Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF1EC9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 10:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1E2610F46C;
	Thu, 24 Sep 2026 10:53:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DITT0T0X";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F22510F46C
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 10:53:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkh7NPuO/dlj4BMFTBfaYSzlioGNdPr9J12WT673WJlvZZh5aoIxVHcbXVpMdLNLqMXmyvAdbkTK1pgY+O5pn3pokBYh1usjCpH4HYpPe5ijYi3tn1Kl7FNTg4yr8FF7+0h2fQVWeuXWJ6KxVehL8os0gLIpOIcff4F3yyMdKcTA4qV4b8QbqAkiIds6yj/mmoxAMVzoXZfvfTgMgFiHIAQA5q6/qhQrPkeI5Sr0z4vKFAwDujeCO2ljbPT5BJP+lwBdZwwHFYSNiXy/PVxGQugECCXVIK4gUqJeh6oML9FxvsUQOpgDxiQDQnuvOCbFkn6sRA4hWyrPXnKqqS4vtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydSQg1WxJ08AP92PRtHzzSfgldLdKG0xSJgbHMG1V2k=;
 b=QLduUPak6zuw4vuDbC/IU31R5ouf6GSaMH27455iXU13gQvgYMeovCPSEfIMZpWQoHNYOl56HYhA8qdtuTZFd5gnQ2NEb8zS1PI70IQeirDwh5ZypaYAlxvAT0JG8JgI/96lnIcCU9/BwnzXjymXnSuE+gd89KqMhsfvGMN6QHQKbzu5cZUJB5BUaLldyJY2/xD2QoIHICDcsTbhu1LRkpeEoS0d28Cc+RHnVkbRoSs9TzBCymSy+vOrntE3N6DxJ6gCXuPEhGOGFHRH3p7oImuvRXVB/9AHuJJ+IpXD2JQ2xDAYj7SaI/7OVFRbVH8ZoHu4X85HCPc6QdigrwwuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydSQg1WxJ08AP92PRtHzzSfgldLdKG0xSJgbHMG1V2k=;
 b=DITT0T0X8rDuxP1HiDoGYoBxeDcLOydZc3qBrK7PjhkVM1lJpZvio8lXy+LKuQ2hjfzH38xl6SIZBvGmICyC/HZJcDYKSN34Lvg5ArjOX4AgIOGBi/gq1NPGOBwqx05+nvmB0gCRV5vputple8qnWZsZffPzwfjdVLqZoOWjDDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 10:53:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 10:53:35 +0000
