Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95775C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 07:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B6D12B6CC;
	Tue, 11 Jan 2022 07:12:41 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CD4D12B6C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 07:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaIp6M9MIONqZ9Hlu/RQTLDwYFSNBrapB/FoLaRXevsWOKAAc2YoajZ1TT/rnRTpkel5RIDGSbxwQbedDbpQvVw+1/scyhLJDlKjkBCArsFnDc9QFp0anGs6b//L6ZE5Urctmgy3Nktw68X6woLZn3zC5EBB6qUKxpUrxhn9ijWpSkS2xVjNnr2U0HkoBLTfty7HGqYeEWw5FVVYTXpsyGSGUnC3vbyTCsjr0FIvH3Ob93YHvxwJR2mTurZIhS+vcs3Q736PggucpQ0pR9rQ2iLdrkO86SmwQyiaELB8sIHbYj0Nyq64d1gDg2KEQNQSoKzXYpDTwtyZbQ+XdzmAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsqvNioQ1+1IghxaIY22cKeUV2H3u3OuJL3msB4GbbE=;
 b=FUOT/tr+wWD9sAc2GxD7Ya9HLoURz2RI0lLTEO3G7wTIgjpf/3yQ30RZInfpiZaubkMTFCztvd3paim4EAs5We/DoA6uamVeSCcI+ev+KLtHAKqlvvoIyU3YORR+PHsucrI1AiW1oS7xCXTkP4EA1R0sromhpmG6gFpLA78g9e4Wy+r5oRIhwJReaAeh9+sqQiJm7nFACvC/mKrAHR+ziqz4C99W1UxD3TrnB3nXcep4BMzxcPNFefvOxHVbyUVjvwcEorGbkIymg7acn5OgyO1K5c5BvlnLxR14ZTwltVN+gn+HcBQnbEutF0o/6dRxQsIAmNoiagaWHRCcmvQNVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsqvNioQ1+1IghxaIY22cKeUV2H3u3OuJL3msB4GbbE=;
 b=40AqA2VAw65bV1LAxh/p5bztrWEG5d8Bc+yhDrwQoS+dIQIv1cGYnqwartCIyftAjQhNIak7Cfrcp0v9o5r9WSvkEwymuHUHLfZOy56JbfwmMXDTFIH6CJPzBxsL9n9gkcy7q8RkIFUxfa4rSbxhwMCsn8z11lI2CpHm7TVJTMQ=
Received: from MWHPR15CA0068.namprd15.prod.outlook.com (2603:10b6:301:4c::30)
 by DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 07:12:37 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::21) by MWHPR15CA0068.outlook.office365.com
 (2603:10b6:301:4c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Tue, 11 Jan 2022 07:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Tue, 11 Jan 2022 07:12:37 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 11 Jan 2022 01:12:35 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
Date: Tue, 11 Jan 2022 12:42:19 +0530
Message-ID: <20220111071219.5638-1-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5d41fec-52fd-4899-de59-08d9d4d1bf5e
X-MS-TrafficTypeDiagnostic: DM5PR12MB2583:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2583F14EDFD08E44BCE2EF83F8519@DM5PR12MB2583.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cBvrYc5kby/rjrlPkgLE5P/J4FvQ/dfSwBZvziT7F+h6CnhNwYC/omxDjWrBXbzJz2rdaOGRkAZkGrCHSyMviR2Pvj8b6w0/Uj10zDj5MrXOBFkZts6kh/L0f71ttu8hDrjfCzW8C91gG4L8oEevdU5XR2kh57fF9XTV5b48SzCu+JsuRHRqHztnCz19P7Od0MwAaU0GKsTo8A0+1qXnwikdQ9OHk760I6Necpsly6DBs2YXJsfY/mT2GP3yRfFXD6vRdCLkVRWpIj/TpSF2OS/x0Mfu+A8AA5EpASCV9189EovBBwRgOlxyXrJxTKXTjBJwPvgjklC2LAgbIa/UQmftVyhGj+X10LgsyL9B9Gr5lA68QWjWfCnKYTd0a2xUXdiVwXDxtPmCwEB35yHgBSWLVgHIYS1/4lkDSME7xQVVZyKOy7IenhKkjO3nqnjE+7zhn2jE7vTL1+YuksUCsa1ODZphbqHF2vo+tsUPsfWtb/XAfcbQGgBP0fkAjQFhPHBq/U2Uue9jIDZEG0JXS/uAOTBGLIX793vTF87MEl1QHVFQZU1aP6JHJkWjrOvNTF5KijNb8AxObrQ/Q2A+7g1cxsV6pxzTSnu8fVqHkodUd2Zc5RJDJItHNmaq4X9DRo1DdBo5Ai6aO0zC6RbMIW209qxgna/+UjuJanrJqMksNcPbbch0FHr6m1VvUi93iXXvlMByP9U9by27sFZCC5m0xKHgxkXj7GrFvokPoqctHVxnZ+3Y3rfW8RqoI1OkzaGfwzJHHzBkHMOasDfu3JRmMOMODk6cDXmHqi9F3WQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(4326008)(2906002)(82310400004)(36860700001)(5660300002)(336012)(356005)(1076003)(186003)(86362001)(6916009)(16526019)(508600001)(316002)(54906003)(426003)(2616005)(36756003)(6666004)(47076005)(81166007)(8936002)(70586007)(70206006)(7696005)(40460700001)(26005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:12:37.1992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d41fec-52fd-4899-de59-08d9d4d1bf5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2583
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
Cc: alexander.deucher@amd.com, Somalapuram
 Amaranath <Amaranath.Somalapuram@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMDGPURESET uevent added to notify userspace,
collect dump_stack and amdgpu_reset_reg_dumps

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 2ec1ffb36b1f..41a2c37e825f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -529,10 +529,41 @@ nv_asic_reset_method(struct amdgpu_device *adev)
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
+	/* original raven doesn't have full asic reset */
+	if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
+		!(adev->apu_flags & AMD_APU_IS_RAVEN2))
+		return;
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

