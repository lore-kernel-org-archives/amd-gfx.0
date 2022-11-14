Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1FDC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Nov 2022 21:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B654D10E320;
	Mon, 14 Nov 2022 21:55:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3B4310E320
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 21:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668462902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qpc2eQF4OVRCR9vIz7961ylczQfdMl7P3OUcWUSapU0=;
 b=C7Qk94be0dmNlQyoSBceypk7d3a56qScObS8ziYRski97UKEvSY7qqHCdfA2s80ckOXQf5
 FgoqKPRQyuRXoArU6xC1tcM9gpOI+6Of/LeK0htcuVuzoTdce948+Egm0A27X8vawmySx/
 ab2aEs6CFmyLSwN8S4jwkDJm4BccNak=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-97-epeTSub1Ot2PFa8rj6u8cQ-1; Mon, 14 Nov 2022 16:54:59 -0500
X-MC-Unique: epeTSub1Ot2PFa8rj6u8cQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 q17-20020a056214019100b004b1d3c9f3acso9291594qvr.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Nov 2022 13:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:organization
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qpc2eQF4OVRCR9vIz7961ylczQfdMl7P3OUcWUSapU0=;
 b=eE5aTPqD9rpKZb49ZJtYWk4AjdX+gkzgxJhU9xC5z13jar4DeDGsg4zKrO0He4+FLm
 g8P9RQcYgsO3EF1EWDdczdj7Ffp+xbIigItZvCt3bv4A2TBWda+a1NJOjIcrML5sBmae
 kTlrcbhuxuhssfcJzBFuqJXm5CVeTnCGcfoXPPOq2Sy+4CIKWXTEoDnyYSh1m62Te7BZ
 opdIqPujg4xRX7XUklijQNV4vh6puhqN+1Fu4ZOzWYXjPAaSE8mvDpjlo5GDTnaiXAj9
 oSRYFPuTg8p5Cd+hF//gOtayP7bvvrxWEYN2WD2OmH6h9s/ba4PYLR6Ux7TxlKvpv+b0
 lVEg==
X-Gm-Message-State: ANoB5pmXhRq5lgcebiA4XnlPR5ZwwXJ48wowHl3SVX+RUklxX1WlzkHT
 KDQKKw9FzLh4kAGjMw3o90Jk1nwnrtisbZMfQoEKLRi1RX4hf25WXccU5uQ7BXibqOqJNTh6clY
 K7ar3eY0VCFxky6+UQOkt6Wad7Q==
X-Received: by 2002:a05:6214:1902:b0:4a4:474a:1394 with SMTP id
 er2-20020a056214190200b004a4474a1394mr14177484qvb.36.1668462898907; 
 Mon, 14 Nov 2022 13:54:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4JgH34ZSNeRxluqCoega8kEsCXijBbz2npC1p8GEG2x4oKXtEevNQk4JgOUn038jyPFgODag==
X-Received: by 2002:a05:6214:1902:b0:4a4:474a:1394 with SMTP id
 er2-20020a056214190200b004a4474a1394mr14177451qvb.36.1668462898651; 
 Mon, 14 Nov 2022 13:54:58 -0800 (PST)
Received: from ?IPv6:2600:4040:5c6c:9200::feb? ([2600:4040:5c6c:9200::feb])
 by smtp.gmail.com with ESMTPSA id
 i19-20020a05620a249300b006fb38ff190bsm7023557qkn.34.2022.11.14.13.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Nov 2022 13:54:57 -0800 (PST)
Message-ID: <4482e7de979cc6673162b7aac0fcbfddb5d2d906.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/mst: Stop ignoring error codes and
 deadlocking
From: Lyude Paul <lyude@redhat.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Date: Mon, 14 Nov 2022 16:54:55 -0500
In-Reply-To: <CO6PR12MB5489E3850FE3C9FBDA7BAC29FC3E9@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20221104235926.302883-1-lyude@redhat.com>
 <20221104235926.302883-2-lyude@redhat.com>
 <CO6PR12MB5489E3850FE3C9FBDA7BAC29FC3E9@CO6PR12MB5489.namprd12.prod.outlook.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Liu, Wenjing" <Wenjing.Liu@amd.com>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>, David Airlie <airlied@gmail.com>, "Francis,
 David" <David.Francis@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Hung, 
 Alex" <Alex.Hung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, Daniel Vetter <daniel@ffwll.ch>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>,
 Mikita Lipski <mikita.lipski@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Kazlauskas, 
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 2022-11-09 at 09:48 +0000, Lin, Wayne wrote:
> >   	}
> > -	if (!drm_dp_mst_atomic_check(state) && !debugfs_overwrite) {
> > +	ret = drm_dp_mst_atomic_check(state);
> > +	if (ret == 0 && !debugfs_overwrite) {
> >   		set_dsc_configs_from_fairness_vars(params, vars, count,
> > k);
> > -		return true;
> > +		return 0;
> > +	} else if (ret == -EDEADLK) {
> > +		return ret;
> 
> I think we should return here whenever there is an error. Not just for
> EDEADLK case. 

Are we sure about this one? I think we may actually want to make this so it
returns on ret != -ENOSPC, since we want the function to continue if there's
no space in the atomic state available so it can try recomputing things with
compression enabled. On ret == 0 it should return early without doing
compression, and on ret == -ENOSPC it should just continue the function from
there

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

