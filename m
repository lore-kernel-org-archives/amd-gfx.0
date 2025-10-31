Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B96CCF9FF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 09:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED7F710EAE3;
	Fri, 31 Oct 2025 09:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EctV9onW";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C14D10EAE3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 09:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCE2+q3rlpbcwzn422V1sNjFTUcyiL/CjfR7yNXcyLWAJY1ORlknCiR4kfDewuGFWgVJslZlvfPw3DuA+TMya4C5EhKXGWv4JW/ZzYDn6hlgaRKYLn9h51tLGgLs1N6BPmiwcFGvVQRsbVYqjj8St+5k5gkHXTtjDDOUf6SCYqQe62rs27dCKJLzQc+1p2nCSzRyoLgKkFfRgRpLkg8wXq06ySRf4ON8HUtuZAPa+oTqZ6phAC7gPI6Cf+/7gbkFoHbZraxaB52mrMFV+SNrWLeWgTvz/2veTxFDSKMvjdPwhpsws1f8IJHUfeIadawb74Ay+J19gz9NZeEijIXe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENNugD4tXXoueRu9/CZ965jv+gWfrB8qDc7QN5sfagU=;
 b=RAVgEnZUtCdlgMFQjdhf8/Kb0ytBqWNr6Y8iZOKmWQKhLhH/U5o5HWiG1NbW/2ej8uw2f9ksy4ONUeB3I+fZP9pRgPCL+AFxXp+yi9L2gtXU4v6WrMLmXQFnUBXzPuefdtlwzkCIRaxtJET0v0C0h+7FiHRZhcaEFvkAMajZyJcAAlKoYrh+ZJ7dDLvoaJbBSpcAs9zD8tDm+lsnkGf+eI8CKiYTU96gDTIksAYRlEPIv7Qo7RJUpKIGSGHJtbyofQStVSigjQCVOkLiOV68yiSYW/Mr+QvMxypMpo7hkHC/XEKCisUUti5udH6Tz8chPVRuhvS5YJhzOd5+HMhQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENNugD4tXXoueRu9/CZ965jv+gWfrB8qDc7QN5sfagU=;
 b=EctV9onWXJQpClMCfprCNmPyxRqgc+BOv+uJM8E6HwTIZRnptYQQqSFiUOiAat1JOJhHQjp5pGLxT6w2abLreRNGLaVejdMh4YEDNRz9MnHPtdE2RLhfCDyxfR8gRFsxKyHsKMxl9ClzEJ1ftZf0OmX9nLhRW4GDJkWEkjmJP3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 09:38:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 09:38:15 +0000
