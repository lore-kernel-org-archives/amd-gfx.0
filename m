Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E5AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 22:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B6910E4EC;
	Tue, 11 Jan 2022 22:45:47 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D219610E4EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 22:45:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nATxujp7F0sHGoa/ty7/KGXDy7OVPPzW7vqLQ301MQKXVHZnGxPiwQgOJ68GV6xjH4HmtbJE/yvZA6OX45MOk0truFfkkxN/zrd67yIhr9Su01C0JDtY6++lWl8j3u9i3O51Mr1LEFVyoyiTAXzRH2begKJtZZe3DfiPC8IXgtuj/bV9DgHh0rt/kQC7xC5oqbUw5LYqR/vL0IcrO9OnEQEuaMzg9WF734iX10EiO6pyfdm99GH3LMTkEaBysq7XizUyXStQQPMksre7Ryfm+wIGV1rUMlHd62cUTSJ/LK2RrtIgsVOe9QQAnP3AFmGGHbbpozyL7myfzZR5pGIAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/Dv+yKUXahghliN+ffvgufM8PIiWqCNEe5Dj43EwyA=;
 b=KqxdR99pzeK7LhkCowNnOzEZhdbsp/B7HfQiRSAFYHI3ZdXG+Q7ikY+/GlehsnMprx4Xg5E+2Rj3pnc1xLK115mzuoGM714kwKrkAlq3nz3OSUQ3JgHIBQjTsiTCrnfk6F2UL283Ve0GEt1mqcsSM/FphStCzICePQoY5GsrFunR+m0RDGwcENwso429g4P6iOoh37kgByGoITHdsjSoDDYE+7UJJzJqINx0/XT4W6STwVq2lnmr8bMG9Uqhqks9S9TR67DuaC2N0exz54oh+IQ4VEipd82VSk+ojxbKRGyDDkH6KJ2IqeD/np0RgpiRl414P+hCFkCnqnKlabtyjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/Dv+yKUXahghliN+ffvgufM8PIiWqCNEe5Dj43EwyA=;
 b=SYHGDE5Pm2rZ0LY+I2o2w+dibm8OUH/bIfL8vBBK5uoq7zbpHiUERZRt9ucXNiTukgZ7PIN/+8R5xHBA5w9XtuuiXMR+iownOGJQjavz19rTJDxISPg2DfD0sN6Du9xNLKnVvT1rvwx+z9YDYCWqpZqH3fcAlNMXvntmDIlv21U=
