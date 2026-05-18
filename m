Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD11CCD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 09:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BEDF10E778;
	Mon, 18 May 2026 09:41:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GoafC4ry";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E322010E778
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 09:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3EpIJxRBpc1T/WK61qShWeUDYfR6togAhhiZEIY6XiOG5BUxUTr2M7npZJ/V2nmxUFTxvoUgVVduogpQ5w50hSrhsMlEBd0iF0/RNKnqYibhlTaEfpOstlN/Rgti951ElqzeHT/7/UsZHzfgrGUIaI6Ad55r5A5ilqJJlj/Kmq+NozFk732PtB7dWeXo91Cd73vTEkfCYv/hI5TxakzB8hZs+k+DzJuJhEKFj0u2Ga6IxmKV9cEv/XeqIbwyC2VfeBu29e9WNaoqTxXHzDUwm1TJE8N8tVIsYLY6rxLsVB2sPjWVeVpTZOiHvrt1eKdH0GyFoimWvpkhnSrQw5RSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPjHrvRlZHfW5CPsfXjQRN56KlAnLhYXd78lZMSTOWM=;
 b=DnOmljjXj2gX7exxsC0jEVrkCJtGoBbpXU82YkwB/MyYvGYncRYpF97fs5OyUxDxKdub7A+2ByfTLLMkYCUFuebUkUTrOuIjfOkqp3OT9bBQMCMaNPcVvesmgpG6DPk4eVwrp4QBRQ1HuelpNn6Fuvoeaxrn2YZj9N+//lflxNdzjPHSr00s7x/0uoPAo4tlTV7/bT8EhUBduAVOFFrgt0cyNNNfR2ocqyHt7TSunw6sF3hh5ZbtNHkct4qrXdRAYvDdeZ00ND1x+6EZ0AH1MFM3pXO6bMpLTE2323YF9Mc0APsph3CWimiBmy76fUE/lKSY4Cq5ew58UwgwwI9Ilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPjHrvRlZHfW5CPsfXjQRN56KlAnLhYXd78lZMSTOWM=;
 b=GoafC4ryjI/qqx41G40U93hpTf4jjfiI+X66rqybOx+D5s416dl5yan8+ewnr3WjVN80VAv/cD8I4hK1oy/StPvz/zdwM8jK0MTizXhMO7ojWif7zUHUqs8rnibnSy11X4CjJXZ40NyzCNwZmDQ9V9WuqQWucn/ivG4cm2G52/Y=
