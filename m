Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99021C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 17:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0663010E334;
	Mon, 24 Jan 2022 17:11:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ACDF10E387
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 17:11:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddIZ6orJO3qAtjkC3PPceKEDQQFvfLp54kT/LIq+eI48dMOHijy3lgUpJovzrYhrJwywyP/Q0QNoCs6t0X+s5x3YuB3SnZ5RsY1TlJSHLV98uNJdghqttfwfDbcerdQsjH+q8Xm7v23ACFnaX+nH66+0kWaatH+72weYEKjsmI3OCA3mzHBhH8nveg6AcLgg7vOaJj/ZToqYfdAupP/QHcsnOOFKdSHnkzhxNHR5SLhF0g2d673yvTKcL57fI/eBu8pOspbIpe4ae01mOClf1R87PN1lZrveJKVJhiLrqwLBFjvCKyRz7rjaPJVI6JroaA3zBve3MDP+gCfkWFYU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8MS3QRw5Q3eXqdZR+6aL3jwhAMC9TF1Q9rzCLV7I0M=;
 b=iPdK7/a63UI7ilOwUX7t9Cmwud4RvtczmsnrTJL+M4I/LMQcHxJTVgZiW5VaXXKu40gTQMnYpCl+VEwZQJbX/quFLeTBgBKnR7gKmoh2MX/DSR7lkRNCH3J0If212vGEkjimLrhaAM5RUTybXfkMn+Qp3KhTODsOsuDYvDyvRqKWbyow9UVMUJ/K7na8kV9ypAgsVhRIz/rCPRyffQC3t8kiYr4byRDEiiUrm7bc0IrCQj8V3bezT8p4Q8EcZ7pQ6/qOD2wPy2ErXsdVhii8gu5DXC1jA0dmAX7vv4C5JnaCP2IHiUoc3i9BZGgAeWkD6jn+YyadjE94jvnXz/38BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8MS3QRw5Q3eXqdZR+6aL3jwhAMC9TF1Q9rzCLV7I0M=;
 b=rXZRilolckrwzLXyK47NoQSCZENIek0+LMJqgQGoSDcsIHElyLBS2a/08o1CocacX1hzERvGauixhg5ftEml+L2HfbnT0qbAn1n7eRjV59OrlIK4basRsAtqd3FEVjeyuJZ4VM8qr0d7DwA818aDkj0oQiElJzfQwXZVW4vGsSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 17:11:38 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 17:11:38 +0000
Message-ID: <f77a1cbb-d4e2-af9f-df47-a2ec8c7e927d@amd.com>
Date: Mon, 24 Jan 2022 18:11:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
 <e3a18180-7c02-c10d-157e-8c4b6c6736cb@amd.com>
 <d98e2702-fe42-dfd3-64d6-0eb67a07ca7f@amd.com>
 <805198f1-35b2-2e75-4dbd-9b38079bde9e@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <805198f1-35b2-2e75-4dbd-9b38079bde9e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0017.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::30) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f2f76d3-472f-4c9e-9790-08d9df5c9542
