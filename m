Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31F9EB64D9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jun 2023 03:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ECC210E145;
	Tue, 27 Jun 2023 03:56:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC2710E145
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jun 2023 03:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ooa2EEq9ppG5ILhfJzg2VT9o7i2amVezF43um0jl5BPm1gGbxwN9U0VG3Q64U3iW5oPppfiOlh4Eur277++fuZC7CGD6pejQm9nt2GS7DvDo/ctsmtBbTytcmuJNGCiLHCq35nvcPCm996hxGNoo34pyTpYCYn0ssMOU6Sy5JSE+t1XsBfP45CDlSBmh+dRWg86mfduiMTJvV/SNbJnMZ1GGPM7iciP5OYj5jVFr0MwJ/q/lXHB//pRvX3z1gpoLuI8N68aPTc8VR1R0K2KNzY+JH/Vhc+R+Rf3en6qkK+0QseM8my+ghgipPGIUBbYfSShjet7BjNqEDPdEH7DWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DY+8f0hGrABUI5OK5SVBFrm6X8paMwXm/ihTO9UI0Wo=;
 b=F8oXMjID3fwy5JABC3J+E3MShH2kSl59IuQbf4EJDVK9oEgk1u+JsJi++qmpz+6Qd0jGQXGW9AJnEPAEXLExSTjzdkRKGot2aom9GCBbYDU92PD2s8KyoyrYzEryNvkTmLW7EFqHhNQuO1bfBLYR3vEprpZebmXDGsJIcDQdfACURF9AzdVbo7U9aA6gUWczdBDpM+BywSsrSkqIOnVdwRyRw5Lqzid8Dq3K0aJ3hmlR2zKXNeEM26vyRtJj37cTUehvmN922EPKnauTlGDOvYsaaKywPvW6xJd3lU9/4M72ViYtk5Y1IBCie2CG6GkPjOAL6qb7gRgTD92AseB7dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DY+8f0hGrABUI5OK5SVBFrm6X8paMwXm/ihTO9UI0Wo=;
 b=M0t6MctzLQZBS7oRqWghrOcT/Zuz4YamvUUosC0RnTUSl0sCr4NJIRW95c9mbO+vVg4MdoxymXXbUaUMomI2GpUhhsj+1J5cKjMKNSZMOwPCspJ9N4COKetiM9IHKxIsa7RLJhNTrV0rPEXZ0emsnY4BFB6Lk5Gj8xUus0XdKf0=
Received: from DM6PR03CA0076.namprd03.prod.outlook.com (2603:10b6:5:333::9) by
 CH2PR12MB5514.namprd12.prod.outlook.com (2603:10b6:610:62::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Tue, 27 Jun 2023 03:56:30 +0000
Received: from DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::11) by DM6PR03CA0076.outlook.office365.com
 (2603:10b6:5:333::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Tue, 27 Jun 2023 03:56:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT072.mail.protection.outlook.com (10.13.173.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Tue, 27 Jun 2023 03:56:29 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 22:56:28 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: remove duplicated doorbell range init for
 sdma v4.4.2
Date: Tue, 27 Jun 2023 11:56:20 +0800
Message-ID: <20230627035620.8589-1-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT072:EE_|CH2PR12MB5514:EE_
X-MS-Office365-Filtering-Correlation-Id: 865dc184-04d7-4a08-27e9-08db76c27d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odziRHnvi3JaC9QNaymH7n+OWWGxGNe47tQEgYqoavqPunk2z3/1+1veZO/PP2LPPjvecXAA16L6ST5cr5YcWwmaueec1crSsMa6k4aYaJ5ATtTxKPw+QICfCaiIVxBkZNoM4cmq+h/uDBYuF+ZJchvBOpa+ZhiYLnWr8qXpdd0fxVTY72RBmAH5S6lqyH3fuvnSuay4b4BpZDfxb9juQoaW0y74k/SJRtr6YPTK89t8fqhdnmh1Gv968uvYJfaFVrLBeXYzc+vjydN/NQ/yitZDesUTD8JhnS+N0VQNHgGLHXl+BJZblUhXm/Er3/RSp8cHYC2NeNYuI5PrAP7Pg+0V9bHGX9o4wd7wUMoku0bseUgDm+7VDmhRmMhubcqxlb5A1E3grzpxT0EYDgMkjszGYOjDq4C2fOB4dwka2AyTsi1if96/InRDBFNS5S2/Mc2+zmovPKkFhQnMwDiHadd3XIec2zdgqIjYHQW7pRUmoELMgTHQa67Ba2//uGMzPtAAdKiCr3MM2AHpEId1mfoWlc0ER6mvcLGG/e5zsDM2tMLPTXj0WgNCEkaKujwm4Ksytg23BS4MLmsWLlXiuOMyWBRxeCxWpoxHov22rOOBKybAgeJ4BdFaUT2lZBQQ//fDpJ6zqCCS2ZLx0Quf9agt0sDTv/rcPYQZpy8iR5pFNCTQs0A/lMTAjb14udzVqbFyaEbPqmMOD4VQqWQDT8qVI4VVHg0dMHeCRrjgeLXc9nhN9vz4dnrYg3B8jbWSh7kw4lxqcuL/bo7S04ZjLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(8676002)(41300700001)(316002)(8936002)(70206006)(70586007)(6916009)(186003)(26005)(16526019)(1076003)(336012)(2616005)(4744005)(478600001)(6666004)(40460700003)(7696005)(82310400005)(2906002)(5660300002)(40480700001)(44832011)(82740400003)(81166007)(356005)(36756003)(36860700001)(86362001)(47076005)(83380400001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 03:56:29.5957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 865dc184-04d7-4a08-27e9-08db76c27d0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5514
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Handled in earlier phase

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 6be19ffc502b..f413898dda37 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -902,11 +902,6 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		WREG32_SDMA(i, regSDMA_CNTL, temp);
 
 		if (!amdgpu_sriov_vf(adev)) {
-			ring = &adev->sdma.instance[i].ring;
-			adev->nbio.funcs->sdma_doorbell_range(adev, i,
-				ring->use_doorbell, ring->doorbell_index,
-				adev->doorbell_index.sdma_doorbell_range);
-
 			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
 				/* unhalt engine */
 				temp = RREG32_SDMA(i, regSDMA_F32_CNTL);
-- 
2.38.1

