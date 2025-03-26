Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0643AC36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 13:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D0AC10E6C4;
	Wed, 26 Mar 2025 13:19:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="wQC9rN7V";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCD3710E104
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 10:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1742983844; x=1743588644; i=spasswolf@web.de;
 bh=fYWRILG8iffA09ZGB3Ffsr3Bq1E8q8ZQHvSESpTPbCA=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=wQC9rN7Vz12e6LxL8YXSXVFYrMuHyKbWgt8R58QYyMAqZ4nbaeJtqXA3YplJMHXz
 ammPaYl+WA3T4amw6CeXIGe3iPzcDQNEH28/TP02iMW9c3RDjAeLKs0WSLonKA9yF
 mz0bwoOrSJkrNYzczTIyUoLzwpGvRNWkVju4jlzkI6Nc34XCD0P6K1aasnaLH7KFI
 Ilv3y7fvwrIlYbS8zQZPriymyD0eV99G4qMG0QqEjParpyboeAbID0pMf7r0pQueU
 Aj3sGFehw3cLtzu74XqbsO+zfzWhzWQOVYWC+K/BzRcKDo8JDOeD2iK1zPQkdx7XO
 6ecKrzZ6BrbhASPZUQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLijy-1tfiLM20x6-00Hzx1; Wed, 26
 Mar 2025 11:10:44 +0100
Message-ID: <79a263b2af01e7ed6594ca5896048bd9d7aae35e.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Alex Deucher	
 <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, spasswolf@web.de
Date: Wed, 26 Mar 2025 11:10:42 +0100
In-Reply-To: <a9f37e3b-2192-42d2-8d5d-c38c0d3fe509@nvidia.com>
References: <20250322122351.3268-1-spasswolf@web.de>
 <688f2757-e364-45db-ad54-daa6ff1c4f3c@nvidia.com>
 <6e8ad3cd27b570aaefd85395810cc90bb3120734.camel@web.de>
 <7cdbe06c-1586-4112-8d27-defa89c368e9@amd.com>
 <b1d72b95-5b5f-4954-923f-8eebc7909c4d@nvidia.com>
 <938c2cbd-c47f-4925-ba82-94eef54d9ebc@amd.com>
 <261e7069-9f65-4a89-95cb-25c224ff04f1@nvidia.com>
 <eb041c610719c8275d321c4c420c0b006d31d9f4.camel@web.de>
 <76672910-423c-4664-a1bd-da5c1d7d6afd@nvidia.com>
 <a9f37e3b-2192-42d2-8d5d-c38c0d3fe509@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G3OrBDdIcdKY3cXunfGtkb2MUbAOlzqr/8fqw2GvafE4WJO4vE6
 Yq6StZN0RCSHw50ggGJM2m+EQFKtfgplAxofMPzQMZprhrwsbgkjCsI9I5H2GOa830nUmGW
 Me++yMhyKQ78wbjbv21W3U19HMxa5eKuxA4QIFEOnswgu5NNANN2cYqKXZDge/pGObzCC6j
 af3By3y6xY3dAsRvZ83cA==
UI-OutboundReport: notjunk:1;M01:P0:zw9F0MhW690=;W4AbIuOp7MedvgHnKd9JBaHoyFH
 rSg4DdXalF9TmCDKbq79qaWzp3fu3ee0rXzxSmZ+Ks9eN5539yizAZgGOKDP644c5FN97WX6f
 2QCIq55Ffg4rW1j+sKPmTYrsLYUoLiMT1ChFtQP2dhU3jsoFv3xI0vJyq32CgH0t4arDszKeg
 ZQqDaXqZU8IWIR8CIXyOulUw9jk57cDGYzLsJ/qctxdexKJBh2/iyNK04BfstOskz/Vir/JAW
 zqPIYfzsEaiKKFgHetKMc9ynf0Dn/H8GeGHbVAbDmbAG6gVEYyIjAiNgmdyShBQ0S++noDKcY
 sSchTp9kR7VLs6RE6l/IrpK3l/DLI2bkw4HTXc/4YdLhfYnpGXxK4msNBlZhhUwzGb37YYACo
 IHuvvfUqkE3+iiGz6AqBproXLa5JeT2PcVoF0grpFZyuLLtVup8V+RP9oi2LDCZbUs9N8iW6Q
 2bJaKaWd8QqFzlJG9n3UKokEZ+j/Zve9wr1mEG+t0SPTWeYT4+IWh+6Giv4tKbBcf8G3UvHY7
 DiCNVD6S0+qH/5g7YkBuDtORLF85dY5r13vwo+nwb+qHR2wefeVaKl/smEP5vkdHdI6Z8Vyv4
 mC0v+xhmQkrnz9x7LXfZwpaJFz+E+9oE69WQTXTTjJaYD7jYgY+QQP6FsrrtMMp6tXmPsiCtf
 0ewYoT/KSiT5EtVWyuiBvuhhBGImEkLt7D1/SCledvEi7KSiuTF72+uSF0I7vpeCWaUkPzwQT
 +xre86dDV6EQHNb3XXx0efytYKsYRLNGLAPFhYvQpVZdSeHJr+hlIzXxDJC3YG8Z5W42XtEFK
 5LR2vTsFU3NnGqe9M3SIJCI+Iev9cVLP/1pxsO+4mUDIaelbTuXAMWdilQw4Un6bABBhUoJeF
 mgWt00F0E/4p80CfXjjpq/eI4bpoK25xRmIDaJoZ9KPp2NLcvaHQxvMf6yhyg3CrzmeDbbts/
 WAt16KXHp9/d9BBoms/FD+2B1y3LoZTeMEwJt1WNBqoapqKZSenk0XodxzTxhf3PU9azbePVq
 gX18fA4leqT6yyxxC5ktjpNqXJdoLX+mdCtcfTJOR6G8ZEfuHfOLr6jUpgTxcpkUBnyHJO5Hn
 PvdvYlKs+j2xbnyFYWCsRF9okq4I9t16MEquFv2Rwm4v8YPn17UiTldn+k5jAf1+z7OtR3rIx
 xDmhHrR73KlQVTvS4cnSjmQYFAqXLW2yNx+01L5mT/DdKxuzP/4AJu/Zy6oBXOpoxtDFg/qDS
 uR+hrcJYImXKlYmt/eeZqIMWjiKSQQBU+BGHpkq0imu6RqehUKNypit6OZTY4D42BKVSsHSJX
 6n7KoqqOlhFhEMYmc3GZAZbb398BubjDBnYPwUQePm1hwRIIzeCSORQMA6Q4+E3TpZVPDkubR
 u7srnFZA42W2QP4MD+jI1S00C81/30IpmoETTLyQyvWsW7pQh0zndPmtm1Hwts1aMYa0qCpka
 hdWngCw==
