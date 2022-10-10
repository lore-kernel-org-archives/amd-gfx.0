Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036D9C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Oct 2022 13:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21CC410E4F6;
	Mon, 10 Oct 2022 13:29:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F59110E4F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Oct 2022 13:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bw5clBslMczTt7rVUzWGBUpjt5nGCA68qtb8MKFLdunKJMa96Mj8uB7EUUHQdGUW4IxZx9AOyDNin5TkPYRy4WbUiumeKHLBrRyKPSKyqphAqWLuexO2xR+oIDqfHwgfzNLXsM6CNLK94dO6W2pQbmyxcHSy1auQfY4IuVAnBQgbUuKQVirLcLbRnAv8fLSq3JIlZbC4mj/hRXTFhMxqiJ3K4nbnw9PWxyfyLf/zGa4tB1+gHgr+8rCe970gm9f3RKEjhPGDoqCqe5L89ONIHAIzqRBJo8MhrRDaVpXmKoHp4BAbmQzRnCScT8VVXdKiCUNhp8SHVrQSjl/c/HNPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8u3N1OM0J/c8XW5EOKrMW+yMD5ysqryhIlS7gyTl74=;
 b=dyb6pLTxPCsFfTIiePzQhAdtsm5XheYmX/4wGyXjNz2f7pG2nnoBykou4+CTSzfGUSLRkpRdWLRoEN6EIqBT3v48U3MplB/JTiXff3J2Q7hQTQU8qqN6Jc6EIeDoYVuZf8Lfg5/cdWsiCIFxbvHJmARGnJN+xocgXuJfKED2Kuzqbqqi8OtVCLdKN9XdP99LvUSWo/JrWBjuzTUYnowuXQdr70R1WKy7EQ1eVHtDBmoFnIzz+CZizvc9dgiCQgvFm05LpXz0DWg4DoB3/I0A9g6ytqO1jSYjaCtmi7I/7ETc26jgIwdHG+E40NAx4vFMYYLr/JFoflIkCci3BxwBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8u3N1OM0J/c8XW5EOKrMW+yMD5ysqryhIlS7gyTl74=;
 b=q0P023YYD90E0J7jxIwDn73oPq+gI2EF+EiHfFBLcI74EEehYWU+VoIyI5HJnZM9B9B2TRs0GqmZkmhvZ9RJLGu19pHdOkjF+0lkt+YfrUBxpv1zkGHUbOIYCHz1z6U0BAJVVbtt5NgUc4LEJBmKA5347y6rai5Cxz8LhxVuEco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Mon, 10 Oct
 2022 13:29:37 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::2d0d:67cc:14f8:a3bd]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::2d0d:67cc:14f8:a3bd%7]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 13:29:37 +0000
