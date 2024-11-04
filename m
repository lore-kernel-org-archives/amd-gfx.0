Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA00D111A3
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 04:04:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDE4810E00D;
	Mon,  4 Nov 2024 04:04:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eO6UbJkm";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A3410E00D
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 04:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcVSjARvgAU73oTfa9eIVpjyqd5EoGilx+Q9INk0Kk1tVz+jGRD7IfxI63eCc8cPDuCxHmzikCZOEcPbcFXDQjY0d7cSfQR6jbcP2AHPxifhMbWqOJ+bYFIp0ylWUfaoXNk28/3yuqam5uqY47WDftPovxSD0CnMYHuIls0dGbVZ2NUJdXBTUEP1TcATiYbhO1cogPh+MTT+K3GSGPXnizgHKJJFes0yo+nh/gmVdtoE5KRxDUQ1nYndrJkaLPhOnD/g3rHKuaUomj/fx6bdfbet0wV4Ll1jUI6j54Xs1CtlcwUWhZobk5CvL9JHdpJTneFYWjo8uuk9T35KIlj7nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCkIg0Ai6JBeFkDqiawK6k+LHM41KIEUFrgGs8jylxM=;
 b=dx6hm/fRC99odvJ3F8Vlky8+GG8nliE+PuMUknr2G2KtPVlYU7kOJOdc1dMY90dZ0+nL3+alexwAuPFjsWfjrVJv3ZaPi9CAU21Z+M+DvxnaN9mVWcBFMvH3b+5s2MuS2JDXihXsEIN+YQvQZ7T9IQNBGqUNC1s7W15O2SOztCBzWdPQI6Bh460LzCE2LBZL/hLYlYk3+wd8+RAUntmVqZXVFJosQ/3Gb5hX7qW/RG4c6eQaXDrapRM70YoeTA8xcz3d8tjMT0fSWydWyl1t0WbXfffyBI9Mj6WDdmxP+mLwqhTyrDzoj6Jid1dMsIZ7RlFgKXOuD0qz9Uo5VHZjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCkIg0Ai6JBeFkDqiawK6k+LHM41KIEUFrgGs8jylxM=;
 b=eO6UbJkm+z9FRrkxcqOFaKFs/rWTkavbQ7GdQ/N79PBpzgsvMwKcWDv8/LnIJ61ddAy8anEEn9OpLOLmj4ZY1R5Zh8/cLTG2xIiPD4mFtDDD10BWkxbficXXG79Ei5x4vYTKIDCMiSn0ssuW77eL1ryYOE6MJWO4qXZKF1jsc9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 04:04:51 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 04:04:51 +0000
Subject: Re: [PATCH v1 1/9] drm/amdgpu: update vcn_v1 devcoredump on per
 instance basis
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241029135020.2494491-1-sunil.khatri@amd.com>
 <20241029135020.2494491-2-sunil.khatri@amd.com>
 <446d84ed-9a45-4125-8618-9a1ad3dea5f5@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <04d8f83c-8d14-78cc-c8ad-29a8a4234190@amd.com>
