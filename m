Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1062C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 13:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B79611A471;
	Thu, 25 Apr 2024 13:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zTlC3A16";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCA0911A471
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 13:30:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhhCBLTiE5mtN7JUf6fSQ3RikFNPijSQ0zmszhi4zSCrgNTlhJ7chak0Nw+OY/IN1BB6qYEc3WQ2H2BB/gen+7l0gMaKrvBI8jVCVUGmg3jYmiQiyfjZSvY1xkLcqh+4ZW2zrr5KIG3BBHgWMNAIMgJSl48MffEo0Zf/SQg0/Qo6G0skgUcQjHUu1P0VZSZ6ZyRG5SPaujHtHopBDEyT8OkZ143gzGDuYU0I3n1FQC+uT+BzjNC4xjEL0ktK+yZU5D1LM+9GyiJPrazZrWSGpZWh22rTd729jijaynXiil1sa4Jrxy8WXSbIlnCgWBB0YZimE6/OVXYWNRN9W7ze3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5omedhwodXht9p0NAnn8nc8mGwCRIzW2fp5KkYOiX4=;
 b=AOcbeL7ysVg3D0pZlmnAgGpHkEYHBaRlAeKjLv2yT9aX+QTcpfKp0h8bRJ4/qmRD0A/xm96wCfGkwHQGjiE4QU5RwomsLavGKPXAUbru5BHapI48TNBRHboM6fiMb4SNYUmHp4ULR9LdP2UbhySaurKGHIrxX8GnkorueMY8aTJUChNTIwsSlj76haEszXn4oLSaQzguIJgqvgOPEpi5glTciRS7H2wyCagRR40DY2H/79EObAEcoQPX61zQcB6JVUBOGr5+ZA0leCu50gQXPIh46UM23ZGOIyQSMT7blJiVB86D8uNUdT24na+HdXx9HaID22knlfjvuiOwDgDEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5omedhwodXht9p0NAnn8nc8mGwCRIzW2fp5KkYOiX4=;
 b=zTlC3A16NfLe9ie54KLpcgLHPK9wxB14cQD6PAeehQelQm1gNGSNVKB/WFBSPGzV6F1qS+NzPhXjGCkXb9Quyml2PWQAQUizzlu/Jw8jlH//594Ctuly0EEfPkZffBWwT3jBa2hNNHEnmaYNM7SWZp7ek8X9lQSTs2j3BBA+7fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Thu, 25 Apr 2024 13:30:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 13:30:48 +0000
