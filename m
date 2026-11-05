Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF834606A328
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xfwZ9qwY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC2D1127D5;
	Thu,  5 Nov 2026 15:39:15 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3B5B1127D5
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 15:39:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVQhKWLAkbkTQf9Y1CVGldYOPROvyHbb7Zh6GLeD3B7ACdC+dwz2X3IYjw5rfOwkQfn5zRW0fMT0thawud+N1BXlPG2Htgm1T5VhgBpPXAQoXm7WIgwcVkYmwBvYtBHCxksdZvLgEOFRCdhkYGmoH92g1S/AhRr4fes2ciyDa7w97R0plCzNR8apwCsuzWWmCk2qAWSLwj1IdKYIE7Rx3W+vGSm/rK8qjjdZCtYlPhWFJP/Zt0OIQBR6yQE+B/4/PF99ln0x2eXt4wctiHmokDmaRk6FH0dW/5V2elwWQb6tEBqCX0xW0u23awJUOgaFS2pde3qWw95HoE8MedEtEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ul8y0abc8syisAhs+JnToJZEBExJW7KnGcOAcfboU7Y=;
 b=fPg9pnaQLgr7qUBBBmVCuVuTacma4vYIpG/vfV4MoymbH8b+0w7sy9JZv4LzIZXbUmWDAQ5l/48g5wGtTbexRYQmsE3ZJp89zX9TSktvF+faIVNA1moz3nOk1z1J6G5sO84N40hMIAKDSkNaCpg9RF9TCYX//7Uh71iecC2UbxTFaX5QgMAvA6lNow2cs7zUdssB8Mvo1HsP/yNkPtA+s4NghMeQPo1aeEZyo+GzxSDsnbm5+JjwGHDjnJrB9JuQTGMN8RFrqXOWBroZrTSa1wyxFxsdxCNuM7TYt8MBbRJ23EOvMkEi1vp+m5SNHTuibx8CYoqBH/znc/VxWHk5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ul8y0abc8syisAhs+JnToJZEBExJW7KnGcOAcfboU7Y=;
 b=xfwZ9qwYwN1mJcVHubhzGdh0+GhEhepKe9QH7wsW3WjwBLcVez3bcUFCAPIGyR0qDS+rKOOdVozyXb3vzw7kI39JneCkgYbWIoFPxt7hr3EE5kKR7HibROAYrhr9s1ziEbo3SLxy71rsa/VYxqs8xE2i579HJg7YxYAyuP0IcQ8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CH9PR12MB952423.namprd12.prod.outlook.com
 (2603:10b6:610:353::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:39:05 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 15:39:05 +0000
Message-ID: <fb87787e-184b-4644-9c55-98b3396963b2@amd.com>
Date: Thu, 5 Nov 2026 10:39:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: skip GPUs without a VM when checkpointing the
 BO mappings
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Philip Yang <Philip.Yang@amd.com>
References: <20261105092101.958212-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20261105092101.958212-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0346.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::16) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CH9PR12MB952423:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a5ba55-6733-4d66-9120-08df3b52ec91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|10067099003|18002099003|22082099003|56012099006|261021135927099003|5023799004|11063799006|261102123227099003|261021121427099003|261021123027099003|261009223027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: aay10wTP2BYfOvSuOodcD09TK9vGisDDXa/jeDNKspAmbE4i1aZdYQfMguelnQ9uiIUZqKxeIZ9jpfQQ593wecvG+k34HOwr0E/EdFvV5deX8YWiSoRJykGKFKAg+LVTb+C6FTF5QXZW4o2aYt8BzEiZa6Xb5PrKYfnEevW28jw2rBNAwJ29Q6FQ9YSw2/RfufCziGswDxqaIhye1V1gw9UQbpeOw5I//Zk1QliQjRdacy5v08MYURgXPTMTUIOWzgOKxvDGYp2B6xm7CbkG7tyqC9WS2sVCFVyx8Pbi6YA1dpT16T3FuOpJ7r9NruucLqOflAsU8caYcwBus0RYjg3RSsHkZJWWV/LvWBeTwPu/qG836ytqy8P/RF731OL7ydHu1bkfzYYn4nJox3jV7po2teaTQ/IfUjsYGactO97u5tdP2jxuUDjWI64JrNahVFwnglhtsK7SN1t8XFam9kb90YbCrLgJ17ILpJCW9a+GJxm2WrRPLdVsMRvRY+Ij2bG9FEJ4lY4emnVzpAhbJNr6HwdpMsH0K4+x9wKsQqDS8M/gVzJEQOT1GBjUavUp4VsCY+FCXy64L0UFHq4o1vVNH3ZbRQXFB3Nevguc6oEonVmUzJ9efSu4gjlSOQF/dx2/L7IuqqmuTR3F7s/GO9f6ApmzNg5Ta5X7PLTIZds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(261021135927099003)(5023799004)(11063799006)(261102123227099003)(261021121427099003)(261021123027099003)(261009223027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2dQYVlrV0xtSVIxVDIzbUp3SU1mRXNrMlpBZHBpc29lR0JjSUs3Y25idnpi?=
 =?utf-8?B?UENSR3RjOEdzQlhRUUhOalVWN3hLaVlaalVEU3l2SlhjOUhCb0puV3BHcitJ?=
 =?utf-8?B?T0t1VExYcTZvL1FTSUk4cGJSYytsa2xYdUdvNnJpV1lKbTdTSWYrQXJhbUY3?=
 =?utf-8?B?UWptU1BCRG1RNWt6TTV3UGlhRVRZNUJxc2dmbEkxbDkydERIdjhUK1E4RU9E?=
 =?utf-8?B?MnY3QmdEUWthblVVekszZ1g0OUJsVFVUbUJBcVBkNi9IYjROVXViLy9jaElU?=
 =?utf-8?B?d01NZGhQMnpZOWhvRStuaENuVlhhWWJaTFlGMWhYM1k3UXFRWENOb2Rjd0ZY?=
 =?utf-8?B?V2RKWitXZXo2Q0JXOHd4L0JHeXo2RWgyeVNmVDNkTVpGUGJXQkVZMzRRU0th?=
 =?utf-8?B?Sktmc3pHZ2Ixc0NzL2ZsMi9WTXkwY2FGYkRxWld0c0g3dHZNK1N1dm1GdnBy?=
 =?utf-8?B?a2VZWGZwK1lnTTYremxhRHJkdHpFdkswalpmYXE2RkpOY1M2VG8zVHEzaVVC?=
 =?utf-8?B?VXg3UEczeloxUU1IOW5MQm9jWk95THY1N0VLWGhSQ2dCbDRDN0Nocm04MHFE?=
 =?utf-8?B?RENhZ0NjUnVmbnd5OC9RNGxFSFU1U09yZG5Bb3V5MkxVVFFtUzYyTEVkdzF0?=
 =?utf-8?B?NGgxZXVHbU0rT2hnL0pCcExINnFEakxKWlFaZmxYNFkwNitxeCtIeEgwTVpX?=
 =?utf-8?B?Y3N5clRRWnMyRHdGalNBNjgvcEREQ1o4MFhBWjBCM2lQVmprcVBzYW55VFA4?=
 =?utf-8?B?dWNCbnJKRElHZW5EWHhzZHg4YnQ4bHZBOEN2bzhWYUxGdlM0eUcrc0FVWng2?=
 =?utf-8?B?cGZkUUJoSjRrVXVHM3VKMFBwbGo2ZjNJRTBHbHNCV3NLS0xIaXBFeVlPazlW?=
 =?utf-8?B?RU5RQXRJcUU0L2hodG5xK3NnNU9yRWl5NnBVSGFhaldyK0VnVUpUSnRkd211?=
 =?utf-8?B?QjhJMFowaGpKUHdtUHMvYkVGQTBnbWFyTWpNTVUwVkpwczhYMHlaTUVjaGsy?=
 =?utf-8?B?SGU5VkNpVDR2TFFOQlIxaDdBdU9ZeExrVmVKSDBjQ2JmRFhtU2R2ckRlNGRQ?=
 =?utf-8?B?eENQTHhkc09pZ0t1VzFIU01Bdm43TWZxK3FqaEJPNWp5RGwwV1VPY2ptK1di?=
 =?utf-8?B?cDBURWgvQkVuR011OWZ6RGF5a0hQQkY1MmZOMXJnQVZvVWlNRGtJbG1MQm4z?=
 =?utf-8?B?dW5YMncxbEl3TURDSE55QzJvd1d0czltbS8rM0t4bFBBZElYVmluMUc3VVl1?=
 =?utf-8?B?WU9HK3F4dFV2SjdOMDUrZ01QeXRoSDdoVUdWNHlITlNaOHQ2R3JFRVlkS2lH?=
 =?utf-8?B?NnpMamVQUTVnLzNQYlh4RTNjVVdvd3AxaFBkMi9SM01veHVNWlV1dTBhK215?=
 =?utf-8?B?UnBHV2FLK3N0OHVKdlN2dWpIUjFEeTVYTWZLaGtSaW0ycm92T3I5NnBKY1kx?=
 =?utf-8?B?UDhvbmtKR0JlVHVmYWdCMVBLcUdlSGZoKzg0NmY4L2pkUzFvRHlpbnJ5a3Zq?=
 =?utf-8?B?Nkp3WFFxbnM5ZEVxRWhxdGVUaEpjeUN3MzNTYXRPT3dQVXFmd09XemRaWVNn?=
 =?utf-8?B?ZU9CMzA2TVZwdHVRcUxidlAyR08wOUNaZkJ6bHBZWnZRdFNuREVCdkgvLzZL?=
 =?utf-8?B?NStSRnpUeE9QV0hjU3NmVG5tWVNzOEl1c2dpUEE0RTNSd2pDbEdhb2ZUMVlm?=
 =?utf-8?B?TS84dVdjQkwrenRDMEtPeWc1MkpXdDd2RDdXK3VkVmJWUDFhTkdZNXhZcGp6?=
 =?utf-8?B?cTg1eWl5b1FYU0lXdmFMVVd2bFlOenFia2xlU2FhZHlkb0lnd1JoQUhROUo2?=
 =?utf-8?B?TkhkOEZOVS9TdE9GSFdSVXBhSUxqQWt0NUxXbWJ5Qklna1Y0Z2tscXVvS3hE?=
 =?utf-8?B?bTFUMDBJamFmd1Y1RzJSNFp4dFgxeDVBMzIyaU83enA2SWMreThvRUZoWFY0?=
 =?utf-8?B?U21sKzR3NG5Kak5kUFA1V05XdjY5dEF4ZkhxMFlKOGZMM0N0eUxKeU5maXEw?=
 =?utf-8?B?WFZnOW9PczlraEtveEdMMVEyaFVMcytFRXFyM1g2RkNPZDVBWEpIaTZZTWQ5?=
 =?utf-8?B?ekVqOGhBTlZnYVM4eTh0V05KNXRNOTJYMGtnSE5oRnYvVDNoNUdpNEhNSGhX?=
 =?utf-8?B?eFNOamxja3lib2t6eFBPR1g0VmpHbXBaSnEzM1VLdjZYNWpEUXRJR2tvVTdV?=
 =?utf-8?B?VUJ4T01RVHBNU1ZhenFQVG9pOVZLODVBV3hhZVZxQW1ackMxMSszOXZVemJY?=
 =?utf-8?B?Z1JHcXJmUmx2Uk5nWXRVbmVsbFcxTUo3b1MwN2ZLSjIwRU5pTXgxaGd1ZFIz?=
 =?utf-8?B?NFJTUGtwaU1lV2wvQWxWRFQ0Yndra0hWSlpJWlYwRjhUR3V0bUxFZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a5ba55-6733-4d66-9120-08df3b52ec91
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:39:05.3701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHEVMjZWBE2yGllnFju/lBy9IRkZfDrQRxm8AalbNk/H1XF/lbfjjIxQS5kPswCxWxbhCUfh2BNOcZphynwKWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB952423
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

