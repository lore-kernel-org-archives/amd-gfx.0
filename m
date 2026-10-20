Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C353606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5TB+Q7pI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 372EB10F288;
	Tue, 20 Oct 2026 07:10:26 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3872310F28B
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 07:10:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMHkYo2NpTWtbKjbwQrWggxymfFyLObXJR1LnvkTJsryi9AicbXYcfDiIlyx06qPhsmD3DRPOLa4QDk8i3eGzc0TIiURb1amNpR0hM8uAEi/+VIYKBW0fAP+yA8Iuseyietanotc0RL+jpkesSRKQEbbf7nFapjlqfw76YyV+FhO57gL+cdALc1K6/cbtnG09oUQLPH7OPmGvSKhz9PbJzrEYd9oBWubGwczqQeGfcn3f+dH3ImJJwma+XGgHwjz7PMe//Sc9vvN9JXgPEf/XPbGOD0XrqJDbFx7wfhjV7+OXynYeLoJ4OI035mfYvNCTNEsmi/lRHDqVAsx/gvObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8C1JoLZq3YlCvYNsBbvt7LhGgC9jURjl447gTQjLGBA=;
 b=T0b+lI4BDvDbQc+yB56ftQo3iUesZRGQQ2ljULfWGxsOOrfNPSl5A4g0iCKJPxbODFMGxCVI/SxzPkpAnpSlmIrzz8zzmQ7HnePkqtAPl5HfsFl6IfWY/Td45zdM6EZleMpwOMiz23mpV2vI+2iEow9/p9UirkWa+9ytW2/dEGc7HPXWZkj5oyuGo+tYANdx4XdxGLLXVLgzwjvqgtnuXAn3Dy1u4A63IMw7ETpjkPDblUdf7ox1670+u/RlqpoNo1cuIwbUxW95jT4GlFbgeMMsN/JVeDaVtn38vqtvBvBhqlKcFokQYmLzjExeWGbvZVBg07aVBCgtDW3h7mz1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C1JoLZq3YlCvYNsBbvt7LhGgC9jURjl447gTQjLGBA=;
 b=5TB+Q7pIZLIyPdIg564PM1yufCI44PMS7phIZ/TjNQAMEAh+/+h0bKSPXviik3z+60IifRZfv+zPpdpEP+V9IqJdUdgx7Qe/jcNQNO6unLJg1KR/HZVsgSbDMkZ7Gf3rvFavpcsxU7hxKQk+Vp+iZDFtrv74LVDMUJyzDeIM0BU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 07:10:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 07:10:14 +0000
