Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3133C5DF97
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C82210F48C;
	Fri, 21 Aug 2026 19:53:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mRbrAbSY";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 842D610F47B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:53:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rAPVFIU00PRcsdGidtD/wInuE7DBR7XF5ovxRp6HBmnKnh6iNHjdsp36jlEKzpr2h55Of7kYE4ONUpYRdxnhQNqMVgWjIegkcR+472mVYCONNzgrSxpweOB8xx1iRkd04s9cmWn9Bj6rDTn+XphGPJo94yWeIjtroMduIyCr6y4+QlWCj0f9ObMFLnT6jd5F09tgqkEeL6arYqwZAvyl9lz8prFf8WpXRr/N2Xj+OH9w12DMeDbFVqQ9w0jYzg3PofWbk4sajw2C/u8Swwl0fLThYjDf2lnAkq1Rf0emTA7mAw7x6fwZWdYxb1WErSmmTcHuD5doQzMRub+ldZcEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCw+nyF38kxQFW15pdV9C5yyscUXPz1kriROBuhBJNg=;
 b=e2hjIjyJA8gHDnp236MZFh3ouJbEHkbmIpXucvCKIw5uLZ1w3mchj3/w01I1jfsiQ1hq2ae7QNKFFt3jjnXgcqNgFZ6SUJg1FZA7bR0cTNR29dNdNwnrhO8K+Og4IyeGps6Tn79YS56/kbUtDR+zmuj63o8vvUe4nWGi9X+qJPtkCiV/DweVtrOXAnX4EXuC47eJUQBOCxeeK1pEhdAsCJwFg7Std8/pSpjK0BpmLRPvFIP/zLj33gfgGnZIUsSKl6BZ5Zst+xacVmINGgYuQAiwIKJKhFQctji3fy82ATCdMCQaRfRUoiWuRfjOlWUUlRW7WWsp5euociyeIIWG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCw+nyF38kxQFW15pdV9C5yyscUXPz1kriROBuhBJNg=;
 b=mRbrAbSY6xzsvuy5CjCurdX8xwWC9Du8um2OOFisp3pVqAXFMYvW9f/WX9ax+1ezzXqFBSFccntqx4GTa7K1VnpPiKul4kN+WC7iAybtVSEQoyjJLfO3J4M2IC4XfsIUqSHxJu8vhlibamR64ZXmWDLMqpUOeXL9DjQ5U0aksxw=
Received: from CH5P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::23)
 by BN7PPF08EEA05B5.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:27 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::b) by CH5P222CA0016.outlook.office365.com
 (2603:10b6:610:1ee::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:20 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/95] drm/amdgpu: Implement PSP cmd UAL_SET_STATION_CONFIG
Date: Fri, 21 Aug 2026 15:33:37 -0400
Message-ID: <20260821193458.808626-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|BN7PPF08EEA05B5:EE_
X-MS-Office365-Filtering-Correlation-Id: 5048e4c3-de37-4581-0e56-08deffbb5a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: w2drNAKqriCrCkg0xRinf/k0MndtIbXrtrl0Vj03+jjQ0/J3ubRbsnw59fAY04wJjacxeS0C+HIkfxGswKVYh+ERC+mgoZrpwwBhNR99Ia/GanEQFePDDfht8XsZEWEi8KR/3ROmZ+qsaVyX2fj7+JSSPjV/zHDcPszenNEQOGnoVZbMzWF6JVwAs077ezcDZXqnOz5T74TqIJV6KgtkdYP4QzdF7JnfugWeS2+af1kNorecS4tjaNFRv2ZlxRFUt6GVhRGTy5ZjV3yE1JSGe76lJFxtHYGtpKnC12AYi2AWHRukayl7KzVdKHlOAv9LYlSyosSLI1wvN2dySjrU4VnJeindZjQIUEIbgyI8da6vhxQvY6fSRNS15tNChY51SgY5e9qbRWP3Ilm7VYf7NOu9QFxa2gc5q57bL6F5dKZqfseGzhkU4QBGggj6E/k+rfXJ01svDRBXOqN4yeBOGPZQIw96N5sFhOym4Qh/M64An5+k0NSGvnCqjP0gM5zetKXZIcYpjl/ajV+JwxhJPMUkramOG0Jf70i6s9i1legBLu+wrwykhDAMl5uPP/sI0BJTbpmfl5Dqvr7ibKoINIVG3jhUgWsXMfxBVluf9ANZrsspJz9tx5wawLyrOx5dHuP8JV+ZFH9HBoof17w0ZjJutnLpeEijKfOv6rvFdDVeItunAIfEtPVKP3Opy2SsMHkVq5O+QVvkQCX9SBgbqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OzBXWdpV5p8DAoErN1dqjz945I1qY/pw7Nfd2f1Zt6EnyIR467MtaXzBE/khMw+HSovjtYUuP7pnyqbwzjGYobtvZMXyh7NX0JhHapnEGfpqTSYXv3r6k3NRjBpJ1EPwUIHlq1F4SElgUFSWqP6h76nVC+twplYhjU/y5My2RshM7ohqPtPOMwbnGwk2Z1D84Ikdbmtm4hIzDr9u9XBOcl7JurHPgssesFTo7ob96cEMYJADFIJNJpaFJ+RraYQ3cBKZsn9KytmSNqeScDMjG0Dz8Uw7BF5R3rMyftx+vo8tj4//AcV0dwZojDfhpf8tI+p1SMzAdarZiRr+K+oh190SvsDBokq4C6LIVOHiBkEuZsuhin3f8MJ1y4XWaiSP1KCoxU7dIwsDE0en/HZ9UMxFp66sydlKqQ+CAcA5vTeDy3ZZd+Fv13s1eJV6PWhM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:26.9687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5048e4c3-de37-4581-0e56-08deffbb5a2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF08EEA05B5
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

