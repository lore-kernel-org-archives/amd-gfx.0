Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61336C27C53
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jun 2024 04:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB37510E877;
	Wed, 19 Jun 2024 04:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d7Y+VvzY";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99C2A10E877
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jun 2024 04:54:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kN7keIi/FfU1J2cytr21y62KC9A3KsdaI2bOMMXtaR4pPXrhnTKLkqh+eQ1gslPdIjuRb3bZx0rt0yb3QJibYiIB70ODT3Vx3QZ7z9Gi2EwInx7MlK96rfS/PXGDyycmaX721Yv0Zi3Bo97DLYnn+r0U4kNRM4Hsr+NtlH4EmuPUNd5vdeDt/q63JDYPxRlUSK5RjaHsDp71PN/PaUoo4hY86Mg8erB0GcsRRDpBz4MshWbtfMt7gKAJ7pGmUjbp1vme8leL93vhrq9nVQYRVGBz894SqI9hRjKI9xyxpBacHRTb99hIZmnVx0xphgIvqxdDxZMh5XeSsgjtBX2pIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FWwB+RKr6JAQXDn29f4plQWWn00SkZq4UGOjyeAMOs=;
 b=mLWijiX4ig3vIN7Dq02JiuSQKIOUds4JwnXiRHv9MWM1rCjP1x2ERmTL/4R9E43cOGhutmR4eLIcNWoNRacvGw+x4ZbJGONDY+4xIRWYDxD3NIS83rXLVgoln/KvrUzHOvgP6Y3Ehjr9IeuOMj6kdIzI58LagnWtKVpgcSMo9BeDqnLUKEN+OVGXhh2CMEPHN0iX9dh7mADhE1brcaq8LTzJEOM+TwG+5kRmptqWlkgOJYp5CWAWirHaaWBmg2yT8NG9tpce34C7gky6tL5Ym68BE6D6YurOsMa2hliH6NPcSsC0q1kc7eYpW2eAyXNcn9Buy6rK80va1LeO4+8HEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FWwB+RKr6JAQXDn29f4plQWWn00SkZq4UGOjyeAMOs=;
 b=d7Y+VvzY9wpQkK1zpT6hR3BTuQzX6QAhQ5dZS9CTL1EqAshAXWuXU4PGqdeMRQBaY5qtH3kYdxbpy/QY3GCuVvbx9BIcyrzlBATC08iZgnSJySrrW5/572DHchA5f/n8c7pWyKiAenZj4f/HPvXv6JOvpZdbcv4QsWae5XOkd0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by PH7PR12MB7796.namprd12.prod.outlook.com (2603:10b6:510:275::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 04:54:00 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972%7]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 04:53:59 +0000
Date: Wed, 19 Jun 2024 12:53:39 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Zhang, Julia" <Julia.Zhang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Chen, Jiqian" <Jiqian.Chen@amd.com>,
 "Zhu, Lingshan" <Lingshan.Zhu@amd.com>,
 Fusheng Huang <fusheng.huang@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: avoid using null object of framebuffer
Message-ID: <ZnJkU0ueb8dIbqbC@amd.com>
References: <20240619042924.1489294-1-julia.zhang@amd.com>
 <ZnJijxTr65XMEXki@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnJijxTr65XMEXki@amd.com>
