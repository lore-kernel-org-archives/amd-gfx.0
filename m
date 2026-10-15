Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7390CCC6B30
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 10:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFFE7112294;
	Thu, 15 Oct 2026 10:39:56 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9470910EBC4
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 10:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxIiPqQxSm+iz6QLRiEbKfHjDtV5lb31bRk/w6d1iyi0LUjdROnoV72O6jkMAR+GtIx5X3TyhyOTSJFe/pJmnfOf619r4K1+eknmwUiLaPFWXb6A2VBlbvaid5DfRndsGMDc3eOL58LUxXC9MtO275ycwoMHvnIGTLmf2wr+oVb5w6wEYyl8KxdrkzHquSCnkoAEghsADM0e51M5tV7tKTpRdSnsUkRaAL8CFpMHfcjVE6Q3d6mzkcNL4xqpSVPJS27h3bJS1NefiHn3jp75tzi4Fyt9AmbnJmJ5x85AvhGCzVjEVdgkq4GBLM6oqVjHVNZzVHe4yUoP6zhHzv4eIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1H89gUnYy2w5jEUhmGse900ARYtp7olnLc8SLZQwDlM=;
 b=LIpg26bGvnvJ9PEvfBnUMbE25/4St3qfY9cE/MZZDE/6144mMzYRo9iZFulGuDNgmRNm853S6Gv5Ime/VIuOegfnLzG/smwQ60qjc5mb8RBwqOEI/rB2VVDFMmOXhMUTe7ZCaMCtgQtHZzfFnWEzcns1HDLvC1hXydc78FYJq6ToMD98CFWNZI4b5pb9VwRFVnlaPpS1J9kP6OZgq3tnxPun7imAxIqJmnPPcYWHg4mG2jJ1I2MJ35HP0w7HM5e5sVx4HejpltRn7rm2JTWLuN6avkb71kl0EavTjhfnQoBzHgHTFzMc56BhGLAXQh2GzsSpzzct8AyDXcGQ6rWCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1H89gUnYy2w5jEUhmGse900ARYtp7olnLc8SLZQwDlM=;
 b=uyiONJCgTioOAecTS0lkyBo22yIR/YAddehHjPfs0f5Qg6tu6yv56FdsqgNIUaMPN4eDYWreTzpZ62Y2mKqdduKy/42fyPhXoR0p1rrptlxszXHNr9l5PWzzH1xux1L23QFSKFF/FH8AVgajdde0eaMJiLn7dPTpV1rJDJx+4GA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 10:39:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 10:39:41 +0000
