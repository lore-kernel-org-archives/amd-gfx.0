Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FD0C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 14:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F9510FF11;
	Fri, 19 Apr 2024 14:02:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PAwRyEQP";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D7EE10FF11
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 14:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtTUBS3cHn5h0GW11wSFUALyC+FoQdCaoDPVS2/blVjjgMV9diyr9TomKh5w65mspDl+9sVVoFxuqSaR1Le29ldiwalaf3367yCFxWCZ5E8UyhT4MAtranF/33KnPuxOgC0JHJ/SdY/h57Q8cFVZf4ipQgp5HZw3jMLDS4F9tqiJv8VGf0ir3fAXdbQXWTspYwkYIttMOMyYa0puu2Qjekbli8NtaTvtyWJ3tS40FgluoXeltA2DqCIumj3wNagOP9zOcSjrJnCSrTydE496mcPwmFbaaZbZ8xbEnOXBejBsA2JKoVMUXZn0v/H0lw4uN9KgcN92w0Sj6BW0ZBa9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmPEfG3qVyzyTkNU05zzboK1Lq3AJM4kcNRFfR2HuTA=;
 b=H0zwVnktqSv7tVDL3ueHC44+lQz3HxQ7TiMshG6MTJ+W3qXOb6krwMzwb8E+yGjQ0kGGOAFacoAf2nvG/BerWR/1tBEq7wD4kV8UjTiBjKKo6zdr3wuttGDfajzCXbWPUL4SCpxXUsFAZB/qFO8771utOWdjwyowKhgZLdlrB2kADdoe551tpYbRqQfh6MF9uNpR2Lz5GnmUSzT3t54rCw8w7uET1Ye+bNL7U0y3COtYOjnm4MRzSRW1A4EhU81y7cV5dsd1ExV6Br9W40Mea5QLbHOAY051xaxyaUswIo5xWjvCyr6KUeeZhUA4DkiBwd7Nbx4o2S2nX3jeeFlVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmPEfG3qVyzyTkNU05zzboK1Lq3AJM4kcNRFfR2HuTA=;
 b=PAwRyEQPIDVnbnF76LxXwr26eYAkfSpVdPuHTY6EMf5xLhyUUtiprLZQzHeJBQ4pUDiwx4+BMzKXdoX36/TJVxnw7I5znYk2ndCpP5Pgs1rImnw0P+IWMmXzp0aPSLhrVwrypZcLl/5uBpGAu3sh59IxU7SshJ5RE7DqsuWmaP4=
Received: from CH5P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::24)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Fri, 19 Apr
 2024 14:01:43 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::19) by CH5P220CA0012.outlook.office365.com
 (2603:10b6:610:1ef::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.31 via Frontend
 Transport; Fri, 19 Apr 2024 14:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 14:01:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 09:01:37 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: demote unsupported device messages to dev_info
Date: Fri, 19 Apr 2024 10:01:24 -0400
Message-ID: <20240419140124.1900789-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d637138-24cf-45a9-f6c5-08dc60793e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGJRHETPznixkLyuVCJDxBOk4CJP4SYus7BrJ4Ys8mx0dAnzWb5QTga7pGZt6+2HPQ6xwyWOdwODPTsu/H2i7C/wO1/Tkx3tbeCW5LFoVRG6i9WAi99/AM7Odt69eIewH51K9FtWg8OXWvZxHA95cCQcND/LN/P1hTHjkcgpVzL0uL2rBkC7X0BIQt0LOhycxVI8e+xiziLL3vUHpvLllVzbwsfHEfftjXPx8py93s+2GcNSlO+MM/VuSbj1pWDDWtR2DB+mYzcLDFq6vekakb759DC1Ixdf7jp08gNBd2TcxKmeSbuy6hrwqvWnDoLkhbDuxytbQw82+Tnm1ZZ5VTo6vfW+qmpwPPWTOUhX42N9p5BGKHxukLvOLJC7aijlh7fRdsvYNgZBODwTrEbarPwbgwvw24YjnJHJ6ZcCpCyNCTSCmDs2GidLtybF259D5Zelqq6svxLaqgtFIou7lSivcEHWJsxc/K9PLkruSuS8ItmIb8UQgACBMZocU8eK5xhbLoAqFFFus+1v8yxznhJK0ZEovEqoXHCWXE/6Ry7lFpLktJ/nEyXljK1+NJ5K8waf6lo+7lw68Hhcru5JlMSTn9vnE/nbGM0zZpljuWR0urxrjkVqJsQhRvxm0vmoWJN9WqfXlaunsjMHQRZgUQ1PItDoRcF9tQjw6ZbE6f7I9crsywvPUJZBvss3k5+CUlDhtFYDax+VjGP8pQvheQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:01:43.1975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d637138-24cf-45a9-f6c5-08dc60793e5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309
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

It's not really an error since the devices don't support
the necessary hardware functionality.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3331
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 719d6d365e150..9596bca572129 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -435,12 +435,12 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 
 	if (!f2g) {
 		if (amdgpu_ip_version(adev, GC_HWIP, 0))
-			dev_err(kfd_device,
+			dev_info(kfd_device,
 				"GC IP %06x %s not supported in kfd\n",
 				amdgpu_ip_version(adev, GC_HWIP, 0),
 				vf ? "VF" : "");
 		else
-			dev_err(kfd_device, "%s %s not supported in kfd\n",
+			dev_info(kfd_device, "%s %s not supported in kfd\n",
 				amdgpu_asic_name[adev->asic_type], vf ? "VF" : "");
 		return NULL;
 	}
-- 
2.44.0

