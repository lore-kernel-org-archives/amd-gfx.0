Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BD8CE7B12
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 14:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 406C410EA7A;
	Fri, 14 Nov 2025 14:08:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="YuIaXwa+";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1970A10EA64
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 12:59:45 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b472842981fso243729266b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 04:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1763125183; x=1763729983; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lIa30kEZfIOzXn6c2Ch+jzSexECrPYWXzGffwwy3r9Q=;
 b=YuIaXwa+fLkz6OKdz7Qb5f4ZJrrZVmThIMGrjbAVL2gojv2kWXnpe302ZpgiYav1QG
 ydN1cM8U8WCE3+C1vKz8FZ20TOLZQt3az/oxUqgIGYVLxuFdI3CJ5ZVmkez/fxLMGpNY
 7eD/+vAUMA/I9KzCyYbbGEmcb0BgYnqmCFeh3XGaM3fMeGk8sVLYzmuni/W9aaLUQwJY
 xa9grzZMqyj9BfF3sbzZtvjtNeQdTH3vPjTczovRJc1bdfoe+2dgqS9V2IFMoq5tFlvZ
 J6MiQsl5tzAUgWNAPtiYk6rLiWvLD9F1UOEQX2EaKwwVWzmRGRfL2zwljrAktehGOZBm
 Hxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763125183; x=1763729983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lIa30kEZfIOzXn6c2Ch+jzSexECrPYWXzGffwwy3r9Q=;
 b=ok0XLQ1lYvwl/41OCb8EMUAfYjGAbIwzm9TBq8pZ5US2L0FjLAOFQSaaLO60vJuZCy
 BOiF4vrOXpZtnEGuXe3XkCd08NAwcLRS6giVORH3kDJAaK90sRw4Y8QcElemywNOhnUD
 ykW1uOkYs7gMhdGMqXr6Y1+d2laCzj+M7kBrawEWdQpKzcWxBhs1rn3EU4AtjmSqOMPO
 +RBbQYawgDRAK9P+KIsnhqRgt9+RQkOzksVy9YE4ZKo2ev4CGqXId2bXmolVWsIG2X9x
 gzU8ijpAeI9RJbUOkZBn+2rJ6WSN/LqzAfbtmSDORlUrHxDDl2qdV1UZJJjxdDr3/O7g
 SaQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5XcTnNIfXoEM7BPmkNTnWf90bHeGgkMvmVgO1inHFXJXlXUu4sXYac2Hc0CHgr1j7f8jVf0UW@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwL0w/cKgYI9W8u1foPGcXtqof4QJpWDQSzxUtxkPE9HZFeKHYe
 t+BPNuZaBVL0Ee70oUCRmJ2aY6Ms+Oi+S7wC83lnUPtkLfpPT9Qx+MeT5D92RWc4kjA=
X-Gm-Gg: ASbGnct2Q0odOc+lgFFpPiOPabDLpCF4X3mFwPLUqOioVizzrlcW9GkMSgUgTFrZxSp
 7A9IYLUJyiSiiK5XwEU3S43UC5aYmWnrDsmLLO0Wd+k+p/SYhRvsY9PA0qMCMlCCpuuwRqG6IKC
 Q8RQOL7RJFDpesxIrP3rujfE51lItJ1a5yNG+WwIiaVcwiYbLpVX4kkEQhm0VX0LCWMKig5q0VY
 KU2gLAPw4zsS+/5GxqV5y4zHlHJMtXdoG5jXgx40XDXiQ0Pn9z84pFO7Uq8b4thALqAwUNZRLNc
 OP5ECIiKuMP77XU6bROogiJVQ41OOJSzc2iJ+wUcoWWbq3Yz1WkyJr+M/OOAqUtKSwQL03LrfAH
 E967UxmREcafzzANiDU/KuCqAEGz8ryTOEPm6GgUzwn6nCw2sUL7XlR8ZtYdTmn5pCaM4Ae17p/
 j+L5Q=
X-Google-Smtp-Source: AGHT+IH6H5eoyoDiGCawX8hcyfAIsFqjcgfKx5GqQ3M5ZUeRqB23EXgoQaPPEhXoJ1r2rQPfP0tLQA==
X-Received: by 2002:a17:906:f105:b0:b73:7652:ef9e with SMTP id
 a640c23a62f3a-b737652f76bmr38125366b.55.1763125183501; 
 Fri, 14 Nov 2025 04:59:43 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fd80a3asm382714666b.37.2025.11.14.04.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 04:59:42 -0800 (PST)
Date: Fri, 14 Nov 2025 13:59:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Corey Minyard <corey@minyard.net>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Calvin Owens <calvin@wbinvd.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Sagi Maimon <maimon.sagi@gmail.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Karan Tilak Kumar <kartilak@cisco.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 Max Kellermann <max.kellermann@ionos.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
 ceph-devel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Rodolfo Giometti <giometti@enneenne.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Satish Kharat <satishkh@cisco.com>,
 Sesidhar Baddela <sebaddel@cisco.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 01/21] lib/vsprintf: Add specifier for printing struct
 timespec64
Message-ID: <aRcnug35DOZ3IGNi@pathway.suse.cz>
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
 <20251113150217.3030010-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113150217.3030010-2-andriy.shevchenko@linux.intel.com>
X-Mailman-Approved-At: Fri, 14 Nov 2025 14:08:08 +0000
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

On Thu 2025-11-13 15:32:15, Andy Shevchenko wrote:
> A handful drivers want to print a content of the struct timespec64
> in a format of %lld:%09ld. In order to make their lives easier, add
> the respecting specifier directly to the printf() implementation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks goor to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

I wonder how to move forward. I could take the whole patchset via
printk tree. There is no conflict with linux-next at the moment.

It seems that only 3 patches haven't got any ack yet. I am going
to wait for more feedback and push it later the following week
(Wednesday or so) unless anyone complains.

Best Regards,
Petr
