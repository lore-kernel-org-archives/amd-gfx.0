Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23359C83F10
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 05:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 707BF10E042;
	Mon, 28 Aug 2023 05:10:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ADCB10E042
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 05:10:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/7k6spK7uzmV1sikr8pDLJwVAMIEdQ1MoGSe5HM+k4kaMHF2vOpQoABLaFpdwp9fJA56d+wl03yRry9dxNScCtx/mtrgIAsX9w6hZx0S5iZBPzm0W66AWGmw2TJOk7xC+iK32x6ydjBHIpVob2Y8DrPRyiChFV3izDJbSU1UJ7v4O9JqR1sDi49HLZb0o29FA1n087KH7l5/gvhw/Ha+kU0gl8kNuxlHwLkzE2bnyDE7In39ca/8qcf7sbTrmnT385Y3Vugl1MXZjLR019pQ7VwrpuV5F46pQtwJoZjxqu7buEhwpT9S39+IuSSX88FRC0NrnBBisgM1L5JTv+bOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjx/jqd0HEX1gxy80IyGrt+B9a++xLRYLbXD3zTYbIk=;
 b=kZx886qSmR1X4o5/Ffra81sbFaNaaERXRUysKTVWWjWRs5lKPjbs5fBUW6V+yQcem7rOLHjSDBCoy6lsYyT6wOESwgubirq91B0KaGOsohiud8cSU3LMdBBsofV3kZ39EvNj0SUgfS5gY4kLFEBDudAgd4bJ1lepqUezV8EovjZQXOQfSqQ6q1GIqQ3Ql652ULnRVPRLyoRA0tmYtPg8SuIruofb8i8Umi0z5FElhcqIw9w3tUkbl3tchBc8T1SnWRtVvQzNE3NZZyjRZRT0ZtvmwN7GJrbar0FU5j3Dvi+4UDMWs3m6LXNOyU/6sPsk52lGpAQoEzdhFsMX/o9GuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjx/jqd0HEX1gxy80IyGrt+B9a++xLRYLbXD3zTYbIk=;
 b=zyPT05cV7VvbcY0Bo+OZRyKx4o36M8LiRdpPB9HE2rFqWOkX9cSGqlEhDaF6iK1rjQ1/5uLftlhNYD6bl/bjvcm6xvQb4YQklk6Rex93DZMxU7SKzLVbfkcbItJc17H9Rz+I7kkEnXVZDNVE9vK7dswv4c+cUZDHsTN/I3VmCmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CY8PR12MB8314.namprd12.prod.outlook.com (2603:10b6:930:7b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Mon, 28 Aug 2023 05:10:02 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 05:10:02 +0000
Message-ID: <b3df28b7-286b-7e5d-f6a3-ab144846247d@amd.com>
Date: Mon, 28 Aug 2023 13:09:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From: "Ma, Jun" <majun@amd.com>
Subject: Re: [PATCH] drm/amd: Simplify the size check funciton
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20230825052204.1315534-1-Jun.Ma2@amd.com>
 <1c44f172-99b4-3981-a646-48d2b18ba149@amd.com>
Content-Language: en-US
In-Reply-To: <1c44f172-99b4-3981-a646-48d2b18ba149@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|CY8PR12MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: bedb01e6-3b7b-494a-a72a-08dba78508a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRTctTOJeJJ2BfcWrsSdxBPlKYR5Tb3kwGCybZMl1VgllnvNOPPDPj/sOpaEettgoHwMr7mEer3EGM9e8bWG8C48j9BhdFv2ta+EhmSh2a/oSz7coktMoa63mzApXGhSTCJY4N7B6kQbR8xXc8LKsm16Dba1p3g2lu8DUA5/R+VQciilBHx4W8a7oPmiWh2wmR/0qz3zLjTXfaAoeXbmkRFmZo4yDMw7QejMEoCm0uNs1La2zMCYJgXN8VlKiUXMzhANMrLg6MAcrQJfpHoZdxPadG6sdo0M4SwGomcRDkIjHtDhgeI3KAmXMH0A9IqIinjBIaWaydBwMSZ2DZim2Z8Xu788JXiKBcMmTCmz4JyEkV32xvi6N6lIA7CfdcX0Awqpygy9J0pIaodaeF87RdXcatR3LWkb4O5oUsH0CFBfN8D/w6w2vUDxYuix2Z3GXjvbN2TiJsQdFZw2x9NWtpQvIR5FxPayUyzzbPIKxVNGDsk7tyhsP93yoVE+zMo21pkcAjnDDyN37ASfgllrxczsC+A3zkMAqNF4lRY+zMxs2sTjyhwpQq+6dWpyB5Ub2AwPKxJDRXhJXqTXuQ2GiFc2y6we+AwqiQtBpm3tvIEBwFL4HNyIADinuxzyBgZ6woTp+bWE1G8qvSbZ+MHaGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(366004)(39860400002)(376002)(186009)(1800799009)(451199024)(41300700001)(26005)(38100700002)(6666004)(31696002)(478600001)(83380400001)(66574015)(2616005)(6512007)(53546011)(6486002)(6506007)(6636002)(36756003)(316002)(110136005)(2906002)(66946007)(66556008)(66476007)(5660300002)(8676002)(8936002)(4326008)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3FLMWRWdVUzbXE5dGl5NGdzWEpzVHBuVEsyeXZaT3ZxU1Nnc2tPeTJWcTFs?=
 =?utf-8?B?WW9XSGxPdXNkQU42OWdTY2RHcjYrVEJVR3pjb2NQd08wcy9zRFFEOVc1VWRV?=
 =?utf-8?B?cFlxcjh2UE83dlJUeXB6M05QY1VrY3BBTjd4SmxXdUVCT1lTTTF5WE5nUlNR?=
 =?utf-8?B?dEVQY3J3bVMydkdOdHgxYjJEaXpiRzNsV095TVpuUm11cStib0pVQXNxb1FZ?=
 =?utf-8?B?bDgzQkNucC9LL0VBWHhTZ1JZS1RXcmNGM3JCTkdoS2pMa3lGbVdsVGpyVm9H?=
 =?utf-8?B?V0U1S3dPcGZ1OWhQbFFabEhkckFZRGc1T245akhYQ21oRmVLaG42Rnp3WWNB?=
 =?utf-8?B?N2Q4TFdZY2JveU9jWTRSSGp4NU9ZdklEcVIrd09TWUFuREhYdTN6bFBJUExz?=
 =?utf-8?B?QmlxMVE1eG4rblBZY2oxMGJzbnFnM1BjU2MvdE1lTm5WZHNmMGNtQWhjYzlH?=
 =?utf-8?B?UnpuL05qZFlHNHBnclBNMXlvcGVlcTc3WlBGTEtCRVFrOUora3BYbS8walNI?=
 =?utf-8?B?Q2F3aHdjSVNTM25QRFJza1l3V1NZTWo4dlJ5aUdmUTFSK1ZjNjMzRzZYNjNn?=
 =?utf-8?B?L1NKY3FjaW1lMEJrTVNtMzBmZk5RZ0ZibDFaVHMzRVFCRXVWdFJZZGRZd0RM?=
 =?utf-8?B?aVgzclF2czZNVTFRRXh5N29SYlE0S2VkMklkUHBzQzhTa0ZlRzBkYkZFL2RO?=
 =?utf-8?B?Zld3YjVaWFRRN1BoM3d0dlZiUVlEcGUxK09PRCtWQlgrZ3huU1JSLytFY3Zq?=
 =?utf-8?B?MHo0ZjdHYmc4UjhORVFSTk4xSXhURStBZ1VkclVRMzhCaXRtcllBa0ZhUzVI?=
 =?utf-8?B?ZmxXNk9VU3l1d3hjWForMG9vSjJINmxVSDJ3K3BpSklGcHNmaDl5YkdaZGh2?=
 =?utf-8?B?U1N4TVU2Q3JrK1pPOHVKUk9wdmE0Z3JabXpWeU1OSjlMVW9CT3dFQ0RPOFpL?=
 =?utf-8?B?bVVBL1BOZWtrVzUwWVAxaFk1RUM0MjE4YVk3VDlKWE8rMDdBeXJHaUtDNWlR?=
 =?utf-8?B?VXM1NzFmNTlWdmpFZHRmSUNuVjJBbWcvK281QjlsTEdHOUxBWkVvcmFWbkVk?=
 =?utf-8?B?RVpsY2xtQStsUklZSElNaExiTDNHQThQYkNhblBubzdaa0JNMFUrT0RtMk5Y?=
 =?utf-8?B?QTE1MG1SZFNobGhEY3QvSmJ0eXd0T1F4V0U4ekxVMFlYYjhSM2kvd08wazBw?=
 =?utf-8?B?eWR6bkkvUDkrektibjNkM21OUFl2T1lBRVhKVG4rNGd3KzF2YzB5cDRuZFJn?=
 =?utf-8?B?RTE3bDl2TjVNRzlvcnNKLzhnRDlvQjR2SXdNcm5TcjZqOUFQZHRKMElNU1Z1?=
 =?utf-8?B?SERjMXlQY1Y1V2ZWeFhzeG9HYVR3K1VJcWNGK3JPRUh0eGZLYTdoeDdqOVJo?=
 =?utf-8?B?Q1p3VWp5cGdoaUF6bEFvb2VnT2kraWh4R0NUTDU4dGlrRXM0U3htRXpRRktn?=
 =?utf-8?B?eVVTREY1bnNQbkdJemEzVWIxODFuczM5R1dMRnk1S3NxZXU0b3JxaUZNYWZv?=
 =?utf-8?B?cDlUTmFURzc4NkU3TmV3S3l4UHFGNWJBeE5VdmYzVHluTTE3cFVYbFJ2R2tl?=
 =?utf-8?B?VVNwM2pOVmNIMTlwK1pmL2ZnSXdKYlVzZXV1NnUwSGpsUUdZY3ZrUlNhcHVL?=
 =?utf-8?B?cUJGd0NwZy91SFVWM0c3N2JZRG9lbU9XRW9XQmE1MU11TnlaQ0ZFUXdzTE03?=
 =?utf-8?B?RDRYZUdVRlhjcEVDVmpMeFd3NGN6a29lVnlhSW5PeDZXckpmT1hwK0dDL1BM?=
 =?utf-8?B?bXc4WlcvUnU5VEFmeHJ1bE5taUxCZ3BHNFFVdS95cHJlU1grMENLSDhPY2Qw?=
 =?utf-8?B?eGlEMlVqYTh6ak1LUkRzcE1KRDI4UDJISXgxakxTVUd0QnN1U0FYMG96cGll?=
 =?utf-8?B?cWxYMGNZUnM5SlZmcWNlV1UzQUJ1S1NmSWNsUFg3ZXJQUlg1dG9DMWdXZmpH?=
 =?utf-8?B?VUovM1VOZG9JZDFtUlYzMkNFeitKVTNxQU4vYzlZSEdyRFFFNUVkdEdQS21r?=
 =?utf-8?B?Q0cxQXBkdlluY2tlM0NLV1c1M0N1Nmo1K25vNlhBam1JN0VGV1gvN0ZmbHds?=
 =?utf-8?B?ZVZZRVdEKzNJMUdwUXFkSTdXVm5PSGEwSWh2UXlVa3RKQkc2aE5ZZVkrOEJy?=
 =?utf-8?Q?g/wjN18WutJ1tT9qN5JoGABFB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedb01e6-3b7b-494a-a72a-08dba78508a5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 05:10:02.1957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGY9cUeD0IavgsSob4NqOIHnhSgv4KUrt1nwhIlzxQaWdDw4PU2gW8E/yV0rkBo6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8314
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

Hi Christian,

On 8/25/2023 4:08 PM, Christian König wrote:
> 
> 
> Am 25.08.23 um 07:22 schrieb Ma Jun:
>> Simplify the code logic of size check function amdgpu_bo_validate_size
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 28 +++++++++-------------
>>   1 file changed, 11 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 807ea74ece25..4c95db954a76 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -480,7 +480,7 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>>   		*cpu_addr = NULL;
>>   }
>>   
>> -/* Validate bo size is bit bigger then the request domain */
>> +/* Validate bo size is bit bigger than the request domain */
>>   static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>>   					  unsigned long size, u32 domain)
>>   {
>> @@ -490,29 +490,23 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>>   	 * If GTT is part of requested domains the check must succeed to
>>   	 * allow fall back to GTT.
>>   	 */
>> -	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
>> +	if (domain & AMDGPU_GEM_DOMAIN_GTT)
>>   		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>> -
>> -		if (man && size < man->size)
>> -			return true;
>> -		else if (!man)
>> -			WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");
>> -		goto fail;
>> -	} else if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
>> +	else if (domain & AMDGPU_GEM_DOMAIN_VRAM)
>>   		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>> +	else
>> +		return true;
>>   
>> -		if (man && size < man->size)
>> -			return true;
>> -		goto fail;
>> +	if (!man) {
>> +		WARN_ON_ONCE("Mem mananger of mem domain %d is uninitialized", domain);
>> +		return false;
>>   	}
> 
> That change here is not correct. It's perfectly valid for userspace to 
> request VRAM even if VRAM isn't initialized.
> 
> Only the GTT manager is mandatory. That's why the code previously looked 
> like it does.
> 
Thanks for your explanation.
How about changing the code to the following?

+       if (!man) {
+               if (domain & AMDGPU_GEM_DOMAIN_GTT)
+                       WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");
+               return false;
        }

Regards,
Ma Jun

> regards,
> Christian.
> 
>>   
>>   	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU, _DOMAIN_DOORBELL */
>> -	return true;
>> +	if (size < man->size)
>> +		return true;
>>   
>> -fail:
>> -	if (man)
>> -		DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size,
>> -			  man->size);
>> +	DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size, man->size);
>>   	return false;
>>   }
>>   
> 