Received: from BL1PR13CA0350.namprd13.prod.outlook.com (2603:10b6:208:2c6::25)
 by BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 09:41:52 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::87) by BL1PR13CA0350.outlook.office365.com
 (2603:10b6:208:2c6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Mon, 18
 May 2026 09:41:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 09:41:51 +0000
Received: from stanley-test.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 04:41:49 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>,
 <Candice.Li@amd.com>, Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: harden FRU PIA parsing with bounded helpers
Date: Mon, 18 May 2026 17:40:21 +0800
Message-ID: <20260518094021.280968-5-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518094021.280968-1-Stanley.Yang@amd.com>
References: <20260518094021.280968-1-Stanley.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|BL4PR12MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: f3646ca4-3310-4eb6-04a8-08deb4c1b0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: mmZFULY5UODcrjTADrMH6yNctCb8blHf+R0xIfXKOgkJVgmK7z1yC54cDatoTSFKFF3mI0bOgjx6ecOEdnySbJHBrk6okvbTPNW5TTMW5FNyRidIGrh4cJA1zqg8hSFRA3m6i82RxLTOni2fCgpOYkE3kdzYAfzrDYY1Sh+AiFohOup6vnc4ZVjroAjxzCU1avh1nmwg8oJ//ddcoL5DCoL7/ARNCn/wDpFpfWTFmpKVA+UpmfmVYBqilXf0h7pXPhEqXa7mbjzY4LAXryEo0RveOAelQtnN9Lw87oOD7UoG6J9UFh//+87zGdzLE1bpqtWoWEIIRHBejBaZkPXMEdkATnvmUXLSrucXNF0pNqVp4sreUOYHu+ccMVCjAPqiRYhJf/aSe63YGaVr43SNqwoUSplxoW/4EhBYaoEOHxMc0+xxvYIbieJsclwuLRuWPGLqGgYm1kapJ5cijjgRTsGFeJwfsAoLI4E3Cf9hBX8T0yTM/9mO0/A6bVquMnlt35TLdD0P6aAnn/5I/uD1rxLnOOzZ+rwK02ZSytH4YTd4lk2I6bf7HMEsZe5/nOfIjnJprPaPj0cOVQo7H/XwDys4ZHJCOOU+vedvElxgFP0kto3T3bmFpRdeAqQnp++VSO3oxri5W0RQYUy7Ndr9Z2XEk1sFrS3JOHBQbrIoG3TWvX5Y5nwnzwblLr7kHMLDsX7fqyRXoXeVBLlRyKhYBmvMU6+Jc4EtdJKyfdRRRWQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2uSLvhG6eR+Mq24FwCoKrLSb7kwWIG4qEEGRRM2ZN06sEtd1vrdudjZt0bUTqKUwhylu9h0SICfy6dncou9JtC0Rl0aVJ4lt6+YvTjTlQqmgcP/iIUxvAH5Q7vGnwK0N//zkgDv4g9g1wmF/4E/VUKRph0o+PA64rZd6Nse3zcZF3sdBAjjV0yxF+0Ri2Obk4a7aIVArCz7K62mBYOAfrMUnQuNMjB/a6+ygfOhyJxbqVq4GIsSLpeMPEZqBarW2CJ7BXT328dVkujTdQTflt24q4Q0Npf0jdYw0PuN+4RMHE6pSW55TqbuC+I2NAdZk9RyWRpR6omPHVL5Zt0mRlKjNzdWYoI4i8MFf9emmxQh+tDSAlmQP26RU+76W7qkUF6ooyWIQAU9LLywCO5cRansvz9jOy33P6hFDm3XL8Xduq6HVOtlq5PBYbhxTvSdB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 09:41:51.9953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3646ca4-3310-4eb6-04a8-08deb4c1b0c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505
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

Replace the open-coded TLV walk with fru_pia_advance()
and fru_pia_copy_field() helpers that bound every read
by the actual EEPROM data length, preventing out-of-bounds
reads on truncated or malformed FRU data.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 95 ++++++++++++-------
 1 file changed, 63 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index c5178e2b794d..86b2d5a79993 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -115,6 +115,43 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 	}
 }
 
