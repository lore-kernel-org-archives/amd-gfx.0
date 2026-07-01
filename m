Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DB0C43327
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 08:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7703C10F1ED;
	Thu,  2 Jul 2026 08:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="BXBTqTUk";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD7B10EF04
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 11:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782905638; x=1783510438; i=natalie.vock@gmx.de;
 bh=6O3VyoprwvQdHEFnrRxtwacSWvdL5gugEf8Ue1Oc4pA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BXBTqTUkbylSgxBxL3BiguoULnt8w4oT8IunmxSM7vTE5hBZDKrxkpTzEr4ISBak
 CmZvS4GwXr+2MJA3AFgC1/zPK6uv/PjiF22eYXFxNPCU7pi5tmUELEy/3o2MSi0R5
 xJG/y20s4eC4kzQccwCi2jmaxsEVdspbtH98lfiuGlw1K9uiBELd5hqZSA13hWGxw
 oNEKl4CpNWSZzw8qfAYUPNZaD8Z4x+iOrI1VQyfrb8KYeP2a1WgDhj0VYF1MSKpTP
 m7yTZrTUn/LY2DuqMuzBhFXyiUizXO53fOlLfKoZOiUp69DOo1pVgZ28GgmUjX/b1
 m4eh9bQEOe3QnJv6vQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEFzr-1wmpgB1A8L-002UUZ; Wed, 01
 Jul 2026 13:33:58 +0200
From: Natalie Vock <natalie.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Fix VM status/vm_bo->moved locking
Date: Wed,  1 Jul 2026 13:33:39 +0200
Message-ID: <20260701113340.466177-1-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:imEgbKcHbBpirhBfU8Sp1IKIIqahy2WolBlyTOytBJ/nx53hgqV
 3wz0xMqIUJGqMx299mgylaeFbVEJ32ji1kGgprGMxICIZZYPf+R4ITp2tOzxj/+Da8aM9Ph
 o8qs+JbZbACLWs8AGTa2cQQVYIpzebWW8bA5166T9Qw3zO2Dr9mMn/B52B8lctct+L72uJn
 6Qb6WSnuSxT2LCLIMQ+Mw==
