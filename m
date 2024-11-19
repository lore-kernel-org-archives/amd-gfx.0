Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A26D591D3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC23810E5C7;
	Tue, 19 Nov 2024 06:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wk5lBCMu";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1757910E5C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwWZIPxDmDyOYeVq6k+q2VRt34q5KwDxId9v0aj8MEv70kUBfmSnMPlyMSjzvPn/MNMgpjDlVy8fdT5wDnc+Qgif2+bIN0cuoPfvS5RBn90rhqX+Wykcha7qAe4I8YmZA9pbBjB6U9VoC5M7pDIgPiJJ9sBiSg7gqwYQlt3/EhHUitATTZpaqw3leW05twuOFFFgiGrDqAI36YUrW25seWAxKPOOr6ec2q93E06KrU6MyDJQL5TC8meNn/QOgpshlCUt+ztmIxKtRERoRtQ2VROCURiRt3JdLki8XWwVjFbOvGiLPfBdpY4IO8jHLHooQuEfS6TNXMZ8uFMkGsZ1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhxJsZNdB2xzHmS/pJGqKWoLCrPchDjVYr1cO66YqYw=;
 b=Lx1wJCBPOXGo6miPS/DMtm0bxfLmrCScPZ1BJp14SFWCSFYi0flem6qTUFSJScgJs65mjzf+MXTavviTUd74KRbRQkkwNjJMG3FFd0RXVd8X3RIbS+SLaI8s42xmxQoO7uUGA67SXXAKmEEm5zQdKTJ92mEeBJghEapjeK7JO9uGqu42EuaGwLzdBVoE6MFNK0bxgCT0UlOQMPs7gKN3SyVBX6D/8x+WejHXZLlhJja9nlgolpiOzDuEJRIFSFS9Qg4IqIGSKoFJvc7XE4jXg/ptnKZUWg6+xr2sLfNF+RppqN187FxA5YufyTlaueJK+0ui1rkAJWq5cy84/R4Q/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhxJsZNdB2xzHmS/pJGqKWoLCrPchDjVYr1cO66YqYw=;
 b=Wk5lBCMuGwTTANsh7AwRn5loYP3uuuMXXP+MBvessWUeNPHbYQ/ZKU1c7WTsXqAlkoNwN2aSBQtvrx3IEeiojmpmd64XF6IYccaL++7BqVku+IHdJHdrcRdzZ9xPgWx0os5d6hRAseFxjI7Auml8HZYypJD/JQRFY7vsAMdkH/M=
Received: from MW4PR03CA0042.namprd03.prod.outlook.com (2603:10b6:303:8e::17)
 by DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 06:36:29 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::1b) by MW4PR03CA0042.outlook.office365.com
 (2603:10b6:303:8e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:28 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:25 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 04/21] drm/amdgpu: make convert_ras_err_addr visible outside
 UMC block
