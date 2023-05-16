Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F37C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 06:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A9BE10E2EE;
	Tue, 16 May 2023 06:44:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0139E10E2EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 06:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTviq08a1IRNDbuoTKUNegxELYffAeUXDZYN3L5xOPQNDpVMMP043lcSBHxsAfB/iJAUVlT1XjIO7B88OOjaEktIjuBFoSrCL7G9+fzTdM5+xP18k+hvMU26Dimm82t1G4xj3qhMaFiSrDMaDqS5/dPjNEz4wCq5fY52fj/gA6618CiWPm+iVlsJ6VAkili37s6ob92ekKeAaB/JX6K+HpRtYueJE8FRe7PgJkx453X5Uj/CzSCg3BTltLVcSM3DyJTjN1CE4zRmPMbgtnep5RfJ+lvJ4HcC8j9aARB/qld+moeHtvU3o9xUeJ0Su3XGa6bPO+J5Xf3VcNUGc9H+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owD8v/mMyHJRN1F9/i1ET7XZxiNRg4bJa1yAbMRTzps=;
 b=k8TVU+V0tzgd6GjM9l/42lJJdIz3DkYQJF58UMaBo0ntqt8Lt9HTYX0GiVKxcUitDukKMtzMMbLhRLLqibhBZCqo9CiZ7cVGs0QnOJTwbnG1bfutdXfOYc8em1czp9hblD+CMpv52XfCJQ5d08ffJnD44+QcRTJkgU5sxsVdV1pgnk7cu+lHt1GRa7axPq30ThlQebJYoynNauAXnryF0NYOYJWu/l9OUWn0yftK10X1msQxo2vz99tMcV8OlnJrPQs+AqgMYVG2YYtDmHyswLRSzl5FMOTWXamBWwczPhvtX2VKDznWKhm/wlb5QXF4QZ6WcmUo+K0S2GI5jMzZ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owD8v/mMyHJRN1F9/i1ET7XZxiNRg4bJa1yAbMRTzps=;
 b=lBsELrS5KDi+LchKBEn3oBK4iEpbrLB3HwC6QwLAGfo60vJsaonObC0JzBA0O+JiggZJmpA3pgzrIU6cUkdgZ8RkrkUjY7C+XgOdRlJr6CPSvJgc5jWMnaBRcU/i5hyeEHXN8Y+swljyhzm9mf1ZhyBsgDBRHoudjfCnNXfIIZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 PH7PR12MB7281.namprd12.prod.outlook.com (2603:10b6:510:208::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Tue, 16 May 2023 06:44:25 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::cdf:2ed1:1f52:9f65]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::cdf:2ed1:1f52:9f65%4]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 06:44:24 +0000
Message-ID: <486d520b-e52c-b16e-f132-02491489b242@amd.com>
Date: Tue, 16 May 2023 14:44:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] drm/amdgpu: Fix the EPERM error when get user pages
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Ma, Jun" <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230515061342.3328610-1-Jun.Ma2@amd.com>
 <BL1PR12MB5144B04839C7DF2ED7741A97F7789@BL1PR12MB5144.namprd12.prod.outlook.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <BL1PR12MB5144B04839C7DF2ED7741A97F7789@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|PH7PR12MB7281:EE_
