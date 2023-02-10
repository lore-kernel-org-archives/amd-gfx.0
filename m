Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E16C636CD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 08:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DA2D10EC86;
	Fri, 10 Feb 2023 08:04:08 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C68C10EC5C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 04:50:09 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id s20so2769545pfe.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Feb 2023 20:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5mAzAHTdZsC5IqNul3xJsl6wPXmAHfKwZ27VCzKXGF4=;
 b=JVtiloj7yRa4BQFYW86RmJebSQYTmr6ulQWbaNdE813YnQNwxXxigdeqKGwJ547OA9
 iKneGqYybribFvactjWAxLOC1FFyHyE+vrJN9XEm4Abm2yHTeo6rcn+1OgEhy5wP98gZ
 +ThcUd3YSIgv/n1tSUkAQD0bQGEO9epBP65UtYfzB4TDt5HkYEHAUsO9ybZHG+TDzu0u
 hqJKP33cLtrVl0eYH6Qi6HmbIoL1D0nmoU8eLgaP0zLDynkeKmwUzTLzZaRDN3rU0PL/
 En5vvM6GmtpTk46YMQcS55SP+xFg1xh1ZcTgKWrbYfmIOMTZVYpC6OIy+kKwcbJ4fUCF
 NfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5mAzAHTdZsC5IqNul3xJsl6wPXmAHfKwZ27VCzKXGF4=;
 b=6tsr6IURWZLjG9ZIewJGj1MtbY7X8T9Kjqn12xC306DFwUhbvM7NuamHoz7DCTK26F
 Yz6IPVPyMNt9fy7DDILeqI5+2Gff05DP67jHnmLByGkJZLkwZWbmk6H9QIaPtAJ8nB/g
 CjO1Q5rUhcAw/cumbalttESTcWJ96vkcghPnSF+vSi+OJqj5xsLC93wm/LMn4tyxRTqY
 dq7Yb/59OoyGSskPXDjEr+MpgtjWGVAcI19BtXakPCJuTIFcgCYkcBCnJyTKW4IoFs0R
 T1XKd80jXyfButIueQIeHA2UKWup/ajLxMZsHqeTNdj8Ym2OA8qeAOD81EQpK/JC6XVh
 6s5g==
X-Gm-Message-State: AO0yUKWIzpPv0KJAnhn0+I/4mPzO4Ouorn1/sfim/JjusMMpCvFucGws
 sZLhYvD7RpTY5Gk63q5GUKg=
X-Google-Smtp-Source: AK7set8TKp+XoOdzFSSniCiSLofONjJNjijxRgei3TQG94xGgDFfQ+8mh0QAUiI4aSA+indqTsT/jA==
X-Received: by 2002:a62:1c13:0:b0:593:2289:f01c with SMTP id
 c19-20020a621c13000000b005932289f01cmr11514678pfc.25.1676004609052; 
 Thu, 09 Feb 2023 20:50:09 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a62ea0d000000b0057fec210d33sm2269218pfh.152.2023.02.09.20.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Feb 2023 20:50:08 -0800 (PST)
From: Orlando Chamberlain <orlandoch.dev@gmail.com>
To: platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RFC PATCH 1/9] apple-gmux: use cpu_to_be32 instead of manual reorder
Date: Fri, 10 Feb 2023 15:48:18 +1100
Message-Id: <20230210044826.9834-2-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210044826.9834-1-orlandoch.dev@gmail.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Feb 2023 08:04:04 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Rander Wang <rander.wang@intel.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Evan Quan <evan.quan@amd.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yong Zhi <yong.zhi@intel.com>, Aun-Ali Zaidi <admin@kodeit.net>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Bokun Zhang <Bokun.Zhang@amd.com>,
 Orlando Chamberlain <orlandoch.dev@gmail.com>,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Kerem Karabay <kekrby@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Jack Xiao <Jack.Xiao@amd.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 Takashi Iwai <tiwai@suse.com>, Aditya Garg <gargaditya08@live.com>,
 Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently it manually flips the byte order, but we can instead use
cpu_to_be32(val) for this.

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 9333f82cfa8a..e8cb084cb81f 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -94,13 +94,7 @@ static u32 gmux_pio_read32(struct apple_gmux_data *gmux_data, int port)
 static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int port,
 			     u32 val)
 {
-	int i;
-	u8 tmpval;
-
-	for (i = 0; i < 4; i++) {
-		tmpval = (val >> (i * 8)) & 0xff;
-		outb(tmpval, gmux_data->iostart + port + i);
-	}
+	outl(cpu_to_be32(val), gmux_data->iostart + port);
 }
 
 static int gmux_index_wait_ready(struct apple_gmux_data *gmux_data)
@@ -177,16 +171,8 @@ static u32 gmux_index_read32(struct apple_gmux_data *gmux_data, int port)
 static void gmux_index_write32(struct apple_gmux_data *gmux_data, int port,
 			       u32 val)
 {
-	int i;
-	u8 tmpval;
-
 	mutex_lock(&gmux_data->index_lock);
-
-	for (i = 0; i < 4; i++) {
-		tmpval = (val >> (i * 8)) & 0xff;
-		outb(tmpval, gmux_data->iostart + GMUX_PORT_VALUE + i);
-	}
-
+	outl(cpu_to_be32(val), gmux_data->iostart + GMUX_PORT_VALUE);
 	gmux_index_wait_ready(gmux_data);
 	outb(port & 0xff, gmux_data->iostart + GMUX_PORT_WRITE);
 	gmux_index_wait_complete(gmux_data);
-- 
2.39.1

