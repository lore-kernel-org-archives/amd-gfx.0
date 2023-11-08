Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E4CC4167D
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 04:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C6CB10E6FB;
	Wed,  8 Nov 2023 04:17:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFF9810E382
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 04:17:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWsBm15S3ZHZ1U7bOide8vBxPgjIhHIBF1dbCeU5KkpfnONgI0EZ4hJvQAUk5/g2jUoVVy7ryNBSCbJ+omvu4lP/V6BnquWrQjLc/IbimN9W9C+mFvlq/TfVDThqYwInAtE++HQNVw0abGga3y7lg+vo4RsYgO5gVOHDtNm3104UpqNCwI4XWYDl/dJUkPYPF186sjGsRYaCcb5qma+BArhKN04lLSPMXcGBR9thst29uyxwZ7izbC2FoCOI35a1TUl6wRyAWn7/bkas1JGM24AlETJYElJVYidcbmKCsoQyd/xYH8HMw7irUE4pfCB4LzKyB4cCNfrcTXkuSyE5pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+IkeZE5+0CgZQE3OO5TZ5ZkZl8y9/Yzgt3AW71EzzM=;
 b=LH9OsUqyff02YWRikWTAAhf9GVBR6ShW8p5kPkrLTLgoWcMbaDt+7tU2crAgioeTkyxGQerZM0+1wwmKQZuidTSoKr4Ka38/irMu54ZJG1TwW0XKm3zwLTPeWTg8Jv6ejQWnnh/nBv9eFZQix4F7luXGiSZ3HhbpvMTlRoCDC1FPgsJp+/uHrdaS7PkayfliWclPgB6ioK0BLWtWg/XSc/SRPC3PeGp1iQDWON7fFi+1VYiiRluEtgdTbsw5DMfVzW40TAFHH8eH47op4t8mYya5IXI70UuNpXXa6nNMl2VVqvlTxkjkm2Xpl51/W3Vvv5v8mup1eXMdJOoU3pYXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+IkeZE5+0CgZQE3OO5TZ5ZkZl8y9/Yzgt3AW71EzzM=;
 b=GfaAdfjg62GMWVanCUPAe4h8WxPyWiBkSvomxluZw9x6eTsv6mpga9e1kWBsUwIVmTSkUG9OgsiDfeFC8XbqrUUBPIwWdcKNxQcEz0xn3X3Lvo4n+SaHQebFHyWA1YlgSs8YsdYNRl8wTTJpjp/lTIz8pSSIhrcBTCW6s8hzGLg=
