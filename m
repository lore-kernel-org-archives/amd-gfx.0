Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1A8C25B10
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 21:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B3B10ED17;
	Mon,  6 May 2024 21:10:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qb7zkSQK";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8037410ED17
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 21:10:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXCd1ClPpkXwMKb1kQ4CK+yo1eqyV4yLkRUqBQj/Xts4YzOJxFOpuAED2ziVJqLlE6Si9mdIbspyXs9YwE8e97hEZBvSTTm8MUIyCShTkJT0kfoyJg7PE+YxFGRZ1Nb2LHQ/3bpNsBxoOXfaveucozxhpXADb9rz46k6MbPHHpEmQw+dnJIRj3+9yF/uR5CPJ994vay3+F0LtQxDKmZJjATkKCAziQEgMYzy7FTGdgHg0kxcpvyAm55qmkUzGKudasZ4H9faXwBr1m2/g+NchSbsEbBxipxcVrzgEhzAy3xdbbYs0eTapueGKNOCKB4eCN7XXM+NxlGwAiQ9iKjWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvQjO1kT7hlpDA1n9EBToecHQkzx1S6wpbL2kmNSW9U=;
 b=jRii3B9E8dFPkM/9P9v2Z9HimMN0Kizz+gtKlIsb09Gc7UlshSxVqp1rYy3MpSzSuYw6dD7g8bYJ+cJl1Dkl0f0a8S5IsXy9EzZ5qg5pUoy+snBoT66OsfJTTvwtb4S+I0/9szyrlCgClaKjYpsSdfEcbDT5niNZ84coyD7S3Ngcr7ZwA664zn5/Ksk8qCg/JNKP9Tu87R54R8idzdxeF2by3OX5ZNLJwKzgUwE/Ak0XcEVF4GRn+wrUAhyi/dTeK9I+IYM3wAuSJJye/Pjs2AxU30LfCFP7ibRSKwJ8gmmgoEZihmT1dtXcmFDfpFA4lkpZeJDeP6E+YUdtrFqPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvQjO1kT7hlpDA1n9EBToecHQkzx1S6wpbL2kmNSW9U=;
 b=qb7zkSQKj7J+uk39FEr2YM6R/cDUsI6JVSzPrpf+LE9RX+0J4XVUzmVq+EQqfNTonqaG0QWukAOQntsT9RIfvzEjIHaT0ADI1Qs4BiiMj1aScNAI5pnVySivn4XVVkQvAw3r+npZ0OeXIxs/a+MksPAMl5fhBWgyIraJdmp3WXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 21:10:50 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::ffd9:2592:5d85:ef60]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::ffd9:2592:5d85:ef60%3]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 21:10:45 +0000
Message-ID: <deca3d41-ef0a-477c-b904-6d5473b3e78f@amd.com>
Date: Mon, 6 May 2024 17:10:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Ensure gpu_id is unique
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240503220639.335198-1-Harish.Kasiviswanathan@amd.com>
 <64bbdff6-1944-41ea-85b6-d836165c9952@amd.com>
