Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F46E9B37D
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 13:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14BDB10E4D0;
	Mon,  2 Mar 2026 13:01:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ejuBkG1a";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EB8310E4D0
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 13:01:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYrGUsghZUAd9TsMrLRYkUtA6FEQu4Y07xldYzfJxmlGcYw45Nfn+8aWFBtxkLvqI8QCwNWVpqBhmpizNyJ+inPWi+hqROvW/kpyTKPLqN/tU9c/3uuD166GDNv+UJjJsa0JtsnLhupWgNpWToSw7XT0iNibFpIaVhS+Rfid3SaQ5Q0vPQodGjLJEV2HGwbwboyCnY4d5q1i3BDXWznEZ+DBaKTERdvioRrUdm4l/xCxIqfcuiKWzQNPhryxYldJeAAkuJ1sEG3D6ooeaWW/QmCD8cne25n5gQFERotidKl2Bv/qHxptg7hYZM++Ul3rsoFxgV1h3XmpdEUUwH4H8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZl5I4LEYrz6NMSzu7uOBeHsC2PcZdIbECz6Ixwv6Xs=;
 b=C3Mup/8Ygjg0l2vCS0IeUN1pCa5yJ2rOXfotMPA26ZpmLXyBeWZxP7lbD4QmgQxNlDrZfCEgqy5MniIWjGPFXZYS3X+OWDIkykBYhMDUcm2aybuKqdS+0u9pAK/oK2N3hIU9CBVAwWIhXiNhDk2TlSyrZZ46PNP42kQJRC0hAbghyh7dPmPuSNyeddv7i1xYAP4Awhn9ATe/+R/23EDy5Pxlwn8JTDiHxjoDL8FDGfYh9Y3PDBh+MihIEayhPccX/wrm+Bkb0WfibfjNa7GYtKQEvCr5M/KV5vQluLG9NqpXb8VsrSwGE8AjxTsgcKgrk0wrhUM/Ap7XA37T+EP2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZl5I4LEYrz6NMSzu7uOBeHsC2PcZdIbECz6Ixwv6Xs=;
 b=ejuBkG1ahdrlXMzxKdbztGERqUt3hIkcMpTtCTAc61k40jC4Uggw/fY+uWaAC9fV0bDGVsbAq5y6Bw8crXbFvgQfHeFWJrISBNBJSBHs1xtT0JxOGLaUUmaJ5jog7MseWfpC70PAu44+2AITRdBYY6ekLJSynAwcYx0jWcPTfro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6923.namprd12.prod.outlook.com (2603:10b6:303:208::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 13:00:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 13:00:57 +0000
Message-ID: <41d029c5-cc02-4e81-8fcc-e7917f78259a@amd.com>
Date: Mon, 2 Mar 2026 14:00:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/amdgpu: Add render-node EVENTFD manager core
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20260302030219.1734986-1-srinivasan.shanmugam@amd.com>
 <20260302030219.1734986-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260302030219.1734986-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a554eaa-bb89-4242-1cf1-08de785bbee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: qhzKYiHTgae7kDHFY9Ldkj+WoiR+lqZ7xWs3DgpV+bkSl+/qkFxaafG4vvVyMG59aPR1foohBLC/vmG0/Sd5o2NipVIyNIShtghXtGoKxvrBacSxeAd5R+EyZHYXGi09lWnhsiMMvEoal17IG1nGkhCcOyvH+2MRugD6JvyedQzPO2R1bpRWIa8ts1ad7UD53nWEVd7tnTlMe7ZxN1aM4VvjlgWaMLl6/fDqg3At36TEy2/ScHXRe/DDvA7emZDabnqEPqX4sOlj00hhQ6FkejXOX+/aUKqE8fD2NIlGy6Cemnkb9EDZ7AEvhttZeRo1hARAdfNAvm/Ngc9mdh2m/zD+5k2unstpc6AA2PZishpp4N+wKbBYcwIO8i7Welw2ZIwEYDBOMQzotPdoFzOJ9JgTch6YjvfmYdkeyfDqAT/XF389f9onvenNZRvFlO3Tk2meyGYUTJqu8b71QekSvqTyVfIuAsKAzFft6vwixjtzx19f1N7I3VrFy7FeKYIlcxEKO38+oDpnmLE1A1r3m2zI0Yg63V7COP8ZMthhB7DszkvQPIOejT/+hPDMfyRIHN6fnAvDGNDnWpNC+F65r9C2oFNv3JCCoNWupzsnsbsX0BwmjO7q+JEw6I3vnhFIa4BeU/cmB6+/424hKBG7UYVtu01UIM3a+1JLX0ka3qa4O+fQD1iBmaERn/bFToOHgT27tI1TT1FMTPt62at7D94rGPFUuCIXzOwxJ+Y9Goc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDJBeEpUTkJYenkzTm1oVkc3YWpTSGd5RXFnS2dHWnJCTm1HU1FTVlA3QjRS?=
 =?utf-8?B?cGZKbURJNU56bWlJN0hCOTY1azcvRTN4L001RGhzOUVZOEhqdHJOMDczc1I4?=
 =?utf-8?B?Y25ZaWw4VjQ2TWFsaUNpN2pIdityam9zSHoveVZrbDB2MXVkWEo0K2hIYTM0?=
 =?utf-8?B?ckhuMzlqT2w3SlBmUmliMmdVUGMwOEJpcEhHayt4NVpYd2ZwWmxGY2JBbHZY?=
 =?utf-8?B?c0hYM1pGL1BLQ3k0SytiUjQycVVFdXBTemh0ZHZneW5wNklOWDdVQXdNMzR2?=
 =?utf-8?B?N1dLUFhIbXNXMTVHWG8ybHMrUThoVHZDZlhhQmZwS0s3UXpTRENlTEZUL2pM?=
 =?utf-8?B?b2V2bG10NjF6dEplemg1M3Jkakl6TTQzR3lwZ2lLcTJkaG80QTd1RE9zNVFm?=
 =?utf-8?B?eGc0LzNvZllKUkFKaWlzZUxEL2t4RjNUMGdJTUVnRkg0TUw0RG1qV3dsNm1O?=
 =?utf-8?B?V21MbjNmanUzZGVhMGREdGpldnJSSTl3a08rS09HdVlqa2VwVDFlb0dVVWFu?=
 =?utf-8?B?SnlITDFtRHVyRDRQRnNxeUlDUzFnWDV4L2ZNUTNTNjhQM2Y3YkRxRjg1YmlG?=
 =?utf-8?B?YlZnU0EvNWZGK2cxNTI4eVNaeWNaeFRhMDJVNTd1dWJ3UkZDTmNjdDQ1V2Uv?=
 =?utf-8?B?VEN3T0VOWTU5cWxJeXNvZUtFejVqa3hLWDVvUEhGYWRrMklwenVHd3FURjZ4?=
 =?utf-8?B?ZTA1MG9WcWwzV0V5R0paTjlNRUR4cTlWZkk3eHc1MDZGd3BoRTRxQnNxUjBk?=
 =?utf-8?B?WU1RSjJKMkZYZVQ4a05aODExWGtoVTRqdmNpMmZDZFYwV0NjdVlJZW1DMWFT?=
 =?utf-8?B?cHBHSENKaThkVTNBWmhrRkIxd0p1MXg3Z3JSSUZ5Y013cUl4UGM1WUo2K3Nr?=
 =?utf-8?B?KzVBdWFSb1ZoR3laUCtpeUVPbElzS2RkdlR2eTZpdVZteGV1YW5qcWxyUlEv?=
 =?utf-8?B?Nmp5aHhIZytwZkg4RWpOcWhuUndWUFVYQ1Vzc1lqRU1iOE9SWEtNUlNnbjN5?=
 =?utf-8?B?bUFOT09mNnBNZEllVm1OY0JjYkNYUXBvUUt4VFFlOHQ5S3J4cWp3Y3lXWUdw?=
 =?utf-8?B?Q0Q2YS9hNjhEOS8rRnBzWnNsQWpvNUs0OVZxanRFZ2gyMG9leno3cVZlc25R?=
 =?utf-8?B?VEVmbVFINTVmMTVRM3R3RmFKQUliNTI1OHN1K01Sd0VDTW4yNFUxMG54SjBt?=
 =?utf-8?B?cjI2UEp3d21RK3BKTGM5dE5pUkZ4cSttTElHVElTa3lBNWhhRjNwNVJZanYy?=
 =?utf-8?B?ZFMraURCeTR1OCtxQWw0clR3SVdUS0tZb2x5VjNpY3BKM3pzRGpvUUZSMlRa?=
 =?utf-8?B?SlFjNHhhTkV1dG5mL0lncndJajJweWg1Ty96ZmdLWDdPSUh0dk5xWXloNll6?=
 =?utf-8?B?Y051QmR6TE9mQkZ1MDFPRVNiVlRlUGFIN1ZYT0NTNnJIanRITE1wUzJUaWNy?=
 =?utf-8?B?NTRETS9FQjFndXZGalRJeThOUGtTRjhsZmdsTzJUZ3haczcyVUhUSndOTmRD?=
 =?utf-8?B?c0swMmhVYmZEcEVRZGpOMVZseVBMdjA4MEUrQnY2NzlNMHdabnZiVWx3RVls?=
 =?utf-8?B?UCtFdk9xK1VvME5yRFZ4RnlndGxDOHoxWTJLNzFZamlvbVByQmtQZU1NWlBM?=
 =?utf-8?B?ejVNbFRpZmJDN1p0WHdia29oUDBYcVRDQ1NUcHpXaWFjQXFFNXUvNkVJN2FP?=
 =?utf-8?B?aEIwOUFrYzlrNytFRUtCcHh5N3oxeWJCSVZpVC9zUmNQbi9TUnIvK2NHbkZZ?=
 =?utf-8?B?ZUlPSGliTmhoQTZBSEw0NXdrNE4rOEpyN0lqaTJCVnI5Ylo3MTAxVmNtVGNt?=
 =?utf-8?B?ZFBEM1VVN2hIQmpvM3BNcWp1NzBiekZlbWVhTHdDQmliUWx5ZFdIM3U0SE5H?=
 =?utf-8?B?SjJyYmNjdWo2Q0xUWjIxT0I2TWtwZE9aMDZNSG5DVWVvd1dGNzJZeHkwdlNY?=
 =?utf-8?B?bWFVS3FVMS9zQXNUS3B6SEp3SkdDNWRJTjV3anJuWUlUVVlZUTdxNFp4K2Rz?=
 =?utf-8?B?OWJZRUZnc3NGUWJjSG9UUXQwbFpEcTdmSGorZnB2LzkvUEk4S3liK2lBWjY5?=
 =?utf-8?B?MG5adVdtdFN2d0xDa0pZOHlVcG5QakpTMSs2cEx6WnRURzViU3pYSEFBRjI3?=
 =?utf-8?B?Lyt3a0EvbDh3V21QMlM4Rnh4M1Uxa0hOWkJ4TXdMaXd4NlJJcU9xVEYzODZT?=
 =?utf-8?B?V0pQOU10dFJUb3Jmc1NmQmxhd2txQU1GMjJ2VTBodEh2QjJweTFvWjRJakhs?=
 =?utf-8?B?M1JubmUzV0w5bHAwMGYreDd4dTNzWWZ3dlhQSm5xRE1UVk80bVNqS1RwbmIr?=
 =?utf-8?Q?mXtlp4h5OD0RnHDB6n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a554eaa-bb89-4242-1cf1-08de785bbee1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:00:57.5004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/cvPG6EBmWU7DpfnnGpdqyFkgtdtRBHSOlg+8J4w3NFLtTpvL/p0J49uHJy4Sd+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6923
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

On 3/2/26 04:02, Srinivasan Shanmugam wrote:
> Introduce a per-drm_file eventfd manager to support render-node event
> subscriptions.
> 
> The manager is implemented in amdgpu_eventfd.[ch] and is owned by the
> drm_file (amdgpu_fpriv). It maps event_id -> eventfd_id object, where
> each eventfd_id can have multiple eventfds bound (fan-out).
> 
> The design is IRQ-safe for signaling: IRQ path takes the xarray lock
> (irqsave) and signals eventfds while still holding the lock.
> 
> This patch only adds the core manager and wires its lifetime into
> open/postclose.
> 
> Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Change-Id: Iac025dcb7c1b4f9ed74ac4190085e1925e2c8e68
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile         |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   5 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 321 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  76 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  28 +-
>  5 files changed, 430 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 006d49d6b4af..30b1cf3c6cdf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -67,7 +67,8 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>  	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>  	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>  	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
> -	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
> +	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o \
> +	amdgpu_eventfd.o
>  
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 1e71a03c8bba..9e650b3707e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -44,6 +44,7 @@
>  #include <linux/hashtable.h>
>  #include <linux/dma-fence.h>
>  #include <linux/pci.h>
> +#include <linux/xarray.h>
>  
>  #include <drm/ttm/ttm_bo.h>
>  #include <drm/ttm/ttm_placement.h>
> @@ -434,6 +435,8 @@ struct amdgpu_flip_work {
>  	bool				async;
>  };
>  
> +struct amdgpu_eventfd_mgr;
> +
>  /*
>   * file private structure
>   */
> @@ -453,6 +456,8 @@ struct amdgpu_fpriv {
>  
>  	/** GPU partition selection */
>  	uint32_t		xcp_id;
> +
> +	struct amdgpu_eventfd_mgr	*eventfd_mgr;

If possible we should embed that structure here instead of having a pointer.

>  };
>  
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> new file mode 100644
> index 000000000000..15ffb74c1de3
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> @@ -0,0 +1,321 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +/*
> + * Render-node eventfd subscription infrastructure.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +
> +#include "amdgpu_eventfd.h"
> +
> +static void amdgpu_eventfd_mgr_release(struct kref *ref)
> +{
> +	struct amdgpu_eventfd_mgr *mgr =
> +		container_of(ref, struct amdgpu_eventfd_mgr, refcount);
> +	unsigned long index;
> +	struct amdgpu_eventfd_id *id;
> +

> +	/* Final teardown: remove all ids and drop all eventfd references. */
> +	spin_lock(&mgr->lock);
> +	mgr->fd_closing = true;
> +	spin_unlock(&mgr->lock);

Of hand I can't see a necessity for that. Please explain further.

> +
> +	xa_lock(&mgr->ids);
> +	xa_for_each(&mgr->ids, index, id) {
> +		struct amdgpu_eventfd_entry *e;
> +		struct hlist_node *tmp;
> +
> +		__xa_erase(&mgr->ids, index);
> +
> +		spin_lock(&id->lock);
> +		hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
> +			hlist_del(&e->hnode);
> +			id->n_entries--;
> +			if (e->ctx)
> +				eventfd_ctx_put(e->ctx);
> +			kfree(e);
> +		}
> +		spin_unlock(&id->lock);
> +		kfree(id);
> +	}
> +	xa_unlock(&mgr->ids);
> +
> +	xa_destroy(&mgr->ids);
> +	kfree(mgr);
> +}
> +
> +struct amdgpu_eventfd_mgr *amdgpu_eventfd_mgr_alloc(void)
> +{
> +	struct amdgpu_eventfd_mgr *mgr;
> +
> +	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
> +	if (!mgr)
> +		return NULL;
> +
> +	kref_init(&mgr->refcount);
> +	xa_init(&mgr->ids);
> +	spin_lock_init(&mgr->lock);
> +	mgr->bind_count = 0;
> +	mgr->fd_closing = false;
> +
> +	return mgr;
> +}
> +
> +void amdgpu_eventfd_mgr_get(struct amdgpu_eventfd_mgr *mgr)
> +{
> +	if (mgr)
> +		kref_get(&mgr->refcount);
> +}
> +
> +void amdgpu_eventfd_mgr_put(struct amdgpu_eventfd_mgr *mgr)
> +{
> +	if (mgr)
> +		kref_put(&mgr->refcount, amdgpu_eventfd_mgr_release);
> +}
> +
> +void amdgpu_eventfd_mgr_mark_closing(struct amdgpu_eventfd_mgr *mgr)
> +{
> +	if (!mgr)
> +		return;
> +
> +	spin_lock(&mgr->lock);
> +	mgr->fd_closing = true;
> +	spin_unlock(&mgr->lock);
> +}
> +
> +static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
> +{
> +	struct amdgpu_eventfd_id *id;
> +
> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id)
> +		return NULL;
> +
> +	id->event_id = event_id;
> +	spin_lock_init(&id->lock);
> +	INIT_HLIST_HEAD(&id->entries);
> +	id->n_entries = 0;
> +	return id;
> +}
> +
> +int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
> +{
> +	struct amdgpu_eventfd_id *id, *new_id = NULL;
> +	struct amdgpu_eventfd_entry *e;
> +	struct eventfd_ctx *ctx;
> +	unsigned long flags;
> +	bool found = false;
> +
> +	if (!mgr || !event_id || eventfd < 0)
> +		return -EINVAL;
> +

> +	/* If file is closing, refuse new binds. */
> +	spin_lock(&mgr->lock);
> +	if (mgr->fd_closing) {
> +		spin_unlock(&mgr->lock);
> +		return -EBADF;
> +	}
> +	spin_unlock(&mgr->lock);

Such checks are unecessary. bind/unbind can only come through the DRM render node file descriptor and when we set fd_closing to true that one is already gone.

> +
> +	ctx = eventfd_ctx_fdget(eventfd);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +

> +	e = kzalloc(sizeof(*e), GFP_KERNEL);
> +	if (!e) {
> +		eventfd_ctx_put(ctx);
> +		return -ENOMEM;
> +	}
> +	e->ctx = ctx;

Do that after allocating new_id. It is not a problem if we allocate new_id and then never use it.


> +	e->eventfd = eventfd;

Stuff like that is a big no-go. The file descriptor number is only valid to call eventfd_ctx_fdget() once!

Even a second call to eventfd_ctx_fdget() can return a different value.

> +
> +	/*
> +	 * Prepare id object outside xa_lock_irqsave(): kzalloc(GFP_KERNEL)
> +	 * must not happen while holding spinlock/irqs-disabled.
> +	 */
> +	new_id = amdgpu_eventfd_id_alloc(event_id);



> +
> +	/*
> +	 * IRQ-safe design:
> +	 *  - protect id lookup + insertion under xarray lock (irqsave)
> +	 *  - protect entry list under id->lock

That is a bit overkill, just protecting everything under the xa lock should be sufficient as far as I can see.

> +	 */
> +	xa_lock_irqsave(&mgr->ids, flags);
> +
> +	id = xa_load(&mgr->ids, event_id);
> +	if (!id) {
> +		if (!new_id) {
> +			xa_unlock_irqrestore(&mgr->ids, flags);
> +			eventfd_ctx_put(ctx);
> +			kfree(e);
> +			return -ENOMEM;
> +		}
> +		if (xa_err(xa_store(&mgr->ids, event_id, new_id, GFP_NOWAIT))) {
> +			xa_unlock_irqrestore(&mgr->ids, flags);
> +			kfree(new_id);
> +			eventfd_ctx_put(ctx);
> +			kfree(e);
> +			return -ENOMEM;
> +		}
> +		id = new_id;
> +		new_id = NULL;
> +	}

I strongly suggest to move that whole dance into amdgpu_eventfd_id_alloc().

> +
> +	/* Enforce total bind limit. */
> +	spin_lock(&mgr->lock);
> +	if (mgr->bind_count >= AMDGPU_EVENTFD_MAX_BINDS) {
> +		spin_unlock(&mgr->lock);
> +		xa_unlock_irqrestore(&mgr->ids, flags);
> +		kfree(new_id);
> +		eventfd_ctx_put(ctx);
> +		kfree(e);
> +		return -ENOSPC;
> +	}
> +	spin_unlock(&mgr->lock);

That could be an atomic operation instead. Would save the mgr lock as far as I can see.

> +
> +	spin_lock(&id->lock);
> +	{
> +		struct amdgpu_eventfd_entry *it;
> +
> +		hlist_for_each_entry(it, &id->entries, hnode) {
> +			if (it->eventfd == eventfd) {

Absolutely clear NAK to stuff like that! You must compare the ctx instead.

Apart from that is it problematic to bind the same fd to and event multiple times? I mean it doesn't make to much sense but it also doesn't hurt us in any way.

I'm running out of time to further review the patches, but I think that already gives you quite a bit of todo.

Regards,
Christian.

> +				found = true;
> +				break;
> +			}
> +		}
> +		if (!found) {
> +			hlist_add_head(&e->hnode, &id->entries);
> +			id->n_entries++;
> +		}
> +	}
> +	spin_unlock(&id->lock);
> +
> +	if (!found) {
> +		spin_lock(&mgr->lock);
> +		mgr->bind_count++;
> +		spin_unlock(&mgr->lock);
> +	}
> +
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> +
> +	/* If event_id already existed, drop unused allocation. */
> +	kfree(new_id);
> +
> +	/* If already bound, keep existing and drop the new reference. */
> +	if (found) {
> +		eventfd_ctx_put(ctx);
> +		kfree(e);
> +	}
> +	return 0;
> +}
> +
> +int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
> +{
> +	struct amdgpu_eventfd_id *id;
> +	struct amdgpu_eventfd_entry *e;
> +	struct hlist_node *tmp;
> +	unsigned long flags;
> +	bool removed = false;
> +
> +	if (!mgr || !event_id || eventfd < 0)
> +		return -EINVAL;
> +
> +	xa_lock_irqsave(&mgr->ids, flags);
> +	id = xa_load(&mgr->ids, event_id);
> +	if (!id) {
> +		xa_unlock_irqrestore(&mgr->ids, flags);
> +		return -ENOENT;
> +	}
> +
> +	spin_lock(&id->lock);
> +	hlist_for_each_entry_safe(e, tmp, &id->entries, hnode) {
> +		if (e->eventfd == eventfd) {
> +			hlist_del(&e->hnode);
> +			id->n_entries--;
> +			removed = true;
> +			if (e->ctx)
> +				eventfd_ctx_put(e->ctx);
> +			kfree(e);
> +			break;
> +		}
> +	}
> +	spin_unlock(&id->lock);
> +
> +	if (removed) {
> +		spin_lock(&mgr->lock);
> +		if (mgr->bind_count)
> +			mgr->bind_count--;
> +		spin_unlock(&mgr->lock);
> +	}
> +
> +	/* If no more eventfds bound to this event_id, remove id object. */
> +	if (removed && id->n_entries == 0) {
> +		(void)xa_erase(&mgr->ids, event_id);
> +		kfree(id);
> +	}
> +
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> +
> +	return removed ? 0 : -ENOENT;
> +}
> +
> +void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id, u64 count)
> +{
> +	struct amdgpu_eventfd_id *id;
> +	struct amdgpu_eventfd_entry *e;
> +	unsigned long flags;
> +	bool closing;
> +
> +	if (!mgr || !event_id || !count)
> +		return;
> +
> +	/* Fast closing check (best-effort). */
> +	spin_lock(&mgr->lock);
> +	closing = mgr->fd_closing;
> +	spin_unlock(&mgr->lock);
> +	if (closing)
> +		return;
> +
> +	/*
> +	 * IRQ path: keep xarray locked while signaling, as suggested.
> +	 * eventfd_signal() is IRQ-safe.
> +	 */
> +	xa_lock_irqsave(&mgr->ids, flags);
> +	id = xa_load(&mgr->ids, event_id);
> +	if (!id) {
> +		xa_unlock_irqrestore(&mgr->ids, flags);
> +		return;
> +	}
> +
> +	spin_lock(&id->lock);
> +	hlist_for_each_entry(e, &id->entries, hnode) {
> +		if (e->ctx)
> +			eventfd_signal(e->ctx);
> +	}
> +	spin_unlock(&id->lock);
> +
> +	xa_unlock_irqrestore(&mgr->ids, flags);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> new file mode 100644
> index 000000000000..542a1d65e13b
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +/*
> + * Render-node eventfd subscription infrastructure.
> + */
> +
> +#ifndef __AMDGPU_EVENTFD_H__
> +#define __AMDGPU_EVENTFD_H__
> +
> +#include <linux/kref.h>
> +#include <linux/spinlock.h>
> +#include <linux/xarray.h>
> +#include <linux/eventfd.h>
> +
> +/*
> + * Manager lifetime:
> + *  - owned by drm_file (amdgpu_fpriv)
> + *  - can also be referenced by longer-lived producer objects (e.g. USERQ fence
> + *    driver) via kref.
> + */
> +struct amdgpu_eventfd_mgr {
> +	struct kref		refcount;
> +	struct xarray		ids;     /* key: event_id(u32) -> struct amdgpu_eventfd_id* */
> +	spinlock_t		lock;    /* protects ids + counts */
> +	u32			bind_count;
> +	bool			fd_closing;
> +};
> +
> +struct amdgpu_eventfd_entry {
> +	struct hlist_node	hnode;
> +	struct eventfd_ctx	*ctx;
> +	int			eventfd;
> +};
> +
> +struct amdgpu_eventfd_id {
> +	u32			event_id;
> +	spinlock_t		lock;    /* protects entries */
> +	struct hlist_head	entries; /* struct amdgpu_eventfd_entry */
> +	u32			n_entries;
> +};
> +
> +/* Per-file cap to align with common KFD-style event-id space and avoid abuse */
> +#define AMDGPU_EVENTFD_MAX_BINDS 4096U
> +
> +struct amdgpu_eventfd_mgr *amdgpu_eventfd_mgr_alloc(void);
> +void amdgpu_eventfd_mgr_get(struct amdgpu_eventfd_mgr *mgr);
> +void amdgpu_eventfd_mgr_put(struct amdgpu_eventfd_mgr *mgr);
> +void amdgpu_eventfd_mgr_mark_closing(struct amdgpu_eventfd_mgr *mgr);
> +
> +int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
> +int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
> +void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id, u64 count);
> +
> +#endif /* __AMDGPU_EVENTFD_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f69332eed051..8ab8f9dc4cfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -42,6 +42,7 @@
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_gem.h"
>  #include "amdgpu_display.h"
> +#include "amdgpu_eventfd.h"
>  #include "amdgpu_ras.h"
>  #include "amdgpu_reset.h"
>  #include "amd_pcie.h"
> @@ -1469,10 +1470,17 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  		goto out_suspend;
>  	}
>  
> +	fpriv->eventfd_mgr = amdgpu_eventfd_mgr_alloc();
> +	if (!fpriv->eventfd_mgr) {
> +		r = -ENOMEM;
> +		goto free_fpriv;
> +	}
> +
>  	pasid = amdgpu_pasid_alloc(16);
>  	if (pasid < 0) {
>  		dev_warn(adev->dev, "No more PASIDs available!");
>  		pasid = 0;
> +		goto error_pasid;
>  	}
>  
>  	r = amdgpu_xcp_open_device(adev, fpriv, file_priv);
> @@ -1538,6 +1546,12 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	if (pasid)
>  		amdgpu_pasid_free(pasid);
>  
> +free_fpriv:
> +	if (fpriv && fpriv->eventfd_mgr) {
> +		amdgpu_eventfd_mgr_put(fpriv->eventfd_mgr);
> +		fpriv->eventfd_mgr = NULL;
> +	}
> +
>  	kfree(fpriv);
>  
>  out_suspend:
> @@ -1568,6 +1582,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	if (!fpriv)
>  		return;
>  
> +	amdgpu_eventfd_mgr_mark_closing(fpriv->eventfd_mgr);
>  	pm_runtime_get_sync(dev->dev);
>  
>  	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_UVD) != NULL)
> @@ -1605,10 +1620,19 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	idr_destroy(&fpriv->bo_list_handles);
>  	mutex_destroy(&fpriv->bo_list_lock);
>  
> +	pm_runtime_put_autosuspend(dev->dev);
> +
> +	/*
> +	 * Drop the eventfd manager BEFORE freeing fpriv.
> +	 * (mgr can be refcounted by longer-lived producers)
> +	 */
> +	if (fpriv->eventfd_mgr) {
> +		amdgpu_eventfd_mgr_put(fpriv->eventfd_mgr);
> +		fpriv->eventfd_mgr = NULL;
> +	}
> +
>  	kfree(fpriv);
>  	file_priv->driver_priv = NULL;
> -
> -	pm_runtime_put_autosuspend(dev->dev);
>  }
>  
>  

