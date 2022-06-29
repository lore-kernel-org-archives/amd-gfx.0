Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A266C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 03:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC1C10F442;
	Wed, 29 Jun 2022 03:21:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 058BD10F442
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 03:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBIFXTEJrp9x5xW/pmU2mtDZTrJfmHacULRA5gkLPPxkpnbL1hGi4GO88vmVOdOicxPlaCZgnigQuyHuwd26DgY7AnW9wItZd6Wd+u68CVNt8CXw67J5JcMS35TJ5daMrNPf4eVovXmlz53aKtpKogGeCImmFdQGTrdycGQ76rz2Td+tKzbihNjK0GKoghpbo12gJmZTq2mD3kvRhq5mx1UMBMi8NB8Qoyv9+gZqlgV1Ssuk1OiRKX+vDQ60zRnd8+W/bV2CAYpN2SHpDsAz+NG3dPVpHqRySbV51z/GHr7ymoYnlcfINfT/SpPEyiAq6qyc5icbtHWeDxqErn6UNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJh8DncghxxktnPbk8Lj/8CPiMce/vvkIKPzMMfE3N8=;
 b=EaltYDIh4EyzAW61kQwSrXKb7h0BQs8PP6N8vW9XkAxtpsJa/i6KU3mOxzDwPctVWAS9WaJ52rvdDovAj9/bNwu3EzW0hDcDu4TJ87+QlToDWWHRmXQ81rNG3wk90jep+ApI/LwhlI7rGd4QzOT98j54sotbxWElXq0ZnoBV5Fi2/W6DQAQfb4hEoM3tVSWYHH4JBqVwuLp8j8e2vUhju4JWoZfW/nSq6eHu3zEcBsjyQrhld7IL4XJgiKkLF+D6BUJvIgdIl648IVpA42kxcB3+v5a4XaRlon//dMWZRmXPb4C6bE2OODsz2XMK4iJ89+frBeiOlKb2MZSBMOz9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJh8DncghxxktnPbk8Lj/8CPiMce/vvkIKPzMMfE3N8=;
 b=JGGnDEda6+M/z3kQoJk1ptUY2NzKaIBsLmQGojtx46a0t1y/rzX3pH6WGTwvdC2n5B4w4YqYY11QfNZ0L7m32LpCla2OXlnEQz0hZLjN+i3Z//jWlJrAOmdk8+yAg9plWNHslBA0ZI5tn1MGaHWeBPogGEiMTyYHVTAWfQjjDV8=
Received: from DM6PR05CA0050.namprd05.prod.outlook.com (2603:10b6:5:335::19)
 by MN2PR12MB3245.namprd12.prod.outlook.com (2603:10b6:208:103::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 03:21:33 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::31) by DM6PR05CA0050.outlook.office365.com
 (2603:10b6:5:335::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 03:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 03:21:33 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 28 Jun
 2022 22:21:09 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/7] drm/amdgpu: add common interface for mes misc op
