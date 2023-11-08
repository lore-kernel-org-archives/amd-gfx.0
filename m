Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6BEC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 17:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0123310E7FE;
	Wed,  8 Nov 2023 17:26:08 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567BD10E7FE
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 17:26:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcQD3Nf2rwxPUUslD+qEj11IymYakrVuuNCx47qZVAYQ00i+LWOq12mSAGBrI7pYwCeW8pldw6ZEjA3cocA01BSAubkvBiwpCEuQz7NRnS28lwEZj6F8/7xqqeROf1DAUby8Z4ztAC+3meVoqfQnBsei1BSRRV4Kh3Scxu3UztRXbNl3yMdLELFo4h0elBzTiXeRBCN34z4Xm1MS6YkND7MHr1AA0DfiZzeeIMBf8qUidBNfElY/W/mdECW9+94Wc55s1rWSHQWalwAb7MWpBGrqiv/+He45RTHdfK1OnD27EIWMiKwqWF7a1rQEl0oPTncepcpSP6rsQS4k27ihSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IURk7ldBKwzezgUy/agJJLWOuoiWcPyBFlDjVPc20cU=;
 b=IqYPei/z7lc1hcwQft3jBdsxCJ+Izhh++rQSXgMiphiRzs65PXuUc/nLmUqYD8ojNUB4m6P1fKfBuzonhn1Sm5mauLdhTFJERRzi4+T57qlaRDGCTShHwqPCFyEWkvF1towPnG4UOCyGcQf73e33rwsU6eloKsu1mOpFF7NK+0RRsFA8rEvAAzXdrf60KpDHvyqt2BAdO3n8E5IjHVcLffHonJuTyc4fkALrOUHgl3sKACir0F8IvDiOEfnQuQ8fXZJ+z5rkDJyh/RJsDw/3e7mWzRiVCa9f+GhNyXY+TBLwmOCL2O9Fdyu146HUhBrxEfJ5SFNWbwZaDJQcN/eL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IURk7ldBKwzezgUy/agJJLWOuoiWcPyBFlDjVPc20cU=;
 b=Ff8/B++Q3oRXUvzmPFb62aIsMp3nf+FZDiLvWbciDc7kqepBa3DNZ6bTrlVHVRipPHJKoF9mNLL+YbKxILMipaWlP7Y/8f7n/zd191F15cKi8I9vqW2Ho40RB75xg01AxisMEg4jzfc42xhc4NpcSY3XwPSv5rrUSw/iEmKyWT8=
Received: from CH2PR14CA0048.namprd14.prod.outlook.com (2603:10b6:610:56::28)
 by IA1PR12MB9063.namprd12.prod.outlook.com (2603:10b6:208:3a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 17:26:02 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:610:56:cafe::77) by CH2PR14CA0048.outlook.office365.com
 (2603:10b6:610:56::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 17:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 17:26:01 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 11:25:59 -0600
From: David Yat Sin <David.YatSin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Change extended-scope MTYPE on GC 9.4.3
Date: Wed, 8 Nov 2023 12:25:24 -0500
Message-ID: <20231108172524.2366960-1-David.YatSin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|IA1PR12MB9063:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cae1699-a66a-447f-504c-08dbe07fc7ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSZboMAwjWQgNHUsW1IMyRiZWUE1F94l1W3TfVXpp/QPwZjIkvMupE5fxbiIkvxlZXrqjeWlkOz6E7CXy9HB1rF7m7VeYL767RjHGDm+OG8R6ZvDXsjsrlSsLNQqEn49rZpBz5/f4guXtg5i/oW+4nf4MdYLstq48LIEwIDuKh0nLRTlUg+IFTH9O7AWJkDHPL1n0lgFNcUDMduTPqFgwtZ6dytVUeK2Ql2yDc+XAAgrUKOkoWMe6E5klyB4D/KzzK1dGlAZ4rwvueN61qtFgCLAQQDRH5BJnMqGXblcrUDwrS4mS5pDi3AyyEevqJhpWw5q2tJ2oyr0Va5q1HeaJ0YviSz3LNFkC5S9NcAoPyBkvuyVoggpLdGCtZv/pY8gEwDz6AQ4zprCDJQRHqgW1G7PszMaPGSFgff91OgI01t5BBhUG1Hhy3o4tXQJGFTTF9Qugl27qKd/1QJNLuRB8eqQ8cA51smcba7HulS8Ke9ntYPgoFnVNY4IWiutixIJfodP4I6Db6Lv6BCqPufNzejTCVC/JNRoCuZavlkoie1jQ3md6Pbdu9x/gRnGe2O5GMItpaxoKM7Dfitvmg8I39xo561AA0qok6rCD3OQw2DKS9nIlsYPn2dFSzTz8YSzSLQ4y/2RwlaQCi7oThfycporVew6BEZ7vsDcWsRgsOEEJ1mLEFQSG1/wRHjuXKA0OtT7KmGitHEQPMLZ5rie9HFG1XZbIt3Aeu5oBpCtkS34n61+tSKe8W0JNrQz7b+UZE7/76kn6tf8T4BayY3AJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(46966006)(36840700001)(40470700004)(2906002)(41300700001)(4326008)(8936002)(8676002)(86362001)(5660300002)(40460700003)(6666004)(36756003)(40480700001)(36860700001)(478600001)(81166007)(356005)(7696005)(47076005)(70586007)(70206006)(16526019)(83380400001)(1076003)(26005)(426003)(82740400003)(2616005)(336012)(54906003)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 17:26:01.8368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cae1699-a66a-447f-504c-08dbe07fc7ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9063
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change local memory type to MTYPE_UC on revision id 0

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 8 +++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b66c5f7e1c56..5ecddd08c363 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1176,7 +1176,10 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		if (uncached) {
 			mtype = MTYPE_UC;
 		} else if (ext_coherent) {
-			mtype = is_local ? MTYPE_CC : MTYPE_UC;
+			if (adev->rev_id)
+				mtype = is_local ? MTYPE_CC : MTYPE_UC;
+			else
+				mtype = MTYPE_UC;
 		} else if (adev->flags & AMD_IS_APU) {
 			mtype = is_local ? mtype_local : MTYPE_NC;
 		} else {
@@ -1297,7 +1300,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 
 			*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
 				 AMDGPU_PTE_MTYPE_VG10(mtype_local);
-		} else {
+		} else if (adev->rev_id) {
 			/* MTYPE_UC case */
 			*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
 				 AMDGPU_PTE_MTYPE_VG10(MTYPE_CC);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fe937670c927..b23ba92a794c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1253,9 +1253,11 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		}
 		break;
 	case IP_VERSION(9, 4, 3):
-		mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
-			      (amdgpu_mtype_local == 2 || ext_coherent ?
-					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW);
+		if (ext_coherent)
+			mtype_local = node->adev->rev_id ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_UC;
+		else
+			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
+				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
 		snoop = true;
 		if (uncached) {
 			mapping_flags |= AMDGPU_VM_MTYPE_UC;
-- 
2.34.1

