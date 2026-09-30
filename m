Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29037CA5FAB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 05:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1E2610F1AE;
	Wed, 30 Sep 2026 05:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o5o+BbL9";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E774110F1AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 05:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVbo76ybMXflFYZCQxRUlXue/j3qGMQW3jiz4//D1k40D2hLymS3GuEkkUE7O8rkLLBoIPxkoSCXmhPFBeAAJysUzDqxibUB+qkZtwNg/RxMZ0kw38WBKX88KKLnWJ0FEbO+Amno8v9g4w+mdYNZsrtOSZznPxNaPkl/YkRG3CAgV/9GO/zsas3EjEynez74wThBHu30/cnsj01lY0QASfy8NUn3KsANhgXwfc0kQdyIHtvgcar4yXPXTzsYZIeoYjPfSClwirSQ6/tMTsqo96IjK+U1Du5ow4t0fw87MeXQtMWSPdmCa41S67do+G30c5Q/apwUGPXMhJFIFQ+/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2kClTapl/I7MxGOKFHiPb87Lnhakkuj0VD9PueR3nI=;
 b=lYcbz/8ULvJscewsaRz9rTR6C+qgiS0kULI2/daxT6/x3VvuwTDDpXtK+joc2MpOg1XE+a3En9cynMsUWRMGwAtrbRPqtZj9278lre2Mg8yZ+u2mKCUE4kySPBWJwLtKWKfcf+Pxp8xPS8BH3gvDJzwLdXfHniSts+PNk6Z2tPg5HHvQa8KOiV6RDZrUTntQwfq5yQ7JwuZZcrAyow8mRmouPS5w86n4Qeho8ejFUCtdUbgMOtw4ikpv0skk/NTh/mSxYnSoz9Ld7FvN635XV1joX5qP1EFB9+mGK+hbjmW58pjQlWhPAWURtkcb4XSGMPzFSFLMF7M/NA5E4tnCSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2kClTapl/I7MxGOKFHiPb87Lnhakkuj0VD9PueR3nI=;
 b=o5o+BbL9Z4FStC9R/fPHzoSQaX/VVb3D1dc6hcy5tFjunCCFn7ALjB8OrOhD/7+WDAkD19QCqmDw8BaMt3dYFidqw8PVMM0P7gMZ1wKNknyOuK8xiUjjBfWoHWkJ6JHs9LsyxZDzN7H5eAs8QgfMaNc+viKINhDg/XSiiytWl/Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 05:40:52 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 05:40:52 +0000
