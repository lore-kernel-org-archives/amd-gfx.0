Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56E3C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BCDB22DFB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCDB22DFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E889A6E190;
	Tue, 12 Jan 2021 09:21:57 +0000 (UTC)
Received: from mail2.protonmail.ch (mail2.protonmail.ch [185.70.40.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 313FA6E18F
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 09:21:56 +0000 (UTC)
Date: Tue, 12 Jan 2021 09:21:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1610443313;
 bh=P7Xq0acnLz9yj6KgKO1+MbJIrgeDLzDdM6heYyrfd4o=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=G6eHKKIQ3TPMBPpOa+mw4Is/3/XTksJFFoUGYuAN5O9L48nF1cBBkQZ0xo80JXVf/
 gZSiYPFX4mnqR0mtWg1sb629vK3PCVXJbX1ER9Kv1BCIwIyTMFww+EWVuMPXg+x33k
 JTNAQ9lo2UUQpIPABE93Y8iRGHIO+XBPXCcOxNHEARZZEwr5fJvm1HwRUBUzgBTn/p
 oe3BGpWwRwjrsRcpPKO84g9U70X7nOe8p5T4xZCpBhLcfcTkj/gCHJ6zFAB0p3s1N5
 pBSpu7G93K6/2OCovpRVqMpRN/DS33OXr6YZKpjKyLQnaK2UiauwcUfnBXpNt+/RUW
 Z2RCmT9ehkWrw==
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: RE: [PATCH 1/2] drm: distinguish return value of
 drm_dp_check_and_send_link_address.
Message-ID: <fhO3DFK9BjC0oXptdSRyxVqyxYGUM2BV9bgl-IoQa1E8CiTQVz0BbZXGdqawwnkryfbVMeyVIBTYPOpBkOKca34wehM7OAKJOzBtWQo4ovs=@emersion.fr>
In-Reply-To: <DM6PR12MB2602B6281BF8C9430115E03BE3AA0@DM6PR12MB2602.namprd12.prod.outlook.com>
References: <1609740098-32603-1-git-send-email-xiaogang.chen@amd.com>
 <DM6PR12MB2602B6281BF8C9430115E03BE3AA0@DM6PR12MB2602.namprd12.prod.outlook.com>
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

On Tuesday, January 12th, 2021 at 7:36 AM, Chen, Xiaogang <Xiaogang.Chen@amd.com> wrote:

> Any comment?
>
> -----Original Message-----
> From: Xiaogang.Chen <xiaogang.chen@amd.com>
> Sent: Monday, January 4, 2021 12:02 AM
> To: amd-gfx@lists.freedesktop.org; Wentland, Harry <Harry.Wentland@amd.com>; dri-devel@lists.freedesktop.org; airlied@linux.ie
> Cc: Chen, Xiaogang <Xiaogang.Chen@amd.com>
> Subject: [PATCH 1/2] drm: distinguish return value of drm_dp_check_and_send_link_address.
>
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> drm_dp_check_and_send_link_address discovers MST device topology.
> It can return both positive and negative values. When it returns positive values there is no error found. If it returns negative values there is error found, such as get NAK , timeout, etc. Following drm_kms_helper_hotplug_event should be called when drm_dp_check_and_send_link_address returns positive value.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>

To the best of my knowledge, this sounds correct.

Please wrap your commit message into 80-character lines so that it's easier
to read. Regardless, this is:

Acked-by: Simon Ser <contact@emersion.fr>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
