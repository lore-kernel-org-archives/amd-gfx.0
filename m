Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A70C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 20:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF69510E451;
	Tue, 25 Jan 2022 20:31:16 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2067.outbound.protection.outlook.com [40.107.100.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C88D10E451
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 20:31:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8Vv/8rEAO33YuglbJJsrCJlmdycrLvo7nnbOSCG7oNp1OUyhYjONOOkYOKh1S3bETkJgqsJW9EoTH7tX54gEuJA1frugm0QowwdpjFQBtTyWA9WK5sqP/V12LPhBzoOtIr66RWA4g4bXxLfhF8Fgszo+aQxdKtm0gLj/9xru/rOqHDX/ptWVIKiLEACvbwzLPmaDgPS4hxMAmoCUtpSiSq3pWaDtnIVSz8xyfhjRVzRNQWqkF1eyx/ZNWNCKIQSylaWele+kdc9pMm8gGIO96WX/EMCBGIDgWbGoSHRHfuZwtWtD/94XrdJYCYFVjVK9kUw0c4lCH+Y70PFHLUCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AipzBaJEB2nFAtVFBHw6/xMV2hb2R+HN3gs4MHYJRHk=;
 b=aPpB6yC+KmXuk1edtZ2jHxKRIcZnbXwaFL2M+yiSZ9oBvHpEPw/B5CV51rH2Dr4XogZhY9zivdFYdNOoYGGhjlmNZRUUyrnnCluHr3nUWnRVq8qEn/mngJir40w/+hg4y/0T1J5UT3RQaiaL7ZaEIYPpu9356d1ZMXIe2omJ1nwDTZZciuwMNIkQMoxvTENp3j5ijT6SwUV1B7Q0kZi0FBqwQVB9vTZmZZeey781X/i3rFNxWmo6mIe/198D3fP1iohdMixjNARaBvD09WBApAjCzil7xAmN9SGmydRYEDxCIQMKGQaAT25xue6oMtM+OBnqCGS8L85CF0Ib0PJmbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AipzBaJEB2nFAtVFBHw6/xMV2hb2R+HN3gs4MHYJRHk=;
 b=X1DdgP0qzyElF6u3qPZTa+iwL7cJMkFtnGHBSKL/Fd93Efq31EeCzCNjk9ftRGWRjjjIuWH1pLE03lhNd2k+6S2q486MWImXAMtGZdQ39g5aBXZOYYOAbbj3G5jwcFdCJxeoQQVToLZelfT7zzLHCO0RJvLnQKPfIYJj8rMFQNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3375.namprd12.prod.outlook.com (2603:10b6:208:cc::12)
 by BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 25 Jan
 2022 20:31:13 +0000
Received: from MN2PR12MB3375.namprd12.prod.outlook.com
 ([fe80::5593:bc50:9e71:71e7]) by MN2PR12MB3375.namprd12.prod.outlook.com
 ([fe80::5593:bc50:9e71:71e7%5]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 20:31:13 +0000
Message-ID: <f34cb356-da1e-5241-56dc-c290a908f292@amd.com>
Date: Tue, 25 Jan 2022 15:31:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] drm/amd/amdgpu: Add ip_discovery_text sysfs entry (v2)
Content-Language: en-CA
To: Tom St Denis <tom.stdenis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220125181835.2735521-1-tom.stdenis@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220125181835.2735521-1-tom.stdenis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To MN2PR12MB3375.namprd12.prod.outlook.com
 (2603:10b6:208:cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 098b8f35-181f-4671-4355-08d9e041a128
X-MS-TrafficTypeDiagnostic: BN9PR12MB5273:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB52731175019702EBD8D3B054995F9@BN9PR12MB5273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdIdpfJ18P062x/JCv2kznlTsqlO7SUqFtvK54R35ZEWad3q9VW0Uez5Bwin0gU3JXc9vCTuPJT4UeY/cfFI8wSmhUKhA+SjTw+gYQbiuBRK/UfG4pt1HN0s7FdtKSm6+7DI0nN/m5/SzFSkq5AulG+XvkHBbgnvXGhLJNjskvC2Crln26AGlEvb3/dMyJsssNaxhw83aL+5vMBIS1AK70BRK3ty7A9ltRQiqoDbieCXuvvCFqhT+2L6n6xj5p8w/Gf7AvReGKuWqERQdRiHn5WZ2ksXKk6lqC9MKJU/Q4bMI0cQZnwIJw+qC/PxQzK0q82y0j1XrramcLPhg5QCZxBNRtbXgCe5+yoNSOeF1vtJ9MC37sapD/4oYVxTgVkVrnOy+iJYQ2rE/nj2QI33AVP/LZQZE/mf3tcGI3WTzoCiNWnjG/DYt4BPPQWQsFeb12qgaqC0HCg6cm/hdO32kNZecjsYu2tb+CASf0sRgPhhjnskZ6dHfhYFasXOXXpfxpR+rUUCQvVPdpBbREtuocvVezS7WqrK8IHzvB2uMwwpbd2j9n6RdbnxxzgFJF8lSWnJGFpDXZVNtlpPiDzI4bwo16g1hPqkpZPBfyzM0u3JO2yNOv1H2KFlZ3z9saN8pdBCfRyWHliuusK0xLjqYkZq6i6phm7kW4sPcRCtMM33tsAgIiek+P5y9GD495m8qzFzvKyqCpb7F/iKP2wbUK1Jt+O1/lIJGNNnHbyq3rw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3375.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(86362001)(31686004)(508600001)(66476007)(26005)(316002)(31696002)(66556008)(83380400001)(38100700002)(6512007)(8676002)(186003)(66946007)(5660300002)(44832011)(2616005)(36756003)(6506007)(53546011)(6486002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHlvZzF4dnlBZ3hIQWltRXc4MjZFRTJrV2FkbUpvU0cxcEtXR3diU3BjdWVI?=
 =?utf-8?B?eDRFK1pSNk81NnIwanVkRkxHc1JpQUIzZzFSWnZyOVRDeTlGQzZHZ0c2dWtw?=
 =?utf-8?B?cnNhTEJpVjZTMHJIcVZQWloxOHkzUS9OdFhweks3QXdCSU52UG1WRG5lcktN?=
 =?utf-8?B?U3c0UmgwSHQ2aHJvWU1yTWkzckhGd3hWS2NncFhxL2k3dUNvaEJlU1B5Tloz?=
 =?utf-8?B?UGpqWUpOY0pFRDZNRFAvZWxSR3lHdDQvUDJ5U0tVVVdjMDdQbkFGbGdMNTVH?=
 =?utf-8?B?WWg5UW9Hc25EY0kwR1B3UTgvbWFEanBQWkdodFJRZElrQmJMUm1NYXc3N1hv?=
 =?utf-8?B?Q1FrcnJLZTFDQ3A3RVAyblZKR2lFWEZrcEVCVVVReXVsRXRBQzZiUGprMlBk?=
 =?utf-8?B?WWpMazBldC90SHVNTlJUcHR3ZXNVN3loc2JYWEYvS1VXcVEwR3JiSm9aZ1RE?=
 =?utf-8?B?YjlkbGR0TDFnclVyUzQ0aDZtaGVZL3doRmExeXBqUjZuNi8rVStGZVhCRDNq?=
 =?utf-8?B?V1YzY1VsRmFIVnJqaTZ6amJxS3QzSlRTZC9mWWhzWnM2aUM5WnNPT0FOT0FS?=
 =?utf-8?B?UXNuYWNlRE5ZWVl2WEpDb2xyTFhLYmIrUE1UM3FsUmwwclBZRzdYUkluUHZX?=
 =?utf-8?B?SkxJVG9HcjdyNW44R05WSW8vaEFrUHZIaDBFM1JpMEEyaVRDZkJPdytaaGRp?=
 =?utf-8?B?V1FvOU1RRWRoakF1TTcrK1dQbE43cjBOM1BzQlY3RGhTLzlOZCt5SXRneUpN?=
 =?utf-8?B?OVVxNURCK3J3SkU4V2JtSGdZQkdIR2dVaHFtdVNKbmVkbDl2YWJFbEFvdGlz?=
 =?utf-8?B?TlhVWlN0ZDFid3RkUFU0ZzBybkhyYWZ0V3hCZVNFUFA2eDZUeHBOSGVuV2cr?=
 =?utf-8?B?WVFDaUZKaUJQcFBsWDRSczg1V3VVemhib3kxSWdjUDVKWTYzNFFLREpFM0pa?=
 =?utf-8?B?dXJJR1ljSkVTVmp0eUdSNEdJUUVKMUNRSDZoV1phMjIyT3dZUlFVNk05YXJG?=
 =?utf-8?B?WmFyRFg4U1pnV0N2RXN6SUdCNEFicElmN2gyV1E4RVZRZ3grZ1hBMDREQTJ6?=
 =?utf-8?B?T05OK2p6Q2dhT3dkdnFEbUpxMUFuMjdoYmdpbjBabUQ2eXhZMWtvZHdzeU9a?=
 =?utf-8?B?eHhUQW1LNFkyY3lhZUxacVRTZ2ZyNXZoV0N1QVRXN2RsWEUzZGpYMFpzdklJ?=
 =?utf-8?B?VUhBTllKeHRpR3VIVDdqTXlTSGU2NUVtNnV4VnhGaFBQV2pOb3hFMlNtVVBh?=
 =?utf-8?B?L2h1M1RxY21LdHlJUTVGSTlqQWVEQlQvQUM5dmFXTVBSRVEyR0thVHNaQUQz?=
 =?utf-8?B?SENvTlI4VzBIOWQzUStDNTRCYlN3b3FDK2JKZzZZRis4cFJ3MVhmMENSRWwv?=
 =?utf-8?B?Tzk0ZDA5a21sVkE2cmhyejJFOW52UnkzcGd2U0krTkRDbEpxQlFVQ2hOc202?=
 =?utf-8?B?QUlSVzRtMmxlcFdpbVhEZEtiOUVJWkFEUWp6TmMzbjdsV1hsdkM1OUVyUGN2?=
 =?utf-8?B?NlRrOEV5dVpJa21EQ3B4ZDlhUzdJa1JNU2tpN2h1UlZlNGR2M0hXOFVWMmV0?=
 =?utf-8?B?RUhUU0t2Tys4MU13aG1hNnBUeldmT0hOQ2pmUy9kL2haaDFKclBzdkV6dUhp?=
 =?utf-8?B?NmNucnBCbE1DdXlLRUhVZnZicTBPSitaNWdOWFBUZW95NHdnclJnSWFvbVlU?=
 =?utf-8?B?dy9wQUFIVG9IN0FhL2hmTWlkU2tseEx4VXBmZGtJbmMraUlud1RNU1ZoNE8r?=
 =?utf-8?B?RVQ2ZjZvQmlyRE4zd1pBRG1Jczk3a3VOR3NVcDVsUlVoeTlweTBkeWlJUDl6?=
 =?utf-8?B?eUpKUUtkc0swbjdySUdTL2VQRDJROHFEUXZVOHdPQldTdStaZXZHSGhDNlFz?=
 =?utf-8?B?T0c0cWIzRW0rb0JpSFBJQVZ3Y3JjK1FGd213T1F6S0pnS2RkMXprR3VJdU1h?=
 =?utf-8?B?ZWh3YTZoSSs1ellxVTk1WkQxNTFTOHBobUhjM2Z0RVpMZ041RjBzMkZWcTl1?=
 =?utf-8?B?blgxdEJZbVhkMzh1RU5GKzhWV1RKTkRnWnJrWkttMk5aby9vaU40bUhKQ1Zk?=
 =?utf-8?B?WW4rUmxiS1luUmFlN0w5cUE3eW81dGwvSmVucERleTE5aExaTjRYZmRYdGVy?=
 =?utf-8?Q?MMd8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098b8f35-181f-4671-4355-08d9e041a128
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3375.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 20:31:13.3870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yO9EouLQwi44yJT563oo/0/4PfCr2VZHf4bOGu0L+HGw19pp509McBiZ3fqNiSd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273
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

Inlined:

On 2022-01-25 13:18, Tom St Denis wrote:
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 79 ++++++++++++++++++-
>  2 files changed, 79 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3bc76759c143..43caeb4bdc07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1019,6 +1019,7 @@ struct amdgpu_device {
>  	struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
>  	uint32_t		        harvest_ip_mask;
>  	int				num_ip_blocks;
> +	char            *ip_discovery_text;
>  	struct mutex	mn_lock;
>  	DECLARE_HASHTABLE(mn_hash, 7);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 07623634fdc2..d036977dab8a 100644
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

C++ comments are discouraged in the kernel.

Run your patch through scripts/checkpatch.pl.

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
> @@ -382,6 +404,22 @@ static int amdgpu_discovery_validate_ip(const struct ip *ip)
>  	return 0;
>  }
>  
> +#define IP_DISCOVERY_BLOCK_SIZE 4096
> +
> +static int add_string(char **dst, unsigned *size, char *src)
> +{
> +	if (strlen(src) + strlen(*dst) >= *size) {
> +		void *tmp = krealloc(*dst, *size + IP_DISCOVERY_BLOCK_SIZE, GFP_KERNEL);
> +		if (!tmp) {
> +			return -1;
> +		}
> +		*dst = tmp;
> +		*size = *size + IP_DISCOVERY_BLOCK_SIZE;
> +	}
> +	strcat(*dst, src);
> +	return 0;
> +}
> +
>  int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  {
>  	struct binary_header *bhdr;
> @@ -396,6 +434,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  	int hw_ip;
>  	int i, j, k;
>  	int r;
> +	unsigned txt_size = IP_DISCOVERY_BLOCK_SIZE;
> +	char *linebuf;
>  
>  	r = amdgpu_discovery_init(adev);
>  	if (r) {
> @@ -410,6 +450,15 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  
>  	DRM_DEBUG("number of dies: %d\n", num_dies);
>  
> +	adev->ip_discovery_text = kzalloc(txt_size, GFP_KERNEL);
> +	linebuf = kzalloc(IP_DISCOVERY_BLOCK_SIZE, GFP_KERNEL);
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
> @@ -419,6 +468,8 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  		if (le16_to_cpu(dhdr->die_id) != i) {
>  			DRM_ERROR("invalid die id %d, expected %d\n",
>  					le16_to_cpu(dhdr->die_id), i);
> +			kfree(linebuf);
> +			kfree(adev->ip_discovery_text);
>  			return -EINVAL;
>  		}
>  
> @@ -458,6 +509,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  			    le16_to_cpu(ip->hw_id) == SDMA3_HWID)
>  				adev->sdma.num_instances++;
>  
> +			snprintf(linebuf, IP_DISCOVERY_BLOCK_SIZE-1, "%s{%d} v%d.%d.%d: ",
> +				  hw_id_names[le16_to_cpu(ip->hw_id)],
> +				  ip->number_instance,
> +				  ip->major, ip->minor,
> +				  ip->revision);
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
> @@ -465,6 +529,19 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  				 */
>  				ip->base_address[k] = le32_to_cpu(ip->base_address[k]);
>  				DRM_DEBUG("\t0x%08x\n", ip->base_address[k]);
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
>  			}
>  
>  			for (hw_ip = 0; hw_ip < MAX_HWIP; hw_ip++) {
> @@ -491,7 +568,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  			ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
>  		}
>  	}
> -
> +	kfree(linebuf);
>  	return 0;
>  }
>  

So, I don't know if this will ultimately make it into the kernel, since as Alex mentioned, sysfs is one datum per file.

Regards,
-- 
Luben

