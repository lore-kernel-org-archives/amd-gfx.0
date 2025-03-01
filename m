Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E61C282C6
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Mar 2025 02:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D11BD10E0DF;
	Sat,  1 Mar 2025 02:22:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YlKCv/s6";
	dkim-atps=neutral
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E12E10E0D8
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Mar 2025 02:22:18 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-6e89b6b5342so22130426d6.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 18:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740795737; x=1741400537; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PCgAvAQkvFwvZHHgw4iRSZFYnj9m9aXH9H706dhxHVg=;
 b=YlKCv/s63IcmcgMXxG/V2AURam8Xjz0YXtkd7S7p893GKQrxBLfFq5p2koNoCeWHNt
 J7ZXYCE/aSNMRZRnJFT1L4p6yyar9UHCFrpeE4jgWxeGUDQ+LKYre5yiUhWulaz9Dh4C
 F6Fk6fraxRgppRVZrr5onGT9DIGAvzPyL77ekyj8qGTKSNCAULarZZNGaY35aSwk8sao
 n0+Gsq8TfdXgmkYgiKvkmVyvZf2njeRt3HNK6rb5laA9R4jeZ0UfJcrmSYrlCPxLUcD1
 h/Qy2j64Fb0v/wtcO9/p0OS1ftfRvg2AdWyyTIXwrqhswsU0VrPlMBMbypZC0p36Pt25
 hqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740795737; x=1741400537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PCgAvAQkvFwvZHHgw4iRSZFYnj9m9aXH9H706dhxHVg=;
 b=Keky4YR10jVyy07/J3ft+kaeyJJ/EdZuCo3l7Hs2LSD4PPsR0rIbQM1+xlDRwHyV/X
 wRARFqwZIO9ibEdqL72FG/pFw0xMO72U8iZUDo0CiOVecv5AnHFtLf6KjoGKku99pz4A
 QdwYkSuo2kCQXpOUI/hW2TZzJcOhznkdy8jtBjx8W1CZa4dg9bdIvSDBQrhj61NMHh1b
 4aFz/9xlSmPkA9l5pJim/mOsKJrLOUizh5plcsbX/2gn73AJmkEDAA4eIYv6gz4czYYz
 SsAy1K4id6Y76jDKDzkLPkF2/+3AqOmMoScXaZUB3z0B1WdKBw5d+aeDg1EbwOKoloxS
 M18w==
X-Gm-Message-State: AOJu0YyVgctqvxfDJiaAHXVsk3wMh7HH/gnLAuPU9VZfQMRSK6Rxn8CP
 mxUcayED6yXDkv/1u748cBUN3HOsP3uDRmuT7b+89D51xQNrzknkAUbSKg==
X-Gm-Gg: ASbGncsw9SBQq5prabhmVkBkr+pB4om5ZtYPRCPgQUejjY6cTIw6VpdJ0aAi22TayN+
 GGRcs2JeSxamQP5hpRMUKU5yi46lLOo6cyZhl7N8Ir1LFGQJ79mw0tXFGpHvkxVC3jeDDXdDRwC
 XR5/1ko/OmVbAhUWIYCq1y4ZIZD5+HVNRsgaaRG06LdZcnO+QZu994aHI64oKUwlpSIg7XY2cSt
 95VudoBkiAzJJO3YRt7RrOWqeuZcpzZUCXzl1iamwZSaWVVw8lc5VsJDTyPpKvEaRlXozmyiQ5r
 0aJHOC1pWf2UNXYolE/I7Fg7nckuwTzNjQqMDS3+/sQmjm3kXYHHlsMc7QwMZvt19qk=
X-Google-Smtp-Source: AGHT+IE4aAdgcPwysjGb6vgwtatwYx4EqjNc/In0tsEAAPNZg+FjfV49hLVVlx6QIFFtBO4Y0LhgDA==
X-Received: by 2002:a05:6214:da1:b0:6d8:e5f4:b969 with SMTP id
 6a1803df08f44-6e8a0c9e4a7mr95175186d6.10.1740795737376; 
 Fri, 28 Feb 2025 18:22:17 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8976537afsm28489106d6.43.2025.02.28.18.22.16
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 18:22:16 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 0/2] drm/amdgpu: fix style and comments in DCE6
Date: Fri, 28 Feb 2025 21:17:45 -0500
Message-ID: <20250301021747.28827-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
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

While going throught DCE6 code, I took on myself to add some comments
and to fix style in a few places.

Alexandre Demers (2):
  drm/amdgpu: add some comments in DCE6
  dmr/amdgpu: fix style in DCE6

 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 32 ++++++++++++++++++---------
 1 file changed, 21 insertions(+), 11 deletions(-)

-- 
2.48.1

