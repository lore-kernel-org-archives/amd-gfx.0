Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D24C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 19:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D13A310E17F;
	Tue, 15 Mar 2022 19:27:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4F8210E17F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 19:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWwM9JGhtiy1v4MDEXsgXAo6QFfiqVx1hgrC6HqzyIaDHc6ys0vc4PD87FiMKVhzNf/OVj79EfHfM9XHFc2gXBuUN6Q1XusiUWO4zeA3lkpccOprxU091h8wq4VRtign/B2cJC9YEdOcOKCcEhT2d3+3w8GRAWmuyyaEbOzrHnYBEi3j2m2xZAIdIqwwvPJ3lv140FcS0TiAgVGkF5KyUNFMfmNB4SEkB0rnlgnhKIpLrdiUPr0O0zRgf8r3a/D8f68ZH+3Y7VbXAc4ckSl7foSGCwZfU6VA8ZDRIoBTfZiM8qPN6VWyOu+tSuRtiNbVUd8nV5bZTj1G/RZFs5pzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rfmEYb87KR6ZAL4FU0gnTNzRewee0acbmOypDLJm00=;
 b=NRjRjnhULeL3mDQyAwPrj+6yvuf/1Si2uTFeby5TFSzZlbObrDnjJiWQSY4v9Af8RzH2jmbbok8Rq1QoxTQhORXDPiT5HWdjtDPUmD3zLUuFBrYiMgO/+BUgl13o12UONRcnz90gryjF5H3Ivt8r2fm8XSKJ5XNCmt1Zx61PnVSSpnz13cr+hic61eZ4I4J0lApWfyj5cLBEUcAhbuTyAs2R19ucfqe2HrDIz5fI7rDsnuBAs83lShiFxI/QnRUnJreRAZi9BHTMo/+Msqhq3yQYVIyOhGYVEg3Ju+8rXzrI4Vm0qia92rxfEwJmJ3PprlR61m6mJWToAAp7/LHYDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rfmEYb87KR6ZAL4FU0gnTNzRewee0acbmOypDLJm00=;
 b=a+wEHsoW4br4Gd/Jq0jCji/FRohmGTZ4649vBcbueLvh0A/CKZbRlezIToI0ZOuQ4Zp7IJPEUPi9LFd+9ZdZY9B8SDW64RvNm+X3sIJMlGwmnzjbEoklMIc5OTto0O6HsCGw2LXB5gwc89tCif2CpQsMS9pOPL412IOPbVDLgEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by MWHPR1201MB0126.namprd12.prod.outlook.com (2603:10b6:301:57::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 19:27:34 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::994c:c7ce:c849:160]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::994c:c7ce:c849:160%4]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 19:27:34 +0000
