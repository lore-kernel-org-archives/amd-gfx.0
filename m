Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2071AFF886F
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2026 00:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E74110E1EB;
	Fri,  1 May 2026 00:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cFhSEVgJ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BD8910E1EB
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2026 00:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqOYT40YJMyCXp0Qoni7s8P7nvFWBoUvTG4vYOq1z7Bq8RhAgMk6BRQ07XIlCrC82g4zDPq8tyYBYUhJGsQkEDjyxDhFlckVAF25BZa5Oj0LhLbbuGYY5SMZIDaO5aCeHkmKPDI0ckouspqdPwEIbZZcQNfL3qvAuTqV+cf450CnLt6qACVzGqlr3bFgpB9sdEmu9qHqmK81+15KkXvWJ+iXtoVAp05asdF2ZFPu8HBax8QdJ9SCqG0vcmwbyYAYL0XbW+klb2wNHxAZZZBhrsozdDKIkVow2QWcinMkcaRqKfZ1IZpTGUxNhakKq2FhwmoWEFJdTOyfWZ92oWxFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0U9Dc27e7fFaD54eWZZEx9kMPt5jvsv0ygBJjxzpyfc=;
 b=AzV/2/VyTXnUAMhOE+fr4ICjnGhT0yl13fdlDqtyRiizW33NdEKP8ytJ/fdIUbfSWqdy3LiJaH3yRRfp8BKnFhXUMZwsBQgchMnyJzq28vQzj1xJcm/zbl28MDkEnQ2ZbwI2F2iJQHZQMJDPHGpXPAOMi+Qiah61fiwxiaEdpFvpzmgkcOdfkfZyGWPv2HUCamTs34v26u13j/MntOHW42DwkyGqiS++NyC2XakNACIfc0E9jHeSRnlCtqUjK2fNrjxKkGTq6Hpd0dYRDu7QHlMsxPwCZ7wMMvhejUMMdQy/wztN8hF9YD0ep8j4Hs0rb0AlV4a5YuLtsbGsndyIFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0U9Dc27e7fFaD54eWZZEx9kMPt5jvsv0ygBJjxzpyfc=;
 b=cFhSEVgJcxjvLmJlX3F5xBUvw1Uj78YxNz4AZAh1gFDS65XnSukPKc1JHcrg/6Aw7RIa5jbqd16pwZKmyxqlKvLfkMY2TbZLInV3QsLtKOQcVGX3T0X0cxnn5+S9gnwUrVPk0KAINcIpwn9QDRRZ0aSLm7uELTo0kxNBCP6vt6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Fri, 1 May
 2026 00:50:34 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::715:65fb:c3fa:9c26]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::715:65fb:c3fa:9c26%5]) with mapi id 15.20.9870.020; Fri, 1 May 2026
 00:50:34 +0000
Message-ID: <452f98fc-4990-43ce-b0f3-759d95b62c44@amd.com>
Date: Thu, 30 Apr 2026 20:50:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdkfd: Add input validation for SET_XNACK_MODE
 ioctl