Message-ID: <fa59606b-0860-4aaa-b6ce-ac037f73eab4@amd.com>
Date: Wed, 30 Sep 2026 11:10:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset on
 gfx12
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Yuan, Perry" <Perry.Yuan@amd.com>
References: <20260929022540.122318-1-yifan1.zhang@amd.com>
 <f9db848b-da68-4acf-a0e3-41464b939817@amd.com>
 <CY5PR12MB6369B765E89F17858A5AB4A8C18C2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <BN9PR12MB5146D08AFE80E7E6EE34B614F78C2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <CY5PR12MB63694BE5CF3FB172F837CCBFC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <6b086b84-deed-47ec-ab7f-8cc016ab519d@amd.com>
 <CY5PR12MB63696540D11FBBD268D9B7ECC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <a2f8757d-1566-4b8e-a606-e363221db6a1@amd.com>
 <CY5PR12MB63693EB274BB3A16097332AAC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY5PR12MB63693EB274BB3A16097332AAC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 440c0029-ba3e-456b-6b72-08df1eb563d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: l3bLh3+dwngBWEsMKMPd/mknP4CwuuLKeEXXtIYnXhdi93zo9bZ0UXqA+8vUby94vi6ysT8bUAiTBvaGMyWQh9vff/lyD3t9BdMHIKUL9n6EhABeNkpC+4Fj8qi6StLc8lC2IH5ndgMBUBfR1zoHve3jxVTxLH6UsuDG8JYxlK9mhSbtz47JvVlsE1EmTjXawQNgNHShSD0mKUxKISjZAuZOQR1hqhFQ2sqqUe2ot3hbDrEZY0ebJ5Gsq/gelTLyDV9t1ddzR/XT/hi3RdKvMKUWX1ZGyJVBmdql/8cSQH5sHKoSyAi486S0WEgn3gFGKBUmmsRrO+arrk1D9RjnYfvQu1+JYUgGVLCngVSCHQN5xdHqE0aLxRkQpiO+wtFXSwgt6DreHK9WFFF/Ufu2CXF+k16FuhUGpusxK2a25mXfeNwRPBl0E3QDv9D154/IU1A5np5IGtL8IuiZtsuwef6KoWAMEgykzd/uFhgLJp2uNrs0Azc8O5r3R0KeLTsYROA3QqyFyo4w1Sg0AUZGKgSsMmxjV6Dk5PsyP1QYYuuWzgcuPH/HzWmkn3DVa6+hJtUjplxnQz7ehPkwPD4vBOzxABlTBOAoB5HY/vJtoUkIyc9vspkofd2b9o+J8qAGQNCPlrAEbIYxVm1FsMUP9pgh1KFnG0KliNgJ3Tj6te8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1BCOVlUZUpzanJRTHA5Q0hYaFMzcVR2UG9rM092M3UzeEF1bi9pcnVmNkpI?=
 =?utf-8?B?b01qY3BOelF3T0txZm9OeDNmcDBRRnRyQlJ3NnYxNys1U1V5UWR0K0RheGZG?=
 =?utf-8?B?VUVQUHgwNTVuanpwK1lnTFI5aWEwSzZOQ05NQ3hGOHRFeUl6bU5KYXpiWFNM?=
 =?utf-8?B?UFZlNE9mR3orVG44dExucHMxS1F2UnhIL0FGc1FuRVpma3ZZdHozeXY0R0d1?=
 =?utf-8?B?QXVvcTh3N3B6TEpuZlh2NStLTjJaRHBkT3BHSG8yZ0VaaGMxZ2EwTkl2Uzk0?=
 =?utf-8?B?amNVNnNKYTlOOHlzUWRlZEtaOFpDb0ZnNWlrc05neWdvTGlkWmV4WjJJUUtk?=
 =?utf-8?B?VzdYeFFYcWpIMFJ1SUZJcmdRbHBybWd0aWFqV1pDNGFzTEVYU044SnJqcSs1?=
 =?utf-8?B?bHhXdXdjTmdWNUIvVmZ3cjF5cWJyb0lsVTZvTHRBdGRhL25waHBYR0dMQitM?=
 =?utf-8?B?cWtIOHJuNFZrOTRYZ0VtQVk1ZTA4ZHBuZkordWRxRVlXTFp5cDNkSENNenZv?=
 =?utf-8?B?ZlpIMERneDNFd0Z0WnZSVGdvSTZ1L2ltSERTS0VaYWZIMFRzYWJEYjlia0JD?=
 =?utf-8?B?YnhMYlFIV1NWOEhuRzNMcWVJRFRGNmZpTWZiVTBPVUppR2h4WHpLUitacUcz?=
 =?utf-8?B?a2dFVXcwWlhZUzZUVDNnVytGamFmS3E3V0dsMUpWSFlFd3grdVJPL3ZYTEt0?=
 =?utf-8?B?MWpuOVBiT0U0ekRpUmY0UVprdGpQV3pDSkRRcWx2SFlFRHJGdHRyVUZqUEpW?=
 =?utf-8?B?V3JtcFRLSWNLVUczVDJvSXNFR200R01ZYnpyWUlubWpyZGtxdG9SVlFIRVd5?=
 =?utf-8?B?ZmtIeGFZSTY1RlZvVDZPS0JSeWw4SU1YTzVudnhMdlFxZzllZ1pHd08xUkVU?=
 =?utf-8?B?MmhwYmRZOXh1NUFZbURjOTZQV2MvcmF0NjhnNEx6WjVsdVl2RXBqY0xYa0NF?=
 =?utf-8?B?TWVCek1nWWVxdm9nd01hZDNhaGp6VCsrZGlYU3JNMWhDYTRuNys5UlIvNlov?=
 =?utf-8?B?dEZ5NFUxcFAxQ1Q2blFlS2VhbWxQVzZTYis0OVhyQktGR2NHYW94SDBWamJG?=
 =?utf-8?B?QlJUeTRFSzY2Y05WQklQSU9vekpubk5rTDNsYVpHNUQ2S2hmQVRLbDl2SktI?=
 =?utf-8?B?MWZOeEM3SjU1UGJRekRRTUV6RVFWT1NtcUFIUm41Y0plaG01U2p6aXhEaFZm?=
 =?utf-8?B?Qzkwb0Y3MURRd1FENHlDN0xlMVlhTmZIM1dxMG1tZnYxNVRIUkg3QTBOWFUv?=
 =?utf-8?B?Y1ArSVZna1BWL2NPaWh2YnU4TjBrMUNKdTRPNlMvemUwWENZbzhWYjA0NUZR?=
 =?utf-8?B?R0Z1TW1sanlGcjBKZHN2YWpCaWNkN3ByNk1KZEYvWUsrNzdKMDJSYUF6OGF2?=
 =?utf-8?B?WXZuV2lWd0o1RTBaZ3kwbldvbFdBNld2VnAvZGw2MDZFbFZJdTBYU05XOFkw?=
 =?utf-8?B?S2hLbzc0dUMxaWV1bWhKQ3JJRm9BbU8yZ1A1cWxkVDlNcFhQZnZiVGp3eExW?=
 =?utf-8?B?SFRZOTJFU1Nnek9CWlU1dTA0cGRDQkV6ajdLTktJcTVGVkRicmFrTFdGQktG?=
 =?utf-8?B?NHQ2VFlQWG0yYk1UT1VwR0xkRzRqZC9USW9ibnRSb3hyZjhKOHg0WjdGTytN?=
 =?utf-8?B?U3BCbHYwSVAxd2E2bHc5Nks4VjVFM1RwQUN3NUpBcGNld29lVy96YkpXUDBs?=
 =?utf-8?B?MW1FRVVjSE85LzhoaUp1MTVWWmFXNXFHaWJVcTFoOXZ5RFVXbU1Rbk13ajVu?=
 =?utf-8?B?ZkdzOGxrZ3pLdFB5RFErS05FMndON1czSnZHaXdoejg0U0U5N2R2R1hlN0ph?=
 =?utf-8?B?WHVWTjl2a1FOelhCSUZJdVgwWmRXRExjcng2TXIxNGRGbWZFVUVVbys2TDBx?=
 =?utf-8?B?aG9UZmxvekJSdWxQbmtVOHd5UlJIYm0xL2tMRVlZNnZFOEtXekNLYkh3U2pa?=
 =?utf-8?B?QVp4eHNDOUo4M3g1ZnI0MFZScGxEaER0QWovMUdCWkNYNVhtckc3NHVRQWk0?=
 =?utf-8?B?VEFrcGdncmpHYUtpak9XRUNhM0RDaTNSbnNRb0lLUFBWT3VVQzMwMUROc0ts?=
 =?utf-8?B?VWZYYjVNZmR3c0N1cDVSOVlPZTh6dHRObVd1NDBmN2VUb3ZRVnJQTW5zcDN1?=
 =?utf-8?B?VHQxYnpyL05MVG1zdWFPblBQVTNCMVVHcnVIUnVwME10cjY5eFNheVdTUjdn?=
 =?utf-8?B?TVdtbHBWaUVCcVVPUkNvcUR0M2V1bi95RHhxTDlWTTh3Z3M2cThZNTdmNTkv?=
 =?utf-8?B?aytsYnltUnJUNEZnM0Z4L2xyalo5Q1ZXS0ZZSGxYYmcrUW1rRlNlZzBPNVhT?=
 =?utf-8?B?ZjM4V29zNER6bHZEUU5uYXdhNFF3Ti8xb3JJeCttZUlML3VzaUZqdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440c0029-ba3e-456b-6b72-08df1eb563d6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 05:40:52.5629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/XI+FOKuFmhoaFuZMwpEOGHGraizUgQByh36hcZyNWQ0W7c47NtnEeguED27vri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
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

