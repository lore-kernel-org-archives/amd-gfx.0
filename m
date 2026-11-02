Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B518D606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 20:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=H0dptwA5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BFF710F1DF;
	Mon,  2 Nov 2026 20:32:01 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B336010F1DF
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 20:31:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXpnmOfWU6hHOTmgQTFvIlFIniQMTCyKMGZAljWPtXCYPZFYc/qd0UwNqjqxS1yg7arSGV1TyeKNZBa2X6J+vFM5gnB/2oeV7SZX/ZJ0I9kW2CUZ7B9x5vUxAnOVzc0shNcCIMcNstfc2MTZViFKez0+hESGjUWFlkFFUNHJfhHD0unLytDpog7NSjHJflblWcgb/BzwOSNnr79KuAK+k3PFiaa4C+D57dCp4dsiw+wY8IQ2ALOXtJMB7tRc4ze2MX4G+BCh9D9toES1gC0jp1gXDNnZXqRp3nJfSNr7KbpBhJ2gExfmixkg7YvJr20UzxgNU71UVRm3K6rIfdZ9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dco3H3cuQfj2E6RewhmtJz7w8txNl2kylCULXicwojY=;
 b=ygrlezPFz+Tz6Q4oS6CCZEzBo40fQUXxge1WlR8YSPbA4RSRnrt47ZiJzoc9UqhyZ1ZuN1G86TxA/QG5/+bFk5Ut8dWTPCfgLDY6LkINOa9p6eoRdO9OvxOmUjBUCRt37t6pJd8gvye50G7IKrAk0cMdOunJFfP0gU205CIVmrNbhWoUToa40qgj5FD1xu8XsRDOVpR1lIoDk6bFzmGbur41HjteVt57X8FO0w4W2mtPVW/qwc4DUd8lHXfCbN3+JusqGYIno7JRKuiykTt331IYFQ/eYrllWtL1bmwiM/fpR0wYBINM/XdATPD3/A6kY/JCkar6AG+l77RrAoen/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dco3H3cuQfj2E6RewhmtJz7w8txNl2kylCULXicwojY=;
 b=H0dptwA5ezvFc4rDobNENM8lzWmkVkLkQFxZQPQDZ1z0tCTC2rf4tiVcn8DY+3D9wor6czksxzV3LGm4oKAS1IPZIM0AkwiSoBhkUBc0dUDInXKpvjGtVh1KZd4kqHgGB0xtAHs7RiQmFIxQ0f+ctn9eqaeNFr2Jawpnbp7eisk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CY8PR12MB7658.namprd12.prod.outlook.com
 (2603:10b6:930:9e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 20:31:51 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 20:31:50 +0000
Message-ID: <77879b29-4676-432c-92d0-30b0d79712d6@amd.com>
Date: Mon, 2 Nov 2026 15:31:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue restore
 (again)
To: "Francis, David" <David.Francis@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20261030140550.2524662-1-David.Francis@amd.com>
 <20261030140550.2524662-2-David.Francis@amd.com>
 <bdbac10b-f1c5-4e3c-9e1d-7694b649c448@amd.com>
 <CHAPR12MB99924757FCFC078459155A971AEF6A2@CHAPR12MB999247.namprd12.prod.outlook.com>
 <3d5a7903-367b-42cc-958c-66ff65565194@amd.com>
 <CHAPR12MB999247AC90D109E731175BB99BEF6A2@CHAPR12MB999247.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CHAPR12MB999247AC90D109E731175BB99BEF6A2@CHAPR12MB999247.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::25) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: f713baa0-00b0-443b-d3c3-08df3920532d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|4143699003|5023799004|56012099006|261009223027099003|261028144727099003|261021121427099003|261022105027099003|261026140227099003|261021123027099003|261026121527099003|261022075727099003|10067099003|18002099003|22082099003|261102123227099003|6133799003;
