Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907E1C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 02:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF9560C3F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 02:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5AF9560C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF73C6F3A0;
	Fri, 30 Jul 2021 02:41:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A68DD6F3A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 02:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqzV64MRQ1AOuJGasvJcRW1Gi3ytC0NaAaUC8TbzqMDIAtZPAog90ZRRaLShtQk9rPCtTO1AP+2EVBLfY6NfRAPO6xB73u7c2s6quf8vh0G1Oud1Rzva5xVFpli1PYTnDcxLl5W9jtWeDxX5kV+3ZAxppE9+doZ9aO4XSSqX846UyKe/gj270h79Z/x/sVj6Ak9dLYPrZMhQHG20+64qf2E0EHARxqcVkdcv+h5tn3YHkB9ouWwtAWLEOIxKgqm4R6SCN5c2Wy/7NpEKfDY+MLx9kreqbhBtqI0ObaCBHesKIOC8B4u50TD+sjPy9CHuQiml8iAgrjwyt+cOehoc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bjwpOmsk1XRngq7Z7nFcaumDJd/2QWulCC4Q2E2O6g=;
 b=d07KcUExzokrrlshGbp0fYkpqlyi6j3Htdpve1rWcGMpIwPZr+B/RmLf4MNwuIAFGqnSTD0m4uZrMKnFe/LysTwqRl6pKXEO/unNc+WhHfvp5qGgcTQWqI9jVvDDWqYLYTwxdxQ5IKX608mAJtPrILdZOcAp2wOoQ1jhlG3BxZZRnh6fyWMtUobDuI3n6IsBN1LxMSqdA7BRzSM6X8M7QERQBCz7AOuvRDtVCS1Cqu3ER6BlvVKwiXmC2Dzm3E3S9MfVW7SYU8Z3jD5m6iFAxteY8jYH0Qg+82EGibZzsEP+3/GIhlccNAzpTwUOiQkH4UwoHWr/nlck9gU+18TYPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bjwpOmsk1XRngq7Z7nFcaumDJd/2QWulCC4Q2E2O6g=;
 b=Xx6k1XopHft/lR5CFMQlpx3U+rnzi7V+Wus0KDzdA9IjDrM0Pb1Wn9oda1g/MoHpMiVARhQe66dialNO4lYUmZzEC5MC1PXuRfJPNCXgtBW5rOM0JaysV054XXX5EPiiASJ0AA3E/JgT2WTOUAPPaCWHpcVbMX8abldpzJPRoT0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB2638.namprd12.prod.outlook.com (2603:10b6:805:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Fri, 30 Jul
 2021 02:41:12 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861%7]) with mapi id 15.20.4373.025; Fri, 30 Jul 2021
 02:41:12 +0000
