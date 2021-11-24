Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AB8C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 16:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 018536EA9D;
	Wed, 24 Nov 2021 16:36:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE23E6EA9D
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 16:36:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8xm49zFipc22bQ8Sy028ovFjouWlLWcYIW1iWlDmMMjlbBYmycDDCZdyPA//+772YXeRTUqXTwkWye6su3Vb4itLmGkXRk6tFQtMFCPM94Ce7zdSf2qv5p2xQa4tsQfToYaOzODMHtSx7U92fwwrk1eiVXtUA7FS+4Ci8QBqcRAH8/42PUX4BKFLsJZbkH6awPwVzQbSOaXOJvLD4h2g/LsSk+uvSI7w7/gnmzYeRHBCQ1agbVBkBoCwHDjdHjvdrrykYBcrQZBYpuao6akAVCbWLNywEMPvYp2TjKaJraCtWe2DLelnTjV4uczESdHbR6A+tlXeIq+KVnkfRAylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiwsbYOM84z493h4VDaL267DgiS2DArp4Ublt+SWFr8=;
 b=WYRW6ubJfiYvxAkWa6mG68HyGNX1NvdBidltISZPaCO1Rq1jEeGe3J+SOnNr9oR6PfgCV+fcE+Ap+6EBpUPbyrR0Y8c5UIZGV2zP4KLHkL309ajNjqs2Scgnx1BJehUouqWcfT7I5JrRgqqzmQ1ZKAQp29XtpEg+3Z+Agec680UPZmJ71+diQi+WeR9eZwrjMvapc+5uwbGFAHT6s5OsD3Xp7UnyMcB2ps/RGNVC2GSfwq4wyoOkzbGOZG0NzgC+8hx9S4DoOr3mcrUqWe8oNskc7Nr8udvb0geFeBo2hi57BOs6BiQnJT1XjdbGR4fZ3YwcGxCzwCn5WAVpnNZ34w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiwsbYOM84z493h4VDaL267DgiS2DArp4Ublt+SWFr8=;
 b=hq3YiRJcWt8c7zyBW73DCy/Ef8w8UbTCCUBUH8TDMtbM8RUXf1gETAJGXpgkurfTkqiIkbXouLqQQlf+oITPkfcmp7cE1PU6x2XhjeK49SvdHQUPDwa6Cz6dIjnwyosSuPgdxvuUa1+DklW6MELUF6GrGg1qQQLsXc8IYRE5LyQ=
Received: from MWHPR14CA0054.namprd14.prod.outlook.com (2603:10b6:300:81::16)
 by BYAPR12MB3222.namprd12.prod.outlook.com (2603:10b6:a03:12c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 16:36:30 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::e6) by MWHPR14CA0054.outlook.office365.com
 (2603:10b6:300:81::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Wed, 24 Nov 2021 16:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Wed, 24 Nov 2021 16:36:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 24 Nov
 2021 10:36:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: fix 64 bit divide
Date: Wed, 24 Nov 2021 11:36:12 -0500
Message-ID: <20211124163612.2728640-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124163612.2728640-1-alexander.deucher@amd.com>
References: <20211124163612.2728640-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efbb98e9-c841-4cb7-488e-08d9af68917e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3222:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3222B6F66674FE8CC59F45C0F7619@BYAPR12MB3222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JoHoDm8Z2Y+t+ihaaKcRyYF/7EE/8ADgAheDR+7fUGXA7TXPUu7NzEyYBbWtbm3y/+oRbH1TM1vgJMwvY3YiU8vg0SF/4Q98GneSwIOHx+Rzl66jqmc5pDi4w7WUdtiGSx6wgtGKAceQKsNiHKH+BVVKK3Pnmn2z2W2awNZMP1l/wsesm7rjThaVOgx5e5zzQhA03O/maLth203weDkOA+7p4DjCloDodPgmMjock0LCBs9SBGyp3toLM0by0CoRXGAwZJFNeD7LURxbrOgWa2rQS/A/e4nGEMdH3O18np6f5YkT6NzhpP+0aL+lsXVa324YWHQTwcdiF6W5LoV0TQv/0sDmVDvDlPx+ilcoqL+8XKGXcGClq2FS/fno/vX2HviPTYeurRZDyjxms457YFBtZwFjZSKLc7V87EFpvn+hkrBYp7NwEH6pTNwaW61c5I5tZFmdO4hzWLSOzqVH/9w4DlzXXiAzYDxmRCIZhn2mBml1OQhTSiA+ElW8Cuv5xes5W7MBWoeElpnUSxW5LICEMUsMpwHXbC9p9ynDlBYNCyp1rjWHon+7qFR//yOgDSK59vKbnR34G2raj1JAiFAbxo20kAfd03vMXOKEkR1XISbzi1CNF2c9Re6jIr7IndCeHBiPtH2ej5yzEiWfRyxVwrVnyo0acV0T3vWku9/w5OEJjvD+OuRmfLdRfOXI9hbPFor9l7/HodH7mZfy99ZI0Eex2l78tkzle7VT3CA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(86362001)(6666004)(47076005)(336012)(508600001)(5660300002)(2906002)(81166007)(8936002)(82310400004)(356005)(6916009)(26005)(70206006)(8676002)(83380400001)(4326008)(16526019)(186003)(426003)(2616005)(36860700001)(54906003)(1076003)(70586007)(316002)(7696005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 16:36:30.0308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efbb98e9-c841-4cb7-488e-08d9af68917e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3222
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Bing Guo <Bing.Guo@amd.com>,
 Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use do_div.

Fixes: c34f1652a18c4b ("drm/amd/display: fixed an error related to 4:2:0/4:2:2 DSC")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bing Guo <Bing.Guo@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
index 381561ee0026..7e306aa3e2b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c
@@ -100,6 +100,7 @@ int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps, struct dsc_par
 	int              ret;
 	struct rc_params rc;
 	struct drm_dsc_config   dsc_cfg;
+	unsigned long long tmp;
 
 	calc_rc_params(&rc, pps);
 	dsc_params->pps = *pps;
@@ -111,9 +112,9 @@ int dscc_compute_dsc_parameters(const struct drm_dsc_config *pps, struct dsc_par
 	dsc_cfg.mux_word_size = dsc_params->pps.bits_per_component <= 10 ? 48 : 64;
 
 	ret = drm_dsc_compute_rc_parameters(&dsc_cfg);
-	dsc_params->bytes_per_pixel =
-			(uint32_t)(((unsigned long long)dsc_cfg.slice_chunk_size * 0x10000000 + (dsc_cfg.slice_width - 1))
-							/ (uint32_t)dsc_cfg.slice_width);  //ROUND-UP
+	tmp = (unsigned long long)dsc_cfg.slice_chunk_size * 0x10000000 + (dsc_cfg.slice_width - 1);
+	do_div(tmp, (uint32_t)dsc_cfg.slice_width);  //ROUND-UP
+	dsc_params->bytes_per_pixel = (uint32_t)tmp;
 
 	copy_pps_fields(&dsc_params->pps, &dsc_cfg);
 	dsc_params->rc_buffer_model_size = dsc_cfg.rc_bits;
-- 
2.31.1

