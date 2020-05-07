Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C987C38A2A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 20:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA36208CA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 20:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Jil7DEcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA36208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A125E6EA60;
	Thu,  7 May 2020 20:15:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F826EA60
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 20:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTWCQ+Pcx45lQoImfKhw8ISGm+4oMEzUsCQlEUSioWV+k0r4VrKci3QIIMwBGxTT4zOhHM21TCJe1Nq3/KmTtPLxNLRbJ80LDliCSAZA/wd7Pihg5GeI3nwXIUHT6XXGTKOyzhNjvuORUEssfTlLH2RKYeZcScx5QiSy4np6104V5Wm1oQaBzMZ6vO8agVoKgAi8M0ppaJ3rqb4F+PvMrB7TivqOrFRkSN5a+IDCP4A8oaFlGtRI6wwoKG8eg6Xs0R4YHaY9ldxNmb+H8Ztx775T2Ce+CupXerQiRFVRpDXoA4SKyBE/Z966oYZSbjr4yh6ACmzeGB/KSDvybHUIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEYDa93n5WCWlKqWaKf2GD6QhumaWQHhsL7Y7RLgvOE=;
 b=hKgbLxHImL/Yw2YKlXawgAs8BRwJXzaV2cMQgJUE9p3JQVjVPsu1rVW3li+3zGIQgzMDp7aH/SDRtWzTJXa5l41KNnydC2+p4Prlab5mYOXy7V43Xf+ATkgYNeSNf9Khu9fOudBbnfN5zssGhjNB9jYO5tlTERZs4SOHqbwfyouZ9ZlmwRZWqv5hR0L1lh00sOO/D881FYI17I8d1MKvIArl5tQwUqvnW2KIAFuuEwHbUZ7paRwzCzY1ExzgIWIvovFvbjVU9EyUZNBmCQ35DTdkCEomnuFOR58PAjKnIo8QaBoDZw+WzZlL9w4HIMRkToApSdIlZe/9T3GYLtXo9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEYDa93n5WCWlKqWaKf2GD6QhumaWQHhsL7Y7RLgvOE=;
 b=Jil7DEcW3qM+zo2YHYfnTWPLqRHPTNt+q5Z/qHVylfzc/Tk4TwBCI4D0X98ccjzNEzEmoRjiZ7nU2p/g3oXNEnTjI6ziS9LzlfguP49YwXqU/nIyGz15wMSgltfgHc244+02lBzOmoLT8qabWUr7e7uDJVUcy90q3Q3+HCsI4wA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB2894.namprd12.prod.outlook.com (2603:10b6:208:10a::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Thu, 7 May
 2020 20:15:03 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::c578:193b:bda9:ac5c]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::c578:193b:bda9:ac5c%7]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 20:15:03 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: cleanup sysfs file handling
Date: Thu,  7 May 2020 22:14:49 +0200
Message-Id: <20200507201449.4453-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::17) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (2003:c5:8f24:c300:8608:99c3:9b1d:e8ab) by
 AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.29 via Frontend Transport; Thu, 7 May 2020 20:15:02 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2003:c5:8f24:c300:8608:99c3:9b1d:e8ab]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0fe0551b-d947-4ffd-d33b-08d7f2c35370
