Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20A2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 21:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58CC2611CB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 21:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 58CC2611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE466E3D6;
	Wed, 20 Oct 2021 21:50:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67D5D6E3D6
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 21:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZFflkFzSWEol2KUGfoCdynP2d8tmkudugrYqbGnNcEqjH05MeMzXVyPZpfhoW8ByAwW05o89d1fElRx2Qj6RVS0youKKHOr/hE7sG65axUTVR7SPqVhnf16wW4FcUurUK1efb/3eZyZdt3Y/jkrooikLWZIJ1VMaR/vNBRiXxOAjke9TtqrlvrI+EoZV9w2p2COsekFtsmRYo9X8qeq5oTc+8q9c3x4g+S77u1G3O82p4zp/WunDO9FdW5uAoDNkRy8LrPLTQQgpHpInBw55bzayNpMnxCZ6sTcU1+aucmjRV5EmfzN3dnhILEC2f2fYQF3wxzA3Ibx8RatKtT1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VehgKItbATpXU8J9Z5PeIrq9/gmh9/j2sF/ZnbxJ20=;
 b=EX29Jsvwjtt/zkK0MOlb6nSUDXxUiz5He0Yw/VEujLjAihUMKFEAbe2CQGmZoBJamDHFcC5C8BsJFc3VwEvHyhoHRDl5d9efk8bCx0NwZBHh9n00okWjvkqY5U+OO4ypJ3shWPVKmKziuxU6FnWjK68ThB5R+zrMAlwGmsOi6AMGYma5AM/q+MGuypDosOd3c/Q8i8Ci4PB80dAQAUa3lv55pbak9rdsY64iT6emwwnQqHw21VP4nL5w1I1dJcxaYZmjFH5HLrkg0QnQYoLmSu/+b8HSOxMJ7BKluWE66BDwL8L2yXYlpY+P21lcfHSEugBqSq+LUKjp5I1MZGaP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VehgKItbATpXU8J9Z5PeIrq9/gmh9/j2sF/ZnbxJ20=;
 b=Ox5Cobv3esvHMG1GOPy2efxgL2PeN68zlASk8Sj3UcxfiwwNCcscoV9bHl/SKFvm60mppg2myT5Ssw/MnEwghVdZnJ4uL7ifOg5+2Eqvc9Ipk4xqO+Spb1ZIZKb8jwyqCY3mFqu4M4DPz7Hr5TDYJejPz8XPxMVkvDFiTNxLsZI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 21:50:30 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4608.019; Wed, 20 Oct 2021
 21:50:30 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu: Warn when bad pages approaches 90%
 threshold
