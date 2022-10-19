Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644C3C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Oct 2022 21:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64BD710E0DB;
	Wed, 19 Oct 2022 21:32:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4046810E0BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Oct 2022 21:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666215135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iRo8z7I39TZ2xgzmOs0IkUPyEriKByUvdIr0+xvZt3Y=;
 b=TnzEz5O7TBF/cuQchHjTG+IkTf/ga3y20rJ0WhJ5oZthmYA6JiDwjruCKHsVO7/U32NVY9
 lPLkyQ+A923zsY0jdXSK+uyxMiV5pznmIaB98EoMiVih+pQszXZ9Ch/bovHuTuaTas5/eh
 IhQgsCtYVBnTRkmR6pLMQ5iWk4GOprs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-f4g4O7DSN1O2-YzWkT6DBA-1; Wed, 19 Oct 2022 17:32:14 -0400
X-MC-Unique: f4g4O7DSN1O2-YzWkT6DBA-1
Received: by mail-qv1-f69.google.com with SMTP id
 mz8-20020a0562142d0800b004b18a95b180so11416799qvb.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Oct 2022 14:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:organization
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iRo8z7I39TZ2xgzmOs0IkUPyEriKByUvdIr0+xvZt3Y=;
 b=QC0fnxsE61LTlU3BTutXuPs7hY8B7KOY87oU4DuaAfFWfF0eidcpcEVvizzGvjVvjS
 37rD3w2JBCPRFPXMo4X2Qe1V+6kpBXIJdM6koYbr1nlTaOTpWMBdURpL4mZkIX3Ty5L5
 12j/kRfqdbKMeI9Mog1OLe0SOg3Qso8Ay6gtci5g+136U2pjePGF3g5f/MqLXZ5rwmgV
 Zab1y/QUxY0NwtnAs7yNryxWQTFvHIvwiFBJ4+fuRvLM83UcRzMaQ7KgMLDhZcxsxm2o
 aYBzlUGKSq8sSoQjbAzouak+XpIsBD+TXGuQ+sreb6YzEMFgNB1/A0xmo47NPuY10VCD
 ncSg==
X-Gm-Message-State: ACrzQf0Iq5G7TRJmMaL6dsXBjaTEyiABUozZm1GKtq1kFLtw1tV8XaTf
 PO+v9CztlHT0hwujAGgMrTfLmcsquC1HMw3sHgp8HRSDiirV0jpgxYFvmgWas4kJOACZ/nlJ6hP
 pfkNQmM1SBtUxHOGefRfumL4YDA==
X-Received: by 2002:ac8:7e84:0:b0:35b:a902:57c3 with SMTP id
 w4-20020ac87e84000000b0035ba90257c3mr8244627qtj.37.1666215133695; 
 Wed, 19 Oct 2022 14:32:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6n9BznDrKP2dQk6tJ1JIOGufLUsAqZJjny42w86LkBTeAVBcYMkps5A9DvXTIjQgO1LQYTSA==
X-Received: by 2002:ac8:7e84:0:b0:35b:a902:57c3 with SMTP id
 w4-20020ac87e84000000b0035ba90257c3mr8244601qtj.37.1666215133472; 
 Wed, 19 Oct 2022 14:32:13 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c68:4300:fdba:af4a:bbcd:7e28?
 ([2600:4040:5c68:4300:fdba:af4a:bbcd:7e28])
 by smtp.gmail.com with ESMTPSA id
 d4-20020ac81184000000b00359961365f1sm4675476qtj.68.2022.10.19.14.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Oct 2022 14:32:12 -0700 (PDT)
Message-ID: <41ffe32931a21961a3f368b30bd4335faa5ac6a4.camel@redhat.com>
Subject: Re: [PATCH] drm/amdgpu/dm/mst: Fix incorrect usage of
 drm_dp_add_payload_part2()
From: Lyude Paul <lyude@redhat.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "Siqueira, Rodrigo"
 <Rodrigo.Siqueira@amd.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Date: Wed, 19 Oct 2022 17:32:11 -0400
In-Reply-To: <CO6PR12MB548939841653ABD0EAA95DCAFC299@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20221004202429.124422-1-lyude@redhat.com>
 <d3b272e1-3b5d-c843-e8ac-57dc5e3a7ced@amd.com>
 <128762cfb6524d17e6ee7308aa7e859dd350fa63.camel@redhat.com>
 <CO6PR12MB548939841653ABD0EAA95DCAFC299@CO6PR12MB5489.namprd12.prod.outlook.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
