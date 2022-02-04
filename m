Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D82C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 16:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D71810E23E;
	Fri,  4 Feb 2022 16:39:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E97FB10E23E
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 16:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmfiCNj9gBTFoC3nN7ICnliZhBk5agyCPm0Kmmsvb5+gfECb5Nb5lv85QEuYqKnt/w0BiS9MVuqArbRYRqV140ctQZMJZ5IclEkKhfwJK/kM6J4/F5E03JTYlial8ttWqdXgj1YORamS0SzY5/dElfrVlLCTFpFf/DlnY2pkctdTeANMjf/MwG3/zkt0KwTEldJK5al7PtDeX0GE707sWbsfMT6qYzibani9WpxmntJoVZX41+hE8ZaSoglGeAeUdBzOS2LDXjqwjveJW4yJD3PTluZYIYqtUBV3n2Y7lTPlerJAPLEQe3EV/7gtpLXCnR1ERdUcR8pP2kvnUhg2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4RmTbAWM27eDTZ96GO7VQkSWeqDecY2CwYktzcw+SU=;
 b=bff5PhfKaZG7JBE8R98IeJFlbgOdziDQk6quxrlpbe+6Pud9JI+fWSjwsjsP52Eo9/VjiuWlQoiu/7am9fbphzboyHIOXmsnW4wTXIXJ6j2qTC9e5RSjBc7bcGRJBRMilK/AmmZQY4Rmh8dVQNzVqhaCkQ86EJKlujSOKl9/jMXTEsDFnpsezw0AtFiXLavTYhv+7gE3DSeNOn8+Q650IRPozU1kE4whTSapVXtsu3K1C69Sdda+Jm2Jenf4G3tPdZ3UBdsDXNME+Zeho6Fd4NjmJyBxV9Wjv7m60S33mCvQ/gaN97CAEjUGjbxN1iNDNwsmvrXCfjn5kWjHASTEMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4RmTbAWM27eDTZ96GO7VQkSWeqDecY2CwYktzcw+SU=;
 b=qLG5qGklojR6EV+TwmpeugPeDbwtT0xRrpEL/HQ6vU1I9Sy5hkLMT2phAIoyAwWGqzibi3MTmGsTHBNscfWdge6RLXRXUF2ShWdOJDEya39WbdtgYlu9TbdaiDTzgwXXYGUuTmKwivXai3gymfWeSKmlTdG8jxHQKIE6G2axgEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM6PR12MB2713.namprd12.prod.outlook.com (2603:10b6:5:4c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 16:38:57 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 16:38:57 +0000
Message-ID: <817df2c3-e7af-92cb-53f8-8bc70b69b988@amd.com>
Date: Fri, 4 Feb 2022 17:38:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
 <a0693436-619c-efa1-b3f1-2fca6377e2fe@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <a0693436-619c-efa1-b3f1-2fca6377e2fe@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P195CA0060.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::37) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd25896e-7bc2-4c8f-298c-08d9e7fcd6d9
