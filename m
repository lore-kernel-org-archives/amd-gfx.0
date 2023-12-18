Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A272C46CD3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Dec 2023 18:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E6C10E291;
	Mon, 18 Dec 2023 18:21:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF8010E291
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Dec 2023 18:21:14 +0000 (UTC)
Received: from DS7PR12MB6047.namprd12.prod.outlook.com (2603:10b6:8:84::22) by
 IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.37; Mon, 18 Dec 2023 18:11:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGQbXDs65K23SnLdVvxL42OiAXA/3S0UpCdjEu3yylNawXEXtEhOySe562BLino7iQYPd3/EH4khuy+h8Ig2OgjW6wGXYiu/VajJHOI0C85ctOWA9zlMLtZQHmrsUdVbbLerwWcK/1NEKQCKKahR+oiM2x6NEDBrte7n4mPDerSEPEYAXeGx8VVBbOHdafxaIw02lULvI2/e2F4DwgmC8QuB+6fkQGFO7R6xpUFQV6kTBhFa+F78Y6M+5NErOSLw3kuOaNCnXWwRCHlWw0tdaCNHCkTQEPWu0gxMCcB3mEiVL43moPDH07iF1G2In+mVEVWGnZ3TJ8xLUpcL/7l4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETBbGd+VJI07uUfw7ccIWNUMktQMvTQRyDWlipmypTo=;
 b=A+dZJdBYk2ESTlndf84ciUmL6E0ElbG3ahB1Jj6zuoC/mDMKMrWEI/Fy92VJYorMA4eo7GDOrkYvzYz9voabAAlvq1uSo6RJjP9o+kiBU15fEC7smR/u97lHo8LpIDTQVZQoxs4vrTIVvom8HqNCrm4NRLLX08LxSlMIT+aoOOwcSm1ly5yaESMr5sXhd0jBPyQ9nwNavg9ghzr11cCKcwTR28wf45xPOawBAvDEPBNgdzeXbFmg0SN9ZgzJOHkWseIVcZVLYC/WwrQnIx00ZxSgoBfMJU9uTHANm7wxfWqPdIGKwgFbc3NhN6E9Al0SLZ78ck5IjqX3kkGgfa03Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETBbGd+VJI07uUfw7ccIWNUMktQMvTQRyDWlipmypTo=;
 b=3EeqptqhSVMj/I//PulsY33OD9elBnrDx6cLg2wauNZ1bo6K3NZZj5j1KC8w6WgwHaYWdJ3G+/ny+ZGtxLjikUBS2W3OX8trf/kzQ1QO74afuuVOFyq4YQgOeLFn86I4nBK28cb72LZwCQf5D0OtUtO1Y554DLoqp8nhAZiGn8A=
