Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A698C00A5A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 05:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B029A10E045;
	Thu, 19 Jan 2023 05:00:15 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEFB010E045
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 05:00:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiuu1sE+KiPy53q52GePbCcIB84PiaNExysY+9a9/NMn+Ht+4P05LMsicFACmq3RzooZQsqHygRxHnLyUipDEh2qsXw3W+GHJtGmcc/sWmsWUFfupwTxKt1ZCWvk/9H+alirXLy7QlQDgHGMCgV7/OhxevohBNa+GSVshgRvecO6Z9FNFEHMw1VwoBUm8n/FATVjsj2FtvkOgFpQtWWlZ5HI4k36lcnofgXCvsJ/Uf7nyjBgj2/SEc17j75Hu5YThjZU5fzGHtuP6ABFf629iys60JW8mno1UKWOfpDJjA44VyGPVyRLZhnnirD28wBc9DnSnKXnpNg9Xqg4vdMdKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rfBPEsSDYENoRZydiC/Ate+lmefLPdscVbzMHn/xT0=;
 b=Z4yABi4tMWEmJazG0jgUSGlITxLfeEsBNVIZFNHNUJNviXZp6PH04X/PYIWFF81TaGefS7hdf7tYzF+78QyJWdXPysMDcY0N/zCaOAOD3uP4m24hNh21nmzabkpuh3BgSloOFz7Y3tlQHQCFDLvzEwgdNIgosfI82CI5dwd4FeMp5vWAhDN2q9wjtMlXZtTq9zbGUp9IUsR5nhYzcLEx4w9mVFAbuR6aaxiGy+EUwuCuEzbEaB0933eY9ecleuntTB/FsRvcMGqvTGKfBCDD7kbvuzB19PgcgBrdELcob8ekD5LMx3IyOOCHDESYvwj/BGK97OW6LnXHIz0YOfl9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rfBPEsSDYENoRZydiC/Ate+lmefLPdscVbzMHn/xT0=;
 b=FIU23LpXq6uFjIa/+TElwcqRs+bEvazN5xnu/nmg7m8C18nHoKW/RueeB3TRrBwp6aRNt6awoUQKwxXljY9SSsqErwKNwhJ2xOZIqN4KnBjWb7sosdt42MYGs8iaP43z3mxuK7kkT1sWo5FNKuTu6j9JPqwpvexYLEaTJJKo1yM=
Received: from BN9PR03CA0987.namprd03.prod.outlook.com (2603:10b6:408:109::32)
 by PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 05:00:11 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::3f) by BN9PR03CA0987.outlook.office365.com
 (2603:10b6:408:109::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Thu, 19 Jan 2023 05:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.24 via Frontend Transport; Thu, 19 Jan 2023 05:00:11 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 23:00:08 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Add sdma ras function on sdma v6_0_3
Date: Thu, 19 Jan 2023 12:59:30 +0800
Message-ID: <20230119045931.576688-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT091:EE_|PH7PR12MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 49198526-dbbe-4c74-df2f-08daf9da0b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONQO3/2SGc0lOe6PV4MLHN9gImk7LabOjvMBJc9OGvKkjLlEDbyiIR2P6zGBFEK+Dg9T/8W8Alg2rOltIyzWAD/Vz8oYCrTaF8O/LeKLAM55pdmQ+FfTLFPqL+n50iaw9cpBBGXL60iBC4QnX1QOgvGtvSppMNM2VJbuXZlkyvh9XgWaHbTwULpEWb8GsFW5m0CXpX2gHBL/sB5ozSQaMup7q6xoksNL8bXmRdtnq5hPIigKoXqwhYCDapwUxUuvLqPjX5EYGtZMVs740JSMrTGni71iY7PiTU/+lgFe3Ywz4aHE8IoExj5w6qLFxUJCTuEQ2Urwe9yk0jxagmT05Ty+LeZ6H6MIsJgS05PcoG2+xSOJFJS/P7tKjGztCLfNW/gLD/FqF0I96plDBo+WlCV4N0Flh/ACvrk3KcZJgYlsX4j8hFkajAiYrX0yhYkWZnMwT3TvM4RkMQW+/Ng4xG3q/OPmuuAqoMp2uVTlHFxFqgjd5LTWicHcjUcJKz9EIq0FmCd/5kxz+qJ76QOIjy8mOs6Pt5VFMxFTJMk8iS1NjZ4nWvpaAYKyLmqSiqaXkj1HxLbDSk0t8f/Ab3DPZG8BPuPitBIZR0zHdnfEXaHP60pstP8aTSaQZEFZS9PmxSqnetrB3HuvmSQ9d0FfFOIddxcqr6TD04V0sJwaJ7jh6mPywrILATklfsocvWKzLmxe09qPaDcUFuP3aDvigqBWQOMf1xc0EBFva7wV/vo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(82310400005)(336012)(40460700003)(16526019)(54906003)(7696005)(186003)(36756003)(478600001)(40480700001)(36860700001)(81166007)(356005)(2616005)(47076005)(70586007)(1076003)(82740400003)(86362001)(426003)(8936002)(6666004)(70206006)(4326008)(26005)(2906002)(6916009)(8676002)(316002)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 05:00:11.0702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49198526-dbbe-4c74-df2f-08daf9da0b1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Hawking.Zhang@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, Candice.Li@amd.com, yipechai@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add sdma ras function on sdma v6_0_3.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 35 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 24 ++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index e9b78739b9ff..231ca06bc9c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -305,3 +305,38 @@ void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev)
 		}
 	}
 }
