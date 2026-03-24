Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBF6E9A756
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 09:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21CD010E5AC;
	Tue, 24 Mar 2026 09:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DV8uZfCr";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4039A10E5AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 09:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHiaWtry1MXFSp5GVcLHNeBqOhbCpCM81ILwzCX3jfhFKAOUB5gzDPmDMAiKw6ucLFkPwvqKlBgd/ylDsX7kOGfDInMnd+ulidpm70+evz6E52zgqO+MNfdQaGQjnH6vf3H2ozMdwH56j4HTIOf8xCisdyvqJHFy2C69+1CRyElS0/eyKkfb0OwcI+sz+fqUW9DTTCWY4Cas8hqjzxJCTb7UIUpNKcM4BSWJWcfPDQEpfS+aLng7BZ5kAsyQu7fXxl3hIMfn3mBDvX4awDPnokOpoGOVrIKDBIQmwnZVoK97DbNMiRddLEZ4GujyzE+7NnnIHH8amq7eJJCI1OwL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEIVqHX1taYJ/GjemArRVAReG98z5F0iBVupC+tqYlo=;
 b=U4hJp3RH9AGwkUpQmwsX+SF9FkqbxlfdvigUvzZocydDM6TLHbUYlCehlMDCTLOgarLbhgMoF4QrWMZrMi1ens1OyFzXx9Yq3UG+OsVfynxsb7ANwApPQaGGRWbN6+9AZG3EJjqikQaf80lxDhqgtipZ/ACWOm7aXaAho18TUK8+XQk+GRCL7Vsrvp15qEYygE8I0SzMmVG7VB9E7LaDQIX74BpDglvnTZEbkAhXT4zwn0USZT0xORE1sWlTH+DFgmYIe1v46FPRDFP84Zf/rdf78+6K2r9VXX5BEFg1SMdCdSddbynlLRIRtOnq/ymoEgN1XAo8fhX1oyWYRkf0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEIVqHX1taYJ/GjemArRVAReG98z5F0iBVupC+tqYlo=;
 b=DV8uZfCrVKARDZWuAjsXQfBEDLk8wzqPZBpMXqMxZofcm06H8i0PARtf2mu/DnXRlIMFlW00Ouj3oy3ALOZFUKjQx3ldQYvupebEflbZG83fkdtCsfYVZQh4YuveCKAkzj+y95m7GFza00CAb5i6gNNZyLERey6IpjnBR/HBn9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.9; Tue, 24 Mar
 2026 09:56:38 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 09:56:37 +0000
Message-ID: <042cf542-683d-435a-b54b-0c7161003d1b@amd.com>
Date: Tue, 24 Mar 2026 15:26:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amd/pm: add variant func smu_cmn_send_msg() to
 unify msg sending logic
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Feng, Kenneth" <Kenneth.Feng@amd.com>
References: <20260323231206.722067-1-kevinyang.wang@amd.com>
 <ec7369d6-8f6d-4c2b-bbd8-b43fe11a41e1@amd.com>
 <DM6PR12MB2972AF9E1A2818BFA249ED7B8248A@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2972AF9E1A2818BFA249ED7B8248A@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0023.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::16) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH1PPFDAD84AB72:EE_
