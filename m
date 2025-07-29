Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FAF5C87FCA
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 21:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A210D10E04F;
	Tue, 29 Jul 2025 21:29:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="35s+hUHU";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 193A410E04F
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 21:29:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DI5hY9ukOCA/5sQ+duqatABlD8rdL3W/dvu6H3YNOZncYivBPVoHMtamjWYBtazx5/Rw33iEw5/IPw6x26GklxxUqwyfSfXFRj0yQqSVV9Xf/YPMnyOSaKbdAB6OkFy21p8Y5lqutyX2oiFurwIacMOh1gTWwP5cYPQZIwz55fX2/WlynsluCVODhP6ihAGFIeSLipmyJjv1/60+nbtHjbzbbuTFxGaNrtdOvJPk5KJkJSyqqlftjKwhOC0apQDcAfUluttgNclb7hOkpHOVMO9/31dADJAhrUEC4UOTpheDDU8p4Pi4gBYtnMkryN+MJgk0HOjIp7aj0yVm6iqCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NFGD7IRZm3uxy7pRtxb6/sx9cvXSADs1mOrjlvu0zA=;
 b=UtHEmwCRVIImMuDuEHkEf6bbgANqSkrSPwPrxOaWSPNk05d11BgHlE+Yj3Ow9P8ONoBRO7n1mH1giojBroYfvzfJ93V7DMBCY4nQxklj9qC4dRylqdIGBf25qcX9H0OzEDq1U1tmS5nN5Fmlid+pGFb2SHaRXEmjemyB1ftwoE33hTVoQDQurymCYkQwsD59h701YoMAUsbchFYI7MkI3VM/9fw+6rMXg15nv/nUDbsT5Rd0K7arAbjkan5VVDdSRwQezAEE3F6Y/w1xl/41vyUbQd1yiNrNp+jIUPSLoHYk61NQGYYjBJlzckfXAdenOUa0G8+rgZJidXRGgy/Qsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NFGD7IRZm3uxy7pRtxb6/sx9cvXSADs1mOrjlvu0zA=;
 b=35s+hUHU3lc8Cs+6b/9qXpdb6vbVLm/kah1l/M3dDZu3o7CVolejI3F6I4e3eZcaf55JtPJ402RTyolvpAiE/weZ8mUFQFPBh1pwpi9HfjdVhFyMVdwTPC4ZTAFg6cmZJz2nR7CbwednC78JedYg47ECRM/gZUu7DVZPruagu6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by CY5PR12MB6299.namprd12.prod.outlook.com (2603:10b6:930:20::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Tue, 29 Jul
 2025 21:29:55 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 21:29:54 +0000
Content-Type: multipart/alternative;
 boundary="------------lmbVRtVZ624RkotaACSy9WTu"
Message-ID: <a9606504-d719-4629-b743-462415c6612e@amd.com>
Date: Tue, 29 Jul 2025 17:29:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: update mmhub 3.3 client id mappings
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250729210754.2304695-1-alexander.deucher@amd.com>
 <20250729210754.2304695-2-alexander.deucher@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <20250729210754.2304695-2-alexander.deucher@amd.com>
X-ClientProxiedBy: YQZPR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::22) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|CY5PR12MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 224508e4-3494-4206-779c-08ddcee70f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tmh4M28veVZ4RkhDbVJlcktFQzBHUmlPeURWTzd1OG1CSExqZEFwT1ptUytl?=
 =?utf-8?B?aGxDeGVFVlNSVDR6QWt4YTRYbVh4RGlpdEJ2UmRNQUNYZWFENlF4TTVMRkxS?=
 =?utf-8?B?T1RuK1VzUnVsQ3pTWkd1ZklTL2F6UG9rTDJBZGhadFJWMko3RVNaendMN3ov?=
 =?utf-8?B?Ti9wdHFYYWJ5MzRzK2RYVmxCaURoRElKOGRsMUVXYWthT0pocEdJdW1ncERs?=
 =?utf-8?B?MENrN2pEUGRnRWhNcnd5VHF4Ulh4WlRrcm5VWXBvQk5CL0FvdUErZUt0VVdB?=
 =?utf-8?B?Tm5CczBQd1IyVlBwTGN0UW10V1M4SXl6d1JJY3ZWTllTbE5DMVM3QndDMUNw?=
 =?utf-8?B?MVlKbFdHbWNhSUI2cmJWSGl5UWJMUi9WSDUzSm5kNHhnZG5tSVFQbUxTWDdo?=
 =?utf-8?B?SEtrUk1vUjFTTjJyOTdUUVlrQjNKbHhDY1J4WkZacWZHcyt1bWdnYjBTODFR?=
 =?utf-8?B?STVaTG9lN2ZzNldEWk9HdEVhRnhCQVA4SHAzRGlOcDNhYTdJOFIraXNHa3dM?=
 =?utf-8?B?VjVKNmJTcmszVGxBRjBLK3dVTEVhMXdUaVJmSE1ic1hrNmhLdmJ4WklmdGNK?=
 =?utf-8?B?R3V1RUswQ0gvVlZVV3VvSWlqaDZ5MXo0SDN2c3g3ZmdDVkIyRzBYcWZ2enpN?=
 =?utf-8?B?MjcrV0tzR2doMmVuRlhIT2lUMTdVYVltWGYzUkhVTFpLb0RUUGRhREY4VkNP?=
 =?utf-8?B?U0lpWmhLZTZ3c3FaR1hSMnh2dWtKM1VzQ1U5UG5iRXhvVUMzQUZiMnU0Ky9T?=
 =?utf-8?B?amFvKzc0RDJYRmRJdTM3cmtIU3lXQTNRZEJ4R0ZLZGNBSVVVbC9JZ1BJYkE3?=
 =?utf-8?B?T253QjN5V1VHc2pnSmJ2enF5Y3BGKzVvQkNjYVFLR1lmLzdVUHFvc3FWWktH?=
 =?utf-8?B?MXFiZXUvUm96S0ZNSm9xOXZwdlF4bStpOGRWUDFDbUNQbDFDMlRWdE4zWldR?=
 =?utf-8?B?K1BwbEVTWG1OSmd1L0piRGdTSE4yWE1xQUVTNXNJeEV2ZXkzWVVwYVRqUHRh?=
 =?utf-8?B?b1daQkJabXVMVHNrQlMybUphQzFKcEVrYW1Pakl3U2QybHl1M25tYXEwQ3hD?=
 =?utf-8?B?QTRDZTNYT2hjbWd5MFY5WG15YndackowdzRwekJQUVNjUXQwL1d0ZHc2THJL?=
 =?utf-8?B?ZTM4dXhVOXVjVmF0VFpCenM2bktoYXhKcW02QlZDbENCcGFZU0JXMUVZajFP?=
 =?utf-8?B?V2wzMnZlOHNDQmVtMmNyZjhZaGpjaHJjTVMzUEJ1NnVtRjZCZzlyZnVZMGRr?=
 =?utf-8?B?OEFlNGNNUE5CUXNjclV2c2E2QThVQ3FCSElEbVZJUjZGOW9uZVB6emxKV3o0?=
 =?utf-8?B?RVUyVWVuR2l2a2lEM1lkUzJOYi9PL0N1SVh3VHUvanNjdW81NElZTFdQUUxD?=
 =?utf-8?B?Q3Y0MVAzQWFSSUxKak5EZVZaK2FXQ0VvekpPODk1Nk1JT2RDYXVXVWw5Yzlw?=
 =?utf-8?B?d0xpSkluMDNPS1JuR1FIM2F2MVY5czlvRlExV1ZWb2psUlZPdGxCbjRNSGxQ?=
 =?utf-8?B?L1haZ1ZKY1pxbXh4L3M4LytRcWxVTGsrK0JTeHdZSUdRUlN2RUFIZHdoL0tJ?=
 =?utf-8?B?Z0ZTYnZiSTlXQ0NKUEtoMGpmbVJLOTVhdjJzenNON0hiU1dJeGZjV25hT1FC?=
 =?utf-8?B?UWwvTEZVYTFDeUk0d1lYR3hZbGFjSlhYMGRkSXB0K0hQcktVU05FNitrVmdw?=
 =?utf-8?B?U0VaZkFERHg1ZkpMUGx6VVptZUpicDY4VWt1SmN4RkxSTmtPR0FsY0pkRHE4?=
 =?utf-8?B?eW5ETEZwQkN2SUt2R2o5L0xwRzdxMms1WUpjR25TMFFPM3FHMjZUR0dpb1JC?=
 =?utf-8?B?Q0hKTWlSWVY0bU9xMjlFSGRkQzB0b3orTUlyRU9PV2xzdk5acGZiMndnMjRu?=
 =?utf-8?B?UGRzTTNkQ2VNRHJNUFljb3RkemMvdFlLS1RXODdQYlV1MmZFbnRrUXRiWHVF?=
 =?utf-8?Q?K51V5LPM/k0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2Fyb0NubG5MZ1EwRmdsQzZvVElsRkNuNlczaFdPbFdRZjNTRFVwZVlranVH?=
 =?utf-8?B?RVFYdG5kOTlFOUVCRS9TTUtnM2llZEc3MHR1UUNSc05Udm5keVlsdEdtVExq?=
 =?utf-8?B?dmRydmhjUjBJWDZHMG5xMCtaOWovM0Vrb1Ntakc1ZDRzRXhKKzh2OTVrWUUz?=
 =?utf-8?B?cGpxRnlnWGhPeVNhVzZ3eW95dXhOK1hrekIxMjlmcTFqZENPY09KQ0phYXps?=
 =?utf-8?B?V3JuMGZ3RmV6cHNPczd3bm1ReFNOc2o3SVhNM0RtS29XQnh5MWZuWVE0bkdi?=
 =?utf-8?B?ZWJoOTZ6TnAxSlVManYyY3JYOGhpcXdDM3IycHpyVDlJekhjRktOZXR3NXZ4?=
 =?utf-8?B?WmtHdDRFbmwzdExEVWh4RDRNRGMxVUNyWFMwRWlGZ1d1NE1IbUhoRzBUWU0z?=
 =?utf-8?B?WGlnZ0pJNnQwNUxrUCtrazdvQWo4SndIK0t5QVNERmdHc2EwZWFtU2dEUS9o?=
 =?utf-8?B?QmpWMHFaaHJQYlIrTkx3TmRTYnBZSkZqcUo0UzJHMFJVckxQeUZ0OTZoZk9h?=
 =?utf-8?B?T1ppQzQwSEVURU03ZmlEQUUzL0dWNmN3YllRS1FQMkEzZmhrSjdWSlYybU02?=
 =?utf-8?B?MUY5a3RwOG5QUlJ4Tmcyc0xrdUoyQjRVUXoyWFhacVBGM096Wks4Ri9IS2Jh?=
 =?utf-8?B?a2pML1VXZytDNlkwWmwrdnpsbWZaUTlQYWluZWJweDFzdXhDdVNIREt2dW1D?=
 =?utf-8?B?RHUwcU5vdHhmVW80aUFTcDY4NXh6dTNhd3hOVlVQbEFDQWxsZWtJUFpvaU8r?=
 =?utf-8?B?dmY3aWc1MVR4d1NEejVLamtOcDlIVVFKT0JMNjMwMUkvbERDaFFLdFJ2WkRF?=
 =?utf-8?B?b3ZXRmhtNVZJRG1adlpZNzRNeW53YWY4T0ZUMEF5clJONE5wOTdySlhFbFVl?=
 =?utf-8?B?eG80Q09Xd1liMGJ1SlhpWWJtWWYza0VVbS95VlZoSDd5ODNTR1ZtajBEOVU2?=
 =?utf-8?B?TWUzWXVLcCt1NXdZaGhhOEM5c2N4SlRzRFlra0VqN1JaY2VtNTFOOEhyK1Ru?=
 =?utf-8?B?SGh5ZTFVYkxVdWZLQzlLcVo2V09rY0tCRjRVZmdqYVZiUkdaaStNSDl5eDNq?=
 =?utf-8?B?RDBsOWJ2RkhodElyR3MrZVZ0M2w0QnBJWitYS0V6YWZZQUZFWksvYy8xd2hz?=
 =?utf-8?B?OG5BclhzRHMwZ3BMSm43ZDREWXF4TTlvRElNU3hQNmtDMXRaSGNhVlZld0lR?=
 =?utf-8?B?WUVLUUh0dnlNMklxLzJMZUNaZDR6R1BCT3VRZ1dVQzE0c1pZZEVEcmI4VXBT?=
 =?utf-8?B?YTNRNkZSZE9EU1ljU2ViY3ZkazNFdHZKd2ZBUWVNZ0ZlakhRa1JTSDFKQ0g1?=
 =?utf-8?B?YmFpeldURzNnT0FHdmZBbWVsbDltYStiVlBQZmQzYi9wR2s3eTFhSlU5Slh6?=
 =?utf-8?B?NFhBOHJYSmpPRFdKVXNjU3RlL1B5UFk5Q3UweVdhdUpvNS9uUHl0U1hvSnRq?=
 =?utf-8?B?K3NtcWtiUjVLdXJuRzJzZWpLYWtaNm9XSHZwczMxemcyZjlBaS9Bdi80WmN4?=
 =?utf-8?B?ckQ1YjR0aVdlMTErVk1GcFl3T0dTRXpGSERyRUpPTUxHbkxsc3FXS3lTU1Z1?=
 =?utf-8?B?blNEUkxadktWaXduakJsbzFnNUprTklXMmh5VGFSSWJMc09vQlVNbnZNZ2RD?=
 =?utf-8?B?Sm5wU2tZSDB5U3NWMDhTdU15NytyVjFBU0V3UHFKc01lZVdYMklGVm9MK0sr?=
 =?utf-8?B?QjlZSXhiSlBMWEFZMjZVOTNPa1Q5MHprVFFES0tYZ1k4WUJURDFtU1ozeEsv?=
 =?utf-8?B?NWo5RzhmZC9qNVJXL3NYNElHTWc2V3JWUS9UQnBKZ3FseFNMMTlYVEhYVU9k?=
 =?utf-8?B?enpEUGJheG05MVBEWStob0JYTzFvSVd0Y2FjOWROWDlwVVZNdjZwS0FERDZH?=
 =?utf-8?B?M3V1NXlodEZBVnNkYjBxYS9VdUl6UVVuWWFnb3MvZUFRRWpNZ1d0a0RxVlZp?=
 =?utf-8?B?bnJGR2VaY3c1b2ZFTmR5UmNER2RHQXBkekVDYzEvcDhNUWZtbW1Xc3NYQytN?=
 =?utf-8?B?VEFaSmpZVlBTbHZmOU5oTjdMOXZ6TGtYNVpxMkpOKzFWWWQxNE8yOExLd2Fn?=
 =?utf-8?B?RkQrZ0padkZCT3hwNURaamIrTWsxSVVJaGFEb3cvZHpvQTgwL0VnZE82eXV6?=
 =?utf-8?Q?mhmX9fo3wm+N/z35ICGghJpM3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224508e4-3494-4206-779c-08ddcee70f1e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 21:29:54.5540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +z3GSRYczhYUyBuBQ0j7AUzEFsbrrMyyW33lazVFuZYIrHdNpt55y3pjpJDsSYuhkYNXtV6L/f1sfXggyzpZjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6299
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

