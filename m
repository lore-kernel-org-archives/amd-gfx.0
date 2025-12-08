Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A40D3B7E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FDA789FF9;
	Mon,  8 Dec 2025 17:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SjGAsbLP";
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C59689FF9
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:11:13 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-7c78d30649aso3895147a34.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Dec 2025 09:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765213872; x=1765818672; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78LuuiPJBB2U8AT7kFxuqcn5JBa0QHZYUkBx9lAY6sA=;
 b=SjGAsbLPSiAasMroKxLZ6wGRBVCVgXtxnnUHPglLHDVsyJu7HOkqa9x9ixXOtZ5N0S
 LMU1tyQHBAX9cRTO+k1tZwnqT/Kn5qNxsIOLau20TKXarYIXgQH+iTk3NqUGAZenIkL+
 rrFehHOINOvq9aJSjXz5voG5WC6xC+PeoVwDjo7I/fq+7AUNO6RXugCtkWfsqSsBXp9a
 t3NSu4mo/16uX7/Gc7fQyzbJaLyvlVRiHnDWJYG7UIizd+b+36NiQqxf9rFH6cheswfd
 VbK+/FV2QdtO1ujCqa/M1Ru2tma6D+84dxAGc4NraTJWGXtj0VZyxGJD/ZrAtr5D6C1a
 T5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765213872; x=1765818672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=78LuuiPJBB2U8AT7kFxuqcn5JBa0QHZYUkBx9lAY6sA=;
 b=LhGXLjh2vZVQOIvR2WBV6KkcRUmMu+FhxVeHEtm4czrrvhkEp5rRHN6LUl0GfZybje
 EAtucKAGCIgiezI1S2uZwBhOC3l/L8v7hYx2Vv66eMm1DEcb5LkZlTxCiIKtbglABhpH
 /3YGgdrb6NBDOwK+WNGmak8jh1OknSI13d/h3yMttGarPRKFvNGwBNFQJUJlXMUs4rko
 iLY8IK1yKlA+CdNvkI6EYb5rjq84x86g2T20tgYd5afH+b1LFWjT/oAjuLDWDjfGxhB6
 Ulu2RKyF97cmeQfDNoEun07XJQE8IoWcnhkhomN2JbZrD2AelR30bNkwWl1yKs+vjq4s
 1Lww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB/Rj/6LqLUyKTo6rgqJSBOTrGv9FvYkNCROn8B6UnD0hctELWxMRVbw4MMgaTp2LhvlKesEKu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMixxDFMJafus1Wf7/8QPCLSQl/ojwyqmyp7KxHkSK2DKVAryT
 9hp15OLNUk42ky6ZIkyRWMMWbArHMArE+FzXraV3Ts3DfftlVuDbW17sGG65Mwn/ZZUXiTqdPrJ
 4GwOs8Qz2HJwjTCPxvn07uhmrqKBUurMpB4/mSnu9H40Z
X-Gm-Gg: ASbGncvTByr5D8O67OeqqvdeKBp/5wqk+HJpusYYjP0S4CDTjWsAdkzrihu6p45tiU2
 eFyH1glWFzYZ4QZorxnjVu264DgtClPaq0SpB07hMOaCsb2EJN0izXstlOJKAnLNdwPB7pphOis
 bI2cIhWcPJBvO8zh0y8EjYcvkQ4aCNtCN5nkUOis/cw/1LBoMg4ovbxMDkDPsGShH3YRggYccxT
 9ZPd08/isKMIL0GtXpkWQFonnkK0uAiiAs2agF3BFm5/EGlJfG8NX61h6Wn7dcqQFTyseB9CQ==
X-Google-Smtp-Source: AGHT+IFB7Rzaaz4EC6IUMwWeyrNDYtzP5w3CZJMkKn5Ph9aolBvRR+CrgAojcayhMbXX495K7a20q62lDHZ5Xzn1Jko=
X-Received: by 2002:a05:6830:2e06:b0:7c7:8280:edd9 with SMTP id
 46e09a7af769-7c970877727mr5802912a34.38.1765213872290; Mon, 08 Dec 2025
 09:11:12 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsOcjjD1f5vCxbv-CCCMZPearMnY6GE-WPc_N=_k1TtfXQ@mail.gmail.com>
 <CABXGCsOfOuWqzV=3wZXSUJRmJpWQf6f3qQ=93=DqtN2ZjhyhGg@mail.gmail.com>
 <CH0PR12MB5284525FDCC5F2261D7FA6BF8BA2A@CH0PR12MB5284.namprd12.prod.outlook.com>
 <CH0PR12MB5284880C09ACD7DFB6670ECC8BA2A@CH0PR12MB5284.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5284880C09ACD7DFB6670ECC8BA2A@CH0PR12MB5284.namprd12.prod.outlook.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 8 Dec 2025 22:11:00 +0500
X-Gm-Features: AQt7F2rstYxLMY-UHyCt-wjtxjcgpU2933wVwZlBZ84K1y9EeH5LHp90-n4Sqlc
Message-ID: <CABXGCsMH-4mC9n-ZySb=QtCLkM0eSX1sKaDTzXT8cG9mFS0rRQ@mail.gmail.com>
Subject: Re: [REGRESSION] Black screen on HDMI power-cycle after commit
 3471b9a31ce3 (7900XTX + LG C3)
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Cc: "Vojvodic, Relja (Reggie)" <Relja.Vojvodic@amd.com>, "Liu,
 Wenjing" <Wenjing.Liu@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Dec 8, 2025 at 9:42=E2=80=AFPM Pillai, Aurabindo
<Aurabindo.Pillai@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Mikhail,
>
> Turns out we had a followup fix for this issue: "drm/amd/display: Improve=
 HDMI info retrieval". Do you have this in your tree?

Hi Aurabindo,

No, I do not have this commit in my tree. I am currently testing on
the mainline Linux repository (Torvalds' tree), and it seems this fix
hasn't landed there yet.

I just updated to the latest master (commit c2f2b01b74be) and searched
for it, but found nothing:
mikhail@primary-ws ~/p/g/linux (master)> git remote -v
origin git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (fe=
tch)
origin git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (pu=
sh)

mikhail@primary-ws ~/p/g/linux (master)> git log --all --grep=3D"Improve
HDMI info retrieval" -i --oneline
mikhail@primary-ws ~/p/g/linux (master)>

Could you please point me to the tree/branch where this fix is
located, or send it as a patch? I would be happy to apply it and test
if it resolves the regression.

--
Best Regards,
Mike Gavrilov.
