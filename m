Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77495C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 15:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB11310E615;
	Wed, 29 Nov 2023 15:35:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AFA710E617
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 15:35:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvommdBU/p6CJq/csqYo6b4ZZ1Ww3ogL3xKxGp74QKmjxQ4GnpXJAEE/A9sQGxnk38GuwzfiK+BynRkvN1yYR1e0iJZrWifDrbHoGlNEnqoPzAFP2tn+lx1K+0qlSkmB5n6viuBNG3EiKuUHb/1TZ4SwtGMmLOHOKKjUC5QZj3NzLdF0uXTkqzwMjJ2sm+aurTQG5aDl0+9hsnTFVEnd0Bmj64wEXLMwLbw60tTRdiG8SOtdIjoaf4wcFynt2vR8n7gLWA06XevA/DbsSxh/ZYxWz8L2kO/ulY5n93Fg02CRoLIbe6+bAVY1D5CF87l5ddXfaUcG6GeJjvaNlnXP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aes6l6RAFAzTkFrf/TPFjXEi/k8h4yVcISfpYDskIiA=;
 b=jcOT4He9GTPSymqA9X9icbMdSoHG25n4HdJKa50U9N6BMN5v0mfLmTrEsdv8V8WWZ3xjyy9MKeE4vKWeBKtRKEYn+gJiPHayz2N1JydQBAeF3TBcsOQgteRMhQEtJbMVOHjz0FH39iLrZPR9/lbXU8FQCy9xHt4uC9hJ32TnNIHAhUkavNDCawfBByKJERW/XuQKciLsCe6pDu2VDMmiGFCjPjx0iov5auwinDdE2Oa437cNCON/oUXmJXa+atI3f6g2uvtSYUs6m2SgMDXVYdzkbbC8Av5fGg36pXUA/BKUqFWiPkhG83a1xfF6lGtZlI/lvZVbr0Lu0rLADPe+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aes6l6RAFAzTkFrf/TPFjXEi/k8h4yVcISfpYDskIiA=;
 b=nsOHV0tBp6UEvwDjKgG7i2KgPS7cAXchrAdhwvWYt23UNmtGZGPqZMSnmc7s49u3ZggUImrzPPcNffJmuqO/MqOeEp1uDuiij97kaEuxJpQykW17VSjZuf/1EouHkTAyYr3I5IwdHYewqs4at+fqdI8Wqg+WMWqGYYU6IXy2xrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Wed, 29 Nov
 2023 15:35:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 15:35:28 +0000
