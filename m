Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F320C79F99
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 15:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BADDD10E86B;
	Mon,  7 Sep 2026 15:11:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wD7ll1NJ";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3EDC10E86B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 15:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7QwrrV4om24Yj8dhW/cVsbSwLN8v/aQw6EDclIzMBaXoCTfT6bC/428EzNRVOwoWZ3sjPwPV9F6M0I2yUc2+GlLUVmyfOXQGncqXYCrYVKDY0nUDJPLJtKyeWWi8O5Vu/VPMSxTKyWHRHIAtRO5xeR39WaWQxysTMuzChxxBuyGoO4+spwDLEpAhcKKGSqd0BZQu+fSd5RmWhVrxPMBh+7NEVgzMs8DGRJPH45qFdMpAjmV2lYIqezbgQ/snRbYB2h4DeJraDO699SPRYZrIr/B2rYWKA20keqjhmkOOvnSr7TNVSkoYJKcA2Cx3Iwh8Cu6gzqHIjgAtMd9Ppg7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vHSn8mZu0Kr92y64FcpWqqF/o9WNAD5wPjkt3ELzIg=;
 b=rbMCSW0PI19BAm/bSI/HWqL9ATrf+/S3vMYts8EiyfATKmfYJENtdx4kvYMLm8xYf6oATii+Q6H8qhgo7/lwWtLKON0MJldlooRdGLfABy3aJCSOPXA0Km+Zb9ShL4hioxUGjSZYzEU9klIWSFhPoR0UHNvqdJBmOj8DtDcb9RVUn0lBDYA8FBdFwtnaVEc/EuXtkQod5Hp+JGY3xkmTPdAW1+7Vkf0/pfdwZ7V4mvCanJwJqBHOBPXfp61cC3snhY6ei5xz3eMKkOO/ASwmW9FYI/xcbHUoUQOo8Jeel9K+ZIQDN+BRFWT/Lq3BzPvtoqPWoVQ678tXB6FQdnDFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vHSn8mZu0Kr92y64FcpWqqF/o9WNAD5wPjkt3ELzIg=;
 b=wD7ll1NJhoUEiPQB/1XZBpNm3QizCtIay0Le/78zZvuf+z+Zg1EtWkGq/qK40Xq8piNdxIiyN481oGOXnTvVKghF6TVtKhjAZ47X/CanfGPHUxe+Qjh7DeWKNcQQss5POxFq4XPf9n7spN6toim44UWNMRoSGyM9kpnW82ShRy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 15:11:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 7 Sep 2026
 15:11:36 +0000
Message-ID: <d50952b4-6886-465c-9f76-2eae4895ba2f@amd.com>
Date: Mon, 7 Sep 2026 17:11:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: fix userq_signal_ioctl stuck in
 drm_exec_until_all_locked()
