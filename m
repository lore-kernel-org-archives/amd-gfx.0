Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413B606A330
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 02:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=x9LLlChx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077C710F327;
	Tue,  3 Nov 2026 02:53:01 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012065.outbound.protection.outlook.com
 [40.93.195.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A7910F327
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 02:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ea0DtR5/8h3CtRp4+XwdXTkcHPb6drm0YKQuhMCMPXDtoXCIAYNDfCS+Ucydcw+4pJgQLgAHZURAHg1QR82Sldg+CtjixgcJo0FGgUzRjTaKfJ5Hzifr8X+PsVYZRkvGoO5mfFxiRqpbaKlr9YpoIcMW3q3UCKHxlAIhRmFvxTtLPelM4KPGk4GdI5ofYJX3wRdMp3Ish5//jm7fY0hCz9uHFKqgS9ihxXKarkdRRx2We2Ce3NOi0SsYXvX6fsGv8szuuDQMC6huVVmpi8CG0q90zvc3N22YyVW6dAptkoV6Spx5nhXcHI/4OQbjbaiqert8BQb1OS6m4fjPTIX66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckOE66tYgRkr0opygIocycgMOUd1eO11xbRwKTtOBHM=;
 b=oI+ABXq2eGASZ5B4fU/hsCllUDtUHHZdPsuTSGddvKF29LBXBeLUq/krzz/3aP44nCtF6mc8JboybpUFF7enHPpw6bOR0BlAQt+cc+6YQc7iJPULvGUFiexpflQPQuVjiQ7Ky275kYKOkz6+Uotn+kR2KMozTwM50hkQPcgHoXkylFpV7/BTBuEC5TBasOpzFrcTlajtXoOI9objTFnzzgAcibzekf0RoD/FU3eYCgDFr5+wuDk71G2bHBKYBJG7NV/cApQXujA2JNbmHlUkU/gOMf9aYrOLULMYRwSdJyZEY+W/ebtWuh3gD9r8C/EgaJxANqz4l8bdaZQexbNrMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckOE66tYgRkr0opygIocycgMOUd1eO11xbRwKTtOBHM=;
 b=x9LLlChxrpN9TbS/6T1gDsfBLDmymnJtNcVWANiFnCX/za+rr3AgI41p+Mqa6VMgucth+741iqQlMFogi/rv5MqbXE4ZtUJUPL7h423sx1VH5Z+WXoqa+rHInJE/oEzrF+str70/H5g+xKEG59ff82CQxtPqUM22mEHKapaUyYE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:52:51 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:52:50 +0000
Message-ID: <5e8e8c22-d8c7-4c76-8a88-2a69f920245d@amd.com>
Date: Tue, 3 Nov 2026 08:22:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] amdkfd: Native integration with DRM fences/syncobjs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 aarthex <aarthex@proton.me>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>
References: <6LGhg_Yb_ppPcBcic7UenLy4cBVr66GyWswWm0xLqKQZc04YxYzLkPxbPNQj_2LvHWaG-hSzXaFM2ERSYhJbEOEUYXVn_tWBUYfMP_KzQAI=@proton.me>
 <ba707a14-2802-4a35-a727-c22e749c136d@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <ba707a14-2802-4a35-a727-c22e749c136d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0238.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::19) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|PH7PR12MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: c878d5f5-ebd3-4cbd-515d-08df39558cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|10067099003|56012099006|261102123227099003|18002099003|261009223027099003|261021123027099003|261022105027099003|261021121427099003|261021135927099003|261022075727099003|11063799006|4143699003|261026121527099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: KyUik+axAW8MDSse129JC4PROAwHXzcvkrt/J3l1Sr5fW6AWQtWM8X1cuRj1H+DtuOecS18unj+z3RfoQpOeEo+fIPzCdj6Nw8pAvmc3fzdX+bB7rui1ATaGw3c+1Q1Ne/O3grwl+z/7c/SSfR1ThAJqVBPzDN/IoxpwkhFYWMJxNQS+vsXwEo5btFbGH8yNKZniQainqygPrAQoFBQZdNR/bUGslEtXRR8lR/fTXW7rTSJVMpuA3LaegShG0hSJ/nzGu6q1Cesbh5SI9YLTYs4teIqAcie9Jfe2jgBjWJVF0TTSFaZtcRuaBDCoWZbXnGaKp0RvNwRwOC44VTAP4TWRz94VmK0cm0Z1udWYSLfgOLo8AusD97vPudoghCYxVOE+fi8GhU6HlwDMBodkPYWl8M6FaLxE+9whnh+lmFz7tFvCjur7Ppi2h7YbZ6RMU/sQdGiy/h92qanKJfd4hU6OQ1jV0jR1GBWSZx3a8hzSo7G3W1zmQvrR1h+O0poqNhEmnJo6YMjNc7vMmFqXSaw6/bs1z9/brBSyMuaX7by73t32edZ21ne5BWugRbKPL9b4Vkz53W3pinhVp/25DC3ie5VcNItz89I6R0df1Ow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(10067099003)(56012099006)(261102123227099003)(18002099003)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(261021135927099003)(261022075727099003)(11063799006)(4143699003)(261026121527099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVlXNDY2aGtVWG1XdHJzYldoZFpSSEZIbHlYOTY1S3RRSE1vTUNBcVlMUzE2?=
 =?utf-8?B?ajVlYmFJYnFGWjE5LzVOWXlXbU8xbFNnM3FMUmlTY1l3VFlXWG1yN2tqMFRE?=
 =?utf-8?B?RFZVbjVFeEFyQmlJaXZabGdNb0ovUjN0S1ZRdWQydm1OU1krdStjY1Y0QUtG?=
 =?utf-8?B?ZzIyMjllQjBpMCtHMUZ6UHRadmhERDZBb1JrN0hERXo3Y21JL3N1Zmw1T0l6?=
 =?utf-8?B?UlZqT0dVamI4dWxWdkhtajR1QnBVTjNJaDlTeDV1cUg3QVBFTEw3QXBJVUd3?=
 =?utf-8?B?NmVGWC9wZjY4V1lyZXRRbVpqUlpZNE55SEpPQWp0NWFJelExK2pUbjRLVFF2?=
 =?utf-8?B?WVRXaU8rYkxXMGZSSlIyRlFnYnp3MG9sZUdHVzNucmw1Y0IxOVRtWnAxcktK?=
 =?utf-8?B?cjRtZlBFZEJSZnZiczNDQ3RUWEtOLzNhelZuT2tjaFlnYitFRVBzYTVlR0VZ?=
 =?utf-8?B?SXRqTkVWcE9QaXM2SkJpUUZ3bnAwN1ZVSmFrQktVOFhmWmJtN05zb0RmUWhk?=
 =?utf-8?B?b1pYRVNVM2Z4WUhDTnZpZDdsZkJ6aXFnZzRBUHJaZmhBWFhxMG1xR1ZxUmZk?=
 =?utf-8?B?UGZxSER4V0dqcUN1TC9KWVRMcXNHSW83aVNhdUh4QUs4Uzg3ci9rVyswV3Ax?=
 =?utf-8?B?akd1cmhZTnpPZGpjemtRSFJveGhsRWsxeHF0Y0xtaHphL1o1aFpwT2t4TXZT?=
 =?utf-8?B?YkI5TUpHdlpCbWo0aGdIenJPaW52VG5xVFpkWkpkWTZCVWE3WC9wWWRUQVJZ?=
 =?utf-8?B?VFkrdGZmZjdxWG9oYU1SbStTME5ubE84bHFXN2FyOC9OWlNXeis2RWdRZjFD?=
 =?utf-8?B?ZmxuUDRoWHBGbXBjS3Q4bFJOdnVHN1dTRnZRaFlGWjRTTzI5bjhMQWNiZUV3?=
 =?utf-8?B?dERCZE52dG44c1lqUGVWMDhFbHZEMW1ySUdQeThCSU5mNzBoR2k1Qmw1SXkw?=
 =?utf-8?B?ZUFYVkRJdURTMnpqc3B6WjRkQlc2QXRjTlIwaWJ4TTRSOE5rRlVEKzhuRWNv?=
 =?utf-8?B?TFFVM1BnUkhnem9pQ3lUYXFQcjg0SjlHT0M4d2tuQWlzWWQwYmdpMnlVNURN?=
 =?utf-8?B?dVlhVmUxKzhDbDllbllHS2pQWWNhZ09TWG1ZaVBHNitaV3lGZjNzbUhWMlpQ?=
 =?utf-8?B?UVdmV01XeUowSUp0a1lmaWRvaWZ3b1AvT1cyZlRwRGlzWFZ2ZHNWU1lqUkhh?=
 =?utf-8?B?YVVZdzZmTzI0TXlRU1JDbTQ0WEpvY0poK0xqOGErMWpWS1E2SCtnQ0wwUmw0?=
 =?utf-8?B?ME1sL0pqR2lpRXpRQmd4bUR2NkJUcHdxaWF4WisrUjd1UFJMRGlFRWxlYTAy?=
 =?utf-8?B?SUVmQ0VyQURkb2xPclROY2ZLV1k0WEc4SVhSTmFMa1VweDdacjN6Y3R6YlFj?=
 =?utf-8?B?aGhJQkhCVmFsL0dQOTUwUkhYM1RSNnBoZlBiVlByUTlGdmxqMXZBRzVpaml1?=
 =?utf-8?B?U3Rwa2paUWFweDh0dm9relE3L1QzUzYxc1ZseGVkdCs0Z1FOeVNBcTJxWlp6?=
 =?utf-8?B?TW5BeElFSE9yVWJxTDJpT2kvYkZrSkdtZnJ0OXpRcTIrU1ZNMFB6UW5EVnc0?=
 =?utf-8?B?UWdzMW1XaHVJK1BUbnlNOE5lRXBFNnVYeDFhWURDUzdDdEo1R2F4dzZqRE5D?=
 =?utf-8?B?NnpucXhNQ0N5bHQ2V1ExT1YwRENyUCtQMmk1SHl1RjA5dGxRR0J0TnlremtQ?=
 =?utf-8?B?QmE4eFJrUFNaN3EwdWx1dTFnbVR4cndGYmtPQUdSWGpKcHBCWkswZEJKTXRx?=
 =?utf-8?B?cUJyMkg1aXBvaDBBWDF4enFxb0tTUWlVemFTb1hEMWVhY1VIWGsybjBVZEdE?=
 =?utf-8?B?SmxFV1RYMUJZTVYway9Rb0sxd1hBNUVGSTdYdXdBbGwrK2lubHdmL2p3WFZ3?=
 =?utf-8?B?ZjZ0OXZYQkJhZnJUaWM1c0R3UGlDZUFBdW93ODNvTVI2akpONXUwaGovY2JF?=
 =?utf-8?B?cFJNeVZLUnF4TXl4MWhBdTE0RlJTK3EwallXb2M4N1ZNcjBSN293UUM0MzZa?=
 =?utf-8?B?V2o0NmZPY25UaW9ZVnJKY01zOHk2dm5mSTd1bjNEZzNNclJXT2tlZGNxWGJI?=
 =?utf-8?B?cVV3elF6ZHVkSlU1QXlqUzM1MVVpL0IycjE2YjNjR0ludHpMTXVuL0dzZjZX?=
 =?utf-8?B?SlFubFJHeXFhdTBCUE9nei9zUnEvcjB3ZlhVcXA1NWFiWjNmdm5VMUl4RHJ2?=
 =?utf-8?B?RGNDWGlnNm9sU3I3ejJQYmdMR21pNkZSR21YdGo1LzAvSG8vcWx4TzlsS004?=
 =?utf-8?B?T0oraWF1ZG1ubG9ibEl3VDhmQVc5VDhZMndyV2lQcWltU3hCVStxcndhMExw?=
 =?utf-8?Q?B6FRpDoJ8h9swxaANy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c878d5f5-ebd3-4cbd-515d-08df39558cbc
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:52:50.7714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mM+BRSxnO+EzrgYzBIi0MYhhc8A81e9u747rMDaROEKGsKfSNY5+vQyIA50W7yG9n0GdzuZnBK/ThEoDJ6rTTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/2/2026 6:20 PM, Christian König wrote:
> Hi,
>
> On 10/31/26 05:28, aarthex wrote:
>> Hello people,
>>
>> Currently, amdkfd provides no native way to integrate itself into a wider event loop (like epoll or Wayland explicit sync) using standard DRM fences or syncobjs.
> Yeah that is completely intentional.
>
> Background is that the semantics of dma_fences/DRM syncobjs are incompatible with ROCm or more generally any compute stack, Intel (XE) and Nvidia have the same limitation.
>
>> There are some workarounds, like creating a syncobj and then signaling it from the CPU side after the GPU is done, either via polling or hardware interrupts.
>>
>> But none of these are very tasteful, especially for something that is ideally the driver's job.
>>
>> I opened a feature request for this on GitLab a bit ago here: https://gitlab.freedesktop.org/drm/amd/-/issues/6013
>>
>>
>> Before I work on implementing it, it would be nice to know if the team was open to accepting this, or if anyone had any thoughts/architectural pointers to leave.
> It's really good that you asked before starting anything because stuff like that is completely impossible to get right for dma_fences and DRM syncobs.
>
> AMD and Intel are working together on a eventfd based approach for their compute stack to replace AMD specific KFD events. If you are interested Srini can point you to the right patches/components on the mailing list and in code.

Hi Christian,

Thanks for the context.

For reference, we've previously posted prototype work around 
eventfd-based compute event delivery, WAIT_EVENT infrastructure,

- EVENTFD infrastructure:
   https://patchwork.freedesktop.org/series/164618/

- GPU event producers wired into EVENTFD notifications:
   https://patchwork.freedesktop.org/series/170501/

- WAIT_EVENT metadata retrieval and consumption:
   https://patchwork.freedesktop.org/series/164813/

The goal of that work was to explore a generic eventfd-based mechanism 
for queue completion, reset, and debugger-visible compute events from 
the render-node side.

Regards,
Srini