X-Mailman-Approved-At: Wed, 26 Mar 2025 13:19:22 +0000
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

Am Mittwoch, dem 26.03.2025 um 12:50 +1100 schrieb Balbir Singh:
> On 3/26/25 10:43, Balbir Singh wrote:
> > On 3/26/25 10:21, Bert Karwatzki wrote:
> > > Am Mittwoch, dem 26.03.2025 um 09:45 +1100 schrieb Balbir Singh:
> > > >
> > > >
> > > > The second region seems to be additional, I suspect that is HMM ma=
pping from kgd2kfd_init_zone_device()
> > > >
> > > > Balbir Singh
> > > >
> > > Good guess! I inserted a printk into kgd2kfd_init_zone_device():
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> > > b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> > > index d05d199b5e44..201220e2ac42 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> > > @@ -1049,6 +1049,8 @@ int kgd2kfd_init_zone_device(struct amdgpu_dev=
ice *adev)
> > >                 pgmap->range.end =3D res->end;
> > >                 pgmap->type =3D MEMORY_DEVICE_PRIVATE;
> > >         }
> > > +       dev_info(adev->dev, "%s: range.start =3D 0x%llx ranges.end =
=3D 0x%llx\n",
> > > +                       __func__, pgmap->range.start, pgmap->range.e=
nd);
> > >
> > >         pgmap->nr_range =3D 1;
> > >         pgmap->ops =3D &svm_migrate_pgmap_ops;
> > >
> > >
> > > and get this in the case without nokaslr:
> > >
> > > [    T367] amdgpu 0000:03:00.0: kfd_migrate: kgd2kfd_init_zone_devic=
e:
> > > range.start =3D 0xafe00000000 ranges.end =3D 0xaffffffffff
> > >
> > > and this in the case with nokaslr:
> > >
> > > [    T365] amdgpu 0000:03:00.0: kfd_migrate: kgd2kfd_init_zone_devic=
e:
> > > range.start =3D 0x3ffe00000000 ranges.end =3D 0x3fffffffffff
> > >
> >
> > So we should ignore the second region then for the purposes of this is=
sue.
> >
> > I think this now boils down to
> >
> > Why is the dma_get_required_mask set to all of addressable memory (46 =
bits)
> > when we have nokaslr
> >
>
> I think I know the root cause of the required_mask going up and hence th=
e
> use of DMA32
>
> 1. HMM calls add_pages()
> 2. add_pages calls update_end_of_memory_vars()
> 3. This updates max_pfn and that causes required_mask to go up to 46 bit=
s
>
> Do you have CONFIG_HSA_AMD_SVM enabled? Does turning it off, fix the iss=
ue?
>
> The actual issue is the update of max_pfn.
>
> Balbir Singh
>

Yes, turning off CONFIG_HSA_AMD_SVM fixes the issue, the strange memory
resource=C2=A0
afe00000000-affffffffff : 0000:03:00.0
is gone.

If one would add a max_pyhs_addr argument to devm_request_free_mem_region(=
)
(which return the resource addr in kgd2kfd_init_zone_device()) one could k=
eep
the memory below the 44bit limit with CONFIG_HSA_AMD_SVM enabled.

Bert Karwatzki
