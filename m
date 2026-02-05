Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4CBECD9AA
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 21:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA14210E13E;
	Thu,  5 Feb 2026 21:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ubuntu.com header.i=@ubuntu.com header.b="KQJ2zhzc";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F6E310E13E
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 21:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com; h=To:
 From: Subject: Message-Id: Date: Content-Type: Content-Transfer-Encoding:
 Mime-Version; q=dns/txt; s=fe-953a8a3ca9; t=1770327818;
 bh=pjbwI8/toe4jBT0dkLZbWij8hg+Aoe8jhtwClB49npI=;
 b=KQJ2zhzco3Kx6dwREY/I1mo373bdAhl7X+yxZnb28MxOtT7KLNtWv3yo/Dn2DSPgtjk/AaUNR
 GME2dWh+t+ZhzL1tzjXsL5Lxv6XEG4Qq0itsZLjd3PrOj6/FCJy9B7w6LzKkbd+EGzmyHgDsJ0+
 a0b8or4WRzWzPtL7yt914+t/7m10LAy7fUdGI23Fye6Xp+RcIrHUSdEIaKijMknicgj0C2zHq5p
 HqAmI0fOQvbXFzeQaC8Cye/q4Gp9tH68V8tPbdIZ5kq0Urr/aGYWU8UjW8uYTqhOp2iGBBy6AvO
 vifNyRXTi4F1iaF1arvCHCHsNQlKzGgy3TuguSEoFVwg==
X-Forward-Email-ID: 69850bd58a29473a36a7b980
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Thu, 05 Feb 2026 16:29:52 -0500
Message-Id: <DG7CJKUR1SN4.1ZXQ6OIU28Z4D@ubuntu.com>
Subject: amdgpu_connectors: move to drm_edid?
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
X-Mailer: aerc 0.21.0
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

Hi everyone,

While looking for things to do, I found that amdgpu_connectors
is using drm_connector_update_edid_property, which according to docs
is deprecated in favor of drm_edid_connector_update.

This would be a drop in replacement, but the second parameter is now
struct drm_edid instead of just struct edid. So this would mean
updating amdgpu_connector's edid field to be of type drm_edid.

Is this something still desired?

Thanks,
--
Josh
