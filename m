Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD805C47096
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A684761C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A684761C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5B36EDC5;
	Wed,  2 Jun 2021 16:50:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D3C36EDC0
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gt0CUZCn+zLaZXNS0tHqjHJ2aCBrHYRJL74ajItAHtb/W6PlhDz5gOfuf6RKhRgl4swBk6TBeQztN2rsIqqEafdPtPOw/nfWKhMGZwpmv+E6wEJz25AibQxnOKfo0h/OppAftJTrf1fb3F4Mx7eJ8qUveU2IfpamaRuf/6jpGxzFSkIeueZ/d4fZbb+5rG3FMVaai4hsF2uoQA57hF1O4NcmSHWL0s9B7e5/XAPXPd+MVQipnJMrG+w/zdKxUzeUn9s39ySJ74AUpPmF6pwpiglxsr624ow3C8Jdn59wvnTQtnBPhnWCsNHCtOpNJ717ZDDwgD9IFLjjX81R74F/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DiL872HXk3IhNyOIG76NeJO3M6e+tTyOIOsHwY4UBo=;
 b=lT/YJthHWB+FewYEhcTXtl5CzbruCYO0Q+4ugoEECVPX4iH4plgyLSZuku38PEG3nZ4A3KxdUNGFY4tXbbGMw77PJ87VNWBXwP43n2MTzJUL4kIDkVbClo1HPNsL2/xfrFD2mfqpcLP8+uBBfiv4mXcIn9W6M5/7uoR/78K0wKXnUxqliUHEn0WLdeJEPEuXtm2nitVHEJ7X2kDnZ2bP8k1Uk5SfaENM0ICq1LAUq59XO56rrjF+N0ZqwQfSshW3qkSiW4V0SIZNBqYGwvpJ1mZtyVNki0bdgeJOq+goXEHIf5aGCuIPkPhcHS15gqtIk7ODtM/32871etMQZUlK1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DiL872HXk3IhNyOIG76NeJO3M6e+tTyOIOsHwY4UBo=;
 b=fRMy6baaEEWWTu/Ok9ag/wgAreGxoL5s5Esp638bkPNQbBJiI28bSV7qEdU398rfxcwwluDYvmqROq4HPABrA3JvYT1A9LQ97Ov9fRv6omNrjyQucbKm2zzen4kShKCJQMFP9p1L74H276dyhmGsKY0COP6XomluSFkbwUGHMsA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2434.namprd12.prod.outlook.com (2603:10b6:207:4d::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:50:40 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:40 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 59/89] drm/amd/pm: add callback to get bootup values for
 yellow carp
