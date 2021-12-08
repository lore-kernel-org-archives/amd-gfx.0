Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E96C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 10:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1354A6FC47;
	Wed,  8 Dec 2021 10:43:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 714F26FC47
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 10:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1ZtrtM6iQ45WXjZXq0v28RHEbjKKltfGG7i4mcX6cXBEwXDNVXbtW0sNx6n4LN2ChTnejFzNgDRw6aXf8qW2AoKX5W2NrPDVu4I1iLmm+4Z3fYiRxwQInn7O9vTH8zjMEotIeMbj3NdHjZyKXaUwJgPHG0OXLssOsPA7CDOqZR5BiWMDXyuXFc/LsGuce8bY7jR90tg5JHKfXWqkHjvpQhSLKNfD2RSnbnnx1z8KTFSBxH/8iX7+0/dXP/NazB6ZZxZ9CX2deGCbh8T8EMnRneRQSwI+SHgbZc4unHbiazVpNayKVpbsMFpmFzPBFHahpPPwp8tgC3sdlgwcN0j9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Hxz03KGMwNSJKtXs2ZYR5304D5nsLfn6rm+QQKORL8=;
 b=KVEOoDF88ucNnpP4d7J/HT+o67CvQPqz8GLKZcNuAdq7oeM/a7h7o1OkZ75Gmwno6uh97I22zbdux8QoeZdP64RwqM5RZdz3AGvguiee0g/a+2u+FtHfopaU7YN4HUW3y21wRaj2HVdoiQhy3Rt4YBr+Z+REZv+rhDUG7s5Odw45QMQMBEbK3qYdydX4pLMAyrCG9IZYcXSrx9gsLvdab+sDNlqO/XMMhewUhfEQElY8ZPYiQ8yH2y+h0FuqKON+DObADAws4Qz0BP6B5hJ0sQ2Wm9jmFJgkWLrNRE+/LKi6jK0F+mz7Q6KxjhQyaEyDoBHxIW6n8xhQuh3U/Cc87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Hxz03KGMwNSJKtXs2ZYR5304D5nsLfn6rm+QQKORL8=;
 b=mupT+X9vRz6KG4+5JXHrACbn0/Yg/UYPx0Y2sSSHw0YjExrMEowWiI12yB7O9XgRmiP4iwYimr2l3JZxlnjDTpLnOL23Z+c5hFk0Dwm+FaKq4+WVdUXwTdI9uunFtMdmXaXRmTQQdBFewaBggmG7i8whtwXdAwzdJ+fZ30YFeVc=
Received: from BN8PR12CA0024.namprd12.prod.outlook.com (2603:10b6:408:60::37)
 by DM6PR12MB2651.namprd12.prod.outlook.com (2603:10b6:5:42::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Wed, 8 Dec
 2021 10:43:54 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::b9) by BN8PR12CA0024.outlook.office365.com
 (2603:10b6:408:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Wed, 8 Dec 2021 10:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 10:43:54 +0000
Received: from thomas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 04:43:51 -0600
From: yipechai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove the redundant code of psp bootloader
 functions
Date: Wed, 8 Dec 2021 18:43:11 +0800
Message-ID: <20211208104311.180213-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c858f6b-bba3-478d-e1a2-08d9ba37a157
X-MS-TrafficTypeDiagnostic: DM6PR12MB2651:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB26510C6E5BC3D753B9C56DF2FC6F9@DM6PR12MB2651.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icniHk0hotXHeGVXHBDaCkQmut14345gWfzPZZQRRM0OHCqnxV269X3tPI9uikciNx1ig5Hya1M9eNjdrkLJxfT+uxOZmD9YJEEpBDTPlRDyQ4p0x8vlnYnAJF7lzPLTylGAH7re6xagzRON29sUc3v1LErYiLuNoUSrMqSr7U/lovDV6iFyUcxcrJATyHe4Qtcl17kDNoKs5DA67jHPNKLV3mEQG0rRLO5UmK3pPTBHrET9dFI8e1w4OfwRI3xilqAaU6eAbwMCfMfj8AA2PRdZPvsILOvXlkCg/w+BKUDJ7CmjKniLOPqYhA71gK4WQBSSgXgFPomHXfuZH+4kDkickyWNo9JkKa9dp4RXy9pPoPdYS3hIFbX5xLhSwh7sEk9IDv9TDkVFcgJN1rjXj8xBSWWUTuYSFdKmmZdxXMNLoC45UWM5qMuxA6AcmBQWemER4Updyo1MBXomf/Oin4PuFBCqdWDelw2Mxj5aPgAVrpmLwN127j8s9y0o3vvNgpYU47yeEiTNzAAW+q6ZVp7/n3C4i2RiOoGtrtxIva+3G8n7tUvFRgV9l50QQ22Rbm7Hkau23ja7e9MIj+XE7IyYZkGk/cAB11oapSOQW8l5u61gC+rhNk3ItJhFDU+McGevAXmxD3BSM13mbp8w5VsVFED23JBkav1O/TAQRxTpdKzNE+jgix1QXoEZ3OOvvEe5jkBQD+MJyK6h4Mjjsy9a9Xl3ZSid/G5ZIbcAfAyuLG8Ge4kALnIuBQRzTv5n7B4TCg/Q8UmxSOr4cfDQba6jTc9wwqp3uwc+Z56uATCyDY/JDxqSwvOthGs99/l4vzj387PYtX1pBxZiCOFA5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(54906003)(8936002)(47076005)(508600001)(6916009)(5660300002)(336012)(2906002)(40460700001)(186003)(86362001)(426003)(70586007)(70206006)(36860700001)(2616005)(83380400001)(6666004)(1076003)(36756003)(16526019)(8676002)(7696005)(26005)(316002)(4326008)(356005)(81166007)(82310400004)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 10:43:54.2050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c858f6b-bba3-478d-e1a2-08d9ba37a157
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2651
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
Cc: Tao.Zhou1@amd.com, Hawking.Zhang@amd.com, John.Clements@amd.com,
 yipechai <YiPeng.Chai@amd.com>, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The psp bootloader functions code of psp_v13_0.c had been optimized before. According the code style of psp_v13_0.c to remove the redundant code of psp_v11_0.c.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 79 ++++++--------------------
 1 file changed, 16 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index de53ca061d88..a3e6aa17a8f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -284,13 +284,16 @@ static bool psp_v11_0_is_sos_alive(struct psp_context *psp)
 	return sol_reg != 0x0;
 }
 