Message-ID: <90bfe0a6-84ff-b6e3-cfc4-210b1046385b@amd.com>
Date: Mon, 10 Oct 2022 21:29:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] drm/amdkfd: Fix the warning of array-index-out-of-bounds
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20221008055612.505160-1-Jun.Ma2@amd.com>
 <7e7bcddb-f49f-d157-3f58-24d6910036c3@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <7e7bcddb-f49f-d157-3f58-24d6910036c3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:3:17::27) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7c628d-08a6-4f15-4738-08daaac37a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nu/0m8xBDsnR2N+djNQEb4OUlrcuLMhwUPCjYkv6Vh/qrgkUuLJuG9rhNofS6arCzxeS+vU0DKbI9BOiURo7h3B8edqjPfrbWG5LaaiBcAT0ctB4KidOPTKAzSMIXKsa6xxrongJLTmkkEt7pzEQVfA4khxW5KigQE9JT95Sv+5big1xXGPTtc+g4JFrU5S9ii2PPWfg3sQUdK8vFfCtWHi1K/2WwGC2PFSJEhtbt2ekCHl56nPRWiiOQJaDFG/Oy/yHHKy1ddZpZdm/z8KoTZWWUN2jgwen9pruo3dRZcGqpQME7v4IFH2yzLrFWyPFkX2Fz2y48g02cexJhnjoLBc35mRvdJGGip/pfcxV4EMBaWCr7Fd75qkKsazMEo+tRGX8N62tSEbg3cQlOuYGh0CF8OPkGAJvCXrFia+mGYejyOhaPsRXwEypvVIrbtgIMJBQ+tk4dgeHt5z4ROusLN5XDMxfoXHdbw5SCkovgr8NnU+LfssrEeC6pKYT2ZBOFUM92Y17cF/DXKQkZHSd3VW/nrv6pIKCIuz5Six7ihBR8nSTVkcWs0ou1+KKReIIyO/Rtj37OYwRcmlWlJBovcnZ7gKC9rdM9/Hh+kE1rOv1kdfzIdaTTT8Dhexh+PutGE3evflph5RQzlFd5onpwhvoXHzVokF7ZEFQKE7wFTFUxa1u18M+SpK+d2GzQ8b6KBm4BBUiM4HSMzYLwzVMojFcNY2e1+6LJYSV3kqRwsNVfYjOhGyx6OIpdfwKV2WK0xVdgiUJfrpeNUMph/y9Y4KvrMsrgd7qXDUSpo3dMSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199015)(6506007)(36756003)(6512007)(53546011)(2616005)(66946007)(186003)(31686004)(5660300002)(8676002)(38100700002)(6666004)(4326008)(2906002)(83380400001)(66476007)(8936002)(41300700001)(66556008)(31696002)(26005)(6486002)(6636002)(316002)(478600001)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzRQK0hQVjNBaDIzRm5US1BENnM0ekZQYmlBQlVjUVFBdEhpaFdVZzlBdnJ3?=
 =?utf-8?B?NVYyVHlZTlhUT2pUdFNvcHpESFc2R3pHV2UzUmRObkprSzU3akxWRFVVdWR6?=
 =?utf-8?B?VnlYcVZPdGlEcWxyU0NzaktFczViL2d6anpjZUx0RUZFNHRRZGdCT25Ga2VT?=
 =?utf-8?B?TGxMZzdybnlBQ21CWnNUL0toLzZqUnJLejAzeldiSDlkVXFObjl3dnF2T2lG?=
 =?utf-8?B?WWp3SFU4My9iWUhjejhoY0I4RXMyVStROENFV1U4VEw4anZySGZ6L1pOQVVG?=
 =?utf-8?B?Vk5vazBDaS8zaEFnUkJQdEFjUStFaTZnaGx0ZVJlTnVjSjFxL2xQQU9JZWFF?=
 =?utf-8?B?eDNLSmJJZTV6NmRRdzh1cGY3MFFyZGpOTEVaRDgya1hqaE42VllUMWFTVjVr?=
 =?utf-8?B?SElvamlseldqOXd2MHRYcFRkeEZTdVhpc0lhME43Tk1mRXgvVHpMeUwzRmF0?=
 =?utf-8?B?WU5tK25PbzhFRTNjK0FyUk0rekhua3hvRkkwblZHM0FEN2RIZnFxd2ZWemFT?=
 =?utf-8?B?QndMNkJ4YnFSYjlHY3VNTVhKKzJOdk9zeU5Nb0ZEbkpRMHhzdTlVYzZVQnFO?=
 =?utf-8?B?M2l2anBySDhUdHh4aVpEWG1NTWJBdXN5QUJuZWZJRHJxM2l1QzkwcGpKdDJ3?=
 =?utf-8?B?MUJwZWlyK003VStvTmxsV01ORHBMUEVCYTZvZXdUa2VmOUQxMDBLSVpSeDJZ?=
 =?utf-8?B?N3JrYXhkc3hSamp2T1JxY0h3VXpodlhtRnpmc0lZWHJwNGQ0SnNQTjE4Ry9z?=
 =?utf-8?B?MXFpRXRlQ0VmdzBxU1gwcFdFOVpVUW04b2t2UlEwcTdZdm5KcDhEd3dsZzZU?=
 =?utf-8?B?OUhDQmZZMmgya2JJTXQ0SGlSWWM1a0JheXltSG9zOG9zN1psTTJFRnlZb0Zm?=
 =?utf-8?B?ZGtaWGhWUnRnYlFFQ3Qra1VaWW5NQnZYa01pc0dpM0JlNkhrSDlwTCs4VHhD?=
 =?utf-8?B?NzJjdkJ0UWVvME5uaE81dGV1azc2bVFvZDVBUFNPaVBVNkNvaGJRb0dhaTBx?=
 =?utf-8?B?c2prdEM2VHp2TFk5R0d4dm5oUmpxVVFtRHliNkNQdW5YMHR5Q3UvTUxZZVZC?=
 =?utf-8?B?dE5pVHdOcVpzR1JCNlpwTGVIZkt4eUQ4bXpQOVF2alRsRzVJQVAwNTUzcTcv?=
 =?utf-8?B?Tm9ENFZwOGpiSjI0NDRjdW1iT3U1cVlXOThDQmxUSG1NdmpUekt0Z0RCOE5Q?=
 =?utf-8?B?QXZIM3lwd0ovOUdDbnRJdVR4d1FqOHIvSHk5ZSs5aElDQzZZY3VLVmZidUU4?=
 =?utf-8?B?VTNENDlISDF3MCtLN0ZDTGZuLzBkSkREdHpEN2lOTElVNk1PYkIrVk9VdVdj?=
 =?utf-8?B?VHpjclJPSzlTMng4bmVYSWozWkxVVjN6QjBLRE53N1pTTDBlYmN5OWxpV0kv?=
 =?utf-8?B?bzI5NVhWZnRCMVBZYXBub0hhS2ZiYjVOZzlMSGtrUFFIcCtER2Z0dVZGSXRz?=
 =?utf-8?B?UHNvS0ZzdXlXU1ZDZDFNaklycFhIT1YvV2dpV2hiUEtFZVJ5aFErTmYvb2JV?=
 =?utf-8?B?WWtCUEdTYTlxN1d0d2Z6REovOEVGZWtCWThQcjV1UlRPSXhyS3QzNDhNWGgr?=
 =?utf-8?B?QnF3THdwbVFqZTZMM3pGZWs1TVYrQ1p2UDljaVBqQ1lsVzZ6MVhnWmFFb1pX?=
 =?utf-8?B?cWU4V0p2QTZPQzM1dlNwSDlxZ1A3dWVXR0NvQW5haWxCSVo4cTI4azd5YU1N?=
 =?utf-8?B?TVhFUFR4S3laNXlHUC90VVdIZmhQMzNuaHk0eDRDV0pxQUs0YjFXaWlwNVhs?=
 =?utf-8?B?eHRFYVRtb2d5TlZjSThVRjJaQ3NSalBYSEgxYmF6UEZaNkdzWFRBS0hJQk5M?=
 =?utf-8?B?K2QzTCtnVWZ0b0JRWFBhTncxUTd1NUhBWGVSVm91Qzk3TDErT0pkMVdCVmov?=
 =?utf-8?B?T29OclpFTXh6dU5RaVB4dCtVbHJBK3lSOFdQQ0ExRGtkMlZHVVhvU1B0RFdl?=
 =?utf-8?B?N2JKekpzbzdFcWhPSk84ZTV6TVg2Z2VXTEZ0YXVSa1RMT3RJRUs5L1lGb0tN?=
 =?utf-8?B?RmNwSkhodStiTUg5NjI3VGpLQlJWem9WaU00OW5pWkZlMmxkTEtMYW9USDFk?=
 =?utf-8?B?bzFYaTlLazNuY2RjYWxVc1phdExjTi9Welp1RjNrcitCVWg0ckVCL1AybXQ2?=
 =?utf-8?Q?S+2CquFCWP6CibgU/rYk5C76C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7c628d-08a6-4f15-4738-08daaac37a0a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 13:29:37.2309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLhP/TMItMygFhARjYaeM39pG5GgCgoJEz2FVvLn/5+vNJHsf/Gll8GZWVfVP3Oo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Felix,

