Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE12C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 15:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D9810E41A;
	Tue,  1 Mar 2022 15:02:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CDAC10E41A
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 15:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h28EtHRnAy6PRhATU+Wlzp8ST8wzxlgNuZpY/JmsiScsUt46nadNx/44o0A8bK11VT38dvoOOyG3MNecbgBlebR8Oe/KVVvKnlGQjzGsKyJ5y2EFXV9gHdmt6uKycqwYwP0iCNTtHLZx2oqp0a0VHyJo+FKa74EnyX9hvtY15lahAaXLXjCjS2eRWEzjLtYLqtdDQHFiAfRRNeRMIofwgyxCsbUEl7fX5Gb+tsnf/fQMu7VL/B6DMu8DNOGbneIHNDa3ed7O+niv2Pl4dNOod61YRhTXF0YIaNGZw6PQZcYmfNMePNlV9FZfl9dMeG7omc/xwPpizewlReOEQ2n+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToB++7odEK6IvCGYOMI1B2uwfVuWY1tlBXUdTUHpGdU=;
 b=KSosVJMxz1DFDBmZ9wOc29Bd3CXN5eTAUgjps72EMEDe8N8TWGcvEIjS6RE4EG50O8P/e561mecOb4Y+O7U8Dt0NsR4Z4Ce4CvkOy1e4GPIXniTaAfmjnK39fJCP/jCMKY5b+Gc+xVo6YcUXHQzdR68TG4j0wz8hv3gZ5fcHgiDi9Gdwa/WlfGyuBJa/92ag3kEGcMuRlyEVFYD0JZgqADlk8cDNNdTltJAAV+IC97c53ziaeHERld+46G9cOtJL4zSnT+wUINg70aj6KfcZ9PGlHRfN+OJcYPlD8K51dujmEBB6EJPG5AvwBuhPdx/cX0aqMKBzWw7d/qc7qfGghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToB++7odEK6IvCGYOMI1B2uwfVuWY1tlBXUdTUHpGdU=;
 b=BJJljbTRkR8NZZklv4BvbKyaUNgW7D7J+TAugmLsL4dPsFB46rQlcN7hV/XoyJHHx3XkFhenk1BIQRLE7HKPItwCAcErd8/Yy55U0KI0rkfJ3H1ZUp2oCcbcKZTfpgJFF9/PWGbNQxHHOUW7eMdMH840rg/Nw3xOFJxU95ZosPA=
Received: from MWHPR10CA0015.namprd10.prod.outlook.com (2603:10b6:301::25) by
 DM5PR12MB1195.namprd12.prod.outlook.com (2603:10b6:3:7a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.24; Tue, 1 Mar 2022 15:01:56 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::ea) by MWHPR10CA0015.outlook.office365.com
 (2603:10b6:301::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Tue, 1 Mar 2022 15:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 15:01:56 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 09:01:53 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amdgpu: move amdgpu_gmc_noretry_set after
 ip_versions populated
Date: Tue, 1 Mar 2022 23:01:19 +0800
Message-ID: <20220301150121.3785743-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d77ab638-10ae-4b06-aeb8-08d9fb946dc8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1195:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1195F22636460F9A46B8B4CCC1029@DM5PR12MB1195.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jYqLwrp7FcomhBC3u4DR29lFzgyy8mrq7XU1Ls/kFdLYlK622NvaG8cKoYZJW9NyXL75TPef54f78TNnrnWasWHbj4bvujyodL781orDUid1zglyJhWxc9nCqR6CiMADWS89AKHq72NNknoArzDWGnBoyDpfHRJn7q8xhooaCXiKfIJ/cpPa/pdhwpjI0AqZP0vcU9GA1uaAX83JLKeTvCyEkDvhEw/GHPRswkqb5A0B5UmVnQLRolyEVxa9yYBXcbDoQpz9PYtNRey1BzBMDG+68jAM3FdecFfaowzVk8cWGnN4RDoAzs8q+V4GdQWYGRZsQERm0a0+UDrYon25lPyxRt+LEZ+T5uv8Wa6n3zXb+lLQhtI3pTYc2Km4rFCtWPK1Kd20P48EKaR7KgAD7QNihgJahdyAZWkjvFpNd/6fiH/X1c0DvCEjUe4SJWuxHLRoVq91j3bmadH11uA1Zo7OUDcKYsyXRD8vcUhwRjlXcrczpa+6rq2WnMllmy3G4iC32df/6lR/p7Pf/l20CCRxD6WSKUOEYg6cfq+EVXtiZRXCUwI4GwaamXqmXNnv8vE8aQfhX8gh1BP9hrkPABOz5H8x6cIt0KpGn+GeOwutNKt9lSnoJJ4B5ykIeEyZW/jAzhQk90LyXmTeTlsHCRvpGR5a14Ds4lRQmTaMxg2lLMQKpFPWbvN/YOSDk79A+jHeApOlCw7znFMRoAAQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(316002)(8936002)(5660300002)(86362001)(1076003)(82310400004)(70206006)(70586007)(8676002)(4326008)(2906002)(4744005)(16526019)(186003)(26005)(2616005)(36756003)(81166007)(7696005)(356005)(6666004)(83380400001)(508600001)(54906003)(6916009)(426003)(336012)(36860700001)(47076005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 15:01:56.3517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d77ab638-10ae-4b06-aeb8-08d9fb946dc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1195
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Ray.Huang@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

otherwise adev->ip_versions is still empty when amdgpu_gmc_noretry_set
is called.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6113ddc765a7..61a6a7920c76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1554,7 +1554,6 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 
 	amdgpu_gmc_tmz_set(adev);
 
-	amdgpu_gmc_noretry_set(adev);
 
 	return 0;
 }
@@ -3641,6 +3640,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	amdgpu_gmc_noretry_set(adev);
 	/* Need to get xgmi info early to decide the reset behavior*/
 	if (adev->gmc.xgmi.supported) {
 		r = adev->gfxhub.funcs->get_xgmi_info(adev);
-- 
2.25.1

