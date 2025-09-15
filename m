Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18E6CAC59A
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 07:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB7210E6BE;
	Tue, 16 Sep 2025 07:21:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TKMxGOJF";
	dkim-atps=neutral
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF72A10E13F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 23:02:39 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4b5eee40cc0so47795081cf.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 16:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757977358; x=1758582158; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ua7l1bqzQuCWyFV9tIRGLf5KyT7bRmbeKtayL/Sa8go=;
 b=TKMxGOJFD18A6fp8085rnaLDlQ7Dxe/n3szqHiWS1L1AKKW1ZyPHus17Tq6MxrroKb
 D7VYdRGnjFJL6c/CfI0+lOREOE/9M0d73ZgW7C20wz9pHHiKAHFyvz+uYZ3+A+hr21Zw
 2dD2stCycZZQjCNGJBVINE1zVWlSqU/JW/3QlbVYmViRyW61bF7OZcZkOkaxH0T7zCKf
 AzuBD1VOYtmlDsqFMNzV16uEMmbSUD4wcc1jJoCe/4/qacdFIFZyq1+Mf0c/GOSsq/tM
 PUnE4B/+4GAU58URim2RX8qcd6u5LlX7wE3PAs1JV6BIKxLRkHM3c+LM6jqGW3Yr4XU/
 kXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757977358; x=1758582158;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ua7l1bqzQuCWyFV9tIRGLf5KyT7bRmbeKtayL/Sa8go=;
 b=UzDBUl9pKPDkyW7TY3PwKewHFrBpg6aS1aIhOzIRviT2DovJ3Oh9tcNt3+LrNusgtj
 j1ulnxeqG21NslxkREfTS8rTK3mK8TAj4VvztReyISrD0VXFbzeP1OVGTNQ6EMIjE3BJ
 OvtZURjGI7iItgYE5Uh1fe2Bw515eMrnVRxjjUvAvQB5tYVR4pdxwpyM6N/z+Kff3Wo2
 4/c7LqsJGLeyv2Eki6aeWE60fin4TXa+GjQcXs3ElD5nGk2X3Er/s8P6crHqCpNJIKgC
 jGfwHVEyORGnYWrKb8TIzkE20r2cP8h3Pwe1Zg/bphH8DAi/edCwiUdzG1M4QXcEo0Ua
 Tt7Q==
X-Gm-Message-State: AOJu0Yzp8KsHD2pc9+r3P3W3hGUSN9GG/o5iTz+SqraEmqCnto241cmp
 5Wl82M7KxIa1f1uY3wTA3QlQHbJjvt1UQ3feU6Xmjkg259a4ITD+FNyn
X-Gm-Gg: ASbGnctit1jmrkEtdO5dP0QmU/7GC4yg1bVD0hpmQCr6TlvJq7IrNgeW4jjzTgDLxSF
 tdeg79PJUgd51WqcQ/YdNTjwZNZEgsTlSdRNrQCao8rihRDOryGd7JyG19Rl3n0o66TLO5V2Dya
 fje1y2LBcvatn2QtI8OoP1Zr1Ar9f1+6MXd8w4yzQ2fpc4GgLFZ9OJwJY6yxNGQnrxqQb5tVpjT
 lfB4E0nw64XQRDi2PV38pdd2QwoVxq0GL5sA3ORO+aBzZP7Cz4Pe+lijvKtMA6p1NguuqC8PQQS
 uRkpmpIyBWvrOGYRWF4sU8SgMfoWh9G/jeaCJbVukTom9bVKiHdNFpqU4PnGYG7duXatsOoiVWk
 7Su373ppMzfsKUBwsnlAK08gvMgB8JO5gXjLXR8dbYSV+yWnMf5cQtr400bLjbcw0EX/Fc59k0+
 bDTviHJopvGQ8=
X-Google-Smtp-Source: AGHT+IEL3CC8YI/JRiZOHg5Ppn1FQSD6RhZ4YQMN0AMHBA3ioVI9iNaOVowwbde59HkrjMjwsnzYkg==
X-Received: by 2002:a05:622a:55:b0:4b6:226b:b6b7 with SMTP id
 d75a77b69052e-4b77d1b243dmr217362301cf.81.1757977357464; 
 Mon, 15 Sep 2025 16:02:37 -0700 (PDT)
Received: from ?IPV6:2607:fa49:655f:db00:25c1:6b2c:46ab:8758?
 ([2607:fa49:655f:db00:25c1:6b2c:46ab:8758])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b639cb2102sm71918461cf.16.2025.09.15.16.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 16:02:36 -0700 (PDT)
Message-ID: <379880c4-d8e0-408e-bb0b-766389f10a38@gmail.com>
Date: Mon, 15 Sep 2025 19:02:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [REGRESSION] AMD GPU not detected since 6.16.4 commit c97636cc83d4
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <12e266b6-b708-43c0-8ff3-db0058c35742@gmail.com>
 <0ffe2692-7bfa-4821-856e-dd0f18e2c32b@amd.com>
Content-Language: en-US, fr
From: =?UTF-8?B?SsOpcsO0bWUgTMOpY3V5ZXI=?= <jerome.4a4c@gmail.com>
In-Reply-To: <0ffe2692-7bfa-4821-856e-dd0f18e2c32b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Sep 2025 07:21:45 +0000
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

On 2025-09-15 15:04, Mario Limonciello wrote:
> It makes sense.  Can you send out a properly formatted patch to the 
> M/L with all the tags (Fixes/Closes/S-o-b)?  Or if you want me to use 
> yours to write one and send one out (and give you a Suggested-by) I 
> can do that too. 


Please send it, I'll learn that another day.

Suggested-by would be great.

Thanks,
Jérôme

