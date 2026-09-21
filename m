Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0309C982DE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 216AF10E446;
	Mon, 21 Sep 2026 07:53:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AZ4bAaM2";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A4E910E307
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:53:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZuPYJJVb8MqR3ZcKYRhTqFy24Q+8+CTm7VdyF7qVCbuKSyjHl4MCXXRq80RgvpnNUHAPe+FmIO4BSlE8rrRkQJCkWv8lDygKnHshegr5NbA30D1uAqKRxBZ7a8xRy/e0wPe5D9dMqUSW+c3kTrY4J7lX7+gzE5PDi95rUebo34WWizF1ekzYqujl2YTml2uEygCMjMjVW76yu4KbRtoI9YPd6yAXOFkLdJFYvK5IiRt3kXgMsPZa3ncBuDaTkkM/gGK+VlqJl2TcwUG0t7lW3YRqHM9hP2a6FZvLAEV8k+7TX78i/6HRAou2klCpfen68ptLR/Xh1iX29ZqVEJTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaH0XivxB00tfLSpFdg/2IvYY4SrT+4FkYsMIfnQFeQ=;
 b=ascQ0oSKu1oOfNybC492KbkWUh7oOdPqBMJDtOkXRV98OGRJx2wfyRUn0obkOvVoKDiBkPgew/q2Ml5D4O8P40j6dtsAV4HnB+L7TckOG5reEWX3aCm8d2w3va2QTOfPt4oF/1maoHVZN6V2rLQ+1ZQge6qZkmwxOZwlhpHdxCJOeo6l2R+ElQrXsb+ThxpizAbziv01rIGxFne1hprznNT64uH7ZoJq8YVLajZSy7F2H60HZLds0x/nEpWpiJ450hikScsbzMdhnIslu+VILf7PRTuF34D+6qVkUT1P9+yb27ha0eOk+8pJA3jRRDgXABmKbh8m9xzOlD+oCm3/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaH0XivxB00tfLSpFdg/2IvYY4SrT+4FkYsMIfnQFeQ=;
 b=AZ4bAaM2rwBe+rDFuI74EuOU/O3voZGEAuIXaAmq6vMfF3wmW6CnY5NTrWgTR7DzbaJQyesoIh34UfIhAWKxWVDtUwOz45Q7Q0IIbCOlRoTMB2FtEStZJHvDUSCTln2k5wMcCuXu1iY94AmWCQGNgVeXZimhu/3p06oKoHZBERk=
