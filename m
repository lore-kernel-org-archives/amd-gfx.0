Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551C0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 16:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7F8710E21E;
	Tue, 25 Jan 2022 16:11:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F0D10E21E
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 16:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWR4LpRDvLGzUTMwIBOLCm8WeR/yED9rts9qAJ+iIW/LCg9UEgc/MeahcTmuBZlJIWpCCc2iy9eEuufu34Mtr7CRBzJAuzHGM50tJaHK4vdrJJlZDjvCx0D31X7EoVLlxSlPgOuzrsNSdxQSbgeF2LT55qY3N7+aRqIQVCr7ahW7wo2ewheJYZfwN8rsfTGryG1JVMstcPVstOzFvLJRZfR+0KZ783Y/gAYIxwcj6zOj1dg0k7Z/UyOtED+MOajysZ6r5pspl4Wt+tIaawtlJInOCLQgMcJ1NRDdZ4B5mpdTLBa5iWRqAy6+9uBbBuakjrYVYFnQkQEo3IQi+JToQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUzJAmNmPUpltErGp+c1jUwnLA4sLQv5eAgoHcLm0VE=;
 b=Qez4qPo+woGRFs/Jr2jnmz7LrraEcwXvdOYW1ChdgXIdsnKT9DJ0UQi+5dYLDk+Ap4Lbl0tTh461uDNUYrY+5gK8fSAiSgRLcckMXl4WXPQEniyZqSg3bkVfWIoE/bzx4czp1WkzNikqFjUohrPlMPI/s+jNNqwGysyIizAF23uzWKYTEBlUNGzmUYFKw6kYGpHg4Btnn1EZuLANZYkCdf8bOc/4lq4i2pd6g952nu7L1+QQP191Sa+fTI+lMwz+vGflZEBwCj+zXZJOxG4o4uvoaBJZdtVk8evikj3V1aZad75/O0zviCHntm+PDuMqYbXoV0c5AjSe9QsQcNzQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUzJAmNmPUpltErGp+c1jUwnLA4sLQv5eAgoHcLm0VE=;
 b=KHmxkFi5XqI2n/MzSTuomXctFTEmuvUUkGoOVNFN8mIhLIxouc/CGlewGGlinrPAHsP3rf0CZPiuOJavTgIL9e666rq2tn30m8P9056XYzayBwNVJijhFoUSRIJi8MCj4vB0Y3OYWdtenVf41LLX7bZR+RnJODWqXHp8Pt+eSck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3375.namprd12.prod.outlook.com (2603:10b6:208:cc::12)
 by CY4PR12MB1751.namprd12.prod.outlook.com (2603:10b6:903:121::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 16:11:49 +0000
Received: from MN2PR12MB3375.namprd12.prod.outlook.com
 ([fe80::5593:bc50:9e71:71e7]) by MN2PR12MB3375.namprd12.prod.outlook.com
 ([fe80::5593:bc50:9e71:71e7%5]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 16:11:49 +0000
Message-ID: <9d98c06c-79ce-edcb-7f1f-6d035ad25152@amd.com>
Date: Tue, 25 Jan 2022 11:11:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] drm/amd/amdgpu: Add ip_discovery_text sysfs entry
Content-Language: en-CA
To: Tom St Denis <tom.stdenis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220124180736.2646458-1-tom.stdenis@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220124180736.2646458-1-tom.stdenis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::33) To MN2PR12MB3375.namprd12.prod.outlook.com
 (2603:10b6:208:cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5ea5e50-28bb-431c-29f5-08d9e01d6460
X-MS-TrafficTypeDiagnostic: CY4PR12MB1751:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB175104943B23B2D89F85468C995F9@CY4PR12MB1751.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDKJecmWEXOMYDvZxL91UJ1C3tyUm/NYOBHxdJ3L4lwqXuhVWluccTpMNNGlE1EwDon2fWy3nimPef9s+Z1affsrDhJXIR2TJwhezCseugkz6HzrvjBxVI+XfWux6eTsrgrs5Te8vsTEci7yZg5u9ryAc0c8lPP9kx9nJXDaeaWqcyabsd3z27Gl3COwnhpMQ4Ora3Ear4/NWTkzqaIhvJ0N5J9EA4DysGJGgtJ/+ppzWq8MS085/L1CeD2JSGKqGloMD5m9HBVZmDWMw0dd9TJjpisN8ASxYQemEp9wBNUxR6MPNqRj8gF8rWB9tKhMwg0sEm/d2ApFx409K7Ty1XKQL8HRtjH6j07bD43DXN9An1Fg+A1wOAwrAJWT2YmkstGpO9wtwh7ny4Zyhg6rNIV7Y3dC3ztvr5iQn1XFEEl3mxlszUs15ro9QDemhXibBhwOMDz0tMBUroMNOMXwyrF0FMW6MZojLDwHd/IjUzofzv5meLPMsZPx5js8T08iencGxkEPawLdOBrxzs8mFXytkdqTEJLTMnp9Yykiq2rpArOzy3lwKvYEHhINnOab1YUb/EAVJPCJ9zn8sxPEx62GvXls+YD08ijhW53c500brYzVl7tCct3/C3tymyopKQTNyXtxaufHCAzbLqmZ5hnZG1rERpKSp4Hqjhm5tGlzAxN42RGtuRv4x7httF7BmWRij3UTsaXJ3sxNvIH5AJ5kWriodpZTSJx18G9W/rg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3375.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(44832011)(38100700002)(6506007)(83380400001)(6512007)(8676002)(2906002)(6666004)(8936002)(66946007)(66476007)(66556008)(5660300002)(53546011)(186003)(6486002)(86362001)(26005)(316002)(2616005)(36756003)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clBoTVpBNExoUENDK1QrZ2ZjNVBYQzRYSjlJaU9yQ2duQTNpRVVZUUUveVlK?=
 =?utf-8?B?dEVkY1YyMXc0UGVId0NVcmdNQ1JzSXh5N00wRmNGcHlZdjlnOEJQOXdPSVBQ?=
 =?utf-8?B?eEtxS3ZudDYrWWFhVXZaQkdzeS9ocWJIcVdCbVNZeDIzV29xTUY3NUZvanFu?=
 =?utf-8?B?U0JxTld4VUtzUzhtOTZIZ0RJMm9adUJFM1RLR0UzTDJENEVpZWc2RXBNNGdO?=
 =?utf-8?B?WDQyVnNPSDNHNWpoYmVCM2xCdnpGRVRaTTZ4V1hlL3gvOUxIdXRKMU5DWFNE?=
 =?utf-8?B?b1U3OWxoUFVmWVMzcnc0bWZINGJiU09mcTlHMDQvcG1HV2pXeGdwbFdmWkpP?=
 =?utf-8?B?V2lZKzh3WjVmL0c5Yzl0UW9vc1l1dmxUREZNN3Z5L3R3ZWptZkpGSzhTbU5h?=
 =?utf-8?B?Rlh2R095eWJZaEhsbmNXOUdtOTUxZllYRE1RRVMrYytJcG5haFoxaXlST3FG?=
 =?utf-8?B?M2FvSWtaajNuN0o5TnlNb3lOY21BWEtFYlBHTmJMVERCRCtZajdrL0lZSE9u?=
 =?utf-8?B?MXo4N0xHcDRCaEVXVW9lMGlQV1JmV0ViMlFWVmFjNmlTbC9wRWtmZlRkWklu?=
 =?utf-8?B?cFdFSVFieGFVd0U2Nm8vejZJd3V0Q25WSEpTSWJDMFVCeEMvNS8ra0lKQTBq?=
 =?utf-8?B?N243YWxPcjgvOEZIa2NzK3RXdnEwSlV6YW9jM3ZnSUo5MDBNRUpndnAvR05Z?=
 =?utf-8?B?ak1RWWNSQmhZekpZeVdwQnM5ZzFhL3EwOHYvQ0dZZHlVd3J5ZURUNE9zbXZl?=
 =?utf-8?B?K1VseU9rUnM3ekw5SWw3VWNvN1BJUncyK2VPNjZNVzBVS0dyYzIzcVVkV0Fw?=
 =?utf-8?B?azAwSjNSMTVSUnZrcGZwNEt1TmFScGE1aktEZm5VVldpVHRaVzJLemZzTmd4?=
 =?utf-8?B?NWhGbVJOREpNd3RSaEk2UDNQTXBOb09lVS94ZVNnUmJIdlZ1M3h2TEVnUUUy?=
 =?utf-8?B?V2h4ZVMzMVArZ0t6RjBHWTdIYzhsUDN4ZXp2YkJlTFJFL2lBWW5jUm0ydzYz?=
 =?utf-8?B?YkV6aDBMeXlzN3UzNndiQjFvM1ZRaXg1dlV5eDVwTS80aFBUVVZFdFlEa25F?=
 =?utf-8?B?NUxvdFVqUGowd01mbHNlNmRzcTVRRC9URWhIWTVzV1Q3ZkZFZ3V3cU5CYzNK?=
 =?utf-8?B?dytGN3pSVlZqNXRFRkNHZTdSNjMxZkhwUUpkS0dsMDNkVWZ0a2RGNmlVcUZP?=
 =?utf-8?B?cmFkTWdKQ3dvL2dFekV2UUZtbEhBc2lBcWZYM0dVUmNneUIzZU1JQXNBSlpR?=
 =?utf-8?B?NDFhOGZtSzBGQzdXVnVqNmowRWltQmMvTFZ2TXNhSk5nSnZleWFVSDN3YlVr?=
 =?utf-8?B?VWxDckY1RnA0YXpOVmhSQnhGV2N0dlVJY0RLcUl6Wmp1MGJXc1ZFajFKc29G?=
 =?utf-8?B?T2JIWENvNFp6ODgrLy9tV25XNmpwV2ZVN2FwNGMydFM5TVp6UGFVbzRSSXVO?=
 =?utf-8?B?QmQrQVlZZVlnbGs4WnZMd1RTeHZjMjQyQXpWdGpReDI2ZGFUNWZhNm5GclBp?=
 =?utf-8?B?NXJ3NXV4U3ZsOHY0QW1Xd0p6eVpOZEpoYUVGMUVxZVI0amNnbXlCS3d6ci9r?=
 =?utf-8?B?bWRUU3RpU1VIZDhBTGd4SEJZM3pKbGU4Z2gwLzEzWUxzc0FidDJjRFp4NUZR?=
 =?utf-8?B?emxmY0l5cFRZTXVHYUl5WWRYQkpIRGdxSU9HTjgvR25sNmpkSHhlWDF0cURo?=
 =?utf-8?B?SkJhbk9DRGtMRWNDMVRXb1NlNXEyL0psZkJiaW5NTmxCNWhmM1ZMZXY1bVBm?=
 =?utf-8?B?UDBWRVFmdzNZQktNS0VpaUpreDFEOG9XN1BTT2hVQjJTcE5aa0RseDhDSm5E?=
 =?utf-8?B?bXhvYnlLSVc1YnJxVEowT1NZekhweHJISzlqY1gvcHhVQTBsMjcvdkZDaUJo?=
 =?utf-8?B?OWRsMkJteGRnRklVTVViS285dHJWTXhaamJJbXoraGJVZ2JSR3pUYm9XUlpY?=
 =?utf-8?B?OFp1dlRkQnhVcTJMS2hEODF4YmRKTy9yc3hYRmlPN3NEMm04UlFCaU9QYWVj?=
 =?utf-8?B?d3R4MUNsZjBGM0hzUnpubGNNckNleW5DVGJJcUFuc2JPWUZkNlJVMmtnazlv?=
 =?utf-8?B?YkgzMlJRNExveU5JcXIyQjZwV3U0OHFjRmZFQjJhMnl4YmFrcmx5SU9CaDVy?=
 =?utf-8?Q?XoUg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ea5e50-28bb-431c-29f5-08d9e01d6460
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3375.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 16:11:49.3582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frGE10kGM4Eb9eKtPHCjYp5T36z5RBp4J0JynDsC0JubonmYRYgAWeqNTEYCEo+D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1751
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

Patch is fine, if it does what you want. A few comments inline.

On 2022-01-24 13:07, Tom St Denis wrote:
> Newer hardware has a discovery table in hardware that the kernel will
> rely on instead of header files for things like IP offsets.  This
> sysfs entry adds a simple to parse table of IP instances and segment
> offsets.
>
> Produces output that looks like:
>
> $ cat ip_discovery_text
> ATHUB{0} v2.0.0: 00000c00 02408c00
> CLKA{0} v11.0.0: 00016c00 02401800
> CLKA{1} v11.0.0: 00016e00 02401c00
> CLKA{2} v11.0.0: 00017000 02402000
> CLKA{3} v11.0.0: 00017200 02402400
> CLKA{4} v11.0.0: 0001b000 0242d800
> CLKB{0} v11.0.0: 00017e00 0240bc00
> DBGU_NBIO{0} v3.0.0: 000001c0 02409000
> DBGU0{0} v3.0.0: 00000180 02409800
> DBGU1{0} v3.0.0: 000001a0 02409c00
> DF{0} v3.0.0: 00007000 0240b800
> DFX{0} v4.1.0: 00000580 02409400
> DFX_DAP{0} v2.0.0: 000005a0 00b80000 0240c400
> DMU{0} v2.0.2: 00000012 000000c0 000034c0 00009000 02403c00
> FUSE{0} v11.0.0: 00017400 02401400
> GC{0} v10.1.10: 00001260 0000a000 02402c00
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 77 ++++++++++++++++++-
>  2 files changed, 77 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3bc76759c143..6920f73bbe73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1019,6 +1019,7 @@ struct amdgpu_device {
>  	struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
>  	uint32_t		        harvest_ip_mask;
>  	int				num_ip_blocks;
> +	char			*ip_discovery_text;

The above is not aligned. Don't use hard tabs to align. Just use spaces.

>  	struct mutex	mn_lock;
>  	DECLARE_HASHTABLE(mn_hash, 7);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 285811509d94..c64cab0ad18e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -267,6 +267,19 @@ static void amdgpu_discovery_harvest_config_quirk(struct amdgpu_device *adev)
>  	}
>  }
>  
> +static ssize_t ip_discovery_text_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +
> +	return sysfs_emit(buf, "%s", adev->ip_discovery_text);
> +}
> +
> +static DEVICE_ATTR(ip_discovery_text, S_IRUGO,
> +				ip_discovery_text_show, NULL);
> +
> +
>  static int amdgpu_discovery_init(struct amdgpu_device *adev)
>  {
>  	struct table_info *info;
> @@ -351,6 +364,11 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>  		goto out;
>  	}
>  
> +	// init sysfs for ip_discovery
> +	r = sysfs_create_file(&adev->dev->kobj, &dev_attr_ip_discovery_text.attr);
> +	if (r)
> +		dev_err(adev->dev, "Could not create amdgpu device attr\n");
> +
>  	return 0;
>  
>  out:
> @@ -363,7 +381,11 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>  void amdgpu_discovery_fini(struct amdgpu_device *adev)
>  {
>  	kfree(adev->mman.discovery_bin);
> +	kfree(adev->ip_discovery_text);
> +	sysfs_remove_file(&adev->dev->kobj, &dev_attr_ip_discovery_text.attr);
> +
>  	adev->mman.discovery_bin = NULL;
> +	adev->ip_discovery_text = NULL;
>  }
>  
>  static int amdgpu_discovery_validate_ip(const struct ip *ip)
> @@ -382,6 +404,20 @@ static int amdgpu_discovery_validate_ip(const struct ip *ip)
>  	return 0;
>  }
>  
> +static int add_string(char **dst, unsigned *size, char *src)
> +{
> +	if (strlen(src) + strlen(*dst) >= *size) {
> +		void *tmp = krealloc(*dst, *size + 4096, GFP_KERNEL);
> +		if (!tmp) {
> +			return -1;
> +		}
> +		*dst = tmp;
> +		*size = *size + 4096;
> +	}
> +	strcat(*dst, src);

Heavy reliance in *dst and src ending in '\0'. See below.

> +	return 0;
> +}
> +
>  int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  {
>  	struct binary_header *bhdr;
> @@ -396,6 +432,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  	int hw_ip;
>  	int i, j, k;
>  	int r;
> +	unsigned txt_size = 4096;

Can you use a local macro here for this literal, and possibly define that local macro to PAGE_SIZE.

> +	char *linebuf;
>  
>  	r = amdgpu_discovery_init(adev);
>  	if (r) {
> @@ -410,6 +448,15 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  
>  	DRM_DEBUG("number of dies: %d\n", num_dies);
>  
> +	adev->ip_discovery_text = kzalloc(txt_size, GFP_KERNEL);
> +	linebuf = kzalloc(4096, GFP_KERNEL);
> +	if (!adev->ip_discovery_text || !linebuf) {
> +		DRM_ERROR("Out of memory\n");
> +		kfree(linebuf);
> +		kfree(adev->ip_discovery_text);
> +		return -ENOMEM;
> +	}
> +
>  	for (i = 0; i < num_dies; i++) {
>  		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
>  		dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
> @@ -419,6 +466,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  		if (le16_to_cpu(dhdr->die_id) != i) {
>  			DRM_ERROR("invalid die id %d, expected %d\n",
>  					le16_to_cpu(dhdr->die_id), i);
> +			kfree(linebuf);
> +			kfree(adev->ip_discovery_text);
>  			return -EINVAL;
>  		}
>  
> @@ -458,6 +507,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  			    le16_to_cpu(ip->hw_id) == SDMA3_HWID)
>  				adev->sdma.num_instances++;
>  
> +			snprintf(linebuf, 4096, "%s{%d} v%d.%d.%d: ",
> +				  hw_id_names[le16_to_cpu(ip->hw_id)],
> +				  ip->number_instance,
> +				  ip->major, ip->minor,
> +				  ip->revision);

This and add_string() and sysfs_emit() all rely that the strings in "ip" all end with '\0'. snprintf() is somehow protected here, since it uses the 4096 limit. Is it possible that a string could be too long and overwrite the 4096 limit? Maybe make it 4096-1, so that snprintf has space to write the '\0', or make sure that we do end with '\0'? Unless we can guarantee that it'll always end with '\0'...

> +			if (add_string(&adev->ip_discovery_text, &txt_size, linebuf)) {
> +				DRM_ERROR("Out of memory\n");
> +				kfree(linebuf);
> +				kfree(adev->ip_discovery_text);
> +				return -ENOMEM;
> +			}
> +
> +
>  			for (k = 0; k < num_base_address; k++) {
>  				/*
>  				 * convert the endianness of base addresses in place,
> @@ -465,6 +527,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  				 */
>  				ip->base_address[k] = le32_to_cpu(ip->base_address[k]);
>  				DRM_DEBUG("\t0x%08x\n", ip->base_address[k]);
> +				snprintf(linebuf, 4096, "%08lx ", (unsigned long)ip->base_address[k]);
> +				if (add_string(&adev->ip_discovery_text, &txt_size, linebuf)) {
> +					DRM_ERROR("Out of memory\n");
> +					kfree(linebuf);
> +					kfree(adev->ip_discovery_text);
> +					return -ENOMEM;
> +				}
> +			}
> +			if (add_string(&adev->ip_discovery_text, &txt_size, "\n")) {
> +				DRM_ERROR("Out of memory\n");
> +				kfree(linebuf);
> +				kfree(adev->ip_discovery_text);
> +				return -ENOMEM;
>  			}
>  
>  			for (hw_ip = 0; hw_ip < MAX_HWIP; hw_ip++) {
> @@ -491,7 +566,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  			ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
>  		}
>  	}
> -
> +	kfree(linebuf);
>  	return 0;
>  }
>  

Regards,
-- 
Luben