Message-ID: <001e6c0d-6525-43eb-a429-46265245986f@amd.com>
Date: Thu, 24 Sep 2026 12:53:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] drm/amdgpu: drop vm->generation initalization
 and root PD clearing
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kevin.wang@amd.com
References: <20260923193346.2292597-1-shahyan.soltani@amd.com>
 <20260923193346.2292597-9-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260923193346.2292597-9-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: f703a77d-120f-4d1a-4c8d-08df1a2a151c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: IYUL9/HfMlT6jN4ZIh6MFMSS+UZcYKLuzDq1rhLw429K+FFq44NWjbiNurMa3qkeM3V/C7l+gJ3O1rXa5I/xE/cqov5NePw2YlrdLPbvxoZRa6WIwec9KT4ycwmN9LoN593FZ8AWcQiRK0qGqfFCIpJn61N7vpzJnVDmUIKV7BAMmgvr4D7VGzKAQsdZ3nDWDQWrS6mqEwwLxQFsKbrQSaDhPWd/OE0QqecZYSiJpTvBOKxY0xduguLTeYxUQECJwqtaAAoXVbDGAnXUBRkEtpSKD8SL6HLjr/SQCIAp5mpCR4JUW7EZK+2NfD2JLgaQ5r8WzZ6T0Atc0ne4M+5XrROcSsK1K12CFkF7r207AR9WTFat8lD0SKgD++TE7O5rNk0tx0M/TxSSoLNOap7x2ZSs2qAkXHHH9M+9+cqx4Bf/tBi8TL0IMQQWrJZ/xWpe5n6MbzvSySFXSlwpnjz1i4bREfRYreYH/C4r1wJzodseDvK7RckOmRilmeuK936FCDX/NsdfU4uYpONpFD52Xq6Qb4IbjxqkuWCoCCEW6gmaOR8OhMJZ8/lmKxmHRhImDHzoOVXAk+0PRUcDFrhsBTGUxI/1AtGKdDZmreECpjn0asJhTvgarpUHPNoxobPtUF35fDiAECmcsJ/o3lfJ0sRSOzyrYc9H9qyt4fRpOqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU5BeVpqSjRiY1crb2RKRkE2S1lCZFhGcDFBOTRaaWRKVkFrUHJtaWc5S1dG?=
 =?utf-8?B?NGxKcHJqcXdFS2FLdHA5alJ0RjdHdGtxc2Z6Q0NwTEhpYlErNGhUZTlYTzZN?=
 =?utf-8?B?N1ovZ3dOMHdRZnltMkQ1MmN2M2tmdFp4UjkzaGpmMWNxM0xaSnBTYXlWdlly?=
 =?utf-8?B?K2NVVzlETmdrT3RTR21MRnpQckhjL0hheHdUbUZWcUlId2YyUWZEVWJESFRO?=
 =?utf-8?B?bEpGR25acGtPV0tzN1hWL0tOK2ZaRHRtQm85K2UzN3RObTRzLzVlQ2ExUUlu?=
 =?utf-8?B?ZUFQQzhQWThvUldVOFIwOWxCVlVLOW82U3hqUXU5UVo3dUFQNnI2NDJDekVS?=
 =?utf-8?B?U2p2cmcxWDBrU0V1eE5NTGR4TWdxd3dIbWdDY2NOZ2ljMk9jRS9Sai9iYktu?=
 =?utf-8?B?eG9lcjdyYjMzME0rK2VTZE93MkZxK3pZTmlBVUxhb0g1bDBESm1pVVFMMVFO?=
 =?utf-8?B?QXlxeFRYTUFqU0Zta3ZMemVEckNQZ2kyeFQyKzhZd0JLaFpndEp2SmdPVkxV?=
 =?utf-8?B?cDlualZnWGdYdXJCbzdPdTY2WFRIVCtvWUZEdzU4a3pYMm1SRWtjemlITWt3?=
 =?utf-8?B?YVpYa2V2NlZvbyszd00vQ3dvRjBNamg4SnhrZk9ZbysvaFN0NmhhVmZzeGJC?=
 =?utf-8?B?NFN5UVUwald3WHU1RkZLRTdybHI1SEtvTXA5REZCc0FFQmNnQWs3Vjg4YTYz?=
 =?utf-8?B?M3hjU1BSRmc3dC9ZalRqbGZZVE4ydG1qRys0YldJUmFNc1F3MXh4cnpCVXBX?=
 =?utf-8?B?OTdtbkx6cHV3ajRHbnRla0lvZDRQY09UTHE2aWliRlFYTFBRekZEaEVDTUp0?=
 =?utf-8?B?VjBxYjNRVkZuM1dnRmtCQVZ1S0YvTS9ka1E5NzI3UDJUU2M5YW4zKzIvMVBq?=
 =?utf-8?B?VTZEMEUrb0pWS2ZvWFFnRURLOEhWY2Y4SG5LRDI0ZkZkbGRXM0NlMXhURVFP?=
 =?utf-8?B?Q1hSN3l5OHRaWml5Y0VZcHdVL2ZqTVBTelc5UkZ2dHp1dVNhSTJ5c2FQd3Vo?=
 =?utf-8?B?RnFKUVh6ajQxalEveXhYQWNXY0RXREEvcDFvczRxYm9NZ0VocEMzaC9hVm5t?=
 =?utf-8?B?UXg1UHVWT2VSTHZ6dVN4YXdqNTQ3dlZZaXBDZmtsR2trU1IrcDBVMUtBN0pv?=
 =?utf-8?B?dHNRVUdtajh3SlpXaFUvR0FBTXBWVEZKdnIzTmc3MHJCZjBCNnNNc0N5c1R2?=
 =?utf-8?B?c3BVU3I2dzlmWi9nZDYwOUhSV2JqUG10SGFqWmRzSGdhaVk1c3pvWFgwN2Jv?=
 =?utf-8?B?Z1I5Witpb2F1QUtaVGMxMXhhRTFSL0FzektSN2pERDBWVnVyTGJHL2YwTjlt?=
 =?utf-8?B?ZFhNSWtBMzJ0bUV3OUppcGI0RmVSYWw5YUplS0tHMkxoa2F6ZG0wNkxEckgw?=
 =?utf-8?B?eFB2akk5ZnRGQm5PYlN4ZWhJSXVZQ3d6RGIvTjdMN1g4NWw2aVJEVnlld1Bo?=
 =?utf-8?B?Z3dpRXNNcU1nTng4UEJJMFdZOTNkWXNiQ1g5dFRrQ2VPVUp1TjBFWTE2YmJD?=
 =?utf-8?B?anJ1WG5ENkh5VzQ5KzV4VC9iVmRTWFdSTXFEZzEwMGNib0lOUEFRUDRlVFRM?=
 =?utf-8?B?NDBXTW8ycHZ5aE1TYkp1QzVnU0hPUlh2UUI2YUR0cXFjOFMrQ0d0RGlUZnNq?=
 =?utf-8?B?VkFLU3VhdU1BK3FuUUhjZ0JoUzVrVElCSE84dGJDRytuV09ZS2FJSlFpYlZN?=
 =?utf-8?B?M3ZGN3N3QVlNbE8vMWNJRXlNeWtTOHhFYmFQOTJHUzExOGJwZ01rd1dNRk94?=
 =?utf-8?B?V21hajZ0anVaWWRjZjM5US9XVjR1NWt4aExoV3ZKSTJseG1tTWtwaHNUZEow?=
 =?utf-8?B?ZVhRanNlMlpQQTR0ZC9LbFRnM0Ezb3lQRGwwUTFEYWdlRzBJdmM3RnV1Y2Fm?=
 =?utf-8?B?ZE9FSFdwOFBzb1dwUWZYTkgzQk8xSTFQRWoyMVMxMUd6VkZ4TGRQcFNQdThB?=
 =?utf-8?B?NkxxN0FoUUdWRXczV3NOYkF1YWhXKzhWNExpYUF2WER6TlhFMXN4TTVnOWRP?=
 =?utf-8?B?NUwrQlcyK0ZKUnVzTVdRT3ZYMElqY0x1TGF4VHBQZ1FPSUZBZnJRT2RHSGNy?=
 =?utf-8?B?OU91WE9KbGtPTm12STNFY1ZKR0N1ZUhPRFFtYjI1aE9ZT21PYUN4bStMRFNM?=
 =?utf-8?B?bzZiRDdoVWdwbXNOM1REWldqYWN4NWlpcVJyMTBkODR3eTBTcnUzR2J0SXRL?=
 =?utf-8?B?VkxHcjVQNUNlK203TUZ3amgrK3JHVDZpUUJvMWk0NDNsTEZhRk1OWDVrQWFE?=
 =?utf-8?B?MUVvNkErWVpObkFsdktaRXY5Y2VtaXJjOHJZMFNwbWVEUlo1ME1BNlRlU09O?=
 =?utf-8?Q?keyFaZoePwBNhDPtYg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f703a77d-120f-4d1a-4c8d-08df1a2a151c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 10:53:35.6980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQLtu7uwDxXmDXf00ZedOQFZ+E0nJVS+33naz6cJMnqM9vo6SpzSO0yAv2Yo9x30
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865
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

