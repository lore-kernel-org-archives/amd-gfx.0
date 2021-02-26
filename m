Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10699C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 04:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C9964EE3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 04:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C9964EE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DE196E8DD;
	Fri, 26 Feb 2021 04:25:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC78D6E8DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 04:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLSBirUtll/3szulJrHzL4zGN9wf2TKUwn/S9FOQCicx6IDo1MXqz5s7ZAjUBbyCFjm37dMP6C02+4xQJd2JX+KmNzijlo4hfTsvrDEPWgfC0ilo0GKk0NULC4zHf7yNyRcWSK9OZv7aIjXpsxH0GyKBONitAYdh7Eos3cCktRLfGaqKKpNbXLrDuGJVrD+iHg1gmgoGuQ8lBJ5AjahtL9HnrrfkansB0AbirB8DpBkNEJq1SowyP7rxiU2aq/GwOyS1lu37EKKXGb0zqfVYHzKpdGvI3SniHbAnCghR7GhTDAsdgRDsA2x/c6mot5M3PIMr87863/RobSDfhnAB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcuQ7jFRGlhPtnSa4yAV7CCtZ0Ymnx7WEyUDRk1ud8I=;
 b=E32oDAI0Qhxal9U5AMbNC4AmvT5Dnht/7USkGhnFzsrK4tF3lN2/pq+oeD+sup2iygsPtRi4xmLsxto7WktOG00TI1ZSzna3ybmYiNsyH1Cbmi5EsAwjcEyfBJghIvQNKgSi96uc5O4bAfFjid0bfJBlVCtRLJs9g4m93cUkJ0LkhiouvLPf0dRLWFPCe3ZFhBLj5vtlJPRZo+Rb+5xH4OJ6eGb6nM2sVpkytYjLdaUcWhCdxvBJc0DLJx5fO9CoBuvUXytb6rjJ4ePXAETb7Fs0CNMFKwXyWnSmjfG6ar0Q7KQkq0H9t7fExmZ936z3EeboiPCRl5zKlEmiITVkLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcuQ7jFRGlhPtnSa4yAV7CCtZ0Ymnx7WEyUDRk1ud8I=;
 b=qCM9ZjfLffKwPQaR9GJRLsZTYENQVGyejDlKG/kmkqxR8BjJA721+gU80HRD4IhoubayP8vMdVWH8U7eRDCi4TP57GPF4A6k+fXEkqWgmudwk5SZRPaEtdoIlEduFBpso+xrS/J8q3Sya5QQB6je0vWLq83mcBqIA35k08cC1bk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2893.namprd12.prod.outlook.com (2603:10b6:208:107::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Fri, 26 Feb
 2021 04:25:06 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 04:25:06 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: remove unused variable in amdgpu_dma_buf_unmap()
Date: Fri, 26 Feb 2021 12:24:47 +0800
Message-Id: <20210226042447.39296-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK0PR01CA0067.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::31) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-ws.amd.com (58.247.170.245) by
 HK0PR01CA0067.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Fri, 26 Feb 2021 04:25:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11dd776e-7c3e-4fc0-1aec-08d8da0e7e4a