To: amd-gfx@lists.freedesktop.org, "Russell, Kent" <Kent.Russell@amd.com>
References: <20211020163520.1167214-1-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Cc: Luben Tuikov <luben.tuikov@amd.com>, Mukul Joshi <Mukul.Joshi@amd.com>
Message-ID: <50882392-beb7-b7bc-01c9-04945ffdec00@amd.com>
Date: Wed, 20 Oct 2021 17:50:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211020163520.1167214-1-kent.russell@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: LNXP265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::26) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 LNXP265CA0038.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 21:50:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 233807d0-57fe-489f-b39b-08d99413a233
X-MS-TrafficTypeDiagnostic: DM5PR12MB2583:
X-Microsoft-Antispam-PRVS: <DM5PR12MB258380A25D9DFE6F3FA8B62092BE9@DM5PR12MB2583.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+tS3dqaeqnIUcDyrnvaAlzv78cOuYlACow4wwtm9Wik9kgErjVOOd8EAn5OHSmw3YJ2HNd6FRLai2awgFOTrvPqLeFiDSbAW1ZTorhnqTqcizOnp7cA5Z5xC5jfryv/Sy6BmbzwlTsekb0z41cTVmQL0j0s+CTSVDm+KndqRbrcfo1uhWkChiSdeMPq5ZIdjd8UCEdg7LpWpq/ikjBIjF8QvzNAywDZS4DmBRuuUd6o8zjEM+mLzlD1aIEHjiKyMOqYmAFsSuWVmLFXj4qIvX3xs+c3QUrS89Z0EI5HzSwGBIcgElbVouQQ3WmVr0Vh//UAas6cGHXWfjBOLYW2NlHCxyRwcY12okn4B8Rg5q/McH0vOnMHJZeNIEco7gz0kUNLTumRPZjbQD3sTamtaAIXuyWC8sN+FlJ7DkpLGPuCXGwweJTUToXwfPQUUpsKRqOd0i2VjqgvSHUNgOIBBHSNx8ZSqLiKGZxIHG0l48O73zMov2xgJKrFUJGHwRfaiy4r/ehWc5Yh6AkAocZevrStN0kTBnbvV1eU5IOt2dIuZRxVrvxJJeRUiJbMZDIcY19R6QB7Cv+rS0El7ATAX250LDCOdT66U/PwOrzv0kF99jNc584Qx6V3JEEJZmzcdhpXvof3HMmwowCHQ4IpiTmZEqdWF3HpLqxQTKplqh+6i2rQguCm3FpnwAw0yH1O90Ftph2XQ+H3No9gMPaqpy/VWcrdK3wIeopbzB7lk0g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(2616005)(83380400001)(36756003)(956004)(66476007)(4326008)(66556008)(86362001)(31686004)(38100700002)(6666004)(8676002)(6636002)(4001150100001)(316002)(186003)(5660300002)(8936002)(26005)(6862004)(16576012)(54906003)(6486002)(508600001)(53546011)(66946007)(2906002)(37006003)(36916002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STZXZzB1YzlndEx2K21CRW5OUUV5OXN2NE01RWFwN3FHRFNrbVJUcVZkak5v?=
 =?utf-8?B?dnI2Z2VFdWZIaXJJZStNWW8yK3g3MWRHZ0R1aS9lVlUveXdTaHBEM2FGbHE4?=
 =?utf-8?B?TVJNaDZqUW05ZGltbUxCOWhuZVBWSXVlc3NZTGtXNzlCUTYrVFR0VDAyNFdE?=
 =?utf-8?B?MU9BTExFL1RYV3lOcXFNN1h2cVFzcytCUGJMazNZaHVsZS9qcEFCTzJpdytR?=
 =?utf-8?B?a2tTMUMzaWFBMmFDOTlDUW9BY2RjWTVyNW1FT1RUTzhGVS9OWVZhTXhwd2VS?=
 =?utf-8?B?MERDb3hLa0ZDQzExU25TdWF2bTBDMkFTbDZrNHN5QTVjTFpMQ3B2MW1EWFla?=
 =?utf-8?B?S011aTRoZm5uYTJvOWxFeU4wVGRKY1BoeFVuUnJKUU5XRXVhUjVFT2FWOHpa?=
 =?utf-8?B?RUxBM0NpdmloTWJNRDRtY3duZTJLKzQ1dFJSVi92SEs2bGlKeDJsMjNLY0FQ?=
 =?utf-8?B?S3JQQWx1OURmQTR6UnhaMHdKSExNYUpKWUp3TWRWY0cwd3ZDNnpTMkU4TjVM?=
 =?utf-8?B?dTk2bEVWVjFBanNiNEFvM1licTU0RFFpaDZWc1Ftai9LdkllMGREb3ZmdG5J?=
 =?utf-8?B?SmI0cFBiUlZDV0pVU1ZsUkVNYkY2NXVKeUJOYi9oalNYeDBVTUo1Rm9qSmVH?=
 =?utf-8?B?d05GdTRxN1NPUVhKY3RUNkIxZVhUTG9wNXJFdWpQeW5jOUl5d2lMU3V0bUdS?=
 =?utf-8?B?a2p0SU0yOGoxUncrZEJvMy9tOGo1SUpYRm83NE9XTDNReHZMV0V2RmN2Smxs?=
 =?utf-8?B?cmVNTFA1Q3FFbXBGOTA4bXhqNGlRSzgwTHk1TlZsMThYY1M0eVNSbkliOHZl?=
 =?utf-8?B?VTdqTm96YmxISnYrdGRPRnUxRERvRlVBaWJNdnRBN1RNWjhJK3pSVE9MN2Rm?=
 =?utf-8?B?QWxjd2J4cHFVQWtVRG1JeTZvSEV6aTVTSWszVmZqOTVCejcvL25UUkRaaWdD?=
 =?utf-8?B?b1dsWEN1RDdmZjVuM1BzWlhoZ05ZLzcvMEpTODQ0SzRndFZBTDlGell6ZXl4?=
 =?utf-8?B?TUFkQmdnYzV1UFVrcW1sNnUxZFhsNHNkaXlPY2pQRDVMSXIyVENLZGMybyt5?=
 =?utf-8?B?aVpmVU5paWFwS1o4NzZoU2hiZE5HMVVja3EvNU9kUUhPZVk3bWtFNE5hcEdO?=
 =?utf-8?B?aVF5M3B0S2NvVStQNGtsYlNpdGtUTG5Scm5VWVVqZXZJRDZPOEZwdFhMRVZm?=
 =?utf-8?B?WmpOM1FtallYZHM4ai8vMEtPQ1RpOUY0T0ErQ3YwVkE1OWVld3YxSElSVG5E?=
 =?utf-8?B?emk3SXoxZmdTdThCSjZhZ3FpMUFWNloxN2NJaG9ES3FYdWcxcGp2bS9QSnBh?=
 =?utf-8?B?R2lXSEdCR3ZGZisxSlJBUVBXQUN2OFdoVzhnRTd6ZU9XT1FnQXFOS3RCd0dQ?=
 =?utf-8?B?SmxZQVppTG9VK29yQlovSUU0NzQvY1BFK3k4WTBaNVIzQ2N2MStMVU9JYUhr?=
 =?utf-8?B?cGZKQVRvN0Z3bXJ3VWZmbEI2aDNDUzhob2JrTG1UK3EzQVJjVHVHNGZEazNs?=
 =?utf-8?B?ZGZ3REtKa0t6V2FtRkY5Y0pnSVhYWWd5WUVoMFNERDNFR0JYVzhvRTE4S3g0?=
 =?utf-8?B?NXh0dU11dVpUUk5vbHZUdlMvZmdwYVNKcktvQlI1Q24yTWZPRm1McGE0OFBw?=
 =?utf-8?B?M2hOMjF1M3pVS3p5WERzQU93WWdOWjk5cG8vQ1pxYStpS09NR042WnA0cE4w?=
 =?utf-8?B?VTlFU0N3Mjl0WlJyb0pNN0o0TWE2UCtEREI0V3NQcHdhUHNxSFhHQ1pqT2NW?=
 =?utf-8?B?NEc2SDJmQjNYWTN2TStHbnV5bFhYRG41cFl0ajdHbk9udmplOGRXa1l1Tmcw?=
 =?utf-8?B?NzUxVkVkZVdNK3RWbG1ZUGRnczlUTW5ra1E4d3FWdTN0ZzduWDZ6M01qUThy?=
 =?utf-8?B?dnNVOVJ3VFVsQXprR1JPV25IY0NrZDlmbVJKakFOZ2FUandRcFZoVXVyajBQ?=
 =?utf-8?B?a2JtR0tIblg2RHBOOURWa3c4bkxhZzE4MEJ3VDFzclZyZFQ0NjRLMUszUHY1?=
 =?utf-8?B?Slp3T0RDUmdCWmh3QkJ1enR2WE56MW9Sb0pYZkZJSXZSamd0bHFBM3QzUC9v?=
 =?utf-8?B?bkJKdlBvbFlSSFdzR2U2NG1DVk94WXJGQjFKS1Y5azIwbXNqQVpkVWY1Yitk?=
 =?utf-8?B?eHRocnQzaktlL3hybG4yaVVEbFR6QU93ZkZURW95NGZkMHd3ckg2dVptTDVv?=
 =?utf-8?Q?QcsNE1UZB67Qb4PC24sIVQs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233807d0-57fe-489f-b39b-08d99413a233
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 21:50:29.8421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkort6bJdrasshDpsnzLDTRTL4LGXNfPeE5a7/6lV4xUCa2yIsv1uTJa3ln30C1pW4taxk3CXHqTqwfzXMQMSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2583
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

