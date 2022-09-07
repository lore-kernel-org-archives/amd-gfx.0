Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62149C54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570C810E806;
	Wed,  7 Sep 2022 18:12:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B8B910E241
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/3Lorrb0rMpVx6uJFWhgOafocSddO0o3d+43lnsZIvuFT7fB9zfIieoXPF4YlR15V6+CbhS4Alyer/NxUw4GVnHl/5nJ4a4+MmTyWHPK4IW6XqR7khhxmZ3rJkeAw9seimxQio7LapWbWNr1MaOdpMttcJqewkztdL1+8yTTG6J7of4isba6x8/O+2N6JgD5YyBg4pvFR/+zQDhMslV1d7p+h7K9fFXmBxLkecar2LuRAbVUzGEXRfvS0R6gApA0wCrmtBT8DcPwqUPjV8KIdSGtJPCR4dt4+9VExsMQk+P/a8rjgCeZq5ldv8wOMzUAsU5B1WGAqykAhpfwk0q7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxWbAZySyZK1AUNh3RHRQsHPVwvzzoRtnMGfI1enSdg=;
 b=VCSA1J6kFTLbPqa4z5eZYSUdpek88MGNsF3nPY3qVx0JBZ0N/AkqYkuA4/zwBhZIwX59XRHqOzvC5jWf8U2zlef4pfswD+zMz8NAodtIgj045agtQiD6B7YwMgOYS9KXrVfmbZzXvL9ECXxcN66APgDy4NcDU7JLk/gYOXs0u3IN0rQzYNs/i+o3HMZP1rMNsJkU2rG0Y+tQ8cwXxybM/rZLYRed+cSC1zosVUO1h6Q+ZEp7wKlhWnuVbNPMsOheJ24hG2umTip/FSqFeP6OUVpjjbwVQU7OHPJ49efAHQwUQqR29X9BAjsq+cFSIQPdUcMFA30a7gyygwJ9DynnmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxWbAZySyZK1AUNh3RHRQsHPVwvzzoRtnMGfI1enSdg=;
 b=HCZffJ3FKbPdM7nYTR0ACOYC6QKQfLsjLd7Cd6/hsnIzx09MaGkcMBOsKFq3RTbvbX5D2ccMLUXqlFScxg9niHtsHgq2xMrV6tXyQ1m/jTOdzSWwd28GZpxJRGuOmmilStckVD9LY+YKUwaZcYFzjxbmgn6yn1iTBlvAW2xr6yM=
Received: from DS7PR07CA0010.namprd07.prod.outlook.com (2603:10b6:5:3af::29)
 by SJ1PR12MB6291.namprd12.prod.outlook.com (2603:10b6:a03:456::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 18:12:21 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::3e) by DS7PR07CA0010.outlook.office365.com
 (2603:10b6:5:3af::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:20 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:18 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/21] drm/amd/display: Fixing DIG FIFO Error
Date: Wed, 7 Sep 2022 14:11:43 -0400
Message-ID: <20220907181200.54726-4-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|SJ1PR12MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: aec2f580-0f98-4c57-2960-08da90fc8162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BlF28kTw/ZUWO9faqe8aFTrDPEvC+Vl5ouJblGgVJL9ygnyYliEPj3EPxh3IQS/wfR091AGrywohUFvDHI9ZbRSvx5dHutBZDRgIq+dmTz1p/yKC0p+ImvtlM47YUev0IFXUgffRsxw5V2/f/6illqzKsVrj35VjmNnuA7iRKpQ4147yIbkwLIzIdLLvExUFPac+6bFfX67biZ2W1lOhLz9JEVt0z6BOvwC+/LVt7yvYbZHOztVQH07oIFu1zMAl4+qM0lw+kSYp05C4e3DOOeNNjGTYK1jZpnOXr0dMtr6XHBNFqED2ex5ED+QDnz9i4sg7MCQUl9Crl/ybegjAOy7fNsOyqQAogtoCiIujRoGZJwWfo0emL+PodyMQ93uLY64N2ld3fYbaxqVY8V9MjE59+GthSeGvRIIqCeK8fEaV/a74t7R9xfM6Cd9K+eVbzSOBmFg7Pw0XgCBEk3oIS2jK4KzRI/dERnfDa/RrrVnlUZdxTvS5nWbZa5ASGu3Ntj+8RoEkgY3/IG8QIPShkTj9rzZEycHJ44bKo0COOMCf2MuXzilFXE17qf4uRGOhkHGYrDQGCCI38R4mgdRrEHSP5y2lmd43Pp89RzqVkE59IzW0lmwGLkW6KT8M62xk0Evxkc1kHggj7Dz4LbvQ/mnVEcBIAdN6RdRNhg+T1O1cHnanUflOaMwnATk+nUb6bB6u+4plGvZE521JQI520i7wQhAPJ5Ner4KeM+U7yz2M9lmnsy3moZcf9BJ0VZU12l9SWqgjX4VtkCkco03v6g41xGOo3Lb/EGU/a9qrKCPilBW8MsAuRT6Zg68Wnn2b
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(40470700004)(8936002)(8676002)(478600001)(54906003)(40480700001)(6916009)(82310400005)(316002)(70206006)(4326008)(44832011)(2906002)(70586007)(82740400003)(40460700003)(5660300002)(36860700001)(36756003)(356005)(81166007)(83380400001)(336012)(26005)(7696005)(41300700001)(2616005)(186003)(426003)(1076003)(16526019)(6666004)(47076005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:20.2261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec2f580-0f98-4c57-2960-08da90fc8162
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6291
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Leo Chen <sancchen@amd.com>, agustin.gutierrez@amd.com, Pavle
 Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <sancchen@amd.com>

[Why & How]
DIG_FIFO_READ_START_LEVEL should only be set to default value (7) by software.
Removed all instances of resetting the register to 0

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c  | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
index e3351ddc566c..06d8638db696 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
@@ -67,8 +67,7 @@ static void enc314_disable_fifo(struct stream_encoder *enc)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
-	REG_UPDATE_2(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, 0,
-		     DIG_FIFO_READ_START_LEVEL, 0);
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_ENABLE, 0);
 }
 
 static void enc314_dp_set_odm_combine(
-- 
2.34.1