On a second look, the patch doesn't seem right. Reset sequence is 
supposed to be complete by the time FW responds back to the mode-1 reset 
message. During reset sequence, we need Mem space to be enabled to poll 
success status of the message and that's most volatile window during the 
whole sequence.

Disabling the memory space after reset sequence is complete looks to be 
the wrong diagnosis of the issue. Access during reinit sequence after 
reset is safe and shouldn't cause any issue in general.

That said, we should try to resolve the issue without touching any PCI 
config settings. PCI config space is open for others as well.

Thanks,
Lijo

On 30-Sep-26 10:57 AM, Zhang, Yifan wrote:
> AMD General
> 
> How about disable UE during mode1 reset ? E.g.
> 
> Before:
>          pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &saved_devctl);
>          pcie_capability_write_word(pdev, PCI_EXP_DEVCTL,
>                                     saved_devctl & ~PCI_EXP_DEVCTL_URRE);
>          pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK,
>                                        &saved_uemsk);
>          pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK,
>                                         saved_uemsk | PCI_ERR_UNC_UNSUP);
> 
> 
> After:
>          pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK,
>                                         saved_uemsk);
>          pcie_capability_write_word(pdev, PCI_EXP_DEVCTL, saved_devctl);
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, September 30, 2026 11:37 AM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Yuan, Perry <Perry.Yuan@amd.com>
> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset on gfx12
> 
> 
> This is the behaviour of this bit -
> 
>          Memory Space Enable - Controls a Function's response to Memory  Space
> accesses. When this bit is Clear, all received Memory Space accesses are caused to be handled as "Unsupported Requests"
> 
> On AER enabled systems, depending on how the platform is configured to classify the severity of UR errors, that could result in System error.
> 
> On other hand, if you are sure that there is no such access during
> mode-1 reset, we don't need this patch in the first place.
> 
> Thanks,
> Lijo
> 
> 
> On 30-Sep-26 8:53 AM, Zhang, Yifan wrote:
>> AMD General
>>
>> Hi Lijo,
>>
>> Why does clearing PCI_COMMAND_MEMORY cause AER errors on data center GPUs? Are their PCIe BARs still being accessed during a mode1 reset?
>>
>> Best Regards,
>> Yifan
>>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, September 30, 2026 11:06 AM
>> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Yuan, Perry <Perry.Yuan@amd.com>
>> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1
>> reset on gfx12
>>
>> This doesn't work for all (at least on some datacenter GPUs). With AER enabled, this will result in AER errors. Depending on the platform config, some may classify this access as fatal.
>>
>> Thanks,
>> Lijo
>>
>> On 30-Sep-26 8:25 AM, Zhang, Yifan wrote:
>>> Public
>>>
>>>
>>> Hi Alex,
>>>
>>> I think it is reasonable to apply the patch to all ASICs. I will sync
>>> with the hardware team about this change; so far we have only tested
>>> it on Navi31.
>>>
>>> How about adding a common helper and calling it from ASIC-specific
>>> code, starting with Navi31? For example:
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/ drm/amd/amdgpu/amdgpu_device.c
>>>
>>> index b690a07e31ab..075de681ab86 100644
>>>
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>
>>> @@ -4931,6 +4931,28 @@ bool amdgpu_device_should_recover_gpu(struct
>>> amdgpu_device *adev)
>>>
>>>                    return false;
>>>
>>> }
>>>
>>> +void amdgpu_device_mode1_reset_wait(struct amdgpu_device *adev,
>>>
>>> +                                   unsigned int delay_ms)
>>>
>>> +{
>>>
>>> +       u16 saved_cmd, cmd;
>>>
>>> +
>>>
>>> +       pci_read_config_word(adev->pdev, PCI_COMMAND, &saved_cmd);
>>>
>>> +       cmd = saved_cmd & ~PCI_COMMAND_MEMORY;
>>>
>>> +       pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
>>>
>>> +
>>>
>>> +       msleep(delay_ms);
>>>
>>> +
>>>
>>> +       pci_write_config_word(adev->pdev, PCI_COMMAND, saved_cmd);
>>>
>>> +}
>>>
>>> +
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> b/drivers/ gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>
>>> index b250c5e41e45..356e09b7eef9 100644
>>>
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>
>>> @@ -2242,7 +2242,8 @@ int smu_v13_0_mode1_reset(struct smu_context
>>> *smu)
>>>
>>>            ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
>>>
>>>            if (!ret)
>>>
>>> -               msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
>>>
>>> +               amdgpu_device_mode1_reset_wait(smu->adev,
>>>
>>> +
>>> SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
>>>
>>>            return ret;
>>>
>>> }
>>>
>>> Best Regards,
>>>
>>> Yifan
>>>
>>> *From:*Deucher, Alexander <Alexander.Deucher@amd.com>
>>> *Sent:* Wednesday, September 30, 2026 2:59 AM
>>> *To:* Zhang, Yifan <Yifan1.Zhang@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>>> *Cc:* Yuan, Perry <Perry.Yuan@amd.com>
>>> *Subject:* Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
>>> mode1 reset on gfx12
>>>
>>> Public
>>>
>>> I think this should be asic agnostic.  Any asic doing mode1 reset
>>> should do this?
>>>
>>> Alex
>>>
>>> ---------------------------------------------------------------------
>>> -
>>> --
>>>
>>> *From:*Zhang, Yifan <Yifan1.Zhang@amd.com
>>> <mailto:Yifan1.Zhang@amd.com>>
>>> *Sent:* Tuesday, September 29, 2026 5:36 AM
>>> *To:* Koenig, Christian <Christian.Koenig@amd.com
>>> <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org
>>> <mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org
>>> <mailto:amd-gfx@lists.freedesktop.org>>
>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com
>>> <mailto:Alexander.Deucher@amd.com>>; Yuan, Perry <Perry.Yuan@amd.com
>>> <mailto:Perry.Yuan@amd.com>>
>>> *Subject:* RE: [PATCH] amdgpu/pm: block GPU PCI bar access during
>>> mode1 reset on gfx12
>>>
>>> Public
>>>
>>> Hi Christian,
>>>
>>> The no_hw_access flag was first set in commit
>>> 0de604d0357d0d22cbf03af1077d174b641707b6. This was intended to fix
>>> the Mode 1 reset hang, but it proved insufficient.
>>> I think the flag was set in the SMU code so that it would apply only
>>> to
>>> SMU13/14 ASICs, without affecting the Mode 1 reset process on other ASICs.
>>> I’m not sure whether we can drop the no_hw_access flag after
>>> disabling PCI_COMMAND_MEMORY. The PCI hang occurs intermittently, so
>>> we may need another round of stress testing to confirm that the flag
>>> is no longer needed. Should we remove no_hw_access in a separate patch?
>>>
>>> Best Regards,
>>> Yifan
>>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com
>>> <mailto:Christian.Koenig@amd.com>>
>>> Sent: Tuesday, September 29, 2026 5:06 PM
>>> To: Zhang, Yifan <Yifan1.Zhang@amd.com
>>> <mailto:Yifan1.Zhang@amd.com>>; amd-gfx@lists.freedesktop.org
>>> <mailto:amd-gfx@lists.freedesktop.org>
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com
>>> <mailto:Alexander.Deucher@amd.com>>; Yuan, Perry <Perry.Yuan@amd.com
>>> <mailto:Perry.Yuan@amd.com>>
>>> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1
>>> reset on gfx12
>>>
>>> On 9/29/26 04:25, Yifan Zhang wrote:
>>>> block GPU PCI bar access during mode1 reset on gfx12, to resolve the
>>>> random mode1 reset hang issue.
>>>
>>> Interesting idea, that is much simpler than trying to mess with CPU
>>> page tables in the GPU reset path.
>>>
>>> The only downside I can see is that we now drop VRAM and doorbell
>>> writes, but I think that won't matter since VRAM is lost by a mode1
>>> reset anyway.
>>>
>>> MMIO writes are dropped as well which means that we can also drop the
>>> no_hw_access flag.
>>>
>>> And BTW the SMU code should absolutely *NOT* touch that no_hw_access
>>> flag in any way. Who added that there?
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com
>>>> <mailto:yifan1.zhang@amd.com>>
>>>> ---
>>>>    .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 29
>>>> ++++++++++++-------
>>>>    1 file changed, 19 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>>> index 072d9c4e202d..25b9085ead71 100644
>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>>>> @@ -2078,21 +2078,30 @@ static int smu_v14_0_2_set_df_cstate(struct
>>>> smu_context *smu,
>>>>
>>>>    static int smu_v14_0_2_mode1_reset(struct smu_context *smu)  {
>>>> +     struct amdgpu_device *adev = smu->adev;
>>>> +     u16 saved_cmd, cmd;
>>>>         int ret = 0;
>>>>
>>>>         ret = smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset);
>>>> -     if (!ret) {
>>>> -             if (amdgpu_emu_mode == 1) {
>>>> -                     msleep(50000);
>>>> -             } else {
>>>> -                     /* disable mmio access while doing mode 1
>>>> reset*/
>>>> -                     smu->adev->no_hw_access = true;
>>>> -                     /* ensure no_hw_access is globally visible
>>>> before any MMIO */
>>>> -                     smp_mb();
>>>> -                     msleep(1000);
>>>> -             }
>>>> +     if (ret)
>>>> +             return ret;
>>>> +
>>>> +     pci_read_config_word(adev->pdev, PCI_COMMAND, &saved_cmd);
>>>> +     cmd = saved_cmd & ~PCI_COMMAND_MEMORY;
>>>> +     pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
>>>> +
>>>> +     if (amdgpu_emu_mode == 1) {
>>>> +             msleep(50000);
>>>> +     } else {
>>>> +             /* disable mmio access while doing mode 1 reset*/
>>>> +             smu->adev->no_hw_access = true;
>>>> +             /* ensure no_hw_access is globally visible before any
>>>> +MMIO */
>>>> +             smp_mb();
>>>> +             msleep(1000);
>>>>         }
>>>>
>>>> +     pci_write_config_word(adev->pdev, PCI_COMMAND, saved_cmd);
>>>> +
>>>>         return ret;
>>>>    }
>>>>
>>>
>>
> 

