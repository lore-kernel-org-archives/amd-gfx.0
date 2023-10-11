Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46DACD6E54
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 09:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FE7F10E0A5;
	Wed, 11 Oct 2023 09:58:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 338BA10E0A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 09:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ke5eZ3mOmFn2r72MZpxGNzbDaD4IsfmZeul3jcaOHx7z2Fy9N3XCJGmGoxxhtYAQVZRxJu2cvFd8d3Hst7p324QQ9/fQKAMdEKYnOdKwbWRFPg25TJB/hvMoebh09IMnIm7pwLEzps9TXEuxUbU5J6ohuLUBJDqx0dF4sbmSMeu5rYYbXzzvQpqnkgV7A1PWj6DSoj8ogz8bDAAaPyUEqQDRML/7rLFLffgWh5VSdaEfD3D3zpV7Kmn9WOu519ZuXLQlBOzF5yLXXSaVhaoIsMnXyFDgr1/4C7ypSF1onjyPxxmLsWIP/ZQJmCdOJK3osNVWvse4v4CBqvbu4tic0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvQTe2Ws/WJsj1qvYNcfXn+AyglSqer/z19+6i/jrgE=;
 b=Qoi1n5XnOxUac/uIwUMryCy5m487vHHKU6WFU2/KDltqbU5HsRjmcdE5RlRwrMA8tzm9kVV8FOX7aQduSgSWPlLpSwvEJ1JXx+lxhNOrGT1+28XHm8W8W38RvccR3EW5xAGWe0WadVpHp7yhPI85kjNZvqJtMmAlWPZNCbV1zWeb1Ayj+c2T6x0a6OFPdfruzkig4PM1a03LbVpWB+T+XqyqHN8OMgmVF8wmdQ9KcFPQe8Lss5ccvkkMpwMBEamhygjJC2IIYM34OSL+3afEe2gJfGfENO3b4tuHibdwQ2gg32jyMF77ghkQasVaQq8g3CZOHEpLJpuKRDDeMNRJOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvQTe2Ws/WJsj1qvYNcfXn+AyglSqer/z19+6i/jrgE=;
 b=BRglttf/kEVFM13vJXPl6QlY0Zr9w4RReaL7f8bIA1AcBAvoLk+Z7WgTfXP8qoro9tu5mLLcr0YybCnLL6Y0ccvg3WsY7whQOVuH++buACuw7gEKKL1RvCQ1TOguH7B0MmRqr/Ix/8ijapwTBUoWEBi7YMErR9ZXF6MjTSkprdc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 11 Oct
 2023 09:58:14 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%7]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 09:58:13 +0000
