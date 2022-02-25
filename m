Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184DEC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 13:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9488410E793;
	Fri, 25 Feb 2022 13:59:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3611910E793
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 13:59:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilY7+5G/iPuQBZ+e+vFK/rY6ZOUThoqTe+/U68dYGPOJnp4ZPtHpH3pLq5qdetw3jZJpzm8o2uMjEahfhZFfLTpCrky0pbaVFdEKzl1jr4CfBP7d9CwhEhrlimD9aAF9MPSU+BTdes+mKkb/ym2eM1b9zX08tUc9MuJ307TlfS68136Fq7FVt1MB/lTbuevghh4upTU8j/Z3KuwryE0EUwLfJLEi5s/Qrs7iwllzet4lTeJ6qmbIJ/VBFhY6NKhhmjUGgY9p1gmYSUvWh/Cm0iPqRyPfFAU/wmjIIfL5uFc40lyJs93Q2dn9npFui4GnzIkNyCLIaYHKEMjRYjIWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/hbL1yOFdO3Bwpy8U69dEKP8k+RTWkk5gAWCMb0YWo=;
 b=gc8IF2zmFOYiP1HZU5k/sKi2uoZQp+oc9e6EFO7u1mXYqw3XVnzaXovNToNAL82sYP3LLSa7izTGBe/b1tM9aQdO+hQrolwWUEcJ5BPqfqUm3o666RLUNqSL0E5BB/vhWcdNxL8Qb/Ktu98G8+Emc8qAh9t2Aufo8TYXNwgBs69l1Ys3r+OIIM2YZpYFg2lR5dAn/tb0/Tuq/N0qqYUSsyK+Wlg5vcP+iKSfxyx/nZGJxyMz2eGNLI7fWxA1lwN+sTjonSy3tvqYhI1C/lZZk6fl7tgoJQXQH8aYFIgjzXsAZu5BUWAkEmj6zUtQ39GPXtzbS6wLwPHQbuqDhbl0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/hbL1yOFdO3Bwpy8U69dEKP8k+RTWkk5gAWCMb0YWo=;
 b=uJJd4JeLYZ50KuL24DNUq1UQF7DQ1jj2WaE0+AswZTbtjU6M/dv8qjDh1MkdV+eYxYR6rAWdI96oQRwMlTy0TU1gaW4SRtY9IpOL9gscI9LVZR9ghHCywu5LapApwZZr8ZuFL40Thip6gJVU95Sj5w3D7Nb8bfe5Qejra8StCIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN6PR1201MB0244.namprd12.prod.outlook.com (2603:10b6:405:54::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 13:59:44 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.5017.022; Fri, 25 Feb 2022
 13:59:43 +0000
Message-ID: <bcef8f25-d82e-cd42-7574-5739e09ea6f0@amd.com>
Date: Fri, 25 Feb 2022 19:29:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220225042156.676421-1-lijo.lazar@amd.com>
 <DM6PR12MB2619202956D5AF431734D5C8E43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <BYAPR12MB4614577C233FED50C0EFC80C973E9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <DM6PR12MB26192A826B2B5DF65ED8ED5CE43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <2bb4e178-b224-ff6a-e730-47ab780e44ca@amd.com>
 <DM6PR12MB2619810DBC53C6430A03535FE43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <955cd7a1-6a93-9043-d065-dc45d149fd13@amd.com>
 <DM6PR12MB2619EAA72E6FF1ED8708FC0BE43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619EAA72E6FF1ED8708FC0BE43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::29) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 708fdfdc-a51f-4ddd-a860-08d9f86712a7
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0244:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB02441547A36131AC81F70190973E9@BN6PR1201MB0244.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wnl6qvim3TY78tpWwvg/tIBK8O+8lCEbxX9AumcbixmRQ6v8n50+L++4oumvuj/zcoBOB50ExJSqa4HvLqjphQEPBwtJcLp3jg3ZE5ns1mrYACMlhusxm9zyc0CbADMkFVDcp5+yxDyw5tBmB8SrYk1zTwa+QuAeml0DqGwcNsQpPWa6FllN9EWjdHHquL3rcjiIh179VYNxAThP+vbiAJJpNUL3fYpjlmuCtjcYGVMQX69yNPME9MEn6/ShqFhJpHocru7Lcw0AWeVug6FuJtZa4oO0X3N5XsEQ+pzNnMNi4kkshpOcWJIv5Qqzx4O5w9YK9adKKxTiq+w6A/z2D20Tux6DlYgfBmpJyBW36AMIqrFgq/m9hBbmQKhO/coD661iV9MCyMRHNBTXi+dqmcg5dofQC8wyTo2HjA4vpBVHA2uMkGVW5XvxFfzKDY2C8PKqJbJDtwc5QcXWCt0e6iZNQ59a+4s4dp1r7/hr8/xIbBplcxMUgiQV71ODf0XOKftExcWZCvgyGQ8H0tlI015hbMrvQaSOgNItUA9r5akgf1AkZbQ4QsgazdVF3qivuET0AQxt3/aogK0tRNkwoDyxTLi3VOAnqvhN4YkVdtXvIx2EMj9lU7DAB3PimzYklaDzJo9qxX/W5MCMvF9STxE1F1Qq14XqbmR2ZM5bocr4Yt9xmO7zWccFLGnpuQ4H+bNV+DyBPlYjtBVUpnywlxcQr7wUctkt260F7Npr5Xz0leZX3x+9KoEqvMzg1Zgl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(54906003)(86362001)(6666004)(66556008)(83380400001)(316002)(508600001)(31696002)(6486002)(186003)(31686004)(66476007)(26005)(66946007)(2616005)(110136005)(4326008)(8676002)(36756003)(8936002)(38100700002)(5660300002)(53546011)(6506007)(2906002)(15650500001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXpmcWZzLzB5Tkl4eGcvRkpYcnJFeUNaMVlWdHlKQVVGWnhHM1lieGw1Yk5k?=
 =?utf-8?B?WHordGlVaklSR0JMVGxRUGIwaEdJMFRzV3lCRFZIZFlJNm5PSm9MTnpCd1B6?=
 =?utf-8?B?Yk1wQmxtd01YMXR1N1VXaTl1TXJaWmgxT0M3cFZEa3ZHZUt3QnB2ODExUlpn?=
 =?utf-8?B?MXgzK2NSRHdzWG42ZHUzcEdjSWNVUTQrV3BnbDhzTHFBUjBHQ0NRanB0L05i?=
 =?utf-8?B?c0kzTHpQNVNPM2JHZ3N2bXFFdTA3TExIZkFGdldGck9UVm9Td2thVWQ1NmNB?=
 =?utf-8?B?Ulh0YWZ3NVBnSjVRdUN6TWpSRjRGbFhKR1ZVWVFQVGdiRzRhOW9EQnBqQWlx?=
 =?utf-8?B?SVZQUVp5U3YrbVNVMFFHM1YvU0ZvdGhNcUpoYnVkcnFvQ1lMbW9NdWdpUDE0?=
 =?utf-8?B?eDZlY2hzS2NLK201S3o2ci9lZ01ZdGRLdzhBa0REQ0ZzaUV0VXNUVEtRbm5a?=
 =?utf-8?B?Rmo1SnNMM0hOUlZuUVM0ZGd4QmJwakZBL1NwUGRrVTd2ZjFsaUwzMTNSdCtJ?=
 =?utf-8?B?dnd4amVoZUJwcHpacVlKYnFYOHZXaDVOQU1QWmRkdk8rditjcEtmQTljL0sz?=
 =?utf-8?B?STNRL3ZROTF6a2pGeTJwVzRjTEFGTVBRdk5hblBWTXZJODR0YlJ3ZkJ6bkd0?=
 =?utf-8?B?eHEzcUxFVlRKc0ZiajRRSk81d3VlSUNCUFNLc2tBQzdnUkltOFFvenpMMDh5?=
 =?utf-8?B?K2RtUXk3OURSeVlYQVNKd2dxYkdVNnVFRytCNFpDNjlJVFh3N0JROFBQY2lZ?=
 =?utf-8?B?VVBWU2tmbmpIb2pER3J1T2FIeWlncUc0RlpQdzlYbjVRVU5tWFBSTm5pUmtZ?=
 =?utf-8?B?MTZJTjBNZWpSQVc1NldpUDdkR3J5aWdiYURKTG8yRzB5SlBKSFdmalRLTC9h?=
 =?utf-8?B?cTVBREtPVHFlMkpiYU1STitvVVVnSGZOakFEcUZTeWZLNENscGJ4T3duNkE3?=
 =?utf-8?B?Q2pEaHQwcGRpOWxQRmRtOUxoZnNEMW84Z3Y4UjNGQVk2RG5jSnZNckVqbzkw?=
 =?utf-8?B?NU4vWTBZOFUzbGJUK3hXMXR1Zng2YUZ4RFFBRUs1YWJWblFiWk1TOWRMUkMy?=
 =?utf-8?B?UW1ZSlBHanVPb3BLdzg5TnNGbXFsdm1xaEZrY1hOZUxvVGVGbUtWSkRvMzhD?=
 =?utf-8?B?dE5BTWVITldKNjlNZ0V3bmY3emdGWVJRRFowWmZWazFPNUlKdmlaUEN0Q0xT?=
 =?utf-8?B?M0N2aW11OTFOMFNWblkvbkZhUk5nYUl2Ny9PeGUvdUZCNDVUSTVEWWVzV3U3?=
 =?utf-8?B?dVF4UFJ5am5GMmdnOHV3VG9OKzhXeCtHWU9sRFFPdEZRSkFRRG5TTW9ENjBH?=
 =?utf-8?B?L0RjSGVxT3FNODJ5WExrWVJSZTJpbEZ0Ry84cmFGamxSZXF5REZQOHpiY2JD?=
 =?utf-8?B?YUlTNmFjZVV5Z0V0cUYyc2IxS3JCZW43WHg2N05rRG5FN1JxbHJ4K2hqcTFQ?=
 =?utf-8?B?UmtiVHlWQ1hzcjZxNk4vTzFUUWx0U05VZ3F6TUxhQ1JYUTdSUDc0VnVkV1Bs?=
 =?utf-8?B?cHVuUEJyTVVVYmowdFdneVF1QSt0UVk4MHZrMzU2OXNod1FTcUV5MktqREZM?=
 =?utf-8?B?RWo4d0xjczFmNk5nalhtMjh3WmsrTnVXOG5iZGVjWE5oSmp5UkxkUkFpTkJ1?=
 =?utf-8?B?NUFiWDJRdG1uQy83Wm11Y3dYaVh0Q3hkdHVjcHo5cWxCN0JicnVYMFZWUEJz?=
 =?utf-8?B?dEVZYXFtTnpWcHR4bjk1bUl2Y2hYUGtObmkyeXkrK2twb3RCcTM5ZWkxK05h?=
 =?utf-8?B?cWlrV0hkVzJQcVJXN1dnYWhxQVNWeXBZa2hSck5jaFQ5VUFzbXllbEdXQ1d4?=
 =?utf-8?B?M0FoTk02OE9iNjc0VnJyRTc4SmdNbkVCTnpmYXlpN2YzZTEreDdyZE1udm5K?=
 =?utf-8?B?a0hPekJLVmVvaDVzVG1HQys4QkxXUTRwektRc1QxdVVTNTQ0K1BxUnRkZkhj?=
 =?utf-8?B?Q0d4RnN5c3ZCckJGSmgwbXNwZ0J3VDc3M0hkVHREcUxxbEVqdXo0MnR2d002?=
 =?utf-8?B?cmtCbStMdWtYbkhyazRNeEp4NTM3ZXRxQzJjVDR6akFSaHpPYytyS1ZlQ0Q4?=
 =?utf-8?B?cXpVb0RhNENWZ25RMzRZbWxTVElRQlVJRTFDcFMvQzRqSHdGSzhIaUt5Z1ZD?=
 =?utf-8?Q?NbAo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708fdfdc-a51f-4ddd-a860-08d9f86712a7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 13:59:43.3089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HF7/YR7bl1iw6Rwcu4qTrve+o1u0A+Uajm0HTN8alboT4nWcY6pwmmH3aAnOEQtA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0244
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/25/2022 6:33 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, February 25, 2022 3:43 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
>> <KevinYang.Wang@amd.com>
>> Subject: Re: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
>>
>>
>>
>> On 2/25/2022 1:02 PM, Quan, Evan wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Friday, February 25, 2022 2:03 PM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
>>>> <KevinYang.Wang@amd.com>
>>>> Subject: Re: [PATCH] drm/amd/pm: Send message when resp status is
>>>> 0xFC
>>>>
>>>>
>>>>
>>>> On 2/25/2022 11:25 AM, Quan, Evan wrote:
>>>>> [AMD Official Use Only]
>>>>>
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>> Sent: Friday, February 25, 2022 1:47 PM
>>>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-
>> gfx@lists.freedesktop.org
>>>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>>>>>> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
>>>>>> <KevinYang.Wang@amd.com>
>>>>>> Subject: RE: [PATCH] drm/amd/pm: Send message when resp status is
>>>>>> 0xFC
>>>>>>
>>>>>> [AMD Official Use Only]
>>>>>>
>>>>>>> That is the caller can perform something like issuing the same
>>>>>>> message again without prerequisites check on PMFW busy
>>>>>>
>>>>>> This patch expects this method. Caller may try to resend message
>>>>>> again. As part of message sending, driver first checks response
>>>>>> register. Current logic blocks sending any message if it sees 0xFC
>>>>>> in response register, this patch is to address that.
>>>>> [Quan, Evan] Yes, I know. But the caller here could be another one.
>>>>> I mean
>>>> there may be another caller stepped in.
>>>>>
>>>>
>>>> That shouldn't cause an issue to the second caller if it got message mutex.
>>>> The second caller also should be able to send message if PMFW got
>>>> free by that time. The first caller can retry when it gets back the
>>>> message mutex. FW doesn't maintain any state for 0xFC response. Any
>>>> other message may be sent after that. If driver keeps the state based
>>>> on two callers, that is a logic problem in driver. I don't think we have any
>> flow like that.
>>> [Quan, Evan] Yeah, but there may be some case that messages issued by
>> the two callers have dependence.
>>> That means the message issued by the 2nd caller should be only after the
>> 1st one.
>>> The one i can think of is "EnableAllSmuFeatures" message should be after
>> "SetAllowedFeatures" message.
>>> Although that should not cause any problem, I'm not sure whether there is
>> other similar case.
>>>
>>> What I suggest is something like below. We just do it again in
>> smu_cmn_send_smc_msg_with_param() on PMFW busy.
>>>
>>> int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>>> 				    enum smu_message_type msg,
>>> 				    uint32_t param,
>>> 				    uint32_t *read_arg)
>>> {
>>> ...
>>> ...
>>> 	mutex_lock(&smu->message_lock);
>>> 	reg = __smu_cmn_poll_stat(smu);
>>> 	res = __smu_cmn_reg2errno(smu, reg);
>>> 	if (reg == SMU_RESP_NONE ||
>>> 	    reg == SMU_RESP_BUSY_OTHER ||
>>> 	    res == -EREMOTEIO) {
>>> 		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>>> 		goto Out;
>>> 	}
>>> +retry:
>>> 	__smu_cmn_send_msg(smu, (uint16_t) index, param);
>>> 	reg = __smu_cmn_poll_stat(smu);
>>> 	res = __smu_cmn_reg2errno(smu, reg);
>>> +	if (reg == SMU_RESP_BUSY_OTHER) {
>>> +		mdelay(1);
>>> +		goto retry;
>>> +	}
>>
>> I suppose the retry option should be left to caller. Regardless of retry or not,
>> the patch is still valid.
>>
>> Example situation -
>>
>> rocm-smi is trying to get metrics and another app is trying set performance
>> profile. If metrics fetch fail and even retry of metrics fetch fail after some
>> loops, rocm-smi is free to fetch the metrics again after say 5s. That also
>> shouldn't prevent the second app to send performance profile message and
>> that app also may retry the same later.
> [Quan, Evan] I have no doubt the second app may still be able to send performance profile message.
> However, the metrics data retrieved by rocm-smi will be different under such scenario > That is after performance profile setting the clock frequencies may 
go up.
> If the first app is sensitive to that(suppose it wants to compare the clock frequencies before and after performance profile setting), that will be a problem

Ah, my intention was to tell about a different use case, probably a bad 
example.

What I intended is -

rocm-smi is running periodically collecting metrics data and another app 
which doesn't bother about the background data collection trying to do 
something else. Thus a metrics fetch fail shouldn't prevent the other 
app from changing performance profile or whatever it intended to do. 
Also, rocm-smi may be able to fetch data during the next polling 
interval when the PMFW gets relatively free.
> 
> I reconsider this a bit. Can we add one more parameter for smu_cmn_send_smc_msg_with_param()?
> That parameter can tell what the caller wants(retry or abort) under PMFW busy scenario.

There is one complication to this. The same message could return 0xFC 
under different conditions, and it may be fine for situation A but not 
for situation B. For ex: during driver load or init after a reset, we 
don't expect PMFW to be busy.Driver may send message to get metrics data 
to check say 'smart shift is enabled or not'. A failure with 0xFC is not 
a good sign that time and we should abort there.

The same message sent during runtime (like rocm-smi data collection) may 
fail with 0xFC due to workload conditions.

Adding another parameter will complicate things as we need to check 
every condition of message usage. In the present case, a message failure 
with 0xFC is treated as failure during init and we don't proceed. For a 
runtime use, apps always have a choice whether to retry the same API or not.

Thanks,
Lijo

> 
> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>> ...
>>> ...
>>> }
>>>
>>> BR
>>> Evan
>>>>
>>>> Basically, 0xFC is not valid pre-condition check for sending any
>>>> message. As per PMFW team - it only means that PMFW was busy when a
>>>> previous message was sent and PMFW won't change the response status
>>>> when it becomes free.
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> BR
>>>>> Evan
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Quan, Evan <Evan.Quan@amd.com>
>>>>>> Sent: Friday, February 25, 2022 11:07 AM
>>>>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>>>>>> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
>>>>>> <KevinYang.Wang@amd.com>
>>>>>> Subject: RE: [PATCH] drm/amd/pm: Send message when resp status is
>>>>>> 0xFC
>>>>>>
>>>>>> [AMD Official Use Only]
>>>>>>
>>>>>> This may introduce some problems for two callers scenarios. That is
>>>>>> the 2nd one will still proceed even if the 1st one was already blocked.
>>>>>> Maybe the logics here should be performed by the caller. That is
>>>>>> the caller can perform something like issuing the same message
>>>>>> again without prerequisites check on PMFW busy.
>>>>>> Or we can just update the smu_cmn_send_smc_msg APIs to give it
>>>>>> another try on PMFW busy.
>>>>>>
>>>>>> BR
>>>>>> Evan
>>>>>>> -----Original Message-----
>>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>>> Sent: Friday, February 25, 2022 12:22 PM
>>>>>>> To: amd-gfx@lists.freedesktop.org
>>>>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher,
>> Alexander
>>>>>>> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
>>>>>>> <KevinYang.Wang@amd.com>; Quan, Evan <Evan.Quan@amd.com>
>>>>>>> Subject: [PATCH] drm/amd/pm: Send message when resp status is
>> 0xFC
>>>>>>>
>>>>>>> When PMFW is really busy, it will respond with 0xFC. However, it
>>>>>>> doesn't change the response register state when it becomes free.
>>>>>>> Driver should retry and proceed to send message if the response
>>>>>>> status is
>>>>>> 0xFC.
>>>>>>>
>>>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 --
>>>>>>>     1 file changed, 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>>>> index 590a6ed12d54..92161b9d8c1a 100644
>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>>>> @@ -297,7 +297,6 @@ int
>> smu_cmn_send_msg_without_waiting(struct
>>>>>>> smu_context *smu,
>>>>>>>     	reg = __smu_cmn_poll_stat(smu);
>>>>>>>     	res = __smu_cmn_reg2errno(smu, reg);
>>>>>>>     	if (reg == SMU_RESP_NONE ||
>>>>>>> -	    reg == SMU_RESP_BUSY_OTHER ||
>>>>>>>     	    res == -EREMOTEIO)
>>>>>>>     		goto Out;
>>>>>>>     	__smu_cmn_send_msg(smu, msg_index, param); @@ -
>> 391,7 +390,6
>>>>>> @@ int
>>>>>>> smu_cmn_send_smc_msg_with_param(struct
>>>>>>> smu_context *smu,
>>>>>>>     	reg = __smu_cmn_poll_stat(smu);
>>>>>>>     	res = __smu_cmn_reg2errno(smu, reg);
>>>>>>>     	if (reg == SMU_RESP_NONE ||
>>>>>>> -	    reg == SMU_RESP_BUSY_OTHER ||
>>>>>>>     	    res == -EREMOTEIO) {
>>>>>>>     		__smu_cmn_reg_print_error(smu, reg, index, param,
>> msg);
>>>>>>>     		goto Out;
>>>>>>> --
>>>>>>> 2.25.1
