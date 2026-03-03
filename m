Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCC4EDA698
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2026 17:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0F210E875;
	Tue,  3 Mar 2026 17:00:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.b="XM1eQFEy";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 947AA10E846
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2026 16:17:48 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-824a6f2d816so2598088b3a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Mar 2026 08:17:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772554668; cv=none;
 d=google.com; s=arc-20240605;
 b=GQ3AmFi0f7nTCNbpulCIYPVekZnj5ZXKPS/bpgqS+MVGWP34cJGiBL9QUtkIOjb5qC
 DqTwbClEMTSdvbMqIMcvRVmFbGNOFzWIOBPtU6Gl8KVCigdG83dLQvIj0G8E9PLY5nKk
 13Mkx1YpVC7O0wZhB3ICbS5uRSQYywttpmBIZbcv8j4HZ4H4oq6XQVylKkExQYYAt5Bp
 bsFa3/O5wrSuqAUZksCEgOIpGXai+Q+L1HU2/rnd40XegRuEaLHi6b6k6k/pK92wCbZu
 ZtFbARrORgzt0UzahufvHp9Nbjq3MUm4XPm3XO5lX/7qFtxECVZWyehdMyyGsw1KuhpA
 gcpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vlM0HTuT+/Lu8GovscjfA3KZuqms5GnXWRMciKBvDhQ=;
 fh=tecWcxNWi2OoBZBQu/XGA51ZsFJl2V+D4pPwfhRhwcQ=;
 b=kmhMEdFgPoX/JfRxMxWjcVOUz4gmZ+kPTecIouyUoOFt6THfvFNt4iwFCTqC/7/3lF
 Q4f47RsLfa9fmogmuaUDF92aN69irp8btaOldQCCQ7FbFEVn8kzOAPLP3Bjosfm4bQDH
 KK3z0Qj4tzwAs7a6ff29mGh0svF3lF9OSssTapXQ9bnXWZou5sN+WLJ0s5Xg3OaRfAFB
 WyCwxLz5fUfWxfBTpG82QFCj08J9OIdRiLD+UC3PUmhWXd19HIEtHu05qFBvKsoMDnJp
 AmmtfsPAR5GptwIASnmwFb8M2E3VnL7qypoHHLtcqKX3D5/u5PYkAEneKObCbS9DYt7/
 r9Ew==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore.com; s=google; t=1772554668; x=1773159468;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlM0HTuT+/Lu8GovscjfA3KZuqms5GnXWRMciKBvDhQ=;
 b=XM1eQFEywMqysfGSCA1xKkvxUL0ijCtPeBNPPMJO+VhInGCuV1hXcdq6kTpJy5EwYc
 ba+ckqW/ebDKbLqP3qUfhSdrO9355jdBaQ4lyCQ9zGr3ty1kjaWry5lDHtxM5MQtuxPw
 mA7QhV9WJiPdOBar1yCHliuSI+T7Neucl3aDZaDsML0fgweFgS4u4i5H9H70fwmnmbrN
 +7RbOdIlNu+Ae4S57W1Vd6ikevGdTV3NRa/X4YbcTs47I3h3ouRNL75bF3RZPVOrg6Y3
 qrGDeOP0yVhwjJMHKNl7dhXofXw0gi5v1kQbkUKDrdbfIL3qwoNqJFxZnEN53MId8mRg
 Cafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772554668; x=1773159468;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vlM0HTuT+/Lu8GovscjfA3KZuqms5GnXWRMciKBvDhQ=;
 b=tSC/e/zfomNK7dVt3rGMAqoDK3hy8jUgsbTMeiM2CUgDGCFw0Nw3nw5XfJzUgTFrWm
 8mNXMPUCAx/B7iZ38Ou0vWUjsApWFey1Yk+7Qu5Ok+yzqWhOJQsCsBjlrHu3xSCUXWJj
 ILWz3r6C6iDOXm06Uw0ycq1VCn1VSW9hjsWHX3ze+z8aT/Amr0Ebsaz7+Li2dTFr9vF5
 hhc5YCWAe1HI6RdjbNG+zuNWMcQ1d75Eq6YR32ZNSwbjFJQIlgn5cf3bMDGrCMNevvUf
 dnjWy+h5WyzeLm/g7UHkFn9TI8HKI7/cspNlc7o+fO2BvH+WpgVJttENN9hW4gsniSFt
 WKzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ7+6za2gvu4RSjEITGxwZ19vac5USfbGsrejD5C7g58t+YKMTiz8wKq6N8NHcIDtwVRe8fZ50@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDmL/aDy2UJS6Xkj2MUPInhqs19J83Qzk2h3/BrklrbtJ39qtT
 FePlhcK46AtiawE/w66tVIxrYcM5kNqujXGYuORLVEl9GOZdIyjNISm4j5zvtAX+P2t8heUoivf
 e61Ct57ql3mvoatGoG7NC2Z6JPfWgqMSYYmz1egcS
X-Gm-Gg: ATEYQzwnerV0G83RZ5Y7BdwByYPekbn9lPuoD22e3Ssq1OnBf+9PeXLPH46Igj6uaCc
 0z5gFLOVqotctb5fvJEH+Iex1vRpRuQ2XvsrohtastKF/SYcnm82UWByR2AbhrSCsvBpyjdhugO
 Xef1/cyGEUg9YG+AVezbmv15Mj66NOaaHkP4obvkphebD5vjqKAN1Qx+jLbmeJ+2jNUCbcf9cS3
 MRHSjTkfIlleLLPqbU4GHEDh/YrbqtonzWTxAqkeHmo0tngowjQRGwWJLRP9elEXBVshL8BP/1K
 QFxyrKk=
