Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81097C46467
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jan 2023 03:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 004F710EA12;
	Fri, 20 Jan 2023 03:28:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F83C10EA12
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 03:28:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA8+l0iK3omzcx7ttLJa/2N9xYkXY8X/8ijxtQJ+8MiHArz+gnojn2QhQLyR/jjQt/GHxpI46hGhpam35NoBgESGfz0l+B2w3fwwiKYgcsFwpzTcBg80W6dt6+OFSLATfiIFANER1+t4ZdL0MErqZMZP40Wo0FmHrov9AFRxZF+12IfZJaiqy4i5Zj/VyWtV4NzfJHxjJTRRbSvGEclYRMR3/LiTW0FLfVJtKjU42cp0hleRur3j0tvs7gF4Nr5A2CahwViKj4WGJwileHb1YKtJ77U54g5RLl45xlgS7h27dqbkhJdoREktykKsj0TKoJzI8cjvJXlJCG7AjIXjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXBpwYBH3fwL35LG9SdKKUWDhsy2OFz4pfvRQSpXWSQ=;
 b=YWC9TbyaXiwsO7Vpiv/YWR+wVefkuhPffEnvYdPBko1DknT1ee8Jedt3A3rIrpIE5SpZg+cL8L+nDxPOKjCGIG0CMLu4k7/QaSimjjQ2O/QJjtXlVGIGkj8d1xWqpeVZWNnFW4ApBALb9qlK5r7xcNzu3plTNl2qD8Od9JGtR2G/ZPnVu/ObRyG6Z3iJlTGXO0Icq8RR6EOZw1J+0CunelrhfSKwajy6Z56KTbf/Ulx5VueMJgSPHaOqxaOK1nsIUF7mkNCrxV3YsCofucyOvR8P3WjBT8n4xlHckVU08KHDWcNkrP/xcpsHIjkYN/XQUSXtqhEfUNEuT+LpQn/3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXBpwYBH3fwL35LG9SdKKUWDhsy2OFz4pfvRQSpXWSQ=;
 b=4pQa+Hv73MCzSZoDGPKv5zYmh+60BGjIPfSmQtq485jVAMxvEN2soz4WVpuDvPPAhpUkg4xGfdgyBOOxiemngpxggbiu/6x2Sl8MHkjAROG4RSDuZKbC0sQR9oHRP6bBtiTqoFqdk7kOW4AgvW/pDuAeujaYgKSBlv/Akuf3sCE=
Received: from DM6PR07CA0068.namprd07.prod.outlook.com (2603:10b6:5:74::45) by
 DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Fri, 20 Jan 2023 03:28:54 +0000
Received: from DS1PEPF0000E65C.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::c6) by DM6PR07CA0068.outlook.office365.com
 (2603:10b6:5:74::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26 via Frontend
 Transport; Fri, 20 Jan 2023 03:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E65C.mail.protection.outlook.com (10.167.18.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Fri, 20 Jan 2023 03:28:54 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 21:28:50 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: add missing AllowIHInterrupt message mapping for
 SMU13.0.0
Date: Fri, 20 Jan 2023 11:28:25 +0800
Message-ID: <20230120032825.2094786-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E65C:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f3a19d-dab6-443e-97f5-08dafa967553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /uJs4z/5vwQZ+i6D+hR9eC73q3qECj6E6uY/fUuermdDPd86L5fhImGw8gYwA08o6tWB+kMhCqXkyJWcpXtgj4eA3jm6vC2MibJosvbAhe2DWBToQR+wPKtIM9TvXgxY4YDG3Oq5d6X3lcnFNAy77qVg6tlCEYII+SgpEqcRu4gL3V5qgA/pHVI2QdGMIXzlfTmicghBmf4tgkm025UN/fK3d44BioOYzo+5nQxmGrsJBAWKHJOQcZjsUrsAqCBc5a6+smkRywtzhRyypGyomqQk60vl88gJpVCkwUhfuAr4kLcyF6Qvu2HNtkpXFRxfnCugak6xdzCrAaK6VPP5vgD3G6MHMyirpmai65oH4hxWx9Y/GEUZAuCsWBzJWhX4X8dvIDxtoWpLhT4HTUOFzdqVNh7fCa+n4aV02ahKjswcGVwdPcUUbS44hwSleZPvBPuN2XUA2Mc/p+IpPxkd/17Lb6x/zNwJw5ULBYrNJAl3QAtu1LoTNZSs6zA6Dn4angYs5ikOu59PufJqNRGL3jKRfJY9tD6fE63evFo06n5DgxlFRuGJjVpCeBUJS2l8izR57klvyObiTwOHID1fdbQEDb798iE+zC+cWvPnT3U5hWO0O/xRqKqauH10eNhwWrmqngC4tz5y9PUDJ5ZgdkvYGPPpyN9Jy028R81qkpUIpm6DuAEIjJwKipOLg0oRTjCdLjpdxw1fAluFBF8EMtm+ho1sxU5/hQubFCaA3Vw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(86362001)(83380400001)(82310400005)(40460700003)(356005)(186003)(16526019)(54906003)(7696005)(36756003)(478600001)(40480700001)(81166007)(36860700001)(2616005)(70586007)(426003)(1076003)(47076005)(82740400003)(336012)(4744005)(15650500001)(44832011)(70206006)(8936002)(26005)(2906002)(6916009)(8676002)(6666004)(4326008)(316002)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 03:28:54.6016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f3a19d-dab6-443e-97f5-08dafa967553
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E65C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add SMU13.0.0 AllowIHInterrupt message mapping.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ief5f12215572a8029970e79814495e67d20f2388
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 3fded9d2c20a..5ab303760714 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -145,6 +145,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(SetBadMemoryPagesRetiredFlagsPerChannel,
 			    PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel,   0),
 	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
+	MSG_MAP(AllowIHHostInterrupt,		PPSMC_MSG_AllowIHHostInterrupt,       0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
-- 
2.34.1