-static int psp_v11_0_bootloader_load_kdb(struct psp_context *psp)
+static int psp_v11_0_bootloader_load_component(struct psp_context  	*psp,
+					       struct psp_bin_desc 	*bin_desc,
+					       enum psp_bootloader_cmd  bl_cmd)
 {
 	int ret;
 	uint32_t psp_gfxdrv_command_reg = 0;
 	struct amdgpu_device *adev = psp->adev;
+	uint32_t sol_reg;
 
-	/* Check tOS sign of life register to confirm sys driver and sOS
+	/* Check sOS sign of life register to confirm sys driver and sOS
 	 * are already been loaded.
 	 */
 	if (psp_v11_0_is_sos_alive(psp))
@@ -300,13 +303,13 @@ static int psp_v11_0_bootloader_load_kdb(struct psp_context *psp)
 	if (ret)
 		return ret;
 
-	/* Copy PSP KDB binary to memory */
-	psp_copy_fw(psp, psp->kdb.start_addr, psp->kdb.size_bytes);
+	/* Copy PSP System Driver binary to memory */
+	psp_copy_fw(psp, bin_desc->start_addr, bin_desc->size_bytes);
 
-	/* Provide the PSP KDB to bootloader */
+	/* Provide the sys driver to bootloader */
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
 	       (uint32_t)(psp->fw_pri_mc_addr >> 20));
-	psp_gfxdrv_command_reg = PSP_BL__LOAD_KEY_DATABASE;
+	psp_gfxdrv_command_reg = bl_cmd;
 	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35,
 	       psp_gfxdrv_command_reg);
 
@@ -315,69 +318,19 @@ static int psp_v11_0_bootloader_load_kdb(struct psp_context *psp)
 	return ret;
 }
 
-static int psp_v11_0_bootloader_load_spl(struct psp_context *psp)
+static int psp_v11_0_bootloader_load_kdb(struct psp_context *psp)
 {
-	int ret;
-	uint32_t psp_gfxdrv_command_reg = 0;
-	struct amdgpu_device *adev = psp->adev;
-
-	/* Check tOS sign of life register to confirm sys driver and sOS
-	 * are already been loaded.
-	 */
-	if (psp_v11_0_is_sos_alive(psp))
-		return 0;
-
-	ret = psp_v11_0_wait_for_bootloader(psp);
-	if (ret)
-		return ret;
-
-	/* Copy PSP SPL binary to memory */
-	psp_copy_fw(psp, psp->spl.start_addr, psp->spl.size_bytes);
-
-	/* Provide the PSP SPL to bootloader */
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
-	       (uint32_t)(psp->fw_pri_mc_addr >> 20));
-	psp_gfxdrv_command_reg = PSP_BL__LOAD_TOS_SPL_TABLE;
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35,
-	       psp_gfxdrv_command_reg);
-
-	ret = psp_v11_0_wait_for_bootloader(psp);
+	return psp_v11_0_bootloader_load_component(psp, &psp->kdb, PSP_BL__LOAD_KEY_DATABASE);
+}
 
-	return ret;
+static int psp_v11_0_bootloader_load_spl(struct psp_context *psp)
+{
+	return psp_v11_0_bootloader_load_component(psp, &psp->kdb, PSP_BL__LOAD_TOS_SPL_TABLE);
 }
 
 static int psp_v11_0_bootloader_load_sysdrv(struct psp_context *psp)
 {
-	int ret;
-	uint32_t psp_gfxdrv_command_reg = 0;
-	struct amdgpu_device *adev = psp->adev;
-
-	/* Check sOS sign of life register to confirm sys driver and sOS
-	 * are already been loaded.
-	 */
-	if (psp_v11_0_is_sos_alive(psp))
-		return 0;
-
-	ret = psp_v11_0_wait_for_bootloader(psp);
-	if (ret)
-		return ret;
-
-	/* Copy PSP System Driver binary to memory */
-	psp_copy_fw(psp, psp->sys.start_addr, psp->sys.size_bytes);
-
-	/* Provide the sys driver to bootloader */
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_36,
-	       (uint32_t)(psp->fw_pri_mc_addr >> 20));
-	psp_gfxdrv_command_reg = PSP_BL__LOAD_SYSDRV;
-	WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_35,
-	       psp_gfxdrv_command_reg);
-
-	/* there might be handshake issue with hardware which needs delay */
-	mdelay(20);
-
-	ret = psp_v11_0_wait_for_bootloader(psp);
-
-	return ret;
+	return psp_v11_0_bootloader_load_component(psp, &psp->kdb, PSP_BL__LOAD_SYSDRV);
 }
 
 static int psp_v11_0_bootloader_load_sos(struct psp_context *psp)
-- 
2.25.1

