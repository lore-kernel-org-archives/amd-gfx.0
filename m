Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F56DC3DA66
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 07:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE7DE10E61C;
	Fri, 25 Aug 2023 07:24:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 898CB10E61C
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 07:24:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/B2mJzQ2sGfNhWIQjylzIvwnfFRzh92yePYcqeRZqYjWJ1qiLZlIWRmKlK/aPcF5M0rxCZr/OjAbLjklALHQ/KWIjU7rLIHrHVGWO4wGvMGtbFw5BwZNmtb8Hp01IfX2CG1OlT0G2x4mnEFCUm5vHDgO6oItTg+5Aum2Df3R8q5iAvIE1IOv0oC7qZufDzlQBg0w014ILHnREa0MnZ5MNVxJomkmiOYfRmcp0XBi1gIp22MPAOnq8uvaJYSraostYAJAfe7OL59sFVfjY5vumvFtSTmGyTwJceSVxwp5hPAPp4jVrqdaeFOLG6earV2tTB4n3Gutmg86tfMWmZdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ey7/e5u0InqKieo99vkEVbZ1dY77jMYIWO82J6DMSTg=;
 b=DsZP3trRljeCv98/pxXckyuu2EekFj3NGjsi+hBVxRBlKyIvSE9gowrLWnsW8TdLppIouE/6fbQsfGF/IPccWS7tkRI/oG4Ea60YeRAH2VQYAs3a6wJoJiciq0lGv4d8zf6/NAMAfn+aj0AY+QHzhFaWtgVkwlvDxoOdv8zOJjlzNq3M4rYWi8F3A4fnjeeI/B7Op9ucLrqnfzyaXF/oX0dwLo7+IPu/neNTv83R8fbyGnegr2xW7ZFVKEbktnmbjekp5nJm4prNWXk5Bw0CqpDLt+/FV2qhGgs6zfqrx3Jom2DCcynRe01wYxIjGb6yFqjbimoXk76vvGy/RF4k4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ey7/e5u0InqKieo99vkEVbZ1dY77jMYIWO82J6DMSTg=;
 b=CAGh2Pd3N1OMSnYXVotfSY8AaTEC1Ac1uaJ9zSDAQ8yyP+LewmNFA9x65Nsvw7MGm0evvKykXYV2DnFrnjGK+z1nkHX1J2j6JPSaH+g4cUH6BJAaePlnuXuZVV6mFINOAhiWUuIeKptRcn4UgFw0OsqlRWXtvvx+OfjzO0UCeM8=
Received: from DM6PR02CA0076.namprd02.prod.outlook.com (2603:10b6:5:1f4::17)
 by SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 07:24:17 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::94) by DM6PR02CA0076.outlook.office365.com
 (2603:10b6:5:1f4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Fri, 25 Aug 2023 07:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 07:24:16 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 02:24:12 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>
Subject: [PATCH] drm/amdgpu: use read-modify-write mode for gfx v9_4_3 SQ
 setting
Date: Fri, 25 Aug 2023 15:23:47 +0800
Message-ID: <20230825072347.16258-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|SJ2PR12MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f628bf-e610-4697-463c-08dba53c4a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wiw3+tgR6MhfOfoNddSW0bJCNVCSWwv2rFA/avw2+twLlO3ZNXErVpQpMUb1KnyeRMDljuqiyjfDhc7DSjq3DtQOKVXFWkFoSwZ2yQT/a7wlZoqC95z4AU99U65mZZd6/ARRBBR7cvR8vGDCFaCiB5yrio7yHqKdxnI73GgDzIt+Yzkq2RU30Lp4YyIe0VNH14IvlBqVNZpoeRgUFchAzeY6021EEtVdojRDqSiHIInvvliA/ezNeOXymxgEF0vstW0WqOIuEEcso5PZeqqbe6SX0SfIeLOeRONg66HUndnt8xAIRhC7hjYokY7U7qUMVViMvLZ6Hw4nVwro2XFanD5Du/b472I7A/B8F7HlZHrgcOOj8JttkGpcOazzHhfPsT9tt8TwXOEk7CmwZn5jlm6TaKuXp9vYYY1sn22bddombFmXXDdQECDvj7NbICwjb9bgg9vTP79zzb/SnNDZQwWUrzvohWSQ4BHXDgSVnFpebpWJ6fXu+iqwjhUDcHcA6Tw1OySBBMs0Kk9XiTheFSIum6IEBNjxlyMQx/VD+x+qwFo/uOUmBSPM4YZ7ziO6EMFriQMJbOdanPUzBSHstAIyXlJihMnonOLz6SlnAwgtV4ZSjiLDRHh2aiQgx1zQXMEKdzmqYb+0Xdhxjx3JBFc+/5AGmVWqRSqoLJh1VLJGs3YEWZH4BlpMSPppsux+FPP/YYx01e/pKzIMveZcNNNXcnq04CiExgGGCht2E9joBcfEfxZlJdrDU42b8gXGKJtoQdrgy/AqOr2CtRsrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199024)(1800799009)(82310400011)(186009)(36840700001)(40470700004)(46966006)(86362001)(82740400003)(356005)(81166007)(36756003)(40460700003)(7696005)(478600001)(5660300002)(4326008)(6636002)(316002)(70206006)(2906002)(70586007)(110136005)(8676002)(8936002)(40480700001)(26005)(6666004)(16526019)(426003)(336012)(83380400001)(36860700001)(47076005)(41300700001)(4744005)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 07:24:16.6594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f628bf-e610-4697-463c-08dba53c4a6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of using direct update, avoid touching unrelated fields.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index b4fdb269f856..f24a5474db35 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4042,7 +4042,8 @@ static void gfx_v9_4_3_inst_enable_watchdog_timer(struct amdgpu_device *adev,
 	uint32_t i;
 	uint32_t data;
 
-	data = REG_SET_FIELD(0, SQ_TIMEOUT_CONFIG, TIMEOUT_FATAL_DISABLE,
+	data = RREG32_SOC15(GC, GET_INST(GC, 0), regSQ_TIMEOUT_CONFIG);
+	data = REG_SET_FIELD(data, SQ_TIMEOUT_CONFIG, TIMEOUT_FATAL_DISABLE,
 			     amdgpu_watchdog_timer.timeout_fatal_disable ? 1 : 0);
 
 	if (amdgpu_watchdog_timer.timeout_fatal_disable &&
-- 
2.35.1

