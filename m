Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF2606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3sCEg2ND
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA1210E0B5;
	Tue, 17 Nov 2026 16:54:58 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013028.outbound.protection.outlook.com
 [40.93.196.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C1C10E0B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 16:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmiBDqkNGLqRBaT79TYpvoxuaKMFwJaPKV7om/YNH/wNda7mxsbPPzq/yxswLYBB0aez6iIEoXklbV7sxU+mDQe+CqFdxcMZvynByI9zpZhc96DSnODklQV+L/pXdPW70JMRWRhE4uaLYneQelekYVH0XMcnHvihFr9TWkVeE2qAocPXxSZY1+YJ2K5lHKz1RVskBweFs5ybDKO7wdid7drwlk1TAFQKhwXwfBnSN0h2P/ECdWa+dzFndjN4cZmW7jt/6vw73ppbLoiJHD73+UJkvfkW1LVs8FDXx/IiNG59+upZ7lseaM+S+ncUAJJHRGu5PNmv+OwhiV871EdJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWV/AAWo3HkHbHh7OJ6CmIIlsQ4UA5p/DorlAHZE8D8=;
 b=FIzlOa1bxbgo1WYV3yieSDEJ5xDXl9SwwWZQ21UnQjUfb4e5MBAMSM6Bk2/3u3hBjP+LgTt57jyaL7m6lEflTXTdKrwWCKO++FhBD2bcgypxawN4GVWtXUDN3m4yC0vNpFYJGxHGfIlPGQv3heA7Ahbgefg4EYBVPpWFuKzR2rSE7HK4OlotvYP81qcRMBDh+tGqrZT7/KS3+Hd+TMw8u/EygNKTTJ9T8tcraEFgR0ECSWiQW7pqq2j55Oawp/XN8Os1PogiSpEomY/v1dXHTWdJuzLRUZfAyNwOc1T6H1+D7UJDP5XeHgfA8VU5yKVr86LRHwxHR09yunJPTB19+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWV/AAWo3HkHbHh7OJ6CmIIlsQ4UA5p/DorlAHZE8D8=;
 b=3sCEg2NDCz/wiHvCIMGzdW1ItGwaDHGu6AbSvH5vBlnfuqwySKX017ycst4PWndVpBkGRfy+5KeHlrOzLSTwZrmDnSsIc4g2paspHBdkS+JniS8OWU563A6DIcTW6guhwe8eptjHbHW/JZg/qrmWaUOg5U4TVVqvqXMw3ycxFZg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by CH3PR12MB9314.namprd12.prod.outlook.com
 (2603:10b6:610:1c5::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 16:54:48 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%5]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 16:54:48 +0000
Message-ID: <9d649b16-d873-402c-9d59-70a5dcbb38b7@amd.com>
Date: Tue, 17 Nov 2026 11:54:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Disable XNACK retry on GFX12.1
To: amd-gfx@lists.freedesktop.org
References: <20261116191141.145348-1-kent.russell@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <20261116191141.145348-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::8) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|CH3PR12MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 783a7418-bd46-48ff-df2d-08df44cb7d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|261009223027099003|11063799006|56012099006|261026121527099003|261021121427099003|261021123027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: S4v03I6n1czyv0l81TqiMOuqs+T/X9Gd2OQvwNrzIZFg89vqGGPKHx79NJ/VJ0kY9n8iMrQjJwg0HZleNtvx/HBgCYXLK+KmUKcdOEWkFz4N7zKAiemMD5VqGQaSIUgLmbitO/dCkDPzVsQfw0+gm26nX0NXrB0FzpiDhBkdudYW1IkxPqDIbsTwfvZ8ljWQYnApxRfYYT8HC9wZ7C0Lju75G1wrXv/YcYMeQ4IzwxJPXma68OUzuLJlQ+n3zKkv33QeMUlLHnTgEId9cwWKAht2wMT0HEYz+JxUKxWKVLDWQ3iGfsLsPWUsRouWBWxCNKf7IC0qArqf+wm9ygWo77LGMumItCngJikCFSuuL3yd0OI2oYOKkqQHlqwzhSt7nFDwIsZs3aEyDDMAWTeSLc2lmZr/BilCYM1aFBrVSp2L5HwOOHM/E3myA/MJXKQlhOvY731wQ+AjDMCWaP8sVw3PW5qusDNWhT4RohxMHQmpKcHkU39a7NzJbGXtp5elfL4xcsKEIBGayYAGwrfCbsidftplUGbV8ah14w3eshD/RIIjSp/jS7IiRMzwSVVrx4yMJKkTCEqySaI+MAHVZIXawEJmCTMc650+4lZC5l3nWGwdl571eDlzmVI84jTjYwPUHrbeoRdryjjuq24Xmf7enE2gxIP29iMFsT2DgP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(261021123027099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjZPRWlxRXhUUXNpay84TXcybUJTTHhkVGpaR0hKSXJLeHAvTmY0RHZBUTJJ?=
 =?utf-8?B?QkRhWHVBTUwrakZ0ZDVhVFF2eXYyWG13djYycHhlTkJiWEI4cVYrZzlxQVJ3?=
 =?utf-8?B?NFhnMHJOekUxQWx6TDhOTEt2cGxoU3Z5ZkxiVU51dkVaYjNUeGxBeExEY25G?=
 =?utf-8?B?aTRtMWxLdStGemx4UXdnckVOQ054R0I5YWJQVjJWTlVCVm5mRlNUMEFiTTNn?=
 =?utf-8?B?V1J4QTh1WTZIQmFZdkY4LzVZc2tkcWVEbW8veFZKb0grL1BSWnNSbW9tdytq?=
 =?utf-8?B?M1ovZmtEZDVCY3g2OUFOc0h1OElNUUhMeG1kd0RwZ1JHa01yYmlLNkY0UnR3?=
 =?utf-8?B?ZXB6bGM2THZIVmdDQVhOWEdiT1RXejkvWStlODdCRW1tNzVsR25odm5jcllR?=
 =?utf-8?B?L1VRME5rTHRCbDE3MTFZendoZXNHRE0rWTVkaDZQZlArYXE4WGlSS1lPME1E?=
 =?utf-8?B?ZGxacm9hbmJ1OGNMOVkwcXlQWkVxajliZnd0QzV5RFB4dXEyayt1UWlVd3d4?=
 =?utf-8?B?SWk4Mi9oeHJqaVI4NjVoenJENlIvZFJNaEt5OUJlMk5TZ0pNQkQ4a2tidWZm?=
 =?utf-8?B?VnhTQWhHcXRKL1BZb251WDBSaEMxYlA2YkY2UmVGSHY0WjNjWDNXQ2lLTWxI?=
 =?utf-8?B?eXM0QTJ0SG9URUtuUWIrRzFMYWErMmp1ZG5DOS9tQXM0NFc2dUN3azl3cm1h?=
 =?utf-8?B?ZkViQ3JGYVJSTno5dEpOVHhCc0lySGhkOWZaQU5XVDBQSW5uQjltdEtKNmdL?=
 =?utf-8?B?bHdndFFsdkc0bXEycWM4RkFXSDFldEFpc3dZUWNoeWZFa3VJZzlSZjdYZGRL?=
 =?utf-8?B?SWppZjRDeDJNbTFOZzJNWHJENzQ3aU1zTEZ4WW0waFl2YVd3MmRNeE16bGlj?=
 =?utf-8?B?dEpZSktIQlNZZ2kyc0FDcFdML3pBRHFacmRtTTJUQ2VESC9rbVpKNXBIdGtK?=
 =?utf-8?B?SllKY29GTnhvVTFkTExFT0JBNkpDTFZQZ1JYYVdXWUhKenhlOHRVYmVGeHZ3?=
 =?utf-8?B?MzY1R20zbTA5RnZ1NWhoc2UyWXh4OEw4SWRhRW9idThHUUhQb0FmS0Y2ZGlo?=
 =?utf-8?B?Y2ovNmd1SUZrMUZZK3hwVVN4VXVra3QyUVlCczVvYk9xNVlCdXpHWmJuMDUw?=
 =?utf-8?B?bU83K3p3SzdIZ2l1OE8xbjU0NksyekIrK0UwRFhtYW1LVG80dDcyVHFqZWZI?=
 =?utf-8?B?K2l1dys1ZlBNSXlxVlNNTTVOZHBwdFl0MjFCOUVKYWhxdXlHTmc3NzZvQjc3?=
 =?utf-8?B?dTk3QWMrMjk0eTBpUnpFQXc0V0Q2S0dTeTJxaVNHQnhkeTlHakZpWHU2eTZL?=
 =?utf-8?B?ekhTNW9aSEJ0cmdLQVdIcXRKZGtSK3U3VXdreTdRSEordmdKOTNhZkpXN0xm?=
 =?utf-8?B?U2s1OStvNnIwOCtNNlRVNjVvRndMZG1RRkZTMFF6V1pSbURHUzBIcnhiN1N0?=
 =?utf-8?B?L2x4bWZpRE1XYUVLNVdUS1BDN1luOFZsbEZNOW55Nm5DdFgxN1Y2Z3YyM01E?=
 =?utf-8?B?SUE1VGg4VzJtbEFoRnlKR1B0ZDQyT0g5TTFsTDdjaVFBdGxRUngrMlJBd2R4?=
 =?utf-8?B?MVMvVDZzdmo1eSt4N2JsMnl1dExvVVpWdjQ2LzRxV2JwMCtKTDNYalVQckVG?=
 =?utf-8?B?R1VRd2RJbHdxQWV6YjhESmxxclliTEU3dE9UdFIwU0Vid25mbWt2aFo3ZzBh?=
 =?utf-8?B?ZUVNSVZleHVEOVcwdmxseldBODZBVTBDaHBBMzkzTnVvdU9hRy9xMjF5cEtl?=
 =?utf-8?B?byt2MldwTFAxWVFqSlhSQWgxZTNRbzNISVNhcE9xWTM0clNtK3hxZG9xblJz?=
 =?utf-8?B?Q3JidndaOWcxdXAyaExyeGk1bHFxdHhwL3VkQ1hqZGF2bGVIcnhiT1J2b1l5?=
 =?utf-8?B?S2pIUyt6d25JSldqN1luU0RVVU05a3FuWWNvakFjYTg0ZW1vUm5hOTA5NmE0?=
 =?utf-8?B?eXowNTJTdXRhVjBtcU1SQjhCVklkSDBFaDFJcnNQcCs0a012UFE4VWJiODY5?=
 =?utf-8?B?TnhTalUrcmNEK2VPWVZ4cFg4OHc2Zm9kRnBldDdtQ0REM2Vyem90bFNObllW?=
 =?utf-8?B?QnpTeG01K1lFZ1FDczV5aWtiVDEzRmVLbHlrb29UVllNQmUyQ0JvdkszVGtO?=
 =?utf-8?B?TnR0TTdUbDZnR1RabncwbVYrSnRGUVAxeUlmUzdGeVJYOVJOdU1ZQUhnOVdn?=
 =?utf-8?B?VWJPTUo3elZtOW5XaVljakFMRytENk53QVN4WWwyY05UbTFlNk11azNGZTVN?=
 =?utf-8?B?MFUwSHhYYkE0a25aeExBL24ydDdmU2xOV2FlKzAzNzZmUll1MGxtZm1WM0sy?=
 =?utf-8?B?bWhUdkhmKzAwN1I2ZUJLOVVuOFIxOEROVEZKMG5KKy9qMDBRY25RQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783a7418-bd46-48ff-df2d-08df44cb7d77
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 16:54:48.5083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwZc9SGgg+W5mpElwrfhninN0KRiEBokT1Z8eIUSWZ3HO6mWQVdF5AnzNICSLF0BWNsgbHnILR+JZQqaqyJCHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9314
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


On 11/16/2026 2:11 PM, Kent Russell wrote:
> This feature cannot be properly supported, so disable it both on the
> amdgpu side and the amdkfd side.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c        |  7 +++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c         |  5 ++---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c       | 12 ++++++++++++
>  .../amdkfd/kfd_device_queue_manager_v12_1.c    | 18 ++++--------------
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c       |  7 +++++++
>  5 files changed, 32 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 08d3ff61edcc..d0ede277aa85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1151,6 +1151,13 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>  		gmc->noretry = 1;
>  	else
>  		gmc->noretry = (amdgpu_noretry == -1) ? noretry_default : amdgpu_noretry;
> +
> +	/* XNACK cannot be enabled on GFX12.1, so keep noretry=1 */
> +	if (gc_ver == IP_VERSION(12, 1, 0)) {
> +		if (amdgpu_noretry == 0)
> +			dev_warn(adev->dev, "Unable to set noretry = 0 on GFX12.1. Keeping noretry = 1");
> +		gmc->noretry = 1;
> +	}
>  }
>  
>  void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 1f57d0fa2c04..034cc3fd07f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -1518,9 +1518,8 @@ static u32 gfx_v12_1_get_sh_mem_config(struct amdgpu_device *adev)
>  {
>  	u32 sh_mem_config = DEFAULT_SH_MEM_CONFIG;
>  
> -	/* GC 12.1.0 A0 requires RETRY_DISABLE in SH_MEM_CONFIG. */
> -	if (SOC_V1_0_DIE_REV_XCD(adev->rev_id) == 0)
> -		sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
> +	/* XNACK cannot be enabled for GFX12.1 */
> +	sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;

I think we only the above 2 changes. I don't think we need the changes
below.

noretry=1 should handle the conditions below correctly anyways.

Regards,

Mukul

>  	return sh_mem_config;
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 3d2136adb62b..3b62b9e5ecda 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1766,6 +1766,8 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
>  
>  	mutex_lock(&p->mutex);
>  	if (args->xnack_enabled >= 0) {
> +		int i;
> +
>  		if (!list_empty(&p->pqm.queues)) {
>  			pr_debug("Process has user queues running\n");
>  			r = -EBUSY;
> @@ -1780,6 +1782,16 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
>  			goto out_unlock;
>  		}
>  
> +		/* XNACK cannot be enabled for gfx12.1 */
> +		for (i = 0; i < p->n_pdds; i++) {
> +			struct kfd_node *dev = p->pdds[i]->dev;
> +
> +			if (KFD_GC_VERSION(dev) == IP_VERSION(12, 1, 0)) {
> +				r = -EPERM;
> +				goto out_unlock;
> +			}
> +		}
> +
>  		r = svm_range_switch_xnack_reserve_mem(p, args->xnack_enabled);
>  	} else {
>  		args->xnack_enabled = p->xnack_enabled;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
> index 525989371378..63ba13a60b98 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v12_1.c
> @@ -54,7 +54,6 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
>  	struct kfd_process_device *pdd;
>  	struct amdgpu_device *adev = dqm->dev->adev;
>  	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
> -	bool xnack_enabled;
>  
>  	pdd = qpd_to_pdd(qpd);
>  	qpd->vm_cntx_cntl = hub->vm_cntx_cntl;
> @@ -72,19 +71,10 @@ static int update_qpd_v12_1(struct device_queue_manager *dqm,
>  		qpd->sh_mem_ape1_base = 0;
>  	}
>  
> -	xnack_enabled = KFD_SUPPORT_XNACK_PER_PROCESS(dqm->dev) ?
> -			pdd->process->xnack_enabled :
> -			!pdd->dev->kfd->noretry;
> -
> -	if (!xnack_enabled) {
> -		qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
> -		qpd->vm_cntx_cntl &=
> -			~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
> -	} else {
> -		qpd->sh_mem_config &= ~(1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT);
> -		qpd->vm_cntx_cntl |=
> -			(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
> -	}
> +	/* XNACK cannot be enabled for gfx12.1 */
> +	qpd->sh_mem_config |= 1 << SH_MEM_CONFIG__RETRY_DISABLE__SHIFT;
> +	qpd->vm_cntx_cntl &=
> +		~(1 << GCVM_CONTEXT0_CNTL__RETRY_PERMISSION_OR_INVALID_PAGE_FAULT__SHIFT);
>  
>  	qpd->sh_mem_bases = compute_sh_mem_bases_64bit(pdd);
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 546721b4d59a..059e22cd7f1a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1670,6 +1670,13 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
>  		    KFD_GC_VERSION(dev) < IP_VERSION(12, 1, 0))
>  			return false;
>  
> +		/* XNACK cannot be enabled on GFX12.1 . While dev->kfd->noretry
> +		 * should propagate this requirement, adding it explicitly here
> +		 * will help cover any possible future reworks
> +		 */
> +		if (KFD_GC_VERSION(dev) == IP_VERSION(12, 1, 0))
> +			return false;
> +
>  		if (dev->kfd->noretry)
>  			return false;
>  	}
