Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC7DC88E77
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 13:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB9EC10E3B4;
	Wed, 16 Sep 2026 13:55:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Na+maJc/";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012051.outbound.protection.outlook.com
 [40.93.195.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2145410E3B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 13:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZGY5aPrSaZAU/SvVSQfK7h1xeV5BaTaypx71sNKBzKD7BO3NKLwl/wiruUkVIDPXsrmzwOh4bpN3Ndt7yQ3G2iB0+/MHCcsI4s34QEvwvxCz3sdleqJP3zZ/XUMXxkdVgbDNg3t1VgynXvauTEIJDdTVl7DNSlg6UHA9Rix2OFt31PmCvF6lQofI1lIJDmYWpivOBFQrBG8Gp0NK+576mzVUpH5zMRCDe3GnMtBfjKECHNlOT+on33P0xDYlr7uLJnavbO+Woru3MUd+3NLvPXA7WRg+2R967H5JZCtLeAgTNlbT7JePpqL4AlxocnShWZA+JRFJeCBqkoVx98VOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQ8Dr/prBBevRRRq5OGCjxp5c/6ZcTz2+lI++ENpR9Y=;
 b=QXsc10Zyy1osRLikb6NCmnFVVy9XlbZj/kWxnEzOvREsdfGNQRob0GgqmRVTnsg7+3pXCtLClPh+vzy+N7YK9m+mZ7vhmq5pDHduga98/wyL+rJ3L3lewhUKT8w4r0u4RLi4rv1mvZvrZsmpnea2yr0Bt7qPDolED2JaR6P5UASHvMSO9TgbvR+W/f+6nY+JEzOvi30EyW3alEvl1YtHRL0nFfZ58IITfcVeRnwVhoAvo+2ONWAfZz9brgSAIXEW+e3RLUew5O8xOCg/g7NZaO01Mqo+Bxasv9WJNNZs0Qxacstq94PBvPHFrsaIPDUqEwv15MSbA+Ykum/oDhEicw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQ8Dr/prBBevRRRq5OGCjxp5c/6ZcTz2+lI++ENpR9Y=;
 b=Na+maJc/hOrtnIEhkczzsr6ySw5t24IeUiy+1VcIrMeXVy1IwwsUoJC1GH66o879p5EC3/1pHSETYRHumzebok99ZjsO9ptdLjJj6hu1it7wUA7Vk9s8BWXn11Wj/eYJknGhW7wNd3VQmwYiP1j5U3D6WUf2YgtxkaRUnDbbgis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 13:55:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 13:55:54 +0000
Message-ID: <43e91c31-ace4-437e-afae-26297102176d@amd.com>
Date: Wed, 16 Sep 2026 15:55:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] drm/amdgpu: mark queue and process as guilty for
 hung user queue
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
References: <20260915071946.710846-1-Prike.Liang@amd.com>
 <20260915071946.710846-5-Prike.Liang@amd.com>
 <633738ea-bde0-4658-83e7-9cdf0f47c2e5@amd.com>
 <DS7PR12MB6005BB1C3565E77FA94DD005FBB92@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005BB1C3565E77FA94DD005FBB92@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0322.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: e688e087-134c-4a9f-2940-08df13fa39db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gpBQRqBdeOSD3yQ4JtrUiaSrgA2m1N0EJR7YFEM1NiPRaduorX3BIngeH0A2dVz+ELZbzVtnumvfJinwlPXlGzLfJMMyzx/qdMs8HzvAEatf6pV5NL/++MLaE8YL8lol6f9nKXuba3yygRFsyETGgki6YOqSzKWU8CpnoTqIPROG70VQSdnGJXjPspG2hqwr+k/La4ar+D/S5UnJXRdBnYmCFjk5E3DIrC0oTvjCMaN4xSlkaGgFbxueOf3/lv9cuuI3/z73Z2YeI29AAbi7IDhxMyG32rNCwlN85zt11Lf000BxGP9oF0Ugnel8W3D63RNyMHkEopYUkrdvzTDp2DjViWHVW1GHD/PVqaSquzrNv+f86dfqarB/ZkPSpM9pGvZV27jmko08VcjiHmGB8GCfrhFy4AjvTcY7d2EbICTJ0Wgpot8zzYpMIe4DlEnb8hSZnRdKtCIy5YZcm5E4Gy46WRiMg9dUmuwDz0INDavZq+ND3MWQXT8HKZ9hXHL8ay9/6hX1KoaHsgFE+/PuqJ8CVB14KuIBVKnWdEU4VRV6hSFik1KJAbvEube9txyNmtZMFDB7P2AFQUBmrlU6qg4vFXu0LxUhnT5cDCx71jfCGFcq+nw6dylSZ5YOchJ0hTFbb3HzIeHBn8KBAd+NPxb8fX+j0iVoFTXoPFR9lKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHBENEpoN0h1dW12TzA4bXBzaXZ1dTRoanBaOW9JNWt5UDkwS0FQQUx5c0Yy?=
 =?utf-8?B?dE1hdW5YWGxGV2g4RWFFYUptNFA4S0xMY1o2cCtkZFpBZ2h4YXNBOVovaHh0?=
 =?utf-8?B?eTk1NjAzb0s3NmVkUjhXMXFWeHd6dHBNN0pzdlFpOFIvbXJ5VXpzRXlxa0V0?=
 =?utf-8?B?TTNKUDQyRURUNUJMYXlUcG8yTktLaWVLTkhYd3llREFEVEV3eUlERzE5RWRZ?=
 =?utf-8?B?MTVzMmZjNVR1QWp6ZCtTa3loQ1hRMzlaOVBpRzZIRVlaTG01dS83LzRXdnJD?=
 =?utf-8?B?WUVJazdydWd2cEg5ZjlUUjAxdUl0VDMwUkhsTHNTbkdSTFIzQVVRQnRIbWdl?=
 =?utf-8?B?TFNFaUxLUm9SOE1MZUx0NVY1R0JXTk5yNkluS1R6eXVOTUlTVXEvM3BzWW5G?=
 =?utf-8?B?bUJ3NzN2aHhZaXpaQWh0TUQwVTFSQjNuZGpCSGtlZ3FwdmlJb1J3TnBCd2pV?=
 =?utf-8?B?U1lpR0E0YzM0YVRlbHVMcUdNdXNOem5RU1kzbG81RG1ZUk1vNlRrMUFSbFFU?=
 =?utf-8?B?bzZXcHBMTFFsL2x4NnJ2eHlkNXR5Vmh5Uyt1dUNPODlqMUZqK0lIaGxhR0FZ?=
 =?utf-8?B?ZDF6d09jNENXQUQ2YjB3bkY5UU8xZnJ4bVpLWXVlalh2K2h0RUtoemUvSVV2?=
 =?utf-8?B?MlppM0t2UGxrZVZIaWt0VmVMa0JLRDdIWkc2OFF3NUhpcnNLeEVHQVlqTWtm?=
 =?utf-8?B?azBUcTdnbitFSDkyMXQ3aEp1bm1VRDBFRTY0dWZlUFlwUzJoc0IrVURBd1lT?=
 =?utf-8?B?M3pkVXF2bnRiMHREMUNCdXlCRUNFNFNGeFVjbGtlWkl2NnBNYnZwWGVHQXJZ?=
 =?utf-8?B?L2h2dkMzaDFoeERoN0ZpTzZjOUtCYlNIVjRZVWUxNUtGVFpvR3BPSVB6blk5?=
 =?utf-8?B?MUpsUWlRZG9VQzRnbmJMbTlraGQvOENvUTdPY2YzNVJMUjQ4MUJUS1NFL3VO?=
 =?utf-8?B?dUJqWVQyTFVpVDRMUzdjaWhieVpvVnJWKzRiZ3dKaEh2cUpRdVRXMVdzdXM4?=
 =?utf-8?B?bmp1OWwxb1crdUpyR1dyNFNqQmxSd05nTGh4RUlOWFdyZTA5ZW1kUGVsVUN5?=
 =?utf-8?B?cjg0MTdOSmJNUjhFeS9OOHZnMHBKVmwyT3Rocnd0TUpjcFE1SE42aytndS9B?=
 =?utf-8?B?eE84b09SNXgwdHN4NzdpZUVQWW1ZcURrZGtZUXhDcFhLOWU2WEVHVGxCSUhw?=
 =?utf-8?B?YWYxZlN4OFhqMy9TR01icEI0MjJCV3JuemM5cExEM0QvUlh3MnNGZFk4cDdh?=
 =?utf-8?B?K0VuRENlVFd1Q3labkJrQXJFb29NWEc4RW1STUlxOU9haEdOSjBPR1RoWTN4?=
 =?utf-8?B?V3ZzR2JFeXU3OXBTeEtLcjZtM1FaZk1pNFNnOWd3MFJkUmdoYUFJYXV1eVIy?=
 =?utf-8?B?Q2NxZ3pFczFXWW0vbGJJQUw1dXZTeEpncTRWc0ova3pjd1haMnUyVnlHU2Nv?=
 =?utf-8?B?L3ZyTDBqeWdKN0FVRkRHWlF1TFhhakIzZ2RRc0x3bjFjMzZSVWduY3NmMlo4?=
 =?utf-8?B?WTBaSE1HTFFRbGMyTmxzWDY4WHpCcHJBWVQ1cFRPcGdHWVk5dUVtcDNqK0NT?=
 =?utf-8?B?UWh6bW5EeTZBdTBucS9xdEpPY0VsS3ZWcXFMZFJSenRzeENNbmExTkJHb0xL?=
 =?utf-8?B?c2luTCtEVHVxeUJLSGJFL2FCdDE1bzhqUSttYmV6Tlk5TnlZdmtIZmpoVWw5?=
 =?utf-8?B?ZStjQ08zcWtKTzEzQnpwS25wNWhvUldkeHVvbzg4alQzNEhhRnFxb0Njb0xi?=
 =?utf-8?B?Z2UwMytFSStlWFQwY3djNGhManV2RGdxdElYcThWVXpLWDQyNWplTVRXUEEz?=
 =?utf-8?B?Q2ZRREZPVEtVK2s5M1pob1R0djRGMXBvZGVrTW1uL3pwcCsxYzAyZXRodXU5?=
 =?utf-8?B?cHJybW1rMUtZUU9Gc1AwSkpqNjFNcVNTa1JBTlZ2Vm1yNEFaNUV2L0RqYm5u?=
 =?utf-8?B?SDQvTlN1UmN6MU1IbmhEVGxpKzlZbjh0VHdpM1dyUlpEOW9HREVjMHJwdi9C?=
 =?utf-8?B?UFVLU3NXdm1nVU1sSnpPZGNDak9NeEpNcUdiallTR0NBYStTL2RsT0dkSFJp?=
 =?utf-8?B?K3R1aWMxRkJ2T25LUlprU1pXUEtpeTduVk45czZNQk5DSks1VWRzRkdsZFF2?=
 =?utf-8?B?WmoxamxyVk1hRzVKQ0hNOWV4S1BYSFRRR1hkMkU3cnE4dEt5Z1dLb25WYmU3?=
 =?utf-8?B?Qmg5Sk54eWY2SGNQb1RDaDdoZy9XZzNQc1d6dEljd2pvMm9kMnNXQll1dWdK?=
 =?utf-8?B?RkxUNmdDb1Q2MU05WTZvdHRsQ1M0bEZJYit4ZnNLRXlYaXlSdzdxdzM0K0lr?=
 =?utf-8?Q?m6ZPhhwRABgeGd/ZrN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e688e087-134c-4a9f-2940-08df13fa39db
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 13:55:54.6964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoVYYl8JO6mZ1UzdkAj1QTJJisCeypp2u+sP8Iw5+8nUqzvmsR4rI/qTuLh6/wuW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226
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

