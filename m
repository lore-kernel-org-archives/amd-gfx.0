Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE3DECAAD8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 14:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E409010E6E3;
	Tue, 20 Sep 2022 14:48:13 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D9710E6E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 14:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEfQiviw6o7tixWYzN98wPcR6z+KJcOTw6bajO+uB3FcKYFKy3dfRnflC1GjZvFCvdAVgF40FQOUuM6v79SFRP2dcqTRYRbqCyMRlb1TcCl3ymsBcBzMM9at0E8vpw+haFfvfG9x5+uMikhginSPmq4/i3t+pDNEKNBPRqPKvrzVDtku3p7/wJlHqEMAr5YfYTFJ+KdKhaCfxtNiAJZIvXNgYu1t3vop+0kpR6i8n+M/M+ozPKOG5uChlsZx4k1j3C8dAuO2dU1vglNRiR68Ne303QOPedbHnPXbIL183ia2gEUt2kDrOX/Zi+zlepF7qyQEmBZM605jkTjYZ35a7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ddFxiGB3WcYjNTLEUYXJJ8eXePutM4NrkADJQEQuSY=;
 b=Hz8UmvFUYHEVtPc6dVobALLg/gNh/OOA63gbfzaReRr1PhqpbWpMyjNFKKMmA18GyKTnFqAbpVNunfGuPhZlVfbNww/y68vQf0hFjy064gzVNf2mUVNnOJ9HRZh+A0c6w+YxzZ8xRDE+ALqxc0hvM4EGuPVI4DZE9rs1zLr1rOFe/MzCm1+9wyXm9u6Gyw5DZ3un5ltMtL+Q/4hu2kl2Oq6OUJDRju7gq71uOdgQEFX9q19QnjIskJ5aev3iDXcW8QIs5rCV4AWZuHw1X9OP6lQ+tlG/NRJ+q10lDKLq7FWRJvLvlaRaHPGMjccoe0vmYgz9Kjr0yiHXMP9TQtZZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ddFxiGB3WcYjNTLEUYXJJ8eXePutM4NrkADJQEQuSY=;
 b=A9KjkkIE7epodPR9XVVYOZSr5wHjhN+6q7FUt3+dxDVmkB1ezjxtWmQTw/b1BR1T6td/UaVmVZsN9nAh5ZenNhiDcwWsmARENgAi9GFBSBhRE5rZQmC0qNbXuTp0XtpjInBcj9s4rQwtkeIsfqX6Cy+VEtoOXo/xNuuuNh1b/2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 MW4PR12MB6681.namprd12.prod.outlook.com (2603:10b6:303:1e1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.17; Tue, 20 Sep 2022 14:48:07 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::8423:8031:a9f3:20d5]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::8423:8031:a9f3:20d5%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 14:48:07 +0000
