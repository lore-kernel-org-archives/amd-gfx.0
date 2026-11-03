Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69EF606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VIR6oo4b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 536EB10E7EC;
	Tue,  3 Nov 2026 12:07:39 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3AF710E7EC
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 12:07:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2swoFPjkTDTA2efOvOpnqeVN7UsFnFZkrzyx7Fn9alxma++zogKO6llYPfj44Xg14VPmNY/W4uwN31mU1bUGHkyvJ741ddoX03mkO4OPVu2FThrhmncHSiv5GZMQ8qeT+DYCmmhjgtE+9PJ6ctLQFM6ff3+fDAbnoCjEbvDaip6H6AiLMxtxj1/VPMF+Zzit6aPRw+0ypPG52HX4TJHgU//CEIM9VSndllBRPKNwB7n/ok41jUi2ZmQp5xLSBN2UmBh68QVQFrA6agPkLPMZQ1+ZkfAda6wS+gOYeD8n+ElHartYh9cuNp5IGf3nyKcPg+8Gs6To7qED3PAJ6JO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64PmIpv9kvLcPgLfdg0nr75n+VFT8glTlUBAh0twhaw=;
 b=hNiEp8vhlMINlB68jvB9/ikECqn8VNCzwX+uucNbWvRhSV7SpvIOSwl4ybBqZYv6dZh98EvJrP8H4xmvECOjY92iVeHr82u7TBl9N6Gf7L+UJWZRuR2x5219t/nop0OTzKHyww+zOJ03ZF961jWtZiNB6wYJVGGNcCaGEx7Q9vonp/dt+RUM2JUIgUuYKcpstqns58rYMlHdyOhgnSaPtAcCjYHOckv/mzm8AS767Xn7GDmoFp2V6UfmO0FLHq39rv5TSB+rlIGFfH1iU+a7C/YgnzKAOzeOXSYlzAHiFDfg457cvK5OACZDeYTI0J4ydooYmvQJ3r0NjhizkAj9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64PmIpv9kvLcPgLfdg0nr75n+VFT8glTlUBAh0twhaw=;
 b=VIR6oo4blZPdKUtNkm2UU85gMtBCql6KvZIqZrTKwFbDA6cC3+hKdmtPvR0pZmv4hkb0pT54+cURPceScX8XzryxfLi6sZNVtnnTWic39AZOm8st3UtuPdmhNp0p+prxqERB9/keGWjYWqrDJLxRfxWdCEsldNLLanZD2dzs9IY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 12:07:26 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 12:07:26 +0000
Message-ID: <366f1dfa-5e36-4a84-8c09-fa965456f047@amd.com>
Date: Tue, 3 Nov 2026 17:37:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] drm/amd/pm: restore the forced performance level
 after a reset
To: "Wang, Kevin" <Kevin.Wang@amd.com>, "Hosur, Priya" <Priya.Hosur@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>,
 "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>
