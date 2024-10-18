Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEDAD2FFF2
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 11:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FD7F10E8ED;
	Fri, 18 Oct 2024 11:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CrtT1STt";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7450710E101
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 11:12:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPRUxNBpFMUD5PSlXfSMiEkgoLZDfI2llqavV/fGu9owVGqs2tDN0c6ZbAYCxugrqLKdDU42jIUv4a+QJJE6nfr9BS+j+Fxd1XwU43tDD/jhKTwm7VvQLqISs5A6w0PVse27hU94o3X4ADzaeT5cNUpEFM7quk0YzBUwnakjCof5qwLuT9wiMUmeYpUjIV9T1MAZr4dTuQnbLGB5bwezKPgcv4obqXPLFVhZczsfkjXgWzlkDLLcKRTV33RUY7mDU1mjd3S6Zy3vt1Bawhz2wYoHS9+UWvZgUG9EF9jwQQrRWEDiuFdTw5jyg+BQ334FrURIyW7cFKuVCjlzW/qDOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIg6k3An2uBX68nfr+4J5Wymqp67rXjbvS7ASEEipAw=;
 b=F+i4klObn8GGmtq1u5a+jeAAEOEQPmk+gicN6B1lbeSrjSMHHWE+aqcMCFMXtO30xjjT3NKRMwnj9HyHmnijLEpuM9wDrfyqYQKB0udgOvYUVwbnhBxDucfnbuYpuEX7PfTdTZ9/1/5Sosy0GHC+bohkv6yrCcox4JYU3aSJhTWcxQSbN4jeFbgCO4U82MlCdaXMtud5uze/ysOi7zqnsubT12qAUp/I4ECmI6AfNTt6HU492jP6r+s7kUCZmzg+rBmyFB6t5pbyI3x3ksbq4MzvQCr162BsXLhItx8InlhCIJ0FyM9sRaLP0Pv2a3S4OGl1huWHko4E+UxT0jlNRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIg6k3An2uBX68nfr+4J5Wymqp67rXjbvS7ASEEipAw=;
 b=CrtT1STtY4mfvHH6fvnLNEZWVa6woDOLckQCAVUdyO+84/lGtjeAZlTZuStIBKXI6FuwJR01PVp0p5vBSFCGJh4ZCyCq3GeNAN8qP2mzqaFtHeRMwlzvWO6aZXeUSZ6YaOJ9F3CkNoO+QU9eQkDdxtSm3CtCh95ai5ty0doLeoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 11:12:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 11:12:14 +0000
