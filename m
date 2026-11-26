Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF77B606A326
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mv6G+C3F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744C3112105;
	Thu, 26 Nov 2026 08:09:35 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B678A10E394
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 01:41:38 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-386bd881d39so5889255eec.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 17:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795657298; x=1796262098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ExzTqbqi9kFA5O0q4Lv2u4RJkGRDRHkXl4U1NnKgeXk=;
 b=mv6G+C3Fz7Q96Wo2T+UX1jnL1e6A3q+887XDMR0VnpM19AHoHGAGb88f8eLtdYJjCb
 iaoveQ4UlU4fiIAg3/rq8inFZssgr0E4Aq/5XS8fhlLKM94smVMsYOEckrdJSbMmR2ZE
 JI/YSSNcJZG3saKt8IrK03D17o7Aup+nRmE9eCDU6fat4AEix9Ze7vJUdwBhPYsnxaAD
 pndEQ/d9MnvUjq1q0Sw+XP1A/5kmtkL1lqDSZEfy+ly8b5oO8lYHhxubm7n5z2P8oLYB
 yHbA4nn1EhmXtL4RnL3mX54Jitxj+AwIhCOLPzBHuwK04RjvmPHYMF2G6RQeamZFobnD
 xBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795657298; x=1796262098;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ExzTqbqi9kFA5O0q4Lv2u4RJkGRDRHkXl4U1NnKgeXk=;
 b=pkvOMrGyqFvsiSUgZM/96cI1C7HOffZgiWn7YPyY6+aKfRsXTfs5Wv+n1dayOeo01z
 2Rh9Q2NSTLFNHbxZMAUU/gyROqQH6NZHCcLubeCrX2uCLO6GrokwYmrEZIZQHhLy8/zf
 18IxoW+9/l7vr/agH66dJdxZ8OPjmv03/+2oPdza5Kwf0TcsvOzqeD7JDsWdsjDJdPH8
 OTWX+kM++0UruQKkQjZ7UB5KHoi4MUaIg6yB7vh7MX51Lt9BLStZn5D2EEOF8VCSJ+qQ
 J4AMgx3BWntqEdOXYzrFuEZswImkpQrobk5kD3DOsucs3en+UlAC6IL2gR2Wh05Kr5bk
 E/8A==
X-Gm-Message-State: APuU4Z85PpKTDw+Sgw5OPQ61fzlBnkauH2UC5wV7lx3495eNSM7yI2fN
 nfNX9lLRU4YX7leK0MLA6PfRiPU4xHehYvC3DY1Yr/N/2jaq9x7/IwLafPtxClZU
X-Gm-Gg: AZFdTZeyVOPnEIICudxTkNkdZBf81moXjp9mIgizguk1H4H2p82l8p29QI5RrGUsBzQ
 jA8PBc+dNAQyJ6bdyU/1A0dmJKcs3jOpDzzbeFfS/9Uyaz8JDTFHsbd1LdEM/OdXnb1IDGRTly5
 eX6fYEoPx28LQpWVbyjYgucTWIcnMjeEXjfLkH8gEqbDYcQPe0ReEGbEnUV9/buMxahXo1w+gFO
 1G5Qlzwu7vKMTaIhg1R84uGL99CiGxzIptJE22DgTe5yuiZzZI3B335IG0ztfnFQHKUIzLKYBlr
 1rZO+y1Vo8y3bciClNKdOU8Kf+32A/T/u/z9SN8ScAHHI/0f64optGpFdzciWe0hKAuWLXjMJkF
 5ttZ+fye0ZM4mWSI5BhP6QBo2I41nLDQLsmK1PsQDJMHGPuHFt8/rWvtSoU7CA93129T+K77yVZ
 UNCvwq9lFRdgIQkRwO/neFTFFFZpKvC9DdcFmTOgTN5RT4pJq5bZvdzSWa56gi1OvgSMGJIn8k1
 jCYFi2pgidEUY60zDjxwQQA8iQT3O+DYk90ZtFgWLTu6RHYPEYTgRzQmHmrf8u1YOldVjEAbUjY
 cLzsU1EKMBNRdJ/qStaHI2XIL95sPP1aptoVv5s9OtkjExE=
X-Received: by 2002:a05:7300:f789:b0:386:abe8:32b0 with SMTP id
 5a478bee46e88-386abe835b7mr13118191eec.8.1795657297739; 
 Wed, 25 Nov 2026 17:41:37 -0800 (PST)
Received: from [127.0.1.1] ([2603:c021:8021:f000:0:1865:8c38:18fc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385f68bc0adsm53381126eec.13.2026.11.25.17.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 17:41:37 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Weijie Yuan <wy@wyuan.org>,
 TAKANO Mitsuhiro <takano32@gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amd/display: Document the union in
 dc_probe_status
Date: Thu, 26 Nov 2026 01:41:35 +0000
Message-ID: <179565729553.2633668.17477740633249957356@gmail.com>
In-Reply-To: <20261126012316.2624853-1-takano32@gmail.com>
References: <20261126012316.2624853-1-takano32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:09:32 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sorry, this pair is a duplicate and should be ignored.  The same two
patches went out as v2 on 2026-11-23, already with the disclosure below
the --- line:

https://lore.kernel.org/all/20261123122226.4101191-1-takano32@gmail.com/

The patch-ids are identical (5d8ecdaf, 9254cd07), so nothing is lost by
dropping this thread; please use the 23 November one.

TAKANO

