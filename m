Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFF7CCA462
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 11:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D432610E04D;
	Fri, 16 Oct 2026 11:35:05 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013014.outbound.protection.outlook.com
 [40.107.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D951810E04D
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 11:34:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8R1CAhlKFcRg19vpvJikgwFe9notKVLNfJFd3B4LJJy/mDWKuHzHzjMRa5Dva57nV3I5jc6Vrv7D5O/M9loaL6CTXgncrWm+IzL7aqB/5KG1DNw54GqExQ03KoBXQoEH5qOP2wR9FGIOwf5colxnk9MUudbKsL5K84QgYzIXgM8kec0W1+woMCg2R6zNhIBT9gK0ziUd+1K8NndlYMF8BLt+yGAavpzSWySmQTgsLKeDSVPfvhxMuAEVFQhJI4CqRE6z12AE0vyjSZ7dzdUVdfTJmuAMLdQLVtT6eLyGVPFTzd/F/tUAYsapB8WvIgfyAV8PbYSSPgR8EMsVYJ33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTaVdUKD8/+n1T+ymB7hPA/ie9fdbAs+AZYwFwlkX/I=;
 b=J0oqjxL3Q7uGHUaZhFB94unJ82vHRWcZdujJBUirA+tE97TDKdnE+V3ZQ4fONMme4vLOZvN8m+kdAd6YXlTH5viEbI1au/ehfW19B0WT6PpXhMjE3LO2yrcbw1jmT23PGM/jn+X0Bwjl2vU8zBg6lUeUgicGY6nXwEDhj1Z/vN2ThYANgTfiAJLA519staBYl++ysv5mAVVWN08ASNL3u2OZQYvKYc3PAjHpol1meafQf7PPIoQglUdD8WwjiAd2FwA783jVDb11lpwqpcVQQklU1q7fSj3+fIwO4EP2Rtj5/vlemceaKgK3wo7zJNfNw7F8aTfPyr7Ml4lO4P15YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTaVdUKD8/+n1T+ymB7hPA/ie9fdbAs+AZYwFwlkX/I=;
 b=VJ+mOvPIPlx9HS9rSHNTU+5+kNJr4zuKK9FqoI4sG+CjrC7uiBf9dUs36EDNFZYVLXFxShy/lhVqXMvBLldotehMbQjcZCK00DGVCT/s8O+lwHT0hUxgFDnOrxubbJu4R9onTphXDOQoZQybT2hYt1mIChtetoNXpTb6FrCBFME=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPFCD5E2E1DE.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 11:34:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Fri, 16 Oct 2026
 11:34:54 +0000
Message-ID: <a1676db3-7de7-4a49-a41a-433133fc4913@amd.com>
Date: Fri, 16 Oct 2026 13:34:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amdgpu: rename amdgpu_vmid_alloc/free_reserved
 to _spm
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261013112112.1449531-1-sunil.khatri@amd.com>
 <20261013112112.1449531-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261013112112.1449531-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPFCD5E2E1DE:EE_
X-MS-Office365-Filtering-Correlation-Id: e6eec758-5560-460f-5664-08df2b797fd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|22082099003|10067099003|18002099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5jXfXNPiu6c51VGC3EutVmQsjiUFHdPqcGSOCmwSQfjcz8MJC9xoTWUiaTtT7gxec9ol1mVisWWnB6eN4jVMie/1RT6P7n66jVGeHRcROWE92Vxb+KluJ99e1Xd4IyROcIylSUjqUpEXx1/S+5CJmarETPSlhg7tMsQ79CW+LK2PHD5r27047S0NMTfnnvd6kgJibpEEtNeC2Zg6v6TZg0z3QBpSNT+SJwtCFp/rMBtRtB/mr77UWhsk9MSNtKLJsGLb3BBC/Z4BTKXAX6WbqePQS7QLyoVAY4uvZmsqBPfd0bqokej1MbBuFrtsLqva9+QvyNxT2l0PqN3y+MBZLyF1YYdY+njWMLS71ydswaWZ6wWPYVeKkhmCW6yZNVB4moIanww9nQFfyBHMtfFS+pbjgw00r/rPDhTx70CaJOWI0tZj0ysaDf/WF/m+maqF4+Dkzt0n3W/hA1ZpTOQOJmu/QPjVZE9BbHqF70I3UqYeSdEwKCQVB9EOAwuffeNmMunUbpywkseFJUmLGr4MaapYeEM6HjjLhnj3QNphfYQ0OWKMnA3lgXy5YlaU1Tz1xj32wXpCmUl0O0n476YLJaLQPA7P+BLixsQL2l3u81F1NUK21JjEnykhM9VQFjH8jWv3mEWbQPcuXzcKq5eLEYvHU5A3abc1LYV7E6RSHAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(22082099003)(10067099003)(18002099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eURWNFNnSnBySWNHUjA4czZ2NzkvK0t4QjcwR0c0TzJRbWMramd3K3BaT2N5?=
 =?utf-8?B?aEVLT0NDVWxSeVlTVnB1dW10OURDNGRPeUxQS1pNc0g0WFJJdmdVZUtncjJK?=
 =?utf-8?B?MzZDZVQ3RTBOSDZlVFFTeTBYQ200cjBvRmk1Rk1SdFJ2T1N0dFhTTWV6d1Qx?=
 =?utf-8?B?cEtYc2pjMnVlczA2QkRWa1VXVU90UWZCTlYvQzZJc0VXd2lhL2FGSHp4cWJM?=
 =?utf-8?B?MjB2Ni90Q0o3cDFYTHdlY21BN1N5M0ZSU2srTW0vRE1QTTBJdjVHendvS0dw?=
 =?utf-8?B?ZnhjVkU5QjZxVkNsbDh4MUNBbXJ6dXdUNklvb1NWbjhwckJGTHFiWEJDLzlx?=
 =?utf-8?B?R0VaWmRKRDVodkFSbkxLaUM1ZnBWZW5MeWk4WnVYT090RE55YWVUWGVzYnBI?=
 =?utf-8?B?cXYwT29DbHBFOTVxcGZ6NmJSdUZOaVl1akUrV0hXTUxjakQvWjdGQ2RpTzAr?=
 =?utf-8?B?YXo0cWl2UEhEQmt4cUhEcDNvRmVzMmVDamJMWXZyUXNOcDl6TkVOTzc4dVBR?=
 =?utf-8?B?bzNTa3U5clorbWFBazU4WFlQSzl1Wmc2UURLWlF2em5aWmcxZ3U5cjA2ZTg2?=
 =?utf-8?B?M1RHVVZLQ2RFUExjV2lNbGN4M0FkRjUyQmZHWXBMNXpBMHZzNnNVU3NBSEFY?=
 =?utf-8?B?OGdBQkVod1NCaW9pUkR0TnRHdVBmSmREMWhyM084cDBid0tnY01YM1RmYVl5?=
 =?utf-8?B?N09jUUxvWHZxV29oakhac2xIQjFjeHV1bDd6Zk5LQzRSZjlkeW9jOW8ycXZD?=
 =?utf-8?B?alV2OGg4SWVTaVc0TVEwK3BIQTZ4NVlRRjR3N3VabEduUkFQUm9mdGtOeGVq?=
 =?utf-8?B?L2JCVW9QWnBRNW9IamZwb2V3MG9pRmZYdW85OWFIdnFoZ2U0ZHFERXdueVBm?=
 =?utf-8?B?Uy9ndlZRbFNIMFNjSWdIbE05NjJMOWRCV0dSV2FjOFNjam5oZWErK1lwNWhB?=
 =?utf-8?B?LzdYUW9NNC9BRTlDeFUwdVNGblQyT2pKZDZCVWhGOWhsSS9pdS84dHBOYUsr?=
 =?utf-8?B?MG43ZGFMMkQrbnRkR3BxRVZXUDU4TmZDRzRoRjRmZVRlZkRvUEFxWVpUMkl3?=
 =?utf-8?B?OE4wVnN5VDNFV29GeFBnQ08zck4rMXBzMHdnY2pYTUMwSkN4dkpDdzRHZk1I?=
 =?utf-8?B?NzBTSXJ3M3dPUWc4RlN1aW5rUXBiN2tBWDVFVEgrbjBTMUxGSDRhOXZMUmFo?=
 =?utf-8?B?YlFXekJadEVFNlNSZHlHdmFmK1JTbVNIZEhVWFNZeXNZN3VmakhBYnlsOXdp?=
 =?utf-8?B?YVg5VG1tTk1iQ04wSUtaeGx6ODVtK3VrV2NOVDN2NmJpcFIxSk5hR21OZ3ZM?=
 =?utf-8?B?UWNWME5US0dCVWFCSkVaYUtYbHdKUWI4UTJ4V01IL0ZzOWlvSWQ3ZVhJL1Qr?=
 =?utf-8?B?aW01WE5sbGtBV1hMRyt2OWM1SW5Lbis3Nkl3aUcvZEZQa2hmbWdjUW85UGEv?=
 =?utf-8?B?K3RGQXZuRVBMRGh6T1RPUGxEcEpab2FFT1A3NllmMmdUQnZsSmtQNEVQOGZH?=
 =?utf-8?B?bDdTVzI2SnhKek9FQ1RoQm5DaFpxdVFlN2lKcS83eXZKaThQT3ZCQThYUzli?=
 =?utf-8?B?aWxpdkVjY29mamdIVUR1cmRtNUZQMm9hR1lHanpxM1lGbU1wYWxKMjUzTlRZ?=
 =?utf-8?B?UE1TOXJSN0I3ZHlpZnBTSWF5dkY0anNvZm53Q1Z1OEhGYVBvYXA1Y0Rzanky?=
 =?utf-8?B?M1ZzeHdXcDk5YzJOU080WTZhNzJ2cUdYNnFUMlFTZytwT1IrK0VxSktjNldK?=
 =?utf-8?B?d2p2bDh4TlJPMGR5TURFTjczRUZJOW5qY3RqTU9aOFZDL09YdmZEL2xmRU1p?=
 =?utf-8?B?UlJLOWVVenljTUsyazJvekYyZ0hSdTZuNmp3dUYxc0FUcGZ4Y2g1WlNUVnE0?=
 =?utf-8?B?U3NLbmd4cVJWVlA3NVRBUzJQMDlBYks3aXc2dThkOEpjaUNnY3AzOW15dzJF?=
 =?utf-8?B?QUtQNDQzS2E5a1NORzM1TXZmeGp5KzhjM2JYWElMOW5iNStmSXJwNk9VNjll?=
 =?utf-8?B?NktDSnJSUDAzM2NZaytDSk9ycU02VXZFNHFmVWgyQk9aM0ZlVkJyS0tOaWwr?=
 =?utf-8?B?RnhYRzVBbFZicksreXVjSytrYmM4bnZPdlFQMy9IYm1BRjJpYWJjT0o4UFI1?=
 =?utf-8?B?Y1puZjY1N0lYY2dSZ3JvbVMvbUE2NFdCQk96RWVlRTJyNXdUVWVvSGFSZFR1?=
 =?utf-8?B?Qk13eXVPTEJTU0FPZjdqN2hXc3hTdElxK3ZxdXM4VjhkQWdFTDZMbFBmOHFq?=
 =?utf-8?B?aWhpM2hydVBFUXhLVDdXUThxM0x0WUl1UHRxZEwrVmhSYnMvZEs4Rzg4bHlK?=
 =?utf-8?Q?TbfwveMIwAY2rmCPWs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6eec758-5560-460f-5664-08df2b797fd1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 11:34:54.7133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6x1YL67T3ufT5Qh+iFPx5bAl+/TyOxrU3HGTA2AVRZRbueix3Cw+0Rgd76m1naSE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCD5E2E1DE
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



On 10/13/26 13:21, Sunil Khatri wrote:
> These functions only ever hand out the dedicated SPM VMID now, not a
> generic reserved VMID. Rename them to amdgpu_vmid_alloc_spm() and
> amdgpu_vmid_free_spm() to say so. Pure rename, no functional change.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 8 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 6 +++---
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index e5d84a786c4f2..f15702993eeab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -589,7 +589,7 @@ bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
>  }
>  
>  /*
> - * amdgpu_vmid_alloc_reserved - reserve a specific VMID for this vm
> + * amdgpu_vmid_alloc_spm - reserve a specific VMID for this vm
>   * @adev: amdgpu device structure
>   * @vm: the VM to reserve an ID for
>   * @vmhub: the VMHUB which should be used
> @@ -598,7 +598,7 @@ bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub)
>   *
>   * Returns: 0 for success, -ENOENT if an ID is already reserved.
>   */
> -int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +int amdgpu_vmid_alloc_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			       unsigned vmhub)

