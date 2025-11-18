Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3517ACED24D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 09:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA7FD10E451;
	Tue, 18 Nov 2025 09:17:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zn5XYhqX";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB81C10E14E
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 09:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0Ak4Tv/YO9MpsDyzuff5o5b3s/0KAUEX8SCx3FC4dsmQYvywKrPjohufHiXmh+SwIGQhsrUVCfjCZZ+G5QPBL4mBDVYeYgI0AEr8KHc3OBtOaa8klGGJAfV9TBnuHJ2ngNo3ubjKUhV25t85LYSjDonoBXeh8UICJ5T+zhpDDzwT7CttnqEN/BPqzdR4QN8f5H3aJvola0nrNT2SdTD6XFIzGnJx/y+epxL16fKinRM6uPROrzx6MiYeQfpJD0Wk6g9Tmaafn4oRR3uW/9lV0LMMGS4BZnGft7Vp9k+fRsc+t/EUEW8dBt6SWx5FvUDMqy1HkcUdV1BqM1J/HYchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjoXOamwoUhaPDkDkkRI+7tI+2VRNxclmmdaee0t5dk=;
 b=o3N76/WMur05067RvUnw2lcoYZeLYul1hvfUYwdH8ee//EK0yFbagPLJuhTSBqhvlNuPaZPWpEqu2sH1ABRoglFnFFL6redgn0K3r9roBC0kWyshb6mMsUDWzrDRBf1wbeHWa1M9eJauIiqF90+UnzWR+aHDL3kVKtNEIF7iD/5HpcFH7TjBtaAHyovfG4NxAxtq1eVI6PZRvOVI6+pSXk5Sc9p8ghEBzogFTjscP92w1dDwl9ghmALJTLhOehFVGNPeijtGzs7Mq+zYQAwKR75RPAONm6YSSY2wDetBAiw9DDiT3yPhvNXqnoFPOrbaMyrQTBQztl5n5+zoOQRruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjoXOamwoUhaPDkDkkRI+7tI+2VRNxclmmdaee0t5dk=;
 b=zn5XYhqX2nfFo3UCYSiKyLHYZfE798DosCwr5zxX66ScZnJhkV/ljGec1PsH0MfgBJ1DKs4y9iQkqZaYwgpiyUDGy/h7P7U1SWqUXsH6p0HwF2aIRuystnSzLw0QvQ2wiExlmXLXwv7OfE0Y4EqEGdyG2r2KS0zlIrfT+wn3zZM=
Received: from BL1PR13CA0318.namprd13.prod.outlook.com (2603:10b6:208:2c1::23)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 09:17:01 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::cb) by BL1PR13CA0318.outlook.office365.com
 (2603:10b6:208:2c1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 09:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 18 Nov 2025 09:17:01 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 01:16:58 -0800
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 3/7] drm/amd/ras: Add ras command to retrieve cper data from
 sriov host
