Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D538C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 04:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E0B10E701;
	Wed,  8 Nov 2023 04:17:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA81D10E6FD
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 04:17:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeWSX/8spI2I2PGjzt9gXGt+kiIiS6ZW7rrnObrAHQVgOlwCkv18zE4ioj5aw9/T8S+cEVCY6NhsaKaXGBej0tgv0rfQPe+7W0IW6GKMksOKD+L568iGZ1p2cxKwRlWrMrKEBcGcHGaBvPWifnztH9A3YdbdOJ36+T+DIGfm85HfYeKo+R7idKddxSXiuDYcZ2Z5oLMf0+euwdkeGO+64tCDjgxj0W9t1u9aVN7oxA84//9JRyByr5CwUCzu9uL38RSOGCu2BwUVCbz7YzzGj2GEVcRfuguXn4mNMirxQBcNJ+tJW2a01X+zyxysqMIxHygCbmNNBWFC8YgKyH7m0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49z35dRJ5a/vx/+u3Wy4A1DuuV2YMjOumUg7PM3f6GI=;
 b=fieV971k/xyhzIFgOCRcoZpB41/0PRFPbe++6ZMaabnv0m1NxnGRtHrTa/W1s6bIVraAD1ZHY6lpU0RrT4zcyGNksvjAL7Rx5u7/zZpx0Dnyf+w/JvBP4iUBjAtJmShTykpH48M4lW98Q/Y9jiIVm7MX1EwicsnmiUs+S71N84OrGEBq3ejS715IqKcwGoJZsRE9Pnoyk3N+OfN5M2fcPsyi7UUA3AjVY2rk3c2s1aD7VUCYIfuHAhnjGKPM2zIkK2aB8CBZRcGW42C/JwsoAkNHHXLyAdILcQNFtCedbvt71RSCEiGLUiEUag9xOSuEHGD75RERsozKHl9SSqbodw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49z35dRJ5a/vx/+u3Wy4A1DuuV2YMjOumUg7PM3f6GI=;
 b=WrFmYJS3o5zvi8qRr7Yy+da2DUyuYlYiReDrvbWoMmY8Xc0ewkWjIGnngh6tlBectLbnkha+sLM6nIfkZ8b2FjXYJiPGPifPsUdFJhQeDxcdRv9cGbRa2vSo8ovJTk1GfXSInsFpnio3Oj6Ba1Ue/sVIpfEcyxGNNptTyP6Y/wE=