--------------lmbVRtVZ624RkotaACSy9WTu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I think there is one more change here [32+5][1] = "ISPC*IS*WR" => 
"ISPC*SIS*WR".
others look good for these 2 patches -
        Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
thanks,

David

On 2025-07-29 17:07, Alex Deucher wrote:

> Update the client id mapping so the correct clients
> get printed when there is a mmhub page fault.
>
> v2: fix typos spotted by David Wu.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 105 +++++++++++++++++++++++-
>   1 file changed, 104 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> index bc3d6c2fc87a4..733bc76a0f3f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
> @@ -40,30 +40,129 @@
>   
>   static const char *mmhub_client_ids_v3_3[][2] = {
>   	[0][0] = "VMC",
> +	[1][0] = "ISPXT",
> +	[2][0] = "ISPIXT",
>   	[4][0] = "DCEDMC",
>   	[6][0] = "MP0",
>   	[7][0] = "MP1",
>   	[8][0] = "MPM",
> +	[9][0] = "ISPPDPRD",
> +	[10][0] = "ISPCSTATRD",
> +	[11][0] = "ISPBYRPRD",
> +	[12][0] = "ISPRGBPRD",
> +	[13][0] = "ISPMCFPRD",
> +	[14][0] = "ISPMCFPRD1",
> +	[15][0] = "ISPYUVPRD",
> +	[16][0] = "ISPMCSCRD",
> +	[17][0] = "ISPGDCRD",
> +	[18][0] = "ISPLMERD",
> +	[22][0] = "ISPXT1",
> +	[23][0] = "ISPIXT1",
>   	[24][0] = "HDP",
>   	[25][0] = "LSDMA",
>   	[26][0] = "JPEG",
>   	[27][0] = "VPE",
> +	[28][0] = "VSCH",
>   	[29][0] = "VCNU",
>   	[30][0] = "VCN",
> +	[1][1] = "ISPXT",
> +	[2][1] = "ISPIXT",
>   	[3][1] = "DCEDWB",
>   	[4][1] = "DCEDMC",
> +	[5][1] = "ISPCSISWR",
>   	[6][1] = "MP0",
>   	[7][1] = "MP1",
>   	[8][1] = "MPM",
> +	[9][1] = "ISPPDPWR",
> +	[10][1] = "ISPCSTATWR",
> +	[11][1] = "ISPBYRPWR",
> +	[12][1] = "ISPRGBPWR",
> +	[13][1] = "ISPMCFPWR",
> +	[14][1] = "ISPMWR0",
> +	[15][1] = "ISPYUVPWR",
> +	[16][1] = "ISPMCSCWR",
> +	[17][1] = "ISPGDCWR",
> +	[18][1] = "ISPLMEWR",
> +	[20][1] = "ISPMWR2",
>   	[21][1] = "OSSSYS",
> +	[22][1] = "ISPXT1",
> +	[23][1] = "ISPIXT1",
>   	[24][1] = "HDP",
>   	[25][1] = "LSDMA",
>   	[26][1] = "JPEG",
>   	[27][1] = "VPE",
> +	[28][1] = "VSCH",
>   	[29][1] = "VCNU",
>   	[30][1] = "VCN",
>   };
>   
> +static const char *mmhub_client_ids_v3_3_1[][2] = {
> +	[0][0] = "VMC",
> +	[4][0] = "DCEDMC",
> +	[6][0] = "MP0",
> +	[7][0] = "MP1",
> +	[8][0] = "MPM",
> +	[24][0] = "HDP",
> +	[25][0] = "LSDMA",
> +	[26][0] = "JPEG0",
> +	[27][0] = "VPE0",
> +	[28][0] = "VSCH",
> +	[29][0] = "VCNU0",
> +	[30][0] = "VCN0",
> +	[32+1][0] = "ISPXT",
> +	[32+2][0] = "ISPIXT",
> +	[32+9][0] = "ISPPDPRD",
> +	[32+10][0] = "ISPCSTATRD",
> +	[32+11][0] = "ISPBYRPRD",
> +	[32+12][0] = "ISPRGBPRD",
> +	[32+13][0] = "ISPMCFPRD",
> +	[32+14][0] = "ISPMCFPRD1",
> +	[32+15][0] = "ISPYUVPRD",
> +	[32+16][0] = "ISPMCSCRD",
> +	[32+17][0] = "ISPGDCRD",
> +	[32+18][0] = "ISPLMERD",
> +	[32+22][0] = "ISPXT1",
> +	[32+23][0] = "ISPIXT1",
> +	[32+26][0] = "JPEG1",
> +	[32+27][0] = "VPE1",
> +	[32+29][0] = "VCNU1",
> +	[32+30][0] = "VCN1",
> +	[3][1] = "DCEDWB",
> +	[4][1] = "DCEDMC",
> +	[6][1] = "MP0",
> +	[7][1] = "MP1",
> +	[8][1] = "MPM",
> +	[21][1] = "OSSSYS",
> +	[24][1] = "HDP",
> +	[25][1] = "LSDMA",
> +	[26][1] = "JPEG0",
> +	[27][1] = "VPE0",
> +	[28][1] = "VSCH",
> +	[29][1] = "VCNU0",
> +	[30][1] = "VCN0",
> +	[32+1][1] = "ISPXT",
> +	[32+2][1] = "ISPIXT",
> +	[32+5][1] = "ISPCISWR",
> +	[32+9][1] = "ISPPDPWR",
> +	[32+10][1] = "ISPCSTATWR",
> +	[32+11][1] = "ISPBYRPWR",
> +	[32+12][1] = "ISPRGBPWR",
> +	[32+13][1] = "ISPMCFPWR",
> +	[32+14][1] = "ISPMWR0",
> +	[32+15][1] = "ISPYUVPWR",
> +	[32+16][1] = "ISPMCSCWR",
> +	[32+17][1] = "ISPGDCWR",
> +	[32+18][1] = "ISPLMEWR",
> +	[32+19][1] = "ISPMWR1",
> +	[32+20][1] = "ISPMWR2",
> +	[32+22][1] = "ISPXT1",
> +	[32+23][1] = "ISPIXT1",
> +	[32+26][1] = "JPEG1",
> +	[32+27][1] = "VPE1",
> +	[32+29][1] = "VCNU1",
> +	[32+30][1] = "VCN1",
> +};
> +
>   static uint32_t mmhub_v3_3_get_invalidate_req(unsigned int vmid,
>   						uint32_t flush_type)
>   {
> @@ -102,12 +201,16 @@ mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
>   
>   	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
>   	case IP_VERSION(3, 3, 0):
> -	case IP_VERSION(3, 3, 1):
>   	case IP_VERSION(3, 3, 2):
>   		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_3) ?
>   			    mmhub_client_ids_v3_3[cid][rw] :
>   			    cid == 0x140 ? "UMSCH" : NULL;
>   		break;
> +	case IP_VERSION(3, 3, 1):
> +		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_3_1) ?
> +			    mmhub_client_ids_v3_3_1[cid][rw] :
> +			    cid == 0x140 ? "UMSCH" : NULL;
> +		break;
>   	default:
>   		mmhub_cid = NULL;
>   		break;
--------------lmbVRtVZ624RkotaACSy9WTu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    I think there is one more change here <span data-teams="true">[32+5][1]
      = &quot;ISPC<strong>IS</strong>WR&quot; =&gt; &quot;ISPC<strong>SIS</strong>WR&quot;.
      <br>
    </span>others look good for these 2 patches -&nbsp;&nbsp;<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a><br>
    thanks,
    <p>David</p>
    <p>On 2025-07-29 17:07, Alex Deucher wrote:</p>
    <blockquote type="cite" cite="mid:20250729210754.2304695-2-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">Update the client id mapping so the correct clients