To: "Kuehling, Felix" <felix.kuehling@amd.com>, vitaly.prosyak@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
References: <20260430201803.90458-1-vitaly.prosyak@amd.com>
 <20260430201803.90458-3-vitaly.prosyak@amd.com>
 <1c1b5033-9624-4989-8353-441655139fc6@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <1c1b5033-9624-4989-8353-441655139fc6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0052.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::7) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fdcd87f-3ccf-4d74-1a51-08dea71ba6b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: Z3PT9w+wYhchkl5FJRfHEwOc8VVhBjiWa4TYZxOf5CD4SOG1P7opZ6/ecicOGA9JH8FCmI/ayYlT51+8ZH77JdlLUwk3Q+EJsT4CM55y44t7nTw8NjEbMUc3pHCEnYy8d1qDWdTGPeEv279Sd/3bigjv7O/CgaiwjObTwF2dOcI8rH7NRHUqnnvD3CnAB/yzsknvkwKDC/RZmkitJgdQXE7dH6Fw0WGO0Yw7S7xD91deQe3Jj8fabj5a/Y9CVzfUU0RkFT2f0czdfg4A+ln57xZQ71CIADSeLx6W/x1fz9r3vY1PGnbCJNrkQI5nSrqNAmWSJC7tjkZz89vlMOvKqXtdvftMtQMmi/tJh9fSZ2KN81p1eTzbFlyXhGeSaqRKNAXqk1WflMYKJaJnGNl8j5JTRxh2u/NpKKNihlymsu8xyCXoB0lsa5ySelbEvKFDVTux1HAedeOan0BIjbJHsYagX2uxG4GgacMHVkC5mxrKqGBUddlVUr657P1q5Xj9owiXUQixxjpIAN463ksrk4HUgdilUyA1fEz48QF3EIal21wFiQKLpm6zRrLW0AbIRwu3okuliv9FsZ6LPJ5uva6rzWyxLlhjYhwlegH/2neEhI5E8DW7IFlSWG8eLVrMnBPZLjso9DdffDgcvjrgJt3Jt37Um6MRMLbVrLKZQMsW9XkKJGIBNUcnlMYITSql
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFZ1OTFueXUwRDZVVHdqdERMM0YrNk1ZL1JqQTVmQmxzK1FVNlhlSFZ6ZzhU?=
 =?utf-8?B?eGZ2Q1h0UEhEWWZkVVgxV0pZSUhzcVIwT1R1Q2J2azdGaTB1STJJREkxTnNq?=
 =?utf-8?B?NGNhazdTL0oyb3VIcnc3WFhzK296eUV0Qkk3VVFYL0ZJRjNXRWJiZVNjQUMr?=
 =?utf-8?B?RDU1OU14dHNVRnFHaHVCRDlseDhWUEYxOTN4dDVuU2NjSElzUEh0WWl6Z25h?=
 =?utf-8?B?TXRTc1hBWnhuQXlNaFVPdDFQeWNJL21RT3Q2K2FTYi9uSzF1T3kreTFtMVUy?=
 =?utf-8?B?R2FFTk1WYlk0RTR4ZzJHcmRnQ0dxM1dWSmJSRHdEcWUwbzd2Tm1GeWgzTWwv?=
 =?utf-8?B?US9LMW5DQ204eG52RXVnK2htdUlYTFlZbUt3VUt5Wm9QanpWUys1a1F6dEpu?=
 =?utf-8?B?ME9hYWtadjhTNlQ1NytiNUwweUhnWUZGdVR0ZGVjK1dUMUpPNC9KWDR1QUJp?=
 =?utf-8?B?QWk3Y0QwMXlodlZhV1lsQXlQbkJSbC9ybGEzZHFVR0h1dTh6TUJEWVNlVFZi?=
 =?utf-8?B?T2ZiRU5DSVhoVlRBdnBoYXFhV0E4TDFMcldjVXpTaHZvcXptZ2tiOHFmSlYv?=
 =?utf-8?B?MEppQnRzQ1dCa2VzZ3dCd3kxYTBPTUQ5NWR4NEZHYzhiNmw1cWo4d1FUUDVF?=
 =?utf-8?B?UHVrUDZQZ2ZqeG9zMjVlc0RuSnBuRkl0eFBtNlo0dk5mVk10Zk5ESngrZFE3?=
 =?utf-8?B?TWZwMExMWGNJN2wwdklRSGFNNXBVelJuK2lBSjZzd1VOS1owMml6dG1yUVdT?=
 =?utf-8?B?YUJWK1FFb3QvTkJodHo5U0kzbUN2anlXNmw4VGxTSERwM2NhTHZyMklMY1NR?=
 =?utf-8?B?cngyajQycU9aRzdmQlozaVkzOU9JVHU0dTlEcG02ZTR0YUd0UnFhbFFsNjdh?=
 =?utf-8?B?VXFFZm1KZllndTFZK291OVNtdUR6VkE1VHpvUjhwN2ZIb2VMZk1MMlcvclpL?=
 =?utf-8?B?K1BVV2o2S3EwNzkvN1lXam1hYUF2TlZyOFY3T3h0d240QzhST1grUTV6VXBy?=
 =?utf-8?B?cE5odkRNN1ZXaUFjSXVBMjc1bjhxYktCVzJERFcvdmsra1RzcThYQ3JUd0FJ?=
 =?utf-8?B?WjhLTGpFQldDdXlRVTUycUxiSjg1VHg5eWZ6NmtOaDBBWHdDczJmRE91dmJl?=
 =?utf-8?B?c21uaXoyNytEZ3dXa1hHZHRtVTVMK1B1enQzbVVXQzRhd1IvcHdlaStrT2NM?=
 =?utf-8?B?b1JzektVbzU3ZjJzbmpyTDl3VlBUc3RhUGltVEZHMU42bHVrMEdSVElIcXln?=
 =?utf-8?B?MW5nVDd4UkdqMC9TVk9lTDFQRkVQYk5STE1ENDVQTHdTdmx6L1dzYkhqMVRt?=
 =?utf-8?B?V0dBZXArbkd3c1A5OEh6VzBmcGpWVlo2cTNIZk04Y3FmcmdoTVc2ZGdPQkZt?=
 =?utf-8?B?ZnN5YTQ3K2VrT2c3VDZ6RFExVjRhNjQ0NldrQnhWM0NlMWZBc0xOaU1WUnMz?=
 =?utf-8?B?cWFHc1FrK1NyY09OVkJtQ3B1eEh1WGJHZy9vNitOOFoyanltekt4UmxjWDVX?=
 =?utf-8?B?Ym92Zk10RVJHRkNTUzJKTklraG0rMmtHTk82Tm9jV3pxdC9abVVWTzhPdkc4?=
 =?utf-8?B?Vlk1aEhQclZkS2J2NG83MCtuK2NXVmtSR3hiNTNDOTJxNVIzaXladlBHTVFk?=
 =?utf-8?B?cGltMm85V3lJb29tRXV3VE13TXpFQUVkWGhhcVYrdlp1eEFnMFZhWDU1T3Zu?=
 =?utf-8?B?d2RjRVVnVzlaQXY0RHVrcmJHbGUrV096am9IVDh6a0RmdG8wRjd2bGxuZHp1?=
 =?utf-8?B?azRtRzROYUJIOGJWdHA4bUhCT0FBLzRoeFJSYzFsRm5ra0xGQzRTRDkyeThQ?=
 =?utf-8?B?aWpTOTZHNlJGVU1SVmlNZ0ozWi9LQVZrbkJVQkZ0bXNNMy9KK0lqUE9sSXVS?=
 =?utf-8?B?dzZKdEFoTnU2K0tHdzRHcGJrdHJyWWN0eFhMM3oyb0FBUnhWZHVRcGt3QmFz?=
 =?utf-8?B?SHV0YXI0UmlqNi9Lb0M0SE9PSlFsNzRINXVkMlBUc0tKZEhXSjFNclRVSTNo?=
 =?utf-8?B?L0p6WWx6TlIySnNWeitrZ3JOaHZVeUtZSXQvQlpZNXhRV2d0S2I1OEZkbWVX?=
 =?utf-8?B?WjhxbWtpQk9BbTkwa2lFNWMvQlNuR1VuaFcrUzljZkE5ZVpoWm54QmUyeDh5?=
 =?utf-8?B?OWxOL0pkT0daTGJoVHVJc0lGNmM5VHRJbkFzMWFiOFBvMXJTSGs1eStvTm9h?=
 =?utf-8?B?dzVOaTFTVnNobTRLYVAzK0VLVzB3ZUFJaGVDZE9GMWlsSXJqYks4SDcxQXV3?=
 =?utf-8?B?R2FrQ21WSmFFTEN2Q00wS2Z5Si9Hc1NpSjZ2dnp6ZEExSXJIVHB0b09kTGox?=
 =?utf-8?B?c0s2QUNMV3B5elJnYWd1ZjkzanNqbWFvWGZiZ0VKczdxc3llNGVZQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdcd87f-3ccf-4d74-1a51-08dea71ba6b8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 00:50:33.9321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpNEiPEQAr1z9NmsmrDInPihPeto5ziUlKzl/ZRGVFgAo73/geqApO1zxAs+QDm480TWXOhQOfmfY2ndz3fzJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
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