Received: from CH0PR04CA0080.namprd04.prod.outlook.com (2603:10b6:610:74::25)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Wed, 8 Nov
 2023 04:17:35 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:610:74:cafe::a2) by CH0PR04CA0080.outlook.office365.com
 (2603:10b6:610:74::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Wed, 8 Nov 2023 04:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 04:17:34 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 22:17:33 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amdgpu: Read aquavanjaram PCIE register state
Date: Wed, 8 Nov 2023 09:47:02 +0530
Message-ID: <20231108041705.528194-3-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: d612f8c4-ff87-4545-2eb3-08dbe011a2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HASSKoy1EzsgaaszVaGD25grrfWapj1AalPHnBTXnfTc2gXrw0oaVa58uIuvc2Fgh8/wnEx9hwk9UA5MKCRfCqmj3rFqEM8nb/bnUKWFqAhvhtEoKICR+r7drfXz0B5fxbymS0Os34pC72e/QnT+jtmNbFu7Y27rY7ZQQHz9yx4b3UMpic5lFr9GGtAZ2UK1aHtEoTU1zkdD0GLUXS4tzMe000XwbZj/6PDGPnd9DQ4ucUrOa/0qC3Il+vA5EH1Kce6cQyi9tByGRti7PiNogY2yVd+rMUTVHRA7oNrf6AhshtjXc9y8m9s/YKz5qWJQpGjf9NW522/0Z/TWFpC5wFQXklSFBGZiET3CtKC1af0HCZOuKGEydBuTjst15mZUILPhZ3idaZa+kAK2xppvyhbq3U3lBfbr3oMbtzD3i7o9x89T87PrcVponVwiYa/eStWfojswEkX13WCsy8xAH3PUmVJ47OqRIY3u226uV8n/V8xKRFWBXK+NCDQQNj6O7SEV6FWFmv+DWv3esh1ABbdlvDff3P8yK5AFnXkee6prQYUbqM1RDzSpLYH9RnT+kgI4Rtlbn4wOqi5ZWacis41NlmSgf3ihdil0csdYkTLsejnTjESZwE1dn/zkeG33lGFibAzmfbsXTJTN1Mt+TomuBfPNOHj2zoKnmqPolonyj75+Ak43xESFKeKGLtJ2Bo3LxRbWKDfxVb0A34kMK+ujF8rEpu3RqgSUGfmPq6/UpyfQQ+n49tnNj9iRi3GB/es8j66BDcHjJJQIeYCF3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(40480700001)(86362001)(2906002)(54906003)(41300700001)(40460700003)(44832011)(5660300002)(316002)(8676002)(4326008)(8936002)(6916009)(36756003)(356005)(70586007)(81166007)(7696005)(70206006)(336012)(47076005)(36860700001)(26005)(16526019)(426003)(82740400003)(1076003)(2616005)(6666004)(83380400001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 04:17:34.9360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d612f8c4-ff87-4545-2eb3-08dbe011a2a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599
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

Add support to read aqua vanjaram PCIE register state

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 115 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc15.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/soc15.h         |   4 +
 3 files changed, 120 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 3f715e7fe1a9..0a4598480dd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -24,6 +24,7 @@
 #include "soc15.h"
 
 #include "soc15_common.h"
+#include "amdgpu_reg_state.h"
 #include "amdgpu_xcp.h"
 #include "gfx_v9_4_3.h"
 #include "gfxhub_v1_2.h"
@@ -656,3 +657,117 @@ int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+static void aqua_read_smn(struct amdgpu_device *adev,
+			  struct amdgpu_smn_reg_data *regdata,
+			  uint64_t smn_addr)
+{
+	regdata->addr = smn_addr;
+	regdata->value = RREG32_PCIE(smn_addr);
+}
+
+struct aqua_reg_list {
+	uint64_t start_addr;
+	uint32_t num_regs;
+	uint32_t incrx;
+};
+
+#define DW_ADDR_INCR	4
+
+#define smnreg_0x1A340218	0x1A340218
+#define smnreg_0x1A3402E4	0x1A3402E4
+#define smnreg_0x1A340294	0x1A340294
+#define smreg_0x1A380088	0x1A380088
+
+#define NUM_PCIE_SMN_REGS	14
+
+static struct aqua_reg_list pcie_reg_addrs[] = {
+	{ smnreg_0x1A340218, 1, 0 },
+	{ smnreg_0x1A3402E4, 1, 0 },
+	{ smnreg_0x1A340294, 6, DW_ADDR_INCR },
+	{ smreg_0x1A380088, 6, DW_ADDR_INCR },
+};
+
+static ssize_t aqua_vanjaram_read_pcie_state(struct amdgpu_device *adev,
+					     void *buf, size_t max_size)
+{
+	struct amdgpu_reg_state_pcie_v1_0 *pcie_reg_state;
+	uint32_t start_addr, incrx, num_regs, szbuf;
+	struct amdgpu_regs_pcie_v1_0 *pcie_regs;
+	struct amdgpu_smn_reg_data *reg_data;
+	struct pci_dev *us_pdev, *ds_pdev;
+	int aer_cap, r, n;
+
+	if (!buf || !max_size)
+		return -EINVAL;
+
+	pcie_reg_state = (struct amdgpu_reg_state_pcie_v1_0 *)buf;
+
+	szbuf = sizeof(*pcie_reg_state) +
+		amdgpu_reginst_size(1, sizeof(*pcie_regs), NUM_PCIE_SMN_REGS);
+	/* Only one instance of pcie regs */
+	if (max_size < szbuf)
+		return -EOVERFLOW;
+
+	pcie_regs = (struct amdgpu_regs_pcie_v1_0 *)((uint8_t *)buf +
+						     sizeof(*pcie_reg_state));
+	pcie_regs->inst_header.instance = 0;
+	pcie_regs->inst_header.state = AMDGPU_INST_S_OK;
+	pcie_regs->inst_header.num_smn_regs = NUM_PCIE_SMN_REGS;
+
+	reg_data = pcie_regs->smn_reg_values;
+
+	for (r = 0; r < ARRAY_SIZE(pcie_reg_addrs); r++) {
+		start_addr = pcie_reg_addrs[r].start_addr;
+		incrx = pcie_reg_addrs[r].incrx;
+		num_regs = pcie_reg_addrs[r].num_regs;
+		for (n = 0; n < num_regs; n++) {
+			aqua_read_smn(adev, reg_data, start_addr + n * incrx);
+			++reg_data;
+		}
+	}
+
+	ds_pdev = pci_upstream_bridge(adev->pdev);
+	us_pdev = pci_upstream_bridge(ds_pdev);
+
+	pcie_capability_read_word(us_pdev, PCI_EXP_DEVSTA,
+				  &pcie_regs->device_status);
+	pcie_capability_read_word(us_pdev, PCI_EXP_LNKSTA,
+				  &pcie_regs->link_status);
+
+	aer_cap = pci_find_ext_capability(us_pdev, PCI_EXT_CAP_ID_ERR);
+	if (aer_cap) {
+		pci_read_config_dword(us_pdev, aer_cap + PCI_ERR_COR_STATUS,
+				      &pcie_regs->pcie_corr_err_status);
+		pci_read_config_dword(us_pdev, aer_cap + PCI_ERR_UNCOR_STATUS,
+				      &pcie_regs->pcie_uncorr_err_status);
+	}
+
+	pci_read_config_dword(us_pdev, PCI_PRIMARY_BUS,
+			      &pcie_regs->sub_bus_number_latency);
+
+	pcie_reg_state->common_header.structure_size = szbuf;
+	pcie_reg_state->common_header.format_revision = 1;
+	pcie_reg_state->common_header.content_revision = 0;
+	pcie_reg_state->common_header.state_type = AMDGPU_REG_STATE_TYPE_PCIE;
+	pcie_reg_state->common_header.num_instances = 1;
+
+	return pcie_reg_state->common_header.structure_size;
+}
+
+ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
+				    enum amdgpu_reg_state reg_state, void *buf,
+				    size_t max_size)
+{
+	ssize_t size;
+
+	switch (reg_state) {
+	case AMDGPU_REG_STATE_TYPE_PCIE:
+		size = aqua_vanjaram_read_pcie_state(adev, buf, max_size);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return size;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index d4b8d62f4294..e3d41e8aac9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -902,6 +902,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
 	.pre_asic_init = &soc15_pre_asic_init,
 	.query_video_codecs = &soc15_query_video_codecs,
 	.encode_ext_smn_addressing = &aqua_vanjaram_encode_ext_smn_addressing,
+	.get_reg_state = &aqua_vanjaram_get_reg_state,
 };
 
 static int soc15_common_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
index eac54042c6c0..1444b7765e4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
@@ -27,6 +27,7 @@
 #include "nbio_v6_1.h"
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
+#include "amdgpu_reg_state.h"
 
 extern const struct amdgpu_ip_block_version vega10_common_ip_block;
 
@@ -114,6 +115,9 @@ int aldebaran_reg_base_init(struct amdgpu_device *adev);
 void aqua_vanjaram_ip_map_init(struct amdgpu_device *adev);
 u64 aqua_vanjaram_encode_ext_smn_addressing(int ext_id);
 int aqua_vanjaram_init_soc_config(struct amdgpu_device *adev);
+ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
+				    enum amdgpu_reg_state reg_state, void *buf,
+				    size_t max_size);
 
 void vega10_doorbell_index_init(struct amdgpu_device *adev);
 void vega20_doorbell_index_init(struct amdgpu_device *adev);
-- 
2.25.1

