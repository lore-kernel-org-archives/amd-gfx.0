Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AACCE8D6B
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 08:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6080E89C0A;
	Mon, 17 Nov 2025 08:02:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QXt6OgYv";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B2E10EA8B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 14:35:12 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-42b3b29153fso1212333f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 06:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763130911; x=1763735711; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dWXLhPsJovH76m+UWdSFM19WXCf+smwi4mOSlHBAWM0=;
 b=QXt6OgYvB0GrccRY4O/EVcLjkMbn+DlDWyNkAUdiOnNwqvKk92sOwFWTezHXn58Q9S
 mw1siUfJL0+hkSKLuRo3si3NdEbU14tElEK/Y4WAxVUwSsHAt0dpNxiQLhr71+eh8Wgs
 7Epk38xAJNLQwkeGlqvJZs+ZfPC3TTfugHMmiSeJAzD9S5CPadte7p/kZ3E1QjHhjjd1
 X6RQiGLmC+HFNJnemHOkeOkpaIZ3Umoj91TEf1AQgq1uernXrN9JmTuWSEOVWSMGMSop
 fVU9elwaWX7QI5HDzGTVOFQuajEfhrZyZ9MGcuYRAJG1bi1bwrLc1Vt+5+r02/7urLQl
 V8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763130911; x=1763735711;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dWXLhPsJovH76m+UWdSFM19WXCf+smwi4mOSlHBAWM0=;
 b=uQbYzGK8+up2VRw++5a6aua2HixeyAiDxNHt5lIz2aD7oyUbiSFAXjx749UGo6apW8
 ogpy3a/lAsfxQj1CHgUYiLLL6TLP0ejYeL9HGW9Zf+YC91cyly2ZDIAFQLx5deJx2//U
 oJTytQOKAS4Q2wquuTmhOj+80+mJRtWoqoYE+ylFM/iIIRg2dtFmRazsLArUffypj7t6
 /LFtb5oXiviE6o2PXHkEdYX59iJYJfN6V1azxJnojprHQGEEuX0cEPeAPij58osAby/a
 hzySUoYP7MChQe16+gHb79nCBCvKSEiJJsuD8KBC+fRYjyG4kf/XjJrx7M1bUAq0ifnO
 RAsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUryDS4HChdeA4Y0V51fF+TzaY4pF3t0s5yr0w4f4lqHjkiceIsmdWVPi3m7M1Vv3iHTjh0bOc1@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6E2WQ0nYUPQZ6gicmNrPUR4JVlUp6qgUN0c7gyoaTseKV5+Vc
 9T4aG0tyts3uWq6akRYgKQQWvyHSNfQDtzAApqR5MzPkwTzPgK7KjCZeMnFvSFJmRtY=
X-Gm-Gg: ASbGnctNBxwAW7MQw7JJPj1HQehBLupOi0y3VYmpfYdddWIcz1EYo2VR3WP2UNJecf/
 903dMv59AQGFAeOJk0MDxiG5Z+7nIKHBQ03Th+3W2nfkTLC5oM/7Vz1mCFdr+3VyEmlfc0tF2Tu
 PQye8yW1GP3BOeIeFAUmG1mfTATCT243Uj2DHQdIQBk7aODbGP7oJa2vJ9i2g4agTM2F+4ojGck
 U+Byy7Ci29Q0vLpedhligmkJ1BJqzLW1re62Bj/RVAoc4mKNSbXDrpm4esOV3YzxIz3xKMqtGDP
 wr7rnltl1N0SJA7dxAF2SyV8oRXi9t+YdLOd5wUXQWL0kBTCQCSSPiUu3Iga+j9jJiHlXyZk03C
 0+ID/QKGP242/BjrQVqzhennZnBZ+L6d0GHhJcLxifNdoxTFCUY3k17hn/DfHbE3gLMqi8kqXjm
 iA
X-Google-Smtp-Source: AGHT+IHw5DY+d3JMXj0ehkwCi00kh1fcOQgwNxL358oZwa3xTlItactqY9kSp562T/u4HnhssT9g/A==
X-Received: by 2002:a05:6000:230b:b0:42b:40b5:e681 with SMTP id
 ffacd0b85a97d-42b593450f3mr3355692f8f.26.1763130910639; 
 Fri, 14 Nov 2025 06:35:10 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f0b8a0sm10330771f8f.25.2025.11.14.06.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 06:35:09 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CCE895F820;
 Fri, 14 Nov 2025 14:35:08 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Simon Richter <Simon.Richter@hogyros.de>,  Lucas De Marchi
 <lucas.demarchi@intel.com>,  Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org,  Bjorn Helgaas <bhelgaas@google.com>,
 David Airlie <airlied@gmail.com>,  dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org,  intel-xe@lists.freedesktop.org,  Jani
 Nikula <jani.nikula@linux.intel.com>,  Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>,  linux-pci@vger.kernel.org,  Rodrigo
 Vivi <rodrigo.vivi@intel.com>,  Simona Vetter <simona@ffwll.ch>,  Tvrtko
 Ursulin <tursulin@ursulin.net>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,  Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>,  =?utf-8?Q?Micha=C5=82?= Winiarski
 <michal.winiarski@intel.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] PCI: Change pci_dev variable from 'bridge' to
 'dev'
In-Reply-To: <20251113162628.5946-4-ilpo.jarvinen@linux.intel.com> ("Ilpo
 =?utf-8?Q?J=C3=A4rvinen=22's?= message of "Thu, 13 Nov 2025 18:26:20
 +0200")
References: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
 <20251113162628.5946-4-ilpo.jarvinen@linux.intel.com>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Fri, 14 Nov 2025 14:35:08 +0000
Message-ID: <87346gptr7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 17 Nov 2025 08:02:58 +0000
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

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:

> Upcoming fix to BAR resize will store also device BAR resource in the
> saved list. Change the pci_dev variable in the loop from 'bridge' to
> 'dev' as the former would be misleading with non-bridges in the list.
>
> This is in a separate change to reduce churn in the upcoming BAR resize
> fix.
>
> While it appears that the logic in the loop doing pci_setup_bridge() is
> altered as 'bridge' variable is no longer updated, a bridge should
> never appear more than once in the saved list so the if check can only
> match to the first entry. As such, the code with two distinct pci_dev
> variables better represents the intention of the check compared with the
> old code where bridge variable was reused for a different purpose.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
