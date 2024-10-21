Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBD7D17129
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 19:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9276010E2DA;
	Mon, 21 Oct 2024 19:25:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CghfUuPc";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAAD310E2DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 19:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIu1kgZBR8cslj44ABo25Jjg/xJNNla180z+wJT/aUj3HkIOh8BtoHT7i+XV3mlXukFh5wR/eHtWc2RGj7HuWWUV83e7+PSjDG+iQNqY1hYX76HxNM68gjIPziDbbqFtO3XUnoEnWz1hUrastGOAglXJHccmD6DZ86KOFxjWF9SH3afR/VKylwDel8ie+Be60Wpi/P3SMBjxnv2DzK+2DSsScZszKve0TN0ayC9+GUbJPRF4hqd8ku3kopJfE3Kc0qHT2S5449Nz32H2xp+uaohI6KbUZgkvM0HF3S+QOjqVqXA7KyXd+6PO/Y9Lsbb3Bj+GYU2KOIv7AsRfacEd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cnRNNR8V2fR8YelvNlxIZLCS/S9l5QKvJ1NDB8N2so=;
 b=Hi6Y8/2jYh7zzZzZNvl3XAWO9unV5X7kikiLaCFKgv+5Q0ip/e4zI/dDyrXdOC/FP+tiW5l0LKs/u/GLajKSwpl6aq5vHoeY6rvMVggxTijRyClOTRbceTfdkY0ShuaYHdBPkyocUD4avM8v5FqMddQy5i5kSTRB8+osC/hu8L33NrYzmcILvH//P0vYxtTrl1U3oO37JAjmkeUj4nWjM1bK/20qQCh7+jKUM4gh0edEb9ASj3KG2pfhgHM3XlkBGwIsoXEzAOhE3AtFD7A6Xv9h9lGA1pYlnr3oRJeCyebbLOCdSFnS2ysQkQwv9nlKD6G54JoIbRLQF7EETHAAhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cnRNNR8V2fR8YelvNlxIZLCS/S9l5QKvJ1NDB8N2so=;
 b=CghfUuPc9fDxhTwl6tQOZk0T/nWHt9Y84duc16/Axt0zps0z0VO4/y8Jt8iqIio0UvD4qXL0ngU/X81Nbc/UxoVLJ+4rwZ260+2AOxkjYWiNQAzt9KFZTiQsH28YRjArHcPNhDJUTktubN3H+AvwLgfeUXLe7pZhrGlt21Jfv/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 19:25:52 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 19:25:52 +0000
