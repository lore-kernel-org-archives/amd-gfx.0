Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC4ACA6007
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 13:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 753FB10E807;
	Thu,  8 Oct 2026 13:18:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dju4vUAm";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D59310E807
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 13:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZH7uzvDaIylqWvISzKO5s7WjKU+pMaGxh7GHmvDS8/6o46pWKNVrCPHkRVhP4YrgR9ZzilATb3giAhdyTTCM31RiBHOlySrafoHllz+s6Jx1Ajr6k0n0Jly3kNatK4J6FyS36zaYdWFt9tAU+ig2ZQEs2Zs0PO3EpzTqv0/h9YQm4ELMI3dyb0OIOKswNrAMIfh5MzNLzxykILhcWfbjk+01BBWc1F+BDdzf4p/VulT2GMsPRlf5Lcbr0iPzwr9CYcuLgiMgWB4Xaax/YYHTi9DQcGennIGaMlga0X10oMrDE774aO+7mvhbizjli57pWihY9GaYBL53vVwz0UCrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEW2774qLaIgElB6ks8OXlV5FBJ9fuWEe0JSi91XhmY=;
 b=DouLzzXWkCs2//v++pMiHBhAlnj4Q06KmLjbjTaIkSSFp3J/VXbrtax8y1wu3J1a0qMY8gPfECYg3NJvb0faG5B9wzZgZ2C9HJt8vdfgv4qPYWOAwQwP0OoBAnvUI+2eyI9HoOyTOwANPE+Di0A4qlW1LeIRvEyxRLCA9RFYYOuRa7LZN31UKY3kl/M3E/rq+RFyTeO5Kzbll/zwqovIc68FxHaMywl5QpIAF1tjxX6JS+lt69URpCq0gE5tSIS6JI9Z1m2LtmjWF9nDw4Q88nY+5y8ZYJ7TJi5Qk3hKw4zaN5rT4EvgV2F1/PkQvtVyN4EMilOcfSmtS81yEgVnqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEW2774qLaIgElB6ks8OXlV5FBJ9fuWEe0JSi91XhmY=;
 b=dju4vUAmVN3LcOFNPaaUifaNM8PcefQSPYNsj9qUGHJgo6sB09ZcnMaTel4bMyZ7fq5r5hqt9TLoub+paSANUc5nBN5u2k3830zxJ9xX8PoPsCLl0tJSB7Sld6z3OOOAUeP5AayQpa4ThU7tafzN7EhjsjyvWdNqmRRdd85B6qg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV5PR12MB9755.namprd12.prod.outlook.com (2603:10b6:408:307::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 13:18:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 13:18:28 +0000
Message-ID: <0e2d92c2-c8dd-4b19-a77d-7f55a8069c7c@amd.com>
Date: Thu, 8 Oct 2026 15:18:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: move amdgpu_vm_bo_update() call into
 correct location
To: Shahyan Soltani <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, "Khatri, Sunil" <Sunil.Khatri@amd.com>
References: <20261007221530.389925-1-shahyan.soltani@amd.com>
 <20261007221530.389925-2-shahyan.soltani@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261007221530.389925-2-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:208:32a::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV5PR12MB9755:EE_
X-MS-Office365-Filtering-Correlation-Id: ff521206-f41c-4f0d-c8c6-08df253ea3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|10067099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: lrQt3hdEGrS6A855/8dS9rhA3Ji1/JB8m/4rB18dEvaGWx6lTPpsvtA5Ij7eWQGrZyVrXejiyq+pKKviyVkIgi+h17xPaz/63N9dRq2JAOhWmAwtUnxyGY9Kim98YbExtOpbAvbIgqm3eXsAmWNb10k9vbCUIPbUF8Gwve1O7knFD4riyjQTPQFBQXFPd178QY2y5sH3DQE6kXBibC4qWL41Qj+cuRZ6hfgjKxmM5c+M5RsK4VLNgKxrSMNYiHMzbpvYNsTsH8TVJ2mEbvSsLacF7qRg2RNLT80q5cKdQFU0UFbIc2Vx8cGYRL4SXQpXy6mzTWl0KiPORAGzD72kEB+G/BUtNgKCoKLGLoZFKUROwEqh2XIqF4zPsSKMZsM67+RAX+O3p8WKpiZWcNWqrGDxf5oz40aotP5xY5JJxZS0Pq7Ik+akylm3+rQnlkinYfUFTXWSMW/tNivkDsMVtDQlvGWILldX7wL2oTGgH3Y2X9mZ5lzhahib3n1DfbKmQ5ykorbknxn8ZjGNCVf+owrXIeMebgB6EJDEm2Kpo0hvtKFilBDqgmc3wVGiVBvhIa9BLBuzdqgY04qsbQI71Mubg2eA+vRb+PqxKbP+iaf6pi0Sj64o7j0gR3HnH1J6BKvWrNmBSGbRMYJViMvazT+QrktPoLufr3cVgZP/2NE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmRINmlTaFByVDF3YzR1MVJ3K2UzWlRDOFlqSU9Mdk91cEp4cVVTM3BGNVEr?=
 =?utf-8?B?RkhUdEFTZFg3aWJkVDJNMjhzYjRMMTJ5UURpUUdmYUhNdU8xUGdPUTZMRlRY?=
 =?utf-8?B?K05GaUJuRDIvVzVqSnIxNWxRTzVUaXVYWWZ2Y1ZTdWZmWlZLYks3bUdkYkgy?=
 =?utf-8?B?SU5SL0dTenVQZFVjanJvbU1kb3NNU2R0bjVrNFVObmVNdTNXR2JlVitQbDc3?=
 =?utf-8?B?NXpRODV2ZlhNSGw0dUxIUllRQWtqMWF0Y1YzQk9YVlA1QjVBU0lvOG43b2Uv?=
 =?utf-8?B?N1B0KzlrcUg5Sjc4dlc5T3hHK2lSdmFQWUlXN05HUzE0UWNrK05yNUljalpQ?=
 =?utf-8?B?NWx2WUV6cHRtRmRJVFRTL2x6RFoyRUdqN1pybFdKdHp5WSs2K2ZWZGF4cFcv?=
 =?utf-8?B?TlMrVFNsazF6Um1iODRmWWpjMjZVTjZEUlJEUEtWUWlrMVdmTHlwREMyTU03?=
 =?utf-8?B?ckpBeEJxU01veWVpdXYxazRLU0hoc0s0eWxyVTJjbkZlVkYySmVHSlhxNlRH?=
 =?utf-8?B?R0JSZUsvV2RWemE4ZFRCelQzcTNHay95RnZMTksvUmJCU3c0V3lLZVBTODRj?=
 =?utf-8?B?ZDZBMEhQb2lyV2xRM2Jvcm1ndFcyRnhMajhNekVsM0JSRUhhOVF4ckdUeHhx?=
 =?utf-8?B?Mkxrbnd5NW44MER2K1VvZnRaVFRtV0JGNlJVOGhGRmhlK2Y5N2hCV002YXQ3?=
 =?utf-8?B?V0cxazdWbmNtTDJTUDB2RlBPUUhGdGlaYml1R2o1NXZrK2lNNVZnQUFhYVIx?=
 =?utf-8?B?VWVkbm5lMjl5M3ZROGxZTGJVRU4vZS8reXExQzhHQXRWRkY5MTVaaTVQK0NP?=
 =?utf-8?B?bHp2QXdReXZUeHRiM1Nqd1U5eXQ1a2Job0Q1bkZaNVRmSjlobzZPaVAwaTVD?=
 =?utf-8?B?aGhFbHUyZ1hGN3RKVTJNUWdiNXZ3WVFGbkxWR3djK1dDSm9iRVJYekl5RWJv?=
 =?utf-8?B?VVNWWHIrUEVxQ0gxMWd4cWZUYVJ5allSLytRaWVNQVljdC9xaldXU21hd2J0?=
 =?utf-8?B?a281R3l1MVQzZ3VxemFhTkRHR0F5WHBOV1NKTFg0MlhMd0ZGZzM5N3dUdEpK?=
 =?utf-8?B?cDY0dWI2Z0M3cXB1SGxFb0ozUTU4VUhtUHBvaGtoRHh6SStCbWNrVlorT05a?=
 =?utf-8?B?V0NvejRVS2ozVTZCbEUxYlJHQ2k2a1JnNlhOMUEvZExWN0tQMmg4VkFDZDR6?=
 =?utf-8?B?dTV1ejZHYXZQdXVWalYzVXYyVHBmdmdFTUpuOGdKc3hNN29KUFNPV1pRVEFJ?=
 =?utf-8?B?aXlWU1l3ZFErZEtvaXV0M0Rva3R5WDF5U1lEd0pWS0dIREtPRXQ1OVRlS1ho?=
 =?utf-8?B?dXVrc0FsNU1nU1p3ZUlUQjhUUDhtTkhSR0ZRajVjY2N1WkNsSkV5UFQ5ZEFt?=
 =?utf-8?B?a05SclVIZXg1d1pOQ1d6eUJLVzRoeDU3Mm15RWVYNGpMZUpLNGJHTS9CTzE1?=
 =?utf-8?B?UlJ6ZUlzZzREMFFpelNGV1dCc0o4OENzcGVHNXVCOERqbkpVN1gwWHdzREVT?=
 =?utf-8?B?bXB2NTNra29DVVBzY3p6T0lKNmZyM0lHMWVJNFUva1RnODdzZ3dxT2poQlQ3?=
 =?utf-8?B?dFhLOGNQU0ViYTV3dFZpeEF6VGxLTFRMMVl2OEpmUDc1aGNuZ214bXFrUko5?=
 =?utf-8?B?ZzE0RFJYTGNCakNDVXNlc3I0K05yc3VZZHpSZ1JPRnZpVjZGaGJEMTZibG4v?=
 =?utf-8?B?Rk90cVdIKzNTVE5nSEVVbXVuWmxlenpkSlhKNytCeTlKTktFL0VsdkErQ0FB?=
 =?utf-8?B?dTV3ZGNkWmJQQWNZeW5STGp5RWI0Q1ljVkg4TTl5ckxiZzNYb0hkTCtiTUhN?=
 =?utf-8?B?MGVpR2Z3RFk2VVdVUXdCRXlmYVRicVBuOTVMNmhtN2dHbWlBaUo3eDVyeVFj?=
 =?utf-8?B?clpXZ2p1VVJRRVdqTG9vRTBpMGRqWUltZnU5dFpCaXNmai8raW5lbjJNYTY4?=
 =?utf-8?B?NmdJMy9ZdXJLNFByTVJndzZ6Y2J2eVJSeTB0eHUwTkgwcUYxUUphb1hwVVpw?=
 =?utf-8?B?dk53YUZzN2NkaDJaS3d0elhURzlkVTRBbEZxUktZVVAzTXNDSVlBTnBLVGVs?=
 =?utf-8?B?NC9JakovUXVUTXgwa3hiRW5JOGNESzNrREdGb1Q3Y3h4Q0NydGFSbDdXYjJk?=
 =?utf-8?B?dGNocjdCVjF4bSt5WGRqNlVzb2JCVXV4a2NyTVJFOWYvdnVVb2tVNVdxcDNO?=
 =?utf-8?B?M2ZDZjdDR0FaYlNiOXpkeUphOWdJMFc3cEllUEhTak9hZG9qK1AzcHVtcnds?=
 =?utf-8?B?dWhoRm5oSjU3V3ZmcUcrQTdlRDgyMFdnMlJiZzR1NFRuTHV1d3pHK0JkK0pr?=
 =?utf-8?Q?TRHQFnKWrWWrIJHbqn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff521206-f41c-4f0d-c8c6-08df253ea3d5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 13:18:27.9662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pR0S64JB6mf8Rb9PO0tR8Ey2pzfQOkMUXYzvG2DTaX7aA5dkgaMOR9n9jViwO6HB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9755
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

On 10/8/26 00:15, Shahyan Soltani wrote:
> Calling amdgpu_vm_bo_update() this early is unnecessary. moving it to
> amdgpu_cs_vm_handling is the correct location for this function and is
> required to allow the VM to initialize without waking up sleep.
> 
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

It could be that this is regressing user queues, but that would then be a separate bug in the user queue restore handling.

Adding Sunil on CC just for awareness.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c    | 14 ++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c |  7 -------
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index d059e0c92866..2d01a831d534 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1159,6 +1159,20 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>  			return r;
>  	}
>  
> +	if (fpriv->seq64_va) {
> +		bo_va = fpriv->seq64_va;
> +		r = amdgpu_vm_bo_update(adev, bo_va, false);
> +		if (r) {
> +			DRM_ERROR("failed to do vm_bo_update on userq sem\n");
> +			return r;
> +		}
> +
> +		r = amdgpu_sync_fence(&p->sync, bo_va->last_pt_update,
> +				      GFP_KERNEL);
> +		if (r)
> +			return r;
> +	}
> +
>  	/* FIXME: In theory this loop shouldn't be needed any more when
>  	 * amdgpu_vm_handle_moved handles all moved BOs that are reserved
>  	 * with p->ticket. But removing it caused test regressions, so I'm
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index 21a225b0116a..fbf9ec7d467b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -103,13 +103,6 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		goto error;
>  	}
>  
> -	r = amdgpu_vm_bo_update(adev, *bo_va, false);
> -	if (r) {
> -		DRM_ERROR("failed to do vm_bo_update on userq sem\n");
> -		amdgpu_vm_bo_del(adev, *bo_va);
> -		goto error;
> -	}
> -
>  error:
>  	drm_exec_fini(&exec);
>  	return r;