Message-ID: <c5725668-98fa-4a8e-a120-0ceb8a8f5fb0@amd.com>
Date: Tue, 20 Oct 2026 09:10:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] drm/amdgpu: remove suspend/resume DRM clients
 during GPU recovery
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Vitaly.Prosyak@amd.com
References: <20261019064838.2577746-1-Prike.Liang@amd.com>
 <20261019064838.2577746-6-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261019064838.2577746-6-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 553b3899-b708-4798-882f-08df2e793032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: x5zT97e0aMFTjoYevlv4i8tPhUKrH2tBMHsmxbjiU3fs5O4R4CT/REw3lyp+mKctmlWMsvhikessZ8/QJ7frbMNVzDk/M35pjWms4+S13ZUjwsT/FusUAO4wqviQBNRtC4sVmgsrzJ2LS10HMttw0P69YnOmCEyoVlhqpGFbIPQmd6mXqsy+Y+SBJVZRLWTjvXL15ZtLZiaP63WubA3KK9iPu7AkTuExL8HG+8FxQMGm9ddHTzSS0UYXtFMF0+TBgMdvxq4+cylhe/+aUSBjjtT3O8oHeYJBB2FjZUcvRN3m3iErDoAmEfCJ0Q//S/TLuwTMbb9Oc1wan99WM1C1bArRSsVw6Z2x6W/J6CoY8cZiALHZnnDguUNzY6dxYGgaIPQm0oFGebMv1SEi1iyxcNzPV/tWWtpqeX/m+cLD/tfJsDCF8TnwJap4/vPezUKCsbun/6WKQxjsP9YSU23LHe+mvXvNtlVWwkshakhuIjJOu7WaTVm4y7jTjKC6p1ZivAhFqSb05cvmntpgS/W5qMWHBsxBOzpItRJ25uS3Ewv/rxu2WJ6dgak5hI3RDfiJ8ZxoHCtlM4v00mj+/OAiM4c0uOpVM4cCUmwKeXR8Q8to/d9bSjsh6KdcQhrNPI3xl7lI8SdJX0b3SVorkvN46fLSbzeR+4kJ7vvVhMszKtg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wjl5RjNGUXVaRWUzdjhRTVp5enVjb0E0MFVXSEt6Wjg0dUR3ckxtUUQvUDZN?=
 =?utf-8?B?a0pRNzQvUDR3Z1czcDNpNnJhV0RHS2FIRVliMjlwYTA1VHhialIyZDFONlV0?=
 =?utf-8?B?M3crVGZSeW4vM1pvakt6VVgrVC83eDZvUzZZUnhUS0pzRE9nZWVVUVFSYVZC?=
 =?utf-8?B?Y01ld0tmSkxtT2R5TmgrOGVKdzk1Rmc4KzFMVmVETFE4cnRJK1F2ekNqUmVK?=
 =?utf-8?B?eldFYzJ5bU9wT3lTMHdTN01XYXhoQzdmcGtEaFFHMTFpdEJYUmd5VEpPbDdy?=
 =?utf-8?B?ZS91cTRLeGtiYnRwYW1JSkRlRklkRWcxUy94MUxqamxRL2V5RTBiYjJMbFIw?=
 =?utf-8?B?eGtpUEYxaCtXc0o5Y3NUalY0amlldlM1aVpDaW02d2ZXWDA2NnF4aGM2bnJG?=
 =?utf-8?B?MWRoSHhFVWVZbGxqc3QzYmpZb1ZkVG9RTFRDVHl4UDdTeDFuKzVzdCsxYThU?=
 =?utf-8?B?Y0dmc0paVmltemZ6ZmRLY2t0Q2s3RjdxYXhCWGJaMXZUaTNtS2NOaTVuWFFL?=
 =?utf-8?B?a0RzNVZFMWV6NVY5UlgyNi9TQWtXTVh5S3FtU0o1UUdabnRBcllDcXF4cDJT?=
 =?utf-8?B?cm9Vb3d6NDdmWUdJMHFlT3M5aWxBb3hpM25LMnNCVEQ0SThndG5NZXVSa3dO?=
 =?utf-8?B?Vjc0Q0x3bGhEclRlNXh2N1RzM0JZUzI3dEFzSUc5d3ZCeFYvS0N5YXlSTm1G?=
 =?utf-8?B?eWhBWkRNaVgwbStkc1dBM2k3Vm8wYkVWTU1qTExXOSs5MDdML1ZZNWtFT1lh?=
 =?utf-8?B?U1ZMMDFLUFpTV0FyU29STTVad21pN05TaUFwR1pzM3RvU2s4Q3dZQndQSStU?=
 =?utf-8?B?M2FqbEJZSU9LWW5INStyNmhhMGdsYk1weE5UamdEWTNMVEhTV3VQR1phSG5m?=
 =?utf-8?B?UGt4bHJ5anZjQjA4MFFXY21QT2gyRDZWeEwrc3RqUXVqckExTk0wdjlTK2Nr?=
 =?utf-8?B?NjhGM2Y1VHJrU25YMTdpOCt5MXdKM0lWTzc5clBCN3A4TjhKaDVjUjN1VEhu?=
 =?utf-8?B?OHBVN3BWOWMxRnNaUHZFQVRjQ1JSV2VWTGgyWXlWa2FxajZqdDl4ZCtvdEFm?=
 =?utf-8?B?U05PQlNIYnJ3Vkp1RHJnNFloRWdlSlpqVlNMbEI3cTRyQzh6TEtPQkJnMzJH?=
 =?utf-8?B?NityNmRGeXB0c2ZCQnJyamVGb29BV0ovWkdOeU1XbC92blRSdjhRZFAwbW5Z?=
 =?utf-8?B?cU5FV1I0S004eW1vR0lacXEwdXlaOW9xTDErbWZ1S2NNNWh1RU9vVGFqYjZM?=
 =?utf-8?B?WjFZQmNaNTRpV1hXSFkyeEZINXVuNmx3cEdXam90RXFHZVpCa2lhVTNhZEhP?=
 =?utf-8?B?WmhQdXJjcTNYQ3VPTGpBbGhra2RzN0gxYUk0dkovR2QvZ0FnUjhCL2c3ZXc1?=
 =?utf-8?B?NUk2MzhFTWl0MWhCeCtmTzR2by9kTFVkODJIanU5VXBxOVdQdlliZ0ZmV0dx?=
 =?utf-8?B?UXdSMisxQ0VwQk9WTVRXWVdxckJIaGtrRTRuTWkrY2MvUzVFWkhocDdrdzd1?=
 =?utf-8?B?cHMvdzZyUzVQT1pRa1lrcmhBYk13TUlmYU1IMlhUTzhhSGgxVnhqVmNsNEtz?=
 =?utf-8?B?eVgxU0FYRk9XWmVJM1ZNbEJZakNSVWsyR1Y0YWpwc1N4OGFSajNYN2dLWmZX?=
 =?utf-8?B?QmNtYUc4RGtjL0Y4V3B3eVQzUWxvNFdEM1hrVTlPc2dkZDVZZG5qY05NMUll?=
 =?utf-8?B?RXo3SFU1UHhaZkdaaHltbkdYc2JidlBLdGxYOUJmcCsrNXdyakhwZ2V1ejJr?=
 =?utf-8?B?WGFZMGcrUmdYcE1yK21hUmNKZ3h0cnltcWRvekZSRWpEa0JTYWhpdTVxMWVV?=
 =?utf-8?B?STNWVzVhQmxoUkl2Qjd2ODZUa3FvMFlMd1lnK1BIYmhDRi9VTFlkS1crVjR3?=
 =?utf-8?B?SXJydlFKRXQ0RUtLUVZHaWR3cWk3S0IrUUltbmVpOG5GSnRPRHVuWVF5Nms3?=
 =?utf-8?B?WGpBYjZDY0pyK29tQ2VXV3c4Nm9NQkZ3R2JOaFBCVkFrc3ZvVzZjWU0wb0FE?=
 =?utf-8?B?ZTYxVGFTWS9Ld0lVQUV5eXY4bFFMQ2VqQThjc1hlaHp5UnFZdW5DekZNQWFY?=
 =?utf-8?B?a0VFb0hib2ZXcS8vU1NFZit2MW5aY3hic2k2V0JLMHZ6MklXN3RBVW5YeUl4?=
 =?utf-8?B?MlB4QlRzWVlZYURrQXZERHJEWmRkallXb1o3THBpaXJUMFMxZTdwY0ljdFVK?=
 =?utf-8?B?RS9iT0RpSW4xVFZlKzh2eVc4SGZzSHR4TTRmdXhHZDNwQ0FCdkpheDN3Q01R?=
 =?utf-8?B?NHdXaFVvZ1pJN3JHWUYzN1FLQlJRbTJHN21JZW1QeC9wNDdtS1hDRGI3ck8w?=
 =?utf-8?Q?pTksAFcuiF9vBLdenX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553b3899-b708-4798-882f-08df2e793032
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 07:10:14.6312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: br+W0kj7qYIym6V6at3ciWPqj3OzxPjE3SOvYapb1qZEcRmptJCLCMRF3Uu+nvfg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
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
> drm_client_dev_suspend()/resume() wait for clientlist_mutex, the fbdev
> damage work and the console lock. Their holders create, pin and lock the
> framebuffer BO or do blocking atomic commits, and the userq restore
> worker takes userq_mutex with BO reservations held, so GPU recovery ends
> up depending on userq_mutex and eviction fences:
> 
>   &dev->clientlist_mutex --> &userq_mgr->userq_mutex --> &reset_domain->sem
> 
> Only notify the DRM clients from system suspend/resume.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 71aa13a9883b..cb2bd4833f2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5228,8 +5228,6 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
>  				if (r)
>  					goto out;
>  
> -				drm_client_dev_resume(adev_to_drm(tmp_adev));
> -
>  				/*
>  				 * The GPU enters bad state once faulty pages
>  				 * by ECC has reached the threshold, and ras
> @@ -5562,8 +5560,6 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
>  		 */
>  		amdgpu_unregister_gpu_instance(tmp_adev);
>  
> -		drm_client_dev_suspend(adev_to_drm(tmp_adev));
> -
>  		/* disable ras on ALL IPs */
>  		if (!need_emergency_restart && !amdgpu_reset_in_dpc(adev))
>  			amdgpu_ras_suspend(tmp_adev);

