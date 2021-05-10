Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084BDC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 02:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8491613DB
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 02:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8491613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102436E323;
	Mon, 10 May 2021 02:30:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06D136E09C
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 02:30:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFkvsi8gF0xDQ+P4PicSVw3uwVIbfvzjdbGbIpeCCVziDcgdfuLwCojvo52OJqFwmqj60sEaWuf1I9JqXUPSjHSKgsFGzAMFT7pvMaBh8/EcQueZDnTelc1obEJWUehkGSMVzr3xXnHUUrgBbarbRFTjsxVHlMGhDMSvBx/8tJts6W0Tdp8s0bUPGpJhJTbiOuQ6+Svpjqky2qtrrmtRBCva/LgWQ17teyPELT1K5Lha6yaH9kMoxMx9t21HH6s0g6nEYRhycTDv2+yZMs1ZNkaXGRzotlWGWsGADjoeO5qCzMYy3U6OMOHaN0EOnyamSnRQpFEEXFCb9ZdHwzZAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kavJWokjuQrezjAvJ39qvt1szbSD1htPp6ZyCh4tumc=;
 b=FkagsGuGJSvdIhzk68vFN1GwelzpAO+MvvaOAqzNlmyGgT05+MMcRMFS7O3+wjKd/HcUzu2OD+yNXyZyWOhZpln6o3x7O+iiRPHTa8r9l0RlkLLEWeWcXW5oa33MTrqM4Fp1r+zXYyl/kuwCLWHowKD4AqglP7k0AMPw63WdSjj92Do4Tqk2R7XT/UqBBTFJs95rnpuMb+oe/Bql2KZflWoTe1CRrtDRy05yE3X9HD21iOgDRDVSjSjmTBDlsA+Z7PmuBGoeW/dI+6rw2JmWKA4Am2WijTnj7CJ8T96p4Mq2BUZivZCbYVMjZ0EbBpzPFEHtOt37bMaTWja+C41V/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kavJWokjuQrezjAvJ39qvt1szbSD1htPp6ZyCh4tumc=;
 b=eaXCsbQCUeFDSwsI89IucV6nR6XjJb925pPBbXQP285W4bx504oNG0jvobQUVfMvAvms0geraJUOeuau8NxHXps0LHLD8c19ECMtpaBATQmNHexuXDHCfEL5tT/LkCyHoz82rOuuoEF8pLrzqndvR8EAtqpBCWiFPq8pTyDpfWc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Mon, 10 May 2021 02:30:32 +0000
