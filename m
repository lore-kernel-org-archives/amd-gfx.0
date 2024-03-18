Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EA5C54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 18:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A76110F846;
	Mon, 18 Mar 2024 18:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gE1sicHb";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C2C110F846
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 18:56:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl/zKSCxdC6BPuhtkyVSsSWYZIXJWI2B1u0Ely49OHJMDJ4cXbUWhZrsg5XRnibbOCqCAt3i8IR4GgS4lJm6kdiee9x0zrjStxVh6Ih9fJjQtLABDCA5MLRLxqQTNFncCulctaQ6gLY9bmWWB7L2Df2VHc1wPD8ND5AJNOSeqAE+A6kGstiRn2OdTx0evdZfrYGUxZZhFuoOwf0HlBHbekG9VgAU5uhX7WgtXCfkS0T9U6Rpc2tKMQd5YElof8k7UNyP1j5rtjjF1pWxNosrXN96tZwH8IQNH8aff3iHUW/3anP2othNx22fp0YbowetGxm/sMEIH4+brqM2E1jl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i09RkYTXa3h2B36RNiQj+pcSBuoOBGtvVON6CylIVV4=;
 b=JACj5tZ/p6/VaUnY6rwGeZJndUbu9hLXqiO+SpgkY7scIjTxwf9Y8PWx7/WgpLkJpfvY5lR6l7gihsaaKd+ZQXq5gmxZNyIshmebPLj1+Qm5SH6l/+MHfueziU13g39oLaLTuiWCq6WxYp7/RsYl8wtVQOrBqBCynprSs+FPl9IHqA6NZcD8Q+7/mh2wy38N6c9Q82tj5GImavbQ3qEeVfXuDUebcAe7r6U9Aa/xNv3tOxc111DKD3qUIqq1ObXcNYKSgvWMuL6wBEdkuNb62yUeyx+LH72F/4GT23CvPjRMF9wd53NOZ4VAhwH32LbQkMSg5p172PRr4OP2via3tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i09RkYTXa3h2B36RNiQj+pcSBuoOBGtvVON6CylIVV4=;
 b=gE1sicHbsk1prbAimiWhR0mCYT8ZqrSUbanL2oOB4vZkzQ1z7xqIXqnzfoZ1cSyrhQzgoOQS0ar84ghEko+e1XFhzp4MrakEkwhIQEcr0nRKJGQnz1k37aNgCGD5AtNlW/TsHR+ZYFE12RT638PHn0QBP3PSFUXyMYI7YArCo+E=
