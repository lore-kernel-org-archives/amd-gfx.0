Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8339C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF001113AB0;
	Fri, 10 Jun 2022 20:53:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3BE2112C65
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2nKHo5n+CFUWGPC0p7VrkU4/WCFCj5/Rf0beMOIw3jqefAvOq/TfGtk2hGm2u+ibgMv+ED8TJ7upKYI4GI9luYQI8KjhIE02FL3q34mNGX/vka7TVVNi4DXWSQPD9S0+3nSr2PHwNNHvavC31wU5hUFvebPhw1MyE0MjsrQnnA51vWGwUywXAKJG8IzNYZ81sXIIeVdldVshQSgFpNpCqLzQsffp6IUUgCHEh4FfHa+1at26FLTnxoeRy6KpRxtL1z/npbHpS7csw/PYD3YpWhIOXyiT/MhKQ6BK7T8yapaPbRtuy76vHbNp8nyDd70jEPRT1tSd+8q5IEFdP6XNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UZcXz6dap+1oUteKDqJ6A6nNIC+a3RCuKOdUVG3DSs=;
 b=O8vA2fKgf64KCdWIIozKgQjYzE521xMo6z+eXdDQS21KIOOKXP8/YKFmSjiXZ2JFt6+rRt5Nbw0Y04l7zliYlh0zgKM6xHb5qnIrblx4ymt7xY+jnBpLl02ZSUjOF8aX8+BJ38MH2WEKdoqd0eQpYgr2GY9qLtzhRvRhY3DEA5EQTsthM5jZEge2q+TEkMcH7rIUEVk/huGRVTRV7/pkB9/lH8sWA9auMbkcO/kSciYbMnmktXnw1jDPvI5I4LdyEeR2sJzcRlNDskBRmwg0YPeR5oQXFz2zpGdgTdtyhjJSlhXY+Ls/SQPU3FeF6OD3LZDMFGs5sUZQJm5262gKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UZcXz6dap+1oUteKDqJ6A6nNIC+a3RCuKOdUVG3DSs=;
 b=vaS5Slu/A1PPPE4FtQscfZxXzKiargkzXh6jG9uOA5nAr8ipuaUC6aOKN87tC77zbgZCQyoT7g+JdUopgI63EBc8cZK1gqoJPVbDY4gtzRulpxx+/1bSjPmRM6KGgcFDP93crMNgpaHCGIcAnCKjCspIpJepd+iLTv2EwXHhr8A=
Received: from MW4PR02CA0019.namprd02.prod.outlook.com (2603:10b6:303:16d::23)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 20:53:41 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::ad) by MW4PR02CA0019.outlook.office365.com
 (2603:10b6:303:16d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:40 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:35 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/23] drm/amd/display: Pass vrr mode to dcn
Date: Fri, 10 Jun 2022 16:52:41 -0400
Message-ID: <20220610205245.174802-20-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7346564-2c5c-4e8a-1223-08da4b234cc4
X-MS-TrafficTypeDiagnostic: DS0PR12MB6414:EE_
X-Microsoft-Antispam-PRVS: <DS0PR12MB6414708FFC659ECCC30C35D7F4A69@DS0PR12MB6414.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LffCnB4u0dOIOK9FHQYxVJfWGgY4mEojXJ+PkT0CGSHND48IR3BrYTHXUHlxV69wLCJGg2ZL1/gNQDqLJ46UZGUWhvp7j0DO9OpFXA4BQPTqIH0fQON3zu0EK7gabTZ/l0DX6ZJixcA5gIHMk4Kb8SrH5V0HvtYaBGrKRlUotdNKV5M5vg3tPOImo+qPKdS8vjtRp5akYAekK4ir1pQn7o49CQoaWnsOlgluP0vGV1I6OouBJhZH++Ya7UoYrCRLidKxtuyoLSw64r30Az+WW5ixseJ1e+Nez9tYkrhMa/dNobWazEJPfAaV16rfPFvCn5pet13Ry19giFd2y+p0vl6lDBmLLqi2BTRDTcRm8cZ/0hL873/8ZYeh1BGLPJv49DUwWDL3rlCSr0fm3gq7iYPaiLZt7ZefKpW36YuTNuVrpXWBhWsrVtUWWQxDNBxetAxVWVKLZMDCLm49DhpOJ4pnl4YEG23XFuMl66Xm1wCtwANs06d8VtQ7iU1FlS2bcoFTjbWF4VS74yCJtWt0iVA5kFhsGtOUZp8gn2Gd7O7EpfjANja+VMFQTzbP4x+JTEZwtw1aXSXHCL+WM6m4Tmwab8Dkghx3ab3AhN6rxHEkATA72LHB+PRNpxWHrbI/5ATFSEu3Pdz/DrkDg521LQOjnN/xdqo3yA2SsFai+5TTa9lqplarHvILgtLP6PAWKK26/890Oe2AtHVbnRaTtCDJePS+I2IQFCcEuw+QDiYpoUJDXSkN6QtCLEgpHDoX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(6916009)(8936002)(2906002)(44832011)(70586007)(70206006)(316002)(54906003)(6666004)(4744005)(5660300002)(8676002)(4326008)(508600001)(7696005)(82310400005)(36756003)(86362001)(26005)(2616005)(356005)(47076005)(336012)(36860700001)(426003)(81166007)(40460700003)(16526019)(186003)(1076003)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:40.8328 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7346564-2c5c-4e8a-1223-08da4b234cc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414
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
Cc: stylon.wang@amd.com, Felipe <Felipe.Clark@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Alan Liu <HaoPing.Liu@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Felipe <Felipe.Clark@amd.com>

[WHY]
New features will require knowing the vrr mode for their enablement.

[HOW]
Pass the state via a member of dc_stream.

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Felipe Clark <Felipe.Clark@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_stream.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index c76fac3c153d..ae9382ce82d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -208,6 +208,7 @@ struct dc_stream_state {
 	bool ignore_msa_timing_param;
 
 	bool allow_freesync;
+	bool vrr_active_variable;
 	bool freesync_on_desktop;
 
 	bool converter_disable_audio;
-- 
2.36.1

