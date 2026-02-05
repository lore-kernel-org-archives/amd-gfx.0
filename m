Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E3AE91269
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7192810E221;
	Thu,  5 Feb 2026 06:51:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EBzhkQLz";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3379A10E221
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:51:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zI6kvrOuH2DZrciDxdgeDPJH2H8O3Nq2AeeyGP+ed9nVLiG/+XrMZaxx+6QqmPrM0Uo8sb+MqGn0XBp3gmUvkaKnIEwpDl2iKEhiBMPpJnJ2rYOZCvj5syOCTxzOi6OD8bM8ibh67Knax5LY1szROyDnXmwm72FdWvZ9RXIVbsRhZIKDbodaKC0euXzZR7UXyopo7KKkyLS/LWmB7AVeFJBfDcn3Vwb4d8PAW9DzKc+5R0UiPAB7iooubGqQeV89F/FJoL4+Ql4WEeTlOjrQM8L4YiwLBmVGYrWHK4ZTrW8zIGPf5inQKZcC35zUDsanAwHfOG+hdbAnlNUsi0IJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyvPxhpCavzhuc+kN5z63ijH8/s4Q26bLJrFyd7r4Os=;
 b=JEVmnNc+6RqldffXZH5k3jEdaVJSYyqMJ7Y/K0lMw+eqyZ+0hJbL0BkQStCsiRuaDp9Bw2LunlOgNXuqJ3F/RVFja8zRhxNJ/BKmQ/ocYRxBO5swTCya5BnPRLbFcV7TjsWCmHG6BBlBde9/2pnFHwLjlszuVUUN5DXpctFWFNYETm5wtCJQLWPG0rAtZ1vI8kUJEOmyCf3V13+jGe6a1XD1O6BGCuWF2Q0TMXTzrMEHZfqYF2VPcbiMKpK6W5zXEHnw7QHb1FNh8y5hw3D2QiD2jWwfnhd5RcFjNQzS4/b+gUPWbpX6/+X3bm8ZXV9Oszgu6R/3Iau/ZZ9WlbS59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyvPxhpCavzhuc+kN5z63ijH8/s4Q26bLJrFyd7r4Os=;
 b=EBzhkQLznX2aCeBniHBvVYgw5FRoNqIkduExnzzrMKopwSUyX4RQVD1UNQ8BmMQtCyM9Aq2IDetQ/GsHjIiWUQNTACCN8ZR30Jlbb+9Qlan+vOozb69BwFqNAHBoCK6YgomEqDoeetFHBy6ZASRp3vGXWgUz+qLw6DENi2M+1rI=
Received: from CY5P221CA0053.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::23) by
 BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 06:51:41 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::d) by CY5P221CA0053.outlook.office365.com
 (2603:10b6:930:4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 06:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:51:40 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:51:39 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 02/22] drm/amdgpu: add psp interfaces for peak tops limiter
 driver
