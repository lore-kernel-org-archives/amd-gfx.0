Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5223C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 07:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B80F10E746;
	Thu, 16 May 2024 07:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n9bzMq7J";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB2010E82A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 07:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mX8Ker61XUEgA4cQBcMkiND9QLr3MboPQEhPrGVQQ6CNr0vhy90bU86EtyJD3R+LtQL6IBdxoK1GpsAPIty/BdOb37d7Zy6YbP54DAbBonrDda9BaPNPwMZYBlf1UMgaya5Oml58SNSnnxJjiENxo2uul/6jjOuILTFdkU5K4BZa1evEO8aE5y38i1Jn55Qx+K+L7j0Gefffl7s2iSFs1BPytseJL9hJz7plGQPxWoBage94P3zg2JqvvvWRGIr/RuHHhfWB6g+rnOydtmGQ+Pi38wXz9jjaqAR/dkfSLWeUhQEE7CmsbnNeU0osDEQLWCmbLhGpELT9NP/7Fm89SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMM8+yCY1ztHPcX+a/WBiA/JOcSSIPeDqxoID8puMDc=;
 b=P4fISGWIcxMoN724hAZSq4t5+cpXY/Rjb7bKm9G6Aq5EJ9Bt5qVvzaaJrZRRWqiTLZiUvFykFpjE5tVZjxN/+4osA5sSmkT5Q5CwBIPQU6kbRE6/XFTbzfsSbXfMfTzpTypKRby3sB1P8hbIBd6fUjrF3ziW0QaESlnEt8cq5EFzX2EXxVbxCmJFs8uVXGi3x4on6guRF0f/08ez4kTge1qya0RfYC21cKLRyhVdMOwcThlrQnBRMfix/mWCEEbwqds92LrFYboVSJGhj+/YFhAHNmc/Jg2HQfGYQhgDoVXXCHZ8CL/DKX9fVO813c7onRVVASxhOBF4687CWVjURg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMM8+yCY1ztHPcX+a/WBiA/JOcSSIPeDqxoID8puMDc=;
 b=n9bzMq7J5cy/8rNjPpShKV3OY3yVMQuK0hUcn43mYOSfSczDY5efUPeTrl/6W/Zsd3cCwrKxZwUIdQdyPrvB3vTBV3iDy1e6gLq80nNDGncJu1jcBtGbOhz/1SiLc57kdL7TqVD+x1wTonG2SOqHs1o1qUCvkWc0LtOX5EWT8pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by SJ2PR12MB8956.namprd12.prod.outlook.com (2603:10b6:a03:53a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 07:34:21 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%4]) with mapi id 15.20.7544.056; Thu, 16 May 2024
 07:34:21 +0000
Message-ID: <2b14d07d-d589-4b38-8fc7-ae2d5c7a5e9c@amd.com>
Date: Thu, 16 May 2024 15:34:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/display: Update kdoc for
 'optc35_set_odm_combine'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>
