Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DF0C4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 04:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3441110E386;
	Wed,  8 Nov 2023 04:17:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BE3110E386
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 04:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co9XJJQSN//Hav0t3ru2qvdhfgjvE4UPIb5oqkTiEe1cHreh8pXnhYthhqVV90QwsBx+1iunm1niC+BcH4NpWAR0hQu0SkgKJeFr1B42Dr4I8+2haMbaaUtAX8/f6J++1S/pclgw4O5/I1C34QvYWTK+UGJcYE5GiKWMXL9n85iTGz5qnLQcdMkXYBa/9nJeWI//twz1Rh1hNyM1stdNewhYGHO7HZOXeUdyeYc+wQnTWow00VLvGthk8ztVnuEcUzknTSo9eIFNvJsj9slw1DL2uSOg5As7mvl2iwwr9hJhUymFDEhdcdhmTRaD0mRs0GIM6s4+VABUnbbHx4Q1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pN+/6OatGLmYciFGGuPmDch7vp8GhD186L19RH+6GUY=;
 b=RoR1UXiSi79FwwFxHXucA0tGMiRmmF6PVfHg6l5juPhl5zzQu3fCn3g6arWsn5yYJDJEIp59Ry4ePVDaUKMomjYxbkQVSxShwDULzrGmNtcx4xzV4l3w4MeoNzxJLqrqlQ/0oVtJfxXPXuZ+rT487I5ktntYXLYL0x7aJvF+bf4WiDtqJbrAYcJ7rFT2y1EknEdHEEzmlP48BMAHBHE4mF7nHvfNyKMpTEMhvSxECe5HjSHGyIdzlyFdhb6tj1SYlHg9CsOTBcjVtliqW7mGcGpjao4TEKyzHFVicrlZtj8JljDnH7EdODyb6V3pHJ501o6iLal6V9NYa2ibqgDu0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN+/6OatGLmYciFGGuPmDch7vp8GhD186L19RH+6GUY=;
 b=fh9n3cU3lR4SdVKSbtYs670uEBlL569/KT+s8V5mQfuHaK1Y839uBUvRESC9CYH7Jpyh1TFKr0dXO+kImA7ayBuIHQpMsnxRNfu3do4bgOsUerzpPJu5zXEdfA2ZdXZ66hI6etDVZDDwgkTxbeuHFsVn9QHea10Mc0g/GieqNrs=
Received: from CH0PR04CA0081.namprd04.prod.outlook.com (2603:10b6:610:74::26)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Wed, 8 Nov
 2023 04:17:37 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:610:74:cafe::a7) by CH0PR04CA0081.outlook.office365.com
 (2603:10b6:610:74::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Wed, 8 Nov 2023 04:17:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 04:17:36 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 22:17:34 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amdgpu: Read aquavanjaram XGMI register state
Date: Wed, 8 Nov 2023 09:47:03 +0530
Message-ID: <20231108041705.528194-4-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: f89912f3-2987-4c0f-9b0e-08dbe011a375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DDxQW0KhYcysfZvluNa+x3w0OBRM2okzpKZEVPcq5CP5qFYTjLeIGp7jZ8SmKPPxc7YzK2/zZmkM2Om4ByPVeyBcjrC7RxotZfeiIAcYzIBhprn33G78X5rXUeDq2B8UtE9H8BPe+bjgA+lAnT+0uzkNmS7E3rJVoECDjTIBfwI+uioOPT598CCjss4ZThg2hT9h+AEUxU/e0NgJzWxl+vB5+ZfcUd1smivd1uxv0pDYN/H0XNTwjk4phspWBL17rqbkj6P2mv22GsUTKbp7z7w8tTcSVkoYf9hkIfk2LDQ0NUZvL9oiOO4tBg2ffOpupvBVXhvisCncVbuGOOUyX1Z/DzQE7z2G+4II9r1DByG1nKoe9FAJl6Nf8YTCu/m3968TDOLkOT/6l0oCr3ksrRlHWtZYGlr2j0xTk0ckRQt50fbyUW7M2x3lel832ykcMEZwVKEB1M9doBB2a6ujgL0zeMLSS3WQOAAo0u23MiYBnK0gejQEW5gEwz/TYuJMF8VhdRkCfbETZHSVQ1QG+SaSXBK6ow7wXxA+mHISXynDF3t+oQj8GYreOWVSQSqQaYEMXNdzvDtVOwwwiEBA2TAhc/haT0a+GrXfW8db/aaj7fTcWLUXtg6a8SdfQuPP4qu9Fk5u4rLRqz7z0pmHedMsPjE3ZvDmdAeyEk2bz/xdU2MEWmWpej/HdpEP8QFPe7c+BaqyrZ/PepstVGZ4UEwfZzhs91IHIL5h14yohfq4/+dw0p0Nz5GUk8YorMB7uktfvqi2OP8joR6dmHJYag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(70206006)(70586007)(54906003)(81166007)(36756003)(356005)(82740400003)(6916009)(86362001)(8936002)(36860700001)(336012)(16526019)(426003)(26005)(1076003)(7696005)(2616005)(41300700001)(2906002)(6666004)(8676002)(5660300002)(44832011)(316002)(4326008)(478600001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 04:17:36.3735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f89912f3-2987-4c0f-9b0e-08dbe011a375
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819
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

Add support to read state of XGMI links in aquavanjaram SOC.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 0a4598480dd5..a00b8c6f0a94 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -674,6 +674,15 @@ struct aqua_reg_list {
 
 #define DW_ADDR_INCR	4
 
+static void aqua_read_smn_ext(struct amdgpu_device *adev,
+			      struct amdgpu_smn_reg_data *regdata,
+			      uint64_t smn_addr, int i)
+{
+	regdata->addr =
+		smn_addr + adev->asic_funcs->encode_ext_smn_addressing(i);
+	regdata->value = RREG32_PCIE_EXT(regdata->addr);
+}
+
 #define smnreg_0x1A340218	0x1A340218
 #define smnreg_0x1A3402E4	0x1A3402E4
 #define smnreg_0x1A340294	0x1A340294
@@ -755,6 +764,90 @@ static ssize_t aqua_vanjaram_read_pcie_state(struct amdgpu_device *adev,
 	return pcie_reg_state->common_header.structure_size;
 }
 
+#define smnreg_0x11A00050	0x11A00050
+#define smnreg_0x11A00180	0x11A00180
+#define smnreg_0x11A00070	0x11A00070
+#define smnreg_0x11A00200	0x11A00200
+#define smnreg_0x11A0020C	0x11A0020C
+#define smnreg_0x11A00210	0x11A00210
+#define smnreg_0x11A00108	0x11A00108
+
+#define XGMI_LINK_REG(smnreg, l) ((smnreg) | (l << 20))
+
+#define NUM_XGMI_SMN_REGS 25
+
+static struct aqua_reg_list xgmi_reg_addrs[] = {
+	{ smnreg_0x11A00050, 1, 0 },
+	{ smnreg_0x11A00180, 16, DW_ADDR_INCR },
+	{ smnreg_0x11A00070, 4, DW_ADDR_INCR },
+	{ smnreg_0x11A00200, 1, 0 },
+	{ smnreg_0x11A0020C, 1, 0 },
+	{ smnreg_0x11A00210, 1, 0 },
+	{ smnreg_0x11A00108, 1, 0 },
+};
+
+static ssize_t aqua_vanjaram_read_xgmi_state(struct amdgpu_device *adev,
+					     void *buf, size_t max_size)
+{
+	struct amdgpu_reg_state_xgmi_v1_0 *xgmi_reg_state;
+	uint32_t start_addr, incrx, num_regs, szbuf;
+	struct amdgpu_regs_xgmi_v1_0 *xgmi_regs;
+	struct amdgpu_smn_reg_data *reg_data;
+	const int max_xgmi_instances = 8;
+	int inst = 0, i, j, r, n;
+	const int xgmi_inst = 2;
+	void *p;
+
+	if (!buf || !max_size)
+		return -EINVAL;
+
+	xgmi_reg_state = (struct amdgpu_reg_state_xgmi_v1_0 *)buf;
+
+	szbuf = sizeof(*xgmi_reg_state) +
+		amdgpu_reginst_size(max_xgmi_instances, sizeof(*xgmi_regs),
+				    NUM_XGMI_SMN_REGS);
+	/* Only one instance of pcie regs */
+	if (max_size < szbuf)
+		return -EOVERFLOW;
+
+	p = &xgmi_reg_state->xgmi_state_regs[0];
+	for_each_inst(i, adev->aid_mask) {
+		for (j = 0; j < xgmi_inst; ++j) {
+			xgmi_regs = (struct amdgpu_regs_xgmi_v1_0 *)p;
+			xgmi_regs->inst_header.instance = inst++;
+
+			xgmi_regs->inst_header.state = AMDGPU_INST_S_OK;
+			xgmi_regs->inst_header.num_smn_regs = NUM_XGMI_SMN_REGS;
+
+			reg_data = xgmi_regs->smn_reg_values;
+
+			for (r = 0; r < ARRAY_SIZE(xgmi_reg_addrs); r++) {
+				start_addr = xgmi_reg_addrs[r].start_addr;
+				incrx = xgmi_reg_addrs[r].incrx;
+				num_regs = xgmi_reg_addrs[r].num_regs;
+
+				for (n = 0; n < num_regs; n++) {
+					aqua_read_smn_ext(
+						adev, reg_data,
+						XGMI_LINK_REG(start_addr, j) +
+							n * incrx,
+						i);
+					++reg_data;
+				}
+			}
+			p = reg_data;
+		}
+	}
+
+	xgmi_reg_state->common_header.structure_size = szbuf;
+	xgmi_reg_state->common_header.format_revision = 1;
+	xgmi_reg_state->common_header.content_revision = 0;
+	xgmi_reg_state->common_header.state_type = AMDGPU_REG_STATE_TYPE_XGMI;
+	xgmi_reg_state->common_header.num_instances = max_xgmi_instances;
+
+	return xgmi_reg_state->common_header.structure_size;
+}
+
 ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 				    enum amdgpu_reg_state reg_state, void *buf,
 				    size_t max_size)
@@ -765,6 +858,9 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
 	case AMDGPU_REG_STATE_TYPE_PCIE:
 		size = aqua_vanjaram_read_pcie_state(adev, buf, max_size);
 		break;
+	case AMDGPU_REG_STATE_TYPE_XGMI:
+		size = aqua_vanjaram_read_xgmi_state(adev, buf, max_size);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.25.1

