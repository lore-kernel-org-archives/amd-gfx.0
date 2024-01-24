Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D993EC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 17:09:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57D3310F6EE;
	Wed, 24 Jan 2024 17:09:24 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41C9E10E3AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 17:09:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ki1OsTgo2n1c0VX6CK2AB8xAy9ZE8Xp+SPdcSTcryPnhvWcfEOLBjoPJQiZWckUc271/X5uOMMbOV9wZ91wel3HcHCmfCliYj0MMeDmVYZK6ChNmlvKgTt9ScUBj0YK/ENqLFrZ7+dapAAlXF786hY4W+V1Fx8X2F4LJQr+LxdM9/afYkUu8dRiqdu8lTwl4+NhLEX5xw0BQwrYx6M8MRUxxRHQW3iMx5BzQYu1ASVX0y+zHvC3W3X1Gjvr/d1k3Dt+UbtmOvcya1xa4mxJZqIoY+eZRrbTcFJoqIzsytL+Y5ANL6jK1rb269HV1NfLlvXNlC1QbBJITaQoCGirNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQzUEbR3TigmYDiQqDNs018yfHBcqEHm5/ukqz5uPmg=;
 b=NkfEojN6JPoUqFKiUUXotolfS1YyNu917KIfc2dFVgVbvzKLCUI2t0PYHa46e1Clqbg43WJbqby420CrLjc7QMybUHV/NNIAyzh/tjrPa4vCinIg/ORItHo2jWaYKS27GozlQaNyPKY28+9ClUs388JvwoB/A5Q2xLpwlA0dSqz8XE6dOizchieIu7ah0yp+/sAyLe0XvBLlcmcTOvRikBHpSLPW3RHrpAOwzO1ybaZlMEzLrfDAwdVLhRMaRB4SFZycbNc4XegpFMCUhQOT9N35BbVlDQKCC271h5WjgNVRtTAzZ0L9v8VHV04x8awMmtUEvYmIK51TKSX+o+WkvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQzUEbR3TigmYDiQqDNs018yfHBcqEHm5/ukqz5uPmg=;
 b=BhLJtY6xB1u2mFL+kEIADOJr54ewrmZ0zlxJIzEQpwTsU5O8mvcNwW5aTxZN/ShCZI34Y1iHZkBigyEFnMBxHCPgNLHcPo2A+nsWRS8sD/BzMuIvK8rcudVG9TWZf0CtNyBUO0I23IEsxKM0+ukLDN/Z8144O6zhR/h0uq/78ow=
Received: from MW4PR04CA0304.namprd04.prod.outlook.com (2603:10b6:303:82::9)
 by PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Wed, 24 Jan
 2024 17:09:20 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::53) by MW4PR04CA0304.outlook.office365.com
 (2603:10b6:303:82::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24 via Frontend
 Transport; Wed, 24 Jan 2024 17:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 17:09:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 11:09:18 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 11:09:18 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 11:09:17 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <mario.limonciello@amd.com>, <Aurabindo.Pillai@amd.com>, <li.ma@amd.com>
Subject: [PATCH 1/3] drm/amd/display: Disable ips before dc interrupt setting
Date: Wed, 24 Jan 2024 12:09:04 -0500
Message-ID: <20240124170906.901841-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|PH0PR12MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c9728a-5212-4152-b0f9-08dc1cff3455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDMkZs7QQo3e9fJzvs130B54hfQLM+14rid9UGRQq5aCUueBab58GAps1YDD8CNRF5S2gi3DWlcpkoaolt0SnsO2+m+B+74O+sVLlMxABkXZRrXlK4aF8QtJ5qXRbauZgtonR2TSUE39hvZQQOvygtlry4I/pvU7JZY5BVJ18wh3JSLmWoBl/bw/YJWa7AkV2UiLDtl8IyHuWaxwtpTweQOy61aUjBR3IIADmU0jWhXY+uGJ5oRdV+8t12LtjR+TO935OOwqbWWHuW+vWtIpWN/vEp9VVs+YmGjcg7uI0HMKmPmgkj/liNZkJ0v58TdFl9K+Nm2/++4iOceTqeBULyUGjskiZ2sgMtetmjfmVmDJC4ozZz+5ka6aOflRIO9FDSxvHC+zFpvDe055DOlTxyR1vmKiNNEAudWIA5iAsOLWTGt0lJZ2iYM870sKvitDd69vDEIAuzZNA4QlTo8h9vP3Wwvzh20Yc+tjrQBwLCuijv6SPPaqXIUP3mS7Q+a2GRr+JCNdOwC1XnyPpvXzrUrNBMpLlgS9XAAqyN/O/HHepBBVesVZfW1DNkxucGFwn22AWrx81BaZ6zCDzuLXnQ6dtlkQA122laJR7MOCScvQbF70s1OQXmHV5FBHTh0suvJkpg/R/rFuhdiBzyfCQOcOv2qnP3QSSMyPo4RSniGk3+r92UCjYzocQ0QrsG9oQ74sogQWLvUZXNqvJaJJQWBhSjxeXyIHuzzVtboZM4JXMtGcMPIlVoX1r0+FxaGcuzdDrj8wz20rFF+KprjU+kTvn9ZxLGExcAk0zwdjpIU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(36840700001)(40470700004)(46966006)(336012)(26005)(426003)(36860700001)(1076003)(7696005)(81166007)(47076005)(6636002)(316002)(5660300002)(4326008)(2906002)(110136005)(70586007)(54906003)(70206006)(41300700001)(2876002)(478600001)(8936002)(83380400001)(36756003)(86362001)(82740400003)(8676002)(356005)(6666004)(2616005)(40480700001)(40460700003)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:09:19.5662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c9728a-5212-4152-b0f9-08dc1cff3455
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127
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
Cc: Mark Broadworth <mark.broadworth@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 jerry.zuo@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
While in IPS2 an access to dcn registers is not allowed.
If interrupt results in dc call, we should disable IPS.

[How]
Safeguard register access in IPS2 by disabling idle optimization
before calling dc interrupt setting api.

Signed-off-by: Roman Li <Roman.Li@amd.com>
Tested-by: Mark Broadworth <mark.broadworth@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 58b880acb087..3390f0d8420a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -711,7 +711,7 @@ static inline int dm_irq_state(struct amdgpu_device *adev,
 {
 	bool st;
 	enum dc_irq_source irq_source;
-
+	struct dc *dc = adev->dm.dc;
 	struct amdgpu_crtc *acrtc = adev->mode_info.crtcs[crtc_id];
 
 	if (!acrtc) {
@@ -729,6 +729,9 @@ static inline int dm_irq_state(struct amdgpu_device *adev,
 
 	st = (state == AMDGPU_IRQ_STATE_ENABLE);
 
+	if (dc && dc->caps.ips_support && dc->idle_optimizations_allowed)
+		dc_allow_idle_optimizations(dc, false);
+
 	dc_interrupt_set(adev->dm.dc, irq_source, st);
 	return 0;
 }
-- 
2.34.1

