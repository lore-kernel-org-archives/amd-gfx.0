Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22ACC5AE4A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 02:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2097E10E29D;
	Thu, 16 Nov 2023 02:47:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A45B010E284
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 02:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAZAG8Us5x4OZmrWEcHC8/BF42H3k7X5mxdozw6Fnm9zJy9O3iw72YT0X9+jetRsc/90yFFcnPoLXpUNg6ZrSW4Yw3aIUUYqU7XJ+b6Mh/1miqUl3GzwPA3rBm7ty0AyPYW+fmQ9ZdjD0bYLiztzH3lAMwy1wYfGg0Hkox60fQpU9+OB0bW93bcDscyUHxAmoBGnDhXYO5+ohA9bQ++/QVxGlNHwNI6Lb3zvtDsCknlQAfdc+uo0yLHeVwr8lhZH9nDyLAPusN89xIdnozVNSdv5BIF2LuvdwgVd7QPCIXEyLiyd+RLH2fcf6hMBJCjSc0z/X2cbAh+X6WHG9waeXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4w02eS95r2V+Ye1C5bkx6yaajlUPQgalKTGIm9oJpS0=;
 b=PQWwSJ+l4VMWfX9XOdfgwVSLLon8ra0k8r4+P/9XaXimeFIxG/n7la+1cIzyMNBv2PkPrB8HR08HBk5/jc3ryAnNC31UepehRdTC1GmcX0lLyibkxpLsHiQl7bV0/nX+1jcFYMJwsCVEo5SbTYRK41oZH5QZmlINlTD9cRxoQLomgOfnXAqQV48DqUo6t03T/mQYFAO539BpJo4lIl5sdNm/u/CLS37T++W1AQIyeocqh1z26mUURB/RqqFaF9mjYKSKk74sSX3zsAgkqruiszj1iL7XX27o0hGLNGIlXsOcIzG4D/QgHgB//hLm+1vkln0G/ssawPV2npQrfqcxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w02eS95r2V+Ye1C5bkx6yaajlUPQgalKTGIm9oJpS0=;
 b=jg4OL3WWOZG/a/mNdXEZGAek6n1saFP5t0lvNe9ow7hp3KrgX4JDAa/fXvIOnnUm1YnI86GRFHqWFnjOEm/g2ZHpzrGHCs8Y8CkcINOPtBsbnMIL9P6xOA2bwCG2CUdlIlyuj0mKCAAuZAGMoZTznzqTn+f572yK92X0Waahyak=
Received: from CY5PR14CA0006.namprd14.prod.outlook.com (2603:10b6:930:2::17)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 02:47:51 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:2:cafe::d4) by CY5PR14CA0006.outlook.office365.com
 (2603:10b6:930:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Thu, 16 Nov 2023 02:47:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Thu, 16 Nov 2023 02:47:50 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 20:47:47 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amdgpu: skip LSDMA for mes self test.
Date: Thu, 16 Nov 2023 10:47:02 +0800
Message-ID: <20231116024703.2838690-6-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231116024703.2838690-1-yifan1.zhang@amd.com>
References: <20231116024703.2838690-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|MN2PR12MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c57de7d-653e-4a2d-b573-08dbe64e6c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xr7Oo6boV0G3hfUs+olxgHYJHT0vVXNwaQIbtF94ksfXrBbMLD/L98IT+Cu7RbLwi6WbNXeZ8y52VabqLFmZn0aTFMxGHkoVNdYrLyu50OYGSu9BG4t9cRY6g1fehntGOkw9QppDkdPh1X3G1aT6ZKVrOAMQDFhwahEYI1bTEJuYS1N6vJbT1qU7NaSHDk2hcA8qWapZmb6qXlSp1orIo8g7tUQn+U7UAZ5fw9PVFGzjfzlpp7069GpUrOi0OX3/y5H2DiNAZbuBcz2yapklXCAWEExanyRbVqyUKNcvCngHmooTnPpuWpeKAwxO+0o0t73PrVf01R+qkQF/ViAUJOYsNdHA2wWTa4EEEjlQscc3DjRMYZ83jpNQomQ/W1MrVWV+jx6D/s4m//RFoTDvDG4c6uJENJBOCDHd9PQqlRgEkiLgmAnVrVvOQJjZZs3EHQYMCtRrlsg045YM6rIEj2TplcuLW9ziaTQfwUGRQpD/QP5+MyjmmCEdRw5ripYSK9jzUm9aPvg+WLEaN3v0oCEqyNnBERslEh+ExcrPsCxXqcMvMZfsJwjJ8qsN/TwqvfCb2ptuxodb6ja6doH6M9JJsEK0ujy1JlMRhtmQmzRJXPLJGfaeqlN2LJ3w3SX/iKMlKJzjpZLtZrgTmchDXuFwRkPfKf8kMP/7+Cs8zr2Wo2mEMSAFOI9j/tWsLEGUzc2TgFySg4WbtG/njFv0bovQ7KoylWDr3GXymB4Q50nHCaEL8s5hVibtzHxH2YV8pOnsBdWIkHMYQ5UpO94HSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(356005)(40480700001)(81166007)(36860700001)(8676002)(54906003)(4326008)(70586007)(4744005)(8936002)(70206006)(336012)(426003)(36756003)(41300700001)(47076005)(1076003)(16526019)(82740400003)(26005)(2616005)(7696005)(6666004)(86362001)(478600001)(2906002)(40460700003)(6916009)(316002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 02:47:50.5435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c57de7d-653e-4a2d-b573-08dbe64e6c98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
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
Cc: Tim.Huang@amd.com, Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Alexander.Deucher@amd.com, Lang.Yu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

LSDMA ring mode doesn't support doorbell.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 45280fb0e00c..2464d246aa2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1362,6 +1362,9 @@ int amdgpu_mes_self_test(struct amdgpu_device *adev)
 			    IP_VERSION(11, 0, 0) &&
 		    queue_types[i][0] == AMDGPU_RING_TYPE_SDMA)
 			continue;
+		/* LSDMA 6 doesn't support doorbell, hence skip MES test */
+		if (queue_types[i][0] == AMDGPU_RING_TYPE_LSDMA)
+			continue;
 
 		r = amdgpu_mes_test_create_gang_and_queues(adev, pasid,
 							   &gang_ids[i],
-- 
2.37.3