Message-ID: <aede46ee-7a80-4ae0-a179-2244153ece42@amd.com>
Date: Mon, 21 Oct 2024 15:25:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use SPX as default in partition config
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 Asad.Kamal@amd.com
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 Hao Zhou <hao.zhou@amd.com>
References: <20241014091911.3036389-1-lijo.lazar@amd.com>
 <a4287c13-6006-4739-a2f3-8c14cd085f05@amd.com>
 <d19b821d-4768-4338-98d1-40950956cbf4@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <d19b821d-4768-4338-98d1-40950956cbf4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e55a0ef-ceae-4061-2607-08dcf2062d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWMwVnNOSlFGZGFEL3JSajdLUitOOTExeWtKbTBEeG9NN1k0ZDM5Z1FKeGJx?=
 =?utf-8?B?U2R3N1dGK2pxRGlpbTNHRjJTaHhnd2RBL0xiVnZ2V2d2OU5la0hDM3Q0am5U?=
 =?utf-8?B?VTZ5VGg0dVVFMjFkaE0zVGJkdUxMazVkQ0ZnWHNrdmYyaGVKRVBhNjMwQWJI?=
 =?utf-8?B?VjRwRU1YUEZqSWxxS3NOSVYxcy9DZFZsTVBhUGg1ZFJxQ0V6VEhML1dHMTY2?=
 =?utf-8?B?WGhhdFN4c284Yk9IRm9jM2thM0RkR0NCc0NDamVvWFg3N3F5ZUdkdWRKdmg4?=
 =?utf-8?B?L1FZM3dmd2FwV0dTcks1ek16NnBCc1QzYkZ4ZUMxRWwydVZIUzJzSlR3Yjgv?=
 =?utf-8?B?SjVjZHhCTHRpZ3llVms2blFyakN5RXdvZGZnZmdESUM4bnZMbGhRMmsyQjdP?=
 =?utf-8?B?SU9hMzlSTS9sRlRqUEJoQzAzcE1CckpaZy9CcTB2RlJyZXRvc3U4Q1RCUVU1?=
 =?utf-8?B?b0dQeWVVTDYzSjQyNjNqd3gxMjVocEtzdkFBekFJanJsRmwzVnBDM05HVnU4?=
 =?utf-8?B?STNkZFNITDRpV3ExNGd4ckRrNWU3ZDhOeVJaUmpvZ1o2SWRTQUUxY0hQNzM3?=
 =?utf-8?B?d2tJZXdNSUIrand6bVVQVXgwR0g4NFBUUDlvQU9wTnJPQ3hzeXF0R21rTkNi?=
 =?utf-8?B?V25oSnpRSUdBS3NQV3M4UjUvWFNBMnNzb1kwMXcvOGZHVVhlY3owMFlWZDQ1?=
 =?utf-8?B?dHo1NC92QktDdU9ZMjU1VjBORWltcWVTZ0xiUTJtMmM1eUVtOTVIYmNVSzRq?=
 =?utf-8?B?L1hhRVYzU0Y5TjR2R211cmNHVXFqZzlRNEJHWTlvcTFFQk5FZTJxTWtEbWZW?=
 =?utf-8?B?WlRiL2YyRzFBekpNZWliZGtuOTRkaUkyMGUwQWhqR0JJVU1DaWtGL2w2OVZi?=
 =?utf-8?B?emJuTnFLVWYvb2UxWE1ieWVsaDRlTzV2N3o4eUpJRDNVeEVXaXYvb1dPYitj?=
 =?utf-8?B?eCtTRUhjcDlVVUp5SFNRQ1htZmI0VXU4V3hJWUpuSXhHWUtqUU1ZMzlvY2Jw?=
 =?utf-8?B?Y29KQk9tblIxMUMxbmg0QjVLeEhxaWxrZ3RjS0pUYXVRRFkzdkhrVWJTcDFI?=
 =?utf-8?B?bkhBUUNkcUF1TlF2dnIrZ1J2dE5jdlBJNktHUkIvdlpsRXRHUlkzTXVaNHg5?=
 =?utf-8?B?UjJtelBjSzlrd0VTSUFYdXpFT2JzNTlObmxWaklkOW9BblpoZGgxV1NCRmVO?=
 =?utf-8?B?blMxaVVWTU1BVkdnTjM3R1B6QUZPNHBtWFRjaG9lUzRlYkpmUCtEdm5FVm1l?=
 =?utf-8?B?OXQ3OGUveU5qZnhmak02QVY0dWpFQnc3SXkxV3ZsQ2luZk4wRThsZXU0Z0xX?=
 =?utf-8?B?QUFCRE1WQi9QZitaditXY2ErbGhSZUI3YlY3NWtvWVVZeFpHWmphQXkrUVRK?=
 =?utf-8?B?Y2hYRzk2WklTSnZkOWg4dUUyR2ozOCsrNHY3MkVmUFVxS3llSWZ6ODRrMmtz?=
 =?utf-8?B?Rlora2FwNFJVa2Q1aklQR2xvNGhZcWxibUxCRzU4aXd0Mkd2aVhBVlRUaTFv?=
 =?utf-8?B?TWJ1cU90aDFENy9SMGp6RkdiVDZTUzUvRU4wemlMMUNTbEVYV3VJVnNEbGhD?=
 =?utf-8?B?UDlpNTFDenBKRTBCZVJBM0MrbDBWeS9ua3pHb05Rb0dKRHZ2dW5RT0Y0eUZZ?=
 =?utf-8?B?b0Z2QzRTb25qNTlGblpUamdXSHJLZW9SK0VjT0xsQjd5bUw2bGk1blFqMlpu?=
 =?utf-8?B?bXlmMFFNK1grWDVJL1Q1UzUvd2JNQWIvMHViZUpzcHI3QkZkOEtCMzRUMjU5?=
 =?utf-8?Q?s+RNOIjuWhSdz/BWORClFfK2AVOu+DWLztosyfJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODBFK2xuUEFibkZWUWNWNUtiRE5EUUFjSmRFbW03LzJ1K01UMElxYk5nVVZJ?=
 =?utf-8?B?MVlEaVJHMFhvbzI1V0VmM3kvMGdIalVmaTcwMGJYK2pRQUhLKzREZXc2M1l0?=
 =?utf-8?B?WGtjS29TN2F6ZFd0d1FPa1ZGSWh0N1lKdUJmekVIMXc1YlpxTy8wVjVESEdl?=
 =?utf-8?B?QjY4SG52cGNsd29kbmg1UHlUVzBsQzczVzhwM3U4MFdzL1lZSTF4R2lIMWx6?=
 =?utf-8?B?aXNoTUdIYTh6M3VYNDU1L0dnMEQwOVNMRkpOUXB3SDBESVdZUkYyMDM3OUc0?=
 =?utf-8?B?a2dLT3oxNU5pWE8xa3ZXVDJtVGVzV1NISDkvV3BYTm00OUhJYXFGd2FsNTBS?=
 =?utf-8?B?RnJhZEduZTdkbk9PNGozQkpUcmI1NUdYRFRwSUxIYVQ3K3ZlcnhacjVXWXht?=
 =?utf-8?B?eGpENzZIMi8vL1ZWVVUrL1NNUzFxV0U1WHlUZUJSbnZPSnJ3UGcybHFPZzVP?=
 =?utf-8?B?dWRxKzV6bFJzQ3psT0V0M1NLcW5sY0xtNjI0SStiNlNlTmRNZnJkWEk4MzVQ?=
 =?utf-8?B?YXB3NTZ1VXZxNTRDd1pmQXdwZ2RPVmdNRkF1SGdoVzRwdThwKzRCeERKTER6?=
 =?utf-8?B?MU52N0VUY3k4TkNNay9IUk84WkxUTWlFRm5wQ1hodGtsZ1hJWHNoemNvMzVI?=
 =?utf-8?B?ZmNsVTRzSVhyTGZkOU80RXlnZm5QZVZOR3hqNzJOcnhkWlF4d3pCR3N0STRY?=
 =?utf-8?B?NUVYeFMvMmRyNks5eHZjbW9UcTM5TDAzTGs1QTJGdlZVVkF1a09xRmxGRDRE?=
 =?utf-8?B?b2NqS0lwcGs4UlA0MnZzZ3NOYjkyYW94OXcvZ2t5ampRNTczdjRqWkJXRmdh?=
 =?utf-8?B?WGdUU0NUSkI2OVZzTGxVSjB5OHBvUjMyYWVzbEVxb1pGa0dxTVdSNjB2Y09X?=
 =?utf-8?B?YlBNK0ZDU0t1dnRua2V3dkRiWWsxWUdKWGlacU0wVDVDMVJZM1lMekNzYmc3?=
 =?utf-8?B?TmZXdjY2czhQTktIbEJlV2FkcVdYOW1LUmo4MnNjdmF4SFlaY1pGRllybFlB?=
 =?utf-8?B?WnJ6MHhDTjY1MWQwdlBUd2M1ZlU3dUZyQkFheVNDVTdWdXhHL25XT3ppK3Zh?=
 =?utf-8?B?WjFDTmdENFMra3hRWjd1UXg5eGdvdkZhY0lXRjdOaXNFYnJZVjgwRzRER1lT?=
 =?utf-8?B?cjl1cVRiMWhZUmttUGRFbHd2S3h5NitnbnlSQUh1cDF4RERoRVBWajBTWGRl?=
 =?utf-8?B?ZWVLbXF1RGhTODI3aXFkYm9hYWZZT2x0bWFwZmdNaVBTWlN5WnRzVHdxL25S?=
 =?utf-8?B?Q3l4emZJUU5jTFVPRHpxcitpbTJtY2hFNFdZcU9kc3F3N3pXN3FpcDQvcG4r?=
 =?utf-8?B?aGdpZ3o1Z0VydVk0bks0VlZvdHdySEtSM0FXTkpwZ1ZwUW8vS2IreklxOWQr?=
 =?utf-8?B?OWcwK0lHQnU2K29pL21NRnhUbTVqaFdsZTZHd3pSSmdYWkh4VXM2QVBLVDJO?=
 =?utf-8?B?RStsSzgraXlVRklWR1owWThhdWVqMDlROWM0OVAvdzZFNitDNzN0bU1Eb3Z6?=
 =?utf-8?B?MGlTNVZ6M05ROWUzaFhMNzM4ZCtvckNpTGFVVHNLbGpvVzU5emFQYStTZFlx?=
 =?utf-8?B?SDBSWElEK05ONmlaTW42R005MlJsdG9zNndEQnNzOWFYY0Y2bkVodHlSZUdX?=
 =?utf-8?B?RmlnTjZlOXVDK3NBWW1tTEJoUHdUSHdwUHc2bDRwUDBhV3hTeTYrdmljUElm?=
 =?utf-8?B?YWsxS1RvcDZYYkYrSmorWjNvM3k3dVh2QlFyYXRqUjNxM1BlejhkYXBqcnk1?=
 =?utf-8?B?cFhpOUl2NFVzVE1ObXBkMG4yUUlTbTkyNTF6eHZycGZ1LzVOUmhDc0w2dExJ?=
 =?utf-8?B?OEdpbHppYjJMSEFDYU1MMDl3dDRxazNjTFJwdEozZDN5QXZ2a1BQWXR4THlp?=
 =?utf-8?B?ZFNERU9ZTEFyZmFjTzdlRVpqWnlwTDltUi9pQVczdGdaVDEwd2d2ODRzeXMy?=
 =?utf-8?B?ZmNvTFZiSFpTVXVjaWJSaldlaHVHTjZrRmFlTjlHdmd4RWlFL1NsNFBHaitl?=
 =?utf-8?B?LzRPcE1hdndQL1dWNFR4SjdUQUZTZFVmczdtb0FpbTFuRlVUMEszN1liTDVw?=
 =?utf-8?B?QzY1K3FobUg4a0dvRmMzdDZVMjlFMWhDOS9nS0g5ZU1kc0I1OExvM1ZTWHJk?=
 =?utf-8?Q?4PKzJlRb6aQfl3aqFZxVaXOMF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e55a0ef-ceae-4061-2607-08dcf2062d5d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:25:52.7072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKsMAGmqtUaAEHHyVK1cW0ZcVYEapS0Z2VKjwFcNosSxnkmCj99RtKYwHeW6enyhQx5HC+tETUaWlem2H7TDdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
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



