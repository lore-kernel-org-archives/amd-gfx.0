Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8479C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 19:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07ACE10EA2E;
	Wed, 16 Mar 2022 19:47:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28DCA10EA2E
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 19:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647460060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J0oI+0ISdRle63jGaS9/UHYnEMzVjtXKfWa9O2AXWGk=;
 b=MO/by9su7tEAz21aXYA1x03aZZNpCLii3/mrCd9QTmwCcMvgHAcR8pmKU8DbWB/rGsYuYk
 OQyzzMzmXNTRcHI8X+2ZfDaNbuWZdgHPiH2m4Uzc/xTVDKXWSzoWlOCrgetIO7lVw2WPwA
 jHmjreTpDG///KOktnUbULPPvVHnXnQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-ke7m3whYM4WjUcb2BXyZXQ-1; Wed, 16 Mar 2022 15:47:38 -0400
X-MC-Unique: ke7m3whYM4WjUcb2BXyZXQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 m12-20020ac807cc000000b002e05dbf21acso2102100qth.22
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 12:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:date:organization
 :user-agent:mime-version:content-transfer-encoding;
 bh=J0oI+0ISdRle63jGaS9/UHYnEMzVjtXKfWa9O2AXWGk=;
 b=QX92olpmHTG79hfbxkIn0qsDQZsea18ud0jq42Z4kh8NxephwCOISN5vLktHc5E4D9
 3b0WADOTYB08bBaWFaQXnq4qjatCPUnCsLSV/srGBcPkzSFK2a6fn3cnBjNhv4b851E9
 pi1pZMR8H/4h7H5blQ1VrvIeHpRLHkFmqoElZG7GvTYtS7tmb1csYgcu7HVfkoGBv8ZH
 8iK/yudateift2CIB0SjYvsCFXIMXkVd7Sy/cOI3IHXIffBevWqjaxbbdxn4zcKni1KZ
 u7NgXWc5g2YmishpzFADdIXpwqpMH3qwiMLOomFHIBwWigGSk2/FsFEVmnX+W0QANS25
 GABg==
X-Gm-Message-State: AOAM531nLWLg/kikxVFCJ8JTC7Tl2MfviXVjqmbPSdWCGreQtOfJlhlI
 HFPCvKJAJ9cmc9lrF9tXVIuUVWnJPWJcRZXIZXgBTsJkfLASAmVmzdcFsXJ5jwN+qpAG31dwuJi
 Z/5THbi7pY/pi7kRrEw2+BiwTdQ==
X-Received: by 2002:a05:6214:dcb:b0:435:cb9c:b0b4 with SMTP id
 11-20020a0562140dcb00b00435cb9cb0b4mr1081806qvt.119.1647460057837; 
 Wed, 16 Mar 2022 12:47:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd6yBQg5t9nqQt2lYJt49ehTyptVw7upMg0uojKxcC/Ku5glPD14dTM2VhzVpmsxZJOfIDgQ==
X-Received: by 2002:a05:6214:dcb:b0:435:cb9c:b0b4 with SMTP id
 11-20020a0562140dcb00b00435cb9cb0b4mr1081787qvt.119.1647460057597; 
 Wed, 16 Mar 2022 12:47:37 -0700 (PDT)
Received: from [192.168.8.138] (pool-96-230-100-15.bstnma.fios.verizon.net.
 [96.230.100.15]) by smtp.gmail.com with ESMTPSA id
 c27-20020a05620a165b00b0067d32238bc8sm1237699qko.125.2022.03.16.12.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Mar 2022 12:47:36 -0700 (PDT)
Message-ID: <0e029c57f314bb6139e72ff22a3f7667c99b7f26.camel@redhat.com>
Subject: 2022 X.Org Board of Directors Elections Nomination period is NOW
From: Lyude Paul <lyude@redhat.com>
To: events@lists.x.org, xorg-devel@lists.freedesktop.org, 
 wayland-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 mesa-dev@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 etnaviv@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 libre-soc-dev@lists.libre-soc.org
Date: Wed, 16 Mar 2022 15:47:35 -0400
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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

