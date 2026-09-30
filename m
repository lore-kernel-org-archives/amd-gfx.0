Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB56FCA5FB1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 11:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FAA010F309;
	Wed, 30 Sep 2026 11:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zf/562kX";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE9710F309
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 11:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVc0w/yV3y2W/EfVTVFT3EGnVex5I01oEHTRSlzgbNVcGu9UQi4vb0tcYGHOXLZHA/0ZW+IbYIrrGeuiblPAlgQaGP9cobVCgmB+CAsWvWx/peXSpu83LkQbfWfm1Wv3aHl6GLBc2RiFJBXyZS8wGSB212S49F+a3qJyXGctZeMR+uNd7SxZ+uftQZ9fgq+wU3baQY7cauBe3b2cHmyCOr7t+9S0EDJ7NazcFVZRbh9vFJub8n/DaFDiXxcXkFLhftDh+z+7LhUTITs5A10PzJeOSxdfxwec6c1Rrrf+gheBY7MhSHKeEgVxwaEBxMmOfikh2o5OEvsc5g+sCQq28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGHmDHvDbpYVoKl95fwm4KFSRH+nSK6ISoU7D9oNj/k=;
 b=RYA6hkkG4w3FntiYuQ87dMUWvZwSae9ZAZcM9DKn+FU7Qt98ApugN9ts0vYE+tVkS0GpscFv+rXBIeGfA21Xvl1QOmP1Wl5DoHSt8yrQPG5TsvoLeZ0McOd6MeDXjzqOMQa/pNib5wGaRrWMKONuCQYCtIDZM/k2QTvRx6Jh/XMerhN2Kn5IJX+T2H9ciDpntbYmSjRbGVkSXfN4CY8I7+9Rw28d7ExRpcKvsQNUr4Av8P+umur8Vi6PJys89Q20JY2Fvv5KvlrE29jFUAozm2ZsrhoUmnTaiHhYSrjmrjjZPDljSRizU5fZ+p1mCZR2HGTSCdLnyvIPxBHuIqqPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGHmDHvDbpYVoKl95fwm4KFSRH+nSK6ISoU7D9oNj/k=;
 b=Zf/562kXSxnrMNwh3C3cadlWAkFEhM2PZXwXp8dSCz3RuDG5P1LP5v6vddxBtAKDUBUWfIhuHW/zGFjGxOt4TrO9vpMSs1IPP12ZZq8ObwzHzNdmxhrGkTGT6DF8GmQHO6tKlMI95azsr43VNtHCGPIylBJ7R2LEKV5OQw5eE/M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 11:41:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 11:41:36 +0000
