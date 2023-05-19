Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE87C77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 07:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C99B10E5E2;
	Fri, 19 May 2023 07:53:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D57C10E5DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 07:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j77bZquovB0ifsMmBNH7zM0lzlqaZ7mhZokF35DuQZlcvBwpZFrxevKmX9XrbIUqBtYHTol1we9fg4UiK5IhmmNUinNsXFxKiA4HHriVBMq4lH6YdaJdaWeNyP3EsfY6j4vFmrRQYrByJX0zxLIYGLX9+85OQFG+LSI1dncrGRBOvsFM9cQeh2FrF0mbtWtXGFtRC5Vhtgj+EMtl3vAUz7yCT4TW+sPmR6VvPhQPhvT0bIPHSa1vkV/VULg/Y4MjjNt3nOXFPvTR7X6Eu4dJzoTjxDjhtWp/D5Fv9aJyHvTP02qNT8O84BXeNAmHJmjDTPkPH38e1ikhuT+Ky/DIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BsIFhmR1CCiNa2CwpMWRv1IHoOdGOau+uvuu9gdKFM=;
 b=nVuqM9QrMAG+S2R+p1QjZQC5ibg4zcNjAuF+eQzz/9REAGetm2yWhMJqkQxf3q6vwTdoBgqP6Os3NZJPZikXp2kILJAumbXKhkVpPFgTUeFiagl/63sO0DNUXz8ETJcbMcMRRueypQn4lu6WRexqLtWaxssfisgHhlUWJI66Kerprl2s03PQFGmcS8ltrgA/hktkQBr9eP1F14KOZe0vEl6XAbQdsmVIfMAcEXrRFX/uCq+3znuGC2xkwuqfkl43UZiFp9CSv9MUkM0OBqM0EvcUIlyXZvyQhZ1ewadyCud5D1eAJtiW68yOtNs0Q2I+fr9GQT65Ic87gvYb4c1COw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BsIFhmR1CCiNa2CwpMWRv1IHoOdGOau+uvuu9gdKFM=;
 b=XwXxwwA20pJ+/Q+Cx5AVEtRelBBGLSlHhFHrYZjJqB4X0JXPLn+sLP8vk3+UtiwqBXG6f+VH2XQCUT6gyBn42rYF66oMxi922xHVp+LL0uMdCmcVkdWL/+RtiJR6H2qCkY+fcnYE3tvpF8iHmR6JJxVpYj1PTQWaGNnJoRVVL4s=
Received: from BN7PR06CA0044.namprd06.prod.outlook.com (2603:10b6:408:34::21)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 07:53:35 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::94) by BN7PR06CA0044.outlook.office365.com
 (2603:10b6:408:34::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 07:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 07:53:35 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 02:53:32 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: add missing NotifyPowerSource message mapping for
 SMU13.0.7
Date: Fri, 19 May 2023 15:52:59 +0800
Message-ID: <20230519075259.1650630-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: bafb2f96-f056-4a67-0c21-08db583e2637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDr51LGKCyoN6qSZHEAOiRZiKkIBJWWL+ToxSILmvE/EkwsvpbJfMxHHonjS5wKpZe9BcTvoV/MKzNJDLTHA8Upi7apn1Ffkmfzd3JkISU5u+NnYn3HLj1/u7CZGPPL85ln55GC3d0C/dXThLy1EsV5VZNQRvxIB7r56mkoaWjTaDhmJgHWz39hhsFGmlFxTi3E7k8blA5D/YyWgER4ZIuovzwC1iBHjXA6Cz+Dm7kWy/XyexhcKcfF4nN4714qSFsqpaiSuuyMydBUxSGS4h+s1MfWxuzLnXE2BkHXc+YDI79fXLhV4y0Dhjg/bqVYLC9rx7R2cIqwxcj1vg75c1jOmEANgXyBhoao9qiqi8+q2HPDNzRuayQuWX/RqccCOyaqqnIVWSckPK93qeKj7h4rNl5rG604cgKdBJmlQ2QxC8NTaORIAQXFRekc8kQKqWxNvEJVeHW0734TXC/RhLp5pE9T/dUadbg0TL3ope/Xu681tot2hxRbMF2DDsCmHieBcnNK2d+Cs64USIHFdQXX2rk7xlaa9mbbL7LxasNDh27/6+fABgOkhz3R+B6OZoTWmN7GPXt/S2ErvTL1tHKsZVRC5veY1d67loq5E64A1Q96HnWZD4MVqUTgS4NOUbmpDE5B9uFtCGEflcXyoEkSo70ur7WypnayFLOulUdoLI1tskQWT0DacBpncGfXodKhyuqKrlYUztMuxOMew3XlsyJL9CeTAi6zojo+phARNfmChPi8d1mmFkxx0t98jVN1pess84Ewd5wlX38zKyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(6666004)(41300700001)(7696005)(44832011)(1076003)(26005)(15650500001)(36756003)(5660300002)(2616005)(36860700001)(82310400005)(47076005)(83380400001)(336012)(426003)(16526019)(186003)(2906002)(4744005)(86362001)(356005)(81166007)(8936002)(8676002)(40480700001)(82740400003)(478600001)(6916009)(70206006)(70586007)(4326008)(54906003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 07:53:35.4946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bafb2f96-f056-4a67-0c21-08db583e2637
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
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

Otherwise, the power source switching will fail due to message
unavailable.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 1b6116cf8b4c..cf6827179fd1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -125,6 +125,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       0),
 	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
 	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
+	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
-- 
2.34.1

