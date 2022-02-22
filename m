Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8A5C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 01:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D5F010E25C;
	Tue, 22 Feb 2022 01:46:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF04910E25C
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 01:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645494373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=96JzHwNa1B2QXjUWnZ374iz4+U14qI3CRmOmAH0GIUs=;
 b=UkNr2LgnbiAw0yAtrQX5c/dVLItsCRu2U8iIT00iCvoAtsBF8oS7E4gYWwb13PmtAldgR7
 wed7YxopEaKG4umwyBIhdnjLvMKEBIWxuVxleZd+VeIWdolz9G3mljmvDyI3msmwmLTl4k
 5WmUpTTXds/WeErodrqYm2aM7BUy0oQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-WXBwq5ZfNw-w8tdA3-u29g-1; Mon, 21 Feb 2022 20:46:01 -0500
X-MC-Unique: WXBwq5ZfNw-w8tdA3-u29g-1
Received: by mail-qv1-f70.google.com with SMTP id
 jv14-20020a05621429ee00b004300c413db6so19153685qvb.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 17:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:date:organization
 :user-agent:mime-version:content-transfer-encoding;
 bh=96JzHwNa1B2QXjUWnZ374iz4+U14qI3CRmOmAH0GIUs=;
 b=FTB/ekVkhO3rJZZJpiT/PSZP0S5YykWXIrhw3WIvgV87l6wpCNgfM3BuxWAfT5826f
 AUMYuBVAn/ji5b14hZOqYxSvCRavvkxFyZKDcLcpjXYE3kV3OacIjLCyqzpB5F1Sk/LP
 mcRlJjkEuk5PsmOWl0qv8AF3Z2J3AsxrOl3z6y3RVG3nvTS/BeevQzYdPUm4GDBPjLz+
 vtKjC9PqCg7R6LKxd4OAL9RSDg/HtB27X8D2WscfEBkbyKvGg0TirtMCTJ0vuSTZSFtp
 +lQbGgugGvIJJi1kfzxnZJKHqgP30SAUWwzKatkAu10CMLIC851yK32B+z2LN75QdV4n
 KiyA==
X-Gm-Message-State: AOAM530Gs4whs30mSLdBkOV3rHl4yQlUwjf784N7PI9rbt5u8mJdBlyP
 i92p/D3lH11A/9FhduWfr0KXJlr7rQ4ptRLnylsDVhMocr+VvVJ95iknCRiRoHsKriVxEgF2fUM
 MgqGNcFq6HeLyxSaAglLoFIhMDQ==
X-Received: by 2002:a0c:bec2:0:b0:42d:7a97:7c50 with SMTP id
 f2-20020a0cbec2000000b0042d7a977c50mr17596036qvj.64.1645494360836; 
 Mon, 21 Feb 2022 17:46:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRyX/nST1Psi3yWzhSr7BZIQG7ecyOcllTfLzjLqbPHMXIvAV7C+vXZhS0bg1zhOmNbnqosg==
X-Received: by 2002:a0c:bec2:0:b0:42d:7a97:7c50 with SMTP id
 f2-20020a0cbec2000000b0042d7a977c50mr17596017qvj.64.1645494360574; 
 Mon, 21 Feb 2022 17:46:00 -0800 (PST)
Received: from [192.168.8.138] (pool-96-230-100-15.bstnma.fios.verizon.net.
 [96.230.100.15])
 by smtp.gmail.com with ESMTPSA id j128sm6512810qkd.61.2022.02.21.17.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Feb 2022 17:46:00 -0800 (PST)
Message-ID: <e93170406e5ea46e95f44d4e33f0c86a78c0623a.camel@redhat.com>
Subject: 2022 X.Org Board of Directors Elections Nomination period is NOW
From: Lyude Paul <lyude@redhat.com>
To: events@lists.x.org, xorg-devel@lists.freedesktop.org, 
 wayland-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 mesa-dev@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 etnaviv@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 libre-soc-dev@lists.libre-soc.org
Date: Mon, 21 Feb 2022 20:45:58 -0500
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
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

We are seeking nominations for candidates for election to the X.Org Foundation
Board of Directors. All X.Org Foundation members are eligible for election to
the board.

Nominations for the 2022 election are now open and will remain open until
23:59 UTC on 06 March 2022.

The Board consists of directors elected from the membership. Each year, an
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
prospective voters. The collected statements, along with the statement of
contribution to the X.Org Foundation in the member's account page on
http://members.x.org, will be made available to all voters to help them make
their voting decisions.

Nominations, membership applications or renewals and completed personal
statements must be received no later than 23:59 UTC on 6th March 2022.

The slate of candidates will be published 14 March 2022 and candidate Q&A will
begin then. The deadline for Xorg membership applications and renewals is 17
March 2022.

Cheers, Lyude Paul, on behalf of the X.Org BoD


