Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F25D1039D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 08:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FDAE10E54A;
	Wed, 26 Nov 2025 08:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="vQWEMJY6";
	dkim-atps=neutral
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42E8910E18F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 08:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Reply-To:Content-ID:Content-Description;
 bh=JooPdBlnvKNLURGsI5vYvEHJgTQe9x3syHdXqOhbTtw=; b=vQWEMJY6Ob42gPaQ8L5SMYRkV4
 iOdgR7g6ydYtwbrH2g0bytH/Lq28aGbVEzbXVKWXCdi6W5PL5a3rjEdeIr3KQzJh3dgdS2wNR7Sy3
 TELejOo5mEWm3vMLxIukpurbjUxLkPuwVBmWAVnbhTkKMfE1KOLdbdNemb46vK4H8BOvF6dbGZQ7Y
 JdtNv+GQw3egVASDMwLHzOBGOTQBQsO4ODCGKdjjtjBE8Wvp8/G5GXztqZiNIRl6zu2wwkoZmFZ3+
 1vqki5sH93UU+vFZDFwjc3tIq6rIeYrDHKXLT1gzmQZtkNomOdIH7xY4C7FuKjPRJ0nj3ZuK4KXEE
 9r5D5KTg==;
Received: from authenticated user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2) (envelope-from <carnil@debian.org>)
 id 1vOAXx-0043gU-9t; Wed, 26 Nov 2025 08:06:41 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
 id 9370FBE2EE7; Wed, 26 Nov 2025 09:06:40 +0100 (CET)
Date: Wed, 26 Nov 2025 09:06:40 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Roman Savochenko <roman@oscada.org>, 1118349-done@bugs.debian.org
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: Bug#1118349: dpm broken on Radeon HD 8570D
Message-ID: <aSa1ECXKTkjM7_uv@eldamar.lan>
References: <389a9e45-0f92-4810-a8ed-91640750d973@oscada.org>
 <jkkqfvey7b6evfq6ojj7nldwka6a2s5y32ehybyoi47nfn25ck@hqh7d2zrvlr3>
 <ef917b90-3ed3-4c57-8af8-12012e1dfc1e@oscada.org>
 <qgdse6s2nzjfdbiudf5xv54mtg3tz2jopyvzijfn4vcdoxxlkr@xm56p5qrjndb>
 <cd316805-65a9-4f78-96bc-4ced6226db1a@oscada.org>
 <pipwh3hfkzm24t3qxknkpj44d3esmr7g46ldjgreb2357qmzra@7fekfuwv6udi>
 <f3b685d2-bb09-481f-bb54-3ef75613ccb7@oscada.org>
 <ccc4sfbee6ehdbkos3gpjhwtqy5fb2snlsz44jpzor6owupcyc@ckj7po3biqpo>
 <176078292467.2932.7155687538828443067.reportbug@home.home>
 <37c7d07c-fb54-4e0b-a880-b1b13795b5af@oscada.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37c7d07c-fb54-4e0b-a880-b1b13795b5af@oscada.org>
X-Debian-User: carnil
X-Mailman-Approved-At: Wed, 26 Nov 2025 08:58:07 +0000
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

Control: tags -1 + moreinfo

Hi all,

