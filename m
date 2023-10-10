Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECDFCD68ED
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 05:50:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C48110E1A8;
	Tue, 10 Oct 2023 05:50:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC19910E1A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 05:50:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E94QYFgi/ViQ4deXRI4b8bcyeQhB4gOY6hk+xYhbmgwNYSMgTO1Yphcl6GN05Clojr6jNWjrFrpZ+4R9dMk/dl1PPuHbeZOf5XmquxibCyF7XCu6/wU6gCZjQWYAnXy4un7v1Jr4ouMJRGK9caoe5lVi6mGrU1sGxI+SRehsrD5+oQnvv4V2KkBx5piobSjqr82INercCNb05RC/M5TgfpWtqVjeedf0plvTWrsiEXOvWx+VEITElZCLDqE5BUJdH0LYwK7XLX8Rh3BdJNT+dU9GHT1bfz1kShZmU1SYzLlhRRkENJop1JxqQ72QFo4u5QJzOxwL+vwL6S7zU4JIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NewJt3/Fw5coLMdDssXTqgLl4Rb7ttWJq2yqIGZAiDo=;
 b=CIwnrHVcIZ9wCQxufuuvSXbhYkMYCi3I7Ubswln316YWq9EbSF52x8RJyYHyla5gSCTGYYxQF3OvczewbBtUrkH6j/mZbvPz8OG62a5/2ywalumeriE8lm8/AxqoLDqr+H+7p9F1EYpmYEkeiuQ8zSWz/kLWUlEv7833s/CiWKeng2yJDjTslGQyJ28M09qJecdKxa2dOVFrdorbA2Y4iEOQn6Ixivf4clnW7i6U+oB3GOMgkraoCIP2cPI0q+LzMkhCn0Ja8HSbCRutqan9mwDgPWik7/Tv958sDSs0U6rNmi847S8bIu6+a9+2zRp0xXv2Rhxs2mgWJIbjHQpMIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NewJt3/Fw5coLMdDssXTqgLl4Rb7ttWJq2yqIGZAiDo=;
 b=Zs7AXX51gZHUCQ5j3aESR/NB7ZezxbcdAav3ZRm0E2tWwLVarK+D9CRFFMmPhjPvsHTTb0mFTnTabD/Rxj943hQiKDocC/+EVGQ+ODQnS0R3c1GacXQqM+3BCss9lq2jQy8NCSt0v9XHJU55ioRdWvcZwm9N2p311is3yslp3f4=
Received: from SJ0PR05CA0096.namprd05.prod.outlook.com (2603:10b6:a03:334::11)
 by CH3PR12MB9314.namprd12.prod.outlook.com (2603:10b6:610:1c5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 05:49:58 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::6e) by SJ0PR05CA0096.outlook.office365.com
 (2603:10b6:a03:334::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.23 via Frontend
 Transport; Tue, 10 Oct 2023 05:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 05:49:57 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 00:49:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 22:49:56 -0700
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 10 Oct 2023 00:49:54 -0500
From: Bob Zhou <bob.zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Qingqing.Zhuo@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: add missing NULL check for DML2
Date: Tue, 10 Oct 2023 13:49:53 +0800
Message-ID: <20231010054953.20156-1-bob.zhou@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|CH3PR12MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 66518385-cde9-425f-fca9-08dbc954bc25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDcMl4g//c+vzAp355zRtVfj4sUXHzc6Tlcs2I39EA/O/te++8ayJOb7veP2b57ytIidVbEB+cnkziKTMQtNICwobOjmh3qW7u7F9ugBQMYk5G/AfIF7TkbLTVfb24vDxGE7XOszIDWgiDL0apURigC2VlyO02+65j2aiRAQaK57LxfatQbz9+SGtJJugXOLj2A1PvEc77MMOlSfugvKFTD092rFm3IMbbQUy5Sjia6v283r1DaP0Xrty7XQoD3ZR6AmYMc3h9j0ejFk7omYJvBRiCnqXS5jCiywvs1/sLx8ahwcI/m6RLJDReMuJbK0TLrApnvfbY54zYA7DIHJgO56sUscCp1WIIElZBamDQJ/nrIp89d2rkh/wxi4covD3vWJ+V8iRWOjuc8vJ1HknUeNxmitrfSNOqzYKuC5BtlAtNCyDSt73SQ6XeN7rdMbzqDEGEWQzF3J8fbHJt3KXWiD6wzjAOUYT3m3sOReCjzYNvkMreY8VE5MOaR/wk1jGqciBgZa6o0dpozPSr3QXKWGVi+tf+gL7m7XDq1yVcijy75S4/1xPqI2hUOAYyF4k91PjA01w56OiEIhZx8PYUg1qindVqIPuJxuIQFvR+NpyFelkvmYAVwhQe4QAYaCcqL7r+uzf18G06eocX6iyODH0rSo4wMleo33fUhC707ohweLI8eGT9lYsw+7fzpuFbIw4BJ4zGDAziSEzd7D7hWw28ZHrbaoDfoxpPkbdZZ1Xii6/TmcuFbZ6Ra0Ri9CSn37DDYTwE97PxA7Zf6K/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(110136005)(316002)(70586007)(70206006)(6636002)(54906003)(41300700001)(44832011)(5660300002)(8676002)(8936002)(4326008)(40460700003)(36860700001)(1076003)(2616005)(86362001)(83380400001)(7696005)(81166007)(2906002)(40480700001)(82740400003)(356005)(36756003)(426003)(336012)(26005)(478600001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 05:49:57.2692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66518385-cde9-425f-fca9-08dbc954bc25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9314
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
Cc: Bob Zhou <bob.zhou@amd.com>, Jun.Ma2@amd.com, feifei.xu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Recently, the driver introduce DML2 for future ASIC support.
But, some ASIC's hubbub pointer is null before calling.
It cause the below null pointer issue, so add null check to fix it.

BUG: kernel NULL pointer dereference, address: 0000000000000000
RIP: 0010:dc_create_resource_pool+0xc1/0x2c0 [amdgpu] Call Trace:
 <TASK>
 ? show_regs.cold+0x1a/0x1f
 ? __die_body+0x20/0x70
 ? __die+0x2b/0x37
 ? page_fault_oops+0x136/0x2c0
 ? do_user_addr_fault+0x303/0x660
 ? exc_page_fault+0x77/0x170
 ? asm_exc_page_fault+0x27/0x30
 ? dc_create_resource_pool+0xc1/0x2c0 [amdgpu]  ? dc_create_resource_pool+0x243/0x2c0 [amdgpu]
 dc_create+0x23f/0x6b0 [amdgpu]
 ? dmi_matches+0xa3/0x200
 amdgpu_dm_init+0x2bd/0x22a0 [amdgpu]

Fixes: a2815ada8616 ("drm/amd/display: Introduce DML2")

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 25562b262555..d20e01226353 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -321,7 +321,7 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 				res_pool->ref_clocks.xtalin_clock_inKhz;
 			res_pool->ref_clocks.dchub_ref_clock_inKhz =
 				res_pool->ref_clocks.xtalin_clock_inKhz;
-			if ((res_pool->hubbub->funcs->get_dchub_ref_freq))
+			if (res_pool->hubbub && res_pool->hubbub->funcs->get_dchub_ref_freq)
 				res_pool->hubbub->funcs->get_dchub_ref_freq(res_pool->hubbub,
 					res_pool->ref_clocks.dccg_ref_clock_inKhz,
 					&res_pool->ref_clocks.dchub_ref_clock_inKhz);
-- 
2.34.1