To: "Khatri, Sunil" <sukhatri@amd.com>,
 Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20260907084719.3972-1-yogesh.mohanmarimuthu@amd.com>
 <f9e8f8ff-ee5b-42d1-bc80-4ee22e4f3677@amd.com>
 <7b03140a-5c9b-4e87-92b7-72e8c1d93722@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7b03140a-5c9b-4e87-92b7-72e8c1d93722@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 60152f29-3a0a-4e4d-13d7-08df0cf24f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wbc+IOs5V81XF7uB3ce9LqE2cU3gYXxfe5zWBm5dtqSDBKXg95K+DQ3AedRPmFGDTUaLKuuOMjQC6tQZS8D6nmOubFCZGG0Uh9KANxY7vNRD4qQjdJ6hjyyLx3uCSo2aUNUmoVMOc3nPpelw41FzeylVb/PUhSaNOxQ6A5EAbYjVIpMTxJg1MRtDDdmptyPX4zn4lVfroFSAPYbiJB3XTlzggeVPRp4SeJGKzfDTCRhXZ7AfgqQgwaqN8yRRHr5yROKxwr8U4z0MZNqeXV2DwblHKjltLcqenQm4W71Xk3hMccy2vlDmvKiQhMzpRfvq+SZZoh9+Thzr/CNkYkFVndjciiW3XNILP1m4BTuMky1+BuCFN5wcymaXXtak1yDSgAr6dkwCyTNZe5NlrtAgeGgAQiv2CP/SItENRKpIX9/eV+B/pH5gbYC8zKME2P2JAlSryE74BY+oxwgwD/VwsM1E+vi5+0E2oUD2guKHGE5w1XknWKy0ZS/VInsxl+Su/T5z8lHcQIGFC8FfSkZ7qeFfbl1rLGsfKOPn3zebiqG1MyBcFR3pDuGJKVRzoclqMCyvXpHVNG39kbyQpT4pwAoZ0WdSzkTT47tPoGzoLCnhLlGVDkkGhPKCklIvpjqX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmpocnAxVStCeW1XZ04vZTJ4blQrMFJ6S0VXVSt3LzJFUG1qcjVJdUtWQjhy?=
 =?utf-8?B?a3NIWXFsbzluc3luUkU2QmovNkpMeDVTNHkraGo0cHA1eUdQaUFaNnF6b29p?=
 =?utf-8?B?cnVZL01adDIyRHl6Y25zNWZ1NUpYTmE3SkJsb2t4MGlEVEdtTDBtQ3FNTkZy?=
 =?utf-8?B?WDN2bEFkc2xib0gyZ0tjTWNrZnJrVkJzK0tWeTM4Q3JHWkNaYjNhQUdQaDdV?=
 =?utf-8?B?ZmQ2bm1qS0c3UzBBWG1LUThBK1RSVGt1YVBsZ2tzeFhxUnlEV0F4N3ptYWhC?=
 =?utf-8?B?YzAwUWliQis1Q2dFY0x6dlJxRFhHakxNaFc5cHFSQmszRk5KWUVuQVcyVnJr?=
 =?utf-8?B?M0N3a2pzNWxGZC91Y2s4aElJM0JPZlRqRURFeXFFbWNQTzEzS0lOTWU2R1R4?=
 =?utf-8?B?S2prc3AvN0pEcDVXZWZxbmhrendHOE1ldkE5M3pRL1ZCMlBDcDJad3pMZnZt?=
 =?utf-8?B?M21rM21GaFlQNkVwWHAvN2hxVTA3bUZZdlUzam9oMEhmb1cvRVNrTFJnWk5M?=
 =?utf-8?B?S1dsWk4vTy8yR2NXV3RWejNUMmV6ZENrZ3VWUTVNRjdqQ2Z5WFNhWnBQQ3Z6?=
 =?utf-8?B?NTNMaFdWaDFLOGVrU3JSYmw3TUhzNDNoWU5pL1B5QzNiZ052d1ZYY0hvbmFH?=
 =?utf-8?B?TktDWEJNUHhxaW1wR0VzSENycWZYcC9XSFEwV1BGdzNXQTdCUHpCZDhsMkJ2?=
 =?utf-8?B?S0xUOUVYOHFCcGV5SVUzamFWbS9TSVNPcndPNEtOcjlzd1BTMjVBZjhhZU8y?=
 =?utf-8?B?aGdSVzZNY2lNNmxqaHhybDVRU1FxQUpHbnhRVVY3QlcxTlY3WDBqMStFbkVS?=
 =?utf-8?B?WEgrVzZqekpSWFJTVXFJbHhPUEVzN2c5eW9hN1ZWcGNjbzZzNzFmRkQwRVRP?=
 =?utf-8?B?Y2gzbi9Bb2kzc3htRkxiZG5NOTFhS0Q4cy9JSTZ5WG1CVEZwZG45UzFmdkJu?=
 =?utf-8?B?aDlhTTJjS3NRZzhQRGxSWUZJWFJwVVlOMHNibGhjU21LNGpMdnFaU0ExRXB1?=
 =?utf-8?B?YUgvZWE5WWVIWHQrU1RZYThGbkJDK1RQQ3RKcnBUVWcyNnR6Q1VlSG9WS1F3?=
 =?utf-8?B?VlN1MWZWS3JzVGlscGhJQytpN0ZkbEtuWjQ0cUp2MXpSZUlKNVR4Q1prcTZo?=
 =?utf-8?B?bHE4S3RzYW5kZ0ZkK21SbUE0UTBVZmZZWUZMbzdKN2I0ZUUvTkZyWFZNamh4?=
 =?utf-8?B?K1c5bWM3MXBSS0hPOFZTUzYrTVlCcEd6RWdJR3kreXlzSEFqSU5nMVY3bzZV?=
 =?utf-8?B?UmtxOVdIVmRaemlQK3QvMU9WZGh4dlNFWEtyODVWRXdEbDc0UjR0a0hrTzRs?=
 =?utf-8?B?bmJCL3dQamd0VW5XVDhlQk5mWXhJWUIwL1ZTek1wRG94aHdmbFA2bWtwWEQy?=
 =?utf-8?B?THlTYVNrS2hZMmk3eTBjZkNVVWlYWmprVG9KLzczUUF3NjBiLytXVnQ3Qnpu?=
 =?utf-8?B?d3ZWU05nTmpNcXVIZlJrU0ZVUHo2dTkzbkpmS1ZwQUVLMGJXclk3djFvZFVC?=
 =?utf-8?B?RlRaclJucU9aMUxadTgydkt5OHQvR3Y0Mk1peCtiM29VWTdDR1piaGtLQktL?=
 =?utf-8?B?ZXRSbUlIVUFTNHYvc24xaHlDcjd5THdMTXJPRlJpNXZHVUc1ZTAvamc2T2R2?=
 =?utf-8?B?Ulk1Syt1L0Z5VWdDUWNJa3N3cStQT05GeHJvdFp0NmQxT0NBY0g1UHNEVktJ?=
 =?utf-8?B?K1NjbVRHVWVDbWU2Tm0vWVNXVHRGZjJmNDhtdmZJM2U5OC9aZUVYL1MwcU9Q?=
 =?utf-8?B?cUYxUHgrVGFTcE90YWtZQWRUNkpRTGlwS3hvYzVjZTV2WXNvY0VDbWhQTFov?=
 =?utf-8?B?KzU2UVI1L21zazFKazJBLzRMNDBhSDNib2JJQ0todWxZeDV0c0xjUmFBSk1i?=
 =?utf-8?B?YjdqTURDTytNclFhanF3aTRMRnlWRVlQWDkvSElCMU5Xd3lhbFBQMUdmdXZM?=
 =?utf-8?B?bWFZQkhnWTJPc0tVZERWZFZkRFduMnJMbk9COWZIRk5lUE4xSEwzVzVxb1RV?=
 =?utf-8?B?UkZ3bUlXd21YUUJjZFBHVTBySG1tZE50NWVjcGZac0xwTk12d0tWUnpVWElL?=
 =?utf-8?B?QUtidUFFOSs1ZjgzZHVEcGdtT2dVOFZ1MU5NRmhMNUZscWlvUzlLd05QaWpH?=
 =?utf-8?B?MTFxNGVKWWdPQTFveUF2c1FHOVpkTHp6TVhLdXNpWDk1MHFnOUJiMDVQQ3k2?=
 =?utf-8?B?NGxhSE54czZuOS91ZTVXUXZWODRaeDhpRjRBOHkvNXprQklLL2VtUS9hbUly?=
 =?utf-8?B?TEE1K2FlZDZ0N2RvTXBFN0dlbXJnV1ViZXI4NldYVjk4Um1iMXZGNmpTN0Zh?=
 =?utf-8?Q?9cXbpHrnLnwKlVxpYw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60152f29-3a0a-4e4d-13d7-08df0cf24f9e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 15:11:36.8700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27xG2rWpeCs4tFE41xeudX8wB2mxC6Msz8K1uAMv7gF+sb6zh4bM8QpI99wBlXcC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
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