References: <cover.1793689935.git.Priya.Hosur@amd.com>
 <f370dc0e7025b9b39cac723b1b60ccbd339d233f.1793689935.git.Priya.Hosur@amd.com>
 <51d3d345-e1f0-48db-af47-de488e428dcf@amd.com>
 <825f3627-cfa4-4da1-8bd5-a53997f72709@amd.com>
 <PHXPR12MB9992558B181231CF0A71FF224093692@PHXPR12MB999255.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PHXPR12MB9992558B181231CF0A71FF224093692@PHXPR12MB999255.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a627e94-e85a-4163-779f-08df39a3063c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|18002099003|261102123227099003|22082099003|56012099006|11063799006|921020|4143699003|261022105027099003|261026121527099003|261022075727099003|261026140227099003|261009221227099003|261009223027099003|261028144727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: ylX8uOxtyo+1CF762xwQQWEXNzYRfhD3ySyVuWi4z+I33pas9oqayEFDZEvte/kaLNGUwO4jBmaF4nlr1FZ6nSeov/fvsmVM0KzkfoA4ZxzYuvVEe6lXLJx9K8gyD91behRrZGhCbizh9itYUq0oAXCE0Qs6vY24Gk2wkOIR/YmlOlPYtLpeFUD2Ksp2CgsHc7+JAy10bSNJyZxLxHLcRbO2BLoyyQJ30RRIVU/YGYfaTEkACGoheuVfyKUTySP9QQ+DvHB+Ypaqwf7TwLhWfGL4RxvHWJcYKJsAVIFuikq6u+l1oa8XfyQT6ip6xoEKy1ksgUnS7cO+ewp7ctmbIcxY1aUtIaw+WYBCsgtn8fERaxRSNBQVmdz0RUlTXJzEJW8Y4KNPcY23LlNm7SDPSXCHyAKBUqTRYFws84HeUoPCBe86qrIRB/QrJcyx9df0i6sKqRPpzEM8GrV5l8VQDS8+eQ7o0tZcFQ/THQVtcxgfZoa9FSVhQS0uUkKaTY5Aw3mBLL+81rc6Bxw9fmQn30RJGODk4APcmxo3vkjsRlu+Yn5ek145QwxpQGuvKwcJPXFackfXoHFNZO90mpOQHqGcAQ6WnqzFLfByUpHaMNr2aVZAaDLf/7AmOZI6sH1PN6gufHXEoDkN8naBUecVUqFK941kC7/SGI7GMk+3nQcJ/am+u15mhct+Etu/UnZosoUhv5D8vN8ryIhs9XQ8mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(18002099003)(261102123227099003)(22082099003)(56012099006)(11063799006)(921020)(4143699003)(261022105027099003)(261026121527099003)(261022075727099003)(261026140227099003)(261009221227099003)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzdWc3FlOTlyU0tFajJBVkdFTGd4VXVOQ3lkNGpOc1RKNmtsRUg3L0QrS2ZT?=
 =?utf-8?B?MjNXM0xRcEtOaWZhRmJLcVJBVkw2anZHUFo0Z1NyOWFmUy9ydmFjWDQxdEZu?=
 =?utf-8?B?Y09FL0lockhXU0YyVWR5cHNLMyszdFhYc0NlYzhoWkRIb1Y2amV2MlNnWVFs?=
 =?utf-8?B?Uk5KRkFLbVBlS1JqWHpDWVp5Y3dFZWpxVll1dElPcit0YitBYVFnaDBaVDQ0?=
 =?utf-8?B?ekk1U0FGQkFKY1FiejdsY3JSUFA4dENJODJGdlJkSm55MUM3dE1KaFRiMERN?=
 =?utf-8?B?M1JOU0U2UktLblJUdnhoS1RXMWdydEdwMENyZ0Zhdm5jeHlvTDhwMndHK2x0?=
 =?utf-8?B?OXZ2N2xZWkRGYjhmOENzRncybi9HOFgwcDZsN2hMbXRWYTF6ZG1xUHR0b293?=
 =?utf-8?B?VFc2TEhHTno0TVRyUDRSNTRDWDJzbVVIU1d6M2tiYWMxbUIzWWV3MG9vcmZj?=
 =?utf-8?B?UzNGMW1oMUR5MDFhZDRRcDVxTWVnOUUrUWNxVWhpYjJWRzZTUXJoUUNUNmZo?=
 =?utf-8?B?OG5qRzFHQ1hWdy84N3pwNHJrYnhKSndnTVNSTS9SRmpzYXVxMGhIaVVuUmtt?=
 =?utf-8?B?eXVJdVZ1UGx2Mk45bHVBK0xWcjZzUWZTL0JVQnRYemgzR1dVUklFS2NtemZi?=
 =?utf-8?B?TVdYOTd3Nmd2MmJNZmF2b1hiSXF1a1dGSXhtazUzNkwyRW5zeXZwNnE1bTJu?=
 =?utf-8?B?dUdKclVEVlZyTHhYdmZkTXBONklDajllaXp3RzRzNllmWFZOR3F2TkFFRmo3?=
 =?utf-8?B?QlBPTGtBWDU5ZFNPQWxwZ3AzME1MeFluTlgzMTJ5Tjg5QlpzWmdGc3NPbVN0?=
 =?utf-8?B?WXZUMEVUTnFqTDU5QXd0WFg5U2ZVSCt5N01vWlBsbEpjcVBQYXpvU3kvUGZv?=
 =?utf-8?B?enU5cU5qZ1ZFRXo2ZFMwRlpmRGhMaE1uajZHMGxwSllOV1FwQUU5NVJ6dktx?=
 =?utf-8?B?RXlJM0ZtVUNFd0c4VkI0ajMvaXZtdzM4aU84VDdZb2NZekhNdG5wZHdONjRv?=
 =?utf-8?B?c1lYdjRQaGQxbzgzaVpyeDNFNWE0eTBiL0xGOXpFbnV2dXhMeWNKOGlCV091?=
 =?utf-8?B?NkR6dC94UzA4NHhveVhQdmZCOHNWTFZML2hoazJ4UUk1Q1JuN09oUVZxTllN?=
 =?utf-8?B?a25keWwvRVNOcitiMDZRa255THlVb2N6ZlhnZDlCcmcwOTIyTU95V2QySmh6?=
 =?utf-8?B?QUtYM1d1N1ZFRVRpSlBsUFlrOHlieVZLaGYyWXViNGZzeTQxa1pzK0Evck9T?=
 =?utf-8?B?K3pLOXlXaTYyNHlVNEdLWDlQeE9xK1hrOGQwUWdVaDh1S21mM0M2Nm1oTnFF?=
 =?utf-8?B?NjFKUmJQeXJDU3Z1THduZWNOemxxTlV3YXFTRFhxTlp4NS8vbnZoSTV4UDJ1?=
 =?utf-8?B?WFRRNklWeCtya085UkZPWjJxWlpTc29rakl2SjJGZmw2aGU1QW9kY3QzS252?=
 =?utf-8?B?ZC8zcm5yYUVCc2l2RVNrRndRUDBpUitYUklDZWpKbFhrZks4Y3lpQmhKTFdN?=
 =?utf-8?B?Y0ZWak9abEZ4YzZaaVNyaEIwcU8vamxoMWtuMlROOFFkd2lndkJlTzJyTnVz?=
 =?utf-8?B?b0ZNU2FvYWdBZ2xocWxNUlR5TDNVSkhNcmpFNkVrUWJBamQvNjg0OUlicjBz?=
 =?utf-8?B?SGE4UmxOS0c1c2VTb01tRHhYRGUvMGpUYUgxSzE5OVozN2dVRjBYWmVucFJy?=
 =?utf-8?B?TG4rSVhlVFY5RXV3dytiNU9lKzkwUjNLdXVHNzRoZnNZWlY1b05lVUVJd1E1?=
 =?utf-8?B?bzRHalJGNmxpNE5JaTBIZ3h5ak1FcnRSS1FqSkxWdnEzcTQvL0V1Tklaa1BE?=
 =?utf-8?B?dldlMFowMjdTWUx3Yng2Z3NMWGM4YzNGMFIrNHhjYkFhczNTOGNXRWNSZDI1?=
 =?utf-8?B?aHBiU1UwVnFHajZzQmFiMVBJWlNkTHBxdSt5aHlOLzkxNE9XVXJGN2NnVkpa?=
 =?utf-8?B?VENiOUV4WldsVHBYekt2bmhMNXNrY2RQVmo1dkVMTGROVk9DcXhCdTEyRVlX?=
 =?utf-8?B?YkNBWldGOUVYWW4xV1gyc0tHSU5FQkNucU1rZTFqUEgvNDdINzR3Z2ZkaVBw?=
 =?utf-8?B?eTRuc3BqS2svYldBUE5hTGNUNUd6K1JzOW5PZS91NmFjSVN3TU5oLzVJenp3?=
 =?utf-8?B?TnJWc3Q1UGoyMy85cE1rZkNHN3BlZUVNMmZuRnB3aDl1N05yL29seXZFTG4r?=
 =?utf-8?B?TStPZ1JQK2ZEb2tGMTRyM0dLeXh4dkd4MnBSam1LWC9oMHp1K0tqeXVNeVpp?=
 =?utf-8?B?YUJiRjFnR0xJZVBUb0tVcm85TklMQjlYUjVIcVpsenZXdFpzYisxRmRSeVU3?=
 =?utf-8?Q?ZNV9sSnMDSnl8N4Kld?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a627e94-e85a-4163-779f-08df39a3063c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 12:07:25.8987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkC4Kdvc4ev8jrTHddvPEldcFtmkMWfxnhUiK8eps1og5zdhE2KLGKSljMBXqGZt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870
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



