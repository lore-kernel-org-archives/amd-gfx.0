Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB71CC6B10
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA6F110F5D1;
	Tue, 13 Oct 2026 08:00:40 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3669010F5D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:00:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjtkRcNpG2vLllif7D2qyw642LAW7XJhs/uGO1gxb5J0FfC3LjhsxcN+xg++q5mFwTCVY9M9ffbZTR+wofYcMi+Xs9JoD/IKT0HQWgyitYPTgeMjKfXPI0tFHOssLDJ9HnwulkP7e/Y51rl/1r/VUC+nhMi1GYsQo4+tD3ZFcSuY+l8NVPZbhzmG5Ke9p0qvyJbnMWZ3cNjMvX9Su2CRWaL0q6HaIBt7U+cUhk+bEJxKjzU7th9H4RahCnuVOjJMC3TKGk+ycvQkY1v98qdxmo8PqIyx+/Le8fFDK0jONO+pyoHmu3YvK+z5PJIdXmW4xcdyZgKn0LEzDWcORpAVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFtbi7nRfW0EmMnJkSfD6BK1eecqSJEVcS6cYLjhGSY=;
 b=e4c4BOsLCX4Pr4iK9uQTVcKbGR7vnPqWZU3dOWx/pahROBwhR9WZu/zJdMYEVfBDmflhOeQc1K+6xLPPux6ne8c2zy9Daoaumd1yUFRbxxMRTQ3MZfoZX0/tvXuGpOhjkUn9i3RDBuhz6w9BPXkxHT3JkNaE2jcpB8jqVKmOxV6Dy0ihplf6a8Y12uUhDTFLJ/JeqQiGYwifKvpY18uSTp9Pq97ct9zIcCT8XWZ6jOp+KYTmimjjpj2WRrj1WqGvXperBMc6iDYuo7EHAzIYUlKAXT+35t2zqH1bYFYWiKtlVV4Q2XGLFiLko76D+60nEgFdhySQV9J25/VieVRePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFtbi7nRfW0EmMnJkSfD6BK1eecqSJEVcS6cYLjhGSY=;
 b=aUeDHUOyxJ/cuVA51lBg9AGETrJvLihbnuAQ6TfJOINd2glAYVuY2387y17ju0nlQfhTiO2peH6usVmfwTeFS6WUTOpMkc+bV3Ng2jkAaU0suMCsgHfc5rbmNeOhl9WHIw/5DSnin5I3evr4DT6XSCxKwA8yN6V98itwNMMpXJo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 07:59:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 07:59:30 +0000
