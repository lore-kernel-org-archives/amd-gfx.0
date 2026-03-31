Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A61F1061B39
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 11:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E198A10E8F4;
	Tue, 31 Mar 2026 11:42:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eV8btIe2";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012013.outbound.protection.outlook.com
 [40.93.195.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB64710E8F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 11:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDCmVm6A55wVh1C2TEoxZSgsW7rqCaUsvo7plfuExQZP0/VjQPYS8tEjTA13lSixcx/bepQHMFGFL/GOxAV9WmkDZU/+4qkrvV3ZcTF+pDQsQASdOfJUtcbF7wUdcTE2qJqhdmBiS1aZ9UImxbSEHJ+deaWNf+9Ved1P5DkXAXBGu7IPw1QxWHcIlgUU5jU6Ntumib+G/iEcKTlnxrcCtuSHiIo2FZJz45+R/ch4Bs7dz7PSkJLqNrgAl+VHEVz3Jaz8qQwccl1HwSpbRCr9qsR/Pm+sXqa7DwZZVrnFHV/QhLR1FIfosyH+0XCzw5hNhROJNpj9jRiLLZedtzwN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlKk/hLRiYKtBXJlZRuIouwospLtF7NIaadmFbiUM7g=;
 b=bumqOo8Otq1hhT2MjJd+GUo02Ez0PqtSaMBB0yzeZaE2nqWYV2ecCWcwOh+Ucf762J1T9xmgugTYGYZsOXnPl6zedUuVwOZxfqkWIFI8A21AbkruVS7EnmHi8mMWCep6AUj5COLSSBARV17be8iIwF8LM0OCxdMIWkS1xq4APrOK/W3yIRW+ilL2TaovAV9A37+oG78n8n7dVhWdb2AKETnRJU6fpkK0KH8sPHkLIsN12s4+b6HKYY1F947QWiyCa1B0dwNNVUV+a0GzsxHZTNHVQKshnPu56AJn6+zv/xug5nRN3ZJY/wFWPfoWHP31bhE5gkkXRhr/jLXE4yhbnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlKk/hLRiYKtBXJlZRuIouwospLtF7NIaadmFbiUM7g=;
 b=eV8btIe2hUX4qSrzspBT/hEtx1TboONiqqca74KIN6anD8FkojJwy4u5lX1E8jgUoUwGDd40Rxdd0b7O0CD/eDzMJDxbpbW0HxOf2S4pgrh4Omr729BL/SKB+x5rn7M2PK/H+BDvxa3YvcVgnWdh9hvsURKno5CohqZK3O5SonE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6162.namprd12.prod.outlook.com (2603:10b6:208:3ea::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Tue, 31 Mar
 2026 11:42:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 11:42:33 +0000
Message-ID: <6e408ee6-2855-4845-85be-296b1e6108cc@amd.com>
Date: Tue, 31 Mar 2026 13:42:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 1/4] drm/amdgpu/userq: dont check return value in
 amdgpu_userq_evict
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260331074943.2510941-1-sunil.khatri@amd.com>
 <20260331074943.2510941-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260331074943.2510941-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d3d837-9896-4f50-8fa2-08de8f1a98dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: BTwQ7oNPA3DrGNvatzNuyRoG1oujPLJqmtwyZ+3a+VABodDP1gT5mJpbO+xoEbscbsXIxxOxdgYeFt0svUPeWDUhbL/Bwgvtfc67EIFO76QR9l8S571POqig/gdvLyRS00Ux45z08a0pVODwhHTkg/VX+cLNMCdnNieHZWJp3AAKVN9gsMkOAzTEirHwoJ4lL21zZPqaj4MV9dpIpp2CG7xzpf84MWDhdKI68KB3VW9L90VcEDp9SahZCCIyv7ZKB6QHb+O84MhWS7oVg6u/MeLJRIxSSp9cOOBSVApBrvuNzYo5KQe6VXNVOA5utH1WSNCJNtM9pc6XwKe15rjrQ8IWz3Ixs4zNUhRNc69U3GnSenbLmF6ArmB2xzQuHFqtS0Ku+kqGn/IXlwZIX2VDHMAigIi5R4QvHV9bJPe+Nxo+Joi/sbefpxs4+zubfWp45xyvHveVuRSA08Zi4YZQ7fM2ogWbyJPEh6/NVN9Uqxrf/znOXjv58FEP6Kqm9oJ1fZUqlQWbrINmNG8mrL5b/gpVn/4itB4xISbjBQJJ4/kSUE4iarSruqUfzcap2DNgEMGz9XDm3cEUmCtkRu9ozgz66TNPIXXGSkFQlIknpntnhT4gI4ZDRVIq1VzEGXropkjO4NSkoJi9FyYECV48S0cQ4Sc886zW5+ivlFQEGFPRQeY4cqpfYQx2JkFLrzoZrLePTFCp4846z9JAFnSpf4LHlUQhGOg+0vnTxcoe7Y4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUNnYWh2NmxWTm5peGRGL0h0cEFQa3UzOCtKQU8yVUoxeVlvTC9GK3FHamti?=
 =?utf-8?B?RTVWOHhybVI2NFBRaDBwdkY4aVV2QXRwRHB0c2Qxd0lBU2ZwMkpNRjhZQVQr?=
 =?utf-8?B?R296dnZITVlkcHJQZjJOcVVBMHE0SnRmVUpZRGxRTFdBRDRDc1E4R3BpcXlm?=
 =?utf-8?B?TzkrdjdvZXczekZiMDVIbEo5aVlxZGtIbGlUZzVudDJVRzNZTVVuM3ZENVo0?=
 =?utf-8?B?TVNvN3RaczVPaVhWSlBWNElBbTZvU2Nua0RsbFhHZTJEcnVOQm53cFRmYjdS?=
 =?utf-8?B?WlRDb0JaQmxjYVpHK1k5TEc4R2lDVEZIUWpTK1V1UnZDYmpmT1lscGt3U21h?=
 =?utf-8?B?ZHBJUElTMmNHcDlRL2o2ejdxeDlYZjdiWWQzV3FDa3lXUkN3ZHp6SWtHUklS?=
 =?utf-8?B?eHRhS0tzTnBEdlZwdWhDR1Y1bHhHTmhzR2RDMDFmSUtjMHNsN0tRYllZTkVM?=
 =?utf-8?B?dGErZnMwMDhKTENReVgxRFZGN3FtRk9EbVVLV3loNlQvOUl2bGdMM2VHaHlY?=
 =?utf-8?B?MGlXVGZVOERCcVJ0VDQ2K01vRkYwL09WL3dBYUhnNjl3T2libDBiaHQ2ZFBT?=
 =?utf-8?B?TmYrZlJTNHpLM2cxci9iUDVFbTFNQzZSU0xkQXJoeTFjQm1pa3RBTFNOWW1z?=
 =?utf-8?B?ZnJxYnl2aE12MDd6YjAxT1hHWGtjekkrdFJEWU53MERZU0NPT1lTQmJ6R3Nz?=
 =?utf-8?B?REZiMjFHWDA5ZGRPTUd3WE5FNU5nbUoxRDZNbk5ON0VCdnQ2WWc4SnoybEJX?=
 =?utf-8?B?cEtDdDRCemwxWGFYVFRNMG5SY1MwY2tBZjBIQ0ZQWFdZcU1GRHgvbFBHbkdr?=
 =?utf-8?B?TGwwYnc3T2FsdDR4aXI2SEJnMUpPUzNPWWk3cFkzNXBnL0dwK3Q2Y05LVFZX?=
 =?utf-8?B?ZmxoL3NjM0p2NUpvbUhZVUVxRjUxS0piYWc5dzVXTEd3b3dROTE3NUpHekl5?=
 =?utf-8?B?VHphSnBHTXZxTXdIVHNJMDhHbEoxQitkTGszVXdyMnQ4NTVCT256c0ZKSEQ5?=
 =?utf-8?B?ay81NXJzTUhpamZHYkJBWklCUG5lZTBoNkRHTFpWYWpCc0dvNjdsSHhIZnMr?=
 =?utf-8?B?MVlqRTJyL0ZwdnNCcXA2R29sT3puWlI0QmprOGI0R081UGZKZU0xNVFOMTBj?=
 =?utf-8?B?endhbFY1eEl5WFJ3TzRZZnJwQy9ON3RjSXgvOCtUZEpka0JpRkpWL1NxM3o3?=
 =?utf-8?B?dUNHN1hleTgvVGRocExVT1E5bVYyZGNkOUk2WC96Ynk2K2NaZXhYNGRjeWNE?=
 =?utf-8?B?dzhCLzJWSTFuZDZOTlBQcjBsR052Yk1PUE92WGZScVh3VE16U2ljOElUMkZC?=
 =?utf-8?B?RVVuVU1hQ2VRSnNiMEdsWGhFKzNqQzd4VEdlYm8wZHNYbkZISnZQUEM4Smc5?=
 =?utf-8?B?dlBOaUV1MHRiUVhkQkszeGJDZmV3UWMxQ25rajl5TVFJdmZ3Z1crcjdMRnRp?=
 =?utf-8?B?aU9UZkhrdk9vZ0ovU0pLUGVaZnpKSUlISllaQ1A1QUs2Mmc1eWYydGhlc3VP?=
 =?utf-8?B?RkhjVVZWMlpEKzBuR1JoYWh6SWMyZm1XK1pCZXlveG41RElzdnNuQ2tUSHJy?=
 =?utf-8?B?ZVRtejNFY3NtWEUyZVVING1kSmtwU1EwMHV3T2JXaGNZcm43MHdId3d6UjhE?=
 =?utf-8?B?dVkvTFA1cmkxQ044ZFpYWDhTUmJMbDFvWmhjTEJqdDNLZENxZitwOWtUSjNO?=
 =?utf-8?B?YmlSV3QySm9hRlgrNHo2TldMMTFUWWMycmNJUHRxNWJWRFUvczdTMVJBTnpr?=
 =?utf-8?B?Tm1wamZTSGl2dm9LbVZmenhCcmp5UWF1U1pWZEx5V01xcDNqZG1DWlNidlQr?=
 =?utf-8?B?TUFYNEFPREdUVlRwV0gxK1k1RzJmRkN0bHAwUzNjSjVyNjVWb1kvemlMU2M0?=
 =?utf-8?B?MWdVSmxLcjdVRCtiT0ZTSlNJeFc2WW0ycTh0VkFpRVFvTWxacG42aUREVGZn?=
 =?utf-8?B?QXFmOTJxNTRKNFJjWHorMnhYZnVYSUx4WUJjZ2FFOENJQ0pTanpkandZU1Vz?=
 =?utf-8?B?V0RnNGVDRmlMeTgxWTllMU11ZGNBaUxxaVZlMjV6RmRsSDExQ3BhV2ZMcmhS?=
 =?utf-8?B?Q0lIcnoyczluNWVTRnpRVEJaRGJXRkw1NlFWcDY4dXZ2ZERhYUZhNmlsTjUx?=
 =?utf-8?B?ZzNucURpSVBqbDJzM2FCbTE0akdGcjk5WjBUTHVTMVc5aVdGaHNaS1JkN2Q1?=
 =?utf-8?B?S2JRM1VReUgzT1FxNm9sU0hueW9UZ3E2NjZYYTRyZGRjTmpDblhYRmVrbnZF?=
 =?utf-8?B?bnZwRis5QUI0K2xBMXc3Kyt5YXhIQWhyN3F2ZUhQcjZUMmo3QjdNbSt4MU5G?=
 =?utf-8?Q?A+jxy0zX+lbHBMYl9T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d3d837-9896-4f50-8fa2-08de8f1a98dc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:42:33.2945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hH55pBBpqMgzX15Aqo/9sYB7Csu5VNfqUu5QkcfF3RJBrrqtI4OvyeY2gJf8eXrl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6162
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



On 3/31/26 09:49, Sunil Khatri wrote:
> In function amdgpu_userq_evict we do not need to check
> for return values and print errors as we are already
> print error in all the functions of amdgpu_userq_evict.
> 
> a. amdgpu_userq_wait_for_signal: Could timeout and we print
>    error message in the function already
> b. amdgpu_userq_evict_all: We unmap all the queues here and
>    in case of unmap failure we already print unmap error.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 26 +++++++++--------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index fdae8c411aaa..79ee2f6e09da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1258,7 +1258,8 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  	}
>  
>  	if (ret)
> -		drm_file_err(uq_mgr->file, "Couldn't unmap all the queues\n");
> +		drm_file_err(uq_mgr->file,
> +			     "Couldn't unmap all the queues, eviction failed ret=%d\n", ret);
>  	return ret;
>  }
>  
> @@ -1289,13 +1290,14 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
>  		struct dma_fence *f = queue->last_fence;
>  
> -		if (!f || dma_fence_is_signaled(f))
> +		if (!f)
>  			continue;
>  
> -		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
> +		ret = dma_fence_wait(f, false);

>  		if (ret <= 0) {
> -			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
> -				     f->context, f->seqno);
> +			drm_file_err(uq_mgr->file,
> +				     "Timed out in wait_for_signal fence=%llu:%llu ret=%d\n",
> +				     f->context, f->seqno, ret);
>  
>  			return -ETIMEDOUT;
>  		}

You can completely drop this. dma_fence_wait() will never return any error when used like this.

Apart from that the patch looks correct to me.

Regards,
Christian.


> @@ -1307,18 +1309,10 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  void
>  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
>  {
> -	struct amdgpu_device *adev = uq_mgr->adev;
> -	int ret;
> -
>  	/* Wait for any pending userqueue fence work to finish */
> -	ret = amdgpu_userq_wait_for_signal(uq_mgr);
> -	if (ret)
> -		dev_err(adev->dev, "Not evicting userqueue, timeout waiting for work\n");
> -
> -	ret = amdgpu_userq_evict_all(uq_mgr);
> -	if (ret)
> -		dev_err(adev->dev, "Failed to evict userqueue\n");
> -
> +	amdgpu_userq_wait_for_signal(uq_mgr);
> +	/* unmaps all the queues */
> +	amdgpu_userq_evict_all(uq_mgr);
>  }
>  
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,

