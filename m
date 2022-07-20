Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D42C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jul 2022 02:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E76AC112668;
	Wed, 20 Jul 2022 02:50:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D9BA112507
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jul 2022 02:50:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5UufdhU+hynASOSXExrUt6IEJelEUFzpJ5c/0++qqscgHiZdjjMkvyRV1/DvRrVW1L12oC8/tdioaVZNgRU/tAcLoCxQxJf/fgml1HkkIVzcW3cQsdPlXgvNidTkNzxZzmDc/hK1seO3fXlyBd4SYt/G/L/ibMenFOZVlco9AXAUPlqTikoP65dFKcSkNbLBJ9pBebyBAI+vgPjl+mmZBcbLrEGMxRzrwfD64pSltVjbAjr/r7LrVKB1NOP7Y5ZyQ5dfaTA0zuwV7wnZnnAo5nXlgB88gawtm59ktnMRncdd8FUEDQ+B/XL4d8oevy4vs0TCS1CREVf4Ax6nL7TXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESqTxvEGQhi5gns3k1cPsSydDvdYeMZemdEru8lC/N4=;
 b=Fv1PIgM19SafU1ScBLj2n8Adeh7dhoDQtX//Zw3wgxs/bVciw9bBcl+3VSUy5tNmN3+4QqB44IB60mPfWGfToEY2jMW1Y97ul9O+4Ojp7dqIfHashSx7sDBEin5pDNtRMmovEvZj/B4HfBpibsPzyiMWVvBlVdovskSPCRnxqmQYvtGwHnnXESxwxYS6G+KDX9SN2EBhOU7iEkrsCaOQO4y5So7EFY4XJJsgYPYez8i0Zn0Htd2hup811e4zIXK4HSOSB+z5JPkjGpRvvXdPhWNkvzz73C3hUgDjRDpX1+cloz2haS7b240+fEh2+m6HQSJMUxTNIiEzwtm/KSt0YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESqTxvEGQhi5gns3k1cPsSydDvdYeMZemdEru8lC/N4=;
 b=A+TQY4Ke9H/qWeKg0uAbQ990eO3jqL8mifH12NJHEV6CF8x1GwfJYcu/7CDnBtSX+YfDnsY/oK5+CBJVDtA3J9ZQ5XY6OO8bywiOGenjdKO71X5gdn6c8LDMc7S0A5VUb05bsT3/v8/rB5k4YKmjJSDWtb2/QUJv/1nZJHmNJKI=
