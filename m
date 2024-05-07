Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2C8C25B10
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 02:50:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BAC211237B;
	Tue,  7 May 2024 02:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GLk9cC6V";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4B5F11237B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 02:50:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpbFXecN2ljbncgiz9I3J5HzrLZkYJzF7J0CYIJ7oylyjK9/N81fSdnlpWS1HW2fKmTu5urxNh0RTC/HimF8TUJB+rIrzWsSECkVf03N/XNZgSYo3XgzLwdBykLCHgH/Kb+HtF8EDuu9ntiZs+AKQwplBJXASZ4r//XXL+uthDSSGKvxMP2EWTfIRiCmDRLiwETqhgt6zigYyac9rjLiOa1XtDDbTuW7DRT1C2M89TpDKDrSlOz8xiXrQxLIRXS7IZFVHcpneDzH4GPCvHLwymBRT+14knxBbV+xYZWip0mVSsQcFoaH+7zz2jVtxiMF9oXGkuRcMLvM/IptCwzOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJJJf3/Wpe/1/D5nkBhEEVhyhhpuNoYHxiTvMLTZqRY=;
 b=NfrvQNdl5l4JB4751vVc0ghHr8HPX73gZe3MQMgym87vSKL8ONtVFVRfgUZVqlwpFTlWOJ04ihB9y0O1/IwskvtrbgGqxdF48WWFjxfXUi+q+HL4Ju6hzdO31GvvTJdig9/F8DsN7fKH9bLFPhVodFZ0gexjWi/7EjHZ/GccvUsiesN5PhtfLMy6/Q60ano57qbTWrp6y91N/gmMbul8fxr5bNXfRcu1hTk+CaO6rVjxK4zuD2IMwvYlloaiyowMdCIYDEkFc/9sfv4t/NapcJZBlQYaRwT7EltkM/+otTOaBLnxffxdPZUsG+NwO6ia+NRQdmVJn0Rm2Vk9e3Vdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJJJf3/Wpe/1/D5nkBhEEVhyhhpuNoYHxiTvMLTZqRY=;
 b=GLk9cC6VfdTnOLRPiXoUY0RdSDu15FvkyowUnnfuCit2l3I3mjc8XzCSu3Ny7hf6SF7hgFyJ142cf7bDYRCiCBQ0EIAFpmSs1hAgAZ+0tNTSu043SdGd2E94uBRi62lqfypzbWMG68mZKUZJ7CE+PKutuAfZKtAGVggKuCaKdiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 02:50:27 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 02:50:27 +0000