References: <20240515152341.750360-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240515152341.750360-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|SJ2PR12MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0802ea-7232-4011-0e59-08dc757a99ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1l3MTJTMS9lWE1rSHhIUUNHU2NRTjRoZWQrdVY1WWNxc2NjOERWTkhhNlV1?=
 =?utf-8?B?NGo0Q2ZLUlB2c21QbHp4Y3JWK1BUTlhxVU5mb2hBVVR2a0c2TjdkbVRoRDR0?=
 =?utf-8?B?N09VNEpISWlzZkl2Mm9IaFZTRVJLVkg0NWRNanhGTTg5YnM2V1dmcUZnQU04?=
 =?utf-8?B?aU4xOExtT3hoRk5nN0lWQUFIWS9ieVpvZUdySUR6WHdxNklJNFp1Mm5HYUtL?=
 =?utf-8?B?ekFvMkNYOVBtZ3d2dE5aM3F5MHhyWTZ0RjY4cVdOVXY4d1JPSnE2SFljZVBy?=
 =?utf-8?B?VEU0ZkF2RFNmZVloWkpOWHJPYkdRSGpLZldwVGZIUlpuQmgrbXdhdWRYWFNp?=
 =?utf-8?B?WFRNamQ4SlVRMVN5THd5d2xxSHRFcjRNSTlrN0p2eHA0MFpZSjAxNUJ1MWpm?=
 =?utf-8?B?SUxRMjlSRDhlSlYrdnlkbUpCdENIQU5Vd3FRcEhKMEZ0WHB1NytadVRTd1VM?=
 =?utf-8?B?bktxeHlvREE5dmJMd0N1UUxwVmh1SHlGVUdxaE82OFVoblA3R3ZMdW16M3pY?=
 =?utf-8?B?UmRQaitLaUthU0tTR3U2cHFqZVlLN3FoTTRHL0ZxQVhtNzk5c2JxZDBBckdH?=
 =?utf-8?B?VnlOKzl6KzY4b2tMSU1zeDVsek9KcFBHUjYwc1ZwVGIwWnBkQjZPRExVdmo2?=
 =?utf-8?B?TkZwbnZ6bThRMnk2TkNDT1dPcFZmWC81eUJxNHVVcUxiMW9RUkZ3OTBYckty?=
 =?utf-8?B?M3h3S3FHOEU1TGFTMXhuZ3RHcEhsamdzTVBJekc3NUFmS1pUbmt2UnlWa1cv?=
 =?utf-8?B?NlpaeUFieURQTThXNWY2NFdGMkxOeTFTb2t5MWtwd0NXWFQzUllmNXFzMVZL?=
 =?utf-8?B?UytodGFmRnpVWWo0aWVXNm9UcTN3T2d2UHpJTWFlejJXZ0JReUgyQjdFSXhQ?=
 =?utf-8?B?eWUwOGN1ckl1cGVVZWhZMnlvNWFUeUQ1cGFEY3B4QWlSNWlVbmdSOEhyQWUw?=
 =?utf-8?B?OHpNbU0vZUtVaW5ONzZMN2N2OVYvVlhvcEg1OE9FZmRUZU1mc1JEZWVMS1RG?=
 =?utf-8?B?cXVvWnRsMlBCam5mTXhZcFBPWDhNSHRFZlhGYmxjY1d5SzRoc1NaMk5kZE9h?=
 =?utf-8?B?emRUYWxtWDlvWVl3ejl1bnNSVnA5d3VCM0lJSGpkUkoxUTA2OW1GMGpJMFBr?=
 =?utf-8?B?SzZRUHpxRUh4a21VU0lzcmptWWVtVXFVTTYzdjY3V2oyNFpHU3hKN052QWN5?=
 =?utf-8?B?ZW52MlFvUWF3eTZwcVN2K0I5K1YyWEgvK0Z5NmVpNlZweStoS0lUR2lIblRi?=
 =?utf-8?B?VndvOVFLbDRnUHJETXZ3YXk5Ny8yMTA0WWdXOXRsY2JGYndYQkxFR2FvOFIx?=
 =?utf-8?B?S2NPYzY0WGlhQ256UStYdU9DTWE0eUd4bkVpUjk5b2dxYVd1ZGpTVEVuM3p0?=
 =?utf-8?B?ZGsxOUI4WDZBWUdKSjJSYXJ4aEpoRG85ZXg2ZnNZRTlMRnVTY21vTFg1S1VP?=
 =?utf-8?B?alJHcC9JaEV5ZDVTa1hLWGFDam9lY2VucHd1Z2EwbGJoakVTcXZCOStZMTdl?=
 =?utf-8?B?ay9HUzViNWdVTXRyUkVReEJIR3VaSVF3MzFzWGdsT0x0RS9lWUlBVHQxZFZJ?=
 =?utf-8?B?RkM4NCtZdjI2Mms2V0Z4cWlSWmRPL1o5d3VZQXFBeFBWZkRPZVNxWjlueVZn?=
 =?utf-8?B?eStPdmpSTEl5TDZHVmJSNFBpNVVqQ2doZDIwb3gzL05IdHV5amtpaXhsOFhC?=
 =?utf-8?B?OUU2anBaVk01Lzd1MW1lN1dNaTFBd2gzRnNmNi9qazFLWUhsbnVBS1JnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkZoY0NKMTF5YVJ2dkhrQkNjV2hRSExsTndxNG9xeWM5S2l6ZlIrWThBUGFl?=
 =?utf-8?B?Q1lObHVOZlRraFRoYnNNUGxYaE9QQzR1ZUl1OEYvODFleE43c2VadUdGUUF3?=
 =?utf-8?B?UHIyM3ZvY0ZrcWZISWl0VkZndy9MZEJqMzNNNmtpODJSTCs4dC9RUGovbTlL?=
 =?utf-8?B?bVpUaE9LRWdqTDQ0aXBjdTgvdk5PR2RycWlheDVDRVl1MkkrL1hQVFhiL2E3?=
 =?utf-8?B?RWdJVExGOENsZEJxV0c4Q2EwUFp5Vyt1RUxnNlA0ZGk0cVNmcEFYNE5EMGo2?=
 =?utf-8?B?dEZhbStCYmw2Q0habkt4Q29UQ09KYWg3bUJLMjFnNWlBR085bkMvUkoyOUFj?=
 =?utf-8?B?SXFobVJEWFg2UjRXd2pzcUhJWVdpNS9GSUtQSGxhb3NiRHVJU1hodGoyVVFL?=
 =?utf-8?B?UWh4eHkzWFlXNGt3OXUyZ3VrLzdVbjZVYVlYTTNFN1NsT3VIbkt0WWJxdklF?=
 =?utf-8?B?a3p5bFlTcjA3blNtSkF3Y2NXYU4zWGN4aG1rMmluVWhqWVNKYk56eWVTOFcv?=
 =?utf-8?B?YTJoOElzM2VKWmE4TWVxRndxbUI5c3hHM1NHbkZJRXNGdnRjMXk1dXNUZGVE?=
 =?utf-8?B?MkdtUG56UTNybzV2ek8rMzlpZUpsUDlibm5KMHhWVVNMaHVsZDNsZThwWlgr?=
 =?utf-8?B?WDN4L0lvL3JVNFhTNklYekFkZXFOV2JDNHdzbExiZlBtZk9CbWNYalF5MTNK?=
 =?utf-8?B?dytKN0V3OVNDV2tyZUZ1OWowZnR0M0RBRkRrYmt4MHQ5d096eVJBdHVGYVlu?=
 =?utf-8?B?R3hiNE1aTExGc0xqVWdaQVRoUjlLWFRFbk9mSjRISzNDVmR5Mmllc21Wc2Ja?=
 =?utf-8?B?TmVCcVZmRDN1TnZwRm5MeXZCZUlqOEpwNEY1UkFTR1VXeTQ1YVhuSkhCQjh4?=
 =?utf-8?B?V2dtZWMvbDBkZGN6NHVrTWpRUlBPc2l6MnhGTXRiaUpCVy9MNkZqcmxYejIx?=
 =?utf-8?B?aVh1U3BCM2V5VDI1MWw5NlJjSHpyVzFVcVpYY3gxTDdwZ1Nlc1paakVuYVNa?=
 =?utf-8?B?djN1OWFBRStIdDNyTXU3M2VkWm41bU9KVkM4VUtrNmhpcVM3RlVtMXh3eGVa?=
 =?utf-8?B?RHJORzRzMWNrT0d5U0VyU2ZzZTFYek9SSFVkL1hkb2krR28zamtCYmNGOENv?=
 =?utf-8?B?cFhiZ0t4bGg5SEVaT1BhMjllbHIxWnFPZldnRlZKT3k2YS9yaVpSS3NIRjda?=
 =?utf-8?B?Y00rQXJUa0NtKzVtbWZtUkNvWTRjWFA5aG5meUdBYUxBblQwVU9wMWlDYWdP?=
 =?utf-8?B?TWhBRlZBaFpnT011REIrM0RNTEJhaU85NGUxKzZGSHhIbDBGRUs3K3UzaS9o?=
 =?utf-8?B?ZmFUcldJTUMzVWJGNWIyQWd5Y2xZWFAzT0cwMXFzeXpKdCtqbHdob3BIT1dh?=
 =?utf-8?B?Uzk2aFRTNzhBVWhMSXQ4L1ptY3Z0NExXWmhoMjNTNXp2ZlJyS2FEZWQ5c013?=
 =?utf-8?B?OG9lN25mYkZuRUdNQXRNY3lEa0FlUzkvTDlheVJCR0JzMjFHN2RabW5ZQUlT?=
 =?utf-8?B?R3ZxWjVnOG5VcVlFSFl6SWpiNXllaXNpeWxxWWRIUS82djNTSzRMb3pBcmV5?=
 =?utf-8?B?Ni9WRlJkMlJRYVBrOTVSckRrMTY3SzZreEJzWEVUNFF4VVdIcUtMdU9Gek5u?=
 =?utf-8?B?MzJZcitnNUtiSWtSVWxqODJtVXlOb2NDd3hsbHJEMm45cWlSemQ4VGRkb2x1?=
 =?utf-8?B?UHpoSUl6Y0NueEwwM1JrTDVicER6OEVXeU0rTGNKN2l0VDQyUCtrOTc0d1U5?=
 =?utf-8?B?MFZrWTB6WjE5WkkxYzRKNmRFZFZLR25pMHJDUW1iL1gybHFhZndzL3Y0azNs?=
 =?utf-8?B?UXlOQ1hzYlJSUDZKTUN6V1BZeWtIVVNaRnZRMnZ3TUZIMkVPZGgvWFFVam1P?=
 =?utf-8?B?WnV5d0prNm5uZ0tGdFFucHc3d2FGdW1COW9mNmJhMS8zUXh3Q0N2WHU1N3F3?=
 =?utf-8?B?bG80cXU5L1BQeDhOV0tYT1FXaE5pbWo1WFdvZ1Jja3Q5b05BNVBad0x6K2hX?=
 =?utf-8?B?SVpWNEQ1Q3BxV3VNSVdTNTRzZFV5WFVEUkRSeHdxSGlLV2VON0dYVEhQU1VS?=
 =?utf-8?B?SDZKNmk2c0dzM2Jsc0kyRU9udXNQUW9ESmdqV3FvK2NOVlVCTEJsY2pXN01Q?=
 =?utf-8?Q?oMnhRPxpXsVr/+IRkKFWS9Sjj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0802ea-7232-4011-0e59-08dc757a99ca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 07:34:21.3880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzGzU0n05SbZ2gOGEPlYXe0alPlC10pjLo9AXHYZoQ3nsK6DnbUZSVy4YMEZZFxEEyQ9cx9AYb7RL5TRlKPsBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8956
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 5/15/2024 11:23 PM, Srinivasan Shanmugam wrote:
> The parameters segment_width and last_segment_width are used to control
> the configuration of the Output Plane Processor (OPP), specifically the
> width of each segment that the display is divided into and the width of
> the last segment
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/../display/dc/optc/dcn35/dcn35_optc.c:59: warning: Function parameter or struct member 'segment_width' not described in 'optc35_set_odm_combine'
> drivers/gpu/drm/amd/amdgpu/../display/dc/optc/dcn35/dcn35_optc.c:59: warning: Function parameter or struct member 'last_segment_width' not described in 'optc35_set_odm_combine'
> drivers/gpu/drm/amd/amdgpu/../display/dc/optc/dcn35/dcn35_optc.c:59: warning: Excess function parameter 'timing' description in 'optc35_set_odm_combine'
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
> index 7c9faa507ec2..dfa9364fe5a6 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
> @@ -50,7 +50,8 @@
>    * @optc: Output Pipe Timing Combine instance reference.
>    * @opp_id: Output Plane Processor instance ID.
>    * @opp_cnt: Output Plane Processor count.
> - * @timing: Timing parameters used to configure DCN blocks.
> + * @segment_width: Width of the segment.
> + * @last_segment_width: Width of the last segment.
>    *
>    * Return: void.
>    */
