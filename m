Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FE4C54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 15:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACD5010F0AF;
	Tue, 12 Mar 2024 15:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="O3qOZcf5";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B5410F0AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 15:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1710256530; x=1710515730;
 bh=E9wUG+L+Y2XPzkUMtFXxQPAZM2y33J3XgppsV1zA+Fg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=O3qOZcf5BLz8SuWWjVtdCcFc5czbhhV8oD+/n6wy//QTNpp6jvn8JyXO+Xw3Tfvvs
 mKoQviKgCUdprASxRcxGUoMmGuv32V9SeIY8HVTARmD+WEpC4UqXLQi+GcsZkhIWEj
 kM54dn/gsKDYrv0LfvB1HaX5D9ckaUG5kJBAETtCBHYNf8p4KKwPXv4e1jOGOEHsEL
 eq3i5fEXdoX0DSQqE/hFLGwevIIqSuZgYMeT+/WqZZGCn3Woqrc1xPYJFb7ByNxfOp
 fPRPOe4y5hUbpcEkEzHcmF6EbKHuP4uaCebn0jTsEWQcUruaJ+EWK4+3dvwH3/EdPF
 i47MzAQp+SKiQ==
Date: Tue, 12 Mar 2024 15:15:13 +0000
To: Pekka Paalanen <pekka.paalanen@collabora.com>
From: Simon Ser <contact@emersion.fr>
Cc: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, wayland-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v4 10/42] drm/colorop: Add TYPE property
Message-ID: <fUKns6g3m2ljL4-W9uaJkjW8nXhevseCHOwD6AbJ5AeDLMD68YIPSWZA1U29fjvrY9fabCmztCZEy8EkZtYGZ1iSudy0VxAMLWGZFunsIUc=@emersion.fr>
In-Reply-To: <20240312170247.326b1c6e.pekka.paalanen@collabora.com>
References: <20240226211100.100108-1-harry.wentland@amd.com>
 <20240226211100.100108-11-harry.wentland@amd.com>
 <20240312170247.326b1c6e.pekka.paalanen@collabora.com>
Feedback-ID: 1358184:user:proton
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

On Tuesday, March 12th, 2024 at 16:02, Pekka Paalanen <pekka.paalanen@colla=
bora.com> wrote:

> This list here is the list of all values the enum could take, right?
> Should it not be just the one value it's going to have? It'll never
> change, and it can never be changed.

Listing all possible values is how other properties behave. Example:

    "type" (immutable): enum {Overlay, Primary, Cursor} =3D Primary
