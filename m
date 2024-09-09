Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC70ECE588
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 914AD10E686;
	Mon,  9 Sep 2024 20:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EYB+4sjj";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B0310E686
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqpFFopfgnzelcl9j4MpQdX0a0ixP7feVI2u6NXkHZGXzyDx45KxXZsu1FzF59pqWtrJLGKKmWT+ZSPvPH5KH1CRgbnDFBiKQ+dsTSy8xO7GVbMLyg77+lbEIOKKB8v35B7FJ0TIsvz7AU8i+9sTm09P1dxixvMjHBsXJf/HbNyJMKN559UD6+h9eNjiiOfzOZ4GwgfAHNO2oKnAxogU9UcVZzjg176IkbwcWtt0fcWhkbnERbDC1ZA/cpICzwku8fkZ++EgScKdyIa7zE1Gg2hQ3wyie3TE1gG3llLi670I1C8Au97gA9lYuBja1cErwfV6VMAQEfgPyquOTiWKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKexRRpuSR7XndzY1OVLm2sIEYIRqhxZEG6MnfoWpkA=;
 b=DNpSXdV4rp1df54lXLBUnVqN//eawdlYZZv/pWZ2ypAqnS/DBeDgKHHdxAxT90uEO2/ORwOMwotQ5N8NZnDYUBKMv1j3iIsbBbVQqkqSpVpgnF7zLIHB1u8BzqR3Kv/YwxT20spSYt6/pSMayUKpxRgENx7on5K/v3AfNBDIKopZ4emb8fuq9xHVTod3i5FIbUA1+AroEC2qO66/QK6w3wFA6IS84qsJBh0Hv3bhOB2L1zN0wMHlcSLXGokrc1u3NBdeHGZLS0AiKPphHeuY64dGEH3HFeNzl7u7kdAarZXdf5zUPYJXEEE0GZGFwS7k+M964HCfD0vNx8buQuZbSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKexRRpuSR7XndzY1OVLm2sIEYIRqhxZEG6MnfoWpkA=;
 b=EYB+4sjjI1BUlgsFytxFaTDIEqYuQdhrNMImiSAPTKuyWkk7sYtIfEL9Kdq/BBJ8IVpg7RFSdqmu4rZBG3hDhGiIvZr5UESVx6FlJFxvt5BtQheXqhXYFC0BW4CTMgzLMWDvl7ReOrEFR13/Xc+sZ13gMQFsXjA1xc6HiMys3nk=
Received: from MW4PR03CA0323.namprd03.prod.outlook.com (2603:10b6:303:dd::28)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 20:07:21 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:dd:cafe::18) by MW4PR03CA0323.outlook.office365.com
 (2603:10b6:303:dd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7982.0 via Frontend Transport; Mon, 9 Sep 2024 20:07:21 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:18 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shashank Sharma <shashank.sharma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH v11 22/28] drm/amdgpu: add userqueue suspend/resume functions
