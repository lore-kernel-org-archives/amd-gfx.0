Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22918C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 14:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9E1A10E10F;
	Mon, 11 Apr 2022 14:04:34 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC9E810E10F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 14:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVQL91NvFE7YqRwmzJ5kJx+8AUYttzBU6RvfhKMiS4xDdXQmztNByP/cGW2Nd5A/J5/y5GtmRNMJzhMffvWRdb1XJxKlz2qpBU+kRqhomHbpfUJAOsvgEnuo/bQMOLXGBkIx2q1H9abMq9+SW2UOCjwdyzBzit5G1LBAUNvgTQ+s9lhAQplEC3DYcUoCzQyXcDwqVyFUDiuHOrz5IXPTpyR/Z1oOtC5+1cpqobO0eyL652wS3wBKXmQT4qtaQ3L5v9YdS642W2IQW6NyBsiEEQQa38YTV2zCcBSh6mNcECTOcoZnoEZ0YPLU2O8fP0+NIH9/fdG5Hg7DG65nugIo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oK+aySW3yqzOhn6/cVFvTJ13KbrJWyQR4eFSqwkrYW8=;
 b=cfFFuJNQlkuFSoQz15gtzIhdPt6lhlcXdAdJRSm4zY6GG55xMg4pbtg0QMA5JHal31cQuhRy9TLYWhCxr5e43Vbil90ljL3fiZRC2PPVpC/ogDtE/Sq8Vb90AbXLT5kIeho35QN5fiUkc+Wa0JEAE1Hps/eeIk+ZgJ+tiNTgmyShRni6T+d7VjCxR5yPOr9srlz7uW7QI+MZ2tzbwMV0oVPbKohc9g/dQLD205ZLwiR9l7GQE0tc2kanw9ZwL271DbJSHWp95R8TxmhCVLI0boAS7W/co6oiScrTF3267218zzngJFrzr+ckThuIjnPoe3IsgyXRaG1qcAsSqQ1/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK+aySW3yqzOhn6/cVFvTJ13KbrJWyQR4eFSqwkrYW8=;
 b=Pe4uqXBVfMRq+mhS5Bqjx7UpBSn4GmUJCAHS7tMOWnwT+EURhW1j4Id7/rEBNp8h8jCWijg2rOD8Auvt//H3GRemgWWk0vPKXb22d7H7DEQC74IfbPtaHFu+nWNFMFir/NBc3h+ilx5KPjkrrXLMHsgmdsjKKANCT2PjEVRcN8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH0PR12MB5332.namprd12.prod.outlook.com (2603:10b6:610:d7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 14:04:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%7]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 14:04:30 +0000
Message-ID: <c41c8783-af98-ec73-124c-b47e89359ba4@amd.com>
Date: Mon, 11 Apr 2022 10:04:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdkfd: Asynchronously free events
Content-Language: en-US
To: philip yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220408023907.320138-1-Felix.Kuehling@amd.com>
 <ce419f99-0295-8248-925a-fd4d2d3f2c2d@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <ce419f99-0295-8248-925a-fd4d2d3f2c2d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b75389e6-0e5e-4526-935a-08da1bc43247
