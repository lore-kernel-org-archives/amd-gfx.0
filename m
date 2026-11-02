Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9330D606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 09:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JrjqNRqP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2C3610F4A4;
	Tue,  3 Nov 2026 09:36:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C7CE10E26F
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 20:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793652792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
 b=JrjqNRqP10lz+xwTaT1N5hOMraQMewbNcL6ZPtYs/6qBeMDZq5lyggz1hz5TUE2wvCqKwM
 IXQbQRbVn/7mLpXXty1C0A86MwLFP717upzSrzHF5Nt1PiF43MqFrw00/Vf94oFs2+EMGE
 o+EsfhfOm9/h5ijPwHR98WSryq3gxtk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-ZOjY6K4BPMmEi2tL-r65CQ-1; Mon, 02 Nov 2026 15:53:09 -0500
X-MC-Unique: ZOjY6K4BPMmEi2tL-r65CQ-1
X-Mimecast-MFC-AGG-ID: ZOjY6K4BPMmEi2tL-r65CQ_1793652788
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3ab2f8ce13dso226021fa.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2026 12:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793652788; x=1794257588;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
 b=SpjH2cEMdEEjBpfkKcph1eG5QLKDiluPTZtDkPXSj/q+OWozFZ0fosqIUPmdqkzhBn
 HDszPppFHhxAK8ZZGd0SI5XCJs9sy/cIeyckotDVC0tQSTOeZnyvObIgbZ96LASzigj5
 V/Low6IOenf3EUmmGRQdCDfo5OGBJLdeYTTz9nzON83bx3/t4Ar6Eu9eKcYj5KE0Sxlw
 OigGeTKqLVgjFPumzHqn/i21Fo2z+cyHme8TqxBwVLI+p6/YRC/MYlqrUZq/HlLu32xa
 lVPnsBZaKb4FtoVpNMq4HyhFZ2nmZKae5H4ed1RfVfQNywM067xIxA2rqWGI/YqED490
 yluw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwusXqoDLiS6zpANnd6T84sjDWx+N2lrZFy0k4d84G6057ma5YuQTpcjjbR+z02QhqgNgNVA5PU@lists.freedesktop.org
X-Gm-Message-State: APuU4Z88cXf1yaSkG1qv8SGoptjne7NbeUENs07NWMNOAItDvhoVviTH
 bY1FHUyAkH5FiPPIfG5bvo+Tvmk/JNKxRRC9CLvIAGskNXRfZlzb1HZcUgT1tKMqaVZhAVmjldw
 /d2CALgnPBf8hFoDWVLXZZPxZgzSeMSkc/qPXHDZjHc+UNPDL1hIYxULVGYlEtiPQWpYrYpHpql
 Zxv3iPrS94tOnJljs2PkF8VnkZohWi5aoDmNWUQwC7UQ==
X-Gm-Gg: AYBFou3PqGI4gloViMDD97pdEXlIOpHbSbZ+EPW11NgBayXJz2yJs2+rsBFjcDHrgTm
 //VAMwHU86lIg04sILOIA5QlxLj6/fE1Vl2uFfCwyGFhXqOTrr1Vu6CrP1cD4PbCkZ7riQSf2k+
 dGAtnAswDu5D6M7P9melTug7UxkyUoTykUs7qvJhqMEaxaSZ1K0gdU6ZeV
X-Received: by 2002:a05:651c:a14e:b0:3ac:4b79:573b with SMTP id
 38308e7fff4ca-3acb7aa83b1mr20499361fa.13.1793652788303; 
 Mon, 02 Nov 2026 12:53:08 -0800 (PST)
X-Received: by 2002:a05:651c:a14e:b0:3ac:4b79:573b with SMTP id
 38308e7fff4ca-3acb7aa83b1mr20499011fa.13.1793652787872; Mon, 02 Nov 2026
 12:53:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com>
 <20261027223847.652884-6-irogers@google.com>
In-Reply-To: <20261027223847.652884-6-irogers@google.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 2 Nov 2026 15:52:55 -0500
X-Gm-Features: AclHuK8pGzNf4aGPekLa6NQcs521xOugw8djA3E8ZMCjZ7yn89XzG5j_wIaQNFk
Message-ID: <CAK-6q+j-MS_5St04YFU11LG_Cjf1jOuS3q33qk_iK=7TE-iuBg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] dlm: Free dlm_ls in kobject release callback
To: Ian Rogers <irogers@google.com>
Cc: Kees Cook <kees@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Zhihao Cheng <chengzhihao1@huawei.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
 Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev,
 llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
 xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>, 
 Greg Kroah-Hartman <gregkh@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hyRxTaSxWNed_zGHpO0pvQhuAcfdqj_M-Gy_k3YvNtE_1793652788
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 03 Nov 2026 09:36:47 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, Oct 27, 2026 at 6:39=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> struct dlm_ls embeds a struct kobject (ls_kobj), but dlm_ktype lacked a
> .release callback and dlm freed the lockspace structure directly via
> kfree(ls). With CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, freeing ls before the
> delayed kobject release runs causes a use-after-free, and unloading the
> module while the delayed release is pending results in an instruction
> page fault.
>
> Add a completion ls_kobj_done and dlm_ls_release() to complete it when
> the last kobject reference is dropped, waiting for it in free_lockspace()
> before kfree(ls) and in the new_lockspace() error path before module_put(=
).
> Also delete the kobject via kobject_del() before stopping dlm_recoverd
> to close the window where concurrent sysfs writes could wake the stopped
> recovery task.
>
> Fixes: 3514faca19a6 ("kobject: remove struct kobj_type from struct kset")
> Signed-off-by: Ian Rogers <irogers@google.com>

A somewhat "big change" for just a debug functionality. Althrough I
agree we shout call "kobject_del()" early to avoid additional sysfs
changes during removal.

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

- Alex

