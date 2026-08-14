Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492F7C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEAC910F713;
	Fri, 14 Aug 2026 21:03:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fh74Ym7V";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013028.outbound.protection.outlook.com
 [40.93.196.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BEAE10F713
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/DvSZ3Uqbn8HLkvQWVIvWQx/SpyzsH+RLo8TaPmC6SFPj7dGrLkOMPonwHd+C7vagk3xiZ40vEuSUOkuXdXV+DUWN4A4TPfGea+stU8G0IsAkR0H7/dkbff3hjBxyHlJh4FpNwpq+HNAYjKDwz4iYBg8juwkiF1K4ZL1bCc3mNYsmeB6Ej7jvWMwZCEKrD/RuauTl36w8csmQxvTMZEbyhJSyqUTZVjjfpBGSQaTkTGlGxVY4Lg7U+gznVFrF8htXw7OfuCs1IMeLKWPTUokS+y0X8sfDc6SiDcu7FKhJ4HfQ3DYrlYx2NPEb4jmaJJBqJhdYShCYBXOaQIvPyPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5quA2hESwE++8CK2QNJTaCt+KPIe1VrNlaEY8ARvQiA=;
 b=rEOUeRDZjOK8+gvPH6iyjihKPbo7fp95EHb+Ak0zvReXcusbnIohzTzoqyICy2qs+hx+E5VJz6bD5SXQA9K8AxUtOCQ18uhdUWadotnQQ1CaKBuYnGSUzDFu+4N25n5E9L8wrD4YNoWD2c+w4xnpNsGZWy2sAXv+9BdPNDHnFgMZPXYbFCc1cHTD3NbbGVoW5lR7E5LvBIf2lwhOUdguP7MKoBjxa5ZWSTZWtGsa5SxTWYmh7zSG6kqK2oBdaIMKqk/axLwimTzo6pScEDrkMbBBpNk2gkpgc47+AOIRXSkF6ipAMrf+9AYFhLUXTNGnyYqOSxRIp89fUtxnixxZjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5quA2hESwE++8CK2QNJTaCt+KPIe1VrNlaEY8ARvQiA=;
 b=Fh74Ym7VsZH7qrVz7qWOuHTQ+cw3jqWXosyBvedVvp44sFfPXtq7EZhUNPNxHsvJuJe1nTIzG1D7kBTqIqnHM+kWd3rbg9CMYnw3eza0ce/eWXbDe0kpu8yjt8tM5PzWrcCRaVx3qkmm5R4euXLT9sgRHvtuMEBwERptBreuvbo=
Received: from CH2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:610:4c::23)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:35 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::27) by CH2PR10CA0013.outlook.office365.com
 (2603:10b6:610:4c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 21:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:27 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 050/109] drm/amd/ras: Support obtaining bad page info at boot
 time for ras_mp1_v15_0
Date: Fri, 14 Aug 2026 17:01:47 -0400
Message-ID: <20260814210246.3067612-51-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: 1687abb7-4abc-4c5c-cdc5-08defa4781ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Uohx1w2FAnQnu1bEx1H0PE/hwzdV87hMan+qFEncbYbsTSODAsxG295YYdnEQF/8Lm4yX7LkoSsuiIMgMnW+Bxfxcojy5QCB0poEkORBNC3n0THS8qEGkY+boTS51l+QlOMkLhO064sm6YtRzvYJzpcOMIpynnPp15GUP91jMTdvLOClqeJPEtew5EgdbZKvzk0ptqP91QMIq8+2ZaaqDWhnvj3UD7bQ+uBG1PdEyCTEp9KLjK3EMjC+WiBxdNhn3q3ajLl48fGVPWubdy7gGlW+rhYbS742zG8Yu/mx9IZRPVgDjKgBWZxbZy46ZWbCw3tbIUa1uvQ8CB8MK2pW4i1NTe1ZQM8d7E3RPZDp6nTylifKUOA56bGs+rh04labK4CdhVYyQPWl5NRWN6ZYX+hg6HeA/XRQWrQXDPxO8eSKbBnuMtBNSD9vqpe4cptblTIpSzZRgvMByOO9/BSP/r5o91bEEc/RoUHGx+MgPxI35f2Dq+cMfSD73xjotI1UD8cWSwk9Srq68ocCLzFGWUx1WVK7G/c7eBuDqOmcSUAnNg2y4Epl54vUy18KbfUbzVwQdvV/xbMeaKCRhStRWeB4jP3qin8k/HxxZ+z/3BGrDY3JchRWbcxeyqV7CIzkZ7y7VJ+KruJ1lRu6CIomzocvbHzZ5hJD5EdrhjnN89U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VWhB/3gqY4fyJc1UNyn1ZNfcCiyuLn+jkzw2MVLuc8GCt/Wn3O6UKgOmGKAXjucHTe8o23v4jgXrBdBxPE36pzB8eul57uDE5VREl3wSk5JUjvfXUk2ksg9QUp+RuSnKKQ0CNDg7gvK3evuu7TpN+zPEPXmoA2FYt4Bv9WeDpm/zk1u6FboyNJ0J58sCeErYwIvUVAiqPPy7Tl2xgZWJzaAvxrqWR13PNDLygCq8VR0SeJf4ex4aMsh1pIsq4hjHzIiLpMKKTMr+PBSjk4ExWHvoKUPtAZMO4FhGYQ7G9X/Hfa3ghCwFPcxEnwf/XronTo1KVrazhlEWbGSx5K8tGQn8Iqvu02p5ogFQtzB/btjiMSv/Zg/L2gzbsLqBm36LoNn/ENf+P/6fyu7GPJGbeznt/SajHq4S4Pe2suS4FksG0ojidVvVaqCrS9TQeFUi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:35.7932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1687abb7-4abc-4c5c-cdc5-08defa4781ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Support obtaining bad page info at boot time for ras_mp1_v15_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c | 71 +++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c b/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c
index 2cd0f266b5855..fc977396d9cb0 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1_v15_0.c
@@ -29,13 +29,82 @@
 #define MSG_DATA_LOW32(idx)   (idx | (0x1 << 16))
 #define MSG_DATA_HIGH32(idx)  (idx | (0x2 << 16))
 
