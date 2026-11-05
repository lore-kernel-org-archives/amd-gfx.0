Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707AF606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 00:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nSix9OJj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1191610FFBC;
	Thu,  5 Nov 2026 00:05:01 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011048.outbound.protection.outlook.com
 [40.93.194.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD6010FFBC
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 00:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0PDii8L0nL+SwdcRZnHes3aMypTzV2u/TFS8R+MBwWB/8Q+UlZaNcvpM17kXfcUrKxBGiY+HU7z1wsAORadjfFo2khW9TPjtACCzgOLajinQB8ONmXmY0029UYFyH2DbpW9RXg71hjDsFFb7aHmXoczCkikU7rpQLvtc6QN+RyTAtBEFfEMilBUSQDJyzwfOI8mtB2bTZkcmT5f47yyYc/dpFjDhtbWgk/5kXK90/TNhNNzIOG24gelSKcy2+4vnefkPYBnUaRoZdILTF8OImGgcTfgUMFxUsFCOcPnX20/vKRmrQBQzlZzR/3KnUXxRIgkxKgh84Yo/kOnZtl+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11CUM8pVKv1CJ78mK8/sMWRxM8IDm6N8PMOBgB6O4eI=;
 b=JqDoyFRz4RT/1BlHquBhyYyuvW0tq+mEc0/eww4RqjTTkDw4KsgIpqFSup6YdMG4bsa1V9e281mHJekvCW9ka6ZvHiUbN1c8LS5taU3YYdKknv1suRsX2jgwphUsb6aNwzsYK0w4+T0Mqk1+ZTWfN5Crx8g3PowBh0O+zceyWDmD8pB7MdSIBSAqsx1cnBGrhBkmyLOTBju/ZZqaQJTB//n5nUNFzI8Jfg/vm7i55b8GZr4Al4jn6DfYafmnNKTOVTPHpVoLeCdSo10PeHzdnr4ZlM43xtMx41sffD1UhObCP5LGxtjBLkyAAhqDKgWx6KQQb4DYrXzteR4qbxIFPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11CUM8pVKv1CJ78mK8/sMWRxM8IDm6N8PMOBgB6O4eI=;
 b=nSix9OJjaBH9ayhanTMQaZCqu9XEd7P0l9r6b7lI3dhUdqmfQZEgUU2bS59qG02qb/jhkgEIA3nz002sDvzczlJrWJXssJQXUIS/IcTeVwEAmSM3yoLPY9pLrJjaz0zn7imJ0go5nzDBx2xEKd9v95pupBRmAjzJRc7cZoDEUdc=
Received: from SJ0PR05CA0084.namprd05.prod.outlook.com (2603:10b6:a03:332::29)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 00:04:48 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::4d) by SJ0PR05CA0084.outlook.office365.com
 (2603:10b6:a03:332::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Thu, 5
 Nov 2026 00:04:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 00:04:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 18:04:47 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 18:04:47 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 18:04:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <frank.min@amd.com>,
 <Hawking.Zhang@amd.com>
CC: Kevin Wang <kevin.wang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add spirom dump support for asp 15.0.3
Date: Wed, 4 Nov 2026 19:04:38 -0500
Message-ID: <20261105000441.3850131-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|SA1PR12MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: c0335a53-4af4-4d9d-4ba6-08df3ad0680a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|261022115727099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261009223027099003|11063799006|261028144727099003|261026121527099003|261026140227099003|56012099006|18002099003|261102123227099003|6133799003;
X-Microsoft-Antispam-Message-Info: iXN61pTS5iQ1Sp2Y5yoImUXcYfkfWpfZSOSc78aptX8L3jyyFeZwr3q/VGR4Ns9qesvy8lJNNQPOS6VZacOxVDdo0LzPpgU86oyCWquFc5Qawid7lJte9MWRbNcxO/7NC9Zvs0y/rTXVv6Aonir2IafIhIqj9I8zs/axsNX9B6UWhpZpXqu0oVPS3wH5dNTn1iOzKlDcVUZwBFY1/03xmFqiw5RZQRL/SkDewSV/fZ/p8hTXYUWtOp/xwNqftLB/lluZh+e5p80DpQiH77sz4PHLVnkanHqP0sAP2vYPSnHB8RKBRfING/PCKCD4X3wklDuG6c9yTM9hV8YBY0xBZPQTZQq0mkSD2lzm1co+R+qmYDYn3nJCOKrb+89PhPwgwfwv7NI4+/wKp14KGDqhSSz9ttbcjQ0B0lsvT6xUi4ZpB1bdSAEa3pNP/+U2W0iURi+2mrl9IetafoSYjCVYUgumc0ouJOc3pKn9ppOyPa0OonNCU2tiwKXZrxe5DtL88ZF2QEH1VW4axvwFueCv872l+9oGGogpn7akUPuwrfX2OzT65c7MRwEuiXZhfhJel7MMFVxm2C/LdcOMebRxDMeOEh2/ftC8VoxOWRHLh0bibLeTtGwdnzZIFRSla6wk1y4OWD7LhwNRsKfo3bn3Qz9BZwBPZlVZzGiWRsHE0G9YnJVGXtu3EEpBVJaMrRqfZ5tFmE0xog1xvnv4MGtFFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(261022115727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261009223027099003)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003)(56012099006)(18002099003)(261102123227099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rgiW3gqodsoDdbQNqjXuYA3RATGU47nwvowmcF0GAqAoU62eroEjCo+KAFNOiXko4n4jcL+tMsjUxUgXdFZgWckHgq+8E0/ELqZTSrmEmS3m9BXSPjMfUD+e/FaKEPLlDwPhDdlRMKYAZZ8E1+7sXivN9M67A/RgtHGQB7MwfsnI093LlQsmotpUdph38h9ydIlYnI0vKnrUGzfz+qAnseUYAYWcUQ4yNusIvZ/dg8t4Glafn0BYyIgWaLKAv8osZ4ScNyglYH7yFaVvUe0K9g5QdlTPcMdTwivyaqjvxTBmkaKX7o0WLWjKbFJY/WpyvcSyuthqRFqiWw5knNiuIppFhp6IpM3iHeyuNNJRzIQACb+TykJoBeBmc3Ea+peg4ZdWqyxS2P6pykgYZMVHses0ANHUNTwQIJ4alDHvJq55ybqSA8RLGU5eVtGIDbSy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 00:04:48.1972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0335a53-4af4-4d9d-4ba6-08df3ad0680a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Kevin Wang <kevin.wang@amd.com>

Add the PSP callback to dump the SPI ROM image on ASP 15.0.3.

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c | 38 +++++++++++++++++++++---
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
index 029d4f4b09616..b5202aee40354 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
@@ -602,7 +602,8 @@ static int psp_v15_0_3_exec_spi_cmd(struct psp_context *psp, int cmd)
 	/* Ring the doorbell */
 	WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_73, 1);
 