UI-OutboundReport: notjunk:1;M01:P0:ie1rL7Xxm0U=;kdPQqYN3iwDGUjfXUPp8tWr5074
 GB7F1xiI7ZamRdETb1VhCi/EEoW+HqIkah+NUgr2l0+gLqJBpFLRJhdECzZ8kguRZ3daUetUG
 oMY81wFw0xQdLXND7fIeIJBp4O03GbaAlL07FIiFUtbFmvLcDtcWPnluy4UmoZpdZkBlZC7tV
 bUmrn0LP0RMzYYx264D1G+r4oJEUWAS3e1KH39tGWHXsMhd7RbNSopN1azW0gEjLeRcxS8Doi
 ZZX0ZGl7X5ZUVQWmf+gAM0umEZGzKMMJ5ZrrM5sxAMeLfbvTOAOUhWdouaLo4/ir3YjHWH9Wl
 OzqhDgxpqOyPmKyBYzz7ztkXWGLqQBxe6n+v6zmfXcPiNUp0V2MgMKkyJ8YVSUBHwN169XehX
 qzTKDzVlkDIgcfY+1MuEQcPrV5KPc6sARtWKrERTbdobl0QJk2xFYVSR2mYEqaKVWFh4h4sgE
 BJVlq2i/j1qAt1dYjtvQRsa7JCF2h6tq1+uMjWWAEbvQHcIlMriQHopUuwqBrS7cZPd30vln5
 CP8vIUSGlSWDBfIPfHM3kLVEd3cNJXeCLqZdPx7UBNEunAlXpPoRMvl88b3XU+VqoZhQhGp5B
 DONWcBszrlV79arWCsQSWOmYBZ2aiSfRL6LfDw1DMjn7a6RfauubD6Sc7UGsm30dvO401ALxF
 t1/OJRtUVuy5ygfg3SCcmqH5Oe9Q9sTyVqfDljJYEdDBsXPdnk/6TBmcmWxUFvD6YSEEmiwnw
 BcIcMjaP4UPMQNjYv/Dn7YP57s/bjPC408fdX9UxhZCYJsaQy5PvIamqoZ8xMKgeopBtdaUum
 BcUHB4vRCIchwX869Xza3MEspQ0CdtyLMIiI4qTiM4URkvh7fjY033+PhTSXxlecCB6WNTxo2
 mE1qStHMQboYenFQ7XzS/08MaGoJF/AvNyNvCBTCmwegNosgSBQLac7+kWQn0zKoTNthn4r5v
 3I32gFefG2PAaLSPuid654ibw99o854a1Mj6l6LyaEjyZzDFiHZrh1d83OC+hrCL6xch9P6DW
 y+FzF/TPlHSx1DEYJ5N7ND9qD/5rbF/bEorXH9D7WaAMorz4nbLidck6osfNj7CPg9bhDQ4PI
 c8kDGga2rkJ9z6dSkk6enIOaQ206GJdYNn7GalR9Ru+UeKVUoBGnWDwQwxSRHyFdB9RW9LjGk
 h9GdSOR9NT7PzUbjm73OYQ7k8LxYCHevRm6AlDfbwXRC7UEm9y0AhYZ6Q3IcIR9fCsji9uolY
 7D9zaQUBy4f3haaE2KF4GHWhU5ROIB503Kqb7jknM0BhOxafgZ9Trsa2vJG9do+JJwm7Y3mzC
 7j2YlSYxOSSQ4zMCLNPKvbb52ip+nsMwJY6W65bz2rQfT4qnA3Ug/YOav+dKuwvKvzrieuP+j
 sQ8/1wKpS/PRPKydKn8cFZEuNTge5bj4f9bZM7Y4Nc2zU4Ln3IV6XRt3L1lbpPdwjuFVVLO1z
 tUbqKxdbIKTO/OnwI26mAGItmfYcoAg7My2aNy5okP0YnLalzo/ZFPPvekIcsc73Xo/jU0Kht
 phEdAoOLi1klJrXrhKWYyH4NMOgNzSvnZ6bxU0ssKkS49Oh4tcgFnHYZIb5Bu/71FVFUo3S8/
 8ZSvPbzXCGZVosw3caVrx+ftF3MRsbM4dw7jBGbh3Vomv+J3ASz4iDPtgUgGVnNNUnz8lI5sw
 JhyvFSH9ZA6he9pjkWNaladddSmxcttXv4jEofUHoZ8yqC8+xwHPPsmw1LzjmF2LPj9RVQVDI
 FQjYi2fK9EnbDfccCA7lnDba+ToTRUwXC60Xw4VjX1J3buCWDOHarVPHXYL/5U8m5jqRuUAAi
 UgtGiy2ag9X8GvUPEEJ0uh872HriPLIiQ7rKTQB9Li5gIejS33z6do8tKUTstxYvObkGO1Eqf
 vK/aSP9iTzDD2/JC6B3eeFW10RbdkV9M82I8TiaEmp8RJKchXfTfkJev617aKxPpur4vmo0Vd
 /vhRIT0tNd1j1gihWbvsAvsnYcvJYYFB9BdvPN8iEArrXApOnp8OuhcjFmXptRxdchtFtX19b
 JbCOejo6SWzOXhBE1yLFLLv+9IJIUN0uFuOKvHlkW9mtm5LHUiSvJr3Jewew6fK0+k1lX2jEc
 wIeLRhzfhB5EbilUxIl7JPjOzZvKOtEiXG+QEM6mMHo4N/vnKcc90Ba4K53v8lA76v/Pgcs5j
 /GNAyJEiCk0/HzGQyQuPOjQq4its8DQSE4XEdnAhErEzXj802B12s66P4QEQjpsXqi+ci6dOe
 IQrDbfxqlBmNaa7MBtCbiUH3WFa766p17GKhhu2YoJKocATxUc6ls0f4GFyqG34cKEZLQ9BhM
 KSibzT0d2Lp7R+Om0u2LDOHWJab8zEyYU3d0YqFgExCnDqe9a1UQol1Yqfdxg2uj9h47lTE35
 CvMA6tlNaWGFaFF+BtiwZO/39w0s2FCzNBnxVQUn9r+RRHM69tSFx9YcqY6xoIGMiWdSMxtN4
 CApVRNEN+ia6qLCvA59Ib+vq0mpEr18hbfnKZxD4dCM2jF8OBUf7NHDOU6iR3MFrfeBuOCtkN
 AmXl88vBFMBUpdz3bo0ZdAqEX60H19L4DWlMq+ODs8wIuOXiUQCSOk914KBdQPyT+4rCmb58D
 Slj4/iL+YFFZ1ONw/Lxs9dAzPvoyRg9ClXAqGN8/GqsKYg5pW48ji/Cqzvjviolo8N+vqcFB1
 PWOaFbRAAnPtyf6J8yaSnl458DJvAI320ETfEib5RzU4mWhy89IZHcEAXGr/ELU9dCjtYD9nC
 apoti1PiLxBy4xStQ0jTyLf+2h/B0533vSKjMyfJVrMkAQ4VqsgYA5eEFn8fGfR90r/fpHrHA
 UIYv6dHmC2/ipRNHxe6MAxqzBHZ9l4K+vHooSk+Q34XEtcbg2qutQPSsFwIhlu4qjQaLSZnKh
 B2vebSlrRW0tMFg8RoXy6v8vtOFZODydsGFX40PKGBrun7TwMUH4O1mEMJ0eUJYNCQ29RtoXz
 JbEFZh39cybMitu8HjkAKyYebJn9HVcr0P+4Gq8rliC5/zHF1thqSuFHtWPimRc/VW+5cqNew
 GutpFNgRVUGv6GymNJR0vjAX1wcoF4EQn2GZGaA46zT52FMCshnp/EtoXNo4trM+3tFwQg6dj
 AdzJbVPkNkfjaDvP3G+3Zvx8neR4/3uInL9emM6m6sdUi1HYudzvuBMgGHhEZEcJUAf+ULMUh
 48mXc1ZmcIj/tbc/L+qD2NHkZ6FxHIKFjhf+RNQoVVTtfVoC6TFsQrP61mdT21YJMDon9GTe/
 H188Jx+OM8PbICcztY5WxKpG1H6QQJfMRtymx3HwZ1mezICSgJQrQIu8VcYrWy2O9ZrkUWgmF
 BmwPoJkmxRypXEUUCcGXpTXqt9JZ6orUpIhRcsn+GjsVPMC06Fx5zBdPloBRNmPOH76Xukx8J
 Aqz/QSXYoN4zI5OJbfMD/gMsAKZe/yymPZxvSQ6PqYeuht5XP0R629V/iOyRlizvJh4zsHgc2
 +NhHiG7JsROMTlpPSOXij+JDYGjUIApcupqjvblyuH9pJTZpSdkpVqxDXpf5FX0blnrChMW9Y
 9PN4ryEdj2+qrjdoI7x2E8qfwygVE5B6mJ7YVLH/oNhZHstYTaxkyHfZQq5DnFzaIi2Zj3T8d
 i/8F+tC4/4ZXdUVsj+nMrEK9UvFlgKxc9ibe1tpGs4++oerx0VD7aXHx3A2gs26X1JOze6LYn
 wEbvC7cKFVGYBg/MYarYZpG8w7g25jSuy+DOZZtZVdRyGsRfiPq5KWutHO5FHRgL3GF7IJzFS
 sFG0im6y366roFiZKV5OFVQI2cEejHsxUUhC/g5kivcvIIhGo6cVjA6NyKofQTjjn25VngOb+
 mrI6LQAdvEZsAIXApvpn1Wm9Kw67ffV7VP4v51jUcyYaHdOeVONg+Z8PMcs1OF0UwGnnnmmg7
 V8ljgAEfh3lYqhvFvP2CnrznqYrSs/13++1IjOT9ZDxNzsU+wHM1FE5d/Q9fRo40ucJ8xxwQ1
 jtIkd469R+Z5XTIItwEPsv4ciF18wVflTX5exHWbv1GLBoNYi+Q3wMDAuvhz2U7exhuZ6fp3u
 rg4IPgEYvQmpP6Ap7tzmeP8bdZD0AQ52joiPANtCDGHelnmT/MePiqRFepJeWL1bm52PvyBj/
 OWL894EHUY1Gay98iwejpvXT9unNqgXlUS3gvRMR/UtFqcHgS5ivvQJJrcHeMeyUxY7nLqhI+
 w058QLRoRGI45tii6nVnnYfm+3h3e4EhSbbi2RXWNoXi3Rs93txgNL3bXFlvQRAmtYFyN70yI
 kpehNUjUiDHknNL5pLs0ZQOdvC5Xso7HqqZNen3/eywRuYHEfkvJJgu0MxzkXVNLmqVfYNZ9I
 kS6OPpxyOydkWbyKYwLbkUGXq+DCuHwVHIpLJVa9QtDp7XNJdsX3GOLE+PeeGqPpIeuz+6+NV
 A9rJ/+9gZ8i0rF9T4P9hD7ub3R1F47KZK76yoPZwR/YSM7TvnBmNcb0V+DjCkFGrhYBrh7dOH
 CvRYthEjI4oy7IJLgu/wuIsp+bizPvW9RHHONUbgXR8bTP3pwplveN6xPjzzmjTA11QcxUvOV
 EwEeW8Zl2Dssl9lv2674Q7eqIRyDnNMInF8VjlF54HsRdaWqmUuMVv432zAJQzfDDFJntbHmI
 Gg7SUx3QAR8XTOsWZZp9jbRyB2ArSpjHK9dXf8J00lViDzwPyweSuceDTMvasKxbifuCeUALA
 BWmQDUJxFfPj7wZLNR1EFuqSyE5xoKB+aShSyH5nhz7q9tSGA4ZehVAagzeJO/gHuYK1otkFd
 ibtvno+LflJUNVbjJWldo35saREe0oz2BpB6gdWzgmesIYsBCCa3oNgvaF8mJv9H8imU4jCFl
 G+RO4N2mV4Vltmo0Wttkn8uLsO9Do9eUnZKbVvqdNu+uzOoShpnjiASJk1DUl1iBawZu2S6A2
 mYbRg8sZP44Oqm+Biqxa+LRtC8XNWtvvVN7t/hzPT5+BB+f1er6MNINT3pdHc06CmhV70A9oU
 Bm6FYHNp+2uJpVW9Q/lNRvX5vC7nfUH4lj3EWEuMOynLQuNxEj4v4ZWXvTGgJSpViLZyLi+QE
 HumgrNo+fH0IYO+MgfxOg4/+3OvLUOwkFUz1TMs/FaFucMd/tlL/tw9LTuXGt9YzUWTX9EQz+
 7xhWZF5xKvZwbYIAbn2SUX5GDd8jFheMcJHCC6Scf89vRpm3Fn+737j2DJZnkEJqHkAfwu12A
 LltKDkw6ApOmN5v6/A9r33dD0vddqEf1I1AeIpxrbhsaNI7mASVSasKlLABmERJu26FH3HCvJ
 V6+LvhJ3iNhdlkr6pVrTqLY4Aa2WwBxelvusYN+DEhExzBz9nbK5CQRMd51HSx0WpO6HUVoMG
 cpDroDWweElNgy1Ui/c1LjYCmfSwWPShG8uhogfE2UqEi3A9Mv54fbAFggTE62XWYp5SL0vcY
 jlM9pSdO7EQZ/3D0xuMYQXmaAjGr13G5i5GXe6kbHDtlhwFnTr3fHbhYdZ56Q1fhyQkS/2/+z
 nVvpTXZtAkZtJrZ05NiYaROoQmgLKh2bOXpozvNvFTTSut/9YO65PiLMe6te4naCvzwtWwwii
 cKily8chy6GdWe0fzeikobXKCgySI0OO517j2NsZjETeM2KrOgyiUTfRO+kAzb9VXMHvxSVpY
 OpMkIb8a4AvAvxKEfru8R+OppLNciDIqA2lpa+BT2EQBCrBIDufOQ2Jkmyg/w==
