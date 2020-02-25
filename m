Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A883C35E01
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 14:33:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6F720658
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 14:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ws/470mZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6F720658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0FA06EAEF;
	Tue, 25 Feb 2020 14:33:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE936EAEF
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2020 14:33:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIyvBV0u9gmHqQkIcc2FBC4rhWbIRIs5X6uBZAz4k5sspLsNfpJjeXuj0kwcQuw+W33uk/x5TdeGuEPmSUgWhe5wf28X/DzuZnNxQ681gN9E0e8e2dh5KasDXEVcaVKxZHNWGb7nyOtaOUSigPZ6+z5+dLO+uKVfgqSzlS9tYxLBSDEM//LA2dc7oKCjOt0O+upPhgD8CRSD8EW0vByCck/sPu9pkAVvmQQ5U0Y0BY1FelwyMqkkuw9fJiDHsRpUFTJdpgpg/m1gkPdke8l64r0a6cCuCWCL6R7pfp5jzEIYQUuBXQlg8OtHOiUmBL/J5Nc3yGt1u7wtzxeqULp79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etrNWVOU0UnS+dfrWEVZkmzVSd6txmg/IPQLQHepoEQ=;
 b=Et4ZovQVehsKs7wZO948Ifb/76cio1qIIpJL39f7nvJS4J4ZGw8buLPKzHoySB4/F2daGlkmol1ga+IYR6L6CryrGB7N0gqvU0jo/6uczPWTcp3B8mUkmhID5sRXEp4GTD/LPFlOQAnFydMKPqwfFB4aTmi8y9o3IaJlk174Rf+d8QsgIYjqeijt91hUSuzYVBoKmRPuWCBzUDAWTq7NbPMAhdPgRXxh5O37T242yQf3PISvFK2c5l9EA1v5oEm7OgSXcvx7uZJW8pqCnHF51Ba/tONO2hR0FrWwIJ9U7bowvEIW1puPx1uDEIxC22OR3zHDioUYUbNYdgHdqvGctw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etrNWVOU0UnS+dfrWEVZkmzVSd6txmg/IPQLQHepoEQ=;
 b=ws/470mZa1B3EfIYlbRQkZOakhseRDBeab7Vnfjk5TW4TuFIO6+H+jePc9toshsKveyIcrQ9CViEQOPs/ri70VAfKpj7yIJf5edAaRxhuRSRDq2iC75QZXnMIe4XY7Kuc+d/d5ad2+4FoueHh3TAjgcI9PJsDwCIv+jvka4Iwog=
Received: from DM6PR12CA0002.namprd12.prod.outlook.com (2603:10b6:5:1c0::15)
 by MN2PR12MB3134.namprd12.prod.outlook.com (2603:10b6:208:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Tue, 25 Feb
 2020 14:32:59 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::d8) by DM6PR12CA0002.outlook.office365.com
 (2603:10b6:5:1c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Tue, 25 Feb 2020 14:32:59 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 14:32:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 25 Feb
 2020 08:32:58 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 25 Feb
 2020 08:32:58 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 25 Feb 2020 08:32:56 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 John Clements <John.Clements@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Kenneth Feng <Kenneth.Feng@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add DFCstate control pptable func for arct
Date: Tue, 25 Feb 2020 22:32:48 +0800
Message-ID: <20200225143248.13324-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225143248.13324-1-Hawking.Zhang@amd.com>
References: <20200225143248.13324-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(428003)(199004)(189003)(2906002)(5660300002)(356004)(1076003)(7696005)(110136005)(316002)(6666004)(6636002)(2616005)(336012)(186003)(36756003)(4326008)(81156014)(478600001)(81166006)(426003)(8936002)(70586007)(26005)(86362001)(70206006)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3134; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70d05bf6-92d6-4ee7-03d7-08d7b9ff9ca0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3134:
X-Microsoft-Antispam-PRVS: <MN2PR12MB31340B557BD4D26206C748E2FCED0@MN2PR12MB3134.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 0324C2C0E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4sni42FM06czir19h+3sFPC17rOR6C+A1eaxUPg8YUuChqk4fz7+uaIUpHbjNzhc2h99OXdUP9M0GqocxoujZDLGgvdxLAlJJA8gRQRljpEvK65HsOx3gUA0ImraVWNPXNmolGC8A3olBiDwV5PN7H4Se4CEj6m07ubKhqAxE0lVezw6gx2f2uDXJiuW1YR9irOtBubjvfYQoBOD2/+NuQNSybtKnJvPD518q6WeWgPjd1MyoH50hLE15mL2B3j+9n0IDJOzymKD9IeD4MgYXI5+vRra4tPBxSKSMk8NNnkDcxHy58pk1tqFc7amfok0pX+HFAT9cBJz79C7ky9LT46+4ub618U7QTheTuWB4tCsWupn1vpavIVKVChFt9wXohzGCtCiCbtlyAwtqor5T9/cW4gLpMKzoAPiavKFGKTEuf0IFsteZz+S8NXPZk8n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 14:32:59.0786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d05bf6-92d6-4ee7-03d7-08d7b9ff9ca0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3134
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

This is the callback function that is going to be invoked
when amdgpu_dpm_set_df_cstate is called to toggle DFCstate

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 14ba6aa876e2..d3c4e7a8c1b1 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -127,6 +127,7 @@ static struct smu_11_0_cmn2aisc_mapping arcturus_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(WaflTest,			     PPSMC_MSG_WaflTest),
 	MSG_MAP(SetXgmiMode,			     PPSMC_MSG_SetXgmiMode),
 	MSG_MAP(SetMemoryChannelEnable,		     PPSMC_MSG_SetMemoryChannelEnable),
+	MSG_MAP(DFCstateControl,		     PPSMC_MSG_DFCstateControl),
 };
 
 static struct smu_11_0_cmn2aisc_mapping arcturus_clk_map[SMU_CLK_COUNT] = {
@@ -2214,6 +2215,27 @@ static uint32_t arcturus_get_pptable_power_limit(struct smu_context *smu)
 	return pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
 }
 
+static int arcturus_set_df_cstate(struct smu_context *smu,
+				  enum pp_df_cstate state)
+{
+	uint32_t smu_version;
+	int ret;
+
+	ret = smu_get_smc_version(smu, NULL, &smu_version);
+	if (ret) {
+		pr_err("Failed to get smu version!\n");
+		return ret;
+	}
+
+	/* PPSMC_MSG_DFCstateControl is supported by 54.15.0 and onwards */
+	if (smu_version < 0x360F00) {
+		pr_err("DFCstateControl is only supported by PMFW 54.15.0 and onwards\n");
+		return -EINVAL;
+	}
+
+	return smu_send_smc_msg_with_param(smu, SMU_MSG_DFCstateControl, state);
+}
+
 static const struct pptable_funcs arcturus_ppt_funcs = {
 	/* translate smu index into arcturus specific index */
 	.get_smu_msg_index = arcturus_get_smu_msg_index,
@@ -2307,6 +2329,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
 	.override_pcie_parameters = smu_v11_0_override_pcie_parameters,
 	.get_pptable_power_limit = arcturus_get_pptable_power_limit,
+	.set_df_cstate = arcturus_set_df_cstate,
 };
 
 void arcturus_set_ppt_funcs(struct smu_context *smu)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
