Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6642D10A62C4
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 12:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01EA110E92D;
	Thu, 26 Mar 2026 12:55:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v7kO0NhG";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A73210E926
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 12:55:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcTwo/qdqNKFmZwaBfrLlfNCx5qj5C+uVknVmUjydnHv/t3wzvDrRwZWjbFU6RO7Tly2hN2m2NDU5NExSYoz+vsFtr8aTeRVCqPZA7hnFLBrkpFiw8xfdl6AFrPtOMmR395/H5VqKXLXfVv/fiJ40B4P1TnUVjLuC7cdwHrV+iZs/ev0ywJ3e7rcuEvpfwJLxCBvj6gcyUgoH0qdnQ8U3574LbLFkcYlqMwVwOZIzFO6KULginEUvR8/T4BCAtORf3RuAQRRYKWZRMCd7OslIjJmxNPBJG2vpmSKX2L8L2Xovm4RpGwKUA4l9gCeQbarldykDU16AL0oUjNFoH1nxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cU2Ud5Dpp7nfB/gw/1ys/ufsOyILyMnTrI+/Tzf4uA=;
 b=LNnoIzu4wkkc1vcpaA808VDwL8/osWOlr+uVHesI2RHvDMpxgBZY7YqbV0ISTlcTT47eH11YSIZZQdP5ULW2wu5fMBolu0EpnR7ZCOYHAjdj0lfM4Qvwwfqz/M947CGOsluma6SvAiCNK7E3qjP4N0VkDlIXJse0kZJXBRLS7Kf891poNZUqYs0uxtZQG83Guv+7b3kbIHi1w+MxAGDqlz0hNu7fddbEV4snXDrR0ZvlzGarfhJtwEVYHqwQKZ5eS/zxz8KIx/hiJKos/tojftcdTFlqlyyvQ4vx7rVxBUiMQOkCwk6+beRhPvPvM6Mzto/wL7AKLoIkulTf301eEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cU2Ud5Dpp7nfB/gw/1ys/ufsOyILyMnTrI+/Tzf4uA=;
 b=v7kO0NhGilLiCAuY0kwrmlGX8TjXC5xZB2acfiRXdnrCGV2ed0TZJkWs+lA8SwV+5A1rSh0dSBkG6KOelO2IG8yfmsrcGpoVmboE1XQZj1lAAEN3gBFwB530sfBvJ3rda7pRRPogaQ9YUMHYN7wXJOv1dJsQ/b6i5jEk5khdIDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB8166.namprd12.prod.outlook.com (2603:10b6:a03:4e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 12:55:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 12:55:50 +0000
Message-ID: <b7dfb564-76ab-4ae7-9869-cdb01e873776@amd.com>
Date: Thu, 26 Mar 2026 13:55:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1 2/4] drm/amdgpu/userq: no need to use local variable
 here for return
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260326085601.2665215-1-sunil.khatri@amd.com>
 <20260326085601.2665215-3-sunil.khatri@amd.com>
 <23d8f2a6-b705-4380-8897-93d0612f1237@amd.com>
 <26bef1cf-e636-46f8-b27a-e2840d0bd04d@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <26bef1cf-e636-46f8-b27a-e2840d0bd04d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cef1e4-4808-42b5-9294-08de8b3701ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: GRFR2tsQEPaNOkVQo+hMlZNl6zj+a1z99tGPTGcM1ipuJmNN8Z1A260ecq0O/NAETm7MyFWwFwhihb7Ww/eS4x681P/0YEcc/bWiRLUWFMigC+LVgmyQ0TSbFnYfK48nf/KAofFoIsVNBbX5BwBaXJkbEI/PNzW+2UZT1DPGjBY/gNgO5HAMSMkACwEcjsQtjCxvU0PJOljffevBSQMAZi+qAoGRx6rC/3K4XSTbd2Zh5uQR59v2Kk4nRm7IUYqHw5CBtmGQ52CbE3QwFzDS5Q+6CS+ilvy4ivo2ZiF8Eg4PsZu2BWfQiePa56H62VfemeHOpOkGkAJSQL3JXhpAOhPgozBe0vPUIDJg2hpPtvhnwgAs8cdUOdQa2HoXgxCmhCWH6kDAUEvFOf9Bh63Hy/a44pcGIM3UuG2HvduJ8oK5jNeUfqfS+Ynieu3Z4OeuNMXZt8/crFwmk3LFCm21gh0P6fcyvCxH87K3vJZTcx4zAtzluR0HnFGwI6Jj0xPca7xaGMQlzUmz249YecDTyHSegac5vf9zqaNPu5clKQk1IGmhz59Jskvxm5c5yzhdQwZrnYy4UMNnnGn5gKACy32mzCvYHFGhbzBOPOmYm6I7plPoB0x1s+rQDPmRLHp2WbOSIMQ1asEJD/a1vK69sBueBpq5XNkFuDn1q7ePLW51zL5ij4gd0YqB6m/sSJiV1gfk9RLVGjoY77Rh1F80sjC/5Xj4TmL/veVPj4J6efo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2tsM2lPZm5nMUNFQ1JrTzR3V3FyQVdVZEd6K0hXc1ZiNFE0WXlXMU5Za1Uy?=
 =?utf-8?B?YTR5S3ZxRmxXTlBkaExCVlE2a1hxaWlIWkJxSjFzWG9VTE04RVR5dUw0N1BC?=
 =?utf-8?B?YXJaVC8wOURMcHk2QkJFdW5ZTGYyeW1vdGFQOGFkaGcvaFZCR054am1TRnBX?=
 =?utf-8?B?TjJINGJGNzcvOGZKbFRaMXI4eVZEazZlWE9qZnRiWGRqZzRVQi9pMEZKUGNP?=
 =?utf-8?B?UW1oaFNOMmNDejFkSVg4enBBRkJjbThIaUVDSG1CTGY2MjBmSWg5ZGp5R0xE?=
 =?utf-8?B?Z05YSTNKekJOZExFR1loeU9lejh0VVNYMEs1R1J0WWFKQkkzQkl1S3FSRElC?=
 =?utf-8?B?bHl2RWt5OFdUSVNwbHRCbG5KaCtFN1hmYW80TXpobUpZQ0twTUJqanRWZWdX?=
 =?utf-8?B?QjM4WndSVzlickJzMUVKdjdMNjRWTG1UNENzQSszTkhaUjFCQXc4TXVVa2xO?=
 =?utf-8?B?NjlPTGgwYTRGdzBTV1c1TFpZUlBYWGg3TnBId093WkhDb0ZLbjgwZXFPKytB?=
 =?utf-8?B?eUJXMk1ZOEFpT1U4WFRidDlucUtkbHZMQzdBU1pOK1l5V2d2cTh3WlZvSVBH?=
 =?utf-8?B?U2haWkVhVnRjWE11Vjlid3lNWGdvNmNhNjVBUFNka1FTV1dRejUyWTZ5Tk9Z?=
 =?utf-8?B?Uys3K055WDM2elMzeHp2ZG5oQUh0aDhGa09mZ1BrYTExSHp2dW9DYktLcHNm?=
 =?utf-8?B?djdwWW5yelVHK2J0c3BGUURYUVpzKzg3M3pzamJHUERsK3U5S2o2emp4YWRa?=
 =?utf-8?B?WUFtM1ZoSksrZ3hWUGw0cDlpajZ1Qi85R1BHRnpQanFDNThvRWd5TURLVFVn?=
 =?utf-8?B?ZHBWZnhsNTRiZkZFZWR3VTFZNlRSNGNGenJsSDVXaXQyK3ZXbldwUHA4czFm?=
 =?utf-8?B?V3l1V2Fxb0taR1RYaUIyazcxWlFYNlFabmZ1Nk1PdHRjZTQxV3Y5dDExMnFm?=
 =?utf-8?B?YzRZZUEzM2RYaFcycDNJV2FPckJMUGk4bytOcWFYeDliL2hvOTFuTUZtWVpD?=
 =?utf-8?B?S3l0WWVJTFlleWJVejR4bjNSa3F2RnJ6ejVnbS9hQVhCNlJLZm5uVmRBSmNo?=
 =?utf-8?B?a09SYll3Q09TdEJSODlNZmIxTEhoYWl0aXR4RlI0bm9FNllBWUVza2Y3TmNR?=
 =?utf-8?B?dkh6amhpYjE2R0VXKzNyRXptSUdwTTRST0RvcVg1MXdnckdDbElCNlF5Y3hz?=
 =?utf-8?B?QVo5VXJrdFh2M1Fxb3NpamprckZHSzhKQ2svaDdzZFd1UDZudUNxaG8yM29k?=
 =?utf-8?B?c2o3dVVFVzljVHRaRG1BYmNja05WcmdKZVpCeHo1bnN1R3Vvd1dXQmxZVncv?=
 =?utf-8?B?emhHTm9Xd29PR0NIbnpKdzBxYnEwcExaTlI2UFdPZGV1WnI0b0pQVDc4bzUr?=
 =?utf-8?B?bGJwdUI2elUxT3VUTHIwMk5tbWZPMll3QmVOQlY5YWlNREZwYmYxR3ViRGU4?=
 =?utf-8?B?OTBuRmI2anpialEyRmozOU9oL3BHa1RBYm9BTUJMWE1CYTVRRkRnWEh0OFFR?=
 =?utf-8?B?OEljaEV3bkhNUGJTVTNlSlFacm1qL1RpMmNEbUs1VjVSSzJoa0VvS2RhdTFX?=
 =?utf-8?B?SVUxM1FXbkx0cDJsT1NxK1p2U2VLTUo1ZWVRcElZdzFYeWkzcXpkMTFrZmY4?=
 =?utf-8?B?bUtxSEo2ZXVOcGlqTUMwRnJjQ1BmOWhESktyUGxqbWJTVjRWUnZaUHUyUFpm?=
 =?utf-8?B?RWZrMmU3SExTRzB2YVBYeE5LMGdlQ3BPM0ZnS29MQUE5RVZ2b1lNMUZnQ25u?=
 =?utf-8?B?V0tiRG1jd0ZVb1JHdlQycTRlMVJPR2RSbjdlSHRmMWhyZ09BMmZ3aE9xY1d3?=
 =?utf-8?B?Vm5NZ0hHZDIrY25vK3RROUhQRGRMOWtLQkt1SVNFaDd0MFFuajN1SFBrVlhE?=
 =?utf-8?B?SWZteDRVQXRaaG1Uc05XdGZrWFRVQXg3TVd4dVhrSWMwMXo2S3Y2WGpTeWVQ?=
 =?utf-8?B?N3hMK0RSSjV1a3A5WTZTZTBUZlJDZmpLNXRMVXdRcmxveklnSW5leEI3QTZx?=
 =?utf-8?B?aDZBTEdpSWcxNmVOODdiL3RGOExOdk1jbEpLemVKKzdpd3ZVbEtwbFlTbFNF?=
 =?utf-8?B?cENOdG1uK0VUTVA2dy8rUERqZTRWL0RUbzRJcTZTQXNSdEwrcXNWSXpCTCs1?=
 =?utf-8?B?b2R1TVZlZFZZeVVmYWJCM0FUczBvVFFhdDNUaEFOVG5yZlJ2SVB3RW5pVDlD?=
 =?utf-8?B?MHlkME9qZWhnZkxiVWNsVEFLUnhVckJtMjUxVkxEbXV4OVFaWXh0MXUyZTNC?=
 =?utf-8?B?TktRK0pPbG80R1c1ZXJlM2RKNFBsTy9nczV1b01Ca3FSanlZS2xNeUt4eC9E?=
 =?utf-8?Q?PrfougEB7EbC07IhkH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cef1e4-4808-42b5-9294-08de8b3701ca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:55:50.3971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRMSE/tV/yzTSHb+yVn0jXDsd52bcJEqyK98V/otVnvZSOXEoS72PJWYM3W9jFFB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8166
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

