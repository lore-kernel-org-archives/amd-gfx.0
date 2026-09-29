Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C510C9832A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 03:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD9810EC95;
	Tue, 29 Sep 2026 03:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ijMhoZQW";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010044.outbound.protection.outlook.com
 [40.93.198.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA7D610EC8A
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 03:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnC1uUcCNhOXWa1UQcoa1PUPs+4PuKtwuc+Dp+8d1OhGe/HYA7p2XpNmi2aKXWBZtwwSDqvfFnnu+pch0/boRNHp39M0uyPPFNX8SDPAzuhcMxD/8VD6o8hNK1b5S+M0PvR6JWlY0dC7frfbKu9Cx0Lut+ZmOTlHsgz81lhpRgr/zLSDbWd+FUQ69qJIlH/FwqH/91ef6v6ANs+D1p5v5etbq+59BIL3VrCzhecHO8SoToOrwR4KFEbiyIFEQYAkNfO3tB0Diq2STaSquyaQvV5GQUi0IPatSLotY94CDiEVtF4r8WEqMIOKl8N0u7HIB4iZS5RAvm8Di8B06Qh+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMQqcNMzRSiY7dK0iYcXqE86pUuyofyL196Ad63BIPg=;
 b=o2M2v/oNc2ItXtoCuA2qSmUU8ws9Rro3/CDr5pYXjZ0epJJUSFUOPqgNVQYZ5eyR14E+U4s5wMvArBPMG9lvVNebTbz0mBPxAiNlrY7D3PgM559k+M3e77v71qmthhFroj4z18ghq3YhgT/gsFS5ln6/CoCEMv5AlsLB+8ZZ8OHWkWV9yfeslNkwxawSluPxBB6kqvAyplG6t/VlKUsQExZQoKwvZRhfqhE3EAKBQ5YxhpDc0W40yoyOuFtqa4qBzkv2RTetB5lwe19TL3p+k26wvcKoZa21bkBtq3vT/gYT0OJX0fk6haQHDS/XVtYtE11RCoQomFAymNTT3fqmDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMQqcNMzRSiY7dK0iYcXqE86pUuyofyL196Ad63BIPg=;
 b=ijMhoZQWybfYOC0vzlr0SF5vSAFyzAm3jpQEeqKyRVCQ8XoINl+ceAy5fhoUx5sH0m6Xv+6iegJZUtdlqhpXf1WplCGX24wjqTYZzn1hiCnXFn5DFX5orxt0MhHyVqZXGzb9rqbt+kB0GFQ0TYcC8l26Do6cVZ0UWMGXvc+/nBU=
Received: from CH2PR15CA0020.namprd15.prod.outlook.com (2603:10b6:610:51::30)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 03:47:02 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::32) by CH2PR15CA0020.outlook.office365.com
 (2603:10b6:610:51::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Tue,
 29 Sep 2026 03:47:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 03:47:02 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 22:47:00 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 02/14] drm/amdgpu: skip VKMS mode-config helpers during GPU
 reset
Date: Tue, 29 Sep 2026 11:46:38 +0800
Message-ID: <20260929034650.2393125-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929034650.2393125-1-Prike.Liang@amd.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec3ae6a-68eb-4f71-66e3-08df1ddc5296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: T37iLvSsXs6RnOGTysqwhH+AbT3MF1dHlTCvY+gxAY30MbBIQmiQCf7MdX16N3euFkfyN6fOFtSZ8d6ms3q4O74VNuVlf5JErB7OK0WR3K5oMq+M3LLDxHmpwL6/ywyqKBblzJulAE6Kl2h4BpyRd0QiOX+jHbDVAY9Mh3uzbpqzTAFE6hpRVD1WkWK08WkZMcfIOIkJ8Skw86z+jAfvATWTdzK5SeT89m3fx4mbONxslYXPbbeeq1GacM+vLZTQ9p22JUvnF5YdK0jJ4Mp1Nqfcn4hWGxdPMugkoxSA1GrjPl1cJQ6d66pRihdZtehKM9avdtMLOqB4e9nSlKu7ZgK5ZdTZJAcNWhKT1lTlcvp029fZpnlb5H2n0Hns9WNT4FVsORf2fYc2ypsmZGpyuShmhqryxmBqAPpKUYfdSk0LTiOvdSoXQVs9zaQnBkXIXBzhrKvDaTxniNsdHtM2NfRiz6aUB3WMUqF+r5xftJMiiOXOjP3xo0ZEzufcfD0C4lZ+6cjEceaDDPz8fNCq930ALnR+usGqxsWkTXbn4ivOZRql2ovc8EX2+I5QR1Och5hYYKBYIKRIz7RE+jju/mtqVraBoY9ylf+bXwEfEB1OE2xCJmzWyFfzjCuhxr3JY5TvUyfTavzbRiS3nhd3buiBwXBsiyy/+IPvlJRE1NB+rG7P6iOGHEU7b2Qk1+lNRoUe+aMk31BMGWDpFxMUjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mVgr3yidp/6rqKJOYkZjNOCvqK8qGG//zVl7HZUELRJxMXhdqzQ/Bf8DufSbJRI3HlzXSse9T29NilLW5fEQorQbBykEmlYWTB8QV+J8f7BKJtVEmyWApC3onZr9Q52+vadQAPfHRD7v0VHqpc78qCnMe7QMG9S4oYVwgc7oRHg6IHzLK4WfcWJlXMH6HVCTJSTuqcgjpL74tJ7kcL3RG0+eldG6q1LKa0zo9fI8RRJnyLbEW+zJe2KM1K679DO0ulpnB/INNORRWqONWlTdMgzBJuqHaVCQ3b4h5jM0XsQbEjRwlc9Z/TGMBLB280IgcAUotzyOHicv9MBP4k5HYzGFYUC5iPFgGDsIdiFvsSl/ndUqf7mDxYYgwLFvcQTRbnxx6/ljhboG0rAgukFiu/ECHwcyk+EDquHIZVt7Bvyg0rPcOO1KBZQRZ7/7pZ+Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 03:47:02.5086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec3ae6a-68eb-4f71-66e3-08df1ddc5296
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853
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

GPU recovery already notifies DRM clients. Skip the VKMS mode-config
suspend/resume helpers during that internal reset to avoid duplicate
client notification and atomic-state handling under the reset lock.
Keep ordinary system suspend and resume unchanged.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index d6b51b3f216b..a49c7dda4c4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -491,6 +491,9 @@ static int amdgpu_vkms_suspend(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	if (amdgpu_in_reset(adev))
+		return 0;
+
 	r = drm_mode_config_helper_suspend(adev_to_drm(adev));
 	if (r)
 		return r;
@@ -505,6 +508,9 @@ static int amdgpu_vkms_resume(struct amdgpu_ip_block *ip_block)
 	r = amdgpu_vkms_hw_init(ip_block);
 	if (r)
 		return r;
+	if (amdgpu_in_reset(ip_block->adev))
+		return 0;
+
 	return drm_mode_config_helper_resume(adev_to_drm(ip_block->adev));
 }
 
-- 
2.34.1

