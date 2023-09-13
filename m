Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD42EE01FD
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 17:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B7010E4D0;
	Wed, 13 Sep 2023 17:44:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC8310E4D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 17:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTrVtCU6phqP3/vlMR91b6eG4fh7dabQdwVhdEd5eyrodftNTEJaKxJW0i+zE4ko/lomkptfdoDSDyGIR9ElwqzbQ6W9Gj4Ms5odKhAZyiust4W3L4wMrOP4BVAFII2bAEvCAQ6ACFrX8DB2SlUPbYWvDUuWGPaYabwPkDFcce1hPDwPEWnniFzDrRE1b65MKB/IRkGrgqp9O9FYlt6yBkXM8zOEmhZf+Vg99FMGS5U0TI5fIvR+qJT/07EOGnHwG18Nv74bVrSS96vWoAnXRrSJUzQSAKKOjLTE/UMvHwfLDdAQkeri7pBpzFq7DnbyGMeQZhX3okC+Fl1H9OZZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzrt8OAc0LVABrZDiKdhSlECopz1FjRPgnx7BI1MYJk=;
 b=R60GVwDeYAuqBiNE6WZ0CpU/rGZgFDCLuZqVLIpNDi3+JARkb7FlMZgngTlNlf4kKYMsatyNKLu/raoS1pj4zj+fCgidEvvC38tipeZcaKQGoMJtP4C8j68HDJ0/Q7exmrEarmNe5xUFjI2tDrsMq+oTQ4vrVyCfRp5YQIJkvplyZjUTI69wrFcJIizGOHnDdkHx3NO5RZbCzeDnrEGJRFVhbGLugPw87xDODJ7qr2rPm4xsVEUm1izpaOJnKSVIK6S1kdqc8welH22g8mvP9em/AwxQ6+zGI96E5C50jrT3pKd9MhvO1w5KCihhY22DiMbdlOR5wulrKl8YsUq2Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzrt8OAc0LVABrZDiKdhSlECopz1FjRPgnx7BI1MYJk=;
 b=44fkdQ+ufLpl9yEZZ6KHF5VcIAWuxGo5uXJg25YeqeP9YsNYwxA5LRg94iPl5XNLsinL6/CS5MpJ99K1yj+OoK+SjqKLCk63N3GO5lQEFVRgK+iWsRSaxkCZ/6IGLxXxZHwTm2dzjax0/FVFEAGZFuIVKR8AWB2qk8pxDgNYrGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 13 Sep
 2023 17:44:12 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f%3]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 17:44:11 +0000
