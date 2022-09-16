Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FEEECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 18:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAEF110ED8C;
	Fri, 16 Sep 2022 18:24:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0025310ED83
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 18:24:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJ8kULL34wdRNUt4juEdOfosRXx1iNsJ+M04qZu4X6rkvtikimIzo0/SMKNCaPSgDZlpc4yo4v/uZgAOgi0YcNQt/4pDTxTvGFVE7aE26dSP47t1pXhwt6/WfqpE2eNkyGlC+UMPN+buEJGjgJC8wRhMkIoLBmEBfGfggco+sVRL5ZD0oabaKUErMiYc8SoHYaNSBA/XLbUafx1S+f/d8mSnf2TOotTDYybmkcT72Dq6ib7/0UO//8i62zG5ex0bV2/mXOSFVCHj3ALY634ERf3wORavV5xzdtADTHWxyQX6dA68flQYAEIMFEBgUm2VfUFNOlTu5MD24ZcbM7sZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5EeffBnaHMszLpUtGD+w/YoPLiW7b7tVmbbOgSdhZY=;
 b=Tn+0U2JyOaurfd6SUqKF7rV6nlZwJbVOA2VGgv/hbD7EM0+WCWntvgBnONNZK1Uobw2kozXZm5DFXqQ5YP1tjIqOYNzj+rpslasoh0NIRMubBMFHgjg6zrdzjKUXFrsEiZfCknnsxsH2SGTWCqPJJViw98xMWjATK2DqYVdbMVFaeD6/jrT1dJz61D5hjpMqrU1mAELZ+san4UyB0RBgyOhTaXZwZhIfo2K4KDKVfcRIMvJCsMWsgfx2wERg6wQHAjHE+afgfKt42539ki8ct1WB/YlbMfEHOSCd+xKSN+vpW8RFR1jj/zIi5cgojfnPNGFrTQ9ScXgOcOd9avbi0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5EeffBnaHMszLpUtGD+w/YoPLiW7b7tVmbbOgSdhZY=;
 b=YXK+yRsPErye4l/9FSJTaZunNBVM8WlMmzrIsMpgL/Qxf1ji2U5mYv/KeHYH3Wh7MYLpKEaF3UD+RX4yaUNK886VrJM3GkZr2Q2NOyPAmV5KYzbtN2Ch7mLtm1fCNt9qr1Zs2FhneltPEQmB5qhGv8DMBDIvQ6Sk+MRizPwDhQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 18:24:21 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 18:24:20 +0000
