Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD49CDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 12:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62EDC10E2EA;
	Tue, 17 Oct 2023 12:46:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2376F10E2E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 12:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYzr/k9Ytr1OSgOvrfAZUjZQ0onUkAoZkSdVIpcF82ShwfTAsV5rh1yz/J3cdgATAQPALcZasCRxqDK+94w4fiIOxlm/5aT0SwE/h0yYCVcaVHeW17Ol+Qybnfw8WiIg+5Hkx8jMxQ0Lxpmg4p7BeGXlzqAGFliu87OLmpKFykiT7PIEnd+F8jGQFTbF166yevQpT9VmTB9c+TX9FDrnOisogSO6MtQCOPmo6tdhbpefBJAWj+i19ZPZ9aqegr4OtuDQOKKnNXQN+S8regRJ699NnqpSH27wVeZMHWhio9x8ENNfcBTjULtxBYDhaWilOqIvpnfDPca9x7Qh0Eyfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVSKEsf3+GVyIFFf6OuxatIt4qTp4kxTSpTZfeGjcv8=;
 b=lSb49zg24vJmANHewr0EAn9AuXeUDD1SLp3o0+c/xzkgHqReLWxGhrTCPEggWiWhTokiJmRfsj/nsbaLxNXB6S1V8wozulbCVWCoBsqBHCYYiVns9tFRkrqNR6TarVgF2Av7BztgYD1Nt5It9lE46Fosy7Zm1xSXOSVzBU2nsBIsjrvd8TI5MiB9jpy/bvL3etTDJM4HQG7rrStPn7aY9JO2YBcAQv7+VV4lGkzS+dqOCC+uPsmI99R+UAHvMmVVVQ/tY68IW47/MlYSoF7VFo90uE7ccqbPt/6J2SrMZtEE7BMoPL0Nx6voz+RtKJ0/xmEuoyuWUgTqKvQKVw048Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVSKEsf3+GVyIFFf6OuxatIt4qTp4kxTSpTZfeGjcv8=;
 b=KX0linBXNtKa3g8WQHAH4OEeK9S8S4lc5LsAxv5zuU6NFaYxgyqz1mongslqAra+6xle4A5UlsKkoRFM1OO5TRIdEqthl9lOy0HVv6tX1yxPX+r3a+iPekTkT1LNz8iZPuFu9ohj1g/8ecki0BV3KpKNiKnWU85rZK1LYHIOepw=
Received: from BY5PR17CA0047.namprd17.prod.outlook.com (2603:10b6:a03:167::24)
 by MW6PR12MB8952.namprd12.prod.outlook.com (2603:10b6:303:246::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 12:46:14 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:a03:167:cafe::13) by BY5PR17CA0047.outlook.office365.com
 (2603:10b6:a03:167::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 12:46:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.4 via Frontend Transport; Tue, 17 Oct 2023 12:46:14 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 07:46:11 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Candice.Li@amd.com>, <yipeng.chai@amd.com>,
 <lijo.lazar@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 4/6] drm/amdgpu: bypass RAS error reset in some conditions
Date: Tue, 17 Oct 2023 20:45:50 +0800
Message-ID: <20231017124552.27509-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231017124552.27509-1-tao.zhou1@amd.com>
References: <20231017124552.27509-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|MW6PR12MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: 874aae8b-4d46-4901-b0e9-08dbcf0f0c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HHBxwzHnAGwJ37Bwi34xnhJLVbfkqU8mKNOADeOx6iUP6WHj9QsUEYFjTrJYNvkaA6o5IRhCTfc46OZkxcHPseyRX3kJ9cx8evbBm0Om99IJDzvXKnSrL2MSF/dkhGJRi5W8VQ79kK2ZklvBi7PvdNB+Dgh5CwJJy+AB7/WpFdec90zjL0ABagQnQR2zu11We28+SDFny4iQF3oJQ3LUE/9TuObfUDnZXoVa5wq+kkhJRriXIgAPe4BLnmxwNUACq12+uXPzSgZik9FFCWx2CO1iR9th/CuSX75nnYLtNSauTNm3lnHjQpUclZ3GNWsj3AhpoMovEwamX7SqwV4EbO8RhMnzopbrifPxr5t1pJoDvK2X/jpdHetpH17gM1t6LvQolzOADRq5y8ogTHsa63e/6J/glgOE8Y6C6r3VWKEK34xy0KA0ROee0NUTBmG8mSrjebGf9Sv+tVpVNh7D1AzKsVPlx+x67t6e78wcztOQ1AC/5aZHRNpr05hLJofvQXA6Y840UM9MuClTFgmMrmoGrOuA7ywHZO2VLsS3CpazZrRTEiHlNiMZS/tUaOA7VDBJSIzog3uLvx6ZONaz6fC9O/OW7YOqJwCIqNjnWnaxgjXOJdkgmQgy8qUTfePK3QR+8dLDjQZjZM6knkeE4LaVLrpMudd/bxaV6Icg6Ypr8KZCqaRMXUlO+7OZdbsJMflVNVE/kcRq2nwZGGThToyBNgusLgkOdrpYdkKNfnc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(46966006)(40470700004)(36840700001)(7696005)(40460700003)(40480700001)(36756003)(82740400003)(36860700001)(356005)(81166007)(47076005)(83380400001)(478600001)(26005)(6666004)(16526019)(2906002)(6636002)(426003)(316002)(70206006)(1076003)(336012)(2616005)(70586007)(110136005)(86362001)(41300700001)(8936002)(8676002)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 12:46:14.0057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 874aae8b-4d46-4901-b0e9-08dbcf0f0c61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8952
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

PMFW is responsible for RAS error reset in some conditions, driver can
skip the operation.

v2: add check for ras->in_recovery, it's set earlier than
amdgpu_in_reset.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 95c7ba889e2d..806c6d4deb63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1178,11 +1178,19 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block)
 {
 	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
 
 	if (!block_obj || !block_obj->hw_ops)
 		return 0;
 
-	if (!amdgpu_ras_is_supported(adev, block))
+	/* skip ras error reset in gpu reset */
+	if (amdgpu_in_reset(adev) && atomic_read(&ras->in_recovery) &&
+	    mca_funcs && mca_funcs->mca_set_debug_mode)
+		return 0;
+
+	if (!amdgpu_ras_is_supported(adev, block) ||
+	    !amdgpu_ras_get_mca_debug_mode(adev))
 		return 0;
 
 	if (block_obj->hw_ops->reset_ras_error_count)
@@ -1195,6 +1203,8 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		enum amdgpu_ras_block block)
 {
 	struct amdgpu_ras_block_object *block_obj = amdgpu_ras_get_ras_block(adev, block, 0);
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	const struct amdgpu_mca_smu_funcs *mca_funcs = adev->mca.mca_funcs;
 
 	if (!block_obj || !block_obj->hw_ops) {
 		dev_dbg_once(adev->dev, "%s doesn't config RAS function\n",
@@ -1202,7 +1212,13 @@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
 		return 0;
 	}
 
-	if (!amdgpu_ras_is_supported(adev, block))
+	/* skip ras error reset in gpu reset */
+	if (amdgpu_in_reset(adev) && atomic_read(&ras->in_recovery) &&
+	    mca_funcs && mca_funcs->mca_set_debug_mode)
+		return 0;
+
+	if (!amdgpu_ras_is_supported(adev, block) ||
+	    !amdgpu_ras_get_mca_debug_mode(adev))
 		return 0;
 
 	if (block_obj->hw_ops->reset_ras_error_count)
-- 
2.35.1