On 9/7/26 16:42, Khatri, Sunil wrote:
> 
> On 07-09-2026 02:23 pm, Christian König wrote:
>> On 9/7/26 10:47, Yogesh Mohan Marimuthu wrote:
>>> If in userq_signal_ioctl only bo_write_handles is passed and
>>> num_bo_read_handles is zero then if there is contention the code is stuck
>>> in drm_exec_until_all_locked()
>>>
>>> This happens because read bo's are handled first and then write bo's in
>>> drm_exec_until_all_locked loop. When there is contention in one of the
>>> write bo, exec->contended bo is set and the loop is retried, but
>>> read bo is zero, still drm_exec_retry_on_contention() macro for read bo
>>> is executed without drm_exec_lock_contended() getting executed.
>>> drm_exec_retry_on_contention will keep going to beginning of the loop
>>> causing infinite loop.
>> Well that is a really good find but clear NAK to the solution.
>>
>> This if this causes an infinite loop there is a bug somewhere in the drm_exec object.
>>
>> My educated guess is that drm_exec_prepare_array() needs to call drm_exec_lock_contended() even when num_objects is zero.
> drm_exec_prepare_array()  returns immediately if no of objects is 0. If its not 0 in that case order of calls from prepare_array is drm_exec_prepare_obj -> drm_exec_lock_obj -> drm_exec_lock_contended
> So contention is never cleaned. 
> 
> I can patch this up in drm_exec_prepare_array in case no of objects is 0 call the drm_exec_lock_contended like below.
> if(!num_objects)
>                 returndrm_exec_lock_contended(exec);

That sounds reasonable, yes.

Thanks,
Christian.

> 
> Regards
> Sunil Khatri
>> Regards,
>> Christian.
>>
>>> Fix this by only locking and reserving fence for bo only if there are
>>> bo passed userq_signal_ioctl.
>>>
>>> Observed this issue when testing with MR
>>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40808
>>>
>>> Signed-off-by: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
>>> ---
>>>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 24 +++++++++++--------
>>>  1 file changed, 14 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index c270635c9..135e77837 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -572,17 +572,21 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>  		      (num_read_bo_handles + num_write_bo_handles));
>>>  
>>>  	drm_exec_until_all_locked(&exec) {
>>> -		r = drm_exec_prepare_array(&exec, gobj_read,
>>> -					   num_read_bo_handles, 1);
>>> -		drm_exec_retry_on_contention(&exec);
>>> -		if (r)
>>> -			goto exec_fini;
>>> +		if (num_read_bo_handles) {
>>> +			r = drm_exec_prepare_array(&exec, gobj_read,
>>> +						   num_read_bo_handles, 1);
>>> +			drm_exec_retry_on_contention(&exec);
>>> +			if (r)
>>> +				goto exec_fini;
>>> +		}
>>>  
>>> -		r = drm_exec_prepare_array(&exec, gobj_write,
>>> -					   num_write_bo_handles, 1);
>>> -		drm_exec_retry_on_contention(&exec);
>>> -		if (r)
>>> -			goto exec_fini;
>>> +		if (num_write_bo_handles) {
>>> +			r = drm_exec_prepare_array(&exec, gobj_write,
>>> +						   num_write_bo_handles, 1);
>>> +			drm_exec_retry_on_contention(&exec);
>>> +			if (r)
>>> +				goto exec_fini;
>>> +		}
>>>  	}
>>>  
>>>  	/* And publish the new fence in the BOs and syncobj */

