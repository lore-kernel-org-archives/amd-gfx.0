Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838B9C7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 14:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB0C10E028;
	Mon, 23 Jun 2025 14:35:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B99lfV32";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFCE110E028
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 14:35:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcggR1vhTqKq2cEX/3pc6y6soqwxjzogklAlRdX60uJUrMTmVGJBRr++wzSn0L6ojn7wmHHUkrF7PJNNrxf0i1hY9HhWIOiHf20OU1wy3M8hMreVvF0XFK05B7eTcdK7/knDUlDRVkRimONMusdiLQ5N4S3NM9rP08d3cD4jcRfHV/wgucpjsyilZDulrNCMOKLwWRvuSRCBAVXyfY1rcuZ+KZ6oydbQssV79eE3iFxMTyiTFo7sMywKBkYjX5S/bHvKc1QAcSootJPv3onC7f/WepRPPxYO2gFor/vkXSN9p0yaNBiSsxhmbxxHEAiswB2gb4/vwREiZUq/FKz/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diviGg7lsOT+ONCIMTC4BbxXzWmVckVQtMSE0N9UbFQ=;
 b=E+t9PJVX1NZNMemRTgNrgpw01wFVEnjSlWTN25MEXh/xmM18zUstjZDQ0cU61aqfp+4UlyxAsD5qXb5POR9aWNU75vtn5Gyz75z8N2Aets0zOfA1JNzaHSWcnwch+C04S/2uvxqrmecaexW4FKZaJlZ7+4lwRG3DMIHSs4nBm1dmHdL+YSTcfYxzlmMlgxGxdw4VClMUqbwKTQ8VwfiRcKE+tzOSdkWuEohIBaYdZgAc1m2w0vf+pz5elTjgp8rTWyD2FrkFU1YwukGHrdU679anesfKB6Op6t5UadSceIlEzJNF16PrVfTZjjz4lQCdKeNUekUCaYk/b8+GPQaEjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diviGg7lsOT+ONCIMTC4BbxXzWmVckVQtMSE0N9UbFQ=;
 b=B99lfV321BxVd986oeNX8sSAq0JYcIFcrnLZD4ankJLqEpcTJ5INSvVAbB7CwBC3xiY91LeCquw2VznLXI5jyU/NLmfYMxjsxRQ+dxZEiNatZMB7pAlEPEnW8Ppq06z/gCDPxlAS0JH4t4+bXXsSNiC3LwvpFUZCqbn166kY4ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 14:35:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:35:03 +0000
Message-ID: <4739df47-fb92-4e71-83e3-389ffc22edeb@amd.com>
Date: Mon, 23 Jun 2025 16:34:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix slab-use-after-free in
 amdgpu_userq_mgr_fini+0x70c