Message-ID: <0e990a33-7251-4c96-b52d-e87f924eee99@amd.com>
Date: Wed, 30 Sep 2026 13:41:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: move vmid_mask_gfxhub/vmid_mask_mmhub to
 vm_manager
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Ma Bing <Bing.Ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260930111601.3721001-1-sunil.khatri@amd.com>
 <2873ad31-7fd9-4fcd-96fa-7f4fff1c1934@amd.com>
 <8939b352-899f-4327-a8ed-26e12e3b6c39@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <8939b352-899f-4327-a8ed-26e12e3b6c39@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL3PR12MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: b13c2403-76d5-46e0-251a-08df1ee7c87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gqRKOl0hiOOygEHHRKDXZ+WqIxVlo0g/d9AqLO4FK/hgIYMALq2XUt0y4EzKip4NX3EFwlki0UZ5O7ZPC/Wjl6eiVtEEJtEiQh5L/a4lq3HT8QbEiBymtAQsI/+Hgc/Dd8kqU3dvqcw0nfJYw0FR59cG82SYNzvx5TN85QH4rfT3TqpwXmF4+UnIGHE5r1KkEESq+3Xsnp236IioesynA/Yt2IwKijD7kXFLyihJpmWkhgft6536ZD8bCro4l5cbGjm60Gwzcwfz0RDCyuXJvesg54vehoY4wffJA7B2a6lg5nUuhyY7uYiJ7GShLjNfnJe5rkQkslXnVWHYrTUZLPDHrDIZhMdp/SuGbdf3tPqz9RvQjE4Ay7umbox9IXgTsZ2dMS+ur0xaRO/DS6DxUThKoBMWXn/04TCpYbYMnIX0UzQLKUChenQ4KAX93dbCsb+gAQz3HLf9yzIqKYBHYaaNOUNReW92BrJm0NvCLmL+pblxrui+BMvYLIRd+L5lu1tjoK9AwVOHS8HAfal0WYZfIRdDjH5WTJdxECIcjnzBnNAPgISIxY5Uwp+bP+1VlG9neXf5tOgq5r8CjchXvhClknGHKY0Fg5uwMEhyJxGIpFwwv8IwSALVupzr0w44Ugai59JvZLmQmAvlHmp7DgcGGIFx6U/VdRLWy7Wd4yc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnJuaU1GRHNFNjlWaExOM0tlYkYvcTBEQWowZHREZTFtS2lobTlqSE1tU0E0?=
 =?utf-8?B?ZWsrQ041SmlmdTkyN1R5RlRpWVBpUGwvYVRHMm93cXdmSVF4am42bG5JSlhR?=
 =?utf-8?B?b3BNTGMxZnVKL3RzU0FJL1VLM05SSkFBMUhsZ2thanVhZmpqQ3Q1S0JzalFE?=
 =?utf-8?B?VDYyeUkxN2VpdGFrcjlsRE5sL1BYVWNKRHlmeUdGQzYvZkFZcVlPM1daakpa?=
 =?utf-8?B?Y1dDQzRxdm12bGx1OGdMZytnYm5veVBMNUROM2dCYzdYS0JHNTNJMkM0ZzN5?=
 =?utf-8?B?Yi92Sjg1ZURENXRJVC9YOHh6YUx5ZGNOazRzdnByR0lIdy9SUkxkL2dhVUs2?=
 =?utf-8?B?U3ppY082WlBZMWNSR3dXdzhPVVVUdGlPMk45R0lteGxEdVVtUFJ2VzV3Q1Bk?=
 =?utf-8?B?SmhrMlRsazhRMFBIVkg0Y0IzV2t3azhjRC9TbkNtbTFwLzBIazl0SUZoTm1L?=
 =?utf-8?B?Ujd6aEt2L0l2WTFJL2RxaGhxLzFHMHRQbWhwd1pnUVA2dFFsODdMSDdXVHNW?=
 =?utf-8?B?amJyWlN1R0JRbHFoS1NLSjZ1ZisvNmxIMkQ5dVcxTjFMMndlQUc4YzJ3ZnYx?=
 =?utf-8?B?VHo3Y09UZG9rbWtMK09kVjdpR3R4QmtqcXFkVmxxdGRhdExQTTFTRXp1cCtF?=
 =?utf-8?B?R1Fmd1J6OW1ZWXRlckRHcHJ2Yy9zb1BSSWd1N1kwNnhZM3BZTTdpcHBqM2dM?=
 =?utf-8?B?QUphRllBTlNGKzFyQmZBRHN0RDlTY0tQQW9NaEQ0U1lqK21hK0dxakxIVk1v?=
 =?utf-8?B?Z1ZaUEpGbVRGeUl3ZkJkdEVxUWpUa2VVREhFUENIR1NiamlZbWkrclQwdzVy?=
 =?utf-8?B?SnpoUzFiT1ByN1VKNHJldERHQnU0NzZLOHgyUFhDMlNvMWhvSXcyWFpJOGNH?=
 =?utf-8?B?SzJISnIxYVh0bmVEeEVvMGJvenVEMUR1b1FaUkQyUnhoWFB3bElQdlZGZEI5?=
 =?utf-8?B?SkRqblJOZmdUR3VHU0tLYUVuQVVvVldpWDJwTHlpaG9BeTFmYzlTeDFXU2g2?=
 =?utf-8?B?TkRzbUd6ejVHWEZrZmN3a1dzN2FpaVJwalJRc0VkdWlRMVF1RXJ6Wk0rTW1C?=
 =?utf-8?B?R2hGY2xzWDdIYmZUZ2RQQ2ttMmlWaTNhbDFrSi83NUM0SjBCZnVFMW5sT25r?=
 =?utf-8?B?aVY4S25oMllyeDRFWEMrTi9hbjRJOFdSWWlycmVSTnpNWGFXMlgzL2Z1UFBk?=
 =?utf-8?B?czQvRit3UnUyNkVKV1RjMXpSTXRQaFlNYmt2WUc1MVhZV3R0S3ltODRweHZX?=
 =?utf-8?B?di9MeE1kZmdDSTJBdlFUd01lTWthbjFHTXVpa0EvT3JiTEpKWlB5YldmR1M2?=
 =?utf-8?B?bFJzUlpsemR2Z1lvWXo1MzFHWExka3o5RGN5VjN1T1AxbFl5ZXJOU2tzZ05a?=
 =?utf-8?B?UnhNRVlGbXpubWdJV0pPVUwwSk5SSUtTNExocUNwbG1lRXVRU1ZPTEQ3blRQ?=
 =?utf-8?B?b1VCQ3JwclorN1RRcFZqMERmalNsUm5jcUtRU25NN1VNRlFqMlJMNEV5a3dT?=
 =?utf-8?B?ajJnRlpnaFFMV2I3MVBqR2h0Zk9PS3FqTlh2UFo4b09XdDc4aDJDc2gvTU9M?=
 =?utf-8?B?dVc0M1JVSzBPUkxuTkpDaWtqa2swc3p3SkM0NGdxME0xem15bms3b0hOT0dq?=
 =?utf-8?B?SERvQktnK3F5SDRPbUtNTC90N0E0UWk1THlDa0hEeFkxMDVtaE5sY1JKUFNl?=
 =?utf-8?B?QXU2djFEbVU5QWE5K3hRQWJiVEwwRDFvRW8yWEwxM2NvVEV2RlhjMWNMVXJu?=
 =?utf-8?B?SnQxdnpOUWJPOElYT1JVZGtsT1lmTCtINjJ2YnhDejJBNG1jbFNrUFdIdkow?=
 =?utf-8?B?dE9zdGhSUlBCSzB5YWFXbWg3UzMrSHlqNGxieCtDa3dEcndUbGg4WnQrOWZY?=
 =?utf-8?B?dXhUdlNSM1prM0JYK0J0YVMveSs2bTc4M2tNVHFlMVp6c2NtQ2U0bklEL0FO?=
 =?utf-8?B?eEJFRWp1TmRSZGdhckd2Qm03VU85VGRMd2s2Ymg0VkZhaUM3TnI3a0dTeTJW?=
 =?utf-8?B?L1FlMmt1Y2RRNSt0cTJHY2VDakJGVmt6dnJNcHROaWZRZzhycW5rNU1QMHNr?=
 =?utf-8?B?dFZjSit3LzV4L0x2dFZPRkMybW9qUTEwL0p2SEx3Y2JpQmdKMDYvRjJTV21L?=
 =?utf-8?B?WmZsKy9zem1xQXRiYy9sbU5HV3kxRU1VMjA0V2xxKzBGaUpTeTc3TmE1TkFP?=
 =?utf-8?B?b2sveUJjNUdXVStjK2NTVHNvZ2JGalBEN1lvWTlhRHUwRk5ZWnRINWt3NjNG?=
 =?utf-8?B?VVNCamZQNkNZUU9seGpKa1NRbUdidWRhTDhtbkdydG5xUW1MbU1TbWljZGhR?=
 =?utf-8?Q?gSxb03FrkWdPXtSWji?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13c2403-76d5-46e0-251a-08df1ee7c87d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:41:36.3012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 521I/Obup1fpJ6IVdvFFD0M7d+PdWreknbAoZxxyPR31rfF1sCI4lr7aRNm2mbOv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404
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