Message-ID: <0a3f8872-b4e1-4046-a71f-f74d757adac9@amd.com>
Date: Fri, 31 Oct 2025 10:38:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdgpu: validate the bo from done list for NULL
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251031093613.3758322-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251031093613.3758322-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4bc328-3250-47ca-5c31-08de18613781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWQwU0s2MzZ6UzlBUU51NGhKdDFNTEF0V1FSUXk0aUovRWJ6NlhOcXpaLzA3?=
 =?utf-8?B?b3FWblZVTG5YNlk1OXZYdndVT2dnRFB3VEMzN0RvTFRhQWQ3UzBsRk1Ic2Vi?=
 =?utf-8?B?SUpQd3Y0QklyUm56M2lYbjNIMXVBK0VOdHIvWHhJRkswNWwvS2FsU2J2Z2Ey?=
 =?utf-8?B?d2pQYmk3ZlJQZ3psRlpyZGEvaU1nNUFOVWtHQnhOSFd0RVlXVHA4U1NsaENq?=
 =?utf-8?B?ckhxK1Y4MElDRXBOcThKd2N2b2w1M3J4MUVobjJuWERKZDcrS21yWVVvcGFT?=
 =?utf-8?B?TUZmN3RBRzVhcnRqQm9RZVRyZnhGSFFkZG5IWGROV015UThQdTlNd1FYN3lM?=
 =?utf-8?B?Q1BXZDBxMTBhVElhcHkxZWFCRUxpNjE4Z2QwczIrRW9uaVlxWGZ0YW1XQVBL?=
 =?utf-8?B?NVpZZVNBVG9MTjExeDRoWmVuZ1hUb3ZuZWpIa0p1dlhzN0I2ZmwwSkhreUZI?=
 =?utf-8?B?Ymk2OGo3SFBvOEZGWFNCbUxvazd3d21QZGQvVzYrVHN4U24xN1ZYTGtiL2NL?=
 =?utf-8?B?U09NZ2R4cTBGSTdwZzJEdTRGa0s5K09hbmo5WFVPdEJoZVM2UDZYdm16Tk10?=
 =?utf-8?B?eWdxQzZQZCthYkEwdVJaMG9NNEZrdll2UHRzU21oODlaL0RCMk1FQXVIVHdl?=
 =?utf-8?B?V0FoZEhhVjk4UkdYTW9PLy9tVHFOSmwrd0E3SDIzTVEyYkdrLys5b2JUNlVo?=
 =?utf-8?B?VmpqcGxuQ3Y5Zjk2ZHA4ZWlETUZNLzgvNU5nOXgySnJvVHArZVBPRDFzd0N2?=
 =?utf-8?B?em8yaVdjaVc4Z2pLR3pPVm5lN0NtUVk1UnQvVU9YN1JSUHZNaTdkVUF0cjBH?=
 =?utf-8?B?WFkxZFNYSmpDUktuRmhjcENMekRBWHJXbm9lMGdPdW5SYkNFd2hCWVVmblhI?=
 =?utf-8?B?ZzVWUEc5WlZUOEpxYk1XR3ZpUy8yVHZhQ0dZVVZtRWtnWkVrZUNad1prYmVr?=
 =?utf-8?B?UW9JZXpNR3hNdVdRWTZWUWpKTXhzcyt6aE1XZXlvTHQrNmhiMDcrTThGZ2NJ?=
 =?utf-8?B?bC81RktJL0RnTmFYWEtmdTZEZ0hhZlA3YzBnbXZnSE5QVUk3V2lpYnJBaWw5?=
 =?utf-8?B?K1drdE11UkhvOTVxMjFoSmJzM3JBd1VFSmZ3Uk12bWxTdzBCWFRhaER5bHZY?=
 =?utf-8?B?SlBPZUF5MG9PWjdGS2NmeXdhLzgwc29XbVRrMGZTd3crcDg1MXIrbGREWXhi?=
 =?utf-8?B?ampKeUNPYVY2alBFcHJjUldVTGFKYXZKb3haWllqOHJ2cWlwK0JobzVpa1dq?=
 =?utf-8?B?REhLcWl0NVQrNmZZNWIxVFgvbUx3dlIzNjM4R3lYVjlOdTBDZXdxTU11aDBF?=
 =?utf-8?B?T0JYR1pPYVo2aWd2THFZS014VUtpd2s0dTZ1N1RiSVZ2OGlicnVzcEV5WVQw?=
 =?utf-8?B?WWo1S2xMSitBOUtobHdLVGR6N3NwaFVVRmdrdFh6TnhsczQxd3UxbzJ6bmh0?=
 =?utf-8?B?eExDeGpRb05PeG01QXJHZVBQaTlMN0hSM2wxSEhqMFNleWluVXNvWXI3bC9T?=
 =?utf-8?B?WlZ0a1FkTm80cTFkN3dyOC9UNU11VEx0MVNRTGJjQ0dwSHRuaUF6b2ZWOUpk?=
 =?utf-8?B?a3dQM0YwaEpsUUIvd3g2T2tHNnJGbkpONXorZGNnc3JaeGVwUE0rQytMQWdK?=
 =?utf-8?B?MStZcjdIWlZLd29QUld5U0RsUDhHR3RvRStGQmxZdjRNVm1BZGlDbDhua2FC?=
 =?utf-8?B?Q0Rvc2hzWnBlTjhVOTFrL09sSmZGcXhjT2c1U1prT0dOUTJVQm1vaWw4M1dm?=
 =?utf-8?B?R1JQZE10VWlWeWlqVVFGaU9ET2RwVW9tR0tKSWt1eU0raFNWY3grMDJobkF1?=
 =?utf-8?B?SW85R1VuYjVkWkQ5c1ZUcWJ6SkNSamVjV3U2SVVBZlQ0Z2tUMXVUZGl3VDFY?=
 =?utf-8?B?bHFxQTRiQk1JMGxUNE5TWHZtRFZLbVgzS0JHZzRXRlFnMlg1WEFLVGhWbVRl?=
 =?utf-8?Q?LlDo5ahCJtekwQykFjH+ok/lkN0vrV7j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDNjZkwxb3VpcjB0OHZ2dDFoa1BGMWp6cjExLzZjT25zbGpkWmdQR3BnNHRj?=
 =?utf-8?B?aERYQnVBQUIwa1hXK3gxT0dKYjRycUl4QTllQnRNUHQvQjZnSmcwWHlWTDY3?=
 =?utf-8?B?Ykt0M1h6WEp1QWE4R2xPaEVidFRuek50UHJYRkUrbFRXV01MWWNTdXpFMXdL?=
 =?utf-8?B?YjhSb2VucUZoSytteUtubnZYdXYrdzU2dGw1TFB5b1d5cXJpRTZnNHFwS2RB?=
 =?utf-8?B?eHlsWVloR1pjMUFXWUtFYnhPM2xXbjlyaWczdGlOVmlVL1dSVVRiMU1hQSsz?=
 =?utf-8?B?OTdXU3F2SnpTWk1vNi9qZC9UMThERUttUEV6ZVhnc3cyaDhqWnZFMjNrb2x4?=
 =?utf-8?B?TXRJcXY0bGtoRWdLYlB2K1VIQkpZcUE4S0Y2VEtnZDRKT1d1OGNaQlhaVlFj?=
 =?utf-8?B?aEp4cEFjRk1DYTRSWXl2bzgzVHdIUHBGV3BsK2k4Rk1QSXVJUUI4bkZ0ZXZE?=
 =?utf-8?B?Q0t3TTdaSkIyaTlFdlBNN09ZVWFkOWdZTWZXenN2Nlc2TWtRU3JaWWlnRlkw?=
 =?utf-8?B?SmtlWWh1dERFZ1Z6R0tiZUlCTE0wZHNrZkduRGtxUDRvWG5UbFgvNngySlV1?=
 =?utf-8?B?eUdOeHJlZXRURnFacjl6NllVYTJwaGIvcWpEdkFCUitZQjh1QUh1a3NpK3lY?=
 =?utf-8?B?bVk0SnNxdW9Ua2dsZFY5cFEvd3ExcE9yZjk5ZzBSWUxzTVNFR2RDR0pDMDVq?=
 =?utf-8?B?aFp6T3ZhZE5tSXJJcXdHam1MVGx6REdoSjZ5L2RLc2FKRUZFZ0ZRWFhMWUNx?=
 =?utf-8?B?a3hDS3dVRUJvSy9TemhWamc2UVV5ZTUvNldZb2JSSVRHYW5wYmFQMENpdWc0?=
 =?utf-8?B?dHk5QkVON0d6RkFGR1pkMDdXM1l5VkFCNnJKY1VxOHA4YzdCNWFaLzZNRTBw?=
 =?utf-8?B?QS9hMXltTFJLY1dYcVBZa0lPVkg5RlRwVFpsOGZVQkJuemE5QXhUZ2gyNGJr?=
 =?utf-8?B?ZW9DWE00REtIODB2QTcrSkIxSU9aUHVQQ0Q0S09VZi9ram5LT1FXUHVLUlFx?=
 =?utf-8?B?ZndkTHlSZHhLQ292Y2NkME5Uaml1SVZGcGNqOTFQTDMxWm1uSWxHY1FBdzdz?=
 =?utf-8?B?Zm5IVmxQbUwyZWphK3lMb0lSRis4Z3lEeTUzM3M3ZGF5OWN4M3FRMVRoMmFp?=
 =?utf-8?B?VzV3V3YweTJ1eUNYd3BzTGdNcGg5NkJOeDdqeGVGWHQxNFh1a3ZBVlJ6azAv?=
 =?utf-8?B?SnpxZGZ0WmJ6ZTNDRzByeEw4aHBZZjRVWnNQNUk3SUtITy8wdXR2M0hWZ1Ir?=
 =?utf-8?B?ZDAwSnllUEhOV0RyZ0pFaWpwMU9YbExHa2Jpc21KY00zQnhodThJNU1lL0Qx?=
 =?utf-8?B?S2FmdjdBL3oycFVpRVRFd0RvM0g3aWVRZTNQRzdhRWhrN2VqK3ZlN1BrU0xS?=
 =?utf-8?B?ZklvYnFKT2RTc2xwT2Vydlp4bnhjcVdBVFBqRXk5SUx2TWtpWFpsOTVQOVV3?=
 =?utf-8?B?THB1RzBBVWtIY2NneVNnU2RXdTJPVXlMZHRzZkdiT0EyamlOVC9oTDh6eHhs?=
 =?utf-8?B?OHFzQ1NCTjJ0dU1WYTBtMVN1N1dDcHpGelorQm1MbTBxV2x2T2hOR2hieWFR?=
 =?utf-8?B?LytzR0dQRHdjT0FaRndkckdBa2pHbEMzd3ZtL3VkeThHTlZueGhZUE90bm9F?=
 =?utf-8?B?b3Qzc2FCbGM1NTFKRWNnSkI0YlM3L0x0R1N3UHFCb0JXSUp5dkdNOXY2Qkto?=
 =?utf-8?B?anAyMkxVR0xVc2E4ekxOc1BucTJnTjR3c01ZZ3poaVhQUEpLMnFlWEFEd1RE?=
 =?utf-8?B?SWRucnE2U3NraUNLak1WeklMejNvSlVXaDlubWE1RytsNjF6dU9zbUo3aEJN?=
 =?utf-8?B?ZG51VHhJeTJKU3MzZk9uVDZmZFl3ZVZLbGF4ZFdZMXRPaXNqK1Q1c0NaR1hl?=
 =?utf-8?B?REZCbGJqdEdzQ3VIQ3dFaG81RmhpeWFseGdvZjliU1YrTkpCTmdFczhRMWlz?=
 =?utf-8?B?c2JlRlZ2WVRpT0JubXM3YkREbE5KeHBBNitqOFpPNjhmSm5CeVZnQS9DdWgy?=
 =?utf-8?B?R3pOcFZxUFV3cFV1RWNxc3ZQakJ1NnkzWThqVmloSWF0Q0tXeVZwbU50dmk5?=
 =?utf-8?B?Sk1laWg0QmlFbmsrU3dYNm1yS3J5R2FZZ0NXYWthWXRucVNRY1dRT0NpbUEr?=
 =?utf-8?Q?xkts7U7Ht5fvbe7H51HRsfM9D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4bc328-3250-47ca-5c31-08de18613781
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 09:38:15.7909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FYz/B9d6xA4KY3DEwD9M/ayjw1adv9udiB40pYZ/AFZjckcgw1DRjiSlsbDw5n+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
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



On 10/31/25 10:36, Sunil Khatri wrote:
> Make sure the bo is valid before using it.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index cc2f96ed7004..a7ba9994d250 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -942,6 +942,8 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>  	/* Validate User Ptr BOs */
>  	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
>  		bo = bo_va->base.bo;
> +		if (!bo)
> +			continue;
>  
>  		if (!amdgpu_ttm_tt_is_userptr(bo->tbo.ttm))
>  			continue;

