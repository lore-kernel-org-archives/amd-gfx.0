Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C07C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 12:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B4310E834;
	Thu, 10 Feb 2022 12:00:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A63310E834
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 12:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WB8gTGxcWVl3OKsfxySQsPypOawu8zXtYLRV8G+QQOx0Of2J2h6PMOVGWSYH9p5yJZGjoe3Vp6c9j81pVtW20ulZbSMHMsZRcm+VdkUgIqrlKxP7kfQqYkvSZGhoa6pQ/Q1kJSCBh6CJtZByMyotEayeatf+E4XfiDa0PRCHQcau6gHzDg4nVJd/NqXbK/C3G+rQPs0uMZy7a2HHdbMScjcdNr575RewyJBbHtUIEG/CivEmRfE126rXDRerOZMHURG5t4h64MdbvnF1KTK6KQaqPspaXXUNEMaGRjqiVSxAoQwByrOOJW8+xW1HCkhkSJoEuHCymM3KNsQA4CeIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XYx390MeXAgdsSAmvjVAc9rCP5cGC7FlwZTyB0fvpE=;
 b=M2IqGoMW/xpLlGx4v0IA0uGvWG8Xcmvb5wOgr2iQWfX6pWBR3k6b23F85dI8x+eKi7Ba97bZz/yLWpdlCVLMKe6I+cLYOwwO5uV5T2gRHjgelyaWBqzyXUC3cJBn8ZMSfdGlNH67qx4zM9WD7lSUJh4e53b2NtqdAMcYt0HNWG0llEl4jtdEiAtkEZp5pQZ00/C7f2Yq+7rZveRJ2WjDffPEx2poB8CxSM1I+vuDU49nf3wElN1rMlxQ4d2+MT47dxidvGu/bvy5/Dym5/S3faUOzuu9DAIa76E52rmrXePCuPEuEthCvcQ8BqaCOFdjCDQT5AkvIQ7/rMNMKQtxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XYx390MeXAgdsSAmvjVAc9rCP5cGC7FlwZTyB0fvpE=;
 b=Fn9x5FcNjg6LEkjf+4vteaPHCWc+n+YIi45HSI5upygJuwA1C0JVLDExny6D9Z1S8J+RfkT/8lhzN+W94viRU1DYuEn94XHKzf6F1QqLWImn/onj9R9+HqFnDvy/Xi6oN6U7F9+s17RZY8l0eHf45ODeM6pLRgcY3rY6+LA/mrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BN6PR1201MB0003.namprd12.prod.outlook.com (2603:10b6:404:b2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 12:00:04 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 12:00:04 +0000
Message-ID: <0f1bdc56-6ca3-d343-50de-9b54a39d39a9@amd.com>
Date: Thu, 10 Feb 2022 12:59:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add reset register trace function on GPU
 reset
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
 <20220208081647.3025-2-Amaranath.Somalapuram@amd.com>
 <CADnq5_Pun3UPKJsTKEf4pu3R=UbbHAZDW5-=+pekTDx4TWsAEw@mail.gmail.com>
 <6a7ca5ae-6d78-b8fd-cba8-cd2dca4418f4@amd.com>
 <49e24f9f-4657-d3ce-e84e-abbaa56d3181@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <49e24f9f-4657-d3ce-e84e-abbaa56d3181@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM7PR02CA0020.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::30) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faf7ac9e-bf6f-4b13-87dd-08d9ec8cdf88
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0003:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0003B63B9B62682A19C8F58FF22F9@BN6PR1201MB0003.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:312;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cI2ONbS+ctMPNaq3be22omtDYyj5l4Xp0ZFOaMYcYmRH0XH70XA7jJon5n4a4Ph4nODLQ6NXWT1VbwlkytWW5JxL9mdxBJrgyfKhW5jTpXrJd4K1rQmmmqkUk2vryvgELpTeg5Z46pkbbldwrNjCsSAyd1Kdi0qTVgNAJY9ZWsKiqVOySJO9iB0MMMd6bwNuA18sm84LfjRYslwvFPTIrEKAwSHpjhHGseiNl9yyhA6inLdh2unuAPLeOCL90IJxPht5O5HdDH4ih1+sj2pnS9JCDE6mfWQ4orMzsL61dqos5gxIau8a9Pq90ms/iP1CKy4c2r+Ptr7uGcq7b9nZh0ILNGhjrIaH4WpSyk6wxEnI6HqJHDqbc8e664Y/8tchkbm+UQN+wd9yUn7ZFOsRaFHMzGEnN1cL13QJQjTEPxUqqFwpfqFHpWmpgxX90rE+SInw868AtLCWdu4nfPUhO9NyTgmvErZEST2rfflW7bPqYto7GPOFO42k+QWnChDt/s0/LhyKUdHUJ8Flz9yJwXQdzGQplECNJhk1nH2auW6tMLUKoN2AYjzbmyA6fehxZl62cqNzmw2M83nr/NWsdO2DvWPtiazkwDZMhAkuVUmOiAyWYh/Nsb+iwp8XxLz0mKnTlktcNLsfpqw98XrTjSB3xMfCqLEPm3gLBrWPmPoSXNm/sWhTiMUkJ1jBm2zQLVuAFalntVQJ9aKRSkwxtl//WhW+C54Y8abSjhHw/sU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(186003)(38100700002)(53546011)(2616005)(2906002)(6506007)(316002)(66574015)(54906003)(86362001)(6636002)(110136005)(66946007)(66556008)(66476007)(4326008)(8676002)(5660300002)(31686004)(8936002)(6486002)(83380400001)(6512007)(6666004)(508600001)(36756003)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2dsVnQ5RVpIQy8rMHZPZDRpODFYdHgzVCthUlYrTHZMUyswNGtsWEJXN2VS?=
 =?utf-8?B?VnlsbzZBejVrWnZPOUoxdmxwYzVZME9XMWluVms3TzZvajBuRUMrMXIzSnRS?=
 =?utf-8?B?N0ZwdUg3bVpKL21xTk15bFVEcHNlRFNMdHRXZ2pWTHZhOSt2MWY0ZnFhOXNT?=
 =?utf-8?B?WUdFcEdHbklla2NoSHpwMXdmbmN0aEtidC93c3RzOUJaT3J3K3RnQ1JiNjBJ?=
 =?utf-8?B?MWVqcEpHNG9sUklqT3YyT3JvalRzN25GaUlpeVE4WnJVZjFlTjRIZTlNeEJW?=
 =?utf-8?B?UVp0eWhndjRYZlZCTEs4WkxNSVYvdzFUWDlNdGhRMmt1MWtCWlFLZ1dnR3d5?=
 =?utf-8?B?SjJOL1pkQU56RHYycWRCNFpMV3NuQUlLTUZHYk5LMGp6TGdtdEt4S3czNksy?=
 =?utf-8?B?Szd2MmExandwN2JlWk5SYTJSTHFXdjBrK3haSWx5d1JJcmlVajd6RzVGUVpk?=
 =?utf-8?B?RGxKYzhuYlRJN0Y5T1hJaGZNQkExb1MzM0o3RXZkSGdVOHFseHg3WHJsZzlz?=
 =?utf-8?B?T3RISzVoZmFvdXBPaHhxRDBKaGdKQ3Rmc0l0dlJoR0kyZkMrVGovM29rdWhN?=
 =?utf-8?B?ekRTcVFXeEpZUVBOYmhsS1ZPak5lSjdEWjdDMkJxVVdPQXFVek1ET2xVUjZm?=
 =?utf-8?B?dVRPMSttM0dicDVSdzdKckM1QUpGSFRrUTVaKzJ5RTY2WUpTTXMraitWdzBZ?=
 =?utf-8?B?ZExoOGNRdjBNb0xqZW5mZWI5T0lLTVR2ZzRJSXphWWJGUG9yOGQ1TUhkc29U?=
 =?utf-8?B?YmZWOFFQZVBUeEJscjU2Ny94bkdPVHlLM2RMQjJWZEhTbGd2UytucGxNTk1r?=
 =?utf-8?B?blh1KzBYdk5EODcwRHMyZTV2Vmx1VWhid05jbW14TFhBNllYemlUZWRSaWR6?=
 =?utf-8?B?RXNqcURSU0ovWWhMbnFleHRUNWwzUDBORmQyckFLNmtaL280LzBpbzhGRUpo?=
 =?utf-8?B?UFRsaFFPNnVpdmRvcXR3b09OY3pwTU9Eck5CMm9WMkFNNmVrK3dybHMra2Y3?=
 =?utf-8?B?bUIzTkFGeFh1SCtRQjNsYXJBK2pyZDhIOFlEaDRQeWtZdHNKRnRGQmVrbkpL?=
 =?utf-8?B?RE9qUEp0aHg0MmtvU2gyVUprdFl4TDJDRW52dHFvcHRKMEJncHhxLy81MkZC?=
 =?utf-8?B?aERrMGFRMVlQM2FLSjVhUXFpR1FWdmdWU1ZnaVVWTXFnUVNYMFRodUhob3c3?=
 =?utf-8?B?Rnk2SGppZWdFdUxQRGcxWmZlR2owNktTZ2hMYlhPVHd3YnZIVjNEZXpLaFgx?=
 =?utf-8?B?dzQ1Mk1TVXVzQnBmOWQrb0oyNG5iWUEwbkY0VzFyZFc5Ykc3a29GaWNqWVE0?=
 =?utf-8?B?dUFsT3ljVGxqcnFSL2l5QTZ6Q1QvL3haeExhTVFZQTZHUGx1czR1dVd4UWtB?=
 =?utf-8?B?bGFPb0p0RGIxaEJCTW9PRXlna1J6ekdpRmZ5Z29jbjRUeFZOTUhKK2ZCOUgx?=
 =?utf-8?B?VnN4SjN5S3NCbmhBNlJUc3NZYTAxWWoyamRudjZEUlkwaHFkSm5XZU9yZDE1?=
 =?utf-8?B?S1d1WmFWMTY2TlhjbnZsMUh6Smhxa2MyUFhSdVJtSk04SEtoNTVkZ25JMXBv?=
 =?utf-8?B?N2Q3Nm1vWndSQ0c1ank2YkdFazBiVnBUY3RadmZ2TmJuQnFmaVFkbFlPZGsx?=
 =?utf-8?B?cXczeEIwMkFaTk9QN2h0VUR5OHo2MzlhdDFXTlJPUklkY1UxUXRkeVZYZHlK?=
 =?utf-8?B?aDM0eERkVlFxVzVkYmpOMk43dmUrbXMrUHdSbUZCRURFb3RIU2lZY0JnaW96?=
 =?utf-8?B?aGVhMTVsMmtsTzBoMkhldHFnQ25lTU82QkdzaVFwVmF6QjlHemR6a0dNNWtx?=
 =?utf-8?B?aGdKRERzelJ5WEhBNDRaSHpnYk9hamMyZ2RnZlJ2aHNVS0d3dkJiY2tvRFpa?=
 =?utf-8?B?UTJRMWtsT250VWdsWFBJOGJQYzNMZkMvZHBPSDdSUk42OEpRNk83TzBKUXI3?=
 =?utf-8?B?dk5zUU92bWVNTnhVQWJoUTI0cDJ2SXJMR2hkUFYwaEZkcXZ3WDhiMWNiRDlW?=
 =?utf-8?B?SVNJOUZHckQ3eWJJaTFQUm9nb2RJaW1neEYxamtEaVpjSmtQbUh2SUV0VjRB?=
 =?utf-8?B?UGhnUit1Ujh4NVpuUWpxdUdQbGJ6VHNMYWEvWFA1RTNMTnVpWU1pS2VyQzBm?=
 =?utf-8?B?L3p1dXlSMWFOaThQM2VEMFkzTnJGRDlCSEpPUy9hVHdiVEgvNXVIRzYvOG5n?=
 =?utf-8?Q?bpmO3K8KBXSqmV6AENFgBw8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf7ac9e-bf6f-4b13-87dd-08d9ec8cdf88
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 12:00:04.1542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5o79jVn9T3/wquMyu3QnfD3Yzvw2PjOnCJYUd89+CXbfkx2+VUrsjyUOTTBsbV4i+kZT8pAlzOwkjkd+2RRWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0003
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/10/2022 6:29 AM, Somalapuram, Amaranath wrote:
> 
> On 2/9/2022 1:17 PM, Christian König wrote:
>> Am 08.02.22 um 16:28 schrieb Alex Deucher:
>>> On Tue, Feb 8, 2022 at 3:17 AM Somalapuram Amaranath
>>> <Amaranath.Somalapuram@amd.com> wrote:
>>>> Dump the list of register values to trace event on GPU reset.
>>>>
>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 ++++++++++++++++++++-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 19 +++++++++++++++++++
>>>>   2 files changed, 39 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 1e651b959141..057922fb7e37 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -4534,6 +4534,23 @@ int amdgpu_device_pre_asic_reset(struct 
>>>> amdgpu_device *adev,
>>>>          return r;
>>>>   }
>>>>
>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>> +{
>>>> +       int i;
>>>> +       uint32_t reg_value[128];
>>>> +
>>>> +       for (i = 0; adev->reset_dump_reg_list[i] != 0; i++) {
>>>> +               if (adev->asic_type >= CHIP_NAVI10)
>>> This check should be against CHIP_VEGA10.  Also, this only allows for
>>> GC registers.  If we wanted to dump other registers, we'd need a
>>> different macro.  Might be better to just use RREG32 here for
>>> everything and then encode the full offset using
>>> SOC15_REG_ENTRY_OFFSET() or a similar macro.  Also, we need to think
>>> about how to handle gfxoff in this case.  gfxoff needs to be disabled
>>> or we'll hang the chip if we try and read GC or SDMA registers via
>>> MMIO which will adversely affect the hang signature.
>>
>> Well this should execute right before a GPU reset, so I think it 
>> shouldn't matter if we hang the chip or not as long as the read comes 
>> back correctly (I remember a very long UVD debug session because of 
>> this).
>>
>> But in general I agree, we should just use RREG32() here and always 
>> encode the full register offset.
>>
>> Regards,
>> Christian.
>>
> Can I use something like this:
> 
> +                       reg_value[i] = 
> RREG32((adev->reg_offset[adev->reset_dump_reg_list[i][0]]
> + [adev->reset_dump_reg_list[i][1]]
> + [adev->reset_dump_reg_list[i][2]])
> +                                 + adev->reset_dump_reg_list[i][3]);
> 
> ip --> adev->reset_dump_reg_list[i][0]
> 
> inst --> adev->reset_dump_reg_list[i][1]
> 
> BASE_IDX--> adev->reset_dump_reg_list[i][2]
> 
> reg --> adev->reset_dump_reg_list[i][3]
> 
> which requires 4 values in user space for each register.
> 
> using any existing macro like RREG32_SOC15** will not be able to pass 
> proper argument from user space (like ip##_HWIP or reg##_BASE_IDX)
> 


Why cant we use just a simple array
adev->reset_dump_reg_list[10] for both ip and reg offsets ?

Userspace can provide the IP engine enum in first entry of the array,
reset_dump_reg_list[0], and register offsets in other entries starting 
from 1. We can convert that into desirable engine substring using an 
array of char *, something like:

const char *ip_engine_name_substing[] = {
	/* Same order as enum amd_hw_ip_block_type */
	"GC", "HDP", ......
}

engine enum;
u32 ip = adev->reset_dump_reg_list[0];
const char *ip_name = ip_engine_name_subs[ip];

for (i = 0; i < 9; i++) {
	reg_val = RREG_SOC15_IP(ip_name, reset_dump_reg_list[i+1]);
}

- Shashank

>>
>>>
>>> Alex
>>>
>>>> +                       reg_value[i] = RREG32_SOC15_IP(GC, 
>>>> adev->reset_dump_reg_list[i]);
>>>> +               else
>>>> +                       reg_value[i] = 
>>>> RREG32(adev->reset_dump_reg_list[i]);
>>>> +       }
>>>> +
>>>> + trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list, reg_value, 
>>>> i);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>                           struct amdgpu_reset_context *reset_context)
>>>>   {
>>>> @@ -4567,8 +4584,10 @@ int amdgpu_do_asic_reset(struct list_head 
>>>> *device_list_handle,
>>>> tmp_adev->gmc.xgmi.pending_reset = false;
>>>>                                  if (!queue_work(system_unbound_wq, 
>>>> &tmp_adev->xgmi_reset_work))
>>>>                                          r = -EALREADY;
>>>> -                       } else
>>>> +                       } else {
>>>> + amdgpu_reset_reg_dumps(tmp_adev);
>>>>                                  r = amdgpu_asic_reset(tmp_adev);
>>>> +                       }
>>>>
>>>>                          if (r) {
>>>>                                  dev_err(tmp_adev->dev, "ASIC reset 
>>>> failed with error, %d for drm dev, %s",
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>> index d855cb53c7e0..3fe33de3564a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>> @@ -537,6 +537,25 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>>>>                        __entry->seqno)
>>>>   );
>>>>
>>>> +TRACE_EVENT(amdgpu_reset_reg_dumps,
>>>> +           TP_PROTO(long *address, uint32_t *value, int length),
>>>> +           TP_ARGS(address, value, length),
>>>> +           TP_STRUCT__entry(
>>>> +                            __array(long, address, 128)
>>>> +                            __array(uint32_t, value, 128)
>>>> +                            __field(int, len)
>>>> +                            ),
>>>> +           TP_fast_assign(
>>>> +                          memcpy(__entry->address, address, 128);
>>>> +                          memcpy(__entry->value,  value, 128);
>>>> +                          __entry->len = length;
>>>> +                          ),
>>>> +           TP_printk("amdgpu register dump offset: %s value: %s ",
>>>> +                     __print_array(__entry->address, __entry->len, 8),
>>>> +                     __print_array(__entry->value, __entry->len, 8)
>>>> +                    )
>>>> +);
>>>> +
>>>>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>>   #endif
>>>>
>>>> -- 
>>>> 2.25.1
>>>>
>>
