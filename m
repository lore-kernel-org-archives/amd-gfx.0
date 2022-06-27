Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4CFC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 16:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55EF010E5B4;
	Mon, 27 Jun 2022 16:01:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3CFC10E5B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 16:01:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oP7nMCRyIIWtmrsiUPc12zzHyaWEmeee5HQE6EFZr2ntdV3bPSrVmXkT4gtXXLrTlBgIVniwKy23S0tc17XmZGC9lTN85jJ5Ol1Vl0KbvZjqoe/BgpDYXVW6yggfqzUykUy2MF0KTU65qdfxMmAcuy6JF+VzoO5cLUAiPJ3vWLK2jSwx6Birw5bduplyuKhna/K4leCjQVrOGYMyBwwHDkg/utbgg7i+Uj7JGZMHPIrELxtfZfgJcliEE4tAZGtyKqWWpLAh27snD7kjQbOCXf4PUwKkgrYJmc7+RYfrWy6IFE/HsvfnuXTCYrHm5pltwgYMaBNewqKLhyKB2Jqjkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3EZpTZvqhYjgzNGl0t9Ol3ezcinvRYCi+IcVv0Y560=;
 b=KlUazLPGtYqK839l8t1ADWfXtPCc024Z1J72B/Ftuexw7VfZswFEZXqnDHUCNGW8VEJY49Vn6GrFl1FcWbSx5+KJBbfYBcLInj45dNYkLvdoh6A+wC+OfBVPVBUjcRDLWdFLupcqcILwztR9Ax7Ytbv2vkA4T3Az19YwECfNLPHr4kvAQo94VZGY0vEWhOTC1aRgbIz6mTlA4DDn2uE2m89nART4RyuAh3caOBHXq9RadrQ56xUt2YgXTLww/c6h5TjKjwHOdinsF2y3nmn9SkUYZ82QStzmLyXbv3ZMTCH22RODfarwsawYrAm+iLzrd7pZe+9ICBBKgD/FbDwoYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3EZpTZvqhYjgzNGl0t9Ol3ezcinvRYCi+IcVv0Y560=;
 b=nTTM9xv4rJEQ4jPPSc2DtCT96WngCy63n6gmFCelMfvwZVV5H4jJqpomvGafWh3gaWq4gx002FL+ObC/0owNBGSNI/zXDYKAwri7h8HiZXNL6MUJWoG1LoWzyc9Sb+u7PRUuT5iEF7jvrIJBKtoc8hQvT0m0vO1Qn3Prr9rdIk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by DM5PR12MB1403.namprd12.prod.outlook.com (2603:10b6:3:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 16:01:45 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::39fa:4943:168f:7629]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::39fa:4943:168f:7629%5]) with mapi id 15.20.5373.015; Mon, 27 Jun 2022
 16:01:45 +0000
Message-ID: <29951690-b675-ec23-9aa0-e3344f41d3f4@amd.com>
Date: Mon, 27 Jun 2022 12:01:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] drm/amdkfd: add new flags for svm
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220624160243.83693-1-jinhuieric.huang@amd.com>
 <CADnq5_NNs+OEaQXR_L-0wKY+a8dmt_8vgimLWKrfRzAFCNGBjw@mail.gmail.com>
 <1b1412cb-70d5-481b-fdf5-be8500e84503@amd.com>
 <CADnq5_OXDRwNHnKoVNC6yEMrrs3-tc5=056sLw9MXdouDSfUew@mail.gmail.com>
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <CADnq5_OXDRwNHnKoVNC6yEMrrs3-tc5=056sLw9MXdouDSfUew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0071.namprd02.prod.outlook.com
 (2603:10b6:207:3d::48) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0035b6b-4536-4353-18e3-08da58565585
