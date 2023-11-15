Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FA9C2BB3F
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 15:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC8FA10E062;
	Wed, 15 Nov 2023 15:30:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F8B10E062
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 15:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuBXsntnMXqgzukmoSuaWfz7Mwm80SFIuW3Omba5Af/KSFo8NviFexEHtAs8dj/P8Wee3IViurWVbfBx9rNEPpB2n/CABhwVSr9JEZRYSiA0ndxqic53dxRDqLU9snsA9xuVG0PGbvqnKT3JzfOZ+Dcb2PdRofHWBJtHn3wOlC02mQQGKsBKciwy9010qDjB2l3KopzN9+XQzORc9La4ymAJt6vjb6IKnea1k16oPyMThPHaw6TrZggqMrQ/BXE1p1Z2268ueLj4+9tRhJjHnPPNVif5w344aGe+hwpwjd4M0lbCqwie7sfhbFbNdRWL0gyf/hFFWgBLOTePt+V5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NX/9cKWhMOD8EsbBoXJikxSM/LFctcxUwjOLhJUFvvc=;
 b=ViS5JEbg/0rsPwvme07k0uDqOhiUVtAQMDlz6jqsw9txQq8AIGaWV4zOmBhDwqZrE7xzngY+/z2vVgYxtLZ47P+zwMf8a60itiV+DkDqZ8EoIw9D6UKMTXkDcCjhpLIeuhU3oI+22laKvXVd3B28edy5ikx/OqWZRIOx2SqMr8hKaABBj73JJsD3b42C+LBYRnnZSp6Zbj97WGKl6rX288+uLVdfYtCWuWWtOEYoJD9hpTW/uTXvinG3IR33vJNuGVwf6N7Cf62g0fO3AKmUjBS1QpsYcMnDfbon6V1AEfnYrbyRLIgwWkaj6sWWmH/as7vut+kaIjtktV6/rU9+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NX/9cKWhMOD8EsbBoXJikxSM/LFctcxUwjOLhJUFvvc=;
 b=5tq8fwD7gwZrMxohtGcjWVgDPiIIClBfvwgy0cg1s/CiBDrlYS+mvaPzALR511/3Tx9DkPzQblZhSJApCIz8PD8DWKr2iLOZT0gA49hniCvIXTRo+F7FmIl9Q52qlSnATuU4a0crAYFKZxysSfVceBj8xXQ0tuEQK/xfLqFXrmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 15:30:49 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 15:30:49 +0000
