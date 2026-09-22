Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7800AC982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 14:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CAE110ED6F;
	Tue, 22 Sep 2026 14:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RmdOpNVo";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3188210ED3E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 14:57:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcIPCjqRvoDr+HIlEwf9qh0z+6guFi/Z7j3T1SfBywXq8D1FOfKLSriDUutN//g4KXYGUdhVG3rtwaFn5TZPYw+PU+eMWQg73tWh7DAjeycpZNbVsWQSe0Er9EljErAbWG19V2KEAHBEy9Nlj0+NtkQGKWZj6QZaL0gZW15miL9JNkFpzVauJylmpgurFxsFh9HGI/yAvarYTpA5fpk90/Prk3WMOVSPYBnpwFn8e6f5JwlnteMKumMPTMdjN64OuPwcpr5J4BcvqaRO/tQTHk8JMPN3zGMkA1yJKXvFXKx92FFQnWJEcAtS4drlylLqO6RkzBEZnhSb9+BOFz+GPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE1b7kEBpPLusg22lBvIoMzhss3wVdLzH/Agh8L96ls=;
 b=NVST90aGys1LAh6J7buoZSokaxuybvZ9/KkWyP4iCcnMt4f6DwbkvuuW0rWLpdGnUJc8Oym+7NtbEwjVcWRHW5qpqzMzWuQFuKYQqYTnRgHsmJ9FknfiOac3dXi3/ZJLjgT5nJujAbu64e6rhfqfm2b1G1gqVaSYAFoz12kAkN+2KtvvANhltft4q/S+2m0Hxds5MbT2dIHh929f+IovcYXd0eQxo9ALMqIIfT9qAYSqKIfQw/Qxg2ZlWn4K1qV6Og63gMD+ZyDfOUPNDE0EPdWxBF72SjsGxMhFjegoomXPLCQRY0i63LEJbeaPRqJJtkTVWVpcPXREk4NvaEUSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE1b7kEBpPLusg22lBvIoMzhss3wVdLzH/Agh8L96ls=;
 b=RmdOpNVouvMKvaPTsWCPraE5EGSUAAPhysZOEqOKD8RqUGCFfl7CGfe6PMgBo0XDGMJGilb7BCbi3O436K+9jplXas7h/PbUAc4TF6wh6/PsLyIXRrNc73kjFCU2RhbTbib72nibiqLuUgARS7NoZAjbKg6O35N9ZsdPFAES4JY=
Received: from CY5PR04CA0026.namprd04.prod.outlook.com (2603:10b6:930:1e::21)
 by MW4PR12MB7287.namprd12.prod.outlook.com (2603:10b6:303:22c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 14:57:06 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:930:1e:cafe::3d) by CY5PR04CA0026.outlook.office365.com
 (2603:10b6:930:1e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 14:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 14:57:06 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 09:57:05 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Sashiko-bot
 <sashiko-bot@kernel.org>
Subject: [PATCH 1/3] drm/amdgpu: Reject UALink handle ioctl on devices without
 UALink
Date: Tue, 22 Sep 2026 10:56:51 -0400
Message-ID: <20260922145653.1207241-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|MW4PR12MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0ff84d-e42d-48ca-543d-08df18b9c50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|30052699003|36860700016|82310400026|376014|1800799024|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: jCe+NkZZsXp25yVJ6v/lqYWklWkHQ9YdS/ms4twVVqT9VIJecy7cddqOlmky25Iqn1DA97Z+aKdB/OuLCLJ03O9uDOcLGrhBGfEBc8mtQuKJ2smIruo3xy+8nUUWqlfIiZewGlsZglyADhy2JS5tq5bMLE9OnqnE9BvRZyauwTrV3UHW4NR+V6sU+REBnc3I/ph1sNrVhCGULveZwAbbDd1+N98G0RwB8BWDfvOvrqHDwhXM96OYxH89q9pfd0z36+b9Urc/It7Jx9m9ijrDsdL4jJkA7sRMPak3SqXQ82KmbaKEzaXAsNQK6lbL0fNBcuHmYF9yCfIwBczGiMuSPQRT6lIjpPPLhvt2e4YDL6mP2UhAF3oukYFrq4mTXEbD8x1TZPi0p4SxQOlCnb38GEwdS240ZGZ2GBwE/sK19JLE3CS+NBHBxvp4730t4YV1zNbZ/sdlYwEVtFdIlcWgkXL8emD5Ve68/Q/pQLyLDkbAOwAl4TCOlo/VT4Hgd/dYnFXdIvChf6XD1Z6LvSUuDJbwFJ3S/OsaDdj+lgPZiUsZIG2dBQwdD1jL9rOz4lQteYlPGt9lMZgehpC8wAHF4sPVvojevSFzNn5ZCxUBxQxrqxigfJvC9nCEL3ZdRNDX94wGD/IOwG8J3p3K+bqL4nkRxICS60kJNrta3Avg11O7p/gv8J89b4E0I2x+sQvDktW0vxKsBjm+D4SPBMlgbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(30052699003)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JMF9OgxZez29WSpCZv31ZwC42uq9Z5ShCokquQx3YKs9C2v5DUtS8jjAk8UVi0Bgn26fYuqMmEZh5/kFgkbmWPGN2aLdiBKJe4Bc3Z6LnPa69E+dHpp4K7BYNU6FScQ4PPLsMKxa192mbeJQu3QARBFgtWV0d5fRw+6OsA41RRxi3m4d+Ztd0KQKcqaVtTSkDPLqQfL+Y9wLiApir6Ufr0IONC3arJ2BZtKd42MAEwpPIn7mAimdPdAx/0MShzrramkGcfKAgiyJe2nBPI99qKXPhDl5vyCUH2qoPXGhC1OlU+08jZwkL7Sw6Uxpda5M9JZB90mjDLwN1VUhDeWWJh/db2opTpK6P4BebkKNvclWIPPJNzmOe6LletkYw6lXOKEkYFUYdALbOCoZ5er3dSsUCcAKq5deg5Z8MBdC1FdwaaOnNWnQrJ2/WOqYDLbJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:57:06.2618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0ff84d-e42d-48ca-543d-08df18b9c50d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7287
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

amdgpu_gem_ualink_handle_ioctl() dereferences adev->ualink.info before
validating it, but that structure is only allocated when the UALink IP
block is present, which is currently added only for GFX 12.1 only. The
ioctl is registered for every amdgpu device with DRM_RENDER_ALLOW, so
on any other ASIC a render node user can oops the kernel with a single
call.

Return -EOPNOTSUPP when the UALink software state is absent.

Fixes: 8a8bb5cb0410 ("drm/amdgpu: Add ioctl infra for exporting/importing UALink handles")
Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 8411ea17172f..3d84f5a7a34d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -4072,6 +4072,13 @@ int amdgpu_gem_ualink_handle_ioctl(struct drm_device *dev, void *data,
 	u32 gem_handle;
 	int r, fd = -1;
 
+	/* The ioctl is registered for every amdgpu device, but the UALink
+	 * software state only exists on ASICs that instantiate the UALink IP
+	 * block.
+	 */
+	if (!adev->ualink.info)
+		return -EOPNOTSUPP;
+
 	if (adev->ualink.info->accel_state !=
 	    AMDGPU_UALINK_ACCEL_STATE_ACTIVE) {
 		dev_err(adev->dev,
-- 
2.55.0