Message-ID: <7acc34dc-85d4-4e2a-b215-5a6e9ec4aaed@amd.com>
Date: Fri, 18 Oct 2024 13:12:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] drm/amdgpu: add helper function
 amdgpu_ip_block_resume
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241017162531.1551442-1-sunil.khatri@amd.com>
 <20241017162531.1551442-5-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241017162531.1551442-5-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: df03aaa5-4b32-4933-bf44-08dcef65b854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VERJRHZHb2xZVjRsaklsRGI5VFlhbDBBcWRRWFFmR3JqM1VxZFl1SWZZV0hm?=
 =?utf-8?B?TkUzOUZLUVB4UnRJd2tRcmVIbzZGSm41OFYvU2NCY3pxM1JBVjlpSWV2dW1B?=
 =?utf-8?B?THBjVlpRUDBkNmY0RktlQ0RVczBLeFp2U2ZnTko0MTBXbFhqZjRkUWNsNUF3?=
 =?utf-8?B?aTZJZHZjV3pwdUV4OWh3U3RSbDFYSXIvckxCUVl3NzkrSStuR2JiTFVpZnVC?=
 =?utf-8?B?dy9TK2JpQk1NNTZhdkJLenhSTXhZV090MFBBVE1kRktFbjlzZnZBWG54T3Y3?=
 =?utf-8?B?T3YwaWZGa2ZzbFh5MmFGeFJFZjNwTS9VT0k4WUkxNDFMWGlpNlh2QTlKZXlN?=
 =?utf-8?B?cjRSZGhIMnR0aVIxbVJuZm5PSjY1d0twc1lRT0hKR0Y5RG5ibjJTVnNMa0xo?=
 =?utf-8?B?WjdLYTNvTmc4U3hoM3VGekp6dVRTWGNKUFR3QjZ4TGhwN0Rua2RkMmFQQjBs?=
 =?utf-8?B?QkZOQjkvUnFxQkU5SmV0WDFlTllXU2kyRkMwM21GZFlZZmh3UVFQTGoveW5S?=
 =?utf-8?B?MDlRZE1meFluRm90UnkxTzU4ckc0Mm51MUxiMWprMkZXUDl3SDZ4QTUwUVY2?=
 =?utf-8?B?RmNDSU1TbjdoMDRvVTVOSkRwWERoQU9JTGJwSjNVN3lWYXdVTGVEemRvSWxx?=
 =?utf-8?B?MFR2bzliZkE4UnJIYTNTRURlVnFwdStWQnllSGRRb3NyQzAxNUFhR0dVcjlo?=
 =?utf-8?B?dklBMzB2dU9zamRGTWsxZzBZREM3aFhGeXJZSVJGS2RTeHRzWTJOMlg3U2M4?=
 =?utf-8?B?NFRleEN3L0s4YmxKbkF0ZXV3ckFJUm0xbVRTK0FjYzlJNElnQ0Jwd2ZXQXM5?=
 =?utf-8?B?VlkwNE41TTNMYXFscUhOTXVqQjF1eHBhdWd6aTlEUU1jcThtSVl1LzhhZ2tz?=
 =?utf-8?B?c1lUdit0NW8xZWM5OXF0RC9ESC9oNXNJd2FOUks3ZGo5RHhQWmlWOWNXVzZQ?=
 =?utf-8?B?K210ZUEzQzVGZkRFUDF5ODM5WDZaS2dKY09KZThIQUR2Yy9QTzlrOTFnK29I?=
 =?utf-8?B?MHB6dmtLaXBzMkZ6OUtzQ0E4OC94K3Z4TjNSL0Zabm1ZTUI2SUxzL1VjcDJt?=
 =?utf-8?B?Z21GU3lhSC9DQUVnVHhoZ1RJa2x1Q3VHRWgvdUZmVWk1TXdCSTM3dllXZEkz?=
 =?utf-8?B?OUJ2VVBaYUNKNzhZUitqV2k5VFJHR1grVkFaRUpPQ0x2ak5ybmJma3B4ZHh0?=
 =?utf-8?B?MVRKbTAvNDVsREY2T3l2MHhBWGdaN29TN0FwRE9kMzlHNlBMM1BZWmpoTDVH?=
 =?utf-8?B?cThmcnAvQy9ld2JDdTVMUkZhOUF2RDVQaXlNT2oxUFp0Rmt4b05ydi9RNm1K?=
 =?utf-8?B?TTlHQVVENWZldytHUXB5b1JqbXRqZTE2Y25wS0RlSmRKRVVGcUhWYUQ0dWhG?=
 =?utf-8?B?TVg3aUx6VDQvOEpSRGRaR2RWSXN1Z0d1VEVKNWJaTG9QZE54NTVLeXZTMENw?=
 =?utf-8?B?cUgyRUhSYjJwZU93KzRxVS8yOVZhVytaM3lJS3Z2dURsaDR3dXEwZWcxSVVT?=
 =?utf-8?B?aHJqc3Jvald0TVFVb056bHlHV1FaZlRMblZ5anViczFiNE5pdWprUkx6QjVY?=
 =?utf-8?B?UnhON2ZUcnFUckhqVFRnSzNwSVhWNFNhVjcxY01iQWw0WXJLMXJjZ0NvRmIr?=
 =?utf-8?B?NjJwSnZ2Y1I3bjZWMG5kWHFmcnhVTHBWU0hzdlNwWUhudTJKNWQvQjFZZ3F0?=
 =?utf-8?B?cDdqY3pQTm5IUWtsU3o1ekNGRFlleGhJVEU1emZFSkV0SzVQRURmdnBXY2dE?=
 =?utf-8?Q?h1ymAC47lvfngte2ctV3HtBn/kzSESFltDO/G2l?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjhnMkZSRGt4R2FxeTdTTWdXSk1sWCtOdEVWZkpIODIwWXFaQkcxTHEveXg2?=
 =?utf-8?B?YWZ1cXZQTzc1UGdscnlXQXdiOUlFYTlhNkVLRkJ1c1ErUHdvM1M4TWNPSWt1?=
 =?utf-8?B?ZU85RDJ6d1F4ZG14eHlGbzBZSStiQU5DSlJpSjg5Ui92QTYxV1R4SDRyOEV6?=
 =?utf-8?B?OGE4eVpOcllEdmdYQ2toREdXSVhYQWdINnJqTmgzTjVSaFcybUNzVmxrQysx?=
 =?utf-8?B?dVNsUTRnWHFielpCMXA5a1c5dkFmU3lRclZOcXhCTHd1bVUweHg2ZmtLWng0?=
 =?utf-8?B?eEd3WW5TMUZaT2pEYmwxSkFibUZneFp1QWU3djBHUVQ5ci9EVUVtR3QwOHY5?=
 =?utf-8?B?amJRdmJ3S3hUdm9weWFJdkJ0OW5zM2t6WVpxakxza3VjS0FIanlob2pTVDVX?=
 =?utf-8?B?ZWJuamFFbk1oa2VVaVhuaWJpT3NqUTBKTURIWVh3dkdUbWdabTFFTDMxdHpZ?=
 =?utf-8?B?OGhMdjg3ZHB0YkxUMDhKMGhiQ2xEZExPM1FuMFhOM2s1dnNHRUNqWmFNdVI4?=
 =?utf-8?B?anZRNXI4RWF1WnVINmNIdk1LazE3NnBjZnpLWkxHQlhWQ1Z4WGIxUDJpN3Jx?=
 =?utf-8?B?TFhSRWQ2dTF0MzlSUjFCcjB3QkJlL1V2eDNjOXBKUHptbUxlTFZZYzNYcjIx?=
 =?utf-8?B?UjZGVndlcHpKMDhZNlIvYUNGaUR5TlJYdXhZbytVUUFxYnRoeVRFQXlsb2Nj?=
 =?utf-8?B?Uk5MdERyT0hoSzdBYjNwS2NId3hUNVVCVzlnZ0VTT1oxRW9TQ2FBYldYbndX?=
 =?utf-8?B?bE9zQVFFSUE3cDgvU1Q1b2RqYmdsMlR2NE5wT055bmNrNDVvMXVGb1hhdllV?=
 =?utf-8?B?U0ttT1RPR3M3MERqQlFFUUNaOEtzN0RUTTMxQVlQdFJSV0preG5YNUhPSnNY?=
 =?utf-8?B?b3BvMEFwOTlSVTFDMTBPL0NMSE8wTkI5aVQwT0NEUmVBSFNaZmZGL215bzdI?=
 =?utf-8?B?c2hmNmc3RzFGaGlabXJtZDJtRlZxS3hRc1IwSEFtVHJFYnd3NTFHTFd6RWZD?=
 =?utf-8?B?N0kvbmtWd0hpUGk2SHNJT3hwUEZNbmlNaVZFSllPRDhBc2dSZVdGQm9MdHc0?=
 =?utf-8?B?R0VKVk84SmZCV1hYdFhnUXZQVXNaRHJyckdFd1IzdVRmd2NUaGRKa0lPNVlL?=
 =?utf-8?B?R1BNT3BGcG10RTJFd2xIWllSZGxEYmc4cjZRQVZOZzM4SC9HRFFqdmtIU3k5?=
 =?utf-8?B?aEdiUHNuSzRwS01sYndtNEZHa3gwb3hnVmFCT3QwQ1NEaGYyejAwa2E0YlNS?=
 =?utf-8?B?TzJnUm9NNVZmQUJsazNMNUJJYVMyampyNWhKdjRReGMyekdWTU9XYlBnSzZF?=
 =?utf-8?B?UldrM2ZtNU5mSTRNbHNiTEhaL000N0hFSjdVZ3NQaUVOL1NranBKUzN3VEpa?=
 =?utf-8?B?d0dKMlNoZlVBRy9xc0FyR3BKQXhGZWlEMmlHalQybWlNdTVxcVVLU0VBdEtV?=
 =?utf-8?B?WmZ6QnhmcE5MTTdGL1g2dEVZZVVqSlJXeEd0MDZzU3BtalFVVWtEWWxaR0dz?=
 =?utf-8?B?ZGRCQ0xyZ0tQSndxYk5sUGJUbGdHN09XMHZLUEliRzVmcGlsRXBjcXp3Qktk?=
 =?utf-8?B?VHc0MmhQZ09TeXhwaDVic05nbDhJYmRySDI1Q1pydzZ4NTNZakp3OUZKclR6?=
 =?utf-8?B?U3VZOHRNR2J5USs5QnZEa0dtUm9jODduaG4rR0liWHN2Y2F5eXUrSFlsdVJv?=
 =?utf-8?B?OHUwLzl4NStrTHZ2QXVaVVIrWmRLRFdFZlQrNHB4QmxXVkY3M2VCcy9nUkZz?=
 =?utf-8?B?cU0xMUV3S2FGdkFUK1hhZitMeUFsRzUxbWR4OUNyQXNzREZWQ0F5b2lVdnRL?=
 =?utf-8?B?amJEaXFKU3lmTFZoNmNkU0dJTmRCOU5kQ0FaWWdoc1V6bmJIb0lTTENYVjlz?=
 =?utf-8?B?QWVsbWFuejJxazhuZzFJSllDN3ZUY2Z5SlIvNXVjbVJnblBQYThIVThsQS96?=
 =?utf-8?B?TU5JbkpmcHJGRFMyWTNMdlN6MDRRems0aXhaUUZqSGJSU1FtL2dYYlF1NU1P?=
 =?utf-8?B?NjBaKzQyMFYveTBGQkkwajZWLy82eVRCTjd2YTB3Q2FqbU9CZDZzbFlaV2FQ?=
 =?utf-8?B?bGVQODVHZFc5YmhReFdua0dnQnN2RVExMktaSnVQWGZrVCt5ZitFK0QrdTJI?=
 =?utf-8?Q?pGop/8/OyX+c3bWprl3wVVeJO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df03aaa5-4b32-4933-bf44-08dcef65b854
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 11:12:14.4115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AWE53PNB3+DaNLZQEin4WoXVXvS2qLNMOuewY34EHs1mKcR6xXitVE4omMuw8aH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
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

Am 17.10.24 um 18:25 schrieb Sunil Khatri:
> Use the helper function amdgpu_ip_block_resume where
> same checks and calls are repeated.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++++++++++++++++
>   2 files changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index df57efa019ba..fba10ad44be9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -366,6 +366,8 @@ bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
>   			      enum amd_ip_block_type block_type);
>   int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block);
>   
> +int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block);
> +
>   #define AMDGPU_MAX_IP_NUM 16
>   
>   struct amdgpu_ip_block_status {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2d098c876151..77669eab3511 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -289,6 +289,23 @@ int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> +int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block)
> +{
> +	int r;
> +
> +	if (ip_block->version->funcs->resume) {
> +		r = ip_block->version->funcs->resume(ip_block);
> +		if (r) {
> +			dev_err(ip_block->adev->dev,
> +				"resume of IP block <%s> failed %d\n",
> +				ip_block->version->funcs->name, r);
> +			return r;
> +		}
> +	}

Same here, please add "ip_block->status.hw = true;" and squash the patch 
together with the next one.

Regards,
Christian.

> +
> +	return 0;
> +}
> +
>   /**
>    * DOC: board_info
>    *

