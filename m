Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A367C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jan 2024 07:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB4810E355;
	Tue,  9 Jan 2024 07:25:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0228410E35B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jan 2024 07:25:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8BrbfBO2tCvAeQdDciaPX0a2Al2khHi3bsm0UQvOW0Z3c0zirZqZHh0MhJizC28YyepG8uNAf/IuxqOqhTSXkorD/Kq+/HQZj0M5r/WM2Zex3lUsbUTLYtbrkNAbL7QR7bZBbOAJqWUcABt+kphlVDLGzR+Loz1e2A/A76ebB00eW4ez8WjG6nP0laX6NXETarRGBTS+LxxK0RON6QaPzoTKxXbiQWeY/n2JlQybrudvj9/4waNMpnNkY8hNkxKw4bUOxRH2pUpKUGdIvlF3bI9M2iUhdoJQ/4jj2/pcdMkI+JCKyvdripRGVTrJ8oaTcdC2NUlWgo0Y+atBV7k+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbDf6+w0hKra22fFxqGu9QEYwjrQnl2mPhEwrNDAtv8=;
 b=cAohs/tr2+xPJw3T6HzkuDRRIqW2M9PFg/co787TsWBc2Ni79Mn9xphLtOBTofC2DHg7HdIVZX5Vd7mUbM8LAy9IZo4lQVP7yHBs8qxhkVL8wh6uzB4LaA2DW1I+vt4xfZfGdhdNJ3uOQZci+trYmSH19D6iZLCI9FZJ/MUmJBVHRZz9wXYrRjzCk3zaXGlF7fkp3fz+/mo1SWxF4VGFy9PK4I2zQblQffTeU19z6TUXnwgrcqQ+LPS86NAczqLiYRcQ63Zz7PLUdY05lCM37jC9ewGC+6fGUhi9Pz4Xf2oysnbSM1hODBmt3e5EYQ7XIYcCEbPi2fh0oxDLC7MS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbDf6+w0hKra22fFxqGu9QEYwjrQnl2mPhEwrNDAtv8=;
 b=TouIYQplWOEgNE2Nx+lnUqnwSyumLx4i+IqD9G6NRkJeWlZf79L6vscr/aSWqQMejlFtYJilsaQNRoaiIH+r0mokbGFmXIkyYEO5ytmz3c4UqbtCrw/1JosfW15PkR1+oK7d2IXSpQLYn12A96zt91k4LCArHomICDJSDnu59hQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 07:25:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 07:25:38 +0000
