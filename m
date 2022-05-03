Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A4DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8801910F488;
	Tue,  3 May 2022 20:37:46 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 445C510F475
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7/BBU1jfArgZ5D51hglk57DXM7IyMP4yCM+pFxpLit0YJdecR3KehdJO4qM49Njqzdso/nn04ic8CHWq69JnBwKNxb5sogNEjkws+v2KEr4i3AbV6pbNSAJqJjiSco08WJY9hT1VrUm/zmG/xazcK5YrV3JcmxK9FgQupBEfRknAPmNvLnOV/dyhjGW6TAe9lO18zDLE9zSUe+K/VMnLg4lw1hLY+Qy7FL9+8jgWX/m845HfFcppe2Zd82WaAAj/ciA1LDsvwL0pOj43WcaqrlOkdMgBvtDCMAQbuwqkQwFjnF+qA+TXXMwCKeAUdkVEAoHnmglz+eCMb4v6U2GUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhUveYEjYjYV0tnLy7VY+gaW6wzZYct5VCLlr8zgcJ0=;
 b=MDoBhbX56/8l8W3Q9lPQysNFvoljMPAiKRPGnIP8VvnmH3R2FTmcLL+ee62GbqnQVJcTgGwcdY9tN51pMWrI17cY1V80CHVlP9pZvhLKKzNifVXjOhzbxDJfuPOjAfVaA5XXnwzhd8IEdtu5OEGGoY8AMgJ9qgTNwDfpm5DQWX6WpibfzqgnOJtV1xv2cnMZPC7iwoTqkZJkY0DQFkyJAiZ6Mxh5GqKiK3pNSoCbA8xkE984f2O354dciEWxpr0uOhADSBtHEBONHtrkqETJjK2k+ZTyNGPDjFYkne3JQ25od2KE6s/qsQGH8snfQsRMMFd1kDoNr9zEeYobiVMr1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhUveYEjYjYV0tnLy7VY+gaW6wzZYct5VCLlr8zgcJ0=;
 b=afEE5rDSaBbv286M7c+Rww2h1woZIfT4I9iFK6BjClxD0oEM0JW0/DuWR87ENKv23TuFW9sRvlcuiypsVSxHHOMLnn7Gw1mW6Uu1toV1R1R6sEdM+dTG6GQSgIpT37ojtf6EimSQwksxBK9O1drc7MT2uBTiWX0pAjoomjYXbac=
Received: from MW4PR04CA0146.namprd04.prod.outlook.com (2603:10b6:303:84::31)
 by DM5PR12MB1867.namprd12.prod.outlook.com (2603:10b6:3:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:37:43 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::6f) by MW4PR04CA0146.outlook.office365.com
 (2603:10b6:303:84::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 20:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:37:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/26] drm/amd/pm: enable gfx pcc and soc cg on smu_v13_0_7
Date: Tue, 3 May 2022 16:37:11 -0400
Message-ID: <20220503203716.1230313-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc82a320-cc8b-43eb-ff1d-08da2d44c601
X-MS-TrafficTypeDiagnostic: DM5PR12MB1867:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1867A2A780E59D916A817967F7C09@DM5PR12MB1867.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iQKy5HEGbq8SOaY9MbTXeL19moZhpztm6jtacAqROXCOiiPf18fwl38AZJH1ZiXwpiiD71nhDZtNLD/tpI056AyJKhaoHZv1no587S6KEOTdg2L7kZVYQtjmo9jLQI3BNqcIsHIAIAqCnJB8wUDQMRvBlAdgA4IfX30TdiDha3ZRKzzEvmv9rk7d8SX8URwvWn1Q9YMJWxgq7LuSx4uMz6pfvuEjle33GtDEkqH1Yjlh62ZeUOJz2Cd2t2x/rRccnx3TGG/mUQGQOYiASuXIbPMnOnzuVW762lst5S5E9zgDfQMSkBLybSaYDnSFgz1hOANOIbbg4yZgOP/F6BALSKOS6QGYFYmPoi4ke4wbOldlvJDiddTZIutzRmNamo8Q9LBuEXRNph9aS7vBC4IbZ4Ke/qlFg2eUKDIJp75vwOAvtGTNXlpCp55EJgb9IapkFF07eJDf/trkrmeL5Rty5sQ65QSXtue/i6xQT3rb35lmc7ra11OE7YPakAbx+xkCdKUX9SPo2lhzsqgxagpXLCmA3HmasZfNTtbNafPyuIOODCRiCS6aSWoSQzOYdysqp6JOTrLwSgmCcwYiCM9iIP6FamnPpQUogbqwaaxlpcJNDbNsw4mE6tKLnAVv7FY/zJqdnEFejG6STOJiZ7Kn6iVdNV68vyZE8/FiqQQqaU+pzziHfBrOo3nR4n+DdosTMn98EtI/MAr9fHEpSG5RHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(2616005)(16526019)(1076003)(426003)(47076005)(40460700003)(186003)(2906002)(336012)(26005)(8936002)(5660300002)(7696005)(81166007)(6666004)(356005)(70206006)(508600001)(36860700001)(86362001)(4326008)(8676002)(70586007)(6916009)(54906003)(316002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:42.7517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc82a320-cc8b-43eb-ff1d-08da2d44c601
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1867
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

enable gfx pcc and soc cg on smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 45c0ba4a30e3..59f0eee1a1c3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -235,6 +235,8 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_FW_DSTATE_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_SOC_MPCLK_DS_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_BACO_MPCLK_DS_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_PCC_DFLL_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_SOC_CG_BIT);
 
 	if (adev->pm.pp_feature & PP_DCEFCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCN_BIT);
-- 
2.35.1