X-Microsoft-Antispam-Message-Info: Zdrw0S5rP+ow88VMkQYe7IecJtzkG6dGpPzXb4gDscbl4pen0TuIBWJBnIqhqiAjngOraowUkGQlao4OAJ4wB5objW/YIpDdlnM04O0bHqh+Lalt2PT8iBx3XXA4bBNF6J67+cE2KIvzou5qLr6pp5zbT/DTbUcmPMyK9BAgG1b01uGhp2kCZfkgg36Mxc3KqHx28TT8o0kKLIIM7n1O0N74RWTPXHQ40La+XzOT/7Heo+zPkGxvXuPIR2HeHidddhjvQdiq4dE0EMnIy4USOl1Pxr7N4MzQfpCLBHixsb6ZrmJEtGLmscYUozb2+7WcnkMfuwY+R/Efdo695O8YdxvPPyn3m7fDjbGtKNjJfbFlUd6rj/Ybgp6uh+gQEgR0RuHFB1ypzsMzm63iuCnMuyjaITb1UR3XsSuVnPg68VWh0eiW0hlax6hTqRV0DPWW2HWC/+HFSf9nG3V6hd872FAiTwecesGzKszPhSjidMGNg+ceESJJsOby9pm18GMpLTbvPXTL/r18yHuXKVyRE7jAG2yUt235M5A4i+7rV/H7IGvBTXTUxAIzA63LWS1H4sdbN84KZWWdHKAKeVYoIX62o+sHPbYcB8vdcVPYbG03hk/BundtigXZvZGBd9NuuiIMGUT+6sfCFDSBiFCkgAfDOfYMkGB11IWi8lQhyIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(4143699003)(5023799004)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026140227099003)(261021123027099003)(261026121527099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(261102123227099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VC9tak50MlllNGZZVXVlc3BqV1FzbENac1FPdkQvS3BvSWRWVDNWK0piYWFF?=
 =?utf-8?B?SDloWHREMUFHcndITXdMbG0zYjNaODFneE1PZ0R0cWU5YUFCTytmL1dxTUpW?=
 =?utf-8?B?RnJMZVVQQ2p3TTVRbVJZdlJ3dVZkRDFwdWpIQmt2MW1uRlc4emtLcFNneW5C?=
 =?utf-8?B?bFF2bkU1cDdDOU15TWVtSUUydW9zb3cxK09IaFFqUmNYcVJEcTNlR2NGR29z?=
 =?utf-8?B?QU8wTUR2R2gxRkQyTjVtc0J5bW1FTi9yaU9vUjFKdTdvdkt5OXhickdWbDlV?=
 =?utf-8?B?eG1kaklhV28xbGhjVnJ3UWh1eHYrZGtYUDZYR2tEMEtHaFRsSFFjNjYvRy9u?=
 =?utf-8?B?RzRYMElKMVFTeXAvS2cxMTFFWEJUNVp1Q2NTbVlPM1BjS054R1AzSDhyM1VE?=
 =?utf-8?B?ZmlpQzV1dnFCVTVpTXg4WTkyNmlMZXdvbG9UclkvOW1OR1ArY05XVW9yeDZQ?=
 =?utf-8?B?bVhxNWZKWEU5VlBlMVFBMGoycnF2K3ZyRlVwTmRURlY3OUNhQ3FBUjBWRSto?=
 =?utf-8?B?bEI5SXF2TXA0Lytxdkxoak9XVDU0SzN5SGZ2TjZqMEhyaGJGZW5aRFB2WGc2?=
 =?utf-8?B?WXhtcWphalVmQ2s1SFM2T1ZZTkhlTVkrSTM4bXY5TUdTbTc3ZUl3Yk82OG9s?=
 =?utf-8?B?czRSeTM5bStYV21JVkkvclhtZlA0UmNPUmlFbU9pdW1adXRuQTNmcnY5eXB0?=
 =?utf-8?B?aU1udG9DQzExU2ErK0pWakFtQW05bG56bEFiR2w5YmFkOU9RNTBkWUJBMHlX?=
 =?utf-8?B?L2lidWlyLytMejlWbTM5SlZNYkRndWVHRGJYRnlBV2VBTzZpSnkwTTN3TjFI?=
 =?utf-8?B?c1pXMFRMTnFZdGtGenhpWE9kZXB4dDcrSk9xOHFhYUltd00xSURVbDQ4THFZ?=
 =?utf-8?B?MXlmVTRBT2s3Z2lvL3BOMWplaVlxUUpyTFRPRHo4V3dqa0VLVVVVTWpBMXNr?=
 =?utf-8?B?YjJiZzRQaWp2ZW1wSWdnbFJxdW1RYjQyYXAzREFFVUFhelVrWVg4SnI5VU14?=
 =?utf-8?B?ZnpocmRIdWVUOWRFZHFrMW0wRWFjdEpSZE5PQVhCSkgrVXdkSWtaa2FSUmpY?=
 =?utf-8?B?WlRMYnVndW1EUFFMdDNtbFJ3UUxUWFYxR2x0eTFGdG85Y0dkazVvT3hONkg0?=
 =?utf-8?B?eEl5dHFSbncrc3pwWmJKRzkwWkcxMGtSWE0rSE9nakJSd2JKRmF6MWVqYzRy?=
 =?utf-8?B?YVJvNlVPTUZJcDlkNHBoQ2kxQkt1S2hFZWNtamRLWWlLN1M4SlVOdnhzYWE4?=
 =?utf-8?B?ajhIK1R4eUd5OXFUM3NKaXdnY3ZUTnJVNXRaZ3FKN2M5MTdxZ0VmWFR0a0l1?=
 =?utf-8?B?OXM0LzlQQ3VXVzk1NVd3SEpHWXRML1NWTXYzQ2FRZGl4SGh1YzJaWkVZY2Za?=
 =?utf-8?B?L3FFK0UyQ0pkV0JHQkErNnY5QTBhQ3JTV3NweDVnSDVYY3RqbXUzK1dJWEtZ?=
 =?utf-8?B?cVFaVys0WWkzdHkrMW9SUlFvRExpalEvK2pnSTZNQmg5c0p0RGhjM3lVZGoy?=
 =?utf-8?B?OXZ2NzY4UmZNNCs1MEZFZzlwREpIMDd2NVJyYUpnVnAwQ2FSWjArSmxCWFVW?=
 =?utf-8?B?OURrRkdCYmVxZ2lZOWhBMUNEeldDNlNDSzlMbDk5TDNDbXJFRlhnemd5M0RJ?=
 =?utf-8?B?cUQ3dklLaThEeE5hSC82TDduek51ejN5VXJXaTVCbnlXMFV4SXVzTGtEL2lr?=
 =?utf-8?B?TG5FN1YwVDF3WjZmY3ZnNUdkdHk0ZmFDcStZdFg2a2FZKzU4eDRDM1JhQnd0?=
 =?utf-8?B?OFQwOGpNSG5jTURiSEJaWVJDaTJpdFk3a2RmUW92VXBnMGhXSHpLSEg4eGh0?=
 =?utf-8?B?SHp1R09IN1NOV29Sb0Fzd1dXV1lhL0VPelJtZnBwbUMvTm1lbFk1UG1uemxo?=
 =?utf-8?B?Nnk5N2pwanEzaVdEbzdHMjZueTQ3d0x0NTZaYTdabEhwZHFoRElsaEJMWXZh?=
 =?utf-8?B?MWhxWGpIWTY1Ny9zbUxDd0c5aEVLdmtmRjZhQ2YzSU5yQkpRL0pJR1lWQmhn?=
 =?utf-8?B?VEtuZkdzbXZvdE8rZVM4YWZQR2ptMXIwMjdHOE8wS0RmUXR5dXV1bEdTcE9Z?=
 =?utf-8?B?Qmx4clZvNDlsZmNKK1JZaEhNallUSGczeVNHMDJ0UE80Z2lSODB1MlJobzRo?=
 =?utf-8?B?YldQc1dFUm5mT0dXa1U0cEhRbFprUlo0QlkzM2xBNEJ5NFVlK3grdTA2UElN?=
 =?utf-8?B?V2xQdmtYQ2IyTWN2MG5SZGFxazVuNCtvUENyNVJaOUNMU1F3S1lMWU9JUWFM?=
 =?utf-8?B?NWQwb2o4UTRSYnJhNWdJOGQyYW9pNEtzZUJnZkJiTXdmci8wM2xYNUFnME1Z?=
 =?utf-8?B?TEZjV3k2Q0ptMXdOMkpRb0R5eUM3b01rbUU4Qm5KdUFhekpHZmR3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f713baa0-00b0-443b-d3c3-08df3920532d
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 20:31:50.8297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atzvzmWHalr48kpNxdYySh9LQ/70TUcdrWkvpcOCzhW4qKepDXL2Pc+4T+gTU/Pzjcr26RWCebzPlxX6Y29sxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658
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

On 2026-11-02 15:17, Francis, David wrote:
>>>> I'm curious what this case is needed for. In what circumstances would a
>>>> CRIU checkpoint contain 0 ctl_stack_size? And is that's the case,
>>>> wouldn't that break restore anyway?
>>>>
>>> A lot of mqd managers don't set mqd->get_checkpoint_info,
>>> so the ctl_stack_size ends up as 0.
>>>
>>> kfd_queue_acquire_buffers requires the ctl_stack_size to be equal to
>>> topo_dev->node_props.ctl_stack_size anyways, so I think it
>>> makes sense to default to that value if the input is 0.
>> I guess get_checkpoint_info is not implemented for GPUs that don't
>> allocate the control stack in kernel mode. Either way, the control stack
>> ends up being saved or copied into the user mode context save buffer, so
>> the control stack contents are saved regardless of the size reported here.
>>
>> With that in mind, I think your change kind of makes sense. I think the
>> cleanest solution would be to just ignore the ctl_stack_size in the
>> q_data and always get it from the topo_dev->node_props. You could even
>> remove from the q_data completely. It's not needed. Just make sure you
>> bump KFD_CRIU_PRIV_VERSION so that restoring an old checkpoint on a new
>> driver would fail gracefully.
>>
>> Then you could also remove all those per-GPU generation
>> get_checkpoint_info functions.
>>
> I think that cleanup makes sense. Is there any concern about bumping
> the CRIU priv version and creating this incompatibility with old dump files
> when we don't have to? (We could for instance just leave that field as
> padding)

Yeah, I wouldn't consider this an ABI breakage since the private 
checkpoint data is opaque to user mode. I think preserving checkpoint 
viability across driver versions is not a requirement. The version check 
is there to protect against an unlikely scenario. That said, we could 
leave it as padding to avoid the version bump. But that kind of clutter 
can accumulate over time. We'd want to remember to clean it up when we 
need to bump the version for some other reason in the future.

Regards,
   Felix


>
> David Francis
>
> ________________________________________
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Monday, November 2, 2026 3:09 PM
> To: Francis, David; amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian
> Subject: Re: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue restore (again)
>
> On 2026-11-02 09:39, Francis, David wrote:
>>>> +
>>>> +     if (q_data->type == KFD_QUEUE_TYPE_COMPUTE) {
>>>> +             if (q_data->ctl_stack_size)
>>>> +                     qp->ctl_stack_size = q_data->ctl_stack_size / num_xcc;
>>>> +             else if (topo_dev)
>>>> +                     qp->ctl_stack_size = topo_dev->node_props.ctl_stack_size;
>>> I'm curious what this case is needed for. In what circumstances would a
>>> CRIU checkpoint contain 0 ctl_stack_size? And is that's the case,
>>> wouldn't that break restore anyway?
>>>
>> A lot of mqd managers don't set mqd->get_checkpoint_info,
>> so the ctl_stack_size ends up as 0.
>>
>> kfd_queue_acquire_buffers requires the ctl_stack_size to be equal to
>> topo_dev->node_props.ctl_stack_size anyways, so I think it
>> makes sense to default to that value if the input is 0.
> I guess get_checkpoint_info is not implemented for GPUs that don't
> allocate the control stack in kernel mode. Either way, the control stack
> ends up being saved or copied into the user mode context save buffer, so
> the control stack contents are saved regardless of the size reported here.
>
> With that in mind, I think your change kind of makes sense. I think the
> cleanest solution would be to just ignore the ctl_stack_size in the
> q_data and always get it from the topo_dev->node_props. You could even
> remove from the q_data completely. It's not needed. Just make sure you
> bump KFD_CRIU_PRIV_VERSION so that restoring an old checkpoint on a new
> driver would fail gracefully.
>
> Then you could also remove all those per-GPU generation
> get_checkpoint_info functions.
>
> Regards,
>     Felix
>
>
>> David Francis
>>
>> ________________________________________
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Friday, October 30, 2026 5:15 PM
>> To: Francis, David; amd-gfx@lists.freedesktop.org
>> Cc: Koenig, Christian
>> Subject: Re: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue restore (again)
>>
>> On 2026-10-30 10:05, David Francis wrote:
>>> CRIU queue restore doesn't acquire the bo buffers in the same way
>>> normal queue creation does. In normal queue creation, the driver
>>> gets an additional reference on the queue's underlying buffers
>>> that lasts until the queue is destroyed; this prevents the
>>> queue's buffers from being removed from underneath it.
>>>
>>> Acquire them, but don't get the svm bo. SVM isn't yet fully
>>> restored by this point in CRIU and so there's no svm range to get.
>>> This will be addressed in the next patch.
>>>
>>> Signed-off-by: David Francis <David.Francis@amd.com>
>>> ---
>>>     drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
>>>     drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>>>     .../amd/amdkfd/kfd_process_queue_manager.c    | 34 +++++++++++++++++--
>>>     drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  8 ++++-
>>>     4 files changed, 41 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index 6c710e4a5220c..d8233337b8d5e 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -433,7 +433,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>>>                 goto err_bind_process;
>>>         }
>>>
>>> -     err = kfd_queue_acquire_buffers(pdd, &q_properties);
>>> +     err = kfd_queue_acquire_buffers(pdd, &q_properties, false);
>>>         if (err) {
>>>                 pr_debug("failed to acquire user queue buffers\n");
>>>                 goto err_acquire_queue_buf;
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index f0ce5fc4a138f..eb4d35a42e917 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -1381,7 +1381,7 @@ void print_queue(struct queue *q);
>>>     int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
>>>                          u64 expected_size);
>>>     void kfd_queue_buffer_put(struct amdgpu_bo **bo);
>>> -int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
>>> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties, bool is_criu);
>>>     int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
>>>     void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
>>>     int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> index 4c4a3a8587f46..509529af2dc3c 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>> @@ -985,8 +985,14 @@ int kfd_criu_checkpoint_queues(struct kfd_process *p,
>>>     }
>>>
>>>     static void set_queue_properties_from_criu(struct queue_properties *qp,
>>> -                                       struct kfd_criu_queue_priv_data *q_data)
>>> +                                        struct kfd_criu_queue_priv_data *q_data,
>>> +                                        struct kfd_process_device *pdd)
>>>     {
>>> +     struct kfd_topology_device *topo_dev;
>>> +     uint32_t num_xcc = NUM_XCC(pdd->dev->xcc_mask);
>>> +
>>> +     topo_dev = kfd_topology_device_by_id(pdd->dev->id);
>>> +
>>>         qp->is_interop = false;
>>>         qp->queue_percent = q_data->q_percent;
>>>         qp->priority = q_data->priority;
>>> @@ -998,6 +1004,16 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
>>>         qp->eop_ring_buffer_size = q_data->eop_ring_buffer_size;
>>>         qp->ctx_save_restore_area_address = q_data->ctx_save_restore_area_address;
>>>         qp->ctx_save_restore_area_size = q_data->ctx_save_restore_area_size;
>>> +
>>> +     if (q_data->type == KFD_QUEUE_TYPE_COMPUTE) {
>>> +             if (q_data->ctl_stack_size)
>>> +                     qp->ctl_stack_size = q_data->ctl_stack_size / num_xcc;
>>> +             else if (topo_dev)
>>> +                     qp->ctl_stack_size = topo_dev->node_props.ctl_stack_size;
>> I'm curious what this case is needed for. In what circumstances would a
>> CRIU checkpoint contain 0 ctl_stack_size? And is that's the case,
>> wouldn't that break restore anyway?
>>
>> Other than that, this patch looks good to me.
>>
>> Regards,
>>      Felix
>>
>>
>>> +     } else {
>>> +             qp->ctl_stack_size = q_data->ctl_stack_size;
>>> +     }
>>> +
>>>         qp->type = q_data->type;
>>>         qp->format = q_data->format;
>>>     }
>>> @@ -1047,7 +1063,13 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>>>         }
>>>
>>>         memset(&qp, 0, sizeof(qp));
>>> -     set_queue_properties_from_criu(&qp, q_data);
>>> +     set_queue_properties_from_criu(&qp, q_data, pdd);
>>> +
>>> +     if (q_data->type == KFD_QUEUE_TYPE_COMPUTE && !qp.ctl_stack_size) {
>>> +             pr_err("Failed to determine ctl_stack_size for compute queue\n");
>>> +             ret = -EINVAL;
>>> +             goto exit;
>>> +     }
>>>
>>>         /* Per-XCC control stack size from topology, as create-queue requires */
>>>         if (qp.type == KFD_QUEUE_TYPE_COMPUTE && pdd->dev->kfd->cwsr_enabled) {
>>> @@ -1095,9 +1117,17 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>>>
>>>         print_queue_properties(&qp);
>>>
>>> +     ret = kfd_queue_acquire_buffers(pdd, &qp, true);
>>> +     if (ret) {
>>> +             pr_err("Failed to acquire user queue buffers err:%d\n", ret);
>>> +             goto exit;
>>> +     }
>>> +
>>>         ret = pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data, mqd, ctl_stack, NULL);
>>>         if (ret) {
>>>                 pr_err("Failed to create new queue err:%d\n", ret);
>>> +             kfd_queue_unref_bo_vas(pdd, &qp);
>>> +             kfd_queue_release_buffers(pdd, &qp);
>>>                 goto exit;
>>>         }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> index 6010a5d7a7eb9..18d24ddb455eb 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>>> @@ -239,7 +239,7 @@ static void kfd_queue_put_bos(struct queue_properties *properties)
>>>         kfd_queue_buffer_put(&properties->cwsr_bo);
>>>     }
>>>
>>> -int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
>>> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties, bool is_criu)
>>>     {
>>>         struct kfd_topology_device *topo_dev;
>>>         u64 expected_queue_size;
>>> @@ -334,6 +334,12 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>>>
>>>         amdgpu_bo_unreserve(vm->root.bo);
>>>
>>> +     /* CRIU svm buffers are restored at a later stage than queues. They'll be in
>>> +      * before the queue is actually used, so no risk here
>>> +      */
>>> +     if (is_criu)
>>> +             return 0;
>>> +
>>>         err = kfd_queue_buffer_svm_get(pdd, properties->ctx_save_restore_area_address,
>>>                                        total_cwsr_size);
>>>         if (err)