On Sat, Nov 22, 2025 at 07:40:33PM +0200, Roman Savochenko wrote:
> Hi, Uwe Kleine-König
> 
> 22.11.25 19:22, Uwe Kleine-König:
> > On Fri, Nov 21, 2025 at 11:11:39AM +0200, Roman Savochenko wrote:
> > > 21.11.25 10:35, Uwe Kleine-König:
> > > > On Thu, Nov 20, 2025 at 06:45:48PM +0200, Roman Savochenko wrote:
> > > > > 20.11.25 10:38, Uwe Kleine-König:
> > > > > > On Wed, Nov 19, 2025 at 08:23:31PM +0200, Roman Savochenko wrote:
> > > > > > > 19.11.25 19:05, Uwe Kleine-König:
> > > > > > > > On Wed, Nov 12, 2025 at 06:19:07PM +0200, Roman Savochenko wrote:
> > > > > > > > > 12.11.25 17:03, Christian König:
> > > > > > > > > > On 11/12/25 15:28, Roman Savochenko wrote:
> > > > > > > > > > > 12.11.25 13:14, Uwe Kleine-König:
> > > > > OK, and what do you want from me?
> > > > Quoting an earlier mail in that thread:
> > > > 
> > > > 	Can you try which Debian kernel was the last one working fine
> > > > 	respective the first being broken in this regard? You can find
> > > > 	all kernels onhttps://snapshot.debian.org/. Please ask if it's
> > > > 	unclear how to do that.
> > > I have told that as the kernel in Debian 11.
> > Is that the last working or the first broken?
> > 
> > The last kernel in Debian 11 (i.e. buster) is 5.10.218-1. Or do you mean
> > the last in buster-security which would be 5.10.244-1? Or do you mean
> > the one that Debian 11.0 was released with, that would be 5.10.46-4 (I
> > think)?
> > 
> > The kernels before and after that are depending on what you meant above
> > 5.10.216-1 or 5.10.237-1 or 5.10.46-3 and 5.10.221-1 or
> > 5.13.9-1~exp1 or 5.10.46-5. Which one do you mean?
> > 
> > The gist to take away here is: Don't specify kernel versions as "the one
> > in Debian 11" or "kernel 5" but use the proper kernel (package) version.
> > Everything else is too fuzzy for me to work with.
> 
> And what that about when I have said that precisely???
> 
> > Kernel 5 what? E.g. which concrete version number? (output of uname -a).
> user@debian:~$ cat /proc/version
> 
> Linux version 5.10.0-32-amd64 (debian-kernel@lists.debian.org) (gcc-10
> (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2)
> #1 SMP Debian 5.10.223-1 (2024-08-10)
> 
> > > > > Must I say you the exact commit or what,
> > > > > or you are waiting I must recompile all kernels with 294457 commits?
> > > > > 
> > > > > I say you in what way the problem related through the stable kernels in
> > > > > Debian releases and that is exactly assigned to the major versions of the
> > > > > Linux kernel, even for broken v5.19 which can include backports from 6!
> > > > Yeah, you keep talking about Linux 3, 4, 5 and 6. These categories cover
> > > > several years of development each and thus are not helpful to locate the
> > > > change that broke your setup. Unless it is really 5.19 that was good and
> > > > 6.0 that is bad which limits the amount of changes from:
> > > I keep talking that only for understanding the problem depth and not for
> > > fixing that in 4 kernels!
> > > 
> > > That is, there can be simpler to apply that workaround.
> > > 
> > > > . This is still a lot and we might ask you to do more tests to further
> > > > limit the set of candidate commits that are broken on your end.
> > > OK, ask.
> > That depends on the answers for the questions I already asked and that
> > are still not answered in a way that I can ask the followup questions.
> 
> Reread the stream then!
> 
> > > > > > Can you please confirm that 5.19.x (e.g. a kernel package from
> > > > > > https://snapshot.debian.org/package/linux/5.19.11-1/) works fine and
> > > > > > 6.0.x (e.g.https://snapshot.debian.org/package/linux/6.0.12-1/)
> > > > > > doesn't? (Or a similar statement with other consecutive mainline
> > > > > > versions.)
> > > > > 5.19.0 has this problem in view of hanging.
> > > > You lost me here. What is "problem in view of hanging"? Are we talking
> > > > about more than one problem? Or different variants of the same problem?
> > > We talk about different variants, and the hanging I saw also on one 6 kernel
> > > just after installing Debian 13 and that is why #1118349 I opened about the
> > > hanging but not rebooting in the initial report #879992.
> > Here is our language problem again. I fail to parse that sentence.
> 
> Reread the first message then:
> 
> >  From Debian 12 (any Linux kernel 6) and now in Debian 13 it is obligatory
> > reproducing not as restarting but freezing with black screen and on any kernel
> > 6 version (also 6.16.3+deb13-amd64).
> > > To help for other with same hardware, since I can fix that for myself if I
> > > need.
> > ??
> ??
> > > > For now your problem report isn't in a form that I can act upon. So it's in your interest to provide the
> > > > information that I ask for. If you don't want to do that, that's fine,
> > > > and I won't have sleepless nights about it. The likely outcome is that
> > > > the problem isn't addressed.
> > > Whether I don't provide you all information beyond "get my hand in the
> > > dirty"? :)
> > ??
> ??
> > > > Parts of the misunderstanding here might also be a language barrier. So
> > > > maybe try to get some help in the kernel community that speaks your
> > > > native tongue.
> > > So, English isn't native one for you? :)
> > Right, and I doubt it's yours either. Or you would be the first native
> > English speaker in my career that I fail to understand when
> > communicating about Linux topics. (The only other explanations for that
> > I can come up with are a) you suffer from dyslexia; or b) you write
> > glibberish on purpose to annoy.)
> > 
> > PSA: This is my last mail to you for this bug until you come up with a
> > statement like:
> > 
> > 	I tested Debian kernel image package version a.b.c-d and its
> > 	broken with the following symptoms: [....]. The kernel image
> > 	that occurs in the list on
> > 	https://snapshot.debian.org/package/linux/ directly after that
> > 	(i.e. version e.f.g-h) doesn't show these symptoms.
> 
> As if I need your messages with your dyslexia... :)