Date: Wed, 29 Jun 2022 11:20:29 +0800
Message-ID: <20220629032034.2994328-2-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629032034.2994328-1-Jack.Xiao@amd.com>
References: <20220629032034.2994328-1-Jack.Xiao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6bc9baa-de3a-4379-0cfd-08da597e7790
X-MS-TrafficTypeDiagnostic: MN2PR12MB3245:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMn1IFZN0hZnzUARkcdFriJBcqoqC99iySYmGxgn7D9TYqzehaxeLeqgHnes4YdvfkdQHbEcxMod8XksdaLF1GGIshgYT6RuDzfHuqfkubyRCAaJODAC8b6uYHRPz5tN1FG0HtLiB0AlL1d/iho+PBUEqKzFp72vwLePH6h6kg1Zmv4k1ouvOGoagE9/IiTzoxkta4jeLpZwo3HfwmPLeNjX+nmEr9cjJQKuEdqZkbYfjiTQ1Ws8+1rg86Mu4EV7d0IBfKdg8LKw2wKmIL2gwK8azzZpm98EOIFCrCO2yIwH0G76aUbhsETgGj61DaGXntqvPaKaggpLE1YmIMDMV77uDIOT3HlahNqRrHGd5w74GmFkN231wOtJHoLUvRS7UlbO2ir8BnTldRea2b7pAYbuiXZsqtBrrSp9NVLWHhTV8UFqiw+6ylzVGcZg21DMZNoAOHeThKwX7ze5W8ZeVdUcOQYaI1TGk/mMN5IRCAZkl8HA3IxkecU0m8f06Jt7WH6Nt2wlkmCcBNpvsjpXvEMio1UdaySCFwvPVi/ARkNvEWzi55zlmApmTdZHTrsBMO/lylR7ctKYRA45M042WfA5lY5PBOovaoAGARGyE/aqRqHo8wLOirMNmMi2VlM8Nd6NqEudp+ub+QG+xGHRtX0N4ohy2nKFt8Rh19JzSP+dTwTwaGKxLDXro5VisZpBK2lD86Q6j4pbfUMTYVYQpZd6F7AW5fLqQ3gkzNVCOeo4JpNBc2/B5j8Xai8AIE1+tLH4L2mbQ2C2rVUJTuymJg0f9DvqQS6wwohpOitepqMBXGZNLqwpA3mmfJBNvoP5nKk8YyKy7yBzHm2V1PBqRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(346002)(36840700001)(46966006)(40470700004)(356005)(36860700001)(6666004)(41300700001)(70586007)(82310400005)(5660300002)(8936002)(336012)(186003)(478600001)(83380400001)(36756003)(82740400003)(47076005)(1076003)(426003)(2616005)(81166007)(6916009)(40460700003)(316002)(8676002)(86362001)(4326008)(7696005)(16526019)(2906002)(70206006)(40480700001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 03:21:33.1308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bc9baa-de3a-4379-0cfd-08da597e7790
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3245
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add common interface for mes misc op, including accessing register
interface.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 46 +++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 92ddee5e33db..93b2ba817916 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -108,6 +108,10 @@ struct amdgpu_mes {
 	uint32_t			query_status_fence_offs;
 	uint64_t			query_status_fence_gpu_addr;
 	uint64_t			*query_status_fence_ptr;
+	uint32_t                        read_val_offs;
+	uint64_t			read_val_gpu_addr;
+	uint32_t			*read_val_ptr;
+
 	uint32_t			saved_flags;
 
 	/* initialize kiq pipe */
@@ -246,6 +250,36 @@ struct mes_debug_vmid_input {
 	uint32_t	oa_mask;
 };
 
+enum mes_misc_opcode {
+	MES_MISC_OP_WRITE_REG,
+	MES_MISC_OP_READ_REG,
+	MES_MISC_OP_WRM_REG_WAIT,
+	MES_MISC_OP_WRM_REG_WR_WAIT,
+};
+
+struct mes_misc_op_input {
+	enum mes_misc_opcode op;
+
+	union {
+		struct {
+			uint32_t                  reg_offset;
+			uint64_t                  buffer_addr;
+		} read_reg;
+
+		struct {
+			uint32_t                  reg_offset;
+			uint32_t                  reg_value;
+		} write_reg;
+
+		struct {
+			uint32_t                   ref;
+			uint32_t                   mask;
+			uint32_t                   reg0;
+			uint32_t                   reg1;
+		} wrm_reg;
+	};
+};
+
 struct amdgpu_mes_funcs {
 	int (*add_hw_queue)(struct amdgpu_mes *mes,
 			    struct mes_add_queue_input *input);
@@ -264,6 +298,9 @@ struct amdgpu_mes_funcs {
 
 	int (*set_debug_vmid)(struct amdgpu_mes *mes,
 			   struct mes_debug_vmid_input *input);
+
+	int (*misc_op)(struct amdgpu_mes *mes,
+		       struct mes_misc_op_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
@@ -296,6 +333,15 @@ int amdgpu_mes_unmap_legacy_queue(struct amdgpu_device *adev,
 				  enum amdgpu_unmap_queues_action action,
 				  u64 gpu_addr, u64 seq);
 
+uint32_t amdgpu_mes_rreg(struct amdgpu_device *adev, uint32_t reg);
+int amdgpu_mes_wreg(struct amdgpu_device *adev,
+		    uint32_t reg, uint32_t val);
+int amdgpu_mes_reg_wait(struct amdgpu_device *adev, uint32_t reg,
+			uint32_t val, uint32_t mask);
+int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
+				  uint32_t reg0, uint32_t reg1,
+				  uint32_t ref, uint32_t mask);
+
 int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 			int queue_type, int idx,
 			struct amdgpu_mes_ctx_data *ctx_data,
-- 
2.35.1