X-MS-TrafficTypeDiagnostic: MN2PR12MB2893:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2893D352CE33630E6E15EFB4A29D9@MN2PR12MB2893.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3+aEdZJk9vCI6nnsMbrXH0f0xuxx52LXzF+/fcSk/uPgWp06Mb03k9CzJg6YE21hfB+SZx1AbExuXa6lPKiafyD5C+rkyySLp8lfZeM8RVEdZXqBSNdBjRyWJROgMfkUF0JD1NlVBOmj/9KHec1QDew5+BCDZWGMdBZtvtyMoTrS09X62zL4GWkrp4suDBNrRIpEaYXMqFgOc4ybWTjEt9UQeAiozx2TNLqfQDANWyCNnL/mimkRAVgZX9o4etwk3W0s+DGwVT3+jOX3vuYYuE9XJobDCvixNQCzX4U2HqRzU7JKgN3fuAogDnsQoJxFc15LdTRm48CUtq5UaimfBS9hAQLGxkB5Uil7XMpCo+jFePfXSUC2aQAgHH51t+D0ruqCrHc6e/bUfe0DB5xrS5+YaLkzI9xuB2uKOgcIZzuyHwVbJNjXp0lkl8Hx9mpM2F3BK0e0RqY5NJKlUDp9kDvAJHfOT86MeoYXm4obUUmVmxZm/wfMlcg74ZXbuXl527nKFVGRkwPYCNDS9nDyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(4326008)(16526019)(52116002)(4744005)(6486002)(186003)(36756003)(316002)(1076003)(6916009)(2616005)(86362001)(478600001)(66556008)(66476007)(2906002)(7696005)(5660300002)(8676002)(6666004)(26005)(83380400001)(66946007)(8936002)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dutNv9dV/DqeJ9mdqf+EGW+eBqHXbpm/L+be6A5NxBP/ApioKsUaLlsbm7Ah?=
 =?us-ascii?Q?ySb84oX3dQsluCfA44ZdtXyiF5gyiNUmei7IiGgE6wdOe6dFD+ljtEtXEWiG?=
 =?us-ascii?Q?T+ooe+zsFXBX6UOWWvOD2q4TKUfgP30NqW+ZTh7D45i6XBH/ozRwEpyTBJFA?=
 =?us-ascii?Q?7PTmYX7IF+ebuEEnm7aazBWYZrbvbGjXF7KpC2EdA2EcHZ/5z6ZvLibyC9LM?=
 =?us-ascii?Q?fW/SvEsVKWhyPR3xc5I3XmbSpkzNTvD/GQXMlyIGoGblGps4hoKk+L2CcbJt?=
 =?us-ascii?Q?vAdyYVElpGQGlanJ1HxvP9STHyDoYKtT0W81fpL8GUivuboqixcxgIHmmwrR?=
 =?us-ascii?Q?QPNsAJa5r3DGKBT6LmKeABDFXJe1dYXkZivf7klNBdL/4db1tT1qnErHKZ15?=
 =?us-ascii?Q?wOT6fly4rlLC6S7y96jL0biL44s9xgRKmDy+pqpNKwuYWAqYWol8v0BCd5kg?=
 =?us-ascii?Q?PC3t9LWNQV/udkw4IpkpA5A6LvdAqOMqlcezqmBl9kEtZ2wKc4M9pRbTSznc?=
 =?us-ascii?Q?1ll4/JLimpxHWiVt0wsUSfw8ZA/t/evbzvAzYNq9rCcSLZKBZLudKpHXzjeS?=
 =?us-ascii?Q?/5VnrAoJOdPNSjT+uft3/gyNStoAZEQ9YHzVZ/smpNwqTkOS4YAGYcKbfws7?=
 =?us-ascii?Q?ztzgs9O1egO6tH8MT1wZ5s6W1Er2M0eQoFEtUI6Jli35kj2vPVDFU5XlrB8B?=
 =?us-ascii?Q?Yeh11giPiN9qBBtFeQkaPdpM8CgymumeG+Z4OQKt680z3/LEPeD8DCybltkx?=
 =?us-ascii?Q?vCOolcba5z1U+bj8lciuoZRG/FQLvX5qxOu0uJsfimIl9cePQKCkXhkkDCFG?=
 =?us-ascii?Q?l9dB1RKhHeeo8r5T7GbB1Dd5luJOnCF2PZIgsnbEQ5R++mMZkxxBO1iaQXFW?=
 =?us-ascii?Q?x4fNL6aGEqMoMSWUYGGnSxAWfzzF+de/oyrjac9365kkqz8xiXyit/fZXkzl?=
 =?us-ascii?Q?rcdPWFJIjNlgJjlyhO9hQuB32mdKdX66IBGZFsEdSQRqUHEU5giFjbQlxHtp?=
 =?us-ascii?Q?1fr2DsfiBfb0tCJRpJGGVSAWkn4pBzqKMZzGBLho2wdnfxXwBBz5ab0fMgPP?=
 =?us-ascii?Q?NqAcwxZGcq9J6Gg7DF959rFAu0xwDdnBkDv66+NVZvNEONUSD8wViH/g7uRx?=
 =?us-ascii?Q?cau8rmI75MsJZPr+7CIw6QUJSJ4WHh5MPrPoHAGvfKSna5PlWdMB5mV6Oi/P?=
 =?us-ascii?Q?7I3fbN7qS6UCQG3osmQB2lC/TImrVvJMWpeprDcbcNYA9LyQMrv1Uls7gme4?=
 =?us-ascii?Q?zWGTmh+3YwyOqir1RHr1kue0CllJ8Rt8J2mpQRF4Rm4HElmcz9hgLaNnK7xb?=
 =?us-ascii?Q?SwYc36+lzwiM2pI+toN1JWRG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dd776e-7c3e-4fc0-1aec-08d8da0e7e4a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 04:25:06.0895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrxQPW88t6Wkeqkl3v0jaRD/dZ3Vh4KWpdRUxW7CsZFOj+JXcGT928sge3R7Yr9E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2893
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

clean up unsued variable in amdgpu_dma_buf_unmap().

Fixes:
drm/amdgpu: Remove amdgpu_device arg from free_sgt api

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index e83d73ec0e9d..5ec6556ebf7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -356,10 +356,6 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 				 struct sg_table *sgt,
 				 enum dma_data_direction dir)
 {
-	struct dma_buf *dma_buf = attach->dmabuf;
-	struct drm_gem_object *obj = dma_buf->priv;
-	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
-
 	if (sgt->sgl->page_link) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