Date: Mon, 4 Nov 2024 09:34:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <446d84ed-9a45-4125-8618-9a1ad3dea5f5@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|IA0PR12MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d35144-0a2f-4f0d-1e03-08dcfc85d507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmNnRVlqd0pQZkVNSzNubThXR3FTMFI2V3U0VDVLYmVCRE9uS1RjTzRSaW1p?=
 =?utf-8?B?TTN2K1B3dkpxcDdaNDBiVGlqcVhPNkkwY3hxOGhiQUx6MzF3MU9JRWxCcm5o?=
 =?utf-8?B?RURldWRMWWNUWmYxVVRyY2lCMXVVK2R3YnVKeTcxVEN6WHRZbHZDSVZzcWlU?=
 =?utf-8?B?RDNWK0VpYlh4V3VadnQzbHBva09TaUFSUy9vckkyTHh2Q1h4OVZzNFBLNkRP?=
 =?utf-8?B?VU5HcEs3QkpxR3hxaHJqNXVDMXczazk4NGNqenhTOHdjYzMxWDRZN29jSWZm?=
 =?utf-8?B?b1JSdERCM1JydkN0RjZseW1pbU5zYVE1MnBlRWV3WFNpSGUxMGxQZDBpakNn?=
 =?utf-8?B?L0MvN2g2Z05YSi95YW9lSTR3TXpSL2x2Y0MwU3FvNVN0RUJSOHhnb0FJYU1h?=
 =?utf-8?B?azFNZm5NR2thOG8yNndJRmp4Y1JiSGlUOXNwSFZCUzRreWUzb2VvRktid2FJ?=
 =?utf-8?B?VUxGeHVncmk0dTBFanBRK0tKbWJqMlQ4WUxJL0tEcnNQanYyWCtXNDAzSWp2?=
 =?utf-8?B?RVA3eXV2TGdsYWM0c01WYmhmcnMvWW1Yc0JYSHE2aDlnSktkZmtkWDNibEtj?=
 =?utf-8?B?L2ovc3hTSDZPZmdlQytZeERzdmlBazlDOGt0L0k2d2pwaDdnUW9DcGZSVWtD?=
 =?utf-8?B?OFQzdlFJajYyY2ozTk9IOWlCYW1IdVd5QVNyQ2cwVHhBam1TQ0hISTZlemZZ?=
 =?utf-8?B?bHUzTUtPR0NvNlJVVTBpRVJmd2NjdXlBTitIZEZ5ajFMN1dJRXRLWjRxRGJs?=
 =?utf-8?B?SnZ6WWcrUVZrV1RBOHJpbGhqcG1xaWZJTzNCdGhuY2dyU2lWTHlHS0N0Y3dr?=
 =?utf-8?B?UzJYMExRUUFkMHYzN1pjZlhaSDBxeGg0VjA2VXpCWExYSGN3MzJCL0JPcGZv?=
 =?utf-8?B?enR4MEx5dEt1OW42dlEzdDNLRVROdk5aeExBMEJaSW9tRHVsVTMyOUtZbGlq?=
 =?utf-8?B?Q3RweEg3L0lxd0IzdHRSWnhUNEh6TW56QXdOY2xjUW5FKzhRMjJyeEpkWldm?=
 =?utf-8?B?SDFuRFpGbGc0U0VOckUrVWNRem9XbnVyWHA5SGZGUU5sdks4ZEs5N05SWHd1?=
 =?utf-8?B?YXBzR2VlL0FLeE5kUHFHUmRzTjY2ZGROU3JEMWRYSjR3TEZQVWJEK096STFu?=
 =?utf-8?B?Rm5WOHBFMGl2anZDZEErbDdJTTJTV21vSnhjb1pHQzlzSnpTT1RHZlNMWUFw?=
 =?utf-8?B?aTU4TjQ5T3N5NkdXa0VlTVQ3bVdGNXpWTFl4cDNKWkttOVIrdUJrN0JhU3py?=
 =?utf-8?B?ZVBJRVVrVk5EbDRkeWcvdDZTOHl0YVo1b1R0SG9vK3AzaEZwZ1hyLzlZWHYz?=
 =?utf-8?B?RnpIbmtQOGd4UVlxWDZ3RGsvbnVpWVhWSlUxZ3pWQ21yTmE0bkkxWWpQUTda?=
 =?utf-8?B?Q3hkU3FQSHJkcWdxQlpTRVBsUDBaVlBUMHF4dGNFUGQxeUNrYlU5bTgwRStV?=
 =?utf-8?B?SjliNkUyVDU1ZnVWUlZ2VTI2bE5nVkZPZDEwVDVESWI0VXdKNFEzY3FWMG9C?=
 =?utf-8?B?eGZ2VWFYaEdrY0QyWG1oOEhZUzhoWWpoaDVZSlBXZHVUTk94bGtrT2dIbDFK?=
 =?utf-8?B?QUlPYkcvZEZIZTE2UVlZdGJKMlE4eXlaS3NMRmVObzJzRWNMV0JRQzVVK2ds?=
 =?utf-8?B?OVhRVnFwc1BlRjEwcW56SllSUVZya0JJL2twVDVsck1DSXBOdElYMWZBNGQz?=
 =?utf-8?B?TklFWWNtc2xlWndhWHhEYnZLNUxFbDRqcUNaWHRTbEUwR2U3SWgxNVdFc0s1?=
 =?utf-8?Q?Gbu5gBfYpFckraC9qg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkd2QVNVdko2UmRaWWJoSjR0OTl6WkJTZVdLTE9pY1lLSjZQSHhnSkp3OFNx?=
 =?utf-8?B?UVlaT0pUTW52M0J5SnB4UGhwL1lXT0hqT0x0KzBacjNHZkp2Rkp5UGpoUHpw?=
 =?utf-8?B?MUVxekplOE8vcUJXV0tkb0hkaURzanMvRkVNU1dIcmtSSUFpS2h5LzdwMGdW?=
 =?utf-8?B?UldaUFY4TVpKZ1pLV3JPVlBQK2dsTWxzUWs0ZEh3VXVmRUFqU2JkMGN0ZUVP?=
 =?utf-8?B?YlRMRW5QbVFQQ3dmWnppb3RZL1hWTnNYNWtSRStpQXR2NUsvVm8wZzNFVkl1?=
 =?utf-8?B?TnIrMG9EOERHRXZiR0QwK0ZiQ2FQbytER1lyU3Z0TlpSRVB1bzkzMHByZmlW?=
 =?utf-8?B?bEtGb28yeVFoTlZQcHpVWUZsN1BQWGlXWG5NbVY2eUVXeWYxME5ieDZhT2ZM?=
 =?utf-8?B?NFRieWpqYzJpb3VQdVoydEZrQXYwNTZYZWRkNERuTEdSU2pUaTNSVkl5VDlB?=
 =?utf-8?B?emg3aTVhNnRvY1doNnI4VWFSM1dJZE5MK0JMNHRqWmMxRzVSc0FGdkhjZUgz?=
 =?utf-8?B?QVhHNWpiRWlxckJRaXBVb1B4WFFSdnhyZCt4emxXajYza2FQZVFTS2wvcTV1?=
 =?utf-8?B?ejJ1bStHeUNZdVlQNWNGTnBzK3k0MlA0TUszVjFWVXgyNEY3cmhkRTB5c0xR?=
 =?utf-8?B?OWFubndTUDRTS3dFTlJrTHFybzlZbnZDQUpyU2lCMUluL0ZHeUJWaFdzRXFV?=
 =?utf-8?B?Y2JPcGIzZm8zSStuanZZc1BWeXVjRXRMTks3OEFralBpQ2hXVndPQmhpS0M0?=
 =?utf-8?B?MDZpTlFEYVkvc2xlTzFRbVlNOTE2M1FzNG9UV0tUT0VPRHhxUzF0VTlrWUtZ?=
 =?utf-8?B?S1gyTCtodEttNDR2c21iSzFIQ1RoQkk4U1Qya1lsRzB6WU9tZ04vRnRIS1hH?=
 =?utf-8?B?YWJvcGdWTWpFOEpsUFkyZFhzWmF1SG5tL2dwZnlNUklPSzJ3VHh4YmJFTkJG?=
 =?utf-8?B?UTdxWXNMTlJEbDJIWEtFOUE0RkRjdzFvNDJVS1JyRzlRQWdyMWFtVVJwOHRR?=
 =?utf-8?B?OG9PeitUK0VnRHhCTkhZcHFtVFVpeXc3ZGxCMUwzdmNlTzY0bGh5anA0Rmly?=
 =?utf-8?B?TXNqYitIQWdSWUpYYlptdGRFL3M3UWdZQ3FMdFFkUjdveVFhN2pBeVoreEpR?=
 =?utf-8?B?QW1YcFBqVCtETmxSUmg5cnpzaDFsODZhbVpZZ2NrZzFObVFSWVV6S2daMFBN?=
 =?utf-8?B?cWt0WmFJMVV5c2pGeFh5SnBqOHJwSk4yd3A5R2FEeFNIUXB0VzM0c3U5MzRy?=
 =?utf-8?B?c3piUndidmdpRi8ydmgwcEpYUmR1S0FUaTQzZGxSS1B0c29oWWhWYjNkbzZ5?=
 =?utf-8?B?aUpOemZsbm0zbHdBUjZDY1NYanl2clJKU0FhZm03eXZnVHlDd21xTmVMM2ky?=
 =?utf-8?B?NDlwWTV1RHY1eGRWQm85Vlc2aEV2eGx4ODE2TENNVEQ4MFliL2ZLektyS1Fq?=
 =?utf-8?B?d1hHcE9UdWdaMnJibWoyZ0lTamwvbWo3TGErN1EyWGU0ajBGc25VUVpINHdP?=
 =?utf-8?B?MkJ0cXcwTlZOblk3SmxnblhOU0hqTHRsTmdUNTBUQXNQbWs0K2NSME1aRndz?=
 =?utf-8?B?K29IWlhxcnhGR1lUWVI0OXBqSnl6aDdSVXN0UnlYbEM0Z3NqRFVtTUMrNGVV?=
 =?utf-8?B?WnYrclBRS1pUcHc1QzhWOWJ1dGZQK3NmOUp5eWh1NUFwOUQvdExjRjdyVVhv?=
 =?utf-8?B?SEx4ajNWR0hobGxNMVRXWVVpczFSMEJ1d09iK25OZks4cW05YXY0NUFweG5D?=
 =?utf-8?B?UnNRWEFReUpYRE9ncFZ3UkI1UEZwV0tDb0ZhcEdCcHlxY1VZQlpMeXF5bTF6?=
 =?utf-8?B?clZhcFNPTVdIdlozblpXYUgyNjFNZlFoUm9iRGJQbkUrcys3NGFwNG92aTB6?=
 =?utf-8?B?V1g5RVRTSWtFWVVVaEVqbmNVckhFVE5SMFhkNTJkUDI3OHZvYWtpSitDWVZB?=
 =?utf-8?B?YlVXUC8rZVh1bWU5MnYwb1FoWUxpbTRWZzBxcHFzTURDcCtxSXc4ckkraXpN?=
 =?utf-8?B?ZGR2OFY3YmdlamNKR3liU3FGQzVZeWRjc21hU0VSOUwzRVJ2MUgwYmxWeU14?=
 =?utf-8?B?b0FyaE5RTWFrK1AwSmU0Sjh5M2RVMXB2eTZ2VVFvRGdGVWlVSFUyREhadzZm?=
 =?utf-8?Q?z+YH79TQoST/D3r7IyHveXdxb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d35144-0a2f-4f0d-1e03-08dcfc85d507
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5776.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 04:04:51.6208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZIGtnbUDMcDuXZ25xurmOfJzZkK39HWCIBBTnrNvZ5OWHbYVoyNZw5R346DyDix0RA9GFrJPOge/aKit+i7oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256
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

