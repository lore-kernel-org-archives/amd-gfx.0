Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0094C25B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 13:43:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B24E10E696;
	Tue, 21 May 2024 13:43:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="kEdYK+We";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAEA410E696
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 13:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1716298988; x=1716558188;
 bh=xRlbO6AO9BRosGd+lyQDF/h0GUTf2ev2CWxdtRN0a/o=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=kEdYK+WeHzoL+OF48n/MDXPh4QFf+3E8MUHdznbjJAb6dXnOHilX5qeLNLYjNvXM0
 1nG142vj0GZ5Q0BBzklH3YTcYsazOBeNHXfIiG67HLf5UCoW2TeGqvcKNr7+87Aiwl
 GPLBXernqEoHUZghW8LiJ6AF5XlXs9fvPi3qbflPcbOCiWv3DBHM3xyWHen01UdVa3
 F0n2hAtbwsXngCdhuvtPg9QpOCsurq3v/hU23PfU86NwJSd/O1/QKAHmo2pkXRvqvV
 /65mjwvvq7EEIrfEgG61WkDv0trmIkr6jOfw1AxVir7w0mSmRmK7ObWKEnXPh9+SQs
 YnxOLLVaPN30A==
Date: Tue, 21 May 2024 13:43:04 +0000
To: Mario Limonciello <mario.limonciello@amd.com>
From: Simon Ser <contact@emersion.fr>
Cc: amd-gfx@lists.freedesktop.org, Harry.Wentland@amd.com, xaver.hugl@gmail.com,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/2] Add support for Panel Power Savings property
Message-ID: <-KAO9zJq5vTiesgtw-PMO0lDkSH1tuV271WNqlVuh3ZSkMzKWB9JQJce68-X-GwhD57QilHIBnLxN9k03I3-CMeYQm30NJMLizfyUUxTqHA=@emersion.fr>
In-Reply-To: <20240519130610.7773-1-mario.limonciello@amd.com>
References: <20240519130610.7773-1-mario.limonciello@amd.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 401727dabe882d36fc0c5354129feb9f1fd46995
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This makes sense to me in general. I like the fact that it's simple and
vendor-neutral.

Do we want to hardcode "panel" in the name? Are we sure that this will
ever only apply to panels?

Do we want to use a name which reflects the intent, rather than the
mechanism? In other words, something like "color fidelity" =3D "preferred"
maybe? (I don't know, just throwing ideas around.)

Would be nice to add documentation for the property in the "standard
connector properties" section.
