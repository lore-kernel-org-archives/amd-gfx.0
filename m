Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C8A606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=okonski-org.20260707.gappssmtp.com header.i=@okonski-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LBT9sySw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E2E511210C;
	Thu, 26 Nov 2026 08:09:44 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D2510E35B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 21:57:14 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c4cac7a7d3cso941062166b.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 13:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=okonski-org.20260707.gappssmtp.com; s=20260707; t=1795643833; x=1796248633;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EscVSvEEWXaJWdMSZsEK6jUAQTPG/3riC+SyPLRH0Y4=;
 b=LBT9sySwW41fres4uyzikYD1sXIKQfA3AdaFDfoMOVkhdp+GlcGgRh9m2FFGE4TKpr
 v3iAMvUqf5a0dF2AKv+pO/Asu/yH49QHIA+rQP3tG3qzJy7VgvsvRBhSiozm5CjLQBN0
 US7iYy0KdLsFcKPElfUfYEui1NlHVLCSGqPmhsEAL2pgsY771BXOHCZdkMGMxTsYYOVY
 nKvyS8Mk9xn2pm9pydZ3vDvaC11MbWgFlms1pRfwwdxvcln2f9iCX7C7IHMQK3yiNsIW
 JbLKVah9Oo7nexXRSq2Npxjd4t1uzF1Cm8314tZ1ZFXfErLpPEZ9r/SY3mkbmatsqRTv
 Vdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795643833; x=1796248633;
 h=in-reply-to:references:to:from:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EscVSvEEWXaJWdMSZsEK6jUAQTPG/3riC+SyPLRH0Y4=;
 b=r4GCw9TLiyEnIM/fa57g5Ax/GCSSxu02jSBUDRqPrC02Crlvc87b/SQG7GiU4zF5iQ
 oMj4wz29+hkqc7n9CfAtXWAbmVVq/grmHt+kdfOaZDwmVCc+7lYs7X6q+6jWBsauDSn6
 FFCPGwBrEtHI1FIBOl/N6tZcDU1QtVKTY8F20nNSEehArCUD6z8PvTBezU7eV8INhNui
 UBylrcQMMhowNmXMyRwSJDfdAjPUtIlixqlQCmsJurTiNVCkXD2JcufsTxTFP/ZhT9tL
 nXs66a9Y5Vr0+iVGwiCJTRgI8yXIQh+AjO0qyATa41VGVA4EBPrkVrL08v6JPj6BuWO7
 u/Fw==
X-Forwarded-Encrypted: i=1;
 AL+hErH2sN+smTE8bFUjBpdNfwDkx48FScs+xsP4JZSLpe/OtjQGDzY/EVlPiXchve9jDzedxEY93Gld@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/1yGluPZ8QernPd+zYO2X3FIK+g+C1FBhN++TpCTB4QzjI591f
 ZcR/Ly1KxCShTrT/HJkRDIKXl397P2/D9wnU9HyjWgPNH5CTcJwxCmdBXljWIdrZuAU=
X-Gm-Gg: AZFdTZfB68fviE4L6HIQ4QhcdiQgFftSP1zoDoOhsWuAyE0ydI2Brlf3/ZGr2jXmA9c
 Vq319N4izDSWz3RKQU58kfhp13tXESjoEesKUdYwpWvYvRJ/NwxMCSKcaxe5yxS7W7uAfZ6DmqL
 hnK0heQt63KN+FGs2K8Dw17oGxMI38O+btfJkce3HhnLr1TNb0Y0somiQYOB7KbbvQqr0m7zhZK
 Xew4BpSzUWl3C4eNejRCpaFydlv9vR9IqlWdkwulAJjEMrc79bWNkGoOSp7LGHVWEZmmKdYEio1
 QFZn15wtNOg6HChYB2t9V7tLtUTwMz8lQWrC8NapAZ5JsPQUTUHHptczp1ggZ6jMb8X6hm5upr4
 k40UmsqlAhD+PQiXP5AYr8nkO+PVgOAVkh1Bc3fiRSq8pAZ2Gx/g23Kr2YaVLYT37nRG5KcNu1r
 o/p942noMOsAYKgQ1OxDygqEv2KVu/rT1TGF2RU4waz9wx229KsYrXJOThX+g1vtl2xL82UCF5K
 a6WaAVvaJYvdah7wu2S0C0Y2PgwylNpUz5h1+oBLIQecaqoMPse/m/34tYk19XaLYKCwx+Zgtu5
 yHERg9AOhwiLEguyzka3R9tg9RHXU+miaukgGmsTwYGzgQPCKZhH6YfMdzWoA+q+ZZx9hWC43nK
 2pBF6Uzdc7bhmzpcLtajSZ3u3QivcxKabsQzWFDt2JYUnRJak
X-Received: by 2002:a17:907:c07:b0:c50:c04d:cbb3 with SMTP id
 a640c23a62f3a-c516adc890cmr999837066b.0.1795643832968; 
 Wed, 25 Nov 2026 13:57:12 -0800 (PST)
Received: from localhost ([2a02:21a0:10:748:2::2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513acfeda1sm731381166b.6.2026.11.25.13.57.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 13:57:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 22:57:10 +0100
Message-Id: <DN4MM3ZE5TZY.2P79WE24F8DZX@okonski.org>
Subject: Re: [RFC PATCH 2/2] drm/amd/display: Skip flip_done wait for
 non-modeset TEST_ONLY checks
Cc: <dri-devel@lists.freedesktop.org>, <sunpeng.li@amd.com>,
 <siqueira@igalia.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <amd-gfx@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
From: =?utf-8?q?Jakub_Oko=C5=84ski?= <jakub@okonski.org>
To: "Harry Wentland" <harry.wentland@amd.com>,
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
X-Mailer: aerc 0.22.0
References: <20261123220913.937402-1-jakub@okonski.org>
 <20261123220913.937402-3-jakub@okonski.org>
 <47ee6326-08ca-4dcd-866b-3a543cb15665@mailbox.org>
 <4daad602-10e4-4cd6-9cf9-7f47f77a7922@okonski.org>
 <a1dee5ea-2a50-47d3-9a81-eb1a94869815@amd.com>
In-Reply-To: <a1dee5ea-2a50-47d3-9a81-eb1a94869815@amd.com>
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:09:32 +0000
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 24, 2026 at 7:29 PM CET, Harry Wentland wrote:
>
>
> On 2026-11-24 09:07, Jakub Oko=C5=84ski wrote:
>> [You don't often get email from jakub@okonski.org. Learn why this is imp=
ortant at https://aka.ms/LearnAboutSenderIdentification ]
>>=20
>> On 11/24/26 14:05, Michel D=C3=A4nzer wrote:
>>> Does a commit with both DRM_MODE_ATOMIC_ALLOW_MODESET & DRM_MODE_ATOMIC=
_TEST_ONLY set really need to wait for pending flips to complete? Why?
>>=20
>> I was not confident at all and tried to keep this change narrow. It's
>> possible this could be relaxed further but I have not tried it.
>
> I have a branch that removes the need for that stall in atomic check and=
=20
> passed the work on to someone else for validation and review.
>
> The problem with the existing code is that IRQ handlers reference=20
> in-flight state, especially dc_stream_state. The solution is to decouple=
=20
> the state the IRQ handlers need from anything in flight. But its liable=
=20
> to break things, hence I'd rather be a bit more thorough with validation.
>
> I hope you'll see patches for it soon-ish.
>
> Harry

Great! Does that mean you'll be going further and superseding my patch
to cover the hw_done waits and potentially other sources of stalls too?
