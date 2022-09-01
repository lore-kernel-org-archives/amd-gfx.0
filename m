Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6883ECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Sep 2022 14:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9481610E73A;
	Thu,  1 Sep 2022 14:45:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE5310E737
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Sep 2022 14:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE4E2ps3CphlGkU3PuSoqoM12SnJ3hSl36RdRNDfMZqJVwklFxJtKrFBvGpDK8oQC+LM9dzOpTj6RHzxmN1BUQIxp23IfjuPfoqvcdDXp4bCITzO4jJvm6rLQdh9wYzMQsRKGD5xoCIDX8gu40apeHVQaGQwj2ZeA+mzYpKHoebYa9qeF7NFTz/h9xahU8/eIoSDg8c9IcKOziAAg5OMgabZuo98o0CtWWb9k+DU7e1tzYE0neGsZU/9NDYTaEj5m8UvdAgLGr/0ZUsP3PboHN+CrchfdGkQ7GwvxMP2nMFevx+ZIH/zII9cdFnPClMy7nRYWyRDw92F7ARLA890ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZ/OhEQ2r1fEtMmXFhJeEMCCKnnFu5keXSRzMEdZ/as=;
 b=AF2mNy0NoIUxB2JceuYk0LWJm0r2GPbTRBdHTbIZRyKBraUutmduZh3NbIHYiMQ/LZkgYXG3PkHLdhTTXbv7ThU1y+zoURoAezp2MwsVc/8RCc4WbaNY8rbPAxGZihKFu3rPgJ2kvkkKjsrXhrKApZXvv7l24RzVP665oNeJ0X03ofuuv8iVFLJbL3AZzpz9iQYNJVp8kdWb7SKsMQOIFSA+SyIW2DRK2gcUUvBa2LGY9LTVlnA6QSYIdwcxlaQlroqQTIrLUpHnT/9FBDgPliw0w4K66dn+/iOvkMWlUdCgT3+pSbhDgdPwpqt2BP/VeWvZwrrOjBGF6G3f3ph53Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZ/OhEQ2r1fEtMmXFhJeEMCCKnnFu5keXSRzMEdZ/as=;
 b=Rjdr1k8rRfXSYIwYkXBF+R2Ja+DpmcwZK/mVT2SeUI3HM48E5zpki7YF2k3+tpYdSpiVM7Dez9uEf4LMptms/VBsOMIjjApeGsSC09r7kuJAAWsJzkjQ+wEaGYXwL5s8gvnasymmd9nUwznxhW7tsn6rCTa+8LUJNKpvdQrjK24=
Received: from BYAPR08CA0025.namprd08.prod.outlook.com (2603:10b6:a03:100::38)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Thu, 1 Sep
 2022 14:45:53 +0000
Received: from CO1PEPF00001A5F.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::73) by BYAPR08CA0025.outlook.office365.com
 (2603:10b6:a03:100::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 14:45:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5F.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 14:45:52 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 1 Sep
 2022 09:45:49 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: add missing SetMGpuFanBoostLimitRpm mapping for
 SMU 13.0.7
Date: Thu, 1 Sep 2022 22:45:23 +0800
Message-ID: <20220901144523.1113135-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3b97386-c40f-4e1f-fd16-08da8c28ab2a
X-MS-TrafficTypeDiagnostic: PH8PR12MB6676:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6IhL11VjuULH+okXAWStThI/Y3IAnEXmU7EdApOEg1WImcESxbeF7z48wGQjU2c/LnvHVaf6O8mH38c2ByUjdPBwN5LB/RnIen2LmFbNKgU4cvbqkXULedxKU2CjUe6hMHIl+K+GdkHBJ8LBhRD7Y6mqwSwkyGehaPDLiNmCGs0MDOqyrWHZ7+4nM2Z2tTFaWo3o7PBFttnMi28vwqq2D+W/jfreP5QX+qy/L6mzOY0X67UhWYAZ22BrISG16UVeZg/eFNyOQzRORuTHqSa2OSGzwj6IBO+MiTQjWuFaIkHEE7JOxQtSwzWXyezTTP4dXjliLwawlzJ6JMw3aGI/b91iytyI3VEpo08SoAQnoW96zp6goR53K3g4bBP9/0DzzclciZ4a62SKZfWRMCY0PBoEXLId0wrj3uDXh+bXZsGdk+Dysj8HGA5cl2bk+a1wQg64t1JHaHWIlaJhb8Z7Q62eiG9sg1d2EavQi1VA259SXf87BFHichFBm1E4xQFK617FftTL5ntYbcRNgW8hJHJx0cxmbOZe0Bv1nsJnRqQsMh8v0MW7H82ZPKEqjFqMgJE69fSSBHZv3ddaC0q6xJ9ESxwE1PhM9gbZv/2M4c2kUlk7AiFoYXPq2p5DwtkHxE0dP6dVqyM+4i9YvfOj+9quMFzgvfxKpco6IfKyESLMj07vYd9thci/M9hAR12yl0JWbE0QBTgapgNmFekbGrIVjxUnEkbK3VrkIKQxJCM1pAi3/inUAEgdumeAxJdKVuyST/gee+2x+HMFwzloiOkv87HWMs8PhxTbygvcNuYuJELIddCoN1jbtpCNY6DJD/CqPHQvRukM+C1lhHov6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(40470700004)(41300700001)(478600001)(2616005)(6666004)(26005)(336012)(83380400001)(7696005)(426003)(1076003)(186003)(2906002)(8936002)(82310400005)(44832011)(40460700003)(40480700001)(16526019)(54906003)(47076005)(4326008)(6916009)(70586007)(82740400003)(356005)(8676002)(5660300002)(36756003)(81166007)(86362001)(316002)(70206006)(36860700001)(213903007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 14:45:52.2773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b97386-c40f-4e1f-fd16-08da8c28ab2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Missing SetMGpuFanBoostLimitRpm mapping leads to loading failure for SMU
13.0.7.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: I2ea606ad5089b2612069614349c3a228406ef928
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 4de2fc035dc7..c8f4fe4b6371 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -120,6 +120,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff,              0),
 	MSG_MAP(Mode1Reset,             PPSMC_MSG_Mode1Reset,                  0),
 	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         0),
+	MSG_MAP(SetMGpuFanBoostLimitRpm,	PPSMC_MSG_SetMGpuFanBoostLimitRpm,     0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
-- 
2.29.0