Message-ID: <47c979eb-a3de-4d18-a6ff-02fa21a04126@amd.com>
Date: Wed, 15 Nov 2023 10:30:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add function parameter 'xcc_mask' not described in
 'amdgpu_vm_flush_compute_tlb'
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20231112044534.1637245-1-srinivasan.shanmugam@amd.com>
 <1726343b-b0ab-43be-91ff-8d0fa12f6944@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <1726343b-b0ab-43be-91ff-8d0fa12f6944@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0324.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e785b61-5065-4c2f-5bdf-08dbe5efd80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbZa/qGJ1C3MhKq4lW/C69r+QsSZb4u5xzWqKzXTvfztyPwqi3UsCBDAHTycfC/lMIQYzPdDVSErjZE4F0mMSwF3V36C2Z3UXwMnzGdSUv8DtZAr/czUjugAhocwZCl3ZFcQUUY2U5qVhlNPsJA63V4MVxJQ6feMHLWcnaUliAD6Krl5OJZp9xTjFzGuoi9BAmU7u3YOHweRgYyl5+IPnolXBTzJezn+AzGwLRTZ7YrV9dDkbh4P5h3WB47oPRzhUj58teuxTY4DbtV684Xt3/f6T7Jir3xZ3rKZgX81qN7S0pyPT8xMGtSaJhevo4pd3j8oscXQfrBONXpK4QoajWrcdxNZc/C6ucQWqO21zP4zgJTaOLZWP/2VNeKNtlEQ2zvsDc87IPBBIuoVleaR2s3GTFC5MpAom1uCg3hxwe0SWgK2lQSVXioA6OUtXEIzudQuaGil1nKC7XTtlITEiDU0+JI7+QSon5sbPjnL/RNxhiMW4K9S99fGVTMi1/nlcnjM3QIrOYpIVR3odAULKiRXyJUvINUcx5MiXrQbcpJiVx5XxnJgxKRnbx+f1QEEV6/YzavKVSjbj61WDhn6REDnaztsA0ginJr20UsWSB1JVsSXNCkwbU/d7m7AwQRklCzsncoan0aGaZKyMG8+GkwVG8sTuPGheXmOxm3Z6igjXXJMA/vsk11SxettJUfK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(1800799009)(64100799003)(6512007)(26005)(2616005)(478600001)(66574015)(6486002)(4326008)(31696002)(36756003)(8676002)(44832011)(8936002)(5660300002)(41300700001)(86362001)(4001150100001)(2906002)(66556008)(66946007)(66476007)(110136005)(316002)(6636002)(53546011)(6666004)(6506007)(38100700002)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGlCUWlEclBJU1ZHMXlhaDlXY05Kam9zNVkwTC9ybER5RnQ2NWFLK1YzcUkw?=
 =?utf-8?B?blNRRTA4TmtkSXlydmNuSkhLdTZYdXVpd0hGVU43Wk5jRGs0eTQxcnNVUmls?=
 =?utf-8?B?eG54OUs1NmtCMlIzbnhXNnhIWFF6Mm9FV0loMSs5YUEzUEV4cEFIZzRDTDYw?=
 =?utf-8?B?bS9mY3RqdnRuN21acnltMkNMVUtRYWdiejl0ck9YZW1RNjRtM3EwMGZGeStO?=
 =?utf-8?B?dXVGNjluZXRVK1prNE5VMEY2cTQ1WGxxMjM4UElxTDRIVVRtQVRkcTBiQ0du?=
 =?utf-8?B?UWw1ZW1reHBFeGV2bElnTWIyLzFHUk1QK0ozVUxOYmtYOE53aE1vcTluZ3k2?=
 =?utf-8?B?YTUvcnd6L3hwU3NSRUJ1clNxQlB6THBQakdoL2JXa3NtODVQeUhjazl4dVRj?=
 =?utf-8?B?bHQ2VTMzUGxnRDlJa3Y1bDFBVW9YOStyU1l2R3N5cHoveGEwc0Y1RGMwRmhv?=
 =?utf-8?B?eGlReDh6TUJiRnVWVjRscUl4VHB1NmhuU1FyNitwdkVTSG9ZakhQODlzQ29m?=
 =?utf-8?B?NDJNZFlEaG9jUnFSVVNDczRQdjZWRkxHK3NjT1Rnc1owQWc3a3Uzc3Z4Uk1F?=
 =?utf-8?B?cmFEMU5KK1ZlV0hNWHRlVkhuMWhBb2xZazBaOGJDUmZsOU9jZ29wSFZNbFdi?=
 =?utf-8?B?Q2R0VmltbFNkalpXOVdmU1lwaElEYWNpb2gxWTgvbC9QUmdGbGl4cVNMTE9z?=
 =?utf-8?B?NUtwY1Z0eUh0WUlRcCtZdFRPS3A4M1BTTks3OWp6ODVZZFppdDZ4OTNTVFBW?=
 =?utf-8?B?dlVIZ1lPQnNRTTY1WkZpSFNzc0Jrd0YvYXhsNHEzQWxpM2ZWMUxuYVJuV2tq?=
 =?utf-8?B?OWswRDRabFZaOEoxNGlUcFcwK3QzSnVrZ3BJMXBucnNSeVlyWHdCYU9VcTN2?=
 =?utf-8?B?cFFkTnQ1NnVDRnFoU2FOcmRZb0xTdXBKZ20rR1A5alR5cVpmWUJsTU1QMGRG?=
 =?utf-8?B?b3lGcDdEM2VFblBxTHM2YjNrR3ZTdmdrK05oS3l1UUFub25LYkthTjZZcnpj?=
 =?utf-8?B?Wko5UHJCeHpHb0hOYkMxeGxRNFRCeFlVVlRGc1Z0WjZoOGZMSDVLYlRjQWk4?=
 =?utf-8?B?NGhNTUduOUJDeURVa1ZzQjBjQ0dPaEpqS1ZYN2JpNU51MDFHVW93bk5oaDhH?=
 =?utf-8?B?OGI3RVBzR3pPeFVVUitKODBIWkJxakVVdDh3eHJYMEl1bnpsTTY5akZDM2E5?=
 =?utf-8?B?UTVXV0s0Ni9kTFFvOWFEZForZUdPMDI5d2E2UE8yY05xbklvSE1SZHd5MTJO?=
 =?utf-8?B?NDdOZFNscTlFMFdOSFE0bmV4VFhiRjBDOFFNTnBiY1RtWjhUYWdxclArbjIw?=
 =?utf-8?B?c1JlTEd2dEtJUjZ3L08xZWw2d1pucW5NUkFmbVBITnJ5T2h6T2FvS1dMZXlC?=
 =?utf-8?B?bHhyVmt4bWdWa3RuVUdtRWxLL3JXUjVjV0VmeFdKVDRsNUdJdythaW9Nem1p?=
 =?utf-8?B?cmdXaGxWbW9xbVNreXQwaXVTNXZUT216bXhnR0tnM3NCUXVqSHpyUy81cHVN?=
 =?utf-8?B?eUhSZHQzMllwSXdWZWhrUGk1L0w0Z0pDMUZaNjZwWDBDdHZ0bHZFTVN1am5p?=
 =?utf-8?B?c1N2NFVuRlJaOUh6azNiWkdiRTR2RVJoVnJGN0trV3NLb3JXRFRXbDhBZm42?=
 =?utf-8?B?cTFtRE5udEtGNVl4SWVZUm9WaDVUOWtJY3ZpSzlMZ1hQTk4zM29rdlY0MDNu?=
 =?utf-8?B?RktJamNTd1hWRXczbTdhRTk5R2w5OTVRcHFjSk1qTEhxclhCb3BXdnNWVEJp?=
 =?utf-8?B?NEFEZEJRZmsvU0NjRVN2eUFxOE1oVmllV1kzeGRhY1NHdnFxUHdzR096V0E1?=
 =?utf-8?B?dGpWendMSVorb0ZHZ3RBekVaa1l2TEJNVW4xRVZiZ1hFSGxiNGpDd0I0NXMv?=
 =?utf-8?B?c24yTEl6MHZ2OTExZnlGS2N1KzNGeXdZMjk2dXJudjZlNldSSFI1b2YxbWFC?=
 =?utf-8?B?ek1SaU9aNVhENUgwM0R0YmFyRG5nTjdpN1NpMWNBd3phY0NkT2d1QjFRVC8z?=
 =?utf-8?B?Q2p6Rnl1TnVyelU0aUM3UDdYN2xlcmQvTEtUeTNvOGVHMjkxSHRmc3ZmZ1ly?=
 =?utf-8?B?MHQwMG5FM1VqbnVOOHREc21oU1g0WjVwN2NLQjlFZGIySnI1OXNFOTlhMEtx?=
 =?utf-8?Q?R+1Mj2JHnRvxErFtk0Ilx3zbN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e785b61-5065-4c2f-5bdf-08dbe5efd80b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 15:30:49.4108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qbfeIq3Gc5hUOCAFsqe138p0cerdUefBS5swV3EvEc9YcWARDpHQHc2JIa9FQHoBbbnSP+r3GNRJN7gbOAFvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-11-15 2:01, Christian König wrote:
> Felix that looks a bit fishy to me, can you take a look?
>
> Why are we giving the xcc_mask as parameter here? IIRC the partition a 
> VM is used with is fixed because the page tables are created 
> individually for each partition.
>
> Thanks,
> Christian.
>
> Am 12.11.23 um 05:45 schrieb Srinivasan Shanmugam:
>> Fixes the below:
>>
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1373: warning: Function 
>> parameter or member 'xcc_mask' not described in 
>> 'amdgpu_vm_flush_compute_tlb'
>>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index be084cbe7501..cd4970c2efc5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1360,7 +1360,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device 
>> *adev,
>>    * @adev: amdgpu_device pointer
>>    * @vm: requested vm
>>    * @flush_type: flush type
>> - *
>> + * @xcc_mask: mask of XCCs for the XCCs available on ASIC.

This is not the mask of XCCs available on the ASIC. It's the mask of 
XCCs that belong to the compute partition in need of a TLB flush.

Please leave the empty line between the arguments and the explanation below.

Regards,
   Felix


>>    * Flush TLB if needed for a compute VM.
>>    *
>>    * Returns:
>