+#define regMP1_SMN_C2PMSG_40                              0x0068
+#define regMP1_SMN_C2PMSG_40_BASE_IDX                     2
+#define regMP1_SMN_C2PMSG_41                              0x0069
+#define regMP1_SMN_C2PMSG_41_BASE_IDX                     2
+#define regMP1_SMN_C2PMSG_42                              0x006a
+#define regMP1_SMN_C2PMSG_42_BASE_IDX                     2
+#define regMP1_SMN_C2PMSG_43                              0x006b
+#define regMP1_SMN_C2PMSG_43_BASE_IDX                     2
+#define regMP1_SMN_C2PMSG_44                              0x006c
+#define regMP1_SMN_C2PMSG_44_BASE_IDX                     2
+#define regMP1_SMN_C2PMSG_45                              0x006d
+#define regMP1_SMN_C2PMSG_45_BASE_IDX                     2
+
+#define MP1_RESP_OK  1
+
+static u32 ras_mp1_msg_codes[RAS_MP1_MSG_MAX] = {
+	[RAS_MP1_MSG_GetRasTableVersion] = 0x1F,
+	[RAS_MP1_MSG_GetRmaStatus] =    0x20,
+	[RAS_MP1_MSG_GetBadPageCount] = 0x21,
+	[RAS_MP1_MSG_GetBadPageMcaAddr] = 0x22,
+	[RAS_MP1_MSG_GetBadPagePaAddr] =  0x23,
+	[RAS_MP1_MSG_SetTimestamp] = 0x24,
+	[RAS_MP1_MSG_GetTimestamp] = 0x25,
+	[RAS_MP1_MSG_GetRasPolicy] = 0x26,
+	[RAS_MP1_MSG_GetBadPageIpId] = 0x27,
+	[RAS_MP1_MSG_EraseRasTable] =  0x28,
+};
+
+static int __direct_send_mp1_msg(struct ras_core_context *ras_core,
+		enum ras_mp1_msg_id msg_id, u32 input, u32 *output)
+{
+	u32 msg_code = 0;
+	int timeout = 100000;  //100 ms
+	u32 reg = 0;
+
+	msg_code = ras_mp1_msg_codes[msg_id];
+	if (!msg_code)
+		return -EOPNOTSUPP;
+
+	/* Send message and parameter to fw */
+	RAS_DEV_WREG32_SOC15(ras_core->dev, MP1, 0, regMP1_SMN_C2PMSG_41, 0);
+	RAS_DEV_WREG32_SOC15(ras_core->dev, MP1, 0, regMP1_SMN_C2PMSG_42, input);
+	RAS_DEV_WREG32_SOC15(ras_core->dev, MP1, 0, regMP1_SMN_C2PMSG_40, msg_code);
+
+	/* Poll MP1 response */
+	while (timeout--) {
+		reg = RAS_DEV_RREG32_SOC15(ras_core->dev, MP1, 0, regMP1_SMN_C2PMSG_41);
+		if (reg)
+			break;
+
+		udelay(1);
+	};
+
+	if (reg != MP1_RESP_OK) {
+		RAS_DEV_ERR(ras_core->dev, "MP1 fail to ack 0x%x for msg: 0x%x, 0x%x, %p\n",
+			reg, msg_code, input, output);
+		return -EIO;
+	}
+
+	/* Read output data */
+	if (output)
+		*output = RAS_DEV_RREG32_SOC15(ras_core->dev, MP1, 0, regMP1_SMN_C2PMSG_42);
+
+	return 0;
+}
+
 static int __send_mp1_msg(struct ras_core_context *ras_core,
 		enum ras_mp1_msg_id msg_id, u32 input, u32 *output)
 {
 	if (msg_id >= RAS_MP1_MSG_MAX)
 		return -EINVAL;
 
-	return ras_core->ras_mp1.sys_func->mp1_send_eeprom_msg(ras_core,
+	if (ras_core_in_early_init(ras_core))
+		return __direct_send_mp1_msg(ras_core, msg_id, input, output);
+	else
+		return ras_core->ras_mp1.sys_func->mp1_send_eeprom_msg(ras_core,
 				msg_id, input, output);
 }
 
-- 
2.55.0

