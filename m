Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E94A606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 01:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oJH0lzsF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B85210F2E0;
	Tue,  3 Nov 2026 01:44:17 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 036AD10F2E0
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 01:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqdweI7qLydWmldkKP6LsrkS62zJtienwfkx7jVdCdHWosgIR0WfQ73RU8gmhxHYYwUdAJoDp2J7M8/TPeyO8RYH72+vxYzJboXyytLNiE6Mm7WTHhNnHkxfdQdQ3R1jyORzzLddWIj+zQYju64Zs6ui6qn1EVNACVFKUzFtol4RY2cC6ybHQU4djiW8yZgTR/gJRN2DYtCpPn+f6nDCnoQ0ZlDSidpPnGSVzFT//oU/MVxCHJQI1mLmXQBTvunPOpR7yQJ0CflmMWHBNnyWfUSenzlBTelXq0TsdJ+Qttt4lGlr6SKz4trksX1nTOY0krBu8WDgcCMfwSqw9XHMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGylOCkJN7YTTMqe9VwWUbwstd0JTL96kzne8yboyxQ=;
 b=Ezv5Kc9tULCUQ3ge3as5gQE7eXWKEn0XLAyzG7+QAZpTVyosJvj0P59N1b7a41WjP1M/XqcXjdwC12vO/bmsPLLBUTk67sWorUCwoHTq60q8fBj6mM4IbfbJXw0h0kD9TJug+IxKUhnd+iOfGhQCfjA0uoSEDi2BwblkPfXzEHkesnKRkIE1dlczgd+6xk82jxyFYswBGv3686/R+9hJOnlLJLlFMUMC8T6cSgmt+98zhyf5B5jR8kgKKm4IWq+J/5qzSpUmBEsNqfALozRcy+ztuSE+CGkW2V2fXyeH2ZM1lesyHt1u8PZajV1ct7pwL4e/UVHZuMPfky//0db4YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGylOCkJN7YTTMqe9VwWUbwstd0JTL96kzne8yboyxQ=;
 b=oJH0lzsF1BglYz1NYZmkZswEUW1oLUiq+ATAJx+i0wSMLdhDaw3FFTjj38AOKOT3khQusZ6ABpyFvp6UHgt3rVKqdlPfFIV69OlCnRVuuCbyHBIR/Zc182Ud0aQYiwEmnZoYUZ2Mb/c6143G/SXV/fUCxTqUItQZ8QJjpcJJwiE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB504406.namprd12.prod.outlook.com
 (2603:10b6:610:34b::7) by SA1PR12MB9002.namprd12.prod.outlook.com
 (2603:10b6:806:38b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 01:44:06 +0000
Received: from CH3PR12MB504406.namprd12.prod.outlook.com
 ([fe80::570c:1c4d:5cd:97f7]) by CH3PR12MB504406.namprd12.prod.outlook.com
 ([fe80::570c:1c4d:5cd:97f7%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 01:44:06 +0000
Message-ID: <2b361291-a50f-4ca8-b2f4-ccefc60b5fc0@amd.com>
Date: Tue, 3 Nov 2026 09:44:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Correct hung queue number for reset
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20261022014728.84081-1-amber.lin@amd.com>
 <20261022014728.84081-4-amber.lin@amd.com>
 <CADnq5_OhOCymFFs8oiZPGTjq8dJFx16PCA2aZ=yUnAnshS9aGw@mail.gmail.com>
 <CH3PR12MB50440642D2F50DC54E37A1EB54E1642@CH3PR12MB504406.namprd12.prod.outlook.com>
 <CADnq5_Mp30K1eU+oOifCubMLb=phKbZU21WxXSs5YreSdS-1jQ@mail.gmail.com>
Content-Language: en-US
From: "Lin, Amber" <amber.lin@amd.com>
In-Reply-To: <CADnq5_Mp30K1eU+oOifCubMLb=phKbZU21WxXSs5YreSdS-1jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0059.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::12) To CH3PR12MB504406.namprd12.prod.outlook.com
 (2603:10b6:610:34b::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB504406:EE_|SA1PR12MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 41cd7930-d605-450c-6857-08df394bf219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003|10063799003;
X-Microsoft-Antispam-Message-Info: VGRRXsLc1YmdMLAo7dvDx3KGx7L6HLbEDErKPPOXXx9G1Q9HD/4sQZR0nP8ygqYkt6AIrn0AhTMyKGLUy+/qD8DFMN62ZPtTQBbv7ER2R4Mal2FWd2X/eZ79l68uQL6LZuSGaSVEmaBjANTeHwFaN5Y+hpiHmZPN3ejNT+MYNCKDHB540wcQpmkL6CEpZlGIDXsT3YWDerenlf1OkJbwHVxg3IZs38u2VM4PT6i8bS5zaZctfem3G+lmGZEk6jMXuNxp48Ls6htWFxwzRJWwfLbamnTT8BKDWLhTOLdR07UyXifQFP2DRxegm5J1hxuzTn+VHXbHoA3Qtz+jJMDDReaWno2/Emt9KvPZnbm73bi/7Ccp50AzXTpo35cyoCQl0eTLJknNlOVahS6P9KBV8Ngi/4fNNvPCv2Rj/rYm520GSUwigktyaPmU+bQPllm6cJFQYJuqHB5wefYDlxpsx7GFqK+GG3xXl/mDwM4TvEvp5r1B2tJQ478ZwSgCqpTnD/teB7hReHWeszWcXtDZCzc5ENlj0HF4PYDdov0pbBDHjTA+opWMdSKfHg7R0XRKulSny4NpE3xELX32ZOJHSAauZNEYrWQPx9pPwzfAtAEbpow2YICI+WGs7B5avj4OdSK9NwHlVH594cFNL2pHvTa/Gair++P6ILV/ZdsItrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB504406.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(10063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnptY0hkTnFyZm10Z2M1eUdKVEZ4ekl2dUdnM21PZXVpNENoUEJDQTA0WFNC?=
 =?utf-8?B?bmZpd0RoUkQwcHpueXJXTHd3TEpLTXdzRWRxVm1aYU92SlJHZFRZWFR3L3JN?=
 =?utf-8?B?ZGtaQk5qR0Y0QnBCTWNESGswNTZMc1VSYll0b09GNFRVMDRaMzVMbEM5T1Jn?=
 =?utf-8?B?Z1ltQkM3ZjRYWEc0bUVGRzBmd2ZFT29SaFNOQXczUXhHTU1VZ0cyM3J5ODJW?=
 =?utf-8?B?R1J1MG5PSlVJZTFzcGY4TWNiNFdNZndjenMySjR5TTVRWWpER1JDU2RXRk1j?=
 =?utf-8?B?Qmo3ejkvQTRYdDI2OFovWC9aUHBKTmdneVVTVjR3YkNNaVJBd3BvKzREbURL?=
 =?utf-8?B?aGk1RktqRHVvYzdybWU3VmdibC80VFFya1REd2tpSHFFM2RWSzNtM0l4TTRZ?=
 =?utf-8?B?Z29Ua0FuQVF1NlErZlNBcXBOSC9RSktmZmxhMjdBRzZveTgvU3pzNHVxQ3Ju?=
 =?utf-8?B?Uyt2bWhJN2pDUXVIZkh5Q1FqS0lxMmlKRThlWVl1NW1JR0F4WGdDTy9Pa1ND?=
 =?utf-8?B?SzBqc1NxNHBnc0RRTHBwblhlNUtDcExjNzlBNUhuWDc2MklWV3p5aGxlNDJ2?=
 =?utf-8?B?cWNDNGdXRkFuc2EycElESU1HbHlqQnBKcG4xR2llRFVud3hQemNMaDcwbUY5?=
 =?utf-8?B?cklFODUwTmFPWGdwNVV6R05WeEh2dWIzRkxhTzhGRW5CSjFnZkFmNmVSYThY?=
 =?utf-8?B?NUY5WVdZRnMwdnhPK0s5eFFtN3lrZncxWnZjQldsZ1NvSG5iVjNYbXZYZVN1?=
 =?utf-8?B?WWVaSnBqby9GZExqQ041ZDgvV1dXcnJDU1VDaU85Q3lCTm0wTXFUMXFsMXND?=
 =?utf-8?B?bFlYYzFoV21PbUdPM3J5bnd2RHUvamdvdDlkRzlzMDlob1hDTXh3WmJHOWlv?=
 =?utf-8?B?OUpReTdkMDFaRnAyR1hXazByZ0dJU2kzOVZCdTZiT0RhK0JWcyszc3IxTm9z?=
 =?utf-8?B?VEJYWnpBK1pwK2dCSUgzN25WRlhnYlFrTXp2SjdDTnQyOVlNR2NNTUpUeEU4?=
 =?utf-8?B?blV3cWI0ZVJhZGZ6SitNRUdMTm92a1ZUSFZ1Q3VUUmVJVnV0dFVKalFOdXJa?=
 =?utf-8?B?d2E2S0s5RTlrQlNLRW1zNWZ1K1ZURUs2clQyWnFJdEFKNGt4YUZoUW84Undz?=
 =?utf-8?B?V2pnQmtqR0x1dnpYWU5YNC9LamY2TXRZZTFPVmVlbUNjU2FrUEd3ejREU1Vh?=
 =?utf-8?B?bWFOc1dMcWNadFcwMkRDN202QllpOW5QZWVoTnN4eG8yTmwrbzduUnRBTDRW?=
 =?utf-8?B?Vi9vM045anVBa1J1cmtMWlZNck1SeUJyN0J0WEMybHZBTjlKMFZHbGQ0Z01F?=
 =?utf-8?B?L2ZHK1RrU2VVb3N0dkkzMGhWM2dzbnhXWmU4d01odjhrbmpuYUNQYSt4ait1?=
 =?utf-8?B?WXE2WWd4OXVjOTV0MDdPRnVUK3NwZkFDVGZkS3pHc05vNmhJMERWZDFhbXB4?=
 =?utf-8?B?NUE0eFlLQ1AwUGY0ejNXektxUHNlSVluUFhOUFV6bTRiTW5OcjdQSlByQ1RF?=
 =?utf-8?B?RTZlcERFQmNDcEp5bTk4N1g2bDNmUzdKQmhjSFlwTTc0S1NYV2NHSnk2alNr?=
 =?utf-8?B?VDlGUGFtdGhIYVovZ29TTTN3Wng5Tzd0cU5wUk5GN200cUFtREdFSGZSTS9x?=
 =?utf-8?B?WXpNQSsyRy91Y3oycE1kcFByaHBHMjZNMjFUM0xuTC9Ucy9SZVdqbXUrM1hh?=
 =?utf-8?B?cjhQSmJCRHM3S0V5NjRPcVUxUVNBYVlJdURMOHdtVFA0cUJUbWUrSDgvaE9j?=
 =?utf-8?B?ZUFLZElIZk9sTmd3NFZPU1BPa3dPVzh0ZzZVSU1Zc1BOSUloRk5kK1dEajNP?=
 =?utf-8?B?V3VGK1NXbHE0c1l0Rk9mbkc1Sm9xeGZWNE9UTytNUzA2MjJEc3I3dnovb0RV?=
 =?utf-8?B?b0VFeWUzNk8wdG5VY0ZWd1paaUc5cHFZUUc5UStoMmtVeUFVeE82dW9ERTlZ?=
 =?utf-8?B?VHQzR1NoUjRIc3lObU1jMUpBeENBb292TXBKc2RJWHRBaVZjNWxUYTdXTTZa?=
 =?utf-8?B?MnlOT2xlS3hRQ3VhQkZVWnQwTERVTUZtMnA1ZHVYMmhCUGZsMk9PY2loY3Qz?=
 =?utf-8?B?NHY3SHAwVEh3M2ZHVEtFdXhsQVAzeklDaHY5NWw5U0RUT3BVQmZZQTNtY0Np?=
 =?utf-8?B?UnhXNzdSUERIMko3SVJzKzExVVN3eG5iakFBVUJNck1ZLzNkdGNmell1aXFU?=
 =?utf-8?B?ME9VTG81QlZxeUJETE1MTEl5eFBzd0FHcDBndlhxdXlqU2h4WEVEWjFpMG9M?=
 =?utf-8?B?WEFwYVRpd3ZabmFZUG82alRtRFloamlFc2VZS0ErWkp5SklvSnhPZTFvM2R0?=
 =?utf-8?Q?1z4vWk1ktk0QRsszJt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cd7930-d605-450c-6857-08df394bf219
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB504406.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 01:44:05.8628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voDDu7JHhWpI9eWErYWcXxBsNoWNOGc+++DVxXsxjCqkE9FGYAgjSP5fxdyfhLFM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/23/2026 9:16 PM, Alex Deucher wrote:
> On Thu, Oct 22, 2026 at 10:20 PM Lin, Amber <Amber.Lin@amd.com> wrote:
>> AMD General
>>
>> Regards,
>> Amber
>>
>> -----Original Message-----
>> From: Alex Deucher <alexdeucher@gmail.com>
>> Sent: Thursday, October 22, 2026 11:40 PM
>> To: Lin, Amber <Amber.Lin@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 3/3] drm/amdgpu: Correct hung queue number for reset
>>
>> On Wed, Oct 21, 2026 at 9:56 PM Amber Lin <amber.lin@amd.com> wrote:
>>>> In an ASIC supporting multi-compute partition, the number of queues
>>>> varies with the compute partition mode. We need to adjust the hqd_info
>>>> offset to get the correct hung queues doorbell offset and hqd_info.
>>>>
>>>> Signed-off-by: Amber Lin <amber.lin@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 54
>>>> +++++++++++++++++--------
>>>>   1 file changed, 37 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> index 58766b27e150..5bcab09b15c6 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>>> @@ -108,6 +108,24 @@ static inline u32 amdgpu_mes_get_hqd_mask(u32
>>>> num_pipe,
>>>>
>>>>   static void amdgpu_mes_userq_notify_unmap_work_handler(struct
>>>> work_struct *work);
>>>>
>>>> +static int get_num_queues_per_xcp(struct amdgpu_device *adev, int
>>>> +num_xcps) {
>>>> +       int i, num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
>>>> +       u32 num_queues = 0;
>>>> +
>>>> +       for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
>>>> +               num_queues += hweight32(adev->mes.gfx_hqd_mask[i]);
>>>> +
>>>> +       for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
>>>> +               num_queues +=
>>>> + hweight32(adev->mes.compute_hqd_mask[i]);
>>>> +
>>>> +       num_xcc /= num_xcps;
>>>> +       for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
>>>> +               num_queues += hweight32(adev->mes.sdma_hqd_mask[i]) *
>>>> + num_xcc;
>>>> +
>>>> +       return num_queues;
>>>> +}
>>>> +
>>>>   int amdgpu_mes_init(struct amdgpu_device *adev)  {
>>>>          int i, r, num_pipes, num_queues = 0; @@ -222,21 +240,18 @@ int
>>>> amdgpu_mes_init(struct amdgpu_device *adev)
>>>>                  goto error_doorbell;
>>>>
>>>>          if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0)) {
>>>> -               /* When queue/pipe reset is done in MES instead of in the
>>>> -                * driver, MES passes hung queues information to the driver in
>>>> -                * hung_queue_hqd_info. Calculate required space to store this
>>>> -                * information.
>>>> +               /* When queue/pipe reset is handled by MES instead of by the
>>>> +                * driver, driver provides the buffer for MES to store the hung
>>>> +                * queues information. Calculate required buffer size, which is
>>>> +                * the number of maximum queues. This number varies with compute
>>>> +                * partition mode. We allocate the biggest size, which is SPX,
>>>> +                * num_xcps = 1.
>>>>                   */
>>>> -               for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
>>>> -                       num_queues += hweight32(adev->mes.gfx_hqd_mask[i]);
>>>> -
>>>> -               for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
>>>> -                       num_queues += hweight32(adev->mes.compute_hqd_mask[i]);
>>>> -
>>>> -               for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
>>>> -                       num_queues += hweight32(adev->mes.sdma_hqd_mask[i]) * num_xcc;
>>>> -
>>>> +               num_queues = get_num_queues_per_xcp(adev, 1);
>>>>                  adev->mes.hung_queue_hqd_info_offset = num_queues;
>>>> +               /* Double num_queues. The first half is to store doorbell offset
>>>> +                * and the second half is to store hqd_info.
>>>> +                */
>>>>                  adev->mes.hung_queue_db_array_size = num_queues * 2;
>>>>          }
>>>>
>>>> @@ -526,8 +541,9 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>>>>                                              uint32_t xcc_id)  {
>>>>          struct mes_detect_and_reset_queue_input input;
>>>> -       u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
>>>> -       int hqd_info_offset = adev->mes.hung_queue_hqd_info_offset, r, i;
>>>> +       u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr[0];
>>> Does mes.hung_queue_db_array_cpu_addr still need to be an array?
>> No, it doesn't need to be an array. Since we guard the access in amdgpu_gfx_mes_reset_compute function and only one XCC can perform detect_and_reset at one time, one hung_queue_db_array is enough. My original series included reverting the patch that added xcc copies of hung_queue_db_array. I was thinking to submit that revert in the next series (clean up), but I can do it in this series too.
> Sure.  Either way.  Might be better to do it now so it doesn't slip
> through the cracks.  Just wanted to make sure I wasn't
> mis-understanding the change.

I sent v2 to address this concern. Would you please review? Thanks

Amber

>> Since we are in this topic, I have a question here. Besides of the xcc copies, amdgpu_mes_init also allocates AMDGPU_MAX_MES_PIPES copies of hung_queue_db_array buffer. Is it required for gfx 10? In gfx11 and after, we only use MES pipe 0 for detect_and_reset so we shouldn't need AMDGPU_MAX_MES_PIPES copies.
> gfx10 doesn't use MES so it shouldn't be an issue.
>
> Alex
>
>>>> +       int hqd_info_offset, r, i;
>>>> +       int num_xcps = 1;
>>>>
>>>>          if (!hung_db_num || !hung_db_array)
>>>>                  return -EINVAL;
>>>> @@ -537,8 +553,12 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>>>>              (queue_type != AMDGPU_RING_TYPE_SDMA))
>>>>                  return -EINVAL;
>>>>
>>>> +       if (adev->xcp_mgr)
>>>> +               num_xcps = adev->xcp_mgr->num_xcps;
>>>> +       hqd_info_offset = get_num_queues_per_xcp(adev, num_xcps);
>>>> +
>>>>          /* Clear the doorbell array before detection */
>>>> -       memset(adev->mes.hung_queue_db_array_cpu_addr[xcc_id], AMDGPU_MES_INVALID_DB_OFFSET,
>>>> +       memset(adev->mes.hung_queue_db_array_cpu_addr[0],
>>>> + AMDGPU_MES_INVALID_DB_OFFSET,
>>>>                  adev->mes.hung_queue_db_array_size * sizeof(u32));
>>>>          input.queue_type = queue_type;
>>>>          input.detect_only = detect_only; @@ -554,7 +574,7 @@ int
>>>> amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>>>>
>>>>          *hung_db_num = 0;
>>>>          /* MES passes hung queues' doorbell to driver */
>>>> -       for (i = 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
>> Can mes.hung_queue_hqd_info_offset be removed after this change?
>>
>> Alex
>>
>>> +       for (i = 0; i < hqd_info_offset; i++) {
>>>                  /* Finding hung queues where db_array[i] is a valid doorbell */
>>>                  if (db_array[i] != AMDGPU_MES_INVALID_DB_OFFSET) {
>>>                          dev_dbg(adev->dev, "MES: hung queue doorbell
>>> 0x%x\n", db_array[i]);
>>> --
>>> 2.43.0
>>>