Message-ID: <71636a9c-9143-4f8c-b77f-bba7473ea857@amd.com>
Date: Tue, 9 Jan 2024 08:25:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: move kiq_reg_write_reg_wait() out of
 amdgpu_virt.c
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240108213811.18711-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240108213811.18711-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 415028c5-1722-4448-1c36-08dc10e42d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5qLbbq7CTSq9UJYDoJF/tjH0Oyw4ikwAxaEZ4T+hAmnaHXGe5zUDz72AmDUrqmexI1xDFjED8B1lyIWP/IcO30gYnvs9RPJ0L0e+ORYVAui8Gpsfvp81MNpkBlO0vPwGkgEAbZ4Hek7SdM4Z6qvPrM1yiutdnJYzh6S7P9yTFR0yFOmJ48dtrjnfl9lQ0ZEO7dP5Bmo/fVr0b7Sflynl7tcEGa6tYrLIp7UMjWe1lJycfzh3Pyukw1jLXRl+Y8We+vceO34k9d1/Fl47vvlcMnPy2dPIcX2+R2p5Rl8iQxfsq/j5hg7SCBLDhon7I49wOYACoRfB1aP5FSHoO3H3DB3rsCZcBuPnxXPwxbWwoha/LRT/misiSaYX+bxbWfNHuk3FMFAggvEX4BbJbZowwxTFdq6us4XXkb5DGTp/k5BNa1iG7zSX60XtngRfYUNhD2A/5re6Q3yhIRG4oeLbSGm7bDDeHeTufN7CiGib3IlGQcLZ4zqqOrFbyfZ+pJ1nTOGMNHuHt6S84IzvGClnDuv2OCwSyXOSL1RRIpzj2hzYSm8TjRla/lxHO/MmjM0QtWpr7Jk4TDD6qcm1nfHCZu9M64XuJZa+68smV1BYUdwiXen4myOJiumwezy7ZpzhhkGwDv5LMVL3sdj3sl4qkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(5660300002)(2906002)(31696002)(86362001)(38100700002)(478600001)(36756003)(6486002)(83380400001)(66574015)(2616005)(6512007)(6506007)(26005)(6666004)(316002)(8936002)(4326008)(8676002)(41300700001)(66946007)(66556008)(66476007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2dOdkp0akFubStCRGxGbjh4V2RNdE8vblluK3kvVUJzU2lSL213WVZFaUR5?=
 =?utf-8?B?OVNEUENPZTlCWXpkS25BZ0h2UDN0bUlERTJrM041ZUdsOTlRb2gwbjRiRm53?=
 =?utf-8?B?UE11Y3VLVXlNZjl0aEF3dVZaY21QeDRvME5uN1NuK0RsQVk3TU5zRUh4WHZy?=
 =?utf-8?B?OEkrbkhKZDVpWnUxM1VwYmZxNm5iNTJFKzk4aXR0VDZQS3JNN2Fja1U3Qlg0?=
 =?utf-8?B?dUxGcGlodmFVM1lZOWlCdVJ1ZmVNOHpsZGZycnZ0TktFNHBraWgyYWcvTTRw?=
 =?utf-8?B?NFpLT25lSE1kTXk4V3hYOUN6c3hYT05RbVdxcDR0eWgrMWErVTl2bXF4bmVQ?=
 =?utf-8?B?cXdLUHlxMDBIdzk3RUcxL1QwaW1GK0J5eXBJUWZ6UmNVQm9xYTZUaThUR2JM?=
 =?utf-8?B?eFZzbHI1R2VDcHpCbFBac1ZISmdoNlE2N2ZTcEJPUnp1YTkzWlhmbDJsclVF?=
 =?utf-8?B?b0duR3JDcDA5ZTBtQWpadjBEblA0ZlZNL1F3cCtGZmJOdTEwd2lOWHVoUjZR?=
 =?utf-8?B?SmUvZ0YyMXdKd0tNcWY0dkR5TXZxSFNUUW55bVFlVXBJRXJUNkEzb3NoY1li?=
 =?utf-8?B?ZUQ4YkgrSnJmSHVnZHEzYnZDMDBrdkE3MEMyejZIWW9GcmZtc1BlWHBIeWdE?=
 =?utf-8?B?blQ2a3p2NUxkYWRTNldIeEVBQ0RWMHQxOWxLekJzYWV5MlVUSWZ0NWw3NnBI?=
 =?utf-8?B?QXNLWUdwK1pXVmdmTEhVcUFXbksvdi9mTzJ4ZVRKcmkyNVRRSGN2ditVMDdq?=
 =?utf-8?B?S0pJUDZDcDM3cXliOVRiamdHdGk3bzRtajQ4Y3BkR0g3VjMrRWt2VUhhUTRj?=
 =?utf-8?B?UTdxc2VHTDdQcDJ2VkNiQzFtYWZlM0ZUc3Foa3duYW1zUTcvMWs0NFNjWG95?=
 =?utf-8?B?VzhaTDZxNTJEMEFwLzdIS21XNU5QWHNaSG1rOFUvNWFhaEt4cDVDMEhvN1Mw?=
 =?utf-8?B?dnk3ZStEbWRDcHZNOUJvaFhLY0NCQk5sSFR2dmZHdy96UXhIY0pDbkI4TXJL?=
 =?utf-8?B?NXpCUHdYNitrMm5EN25TZ0pVWmdaMWp2TzJMajZWMFowdThmSCtaeWxOQlg4?=
 =?utf-8?B?UTFIVE1BUy9VRk84UUVIQXovUWJlalluRmNXSW85VlJoZHJHWHpBNW53RzZZ?=
 =?utf-8?B?VUo2MUp1MUR3L1FrNEhxekJpd3hGenFKOENpZXQzNFdScjN2NFlNZXEwb0JB?=
 =?utf-8?B?WjRNajNuN0kxY3BGc0Z2STJhQXB5MmhPbTI5d0JUQktTYVhPMktJWGxGZzZV?=
 =?utf-8?B?VGRaZ0lGNk9UWUVFMXZUZ29ZaE5LQVVBU21zb25EWXVoZVBjdG9EYkxCT1No?=
 =?utf-8?B?OElPck9abHQzMlcwY2UvSkEvdkhBb1ZncktGNHM1VFZ1TFROcDQ3RDJOMlNH?=
 =?utf-8?B?UW53ckYzdEpOOGhqcTB4MGlVL29VSkhYOXpCOUxmTTJvYXRxbmU1YllqQmZK?=
 =?utf-8?B?QjcwaTFYTURpK3Z3VitVdExvSmFYeW9qemVwdVF6Y1FxalZXSFVPYXBTVHcz?=
 =?utf-8?B?N0laejlkbDdjNVRuMGVpaTY2VUxSdDNnRUU2QWZaLzhiK2RhdnNkdkFaSlBR?=
 =?utf-8?B?cDRaanlNbTZFRnRVSlFpMzBwUmZhSTJTakhRR21WcEh0VXdPbE1zOVJaQXdt?=
 =?utf-8?B?MzYwMkM0VUp2OVVDMzVzaEVRZC9GSG5aN0g0c1hGOGRObXl1NmFsNUppYTd1?=
 =?utf-8?B?NTVmOTRIVFJXYnBPN3UyaWFhcnlGUzJKSTlESWhqVnM1YUFQVDVJOW13c05S?=
 =?utf-8?B?aHpUMGJ1aHJnalZQK3dtYnRaOWUyaWE0TExoaDh4SitkQ0JicDBRdlRPWGxt?=
 =?utf-8?B?SStiRTQ0dlN3Y1pBd2VMbkQ0dWJ2TStJTnFTT0VxTWdzRnlUR3V1akEzNHdK?=
 =?utf-8?B?bFFaem1zNXhOUmtZc3d0eXJNbkdWNklyaHNOOG1vblZiT25hVXdoOW9HZy9r?=
 =?utf-8?B?OWtJb0p1cHlSVWx5T0oxZHBIMlJMNmt6WExSUE1kMDJiQjNBVnpBNjhEbXp3?=
 =?utf-8?B?MjFkWlVmellTek9PREM2dkVpQUI3NkVQTHppcVFMTlREdHJ6b2x3OVRyeW85?=
 =?utf-8?B?VlcvTWlqZXJ3MVlkZlF3SmQrT3NDMHFMRThCeitWQ1A1TjVpOHJlc3ZPc1Ex?=
 =?utf-8?Q?cTrv1JeFF3uK2Zt7us6bPaiaf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415028c5-1722-4448-1c36-08dc10e42d3d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:25:38.0189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dx9ml8UI8/GYBgVFEE3zu1GP4T+by+4xUbzU5QOeRKDfu1kOWlQriBPUpTE7hl1D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013
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
Cc: Shaoyun.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.01.24 um 22:38 schrieb Alex Deucher:
> It's used for more than just SR-IOV now, so move it to
> amdgpu_gmc.c and rename it to better match the functionality and
> update the comments in the code paths to better document
> when each path is used and why.  No functional change.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Shaoyun.Liu@amd.com
> Cc: Christian.Koenig@amd.com

I'm wondering if having an amdgpu_kiq.c wouldn't be better, but for now 
the patch is Acked-by: Christian König <Christian.koenig@amd.com>

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 53 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  4 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 53 ------------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  4 --
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  9 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   |  9 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 12 +++---
>   7 files changed, 74 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d2f273d77e59..331cf6384b12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -746,6 +746,59 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>   	return r;
>   }
>   
> +void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
> +				      uint32_t reg0, uint32_t reg1,
> +				      uint32_t ref, uint32_t mask,
> +				      uint32_t xcc_inst)
> +{
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_inst];
> +	struct amdgpu_ring *ring = &kiq->ring;
> +	signed long r, cnt = 0;
> +	unsigned long flags;
> +	uint32_t seq;
> +
> +	if (adev->mes.ring.sched.ready) {
> +		amdgpu_mes_reg_write_reg_wait(adev, reg0, reg1,
> +					      ref, mask);
> +		return;
> +	}
> +
> +	spin_lock_irqsave(&kiq->ring_lock, flags);
> +	amdgpu_ring_alloc(ring, 32);
> +	amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
> +					    ref, mask);
> +	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> +	if (r)
> +		goto failed_undo;
> +
> +	amdgpu_ring_commit(ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +
> +	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +
> +	/* don't wait anymore for IRQ context */
> +	if (r < 1 && in_interrupt())
> +		goto failed_kiq;
> +
> +	might_sleep();
> +	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
> +
> +		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> +		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> +	}
> +
> +	if (cnt > MAX_KIQ_REG_TRY)
> +		goto failed_kiq;
> +
> +	return;
> +
> +failed_undo:
> +	amdgpu_ring_undo(ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +failed_kiq:
> +	dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0, reg1);
> +}
> +
>   /**
>    * amdgpu_gmc_tmz_set -- check and set if a device supports TMZ
>    * @adev: amdgpu_device pointer
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index e699d1ca8deb..17f40ea1104b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -417,6 +417,10 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>   				   uint32_t flush_type, bool all_hub,
>   				   uint32_t inst);
> +void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
> +				      uint32_t reg0, uint32_t reg1,
> +				      uint32_t ref, uint32_t mask,
> +				      uint32_t xcc_inst);
>   
>   extern void amdgpu_gmc_tmz_set(struct amdgpu_device *adev);
>   extern void amdgpu_gmc_noretry_set(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 0dcff2889e25..f5c66e0038b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -71,59 +71,6 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
>   		amdgpu_num_kcq = 2;
>   }
>   
> -void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
> -					uint32_t reg0, uint32_t reg1,
> -					uint32_t ref, uint32_t mask,
> -					uint32_t xcc_inst)
> -{
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_inst];
> -	struct amdgpu_ring *ring = &kiq->ring;
> -	signed long r, cnt = 0;
> -	unsigned long flags;
> -	uint32_t seq;
> -
> -	if (adev->mes.ring.sched.ready) {
> -		amdgpu_mes_reg_write_reg_wait(adev, reg0, reg1,
> -					      ref, mask);
> -		return;
> -	}
> -
> -	spin_lock_irqsave(&kiq->ring_lock, flags);
> -	amdgpu_ring_alloc(ring, 32);
> -	amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
> -					    ref, mask);
> -	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> -	if (r)
> -		goto failed_undo;
> -
> -	amdgpu_ring_commit(ring);
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
> -	r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> -
> -	/* don't wait anymore for IRQ context */
> -	if (r < 1 && in_interrupt())
> -		goto failed_kiq;
> -
> -	might_sleep();
> -	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
> -
> -		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> -		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
> -	}
> -
> -	if (cnt > MAX_KIQ_REG_TRY)
> -		goto failed_kiq;
> -
> -	return;
> -
> -failed_undo:
> -	amdgpu_ring_undo(ring);
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -failed_kiq:
> -	dev_err(adev->dev, "failed to write reg %x wait reg %x\n", reg0, reg1);
> -}
> -
>   /**
>    * amdgpu_virt_request_full_gpu() - request full gpu access
>    * @adev:	amdgpu device.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index d4207e44141f..1b49c007ff62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -332,10 +332,6 @@ static inline bool is_virtual_machine(void)
>   	((adev)->virt.gim_feature & AMDGIM_FEATURE_VCN_RB_DECOUPLE)
>   bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
>   void amdgpu_virt_init_setting(struct amdgpu_device *adev);
> -void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
> -					uint32_t reg0, uint32_t rreg1,
> -					uint32_t ref, uint32_t mask,
> -					uint32_t xcc_inst);
>   int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
>   int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
>   int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 6c5185608854..db89d13bd80d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -262,16 +262,17 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	/* flush hdp cache */
>   	adev->hdp.funcs->flush_hdp(adev, NULL);
>   
> -	/* For SRIOV run time, driver shouldn't access the register through MMIO
> -	 * Directly use kiq to do the vm invalidation instead
> +	/* This is necessary for SRIOV as well as for GFXOFF to function
> +	 * properly under bare metal
>   	 */
>   	if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
>   	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
> -		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
> -				1 << vmid, GET_INST(GC, 0));
> +		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
> +						 1 << vmid, GET_INST(GC, 0));
>   		return;
>   	}
>   
> +	/* This path is needed before KIQ/MES/GFXOFF are set up */
>   	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
>   
>   	spin_lock(&adev->gmc.invalidate_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index c9c653cfc765..6c68135cac9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -223,16 +223,17 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	/* flush hdp cache */
>   	adev->hdp.funcs->flush_hdp(adev, NULL);
>   
> -	/* For SRIOV run time, driver shouldn't access the register through MMIO
> -	 * Directly use kiq to do the vm invalidation instead
> +	/* This is necessary for SRIOV as well as for GFXOFF to function
> +	 * properly under bare metal
>   	 */
>   	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.ready) &&
>   	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
> -		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
> -				1 << vmid, GET_INST(GC, 0));
> +		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
> +						 1 << vmid, GET_INST(GC, 0));
>   		return;
>   	}
>   
> +	/* This path is needed before KIQ/MES/GFXOFF are set up */
>   	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
>   
>   	spin_lock(&adev->gmc.invalidate_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index f9039d64ff2d..9bff72356a37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -829,23 +829,25 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>   	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>   
> -	/* This is necessary for a HW workaround under SRIOV as well
> -	 * as GFXOFF under bare metal
> -	 */
>   	if (vmhub >= AMDGPU_MMHUB0(0))
>   		inst = GET_INST(GC, 0);
>   	else
>   		inst = vmhub;
> +
> +	/* This is necessary for SRIOV as well as for GFXOFF to function
> +	 * properly under bare metal
> +	 */
>   	if (adev->gfx.kiq[inst].ring.sched.ready &&
>   	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>   		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>   		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>   
> -		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
> -						   1 << vmid, inst);
> +		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
> +						 1 << vmid, inst);
>   		return;
>   	}
>   
> +	/* This path is needed before KIQ/MES/GFXOFF are set up */
>   	spin_lock(&adev->gmc.invalidate_lock);
>   
>   	/*

