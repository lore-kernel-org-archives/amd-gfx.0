Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D278C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 20:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 658D310E46E;
	Fri, 21 Jan 2022 20:31:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B50210E46E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 20:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+Gn4wufBkJxPVxmGiHp1oE3pvjdA8WDUZemEnvrare+IY/qzMk6IRmtlqZ/CFpKQTAkTIirClnkZ9nExsRN+F0ym2HQze04xgscmXwd7uaZq6OoJ2qCOpylQJF/wW6Xjt+wD183XVTwbC/cdFs+QIvCM3+c2ftpsCK3t1xTrmn9Usp3yuc58n8tTC89MEo/Hz8q5iOK9Nq9ncdvLG7dGHPL9WObLe/2y7l+d1gSbweYfY5bK7rz4e/WONd0Jj3Wgqchi9Rve1Hty6SjnTw+jWEre7lx9E02Prumm2M2Tn/bCFgA9p8aYh24MHxNWQT4DPqPL+XFZK859Xa6iF5y6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLTBgpZ557a3CxJ2eG/41v3tPchjwAy41TYKARG5aeQ=;
 b=c+2nfxjfG5wbfwkjZwiLmyTFydIZ+qrGv0w3Xh5uflHs6d0bM/S2YWqQRd02Gq0Vm6MkW8c8bYzs0Z4Tp6uuA/PILmSX1hKjAap8PcBmTjgY0wdQUXlhy4Z49sPN5YZau3mW9vmoCCqFehZCx5CfGWjtlPkLQUgf7SakxGzdMk3qHeWikEditupofoylgvJ5zw7yefbXnz9xwvODGynrPksipJZxiotjy/w2ZHzkJhSOfhFZVlBHf8+0XUnV2NwW/ljcSbChzIO12GUTrtsTmKHEyhwXAaeuU71SWM242kDro6w1hdmYKmPVQwwVzEzekP2Ygp6xQ6OvNreqhjoDvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLTBgpZ557a3CxJ2eG/41v3tPchjwAy41TYKARG5aeQ=;
 b=Rq/4UNCYq1Yngbash1smedontZ3TCIehnf0olAr//qAHHnnKFuJyVHLawxTshW81mJbSFj+c9jNnviXBLk9mUgFFyfT7uq8ePOcySjt5V4yIwdxyaxAw7HYorjrUTFtoo50ziqV0IvznPPtBNwByTGzlt1TUSPowbotb1DSA1BM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Fri, 21 Jan
 2022 20:31:37 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 20:31:37 +0000
