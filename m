Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F99E81E1E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 18:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81D2E10E55B;
	Fri,  6 Oct 2023 18:51:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C517A10E559
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 18:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqteLPy5Bnt+IwlUOIi8za4n/+k58Ydl2oHqqbegFHSGXwfG6GUM6ADscQZkmz36jVSCmuuqvaAuz2es7UUMsEVIQh/bh3YoCzyNgsN+Kftiv86FRm1sRS8edmVobgyAs/QDbHNIote9p03jCY9nIER77zBZi3K3NRou/jdNFhTZwIMx0VJ9s6FlwM628NP2D+0sa+7n3OxX+kaMDNknBtPAtqIG+AmvwGHyTSkD6ZAv+ZZKMrhOfn/RX1nVjYbKabugQF3hVeCMSqykFjFcl09sNss9Oyz6PG0N2Jnkm7wqa3hiMJHUHejZmHl7Gkg1POs4YjvfAmODp6rmsmX5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOqC/k3YbDST0jYwoRQcrl8E7DwyjQU/NHDVZ9r4bHA=;
 b=Fpg5z3qNmg8W+v32BN9DaVoY5URcgQGrLX8SNk3WyH4a68HzGsyzx8kTVK7BPzJXhYgQm6Eykf/+djy6opH3/OEMmn1Q6IVmxw6igLmY221GgN5R/JkE+O07PgabfTPEBSRbHJROQS4H0zVVdoDqzz3OUg6nP5fupFcVH8Iq1HNH755+2xwed1uWTHP7DRVqN2aWDdPv6PJ7z1U56E8bivCZ9W8NC4sHTgL+LKbgejBemUsr8TR9WjXeTiCuaB5lax2VCgKbfeiAuO4d2EAwSzvnI1pRNS02GQxhilA3hD0g3GrfA9BjycOgSiPS+k3ULn0rQWYAxCm1H+Lvo/pKcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOqC/k3YbDST0jYwoRQcrl8E7DwyjQU/NHDVZ9r4bHA=;
 b=S0KuIxzAM8ts7MmyB9WV3/t1KeRLTMqdwVi00LzQ5ZG7TGxSO8n4/hacMoTMKC2Nr02cxnDATrIjz3S9hjnmBUR9g5PsSI2T0b2gEPZC1GMq6oWVggXoZ0Dop8XJPLO8ILhwEC7ejYviIKcaHcJI0sASx5J7lpdzmWkPP+gGPoc=
Received: from BL1PR13CA0270.namprd13.prod.outlook.com (2603:10b6:208:2ba::35)
 by MN0PR12MB5955.namprd12.prod.outlook.com (2603:10b6:208:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Fri, 6 Oct
 2023 18:50:54 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::24) by BL1PR13CA0270.outlook.office365.com
 (2603:10b6:208:2ba::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 18:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 18:50:54 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 13:50:53 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 2/7] drm/amd: Add concept of running prepare() sequence for
 IP blocks
Date: Fri, 6 Oct 2023 13:50:21 -0500
Message-ID: <20231006185026.5536-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006185026.5536-1-mario.limonciello@amd.com>
References: <20231006185026.5536-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|MN0PR12MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: bf65358b-25a5-4d9c-5c91-08dbc69d2b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5gRTotS1nyWETQS/lqdRPtzn1GwY7TU59prT3fZ0bLJ6Y+CrIK5bgYAEbbCc5l3yKJ/Nd4jemcnY33PJ2hu+u0bkMpI7AvwAVkP1V3U6xR7h6R0TrWn6NaPG7tWVKJZwH4wPe50yf9ATeZJ9EbTTMfGR1LcHX0znjs6rkNurM+AsCKWCDrBADzkWa4Yli3PmZvNm4hQVuUSZ2p9TrhojLzn49347JK9ceFgWatKmT//QuxHh5HwiJxKMftlrZMGiDMI3L8PCNMP8C+s7q3DqsHiN0AfUxiK2Nm9wQYGv3dcN2nycuDZvkr7jkrJSjpNHTgxNJK6x/e/qlFJ+55DhN5O4SkqnIgP8calz7W/92hhzFFAN6W2jqfqzcfnX4yB7uRudwVgJjtCre5ou/YFJZ9oT2GtxlzyQTaI+a910Z9L/+Dd0W28qT4Po9S64+HOz1ZxYyQvDDsS08cJZ136vV82hU5kGpGzuZ5n7pdfDuwHG4M3TAezsNYhGxYOIahXuZBMZtENguJac6BeNbAzIRMDQqyZzKkWj9UT3H9x6V3P7Hr5l23ws6+0Ywm4LLpyk0xSsEsSapbi+4cAnVKYv3J+wcCgMLiVq3HQhJ1CheIPZpmQcbSOLoTCk9LjkFkaDFP5f7WKeqWLSPdsWQaixKXOpOy3BR5Ww6aWneUfmp406Xi6vabwD2Uk0HZmSeUIpPnN18WF42yoA48FcKScGYVxvYAgV3O+Y+BJRHpw8fbaPxFBk6/s5TGJVxUDPJdoCAKYpYEYOoTzxqkukzmBMrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(83380400001)(40480700001)(40460700003)(6666004)(7696005)(478600001)(47076005)(36756003)(36860700001)(86362001)(82740400003)(356005)(81166007)(2906002)(426003)(336012)(1076003)(2616005)(16526019)(26005)(316002)(54906003)(70586007)(70206006)(5660300002)(6916009)(41300700001)(4326008)(8676002)(44832011)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 18:50:54.2815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf65358b-25a5-4d9c-5c91-08dbc69d2b65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5955
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
Cc: Harry.Wentland@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If any IP blocks allocate memory during their sw_fini() sequence
this can cause the suspend to fail under memory pressure.  Introduce
a new phase that IP blocks can use to allocate memory before suspend
starts so that it can potentially be evicted into swap instead.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * New patch
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++-
 drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cb334dc57c59..a362152cd0da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4348,7 +4348,7 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 int amdgpu_device_prepare(struct drm_device *dev)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	int r;
+	int i, r;
 
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
@@ -4358,6 +4358,16 @@ int amdgpu_device_prepare(struct drm_device *dev)
 	if (r)
 		return r;
 
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (!adev->ip_blocks[i].version->funcs->prepare)
+			continue;
+		r = adev->ip_blocks[i].version->funcs->prepare((void *)adev);
+		if (r)
+			return r;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index ce75351204bb..1f831cb747e0 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -299,6 +299,7 @@ struct amd_ip_funcs {
 	int (*hw_init)(void *handle);
 	int (*hw_fini)(void *handle);
 	void (*late_fini)(void *handle);
+	int (*prepare)(void *prepare);
 	int (*suspend)(void *handle);
 	int (*resume)(void *handle);
 	bool (*is_idle)(void *handle);
-- 
2.34.1