X-Mailman-Approved-At: Thu, 02 Jul 2026 08:07:22 +0000
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

We claimed vm_bo->moved was protected by the BO being reserved, but then
accessed it in a bunch of places without a reservation to the BO anyway.

It's not sensible to protect this by BO reservation in any case - it's a
property relating to VM state, just like vm_status. Let's protect this
by vm->status_lock as well. We usually grab the lock at some point when
we access the field anyway, so it fits well with the current usage of
the field.

We also need to remove some unprotected accesses of the field when
removing a mapping. Checking for the field there was a microoptimization
anyway.

Lastly, and most critically, we also need to handle buffer
moves/invalidations racing with amdgpu_vm_bo_update. Otherwise we might
accidentally undo the invalidation without the PTs actually being
properly updated.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
FWIW, I'm not 100% positive on whether the Fixes tag is correct - I'm
fairly certain the VM update <-> invalidation race existed ever since
the driver's inception, but it may have been hidden in the initial
revision. I suspect backporting it all the way to wherever the race
started manifesting is roughly similarly painful, though.

Also, this patchset is based on my previous one to rename the "moved" VM
state to "needs_update". I think it got reviewed and should've been
picked up, but I'm not sure I see it in amd-staging-drm-next?
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 108 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   3 +-
 2 files changed, 75 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vm.c
index 32719f31b6c9e..3451dca7de194 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -214,11 +214,12 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo=
_base *vm_bo)
  * amdgpu_vm_bo_needs_update - vm_bo needs pagetable update
  *
  * @vm_bo: vm_bo which is out of date
+ * @moved: whether the vm_bo was moved
  *
  * State for vm_bo objects meaning the underlying BO had mapping changes =
(move, PRT bind/unbind)
  * but the new location is not yet reflected in the page tables.
  */
-static void amdgpu_vm_bo_needs_update(struct amdgpu_vm_bo_base *vm_bo)
+static void amdgpu_vm_bo_needs_update(struct amdgpu_vm_bo_base *vm_bo, bo=
ol moved)
 {
 	struct amdgpu_vm_bo_status *lists;
 	struct amdgpu_bo *bo =3D vm_bo->bo;
@@ -232,11 +233,28 @@ static void amdgpu_vm_bo_needs_update(struct amdgpu_=
vm_bo_base *vm_bo)
 		vm_bo->moved =3D false;
 		list_move(&vm_bo->vm_status, &lists->idle);
 	} else {
+		if (moved)
+			vm_bo->moved =3D true;
 		list_move(&vm_bo->vm_status, &lists->needs_update);
 	}
 	amdgpu_vm_bo_unlock_lists(vm_bo);
 }
