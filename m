Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB93ACA5FA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 11:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 867F310E915;
	Tue, 29 Sep 2026 11:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X8zMilTX";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010041.outbound.protection.outlook.com
 [52.101.193.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1D3B10E915
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 11:49:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wb8Hg5xsgW9OqhfIjXQNz+4KSMRz3jsCEHbaB6c1IUoIq2N3saYGy5HkQa9sqa9u6pClJowxamwNaG+jPZU01cIhUOiX/RDXBXFXrGkFtWRLy23Fa8OI1ldLK1tIUUsFylhN7RBngi/vGBZhMkDICovS63JfqLLZqaD1qQVltLgIwabN/3IxeNhAQwHrIE/jb69ZiZguDKJw2BZwVCejQCTA1/CCrDzFkVeqwmmcl2VgYXh5NkIVQyTT5DYQu7vqDsVllY4arAyQpXFZjaZbK7hQ9A9X/+XK/FhPZLi4YtKqQUPWLv2GVkp2Jko97DcR2ysyQ/Fh3HOLUFdyAc/Jmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YWt1Hb/lQkcQQQXn0d8NdjAtmd5YevX2xVqbPgHwX0=;
 b=yhyt5AlPZbfBgAwQjK1TNNlyqsEeA7oMKK7QirQBS853QHMTBNciDpKG3i9eRMUnx3DXu46d1c3xZt+Yz5po6qaXajvNE+yG/wbM5NedHIAQNboS4h2HexG7WKj2aElJP5O2uhspFUsjGkGMG3UuUJx66o9oAw/l4QegAVFSaYcd8PMpmbAfRVneFJv54dlA2C5PGidzN1imW3rl7zlNMlwjeRUUVrSH+CMyt/pvJ3KNSBUjJIKq9Ol822pDV1bC7GuIF6P8YwnB6/5JhY3OJ3+UM9J3iI5lSdmlYT4vBlaMLVjw4HFCEDN6Vxrr87QTHymi6oVVSJDjdvfIG579LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YWt1Hb/lQkcQQQXn0d8NdjAtmd5YevX2xVqbPgHwX0=;
 b=X8zMilTX2291/g090Xk2qQK39LRzIluNDqCp+Tz0+wupSyFgfcL2QzAhRpXPD4D+X9dFqWimwUwMhr576+ZHcZiGHsY1ixZrk9AdJyX4WWoAYJMJxeUM2AoDau4ipddyFqdUxhK/ZqeGFWg8XIURVuKVBO18T/zI9RY9cKKwSaU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CHBPR12MB790180.namprd12.prod.outlook.com (2603:10b6:610:33d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 11:48:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 11:48:58 +0000
Message-ID: <4731b165-af7d-4a1a-a06d-cc817e80d0ca@amd.com>
Date: Tue, 29 Sep 2026 13:48:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] drm/amdgpu: hand out the dedicated SPM VMID from
 the reserved path
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Ma Bing <Bing.Ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260928185756.2382322-1-sunil.khatri@amd.com>
 <20260928185756.2382322-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260928185756.2382322-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CHBPR12MB790180:EE_
X-MS-Office365-Filtering-Correlation-Id: 951874fd-9fa4-4796-ff03-08df1e1fa5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|5023799004|11063799006|4143699003|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: K4G5/xr/brN9hjf631fdesyB1ye/Ylhy9uRVImsmLsCSk5ESp69KZfhNMrBj9QEax2lvfQlOQa9bFIXK1J4Yqk6nRweUT14XA/5leRUGG1c2vHlbffbAjDBkrqVhiUjhFSq13ut2+E0gRdcKmTv5gDbNBcny59nu4Vmawh90jnIDVx5S3TXhonX1YOEL49epeYcExrQ6faqWjSJU8DYVdADjXTgNNy8J7LmP9PAtj2RC4DV6tLECD9kPt9dFeFSrFFFam4G7ztfbrG9zCKgtTVmpkpwU74tyazXGT6+Bp/nZpjYwJO+MvMvKSKThaMSWPqTvHZ4KJeJokP+y+ok1HzK8KQNwWCv/ygvKyGhpRlaPqcjO9ZnQMGPvKBKtSUjMNqaKiNJvsdTAJWz+H7AvDTkCSQIrjfaq26wjdleE7h1Je+osaoiADgtr0Mkqe+zAAMBa5TFXVoNrT1WRumQa8Z4xBz/2RdthYIJRhp826DKlguVy1ANa4BCtWguW8PCc3JyRNF/9DXMnWTzj4oKLepJ0+qTJ2E+lEsQAruITupUXx7DQeHZTSt1GAZN95mbpgBuZdu1z7CKOfV3WNsfhLUnEHKhVEkPIe8iSTYSxFsyqj1EAC65QjxHJgaIzJX6Kg3fAT1ncUlXAfp1BNKtc9fBsDuOxnO567xhz+exrlgA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(3023799007)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHBwS1hZdEZyRENERlkxTmxkVnU1TnNHQ3prOXAxUlYxYmE0OVBxY1NTQVV6?=
 =?utf-8?B?bGM3dFJoUVlJNCtzRzNhN20xeTlrMVNRT2V2K08yNnFSUkhIb0cybjVwbytB?=
 =?utf-8?B?cGg5V0t1RXlYQU1nMk00MURaNi9JTkFKR2hydlJSYW91WFR3bFBzVExEKzZu?=
 =?utf-8?B?c0hKQ0tIclVWUm5vbE9WNGhtV2kwVytyem4rS2Y2V0dKSWErdS8xUDJHK2Zk?=
 =?utf-8?B?Zmpta3NhdE83eCsxWE1BM0dkamdyS09scVF4MVUyU0VmcHl5MjdPazYvai96?=
 =?utf-8?B?K1I2NEwxN2lSM0tEYXk0bVE2UW5YRWs0UWowaWVsaTJTalRiN0VEUEswMGM5?=
 =?utf-8?B?aWVEMk0vL0VrTWwwd3p4Ykd4NCtqR0lFSlRNWkJzQkVLYzNvbllDSk9LQlVw?=
 =?utf-8?B?bWxJTkQ4MjVTbks0SUIwY3J6ZkpUWHJLd2ZDMSsrWnQ0a0tTNjlqQWdCaDVw?=
 =?utf-8?B?Z0paOHVQRlQ1eDVtZHh6QVh2aXlQVGQ3UDcrY2p1RUJRMVIvcS9jY004OHhz?=
 =?utf-8?B?aEx1Z2J4NVd0YlhtaG1Yc2pzcVpidVI1SzZLSlFwSjdZZHo4eFFJekRRY3RZ?=
 =?utf-8?B?RDl1dG5pR0ZmVlU3aml1c0N5SWg2L1lUcTRaTjAvZkFsemljckJ3SUZZK25I?=
 =?utf-8?B?MjI2dkNaR3Eya2dyRkRiU3FFWWx5b0xxMXdSY2l6KzBtN2dXN2FBT0ZNbUJW?=
 =?utf-8?B?dnlBZGpqMHN0WVZSU2ViVHVwc3BnUkpoaFprc0FkWUZTR1RZSXJqMXo3eWlE?=
 =?utf-8?B?dXRDR3gzbnJid04vNndwWHpiNkhjc2NhUFR3dWtQaUxEcGVjV1J4aVRFQ1pM?=
 =?utf-8?B?MCtXamdoUGZrUXpSdVVsSmU3akN3WTRzai9UNHgrZGRYSGJNRWNWUjh0VFpG?=
 =?utf-8?B?TjFJanFDVFBlQy9CSGNMN2JVdmRhSnFTbmNJM2dzNUpLWTVHcFBXNWc2Kzcw?=
 =?utf-8?B?OURyMk5DTkg3ejdwdGs2TTg5RGtxdGNOa1czK1BtOUc0UzR3ZGRKcUhKNGtt?=
 =?utf-8?B?bEYwZVdsZ2plbGp0MTdQaS9YUVNXR3ZqdUxXWnpOS1VuekZ2UThqM1pWTVhw?=
 =?utf-8?B?ODQ5TStZY0grRUdKYUdGc2RISVphb1BvMjkyUnNtUDY3UE5qL2ZKS0hmenND?=
 =?utf-8?B?YUhoR0xXSXFheVNFNHBQblpGUzk4K3VVSHp1enZDOWJhSU9pREFXRmZzR0VZ?=
 =?utf-8?B?eHZSVnVDT05ZVi9MNjhhWHRlYzhSUFRwTUcrazZqNC9tanFNWHR0WDcvRmh5?=
 =?utf-8?B?eklkQ0g5ay9CZVpZVURYNXlZMXI2SjJGOFkxaWlvSnEwTFVvTUR0c0I1OFFC?=
 =?utf-8?B?bk9jVmxxd1ZOajJ4dU9NRGNhcHdkQithNE9RbU5qNnh0N1FmQ0kxejBUV1RH?=
 =?utf-8?B?U09YZExBckNvYjc4QjdleVRwcDVPVS9NSnJRVEFpUDQ4ZDNHL3lDQmVIcVB0?=
 =?utf-8?B?SjFJbm8wVFNYSHNNeUhEanBjaVdyV21nZHQ0RTltajMrVFVTM0ZZQklLdWli?=
 =?utf-8?B?RVVuVitDLzVpWC80NUVpZXdIakxOdkQ0UndRYVM1c0hqNFZ6TnJWbWdHRGhJ?=
 =?utf-8?B?eHVramhqem02bHlVTEg3aEhUUnl2cHBJaEVJUzNRVmF2MzBxMDZKT1JYZEZo?=
 =?utf-8?B?aW1WTzZtSFkvYW1IVXhQOGEyTWxVZXltS0lrREdPZUdhRDFaOW5VU2s5QzVK?=
 =?utf-8?B?K1Jwc0RqWHphcnhUbVR5OGl1ajIvZ3dtZkcvYTRXZDdoSXNIaWt1T3dEbUVl?=
 =?utf-8?B?UG5qTnViQlJTVzY0d1lydExoZ1hiS29VRVhQMThzUU52eFFPYWZpRjJmR2cw?=
 =?utf-8?B?eWpEM0s4MWNUajduZ1FTcitEOEUwaFZGWjI1dUU4R2o1aXNnM2VLZ2tKL3RM?=
 =?utf-8?B?a2FkVmpHUy9GTWxtaHZxWVRVRjVodnN0YkFseGJldWNxa3JjR1ZpNkJyam1J?=
 =?utf-8?B?RGVhR2RsbklBSjZKTUV6aEVuOWdJcDhkd2V6VUFoaUhRcG54ZE9kencxa1Ir?=
 =?utf-8?B?cnlxNVBNeG9IckttMEVsb1pBb3llblRzbnZnMGFNWUtwbXB2Q2dxTXdDWEVo?=
 =?utf-8?B?Sy83OEgzZTFaMnFiT2pWMnN2SGNuTk5qVEZiTVdoY2FDN2pWbmJKTm9teW1D?=
 =?utf-8?B?bGpKbHlzSzlYdWlpQkovTjNiNTdQejg3SW1xeU1pa0lLenB5TEUvMGVrZ2xs?=
 =?utf-8?B?TGx4eHpqY2kwZkdubHE5ajhGL2JlcU9YVjJ0dkxHRzZqa29CU2tTeVZKUmxT?=
 =?utf-8?B?ZFZ4TGZwdEhmcml1TUFoNko5bXpmK1ZLQ3dYaEM2MTlWOXg5WDRQRVlzWVR3?=
 =?utf-8?Q?LSv7hxwO6K9YQwOIVF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951874fd-9fa4-4796-ff03-08df1e1fa5a3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 11:48:58.3722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGvm7rdx0VYRxFZAyD41cfrh3N1Ga6zV24YsQTNF+qi5tTlDOy6ydnJhosTWZLMo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB790180
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

On 9/28/26 20:57, Sunil Khatri wrote:
> The SPM reservation borrowed a VMID from the GFXHUB round-robin pool
> shared with normal graphics contexts (VMIDs 1-7). SPM streams its output
> through the selected VMID's page tables, so sharing that slot with
> dynamically scheduled contexts is a poor isolation boundary and makes
> the profiling VMID non-deterministic.
> 
> Reservation now uses the VMID a hub dedicates to it. When
> vm_manager.spm_vmid is set, amdgpu_vmid_alloc_reserved() hands out that
> fixed VMID directly; when it is unset the reservation is rejected with
> -ENOENT rather than borrowing a pool VMID, so a reserved submission can
> never end up on VMID 0 (the kernel VM) or on a slot shared with graphics
> contexts. The dedicated VMID is not part of the round-robin LRU, so it
> is given an initialized active-fence sync on every GFXHUB instance in
> amdgpu_vmid_mgr_init() and amdgpu_vmid_free_reserved() has nothing to
> return to the LRU.
> 
> The behaviour is gated on spm_vmid, so hubs that do not dedicate a VMID
> simply do not support reservation.

That won't work like this. The SPM VMID would still be used round robin with that.

You need to take the VMID completely out of the mask. Take a look at when amdgpu_vmid_mgr_set_vmid_mask() is called.

Regards,
Christian.

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 5e424e3b6e71f..c8cbd0851d478 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -551,9 +551,12 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		r = -ENOENT;
>  		goto unlock;
>  	}
> -	/* Remove from normal round robin handling */
> -	id = list_first_entry(&id_mgr->ids_lru, struct amdgpu_vmid, list);
> -	list_del_init(&id->list);
> +	if (!adev->vm_manager.spm_vmid) {
> +		r = -ENOENT;
> +		goto unlock;
> +	}
> +
> +	id = &id_mgr->ids[adev->vm_manager.spm_vmid];
>  	vm->reserved_vmid[vmhub] = id;
>  	id_mgr->reserved_vmid = true;
>  	mutex_unlock(&id_mgr->lock);
> @@ -577,8 +580,6 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	mutex_lock(&id_mgr->lock);
>  	if (vm->reserved_vmid[vmhub]) {
> -		list_add(&vm->reserved_vmid[vmhub]->list,
> -			&id_mgr->ids_lru);
>  		vm->reserved_vmid[vmhub] = NULL;
>  		id_mgr->reserved_vmid = false;
>  	}
> @@ -670,6 +671,10 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>  			amdgpu_sync_create(&id_mgr->ids[j].active);
>  			list_add_tail(&id_mgr->ids[j].list, &id_mgr->ids_lru);
>  		}
> +
> +		/* out-of-pool VMID; create its sync here */
> +		if (adev->vm_manager.spm_vmid && AMDGPU_IS_GFXHUB(i))
> +			amdgpu_sync_create(&id_mgr->ids[adev->vm_manager.spm_vmid].active);
>  	}
>  }
>  

