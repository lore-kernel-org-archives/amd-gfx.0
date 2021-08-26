Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4FAC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E8F2610A1
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E8F2610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C6186E832;
	Thu, 26 Aug 2021 12:41:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (unknown
 [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 742FC6E832
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 12:41:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gvd32mQCwq58vUeROQOegEn8KYLm10i8a5h9q2UeJwifmugrejaUSZ06TDulPeOsFUDTNBGPiCmziOy+jjZl8NcVWHHcsirMG3v36dUdSUilUHW1VADTttaJqGkn+eS2YrBcMzN5cl4+XpGsnw45xtNtJi10fPuX0iuJ3uiM8pOPLrNNDU1tcHLiJbden8hDQWAuDrSlTThxTYOlMHPEVgUNECApRKsvOtgxuWTUJJ4os7NjAkDS2agvKqoW7sLgHN0JLFDFZmi3ncLB8GDmML6WMQ33y+6cvzEL2ITZS1usZNEh3F0QIcTsciMmngn+aT7ub/bzHyA+nlnmeSUZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC9wySCxdK9LW62SQRe7IEMQ6yRanuRRR/xWHDI7qyg=;
 b=IbqyFMVVZCufwl6ViymFWlFy/lYUvyVOv220CB5TfGH6pvNMBW4IXUPfc17iZHrV+C+wexvsv4YY2WZy1XbFcjTqDyC1gliYZVRqmUKW8q3/WlBRGHlz43hxaUDGMuI3u1QpFxY6KBJiQ5q/xo5dK5Bdars/lmF5YJ27o39oi8RkE3EcgPUJqHKw57sN6KGnc+1WWZ9mavVG9pTUclAPxukUotfbgpipyN2qYNK7lU//nDN/aBSpwDJePq3e9rbMaWTvDRZSQzNwz2JybV67+MPG003KbC/jdQJ5Z43Q0C2dOLsJc9YCMF7k80Zw+0fvHAaswgTrma96m4bis4mpcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC9wySCxdK9LW62SQRe7IEMQ6yRanuRRR/xWHDI7qyg=;
 b=PX8oxM4EnjWiekixf89zusFY34aenm8VK7PAHI2WIbqkWQf1C+QVgo4vFEWmOFubEb1XigHMb2Ip7sGaLQmdCjgmLoq/S00klPw+UWlRS9Z4tCFLOS6WW2aEEPheghVSIInF6EYDFf8SAuZH+goDxRxznNS8df31FYjmdlrD7ec=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5271.namprd12.prod.outlook.com (2603:10b6:208:315::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 12:26:23 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Thu, 26 Aug 2021
 12:26:23 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v5)
To: "StDenis, Tom" <Tom.StDenis@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210825172659.247530-1-tom.stdenis@amd.com>
 <4f68568f-6f38-a36d-397b-c9d1d03cf9e2@amd.com>
 <DM6PR12MB3547D401A95FC5CB86595348F7C79@DM6PR12MB3547.namprd12.prod.outlook.com>
 <eec9d9d5-aff6-5344-b15b-155a46a57e76@amd.com>
 <DM6PR12MB35470F0FA108B66B49434B10F7C79@DM6PR12MB3547.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <2ae34dc2-adb6-54e2-30bc-a9636e1fc41e@amd.com>
Date: Thu, 26 Aug 2021 17:56:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB35470F0FA108B66B49434B10F7C79@DM6PR12MB3547.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::12) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0067.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:23::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.20 via Frontend Transport; Thu, 26 Aug 2021 12:26:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3714917-12bb-4d6b-4743-08d9688cb75f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5271:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5271875ED5FDFE861FD358D397C79@BL1PR12MB5271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cjj53vRgKHuMeOJwLjIejNuYuIs2NmaxfkKvrebycgKTYJusDMQX0k+bRUIQgYuBJ3OX5BBUZBGVYmN70mvPK2W5eYGxLJZzVtsb/n6XtbXykDuGh8xgQs4LkX7QQDle/shfpII/N/VjB6Lo/XRln8of6jHCYJansxOqUBYJyLvpyQT6BwEfX8EXbpYciGcpp3QLY3wbehUhZtDbLaGIr1uBRzcgY5eps/ccEhU4R1ayebbAI9x6fhsdYKac5RYF0ceTLvJf1vTYLHikVYVDHPlFK9H4d81p+S5gr6ZH66mivU8scdtXfXebW6SDZdDq0w4BC9LhZTHd+lAFG5qKa123RDPe6IQJG+W/8QdsmB5iLFDyqX+k2H4o5EvZTHW3aom3pdAGaFomua5kjVjypl4NtJZHk2JBTwFeCd+Ro0MdJEUd6rW38O8zgfsfF6AEvLM2eHNBp6pJR8J9JBYNt+m5CMMhMmugNbk107wRMtZGI9udVoNWtG37nNxOI8Q77r0w46ARBo61fnzLynAFWa5MnVU05id4hZdYJ9pek8ViP4VMyuxX4m5G14Q7ur1bMWIXVkOIYxSMR8a9WrSJepqb3LwMc4tPAWf2BofSoD5rBdI5jREH2/kYoq2y8NAOhAz75KsJfDpvofFMuJMoYeKv9Nvgw4s8aQk7ZpYlSiUxaZWb5Ell8FuFNF3ag52BAe+Rbz63dqfqAl04/UvUURQEh/K80HqHKRFj5WY7aps=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(110136005)(16576012)(31696002)(8676002)(66556008)(66476007)(6666004)(5660300002)(316002)(86362001)(38100700002)(8936002)(66946007)(2616005)(956004)(83380400001)(2906002)(30864003)(36756003)(6486002)(53546011)(186003)(31686004)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGNIcmRxUUYxZVJQSDZzK3ZUMUpTbU8zcSt5bjBTdngvN2Y0dzQraXRqbmo4?=
 =?utf-8?B?TmpMamY0c3BJSFh2NVc4RXVvMGZKcU5qVDYvanVlU3k2Vzk1djZub2lPdk82?=
 =?utf-8?B?bnpKOHcvZ0lpK3RJaFBNaldyTVl4cUtZTDFvR01BdEQ1a1RENTc5cy9uTHdE?=
 =?utf-8?B?dUpFUlVQM3FvdW1vbnZwS2ZoSy9aYTVPOUpyS3BhalFNekxxQmpJdWQ3TVp2?=
 =?utf-8?B?L0dvN0RnQzR0QTNCMHMvOGJWYWNRdWROLzZGOFlLdGtDSWNGREVFTlZoTGJN?=
 =?utf-8?B?eG9tSkxwdG8xVmVuclBUV2RZczZ3UmJVRmNkVlpEdDZtdGdZb0hRTHVxSC9m?=
 =?utf-8?B?RzZ1SlhLakd1UGRFa0JoR2RLWS9mcXduZ2NpSGFRem9YanBQcThNbUF2dlhk?=
 =?utf-8?B?SDBPdlJUWXd5U2Z1YTMzeEswb0FEMHdNbzlCdmhOSDZKZ0d2M3FYcWVsdkxp?=
 =?utf-8?B?cG9nR2VqdWNsQ2ZEMW9wVExodVNISU5BWWltMHUwdmVXOWNhUWVwRFRGdDlx?=
 =?utf-8?B?YnJySVlCUWN3TzBrRzNqSS93cFFuNnpoTFM4MG5IL1dWd2JKVkd4KytlMDF6?=
 =?utf-8?B?UHZvZjVvT05ML3NtY1pFQTltN2poTk9qT1c2WXJFTDFJVXdqc091UnFsK0Fj?=
 =?utf-8?B?VkdrMGFuUG9FSU56YVZ0UllDVVJMYUdHMnNtaHpZdE9LQUhGZHBjOXQrUDBR?=
 =?utf-8?B?U3RiTEM1a0xmT1Z5cVFYNzVNWHFsWkRMcTBLL2FKcnhrV2FPSTRvM0hJclJZ?=
 =?utf-8?B?Qjl1d1EyUGszRzhRclJLRFZGYnVYYThYVWpzRlFVQ0ZnLzZySDlXUHl2ZlEx?=
 =?utf-8?B?eDlpNXNoL09sSHBNRmVqSS9iQjRFenIxQ1JtM0hIdnlxcnUyT0hHZndZbnRR?=
 =?utf-8?B?OVRPWHhNT1QrOUxyZkR1UFNQRSs4YWxDV0psVXphMlNORWxrQzkxU1hNU3pu?=
 =?utf-8?B?Zk01bjJNK1orOXFFMUExSmkraDg3TjBNek1mZnJ4ZDZyWjdmS2tLVElMMkxP?=
 =?utf-8?B?U0gzdzNmV08wcGIyVi9JRWJmLzAyZnlwUURjN2pXNEk1V3Y5RnR2QkoyeDJJ?=
 =?utf-8?B?MHJPVHRqWVFRNW50ak12Z0hncXV6cHdPN2czMnRnYVpMcmI0c2FCUE5Rcjkv?=
 =?utf-8?B?REpxOUFBZkdLU1ZBQ0VxR0ZsVS9kWlFtbVlhSkVla3FMV3FxOVBQT3plS2dL?=
 =?utf-8?B?elcrSXRvTWh5aUJyb0xENTdrUWxqc2dFM2ptd1pXNzZ2bmE0bVYvYUtzb0Zo?=
 =?utf-8?B?VDVHL1dPZ0RhWUh1QmxGU0grL1lZQmtUTm11a2JVSENMeDRSemoySlRuM0FY?=
 =?utf-8?B?d0ZIYkRjUHJqNmM0TjJlRGhJc1BjdnNBNGs3RUhsK2laQnZaY214Y2dTcjJP?=
 =?utf-8?B?OWtBb2xjQnpMdk1wRk50T1ZESzA1SjJ5WitWVUhDcmZ3QUhkZXllSXZDbVF5?=
 =?utf-8?B?WkZuWnF5aHlDVHdwcGtIdzhVVWpXZEtxeCtCSFA0VGduY1lwSld0ck5OTW1C?=
 =?utf-8?B?RUViNlpsQnU5ZG84WGkrQlkvbTVjSjY0RDRSRDBiMDhTek1vaFNIS1FXQmFi?=
 =?utf-8?B?bzB3bU9SQWJGekJ2NUhMdmNJZXFza1ZncGJnZWhBWnc4Umgyanc2ZEo3REh1?=
 =?utf-8?B?NXNXbjBsTWo2LzFjdG1NekVrdkpuVzlKVjFicnQ5L0Y0amEzOU1jY1ZqckZT?=
 =?utf-8?B?MXJOeGhrRkdncFVYRmlpSUN2RUdoR0dQbDVPd3FjWHNuakpkS2NYRjIrdmhT?=
 =?utf-8?Q?O/PIdYLDxpCCeCp7CRjqcEfWO+DpDC2Kq4gfMF4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3714917-12bb-4d6b-4743-08d9688cb75f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 12:26:23.2065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZ0GFXy0NF48/dlCUT1u0aGVWBLuOMrKUZiOlBKM8mz13R1/5d9SHi1InYMxvhat
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
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

Does that really need a lock? Can't local variables solve it?

Thanks,
Lijo

On 8/26/2021 5:52 PM, StDenis, Tom wrote:
> [AMD Official Use Only]
> 
> The issue is someone can issue an ioctl WHILE a read/write is happening.  In that case a read could take a [say] SRBM lock but then never free it.
> 
> Two threads racing operations WITH the lock in place just means the userspace gets undefined outputs which from the kernel is fine.
> 
> Tom
> 
> ________________________________________
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, August 26, 2021 08:19
> To: StDenis, Tom; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers (v5)
> 
> If there are two threads using the same fd, I don't see anything that
> prevent this order
> 
>          set_state (T1) // State1
>          set_state (T2) // State2
>          read (T1)
>          write (T2)
> 
> If there are separate fds, I guess the device level mutex takes care anyway.
> 
> Thanks,
> Lijo
> 
> On 8/26/2021 5:45 PM, StDenis, Tom wrote:
>> [AMD Official Use Only]
>>
>> While umr uses this as a constant two-step dance that doesn't mean another user task couldn't misbehave.  Two threads firing read/write and IOCTL at the same time could cause a lock imbalance.
>>
>> As I remarked to Christian offline that's unlikely to happen since umr is the only likely user of this it's still ideal to avoid potential race conditions as a matter of correctness.
>>
>> Tom
>>
>> ________________________________________
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, August 26, 2021 08:12
>> To: StDenis, Tom; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers (v5)
>>
>>
>>
>> On 8/25/2021 10:56 PM, Tom St Denis wrote:
>>> This new debugfs interface uses an IOCTL interface in order to pass
>>> along state information like SRBM and GRBM bank switching.  This
>>> new interface also allows a full 32-bit MMIO address range which
>>> the previous didn't.  With this new design we have room to grow
>>> the flexibility of the file as need be.
>>>
>>> (v2): Move read/write to .read/.write, fix style, add comment
>>>          for IOCTL data structure
>>>
>>> (v3): C style comments
>>>
>>> (v4): use u32 in struct and remove offset variable
>>>
>>> (v5): Drop flag clearing in op function, use 0xFFFFFFFF for broadcast
>>>          instead of 0x3FF, use mutex for op/ioctl.
>>>
>>> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
>>> ---
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 150 ++++++++++++++++++++
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |   1 -
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h     |  51 +++++++
>>>     3 files changed, 201 insertions(+), 1 deletion(-)
>>>     create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 277128846dd1..87766fef0b1c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -36,6 +36,7 @@
>>>     #include "amdgpu_rap.h"
>>>     #include "amdgpu_securedisplay.h"
>>>     #include "amdgpu_fw_attestation.h"
>>> +#include "amdgpu_umr.h"
>>>
>>>     int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
>>>     {
>>> @@ -279,6 +280,143 @@ static ssize_t amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
>>>         return amdgpu_debugfs_process_reg_op(false, f, (char __user *)buf, size, pos);
>>>     }
>>>
>>> +static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file *file)
>>> +{
>>> +     struct amdgpu_debugfs_regs2_data *rd;
>>> +
>>> +     rd = kzalloc(sizeof *rd, GFP_KERNEL);
>>> +     if (!rd)
>>> +             return -ENOMEM;
>>> +     rd->adev = file_inode(file)->i_private;
>>> +     file->private_data = rd;
>>> +     mutex_init(&rd->lock);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int amdgpu_debugfs_regs2_release(struct inode *inode, struct file *file)
>>> +{
>>> +     kfree(file->private_data);
>>> +     return 0;
>>> +}
>>> +
>>> +static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 offset, size_t size, int write_en)
>>> +{
>>> +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>>> +     struct amdgpu_device *adev = rd->adev;
>>> +     ssize_t result = 0;
>>> +     int r;
>>> +     uint32_t value;
>>> +
>>> +     if (size & 0x3 || offset & 0x3)
>>> +             return -EINVAL;
>>> +
>>> +     r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>> +     if (r < 0) {
>>> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> +             return r;
>>> +     }
>>> +
>>> +     r = amdgpu_virt_enable_access_debugfs(adev);
>>> +     if (r < 0) {
>>> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> +             return r;
>>> +     }
>>> +
>>> +     mutex_lock(&rd->lock);
>>> +
>>> +     if (rd->id.use_grbm) {
>>> +             if ((rd->id.grbm.sh != 0xFFFFFFFF && rd->id.grbm.sh >= adev->gfx.config.max_sh_per_se) ||
>>> +                 (rd->id.grbm.se != 0xFFFFFFFF && rd->id.grbm.se >= adev->gfx.config.max_shader_engines)) {
>>> +                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>> +                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> +                     amdgpu_virt_disable_access_debugfs(adev);
>>> +                     mutex_unlock(&rd->lock);
>>> +                     return -EINVAL;
>>> +             }
>>> +             mutex_lock(&adev->grbm_idx_mutex);
>>> +             amdgpu_gfx_select_se_sh(adev, rd->id.grbm.se,
>>> +                                                             rd->id.grbm.sh,
>>> +                                                             rd->id.grbm.instance);
>>> +     }
>>> +
>>> +     if (rd->id.use_srbm) {
>>> +             mutex_lock(&adev->srbm_mutex);
>>> +             amdgpu_gfx_select_me_pipe_q(adev, rd->id.srbm.me, rd->id.srbm.pipe,
>>> +                                                                     rd->id.srbm.queue, rd->id.srbm.vmid);
>>> +     }
>>> +
>>> +     if (rd->id.pg_lock)
>>> +             mutex_lock(&adev->pm.mutex);
>>> +
>>> +     while (size) {
>>> +             if (!write_en) {
>>> +                     value = RREG32(offset >> 2);
>>> +                     r = put_user(value, (uint32_t *)buf);
>>> +             } else {
>>> +                     r = get_user(value, (uint32_t *)buf);
>>> +                     if (!r)
>>> +                             amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, value);
>>> +             }
>>> +             if (r) {
>>> +                     result = r;
>>> +                     goto end;
>>> +             }
>>> +             offset += 4;
>>> +             size -= 4;
>>> +             result += 4;
>>> +             buf += 4;
>>> +     }
>>> +end:
>>> +     if (rd->id.use_grbm) {
>>> +             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>>> +             mutex_unlock(&adev->grbm_idx_mutex);
>>> +     }
>>> +
>>> +     if (rd->id.use_srbm) {
>>> +             amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
>>> +             mutex_unlock(&adev->srbm_mutex);
>>> +     }
>>> +
>>> +     if (rd->id.pg_lock)
>>> +             mutex_unlock(&adev->pm.mutex);
>>> +
>>> +     mutex_unlock(&rd->lock);
>>> +
>>> +     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>> +     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> +
>>> +     amdgpu_virt_disable_access_debugfs(adev);
>>> +     return result;
>>> +}
>>> +
>>> +static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int cmd, unsigned long data)
>>> +{
>>> +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>>> +     int r;
>>> +
>>> +     switch (cmd) {
>>> +     case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
>>> +             mutex_lock(&rd->lock);
>>> +             r = copy_from_user(&rd->id, (struct amdgpu_debugfs_regs2_iocdata *)data, sizeof rd->id);
>>> +             mutex_unlock(&rd->lock);
>>
>> As this is a two-step read/write, I don't think there is any protection
>> offered by having this mutex.
>>
>> Thanks,
>> Lijo
>>
>>> +             return r ? -EINVAL : 0;
>>> +     default:
>>> +             return -EINVAL;
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>> +static ssize_t amdgpu_debugfs_regs2_read(struct file *f, char __user *buf, size_t size, loff_t *pos)
>>> +{
>>> +     return amdgpu_debugfs_regs2_op(f, buf, *pos, size, 0);
>>> +}
>>> +
>>> +static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char __user *buf, size_t size, loff_t *pos)
>>> +{
>>> +     return amdgpu_debugfs_regs2_op(f, (char __user *)buf, *pos, size, 1);
>>> +}
>>> +
>>>
>>>     /**
>>>      * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
>>> @@ -1091,6 +1229,16 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
>>>         return result;
>>>     }
>>>
>>> +static const struct file_operations amdgpu_debugfs_regs2_fops = {
>>> +     .owner = THIS_MODULE,
>>> +     .unlocked_ioctl = amdgpu_debugfs_regs2_ioctl,
>>> +     .read = amdgpu_debugfs_regs2_read,
>>> +     .write = amdgpu_debugfs_regs2_write,
>>> +     .open = amdgpu_debugfs_regs2_open,
>>> +     .release = amdgpu_debugfs_regs2_release,
>>> +     .llseek = default_llseek
>>> +};
>>> +
>>>     static const struct file_operations amdgpu_debugfs_regs_fops = {
>>>         .owner = THIS_MODULE,
>>>         .read = amdgpu_debugfs_regs_read,
>>> @@ -1148,6 +1296,7 @@ static const struct file_operations amdgpu_debugfs_gfxoff_fops = {
>>>
>>>     static const struct file_operations *debugfs_regs[] = {
>>>         &amdgpu_debugfs_regs_fops,
>>> +     &amdgpu_debugfs_regs2_fops,
>>>         &amdgpu_debugfs_regs_didt_fops,
>>>         &amdgpu_debugfs_regs_pcie_fops,
>>>         &amdgpu_debugfs_regs_smc_fops,
>>> @@ -1160,6 +1309,7 @@ static const struct file_operations *debugfs_regs[] = {
>>>
>>>     static const char *debugfs_regs_names[] = {
>>>         "amdgpu_regs",
>>> +     "amdgpu_regs2",
>>>         "amdgpu_regs_didt",
>>>         "amdgpu_regs_pcie",
>>>         "amdgpu_regs_smc",
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> index 141a8474e24f..6d4965b2d01e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> @@ -22,7 +22,6 @@
>>>      * OTHER DEALINGS IN THE SOFTWARE.
>>>      *
>>>      */
>>> -
>>>     /*
>>>      * Debugfs
>>>      */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
>>> new file mode 100644
>>> index 000000000000..919d9d401750
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umr.h
>>> @@ -0,0 +1,51 @@
>>> +/*
>>> + * Copyright 2021 Advanced Micro Devices, Inc.
>>> + *
>>> + * Permission is hereby granted, free of charge, to any person obtaining a
>>> + * copy of this software and associated documentation files (the "Software"),
>>> + * to deal in the Software without restriction, including without limitation
>>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>>> + * and/or sell copies of the Software, and to permit persons to whom the
>>> + * Software is furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>> + *
>>> + */
>>> +#include <linux/ioctl.h>
>>> +
>>> +/*
>>> + * MMIO debugfs IOCTL structure
>>> + */
>>> +struct amdgpu_debugfs_regs2_iocdata {
>>> +     __u32 use_srbm, use_grbm, pg_lock;
>>> +     struct {
>>> +             __u32 se, sh, instance;
>>> +     } grbm;
>>> +     struct {
>>> +             __u32 me, pipe, queue, vmid;
>>> +     } srbm;
>>> +};
>>> +
>>> +/*
>>> + * MMIO debugfs state data (per file* handle)
>>> + */
>>> +struct amdgpu_debugfs_regs2_data {
>>> +     struct amdgpu_device *adev;
>>> +     struct mutex lock;
>>> +     struct amdgpu_debugfs_regs2_iocdata id;
>>> +};
>>> +
>>> +enum AMDGPU_DEBUGFS_REGS2_CMDS {
>>> +     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,
>>> +};
>>> +
>>> +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
>>>
