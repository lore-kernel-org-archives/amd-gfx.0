Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A386C0015E
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 19:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C79DD10E49B;
	Wed,  9 Aug 2023 19:10:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1CF110E0DE
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 19:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8T1DpGw6lnURGsQN35/ydOUPcgos5pcBbRmi191aqK1P+vc3yNjkZFD/a4+9wJPf/c768//fLAThg7oIxIe9r9rAg2VjqVJ8TQ3akoYEDMUimZfBwg5wpMn6Z/Yivs+BMjUreyiTqp32e0EWRGqaqXgCTyjPNHRzNInzX31s9GQzDcuj2hkab782sJT0Mqk/qkZgWnnLnQaNczM+10d4FyfGKXbf7sInoePNEGItTCq8XkNi91L9xGaMijjIXDreZD+w6dHyobMdd0DK6hgB+ygFZcckYDgJ1QALKUpwzOkieYlJK68cb/nh7kcpr93LixxvitaAJPMqGcilMQjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvmTZYqggKZKBPMDEDGyRMxImmn8WL7CZWcOMvw5WCY=;
 b=QAkUkMFCE2kZOornTGlyD2dPbWamccW3lCWhLW8lvKd8cVRPSWrG1ctxSrOqLJh07pzhasYxwfrf6dD7K7jJObtu7kA3XpCF8mmzxZ/ZdgqiMXgTuj/YuAmL63YaAOYhsCpddY3pEgFYoMaVTn6Gmb3HdMIDvJekBX6MaO6JZIAXYdgudhkxTrQryzMq1+GCYupxAr3/jAzFn3yhJVUvLrvEsEl7di2YH55AB+/AQ/jv0/W4PN+T/Yz2CnhpjibtCi9Roaz0DtU/m9gQubGO3VrTniL76HAr6STBMOkSrIgjcZnXe5DV50kP/6LXdPnBRbB+CyZjZLmZNighvwPvyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvmTZYqggKZKBPMDEDGyRMxImmn8WL7CZWcOMvw5WCY=;
 b=Y+FhWvoXMBW/zoGfXBMqEjU1zXqcHhggLbAwAvpleahrPffWyGLLx8qSXK8CatzqKH+hkyQ4RT1izISvARWKGkohcl7NM6AOrLp+w5nx8wsIPUQLV0NFmkQFEjnIlbSgEySnoLl9gSVzC/HQlaKpEowQyWAlT5AtN17+DJGoeVQ=
Received: from DS7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::15) by
 SA3PR12MB7921.namprd12.prod.outlook.com (2603:10b6:806:320::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 19:10:19 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::a9) by DS7P222CA0012.outlook.office365.com
 (2603:10b6:8:2e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 19:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 19:10:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 14:10:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amd/pm: resolve reboot exception for si oland"
Date: Wed, 9 Aug 2023 15:09:56 -0400
Message-ID: <20230809190956.435068-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809190956.435068-1-alexander.deucher@amd.com>
References: <20230809190956.435068-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|SA3PR12MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: f61ba614-e38d-451a-d147-08db990c4599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: il8cPD9+v3W4dOzeVXyqv1pdSfWHH5Z+9PVpVLjDBFCaHd5xDZwKmoLIyGZgwcVP6JPvgfjfEpD8hzuTESxu0ooc35maRnGZ5FF3tFJ8g/x+j5sFnTv7zGKOEwZkrzsr2KE3b2CVYzVPk/+gh06GnCrbf2grLiu5R0XHHEIHFHKdLACUpqM7oFF3uNSCcuFmtp2P2nlFbPP46aQjz7Cg5PwG3Ev3FDUz3CbjKDbEaQZEg6bwVq5v615BVlBkz6nzZQDkgM23cO6JxNjq+4YqSe8UUTTnY2fMaGvcm+Qu2ifkOh/rM2954pCu6OX2QLso9WpxQRMJSsb0qFLcnSJ8FBeZnHlHSRDraSCNpyFizLhfG8yXYALjLKoacyl3tqeZWbjX6JoBp9D/Na5MbgNJtS88IW2obaFEvqqmZM73449W0joLJKfYae57IqvxU8AZew28dLV1EYrMOv7/24mJK5L/W+Ctdq0MBmnwZ0lYBX7qMq3imgXLPM05xKzKSCPXCl/8z/qfRPhyWZP9Mf1H5DTyn5DUNqS+I2bwW9K1d7Wck6w68c2Tf9X73sJ1Jd65IUJFq9+AxBsnTWQvUjxkOctfC3G6oUXFa8y44gv4pzJ2UdfBHUtZSsce9/rCuWk+H3HhQKybw4e7U0wUdvRZ1vMGE7uI/8v0UWtz36IFdSY1xdwszvQZR39WuFZS55lDApcqyd6NdoGVOJifrkGX9THusr3y+42OMuAXeTZeNLJTh/YcJ9vN3Vk3rr44HrP5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(1800799006)(186006)(82310400008)(46966006)(36840700001)(40470700004)(41300700001)(2906002)(8936002)(8676002)(316002)(5660300002)(40460700003)(86362001)(40480700001)(36756003)(82740400003)(356005)(6666004)(2616005)(81166007)(426003)(1076003)(26005)(966005)(336012)(7696005)(16526019)(36860700001)(4326008)(70586007)(70206006)(83380400001)(6916009)(478600001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:10:18.8172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f61ba614-e38d-451a-d147-08db990c4599
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7921
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit e490d60a2f76bff636c68ce4fe34c1b6c34bbd86.

This causes hangs on SI when DC is enabled.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2755
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 02e69ccff3ba..d6d9e3b1b2c0 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -6925,6 +6925,23 @@ static int si_dpm_enable(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int si_set_temperature_range(struct amdgpu_device *adev)
+{
+	int ret;
+
+	ret = si_thermal_enable_alert(adev, false);
+	if (ret)
+		return ret;
+	ret = si_thermal_set_temperature_range(adev, R600_TEMP_RANGE_MIN, R600_TEMP_RANGE_MAX);
+	if (ret)
+		return ret;
+	ret = si_thermal_enable_alert(adev, true);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
 static void si_dpm_disable(struct amdgpu_device *adev)
 {
 	struct rv7xx_power_info *pi = rv770_get_pi(adev);
@@ -7609,6 +7626,18 @@ static int si_dpm_process_interrupt(struct amdgpu_device *adev,
 
 static int si_dpm_late_init(void *handle)
 {
+	int ret;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	if (!adev->pm.dpm_enabled)
+		return 0;
+
+	ret = si_set_temperature_range(adev);
+	if (ret)
+		return ret;
+#if 0 //TODO ?
+	si_dpm_powergate_uvd(adev, true);
+#endif
 	return 0;
 }
 
-- 
2.41.0

