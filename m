Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDF6C54E94
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 21:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00DC010E131;
	Wed, 25 Jan 2023 21:46:37 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D5D10E38B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 19:22:50 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-4ff1fa82bbbso231669047b3.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 11:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PCnMypYs8jymH6Ufuva+9r/69Y/DZs8kYxwQEYrzQFk=;
 b=hXTUs83qvSMCw0sqrewtph/1zyRGQA8EwV9VOqASoIhN1O27YlTeLHvU30LwpkaPKE
 6ZtbduOBpeU0Mk6yScQyxHGjdOZ8W8NbAK7HCSbKR2qQVwpslpoP2Mqh8DnM60UrkSEV
 Fy/rJx/xAj6ReR1yQheSDvUeiLsUOZe36GsXUe+/pA5dp4+pot+ScO1k5jhTafZOkoJo
 vEjMe7B3/0BupSIQn5CSlkYjolaKBFMYB73xyId061H8p1ZYZbkvvK9SPdZltanRDpUl
 vOuM+M/xFo7tmOP85pcv8h038+SVqlBqYWxO3Lgun0O5W06va+PJHK2pFsHgrhvmIiGL
 lvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PCnMypYs8jymH6Ufuva+9r/69Y/DZs8kYxwQEYrzQFk=;
 b=MIapJej/VOhzcuH7Y1sP4/K+VlzTpPLf8/wegxcocP6UHKWhPo9+2q4uUimtz6HwW9
 SDODUKwq0rrf5Psf7PRCQYOLVdTYDuN4rPTHKSaVy7BbeK+W/ruc/MGO7NHa/pl5DUyB
 P/VYARbdItrhOrgIx0iTBcLkiG7vF1zQw0nMYq37gurucQ+eF9KCzxTV9j9DA29Q93Pz
 hnJ5qMgzM/2CKqVu0QLGonNg8pMt3hjtv6c56wFP46DwFycpfkDMnVgzKYz6gK8Y7nQp
 rokDMFdjNbV2MwsJKBBQTlr/VcJtevLA4qGkMB5sXAFE7+LptzYbTXSRX3D6kJaqthsF
 0DBA==
X-Gm-Message-State: AO0yUKWB1WSEWY0hZqdquOgqZyg/sADj9PX9wRUCPFju22KmZMDqys1r
 Q9+vX/o+WKNlRapX0+29cjNax6JfY5rbSWcBP5hsdw==
X-Google-Smtp-Source: AK7set/Rj29H3r8vHaYccCmp943Un+QyMRF/w8dcRdt99GFw8apI+/L+5tSmXBTsBLdlTBniti7hA8kyFbpjr3H10kc=
X-Received: by 2002:a0d:d456:0:b0:507:26dc:ebd with SMTP id
 w83-20020a0dd456000000b0050726dc0ebdmr298632ywd.455.1674674569763; Wed, 25
 Jan 2023 11:22:49 -0800 (PST)
MIME-Version: 1.0
References: <20230125083851.27759-1-surenb@google.com>
 <20230125083851.27759-2-surenb@google.com>
 <Y9F19QEDX5d/44EV@casper.infradead.org>