Received: from SJ0PR03CA0243.namprd03.prod.outlook.com (2603:10b6:a03:3a0::8)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:53:35 +0000
Received: from BY1PEPF00026957.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::65) by SJ0PR03CA0243.outlook.office365.com
 (2603:10b6:a03:3a0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026957.mail.protection.outlook.com (10.167.244.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:53:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:33 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:53:31 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 03/21] drm/amdgpu/gfx11: implement detect_hung_queue
Date: Mon, 21 Sep 2026 15:51:10 +0800
Message-ID: <20260921075326.2409021-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026957:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a8e361-4fab-4ab0-0fb0-08df17b56ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: CjinWRX5tBL2k58xYYPKxEB5q5OfnOfAI0xJqJLgW9KeP1iGU22wvEdKcZf+j3M1MfF8VAoHXQvBqGwAHmG4S7P5pFLRjOSVlE9HdDE8MMi3avcnbahGD0bZ6NlYfXMDZpWLnblwmtVCPnTtC3OjRMy/egfNvVBub9wfIr2UGXDgCkWbr0TnWHoCJ3sZEer4g4bTbsJA7IN3NsEbRrlXhmdit2nMvrstfE3GshnDjaoc2BPOPfjOVhI8FRxezlA7uAe5eno1v1Gs6sjaGPrg9r1iWtjAzf4MEuNA2/lDNUqpB9ptP8BdxPBBgLGVyAYpk/OFQ41aFchwmCr+TpV5owuEJ4h9MulYk8dUG4wIdiMzR7Ivq6480+zII0vRUNd9GfC/oZjKPCQpPlhV6H3xHP2kg/UpjJSRXnl6AV41cInq3R6c2cw/xqrROE1fpTXTGvB8RiMd15wQ7WTRkC1LrD4GOpdklYNNQW8gTg9CN2yzsEeFjDYFw4evheC1e1tyhbaq/AkSEWoKWYmR3oMrWiukYKu5SplumzxoziZPn2CbEQvUNAUMFGFaZbB6+yecho0LXIg3Ecz0GXKvQ9TRC13Fc8beGixqCD95RfKwlYv07sr24+pqTW6tMETV4eyKOljvA3CP2k+pOkYIbksNWv8gqB8PJNXYQ8iA3QlH/Lom6Vbj1QbaQg2wkb/Xm+j/J/NArMavv5CHMS3b2bR3iQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IE+Zo8/r7q4iYAKUPF56+Yr0sC6ownogQf29y5xaFceKQ/cxsBeXxAXGYTMGCSjHoO/7GAh1pYOQGsiTgR1RcUeg74jVWapM9/07gMAW3N62WD96wgRBZ4+KvxDbur+IXvOe4NOdCHIKiYkcO0qnQX4TkD6EH5ztsEkI+OqCso+wXP+HLBlX9iF8KDucKpk8c1qylGD6J0Zp3EpWPkxw0WZuV8w1lVrvwKV9jGW8lnyEr9ts7dNhnOw/AGH/f0a1bSADCXNWFe6SVUNw58AkMjeTc5QazH9oWLt8lkhP7gLWIvgdvi09mKo/HW8PvAtfmcWyqLCnAyfztsOVUD4NFbngnbXocRUTGA8/TCPw1AYwW0uj8aTs+HTBB5QVnGeu+33sQD6+sHcjDVpL4shVuR/5okRIzgH2r4k8pXlTZHQOxwLqc7+ILSM/fVxIDr2n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:53:34.3162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a8e361-4fab-4ab0-0fb0-08df17b56ff0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026957.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
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

Implement detect_hung_queue() by matching enabled HQD doorbells over
MMIO, allowing GFX reset to locate the queue without a MES request.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a7ed4923857b..76e133d283a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1102,6 +1102,43 @@ static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
 	}
 }
 
+static bool gfx_v11_0_detect_hung_queue(struct amdgpu_device *adev,
+					u32 doorbell_index,
+					u32 *me, u32 *pipe, u32 *queue)
+{
+	u32 i, k, p, db_ctrl, dboff;
+	bool found = false;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&adev->srbm_mutex);
+	for (i = 0; i < adev->gfx.me.num_me && !found; i++) {
+		for (p = 0; p < adev->gfx.me.num_pipe_per_me && !found; p++) {
+			for (k = 0; k < adev->gfx.me.num_queue_per_pipe; k++) {
+				soc21_grbm_select(adev, i, p, k, 0);
+				db_ctrl = RREG32_SOC15(GC, 0,
+						       regCP_RB_DOORBELL_CONTROL);
+				if (!(db_ctrl & CP_RB_DOORBELL_CONTROL__DOORBELL_EN_MASK))
+					continue;
+				dboff = (db_ctrl &
+					 CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET_MASK) >>
+					CP_RB_DOORBELL_CONTROL__DOORBELL_OFFSET__SHIFT;
+				if (dboff == doorbell_index) {
+					*me = i;
+					*pipe = p;
+					*queue = k;
+					found = true;
+					break;
+				}
+			}
+		}
+	}
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
+
+	return found;
+}
+
 static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v11_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v11_0_select_se_sh,
@@ -1112,6 +1149,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
 	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
+	.detect_hung_queue = &gfx_v11_0_detect_hung_queue,
 };
 
 static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
-- 
2.49.0

