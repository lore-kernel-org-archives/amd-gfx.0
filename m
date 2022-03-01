Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC9BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 12:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B09ED10EB0B;
	Tue,  1 Mar 2022 12:30:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF5410EB0B
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 12:30:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeiflJ8ECz5IO7W7BE05W2Ti090HhX3ZfF4RQNC2aBnIKT6CuQWnlSmT7Xsp592PBK53m7hGf44xLKVDdmkwkuT2XTFqEJ12s/mAhN+HghweIfaS9YJpQtHmzmskWPjZ0Ywn//zZrd4fr6ynflq3xLOsMtWreFEMUr0ylY2QyxiCOaAAyRKiRs8gMHgM/eb6//9jTB2ESrtnf/pAawCvD4NstRme/RH+tPz8hwFhjq29C+M+WUSUHRZyhRfxe28XQW8rdXW94wXmpNEegdErbEv4vJYMjw/EVsBn4/cRiSkok/oSMhH0qoS6vLhcCGYuwIViNhJuDDcFMBj8j4qh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3CgHIKtwbSi/d/lEnkoNmOUcjM4CKJFewvh8qsWlpc=;
 b=hEGF+i0drJ4tpK1zWgcYZNfw7ktgqB3xJUk7ajO659nWWmRueIALD4bmlThKlW6ACamoEydXTvb2Qsy5u5WWGtC22Dej/DZSh9ErSeGQQNy4RgZ1BZp0WUUCZrLPLnjZFZUtouVZ8kiMTOvWDfnKxuYMrdkNZlVjeCKEGG6XlOUZ6N7p1ACqgHNA754aj7V9d8zUGUQObxJq0A1lwq0kpmrRTeN3ZwtsghYJDgADccg19UXe4HpIN7hsx/nXjgk9UwnRiKhYkniuK8KwlZ0GGOZd+DRtGtFmFH4NsFN6y5jnauxOni0BeFeIu6K3MEZ3VoI+htXX7bkvBMQ0UiK5Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3CgHIKtwbSi/d/lEnkoNmOUcjM4CKJFewvh8qsWlpc=;
 b=lHWkGW1959DrZsFnbm9axevQJ5VsrNBCugOFWMpy4LZePUO0TTKwrWXnvsgYCa1G+hqMgdTveeG/w5v1zViI2NVnv/XsRWJW1oneGs1qDCNL/WQnLVYTzHyw9uHOLVtbU7FiWTaUoUXayv9SZEXRh7IJAd1BWC5Hsh7g7L200EU=
Received: from BN9PR03CA0520.namprd03.prod.outlook.com (2603:10b6:408:131::15)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 12:30:51 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::4c) by BN9PR03CA0520.outlook.office365.com
 (2603:10b6:408:131::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 1 Mar 2022 12:30:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 12:30:51 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 06:30:48 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: enable gfxoff routine for GC 10.3.7
Date: Tue, 1 Mar 2022 20:28:14 +0800
Message-ID: <1646137694-12053-3-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646137694-12053-1-git-send-email-Prike.Liang@amd.com>
References: <1646137694-12053-1-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 991e79d2-f958-425d-ed68-08d9fb7f52a2
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2340444B07FB3435FE90607DFB029@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZSbsNw9763KByLiTtKehiX9KBo7x4yhkXtlCpoqOl8wOYKLituRCHhY/BXy3E+qbgmGiLYRYqBLtw6EwyMHS8QHcbY267TcpYo+yh/kU6lYREm/EApt4FOuaAsj38qOvoi+0axq3PYdQv3ThZOmJW8ZgCXYTCd/ZIJf4wkc9Jj2Qa6jfqv2072Tw1taHwMpjseNFYnMwETvVpeuT1yFlqI1O1P7gLXY7N+Y6IK4QYkwDRL29pJD7o//LDV0Flxnw8gydmJpQA6+eOhivzd2SJ6fPC3mU/7Lq742nqrzUD5IKkarytt48IWsYovAGjjN7oHpWZso1HMRR4Byi7sHUfBn0VUUVhRfo/12SJKDHPZ+5p+R1dAosu3KlTmJpDsH4UQWS7dY4wEmNLcao5RdUrxAnAK4OD/Pm7FaLXGckmZL85vmv1fYV71+ifyM0G6vZ2l4LplZuCOz4W0J7AbWykeuHLKGG6DSAOGKGqnC1rpdvHFWPdVZFez83MlvphBOWV6Mu6lhyejye/pjuBI+Erh9wukGVxoKBL0VcHvuucpl136Gh5VpQL64WQLGhg0eJZyoG5r+ZcbRkHultJSZ9NwtcsxXYQaD/5NZBHGwFWkfNSm2CY8tn/MpqzJShUwWgrEnXylhNFlEFwZ/5AQurdyOZNckjnE8/pEhYcbJrMlJmsRSI3IyzUR5ojW9UWFV5m5uB6mfI/a/g4MwUM46QLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400004)(70586007)(336012)(186003)(26005)(47076005)(36860700001)(16526019)(70206006)(8676002)(86362001)(4326008)(356005)(81166007)(5660300002)(426003)(7696005)(40460700003)(8936002)(2906002)(2616005)(508600001)(36756003)(6916009)(6666004)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 12:30:51.4838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 991e79d2-f958-425d-ed68-08d9fb7f52a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable gfxoff routine for GC 10.3.7.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c         | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index e048635435a2..92fdccc4a905 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6557,6 +6557,7 @@ static void gfx_v10_0_kiq_setting(struct amdgpu_ring *ring)
 	case IP_VERSION(10, 3, 5):
 	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 7):
 		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid);
 		tmp &= 0xffffff00;
 		tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
@@ -7857,6 +7858,7 @@ static void gfx_v10_0_set_safe_mode(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 5):
 	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 7):
 		WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE_Sienna_Cichlid, data);
 
 		/* wait for RLC_SAFE_MODE */
@@ -7894,6 +7896,7 @@ static void gfx_v10_0_unset_safe_mode(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 5):
 	case IP_VERSION(10, 3, 6):
 	case IP_VERSION(10, 3, 3):
+	case IP_VERSION(10, 3, 7):
 		WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE_Sienna_Cichlid, data);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 261a3749c089..05783b9b4b9a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -751,6 +751,7 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 8):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-- 
2.17.1