Message-ID: <21e7e927-ba76-6f04-5892-5c6c280f2d23@amd.com>
Date: Wed, 11 Oct 2023 15:28:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] drm/amdgpu: Expose ras version & schema info
Content-Language: en-US
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231011092532.628919-1-asad.kamal@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231011092532.628919-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::21) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df76ea3-f11a-4590-1851-08dbca40933b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DigUmUOYc7wzzYC6/KxxxCb9ZRjfcgtsEsSiAsEyBZNOoMBze/63jXw74wnWVCprTaGLu2fScOsqFdSH5HmchmYmQuvVi0LuCpPgYOveSSHyfFbmv3vMPUiEQfaqyvYo7Nrq7Zyy3sj+8uPvaoF3CXZu+QeV8e4xC852uvjxpEw/F0DFnNvSaHpKZkSqzYwZy7K1H7Cuq0TrTwCEhwhokTI6kk//9MRN7YGQWSOQ/YZ6G3ZIfGlZY5bRwCpl0UemJB5GILiAC5+sK+1GbZhuhR4bxMNC2n+KEdluvkkb3r0zLCspLlBa9s4u285I2H+rN21IhImZdUul/k4r2vw9wOgE2QGMnTTUFD1hJOxm7T7rbs6nG+hZL59ue6Xf7cJaonssJcYBvxgJO3toL5dcJaMHJGOoO7wMck2yZyYrdBKRemKEiNlwcutnJKSUMkNEdzUfdZMfsZQdiBIEcYhdTwwn6gZVri+RCJwAN360YnqI5PWATx+/AwZCT4Sd0RpsSAgHlup8JvXiQm/t6yaW51XlzlgNKhOPSQXiV+mN15EyLCxLmvyC72xiGfsxXBjHDA6ckfbuj11NREQ/5/y0eEKFHPYpT/rcWrKrD7EgGa8rVMAGvikVUBsUAXir3oATIgvP4DPBe7ey9JH29oJ9tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2616005)(83380400001)(31686004)(26005)(6512007)(5660300002)(66556008)(66476007)(316002)(8936002)(8676002)(4326008)(6666004)(38100700002)(2906002)(66946007)(41300700001)(478600001)(53546011)(36756003)(6506007)(6486002)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlBMYUNuYmtqd3BpbmR0TEszVSt2b244VzZYVlFJT0wrK1FER21FYklUSjhO?=
 =?utf-8?B?YjhjN25NT2tBTVVVWmIxYkRlVVBMa2VwTzdOZXFrYnBySHNKWEZRSy9ha3Nn?=
 =?utf-8?B?aWs4dk5XWmZ3WFZRcW0zS1N2R1lOV2JqWGhCT1pScUdsMGM0RThPNXVCa1JY?=
 =?utf-8?B?bFBLbVBuWko5eVlvbjVza0VDdmN4eUdKNmd2SW1oV2ZGUEMydHkwdytmVmFr?=
 =?utf-8?B?cjQvNTEyS1pDbXRVWlYrUUZmdXVOYVY2YWhYTm9UNUlMbjVKbmZDNWhqT21o?=
 =?utf-8?B?bmpSTWRrTk14MVkzbytxRjdpdW11SEtod0g0eXkzdlIxUlByaVJBc3lLaGd2?=
 =?utf-8?B?c2QrRk5Mc3dLakFGRFRiTDkyTWFYV2ZHSlZNYXR1R2swTjg3bHpnSEFadlEz?=
 =?utf-8?B?MDltK3M1a0lEclBqQWRubU1vbjlTb0k2RE04Q1g4Y2lIY2pOVm5WYm9CbUZo?=
 =?utf-8?B?TFc2Unk0elhaVzFLQjlHQ2kxbHVtQzJQQ1RxK2ppNlg4d1BlZTJsblZTQnAx?=
 =?utf-8?B?SXk1NTRuY0NhUUJXY1lzWjlkclRlbDVvbERyZmo2TEk2eHBWWFF4OFhBakxu?=
 =?utf-8?B?RGN4ZndETlRBbGNWbHFuaEtpTUlrc09ONVVGZC9BVFFqSGp2ajUweXppV1px?=
 =?utf-8?B?MDg4aUN0N1RYTG0rQ2R4UG85TXVRZG1kRXMwVllnalhnTmw5eE5DN1BxSnQz?=
 =?utf-8?B?QU1KM2gvTThkSXcvQ3ROM0dMT1BMWW54aTBYbkExVWhib0l2MCtYcCtyMFo4?=
 =?utf-8?B?MDJuY000Y2FCRklzaWdEYnZQb2xUNmNWRW1YcC9oUFZrY2F5UHZWVXJ3RStT?=
 =?utf-8?B?SmpWTVJGQ3JzaE9XblJHaUhSVlljWjQzMlVUb2ZVTFVBL2dKZTk2SGFBdVhZ?=
 =?utf-8?B?S09FVnNFb1NpUVZxWXJ4SnZJTjEvdmtiOTRueEYxZUtOc1pZbENZejJjZ2dV?=
 =?utf-8?B?RlVVU1JqQjZ0M2xzYXYrengvVk5wSndSNzd0VkdGT2FHbzd4elU3L2ZuYXVi?=
 =?utf-8?B?VFlVdmwyTXhLL3FmSzVranlkRHE3LzVyT2s5Q0d1OGdtVUZ0M3JLdW53T3I4?=
 =?utf-8?B?aTNnWkxFTUZubnlSR09lVHJWVGF6eEIya3IrV2Q2RS9DNWxWTlhid3ZZcGxL?=
 =?utf-8?B?NXhVckQ3S1Q2aTE4dUl4V1V3RjNRcUdpRGZJM0l2ZmFmU0pHUkN3NnFZZzdk?=
 =?utf-8?B?Ny84VHRDYVp4RE52MmdlMm85V0kxa24vWEFMd2daamhEb2JUaU1uQ3BUVm5N?=
 =?utf-8?B?VUJHc3EvSzUxd25OdVVxTnN5TUJNMjAwNm8xM0RGTVBxUjU2djhzMHVXQ0po?=
 =?utf-8?B?NWpYUlNYOFFUR01vTHRRWmdLUy9MTzB0TmhYVEhvdURjblZqSHNHUWUrZW1D?=
 =?utf-8?B?YzZZMFl5VXRNLzQ3ZU9SVzFhT0xHNlR3TXY2Z0xwR1pWcWE2NTE1TWV6cmNr?=
 =?utf-8?B?dDVLelkrZy8xaTBMSHEzdjB6R3Y4NE5hdHJRMVFGRDZrYkRIeE95TmxiVjM0?=
 =?utf-8?B?ZjBwSnhpd3UwM2JTaWUxZklCVW4ydVNjVDRFTTRacVNyakE1Q2xvc05uUkFt?=
 =?utf-8?B?ZktZZG5mWnRHd0JxSTB3YzU3b25DUFVRRFBXUGtrYnZhaUFidGY3dUpWQ2pH?=
 =?utf-8?B?V1JpbHZ2L2FJOGsxVlZYK040a1czOFRQemxYVThTTmhHNmVXWitOT0E4L0gw?=
 =?utf-8?B?azNpM2NOcGhJd05NZ0pnMzRhdzJ1MmVXaDU3TUg5SU1XVXVPUklGdEJKdkVV?=
 =?utf-8?B?aE1NTitlS3BtQzlYdlZwSVNmUC9weThIeXlhTjRiMEVFRllRUnB4Wk9IcjNl?=
 =?utf-8?B?dktRK1l1Y0crME93aTVNY0gvNkpwNGUxOUFxdDFYcXdXSnR3SVg0WjJ3cFFR?=
 =?utf-8?B?dkp4NnNFZHVxNjgyUzFJMmUySVB3NjFSWk12SWtGWmw4L2FWSyt2aVZSMUNi?=
 =?utf-8?B?S1hoLzB2ZzM5VWZ2T0dlTGxZRTNieE1qSmpPN0VPUjZ6RkZGL3JtL21Lc21C?=
 =?utf-8?B?RzRtYU5yMXo5V2w3SW05Rzh1RmExNUxyc3prdTgvOWdpOWpYSXJtNDd5VFJr?=
 =?utf-8?B?cllCYlFRQnpEZzhXc1dLenpyMkRmR0orVGpibHVQbkI3REZ0eDJ5Y25ValpQ?=
 =?utf-8?Q?ieL0HSj5bAK1AC3iI0XSBlQh2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df76ea3-f11a-4590-1851-08dbca40933b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 09:58:11.3868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmVNPLWdzhebsCXYExcLz3+bNmXyWHaH/nDFCtBe9KALZyKtt1n672RCfLi16pp8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
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
Cc: le.ma@amd.com, shiwu.zhang@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/11/2023 2:55 PM, Asad Kamal wrote:
> Expose ras table version & schema info to sysfs
> 
> v2: Updated schema to get poison support info
> from ras context, removed asic specific checks
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

