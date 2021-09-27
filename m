Return-Path: <SRS0=K0ja=OR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCDEC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 15:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2104604D1
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 15:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B2104604D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62AB389FF9;
	Mon, 27 Sep 2021 15:09:28 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch
 [185.70.40.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2F4D89FF9
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 15:09:26 +0000 (UTC)
Date: Mon, 27 Sep 2021 15:09:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1632755361;
 bh=fXzawrdPhcEiRRS7QLhl1QHyY5X/UCeVEnskCKUH7bU=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=N3q8nlM1tBnSCynyg5Uipm+hGannC+rmUqXsWgyYW6EdS5xByFDPiY/BkJd7noAW3
 MfQ/X46GcWe4lWMMX7OOMxA92SxXM10jeXgKIepZSKCNoQ9MvU8HCSIRXnwyg8v3ss
 G18wCz2ELqZKr9sEk14h2vdhSVE/bv1CpdqtMqeXRSF9vf7ETKbzXDnNSLMz4ouVKR
 M5N6eIM88+D+CgsgdDVPGL5jS7CXUzrm92+UjfqjMSksfMYq4Iv7o49MgA0gPFPvAQ
 uhpyGwXovoiryR3oixdkWBkYQG39SHXZIl0U5NSOrnN+l82t7YAkuj9Kkud38cB1wR
 i2wfYUmEZLHhQ==
To: Alex Deucher <alexdeucher@gmail.com>
From: Simon Ser <contact@emersion.fr>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "for 3.8" <stable@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: Re: [PATCH] amdgpu: check tiling flags when creating FB on GFX8-
Message-ID: <KvsBEjUfaluHmhGTchZazzOZHeVQEtdicj_znZpVB1gdwU3qaZr1bObQPplEh_EVcG2I_xsIUNuIEgFXCQ81VaLaiIgtKhfXE1q2NP718xs=@emersion.fr>
In-Reply-To: <CADnq5_PFMLUfadfA83bH7i4wAQdEtLWsKf7L7iLT_YjEhXDGug@mail.gmail.com>
References: <20210920103133.3573-1-contact@emersion.fr>
 <Kmwa-gfuqYfkMsvvUXAaujfROLLXX4PuTRBRQ5efixoEvM3arNB_yT5eure3D1iqmnFB54wnbB87S1zBLL-79Ci7fhqoKx-M-ciPVs5fcSU=@emersion.fr>
 <CADnq5_PFMLUfadfA83bH7i4wAQdEtLWsKf7L7iLT_YjEhXDGug@mail.gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Monday, September 27th, 2021 at 16:57, Alex Deucher <alexdeucher@gmail.c=
om> wrote:

> No objections from me with the WARN_ONCE change suggested by Michel.

Cool, just sent v2 with Michel's comment fixed.
