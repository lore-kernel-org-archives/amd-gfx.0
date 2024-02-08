Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD09C48260
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 05:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A64D910E147;
	Thu,  8 Feb 2024 05:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u3pq4ICy";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC01010E13B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 05:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9KPwTcU8lGtv5I0sSVtVqRLIUlO/HTihnQe8yltDJGoxN4WS6HOj9wZ84A2+d3AIu7unNJvqZljrkW9txanYZ8WkHx1wB9ixmBgDSzWYu6QNdKo2wJUZPnfkHB/hectiZCAV0vfPB7XvPuMoWJWWfo4OhkFywfVZCMakZkihVM5IBxalFQInQKO2hfhHYXxAMcgpltplCiOo1LIkVMQh6M/8hQD/auG3lIfaVJG18WcAaTH1ce2PUhRvmDg12BKUg+PF+DVRiHqvV42rf2stcEWV1Ektn+MMxHiEksupuoO3X164qGO/rYJwHpRza1QgOXPfNsKyg18cQ1+AKG1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVpiXnasZ3qzSl4JapSihbjAXZQdxdBs7PKz8qabC9w=;
 b=CO/wWg5wfjQ6w6ntGCuiwvj+3JcNZLaJifYBVgra3yAmHtGXiQKwJkozhq05BvSFIWoPyHKl2hzP8NaGQbKM4FVWDUwoV6+MxbEALKxeBklnfbJ57w0eOuHKqiMBPZ1P09/bSwi4lM8zsg0jjOdvaCRCmCCaq6eLZKrhPoxfjw+u8rbcd+rSFTTs9Moo/l1cvrxgKq5j1bkJGjS/Cs7x5B3GCW8cmVhG+6gViyLeEVltqN4wDqCgKK/WUXyXnBm0UKpNJU0QxTDVKtYH/GR8+8rZWnfPP4LkQR4fQKai0YOm8hZhogkR57PZvYHfl7ap+Yt3l9l2loSQ8E+jEzJJig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVpiXnasZ3qzSl4JapSihbjAXZQdxdBs7PKz8qabC9w=;
 b=u3pq4ICyCI+/3xhbJNnOMK2FMfrb/CQIWdHmw32SKtPgR0H2vwsr2umuyQWPt21zI6Hg3+25eUSKUjJlgnxbLO+FJ3PWX5Esht2+ddB0xQ2KqwXotrRoWrWd2eWzFVP6JSOs7gSL+xt9QLFLyQzN+esnHYHfH9+AxkkRqUUNP6k=
Received: from MN2PR06CA0002.namprd06.prod.outlook.com (2603:10b6:208:23d::7)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 05:53:15 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::97) by MN2PR06CA0002.outlook.office365.com
 (2603:10b6:208:23d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42 via Frontend
 Transport; Thu, 8 Feb 2024 05:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 05:53:15 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 23:53:11 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
Subject: [PATCH v4 2/3] drm/amd: Stop evicting resources on APUs in suspend
Date: Wed, 7 Feb 2024 23:52:55 -0600
Message-ID: <20240208055256.130917-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208055256.130917-1-mario.limonciello@amd.com>
References: <20240208055256.130917-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: dde71d0d-03c7-43a3-bddf-08dc286a3e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFpMOUPpIpL/2A+3czPvJ+0M51MvUJ++LcsU3CLK+5If8BwJ+KL6v4uSfn+O0KfCEMtXGEGF605rQu4mH7VGEANnKMsbqbZ2osff6URgADMKSD04eBzcyX/zmS3SqO2V3XcQODUnlcOAtC8qf7YedJ4O2MnPTMI43U08Buik6+oA//XWcVelXs1MHr9sUWfYZvhzp3Fp8pEPAeel08IiKRlTR1tDpu4U1XUOgn5RMhQ/T9kZWz60umafNIoL/5JrhehEwlieqRhlfXqv1eRB/jLcg296sNP9XA686MzR+geB1dXiD0O56/dwkfa6uQXIzH04onuP4Er+d8WC/EdvljUSuBj8SP2VeZlfwGOi8LJKbtsOWzm8GsOR+L8bHbnyrt4b0w6pJvkFO4hjBEOg+fdU7xMv64OhdJ4OWtGLrpUysYeQaxRPuaQi/UREC6UNzsmpgUZA6Ryd5Z+NaZbROO5ByLybc/Lg2Vqj69y4Ha4LGStLYZNP5gtnEs1zTK9Rh7xoqjF1W48A9dfSjcC/EzYZDiONTzFlokANk2QAbSmuiAisBzqWfyYVG6HH3LctzTh9+xTBhemHo7KVurx4jw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(426003)(36756003)(41300700001)(15650500001)(356005)(81166007)(2616005)(82740400003)(1076003)(16526019)(6666004)(66574015)(336012)(2906002)(26005)(83380400001)(7696005)(478600001)(5660300002)(316002)(4326008)(54906003)(86362001)(70586007)(8676002)(8936002)(44832011)(966005)(70206006)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 05:53:15.4980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dde71d0d-03c7-43a3-bddf-08dc286a3e3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

commit 5095d5418193 ("drm/amd: Evict resources during PM ops prepare()
callback") intentionally moved the eviction of resources to earlier in
the suspend process, but this introduced a subtle change that it occurs
before adev->in_s0ix or adev->in_s3 are set. This meant that APUs
actually started to evict resources at suspend time as well.

Explicitly set s0ix or s3 in the prepare() stage, and unset them if the
prepare() stage failed.

Reported-by: Jürg Billeter <j@bitron.ch>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3132#note_2271038
Fixes: 5095d5418193 ("drm/amd: Evict resources during PM ops prepare() callback")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
    * New function to set s0ix/s3 and explicitly unset in cleanup
v2->v3:
    * Whitespace
v1->v2:
    * Add and use new in_prepare member
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c   | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 +++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3d8a48f46b01..f6c38a974bae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1547,9 +1547,11 @@ static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
 #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
 bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
+void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
 #else
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
 static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
+static void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
 #endif
 
 #if defined(CONFIG_DRM_AMD_DC)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 2deebece810e..cc21ed67a330 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1519,4 +1519,19 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 #endif /* CONFIG_AMD_PMC */
 }
 
+/**
+ * amdgpu_choose_low_power_state
+ *
+ * @adev: amdgpu_device_pointer
+ *
+ * Choose the target low power state for the GPU
+ */
+void amdgpu_choose_low_power_state(struct amdgpu_device *adev)
+{
+	if (amdgpu_acpi_is_s0ix_active(adev))
+		adev->in_s0ix = true;
+	else if (amdgpu_acpi_is_s3_active(adev))
+		adev->in_s3 = true;
+}
+
 #endif /* CONFIG_SUSPEND */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2bc460cb993d..dab03865c827 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4518,13 +4518,15 @@ int amdgpu_device_prepare(struct drm_device *dev)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	int i, r;
 
+	amdgpu_choose_low_power_state(adev);
+
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
 	/* Evict the majority of BOs before starting suspend sequence */
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
-		return r;
+		goto unprepare;
 
 	for (i = 0; i < adev->num_ip_blocks; i++) {
 		if (!adev->ip_blocks[i].status.valid)
@@ -4533,10 +4535,15 @@ int amdgpu_device_prepare(struct drm_device *dev)
 			continue;
 		r = adev->ip_blocks[i].version->funcs->prepare_suspend((void *)adev);
 		if (r)
-			return r;
+			goto unprepare;
 	}
 
 	return 0;
+
+unprepare:
+	adev->in_s0ix = adev->in_s3 = false;
+
+	return r;
 }
 
 /**
-- 
2.34.1