Message-ID: <fb683aec-e96b-49e0-8ba9-e351cd800bce@amd.com>
Date: Tue, 7 May 2024 08:20:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Assign correct bits for SDMA HDP flush
To: Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com, Le.Ma@amd.com
References: <20240417115743.167530-1-lijo.lazar@amd.com>
 <CADnq5_Nu85f-UkAwnVzizxwKMhmW6UN11JuBpx68Se-SpLhm1g@mail.gmail.com>
 <d6cf999f-c44a-4f70-90fe-7cce1eea4a5e@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <d6cf999f-c44a-4f70-90fe-7cce1eea4a5e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::29) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: 917da262-5254-431d-f5d4-08dc6e40734f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVNKeWtJZzhmVjdxSG5obk5uNXE2WVo0TDh1ejdJOXYxQ0ViZ3RjdDFKUlc3?=
 =?utf-8?B?aWlNTW5pRHZGOFQ5NEJSTFd2SDdVaW9HS3kxa2ZrVmliVEhXeGlCbEx0alNh?=
 =?utf-8?B?WUl2S3FIVy9jSlVnN3pkS2lybzI1NGFVUG9Ha1M4UndCS1Fwc0tSWHZtL1hn?=
 =?utf-8?B?bldONW9va3lkVWdPUUdrQU0ydmJzVmhiVjBITmFURXF4d1h2THEzNDBNSTc3?=
 =?utf-8?B?aUJ3c0JKTUY3T3NTcjB4REh4dThLbDhld0RNa3JHUjFPcTJ1blVkaTNTS3dD?=
 =?utf-8?B?WnNXZ0pjOEh0NGJvZDgzN1lsOEUrZlVMOFo3d09QS1FXOTl5Vm5vMVRXSFg1?=
 =?utf-8?B?emJyZGZEODVraUZZaFBhU0N0REN4UFhYa1ZBRFZiODBicWdJTnk1THNCRkVC?=
 =?utf-8?B?R0J4bUxobTB2enFiZDZscHdIUVNUNkZWWTdkVUhpK3QwRS81UU1QbEpSWkFD?=
 =?utf-8?B?NXBXdFBJdUtvS1RSNlV4Y3BXWFM3Kzc5VzdUVjhObGF4N0cxOG1ER3FRazNm?=
 =?utf-8?B?OHFOUm5ienlYR256Z0U4Nm0rc2FLZnFLaVpmQlJneVFJcGpnb0tDZS93d29K?=
 =?utf-8?B?S2dac2pTRDk4NktNcDI1czZ2SHRQbmM2M08yV3MvNE4wdjMrUkhIY0dNSHNz?=
 =?utf-8?B?aVZQQ0RRZ0ZSK0tIZlpHZW9QL2Q2bHNkV2t1QWNqOThmOW5UWHdxd2MwTlQ3?=
 =?utf-8?B?cnFNUWt1MllkQ3Rrd3RLaUs5N1BZdFN4b3FXZExJWGlMc0paN1ZmMjg1bEN6?=
 =?utf-8?B?a0U4VmRQYUh2ZDZLTldzUDJqWTdYNUtkM3l6eENVaHFvSTNmQ0ZrKzEvZldj?=
 =?utf-8?B?REwyMFFjb3J4azJYVzJDTnVWU1c4KzZGUGZ0cHlMdGhLeXc2VlMwbzVHRitU?=
 =?utf-8?B?U2JYWFUwQ0dYaHFpRW1oclpsVmZZc3JlVU0zZE1KZUhtTzZWVGM1RFFtQmNX?=
 =?utf-8?B?ZHJNNWRqanFXaDlGSk91Nk5JQlRLSU9xSzNySG8rNVcvUHF4U0VzQUJ5d0Yx?=
 =?utf-8?B?VzhmY3dxby8wMitIaGt4QTJzTVRrYldONjBIMEJYeTc0K1lXRE1oelVmeVd2?=
 =?utf-8?B?MmRuRC9HL01sRVBFeVVzdUpBTTd0dE9WMnovMmFXaFVDNEtkNDRDREF6L3Bi?=
 =?utf-8?B?U29CaGNvcUplY21LcjJxbzFIeldwVEM0b0pvK3h6M2F1WTl4N2hKQWF4QnU1?=
 =?utf-8?B?dlM5ZDRtUGhsRTI0aElXZFcwZFd0R0wyT3VBdk4zZW1ja0xvaGI2UkFMNU10?=
 =?utf-8?B?WHFmTWo0bjRMRG9haEIzblArREgzTDN3SGRzdklEZmRsTXI1VmhVUnpiMDRk?=
 =?utf-8?B?MGFKdHhqSytFOGFOakZzY3BvQW5LTktBckY2bEJmQVFKM25idlRMWnRleVVy?=
 =?utf-8?B?RFp5WmIwcUliQWF1cS9FMzZmQnFXZDIzT2lpS1lLOVNUQjY4RHNaaFpncDM0?=
 =?utf-8?B?RGtuSGx4VnJqTFhHTnhDS09iZDhPSWt0NzNmZDlmUUkxbUlXMWxQdy9QMWRy?=
 =?utf-8?B?Q0JQajdzbmg3ejV6MzZBMHcvVURBRlVGUlRtRUxMUXRlNno4eHZaQXBkZUdL?=
 =?utf-8?B?TjdCMk5meElpYkdPT3VXdDhmOU9na1ArMlJHNVkzYW1sT3ZJZ3MxWXFjcThq?=
 =?utf-8?B?akhBMHFoOUFRelQ3UVM4ZmtyY3RZaWNIclVhT2pPZlVlcVUzSGhNTUVDMWFE?=
 =?utf-8?B?Q241NGNSN1RRSjRDVWRBOStJR0x5YWU1eGN3R3BwOGFRSE5uZlMzRElnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3UwYzkzRkJJZEc4K1pmSVNyWWRVbGlwc2ZacDBFd3JZdGUybWlaTnZaTll6?=
 =?utf-8?B?SGhHRk5iZ2EzdEJiemgzZk9sdnpOa3h6YnBNaldka1NTeThoMEFQRHl2VTJV?=
 =?utf-8?B?dG5HZmJCaTBXOGNuQnQwVHRRdjFmQm1OM3JxOXVkQXB5S0JZL1JlcTgvZ0o5?=
 =?utf-8?B?N3BNc1pGeFZXWXpZMnhnVnBIQ1NwUlYwTmpZREtybGJuY2RpRU9nNE44b0My?=
 =?utf-8?B?Mm1JMlNOOVI5WmptamVCU1l5eDhkVXpYejFtV05rSGhnMTNiTGFSTXVxZWg2?=
 =?utf-8?B?R1ptU1pGN0IvSWd2MHNaMUh6NGVWb25OQlZVVFZxNlBMUE9CSmhHK0IyUkJt?=
 =?utf-8?B?K21PUXdXbXBvaUNsbitLRkdDWjJCVUNRWXBDUjdDNmJNVWZ4aTErSWY4UDdC?=
 =?utf-8?B?WWJ1VW5iTUNHR2x4YWZsNCtWeEpRYit1VnJyNVZkMWZMdlpMQXhVL0dmaEhH?=
 =?utf-8?B?Y2hpNmN0WnNIZVBGNFJVclR0dWo0bjZIQ04rK2xUWlNQZFhBcVM5R0FqMjVL?=
 =?utf-8?B?WUNsMW9rL3Zham9tTHJpdXJ6SmxLWnV6RWtuWlU2YXVrcGxKZ284bVNyOXZ4?=
 =?utf-8?B?TzZ2TlNsUzMxMklmZEJyZW90UzJnbDJDaTlxOEErSUR1eU9oQk1ldGhObGNM?=
 =?utf-8?B?bnJUbitGcTlRZFZlWFZFMmlOZldGV0x3cmZwM2xIMUc3b0tqMGgrRWVFcm9E?=
 =?utf-8?B?RG5ac0Vhem4yZWo4UUJKYVIxNHhXQTF3ZitkNFIxWk82L0ExVUNlV3liVWdM?=
 =?utf-8?B?UjlVMmVpQlcvSXBlRjY1R0k0OWZwbGZsck9ndHQ0aFVRRDVoTHVIdGJaWm83?=
 =?utf-8?B?SHRNZ2JtcDFJeWdZV1hxRWltdEFUaXNKYTdOLytiUzJMTjZpdlZXaERKZ1h3?=
 =?utf-8?B?U3RMd0M4bWFEaEhIemhxeUZXRWJZVHViakkrMUEvYTBQRFoyNENVa0FHckN4?=
 =?utf-8?B?VlpLNXMwMWxEdUJHOHI3Nzk0NHdhZTRRaFRJYk1reTdZUFpBRGZtRWZYT2ZL?=
 =?utf-8?B?ZVN3cC9WQ2JPSU9OTFlob3htVmFiaVBRY2oySHVpSW9EMjRjS3Zrb0cwSlR2?=
 =?utf-8?B?OXhwRER4Z2IwakxDZE5USEwyVHZhc3lzM1BBMWx3b3ptWjV2TnBBenhzUEVS?=
 =?utf-8?B?NS8wV0NCVXl2eTNNbTZ1Sm1JeUNwTFpmNnQzYjhmeUVDNjJyQVROM1lZMy93?=
 =?utf-8?B?OWcxMlR1MkZJZEVWb2EvWXF2aGUwL1B2UVYxNElSSjNaWkxWMFc0ek1oeEtQ?=
 =?utf-8?B?aTVrWlVJdkIvT1RSc0lZL3ArUWlNTEx1YWNzR2VmVTdia2hmSy9Lcmx5a2JP?=
 =?utf-8?B?ZXFOdkY3TWg3VTk5c0VLR2JzenNEb3QwZFZhZ01ZZXdmV1VGcStXRndlei9U?=
 =?utf-8?B?US9CWldKZkswQ3FBUzhmZTVtUnJUU2ZpVmlLVGdoNXJmWjBiSit3MXFaVmh5?=
 =?utf-8?B?Q1dZTCtZSm54T29id0ZJemF6YzFUMFZJbHE3bmlDUUsyOWt4ck5KbE1DUHNP?=
 =?utf-8?B?YVUwV2R3SFhtd1NXRHZORmFsbHpTMkxwZkVJQlQyNVU1aVFzVzVIUWsrRzNQ?=
 =?utf-8?B?d3F0WEtsSUZyNVc4bEpTSGlwQnoyalZocE94aU1PeHcxblFWd1gzdTZjWFNU?=
 =?utf-8?B?RW9jMUQ4SFFWRUw2MEUvRUZNZ1pYR3F0RHpFSnFTUWg0MlJCUG92RUxXbDl6?=
 =?utf-8?B?TGRYTTRxTnNIOGkwMVMrYWM5SFJwTWRKK1MzZU40c2RzVGpiRTcyRzRyT3Bh?=
 =?utf-8?B?eVcrQjM5aXIrYmlFR3BjdVJYdkRPYjMvSG1SYUxobUtraitBUkNCVDR0bXBn?=
 =?utf-8?B?K1FjRGk1SUZBenQ3MkN4eVUrVGdTT1VVeGZpVmMvUHJGNWdZZ0F2b3p3dTBR?=
 =?utf-8?B?L0RPUW0vK3VpRExDWkc1ay9EUE5sQ3dMOGUvbXFJdUc5UVc0dEZRV2FKdFhE?=
 =?utf-8?B?VU1zejVpeTErU2pka3c3Z0Q4bHdwV2Q1d0pUYzlEVEZTZXBaUnlvdHEreFo0?=
 =?utf-8?B?ZmFRdEdOemNRL1B1MG5jZEltc25Pa2xXbWJFYXBMM1dwZzM2ck9kNjBwUUl2?=
 =?utf-8?B?elRGS0dLRUlvek91dk5OMWVoTTVadVpGVmNnK2hJRTVpeFlnc2gxWVYwYUY4?=
 =?utf-8?Q?QNuB0yhg3BlOmNoggqGJh5CQ2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 917da262-5254-431d-f5d4-08dc6e40734f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 02:50:27.6001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiyUxV1NZ+4N8820FmBO6x/iwHEfbteXeWNciTgK+pHV6o9VOW5B0Al4dDHwHCEO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
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



