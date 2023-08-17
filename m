Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B63EC3DA6C
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 18:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC50710E568;
	Thu, 17 Aug 2023 18:15:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1988B10E55A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 18:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKgCc8GsV/FweRii0m1sLVPsVt6EatTqeUgVFoPSPcVxqg6zTNQ0lk6AQCxEoQBDDXxTw/gkIbgcONy4xfI9CnmrAzxyEXjMBLsT94UUwH2SuAdVbYmyAVjeAOWKvIJsiWZOC4/QIk+WvnsSI/6MwRma2cXT/wL+FDQn1Z15uOIDqYG48Lk7a6fzzRV6vD5d2su5ZiGlu1EJLBZG2MqfS/riWRQJbDHzNTgSme2EvD8vZWOw63kBS8qk7dVEEQkCXT3GabU4F166WaEqeQ8wVcSj4js/Ak1OaLvM5CgUso0jpBuWc5QUph4rpScgtuI1F+0viB66IWZTRabCF3S/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mo+6iTqoRz4yV4lDXVj1cIagmGrjacVS6bb9cjX0Mjs=;
 b=FY30LSYfj0wJKdeQq+LnTI8NdemebUxsZ2WwQW237Mvoe3U1iXgr0QL/sEekNg3+0Nt+VE0BYkykjn5O3RL3ARSSHGgaijiQk8GmFPwPT3ZGxy1/3hA+XP99zyVyJ5w5EF0KpsOW0hGkrzK+3s3abYhT02Bz8XLS/4soD9Fm2nLPrP08PkU6cTg5xuu0/6rU62phtdHLFMqyvJ/6BRb6aNAdSx8dFncRutZuBc2OVyKLsR3GXspzVJRjM9Gsc6rk0VxUrAdxsPWVfzpBXZdMXnSkhGT9Snws/Cx9vBIr4Jroy4N5OsS1+YaCCldhTkpLTRZ4AVYWwSzyvc3Tt7eg+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mo+6iTqoRz4yV4lDXVj1cIagmGrjacVS6bb9cjX0Mjs=;
 b=lIkTHWLm+quQGN4NNgGnR7o9/x8x9UtG0g0UBeZJ+CiOwYcFx+Gtl3caTSMUnGlgNnUoXXx1cXbWihJ/jAooBeGisInWVnsFEyL5rHAYG0jpC0TFQ5+m6hd3NKZV7802h40M5MGy/BFTNFjBhvuVsiLk5H+DegB+IAELPfQUk5g=
Received: from BN9PR03CA0667.namprd03.prod.outlook.com (2603:10b6:408:10e::12)
 by SN7PR12MB7202.namprd12.prod.outlook.com (2603:10b6:806:2a9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 18:15:25 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::63) by BN9PR03CA0667.outlook.office365.com
 (2603:10b6:408:10e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 18:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 17 Aug 2023 18:15:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 13:15:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: enable gmc11 for GC 11.5.0
Date: Thu, 17 Aug 2023 14:15:09 -0400
Message-ID: <20230817181510.1544991-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817181510.1544991-1-alexander.deucher@amd.com>
References: <20230817181510.1544991-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SN7PR12MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 37ee2af4-35ed-48ba-bf04-08db9f4dedaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3RkWzM9l68pzsK4rGq6iqvoz548SP6D60kcLEctsJB5YdshupdfRRsgUm07Wmtp+yF6EiGMycpSNJqqX9EzndHQ8BpWh22vejNl96H4d9AybpPROeUjtMRLVKG7VFFHi+KFBKClKc0beQdlq5iKbWMO1JarWbkgZPJn4gGtpXqEaxJ8F7Wq8fqmesXpvBZaSrO64Ly1BRgg0HbwV6yVNyLqx3ty/yynDRFPVY/cP0PEvQiy2LS77ZHoSB90yQAmsV2xSVkI0cZFpAEggUDqZ3Tz6xk+VJFD6NMcFW32tfXuqeLRrW5mbFyt5jszKBxKojE12FowgkmlV/F391lWxtOuAJz8Pqc38NWmfiMDhskYmQkhCgXR0gTYKVrecz7LKV/VWZzjZJh2O4boSF3tkhLPoHVpIU6gvI4gDWdDX4ONK6PKHVhsuw4aL6v908AGq8lgXy/lOFZYb4BSRNlRFQrYW7DmsYbUS2WPWM12sPmZXcYJ2uIAguHaAUqhzIBBmTO8RyOATj751qi20D81Ir+XAzTeLUssm4sMqe+yILhxspOICuJjbBmIwCwfAAjp9ozxYNlVcQNpVKeWUCz2SYMPNCUa3ailoSbpD+CqyKnaZoki5sqZRiMPmPs9FF21mFs01BETt3mtvPu6a0Hne5QATaVfXz0Xjmjrr0IwE+/3e9Dr+XrWmw/deK7AlPKk2Ibj2GvHpjAaYsVvwsktpjAaa1Cdi6SBgWuCtwcBhiHJojPKYepMrO1FNJeNJsGDSRvNTixWh5e8jAZ4/oAVvTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(316002)(54906003)(82740400003)(356005)(81166007)(70206006)(70586007)(6916009)(5660300002)(41300700001)(36860700001)(47076005)(8676002)(8936002)(4326008)(26005)(40460700003)(2906002)(4744005)(83380400001)(16526019)(478600001)(40480700001)(336012)(426003)(86362001)(36756003)(6666004)(7696005)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:15:25.0823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ee2af4-35ed-48ba-bf04-08db9f4dedaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7202
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Add to IP discovery table.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 5c4e85ad7f8d..d2f5a34e340a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1665,6 +1665,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
 	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 5, 0):
 		amdgpu_device_ip_block_add(adev, &gmc_v11_0_ip_block);
 		break;
 	default:
-- 
2.41.0