+
+int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
+{
+	int err = 0;
+	struct amdgpu_sdma_ras *ras = NULL;
+
+	/* adev->sdma.ras is NULL, which means sdma does not
+	 * support ras function, then do nothing here.
+	 */
+	if (!adev->sdma.ras)
+		return 0;
+
+	ras = adev->sdma.ras;
+
+	err = amdgpu_ras_register_ras_block(adev, &ras->ras_block);
+	if (err) {
+		dev_err(adev->dev, "Failed to register sdma ras block!\n");
+		return err;
+	}
+
+	strcpy(ras->ras_block.ras_comm.name, "sdma");
+	ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__SDMA;
+	ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
+	adev->sdma.ras_if = &ras->ras_block.ras_comm;
+
+	/* If not define special ras_late_init function, use default ras_late_init */
+	if (!ras->ras_block.ras_late_init)
+		ras->ras_block.ras_late_init = amdgpu_sdma_ras_late_init;
+
+	/* If not defined special ras_cb function, use default ras_cb */
+	if (!ras->ras_block.ras_cb)
+		ras->ras_block.ras_cb = amdgpu_sdma_process_ras_data_cb;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 2d16e6d36728..fc8528812598 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -129,5 +129,6 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
 void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
         bool duplicate);
 void amdgpu_sdma_unset_buffer_funcs_helper(struct amdgpu_device *adev);
+int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 6fe292a2486b..3d36329be384 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1211,6 +1211,24 @@ static void sdma_v6_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
 	amdgpu_ring_emit_reg_wait(ring, reg1, mask, mask);
 }
 
+static struct amdgpu_sdma_ras sdma_v6_0_3_ras = {
+	.ras_block = {
+		.ras_late_init = amdgpu_ras_block_late_init,
+	},
+};
+
+static void sdma_v6_0_set_ras_funcs(struct amdgpu_device *adev)
+{
+	switch (adev->ip_versions[SDMA0_HWIP][0]) {
+	case IP_VERSION(6, 0, 3):
+		adev->sdma.ras = &sdma_v6_0_3_ras;
+		break;
+	default:
+		break;
+	}
+
+}
+
 static int sdma_v6_0_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1220,6 +1238,7 @@ static int sdma_v6_0_early_init(void *handle)
 	sdma_v6_0_set_vm_pte_funcs(adev);
 	sdma_v6_0_set_irq_funcs(adev);
 	sdma_v6_0_set_mqd_funcs(adev);
+	sdma_v6_0_set_ras_funcs(adev);
 
 	return 0;
 }
@@ -1264,6 +1283,11 @@ static int sdma_v6_0_sw_init(void *handle)
 			return r;
 	}
 
+	if (amdgpu_sdma_ras_sw_init(adev)) {
+		dev_err(adev->dev, "Failed to initialize sdma ras block!\n");
+		return -EINVAL;
+	}
+
 	return r;
 }
 
-- 
2.25.1