Cc: "Chen, Ian" <Ian.Chen@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 open list <linux-kernel@vger.kernel.org>, Jani Nikula <jani.nikula@intel.com>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, Claudio Suarez <cssk@net-c.es>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>, Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Mikita Lipski <mikita.lipski@amd.com>,
 David Airlie <airlied@gmail.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, Colin Ian King <colin.i.king@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Gotcha, I'll take another look at this tomorrow

On Mon, 2022-10-17 at 03:09 +0000, Lin, Wayne wrote:
> [Public]
> 
> 
> 
> > -----Original Message-----
> > From: Lyude Paul <lyude@redhat.com>
> > Sent: Thursday, October 6, 2022 3:37 AM
> > To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; dri-
> > devel@lists.freedesktop.org; amd-gfx@lists.freedesktop.org
> > Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> > <Sunpeng.Li@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
> > Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; Zuo, Jerry
> > <Jerry.Zuo@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chen, Ian
> > <Ian.Chen@amd.com>; Mikita Lipski <mikita.lipski@amd.com>; Mahfooz,
> > Hamza <Hamza.Mahfooz@amd.com>; Claudio Suarez <cssk@net-c.es>; Colin
> > Ian King <colin.i.king@gmail.com>; Jani Nikula <jani.nikula@intel.com>; open
> > list <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH] drm/amdgpu/dm/mst: Fix incorrect usage of
> > drm_dp_add_payload_part2()
> > 
> > On Tue, 2022-10-04 at 16:46 -0400, Rodrigo Siqueira Jordao wrote:
> > > 
> > > On 2022-10-04 16:24, Lyude Paul wrote:
> > > > Yikes, it appears somehow I totally made a mistake here. We're
> > > > currently checking to see if drm_dp_add_payload_part2() returns a
> > > > non-zero value to indicate success. That's totally wrong though, as
> > > > this function only returns a zero value on success - not the other way
> > around.
> > > > 
> > > > So, fix that.
> > > > 
> > > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > > Issue:
> > > > 
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgi
> > > > tlab.freedesktop.org%2Fdrm%2Famd%2F-
> > %2Fissues%2F2171&amp;data=05%7C0
> > > > 
> > 1%7Cwayne.lin%40amd.com%7Ccd5a63120e064f4bb6aa08daa7090baf%7C3d
> > d8961
> > > > 
> > fe4884e608e11a82d994e183d%7C0%7C0%7C638005954559719396%7CUnkno
> > wn%7CT
> > > > 
> > WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC
> > JXV
> > > > 
> > CI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=nMIGnUKS6EDrdKJ0rR%2BAh
> > FRa4ST0%2
> > > > BYr9bILmXv40yv0%3D&amp;reserved=0
> > > > Fixes: 4d07b0bc4034 ("drm/display/dp_mst: Move all payload info into
> > > > the atomic state")
> > > > ---
> > > >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2
> > +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git
> > > > a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > > > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > > > index b8077fcd4651..00598def5b39 100644
> > > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > > > +++
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > > > @@ -297,7 +297,7 @@ bool
> > dm_helpers_dp_mst_send_payload_allocation(
> > > >   		clr_flag = MST_ALLOCATE_NEW_PAYLOAD;
> > > >   	}
> > > > 
> > > > -	if (enable && drm_dp_add_payload_part2(mst_mgr, mst_state-
> > > base.state, payload)) {
> > > > +	if (enable && drm_dp_add_payload_part2(mst_mgr,
> > > > +mst_state->base.state, payload) == 0) {
> 
> Hi Lyude,
> 
> This line changes the original logic a bit. The 'if' case was trying to catch failure 
> while sending ALLOCATE_PAYLOAD. If the msg fails, set the set_flag to false.
> If succeed, set the set_flag to true and clear the clr_flag. 
> 
> Sorry if the code wording misleading. Thanks!
> 
> > > >   		amdgpu_dm_set_mst_status(&aconnector->mst_status,
> > > >   			set_flag, false);
> > > >   	} else {
> > > 
> > > Hi Lyude,
> > > 
> > > Maybe I'm missing something, but I can't find the
> > > drm_dp_add_payload_part2() function on amd-staging-drm-next. Which
> > > repo are you using?
> > 
> > If it's not on amd-staging-drm-next then it likely hasn't gotten backported to
> > amd's branch yet and is in drm-misc-next
> > 
> > > 
> > > Thanks
> > > Siqueira
> > > 
> > 
> > --
> > Cheers,
> >  Lyude Paul (she/her)
> >  Software Engineer at Red Hat
> --
> Regards,
> Wayne Lin
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