From: Felix Kuehling <felix.kuehling@amd.com>

To set the UALink station configuration to PSP.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 35 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  4 +++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index cbd85b27c6f6c..47367ff8c3903 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -835,6 +835,8 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)
 		return "UAL_SET_PPOD_CONFIG";
 	case GFX_CMD_ID_UAL_SET_VPOD_CONFIG:
 		return "UAL_SET_VPOD_CONFIG";
+	case GFX_CMD_ID_UAL_SET_STATION_CONFIG:
+		return "UAL_SET_STATION_CONFIG";
 	default:
 		return "UNKNOWN CMD";
 	}
@@ -1357,6 +1359,39 @@ int psp_ual_set_vpod_config(struct psp_context *psp, uint32_t intf_ver,
 	return ret;
 }
 
+int psp_ual_set_station_config(struct psp_context *psp, uint32_t intf_ver,
+			       const struct amdgpu_ualink_station_config *stations)
+{
+	struct psp_gfx_cmd_resp *cmd;
+	int ret;
+
+	/* TBD check interface version 1.x */
+	if (intf_ver > 0x1ffff) {
+		pr_warn("PSP UAL interface version mismatch: 0x%x\n", intf_ver);
+		return -EOPNOTSUPP;
+	}
+
+	cmd = acquire_psp_cmd_buf(psp);
+
+	cmd->cmd_id = GFX_CMD_ID_UAL_SET_STATION_CONFIG;
+	cmd->cmd.cmd_set_station_config_ual.num_stations = stations->n_stations;
+	cmd->cmd.cmd_set_station_config_ual.station_flag = stations->flags;
+	memcpy(cmd->cmd.cmd_set_station_config_ual.lane_en_bitmap,
+	       stations->lane_en_bitmap,
+	       min(stations->n_stations,
+		   sizeof(cmd->cmd.cmd_set_station_config_ual.lane_en_bitmap)));
+	/* The remainder is already 0-initialized by acquire_psp_cmd_buf */
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+	if (!ret && cmd->resp.status)
+		ret = -EINVAL;
+
+	release_psp_cmd_buf(psp);
+
+	return ret;
+}
+
 int psp_update_fw_reservation(struct psp_context *psp)
 {
 	int ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index d3bc3ba30599c..60ee3dc25113b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -709,6 +709,7 @@ int amdgpu_psp_irq_mgr_register(
 struct amdgpu_ualink_info;
 struct amdgpu_ualink_ppod_setup;
 struct amdgpu_ualink_vpod_config;
+struct amdgpu_ualink_station_config;
 
 int psp_ual_get_interface_version(struct psp_context *psp, uint32_t *intf_ver);
 
@@ -721,4 +722,7 @@ int psp_ual_set_ppod_config(struct psp_context *psp, uint32_t intf_ver,
 int psp_ual_set_vpod_config(struct psp_context *psp, uint32_t intf_ver,
 			    const struct amdgpu_ualink_vpod_config *config);
 
+int psp_ual_set_station_config(struct psp_context *psp, uint32_t intf_ver,
+			       const struct amdgpu_ualink_station_config *stations);
+
 #endif
-- 
2.55.0

