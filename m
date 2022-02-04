Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C607AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 16:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 169BC10E55B;
	Fri,  4 Feb 2022 16:59:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3AAB10E55B
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 16:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sjl1P6qYFmEbK7imSoEvdH86Kp3Sc8KfNAsfskivo4DV12pQz+f8nHOpEF3GLpqWrWhKem0sFPdOoLua4WwGPAvPV4hhOSfBayheEUVLBl9nFpXD62qhY/+2BuBT4xoHsQSlqVIh0uHyEhly+CHa5QVrIrX9gbjbzolLHkiuNIt/1Mb426n9TX80LDXcmheckrQosbysz1U6p5EmowaxA4HaqIdEFiNsjopiopc/5tNO1dsn0eNc9OjWzg6KMCacatj/Ur+h+otiRRNBjgBPiMVhZhNUp60dS9PIKkvxuZnbbsyS6pi4q8hiXr1iayBeVQyFYZaZuy+Lahluy55T1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsNneXSdfBP3wJBYtJrQbrDdbRkeIsohSdCWd8PsqJI=;
 b=EkLbhP1hiVzl6UCrvPP3hqCXhhDdjoSezDPM4uQXnE+HegeMJ/QHY1i4WL1z0cDynyN4LCo4c6LkSsy/F65vm6sU/fd7UH0X4MRg+FcDSR2Q7JEl/KN0LoI/J2qEl7SgPFVj5tWoFxVW3+8Q7tuofZz5wHDo6JTyqyB32TMgW4zq2qU7H0tDnsQnAlnOFukq3KSgTqM9qcTSgsTLRN9MyvBfYsBdLx8JeN01TndGMW69HgR6i1ToCqIUoNGLyNoFf3HbwBg1zeDOrC7GDJuKXdhG9LS62WrSRLqbeggpcNem8+O+O4OlhOWahlDjr5Ef/1/y3YReAnvh9hawKiwqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsNneXSdfBP3wJBYtJrQbrDdbRkeIsohSdCWd8PsqJI=;
 b=zqUeF4f+rguY5FRNtvyYHAlSHE3uYDe60ZTiuPfTFYkbZWV4BYWuXhlBjRvHs2Ps4L9b0oaRyri9v8MeZDNkK9cGmcpQR9bavn/xaubM/UywP8cDy9oKqzOdchgNaitt3H+Ztt+puJ967uRXPN+L/0g1ZC/aNbFxybh/OS4R0Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CY4PR12MB1703.namprd12.prod.outlook.com (2603:10b6:903:122::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Fri, 4 Feb
 2022 16:59:07 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 16:59:07 +0000
Message-ID: <8bada9e4-d6d5-e11a-45fe-aea7615f3356@amd.com>
Date: Fri, 4 Feb 2022 17:59:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Content-Language: en-US
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
 <a0693436-619c-efa1-b3f1-2fca6377e2fe@amd.com>
 <817df2c3-e7af-92cb-53f8-8bc70b69b988@amd.com>
 <BYAPR12MB46149A07EB030CB27FDA8B1397299@BYAPR12MB4614.namprd12.prod.outlook.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <BYAPR12MB46149A07EB030CB27FDA8B1397299@BYAPR12MB4614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0071.eurprd06.prod.outlook.com
 (2603:10a6:20b:464::22) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b123d39c-890b-44a0-55ec-08d9e7ffa834
X-MS-TrafficTypeDiagnostic: CY4PR12MB1703:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB17038D312F13A013A1D41DF1F2299@CY4PR12MB1703.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nl9yNsM9RxS1r/UgRoDuIVj/BduJw+ojp8+e8ZjRCJhmt2LVgSuPkBe8OgvSpuNfsWFdhXWYNrP6VuicPJ9mlUXB0CtnetuLaWNQHmF5qKOS0sHHERCf8EM3o9XN1sp8RDxdrT9VNHAHDL7/NlTDWn1Nilno3LEBZMU3e3x5DMzjsGf/67N+b1b2RvuNQ0pqkeccyd1BL1+U0+tzvYQchl1ztXSx3Gzes2gA640+Oc9QvXNCTYmn6F2ge3xx7rAKNUT/mh5vuw9xdPqznHpnl5WeZnz7qFqyEaI67ghIU1M1d1sF1eliPyqiIJYtZX+KHEPpwhDfuZwFApTn88D1egQx+mz47E5H1WgnolCmPWqnAKtWyipuLK9hUj8tA++k4eQfC2qEPI5UZXoPziXLyUoRWV10OCD4q/9t5GS27krQxcUaq/vJTjW0AYWhRvrV7Fdl+Mih8LFfMz6VHImkLMFefwoJVZ3fvHhZ4Q30w7IKWSReOnHnnfLjIYDiCIMVdreubaJ9vRTHpxCH+lpVrHq5LKVrp6X1/g21y1J7a5Qr7rwFjUGGUbFvp/UPeN9d29mClm4+irhxVtDKh1PyqsppSX4RtxSuUQVJMbbOjW6eleyy8mTKn913Hl5EV6P/lxvhrdFOBqQF8uqMI+/hPTEiil+UlPRvdcf8VqajKHO9XGqHpCt/J1tihj44Co4nFKkbJMulXNeXc8JBDfo8yJZWRhwI9hKXx4L6SjX/S0FWi623T67pz7optkGXTVGswK5J0FiNPBrv8pn3B+oIixp2ImBrudnbBh3cQWIycVDXbgcINjSatpesSNPrnrPx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(8936002)(4326008)(6666004)(38100700002)(53546011)(31686004)(66476007)(66946007)(6506007)(66556008)(2906002)(83380400001)(6486002)(966005)(26005)(508600001)(186003)(36756003)(5660300002)(31696002)(6512007)(316002)(86362001)(110136005)(54906003)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2JiOTdvUGZhN3VpSllqN0hvUTNXaG5memVRU0xuRkszdG9TdVloVkNDdVpZ?=
 =?utf-8?B?RjdHYVFMVkt6VTJicnRheWtKM0N4eVhGOEoxRjJlUGZDdTRENlRHYVJGUzdo?=
 =?utf-8?B?TStoUmVaaHl1SFhSV0NRa3dXLzJ2TEtpcXl6SzZsWFliYUhnWEpsZ0V2ZmZn?=
 =?utf-8?B?UE1QUEc1Qk1zTWNRWVlJUVptUmV0RlI1elYwNzUvdWU4Tjc2Qm1TK3FqUHZU?=
 =?utf-8?B?MkEyL205aUFNWktGYzRDWmVqeUJNNjA3bUpIdlAyd2pQTGl4NnVnMWpUUXlz?=
 =?utf-8?B?WkRkVmJjcmNJU0VtSnorWktVempFcmJ1djFyUGkvWmNwRG93NlBqcTAvN010?=
 =?utf-8?B?N1dRV044Y3ZLRmJWZTloeHZka0k3b1U2WGNta0hyREs0RjkvR01hK0xVWDhN?=
 =?utf-8?B?ejUvbWVXanU2Z3BNN3JQeWF6Z01WODBHK2h0WEF4U2N5VDlSNjFUSFNwcXpH?=
 =?utf-8?B?T05UWUllZFExczhUclVJN1JGTGhTK3V0WUtqNHB4S3RDNHI3dUtuc25tbDVD?=
 =?utf-8?B?a0lNcmJKL3JDMUc3UEdaMkloSkc5QnMreWM0N2NFbWZFRW1qdzVzQi8rWnVS?=
 =?utf-8?B?c1QzWGVuM2t6bmRvaTVrMlltNWZpV3E4eExnc1BtcEY2YUlvRGNYRXRUdXRX?=
 =?utf-8?B?enJLenljaUpnOEdpcGhCL1B0Zmx2VllVOWIzeFVHWHZpV3AvRG03UE11aXc2?=
 =?utf-8?B?SXB3UWc4R3lNcDREMGxaQ1ZTU3Z6NU1xUzdkYTZGVFRzVlRha1EwVkZ4NGsv?=
 =?utf-8?B?MnpJUkhyNC9McTAvUEIwNzR5S3dka2RyVUJBa2ZnZWxVQUc2NmFzVGx2MzNx?=
 =?utf-8?B?K0x4dU1FSWVtZWJhdDJSNG93WFFJTjdtN3pmR0hoSWJ5QWMvV0lIaWpGM1Jj?=
 =?utf-8?B?aVV0eUUzRTRRd1NqeTB4NXphaVIyc0lxOHg4UWZySlp1VUV1WVVuUzNHWm8r?=
 =?utf-8?B?SkszcE1FNit0YVlVMmp1aVFJK3RTd3dQd0s5OVVNRDZaMFR5dURhTFJ6MHJz?=
 =?utf-8?B?ZXFXdE9ZbXdzbXNySWQ4R014T24vdEw4NnMrNWlCcUNyWXErRkxzb09RYzBj?=
 =?utf-8?B?TnlzcEoxOC9kSzNqTlp6Mk9ieCs1SHBQTjBDaXRvZ3VsS1dMdVZYV1EwcmZR?=
 =?utf-8?B?YU5mU01HZDBEMGVsNEpib3ZMMStyY3VPZG85MWlCek1EVEprNHp2OXJaL1dJ?=
 =?utf-8?B?V1VwcTZ5clh4Wm5lckw2ZE1iRENPdEFnRi9sdnlSQTF2WXNST0kwRndIcG5G?=
 =?utf-8?B?K1cvanhvTk1wRHBuanNERmRnSmFOc21GNm1zcldsRG0rRjBEcFRZVDlVMGYx?=
 =?utf-8?B?M0dSTldKSFdFcFlWT0k5K0xmWUVNWjF5aFNtdG5KVDJLa0R6WDRhTSswanho?=
 =?utf-8?B?Q1JGOEZ3OE52YWNlSjRvNmRQWXFCN3d4VURUblhqVDBuRnZ4VDJ1cXhDaSt2?=
 =?utf-8?B?TXNySG1RYzBnc0RTT1grSkQ3ampYa0dheVZIZjVUdlNWdjNjZlVVd0Ztd1VX?=
 =?utf-8?B?alo4aU9kT3FYN0huM2YzdUxVR0hsSHFnWWhReFVRODNNNWo0T2l5ZS9tcGFC?=
 =?utf-8?B?M1FQaG05OUtmOU1RK2thdm8rZm85b01UK3pQZG1LS0NNK3hiS1pvcC9iZnI0?=
 =?utf-8?B?NDZFaW1uWkp4eTNSZWFZZWZHbXdlZzF4MXJEREtsNDBscFp0MXZQclhudmta?=
 =?utf-8?B?TW9xNjhCaDdpemNlRXdwRTVmMERuUUQzK1hoSEdHODFQTXJZZExvMHd6SG1D?=
 =?utf-8?B?VFdtbncxRStWV2krQ1hhcm5xdHdEcHBzM2lpcXVoaG5SQ2h1ZzJDL3FLYVh4?=
 =?utf-8?B?cllyMnYwU3dOTU5GWkVoSzRzYXBTeDd2c0lBUjRPZHF1NzhwdUxNZlRKNVBs?=
 =?utf-8?B?andEd1lyVEJQTi9sVE9rNWNIZG51M0ZVMDRWY0pRRlFrbjRVVUJhamNUSEta?=
 =?utf-8?B?NjB6dGd1V3FOeEdEM0tJUkNmOWxJcTNlZXFCM1hOTkZ3cWE3VFU4U3BFemNa?=
 =?utf-8?B?WkNOV3lEZ1NBdk52T2RwVzFmd0hVTFZRMjY3Z09BalRtYjVmL0E3MVpOdTNW?=
 =?utf-8?B?T1NyTy9SeWFVS2tZaHluNVZXbjhCcDJMemNHVjBENXRKY0tGbjhaSGQ1dUJh?=
 =?utf-8?B?NU5LZWtadkZKYzJxSVhJRkNnbUM4L2RCY0cyYnl5QXFuY0wxZU5IdmRWSmQr?=
 =?utf-8?Q?uxeAIroEYZxVrZRNLCkoKds=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b123d39c-890b-44a0-55ec-08d9e7ffa834
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 16:59:07.6501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PREUxF0UaM+ebsZKbpoBJCOThxxrP8N835B2ngvVfukUSbJSyLwpx+Ph+GWnAHodX66/NDm2avyK6zvzKHlw2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1703
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/4/2022 5:50 PM, Lazar, Lijo wrote:
> [AMD Official Use Only]
> 
> To explain more -
> 	It's an unconditional reset done by the kernel on every suspend (S3/S4). In such a case which process is going to receive the trace events?
> 
> Most likely use case would be related to gpu recovery. Triggering a trace on every reset doesn't look like a good idea.
>

If you observer carefully, we are just providing an infrastructure, the 
application's intention is unknown to us. In my opinion it's rather not 
a good idea to apply a filter in kernel, with our interpretation of 
intention.

For example if an app just wants to count how many resets are happening 
due to S3/S4 transition, this infra might become useless. It would 
rather be a better idea for the app to learn and ignore these scenarios 
which it is not interested in.

This could eventually be just difference in design philosophy maybe :)

- Shashank

> Thanks,
> Lijo
> 
> -----Original Message-----
> From: Sharma, Shashank <Shashank.Sharma@amd.com>
> Sent: Friday, February 4, 2022 10:09 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
> 
> Hey Lijo,
> I somehow missed to respond on this comment, pls find inline:
> 
> Regards
> Shashank
> 
> On 1/22/2022 7:42 AM, Lazar, Lijo wrote:
>>
>>
>> On 1/22/2022 2:04 AM, Sharma, Shashank wrote:
>>>   From 899ec6060eb7d8a3d4d56ab439e4e6cdd74190a4 Mon Sep 17 00:00:00
>>> 2001
>>> From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> Date: Fri, 21 Jan 2022 14:19:42 +0530
>>> Subject: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
>>>
>>> This patch adds a GPU reset handler for Navi ASIC family, which
>>> typically dumps some of the registersand sends a trace event.
>>>
>>> V2: Accomodated call to work function to send uevent
>>>
>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/nv.c | 28 ++++++++++++++++++++++++++++
>>>    1 file changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
>>> b/drivers/gpu/drm/amd/amdgpu/nv.c index 01efda4398e5..ada35d4c5245
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>> @@ -528,10 +528,38 @@ nv_asic_reset_method(struct amdgpu_device
>>> *adev)
>>>        }
>>>    }
>>>
>>> +static void amdgpu_reset_dumps(struct amdgpu_device *adev) {
>>> +    int r = 0, i;
>>> +
>>> +    /* original raven doesn't have full asic reset */
>>> +    if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
>>> +        !(adev->apu_flags & AMD_APU_IS_RAVEN2))
>>> +        return;
>>> +    for (i = 0; i < adev->num_ip_blocks; i++) {
>>> +        if (!adev->ip_blocks[i].status.valid)
>>> +            continue;
>>> +        if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
>>> +            continue;
>>> +        r =
>>> +adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
>>> +
>>> +        if (r)
>>> +            DRM_ERROR("reset_reg_dumps of IP block <%s> failed
>>> +%d\n",
>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>> +    }
>>> +
>>> +    /* Schedule work to send uevent */
>>> +    if (!queue_work(system_unbound_wq, &adev->gpu_reset_work))
>>> +        DRM_ERROR("failed to add GPU reset work\n");
>>> +
>>> +    dump_stack();
>>> +}
>>> +
>>>    static int nv_asic_reset(struct amdgpu_device *adev)
>>>    {
>>>        int ret = 0;
>>>
>>> +    amdgpu_reset_dumps(adev);
>>
>> Had a comment on this before. Now there are different reasons (or even
>> no reason like a precautionary reset) to perform reset. A user would
>> be interested in a trace only if the reason is valid.
>>
>> To clarify on why a work shouldn't be scheduled on every reset, check
>> here -
>>
>> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amd
>> gpu/amdgpu_drv.c#L2188
> In the example you pointed to, they have a criteria to decide what is a valid reset in their context, in the kernel side itself. So they can take a call if they want to do something about it or not.
> 
> But, in our case, we want to send the trace_event to user with some register values on every reset, and it is actually up to the profiling app to interpret (along with what it wants to call a GPU reset). So I don't think this is causing a considerable overhead.
> 
> - Shashank
>>
>>
>>
>> Thanks,
>> Lijo
>>
>>>        switch (nv_asic_reset_method(adev)) {
>>>        case AMD_RESET_METHOD_PCI:
>>>            dev_info(adev->dev, "PCI reset\n");
