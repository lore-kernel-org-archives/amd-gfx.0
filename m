Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C819D1D88D
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 16:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B477810E5C5;
	Tue, 15 Oct 2024 16:37:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WWnc9gAW";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 343E710E5C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 16:37:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUTsQoGf7ztEuD+DHrPWHXpPtWOiv/V30N4RnndUjcQqVRz5b5dBbrGAxbK984Y7L5BDvkmuvDte1d86DryBA8f3OM8hYp2yeYX5omMuB3cddd6OdIEbouIeMnGdbNHbXA9Pa57REqqHrtUg8Nu6CDF9wskIPyeGQKAXACik9pIpviQQTvTrzPwpG9MssYTQGF4Eo4e3V1lWSF6w0/pgnvyWkBFQLqI+EvdXK88UUAlPCshW/6nuLFm9RMNXAoJ/KfzKTd7pw+R2bukst74u33F2ygEDgfi5bgfJwN7rbJsopHjFhr8+ulxh6apm6uSZTVSQT3xvz2Vioxvv9wJXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/zGZOR4ki39VS+Vw7h6odIWA9tYigsx/LWWzYF90Vg=;
 b=t+gYYyv/2e8Wg2VRZM/P/UKGua4jS3db11lI7rJsqZDx+LQd5U0zAUUGsaFbVMKAh62i+YyZkjIL4wL8GDTboS3KIjneXVWrbuM0yz0PAyVJtWXx2RtZKmQR9wb0UOX0B8BmDT3YQhaN7gJj/v8QJ3i+PsRgFk0YNV+ZOKx2NoEylqWyjg8YuX/uatGhd0uBz8tQWbudj1g4y6T2E9ZHpMqXetaBLmMiqfUV1xJk39Gz0HFUj8vrM7p/jTD4JMKy7UrtgXJC5CKYd5LkhdcjsmNKoodxTPdOGTNgU7OVVyGBo8uE6ByS8xLFA6Dp2VJcee1So4H50ZZpHGRXeKy0KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/zGZOR4ki39VS+Vw7h6odIWA9tYigsx/LWWzYF90Vg=;
 b=WWnc9gAW5kftALVSGiTtzEM9pUYM89NWx8fVGgnUNBumyE10y4qLGgixYA3UzgtzPOcIaNJ1qbJLe4cZJsrhwzaGNTqF69ZCQ7V1OuyZRDL2cB3irbg8LCSEqF8esW73rpe42JxJjCBx1Br17Ukr4iX0cFYnOs1ZPP0zsZOwzgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Tue, 15 Oct
 2024 16:37:31 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%7]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 16:37:30 +0000