On 9/16/26 05:38, Liang, Prike wrote:
> AMD General
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, September 15, 2026 10:03 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Pelloux-Prayer, Pierre-
>> Eric <Pierre-eric.Pelloux-prayer@amd.com>
>> Subject: Re: [PATCH v2 5/5] drm/amdgpu: mark queue and process as guilty for
>> hung user queue
>>
>> On 9/15/26 09:19, Prike Liang wrote:
>> ...
>>> @@ -132,7 +134,8 @@ struct amdgpu_userq_mgr {
>>>     struct drm_file                 *file;
>>>     struct mutex                    proc_ctx_lock;
>>>     struct amdgpu_userq_obj         proc_ctx_obj;
>>> -
>>> +   /* Set when any queue owned by this process is reset guilty */
>>> +   bool                            guilty;
>>>     bool                            proc_ctx_allocated;
>>>     uint32_t                        proc_ctx_array_index;
>>>     /**
>>
>> Again, clear NAK to having a flag in the queue manager as well.
>>
>> We should not track that here, especially since there is no way to reset it as far as I
>> can see.
> 
> The userq_mgr->guilty was originally added to track VRAM-lost resets through amdgpu_ctx_query2() so userspace could reuse its EGL_EXT_create_context_robustness handling.

Hui? I don't understand what you mean.

amdgpu_ctx_query2() does the VRAM lost tracking through a VM generation check. See this line here:

if (ctx->generation != amdgpu_vm_generation(adev, &fpriv->vm))
	out->state.flags |= AMDGPU_CTX_QUERY2_FLAGS_VRAMLOST;

Why would we need an userq guilty flag for that?

Regards,
Christian.

> If userspace switches to querying user queue status via amdgpu_userq_query_status(), we can drop userq_mgr->guilty and rely directly on AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST for identifying the case of userq vram lost.
> 
> Thanks,
>   Prike
> 
>> Regards,
>> Christian.