On 3/26/26 13:30, Khatri, Sunil wrote:
> 
> On 26-03-2026 05:39 pm, Christian König wrote:
>> On 3/26/26 09:55, Sunil Khatri wrote:
>>> In function amdgpu_userq_restore_worker use directly
>>> the function's return value in the if condition instead
>>> of local variable ret.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++-----
>>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 2a1832fce6d2..2b07c3941927 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -1222,20 +1222,17 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
>>>  	struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
>>>  	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>>>  	struct dma_fence *ev_fence;
>>> -	int ret;
>>>  
>>>  	ev_fence = amdgpu_evf_mgr_get_fence(&fpriv->evf_mgr);
>>>  	if (!dma_fence_is_signaled(ev_fence))
>>>  		goto put_fence;
>>>  
>>> -	ret = amdgpu_userq_vm_validate(uq_mgr);
>>> -	if (ret) {
>>> +	if (amdgpu_userq_vm_validate(uq_mgr)) {
>>>  		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore\n");
>> Again, probably a good idea to print the error code here.
> since this is a void function and all the functions called here are already printing the failures and we could just remove the if and let the called function print error.
>> Regards,
>> Christian.
>>
>>>  		goto put_fence;
>>>  	}
>>>  
>>> -	ret = amdgpu_userq_restore_all(uq_mgr);
>>> -	if (ret)
>>> +	if (amdgpu_userq_restore_all(uq_mgr))
>>>  		drm_file_err(uq_mgr->file, "Failed to restore all queues\n");
> Could avoid printing this error all together as we are printing the error in the function. We could update the error message.

Yeah that works for me as well.

Thanks,
Christian.

> if(ret)
>                 drm_file_err(uq_mgr->file, "Failed to map all the queues\n");
>         returnret;
> 
> 
>>>  
>>>  put_fence:

