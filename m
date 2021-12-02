Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DC8C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 12:21:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6977F6F5DF;
	Thu,  2 Dec 2021 12:21:25 +0000 (UTC)
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch
 [185.70.41.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E6796F5DF
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 12:21:24 +0000 (UTC)
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com
 [188.165.51.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail-41104.protonmail.ch (Postfix) with ESMTPS id 4J4ZnG27qXz4x9tJ
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 12:21:22 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
 dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr
 header.b="su3KAOQ7"
Date: Thu, 02 Dec 2021 12:21:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1638447677;
 bh=+wgmm1QnVKifVi6i/KAbh8pDeJ78C8Gn+gyE8XXNd9I=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=su3KAOQ7vzg/3uto8RFln0sVD8wV6QdRoYNKVUPJkCLLc4xvYDwN7b/CJbkYJn2hG
 /m1HOjGcr/d5i4mb4UDAVOxyDIRd/2pXkVk0YrYmZG3p0o9A+a1H7zNPSWtaqyM2z4
 O2dwiKQe//y04LuKF24jQ76936k069pqYY5sk27MVtRM1ufSbq/Mk39BKxgqeXw++A
 KvGW8I0es9NaJ0osV/YZv1lOSWizoe59nN2Up4KMEkfKST7kKnBwJsadZLUB81RLzK
 JBI0nDHE9GiXMMzl/GpTDVRkVYUMUQIOvRPnAFSpN2yoxL3Hy3j/4APhUlm/gFj+Ny
 KkmEOOflnPjwg==
To: Vlad Zahorodnii <vlad.zahorodnii@kde.org>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amd/display: Use orientated source size when checking
 cursor scaling
Message-ID: <wokYiPNfrckmjqs2r5_IU-pvNbB8xb6JnNLEVXKj-ACeAd4X6NX_mPpKSiQktbq2DftWMhGAEq89M6qrG-15vM0Z0AhPT2ZCjM6FRy2fhe0=@emersion.fr>
In-Reply-To: <20211202121650.2265-1-vlad.zahorodnii@kde.org>
References: <20211202121650.2265-1-vlad.zahorodnii@kde.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org, xaver.hugl@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Have you tested this? I have a similar patch, but the cursor position was o=
ff
when I tried it.