Message-ID: <922c9817-1677-4df2-8313-0cb65e734d30@amd.com>
Date: Tue, 13 Oct 2026 09:59:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/13] drm/amdgpu: use dedicated SPM VMID from the
 reserved path
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261013075644.775162-1-sunil.khatri@amd.com>
 <20261013075644.775162-3-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261013075644.775162-3-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: b34c843a-ab51-47ad-e491-08df28ffe8b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|261009223027099003|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 6YAmILnhkLpjFKDOpq7+gPBSQcuAQpV5dkOCMDA3vxIPZa9sWKOE/sk+cg7dx/nBulKbLs88CPF6Z32Ue1tSyWnc+CAyKYo7o8UaioLzhzdUtGhm8ZxBjmyzoY99l+UGNfgBo0nqDfo220cLq2JhcFohWkyupOOgUEewvASqNUA9bZ54EekaJ4UaRzz4sCnCYzW3CIFwXBU0Ov4thAqMDWlULaZANwBONeuV/xG4+YI04PqSkKaYhtIBvW9dFsBmHpfg/kLQZvoduOiLkKOzHw/pOWRNADS9gw21VpmFWoxGmlpMY7ZQJbZHYiop+N2ab3nDW99SHrAsyiKbYzrk0RlY1jUSaEkEmCToJ4ikG8tE5LQQEB/VSukJ1kwsmGQMGTKyXN4EGxFLWj9FJdgVJrxH3W1sZYgloobSaEHVM/AeOuNGBfRjsrR5adkZBmicDKA5uUhYhBgCHQFrSflgXFPZv2EGErxBxtNCqvITD0F+eCdMipXUPURCdD5bFqrwAt+lpeNSFcZ1Ggxry0V6Iq+oIEicpOkWQ5AhegVax0s373Sma+ujMkxC9B92wiwGwQ7a6vYTqm4rghm9zjN3199FCkdF8scGTsD8xnxfdT5QFdLyI7aWDcKTQzjap/lBXITUkO5WoCbwE/bfZ/X/cTIpP087TH+OIgcRYuob/z0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(261009223027099003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkxKU1V0ZzhjZ3czRUE1UmMxN3kxVG40T1VXK2JQa0ZRcHBqWlJPeHFLekpK?=
 =?utf-8?B?blB2V0UxZ3ZON2hVUGdycEZRVy9EM2RMM1pXZFdGeE9memp1K01Vb2dBUW12?=
 =?utf-8?B?cmtUK0puZkxsU3RLVC9iUnQ3UUNGZkpTMWpwR1R0RnMrT2VmdHZ5b1FyNzho?=
 =?utf-8?B?N1JUNHZxZzB6aE45eVhoZkROT2tDWTJyTS84dE1kMWRCUnJIVkFmUVZ0TExt?=
 =?utf-8?B?NGRZbUU5aHpWR0wyQUZqeDFpZnhET1p3QWZYbGlHUS9LTGdVSkJVcjkwdXFV?=
 =?utf-8?B?UTRpSXpJcHdOTHcxUVIvQ01YeG5KS2dFditrRGlvckRsUXR2OGk2S0txTGR3?=
 =?utf-8?B?U1hSV3pwOEhjNFFiQ2MyZmdUM1Q4Um5zaUtBb3NEUkIwc3RyYnpBWDhhcFNh?=
 =?utf-8?B?bU1CVUZVZUkvVUlyK1BnVmxTY2V3MVNNR1FYUzFlWWI2QWUvSXRqNTlsUW1C?=
 =?utf-8?B?cmxFdFVOWWRqZmp3VnMxQWRlL0xIRTJMV1NKRTI1UnZxRlR2SU9TTGdGeHdz?=
 =?utf-8?B?N1NYNXdNS2MySHpBaVp6Z0prbXAvdTRvN1VKWUtybCtEb3JTZzlqbzltUEZ3?=
 =?utf-8?B?V0loU0todWRJQzRUZ04zV3NtMkh0V0VpT25ZeEFWV1hyVnhiN1RrSGV5MEdR?=
 =?utf-8?B?WS9SWFl6QW4yd3ltN2F6bEQ0T3BMNUNWTXNZM01jbnlTditRV2M0UDluMndi?=
 =?utf-8?B?UTVKRGZIVTRyTWxIeVp5T1dlQzVhRTI1QVdxT1FVWW5lOFQ2UTIzcTdmeWhu?=
 =?utf-8?B?ZkIrRitFcVhLWlBHd05qazl6dUZMUldMeEc1QnRQZy9vb2QrQjJKaW9JOU5R?=
 =?utf-8?B?WXEzbDd6K1RUOWFCeTdjTS9zaUl4a2ZBcnA4dkQzenE3VUhvaGZlVy83bDJR?=
 =?utf-8?B?clJuTHRtY1VxaU5tK3ZwZ2FKeHF2dW1DUGhaVzI2ZW1icjJKdDE3d2xLQWM4?=
 =?utf-8?B?Y2hYZlZnTmZqVzBnTmQrWmxHcU9ZQi9jL1pscjM1dDhBaWswYnNSWjl2L0l1?=
 =?utf-8?B?Y0xIYlZLU21MVStnaXU1czN1b0l4bS9oTXZkRndGNTYzMXk4b1BXeUhSN3lB?=
 =?utf-8?B?VmRiek5tc09BRGVGNGY5dk9VNCtlai9FUUVkdFRockk0RzFhb3dlYTIxN0hL?=
 =?utf-8?B?SlRzMjUycmNjNzNFT0NLNC9XaWpiS3BXdzlZMnh4T1paeDI5OUl1ZytNaHQr?=
 =?utf-8?B?eGxIK0dOVzdKY1gyTG5uUkdxZjlKV3N4OVh1VzdYSUptbUZkWHVPSTBzVHVr?=
 =?utf-8?B?WHJnbFA2bEk4SWxJTFY3SGp2V2FHbVFyQ2tmcVN6MzBJaHJINGE3MEVLYlFL?=
 =?utf-8?B?MjlSTERvS0M3U1o2bmxWb3VQVXRIYVhwUThTS29TUlFjbktDbW5uOFJhSEpt?=
 =?utf-8?B?d2hER2RLREs4UnIxa3hXa1d0QkZPT3Y3S2JMK3dGMk5uM21ZSEhOb21ka1N5?=
 =?utf-8?B?WDRYY1pVTnE5cjVnRjlKUlliTzlETWVPekxFZ0dodUVpNkVuNkp4bGZvRDE4?=
 =?utf-8?B?bmlIdERQaHZlSjdsY1VTQ0FxUUNxT2IxdFI3bzdlejVSWmtMemVPRHhvYjNh?=
 =?utf-8?B?VUFkaTZwK2NpdDhDaTZoVGt3U2tQU2NUeUh1NFI4bmFyZ3R6bmsvZ3oxTXRX?=
 =?utf-8?B?bm92aDlSRGNTTGduN2ZpQ1hwdFM5TW1kS29BdCtUdEhrYkxqMjVQcWNreHZI?=
 =?utf-8?B?R1lHVGNpeGNYNUN1eXRDa2xqMlBGOXJwcjM4Yk1scXNKdlYvK0hlNG5kendX?=
 =?utf-8?B?Rk90bHFRTVEwOHoyVEJMT2pSMHBVTzVGNml6TGZIVDJmRVRBZno1NEZkbUdu?=
 =?utf-8?B?Rms2NUpwcnBuSXZKNFYzbDN3N3Q4SFRkdVR1aEVSUVovUy9rY2czdTVDdVV4?=
 =?utf-8?B?eXg5cVBnd3Z4RktWVXhTeEVFWXhlR2JCa3NWMUcyWHZ3aEhONUxMY2cwN2Q1?=
 =?utf-8?B?QUJidUkxNVBYd1JIODZlZGtzS054b0FXTWJoVlMzYWZUZDRpRkQ3UjRZUVJL?=
 =?utf-8?B?MnFwZ0RkSk1VaFhwQmN5eVRpVUZvRGFIYjFOMFNtMkhXajExcmF6NVR5M1FQ?=
 =?utf-8?B?L1dKb0crekFEWVRmZm1lSjd4NU5yMG12VVNmOW90ODd6SXNTZDU3bXBxZmNG?=
 =?utf-8?B?b1FnUXByNUxNVG1vQVd5RmtoVFRqbm9zdlZBRGZtZlBWVzM5bFVRQVZSU2VW?=
 =?utf-8?B?L0FKNjA4OUt1NWdnWmtUNlliMG9EZDlMQ241eGFCY0VEY1d3SU84ZGV0RUE1?=
 =?utf-8?B?MFczajRGakhjbDhoY3ZQTkRtOVdpdlljaU5RZzl3dHFvNk1uZ2dUQUZESzMz?=
 =?utf-8?Q?sBVsksG/QzmEZ2Eu5w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34c843a-ab51-47ad-e491-08df28ffe8b4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 07:59:29.9281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WA5peDs2ELP6nhRGvlVfP20d1Rq7VPIlhqa/fScpamynBB74oXdcJ/7sy2pI5p5+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
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

On 10/13/26 09:56, Sunil Khatri wrote:
> Use the spm vmid which is dedicated for the SPM only and update
> the function paths accordingly.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 30 ++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index ed1efde29a9a5..0eac7695f5587 100644
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
> @@ -628,6 +629,14 @@ void amdgpu_vmid_reset_all(struct amdgpu_device *adev)
>  		for_each_set_bit(j, id_mgr->vmid_mask, AMDGPU_NUM_VMID)
>  			amdgpu_vmid_reset(adev, i, j);
>  	}
> +
> +	/*
> +	 * The SPM VMID is not part of the normal kernel pool, reset it
> +	 * anyway in case it is used with kernel queues.
> +	 */
> +	if (adev->vm_manager.spm_vmid)
> +		for (i = AMDGPU_GFXHUB_START; i < AMDGPU_MMHUB0_START; ++i)
> +			amdgpu_vmid_reset(adev, i, adev->vm_manager.spm_vmid);
>  }
>  
>  /**
> @@ -712,6 +721,17 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
>  			list_add_tail(&id_mgr->ids[j].list, &id_mgr->ids_lru);
>  		}
>  	}
> +
> +	/*
> +	 * The SPM VMID is not part of the normal kernel pool, create its
> +	 * sync anyway in case it is used with kernel queues.
> +	 */
> +	if (adev->vm_manager.spm_vmid) {
> +		unsigned int spm_vmid = adev->vm_manager.spm_vmid;
> +
> +		for (i = AMDGPU_GFXHUB_START; i < AMDGPU_MMHUB0_START; ++i)
> +			amdgpu_sync_create(&adev->vm_manager.id_mgr[i].ids[spm_vmid].active);
> +	}
>  }
>  
>  /**

