Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68333C25B47
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 07:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B4410E930;
	Fri, 27 Oct 2023 07:00:57 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D651B10E930
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 07:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byKJM8agAx9XmMqZW3a3ZoU2yHtzdDgiDpKO4W0BUV6nKudGluiEHVprCJOAbHr8+9oJMTzRB6KCK8Fx9EyR/uXCiMt47Ep5wZkIVvVnIDGTiLsnzPixBPeV1zXan5HOusRBl6jQ2kkpWMwXBTyfhGbRefUfd1Cxrm5T2wkDwXY/hLUD29G9x/fHLtvEzWJ+vGI/uc2z8jK4lQQnmKRFpcvlLC1gL+5MhNw5pZ3nAZr2LoMeG++Ozt+4n0dZHsycFyJ8L3thxs4sD0thVLQu7CfwP2rV/nvoT+TH348PjuoY+2rn6Dh/XcBUycUx18lhfne6pzImKVUJ4Y7LdYgDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fm5aP3qih49Uss0Toxa2t5OYs8Ui+kSqRseBYm0mhTo=;
 b=Nl5Qkc3kKWGivZddhJvj2oxP9fmmbHUSWcZNAzsowN2a+8YX/UpfyXU2bnp9K6uR00E7P2NDoT93VfsecBUqhzJi49085OEwG6LaZdqG85FKXRhrIxzx8yVoSRU7VjmEk9CA243GVLZPvwZUYFIep2KTPguRfkjRDl4LRy+DWbYtl5JYG+x0FUNDG2r79E1kD/M0VXBfIGS2aj5QcSpAa9WUKqZDaBfXBy8NodtrNX+tH1C685QQF7NAgWCzccugeM+bX6x3XBjSH0m1HCDw6k30Ox0xa/GwZFPZqIPJH9sXkYO3dVhiKugYqucAoXeoey51cO5UXZUTGsKEVewjFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fm5aP3qih49Uss0Toxa2t5OYs8Ui+kSqRseBYm0mhTo=;
 b=txQ+jKqmdgeEtWIfWlnEGcshw2y+RzfPB27O1p+InbCDp8IZJKB6lvCtcbWFIXq9o1IDaZ1WLZMS5SdL7S7ONPKakF04D5hvbaCQiF3+IvshUY7CK4F1zJQ0uBxi0GGws+Aog57Vf/KvrzYI6Mp41sG4RoLpRHXplOOfKv7p3cw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 07:00:52 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::af19:f731:8846:68ba]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::af19:f731:8846:68ba%6]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 07:00:52 +0000