On 9/23/26 21:33, Shahyan Soltani wrote:
> Dropping these should allow the GPU to clear the root PD only when it is
> required. Further testing may be required to verify this.

How familiar are you with trace points on Linux?

We have the amdgpu_vm_update_ptes, amdgpu_vm_copy_ptes and amdgpu_vm_set_ptes trace points which allows you to observe if the root PD is cleared or not.

Please double check if that patch here really works. My educated guess is that it doesn't and we need to improve the vm->generation handling quite a bit for this be correct.

Regards,
Christian.

> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 47cde5459469..1c3d3603af60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2640,7 +2640,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	vm->last_update = dma_fence_get_stub();
>  	vm->last_unlocked = dma_fence_get_stub();
>  	vm->last_tlb_flush = dma_fence_get_stub();
> -	vm->generation = amdgpu_vm_generation(adev, NULL);
>  
>  	mutex_init(&vm->eviction_lock);
>  	vm->evicting = false;
> @@ -2663,10 +2662,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		goto error_free_root;
>  
> -	r = amdgpu_vm_pt_clear(adev, vm, root, false);
> -	if (r)
> -		goto error_free_root;
> -
>  	r = amdgpu_vm_create_task_info(vm);
>  	if (r)
>  		dev_dbg(adev->dev, "Failed to create task info for VM\n");