From: Mario Limonciello <mario.limonciello@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: Convert SMU version to decimal in debugfs
Date: Thu, 29 Jul 2021 21:40:49 -0500
Message-Id: <20210730024050.248-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730024050.248-1-mario.limonciello@amd.com>
References: <20210730024050.248-1-mario.limonciello@amd.com>
X-ClientProxiedBy: BN6PR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:404:8e::15) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by
 BN6PR21CA0005.namprd21.prod.outlook.com (2603:10b6:404:8e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.0 via Frontend Transport; Fri, 30 Jul 2021 02:41:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09b30677-0e8b-41e9-6a27-08d953037e3d
X-MS-TrafficTypeDiagnostic: SN6PR12MB2638:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB263857E1193A1E70872EA13DE2EC9@SN6PR12MB2638.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1GQgddDq7ZLgRwhBSuXuCyEo9E4TZF3V+K9wT4gTmumdwUO+aHLnJsm96mHGIOK6sDCmiozq1XSD8cP04wlTWIX7aGatdr0MK8fcOUWdEmV/NPmK7y9Y44OJnaGqc6ktdg50VfIAyT48gt9oEq2yKlupuF4lv1WSp0+WEVVk0t81+6xkN21ipEotlyx9Hm0dkRh0Fxgc+RnC1+i5+Az+m1yUom7A8GhtJWVYY1IXV7wnrLbSXjVOTPGIQcNZenA6JKAZ0V8thvfGCxoiCBcz2SBVL8L+M4xhBv1j3fi0RqmlcVd6MJ51UBwHlfspJeqiO/o3RzJn4UN8ENIaabQD9msM/tQg2Fl8QNSNYJNTGUTruHROaqGr+XikrsWR8eLF6Bd0AillzkfB4L/suyR2V79+aTUXKeFB4KFEY5mrw1DId162Cf8bvAiP6/piscxKseIShTLlG5wga389zWUv+HdYsc4UawVhR8QyBmkpY1m84hDdKgRH8LHnVxnxrVYAiXKSbEHfbVP0AGYyYPBLf6+82co0XbjMmTxGCtpAjOjLOhGbiJU/f1+EyuBfT41dzEBMvgRv4Af3fYX41lJTMQCZ9WN4ZvMhCvl1to0OrTpDxYUxUH6kZn9sgBwy7A6tJEFgpnhwXIvesgy/v4KKnsdwefK1gRgR6SRelYGgL/duayaSg9V82jjlffKkIyygXBHqnxOpI/PGGIRoOYmOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(2906002)(83380400001)(6486002)(8676002)(478600001)(8936002)(52116002)(38350700002)(5660300002)(7696005)(86362001)(38100700002)(316002)(4326008)(1076003)(44832011)(66556008)(6666004)(36756003)(186003)(66476007)(66946007)(26005)(956004)(2616005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uFCTeMwnflTkAqMqj74tNx0euH76lR1MFr7nMjXm2kDRquEcvfUNEV9dkqG+?=
 =?us-ascii?Q?K+0+fjpFUZ4iT/1VvR4fFv/gqvxUN2fTYpDXWCLnHShUutuksuK5xXDIPk8D?=
 =?us-ascii?Q?sSESsEhskSGOCiGvQYRcYQtgAmQ1tfdfIMGCt1U0vyr7+aYl7qZs10u07iCm?=
 =?us-ascii?Q?2Wras/ZMdGJc/Ie56YlYhP9+qcJjg4DL3Sn/VVHOH61S73LqnmaJgaYwZ4NW?=
 =?us-ascii?Q?ZpzKJlr5clklUwZUa9E1Se4bCB7y5e8n9jqMqI+D9s8ojU3c6EOQHuaALV59?=
 =?us-ascii?Q?iFjMO6P1FPTUPdFF9sdghX6lN9XfVZfIzFBvMgwariS80qaM5iwdhM12rA41?=
 =?us-ascii?Q?mVobwjZBLka+NrGXaeOd4divxcG1rxf5CNBhs3hQI3oDlwDCtguWMNN0UoFN?=
 =?us-ascii?Q?FK8GV5z3Ws7N2xX5UDiusG9oYWZlGLD7ULuFGiYjWRM5/lRpy+2m8Uu7PM7V?=
 =?us-ascii?Q?aMovojBJuCB2P5hRV6wVqvTAxm3i/GRCVBKNzm2JjSgbZLgSxQqCaQr7mpCw?=
 =?us-ascii?Q?T1HhNwkTrsreQIx1eonuv9TBjm1TZpBQbfbESsyD7qyvJ6Lz/dfvoALAvROj?=
 =?us-ascii?Q?JlWDDTgYDANcu6PfQaYchTk+voK17/0/R/XHmZdu7EIb7QbSSphGtWbxeLzT?=
 =?us-ascii?Q?R8ibyJOqM6oxv764W5pLXEpNd2JgQtTx+cOuePS60Gj8Gvxi2TTgVaXB/ZT2?=
 =?us-ascii?Q?8LMPvHF59fuC8xtS4kGQi/7+cBf1hyHgU7kkAFytBoBpiit3K9pHNdq1Je8Q?=
 =?us-ascii?Q?sZu9TQeHDt04polMmq12wGDmlK1gyK1ppfVxAJx5zYEyH6/Vmd9uPftH9TWk?=
 =?us-ascii?Q?bJJm2dBAlyYZsyjhfOKBbWlHC8unTRwwyQ3dGuHqu0mXwrgTQ3YJtm5R8hlN?=
 =?us-ascii?Q?W9UmO822ZG3SHSqlnUC9KJoNgLpx595GC2SD98BUjQg/rY99F71dqYulvPYC?=
 =?us-ascii?Q?76NIpGrTD77k28y8FyfiA7uAWer2lVthT3nR0vMdsm3trRIEOhi09XtTesxI?=
 =?us-ascii?Q?DmpsgZ5GWWLqpsqgrB6phCaqtjH27Z9Uwwbl2Y1nJ+dRJKO2AhNQcMdskd7M?=
 =?us-ascii?Q?v6yDS+Owyfq8CWUV2lIPhKNZ9tAUnYnXJsvGNesRMmjsZNhEpmb8/MKtdhSN?=
 =?us-ascii?Q?qA3GEy3z147v+ZGj09LnLsDd+OTENk1q0sjssMeNJPgGo4nrJwX/z9fCfXAC?=
 =?us-ascii?Q?T4oJ1Zl1JUBzauEXl9u4sExlxRFoNvr2dnrqnUzNHHi4mdLkSBrFOfhD5VEd?=
 =?us-ascii?Q?O0mv/Nysb536VtpC2aXvIwq6PDNWGaTezlHU6iXdcqGcYMxfpu9o+tDLCz3o?=
 =?us-ascii?Q?OY8UkylrAAzFH/5L04+SWl/g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b30677-0e8b-41e9-6a27-08d953037e3d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 02:41:11.9399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JErtObNbU7qsRhNPD+Kf0aYgR1iyExrXx3ri9l+4uFE7zUN5BiTemYkglUz3T9CSjtDpkA0kisPbcSx1ElcmPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2638
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is more useful when talking to the SMU team to have the information
in this format, save one less step to manually do it.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 20b049ad61c1..bcdefe1157ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1416,6 +1416,8 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 	struct drm_amdgpu_info_firmware fw_info;
 	struct drm_amdgpu_query_fw query_fw;
 	struct atom_context *ctx = adev->mode_info.atom_context;
+	uint8_t smu_minor, smu_debug;
+	uint16_t smu_major;
 	int ret, i;
 
 	static const char *ta_fw_name[TA_FW_TYPE_MAX_INDEX] = {
@@ -1561,8 +1563,11 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
 	if (ret)
 		return ret;
-	seq_printf(m, "SMC feature version: %u, firmware version: 0x%08x\n",
-		   fw_info.feature, fw_info.ver);
+	smu_major = (fw_info.ver >> 16) & 0xffff;
+	smu_minor = (fw_info.ver >> 8) & 0xff;
+	smu_debug = (fw_info.ver >> 0) & 0xff;
+	seq_printf(m, "SMC feature version: %u, firmware version: 0x%08x (%d.%d.%d)\n",
+		   fw_info.feature, fw_info.ver, smu_major, smu_minor, smu_debug);
 
 	/* SDMA */
 	query_fw.fw_type = AMDGPU_INFO_FW_SDMA;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
