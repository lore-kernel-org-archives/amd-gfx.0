Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE54DC282DD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6CF2070E
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u9+UK9/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6CF2070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B806E8B0;
	Wed,  8 Jan 2020 16:17:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFA736E8B0
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 16:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SknXAfTYYPSUsiIcyaKciUYbrq0qwZhHLKWJVu7z3EXmm0+ZvttIHUbA9bk3H/DdJPIgyj6vzh87RwP+69I2Aj4lijuB5Xh3IA0XDlQRt+Ut9Ka+guRo07P5GxlxxdHo9swJFP1iVNyqWzSWCwGZHkHuuSfMBgd2YZg+vTxXTydazlVHjMaeVgvQ4yQQ1forTIz0tJGIsCILonVfUMTbLKfClWgCrRGuqpYx2Y0aUTamjHG2xjHzLa7a4UFEEyFIJl6rTYOnohaLU7Uf68TQfdoF7bmcg8/ohqdwfXETw35xHX0itVLEWCiF6OTT/q7be1J5ALjSy4hZTKHTmDiwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEz55nvdvtDrr31p2Lks9eXMLXkR9vKfU3lBmDleqsg=;
 b=VC/AvD2kdD3m3siAsLwK5TIoqlL1Ma4YDertkoyvghsNRQEaM+GpFAxrG84TpXLpwuQys8/0o8r0MZE2VGv2SXmIVMAAukwz2JbYhc9pWewR3KY/gxRMyoPVlRGNOtrs3/ixrOzb8DZPVN51Y/U19bJNolZWdyCofgQ/x6WZKO0e2uVcCl1scuCw2fjfFak9MHjcEmwMJ8KiMqv9tUsgzh8cmjcTtxuUWCdzkVnKc6z93BopjTKDFhmFjs1/XQus0oUAa4ECAM9Lc03wt15YlUGWmXV/GGdtZ3iwgva3Wqqw4Yqn5AWIsGya71WklChv6y1ET5leCEFe36nx9/9r7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEz55nvdvtDrr31p2Lks9eXMLXkR9vKfU3lBmDleqsg=;
 b=u9+UK9/IKS/Gl1iItwcCoSBxmWalwj1dASRvDW1UcFIDmmoEiwU/wypsNDvoVwWpCl26Mjwzxq59nmZgd/C1gbbVzPX2UZKZuuhee0BSrdvrWSzmLRKtvnHtgx/kjkfSI1rRrwJDHf1i/3170rcjywGEyvChP6qMdo2qTg0l6jQ=