On 2026-04-30 16:55, Kuehling, Felix wrote:
> On 2026-04-30 16:14, vitaly.prosyak@amd.com wrote:
>> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>>
>> The AMDKFD_IOC_SET_XNACK_MODE ioctl accepts any arbitrary 32-bit value
>> without validation. According to the UAPI documentation, only three values
>> are valid:
>>    -1: Query current XNACK mode (read-only operation)
>>     0: Disable XNACK mode
>>     1: Enable XNACK mode
>>
>> Currently, the ioctl accepts invalid values like 0xDEADBEEF, 0xFFFFFFFF,
>> 0x7FFFFFFF without returning an error. While the kernel internally treats
>> any positive value as "enabled", accepting garbage values violates the
>> principle of strict input validation at the kernel/userspace boundary.
> I disagree with this statement. E.g. for boolean, it's common that 0 
> means false and anything non-0 means true. In this case it's extended to 
> 0: disable, positive: enable, negative: query. This is also how the API 
> is documented in kfd_ioctl.h. I don't see why accepting values outside 
> the range -1..1 is a bad thing as long as that doesn't cause undefined 
> behaviour.
>
> Your patch is changing the API semantics. If you really want to do that, 
> you should also update the API documentation in kfd_ioctl.h and consider 
> whether that may break existing user mode.