Message-ID: <233a67d6-5a96-4f6b-8942-07efd628a8c2@amd.com>
Date: Tue, 15 Oct 2024 18:37:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: enable userqueue support for GFX12
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Yadav, Arvind" <Arvind.Yadav@amd.com>
References: <20241010180806.834-1-shashank.sharma@amd.com>
 <BL1PR12MB5144EC6671DD09A36B0BFD0CF7442@BL1PR12MB5144.namprd12.prod.outlook.com>
 <0a06cc8c-b496-45ae-856f-67cd538a2153@amd.com>
 <CADnq5_P-DgRJg-ainqgWAyDR_1P1DF+RirpkzsDJ-Kc4aHfCTA@mail.gmail.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_P-DgRJg-ainqgWAyDR_1P1DF+RirpkzsDJ-Kc4aHfCTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::8) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 5104a34b-2559-4439-a1e0-08dced37a9bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVJ3dmdzZUVCcktEUnoxeXdmU3NabUl6aFpVNHJ5cXlxa0x5a0N2N0ZhQnFh?=
 =?utf-8?B?NTlBT1pFV3d0SVUwMDJqajlPWFIyTUpIRHVrb3psZU9Yc0t5YUg3ZVozVkhs?=
 =?utf-8?B?bURTNzdYK3ZvaVY2ak5IZWJtSXlxNnM3OGtYOTg1a2F0Sk1QSDBIbldNRFhi?=
 =?utf-8?B?ekRiRFA3cGg4MTN5WnEzNDZWT3RjV0JlUm5lYkh2Mmd0clMwR2h0V3F6bnF6?=
 =?utf-8?B?ZEJnNHNJUWQwUmxnNGhTUGRHNzB2SVVZdkpPeXRFS2dVZFFYYU1nZVNuOGZT?=
 =?utf-8?B?ZlN2OGV1cXFWdldRNzRscThZUjhhdE9tSWZURjRyOENVNXUzZStwa1BpYlJt?=
 =?utf-8?B?N0grWFh3Q25TTzZjQkQ3NktyRWdGcEJjSUpTR1dXdzRDQXBIaUdGbmp4YWxB?=
 =?utf-8?B?ZFJYd3RpYnZLUTdmV0pPNEtTb096QzBodlRMQjFPUVVqcVIzeC96LzBCNHhD?=
 =?utf-8?B?eEJYRWhiemZ3MXgrZVg3QmdCejc0VHppdG0rV3JhdkFUU3YxWUlWWnBra0d5?=
 =?utf-8?B?ZHJrR3JpbWlwbkVUdVJRdTFHNFVaWU5nSXhDd1Y4R1RRYlNQc0MxbTBhcC9K?=
 =?utf-8?B?T3VjVlJLeXFLTkE3L0d1RDFXWWd2b3Q1YmREQVZhSEFnZDFLWUFFby9UMTA3?=
 =?utf-8?B?bUExcDJZS0hZd291MnJSNkJXZzZqeGd5dGxEc2I2NFluWVZkdzVFb0NpRFRU?=
 =?utf-8?B?cUlLZG9yaUZyT0c0c0trMEhzaGRaR0RTUzlzL2J4U0phYkZlZCtacEMrc2pC?=
 =?utf-8?B?U1FxS3FNVHovQVNmYkhlRXdWdXM4TFAxTFJYMThpaUd5SFJvanpoZWNmN0dz?=
 =?utf-8?B?NmxXUlEzc2tSNnBBU1A0MlZsakc3bEJpMldwbnJNdzlpVWtVUVg2aUNjYnpW?=
 =?utf-8?B?QytQaHV0dHBhOWNKamJqUWpwQnY3RTZDczlQZUNUcE8rU25HaUE1K0kvbmdM?=
 =?utf-8?B?WnRFaWYra1dNTVdIUG53Z2lBMXovdzhLckp4RnpCbmNhR3hNcHhMdkNYWWdj?=
 =?utf-8?B?SGtFdEpRaEs3S01EZmVwTDRvYW9XckpwMG9Vc0ZVQUN5SkpUVWgyQ2prSHFQ?=
 =?utf-8?B?SldpdzdJWXJ6ckp1V0dTV1VzbzEvT2F3c1l2YUxsYis1bGpIRDNoeG5rQlJW?=
 =?utf-8?B?ZFVSUHhtZHFSaENYbjhjbXpvU3ZjRUtTZ0NQUm5Lb00xRjQwR1BUaUk3Z3pV?=
 =?utf-8?B?VFAwWUJUN0d0OGN2dU1jWk1rQWN4cEtIVGhwSHdGWWhwRVptendCZFNVV0Ft?=
 =?utf-8?B?YmxDOS9nNHNoVDQ0RGkzaENxQkplbVdNcCtDVGVlcGNmakw2b0tRc2xJQlZB?=
 =?utf-8?B?Z1RraSt6LzJqaHFFc09ZbWlMVUV5Wjd3V3krbEtnNWVMT2lEZzhTRSt2ZTgr?=
 =?utf-8?B?MEg4VGJtRWxKREczaEEweXdqNGV1WTk2MmZyMk90UjZzNmhtM29FRTN3WmVX?=
 =?utf-8?B?OWg0UUIwYXQ0dTdSWHFwQ2ZHQjJXRGNZWk9pS1B2MGlRUTdqdDRyUlNRQnVi?=
 =?utf-8?B?Wkthc3Y1NEMxcHQ3Y0lJUWEyT25BU3Bidnc4eWY2VWwxMWRKWDNpaFI4clpN?=
 =?utf-8?B?TlNDRGk1WDlmK2lZN3UwMjNUVGdVQ2o0aWptNVBmNncrOXowV0pvOUpMRUtw?=
 =?utf-8?B?VG5KUFc2S1ZReTRUZnpBRHk5MUV4MXVWblZORnY3YTFPYVBRaUlidHVaWkFz?=
 =?utf-8?B?ZnNzUDBSMC9PRzdqWjRPRWdGdnMzbllKb1FsOVRVc01Qa2s1TTFQc3lRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG56dlE4M0VldWFSVUFZMjl3Z3JCdFEyeWh1WnRZRkh6aGtuU1BzWTRpMlha?=
 =?utf-8?B?MkxLeFFFb3Y5dVlzM3lqckl3cHR6Rnl2clNHblg1N29aRUVEcmkxUU1xNnUw?=
 =?utf-8?B?V0ZIZnFzTGo0K2hLODlIZDkxaGpNWlhrMGlBRWhlbmdzZ1hEcEFENXFETzgr?=
 =?utf-8?B?Wm13bHREZHBtMTVxNW9qK3hGSFYrSjZ1cXBNVUtQNitZQUJhaUp3QnB5VGpj?=
 =?utf-8?B?MmwwdWRGK3o0b2ErWFJ0cjN2SitvYkoyV2ZBd2FpeVVQamlTZHBzcUtubTly?=
 =?utf-8?B?b1RCdnQrdHJUamx0RlBLdytmYlp0SVJnWXZnS29rTUYwRlJMb1VXbVlBU2ww?=
 =?utf-8?B?cWdoUzBFY3ZKb1BZSm9pRG45d29JM1VydndPK3hjaXZ5RUtDMEw3dHN3ZUxh?=
 =?utf-8?B?VTMyVU40aDFzNDJmTHdKd3FFYUkvWTZPMmZjeWc2YTFwRWRsN3BydUdBNkpo?=
 =?utf-8?B?TEhKSnBnRDJCMWxnbE5jT3lXY2ppaitjVE9iRlZLbWRMeGxGMndiMWpDdllL?=
 =?utf-8?B?QkpmVHN6NFJjbDdjcUdhQUcwYjhSVm1DUVp0ek5ZY0tQSWlUUG05d0JwUjdm?=
 =?utf-8?B?Q3cwbFhHVVlGRUpOK0czZ0dINno3NUdnajczU2VjR1dFdWVGbTVVRlE1c0p3?=
 =?utf-8?B?QVFJc21KWUdXRGErQU5nTUdvOHl3TnpNbnhiVWd3YzdQR25WV2FmTzlETmwz?=
 =?utf-8?B?bVBjVGhWTzA4THpqM3ZmVndaYjAwV3owcFM0OHRWdHJCbDVYTEIxUFRlNHhz?=
 =?utf-8?B?M1FLVTk5MFlBWHhmSEhFMHBmNTJhUXVnUkJwTy9xc1NHOUwvRU1WeE1CWDIw?=
 =?utf-8?B?R0VBODJ0UnRVVnprcGp4MWlIbFR1b1Zya0h0M2JMWElmcDFvYzBNUHQwM2NR?=
 =?utf-8?B?b3pnNndWMzd2Z00vcGc5QVoxVDVyL0lxWXM3QlpWODBZa21uMXZqcXI1RDEy?=
 =?utf-8?B?WFRFcHhjOVEramJrM0VldGhlamtQSzdIV1VjZ1FVSjI4UEZDcTV5Q292SlFK?=
 =?utf-8?B?NXNnUWtVMDV3Mk0vdGRXc1QwalREQkZDYWQ2Rk11Q0wvMUgvelg2cFIvc2tT?=
 =?utf-8?B?UUsvd21sVGF2aklCVXJ3VUdIVFpuU0w2T1JsRGpvb0UxaFd5dG9EVm9RQ0k1?=
 =?utf-8?B?dUJyWVBkQmpzcmFjM2VvQVFzb0RNaEhLU1ZTNk5xNE56bmU1MDN1a2FQbDNh?=
 =?utf-8?B?Y2dEbStwcEdKcGRtUlY1bVZydWNYS2U1cmZNWU1sSHNjTkNXVXVscjdNazgv?=
 =?utf-8?B?V0JFS05qNDYzTmpmc3J4aFpYblRZTENBN1NTcGtTUEVyUWF0VlBIOGEzT01O?=
 =?utf-8?B?OXQ3SG1MdXJCQXhqWkh2OUdWaGtRcjZFWlgvN1Z4eGlXZHlweVZJaW1wV2Ex?=
 =?utf-8?B?aGM2MXgyUFQrRXFlN3FRV1RINVJwTUtYOTJ6bm05YncyVFN6cldlejE4VWxw?=
 =?utf-8?B?VnAyVmxtdHdHeTZRWjZaZDU4RitEVmxOakloQWpPRFZCUlRaN2NWMUJXRHpW?=
 =?utf-8?B?d3VNRU4xZ1lRMEVhV2Nyb3F1d3JzT1R1b2t1YWtBUjFrK1pLNTFwdDR0TWlV?=
 =?utf-8?B?dXM4ZjFtQ1NodE5iQk5zS0FzY2N5RWtMVDhteXIzM3ZwbUgyM09XbE5PWWlm?=
 =?utf-8?B?MjFlSHFSL0FxZWhSWTBKZlNpc1JWR3Q4KzROcjFkRGhoZmtoeEd5MituajNS?=
 =?utf-8?B?am5LdjZ4NHlHNStxWDBqVFMxZ25mVnpSYlNYQks2dFBmdER5V1dEMTJHQWVQ?=
 =?utf-8?B?V3Rrb2ZjOGx4cjBFcHZLM2M3dkF0M1ZRd1JuTmkzRFdYUnI1MHg5MlhvbXJ5?=
 =?utf-8?B?NXplM3JaL2dHZFNqWXRuS3VudnJrRnU5VzJFUVEwVHBSOHJkdTdBaU1pVCsx?=
 =?utf-8?B?S2FhTGR3a0xNTjE4bkhEYVlnci90RU9qc2xtVEpKN0tvelNEZThIQlYra1ZJ?=
 =?utf-8?B?VVZTOVJDVkZXb3FXZGFkdnZWcHB0MU82ZTNyKzg1WDFXQWtZbFh3OE90Mkhp?=
 =?utf-8?B?YkJZTFZLaUJXWUFFVjQwNFhmT3pHeG8zYW5jTUVSNC9lcGdTN3AxWURLSmh0?=
 =?utf-8?B?SEszQWFiVWtacXVmSjF5dm1hWGVWNDBtcmNDNk0rY2pzdVYyWmI5RStmTnBH?=
 =?utf-8?Q?v7BNK7iHKT0ZtsrgbG0gWbezd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5104a34b-2559-4439-a1e0-08dced37a9bc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:37:30.9040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhrdcgT8mgMAuAUZGJxkdp+kcZ8Eq9neYkBS19RBv23J0muqzY78wBGR/I8umAd59jgtbA+zrYmbSkMaJdo7bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237
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


