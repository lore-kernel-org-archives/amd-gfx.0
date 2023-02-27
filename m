Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120A5C7EE2D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 09:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B9610E3A6;
	Mon, 27 Feb 2023 09:57:36 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5ACC10E0EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 07:12:21 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id r7so5069424wrz.6
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Feb 2023 23:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oyeg5wP42IWBECtz7xqXMlTgUnHhR/85mRaNmVQW2Ls=;
 b=F5CvI9/LYnbqJtmDeJqmvrF3xrxJEFOycgowdmuGjcFdBzk21YLSTIrhXUTydn8geg
 PiA955VCXC+ftrGO6UOdixA3lw20EdiXgbZ4JqoYEVVOeDaDMw6y+cMTR3RTNjQppayh
 Y9Wq2Zy6xDIIREKgVQtloQkxamFe9IB4KZpMOwSIF6e3K3YJdPm5/M6ANlcgBY+6B6PG
 M4r7Th8kJB6Q04QEah1raqctSYQhUxDaB5Bvh1+qXQNVbirz5D0rZ5jvzu9n9jdMnHcO
 INQDaVgWNWLFWFQYP2s4TrASnh54G50k+pZHDgkDtfpjw9LItNCwMYN2G/3AaZDnOvuq
 r03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oyeg5wP42IWBECtz7xqXMlTgUnHhR/85mRaNmVQW2Ls=;
 b=HACkflyoa682impr6mepaDHWtJwciQxFact1OGkFHnZ7+crmEiPZhm5GEkWHJVDDum
 hTddpfZnY3qNRqNdl7APrwekAPPAJE64I++DYGkv6Y5PaJ66cEb7I32odbuLK8je5baz
 wdhsV8uPka9Ah2rfLAO08ePpI7gKPSv/FE92QB0Mo30tXz4TH9bwkBjk9EGotkpnSz8L
 PXK1PIggDJ5pwRcYGypdSUzimHSpCT+LAmJ00FzMeg1iAbAIdS/tKtKbgn76NdLOEE3e
 BYC48hhg4hNvaVMUKcEs+aIED7BOJV6FR0I/8U5oeFGLSRKt0QLIe//CPdKUHbuIB5wC
 bqmw==
X-Gm-Message-State: AO0yUKXh4Sz1Q6gxk/GRMKNI6X1EjjR4uAZIzdZ7SjJ3k7CtLUKlj8cH
 rfJogvGtVZy1qE3di7dnp0M=
X-Google-Smtp-Source: AK7set87N1youREmQwxO6+eyumctKwvn8O/d2IWNgToVGwYeD7gFXj/mLxH+SNAyaJpv/V6YJQeOzw==
X-Received: by 2002:a05:6000:10e:b0:2cc:26be:8aad with SMTP id
 o14-20020a056000010e00b002cc26be8aadmr614248wrx.45.1677481940082; 
 Sun, 26 Feb 2023 23:12:20 -0800 (PST)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 t3-20020a5d6903000000b002c56af32e8csm6260829wru.35.2023.02.26.23.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Feb 2023 23:12:19 -0800 (PST)
Date: Mon, 27 Feb 2023 10:12:07 +0300
From: Dan Carpenter <error27@gmail.com>
To: sancchen@amd.com
Subject: [bug report] drm/amd/display: Various logs added
Message-ID: <Y/xXx2KXpxI2WoF8@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 27 Feb 2023 09:57:31 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Leo Chen,

This is a semi-automatic email about new static checker warnings.

The patch 7ef414375fcc: "drm/amd/display: Various logs added" from 
Aug 29, 2022, leads to the following Smatch complaint:

    ./drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c:1862 get_firmware_info_v3_2()
    warn: variable dereferenced before check 'smu_info_v3_2' (see line 1861)

./drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
  1860								DATA_TABLES(smu_info));
  1861			DC_LOG_BIOS("gpuclk_ss_percentage (unit of 0.001 percent): %d\n", smu_info_v3_2->gpuclk_ss_percentage);
                                                                                          ^^^^^^^^^^^^^^^
Log adds a crash.

  1862			if (!smu_info_v3_2)
                             ^^^^^^^^^^^^^
Too late.

  1863				return BP_RESULT_BADBIOSTABLE;
  1864	

regards,
dan carpenter