Message-ID: <0d298b2e-b0ba-160e-25b5-e324a88b06ad@amd.com>
Date: Fri, 21 Jan 2022 21:31:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Subject: [PATCH 1/4] drm: add a new drm event for GPU reset
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::34) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6c6787d-8189-44f8-fced-08d9dd1d0587
X-MS-TrafficTypeDiagnostic: DM4PR12MB5295:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5295DD91B038A5AB1229FF13F25B9@DM4PR12MB5295.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7+WIu698BRKTzML+1zaf7sFzp+dUsP5ZtUOcQ0kbbD1Qul5eJyrN3/Iv+6OE3wEUxjlnZI7k6vaYb4ICdCaIf/2AXxWWvqyYWPtawLIFNzOzOTPnkWK073EyD/VU266+3S4bspYVUk1u4mY17IHkvRnkDVt7IWxnBnD4x/ErKdYN9RRdfdztMzHkQ86H6ioMbkLsjgVKv2FubDZRPO0IEIoBj89d/8dVwhblehy7zr5tSaS6LBwVOu8gWzTn1Zt1k70rJv/GFV+IWvTAXMxcSZ2jYwoQzGWjUeeCXlaRu3kHvacrthr6mGNDczGv1tNvyMCRY3SWDMLJ2IBQ84ID63JrA4acdHIzKmumjhfPnaPt/95LLwyziiYLjnGSXCyxV0oKRp8F/P+1x9AScBMn200Eldiqxvo6+lepma2FALPC4F1R02LCJLlVwL9ND8J/DP98wcIvtbNB4Lvvdghv3G23Ix8PVvxjJ9QjbMqJ7/61Q6FuM4AAC7rLNdgsNqbgYDZqxcKaaenPbpTUClH0QoPFRVDr/we/NryAHimvBWmpOBeGfyFNeeSlXP9x0mMgOojzRvvgP2AYHXMI8SH9fMKGzkjQYN2/YxcrR/wpn+E3KdeGdmGw6XEf6TnrEK2Gp3oLFXwEFTBJubvwIrnOL2xdew5id4BE8SX0dIQBI0oC1fOcU+aZDxCiVvwikK+aVMPyz+vxD3Tken21wxjBp67354DB3LDwKxxZKkGbmTqJK26eGkKAbpF7ug6muTF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(66556008)(54906003)(508600001)(6512007)(31686004)(186003)(2616005)(66946007)(6916009)(26005)(86362001)(6506007)(53546011)(8676002)(316002)(38100700002)(6666004)(8936002)(36756003)(31696002)(66476007)(5660300002)(2906002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yyt3dW9vS01tSFo2c0dlNWRNVk15eWd2WFpJRFYxZDJGUEFZS2RNbE1pb0hk?=
 =?utf-8?B?S2pnL09yc3NVdlFHWmdsWGZIWm5vbmFNMFJEdWd5QmRoaW5ybWVLMzB4V0dh?=
 =?utf-8?B?TS8zTThYR3lEOUZWUUVlUzBKUjYxOXNjZ0xNOHBqUVFLYmgrZVd3TVptb2hD?=
 =?utf-8?B?dDRjOTlGRkM1ZWptL0gwclVGWlQzQUZwUFVTMmJ2eWd6cDVoRFV2UEcrWUg1?=
 =?utf-8?B?T2VxY0lIcFhvdW15WXp6UWIzVTF5ZmJxN2Z6UFYxT3BXQU8xWU80U082NStI?=
 =?utf-8?B?RHlpZVVSTHBybVM1eTBaSjRYVmhyaWMxK05jTnZLRE1sa0RZcUY3TS9ud1pv?=
 =?utf-8?B?aHMvNU0zKzRjMVlqYk0vcm00Kys5SUw5V2xIaW0veUhVU1FCanI5aU9uNUY3?=
 =?utf-8?B?UG8xZEk2TEdtNFFhME5TMnBpb0ZIeUVSdzBjTkhaRDRaU1Z6TklPWW1FTUZk?=
 =?utf-8?B?OUlRV21NbDkrUmZkMFhYMGRXVVJoT2NLYnk0R1RJdnpaYko0SU5vTjRCbk9W?=
 =?utf-8?B?ZHZRRk1mRlg1UkVBbUxmVmNOeE9NRURHRVhMQ2ZTUlNUakNhSFRMS3R2Z1lI?=
 =?utf-8?B?WWFXMjFJdUg4QjIrb1JpNGhvbzllblM3enQ4SWtDMGtROEZickNCaXVzbmRa?=
 =?utf-8?B?L0hIMTV3eTZYS0srMmwvSFRGN2VOM3d5S3lDZU55MkV1Y1hFMksrbU5ncDMr?=
 =?utf-8?B?ZjJUZ2hFVTh0WTlyellXMmlZZklJUzlrd1N6QjJXRmtiWTY3NWtwbGNWL2dn?=
 =?utf-8?B?S0NkRGVXZUpXZ2NpYTZzeFAvaGRZelV0dlc2c1JhaXRNbC94NFNVaDl5S1JI?=
 =?utf-8?B?ODJsb29JcDRnTit0QmxzbXdRcG4wak9kZWlMMHlGWUcxWjRFVmQ2Tm9MdHpj?=
 =?utf-8?B?QjR5T21HaFprbjdUbnNSU3BJazVuM3BaalNZV2FQbFZFc0VpYTlVY09oN2NE?=
 =?utf-8?B?ZnRnbVhBWkduN1diWXZGenZxYjd5czUrY05Uc0RhZHppQWlRYk9BOTQ5Ry9H?=
 =?utf-8?B?SS9UQTk3SjFpTzJrUVlvTG11cUJXQVVxc2JETHNoZldTVklkMW9QTk9xcHVt?=
 =?utf-8?B?cVRMaTE3WGU4NUxjSDladDRLOENNQkY5bFdvSk1xenRHRDRGSVE3L1JuMElr?=
 =?utf-8?B?REdvK04rdFdFSmNnS3dzeFZ2TmtjZy9jeUZXR2JMSFdFMHFlZlJZblpiVnJn?=
 =?utf-8?B?RDZUUFZ5UWloSFZ6Q3BpY0NsMUIxOEhYK081b25Zb1haS2VHMWtSUDFoeXFZ?=
 =?utf-8?B?KzlGWG5oZVlydzlyRXMxUXRKMERJYld6QXJFalVWdDZ2TllWOHNRUkVZUFR1?=
 =?utf-8?B?RnlpNnhHbWhBaExqZ1dnSmJkRnBUM1F1dmJZR3czWXZ5bmZtRjVXMWppckwx?=
 =?utf-8?B?azhHdzFGVDBBYWhvTys2T2pxWldhZWMzY2xUYVNXN294VGNrVyt6YStRLzFN?=
 =?utf-8?B?QS9nTUxrb3RuOXFhWFR4NEVXaURhZWU1bjRNRjlxSWtjVXcrT0RIZ0NGMFM1?=
 =?utf-8?B?VHBTTzRYTFlIeWpuVnp1VEdGd1BnOTZ0U3c3L1J6WXNGRXlnSmFjNnlWbmZq?=
 =?utf-8?B?TE12ZXRmS0VraEhPYnlCYWxSSlg0ZElqcUVFVGFNL001OXBJVjRob3hhZ05D?=
 =?utf-8?B?MSt0M3ZCR2FaRmhwUkg2WkZ1NmRqSFh0U2lkb0dYZEJ0RWR1Wm1IS29hNGZS?=
 =?utf-8?B?MXR0YkxibkR5eUNVZGZJMjhvaW5pU2k2VGhqVFlsTmZrMWZqNUVvWXBXNmYw?=
 =?utf-8?B?TStZZmU2bFRvNndScURTSC9lSXVFU2I5c1JpMFJUREFKWTJKeFg5VUEvK1FZ?=
 =?utf-8?B?aW1ESTN1c3JzWHhoNFV1bWQvTFBKYmxmSDFyUDhGd2k5UEVxVVJpUyt2VEtH?=
 =?utf-8?B?aTRKTXN2a2N4SC9mZlZMZ3Izckxnb0hiaFF0VmZBbnpYNjEzZTgwczcyaVV5?=
 =?utf-8?B?RnQyUUJXRmlwdEVZR3VBL1ladThoU1paR2hrNVZXeTU2NU55QUVwZEN1bExn?=
 =?utf-8?B?UDdoakdhSFVzNWcralZDeFN4c1A3eWdWd2lxb25CRXpFb0s0QVQ5aVRjcXdS?=
 =?utf-8?B?dFBpRTBVb2drYWFDelJCUExlQ3ZJc2cxcDgrZjFnUy92VmM5N2VyT2w0em9M?=
 =?utf-8?B?b1lJVlVmMjZhNVZVVlBId2VXbmsvMSt1M2UxQXJOZHk1a3FTUXRhYjVoVUpT?=
 =?utf-8?Q?Ortpv9/TeB/MZIWh+Yca5Fg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c6787d-8189-44f8-fced-08d9dd1d0587
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 20:31:37.0430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJAIg7dTK7jMlPZA8XM6cp9yHbosfE5fU6PF5xXmNjtHRVsLSH/TNqtEWXQ9p/xexkmsVhWF07zCAJ3mrwAqdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5295
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 From 8144e60d9f80941dd9f8a53e4b468582aaa849b4 Mon Sep 17 00:00:00 2001
From: Shashank Sharma <shashank.sharma@amd.com>
Date: Fri, 21 Jan 2022 17:23:41 +0100
Subject: [PATCH 1/4] drm: add a new drm event for GPU reset

This patch adds a DRM uevent to indicate GPU reset event. A
userspace can register to this event and do some postprocessing
if supported by native driver.

An example usage has been added into AMDGPU driver in this series.

Cc: Alexander Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
  drivers/gpu/drm/drm_sysfs.c | 19 +++++++++++++++++++
  include/drm/drm_sysfs.h     |  1 +
  2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 968a9560b4aa..0d721d536bb1 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -343,6 +343,25 @@ void drm_sysfs_hotplug_event(struct drm_device *dev)
  }
  EXPORT_SYMBOL(drm_sysfs_hotplug_event);

