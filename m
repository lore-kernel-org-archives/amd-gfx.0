Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377CFC7EE2E
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80DA010E3F7;
	Tue,  9 May 2023 22:07:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F3A810E3FB
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:07:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdsPFyg9CMI+nY4NG+dLLsTODu4xXIGkAArZSajHPdQB1PG0IAUOMP3mJtDjLOH5MsHoSaY/LAC0AI+9Bwrqq5wLQAag5ejTO681pVE/c40Sxe1BF1JuxpZPU7vdF+ZRQVDsZcMrB8IwFc+8JMxdTKfiP1FvEDorELRRd2Y3QRo5WlPWejhuQzXxGdCfdylAJ4JiPFP/Vs6p6OVdpVq/jfB1+pqT7j8Ht/qfLSux8kKpFQMZ0E7XVunzp20odW5ALDQyK6ZQfK89icnXIm42/B2MGGTYftfU+GLJqq8mDqRBYgjv8F7LJLJGGfQDb3NYXdxyqtNmnspLOnoc+iLLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwFWlyLk+O+yGbxnF8aW/6Xv041BGnvspIF5LbOOSoE=;
 b=Es5A4+cbW0ZtpIwdASQ6S+MjkYAlSYH2SlGWSSzSp4RDO7pl558CE8YGP7jikEokymfiwezcJQVeQiQjYxCfck6xQ5+2I1Lly8/I0ltgRgkCJ3kJfbtF3iZxKoQhosXUetA/7gwj/kwSn3T4iP4EJB+QK1DsnYWqsxHcaiuZgUMIGTDVCBKrhf2WFlar6S5BbdJNczxiuKDxxZMaDlnUkHWieeNzhNcyXJmqZ2RWajT8J0+2Gls9l4vK9/9sxyc+BI+HSH66KjMduCRxOi6kXw5SQROXGq9ERcI2d8qvGYsFe+OQQHuyPAEU5uCIKfOHwcWxIDIwnXrUz+1aGcXuuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwFWlyLk+O+yGbxnF8aW/6Xv041BGnvspIF5LbOOSoE=;
 b=ES03gytUS6QlLi22LfSD1M9O5pbBtdc7ODBKgVtxKTgsSynxC2lOMc9NSqrHSVMc/pki1dHWgBDks8B6R8A8kG2tKUJ5yPWZBvqMHDM08Ax0usTiNQt9kT2DdqTeWdnjWAkm89nFHcpLNvL0yV9+GFNEVoE+Hu9qaNUkwoOIqHc=
Received: from BN9PR03CA0437.namprd03.prod.outlook.com (2603:10b6:408:113::22)
 by PH8PR12MB7205.namprd12.prod.outlook.com (2603:10b6:510:227::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Tue, 9 May
 2023 22:07:30 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::ea) by BN9PR03CA0437.outlook.office365.com
 (2603:10b6:408:113::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:07:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:07:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/12] drm/amd/pm: Update hw mon attributes for GC version
 9.4.3