Date: Thu, 5 Feb 2026 14:51:10 +0800
Message-ID: <20260205065130.654921-2-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: e533798d-b57f-43fc-dbec-08de6483043f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g0+BV9YAdr6tAK7ZukglePXDnFfTaFr0sF5TmuvECKE+ISxu0Pe2XS6z0yXU?=
 =?us-ascii?Q?dH44oUKaD+18N7dBzpbjP8GnFtdQhEamfhkE8QrB3Ur1rzoEpSwnjMUWG1sZ?=
 =?us-ascii?Q?9cPlNQMoIuj3JdvWEXtncGdVvDemNJTLfzsZ0ImArNtHhqGK+UbpOYzqoKaM?=
 =?us-ascii?Q?E/smJMTVWLGeFkMuft4coxzyZjX8MwWiT4dXa81Ln5bEk4lxcpquvDUp8cii?=
 =?us-ascii?Q?Ze6hGMWepOYEwSB4gKRrnQndbf/J9P8fwnYv1ZXb1bPziBZqEw9xyfvrKYbj?=
 =?us-ascii?Q?i2oANOgZCFZ8Pr3s3UEleAbZ7z68xPGDoZDDaw9PUQ7Qgvum8eJTLcdwg8ci?=
 =?us-ascii?Q?EZ/aIS75G7OdC9VNJt/SdLSy0j+tqzbZ9hHhvFYrHevGQsvP0PHTxStrG5Jd?=
 =?us-ascii?Q?x/cUBHaWgOor+Psj1aC9952wP18vgerS15o9ln1vj2Gn7lZvRqj2LRueWCWJ?=
 =?us-ascii?Q?9u07xr6zmXO6W3Ho/1Fpth5Kldd9WUy+jwwqB8VqAMtCgXdYMxBchptAHqBq?=
 =?us-ascii?Q?anh7+6KYE+NqkWsqvfayAziaqEvZqjYhklhoIhGvW2sXcspyA7YB07S0J703?=
 =?us-ascii?Q?+nTtj3a+JLyVVXgidop0nYWHN+c85g2w5CF7eiajEXqm8c4f9CwUPlZw07Lk?=
 =?us-ascii?Q?Gkuo7s4YtNuUWri1VF59JAPj0auSFtw436mC1LuTJsx+S0UEO0FY6c6a4MmR?=
 =?us-ascii?Q?LEKmrRLuqIWODrt04jHPoe+Gl8/h9wlpOLMEK4p34nGvGZxoP7ZFaP6nlEp/?=
 =?us-ascii?Q?SLb1Bfd11OBTLBuwbkew9DL8ysRkH3Q2/O+02dBW2HDm4HmO/Hezc6sUOtak?=
 =?us-ascii?Q?DglBvwj28qY0635rf6f6Ur6tdiINYuj1ro5dlD9KoYM+endxZZv7f+fMN6X1?=
 =?us-ascii?Q?H0VgbvRnH0DuC1uC4Znt5sjBrk60jsm4AD46PxQJluKnGqPBI/jmAhEzEFNs?=
 =?us-ascii?Q?hkrOnFUtG6U8H8p/4vYsRgkbePyQrLQW99glxsMMXO/BW1LcLQd99zrdlEsU?=
 =?us-ascii?Q?nhCu0YJcH5ZSGMuO3nSYZbY/E9Ro6ILwEnWJSZ4m9czmDSLLGe39ZXb4FQKm?=
 =?us-ascii?Q?5cC6AAGemFqY3Qnle2DHZ9R/j2ajsxVSviII7BrlquYvpOc9HnvvidpgBH/Q?=
 =?us-ascii?Q?bPW7axKCoseVlneEC7Yy4NNy49TxHogfoPAY3vSRHSaxie2VaGV+YFYOYkxX?=
 =?us-ascii?Q?/ATi0okdeA5OhPDgop7ufkCXZB1OufBSVafa13PM7R9BXF0f3velaVTffHqz?=
 =?us-ascii?Q?VkQn3npvlWOWjrZKuF/hR2vC3T9aKpSPdP6YO5cXAKCcg5QTwnKtyF4rdYfS?=
 =?us-ascii?Q?nJ6buaAXdJSsRafHQzN2ZAxYJnsAbN/NvrLibLDqfSCP2L6Z04YvYF48FGbb?=
 =?us-ascii?Q?Xl9UPr/9NMrRMpnDvYw0Exig/1CZLXnEN/ofqXn/sXqWDyU21amKHeHeFQp0?=
 =?us-ascii?Q?93XtAzoBUHcbWGXavb0lsLVGFsbN84oIfpUfPOSPI5WZ6wHp3/BbpZta6HZ8?=
 =?us-ascii?Q?v+BqHJhRS7rnG8mA6zPoRzYKuJ9AemvkM5FE2ENfUezdYci+nQVg2dGuYudV?=
 =?us-ascii?Q?xuYDwDf6BkISIuwyof1zFTSbD6fPZDl5ogyPutDkAKZz9/WWqV3JzuuFpjXF?=
 =?us-ascii?Q?srsyQC3A1Owe+H2AmilZnWMPCe8pkHNiatXdWP9ChbyDBpGm8pl82M4GBTNH?=
 =?us-ascii?Q?HhFprw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bE05svJ56UxgETjACbc19LfXDgNtPCxIApK9ri5bA0HSs6wQl7D6efnEWqRRgMqKnMlU50Esz359rha/18mh30GLJxt1n24Rj48oB6R4Sh3stHQCicX3oAb+8vf/mlKDcsVWmCnC2b7SxRdy1Ig6hbfA0aMYK/JquaOHJ+9W8eLQ2bnk9RRVW0S++2B21VFUD53ftq5SiqsKATVjDfVDvDVf+iE329i3nHm2xt6UYzegiKn0KKm6f5OaLvVDFzTrJurzOMt8z7rmWvvINKMcbL7jiTwIF7O9xihYIWHef9FqZ/40adtbwdQt76io/hEVONAcGHee5JONbWbmJ9BO3GD82Q9W3TDoruVe98n+LBj5I4kAhc22TuRFh82OibjdH6pzjIFAfKANkoe6w8Q3AeZECpmIWC+tN55NjAqaLu170sHZxswDjpeN7ZdyAAbk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:51:40.7134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e533798d-b57f-43fc-dbec-08de6483043f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
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

Introduce a Peak Tops Limiter (PTL) driver that dynamically caps
engine frequency to ensure delivered TOPS never exceeds a defined
TOPS_limit. This initial implementation provides core data structures
and kernel-space interfaces (set/get, enable/disable) to manage PTL state.

PTL performs a firmware handshake to initialize its state and update
predefined format types. It supports updating these format types at
runtime while user-space tools automatically switch PTL state, and
also allows explicitly switching PTL state via newly added commands.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 80 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  6 ++
 include/uapi/linux/kfd_ioctl.h          |  9 +++
 3 files changed, 95 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index b0540b009e84..2fbc3f95fedd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -679,6 +679,8 @@ static const char *psp_gfx_cmd_name(enum psp_gfx_cmd_id cmd_id)
 		return "SPATIAL_PARTITION";
 	case GFX_CMD_ID_FB_NPS_MODE:
 		return "NPS_MODE_CHANGE";
