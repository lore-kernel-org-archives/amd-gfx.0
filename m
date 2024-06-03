Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03FCC25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 09:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32AD910E021;
	Mon,  3 Jun 2024 09:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NAbnqbis";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD0210E021
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 09:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBvephtR/GRpjl8p4D8SS56/2F2TAZjnFEa9lYB6mQcnUiEiwDA/bZLMLDsLzJ0IEOwnSo3otJGysCsB1tLUFOEdVeG2oGiGQBo4DE5Z2pV9Sp64d+dlnKcjvs5pRwvxBKsuzBAHUQqpF3hgzeBlGaeAnGQesTKXHove/yjjybeTlq0xKtBUDfiCRbTw9mQgJehWtaUqwWVkUf3Fh84Y2KW5S/fI1aLYQWpKOoS0wF1dcbkbETR4nqGN+UqSTgW8u9UCjuzWuKS/7UBrXhdT6/RYFcwyZsRp3+o5PuYB7dWIGWdjJ90NYmMVcH1jOD1/0NfyUyfSSTD3wmKPVkxzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDRtL5XCJcvggFayiNTXsubhTbbIwnxf4B2SMKhOPmk=;
 b=jh7lnpPpW/TY3QcJD9jAXCRV8MO4SFzk84q10wWzMjl5mNzZvj+iaQCvryTyFNbGSZG3ELn14KAm2ulJuIiIBjyRnkcMM/0Fh4rymHf2y6KB/qB31WrTM46eHMnE3sb3WZI4u2QqnB/h4OrHxd4+43tPMvesTGujCQg6ijTt+jn3lPf29BJF0SPrg+Get5H2i+EIOh2xOlky2yjbJMlCH7KKxPpwDM7IbhmZ2PuwEsHkjfE84czGb3KcPbUoFH8qwkM1Qf/BjgFmbmYetZDGlVvWud12XOLAm0FVeUWTLGhLqgNWekCrR+EIjSfY/rP6Ea8PVj1DfC2JEzJBjDtjHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDRtL5XCJcvggFayiNTXsubhTbbIwnxf4B2SMKhOPmk=;
 b=NAbnqbis3f0ue7oSAjYSjbyFDqtalWg6ZCj4htLFVlvDfOGBAt/71xls8lMa9jtscicSPU7l2ledjOriZX6p5SfQV4KuxCPnceL+k3yD7cysHRbza8V9KvJHG4k2NKL4IrxIGow9m/bjxOZZVCzbn+aryA+j7EiGDAl4ykI77EA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 09:58:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.017; Mon, 3 Jun 2024
 09:58:24 +0000