Thanks for this suggestion, I'll make a new patch to fix this.

Regards,
Ma Jun

On 10/9/2022 12:34 AM, Felix Kuehling wrote:
> This breaks the CRAT table ABI, which will break APUs that use an actual 
> CRAT table from ACPI.
> 
> I think to fix this, you'll need to populate 
> kfd_cache_properties.sibling_map without using a VCRAT to support GPUs 
> that have more CUs than fit into the CRAT sibling map. In other words, 
> don't populate the sibling map in fill_in_*_pcache. Instead move this 
> code into kfd_topology.c and populate the 
> kfd_cache_properties.sibling_map in a new function called from 
> kfd_topology_add_device. E.g. kfd_topology_fill_cache_non_crat_info. 
> Maybe conditionally only when using a VCRAT.
> 
> In the long run, I think we should get rid of the VCRAT stuff entirely 
> and fill in the topology for GPUs without a CRAT without the 
> intermediate step of creating a CRAT table.
> 
> Regards,
>    Felix
> 
> 
> Am 2022-10-08 um 01:56 schrieb Ma Jun:
>> Increasing the simbling array size to fix the warning of
>> array-index-out-of-bounds. The VCRAT_SIZE_FOR_GPU is also
>> increased accrordingly.
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> index 477a30981c1b..3ec425c3737d 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> @@ -1683,7 +1683,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>>    * expected to cover all known conditions. But to be safe additional check
>>    * is put in the code to ensure we don't overwrite.
>>    */
>> -#define VCRAT_SIZE_FOR_GPU	(4 * PAGE_SIZE)
>> +#define VCRAT_SIZE_FOR_GPU	(6 * PAGE_SIZE)
>>   
>>   /* kfd_fill_cu_for_cpu - Fill in Compute info for the given CPU NUMA node
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
>> index fbb5f6c32ef5..31a4bbc9f9cb 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
>> @@ -80,7 +80,7 @@ struct crat_header {
>>   #define CRAT_SUBTYPE_IOLINK_AFFINITY		5
>>   #define CRAT_SUBTYPE_MAX			6
>>   
>> -#define CRAT_SIBLINGMAP_SIZE	32
>> +#define CRAT_SIBLINGMAP_SIZE	64
>>   
>>   /*
>>    * ComputeUnit Affinity structure and definitions
