Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB496CD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 09:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66FB610F461;
	Fri, 26 Jun 2026 09:44:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="se2ysj8n";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010008.outbound.protection.outlook.com
 [52.101.193.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D7BC10F461
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 09:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taCEbUUpXGcv++8rTqgKTAb62sVHRlaj9ZlGFoZtoKzPSmpJxCAQJMiFurBHZ9nlRCYIzZMLFHrsImPXTotwoPs32GPfTD4sehVBtamqMab3b1z0oM+HkFpQMC1kZrowDLfgu3/ND+WK1aUrXCehM6NYxZHwR1J0b8dvyLLm5/E6mnic2qj+UmGec7NyknPJy7kLhyxs/YsY5xxm/J3VEvgzxgd37G3IFUEeR3cm4T9jzAZGz5mpRrKZtIC1yQw00oajDWg3gbSs7fnRypDFRjuWh1n2s4NEqir9f3M6wIdktZi3Rzg+w0LeDV5oF6t3MFuPptAp5a7pyveR9l5n2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/9Nr3T+GJQR4WECtMmEvT6dWrtagEoqhK4CQUMbESg=;
 b=YuzzVnELJ9xQRnXpyh2T5KFrzAWNoNW7d20sSY2W1vzlaKV2atT8UVUxi20Wi4UADSZxVzSgne8xJASNOuta716we3BRkt9QXuvL4nP1haHQ9v0mQFk+xF2oicM94M1Muk6AyBriXo+I9zPcKTUcRAGKz0icFug3FymjHdxAU3sFCDE2uKsOOtQ1qOFJdGtuwNGkgiZg15KkD5PbzufypKcOnyxff2mSD6deEahz8akX9XRwsURlC2WDQ6TpQIKskqqzLwtn7CzHvI5iomIvq5rwH50l7AAPcODpT11KL6DM+uS9B554hi68JQ9U+ndZ9EVSTHuCeTLJYyNXsWSC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/9Nr3T+GJQR4WECtMmEvT6dWrtagEoqhK4CQUMbESg=;
 b=se2ysj8nFEQd6yXHWDO/3RnMRJyBqB3W1x5JQQjwi/H8FvjROehsiMH17fG69Z1rbHM2BL4M2fed/Ehy6X1v3iDsxjnRMQR3PMdki2q7dIKdV2hU0565a7MAsDIs+2zkSuvax06hSE5f5otRl2ddJaHM9S6OdfkNvF5uxa3Nt1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by CH3PR12MB9124.namprd12.prod.outlook.com (2603:10b6:610:1a7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 09:44:13 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%3]) with mapi id 15.21.0159.012; Fri, 26 Jun 2026
 09:44:13 +0000
Message-ID: <a518c22d-35c0-4e05-98b1-de95d8f31fa2@amd.com>
Date: Fri, 26 Jun 2026 15:14:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amdgpu/ras: Resum RAS IP hw init during nps
 dynamic switch