+/**
+ * drm_sysfs_gpu_reset_event - generate a GPU reset uevent
+ * @dev: DRM device
+ *
+ * Send a uevent for the DRM device specified by @dev. This event will
+ * inform userspace that a GPU reset happened, and it can do some
+ * postprocessing (eg: data collecting from a trace event).
+ */
+void drm_sysfs_gpu_reset_event(struct drm_device *dev)
+{
+	char *event_string = "RESET=1";
+	char *envp[] = { event_string, NULL };
+
+	DRM_DEBUG("generating gpu reset event\n");
+
+	kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
+}
+EXPORT_SYMBOL(drm_sysfs_gpu_reset_event);
+
  /**
   * drm_sysfs_connector_status_event - generate a DRM uevent for connector
   * property status change
diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
index d454ef617b2c..312956a0a1bf 100644
--- a/include/drm/drm_sysfs.h
+++ b/include/drm/drm_sysfs.h
@@ -11,6 +11,7 @@ int drm_class_device_register(struct device *dev);
  void drm_class_device_unregister(struct device *dev);

  void drm_sysfs_hotplug_event(struct drm_device *dev);
+void drm_sysfs_gpu_reset_event(struct drm_device *dev);
  void drm_sysfs_connector_status_event(struct drm_connector *connector,
  				      struct drm_property *property);
  #endif
-- 
2.32.0

