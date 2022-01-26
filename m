Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3849BC2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 05:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B874910E42F;
	Wed, 26 Jan 2022 05:36:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B8010E42F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 05:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWXwirCyvkQdkiBEHOMuFrPy5QUKtTAaixgqZhHfuci+5n9+mOCct+hXCCfv1Ja5ELkWUuBtDtA36AE/di/Q/3nZaS9n6MlVYgbZXvV9BxdLbancFO60TgrC7N/K8P6D9PrWdvn7Bua7X4C1Uh3uj6z9J0FrDc1ecf6/x5GAdiVvV9XXgvGUFK316sB7Jb1QWms35Flma3kNCm934IjAD5X2eF6G91leKhhE/u7+UzMWmDxfabN44PIg7MJAiRmnN/hUsiww1sYBjWpkkXqFZHqfTv6TRvJPjTSdKSu21Y8nELUYW46q5zCXjTnbuU08L91AaRJyFRSQm+6BNSxuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbnLc0LlhcOZE1G2YmRCccYWES6qWTU7cwY4rvQeiC8=;
 b=KyvylYKd1Ugdb/+xZKoyOaKa2BeWSugbkFwrcjeyvqRuNsjHZKbGgH3yTjxxbKEwqS7ofioHB2MKhkDWXXTae9HYa5gPnZOn/zkuJglXWKR+nd8jI2ya/vDF+dBN/F0HzUQAwF8Rl6jv39Zh7bgNWJPqKg2yaHUDv0DVjuxBSw5MctZFe1o09rXXeBOHSZOH3QfTRBG43qgNi4FDM/AH6BlKmq90L7G2kDPSwz3wEa6LEtTRPqA5IewyNCNOYD4IizjB7h4omBC8L0mKgQElgwH6fG2Bw7Yj4TxNW13PxeWsxCHcSyq6ejwUGMIFGp8nF3Iu1byB8PIETwE+XHg8KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbnLc0LlhcOZE1G2YmRCccYWES6qWTU7cwY4rvQeiC8=;
 b=lh7sK9DWOOtEuJ3uzmupnGBP4sKNn1dDK3cgsVy/d1amqQ5Kr0nruOoc8faRvu1ojpMz3StoVqUuNkV7KSXuvRkE3s0EWfBTuoKwgHgSq5/08lxcH0fdmB++xj6hKTkrkw4TaPtMeVz24JVa+PrTaGZneJzlrCsfZ4p/W1zXrHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MWHPR12MB1440.namprd12.prod.outlook.com (2603:10b6:300:13::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 05:35:56 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 05:35:56 +0000
Message-ID: <4a4917ef-a770-17f0-f72c-e4321792eaef@amd.com>
Date: Tue, 25 Jan 2022 23:35:54 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: drm/amd/amdgpu: Add ip_discovery_text sysfs entry (v2)
Content-Language: en-US
To: Tom St Denis <tom.stdenis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220125181835.2735521-1-tom.stdenis@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220125181835.2735521-1-tom.stdenis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::30) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 438250a9-0b86-45bc-0a16-08d9e08db9f4
X-MS-TrafficTypeDiagnostic: MWHPR12MB1440:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1440AC580E94D3EDAAB8D6E5E2209@MWHPR12MB1440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5C7V5YXuxofVb8ys60PWgmXNGQlfKiMbl+YHaDC9BlWDeDi3aZN7u4w4t7noHycD2nnSuRjQ9S+DSeECo+30PpnpANhPL7yaCjI2v2bgKrZA+A9CY0ZZXjRg42AjOg11vPJgAKJG28daIE6YhNsXW3wIxgUDxxZuE1QyNRE/oDp5zvwmWtxNSdBJNoYkZN446fJ9s4gnNE0EGqNM/IEyz35QLL6uBi4SOOsneEJnGnn+3VrFNbac4TQ24v5XumVul+Xjv44/j23suhShp/EwCpGtF1XzhNWm8qWgY2Xk3Q3vooAnkCnh7xM+Zr9OhdzPIWgTIvIg/gAhzsPDDw6U/iGM68xiqnPrRPQVAtPYq2aNXnjlFfuNeAR3RfrDZN+HEQzK48pbmnI0pZJB7yH6GzjFLTApD4rMzY/gYVT47RzLsQk5Ijvy7eTsl7BNEThbRNE3NojRFxX3NWjihkTV4JnFWDwDseRFbRicQOeSpBDJobq2yVIG3LaiI3JMY1deewZmFf4du8OwNWkRDYH94DAiv+f5UxZXR28L5VG5fDrOglm545tEwR7a973Z5sGoSPm/2UoDNAYx9J+8+RZoeKVOGUpvyyaa3P3f5IFO/busJSNd+/xPAPu7cMC99NlENlN0T7Ut7w447tlma7wXyPWVuI39NuI+7ryiHanil5ozg1ZcIGX0lna1thUISqtP2x/sA/JQqZaFRC3ZaGnr0qQ8GUZzZoSmTx6MSmjg7KM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(5660300002)(316002)(2906002)(8676002)(8936002)(31696002)(66556008)(66476007)(66946007)(53546011)(86362001)(31686004)(2616005)(508600001)(83380400001)(26005)(36756003)(6486002)(186003)(6506007)(6512007)(43740500002)(45980500001)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlR4dy9sQm5nelJxdEs1V3NQRytGQmNYYy8vU0RybEkyekgwZXhIcWYrY2dj?=
 =?utf-8?B?dHB6dWU5QTdpMzhsYW1TVVFoZHBKOWgwZXAwSGhtRUx5UGZtdGtkSGtuUk1j?=
 =?utf-8?B?RFlkdHJmeUVVUUtodnZRL3VUenRnaE1UQVRhaEZqbkpzTkpVWVdLcFFERE8v?=
 =?utf-8?B?cGZSWEg0U0lLdVd1Q3lpZHc0ZmxxSUtWTlNJQVRUOFIzSUo2UUJycW82RGp2?=
 =?utf-8?B?ZitMclpOZkFVVGxOY0ROWUpEL2psS2hkbTAvRTJ3eCswWGVlSVg2Y2hSbHZ6?=
 =?utf-8?B?YjAydEtqNzRaUDB0YkQwRVlYZnJrNStBMWRYb083THNPVVhPdjgxbng4Yzln?=
 =?utf-8?B?ak5QYk1pZ21kRWM3VHNzOTgyQnFVUk1uOHErUndmZ09GaDVJQ1lNZ0NoVVZF?=
 =?utf-8?B?YjZqaFF3YnhrdENlYm1XUm5nLzNBSC9YUjd6L0pjNnM2ZitBdkZUWXhnQlA3?=
 =?utf-8?B?dkdWWTl4bUN6UnhHN1ZXYVZJakRwdGR0ZUlhQXJBSi9FZTUwVU9OZ0xxdGRo?=
 =?utf-8?B?VUpKbXZLRXVRT0hPZHRjSHh6VEpndE5RWXNoRmo1NkU5TE5Uazhwa09zd2sw?=
 =?utf-8?B?cUQ2Tk5TTVJSZlFTM3VsUmZTeWtHYjV1cDk5R28vRlhrQUdWNnNNdW9TVUFn?=
 =?utf-8?B?dGxBc0p4ci96ZXAvN0lRN21OY1d5V3VJMGl6RmsxRjlzMEdnRGhSNTVkZE1K?=
 =?utf-8?B?VHIvajNvMXpjZ0xrUS9XWnI2RHlWb3UyVmJ2RGhzZ2Q3S3dMMFlkR0NnL0dE?=
 =?utf-8?B?SDBWcnRzbUg4cnFMRDViNmgvL2cxNTJQWjY3d1g2WEVURVd3Tkx3K00zS2NI?=
 =?utf-8?B?dWoyb1pLMVNUbWZBLzVnZWVZOGo4MDJuYklzZ0lzRFEyWHFPY1gzbERzdi9n?=
 =?utf-8?B?YWoyYWoycDFDYWFXZnNZOEh0OFFlRmhsVkxubzVxMmh1ZGQ2TW11ZmdZdlBC?=
 =?utf-8?B?Q0xUa0hoYXBnNnRCRWNMTk5aRW03THhNaDE0eFBTdmhYY1duU3Q5QjRqcDRp?=
 =?utf-8?B?YjlDSHp6VjY1TlVONlBRbGltaXhiOFZjYmp1SmlITWJPcDdvK2c4d3JieFJi?=
 =?utf-8?B?T2llbXVYTHpWZlRTMW93NUFZNUhyQ2p3WkhHbEpycW1aSnRUbThwUllKOEVo?=
 =?utf-8?B?cEFxRG9MNlpjcUhCc3k5VVJOZFpyOXVySEpJRjNQSG9HRWNRTmhiaEVlbGJ4?=
 =?utf-8?B?UENYYTdvd2gyZzVNazRwUkhhQnErZUZ3b1Y5aDB6QUloZ0p2TlNKVkF4T1pV?=
 =?utf-8?B?U2M3M1Rha3NLRFc4bWd0SEdFVmxjQVJIYWxNSXY2RWFTeFpsVmE3ZllxMHRV?=
 =?utf-8?B?RkxWRHB5ajloNFVmY3F4Q0s3OFlBYmZKSGhFZXdRSjdyWEF1SEtpdWNrclRX?=
 =?utf-8?B?OGNxbENvekx4TkMxcUFnV1p4YldrTHlaUFA5Ymo2cWRDNXlhZmpHS2w5bVlU?=
 =?utf-8?B?MGNoQkFjeVVFUm94TzVORXpEbnJNd1VVcnlJOFpNWDNTaUFNODJaQjloa0Rq?=
 =?utf-8?B?M1hJU3dqRWJUeWtkU3Y3Zm0yYU1pQWFBYUZWQnVoSDV6RXg2Q0V1dWYvVWE3?=
 =?utf-8?B?QmhmNlhuL25IWjVuUkd5V0VVcDVEbHdJR3FhSDUyRzMrYVo1QTNrZDRyRG5i?=
 =?utf-8?B?b3c4ZS95MmZjMlozU3JPVGREYmdpblJYSVUyQjBXV1ByVDZkYk9DYmhzei9N?=
 =?utf-8?B?V3hZM05EVXkxcVc3N3J1WGJ6R09QYUxRTUt2cEQ1d09Qc29WWmRBZHA0a29D?=
 =?utf-8?B?VkE2KzI1OGZ0ekh2ZnR1MWh5SWEvRzBndnBTRFZXZlE2YTdKbk02NXJEbENR?=
 =?utf-8?B?WERraGkrNnlMSlowbld4OEcyTk1PeVM0eWp3NmNGbDJoNUMwYy8wV0pWMG91?=
 =?utf-8?B?eGJaSFBReFFrRU9leUJvNlNrSmpUZnljcW1rNDg0QUkvTndpVFArditoMmRD?=
 =?utf-8?B?TTVtZWgvMXZlSGhVUmkyS1VjM0ZuUll1U1hEcjhoMjE0OUF1SzRBK2IwM2Yr?=
 =?utf-8?B?dXpqUDAzSzM5c25JN1hRRXNHcGtzK0Q0cjgxZWZOMGtZQU53OHpoZGtkU3dx?=
 =?utf-8?B?SFRjRFlyc0VEdHZaN1phTzBtalBwNFJHK2pKcUNSTG5EOXk4Z2d3WGJ2N1d3?=
 =?utf-8?B?eXBpQ0pDbVVScG5BMnpjNkxzeUZGVFdGYTVCYXhYQkJlUDRsbGZuL283YnRm?=
 =?utf-8?Q?tRqA3fq/nTA78GpBZ+xArZ0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438250a9-0b86-45bc-0a16-08d9e08db9f4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 05:35:56.6277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1rOz3BKulog7NznzjwDTWDqpt9Thiw+N7PPNFhE1O3FSJfs9Etx1efxefXDscpalf+C6Ifb4Mtb2JWLGK93kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1440
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

