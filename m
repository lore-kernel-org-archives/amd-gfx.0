Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36230C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 11:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABF4510E7AC;
	Mon,  9 May 2022 11:47:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4ED10E7AC
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 11:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqzGJJTldLJIQyDfdzk5yX/7YJa16As1S5WtCNH8hkjg+xcVJZo1/AdT9vb+C7xZKG1LObSCAeUjhO+OibJHlYErO7RJqmn5E0E3ruGXt+qTlKEGmq2VMd1VAEnyLUtFhHtcyPvTxC06BAdncqHdKK6gs+e2BOig0Jn1ma64DhoTQ6l9ZO3QFfPa16fWyMWxY11LyVeIxEfwHg0TYxEr9EGpJrAfRNhevX83iqdyheSsASZd9eH9styvi2Q0nVdq5XzE5I+9hXbe3y47nBP+NGl80gTIkxyT6KUjTjyV88QDT6S0JndayhUZTq47kuJyssPV0dRGeZJDDJRr/kO/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yyoiug8p26lLoo0IL/eyXc/tawL+ZHU5r3PNZbkKzw8=;
 b=cMYw/o7W17Kn8ilFS6uNXZIEFofKlBYMxr+XvME3+67SY7wi5h1aFJFB0kmI0Joc+NZmBopSRdB5+K3L6zyXq8RxdjTvDYxK6RDWumtvp0NY5AhLAHbPqsXIo1xAOYv0QUYQfGsub1Qm8d9ZpdvSlLFmJfQeYoz0tLBMmdjueyXVsbeGFffxAtbY8thwtO38UF+vHRsFUbpeyi/eCFxnz7zI21LWnC4rM1tcIwbJhU82BGfL04P53UhODDp7fudhjgROJRKu9fGdXy1L+elGenvYFxhfeO5mNUVNJ56rOTg1SrrbaL2UFZn0GAMi9lJfNruN53cLFdpz4bByauH7jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yyoiug8p26lLoo0IL/eyXc/tawL+ZHU5r3PNZbkKzw8=;
 b=12dJ9gK4E4W5bacSkcivnuZqLIpodUI9SOagZNFjYh5RqKu5tHiTtTAOP4DCO+md8qcfgJ5ks/r5BdIe2OmArmctQQG+2i+B/qrBj9r9Ef0yr5PPJkuW24Chx3uIFzBVDt/GdBIWIsX3bivgvQtwR+mmOzuAAM2tIGknvFGI4+k=
Received: from DM6PR08CA0028.namprd08.prod.outlook.com (2603:10b6:5:80::41) by
 SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.21; Mon, 9 May 2022 11:47:47 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::50) by DM6PR08CA0028.outlook.office365.com
 (2603:10b6:5:80::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Mon, 9 May 2022 11:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 11:47:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 06:47:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 06:47:45 -0500
Received: from sriov-MILEVA-7.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 9 May 2022 06:47:45 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amdgpu/pm: Disallow managing power profiles on SRIOV for
 Sienna Cichlid
Date: Mon, 9 May 2022 13:47:22 +0200
Message-ID: <20220509114722.124060-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0776853b-461c-45a0-dfa8-08da31b1bc94
X-MS-TrafficTypeDiagnostic: SA0PR12MB4463:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4463191CDDE2A2B8AA0C950B98C69@SA0PR12MB4463.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8hWh7v16Vcuds1KMQNNh9VLFeydmWrYjzAZz5fKZtRsyQcDb+QiRev4qHvOMVHyTAk0rS9camcPKAugARORgpRsXfBQKMGV9dE2Vj0QNmMoOr2AYp+7MOjBb4xq6HPVLwBwm9b0cI05neYgWB7wuMbLE3Li4iPKWzGALu/VtiyMrk/bKjwkVux1ag/DNQeQLSzJ7NGF1rPBFwJJ//fUnrzddEgVvySfdWsywVXjW03TUcH7KCq6sZjqsuSgWZ7A84rpu++zjtDp0KdpDZyx71kiKptCzI3cO/a8JsaHQRDN97nebQYNWdKHrqiLoY1ZEZdDlWkjqixFNj3XG4y60Hj/pwnQjTU82dgGj9Frv8EWazCA2vWTTfj75Ko7JD929pN2zyNwB+89Y3wuoDvRseTeF7TvMbjMW4qk0r89U/mqRz6/+toVKVL+FS7jJQWzyYeQHiCfWKZPe7jJDrY9W2D/yHkSn7iIlHZbbuzhu4oRSbDPrzZg/VgiRbKbsUbv3eW70CxgRfwoxZ/EUG9buN0kRSxliKD+Dc2F1t+cfY2nm2Xx8XlT35KUAvDeNRoXfM7xn2hqAjExkcaXFZkMUDk5t49wnyp7csG6idKtQzOl9sIKtFoWTLfCa1DUt0JGdiD1WzOnYQQzdQjdsLZg8dg0xzivLY1YG2eAEoGAu6LbSfE74fJED4hArUXHCdBdxnBoomPev88RVyNV4UT4sQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(36756003)(2906002)(44832011)(40460700003)(36860700001)(81166007)(8936002)(5660300002)(508600001)(4326008)(1076003)(186003)(83380400001)(47076005)(426003)(70206006)(336012)(70586007)(8676002)(2616005)(82310400005)(316002)(6916009)(7696005)(86362001)(6666004)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 11:47:46.8254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0776853b-461c-45a0-dfa8-08da31b1bc94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
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
Cc: Danijel Slivka <danijel.slivka@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Managing power profiles mode is not allowed in SRIOV mode for Sienna Cichlid.
This patch is adjusting the "pp_power_profile_mode" and
"power_dpm_force_performance_level" accordingly.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 70a0aad05426..59a662aeaaf3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2025,6 +2025,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
 		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
+		else if (gc_ver == IP_VERSION(10, 3, 0) && amdgpu_sriov_vf(adev))
+			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
 	switch (gc_ver) {
@@ -2038,6 +2040,13 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			dev_attr->store = NULL;
 		}
 		break;
+	case IP_VERSION(10, 3, 0):
+		if (DEVICE_ATTR_IS(power_dpm_force_performance_level) &&
+		    amdgpu_sriov_vf(adev)) {
+			dev_attr->attr.mode &= ~S_IWUGO;
+			dev_attr->store = NULL;
+		}
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