I think we also need to make sure that the hub is a graphics VMHUB.

There is really no use case for an MMHUB here.

Apart from that looks good to me,
Christian.

>  {
>  	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
> @@ -629,7 +629,7 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  }
>  
>  /*
> - * amdgpu_vmid_free_reserved - free up a reserved VMID again
> + * amdgpu_vmid_free_spm - free up a reserved VMID again
>   * @adev: amdgpu device structure
>   * @vm: the VM with the reserved ID
>   * @vmhub: the VMHUB which should be used
> @@ -637,7 +637,7 @@ int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   * Waits for all work that used the reserved VMID to finish before unbinding
>   * its page table, so submissions still in flight don't suddenly fault.
>   */
> -void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			       unsigned vmhub)
>  {
>  	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index b85aa2ee19b19..c134000eecfdc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -125,9 +125,9 @@ void amdgpu_pasid_mgr_cleanup(void);
>  bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
>  			       struct amdgpu_vmid *id);
>  bool amdgpu_vmid_uses_reserved(struct amdgpu_vm *vm, unsigned int vmhub);
> -int amdgpu_vmid_alloc_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +int amdgpu_vmid_alloc_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			       unsigned vmhub);
> -void amdgpu_vmid_free_reserved(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +void amdgpu_vmid_free_spm(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			       unsigned vmhub);
>  int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>  		     struct amdgpu_job *job, struct dma_fence **fence);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 7fd6215510a94..8d4c13f2ef7fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2894,7 +2894,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  	dma_fence_put(vm->last_update);
>  
>  	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++) {
> -		amdgpu_vmid_free_reserved(adev, vm, i);
> +		amdgpu_vmid_free_spm(adev, vm, i);
>  	}
>  
>  	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
> @@ -2997,7 +2997,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		int r;
>  
>  		/* We only have requirement to reserve vmid from gfxhub */
> -		r = amdgpu_vmid_alloc_reserved(adev, vm, AMDGPU_GFXHUB(0));
> +		r = amdgpu_vmid_alloc_spm(adev, vm, AMDGPU_GFXHUB(0));
>  		if (!r && !amdgpu_bo_reserve(vm->root.bo, true)) {
>  			amdgpu_vm_spm_update(adev, vm);
>  			amdgpu_bo_unreserve(vm->root.bo);
> @@ -3005,7 +3005,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  		return r;
>  	}
>  	case AMDGPU_VM_OP_UNRESERVE_VMID:
> -		amdgpu_vmid_free_reserved(adev, vm, AMDGPU_GFXHUB(0));
> +		amdgpu_vmid_free_spm(adev, vm, AMDGPU_GFXHUB(0));
>  		break;
>  	default:
>  		return -EINVAL;