Received: from DM6PR02CA0138.namprd02.prod.outlook.com (2603:10b6:5:1b4::40)
 by DM6PR12MB2780.namprd12.prod.outlook.com (2603:10b6:5:4e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Wed, 20 Jul
 2022 02:50:42 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::fa) by DM6PR02CA0138.outlook.office365.com
 (2603:10b6:5:1b4::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Wed, 20 Jul 2022 02:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 02:50:41 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 21:50:38 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/pm/swsmu: add ras eeprom i2c function for smu13 v13_0_0
Date: Wed, 20 Jul 2022 10:49:25 +0800
Message-ID: <20220720024925.9640-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88fb5c11-1d0b-498d-4951-08da69faa2a9
X-MS-TrafficTypeDiagnostic: DM6PR12MB2780:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bfZj2rJFS69TSiELJmNOl3nEvtnHEy5migkA2wKnkyM4EHhICqAK8sRmpzO98fMoROLqcte1u8Xt0haeD3T30gcW165n/u/I+kkVbhMd5PnLa1uNgNTcvqNaUMufcc7dZ4x5qrgBiOT+3ctYVofrsg5Dkjsu/2/NWCWgBFjEvJ9uIxqVmlrptHDvKGCvJ9hJ5AiAP/gqd2eGVtHrWfop0nITfaAEcyIPL/FtPrJEuxbhaGgslageXJaue/hSmePWkBtiLdDBCQ9SKQULKeuLeBc2uXxX/7wh8ga4SryPQy1eX72bdPGADJ7KAlaTzsdIGpHxbymdV8qIDSTCcUvShnudkeEwLvsHB4iOsfI2RsPrgSGmleAEQssz12n5jBQ8QKpp+SAsJjuj1Jzye2aT/OfXBs+/h8jJ5kjpmab38QkKvmen/hOa27DNjTCi57U49w+QeL8VrWSjl3vDKO1Si3SVfb+2pdBIw5Z9CuFo2EUPET0Ic7ZD40aRxKXe8yeIV0l+0dyNInQHaO9SDETu0PNry8VKsBBuEpTk04Nxt9IRs0FRwoLn1zh8Wfcv07Cvq1iassG3PofSJ6u3rpj8+O0yrIg5YMcnrdOPJTJUjQn3gOojZ4JEwXsEPPx5Og6G4lhRSV7DoCbYqReZUAtRElnbQi234ULm0LrF9ZYNdW2cZcO9lOILjEr4aUCiWCjlBSuGuN9/85O4T7Q17VW0KKQuxG0NTkR9Ric/jLGqI4uqFxX12ayTZKNEpndxXFLTAFYjyufMFDNgXweojngsl8E9tSQ0MFhFJS+TTuhr2f3VLzwl2tLkHfVsKhhzoQ1uOdxH/9xAMxaI2XbcB+7dQLVCZhSWMGLWsHFlJNbWRHU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(40470700004)(36840700001)(46966006)(70586007)(7696005)(8676002)(70206006)(4326008)(8936002)(82310400005)(47076005)(186003)(16526019)(86362001)(336012)(426003)(6916009)(40480700001)(83380400001)(356005)(82740400003)(54906003)(40460700003)(36756003)(316002)(2616005)(478600001)(81166007)(6666004)(5660300002)(26005)(2906002)(41300700001)(36860700001)(1076003)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 02:50:41.6996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fb5c11-1d0b-498d-4951-08da69faa2a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2780
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
Cc: Evan Quan <evan.quan@amd.com>, Tao.Zhou1@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, yipechai@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, Candice.Li@amd.com,
 John.Clements@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add ras eeprom i2c function for smu13 v13_0_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Acked-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 157 ++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index ce2fa04e3926..2b83191e8006 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -196,6 +196,7 @@ static struct cmn2asic_mapping smu_v13_0_0_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(DRIVER_SMU_CONFIG),
 	TAB_MAP(ACTIVITY_MONITOR_COEFF),
 	[SMU_TABLE_COMBO_PPTABLE] = {1, TABLE_COMBO_PPTABLE},
+	TAB_MAP(I2C_COMMANDS),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
@@ -1606,9 +1607,165 @@ static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu)
 	return true;
 }
 
