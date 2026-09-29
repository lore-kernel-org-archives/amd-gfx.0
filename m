Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC264CA5FA1
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 07:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 702B210ED17;
	Tue, 29 Sep 2026 07:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uNyb/fEB";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011063.outbound.protection.outlook.com [52.101.57.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 803CD10ED17
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 07:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgFs0lVGs93+32nPoU/WPAF8IzpPYQSI75iN8DTd8ml4XArqTXOlTDyNe5za5qqhhUuzkM6Hsqu1NsCxxRRnumwQFHawJkzrcGglriUWOIZpjTmlAhB3raEinEkMqmgtNl6uy2qjgm2X/fOYTpv8jEpDN+tXuMd07g3/iSSti6wXG1NJjxa4vKP0IApqudKkfcbzO5io3JVEVxDOwwA0hXHS6jWwUDLbsN6z8hT91FEJeI63XxZ26ff3GJEajVt32DVsH+69poqbi4WdEzGW1m5vT3AZND204Z1DRNFDTnJMDGIqsARkTBKEBWMtL15udnjdlFHfKYIcABjGNhZCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2MdCu+ysiCFDGvnjnh3SB0Hb3wWIpAGTDhIBvQprEo=;
 b=XjDToL/Q47jLDf9+1MGtSclKWx5aePRShgtaugeZtrgokvColseTzmPurHu1KiFUaYlKvY/bjdqrcstfYMf4CN1TQyPVkftSFiPDt1VFW+7vQ/P53xA6lEfmTNYdWVp1ngxRThYSmq46z3+XMJ6IombX19ceAgRdztLB+2NhhOYAXhVCg+4/FlXpdNzL8Fzhq9qWIfLDdH/6vMZpSJh0PRmdCJnZf5AYZDrRK0TFRfFtMmIkxuOSkVeLc2GIuiSt4kYLikIHR3r/JYKegMhMrC/HKgS5q6o3QHMjiFwxAVUa3y+P/LKkxVYJqtYtXSusZcvIL3f6cT0ck3edggFBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2MdCu+ysiCFDGvnjnh3SB0Hb3wWIpAGTDhIBvQprEo=;
 b=uNyb/fEBAow7iNyss6k22M0oj9Rk6hX/5xgBYHcuNN65dwkPP7rn3qcqIhFn0t2l9OZMf2P1Yv12nzIfINl4enhdofh8R/JLJiHMJjLpGyJQfnQDmh+wqb+pQ/N4tjnCVgthB4dPA7VBpXA3iPe9FzRIOBGPZue2pfOq7G9h/+M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS7PR12MB9504.namprd12.prod.outlook.com (2603:10b6:8:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 07:08:20 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 07:08:20 +0000
Message-ID: <290d7051-deb9-4b51-b5c0-e633687d1be6@amd.com>
Date: Tue, 29 Sep 2026 12:38:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: skip PF-only programming on the VF
To: "Wang, YuBiao (Ethan)" <YuBiao.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20260924070129.2150408-1-YuBiao.Wang@amd.com>
 <3ee41db3-c971-4954-91ba-a00b235d3115@amd.com>
 <CY1PR12MB9699451FD7B93462739D3442E58C2@CY1PR12MB9699.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY1PR12MB9699451FD7B93462739D3442E58C2@CY1PR12MB9699.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0308.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:220::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS7PR12MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: e484bfec-b47d-496e-9452-08df1df871a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2OXF4HOTrnaFws9KMWBJIdcAypbscN8kQWZGEmqp+SeqZABG1BhtLdj8r3O/TrtQH1UN46c6NMpbY9S0hrPlux1K2BJOnuWvelh5wd3buZw3OQdhl9yddaqsqW4p5phJrjRkwVXNBNdWs8WaIUgcOoKx9SCaLZLAdk5E0zkWL59BsqiiBIBlKQnDrdv47ISQDJ0uNCI8M05MDfw7Aw0Sisee+fsUkuNjlnVF3LQr+abllJRa0Nc5O8yKXUTWHiyzCFMzvEs9RLJ5x4hnig9g9plsT3EBbkTD/uBiGsPyNnlHTHaNuUI9vRA5EAJPN+QIpwxgssMPS7kKH9fn3K/Fdjh1gbybXYVJSxqK121N1j4usYND6fAkQEJWqxy356ZDCzmAvD03o653CemY9gHpGHTxq0gJEAhPn/1zAv0iOec5e8ebYRQPFvbJ7CTgA8iblq54JZ99rmd9v1wcNyoZM5d3fFh1CS/v4pob+ARLDzBDQhC0QlNx161xHnem307SsJGdeBpbliTkZgBN+sn0Po1CSJ1ZpWMfyVbkaLrelvHqx9ARZ8+DUipkm0p4tBjjtKpax4xnBzQvSvSu88ZzCH8uNZ9cnDGbLbCkqfzfqb7E2g6hx45d6V7mlZvqmEolJWsvoGpyfMg5kJQMWXNdXqfUjYXG2wlhqi+YAhFy4Bk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk9LZ21lZExMcVcrV0VBNzZNUHFCSDFtbHJuY0hxaFpkalA0aXJMYVhrWS9i?=
 =?utf-8?B?K2Q0U0VqVmZCOG1PWm9ZVU1CVHZnV1VsaU9jazN6dnpxVkdhTy9LZWtEM3U1?=
 =?utf-8?B?bXM2bk9Vc0dPYzVETnBSUWtxaG0yaklha1FvVlVNZlVzNzNuOFJlWFJzVUF0?=
 =?utf-8?B?LzcvMGhGUys3ODNGS3Jqb3dqTGJmcEU3bm1zZ3lkdTZDT0RmNnpiVmxDTGJU?=
 =?utf-8?B?K3JzQmdjTkw2MmhpMGRaMWxtTzJGajNZbTZ5NkZuRG9PR0hPNzNxa1BzazlH?=
 =?utf-8?B?N055Ri9xMmRJMmZNVDFkemhHTElFcmJxREgyTFFtWHZpM3JuV0t1VFhXS2tP?=
 =?utf-8?B?RHdmSENubFVhdzkzdkxvdUhQK0lxU3N5R1d0Y1ZRaEdHYlovbVloU3EwNGNT?=
 =?utf-8?B?V0NSeFlNRDdRK2RnRDNSWjhqOHNDUk9rbUxJVW55L1BBMXVUL0s4OHpMOWt1?=
 =?utf-8?B?MnV6YS93djRrNlZ3a1pKYU1heGxQRGg1RUowUjcwL2kwQVI3ekU4bVgyQ0ps?=
 =?utf-8?B?M251OWxJbm9wOEVZNysyT3NZallwS2tkMUlrMzBzektBYWRhT1RDRmcvaG00?=
 =?utf-8?B?MUFLempKemdvZm1ZY2l4WXpVK3hDK1VyUDJkNXJzTHgxb0NnSTB1bWkwSmVu?=
 =?utf-8?B?bUxUNm1hak1EYTlaYjR1M3N5Zk5neWkwa0NVZkRJZmV5Q3pkR00ycWM3ejRM?=
 =?utf-8?B?YnNiT0R0eVNVLzdvQlhKeGdzd2JkNmFUWFJxblJrUkhrOGozTGU2eDVkR21D?=
 =?utf-8?B?RXBSWGFvSDk0dElBZWZTem43c2cwcCtFczE0QlRiSkRFWnhRLzhqWjVuWita?=
 =?utf-8?B?dk5DajNVRGFnL0ZrQTVFM3hDdEZnRTZoMXkwYmdhRDB1VzJWZGg4T3dPM0to?=
 =?utf-8?B?Z2FqbW0vTzBReUtmYUIrODFOMHJqR1VxSTJlVkFJR25QNzZhTTBNWEU5enVT?=
 =?utf-8?B?a3drckVYc3lUUkJmWkNLeGZ4dVJXUFBUZHNZWmY2VmZLQTUxWEdiTFg5QnBB?=
 =?utf-8?B?ZDlnTzJSUFE5SVFjak40NWRoRDhJRk1nS2RwUzJ3dlROa08wYitrY2lhWWpR?=
 =?utf-8?B?SXVNRU42UXYvMGR3Wi90bkNpSHlteERrSzkxUmQ3T2FUSXBETmpnb01CS05N?=
 =?utf-8?B?VzAwMFNUYys0d0FZUUNTZjIrWDJrL09lSExrL1lLNWlIMnlDVmZzMVM4VDJJ?=
 =?utf-8?B?UFZxNjVaZlRqNEwza1Jrdkw0TlhURXdnNDJ0SjkvcVZsRFNKaHdlb1owNVN4?=
 =?utf-8?B?dVVPSGt1RUZHbHp5c1JHNEJrZ0J2aE5QOTVJSjFPZXJ0V3prL1VKelpqNm5v?=
 =?utf-8?B?RjNURDJvdVFqYUk1NUZFRVc5L1pTMXN6QmM0RUl4d2ViR2VTdWxxVEpCaEhQ?=
 =?utf-8?B?ZExZZ0E1Q0EzRVVDaXJNazdyUnJ4VUxaMGdMVFZrU0hwV2VwVGU4dElPVVpv?=
 =?utf-8?B?YUU0VU5IRklYRHRxUVNidUExWlRPNHZML0d5bVJRSWFwblFMb1RscUsrb0pp?=
 =?utf-8?B?NWlSS295SGpzRmo5YVhlcitzVHM0QU1TbzVBemVURlY0V0tSS01wZXk0Mjk2?=
 =?utf-8?B?THU0ODkyQmpSVE00R3dpZ29WYnppZU9YTXBrSkV3Z0JaTFU1NFJZZlBCNXJI?=
 =?utf-8?B?b1RFdGJmcWZySjJaakIxaHBqMVBFRklHYWtaUGZab2dMb0E1aWtLVlB4dDdL?=
 =?utf-8?B?dGJudGdyVnVvdjdtempxc2ZXZFhEUTlHb0hiaTFlb3BpM2tTMkZRUThrL01n?=
 =?utf-8?B?WVN5WFVZMkVUT3FjV0xDUWhQR3NLQjFOdE1sY1lLM1VBemorME4xdS9taHBU?=
 =?utf-8?B?cnFBZ1RMelJXVXU1RVNXN0tXTVN3amxnMmpQS1dHNjFtbndoaVY2MjRDbWxq?=
 =?utf-8?B?ZWhDRmtuMG9jdTJYb296aG9COC9qSjIrclVVRlFIbTRvcWVVd1NsOUUzWCs4?=
 =?utf-8?B?djlSdUgwbk5KdVQxSG1UM2NUT0h1M054N3ZybkJzYUJmd0ZSNEhsdTRhaE1a?=
 =?utf-8?B?UGxIZDBScndVRFd6ZFBFL1ErdVFaRVNMTGpVa0ZiTUhvYWNlNDdKSzVlN0pI?=
 =?utf-8?B?cy9XeTlnejJKSXNKeS9ic25sclhDQ3BhNmR4SkRUNHB2ZkdEUWhsMFZjUnlG?=
 =?utf-8?B?bEt4V1VDd2huN2lUMmxvc1FSMkJRSjRpU1BDb29nNWpReHpBRVpnSlZSVHh1?=
 =?utf-8?B?eVBmZjd4aWdQNzYxM0lrbjk0dU1nYzVJWDMvSGZQVXR0ZlJsenozSHFDNmFU?=
 =?utf-8?B?NUJoQ0dvelhmeGZTeW0wcldqd2R3a2dFY1hIMG1IYk9hWUxyWDVlS1kxdW5I?=
 =?utf-8?B?MTJmUjd1WVpacXpoZTcvLzVYV0xPY2dpNVorakF2ZGcrWEZZNytEZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e484bfec-b47d-496e-9452-08df1df871a1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 07:08:20.7432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCa2wtnJhMFGB21SOn+Uq5U2i4PKqybSxOjyxTUzDydxB46URg+XAv+pxPx5Svyt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9504
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



On 29-Sep-26 11:15 AM, Wang, YuBiao (Ethan) wrote:
> AMD General
> 
> Hi Lijo,
> 
> Host driver will program the VF copies for FB_LOCATION and SYSTEM_APERTURE registers via PSP interface so amdgpu doesn't need to handle it under sriov.
> 

Thanks for the clarification. The patch looks good.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Regards & Thanks,
> Yubiao
> 
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, September 29, 2026 1:35 PM
> To: Wang, YuBiao (Ethan) <YuBiao.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: skip PF-only programming on the VF
> 
> 
> 
> On 24-Sep-26 12:31 PM, YuBiao Wang wrote:
>> Golden register init, the SDMA RB command switch setup, the GFXHUB
>> L2 protection fault controls and the guest-side FB_LOCATION
>> programming all touch registers a VF does not own, so leave them to the PF.
>>
>> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c    |  3 ++-
>>    drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 24 +++--------------------
>>    drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c    |  3 ++-
>>    3 files changed, 7 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> index db541939555b..4f6eac30b235 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>> @@ -2665,7 +2665,8 @@ static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
>>        if (r)
>>                return r;
>>
>> -     gfx_v12_1_init_golden_registers(adev);
>> +     if (!amdgpu_sriov_vf(adev))
>> +             gfx_v12_1_init_golden_registers(adev);
>>
>>        gfx_v12_1_constants_init(adev);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
>> b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
>> index 7fa451b373fc..b13967a1c8fb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
>> @@ -482,27 +482,6 @@ static void gfxhub_v12_1_xcc_program_invalidation(struct amdgpu_device *adev,
>>    static int gfxhub_v12_1_xcc_gart_enable(struct amdgpu_device *adev,
>>                                        uint32_t xcc_mask)
>>    {
>> -     uint32_t i;
>> -
>> -     if (amdgpu_sriov_vf(adev)) {
>> -             /* GCMC_VM_FB_LOCATION_BASE/TOP are VF copy registers
>> -              * VBIO post does not program them at boot up phase
>> -              * Need driver to program them from guest side */
>> -             for_each_inst(i, xcc_mask) {
>> -                     WREG32_SOC15(GC, GET_INST(GC, i),
>> -                                  regGCMC_VM_FB_LOCATION_BASE_LO32,
>> -                                  lower_32_bits(adev->gmc.vram_start >> 24));
>> -                     WREG32_SOC15(GC, GET_INST(GC, i),
>> -                                  regGCMC_VM_FB_LOCATION_BASE_HI32,
>> -                                  upper_32_bits(adev->gmc.vram_start >> 24));
>> -                     WREG32_SOC15(GC, GET_INST(GC, i),
>> -                                  regGCMC_VM_FB_LOCATION_TOP_LO32,
>> -                                  lower_32_bits(adev->gmc.vram_end >> 24));
>> -                     WREG32_SOC15(GC, GET_INST(GC, i),
>> -                                  regGCMC_VM_FB_LOCATION_TOP_HI32,
>> -                                  upper_32_bits(adev->gmc.vram_end >> 24));
> 
> These have VF copies, and likely needs programming as in gfxhub_v12_1_xcc_init_system_aperture_regs. Could you check?
> 
> Thanks,
> Lijo
> 
>> -             }
>> -     }
>>        /* GART Enable. */
>>        gfxhub_v12_1_xcc_init_gart_aperture_regs(adev, xcc_mask);
>>        gfxhub_v12_1_xcc_init_system_aperture_regs(adev, xcc_mask); @@
>> -576,6 +555,9 @@ static void gfxhub_v12_1_xcc_set_fault_enable_default(struct amdgpu_device *adev
>>        u32 tmp;
>>        int i;
>>
>> +     if (amdgpu_sriov_vf(adev))
>> +             return;
>> +
>>        for_each_inst(i, xcc_mask) {
>>                tmp = RREG32_SOC15(GC, GET_INST(GC, i),
>>                                   regGCVM_L2_PROTECTION_FAULT_CNTL_LO32);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
>> index 321c67e01443..d1e09acc684a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
>> @@ -1397,7 +1397,8 @@ static int sdma_v7_1_hw_init(struct
>> amdgpu_ip_block *ip_block)
>>
>>        inst_mask = GENMASK(adev->sdma.num_instances - 1, 0);
>>
>> -     sdma_v7_1_rb_cmd_switch(adev, inst_mask);
>> +     if (!amdgpu_sriov_vf(adev))
>> +             sdma_v7_1_rb_cmd_switch(adev, inst_mask);
>>
>>        r = sdma_v7_1_inst_start(adev, inst_mask);
>>        if (r)
> 