X-MS-Office365-Filtering-Correlation-Id: dbab8dd1-10fd-4ffe-13d0-08de898ba3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5j962Jw6gXMy3CZbMxQe7o99xHmFejnGdLCQE0agKThhL3zrwxetUabLjoDYGNHw5xoqSvAR7plODjL3Rk5v2w9goAqhAEv5ikHIjbw5xhWlI5rn6RDeZuPNDm26gLhTDtjwfuLLActsU2HdoO0sipVc+nVm2gYXfI0PPX+0KS5UsJ/hx6+W4/V95KqSJr+ER1Z9gCQLWUtPaWmDhjJg5u2dpBN1P8oo2ZFOYJwmrpmMqIJJBxgIDAWuyFjJHBu2Q3ttMar9Do5fu6cSt1k64OwwKrp3kFv30nCnfdu8qcpANsjp2mME0OcJX+hn5/YsXgqSleFcg2ZjWgdCsHs9Wd3007IxFcePYgJUGDC73lzXOBrhWjHiCY++cXrsS//bpCgkXQq/DEwH3DNIciY6nvmEUqG0rdlixvoELBVa7n44AbbfHaqFfN6XTO4V8Ckq9zwKGYitvdYjZdjklKzFDeIryUFJVymnnPLk4/W/U6zxxEpx4DsvtXtvNK/twX+WiGJKZf656TrA+66ivnuuZ5w4ZEgMlk/yoE0t1nH7cqQZ09rE7fFaWolytMuEG7cag/FXUHyw0F6IEboC4CYNW6bDuBVHk/X9se3flRc2oF5CNAL26LGbY+duTKJpsQ07l36IP1DbGqhp3wozupxYwvOJDHHV6TsBrDEEliKJPLifcKTDWS0V4eVJnCE4cZrZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUFoWmNwUTM0NTlic1E5QXRYM0FNT1ZCeW43bGlwOHFQYnpOWmpiQlR2Yk1K?=
 =?utf-8?B?anFzZWl3ckpob1V3d2xtUVhES0Rtb3BzTHFtQ1BmdnBWelFZa0Q1bDhuaUlm?=
 =?utf-8?B?d3hISktTa1I3SlhrZ3Y2anl1ZXMrVll2U0E0TTJoVWdNUlVoV01pNndjc0t6?=
 =?utf-8?B?Uk10UUYrZFlmWCt3WTVSNGhIWFpFY2xYbkpRTWRZSk8xWllzS09WRUNwUHk5?=
 =?utf-8?B?RUY5TnRCM0VuZEJxSHozYlI3TmlrMmF6VzQ1bzRjZUFyU0hHTm1MUFJ1MERZ?=
 =?utf-8?B?eE5va2ViRm8zdmFCaUgreFVpenc2TkdYcERHaHFKblY1VEJEN21GeU5xOE4z?=
 =?utf-8?B?T0ZkczZQYnB2L1BRZWZiSksyQlhpOXN3OCsrZEd6cVRaa05iYXBFYWc0elpo?=
 =?utf-8?B?R29Hd2hOb01XZ2RtZTkySHZOUW93MGMraVlxMHJPUkd1RHdrL290NXcrQkhi?=
 =?utf-8?B?b3BkYUNIZDE5K0FIT3RjTDVTTllkcnZYZ1VkTGttZTFtemJUa25pUjAvbXU0?=
 =?utf-8?B?dW1TSll1YzZhYzd2bDdjTHhmUmc5RjJ5RkpkV2ZhWjJSNVZJMFNGM1YzaUl1?=
 =?utf-8?B?ZEpxakozR1pnaUkvNFpjejcvcUlRZDNDc1JMM1o4aEpCWlhBN01TbDJnR2FQ?=
 =?utf-8?B?ZUJvb0hYMFg4cEFTcEZGME5WdUYxRnJ2ZnlqZmNmMmhHUjV5VFgxSVE2dVdV?=
 =?utf-8?B?NElJbW5WdzRsdnM2UDRyNnFkd2RySzN1RWRTTEtDMTlGdnNYNDBkczhSSkVE?=
 =?utf-8?B?Y2oxNTRJcDIwVWh4OE9MV0tpdjk4OEtUV3F2ZW9sSTFwSm8vT01TUFYvTUxS?=
 =?utf-8?B?VXBiekVVQmJ1YnY4UnB1MWhJaUlZU1I4eWdYdEtlOXRuYlpFL3oxTVR2NmdU?=
 =?utf-8?B?WURsZ3l1QjZnUDFrN2FXR2R6VlZONlpsQ09ESjVvbTl1eDFWV3UvRXdGZ2dl?=
 =?utf-8?B?bzB6VTRSK1FScXEwLzVmOXZDbHRZVmk3RG1FejUrTW1CdExTUFFCL0RWNDJi?=
 =?utf-8?B?N2d2SjhuNnJHVGJ3ZFZuemNCOHFSaEhlalErWjJWb1kxMFN5bHFKV2ZhcEQ4?=
 =?utf-8?B?Y3FpRUhGN1M5QU1qWENVVFBpYTZYNHlDcVFHY3VRWURJelBsTFBsb1FCb1l2?=
 =?utf-8?B?V2FsYjhTd09wNHp0UVhkZlJ3eXVsYzhwUTNUZUlSNUFySVZNZU9HY0QvUVpF?=
 =?utf-8?B?aDEva2lXd2ZsOWlhRzhaV0g5eWV5WVBnYWxlRjNuZ1hqTUQ5ZzlKTTVUTGlY?=
 =?utf-8?B?VTFhN1V6cEhIYUZTWEtzcEFsOWUzek5IN1NMMmRGRXJXWEdGU3hXZkIyc2lK?=
 =?utf-8?B?RUk0dXpkRGVoYUo0eFR1QTV0UXloUG5nb3hJd0JvdkE4RTZTU3JpTU91Q09a?=
 =?utf-8?B?N2JDNWx4SGVYYTQ0OHdJN0FPcFNaVUpINDNXb0VhV3BGMzA0bmppcGsrRU14?=
 =?utf-8?B?QmhldVVTaXZCaDQwUkdPVjBINFFWODF5dFpyRFFRSWI2UTR1Y2sxWEdkeFNP?=
 =?utf-8?B?aUdYK3k0VEtkQjduV0NyNDdlc3pTMWNlSGRVRGhXb0JabVMwaHNocVRQd3U1?=
 =?utf-8?B?OWQ5eHhBaytkL2VxRGNxUTNBcHVwSFkrVjkxeTMvZkJmU0hWYXEwSG93T0Ur?=
 =?utf-8?B?dlVlNkNpQmMzRERIOG90UlptM2RPYnJPekFQSmlUcUdsdm4vRXFHSlo2VStH?=
 =?utf-8?B?dExTd1BqWG9BeWFiUDBBVHlFYlRrSVhMWWlvalZrOVFFYmxTRVgzNE10eW1u?=
 =?utf-8?B?SExWQXVMU0JwSGhmUGQxdEx1aUVlNnRUL0RJVCtlQmlsNmQvSitXTFllbHoz?=
 =?utf-8?B?eU4zRm41RVc4a2Qxejk3T0tnRC9pL3pWbk9UY215Z1RpeWpRSUluajBLZFI5?=
 =?utf-8?B?TlI2WFQzOGtZK2NvUHRNeEtSeTNRSlMxUjBZeDNmSnlONVpFcytnNWJESmtX?=
 =?utf-8?B?MDlBTGovdTcvbjhwb1Y5VkRDUStOVWdjbVJsV041YWo5NUxPZFo4bVJyelZO?=
 =?utf-8?B?NVlnY0VYTWs2QTlDN3FVZXZ5QThhdVNPZzNPS1IzOU8ycVVnZjB0eHdrcmhR?=
 =?utf-8?B?NVJjQmtKQVpwSE5SR2plNVFDVTQxZllTMy9XVmIyMG91MHRmMXpWNlBaYU9a?=
 =?utf-8?B?NUlCNHl3TVdjc3N3Mk44UG9VblhzUTgyU0lkMUpLcWtRTXRiU1U1UWd1SFN5?=
 =?utf-8?B?eXRzQ2xNd1cyVElSRzFjWHJFUzRteEhKVW1mSTBXQTBLZVRLQko1ZDFuQjhi?=
 =?utf-8?B?cmZGS29icXZQNFZab2V2ZjZ4cWdaMjNEUDNuSjBUM2cvUVJCMjNmMHp5MGdo?=
 =?utf-8?B?ZUdPQkk0dDhVM0NrTHJBM09YaHRwbDVucnI1bGVkOTgwMGg0cDgwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbab8dd1-10fd-4ffe-13d0-08de898ba3cc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:56:37.8245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajOetTvQnVIARbBnw9IXy+0aKKgmThZ+7Ur3b6rGvR2DySBbwK8pFtS5SckR0ql+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFDAD84AB72
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