One nit inline. With/without that change,

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 51 +++++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 ++
>   2 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 9c8203e87859..cb9e48fb40d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1370,6 +1370,22 @@ static ssize_t amdgpu_ras_sysfs_features_read(struct device *dev,
>   	return sysfs_emit(buf, "feature mask: 0x%x\n", con->features);
>   }
>   
> +static ssize_t amdgpu_ras_sysfs_version_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct amdgpu_ras *con =
> +		container_of(attr, struct amdgpu_ras, version_attr);
> +	return sysfs_emit(buf, "table version: 0x%x\n", con->eeprom_control.tbl_hdr.version);
> +}
> +
> +static ssize_t amdgpu_ras_sysfs_schema_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct amdgpu_ras *con =
> +		container_of(attr, struct amdgpu_ras, schema_attr);
> +	return sysfs_emit(buf, "schema: 0x%x\n", con->schema);
> +}
> +
>   static void amdgpu_ras_sysfs_remove_bad_page_node(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> @@ -1379,11 +1395,13 @@ static void amdgpu_ras_sysfs_remove_bad_page_node(struct amdgpu_device *adev)
>   				RAS_FS_NAME);
>   }
>   
> -static int amdgpu_ras_sysfs_remove_feature_node(struct amdgpu_device *adev)
> +static int amdgpu_ras_sysfs_remove_dev_attr_node(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>   	struct attribute *attrs[] = {
>   		&con->features_attr.attr,
> +		&con->version_attr.attr,

> +		&con->schema_attr.attr,
>   		NULL
>   	};
>   	struct attribute_group group = {
> @@ -1459,7 +1477,7 @@ static int amdgpu_ras_sysfs_remove_all(struct amdgpu_device *adev)
>   	if (amdgpu_bad_page_threshold != 0)
>   		amdgpu_ras_sysfs_remove_bad_page_node(adev);
>   
> -	amdgpu_ras_sysfs_remove_feature_node(adev);
> +	amdgpu_ras_sysfs_remove_dev_attr_node(adev);
>   
>   	return 0;
>   }
> @@ -1582,6 +1600,10 @@ static BIN_ATTR(gpu_vram_bad_pages, S_IRUGO,
>   		amdgpu_ras_sysfs_badpages_read, NULL, 0);
>   static DEVICE_ATTR(features, S_IRUGO,
>   		amdgpu_ras_sysfs_features_read, NULL);
> +static DEVICE_ATTR(version, 0444,
> +		amdgpu_ras_sysfs_version_show, NULL);
> +static DEVICE_ATTR(schema, 0444,
> +		amdgpu_ras_sysfs_schema_show, NULL);
>   static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> @@ -1590,6 +1612,8 @@ static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
>   	};
>   	struct attribute *attrs[] = {
>   		&con->features_attr.attr,
> +		&con->version_attr.attr,
> +		&con->schema_attr.attr,
>   		NULL
>   	};
>   	struct bin_attribute *bin_attrs[] = {
> @@ -1598,11 +1622,20 @@ static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
>   	};
>   	int r;
>   
> +	group.attrs = attrs;
> +
>   	/* add features entry */
>   	con->features_attr = dev_attr_features;
> -	group.attrs = attrs;
>   	sysfs_attr_init(attrs[0]);
>   
> +	/* add version entry */
> +	con->version_attr = dev_attr_version;
> +	sysfs_attr_init(attrs[1]);
> +
> +	/* add schema entry */
> +	con->schema_attr = dev_attr_schema;
> +	sysfs_attr_init(attrs[2]);
> +
>   	if (amdgpu_bad_page_threshold != 0) {
>   		/* add bad_page_features entry */
>   		bin_attr_gpu_vram_bad_pages.private = NULL;
> @@ -2594,6 +2627,14 @@ static void amdgpu_ras_query_poison_mode(struct amdgpu_device *adev)
>   	}
>   }
>   
> +static int amdgpu_get_ras_schema(struct amdgpu_device *adev)
> +{
> +	return  (amdgpu_ras_is_poison_mode_supported(adev) << (ffs(AMDGPU_RAS_ERROR__POISON) - 1)) |

It's simpler and more readable with a ternary operator.

Thanks,
Lijo

> +			AMDGPU_RAS_ERROR__SINGLE_CORRECTABLE |
> +			AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE |
> +			AMDGPU_RAS_ERROR__PARITY;
> +}
> +
>   int amdgpu_ras_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> @@ -2636,6 +2677,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>   
>   	con->update_channel_flag = false;
>   	con->features = 0;
> +	con->schema = 0;
>   	INIT_LIST_HEAD(&con->head);
>   	/* Might need get this flag from vbios. */
>   	con->flags = RAS_DEFAULT_FLAGS;
> @@ -2691,6 +2733,9 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>   
>   	amdgpu_ras_query_poison_mode(adev);
>   
> +	/* Get RAS schema for particular SOC */
> +	con->schema = amdgpu_get_ras_schema(adev);
> +
>   	if (amdgpu_ras_fs_init(adev)) {
>   		r = -EINVAL;
>   		goto release_con;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 7999d202c9bc..728f98c6fc1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -389,9 +389,12 @@ struct amdgpu_ras {
>   	/* ras infrastructure */
>   	/* for ras itself. */
>   	uint32_t features;
> +	uint32_t schema;
>   	struct list_head head;
>   	/* sysfs */
>   	struct device_attribute features_attr;
> +	struct device_attribute version_attr;
> +	struct device_attribute schema_attr;
>   	struct bin_attribute badpages_attr;
>   	struct dentry *de_ras_eeprom_table;
>   	/* block array */