Message-ID: <beb3e657-3834-4c80-b854-cdb5ba4ca534@amd.com>
Date: Mon, 3 Jun 2024 11:58:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] amdgpu: add the amdgpu_vm ptr in the vm_bo_map/unmap
 events
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20240603084729.15135-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240603084729.15135-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0241.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: 809ff8a1-51bf-419e-51a8-08dc83b3b54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnpLM0RGUUJrNVVEK0U2Sy9halR2aGdyUHdkaVBLMjArMFJCU2loNUJ3VzZE?=
 =?utf-8?B?Qjl6M3I0NVVTNGxKWmpCUDBETGRneDdBNU0ydEZWTnV2Tlp5TitJWnB3ZFp0?=
 =?utf-8?B?elBYT2FjQU5jcXVFMlZXUzljSi9mNnZxQ01BUnFqR2pPU1FuVG1uOXZSWnBV?=
 =?utf-8?B?WVpnSUhCQ0dwNFNYOWR1b2JVNG1VaGJjR1lBQW9XRFRNbHA0T0diR0R6aCty?=
 =?utf-8?B?S3JvTTE4bm1DeFJ0NTN4U3kwNHNnK1ZmS0VwUVNhMTZGOGpyR3JBNXZBNUVQ?=
 =?utf-8?B?cWdBcUVhZFpjTDRNN3ZVc1FraU1VMmpFclM1S0V6WisrNTMyVGh4czZVSTNJ?=
 =?utf-8?B?RlZ3cTZkL0NTRlBVKzNQV2krWjRSYXdtK2E4YTdLM1BNbHdUMzhML095QjJL?=
 =?utf-8?B?MWFmYlc2NXpSMzNGK0p2UXg0WXRITmRFTGNyRTJxMzA1Q3pKWlcyUmpUTzBV?=
 =?utf-8?B?WUdQSlJ0MWROZ0lDZVBrRVUyM3RJVFBOQ2ptM3lsQ2hMTTFEM3lDSEI0c1Bo?=
 =?utf-8?B?OGxKeVhnOVhyTzNIQjRiRkRjem80KzdBcG16SXhlSDJ0Q2ZMRDJxWWZuMjF2?=
 =?utf-8?B?RnlubUhnSmEzUFZvb2VIdEhXRU5vdlp6emgrdEhzeWlSeU5TY3F1Yi9nanIv?=
 =?utf-8?B?ZmdYVUhGRFNnbU5CeDhWaFk4UEtMajg5ZlBjN1BrRkk0TkFGK2NIMFByaHF6?=
 =?utf-8?B?SVp1VWhodlRWUFR2cE81ekV6VFZGUTFxd1BnQ2JpOXcrQlNjRHg1QVZOdkk0?=
 =?utf-8?B?Q2Z0Y1F5MXBBeHZ4cmpNQm5oVTFaNHVnZXZUWnVEaXpUZzFPUE5kQXRwaWZu?=
 =?utf-8?B?ZGhHc0E3Nk81cjZxRXp6bkxrd1AwalZBQi9nRUNPVk9udU5UT0w0eUhyeEx6?=
 =?utf-8?B?R3N5UmlIdnJTMXhHQ1BlbkRnYURRaXh6Tld3RGYzOElITGpXTGxsMWRaNGpn?=
 =?utf-8?B?RkZnVmFvdWt5Umw1MFBFSisrajFjWWhZRnJWTUwwbVVOeENJTk1hZGtlSCts?=
 =?utf-8?B?Q1ZWaXY0S1ZqYmY0YzduVytDMXFFSXd2aHhET2FMcGU3VWluNjVFK0dqczUx?=
 =?utf-8?B?cEJCMDdQU1VEdDRJSUdJc0NMdnVJNU8yMXQ4a2lkczlOVXFOTEx0anZCeHZm?=
 =?utf-8?B?Q0VqY2dJVWwveHBIS2liakJzeFN4UmxIeW5PSWJibTRIaVArNkNubS9qSWxh?=
 =?utf-8?B?OG9ibTlnQ1ZFeWF0bHpmTXBZVDl4MXozNzA4SmgrSC9LWng1YkNVUE80ZFk0?=
 =?utf-8?B?ZEMweUgwWWg3S1NPUGRWcWRIUmUrZWU1L2V4azlCOGx1Q3FxUVVFeDY3WFJv?=
 =?utf-8?B?RWY2SE5ONnVsTTVuV3JGY0lONmpXdmpaNG9vUTJXZzZoa0J4MFF5d1FaQ1I3?=
 =?utf-8?B?NlQrV1VoZTZNQ05ja3VkM2J2YlgzMUdOVnVubGc5VlpsRjlBOWFubnY4OU96?=
 =?utf-8?B?cVhGK2c1ZEdwTGY4NlVwOGticHh0WmNrYXltWWk1aXFDdnUrVUNvcnZuVnVw?=
 =?utf-8?B?NTVSdzN0NTUyY1dRa0JjL3pwaEZ2cUNudnFmRGJNUFJyVXBUblN1MzFLU0dN?=
 =?utf-8?B?V0I0T25vcDJlcDl4VFU4bndUejlpaGtSK2ZmTjJuVEZCN0ZmQk9GYnJVR1Rq?=
 =?utf-8?B?c1dUVzNuVkNEaXhsRU9GWkp2VnpEbFZJZjZCN09DRC94UnNKZ0JnbkEra0p6?=
 =?utf-8?B?YnZYYk1NTzVtenh2SEYzSjJGTVh6T25lNkFVUkNrQkliVVhJbjFBcFNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clNQUUtjU0gyQkhjbS9HSmRGbXpjSC9QZW1CSS9DQzl6WjJpVUtWUEZkeXJx?=
 =?utf-8?B?NjN0ZXFrVWttR3Ztd2lHSkh6M2pPd3dyZHJOZDlralN0SU1tUGJIRjByYVY1?=
 =?utf-8?B?NUp1QTA1NXdXR0dOZ1NFcFk2OXR2TlNzUWFuR1I4Tm85VDRvZ2VsZ0Vkd3ZR?=
 =?utf-8?B?Tk9jOVROdTV6cE1SelhlTExxa2dwNTNpRUVKclkrRWh0aUh6bmtUTVpJRXdY?=
 =?utf-8?B?TUZRQStrVExEMHJqbWdueG5TQkRwd3RZdnNNWWwxb3JvbUdCT0hQYTltVzVr?=
 =?utf-8?B?QlJPMk1NQWE2ZDU5V0dsMzhoRlNNNkJjWE44cXBuKzREUko4Zm5jTSsreWJo?=
 =?utf-8?B?b0w0b0F2Yjd0YVRvR2kyb1hWRW9Ua1k1VmgyRlZDcnpRRk51RFBlMGxYMVFN?=
 =?utf-8?B?VHBXbjZtNVo1YzF1enRwekpnYTAyZ3Rnb01iSk14VE5MNlpWdGdwa0lseGRo?=
 =?utf-8?B?VncydUlUNWMzdGlVbzdLZEUwaStvSDBrYzVldGtmeENwcm9PNlVNbW5rckVr?=
 =?utf-8?B?RXlJMndyd3AvaUR4aUlXWDUvWUJpM1M0M3lhdzFFVTNjOHNmYm8yclRRRFFK?=
 =?utf-8?B?V21zTGJVdzJSRmxiclRXcnNPVTNkV1BVU3NKQ0hTMDh3RkcwblZsQU93QWtk?=
 =?utf-8?B?MWR4NzRlTEdyVXlmQmE5NEtWVzNGK25zVVVibE9idDlxWFlLL2llWVRYVmFs?=
 =?utf-8?B?elkreTBEMkNDc29PQkF1YUg0L1ZGSkw5U0JLZERRK1FQUHpYcE04eVpIWC9B?=
 =?utf-8?B?YTJISjNnSW5VZEpMOTRsN0did0lmN0dmbm1VdVp1cTk1aUJ2aHROdUFFNWxt?=
 =?utf-8?B?d1pKWlFwQngweUJNTVRKT3NSOW5nL3JhRERrdjd6TjQvOHpETGFVWmJPdGtN?=
 =?utf-8?B?MXhVRVltREdxTVJwNHJQU0ZreHZhdnVnZTZqaWQ5UUZVanh0QWJlaGVyMTJi?=
 =?utf-8?B?Ym5CaytmT3ZrZGM5aGxpaDc1MWhrbm1JcUNNUEFJTWxBbElXMVJEc0xNK3E2?=
 =?utf-8?B?UVpEQ3ZKUlN5dXJtd2QwdmRUckw0NHhDVzI5S29lZkZ1TEpSSFBJTE1XcnlS?=
 =?utf-8?B?SEtLSzFIL3ZoSzJOd1RVekN1YUtXTWJNT3lkNmpnb01zeDh3em9PbFQ2MEtK?=
 =?utf-8?B?S09hOWVSS254N0JqSVdhdHcwZ0k4YjBUZGorRm1qNlI1UE9HKzJmNUl4Z05G?=
 =?utf-8?B?Ylh5TU5hbzZVTGd6V082VktJQ3FDM1JjN0pRdXRHS2VDeW95ak1rWitnaDQr?=
 =?utf-8?B?RTJlVlVLZUtTcEkyOU9NVE9pWlU3cUhvWm5mREhtT1ZSK1ZSM2NsUmVYelVP?=
 =?utf-8?B?RVl3TE1vcG9mSlExbEoybXlEMzQwdFl0YUcrRmo3alFkSHRhSmZ6eWtFTTI5?=
 =?utf-8?B?THNaVHZqYlVNT2FndU1ZSi9uRUdOcUdGWnE2dVhkMWtSUFV2U1NSTWY2VmY0?=
 =?utf-8?B?ZS9pNDdIWVIrbXNmTWVMbE5CYU1zUkt5bzlFZERjSzd2K2ZLT1crWHp5ck00?=
 =?utf-8?B?ZW1YVzI3V3ZFM25nOGVMOVRxSE41ZXdDd3pPQ1ljZDRsMWFpVVh4Z2ZYQXA3?=
 =?utf-8?B?TFNVUDlnTHZZdm1zNWtxRmJMNXhRcXUrdDNsNWZ1SkVTOU5TTzNyY3FnNWRt?=
 =?utf-8?B?b3VQcTViUjU3T3ZvQ3U4SzV5RzRqRnVsSXh0cUpDcVhmd0pVNU5NODB3aDZ3?=
 =?utf-8?B?cUhFbmNTaGZxSkFZV3NaZlN4SGdWdlhibEdHazBqeVBJWCsxQVVqR0NreTFI?=
 =?utf-8?B?aHRMZC9XbGo5YUhpTlZ0dlpKdllFMlZpREdzeFhQM08zMWVOSVBtUnZTd21p?=
 =?utf-8?B?SFZIUmRleHRUV2FnckwzTkh4YnJuRXJhS1E3dnBOVXlJU1E3dkxPS1VhcVho?=
 =?utf-8?B?VnMvZUxGSEhueldHVElGVFJSSGsrNitwNTUvSHBWV242eHUvWWpTSExVNWJM?=
 =?utf-8?B?MWMySWhBR0dJbXhaUTMzYXJ3VUt4WU9RQjNEeElEemJyZktXbFhTU1hrZGdx?=
 =?utf-8?B?WUtBRFV3R0pmU3UweVVUNW1LOUhmZmk3b2RrcFhjWGJWZDBkTm04WXFrVWh6?=
 =?utf-8?B?QjE2b2dnSjlKZXN2RktsN1JqdFhWNkdRdEI0Ymx6c3Y2QzhjK2VEKzhPSjJ2?=
 =?utf-8?Q?tSRmbI4/92LczQbphdTceqpH9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809ff8a1-51bf-419e-51a8-08dc83b3b54e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 09:58:24.5324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rA3wEmRmYSonbpwY6faKd53OCgV3ZGyqRB2KrJRiIJM18xw4Hf1bCSgyonRULmC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
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