Date: Tue, 18 Nov 2025 17:15:55 +0800
Message-ID: <20251118091559.959683-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118091559.959683-1-YiPeng.Chai@amd.com>
References: <20251118091559.959683-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: e6af505a-3892-46b1-2c63-08de26833b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OMlsT1QYmFfDLTqTHgkRJZ6w8psXEAPIhWQg5x/4CXgeKidExpKD4+fzTYr4?=
 =?us-ascii?Q?897Ltd9TOUewQbekrkqeEuz69/yQwVthsi5EV2vyo9krUMpnE6KRUUtJfF7I?=
 =?us-ascii?Q?P0BpYsJCg2982xMBIoni4OJuKyieSbDu2PIzX9uRjhcFotyF5tcs8MXVdg0K?=
 =?us-ascii?Q?pnk/fqIMuGNqAUl+WGSfWPpz6gdg1Ing8kvi3zogS1QosFB+C7oxRND8MIrO?=
 =?us-ascii?Q?RKsbMx8Sh0CsgC7lJpVemYCZ3/1fAMGTkXHUiPqgkCu2Hn/DBd4QwU+TtMVk?=
 =?us-ascii?Q?9D6Gk8rWBkRRqTx49r6o+oSt2xRVodBqk3PtABtdLzNjrmvNEGlzpCxBRFkn?=
 =?us-ascii?Q?x8EpH4Q8vB6v29Exvd/wp37UamXbAwYlTD4CbED9HDF7toydL880Sg2qMIcI?=
 =?us-ascii?Q?1XcPxlr1zLHE9a4sMBmmNM2oHoE9R4e+GZjXgVDqDQay53g2Vjb7K9yWLmiv?=
 =?us-ascii?Q?NYzvjnQHQF2euHuhILejj+hTWn5JAqLRR3F/2mfss7tGc19BGkPd8tmiJ4BW?=
 =?us-ascii?Q?NAV1Zjeg0lwQz7nefI5yvtNIU7d8BZVkD3FVhkjpI1/VOqju5TwbJZs1Y27x?=
 =?us-ascii?Q?yq7sLH6AlJedOM3VaQfQwjxlN8hSQirKdeh98EnyX0x3N03l/AyK9eEJNWQ6?=
 =?us-ascii?Q?To5woqn+szDm1dJ0gMo2VmhufODdRH2Qksb5RlEhsAQO6wqM+qYFja819g+S?=
 =?us-ascii?Q?OezGvgxj4iHwqSjeFqt7b4Sv5Z3zk0zLw64zd2H2Quj7i4Jxp67bNql8Cv5d?=
 =?us-ascii?Q?ZrnWd7ocPuWJXRm3XAsASkbpdUCuIqU4QonLsl1A3zI439uig3n2xBeHHiwP?=
 =?us-ascii?Q?NHqrzBKiwiTUOqfDkBV/YpAOsSMK2Bh+uMr8PDEwedATt/RpPsUU6xc7GviN?=
 =?us-ascii?Q?65jMEUoaeBw3zKwfopwBKFRWjEjfAzr2UYhDRvlrmUzaBM9IzC51kJML07TU?=
 =?us-ascii?Q?aEwoQ6I8Cy5hM4v90foDjQPJ4WyTDnjmvSKsdFaQIGG9mFDGE7ICuCmjmm0/?=
 =?us-ascii?Q?NVw+b0TcYKUs44a/0IQWevbusNWQvuDUNek6wAaORewDi+Cyeuui45BQnoIx?=
 =?us-ascii?Q?lD6FnasErj/VMkejxAAZaE+J2QNkzAMKH4DLHSd3LweCXSp5ZFAAyOY47sU1?=
 =?us-ascii?Q?i2EbmI1WOl4u4PsaE0MOrtmeZNdRT+J8dthPm6nNQr5BKKJTC7HS/MOZiWeb?=
 =?us-ascii?Q?r4qWEU2i3Dczc3/v+mITuMTPWN0whAi+d+EiXhnAY4/VfoOX6YKv7Fpp+1rg?=
 =?us-ascii?Q?mtPuDoBBqyFml6qTD7EtHc2B0yUReRhQDkjqQOe0BHtS+7bCp6SCPhQOyAZj?=
 =?us-ascii?Q?6kl0PlVQBn87xBB7KqAI+p1j5ZlPSnS/vixJgPbxLK0LQPOH7nZfzEk87zAl?=
 =?us-ascii?Q?BYUpaof9UvMGJNbxcYfSPhDGUc3IWNQKYBBklPp6Tbx/4GDE6HCgKh394Zib?=
 =?us-ascii?Q?/nmHLxFgHIlIYOqadyFIVFbhImuqcXrVFQvliXLm1hYsfF28pDcxQ/jofDoH?=
 =?us-ascii?Q?hnxWj4T0y0m5NGfdpkRAOS1NwzcCRETW4KlkwpVWSqD4K63LGea+4sMkFRY/?=
 =?us-ascii?Q?k4ABwegI1Xj5rDnnR38=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 09:17:01.0960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6af505a-3892-46b1-2c63-08de26833b58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181
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

In order to reduce the number of interactions with sriov
host and the amount of data exchanged, a set of ras commands
is first used to obtain the raw data used to generate cper
from the host, then, guest driver generates cper based
on the obtained raw data.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 168 +++++++++++++++++-
 .../drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h |   6 +
 2 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
index 8c4be1af76b2..992ff214f30a 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
@@ -70,8 +70,174 @@ static int amdgpu_virt_ras_remote_ioctl_cmd(struct ras_core_context *ras_core,
 	return ret;
 }
 