get printed when there is a mmhub page fault.

v2: fix typos spotted by David Wu.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 105 +++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index bc3d6c2fc87a4..733bc76a0f3f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -40,30 +40,129 @@
 
 static const char *mmhub_client_ids_v3_3[][2] = {
 	[0][0] = &quot;VMC&quot;,
+	[1][0] = &quot;ISPXT&quot;,
+	[2][0] = &quot;ISPIXT&quot;,
 	[4][0] = &quot;DCEDMC&quot;,
 	[6][0] = &quot;MP0&quot;,
 	[7][0] = &quot;MP1&quot;,
 	[8][0] = &quot;MPM&quot;,
+	[9][0] = &quot;ISPPDPRD&quot;,
+	[10][0] = &quot;ISPCSTATRD&quot;,
+	[11][0] = &quot;ISPBYRPRD&quot;,
+	[12][0] = &quot;ISPRGBPRD&quot;,
+	[13][0] = &quot;ISPMCFPRD&quot;,
+	[14][0] = &quot;ISPMCFPRD1&quot;,
+	[15][0] = &quot;ISPYUVPRD&quot;,
+	[16][0] = &quot;ISPMCSCRD&quot;,
+	[17][0] = &quot;ISPGDCRD&quot;,
+	[18][0] = &quot;ISPLMERD&quot;,
+	[22][0] = &quot;ISPXT1&quot;,
+	[23][0] = &quot;ISPIXT1&quot;,
 	[24][0] = &quot;HDP&quot;,
 	[25][0] = &quot;LSDMA&quot;,
 	[26][0] = &quot;JPEG&quot;,
 	[27][0] = &quot;VPE&quot;,
+	[28][0] = &quot;VSCH&quot;,
 	[29][0] = &quot;VCNU&quot;,
 	[30][0] = &quot;VCN&quot;,
+	[1][1] = &quot;ISPXT&quot;,
+	[2][1] = &quot;ISPIXT&quot;,
 	[3][1] = &quot;DCEDWB&quot;,
 	[4][1] = &quot;DCEDMC&quot;,
+	[5][1] = &quot;ISPCSISWR&quot;,
 	[6][1] = &quot;MP0&quot;,
 	[7][1] = &quot;MP1&quot;,
 	[8][1] = &quot;MPM&quot;,
+	[9][1] = &quot;ISPPDPWR&quot;,
+	[10][1] = &quot;ISPCSTATWR&quot;,
+	[11][1] = &quot;ISPBYRPWR&quot;,
+	[12][1] = &quot;ISPRGBPWR&quot;,
+	[13][1] = &quot;ISPMCFPWR&quot;,
+	[14][1] = &quot;ISPMWR0&quot;,
+	[15][1] = &quot;ISPYUVPWR&quot;,
+	[16][1] = &quot;ISPMCSCWR&quot;,
+	[17][1] = &quot;ISPGDCWR&quot;,
+	[18][1] = &quot;ISPLMEWR&quot;,
+	[20][1] = &quot;ISPMWR2&quot;,
 	[21][1] = &quot;OSSSYS&quot;,
+	[22][1] = &quot;ISPXT1&quot;,
+	[23][1] = &quot;ISPIXT1&quot;,
 	[24][1] = &quot;HDP&quot;,
 	[25][1] = &quot;LSDMA&quot;,
 	[26][1] = &quot;JPEG&quot;,
 	[27][1] = &quot;VPE&quot;,
+	[28][1] = &quot;VSCH&quot;,
 	[29][1] = &quot;VCNU&quot;,
 	[30][1] = &quot;VCN&quot;,
 };
 