X-Received: by 2002:a17:90b:4c12:b0:359:8d70:c4e6 with SMTP id
 98e67ed59e1d1-3598d70c5admr5344309a91.1.1772554667658; Tue, 03 Mar 2026
 08:17:47 -0800 (PST)
MIME-Version: 1.0
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
 <20260302-iino-u64-v2-3-e5388800dae0@kernel.org>
 <CAHC9VhRnmBuXEKkUPQhJ_LDzcksjoAJL-ne6mFoJdR1hnDdzsg@mail.gmail.com>
 <7a0165fe39e82a1effd8cce5c2c4e82d6a42cb3a.camel@kernel.org>
 <CAHC9VhTyhnG7-ojnTnVdh_m1x=rKxw9YEH9g7Xp9m4F78aA5cA@mail.gmail.com>
 <add39953250a4a1b2fe2b09deb3373c2a7482b88.camel@kernel.org>
In-Reply-To: <add39953250a4a1b2fe2b09deb3373c2a7482b88.camel@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Mar 2026 11:17:34 -0500
X-Gm-Features: AaiRm503AvilRZsmzje3hsLVwZQN2UeIDoaYrT0wwtgoCj-_LcRzyWRvZdGrFAo
Message-ID: <CAHC9VhSb3nAsJBxhqitDVQw=J8hX1CJDe1xqL-JMjOA5J4tUkw@mail.gmail.com>
Subject: Re: [PATCH v2 003/110] audit: widen ino fields to u64
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Dan Williams <dan.j.williams@intel.com>, 
 Matthew Wilcox <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>, 
 "Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
 David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, 
 Steve French <sfrench@samba.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
 Alexander Aring <alex.aring@gmail.com>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 David Sterba <dsterba@suse.com>, 
 Marc Dionne <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, 
 Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 Ilya Dryomov <idryomov@gmail.com>, 
 Alex Markuze <amarkuze@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
 coda@cs.cmu.edu, 
 Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>,
 Amir Goldstein <amir73il@gmail.com>, 
 Christoph Hellwig <hch@infradead.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>, 
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 David Woodhouse <dwmw2@infradead.org>, 
 Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>, 
 Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
 John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Casey Schaufler <casey@schaufler-ca.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, "Darrick J. Wong" <djwong@kernel.org>, 
 Martin Schiller <ms@dev.tdt.de>, Eric Paris <eparis@redhat.com>,
 Joerg Reuter <jreuter@yaina.de>, 
 Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>,
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>,
 Remi Denis-Courmont <courmisch@gmail.com>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
 fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev, 
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org, 
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
 ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org, 
 jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev, 
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
 selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org, 
 linux-x25@vger.kernel.org, audit@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
 linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 03 Mar 2026 17:00:33 +0000
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

On Tue, Mar 3, 2026 at 11:12=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
> On Tue, 2026-03-03 at 11:03 -0500, Paul Moore wrote:
> > On Tue, Mar 3, 2026 at 6:05=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > > On Mon, 2026-03-02 at 18:44 -0500, Paul Moore wrote:
> > > > On Mon, Mar 2, 2026 at 3:25=E2=80=AFPM Jeff Layton <jlayton@kernel.=
org> wrote:
> > > > >
> > > > > inode->i_ino is being widened from unsigned long to u64. The audi=
t
> > > > > subsystem uses unsigned long ino in struct fields, function param=
eters,
> > > > > and local variables that store inode numbers from arbitrary files=
ystems.
> > > > > On 32-bit platforms this truncates inode numbers that exceed 32 b=
its,
> > > > > which will cause incorrect audit log entries and broken watch/mar=
k
> > > > > comparisons.
> > > > >
> > > > > Widen all audit ino fields, parameters, and locals to u64, and up=
date
> > > > > the inode format string from %lu to %llu to match.
> > > > >
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  include/linux/audit.h   | 2 +-
> > > > >  kernel/audit.h          | 9 ++++-----
> > > > >  kernel/audit_fsnotify.c | 4 ++--
> > > > >  kernel/audit_watch.c    | 8 ++++----
> > > > >  kernel/auditsc.c        | 2 +-
> > > > >  5 files changed, 12 insertions(+), 13 deletions(-)
> > > >
> > > > We should also update audit_hash_ino() in kernel/audit.h.  It is a
> > > > *very* basic hash function, so I think leaving the function as-is a=
nd
> > > > just changing the inode parameter from u32 to u64 should be fine.
> >
> > ...
> >
> > > It doesn't look like changing the argument type will make any materia=
l
> > > difference. Given that it should still work without that change, can =
we
> > > leave this cleanup for you to do in a follow-on patchset?
> >
> > I would prefer if you made the change as part of the patch, mainly to
> > keep a patch record of this being related.
>
> Ok, I'll see about factoring that in.

Thanks.

> > Ideally I'd really like to see kino_t used in the audit code instead
> > of u64, but perhaps that is done in a later patch that I didn't see.
>
> I think I didn't make this clear enough in the cover letter, but kino_t
> is removed at the end of the series. It's just there to support the
> change during the interim.

Ah, gotcha, thanks for the education :)

> If HCH gets his way to do the changes as one big patch, it'll go away
> entirely.

--=20
paul-moore.com