To: Alex Deucher <alexdeucher@gmail.com>, vitaly.prosyak@amd.com
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
References: <20250619013206.123183-1-vitaly.prosyak@amd.com>
 <CADnq5_NKTTXcEuZANmsS=E6gcLeX11P5CMT5bQnF0p-5XaLqYw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_NKTTXcEuZANmsS=E6gcLeX11P5CMT5bQnF0p-5XaLqYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:207:3c::39) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 677f24e0-9398-4f3c-4553-08ddb2632438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlowcjkwK2U5cTZ3ZG9kT0FUVGp4cFRyWjdUTmxta2g1Q3d1UHk5MFNYVklZ?=
 =?utf-8?B?cEJ1NUhqMTdKTU5ZR2xUVlNMSEp5UFNNanA1UmwrU0JDaWdWKzBjcEoxZWRO?=
 =?utf-8?B?b04zbWQ0bjdPbFRPeVcwSTJkd3FBNjRPWUozd1FIMzFrMG9RSVdqUVhyUTN2?=
 =?utf-8?B?VENUL2V3Nnl2WWFGN2VrNlUxSVZhdVNaNTQzQTdhTjNsRE9hSDNzblpZOE11?=
 =?utf-8?B?L0xHUU01UWhpTEZzU0FoQ05MdkxlVEorNXhQV0pqTWd3Q3kveDNNQjlBcWtB?=
 =?utf-8?B?QTdtN0l4WUpnRlRMdm84K3BMaHlaT0NnWERFL2ZxVldPWWIwcHppbGlydGdl?=
 =?utf-8?B?d2FDWVVDcHd1UnR1VEhmUWRNa0hTQW9CVHFjMXM2eEszbnlmL1dVejd3eXNX?=
 =?utf-8?B?RXphWi90RGVhRXhtbm1TUlNwZkpyYkd5SWxwVjhJQjFXa1BDM1NjMXJmSWdS?=
 =?utf-8?B?dVcyKzExWTJjb084QjdQZUVFM2dtUE9pYXdSZnJmNytnMWVnNkdQQko3ekl4?=
 =?utf-8?B?MDlkSHcwU3d0OXNoYmtFMlVUaTdsTFJIWndCTUthaERyQjFZa1dOTjExM1hX?=
 =?utf-8?B?TnQ3MmhHWkRrcnpuWFhZMTd5dVM0N1lHckZ2VHlSYW44OUt3dU1lQnFUclZq?=
 =?utf-8?B?RUlRMjNHRlBUQTRCNm16YkFHQkF3WDFQMGUzallMMUJieHdyczBZSUlwVXNI?=
 =?utf-8?B?MUYrR3hOeEtuN04wa1FWYnRCTUsrNFl6QmVkUkhxL2J6MWhJWXQxZVRFSHdu?=
 =?utf-8?B?WkN4Ly8zaEtROFFQNlV2RVJHSmFTU2Z6djd5SkhTMHUvanlBeVZKSm5yUUV5?=
 =?utf-8?B?bVBVc2tiNzM1RGZWZFVZU0VPODN2NjF1TGFLZUZXRXZEK2phTmt3QWRYWWdM?=
 =?utf-8?B?VkZNQXVPdVpRVnBKdVFIcjkzS2MvRTVtalpzR2VTOEhvcG1ZVWxlS1lieDBP?=
 =?utf-8?B?ZVdDSzVmOFpORmpXNk12WlNUT0Y3eTNwamtmUGJHMXBOK2ZvTDVZc1lLWW5s?=
 =?utf-8?B?NmZ3bUhaMUxudWx4RE5wU0lpbVRsa3FqanhvZGFVcTMwTDJrUlZzK0gwdERY?=
 =?utf-8?B?blVaaGs5bis3YkFYVkdYVDY3NXlFWjlvWTc3Q2FRK0JOakpEQmVKWFloaVlF?=
 =?utf-8?B?dWg1SlVLMmkvUk4vZWg0SGdDSFJJUkFENHlKTjVyakVHWUZ4bHdzV1FiQnhB?=
 =?utf-8?B?K1hTcDUvQjdjVmMwNkxzZVhDcXVsNE9jdTZRMkFhZjhFRzBodnFBTmpTMFhF?=
 =?utf-8?B?aGRsRVFURWFqQnl6Q0EzTmxiazRwM1U1Y3VYNGpHMG81Um90UHNwMFRyOCtH?=
 =?utf-8?B?Y0dGQU9LQzRocWpObXp3N2F3SWozbm1NcEZ1L1p4ZVVHNTdrbW5WQ21hSlRu?=
 =?utf-8?B?SEZQdGJMNWordVd4Nys1YW9xVG5rQUxwbnhoZWRoUHk3NWVmWXFpdnI2OG1j?=
 =?utf-8?B?MWNuakl1aSt6bzhqQ2RqZk8rY2lFcEREN2FNcVJCNXUvMnYyejZxdmtRL1BH?=
 =?utf-8?B?ejlNeEJYdm9yTXJZYXpMYWRyVVlOaEs4NW4xWjhhRi9aRjMzOS9KU1RjbFlO?=
 =?utf-8?B?bjArNzJhNWROczJzQ0tiRTltVkc4SFovQWlwR05QSFdBbWdjRzRsSENaMXRV?=
 =?utf-8?B?UUFMOUdYa1JIbVhoUGplWmpaSkllM0F1dVJMTVY3ZEFsbWRKb2hiRGJBQXdM?=
 =?utf-8?B?djcwSVFXYnEwb05BajVuVFNIbzgzcDljMHlpM29yTXdNc2dzOXZFbHd2L3U2?=
 =?utf-8?B?dWRKa214ZTc3YitucmhRaXRpKzQvazNuUVNYaTNzOVFvbE5ET0kzYUtnMzF6?=
 =?utf-8?B?WTZMZW1KUWRZdW9qdm1ESGs5YUNQbWRmYmhubHltN01acFR6c3NTQjdhbWZK?=
 =?utf-8?B?NjRLT0U1R3hLSnIwSVRQV1cxekZNOSt3UFZyTUVQZ1djQ2UwbUtRZHc5cUFS?=
 =?utf-8?Q?jEEMPLl6kBM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yjc1VTkybGkrcVc1TEp2Nm9YYkpTaDMveW0vSFdLcDYrODduSmU1cDY0cnhE?=
 =?utf-8?B?RnRZeFRjTlNKVTg3Z2E0eFg3bnVOOUdFSTFYU0I5b2xFWU16UjhqWUsyN040?=
 =?utf-8?B?T3VjYXBLVkZaWVFiRHB0ZmNtOU9mUjB2WFBDdkUveUs3MkNMU3ZxbFEvdmhx?=
 =?utf-8?B?QmRoUHZrSUN4eE8yMEZlVnM0UmVZc28wWEFVQ3dtZVF0NmkwTFMwV1RiaExn?=
 =?utf-8?B?N0RtRFdaWnFueGxvZk1CbkJ5ZkVmQXdwVHpVSStLR3lUV0RDSlkycGQrdmpq?=
 =?utf-8?B?Rks1bTYvUmFTTlB1WGp4NnJJeXFLMm5icDdrOWYvb2E5anl0MXI3LzZDdUFk?=
 =?utf-8?B?UmF1c3dMcHAvQ2FiWEJabGUrTkwyYlU2bzh1UUh4TEpPYUFtK3BFTEJySmJM?=
 =?utf-8?B?YU9pNW5ydTY1K2dkb2hVTXREdHcvbE1relJQZDRFdG9zZ1VqUDdGczlITXJm?=
 =?utf-8?B?dXBXUkp2dWJNQy9nT3NwRCtBNTl1UlpTZ3JmYmk0K2wzUzhYK0JUTVlYTHdz?=
 =?utf-8?B?UjJMVzNabkkvMG1SUytyYkp2S1ZEbitNYjZPMTN5VUcyZGsxYlhtTVE5OHlF?=
 =?utf-8?B?YXJsT3lkb2NKWWxsdzluVDBrUXhwRWxtZGRwSmt0dFlRVWtVUkMxRXFJTk8v?=
 =?utf-8?B?YUpaSkx0MU1qYkEwaEFiS3ZtRGRlWnRlQUhQZUt3Um81VW90RGsxTE5pTmk0?=
 =?utf-8?B?MjZOdUpYczJLSTJ4TU9GUVc5OG52NW02ZDF2Zy9OTTd4UGdrdnVvTVZWT3ha?=
 =?utf-8?B?QTU1R01GSFEzZmh6VHhhMkxvSW9BeS9CY09idHZ4YVlmWXVGbXBaRnp6WmdH?=
 =?utf-8?B?WFVNMG5Wd2Q0SjY1RUxMcG5aTzMzbHh2b0V0MnA2UjVUeHpQM3gvMVlwd1hz?=
 =?utf-8?B?Y1lJSHNpVFBaMjZpZDVtL2VDa3VWa09DTHVsNFhHeDJYR0tiZk1jcG9WWnZC?=
 =?utf-8?B?SWhoWTBHaEU4MGtkNDBjSzVQQzZIRmxJbkVNVkNtNnVNekQzeGR3ZWFQdWNT?=
 =?utf-8?B?L0FKU01SMGh2SDFRRnNDOXYrWUloaW81T0MrYlN6bXY3YjRYMFFiQ0dFMk5G?=
 =?utf-8?B?L25Sa1lseXZXUStxeXpkcFcwaXBrZmt0andPRWl0UHB6MG9vMFNQWS8xNXAr?=
 =?utf-8?B?UWxrY0hyOG5EYjc3RHJkbm5ndDR4cTBiUGtMS0MrTlhET05haE13cXVKZ3RS?=
 =?utf-8?B?K0VYOVhqeS9Ob1NwNUtGbGZISmx1bjNPT2tWU3JxandkUFlCUnUwbHlaQTUr?=
 =?utf-8?B?WE1JQWZLbkNiUWRGWHVsT2VPSmxEeS8vWmVuMGxoMnRVNzk4V2F3aTlXSTJX?=
 =?utf-8?B?U0ZPVTFyU3Vubm1PR2RGWUdOQVAxT2RjUy9kM0luemZ2T0lHdUE3eG1wdVdD?=
 =?utf-8?B?cHBwdTZWN1lYRDJiRlc5R2ZRTDluWU5DNlM4T05ZbHFVeXZBS0FmdDBYbDJ5?=
 =?utf-8?B?c3Q4cXBlLzkyMzNZaEF5RDUvTERRSFRlSERFTCt1bGNGS2hkUmg3YmUyMDNm?=
 =?utf-8?B?MGFqbHFRYVJaWndBTlZhRGxYZVg5L1dYSzgwYkRmRGNCd3JnMURjRGduUzAv?=
 =?utf-8?B?V0VtUzgzNjJxTllDSndiVmJwb3kwRjhybWNCa3Y5a3gyTmk4YW9OOFpuLzFI?=
 =?utf-8?B?RThaTXRPZTd3NWFaaldxVjhUNTlLR1ZnZ0hZK2FyVGs0R3NYeEZ1dXNLZEUx?=
 =?utf-8?B?eTJjUldlZ01JT1BZeHFDblZVYWdES2J6ZVZkSTg1YXppeFcvcE9hUVpKWnQ0?=
 =?utf-8?B?cDFpcTRnUm41UmxZRFVEeHdjU3NnbnFUUnpYNjFIOHhVekdxWlRjb0hGWkxM?=
 =?utf-8?B?dkdsc1k1UWhqS2FjQmkwM2plY3krcGNCZHhYMlhsTHg3eFRHK1BOZlNiL1c2?=
 =?utf-8?B?MENJVDlFZm1tMlV6L252TDlGeFcrcEtZN1F2aEJmanJrUGpvc2ZZNHh2VnZY?=
 =?utf-8?B?b0VKWVVYUitHN1VteDBSMXVRTHVPWi9teDIxS0hOaVRBQVpsSW45WW4vdFI0?=
 =?utf-8?B?cEJmNFlOUmlZSGROam5iOVRGV2pDUS81YWZaSEM2eUgxRzlPa1pteWdCMFk3?=
 =?utf-8?B?NEdMbWlQTkdMcFdYZmgvT2RtMWJhbGlZRkVaZE5yVGhOWGkwc3ZUNlBvOXpm?=
 =?utf-8?Q?MIY406LQ/wLvRbvXhJMASmklB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677f24e0-9398-4f3c-4553-08ddb2632438
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:35:03.7555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMZfgSAzf2BJbJt1JDCRwkqVs8bS5G9i/1MLcg7/P+8bJKdolUMANKYxC8NSIECs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
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

