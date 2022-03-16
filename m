Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73150C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 06:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BAAE10E59E;
	Wed, 16 Mar 2022 06:54:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4EEF10E59E
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 06:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSHMAz5G6i8mYVTlTBqcl4Ks4+LBfUvxB+sE1Z2u6OFRXH2KMS+2+rNzBgxyjQwMkZjHcau/TvwpxIvBKMcoLARLguYlbqOBIa7vjvPuWW5QT92qXsqCFepqHU6NERzOMXhV4qqF6cgiPe8CnDxSVJ0+MP/QkzUPRKCXt4jcRDKaMzKrHs9VeqrwtU2lt4/rt1hxw0gxhxFaj0Et+DKXMKouI/BxDhcg2vwgTk2Qjn0Jt3VA8ZWBrsk6yBbaC6QUm+kkt+AkclooQm6XxsOuvFx+5h/gF3rprr8+KVbFS8wxc38Jk2nHDYHzXb20JcslnQ1VjyKJBpb6E8RiVbCjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrZPHsHP5jUSQ6U4A6miKgbi6j25w0WWztdF1rI/xGg=;
 b=BaoUD4yN0fXcA7z55HbRhUgN7JipzkSddPW80bKfWlAYiboM6h12lRpBlOYjFGRmZI8IR3F9xX9GHD/E+MIP8sWT7TALAXEVn16TunQqBrAqlshlS36c5up/wEg0fhwB768w+KNcKHT/72Xwli93L4fyrXA0GXBaKy3HNeyh40aEJaBIiUvd9kMbqlbBA+nZPxajdHyqur8ssdlnUAWYC2XFhxHJi6mOlmdxdC/lH0UBuj6yHM8y+Zy2R1mXesDKSCewpT0hWkvEEnZlhtNW9bsbMMX3miBVcNfWkSWLkqRgI9LYQbrDh0L5BWGWVLS0iak+2oeekwVujjIaekjqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrZPHsHP5jUSQ6U4A6miKgbi6j25w0WWztdF1rI/xGg=;
 b=4rTslo7hUSjAQyVyAy5DUCFfBZrkmddQbMqroMz0WoCY9DhOZPC5Yt4smRcUyWwBe8Ka/1mYg7MjwjM03CmYPejS5SRrYAR9+LfiVAefwpeVij2BZ01H44xSC7TnJokepd9W4yD30qW6uVNFvx811q7sFPwrKcgg0HJi2Xf1Zd0=
Received: from DM6PR03CA0057.namprd03.prod.outlook.com (2603:10b6:5:100::34)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 06:53:58 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::49) by DM6PR03CA0057.outlook.office365.com
 (2603:10b6:5:100::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26 via Frontend
 Transport; Wed, 16 Mar 2022 06:53:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 06:53:58 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 16 Mar 2022 01:53:56 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: drop redundant check of harvest info
Date: Wed, 16 Mar 2022 14:53:42 +0800
Message-ID: <20220316065342.1141-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cff4209b-246f-4fd1-91c9-08da0719bf03
X-MS-TrafficTypeDiagnostic: DM4PR12MB5771:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB57718B7BD8D50CBC610E7F6FF1119@DM4PR12MB5771.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TseJsCzkWJ0KN9fRC4pkMKdIWzOhYDmmPzRzvqhbMZyctuQaLiki+SICQ6i/+tBh8pQkpFr8KzKNDqA79c8bPdUp4HKXXyH3YLER/+dVg4Hmi5w9z13NPY3ss9PHfKMF7zxoiWI7mZjg/gS98YDy4ayBjPK7SrXWWh0gLGd1qbJV87SNxYSzPyfvhtAyWE+xG2xBDguBTTsJvfzYiHzaY7c7Fsu7NImaMtWuWiJd0Km29ANuQVgytq6FrytczUlmus9XEsvXCpaimcroLMzTekBaqmA3THObdmhO3RkV/5OJsLJlr1HqFd7VtGgilKB7vu+BIlpQtkgZuKleNCRTIUKsaano6ZxA/ShL9BCg78AH/En167CajGSdTI8dDxAFxvCDqURDFkpAbv7CkN3R4AEj8Rf2eT00Ln59Zjy4CnuCd9NPdY9FJFLhDs63nrK0usswzvRKT0LU3o0KKT/poIeyjvipU3CQo5YPKamQbgR9newSWGms/EEf4BwZAb2ZIoNz00VpNZl4o0Av78l1hxmCgkA6I/BR3hEVjaqiDJRXx94yXhhCq7SFXvBENxPhxEwHiKGXl5J7xfxizWr+hK5r6Mn+YMiaD6X/+7Q0igSi8rreZEMo1HhfFUeVyyXR/eDspjY8npEZY6HXQ9b2/Tgn/BmD13F1NfDy6RwjhR4vAf/98Ep6dVyBRxmc9P7i9CO63vDui9z1OsbzN5mghg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(5660300002)(36860700001)(47076005)(44832011)(2906002)(8676002)(2616005)(6666004)(70206006)(316002)(508600001)(7696005)(110136005)(6636002)(26005)(8936002)(16526019)(336012)(1076003)(186003)(82310400004)(36756003)(4326008)(70586007)(81166007)(356005)(86362001)(40460700003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 06:53:58.5199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cff4209b-246f-4fd1-91c9-08da0719bf03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Harvest bit setting in IP data structure promises this,
so no need to set it explicitly.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index e4fcbb385a62..5a182288391b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1150,13 +1150,6 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 		adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
 		adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
 	}
-	if ((adev->pdev->device == 0x731E &&
-	     (adev->pdev->revision == 0xC6 || adev->pdev->revision == 0xC7)) ||
-	    (adev->pdev->device == 0x7340 && adev->pdev->revision == 0xC9)  ||
-	    (adev->pdev->device == 0x7360 && adev->pdev->revision == 0xC7)) {
-		adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
-		adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
-	}
 }
 
 union gc_info {
-- 
2.17.1

