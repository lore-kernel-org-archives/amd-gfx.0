Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B871CA5FB3
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 06:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE50E10E29E;
	Thu,  1 Oct 2026 06:27:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kzTFxD6E";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87A3710E2F8
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 06:27:25 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so45991575e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 23:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790836044; x=1791440844; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I1O/J3qPHy9waunLVJ5FBW9UeEwgJSqlBJyOx/vHvB4=;
 b=kzTFxD6E5UFRoxdZDUfN8zvqYqfYaVoG3GF50f7wboktatZRSA4tzsmSjjnZ9O5ANc
 8Qb9jUC5u8AFCUKvI1BHqa8DTtB6g4Ca8FyN5hdigBxphXFGdXLCCR2BRSWErsEry0vc
 M7wi4XZqlA/vid3EM46Rreu0xQim0JbONwjONdpJGGktY3bqTCLMmdqzJ0WNyMb37LFa
 Qjji54aqEm/VdmQu3ZPnLjC3eF2kWuJeCwnYh5GDKaIOoTyqmmnV31wdyWNxU0Uk5is+
 BZ4F+UoChjBJ2KR5bgmaryv3yJU9vaYWiSvm6gN3bXYA7RcxDraiiSkmAYK0H9H4LU80
 Dl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790836044; x=1791440844;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I1O/J3qPHy9waunLVJ5FBW9UeEwgJSqlBJyOx/vHvB4=;
 b=LHQs1eQVF53eT9Eyr8mc7NJ9RZ3g5p72CPvKZpiv6CJiLTL5PUeBg1AAU8ocSVHACK
 MiMTIiwhJybrxgq1ez+5lIYEeE5lbdL1S2rVkIslsiVVqRdSkjuu6y8qJjTxsV9AcRRf
 KjaP6Gc9Tkz+ucYzS7QIFjigqVV15AX1qw9u8guKNmss4JmY4MZj1CtGCAU9VeKqtsTU
 0YlVQq2VXEIHymuLPj/O8366ys52ls8kKR1vedpr7kvuldAysKIcgdADpzdk94frOjhr
 a9keVeucTnUWSEa6u4EedNS9eow6DDCfGQ774dquQx+3WT4yI8hIrDjTJZvgGF5JXJ1Q
 79Rg==
X-Gm-Message-State: AFuF++mF771QkBzaQyMi0QlkklIVDY5OUJf03FBsfOCZjIR/3hcuUznM
 94687AmVBVZM0RrEVbHo6Fs2FFnek32BZjneRXGWd5qPSD3ktDgdcJ+b
X-Gm-Gg: AYBFou072cy3q58W/+Wr50T9jBgdQod5QbUOxXDk7gdNIMb+Op18o2TIhyRpnAIrYMe
 wMnOl0cCDgNbfVyMACCLYanxTBogaPGovgmmlQuORTA+12nXBsUQR/17QMn90jmjKKPO80IX4Vl
 XBmrQQEwqwZdirPsl2q9fu138iUmZb1msTvwl6dR3EH8ufBMJgbw2RUAdS8chMBMJnFn/vYS3/e
 xwWa69drnICshUzvQDF6Xn1OFdvFkVMUl//yDYwmce2pzJjSZ7JfUaDZIZ4vFKTpjJr7nNThNVZ
 n9ChYWFbVVf++suVCo/6PgpoUIud8gEZTS8aKs6ipLVHUGDwer0aiH9Q6qi2f25AskLGysLnLTt
 7tVFttiZtCET3ntFGifZg934CvcMtMeHhWPNviMvVQqoWhPCdt14jnPa4mAyc3BLwpW0iq9btdI
 hEnJX4kG+g1HE8PIbyWHXXC99geyR0FwOfxkSAlLOiCp+ycfZoWGPRP6Ge6xK9nwd8J5Pny3vjM
 Otif7cz7+Tfm0wS+TjNEduHSXx3cI4NDE9/kj25e6BfCuXapezadbP6rw+V8c8dopIe0eU=
X-Received: by 2002:a05:600c:e54a:20b0:49e:799a:8969 with SMTP id
 5b1f17b1804b1-4a01b12334dmr38663995e9.30.1790836043770; 
 Wed, 30 Sep 2026 23:27:23 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a022619b42sm6812245e9.3.2026.09.30.23.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 23:27:23 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 vitaly.prosyak@amd.com, tom.stdenis@amd.com,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: copy debugfs register data outside the
 GRBM/SRBM locks
Date: Thu,  1 Oct 2026 11:27:17 +0500
Message-ID: <20261001062717.93329-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <957a0ec9-a772-400a-b633-ecf41d16a2b7@amd.com>
References: <957a0ec9-a772-400a-b633-ecf41d16a2b7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On 10/1/26 08:12, Christian König wrote:
>> Fixes: 1d0f5838b126 ("drm/amdgpu: Add lockdep annotations for lock ordering validation")
>
> Well that's not really correct since that patch only makes the problem visible and not introduce it :)

Right. The user copies under the locks come from

  566281595037 ("drm/amd/amdgpu: Add bank selection for MMIO debugfs (v3)")

for amdgpu_regs and

  37df9560cd3e ("drm/amd/amdgpu: New debugfs interface for MMIO registers (v5)")

for amdgpu_regs2. I'll use those as the Fixes tags in v2, together with
your Acked-by, once Tom and Vitaly have had a look.

Thanks,
Mikhail