Received: from SN7PR04CA0091.namprd04.prod.outlook.com (2603:10b6:806:122::6)
 by DS7PR12MB6047.namprd12.prod.outlook.com (2603:10b6:8:84::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 07:10:33 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::90) by SN7PR04CA0091.outlook.office365.com
 (2603:10b6:806:122::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Mon, 18 Dec 2023 07:10:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 07:10:32 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 01:10:29 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: Add umc page retirement for umc v12_0
Date: Mon, 18 Dec 2023 15:09:31 +0800
Message-ID: <20231218070932.2307244-3-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218070932.2307244-1-YiPeng.Chai@amd.com>
References: <20231218070932.2307244-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DS7PR12MB6047:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6e3e2c-c680-4a99-ae38-08dbff986c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MCyyrnJvAHoTF5A+Ews+fDvXUvHq/6N/htYgKHvtarslL83FJPJAcTvYyTc4JwVWYf2uOAy9IZpbg6AwYvz0/P/u1ASMc7C85N8fKV811fxlTOozerQibuJXhGI2jiGiWBG6ZatTBiBCWi0UOf2gICXXS0w0TRazF3MzsfXixxW3TOyOjLX/cNF7D4VGwAB/bWRMB46jQmySR+G3xehQOmL6N5MAJnnViA/hmk69b/RLPkPpZCyDQtdQzy7lbp/e9VhTslfD+JNieVfkWtlRUIAeozY4zYdHZSB3u1xGV6eIug0YJ45D0zPW45TulyFPTUG7GLjv9qr2q7WjO0nJEoBzgERERYt5eMEtcRJ3vqxKGd19/jTcSmxaMzGYrhhoKBmXjIPkTzd6qhJiwMepylqniQkX8QKlt2cj8qNHarGou35WMFY+dne/qKnxi6CfPFqLY1DpzBzhDTjnPeiQrlnxcnlJEnoi0GN2TKEUIx20pdnCxJ0IvBRHVsUhztJcQqP2hzS2SLl9veNVgREzgrDLtvgLTnPBvFySNI9IEkTJAFDsmlJhFpjl+hXepAaGQuDaJm7a41YzJDxeuxOwax6CmFyag2IQoFmR+infZCYDcc6EWFbTPpqHC4wOtUis+joMhnJSwBKJ5OtXpjaW3XF34S95BgzA6NRrYvRRUPtaii/rVNrR1K32dJXBy+kkvU3i0qNk1UTXfWTDz7YM818rrJ59KQI3BobPjLpTzuZ+RD+nujZfZtZwiGxe8AFeVm9IZJNA8ywYOzcVoGp/Zw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(47076005)(5660300002)(86362001)(2906002)(81166007)(1076003)(2616005)(26005)(83380400001)(356005)(426003)(36860700001)(336012)(16526019)(82740400003)(6666004)(7696005)(36756003)(41300700001)(316002)(54906003)(70586007)(6916009)(478600001)(4326008)(8676002)(8936002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 07:10:32.3965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6e3e2c-c680-4a99-ae38-08dbff986c90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6047
X-OriginatorOrg: amd.com
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
Cc: Tao.Zhou1@amd.com, YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com,
 yipechai@amd.com, Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add umc page retirement for umc v12_0.

V2:
  1. Changed umc page retirement check condition
     to call umc_v12_0_is_uncorrectable_error.
  2. Use memset to clear the contents of the umc
     error address structure.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 56 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h |  4 ++
 2 files changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 8430888760ba..7458a218e89d 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -26,6 +26,7 @@
 #include "amdgpu.h"
 #include "umc/umc_12_0_0_offset.h"
 #include "umc/umc_12_0_0_sh_mask.h"
+#include "mp/mp_13_0_6_sh_mask.h"
 
 const uint32_t
 	umc_v12_0_channel_idx_tbl[]
@@ -370,6 +371,59 @@ static int umc_v12_0_err_cnt_init_per_channel(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void umc_v12_0_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
+					void *ras_error_status)
+{
+	amdgpu_mca_smu_log_ras_error(adev,
+		AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_CE, ras_error_status);
+	amdgpu_mca_smu_log_ras_error(adev,
+		AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_UE, ras_error_status);
+}
+
+static void umc_v12_0_ecc_info_query_ras_error_address(struct amdgpu_device *adev,
+					void *ras_error_status)
+{
+	struct ras_err_node *err_node;
+	uint64_t mc_umc_status;
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+
+	for_each_ras_error(err_node, err_data) {
+		mc_umc_status = err_node->err_info.err_addr.err_status;
+		if (!mc_umc_status)
+			continue;
+
+		if (umc_v12_0_is_uncorrectable_error(adev, mc_umc_status)) {
+			uint64_t mca_addr, err_addr, mca_ipid;
+			uint32_t InstanceIdLo;
+			struct amdgpu_smuio_mcm_config_info *mcm_info;
+
+			mcm_info = &err_node->err_info.mcm_info;
+			mca_addr = err_node->err_info.err_addr.err_addr;
+			mca_ipid = err_node->err_info.err_addr.err_ipid;
+
+			err_addr =  REG_GET_FIELD(mca_addr, MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
+			InstanceIdLo = REG_GET_FIELD(mca_ipid, MCMP1_IPIDT0, InstanceIdLo);
+
+			dev_info(adev->dev, "UMC:IPID:0x%llx, aid:%d, inst:%d, ch:%d, err_addr:0x%llx\n",
+				mca_ipid,
+				mcm_info->die_id,
+				MCA_IPID_LO_2_UMC_INST(InstanceIdLo),
+				MCA_IPID_LO_2_UMC_CH(InstanceIdLo),
+				err_addr);
+
+			umc_v12_0_convert_error_address(adev,
+				err_data, err_addr,
+				MCA_IPID_LO_2_UMC_CH(InstanceIdLo),
+				MCA_IPID_LO_2_UMC_INST(InstanceIdLo),
+				mcm_info->die_id);
+
+			/* Clear umc error address content */
+			memset(&err_node->err_info.err_addr,
+				0, sizeof(err_node->err_info.err_addr));
+		}
+	}
+}
+
 static void umc_v12_0_err_cnt_init(struct amdgpu_device *adev)
 {
 	amdgpu_umc_loop_channels(adev,
@@ -396,4 +450,6 @@ struct amdgpu_umc_ras umc_v12_0_ras = {
 	},
 	.err_cnt_init = umc_v12_0_err_cnt_init,
 	.query_ras_poison_mode = umc_v12_0_query_ras_poison_mode,
+	.ecc_info_query_ras_error_count = umc_v12_0_ecc_info_query_ras_error_count,
+	.ecc_info_query_ras_error_address = umc_v12_0_ecc_info_query_ras_error_address,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index 17b4b52d6f13..e8de3a92251a 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -117,6 +117,10 @@
 		(pa) |= (UMC_V12_0_CHANNEL_HASH_CH6(channel_idx, pa) << UMC_V12_0_PA_CH6_BIT); \
 	} while (0)
 
+#define MCA_IPID_LO_2_UMC_CH(_ipid_lo) (((((_ipid_lo) >> 20) & 0x1) * 4) + \
+			(((_ipid_lo) >> 12) & 0xF))
+#define MCA_IPID_LO_2_UMC_INST(_ipid_lo) (((_ipid_lo) >> 21) & 0x7)
+
 bool umc_v12_0_is_uncorrectable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
 bool umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t mc_umc_status);
 
-- 
2.34.1

