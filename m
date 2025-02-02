Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4800DC02192
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 10:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3E9010E476;
	Mon,  3 Feb 2025 10:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="QvpqXNz0";
	dkim-atps=neutral
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8404710E32B
 for <amd-gfx@lists.freedesktop.org>; Sun,  2 Feb 2025 22:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=h8D2rr22gOJ1tOKVrss/WOcI0m3aUBmqqa5JhhAL93Q=; b=QvpqXNz0HbyxCRmU
 kOdLa/7LCj1Z0Droe2a5yrxXp0n7QFKXHr03kleZCZPpFJYLWldVzO9RSCoYXhe2Gw4KbhlrEf+Ct
 D9tYwR85HU24p7+OJA6ocwCAwtXEAIxpqow8S4lkbaRX1FupzkBfY6jAwhwMEY1TF2fjFPmr1dSAr
 pscIlNxvpCFRfC1pSvhNycYB0Az6sMpZKIBxgNbLBeijm4wjdg+Fy3uiq345S8gXnvaV1doOs4bzm
 BuWTSm8pV+b+LZq8GpzWjkNUoIE+bqdSHZhVu08H/0LLTgQCCF+XCmcppjHI4PmIZWj+u+b4AOJeO
 aAN7azeEkWKYMcjFgw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1tei7s-00D9U2-0t;
 Sun, 02 Feb 2025 22:07:36 +0000
Date: Sun, 2 Feb 2025 22:07:36 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Charlene.Liu@amd.com, alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: hubbub/hubp, Missing struct assignments???
Message-ID: <Z5_sqHaGBPIqvWk1@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 22:02:32 up 270 days,  9:16,  1 user,  load average: 0.02, 0.06, 0.02
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Mailman-Approved-At: Mon, 03 Feb 2025 10:51:05 +0000
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

Hi Charlene, Alex,
  My scripts spotted that all 3 functions added by the commit
  dbc2309cac2a ("drm/amd/display: add hubbub_init related")
are uncalled, and instead of deadcoding them, I wondered if it's
actually a simple bug and they should be assigned somewhere.

That patch also added a member dchubbub_init to struct hubbub_funcs
so perhaps 2 of them should go there, and hmm there's dcn32_hubp_funcs
for the other one???

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
