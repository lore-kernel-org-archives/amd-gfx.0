Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371CDC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 19:26:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B02E810E4C0;
	Thu, 24 Feb 2022 19:26:48 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C0D110E4C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 19:26:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGU5Cus7KbmGPiuM7OQiL09J/KwUtFj4a3LLD8iE+AJwngCdEyE6kQWm81RVjsgGZwMyvLEusfFM4Cq15FPOtyis+2nQ4Kb1HD+HYwDJM0QCcQMO/KcONXJHo6oLOZKXakypFLXz98CTtMkn0vhozsAtBt/o0pZmQ3oTf82KO0T8M3tQqz3uziaG1I0m4mn45/UJEJbPP5OUvRCastA56BNLlKsjxrlMfpw257XVUJh9vJQIhWYTqa13WxIC+mZ9QDrk4l+i5v3QEOMOHAdWWpov77lQPIUHuHcKDobVbqt9aW9YlzcLPPVp+AOp1kVVx/XREV2wuQh/NukiYv5MIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCoo7UinzWUZjMxGdgK1XD1ykaINakrtm5MnkInt3fE=;
 b=k1IOFxpAYkdjR3sXmIsOJ3jn4o71JQp7zuBYfY4TUZ2eq9orINHBgzqUHsEBU3J0wqEOKpBIdXM9G6snV8QU2XAqfIABjy3dYOsRIcUd7xf4uZKa3hwg5ehdppJlNMwpNlesSwjrWQiZcFXh3tNqN+OxRC145vFvEmSJPTHTKM0J5Gff6NQlqjmpew/lBIhdq0VxtpK0b7vU71DWqmCewToIb904ku1QUwY+TTf2RaNlfOsFNuCNcfLyLZkdlQozb5VgTwdUpk+3HIybvmw/kmWIVCeSn4SFlMLxOcsHapDWjr2OXbWsDAzxvRzisy4Nu2obh73KQRkmM9bcucfq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCoo7UinzWUZjMxGdgK1XD1ykaINakrtm5MnkInt3fE=;
 b=tKStLI+wJfQvKZjnyX0gBDU/Cag7U9qSZ2iJSE+RQf2082ud+/l+Fo6OpPTvsxDqDV25gYzPXzcd5yDPC6xyUknF+AYNBjZrds7ckSocyx3fSJkt2u/binWmxrJoC/HPOJbBAWZM77pA3A9mANnHQ8rMvrwPO+jCTqwYjg5MJIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BYAPR12MB2677.namprd12.prod.outlook.com (2603:10b6:a03:69::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 19:26:45 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3%11]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 19:26:45 +0000
Message-ID: <ad31573f-f2d7-85fc-aee1-b54687f99654@amd.com>
Date: Thu, 24 Feb 2022 14:26:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: Exclude PCI reset method for now.
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220224180521.485627-1-andrey.grodzovsky@amd.com>
 <CADnq5_P8j4mBRH1eJmNkof6bTc2W4cLafMVmZiwhXxhg5t5_HA@mail.gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <CADnq5_P8j4mBRH1eJmNkof6bTc2W4cLafMVmZiwhXxhg5t5_HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0051.namprd20.prod.outlook.com
 (2603:10b6:208:235::20) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f12650f-6132-42fe-9bc6-08d9f7cb97d6
