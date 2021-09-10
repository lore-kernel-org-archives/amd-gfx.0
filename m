Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA03C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 06:29:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6405C611AD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 06:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6405C611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E406E970;
	Fri, 10 Sep 2021 06:29:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 195106E970
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 06:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBFJy/DuCHnOiy8JUyZecLjYozNJgjNruesXHHEPFnJaemYpMD9kNGCHYDLBXIjKH29vRGB0hTSzOUKN+7x2wPBbyKkGp9LALEn5Cil5Rlk/lr7ggXyV++GduyQFSD8pnSwXM5Z8Y89t53NQyisAH1LyIuGJcqELKBDPZVbBuJWIqbWW81hBJ6j0loXClLTTblzS4xAfRJ2Tz7Or5PFPSo8YFoYMix/AAow802nRFVNYX1m0VOu62o52cWDJ5isCXbrXbPcb9pq/QiZqBs7sfOVZIj881vJ9ag2HzzUFUQPbqmgO2eH8hNCZoZ3vKskTfjg0VB9AH5nh74JdDJrSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=/CWBXB8J/lss5O/jn235EFtbYBu0NPKaNut0VnwmryQ=;
 b=C3JRWhSBlCAi5bfEFdzsgi1ursYXMqcjBSU+6JS5jPal8UZI75BllYhhkGLwa31gDjucFkiSED5djrc/lVX3JTBXFNmZdiF0fnHScYfhezrKSN/oVkCQiPHrRaJ41xONY1hfPaZm+ccNgOENqgcnYrz++++n50WJW1cde05Th+22l29e09XASzGNK9wfH22Ha2U5jCDjTXRI0Rz9GSq0oXSqBD5UT8nkUMEqmGCJ5UHPlfb7jDBfTVamm164Nd8Vk+R1WkKeYHZKupiIeVdJJ/K2CfNlqlt/e8qI3ioU8gP+hpvFjD2avg078GUtiuNGrZRXEbi3eaW4tYBfW4ZFfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CWBXB8J/lss5O/jn235EFtbYBu0NPKaNut0VnwmryQ=;
 b=eoReLGtnEP3/hRtS4hDXK+M7DE/9bLtMQ7QEgKboqAyjrbrb15nmKyWIpfjSxgKpfXiYpAgyl9aYpnSYTGfD3enUYlQ8E/bSGA07GWXx3imQag3WYShIE7u6ecy984HoqGyZMb/19Yp7WyI+lP2Nz7MKbYrtDpAiS+KDS1cScqQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4897.namprd12.prod.outlook.com (2603:10b6:208:17e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 06:29:28 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.015; Fri, 10 Sep 2021
 06:29:27 +0000
Subject: Re: [PATCH 3/4] drm/amdgpu: VCE avoid memory allocation during IB test
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org,
 "Liu, Leo" <Leo.Liu@amd.com>
Cc: alexander.deucher@amd.com
References: <20210910003828.4013-1-xinhui.pan@amd.com>
 <20210910003828.4013-3-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3269aee8-ee86-484b-9a6c-83312e33f58f@amd.com>
Date: Fri, 10 Sep 2021 08:29:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210910003828.4013-3-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR07CA0004.eurprd07.prod.outlook.com
 (2603:10a6:205:1::17) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM4PR07CA0004.eurprd07.prod.outlook.com (2603:10a6:205:1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.8 via Frontend Transport; Fri, 10 Sep 2021 06:29:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 743da3b4-6134-4079-8de7-08d9742456da
X-MS-TrafficTypeDiagnostic: BL0PR12MB4897:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB48975A1F9FD8319B964336FF83D69@BL0PR12MB4897.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hs/5HkQEXKsfFtFP6uvbXlu4JsBQpZ7pw9NOJy5g9XTev3s7zda66nAB7rts0B1S48BhaqUglqi/mJUNscUVQkNJp/GRlWE22QSX91rru4/E05w/Iu3qSoSqJQ/t4zqBCghrseTNBnL4r9aK1SAPtXEDd7GDfEfzUGC7U12ZP+IpqX6cSYbYEa9jiQOohf4v5iD9j5zZlWlXfuUW+yEIZCIGSBetYJRbAeWdmxX+VV6dZPxjdKnXP5FizPvDDDc7ebeMmGD+9dAvZ7lWOnXMZVG6VG6o1Q8y7e32FnndfCBkfsAilcgH6m3AXz47egsiHEAKPZS72skNH3CtavF+zXphCJLwU2W5HBw7OfV2Qtl1bJ1uNG0oBNyXdsrV1Pgkugg1KM2nFmapughQY30+5Kpc88U39NbZuxxZGp7XRUmVpbLfKBKam2EDIJo+Hr39Bc9B0qSVvWJTXwWJRUYPEKtniRu6A4rd/CrB7AppUMxrMP+n/0bnjIg+atN4jX8qMM59Gvja0tVFO4s3VYiz8h216pefBtKBHULazh/lDovXLX1/ppvEMIs6lEFsvN4F6H8MMJUfb6/1Gbk6VzbD04WMC7Q6HYmjTwcwQubau5d3Cujkn4EZkZfE2Um0c5v1LeRoenAe20ahLhADLHrZtfY2gP8B5AeXjE7ZuYE5omosjHaXAxXH6Hdi5HfRCz5mbeXfDWgzSazmSfctpS2Pi509tI6lnsRqyCjUE9o9P0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(8936002)(4326008)(186003)(38100700002)(316002)(66476007)(16576012)(6666004)(66946007)(6636002)(2906002)(8676002)(110136005)(66556008)(36756003)(83380400001)(2616005)(86362001)(6486002)(478600001)(26005)(5660300002)(956004)(31686004)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K05Fb05TOTlpQVdFSnJqN2RkSjFTS3Nxell4K2FLU1lMU3FSOVd5V3ZtOWYv?=
 =?utf-8?B?ZStrVU9hYnA4WmQxZW5iL01RUnR3czkyM1FKbEt6MzFsV0ZPb0VlKzVjMFcx?=
 =?utf-8?B?eE0vSllUZzhlOHZJem1mbWNUdExXQjUvdkJYR1cxNHc3bDVtTytRNW5xb2ZW?=
 =?utf-8?B?c3NxWDdOM3hEc3FkMjEzUkNjN0xVODlEcU5kc05NMDFvMGVFRTI0Ullxamhn?=
 =?utf-8?B?UnZVYitCeDcxMnExeWFLYzBpczJGSGJ4eWxZWnZyeTlOWDN0RmRoUGtpZUZH?=
 =?utf-8?B?WGg2Mi85MVBNdGxVM2Zla051Ny9ubEJ1cWdKMDU0OEhEaENtZDdNZzdxcGtp?=
 =?utf-8?B?VFA3TW1PNTlML0t6V2lsK2FtbTEvN0xzS0QwdzlTREV4clg1T0xFZHJHdnlz?=
 =?utf-8?B?azkwVEwrR1ZoVzNKOE55aTg4L1Ezd3RHaUJGOEJjd25HM05vRnVRUGkyK2E1?=
 =?utf-8?B?SC9ieGMrYU82SmFqdU91TjBDQ0s1bkZRdSthOUFzSXppQXk3b1VHMUxjU0pM?=
 =?utf-8?B?Tmg4aVF3V2phL2dLZWt0Y1I2UE9oZVlUTldCUzZweFZ4Y0wxcktMbTNMeTVP?=
 =?utf-8?B?dzNkV0NQTFRVTHVocHBaVHdaWXRZUjVjSndtV1RUUkZvbXYwNFl1ZS9ZMG93?=
 =?utf-8?B?NjdwRjZYOHhPaTd5aGJnSkgrdmNQc2JNSXYzTjNpdlFPTTZnZVJPRmlLOGl3?=
 =?utf-8?B?SmdXVWFHSnF0dUVuZG9FSHpmcXZiT2VGYTJuenZ5REg0RTJWdFNrcDRScEJD?=
 =?utf-8?B?S2t4blZkZFVCZGdSVkpReG4vQXdiNnNqT2YwMjdRQ01jcnAydFFhdjErbm0y?=
 =?utf-8?B?N2FDNjJuV3V5YXRkT1ErMTZLYlREdHduMVY5MkVnSEtXS21nbXlpTXlJb2Fs?=
 =?utf-8?B?eHdESjU3VkZUaml6S2FQdS9qRjN5STQvN05KQ3Y1RjllQTViOHJmM0V0TkZh?=
 =?utf-8?B?UlJkU1R1OWVhRG1iS0x0Mm9mZld3TW5sOGVuSXovcUVKR1NkZ2dmLy9zWUJK?=
 =?utf-8?B?MENBR2ZHUzlLaG0zM0tMbVZhbkExSjllMll4Vy9GOHNGeWcvT2laVWVKTkhj?=
 =?utf-8?B?MGovSStQT2JEWG5nY04rK0owM0ROY1I1TUUxRmVJcXJkeCt6YmF6S0xMdlhV?=
 =?utf-8?B?T3pWQWRLa2c0TDk0Z0VobkFiR0NWcEx4TFlhMGxwQWJZYllJR281dHB0dFFF?=
 =?utf-8?B?clkydGpBa2ZIQmdqdFRKM25rQWtMV0xLUWVwVHdIbTVEVklhS0E4a0xoRjUx?=
 =?utf-8?B?YS8xRHlIQ1FuSkdDbXgzbW9lbDRJNS9nWUdJSTErdGttWElqN29CUzkwK3A4?=
 =?utf-8?B?S2xPKzBTWTFnN0l6VmtjakdkNUxHaDJHQzB5VU0rV1RuYzV1VlhIeVFVS2NZ?=
 =?utf-8?B?YU80cEl5RkZZREhwcmpvR05teE91WEx4K2M0VFNtaVdiN3dvQzhyTG9acUdK?=
 =?utf-8?B?RXh4ZithYTZadk11TE5EdUdLdTltSWJGWFZNeXhrUXRjZDBmeGxBZlVBdUp1?=
 =?utf-8?B?bFBYZnMwZnVPT1pQQVQzVGNXUU9FZDNvUXhXUmtMVWNlemJRNkNxZy9hb0xu?=
 =?utf-8?B?M1ltT1lSNWRKSzNSVkdXbHlpTk9Id3JKeTNFT000VWhJM1c4aEhjdVpFc1Iz?=
 =?utf-8?B?UFhzRGUzSlFtUVczb3FscVdmU2NyMndQWDdoNitjUld5RWVYcm1CZ3Q0aHlW?=
 =?utf-8?B?QjhEMGMzaktnRTRQRzFMUnFtSzZQMlpEMTZQUlB5eFVFZWwvcFFHekljUnJs?=
 =?utf-8?Q?E6ZdAz5w8bGkc1JNeKLuthTTSHMJSu7x/UI6Dy+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743da3b4-6134-4079-8de7-08d9742456da
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 06:29:27.7112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HR/04YdcS0H05olGz/SzuqcuqSurPy6G80KsR5+3pv+sRai7SZj1pWzLqOoe8XV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4897
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

Am 10.09.21 um 02:38 schrieb xinhui pan:
> alloc extra msg from direct IB pool.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 18 +++---------------
>   1 file changed, 3 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index e9fdf49d69e8..45d98694db18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -82,7 +82,6 @@ MODULE_FIRMWARE(FIRMWARE_VEGA20);
>   
>   static void amdgpu_vce_idle_work_handler(struct work_struct *work);
>   static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -				     struct amdgpu_bo *bo,
>   				     struct dma_fence **fence);
>   static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>   				      bool direct, struct dma_fence **fence);
> @@ -441,7 +440,6 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
>    * Open up a stream for HW test
>    */
>   static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -				     struct amdgpu_bo *bo,
>   				     struct dma_fence **fence)
>   {
>   	const unsigned ib_size_dw = 1024;
> @@ -451,14 +449,13 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>   	uint64_t addr;
>   	int i, r;
>   
> -	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
> +	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4 + PAGE_SIZE,

Please use AMDGPU_PAGE_SIZE since that here is not really related to the 
CPU page size.

>   				     AMDGPU_IB_POOL_DIRECT, &job);
>   	if (r)
>   		return r;
>   
>   	ib = &job->ibs[0];
> -
> -	addr = amdgpu_bo_gpu_offset(bo);
> +	addr = ib->gpu_addr + ib_size_dw * 4;

That here needs to be more aligned I think.

For UVD that used to be 256bytes, but no idea what VCE requires. Leo do 
you of hand know?

Thanks,
Christian.

>   
>   	/* stitch together an VCE create msg */
>   	ib->length_dw = 0;
> @@ -1134,20 +1131,13 @@ int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)
>   int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo = NULL;
>   	long r;
>   
>   	/* skip vce ring1/2 ib test for now, since it's not reliable */
>   	if (ring != &ring->adev->vce.ring[0])
>   		return 0;
>   
> -	r = amdgpu_bo_create_reserved(ring->adev, 512, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &bo, NULL, NULL);
> -	if (r)
> -		return r;
> -
> -	r = amdgpu_vce_get_create_msg(ring, 1, bo, NULL);
> +	r = amdgpu_vce_get_create_msg(ring, 1, NULL);
>   	if (r)
>   		goto error;
>   
> @@ -1163,8 +1153,6 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   
>   error:
>   	dma_fence_put(fence);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_free_kernel(&bo, NULL, NULL);
>   	return r;
>   }
>   