The discussion here is derailing. Roman, if we want to have the issue
fixed I support Uwe statement thate we have you, with the affected
hardware, bisect the upstream change to isolate the fixing commit. 

Here are the steps which roughly are involved. Confirm a upstream
version which does not expose the problem. Ideally first though by
using the snapshot.debian.org service as pointed out narrow down more
closely the upstream range where things change. Once you have a set of
kernel which are close enough start bisecting the change. Let's take
te following hypotetical versions, working kernel v6.11 and not
working kernel is v6.12.

|     git clone https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
|     cd linux-stable
|     git checkout v6.11
|     cp /boot/config-$(uname -r) .config
|     yes '' | make localmodconfig
|     make savedefconfig
|     mv defconfig arch/x86/configs/my_defconfig
| 
|     # test 6.11 to ensure this is "good"
|     make my_defconfig
|     make -j $(nproc) bindeb-pkg
|     ... install the resulting .deb package and confirm it successfully boots / problem does not exist
| 
|     # test 6.12 to ensure this is "bad"
|     git checkout v6.12
|     make my_defconfig
|     make -j $(nproc) bindeb-pkg
|     ... install the resulting .deb package and confirm it fails to boot / problem exists
| 
| With that confirmed, the bisection can start:
| 
|     git bisect start
|     git bisect good v6.11
|     git bisect bad v6.12
| 
| In each bisection step git checks out a state between the oldest
| known-bad and the newest known-good commit. In each step test using:
| 
|     make my_defconfig
|     make -j $(nproc) bindeb-pkg
|     ... install, try to boot / verify if problem exists
| 
| and if the problem is hit run:
| 
|     git bisect bad
| 
| and if the problem doesn't trigger run:
| 
|     git bisect good
| 
| . Please pay attention to always select the just built kernel for
| booting, it won't always be the default kernel picked up by grub.
| 
| Iterate until git announces to have identified the first bad commit.
| 
| Then provide the output of
| 
|     git bisect log
| 
| In the course of the bisection you might have to uninstall previous
| kernels again to not exhaust the disk space in /boot. Also in the end
| uninstall all self-built kernels again.

I'm closing this bug along. If you can provide the above version
please respond to this message with the required information and a
control message to reopen the bugreport.

This is how you can help to resolve the issue in my point of view.

Regards,
Salvatore