-	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
+	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE ||
+	    cmd == C2PMSG_CMD_SPI_GET_FLASH_IMAGE)
 		ret = psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_115),
 						 MBOX_READY_FLAG, MBOX_READY_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
 	else
@@ -610,9 +611,6 @@ static int psp_v15_0_3_exec_spi_cmd(struct psp_context *psp, int cmd)
 			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_115),
 			MBOX_READY_FLAG, MBOX_READY_MASK, 0);
 
-	ret = psp_wait_for(psp,
-			   SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_115),
-			   MBOX_READY_FLAG, MBOX_READY_MASK, 0);
 	if (ret) {
 		dev_err(adev->dev, "SPI cmd %x timed out, ret = %d", cmd, ret);
 		return ret;
@@ -628,6 +626,37 @@ static int psp_v15_0_3_exec_spi_cmd(struct psp_context *psp, int cmd)
 	return 0;
 }
 
+static int psp_v15_0_3_dump_spirom(struct psp_context *psp,
+				   uint64_t fw_pri_mc_addr)
+{
+	struct amdgpu_device *adev = psp->adev;
+	int ret;
+
+	/* Confirm PSP is ready to start */
+	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_115),
+			   MBOX_READY_FLAG, MBOX_READY_MASK, 0);
+	if (ret) {
+		dev_err(adev->dev, "PSP Not ready to start processing, ret = %d", ret);
+		return ret;
+	}
+
+	WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_116, lower_32_bits(fw_pri_mc_addr));
+
+	ret = psp_v15_0_3_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO);
+	if (ret)
+		return ret;
+
+	WREG32_SOC15(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_116, upper_32_bits(fw_pri_mc_addr));
+
+	ret = psp_v15_0_3_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI);
+	if (ret)
+		return ret;
+
+	ret = psp_v15_0_3_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_FLASH_IMAGE);
+
+	return ret;
+}
+
 static int psp_v15_0_3_update_spirom(struct psp_context *psp,
 				   uint64_t fw_pri_mc_addr)
 {
@@ -826,6 +855,7 @@ static const struct psp_funcs psp_v15_0_3_funcs = {
 	.load_usbc_pd_fw = psp_v15_0_3_load_usbc_pd_fw,
 	.read_usbc_pd_fw = psp_v15_0_3_read_usbc_pd_fw,
 	.update_spirom = psp_v15_0_3_update_spirom,
+	.dump_spirom = psp_v15_0_3_dump_spirom,
 	.vbflash_stat = psp_v15_0_3_vbflash_status,
 	.get_fw_type = psp_v15_0_3_get_fw_type,
 };
-- 
2.56.0

