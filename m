Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4A6CD98F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 07:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E135B10E1FF;
	Wed, 11 Oct 2023 07:27:16 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B2910E487
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 07:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdiufGsyb783G91zzxms64vljUs4PfmOJ8bNx3teXrVZY/9tbt85uun1ThdBvSVjdYk19LaMZeIPP1TeEMninsGscj/MovS9xLyIUfErpCwiRXRr4jaoA1iYGYaGsBK276xizgxqpV9rDOb2FHBdGRKx+PUwRzEerFNOv0RwwqGkuvTMgCvTFPpFYmYwLp0RvXjThzaVuH7Qa1OnRQjO7LzJTeaNy9LWfoJ0PF1vKVUFOfNqcouT+C6blGi311cgq5+HbV6JjnXeBzL9YccyfGeN1Y/PUISOEJuhbtEFB6rNicx16W5ncBt0032IN4qyOySXMpS33cjltU0Sz0T+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPRg5LJ3RuRKOjhEy1V74YIMC9XSd5vQxkuR2c0eM9o=;
 b=SFToV27rX0Etb85kV80rbWgkR45KIRwPbUGzc0KxR9h8EPBHj8fWCh10OvIHitpUWCoN/U9xU1L+Bp9TRxGHRIbg8STRUFfNxHW7Ob7a9hq5AJfLsYYdWBdBUMLloiaOfVzHs2QTvX2hHIMQ1y/1DpR6WMEL0ux99YqEjFUbm5HUj0z28YAFneevP/VMtBUnUSnRsYVNn9TUjOXbPSvM1+16gqyfbnnQgyIcgMJRPaZmneCMbln7rSia9MEiQgr0ImaxWd6bBKA8+5ylHuNPCYs+RzJvkS+PE/0YJoFgWjzECsZrA9wzGj5A6eBLpSC9qWOiBPFlR9+t/7NOVjYloQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPRg5LJ3RuRKOjhEy1V74YIMC9XSd5vQxkuR2c0eM9o=;
 b=SEQ7pcivmCNcuvJNAJ+jb4jv7FlV+ZjRe+zR6aKGX7K+AabTccNGVSAaZfb5hHTBVVIHvXKMh9Gfsr18WnKO5k/4qi9nHDbMZn1zex6OTPn9bWoOg/KyH+og+kenOF7okAUHpjNKdErrmsyXohqHvemBn2ovuZY+uuRZ1aM9zC0=
Received: from CY8PR11CA0017.namprd11.prod.outlook.com (2603:10b6:930:48::26)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Wed, 11 Oct
 2023 07:27:10 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::24) by CY8PR11CA0017.outlook.office365.com
 (2603:10b6:930:48::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Wed, 11 Oct 2023 07:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 07:27:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 02:27:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 02:26:39 -0500
Received: from dev-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 11 Oct 2023 02:26:32 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: disable GFXOFF and PG during compute for GFX9
Date: Wed, 11 Oct 2023 15:26:31 +0800
Message-ID: <20231011072631.1901764-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|MN2PR12MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: 3425818d-781d-4c48-4a26-08dbca2b7b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOsvu8Nc0HN/6i+gaNXKzBrhdFCp0YwStrfsJaYJMWFPZJ4Yy2OyLKS/S/3R/cFymNWXgcnks9MGyDRJA+DeXSquUGU5/fMXwanbGQ3QeivlE5UzovGkWkJbiifa6UaQsnD9mcJ6r/NquW3ZlY5r0qbBRaFbQSzRkJkyI8BoPBwF/PrjPq0hg7MPiafsPgQWAJEJDp8rz9t/ysvLSCxqLyHchIVYRdVCGD6KWm/p75rnCXumSRGkPPsKY+Z+7MIpr3T67bokW447QnsgAxF2VjaQnvNMMRvn+XOZXAt26qtRCcqFj/A9D1gD2ZrYVlQyuvmtvTP78mD+JOHgTGzyHSdw8fptNFDpwN56s+FzZVbW9pHtkhV7h8ZonoWM238yuhNkogD918hLa/mmQgjHlLDJKebBKbnHdgz7/m+O2kxJZjdz7tovqt9andTpSKxYpsj2GVxpo7SiNRi8KByCOwCXjuU2biQYn8BANkBiZYWrKXY0XdWD7amQWUpptWtZWYv//Shjmc5kdzGRxezj1kZL7n0VVz5nuRU86QJ0Fk7W9ZmJK5Blw5fB387U4593zWsIWUYHr5ABL7IxE2VEqudTNjgPcHaMzGiwasH3Irgu0Aw3kefOWcNgVvsFh+XYKms9xcMIT97CzYQOCOZNbWNeLfe5c9Q1dnR0PHztDDXTJH/DvzkRRZ5pFhZ8LJ3TATVK0eXn1JyQN+fDlEDlBMtWnRMVmnk/I0OTid4b/XdWkGrhNl0XDRYA2zY7g8cHLriVuvuUGdUu5z3BP0JwKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(83380400001)(40460700003)(26005)(336012)(426003)(40480700001)(356005)(70586007)(54906003)(70206006)(82740400003)(6916009)(316002)(41300700001)(1076003)(5660300002)(2616005)(8676002)(8936002)(4326008)(2906002)(81166007)(44832011)(36860700001)(36756003)(86362001)(47076005)(7696005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 07:27:10.2506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3425818d-781d-4c48-4a26-08dbca2b7b45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
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
Cc: Alexander.Deucher@amd.com, Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 Jesse Zhang <Jesse.Zhang@amd.com>, Yifan1.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Temporary workaround to fix issues observed in some compute applications
when GFXOFF is enabled on GFX9.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index d3805dbbbb6f..fef93d4edcbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -683,12 +683,16 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 
 void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 {
+	enum amd_powergating_state state = idle ? AMD_PG_STATE_GATE : AMD_PG_STATE_UNGATE;
 	/* Temporary workaround to fix issues observed in some
 	 * compute applications when GFXOFF is enabled on GFX11.
 	 */
 	if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 11) {
 		pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
 		amdgpu_gfx_off_ctrl(adev, idle);
+	} else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) == 9) &&
+		(adev->flags & AMD_IS_APU)) {
+		adev->ip_blocks[AMD_IP_BLOCK_TYPE_GFX].version->funcs->set_powergating_state((void *)adev, state);
 	}
 	amdgpu_dpm_switch_power_profile(adev,
 					PP_SMC_POWER_PROFILE_COMPUTE,
-- 
2.25.1