On 5/7/2024 6:00 AM, Harry Wentland wrote:
> This patch is causing crashes of Manor Lords on my Navi 21 on the 6.8.9
> stable kernel. It leads to an assertion failure in wine:
> 
> File: ../src-wine/dlls/winevulkan/loader_thunks.c
> Line: 3621
> 
> Expression "!status && vkEndCommandBuffer""
> 
> This happens both with radv and amdvlk. It starts happening on v6.8.8
> with this patch. The previous patch (drm/amdgpu/sdma5.2: use legacy HDP
> flush for SDMA2/3) is fine.
> 

This patch will affect only aquavanjaram SOCs and shouldn't affect any
NV series (unless there is something going totally wrong and coming to
this path).

.emit_hdp_flush = sdma_v4_4_2_ring_emit_hdp_flush,

Thanks,
Lijo

> Harry
> 
> On 2024-04-17 09:19, Alex Deucher wrote:
>> On Wed, Apr 17, 2024 at 8:07 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>>
>>> HDP Flush request bit can be kept unique per AID, and doesn't need to be
>>> unique SOC-wide. Assign only bits 10-13 for SDMA v4.4.2.
>>>
>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> index f8e2cd514493..09e45ef16c0d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> @@ -368,7 +368,8 @@ static void
>>> sdma_v4_4_2_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>>          u32 ref_and_mask = 0;
>>>          const struct nbio_hdp_flush_reg *nbio_hf_reg =
>>> adev->nbio.hdp_flush_reg;
>>>
>>> -       ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0 << ring->me;
>>> +       ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0
>>> +                      << (ring->me % adev->sdma.num_inst_per_aid);
>>>
>>>          sdma_v4_4_2_wait_reg_mem(ring, 0, 1,
>>>                                
>>> adev->nbio.funcs->get_hdp_flush_done_offset(adev),
>>> -- 
>>> 2.25.1
>>>