X-MS-TrafficTypeDiagnostic: DM5PR12MB1403:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i/9e/XWt7G3QT2iWi5WYYGV244ZA4kaZpQwPrxC3U4GuPU1H4WivrTtA1/f/zfwXovUZyqBbFCB1eYC8L63p2hxgq7aSRUF7N5+VvLXiXcGOMysEtfnuaypE3pqbAHs8/XgCg6oaQp3lOH+1O6814k3bKptPfNSjJNEn10WHjdnHhc6Dq91zhNNeXpwVviyzXIBWALJjH5KQax4EZSjGbjpAThR4hD79Jawb+qi6Dj0k6M6N4EKLka8S7k+uax1GqY7U97JwHh182s/zugZATJK+vzdrm6a09oFeLA/vz32lqJHGm5rCuQj5BQF0ctDySPoyapjyHONxs5BZs3w4ksmsrSglH+GkEdirmLlnULmVU6qdYpVD6RVWv+3F5TjwgtSYFnvpXPDC3vEoRwCTIwhZrC9lfSFA5LJAwCLEsn48/vGKNIVktUoy6jwhkjdlwNzsKJJWhW9n2Ic3SiAtHnXSj7/33F1pvn95l2JSxyfbJmN6cVbbUnwNoLDuNjDAsKx3HRlhNA7lmAAY30sI76qbT3gA9qI3u78aafMoCUguAWJ5iFoNxn2X8Mjf2YgZahZHu5yKWsskZgfnX3Mw5UrUAWVAUC4yuO3XPGX6IB/sXPiC0qYFhoAiCTmUk/yeWaI+ey/p/W/HsEZep0dCjw9lqfdDqlGyS+33uouxlp9nw9DTolY/qYfenXHQ8foNTCB1gG6QsNYR6aG/bux3T/sS3U+hSdL2ZIXfUKOT9f1UN9qrlztGp01jxEeSwHu7P269BHTusaDfrgh3eez0/Htytr+fbRXBZX9Hp05GwekpkiG5wxh0BFHK8QoK3tWA0fAz/ilwC2U1D4ld0GiCB3NP+mz5za5fDUvmoIlXXKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(36756003)(31686004)(38100700002)(4326008)(5660300002)(8936002)(66556008)(6486002)(66946007)(2906002)(966005)(66476007)(316002)(8676002)(54906003)(478600001)(45080400002)(86362001)(186003)(41300700001)(6916009)(31696002)(53546011)(2616005)(6506007)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUcyMXc5UG96Y2dLOVZSVG8rSkdTTWdFeGNvdExuOCtsU291c3dvZ3hZckpV?=
 =?utf-8?B?VUVBSE5LTy93NEdYK2N5YVpQNUNmeC83a3hmeG5RU3c3R1NaWWVkYkg4Vnk2?=
 =?utf-8?B?Z3VoQjI5MDdweU1vMFovU0ZuZ1NkNldBMFEvN2ZjYklaekdCcThaKzFjSS9O?=
 =?utf-8?B?RkE4dWl2V0xwYUpCUFdEZkJIejNoeXlKM1JjVHB6Mm9PY2J4eXZpWVR5MjlV?=
 =?utf-8?B?ZjdSeDA2Vzd5TDNYbzhZbzJ2S0xIaXFHMXdCUUtWaGp2SmtucWQvMGhCQWJ3?=
 =?utf-8?B?alRjNE1CSWZ4SXk3NGNYNTV1L2o4eVJRdmxZK2ZobmdVcDRYSktJbE1WZm9K?=
 =?utf-8?B?L2xjeTlkT282dHpKZ1RNaS9UcG9TdWdBd2g2eC9uYTRlME9yck1iV0FScldT?=
 =?utf-8?B?RlpWUVFlSFR3NEh4WEdJeUZDckhXeTB4K2hlSFRYdjhNUzJsRkR5MDhNOWtG?=
 =?utf-8?B?eHdyeVREY1h2eGJhaVpCMlZXekpxK3o2UHhuTUowUlFzaEhvTFM5U3FnS2tT?=
 =?utf-8?B?MXJzb0NQaXFVTS8rK0YyVlpXVkxZNmZHN095TllENkdOUDkwV3E3T2NTWFgw?=
 =?utf-8?B?a0V5VnJ4cVJEMldzbld6MTVKUlhSRitSNnp1RlU1TzdUd0d3UkZRTkVuNXhJ?=
 =?utf-8?B?OTdwOGVSa3FkcW5NNEZKZThXZ25BbmdXa2VNNXJQNktqb3dobzhQY1pBR2Zi?=
 =?utf-8?B?c3RrcURHRXJndUFHdFQxUWdnR05VdkpxZmgxdEJhWSsrdG1YZklMSjN4RUJl?=
 =?utf-8?B?Um5xY2N6amxKSFdQU3RmUGFBRnRBK0tYb1NqUFJ5WmZjb3dURmoraUlBSDQ3?=
 =?utf-8?B?MW03ZTVGZzVidFlKMmdZaEEwYzZ5THhMdCtYUldqTExIc0x0aHBaRHpCVVE2?=
 =?utf-8?B?Q2VoODZ3bUU1bUN5RlFOTkRuUS9PYThQQzJyTHVwb0ZvSFZuck5hUFhPcndT?=
 =?utf-8?B?Z1FHNFlQYksvVStQd2ZaanV4YklPZzZPcEF3Sng5Wml2dmJqSkNhU2Z2Q2hn?=
 =?utf-8?B?emtsaEZ4SjdDVm1Hc2MybzVFOHNlVGd4WW8vRzZmeW00K0xpUFlheTArZ01R?=
 =?utf-8?B?WWdtUko4eWo1TlZsU1I4VGV3KzFMalN1SHZiVTBaT0hzNFF0dmZvdWNwMUZL?=
 =?utf-8?B?cXNsSjZMUWltTitYMVhNTE9xQVBmQW1kdnZhUnFPNkliTFdZazJwRjlyOXIx?=
 =?utf-8?B?K0JvZktFMEJTYUcwRDYzV3ZoZnZpWHpOUmhVSmRmUm9NdFBjWitGQlR3WXJa?=
 =?utf-8?B?bjd4d0N4Znl1eUNjeWRiMThWSnkvTkxtdTJrNEpSKzB1NnBFcFYvNlJac0hm?=
 =?utf-8?B?UDJvQjJuc2xNMkZWb2tqa2xJeU9raFdiQUI3eXB0QnpPVmFXOElTS0V4QkdB?=
 =?utf-8?B?b3QydG1WZ3lzeksxcDFwM09qalFvNDM1alpSRTU2RkJKcWhvWkR0dVhjZi9L?=
 =?utf-8?B?R1ZHUldIQU5BcFhIK3dFWGVxbmdFa1hpamsxZ2pmQk12T2N4ZEhaUW1Sakx0?=
 =?utf-8?B?WEtRVXRtN09XemlOVk8vQ1VIRmxCR09CMGw0YXpHMFRBTjBTeHdwcngzVlpC?=
 =?utf-8?B?aWpSUTdZVmEzWHlpQWNFTGRFTlFYaFJ4SGxCQ25MQ2haQkc1bXM3ckM2MVlq?=
 =?utf-8?B?aUtaeTdzRjFjSTN2QU1WaXBMQlRrYUZUT1BkVGp2czEybkd5eFdUc1BnV0hM?=
 =?utf-8?B?QkdNVkFFRXZvdDRHZ1dqOXhlZFo0Uy9qYmRFNUJSMmtJMGZ1SVBoRVFmUTgr?=
 =?utf-8?B?Q214Z1EyWVBPd2w1bkp6bzZscnh1T0IweWdFQ29GV1lTMWJlcHpaTG5PTzhZ?=
 =?utf-8?B?TnBWNmtueEpSYTQ0Z3BiYUpUZFA3Y1pTS3lXaFlhdjN1Y21ITC9iOW0zeUZp?=
 =?utf-8?B?MGNBNEsyMlJOSnJhTGcvUTFvZ2FNWnUzV1p1di80NUVBUnhoREhBNy8zS0tH?=
 =?utf-8?B?Szc0VldKL0p3Z2NSVjlJNDdwRU1GYXNxcGlvN09FSW5qd0hMZ2RBbDZEc3o3?=
 =?utf-8?B?V3RHSGV1eXI0WEtHSGhGcVN1WmxvdXJ4UFpkQ2Q5R2dySlVjSlp6dHdBaXpu?=
 =?utf-8?B?RTZCTi80REx0VGNtOWpadXFpOEYrYi9DODBCME1hMzdZT3NtUmEzL2c2Njhv?=
 =?utf-8?B?OFlEMVRKcGVQUENjdTlWOFFrVEhvNDZnY0hZc0o1M240clVjaEdZekhQaWNC?=
 =?utf-8?Q?gNLMMnjsJMgWHoor+eWuYARbRvhclc5uqn0ETXUQDSBg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0035b6b-4536-4353-18e3-08da58565585
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 16:01:45.2970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90r2LkUlLWErJzYh4MphbkJTyuL5bvWmRBwUKKuIH/r/OFWV7GvTV2PJkr+gLHTR1oqBwLg6Gd0FxaIvG3Comg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1403
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No. There is only internal link for now, because it is under review. 
Once it is submitted, external link should be in gerritgit for libhsakmt.

