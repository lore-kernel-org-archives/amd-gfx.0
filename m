Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ED3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 20:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 428CE10E5FF;
	Fri, 21 Jan 2022 20:37:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B4810E5FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 20:37:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faWubIdGGyYBI1MsxjBCgUiw9erCoyNjXJCnGR7QhZOIWzCNgGduA+cD0/Jg6f0ao3+Q7/dTqVV0Yk3Qo7l0oovlMlrjk8zb9jimkjgTTsMp71RfJBa7ioSCP079GmdcuhHHtj9PQaSt2ouoPfRRoAitOkvsVh5sZIB9/n7iSlH/iOEN5QMp6OUjad+q62ZUzbQSFBl3Khr+kBKf0Z08XyX3aBZrOsJ33hMUApcnxPKOICuzOcDTkCt70p5Sgwoxo6sPKc1gvHxwXeO5USSPg0+gcAvemphCvJika9yy5nal/UsMslqGFkbsAtWyIqWBXZVlqKKOm3mZEEyB9PrMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/ba6m5+3/j0HVRH+Dr3qX+SfNxNUn8adJvEcBTsTRI=;
 b=bAVNu+xV95idMe3ZHEG4iY1G+gIw/RPT7dDBej8JKOQif0s+L+SNl/HOI8+k4wDbYEfm/ldLV/ScWxOpShoYzC1abjKqOrXXY+mvkHba88AG+n58MRQypcaHw7F7hsrFDH73lIeAtE4RYp05MXzaYFVxDsZD/F2qqIGXa8OCY9TWNNDcofWkDP4WNfIRRptkjONj9chI82tyUzjaVl8zMYHqcw90bqYV67ZuOAps8+msIw7HEzPTiUg8hi+8ZlHylGIDYw4puTNBvbiEQXMUf6JMP1KzTqpNdXb4B/Zn2jSoq0HWZNvCYirtFf8YaeomFQE4MjRk/XKsZ74kGHbePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/ba6m5+3/j0HVRH+Dr3qX+SfNxNUn8adJvEcBTsTRI=;
 b=yOePyChi3/I9TTDfo4fClDEIdP0bkXOAXV7qLH7vfF/HrZijrN3vvMycZIoxxQJSGkmLE+JE1PdsWcBpgYfNHePYoPtt1MgDAstZFiCyYXFAncsA+TX+hjSETXp0BgVyfnzBwObUjNG4Z8ELk2M/hVmB4zVhv9tgwya/Ibe3XXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SJ0PR12MB5501.namprd12.prod.outlook.com (2603:10b6:a03:304::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 20:37:46 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 20:37:46 +0000
Message-ID: <b951f172-45f4-c88d-6655-8eec715c038c@amd.com>
Date: Fri, 21 Jan 2022 21:37:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: add work function for GPU reset
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::23) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 943ca261-66f1-421d-f10a-08d9dd1de1af
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5501:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5501642799BA56E9130AC105F25B9@SJ0PR12MB5501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OB6BxebVEDoVmTJQazc9BbfKiVqU1Zw+cn8n2gmjhPTqN1DwU0a0RQw7czZ8xiu7Lxe/GYdu7WBLcnFbPQb2ncv/5MOqZuY/sqt26L4SQAZzsod95yVLN0T71t8ZvAop1uOu+Ue9DZLf58mVg+d3wGtEOplL0Pxi2a25bsZqw30V85K/WvEU81tsiVyhuJANJbOAZUv37o2tfMeCPrVxDwqO1qp23SlrFAwoC6svko43HnGsy31s70QidZOweNphKuKQy1uDS7cy3Wy4LU4r0K9gTm9tNQYzpdXx6hIr7rgygsVlM1VfD6lIEad8eKW9jtX5wUu+MSz5WYO/skAlbYYlnu1VLg5y1Ic0fWWJmuqsWy/au1qv57Onx0fHuXDC66Pw9K7x3A1vYR7gXUJh4E/3t1Cu7q4lktOSrnuraD/0NFltHOe+j92iNJ+D9Y0Qa1dSmtCFn9vNXuwyW1LUAW8yjijz2wa1BYRBMlPyyXyVe2XBJbkgiw9kt/uybwt3BRwmCXLjPFS+MtjwJTR7EokdfgHAvSMPKBnwTWBeJAD/2en8q0mgA92QaDRDuvoGGY/SrEMYkeibOGWv3OA1X0EzCpvQqVzjaYSaj0eB1zslBkSDykAkHzZ2V+T9KuzsxeVH6gS1fu7pKd1OverwFBCu3qm5pnn8ifkBcVUYbNis1RmP8xbiwss6zgKL4vvZChxm1N2W+NeYhpM9Yuq8sADV9cht5jSZtQOCxRX/CdcfchkT+KSCzdiQ2hCyLfzc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(508600001)(31696002)(4326008)(36756003)(316002)(31686004)(26005)(186003)(6512007)(6666004)(66946007)(66556008)(66476007)(8936002)(8676002)(38100700002)(6506007)(6916009)(53546011)(86362001)(6486002)(2906002)(54906003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW0wVTI2WktpQm5HckozbkNLZlMyTHNxWDR0NHZ5WTF0YnZlSUQ5TWprS3B5?=
 =?utf-8?B?TmxKWFVZUDFoSEdBR043OVBOR3dtbHFqU2lHdkhlcmgzbk5kL3FzcVRqcWpD?=
 =?utf-8?B?SXRxRnRwZ2dYYmR0WWt1TmltbHhVd2NZcHJwNlpvWWFBaW5QNVF2YXFKcmM4?=
 =?utf-8?B?UjJNTEZYSVVtaEFNNmhuZFZkamFWeFdWZWRLSmxvVW5MbXd0NUdxakw0Vkgx?=
 =?utf-8?B?Uk9KZWoxMXF2QlRsNkcwZ0wwOWc2RnovdTR0RGhGTk1MVm91alBOOG5lUllL?=
 =?utf-8?B?VVA4RjlFVHhtL2tydzlRZGZMR2xxVldhTnc0NXc4VWd5RGZhSGhrOWtrYVlP?=
 =?utf-8?B?MFgxQVY1cHIzblhTUktHWi9mbklEcGFoVzhlang4VlVkVmhvMEsyMWUvYWlz?=
 =?utf-8?B?Ly9mSEN6bnFyN0ZpdVVGRW5tWjBqQmo5dWMvWTdvZTZCUFNDVW9ldk5aOGZ6?=
 =?utf-8?B?cXJ1SmJQZkxBdytJekdIYUhmZXRMTkNVaWZNYlZiYWlJTVptSUVBcTdjMDMz?=
 =?utf-8?B?R2VjRDRLdVRrY1QxL29Ca2VOZDkxdGpTZk9oMFpDYTZMMVhDMFBEWmdUV2tl?=
 =?utf-8?B?L0lURUFDSjBOc2J4V2o5T1htcUl6alVIYkRqVCtTWTZUbXdjcVVoRTg5YjZN?=
 =?utf-8?B?d3ZueGhvTmw3cVJhWEFuYUxyMnJ6VnRHZVI4aklQOEwrWFZIc0tuWG1STmZr?=
 =?utf-8?B?bWZUVCsxZUVFeUk3NUZIRXRMRDlTQWVQNFdSTjIrcTRXVnJQRmVxS1lxL2tW?=
 =?utf-8?B?TGMzRG4yUytZZnREWWpaRi9VanJGdVNWLzQyU0w4VDh3bmZJZ0k0dXdjZng4?=
 =?utf-8?B?OC9mblUrb0tPRUdDS0pNU0V1V1dlMU4wNU1OaHdCL3lyVTczb2hIMTAvRHow?=
 =?utf-8?B?M0RrS3NNOUVuRTJ2K2JWSFdPWE12MWJXMEtJSXlyckQyaXN4ZHRhL0lKdVVt?=
 =?utf-8?B?YWVwWnVaTnAzQ2tXVXZlWVYvL1BsenFDNytuaTZZTTNETnZtRkYzRk1MaDVD?=
 =?utf-8?B?WndLNG12NTVPTi8rTmJCTE5PS0pPMlVjRkMvU2JGMTdHZEpXbVgwRkhKUkly?=
 =?utf-8?B?eWlLcXBJZkRDYU1xOWFIZlBORk4vVmFxYXRQYXhNTVpOalF6Yk9XNEdHUXl2?=
 =?utf-8?B?R3lyVzB1dUhyWElpQStIczluY250VW9EU0JITkVXQVpQdVdsZFNrbzhhdGJ3?=
 =?utf-8?B?amVWUmNVZ3VDL1lMRWhMZFBVNTNMalBwalFRM2h4T3V1c09vQXlCTzQwMWVO?=
 =?utf-8?B?cTVtYVlxcW9uY0JqdTNSNjhyclA0aVViUXowMWlhVGVYNTJ2Vk5BSElrZXlx?=
 =?utf-8?B?STlsMlVLRytHdk9LcEYwTlNuYXgySGplMmk2RlZIdjQwL2ZDVjJKQXhtNFN2?=
 =?utf-8?B?VjVyd05KK3g1OVVOV3JIMFF2VjJFTzhJUG5KcmhVQTgvZDdvSEtKNHNSUW9U?=
 =?utf-8?B?MHBaTGFPNHFjWVNSYXRmZ1RXMEQ1TmpvRDZKVnNuNnRZNlcwOExqR3VwQ1R1?=
 =?utf-8?B?TFhIY25TK0hZK2k4VkRLdzl0UXBQa0xBYkQwR2xoZGpDaWRxSStxTVNuUHBl?=
 =?utf-8?B?Sy9ZblBQejZGV3VKbzNwOHlsb2pIb1FmT0pieFhvVWwvZFM1TW1hRXZmVnZt?=
 =?utf-8?B?V2JEUnZVdWs4UEgxcldyeUxHQUNWTzVoSDc5OWZ2c3Bjb1pjT0NqQ1Q3Tkd5?=
 =?utf-8?B?cW5PRVVtME9qdVRpbDFUVUs0c0liaE5MbldJb1VyVWdtYjJpME9PUG1PQUJI?=
 =?utf-8?B?eWdkTHlTZHhuanBmMGhjVyt0UzFyMVNhcWZCM3FoVTJLbmNPZ2I0dE1tRldZ?=
 =?utf-8?B?eHhvN0sveURpTEVaTEsxSFJ6UzRVMVRkU3dRNEhBUHBsLzg2L09lRmF5OXhG?=
 =?utf-8?B?RGlOblhKelVGdC96T3Y0WWVadEl1dlB2cGNKTWRZaGRhWGN2VjJibVlqaFdl?=
 =?utf-8?B?THBuNFNNeklnbEo1ME5Sam5KYjFGdGNCYkNlNHNteklpRk1uYVVPSVltRTB5?=
 =?utf-8?B?cktJTTdxNEI2SlV1dzlES1Z3UTdHMEdSM3Z4VWNtOTU2ZkVIay9pWGREVHh5?=
 =?utf-8?B?WUFQUkhnOE40Q1lwbjB2YkFiQ09yM3FHWWNzNlZuc29QL0wxK1VNa3RZN1lt?=
 =?utf-8?B?TmFWaDExdUpIUDZabTFpUGNmY0xRSmxjTDdhQzY3bkthOHgyNEV2QVB4cXNy?=
 =?utf-8?Q?r3BwZF5uUHlNL+oLMQNR+1Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943ca261-66f1-421d-f10a-08d9dd1de1af
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 20:37:46.2954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +t8HxaEIGlG1ztBpkori1Np381gZcmA+oDmbC3vzwoi6mBfMQkBapVmGMNJbIFQURhYQJm0fy4EvFNm9K+Bjww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5501
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

 From c598dd586dd15fc5ae0a883a2e6f4094ec024085 Mon Sep 17 00:00:00 2001
From: Shashank Sharma <shashank.sharma@amd.com>
Date: Fri, 21 Jan 2022 17:33:10 +0100
Subject: [PATCH 2/4] drm/amdgpu: add work function for GPU reset

This patch adds a new work function, which will get scheduled
in event of a GPU reset, and will send a uevent to indicate the same.
The userspace can do some post-processing work like collecting data
from a trace event.

Cc: Alexander Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 ++++++++++++++
  2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 269437b01328..79192f43bb71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1057,6 +1057,8 @@ struct amdgpu_device {
  	struct work_struct		xgmi_reset_work;
  	struct list_head		reset_list;

+	struct work_struct		gpu_reset_work;
+
  	long				gfx_timeout;
  	long				sdma_timeout;
  	long				video_timeout;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index af9bdf16eefd..e29e58240869 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -72,6 +72,7 @@
  #include <linux/pm_runtime.h>

  #include <drm/drm_drv.h>
+#include <drm/drm_sysfs.h>

  MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
  MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
@@ -3274,6 +3275,18 @@ bool amdgpu_device_has_dc_support(struct 
amdgpu_device *adev)
  	return amdgpu_device_asic_has_dc_support(adev->asic_type);
  }

+static void amdgpu_device_gpu_reset_func(struct work_struct *__work)
+{
+	struct amdgpu_device *adev =
+		container_of(__work, struct amdgpu_device, gpu_reset_work);
+
+	/*
+	 * Inform userspace that a GPU reset happened, and it should collect
+	 * data from the trace event.
+	 */
+	drm_sysfs_gpu_reset_event(&adev->ddev);
+}
+
  static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
  {
  	struct amdgpu_device *adev =
@@ -3506,6 +3519,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
  			  amdgpu_device_delay_enable_gfx_off);

  	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
+	INIT_WORK(&adev->gpu_reset_work, amdgpu_device_gpu_reset_func);

  	adev->gfx.gfx_off_req_count = 1;
  	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
-- 
2.32.0

