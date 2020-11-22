Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0211C2D0E4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 08:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E0720719
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 08:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E0720719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 430E58989E;
	Mon, 23 Nov 2020 08:25:58 +0000 (UTC)
Received: from smtprelay.hostedemail.com (smtprelay0015.hostedemail.com
 [216.40.44.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8796D89CC9;
 Sun, 22 Nov 2020 18:22:43 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay05.hostedemail.com (Postfix) with ESMTP id 5998D18029124;
 Sun, 22 Nov 2020 18:22:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: base07_180d0122735e
X-Filterd-Recvd-Size: 5347
Received: from XPS-9350.home (unknown [47.151.128.180])
 (Authenticated sender: joe@perches.com)
 by omf13.hostedemail.com (Postfix) with ESMTPA;
 Sun, 22 Nov 2020 18:22:37 +0000 (UTC)
Message-ID: <859bae8ddae3238116824192f6ddf1c91a381913.camel@perches.com>
Subject: Re: [RFC] MAINTAINERS tag for cleanup robot
From: Joe Perches <joe@perches.com>
To: Tom Rix <trix@redhat.com>, clang-built-linux@googlegroups.com
Date: Sun, 22 Nov 2020 10:22:36 -0800
In-Reply-To: <6e8c1926-4209-8f10-d0f9-72c875a85a88@redhat.com>
References: <20201121165058.1644182-1-trix@redhat.com>
 <2105f0c05e9eae8bee8e17dcc5314474b3c0bc73.camel@perches.com>
 <6e8c1926-4209-8f10-d0f9-72c875a85a88@redhat.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 23 Nov 2020 08:25:57 +0000
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
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-scsi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 cluster-devel@redhat.com, linux-acpi@vger.kernel.org,
 tboot-devel@lists.sourceforge.net, coreteam@netfilter.org,
 xen-devel@lists.xenproject.org, MPT-FusionLinux.pdl@broadcom.com,
 linux-media@vger.kernel.org, alsa-devel@alsa-project.org,
 intel-gfx@lists.freedesktop.org, ecryptfs@vger.kernel.org,
 linux-omap@vger.kernel.org, devel@acpica.org, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org,
 linux-crypto@vger.kernel.org, patches@opensource.cirrus.com,
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, 2020-11-22 at 08:33 -0800, Tom Rix wrote:
> On 11/21/20 9:10 AM, Joe Perches wrote:
> > On Sat, 2020-11-21 at 08:50 -0800, trix@redhat.com wrote:
> > > A difficult part of automating commits is composing the subsystem
> > > preamble in the commit log.  For the ongoing effort of a fixer producing
> > > one or two fixes a release the use of 'treewide:' does not seem appropriate.
> > > 
> > > It would be better if the normal prefix was used.  Unfortunately normal is
> > > not consistent across the tree.
> > > 
> > > So I am looking for comments for adding a new tag to the MAINTAINERS file
> > > 
> > > 	D: Commit subsystem prefix
> > > 
> > > ex/ for FPGA DFL DRIVERS
> > > 
> > > 	D: fpga: dfl:
> > I'm all for it.  Good luck with the effort.  It's not completely trivial.
> > 
> > From a decade ago:
> > 
> > https://lore.kernel.org/lkml/1289919077.28741.50.camel@Joe-Laptop/
> > 
> > (and that thread started with extra semicolon patches too)
> 
> Reading the history, how about this.
> 
> get_maintainer.pl outputs a single prefix, if multiple files have the
> same prefix it works, if they don't its an error.
> 
> Another script 'commit_one_file.sh' does the call to get_mainainter.pl
> to get the prefix and be called by run-clang-tools.py to get the fixer
> specific message.

It's not whether the script used is get_maintainer or any other script,
the question is really if the MAINTAINERS file is the appropriate place
to store per-subsystem patch specific prefixes.

It is.

Then the question should be how are the forms described and what is the
inheritance priority.  My preference would be to have a default of
inherit the parent base and add basename(subsystem dirname).

Commit history seems to have standardized on using colons as the separator
between the commit prefix and the subject.

A good mechanism to explore how various subsystems have uses prefixes in
the past might be something like:

$ git log --no-merges --pretty='%s' -<commit_count> <subsystem_path> | \
  perl -n -e 'print substr($_, 0, rindex($_, ":") + 1) . "\n";' | \
  sort | uniq -c | sort -rn

Using 10000 for commit_count and drivers/scsi for subsystem_path, the
top 40 entries are below:

About 1% don't have a colon, and there is no real consistency even
within individual drivers below scsi.  For instance, qla2xxx:

     1	    814 scsi: qla2xxx:
     2	    691 scsi: lpfc:
     3	    389 scsi: hisi_sas:
     4	    354 scsi: ufs:
     5	    339 scsi:
     6	    291 qla2xxx:
     7	    256 scsi: megaraid_sas:
     8	    249 scsi: mpt3sas:
     9	    200 hpsa:
    10	    190 scsi: aacraid:
    11	    174 lpfc:
    12	    153 scsi: qedf:
    13	    144 scsi: smartpqi:
    14	    139 scsi: cxlflash:
    15	    122 scsi: core:
    16	    110 [SCSI] qla2xxx:
    17	    108 ncr5380:
    18	     98 scsi: hpsa:
    19	     97 
    20	     89 treewide:
    21	     88 mpt3sas:
    22	     86 scsi: libfc:
    23	     85 scsi: qedi:
    24	     84 scsi: be2iscsi:
    25	     81 [SCSI] qla4xxx:
    26	     81 hisi_sas:
    27	     81 block:
    28	     75 megaraid_sas:
    29	     71 scsi: sd:
    30	     69 [SCSI] hpsa:
    31	     68 cxlflash:
    32	     65 scsi: libsas:
    33	     65 scsi: fnic:
    34	     61 scsi: scsi_debug:
    35	     60 scsi: arcmsr:
    36	     57 be2iscsi:
    37	     53 atp870u:
    38	     51 scsi: bfa:
    39	     50 scsi: storvsc:
    40	     48 sd:


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
