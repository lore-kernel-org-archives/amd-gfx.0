Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD6DC4707B
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 21:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E71ED10E678;
	Wed, 10 Jan 2024 21:54:14 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E2C810E678
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 21:54:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+HPAWTDdMRZNwlhmN0ZX0M6orT83m2ohg7YbsQEs0KYm+qMK/gV//7qj0P6sxOPmDxr2yGvn7sn449c8LGVKNlfYvJ9WtG/U4HG1pT/GH0J6t1InLboX0Eg6zSZkcsQUz39rvS3MPtPTBqMsD38o7EgMeDEpRvrHVrNf1YkCyxnljd9l0wCtKjhfhoKl0xefTcMJLToRz/Eh4NvEjCXABmO/2MFM3xXGPzbzJlUvteIpA2nNWOFhtIqR1MlE2CAwNOJYtSV1VffDrpXVuxNh5E/5FKpp/l+3HDzRL3XmpJNEKoUIkPIxR4Aos6MrBQn9IEA4GuosqTkZrm8yvr4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvFYftttsZO6GIqLxSQ/tDp14z6UDFdJUnhjgKe0iW8=;
 b=Fw9OvoHmR/fzP6l5aKrCeQUGJlnX+TI8GyoatZtqmNkAg7YX4snsbDogDWKUrbq+Aj4yCVWD194mJa+DyoFHiimFHk1dwFsoGImwLiBMoqZtwOsOL4NJuQ0l+UTSB+YOZuD6SRNAORNBbcgABplC3clcHe61D4b0ACM5K0sZKFcV6IsrbO/rFceQTvJUiViR1TGTEhOiYsYQ09FOow9dawu1wFoO/XNHM7BslNbKLeI2mQQdK/5qCWyoJaxVbSy/m64OJWm3qypRB+zm4/tG9bjp4nVvmHPY4UHPDKyQrmWjK9i3IHnYwq0rZFE0HMX4VC96Pa/nPN46kLvPYOJ1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvFYftttsZO6GIqLxSQ/tDp14z6UDFdJUnhjgKe0iW8=;
 b=BYgjPhgDMwtab+qHvRvx7N8VF55zfP4DpBV+HJ3b7i9b9xoVR5S0Wk2rCP7Pg21fXVIrfsZJ+3sX8gnmvU80Nl3Sr4oPE6Tm1jt9lMi8Zj4NV7cgw9DKWIWBuzhdmWtphiKOF7gq/Ci9KsnhQPqFJbt/vzHzC+7niGhsEcSsJAg=
Received: from MW4PR03CA0096.namprd03.prod.outlook.com (2603:10b6:303:b7::11)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 21:54:11 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:b7:cafe::1d) by MW4PR03CA0096.outlook.office365.com
 (2603:10b6:303:b7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 21:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 21:54:11 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 15:54:08 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/19] drm/amd/display: Init link enc resources in dc_state
 only if res_pool presents
Date: Wed, 10 Jan 2024 14:52:45 -0700
Message-ID: <20240110215302.2116049-3-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110215302.2116049-1-alex.hung@amd.com>
References: <20240110215302.2116049-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0dbdc9-dbed-4c85-3b01-08dc1226adc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jl16aKHAr2nx3CVFP1Q+O5bVP0RKLFFu/HHPBy+K0pgyLdxNU5jb5sKqYniw/eQ5lvGsItauILi/BBeB6LGDg53V3W6oqHZn7EnzAeM/sa+lx8pbJf2kwimxgzvghUQRzF+8m9kNxlWnxtpxETGfrRM3M2g7jgBWFGcjDbGjDgbeVMjk8M6rVtqo5E64UxIjrgPzS/6xzfQPC/Qzgzi/LU+NChZpqFrp0jL3dIck2Jkkk74mnuxRDQDUhOCpBoMAIYV+SvRG1FR5e1+XDCpiUsS4a3GbAeboU6AVtIPgyruaVUD/pHHbw/6/wx4E92W8IkWfSM0rHMts3qNEJtNYBhNZZbnZ/h4ESoCZBhkR5xT15MoDfCz7HtQ3aIf+2EQ2IvsKdtwN2gPgXN16cdCdph87zMHRlU0bbk/Gget1HZEYUblb9i+JtlP10D+gbaOAzE1sGhWCDyTatCwFJKqujoDErt4z6GCEWrTrV+1/4U6i5dSxSEmV/kLIiAvSN2RKyGIqZMfHsDg251tnQOmquT3JnCgqL86PJ5hdxHcovdUmkDNBUVay/IJ8NydIoKHllNoUhpYSlU2vZ+B9dTJqRs3BUn0F7fYS1PB9kkD7297xL3LnQIpvq5BGcNuIxwFCoz4uo8hivNygvHQr3JoXTx41QDuBVWTRVaisCQ0tQpwTcs4u34+CsEc8CPMCaZPqEV9+xHumOOGsR76GLKj/ryyjLl5OSn62GsR2CvZNsX7pZgO/cCcWP49M9vvsrJc7HPN4QOt5xq5R8rTKWmwlpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(16526019)(478600001)(7696005)(336012)(426003)(2616005)(1076003)(26005)(6666004)(86362001)(82740400003)(81166007)(356005)(36756003)(41300700001)(44832011)(70586007)(83380400001)(36860700001)(5660300002)(2906002)(47076005)(4326008)(8676002)(8936002)(70206006)(316002)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 21:54:11.1933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0dbdc9-dbed-4c85-3b01-08dc1226adc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Martin Leung <martin.leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, stable@vger.kernel.org, Alex Hung <alex.hung@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>, wayne.lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <dillon.varone@amd.com>

[Why & How]
res_pool is not initialized in all situations such as virtual
environments, and therefore link encoder resources should not be
initialized if res_pool is NULL.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 460a8010c79f..56feee0ff01b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -267,7 +267,8 @@ void dc_state_construct(struct dc *dc, struct dc_state *state)
 	state->clk_mgr = dc->clk_mgr;
 
 	/* Initialise DIG link encoder resource tracking variables. */
-	link_enc_cfg_init(dc, state);
+	if (dc->res_pool)
+		link_enc_cfg_init(dc, state);
 }
 
 void dc_state_destruct(struct dc_state *state)
-- 
2.34.1