On 10/31/2024 3:16 PM, Christian König wrote:
> Am 29.10.24 um 14:50 schrieb Sunil Khatri:
>> vcn code is restructured for per instance basis. Each
>> vcn instance is represented by an ip_block and hence a
>> need to update the dump and print functions for each
>> instance as an IP.
>>
>> Existing way was to capture the ip dump for each instance
>> in a same memory dump but now each ip_block of vcn is an
>> independent one and its memory is independent and handled
>> within the ip_block now.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  2 +
>>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 77 +++++++++++++--------------
>>   2 files changed, 39 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index d4c8cc3c1730..ef564ddcfcbb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -392,6 +392,8 @@ struct amdgpu_ip_block {
>>       const struct amdgpu_ip_block_version *version;
>>       struct amdgpu_device *adev;
>>       unsigned int instance;
>> +    /* IP reg dump */
>
> That comment could be improved, something like "Memory to dump IP 
> registers and state in GPU reset handling".
> Sure will update the commit message as you suggested.
>
> Apart from that feel free to add Reviewed-by: Christian König 
> <christian.koenig@amd.com> to the patch.
>
> Regards,
> Christian.
>
>> +    uint32_t *ip_dump;
>>   };
>>     int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> index 7638ddeccec7..f31fdd620c86 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>> @@ -203,12 +203,12 @@ static int vcn_v1_0_sw_init(struct 
>> amdgpu_ip_block *ip_block)
>>       r = jpeg_v1_0_sw_init(ip_block);
>>         /* Allocate memory for VCN IP Dump buffer */
>> -    ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, 
>> sizeof(uint32_t), GFP_KERNEL);
>> +    ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
>>       if (!ptr) {
>>           DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
>> -        adev->vcn.ip_dump = NULL;
>> +        ip_block->ip_dump = NULL;
>>       } else {
>> -        adev->vcn.ip_dump = ptr;
>> +        ip_block->ip_dump = ptr;
>>       }
>>       return r;
>>   }
>> @@ -234,7 +234,7 @@ static int vcn_v1_0_sw_fini(struct 
>> amdgpu_ip_block *ip_block)
>>         r = amdgpu_vcn_sw_fini(adev, inst);
>>   -    kfree(adev->vcn.ip_dump);
>> +    kfree(ip_block->ip_dump);
>>         return r;
>>   }
>> @@ -1933,61 +1933,58 @@ void vcn_v1_0_ring_end_use(struct amdgpu_ring 
>> *ring)
>>   static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block 
>> *ip_block, struct drm_printer *p)
>>   {
>>       struct amdgpu_device *adev = ip_block->adev;
>> -    int i, j;
>> +    int i;
>>       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
>> -    uint32_t inst_off, is_powered;
>> +    uint32_t is_powered;
>> +    int inst = ip_block->instance;
>>   -    if (!adev->vcn.ip_dump)
>> +    if (!ip_block->ip_dump)
>>           return;
>>   -    drm_printf(p, "num_instances:%d\n", adev->vcn.num_vcn_inst);
>> -    for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>> -        if (adev->vcn.harvest_config & (1 << i)) {
>> -            drm_printf(p, "\nHarvested Instance:VCN%d Skipping 
>> dump\n", i);
>> -            continue;
>> -        }
>> +    drm_printf(p, "Instance no:VCN%d\n", inst);
>>   -        inst_off = i * reg_count;
>> -        is_powered = (adev->vcn.ip_dump[inst_off] &
>> -                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>> +    if (adev->vcn.harvest_config & (1 << inst)) {
>> +        drm_printf(p, "\nHarvested Instance:VCN%d Skipping dump\n", 
>> inst);
>> +        return;
>> +    }
>>   -        if (is_powered) {
>> -            drm_printf(p, "\nActive Instance:VCN%d\n", i);
>> -            for (j = 0; j < reg_count; j++)
>> -                drm_printf(p, "%-50s \t 0x%08x\n", 
>> vcn_reg_list_1_0[j].reg_name,
>> -                       adev->vcn.ip_dump[inst_off + j]);
>> -        } else {
>> -            drm_printf(p, "\nInactive Instance:VCN%d\n", i);
>> -        }
>> +    is_powered = (ip_block->ip_dump[0] &
>> +              UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>> +
>> +    if (is_powered) {
>> +        drm_printf(p, "\nActive Instance:VCN%d\n", inst);
>> +        for (i = 0; i < reg_count; i++)
>> +            drm_printf(p, "%-50s \t 0x%08x\n",
>> +                   vcn_reg_list_1_0[i].reg_name,
>> +                   ip_block->ip_dump[i]);
>> +    } else {
>> +        drm_printf(p, "\nInactive Instance:VCN%d\n", inst);
>>       }
>>   }
>>     static void vcn_v1_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
>>   {
>>       struct amdgpu_device *adev = ip_block->adev;
>> -    int i, j;
>> +    int i;
>> +    int inst = ip_block->instance;
>>       bool is_powered;
>> -    uint32_t inst_off;
>>       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_1_0);
>>   -    if (!adev->vcn.ip_dump)
>> +    if (!ip_block->ip_dump)
>>           return;
>>   -    for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>> -        if (adev->vcn.harvest_config & (1 << i))
>> -            continue;
>> +    if (adev->vcn.harvest_config & (1 << inst))
>> +        return;
>>   -        inst_off = i * reg_count;
>> -        /* mmUVD_POWER_STATUS is always readable and is first 
>> element of the array */
>> -        adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, 
>> mmUVD_POWER_STATUS);
>> -        is_powered = (adev->vcn.ip_dump[inst_off] &
>> -                UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>> +    /* mmUVD_POWER_STATUS is always readable and is first element of 
>> the array */
>> +    ip_block->ip_dump[0] = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
>> +    is_powered = (ip_block->ip_dump[0] &
>> +              UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>>   -        if (is_powered)
>> -            for (j = 1; j < reg_count; j++)
>> -                adev->vcn.ip_dump[inst_off + j] =
>> - RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[j], i));
>> -    }
>> +    if (is_powered)
>> +        for (i = 1; i < reg_count; i++)
>> +            ip_block->ip_dump[i] =
>> + RREG32(SOC15_REG_ENTRY_OFFSET_INST(vcn_reg_list_1_0[i], inst));
>>   }
>>     static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
>