Received: from DM3PR12CA0046.namprd12.prod.outlook.com (2603:10b6:0:56::14) by
 BY5PR12MB3859.namprd12.prod.outlook.com (2603:10b6:a03:1a8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Wed, 8 Jan
 2020 16:17:47 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::208) by DM3PR12CA0046.outlook.office365.com
 (2603:10b6:0:56::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend
 Transport; Wed, 8 Jan 2020 16:17:47 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 16:17:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jan 2020
 10:17:45 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jan 2020
 10:17:45 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 8 Jan 2020 10:17:42 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 Dennis Li <Dennis.Li@amd.com>, John Clements <John.Clements@amd.com>,
 "Guchun
 Chen" <Guchun.Chen@amd.com>, Tao Zhou <Tao.Zhou1@amd.com>, Candice Li
 <Candice.Li@amd.com>, Gang Long <Gang.Long@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: add query_ras_error_count function for sdma v4
Date: Thu, 9 Jan 2020 00:17:18 +0800
Message-ID: <20200108161721.7727-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108161721.7727-1-Hawking.Zhang@amd.com>
References: <20200108161721.7727-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(346002)(428003)(199004)(189003)(110136005)(6666004)(81166006)(26005)(1076003)(426003)(2616005)(336012)(186003)(36756003)(8676002)(81156014)(356004)(8936002)(5660300002)(7696005)(316002)(478600001)(2906002)(6636002)(86362001)(70206006)(70586007)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3859; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6b5ee56-7c60-40ef-8d42-08d794564c5e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3859:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3859D7B73574412208E72845FC3E0@BY5PR12MB3859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02760F0D1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbGFs98GBsNRtgeK0aJ8REzUdG9XQEPDocGD58uj/DOfshE9la+6hBgwxqg/6/9Ur011LLA4wXDb8PfuFvhJTlTREkxjzs7413lF8iVpX90aoWS1bATNIGOq9KH70WVQQXztsskAIiFf6Q++9Jgs3dreV+LJOlDbevQVo/Ps1s1KOsbeFlRJk5q7HOcyNnJ0dq9/YjkjdX5pz5PRJaY2dM0FUFL+asDGHCHBxjp9PKbPl5Tboz/iRoC3blJzjqpmKqKByVS//DZ3Gv3L9t18lwUYRYINRQ9X4wA2s00Xlv5MVmbHjVpIpCBpd9sc1+qsFH5pSPVNddzJUOqVjQWOldvzke9YswEZ8IQPi83fTafXA0fPoaNprPM1EbUnmQg5WEZgLbgdvLIvwUTSQ2J3IMs/Re2faCr2zJ4so2OHvOySgqoUJrLpNxx6PyOoA+x1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 16:17:46.3980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b5ee56-7c60-40ef-8d42-08d794564c5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3859
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

query_ras_error_count function will be invoked to query
single bit error count detected in sdma ip block

Change-Id: I1b17df7c66e71739ae4c31900bd96c5359af2240
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |   6 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 163 +++++++++++++++++++++++
 2 files changed, 169 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 957791673fcd..9e87a97f81fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -50,6 +50,11 @@ struct amdgpu_sdma_instance {
 	bool			burst_nop;
 };
 
+struct amdgpu_sdma_ras_funcs {
+	int (*query_ras_error_count)(struct amdgpu_device *adev,
+			uint32_t instance, void *ras_error_status);
+};
+
 struct amdgpu_sdma {
 	struct amdgpu_sdma_instance instance[AMDGPU_MAX_SDMA_INSTANCES];
 	struct drm_gpu_scheduler    *sdma_sched[AMDGPU_MAX_SDMA_INSTANCES];
@@ -61,6 +66,7 @@ struct amdgpu_sdma {
 	uint32_t                    srbm_soft_reset;
 	bool			has_page_queue;
 	struct ras_common_if	*ras_if;
+	const struct amdgpu_sdma_ras_funcs	*funcs;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 4074314695c3..a00b85934b04 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -82,6 +82,7 @@ static void sdma_v4_0_set_ring_funcs(struct amdgpu_device *adev);
 static void sdma_v4_0_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v4_0_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v4_0_set_irq_funcs(struct amdgpu_device *adev);
+static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev);
 
 static const struct soc15_reg_golden golden_settings_sdma_4[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_CHICKEN_BITS, 0xfe931f07, 0x02831d07),
@@ -257,6 +258,105 @@ static const struct soc15_reg_golden golden_settings_sdma_4_3[] = {
 	SOC15_REG_GOLDEN_VALUE(SDMA0, 0, mmSDMA0_UTCL1_WATERMK, 0xfc000000, 0x00000000)
 };
 
+static const struct soc15_ras_field_entry sdma_v4_0_ras_fields[] = {
+	{ "SDMA_UCODE_BUF_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_UCODE_BUF_SED),
+	0, 0,
+	},
+	{ "SDMA_RB_CMD_BUF_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_RB_CMD_BUF_SED),
+	0, 0,
+	},
+	{ "SDMA_IB_CMD_BUF_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_IB_CMD_BUF_SED),
+	0, 0,
+	},
+	{ "SDMA_UTCL1_RD_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+        SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_UTCL1_RD_FIFO_SED),
+	0, 0,
+        },
+	{ "SDMA_UTCL1_RDBST_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_UTCL1_RDBST_FIFO_SED),
+	0, 0,
+	},
+	{ "SDMA_DATA_LUT_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_DATA_LUT_FIFO_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF0_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF0_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF1_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF1_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF2_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF2_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF3_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF3_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF4_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF4_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF5_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF5_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF6_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF6_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF7_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF7_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF8_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF8_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF9_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF9_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF10_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF10_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF11_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF11_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF12_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF12_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF13_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF13_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF14_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF14_SED),
+	0, 0,
+	},
+	{ "SDMA_MBANK_DATA_BUF15_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MBANK_DATA_BUF15_SED),
+	0, 0,
+	},
+	{ "SDMA_SPLIT_DAT_BUF_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_SPLIT_DAT_BUF_SED),
+	0, 0,
+	},
+	{ "SDMA_MC_WR_ADDR_FIFO_SED", SOC15_REG_ENTRY(SDMA0, 0, mmSDMA0_EDC_COUNTER),
+	SOC15_REG_FIELD(SDMA0_EDC_COUNTER, SDMA_MC_WR_ADDR_FIFO_SED),
+	0, 0,
+	},
+};
+
 static u32 sdma_v4_0_get_reg_offset(struct amdgpu_device *adev,
 		u32 instance, u32 offset)
 {
@@ -1687,6 +1787,7 @@ static int sdma_v4_0_early_init(void *handle)
 	sdma_v4_0_set_buffer_funcs(adev);
 	sdma_v4_0_set_vm_pte_funcs(adev);
 	sdma_v4_0_set_irq_funcs(adev);
+	sdma_v4_0_set_ras_funcs(adev);
 
 	return 0;
 }
@@ -2417,6 +2518,68 @@ static void sdma_v4_0_set_vm_pte_funcs(struct amdgpu_device *adev)
 	adev->vm_manager.vm_pte_num_scheds = adev->sdma.num_instances;
 }
 
+static void sdma_v4_0_get_ras_error_count(uint32_t value,
+					uint32_t instance,
+					uint32_t *sec_count)
+{
+	uint32_t i;
+	uint32_t sec_cnt;
+
+	/* double bits error (multiple bits) error detection is not supported */
+	for (i = 0; i < ARRAY_SIZE(sdma_v4_0_ras_fields); i++) {
+		/* the SDMA_EDC_COUNTER register in each sdma instance
+		 * shares the same sed shift_mask
+		 * */
+		sec_cnt = (value &
+			sdma_v4_0_ras_fields[i].sec_count_mask) >>
+			sdma_v4_0_ras_fields[i].sec_count_shift;
+		if (sec_cnt) {
+			DRM_INFO("Detected %s in SDMA%d, SED %d\n",
+				sdma_v4_0_ras_fields[i].name,
+				instance, sec_cnt);
+			*sec_count += sec_cnt;
+		}
+	}
+}
+
+static int sdma_v4_0_query_ras_error_count(struct amdgpu_device *adev,
+			uint32_t instance, void *ras_error_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+	uint32_t sec_count = 0;
+	uint32_t reg_value = 0;
+
+	reg_value = RREG32_SDMA(instance, mmSDMA0_EDC_COUNTER);
+	/* double bit error is not supported */
+	if (reg_value)
+		sdma_v4_0_get_ras_error_count(reg_value,
+				instance, &sec_count);
+	/* err_data->ce_count should be initialized to 0
+	 * before calling into this function */
+	err_data->ce_count += sec_count;
+	/* double bit error is not supported
+	 * set ue count to 0 */
+	err_data->ue_count = 0;
+
+	return 0;
+};
+
+static const struct amdgpu_sdma_ras_funcs sdma_v4_0_ras_funcs = {
+	.query_ras_error_count = sdma_v4_0_query_ras_error_count,
+};
+
+static void sdma_v4_0_set_ras_funcs(struct amdgpu_device *adev)
+{
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
+		adev->sdma.funcs = &sdma_v4_0_ras_funcs;
+		break;
+	default:
+		break;
+	}
+}
+
 const struct amdgpu_ip_block_version sdma_v4_0_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_SDMA,
 	.major = 4,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
