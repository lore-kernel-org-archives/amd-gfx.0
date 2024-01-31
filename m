Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8633C47DB3
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF8B610FCAE;
	Wed, 31 Jan 2024 20:14:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A5F10FC6F
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:14:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIMB46tqm5XJwgyg8Iex5RDsmhSjHhRj6dSptGPKYgNl+Q1cEIoRHYoylx3rUytW1n91xLQY9QQRnMAnD4HUGpZpQlxcJj6AkbMdP3PQaBEqUSDhFkhNnOh2Tk1bhgYKB3iwDnaUqeU8PsAFlysgG8K1U2llFRjTN6ow1wlw3K/oyOBEDO1T1si+AhWpCmdLQ4zJuvJs4Kp5kIcSDu2UNgjNld7Y0uSOWBF/9f8797AxYxoVqmbJLp25tNMvnyP7L/aWvJJGM+na5694U646cxPKQZ3KVbMdujBDpO+yMxtbkjXzm9vh1GmH11VPeQuX5JDfiORG0q5Ugo3LWnWuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sR1gGih9sWPD2OpZ+6iT28+zLrwKbSsSfxuhKLakL/M=;
 b=duznLadfS21LDFrEp9UFeg/6jaZi+60C/eQrduOTP9gg0VOJ5f3YEu62PPOjC1wbMYmAnH0/aSdcfCDQ6mahfxYOIOYoLxCHnKTK57Y4mrBP6beTalht7xI+jL7EoQVC09q7xZWxB2qN7csRQ6zwOX/d39EcJLvLs/A6NMX/Rab8Qy7d1yMspf1xKoZZB0rM7cbke3cpwNnmJX4erXG+8rKE4VnmNOGLKBHkT64T/t7GLbMqaViTnLU/0WWMicBJL4x83siqRFevu8nJHIW759F2VPatOaJfMxW8R4DA/mCl4vTS3eB79j5YQ5NGrQGvI50gf6Pkzln5pzlv4RvIWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR1gGih9sWPD2OpZ+6iT28+zLrwKbSsSfxuhKLakL/M=;
 b=Dnfjkona3B47B9Eeo+xkJTmtjFhqxQ/myl2xs3GVLDIVFsQDbj0yoOCrQAkrLZ88NKVJjEwJoe9KE/21CrCpi6LLRZLBDYVZmDOmmeBZxnm07Vo26w/AKuh7kiS/mvKD4DwB9YKjqg9GL6awFyR3/d8nB4xShd5sBxJ2uMDnn64=
Received: from SN7PR18CA0011.namprd18.prod.outlook.com (2603:10b6:806:f3::19)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 20:14:51 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::5b) by SN7PR18CA0011.outlook.office365.com
 (2603:10b6:806:f3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Wed, 31 Jan 2024 20:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:14:51 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:14:49 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/21] drm/amd/display: Add delay before logging clks from hw
Date: Wed, 31 Jan 2024 15:11:19 -0500
Message-ID: <20240131201220.19106-14-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131201220.19106-1-hamza.mahfooz@amd.com>
References: <20240131201220.19106-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: f58333ed-31fe-43b5-3ff1-08dc2299482a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yr8+bX+ng+0AV+o5ADXcX6WgINE6dZuRpu5gt/E1WDz3bxGpSSQrRmAnRgij5jnpH7E1eelOKoCWf6Ryw9Pk13EBbj16YUAxu0u0gUBrF39vPqqUPWnZHaSkgDcVcwoApqq0Wl9jYEZdWx7MUM/VgmpzJrnXyNLZUwwCLVe5O2rVi2IEFpXuyIJXqsdIfSYBcWhjoZazjQNI8c6xqmRpbObhl3dvf/57A+QWs6F6jg/nZaX1WhzxpSMg5pwENWdr+KKbiwPW4UZILtrJOW6hc+yYxpNuLpRBhCoyBtFwYy6C387n/I+v+M01ntEWoso+D3ltJAz2+mqJGseaINx2bWOX2B3B8aGPXhdGTAHaeerTWu/9Nza1cVRnqNlwp5GtsAs6R0UFQ2MFssnSt9PdQd621GRgMWjbpMKi3dU2XryMawEAfTUB+V9NKjp5i5p+PC3vjb6Wg38P2Qxep9UhLHb9CdSZ6/k8yYbBVTusqfST8rvZUcwnVNVHX73H+q2gOp3dT1uy1luRrREouBbVcAkSG9uyt3Fy3MnT5lGkTPOMqZqbkmU0C5VCN7FOxh6b3yx8ROm4WNJVoREaZYbVVPixFCPMRPGdAXMfrtzhHmqu33fOswCq0DtBugFdKaoHSZIRCukn57F5BwD9VrxfBwnbp0XoWs4bacf8lOv5jr12rGlY9oDrnizXl/lD0LmyC2WEXvKSybRIMIRKDKTl4RsndrXLsbsFtHP40M9oycHSSYMNwHtSRHnWc3ElGjUFCdpPxA1hrooD/9T7kk+9ltNH+Ykop78kbWrXFxLAYW8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(82310400011)(1800799012)(186009)(451199024)(46966006)(40470700004)(36840700001)(16526019)(41300700001)(81166007)(36860700001)(47076005)(36756003)(86362001)(82740400003)(356005)(8936002)(6666004)(4326008)(54906003)(8676002)(6916009)(316002)(70206006)(70586007)(478600001)(336012)(26005)(2906002)(4744005)(2616005)(1076003)(44832011)(5660300002)(426003)(40460700003)(40480700001)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:14:51.3961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f58333ed-31fe-43b5-3ff1-08dc2299482a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250
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
Cc: Ethan Bitnun <etbitnun@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ethan Bitnun <etbitnun@amd.com>

Add a small delay before reading clks from hw, to ensure correct values
are used for logging.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Ethan Bitnun <etbitnun@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 8fa0aae941c3..e64e45e4c833 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -509,6 +509,8 @@ static void dcn32_auto_dpm_test_log(
 		}
 	}
 
+	msleep(5);
+
 	mall_ss_size_bytes = context->bw_ctx.bw.dcn.mall_ss_size_bytes;
 
     dispclk_khz_reg    = REG_READ(CLK1_CLK0_CURRENT_CNT); // DISPCLK
-- 
2.43.0