On 03-Nov-26 5:07 PM, Wang, Kevin wrote:
> AMD General
> 
>    case AMD_PP_TASK_COMPLETE_INIT:
>          if (amdgpu_reset_in_recovery(smu->adev))
>                  ret = smu_reapply_power_state_dynamic(smu, level);
>          else
>                  ret = smu_adjust_power_state_dynamic(smu, level, true,
>                                                       false);
>          break;
> 
> how about use above logic to handle this case? If no concern, the patch is
> 
> Reviewed-by: Kevin Wang <kevin.wang@amd.com>
> 
> Btw, please add 'Fixes' tag in your commit message.
> 

I think it's better to apply it through the common path than keeping two 
different places for restoring perf level.

amdgpu_dpm_reapply_umd_profile() => amdgpu_dpm_reapply_performance_level.

For non-profile levels, it could call reapply directly.

Thanks,
Lijo
> 
> Best Regards,
> Kevin
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, November 3, 2026 6:44 PM
>> To: Hosur, Priya <Priya.Hosur@amd.com>; amd-gfx@lists.freedesktop.org;
>> Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Kevin
>> <Kevin.Wang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;
>> Kuehling, Felix <Felix.Kuehling@amd.com>
>> Cc: Gopalakrishnan, Veerabadhran (Veera)
>> <Veerabadhran.Gopalakrishnan@amd.com>; Vishwakarma, Pratik
>> <Pratik.Vishwakarma@amd.com>
>> Subject: Re: [PATCH v3 1/1] drm/amd/pm: restore the forced performance
>> level after a reset
>>
>>
>>
>> On 03-Nov-26 4:11 PM, Lazar, Lijo wrote:
>>>
>>>
>>> On 03-Nov-26 3:58 PM, Priya Hosur wrote:
>>>> smu_late_init() re-applies the DPM level with
>>>>
>>>>     smu_handle_task(smu, smu->smu_dpm.dpm_level,
>>>> AMD_PP_TASK_COMPLETE_INIT);
>>>>
>>>> but smu_adjust_power_state_dynamic() only programs the hardware
>> when
>>>>
>>>>     if (force_performance_level || smu_dpm_ctx->dpm_level != level)
>>>>
>>>> AMD_PP_TASK_COMPLETE_INIT passes force_performance_level = false
>> and
>>>> smu_dpm_ctx is &smu->smu_dpm, so the level is compared against itself
>>>> and
>>>> smu_asic_set_performance_level() is never called.
>>>>
>>>> PMFW is reinitialised by a reset and comes back on its default curve,
>>>> while smu_dpm.dpm_level still holds the level the user forced. The
>>>> device then runs at the default level while sysfs keeps reporting the
>>>> forced one.
>>>> On an
>>>> SMU 14.0.1 APU gfxclk drops from 2.8GHz to 600MHz while sysfs still
>>>> reports high. Writing the same level again does not help either, as
>>>> amdgpu_dpm_force_performance_level() returns early when the
>> requested
>>>> level matches the cached one.
>>>>
>>>> amdgpu_dpm_reapply_umd_profile() restores the PROFILE_* levels after
>>>> recovery, but returns early for any other level, so high, low and
>>>> manual are left on the PMFW default.
>>>>
>>>> Force the level to be programmed for AMD_PP_TASK_COMPLETE_INIT
>> during
>>>> reset recovery. The cached level is left untouched, so if programming
>>>> fails the level the user asked for is still retained and the failure
>>>> is logged.
>>>>
>>>> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 ++++++-
>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> b/drivers/gpu/
>>>> drm/amd/pm/swsmu/amdgpu_smu.c index a901f8535598..654ff6824fdd
>> 100644
>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>> @@ -2553,7 +2553,12 @@ static int smu_handle_task(struct smu_context
>>>> *smu,
>>>>            ret = smu_adjust_power_state_dynamic(smu, level, false,
>>>> false);
>>>>            break;
>>>>        case AMD_PP_TASK_COMPLETE_INIT:
>>>> -        ret = smu_adjust_power_state_dynamic(smu, level, true,
>>>> false);
>>>> +        /*
>>>> +         * PMFW is reinitialised by a reset, so program the retained
>>>> +         * level again even though it matches the cached one.
>>>> +         */
>>>> +        ret = smu_adjust_power_state_dynamic(smu, level, true,
>>>> +                             amdgpu_reset_in_recovery(smu->adev));
>>>>            break;
>>>
>>> There is already a reapply profile to handle this.
>>>
>>> Does it work if you replace the current
>>> smu_reapply_power_state_dynamic by calling
>> smu_adjust_power_state_dynamic(smu, level, true, true)?
>>>
>>
>> To be clear - replace the logic in the current
>> smu_reapply_power_state_dynamic.
>>
>> Thanks,
>> Lijo
>>> Thanks,
>>> Lijo
>>>
>>>>        case AMD_PP_TASK_READJUST_POWER_STATE:
>>>>            ret = smu_adjust_power_state_dynamic(smu, level, true,
>>>> false);
>>>
> 

