Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556FAC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 13:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46DC911BEE2;
	Thu, 30 May 2024 13:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=devnull.tasossah.com header.i=@devnull.tasossah.com header.b="VVUcjEeK";
	dkim-atps=neutral
X-Greylist: delayed 323 seconds by postgrey-1.36 at gabe;
 Thu, 30 May 2024 10:36:37 UTC
Received: from devnull.tasossah.com (devnull.tasossah.com [91.121.165.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5590110E00D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 10:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=devnull.tasossah.com; s=vps; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jehkgjsS75YvkuNGPSG2iqWlxgF/EISe7OE3u3S4EA0=; b=VVUcjEeKm+RTq5W+KlNr66y0MQ
 rpbQ3OssHS6xTR+F2k9eFD0DdINeYwYObwcYePgEImpxlpWziInEsY5Z3HqvkJYtI1HkIOrHGeeLl
 pj9kPqoXmY77bT5f0eGsMXzCZ/54OuhsnazfQqc3MzR7ipZLoGLhpiRIEtBSJ8Sy5j4E=;
Received: from tatokis by devnull.tasossah.com with local (Exim 4.93)
 (envelope-from <tatokis@devnull.tasossah.com>)
 id 1sCd3v-003u4M-H8; Thu, 30 May 2024 13:31:11 +0300
Date: Thu, 30 May 2024 13:31:11 +0300
From: Tasos Sahanidis <tasos@tasossah.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu/pptable: Fix UBSAN array-index-out-of-bounds
Message-ID: <20240530103111.GA930046@devnull.tasossah.com>
References: <20240523071637.1114898-1-tasos@tasossah.com>
 <CADnq5_MAPCEO4mNouRHnPMy5-OPXyN1cjy4Ub_xVip4m8x4OZQ@mail.gmail.com>
 <d064e35f-4990-485b-9426-a4f5ab9f3375@tasossah.com>
 <CADnq5_OX52-0Enb6E1qDhDZ-G-Sd3cgGF5hUouofgkq7VzK1_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_OX52-0Enb6E1qDhDZ-G-Sd3cgGF5hUouofgkq7VzK1_Q@mail.gmail.com>
X-Mailman-Approved-At: Thu, 30 May 2024 13:02:22 +0000
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

On Mon, May 27, 2024 at 10:47:39AM -0400, Alex Deucher wrote:
> On Mon, May 27, 2024 at 5:42 AM Tasos Sahanidis <tasos@tasossah.com> wrote:
> >
> > On 2024-05-23 17:52, Alex Deucher wrote:
> > > On Thu, May 23, 2024 at 9:05 AM Tasos Sahanidis <tasos@tasossah.com> wrote:
> > >>
> > >> Dyanmically sized arrays used [1] instead of []. Replacing the former
> > >> with the latter resolves multiple warnings observed on boot with a
> > >> BONAIRE card.
> > >>
> > >> Signed-off-by: Tasos Sahanidis <tasos@tasossah.com>
> > >> ---
> > >>  drivers/gpu/drm/amd/include/pptable.h | 24 ++++++++++++------------
> > >>  1 file changed, 12 insertions(+), 12 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/include/pptable.h b/drivers/gpu/drm/amd/include/pptable.h
> > >> index 2e8e6c9875f6..d1dec880d2d6 100644
> > >> --- a/drivers/gpu/drm/amd/include/pptable.h
> > >> +++ b/drivers/gpu/drm/amd/include/pptable.h
> > >> @@ -480,7 +480,7 @@ typedef struct _StateArray{
> > >>      //how many states we have
> > >>      UCHAR ucNumEntries;
> > >>
> > >> -    ATOM_PPLIB_STATE_V2 states[1];
> > >> +    ATOM_PPLIB_STATE_V2 states[];
> > >
> > > Can you add __counted_by(ucNumEntries) to the end of the line? E.g.,
> > >
> > > ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
> > >
> > > Same comment for the other changes below.
> > >
> > > Alex
> >

Apologies for the delay. I realised my compiler actually didn't support
the attribute, so I had to install clang 19 from git.

After doing so, I saw this warning about ATOM_PPLIB_STATE_V2.

drivers/gpu/drm/amd/amdgpu/../include/pptable.h:483:5: warning: 'counted_by' should not be applied to an array with element of unknown size because 'ATOM_PPLIB_STATE_V2'
 (aka 'struct _ATOM_PPLIB_STATE_V2') is a struct type with a flexible array member. This will be an error in a future compiler version [-Wbounds-safety-counted-by-elt-type-unknown-size]
  483 |     ATOM_PPLIB_STATE_V2 states[] __counted_by(ucNumEntries);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thus I'll remove the __counted_by() from that one.

> >  }NonClockInfoArray;
> >
> >  typedef struct _ATOM_PPLIB_Clock_Voltage_Dependency_Record
> >  {
> >      USHORT usClockLow;
> >      UCHAR  ucClockHigh;
> >      USHORT usVoltage;
> >
> > All the other ones are UCHAR, so __counted_by can not be used on them.
> 
> I'm not following.  Why not?
> 
> Alex

If I'm not mistaken, for a UCHAR flexible array such as clockInfo[],
we would then need to multiply the count by the size, which results in:

drivers/gpu/drm/amd/amdgpu/../include/pptable.h:494:36: error: 'counted_by' argument must be a simple declaration reference
  494 |     UCHAR clockInfo[] __counted_by(ucEntrySize * ucNumEntries);
      |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler_attributes.h:105:62: note: expanded from macro '__counted_by'
  105 | # define __counted_by(member)           __attribute__((__counted_by__(member)))
      |                                                                       ^~~~~~