Message-ID: <d21116d8-9747-4b0f-b574-18b0d5558f16@amd.com>
Date: Wed, 29 Nov 2023 09:35:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add a new module param to disable d3cold
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231129085156.30698-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231129085156.30698-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:806:23::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfe8602-fa8a-4dd6-b2a3-08dbf0f0d03a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+n5q2b4MY9kNZKit24wHFFuhp0RDQikWNBCtixvZ6c13vQCh167YbiwVwEuWhD6pYTPC2GGeI9GPtgswRMAIZ2mXSWlYY6bZoxa5yDNgbcphq98/CTBM7GY6FqPiPRACUTL5LKz58IG1/h3rjQy0WmIFiEg1NLWBcyNHeKAgUJ/e4+RpIIT10yoypU36JTTJW4Duf2x2pZAw7Khoj6KFvKBM4aq3cM4EGg58oY/VcMwaqJ9wGwXeC47BddOE72toXdmPaWgsbooekuGJh2vzojtUg0y/TQ7rOPRU5LOTlJYgrmcqYPVbPQ77ofj/hTZpA335AZ0PLvV2uR7kzcMjMikpaSTEyyR3Kijo0cf6z6DQJaJ75iU/cdQz2z4lXxMp/S3+SSk8+WiJFJjSYxCB1iS1AouoLIluiKnDDsJIIojGeH2rNZi52erj5NrnhTDlwLf2mh3H6mmfQnK/BZe59svaFo3PdyqFGd0g3vRIt8omIZm7eUUGEEce1Uncuuqi6JLUZQe240hTcE4yzQrnp/t0ojhcbdfUsKsClUZ9vKZxo0g0PB18hIZM53RLeWBcjH63xaQBCrI15aydv4JDncHkPrOwiyH0fXhIBjsWIwIPM9YVqTDVHUR8BJgzqKf2VdV6ydyxCjW+pfvsQgs6ucjAlzn1yjAH6dCGZMhtuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(41300700001)(31686004)(36756003)(83380400001)(5660300002)(44832011)(86362001)(2616005)(26005)(6512007)(6506007)(53546011)(6666004)(2906002)(8676002)(8936002)(4326008)(31696002)(478600001)(6486002)(66946007)(316002)(66476007)(66556008)(32563001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnBUS2lpZXZOZjVISCtRQ0pYK3R0ZjduRFVOYzRVbmhvamJPRVFmanYwdTly?=
 =?utf-8?B?T1FBOHVKNlhmdDdEV2NIQzFtNW9DaHRUaU9LV3Y0ZFo1L3FCbVlTcHpjY0FF?=
 =?utf-8?B?T1JIRDZuR1FyWUtyNE5pVjNFS0RIZFRRTjFobjBNTTNxZ1NGZkhudWkyaFNP?=
 =?utf-8?B?cGFnQThuRVJLQ3R1K0pINWRScUlqb21ESHhqRmNxSmMvdFlzOHhtTXpVcGx4?=
 =?utf-8?B?WGNuQlIzUkdzQjVhWmVVK2xHMWRtc2VmRFZua1BVbmV5K2EyVTlkdkpBc0ZB?=
 =?utf-8?B?Y09DR2FBTk15S1BJZmZSQUl0MndsVmw2aFBaa0szc2kwbTNvU3drNFQrK2I5?=
 =?utf-8?B?VExFQ3d6SklqVEl2bTBNNUFPRmhoeUQwbVVoT1ZKTVpEVXppNlNNSmpsdlI5?=
 =?utf-8?B?Nzc2TXdoYmVaRUQrZ2xoVTRhRUFUdFZSd2lTbGZvcDZpV0R4QWJTZ1k3M1BD?=
 =?utf-8?B?ZFdXTHRMMDF6NnNCN0xhVUI3cDNiSHBMNFRhVTRMTUgvaXJTZ3FMN2NOSWky?=
 =?utf-8?B?SkxVYitVZ3U4b0kvZ0JOUlRNQVBLY1NGOFFYc2pnVVkvZ2tRUm1oeCtQd1dS?=
 =?utf-8?B?NXRRbFQ3V250OUZZWWlrLytDUjB6RXJtRzVXVDVqWXJwY2FhMVFjZkZSeTZH?=
 =?utf-8?B?WEkxeEpaWGQyM0ZMZnNDcDVsdlVqQW41WUFLUGY0azBNOGJ5dmI0eHc2bjRT?=
 =?utf-8?B?N2hWdmpjeVMxU0J2SEFCR1paRFkya1BZYzNiYTcwWmorZDBkdkpISWFaaVZy?=
 =?utf-8?B?Nkl3UnBmeVJBdTVaVk45OG9reVAzY0FEYnN6T1FKYnEyNXBwcmNaYzZaN1Jv?=
 =?utf-8?B?NjJFSnNYWEJjR0d1Z0VqQmI5V1pCaVU4c2RRcGEwcmFvN2s3R1VPdEtVU2d0?=
 =?utf-8?B?alhHTTV0YVpGa0dXbjRkNGk4Z0RPcmhCN1RoRE05U01mMm1Jd3JtMlRvcmNq?=
 =?utf-8?B?aXRNdkxCMFF1WU80bXRkb3R3OXZBSUpmd0IwWCtRUC9pNlV0WFgzYzRsV09L?=
 =?utf-8?B?L2pubTlOV3lpeFlPeFBBWHlFdGJUZis4TTRldEVNZTMzZmVqTFRmU0k5SDV6?=
 =?utf-8?B?QlpaM3pMbWdoQjcrN25ldDNNRFoxREFrNE9IOVVPMkQzZEtBWlRLeHIxMlJz?=
 =?utf-8?B?NjIvbFpsTFdkY2h3ZWcraExFNk5OQXZoVUlFOTZZSGIrQkczaG5oTENsT0NP?=
 =?utf-8?B?SlVXK3RocDRYVFZIOHorYWRqZzM3LzY1RVh5T1pkd0NmWmZ4WUNZckw3cXV1?=
 =?utf-8?B?YmNWUDVQWWZzc3JScnlDM0VQRzdzcGc1bGhNZjRBVGdmTzB2SUhFUGtxSWxG?=
 =?utf-8?B?RFRKWG5LNGt5NmxwT1pxaGZSbEhLSmFGT3lEem9ldjg2VjA1K2ZFRDNJZC9q?=
 =?utf-8?B?V0VRK3RTeUFVandWa2dHY0hmM1hjVTVZdTltdzZ0Y3hIeUFkbFRsL1ZhR2Ny?=
 =?utf-8?B?MG0zNGI3SDQzSTRTcHRkSk0wMUNPbkU5UWZuaGhUQ0tzUEIzSzRRTFkwNDVn?=
 =?utf-8?B?UEZqQjZyTVlzeW5nN29POWZDRUI2akliWGZlL1JTTE1wRi9OVWhyV0N1VGN0?=
 =?utf-8?B?WWVJWlhmQ3dDRjVtUU1aQ0VuOHh2VG16bDV3a2pnamFZclNYdllTbEFpNDlm?=
 =?utf-8?B?YnluK2pRTmU3STQ1MVRlOFFlRk1PK1NEMk9qdDFLVnZ2Zk03a0ZWekNYMlNQ?=
 =?utf-8?B?ZnNVTEtkcytNOVpQZkVQa3JudGV1cjNicnowRTFkQTdFb3BwWE4xeXEzbnNi?=
 =?utf-8?B?SkpWWURZVUx4Y0NhQWUrYlpBek1hVUZlWUIzQnljMURqb3U3MFBGRkhGOXNI?=
 =?utf-8?B?NzZ4ZGJMdWd0NkZ4VUgzWHFMYjF0WlRDS1MzRVBiNWZvcm9QdU5ZWFVSYmxF?=
 =?utf-8?B?YjNlcjVZR1IxTitXbCtsUzU5REFEekNYVHBaMS81WDBrQkZBS1YvVGdtNFZV?=
 =?utf-8?B?L0tabXM0endIVGd1VTlYR25MUS9IZmRyUUYyV21sZWIrM2FEUzkrR05VOHVB?=
 =?utf-8?B?VzZIMElHbVIya2dYNTZsUGp1R054Tm1zNDBSSnpiaWZWZkk5OVhpeTZsZjBL?=
 =?utf-8?B?MnNLS283bW1RZWlVOTZaRzdlWng5QW9jdWdRMFZaUDViL3VpSmpiVHk3TlVn?=
 =?utf-8?Q?yjn1x1GXYWMQEpUJKje1paqzS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfe8602-fa8a-4dd6-b2a3-08dbf0f0d03a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 15:35:28.1503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeYaQ6OlpAFHV66NRzG9Km1r9wJi+RmKfUXvd/VXtbwIoF7LO30+64BjAfL19m+K1UnnTH7zZccQ6z6IbdEe8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/29/2023 02:51, Ma Jun wrote:
> Some platforms can't resume from d3cold state, So add a
> new module parameter to disable d3cold state for debugging
> purpose or workaround.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---

This patch is essentially an 'amdgpu knob' for d3cold on the root port. 
At least for debugging purposes we also have a sysfs file 
'd3cold_allowed' that will enact the same behavior.

I do have a patch that I proposed to PCI core that stops d3cold_allowed 
from working in favor of requesting pcie_port_pm=off to be used instead 
for debugging purposes.

However that's a 'relatively big' debugging knob however as it will 
apply to all PCIe root ports.

Considering above I'm in favor of this being available as a localized 
debugging path for just the root port the dGPU is connected to.

Some comments below though:

>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 8 ++++++++
>   3 files changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a9f54df9d33e..db9f60790267 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -166,6 +166,7 @@ extern char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
>   extern int amdgpu_dpm;
>   extern int amdgpu_fw_load_type;
>   extern int amdgpu_aspm;
> +extern int amdgpu_d3cold;
>   extern int amdgpu_runtime_pm;
>   extern uint amdgpu_ip_block_mask;
>   extern int amdgpu_bapm;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 22b6a910b7f2..90501c44e7d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -264,6 +264,13 @@ bool amdgpu_device_supports_px(struct drm_device *dev)
>   bool amdgpu_device_supports_boco(struct drm_device *dev)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct pci_dev *parent;
> +
> +	if (!amdgpu_d3cold) {
> +		parent = pcie_find_root_port(adev->pdev);
> +		pci_d3cold_disable(parent);
> +		return false;
> +	}
>   
>   	if (adev->has_pr3 ||
>   	    ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 5f14f04cb553..c9fbb8bd4169 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -145,6 +145,7 @@ char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
>   int amdgpu_dpm = -1;
>   int amdgpu_fw_load_type = -1;
>   int amdgpu_aspm = -1;
> +int amdgpu_d3cold = -1;

If this was chained to a larger workaround (such as automatically 
applying to a DMI quirk) it would make sense as int and with using
-1 for auto.  However there is a pretty dramatic downside for using this 
knob that it can break s2idle.

In my testing I've found that the following happens on an A+A design 
after s2idle with this parameter in use.

[   70.572270] pcieport 0000:01:00.0: Unable to change power state from 
D3cold to D0, device inaccessible
[   70.572481] pcieport 0000:02:00.0: Unable to change power state from 
D3cold to D0, device inaccessible
[   72.855769] amdgpu 0000:03:00.0: not ready 1023ms after resume; waiting
[   73.943545] amdgpu 0000:03:00.0: not ready 2047ms after resume; waiting
[   76.055602] amdgpu 0000:03:00.0: not ready 4095ms after resume; waiting
[   80.279550] amdgpu 0000:03:00.0: not ready 8191ms after resume; waiting
[   88.983562] amdgpu 0000:03:00.0: not ready 16383ms after resume; waiting
[  105.879581] amdgpu 0000:03:00.0: not ready 32767ms after resume; waiting
[  142.743646] amdgpu 0000:03:00.0: not ready 65535ms after resume; 
giving up
[  142.743793] amdgpu 0000:03:00.0: Unable to change power state from 
D3cold to D0, device inaccessible
[  142.804011] snd_hda_intel 0000:03:00.1: Unable to change power state 
from D3cold to D0, device inaccessible

So I don't see us ever automatically using this and it should be 
debugging only.  IOW this doesn't need to be integer; it can be boolean.

>   int amdgpu_runtime_pm = -1;
>   uint amdgpu_ip_block_mask = 0xffffffff;
>   int amdgpu_bapm = -1;
> @@ -359,6 +360,13 @@ module_param_named(fw_load_type, amdgpu_fw_load_type, int, 0444);
>   MODULE_PARM_DESC(aspm, "ASPM support (1 = enable, 0 = disable, -1 = auto)");
>   module_param_named(aspm, amdgpu_aspm, int, 0444);
>   
> +/**
> + * DOC: d3cold (int)

If you flip it to boolean as I suggested this should probably either 
rename to disable_d3cold or you should default to TRUE.

> + * To disable d3cold (1 = enable, 0 = disable). The default is -1 (auto, enabled).
> + */
> +MODULE_PARM_DESC(d3cold, "d3cold support (1 = enable, 0 = disable, -1 = auto)");
> +module_param_named(d3cold, amdgpu_d3cold, int, 0444);
> +
>   /**
>    * DOC: runpm (int)
>    * Override for runtime power management control for dGPUs. The amdgpu driver can dynamically power down