On 15/10/2024 16:58, Alex Deucher wrote:
> On Tue, Oct 15, 2024 at 6:13 AM Sharma, Shashank
> <shashank.sharma@amd.com> wrote:
>> Hello Alex,
>>
>> On 14/10/2024 22:29, Deucher, Alexander wrote:
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> -----Original Message-----
>> From: Sharma, Shashank <Shashank.Sharma@amd.com>
>> Sent: Thursday, October 10, 2024 2:08 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>; Deucher,
>> Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>; Sharma,
>> Shashank <Shashank.Sharma@amd.com>
>> Subject: [PATCH] drm/amdgpu: enable userqueue support for GFX12
>>
>> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>
>> This patch enables Usermode queue support across GFX, Compute and SDMA IPs
>> on GFX12/SDMA7. It typically reuses Navi3X userqueue IP functions to create and
>> destroy MQDs.
>>
>> I would like to make this more explicit.  In mes_v11_0_userqueue.c, I would suggest splitting out any non-gfx11 specific code into some new helpers in mes_userqueue.c.  E.g.,
>>
>> mes_v11_0_map_gtt_bo_to_gart() -> mes_userq_map_gtt_bo_to_gart()
>> mes_v11_0_create_wptr_mapping() -> mes_userq_create_wptr_mapping()
>> mes_v11_0_userq_map() -> mes_userq_map()
>> mes_v11_0_userq_unmap() -> mes_userq_unmap()
>> mes_v11_0_userq_mqd_destroy() -> mes_userq_mqd_destroy()
>>
>> Initial patch sets had all these functions named similar to 'mes_userq_* ' only, but later you recommended that we should have mention of _v11_0 to indicate the IP specific stuff, as there might be IP specific way of mapping/unmapping/creating and destroying the queues. So with this comment we might be going back to the same version.
> Well that was before gfx12 support was on our radar.  Generally, you
> develop for the first generation and if there are things that you can
> pull out into common code and share across generations, then you
> should do that when you add support for the next generation.
Noted,
>> As of now, v12 UQ was tested using the the same methods as V11 UQs, and found it functional. We might need more information before taking this step.
> You would need to verify that the V11 and V12 MQDs are the same.
> EIther way, I would recommend making v11 and v12 variants the the
> functions which populate the MQDs that the firmware uses.  There is
> alays a chance that the firmware may repurpose some of the fields for
> different things that can lead to subtle bugs.  At the end of the day,
> I think we'll end up with a bunch of helpers in mes_userqueue.c and
> then a function or two in mes_v11_0_userqueue.c and
> mes_v12_0_userqueue.c.  Alternatively, you could just put the helpers
> in amdgpu_mes.c and the gfx11 and gfx12 specific functions in
> mes_v11_0.c and mes_v12_0.c since it will probably only be a function
> or two.  You could even add a callback for the MQD specific changes
> and add a wrapper like the other functions in amdgpu_mes.c and the
> generic functions in mes_v11_0_userqueue.c.  That would make
> everything symmetric for mes managed queues.
>
> Alex