Message-ID: <c92f6a77-e529-287f-ede8-27b6270bca07@amd.com>
Date: Tue, 15 Mar 2022 15:27:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] drm/amdgpu: make amdgpu_display_framebuffer_init()
 static
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220315170914.2804385-1-alexander.deucher@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20220315170914.2804385-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30)
 To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1517bb67-f895-49d1-fc42-08da06b9db31
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0126:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0126068473A920F9F03CD0038B109@MWHPR1201MB0126.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bOVdv0X5vqRIqFfu7UQyAD+sNxp5H5333CDqTy/Z0b0JXE5WHCSNvAY2CaLe5X2TthNYJqS9l5vwwumZgHRwFJHLjhVMAcUcD+cjk4L5mofN6RisFYZbuU3ilWXDqpLOVTwWlcAsrCDe+V8iACfDPxJ4VuIuQJSCmipuJsrxXncJrJD8uHwbD6pds7Oar+CXsY5yb471bA5jKWmv9Id+kXWV1l2VSDdtJFTCaz0880/nFXYjqP9WenfKO2Y8geCz3NO+gh/AiNSrRHOc6LYYh52F1ltm8Y1qa8SHTFgLh+XMtWyU/ov3PKuwgsOiuJMW8szQcclrYvdNYF5zwCxKcnOYG0Fq/Q4lGHMu78Bw7XZXxLAY2/Jz4dW53/9PfoGZwnauEC16kUgqQHtHNPD6NCkgMpDeWMr376HqzC93IfN6q9QEYL8lHjdy6yV/gsnBNmZtUjphSvueE+0Krpxg/oJjV8C701KSEZYYeT7gSdirVNxzfkkgjhepf/T/5nmYQzTuBSZZb7LjFnuww8PnUozvfcV6v2fPWlpJO/DwaY8N49xwY9hrI5QbWL1uHQJ/8ICTNRuAJMSzkyL5M5KWlD8a+ESHT8iO8+FogVL0x+gqY9epS8IKFfmT+T3ctmUnYVv0aaa2vY26AT+sWmE9hDpzW3seCPmTBfcprSw/p3h8odZ/IrxHAZihrY04dxq7EP4QO8h1Wv2jVr4dk7+fIfuowlzYKl2OPIeOr0lxJ5c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(44832011)(2906002)(2616005)(6512007)(66946007)(66476007)(66556008)(8936002)(53546011)(6506007)(26005)(186003)(83380400001)(31696002)(38100700002)(86362001)(8676002)(36756003)(316002)(6486002)(508600001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFl5Zk5MZlp3M05zRy9ILy9HNXByMm1HaTNiT1R6a2Mxd2dOcC9naE53VEVw?=
 =?utf-8?B?MWlUR0V3VlNkckNpTWtkKzZubEtjUVBGbm5tUVhwdG9KS2NFdjJLY2NXcHdY?=
 =?utf-8?B?WHVNa1VHMW43ekY0akY1YjBqZStlLzVJTU1aTXYvT3dVQWNjZGE3MG9XZmpO?=
 =?utf-8?B?RUxpdEtuS2s1cUt2V0pCc24xVG5od0dhTnlBN0NvSzJXNThORHczUGhPa3dE?=
 =?utf-8?B?dXlWZ09ZSGs2LzhNcTNjcEM1ZUdIZmJpZ0xUd2dia0pmZU55a3I4dEdTaFFM?=
 =?utf-8?B?Y3dvSnJvVG02NXRuc3RWUTdVVmtQVDVrOEMxajhyUWZqR1dCTFlLL01QY0JH?=
 =?utf-8?B?ZEdCSUR6U2phRlN1TitxUlNqNWFmNUtya2ZkNnlYeFRyTXNBVFEwaHBSZEts?=
 =?utf-8?B?a2FsVlptL2VHQlY5TVpJdFF6bnVwM0l3NEI2Z2dPb0xBSVRFTHFKdkJpelJn?=
 =?utf-8?B?bTluZm9VWjZ4cDE4QUhKcmo0ejZJQ2U2ZTBsQ3QxMlFtcWRrTFJOMkpKNS9t?=
 =?utf-8?B?bW9tMTVBK0dKWkFpTGtuZEprUkhnNTQ4M1Y2bFBwQ0tWRDdPZ3U2VEpZUVFW?=
 =?utf-8?B?QmFncjFyT1M1UEk0T0V3YXN4WXdLWXhHbzNzQXhONVhHa1ZiTTJoNHNmRDdq?=
 =?utf-8?B?Z1dNaThudnlxL2VwSzlPa21NUEVISGdQOGx3UkpGdVN1L0QvYXNINTJ3TkJC?=
 =?utf-8?B?RlJyODQxZlNRMmdGcWxGUlpHeURCbHVhWlZhVjlsNElDU3lnVlBqNzloVUE2?=
 =?utf-8?B?YXlsVmJqaHo4dU9Od2ZOOXpOVUptZjVvL0FCQzhaeEo3RjhzZDVkL09RODc0?=
 =?utf-8?B?K2krRFBCRlR0d2hMWUtkUXhvY2xJTlpOUXNpckJxRURoYVc0amVVQ2VQd2tR?=
 =?utf-8?B?TWNQL2x2OGpQYm5wOTdDY3QyQXJsV002cHIrdmtrdEltK1h1ZEJ4MDlUb0JU?=
 =?utf-8?B?d3RVdjliRy9Cd3EwbFRWcG0zdkFKRGZieFRPV0FLNE11RTFqdTdjYW5POHkv?=
 =?utf-8?B?bXZyRjkwTFBWdjduSUdDMkVGdmlqWVRDYzFrMHlTZVUzQ2puc0Z5cmhudStR?=
 =?utf-8?B?Z2p5cHQ2aVlUTXpVWW1xbUhoMStzUlBnd1NBQU9jOHZ1cER4dHFjM1FYVElO?=
 =?utf-8?B?cHl5SHJkNmlpZWpPUDQwWTdObmd0MU9jK2pnSW4wZ2dnNXNUM2g1WEhHNktZ?=
 =?utf-8?B?MEJJc0tNNThYMHVqL1M0eWVtUHFxeW12dVhyelFUSTJCQ0N6a0tWemdRcnR2?=
 =?utf-8?B?WEJCS0ZvbWEvTDgyZVJmQjdZNnl6QW10SzFrRk9pUUhCb1F6ek1NcnRHVlps?=
 =?utf-8?B?UTBGcU9NQXNlbnU5dklBUXNzY0FETi9LTDdXMlpnQ05PZTNLYldmQ1Y3bFc4?=
 =?utf-8?B?bzh1L0dpZGtHL29PRU5BbUU3aDhsTGFxeS9VNHBUOEl4TENPOGNCSVRUZWwy?=
 =?utf-8?B?QWt5dVl1MlJoVUZWbXdlcUxqZVlaMHNkck1rQ2NzOGFEQklBbDZpZ012UjR1?=
 =?utf-8?B?b3JHNmxkeGYwMXVEcUNnYUJjbGppWVh4UGIyeVN5N1J1ejBmR1czOFBwbHBW?=
 =?utf-8?B?R1pITDhJaTZqV3ZsMVAvQTlWeVZsQ0d3U2RNMm1qRUtKZUEzdlE3V1BxNTFE?=
 =?utf-8?B?a3N1a1FRRnlJYVppaTgwbmR3cG5EWS9DR0poQWFyK0xBZStDVEErMkxWb0F6?=
 =?utf-8?B?SGhsdm5laTZ0dDM3Uk5lYWlCbkVhbWQ4NFNyMEJTSlVDbC9LYVFDUUFQdEhB?=
 =?utf-8?B?U1AzUjhzT2JTZ0hIZlJUSmorR1QxNmgxNUJjSjZMVFd3bHp6Uk1YdHVtRkYr?=
 =?utf-8?B?eVpMTXBNcnhqcUZnMC9yS0tTUUJYU0ttaFJwZUc1K3pSZlJRbDM2SWRBOUlq?=
 =?utf-8?B?eWYxUEcrTGIwbEFtTVI4SEIxb1J6bTlieDBESzlBZmkvNHVITG9qaURMT2M0?=
 =?utf-8?Q?0BONBRVtyW/fm1VHWKxIt/ECdfueDCZ5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1517bb67-f895-49d1-fc42-08da06b9db31
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 19:27:34.5530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IC7MY/7nUp1WpiqQK7zWw27xUA0kMkvt4k74z2yT2ZyM8Ex0Gd5Eb/iBKdq/WZtZgnVlaAt0AbE+g+/bRUB9bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0126
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

Series is

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 2022-03-15 13:09, Alex Deucher wrote:
> It's not used outside of amdgpu_display.c.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 13 +++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    |  4 ----
>   2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 70be09dd2a93..cb78ba396672 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -41,6 +41,11 @@
>   #include <drm/drm_fourcc.h>
>   #include <drm/drm_vblank.h>
>   
> +static int amdgpu_display_framebuffer_init(struct drm_device *dev,
> +					   struct amdgpu_framebuffer *rfb,
> +					   const struct drm_mode_fb_cmd2 *mode_cmd,
> +					   struct drm_gem_object *obj);
> +
>   static void amdgpu_display_flip_callback(struct dma_fence *f,
>   					 struct dma_fence_cb *cb)
>   {
> @@ -1097,10 +1102,10 @@ int amdgpu_display_gem_fb_verify_and_init(
>   	return ret;
>   }
>   
> -int amdgpu_display_framebuffer_init(struct drm_device *dev,
> -				    struct amdgpu_framebuffer *rfb,
> -				    const struct drm_mode_fb_cmd2 *mode_cmd,
> -				    struct drm_gem_object *obj)
> +static int amdgpu_display_framebuffer_init(struct drm_device *dev,
> +					   struct amdgpu_framebuffer *rfb,
> +					   const struct drm_mode_fb_cmd2 *mode_cmd,
> +					   struct drm_gem_object *obj)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   	int ret, i;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> index 28848f1348a8..69ce2eeb782e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -600,10 +600,6 @@ int amdgpu_display_gem_fb_verify_and_init(
>   	struct drm_device *dev, struct amdgpu_framebuffer *rfb,
>   	struct drm_file *file_priv, const struct drm_mode_fb_cmd2 *mode_cmd,
>   	struct drm_gem_object *obj);
> -int amdgpu_display_framebuffer_init(struct drm_device *dev,
> -				    struct amdgpu_framebuffer *rfb,
> -				    const struct drm_mode_fb_cmd2 *mode_cmd,
> -				    struct drm_gem_object *obj);
>   
>   int amdgpufb_remove(struct drm_device *dev, struct drm_framebuffer *fb);
>   