Date: Mon, 9 Sep 2024 22:06:08 +0200
Message-ID: <20240909200614.481-18-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3f74e1-08ad-4699-f1ed-08dcd10b03ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1+ooaRsPqH8aA5fsyc9iLNQXQJeLpW6yFh/Llq5TrROqFBroZaV+WOmfrFCZ?=
 =?us-ascii?Q?pfbyY6az/+L6+VzpbyEbh4aXqx8yr4eMSMXy1v96/m7XmjQ7jHiyEudnG9G9?=
 =?us-ascii?Q?zt7y7If/NJZR7nDNqIAcd4FR/8xqyyr8ziQ1E7aoCPQWX9fPybBPzbIG9FyP?=
 =?us-ascii?Q?oLN3m4IFOSFdpBjanMgWu1PS+TRtZrHH9m5pVvUujXpKkiQ+fSs4izHpC1nr?=
 =?us-ascii?Q?vo4HfCKg3uwAz2g/1v1+RCG6sYNFuPNgEEeTtrNNoEUWlj4g4zYaVZvcwiUn?=
 =?us-ascii?Q?kZWASZDI+OLhPxRZqs+4PDJHp+qyjdUoafDVPKkWPk+1AjN1IbKqZDtYXeR0?=
 =?us-ascii?Q?2g1ptPcGhl9IoAE9dv9fbp7w2NEpmMKkvNwNExiSjdS+/WtVP/lI/ik2ViG+?=
 =?us-ascii?Q?zaqzvaVY5tmFgBBVxzq1t/b+lNhPUQvXBIQ4RKuy7blQ9QLQXLyQHL5m+Orr?=
 =?us-ascii?Q?eGiXT8vf7Ai6dKoRnzWyt+kBv5Rbf+2MuozcFvxtSBVOqraI9qi0evw5m5c+?=
 =?us-ascii?Q?mO9ldYyN9OLhh41Tyutlx1jAnuCrKo87KLTqXYtdK8QMlt2ysKgYCG9nj1oq?=
 =?us-ascii?Q?R3d1jAXyguc+cpQ/XW1NQRTqLubPGp+mY5sx9AL/cZdHj8Z6Y4m8K1VmD54U?=
 =?us-ascii?Q?djYofZElFM/A6KNiVw/LTCSxkOEQdolBoJQvLYxmLmiWMNbDv6/ZGUpKRfZW?=
 =?us-ascii?Q?r7C92hNmvwE8RcuAELpjUXPp1dYBLGU29QJVpB36YaAFTlL18HNnBU+mnn3p?=
 =?us-ascii?Q?8f1mlnslKXUFsneB00O3zbfDu519FV02p4UlGQnd6KZAosYiThDaA5TLVnYU?=
 =?us-ascii?Q?omxbVgZ3UPBC0aTXgo1z/fBb2VeLNNhbo9hZV+97LfXD1+/+a/CNpGKI3Ws4?=
 =?us-ascii?Q?cPB8JLhBKWIZ7u3DHbmYiNMgEsL1nFunKxu4pjQM6QWxbcr9fpi/DBL1m6Lo?=
 =?us-ascii?Q?gK3j5wXHYBijrzU5dXF1VgE+b4HxiUOCgugN9PJaFBEvHroAPFkKoRhvMqpy?=
 =?us-ascii?Q?u9Ih6sNTxzJd9X2Z/ZZZwJsVvqq0uSUDT3GmFeZUh1R1YMNpCMXfUqo8oTZu?=
 =?us-ascii?Q?LOwrQwBoSUDYhmWeWoRJhqIhSdNLk7+BHRnHWh+IpQafbUQRUiLpj2VtJuI3?=
 =?us-ascii?Q?m8pFxV/NvIvCkUiW/jq8+95YAyrBAtgG4iEzz4HGElTPkSuzEuLxaichh+8e?=
 =?us-ascii?Q?kW+/1Vgc/McfLv6/Wl7xNmeoxb8Kovir0VHa4rQSbDmYL1kpXKP1jteWkzVE?=
 =?us-ascii?Q?3SL4pknKSlwSWdLrFdiz6y2Hnonvisnoryk1T27XEpjsEuOXgK8IiN09hU8g?=
 =?us-ascii?Q?3Tuox53fOUuJTNwv6oqV+my9s6M+tYaMmNpMgfItuDlMWvR5MKeQTMh3IiWk?=
 =?us-ascii?Q?ZRZY37B54O3CznO02DUE9B34ay09MU8kLDLJ+gOtx02FlhXGYVbsm859OVZY?=
 =?us-ascii?Q?MynaeH+lGt24ZNfoKUhBmQNIlUVZSqPy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:21.4625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3f74e1-08ad-4699-f1ed-08dcd10b03ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
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

This patch adds userqueue suspend/resume functions at
core MES V11 IP level.

V2: use true/false for queue_active status (Christian)
    added Christian's R-B

V3: reset/set queue status in mqd.create and mqd.destroy

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Reviewed-by: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 33 +++++++++++++++++++
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |  5 +++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
index b3aa49ff1a87..51c9a215ae77 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
@@ -331,6 +331,7 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_ctx;
 	}
 
+	queue->queue_active = true;
 	return 0;
 
 free_ctx:
@@ -354,9 +355,41 @@ mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
+	queue->queue_active = false;
+}
+
+static int mes_v11_0_userq_suspend(struct amdgpu_userq_mgr *uq_mgr,
+				   struct amdgpu_usermode_queue *queue)
+{
+	if (queue->queue_active) {
+		mes_v11_0_userq_unmap(uq_mgr, queue);
+		queue->queue_active = false;
+	}
+
+	return 0;
+}
+
+static int mes_v11_0_userq_resume(struct amdgpu_userq_mgr *uq_mgr,
+				  struct amdgpu_usermode_queue *queue)
+{
+	int ret;
+
+	if (queue->queue_active)
+		return 0;
+
+	ret = mes_v11_0_userq_map(uq_mgr, queue, queue->userq_prop);
+	if (ret) {
+		DRM_ERROR("Failed to resume queue\n");
+		return ret;
+	}
+
+	queue->queue_active = true;
+	return 0;
 }
 
 const struct amdgpu_userq_funcs userq_mes_v11_0_funcs = {
 	.mqd_create = mes_v11_0_userq_mqd_create,
 	.mqd_destroy = mes_v11_0_userq_mqd_destroy,
+	.suspend = mes_v11_0_userq_suspend,
+	.resume = mes_v11_0_userq_resume,
 };
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 77a33f9e37f8..37be29048f42 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -37,6 +37,7 @@ struct amdgpu_userq_obj {
 
 struct amdgpu_usermode_queue {
 	int			queue_type;
+	uint8_t			queue_active;
 	uint64_t		doorbell_handle;
 	uint64_t		doorbell_index;
 	uint64_t		flags;
@@ -57,6 +58,10 @@ struct amdgpu_userq_funcs {
 			  struct amdgpu_usermode_queue *queue);
 	void (*mqd_destroy)(struct amdgpu_userq_mgr *uq_mgr,
 			    struct amdgpu_usermode_queue *uq);
+	int (*suspend)(struct amdgpu_userq_mgr *uq_mgr,
+		       struct amdgpu_usermode_queue *queue);
+	int (*resume)(struct amdgpu_userq_mgr *uq_mgr,
+		      struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.45.1