X-MS-TrafficTypeDiagnostic: MN2PR12MB4253:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4253CFAD70303C74D39D5C3DF25E9@MN2PR12MB4253.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpyV6+gUVKMXXFZHvpGvKwAjYuy7ZTYtmTCyV3Vh8Io+9jaLImwR9c8+9EUOvbv7b2rDcVPkF1P+oFAPpxydleX72Fp+OAAIn9z8qqCND5ZYD/TtkSSSiiEgRB/VJwbcyEVuNBICcKscgnamp5ZooC5naYyMsmaQjVLt4OZhwQIjAfdtFjEcJhCmGdg7sp4K46h7qbkwyu0fk/ASSitb3HKtAO3BqT5aFzHB+U1lwAG6ni4085v301LBtqdeTcWHO9afEQL6d2keIKYUAC0BrtaAIJ68VFtEs7hhGRAhWDdG740l7fcMQ7m0VLXcFyLsiHSREAk50Ya6mOBGhienxUPe129lyb2wtRThJEVo1P2EGDq36+4j6BdmkHrBXpc5IxucJRJYJuQEY0Rl8bygBvPPdiirXfqSU5CmeH2kY3oVOW+8tgcJLrHWRodFLZfk5LSYnIz243/2uTRi+ugxew/o1es51dY1ewlfFC8+pGlVTNljKnWNMIBS3fOB8U3IXHkA4AVycWboM1go2G2AJECfeg45/OQRFqNxrrFesCdjN7lQSRb0oJ6w/qp9nYyUkexOUiP7bevsAh7H/aiRHKShw+IlQTBlXepsh2mEVC54i1ErQlO0W1TFNrJVJ6iuiSU8PZ0+VA41z3P2UNL0Vz8b7BhZ5qxrfWZwS2bpy6lGi8n59ZtkZA4sLIrGh0Lflya/Ck9+nQ7VVWZTQ9O+Nx80MTotQFvPwDWYORSAoGDhCQXJCWxgzZXO9B6Aagpvfv1TELbsyA4zLhUh1d3/u84xv9Dkjxm9gUgyIBAgc7wp70FUiy2vuCxakYMbI2oEGWfiHxW+X3jkKsYhA3IzVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(186003)(54906003)(6666004)(6486002)(2616005)(6506007)(8676002)(6512007)(26005)(966005)(316002)(4326008)(31696002)(38100700002)(110136005)(8936002)(31686004)(86362001)(5660300002)(36756003)(83380400001)(66556008)(66476007)(2906002)(66946007)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW00V0tXa05sd1o2R2FKWXRMaEV1QWRJV3FDRjFiZHAyZFZCWEZFdXNIZzJq?=
 =?utf-8?B?RzN4WWpLa2dDUENXMEQyRDBNRHpzOW5QdytHQld2REV1djJRdVIyckVGd1Z1?=
 =?utf-8?B?OUtRUFQzMUZQcFRxSjVFbFZFbkhLZWViZ2tsejZtYThLb01qOUtjYU5FVU5i?=
 =?utf-8?B?NVg4bzNKUHlpZFVxQ2FERFppak9MU3ZBZ1hYWENONkdnL2ptMk1BLzZIbjVG?=
 =?utf-8?B?TFc0R1dmTE0zeC81cGFvbk1HOEdzMUpWTU5HOG0wRGdKcERHWjlBV1ZyN0R6?=
 =?utf-8?B?WVFTWnAyYm5nTzI4RUg1azZ0WnpvL1FmY1Z0QmhBOTRWcWxaNE82eUp0Z0U2?=
 =?utf-8?B?M1RlWVlLT1htNGllakZEdkRNOHZONW43YlBCZ0ZyZTA0azVzYkJ5VW9keXFk?=
 =?utf-8?B?MTZoRWtjRjRuYUFFdWJyNEErR0NES3VHTkYyY3Z5aStKUDJqSW1sbk43Vnk1?=
 =?utf-8?B?SllYRHRSb1FwY0lHakI1RlUvUzdyd1dudE83b3JSZEt2VnhMSzdibUxHNEJs?=
 =?utf-8?B?cGs0dVFzNkc5azh0Z2FibjEranFJcVJ0ZnZucjBCRnRRb3lkUlFZbHptckh2?=
 =?utf-8?B?TllnOEFEQzBZU05xTUgydEpSMEhsVFQrLzNDZzVnSzZudEt1VERiMVhnSndJ?=
 =?utf-8?B?Y2xsb2dYenBVLzZLUHFJQ0FlckdrazdtQnJXSHZmVVgyVUxTTUFWbS9SaFdu?=
 =?utf-8?B?NVkwUUdhNFNWQnVtZUlyYWpYZTAzams1NFhtL3hJSUllejlRNTFBZkE4RlRV?=
 =?utf-8?B?b09KYW9tZDd6VWF1V0U1ZnZzNDlwSzNJVG9uc1U2SFJtdEJmaXIwS3prdG5N?=
 =?utf-8?B?TkhnNUZFeUdYNXNzQXlqL05yWktyaWc0NWxNRXJ0NnFpdG1CbnFqd2EwVkdE?=
 =?utf-8?B?djRBbnlyVHBmdk9wbGd5TmQ4OUVYUDBlMFU2SWEyUE9Ta09TbXpIemtyMlVE?=
 =?utf-8?B?WlBEczJiZE1hOURsZUlMTlNMeGdZTitDbDJiSDRJZzVrQzVock5aVTdzZHBO?=
 =?utf-8?B?WEN4MTB3Y291THNhVk83YnE1M3BUMTVhdXkzUmRlUlZwYTFRUWg0c0FZVXU3?=
 =?utf-8?B?VXQ1SmJZbm9KKytEVThIbDQ4VFpEUUtOMUM3eHRYSXhyS3BQOG9WZGNXYWdL?=
 =?utf-8?B?VnlKalhPdkZFQmJ2V0RVNU1oUVdBMWFZMFR5NmFrZGFRS1NPTnZFSmE2SHNK?=
 =?utf-8?B?TUZLMFRReVlxYkJTKzExY1hyWElCTmZxcm1VaUFlWEJFaWEwVXBMTjR3TGVB?=
 =?utf-8?B?cUVCSndZUVVHNUF1M1c0ZExyVGhPUlc1NGVtd2JyMVRhYTJoMGpsWjR0OFg1?=
 =?utf-8?B?UVVhWjJybHFDWU41b1ptY1loYUJlU0xkWDRrM3h1NlZ0MVVaMHJFc2NjSjIv?=
 =?utf-8?B?R1VNdUdkdzhWVlpNVnZJN2dwL2J6NnQ0RmFGS24vQktSdWpwTEViRDVNREdE?=
 =?utf-8?B?Nmd1M3E2SVloZ3h3TkFkdzBHOHI1SmN2YXN3RVk1cXN4cmluNkExZmwxWm9C?=
 =?utf-8?B?aGtSOS9DQU5KL2pZMEdJTmRWUDhBMS9ZQWtlNGRyeVhrRUE5OG56RlQxcjdX?=
 =?utf-8?B?cG9DQ0t3SWlrSUs0WkYwNjEvdVIwNjlQblYydkZSaVpwU3llQjBxVkRHVDFn?=
 =?utf-8?B?bTJVTVF3d0FkTEFLNE5qcmJ6bE92TUxDdHN3TTB0NDNWdjlTKzR5QWdxWkpQ?=
 =?utf-8?B?VFcxV0dVOTJNa0ZORmxlTCtlczlWdThsdXJCMENtY0NwaDBLNGpFS2dCME1X?=
 =?utf-8?B?bFBtUW9VS04vOG1lVmlGZGlQWGZaUXFyZ1EreTVnYU9EdEtXVmhVNEtIK1J2?=
 =?utf-8?B?RjQ2TWtmOWpoWC9pbndCMWk5SEt6YkowTS9CSHR5ZnQxZWR2ZkN6bE9ZM2Rv?=
 =?utf-8?B?OHVHRkd4c2Z5REpLVWVwRG5qRFUzRnBVZVp4aWtNdTNzbU92L1VuUHhFLzZL?=
 =?utf-8?B?cFcwcTdIeGkwYmU0YUJuSTFUdUxsLzA0enVhTU5VVVE3ZmQyQWJlSjM1Y01i?=
 =?utf-8?B?VXRuRWFkNEJOcm5OOUtDNHp4d3VvTjVFajhjYmo5U1JmL3ZsSytRWmxrcEJW?=
 =?utf-8?B?Z2tMUlVBWUo5bE5ZcUFCWmpRaVlPSkJCb1NIdUM0RlFnNE56b1lDUHV5QTRx?=
 =?utf-8?B?SUJERjNyRytHSEUrYkVLT2VXTkNTNFo3L21BTEdwMVdJSm1hcFMvTSt3aFBP?=
 =?utf-8?Q?TTD9a3SjzVmE+Yi19BCFVmI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2f76d3-472f-4c9e-9790-08d9df5c9542
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 17:11:38.5821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUEYuxja4BJfMpK1gTGHDjFGzzczA5VjVjjg2/qmyfgrDQ1aiwIYnjfL2zFPFFbKh9Gt7XFdHuXi7KtyInhbFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
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
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/24/2022 6:08 PM, Andrey Grodzovsky wrote:
> It's just an infrastructure you use when you need.
> I never tested it during reset i think but, we deliberately did it very 
> self reliant where you simply iterate a FIFO of the dump through PMI3 
> registers interface and dump out the content. It currently supposed to 
> work for the NV family.
>