+	case GFX_CMD_ID_PERF_HW:
+		return "PERF MONITORING HW";
 	default:
 		return "UNKNOWN CMD";
 	}
@@ -1197,6 +1199,84 @@ int psp_memory_partition(struct psp_context *psp, int mode)
 	return ret;
 }
 
+static int psp_ptl_fmt_verify(struct psp_context *psp, enum amdgpu_ptl_fmt fmt,
+						 uint32_t *ptl_fmt)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4))
+		return -EINVAL;
+
+	switch (fmt) {
+	case AMDGPU_PTL_FMT_I8:
+		*ptl_fmt = GFX_FTYPE_I8;
+		break;
+	case AMDGPU_PTL_FMT_F16:
+		*ptl_fmt = GFX_FTYPE_F16;
+		break;
+	case AMDGPU_PTL_FMT_BF16:
+		*ptl_fmt = GFX_FTYPE_BF16;
+		break;
+	case AMDGPU_PTL_FMT_F32:
+		*ptl_fmt = GFX_FTYPE_F32;
+		break;
+	case AMDGPU_PTL_FMT_F64:
+		*ptl_fmt = GFX_FTYPE_F64;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int psp_performance_monitor_hw(struct psp_context *psp, u32 req_code,
+			       uint32_t *ptl_state, uint32_t *fmt1, uint32_t *fmt2)
+{
+	struct psp_gfx_cmd_resp *cmd;
+	uint32_t ptl_fmt1, ptl_fmt2;
+	int ret;
+
+	if (!psp || !ptl_state || !fmt1 || !fmt2)
+		return -EINVAL;
+
+	if (amdgpu_sriov_vf(psp->adev))
+		return 0;
+
+	if (psp_ptl_fmt_verify(psp, *fmt1, &ptl_fmt1) ||
+			psp_ptl_fmt_verify(psp, *fmt2, &ptl_fmt2))
+		return -EINVAL;
+
+	cmd = acquire_psp_cmd_buf(psp);
+
+	cmd->cmd_id                     = GFX_CMD_ID_PERF_HW;
+	cmd->cmd.cmd_req_perf_hw.req    = req_code;
+	cmd->cmd.cmd_req_perf_hw.ptl_state    = *ptl_state;
+	cmd->cmd.cmd_req_perf_hw.pref_format1 = ptl_fmt1;
+	cmd->cmd.cmd_req_perf_hw.pref_format2 = ptl_fmt2;
+
+	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+	if (ret)
+		goto out;
+
+	switch (req_code) {
+	case PSP_PTL_PERF_MON_QUERY:
+		*ptl_state = cmd->resp.uresp.perf_hw_info.ptl_state;
+		*fmt1      = cmd->resp.uresp.perf_hw_info.pref_format1;
+		*fmt2      = cmd->resp.uresp.perf_hw_info.pref_format2;
+		break;
+	case PSP_PTL_PERF_MON_SET:
+		psp->ptl_enabled = *ptl_state;
+		psp->ptl_fmt1    = ptl_fmt1;
+		psp->ptl_fmt2    = ptl_fmt2;
+		break;
+	}
+
+out:
+	release_psp_cmd_buf(psp);
+	return ret;
+}
+
 int psp_spatial_partition(struct psp_context *psp, int mode)
 {
 	struct psp_gfx_cmd_resp *cmd;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 90df8e29f532..47c8becbf710 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -471,6 +471,10 @@ struct psp_context {
 #if defined(CONFIG_DEBUG_FS)
 	struct spirom_bo *spirom_dump_trip;
 #endif
+	enum amdgpu_ptl_fmt		ptl_fmt1;
+	enum amdgpu_ptl_fmt		ptl_fmt2;
+	bool				ptl_enabled;
+	bool				ptl_hw_supported;
 };
 
 struct amdgpu_psp_funcs {
@@ -654,5 +658,7 @@ void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
 int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 			   enum psp_gfx_fw_type *type);
 
+int psp_performance_monitor_hw(struct psp_context *psp, u32 req_code,
+			       u32 *ptl_state, u32 *fmt1, u32 *fmt2);
 
 #endif
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index abb526c915c3..8db0c474a769 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1558,6 +1558,15 @@ struct kfd_ioctl_dbg_trap_args {
 	};
 };
 
+enum amdgpu_ptl_fmt {
+	AMDGPU_PTL_FMT_I8   = 0,
+	AMDGPU_PTL_FMT_F16  = 1,
+	AMDGPU_PTL_FMT_BF16 = 2,
+	AMDGPU_PTL_FMT_F32  = 3,
+	AMDGPU_PTL_FMT_F64  = 4,
+	AMDGPU_PTL_FMT_INVALID = 5,
+};
+
 #define KFD_IOC_PROFILER_VERSION_NUM 1
 enum kfd_profiler_ops {
 	KFD_IOC_PROFILER_PMC = 0,
-- 
2.34.1

