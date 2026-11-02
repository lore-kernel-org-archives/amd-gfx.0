Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD27606A324
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Nps+UGP/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FCB610F1D9;
	Mon,  2 Nov 2026 20:09:43 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010047.outbound.protection.outlook.com
 [52.101.193.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A401610F1D9
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 20:09:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvsSBLKY2buw70O6imPIMTEDBnRpcnMnnFQA7zDo/Hc8zKChZZU24yNVaCilMiHs28IzuBetuKQ+oh5ntaKBa4g/pcsoWsQLTCceb11gk+8WvoB721LiKEl6hqUft13cVJZUwDL+NcL7vO8BPVpF+gAxGdYMoBpSl8MeGzq8VTLNM2nhiaZeGt/SNUjDJGmxA0sWW23tBRBqB1i6Yp4AYTr8Jvl1dCNKJYFWHM1sJRimWoR1JKhK0dY1dUnpXNxOnmyMl3jFFoV5VAHRzqpP4PmFEfu7e/Ma1AX8NDYsg1I9xUuNjKl4HS9oZpuj5AKtoOwilfRUdrO07JMMNyvzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOyWHq66c1yTED9YkA4eruWSK8RwlIVB/20nt473En0=;
 b=ohyozBLy4kR1mGpbIpiwYbfq5fzgSz9tCai3k0obbN9k82SYd6jewLpn51ErLFKk4eKwDC+mDlIhl1L2Cd7pmbYW4zRly4pxuxxCHiW0ig3X8BFbZherC0DWQY0lb7yx56YopOgf7b5dbMhPIXlHaSyRoPVtNjM+9BtPoSScoS4qeqhWEAZTx7++JBZlVYQQMbf+KI3Ei4OV1OWBO7/MltFniG2MvnkwLvTiXKahhEbbJgOdId94m6Mab6GlEnhzVw1ysyFlBPzZ0orDFgU3aKjR7C1w1Mq/kRBgNmvBTjKDed/SDADY1oYXibyQBG3eMCjvsS2/7g2G/eCqqNOVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOyWHq66c1yTED9YkA4eruWSK8RwlIVB/20nt473En0=;
 b=Nps+UGP/Iv1XJ+18obSMfIUFL1lHf6J9KHvsiZT/ct31PgUml7I6Zis/yf7lEwGqm1leUGGFoiBb5sVpokViYzVbJGKwvn70lydmZ9Wc2W8o+cWahr1FClZJEfSEHQ4pnOQGvyBUI6UhudLw4xVUl+8AsJ2JWZ+/ZmmXEynpu4g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SJ2PR12MB8806.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 20:09:33 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 20:09:33 +0000
Message-ID: <3d5a7903-367b-42cc-958c-66ff65565194@amd.com>
Date: Mon, 2 Nov 2026 15:09:31 -0500
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
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CHAPR12MB99924757FCFC078459155A971AEF6A2@CHAPR12MB999247.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0328.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::20) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 448f5e9a-63e8-4970-eb8c-08df391d35c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261021123027099003|5023799004|11063799006|4143699003|56012099006|261009223027099003|261028144727099003|261026140227099003|261021121427099003|261026121527099003|261022105027099003|10067099003|22082099003|18002099003|261102123227099003|6133799003;
X-Microsoft-Antispam-Message-Info: xr+Rj7mZu8ZPoXXPbxpzzkvmVs41UJ9ZAoIr01iIz8v4TzEVss00lfCLtpFkl0XJ5xYAY91fgzeipBWNyanwm7V7V4CleWEWCalt9S2xqkbM8SFum52ZyLiv0D43NlcSsdzzmdMddQBonfQmqeRcZ+7vwKZEWhAsFTml0IBJQhq6hijbqgduSyDpwJVaDvlNRxJl4vEeoMtz4URJEFHn7uZ6viHM5k8jmsz9m87kHyxcP1EiUxWcvyn2WSySKgM9+6wStKR+FxRO5bDY7wexHRmHlrbkTGLjxJiXqdZG863766n/OsaoaXQsvNFGdEcK5IjWiV8NcPrGRC/sKfMDXAuWJqJQYEXNZrrIFzLwLshOguVmoR3ENAf7K/a44DfQbBDqzZyrjreFR0u8SVCHevDnAXX5nX0FeCtsxMY0DcgSF86lhBy0JrAo2fzzrXRI+Ods1YTiG1OdP0/tw2OQVgkMIcrV977r9k5wYVYE2A395NG5r0i6e1Qk7GtTa/DvfMY3DZ3ycpgBPowo+al5M1Pcwyz5eB8L+wj1AZUW3Ucgd8ZwCcBm1OZTSX5DQgAzyXD8doh4t0lVPvkRGQBHMubJBRRov+BJxcRzAskRVfCqSIze8o5fLMigAHMbL5D1RO7/VTvJeCNH95TO+2tA5DiBnyrGlf9Zo3+YpiH7KHo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261021123027099003)(5023799004)(11063799006)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261026140227099003)(261021121427099003)(261026121527099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(261102123227099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0pkVzA0bzVsU3lwUDl1MlZaQzVyd3g3c1h6NnF2TFE0TTJwMFQ0cHBCdnJY?=
 =?utf-8?B?eExVWkUwUHZJTTNEMnBZRG80eERwbit5Vjl6WElpUVhidVBGcnJLYXhyUUpt?=
 =?utf-8?B?MzFPU3hnVC9FNmRXMzVrb0tJWTlqWXV3TWp3dktKMmE5aHhMQmRqY0VkcDV3?=
 =?utf-8?B?cVNJTlY4VTRIM00zOW52b1d0U0FNNWxrM2Q2T1dMUTNPeGxZclNkUzBJb0pX?=
 =?utf-8?B?c3ZiT3NxUEZFak5VcUF0S3BOeTlFamFpM1Q1bVYycmlmTXd5WGpzcjFjQmRw?=
 =?utf-8?B?WXgzYkxiSGpYc1J3UmFES1NSRkVPQ3l2bkc5a1o2R0tSMnhLRTVBcnJxUlZa?=
 =?utf-8?B?Y1B4VlZFVFZKdzg5Vm1tekhEZ2d6NmNCSVpZSzlOWWUybjR6VVdjVlNlb0F6?=
 =?utf-8?B?WHBUK0tMZk1zTFFrSGpZZHkzU3pBZkoxTEFKdndhQ0hhMEFpaVRXYmRaenpM?=
 =?utf-8?B?VGpXRndqWTFMUU0zejZSZm1UNCtxM1Ftc3g1Vmsrd0kyWVc2bi8reWduVGVR?=
 =?utf-8?B?bi8vVWxnOHN0WDhHMFowR1FiUVE1eEhPM3d0REVnOUVySW1jU2VVZElVaDBB?=
 =?utf-8?B?dnBvckVWQXI4RWlhb2FVVnpwN2JKZEU1ZzR6bE5RNlpQNDdvL1NnVGV4cVBo?=
 =?utf-8?B?Rk1KTXhKVkQ2dWwyWTk4d0V4OFpQT3ltRHBoSWJMVDEvWFFUa3Q0RzZwVzNx?=
 =?utf-8?B?b2d6TGdmTzJPWUdvOE9jOS9QZE1OZzhjR2ZqOTlBS1hYcENIMHAwTDVSWGtN?=
 =?utf-8?B?NS9Fbi9hOU1TckpXcmYvelczZzhIam9qM3IxaCt5eHdXRWtaRjNiQ043blRF?=
 =?utf-8?B?N2xvM3ppWE43c0I0QlBPaUFEWEU5WGJvamFvb0tkWVdrLzBtRDh2YXA0bVFk?=
 =?utf-8?B?UExobXhWSmN6emcvOVI1VnJkYldwZnJ5TE1NRWE2ZTNaelp6L3dGMlBtTGF3?=
 =?utf-8?B?WkwrS3hnM0RMR3VtMytqRGprc1ZVQ2RtM2dsMjVNQU1maEw0a0MxcnRxQ3l6?=
 =?utf-8?B?cnowbFl4SXdSSlF4Y2kzUGNyZlZHM2g4T2ZIaDRVaFQ1QWVTODY5aUQ1MjU1?=
 =?utf-8?B?YUNxZzRDcWt1WUNNai9XbTlUMTZxQXBGejQxR3NQeWxVdlNsWWlDN2tJUi9P?=
 =?utf-8?B?TGFJd1RuRytxcUNHaE5JeHdDZXlMcHF4THQzWlFhSENvTHVuSmJqVzZyU3lX?=
 =?utf-8?B?eHdzcENwZUd6c0xvd1FTZWpPck1URFlYcGc1VEZJa2lkYnptS2pBazI0YkFQ?=
 =?utf-8?B?UW5jc2F0aG1OdDk1TXlsZWprR2ppY3M3REs2YjRSQVpZNDRHZVR6T2p2NnRT?=
 =?utf-8?B?V0lIb2JKL1c2RnJpalFReTlTODB2aTlYTGFjTzkwUXN1Q1p1SnM5eklJUzM5?=
 =?utf-8?B?SlUydy9Nb1pzcklMaEJVREd2NUZSV3VkWk84NTkvc1RzTDAyT2N5YzdzY0Rt?=
 =?utf-8?B?WWJPcmpETWFxZTRHQ3Izckh0WlU3WkZEQXBvMk5tWFhrUDhzQUVsRTBTaFE5?=
 =?utf-8?B?M09zVUxONG1aRGNVMlptYlg4eUV2UFVtQVpRSUU2RHZoSlpVRno3NlJ3cVkz?=
 =?utf-8?B?ZWlhbkRvZ2RYR1cwd3Iya0FhbXc4ejhybHNxR1JIVm9DN0dnNDRBb2xtRGcz?=
 =?utf-8?B?NnBxUHRxOHd5MWtMeCtmU2ZpVGVHcjc5Z3EyVDVVTW55YUVKSTlhMStvd0xH?=
 =?utf-8?B?ZStwQXVJMWZXSVVheGVaN3JQYWpZTEI4NEZ2U1hSV0Z3NzMxMVVqMjJpbmdj?=
 =?utf-8?B?eVloL1loa3lMUkRjSVdlTUU5NFFtM3pZbjVTNENMM043cUdGd2pYbUZuYWFP?=
 =?utf-8?B?c3RRbG9iQU4wSXBCdUJXM1V5MkJOVkQyT2l0M2xHRnVLSXlHQ056V0lNTnlZ?=
 =?utf-8?B?U2RkTStoZ0xiV0lqVjVjUmdNVGQ4WGhpZndhMUZXUGFoZU1tSmYrQ2FhNjk4?=
 =?utf-8?B?Wi9zWXJuNDNqZGVsZGw3UWZMVTdTdFpQUFVaWXFWdWRxeVhXUDBRays5Rkw0?=
 =?utf-8?B?U0ZEZFEvdDlzNnVlUmROMnQ1SEpSOUY5WHp2VWNsQ1ppK2ZpN0QzM1Y4NnhV?=
 =?utf-8?B?cjJIK3laYmU3SlpUSythMm0vR1VLL3R6RXdNTTF4N0pqeFV0SnFja1JqNVcr?=
 =?utf-8?B?NXduai91bGsrMnFPK3dSUnY5YlFPcEhKbloxdkpJdkxnaXZFYnFWMHc1aVZv?=
 =?utf-8?B?cVQ1NytKcW1PcEEveUx4dDBKb0F1ZVA4TkhPRzMrVXpBeitiblJsOWVibHhR?=
 =?utf-8?B?Q2FmbmFvTkFIQytYS0FEYXRZdkd2UHpaaDkwcFhab1R3a1ErakMwS0VCRE9N?=
 =?utf-8?B?TWpHRlFwUmpnVVBGK0NCK0QwNEVhcFZTU215dG5tZklMeVgrdTdFQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448f5e9a-63e8-4970-eb8c-08df391d35c7
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 20:09:33.0317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AL1Mv3H8fKJO/hPbSsx/R5RLiGFeGXc9s+RMYIGCUJgvzR4QoBHPhDPKeKiWnCaeFNIGPP5fAg/4KPr8XDvkDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806
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

On 2026-11-02 09:39, Francis, David wrote:
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
> A lot of mqd managers don't set mqd->get_checkpoint_info,
> so the ctl_stack_size ends up as 0.
>
> kfd_queue_acquire_buffers requires the ctl_stack_size to be equal to
> topo_dev->node_props.ctl_stack_size anyways, so I think it
> makes sense to default to that value if the input is 0.

I guess get_checkpoint_info is not implemented for GPUs that don't 
allocate the control stack in kernel mode. Either way, the control stack 
ends up being saved or copied into the user mode context save buffer, so 
the control stack contents are saved regardless of the size reported here.

With that in mind, I think your change kind of makes sense. I think the 
cleanest solution would be to just ignore the ctl_stack_size in the 
q_data and always get it from the topo_dev->node_props. You could even 
remove from the q_data completely. It's not needed. Just make sure you 
bump KFD_CRIU_PRIV_VERSION so that restoring an old checkpoint on a new 
driver would fail gracefully.

Then you could also remove all those per-GPU generation 
get_checkpoint_info functions.

Regards,
   Felix


>
> David Francis
>
> ________________________________________
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Friday, October 30, 2026 5:15 PM
> To: Francis, David; amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian
> Subject: Re: [PATCH v2 1/3] drm/amdkfd: Acquire buffers in CRIU queue restore (again)
>
> On 2026-10-30 10:05, David Francis wrote:
>> CRIU queue restore doesn't acquire the bo buffers in the same way
>> normal queue creation does. In normal queue creation, the driver
>> gets an additional reference on the queue's underlying buffers
>> that lasts until the queue is destroyed; this prevents the
>> queue's buffers from being removed from underneath it.
>>
>> Acquire them, but don't get the svm bo. SVM isn't yet fully
>> restored by this point in CRIU and so there's no svm range to get.
>> This will be addressed in the next patch.
>>
>> Signed-off-by: David Francis <David.Francis@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>>    .../amd/amdkfd/kfd_process_queue_manager.c    | 34 +++++++++++++++++--
>>    drivers/gpu/drm/amd/amdkfd/kfd_queue.c        |  8 ++++-
>>    4 files changed, 41 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 6c710e4a5220c..d8233337b8d5e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -433,7 +433,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>>                goto err_bind_process;
>>        }
>>
>> -     err = kfd_queue_acquire_buffers(pdd, &q_properties);
>> +     err = kfd_queue_acquire_buffers(pdd, &q_properties, false);
>>        if (err) {
>>                pr_debug("failed to acquire user queue buffers\n");
>>                goto err_acquire_queue_buf;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index f0ce5fc4a138f..eb4d35a42e917 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -1381,7 +1381,7 @@ void print_queue(struct queue *q);
>>    int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
>>                         u64 expected_size);
>>    void kfd_queue_buffer_put(struct amdgpu_bo **bo);
>> -int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
>> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties, bool is_criu);
>>    int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
>>    void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
>>    int kfd_queue_unref_bo_vas(struct kfd_process_device *pdd,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> index 4c4a3a8587f46..509529af2dc3c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> @@ -985,8 +985,14 @@ int kfd_criu_checkpoint_queues(struct kfd_process *p,
>>    }
>>
>>    static void set_queue_properties_from_criu(struct queue_properties *qp,
>> -                                       struct kfd_criu_queue_priv_data *q_data)
>> +                                        struct kfd_criu_queue_priv_data *q_data,
>> +                                        struct kfd_process_device *pdd)
>>    {
>> +     struct kfd_topology_device *topo_dev;
>> +     uint32_t num_xcc = NUM_XCC(pdd->dev->xcc_mask);
>> +
>> +     topo_dev = kfd_topology_device_by_id(pdd->dev->id);
>> +
>>        qp->is_interop = false;
>>        qp->queue_percent = q_data->q_percent;
>>        qp->priority = q_data->priority;
>> @@ -998,6 +1004,16 @@ static void set_queue_properties_from_criu(struct queue_properties *qp,
>>        qp->eop_ring_buffer_size = q_data->eop_ring_buffer_size;
>>        qp->ctx_save_restore_area_address = q_data->ctx_save_restore_area_address;
>>        qp->ctx_save_restore_area_size = q_data->ctx_save_restore_area_size;
>> +
>> +     if (q_data->type == KFD_QUEUE_TYPE_COMPUTE) {
>> +             if (q_data->ctl_stack_size)
>> +                     qp->ctl_stack_size = q_data->ctl_stack_size / num_xcc;
>> +             else if (topo_dev)
>> +                     qp->ctl_stack_size = topo_dev->node_props.ctl_stack_size;
> I'm curious what this case is needed for. In what circumstances would a
> CRIU checkpoint contain 0 ctl_stack_size? And is that's the case,
> wouldn't that break restore anyway?
>
> Other than that, this patch looks good to me.
>
> Regards,
>     Felix
>
>
>> +     } else {
>> +             qp->ctl_stack_size = q_data->ctl_stack_size;
>> +     }
>> +
>>        qp->type = q_data->type;
>>        qp->format = q_data->format;
>>    }
>> @@ -1047,7 +1063,13 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>>        }
>>
>>        memset(&qp, 0, sizeof(qp));
>> -     set_queue_properties_from_criu(&qp, q_data);
>> +     set_queue_properties_from_criu(&qp, q_data, pdd);
>> +
>> +     if (q_data->type == KFD_QUEUE_TYPE_COMPUTE && !qp.ctl_stack_size) {
>> +             pr_err("Failed to determine ctl_stack_size for compute queue\n");
>> +             ret = -EINVAL;
>> +             goto exit;
>> +     }
>>
>>        /* Per-XCC control stack size from topology, as create-queue requires */
>>        if (qp.type == KFD_QUEUE_TYPE_COMPUTE && pdd->dev->kfd->cwsr_enabled) {
>> @@ -1095,9 +1117,17 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>>
>>        print_queue_properties(&qp);
>>
>> +     ret = kfd_queue_acquire_buffers(pdd, &qp, true);
>> +     if (ret) {
>> +             pr_err("Failed to acquire user queue buffers err:%d\n", ret);
>> +             goto exit;
>> +     }
>> +
>>        ret = pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data, mqd, ctl_stack, NULL);
>>        if (ret) {
>>                pr_err("Failed to create new queue err:%d\n", ret);
>> +             kfd_queue_unref_bo_vas(pdd, &qp);
>> +             kfd_queue_release_buffers(pdd, &qp);
>>                goto exit;
>>        }
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> index 6010a5d7a7eb9..18d24ddb455eb 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
>> @@ -239,7 +239,7 @@ static void kfd_queue_put_bos(struct queue_properties *properties)
>>        kfd_queue_buffer_put(&properties->cwsr_bo);
>>    }
>>
>> -int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
>> +int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties, bool is_criu)
>>    {
>>        struct kfd_topology_device *topo_dev;
>>        u64 expected_queue_size;
>> @@ -334,6 +334,12 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>>
>>        amdgpu_bo_unreserve(vm->root.bo);
>>
>> +     /* CRIU svm buffers are restored at a later stage than queues. They'll be in
>> +      * before the queue is actually used, so no risk here
>> +      */
>> +     if (is_criu)
>> +             return 0;
>> +
>>        err = kfd_queue_buffer_svm_get(pdd, properties->ctx_save_restore_area_address,
>>                                       total_cwsr_size);
>>        if (err)