X-MS-TrafficTypeDiagnostic: CH0PR12MB5332:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB533247A813C57705791FBC1F92EA9@CH0PR12MB5332.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQd2BwdKNeGiUPuys0ZGV/SHepMMplUAOmZKSB7qvpF0LKk7/c2u8LPtohBztzQsCxW2NphQiDX84ghEXnDTWMA/yjzFDL98FDZTpNDfdDNyxg1HMC94EXAJOpHGZYNdiz20ZkBsxsLpIdREX7DYG2t9N0daerZ/GpSlNgkzrrDqTKgsVgHaAiBmXO9ICu9foaV20BhksfBlj/ZriWfuLNmdrSobHUE4w1XjfyCreI7VuTRcZAJNs2PVnZvs3YAPphIPGc/cYNNz6jPAdrgKxttYPfrBudH30Ycn2jyhs5k47CuubKSMtTJCFAz2J2NTkXGZum85XarRHGMS1vDYih4rRedRIfWhUcstOikudja5KS5zUWvOFwpgeEweAJZXXFChjPW4/3hjJB0BL8wibZtPmTo2Hy3G7X6h4Ip5X5B6TJBiNz7YwlDjgAvIo+Kx3mYLGcn0MszLxlmZtNnu9E2ZxgQ5oc6s0sVhPZ6doFtLeTr+yRFku4i5IYiNDQu0PFboo620+IWMVHhFvUM11Go7Euemxh28PpvSgKoC7qsvLw99Hvgk5sBXStN+8D4Iv6mOgxpoXXqXpzqC39PV+5fwXmVjULaPcZ4ppURNa/fBCeXrtbTcNhBUdZlS5GyusIT61KPyEyi/PANSZCXXz1ZKZqiq878wdueVNUlFgWHF3W5H6ycR9x/7QziJu3ie6wnL4/0RyBtugoY3cjAJKpgY1jZ+P5fq/iAxS7OB+RI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(38100700002)(26005)(44832011)(2616005)(31686004)(6486002)(508600001)(66476007)(36756003)(316002)(66556008)(66946007)(31696002)(5660300002)(2906002)(8676002)(8936002)(83380400001)(6512007)(6506007)(53546011)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlNEQUtIMVRwZDRYeEdCQ1FtYWdhRzgxdExKUEEwNjNVc1gxNVp1OEszMVdI?=
 =?utf-8?B?MlhDV2g3Y2gwMjQ5V3cyUE5HNHRDK0p6QVV1L3ZIdDU5WkxXeURHYlVFdWF3?=
 =?utf-8?B?S1MwOVV4S05FMStpVXRKYllTbkZZaFUrOUZKVlhuVHM2cHBsQ1ZQRE9UeFpN?=
 =?utf-8?B?UFZNd1VLbzZ1TFVXY3hSWlNzRCtYYStlYkl0Z3c1VjBqSjhNcmpVcnNjbllD?=
 =?utf-8?B?R1ZYbTZsZVY3czFlTlprakVNVm9VbEUycU9CVkdsdVBHbCtxOWpWd29LOS9t?=
 =?utf-8?B?MDB5cHpaOE5lZFFZQ2lyNDQ3VnhmaW5lRHpDT0N4bWxlNFVvNUc0QW5Qdlpz?=
 =?utf-8?B?MkZ2eEwyck5QTGtTc29UTmJaemZlaXR5UkJTYnIvVlhrenBlSE5Mdms3WWQz?=
 =?utf-8?B?TmgzcHA4Vk9Da1llaWpBUlNNajNBcFJ1eUw1RkNMWnM5WVZBdVhpbGU1UStD?=
 =?utf-8?B?ZmFrOGtmVDIvcjNwa2ZXemFFR3JwNEQyNnFxalFTSUluSnZ3SUEyQlVHc1hV?=
 =?utf-8?B?S2pUTk8xSTZqTjFuSmtBblc2V3pnd0MzclJrNStGZmF2OVVtWTVuQmFqMUNV?=
 =?utf-8?B?aVpiUUNHVjg2Ni9sbDRhZGFoRERXZkozVU1ucm9sYkZrZ3BZZk1veCtwZzIz?=
 =?utf-8?B?OGwwT0E4SFc2Rjl0YXRkMTZBZlY0QTRtallKYWk3Mjl5RE1ZQldsRWpqcTMy?=
 =?utf-8?B?cG9UR3RocG9DTkpGSXJEYllubGlCNlFZdVdkM1dVaEFtWWMyZWRjK0ptY2RF?=
 =?utf-8?B?VFJTTVVCM0xYdFlTTlhwUEhpc1NKUlFUK2F5V3Y3c2I0Z0xQWkNIQytOeXBX?=
 =?utf-8?B?ZTZZMDIvVVEyc3Y0RFA0L1pseWt2VjZJV05pR0lneXNkRHdPcDRwNVMrL25T?=
 =?utf-8?B?aG1qdDBuVGxRR2N2SUFiZ3NRSUl5R29XSFUwRTdYVWVkaGo1aWloRUNwSzJN?=
 =?utf-8?B?ekw1ZlpmWHl0Q0JkNHhsaWZMRlIzeGJzRTJnbEpuVzRhY0I4eUpUUFhXek8v?=
 =?utf-8?B?TzV1SkNzL3dMd3VranVxZytKUitWMVA3V2FyWktiQ2FuYjhvTzdMa1VDcmJP?=
 =?utf-8?B?RkFabExNbEM4dnBmbkxYWWp3NHZ0a1dBTEVPWXJuYXpIaExiSTNtUHFveEY4?=
 =?utf-8?B?ZlBPQXJTWE5LT2ltb2k3eTJ5ekxua2wva29NTGtFeEtRSlVqWExnUFo2UUYx?=
 =?utf-8?B?YkU5NzNmWmxyblBveStCaGJvcUF0aXQvaWUwOVlYays0WXRwYU1GSGJJWGJH?=
 =?utf-8?B?cmlKa1pJMVM0VlBENVMybVRtTWd4L2EvcjVCWDllU0RINWw5SExOYnl1VHhi?=
 =?utf-8?B?RHkrODloTkt0YktHSmNwS28wRGZocCsydk5HRkdkVXpUNXdLaGN6R3oxNHBJ?=
 =?utf-8?B?UER6Z05zMkNLRkYzZ0VPRm43MXhLYkZQZG1yT1JkRml2ZWg5bzJJSktWSS9Y?=
 =?utf-8?B?L21NQ2h5d2piekdrNzNwZi9lWXhpUUtPUjRXRXpDSDJnUlJ6bjRRL0ZVNzR1?=
 =?utf-8?B?cHRRM3FVaTVUOTRKeDdhOGVURjdHdEt2enlyUFN3S1o4NmtHYkIvaEdLbG5D?=
 =?utf-8?B?eUt1dlhqRVhVNVk0TUdKNEg4Qkg4cmRsaEo1RVRCUWczNFkzaW5BZzgwblBt?=
 =?utf-8?B?OTI2WkRPMFV3TllGY3pidGc2SUFKTkYzaHllVVBQSHBqMVlVa2Q3bWVqNmZD?=
 =?utf-8?B?WFJwQW03QS9oVkthdzFFbUVDZ2lWL0I2Vy9YNGdmVVBYR2VpNEhrL29RNkdV?=
 =?utf-8?B?SHNhK25mNU1EUjRuMStWVFR2M0k1dUpGSjZxdnpIWXczbVkwbWh2V1I4aW5o?=
 =?utf-8?B?ZlpDd3NOS2Vua3lyV0c5NGRGY0xIbEpJNmFhY3dTVFRBV0FzTFc5ME1TK1kx?=
 =?utf-8?B?cVpGUGFkQnJHN2N6ckVwZ3BTSlB4M0pYT2R6T09ML3I2Qno0ZVRGcFg3VzE0?=
 =?utf-8?B?YjBqYmtnajZFV1V6TnNjSkMrbmhXeWN2eTdKV2I1Q0FSa0d0Y0UyUUowNnAy?=
 =?utf-8?B?dXlFWmdjLzNwN1BnZUxJSVphNG1VVjVleEdVSTlFK0I2WUNyeW5KZ05qaGx5?=
 =?utf-8?B?eEo5aExjenBYcUc5K2V5QVZvU0MwTHQvR04yOGFyWUtWRjdMRUhBWjFUdE1J?=
 =?utf-8?B?ZStYYW4xN29CbHNrUWYwWit3c3VKa2ljOWxYNUc0M015TFBPMElPd0N0ekFX?=
 =?utf-8?B?SHUwbnJhUmtUYjlWUllzRkxhSE83L1NIYmRHbHpzcW9ZblF6ZFhCaE41cUQz?=
 =?utf-8?B?VUlyWDU4dEoxZi8vMGdhdjZ6NVcxZFlVdWJBaWE2eVZyOWFkUGFXMmV4VmYv?=
 =?utf-8?B?SmNhRTBueFUwT2FFcnJsdnJ5aURJVzg1T3ltN3VUdzN4cGRGdGY2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75389e6-0e5e-4526-935a-08da1bc43247
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 14:04:29.9625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lp0Kc/OEQn4pOaV57ztAdTsHnxKxCERHsbgCnuwjjdgc7Ht69oE+ov8KboyK6/29AC46DSduYF4f+rwWkIywgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5332
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