A few suggestion ideas inline.

On 1/25/2022 12:18, Tom St Denis wrote:
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
> (v2): Use a macro for buffer size and fix alignment in amdgpu.h
> 
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 79 ++++++++++++++++++-
>   2 files changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3bc76759c143..43caeb4bdc07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1019,6 +1019,7 @@ struct amdgpu_device {
>   	struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
>   	uint32_t		        harvest_ip_mask;
>   	int				num_ip_blocks;
> +	char            *ip_discovery_text;
>   	struct mutex	mn_lock;
>   	DECLARE_HASHTABLE(mn_hash, 7);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 07623634fdc2..d036977dab8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -267,6 +267,19 @@ static void amdgpu_discovery_harvest_config_quirk(struct amdgpu_device *adev)
>   	}
>   }
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
>   static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   {
>   	struct table_info *info;
> @@ -351,6 +364,11 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   		goto out;
>   	}
>   
> +	// init sysfs for ip_discovery
> +	r = sysfs_create_file(&adev->dev->kobj, &dev_attr_ip_discovery_text.attr);
> +	if (r)
> +		dev_err(adev->dev, "Could not create amdgpu device attr\n");
> +
>   	return 0;
>   
>   out:
> @@ -363,7 +381,11 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
>   void amdgpu_discovery_fini(struct amdgpu_device *adev)
>   {
>   	kfree(adev->mman.discovery_bin);
> +	kfree(adev->ip_discovery_text);
> +	sysfs_remove_file(&adev->dev->kobj, &dev_attr_ip_discovery_text.attr);
> +
>   	adev->mman.discovery_bin = NULL;
> +	adev->ip_discovery_text = NULL;
>   }
>   
>   static int amdgpu_discovery_validate_ip(const struct ip *ip)
> @@ -382,6 +404,22 @@ static int amdgpu_discovery_validate_ip(const struct ip *ip)
>   	return 0;
>   }
>   
> +#define IP_DISCOVERY_BLOCK_SIZE 4096
> +
> +static int add_string(char **dst, unsigned *size, char *src)
> +{
> +	if (strlen(src) + strlen(*dst) >= *size) {
> +		void *tmp = krealloc(*dst, *size + IP_DISCOVERY_BLOCK_SIZE, GFP_KERNEL);
> +		if (!tmp) {
> +			return -1;

If you take my other suggestion on cleanup, maybe you can also return 
-ENOMEM here.

> +		}
> +		*dst = tmp;
> +		*size = *size + IP_DISCOVERY_BLOCK_SIZE;
> +	}
> +	strcat(*dst, src);
> +	return 0;
> +}
> +
>   int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   {
>   	struct binary_header *bhdr;
> @@ -396,6 +434,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   	int hw_ip;
>   	int i, j, k;
>   	int r;
> +	unsigned txt_size = IP_DISCOVERY_BLOCK_SIZE;
> +	char *linebuf;
>   
>   	r = amdgpu_discovery_init(adev);
>   	if (r) {
> @@ -410,6 +450,15 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   
>   	DRM_DEBUG("number of dies: %d\n", num_dies);
>   
> +	adev->ip_discovery_text = kzalloc(txt_size, GFP_KERNEL);
> +	linebuf = kzalloc(IP_DISCOVERY_BLOCK_SIZE, GFP_KERNEL);
> +	if (!adev->ip_discovery_text || !linebuf) {
> +		DRM_ERROR("Out of memory\n");
> +		kfree(linebuf);
> +		kfree(adev->ip_discovery_text);

You've got a variety of new codepaths that do this freeing of the 
memory.  Have you considered to add a "goto cleanup" instead at the end
of the function?

Then each of these turns into
	ret = -ENOMEM;
	goto cleanup;

cleanup:
	DRM_ERROR("Out of memory");
	kfree(..)
	kfree(..)
	return ret;

> +		return -ENOMEM;
> +	}
> +
>   	for (i = 0; i < num_dies; i++) {
>   		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
>   		dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
> @@ -419,6 +468,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   		if (le16_to_cpu(dhdr->die_id) != i) {
>   			DRM_ERROR("invalid die id %d, expected %d\n",
>   					le16_to_cpu(dhdr->die_id), i);
> +			kfree(linebuf);
> +			kfree(adev->ip_discovery_text);
>   			return -EINVAL;
>   		}
>   
> @@ -458,6 +509,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   			    le16_to_cpu(ip->hw_id) == SDMA3_HWID)
>   				adev->sdma.num_instances++;
>   
> +			snprintf(linebuf, IP_DISCOVERY_BLOCK_SIZE-1, "%s{%d} v%d.%d.%d: ",
> +				  hw_id_names[le16_to_cpu(ip->hw_id)],
> +				  ip->number_instance,
> +				  ip->major, ip->minor,
> +				  ip->revision);
> +			if (add_string(&adev->ip_discovery_text, &txt_size, linebuf)) {

If you take my other suggestion, you could instead do something like
ret = add_string(..)
if (ret)
	goto cleanup;

Here and the other places you use add_string.

> +				DRM_ERROR("Out of memory\n");
> +				kfree(linebuf);
> +				kfree(adev->ip_discovery_text);
> +				return -ENOMEM;
> +			}
> +
> +
>   			for (k = 0; k < num_base_address; k++) {
>   				/*
>   				 * convert the endianness of base addresses in place,
> @@ -465,6 +529,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   				 */
>   				ip->base_address[k] = le32_to_cpu(ip->base_address[k]);
>   				DRM_DEBUG("\t0x%08x\n", ip->base_address[k]);
> +				snprintf(linebuf, IP_DISCOVERY_BLOCK_SIZE-1, "%08lx ", (unsigned long)ip->base_address[k]);
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
>   			}
>   
>   			for (hw_ip = 0; hw_ip < MAX_HWIP; hw_ip++) {
> @@ -491,7 +568,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>   			ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
>   		}
>   	}
> -
> +	kfree(linebuf);
>   	return 0;
>   }
>   

