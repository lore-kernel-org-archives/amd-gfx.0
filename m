Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6993C47E49
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 17:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54D5410E3AF;
	Wed, 24 Jan 2024 17:09:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9E1910E3AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 17:09:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IudkBKAfqo6ZqpbtnirShc3e8CztYjiaa3TGF6myrLLiU0DaRmC8N0c3IjCR/2avkIlLtZG1DKudaT7quHLd0Tmo3VtAYSaRV9NY3R8zzZiUlRfWQTdwH8fQaL5HMOiNsWGZcF+N2Sf8EPAqDMYr0HbzOng31+K8QewA5QY+4KDHp/5/RDcTreWMs5LYf5d/xD71jbHshlFJPJZI387HA/psnyc8WPPDttylqj9KbrJ2ioDzID9hosR2Zn+ByTwiJgA987LqoNWelhcuCSG28A69WRRpKKEGbzc/NkzQ435/Ip4PdDhf/ncSKVdmh+JkCsRkHbyJMj5wpHrYEi2luA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa0g7VjE7zQY/w7vTj8qvDXZAz+n6/BM13dYhbcztDM=;
 b=L+JMIZwgDSK4cMAAfyDpQ6RREAewAa3qjp+gO9xRKZyT6bGUC5r22WTvH3lsNcCAdVu1mRxAEK4up6lHVmtjXKJquMZgj5rrWwwSnK3hCxxtxWqp1+K7RQP8Y7M0keTToXrpmx4fUNaExG3ZMj3p+lQnYTqQNA8l7SdoGZ+W+0t+l4Uqpe9R9LAJEkQPgvUPZXHRxnr2nE4w1GFNq+6V/dWaWe+4cbYlb0+WMwrOA/8D5nqFW6hs0alsaOvAJNntmV9snwGHpfToBvgjpSUYSeDnBYJm6mzpzO296sM7hWty5p9oOwO6uCXKg9J6oX3Nw0X183aTf4cZl82aMu8SXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa0g7VjE7zQY/w7vTj8qvDXZAz+n6/BM13dYhbcztDM=;
 b=wqfrP8iwaHcU016u+UQ037VJr/WAljFUn9a7Tu59t9zGk0xVShrIoyb0RcryYhIjAZhkax+YcsiWJX0tCqYN5IurruvMALUBQlXruLkmpZiy0LlJps3FIdUwki+aXBFNH4a0dO4wszFjgiJ4uldw6Y0hpn0DPmttu/CUzix74AI=
Received: from BYAPR06CA0044.namprd06.prod.outlook.com (2603:10b6:a03:14b::21)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 17:09:21 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::ce) by BYAPR06CA0044.outlook.office365.com
 (2603:10b6:a03:14b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.38 via Frontend
 Transport; Wed, 24 Jan 2024 17:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 17:09:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 11:09:19 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 11:09:19 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <mario.limonciello@amd.com>, <Aurabindo.Pillai@amd.com>, <li.ma@amd.com>
Subject: [PATCH 3/3] drm/amd/display: "Enable IPS by default"
Date: Wed, 24 Jan 2024 12:09:06 -0500
Message-ID: <20240124170906.901841-3-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124170906.901841-1-Roman.Li@amd.com>
References: <20240124170906.901841-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 32744cb4-940b-41a6-ad15-08dc1cff350b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tEVGhqQTSmb2NVbis+rNw3/45cbvkCfLpB6dpd3u4WFFxQ/i3UXQghLkDkigPtTSubK+XMVV/rWy2bzNC0AP8oJIw9FnldRyJ/0OZFL4mXrf3a0j5uwpYC3Tzmg6CKFzsy/W8BtMiTg1pIkOp2LoUM4aY3LGgXw8x7Y9pWnthQJhdYDZ6yYjo72JWiAjc/S/t4qJIST6Hl1XYOt5iud81ZiMgH5M/NRqq40V3boDtrEidZF2UFgcO6JBnTExadZA+EX32GOgJ8B6zy7DPzpqldpmpqi1FbQprGwfczGWT6OPxa2bjt+E1gWDveJrbG3iOnRU4WJA1IW+lUz2hDbCzNEqUqoUWTpksE1as8GQtiNknI85D2JASq0f0v3y09onog3TT0KQodyl1a4BCZbPA5XnnEdPIqql7aPF4tgEPw7XKlQvo9L7TFyluk9UE91jCTx9FiQYpByvOz5bl4jhHRRT1c39AcrfXU1/SvnE8fpU4lloDdp1GTti0eu/z99EkyVPg2Q9p99WKbQ52jEkhO+aaoIWKs2v/3PgjEkKNSohS9Di9G7c+qfKJEOmOijZ9EmUnu7vumNY4xwhVJb/7a8d5vSP9LJiZ1xzh9XPVSzEbggjenVyJzs0eRp9JwkFkzIE9rUujfOVWxflLVwEn18cxNDtXTLZFsLwzRPpUQdB+aCBnHwZNCWe46yCXHrSHirJcRCuJjmDBoTcEA6YHUGem4fWChYItBtUtzs7Ln1E9gUWThA//NlWd/e4+TccMqssmPLYwwZE7ZT4cC70eR+c9Kko7De4HqIkjatVxbY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(82310400011)(451199024)(64100799003)(1800799012)(186009)(40470700004)(46966006)(36840700001)(6666004)(70206006)(7696005)(478600001)(8676002)(54906003)(70586007)(316002)(110136005)(8936002)(47076005)(36860700001)(26005)(1076003)(426003)(2616005)(336012)(83380400001)(2906002)(5660300002)(6636002)(2876002)(4326008)(41300700001)(36756003)(356005)(81166007)(82740400003)(86362001)(40460700003)(40480700001)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:09:21.0557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32744cb4-940b-41a6-ad15-08dc1cff350b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149
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
Cc: Mark Broadworth <mark.broadworth@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 jerry.zuo@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
IPS was temporary disabled due to instability.
It was fixed in dmub firmware and with:
- "drm/amd/display: Add IPS checks before dcn register access"
- "drm/amd/display: Disable ips before dc interrupt setting"

[How]
Enable IPS by default.
Disable IPS if 0x800 bit set in amdgpu.dcdebugmask module params

Signed-off-by: Roman Li <Roman.Li@amd.com>
Tested-by: Mark Broadworth <mark.broadworth@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 41994a60e2cd..9d909c09a14f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1719,7 +1719,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	init_data.nbio_reg_offsets = adev->reg_offset[NBIO_HWIP][0];
 	init_data.clk_reg_offsets = adev->reg_offset[CLK_HWIP][0];
 
-	init_data.flags.disable_ips = DMUB_IPS_DISABLE_ALL;
+        if (amdgpu_dc_debug_mask & DC_DISABLE_IPS)
+		init_data.flags.disable_ips = DMUB_IPS_DISABLE_ALL;
 
 	init_data.flags.disable_ips_in_vpb = 1;
 
-- 
2.34.1