Got it, thanks for the suggestion. Let me check the feasibility of 
plug-in STB in out existing design and use case.

- Shashank


> In case you encounter issues during reset let me know and I will do my 
> best to resolve them.
> 
> Andrey
> 
> On 2022-01-24 11:38, Sharma, Shashank wrote:
>> Hey Andrey,
>> That seems like a good idea, may I know if there is a trigger for STB 
>> dump ? or is it just the infrastructure which one can use when they 
>> feel a need to dump info ? Also, how reliable is the STB infra during 
>> a reset ?
>>
>> Regards
>> Shashank
>> On 1/24/2022 5:32 PM, Andrey Grodzovsky wrote:
>>> You probably can add the STB dump we worked on a while ago to your 
>>> info dump - a reminder
>>> on the feature is here 
>>> https://www.spinics.net/lists/amd-gfx/msg70751.html
>>>
>>> Andrey
>>>
>>> On 2022-01-21 15:34, Sharma, Shashank wrote:
>>>> From 899ec6060eb7d8a3d4d56ab439e4e6cdd74190a4 Mon Sep 17 00:00:00 2001
>>>> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>> Date: Fri, 21 Jan 2022 14:19:42 +0530
>>>> Subject: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
>>>>
>>>> This patch adds a GPU reset handler for Navi ASIC family, which
>>>> typically dumps some of the registersand sends a trace event.
>>>>
>>>> V2: Accomodated call to work function to send uevent
>>>>
>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/nv.c | 28 ++++++++++++++++++++++++++++
>>>>  1 file changed, 28 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> index 01efda4398e5..ada35d4c5245 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> @@ -528,10 +528,38 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>>>>      }
>>>>  }
>>>>
>>>> +static void amdgpu_reset_dumps(struct amdgpu_device *adev)
>>>> +{
>>>> +    int r = 0, i;
>>>> +
>>>> +    /* original raven doesn't have full asic reset */
>>>> +    if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
>>>> +        !(adev->apu_flags & AMD_APU_IS_RAVEN2))
>>>> +        return;
>>>> +    for (i = 0; i < adev->num_ip_blocks; i++) {
>>>> +        if (!adev->ip_blocks[i].status.valid)
>>>> +            continue;
>>>> +        if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
>>>> +            continue;
>>>> +        r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
>>>> +
>>>> +        if (r)
>>>> +            DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
>>>> + adev->ip_blocks[i].version->funcs->name, r);
>>>> +    }
>>>> +
>>>> +    /* Schedule work to send uevent */
>>>> +    if (!queue_work(system_unbound_wq, &adev->gpu_reset_work))
>>>> +        DRM_ERROR("failed to add GPU reset work\n");
>>>> +
>>>> +    dump_stack();
>>>> +}
>>>> +
>>>>  static int nv_asic_reset(struct amdgpu_device *adev)
>>>>  {
>>>>      int ret = 0;
>>>>
>>>> +    amdgpu_reset_dumps(adev);
>>>>      switch (nv_asic_reset_method(adev)) {
>>>>      case AMD_RESET_METHOD_PCI:
>>>>          dev_info(adev->dev, "PCI reset\n");