X-MS-TrafficTypeDiagnostic: BYAPR12MB2677:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB26775EAF7426AC3B1EB261B4EA3D9@BYAPR12MB2677.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QFoS+aQeP6Len8NySZPbZZoB2LbNiAsHvQvL2Hb0DAVPD23EuCils+m2lR45f9TpeXdX10Lv85tGTm7/X9Czj39RqpBb5hgX+to9bjEyOAak6mcwe1e+puKOtjQ/uPMRZH6Ah7TK5z+zKSz53G3hc6/0jn4i4xVak8ZzWkPh+oiETDDam/A9Ubng+b2IUYO1zjRIpWI+bpQXQKGhBdv6QmcJ+KqjscA2tvotu3FCP2JI9J4/2CWvYen38za0sCzE+5J6IN90j0aUWsYGLGrSKDpTtpPlhNYVTEky/xlrrEg9U04LM1Hyrl3KxPc/ctqILP1TIvEatLqyiVQJ9mGiV0ZrRuEmDJzdsGFFxnAUoc72Y+FrOMxIJ+fXH40mbXKLmDx07ld2lGbqQFzg3ROaAcrGPZOlFq+Xysv/h0W9r3agXkd9/jqVoFNv8GF/CTfzDXammeVAzix+TYA5ZEIgblLqWIsuGjAIAtPIcSVBWPHxniw91Fj1cEYqmWn2Gh6yWrjS6yhw1L+EIbqnb0onV1Ldz3BSyHYptY0nZ/OcKap8I3E7RHx0h57BWIC9GJtE41x+OLzqKehyd5fZ+jg0ZEvVqcdC2dU8YgPt5qZHRfCPBjLShNVMLisxplbk54nNbrKvz7gFfrlOJ2CywvQReN0nNTKqaz+IyR5o5ivnEow5QAaYL94VfAnFk+d9RTPOcNJfJ+6AfcwBMUxzfJmpnsnS7O3vZ6yKUBqq+yd6wWKnaqTw7vDboz6JEoirHDRJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(4326008)(44832011)(38100700002)(83380400001)(8936002)(5660300002)(31686004)(2906002)(66946007)(66476007)(6486002)(53546011)(508600001)(186003)(54906003)(6512007)(6666004)(8676002)(6506007)(316002)(31696002)(6916009)(2616005)(66556008)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkMwTyszQlJnYndEam5SQW44Zk5veEs1QVY4dkVmd3BMNTVLZVR3MmluM0Ur?=
 =?utf-8?B?LzJNczZudnF6L1EwQmhyaFNvTW80UVp3WHhyRHJMNDFKREpyUUNIQVhsMmIr?=
 =?utf-8?B?elJmSW1VbTh5NnJkcjA4VmVUcVRzay9Ldk5OWVZNZzhWZTVNeHppc29maXpX?=
 =?utf-8?B?V1BpYjhWSldzMlFyVVIrY2R6V1NtWmlpR3NmNjdRNTVrc1BYY1JhSDJ2bHBV?=
 =?utf-8?B?TURKeTlFY2pKTUlzdUEzL1JhT1dZRldzMkpySTV1SENNLzQ4MThDeDNXRjJ3?=
 =?utf-8?B?MVNvOEs3WVNacWFTVWVKd2xGVmEzRkh6Yi83SXpCS2ZPNitCR255SFZkOEdy?=
 =?utf-8?B?ck9NQkpKTEcyR0phSm9OSzZyZmU3aUZ1bTJlZmRBa0dWdVpGcjhoOGhzNytH?=
 =?utf-8?B?aVdLWDVySUpkaERwQVZKTEVqUTlZcHV0bG5hYTFYRVUwRUMzMko5OWp6bHNz?=
 =?utf-8?B?QmlWSHRUWDl4SlBZRHYzZ1V0T2M5bGNxQVZlTk5UVUh4blpsdkhBckRhSHA3?=
 =?utf-8?B?K3lMalA4bVZJNUJURy94SGphL0VGelBjUHhmN3VZWE1sVktMUktIZTdsZWxT?=
 =?utf-8?B?YXpQZVIrUjVTUWE1VHVKOGwzczVVU0pZV09EQUJRSWtqUHRQV0drdmVKbG1s?=
 =?utf-8?B?WmlvWS9aOW5zeThYR2loOTJaN1BaUDhDSnUzT2MrY1drb3pPYlVKYVMvR2x1?=
 =?utf-8?B?dU9pQzFFdjNXeUg5eXFzcnhIZnR2M2U2ZVd3SUU3V3NjamZ6YVZ4cnVvTm84?=
 =?utf-8?B?OFRTcW9DRit5ckl1NVdWbUUwMU1Id2NBcjZ3dDZNbHVweEdTYldHSzVneVpQ?=
 =?utf-8?B?T2NkczVCa3FhblRFREFYTU0xdDlBQUV0Y0tpUUhLQk9SVFVsbEYzTDcrbFV3?=
 =?utf-8?B?SXlGc0kyRE5tR2tHbW90NWRTYm1sWlF5UFVoOGo5VmxtSWRzTCtaSUpTZDlR?=
 =?utf-8?B?M2IrOEVpY0lwc1JhKytTWlpYT1dHVDM0SGdnWVo5WWZNbEpFVzVsaStEdFRF?=
 =?utf-8?B?RDUybFBZNHBVMFNjN2REaVc5T1V1YXdsaDJRWlNhMmV5dFI0c1RYRFRMQlFt?=
 =?utf-8?B?dFBxWTQxd0RtdkJud3d3aGttM1NDaFc0L1JkRCtSblVzUHZJTGFoSTBWSUd1?=
 =?utf-8?B?REdJaDRzRS9YQVMyNktSVkxqeUU2dzg2VmFCWFJaL2lqSUdibjUyUFU1MllU?=
 =?utf-8?B?QU1pcjFGWkdtYjJGOGFONElEbDNTYlJxVFRpUW82UitrMitOMUF5MGZVazFX?=
 =?utf-8?B?NE4rY0c4ZWhyMEoxVXFPV0tMSENUUmZHTGFnKzlERENGblN1NERtWmw2OE14?=
 =?utf-8?B?eVd2NFIyck8xYmZzK3ZKeWM1dWd5OHhXbXh3dWsvVUIwbmxPY0hCUCtOc0ox?=
 =?utf-8?B?eTBXZ0RMbWpaS2VNSWdVMkZSY0pyaVRLcUNSWnZKQWxmeGpwSHJBZzNGbFBB?=
 =?utf-8?B?Sk0xTlV5a1g2NUlUWVNyQ2h1N1FEcVZuTVlrUkxsc1daNlZOenEwU1BGSXFi?=
 =?utf-8?B?YWZaU0Z0Q2R5NlhGdm9RM3pUNGU3a3hoa3VPSncxKzk5ZGlTc3Jwa1JGYTli?=
 =?utf-8?B?emVzK05Tb0hyQ05ubFhtOXlOUURFVGFKcEFCYWE5VHBBa1Rxc3l3Y3NMVnhr?=
 =?utf-8?B?cDN5Ym8wMUZEcnpzNDlIMmFIZFkzVFVORG9USjg3eTZGdjVoT3Fjd3Q4RmNI?=
 =?utf-8?B?ZEowNU5rbko3U2lnQW9PRHJLSS9pYTl1RUVoVGFrTUtSRFB2UHY3dmVNaldJ?=
 =?utf-8?B?aGRxUllQdFIvYnZGZmEzUnZvbjFpU3J5ekw3SnZPVnA4VnFFNmw4a1pvMkc5?=
 =?utf-8?B?Umh0SkgrbEpiSnpVOThaQXl5MHRPYjBZYkdTZUNkU0RERmdDbWI3aVdhUE1B?=
 =?utf-8?B?blF1V053aXduM0FmYWFkS0FoeVRqQnFnUzZYeEZsVWlqUUQxNVlpZlRPbldL?=
 =?utf-8?B?SHR6UCtWUktVaGlSTjBRb05ydzQvM2FnRFB1TWZxSTJRWVVNZWthcGlDbEM4?=
 =?utf-8?B?dnN6V1BtNUJzUm5TY2tZb2svWFMra1VSaTJuclZjQ0tpY3YzT00rOGZkOXFu?=
 =?utf-8?B?MVIwZE5MQXFXVHEvZHZxMVlmNlhleWNaakZ1eFp5R3k1MkFwZ1MwbWt5NzJX?=
 =?utf-8?B?ZzF3RFZuTTBhTHNnSEdrNU10bjdDd2V5ZXlOZzFOdWtjOGtNNTdBdnV2cVBo?=
 =?utf-8?B?MFprVkg3R1cwSTU4N3NmWjN0ZSs2SHpWeEFCbmFNbWhwZDJla1FaVkk4VmN5?=
 =?utf-8?Q?mEOESaUZvZfSYzhEh6IZ/TiKA9oFlNblq39jEZNdks=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f12650f-6132-42fe-9bc6-08d9f7cb97d6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 19:26:44.9669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9kqYDS1v+mgIWD3nqSLxHDJTo3PHkhxXh+/kKsDHq4E+eyjxhhul47Ou+XDx6t9O3IxSi7U0vLwNWu0oxKt7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2677
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-02-24 13:11, Alex Deucher wrote:
> On Thu, Feb 24, 2022 at 1:05 PM Andrey Grodzovsky
> <andrey.grodzovsky@amd.com> wrote:
>> According to my investigation of the state of PCI
>> reset recently it's not working. The reason is
>> due to the fact the kernel PCI code rejects SBR
>> when there are more then one PF under same bridge
>> which we always have (at least AUDIO PF but usually
>> more) and that because SBR will reset all the PFS
>> and devices under the same bridge as you and you
>> cannot assume they support SBR.
>> Once we anble FLR support we can reenable this option as
>> FLR is doable on single PF and doens't have this
>> restriction.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index ecf8c307baf6..78cdbe3c4a9c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1539,6 +1539,11 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>>                  amdgpu_sched_hw_submission = roundup_pow_of_two(amdgpu_sched_hw_submission);
>>          }
>>
>> +       if (amdgpu_reset_method > 4) {
> Validate the other side as well?
>
> if (amdgpu_reset_method < -1 || amdgpu_reset_method > 4) {
>
> With that fixed:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


Done

Andrey


>
>> +               dev_warn(adev->dev, "invalid option for reset method, reverting to default\n");
>> +               amdgpu_reset_method = -1;
>> +       }
>> +
>>          amdgpu_device_check_smu_prv_buffer_size(adev);
>>
>>          amdgpu_device_check_vm_size(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index e18356fff710..5a2ecc65951d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -829,9 +829,9 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
>>
>>   /**
>>    * DOC: reset_method (int)
>> - * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco, 5 = pci)
>> + * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
>>    */
>> -MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco, 5 = pci)");
>> +MODULE_PARM_DESC(reset_method, "GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco/bamaco)");
>>   module_param_named(reset_method, amdgpu_reset_method, int, 0444);
>>
>>   /**
>> --
>> 2.25.1
>>