+/*
+ * IPMI FRU Product Info Area fields are TLV: one type/length byte
+ * (low 6 bits = data length) followed by that many data bytes. These
+ * helpers walk the cursor and copy a single field while bounding all
+ * accesses to the actual buffer length read from the EEPROM.
+ */
+#define FRU_FIELD_LEN(p, a)	((p)[a] & 0x3F)
+
+/* Advance cursor past the current TLV. Returns false if no more data. */
+static bool fru_pia_advance(u32 *addr, const unsigned char *pia, int len)
+{
+	if (*addr >= (u32)len)
+		return false;
+	*addr += 1 + FRU_FIELD_LEN(pia, *addr);
+	return true;
+}
+
+/*
+ * Copy the current TLV's data into dst (NUL-terminated). Returns false if
+ * the TLV header or data would read past the end of pia.
+ */
+static bool fru_pia_copy_field(char *dst, size_t dst_size,
+			       const unsigned char *pia, u32 addr, int len)
+{
+	size_t fl;
+
+	if (addr + 1 >= (u32)len)
+		return false;
+
+	fl = min3((size_t)FRU_FIELD_LEN(pia, addr),
+			  dst_size -1,
+			  (size_t)(len - addr - 1));
+	memcpy(dst, pia + addr + 1, fl);
+	dst[fl] = '\0';
+	return true;
+}
+
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 {
 	struct amdgpu_fru_info *fru_info;
@@ -223,52 +260,46 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	 * Read Manufacturer Name field whose length is [3].
 	 */
 	addr = 3;
-	if (addr + 1 >= len)
+	if (!fru_pia_copy_field(fru_info->manufacturer_name,
+				sizeof(fru_info->manufacturer_name),
+				pia, addr, len))
 		goto Out;
-	memcpy(fru_info->manufacturer_name, pia + addr + 1,
-	       min_t(size_t, sizeof(fru_info->manufacturer_name),
-		     pia[addr] & 0x3F));
-	fru_info->manufacturer_name[sizeof(fru_info->manufacturer_name) - 1] =
-		'\0';
 
 	/* Read Product Name field. */
-	addr += 1 + (pia[addr] & 0x3F);
-	if (addr + 1 >= len)
+	if (!fru_pia_advance(&addr, pia, len) ||
+	    !fru_pia_copy_field(fru_info->product_name,
+				sizeof(fru_info->product_name),
+				pia, addr, len))
 		goto Out;
-	memcpy(fru_info->product_name, pia + addr + 1,
-	       min_t(size_t, sizeof(fru_info->product_name), pia[addr] & 0x3F));
-	fru_info->product_name[sizeof(fru_info->product_name) - 1] = '\0';
 
 	/* Go to the Product Part/Model Number field. */
-	addr += 1 + (pia[addr] & 0x3F);
-	if (addr + 1 >= len)
+	if (!fru_pia_advance(&addr, pia, len) ||
+	    !fru_pia_copy_field(fru_info->product_number,
+				sizeof(fru_info->product_number),
+				pia, addr, len))
 		goto Out;
-	memcpy(fru_info->product_number, pia + addr + 1,
-	       min_t(size_t, sizeof(fru_info->product_number),
-		     pia[addr] & 0x3F));
-	fru_info->product_number[sizeof(fru_info->product_number) - 1] = '\0';
 
-	/* Go to the Product Version field. */
-	addr += 1 + (pia[addr] & 0x3F);
+	/* Skip the Product Version field. */
+	if (!fru_pia_advance(&addr, pia, len))
+		goto Out;
 
-	/* Go to the Product Serial Number field. */
-	addr += 1 + (pia[addr] & 0x3F);
-	if (addr + 1 >= len)
+	/* Read the Product Serial Number field. */
+	if (!fru_pia_advance(&addr, pia, len) ||
+	    !fru_pia_copy_field(fru_info->serial,
+				sizeof(fru_info->serial),
+				pia, addr, len))
 		goto Out;
-	memcpy(fru_info->serial, pia + addr + 1,
-	       min_t(size_t, sizeof(fru_info->serial), pia[addr] & 0x3F));
-	fru_info->serial[sizeof(fru_info->serial) - 1] = '\0';
 
-	/* Asset Tag field */
-	addr += 1 + (pia[addr] & 0x3F);
+	/* Skip the Asset Tag field. */
+	if (!fru_pia_advance(&addr, pia, len))
+		goto Out;
 
 	/* FRU File Id field. This could be 'null'. */
-	addr += 1 + (pia[addr] & 0x3F);
-	if ((addr + 1 >= len) || !(pia[addr] & 0x3F))
+	if (!fru_pia_advance(&addr, pia, len) ||
+	    !fru_pia_copy_field(fru_info->fru_id,
+				sizeof(fru_info->fru_id),
+				pia, addr, len))
 		goto Out;
-	memcpy(fru_info->fru_id, pia + addr + 1,
-	       min_t(size_t, sizeof(fru_info->fru_id), pia[addr] & 0x3F));
-	fru_info->fru_id[sizeof(fru_info->fru_id) - 1] = '\0';
 
 Out:
 	kfree(pia);
-- 
2.43.0

