Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D8AC43602
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 13:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D51A10E5E7;
	Wed,  8 Jul 2026 13:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="HaEE3nPf";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6BF510E522
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 23:42:56 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c9d1fc053e0so25621a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2026 16:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1783467776; x=1784072576; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NTsYOw6uHozsquujsNCqPDcOi1VuziUuLK4jzy115/c=;
 b=HaEE3nPfzYK8A6we1C/cLxDaf9Zr0uwk6MuGIRVZUfKUPwwld3UUyPHnA5GzTOD9qp
 iFNU8+tAtNxgILnApH8EiHyVZj15V89UshCtZFa8MHk7bl4w2+/mx+Jf2g4wY9QK18C7
 r4FckETGKGPhMw6pg1ktQMvJV6C/tNFwqCSL+JHCa77fLmuLd9A2stRJg1dijnFuWRyu
 FEC49nSq8xsck3XiANMLRbyB7pfE3MIq+d3ZfABqsyLlWHf4VU2pBGFGpeED4KJBAuve
 aj6idYJ6/qIxoC3nKywnZ8uf3ECgwGGfo9z6OPu1FGG8tqm3gsvsthXMcYTgdU7W1AIX
 7gXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783467776; x=1784072576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NTsYOw6uHozsquujsNCqPDcOi1VuziUuLK4jzy115/c=;
 b=kSBRON/pWkvxqC9rjRkPxdinnvLT6854TH+yWj7O0ChoGw1AoC+9wpgQxMgFCPelWf
 gq73/WCFIOZlAgkLpQnWyXQhsEEEKmUgjPlgef5tWbg1PzRvgLDwVj4c1YZsv5W4Ve3G
 EtcL17ibUx0qH/+VZz20X7niG2yoqvdDZte9bX5Zc3Qy+OkB9g1jZjQSv1puO1vdOD3B
 8St/A4ytsSO+1UMbrmDsfwWsFe0ZpwvXCvSBtd7RDuJBLrSmS944IL2jH+iSIBSZXQmP
 aZEP8UHMYSFIkmFrzfk2ol5cK3iggDVb/jz+ivkTAh4oq1JNt/IN1rh4qd2xTCwR52c0
 Ujlg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqAOilXZMhw3O3thmoFGiubZJqKAKNzC3RbpITNKEj0vJ3HTbRMdSepttajnkBlZAQKw/oy/kuI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDvwrVdd+nPm1Fw+M9HqyA5nAQz/k7JvynsCZSQuk8yUvF1ASc
 AqyZ9jkzbBBhYXpbbx3Kmu2GIjcO6J3zhiBNaJNb7iXGp1P+auN4EP+H1g0VBsbC1lo=
X-Gm-Gg: AfdE7cll1/DMBUN6oUO7I8H797P0xJrGV/l25BSyzx+GXGr0lGv+1AVx7nys9t3RLcu
 wa0CCcTVqSlg1LVaQiXVvWXHIlguUCJEDIAIUO6bb/ItAkxA3x7a6mF+7edQSm3cBjfN4clYt1j
 HbWGYJ53zpbsh+68ezoMjXMT54RPs8wnTEIsIpHCduWBKsTHfw6avEU3dZUN3p34k3DsTAL2Lu4
 Xz0dxC9y0dPU6YFb3fwWj21x5yFWARwF2mYf/yHaqvb4AzBjm8ELqcZ4tTOcjK/2KlYEMFf9mGI
 OVvpbViYLZutC5RTdyG5H4VZBB2FuyHtbkBckzFPPqglp2IGT/mqYLwvYt6FuoGzUcKTjQZ5th8
 tbU38jUc6R/8MpDSUciL9HtzPtF0rfxRxofEObw8PyIL4z/11MQG70jSdS2KeaqpU7OQERj2r8o
 k=
X-Received: by 2002:a05:6a21:684:b0:3b5:6b5a:4f29 with SMTP id
 adf61e73a8af0-3c08ee38980mr7590280637.30.1783467775848; 
 Tue, 07 Jul 2026 16:42:55 -0700 (PDT)
Received: from arch-ideapad ([2804:7f0:3df:3dbf:fd10:7260:dc20:84b7])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ae6cd9sm13637822eec.31.2026.07.07.16.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 16:42:55 -0700 (PDT)
From: Ryan Oliveira <ryan.oliveiraf@usp.br>
X-Google-Original-From: Ryan Oliveira
To: ryan.oliveiraf@usp.br
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, kaikycintra@usp.br, simona@ffwll.ch
Subject: Re: [PATCH RESEND] drm/amdgpu: Unify vm_fault_interrupt_state logic
 for gmc v10 and v12_0
Date: Tue,  7 Jul 2026 20:42:21 -0300
Message-ID: <20260707234221.34738-1-ryan.oliveiraf@usp.br>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260616184209.18014-1-ryan.oliveiraf@usp.br>
References: <20260616184209.18014-1-ryan.oliveiraf@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Jul 2026 13:12:03 +0000
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

Hi everyone,

Just a quick ping on this patch. Let me know if you need any changes or if there is anything I can do to help here.

Best regards,
Ryan O.
