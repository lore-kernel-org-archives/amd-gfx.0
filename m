Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74538C47BDF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E22510E4D2;
	Tue,  6 Jan 2026 10:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yJm0Pxrq";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011058.outbound.protection.outlook.com [52.101.62.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BF8310E4D1
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:14:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfXwspAI34DQOZCujJoEnbl5Yvb5ciK4ZZlIIwb5NXtClERux/fjWw/m62Qp/ZxdJ3vPiGgc8toB5kjwtubU4uIuoATTEAe24ZXNqDaxLlCD9WcPeVkEtkbwB7Yvp+V/YlAmywLHG3FAdbYEeVrl3gzZUYIVdzFGYwG9+TbOVxFmJ9jNVF8684QmmyhAqIe6JF1zlzqGdKZ0VQBF3hDY4+8w5hDe7wsvYph5R8gHttpb86EH5XZXuEsrIuCQ+azyeF0ZhHSXiPde2j1UUB6rJw1Fc4lk9sZ/DMbQOnC3IPPWptd9JLpdJhuO2HflBCAcO2krqDW7OYTrkVqFZWzByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yimffec9815VFPW7Z+LkSW/wF2raKIuRg3H/LYvnnjU=;
 b=HlXtVId3HtnV9UM+AsfedjKiBYnmbNm6UF4vG09O04s9ujmC24fCi2BOgnmHcWQFazQuxJ64FJKVSrIgo0u5owrsj1vtW5dFq6tGmT0K+iCT+n+XnzLt05KwQLb5mjQ3/fafAo0oXbvjW7/T6H3wcD8AEhgz1FzHhSjl2oFirRObs5EqjyTlWzf1f4rXTP2BJtOBlgjIdd/S5F0ZXNRoV25jWLI/h2ND+uArEbgZbLYZJl1vug51mZSSVE481ZXGHkdWHDZvZE16D/jBkkx9IJD/VmNEExr6lMrsVs3EVjsVZFBJwvo+aVLOyT88SthYZoiH+0smSLtSDTO6u6cHcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yimffec9815VFPW7Z+LkSW/wF2raKIuRg3H/LYvnnjU=;
 b=yJm0Pxrqtaf01VYfd2hz9fBRlaWyu9XcboZl44Xwl4Qvssdl5lDWXaOvjynrY8md9u6t7csDL2ujBL+RdxFCiNP0EKZqzQsXs715Vbm48i2+8m9I5YYRdZKl1hYv4tAt5cQFqap8+JF//HC0nza6fMNKm+k1/5/VTfrd8Gd9JE4=
Received: from SA9PR13CA0117.namprd13.prod.outlook.com (2603:10b6:806:24::32)
 by DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:14:16 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::9) by SA9PR13CA0117.outlook.office365.com
 (2603:10b6:806:24::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Tue, 6
 Jan 2026 10:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:14:16 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:14:14 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 20/21] drm/amd/pm: Add debug message callback
