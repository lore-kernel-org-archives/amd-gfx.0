Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F781606A32E
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fireburn-co-uk.20260707.gappssmtp.com header.i=@fireburn-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=mSLHjUL2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF52892AE;
	Thu, 29 Oct 2026 15:14:37 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C8D9892AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 15:14:31 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so522980f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20260707.gappssmtp.com; s=20260707; t=1793286870; x=1793891670;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hfS5OIzHxiX0eHuVw19YiRz/YZ1IYKJf2EBJhe4l3W0=;
 b=mSLHjUL2Cw73rfedlrml4mKRoFb1FGG/jlM8YERNY/kT+al2yz7gYZ4X+vK4wuDoxo
 CrDSGOz66GYw3xMu80rjHHh8yF29R6yrL89OVLS/cQRgBqTaajL5LkMMrjuadXvvXoTf
 EXelm+Mpe4XMDhxXuHL8pimbsfSNDVv893mVVF2J+7afdFVwE1usigjstYPlDB/6CGX/
 dUvtLuLNctP4CPRKqM8Ti7YQ7y0A+4QDpRgZs+4RWfYc2gcD4yW37g26pURA7bdQPdGK
 GZ5rCIeYR49O6RdB6zKFbntCRIGyGo8RfU2aDmH7az7kfxt/6NNRL+PKiNWrmsBkwwdI
 4KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793286870; x=1793891670;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hfS5OIzHxiX0eHuVw19YiRz/YZ1IYKJf2EBJhe4l3W0=;
 b=XpAri8UfdLQ1yiMQHwIQA5hexT8D1zMEJYD3bAQMSC2bvamOS/x1QEULfTiy0ZWAM/
 x9wPZHcv7+qVf/l/y3ziwXVOwmEdz6cClVoMKffgq+Nh3ALtt+gUep971/ocGUrEGxTe
 hafIpgmEGroRjgkGai//oU5i1fQpHXoIRNCtvPynACl80oSd3hHuu4JiolrMgliUiQj9
 1TbRSin/D2aThfXcEzqhtHsHpCTlXgvcJgMydFh3GevCSw0iQloe2h1ZsxBlpWeBvc+3
 fWQDZMBHbtanHJf+TYTJgoNYXwRa0W+RZbpQt9tqDE8gpI9TVdA6lu/aWI8Due5xQnxX
 1evg==
X-Gm-Message-State: AFq9FYK1uZ8cS6oozO96gP3b/sUk3ne9i9l1eRyZZGxBHhbhNndTpF/b
 eNFeq/YCBuGnr/njZVusfA8/mrMs9zml5TfltUGjAvwot9HW3z6CNJ/CAc+MSUz98iFVZtIIQ2f
 gtKJcyZSR
X-Gm-Gg: AYBFou0pcU1UyGdCoTFZ3aSs3gopwHECNOQPCmRCCAT2RgiGblS8ZUIUzVxuBzPGcO3
 Fb90Kv5fwbIxSM6DxivJT1kDoLByQTd21oJsK+5qjYc2S9EMvBr3FbJEgcubC0b1IWHCSgjXTz2
 GDjcRzOHW6l3QvF8yOkiRGLS4yZ5qDi2JEwPrAG95g0+fgdOdD5ELcqw5xqFjQpdnMqiG+tVDrn
 /UxU4bdmOcXoSQcin6GdF8mX9215wjUg2UCI7VC8GrelT7gaUzG4sW8+fJ16EYHLpogAYnK4NKn
 kqK4EYtST1nz8drh3xH8kSNE0wztlW0Rz3WOKO70K0b9WtmyK7aNIiOWDXRZ7si6v+tckolK23g
 VELD028vxf8yLn6HCp21cf7+z8MfKghYgE37CHMHlJh3EtOVvZZlsld+fLg6W3mv+FmP3xmL/3h
 XZ2RoZUSbHNiAagvgiZjB/9AgkNtrVe2706wRYbM0mueG6wl/gddIhptN9LoEzeZ+wX4fKbgoKO
 GqvswSAw7cESg/v6eycQ3jgpLSrzb02jYjxbHD6SDYuFR4QoWSWy5lraWW4tAvLm1rCqkQHIKom
 kBhT7hEEQqcYID9an9Wx8hTqpNzQmaMw84qKs0ly1Pvor/93FWWAlVnShJcCz78L1/GCO57HKN+
 DOmQSmYL0wZjt60vc8fEmug==
X-Received: by 2002:a05:6000:2805:b0:487:13a9:80d with SMTP id
 ffacd0b85a97d-48e649658c1mr5331076f8f.10.1793286869865; 
 Thu, 29 Oct 2026 08:14:29 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb851sm30191373f8f.26.2026.10.29.08.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:14:29 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: superm1@kernel.org, dri-devel@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/amdgpu: wake a powered-off dGPU on a dock hotplug
 notify
Date: Thu, 29 Oct 2026 15:14:20 +0000
Message-ID: <20261029151422.56791-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On an ASUS ROG Strix G513QY the USB-C DP alt mode lanes are driven by the Navi 22, and the firmware signals a dock being attached with Notify(<dGPU node>, 0x81) from a level triggered GPE. Nothing in the kernel listens on the dGPU's own ACPI node, so with the dGPU in D3cold the notify is lost, no hotplug reaches userspace and the external displays stay dark

1/2 adds a notify handler on the dGPU's ACPI companion for BOCO devices that requests a runtime resume. Runtime resume already re-detects every link and sends the hotplug event

2/2 handles a board where the firmware method cannot deliver the notify at all. The G513QY's CPM table notifies \_SB.PCI0.GPP0.VGA, which does not exist because the dGPU sits behind an on-package PCIe switch, so _L05 aborts with AE_NOT_FOUND. On a DMI match, and only if that path does not resolve, amdgpu takes over the GPE and does what the notify would have done

Tested on a G513QY with a USB-C dock: with both patches and no table override the displays come up after the dGPU has been left in D3cold, and the _L05 errors are gone. 2/2 is only a DMI entry and a handler, so other boards sharing the CPM table can be added to the list

The patches were written with Claude Code assistance, as the Assisted-by tags say

Mike Lothian (2):
  drm/amdgpu: runtime resume dGPU on ACPI notify from its own node
  drm/amdgpu: handle broken dGPU hotplug GPE on ASUS ROG Strix G513QY

 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 132 +++++++++++++++++++++++
 2 files changed, 136 insertions(+)

-- 
2.56.0