X-MS-TrafficTypeDiagnostic: MN2PR12MB2894:|MN2PR12MB2894:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB28942080B157E92FEA7E09588BA50@MN2PR12MB2894.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0LMTAOTW9DloCxQ4GxFiO5ny3IOqJcWikk2BVgFfy8t969vQ2LpN7oZ/ly8eq5n14tdHqpf8fO9HiUvsRws7XuABQ5ze4RV1JOpDIocxnEATc1gMwP5g0zXkYQAaS+hVYpQ+wh5u+xpt/Q83tk4SNsIyraddm/0aQTNoyal5JR2yEO0xLUeVUvX6ltQLrVP0JRpNTmqnjqcGren5p/R1X+36ji00BeCN5+ZSmywLKAybAMzo4Vi8UaeinZsfx3CblQRXVoJvCrlL3/+qL/enXUMkEvFnUAOOw8muNucgW6AkHeIkqGhIL8HCIQhVxi9Y4Uf2DPzqNxwAYB3eBQIuCjDyeQaY2gIFaJCtKoVQfh2P005eG++eBaZ8LqMSyhCTpTtW0wzLSVXcflciHvPhUI3U1kP2vyHcICvVwyENW3RvYjETdO4gEG78s1Xy5r4ExLc8b828oEGex/EcxWbKKzhD1YU9I9ObG+wMA5S/y0Ov4O/4LJnBgibT2fdsrWNZ5vHp1xtPxn61BoBHN4nF2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3872.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(33430700001)(66476007)(2616005)(86362001)(6506007)(52116002)(186003)(16526019)(2906002)(36756003)(4326008)(66556008)(478600001)(1076003)(33440700001)(44832011)(5660300002)(6512007)(6486002)(316002)(83280400001)(83320400001)(83290400001)(66946007)(83310400001)(8676002)(83300400001)(6916009)(6666004)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: VWJeTahC0FrZdO2ETAaVYXoi/n693x8EI3P0m/RYHI/2QMQnOdlDDjQL4XlZO2zcVYD8BY/TXcfKGWTlryMwez1a4m+EYLM9f00eVAHzFqsT96SzFpguSCnkKTzUEpAOK35gkyTqKIYJn/V1LNAcwfZd1zCiTERoEiwdn1Krp88lSGl/uQmuGldysFs2LV53f2jiP2mhe0PJ4qGC/DIW7H6RSlW+h0SwlfSNoOP9HCu0BZPoeaEjI6ICzIh/RKG0BUXiecMCx5MukleOyMhyj6tz1t3uvhmaNOTwXNvfdZJrXL45Lg+2fj9+2+iTJEaQHfmewNVlSH0cth1Ye/H3gwH2YaGSes38Hj/0dQQ0/QHlsvu57jxQbc+vzeAaQF7jWwvx6H1exWBqpY2yDsPtC9752QYEzGSfS8u1qMliAmUWBIew/3seZEMGn+Tu1MTUX7xw2htpLVwdLlJ4TqJsXw5hd0D12KxR9xkIoPy5nCRmEINQQmGIVgkIAatXoj7UFvM5mmd9U12uQb53KwwpxGKP3rYWGpp6r2s71g3+DSSl2peaDMoEXBCA5AO7dmEB+KAZ9n5CgroFHl/d/CswfZutSPrjX4qQhpJzz9ef+i2EzNdawc7w/palSBVsZsLKTGW45UcNZ9E1sDS8/BqKOdXR7veOItQe6mj6GEfYCkTlXKxNAA0RxXD66WY+ZUCsrfvarOHS9/jLwW8qPt04qCtK9c446bHop2fxQ0If7fUzr+fuPIq8Po9tA+qnTTj0rt9rIKjutSHryz5nrKNqOEtibahq/4VHihBNsWc+Kf1ZvOS6qe2I/Mjw28vmoa9eqSKxPiD7QX0zMz4dPQsGwmUZMgAg4ItF3ncgBuGHAQQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe0551b-d947-4ffd-d33b-08d7f2c35370
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 20:15:03.0161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K01HY6/LI7wtDaOdttpBEwrwxeSRWxFBoeQ/EzsASxVePfS4CT0bnFgT/pPs4z5PBtzqYFVNX6sXfaj0AbFSWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2894
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Create sysfs file using attributes when possible.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  36 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c     | 114 +++++++--------------
 2 files changed, 48 insertions(+), 102 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bf302c799832..cc41e8f5ad14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2918,6 +2918,14 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	return ret;
 }
 
