Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AD8C55162
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 03:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CBCF10E505;
	Mon,  3 Aug 2026 03:38:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZeG3STph";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010018.outbound.protection.outlook.com
 [52.101.193.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9240010E504
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 03:38:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAQxplSUl4TuyWYjeSgox5/th+U8mIVrlTA5jHRBpfa7IVR/SRRxVEqZdUH9kZ61SZXdnhQO2YKfQDDOavbr++sr8mXPfg45RU/ySkjdHrbprx9c8q0n1sOTQelOZ5a6mUwR4KXaghfDNeJKubZthjJlLvijsrADzA0bddLEmWupNyKmLSRDoCIKcmpwsWDBcHQSZXY27z+qc2znpsPCWSdKPzuXAY8aQsN304s8rxLC/Q1vi01TdKKavUk4NBBywxfsI+QWGAojyVLDIDfrEcSH8tl1UCn59sZ1DFuCCHnCkWgkK8DLoh+ngdZbQH5o7JoFuJ9TIcXXEGL89PNpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rexoyMyDe6X25Fv/Zsnjj4g7lL8LTtNrEOXnEuS0tc8=;
 b=zIQISzFVqnRQ/z3z6TS9a2hL0Ezlg+1bAhmOrdq53NMg9c5daCHJdRojgX/mImNB8EBr7c914jN2Z8Z1poaJPSoZRLJPuCvMuREHNltcKeGuRYxSTLsTd6F5o/Vm1GENZsR7hip8CD2ZE77pGsggAJYU1Sm46XIE7glexuoT/LLpc7PDVRfHk67Rk5ScKAZUTxY0FJX7EMqDKgz5TL65xmWORDe0o54JdxIWygtIbCVK8Qrj5m1LSNp9kkdsBDiu+QNRg6+xk6wWLJnsqghXrzJWkAf1RUsmPMbBof4ozDBB7re6l/KHJBXSmQDTzfDn/8vgMRIAsvWVG9D1A8J3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rexoyMyDe6X25Fv/Zsnjj4g7lL8LTtNrEOXnEuS0tc8=;
 b=ZeG3STph6pTbVPeEqU5bLHQggoK8OtpCc87ZhlX/LyblC+QsLrfytrbUxDqgqHdwdbsPExjAqrE/ssO2ELiueXQj5ru/5QPx8csm4EMPjr6mmGF2Wr2HB/Wz2pMk99FGe9zGzXqHBbQY0BiN8mkKYWSgzMT2qzfDtPeHWXxtTWE=
Received: from BN0PR04CA0015.namprd04.prod.outlook.com (2603:10b6:408:ee::20)
 by IA0PR12MB8328.namprd12.prod.outlook.com (2603:10b6:208:3dd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 03:38:20 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::93) by BN0PR04CA0015.outlook.office365.com
 (2603:10b6:408:ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 03:38:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 03:38:19 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 2 Aug
 2026 22:38:18 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/3] drm/amd/ras: Handle the lack of mca address case for
 uniras
Date: Mon, 3 Aug 2026 11:38:06 +0800
Message-ID: <20260803033806.2881888-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803033806.2881888-1-tao.zhou1@amd.com>
References: <20260803033806.2881888-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|IA0PR12MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: af8fd283-1edc-48c5-ab17-08def110a998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: X0uCRTjx9Tu1RgMk09fpZQOrMhX2znRSIy9gX4X34CoVK1cM2k0+fuZKP5hykJlg0ww0/jndV/i6osxvF2RNQYfB8zkRlUl+XvG7aIEAWkY/IeHNjJ0eUvDV0zgJoEnSmcMl09vt3ECjvSyRV4sDvJLtGLLCY670EYE44mk1rL0HV5gKUtbl/dKp2jpdnM8R+anB+K0ZnN8VPGdmYQ8hWSSjEpa5iF9YXwhWVqe1TYAkaRSqSLBR+2T8jf0NmPtZkics9j4zNgh+2p3z6WPyIMzGS7aFnreE4la2ZeXgYSOj8hI+tjzQIjkxG3SJ6qx2vhOXBBOUxIkVsb0JLAxe5nXrhPImeCjdRNPi4FqdvNUZLvffaNU0iz26gWcBtg64K264HvXdopCYCY6vVJLjh5Mg2KPzDvdfauUvWGJwWzbAefQkWGxXHf5brmyxMJcfLgAPpobhaHH1eVf8qyodWdJFTbINBvSo+JVb2vDznaNo3IRP/HfwLEcz2RiWZJh9+CbZZJSLlOiyaPqjNeORU+KqigIH/9ye2suvcLmH881FMJfgXbeJMQ8FPuE3P5BiigFp0Nh+O6og4sy6/i1v5DU+lcojzdTnJmmLw3tJ0Vy8KYeTiBvNOsivUs0WQGlKbawGeUdy4srChZImbQwlnW4OXZx3s14xZOT9Xav71geRPISt/LKgJ2ajG5qCKm3Yq0iHCrH4tE0sM5OtMRk95w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0sIzSwTrrEjbXNhXKfbiFZIHFOgEaMO3xUhgAEgrrK6oDertBxPPyWnB1T+w4no1jTW/BHfm6iBAeWWz2XJa+4RbcXQd1zRC4J3oRPMHwOq2I9JDKzvwpqh/K9LENNQO7AA2+0OwFk1aaqfsPNY69xnX4V+v0ZfP2GYHLkC+oeWPO/cGbd7tbRwYDNJk3YaLl/8EEIpVjkwZl73Jyu7tG+1zUlwelZ6HfHqFDzFg5QhGWGdFXL9GF5EH/dOHt9H2AWtTFFkL9h4s6o01I0xC9qj4drQ1yALSJRBabg5IGKDB09AyzgtqbQPxQJRblQ1QR3IoiRe4O28PKe8sFZUwTxeA2V4+7ScuBIhJqQPz4Y7J08GyksrnusVKWVTLeu+zdECAQa53RejKexUmhoLlbahE7XLH39pRw4L8ZZPF0NtJwtFQ2OGpaSOmY5xopOII
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 03:38:19.9882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af8fd283-1edc-48c5-ab17-08def110a998
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8328
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

For specific old eeprom data, mca address is not stored, get mca
address from physical address(pa) and then convert it into pa in
current nps mode.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c | 38 +++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index becbf8d2d09e..c3cd1e84468b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -323,6 +323,31 @@ int ras_umc_ma2pa(struct ras_core_context *ras_core,
 	return ret;
 }
 
+static int ras_umc_pa2ma(struct ras_core_context *ras_core, uint64_t pa,
+		uint64_t *mca, uint32_t nps)
+{
+	struct ras_ta_query_address_input addr_in;
+	struct ras_ta_query_address_output addr_out;
+	int ret;
+
+	if (!ras_psp_check_supported_cmd(ras_core, RAS_TA_CMD_ID__QUERY_ADDRESS))
+		return -EOPNOTSUPP;
+
+	/* nps: the pa belongs to */
+	addr_in.pa.pa = pa | ((uint64_t)nps << 58);
+	addr_in.addr_type = RAS_TA_PA_TO_MCA;
+	ret = ras_psp_query_address(ras_core, &addr_in, &addr_out);
+	if (ret) {
+		RAS_DEV_ERR(ras_core->dev,
+			"Failed to query RAS MCA address for 0x%llx", pa);
+
+		return ret;
+	}
+
+	*mca = addr_out.ma.err_addr;
+	return 0;
+}
+
 static int __eeprom_rec2nps_addr(struct ras_core_context *ras_core,
 	struct eeprom_umc_record *record, uint64_t *pa,
 	uint32_t nps, uint32_t die_id)
@@ -389,6 +414,7 @@ static int ras_umc_eeprom_rec2nps_rec(struct ras_core_context *ras_core,
 	save_nps = EEPROM_RECORD_UMC_NPS_MODE(record);
 	/* eeprom v2 has no stored nps, always convert if the flag is set */
 	ch_idx_v2 = record->retired_row_pfn & UMC_CHANNEL_IDX_V2;
+	record->cur_nps = nps;
 
 	if (save_nps || ch_idx_v2) {
 		if ((nps == save_nps) && !ras_fw_eeprom_supported(ras_core)) {
@@ -400,6 +426,16 @@ static int ras_umc_eeprom_rec2nps_rec(struct ras_core_context *ras_core,
 				record->cur_nps_retired_row_pfn = RAS_ADDR_TO_PFN(pa);
 		}
 	} else {
+		/* for specific old eeprom data, mca address is not stored,
+		 * calc it from pa
+		 */
+		if (record->address == 0) {
+			ret = ras_umc_pa2ma(ras_core, record->retired_row_pfn,
+					&(record->address), UMC_MEMORY_PARTITION_MODE_NPS1);
+			if (ret)
+				return ret;
+		}
+
 		/* old eeprom data format, the scope of channel index is
 		 * limited to umc instance
 		 */
@@ -407,8 +443,6 @@ static int ras_umc_eeprom_rec2nps_rec(struct ras_core_context *ras_core,
 			return -EOPNOTSUPP;
 	}
 
-	record->cur_nps = nps;
-
 	return ret;
 }
 
-- 
2.34.1

