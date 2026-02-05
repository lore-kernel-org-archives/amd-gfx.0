Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71FDE9126E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 418AE10E387;
	Thu,  5 Feb 2026 06:52:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y00Zkgp8";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16CAB10E7D1
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:52:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvOJl314p3lZD4JjbumDToUD5CV02OS1wh3FSwBDsCdNROzYQOHMe0/3Wa5Z+qK3n9/I2ywwzPkM15ZT2inFp1KM/bz7gQJNQztnxHiTYdcFizXCsCVzua6M1UEkhUfIRxK89hdHUVVogDXEvJVKdScF+E+NjEi+5x+kFwkGxZXDV5GSczANd2+2RmHpLO0sOxlbZugbx49QQONMARxVdoHTUfGZCjS/d6MPBPOYELHRBJ/t8EXZM8FJzuD44hnB8hb7apWFjCUYKfALjfFfaTkhSFJY57l/H3dmXpt7wuZzyXmpEqhDMV2MZ5folbZQIEQWWEyvLmtDrQwK4zg2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvoo/tCErapwfP0TmP+t6REu+tlW3VhWmWz6fd2WE9k=;
 b=UxDmBXBF5hk85oHIWCTnqQq/WnKNXO9vYrpFhedrGR0hATwvhcLz908XBA6/zVpPoNuBp+0hC4hLweoFX0n2cEp7vMuV12d8NmoLV3HgdILbYUum8u2uY+w1ACrFZ8iTo+aoDy1zKK8hYrar6Lci55L9D0HZH6LruAjcB/KgOIKtpIdBduDWcCQV2fQ1ugc3GoxguniUgxjyxldKMZi9uCTNhjbDkEPbsf9Hggri0+nwMyWh9rxuiChHQ30slUm4jEQjUCgnkqiMWM+cAbHmkDNoZQEuaVT2EUFUwcrRRXBqkS1ynCfzOmSVtRGQigbA9DjdHLk9ZvRI9s9jo10wiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvoo/tCErapwfP0TmP+t6REu+tlW3VhWmWz6fd2WE9k=;
 b=Y00Zkgp8pY2h36uxsgCD5xIEUMnYymruZ7efsDDZMAa7jHSkb++kpAWsswLaxoIcEKsTeuLveI5UIj7gp9ibgOVpO2HFpZvfr1WiCywEjF99BMOm89cIUd0Otc4ZOjhcv/798MyqC6grBSaj7yQsODkBbVj8Ydjds4Fh3NoRpRE=
Received: from PH7P221CA0051.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::21)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:52:05 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::60) by PH7P221CA0051.outlook.office365.com
 (2603:10b6:510:33c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Thu,
 5 Feb 2026 06:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:52:05 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:52:01 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 16/22] drm/amdgpu: Refactor PTL control into public API and
 internal implementation