On 2024-10-21 10:07, Lazar, Lijo wrote:
> 
> 
> On 10/19/2024 12:46 AM, Felix Kuehling wrote:
>>
>> On 2024-10-14 05:19, Lijo Lazar wrote:
>>> In certain cases - ex: when a reset is required on initialization - XCP
>>> manager won't have a valid partition mode. In such cases, use SPX as the
>>> default selected mode for which partition configuration details are
>>> populated.
>>>
>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>> Reported-by: Hao Zhou <hao.zhou@amd.com>
>>>
>>> Fixes: c7de57033d9b ("drm/amdgpu: Add sysfs nodes to get xcp details")
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 10 +++++++---
>>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> index 111bf897e72e..83a16918ea76 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> @@ -606,7 +606,7 @@ void amdgpu_xcp_cfg_sysfs_init(struct
>>> amdgpu_device *adev)
>>>   {
>>>       struct amdgpu_xcp_res_details *xcp_res;
>>>       struct amdgpu_xcp_cfg *xcp_cfg;
>>> -    int i, r, j, rid;
>>> +    int i, r, j, rid, mode;
>>>         if (!adev->xcp_mgr)
>>>           return;
>>> @@ -625,11 +625,15 @@ void amdgpu_xcp_cfg_sysfs_init(struct
>>> amdgpu_device *adev)
>>>       if (r)
>>>           goto err1;
>>>   -    r = amdgpu_xcp_get_res_info(xcp_cfg->xcp_mgr,
>>> xcp_cfg->xcp_mgr->mode, xcp_cfg);
>>> +    mode = (xcp_cfg->xcp_mgr->mode ==
>>> +        AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE) ?
>>> +               AMDGPU_SPX_PARTITION_MODE :
>>> +               xcp_cfg->xcp_mgr->mode;
>>
>> Shouldn't this depend on the memory partition mode as well? You must
>> have at least as many compute partitions as memory partitions because
>> each compute partition can only use a single memory partition.
> 
> This is not dependent on the current/active compute partition mode. It
> is to show the configuration (number of xccs, vcns, shared etc.)
> supported for a partition mode. SPX is the default partition mode at
> boot up. That is used as the default mode.
> 
> It's not a strict one-to-one, a compute partition may use other memory
> partitions also non-coherently.

I agree it's not 1:1. Multiple compute partitions can share a single memory partition. But there is no way for a compute partition to use multiple memory partitions, at least with compute APIs. Each partition exposes only one VRAM heap. Therefore I think the memory partition mode should influence the default compute partition mode. E.g. SPX can only work in NPS1 mode.

Regards,
  Felix

> 
> Thanks,
> Lijo
> 
>>
>> Regards,
>>   Felix
>>
>>
>>> +    r = amdgpu_xcp_get_res_info(xcp_cfg->xcp_mgr, mode, xcp_cfg);
>>>       if (r)
>>>           goto err1;
>>>   -    xcp_cfg->mode = xcp_cfg->xcp_mgr->mode;
>>> +    xcp_cfg->mode = mode;
>>>       for (i = 0; i < xcp_cfg->num_res; i++) {
>>>           xcp_res = &xcp_cfg->xcp_res[i];
>>>           rid = xcp_res->id;
