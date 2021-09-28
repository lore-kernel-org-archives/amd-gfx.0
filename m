Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AAAC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C636101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C9C636101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A0C46E8D5;
	Tue, 28 Sep 2021 16:45:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24E036E8D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:45:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xi5S8tu1I/R7UeLK8hdVrnpeYBoU8aHWIysCCy5kjrrOpGXecvoPANIH0918IXwlY26f9EhIjgLm+nuhwLVwKk6qtL9aGQZG3Lw0lUvb59j86MRgHOqiuyKz4ZgxdoeF8CbafqAJqMSW0rNjT+ZIdTJLSUF0H5cUEOO8cDqRtL1xL8hsOTsTLLA4HlQ0takfvGTTJfrgwYiBShSd7k4zmUmwBWzRcyUEuOUH+J5xoYSCJgSUS5Ib3DthrjRS2FZl/x0BlmRk8b/yR2ADtnbyfRWdNU9i3bcOB8x6ihjGPS26fAI118axoAQ2FKSBXicGyGVUGA41cgB65XzHTocEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=e37LYt70JsAMfAL0FLOuyJzV+ta0gYBQ/rqS41ufaG0=;
 b=EjE7HuKuKgjtGEDf7WFZjeGvbX+lHsh3mLNAVpYQ8XWxNyPkPGwBbnVQe4POxObIntIkr150anYHQoT3nvdw6GBtYID0AETPQEVYz6CDlJmFq4EB8ye7StvVCyYssptgcuBSIBiifIfOYFuTdnLQISlay/M1KIPOoWKgTQbLpdzYeCKHg/hFNx9zH+3vNcjY810roIEMGV9FkSmw5f9IdVFe0mjI6PbyUu4tX/mJBNh615r1tbIehYHNVG9lvGw0GX2KnHg6Z8v4wsUXmihOFuV/miglTjMdRp7BKKhl4G/gJgkXGrIWkIKmcwfvW3WCYmlXNbX153qt9vT3d5pMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e37LYt70JsAMfAL0FLOuyJzV+ta0gYBQ/rqS41ufaG0=;
 b=FK2pZLd5hfjK1WkktIzCKtn7rG6zsKq4VpFKRdMjzFFCoI0avobL3/xpbDdbyVpRUZ4Gh3dfP5lUmoi7rDY0TKpBU0x3eNob4WJ9Cmewy1vBMyLZlqCKPVDU3bL+d0APNF9lZSaLDT4IrS/GwEUniDSrxLLRcZNWogDPfyNY0Y4=
Received: from DM5PR22CA0021.namprd22.prod.outlook.com (2603:10b6:3:101::31)
 by DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.18; Tue, 28 Sep 2021 16:45:04 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::cc) by DM5PR22CA0021.outlook.office365.com
 (2603:10b6:3:101::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:45:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:44:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 34/64] drm/amdgpu: drive all vega asics from the IP discovery
 table
Date: Tue, 28 Sep 2021 12:42:07 -0400
Message-ID: <20210928164237.833132-35-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a80891d0-502c-4925-cbe1-08d9829f5235
X-MS-TrafficTypeDiagnostic: DM5PR12MB1657:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1657025FEA395E772BF503A3F7A89@DM5PR12MB1657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YTZPeRHwvLpwT47fNQ7/Vtp3mGvw6OG0DGP93POcQF0be+FIAdJ865P1jNbvUu96WA/FVc9vOT2n5fUs5BDpznEFq2bZn+ajhtN3SAYfhDGV5vB9eJLbWModz74LdYX+pSFLjW9YfsylMw5+ZTSf8JnC0SnnTIBaFCBzuHWrV9Tc6tQC21O/+mogmwLivnnJiTwpU5l0NIdYMxFXyJIq+1IOgjaOtIeQ2ERLgRSt/NqrcsRaW903K+XqHU8hJ6ZBK6zJ2cl6B3YCUYsRQuqoRFjGUCZpvNx7QgBomTRp2u75Rw4XBu0xInZs9XRGWUp3q9BGJuhiPL0c8oaQWcDfqMAhxBo5I3lTvKph48u8p+Jm2iDNpS5OQ09K+pHH/2LS80kgWQJ5XAqDDNljJXnAeuReEknscqgKC0fWYVPrw2SJL1dIxDgtKeJu35nFP+vNbbfWS/5HvQ2fwYSffWMMmLs0yCPaXaV5J3hyGZ8Skx/JEduIJppZj+Oshl8tJBpVjvg2oOUcmMEcernrN8ohlP9p8CdTuJBOx6xrXZo2hWoMU9RMaRVy0vrhNFaVnst9/qFm+sB2XCECG89BZE8ZlbccDr66CfsboM7eR8OiGJl4H1LIMP98mtqyTzrlZwIOTqqiOFjKyXKXgcpKrEPpOSQvzzx295AemQ0dnqCf3TGXJmkcZP0hBHGomufGmZQdYkOCWXuBGBA7EXwdjUxjrn7aZhgqO5xGinYYeFQ7DwQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(186003)(70586007)(1076003)(8936002)(508600001)(356005)(7696005)(86362001)(2616005)(16526019)(70206006)(54906003)(426003)(36756003)(26005)(4326008)(316002)(8676002)(6916009)(82310400003)(336012)(81166007)(2906002)(83380400001)(47076005)(6666004)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:45:03.9514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a80891d0-502c-4925-cbe1-08d9829f5235
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1657
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

Rather than hardcoding based on asic_type, use the IP
discovery table to configure the driver.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9c47cc636429..a4da9ea9d07a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2126,22 +2126,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		if (r)
 			return r;
 		break;
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-	case CHIP_RAVEN:
-	case CHIP_ARCTURUS:
-	case CHIP_RENOIR:
-	case CHIP_ALDEBARAN:
-		if (adev->flags & AMD_IS_APU)
-			adev->family = AMDGPU_FAMILY_RV;
-		else
-			adev->family = AMDGPU_FAMILY_AI;
-
-		r = soc15_set_ip_blocks(adev);
-		if (r)
-			return r;
-		break;
 	default:
 		r = amdgpu_discovery_set_ip_blocks(adev);
 		if (r)
-- 
2.31.1

