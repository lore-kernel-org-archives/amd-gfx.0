Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59539C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 12:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 174B910E64E;
	Thu, 27 Jan 2022 12:59:48 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 052F610E139
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 11:47:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPAgytm3Nf5JjfP+QmWoKwr9uxv3MQOHkGiEMfYVizMM34kFULBoQOLAmEngo0VloeaSGhs+UfWA8UUCVjSOw7KwO5b5Lem2f8nMml+OO4bqq7A5eWlR9Hqafkr0zDBwVsYiz8nDPf/K1yy5YuW+qNC2qkb5ojlLEpCIyFxN9HAQypN7p5zvKeqfXl02h6hmclO4CM8zNfX5nUzA6/CCX3BDDDYXLw1+KsuBx2/UKnr2rB8gYYzj0rNApSReh7yL95rs3RCMNVXqmqe1tnexwSMU0PInuwv6ErhbKjQb6hujw8P/4WfxhT12pXQcPBWjcQQyfIQcHYq5qvbnglvDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85lUq/P9Leau69nwrhdKFk6sHzU7zLdHv3XFFWp+VJE=;
 b=AoFwOF0Iy5tlk3AzFpWqzKWA/6XQ5NxBLuUHKuPK+R3XbmsgdGdpUVVYibMLF/fJ5c2FF9eWwoJUqMpdTlNl/zGofoukhveX0C3Pgi0nH8spi90lFxuYvWgxI7Nb54pEpTcfhNUryV16oH9E2CEYmI7/C1OXr2JYEhw7awYttHiJ/o+7QLq1IxXGFGAWcqypqvIocVw1kenmsDFVvJTjmOnfnFHDd3gmdeBwNCmZeokGTUbS4uvIz9hoTPVnQRPNtSV7g+ulmVulHZ1aO+qSDEBcDwLBFO9+h+SKWfV8Cl+HSoJ8nXKN7y4juwVa4f1ONQLd/HUijh9/c4y8jPd+Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85lUq/P9Leau69nwrhdKFk6sHzU7zLdHv3XFFWp+VJE=;
 b=W6emlXaWEpfMYcoSRBE+Z+BP8KzFOaDjic4S3gGBqxKRFODehjFCVzsi0FuAruk+C9lP1hEGwhDofzFekoDunDviZdYl20MX+rzCAG3BvmpwTOt5IK1xSE+UQ+LqKnuFm6lu4klNs78T1ty0DioWG4VEQdnIe2g24KylBwsc5yo=
