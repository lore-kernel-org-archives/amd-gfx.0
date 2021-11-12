Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93318C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 08:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4670260C4A
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 08:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4670260C4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6B386E985;
	Fri, 12 Nov 2021 08:05:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53E5A6E985
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 08:05:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF1HL1xiAKt/l6EwwyJiH9gncpA/3O6yS0VGTepy321LRFWeftydtLEFW4xm6gjp0ZPii0aH02Xgd4VC5YzXyk8wC7lNyOsm9LpqsT+lhIdVioRkI8Afv4xmBHC3upCGvH/JoyBEYd48aEf2DyyssBIuTPeeloJfuE6OBHYrCzCChEZytLpvD3cZQYwojiUslE9MC84ba+zj6VT4gVmzuAQVK3W/tPP8Zl+UGYQmqQTXo9JkHGEP1dCTHRE0ncR/OErObBTV0RP7DtP7B6HAH4yCRNk7yXtHCdJcW9by+GUxCVpu6Gemx+bZkDXxw5LCwbncuoQYhSoJgaO1Do4IIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgwQZogCkaFSY+yCstnjXNZo+k1mZgZasovSUa4yjvQ=;
 b=QcvN/7hItqEGYiFtf4PbRMH5gy9kSPUB7fTW3yq6him+Da4CEbSxw+7j3P/KIc10N7yjNghDdP/ITG3MYD9uujB9GyCvO+rLD/M2GgUstouB7KmHYNJfg024Q/Ks1Hc7gxlCdIba4j1q1t1X4ahRR43RMOSDfbQBqHyLJG6Xd196CWlIjplFP2IAjA/7bAtE9RAG5m7mC3WPcYNpun75J4d4QnqTQNA2QNCCUQBrQ98XeA4TTzyTzsgywXIt45qNq8XR9wZlOAb4D/hOQtzfGfwdNcu3F3FuTsQD5EykZ0Ls7MA+qlM8V/RWOMOj/Bok2HzYH4Piw4OwhJAVt9z/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgwQZogCkaFSY+yCstnjXNZo+k1mZgZasovSUa4yjvQ=;
 b=ZoyZiEepWSU46LlKO42YcwgJCQs0rcIphBYal9nuQZT0G4oR7aNrdfuy+YwWgycIm7heqTD9oBlJikrXqNRHNbRjeOcQSZ8Vsn4rAybblaUjf0XphmSLvVQRKvAm/R+V2ULCukuOj15VNhshcS+JasBxmfgLEn9xSLy2Lc0R/Tc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (10.255.174.19) by
 DM6PR12MB4012.namprd12.prod.outlook.com (10.255.174.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.16; Fri, 12 Nov 2021 08:05:12 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 08:05:12 +0000
Message-ID: <a776e286-3fca-38ce-65b9-d17c3477143f@amd.com>
Date: Fri, 12 Nov 2021 13:35:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/1] SWDEV-306029 - add new sysfs interface for retrieving
 gpu metrics(V2)
