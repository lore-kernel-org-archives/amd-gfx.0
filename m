Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA97EB64DC
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jun 2023 03:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C5B110E0AA;
	Wed, 28 Jun 2023 03:30:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C77B10E0AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 03:30:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls0ISsaG4W+zWBAtuJi6l4OyNnbVjNYlX99ZE8WDQh7S6gNGK6LzRpf5VdpJ6HVAXCwK7dPKUW6jhvom5iPk8ETHjuvh48t+5LBZq7fsjlzqH47IEN5HYAKVdQVEqoc1IhgeTBZPkIMRcJLKfmv6SwT2Ka1q0Q4s5MaSOXTLNMY+wrV9oBEf1wAZsBor55kjr2g6NTHoFHnD5NoJejvTY+lbYjcbK8IFPSsafyVU5Rli0Ozhk38xH6+XPCc8B1ZPVWNxIoqTr01KIwnEiJK3y8BRhop2YSTWs4h+nb6RE74Y3NdZNIhGm4uy4FX8AKFSLIiRUjm9hzBCTR5NS7h1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSs0vKIUGsQONMvA09EcBJmHwj3JBs5N6mLnH5Pl3v0=;
 b=Nmy/7Yal4GaqTKC8sUBmFvkFt/7BSFtfHb1zk6+Dg/3kII9cjNx/hLEWoddECwsUvSrYk5gCEC91hKLy/hcK8wcSSB99OGG9+VrBf2tT/Gw4t3VblZudSeyRb/86n/oWfW5/28QbhUrRY3SG0gEXZTqeoN94TnM+Or0GC9F+A+3yX+eY/Tembe0wnUUST1l/ggr3SDRQwNEG4HJ4p7XkyRd0wNOMZoRzXFkwHyPjFt+UIn8b/Zlj0ZFtm6aL9Vv8GIl0GMl3J85cw4gIvxlsxnM2MIeNfwP4uDBp6uKfrjb4UkRpNuMWwYdWhQRcRKgbugzWHcM4Me9htZWdS0Qolg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSs0vKIUGsQONMvA09EcBJmHwj3JBs5N6mLnH5Pl3v0=;
 b=tpcxV0Ltf8HROmjB+2pSjOd8g47MN6wQRdXSX02vv0oYIAnVH899b2kAy8lBIw/SrGfCZTjDtb9n30atkukYuRkrEHw4+38puS5L2c4ZlPuzQg9QFo92uYuQq+srZF4cXY/XKXBjSbjpq1YO7gBNw/jc4pzJp1WGJNER7aWMMxw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 03:29:59 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 03:29:59 +0000