Received: from BN8PR15CA0014.namprd15.prod.outlook.com (2603:10b6:408:c0::27)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 18:56:39 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:c0:cafe::11) by BN8PR15CA0014.outlook.office365.com
 (2603:10b6:408:c0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 18:56:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7430.0 via Frontend Transport; Mon, 18 Mar 2024 18:56:39 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 13:56:35 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <samir.dhume@amd.com>, <lijo.lazar@amd.com>, <gavin.wan@amd.com>,
 <leo.liu@amd.com>, <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
Subject: [PATCH v3 2/3] drm/amdgpu: sdma support for sriov cpx mode
Date: Mon, 18 Mar 2024 14:56:14 -0400
Message-ID: <20240318185615.880473-2-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318185615.880473-1-samir.dhume@amd.com>
References: <20240318185615.880473-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: b98f9626-9009-46ba-1bdc-08dc477d24cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARD+lvVfwRH0msA4QpmTKBEchrIypTd3IFSkpQkiPOGu/iWK94RgxHGTIn7T7Sj6uUnaj2npBRYJYMgaTUpGQgPkDtf1sagqknVn59zA/NTK4QEpYTvyTypDdPW6r508yKl7lMbp1hP8bYITaRkN1WiqqEqVHxhi737HxjKaQONGSFSpN1DxekaO5vksIhQS1zYKQPR3GKh6gHv0tXD3CMUokkHZCcJIdiLHFiTb9CKjj9IG6hnPoQ6yG+otdumoNscXlV2qxPrTe9eHTOQrvI4z21ROFF8MGoebazzrRFk4Kwe8Opo1+y1pHFW2JGTVWv4l2YlfP/MeKQcjIHyOUL6+Mq9Dji1VDLnNuAEX69ZO/gi88f2Q353IVSCfIwGvsZe2OL69eOigkPHMLYZKqBKtMVNsLlE0BrzzyCYqZv2zLKGetuFUojz2BohrOlKZ8IwMsO3pSxxwX6mmVYOoG420xhriualMPsvNH/c42sBV+nPHmYcKAvrCkVJuw3bjZp2FWitCSkFjQ/7ZGteR5sYyEq2puMhrXnm46Ffh6QgScHqopfq7MAjFrQxwkxRsx7kI525ZPIo1V/uPjpf9A+hSs7pinApLtgqahPypH6RKQxyslO49sp6KK2bYUzEmkhkavkb6BJXxO4ZBqlc95db3G16TULJlu4KhnNTA49C7kkPUopkMGj2Km8fud4v4Waw7W6c+EysOT6mWOGtBUgbzqiLO70TomSVmi6i6ypuRnIgu4JW9Aispe0qgXKQG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 18:56:39.1264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b98f9626-9009-46ba-1bdc-08dc477d24cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025
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

sdma has 2 instances in SRIOV cpx mode. Odd numbered VFs have
sdma0/sdma1 instances. Even numbered vfs have sdma2/sdma3.
Changes involve
1. identifying odd/even numbered VF
2. registering correct number of instances with irq handler
3. mapping instance number with IH client-id depending upon
whether vf is odd/even numbered.

v2:
1. fix for correct number of instances registered with irq
2. remove mmio access from interrupt handler. Use xcc_mask to
detect cpx mode.

v3:
1. restore all instances registered with irq in case there is
harvesting of some sdma instances.

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index eaa4f5f49949..01d1024e91ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -82,7 +82,7 @@ static unsigned sdma_v4_4_2_seq_to_irq_id(int seq_num)
 	}
 }
 
-static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
+static int sdma_v4_4_2_irq_id_to_seq(struct amdgpu_device *adev, unsigned client_id)
 {
 	switch (client_id) {
 	case SOC15_IH_CLIENTID_SDMA0:
@@ -90,9 +90,15 @@ static int sdma_v4_4_2_irq_id_to_seq(unsigned client_id)
 	case SOC15_IH_CLIENTID_SDMA1:
 		return 1;
 	case SOC15_IH_CLIENTID_SDMA2:
-		return 2;
+		if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask == 0x1))
+			return 0;
+		else
+			return 2;
 	case SOC15_IH_CLIENTID_SDMA3:
-		return 3;
+		if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask == 0x1))
+			return 1;
+		else
+			return 3;
 	default:
 		return -EINVAL;
 	}
@@ -1541,7 +1547,7 @@ static int sdma_v4_4_2_process_trap_irq(struct amdgpu_device *adev,
 	uint32_t instance, i;
 
 	DRM_DEBUG("IH: SDMA trap\n");
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 
 	/* Client id gives the SDMA instance in AID. To know the exact SDMA
 	 * instance, interrupt entry gives the node id which corresponds to the AID instance.
@@ -1584,7 +1590,7 @@ static int sdma_v4_4_2_process_ras_data_cb(struct amdgpu_device *adev,
 	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA))
 		goto out;
 
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0)
 		goto out;
 
@@ -1603,7 +1609,7 @@ static int sdma_v4_4_2_process_illegal_inst_irq(struct amdgpu_device *adev,
 
 	DRM_ERROR("Illegal instruction in SDMA command stream\n");
 
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0)
 		return 0;
 
@@ -1647,7 +1653,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
 	struct amdgpu_task_info *task_info;
 	u64 addr;
 
-	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
+	instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
 	if (instance < 0 || instance >= adev->sdma.num_instances) {
 		dev_err(adev->dev, "sdma instance invalid %d\n", instance);
 		return -EINVAL;
-- 
2.34.1