On 19.06.25 04:26, Alex Deucher wrote:
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +++---------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  3 +++
>>  2 files changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 7fd233f160bf..204178d949e1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2914,16 +2914,10 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>>
>>  static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>>  {
>> -       struct drm_file *file_priv = filp->private_data;
>> -       struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>> -
>> -       if (fpriv) {
>> -               fpriv->evf_mgr.fd_closing = true;
>> -               amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>> -               amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>> -       }
>> +       int r;
>>
>> -       return drm_release(inode, filp);
>> +       r = drm_release(inode, filp);
>> +       return r;
>>  }
> 
> You can just drop amdgpu_drm_release() altogether and just assign
> drm_release() as the callback directly.

Stop, that change here is just broken.

We need to call amdgpu_userq_mgr_fini() before drm_release() since the later will release all BOs and so eventually also the ring buffer of the user queues.

Regards,
Christian.

> 
> Alex
> 
>>
>>  long amdgpu_drm_ioctl(struct file *filp,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index d2ce7d86dbc8..195ed81d39ff 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1501,6 +1501,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>                 amdgpu_vm_bo_del(adev, fpriv->prt_va);
>>                 amdgpu_bo_unreserve(pd);
>>         }
>> +       fpriv->evf_mgr.fd_closing = true;
>> +       amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>> +       amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>
>>         amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>         amdgpu_vm_fini(adev, &fpriv->vm);
>> --
>> 2.34.1
>>

