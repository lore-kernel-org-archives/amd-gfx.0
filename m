Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FECCC5B543
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 13:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC94710E0E3;
	Fri, 30 May 2025 13:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=mark.filion@collabora.com header.b="FVHRJIWC";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4981910E0D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 19:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1748545293; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PytkO90fxZy2Bdu1YW0ijzG1KCwQMyNxLS8MX8ck26r8rf+BpAuWucHU5BABC/dzxm0xCwDohU/00/dHB5XoZMXaFsuW1Wf4+RjPxOh4zoHLM6eGEfD3g+geHxkFJWe+lvM3LnpLc6vThmxysROkorp/WJd/NlEc1HKlTrz9O2M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1748545293;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=L3uj6rLy46QHqM66eogkjrelHkiVumz/LWjuCMD+K9U=; 
 b=EjdP4f+fKXnqi+4YoUPL2GJ0H6bxGv+uHkvEYiSUYNsvz69iZlw2kvmUEYpT36EPovYaB3UA5G1dPGcwlphzKGkJ3/LZ5LIyFVbG+pK77F+J8Rtsm1ZmuWHD3JqA62WW9dWmdQziDYuY0M72GzpGzHPwGgrFg3/+jZ0nYFILKLM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=mark.filion@collabora.com;
 dmarc=pass header.from=<mark.filion@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748545293; 
 s=zohomail; d=collabora.com; i=mark.filion@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To:Cc;
 bh=L3uj6rLy46QHqM66eogkjrelHkiVumz/LWjuCMD+K9U=;
 b=FVHRJIWCNiwSeK7895CWeKnlcrNFAtXoIHwIad4LkXatVsilWCiuXrf0CDKWncyE
 Hn8oXsXHzamgN8UaezTMd94FfPdCGmULjalujEyfLorobpjKtY3j8Ww+gLDfBXWRdLg
 Dl4mzJqTeq0XG6Jqov33Pfi3sMS50y9odUcXzniE=
Received: by mx.zohomail.com with SMTPS id 1748545290032988.7879886401831;
 Thu, 29 May 2025 12:01:30 -0700 (PDT)
Message-ID: <dd96073915e63e9cfb4f6122933e9e6a12dba954.camel@collabora.com>
Subject: XDC 2025: Registration & Call for Proposals now open!
From: Mark Filion <mark.filion@collabora.com>
To: amd-gfx@lists.freedesktop.org
Date: Thu, 29 May 2025 15:01:28 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42app2) 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Mailman-Approved-At: Fri, 30 May 2025 13:54:28 +0000
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

Hello!

Registration & Call for Proposals are now open for XDC 2025, which will
take place at the  TU Wien Kuppelsaal in Vienna, Austria on 29
September to 1 October.

    https://xdc2025.x.org
 =20
As usual, the conference is free of charge and open to the general
public. If you plan on attending, please make sure to register as early
as possible:

    https://indico.freedesktop.org/event/10/registrations/

In addition to registration, the CfP is now open for talks, demos, and
workshops at XDC 2025. While any serious proposal will be gratefully
considered, topics of interest to X.Org and freedesktop.org developers
are encouraged. The program focus is on new development, ongoing
challenges and anything else that will spark discussions among
attendees in the hallway track.

We are open to talks across all layers of the graphics stack, from the
kernel to desktop environments / graphical applications and about how
to make things better for the developers who build them. Head to the
CfP page to learn more:

    https://indico.freedesktop.org/event/10/abstracts/

The deadline for submissions Friday, 11 July 2025.

We are looking forward to seeing you in Vienna! If you have any
questions, please email the organizer (hfink at snap.com), adding on
CC the X.org board (board at foundation.x.org).

And don't forget, you can follow us on Mastodon for all the latest
updates and to stay connected:

    https://floss.social/@XOrgDevConf

Best,

Mark