Received: from CH0PR04CA0072.namprd04.prod.outlook.com (2603:10b6:610:74::17)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 04:17:39 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:610:74:cafe::ae) by CH0PR04CA0072.outlook.office365.com
 (2603:10b6:610:74::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 04:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 04:17:39 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 22:17:37 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amdgpu: Read aquavanjaram USR register state
Date: Wed, 8 Nov 2023 09:47:05 +0530
Message-ID: <20231108041705.528194-6-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108041705.528194-1-lijo.lazar@amd.com>
References: <20231108041705.528194-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f1c9fc-4e1d-410f-84c3-08dbe011a546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykYhMXMuo6gxpLRWNde6ZKmHVT75KvZvfV/4DMHCjGzv/yKHOfiS9XKqGLztyRuirjHcwVC0tEJibQDaqLIQ4U+FJGMgpxHOIBWuhH0EmQMlFPLk6n7YcaJpEfLe4M76NEwnEoYDKf6a1jmPyVbyL2Mm1BFaEj02j2AdempK9j8VQd48tBfPOWfkqgN6p/sMYPdaJIBNllt5GHMOIBDlMJvJXP4Aj1gSB+WfrCtaK9A9t+JR8nRiDlIVa3NJseqQJvpFDjv8iUtwiHwIR/LGiIZ/Kg2T3VuaDXQZhALSxpP+rLqHK4vxUhixQMyu6c9gFG5YS9vOAZ4M67Hcw+lu8W++XtuD9wFXyzXa/taWLhGhxLSeDySSCEQl+PHtsVKaQ893rwQ602y9V6z/oSC/Beh7jrtkg0H3wN7CjK64a7+sq9JB2vfDgTbdy6YVq31qevb1tjWm5mdEqLGppdMJ5BVjQdYDfniRR+uqGKt5T4EgF1tMZIZgryoijp9gun1CmsktC6j4qkH6tb2n8ncGxqzHcLkAmq5Sed48th/cP9CkupunZl1xZTvxp3nvO7nOaIYnfHDexI+HcxToUagd8wkbw/s35OucC5oHFl7wtsfP9OeCrrWckaf6M/oimT1Rr95OiDueSBRaifglTueNSi0W756RiWr6fsc4adQuOXlfm6I6MqoKWAS+sosSKtgbLAUREDhbX2O9aFOnU/5HnSy4fTWiwaBMbrPL/KXbIG2elln6Jus0+1ZKFou/9x2R
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(40470700004)(36840700001)(46966006)(40460700003)(508600001)(70206006)(36860700001)(47076005)(86362001)(36756003)(356005)(81166007)(7696005)(336012)(2616005)(426003)(316002)(70586007)(6666004)(54906003)(6916009)(16526019)(26005)(1076003)(8676002)(2906002)(5660300002)(4326008)(8936002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 04:17:39.3266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f1c9fc-4e1d-410f-84c3-08dbe011a546
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support to read state of USR links in aquavanjaram SOC.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 127 +++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index eec15f1c143f..d6f808acfb17 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -921,6 +921,125 @@ static ssize_t aqua_vanjaram_read_wafl_state(struct amdgpu_device *adev,
 	return wafl_reg_state->common_header.structure_size;
 }
 
+#define smnreg_0x1B311060 0x1B311060
+#define smnreg_0x1B411060 0x1B411060
+#define smnreg_0x1B511060 0x1B511060
+#define smnreg_0x1B611060 0x1B611060
+
+#define smnreg_0x1C307120 0x1C307120
+#define smnreg_0x1C317120 0x1C317120
+
+#define smnreg_0x1C320830 0x1C320830
+#define smnreg_0x1C380830 0x1C380830
+#define smnreg_0x1C3D0830 0x1C3D0830
+#define smnreg_0x1C420830 0x1C420830
+
+#define smnreg_0x1C320100 0x1C320100
+#define smnreg_0x1C380100 0x1C380100
+#define smnreg_0x1C3D0100 0x1C3D0100
+#define smnreg_0x1C420100 0x1C420100
+
+#define smnreg_0x1B310500 0x1B310500
+#define smnreg_0x1C300400 0x1C300400
+
+#define USR_CAKE_INCR 0x11000
+#define USR_LINK_INCR 0x100000
+#define USR_CP_INCR 0x10000
+
+#define NUM_USR_SMN_REGS	20
+
+struct aqua_reg_list usr_reg_addrs[] = {
+	{ smnreg_0x1B311060, 4, DW_ADDR_INCR },
+	{ smnreg_0x1B411060, 4, DW_ADDR_INCR },
+	{ smnreg_0x1B511060, 4, DW_ADDR_INCR },
+	{ smnreg_0x1B611060, 4, DW_ADDR_INCR },
+	{ smnreg_0x1C307120, 2, DW_ADDR_INCR },
+	{ smnreg_0x1C317120, 2, DW_ADDR_INCR },
+};
+
+#define NUM_USR1_SMN_REGS	46
+struct aqua_reg_list usr1_reg_addrs[] = {
+	{ smnreg_0x1C320830, 6, USR_CAKE_INCR },
+	{ smnreg_0x1C380830, 5, USR_CAKE_INCR },
+	{ smnreg_0x1C3D0830, 5, USR_CAKE_INCR },
+	{ smnreg_0x1C420830, 4, USR_CAKE_INCR },
+	{ smnreg_0x1C320100, 6, USR_CAKE_INCR },
+	{ smnreg_0x1C380100, 5, USR_CAKE_INCR },
+	{ smnreg_0x1C3D0100, 5, USR_CAKE_INCR },
+	{ smnreg_0x1C420100, 4, USR_CAKE_INCR },
+	{ smnreg_0x1B310500, 4, USR_LINK_INCR },
+	{ smnreg_0x1C300400, 2, USR_CP_INCR },
+};
+
+static ssize_t aqua_vanjaram_read_usr_state(struct amdgpu_device *adev,
+					    void *buf, size_t max_size,
+					    int reg_state)
+{
+	uint32_t start_addr, incrx, num_regs, szbuf, num_smn;
+	struct amdgpu_reg_state_usr_v1_0 *usr_reg_state;
+	struct amdgpu_regs_usr_v1_0 *usr_regs;
+	struct amdgpu_smn_reg_data *reg_data;
+	const int max_usr_instances = 4;
+	struct aqua_reg_list *reg_addrs;
+	int inst = 0, i, n, r, arr_size;
+	void *p;
+
+	if (!buf || !max_size)
+		return -EINVAL;
+
+	switch (reg_state) {
+	case AMDGPU_REG_STATE_TYPE_USR:
+		arr_size = ARRAY_SIZE(usr_reg_addrs);
+		reg_addrs = usr_reg_addrs;
+		num_smn = NUM_USR_SMN_REGS;
+		break;
+	case AMDGPU_REG_STATE_TYPE_USR_1:
+		arr_size = ARRAY_SIZE(usr1_reg_addrs);
+		reg_addrs = usr1_reg_addrs;
+		num_smn = NUM_USR1_SMN_REGS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	usr_reg_state = (struct amdgpu_reg_state_usr_v1_0 *)buf;
+
+	szbuf = sizeof(*usr_reg_state) + amdgpu_reginst_size(max_usr_instances,
+							     sizeof(*usr_regs),
+							     num_smn);
+	if (max_size < szbuf)
+		return -EOVERFLOW;
+
+	p = &usr_reg_state->usr_state_regs[0];
+	for_each_inst(i, adev->aid_mask) {
+		usr_regs = (struct amdgpu_regs_usr_v1_0 *)p;
+		usr_regs->inst_header.instance = inst++;
+		usr_regs->inst_header.state = AMDGPU_INST_S_OK;
+		usr_regs->inst_header.num_smn_regs = num_smn;
+		reg_data = usr_regs->smn_reg_values;
+
+		for (r = 0; r < arr_size; r++) {
+			start_addr = reg_addrs[r].start_addr;
+			incrx = reg_addrs[r].incrx;
+			num_regs = reg_addrs[r].num_regs;
+			for (n = 0; n < num_regs; n++) {
+				aqua_read_smn_ext(adev, reg_data,
+						  start_addr + n * incrx, i);
+				reg_data++;
+			}
+		}
+		p = reg_data;
+	}
+
+	usr_reg_state->common_header.structure_size = szbuf;
+	usr_reg_state->common_header.format_revision = 1;
+	usr_reg_state->common_header.content_revision = 0;
+	usr_reg_state->common_header.state_type = AMDGPU_REG_STATE_TYPE_USR;
+	usr_reg_state->common_header.num_instances = max_usr_instances;
+
+	return usr_reg_state->common_header.structure_size;
+}
+
 ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 				    enum amdgpu_reg_state reg_state, void *buf,
 				    size_t max_size)
@@ -937,6 +1056,14 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 	case AMDGPU_REG_STATE_TYPE_WAFL:
 		size = aqua_vanjaram_read_wafl_state(adev, buf, max_size);
 		break;
+	case AMDGPU_REG_STATE_TYPE_USR:
+		size = aqua_vanjaram_read_usr_state(adev, buf, max_size,
+						    AMDGPU_REG_STATE_TYPE_USR);
+		break;
+	case AMDGPU_REG_STATE_TYPE_USR_1:
+		size = aqua_vanjaram_read_usr_state(
+			adev, buf, max_size, AMDGPU_REG_STATE_TYPE_USR_1);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.25.1

