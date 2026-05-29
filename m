Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C355CD6E61
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 07:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5630D112EE1;
	Mon,  1 Jun 2026 07:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="gBzvedso";
	dkim-atps=neutral
X-Greylist: delayed 307 seconds by postgrey-1.36 at gabe;
 Fri, 29 May 2026 13:40:11 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A8510FF50
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 13:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780062010; x=1780666810; i=natalie.vock@gmx.de;
 bh=YQj1HONTQu7BXomQ9jAvJgSWK1ZgQHE716MbR/20sck=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gBzvedsoq5n0FvizNFtS9tJAfbacjaP7a9Y54UW9Erd3xYj2q10qCJEx+bpOZ2S8
 m489jW2MnhAMMyD5Koqdw2GpNJpNzDoEz0/O/RhFbwSPg7dKkOwidOfb4iNz/Lw82
 OrvedbMpgbmtdkjxMSkQ/eZ07JviwJuRdvnCAX6UqfgZshlSfnPaJBKOavWeitiI0
 vXTNQHn7nrp6RCZ1/XSWKTeYbrwd3gDEPZL3cNYiJiRKGVcGuuFPYUismmLLflyVL
 HYAuygzYiruOnelgB3Ccrwbk0+EE3jNOHIcqNuANk6dKL2WdOLBnBJvoLkFyrpO5A
 QD192AGvKwzsqReUaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUm7-1way7e3biB-00F6T2; Fri, 29
 May 2026 15:35:01 +0200
Message-ID: <cd38abfa-25f8-4c9c-91b9-051723ab8476@gmx.de>
Date: Fri, 29 May 2026 15:35:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: VM reworks
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 honghuan@amd.com, Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260529114031.3714-1-christian.koenig@amd.com>
Content-Language: en-US
From: Natalie Vock <natalie.vock@gmx.de>
In-Reply-To: <20260529114031.3714-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+mOp48ixBZ0f+eaIJUdBu0EkMzdsB/Ds43dVsz+Pa3X3JdIeBSx
 fx6uxdKBU+/PkMzjOhUzXazsfQY3tO+0AzkwWbKyAz9H911Jtc4zUbLqGa5J46klEY+dRek
 Ifnk29RSY4/60QLEPcHZfLJg6/l72rik0dbE8Ukx794DheGcrqc/AGfmxBMudhz0VdclFLl
 B9mk0795ZI7LzilW/f/Ow==
UI-OutboundReport: notjunk:1;M01:P0:GeBb73p2rYE=;ixd2bx8RltI1AwEXlcdiTxTrJ2t
 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
 WX
X-Mailman-Approved-At: Mon, 01 Jun 2026 07:27:37 +0000
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

On 5/29/26 13:24, Christian K=C3=B6nig wrote:
> Hi everyone,
>=20
> this patch set aims to fix a couple of problems we still have with the V=
M, page fault and HMM/SVM handling.
>=20
> First I rework a bit what we have on headers/defines for the suballocato=
r, especially that the right GFP flags are now used for GPU reset and grap=
hics page faults is important to avoid hangs.
>=20
> Then I rework the VM handling, especially splitting up the amdgpu_vm_upd=
ate_range() into an amdgpu_vm_map_range() and unmap_range(). The later is =
only meant to be used for MMU notifier/HMM/SVM use, but I couldn't come up=
 with a better name.
>=20
> And finally it fixes the problem with KFD SVM that we can't properly all=
ocate page tables under the SVM lock. The missing piece here is to remove =
the SVM lock and rely on the eviction lock of the VM for that.
>=20
> Timur & Natalie I've put you on the patch set because I know you have pa=
ge fault patches in the pipeline, it would be nice if you could apply this=
 set to amd-staging-drm-next and rebase your stuff on top of it.

Thanks! I just finished drafting up a patchset for explicit sync of VM=20
unmaps, I'll also rebase it onto this patchset.

I also sent the current state of the patchset to the ML earlier=20
today[1]. That patchset includes a non-trivial rework to add a "context"=
=20
struct to VM maps, in order to track changed/freed VM mappings on a=20
per-operation basis. Happy for feedback on that approach - if there's=20
something to rework I can roll that into the rebase right away.

Thanks,
Natalie

[1]=20
https://lore.kernel.org/amd-gfx/20260529-prt-explicit-sync-v1-0-9f1c60955c=
ab@gmx.de/

>=20
> Honglei and Philip this is basically the pre-requisite work I have been =
talking about. Please integrate that into the new SVM patches and re-test.
>=20
> I've only did some very brief testing, so something more extensional tes=
ting is clearly a good idea.
>=20
> Thanks,
> Christian.
>=20

