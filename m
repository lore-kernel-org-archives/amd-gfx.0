Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A838C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Oct 2023 17:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E5AA10E0FA;
	Mon, 30 Oct 2023 17:38:24 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9864610E349
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Oct 2023 17:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMZZkc89afg1yoU+2TcYM5Pb3aedv3bRG80L0w71L5qqTwumVH/V4VbiQmJmJAjP161olj2eBsZxYT1LCIkUx+YQs0+bZwPps8rOaB4dXkHl36yVt1fWp66hhciGMtZjhqMd8e/dbmal1zlvLHbmEslRHFaDFKNg1d5clfE5ln2waCzAjEC5ieAnkUgMI7T4gyNR8yhR/3KQ4rUmdcCcWisni38Ilhgf/2QTsH8LnSnJ0W4uyda0E4YUarf1HAxn5UQSWRHQsG7dpfb1c5v4sxykw/NpQTaLNQwCDFLID/4S5jNmCCviZ73kOzZE/ZpoyzVt92+vJQ30Lu4vYR7rew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2QrPrixjQExVZBScdQRtXcCF3jPG9U90wsiWd4x/sQ=;
 b=mJ7rv2Ab2hWm+C8nayUCKT3jvIFpjw2RguoxzxNgLnCv6fzPBHANs6RRXTTaHWLG9fXhS3pZ7bL+K9CFwREJpJ78kCDMH2ZpbiDywWEFi/8rXG8wB8m58wPh/Qf51jdPldOWl3gwQVvhdjIu02zEEH41E5o7clvPiS99wn/0h2DNMTn2VajnsKQ1QUxNtfEcWdV724atbCWgFOMOifZTkvQDdq5Fq6IRMTHQmdZNi5SUk6oquCJFH+wcvxWvDFr7IWIj4njUB804vIIfoSDw/AIEJsKNOLLROE9RlDx4O/dNBZFgUnVMxYfPuh05PwDERxDMiUktOIrdNxflpBrjNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2QrPrixjQExVZBScdQRtXcCF3jPG9U90wsiWd4x/sQ=;
 b=b0y0kX5WiR2l2/TBIt5rscsw/aJTY8weaZoyh4fn9pka4Gqt5212dGmPu3UpTO0+TAhYI+FmNFwIUAq9z0Sc4oKeP5l0ERZlf6De6JWKOtKUJXOBQurf6n6b33XVZM63d4V9Apviv9hu/FZDi6n8Ga/CY9+wKfQvuR9peDpO3dg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 17:38:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31%4]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 17:38:19 +0000