=20
+/**
+ * amdgpu_vm_bo_idle_locked - vm_bo is idle, already-locked version
+ *
+ * @vm_bo: vm_bo which is now idle
+ *
+ * State for vm_bo objects meaning we are done with the state machine and=
 no
+ * further action is necessary. Needs to supply a locked status list.
+ */
+static void amdgpu_vm_bo_idle_locked(struct amdgpu_vm_bo_base *vm_bo,
+			      struct amdgpu_vm_bo_status *lists)
+{
+	if (!amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
+		vm_bo->moved =3D false;
+	list_move(&vm_bo->vm_status, &lists->idle);
+}
 /**
  * amdgpu_vm_bo_idle - vm_bo is idle
  *
@@ -250,9 +268,7 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base=
 *vm_bo)
 	struct amdgpu_vm_bo_status *lists;
=20
 	lists =3D amdgpu_vm_bo_lock_lists(vm_bo);
-	if (!amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
-		vm_bo->moved =3D false;
-	list_move(&vm_bo->vm_status, &lists->idle);
+	amdgpu_vm_bo_idle_locked(vm_bo, lists);
 	amdgpu_vm_bo_unlock_lists(vm_bo);
 }
=20
@@ -273,9 +289,9 @@ static void amdgpu_vm_bo_reset_state_machine(struct am=
dgpu_vm *vm)
 	 */
 	amdgpu_vm_assert_locked(vm);
 	list_for_each_entry_safe(vm_bo, tmp, &vm->kernel.idle, vm_status)
-		amdgpu_vm_bo_needs_update(vm_bo);
+		amdgpu_vm_bo_needs_update(vm_bo, false);
 	list_for_each_entry_safe(vm_bo, tmp, &vm->always_valid.idle, vm_status)
-		amdgpu_vm_bo_needs_update(vm_bo);
+		amdgpu_vm_bo_needs_update(vm_bo, false);
=20
 	spin_lock(&vm->individual_lock);
 	list_for_each_entry_safe(vm_bo, tmp, &vm->individual.idle, vm_status) {
@@ -435,7 +451,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *=
base,
 	 */
 	if (bo->preferred_domains &
 	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
-		amdgpu_vm_bo_needs_update(base);
+		amdgpu_vm_bo_needs_update(base, false);
 	else
 		amdgpu_vm_bo_evicted(base);
 }
@@ -607,8 +623,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 			return r;
=20
 		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
-		bo_base->moved =3D true;
-		amdgpu_vm_bo_needs_update(bo_base);
+		amdgpu_vm_bo_needs_update(bo_base, true);
 	}
=20
 	/*
@@ -625,8 +640,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 		if (r)
 			return r;
=20
-		bo_base->moved =3D true;
-		amdgpu_vm_bo_needs_update(bo_base);
+		amdgpu_vm_bo_needs_update(bo_base, true);
 	}
=20
 	if (!ticket)
@@ -646,8 +660,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm,
 		if (r)
 			return r;
=20
-		bo_base->moved =3D true;
-		amdgpu_vm_bo_needs_update(bo_base);
+		amdgpu_vm_bo_needs_update(bo_base, true);
=20
 		/* It's a bit inefficient to always jump back to the start, but
 		 * we would need to re-structure the KFD for properly fixing
@@ -1266,16 +1279,38 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev=
, struct amdgpu_bo_va *bo_va,
 	struct amdgpu_bo *bo =3D bo_va->base.bo;
 	struct amdgpu_vm *vm =3D bo_va->base.vm;
 	struct amdgpu_bo_va_mapping *mapping;
+	struct amdgpu_vm_bo_status *lists;
 	struct dma_fence **last_update;
 	dma_addr_t *pages_addr =3D NULL;
 	struct ttm_resource *mem;
 	struct amdgpu_sync sync;
 	bool flush_tlb =3D clear;
+	bool uncached, moved;
 	uint64_t vram_base;
 	uint64_t flags;
-	bool uncached;
 	int r;
=20
+	/* Everything we access in here is protected by the VM PD lock. */
+	amdgpu_vm_assert_locked(vm);
+
+	lists =3D amdgpu_vm_bo_lock_lists(&bo_va->base);
+	/*
+	 * We can't hold the spinlock for the entire VM update, so temporarily r=
emove
+	 * the BO from the state machine entirely. This does not prevent all typ=
es of
+	 * races: We might not hold the BO's resv here, so TTM is free to move t=
he buffer
+	 * and thereby invalidate it. However, it allows us to detect if we race=
d with
+	 * something that invalidated the BO again and handle that appropriately=
 below.
+	 */
+	list_del_init(&bo_va->base.vm_status);
+
+	/*
+	 * The moved flag is also protected by the status lock. It's fine if som=
e buffer
+	 * update changes bo_va->base.moved while we're updating the PTs after u=
nlocking
+	 * the status lock, since that also invalidates the BO's VM status again=
.
+	 */
+	moved =3D bo_va->base.moved;
+	amdgpu_vm_bo_unlock_lists(&bo_va->base);
+
 	amdgpu_sync_create(&sync);
 	if (clear) {
 		mem =3D NULL;
@@ -1343,7 +1378,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, =
struct amdgpu_bo_va *bo_va,
 	else
 		last_update =3D &bo_va->last_pt_update;
=20
-	if (!clear && bo_va->base.moved) {
+	if (!clear && moved) {
 		flush_tlb =3D true;
 		list_splice_init(&bo_va->valids, &bo_va->invalids);
=20
@@ -1389,20 +1424,38 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev=
, struct amdgpu_bo_va *bo_va,
 		else
 			amdgpu_vm_bo_idle(&bo_va->base);
 	} else {
-		amdgpu_vm_bo_idle(&bo_va->base);
+		lists =3D amdgpu_vm_bo_lock_lists(&bo_va->base);
+		/*
+		 * Now that we're holding the lock again, check if the
+		 * buffer got invalidated while we weren't looking.
+		 * We initialized vm_status to an empty list head above,
+		 * if that's still the case we can safely mark the BO as
+		 * done.
+		 *
+		 * Note: We only need to do this for BOs that are not
+		 * VM-always-valid, because we hold the VM's reservation
+		 * which by definition reserves all VM-always-valid BOs.
+		 */
+		if (list_empty(&bo_va->base.vm_status))
+			amdgpu_vm_bo_idle_locked(&bo_va->base, lists);
+		amdgpu_vm_bo_unlock_lists(&bo_va->base);
 	}
=20
 	list_splice_init(&bo_va->invalids, &bo_va->valids);
 	bo_va->cleared =3D clear;
-	bo_va->base.moved =3D false;
=20
 	if (trace_amdgpu_vm_bo_mapping_enabled()) {
 		list_for_each_entry(mapping, &bo_va->valids, list)
 			trace_amdgpu_vm_bo_mapping(mapping);
 	}
=20
+	amdgpu_sync_free(&sync);
+	return 0;
+
 error_free:
 	amdgpu_sync_free(&sync);
+	if (r)
+		amdgpu_vm_bo_needs_update(&bo_va->base, false);
 	return r;
 }
=20
@@ -1779,7 +1832,6 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_de=
vice *adev,
 				    struct amdgpu_bo_va_mapping *mapping)
 {
 	struct amdgpu_vm *vm =3D bo_va->base.vm;
-	struct amdgpu_bo *bo =3D bo_va->base.bo;
=20
 	mapping->bo_va =3D bo_va;
 	list_add(&mapping->list, &bo_va->invalids);
@@ -1788,8 +1840,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_de=
vice *adev,
 	if (mapping->flags & AMDGPU_VM_PAGE_PRT)
 		amdgpu_vm_prt_get(adev);
=20
-	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
-		amdgpu_vm_bo_needs_update(&bo_va->base);
+	amdgpu_vm_bo_needs_update(&bo_va->base, false);
=20
 	trace_amdgpu_vm_bo_map(bo_va, mapping);
 }
@@ -2090,30 +2141,22 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_devi=
ce *adev,
=20
 	/* Insert partial mapping before the range */
 	if (!list_empty(&before->list)) {
-		struct amdgpu_bo *bo =3D before->bo_va->base.bo;
-
 		amdgpu_vm_it_insert(before, &vm->va);
 		if (before->flags & AMDGPU_VM_PAGE_PRT)
 			amdgpu_vm_prt_get(adev);
=20
-		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
-		    !before->bo_va->base.moved)
-			amdgpu_vm_bo_needs_update(&before->bo_va->base);
+		amdgpu_vm_bo_needs_update(&before->bo_va->base, false);
 	} else {
 		kfree(before);
 	}