Thank you for the  feedback and clarification on the API semantics.

You're  right - I misinterpreted the UAPI documentation. After reviewing again the actual comment in kfd_ioctl.h 

"0 means disabled, positive means enabled, negative means leave unchanged"

My patch would have broken existing usermode that relies on this behavior, which is unacceptable.

I am withdrawing this patch and will drop the corresponding subtest from the IGT amd_fuzzing_kfd test suite.

Thanks, Vitaly

> Regards,
>    Felix
>
>
>> This patch adds validation to reject values outside the documented range
>> [-1, 1], improving robustness and catching potential userspace bugs early.
>>
>> Discovery: Found through systematic fuzzing of KFD IOCTLs using the
>> IGT amd_fuzzing_kfd test, which revealed that all fuzz patterns
>> (0xDEADBEEF, 0xFFFFFFFF, etc.) were accepted without error.
>>
>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Jesse Zhang <jesse.zhang@amd.com>
>> Signed-off-by: Vitaly Prosyak <vprosyak@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 881ea252b3ad..57bd1e78b3e5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1716,6 +1716,13 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
>>   	struct kfd_ioctl_set_xnack_mode_args *args = data;
>>   	int r = 0;
>>   
>> +	/* Validate input: only -1 (query), 0 (disable), or 1 (enable) allowed */
>> +	if (args->xnack_enabled < -1 || args->xnack_enabled > 1) {
>> +		pr_debug("Invalid xnack_enabled value: %d (must be -1, 0, or 1)\n",
>> +			 args->xnack_enabled);
>> +		return -EINVAL;
>> +	}
>> +
>>   	mutex_lock(&p->mutex);
>>   	if (args->xnack_enabled >= 0) {
>>   		if (!list_empty(&p->pqm.queues)) {