Date: Thu, 5 Feb 2026 14:51:24 +0800
Message-ID: <20260205065130.654921-16-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: e1fb44f0-cbdb-45c9-844a-08de648312ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gpK3XT0p+NUYXnprMscpruQVqNWHY40gp2YqA1qgK43nA0aqC3Iauc0Q2GUu?=
 =?us-ascii?Q?J3PVtZCbBevQBOY0BPqkitST0f+uaIN6ZPuiOMb6HVsnj8T4ekpUwrVVYeET?=
 =?us-ascii?Q?7OZjCnF0FDL0ZtXw671pw0lfgvvImToZ0C2sJ3Dicy0BEMtS1CI/nNys493B?=
 =?us-ascii?Q?eH6hJzZVXLnz8QW+u938SHmhGrymv+8b7LEHUOPWHyAeyXNDDEUPmvH6hd53?=
 =?us-ascii?Q?08lFpq7Ut4yvGl/0HzVLbpoW53F7OYlndwHFkD4ec2gHOJfkqcB2eGGp+PM2?=
 =?us-ascii?Q?j3g1bhmOJu55nDMbsULcsRgOBHgqHigoJNTdNfOYZMD+5Xld6lOhDJd5MeBi?=
 =?us-ascii?Q?4xj11TRZEY5sc+DblQnVYT/VCGe8ToS29IR0BNkjQAP8Ykt31V27dVEa9ykL?=
 =?us-ascii?Q?gr61ha/vMLihIF2IRaN6buucTFQRS+cbfpXV+0j61QhExEi0TTbyvv4+2WCb?=
 =?us-ascii?Q?ogETmSnJ7qJCp4fcIbLD/fCl2ooZGoOxWFbhakyyJl7d4zsU+TJDY5bioiqL?=
 =?us-ascii?Q?TUvl4LZTW2cShc4x/xpd22Rrc/tM/7HvZGMAmqrxckyMoU4umRcNQ5FFDDkE?=
 =?us-ascii?Q?M1O7DG+2ddv2qSrU/s1G3+tOnp0PCw6+qLhKpt9CbRZSmpv9nzZu/gbT8hE1?=
 =?us-ascii?Q?/YFn/dN064UcoFFS5mdRl1j/i9gcNA60Nuiv6LhkViB7ze/kf9sbLRfkUZF9?=
 =?us-ascii?Q?pthRi11Ui17Gxpuh6PTl7BBJ9IFuRfMYuS2IZa5YJpW/5kDgd13NEYAjqBG7?=
 =?us-ascii?Q?ojI9jmi01DlMK84/wCSQDtnu0KeaeNO+3fIbG8fsa2Na7f3KO7fnfAwnkU1i?=
 =?us-ascii?Q?CYlGXJb9u3uKqxwAnR5qGW2MCO19VoRZgOyBqAM+8V4zeAA3gNReSZVUdzzL?=
 =?us-ascii?Q?+NwVWeAwre3Sz5lKTKnz9/TbuLhZRruToWDA2Z46gsMSfAdYbH9piWw4upo0?=
 =?us-ascii?Q?1U7/e1cPDevjXQ17O//+uIVGhNnwHjo/2rAY1TRoKXaZ8K1s41mtpAN/nzrl?=
 =?us-ascii?Q?1WaEHX0NZs2pN4MipsA6cO6CS6aqRygTtXpdumYgX4TOlmYg/C0pOs38uJ0U?=
 =?us-ascii?Q?a5HCzdHMfOCA0xOUfrNecRRyoMUBUEModgtaPwxmrW1pshLsLrmO18AmgCYl?=
 =?us-ascii?Q?wx3w26k9gSzprC2CQZKJd/D6iGkIdU09NEA7GNjOouYZwQ5K3Nou9q38U38W?=
 =?us-ascii?Q?NfHdC0ceIkEPfz4ucdJYptu1Fx62QaUTn/NHC/vbCrZ7us+jCgjahH/DgLVp?=
 =?us-ascii?Q?FYEcRk7kI6JpdT7ix2wVHn3OgRW9l4CGTjOIiASYeF3uZFJR8mK7j9c3q4Me?=
 =?us-ascii?Q?QSK5pbqnd6m8hlKJs9eYR3mp3yFOtootgIvlDouW5V+T/6QEH1D4pEspUmD7?=
 =?us-ascii?Q?LpJc+7PnaW91zbsD8v43FV40/uOl0+dMEHaagJuyp34PfyuBdysHf9EspU7r?=
 =?us-ascii?Q?oWKpcswh40TtL00bgUBPL37DYmdqVpLKr0KqjTmnr0kPlCJzKI/phFXztQC6?=
 =?us-ascii?Q?iUrxF2chBYp2lymBzEcvaqKDXw0x91h+Xh0F2plOP8cQz9WvntCWX5NFOn4v?=
 =?us-ascii?Q?Bnrk+ZgRvy6eu/Yg6mCgHHDG7CY4BBbL1J1SPAoqTFEFTzVl3JUHJOXf/l1K?=
 =?us-ascii?Q?8cdFU5UZJmXY1RDtIulVGegUhZMcl6VbXvLULDrPYAaDO2LuCf72CavYUYE8?=
 =?us-ascii?Q?lz4xCA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q6BbXRyqDfd6ME7FDMtkOM4jfozfZ4suvdXJKVtRjd+dJyfXfBz/deZngiapcC6r09ecJ0gDk3mXBk5ed7Y49D1FXbsLrjJMm89i2EMYXSBxsHj30s1C7u59h61Rwdb2Ay3vH+pklDtvm5b5PafSAjzaRN1D7qfLg60MVGblc+rvn5acjbXf+JlELtaIV9Ag7Ppa2h81PhHDKIy6BcmtfK5tssupe2l+EiUTj4rWN/eERmhq/zDqVDRgKGJZHUtRXe8OAq6nboxdMy23guorWLNYCxBonucCXMNJjfCclC5EpDGLq4WOEp7KX6ENMsCmcSXXNJbhPWp0s5ucOjp7sgIBnrD7vN85zoavnulkm6fUd5qKB0MybG6rbMrZfLPc+7CuRYp2paT8z+rlClYYnfk2u7n2LARtLQcCPZzzlWdF1LqVW29PBnmWMsv8NVhs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:52:05.3353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fb44f0-cbdb-45c9-844a-08de648312ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324
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

Separate the PTL (Peak Tops Limiter) control logic into a stable public
API layer and an internal implementation layer.

v2: revise commit info

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 77 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  2 +-
 4 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index f491fd2e4ed9..74eb57332e07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -526,7 +526,7 @@ static uint32_t kgd_v9_4_3_ptl_ctrl(struct amdgpu_device *adev,
 				enum amdgpu_ptl_fmt *fmt1,
 				enum amdgpu_ptl_fmt *fmt2)
 {
-	return psp_performance_monitor_hw(&adev->psp, cmd,
+	return amdgpu_ptl_perf_monitor_ctrl(adev, cmd,
 			ptl_state, fmt1, fmt2);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 982494abbf1d..f0b1157d7a21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1239,48 +1239,25 @@ static int psp_ptl_fmt_verify(struct psp_context *psp, enum amdgpu_ptl_fmt fmt,
 	return 0;
 }
 
-int psp_performance_monitor_hw(struct psp_context *psp, u32 req_code,
-			       uint32_t *ptl_state, uint32_t *fmt1, uint32_t *fmt2)
+static int psp_ptl_invoke(struct psp_context *psp, u32 req_code,
+		uint32_t *ptl_state, uint32_t *fmt1, uint32_t *fmt2)
 {
 	struct psp_gfx_cmd_resp *cmd;
-	uint32_t ptl_fmt1, ptl_fmt2;
 	int ret;
 
-	if (!psp || !ptl_state || !fmt1 || !fmt2)
-		return -EINVAL;
-
-	if (amdgpu_sriov_vf(psp->adev))
-		return 0;
-
-	if (amdgpu_ip_version(psp->adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4) ||
-			psp->sos.fw_version < 0x0036081a)
-		return -EOPNOTSUPP;
-
-	if (psp_ptl_fmt_verify(psp, *fmt1, &ptl_fmt1) ||
-			psp_ptl_fmt_verify(psp, *fmt2, &ptl_fmt2))
-		return -EINVAL;
-
-	/*
-	 * Add check to skip if state and formats are identical to current ones
-	 */
-	if (req_code == PSP_PTL_PERF_MON_SET &&
-			psp->ptl_enabled == *ptl_state &&
-			psp->ptl_fmt1 == ptl_fmt1 &&
-			psp->ptl_fmt2 == ptl_fmt2)
-		return 0;
-
 	cmd = acquire_psp_cmd_buf(psp);
 
 	cmd->cmd_id                     = GFX_CMD_ID_PERF_HW;
 	cmd->cmd.cmd_req_perf_hw.req    = req_code;
 	cmd->cmd.cmd_req_perf_hw.ptl_state    = *ptl_state;
-	cmd->cmd.cmd_req_perf_hw.pref_format1 = ptl_fmt1;
-	cmd->cmd.cmd_req_perf_hw.pref_format2 = ptl_fmt2;
+	cmd->cmd.cmd_req_perf_hw.pref_format1 = *fmt1;
+	cmd->cmd.cmd_req_perf_hw.pref_format2 = *fmt2;
 
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
 	if (ret)
 		goto out;
 
+	/* Parse response */
 	switch (req_code) {
 	case PSP_PTL_PERF_MON_QUERY:
 		*ptl_state = cmd->resp.uresp.perf_hw_info.ptl_state;
@@ -1288,9 +1265,10 @@ int psp_performance_monitor_hw(struct psp_context *psp, u32 req_code,
 		*fmt2      = cmd->resp.uresp.perf_hw_info.pref_format2;
 		break;
 	case PSP_PTL_PERF_MON_SET:
+		/* Update cached state only on success */
 		psp->ptl_enabled = *ptl_state;
-		psp->ptl_fmt1    = ptl_fmt1;
-		psp->ptl_fmt2    = ptl_fmt2;
+		psp->ptl_fmt1    = *fmt1;
+		psp->ptl_fmt2    = *fmt2;
 		break;
 	}
 
@@ -1299,6 +1277,41 @@ int psp_performance_monitor_hw(struct psp_context *psp, u32 req_code,
 	return ret;
 }
 
+int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
+		uint32_t *ptl_state, uint32_t *fmt1, uint32_t *fmt2)
+{
+	uint32_t ptl_fmt1, ptl_fmt2;
+	struct psp_context *psp;
+
+	if (!adev || !ptl_state || !fmt1 || !fmt2)
+		return -EINVAL;
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	psp = &adev->psp;
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4) ||
+			psp->sos.fw_version < 0x0036081a)
+		return -EOPNOTSUPP;
+
+	/* Verify formats */
+	if (psp_ptl_fmt_verify(psp, *fmt1, &ptl_fmt1) ||
+			psp_ptl_fmt_verify(psp, *fmt2, &ptl_fmt2))
+		return -EINVAL;
+
+	/*
+	 * Add check to skip if state and formats are identical to current ones
+	 */
+	if (req_code == PSP_PTL_PERF_MON_SET &&
+			psp->ptl_enabled == *ptl_state &&
+			psp->ptl_fmt1 == ptl_fmt1 &&
+			psp->ptl_fmt2 == ptl_fmt2)
+		return 0;
+
+	return psp_ptl_invoke(psp, req_code, ptl_state, &ptl_fmt1, &ptl_fmt2);
+}
+
 static enum amdgpu_ptl_fmt str_to_ptl_fmt(const char *str)
 {
 	int i;
@@ -1356,7 +1369,7 @@ static ssize_t ptl_enable_store(struct device *dev,
 		return count;
 	}
 
-	ret = psp_performance_monitor_hw(psp, PSP_PTL_PERF_MON_SET, &ptl_state, &fmt1, &fmt2);
+	ret = amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, &ptl_state, &fmt1, &fmt2);
 	if (ret) {
 		dev_err(adev->dev, "Failed to set PTL err = %d\n", ret);
 		mutex_unlock(&psp->ptl_mutex);
@@ -1412,7 +1425,7 @@ static ssize_t ptl_format_store(struct device *dev,
 	ptl_state = psp->ptl_enabled;
 	fmt1 = fmt1_enum;
 	fmt2 = fmt2_enum;
-	ret = psp_performance_monitor_hw(psp, PSP_PTL_PERF_MON_SET, &ptl_state, &fmt1, &fmt2);
+	ret = amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, &ptl_state, &fmt1, &fmt2);
 	if (ret) {
 		dev_err(adev->dev, "Failed to update PTL err = %d\n", ret);
 		mutex_unlock(&psp->ptl_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 1ab7255718df..711f15d21940 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -662,7 +662,7 @@ void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
 int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 			   enum psp_gfx_fw_type *type);
 
-int psp_performance_monitor_hw(struct psp_context *psp, u32 req_code,
+int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
 			       u32 *ptl_state, u32 *fmt1, u32 *fmt2);
 int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_ptl_sysfs_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 472e2f41fed2..1682adb1231f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2388,7 +2388,7 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct amdgpu_device *adev, bool sta
 	}
 
 	/* initialize PTL with default formats: GFX_FTYPE_I8 & GFX_FTYPE_BF16 */
-	r = psp_performance_monitor_hw(&adev->psp, PSP_PTL_PERF_MON_SET, &ptl_state,
+	r = amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, &ptl_state,
 							&fmt1, &fmt2);
 	if (r)
 		return r;
-- 
2.34.1