Thanks, Noted, I would do the recommended changes.

- Shashank

>> - Shashank
>>
>> However, mes_v11_userq_create_ctx_space() uses the v11 mqd structures which may not match the v12 structures.  We should add a v12 implementation for any functions that use the v12 structures.
>>
>> Alex
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Arvind Yadav <arvind.yadav@amd.com>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
>> drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 6 ++++++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index 9fec28d8a5fc..d511996c374d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -46,6 +46,7 @@
>>   #include "gfx_v12_0.h"
>>   #include "nbif_v6_3_1.h"
>>   #include "mes_v12_0.h"
>> +#include "mes_v11_0_userqueue.h"
>>
>>   #define GFX12_NUM_GFX_RINGS  1
>>   #define GFX12_MEC_HPD_SIZE   2048
>> @@ -1335,6 +1336,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block
>> *ip_block)
>>                adev->gfx.mec.num_mec = 2;
>>                adev->gfx.mec.num_pipe_per_mec = 2;
>>                adev->gfx.mec.num_queue_per_pipe = 4;
>> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>> +             adev->userq_funcs[AMDGPU_HW_IP_GFX] =
>> &userq_mes_v11_0_funcs;
>> +             adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =
>> &userq_mes_v11_0_funcs;
>> +#endif
>>                break;
>>        default:
>>                adev->gfx.me.num_me = 1;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> index 24f24974ac1d..badcf38bb8b6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> @@ -42,6 +42,7 @@
>>   #include "sdma_common.h"
>>   #include "sdma_v7_0.h"
>>   #include "v12_structs.h"
>> +#include "mes_v11_0_userqueue.h"
>>
>>   MODULE_FIRMWARE("amdgpu/sdma_7_0_0.bin");
>>   MODULE_FIRMWARE("amdgpu/sdma_7_0_1.bin");
>> @@ -1317,6 +1318,11 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block
>> *ip_block)
>>        else
>>                DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
>>
>> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>> +     adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
>> #endif
>> +
>> +
>>        return r;
>>   }
>>
>> --
>> 2.46.2
