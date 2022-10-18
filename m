Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA3CC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 08:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF92E10EEEE;
	Tue, 18 Oct 2022 08:33:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A62D610EEF8
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 08:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckuarspG7uTcbp8H5S4fa7dQd8Tpqce35aksGvJlmYdzvkTm3WUvn1GvYnsvJ/1+69nrl5SjLwY7JSZ8K5b8THmCeUJN4oH1mqhB9fTyCw/94VLhF/Gr4426j+SkIjaKSt6p1SVugKs2/5TXakultpGiHgpPLBDN7nyeS7W2K0thowHTXJCci6EmvcDBp7Wb1RpLdbxXBziHUBcJjpIm/SH6PVggPYThA1nhnJfhr76OIv0Li1TIGulJsiW3tKUqK0G8RPempi1/bb6ax/WTLbuLVuI0aEBBvoixMpYvnKo/pK36UWQ2/2qdVfT4VB97s5MQnd2ia47XqQ6oFE5uew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0M+u890y9Zsa3LkUypSxvpilBFnv83FGuOfzML8vCg=;
 b=O4bGLTlKeq4syOcywPDloJc6UWa/yv6JMfQZR72IAlWEvOpFsUzlxX86Ecx5d0LuJOhPNRfOzDIO6wxl51qkihXqE9F+RRm4kzbVaDYXCP/Ol3BbFkz/fnXjmuNK5nUY7B3WHpvdVaEvuSTPbVb3BK2WgfvftsYfkrR0Ghq5QKan4V1pc4Fei7Y0ZY+l8eBEheVV7MBEPWK4QCrb5s8DeNeZatA7GJBp7wbb9sg9u99J0gXLBQrJlXiMrKbpM/3yIPAnqGhk3W86bG2eH2lUSxZjg3GJI3CqEh37CU0KrqMNWHznzhgqHAuh7zc0+PCC2bxoOD0W2mdIKAUNRWKiVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0M+u890y9Zsa3LkUypSxvpilBFnv83FGuOfzML8vCg=;
 b=t/XpTqR5/IOjilehAnY/C29n9bqR11ETCpSk3seB6CyeyQ4YrWf1oi67uvaRcvONprMSaxhWMvK0NaT3xGNxcRWOVrBugt9NQABpN2IJLojnUl1uhDRATdsyxyb0HFGusC8cV38ooBWq2+YXc72BAPqkELIsFwu1tbzeRq3ebFk=
Received: from MW4PR04CA0051.namprd04.prod.outlook.com (2603:10b6:303:6a::26)
 by DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 08:33:38 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::b5) by MW4PR04CA0051.outlook.office365.com
 (2603:10b6:303:6a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Tue, 18 Oct 2022 08:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 08:33:38 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 03:32:45 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>, <candice.li@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add RAS poison handling for MCA
Date: Tue, 18 Oct 2022 16:31:59 +0800
Message-ID: <20221018083200.15597-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221018083200.15597-1-tao.zhou1@amd.com>
References: <20221018083200.15597-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|DM6PR12MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: 803b5483-4c8f-41c4-baf8-08dab0e374a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ee/iheIVJkpgsr/UCqIbBO2vnJSYFUaOMe/xIoqr0aFCPheMOg1RBYWFdsQGJI7rQWv09JWo1SpViPj16N/8gCGu2vgneWrP+k41GyOVJltedgJm1fJLd9NjtSMOsU6Dextbm0yCQKaPbdzDR5Da1rvrMxK1yyjqb5NNTKUrJS+QKTAnFnvuN8RWru1rYInofK8bFBUdfIlPtO0yPyvLNw3Fn7NOQt3GCBcCchK2wHIX8s5JG2b5oubkZZcdxMy806SJyV33JCgxMujb4zGBOjKbbOrrJA7TNjXUg/2c1zEQrgKAgOHrh2wHZytETkiktCki7IAYr7Y/l5C6Y+VrRJFNIgGK4kU9+MIvxPYq4SuYBIkstMtbHYZS5rMyv+sSw29EWDtM538lTpr7N3+pkH3PALKZdhxIYOkE71KXNCU6PXDjzTP8w7uSgjqAKHhTAiK6Cs42h8uWZblDYGC+YyCoU2HOMKdNooZQxTu6/wta9pYB5WIvtWfOryFANvSjiYZsxNw7s+O3D1XmLfM9LsaTlViMYs4BhbWBUXkq+nW754fxRrwAjE3TXdneffjiIVczpt1/6ogjsAeM4RkmOTIJqTctySBU6SnIl+ZSy5fGseZG6q7JJ3S37m8Nw4mseHonCyA+ZuUzP7GZiWwLN2wHvuoLo/dzKry9ECG72EPvrFCq0t6nnTBfnZ2qNpb+mSLfkC2/csCBGk3rv6wvEiCP3929Roz0AHGnEr/LhjzKPcUs5ky6cwct/Ap4XOTO/ZzW8Cu974aU3ozxAVutj0ZQ20aVzT6CfFbiP0jLNphEM0lap2h/YS+Xl1RGIw36
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(46966006)(36840700001)(40470700004)(6636002)(110136005)(70586007)(6666004)(40460700003)(70206006)(8676002)(316002)(2616005)(16526019)(1076003)(186003)(40480700001)(426003)(2906002)(4326008)(86362001)(47076005)(336012)(26005)(36860700001)(41300700001)(5660300002)(36756003)(83380400001)(7696005)(8936002)(356005)(81166007)(478600001)(82740400003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 08:33:38.5998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 803b5483-4c8f-41c4-baf8-08dab0e374a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For MCA poison, if unmap queue fails, gpu reset should be triggered even
no error count is queried.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 27 +++++++++++++++----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index e97b1bd343ee..22995f371eae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -229,18 +229,23 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
 		bool reset)
 {
 	int ret;
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-	struct ras_common_if head = {
-		.block = AMDGPU_RAS_BLOCK__UMC,
-	};
-	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
 
-	ret =
-		amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL, reset);
-
-	if (ret == AMDGPU_RAS_SUCCESS && obj) {
-		obj->err_data.ue_count += err_data->ue_count;
-		obj->err_data.ce_count += err_data->ce_count;
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		ret = amdgpu_umc_poison_handler_mca(adev, ras_error_status, reset);
+	} else {
+		struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+		struct ras_common_if head = {
+			.block = AMDGPU_RAS_BLOCK__UMC,
+		};
+		struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
+
+		ret =
+			amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL, reset);
+
+		if (ret == AMDGPU_RAS_SUCCESS && obj) {
+			obj->err_data.ue_count += err_data->ue_count;
+			obj->err_data.ce_count += err_data->ce_count;
+		}
 	}
 
 	return ret;
-- 
2.35.1