X-ClientProxiedBy: KL1PR01CA0057.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::21) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|PH7PR12MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: a24ab70a-1097-42d2-42af-08dc901bd503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U73hB9RbcqFEpD26v015UZeRDSbpANr6t8w0NHkwFa0q0FADD7XQjh8rq/Kq?=
 =?us-ascii?Q?WAYaE7oZajslsoqSgqq+PUAcloATrwqVTF9L7Hn4Wx6Jn5Na5dupvaMXGI1n?=
 =?us-ascii?Q?/ORvx+bCYLbHYRhrbL+IOxGZCNwwUO4hQrpgwsGE+m9Wa3k6bWPzVlKI9TzO?=
 =?us-ascii?Q?HrbCgTcIjczgFdAXxQshQu4MM7KhklReklTz821bTaDOxK7Ye4cuxWvPjNR7?=
 =?us-ascii?Q?GBD3xezL/oZ/1JoxZV8eCAm7EGV5cD1JkUGBJjjDvRXBhEDta2LsTup/kpLa?=
 =?us-ascii?Q?P/B+6gNl59rmbJiVco9/JTtBvDtnLkNYKK88GCc6oDnQnXfRaVkVJDAqYX3e?=
 =?us-ascii?Q?glfyQ6JxLMat6+LcoU+YwPJFgznSUPziJYVzh+XmIFUNWw77SougizQBXvzh?=
 =?us-ascii?Q?4O/Y5duJnqb9QyfonqoOMZ1Wa6NHxqWwwOPB0i6BLouHwmCWlwpZ2ylYW8yH?=
 =?us-ascii?Q?yufiqig+GcklnHvKoMp+b5YB+bPEzdbapfXoijwzzvAPjv2E++vY+rUTXha2?=
 =?us-ascii?Q?L7OY8KdKQl3o2jaQNL+P75Bo/eu3G874rWzpjiG1f155hmFSOyke0nyWakgZ?=
 =?us-ascii?Q?5SLJUOm3wxrpLT9asSTRKFPqt68yK6gQmnN9CBkwQ2au1AVBqjYwvq3WZvKg?=
 =?us-ascii?Q?MrGB4kSD1YJDTVTShUZHg1ZGtPp3WIhM1ONNQ6ttB6R+oEBsPu0K2p3ytZEY?=
 =?us-ascii?Q?iG4uuHYfVQLWPv9WIIHnj5+U06BBXkVMD3wDrCFzBBjQ4aJpE032yEsmwF72?=
 =?us-ascii?Q?aO+Dalv6NAD9BhGzTJHEKkhgAdctqX9Nr8LnfMcwv1tEqGLBw7gRdMafRc4t?=
 =?us-ascii?Q?08bMy5jGQ6OrnzVD9pOqlxwXRFdbQNx9DX+qOW9UHDRp20jNBNTKo5SGnZ3M?=
 =?us-ascii?Q?ojTAxatfBej/yPaGdv8QMv1b4SiIGGAY0oxHZQZWJt5omwgWZMGauJ2qxwGh?=
 =?us-ascii?Q?dWSIOKZfGOKZQ7enKRSZ13FduxiH4L+7XIuE9BzRLmmC0javc8Pb/boYDFvT?=
 =?us-ascii?Q?LYQGMfTvqjAe1ta1UHjwMYZKTmSTeEYIiY+f6kgL0y/Y6imDMcWVWn2juJrh?=
 =?us-ascii?Q?cLfLs6RoFYQVcjiLQiIvSlxpwLeA//vJMKyOQWh/HPKb6luK0orTgWsuCiEx?=
 =?us-ascii?Q?7o3xFm8kwT6D69vPrJB3vaMP6JlKR8XtB854+seOVFyXMhleqU6nFSGutAi/?=
 =?us-ascii?Q?xuhFNqoauVqLoHK0ARlERiZ3LQNQXFtAhcDbaUTVYF8UFnmqvbqAAVttDc7P?=
 =?us-ascii?Q?95ujx7Z72cHzkhstt3YmPevQDHXNPnChRCSFXQDDFF4+0Schc3LuTSmGOnMs?=
 =?us-ascii?Q?WbRUhXVTVSxp/Iue56b2xviB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/zRi5m07fjCQhIbEbLoRqGw+3mpTuoUPUib5vRub73ahd7W38+nYWqY131zo?=
 =?us-ascii?Q?19yk1JnWjO+gV6rSZF6BslzwQOoxjzCC/amu6q5dZom1nfvPH+0QqZr3tyso?=
 =?us-ascii?Q?Q1hWY+1DeV4rhlYVjVq7lOJW1w8XbZzzl/cw+Sm4VKCxbDu6RFtGDdc88Cig?=
 =?us-ascii?Q?dKo++5o6LGPUcnC5xBNlhk7oGMZxoYO5Wy91PJFBXGoAoB1YupMDTKvoJx7E?=
 =?us-ascii?Q?0SrJdTn+iUTc9TqmW3k/1yTRewRWA6zmHgSALKC5fST7Amfz4jzrVH0ZLrf3?=
 =?us-ascii?Q?1N9bdPQfVXdCtALSsf3o0tfjz3aLXCr4uEXE4gGT4r36CG4+7wzDbS41uWhv?=
 =?us-ascii?Q?ooQvS9VwjMnYLId9YI/+5HB9+eszrnf/73B+1N2Wuz8KnD5W4kiyJVr9DXgD?=
 =?us-ascii?Q?UoJiHyU0OHnZWg4QJasJfBOs0zn1A53JbtJgCoaQuPcPd6mi3VW+dh2qhyjn?=
 =?us-ascii?Q?mjbSw83acxS/tI2Gz520qqGYSh/gR9n5jIdHLwa+Iv1TgHq2dyxE3jQ8Z2Hk?=
 =?us-ascii?Q?zbndpTOpWphOBrYcziwPMaN3EaIT7p6QkhDIuDil2UToYsjrP8bizPenokKH?=
 =?us-ascii?Q?gJsWjVQrRgw194SljaybiWLHSJqqRU77DVsDsYXwchVg3URW43gw2qIDfhwJ?=
 =?us-ascii?Q?pUucaTQ20xoUB5eqQAhI53RbQp3E0fd/ZjsJkrjKSPwwyU9AqU18j0Sc3DBn?=
 =?us-ascii?Q?/AMEb/bBmeLAPBVuYSzpHnIW4qQUusu0nqodREVVKFCE+KCnE57DMUTQp+rD?=
 =?us-ascii?Q?UdmHEhg7HwkvnCEe56ilyL79bEuqOzZTqpYbh0E4VBoOo1WUhErinGU2Oppu?=
 =?us-ascii?Q?GUIZp3V7kE+vK/Pyu62p8NtkoYC1QAkLJJGmvRvQQ4ZZXwlU+fxUMWoEbbXx?=
 =?us-ascii?Q?+kkaFsGWOnLqpKv1U0/2hhXgY7kvwKfwdp9ghpzPFmzhG0jvWUtqp1k3WpQi?=
 =?us-ascii?Q?ovDRBIlhux8uxsohxjlgdgaA39rCsbsLL/tLcXbBpOqe1jKiqatk9zuUhMzr?=
 =?us-ascii?Q?ij6yz42gzjxA4PvKxfo/31ewJAYJCMu2LEhdZl7rimo/tFtnXnKdpwDR+qzp?=
 =?us-ascii?Q?HcRoZ0JqYaW35ebJy8o9fTumSkv4diywG5QmTrM6kBl43ZWQWrjWkOshzTMV?=
 =?us-ascii?Q?IA5ONvQI4hRju6O8SvOWzMPuDDQ0OeWhPqLtVcS1cSC/xlpBh83XS+w5Qo8N?=
 =?us-ascii?Q?ZqsvbpLaITXsAjcJe1EsqZBdoKvw9xFQVfJZXcKPSyEDm0jj/zBgPUAHVfja?=
 =?us-ascii?Q?4MeDMX8Lc5sw3REAhclIMjj4RF3RFNkVxRrjRl69Lyj+Xgrnz1DPSQsuxnDg?=
 =?us-ascii?Q?q0eNDykkC9nUSyJqsqm5C3a/jBt108t+yX9gUXhDhc7VtG/scTW6I8lu4CW3?=
 =?us-ascii?Q?pCGrNNDuHDtGcKmZ4KYXPgmNMj1+EyDRM2jg1EcG8r3p/KqCH2XnS1yd23Ir?=
 =?us-ascii?Q?SqDUDf3NxlbyOPooiH4LRr+XKMDFvowzLWCuIPAQ4TIzvMMTTCnJ8QSkV2rO?=
 =?us-ascii?Q?5Tn8gyNqI/3Tpub2E+RS1hkWFIJcbJyx6fyyaH1tLY+hI7YRMXrJ6GBnqv0f?=
 =?us-ascii?Q?8WWGuCNXNH3Y1sr2t0aBbq75HAYHnjHaP9fjiFc1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24ab70a-1097-42d2-42af-08dc901bd503
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 04:53:59.9125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVBAVK0hybFN3JTn1ck5HuowaeTwprMqqipkGKzd/F/ugV/127JdFVj1M0ycIv2o67HB3aqvDPNpJPLOEDeOlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7796
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