Content-Language: en-US
From: Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>
In-Reply-To: <64bbdff6-1944-41ea-85b6-d836165c9952@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::14) To CY8PR12MB7099.namprd12.prod.outlook.com
 (2603:10b6:930:61::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7099:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6b563f-6602-48a3-1cfb-08dc6e10fe93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ak9LRmNLV0FVcVNVZS9NNkFzd0poME5xaFNQQmpjVk9EK2N0aXRrajBxNnJI?=
 =?utf-8?B?Y0hRMFR4a1h0czV2OTV2T09zRHhoRVdidUprZjVvTnlLdXVGc3oxcVVhc3hD?=
 =?utf-8?B?bTU2aVY3cThCSWpoSC9YWktMSEZwL0NuRlhuOEp1ZXByL3I0QVVDRno2VWZU?=
 =?utf-8?B?M0p1TkR6TUNreE5uYklMTUx0TklNdVUreXJPd0hYcVVqK0dyYmR5MHV1M2ZC?=
 =?utf-8?B?Ylcyd3BZbi8vNHV5L2ZWNzZnYnRpb21pV2RjL0VZTlNrcjRDSHU4emZtN2ZF?=
 =?utf-8?B?NXM4WElXTTVkRFRweldaMnVRVHY4RlNhQmdpdm03TFVCbG9ZUjZmN0h3TlJw?=
 =?utf-8?B?cTB5eUV6ejE1WWdIcUVPTTdIOHJKemtxQnZkb1V0WStpNXhocHBYZDdhWElp?=
 =?utf-8?B?Z05HTHVnOUhrK0RDMktudmM3VUhjWU85TDhIbkpXTzNEVExzNlRHemFkSkd5?=
 =?utf-8?B?bGUxZW1PbEJVSnpxbmx4S0RabzZrTjl6a2h3MmxsZkNvRkdPNTJvV0l3eWEr?=
 =?utf-8?B?RlFLWTVGUGxQU2xucUZJMzdJS3FXK2xleDgxdmxXODhhMnRVQlNyTzNYOHdt?=
 =?utf-8?B?RW9uTzlLMzRkSUxPUlpwZTZOL3YwV2dza2Y0Ly9FRndpWm5tSDlQeS9nOGhl?=
 =?utf-8?B?bGJnSUZSaEVVTms5QzVmbjZ5TWp1eGhZK3NuaS9QOU5IWm4rOWJyaXJVV1d5?=
 =?utf-8?B?eXZMK1N2Zms2eDNPN2hQUnZpY1ZNMXNHeWtyZ0ZJK1RHTFM1UWpUQVJjcmhQ?=
 =?utf-8?B?WGcvclBBbWV4K0hZU0hrcnduUTJCZ3RvRUNvd0hyWDVIaVZEcE9YVEpCTXZI?=
 =?utf-8?B?WXY0bVo1TnVPZCtyYi9WOEZPMkRMaExkVE01UlE4T2lXYWNGZEprNkxSZmY1?=
 =?utf-8?B?bzN1U21RMXVvNWhHWTgwQWM5R1ZTR2h4SXZxKytITllmcjFhaUsrSTY0NjRw?=
 =?utf-8?B?NjdZRW5WK255VGc3TzlEQlVucHhkaS9iYmhlby93RU1lZDNtT2wrdU14Z015?=
 =?utf-8?B?M3lEVnVKeEt4VkwwZ2VMUVNwVE5PSXpqYm1wYStpdUpwdnZtYmJSQjlrVEhk?=
 =?utf-8?B?NW9LbzBSOGh4ZzR5UTdaUHZERHhaQWF6K1MzT2thOS9mbFh0WTRTUEFuaUVR?=
 =?utf-8?B?bk9MTnNPaEl0ZXNrL2p5VXNRTHFDb08yaitUWDU5am1rdktjWEFSa0NaVzVL?=
 =?utf-8?B?ejFYUjhZZ2o5VXZuTVVLbXJneVI5M0ZXbWErY0JWUVBZL21tMDNET09mSENX?=
 =?utf-8?B?SVI3UWJOV0ZHcG11ZmcwZkNROFpDWHF6aG03WkgwdHBndWZhbUZ2clgrbjRq?=
 =?utf-8?B?OThOOTlPb25xb1BnOVdvYWEvU0JXSHNrV1dhdGtyN2d2Z2R1eU9yei93NGxr?=
 =?utf-8?B?RTJJYWpuMnhyajBrd09NMGpLRkVPYjNEb2JEelJINGZ0VEh2alRudUFtWGhz?=
 =?utf-8?B?YzM4d05GdUtoSUNIY0wzenZkcEpkaTdOdGlKQ2RQUmtlODVocjB6enQvaVJ5?=
 =?utf-8?B?M0NSdzl0OW5Bb0JkV1JNelNIbzZBd0FwSVFXL3dUSXo4ZTJzUVh5SEpzU21m?=
 =?utf-8?B?WHlVUmFLVVpJVzJjM2MzTjJmVFJtMU1xdWE0Sks5ZzZoUzhOME9XOE1NVlpK?=
 =?utf-8?B?a1AydkdaNHQwYjh4clZ0TW5tbnBTUVBsTmNIOG9SYkEyc0hmZUdtMlZHSVg0?=
 =?utf-8?B?eXVCU1B4YzZtYXlsalhtVFhTbHk1Mkd2VTVOT3BYSWlHaDVNZW1IZkFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1ZMclYvaDIvS2xrWkJXYyswMmRUKzBUS0hCdnlKL1E0TUFkVzZQaW16eE12?=
 =?utf-8?B?Q1BYRjEzNzNqejl3dGZQU1dxZWg0czJGNHN6SDIwcW5UUWhza2tqQW5PMHlr?=
 =?utf-8?B?RTE5bDB0OW84NkJ6UnVMNUpaSDRkQlpYQXprMzg4QWNidEVYcmF4aGlEbjky?=
 =?utf-8?B?UzRnazZxNkxhdDR5VmpnMjJINWx6STk2eG9zTlU3dUpyQUY3VkovTWppQUt0?=
 =?utf-8?B?NTlxWFllT2RCYm5hZlkxMDJ6UGJHUklZN3NxdFJjdHhQc3JEZzdwSU5CSkd5?=
 =?utf-8?B?a1o5M2Z5WWxBaE9FU2ZUYytVeTA2SGI3U0ZWS1pWQjVGYURobWlnMkhOSDMv?=
 =?utf-8?B?QjFVeGZwb2g3V2VWa1k0WEJIM1ZNYmdrL0tjT0ZIWHkyekZhOVdGdFBPSks2?=
 =?utf-8?B?Sm5OZzBGa1NBeDhmTUplb0ZzOFZqUkE5anhqRHpLRUxGUlV4TGdUM3BmM1JI?=
 =?utf-8?B?cUhVLytaczZCSUFYYW80NWdxVmhpR3k3TUw4VE9qeVhGU2RzWG5GUkhHLzNt?=
 =?utf-8?B?cThxVXpib3h0SmNESk9lS1VrR3cvODJjSGwxcE9jeFhrZnhXcWNLZWxvT283?=
 =?utf-8?B?aUFnYVBXNDBEeW80OTVhZTZiS05sLzBGUmpWaUtoOHFZb3NOdnhaQ3hVOWRs?=
 =?utf-8?B?VzlJdC9Zc3RKYitpTzFac0ZNUVNkN0c3RGQzYUl1dXlyaURpRTNnUlpVb2JY?=
 =?utf-8?B?Y0Q3V2tXTmhpd0g0VjA1dmh6SlcxRFdrZzBnSmhzYUEvZVZCcFJPWm1vOTQv?=
 =?utf-8?B?TkxSYlVpMStaYlFoREYzMEE2bWJUM25yb3M1Ti9LREw3dHhGYzUvc2UxRkdW?=
 =?utf-8?B?eXN5RGJ0dUkyZzhEd2N0cC9MdGljbmQvb28yQ3RDOUhkbnpTazAzTDZBUnZH?=
 =?utf-8?B?dzVHeHE2SU5jU0lBQTIrdXJqUUExYlFucWp3aXR6U3hTU2JrSjA2WGtpN2RM?=
 =?utf-8?B?QkVlaEpHajhidXhkOFZuLzVHM0lKRDZOWWs2ZldDWEVDdktBVDNncGVJVjhC?=
 =?utf-8?B?YjdaVVZpYTZnTkxvTlNKOFd0N3Y2MHl6SlRhVXEyK3ovTFBqZzk3eDB3bE91?=
 =?utf-8?B?M2R2ekZkSFhKYWdNcXZIMkJ4VkdiSkNmZEhOMDk0TVBTSmZRMjhsajRpVDE4?=
 =?utf-8?B?NlV5dTlTQWhlNm5EV0dXejJyM2M1L1RQbVRXTjNLdG9qTFRLR2l2c1lKNFQ4?=
 =?utf-8?B?TVNHYlRCdjNjM0lmR0NRUWUxUkxYR3QrQjdGTVcvTXppNnpuMVpCNnI5K0F5?=
 =?utf-8?B?aXZ0ZjU0clZMeTg0aUd1SkV4Sy9pK2RoTFJQOTd2cjZBV3N5R1RVYm1mcFg4?=
 =?utf-8?B?dGdmOGlXKzkzVmg5ODRIdktwd1BxREVyRmd3UCtDcEJmNW9pWjlZa25TU3dz?=
 =?utf-8?B?NHQya3dVVDRQWGpiWDM0Rko2YTBUNXE1WGlTZWViT1c3WGZoMTI0VmxIQndK?=
 =?utf-8?B?S05iZUExSHpCQ0d3MjdjQVNjOCtjUDJuWEJVOUtEcGhkOFVjOGk1NEwvVGd6?=
 =?utf-8?B?bVpVaXp4VjIyQVZXZTBYS3dOYmkrbXhicHd3WnpZdU0rVVB3aktFb2RWM2dT?=
 =?utf-8?B?WVQ1TnNMZEdzRXcvSzluV2dLdkxVVnF5NUczOTBBeFRHazExWVMwbzN3Mnds?=
 =?utf-8?B?c0RkSFcyRWZzYlF0eFJYT0JyRVB3VTdPWW5KMEszcmR2WFgxVkRJbFFjUGNw?=
 =?utf-8?B?YkNtNnRjUnA0VTBBTFBRaVpYL2srQW5nc0I0K0l4NXAzRU80TERQL01iT29O?=
 =?utf-8?B?Ly9Lb0FZU05jdjBObnRpeCtFa1NFTEFTUFVDOXpQeVZsenk5a1VVUGN3alhH?=
 =?utf-8?B?Sm85dzVsT0RMUU42Q24yS2w4RWN0Z0NqNkRITzRER3Q5WGVFa2NUM0xjaGdT?=
 =?utf-8?B?RVpVYityR3BhS3BEYnN3NmxSVlV5UE4wb2N3Y3JEdGYzM0NieWN0ZWVWUDZa?=
 =?utf-8?B?ZzhlKzhFUXI2UlRvcVRsTUdtWmdhMGV3SXovaXFZMVFsclpWbUdOWHl5R010?=
 =?utf-8?B?M3V0ejhXcFllbFgvVUIrN2NtNURtbU1YZ09yS0Z3dmdqeUl0V3hUVHBDY2E1?=
 =?utf-8?B?eVNFRkI5ODdXRXJFMGsrbUVQMFZTZkh3Z3MxYTMraDVKTXZVUnY0MERZSm56?=
 =?utf-8?Q?aerOhxPlMq0ToncM2yRtSuU6T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6b563f-6602-48a3-1cfb-08dc6e10fe93
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 21:10:45.0698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+PEl78bidD+YEn2qSzh3lKRM/G5lZNipRTPeuMcUh4MhzBCyc+Hy39sNF+C6RmUXBL9+QzDPYsa9USOtYFxDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045
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



On 2024-05-06 16:30, Felix Kuehling wrote:
> 
> On 2024-05-03 18:06, Harish Kasiviswanathan wrote:
>> gpu_id needs to be unique for user space to identify GPUs via KFD
>> interface. In the current implementation there is a very small
>> probability of having non unique gpu_ids.
>>
>> v2: Add check to confirm if gpu_id is unique. If not unique, find one
>>      Changed commit header to reflect the above
>>
>> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 26 ++++++++++++++++++++++-
>>   1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index b93913934b03..01d4c2e10c6d 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -1095,6 +1095,8 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
>>       uint32_t hashout;
>>       uint32_t buf[8];
>>       uint64_t local_mem_size;
>> +    struct kfd_topology_device *dev;
>> +    bool is_unique;
>>       int i;
>>         if (!gpu)
>> @@ -1115,6 +1117,28 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
>>       for (i = 0, hashout = 0; i < 8; i++)
>>           hashout ^= hash_32(buf[i], KFD_GPU_ID_HASH_WIDTH);
>>   +    /* hash generated could be non-unique. Check if it is unique.
>> +     * If not unique increment till unique one is found. In case
>> +     * of overflow, restart from 1
>> +    */
>> +    down_read(&topology_lock);
>> +    do {
>> +        is_unique = true;
>> +        list_for_each_entry(dev, &topology_device_list, list) {
>> +            if (dev->gpu && dev->gpu_id == hashout) {
>> +                is_unique = false;
>> +                break;
>> +            }
>> +        }
>> +        if (unlikely(!is_unique)) {
>> +            hashout = (hashout + 1) &
>> +                  ((1 << KFD_GPU_ID_HASH_WIDTH) - 1);
>> +            if (!hashout)
>> +                hashout = 1;
> 
> This doesn't catch the case that hashout was 0 before incrementing it, and was found to be unique.

I didn't actively think about this case when I sent the patch out. However, we don't have gpu_id to be 0. There are places where gpu_id=0 means it is CPU node

> 
> Regards,
>   Felix
> 
> 
>> +        }
>> +    } while (!is_unique);
>> +    up_read(&topology_lock);
>> +
>>       return hashout;
>>   }
>>   /* kfd_assign_gpu - Attach @gpu to the correct kfd topology device. If
>> @@ -1946,7 +1970,6 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>>       struct amdgpu_gfx_config *gfx_info = &gpu->adev->gfx.config;
>>       struct amdgpu_cu_info *cu_info = &gpu->adev->gfx.cu_info;
>>   -    gpu_id = kfd_generate_gpu_id(gpu);
>>       if (gpu->xcp && !gpu->xcp->ddev) {
>>           dev_warn(gpu->adev->dev,
>>                "Won't add GPU to topology since it has no drm node assigned.");
>> @@ -1969,6 +1992,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>>       if (res)
>>           return res;
>>   +    gpu_id = kfd_generate_gpu_id(gpu);
>>       dev->gpu_id = gpu_id;
>>       gpu->id = gpu_id;
>>   
