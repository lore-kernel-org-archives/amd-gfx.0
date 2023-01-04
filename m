Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FC6C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 14:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F218E10E025;
	Wed,  4 Jan 2023 14:28:15 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C355810E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 14:28:13 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-15085b8a2f7so15237560fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Jan 2023 06:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ASi+0G12FiWEeESds7T7dVE3iXWzVujsQDtzo8zpIwo=;
 b=O+2PlaJCIRPsSKI0zO5D2MRRTmmfJd8d0pi5Dg+AXFykEUnkLye4JWNlKniq9OTSNr
 kC6LPmQS+dnWbzx88iLHDoDYdsIHlLD8Vwols8+NVL1NQGsqoYbpJ/o07iOWNsZraD1E
 YeyX/0WmcIyf5WR6qHjxt/WjQH9efymLzL1UlVfc59XYV/AuP0mrYWE4YpuZx3F0yJ0T
 RM+H+6Te/4NGSMOsplgp4ETY4GKHzlB37BuOsCtQ5JThBQ8rN0agYkMEx3Wybu0/kg9p
 Sl5IrpbQxYbsUoHC2bGrhhcLCTWn5zARM19+/7Y1zYWMfVUME97J3iv46tsw/J/nTVlq
 vAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ASi+0G12FiWEeESds7T7dVE3iXWzVujsQDtzo8zpIwo=;
 b=PsnseukBdAaB6+iU73IdmTSHA8EsZ/lwYdr96ytJLNO9xztM5rBY37ZwcnNYkH7TAH
 1KKj+3J4EtvQCoXWN97hTRbxussOgujAHZYup51UD7selOIqX8SloXHFtd1IikmdFQmC
 GgU9lcy7Q1mnzGcsLnhMdtizK0TVqlraiQ6Y/sl18IJxRW+UAAQESHADZEMU7Viv/UsQ
 B8WgVSib8XQxFGe0ked0mj2OreTC7Rjojzzt8hNCITkQc81msn5r/Azoedb5DrJ+YjhJ
 FU2dPQo+mjDoxgxhzL+I0dvIfAHaR8NAtKsc4KbXjDIGFaW4PMC2jIsAEmUmRiNMPa+A
 C8GA==
X-Gm-Message-State: AFqh2kqfnHgQxv8f037A/QtiYsKaub9uPdXNZvmMnAHEBxzXfhjqjuPg
 etiRzSjPCE/xw3BosKMkXmlpqGsR8hZFDqvZuE6Uyllz
X-Google-Smtp-Source: AMrXdXs1EOPsPSBRmvgXkBwNVWvxkz5nG4+LNQhbRbDZY3KixQccclwORJiX3CLzx8HIZpkvYZiy47tBN8LQpob/qFc=
X-Received: by 2002:a05:6870:970e:b0:148:3c8f:15ab with SMTP id
 n14-20020a056870970e00b001483c8f15abmr3952723oaq.46.1672842492997; Wed, 04
 Jan 2023 06:28:12 -0800 (PST)
MIME-Version: 1.0
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-4-shashank.sharma@amd.com>
 <CADnq5_NONiTu2oEEV1+epbuaH985QBbqMKuM9ZDYEn7Ar5a2pw@mail.gmail.com>
 <d19ada1d-86c1-7278-9bf2-a7571c2830e1@amd.com>
 <a71ce770-7e36-0589-2c47-b0381566541c@amd.com>
 <a75feb71-1121-63cd-5292-503588ee9c88@amd.com>
In-Reply-To: <a75feb71-1121-63cd-5292-503588ee9c88@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Jan 2023 09:28:01 -0500
Message-ID: <CADnq5_OpDdApboeX06fuLpX1w5H7JQn4ep75J=ajugKRZk=o-w@mail.gmail.com>
Subject: Re: [RFC 3/7] drm/amdgpu: Create MQD for userspace queue
To: "Yadav, Arvind" <arvyadav@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, arunpravin.paneerselvam@amd.com,
 amd-gfx@lists.freedesktop.org, arvind.yadav@amd.com,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 4, 2023 at 1:21 AM Yadav, Arvind <arvyadav@amd.com> wrote:
>
>
> On 1/4/2023 12:07 AM, Felix Kuehling wrote:
> > Am 2023-01-03 um 04:36 schrieb Shashank Sharma:
> >>>> /*MQD struct for usermode Queue*/
> >>>> +struct amdgpu_usermode_queue_mqd
> >>> This is specific to GC 11.  Every IP and version will have its own MQD
> >>> format.  That should live in the IP specific code, not the generic
> >>> code.  We already have the generic MQD parameters that we need from
> >>> the userq IOCTL.
> >>
> >> Noted, we can separate out the generic parameters from gen specific
> >> parameter, and will try to wrap it around the generic structure.
> >>
> >> - Shashank
> >
> > Is there a reason why you can't use "struct v11_compute_mqd" from
> > v11_structs.h?
>
> Hi Felix,
>
> Yes,  V11_compute_mqd does not have these below member which is needed
> for usermode queue.
>
>      uint32_t shadow_base_lo; // offset: 0  (0x0)
>      uint32_t shadow_base_hi; // offset: 1  (0x1)
>      uint32_t gds_bkup_base_lo ; // offset: 2  (0x2)
>      uint32_t gds_bkup_base_hi ; // offset: 3  (0x3)
>      uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
>      uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
>      uint32_t shadow_initialized; // offset: 6  (0x6)
>      uint32_t ib_vmid; // offset: 7  (0x7)
>
> So we had to add new MQD structs.

Just update the existing structure.  It's the same.  Only reserved
fields are getting updated.

Alex

>
> thanks
>
> ~arvind
>
> >
> > Regards,
> >   Felix
> >
