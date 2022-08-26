Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D1DECAAD5
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Aug 2022 02:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD6410EB7C;
	Sat, 27 Aug 2022 02:51:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A9CD10EB7E
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Aug 2022 02:51:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZakkyvxBHPupyUSqwT//gDipO0DQ7CyvdirrVLGI3Xy5vyAyd0uqoux4JMRU/dl53ETyOS0u4zpo2dKo07gqdamRKTJG6t3bvzCZ1RtYIrJsaRvaOH3PhTP9uaURsiaQs1SxO2xeMbS0qkGEAXQnx9NXPlHqdkLDhM/qEC+GJ+1LPzUhJQMUgl2HPkxeSrMdSh2kRQUAreVCwcHKU+vb3Mzo4+j0x/4bnVuaKrMeDktSezzeSEicxM6oNmXSCkoydfnodOY3ykWuyG62YxEPWGwgl5M8XuNBXZh/wFjkIF0drUfBGHBB5wSaCDfSsWkGqZOqRvITxC0sicAVFzOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaE7/FI+IVUYCBRqULSYDaIv+aWVhHRpK1Ukupm9ugk=;
 b=WvsftDEsIuRSOIWNrm6qCiPgrjUnzGqwIt0F7mI8UfHKfFPGEnaGhxO+TlfkjyY5uScKWvcbS6/rzDbL9YtJiDvTXtbXVdH9KpXvLnfaHY8lPG61UU3e6Uq0bjpqaKvV96HV7Ea9gUOB/YXDfES2NI98CAtQb+qv/Syi6UGpMJ896HoQblcRExmN30S2USUiovvAtrH8bKuzajiIk/EM3tIAwD1Z3Wk+z0DYYF6jJ949asXDn1DiC5g5917+LhHmTSny5WlkXl2uzHHYgqqNEBa5ErK9xFwWKwFhy/FylqYULFS+Hqr1jYkr7CDDhBVn4hbNTI3lR2eIww6dethD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaE7/FI+IVUYCBRqULSYDaIv+aWVhHRpK1Ukupm9ugk=;
 b=h7aT+mbP06m32yrRo1CnYHPzS3GZhZxleoiiOR8i4clKJLw+j6HKhPxXUclT/lRbJ5RKOmjhvH5i2c9AddJtzpW0Qex8oPbdqfqUfB0yV7HUz4BhKveX1fUcdEqwOHVWHfrJzfRWklefCXn5iNVfey7/d6V2dk1VV6qpv41eoAw=
Received: from CY5PR22CA0075.namprd22.prod.outlook.com (2603:10b6:930:80::18)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sat, 27 Aug
 2022 02:51:38 +0000
Received: from CY4PEPF0000B8E9.namprd05.prod.outlook.com
 (2603:10b6:930:80:cafe::3f) by CY5PR22CA0075.outlook.office365.com
 (2603:10b6:930:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Sat, 27 Aug 2022 02:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000B8E9.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Sat, 27 Aug 2022 02:51:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:51:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 21:51:37 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 26 Aug 2022 21:51:34
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/33] drm/amd/display: Missing HPO instance added
Date: Sat, 27 Aug 2022 06:50:39 +0800
Message-ID: <20220826225053.1435588-20-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826225053.1435588-1-Brian.Chang@amd.com>
References: <20220826225053.1435588-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f14cc62-b488-4092-914c-08da87d7105b
X-MS-TrafficTypeDiagnostic: SN7PR12MB6766:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NA1Uvsp6lbRB2/E7cmhMvWnFxQgWy6fdsI38UWt39tiIH4xdYXLoM7jTc2Sd/SyEty3ZCEO9MANOEqkxyCppJPHvROWbFT3vUmNxLNoKpFTPEix45sw+tpB9MY30YU2W2Mv+TN5fS7uclsA6DilhCt1jgmGawOcEOLtLRwlquV/zZ6ch6QiRhfPlMYxf/olROxFNA0Cj6M+npe7U0PH1S2KEWv28taWPOFGXFmMyoziyAgOqiot6joGLFSDuZUhQ7dNaFn8tUTFbDwPKWRujQP4/rPjV+U/ov8dhbiI6mEvdHYm/JYsnqUPXbZp3XO0C+ZCmT+cXfk0vxbN7euaxa3nwjJWmZEOweNBucsHaMJveXuvV7QnHbvLOtsq2yf576zjpohnHjku1sUU9OK0B0wcPWkCz7SRl4MW63MpuvtmufOwfXcpX+B/dMtNSk9nw8HZZ3pRwmjwz8DLyAuKRvQU9WKr1egVjXj6fbn3VVQJJOZ2D79v30dbZY0S93lheCdRv/Z7iSScWWa7ctdBnY1ngpqkzxmNEBMCyYnPYjRkDC56Eg8fL4vxS99Rfn9uc37KIF84rziW7yqvdmHnWuFgxc719xyvsJVpjn6IhtreDUt2i6UIIDss6dMBtEvv5Dz880trcK+mHYmNFRAOOwVt6PIdlB41nVdzei8ZkdR45kAz+22cXXFdI4s2X4LrQ1H+1IcP3UW/2vpwwaUD//kiOVAU9oE2CpvcJcMlF38D3WTtufN1/iHpQQGfpJY2GgXW3o7fpilpfr9ve7JdOLTQIMCHIoQoK/fDCGLzRuhiE9OTZMSXO2U5CA+2lYc0vO+YR1s7VnaaJeh64/W2YVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(40470700004)(46966006)(36840700001)(426003)(336012)(7696005)(36756003)(2616005)(82740400003)(81166007)(356005)(26005)(86362001)(47076005)(1076003)(478600001)(186003)(41300700001)(40460700003)(40480700001)(70206006)(6916009)(54906003)(2906002)(8676002)(70586007)(316002)(5660300002)(36860700001)(4744005)(82310400005)(8936002)(4326008)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 02:51:38.7251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f14cc62-b488-4092-914c-08da87d7105b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Leo Chen <sancchen@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Chen <sancchen@amd.com>

[Why & How]
Number of encoder is set to 4 but only 3 instances are created.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Leo Chen <sancchen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 5e62527d3ab9..e7f0c7d412e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -454,6 +454,7 @@ static const struct dcn31_hpo_dp_stream_encoder_registers hpo_dp_stream_enc_regs
 	hpo_dp_stream_encoder_reg_list(0),
 	hpo_dp_stream_encoder_reg_list(1),
 	hpo_dp_stream_encoder_reg_list(2),
+	hpo_dp_stream_encoder_reg_list(3)
 };
 
 static const struct dcn31_hpo_dp_stream_encoder_shift hpo_dp_se_shift = {
-- 
2.25.1

