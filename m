Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22FF606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ysnIoE3O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F61210F245;
	Tue, 20 Oct 2026 07:06:42 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013007.outbound.protection.outlook.com
 [40.93.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EEAD10F245
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 07:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChLJnsSXDPwtgg+dF3jNFVBWilftFAVusPExuLGnQDXQ5XTzVzAtTwzRmcQz8xhLrTroOkQv+Si1umrWQh4dXLG1knoS+nq3CTS6EWhSeCqsERH4Bg26NXVXI0YDt3rEvVmHoVoRhPAJ3cPT0QfoY1twhvaE9Q9v4kUuQpJdo1NnDczUmTZt6ioGwjntdh4EdSa4n1Ro9WPQMvf+SXSFMR/4w23Dx4hO1bJKdswKXxH01GsYgaPlzdvF1h2t7P4Il1waUhymR/LUMJhK65qNsR4yA0pPqLpiAXuyBMDe9Nu/4kxdj69N2/VsVsoMhRJ3DIMWW2SCHhtu3452seSvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrY4Bz+uqM2j+QPO8iBjyhc0NCnniiSlM1vebmnBUSs=;
 b=ltSl1mlIuIreOQRlEIgDM2JkQBwqSQkze9vJ548vJ2K8QC5UDIo2MbI/5Y+AJg8YMoykgPZA24dWfZk8G7qm+gQgPZ8fJWrSpYQCnrS8oa+RhFGilkqJQtjqXfj/Ca0wN3qV4W20SV1ph30X30S7pxeTDVbdP39DTYFWXNjocOOIfxAKjty2pgPJ4xH3di/n4HsdgVfpRB6MbBw9Jnh/nRDzKpRw8zSeLoupR84sOhTTPVGjUj6RxFeWvqCMi2Eq3Ol+7kBAhwUDihWxOLv2OJB1PusWsORvtM///wN+MGa7DFVsuu0oZDNq4L4a1gfHdbWXU42uQLlXx6Q4KQuccA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrY4Bz+uqM2j+QPO8iBjyhc0NCnniiSlM1vebmnBUSs=;
 b=ysnIoE3OgRZKgz2gb/LtFXOZm2aIEr8wWfNE5qo16QLak9/iBC9LflfdJZtHVOWM3WGCJROYHkF1THkhDDwdQUEQ8IU0GUG/I4nDV1387lAGjCwY4quBxnY75lRm/8ZSZv63TkghM2jnazDqFZS1wFkRpR4ox/4jfozrdeHXfh4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CHXPR12MB999219.namprd12.prod.outlook.com (2603:10b6:610:2fd::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 07:06:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 07:06:33 +0000
Message-ID: <86079a2d-afd7-4b6b-ae5d-870713a92453@amd.com>
Date: Tue, 20 Oct 2026 09:06:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] drm/amdgpu: drop the unused firmware loading mutex
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Vitaly.Prosyak@amd.com
References: <20261019064838.2577746-1-Prike.Liang@amd.com>
 <20261019064838.2577746-4-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261019064838.2577746-4-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CHXPR12MB999219:EE_
X-MS-Office365-Filtering-Correlation-Id: 398a3195-c29a-4010-5611-08df2e78ac63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|261009223027099003|10067099003|56012099006|6133799003|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 0VEYoPXyHdUUa0WDvjZ7BAVEr7zPZbwhIbv3zLoEMIj4i0T7CuBTyi6bQ7r9+8zQkgdr6BxkX5fMRFpliu8z2SNvdWjUQbPVd3Em8NaJyBlgDy3fpR1wrT9xtp61kyFr0e9B4cCnUk7rPQaGreJSpZA+QFo7zz2p0L4DFGibARDTC5AxyHHmmnvYm7sh8a7x84b43tMspsURNnLa9IXGvymvMc4rCGnH8BMZ+CrQAlHvSlgX/j3V6OHhevgL++AvCwKkc8ItBdBo1Lfzg5JuCJzWUEOV48NoPW3hTcvFENVSui3FspSsgU6WlzAp1km+5k6U8EM+SHdC1zMzuBPb7QjT4z4i6CJgX5q7L3qCbPDVF//wki2wvBVuMraAwqklgRr5Xcaq4eJObQyxbuQFlX1Ou99mHmVQW5CIp0ZE1tE+zF4UY8LciCVI7i0wdDaN1jpb73FtH3pzpKmA8hbMP+fIsqGzPu8TwUNcv1KpbSshxiO92DacF4db6suhjbjuqJYYx/F+Tx7SBsvyGeltnA5ttCsLypwPNNRiJQPWVXHVFzVMaXUMj0P5uyfDvx+lU9dNFzW65zwNvR93YPlRxkzlL2cVrJOpgT6cksmq9icBqhxrXLVjZy2d/phimGIVdx6Gp/j4D0zahFS+x0tj2Q5psaQEcRIL2VLKWtjotrA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmtVNVhLdFloQ0tqNEFFYjArdmlxVUlHS3ptY3pVY3BYYmdMTGUyY3lKK1BK?=
 =?utf-8?B?dEVUZ3BxZWs4RzFWdFJIWkZ6SjZ1Y2kvbnZLbkxPQ1FJUWVDckt0RnZBcFdH?=
 =?utf-8?B?dXlCSlRkcTNxbzM4akV3d1VGM1dhbGs5aExMZ3FEUmU1dVdpejllS0lKN2N3?=
 =?utf-8?B?eFpwUjVTUnVKSURMNTBBbnlocm12V0VkS2doVUNPUEVmVjI0MmpGNUIweS9o?=
 =?utf-8?B?S3lmbE9QZ1dZbllITHV6VUthSEd0Y1AzdkFPRjM2M0Vaa2xXOTJPTGJMOGpY?=
 =?utf-8?B?LyszNG15WmIzQmdzYmpURU0yUDBqRGJjYTBIak9zeS9Mc0svMjdrcTRtL0M0?=
 =?utf-8?B?QUtZNi8zbk40TkJLU3R2Z2taUUJSZWlZQjdXVngvaC9Vd2RKWE05QjIxaXJu?=
 =?utf-8?B?TFBnZTEwR2lRbUdZWHM4YlA2c2VHTm94Rmx6ZGdTSWFzWlFBRFdxOHRHekZs?=
 =?utf-8?B?M21xYk1reFl6ekFwRUVkSEJybmJ0VExwVjIvdmZ1bXpTOUdmZHRIazhPdy83?=
 =?utf-8?B?NWtGZTRpT0pOZ292UmFqV0NBVlpnRk1zcE43NGFtZXhISWJaNmJpYWdDcDJT?=
 =?utf-8?B?UklHTDQyamFXOFg2SSsrcUQ4SkM4RGN0UHV3cmJiOWlFcWNIbXBnVGk4L1NL?=
 =?utf-8?B?Nlhndm5VQWk4UzVpZkxzWU05MWIxTDF0RlZpTSsrZUhKUklrOWZVL3V5REpy?=
 =?utf-8?B?cG9SaWVrRmJGV1pTRGFEV3orcXJHZGhZcE1SZmpGQXlVY3NTcFNOSkwrU2xN?=
 =?utf-8?B?K2pXakdCazFiOWU5WDY1cHQyMFpWVTNQYm11R1BNYVF1aHcvZDFXOVdZZkZW?=
 =?utf-8?B?ck1sUE9Uam9uek1yV1dSTHEvb09tbldQVC9uMldzTUJWcVV0c29objZjcDRr?=
 =?utf-8?B?U1pZVXhSRVZzbHdIUzFXS25teDgvVjZYTUFQcmlNUjBWSVBibDV4dWxyQ3oz?=
 =?utf-8?B?TktNMkRTQjdkeXNKcFF5N2h5VHMzSzdTTWVSa2ZnTGdKZ1ppVEIvVXUvc3k5?=
 =?utf-8?B?SFBwdmt1WUNia1VBcHlBMVphUGZrd3h3M0p0cmp6SXlVTE1MRUJ3TmJvZ245?=
 =?utf-8?B?NHVwdG1KZE5WbXBkVGkyT2NyV3pJa0toR1lML2ROVmExdWxuY3Rqd1V2dE9Q?=
 =?utf-8?B?b3M3ek9UTUM4WXgwZ0pKNXlZdHBOYWFrekhiZHhpbEgxbHBlNWk5NTZjNnda?=
 =?utf-8?B?dXdxZ3FUVUxBUVN5Zm1XaC92UEVSZjY5TVNzeURaNENLRVlxMHdiQ0JvaGox?=
 =?utf-8?B?N3gxLzM1RnE0emVWQjBiTUlwYXo1OENUU1VHbTI3UXJQak5xdDN3Rk9tVWpS?=
 =?utf-8?B?T1dDcHYvcDMxK2R4NDRRODBMTmdPSlFPNWhVWEhmN3FMSEVoNHU0MS81VjJI?=
 =?utf-8?B?VVpEOUpKaWR6WDJrOWxjcVhYdnFSbEJBTmhPVHpJSktobWJYRlpWMThEN2hF?=
 =?utf-8?B?NHlMRkZudGV1Z0RXaEF3SWhLdG1aMDJ1cDc2RVJRTlVOVFBhaS9aTHRzSmZk?=
 =?utf-8?B?bS9sc0lSbTJZeWE4NWxpSkFiM041ZXNPZTBlLzJlVkFkNDlQbk51VWltdklt?=
 =?utf-8?B?UXRBU204UDU5VjVvMnVqeGdhMGs5WksyNEJublFONjYzUFppV1pXblBpTEU0?=
 =?utf-8?B?UTVVU0VNV2dFclc1enkwbjRkUkkvU0t2RExuQ0N1OFhBODBvbERNYlAwYVhx?=
 =?utf-8?B?WGJZejBodEh6VjQyZDdTRHlRYXpWSVRheUw0UzZOMGV4TmZsc29GQ0pYMDdu?=
 =?utf-8?B?ZHA3WmNqczd2cDdnTGQ2citCcEFlbTQ5TWpqMlRCV2hEbW9rODNsK1VHaVhW?=
 =?utf-8?B?dExreFB0WTV4SnRvRGZxTGpQVkIranZ6YzlLQ3hFUXNUMWtGLzI3UjJEY3Nk?=
 =?utf-8?B?VzJxK0xjN2M1Zk8zNjlJMVN4VXJpTC9kZTRreFA4UEl3TTFSak1VTXRRUk1i?=
 =?utf-8?B?ZE1lV01CS2c3SnZvWTIzSXFjdE1uSEFFWWlQbm1ETW1IdU5KN3FrTFdIcmNS?=
 =?utf-8?B?SXhVUlV4UGRPK1BsdmpUN3FqemZESDEwZXY3Mm51Y2NML2lyZ3J2b240M0w3?=
 =?utf-8?B?R1dYMTNoaXlWeTlRemxlUlF6dGVhaHZHUElDSkJOc1lmRW5ORnV1Vm5BQVJm?=
 =?utf-8?B?UFpTUlBEbjlzdmU5RDBreC9UUnJlQlZYZmlQd094VnVXZlpiWUk3TDlQeitC?=
 =?utf-8?B?bWNNK1ZvNzFBSGJQTlM4clpFdnRvMDZ2NHdNUVl4NGVwMkxndGZBQ3dLYXd0?=
 =?utf-8?B?YUFOSWxiWVBVUC9hM0RQRWprNk1Ta3BRSjhVK2hpdW1PWi9TNlVZMXo4ZTVa?=
 =?utf-8?Q?KK3KZHtMBI9l45K8RR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398a3195-c29a-4010-5611-08df2e78ac63
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 07:06:33.4504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3C5LXOvCWfsuTAhYZWwRXGl/I0omTOdMVfkRPNOXOht0vA8ZqUExO8Z/cxgGVev
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999219
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

On 10/19/26 08:48, Prike Liang wrote:
> adev->firmware.mutex was added to serialize amdgpu_ucode_init_bo()
> between the PSP and powerplay firmware loaders. Powerplay no longer loads
> firmware through it, so the mutex no longer protects anything: its only
> users are psp_hw_init() and psp_resume(), which the IP init, resume and
> reset sequences already serialize.
> 
> psp_hw_init() still allocates and reserves the PSP ring, TMR and TA
> buffers with it held, and GPU recovery takes the same mutex in
> psp_resume() while holding reset_domain->sem, so lockdep reports:
> 
>   &adev->firmware.mutex --> &userq_mgr->userq_mutex --> &reset_domain->sem
> 
> Remove the mutex instead of keeping a lock that recovery shares with an
> allocating path.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 9 ---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h  | 1 -
>  3 files changed, 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 20f02dd14c41..71aa13a9883b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3817,7 +3817,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	/* mutex initialization are all done here so we
>  	 * can recall function without having locking issues
>  	 */
> -	mutex_init(&adev->firmware.mutex);
>  	mutex_init(&adev->pm.mutex);
>  	mutex_init(&adev->gfx.gpu_clock_mutex);
>  	mutex_init(&adev->srbm_mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 36bc4b431dd5..01dca6858833 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -4157,8 +4157,6 @@ static int psp_hw_init(struct amdgpu_ip_block *ip_block)
>  	int ret;
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	mutex_lock(&adev->firmware.mutex);
> -
>  	ret = amdgpu_ucode_init_bo(adev);
>  	if (ret)
>  		goto failed;
> @@ -4169,12 +4167,10 @@ static int psp_hw_init(struct amdgpu_ip_block *ip_block)
>  		goto failed;
>  	}
>  
> -	mutex_unlock(&adev->firmware.mutex);
>  	return 0;
>  
>  failed:
>  	adev->firmware.load_type = AMDGPU_FW_LOAD_DIRECT;
> -	mutex_unlock(&adev->firmware.mutex);
>  	return -EINVAL;
>  }
>  
> @@ -4282,8 +4278,6 @@ static int psp_resume(struct amdgpu_ip_block *ip_block)
>  		}
>  	}
>  
> -	mutex_lock(&adev->firmware.mutex);
> -
>  	ret = amdgpu_ucode_init_bo(adev);
>  	if (ret)
>  		goto failed;
> @@ -4345,13 +4339,10 @@ static int psp_resume(struct amdgpu_ip_block *ip_block)
>  				"SECUREDISPLAY: Failed to initialize SECUREDISPLAY\n");
>  	}
>  
> -	mutex_unlock(&adev->firmware.mutex);
> -
>  	return 0;
>  
>  failed:
>  	dev_err(adev->dev, "PSP resume failed\n");
> -	mutex_unlock(&adev->firmware.mutex);
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> index 35277b240f25..7c809692807f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -612,7 +612,6 @@ struct amdgpu_firmware {
>  	/* firmwares are loaded by psp instead of smu from vega10 */
>  	const struct amdgpu_psp_funcs *funcs;
>  	struct amdgpu_bo *rbuf;
> -	struct mutex mutex;
>  
>  	/* gpu info firmware data pointer */
>  	const struct firmware *gpu_info_fw;