Regards,
Eric

On 2022-06-27 11:58, Alex Deucher wrote:
> On Mon, Jun 27, 2022 at 11:36 AM Eric Huang <jinhuieric.huang@amd.com> wrote:
>> https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fgerrit-git.amd.com%2Fc%2Fcompute%2Fec%2Flibhsakmt%2F%2B%2F697296&amp;data=05%7C01%7Cjinhuieric.huang%40amd.com%7C61498029cd6743a4519108da5855f02e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637919423397667222%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=wPlHRSmOyzO%2B2vbwN9IK4qR5dhk%2BaOw2rt3JEdjizRU%3D&amp;reserved=0
> Got an external link?
>
> Alex
>
>> Regards,
>> Eric
>>
>> On 2022-06-27 11:33, Alex Deucher wrote:
>>> On Fri, Jun 24, 2022 at 12:03 PM Eric Huang <jinhuieric.huang@amd.com> wrote:
>>>> It is to add new options for always keeping gpu mapping
>>>> and custom of coarse grain allocation intead of fine
>>>> grain as default.
>>>>
>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>> Can you provide a link to the proposed userspace for this?
>>>
>>> Alex
>>>
>>>> ---
>>>>    include/uapi/linux/kfd_ioctl.h | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
>>>> index fd49dde4d5f4..9dbf215675a0 100644
>>>> --- a/include/uapi/linux/kfd_ioctl.h
>>>> +++ b/include/uapi/linux/kfd_ioctl.h
>>>> @@ -1076,6 +1076,10 @@ struct kfd_ioctl_cross_memory_copy_args {
>>>>    #define KFD_IOCTL_SVM_FLAG_GPU_EXEC    0x00000010
>>>>    /* GPUs mostly read, may allow similar optimizations as RO, but writes fault */
>>>>    #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
>>>> +/* Keep GPU memory mapping always valid as if XNACK is disable */
>>>> +#define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
>>>> +/* Allow set custom flags instead of defaults */
>>>> +#define KFD_IOCTL_SVM_FLAG_CUSTOM      0x80000000
>>>>
>>>>    /**
>>>>     * kfd_ioctl_svm_op - SVM ioctl operations
>>>> --
>>>> 2.25.1
>>>>