Content-Language: en-US
To: Surbhi Kakarya <surbhi.kakarya@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211111190514.11599-1-surbhi.kakarya@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211111190514.11599-1-surbhi.kakarya@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::33) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0088.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:23::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.16 via Frontend Transport; Fri, 12 Nov 2021 08:05:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c9e37c2-157a-41fb-f5bb-08d9a5b326de
X-MS-TrafficTypeDiagnostic: DM6PR12MB4012:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4012A934CA61E0267C697E2197959@DM6PR12MB4012.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: br8seD7bfexL1AQXdQlR+PGZGuRAvxPjpeWz2tCSgQKfm2YbAsYyzzlFkZ4K6qIcOoyCu+Zefyz3oZWTwi8uTlDdIZdloAM4ex+eYppGOXsqKlMttP2hdZlmV3LAKUrCG2Vj7ySnCvvFcWd08VRxLFlWz+iIacHtkqU28uQFY9omn57gzq5ycquucseQIGVEWpMQKE767Om1R1txFDhlLcyEKDh9nwORlCWy7Z/dv3svp4Q51Rh6yLr8AGJERkKnQ8kPEr6BuS7/zLC4+SSelvybPnXc6+4VqCuXllo6V0UPH6rz/tyIOINS4ZFs+GM0S16L5NWN+B4jzMIawK3p1BGsVJIBIolL8JZ4oWljRI83YUcXC37j9NQYkYNFJzokaLG0/q1ct49S0lInFyNkfc6exvVfruMYvZbB53pz4V9WHDxVpE+A7TUDd4Sl4YGucqKEURtwoX8UXLOgx1sYO2yQ11Jkr60eDQfS29OPSfx2bVhzlwH76TCxGLRag5JhDi9aoOtf+SBJ+RnWZfWW2ECfsvqUI7BXCKRC2u1NxPvowv+8hKY7wox8Hx9c3eVyybnWIEPHfnY/yC4vBwJ6YCicrIb9qoc9Divhjkx0BKOdqcqWfgS4vS8wFjRriS45kXpIFfvtV+bZRr5Y67uESpDZljlHXAGQIdSPHwml0DmOlvjODgHM9ZrsTEj289jczO2C38rp378uxuLFdXfBtV37LPdChFxvzbWmhEJPlVSwc6duNCLKCDLr19KdLcnzI7XqKtAnP+fGRsIYHizQIaUPS1AgFNXJ03QRQwmdU3mMuwtv8QsZ9947o2vIa4dl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(66476007)(36756003)(16576012)(508600001)(966005)(2616005)(83380400001)(956004)(186003)(31696002)(8936002)(66556008)(26005)(6486002)(53546011)(8676002)(86362001)(31686004)(66946007)(5660300002)(2906002)(316002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qkl6d0FxWkQ1aVFoTzdKdktxUjI1TjRiNnMzNkdOL0NjRmlFRUtHM05IcFhw?=
 =?utf-8?B?NnJ4NWoyb3dzOGZIRGs2WDZlRndiSHlDczJNTTU1UkdQeUJSRjNIelRnenZI?=
 =?utf-8?B?Rm1xRHhMTVgzYWd4aFhUb0ZCVFR2QzNHdUozQ2hadEJBdUM1VmN3aGJwdGRR?=
 =?utf-8?B?T21OcWx0ZGI0QTdTWWtXWlRGcFR4QytkbGZzS2wvcDJOdkpUdHdqUmVWRk9U?=
 =?utf-8?B?akdVNGV6RERHSHdJWFpNRnhiRzNWbXY3SEIxTmsyMDNXUG5wTjdKbjg0WVlP?=
 =?utf-8?B?aUNGNTNXWU5WWWlhclZEZy9YMHN6ajMyaG16Z3dFeURGb0REMnQrR0kvOURp?=
 =?utf-8?B?RDZpQWI2NWFjcmhNeWl0cVZKNnh2NldPL0R5eFYvb2o1SHZjbU5HWFRvRDJa?=
 =?utf-8?B?SDEzYkFyVEtVd3lxcTZISTAwUC9WbEJ0bUNuMDR5N0FId0d6S3pmSTNLWkNG?=
 =?utf-8?B?akM1SzFNQUlnbWlXelVzTXYyaVBMM0JiMUlQYjhJZTBzSWh4OXNzR3NpNEhm?=
 =?utf-8?B?dFpwVlRwam8vUW9GTTJza2lNYnAyeFNjUFlodENTMVdXb0wrMVpwcjduNHlX?=
 =?utf-8?B?QjZDa1FJNlVuNFBLYk1pRjAyeWNKN3FKSHZEc3lsZHlSL3FaN1YyS1FBVHd3?=
 =?utf-8?B?MW9Xa3VhaDEvZjdMMTBaVjJ0aVJ1L1hQTjJjWHVWOTRFVHBicWNkMWh1WXRn?=
 =?utf-8?B?WHl2ZWlMRmoxV2Z0SVdTeEFlVEE4ajBET094bXd1cE5kcXZtbWRuTHNKOTNV?=
 =?utf-8?B?RHZLbTY0WWFMYlBqS21Cdm1DYUk2UmZGLyswWmZtZ2Z4TU4wM2VORUZqd2xU?=
 =?utf-8?B?ZTF0NXNRb0JNYVZWVmV0ZFUwYS9vWHRjaHhoUThyRFVkeGJncldFTEJxZkJq?=
 =?utf-8?B?cnFuNld3MytRcDFscXRzS290QmV3b242SXJraFdVWDZkR3NyZm9FbjRTUERC?=
 =?utf-8?B?YTE0VEJYNlRHUytSZ24xcG80eHNhSU5WdDdBVWVvTHRlcHdxSkk2bmFYSXFF?=
 =?utf-8?B?NStOWnk5dWo2L0tMN1FKUmpDcG9WT2E3VC90WUF6V0V6YUM3U3puUm9nRDd5?=
 =?utf-8?B?aFFkYUFoUXJvWGRrdVhUZlZvNXNDeXlQNFI2d254cVk2SlhON1B1QjhRZmMy?=
 =?utf-8?B?Zno3cmw5V21CdmJ5M0hVU05tUnhITThUd25mYVU0K1JMd3RYaHgrMktaZTIz?=
 =?utf-8?B?Nk5JcGxzR1V1UkVlUko1NkYwRGc5UmFyRU5RbTE3NmNFZDJuRjN6L0RWdHVR?=
 =?utf-8?B?b2pVSVBnZWJBSm5KSkxHR1hOcnBGaGRTR09tbTFlV2xReFQ2Vm1ncjVpQ2pn?=
 =?utf-8?B?clM0N2MrSnAzdGlTMHlsVmZ3Skp0a3k0SmRwWVZPVU5BZVV6WXhmejMzVzZ6?=
 =?utf-8?B?alF2RUZDL3dRVU1DbGxSczdlNXJLYWZvWncwcklSZnBKZENrcXBOeDcxWDlo?=
 =?utf-8?B?cis5b21ySEtxMGtYWFoycEN4TmNtc2FDczhidXZ0d08xOXdDQyt6b2RsSkxa?=
 =?utf-8?B?anpoVHFrTXdXcHk2TmhZVkdrRTVWc0cwZElxYmg1SCtwSDNIQUkwelNNMi9I?=
 =?utf-8?B?K0Zid1I0Z21XY1BZQXAwZUhXekhZZVZHTG5UdkRDeEtYZ0dxcHhNV2RZd1My?=
 =?utf-8?B?UGxkUTJUQVVGUkNtS2d2ZGlUWW5ZK2FVeE9WYUlMejVUQnM2MlpGUVphcVBp?=
 =?utf-8?B?MFhJenF5SHRJMFJTZHZjQ29velovVWVwd21tczFndGRaMlZpMDdrd3FEMXZ1?=
 =?utf-8?B?Qy9yRTdSdWRYMUFRd2YrdkNiTTZwOFV3RjFpc3kxY3NxbnZwMnVXWERSOXVL?=
 =?utf-8?B?bWFOT20xaEZDQzRkZXB1TnpZdE5hQlpzV3VWYndZL1lmZWhrTEFhaHgvSHB2?=
 =?utf-8?B?L1pydUZVZS9RTzVtKzl6TEVlNUNsdHllYW44M3ppNmx2b2d1MDZyWFpLbUhq?=
 =?utf-8?B?eTc4cXdubFVSTVRZb242Zld5Mkg0cXBXcU5KbG96TVlKU3JyRWRlZFNjY1dT?=
 =?utf-8?B?anpWZW0zMDl3dk1PbUNCRFlyTnNyRUQvellzZUViUS9CTExQemdJY0tHWGU1?=
 =?utf-8?B?U1RxWWI5UUlWR3NFYTl1ckJCQzB1S2NjRTh2R0NaVDJkOGNCOHdhUlB2OFpW?=
 =?utf-8?Q?xk64=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9e37c2-157a-41fb-f5bb-08d9a5b326de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 08:05:12.4018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spwnrZOVJLALrXuidXQvPd8L7/ocGKGf8xUx74woJ4CGJ+gmfqZNmvNHDU8xN8PB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4012
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



On 11/12/2021 12:35 AM, Surbhi Kakarya wrote:
> A new interface for UMD to retrieve gpu metrics data.
> 
> Change-Id: Ieb8d56740147cf60a869a7fa0ef43d05cfbf802f
> Signed-off-by: Surbhi Kakarya <Surbhi.Kakarya@amd.com>

This is not the right way, looks like you need to port this to your tree 
- https://lore.kernel.org/all/20211019214934.4088-1-Vignesh.Chander@amd.com/

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c              | 17 +++++++++++++++--
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h         |  2 +-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c       |  4 +---
>   .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 10 ++++++++++
>   4 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 53bb2565cc61..2e5d2059556a 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1799,9 +1799,11 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>   		return ret;
>   	}
>   
> -	if (adev->powerplay.pp_funcs->get_gpu_metrics)
> +	if (is_support_sw_smu(adev)){
> +		size = smu_sys_get_gpu_metrics(&adev->smu, &gpu_metrics);
> +	} else if (adev->powerplay.pp_funcs->get_gpu_metrics) {
>   		size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
> -
> +	}
>   	if (size <= 0)
>   		goto out;
>   
> @@ -1817,6 +1819,8 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>   	return size;
>   }
>   
> +static DEVICE_ATTR(gpu_metrics, S_IRUGO, amdgpu_get_gpu_metrics, NULL);
> +
>   /**
>    * DOC: smartshift_apu_power
>    *
> @@ -3527,6 +3531,13 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>   		return ret;
>   	}
>   
> +	if (adev->asic_type >= CHIP_VEGA12) {
> +		ret = device_create_file(adev->dev, &dev_attr_gpu_metrics);
> +		if (ret) {
> +			DRM_ERROR("failed to create device file gpu_metrics\n");
> +			return ret;
> +		}
> +	}
>   	switch (amdgpu_virt_get_sriov_vf_mode(adev)) {
>   	case SRIOV_VF_MODE_ONE_VF:
>   		mask = ATTR_FLAG_ONEVF;
> @@ -3562,6 +3573,8 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
>   		hwmon_device_unregister(adev->pm.int_hwmon_dev);
>   
>   	amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
> +	if (adev->asic_type >= CHIP_VEGA12)
> +		device_remove_file(adev->dev, &dev_attr_gpu_metrics);
>   }
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 73fca113f3d9..cbb22d0c5568 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -1339,6 +1339,6 @@ int smu_set_light_sbr(struct smu_context *smu, bool enable);
>   
>   int smu_wait_for_event(struct amdgpu_device *adev, enum smu_event_type event,
>   		       uint64_t event_arg);
> -
> +ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table);
>   #endif
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b4ea8b233240..6a3424d0a014 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2919,9 +2919,8 @@ static int smu_get_dpm_clock_table(void *handle,
>   	return ret;
>   }
>   
> -static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
> +ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table)
>   {
> -	struct smu_context *smu = handle;
>   	ssize_t size;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> @@ -3049,7 +3048,6 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
>   	.asic_reset_mode_2                = smu_mode2_reset,
>   	.set_df_cstate                    = smu_set_df_cstate,
>   	.set_xgmi_pstate                  = smu_set_xgmi_pstate,
> -	.get_gpu_metrics                  = smu_sys_get_gpu_metrics,
>   	.set_watermarks_for_clock_ranges     = smu_set_watermarks_for_clock_ranges,
>   	.display_disable_memory_clock_switch = smu_display_disable_memory_clock_switch,
>   	.get_max_sustainable_clocks_by_dc    = smu_get_max_sustainable_clocks_by_dc,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index e0632530e9bf..cc5d9768c33f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3672,6 +3672,16 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>   	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
>   	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
>   
> +	if (metrics->CurrGfxVoltageOffset)
> +		gpu_metrics->voltage_gfx =
> +			(155000 - 625 * metrics->CurrGfxVoltageOffset) / 100;
> +	if (metrics->CurrMemVidOffset)
> +		gpu_metrics->voltage_mem =
> +			(155000 - 625 * metrics->CurrMemVidOffset) / 100;
> +	if (metrics->CurrSocVoltageOffset)
> +		gpu_metrics->voltage_soc =
> +			(155000 - 625 * metrics->CurrSocVoltageOffset) / 100;
> +
>   	if (metrics->AverageGfxActivity <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
>   		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
>   	else
> 