-static struct ras_cmd_func_map amdgpu_virt_ras_cmd_maps[] = {
+static int amdgpu_virt_ras_send_remote_cmd(struct ras_core_context *ras_core,
+	uint32_t cmd_id, void *input_data, uint32_t input_size,
+	void *output_data, uint32_t output_size)
+{
+	struct ras_cmd_ctx rcmd = {0};
+	int ret;
+
+	rcmd.cmd_id = cmd_id;
+	rcmd.input_size = input_size;
+	memcpy(rcmd.input_buff_raw, input_data, input_size);
+
+	ret = amdgpu_virt_ras_remote_ioctl_cmd(ras_core,
+				&rcmd, output_data, output_size);
+	if (!ret) {
+		if (rcmd.output_size != output_size)
+			return RAS_CMD__ERROR_GENERIC;
+	}
+
+	return ret;
+}
+
+static int amdgpu_virt_ras_get_batch_trace_overview(struct ras_core_context *ras_core,
+	struct ras_log_batch_overview *overview)
+{
+	struct ras_cmd_batch_trace_snapshot_req req = {0};
+	struct ras_cmd_batch_trace_snapshot_rsp rsp = {0};
+	int ret;
+
+	ret = amdgpu_virt_ras_send_remote_cmd(ras_core, RAS_CMD__GET_BATCH_TRACE_SNAPSHOT,
+				&req, sizeof(req), &rsp, sizeof(rsp));
+	if (ret)
+		return ret;
+
+	overview->first_batch_id = rsp.start_batch_id;
+	overview->last_batch_id = rsp.latest_batch_id;
+	overview->logged_batch_count = rsp.total_batch_num;
+
+	return RAS_CMD__SUCCESS;
+}
+
+static int amdgpu_virt_ras_get_cper_snapshot(struct ras_core_context *ras_core,
+			struct ras_cmd_ctx *cmd, void *data)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(ras_core->dev);
+	struct amdgpu_virt_ras_cmd *virt_ras =
+			(struct amdgpu_virt_ras_cmd *)ras_mgr->virt_ras_cmd;
+	int ret;
+
+	if (cmd->input_size != sizeof(struct ras_cmd_cper_snapshot_req))
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
+	ret = amdgpu_virt_ras_send_remote_cmd(ras_core, cmd->cmd_id,
+			cmd->input_buff_raw, cmd->input_size,
+			cmd->output_buff_raw, sizeof(struct ras_cmd_cper_snapshot_rsp));
+	if (ret)
+		return ret;
+
+	memset(&virt_ras->batch_mgr, 0, sizeof(virt_ras->batch_mgr));
+	amdgpu_virt_ras_get_batch_trace_overview(ras_core,
+					&virt_ras->batch_mgr.batch_overview);
+
+	cmd->output_size = sizeof(struct ras_cmd_cper_snapshot_rsp);
+	return RAS_CMD__SUCCESS;
+}
+
+static int amdgpu_virt_ras_get_batch_records(struct ras_core_context *ras_core, uint64_t batch_id,
+			struct ras_log_info **trace_arr, uint32_t arr_num,
+			struct ras_cmd_batch_trace_record_rsp *rsp_cache)
+{
+	struct ras_cmd_batch_trace_record_req req = {
+		.start_batch_id = batch_id,
+		.batch_num = RAS_CMD_MAX_BATCH_NUM,
+	};
+	struct ras_cmd_batch_trace_record_rsp *rsp = rsp_cache;
+	struct batch_ras_trace_info *batch;
+	int ret = 0;
+	uint8_t i;
+
+	if (!rsp->real_batch_num || (batch_id < rsp->start_batch_id) ||
+		(batch_id >=  (rsp->start_batch_id + rsp->real_batch_num))) {
+
+		memset(rsp, 0, sizeof(*rsp));
+		ret = amdgpu_virt_ras_send_remote_cmd(ras_core, RAS_CMD__GET_BATCH_TRACE_RECORD,
+			&req, sizeof(req), rsp, sizeof(*rsp));
+		if (ret)
+			return -EPIPE;
+	}
+
+	batch = &rsp->batchs[batch_id - rsp->start_batch_id];
+	if (batch_id != batch->batch_id)
+		return -ENODATA;
+
+	for (i = 0; i < batch->trace_num; i++) {
+		if (i >= arr_num)
+			break;
+		trace_arr[i] = &rsp->records[batch->offset + i];
+	}
+
+	return i;
+}
+
+static int amdgpu_virt_ras_get_cper_records(struct ras_core_context *ras_core,
+	struct ras_cmd_ctx *cmd, void *data)
+{
+	struct amdgpu_ras_mgr *ras_mgr = amdgpu_ras_mgr_get_context(ras_core->dev);
+	struct amdgpu_virt_ras_cmd *virt_ras =
+			(struct amdgpu_virt_ras_cmd *)ras_mgr->virt_ras_cmd;
+	struct ras_cmd_cper_record_req *req =
+		(struct ras_cmd_cper_record_req *)cmd->input_buff_raw;
+	struct ras_cmd_cper_record_rsp *rsp =
+		(struct ras_cmd_cper_record_rsp *)cmd->output_buff_raw;
+	struct ras_log_batch_overview *overview = &virt_ras->batch_mgr.batch_overview;
+	struct ras_cmd_batch_trace_record_rsp *rsp_cache = &virt_ras->batch_mgr.batch_trace;
+	struct ras_log_info *trace[MAX_RECORD_PER_BATCH] = {0};
+	uint32_t offset = 0, real_data_len = 0;
+	uint64_t batch_id;
+	uint8_t *out_buf;
+	int ret = 0, i, count;
+
+	if (cmd->input_size != sizeof(struct ras_cmd_cper_record_req))
+		return RAS_CMD__ERROR_INVALID_INPUT_SIZE;
+
+	if (!req->buf_size || !req->buf_ptr || !req->cper_num)
+		return RAS_CMD__ERROR_INVALID_INPUT_DATA;
+
+	out_buf = kzalloc(req->buf_size, GFP_KERNEL);
+	if (!out_buf)
+		return RAS_CMD__ERROR_GENERIC;
 
+	memset(out_buf, 0, req->buf_size);
+
+	for (i = 0; i < req->cper_num; i++) {
+		batch_id = req->cper_start_id + i;
+		if (batch_id >= overview->last_batch_id)
+			break;
+		count = amdgpu_virt_ras_get_batch_records(ras_core, batch_id, trace,
+					ARRAY_SIZE(trace), rsp_cache);
+		if (count > 0) {
+			ret = ras_cper_generate_cper(ras_core, trace, count,
+					&out_buf[offset], req->buf_size - offset, &real_data_len);
+			if (ret)
+				break;
+
+			offset += real_data_len;
+		}
+	}
+
+	if ((ret && (ret != -ENOMEM)) ||
+	    copy_to_user((void __user *)req->buf_ptr, out_buf, offset)) {
+		kfree(out_buf);
+		return RAS_CMD__ERROR_GENERIC;
+	}
+
+	rsp->real_data_size = offset;
+	rsp->real_cper_num = i;
+	rsp->remain_num = (ret == -ENOMEM) ? (req->cper_num - i) : 0;
+	rsp->version = 0;
+
+	cmd->output_size = sizeof(struct ras_cmd_cper_record_rsp);
+
+	kfree(out_buf);
+
+	return RAS_CMD__SUCCESS;
+}
+
+static struct ras_cmd_func_map amdgpu_virt_ras_cmd_maps[] = {
+	{RAS_CMD__GET_CPER_SNAPSHOT, amdgpu_virt_ras_get_cper_snapshot},
+	{RAS_CMD__GET_CPER_RECORD, amdgpu_virt_ras_get_cper_records},
 };
 
 int amdgpu_virt_ras_handle_cmd(struct ras_core_context *ras_core,
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
index 7e3a612eaeb0..addc693c2926 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.h
@@ -25,7 +25,13 @@
 #define __AMDGPU_VIRT_RAS_CMD_H__
 #include "ras.h"
 
+struct remote_batch_trace_mgr {
+	struct ras_log_batch_overview  batch_overview;
+	struct ras_cmd_batch_trace_record_rsp  batch_trace;
+};
+
 struct amdgpu_virt_ras_cmd {
+	struct remote_batch_trace_mgr batch_mgr;
 };
 
 int amdgpu_virt_ras_sw_init(struct amdgpu_device *adev);
-- 
2.34.1

