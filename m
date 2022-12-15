Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE52C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 22:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1C1010E588;
	Thu, 15 Dec 2022 22:11:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44FBC10E583
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 22:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEnn4Qv4K9bcGX54PVN+96i3gOmBrh10TxGDxX5qA4BVm2SNzq+MjGwJCndONEToxswnRm2N44glqhjpyct0SJ6kh9UklZx+5LM9Vw4GMea11S5/ca1CjD5i8QSWcVxsxoaXV0qQpjC3b4ROZ6MjDxNBh2LS4emYXDAK1V33JSLvc+hmebajN4RcI7aMcl4898+BJlAJKECYXYcgXtL/lzDN46zhF3Hsy3Vv/KuYD2+XmN4rvjbf2gmwrnOohZAM0Qs/wgNeQgo9mBiwVd/tzlZPhSwxUMEx6CodJmJ7f5JUxkOJfcT/qVkdea38zVPDqLATEFbL7/WnwIZeWA/iIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iANBzLWKsMboUQxqodVlPP3/qMKOID9bcIHybfjbig8=;
 b=QOgP3ML8E2ZpXFcFCV+zekMdB+No/AnVqAdg5176GAk1ESrP/Vv+WMy94ZEHNoZoukaH73zz+F5glZX6IHqBLo9lyyn76LL4j9S50XvlkWY2Ms9hDyfD89WWq2BNBT0ujFGIlq2OuGzsLYSwdCsDWqL/ZeqhdhROs68ZdmwRni/4HrPxH16P/WkhCMOUeOu3tODJTONqt9shEqkrTQaop/4SFJUscU18dkoqK1bNmg+gfroYG/5sUTyy5QyUpY+5Ops0ssoy+SgrxwycW+PH2nClAdp9xvbuTRS+dwMfjFaSQt5O7DZYhxJAsqFNyZioS/ZJpUdWBCxPmgpzSodOdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iANBzLWKsMboUQxqodVlPP3/qMKOID9bcIHybfjbig8=;
 b=m6ZspNDIievbcTAkTgSkzisztoPHPB8870iY++mhEswvEng28KpdwtbsofxPWJ2enNXZV541RTM54tMwpl8Bs/FH52b7jHICVYAQv3OVapUBZ78XaLYNEu6QOrDu4BMUO6eSYms/uo9F0C14Q3I2I64jdTRZPVleZ9YQcZxswo8=
Received: from BN0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:408:e4::30)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 22:11:16 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::8c) by BN0PR02CA0025.outlook.office365.com
 (2603:10b6:408:e4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 22:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.8 via Frontend Transport; Thu, 15 Dec 2022 22:11:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 16:11:14 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amdgpu/gmc11: don't touch gfxhub registers during S0ix
Date: Thu, 15 Dec 2022 17:10:55 -0500
Message-ID: <20221215221059.509565-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215221059.509565-1-alexander.deucher@amd.com>
References: <20221215221059.509565-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|BL1PR12MB5378:EE_
X-MS-Office365-Filtering-Correlation-Id: bca44932-823f-4c35-dd84-08dadee948f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUSkt6DplBCYWnqqn7SezfagnQ5w/GuuOQS7SkLjgv3ncE1ZggkkKHRxYyg75Zjf9Jn3WlXqsrM5+itK/GYQRqqdAZF04psLZ9GCFygmS/KPff/xoyBR0TJ/x15NAbDc7eRuBTthHeNJEbMR5gVE6fkesfpb6WSQltye8KwJAo64/Nww+7L9JKulRbkfr8X4d/j4FGk9hgtRR/wEFIfp5qjaPOJqg1WAf940HG+3PmQEcGg42a/z5upICjRd8jU5sWDAhgnUrJIv6U3ZZJcn5GcgHjxa/g/zWbANNrdeaHOp06hYDfwoSGik/Gbrv8jAtFUUvnfN5SvteNgtRPRXVRwSq70l5bKvgocCDNYLgKpHPc7JgTTpUErH/PwdfFxtOOJ9dKC0PPxL0/9q++eKl5Zm/8rWG+nhlxh2HlBoRDlTXj1+IsowW54BW7uGVaUicCsyRfzVp7zs0qRymu+ITwMKiHhspFPxYD/+IAeHyRh+8EtQwE5S8eP4TSxyoK1Dkck19Ko24BvAhpsi+nOaUsFUfu9xTCRVbf3lo5YInNXkK6X5R+R1O3/AXLlTyYVDy+ql6bmpYTD9HRRKvCpXTb6ZcL1SCZt1zfsHDGeuRCe17tMPHluT2SoQL/UYT7cGemvMtvjtFbIJzyOpT3mu5zzDtV51d9ABOp89zaM9UPoc9PYS9zhJayjBfceBD3+rzeFwzbfbCQGu9Xh0iYIHrwZfd3ca7K7Vn+JkGU7yOxeElHmuJ1XqQm8w6rfUtW7i
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(36756003)(82310400005)(40460700003)(2906002)(8676002)(70586007)(26005)(16526019)(40480700001)(478600001)(4326008)(70206006)(336012)(2616005)(1076003)(41300700001)(36860700001)(8936002)(83380400001)(5660300002)(186003)(426003)(47076005)(6666004)(86362001)(316002)(6916009)(7696005)(82740400003)(81166007)(356005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 22:11:15.8696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca44932-823f-4c35-dd84-08dadee948f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gfxhub registers are part of gfx IP and should not need to be
changed.  Doing so without disabling gfxoff can hang the gfx IP.

v2: add comments explaining why we can skip the interrupt
    control for S0i3

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 4326078689cd..5e0018fe7e7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -64,13 +64,25 @@ gmc_v11_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
 		/* MM HUB */
 		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB_0, false);
 		/* GFX HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, false);
+		/* This works because this interrupt is only
+		 * enabled at init/resume and disabled in
+		 * fini/suspend, so the overall state doesn't
+		 * change over the course of suspend/resume.
+		 */
+		if (!adev->in_s0ix)
+			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, false);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
 		/* MM HUB */
 		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB_0, true);
 		/* GFX HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, true);
+		/* This works because this interrupt is only
+		 * enabled at init/resume and disabled in
+		 * fini/suspend, so the overall state doesn't
+		 * change over the course of suspend/resume.
+		 */
+		if (!adev->in_s0ix)
+			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB_0, true);
 		break;
 	default:
 		break;
-- 
2.38.1

