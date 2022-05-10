Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B5BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 08:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9983210F606;
	Tue, 10 May 2022 08:37:23 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2031910F606
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 08:37:22 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aeae3.dynamic.kabel-deutschland.de
 [95.90.234.227])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9040C61EA1923;
 Tue, 10 May 2022 10:37:20 +0200 (CEST)
Content-Type: multipart/mixed; boundary="------------0svoNg2nlmSd1VWlwVhizSm5"
Message-ID: <66e1d78c-bf27-80b4-9804-6c9f3a8c5547@molgen.mpg.de>
Date: Tue, 10 May 2022 10:37:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
References: <note_1375796@gitlab.freedesktop.org>
Subject: Fwd: Re: amd | ASUS ROG Strix G513QY fails to resume from suspend
 [regression] (#2008)
Content-Language: en-US
To: regressions@lists.linux.dev
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <note_1375796@gitlab.freedesktop.org>
X-Forwarded-Message-Id: <note_1375796@gitlab.freedesktop.org>
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
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------0svoNg2nlmSd1VWlwVhizSm5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Linux regressions folks,


A user reported a regression [1], which also trickled down to the stable 
series, for example between 5.15.13 and 5.15.14.


Kind regards,

Paul


[1]: https://gitlab.freedesktop.org/drm/amd/-/issues/2008
--------------0svoNg2nlmSd1VWlwVhizSm5
Content-Type: message/rfc822; name="Re: amd | ASUS ROG Strix G513QY fails to
 resume from suspend [regression] (#2008).eml"
Content-Disposition: attachment; filename*0="Re: amd | ASUS ROG Strix G513QY
 fails to resume from suspend"; filename*1=" [regression] (#2008).eml"
Content-Transfer-Encoding: 7bit

Return-Path: <gitlab@gitlab.freedesktop.org>
Received: from mx.molgen.mpg.de (mx.molgen.mpg.de [141.14.17.8])
	 by tldr.molgen.mpg.de (Cyrus 2.5.3) with LMTPA;
	 Tue, 10 May 2022 10:09:52 +0200
X-Sieve: CMU Sieve 2.4
Received: from a1241.mx.srv.dfn.de (a1241.mx.srv.dfn.de [194.95.232.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx2.molgen.mpg.de (Postfix) with ESMTPS id 9C06461EA1923
	for <pmenzel+gitlab.freedesktop.org@molgen.mpg.de>; Tue, 10 May 2022 10:09:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by a1241.mx.srv.dfn.de (Postfix) with ESMTP id 7ED61320085
	for <pmenzel+gitlab.freedesktop.org@molgen.mpg.de>; Tue, 10 May 2022 10:09:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mgw6-han.srv.dfn.de
Received: from a1241.mx.srv.dfn.de ([127.0.0.1])
	by localhost (mgw6-han.srv.dfn.de [127.0.0.1]) (amavisd-new, port 20030)
	with ESMTP id 6KHhpr0XRj9S
	for <pmenzel+gitlab.freedesktop.org@molgen.mpg.de>;
	Tue, 10 May 2022 10:09:17 +0200 (CEST)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	by a1241.mx.srv.dfn.de (Postfix) with ESMTPS
	for <pmenzel+gitlab.freedesktop.org@molgen.mpg.de>; Tue, 10 May 2022 10:09:17 +0200 (CEST)
Received: from gitlab.freedesktop.org (unknown [139.178.65.18])
	by gabe.freedesktop.org (Postfix) with ESMTPSA id 51BD210F1F9
	for <pmenzel+gitlab.freedesktop.org@molgen.mpg.de>; Tue, 10 May 2022 08:08:47 +0000 (UTC)
Date: Tue, 10 May 2022 08:08:46 +0000
From: "spin83 (@spin83)" <gitlab@gitlab.freedesktop.org>
Reply-To: GitLab <noreply@freedesktop.org>
To: pmenzel+gitlab.freedesktop.org@molgen.mpg.de
Message-ID: <note_1375796@gitlab.freedesktop.org>
In-Reply-To: <issue_54035@gitlab.freedesktop.org>
References: <issue_54035@gitlab.freedesktop.org>
Subject: Re: amd | ASUS ROG Strix G513QY fails to resume from suspend
 [regression] (#2008)
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="--==_mimepart_627a1d8e3c2cc_154289c149f6";
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitLab-Project: amd
X-GitLab-Project-Id: 4522
X-GitLab-Project-Path: drm/amd
List-Id: drm/amd <4522.amd.drm.gitlab.freedesktop.org>
List-Unsubscribe: <https://gitlab.freedesktop.org/-/sent_notifications/e6179f6336692b71190e18265f7cdf85/unsubscribe?force=true>
X-GitLab-Issue-ID: 54035
X-GitLab-Issue-IID: 2008
X-GitLab-NotificationReason: subscribed
X-GitLab-Discussion-ID: 74f4fe9555791956a10bb4fb07e7b3f5a781f0f5
X-GitLab-Reply-Key: e6179f6336692b71190e18265f7cdf85
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All


----==_mimepart_627a1d8e3c2cc_154289c149f6
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit




spin83 commented:


It doesn't work either.

-- 
View it on GitLab: https://gitlab.freedesktop.org/drm/amd/-/issues/2008#note_1375796
You're receiving this email because of your account on gitlab.freedesktop.org.



----==_mimepart_627a1d8e3c2cc_154289c149f6
Content-Type: text/html;
 charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html lang="en">
<head>
<meta content="text/html; charset=US-ASCII" http-equiv="Content-Type">
<title>
GitLab
</title>


<style>img {
max-width: 100%; height: auto;
}
</style>
</head>
<body>
<div class="content">

<p style="color: #777777;">
<a href="https://gitlab.freedesktop.org/spin83">spin83</a>
<a href="https://gitlab.freedesktop.org/drm/amd/-/issues/2008#note_1375796">commented</a>:
</p>
<div class="md" style="">
<p dir="auto">It doesn't work either.</p>
</div>


</div>
<div class="footer" style="margin-top: 10px;">
<p style="font-size: small; color: #666;">
&#8212;
<br>
<a href="https://gitlab.freedesktop.org/drm/amd/-/issues/2008#note_1375796">View it on GitLab</a>.
<br>
You're receiving this email because of your account on gitlab.freedesktop.org.
If you'd like to receive fewer emails, you can
<a href="https://gitlab.freedesktop.org/-/sent_notifications/e6179f6336692b71190e18265f7cdf85/unsubscribe">unsubscribe</a>
from this thread or
adjust your notification settings.
<script type="application/ld+json">{"@context":"http://schema.org","@type":"EmailMessage","action":{"@type":"ViewAction","name":"View Issue","url":"https://gitlab.freedesktop.org/drm/amd/-/issues/2008#note_1375796"}}</script>


</p>
</div>
</body>
</html>

----==_mimepart_627a1d8e3c2cc_154289c149f6--

--------------0svoNg2nlmSd1VWlwVhizSm5--