+static const struct attribute *amdgpu_dev_attributes[] = {
+	&dev_attr_product_name.attr,
+	&dev_attr_product_number.attr,
+	&dev_attr_serial_number.attr,
+	&dev_attr_pcie_replay_count.attr,
+	NULL
+};
+
 /**
  * amdgpu_device_init - initialize the driver
  *
@@ -3267,27 +3275,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	queue_delayed_work(system_wq, &adev->delayed_init_work,
 			   msecs_to_jiffies(AMDGPU_RESUME_MS));
 
-	r = device_create_file(adev->dev, &dev_attr_pcie_replay_count);
-	if (r) {
-		dev_err(adev->dev, "Could not create pcie_replay_count");
-		return r;
-	}
-
-	r = device_create_file(adev->dev, &dev_attr_product_name);
+	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
 	if (r) {
-		dev_err(adev->dev, "Could not create product_name");
-		return r;
-	}
-
-	r = device_create_file(adev->dev, &dev_attr_product_number);
-	if (r) {
-		dev_err(adev->dev, "Could not create product_number");
-		return r;
-	}
-
-	r = device_create_file(adev->dev, &dev_attr_serial_number);
-	if (r) {
-		dev_err(adev->dev, "Could not create serial_number");
+		dev_err(adev->dev, "Could not create amdgpu device attr\n");
 		return r;
 	}
 
@@ -3370,12 +3360,10 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	adev->rmmio = NULL;
 	amdgpu_device_doorbell_fini(adev);
 
-	device_remove_file(adev->dev, &dev_attr_pcie_replay_count);
 	if (adev->ucode_sysfs_en)
 		amdgpu_ucode_sysfs_fini(adev);
-	device_remove_file(adev->dev, &dev_attr_product_name);
-	device_remove_file(adev->dev, &dev_attr_product_number);
-	device_remove_file(adev->dev, &dev_attr_serial_number);
+
+	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		amdgpu_pmu_fini(adev);
 	if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index c762deb5abc7..f375bc341acc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -3239,6 +3239,27 @@ int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_versio
 	return 0;
 }
 
+static const struct attribute *amdgpu_pm_attributes[] = {
+	&dev_attr_power_dpm_state.attr,
+	&dev_attr_power_dpm_force_performance_level.attr,
+	&dev_attr_pp_dpm_sclk.attr,
+	&dev_attr_pp_dpm_mclk.attr,
+
+	&dev_attr_pp_sclk_od.attr,
+	&dev_attr_pp_mclk_od.attr,
+	&dev_attr_pp_power_profile_mode.attr,
+	&dev_attr_gpu_busy_percent.attr,
+	NULL
+};
+
+static const struct attribute *amdgpu_pm_non_vf_attributes[] = {
+	&dev_attr_pp_num_states.attr,
+	&dev_attr_pp_cur_state.attr,
+	&dev_attr_pp_force_state.attr,
+	&dev_attr_pp_table.attr,
+	NULL
+};
+
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 {
 	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
@@ -3260,45 +3281,6 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		return ret;
 	}
 
-	ret = device_create_file(adev->dev, &dev_attr_power_dpm_state);
-	if (ret) {
-		DRM_ERROR("failed to create device file for dpm state\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_power_dpm_force_performance_level);
-	if (ret) {
-		DRM_ERROR("failed to create device file for dpm state\n");
-		return ret;
-	}
-
-	if (!amdgpu_sriov_vf(adev)) {
-		ret = device_create_file(adev->dev, &dev_attr_pp_num_states);
-		if (ret) {
-			DRM_ERROR("failed to create device file pp_num_states\n");
-			return ret;
-		}
-		ret = device_create_file(adev->dev, &dev_attr_pp_cur_state);
-		if (ret) {
-			DRM_ERROR("failed to create device file pp_cur_state\n");
-			return ret;
-		}
-		ret = device_create_file(adev->dev, &dev_attr_pp_force_state);
-		if (ret) {
-			DRM_ERROR("failed to create device file pp_force_state\n");
-			return ret;
-		}
-		ret = device_create_file(adev->dev, &dev_attr_pp_table);
-		if (ret) {
-			DRM_ERROR("failed to create device file pp_table\n");
-			return ret;
-		}
-	}
-
-	ret = device_create_file(adev->dev, &dev_attr_pp_dpm_sclk);
-	if (ret) {
-		DRM_ERROR("failed to create device file pp_dpm_sclk\n");
-		return ret;
-	}
 
 	/* Arcturus does not support standalone mclk/socclk/fclk level setting */
 	if (adev->asic_type == CHIP_ARCTURUS) {
@@ -3312,11 +3294,20 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		dev_attr_pp_dpm_fclk.store = NULL;
 	}
 
-	ret = device_create_file(adev->dev, &dev_attr_pp_dpm_mclk);
+	ret = sysfs_create_files(&adev->dev->kobj, amdgpu_pm_attributes);
 	if (ret) {
-		DRM_ERROR("failed to create device file pp_dpm_mclk\n");
+		DRM_ERROR("failed to create pm sysfs files\n");
 		return ret;
 	}
