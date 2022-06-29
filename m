Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37C0C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 23:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D22810EF03;
	Wed, 29 Jun 2022 23:31:46 +0000 (UTC)
X-Greylist: delayed 426 seconds by postgrey-1.36 at gabe;
 Wed, 29 Jun 2022 23:31:44 UTC
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CFF710EF03
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 23:31:44 +0000 (UTC)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.riseup.net", Issuer "R3" (not verified))
 by mx1.riseup.net (Postfix) with ESMTPS id 4LYHc6373YzDrTZ;
 Wed, 29 Jun 2022 23:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1656545078; bh=elkf5RmFBorewHxBpyhHPWm8ng8ClJgtspzLN6zcMxk=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=NzDdKGhpy7bLep8cB6NgurxFBMmiWVKBePqtrFWXLnDo2KmcNzIN1g6bj0NSvAPzS
 lWKrioW0KJ7R11yFosqb0q7lJWy5RkWQby6uAcLt3h4deJC3fkiu7/2TBkDOxp8ERA
 MNpljOvbBjS8DJiobUcSibbo38g0iJ1wS+Dot43A=
X-Riseup-User-ID: 027D84224C03B59B55A80BD92B20FEB4E250A12BE61509C15A71B800C3DE096B
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews1.riseup.net (Postfix) with ESMTPSA id 4LYHc50w4Hz5vQt;
 Wed, 29 Jun 2022 23:24:36 +0000 (UTC)
Message-ID: <cff8f7f0-bcda-b804-0737-411c71ec9b77@riseup.net>
Date: Wed, 29 Jun 2022 20:24:33 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org, 
 dan.carpenter@oracle.com
References: <20220629170419.364255-1-Ramesh.Errabolu@amd.com>
From: =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220629170419.364255-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Ramesh,

On 6/29/22 14:04, Ramesh Errabolu wrote:
> The patch fixes couple of warnings, as reported by Smatch
> a static analyzer.
> 
> Fixes: 40d6aa758b13 ("drm/amdkfd: Extend KFD device topology to surface peer-to-peer links")>
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1428 kfd_create_indirect_link_prop() warn: iterator used outside loop: 'cpu_link'
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1462 kfd_create_indirect_link_prop() error: we previously assumed 'cpu_dev' could be null (see line 1420)
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1516 kfd_add_peer_prop() warn: iterator used outside loop: 'iolink3'
>

Usually, the Fixes tag would go here, after the commit message.

> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

As this is a v2 PATCH, it would be nice to have a small changelog here,
describing what has changed between the v1 and v2 versions of the patch.
Also, you can mark the patch as v2 with git send-email by adding the
flag -v2. More on the canonical patch format can be seen in [1].

[1]
https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format

Best Regards,
- Maíra Canal

>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 34 +++++++++++------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 25990bec600d..ca4825e555b7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1417,15 +1417,15 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
>  
>  		/* find CPU <-->  CPU links */
>  		cpu_dev = kfd_topology_device_by_proximity_domain(i);
> -		if (cpu_dev) {
> -			list_for_each_entry(cpu_link,
> -					&cpu_dev->io_link_props, list) {
> -				if (cpu_link->node_to == gpu_link->node_to)
> -					break;
> -			}
> -		}
> +		if (!cpu_dev)
> +			continue;
> +
> +		list_for_each_entry(cpu_link, &cpu_dev->io_link_props, list)
> +			if (cpu_link->node_to == gpu_link->node_to)
> +				break;
>  
> -		if (cpu_link->node_to != gpu_link->node_to)
> +		/* Ensures we didn't exit from list search with no hits */
> +		if (list_entry_is_head(cpu_link, &cpu_dev->io_link_props, list))
>  			return -ENOMEM;
>  
>  		/* CPU <--> CPU <--> GPU, GPU node*/
> @@ -1510,16 +1510,16 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
>  		cpu_dev = kfd_topology_device_by_proximity_domain(iolink1->node_to);
>  		if (cpu_dev) {
>  			list_for_each_entry(iolink3, &cpu_dev->io_link_props, list)
> -				if (iolink3->node_to == iolink2->node_to)
> +				if (iolink3->node_to == iolink2->node_to) {
> +					props->weight += iolink3->weight;
> +					props->min_latency += iolink3->min_latency;
> +					props->max_latency += iolink3->max_latency;
> +					props->min_bandwidth = min(props->min_bandwidth,
> +									iolink3->min_bandwidth);
> +					props->max_bandwidth = min(props->max_bandwidth,
> +									iolink3->max_bandwidth);
>  					break;
> -
> -			props->weight += iolink3->weight;
> -			props->min_latency += iolink3->min_latency;
> -			props->max_latency += iolink3->max_latency;
> -			props->min_bandwidth = min(props->min_bandwidth,
> -							iolink3->min_bandwidth);
> -			props->max_bandwidth = min(props->max_bandwidth,
> -							iolink3->max_bandwidth);
> +				}
>  		} else {
>  			WARN(1, "CPU node not found");
>  		}