Received: from MWHPR22CA0020.namprd22.prod.outlook.com (2603:10b6:300:ef::30)
 by BN6PR12MB1873.namprd12.prod.outlook.com (2603:10b6:404:102::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 22:45:44 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::a6) by MWHPR22CA0020.outlook.office365.com
 (2603:10b6:300:ef::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Tue, 11 Jan 2022 22:45:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Tue, 11 Jan 2022 22:45:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 11 Jan
 2022 16:45:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: invert the logic in
 amdgpu_device_should_recover_gpu()
Date: Tue, 11 Jan 2022 17:45:25 -0500
Message-ID: <20220111224525.3090269-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1fd648b-2d05-4700-9288-08d9d55419cf
X-MS-TrafficTypeDiagnostic: BN6PR12MB1873:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB18731C6FED56643A333FCF5CF7519@BN6PR12MB1873.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xktGp3O7vyLU3UR4W08qK/Tn88NPO8/7BusU+yZ+uG7iSBnEMGc5s+wOtDJo34aciq94Mx3FyC9pU8RtqV5B9W2T/cxMILugmokUXcBEgVDZhJxZ83kMPrmA30+NEIIcEULImN5oYgCryNI05yqf1MTKmx1yzlKpQJozZJ4AydFJbB17y6dnosoGOnX/aYIj2odYki7FNx5Oj3M5Vv3Ji4tHevlJhIMTzpGJhP2ukva6u5KNOZQFURWqtpDCaBniqFFzthlW8PXroWuiri0gc/OvJX4f8R6ZJZcPO2mqvzpmjGbbACMEP+HJPrzEXuG8b2zc47unrA5wFVhdTvZ7Kzf7b+QfKOZ8CSfURtY6IPF/sceLrv7d7Uy5K260ObDH9NQ38YKm3GuiclSkZX/fvRIOv5WwMysnkC/Cp/bAdsr2EtI8Lwlj6ZK4FHv0qbaMBE3JfZg68ZvFcuXHN/fi2e00OehR/9y1XXzoRPJU4CdGUCjxxcR1hC4mYv5EFHW+2i0j4RnPvsi395VNTgiVhPebnXrKTo1+OlHzEwHCkHPdxIYYuJPYb2m9kLh7Njqm9IWvwaC/8DzGmfbKXvrSJEE92Hl445byo9RrHopFvYDZcL6TDUZon+5ASC9mWZRlzbe6Tzkouwu+LK5chUcDwPlSSmBL6LfqddJvclloElN+9Tvi8D2A62hMZsXnRvhQQ7rReosGYbF6RQYLNg3jaFcmPrT8ymYBh6uEsvJ0oxvX8wkCmQbL5jIaEfDvyZeHMRfRbH/AkoAQa9UHstktSUxh2dcGQV9xEUlaNtOse1k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(26005)(83380400001)(16526019)(336012)(186003)(2906002)(1076003)(81166007)(36756003)(356005)(426003)(36860700001)(6916009)(47076005)(70586007)(2616005)(508600001)(5660300002)(8936002)(82310400004)(7696005)(86362001)(6666004)(40460700001)(316002)(4326008)(70206006)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 22:45:43.5076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fd648b-2d05-4700-9288-08d9d55419cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1873
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

Rather than opting into GPU recovery support, default to on, and
opt out if it's not working on a particular GPU.  This avoids the
need to add new asics to this list since this is a core feature.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 44 +++++++++-------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f33e43018616..32ad50b86248 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4453,34 +4453,24 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 
 	if (amdgpu_gpu_recovery == -1) {
 		switch (adev->asic_type) {
-		case CHIP_BONAIRE:
-		case CHIP_HAWAII:
-		case CHIP_TOPAZ:
-		case CHIP_TONGA:
-		case CHIP_FIJI:
-		case CHIP_POLARIS10:
-		case CHIP_POLARIS11:
-		case CHIP_POLARIS12:
-		case CHIP_VEGAM:
-		case CHIP_VEGA20:
-		case CHIP_VEGA10:
-		case CHIP_VEGA12:
-		case CHIP_RAVEN:
-		case CHIP_ARCTURUS:
-		case CHIP_RENOIR:
-		case CHIP_NAVI10:
-		case CHIP_NAVI14:
-		case CHIP_NAVI12:
-		case CHIP_SIENNA_CICHLID:
-		case CHIP_NAVY_FLOUNDER:
-		case CHIP_DIMGREY_CAVEFISH:
-		case CHIP_BEIGE_GOBY:
-		case CHIP_VANGOGH:
-		case CHIP_ALDEBARAN:
-		case CHIP_YELLOW_CARP:
-			break;
-		default:
+#ifdef CONFIG_DRM_AMDGPU_SI
+		case CHIP_VERDE:
+		case CHIP_TAHITI:
+		case CHIP_PITCAIRN:
+		case CHIP_OLAND:
+		case CHIP_HAINAN:
+#endif
+#ifdef CONFIG_DRM_AMDGPU_CIK
+		case CHIP_KAVERI:
+		case CHIP_KABINI:
+		case CHIP_MULLINS:
+#endif
+		case CHIP_CARRIZO:
+		case CHIP_STONEY:
+		case CHIP_CYAN_SKILLFISH:
 			goto disabled;
+		default:
+			break;
 		}
 	}
 
-- 
2.33.1