Date: Tue, 6 Jan 2026 15:42:40 +0530
Message-ID: <20260106101317.3856153-21-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260106101317.3856153-1-lijo.lazar@amd.com>
References: <20260106101317.3856153-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f9f7d1-f03c-459b-4281-08de4d0c5961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RJUYmVNyAmuelpUgPmY9Dc1s3QIl2jieZEOjHeGDbYH0ImamnI6tjR0UC1Ag?=
 =?us-ascii?Q?IP06IpurQmtBC96lw5Sf2l9cI//+zVfsSc+ZMHcvhmP7mldqnJtZI/tlWabl?=
 =?us-ascii?Q?+HQJYqh3uEeK+EMA4PdPck9cnP4hiOC4edXOoaD59aUK2uPe5cLg54s2STs0?=
 =?us-ascii?Q?VeSkOa4c/AjgksIW+HdWT1p8BHCpjUBHn7Y4XzHl9W0gd6Gz3cOUFBpRmwGQ?=
 =?us-ascii?Q?IWNLqilOTTXlfD/jHDd+U/03jh4YHJM+5sDIq8J2RiINwxneK2f+qw6QctlX?=
 =?us-ascii?Q?st57k1vidPrrYLePRfQmIhAuzqp678e7iJoUqB4hI4uF2UXL77trjfadGcMz?=
 =?us-ascii?Q?kPFb+US5AmGZpZiDSK4oUrq0YcEYhHzwIMV6wFKYvbiO1aU1botWRP5xdeE6?=
 =?us-ascii?Q?48zOQDkcRojGPShen6a24e3+0dYKRcOE0KHiJB7vYEWlYcZqahg8e/WO6Mhm?=
 =?us-ascii?Q?vwOXWFaUPMfZhEOGk5y+VVAAX7KV+mflBfmdbbez+fV/pokuKh7yod6R0Mo7?=
 =?us-ascii?Q?IUILyo6mwipGObI3wHj6RL8ab6lRJ/XK5zjl51D6pQdd2qP2WA0MchwATylD?=
 =?us-ascii?Q?FiRC8beHBwXiGFVpirnGBh4BQVIUQL5lu5a3+IJ6nG/dGAtXv7uNLmQ6r6e2?=
 =?us-ascii?Q?GfqEKVNo6AXFhtVmLdZNDmo0zJsDnVuU9XryDzxcLxrEqAueIqn6ry/p3Tnm?=
 =?us-ascii?Q?dLaIRs6sdBgsMjsRR8GbcZ/IjcWb/Etvcf3lZ+PrQDZaUoygRmpDS4IUmTDm?=
 =?us-ascii?Q?DF83oNYoEhtgHeaGxGg04FHwb8Pfw6TY5t1zSfDrToQzrl6D1DxuKux45eTS?=
 =?us-ascii?Q?n9iLClWrwZYjAS6mXZz3eXfa4+P7TCJwXGmmGY15t+dt9u1eELeSMsIyeXFF?=
 =?us-ascii?Q?bzvUgjNSYi7wQS6wwbEosmUdVAYPsFuXngVY7rGZFiINqJZEoTK2Z0GajA83?=
 =?us-ascii?Q?aXzKGxrJwWpp9joTJaWHvK9Zf5F/rw/V/RqC92t64c0Cw/baQKVHyuPQ0jZ/?=
 =?us-ascii?Q?pMsk6jTQrMH1NmYfaT8B89rcTcyBtk5EQ7ChMjKKWLIjIlovRUmYfN/RtbwH?=
 =?us-ascii?Q?9/Lb0dXbBBMxwpoFU6q2lCOkUuKD313Re35JR+D67X3Cn5gR19+BeGPX0DzJ?=
 =?us-ascii?Q?X4PloK5cQcRuYMcaMT+Wshaj5FoQO5nYSgnPUFD7odTfXnu8pnpibbmD7BO2?=
 =?us-ascii?Q?8ioDfXyJKL1LoNUJWxKcGpi8JzKLhiEWv9jMWvue3vfdxnSg1WEmJn8+5Zfs?=
 =?us-ascii?Q?7hNu80c7DJgWQkrrQ/v3CuwT/UyEP7rGss8O8jeOZY9mj1uZ0uRempSnGk1n?=
 =?us-ascii?Q?MH0AiTeved2ZpY8PbLiKyrczIwMIpdkUfmlU/3u2QOW+/LMcPmzQp1NKwqQt?=
 =?us-ascii?Q?RcGW+1yeNmLJtQC6VSgO0i9LcKzLev3zCMq4Y027Y448xR6OkoB8C0YqUyC7?=
 =?us-ascii?Q?zyra880Lzqle8+3fxUxFYo9uxl7RPqM7tZk88FNI1Jfs5+nmUttSxNYAA4cU?=
 =?us-ascii?Q?d7kRas5xXHMPGOL12aUw+cLSGNpwllZKnCTMdPnic7JwU/cf+EXbtcXM0wX3?=
 =?us-ascii?Q?xpBpoZLGLyeZbzoxLq4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:14:16.7313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f9f7d1-f03c-459b-4281-08de4d0c5961
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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