On 9/30/26 13:35, Khatri, Sunil wrote:
> 
> On 30-09-2026 05:01 pm, Christian König wrote:
>> On 9/30/26 13:16, Sunil Khatri wrote:
>>> vmid_mask_gfxhub/vmid_mask_mmhub makes more sense logically in
>>> vm_manager than the mes ip struct.
>> That's the VMID mask for the user queues, so I would name it vmid_mask_uq_gfxhub/vmid_mask_uq_mmhub.
>>
>> Apart from that looks good to me.
> Noted. Another point here if that is the case then should i change that in MES HW layer too..
> unionMESAPI_SET_HW_RESOURCES{
>         struct{
>                 unionMES_API_HEADER   header;
>                 uint32_t               vmid_mask_mmhub;
>                 uint32_t               vmid_mask_gfxhub;
> 
> Should i update here too or this is fine ??

No, that is fine. The MES handles only user queues here so that is unambious.

But thinking more about it, we should also do a bunch of more cleanups.

The structure amdgpu_vmid_mgr is really the per VMHUB structure for example.

And the vmid_mask in the that structure is really the mask of VMIDs used by kernel queues.

We should probably name that structure and the field more appropriate.

Regards,
Christian.

> 
> Regards
> Sunil Khatri
> 
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 8 ++++----
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 --
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 4 ++++
>>>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 4 ++--
>>>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 4 ++--
>>>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 4 ++--
>>>  6 files changed, 14 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> index 5285c1d1fd4cb..9c36ccf5d5659 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> @@ -137,8 +137,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>>  	total_vmid_mask = (u32)((1UL << 16) - 1);
>>>  	reserved_vmid_mask = (u32)((1UL << adev->vm_manager.first_kfd_vmid) - 1);
>>>  
>>> -	adev->mes.vmid_mask_mmhub = 0xFF00;
>>> -	adev->mes.vmid_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
>>> +	adev->vm_manager.vmid_mask_mmhub = 0xFF00;
>>> +	adev->vm_manager.vmid_mask_gfxhub = total_vmid_mask & ~reserved_vmid_mask;
>>>  
>>>  	num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
>>>  	if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
>>> @@ -184,8 +184,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>>  
>>>  	dev_info(adev->dev,
>>>  			 "MES: vmid_mask_mmhub 0x%08x, vmid_mask_gfxhub 0x%08x\n",
>>> -			 adev->mes.vmid_mask_mmhub,
>>> -			 adev->mes.vmid_mask_gfxhub);
>>> +			 adev->vm_manager.vmid_mask_mmhub,
>>> +			 adev->vm_manager.vmid_mask_gfxhub);
>>>  
>>>  	dev_info(adev->dev,
>>>  			 "MES: gfx_hqd_mask 0x%08x, compute_hqd_mask 0x%08x, sdma_hqd_mask 0x%08x\n",
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> index 594fb817e0a38..2b13a5b375393 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>>> @@ -122,8 +122,6 @@ struct amdgpu_mes {
>>>  	void                            *mqd_backup[AMDGPU_MAX_MES_INST_PIPES];
>>>  	struct amdgpu_irq_src	        irq[AMDGPU_MAX_MES_INST_PIPES];
>>>  
>>> -	uint32_t                        vmid_mask_gfxhub;
>>> -	uint32_t                        vmid_mask_mmhub;
>>>  	uint32_t                        gfx_hqd_mask[AMDGPU_MES_MAX_GFX_PIPES];
>>>  	uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
>>>  	uint32_t                        sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES];
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 98cdd7e3475fb..5f22c146e2339 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -413,6 +413,10 @@ struct amdgpu_vm_manager {
>>>  	/* Global registration of recent page fault information */
>>>  	struct amdgpu_vm_fault_info	fault_info;
>>>  	unsigned int				npa_vmid;
>>> +
>>> +	/* VMID masks for GFXHUB and MMHUB */
>>> +	uint32_t                        vmid_mask_gfxhub;
>>> +	uint32_t                        vmid_mask_mmhub;
>>>  };
>>>  
>>>  struct amdgpu_bo_va_mapping;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> index d1cd665ab301c..178ef8dfe6d61 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>>> @@ -1080,8 +1080,8 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
>>>  	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC;
>>>  	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>>>  
>>> -	mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
>>> -	mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
>>> +	mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_mask_mmhub;
>>> +	mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_mask_gfxhub;
>>>  	mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>>>  	mes_set_hw_res_pkt.paging_vmid = 0;
>>>  	mes_set_hw_res_pkt.g_sch_ctx_gpu_mc_ptr = mes->sch_ctx_gpu_addr[0];
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>> index c0719d8fa63e9..f2dd4323ffd3e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
>>> @@ -1042,8 +1042,8 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
>>>  	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>>>  
>>>  	if (pipe == AMDGPU_MES_SCHED_PIPE) {
>>> -		mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
>>> -		mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
>>> +		mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_mask_mmhub;
>>> +		mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_mask_gfxhub;
>>>  		mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>>>  		mes_set_hw_res_pkt.paging_vmid = 0;
>>>  
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>>> index 20159fb9d6ea3..c3e1f9a746ce0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
>>> @@ -685,8 +685,8 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
>>>  	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
>>>  
>>>  	if (pipe == AMDGPU_MES_SCHED_PIPE) {
>>> -		mes_set_hw_res_pkt.vmid_mask_mmhub = mes->vmid_mask_mmhub;
>>> -		mes_set_hw_res_pkt.vmid_mask_gfxhub = mes->vmid_mask_gfxhub;
>>> +		mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_mask_mmhub;
>>> +		mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_mask_gfxhub;
>>>  		mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
>>>  		mes_set_hw_res_pkt.paging_vmid = 0;
>>>  

