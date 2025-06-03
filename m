Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D97C5AD49
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 14:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DACB10E63E;
	Tue,  3 Jun 2025 14:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JM0OAZb3";
	dkim-atps=neutral
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEA0E10E605
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 14:34:43 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7d098f7bd77so606885285a.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jun 2025 07:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748961283; x=1749566083; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8uj9KUGBVGV6GoirwHQ7OfWk3qRg+Z3MFQVtuuH4j2w=;
 b=JM0OAZb3aflrMTPDQzrRAZMSupf7d75Z84LjLTKWiEmmW0cwPIA9tj1P7Mxwzy+9tN
 q0P+LwmG8guXiBIJ5qNfhzs/QalbvcnkKJ/iyuSwZ0/KOPhfaasGB8CS8NsBWylV9JKF
 fmUih9h9iNNyKXT3yss63exA3rqY4jkOW+NkaZ9OP91Bs/3WJqPmI6zyL+mWkbwOH1HA
 N2fG1UmFbAnyGserh5ia3czE39DVXPcLrt/rXww/JoA2HnE89JDNsZyW0oYwwS1tDpF0
 rrGG2xaeG2W+AFuWrgZ0ftJhvoSs490FImucDQBJ8edUaIW4++0UDpmUEwemAHEJKJqY
 A16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748961283; x=1749566083;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8uj9KUGBVGV6GoirwHQ7OfWk3qRg+Z3MFQVtuuH4j2w=;
 b=C+tCScR0xqCOobsxLgvQcVwJEd1OWhDltbh7TL1uZIP++1isd0mmu/NnT1+/cATMam
 M1tXzPk7PxQgFPnrpQOfsnMC7dNGGPTt9eMASA14y//7wrKMF6MKewerYJx4g315DFRW
 LOEJkCq/61qtXzJd2RKnv0+l+nmXJnO5rSDjQtCHrH4dmnnUdMCbR9QPOxPs4JJap9y8
 dkFv/ADbds9C+wLCebKbJ036WbpNf8eLXEfJRDr5AoN25+vTCskWoG4c66Mkby1TT6km
 /lGSb+PJWhInJBqL4Jmu9tUhZUu7HY45OETydasn5VdeEWB20doLxX9IQ7JmIVThSxrL
 2uNQ==
X-Gm-Message-State: AOJu0YyYfd2ranBjFtYRz9cBlgY9SGAsiHyEIdC15GMAgtIqlJEaWGRM
 pYTtPDKfRXmFcTCTAt4VvogWzj/yJc0kCn9YdITR6NqdwAsoGTm05pbABKfBTSO/
X-Gm-Gg: ASbGncsGdYj8XDaovwG+2h8NzvsureUAIGm3px/53Y8UxfctQQAQKO/QhLpVtRM5mhz
 1qJgeYONYtALO+Ly7HNkpodOt5gqkURcloOhqsBQQb/LX78AtTM+gfsOscw/5tmoHUz+B1g98it
 GYh6PL47d3ovygXqLZGyX+X5jbeAx/KLBu7MVjk+rSiuaAnCl12OHl847CRYOuUlk9fXvkK9X9e
 RaAX3r3fdPuHxlPiPASnn0TiPXUtPimQkzQpp2uZfsRSqBl4nsCy19+qHrSPJHys/WrySBdaSJ+
 GzsdLZWapgo6AbHOGUyTxfeOzOvDN3MkWyOvTyZXLSxzdwNg5h24xX+COJhcrTGJPxK5E60=
X-Google-Smtp-Source: AGHT+IEI8jAuR6Vvo15PjSzetVtHhrA3ZZABpGbChYkrqYr2OC8ptm+p7Jir5spu+xlcLYHAjk+rjQ==
X-Received: by 2002:a05:620a:294f:b0:7c7:c1f8:34eb with SMTP id
 af79cd13be357-7d2115a8131mr412448585a.23.1748961282704; 
 Tue, 03 Jun 2025 07:34:42 -0700 (PDT)
Received: from [192.168.1.100] ([32.220.111.111])
 by smtp.googlemail.com with ESMTPSA id
 af79cd13be357-7d09a1a7699sm843547085a.98.2025.06.03.07.34.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 07:34:42 -0700 (PDT)
Message-ID: <a28a0a4d-614e-4ba6-a8d5-8ab06335f410@gmail.com>
Date: Tue, 3 Jun 2025 10:34:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] drm/amdgpu/uvd: Ensure vcpu bos are within the
 uvd segment
From: John Olender <john.olender@gmail.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-3-john.olender@gmail.com>
 <CADnq5_OBUWJj5uqbB78wLkbBAMtoRUy=Nes1O6garEQceCLB3Q@mail.gmail.com>
 <b09012e2-f361-46b5-afbf-313334fad69a@amd.com>
 <7efe97e3-adac-417b-8f0d-50ec4b2589e0@gmail.com>
 <6288c9d8-9a18-4027-ba50-258f837025a3@amd.com>
 <2d3fba88-ed8e-4c3b-8fb4-56633ab0aa08@gmail.com>
 <ced428cb-798e-463e-bdc6-4c01f9562c58@gmail.com>
 <5eab610e-26d0-4dd3-b46d-e61fa44364c2@gmail.com>
 <32880a04-c459-43bc-bad3-424d3b7306fc@amd.com>
 <4b919d57-1f90-48e8-9c7b-5a1814c4a07b@gmail.com>
Content-Language: en-US
In-Reply-To: <4b919d57-1f90-48e8-9c7b-5a1814c4a07b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

>> Oh, that's a very interesting find. Could you try to turn around the way the patch works?
>>
>> E.g. instead of forcing the UVD FW into the first segment, change amdgpu_uvd_force_into_uvd_segment() so that the BOs are forced into the same segment as the UVD firmware.
>>

I started implementing this and I realized two main problems with this
approach.

First, there's currently no guarantee the UVD FW does not cross a 256MB
boundary.  Checking for this and providing a fallback is going to make
this patch... not really any less complex than the original.

Second, most of time this is just going to end up selecting the first
segment anyway.  I'll go more into this below.

>> That would resolve my concern that this could overload the first segment. The feedback and message BO are usually rather small (4 or 128k IIRC), but the firmware is a couple of megabytes in size.
>>
>> When we have other FW and VGA emulation buffers in the first segment as well then that could result into clashing that segment to much.
>>

During my initial investigation, I found out that the UVD FW got placed
in the first segment *because* things were already placed there.  This
is why adding a 'stolen_vga_memory' substitute was an effective workaround.

So, CIK is *already* forced to deal with an overloaded first segment
and, with the inverted approach, will continue to do so for typical use
cases.  Explicitly placing the UVD FW into the first segment just makes
this guaranteed.

I did implement a module parameter for testing that allows designating a
specific 256MB segment as the legacy UVD segment.  I can polish this up
so the user has the option to manually relieve some of the first segment
pressure on SI and CIK devices.

I haven't run into a situation where I've needed this during normal use,
but I can certainly appreciate it being available.

Thanks,
John