+
+	if (!amdgpu_sriov_vf(adev)) {
+		ret = sysfs_create_files(&adev->dev->kobj, amdgpu_pm_non_vf_attributes);
+		if (ret) {
+			DRM_ERROR("failed to create pm sysfs files\n");
+			return ret;
+		}
+	}
+
 	if (adev->asic_type >= CHIP_VEGA10) {
 		ret = device_create_file(adev->dev, &dev_attr_pp_dpm_socclk);
 		if (ret) {
@@ -3352,23 +3343,7 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 			return ret;
 		}
 	}
-	ret = device_create_file(adev->dev, &dev_attr_pp_sclk_od);
-	if (ret) {
-		DRM_ERROR("failed to create device file pp_sclk_od\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev, &dev_attr_pp_mclk_od);
-	if (ret) {
-		DRM_ERROR("failed to create device file pp_mclk_od\n");
-		return ret;
-	}
-	ret = device_create_file(adev->dev,
-			&dev_attr_pp_power_profile_mode);
-	if (ret) {
-		DRM_ERROR("failed to create device file	"
-				"pp_power_profile_mode\n");
-		return ret;
-	}
+
 	if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
 	    (!is_support_sw_smu(adev) && hwmgr->od_enabled)) {
 		ret = device_create_file(adev->dev,
@@ -3379,13 +3354,6 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 			return ret;
 		}
 	}
-	ret = device_create_file(adev->dev,
-			&dev_attr_gpu_busy_percent);
-	if (ret) {
-		DRM_ERROR("failed to create device file	"
-				"gpu_busy_level\n");
-		return ret;
-	}
 	/* APU does not have its own dedicated memory */
 	if (!(adev->flags & AMD_IS_APU) &&
 	     (adev->asic_type != CHIP_VEGA10)) {
@@ -3437,16 +3405,11 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 
 	if (adev->pm.int_hwmon_dev)
 		hwmon_device_unregister(adev->pm.int_hwmon_dev);
-	device_remove_file(adev->dev, &dev_attr_power_dpm_state);
-	device_remove_file(adev->dev, &dev_attr_power_dpm_force_performance_level);
 
-	device_remove_file(adev->dev, &dev_attr_pp_num_states);
-	device_remove_file(adev->dev, &dev_attr_pp_cur_state);
-	device_remove_file(adev->dev, &dev_attr_pp_force_state);
-	device_remove_file(adev->dev, &dev_attr_pp_table);
+	sysfs_remove_files(&adev->dev->kobj, amdgpu_pm_attributes);
+	if (!amdgpu_sriov_vf(adev))
+		sysfs_remove_files(&adev->dev->kobj, amdgpu_pm_non_vf_attributes);
 
-	device_remove_file(adev->dev, &dev_attr_pp_dpm_sclk);
-	device_remove_file(adev->dev, &dev_attr_pp_dpm_mclk);
 	if (adev->asic_type >= CHIP_VEGA10) {
 		device_remove_file(adev->dev, &dev_attr_pp_dpm_socclk);
 		if (adev->asic_type != CHIP_ARCTURUS)
@@ -3456,15 +3419,10 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
 		device_remove_file(adev->dev, &dev_attr_pp_dpm_pcie);
 	if (adev->asic_type >= CHIP_VEGA20)
 		device_remove_file(adev->dev, &dev_attr_pp_dpm_fclk);
-	device_remove_file(adev->dev, &dev_attr_pp_sclk_od);
-	device_remove_file(adev->dev, &dev_attr_pp_mclk_od);
-	device_remove_file(adev->dev,
-			&dev_attr_pp_power_profile_mode);
 	if ((is_support_sw_smu(adev) && adev->smu.od_enabled) ||
 	    (!is_support_sw_smu(adev) && hwmgr->od_enabled))
 		device_remove_file(adev->dev,
 				&dev_attr_pp_od_clk_voltage);
-	device_remove_file(adev->dev, &dev_attr_gpu_busy_percent);
 	if (!(adev->flags & AMD_IS_APU) &&
 	     (adev->asic_type != CHIP_VEGA10))
 		device_remove_file(adev->dev, &dev_attr_mem_busy_percent);
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
