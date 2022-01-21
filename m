Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB49C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 08:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8896310E98D;
	Fri, 21 Jan 2022 08:50:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E60010E98D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 08:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eH3iVre79bvrhD7utLipCiId9ihDoa874us7yXB1fR1s59zB/nFz0y6CG9CyXkJA/5E4OTgMiC5u9/sjd3/azIClhD3bAXDFQdYVwuVBvXVprqxHFGjvoW60TC9QwqeBUr5VuMTt1Ezglw2UDcvK+8X+2v/Ff7QsYDlEC0pCMuJjg14FPOVnsyDE228wFiN3ZIX/3nSOyxG1P7IzMGUTxLxDUJC21XqKDOHyhgtInco1JvPsuPE1Hw37s6YsvlrPLIPzRiVXYMTeiDrQIlqsrAjdgFXsML5J8/20CSWPpd9vqt1a8JUvKTV6D47TlMNOZ4R0W1sFnfswKxTCaPZJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/32fLkHdGlbpT5HSpYUMCbYUcMtvFuUFMsgnTxeonIU=;
 b=BW10PYYtQ27Eh67oxwXL5YBoTt5V0rOWNStLzRTphnIEvsfskG6vrxgsAL366bSKNvcUmf0qvC2JudZI7T7wC/tF0bXmB5bDNV4zVHPNelTZKb6OK2SWJpd7ZeoiCXfe/VtHVqgp2lxX0BKgVfhoKYHFPymVCSeopuixD6OpUyAVaVE95USWOnKVeQcM0ez6FZHZYK6utQdymNI3GbbFnqpEDOO3i83I6CKxX3moGLDvRsaqJpj2hwrsU2IzmNCEE8ZvoZprz5S5dro1oPOe0CjqEywRh7EKLYeK/6tnzw/CQW+KuljOSEkEDXiRryEKWKtdz6rZ9PIKIyq9Pdo/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/32fLkHdGlbpT5HSpYUMCbYUcMtvFuUFMsgnTxeonIU=;
 b=Ks1t4WUxLHNQToj/2zHT3hzViilZl62WhEplYesjPpzqcLdhMxiU8CVwd2D3kKoO0/YtbBLhvlx39IifroeDGwC/D1/4AJJZ25W+eJXUpDzABAvfJG0956vCVBrhx+lj5AKzTnl6mXWH4VJwYtOtcwNzbCl9ubaPUU6Bq84cL7c=
Received: from MWHPR07CA0010.namprd07.prod.outlook.com (2603:10b6:300:116::20)
 by DM5PR12MB1547.namprd12.prod.outlook.com (2603:10b6:4:c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.8; Fri, 21 Jan 2022 08:50:04 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::46) by MWHPR07CA0010.outlook.office365.com
 (2603:10b6:300:116::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Fri, 21 Jan 2022 08:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 08:50:03 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 21 Jan 2022 02:50:00 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] add register dump function for nv asic reset
Date: Fri, 21 Jan 2022 14:19:42 +0530
Message-ID: <20220121084942.20004-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7a6d687-03dd-4637-cb64-08d9dcbb045b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1547:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB154732663242DE7B8215BCA6F85B9@DM5PR12MB1547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:183;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8YLt1A/kSr4as1+mcZeWXkZmMD2VQyaC3fE3sTfvqNek2rcrP1zhyG2cFQPIpz8u0VXD8m+fzNYKnUDMcXkY9AL/Q6UKct2WVCHVJPDKUICPjUyPFg2cp49eqFlK4ShZDShnEkcugE30WbiPtCB5hHAfP/GFoRQhwuFxkkpETMRDBDTnFFpGdmHu39ZPGLKcgjGhQhXnSxxrc44j4z7ZoeZWDtA4ZYSSZcoFT/Ykz9p+pwRTughopYT0M5QSzwqyVuvAZEaKJLmsyt4urorSJtij+ZTbBpQvPg2sldS0w5OqueGGAauTrOWwaZxZsBTFASKYEntwW8P1e9/YqfNmkPcIIOSXFlSWQCY53IgNe51oqnjPLiEKoBs+3CnB3aPKMCvIs6K8XCLBv+Zd71Tvswitp39JdIezfyTs2mv8V5tDHd//lCDw1I4tgODa4UEJjBSSGe2Char1c/OUkhsPVYE4tH78n08JaL4L+iWYsD/b9l1bjP9kmDBB4or1U9CSAdcsVUrnq0i5Nug+1tCc5KaaaV9KP2fEDZ8KRTQ0Tshd9CtKd2i7MbEo0HfDAjG+zeWvWJOBrBwzRhotPtzi4vKnpDeWDNKBYUbPG/+KQwEqyR9VqfinflbPloU40dQtlnlNVNTDs083fIslKXZKr/VtxExu+aAqHm2be6CejQnrvhrjGS0Ooq4n/PZZ9R2PK8szcoZKFGS/QVs89b6FnmfjEdRXs4/YcfP6kX4VXSIM90qhQSX39vcc8EZwiVsIamd2AA/ZcjWJv622g3kwcBTxe3zWMMCVoo1utob/ro=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(36860700001)(7696005)(316002)(6916009)(83380400001)(426003)(54906003)(26005)(86362001)(82310400004)(16526019)(2616005)(508600001)(5660300002)(186003)(4326008)(356005)(70586007)(6666004)(47076005)(70206006)(336012)(1076003)(81166007)(36756003)(2906002)(8676002)(8936002)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 08:50:03.7880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a6d687-03dd-4637-cb64-08d9dcbb045b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1547
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
Cc: alexander.deucher@amd.com,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 christian.koenig@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Register dump call on NV ASIC reset on AMD GPU reset

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2ec1ffb36b1f..b5701772597f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -529,10 +529,34 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	}
 }
 
+static void amdgpu_reset_dumps(struct amdgpu_device *adev)
+{
+	int r = 0, i;
+
+	/* original raven doesn't have full asic reset */
+	if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
+		!(adev->apu_flags & AMD_APU_IS_RAVEN2))
+		return;
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
+			continue;
+		r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
+
+		if (r)
+			DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
+					adev->ip_blocks[i].version->funcs->name, r);
+	}
+
+	dump_stack();
+}
+
 static int nv_asic_reset(struct amdgpu_device *adev)
 {
 	int ret = 0;
 
+	amdgpu_reset_dumps(adev);
 	switch (nv_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_PCI:
 		dev_info(adev->dev, "PCI reset\n");
-- 
2.25.1