Received: from DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::b47f:1d34:8daf:7d48]) by DM4PR12MB5214.namprd12.prod.outlook.com
 ([fe80::b47f:1d34:8daf:7d48%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 02:30:31 +0000
From: Zhan Liu <zhan.liu@amd.com>
To: amd-gfx@lists.freedesktop.org,
	zhan.liu@amd.com,
	nikola.cornij@amd.com
Subject: [PATCH] drm/amd/display: Avoid HPD IRQ in GPU reset state
Date: Sun,  9 May 2021 22:30:19 -0400
Message-Id: <20210510023019.647079-1-zhan.liu@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::20) To DM4PR12MB5214.namprd12.prod.outlook.com
 (2603:10b6:5:395::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ubuntu.amd.com (165.204.55.250) by
 YTBPR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Mon, 10 May 2021 02:30:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b90df31-3c4e-4d2b-2841-08d9135b952e
X-MS-TrafficTypeDiagnostic: DM8PR12MB5413:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54136A79229889CE66E27F299E549@DM8PR12MB5413.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mZD8ID3+5dIZfnJpouII6Q/3/pVSMrkDKFaMCEAibO6EAw1kxEzKQq8sPfsNA4FLe5pEZeI40gyGUaUbhem2VuqUF9hqgMJGCQhBR4CUe7vn+rdTHF2MThtY5SL+mvtvyS5Y2Bs2yj8JOW2VNLAypZXEgEYsSpNTtbf76FoPepFcjGbWof5LCM02qf3w8pU6Gg8c7lsdZ/Fb39Oe77h/G3mHg51VtPLGtUmavr4XcOfmdFJjIvvQOGF+kIOGLCStvKDiN3uIsoQ4H8SCiv9niqdcPk7q9pust7FlNNl9CIe9i5+f4z2j7WlOrLf8d+d1qVm2o1Jk8WJ7J24h8kKd99lRXzvyOWkjIhm+FT+PLwFT4Lx5oj34eeXBKFEgtoYxJU8tUlTJuhcUOBiyGhceF13e5W7jiVuvu98uTXAJXtgjCLN29jDQuwH3Xd8oe55UgskgvFHfCd7etRMga3R3DiLer10jbY2QodhtJN3ujBUnvDBdMfghnZqb2y8/U9pgkKrBZtBCTiqQMFsXKetgXhYrefzC5tEdGblDToxrM+FcTiDHS7RvOZ8jggzeY1Z/LRXkz/D/yXNAt5ZoJra35CDW/fiRL1zDUB8glkEFogqthA36ruQLbNOqdabEFhlac+0reU/oS3e9a2xD/liuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5214.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(38350700002)(36756003)(38100700002)(83380400001)(8676002)(44832011)(5660300002)(66476007)(66556008)(6486002)(316002)(2906002)(478600001)(16526019)(2616005)(956004)(86362001)(6636002)(186003)(6666004)(1076003)(8936002)(66946007)(52116002)(26005)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?h7kQMc89LiGcj/o0aGX81g/K5wk0+Ee25cwEADvizeMfQtWwZaJ0KX4+Ul26?=
 =?us-ascii?Q?BUzI18h5HHRFaRZOkghaoEy7QEPnUlw0gQoTsohtebHIw02SR//ieFSD8aYM?=
 =?us-ascii?Q?bDoKzwAOpmlfF7ov2OzQUOvi2yN1qmgsVgOLOhoRfD5XLGuAHSNvvrLlxGeI?=
 =?us-ascii?Q?4bCIpHZr29to4JDi/2fSXO8sy7PWq1UoAvpncATRWhaOiUOJGoUoTynV2omE?=
 =?us-ascii?Q?nLwEbZh5RTByBYVFBLmsrYjIIRnBPEp47Et5MNQdOo6RphMJO18UDtybkBY1?=
 =?us-ascii?Q?/LmijlHuG3B2n0jW7np1rc1mAovkSmdjofg3GY+V/ie2SppVic/74GlI80r+?=
 =?us-ascii?Q?mwRj2yI67HfKRq9rYyxVjLHl24wraMxsXbJDsm27P4MxXtX5uz+mWQnBv8TI?=
 =?us-ascii?Q?q9HkEbxsoQaqcv/gx64V3JAbBsDUcx4CBW6V7a3bp/aNkZQ5Ey8icrfkBu2D?=
 =?us-ascii?Q?E3PVz1MTIQfHMQbE1vHB6HxHdhUj+Yg9ZU/klwDPFSPtOA+ZRY1pPfJRqySb?=
 =?us-ascii?Q?tZ6wFD1VjGt+nt71ViE4ujz1zitFSk3WJUnIW02x/8o4yewl1uY+dW4kaMSG?=
 =?us-ascii?Q?oCgw9HEChys9d9z7pYeYduP9aN7L0m+eoQ/CP/KF/3OrSFZHqr5ZzHb1oEFr?=
 =?us-ascii?Q?pjI/dNqtH7FyKgn3vAihxih4Ud7yEHsLVUmXo7iqLC6WOJq5GkJIqer6PMTA?=
 =?us-ascii?Q?SUEl0IJNEpOvRFvMNKu/GohH81mOQCukWz/EK6bSFIOm3r6V6PmzhvEGLGQw?=
 =?us-ascii?Q?SUE+WUiC0LJdUE++Crt7bGKcWRqrW3GpcbE35yCbC4mTwurl2bS3qdDWQSlx?=
 =?us-ascii?Q?f17eiaaLa8t0ohBvhaQ1QoqVKU/dq8L7/JIDREgEfhPcR3njbIGsDi8EsHf1?=
 =?us-ascii?Q?tq66MtTE8mtccpjYts0m+zKJJpDJGd/OdXUfzPnJT6OkyoWgtCmjBi71celc?=
 =?us-ascii?Q?7/XWu6HDWPlp4CM1F4zWd+fq8K7mCRCu7/Iv60Ef/b29MfRywFntc1nUj/4Q?=
 =?us-ascii?Q?FxOJGmsPQ/hmb+MeOO7i/p5I7KG5dbzKG2+OMtrKNlp6WDD3u9HPWxXRKf7x?=
 =?us-ascii?Q?RQ7w7EVz1X6pkHj8t//X8vXx2mLIj7qHUwsH59CXGwKHXB5x0XfOfCrI1lg5?=
 =?us-ascii?Q?NHD3QcqvAlwNRrgoDEqR4c/2pPRBycKybg4L9US5btp7g3mpbPOQwYoMrG2n?=
 =?us-ascii?Q?Ug41+cSmDyOFjXBwBgWAj7to+NIIjZoEl/61JAfGv5axU7eCPP7z4a85JukI?=
 =?us-ascii?Q?QoZP41jR6/fKbiP9CJBAyqoeRG4Tq9C+MQZRf+hge2jESPkvdWAZoLpSCwiX?=
 =?us-ascii?Q?GY8u720SCR4MXde2arBnPkGS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b90df31-3c4e-4d2b-2841-08d9135b952e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 02:30:31.7598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlEIl4fuYeFIjK7FSK8B0Js77C1zojtTfKnt8QNDnld8OqSCSmRPl+4sIfNINwS1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
If GPU is in reset state, force enabling link will cause
unexpected behaviour.

[How]
Avoid handling HPD IRQ when GPU is in reset state.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
Change-Id: I29d80501e44096068e98b5d5984e63822dfcef82
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cc048c348a92..58b59152a8be 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2769,15 +2769,15 @@ static void handle_hpd_rx_irq(void *param)
 		}
 	}
 
-	if (!amdgpu_in_reset(adev))
+	if (!amdgpu_in_reset(adev)) {
 		mutex_lock(&adev->dm.dc_lock);
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 	result = dc_link_handle_hpd_rx_irq(dc_link, &hpd_irq_data, NULL);
 #else
 	result = dc_link_handle_hpd_rx_irq(dc_link, NULL, NULL);
 #endif
-	if (!amdgpu_in_reset(adev))
 		mutex_unlock(&adev->dm.dc_lock);
+	}
 
 out:
 	if (result && !is_mst_root_connector) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
