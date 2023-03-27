Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655FDC6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 964D210E278;
	Mon, 27 Mar 2023 19:30:18 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB94610E278
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:30:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+MXaJaP7d98RVJLQO1GhTIZARytwmeABEusnwXuYk+X6EImZ+c+QETm2Nb1KeNp9bnO4yixvnOllEONlF7lp8u8LbXhUAoM46CDJgU/lCHfHnyxhjYMJUZMv3dZ9Y85QS3vFrEa++JFVY9fk3UcUJ0q5Bv8tyY10H0D91NqgpsZZriJR0kPYL+aPegvAwUVAsBSX5AthGgJF+bqqc/uimvbBPyT0X065bYIWUdJ7/tCre3tB1NZLjhB+JfEMEF/Q7UTJjA7C2dh2oPO/ozoJgv74Ks0ptF/+omVcwa7xbSxJEIRonOYj3stQ0jlM/eIePJb03mfsWpdemBccuonrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v23KABscfgujjB6Zx4DzUgO/IozUn8CwLBpyrM67vFg=;
 b=ZUEO6OFN12vckmnWmaNZ+fDK5GSkYfwg2OyWyqOEm+f6VcFD2SLJLopkDGLm/O4DEYQAK5yc2TmahGqoc+Oe9RwMVe3k/jzDWhD6X6cW4rhiGQZGSLOlKIkReAfXwLexP9uL4sGfyQE14wXvQwkjPez2j3QmNgeI/DkeD9N+m0BgtLLuMJzQQ7h2mFf2PNmsErbzJxzA7/XW5bbkI5Q9FX0Aqj6NO7hN0kZ2aV08vRZvZ9y7tWUUQMWV0E+NtCRdGVpP7Dce5ie2wpWOZnKW2ii8QzbUV6NVxQcTr28peJMWbnESARFgtvD8KMwqIYofeb5bVwgTZkKbKvxXQi3Ocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v23KABscfgujjB6Zx4DzUgO/IozUn8CwLBpyrM67vFg=;
 b=dEI6s6uu1V6OvsCcwKDa5edCC2BJBW+TjJ3DEAdovVuJwK+KgoxiTOTLAm9hv9T91OqHNEGP2wYOBikN9yd9cP5YxLx/S6VJUgeAgQobtBYea3LpJJUCIyrBKc8gM6QU72VbIRfAY3kjPLKxC9YJxgwBFKvwE5u1pfeaxejuOx0=
Received: from DS7PR05CA0009.namprd05.prod.outlook.com (2603:10b6:5:3b9::14)
 by CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:30:14 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::98) by DS7PR05CA0009.outlook.office365.com
 (2603:10b6:5:3b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 19:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.32 via Frontend Transport; Mon, 27 Mar 2023 19:30:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:30:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/10] drm/amdkfd: Add GC 9.4.3 KFD support