+static const char *mmhub_client_ids_v3_3_1[][2] = {
+	[0][0] = &quot;VMC&quot;,
+	[4][0] = &quot;DCEDMC&quot;,
+	[6][0] = &quot;MP0&quot;,
+	[7][0] = &quot;MP1&quot;,
+	[8][0] = &quot;MPM&quot;,
+	[24][0] = &quot;HDP&quot;,
+	[25][0] = &quot;LSDMA&quot;,
+	[26][0] = &quot;JPEG0&quot;,
+	[27][0] = &quot;VPE0&quot;,
+	[28][0] = &quot;VSCH&quot;,
+	[29][0] = &quot;VCNU0&quot;,
+	[30][0] = &quot;VCN0&quot;,
+	[32+1][0] = &quot;ISPXT&quot;,
+	[32+2][0] = &quot;ISPIXT&quot;,
+	[32+9][0] = &quot;ISPPDPRD&quot;,
+	[32+10][0] = &quot;ISPCSTATRD&quot;,
+	[32+11][0] = &quot;ISPBYRPRD&quot;,
+	[32+12][0] = &quot;ISPRGBPRD&quot;,
+	[32+13][0] = &quot;ISPMCFPRD&quot;,
+	[32+14][0] = &quot;ISPMCFPRD1&quot;,
+	[32+15][0] = &quot;ISPYUVPRD&quot;,
+	[32+16][0] = &quot;ISPMCSCRD&quot;,
+	[32+17][0] = &quot;ISPGDCRD&quot;,
+	[32+18][0] = &quot;ISPLMERD&quot;,
+	[32+22][0] = &quot;ISPXT1&quot;,
+	[32+23][0] = &quot;ISPIXT1&quot;,
+	[32+26][0] = &quot;JPEG1&quot;,
+	[32+27][0] = &quot;VPE1&quot;,
+	[32+29][0] = &quot;VCNU1&quot;,
+	[32+30][0] = &quot;VCN1&quot;,
+	[3][1] = &quot;DCEDWB&quot;,
+	[4][1] = &quot;DCEDMC&quot;,
+	[6][1] = &quot;MP0&quot;,
+	[7][1] = &quot;MP1&quot;,
+	[8][1] = &quot;MPM&quot;,
+	[21][1] = &quot;OSSSYS&quot;,
+	[24][1] = &quot;HDP&quot;,
+	[25][1] = &quot;LSDMA&quot;,
+	[26][1] = &quot;JPEG0&quot;,
+	[27][1] = &quot;VPE0&quot;,
+	[28][1] = &quot;VSCH&quot;,
+	[29][1] = &quot;VCNU0&quot;,
+	[30][1] = &quot;VCN0&quot;,
+	[32+1][1] = &quot;ISPXT&quot;,
+	[32+2][1] = &quot;ISPIXT&quot;,
+	[32+5][1] = &quot;ISPCISWR&quot;,
+	[32+9][1] = &quot;ISPPDPWR&quot;,
+	[32+10][1] = &quot;ISPCSTATWR&quot;,
+	[32+11][1] = &quot;ISPBYRPWR&quot;,
+	[32+12][1] = &quot;ISPRGBPWR&quot;,
+	[32+13][1] = &quot;ISPMCFPWR&quot;,
+	[32+14][1] = &quot;ISPMWR0&quot;,
+	[32+15][1] = &quot;ISPYUVPWR&quot;,
+	[32+16][1] = &quot;ISPMCSCWR&quot;,
+	[32+17][1] = &quot;ISPGDCWR&quot;,
+	[32+18][1] = &quot;ISPLMEWR&quot;,
+	[32+19][1] = &quot;ISPMWR1&quot;,
+	[32+20][1] = &quot;ISPMWR2&quot;,
+	[32+22][1] = &quot;ISPXT1&quot;,
+	[32+23][1] = &quot;ISPIXT1&quot;,
+	[32+26][1] = &quot;JPEG1&quot;,
+	[32+27][1] = &quot;VPE1&quot;,
+	[32+29][1] = &quot;VCNU1&quot;,
+	[32+30][1] = &quot;VCN1&quot;,
+};
+
 static uint32_t mmhub_v3_3_get_invalidate_req(unsigned int vmid,
 						uint32_t flush_type)
 {
@@ -102,12 +201,16 @@ mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(3, 3, 0):
-	case IP_VERSION(3, 3, 1):
 	case IP_VERSION(3, 3, 2):
 		mmhub_cid = cid &lt; ARRAY_SIZE(mmhub_client_ids_v3_3) ?
 			    mmhub_client_ids_v3_3[cid][rw] :
 			    cid == 0x140 ? &quot;UMSCH&quot; : NULL;
 		break;
+	case IP_VERSION(3, 3, 1):
+		mmhub_cid = cid &lt; ARRAY_SIZE(mmhub_client_ids_v3_3_1) ?
+			    mmhub_client_ids_v3_3_1[cid][rw] :
+			    cid == 0x140 ? &quot;UMSCH&quot; : NULL;
+		break;
 	default:
 		mmhub_cid = NULL;
 		break;
</pre>
    </blockquote>
  </body>
</html>

--------------lmbVRtVZ624RkotaACSy9WTu--
