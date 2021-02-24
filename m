Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4F3C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FEA464E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEA464E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDC6E6EB3E;
	Wed, 24 Feb 2021 22:20:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E406EB36
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7Sx9W1NjSGpK7KVKcbsodCMTG5SFH8qptiLgPlwi5NSNMChW5M4zfQinfHU7GM5L36TiNq8B5zsH/O0wWo91bwRIIU0JZBBPiMiKIBe45TgyjioYLBRJenDk5gCiHYDnB6xw9UUimFRjVTtCPX8yBq+MqqHrue7+KX9klcwtfdA2R38zdSy6dgheRHiaf0C+n6N383c8H8Bl0t1lF2oVj6GAUiVJtPmuHyQBjflXscULTLPT6Y6TzLO4Z+Vd8uQlSO8pHwDYrzXTwJ+EwBxPDeF9urrmhp+NT8/DNwcOpcegsTxfT3xZqo9SE5VJ5KBNhhOSTlYguGQn0Lh9e+WAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hONoon09522LAE0W0Y5qwZjOkSMg13YuHXjDxrCeO64=;
 b=BL7+M/1su4WapTBcALN9wfdpoHhbg3KC7++FGCe0/otUoPZzVCkLa++um/OUFwUOaA3IAwm6MDEmCeOcFDGbKA4Wz55ozZcBeFuBiAlZLyk7iPAul1ZpTKTHimB2uqvaeWh43So/Kth4vl2qBIhbuKqRwe9WIHDaas89u0IdWwHKFA2/YsLlC6ENjZsH8AyhnyAC4ZaATbKQ/fu5+u5mrkYJxuwphTHBeJ732aj1YIBgmmyL8hY1H8I2DMY9zJVHmy17zNwueYNEW/EZhEV4CkL1SmcQBCClSRLWqh/7DG5CtAcFWDnudAUGhH7CIJtU5d8HKvSyhSKjGx9e5ush3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hONoon09522LAE0W0Y5qwZjOkSMg13YuHXjDxrCeO64=;
 b=RCFJSqeBMEObknRBgN0QtX9AjB4oIzzAs4dgccdn0jLrWomFv04HFn4FBJp6xBLpnRLTC/5bbi9R9YSTf7jsApCrcUw3cR2VXij0zE1KP8NaCyQ5Xt6ckBmBQZI+ISopsok+YwgdHdj9C8AE9tZdH4zVNNS1am9u4MEYxjr7mTk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:19 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:19 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 045/159] drm/amdgpu: Fix IH client ID naming table