Message-ID: <76c4d2aa-4d91-277d-372e-eb4c26b46d77@amd.com>
Date: Tue, 20 Sep 2022 10:48:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] drm/amdgpu: don't register a dirty callback for non-atomic
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220920130832.2214101-1-alexander.deucher@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20220920130832.2214101-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0327.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::32) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|MW4PR12MB6681:EE_
X-MS-Office365-Filtering-Correlation-Id: 64244ca5-7748-4a1f-cd6e-08da9b17213d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLL6yCGRgVF3BZF9rgRogAWFo1QsJioK5pp2odIW6Y7HiJMULeaBPBCdXT+oMKMB4DwQwGerDxQMFG7u9bixtRjIFBXM1K2WHWHwLwiAj9SBIg3uh8r9A+IzXR15GQayFDQVIeBeumRZw+pV+6SsEA5wWmgeOJXK50A6NwIRgivf9q4PsQKZUZysk+YyuRPKnu5Xs2vmPEjALqRCuAIEYzp0XfdRMth8/wY+wbvzGFeV3qeZZVCBahlWly7APZISL9M1NbN0UyykgwRfoSoUd+8NbFt9ugHWYe+b9IshmvmBpK77PxWDQATjgfmnqrCP2TtA/1LjPm+C2Xp+DkBouB/7Q9U5RCtI7NemUnc8KxKhO9CLwAeliucTIgVEUN6ADQCTBD31NCvopMqE3V7Y1a7kSP+IDGoRIFCYntjLEtma5QEYML0YejLpTw8fksPPW45q0UjjNEhaBaJGo5q6QPVNY0u0KOxZ/Hsm7WaOglsjgCBNgkypU4OqTElbKCmCIIIfCNuJphwdrHUc9waDjqB05s5BpKqPQCiVhK81FIiBqrYjJMmYKz05oDBHiYb3LWXxl/h1S0PAYvgUKO63BapFfVI93Wos+tXx5UUuKSAOpUwNaBjzYqfR46Fe+n7DyU11uB887lYaqSLCGFcdv02RYgKDSfISJVHtl1oX0r0UQJYT43mIW5xhuwZwkrQMpqgauEq7P1nlmJxXPgEVUSIALB4d1qYrQ6vX+AmyW2ngtFZY1r9WpQKQkJsdOWEv6lBpljmzSlFPJbfEFSRYm+T8k7REJCbx0CfqVmNDY8o6YurviygEm8hi0r7eUcUf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199015)(53546011)(83380400001)(186003)(6666004)(6512007)(6506007)(2906002)(44832011)(41300700001)(26005)(5660300002)(2616005)(6486002)(478600001)(66476007)(66556008)(8936002)(316002)(66946007)(4326008)(8676002)(31696002)(36756003)(86362001)(38100700002)(31686004)(14143004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1BxZGYvYWFvRHJMUGgvZWRMWHN2RmplVmVsZE82eStxeHc4amRSeUhVeVQ0?=
 =?utf-8?B?a3NnSnkybmp2eEdGTUV5a3VSNTZPbndBSkZCaDJFdC82WmJBMU45NjIyVGJr?=
 =?utf-8?B?STBpT3NCdlNMa0JORGRxaDF2bmJ1cHZ6MGVYRkpKMGlqbm8ySHF6bXhlZU16?=
 =?utf-8?B?enZKYW5iWFlKVVJaSXFGbkpKZXBrRzExRHdGYXc4OWpYcXVPTVZjT2d0YlYv?=
 =?utf-8?B?bENTZnhsVm0rOFp4THRWUm9ZblZFbTdpQU5vWGk5Q2U1MnZaVGpMY0E3ajM2?=
 =?utf-8?B?bUhBa2VWSWQwcGxQSWoySDZMUmVVN2hBT0h6N1FFZkoxVThVRGRCeFp0eks3?=
 =?utf-8?B?QlZsZnBIQjlvYmJOdnlOV2Y4MFEvZDhZaWE3ZTRMSFBJdzBwcUJZa0h1MTJ4?=
 =?utf-8?B?RVdVLy9NWnlpNlVzVFMrYlIxdlgxRDV1S3RrckpBWTdhZXhmQVFRQnJGalpI?=
 =?utf-8?B?cy9hMitBTitlNU9VV1daUlB6Zk8xNUVCT0oxWSthVGNuNGFNVitYWWIvZm1m?=
 =?utf-8?B?V2szZ3dBUWNWUkkxUWxHTjNTeWs1emROeWhZckdMRElJdHAyU3U3Y1lEbldo?=
 =?utf-8?B?M3JHbGRkUktHMHREaTVqL3o4VU1lbkxZVEpJQXVTdDl2a0ViOE5mSzIyR1dV?=
 =?utf-8?B?d3NZMnI0VXdzaXMwbk85V01raW1Ucktra3QxcGZlS3Z3MjNwanBDbGJjSnNX?=
 =?utf-8?B?Qmd0MDhvQllQRzFXNERhYzJUY2w0ZmFIcytnc2c5U3lybFBtZzRHUTl1aUZH?=
 =?utf-8?B?V0tlZWRaODRrSnZhQWM0TmxzU0hpVU5OcHBPb0NtdUxnWVhwalJsTE1nL1N1?=
 =?utf-8?B?VEdxancveHdDQjFXRklKR053ZS9DM1IyR1RhUHhRQVg2RVZvTDhlNlczWjBB?=
 =?utf-8?B?OTZjRHJtNVIrUTIvTllMcVBEbW5zQllOUnBQYU5TMGxTeGFVcnlvUGgyek1U?=
 =?utf-8?B?Sm1SL3NqVW56WFRUblRxT3VGdUdLeFlZeGhYQldLVmZ5NkpSZW83SnY3ZXhK?=
 =?utf-8?B?ckpnUGRhRU5SY0VBSG1tWFpvNWhPbkJIbWhIWjlvOXNFa2lYQ1l0ZXdndk1h?=
 =?utf-8?B?cTlJcUV2VE5yR01qTU5HQjhUUVZrVHFFNmZoOVFqb1lUdU80VHpPenZhSEdz?=
 =?utf-8?B?V3ZvQTMrK2xMV25hQXJHbEh0VWNOWkFyLy9UTHgyMGpmUTdGeXh1ZEJOWnJm?=
 =?utf-8?B?WXZUZkFpZG5qdzFEbjVOQy9mQkdNcjVTbnNGQWlHOTBxQU93VUZDdE9iS2Vt?=
 =?utf-8?B?aDg0bVlCRk9LZHFaa0Y2cWk4cERzRWY0YlJ5K2NxYjBCYndzYWh1UDVhZ2V2?=
 =?utf-8?B?UHUyS2VzaWUwZ3BudVlhcndJLzIrS2UvSzZyaFpTTVdyR2xsMXdQNmxZYWxr?=
 =?utf-8?B?Q0h1VE91TzJURjU2ZXRlb0hZVUhNWkNSd21LSXkvMWhaUmpFNG9ObUljcDgr?=
 =?utf-8?B?SENSdVE1aCtHMXFHbElESnhyV1V4SjVtUHhEYlVWU2JHSFFFSlNubkVuV1Bv?=
 =?utf-8?B?Q0pCOEtFNEVhSUpINElEcE53bFlxb1FpS1o5cWZaS3p0S1JjR2Rob1NEcGZQ?=
 =?utf-8?B?Z05sMnJmNmxweEZtaGxvT0V1NU1UZUUzSTZUYnB1ZVJSUDFiT3psdFlML3Fk?=
 =?utf-8?B?amlUL2ErZUFKNEJMdXk1NnBGcklHVExBNm9hQ29EVXp1bTJxQ1lTZUlZRGFC?=
 =?utf-8?B?QzQvUXYwc0laQlpJWHgyT1lvcW95c0ZBaWZVSmNXL0F1OEF1eUpYOTl4U25F?=
 =?utf-8?B?c3dFVTdXdGlmZEk5eXJZOHJmWnF4eWVGcnFRd095RnFFSEJGNkJYZVNYdUZQ?=
 =?utf-8?B?cGlNcys5UEF2ejQ1QWlvSlE2ZDA5U3p0c1BkbXp1eHpzTWZUL3NCTmNSL2VV?=
 =?utf-8?B?YXM5WklPRGNvN2M3R3p3Ri90STZHS2lham1QR2tTbllqTllQRkx4YlRWQnlR?=
 =?utf-8?B?V284ZEJiaTFtcGo2RFF1N0tCcEdZS1dkbjlzK0tRbWU1azhOQWttd3pPQlZy?=
 =?utf-8?B?bVB2bzF5Y3d4U2phZzkrelBEbVhONC9DSm1oekV6eSs3Y0U4UXZOeGRYUU5z?=
 =?utf-8?B?NDFNQ3NubW9KclhCcnVrNi9YQk02YVVpSUoyWS93MHFRQ0RyQy9MZWhPcXdk?=
 =?utf-8?Q?SQHrZWYhKjMKKh4VVaWDgzWgM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64244ca5-7748-4a1f-cd6e-08da9b17213d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 14:48:07.1379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApN9um+kMxgnKKjnXEFUaP7XBlRbv8hqreZDzgU6iz3cikx1EtGg+eUl0H6Qs31yydnP0cb8vk3RXoDQ1D0hQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6681
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
Cc: Arthur Marsh <arthur.marsh@internode.on.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-09-20 09:08, Alex Deucher wrote:
> Some asics still support non-atomic code paths.
> 
> Fixes: 66f99628eb2440 ("drm/amdgpu: use dirty framebuffer helper")
> Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index dc5ef5fe6660..01618cd09acc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -39,6 +39,7 @@
>   #include <linux/pm_runtime.h>
>   #include <drm/drm_crtc_helper.h>
>   #include <drm/drm_damage_helper.h>
> +#include <drm/drm_drv.h>
>   #include <drm/drm_edid.h>
>   #include <drm/drm_gem_framebuffer_helper.h>
>   #include <drm/drm_fb_helper.h>
> @@ -532,6 +533,11 @@ bool amdgpu_display_ddc_probe(struct amdgpu_connector *amdgpu_connector,
>   static const struct drm_framebuffer_funcs amdgpu_fb_funcs = {
>   	.destroy = drm_gem_fb_destroy,
>   	.create_handle = drm_gem_fb_create_handle,
> +};
> +
> +static const struct drm_framebuffer_funcs amdgpu_fb_funcs_atomic = {
> +	.destroy = drm_gem_fb_destroy,
> +	.create_handle = drm_gem_fb_create_handle,
>   	.dirty = drm_atomic_helper_dirtyfb,
>   };
>   
> @@ -1137,7 +1143,10 @@ static int amdgpu_display_gem_fb_verify_and_init(struct drm_device *dev,
>   	if (ret)
>   		goto err;
>   
> -	ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
> +	if (drm_drv_uses_atomic_modeset(dev))
> +		ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs_atomic);
> +	else
> +		ret = drm_framebuffer_init(dev, &rfb->base, &amdgpu_fb_funcs);
>   	if (ret)
>   		goto err;
>   

-- 
Hamza

