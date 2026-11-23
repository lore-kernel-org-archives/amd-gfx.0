Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D333B606A31E
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EsOJgKbc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7619110E7BC;
	Mon, 23 Nov 2026 13:54:46 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A9F010EDA9
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 12:22:33 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-33fb4680717so8872177eec.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 04:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795436552; x=1796041352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VkpezA87wsH4BygJMCDh1GwoGufvYHw4wQvZr1AYzhM=;
 b=EsOJgKbcON8NyebCjTIUAOXNSVxJjPv2R68PiDhLrnM8u5ZX/XXnkZPvZC2Epr4EnK
 /xLUg0Gc3FcVFy3vIqAwfE6XlEMAqZa2q76++214E7z0ss9DyKJC1llMxCWkpj2Z09NY
 y8oZpLzIHS7FB58AIW/4c6HcP9G9x9IFdNbm3fcqTJhbzPjUo7cNXH49Xqdkrsh7iB/W
 nF5VKsaFnfIh0T0DlYB6mklmNh3QdG8/sTEO2FjVvbbgdyGoL1CjYe/N9VuNaMW0qVgL
 AUmJ6/f1pgpKj9lNE+g4WrcNxylpFx5gV/F8L+LODVSzhFPTtX8v2fPdF+RVyM47Sp/l
 zV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795436552; x=1796041352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VkpezA87wsH4BygJMCDh1GwoGufvYHw4wQvZr1AYzhM=;
 b=L9jrnN77QiKSrYccSTDvK0wzUE6Nkt4YC92RlBkCyNefK7v+v4rj5vIWq/fWs664kH
 0gh/I1/6gfUG+QPzM1AIo3WWerjNl7IKRuMdeoKnTgN4akOImhz9BCSS5yUrvKDrCYkX
 UubDZd2/Mcjn4XqX6LS5pNH755lVR/BvA+ffCcR42L6JvCCmKW54eN3aZUXAcXqK/WgE
 0CvjFWIR3Ej61kjemlbqbNEW5T/X+D23rK9HceaHG3NaIjQ+cZL61SllJCK11Q16NENh
 3ql/qSpVW/PMNIq0Vdpeou6529gS+OQDHfuKU1VuOC1h+uFLLvAWi14psNQxwk2i4exf
 mGKA==
X-Gm-Message-State: APuU4Z83UMlQSogU3rUywwTLXmDdGaMmOa2pbb5Gz5aXcuNdFZIClWU6
 70I5WHlImIIpPS8TADDyYV9Ipu5tcWQVrKucCNQrZDb+1gBfWqdMGrM2p1Fo7xjg
X-Gm-Gg: AZFdTZfv2cGDH0UXBJKpWwdq5/cRo4SiPU09kQoAdKNSUiOKSW0BA2x5/DOnjpm5tv/
 5+rw4Ypy0wkaPc3Yi1hTuiClGpqoaudldpg0ZfG/BtKKP5xv9V0hLPvZQedTPp3XwpEhVkI8HSr
 WtccfHaV8hT4g/wtViwG0HQ0b0wcioFiC35b+vNzD0vxz7DptlB1AS/HSjtuHRBd7UA7kgIP1Na
 T3+mGExqz1RVkFBR+vDsECxG/IRcR/T6WwxYzCUatBlWFkodfTiBTgeqIMxsvXX3zE4JLYyiGFo
 LIJsRfA4GN7AouxQsETgYp+22zRj9DTQAjaSTpbi20Y8MnhQ94OkQ7p2sNiRH4Uv1IzJvXsRAAG
 Vld2AGcLQkbYFJL/s6mb8Nf3viy4MEjUQwidMrtChxrUhau5lGT6B+J0BnVsSQnUQPS+Wl2Ybib
 lQ/pR98vANbTzaD8nrx0ARfcufEPsyXxTgiuga8QqgHx4vzHUSqn9aZUAO2fR/ZmzxjslI9FZxS
 oxWpFJ9OOWAYQ7hP8S7slcUsq5KendsRdnY8hky1kVo8TDHzLY5+K76vcZhqSzdvBUFoBx7vNHU
 ZKrnzdoE7VupBopIFga2
X-Received: by 2002:a05:693c:8083:b0:377:678:2309 with SMTP id
 5a478bee46e88-3856ef47a98mr12431705eec.15.1795436552292; 
 Mon, 23 Nov 2026 04:22:32 -0800 (PST)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386992b404bsm25173398eec.1.2026.11.23.04.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 04:22:31 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Huth <thuth@redhat.com>, Weijie Yuan <wy@wyuan.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v2 1/2] drm/amd/display: Document the union in dc_probe_status
Date: Mon, 23 Nov 2026 12:22:25 +0000
Message-ID: <20261123122226.4101191-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123122226.4101191-1-takano32@gmail.com>
References: <20261123122226.4101191-1-takano32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Nov 2026 13:54:41 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The members of the union in dc_probe_status are described one by one as
@u.bandwidth_mbps and so on, but the union itself has no description, so
kernel-doc reports:

  dc.h:2225 struct member 'u' not described in
  'dc_probe_status'

Describe it, saying that the member holding the result depends on the
probe type.

Fixes: 52771a3254ea ("drm/amd/display: Wire probe commit path into dc_update_state")
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v2: the AI disclosure moved out of the commit message, as Weijie Yuan
suggested; no change to the diff.

Written with Hermes Agent, an LLM assistant; I reviewed it and ran kernel-doc
on the file before and after the change.

 drivers/gpu/drm/amd/display/dc/dc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d3c484f45333..debdd69bbe4e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2207,6 +2207,7 @@ struct dc_probe_latencies {
  * @valid: true if a measurement was latched.
  * @measuring: true if the hardware counter is currently running.
  * @type: type of the probe that produced this result.
+ * @u: probe result; the member holding it depends on @type.
  * @u.bandwidth_mbps:         peak BW in Mbps (DC_PROBE_PEAK_MEM_BW).
  * @u.latency:                min/max/avg memory latency in ns (DC_PROBE_MEM_LATENCY),
  *                            stored as struct dc_probe_latencies.
-- 
2.53.0

