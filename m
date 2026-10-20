Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3A2606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ER9BUbox
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DC0010E130;
	Tue, 20 Oct 2026 11:34:05 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4FE610EA25
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 11:33:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UazTp/3v8nHp7GgDMY4zwONdUZGEXNnKjp65uIPCLz04IfUtivSKJY6ZbfJLsySU5Nq//rCpQml6arTXOsdCiekSA9hyUrz1BOSApSxBfTirrjK7Z1sIezkTtrvq5xV0o3T7Du6Wh/jFdB4dtZ9rjeYt1RDgq0ZEp4P7KK9Cem6gb7EUe5duSZ4x+nWT5GoosbCEfmV9slACnhFyT8Z2Mv8ngd2yiL+hK9NnpFeN7tVDOWlaWsjRI+r7esZn8DO8FhD9YKjn82Zp9CePO9U5fEm7KeOvuvdlkc0NlQ7qf38GO2KD1E0anhGp04Gg5rvFkzXn2GWtfuqA0jVQoDAulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys62BLQyU/3LQsYSBDRCVpDEg1kk4J8U2ya7CcnC24s=;
 b=u8c3PUkN0IQBbzJiVCEhxZUw1ZEMnpxH/m6WqPKq4RXDqZqiQXaQoGSrq37MVLp9QjuB/D/B95MqAOd2qTY0bhYanQRTv8C4NDtJKl69ZcFQ3dvx4D6TdB1Nfcl4vRcrf4f8KZ6z3KQvsZkaUOLwhoN97nsr+2Od+jrUJ+WvJPIF7et+zKYqfF5NmzjifFF9JNPS1LtJ2UAljY7hI5BemZgHuDcZnMj7U21VlC6gZX5SxHMCtz2DTSHKANCdNvknOHSpyqWmXz/8rgYhuFdrVkIvXfKY+9pyMaWSvK18mi1yN4zk8rTyZ/q1+ufuYgfNdJ49Jt8OfNMyjjOW7Gpmbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys62BLQyU/3LQsYSBDRCVpDEg1kk4J8U2ya7CcnC24s=;
 b=ER9BUboxOkDpeORDOLpzdzI3x2A0YRtgNih/K6ntrOt+eiLrLwEf8Mn8KYZfF0Lyw/5/kisg2hiYvEsSFHdb2PvdYsHcqDO2MDiCqGHo1+I1hxsMUhA5kRjS/Ke6w/KKAq9NR3Te3Y75wqEToNsHyRScXmLdbLeJ4z3K+DqFhMc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 11:33:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 11:33:55 +0000