Date: Tue, 19 Nov 2024 14:35:47 +0800
Message-ID: <20241119063604.81461-4-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DS7PR12MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: e155e6ec-5e2d-4f3f-6bfb-08dd08647fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZHkZeTeeul6XJ022w6EoFk5s7mtYRDrwcD9T14jpfzkep2S3G2fFG0UqR5D4?=
 =?us-ascii?Q?aGdCDSJj3qPri+au+vzrOZXu5+WPsx8WUFKG9MUak6Obe0S3nIMUkdBU6mWe?=
 =?us-ascii?Q?zvb99+y9NW8r9wKmeXTFi020SFGy4vtF+9fMgZxtqMvVwT/6TInIG61CFEDH?=
 =?us-ascii?Q?IoDFPbLdPBTWD0fejWKss/5caIuYU++SICvidc4fVjG63E4sxidIT3+Vnp1s?=
 =?us-ascii?Q?wxbYPwHh41FfRbEP2v//dweZ91AQs5/K+Uaj1h1sWG+MtV52s88S9f13lo8C?=
 =?us-ascii?Q?w4eY1uBNgSZlAGdFVcPW+KDnxDnannzMhwVYK0ar+cTSY3Nvxvg+0EQbVjGI?=
 =?us-ascii?Q?VM2R02oec3Hm8gso+2Hld8pGmb5co8TvLrnO6cGhp2mjdpYU+JHlk7S3mE4E?=
 =?us-ascii?Q?lsDzCEXK0IfPOy8C/mB5yxSClQjgvZ1E55pV9pZFnV8sa7Ru3mFEby78hss5?=
 =?us-ascii?Q?lq6DtBBmW4D9F5dn2j3jYBh5VBaYvPHVrfphjIvrfrOmVspJ/NH7If0jhkBE?=
 =?us-ascii?Q?GszAh63gmw3HORs9Hbq8tZmAyaay9Bl0grbevVp/F0T6NfRThe8p7PFL+NVy?=
 =?us-ascii?Q?tph6nWSRUylaK24k5Mm5prlqJT6pt/L4aEAUwcm18RdEaAp8J2KiKHdsvoM5?=
 =?us-ascii?Q?rGqETsW/x9ju+gOa8UdotdatZttINLZ0mlsfrZBHHG/Yp8kNEqWNC5vs01vD?=
 =?us-ascii?Q?L7JqrkOt/ukOumSAzWQI/E879zhBnndQJ2A1rW24w0VcraZ1UHkx4fOn48VB?=
 =?us-ascii?Q?GdRz67gaPGTl0/8YgCKgZBrQGQeeV2rM+lqgFckNKQUpCuyFQwud9AYvRFee?=
 =?us-ascii?Q?hl8Mpbn3FBCt+O3JLEqpiByHPIUuMnWSB3qd5iPzcGsGoXk79VaOcPhhUjU1?=
 =?us-ascii?Q?4+UPnOj7OKcBOJgjZ2Fhv3Wh9ulJsSk5f8vlZrmbTsvlsjsbhAyimaheOQft?=
 =?us-ascii?Q?xVfftRsIZxtkmi+svarzOByC2hv8icNOFnXwhckPBmZGOyL3MC26hyXsmbJN?=
 =?us-ascii?Q?tZPYl4cGOiJaZs3XQQDZTl8Wdk2Agwj+zjQB5HJeHXtFaDIzU/88Nbf70T/W?=
 =?us-ascii?Q?JJ/9cwF0FcXG20cNCDjQGORQtzn5io75GM9/3TZ3n9ITpa52TZLx3kr5ZjLC?=
 =?us-ascii?Q?uLHAyuPReRGCa2V6vI44rDxAiEwyJ5BE6cQQgjiVxv4mfXMQVpDkptXts4SI?=
 =?us-ascii?Q?D3mV0oUQe/v4m5YlqjbH4XBA8q5lkpYIxgXgIVzO4Bew+5o47DodwPdRQEQf?=
 =?us-ascii?Q?0NrKk1f2z9JahMETG2l8vyyvciohbrH+grR/98hl0e4AOSJwRs6DnP6FWLhG?=
 =?us-ascii?Q?3PCt4gN8/5jBUXQAzzBoeeOkRDL6lfnM0oktEDl9L1W9GHxMfeiuQBuxV5UI?=
 =?us-ascii?Q?E+zzAlN90w2sOx4W9pbXQDZhD2YppZMef1faR1f7agmJA+ElnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:28.7606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e155e6ec-5e2d-4f3f-6bfb-08dd08647fbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5839
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

And change some UMC v12 specific functions to generic version, so the
code can be shared.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 63 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 11 +++++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 62 ++----------------------
 3 files changed, 78 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 9e70a7b3aa64..75ded3904ee7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -445,3 +445,66 @@ int amdgpu_umc_logs_ecc_err(struct amdgpu_device *adev,
 
 	return ret;
 }
+
+int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
+			uint64_t pa_addr, uint64_t *pfns, int len)
+{
+	uint32_t i, ret = 0, pos = 0;
+	struct ta_ras_query_address_output addr_out;
+	struct ras_err_data err_data;
+
+	err_data.err_addr =
+		kcalloc(adev->umc.max_ras_err_cnt_per_query,
+				sizeof(struct eeprom_table_record), GFP_KERNEL);
+	if(!err_data.err_addr) {
+		dev_warn(adev->dev, "Failed to alloc memory in "
+				"bad page lookup!\n");
+		return 0;
+	}
+
+	addr_out.pa.pa = pa_addr;
+
+	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
+		adev->umc.ras->convert_ras_err_addr(adev, &err_data, NULL,
+				&addr_out, false);
+	else
+		goto out;
+
+	for (i = 0; i < adev->umc.max_ras_err_cnt_per_query; i++) {
+		if (pos >= len)
+			goto out;
+
+		pfns[pos++] = err_data.err_addr[pos].retired_page;
+	}
+	ret = pos;
+
+out:
+	kfree(err_data.err_addr);
+	return ret;
+}
+
+int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
+			uint64_t err_addr, uint32_t ch, uint32_t umc,
+			uint32_t node, uint32_t socket,
+			uint64_t *addr, bool dump_addr)
+{
+	struct ta_ras_query_address_input addr_in;
+	struct ta_ras_query_address_output addr_out;
+
+	memset(&addr_in, 0, sizeof(addr_in));
+	addr_in.ma.err_addr = err_addr;
+	addr_in.ma.ch_inst = ch;
+	addr_in.ma.umc_inst = umc;
+	addr_in.ma.node_inst = node;
+	addr_in.ma.socket_id = socket;
+
+	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
+		adev->umc.ras->convert_ras_err_addr(adev, NULL, &addr_in,
+				&addr_out, dump_addr);
+	else
+		return 0;
+
+	*addr = addr_out.pa.pa;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index ce4179db2a6d..abde7597bda8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -70,6 +70,11 @@ struct amdgpu_umc_ras {
 			enum amdgpu_mca_error_type type, void *ras_error_status);
 	int (*update_ecc_status)(struct amdgpu_device *adev,
 			uint64_t status, uint64_t ipid, uint64_t addr);
+	void (*convert_ras_err_addr)(struct amdgpu_device *adev,
+			struct ras_err_data *err_data,
+			struct ta_ras_query_address_input *addr_in,
+			struct ta_ras_query_address_output *addr_out,
+			bool dump_addr);
 };
 
 struct amdgpu_umc_funcs {
@@ -134,4 +139,10 @@ int amdgpu_umc_logs_ecc_err(struct amdgpu_device *adev,
 
 void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 			void *ras_error_status);
+int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
+			uint64_t pa_addr, uint64_t *pfns, int len);
+int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
+			uint64_t err_addr, uint32_t ch, uint32_t umc,
+			uint32_t node, uint32_t socket,
+			uint64_t *addr, bool dump_addr);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 65336ae12585..9b93ff769b86 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -243,61 +243,6 @@ static void umc_v12_0_convert_error_address(struct amdgpu_device *adev,
 	}
 }
 