On 2026-11-05 04:20, Jesse Zhang wrote:
> criu_checkpoint_bos() asks every device of the process whether a BO is
> mapped there, passing its drm_priv, which is NULL for the devices the
> process never acquired a VM on. On navi48 with its iGPU, checkpointing a
> process which acquired the VM of the dGPU only:
>
>    Oops: general protection fault, probably for non-canonical address 0xdffffc000000002f: 0000 [#1] SMP KASAN NOPTI
>    KASAN: null-ptr-deref in range [0x0000000000000178-0x000000000000017f]
>    RIP: 0010:amdgpu_amdkfd_bo_mapped_to_dev+0x35/0x160 [amdgpu]
>     kfd_ioctl_criu+0x30d1/0x4aa0 [amdgpu]
>     kfd_ioctl+0x767/0xb10 [amdgpu]
>
> Nothing can be mapped on such a device, skip it.
>
> Fixes: f9e292cbba21 ("drm/amdkfd: kfd_bo_mapped_dev support partition")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 6c710e4a5220..56f9ed14a2d4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2175,7 +2175,9 @@ static int criu_checkpoint_bos(struct kfd_process *p,
>   				bo_bucket->offset = amdgpu_bo_mmap_offset(dumper_bo);
>   
>   			for (i = 0; i < p->n_pdds; i++) {
> -				if (amdgpu_amdkfd_bo_mapped_to_dev(p->pdds[i]->drm_priv, kgd_mem))
> +				/* nothing is mapped on a GPU without a VM */
> +				if (p->pdds[i]->drm_priv &&
> +				    amdgpu_amdkfd_bo_mapped_to_dev(p->pdds[i]->drm_priv, kgd_mem))
>   					bo_priv->mapped_gpuids[dev_idx++] = p->pdds[i]->user_gpu_id;
>   			}
>   