Date: Wed,  2 Jun 2021 12:48:38 -0400
Message-Id: <20210602164908.2848791-59-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4599ea1a-f102-4c48-4fb3-08d925e67afe
X-MS-TrafficTypeDiagnostic: BL0PR12MB2434:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB243455EB33F511DBC534D1F3F73D9@BL0PR12MB2434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cE/AJhAi0pgYcgdKUqirAS1d057EVGwXup/DS3f/+LVIQ9+9lEViGRRTMmGb/wEjxWVmJKuF3rq8qXpUovMrnhwiNLVwQ67H/dxRpGOSpaAHd7G1X6t3hwb+/xeNCmla90zmyzu+FTmTsuJwElw/vc3cOF/+rj1PQzZadifuDPpkg/DID1iln4xyId6JLoDqaV4OguQvveR0mqZY6m5NxjWGIyi5o4gpFkCK2/jzX9l0douE9RLWCY72Qm0th/+XD2JFEeTk2RK1bsKhEULlnzcM71DY89gTuUXltkQrukc4Ah7qBSbz0wfSIEBkfB9kKHqhE1kyeMY3Ehk+UJDKEXkrnjhIJT5cYrN1e3KeW59s1VTx69bx5gNe9rT5e2ELJP0oGERanw37s+tbr0Cibv/QhLj0Oirz3sAx2oiv1deQuKMvqLZGrk7hu7hy7YdVmu+otZRAwGwp5agn4iJnCcpOkSB9d5p7WbV6lKcRn+WnAG1N4ix0cg/e0TSp++EoOhPz8jZqkD+FsDilzYL2BxoLroMcX0nPwwrx/8htGYuAX2cJTXIQujCvHlPbQ0eeN5edgsgSCgr61z7xsu05Evi0dKvjnYZVsgdFy6yxJxh9wznNpOXYJ/zae1ekGJH5jMK61NyX+YO+OjlHQN/ZleehTitzqQdslbT9Z4rHW0XdAkX2wens5W577ddZpoDT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39850400004)(52116002)(6486002)(6916009)(66476007)(66556008)(316002)(66946007)(36756003)(54906003)(86362001)(5660300002)(16526019)(186003)(6506007)(6512007)(26005)(6666004)(83380400001)(1076003)(8676002)(956004)(4326008)(2616005)(478600001)(38350700002)(38100700002)(2906002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UBQEWej9rfQnb78eWsm/FTGAHgWiFTPXblYSfBONHYHqytC3w7S7rnuY2KsD?=
 =?us-ascii?Q?Zky4m2W25Xm+gR3Yww+KO84mJ4vTiE7eZnHV51Y3rPgxLWEuofXKx+y/aGix?=
 =?us-ascii?Q?296vOtwMxOU4BIiGm4mEHglBgBIQdI6yP4k49S0fphE4wvUx9HChWkNYt+uS?=
 =?us-ascii?Q?Gih+RYPNHV1MGQDM10NDKyh5QZGijwUGs0/jTPtfUPNm8ivJF0dP2llffg4P?=
 =?us-ascii?Q?TwLekHH44EEOD4yFOiUV/LAydNKOMqYuNVfeR7ZmnrBgk8YJ5EWI0lTn8Ezv?=
 =?us-ascii?Q?g3oZEYH0aAAl0nvlVqb8ZlqiTUtrgwKjmGUAtJ06HSEaCsFsnQVaQSiGfDtq?=
 =?us-ascii?Q?DAPHSeHr8xpHBCRGClD58RdNpDpYz6jTgF8ogWdCYniaoGsKk7PZVuel8i9t?=
 =?us-ascii?Q?BJFQFBjj9x0btPgFzElWBaDTsCQm7c6HPlYolxO6DCCban7HzG8EZXiVm8dc?=
 =?us-ascii?Q?ce1q+7d7mKqvIfo2pMNRLs6GomRhIBb+yH1Gl2fTgr0wZEkUvwHJIlqEI4Zx?=
 =?us-ascii?Q?9eiXsflqCmzhYjADAadxIo5UtAmdGEU1kRiodrPk7pL84A51iUvyyqnnb84O?=
 =?us-ascii?Q?3igOeTq7DHvyak0phkFSUe5YQsyNELY7wGS6Yhs36xdXK3ZXdEi7gAq/RttX?=
 =?us-ascii?Q?Pc7IWFqDv4ZPj7w1XkypjlEah6B5cg8aLAXmCz1X61uJ+pps5k4fn2egDZts?=
 =?us-ascii?Q?PYyq7S9E9nOqSnvMnPiDPqfdaSlTSsy2Fphk8L79goDQX6w2dAl/oJ0PXFl2?=
 =?us-ascii?Q?PIejjGwOtTHqnX80gs0SdgC/qxHHQ+7+cvPsMkdzk0GCpsutinUYi8gUT2u9?=
 =?us-ascii?Q?ZCcBwzuTNnoYQ5hqe35XzoysMPEY4u3xsEGpSyDSXMGBdIy+bw1XdqwP1k6J?=
 =?us-ascii?Q?5M6PIpgsJj+Bu4AaDt5CCpRtRUtnYbOBEQc3iyuBHHyg2am/EPZXIJTkFFHI?=
 =?us-ascii?Q?rJL+GtRw6ErDC2gAUFQMIQRGjnyMzqF0dRJ2LDhWWiCq8MHP6BT1FAdkbhqv?=
 =?us-ascii?Q?OfcETZaf5OwaMSnMHyzsnIAV+xXEIVQFm8gkqSqY18taSDx7avz8y4y6wLLf?=
 =?us-ascii?Q?Sa7WhsGYdFl0CFOVBBW6wU/w2K888kVgGPO4VSTzWMQLQ2sn4Vb1VGGHJjgk?=
 =?us-ascii?Q?/4VLQHUZsU2shexNGLI+SVBebvhylInqn4QnI+dmlrCT6fi5hRFrnMq75sgH?=
 =?us-ascii?Q?g8tuqBYqlBf32+jK4pIqbVctr2NwfK1hO38VIzq2E8AVVQiJSL0AIeZTPoN5?=
 =?us-ascii?Q?QKQl46CVLAIgde40pLydQwYieRwltCGeQA9352nO9FlEyP70/hP/zQbHvU8R?=
 =?us-ascii?Q?HYfRKWQiaL942Fml9yNcVTCZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4599ea1a-f102-4c48-4fb3-08d925e67afe
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:08.7720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RCzfDI4tGPqaN21VcFXImnvtoJCtNd3wkyh3Ek4UeiYzg/IPnyJuxX+W29V7E36t9Jq49dixs1T3woRqqjAtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2434
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

Add get_vbios_bootup_values function to get the bootup values for yellow
carp.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h      |   2 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c  | 136 ++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |   1 +
 3 files changed, 139 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
index 065f3d27b2b8..b6c976a4d578 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
@@ -46,6 +46,8 @@ int smu_v13_0_1_check_fw_version(struct smu_context *smu);
 
 int smu_v13_0_1_fini_smc_tables(struct smu_context *smu);
 
+int smu_v13_0_1_get_vbios_bootup_values(struct smu_context *smu);
+
 int smu_v13_0_1_set_default_dpm_tables(struct smu_context *smu);
 
 int smu_v13_0_1_set_driver_table_location(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
index dfbb527b25cb..61917b49f2bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
@@ -29,6 +29,10 @@
 #include "smu_v13_0_1.h"
 #include "soc15_common.h"
 #include "smu_cmn.h"
+#include "atomfirmware.h"
+#include "amdgpu_atomfirmware.h"
+#include "amdgpu_atombios.h"
+#include "atom.h"
 
 #include "asic_reg/mp/mp_13_0_1_offset.h"
 #include "asic_reg/mp/mp_13_0_1_sh_mask.h"
@@ -122,6 +126,138 @@ int smu_v13_0_1_fini_smc_tables(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_v13_0_1_atom_get_smu_clockinfo(struct amdgpu_device *adev,
+						uint8_t clk_id,
+						uint8_t syspll_id,
+						uint32_t *clk_freq)
+{
+	struct atom_get_smu_clock_info_parameters_v3_1 input = {0};
+	struct atom_get_smu_clock_info_output_parameters_v3_1 *output;
+	int ret, index;
+
+	input.clk_id = clk_id;
+	input.syspll_id = syspll_id;
+	input.command = GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
+	index = get_index_into_master_table(atom_master_list_of_command_functions_v2_1,
+					    getsmuclockinfo);
+
+	ret = amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
+					(uint32_t *)&input);
+	if (ret)
+		return -EINVAL;
+
+	output = (struct atom_get_smu_clock_info_output_parameters_v3_1 *)&input;
+	*clk_freq = le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;
+
+	return 0;
+}
+
+int smu_v13_0_1_get_vbios_bootup_values(struct smu_context *smu)
+{
+	int ret, index;
+	uint16_t size;
+	uint8_t frev, crev;
+	struct atom_common_table_header *header;
+	struct atom_firmware_info_v3_4 *v_3_4;
+	struct atom_firmware_info_v3_3 *v_3_3;
+	struct atom_firmware_info_v3_1 *v_3_1;
+
+	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+					    firmwareinfo);
+
+	ret = amdgpu_atombios_get_data_table(smu->adev, index, &size, &frev, &crev,
+					     (uint8_t **)&header);
+	if (ret)
+		return ret;
+
+	if (header->format_revision != 3) {
+		dev_err(smu->adev->dev, "unknown atom_firmware_info version! for smu13\n");
+		return -EINVAL;
+	}
+
+	switch (header->content_revision) {
+	case 0:
+	case 1:
+	case 2:
+		v_3_1 = (struct atom_firmware_info_v3_1 *)header;
+		smu->smu_table.boot_values.revision = v_3_1->firmware_revision;
+		smu->smu_table.boot_values.gfxclk = v_3_1->bootup_sclk_in10khz;
+		smu->smu_table.boot_values.uclk = v_3_1->bootup_mclk_in10khz;
+		smu->smu_table.boot_values.socclk = 0;
+		smu->smu_table.boot_values.dcefclk = 0;
+		smu->smu_table.boot_values.vddc = v_3_1->bootup_vddc_mv;
+		smu->smu_table.boot_values.vddci = v_3_1->bootup_vddci_mv;
+		smu->smu_table.boot_values.mvddc = v_3_1->bootup_mvddc_mv;
+		smu->smu_table.boot_values.vdd_gfx = v_3_1->bootup_vddgfx_mv;
+		smu->smu_table.boot_values.cooling_id = v_3_1->coolingsolution_id;
+		break;
+	case 3:
+		v_3_3 = (struct atom_firmware_info_v3_3 *)header;
+		smu->smu_table.boot_values.revision = v_3_3->firmware_revision;
+		smu->smu_table.boot_values.gfxclk = v_3_3->bootup_sclk_in10khz;
+		smu->smu_table.boot_values.uclk = v_3_3->bootup_mclk_in10khz;
+		smu->smu_table.boot_values.socclk = 0;
+		smu->smu_table.boot_values.dcefclk = 0;
+		smu->smu_table.boot_values.vddc = v_3_3->bootup_vddc_mv;
+		smu->smu_table.boot_values.vddci = v_3_3->bootup_vddci_mv;
+		smu->smu_table.boot_values.mvddc = v_3_3->bootup_mvddc_mv;
+		smu->smu_table.boot_values.vdd_gfx = v_3_3->bootup_vddgfx_mv;
+		smu->smu_table.boot_values.cooling_id = v_3_3->coolingsolution_id;
+		break;
+	case 4:
+	default:
+		v_3_4 = (struct atom_firmware_info_v3_4 *)header;
+		smu->smu_table.boot_values.revision = v_3_4->firmware_revision;
+		smu->smu_table.boot_values.gfxclk = v_3_4->bootup_sclk_in10khz;
+		smu->smu_table.boot_values.uclk = v_3_4->bootup_mclk_in10khz;
+		smu->smu_table.boot_values.socclk = 0;
+		smu->smu_table.boot_values.dcefclk = 0;
+		smu->smu_table.boot_values.vddc = v_3_4->bootup_vddc_mv;
+		smu->smu_table.boot_values.vddci = v_3_4->bootup_vddci_mv;
+		smu->smu_table.boot_values.mvddc = v_3_4->bootup_mvddc_mv;
+		smu->smu_table.boot_values.vdd_gfx = v_3_4->bootup_vddgfx_mv;
+		smu->smu_table.boot_values.cooling_id = v_3_4->coolingsolution_id;
+		break;
+	}
+
+	smu->smu_table.boot_values.format_revision = header->format_revision;
+	smu->smu_table.boot_values.content_revision = header->content_revision;
+
+	smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
+					(uint8_t)SMU11_SYSPLL0_SOCCLK_ID,
+					(uint8_t)0,
+					&smu->smu_table.boot_values.socclk);
+
+	smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
+					(uint8_t)SMU11_SYSPLL0_DCEFCLK_ID,
+					(uint8_t)0,
+					&smu->smu_table.boot_values.dcefclk);
+
+	smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
+					(uint8_t)SMU11_SYSPLL0_ECLK_ID,
+					(uint8_t)0,
+					&smu->smu_table.boot_values.eclk);
+
+	smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
+					(uint8_t)SMU11_SYSPLL0_VCLK_ID,
+					(uint8_t)0,
+					&smu->smu_table.boot_values.vclk);
+
+	smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
+					(uint8_t)SMU11_SYSPLL0_DCLK_ID,
+					(uint8_t)0,
+					&smu->smu_table.boot_values.dclk);
+
+	if ((smu->smu_table.boot_values.format_revision == 3) &&
+	    (smu->smu_table.boot_values.content_revision >= 2))
+		smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
+						(uint8_t)SMU11_SYSPLL1_0_FCLK_ID,
+						(uint8_t)SMU11_SYSPLL1_2_ID,
+						&smu->smu_table.boot_values.fclk);
+
+	return 0;
+}
+
 int smu_v13_0_1_set_default_dpm_tables(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index d9b3cb7d7ca5..bded5c297a08 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -820,6 +820,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.check_fw_version = smu_v13_0_1_check_fw_version,
 	.init_smc_tables = yellow_carp_init_smc_tables,
 	.fini_smc_tables = smu_v13_0_1_fini_smc_tables,
+	.get_vbios_bootup_values = smu_v13_0_1_get_vbios_bootup_values,
 	.system_features_control = yellow_carp_system_features_control,
 	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
 	.send_smc_msg = smu_cmn_send_smc_msg,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
