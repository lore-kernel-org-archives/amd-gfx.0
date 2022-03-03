Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0A5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 21:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 935DC10EE3D;
	Thu,  3 Mar 2022 21:40:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C6110EE38
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 21:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646343633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xtbmEfHUQ1QhBdRYfxa2FFiLrPGe7Eovpy4drHSn/Dk=;
 b=ZKSXmdEgrlD4lEThEs3zthf3UVj2Nd2NuNDvJMJH4UaCCq7Lupmkjfupz46Rbdvq5Ek0WT
 PzJfgUqkyw3N4amynDEMU2R698Z70+E6qtdjw6/Ema/irw8Cx2HYSTWFRLS1CfrxY5NOoq
 lD/RVs0Mqr2hZDoi/LLJqysukpNix14=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-3H8ELutAMIajiLRcfxSAZQ-1; Thu, 03 Mar 2022 16:40:25 -0500
X-MC-Unique: 3H8ELutAMIajiLRcfxSAZQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 w11-20020a05622a134b00b002dd15429effso4544620qtk.18
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Mar 2022 13:40:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:organization
 :user-agent:mime-version:content-transfer-encoding;
 bh=xtbmEfHUQ1QhBdRYfxa2FFiLrPGe7Eovpy4drHSn/Dk=;
 b=GqyIwFToN8P/CZ2rCXSv+7V5SDQrblvPvIPOha/uFVs01pSEVDIzOoO40nFVjGsqsq
 uSrPdz6z1ZSWAQdyutmefK6kWECS9jVkNc4+RKDqIjlUDWKotjmT2NBN6dVXT0DKebCc
 FqGofOg68FJvADY3EwYuEjdVaNbQhU+fcOtxseP1aAu9YCcfouxO0VnniIbXT0cB2dPT
 L8swYmWJidcG1eeixKA3C386TyWaNOiJzM4V8ntQcsDrNSCG6AVz9qhqAuf8jOlew/RA
 68vSdJGCXsmbq4rO1VslJktu3rcFhqpu7Z71DZADI89lL4C0tYRHdt1d/OtFLlfYnLe4
 TGJQ==
X-Gm-Message-State: AOAM533ZnxrnlHXtxAq8S1Lx6tHXjjG7xS5HfgAPpJwO32ul9q4WtlOM
 kfP/LPqZtScOTQquv7A34CUTtOWDH3iXKWTWgu89YQV9Jqh/0ClDK1IhgpM1HPOdUkq3Dzswfh0
 Hjae9n3dvCw/vEE91CxUhT4YYzw==
X-Received: by 2002:a05:622a:1344:b0:2df:e997:6681 with SMTP id
 w4-20020a05622a134400b002dfe9976681mr23905386qtk.206.1646343624510; 
 Thu, 03 Mar 2022 13:40:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCA+yenE8eTjRZAZCZvGlnVr52EddV1dU7aim5O2e6OJbzh14S7YnLKVi7sNxTU2jKsuO0vg==
X-Received: by 2002:a05:622a:1344:b0:2df:e997:6681 with SMTP id
 w4-20020a05622a134400b002dfe9976681mr23905369qtk.206.1646343624164; 
 Thu, 03 Mar 2022 13:40:24 -0800 (PST)
Received: from [192.168.8.138] (pool-96-230-100-15.bstnma.fios.verizon.net.
 [96.230.100.15]) by smtp.gmail.com with ESMTPSA id
 y11-20020ac85f4b000000b002de4b0a015asm2331075qta.5.2022.03.03.13.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 13:40:23 -0800 (PST)
Message-ID: <80f0071bbfb744921b842c870ac6f2793c4816b6.camel@redhat.com>
Subject: 2022 X.Org Board of Directors Elections timeline extended, Request
 for nominations
From: Lyude Paul <lyude@redhat.com>
To: events@lists.x.org, xorg-devel@lists.freedesktop.org, 
 wayland-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 mesa-dev@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 etnaviv@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 libre-soc-dev@lists.libre-soc.org
Date: Thu, 03 Mar 2022 16:40:21 -0500
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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
Cc: board@foundation.x.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We are seeking nominations for candidates for election to the X.org Foundation
Board of Directors. However, as we presently do not have enough nominations to
start the election - the decision has been made to extend the timeline by 2
weeks. Note this is a fairly regular part of the elections process.

The new deadline for nominations to the X.org Board of Directors is 23:59 UTC
on 20th March 2022.

The Board consists of directors elected from the membership.  Each year, an
election is held to bring the total number of directors to eight. The four
members receiving the highest vote totals will serve as directors for two year
terms.

The directors who received two year terms starting in 2021 were Lyude Paul,
Samuel Iglesias Gonsálvez, Manasi D Navare and Daniel Vetter. They will
continue to serve until their term ends in 2023. Current directors whose term
expires in 2022 are Emma Anholt, Keith Packard, Harry Wentland and Mark
Filion.

A director is expected to participate in the fortnightly IRC meeting to
discuss current business and to attend the annual meeting of the X.Org
Foundation, which will be held at a location determined in advance by the
Board of Directors.

A member may nominate themselves or any other member they feel is qualified.
Nominations should be sent to the Election Committee at elections at x.org.

Nominees shall be required to be current members of the X.Org Foundation, and
submit a personal statement of up to 200 words that will be provided to
prospective voters.  The collected statements, along with the statement of
contribution to the X.Org Foundation in the member's account page on
http://members.x.org, will be made available to all voters to help them make
their voting decisions.

Nominations, membership applications or renewals and completed personal
statements must be received no later than 23:59 UTC on 20th March 2022.

The slate of candidates will be published 28th March 2022 and candidate Q&A
will begin then. The deadline for Xorg membership applications and renewals is
31st March 2022.

Cheers,
   Lyude Paul, on behalf of the X.Org BoD

