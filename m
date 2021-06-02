Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC1FC4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 09:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632D1613AA
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 09:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632D1613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 172AD6EC15;
	Wed,  2 Jun 2021 09:16:27 +0000 (UTC)
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch
 [185.70.40.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E538A6EC16
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 09:16:25 +0000 (UTC)
Date: Wed, 02 Jun 2021 09:16:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1622625383;
 bh=D6+Q/YBEfS3jHCITHGthcUuBTrVXTfaANUhMVlhALIA=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=rf7cRqdBNbJo9LE/YbnG369pA+7gOOIs1UfAPYG2FYAu3Y0n2T/uQryAKC4oqZT/n
 satpjWQwaHKhYOB1dJy7vqr9JzDpEQWd75CcHtceb8rOZW90VcCxvopQveVy4weih8
 X5VWweK4gXup2+QogOL1QLg3VJz+gvS10QlwgEQAg9x9RQAmVahwIqb31/AVUn6XlL
 CczHEqasHfhZLnii5cnl5pJSCFhLVhbNiHKjYimu2WrXUFyXpnBqEzWVxQpDzwAC+O
 DKUIz0t3uTl9b8GWoUcVekcohaCZNHA3LuGfoPhy1L967R+4zDV22a8IwJ4NhzNGb2
 RVIr6bEH4CqKQ==
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 2/7] xf86drm: Add function to retrieve char device path
Message-ID: <U1jbBlShrcZ8K1YtOccahqFpLii9JX-PhuZmcM2FgL-b9armKhfJq5kTFTK7JgQ0afiD60tXAh4nKuG3a7s83ezZA51uVPlFGjcLOusaiLk=@emersion.fr>
In-Reply-To: <20210601201702.23316-3-andrey.grodzovsky@amd.com>
References: <20210601201702.23316-1-andrey.grodzovsky@amd.com>
 <20210601201702.23316-3-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
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
Cc: Alexander.Deucher@amd.com, ckoenig.leichtzumerken@gmail.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do we really need to make this a public API?
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