Message-ID: <b06a0402-8ee4-4b6b-b9e8-1b45a957d143@amd.com>
Date: Thu, 25 Apr 2024 15:30:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: fix overflowed array index read warning
To: Alex Deucher <alexdeucher@gmail.com>, Tim Huang <tim.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
References: <20240425070226.1315866-1-tim.huang@amd.com>
 <CADnq5_MY_dT=OMffMO8wXuiTUdnMYA1r2W7R-+HDXNeODMoibA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_MY_dT=OMffMO8wXuiTUdnMYA1r2W7R-+HDXNeODMoibA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c4d656-dc26-418c-2dcd-08dc652beb5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aCtmUkJRTkgyYWp6UmRPSTcyb0oxZVNZdDJURGVvOEJ0VlFhV2RrVGtaSUhT?=
 =?utf-8?B?ZTg0Vk1IRE45SDIvMWpTa1BEUktuRXhGUUQ0RTFNTUNUNDdxUVdabXlsN0Yv?=
 =?utf-8?B?aXZRbVUyN1ByZlJrT3lPZEt3cE8weFRSRWJ5NW1xRTlMSmZiUUViZGk3ZnVs?=
 =?utf-8?B?Q0dkUVNEQTk5TnVuV3QwazdTS0xrNG8wcXNuemNBb2pVakovU001NHc3cjhG?=
 =?utf-8?B?Q2FZdDJpQmRqZU1tUFFHSkliNHNQRE1uNmtvTm85bXRIZFlGeXp5YngrQll4?=
 =?utf-8?B?RjBsQjFiaWh4eXMwcmVRWFhKQnppd0pFSUpJRy9wTnpKcTZXNm4vdmhxZWp1?=
 =?utf-8?B?VVlNN0NWUG1kSTRFNGxNMXcyTGJtUno3dStiNkxnRGx5Z2F6Q3ZaaW1FaFBs?=
 =?utf-8?B?YUYxUjlEcHJqRXNwREgxbWlsck1nMGJ1YzV2MGJzSWVmN1JRdTA4WEdsdmk0?=
 =?utf-8?B?M1NJbzhqeld4ejBzS3p3b1U4QTN4dEMxeDgrbUdWdnlLajVLVVJYV0w2NXR1?=
 =?utf-8?B?SW42Uy9pUkVwUjhiZFpkYmJFS3JrVFg3NUxNbFpJMy9ydExxdU5BSDFlSmQz?=
 =?utf-8?B?V1hpRDhsaDhTd2hyQUh6QnFOMDlUNkloWVE2NGE4VTYvY2xLVWRtbktZQXNn?=
 =?utf-8?B?UUxYZlJyamtjUlExYUIvaDl2dkJuQ2tnaVUrVkM5NVFDc0M3SnFpYWZCS0V2?=
 =?utf-8?B?TWVxQnB5YjQxbHBBTjRlbSs2ekJLT0lrUlhOKy9WS3VLSGJndUNxSnAwcGJh?=
 =?utf-8?B?bFFzQjEzRW1hajZTbTdIZFBMQkNxZXhaRkZRYlg3L09aZ1BRUUg5eWlPKzFu?=
 =?utf-8?B?QnNDV0UxUmJzOUc4RXV2VnZKWEJuc056Skk5NGl4T1NUclNUQ0h5TXBCT3lj?=
 =?utf-8?B?MERXODUrRVdrdEtoMWR2bjFSN21Gc0JKMUtPcDJTN25DY3JlUGZDWEk0ZVJQ?=
 =?utf-8?B?b2tjbkUzd3FxVGhrYUdRYlY2RVV0bHlQUlNLeHNGM3QwMi83RnNhODdVa3FU?=
 =?utf-8?B?NDBkTlQwMGc5cUw2bXIyOC9aUE5uQWdhY21uNmdsQVduUzJZT3pTZlFnSXZE?=
 =?utf-8?B?eFJPQXhWRWphY1cwMndNeGpEV1JSNUpQZXU5b25UeTNYWkxUZlRkNWVGVWNK?=
 =?utf-8?B?a3ZFNU5ZVW1GME5sNjJlQUJLYmdSVFVpVVJsN1NxZGRxOGRvc2ZHYjhuR2RL?=
 =?utf-8?B?eXZpbHBQNVJINmI0YVVQL3p1eFhFNmZMekp5OVllK2pkTEZvVnpPMTRMSEp0?=
 =?utf-8?B?NXVnT0JPeWpaY1R0bDBPQ1lldWdocWxoOGtVaUVQV0FkcC90NkhzVjduTjZO?=
 =?utf-8?B?V1l6eE85UG8xbmZDWUZmVlByZTdjSUlKY21UaXlRbmg3bG50MGxlaXhRZzUz?=
 =?utf-8?B?Tk9yWnRMN1dPT2NZQlA3WGdhWDlKTjc3d0xxSlhSNDRSb05BSGUzWVd2Nk53?=
 =?utf-8?B?QW5RMFdxbWhrYm1paEtmRmxtVkV2eGZWbW9VMmlKelhJWUFoTXYwUG5WQWhq?=
 =?utf-8?B?bThnSDRVYkZ4Wm14L1BweDEvWlQ2NnpxRm5id2hrbnhteEpxV1dJUjRFUU5u?=
 =?utf-8?B?RG9wYkFubER2Q29ETjkyTFViQ09tekpId2YrNU1acGsrem9OZ3BQdnc5akRh?=
 =?utf-8?B?MWFHWGpqN2JMOW5OcWpWdXpWSlNzOURrcS82TGw0TWwrZER4Mko3ZXB0MElR?=
 =?utf-8?B?NFVHZXZDZlpzZXR6VmZKcWsyUkRjd1BweDdibUQyZDZ1WXBPRnYzNHhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVUwb3Zabm0yajFGdmhHaVU1WUpRb3JtalhpVGFtdUlQaWdMVnBQRXVRVlpo?=
 =?utf-8?B?NFlIYTQ4UDBCUlcweHBHNmdRNjF6dlExT0xwbmVUUUlzVEhUSjl5bHEzdkZt?=
 =?utf-8?B?SzZ4YVAxSlZWY0ZFbVVMMG13MUJHbEQ0TkdNQWpYNE5XdFJNRkNGQXZ1d1pV?=
 =?utf-8?B?c1N0V3hEUGVqTWNxUkNjR0xqY0d0bTBIWHJGa3NUN1hkbDY3RUs1YkgwMDlO?=
 =?utf-8?B?OWVhTEpsd0oyZVF5alBrL29vdDkrL0d3NEp3SGV5M3VJVW82ZmkyN2dObnhI?=
 =?utf-8?B?N2JWcGFWQloyMnZ4UlRONmJ6cjA0M3JCM29lSkpVUDBIcnZnSWVHVUdqREZu?=
 =?utf-8?B?TTYxRTFPZTBkYkZuNVlsZTEyQTRwNGFsVjdrKy9CSjRvRlp6SldxYmR4bS9S?=
 =?utf-8?B?eEIzSjkxWk56Tk53b0REcUVza1lyS1g1bE9tNWp2QlhqWkxuZGpXeDFjbDJI?=
 =?utf-8?B?QzhmTHRTUGt5MG54Um1zQ3ZxQlVQcytXSUwxZzFBWEpwT1gyYU8zS1JxMkZY?=
 =?utf-8?B?M1NkaUFvOVhlaUxIVGFuVnUzblU0RGdvSzU4QnEwR0VBM1YrclA3SzhmQytp?=
 =?utf-8?B?dzNRZHo0bGxmMjVXVkJWZktGU2dtNzZCZFp3UE5rQmhRL0Nvckc3TTZSaVVX?=
 =?utf-8?B?c05yeWpmbEk4TzVPQTNlTEsxSmRWelV3VlpqalhBdXBlTHNvOGZKclZjOGor?=
 =?utf-8?B?SnVWYWE5aWVYV05BdGVHai9WMEpHc3Z1K2s0UW9oR1FrclVwcnJzQ09RWTRO?=
 =?utf-8?B?UERYcnJzS2J0RHhrN1VTazJjdVltcDNhQWY2WnFrV01nS1pqUG1MZjgxL1Bs?=
 =?utf-8?B?NDNqMHJMOE5KLytxOVpkSWY5ZGVZWFExMkcrUFpuUWZDOTFaMUt4N0gzdEpB?=
 =?utf-8?B?VGNjbjNMVklnYUUrTi85bllwZDFlVkszcS9zbFRKNmg0K3RaVCtVOEM5MWQ4?=
 =?utf-8?B?OVR1a1FNT1pzdU5VSkVDVFc1QmcyaGh1K01TYzBQRFRYeGlZQkFuNmdudTl6?=
 =?utf-8?B?MEFhTXZRTGJMN3hlQnNaM1lVM04xZ1g1bHhJOGl2Z3NuUGZOa3pHRndLMG9U?=
 =?utf-8?B?bkIzOE44ZTM3bTBmRzFRTzhrZjUrTm52U3Ayb3pwZkZlS3NYc1Z5K0p5T3BC?=
 =?utf-8?B?bXJyMm5VMVJxVU1tSFB1SmVsNjVDaWNiaVZqMUtkWGVvYUZ6NkhROEhYOWhR?=
 =?utf-8?B?bXdUYkxaa2ZtTzBHSVJsY0M0QzloOVQwN1MxL2ZtNGtaUXR2U25SOWlCYU1a?=
 =?utf-8?B?YkF3RWQ5ZWV1Y0l1OHNsWWJMVkI2a2J2WDZ3YzNFYXZrZkpLR1V1NSsrSUg4?=
 =?utf-8?B?a1VlTzNvVUJZaWZQaXFUbVV0T1NOUEFpLzJDWGdBOWVzRW1TTE95OTVqK2Mw?=
 =?utf-8?B?TzFqeEtYZW85Wk5QVnViak4rcFV4MXlPM3pSWDFIcElJcVBubVVMVkFTVVlt?=
 =?utf-8?B?WTI0Nzcva3RzMTRlLy9lZ0JpUU5zMWNrdzlCVFYxNDRtcUpkVEM5Mk4xZUl5?=
 =?utf-8?B?Z2l6VVdpQy8xSDJLR0lBWENoZWNtOStFYlV5OEZmenYxV0lkbldEOFR2YWV1?=
 =?utf-8?B?dXNDMmtkbk1LV0prUm55NmhVQllQNjNJZDNsOGZReG9BUVA4bUd6UEY2eGlK?=
 =?utf-8?B?WXMwTytzUUc0RXRUWFpqYUdubnZ3aFhGbnBqbUJjSytMUHBYRGI0QzBYNmps?=
 =?utf-8?B?dDhYRFVBaEs1OHJneW1jVEFLNHpVTlB3WnBnMEFZNVdnWDdsc3BKa2hVVHcw?=
 =?utf-8?B?eTNlTk1TRGEzdWg2bFM1RGRQTnRDYlc0bDkzR1NXNm52S3hyeE9kV0J3MUZa?=
 =?utf-8?B?bGoyQkoxNktNSFpkY2FkT2Q4aEZSNWJ4RmFkbUdNREN6aXJDc05ZWWFvVGdB?=
 =?utf-8?B?ajJaRmU3TGN2QWJMZHhmQXNyMEcxRzlvMXphbmJuMm9UT1I1eXNkMi9tOEov?=
 =?utf-8?B?UXFhMGFRWURVVlI2MjNKeHBEUm55c1pmYjRuWU1COGRPMmVLVW9leGdWTm5y?=
 =?utf-8?B?cGNXYjg3Q2ZNYUNscjNTYVhNaXlVSFhTZU85QUFZS0c5aHFJTFRCb0Q5aDZ1?=
 =?utf-8?B?ZzljU1Zwd0dqMUE3dFE5dzdoTTJiNE1abXpCbHN5aVU0Yi9HbTBUREIrOVJP?=
 =?utf-8?Q?o9kmQcmxYe206I67LiTGW+M28?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c4d656-dc26-418c-2dcd-08dc652beb5e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 13:30:48.7919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcfPxqRMZuaFxwH2TYF803JJMn+ZA9B0iJrC7EZuBpvCfdfMsvqEkkEwHynm9UsC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
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