+static int smu_v13_0_0_i2c_xfer(struct i2c_adapter *i2c_adap,
+				   struct i2c_msg *msg, int num_msgs)
+{
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(i2c_adap);
+	struct amdgpu_device *adev = smu_i2c->adev;
+	struct smu_context *smu = adev->powerplay.pp_handle;
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *table = &smu_table->driver_table;
+	SwI2cRequest_t *req, *res = (SwI2cRequest_t *)table->cpu_addr;
+	int i, j, r, c;
+	u16 dir;
+
+	if (!adev->pm.dpm_enabled)
+		return -EBUSY;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->I2CcontrollerPort = smu_i2c->port;
+	req->I2CSpeed = I2C_SPEED_FAST_400K;
+	req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
+	dir = msg[0].flags & I2C_M_RD;
+
+	for (c = i = 0; i < num_msgs; i++) {
+		for (j = 0; j < msg[i].len; j++, c++) {
+			SwI2cCmd_t *cmd = &req->SwI2cCmds[c];
+
+			if (!(msg[i].flags & I2C_M_RD)) {
+				/* write */
+				cmd->CmdConfig |= CMDCONFIG_READWRITE_MASK;
+				cmd->ReadWriteData = msg[i].buf[j];
+			}
+
+			if ((dir ^ msg[i].flags) & I2C_M_RD) {
+				/* The direction changes.
+				 */
+				dir = msg[i].flags & I2C_M_RD;
+				cmd->CmdConfig |= CMDCONFIG_RESTART_MASK;
+			}
+
+			req->NumCmds++;
+
+			/*
+			 * Insert STOP if we are at the last byte of either last
+			 * message for the transaction or the client explicitly
+			 * requires a STOP at this particular message.
+			 */
+			if ((j == msg[i].len - 1) &&
+			    ((i == num_msgs - 1) || (msg[i].flags & I2C_M_STOP))) {
+				cmd->CmdConfig &= ~CMDCONFIG_RESTART_MASK;
+				cmd->CmdConfig |= CMDCONFIG_STOP_MASK;
+			}
+		}
+	}
+	mutex_lock(&adev->pm.mutex);
+	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
+	mutex_unlock(&adev->pm.mutex);
+	if (r)
+		goto fail;
+
+	for (c = i = 0; i < num_msgs; i++) {
+		if (!(msg[i].flags & I2C_M_RD)) {
+			c += msg[i].len;
+			continue;
+		}
+		for (j = 0; j < msg[i].len; j++, c++) {
+			SwI2cCmd_t *cmd = &res->SwI2cCmds[c];
+
+			msg[i].buf[j] = cmd->ReadWriteData;
+		}
+	}
+	r = num_msgs;
+fail:
+	kfree(req);
+	return r;
+}
+
+static u32 smu_v13_0_0_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+}
+
+static const struct i2c_algorithm smu_v13_0_0_i2c_algo = {
+	.master_xfer = smu_v13_0_0_i2c_xfer,
+	.functionality = smu_v13_0_0_i2c_func,
+};
+
+static const struct i2c_adapter_quirks smu_v13_0_0_i2c_control_quirks = {
+	.flags = I2C_AQ_COMB | I2C_AQ_COMB_SAME_ADDR | I2C_AQ_NO_ZERO_LEN,
+	.max_read_len  = MAX_SW_I2C_COMMANDS,
+	.max_write_len = MAX_SW_I2C_COMMANDS,
+	.max_comb_1st_msg_len = 2,
+	.max_comb_2nd_msg_len = MAX_SW_I2C_COMMANDS - 2,
+};
+
+static int smu_v13_0_0_i2c_control_init(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int res, i;
+
+	for (i = 0; i < MAX_SMU_I2C_BUSES; i++) {
+		struct amdgpu_smu_i2c_bus *smu_i2c = &adev->pm.smu_i2c[i];
+		struct i2c_adapter *control = &smu_i2c->adapter;
+
+		smu_i2c->adev = adev;
+		smu_i2c->port = i;
+		mutex_init(&smu_i2c->mutex);
+		control->owner = THIS_MODULE;
+		control->class = I2C_CLASS_SPD;
+		control->dev.parent = &adev->pdev->dev;
+		control->algo = &smu_v13_0_0_i2c_algo;
+		snprintf(control->name, sizeof(control->name), "AMDGPU SMU %d", i);
+		control->quirks = &smu_v13_0_0_i2c_control_quirks;
+		i2c_set_adapdata(control, smu_i2c);
+
+		res = i2c_add_adapter(control);
+		if (res) {
+			DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+			goto Out_err;
+		}
+	}
+
+	/* assign the buses used for the FRU EEPROM and RAS EEPROM */
+	/* XXX ideally this would be something in a vbios data table */
+	adev->pm.ras_eeprom_i2c_bus = &adev->pm.smu_i2c[1].adapter;
+	adev->pm.fru_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
+
+	return 0;
+Out_err:
+	for ( ; i >= 0; i--) {
+		struct amdgpu_smu_i2c_bus *smu_i2c = &adev->pm.smu_i2c[i];
+		struct i2c_adapter *control = &smu_i2c->adapter;
+
+		i2c_del_adapter(control);
+	}
+	return res;
+}
+
+static void smu_v13_0_0_i2c_control_fini(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int i;
+
+	for (i = 0; i < MAX_SMU_I2C_BUSES; i++) {
+		struct amdgpu_smu_i2c_bus *smu_i2c = &adev->pm.smu_i2c[i];
+		struct i2c_adapter *control = &smu_i2c->adapter;
+
+		i2c_del_adapter(control);
+	}
+	adev->pm.ras_eeprom_i2c_bus = NULL;
+	adev->pm.fru_eeprom_i2c_bus = NULL;
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
+	.i2c_init = smu_v13_0_0_i2c_control_init,
+	.i2c_fini = smu_v13_0_0_i2c_control_fini,
 	.is_dpm_running = smu_v13_0_0_is_dpm_running,
 	.dump_pptable = smu_v13_0_0_dump_pptable,
 	.init_microcode = smu_v13_0_init_microcode,
-- 
2.25.1