Message-ID: <f1d1b3e1-fac3-49a2-97f8-7cf9ede8c064@amd.com>
Date: Mon, 30 Oct 2023 13:38:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amdkfd: Run restore_workers on freezable WQs
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231027223911.2640763-1-Felix.Kuehling@amd.com>
 <8e81a28a-5d50-44df-b441-6ceb2133c5e9@amd.com>
 <da7010c1-6b11-41f6-986d-796539073451@amd.com>
 <39374cfe-9c98-46bc-8b3d-196e50a65839@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <39374cfe-9c98-46bc-8b3d-196e50a65839@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 528a4f4f-e784-48dc-ddfd-08dbd96f0174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0awfPTS7w2USu8OVKGP3W8N3JP9VwnxfJABChCHnOA5RIlszeZgYvU4uxiUk4ru7tgYY+HXuixedItQMuMYbCWruhg8epl0AsmfsyH6YMEl8z+qY+t8FTqXzuHvN7c6nwqSaJgKo+5c0M1t9W1S6gwSNI5hOhWYXGv2KecOUerFksA8kh0qg7rUq4zhJuTMM7aHA/85RJSxdmXXuKeOfV5zNJ0iwxj8NeUupIE4jW7oxLvkdsJ6swtWMGu4IcswByMn5J4ibkXLKsnmTmLtGN8BghXlSMqxc0qanpLMW8GHwT+WGqCws8zQrDP3HQZu4LyhanEQY8/aTiXYw1fO/MMGnlus8PRDH+P8Kgibm7xsu5+cZnURXkqrJ/CPd1Qkgqlcrr5549mxuw9XyQvi/nSFOJJ33ZhI+BvbiI/0Qi/9Bpe7wocxp5yqmne2bAMID/bpaZFtajt1+QtL/ANpIn//8G/yY2kVjNh+d0VFCrWhMqSafVx8C5n4cUNAs4hD5TrNCOGU7VUn+6LNbkgY1FIydEViD88QEbjNhKtyveRLeHpF2+lzhK/edd9UhmLsKzYmB2ATnhxxoWDF/VGNGRtJqEKC7MVCh/ojCLnVx4A1r579GYaqH/Qv5/edlv0bUcLFcgujW+xUlTzmND9KMtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66476007)(66556008)(316002)(41300700001)(8676002)(8936002)(4001150100001)(31696002)(86362001)(38100700002)(6486002)(4326008)(110136005)(2906002)(478600001)(66946007)(31686004)(83380400001)(5660300002)(66574015)(36756003)(26005)(2616005)(44832011)(6512007)(6666004)(6506007)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTMxWEhPRHBOS2hQdndob0hzQlM3Z1NWZkZYOUNTN3l5RmVwQy9sS2tERjdU?=
 =?utf-8?B?ZGUxUDB5SG1KdVhsOFBjZlZHZ09qN1ZnQlJ4b1JaUzVQZ0dlK1FpeEh1VDN0?=
 =?utf-8?B?SFR1SVNwcGpQeDFGUDV2bXc1QkI2TTFQeXBQb3F4OXpHWTNMeUlWV2FxV21z?=
 =?utf-8?B?SWh3QncvOG1BcDZRNFZuaE1EeHRldzVDMm0yWC9JZmNhUWVGekpXRSt3UGtF?=
 =?utf-8?B?bWNOS1ZwOXJUdUs3NVlBZmVyTTdrZndMbTl0N3BjbE1qWmZWNnN5TkhDNnp4?=
 =?utf-8?B?NUlyRFJLNkp2R0xtR1hqbTgvTGNJelIxdzdTaHVUY0wvaDBwdFdRVWo5ajVh?=
 =?utf-8?B?NDlwVC9Mek1hTnlvLzdCTkxkOVRPcTI1ZVE1dmhUQU5mTGc4T3pXRVluNkp0?=
 =?utf-8?B?VEt5RisxSDRxMHpEQ2tjZXBxU3ZFcGxqeFFCem81U0NIdlI2U1pKQ1dRTDVa?=
 =?utf-8?B?eXlRNWJLYmxMcEtXWkRSbnU2aE5tbWFyMXZrQjlRS2Nqdmt6QllaYnh1RHRr?=
 =?utf-8?B?V2VFQXhBaU5rZnUvcGNGV0RobmxWL1FROXBVOTJ3UklyczNGLzFtUGZ0Nnll?=
 =?utf-8?B?OExhTHo1Y0xzeVVpaVE5eHpNdEZJWXpxZjV0c2NVY2drWTFLQmZXZ001MWZn?=
 =?utf-8?B?TnB1UWNvQmFkUG5qRGdJcDEzam8xMFo4WUYyeG9YaW5DV1N6QTJScVNDTmhT?=
 =?utf-8?B?dkZ3Sy8ybDNIcWpnbkZvaXRxYlVNMmdiQU1lanpieHVaTXRJL2grK2hhU1RU?=
 =?utf-8?B?SFROTkVYSG5PZkU4cTBOZjBlaWE4ak9EWUN0dlEwa3FmdllFWjZ2RlhMNXBo?=
 =?utf-8?B?TnNpZVNmUlQ5VVF2OURVT3hxOXBCbVhVNFdHMHdoakVENDJOVkw3V1VhY2lW?=
 =?utf-8?B?WlJqQ09IQWxiSTl2dmlVVXV0UHZEV3hqUS9Ua2ZtSXVRdUdsL1FURzRjT0l0?=
 =?utf-8?B?dTF6blhmSkxXcWRIWktVdWlMczhRMlZwVnBXMnNjNUhlMEhxaUt4RnRhZzNC?=
 =?utf-8?B?SXRzRFZIQ3hPRklTVlpYYmxaWnkxMmN3N1VWSEVsTUh5cS9OM255cnJHdUJX?=
 =?utf-8?B?N3J1SUczR2NIS2VpWUtKMTBUajlnek5OcGpSV0dJNEc4MkNGcEFuSklJdWJ6?=
 =?utf-8?B?L0NVSjVmWUl3aVhCRUU5aEM2VkJQTHBpTVRMa3dSWldxaUVQblVWZDkzdWVX?=
 =?utf-8?B?cFdPMHJXcG1GS2dBRnpNS0JtaCtRdGc4aEdibmdUVHNpUkhNTGtyWG5MeDd0?=
 =?utf-8?B?Q1Y3amhNWG9KZElQczZQZjEyWjlVTEYyRFN6SHAycXpsdHZHeTlqcVBzTEln?=
 =?utf-8?B?MXc3aXFMUkFGYnVlVXU3TW5sV3NYdUJGR0E1TTBZaWREcjVwRjR0bDc4UTI1?=
 =?utf-8?B?V3BWVEZmcGJGSkhOeURtank1SVVxTWRnOTRubW8yZGs5MERPRUovNTBkQ0hY?=
 =?utf-8?B?NGVOaHhrSnNmbFZiMkxJeTA1K3I2S1ZyTVVWckxmK0pIa2pLVXZQUXc4aTRy?=
 =?utf-8?B?ejUwNmx6T2ZBR0NBQm5pS2g0Qmx3RWN0UmxNK0RJc1N0Vk1FS0ZmaUFCcnRx?=
 =?utf-8?B?YjJIV1hreFBhdStic0hPOFhTZGJ4NmVLQk0rZE0wN3JwQ1JWNDVPWnUzOXJI?=
 =?utf-8?B?R1ErbmYzT1BpcXpBeWo5eUZ6WFhPM0Izc0RIaEhaT0pzQkdsbE1JUjU1WFQ5?=
 =?utf-8?B?NUcwMVhGSEdLTUk4R1U0dDByd1pJS2dJYnZHRS9xNXRPRGw5eTB4ZnlTbWFL?=
 =?utf-8?B?Q0wxOUp5MlN1YWtLdHE3WEh5a25Ha3VKcW1VQXBJTFVBanJxNS81U1A3NkpL?=
 =?utf-8?B?SElNUUU3QjlBeVJ3cDVMYVQzZFpLL0NqSDlYQTlHM0hVREFmN2htbGhjN2lx?=
 =?utf-8?B?d21LemJCd2JsZXkrL0lvVDJaSDhQd2VqaFdUb20wOTR0Y0RSZXFaSGQxTXRF?=
 =?utf-8?B?VmhjQUFQcnFUeGl5UGpsMlJ0VE5GNGIvN3N0NEd4YVZ1SWxicHpOR1h2SGVr?=
 =?utf-8?B?UXJYQTYwajR1R3JpWk9ZRS8xU3JuREdiZ3JiS2dVb3NVZmR2YXc2ZFZpekNS?=
 =?utf-8?B?d2gxOUQ5eStIbC9UUEtyWWNzYUgyK0dlM24zWmY2VlRPc2lSVXdyN2s1TFNJ?=
 =?utf-8?Q?8ZqeJAK9HeIJgzVBvt4G3l7u1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 528a4f4f-e784-48dc-ddfd-08dbd96f0174
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 17:38:19.3538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IkTVS1njqhLBd/pTnKQybFS18Rkc28WL0vbPBzGfHTVy0XPqAu4L5M3eb6M16JMbCYwLtGxA5fw8+PcO95AvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916
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
Cc: emily.deng@amd.com, xinhui.pan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-30 12:16, Christian König wrote:
>>>> @@ -1904,6 +1906,19 @@ kfd_process_gpuid_from_node(struct 
>>>> kfd_process *p, struct kfd_node *node,
>>>>       return -EINVAL;
>>>>   }
>>>>   +static void signal_eviction_fence(struct kfd_process *p)
>>>> +{
>>>> +    spin_lock(&p->ef_lock);
>>>> +    if (!p->ef)
>>>> +        goto unlock_out;
>>>> +    dma_fence_signal(p->ef);
>>>
>>> This needs to grab the internal lock of the eviction fence, I'm not 
>>> sure that has correct ordering with the newly added ef_lock.
>>
>> Hmm, the only thing we could get a circular lock dependency would be, 
>> if we took the p->ef_lock in a fence callback. I don't think that 
>> ever happens, because even the eviction work runs on a worker thread 
>> (exactly to avoid such lock dependency issues).
>>
>> Anyway, I could try to move the fence_signal out of the critical 
>> section. The lock is only there to ensure that exactly one process 
>> signals and frees the fence.
>>
>
> So basically either the eviction worker or the GPU reset could signal 
> this fence.
>
> In that case I think it would be simpler to grab the reset lock in the 
> eviction worker to protect against a concurrent reset.

Which reset lock? adev->reset_cntl->reset_lock? I only see that lock 
taken in aldebaran_mode2_perform_reset. I don't understand why this is 
in ASIC-specific code. But even so, it's only taken during the actual 
reset (in aldebaran_mode2_perform_reset). I don't think it covers the 
pre-reset code path that signals the eviction fence.

Regards,
   Felix


>
> Regards,
> Christian.