In-Reply-To: <Y9F19QEDX5d/44EV@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 25 Jan 2023 11:22:38 -0800
Message-ID: <CAJuCfpH+LMFX=TT04gSMA05cz_-CXMum6fobRrduWvzm1HWPmQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] mm: introduce vma->vm_flags modifier functions
To: Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 25 Jan 2023 21:46:32 +0000
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
Cc: michel@lespinasse.org, nvdimm@lists.linux.dev, heiko@sntech.de,
 leewalsh@google.com, dri-devel@lists.freedesktop.org, perex@perex.cz,
 jglisse@google.com, arjunroy@google.com, m.szyprowski@samsung.com,
 linux-arch@vger.kernel.org, qianweili@huawei.com,
 linux-samsung-soc@vger.kernel.org, aneesh.kumar@linux.ibm.com,
 chenhuacai@kernel.org, kasan-dev@googlegroups.com, linux-acpi@vger.kernel.org,
 rientjes@google.com, xen-devel@lists.xenproject.org, devel@lists.orangefs.org,
 robdclark@gmail.com, minchan@google.com, robert.jarzmik@free.fr,
 linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org, npiggin@gmail.com,
 alex.williamson@redhat.com, viro@zeniv.linux.org.uk, luto@kernel.org,
 gthelen@google.com, tglx@linutronix.de, ldufour@linux.ibm.com,
 linux-sgx@vger.kernel.org, martin.petersen@oracle.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 linux-media@vger.kernel.org, freedreno@lists.freedesktop.org,
 joelaf@google.com, linux-aio@kvack.org, linux-fbdev@vger.kernel.org,
 linux-ia64@vger.kernel.org, david@redhat.com, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 target-devel@vger.kernel.org, punit.agrawal@bytedance.com,
 linux-s390@vger.kernel.org, dave@stgolabs.net, deller@gmx.de, hughd@google.com,
 andrii@kernel.org, patrik.r.jakobsson@gmail.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-rockchip@lists.infradead.org,
 linux-graphics-maintainer@vmware.com, kernel-team@android.com,
 jayalk@intworks.biz, soheil@google.com, selinux@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, mripard@kernel.org, shakeelb@google.com,
 haojian.zhuang@gmail.com, loongarch@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, tytso@mit.edu, nico@fluxnic.net,
 muchun.song@linux.dev, hjc@rock-chips.com, mcoquelin.stm32@gmail.com,
 tatashin@google.com, mike.kravetz@oracle.com, songliubraving@fb.com,
 jasowang@redhat.com, alsa-devel@alsa-project.org, peterx@redhat.com,
 linux-tegra@vger.kernel.org, kraxel@redhat.com, will@kernel.org,
 dmaengine@vger.kernel.org, bhe@redhat.com, miklos@szeredi.hu,
 linux-rdma@vger.kernel.org, linux-staging@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, gurua@google.com, dgilbert@interlog.com,
 xiang@kernel.org, pabeni@redhat.com, jejb@linux.ibm.com,
 quic_abhinavk@quicinc.com, bp@alien8.de, mchehab@kernel.org,
 linux-ext4@vger.kernel.org, tomba@kernel.org, hughlynch@google.com,
 sre@kernel.org, tfiga@chromium.org, linux-xfs@vger.kernel.org,
 zhangfei.gao@linaro.org, wangzhou1@hisilicon.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-erofs@lists.ozlabs.org, davem@davemloft.net,
 mhocko@suse.com, kvm@vger.kernel.org, mst@redhat.com, peterz@infradead.org,
 bigeasy@linutronix.de, alexandre.torgue@foss.st.com, dhowells@redhat.com,
 linux-mm@kvack.org, ray.huang@amd.com, adilger.kernel@dilger.ca,
 kuba@kernel.org, sparclinux@vger.kernel.org, airlied@gmail.com,
 anton.ivanov@cambridgegreys.com, herbert@gondor.apana.org.au,
 linux-scsi@vger.kernel.org, richard@nod.at, x86@kernel.org, vkoul@kernel.org,
 mingo@redhat.com, axelrasmussen@google.com, intel-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, paulmck@kernel.org, jannh@google.com, chao@kernel.org,
 maarten.lankhorst@linux.intel.com, liam.howlett@oracle.com,
 hdegoede@redhat.com, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, vbabka@suse.cz, dimitri.sivanich@hpe.com,
 posk@google.com, lstoakes@gmail.com, peterjung1337@gmail.com,
 yoshfuji@linux-ipv6.org, linuxppc-dev@lists.ozlabs.org, dsahern@kernel.org,
 kent.overstreet@linux.dev, kexec@lists.infradead.org, tiwai@suse.com,
 krzysztof.kozlowski@linaro.org, tzimmermann@suse.de, hannes@cmpxchg.org,
 dmitry.baryshkov@linaro.org, johannes@sipsolutions.net,
 mgorman@techsingularity.net, linux-accelerators@lists.ozlabs.org,
 l.stach@pengutronix.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 25, 2023 at 10:33 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jan 25, 2023 at 12:38:46AM -0800, Suren Baghdasaryan wrote:
> > +/* Use when VMA is not part of the VMA tree and needs no locking */
> > +static inline void init_vm_flags(struct vm_area_struct *vma,
> > +                              unsigned long flags)
> > +{
> > +     vma->vm_flags = flags;
>
> vm_flags are supposed to have type vm_flags_t.  That's not been
> fully realised yet, but perhaps we could avoid making it worse?
>
> >       pgprot_t vm_page_prot;
> > -     unsigned long vm_flags;         /* Flags, see mm.h. */
> > +
> > +     /*
> > +      * Flags, see mm.h.
> > +      * WARNING! Do not modify directly.
> > +      * Use {init|reset|set|clear|mod}_vm_flags() functions instead.
> > +      */
> > +     unsigned long vm_flags;
>
> Including changing this line to vm_flags_t

Good point. Will make the change. Thanks!