Date: Mon, 27 Mar 2023 15:29:44 -0400
Message-ID: <20230327192953.7756-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|CH3PR12MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: e67de50b-c11f-4c41-6697-08db2ef9b089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1N7bkLwL37j6ipb6HjM2xSuPgpg0DYMIZuITVfg8wkreeR8W3zO3nQvz3GAZgOoBCw5uWSic3qRK4KfSR91pKG1DRsr7V6IQ2Rvt3XmvtsaehrvqSNN1dfGMozJGcTiVVAJgZ7zS+73TyQ2s6tNklmG1RtuMjzCH5U9JNysf4M1N/fsZ/Sr24cjcF9u59BmtbZEx3cWiaKLp4FyoduGAR2jaYKaafoLCJYCOPYPWVrgGB11z54Vm7f70CMD95otjihIxbKOUIjKypfoMlbIkRoKk50leEQ8A/D76XS7wukGc2WiJ6PZNKNDn7gGuQjt3LjGNNE0khio4WoTCOGg2sU00Wn0RGr9Y/+XNTqQHIAWtou6AgvkgCi0LDRPOEaf1CmH0PJn30A78UOpZvSywihVTUJjX9Ski3Tm7f5C7gRH+ZR85a/jt7jaXWLj1S//oH7jAiBXPuQNJYlwLQks4dhAoKM9VDGGXpLUKxqj2vZ/8PDxeULBaYNmUe5ugSJusimxJ9U7NwCNtHQCjsmdYzqTEg7Q0Q+VLZLT/jCu75PNaF6k1cdtfLVwlum9BH90n5p4N9tPnq3ag/LvDKgKWIkRIyyNqABEq1MGPeTpoVbiq6OZXpXjSy5EJYc1ciKVQ4zO28KCzsvpvrImSYfWl4Vho0eQ2avBONIqCpOLHIEUPyJiozuNAPIc1u03Rlt3KJshpwl2EG549jirCJeTLSKjRvCYeRsFVy/Ss4cxu4Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(426003)(47076005)(2906002)(83380400001)(336012)(5660300002)(8936002)(82740400003)(356005)(36756003)(81166007)(86362001)(82310400005)(40480700001)(40460700003)(36860700001)(316002)(6916009)(54906003)(8676002)(4326008)(70586007)(70206006)(1076003)(186003)(26005)(16526019)(7696005)(6666004)(478600001)(2616005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:30:14.5805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e67de50b-c11f-4c41-6697-08db2ef9b089
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8535
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
Cc: Amber Lin <Amber.Lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Elena Sakhnovitch <elena.sakhnovitch@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add initial KFD support
Convert a few structures to IP version checking (Hawking)

Signed-off-by: Elena Sakhnovitch <elena.sakhnovitch@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c           | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c         | 5 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 3251f4783ba1..475e47027354 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1462,6 +1462,7 @@ int kfd_get_gpu_cache_info(struct kfd_dev *kdev, struct kfd_gpu_cache_info **pca
 			num_of_cache_types = ARRAY_SIZE(vega20_cache_info);
 			break;
 		case IP_VERSION(9, 4, 2):
+		case IP_VERSION(9, 4, 3):
 			*pcache_info = aldebaran_cache_info;
 			num_of_cache_types = ARRAY_SIZE(aldebaran_cache_info);
 			break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index ec70a1658dc3..4100db469d57 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -315,6 +315,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			break;
 		/* Aldebaran */
 		case IP_VERSION(9, 4, 2):
+		case IP_VERSION(9, 4, 3):
 			gfx_target_version = 90010;
 			f2g = &aldebaran_kfd2kgd;
 			break;
@@ -450,6 +451,10 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
 			BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_aldebaran_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_aldebaran_hex);
+		} else if (KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 3)) {
+			BUILD_BUG_ON(sizeof(cwsr_trap_aldebaran_hex) > PAGE_SIZE);
+			kfd->cwsr_isa = cwsr_trap_aldebaran_hex;
+			kfd->cwsr_isa_size = sizeof(cwsr_trap_aldebaran_hex);
 		} else if (KFD_GC_VERSION(kfd) < IP_VERSION(10, 1, 1)) {
 			BUILD_BUG_ON(sizeof(cwsr_trap_gfx9_hex) > PAGE_SIZE);
 			kfd->cwsr_isa = cwsr_trap_gfx9_hex;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index ed02b6d8bf63..f612325241aa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -238,7 +238,8 @@ int pm_init(struct packet_manager *pm, struct device_queue_manager *dqm)
 		pm->pmf = &kfd_vi_pm_funcs;
 		break;
 	default:
-		if (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 2))
+		if (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 2) ||
+		    KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))
 			pm->pmf = &kfd_aldebaran_pm_funcs;
 		else if (KFD_GC_VERSION(dqm->dev) >= IP_VERSION(9, 0, 1))
 			pm->pmf = &kfd_v9_pm_funcs;
-- 
2.39.2

