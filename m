Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E47C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 17:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2DF10E54E;
	Fri,  4 Feb 2022 17:40:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5382D10E3A4
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643996411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+Fgk2tPp8Iez8ffo3teobZs6lfET8NrmEOulKtLL6l8=;
 b=hgu4N+S2gNdG1xMhXdat5E6BCLq/KTAMIgvMNi0eK4csndApUPlZp0/k0dlKHe6jbeZJdm
 Ade/UI/wsT6mi0oG5a5pqi1KLVLaexIvOr1LzNja1AKUhUofqDKluRX+tBetqc/l0phA5P
 1h/vBToWtlExXnm1DgcDuSjqS9KBhk0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-93okCnmnMCakDk_Uilr-Jg-1; Fri, 04 Feb 2022 12:40:08 -0500
X-MC-Unique: 93okCnmnMCakDk_Uilr-Jg-1
Received: by mail-qv1-f69.google.com with SMTP id
 x2-20020ad44582000000b0042ac8737909so1378855qvu.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Feb 2022 09:40:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:date:organization
 :user-agent:mime-version:content-transfer-encoding;
 bh=+Fgk2tPp8Iez8ffo3teobZs6lfET8NrmEOulKtLL6l8=;
 b=BikEfe2GKnKyAWe1GqVRXCILSevjE7zRgZmM0+YLG9OmpsD6Ws2ByNrExE4Xan//qX
 vpfHFs182saACFDeWlbo96Ev3K30dK2zU2+OIzuJvPFSluwKC2Czw0pa6R7YxpoLIozr
 9g0qfVPSjYxqLl8364KowB+tL91+gKuTTwi+fckRxoL4FcZ6MyMR1NFhdkSpKaVVI8uq
 Lk/Bo2fZ2yYAUjobXytRh8HF83H+UJozGNuQWLc4rZKkLsEi/reqpL8uH0B0bn1jGfw8
 NU8T7avb88FyTUAJff+zwIaMOg65QBTAKujaINkuvYkmQAe2Br0IolqcC8X0HNn67CSG
 DbDA==
X-Gm-Message-State: AOAM533TR+QXM2r+y+Ph4sdKVx/8b7xOtowYHsd9mMCR1xM9i7aDOSz5
 2FTccNT4SrFviBk00GGb1hXl9r2Ef5Mxrn+trwtgdEd5N4g5Eke9vCIEDowxEWV46mN7k7O/WIy
 QbtJauj7LYxbD+56V34rRMQVKzQ==
X-Received: by 2002:ac8:578a:: with SMTP id v10mr76194qta.148.1643996408381;
 Fri, 04 Feb 2022 09:40:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKdGHijSYkEZ0PZ6zI7XULxLGuuiXeTX+kTLZtxdulDdoNZ2sUxc4s+6mCyl5zpu6dwwjJCg==
X-Received: by 2002:ac8:578a:: with SMTP id v10mr76176qta.148.1643996408156;
 Fri, 04 Feb 2022 09:40:08 -0800 (PST)
Received: from [192.168.8.138] (pool-96-230-100-15.bstnma.fios.verizon.net.
 [96.230.100.15])
 by smtp.gmail.com with ESMTPSA id w22sm1599186qtk.7.2022.02.04.09.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Feb 2022 09:40:07 -0800 (PST)
Message-ID: <8db37efd8113f33107175b353f1f996523db7b9c.camel@redhat.com>
Subject: [Important!] 2022 X.Org Foundation Membership deadline for voting
 in the election
From: Lyude Paul <lyude@redhat.com>
To: events@lists.x.org, xorg-devel@lists.freedesktop.org, 
 wayland-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 mesa-dev@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 etnaviv@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 libre-soc-dev@lists.libre-soc.org
Date: Fri, 04 Feb 2022 12:40:05 -0500
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

The 2022 X.Org Foundation elections are rapidly approaching. We will be
forwarding instructions on the nomination process to membership in the
near future.

Please note that only current members can vote in the upcoming election,
and that the deadline for new memberships or renewals to vote in the
upcoming election is March 17th 2022 at 23:59 UTC.

If you are interested in joining the X.Org Foundation or in renewing
your membership, please visit the membership system site at:

https://members.x.org/

You can find the current election schedule here:

https://www.x.org/wiki/BoardOfDirectors/Elections/2022/

        Lyude Paul,
        On behalf of the X.Org elections committee