Date: Wed, 24 Feb 2021 17:17:05 -0500
Message-Id: <20210224221859.3068810-38-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d01504b-c32a-4bb1-def3-08d8d9124dbd
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175203C3926A96255A3AA63F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Ku1x+fJYrN6t0fnQVxJvvdqgOJ1/HOJU0nZywKLDo2xw4tnVstW8n85MfWFf6QF/Hy5KH6ndXpk/5JBbL/XBIGohJZp2pShFE34sIZjBgrR5siqgtlodYSbn3abWqOHuxtWrENzJD4ca+OWFfpXf1ndQZAv5gz14oQdBJb4/ohQW91kKi6jxe1KoX0NqiLEhyZhbjB4+1mwGeo2fAZx0J1AGAd9pQG4dYeGRZUV2/Ga7eGlg5+2o55dL4i35+Dd+0cNoiVq06C9Sm9fUSVnB0xvaVe7z7vKlrQqcmQN9fkHBlgzKfPGCIJYeiYzVYZj7lMbjYKszTB5fL6xMXcsYL1uyzIxRgjNseaUJGLUu9sdXO9CzRxrFU0gUex/tjcX9qkef1Uy/Qupo+dCIrs7ZzmXZJNDbGJ2Z9tKoe1FhYUC2WdeSAaEyXvMWOMcQRadZDgRRqgeiN46kxv2+cCCLUO39hma5Qrv9va0Q7hOLBmIrMNicvFuIz6A5TLwIEaCGkfKLZ9NX+/BXBAGuk4N+SYdZeGFl6aIrboJKZWYu8gfxTOUGp1F0uxmK2fq7v16LwyFKwvSqG202fyu8xjwmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4Hhi/y6u4U3zhZSdi4SaJwLWa8fFo6Ad8Gkppr7ymMgidrFTdMvA9XMT7drK?=
 =?us-ascii?Q?hHU8CpDtO9b8LxBV2uQcfjIb44WoB1RUsfaBSEkAZwxx7eqKu+6o4XK7u+BV?=
 =?us-ascii?Q?DObemY3Isd807fA3ZgDS8moZiUHtQRFln913hwjosQA8oLEbYsDV5NaM+fy7?=
 =?us-ascii?Q?9QfXzGhZxXyugljyfMXFiXKlWGUJOBBYEei5ltMjoqRHoP3KyVTL7HtTCv5n?=
 =?us-ascii?Q?c1m6aZLeGChI7h2kINzDY9AsFgFbiRmXCRF7sR3yHuPHZegyvxOU1XlOft/W?=
 =?us-ascii?Q?e7qtui4w76swCL4MBxaQhD7cYjIvHP3M4vSQCp9swvKzGY/xXOYbGE6po97u?=
 =?us-ascii?Q?UuBVCRmUpFtXbXFfJ0vg2M0w11P9KVPlxUD0pTyM2C/ZgvxOC99A3k+s4ctd?=
 =?us-ascii?Q?0VHvllYBlmVyS1JQ6/z3mECFET5H15Zj+HGMhcEt0E2LBhjPudyIqpUo8ZXA?=
 =?us-ascii?Q?ucxSqik3F05M4Ia/oaBq22r9yIGJS6c7XcBvlBe0/O2+g+swkt84yaHLuteD?=
 =?us-ascii?Q?kZzZhBlp8AjEgNh+cCsWClBYMTAlv9JlvtyVKA/lwELKJ7gGKco84Gi3QbM6?=
 =?us-ascii?Q?6itwVtfFEV688m3u+1NF9H2Md9CWaHJeWDG9ZarRb1C1K44JB2pUS6qm9qsG?=
 =?us-ascii?Q?30V6riv0PZ5rCvJHlOt2d6yFedEg62M3RUIKd4cZ/3ABarK7WrefFzOvAeMR?=
 =?us-ascii?Q?6TeuWaXmijOu2XkMOL0+cZPWN+XCl7ZX488CMm2G2D0OxYDqSKdL47IPC4b0?=
 =?us-ascii?Q?aGEARhVknDyG4Tx+W7MYMqa2eySzC5GDWbRpYsrwYS37Z8DmrCSZEcV6qZgo?=
 =?us-ascii?Q?M/AGgbKrKBD0aXYfN9/oUODK0kHB/Mpp9uE1qKjK79DIwWlvT4SYJiEBIZ+r?=
 =?us-ascii?Q?f3R7gwPMpHWwtdXFARR5+KI0E4kbNwf43p9ipIdBaBF1napht5NqAE3b269r?=
 =?us-ascii?Q?25kzCCNbhXN7f429mYyb1YZ1e8OKENDSCtflz0A+87WzHmzJwK7cSRzjwkxj?=
 =?us-ascii?Q?mf6KaTHtP5VQxucu29AsnX774kbv1Gck9EGBvJHklVxJUBcQ1RKyblrxyl3w?=
 =?us-ascii?Q?mjwxNclGetBryoXazSHeupAeWefQMlM6KA36K/DoQx8aj38WSOL/9sTbH0qI?=
 =?us-ascii?Q?N/4OD3Hg8IV9EE0OzdbV84EQaKYcK/OulRUzHpyBJzOaMXmQRgOmTJgdTRmy?=
 =?us-ascii?Q?8PGE45b8Q9HXtWK2jCMvjerY/k1ARFz0SaW1AIHN/TG9msRjIL982EQCMCNL?=
 =?us-ascii?Q?5vJdXldyVgg0mAqyqZNAI806ZwCgjt1LadtuBAq0ZOJQ1hmv9SmM3LXQ7NGz?=
 =?us-ascii?Q?eLreAVYT0sml8i6RYfTAALO1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d01504b-c32a-4bb1-def3-08d8d9124dbd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:51.1874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGnM7JHCYWRnPZCeZwDiL2Qfz5/bAB4ZoHFXWW6STMRkBIGw2lozC4uPZw/B0AaPzf2gw0uTbN/wRg2sQF6W6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Oak Zeng <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

Client ID 26 is reserved. Add it to the table.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c         | 1 +
 drivers/gpu/drm/amd/include/soc15_ih_clientid.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index eea2bbbbb3df..9ab8d7db19f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -92,6 +92,7 @@ const char *soc15_ih_clientid_name[] = {
 	"DF",
 	"SDMA7 or VCE1",
 	"PWR",
+	"reserved",
 	"UTCL2",
 	"EA",
 	"UTCL2LOG",
diff --git a/drivers/gpu/drm/amd/include/soc15_ih_clientid.h b/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
index e3088c10bfff..1ace2cff0883 100644
--- a/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
+++ b/drivers/gpu/drm/amd/include/soc15_ih_clientid.h
@@ -56,6 +56,7 @@ enum soc15_ih_clientid {
 	SOC15_IH_CLIENTID_DF		= 0x17,
 	SOC15_IH_CLIENTID_VCE1		= 0x18,
 	SOC15_IH_CLIENTID_PWR		= 0x19,
+	SOC15_IH_CLIENTID_RESERVED	= 0x1a,
 	SOC15_IH_CLIENTID_UTCL2		= 0x1b,
 	SOC15_IH_CLIENTID_EA		= 0x1c,
 	SOC15_IH_CLIENTID_UTCL2LOG	= 0x1d,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