To: "Yang, Stanley" <Stanley.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260626071752.192163-1-Stanley.Yang@amd.com>
 <d06a5c88-63cb-491f-8090-6df38325acdb@amd.com>
 <DS7PR12MB832415758449F9B1FE398BD59AEB2@DS7PR12MB8324.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DS7PR12MB832415758449F9B1FE398BD59AEB2@DS7PR12MB8324.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::11) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|CH3PR12MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d0ca04-7bc2-4ee5-3a91-08ded3677b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|3023799007|56012099006|11063799006|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: a0+GoZAnXk1uVvewrUy4XiQvT/qS63k16CQ5RVrRfe4SGwAEh6J6d6xF4szcXm+rAWo9X4vcMuOflP3pTlH6Y57RZr9xMVtaEp5oD68Ev4q+LphdU6KFH5li9g5MRYnl0Ktiq2S8wtkTAb3zuxEDKRH6BFrJG8z55enWr5sAK8dpCmXF2IKYizDOm5Rd5mjv3f2BCC404W8fRO7jSi+VRvWptPg07UUcgk+twhUCtQsVBxd82cc85h/6o6Dtv0/JtjGv3NaPhg2+8V6PkE29n4BnPbhxOgzISaqImqAs4geQSfR+B3S7w1i3Y5+b8otjODEdrBXhzU9in4ZlQ4EeJBOI9dx01hTc28dMO5THLCbMTERzRACdDbFtGLYiNQpD489T4gv4uioJSMgh44gX9+8+UAOi0Bc1XnbZY86OxCz4vhkA25G8c3f/3Rso8O4ZQE7M23HpknssX+OiZkRzksU97ZQ8pw9g/zArXzSGWcRlnAPJN788k9B2Ak4trH+MvFr0K+lX/Iuh+Aw/VS2+xGKxDrTXLnnOK1WJea89ELOMlcfBjEj5KeEZj4QRcd18W5Gyr0GwZfyk50TGYeKpSYU8xiLQy0Ajp4lyzKx6qtNRBiM6a8qbAihJBEynRTqhPY4n5S0VVF9QxGMeQlFG9RQM0y253fSVbm4JfwA8M2w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(3023799007)(56012099006)(11063799006)(6133799003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YldmNmovdXJsc2g3eGFCbW05c28xY1h0SUhmRHpMTkhFZUpEMTAyOUt3RzVi?=
 =?utf-8?B?NjF3dzFTbG1YY1cwNFowbFNSdk9iU1pIZFJqdlNsUnVBS3N4dGVERy9YRk83?=
 =?utf-8?B?MkFkbExaTUhsa0lvdE9va3hBUC90WkYzMXByOVNzLzh6VFhmMkdEVkdwSGlU?=
 =?utf-8?B?ZjZTRjhGaUl6emFIRFlhT1NDWFpwYzIrNFdKQUZ6YkpZL2ZuTVdiVXd5Z1Fj?=
 =?utf-8?B?WTdMUFk4TGY3U1BucFFRRUFoTTJlVnBqV0RzZEw2QS9wMTJmcmtmRzUwODc5?=
 =?utf-8?B?T2poTzhLaGxJQ21DelAzUHFpVi82SCsxSHZIUkRNR1JXNHRLNFJ5RTZmTzBu?=
 =?utf-8?B?dlJVeW1XRGpzNU9NeFNNYk8vbm1qMjJkTWRGMDZBMkJvVXN3c0UydmdtZ1Bx?=
 =?utf-8?B?d2I4TWc2Uk1waENSWkNvUENiY1YvMXVkR1Vjckw1N016cVpBVmxxN2VtUVRk?=
 =?utf-8?B?M1FLd0FXS1psUFhvQkk5cThtSExkVE0wM3ltUlZkZEtqTzI1S21xWk03a0N2?=
 =?utf-8?B?NE81Y2JrQ2JsMisrQnU2aWdMdFRSc2tQRmtjOVRkVXN6cGpNZzdHaU0wTFRU?=
 =?utf-8?B?OTNkbVNFQUFqdTdDZVM0dEVxelFsWW9ib3k4M3VJZ01vMVpmUjIvVHRiVUVX?=
 =?utf-8?B?UEZzOXQra0IxdE9TSmplc05NS1hSZld1NnVYSWQ2dkwvZy9SL0t4YVFHSU5O?=
 =?utf-8?B?UlpUcUxaemRyeWxwRnIwVXJBWU5nYnF3QXByRFNUc29uUW9wNW5BcnBsaldi?=
 =?utf-8?B?dGxMeTJvZlhSRHBFb0YybjE4ZFNDOTZZRDBNY01teTFKV1RRVzFCVTRyUzVG?=
 =?utf-8?B?b09LV0JSbnRJMkZlYzNKSzlNRG5Ma2twemVKMktIbUNrOWQ0ZFhCMnB5TC9r?=
 =?utf-8?B?RFFXdmZUajBkdTFLbFVoamFoc2w4dnBYaFFEK0ZVaFJlVHJkTWZZVjlRRG9k?=
 =?utf-8?B?SGpNbHFBUXEzdXBVV1dDQkVDWUF4VzdkNTJNWUNoV21wSW5IM2VKMmVUaTMr?=
 =?utf-8?B?ek42dkVsd3FDNmhaYmtaQXd5QzIrOWNvMXNMam1vU1dsNndIVDZJTlQvZzRi?=
 =?utf-8?B?MEVZMGZja0EySnFzSEI0UGZyV0VvYWtCME1ycnhSakQvUmZadVQ4ciszNk8z?=
 =?utf-8?B?MTBRWCtFWmtuZ3l2ZW81NTRhQmsyRkdDUDVPQTlJNzI0bkhQZ2hadllwTEpQ?=
 =?utf-8?B?YzFTODQrcG5kaTdRdWp2Q0lNN2RRdnhNQmgvL3ZRU3FnYVFNK0Vqek05ZUVu?=
 =?utf-8?B?cWdodytwR1U1WFMwUXFUamxHTkJkNU9xNlY4V0U5QWRlZjM2Z0xxczBML2E1?=
 =?utf-8?B?UVY4UjRFcldkQVJGUm9laGlydkFmeFhKWFczOWsrM2d3TEcrWWNPWnhVbGk4?=
 =?utf-8?B?bGR5UmZ2cVJGM0hPdDRWWEdXZU9GOWpaNm1XSG5CNUtvNWZ5QXlaa3FGc1Q5?=
 =?utf-8?B?UncrVlh4NTZWa0tucEk3blN5ZzNsQnJTVGtDaTNBQWtVWHJXdGtrR1ZSM3NW?=
 =?utf-8?B?ZXJwbGRVN2ZuSW5XdmYrcXJ6elFHc3hNUlNSOHpRdHFVZXpwalA1Z1M0UklZ?=
 =?utf-8?B?RXZCcHpSZGtjTEQ2dktTeVJrcThHY2pPa2EwM3l0RzBuY0prdURhMXNCeUJC?=
 =?utf-8?B?R1FldDU4d05WMklKbFdtQy84WXNjbk8xM25mdXM1QlkzdEd6Zi9PbHkrUkpz?=
 =?utf-8?B?U2taclQvN3RiNW1HcGVIMXRWM1VNQWFKeGx5V091eHIrQ1FyL3Z3WkJUb1RX?=
 =?utf-8?B?cUc4eTE1bDRMZ2p4UTczVzZTRzh2QjVpMStaanhiSlhjaGhidnlqZkNSQ1lZ?=
 =?utf-8?B?QWFtRGxqMFZrd1c4OW11Y3VTamtVVDQvS3gyLytQMHUrQXQxaWg3RzN2N2xM?=
 =?utf-8?B?bXBTUDI5TEIyU2s0dkRHczNZMlRBWkxRVGpuWnUyTTBvNzZOUDNBeU0xanhG?=
 =?utf-8?B?ZktpR0F6Z1QrNTQrWlRaMUNCSkptNHVCazM4YWhYRkt3cjJqWThuV0FUUysr?=
 =?utf-8?B?SGZGcnhCWEQ3WW4wcGh2VkxQMi8vRUlaUlNiM3pveTZOZzJuOG1HWlR2QmNq?=
 =?utf-8?B?NVU3dzRudkdrdEdjS3RxbVdSMWJoRWlQSjdmZFhsaWhzeit2SjcyVVR1anFV?=
 =?utf-8?B?NGttaWFqa3p4QStzS2xkb2V6Qm5HMyt5L1ozcGxGN3ExaDQ0VGhSb0tqNkEy?=
 =?utf-8?B?WHZWWDRHZ0FZdWpCTEhPeEtFVzVudk1lMWUwQnZBeUhKVUhYR3JNSExlTi8r?=
 =?utf-8?B?SW9Tdm9TYnFDSXBKLytvRzhTbWl3ZEprUzh0NGxhZXhMZXJ3YWNKZkVSUmNh?=
 =?utf-8?B?azh5MUFCdE0zWUJQR0xVY1RuMTh4ZG1NSDNlcWJmNUhLb2J2cFVQZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d0ca04-7bc2-4ee5-3a91-08ded3677b37
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 09:44:13.6988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liB/VVcBM8THvq3n20lgXl8fdDeHpkt83wJag9lwk2e3XtlSGaW/oejchyhvAST6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9124
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



On 26-Jun-26 2:04 PM, Yang, Stanley wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, June 26, 2026 4:16 PM
>> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 1/1] drm/amdgpu/ras: Resum RAS IP hw init during nps
>> dynamic switch
>>
>>
>>
>> On 26-Jun-26 12:47 PM, Stanley.Yang wrote:
>>> On an XGMI reset-on-init (NPS memory patition mode swith), RAS IP hw
>>> fini, sw fini is called but hw init is skipped due to RAS IP block is
>>> not included in hwinit mask, so need call RAS IP hw init during XGMI
>>> reset-on-init.
>>>
>>
>> After reset, we set it to default level.
>>
>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdg
>> pu/amdgpu_device.c#L5211
>>
>> The default level includes all IP blocks, hence it's supposed to resume all
>> blocks.
>>
>> With RAS as a separate ip block, ideally it should have resumed. Could you
>> check why/how RAS IP block is missed?
> 
> static const struct amd_ip_funcs __maybe_unused ras_v1_0_ip_funcs = {
>      .name = "ras_v1_0",
>      .sw_init = amdgpu_ras_mgr_sw_init,
>      .sw_fini = amdgpu_ras_mgr_sw_fini,
>      .hw_init = amdgpu_ras_mgr_hw_init,
>      .hw_fini = amdgpu_ras_mgr_hw_fini,
> };
> 
> The RAS IP block does not register suspend and resume callback function, so RAS IP block hw init function missed under this case.
> 