Received: from BN6PR13CA0039.namprd13.prod.outlook.com (2603:10b6:404:13e::25)
 by MN2PR12MB3934.namprd12.prod.outlook.com (2603:10b6:208:167::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 11:47:38 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::cb) by BN6PR13CA0039.outlook.office365.com
 (2603:10b6:404:13e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5 via Frontend
 Transport; Thu, 27 Jan 2022 11:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 11:47:38 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 05:47:32 -0600
From: majun <majun@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <brahma_sw_dev@amd.com>
Subject: [PATCH RESEND] drm/amdgpu: Remove the vega10 from ras support list
Date: Thu, 27 Jan 2022 19:47:18 +0800
Message-ID: <20220127114718.836592-1-majun@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a332d34-bb0b-41d1-ce3d-08d9e18ad169
X-MS-TrafficTypeDiagnostic: MN2PR12MB3934:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3934D6610D87065E7F638541BC219@MN2PR12MB3934.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3YCn3joTQSLKiwhBzcSjHgLSZzlJ/PtZVJ9oONg9gmE7/0C6GaG6X23oUXUreVMN2asJx+7nbNJeVqw+UlNCTlVo5iKXaFFxfgnK/Mu9K1FoydmLy/dlUSCrJuOpjQyMsp92qi7btPi/+x1PFI8gR8lJYLwazYLO150rZi69vmDRMsY8VjMoWvbW5JCRX7nhUTfIO+s4UADXyvbuHXA1tQUJZhJGKw3j1swqgw2tTn8vppLuKJ0lVojn3tD5qbN+agygJedRFmbQRri6QXB2y2ydqbIdJnGYhzRTIjUxPKGJc/OKVQMKC7D0QfwyFuMCTUpi7i7zLi/J8Yxv24zMeNCbK5UtrAg2u9IFyODM8e0Uo42mI7A7t2dANvrF0rLvgV4ROVewrtRXOToq1x3W20RzSS1ETEeK2uAB1D/HdwJ/LdE3glolUmOC2h7lflKdODAKbgM7tQ/L3DwdsRifwC/KWE5e7iPIxq9WO55O95KLVlK2DQLLXqJRWTHZ3PIAl+v6Li7N8M6/4CX384WyoTYB1TMnkyYy8hzmNe5U/qxGfs5IDnLoFfWWtvBkEXrxjwvQ0I4TkwmwsuAzM6gwy8PY9G6pINy4ZoYoNle3YW5I95U+nhHsi2GcFZovmR8WQpkG+dwvIXAarAb1rpmITFl61IqBnhcOScx49kziOzi7GP3Hiiin3CSZ4xlMrhVhDtyX+ZkO2y23Rom2jEq3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(36756003)(508600001)(2906002)(54906003)(6636002)(110136005)(2616005)(47076005)(16526019)(81166007)(356005)(82310400004)(336012)(40460700003)(8676002)(4326008)(8936002)(426003)(7696005)(316002)(1076003)(70586007)(70206006)(186003)(26005)(6666004)(83380400001)(5660300002)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 11:47:38.4119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a332d34-bb0b-41d1-ce3d-08d9e18ad169
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3934
X-Mailman-Approved-At: Thu, 27 Jan 2022 12:59:46 +0000
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove vega10 from the ras support check function.
Base on this change, the ras initial function is optimized.

Signed-off-by: majun <majun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 38 +++++++++++++------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 37e9b7e82993..aa1de974e07e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2129,8 +2129,7 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 
 static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 {
-	return adev->asic_type == CHIP_VEGA10 ||
-		adev->asic_type == CHIP_VEGA20 ||
+	return adev->asic_type == CHIP_VEGA20 ||
 		adev->asic_type == CHIP_ARCTURUS ||
 		adev->asic_type == CHIP_ALDEBARAN ||
 		adev->asic_type == CHIP_SIENNA_CICHLID;
@@ -2164,13 +2163,13 @@ static void amdgpu_ras_get_quirks(struct amdgpu_device *adev)
  * we have to initialize ras as normal. but need check if operation is
  * allowed or not in each function.
  */
-static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
+static bool amdgpu_ras_check_supported(struct amdgpu_device *adev)
 {
 	adev->ras_hw_enabled = adev->ras_enabled = 0;
 
 	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
 	    !amdgpu_ras_asic_supported(adev))
-		return;
+		return false;
 
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
@@ -2203,6 +2202,8 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 
 	adev->ras_enabled = amdgpu_ras_enable == 0 ? 0 :
 		adev->ras_hw_enabled & amdgpu_ras_mask;
+
+	return true;
 }
 
 static void amdgpu_ras_counte_dw(struct work_struct *work)
@@ -2236,6 +2237,9 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	int r;
 	bool df_poison, umc_poison;
 
+	if (!amdgpu_ras_check_supported(adev))
+		return -EINVAL;
+
 	if (con)
 		return 0;
 
@@ -2250,28 +2254,24 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	INIT_DELAYED_WORK(&con->ras_counte_delay_work, amdgpu_ras_counte_dw);
 	atomic_set(&con->ras_ce_count, 0);
 	atomic_set(&con->ras_ue_count, 0);
-
 	con->objs = (struct ras_manager *)(con + 1);
+	con->features = 0;
 
 	amdgpu_ras_set_context(adev, con);
 
-	amdgpu_ras_check_supported(adev);
-
-	if (!adev->ras_enabled || adev->asic_type == CHIP_VEGA10) {
-		/* set gfx block ras context feature for VEGA20 Gaming
-		 * send ras disable cmd to ras ta during ras late init.
-		 */
-		if (!adev->ras_enabled && adev->asic_type == CHIP_VEGA20) {
+	if (!adev->ras_enabled) {
+	/* set gfx block ras context feature for VEGA20 Gaming
+	 * send ras disable cmd to ras ta during ras late init.
+	 */
+		if (adev->asic_type == CHIP_VEGA20) {
 			con->features |= BIT(AMDGPU_RAS_BLOCK__GFX);
-
 			return 0;
+		} else {
+			r = 0;
+			goto release_con;
 		}
-
-		r = 0;
-		goto release_con;
 	}
 
-	con->features = 0;
 	INIT_LIST_HEAD(&con->head);
 	/* Might need get this flag from vbios. */
 	con->flags = RAS_DEFAULT_FLAGS;
@@ -2545,7 +2545,9 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 
 void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 {
-	amdgpu_ras_check_supported(adev);
+	if (!amdgpu_ras_check_supported(adev))
+		return;
+
 	if (!adev->ras_hw_enabled)
 		return;
 
-- 
2.25.1

