Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FE3D2E03D
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 08:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C5410EA61;
	Fri,  5 Dec 2025 08:19:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TpjPLrqo";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F7110E9E5
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 23:23:38 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-641677916b5so2424466a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Dec 2025 15:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1764890617; x=1765495417;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GAMF2P1zYp58T4w3wjWAVp8ef3GzCCouN500xAHns+k=;
 b=TpjPLrqoar8D9m6uMMJ5wR57zoEvrkQefCM9fNnvJfTvLJdflAt9B3rG9EdlJWLYfp
 8Y6Mim7k0kZ+CBVdvpyokl4j7nlhCEg8LOJGMOtQb+3vV4fIQrRbsJl2SLXBTjg5FvBL
 m3seBLeNG8Kx8113x5ZPOFO3gd2bKWjzooEKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764890617; x=1765495417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAMF2P1zYp58T4w3wjWAVp8ef3GzCCouN500xAHns+k=;
 b=J4rp0ChPaTWClSCkBA7K1W1fFiM1NHkUL+3yiP+qJ5wHerhemuMgEJRPtQNkU/YkFf
 CR55OH359qeQFz3ZQnW6XV7b69PoogWC9iUURzmVPLkjeL94suqEuoFcOCj7Gicqqlh6
 s1gh9o7wZW0KL0Ft6A5i6hmFwwLi4B2cHKorUZQqAeUeKb9X7XyKkd5lmrNMDTmhykUo
 i/axqPhJvAzyCpmFYCwZQlzL7MncUxMUhnt7KSYISCMOEhrZgMVYngDlk//lr5Xpv8oo
 vUbX9YmoNqRQiKxsCsjSR6/apQWx83fiihfAKJ5I7UXswr5VxqQLDxe9QIIsYzW2tRt3
 I3Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8N1R2RyUPPtbCXhValHCb206+kM21GJOmKsunqPFoUzreu4xDU3XrUFZHJTEAVQtvlzbia2U1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxK6k66aIF79gqvBPQHT69LT+qKzaAVzvIX/QxKJ4Gv2dFlFDmk
 Bk6Onpyti9goiK9nDbnxu2wl5RKZAagCin4RKT5YGyKg4hpBM5JlHoTpLJlwNRWOgwzJVRK1vUn
 ylI5m0Nk=
X-Gm-Gg: ASbGncstxl+e8ZqI9McqOmPJbnyzy+BJvclrrHiDifWrx1Zzq7R3+ULLDDi4yn3+dEt
 Hb08oaUSrnalBSGMJLAAP5qyIrXNoS99eZXjrZfH/N0lfwOTODyFOzXaXntXq9k8t6KOLYnd9Jb
 x5YUpuV3ARlH75Js3FYxWegd2d8jnrRLsH9Gl+NUhv97X3SDcuKIRw95GwldKWcTD2Vxyz131Wt
 bqAR7gT+z2McAtjHm7Xlg9lEt8r8EqmqYN/tmVpA+GpzDGY30ets7MCx513GeQkYA8IpHC84Cwp
 hwrAP4Gg/KvpWqCXJ3junsejHLqPi97uQ6/U5dMBttqF6l2asHvXx0NNAqzE53AGQnDjrAIfBGN
 spEqtuBlb/Vj3fcox7ALoSynWhhVclamUA40ZoyThcMfSoRdJKZ9hMNoUwCT0CFiyCC/WSTAOWV
 2cXcuymHzEtXJxU1hfqiX3aRLSfx/5h8jq+c1JeqrHxQ/UfgC2CquVZXgAik4P
X-Google-Smtp-Source: AGHT+IF761uwQKJNWZvp6LemS4G4ROU7d1B+RO75T+LJPJvC/lMCenF4TBwPcXbobsn2P/CF9KMdKg==
X-Received: by 2002:a05:6402:a259:10b0:640:fa18:87be with SMTP id
 4fb4d7f45d1cf-6479c4854cfmr5384038a12.23.1764890616607; 
 Thu, 04 Dec 2025 15:23:36 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com.
 [209.85.208.45]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2edf71fsm2559799a12.14.2025.12.04.15.23.35
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 15:23:35 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-640bd9039fbso2477301a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Dec 2025 15:23:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUu3zGws9AcT9GpGBRlK2Hk9O5H5T7kB6MlqH2cHeU1jxh7yg/B9zp9zEl9e+sU+R0H62rqEqzM@lists.freedesktop.org
X-Received: by 2002:a05:6402:278d:b0:645:c665:56bf with SMTP id
 4fb4d7f45d1cf-6479c484fcamr6984906a12.24.1764890614735; Thu, 04 Dec 2025
 15:23:34 -0800 (PST)
MIME-Version: 1.0
References: <74032153-813a-4a40-8363-cce264f4d5ea@linuxfoundation.org>
 <1eb24816-530b-4470-8e58-ce7d8297996c@roeck-us.net>
 <0425d7b4-76e4-4057-83a5-a7b17a051c54@linuxfoundation.org>
 <ec77d11a-7613-4b75-8c9e-f2bba1595f0f@roeck-us.net>
 <9d520a1d-0b8d-4d30-b29f-230fc0f92b8a@linuxfoundation.org>
 <1f31b86d-283c-4878-92d0-ab90aed0c58d@roeck-us.net>
 <5af4522e-30ab-4eec-a861-c2760cdabd4f@linuxfoundation.org>
 <2bc690ca-fa57-46fa-949b-28b5441cd364@kernel.org>
 <b24fc85c-0e6d-42f9-a6b9-05136409098f@linuxfoundation.org>
 <CAHk-=whd-k3GhNGvVmP7W2p1d0d4ctqJ8iCuG8DbyKzgNqCL+g@mail.gmail.com>
 <3b6d6e50-91ac-435e-adad-a67d4198a5b5@kernel.org>
 <3cd2240b-ec2c-45d0-b73b-b66c83e75b9f@linuxfoundation.org>
In-Reply-To: <3cd2240b-ec2c-45d0-b73b-b66c83e75b9f@linuxfoundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Dec 2025 15:23:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEXy+7Gd3ONQ-v0e61e6qAmrtk+WE2dpW_61p83nMgXw@mail.gmail.com>
X-Gm-Features: AQt7F2q75KScWbWqgcI8F4O4T3lWb1voNa-u0o71vR1GfvutFdi37cFnKktDY94
Message-ID: <CAHk-=wiEXy+7Gd3ONQ-v0e61e6qAmrtk+WE2dpW_61p83nMgXw@mail.gmail.com>
Subject: Re: Linux 6.18 amdgpu build error
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, akpm@linux-foundation.org,
 Alexander Deucher <Alexander.Deucher@amd.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel <dri-devel@lists.freedesktop.org>, Guenter Roeck <linux@roeck-us.net>,
 Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 05 Dec 2025 08:19:27 +0000
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

On Thu, 4 Dec 2025 at 15:20, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> I didn't see any problems on 6.18.

Ahh. So it might be just that buggy commit adfb6609c680 then, and the
fix already being in rc7 (and final).

              Linus
