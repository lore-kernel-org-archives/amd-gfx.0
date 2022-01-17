Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C8DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 06:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F2DE10EE42;
	Mon, 17 Jan 2022 06:34:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F342410EE59
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 06:34:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuV6Lpd7WQgG41+UodSJzaGhe8Bwcs5IIsPotq8MaVOrbFQn1un7o0kkZbG/L6+U3qpqpxxyJRVi4dQ4GXQ+Bn3et+L/pW4FH9fpx5diNJPS7XGZNywoN+68qeJV8vc1jOBAJzYsjUkMkZ0exCH0JFTUoFyqwcJbYwovw8BUTWftw3vUI6JArwq/9FfygWeaDezNkcSViV9HrNWbobzu1I0TqwTroP6KP0qDNGAAuUpzFH5iJjmxcmL+Ju9BTCeUTCftA3bSWzCcvIV15rJAc6/r+C570+VmYIQZ9fym1SRYAaapW7WB9DiAu3j7/XH6m3Lwg2AzGONNdfvDmoBlCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7CF8IjL7IrlZcpBJM6Jclrxh7Ilok0jSGpLxlgk1Is=;
 b=bJXKcXCSZPekLJJ7flotsl9Gxm4HCL6EE6DH3tUeTqdL8SMwaQ+p/LoBrnoxCoY81mbGcVy4+Tsjr/tTG9A4odsZPHK1eFPg2PL5BKNiRhDnfjUoICj9terNkmePzQ/lhHHT2qSvizRRL8ZDiGNXWtihqCd0/5iHTvxJ/ILj8W/ynrvJI89sFoJaHu03mcECXSMCgE+tEngkOVgV1NN8RpwGrBI/z4NWk9UrwMynvPhtFgpUDYdI1UibGe4t6Up6CCG0278UPlYd9MQSmHscszlSb5YiJRA2JjjSRuTaURWjXtRMni5djJEfUfuZG6XHRguPrqbrDSi59WzXyEU+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7CF8IjL7IrlZcpBJM6Jclrxh7Ilok0jSGpLxlgk1Is=;
 b=SsTcsdeBXWRkpkz97BYo7CtHSJUILgGcDpqkB686Vmt8Uc4WVGxKFODNmcHrKumVtcogVr6s2iVC/Y3OgyE2mG4VnFz3+3J+yAnjdiW02puMYwzeYgDrkuGo2gwE8Xx7BpaKps1MQyFm8Katc4+/5vGNVHgoIPL4xgbOOjwn22I=
Received: from DM5PR18CA0057.namprd18.prod.outlook.com (2603:10b6:3:22::19) by
 MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 06:34:05 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::bd) by DM5PR18CA0057.outlook.office365.com
 (2603:10b6:3:22::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Mon, 17 Jan 2022 06:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 06:34:05 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 17 Jan 2022 00:34:02 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
Date: Mon, 17 Jan 2022 12:03:43 +0530
Message-ID: <20220117063343.27896-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86ccbdd4-0a3c-4420-18ef-08d9d9835bcb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4064:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB40646D53A2A921E7FAB53A76F8579@MN2PR12MB4064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+5HqHQGNFI9+W6LSIRfL4LxcqTCZjJfXuy08n8rSxRT4TcYY2B/eypqpGPHXCrnz5u1FjBzw8TPiGVK5PJKhxw3illbghv03XxAyBFGRU2a8hGybPqLKZosiPrzswLdJk1otAnPYrlnwMXpLtaBhEVhMnyNAkdFbCCR5mDO7qc9/uJ4VKUuyLIBru52fKOgeDpR2oBb9XFvXOQvhUJaWCstEL0TUJKgP/6kIGeWdqwYnAgIzcIA40ZpjDK9x8+4vd7KcyYNx7lx7l8q7FWma+wOAqVjFrnypJn7P/9IeL0iftgeg56Dm1xZkM/ItfCwtq+K7tKyUnf5mRvz1breSnDYc9Z8hT+ZAMhAHMWqq/eVkLypYekKc+9sucfSCrtQGF6AVv4JdQxTtRHTYOUlNYJVBaNLepnoBjNZAHiSUx0eiWiAjkfHKR26iE5trjCq1zwLyU6+CL2zU9BkSyRnFKIbUIIaoLWHWuVgpZXm8DQjK8cCUvccHps4bvOBDSY1XA4yVH5o6XyDffYqy6RAxuwGTD3wZBrCq3WNkEnHFqx8QnPAE29YVNhVHKO9Z22oeY69b1LQRo/i8kQWCx+GXlh4XYq3+tyD91tz7Ap1EWTzcIavBd1WZB5Y2eOHlZGsF0cOFCMbOtoXrG4RtUHxBh0TdF2sLENlqi/VgZWj8e6gOY8TJEiJM6x1FZvQwk8ETxPimuTA26hk90jOxsqo4tLCLvaDJckRXfeBfBFj3X7tKR7mjRVRKVSmxTSD3BsAHJtXhCxeMRQsuTaxY97icPJAlOPf5gWsgNbRDHURptk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(81166007)(6666004)(356005)(82310400004)(40460700001)(36860700001)(16526019)(1076003)(426003)(86362001)(6916009)(7696005)(336012)(186003)(2616005)(4326008)(36756003)(2906002)(8936002)(70206006)(47076005)(54906003)(508600001)(26005)(5660300002)(70586007)(83380400001)(8676002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 06:34:05.2522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ccbdd4-0a3c-4420-18ef-08d9d9835bcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
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
Cc: alexander.deucher@amd.com,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 christian.koenig@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMDGPURESET uevent added to notify userspace, collect dump_stack and trace

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2ec1ffb36b1f..b73147ae41fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -529,10 +529,55 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	}
 }
 
+/**
+ * drm_sysfs_reset_event - generate a DRM uevent
+ * @dev: DRM device
+ *
+ * Send a uevent for the DRM device specified by @dev.  Currently we only
+ * set AMDGPURESET=1 in the uevent environment, but this could be expanded to
+ * deal with other types of events.
+ *
+ * Any new uapi should be using the drm_sysfs_connector_status_event()
+ * for uevents on connector status change.
+ */
+void drm_sysfs_reset_event(struct drm_device *dev)
+{
+	char *event_string = "AMDGPURESET=1";
+	char *envp[2] = { event_string, NULL };
+
+	kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
+}
+
+void amdgpu_reset_dumps(struct amdgpu_device *adev)
+{
+	struct drm_device *ddev = adev_to_drm(adev);
+	int r = 0, i;
+
+	/* original raven doesn't have full asic reset */
+	if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
+		!(adev->apu_flags & AMD_APU_IS_RAVEN2))
+		return;
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
+			continue;
+		r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
+
+		if (r)
+			DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
+					adev->ip_blocks[i].version->funcs->name, r);
+	}
+
+	drm_sysfs_reset_event(ddev);
+	dump_stack();
+}
+
 static int nv_asic_reset(struct amdgpu_device *adev)
 {
 	int ret = 0;
 
+	amdgpu_reset_dumps(adev);
 	switch (nv_asic_reset_method(adev)) {
 	case AMD_RESET_METHOD_PCI:
 		dev_info(adev->dev, "PCI reset\n");
-- 
2.25.1