On 24-Mar-26 3:00 PM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Your comments rely on subjective assumptions ("I don't think") lacking technical justification.
> this increases review cost and slows progress without clear technical basis.
> 
> my approach stays simple: this patch optimizes common message paths and hides unnecessary low-level details.
> And the original low‑level APIs remain available, so, developers can still use them whenever fine‑grained control is required.

These are the ones in case you missed -

1) This uses same function with multiple variants and it is difficult to 
figure out which form to use.

2) It also becomes reading coding the difficult. Refer back the same 
message to figure out which form is being used.

3) The existing implementation is not complicated, there is nothing 
lowlevel in that. It's just a form of API which takes a struct instead 
of 11 parameters for in/out (at it fullest level it can have 12 
parameters in this form). It's much clearer to read the code in that 
usage and it presents a uniform API rather than multiple forms of usage.

Thanks,
Lijo

> 
> Best Regards,
> Kevin
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, March 24, 2026 2:12 PM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: Re: [PATCH 1/4] drm/amd/pm: add variant func smu_cmn_send_msg() to unify msg sending logic
> 
> 
> 
> On 24-Mar-26 4:42 AM, Yang Wang wrote:
>> add variant func smu_cmn_send_msg() to unify smu message sending
>> logic, and enabling support for newer ASIC interfaces such as SMU v15 and upcoming devices.
>> (support multi-param/multi-response, standardize code across all smu
>> code layers)
>>
>> The smu_cmn_send_msg() API will expand to the following prototypes based on the number of input parameters.
>> e.g:
>> 1. r = smu_cmn_send_msg(smu, msg_id);
>> 2. r = smu_cmn_send_msg(smu, msg_id, &read_arg); 3. r =
>> smu_cmn_send_msg(smu, msg_id, param, &read_arg); 4. r =
>> smu_cmn_send_msg(smu, msg_id,
>>                        num_param, [param0, param1, ...],
>>                        num_response, [arg0, arg1, ...]
> 
> As mentioned earlier, I don't think this helps with readability of the code. This commit message has to be referred always regarding usage. For
> ex: if I want to send a message which has only one output argument and no input argument, it takes a while to figure out which form to use.
> 
> Instead, it's better to expose args structure directly to user. I don't think it's so complicated to use like this.
> 
> https://gitlab.freedesktop.org/agd5f/linux/-/blob/drm-next/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c#L627
> 
> Maybe I've a biased view, I feel like it's easier to read this way about what is being done.
> 
> Thanks,
> Lijo
> 
> 
>>
>> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
>> ---
>>    drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 79 ++++++++++++++++++++++++++
>>    drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h | 22 +++++++
>>    2 files changed, 101 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> index 7bd8c435466a..480d91d88957 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> @@ -193,6 +193,85 @@ int smu_cmn_send_smc_msg(struct smu_context *smu,
>>                                               read_arg);
>>    }
>>
>> +static inline int smu_cmn_send_msg_internal(struct smu_context *smu, enum smu_message_type msg,
>> +                                         int num_in_args, u32 *in_args,
>> +                                         int num_out_args, u32 *out_args) {
>> +     struct smu_msg_ctl *ctl = &smu->msg_ctl;
>> +     struct smu_msg_args args = { 0 };
>> +     int ret;
>> +
>> +     if (msg >= SMU_MSG_MAX_COUNT)
>> +             return -EINVAL;
>> +
>> +     if ((num_in_args >= ARRAY_SIZE(args.args) || num_in_args < 0) ||
>> +         (num_out_args >= ARRAY_SIZE(args.out_args) || num_out_args < 0))
>> +             return -EINVAL;
>> +
>> +     if ((num_in_args > 0 && !in_args) || (num_out_args > 0 && !out_args))
>> +             return -EINVAL;
>> +
>> +     if (!ctl->ops || !ctl->ops->send_msg)
>> +             return -EOPNOTSUPP;
>> +
>> +     args.msg = msg;
>> +     args.num_args = num_in_args;
>> +     args.num_out_args = num_out_args;
>> +     args.flags = 0;
>> +     args.timeout = 0;
>> +
>> +     if (num_in_args)
>> +             memcpy(&args.args[0], in_args, num_in_args * sizeof(u32));
>> +
>> +     ret = ctl->ops->send_msg(ctl, &args);
>> +     if (ret)
>> +             return ret;
>> +
>> +     if (num_out_args)
>> +             memcpy(out_args, &args.out_args[0], num_out_args * sizeof(u32));
>> +
>> +     return ret;
>> +}
>> +
>> +/*
>> + * NOTE: To ensure compatibility with the behavioral logic of the
>> +legacy API,
>> + * it is required to explicitly set the parameter "param" to 0 when
>> +invoking
>> + * the msg_0 and msg_1 functions.
>> + * */
>> +
>> +int __smu_cmn_send_msg_0(struct smu_context *smu, enum
>> +smu_message_type msg) {
>> +     return __smu_cmn_send_msg_2(smu, msg, 0, NULL); }
>> +
>> +int __smu_cmn_send_msg_1(struct smu_context *smu, enum smu_message_type msg,
>> +                      u32 *read_arg)
>> +{
>> +     return __smu_cmn_send_msg_2(smu, msg, 0, read_arg); }
>> +
>> +int __smu_cmn_send_msg_2(struct smu_context *smu, enum smu_message_type msg,
>> +                      u32 param, u32 *read_arg)
>> +{
>> +     int ret;
>> +
>> +     if (read_arg)
>> +             ret = smu_cmn_send_msg_internal(smu, msg, 1, &param, 1, read_arg);
>> +     else
>> +             ret = smu_cmn_send_msg_internal(smu, msg, 1, &param, 0, NULL);
>> +
>> +     return ret;
>> +}
>> +
>> +int __smu_cmn_send_msg_4(struct smu_context *smu, enum smu_message_type msg,
>> +                      int num_in_args, u32 *in_args,
>> +                      int num_out_args, u32 *out_args)
>> +{
>> +     return smu_cmn_send_msg_internal(smu, msg,
>> +                                      num_in_args, in_args,
>> +                                      num_out_args, out_args);
>> +}
>> +
>>    int smu_cmn_send_debug_smc_msg(struct smu_context *smu,
>>                         uint32_t msg)
>>    {
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>> index b76e86df5da7..5c14ed9ed9b4 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>> @@ -210,6 +210,28 @@ int smu_cmn_dpm_pcie_gen_idx(int gen);
>>    int smu_cmn_dpm_pcie_width_idx(int width);
>>    int smu_cmn_check_fw_version(struct smu_context *smu);
>>
>> +int __smu_cmn_send_msg_0(struct smu_context *smu, enum
>> +smu_message_type msg); int __smu_cmn_send_msg_1(struct smu_context *smu, enum smu_message_type msg,
>> +                      u32 *read_arg);
>> +int __smu_cmn_send_msg_2(struct smu_context *smu, enum smu_message_type msg,
>> +                      u32 param, u32 *read_arg);
>> +int __smu_cmn_send_msg_4(struct smu_context *smu, enum smu_message_type msg,
>> +                      int num_in_args, u32 *in_args,
>> +                      int num_out_args, u32 *out_args);
>> +
>> +/*
>> +* The smu_cmn_send_msg() API will expand to the following prototypes based on the number of input parameters.
>> +* e.g:
>> +* 1. r = smu_cmn_send_msg(smu, msg_id);
>> +* 2. r = smu_cmn_send_msg(smu, msg_id, &read_arg);
>> +* 3. r = smu_cmn_send_msg(smu, msg_id, param, &read_arg);
>> +* 4. r = smu_cmn_send_msg(smu, msg_id,
>> +*                      num_param, [param0, param1, ...],
>> +*                      num_response, [arg0, arg1, ...]
>> +*/
>> +#define smu_cmn_send_msg(smu, msg, ...) \
>> +     CONCATENATE(__smu_cmn_send_msg_, COUNT_ARGS(__VA_ARGS__))(smu, msg,
>> +##__VA_ARGS__)
>> +
>>    /*SMU gpu metrics */
>>
>>    /* Attribute ID mapping */
> 