Message-ID: <a74b9d8f-ebee-d654-5526-f3c1e24edc02@amd.com>
Date: Fri, 16 Sep 2022 20:24:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/8] drm/amdgpu: fix user fence CS check
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20220916090845.3336-1-christian.koenig@amd.com>
 <20220916090845.3336-4-christian.koenig@amd.com>
 <CADnq5_N=AGMh+pBp+YRw+bNm459ub9Nv5t5SYd_Pk3wPbMDdHw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_N=AGMh+pBp+YRw+bNm459ub9Nv5t5SYd_Pk3wPbMDdHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BN9PR12MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: cb51feb7-4199-4c64-8416-08da9810ac60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRMtwE6fj1TXBsaNVxnRAtF7n5fqUiSzbrZ/8UIBpdJ52iiefqaP6d0u3D4OFbnyFbkyFMu4+45YdqyEKIVGrWMK+Wg4RZ7H9USYsNEPZsjBiVrz/WGOX8mqBE8907YPQhFOLkNKH4h4KzZDVPczgKNWlYXhjDKFtkF9g5QW+VBx5Abjaq/8UOsH1oLIy5CZTGDmQziEjX+c48EKIasC5lFflvlpxXRYtuObV5FZXA/crBj7FaFhf4wCO3rmOh6dQ9jaGUK0Yep6bBiv+08OCGJ8zynor0gAPuhgkcSXo07DSwgcdISyZpzmFOUjTJg2b19ETEwoS6du3jZ8BJLYMX/3nRJVwi1W9gqbp81NOPvjQ5dTHf390Vg1PlSEAL96hykQLwmnYndlxIHccS1QpPGl1uvDH2qcHA9GzzUAGfe4yRk1EDbWmAcqXiBos1hKr9ks8fyec0j1QIxSuLgZV0+f/3QgxhAo3DohwX+ovRAubXpn6Nqa5e3LYrg/O0b6dnvUFjqsim+KTFDwQvdH0QKYtmbOC9CiZCjz8aMSi706ih2vg4/b8gk657yx88HVBp6NvZ33jbM1t3kiGEsxY7brhohZ7R06F9Xpsmhr1pdDw0v3zpR2Joo1R3BxIdYQCB51P1YEoDngwA8AorqubjT0DBqvV9zrPCe2caFdVjyl7S5OBX7J6HrdwMx0Di1AHjh4+K/7XsR2MFRWZq7TEaQIowlKA0GEDdkHEyMgEUnpvhpSEusQsnaMmRqqzpTTv1fqWu649fNtfcKRIMMs9lujpm8Egxnzgw03W3fTZYo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(36756003)(8676002)(66574015)(66476007)(66946007)(110136005)(316002)(38100700002)(6666004)(66556008)(83380400001)(2616005)(6512007)(53546011)(6506007)(186003)(6486002)(478600001)(31696002)(86362001)(5660300002)(31686004)(41300700001)(2906002)(8936002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGlkWmZZdm12bUJmc0VGVFBFRzVjKzNaOGNnT2Q1V1hiaVMyVXBKemJoSzEy?=
 =?utf-8?B?OWVTcUtCRXloeUVtNmRrenFGU3dPRGMwNEIwQ1Y5bTRMdXdqOVJJazVNTUI3?=
 =?utf-8?B?bWNoSzJESjZyWktoMUhmWHliamp1dWlaNDNLMnNVOUhtd0tTUmcweGJIUk1W?=
 =?utf-8?B?cWRjSFNVdVFLc2oyRHY2NU04OEUyaHMxbEtTR0J4Z25ZMmQvdFNQUnY2aE1X?=
 =?utf-8?B?VzNzVmNqdGZWU3pIUTJZRXpOa1FEU3RuQTV0MGNFZG54UlBRNXFCaWM1OXk5?=
 =?utf-8?B?UjY1WllOMGFuczN0U0FOdWlkOWNqNEJ5VkRLMW9zcFRaOTZ4VHZTWTNLZWhR?=
 =?utf-8?B?NEJMa01iMFpQS1cyWThSOXJST3VyZTErNURPakgvdlRmSEtxeWwvN0RkOTFl?=
 =?utf-8?B?ZGc2VWZCSGhBVkpvQThLYnppVlZkMXV4NzNmVkRkTkJYc3IrUWZHZ0R2RjlZ?=
 =?utf-8?B?c0U4Q05pTFJOdXdUQ0MwKzc4M2twRktDSGluVFpOT3BSN0VEcStLWFhFMlQ4?=
 =?utf-8?B?eUJVdTZjZU94ajViNTdpVUJ4TnRmWDJWNzJTOXF0czJDMkZwVkM0dnJZQ0ZN?=
 =?utf-8?B?dUw3b0VZeUxleTRFMjRUME96LzB4TXNMR1RGcXNNaUdMQnpJcUMvR3NoaS9B?=
 =?utf-8?B?MjJKbi9tOHJ5UitwdTVaWVAxc3JvS2ZrVXBZR29wc0loY0JaMEZOcEM5Y201?=
 =?utf-8?B?M25WY3VaSnU3U29tTERrWUR1U1RkREswUUJHeXVmLzFQWWsxUmY5M1hDczFK?=
 =?utf-8?B?dld6eXBmK3lVMmVhTkVJNmFyMi9FVUlGNldHQTI4bHVDN2ltMVpzWWJZMnNy?=
 =?utf-8?B?d3UzRlhHU0dwM0MxVGRwNWxEUVRPeFJReWFoMEV0ZitYbktLaEZ3WVBGNEh4?=
 =?utf-8?B?aGJHQnFsclppL2xGVEdtY3MwcU9IYVZaeGFBcVNVK0VjMXpZT04za2ROaEZO?=
 =?utf-8?B?bEpGdjFqL0t5MmU2Y3dVaXVMMTN4RU9ENFFFdHRUaWJma0N5U2poeG1tdFRw?=
 =?utf-8?B?Y00veWxSMVVXYnJVNWJkUkdTZkFGTkN4c0FyTUhlODk1cVBLcDl2UkRDTUpx?=
 =?utf-8?B?bGd4TllqRk82SGpNdkdRZ0ZrKzdtV0owaGR5Y0NSRHY5ZXJjcU1nWmEzRkxh?=
 =?utf-8?B?ZlkwbDAwUXhoTDhYZzNqSjlQTGF0bUhNOUJKbnY3ang1eGtCVmdtdytpK3ZJ?=
 =?utf-8?B?RmxRMGIzRUo2ajhybnc3RFphS0QyZnBUVHVZTVRaMHRGb0lNUXlSMzR5SEtB?=
 =?utf-8?B?QXBvNUpXc1l5Tkc5YWVyU3hmWWgrZndtenU3M1pScEJlMER3U3JocHBVL2lt?=
 =?utf-8?B?V2ZCMjFsa2hoaHhObHpzdk92MDhkMC94WFNGOExlbUN0YkVXUk9TRE9YYU9D?=
 =?utf-8?B?QWFPS3lzTTVNYzJ3S05IQ0Y1ZlZTb3lYVUVJQUNRSjN4WWlsdnR0TE9sZXkw?=
 =?utf-8?B?bmFWVS9kSmtpdy9obTdqWTI1WVZaSEF3Ry9HVkk5by9HS2F4TW5mU3RmQ09W?=
 =?utf-8?B?WUdBbWw2RnExMUVrTi81djljUTdKamg3TG83QVNsTklWWncremREUUdobHUv?=
 =?utf-8?B?aVhDY20xODVvdkFmZnNHVXh4UjB1aUtoNFhMeWFHUGx5TU9NVmNiaTR1OUNM?=
 =?utf-8?B?L2hUWHVIOVVDRFJsVXZ2aVZLUy9MR1NKbGZCUUk5NTB6VTN0Q0doK1MrNnRn?=
 =?utf-8?B?bUVaQnBDb1Q1Vm5zTHpHcVFvL2lyWm1RM2hQSmpIa1lHOXd5SXVUYmVzbWtv?=
 =?utf-8?B?Slp4ZW9taTRuV1EwOWxqWmY1cXAvRXZQZUtXb1ZkZEpRYmhVZnVLQnlpUHpU?=
 =?utf-8?B?SVNqSUFMTXJJVHlTTm9sbWdHaDdRTGlmZ3ZoTmJlQ3MvZ2J3M1dFQ2hIUzBa?=
 =?utf-8?B?eEtvN2Qwd0V4REkxWi9RTTRlU2pPYi8wSzJCZG9vWXlYWW4wZStmWFdnd0gw?=
 =?utf-8?B?a0VpY0ZSWkFMbkFmcmsycU51TDlBS0F2RU05cVI3MmJ5Y2ZZSVFGYTY0S0JC?=
 =?utf-8?B?Q0dlZVJ4RXhpRDk1OFBpK3hBTU4wS0dYRDJTSlRjTW1lLzd3ay9sdDhrdTB2?=
 =?utf-8?B?c01WbTViYU14UkFnS0phdUlNbmhEYlFBSFZPalNBMUxTV2Rqa1lGSjRyL3J0?=
 =?utf-8?B?Nm96R1hUSnlPc0JtVi9CbW1JZjVGNEtlbXN4bWIrZXFZVEd5SDVJL2FrWjZ4?=
 =?utf-8?Q?kFmNgY0uiBq8NOQD1+ByjAHYE8r7KrSGfs0HYP0saLdk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb51feb7-4199-4c64-8416-08da9810ac60
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 18:24:20.7438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLh3Ng41Pks81HH1JEBP02YorwwyU89RzTgTU6wUNeYZ6Ta37TZCKno4DcdueeFK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5259
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
Cc: alexander.deucher@amd.com, timur.kristof@gmail.com,
 amd-gfx@lists.freedesktop.org, bas@basnieuwenhuizen.nl
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.09.22 um 20:01 schrieb Alex Deucher:
> On Fri, Sep 16, 2022 at 5:09 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> An offset of zero is valid, check if the BO is present or not.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
> Since this is a bug fix, should we make the first patch in the series?

Good point, going to re-arrange this before pushing.

Christian.

>
> Alex
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index 5c37dde97ff2..265ed2118a80 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -313,7 +313,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
>>
>>          ring = to_amdgpu_ring(entity->rq->sched);
>>          /* MM engine doesn't support user fences */
>> -       if (p->job->uf_addr && ring->funcs->no_user_fence)
>> +       if (p->uf_entry.tv.bo && ring->funcs->no_user_fence)
>>                  return -EINVAL;
>>
>>          if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
>> --
>> 2.25.1
>>

