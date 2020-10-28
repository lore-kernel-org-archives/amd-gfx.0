Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C032C55178
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 15:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A94C247B1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 15:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3eqLjZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A94C247B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58E986E110;
	Wed, 28 Oct 2020 15:07:01 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8B86E110
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 15:07:00 +0000 (UTC)
Received: by mail-yb1-xb43.google.com with SMTP id a12so4530598ybg.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I4/tpkkfqIBgfhcHCh/PDfY88rXA5FXDUceT4s9Pktc=;
 b=L3eqLjZ5olC0mGmbTRJP2vHL9GMtDMSGokCY+WS2CPFzMnLJB65dV7ZB2mNO/d19ju
 zNHRjf5AIrk0bsLqD6YOX3GridyeuAm7aIxtwmt3KF6Y4AwqytVPmQOyYYQupSf5dM0G
 jg8AuHQ/Iyx+y8FG1oANmBW1tLSHkS08el4YEyP5V2rrGRaIpES1XSTATD2mY7bXlzyi
 GBuCIE/wugXmjCqzIsmGGza0zxJ/Ie05ssMk/QCRK/Yaw87mQocOXXiIO+YO6G5RqLDv
 XrktObPvy2ugH465evgL3mJzMmaArcTlPtmZ+5kmoBgK3EVSyJP7AjkU/HstCOgU2VLn
 58VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I4/tpkkfqIBgfhcHCh/PDfY88rXA5FXDUceT4s9Pktc=;
 b=sNGF3QIvdoLC3xJS5p/tvDNwYBmZ5k4Cp3Whl90m4THyIWW9UWR0r+GR0CySkiWLDh
 B0kVNjbeHu88EBu+03Jb/oKXqyA9cpNqt7Sl1syt3/66dfGt8HSkC7Sc+TommhHP8d6T
 4tBdL2Yra3qnkM8P+2jlIZ09ZdnQ679LREc448MXQWQ+u2FiGTJZCPPHnpPIfeDNn4Fy
 osn4+rCcOIKc7aM6UmMiamU+UE9AdX6EKLNzc+FikxHBKtpIPeay4tt47c70KbmPW4Nh
 R5yR1lIz8dM9oqzpJ+3lXPacFcgaGHvd6nAjXoSSkn63eolCSaRv/hJtLlVLhrAaSG6H
 I7EQ==
X-Gm-Message-State: AOAM531vdZdclEnWTYlEawvCbirJJmn6dUeMiI4xNUHttpkqiJSbmH9N
 vPGI/oBK+WRm5PYhgB2OZEkqVe68fSGJqYbGadc=
X-Google-Smtp-Source: ABdhPJw4HTAHNMVlivM8wYNEIEQQuIlCu457WVKW+lZzguiX+zHfqZ/yuanCLC2Rks8x7vc4RqPuVOgwodalaxGHv3Y=
X-Received: by 2002:a25:dc05:: with SMTP id y5mr10756550ybe.98.1603897619381; 
 Wed, 28 Oct 2020 08:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201027024025.32269-1-evan.quan@amd.com>
 <CAGPDPzDniqOW7YyRQht0Fx7uqReQk3zm89rwsZJEhjtrt4WN_Q@mail.gmail.com>
 <CAGPDPzB69-phK2hPYSv_qZLO-gB1ikMrAZRDYE85pO0rFAXSFw@mail.gmail.com>
 <CAGPDPzBbEspwRvgnzKt+siPDZqGMFH0Zunc3GXVPUzSb3U0hww@mail.gmail.com>
 <DM6PR12MB2619444751837A8BAAC3B2D2E4170@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM6PR12MB2619B3319B3CB174006B5F74E4170@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619B3319B3CB174006B5F74E4170@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Sandeep <sandy.8925@gmail.com>
Date: Wed, 28 Oct 2020 20:36:48 +0530
Message-ID: <CAGPDPzCK8QaVRfZFvTx6XQO7FcKDBMQ1kd91RzQwMh0oaP0QNw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: enable baco reset for Hawaii
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 28 Oct 2020 at 14:03, Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> If it turns out "PCI CONFIG reset" is used, please try the new patch series I just sent.
> https://lists.freedesktop.org/archives/amd-gfx/2020-October/055327.html
> https://lists.freedesktop.org/archives/amd-gfx/2020-October/055328.html
> https://lists.freedesktop.org/archives/amd-gfx/2020-October/055329.html
> https://lists.freedesktop.org/archives/amd-gfx/2020-October/055330.html
> https://lists.freedesktop.org/archives/amd-gfx/2020-October/055331.html
>
> BR
> Evan

I tested out this patchset, and can confirm that both suspend and
hibernate work as expected.

- Sandeep
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