How does it work for regular reset? For regular reset also, driver calls 
the resume sequence for the IP block.

I think the proper fix is to add a resume sequence which calls hw_init 
(if those paths are identical).

Thanks,
Lijo

> Regards,
> Stanley
>>
>> Thanks,
>> Lijo
>>> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 14 +++++++++++-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      | 10 +++++++++
>>>    .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 22
>> +++++++++++++++++++
>>>    .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h  |  1 +
>>>    5 files changed, 47 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> index 7ef7c54ab982..e11c542a01b6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>> @@ -3857,7 +3857,14 @@ int amdgpu_ras_init_badpage_info(struct
>> amdgpu_device *adev)
>>>      if (!con || amdgpu_sriov_vf(adev))
>>>              return 0;
>>>
>>> -   if (amdgpu_uniras_enabled(adev))
>>> +   /*
>>> +    * For the reset-on-init path (e.g. an NPS memory partition,
>>> +    * switch) the RAS IP block hw_init has not been enabled and
>>> +    * the amdgpu_uniras_enabled return false, check amdgpu ras
>>> +    * context uniras_enabled flag, eepron init will be called
>>> +    * during RAS IP block hw_init.
>>> +    */
>>> +   if (amdgpu_uniras_enabled(adev) || con->uniras_enabled)
>>>              return 0;
>>>
>>>      control = &con->eeprom_control;
>>> @@ -5859,3 +5866,8 @@ void amdgpu_ras_post_reset(struct
>> amdgpu_device *adev,
>>>                      amdgpu_ras_mgr_post_reset(tmp_adev);
>>>      }
>>>    }
>>> +
>>> +void amdgpu_ras_resume_after_reset(struct amdgpu_device *adev) {
>>> +   amdgpu_ras_mgr_resume_after_reset(adev);
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>> index a86ab65aa2f0..ad24c7cf8936 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
>>> @@ -1045,4 +1045,5 @@ void amdgpu_ras_pre_reset(struct
>> amdgpu_device *adev,
>>>                                        struct list_head *device_list);
>>>    void amdgpu_ras_post_reset(struct amdgpu_device *adev,
>>>                                        struct list_head *device_list);
>>> +void amdgpu_ras_resume_after_reset(struct amdgpu_device *adev);
>>>    #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>> index 9a4e8715742a..f175c8987aeb 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>> @@ -1669,6 +1669,16 @@ static void
>> amdgpu_xgmi_reset_on_init_work(struct work_struct *work)
>>>              if (r && r != -EHWPOISON)
>>>                      dev_err(tmp_adev->dev,
>>>                              "error during bad page data initialization");
>>> +
>>> +           /*
>>> +            * For the reset-on-init path (e.g. an NPS memory partition
>>> +            * switch) the RAS IP block hw_init was skipped under the
>>> +            * minimal init level, so uniras was never enabled. Bring it
>>> +            * up now that the reset domain has been unlocked. This is a
>>> +            * no-op for any other reset path where RAS is already
>>> +            * initialized, and for non-uniras devices.
>>> +            */
>>> +           amdgpu_ras_resume_after_reset(tmp_adev);
>>>      }
>>>    }
>>>
>>> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
>>> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
>>> index f627a97797ed..a70e532b3d00 100644
>>> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
>>> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
>>> @@ -465,6 +465,28 @@ static int amdgpu_ras_mgr_hw_fini(struct
>> amdgpu_ip_block *ip_block)
>>>      return 0;
>>>    }
>>>
>>> +int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device *adev) {
>>> +   struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>>> +   struct amdgpu_ras_mgr *ras_mgr =
>> amdgpu_ras_mgr_get_context(adev);
>>> +   struct amdgpu_ip_block *ip_block;
>>> +
>>> +   if (!con || !con->uniras_enabled)
>>> +           return 0;
>>> +
>>> +   if (!ras_mgr || !ras_mgr->ras_core)
>>> +           return -EINVAL;
>>> +
>>> +   if (ras_mgr->ras_is_ready)
>>> +           return 0;
>>> +
>>> +   ip_block = amdgpu_device_ip_get_ip_block(adev,
>> AMD_IP_BLOCK_TYPE_RAS);
>>> +   if (!ip_block)
>>> +           return -EINVAL;
>>> +
>>> +   return amdgpu_ras_mgr_hw_init(ip_block); }
>>> +
>>>    struct amdgpu_ras_mgr *amdgpu_ras_mgr_get_context(struct
>> amdgpu_device *adev)
>>>    {
>>>      if (!adev || !adev->psp.ras_context.ras) diff --git
>>> a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
>>> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
>>> index 4f44a917d48b..3f80b9f1f0ac 100644
>>> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
>>> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.h
>>> @@ -82,6 +82,7 @@ int amdgpu_ras_mgr_handle_ras_cmd(struct
>> amdgpu_device *adev,
>>>              void *output, uint32_t out_size);
>>>    int amdgpu_ras_mgr_pre_reset(struct amdgpu_device *adev);
>>>    int amdgpu_ras_mgr_post_reset(struct amdgpu_device *adev);
>>> +int amdgpu_ras_mgr_resume_after_reset(struct amdgpu_device *adev);
>>>    int amdgpu_ras_mgr_lookup_bad_pages_in_a_row(struct amdgpu_device
>> *adev,
>>>              uint64_t addr, uint64_t *nps_page_addr, uint32_t
>> max_page_count);
>>>    #endif
> 

