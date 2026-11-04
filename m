Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE92606A329
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tiAfIf4W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA36810E211;
	Wed,  4 Nov 2026 22:46:48 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EEA510E211
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 22:46:42 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso8308115e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Nov 2026 14:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793832401; x=1794437201; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bhHTxlHexq0hz5X+Dyv08NkUmRONgq2V9iXR4d5KdJE=;
 b=tiAfIf4WBlKEomEeeCeCavQdKRriZqYjd/126nybKEu6gh6upiOyeS86CLWZs33Pnl
 WD043Ss/28wpM/63xLbHrUBwYXODRYbE+llcQ5tfrL5W1Fg2pwYyMCEQB+M4AORJX1jC
 bZdcZarJtAO6ffJqS1BdhIVP7sMnUVuzMsJgkbUMUHgsqp1Q840eq9+u+yhrwzA3m/Ic
 izdDpSURjbw2ba077C1YrPKsjv0FoBywfLSHF8KPgP6anNxb/mltZ4pYGGSBfMFdGLPB
 fZ/XylMNUMgeOG6tgrUXtw4HFA8+87Jlxu3gFSrrX9ZadI8a3/5qbdXOUMaRzqyB73Wa
 HLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793832401; x=1794437201;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bhHTxlHexq0hz5X+Dyv08NkUmRONgq2V9iXR4d5KdJE=;
 b=Npe75Y0xlgp+EuPYkeDwLz48dwBCFr135QP0w/uXSC2tCAREwTmPNpqhm7I6usHzBt
 dOz/2/s0hgoSrTIhGaOqPhvNGObAZY3B9k9Zedk9ac84cO3swVsqLhtpuaxJMY1ECx1l
 99iaM8a76cpwvmBujZYzwlm+PuOtcncUwb00XcqB2VR+kkbO62KO6AuBpv/Yw8tD2xNu
 qJamb8vLlN7DxZQfHmCbouXHxSJtePGnNnjgO+ElvIH56ABpUO6I33jmlRnBaeMn4boV
 AE+b2VKfQcOGyZpem9qPx0EIYkgF6uO8sy0K6TRKYVTxj80vtI2p7ebIDBipWXos0TAp
 01xw==
X-Forwarded-Encrypted: i=1;
 AKwUvByFH8gVm5mxXUGTQCDvcSa2rQR8BxsXsImIr3pCq+oxrd8Gzatc1I3m+UHDBheBTKU1r66J9sKB@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/6pLdhUAlEFGQyPk2LWr7jLok7005bFtWPUBMLqPIRIH7DNK2W
 iZ8waJ7QpdWNrjvel6CV/XxSvkXFoZgY0flUA8xhWhLOHcmHNYdLeedY
X-Gm-Gg: AYBFou39R8hwpIUvLW7fIs2/1whxrOLixwwP6/sdskiYuqHLc/laxlCaP5VrL3zTBgU
 9/63Er3Wni4Q5Lz49m3qXdpGxq43vrLwM1D2eiPRnZ8pNm9J+NnfyLkHUmimDHXarGouHhlQvkc
 0N71BijYAxncM28zWFC/FL69kPrsEo5HC8luhYaqr+FtrYqcKNbWjTyckpqj05c4LpSmATI+PcA
 WgQtr8t6XnLE8yThxOHUmzEasTd91Oe4QbX8eguwETvIzCNa4R/JqHMg/1CoY6EkpFKQqTiz/nF
 pZSrv3LFlJg8KNfrm4rG84ACb8qGoa6jBKJUCF/lRnrTFyRrErFrXkdndrXtUHdvxxYto90VWQQ
 Hc42m0t7E/uTMkRFNA13GuxsuPD487fWga2j6sOMMOmFWuiwfn8JI8hyun+NQiLT76fq+YeVuMd
 1J7sXjZjXF1Pb3YvtjWZuZdgK6ixIXNNLOlwedvpiOa3KY/rUzPNCFZe2PTuSG2QmeiXsZ/WuYZ
 jE7YsrfA6Vsdi/jRr/11yRuEP8X6GzZ45oXU1PFekneb4ayRvejls8POjUpAQ7d9ZBb/pyHqI/6
 aPt4zlhL5/udbs+yWThBT/uXHMrEKfEi/kdlFf0NNR1rh27O/YeyjWPApJdemR5dzkgljThNwUn
 +QjbZDUxo
X-Received: by 2002:a05:600c:c4b8:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4ac150b38dbmr403735475e9.1.1793832400493; 
 Wed, 04 Nov 2026 14:46:40 -0800 (PST)
Received: from [192.168.1.86] (240.red-79-154-229.dynamicip.rima-tde.net.
 [79.154.229.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda2007esm6019689f8f.47.2026.11.04.14.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 14:46:39 -0800 (PST)
Message-ID: <837f5db76982c9d84f45bc5ecd04e0bd9de16a4d.camel@gmail.com>
Subject: Re: [PATCH v3 02/15] drm/amdgpu: complete the guilty fence at the
 end of a multi ring reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"	
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, Mario
 Sopena-Novales <Mario.Novales@amd.com>, "Rastogi, Manu"
 <Manu.Rastogi@amd.com>, "Zhu, Jiongyu (Joey)"	 <Jiongyu.Zhu@amd.com>
Date: Wed, 04 Nov 2026 23:46:37 +0100
In-Reply-To: <BL1PR12MB51441296195645049FBB4763E3682@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
 <20261028085736.3808569-2-Jesse.Zhang@amd.com>
 <d744c7dedfc32ba6f1a66731eb9aa196f46af941.camel@gmail.com>
 <BL1PR12MB51441296195645049FBB4763E3682@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-04 at 02:46 +0000, Zhang, Jesse(Jie) wrote:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D a=
mdgpu_ring_reset_helper_end(ring, ring =3D=3D
> > > guilty_ring ?
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guilty_fence :
> > > ring->guilty_fence);
> >=20
> > Can you help me understand what was wrong with the line before?
> > I think guilty_fence =3D=3D ring->guilty_fence when ring =3D=3D guilty_=
ring
> > no?
>=20
> Usually yes, but not when the soft reset follows a failed ring reset
> of the
> same job.
> =C2=A0amdgpu_ring_reset(ring, vmid, job->hw_fence)
> =C2=A0=C2=A0 -> amdgpu_ring_reset_helper_begin(ring, F)
> =C2=A0=C2=A0 -> amdgpu_ring_backup_unprocessed_commands(ring, F)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sets ring->guilty_fence =3D F.
>=20
> So by the time the end helper runs, ring->guilty_fence no longer
> equals the
> guilty fence: the begin helper cleared it.

I think I see the problem.

I re-read the queue reset code and the helpers. During a queue reset,
it makes a backup and saves the guilty fence but if the queue reset
fails, it doesn't restore the contents, and on a subsequent call it
clears the guilty fence and the backed up contents.

Unfortunately I think this commit doesn't completely fix that because
the reset begin helper will still clear the backed up contents on the
second call (sets ring_backup_entries_to_copy =3D 0).

I think the correct fix would be to make sure we don't repeat the ring
reset begin helper:
https://gitlab.freedesktop.org/Venemo/linux/-/commit/86f2bf222caee0da267f9d=
9e12362513fe4f7f9e
Please take a look and if you agree feel free to take that patch in
your series.

Timur