Message-ID: <0167f986-d0ae-46d4-b5f2-8b0bbd4f7b0d@amd.com>
Date: Thu, 15 Oct 2026 12:39:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: reject ANONONLY userptrs that span
 multiple VMAs
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20261015083744.3448696-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261015083744.3448696-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 00465003-8260-45a0-d363-08df2aa89e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|11063799006|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: j38byLkJr2g8Ymt8tv1ddx53Qb+oXZC/o6fz5VZ/bLnqJSZTwOieLj/5iWz7gsVYLNP01Md7hXj6x/oA0IfxP3fxvpd7nB3pe37PJxKwt67B4X1fAb1JFwBrtr3ErYAjzoaQ1aGCCJ/+VdZZlrkn1z4P3U3B1V7fcNYJess8Ue3tLttf6yaZ19kIanB6h/y2tN6Rl2NMxun9IRZ0DImvJQ7Tf7fdqxBICh5q35bCrxeUo0aPigADJUOtF0U8tFeCHsElSn5zG6Kqa2DJiWBWC5rFHvCLPM8XhUgByLJ/FEqxu9jyB+TFo8PElY9p89DwkDhRMKaj0jlmPFXGhRsG7VTcP2sicesgyyqQB36IHmbDxD8ZcyHhnzOjVv/hiS2u9WDr3+FhixfrG1GZN5UINFWt6GsH/64leh3MXRT174YDalb+LMzOtV4wwW4l190aSum322N6rc4bg9cRYfLnqBEMs7IdEk9KzZ8XWTnDrxdmkGS82Lwa3s9RUYGy4zqzAh/DauEaqfGv5+hICV1+QMOAMcFgGuO2iII6Pl8mtBAdtFvK4Q9TkG2Dyzmrc8lrpKOmiqvLa23YmmdQ82vfiNPMPyJdwk0Y6XA8APek5sMX2Yyi958bxM+nfBMCbC8tCL51sk0lt5Y+U2e6DwkCU3N5rZuZsfCRVi58M7ReUbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUJkcldrNDFGUjBLUWY4YmdwL0gyTFd1NFQyU0JXK2N1YldJdTQrYkdmKzhS?=
 =?utf-8?B?VDNYOTFxNWdsTDdvcS9nZk1WTVBVdDI2TlFLMlJsdGJOMHRLdnFySnFkUkow?=
 =?utf-8?B?R2pXZlgvelR0YzNHdUhrNTJNWkhSTkVDOU0yRlk5a1hJOUFUclpBa1RveTA5?=
 =?utf-8?B?MDlYZFZrc1pWYUJ6blYwZ0k1ZDhvcmxjbUp5eStBMnJNUVQ5bTVLWEhjemtB?=
 =?utf-8?B?anJ1dHBGMDlCMWtUT3prL2o0NjFiZkdURGZycTVNZUhJK2Fwb2pqVXRDZFlm?=
 =?utf-8?B?Qmx6Q0lOL3FNVU5EY0VLWm54TzVsZ0JSRHhENURmeWUvUE9XRGxkSng2V0c4?=
 =?utf-8?B?MWNoUCtFeklSSDNIeDN5T3NHRGZUVXcyZE1PRm1sc3dyeFVIdkUrT1ZYdEw5?=
 =?utf-8?B?ZnB6RThCTHZ6b3lYQ2NsakdEWnpSRjRnbDhKTGhUTVFXWmRDK0RqYWN3czlw?=
 =?utf-8?B?U3RhSW9xSi9iRy9LVmxmTzc4dnh0YjMzTHgxRUxqZlRWbENuMUI0dFFvdm8w?=
 =?utf-8?B?MDV0SVYrajljSGhxRGQ4dTB1MTBsY3hvNzhsaVdIbVJyK0tsSEZ6cGp5eUN0?=
 =?utf-8?B?RXNhNkR6K2tvTFVFWXp6eW8vVTZpQ04zUmR1Y2QwTnRKVUt3TTBIQ1JFY1ZE?=
 =?utf-8?B?blhXQ1RFQmU0RGJDOGY3b05wOFJ1ODFUUHU1YUsrNjdsT1c4dkhjak9VYUcw?=
 =?utf-8?B?aHBFWE5uRWFhU1RIY2F6cVo0NUtLWStrTHNhZWxBbVR5UUhOaDFkMGo1NXMv?=
 =?utf-8?B?OHVDazYyNlhiLzYwdzJlODltcXFnaVN6V0NEM3BMN1ltR3BFdTN2SCtHMFIr?=
 =?utf-8?B?L3ZiRG5aU0h4ZWwwaUttSnNocUFObXBxdjVEYndsNnZJckhuRzY0d0srVTdy?=
 =?utf-8?B?WHA0OXVXTzBjZkNnR0IrZGtQTWdIRllDUWRIL1hXdjI1dGs0MVhldndwVnF0?=
 =?utf-8?B?dHBvS2laZVVYUVlrcVZWdHBjRllFaHdPOFNPSGJ5QWo0ckVxNTg3dElPVlpZ?=
 =?utf-8?B?QTRpZFN0Y2Y5SW1SSGhWRGFza0dRaDZIRERRTWFESENVTXZkcnRZdGlwTTc1?=
 =?utf-8?B?UmF0VUxhWENueTZ3OFFjUnZtSkxWeVdUUXlSajQ1Y0U1azkzeUswODc5RnhH?=
 =?utf-8?B?aVJ0UFVPSE1lRXZuS2plU21VUlpNNlJ6cFFrRkNyNzV6OG1TeFpERUlURFVi?=
 =?utf-8?B?czJpdm5qbTJ4NGxRTHdRbmlKeHJWeVVNMmZwUXZOcVJMRTVESHpid0x4MDVQ?=
 =?utf-8?B?cXZZZ2c3Um9aLzFQOHJQSktVVzhpV0tJcEFYUnZ3Q1dXYTBoVXhMaFdock91?=
 =?utf-8?B?ZTBaSkNJZ1M4ZE9kdVpiOGJLaHVEaTVFTWlCVStnN2pFa3ViNW5pdTVBbm1q?=
 =?utf-8?B?aFk4a1NKaW4waUhsMXNvSkhBK3d3dUd6ZHpnSHJxQzgyZHZGUVNLb0lBWGEw?=
 =?utf-8?B?bG1DUmFvMTMvUHJGVE83R05VZHpTZVBBQSszRGRUazBMNlVKY3ZKUFo5RlB1?=
 =?utf-8?B?WEZPUWFUTlBLZEk3QklEZnRPYm9JWTQ5a3Jucm56VWR4WHJscDEreTJPbnJ4?=
 =?utf-8?B?dWVlSDJZbUJnV2dDZ0IrNjR4NXFkK3NJWFhvS0M5R2M4MWplSHNvUmhEeVIx?=
 =?utf-8?B?RVpRWmxtc1pUSGJmL2Y3aDR6Q25FU0tuYUkwSjRUL2FCNFh4QXFWQWRES1c2?=
 =?utf-8?B?bjBUbFpkUEhtU09FTnp6TlJjTExhVFhxZkZGeXVzdzQ0MjlpVzAwUStUZk9P?=
 =?utf-8?B?aTI3KzVJQUlvc2JOQUxaUHpSOEc4Ui9HYmtaWnErakZyWDRYRXEyWEFPM3dT?=
 =?utf-8?B?YkQyUU1KaXdCNDBVKzNHVk8vZ0hPdmloYjhsQXBJdXZSbmh5Z3dDQjBFeGU2?=
 =?utf-8?B?UTh5REVjZTlYdXBQajV5b0dtdWhDNWd3QWxodU8yOEw5THdDbDBaMGN0QW4v?=
 =?utf-8?B?QVpKTTU0ZUtES3lhTHE2cXBLcHoyNFJvdW5vaFZLbDQzZWdKaGNQNDAxaU5l?=
 =?utf-8?B?UUNpQ0cyeWhncW1MdHY3anZzZHB2Q1RqSEwrUUJsU2VwSForZ1BaQjNTR2hC?=
 =?utf-8?B?dk1wN2U4b2h3VVM3NzdZWklQeSswMkJjWVdNc0xpbklnNFFTbGZTZFRqeDF1?=
 =?utf-8?B?VXJpNkRNVWVqZlBnU3E5WThmOHdKZzdhUzVnWSt5dVBJOUkzdHloN1lRL3Qz?=
 =?utf-8?B?OVE3R2hNTXI2Tm1MN29FcE9TWlAyYTdWbytLQ3VjYlVuSkthVHA0bVBjeVZp?=
 =?utf-8?B?cHpPSjVSdlhWaUhadjFOZ3UxQ3B0TWIrcG9NOHNQSlBiZU5YTS9JbjFuNWJI?=
 =?utf-8?Q?likFyORljXjyhyLRF1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00465003-8260-45a0-d363-08df2aa89e96
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:39:41.5890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13dTz1G+AqSuEQ3JJVFvUI3fCRxvSjcuaJITqLnjmr05koohfWDI3vrtzYl6ncoM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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