X-MS-TrafficTypeDiagnostic: DM6PR12MB2713:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB271381EC6B245B1A10CA1128F2299@DM6PR12MB2713.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3IOD+P8dxM8H7sx1f/9Aw0ihzc5XyG/iBla1iiujiituBzPhemoJemcYrs7iNwBkFPIRp2YfFH3m/qX3HR6dr1gnzvikVlwLxv5cv5WMUxARdynHBpPXKbPaRX6o3c4MssWnVhaoJiQ1gHE9sCLzbajbd26ptmpDhgaRHDsusmi/RpAPdJ2at/rGNR6MYxLNS7EUYNc+LNbeosV43hegtcLcoWe9P1C7Bl4N7nxjLwIZGr+F121FrKHE1vqAO4E2qFFKpZq7x0ujfghdw2ssJe2dsPN7JY6oQG3nJFoI/oITm2NZYPdLG5NYh+IXe8wM6kpNiZDoAc7BzEbJMc0sqkkBAgabvYJD9hJMwkoAMhM5qd3SKfZ5mehn7WFcgghodAcx8fxLUiuzwpRumHVqn694uOlh98iGBAnn1FyTKuBfDL26kv894eQ69fMlIkN9OR/NGZQVd8IkbnrCoU2pRRLILqInP5MoQgL7ZlJj77hp68PKLxVsbwWyj06g+cb/M4FFO4WCebMdNOLCUdW3YDfGgs12+N1YicjSSPZap8B/YFw+SmNwGEgrb1gdETARX71mi6zyCKR6g4NYgAFpYiYKok4XGiV+UuzOJPqkm5gK05tcTR70BnC9hCaYhr4Rl4XH/59A5BKqQgO8kstGDURsMajXok9/yL5by49CiQfxolsbP5ey/x6aFZYsWvrscMMow1iz1+sgy8kG8aohoPXuWEUn1tIKUndWWsDriOOiRt9iHcEJRz2LASZiTJP77Lfrx/+Tk7TiKxCQZ6QVAoLny5IbRkZI813pmqyM+J9KIoLfOZ/XOysBCYGfO96R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(86362001)(38100700002)(26005)(5660300002)(186003)(2616005)(31686004)(31696002)(508600001)(6512007)(110136005)(6486002)(966005)(66946007)(36756003)(4326008)(54906003)(66556008)(8676002)(8936002)(6666004)(53546011)(2906002)(66476007)(6506007)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amlWeVVudmpaMEEzaGx2ZDVDdDRuQTdRaC9qMUlldU9JSGxWajJnTjRLbldm?=
 =?utf-8?B?U01MWUVtblVIazhhdkJCSmQwNWNoY2o4WUJQMUtSUnpsczcvL2gzV2xHREZj?=
 =?utf-8?B?NUpIMEhSNUU1S1lPNTNpc211SkErMVlCZjFzQ283eEdOUEVCaEFtQk1xbWky?=
 =?utf-8?B?eTRjZmJCc1hoOWxzaVFBZ3EzQ0FtZzBvVnRmT0F4a01PNHVCbkVubkxOZG83?=
 =?utf-8?B?WWpOZHdLS0UzdU9oL0tianJWUzJJbmdFR1kzVTVuaStSY2txYy8xRWpDT0pq?=
 =?utf-8?B?VElKYUg1SDZJeXMyM3NNcXNhaG8vbWhVQlh4REFHUXdjYmp1bFFxaVZCTkkx?=
 =?utf-8?B?NzZJZGtFdnBibGZFdXg2VUJMQlA5VG5YUFNCN2o1azhFWjdrTWVtY3I5KzJz?=
 =?utf-8?B?ZjBWcnhYWjZ0NXl0Y09oUTJyb1NDeTRsU1dqUXVMSVhtUWZkbDJQNGx4ZXZ0?=
 =?utf-8?B?YitLRkFqNVg0WXpBUUJ0VStxWUlLazhyZ053SHJST0VtZDFYSWp0ZlJQaHRs?=
 =?utf-8?B?VG5TZ2tuYW1WMEpaT00wSTlxM3M3OWFpVW9VZTA0VEF1cW1NNEZZZk9HR0Fk?=
 =?utf-8?B?aEJxcFhRZ0V5VDdKNytGdzNxMVhZVHRtMVV5dVJIc0Vnd3RML1ZnMmpEZ01R?=
 =?utf-8?B?SFViRjNWOVhtZHpUWkhVUUZ4SGJsc2pYN01jTERrYVFBa3l0RVVvUGFVT1pD?=
 =?utf-8?B?RlM0dHZLRUJSYlIvQ1JZYkgvdC95Y0RZK0F6VG5zcTlGczhET1U0MUg0cGVZ?=
 =?utf-8?B?bTJuM0pQblE4NTVsWnJkb3ZZZlZqK1pPWElCZloxUHBTcVpzN0Q4ZzU5eVpS?=
 =?utf-8?B?VCtzYUxDTDZjNHp3Wm8vNEZSVHM2MHYvMzlKeTZvb1B1ZUFGV1Z4NHdrV0E5?=
 =?utf-8?B?aTFTbGxCdDE1MnIrREN4dGFrb003NnBSdmNzd3VIc3dweW0wZDJTTURSQkZQ?=
 =?utf-8?B?RmoycXlQMnlWajNEcjBlYlpLVW9GWVgvZ0d1Z1k2dTg1bWwxSU13ZFBqM2k2?=
 =?utf-8?B?bkQ3Qm9BS0pXUmVOZTZMVHdpUVJEcmNCRE9vdSt2VjE0RE5VeTNMakdpTFhP?=
 =?utf-8?B?TG9NKzBRRlFsNkxJRmpXemNrQzZzMm01VjQ4SVdtcmhDdXNrbXFQYjErWDcz?=
 =?utf-8?B?N1lUazQyWm1PQkFLN2RTY0RLUXpSd2g0TlVTR0RFdS95NC9nalJMc1YyVE8w?=
 =?utf-8?B?NU9DT1lGeFdEb2FaZHNUckhpWW5vNWx0MjJsQVVSczQwY1JDTFQydmdCODlx?=
 =?utf-8?B?dWk0Wm93WnNzME5XeXVFcWEzOEgwQzdyYjBtWUg3QWFINDR3SThZT2lVZTN1?=
 =?utf-8?B?N01NZnJHMWk3aUNMWWtqaStPcWxvNDZudXgvQ1RGZktKVmNUWjFseFdJV3hS?=
 =?utf-8?B?WG5yVXZDODBJTnF3dEpmdXNYbW1rVXgwN2VuNjFkMWM1NkNXMGIyRCtPbG1H?=
 =?utf-8?B?UjgrelVsMWVnQktIcXVkWmorSHpCNHVtRTNRY3FSZFhoMy9SS0dUZkdvdENy?=
 =?utf-8?B?QkF3N1NHMXZUTzExekx4RG5IZ2Q2SXlEcHAzZVBOa0Q4bndhalM4WE8xeHR6?=
 =?utf-8?B?U3cra3gwNkx3T08zRnk2NlBZYjBxMldVVHNKZU9Fa2ZPTkVUaktzOFE2L0xB?=
 =?utf-8?B?MWxBSHNiVVUyTXpBbDlwNFBES0E0VXdwWVUySm1sZ3kyMXdqSFptVkVDUmNH?=
 =?utf-8?B?aDJVODV0cVpXWXU2ZW51VmlMT1ZZeWc4ZHlSdjd6T1lIaUhEcVN6dmEvOHly?=
 =?utf-8?B?REdZQW1HMGFuZnZrNXpSdkd3WWhRTTlVRlBTQld3eGIvci9IZUdyWFR5dEUv?=
 =?utf-8?B?Tmptb2xieTNIZnU0UlFxQWtHVlFndXVicmVBRzU3MkZSclNwdE9hRDRUcmVS?=
 =?utf-8?B?TTJhY3FDcmlkbVlsMnBBQ2NlTkNqYU5EYngxdzJLbzNtL0h6M1BMem5sbUJT?=
 =?utf-8?B?RzZ4VSsvMmtCWEw5SEdZK3JyUTRWTDJycWRTZG9hN1ZvT1lLcjdtVU1ydFpq?=
 =?utf-8?B?clZaTUpCYTJ2RmU1Y2d2TjNaVVM1RTQ1WHJRS2pnWTVVMktRZW9uOHR3amhG?=
 =?utf-8?B?eVd0R2s5WDEreVVxZGZJYTlpQXdnbjNzcnk4VmhkS3owb2FvYkRiNEx6ZEln?=
 =?utf-8?B?OWhFRDdQZnU0c2xDc1FmZHNoWDBPcWl3UmM0UXV6QTF6cjcvajhoS1FyZXg3?=
 =?utf-8?Q?tHpEhbSE9xa2kfKYLbwWcLQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd25896e-7bc2-4c8f-298c-08d9e7fcd6d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 16:38:57.4778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jea6hMZ5ICF/sNvYuAhIbOuhOVbbagUcIcbLTLEBC8FIEqbNYMrbNAjJCC83z7fd70E1NHH6/7v1Qme7TUcXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2713
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

