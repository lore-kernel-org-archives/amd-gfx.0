Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF1EC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931C5206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lE0ibcdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931C5206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C8B06E97C;
	Fri, 16 Oct 2020 03:28:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 235486EA83
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:28:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aw4mXOED/43M73447lpowpwnXaJA/qqBG+4DkLlkWQSJh1T8S7uIChMtBgcG2GhJG9Hd3XMfb9kz73e/ms7mjA8EkOwrl0EBWDq/Pme0/Vy/VscQDbEJyCcZ8oM0w5t/o9ktHEtJN0VkufUxYiOcfziPqhjme5gg4PLN34Brk84bSHU+WJigEHW5Hl3xMfXf47Tj3q4Cryr2kn4oWDyY26rasKxCHXsByGuOvyhwOxjjN+cwLbNxZlsulnFOQ1vX2CSglewIE466z2T+Zyz/2l8dEweImgY4po9BcYh6KUHB27vM6gHzDcziCTYTzZhxvTrggub3f7TgAmj0LTbwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ/KtXH4Kd7pK2kmIoqFbAXLbx4zhdRziEsSO2eGMsE=;
 b=j7MhyC6YMYKNrR22QdTdU1fuCXlLmo/1kGntk+5z7fv1FSoWJ6CMX8IEda7QjAimqk63GN/6goyLl5HsNjf6/TO0srKHCfk5ntcEBL//HjwENImfdNh/dZOy0jA/PJmnvweZJPKZv7GnaXdRHu4bKj7E5xKy/0jW9JIDfIC/R7jk96w1H8S39IztMzpAMCL1Vt2vtTurYKriqBgsGZgiLbkvbnFdTqe/YtkRhVZFgcpBw4jiSXwROz+YwPZY4u5F9+Exo41OC8lJYrVXmZar/xlOBkHQ45ewCSn4BAV6Ve/w85M3Z+/YX2ks3WPrqGy3lVh0eyTbRHz2JwImPMhCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ/KtXH4Kd7pK2kmIoqFbAXLbx4zhdRziEsSO2eGMsE=;
 b=lE0ibcdLTDX/hNWcZAr8hss3wBXrUZDdHne6RuD2bR2jRRlU8L8XXzvmcLg1zTJccRfUZukJ75cgxoCKTxf1E1kyrT9ykYRg9PNGiQkGXkl9k2G9xWl2J5b4O3rnmEU5oudeZG0hS6si5XHX1lt3QZPdQlF+r1/6k9Bb1XQM4kQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:28:16 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:28:16 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 25/40] drm/amd/pm: correct avfs fuse settings
