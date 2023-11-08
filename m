Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55906C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 02:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9199910E2FF;
	Wed,  8 Nov 2023 02:46:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E82C10E2FF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 02:46:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9ZKXSY+AL23y/nTBOOsPw19Kv4x9Cad8Kb0WPa5Msme5BSm7E0fcBUZkAv6+E1FnFuRkSQNzZXFV9so/fFaGj1mBDdBp/C3eo4HGfE3bKJQXigCFCA1JgOWAtsq0J8/a6S8XBceqiA1Kc/3b7TEIq9wsN7NEGr4L/E3pXLHj6jzhnegIVkoCRW8c7dKvIkvJEwRme0DswNh6mJOjw8Pu2dVYGxZ7hkkWX1/FLj8r95jWRpNiDQgDijf4q4AitcvDaCByL+Co8XS8CyETgBENBEWckVrLcuBEH5yAoRB1kRz6+uiagk650wn5wYUvW6ilbu+JNxPqJgnEXSb16o6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnrdpGI6swXRcvECE0GbM/BJx3Krpa7sTF17c49l/YY=;
 b=lL8r8p82XPUpDRp93eBEx9nWtX5Xe2xrTlwpxf4m9uVUe64CibEulmHd7Qqdao8zvMgOHCwXK/Wf6/AjlmIdNQCPuQa1OIllgaQ/53nj6+eOsMypfas8nTdFdvxXyvIEwjev5jTotMtxRs3USS0axS91lNs+g74gGwpv3lMQzuowPapCmiLRtc/t9lL/cz9g/Twj05syQsg/i75AXOmIUux2QZj45jUhXHID4gpeT9dIvm94Y9c7zkhWq46QsJMqkFRrQLizx7id/2nEK6tW74UxuzrcGCWZiMu+pqoBOuPFvyDm5nPHUnEiaEwKYtkTCLJECNH+QBCT6+bY1lc8bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnrdpGI6swXRcvECE0GbM/BJx3Krpa7sTF17c49l/YY=;
 b=o9wwfw+xM2d10yAh5qDOsk2jKewbJTQovw2M2QJlIBYfOkumZc/j/qaSKU9VT/7Qc/KWqk7FywOpLXKyhrzD/aXgC5xyWFAMs56winV2bXKPiByEBBFuaHjsOp/PBB7WL52jc2glPfiKzZ5kUp4jEFqM3lQFf4B0CbaFbvkzOI4=
Received: from CY5PR15CA0211.namprd15.prod.outlook.com (2603:10b6:930:88::13)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 02:45:56 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::69) by CY5PR15CA0211.outlook.office365.com
 (2603:10b6:930:88::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 02:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 02:45:56 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 20:45:55 -0600
From: David Yat Sin <David.YatSin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Change extended-scope MTYPE on gfx v9_4_3
Date: Tue, 7 Nov 2023 21:45:42 -0500
Message-ID: <20231108024542.2330781-1-David.YatSin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 993259bd-abc5-425e-45d1-08dbe004d518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UaCHIaVFZicGn8P1z582rHs/RqAzo7Azax2b/mypiKqipwDrdaNUKN2TQS4bxrLs05nZMyfXecAEYX2l3GoNh3x1DRJmQUcR40WlpWyKnJPanBoiZs7td232MOhZVyVNpE/hhue81NEjA9zbekB18lQK828fLsbiwDt25yEmjcnWVMYxFBYai59gcaMKjnqOfVNTpuXZME4BkJLrIP2yoEUzOYv/nycED/nLMBfvb5cgnaRsNiDgDkG8yyIZBx5TnbP8iyYywaya5KpgQiARSi0/CWu1YbcN/IPJ8Xsx4On9GddPrhdlINTnwznfRwTVhizo4L0hwu5PKbhEB6nLf5uvYiX2u8N9zr94OI9dgBhoDnr6jTjxvqQGwDylNf12jJq41hXUiVNUhGwkVCJ+Z0WNfNErZ2oinwnwtjbejyZFAIz2F3u7LpwYXLst7tRcmJboRfDi271y+LFOkiNVGWT6cuHKlVEGijTVKIvW9LrDPDOFQp6SAnOMqPZvFa8Hcl+rId4QQJYHc9ccL1Ubsf51+eT3KLquqiN7zG6XA2YQqKTI40Sk7f+ygnQs8gc7N2PVVmNmjlbhWl+osgM+Zc2PgOmPKgO78RUWz+1KCl414QMnI6yAh0HE9uhLd/awd0Gxu7tSGROnEPkWKGSFRfW5exbObRpq5k6W03kH5xzhenVVF+hzSx9qznyInFuC3587WCha9zZpygQ584KL8C+edc8LZcDcJgVl8J6miB9m41vw/2BchaiZaRM2RLLevqBDHumEDR/jFX3IP68eIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(8676002)(4326008)(426003)(8936002)(36756003)(41300700001)(2906002)(40480700001)(36860700001)(5660300002)(86362001)(356005)(316002)(54906003)(6916009)(81166007)(47076005)(70586007)(83380400001)(336012)(40460700003)(26005)(16526019)(82740400003)(2616005)(1076003)(70206006)(478600001)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 02:45:56.1592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 993259bd-abc5-425e-45d1-08dbe004d518
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803
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

Change local memory type on gfx943 to MTYPE_UC on revision id 0

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 8 +++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b66c5f7e1c56..4d3c5eaa9c64 100644
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

