Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B82C30658
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jun 2024 17:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9406C10ECD6;
	Fri, 28 Jun 2024 17:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="NdeKO5t9";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E3B10ECD6
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jun 2024 17:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719596420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SP48UMwRjN/EBU8LVvAPVSE3bd+HHCSeXFaARhB6zhU=;
 b=NdeKO5t9fbXZKdn8CycGuS8+RSmbzLmVStZjdncnuFFNYC0LQQUdkyBNGO1ds2+UxBCaVA
 smBBQtL2iBiqwE7VqORsMY6ZMRx97yGh02nwAAnmgZZ/jfhwsOghjU5C1359vMNrd98D4u
 qENyVb7/4jDtrCJltu8Dbmvd61L+Ga8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-lR3HMlTsNjKKEq5haNLRdA-1; Fri, 28 Jun 2024 13:40:17 -0400
X-MC-Unique: lR3HMlTsNjKKEq5haNLRdA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4464caaa6f2so13042751cf.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jun 2024 10:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596416; x=1720201216;
 h=mime-version:user-agent:content-transfer-encoding:organization
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SP48UMwRjN/EBU8LVvAPVSE3bd+HHCSeXFaARhB6zhU=;
 b=PJXeZCsboENoKlZsFTMYC3Tp5/c5kI3mfQ2yTM7pje1Yq72H7tSdpGJ9QH6AX900xK
 WcskYe7h0lUNx8fOJN9rNuPvugRpcuQDJ6XlYf6mdEAhNCIAD9bk5FMxJpsELqj+VUYZ
 Tf5fe/K1z0Sy2PCcUgORUSKGmQj/UQJl2I8hrLg93u/Z35vF9QCORmPiQgdGjwMia9BW
 XR44Ml0j9FjXfLCVSfLvNkQ9AzHGqu9rmlNpzxH5iLxvcKjggGFglKNqWI2i5tWOrm4H
 10XsCPG3jgo7Y44zT2XHdPwIjUO85DhvrsnL+CytZAegWp8O/xpzchNPyP73oEAqD8Ox
 DDyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuDZXMIAUNLLjnSAYgdQH/xMcKuUETKZhJIHtgbPH3LtnJKMC0dbXqs6TUjAbdR5rnIuKvxtEwSW2N4/MJiaLYkbosb7p8NDU+K4beEw==
X-Gm-Message-State: AOJu0Yxz2JSztN8jilIIpmkaxmk6r5MejwqdvdKTQ8NFoF8RhF50mvRi
 VpRVuQ6LsdWBBjDemd1x5S9tvsXf/jK5dIO9mdvUKlfMWsqes4ervIAX1+6mU8CtalhDxa91j2x
 Od/S7pIhIB+ruiJlvRxCg4Uvgoe8qz01wu7krSgTodcShOH00ziuFOj0YfcmX06U=
X-Received: by 2002:a05:622a:1aa1:b0:446:4749:88aa with SMTP id
 d75a77b69052e-4464749894emr59113131cf.32.1719596416668; 
 Fri, 28 Jun 2024 10:40:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlk4mMP1ndQUm6VugscFP6Lg5KMqYcxhuueZsOuz4e2OVo+yEy7Ux31iC4UszjGEQFeRcEbQ==
X-Received: by 2002:a05:622a:1aa1:b0:446:4749:88aa with SMTP id
 d75a77b69052e-4464749894emr59112891cf.32.1719596416334; 
 Fri, 28 Jun 2024 10:40:16 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c4c:a000::789])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44651498178sm8840761cf.60.2024.06.28.10.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:40:15 -0700 (PDT)
Message-ID: <9004911c3b8c44afecb354db736f4d7d84c0cf19.camel@redhat.com>
Subject: Re: [PATCH 2/3] drm/dp_mst: Skip CSN if topology probing is not
 done yet
From: Lyude Paul <lyude@redhat.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
Cc: "jani.nikula@intel.com" <jani.nikula@intel.com>, "imre.deak@intel.com"
 <imre.deak@intel.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Date: Fri, 28 Jun 2024 13:40:14 -0400
In-Reply-To: <CO6PR12MB5489CB4E5CFB71CF8E812BEEFCD72@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20240626084825.878565-1-Wayne.Lin@amd.com>
 <20240626084825.878565-3-Wayne.Lin@amd.com>
 <7da3ccf156a858c1a7d2691fbedfa7aa2ceccdf7.camel@redhat.com>
 <CO6PR12MB5489CB4E5CFB71CF8E812BEEFCD72@CO6PR12MB5489.namprd12.prod.outlook.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 2024-06-27 at 09:04 +0000, Lin, Wayne wrote:
>=20
> I understand your concern. My patch will just check whether mst
> manager starts
> the probing process or not by confirming whether we sent LINK_ADDRESS
> to
> the 1st mst branch already. It will drop the CSN event only when the
> event comes
> earlier than the probing. The CSN events occur during topology
> probing should
> still have chance to be handled after probing process release the
> mgr->probe_lock
> I think. Does this make sense to you please? Thanks!

Yeah - that seems like the perfect solution :), sounds good to me

>=20
> > > =C2=A0=C2=A0=C2=A0 } else if (up_req->msg.req_type =3D=3D
> > > DP_RESOURCE_STATUS_NOTIFY) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst struct drm_dp_resource_status_notify *res_stat
> > > =3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &up_req->msg.u.resource_stat;
> >=20
> > --
> > Cheers,
> > =C2=A0Lyude Paul (she/her)
> > =C2=A0Software Engineer at Red Hat
>=20
> --
> Regards,
> Wayne Lin
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