Date: Fri, 16 Oct 2020 11:26:37 +0800
Message-Id: <20201016032652.507-26-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:28:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c603748-487c-4c29-b37d-08d871838554
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB135418A37BCCAF6F5CE80120E4030@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:55;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EzM5JxqOra1JiAbVF+mB8UYmannf0pWiJxXFXi+FUEn8fV+V7vzVbIr29nQmjdXVs+rRqfrUecoFbp8vyKS3iWci5GT5BavXy06PZ+m0vWSquvs201yTKR96fCjXRi8rFz9ovOnWaW2Tk5susVqT7Vp8HNQJkyXUTdeRQ+lRufX292fvXyEV/6e/1gngi1j1uuvtBla7onkU9uWr0UZrJjmfFsTB8b6cQja0YXN9Pdy6o3PkUf70NKP4TgUDH/iYZ17zu+FPQu+Jt57LLkhRDBclLuw/hdfiW7ZD3TlV6YQ6OocmHud6cQST6oqDpTICFgLsQPO+02JHmHFxnhc2a3Eo6+9olRw3wU7qZc2byCIqHA1twU6EzTZWlbjclKvL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(66476007)(66946007)(83380400001)(1076003)(8676002)(6486002)(5660300002)(8936002)(66556008)(6916009)(86362001)(52116002)(36756003)(7696005)(4326008)(2616005)(34490700002)(478600001)(316002)(6666004)(44832011)(16526019)(186003)(54906003)(2906002)(26005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mJp8y5QtJQS9E89RsbIPBj0UbZGuN0UQAsJR1y3zxFSA2k7w6njcew9LlMYKEdM5Yw/KCsz3gELpNRJ7RkwXShW41af2uUDg89I0RghykoulHrMep6o1/bW6NJAXN88FeU8vBRxoR2J9mxhI/LpcVRPY/p8hBpBlseytn40L/LCaahQ5bDI5jXvbnExsDP3JY15kprHSxViR2hkimdxTJdEv/2AFp86+7Irj9iBZWkugJ2VDLzfUoSKCroD12g1JtdKFIo0srpyjSCZPfqOkzGjH+Tr89SagM8RQQ9G0hx87xwgIfR4cU7DeVrIYh0l0uU9tlKXbTNYF2jXcQAPMZjjAp70bjlKgdNBH8YIWOraVDrZrmk5kR8rA0z8raIiorF24tNeYL9unDhKspH7CmFV5njBck2PJOrx2m7HTCfJ/J0ajFr5HHr21VdNQy6zF0rryY7WAlrkugnOcnshEYMdR7QOYs/u8o+IrUqRleOUBUVbexliPkbBZzyPRt417FJA4P/BjxaAEfCqG1DLbHOxYvUdBkglHQ/wC2P8YZITCrMxC1JI4fmfdtGc4uOK+AnZx6ZHNfTmq6tl3d1mErPR14xlaM3xgc1p6nax+YFsC5fvgvPFvmqbBfRC7LfOlc8wLEY8wd6mRnQL/R3Hwmg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c603748-487c-4c29-b37d-08d871838554
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:28:16.6229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITqc8jesO73K8uaBqzuaIFpBYX5ia05pLAUdBxRR/rZOFMTfPfG6EuGCPvH9gbPu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct Polaris10 avfs fuse setting.

Change-Id: Ia6db6bb1d67cbf5355fcbd07ccd5e3fb6bbd2226
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pm/powerplay/smumgr/polaris10_smumgr.c    | 55 ++++++++-----------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index 6afbd138f4ea..46c82bfa793c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -1760,16 +1760,18 @@ static int polaris10_populate_avfs_parameters(struct pp_hwmgr *hwmgr)
 	if (!hwmgr->avfs_supported)
 		return 0;
 
+
+	if (SMU7_VOLTAGE_CONTROL_BY_GPIO == data->voltage_control) {
+		hwmgr->avfs_supported = 0;
+		return 0;
+	}
+
 	result = atomctrl_get_avfs_information(hwmgr, &avfs_params);
 
 	if (0 == result) {
-		if (((adev->pdev->device == 0x67ef) &&
-		     ((adev->pdev->revision == 0xe0) ||
-		      (adev->pdev->revision == 0xe5))) ||
-		    ((adev->pdev->device == 0x67ff) &&
-		     ((adev->pdev->revision == 0xcf) ||
-		      (adev->pdev->revision == 0xef) ||
-		      (adev->pdev->revision == 0xff)))) {
+		if (ASICID_IS_P20(adev->pdev->device, adev->pdev->revision) ||
+		    ((hwmgr->chip_id == CHIP_POLARIS12) && !ASICID_IS_P23(adev->pdev->device, adev->pdev->revision)) ||
+		    ASICID_IS_P21(adev->pdev->device, adev->pdev->revision)) {
 			avfs_params.ucEnableApplyAVFS_CKS_OFF_Voltage = 1;
 			if ((adev->pdev->device == 0x67ef && adev->pdev->revision == 0xe5) ||
 			    (adev->pdev->device == 0x67ff && adev->pdev->revision == 0xef)) {
@@ -1786,32 +1788,21 @@ static int polaris10_populate_avfs_parameters(struct pp_hwmgr *hwmgr)
 					avfs_params.usAVFSGB_FUSE_TABLE_CKSOFF_m2 = 0;
 					avfs_params.ulAVFSGB_FUSE_TABLE_CKSOFF_b  = 0x23;
 				}
+			} else if (hwmgr->chip_id == CHIP_POLARIS12 && !ASICID_IS_P23(adev->pdev->device, adev->pdev->revision)) {
+				avfs_params.ulGB_VDROOP_TABLE_CKSOFF_a0   = 0xF6B024DD;
+				avfs_params.ulGB_VDROOP_TABLE_CKSOFF_a1   = 0x3005E;
+				avfs_params.ulGB_VDROOP_TABLE_CKSOFF_a2   = 0x18A5F;
+				avfs_params.ulAVFSGB_FUSE_TABLE_CKSOFF_m1 = 0x315;
+				avfs_params.usAVFSGB_FUSE_TABLE_CKSOFF_m2 = 0xFED1;
+				avfs_params.ulAVFSGB_FUSE_TABLE_CKSOFF_b  = 0x3B;
+			} else if (ASICID_IS_P20(adev->pdev->device, adev->pdev->revision)) {
+				avfs_params.ulGB_VDROOP_TABLE_CKSOFF_a0   = 0xF843B66B;
+				avfs_params.ulGB_VDROOP_TABLE_CKSOFF_a1   = 0x59CB5;
+				avfs_params.ulGB_VDROOP_TABLE_CKSOFF_a2   = 0xFFFF287F;
+				avfs_params.ulAVFSGB_FUSE_TABLE_CKSOFF_m1 = 0;
+				avfs_params.usAVFSGB_FUSE_TABLE_CKSOFF_m2 = 0xFF23;
+				avfs_params.ulAVFSGB_FUSE_TABLE_CKSOFF_b  = 0x58;
 			}
-		} else if (hwmgr->chip_id == CHIP_POLARIS12 && !hwmgr->is_kicker) {
-			avfs_params.ucEnableApplyAVFS_CKS_OFF_Voltage = 1;
-			avfs_params.ulGB_VDROOP_TABLE_CKSOFF_a0   = 0xF6B024DD;
-			avfs_params.ulGB_VDROOP_TABLE_CKSOFF_a1   = 0x3005E;
-			avfs_params.ulGB_VDROOP_TABLE_CKSOFF_a2   = 0x18A5F;
-			avfs_params.ulAVFSGB_FUSE_TABLE_CKSOFF_m1 = 0x315;
-			avfs_params.usAVFSGB_FUSE_TABLE_CKSOFF_m2 = 0xFED1;
-			avfs_params.ulAVFSGB_FUSE_TABLE_CKSOFF_b  = 0x3B;
-		} else if (((adev->pdev->device == 0x67df) &&
-			    ((adev->pdev->revision == 0xe0) ||
-			     (adev->pdev->revision == 0xe3) ||
-			     (adev->pdev->revision == 0xe4) ||
-			     (adev->pdev->revision == 0xe5) ||
-			     (adev->pdev->revision == 0xe7) ||
-			     (adev->pdev->revision == 0xef))) ||
-			   ((adev->pdev->device == 0x6fdf) &&
-			    ((adev->pdev->revision == 0xef) ||
-			     (adev->pdev->revision == 0xff)))) {
-			avfs_params.ucEnableApplyAVFS_CKS_OFF_Voltage = 1;
-			avfs_params.ulGB_VDROOP_TABLE_CKSOFF_a0   = 0xF843B66B;
-			avfs_params.ulGB_VDROOP_TABLE_CKSOFF_a1   = 0x59CB5;
-			avfs_params.ulGB_VDROOP_TABLE_CKSOFF_a2   = 0xFFFF287F;
-			avfs_params.ulAVFSGB_FUSE_TABLE_CKSOFF_m1 = 0;
-			avfs_params.usAVFSGB_FUSE_TABLE_CKSOFF_m2 = 0xFF23;
-			avfs_params.ulAVFSGB_FUSE_TABLE_CKSOFF_b  = 0x58;
 		}
 	}
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