X-MS-Office365-Filtering-Correlation-Id: af78b885-97af-4341-6723-08db55d8fc9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cto4WPhKraoKkpNNsE9YBhNYyPkxILxoXQzYmtf/7siBLbve7FLXzWpdRZbuLYonJVtxeJX3vegE9N+ynais61zIGo1JZIIwIUFOS9Ait1OPRrZoT0mndinmAa3pOJ+jbEottzV8nO2liouDLRP08PVNh6Xya8hzwTVd1WJ4Ivfn5Ca46Ye39De+opRppHzsd4e6/YpNv6Q/kMlmnNyN2uArJrTwdw56e7T51Gt6hCZlQwjN8o//aXZx0ulNo7bAHGYbcRIIPKMts10GEosdKOwFMq2ShTMcsMaJ36l8Miq7aZmAf4J0DQ/7aY2LSoYkZpM/aHR2yjU8Q7YBsmRCL7G00vZzWkn5QyHaZKQgIe274++WPimCvdlSKXKk7uLrN3vjMIoXMcdaJG5BoNPZow+eCK4QdU0BFMBcP3AcCiCYrr8xYKRW5zS9EOYfQyDnXAgpp2acDwALpX+XH+8BfuUrJlE4ygV2NezT1VKa3RCDuUshUBp9n9CStaisBnE4QuqELYxiGa9mr9NPrsULWA+H+1rus39C2g6sMiFFMNzWyZQoXddEy+xU7j1h86bJWbJl++l4mDf1F/VAF7NV/hGOveJHRAYBELC/c+raXhyAwuZ+jC39nePMfmd21K7M5WRyo+elXsQxb7Ix+TvOwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(66556008)(110136005)(54906003)(478600001)(66476007)(4326008)(66946007)(6666004)(316002)(6486002)(8936002)(8676002)(2906002)(41300700001)(31696002)(5660300002)(26005)(2616005)(83380400001)(53546011)(6512007)(186003)(6506007)(38100700002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0d3RC9paTVOVEtQaXZ1TEZCczcxT1pTWXRaSXgvT3p4VTVHR3llUXJPSDJ4?=
 =?utf-8?B?cWh6aVNMTHFuTlZtQkg1Wkc0WmhlQ3Z0WW9lYjlhTFpkRU0rVlFoWDJmaXlY?=
 =?utf-8?B?Ylcra1pSNlVLWkk3MFFPbFJQWmFJRTRzSDUzNzZnVEd1WDR6ZVptdDN6OFNj?=
 =?utf-8?B?YmtFQnR4NmlsV3drZ0pRWHdQNElETGxXd2RIM1lqNkVFbVFwR0phdzgwVHpw?=
 =?utf-8?B?OS82dkJ4QnRHdWUyQlhNWU05MTlQbXlpWkhVU3NVV2liTHphOUs0bGVSeGFG?=
 =?utf-8?B?cUQ2QTA1clFnenlRRkVHbTNlVkM0Q0hiRkV3a1hNRFFsc0ZIVUNHaDBDeXF4?=
 =?utf-8?B?YUJ4aWgrNzVkWXN4TFhtdDdZc1FRZE5aOHJzeHVUUXVxamZHME9LTjBZNXFV?=
 =?utf-8?B?VDFlRzhCMDNySW9QenZQR3hSQ0I0RTV5UVZzcHhCeGhyNTlycDZ4TnR5YSs4?=
 =?utf-8?B?UE85OXp4SWxhWUUwY2t0a1FKZHYrb3BqbUZsZmxsaU9Rd21TVTdNM2RlOFpL?=
 =?utf-8?B?c1FRTVQ4Vlo2SkJ0UzExTGdQNUxvMHdFd3NiQTU4N1VTa1VwYVhoNStOakpt?=
 =?utf-8?B?YzRVYVhZRm44TGloRDN1cWNtTHc2YzZiTlMwOVhZV1dqSVJMS2RVNTZQOXpR?=
 =?utf-8?B?cHMvUnR3bVljRlZZZVJSRVZ2Y0ZkWEpEcnpLL0VLU2lrZ2VoV1JHZW54TzBN?=
 =?utf-8?B?RnhzQ0RLNVo4NjRmeUhHL0FPazRpR3pHQ1dXTENtR0ZnWSt0NlBXMEs4eTJY?=
 =?utf-8?B?VnhBQVJpWHByL1JjZDZtTndzb0dscEJLbGtqZkpLOHhrUDh5RTAzSGh3djQ0?=
 =?utf-8?B?V2IwVnNaYXlxTTFMLzZWQmc4VzF5S2NzTUY5MnhPbUZmVmdzMUxCcUZmMmR1?=
 =?utf-8?B?ZGZXZ0t1UXpMZ29BeU1kZFBNK20xRFBqcnVhdjd2eTZPSk5EcEtxejBMQ2tG?=
 =?utf-8?B?UWxUTGVQWnFycnBGa2trRlN5VkFEeU01MjIvMk1WdjMxMnJQNEwySEhqSyt4?=
 =?utf-8?B?TW9NVlhrWnFWQjZGUE5ld0RZd1BXdkNFUGh4dVlRRkhKWlFtNW9NOWNQSkNL?=
 =?utf-8?B?TENmQU9za2pKS1FCQXUxTUg0YU9oclYzRWRuaGRQazhyLzl5NEdST0o2QzRT?=
 =?utf-8?B?d3RYMU5vVW1BWHUxc2JnRDNvNE9xYUcvUHdvSW9rbnJGU1ZBUFU0K0tPV3RZ?=
 =?utf-8?B?RzJGMjBBZG51NFRqZWVOYloxbjRvREFKMmltNDVzVTNMY0YzcC9nZWlxOGUz?=
 =?utf-8?B?Q1lHUm9TczYydVFva2RMSzlHWmJIOHUzS3BObytkUk4zVFZ6SUJOZThUbWI3?=
 =?utf-8?B?TXVyMk9oTmVlaDZxN2ZEZFZQZDVTU1JoYkU5UDhWTG1FNTNrUFo2S1dvTjJu?=
 =?utf-8?B?V25zU21MOFg2Y3NYMDFUeGdIdzBJN21PNHJ1UnlPdGtJME5senhOZW50RFpB?=
 =?utf-8?B?SGd5dlpCd2xDbVpBTmIzaFBTMk51WWxoTVhweFZFdWtGQ21mQlBQdlREc2po?=
 =?utf-8?B?UUdFSk9Db0N5Q0JsbDM3RjFLN1UxOTV1ZVphNkE2aEpsWXN5VUZmS2tBNi81?=
 =?utf-8?B?OS9sOENPUGpsSTYrazZiVVFpY0VYVGxmNGdnYkczeEhVZXRneXBCQ1piNFVz?=
 =?utf-8?B?TzZUT2dZeHNjTG83WWtCdk9lbkNRdXFiOE1RVU5wR243V2E4cnFYWkcrVVlV?=
 =?utf-8?B?dkluQVZhc2hCTGFRRWdOdm95Z21heFcvZmhKTmVhckZxQStiOUtqS3RCR2pL?=
 =?utf-8?B?L2srNG9zdTlTM3JhWGMvQlVLQU9SdmVrRmUvZnVJcXo4emhpUFJxdkZBZU1S?=
 =?utf-8?B?UldyUTMveTk4Yi94TVc1L0xJSDIycTFMWE91ZEpXU2lmaXVaY204NXlKaWps?=
 =?utf-8?B?SXIxbjhSM25lcldMWGNFVU9uUDZPQUJGL0txbzNTZ0FxTXorY3RyMHM0cXll?=
 =?utf-8?B?Zk1tcUxINU9GQVRMUlRQUHlzQ0FRTWJmcHM2c0dzVEVadWhqNlhYanZIc2k3?=
 =?utf-8?B?WGlLTm15bFYwUVNWVnJTUmhOMHRJRTBsNjBGWVd6YXB6ZkwzbDF0R0VzMEFy?=
 =?utf-8?B?cFlxU29wdlBhUnJ3QlU5YlVCUWxIOWU3TEptQzhMZXBiQ3BiY0I1VnFqQ00x?=
 =?utf-8?Q?SB5097n3alRcIBGuCQo8Vmu1I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af78b885-97af-4341-6723-08db55d8fc9b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 06:44:24.4571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMsCz9Ja88ohvhfoy5wK0zgJMzXh+43RXBk4CcvzeDIWNJzgUAREgwZ3D5u3+IpW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7281
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
Cc: "Sierra Guiza, Alejandro \(Alex\)" <Alex.Sierra@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/16/2023 5:03 AM, Deucher, Alexander wrote:
> [AMD Official Use Only - General]
> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ma
>> Jun
>> Sent: Monday, May 15, 2023 2:14 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>; Ma, Jun
>> <Jun.Ma2@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Koenig,
>> Christian <Christian.Koenig@amd.com>
>> Subject: [PATCH] drm/amdgpu: Fix the EPERM error when get user pages
>>
>> Check and pass the readonly flags when set amdgpu_ttm_tt flags
>>
>> for readonly ptr pages. Otherwise, there is EPERM error returned
>>
>> during the KFDExceptionTest.PermissionFaultUserPointer test on
>>
>> ploaris10.
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index d426333e865a..85d1087439c0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -1036,10 +1036,17 @@ static int init_user_pages(struct kgd_mem
>> *mem, uint64_t user_addr,
>>  	struct ttm_operation_ctx ctx = { true, false };
>>  	struct hmm_range *range;
>>  	int ret = 0;
>> +	uint32_t tt_flags = 0;
>>
>>  	mutex_lock(&process_info->lock);
>>
>> -	ret = amdgpu_ttm_tt_set_userptr(&bo->tbo, user_addr, 0);
>> +	if(!(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE))
> 
> Space between the if and (.  E.g., if (

Thanks, will fix in next version.

Regards,
Ma Jun
> 
> Alex
> 
>> +		tt_flags |= AMDGPU_GEM_USERPTR_READONLY;
>> +	else
>> +		tt_flags = 0;
>> +
>> +
>> +	ret = amdgpu_ttm_tt_set_userptr(&bo->tbo, user_addr, tt_flags);
>>  	if (ret) {
>>  		pr_err("%s: Failed to set userptr: %d\n", __func__, ret);
>>  		goto out;
>> --
>> 2.34.1