=20
 	/* Insert partial mapping after the range */
 	if (!list_empty(&after->list)) {
-		struct amdgpu_bo *bo =3D after->bo_va->base.bo;
-
 		amdgpu_vm_it_insert(after, &vm->va);
 		if (after->flags & AMDGPU_VM_PAGE_PRT)
 			amdgpu_vm_prt_get(adev);
=20
-		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
-		    !after->bo_va->base.moved)
-			amdgpu_vm_bo_needs_update(&after->bo_va->base);
+		amdgpu_vm_bo_needs_update(&after->bo_va->base, false);
 	} else {
 		kfree(after);
 	}
@@ -2285,10 +2328,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, =
bool evicted)
 			continue;
 		}
=20
-		if (bo_base->moved)
-			continue;
-		bo_base->moved =3D true;
-		amdgpu_vm_bo_needs_update(bo_base);
+		amdgpu_vm_bo_needs_update(bo_base, true);
 	}
 }
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vm.h
index c1bd4d35831e0..0acd889568a38 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -212,8 +212,7 @@ struct amdgpu_vm_bo_base {
 	 * protected by vm BO being reserved */
 	bool				shared;
=20
-	/* if the BO was moved and all mappings are invalid
-	 * protected by the BO being reserved */
+	/* protected by the vm's status lock */
 	bool				moved;
 };
=20
=2D-=20
2.54.0