Am 25.04.24 um 15:28 schrieb Alex Deucher:
> On Thu, Apr 25, 2024 at 3:22 AM Tim Huang <tim.huang@amd.com> wrote:
>> From: Tim Huang <Tim.Huang@amd.com>
>>
>> Clear warning that cast operation might have overflowed.
>>
>> v2: keep reverse xmas tree order to declare "int r;" (Christian)
>>
>> Signed-off-by: Tim Huang <Tim.Huang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index 06f0a6534a94..8cf60acb2970 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -473,8 +473,8 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
>>                                          size_t size, loff_t *pos)
>>   {
>>          struct amdgpu_ring *ring = file_inode(f)->i_private;
>> -       int r, i;
>>          uint32_t value, result, early[3];
>> +       int r;
>>
>>          if (*pos & 3 || size & 3)
>>                  return -EINVAL;
>> @@ -485,7 +485,7 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
>>                  early[0] = amdgpu_ring_get_rptr(ring) & ring->buf_mask;
>>                  early[1] = amdgpu_ring_get_wptr(ring) & ring->buf_mask;
>>                  early[2] = ring->wptr & ring->buf_mask;
>> -               for (i = *pos / 4; i < 3 && size; i++) {
>> +               for (loff_t i = *pos / 4; i < 3 && size; i++) {
> Some older compilers complain about declarations mixed with code like
> this.  Not sure how big a deal that would be.

Good point, we would like to be able to backport this.

Somebody from Alivins team needs to comment, but IIRC we agreed that 
this would be legal and we take care of it by using appropriate compiler 
flags on older kernels.

Christian.

>
> Alex
>
>>                          r = put_user(early[i], (uint32_t *)buf);
>>                          if (r)
>>                                  return r;
>> --
>> 2.39.2
>>

