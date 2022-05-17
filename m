Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D6AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 02:06:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CF4310E294;
	Tue, 17 May 2022 02:06:56 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA39F10E198
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 02:06:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJ3jHVaN9arom2Z8BoV5m7EsW02ILP9kPzhV1SxJX2M+YnyNzjSI77ugU1HmxUubI7WrHn7m7f7Dof0SPo6hpQ2fhDVFUjEOCwN1w1K+wKEwTJ+8eqwWPTn2hKZU0RFGMuZxIZDsArF249YOqbvcUuU5d0vIbK0vwvPEfbaqB9tBUM7GbeNLafjPKStDOJa+n4LXpnqgyYpoPe2U/Frr/JFJHMWEHoQHEfFT9lyGMBr3hG7fvaqRQ1mNoQG7/E0KRYavCZGyBWwRAOtjcRoaVgFH5SAV6nz1XinY3Tr6/5+ihNhjy4fkl+wbYgvNldyWfr/YZmCuroatYJFjbu2Qww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caBG9Y0IafHaSx6vAYLC7uEv7kpoOgfraa6nwXql6vE=;
 b=ffDflvCEVFHraY5F8MQKrje5QdP6nN+XWx3AqXtvxqMkIcBorlMjBuRFY7inzH5oIx5LrqHH/IgcY8phOL/csu+gfCQTBaIOqQKjuYz9c3GMkGIXI9NrpH9vKIg9Nltiv+0W6Tv1hL0Y/0Lo244LxNGKd1aXQTr4HWKT8jGwBpc+9bQaWffhcaoT/ZF0L2bWqAZrTqA/QUdZ7VC3tKKNSIWzbkB7CRwDPKLomXEbpUEobmo99v0uLrkkCQd5xBlKSgKKTsoJ4gnV028e9i00ESOgoVhsTRFz3/ewlj1gGC3ZfFzeiwmo55qZCZatD3c3tocVMyAY7ezbtiA2f/oQzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caBG9Y0IafHaSx6vAYLC7uEv7kpoOgfraa6nwXql6vE=;
 b=42wS8h5IU+nOxv96zOpoCCOi0Os85T8WossKJP403C67OhtH4rZqltQCBKUHugBI4dsRQtCYhakbhOAU8FxY6AUz2/o00GmNHXIWxwr36tHV1lHA63A6nn/j2zJvJxyFeV5lBOMMEwGlm05MU9Fl6YYEKlYUbdRYGjh9CeuDNk0=
Received: from MW4PR04CA0113.namprd04.prod.outlook.com (2603:10b6:303:83::28)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 02:06:52 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::4d) by MW4PR04CA0113.outlook.office365.com
 (2603:10b6:303:83::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15 via Frontend
 Transport; Tue, 17 May 2022 02:06:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 02:06:52 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 21:06:50 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amd/pm: enable more dpm features for SMU 13.0.0
Date: Tue, 17 May 2022 10:06:01 +0800
Message-ID: <20220517020602.160108-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220517020602.160108-1-evan.quan@amd.com>
References: <20220517020602.160108-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cc04901-6d89-4925-4ce0-08da37a9e928
X-MS-TrafficTypeDiagnostic: MN0PR12MB5908:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5908B06FA5BD1382EA0A9C04E4CE9@MN0PR12MB5908.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FlxEEc2OhqJI8GXJqelBbcl3z7Iu+u8Y8V7gMPzQLpCuqAVPgu2wDWG8Er+SJYdpnKzpbQ/MX4j/oGULl36jEhbVoboH1L4Q+/t/wjUPugIz+n5d+DcfrfxRBJuQN+kHi3ICsUSTnCguUXIR0RRZ+PWp9nR28dsa8L9gs13QgLqkp4uI0IM2xhnCniCZVez5xgWEj71gy00kGGpsTFU8ZzkqIg9cDHa1YqgpOQABX8FMaQDQ8QI/yFJVLw/VZ2ei1fW9wBR9kiSOm8P8Yth91+dHShH3GHBOSV6C19Ltk27VxCZ0kPCDkZsrTTZ/QzFDhH4w4L5Dx3tx3PRtgDyodFPHCebV4cz9Es9YYYCZnpMnhu/WPNJDKxa8jcyYn1+ngoFvBFBd0T7l5sOZ3odyTVDroJTtcSA9hODp2b0UPYYSJVYVFO2ClzX4s4CrhcQqiE/ymqj/XI2GKhyZ9enuXZJcXscRsQNCTbmAVWCtv8w0FBZsJDZmOesKX1x1IO1SNJXJ8ndHKdU9O7OllL9+yQt8Pb/1IegeSqUBMTyEAgDSWuCqplYtszasukOEybZT4P4kASoSXNo6h3nn7OdSUvo1mvDHoaYHMna1y/azhIgPdT6O4SP00z1kCqiNNC7IDGdL1dh2y8J1xwKFe88QXofpQ5PbTKUalUbkTXiGBUoPP7JdJztoqpOdxIj3ukEemAXcRzHpkMTz4v49rgEVwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(8676002)(2616005)(4326008)(82310400005)(5660300002)(44832011)(186003)(426003)(336012)(70206006)(70586007)(1076003)(2906002)(36756003)(6916009)(40460700003)(508600001)(356005)(316002)(47076005)(16526019)(86362001)(7696005)(6666004)(54906003)(36860700001)(8936002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 02:06:52.5204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc04901-6d89-4925-4ce0-08da37a9e928
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable OOB Monitor and SOC CG which are ready since 78.38.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Change-Id: I0d7334106917ac83fff2b673ec7e9eb096089afe
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 7bfceca246ae..7bb2923eb819 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -299,6 +299,9 @@ smu_v13_0_0_get_allowed_feature_mask(struct smu_context *smu,
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FW_DSTATE_BIT);
 
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_OUT_OF_BAND_MONITOR_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_SOC_CG_BIT);
+
 	return 0;
 }
 
-- 
2.29.0