Am 03.06.24 um 10:46 schrieb Pierre-Eric Pelloux-Prayer:
> These 2 traces events are tied to a specific VM so in order for them
> to be useful for a tool we need to trace the amdgpu_vm as well.

The bo_va already contains the VM pointer the map/unmap operation 
belongs to.

>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 20 ++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  8 ++++----
>   2 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index f539b1d00234..c84050d318d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -243,10 +243,11 @@ TRACE_EVENT(amdgpu_vm_grab_id,
>   );
>   
>   TRACE_EVENT(amdgpu_vm_bo_map,
> -	    TP_PROTO(struct amdgpu_bo_va *bo_va,
> +	    TP_PROTO(struct amdgpu_vm *vm, struct amdgpu_bo_va *bo_va,
>   		     struct amdgpu_bo_va_mapping *mapping),
> -	    TP_ARGS(bo_va, mapping),
> +	    TP_ARGS(vm, bo_va, mapping),
>   	    TP_STRUCT__entry(
> +			     __field(struct amdgpu_vm *, vm)
>   			     __field(struct amdgpu_bo *, bo)
>   			     __field(long, start)
>   			     __field(long, last)
> @@ -255,22 +256,24 @@ TRACE_EVENT(amdgpu_vm_bo_map,
>   			     ),
>   
>   	    TP_fast_assign(
> +			   __entry->vm = vm;
>   			   __entry->bo = bo_va ? bo_va->base.bo : NULL;
>   			   __entry->start = mapping->start;
>   			   __entry->last = mapping->last;
>   			   __entry->offset = mapping->offset;
>   			   __entry->flags = mapping->flags;
>   			   ),
> -	    TP_printk("bo=%p, start=%lx, last=%lx, offset=%010llx, flags=%llx",
> -		      __entry->bo, __entry->start, __entry->last,
> +	    TP_printk("vm=%p bo=%p, start=%lx, last=%lx, offset=%010llx, flags=%llx",
> +		      __entry->vm, __entry->bo, __entry->start, __entry->last,
>   		      __entry->offset, __entry->flags)
>   );
>   
>   TRACE_EVENT(amdgpu_vm_bo_unmap,
> -	    TP_PROTO(struct amdgpu_bo_va *bo_va,
> +	    TP_PROTO(struct amdgpu_vm *vm, struct amdgpu_bo_va *bo_va,
>   		     struct amdgpu_bo_va_mapping *mapping),
> -	    TP_ARGS(bo_va, mapping),
> +	    TP_ARGS(vm, bo_va, mapping),
>   	    TP_STRUCT__entry(
> +			     __field(struct amdgpu_vm *, vm)
>   			     __field(struct amdgpu_bo *, bo)
>   			     __field(long, start)
>   			     __field(long, last)
> @@ -279,14 +282,15 @@ TRACE_EVENT(amdgpu_vm_bo_unmap,
>   			     ),
>   
>   	    TP_fast_assign(
> +			   __entry->vm = vm;
>   			   __entry->bo = bo_va ? bo_va->base.bo : NULL;
>   			   __entry->start = mapping->start;
>   			   __entry->last = mapping->last;
>   			   __entry->offset = mapping->offset;
>   			   __entry->flags = mapping->flags;
>   			   ),
> -	    TP_printk("bo=%p, start=%lx, last=%lx, offset=%010llx, flags=%llx",
> -		      __entry->bo, __entry->start, __entry->last,
> +	    TP_printk("vm=%p bo=%p, start=%lx, last=%lx, offset=%010llx, flags=%llx",
> +		      __entry->vm, __entry->bo, __entry->start, __entry->last,
>   		      __entry->offset, __entry->flags)
>   );
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3abfa66d72a2..e04928d2e26a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1642,7 +1642,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
>   	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
>   		amdgpu_vm_bo_moved(&bo_va->base);
>   
> -	trace_amdgpu_vm_bo_map(bo_va, mapping);
> +	trace_amdgpu_vm_bo_map(vm, bo_va, mapping);
>   }
>   
>   /* Validate operation parameters to prevent potential abuse */
> @@ -1834,7 +1834,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>   	list_del(&mapping->list);
>   	amdgpu_vm_it_remove(mapping, &vm->va);
>   	mapping->bo_va = NULL;
> -	trace_amdgpu_vm_bo_unmap(bo_va, mapping);
> +	trace_amdgpu_vm_bo_unmap(vm, bo_va, mapping);
>   
>   	if (valid)
>   		list_add(&mapping->list, &vm->freed);
> @@ -1929,7 +1929,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
>   
>   		tmp->bo_va = NULL;
>   		list_add(&tmp->list, &vm->freed);
> -		trace_amdgpu_vm_bo_unmap(NULL, tmp);
> +		trace_amdgpu_vm_bo_unmap(vm, NULL, tmp);

That bo_va is NULL here is probably a bug and should be fixed.

Regards,
Christian.

>   	}
>   
>   	/* Insert partial mapping before the range */
> @@ -2056,7 +2056,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>   		list_del(&mapping->list);
>   		amdgpu_vm_it_remove(mapping, &vm->va);
>   		mapping->bo_va = NULL;
> -		trace_amdgpu_vm_bo_unmap(bo_va, mapping);
> +		trace_amdgpu_vm_bo_unmap(vm, bo_va, mapping);
>   		list_add(&mapping->list, &vm->freed);
>   	}
>   	list_for_each_entry_safe(mapping, next, &bo_va->invalids, list) {