Message-ID: <20e90363-511b-451b-8523-e07a7d6a960e@amd.com>
Date: Tue, 20 Oct 2026 13:33:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: don't wait for the SPM VMID's jobs under
 the VMID manager lock
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Prike Liang <prike.liang@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20261020083804.2777099-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261020083804.2777099-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e100c6-6e80-4e54-f3c2-08df2e9e0603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|10067099003|5023799004|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: PgmbKPeita7+UTfGfZqDyYieqlGFftFuYB8gULWfG6c/WyPkp7Sln11ERgSQ0Vke62qFvBlzXPXLdUwzXEAyn0k1TsF9ZCqsc4jYZpt4Ttswp3Sw8d9RxJl6eAFfcF+YwLGziXQAjVCsuMzvGMNmB5CLzNLO0oWLdhOxu5uEl7HSu4DZPBQ0cQVZJmk606TJkj6GWav6RN9cIYgdfgIWJc0Cdk18MYEYtXhDJQjeq37mGZcSJOIWBSuHXxgCC3wzaMLYUlSYChQde4Bq/d9IXsLLnwynKzFOD1d63sXJe/mVFFoAPT4eencd8MRd0UjXL/lO4DBYprVwhOkNhuzXP+TcjZ4lCR8XIgKwGIG4aZtJd85Lu/u3cWERiss5KIH49DzVtf/hq7iupcvBzM3BDehylKl8a1ba+6npRPMDBGuIleragMYw9lmtSxz97dRHQvcG8LuFBTaAHdBVWDRd9pN+27nL0HcK1Qpg9501erb/mOPSBwSq8ahCghi52uNiBWBXzn4N4GJttNsvZy3U2WXcXLg2dJ4aDdGW3bs/TrwHQPC+/ilF+jPXSAKMI/VdX11hqlA5UhZCGtx3Nay5W4nprxHXkd/sinI81hEv9I3J7RQqAULSniptb3qF8g5eZOMKiQRvmB+om3h+GqzW0cUH9RcoDOTiPOr1v0W7Y8w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(5023799004)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmFISlhFNHpkVERpRFFuSElwVzU5amxYbzR0UXFHWHBxWXZhd3pTSG5kaW11?=
 =?utf-8?B?RnIvblloUG14bUNuUEJKYm9mMTlLYkdLTWgxK0dxYXVwcFgxM0xWWnp1OXcr?=
 =?utf-8?B?THFiZW4yR3d2dnkwOHhZdnhoT2JNcDRLWG4zb3BSTlowTmduczRlV2RHQ3d0?=
 =?utf-8?B?bFN1bjgvek5LcWQ3VFFybXZraXdHdlpNc2NSME1semZRaU5OMzdQT29kazUr?=
 =?utf-8?B?Q2F4YWxLVEcrRGVhTXovYzd5TXE5OGNOczVqU2VJWkpJTHRscDVVbC9lRHAx?=
 =?utf-8?B?dE9FU0cyZElzUEtsdjdkMUdzMVdBblU5cGYrU0ZsZzdpdEU1UHUrUk02ZkxI?=
 =?utf-8?B?ZzdqTGk0TUNrVDhYVU5tdzIvRURUd015bENVc1lDc2ZQdTVHOXFaQlNXRjZY?=
 =?utf-8?B?UG5XWnFETWdjdGUxSFU2dHBFK1I3T3NjOTl4SGJSRE1hVEFTdUVLZmJUNWZs?=
 =?utf-8?B?dThsd296MXVKaEZzRGpBK3h5SURidkZkbFlDS2NHUWF5T1h4UTZRZGxLKzVQ?=
 =?utf-8?B?azEzR3RmbEUwVDdtZWtjaU1zZkZVS0pCMDl1bWtNc2RqUHYrczlUaW5HT1FX?=
 =?utf-8?B?ZEQ4SGlJQXZJOFFNSnNvNk9FOUhCSjREZGNYQ2lnajhsQW51NFVaZHBLaG92?=
 =?utf-8?B?UUJMcFltVkZ4VjQ1UjZWMTJRVzVhMHdMdTdNV0g4ODJERUEzTnEvREVON2lJ?=
 =?utf-8?B?QTZrYlRnYzc0dWhaWVMySGI1ZXhyTS9iSnNSVG1BTUVwUHZkeEo4ZUVoTXVu?=
 =?utf-8?B?Qm9iNjlEd0hhbTEzSklreU5PNFo4SUtsRDRYV0xFRGZNMmNNSjQ4VTVmMndr?=
 =?utf-8?B?T3NDMnlmbGZxcGFubTg1NHNuVnJPSGRZS1hWQno2dTkyS3RLUjBjc3R6Smha?=
 =?utf-8?B?aGl3MDY1eHZtbS9QaEdSR2NkdnlmY3gvOVByQkM2NDQvYjVIb1JMTDREMHVz?=
 =?utf-8?B?MkE1Y3JQdmZrY1BjVVgwYUZrb3Vhd1FyOTdCQU1DcmVoT3djNWFhMFdFUG54?=
 =?utf-8?B?TEVHN0o4T0phTWRVTDN4WE8zY2F6SjhXQkNuVHk1Zk9Db21XYUorOVIzS3ND?=
 =?utf-8?B?bitxZkVxeXk3NnhFaUFxTk55L1ZNcGtXZC9tdUZyNGhlN1NEdnlmUDF0b0Ix?=
 =?utf-8?B?ZDQ4eUZySTF4ZS84RExrcnBSZGtzaDZqdEFnRUNmWHdSWk4zbkhmcnJ2eTVy?=
 =?utf-8?B?RVBzemxUdThNdEs4UkJ0NjgwU0ZkSE5FMkZLK2s3MEY5bG53M0piOGVWQzVm?=
 =?utf-8?B?bXdHZWFCZWs2bTdRRnZid0VaYlhiN2xaM1dqbHVCY1g1UERhYnVra1g5b3hk?=
 =?utf-8?B?Y2hOb21rcjJ5VkxpMjIxUm4vUVRkR0tud1pycGRNVW9QclVuaXcwZUd4QXh4?=
 =?utf-8?B?a3BnVFVGVEY1eEFiZkxrNGR1Q2FhbGdrdDZ6cFhoT0NjWmRHd1dzdDNUK2RL?=
 =?utf-8?B?djVmZG9sVjVkQ1JzQU1zczV3OUpDNzdWN1BleklOQnRvZ0lxSS9aMTE5bTBK?=
 =?utf-8?B?N043SzkvcFdRV1RTZEZOemVRM2xyUnR3blNnQ1pWck5Idk9jYis5QnZmTk12?=
 =?utf-8?B?TXhnSU05V3p3S0JQMlgrQ0FZRVJ3bXpRa2owSTY1LzRUTk1LLy9VaWYvcUg1?=
 =?utf-8?B?ajNRbllsb1F6R2lGb1dNcXNHSXh0MzlMSU0vUjZYUlhsTFBBeW1lTmlrMGxh?=
 =?utf-8?B?NTJGYUxkamlvS2UxVUtIdVNvNVlWYjZ3VGpVLzVxTExDZUdMWGdjQlBLbVNt?=
 =?utf-8?B?MHlRNEZTb3pKTm5jZW1JdUI2RDhDUXo5azF1UGh5cHZEaGhCMEN0OVF5TlRL?=
 =?utf-8?B?R29pNG9aUEszSVRIUnVCVCtMaGJhSXlBTkpjQlA5enowTWdGN0Mwb2QwMTlY?=
 =?utf-8?B?cUNBTWtPZHUzS0xtaXRjTitnTHlLd0xVNWN0SE4vZ1ltbTNhcTFZcHRmVnJF?=
 =?utf-8?B?TlB4Qy9iSllKWUR3RW9kN0wybmpmMWhyRmwwWkt2V01jTGFCa0dGaFRmY2o3?=
 =?utf-8?B?c1RDRzBrZ016eFVwR0VieDZJak10aVNKVUdGbnNvQ0tkenE1VENpTUpGZm12?=
 =?utf-8?B?eWxacEVyb2JOVjcvdGEyZXNTTGZrOVA2cExPcmtVU2V0dmRBR08zSzhjSlF1?=
 =?utf-8?B?eXdDc0hzaERMZTQyN29QVXRsQjR1Y25VblR6WkgwNzlZYmduRTFELzE5Z2N4?=
 =?utf-8?B?UGIzdERFOUFjS0NuckJ0UGJoVkdhenZmakRlSXNTZ3dWQ2dDNUprL1loVE41?=
 =?utf-8?B?SVZWai9NMXFFVGFkY2VRLzRCRm1tSkdOTUduWktZSXp0MlFjQUhXS1Y0cm9C?=
 =?utf-8?Q?qkqyuHcVSFRjunebFu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e100c6-6e80-4e54-f3c2-08df2e9e0603
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 11:33:55.1859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+i3mQhXDRAhak6zpa+43+/R93ZHPDOFolc7FKMFWgr8OxIoCiqcMBf3WMhekqq2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/20/26 10:37, Jesse Zhang wrote:
> amdgpu_vmid_free_spm() waits for the jobs of the reserved VMID while
> holding the VMID manager lock of the hub, which every VMID grab on the
> hub takes as well. Freeing the reservation, by UNRESERVE_VMID or when
> the VM is destroyed, so stalls the kernel queue submissions of every
> process on the GFXHUB until those jobs completed, or until the job
> timeout if one of them hangs. A full GPU reset even deadlocks, since
> amdgpu_vmid_reset_all() needs the lock before the scheduler is started
> again to signal the jobs.
> 
> On navi31, with a GFX job of the reserving process that waits for 1s,
> an unrelated process' SDMA NOP takes 0.8s instead of no time when the
> VMID gets unreserved meanwhile.
> 
> Nothing adds to the active fences of the VMID once it's no longer the
> VM's reserved one, so drop the lock while waiting for them. Keep the
> VMID reserved until then, so that nobody else can bind it before.
> 
> Fixes: 9b47649cabf4 ("drm/amdgpu: bind the SPM VMID's page table to the reserving VM")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 1482fc031d44..d19bbcf25765 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -645,17 +645,18 @@ void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  
>  	mutex_lock(&id_mgr->lock);
>  	id = vm->reserved_vmid[vmhub];
> -	if (id) {
> -		vm->reserved_vmid[vmhub] = NULL;
> -		id_mgr->reserved_vmid = false;
> +	vm->reserved_vmid[vmhub] = NULL;
> +	mutex_unlock(&id_mgr->lock);
> +	if (!id)
> +		return;
>  
> -		/* Only for kernel queues and kfd/userqueues by pass that */
> -		amdgpu_sync_wait(&id->active, false);
> +	amdgpu_sync_wait(&id->active, false);

Accessing id->active without holding the lock is a pretty big no-go as well.

We should probably rather move the amdgpu_sync_wait into the caller of the function and wait for vm->root.bo->tbo.base.resv instead.

That should have the same effect, but we don't need to hold the VMID lock for that.

Regards,
Christian.

>  
> -		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs)
> -			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0),
> -					     adev->vm_manager.spm_vmid, 0);
> -	}
> +	mutex_lock(&id_mgr->lock);
> +	if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs)
> +		amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0),
> +				     adev->vm_manager.spm_vmid, 0);
> +	id_mgr->reserved_vmid = false;
>  	mutex_unlock(&id_mgr->lock);
>  }
>  

