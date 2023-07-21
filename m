Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C08C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 09:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6AF410E63B;
	Fri, 21 Jul 2023 09:22:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF2510E63B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 09:22:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLLYj/TfiPiAn3cD69eO7N821EHvhCWGYiFX+5ilXfZ6T0BvnuRKFEazdhAW+rj9+86g3Jwf5orPPoj9tVnifUyAb8gCfr4OP+G9IC4o+iQDKM7CY3u41m/pqCNa31/9hMFR6YRJaaeFt3OwxG+WMt0pFz1Aql2ScA3bcjalKDWtt/Gzu+g2TsC7RwH57E37k+jPXx8xiLtQ7GadPqsJ3p+kNsnMbxBnlZfwkdOUzUttVUGdYasUMpnHsihPDdCLtoMEhY71FzHoZ9Aqhk3lJeGvfaEoRIliVOEqozBWB2pOMVJXMGfAS79r3yYJJQKGKvca8zINjvZgUBhbC0jQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Bkgmh74a+EWKneQMObzUqHnsBXmeYP5e2IZ5TUdrWM=;
 b=mx/i+4dnsoa+Y29IMJwQLVg0gnLb9QZZhBHu1OPjA4CcTGyOdSnhVyLwMHhjeiyVSzSPboUDC1hzwt1VwaQfF5SrqmfP8rn5g/K5ceoIhAWltuitSjyKan4da4Qh0gdHWzkUPPii/vUGwIc5OlBXGq5tT12Oxb3fpOS+VnS0upKmaUaBZnbRMx3vJsVGFDDp9shvSBLYaK8A97eTJxQGO2Yo6zH+4xlNoroisVEwSP7sRfKiIdlaKSGNRfynjLjurXQWZiELVIclSzvnHjV2up3rifBMgUMF+L/8XLIbOVPcx8eXHGaP1JCbcizEJi8p7Q2UAq/Rj3NlV6c1VnDV9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Bkgmh74a+EWKneQMObzUqHnsBXmeYP5e2IZ5TUdrWM=;
 b=wYZbNkIhO3Q1Jr88S5KucH17xqtiVQrTTAWDcbaukYHNlfYhFfxvC73/bS+Mta1SCDeemUQVJPyPVZFMfYXLXFXhjq11FZCoSksIALrt+UfVB+NVlVD2BOV3yCh4kRH1OLFotPji8xUpyw5CcqdUwiveAYzKhXPF5JARzjJqZ3I=
Received: from MWH0EPF00056D0A.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:a) by SJ0PR12MB8113.namprd12.prod.outlook.com
 (2603:10b6:a03:4e0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 09:21:58 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::200) by MWH0EPF00056D0A.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.16 via Frontend
 Transport; Fri, 21 Jul 2023 09:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Fri, 21 Jul 2023 09:21:57 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 21 Jul
 2023 04:21:55 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Return -ENOMEM when there is no memory in
 'amdgpu_gfx_mqd_sw_init'
Date: Fri, 21 Jul 2023 14:51:35 +0530
Message-ID: <20230721092135.1484616-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|SJ0PR12MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 9135f117-38eb-45db-4a83-08db89cbeec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k3J6pYZ5Gv9I6CCcspIXmDgOp95Q3oaHJQvEoC+f9mFhMfjesA5GyW2FlXIQhj8Biehozpp8xSMWcvJ0Xfp4V8EjE5UZS+oHk9+dz+IK2gw87aVY6sYmzqwPEsgtRODCu8585tVeW3i3mNxH6/enCA/y3SLOYvbyGq7l5n+v9OI7dFj4Bwoc4HO8tWk2Rv7d0b+A3Kh0qeN+ho7+kj5FoxPSazHAJmR0lYaZyetlanLFNoZFSIh+P0bvpKvK0mu7gqmbAF2n46HUhXi4Cmw8tGM70/07vfQg/ToY+VJPT5NnYn1uF/5e+aI6sieTyCyGx/iwELlMLcRxCwdJTXyv4f+Yr605sn5XBT8PePjDBSAbJfuWZ19wqsMtxzHl6tJE3Po2WjfzQ4QV0MW2moYvMqeCEEzvJzfnOY9CICuxxe04+F8Jicp4WGhL1YUld40r2ei3IlsZ+z5MdHkR0aLgz5BC1W94aGvY6X586JmFmWZmJS+yE+ud2zP/XSz+FN18RaJ9UmF2Rzl2SqxR2XimfJeSpJRqfAQ+4nhryYT4Cm/D5YHyD10LF0hr2wAd+hW5DXyTqqd2Xx7e7ZGoa6RiaJmSaz7rVRQsw/120n4G/4Jq0kX5ZNDdDjZvbSiqlM6rv8Qj3hrSb/HTYBdjyO+uVDOTFvqktKrrwtmts0D25cwBK1hOU6nnOnxHJBzWV8Hri6YR8Rd9SuMTOTlq0gVRLwb7eetEBoXRRbiHj/aGxr8qqMO7vLfHQ/d6DsBUV4f21qJwuYdHL53s6YemO63i/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(8936002)(2616005)(41300700001)(47076005)(426003)(26005)(83380400001)(36860700001)(8676002)(16526019)(1076003)(186003)(336012)(81166007)(356005)(6636002)(4326008)(316002)(70206006)(70586007)(40460700003)(86362001)(6666004)(7696005)(40480700001)(36756003)(82740400003)(110136005)(44832011)(54906003)(478600001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 09:21:57.8874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9135f117-38eb-45db-4a83-08db89cbeec9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8113
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Return -ENOMEM, when there is no sufficient dynamically allocated memory
to create MQD backup for ring

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a33d4bc34cee..6639fde5dd5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -407,8 +407,11 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 
 		/* prepare MQD backup */
 		kiq->mqd_backup = kmalloc(mqd_size, GFP_KERNEL);
-		if (!kiq->mqd_backup)
-				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
+		if (!kiq->mqd_backup) {
+			dev_warn(adev->dev,
+				 "no memory to create MQD backup for ring %s\n", ring->name);
+			return -ENOMEM;
+		}
 	}
 
 	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring) {
@@ -427,8 +430,10 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 				ring->mqd_size = mqd_size;
 				/* prepare MQD backup */
 				adev->gfx.me.mqd_backup[i] = kmalloc(mqd_size, GFP_KERNEL);
-				if (!adev->gfx.me.mqd_backup[i])
+				if (!adev->gfx.me.mqd_backup[i]) {
 					dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
+					return -ENOMEM;
+				}
 			}
 		}
 	}
-- 
2.25.1