Message-ID: <70e76514-726b-4652-b2d1-3938ca30f29a@amd.com>
Date: Wed, 13 Sep 2023 13:44:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/amd: Enable seamless boot by default on newer
 ASICs
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230913171455.153412-1-mario.limonciello@amd.com>
 <20230913171455.153412-5-mario.limonciello@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230913171455.153412-5-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::17)
 To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b859bc-5792-42f0-a9a3-08dbb48109ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NCZhY5JrBbvDOWpkIwS+M3oVz8jRzqco+wK3aNRTA2goQ8u6mFBn288j3j95ldQorJoLdepcJ6e++iHusfQXad5vQCH+QxPDc2xdk1+hnCSGSvqux7EKyVCKFzHHAHbxoxVgda8NTM7nLHGEHWNtm4z7V8vZ62uelK3IpBQDCdmdElMxxNyEUiLCkQfxeP3TzGEa95UL0VLBXU0heXxfEEZ2/ahR7wpuIZNhxBvCTzyZx0JISz3JoaUO8BSKR4LsQZnFca9A7kg3alFmrejkyBCohZ/pLLdv+xxJn2JIPl6l4ix7+JX8+3PeQMRqiGRDAeuSFrJAYExmCFfoo11Qpr8xI4ycyyW2lDg6QmNNd5FQp2YOfaqK0kfBNc4z0xXwC17j7XLtxZJHtbvaC+e6FTHxOIY7FiBMGRhLlvpgCeL7eKgNmA6jv8eXESdjXZDc9ryZbGOojg/y7PjLmd4RM2FyPblvz2HiTNMqHfoRaUb2cIri21LZGb9FhPf62ffZx0Gh0p80sQVjTgIb6EXQmAxxTqPRsCEK7WW1i7BdNPgutRAyEf71PaEQ0hmSuMs8hJKnDmHyZLsZTaSFpqhkm9DX3AkA+FNXQ6vrNpqudwY0NdbermuLAhvgehIJqnegN8aE3TWfZn8THlUK+e4aKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(39860400002)(366004)(346002)(1800799009)(186009)(451199024)(5660300002)(31686004)(53546011)(6666004)(6486002)(6506007)(31696002)(86362001)(36756003)(38100700002)(6512007)(26005)(2616005)(2906002)(41300700001)(83380400001)(478600001)(8676002)(8936002)(4326008)(44832011)(66476007)(316002)(66946007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWxjQlZUaTM4eUdteVdtV1RmS05jVmlxZkQrekpOTWJ3QUxEQkhvSU9jTlZ0?=
 =?utf-8?B?dlVrMS9iSUk4TVIvUlVFY1pxUHE3dmEwZ2hVUXRHNEFhUmR2OS9jQmlFTklV?=
 =?utf-8?B?SlRKckc0WDRHY3hOZysrZ1NRRWlkbmZJZG4vL0RBU0wzNldXbXlzcHJ0eXFw?=
 =?utf-8?B?cWNaNTNwNDlHc3Y4ZVUvd2lYbHEwZXN3ZDd0N2hxbi9vcEdyWmE2VlNWM2My?=
 =?utf-8?B?YkxKZHBaVTRZYnpDUDB3WFh4bUg0TlNrRkRwb0s3OHQrT3gvUW1XS2M2Tndo?=
 =?utf-8?B?dW9NN2E5N2k2QVFYSUpPcFRWYXJ2UkxwQk5YNnJOZ3BpSnJiZHFCSXFQSGR6?=
 =?utf-8?B?NytacUw1eXB5S2d1VEI0Z0dOTy9mWERLME8wTzRIVDhhMmJzNkRiODhrTGJ2?=
 =?utf-8?B?ZVBDZWIwT2cyN3NKL3J6elBJdnVzM1ZtOWRFQzM5Y0hOY2dCQmJmOVhlNzF2?=
 =?utf-8?B?M2xzY0N5NTRsNEhvODk0Wmx1S2R0T3duT0pFa1ZSbUQwckhHLzV0NWhJMUVM?=
 =?utf-8?B?QlFZMXhUdWw2RXNiZDkvb0JPSGdRaFZQRE1sSjM5K0IxeGsydzNhcitxOGJa?=
 =?utf-8?B?cnhlUDFOZzgrOGErT1dleGM0R2YrUHcyeXNTQklzMytQYUllMzFwL3JRamJm?=
 =?utf-8?B?NHA5aDgrSUZNTVRhckZ6dm5SNWx3WmRsVGRZUC9xRk9sakNtUjk0aTNUUER5?=
 =?utf-8?B?M3p5MGhSNEJxY09jNWVyUTlKZFl3bGJOUjN5NXF0NFFYT0J6QW9iSHVDZlI5?=
 =?utf-8?B?SlpzM09LOUNIYm9XV2tocUU5dXh5MGkyT2IrUnZwK2tMVmpJZ2xoM1RXNXdx?=
 =?utf-8?B?TW41RjVueS9CUFZXQndweDR6K0l4R09xVnQyRUk0N3gvbUhkeFNrSU1XanZR?=
 =?utf-8?B?STd3L1diQ2pDNFZEdEJJeDJIU2JIeUZPMEpsNmQ5VUNYOTZHYnRuTXpHa2t5?=
 =?utf-8?B?ZHIrWFE4TE1BNUhDUEliekZoQkgrL2M1WjZKaUpwMFczNVlmS2ZMOGIrTFpM?=
 =?utf-8?B?NmhmQmFkWXcyVWdIcDV1RzBKdU5LenUzRVVnNHdpcExUYXZiakJmRjRUdnBm?=
 =?utf-8?B?dzBUM0dKUFFCN1JqTGVmS2F6bXdGZzJlYWdFM2tUdXJTRmUvUElOV0lHaWxX?=
 =?utf-8?B?T3JpSUxwTlBCREVaZC8xeHIrbTVFT2FBOSs0aDdRTzE1blNzcHBmZnJTa3pI?=
 =?utf-8?B?V3NFU25qRG1GbUNoOXh3S1N5VWVobnF2Y0FRbzhqNk8razRtcm1GTEttMDFU?=
 =?utf-8?B?QkNzNXlqM0x0ZHViQVlhTzJHOUsyUDRtR0RJV2FhMnFqTjlERS93cUJKNEpi?=
 =?utf-8?B?UGcrOVp6SnNIQVZsWTdkSEFQQVlLZFdRdjF5Zm5PYklxd1FZNUZUb3ArekRO?=
 =?utf-8?B?RVJ6cWxSdDZDTllDM3g4V0E3TGZselNNcG9ITEt5YklGM0VPSXV3dlVWR0V0?=
 =?utf-8?B?VmF2VHpoRUJHRlVoMFNjemhsNG5TUEQ2ckxra1N6bmpCTEFiY1RkZURKdGtS?=
 =?utf-8?B?anFmaG9YUWdYYnpXMU90cjdmL2lCcXhoRU5nMUNSdlVkcmtYbTRlaU96eGE1?=
 =?utf-8?B?M09YY21aSzYzK0R3Tk9JQUVOelliN3FHMkQrMG13NXMzUGVCT2lzbndPUk5V?=
 =?utf-8?B?U3JFYzlDbHpRT2FXRmw1Zm9mdnY2d0J2RU5pNWl5OXFWdzU5aTgrT3VWK01w?=
 =?utf-8?B?OXk2WlhvdkR4MFZidmdZRjVqV0VjbzVmbWN0YVZDUUxuWTJhQ3hRMEk4NnRu?=
 =?utf-8?B?QnhHK0ZUVm55Wnl1K3lUdGgzb1FaNEpjVGx2dmluR1Q5K2tmdG53ZE0yVEtW?=
 =?utf-8?B?Z1pJbXZjamRaQlJ3VU1SWHpNVDVVVU1mNUtTdTJ4RWhPK0l1UVoxVitDZUlH?=
 =?utf-8?B?YW1yUWlXUzVDTWZnQW0rTTQyZ3NFVTBibGRweEVjVUcycEw0VWhTK3NWSUtw?=
 =?utf-8?B?WXU5WWZxSEJjRlFBbmdCVWt1SFIyOEE2dGEwVHhucFYvWWtjSjVveDBMK0Rl?=
 =?utf-8?B?VUFBWVdRZGVWVTJjN1VlYU5kSUh2MmZ2end1WlQ5cWxwZ2UreUg1UmE0YjBs?=
 =?utf-8?B?WDJnMFVIZVNSUmZhanRGRVBNN25kaHkvdHR2Q1VoRi85TWc2NW80bVRxdmIy?=
 =?utf-8?Q?pgWWs340TmNqL9OE6k6Zt4GqE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b859bc-5792-42f0-a9a3-08dbb48109ff
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 17:44:11.8502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vYWZUuOcTg2LQst0pbVQyu4s5ItqtORSDkeqLQ4fBFfd1o/wYMBSTYv6yt558Z1atDDwFF4rQqH/k3XlGO+RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2023-09-13 13:14, Mario Limonciello wrote:
> Seamless boot can technically be supported as far back as DCN1
> but to avoid regressions on older hardware, enable it for DCN3 and
> later.
> 
> If users report using the module parameter that it works on older
> ASICs as well, this can be adjusted.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2116e016178a..38fafed31a1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1361,9 +1361,9 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>   /*
>    * Check whether seamless boot is supported.
>    *
> - * So far we only support seamless boot on select ASICs.
> - * If everything goes well, we may consider expanding
> - * seamless boot to other ASICs.
> + * So far we only support seamless boot on DCE 3.0 or later.
> + * If users report that it works on older ASICS as well, we may
> + * loosen this.
>    */
>   bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
>   {
> @@ -1383,14 +1383,7 @@ bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)
>   	if (adev->mman.keep_stolen_vga_memory)
>   		return false;
>   
> -	switch (adev->ip_versions[DCE_HWIP][0]) {
> -	case IP_VERSION(3, 0, 1):
> -		return true;
> -	default:
> -		break;
> -	}
> -
> -	return false;
> +	return adev->ip_versions[DCE_HWIP][0] > IP_VERSION(3, 0, 0);
>   }
>   
>   /*