On 2021-10-20 12:35 p.m., Kent Russell wrote:
> Currently dmesg doesn't warn when the number of bad pages approaches the
> threshold for page retirement. WARN when the number of bad pages
> is at 90% or greater for easier checks and planning, instead of waiting
> until the GPU is full of bad pages
>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index f4c05ff4b26c..1ede0f0d6f55 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1071,12 +1071,29 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>   	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
>   
>   	if (hdr->header == RAS_TABLE_HDR_VAL) {
> +		int threshold = 0;

ras->bad_page_cnt_threshold is uint32_t. I'd recommend using the same 
type. Also add an empty line after the declaration to avoid a checkpatch 
warning.


>   		DRM_DEBUG_DRIVER("Found existing EEPROM table with %d records",
>   				 control->ras_num_recs);
>   		res = __verify_ras_table_checksum(control);
>   		if (res)
>   			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
>   				  res);
> +
> +		/* threshold = 0 means that page retirement is disabled, while
> +		 * threshold = -1 means default behaviour
> +		 */
> +		if (amdgpu_bad_page_threshold == -1)
> +			threshold = ras->bad_page_cnt_threshold;
> +		else if (amdgpu_bad_page_threshold > 0)
> +			threshold = amdgpu_bad_page_threshold;
> +
> +		/* Since multiplcation is transitive, a = 9b/10 is the same
> +		 * as 10a = 9b. Use this for our 90% limit to avoid rounding
> +		 */
> +		if (threshold > 0 && ((control->ras_num_recs * 10) >= (threshold * 9)))

Not sure how big these values can get, but you may need to cast to 
(uint64_t) before the multiplications to avoid overflows. Alternatively 
you could use (control->ras_num_recs / 9 >= threshold / 10). It'll 
round, but never overflow.


> +			DRM_WARN("RAS records:%u exceeds 90%% of threshold:%d",

Nitpick: I'd add space after the two colons for readability. The 
threshold should use %u if you make it uint32_t. This can never be negative.

Regards,
   Felix


> +					control->ras_num_recs,
> +					threshold);
>   	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
>   		   amdgpu_bad_page_threshold != 0) {
>   		res = __verify_ras_table_checksum(control);