Message-ID: <49c402b4-4531-4107-adbc-2b26e109179a@amd.com>
Date: Fri, 27 Oct 2023 09:00:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Remove duplicate fdinfo fields
Content-Language: en-US
To: Umio Yasuno <coelacanth_dream@protonmail.com>, neil.armstrong@linaro.org
References: <20231026220525.23682-1-coelacanth_dream@protonmail.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231026220525.23682-1-coelacanth_dream@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::23) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 9401f555-ac9e-4a30-371e-08dbd6ba74ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Ichu5Dw41bEdLkU7MjNBys8k3P233lb5Pgv1rZg5IMCAm6ECEavN/t3v0cZ5xVmrXRuGMw+9WvD9NDfWg6LMNQANzwoY9V4gWrXqYxLeSlgQ11PjR5iE1K5asQoauptyhUAovtGhqaHJPikFtCLzIm7CIHU3w/p4ylvprVy/77yvAjuckvCTMSU6zDi4JYbB4iBn8lBtGzI79afZVnWcafJn5KejOGcMoYLhvHpJdZOT0T+QJNQHLRCF4mIBR1Ua7xyBkKIrvAzgQFVvqVU29WJFA6lsziBKrtMaQCJyLY+JZiauzCgiC7Pp/A6t+NbgP67II7jmujQdNEZyTpkbryP1+ME2zxBOcNni4vwyZQ0/gc76zVEXKFpAoOJVLHOds2bXhZtgCpISdLs5+kLq8LmAv/Vm3pWHTYR4K0EMbNcMX+/96si94YnLrbUan7BZ+nKNQjFAU/SMDS+prn3Y4J9rhW2NiaJsqTV1kvH7EZWejgklAZ2mTAPkwnIii19No6un6h8wgMUMwYvEj4rqr8yLN5apQmfolK8YiPrCqCRdMqKrjKfn5Fd+v30o/wDDpaQ1Si81A8wJjj59TpyGE4qAFPaNqE73Ythij/HZGpVKTD4ba/LHRnZLGzR9TQF4CygefHV03A+sCqyBBvLMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(6666004)(6506007)(6512007)(6486002)(478600001)(86362001)(31696002)(36756003)(38100700002)(66476007)(2906002)(5660300002)(83380400001)(26005)(2616005)(66556008)(8676002)(316002)(4326008)(66946007)(41300700001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG5xMktYWFhGNm1iUUs5dlRRRE5VVWVobXFVNmFFaXBJZkt0dXU3cVYxVVNF?=
 =?utf-8?B?OEZ4d0loaEdQMmVWRm56NmhFb0lKSGZjSExmMjlDUkx6eUN5MCtSNm5ldlND?=
 =?utf-8?B?Sk1oTVhyUjVQYkFUWElYN1FMRlRmbGxlY3BNdzdHYVJmSStFOGJwOHRDdVo0?=
 =?utf-8?B?N1VoNlErYTVEY2VST2s1bnNsQXQ0SjZMR3EyR2szaER3ZzgvQi9qVFdDTGdt?=
 =?utf-8?B?Ymh2YW1ZWHlENWRYbVdXZ1hMSWNWZW5QTk5lcGl6ejdTU3Fpc3ZQZXB3ZE1r?=
 =?utf-8?B?MTN3U1FuZFR6R3BkcEptaUo3MEtmOG4vOTF0SENzQ0hNbTdtY0hhbnF2T3p5?=
 =?utf-8?B?QWRSdGh6UmdOMzFwcFBUZW1IVkNZdTVrRGtjZFhzRE5VVEpEY2NTem11TThO?=
 =?utf-8?B?ZlN4QTlKQzdNSzdRLzhaRXY2VkFBbkszSVYzUVFWMlVZSVRsMEVJUGRaclNO?=
 =?utf-8?B?ZDVIRzdGNllWNytMbWRwY2JkN2djRmR0WVlyb3ZoUmNyaGowcGltbXRxZlhG?=
 =?utf-8?B?TTV2cG9hdERMcVVMR0I1K3RzN2VvUm1yaCtNS1NxSUw5SEk3RlNJSFlIU2Nv?=
 =?utf-8?B?Vm9UWXA3bElXVWg3MUlCMWFqUXBZY284bTMvaUgzTk10NVdTNHIweHo5SFZJ?=
 =?utf-8?B?UWh5cTBlMVdtWGpkZWYzQUI3b1ZLNUg2eDBNMExkb29tME9JZW1rN0NvMWNK?=
 =?utf-8?B?NkJlSU9SWWZZdmptS284cDczcDBuMndicTM5aDRZeDNpUGxLVUk1U01hS2Ru?=
 =?utf-8?B?UFBDWmtVZEo5Ly9LT1JZT0RmNUVLcXp4OFZ0REVYY0lwbWVCNE5sMzRkYWcv?=
 =?utf-8?B?MlJXVnFMS1ZpWEtrZnNuNjdwWkxjL1dvV200R3dkOGxOZ0ovbkFWY2J3SFJI?=
 =?utf-8?B?QmRHcXlIcDhoajlsUEtKeU9NSFpVbGRxaGZIbFVLOE9EWGh4TE9WNkM4RnNY?=
 =?utf-8?B?Z3MrWkZLb2ZWdklDWGpTMENlSHhHc0FpV0wwSWVHS0lKQmRIRTdqcXFRNTZx?=
 =?utf-8?B?azVaOW9pQlFaZnlzL0w3dGRoVFpRZjR2RityekgyZ29hSlhaNWpSYkVyM2xx?=
 =?utf-8?B?TURlN09TUFBUaHJBSlhLcGZ1b3pWaTZjcmVIUlBXSVVFZDByQjJIT3ExY1ZB?=
 =?utf-8?B?R3ZsZzc2ejN6QjUyZHJ3ZFp3UVhSWDZuYWtHQWcra3QyQWZFbCtRNEdwWmJR?=
 =?utf-8?B?VjFQakxPWGxZMENsQk5aQnA0L2lhakVRMlovNVBQUDNIZWFxbUhTZTcwa1V1?=
 =?utf-8?B?Unl4Vzk5aXh5UUMwQ0sveXc1SGZESFZQeEtOME52aVUvWDVvMVJpeVpXTWFN?=
 =?utf-8?B?STUzYkVPSmRtU0pjSENJRXlBeHdWRUx4TlhEMkxhMVNETHFpQmJRQk5zY01J?=
 =?utf-8?B?Qm5PNnliUmRBc2FmeHpXSWgra2JiMEFRdFRocVhMemliYmp4TWc5MC9obmFy?=
 =?utf-8?B?dzdxbktSaGVvVUJSTzJOeVFJbjlKN0pGNXFWWWtsVjN4VStuY3pNRWY5UlFm?=
 =?utf-8?B?OXFvWDFZY0xYRTlUcFEzUks0UTAzamdwVmtKTWMrU2pySGdBdExnOGkzM3lD?=
 =?utf-8?B?NG9nUTdUdFl6OTkvU09oSzFxQUNXMVFYUjVjdHJiZ1dnSFhLSVliU1B5djVZ?=
 =?utf-8?B?Ykl1a1BvbWJUT0JZcHhuU0NrOHA2QU4rTnRIUFFOU1pWVVc2THVsWUd0QW5I?=
 =?utf-8?B?SUNGdDk1NkpxcE9ZRWJWWVFTVFhPNDM4dWYxeVF4MmdjRG5lb3Nld0xzdzdK?=
 =?utf-8?B?MFpUZ1M3WG10NjRtL1ZLTDN1TGczaUV1RXlyd05jajcvbkVWZXZOYnN3eEFD?=
 =?utf-8?B?NDlsVnViU1JZV1BKWW1md05JaXRRQTZ4ZjFVY3BnY0RoRWxES1VvRUg1SWNH?=
 =?utf-8?B?bVZsL21KU2hPemsybjc1clBldmdKdFVCbC9iZ2crUEJyTHhaem5jMVpGb1hw?=
 =?utf-8?B?NEVPQkkxL2JRa1gxMTBGWXprODk4VEc0bjN6WTFTY0hLcmJxWW55eXlUUEgz?=
 =?utf-8?B?NE8rckxzSkVYVEsxUkRQWlVycHFIUkpXQk53MzRNL25hdXRRWDg4U0FMNTVY?=
 =?utf-8?B?dWVFdlJwaWxseFcxR0U0Q1hqMkh1djZpbm9YelZUeXYyODVNV0QzVXVBMkZH?=
 =?utf-8?Q?TIRM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9401f555-ac9e-4a30-371e-08dbd6ba74ba
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:00:51.7345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bEIO2WRHAjLOKd3IgkiF8o2zvPOns4JZ7P7SIAnj2DgQNZoCSP/Mu7v1R37UtfX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
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
Cc: alexander.deucher@amd.com, robdclark@chromium.org, robdclark@gmail.com,
 amd-gfx@lists.freedesktop.org, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.10.23 um 00:05 schrieb Umio Yasuno:
> From: Rob Clark <robdclark@chromium.org>
>
> Some of the fields that are handled by drm_show_fdinfo() crept back in
> when rebasing the patch.  Remove them again.
>
> Fixes: 376c25f8ca47 ("drm/amdgpu: Switch to fdinfo helper")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: <alexander.deucher@amd.com>
> Co-developed-by: Umio Yasuno <coelacanth_dream@protonmail.com>
> Signed-off-by: Umio Yasuno <coelacanth_dream@protonmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>
> This thread has been inactive for nearly 5 months, so I re-created the patch.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index 6038b5021..e9b5d1903 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -87,9 +87,6 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>   	 */
>   
>   	drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
> -	drm_printf(p, "drm-driver:\t%s\n", file->minor->dev->driver->name);
> -	drm_printf(p, "drm-pdev:\t%04x:%02x:%02x.%d\n", domain, bus, dev, fn);
> -	drm_printf(p, "drm-client-id:\t%llu\n", vm->immediate.fence_context);
>   	drm_printf(p, "drm-memory-vram:\t%llu KiB\n", stats.vram/1024UL);
>   	drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", stats.gtt/1024UL);
>   	drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", stats.cpu/1024UL);