On 10/15/26 10:37, Jesse Zhang wrote:
> For AMDGPU_GEM_USERPTR_ANONONLY, amdgpu_ttm_tt_get_user_pages() only
> checks the VMA at the start of the range for a backing file, and
> amdgpu_hmm_range_get_pages() then faults in the whole range, across any
> other VMAs. The check used to reject ranges ending beyond the first VMA
> (vma->vm_end < end), which got lost when the code moved to HMM.
> 
> An ANONONLY userptr over one page of file-backed memory is rejected
> with -EPERM, but one over an anonymous page followed by the same
> file-backed page is accepted.
> 
> Restore the check and reject ANONONLY userptrs that cross more than one
> VMA. The second userptr is now rejected too.
> 
> v2: reject ranges spanning multiple VMAs instead of walking every VMA
>     (Christian)
> v3: cast num_pages to u64 to avoid an overflow (Christian)
> 
> Fixes: 6826cb3b92a3 ("drm/amdgpu: support userptr cross VMAs case with HMM")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Philip Yang <Philip.Yang@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 2103f8d6165d..9c3efc27b363 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -784,7 +784,8 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>  		goto out_unlock;
>  	}
>  	if (unlikely((gtt->userflags & AMDGPU_GEM_USERPTR_ANONONLY) &&
> -		vma->vm_file)) {
> +		     (vma->vm_file ||
> +		      vma->vm_end < start + (u64)ttm->num_pages * PAGE_SIZE))) {
>  		r = -EPERM;
>  		goto out_unlock;
>  	}

