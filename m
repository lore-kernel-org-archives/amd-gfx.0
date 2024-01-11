Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6BAC47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 15:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8CEE10E922;
	Thu, 11 Jan 2024 15:12:24 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8061E10E916
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 15:05:25 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50e759ece35so6109826e87.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 07:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704985524; x=1705590324; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ew/CK2HzAS+7ffi+ceNvq4v8Kyc4CxQdXiEhq4P/bZ0=;
 b=HvU40BQeQc2ZM+99SNi52+AptYHKIdeta6fg0ps2rMiu4iVswzWX7JcMGxEsCEi0Kj
 J9yy4VWXNN7Z06btS2B6B9R3Yy2RXMIrRCvHku70OcxnM0q4HyMhiWX8/UYB8UlkTL4O
 1zJtZ26kbf7WH0zmF8sd5ansHUOwImQ0kKmwubMz9V/gMTQnZLyeO9+8mamwzSY6JgWz
 X7UZXQjn3SHMdsEsjNFrWPPzGxX/QcO9QCFEHfH+AG3PC48ZrKFfQvYSeV2Zn7LAI0kD
 5WXlQ3HJIZGMTxL0TBF2szi6XIdnLKLAS9YkBrd0mffQ4dNG0bvfTRoewEoIeho3x451
 XmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704985524; x=1705590324;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ew/CK2HzAS+7ffi+ceNvq4v8Kyc4CxQdXiEhq4P/bZ0=;
 b=r63sdy+0Fdt1GGwAA0YAUtNVqX5tcloCgCpQe+vPvKgixdvQ7y0XrVcaEpbK65XgJA
 Qg5keSzvP9jqZMO4wrBKHaBPhzTMXIaF3mQp8QjzDd7SYFDbAUWyiDgm9XwUiDjskb+u
 eXs/ov5fnFjr4A1S21uK84tvLJ4j61pc+eh/b1kWW4m65sewQUMm+rCtbl3u/RQahR0o
 tWiHjnxNAhhjC/+48tIzh7lq035PnWCjNB5vWK7UILQhFolvL+gmeh4Q2jE+tYbR6d2E
 ZjLUIb86u7cTOFeaQ8q8X4Z3N4aLiWNldtxgyncvetPYfw7BKQGYJ82d7kzE8NTwDa/E
 S9aA==
X-Gm-Message-State: AOJu0YxqJSYVlQDTBRqHA1zXn4ULBefXd2rvGxLMUHr6/1jwU580zY4p
 Ulqc1oNisJsnRX0oURWWpj4Wt8Tubyg=
X-Google-Smtp-Source: AGHT+IGg3Boalbuxu+jjiLL1rvJa+NFSJU7k95J1NWoFrG0JLASxk7w5jT/2++h4NwtbQZl3H/k/OQ==
X-Received: by 2002:a05:6512:234f:b0:50e:b2bf:92f1 with SMTP id
 p15-20020a056512234f00b0050eb2bf92f1mr760486lfu.102.1704985523460; 
 Thu, 11 Jan 2024 07:05:23 -0800 (PST)
Received: from alex-computer.home (91-114-185-105.adsl.highway.telekom.at.
 [91.114.185.105]) by smtp.googlemail.com with ESMTPSA id
 d15-20020a170906c20f00b00a2ae7fb3fc6sm686116ejz.93.2024.01.11.07.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 07:05:23 -0800 (PST)
From: Alexander <electrodeyt@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/{amdgpu, radeon}: check PS, WS index
Date: Thu, 11 Jan 2024 16:04:47 +0100
Message-ID: <20240111150516.743276-1-electrodeyt@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jan 2024 15:12:24 +0000
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
Cc: Alexander Richards <electrodeyt@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These patches add index checking to parameter / work space reads and writes to
ATOMBIOS bytecode. Theoretically, it would be possible to perform stack-aligned
out-of-bounds read and writes, and since the bytecode is in the BIOS, any     
exploits which could be made with this would persist across reboots. 

This is my first patch to the Linux kernel; I did my best to follow the style 
guidelines, I hope I didn't make too many mistakes!
Tested on a R5 340X; sadly do not have any more modern GPUs to test this with.

Signed-off-by: Alexander Richards <electrodeyt@gmail.com>

