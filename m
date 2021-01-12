Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBFCC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 14:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133B023121
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 14:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133B023121
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6A246E220;
	Tue, 12 Jan 2021 14:45:33 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch
 [185.70.40.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 882736E235
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 14:45:32 +0000 (UTC)
Date: Tue, 12 Jan 2021 14:45:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1610462729;
 bh=dJzUPrnwlwAq5qlyATrS/8GqB1QVkQwbrqW7NZTcAVQ=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=FPWTo1LcFtad4OBHCO0W2ySPzNpvT5Do9/RBMfvzHVq6bBORpY9SMhA8oq/vdQPAx
 LEh06t9RuinW47DJU7JNwHoOaov2XuklRA34P3IlHCU51IG47LRo6qTSxiN2H8Q7Dz
 KlaZYk9Cu09/u10CapKRqS1HiUXiclYvpBPYE0iKX57opmKD4PWC+xCyJlABNn55H8
 crqtH3OH4iXxtBjxa7cJdXxYqsfaCMsVzlD3q5UZYkJ902Num9MaziTmdNyvG7JMOS
 AZGKA2SYld7lrk0Ei69xN3ojkCXPzi7zI42xfLHGLa2uKbHmeAhOEIiyicY0vMle3s
 mcLsnhsVry0gg==
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: RE: [PATCH 1/2] drm: distinguish return value of
 drm_dp_check_and_send_link_address.
Message-ID: <db24bjCQ0UAbXRVNvbMpeYjRKJR-H1mvKckBU8dnpyFYzcsxDYY7dtbXYkYWwnWtOrXpcjNUNqsvM-e_0imcs5IzXzs5zpUs3wIowqwpGXs=@emersion.fr>
In-Reply-To: <fhO3DFK9BjC0oXptdSRyxVqyxYGUM2BV9bgl-IoQa1E8CiTQVz0BbZXGdqawwnkryfbVMeyVIBTYPOpBkOKca34wehM7OAKJOzBtWQo4ovs=@emersion.fr>
References: <1609740098-32603-1-git-send-email-xiaogang.chen@amd.com>
 <DM6PR12MB2602B6281BF8C9430115E03BE3AA0@DM6PR12MB2602.namprd12.prod.outlook.com>
 <fhO3DFK9BjC0oXptdSRyxVqyxYGUM2BV9bgl-IoQa1E8CiTQVz0BbZXGdqawwnkryfbVMeyVIBTYPOpBkOKca34wehM7OAKJOzBtWQo4ovs=@emersion.fr>
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
Cc: "airlied@linux.ie" <airlied@linux.ie>, "Wentland,
 Harry" <Harry.Wentland@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Pushed to drm-misc-next with a re-formatted commit message, thanks for
your contribution!
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