Hey Lijo,
I somehow missed to respond on this comment, pls find inline:

Regards
Shashank

On 1/22/2022 7:42 AM, Lazar, Lijo wrote:
> 
> 
> On 1/22/2022 2:04 AM, Sharma, Shashank wrote:
>>  From 899ec6060eb7d8a3d4d56ab439e4e6cdd74190a4 Mon Sep 17 00:00:00 2001
>> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> Date: Fri, 21 Jan 2022 14:19:42 +0530
>> Subject: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
>>
>> This patch adds a GPU reset handler for Navi ASIC family, which
>> typically dumps some of the registersand sends a trace event.
>>
>> V2: Accomodated call to work function to send uevent
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/nv.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c 
>> b/drivers/gpu/drm/amd/amdgpu/nv.c
>> index 01efda4398e5..ada35d4c5245 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>> @@ -528,10 +528,38 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>>       }
>>   }
>>
>> +static void amdgpu_reset_dumps(struct amdgpu_device *adev)
>> +{
>> +    int r = 0, i;
>> +
>> +    /* original raven doesn't have full asic reset */
>> +    if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
>> +        !(adev->apu_flags & AMD_APU_IS_RAVEN2))
>> +        return;
>> +    for (i = 0; i < adev->num_ip_blocks; i++) {
>> +        if (!adev->ip_blocks[i].status.valid)
>> +            continue;
>> +        if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
>> +            continue;
>> +        r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
>> +
>> +        if (r)
>> +            DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
>> +                    adev->ip_blocks[i].version->funcs->name, r);
>> +    }
>> +
>> +    /* Schedule work to send uevent */
>> +    if (!queue_work(system_unbound_wq, &adev->gpu_reset_work))
>> +        DRM_ERROR("failed to add GPU reset work\n");
>> +
>> +    dump_stack();
>> +}
>> +
>>   static int nv_asic_reset(struct amdgpu_device *adev)
>>   {
>>       int ret = 0;
>>
>> +    amdgpu_reset_dumps(adev);
> 
> Had a comment on this before. Now there are different reasons (or even 
> no reason like a precautionary reset) to perform reset. A user would be 
> interested in a trace only if the reason is valid.
> 
> To clarify on why a work shouldn't be scheduled on every reset, check 
> here -
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c#L2188 
In the example you pointed to, they have a criteria to decide what is a 
valid reset in their context, in the kernel side itself. So they can 
take a call if they want to do something about it or not.

But, in our case, we want to send the trace_event to user with some 
register values on every reset, and it is actually up to the profiling 
app to interpret (along with what it wants to call a GPU reset). So I 
don't think this is causing a considerable overhead.

- Shashank
> 
> 
> 
> Thanks,
> Lijo
> 
>>       switch (nv_asic_reset_method(adev)) {
>>       case AMD_RESET_METHOD_PCI:
>>           dev_info(adev->dev, "PCI reset\n");