Am 2022-04-11 um 08:52 schrieb philip yang:
>
>
> On 2022-04-07 22:39, Felix Kuehling wrote:
>> The synchronize_rcu call in destroy_events can take several ms, which
>> noticeably slows down applications destroying many events. Use kfree_rcu
>> to free the event structure asynchronously and eliminate the
>> synchronize_rcu call in the user thread.
>
> Will need similar fix in kfd_smi_ev_release, as I noticed sometime it 
> is slower to exit the app receiving SMI event.
>
> Reviewed-by: Philip Yang <Philip.Yang@amd.com>
>
Thanks. In the case of kfd_smi_ev_release you'd need to use call_rcu 
because it's more than a simple kfree when you're freeing the 
client->fifo. That would have some implications for module unloading, 
too. Maybe you can simplify it by using DECLARE_KFIFO in struct 
kfd_smi_client, since we create the fifo with a fixed size anway. That 
way the cleanup is just a kfree_rcu(client).

Regards,
   Felix


>> Signed-off-by: Felix Kuehling<Felix.Kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 3 +--
>>   drivers/gpu/drm/amd/amdkfd/kfd_events.h | 2 ++
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> index 0fef24b0b915..75847c5d5957 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> @@ -262,8 +262,7 @@ static void destroy_event(struct kfd_process *p, struct kfd_event *ev)
>>   		p->signal_event_count--;
>>   
>>   	idr_remove(&p->event_idr, ev->event_id);
>> -	synchronize_rcu();
>> -	kfree(ev);
>> +	kfree_rcu(ev, rcu);
>>   }
>>   
>>   static void destroy_events(struct kfd_process *p)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
>> index 55d376f56021..1c62c8dd6460 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
>> @@ -70,6 +70,8 @@ struct kfd_event {
>>   		struct kfd_hsa_memory_exception_data memory_exception_data;
>>   		struct kfd_hsa_hw_exception_data hw_exception_data;
>>   	};
>> +
>> +	struct rcu_head rcu; /* for asynchronous kfree_rcu */
>>   };
>>   
>>   #define KFD_EVENT_TIMEOUT_IMMEDIATE 0