On Wed, Jun 19, 2024 at 12:46:25PM +0800, Huang Rui wrote:
> On Wed, Jun 19, 2024 at 12:29:24PM +0800, Zhang, Julia wrote:
> > Instead of using state->fb->obj[0] directly, get object from framebuffer
> > by calling drm_gem_fb_get_obj() and return error code when object is
> > null to avoid using null object of framebuffer.
> > 
> > v2: Call drm_gem_fb_get_obj after check old_state->fb for NULL.
> > 
> > Signed-off-by: Julia Zhang <Julia.Zhang@amd.com>
> > ---
> 
> Julia, you can add my RB during V1 in the next submission.
> 
> Reviewed-by: Huang Rui <ray.huang@amd.com>

CC Fusheng who reported the issue.

Fusheng, may we have your reported-by?

> 
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> > index d60c4a2eeb0c..212f6522859d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> > @@ -2,6 +2,7 @@
> >  
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_simple_kms_helper.h>
> > +#include <drm/drm_gem_framebuffer_helper.h>
> >  #include <drm/drm_vblank.h>
> >  
> >  #include "amdgpu.h"
> > @@ -311,7 +312,13 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane *plane,
> >  		return 0;
> >  	}
> >  	afb = to_amdgpu_framebuffer(new_state->fb);
> > -	obj = new_state->fb->obj[0];
> > +
> > +	obj = drm_gem_fb_get_obj(new_state->fb, 0);
> > +	if (!obj) {
> > +		DRM_ERROR("Failed to get obj from framebuffer\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	rbo = gem_to_amdgpu_bo(obj);
> >  	adev = amdgpu_ttm_adev(rbo->tbo.bdev);
> >  
> > @@ -365,12 +372,19 @@ static void amdgpu_vkms_cleanup_fb(struct drm_plane *plane,
> >  				   struct drm_plane_state *old_state)
> >  {
> >  	struct amdgpu_bo *rbo;
> > +	struct drm_gem_object *obj;
> >  	int r;
> >  
> >  	if (!old_state->fb)
> >  		return;
> >  
> > -	rbo = gem_to_amdgpu_bo(old_state->fb->obj[0]);
> > +	obj = drm_gem_fb_get_obj(old_state->fb, 0);
> > +	if (!obj) {
> > +		DRM_ERROR("Failed to get obj from framebuffer\n");
> > +		return;
> > +	}
> > +
> > +	rbo = gem_to_amdgpu_bo(obj);
> >  	r = amdgpu_bo_reserve(rbo, false);
> >  	if (unlikely(r)) {
> >  		DRM_ERROR("failed to reserve rbo before unpin\n");
> > -- 
> > 2.34.1
> > 