Date: Tue, 9 May 2023 18:07:09 -0400
Message-ID: <20230509220714.475369-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220714.475369-1-alexander.deucher@amd.com>
References: <20230509220714.475369-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|PH8PR12MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: e4221f28-abf5-44ae-91e3-08db50d9c89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKC5ZpAhbv/8W+EL2v4TqhXeM3dT8R24GTf1S+r31cqd1nL0U5gDstIbd0AUFxseRxdP/Nnk5d4rKtzQmPb7lu3Wj5g4E/0nYm5C2zY6KawfXpEqkxu1ON5g1E5a6fM+wHu5JSaek2oxelSY+WejbiLtooYWQj8QdEuYu8GnZcHYK7RodiKeTjuR1EQE7AN69jmwLasjBqNcIIn8MAGgvP/uOnAu0atiDyl5olC8EX+n4hq8lXvoVDF4NDKpMH0P57qbLyA1gH5l3i/yIW+Y7yWo7HCZ2GOJK7PpWE637A2f2HTnDat6B7VubNCy36Mxbzy1/uIBUhhNvUvFlbh84M4LGFFsCdOfy3CmXDZ1+GmL4a6u36mYKB6yrVpD+wnbsTKII1Z97swFW/TDdzh7Ut0f61KPknroAX3gTvJaA+F9SEs8chi821t2rbpgYyd8z/NCyYffKzEia728SyeOJ/LckUIOaDsmGd3S193NXP5ezMI/jFlUQFAlkmf1qIkDBDmYXYpMGXcTeeHblIZHhqxfm1UzEnX2ThT/VCFXiO/XrxPVZotEXeVVOWResfOFexnuxKf3+sJ/C7C79kmViKU3JD3n1nYeLRFIE6FruVXtfp/0E5aSjjW7gudDibXPTBHWEbGaYnU8WFkXBHBLhwQB57EVe8Gy4K1ewUK6Q1EpN/xrDVVQ3b9p4N60Km/aLEvWX6x1a3cyaXi8744KrAfSqwHq5jIjpFGe7Ua6PNM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(70206006)(70586007)(356005)(26005)(36756003)(186003)(16526019)(8936002)(8676002)(41300700001)(1076003)(81166007)(7696005)(6666004)(82310400005)(5660300002)(6916009)(316002)(83380400001)(15650500001)(4326008)(478600001)(36860700001)(40460700003)(82740400003)(2906002)(54906003)(40480700001)(336012)(426003)(47076005)(86362001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:07:30.6417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4221f28-abf5-44ae-91e3-08db50d9c89c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Asad Kamal <asad.kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Asad Kamal <asad.kamal@amd.com>

Update hw mon attributes for GC Version 9.4.3 to valid ones
on APU and Non APU systems

v2: Group checks along existing one
Added power limit & mclock for gc version 9.4.3

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 36 +++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 58c2246918fd..385d83eb8706 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3362,7 +3362,8 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		return 0;
 
 	/* Skip crit temp on APU */
-	if ((adev->flags & AMD_IS_APU) && (adev->family >= AMDGPU_FAMILY_CZ) &&
+	if ((((adev->flags & AMD_IS_APU) && (adev->family >= AMDGPU_FAMILY_CZ)) ||
+	    (gc_ver == IP_VERSION(9, 4, 3))) &&
 	    (attr == &sensor_dev_attr_temp1_crit.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp1_crit_hyst.dev_attr.attr))
 		return 0;
@@ -3395,9 +3396,10 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	      attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* can't manage state */
 		effective_mode &= ~S_IWUSR;
 
-	/* In the case of APUs, this is only implemented on Vangogh */
+	/* not implemented yet for APUs other than GC 10.3.1 (vangogh) and 9.4.3 */
 	if (((adev->family == AMDGPU_FAMILY_SI) ||
-	     ((adev->flags & AMD_IS_APU) && (gc_ver != IP_VERSION(10, 3, 1)))) &&
+	     ((adev->flags & AMD_IS_APU) && (gc_ver != IP_VERSION(10, 3, 1)) &&
+	      (gc_ver != IP_VERSION(9, 4, 3)))) &&
 	    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr ||
@@ -3426,25 +3428,39 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		return 0;
 
 	if ((adev->family == AMDGPU_FAMILY_SI ||	/* not implemented yet */
-	     adev->family == AMDGPU_FAMILY_KV) &&	/* not implemented yet */
+	     adev->family == AMDGPU_FAMILY_KV ||	/* not implemented yet */
+	     (gc_ver == IP_VERSION(9, 4, 3))) &&
 	    (attr == &sensor_dev_attr_in0_input.dev_attr.attr ||
 	     attr == &sensor_dev_attr_in0_label.dev_attr.attr))
 		return 0;
 
-	/* only APUs have vddnb */
-	if (!(adev->flags & AMD_IS_APU) &&
+	/* only APUs other than gc 9,4,3 have vddnb */
+	if ((!(adev->flags & AMD_IS_APU) || (gc_ver == IP_VERSION(9, 4, 3))) &&
 	    (attr == &sensor_dev_attr_in1_input.dev_attr.attr ||
 	     attr == &sensor_dev_attr_in1_label.dev_attr.attr))
 		return 0;
 
-	/* no mclk on APUs */
-	if ((adev->flags & AMD_IS_APU) &&
+	/* no mclk on APUs other than gc 9,4,3*/
+	if (((adev->flags & AMD_IS_APU) && (gc_ver != IP_VERSION(9, 4, 3))) &&
 	    (attr == &sensor_dev_attr_freq2_input.dev_attr.attr ||
 	     attr == &sensor_dev_attr_freq2_label.dev_attr.attr))
 		return 0;
 
-	/* only SOC15 dGPUs support hotspot and mem temperatures */
 	if (((adev->flags & AMD_IS_APU) || gc_ver < IP_VERSION(9, 0, 0)) &&
+	    (gc_ver != IP_VERSION(9, 4, 3)) &&
+	    (attr == &sensor_dev_attr_temp2_input.dev_attr.attr ||
+	     attr == &sensor_dev_attr_temp2_label.dev_attr.attr))
+		return 0;
+
+	/* Only hotspot temperature for gc 9,4,3*/
+	if ((gc_ver == IP_VERSION(9, 4, 3)) &&
+	    (attr == &sensor_dev_attr_temp1_input.dev_attr.attr ||
+	     attr == &sensor_dev_attr_temp1_label.dev_attr.attr))
+		return 0;
+
+	/* only SOC15 dGPUs support hotspot and mem temperatures */
+	if (((adev->flags & AMD_IS_APU) || gc_ver < IP_VERSION(9, 0, 0) ||
+	    (gc_ver == IP_VERSION(9, 4, 3))) &&
 	    (attr == &sensor_dev_attr_temp2_crit.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp2_crit_hyst.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp3_crit.dev_attr.attr ||
@@ -3452,9 +3468,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	     attr == &sensor_dev_attr_temp1_emergency.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp2_emergency.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp3_emergency.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp2_input.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp3_input.dev_attr.attr ||
-	     attr == &sensor_dev_attr_temp2_label.dev_attr.attr ||
 	     attr == &sensor_dev_attr_temp3_label.dev_attr.attr))
 		return 0;
 
-- 
2.40.1

