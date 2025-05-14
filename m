Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB4BC3ABDA
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 18:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB06710E6CB;
	Wed, 14 May 2025 18:08:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LI/gjv/k";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 203BD10E6CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 18:08:13 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-22e3ed5ee1cso111205ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747246092; x=1747850892; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSLeVpCpyhkdkapiC/6UX9xwclocSb8iuCmyXR/h4w4=;
 b=LI/gjv/ksHFTWjjXn0biZs62YAVzCAgnxbWrdKZfS1lZBDGfsp3/5tIqym8yRkJVtY
 +8IvU5E5OTn6PYwzHu/u+/tUBSgrrYYxzuI5pI2rxSOy4VZWxO4siy+aYtn4bXuKiVSo
 nIMF+Qn9N92ZDCWYnf42MsPQvtkSeXLImJfaGA/PYY7l+fs3J5dMFmKlK6zFqKQ+8sw5
 ctZsdx0tIHdFBjm6jscTi4+WwBQ1nEqjN79mZovAd1QsG9CMdNsRhlcyivdACjdhq8VY
 ooNoICpihHCy4rX1pYklxrbgN4a+Hs+0JYakMnHXCwnKTpFmfxR/IBqWaqhaZUdVD0b3
 lZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747246092; x=1747850892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSLeVpCpyhkdkapiC/6UX9xwclocSb8iuCmyXR/h4w4=;
 b=ZOLvXxmWVvmka8Vgy6d//311/xQ++BRxmwUu2wkrXuJQBfbaZpFyeS9MIUXDcCT8Fb
 NzpzCXXzos3X7eU7lWqBB7yz6xM6EqhinfmgPG+dYCWsN9A4ZoOQgvzA+9KO+4olVgBf
 hTxxrfCLkucUVLqkGr8VByvPHyNXEiXYii9hI3HHpXkhNR5kwxr280o7ZA7s76KB/6Jj
 eDahTSZ8babeLZ2/k/00b3T8/B7kvknPdD3S67sISOIKtiCIyc6ZQlI6OUzkQdBspRrG
 0AnEBzRoADTGbWjjOMf7oGHBjafvAOlg7SBPAUf5LV8fR8JtITdNH2POjrsQLK90Hnqh
 TH1A==
X-Gm-Message-State: AOJu0YwoXPMx8grRu7uUKNzXB8kMhUC8+09oIa+XORyLwzELJbQY0APl
 ojy4bbXdb5LFd99R0DMu1JKcZ16HPmLptDQ+rGwWv5sn18NEPW55MsL2nqa1HZY8uq14WPOS3s2
 jDcDiHSIKOHtvoTqbn+/QUaARv7s=
X-Gm-Gg: ASbGncsmeIOo/8CHQRWMdtn7oz3clN3c0O/loTIiAAxg+0clVp/yIQJpL73o5e+w53Z
 32KYC6uEYphNWvTKZb82ydlzSaExdOuxLjZzRxRWI8tfODaVkjo5udtG0dddxeNERsG4aNY4+ii
 s1S9LKgBMfWM/euzzLHjYog3Y7Cbgopxx1
X-Google-Smtp-Source: AGHT+IGwlL1OXndG8B2iNzGzM6obul3P0dd2suqRdTi/JZ149pmoeZhxE15WQFsItXgZwqmZskSOB2mvQQdYOt1UXj0=
X-Received: by 2002:a17:902:ef06:b0:21b:b115:1dd9 with SMTP id
 d9443c01a7336-231980d7403mr27261905ad.5.1747246092603; Wed, 14 May 2025
 11:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250514172251.726484-1-David.Wu3@amd.com>
In-Reply-To: <20250514172251.726484-1-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 May 2025 14:08:00 -0400
X-Gm-Features: AX0GCFvEXri4EiHcA1Fu1Cb_a1jetO_pXJH7KUWhqjX3bAykKKljwiQWLEZGPXQ
Message-ID: <CADnq5_M4qx-B0wGtOr8=iyMCvtAmYHgK-Vjv2pVPMcvUEQPy4A@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] drm/amdgpu: read back register after written
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 Christian.Koenig@amd.com, leo.liu@amd.com, sonny.jiang@amd.com, 
 ruijing.dong@amd.com
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

On Wed, May 14, 2025 at 1:33=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@am=
d.com> wrote:
>
> Similar to the changes made for VCN v4.0.5, the addition of register
> read-back support in other VCN versions is intended to prevent potential
> race conditions, even though such issues have not been observed yet.
> This change ensures consistency across different VCN variants and helps
> avoid similar issues. The overhead introduced is negligible.
>

May want to update the comments to say something like:

/* read back to post the writes so we don't race with the doorbell */

Either way, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
