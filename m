Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2D3FD5339
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 09:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077B110EABF;
	Fri, 27 Feb 2026 09:17:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=manguebit.org header.i=@manguebit.org header.b="ulkKHiYz";
	dkim-atps=neutral
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD76910E9D2;
 Thu, 26 Feb 2026 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
 In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=lHNPvXjvxrRY/KHE3atTkGQgKEoBn4K5FRw/b5IfwZY=; b=ulkKHiYzv6I+6IIa14ftoupjDe
 J6D5Nic3w9+LTbwjPerGaRkKolwfy2KcZUzYubTFBR1C6YfViQ9IzWzOqE1PMBvOSLtWvDqYWHDkS
 e8YKhk2RZVgK/kgJGqWlaX1VlOeT5XV51JNx7TY19yYOoCL9WPMfL7DEx3UWQDxjJXBn4KZXjEq/L
 QYbtmeNM6AGz7YQoWObfC/Wgr1ca8Ha69hN8dnEa+b8qtPVTc9YoU/4JL/CqWgk9ghL/akGLMqNBo
 zcPi7YHA7wTZsVYKJPKxzvhBKFb5Xcdj6osXFB4VEMUpfmqou7ST10TYaQkSCLGoa+WvRtMN6QWb5
 s7cLVI5g==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
 id 1vvegP-00000000rdH-33sy; Thu, 26 Feb 2026 13:57:49 -0300
Message-ID: <5687bdf62ddd20660394eb0d7dabb96a@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 David Howells <dhowells@redhat.com>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, Jaegeuk Kim
 <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Steve French <sfrench@samba.org>, Ronnie Sahlberg
 <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>,
 Bharath SM <bharathsm@microsoft.com>, Alexander Aring
 <alex.aring@gmail.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Eric Van Hensbergen
 <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, Dominique
 Martinet <asmadeus@codewreck.org>, Christian Schoenebeck
 <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, Marc Dionne
 <marc.dionne@auristor.com>, Ian Kent <raven@themaw.net>, Luis de
 Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Ilya Dryomov
 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, Jan Harkes
 <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Nicolas Pitre <nico@fluxnic.net>,
 Tyler Hicks <code@tyhicks.com>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, Mikulas
 Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse
 <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Dave Kleikamp
 <shaggy@kernel.org>, Konstantin Komarov
 <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg
 <martin@omnibond.com>, Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen
 <al@alarsen.net>, Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal
 <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, Johannes
 Thumshirn <jth@kernel.org>, John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, Roberto
 Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, Fan
 Wu <wufan@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler
 <casey@schaufler-ca.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>, Eric Dumazet <edumazet@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de
 Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Oleg
 Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, "Darrick
 J. Wong" <djwong@kernel.org>, Martin Schiller <ms@dev.tdt.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org,
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
 autofs@vger.kernel.org, ceph-devel@vger.kernel.org,
 codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
 devel@lists.orangefs.org, linux-unionfs@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 netdev@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-hams@vger.kernel.org, linux-x25@vger.kernel.org, Jeff Layton
 <jlayton@kernel.org>
Subject: Re: [PATCH 13/61] smb: store full 64-bit uniqueid in i_ino
In-Reply-To: <20260226-iino-u64-v1-13-ccceff366db9@kernel.org>
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
 <20260226-iino-u64-v1-13-ccceff366db9@kernel.org>
Date: Thu, 26 Feb 2026 13:57:49 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 27 Feb 2026 09:17:00 +0000
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

Jeff Layton <jlayton@kernel.org> writes:

> With i_ino now u64, CIFS/SMB can store the full 64-bit uniqueid in
> i_ino without the XOR-folding hack previously needed on 32-bit
> architectures.
>
> - Simplify cifs_uniqueid_to_ino_t() to return u64 directly
> - Update hash variable type in cifs_get_inode_info()
> - Update format strings from %lu to %llu
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/smb/client/cifsfs.h | 12 +++---------
>  fs/smb/client/inode.c  |  4 ++--
>  2 files changed, 5 insertions(+), 11 deletions(-)

Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