Add callback in message control to send message through debug mailbox.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 12 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 20 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 93c943151721..9b151425feb6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -557,6 +557,9 @@ struct cmn2asic_mapping {
 #define SMU_MSG_FLAG_ASYNC	BIT(0) /* Async send - skip post-poll */
 #define SMU_MSG_FLAG_LOCK_HELD	BIT(1) /* Caller holds ctl->lock */
 
+/* smu_msg_ctl flags */
+#define SMU_MSG_CTL_DEBUG_MAILBOX	BIT(0) /* Debug mailbox supported */
+
 struct smu_msg_ctl;
 /**
  * struct smu_msg_config - IP-level register configuration
@@ -564,12 +567,18 @@ struct smu_msg_ctl;
  * @resp_reg: Response register offset
  * @arg_regs: Argument register offsets (up to SMU_MSG_MAX_ARGS)
  * @num_arg_regs: Number of argument registers available
+ * @debug_msg_reg: Debug message register offset
+ * @debug_resp_reg: Debug response register offset
+ * @debug_param_reg: Debug parameter register offset
  */
 struct smu_msg_config {
 	u32 msg_reg;
 	u32 resp_reg;
 	u32 arg_regs[SMU_MSG_MAX_ARGS];
 	int num_arg_regs;
+	u32 debug_msg_reg;
+	u32 debug_resp_reg;
+	u32 debug_param_reg;
 };
 
 /**
@@ -597,11 +606,13 @@ struct smu_msg_args {
  * @send_msg: send message protocol
  * @wait_response: wait for response (for split send/wait cases)
  * @decode_response: Convert response register value to errno
+ * @send_debug_msg: send debug message
  */
 struct smu_msg_ops {
 	int (*send_msg)(struct smu_msg_ctl *ctl, struct smu_msg_args *args);
 	int (*wait_response)(struct smu_msg_ctl *ctl, u32 timeout_us);
 	int (*decode_response)(u32 resp);
+	int (*send_debug_msg)(struct smu_msg_ctl *ctl, u32 msg, u32 param);
 };
 
 /**
@@ -617,6 +628,7 @@ struct smu_msg_ctl {
 	const struct smu_msg_ops *ops;
 	const struct cmn2asic_msg_mapping *message_map;
 	u32 default_timeout;
+	u32 flags;
 };
 
 struct stb_context {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 6b673eefc7b1..f639d3636d30 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -83,6 +83,25 @@ static const char *smu_get_message_name(struct smu_context *smu,
 
 #define SMU_RESP_UNEXP (~0U)
 
+static int smu_msg_v1_send_debug_msg(struct smu_msg_ctl *ctl, u32 msg, u32 param)
+{
+	struct amdgpu_device *adev = ctl->smu->adev;
+	struct smu_msg_config *cfg = &ctl->config;
+
+	if (!(ctl->flags & SMU_MSG_CTL_DEBUG_MAILBOX))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&ctl->lock);
+
+	WREG32(cfg->debug_param_reg, param);
+	WREG32(cfg->debug_msg_reg, msg);
+	WREG32(cfg->debug_resp_reg, 0);
+
+	mutex_unlock(&ctl->lock);
+
+	return 0;
+}
+
 static int __smu_cmn_send_debug_msg(struct smu_context *smu,
 			       u32 msg,
 			       u32 param)
@@ -541,6 +560,7 @@ const struct smu_msg_ops smu_msg_v1_ops = {
 	.send_msg = smu_msg_v1_send_msg,
 	.wait_response = smu_msg_v1_wait_response,
 	.decode_response = smu_msg_v1_decode_response,
+	.send_debug_msg = smu_msg_v1_send_debug_msg,
 };
 
 int smu_msg_wait_response(struct smu_msg_ctl *ctl, u32 timeout_us)
-- 
2.49.0