-static int umc_v12_0_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
-			uint64_t pa_addr, uint64_t *pfns, int len)
-{
-	uint32_t i, ret = 0, pos = 0;
-	struct ta_ras_query_address_output addr_out;
-	struct ras_err_data err_data;
-
-	err_data.err_addr =
-		kcalloc(adev->umc.max_ras_err_cnt_per_query,
-				sizeof(struct eeprom_table_record), GFP_KERNEL);
-	if(!err_data.err_addr) {
-		dev_warn(adev->dev, "Failed to alloc memory in "
-				"bad page lookup!\n");
-		return 0;
-	}
-
-	addr_out.pa.pa = pa_addr;
-	umc_v12_0_convert_error_address(adev, &err_data, NULL, &addr_out, false);
-
-	for (i = 0; i < adev->umc.max_ras_err_cnt_per_query; i++) {
-		if (pos >= len)
-			goto out;
-
-		pfns[pos++] = err_data.err_addr[pos].retired_page;
-	}
-	ret = pos;
-
-out:
-	kfree(err_data.err_addr);
-	return ret;
-}
-
-static int umc_v12_0_convert_mca_to_addr(struct amdgpu_device *adev,
-			uint64_t err_addr, uint32_t ch, uint32_t umc,
-			uint32_t node, uint32_t socket,
-			uint64_t *addr, bool dump_addr)
-{
-	struct ta_ras_query_address_input addr_in;
-	struct ta_ras_query_address_output addr_out;
-
-	memset(&addr_in, 0, sizeof(addr_in));
-	addr_in.ma.err_addr = err_addr;
-	addr_in.ma.ch_inst = ch;
-	addr_in.ma.umc_inst = umc;
-	addr_in.ma.node_inst = node;
-	addr_in.ma.socket_id = socket;
-	addr_in.addr_type = TA_RAS_MCA_TO_PA;
-
-	umc_v12_0_convert_error_address(adev, NULL, &addr_in, &addr_out, dump_addr);
-
-	*addr = addr_out.pa.pa;
-
-	return 0;
-}
-
 static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
 					uint32_t node_inst, uint32_t umc_inst,
 					uint32_t ch_inst, void *data)
@@ -525,7 +470,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 		MCA_IPID_2_UMC_CH(ipid),
 		err_addr);
 
-	ret = umc_v12_0_convert_mca_to_addr(adev,
+	ret = amdgpu_umc_mca_to_addr(adev,
 			err_addr, MCA_IPID_2_UMC_CH(ipid),
 			MCA_IPID_2_UMC_INST(ipid), MCA_IPID_2_DIE_ID(ipid),
 			MCA_IPID_2_SOCKET_ID(ipid), &pa_addr, true);
@@ -559,7 +504,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *adev,
 	con->umc_ecc_log.de_queried_count++;
 
 	memset(page_pfn, 0, sizeof(page_pfn));
-	count = umc_v12_0_lookup_bad_pages_in_a_row(adev,
+	count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
 				pa_addr,
 				page_pfn, ARRAY_SIZE(page_pfn));
 	if (count <= 0) {
@@ -602,7 +547,7 @@ static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	memset(page_pfn, 0, sizeof(page_pfn));
-	count = umc_v12_0_lookup_bad_pages_in_a_row(adev,
+	count = amdgpu_umc_lookup_bad_pages_in_a_row(adev,
 				ecc_err->pa_pfn << AMDGPU_GPU_PAGE_SHIFT,
 				page_pfn, ARRAY_SIZE(page_pfn));
 
@@ -659,5 +604,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ecc_info_query_ras_error_address = umc_v12_0_query_ras_ecc_err_addr,
 	.check_ecc_err_status = umc_v12_0_check_ecc_err_status,
 	.update_ecc_status = umc_v12_0_update_ecc_status,
+	.convert_ras_err_addr = umc_v12_0_convert_error_address,
 };
 
-- 
2.34.1