Message-ID: <a19a92d8-fe7f-8d3d-cbd6-df527273fbd5@amd.com>
Date: Wed, 28 Jun 2023 08:59:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amd: Detect IFWI or PD upgrade support in
 psp_early_init()
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230627212226.27638-1-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230627212226.27638-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::21) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|BN9PR12MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ed397b-adbe-4523-f05d-08db7787f33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X72piMr1Zn7Vp3BQi+flpX5enLTsqqS1hoHsxUeQ4Wp+IpZaoBzwzNkBLHF71vzhYSNjK8rrwHQmIn5rcqD2ybEhTnfwOY/i5FfvEUTHFHVG8EA2ZsR1SuBws/+damnLOWSLCseIEV9WyYR7Dp49N8gEkOmKtxfFXikYzn3B+ic6Xcbc+nNWi7LnFRBSAEloP3AfbHT9eC5Dxd3j60WR9yrrHoGDUPaKmh+6CQ8/41vyuStcExj/Y+cXFn8jBmdNgK1jyEu0QG+8NFLIY4iY9tfq0bJf+JIajK4W1ZuzDQhHBV6hWp6KJN2f1m5XuqMGrX8kIFk4xBB2kDlGGq3xd/k7hbrGWVvjY5Ty+qDgfOUFBB8b3TntARwZWTwxg4UWM61w/u0zX0cNZrPwMCMKWOi7PKkwY/of37Rm+XnBNJftqL/ZkA1ZkhNtem5bTpfpyXrci8KIpDbOcK/41RVQZA8melqI68lLQN7TpI/OPbDlRlNhOnr7uojoK5i/xQHh4zVfJVG9/hlqTmJ0OEIjLCJINyOFRSFQG8Je0/v0T7pgpbn+JOEgBUbYhJcznB0VTYSAnnJqLvSVTj2/qbH2B1sXa5THvpJDRqw/cY6s++GFLpNvZkM0/Cy7NJAkO2hP2bmCsXML3FMIWQvyQ1JMdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(6512007)(31686004)(5660300002)(66556008)(316002)(66476007)(478600001)(66946007)(36756003)(8936002)(8676002)(86362001)(31696002)(41300700001)(6666004)(6486002)(2906002)(6506007)(186003)(26005)(53546011)(38100700002)(83380400001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US9ZcU9UY3pZRjlNK0pJcnMvSzJGK0hGVEhCZGFBdUhnTnF5aWNQdld6WUdV?=
 =?utf-8?B?Zi84ZTF0UUlscjlVQkpJNzZuTnNxUndaYjJBMnhTSmxpZDIvd2QzaXA0RlVk?=
 =?utf-8?B?NXRSdDlzT2F5aEdkalh4VDB2N0VxTnFaci9TMnptS2tCY1ptUDZ4YUg5RXhl?=
 =?utf-8?B?UWo5YXlEYkhERWtxNFIwMVlxRmxZdWNjem1zc1hyOGw1cndQaVNOWSsvOExx?=
 =?utf-8?B?c2pzN21yWlhMcGNwendBYVhvTHpTNlRLV1BPa3QweTUxdjJhVllDRHJzYTFO?=
 =?utf-8?B?R3lOcFBzMDFmNzMycXlNa201TUxwN0xrNk91Z2lNOWRHTlZxVUdBMURPc25y?=
 =?utf-8?B?NW5UYlloazlpVHZBMHowQW9GVm1jMUtlRVVabXRiTG9sWTE4ZFpiWlhtT0J5?=
 =?utf-8?B?dVRWdys1elIzNHlLU0w0WE9DYUxvUk1ubzlXR1dRL0orZmExSVhjN3VNenQ5?=
 =?utf-8?B?ZE8ySmVQangxU0JVWmNsK3lmbWFDdllEbTdpa1RKVzUvVE10Z1U2RVNGNm9Y?=
 =?utf-8?B?MDhIVnJIWk54UWhKcW9RVERNb000NWpudGs5cDRQc3BCMWxjMVpiay9rTTNs?=
 =?utf-8?B?SnZ5cW85S1prWTFrR1JESlpnWmdod1hIMkRTMHZiTTNvcG9SMkw5ZU1XSzFT?=
 =?utf-8?B?TFlyeTlNcmJrU0wzelBRc0ZkTlFCSm1Oayt4a0NHY3VISW1MQ3VLUEFWWDlx?=
 =?utf-8?B?N3pqR01zVHFBbGpaK25PVjRxa1Z0UUFZeEZkZW8wV1hxZjJoSnZFWUgyUldu?=
 =?utf-8?B?MkxkNzdWa0QvNUhEMmljK1NydGF4MzkvcncxSDNTQithTllyc05OMnFLSVJh?=
 =?utf-8?B?N01GQ2M1OGhpakt5NGJMWUJVV3Z4RnZvZHhnRVJLS3Q5dlR6c0ZaSk93aHhN?=
 =?utf-8?B?eWl4S0s4b25ObEZOSGRDenpua2JGOUE5WXQ5aG1HUFUybE9kNTREYkFmNXJk?=
 =?utf-8?B?T0IyazJRbEtCQTh6OE5WZDdsQ3VUNHErOW5mOTZWSnZXdnU3VFRNT1FWa1l0?=
 =?utf-8?B?YkU4TUxnV2ttbFRjU0FPcUo1VGVnaDRjQUFEbHJlU0dkazVNY05HZ3lCM1p1?=
 =?utf-8?B?NytqRjVUWVJackQyS2t4eE02Zi9xa0dIeFY0ZTRYT3pRblhFWjVqVFVkZDlG?=
 =?utf-8?B?WUQ0THl4Y1NrNm9DVm1RNWdtS3FWUFl0UHRtTXYxWnkxN2ZFUVJUMWFVS1Yw?=
 =?utf-8?B?azhIbWd2cDBRaG1xeXJFY3pXdFpva2plVGxsTkRqQzhibUdnellDK05wVGE4?=
 =?utf-8?B?SlRHM0FCbEt6TTZTWFltOGtYM093YXBISng1QjFORDVqdFUyODUrRXBDZTgz?=
 =?utf-8?B?U0x4dFZuS2xXd3YwZU5hOVVHTXJ6ZFJnZURwNk9MV1F5aUs3ZE10am56VFRk?=
 =?utf-8?B?L0Zqa2ZLc253aTF2M29vSWRtOWo4VU8yR3F5RHRkWWdUUFNqT2wyemxSdCtO?=
 =?utf-8?B?QVZOR3RRdmVXWFVvVDVEYWtvUDYwVXg0WlRNK0RMK0R2UkRQOG1rRkVqQzJ5?=
 =?utf-8?B?Vkw1Z0IvVlJJZ3V4VjJJU3BteU13OXQ0NHpQcG55MW0rNkZKU3V4eUQxV3Yw?=
 =?utf-8?B?LzEyT1MvRHk4NjRZbFJqQzlld05sKzI5TVh1SnFMN2FNMUlVMkdlUDJ2QkNU?=
 =?utf-8?B?TURXb2ovWkZrSkVyMFJWeitSd2IydlZZRTkzeWRkeVV0MVhmcmdMMGM2dXk4?=
 =?utf-8?B?elpJbWl3TnMxMmtqTllPaXBFUk1EckNtMXp6ZkNOSEg3M2p5eU8xK0lTVjM1?=
 =?utf-8?B?YkkvVkdjenhlWWJnT0hmRU8zckE1clVGb0J1YlR1UjR3MTRTeThwSXpaQUxh?=
 =?utf-8?B?TzR2bGE3Z0IyMFdybmgxQ3M3NVBFamp1RlZQUnN5cmtDdktucjN6Z2Urd0da?=
 =?utf-8?B?T1J0NldGeTRpZWh6U21GNGd4M1pGZk1DSU1HTnhGWng5MnZaby9NNHByVjJK?=
 =?utf-8?B?MkxKR1hhcHY1R0lWYThqdkwweVp2dWJ3d0xTTVlDWFd5ejRJc0lPazFyUTlJ?=
 =?utf-8?B?Q0RaQ0M5N3dBSlZYWjRaYm9jSjVMUXYrYkFpTHdOTERCNi84TWNGVm5mcUhE?=
 =?utf-8?B?Q296WVU0RXRtcGhORXdybkFiQ25KUG15czZtdW1vYXhmVmxEcElhcnMrVWNU?=
 =?utf-8?Q?r8S+Qi2+Ik74CLnm7ba1PO7Zr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ed397b-adbe-4523-f05d-08db7787f33c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 03:29:58.9833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wk5pYLiju+scdIe+VoU0vprD/Dh/YGF2pRoe7zrfmwcOzQzkR4VnTGusgusIhsYJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
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



On 6/28/2023 2:52 AM, Mario Limonciello wrote:
> Rather than evaluating the IP version for visibility, evaluate it
> at the same time as the IP is initialized.
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 45 ++++++++++++++-----------
>   2 files changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 630e4f73de30..0d7b4035bdf5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1099,6 +1099,10 @@ struct amdgpu_device {
>   	bool                            dc_enabled;
>   	/* Mask of active clusters */
>   	uint32_t			aid_mask;
> +
> +	/* firmware upgrades supported */
> +	bool				sup_pd_fw_up;
> +	bool				sup_ifwi_up;

Since this is a psp ip feature, can we move these to psp_context and 
init it during psp early init (i.e., only if psp block is present, this 
will be supported)?

Thanks,
Lijo

>   };
>   
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 6929fefb26cf..9904c9c18b2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -177,9 +177,11 @@ static int psp_early_init(void *handle)
>   		psp->autoload_supported = false;
>   		break;
>   	case IP_VERSION(11, 0, 0):
> +	case IP_VERSION(11, 0, 7):
> +		adev->sup_pd_fw_up = !amdgpu_sriov_vf(adev);
> +		fallthrough;
>   	case IP_VERSION(11, 0, 5):
>   	case IP_VERSION(11, 0, 9):
> -	case IP_VERSION(11, 0, 7):
>   	case IP_VERSION(11, 0, 11):
>   	case IP_VERSION(11, 5, 0):
>   	case IP_VERSION(11, 0, 12):
> @@ -214,6 +216,7 @@ static int psp_early_init(void *handle)
>   	case IP_VERSION(13, 0, 7):
>   		psp_v13_0_set_psp_funcs(psp);
>   		psp->autoload_supported = true;
> +		adev->sup_ifwi_up = !amdgpu_sriov_vf(adev);
>   		break;
>   	case IP_VERSION(13, 0, 4):
>   		psp_v13_0_4_set_psp_funcs(psp);
> @@ -3704,9 +3707,13 @@ static ssize_t amdgpu_psp_vbflash_status(struct device *dev,
>   }
>   static DEVICE_ATTR(psp_vbflash_status, 0440, amdgpu_psp_vbflash_status, NULL);
>   
> +static struct bin_attribute *bin_flash_attrs[] = {
> +	&psp_vbflash_bin_attr,
> +	NULL
> +};
> +
>   static struct attribute *flash_attrs[] = {
>   	&dev_attr_psp_vbflash_status.attr,
> -	&psp_vbflash_bin_attr.attr,
>   	&dev_attr_usbc_pd_fw.attr,
>   	NULL
>   };
> @@ -3717,29 +3724,27 @@ static umode_t amdgpu_flash_attr_is_visible(struct kobject *kobj, struct attribu
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(ddev);
>   
> -	if (amdgpu_sriov_vf(adev))
> -		return 0;
> +	if (attr == &dev_attr_usbc_pd_fw.attr)
> +		return adev->sup_pd_fw_up ? 0660 : 0;
>   
> -	switch (adev->ip_versions[MP0_HWIP][0]) {
> -	case IP_VERSION(11, 0, 0):
> -	case IP_VERSION(11, 0, 7):
> -		if (attr == &dev_attr_usbc_pd_fw.attr)
> -			return 0660;
> -		return 0;
> -	case IP_VERSION(13, 0, 0):
> -	case IP_VERSION(13, 0, 7):
> -		if (attr == &dev_attr_usbc_pd_fw.attr)
> -			return 0;
> -		else if (attr == &psp_vbflash_bin_attr.attr)
> -			return 0660;
> -		return 0440;
> -	default:
> -		return 0;
> -	}
> +	return adev->sup_ifwi_up ? 0440 : 0;
> +}
> +
> +static umode_t amdgpu_bin_flash_attr_is_visible(struct kobject *kobj,
> +						struct bin_attribute *attr,
> +						int idx)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +
> +	return adev->sup_ifwi_up ? 0660 : 0;
>   }
>   
>   const struct attribute_group amdgpu_flash_attr_group = {
>   	.attrs = flash_attrs,
> +	.bin_attrs = bin_flash_attrs,
> +	.is_bin_visible = amdgpu_bin_flash_attr_is_visible,
>   	.is_visible = amdgpu_flash_attr_is_visible,
>   };
>   
