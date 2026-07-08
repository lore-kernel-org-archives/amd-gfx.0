Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15436C44503
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 13:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97CAB10F121;
	Wed,  8 Jul 2026 13:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BTYTXZmR";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA6F10E566
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 06:18:54 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2ca158f02ccso962015ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2026 23:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783491534; x=1784096334; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IeKjljjW0rbzKqDo5+JHTj1l65dd8fRajYjS5rdVpUg=;
 b=BTYTXZmRXEGLSW08x0qkRr3samnRGgPeroXCqZi9voM8dc9/npppgcuRhrpaneqGRR
 7vLcoc3aKfcapsWLsY/z/LVB3YJrxT+IvCOSke+ht17tlUxqSKJ5SCZVus0ZgHE0yyBY
 Ti4SHjX+SgUJwpZqusEpFq/RErbR2DxFzOIAXAYBpZqi5xl00nqIKM2oJYsNbCKibKwE
 Jn7nLt3ynYiiCcFZXtl5E6IpH7+/poEQVIyKPbc7Lr4DHPpGf8R9C/FBkye0O2etAdAt
 RI80u58FakzoMwL+MwyR4KpuLc0ID8fNomd95PhyTzPP4gx47yRf5I+9982aaF1QZalw
 H/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783491534; x=1784096334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IeKjljjW0rbzKqDo5+JHTj1l65dd8fRajYjS5rdVpUg=;
 b=pcJpjlhtWd2Sqq4vPkdwhqyMq2KYj3JeifEW1ZrDXu1bY3Oz18pzuHqg0BasjcqTJv
 TSdtv/0nL2ru3ByU+33TIwB0Hba6UElTqUWMhoD9mDs2LThrbZ5oc/gfSMFfHcqLZ9uN
 VJqZCg+T++vklyolmOPZ/0CsGe++uMNQ2qwIwRk4SgdABAXEl6/74DhyNFUo1TT9ENhp
 QRRbbgKuHW1NPd3gplfIR8/uzvV0Q8JxBl49dhku1yqKLR9ZT26keDj8TR2yZd0y/hyQ
 kk1LOIzIH56KkzzJxa5G35sp8dhWXZL43im3jIzflgWUu5lzvgm8BFkxq4StkzYkyFAW
 hLOQ==
X-Gm-Message-State: AOJu0YxKBpY+aUd3HJAVAhWzLJO9knqHhIG4bUxv0oWOMhsu0mgmkQKb
 FrtbtXawxhkXT31XDDl4pd2xpm/uTn1esPNMAWfqZZa5IJ2kjGUWpOA7
X-Gm-Gg: AfdE7ckQbGNg2AXKfkxMiH4cz/qljibksfaeO+XC4EaHNWaInoQe2ZZUfOPvsf1laJ0
 hb4T7Zy9ygc6BADBRHxZHwlUP6Go+/s/rMizrZLFyo7xyJBNG9rY6NeS/J2sVdro0tfpQ+idUMG
 vtntE0FLMGqkVc2FUneF7Hbv5/A0U06P7aMnTp03X242uuBZ+Ox0FKWSrd3vtH4+Xl3RoKIAMC+
 qZfy6H06E+7DbWFwqFXeeiAJmhMKztjPQV9szsn6QZOa9ZXowHQk2MY6shbT8ESQQWCwRY/Ym3R
 0ADnbnbgpw8YE6uZDtr+oYyumxN2GeVhE+MymVB6eVHvLVnZSp57haiugN9eY6Vfn+rzJZmIBPg
 RDD8OndT7Tf/qd7wmKR3q7IV9MJE2B3+DcNpLIvNWDycnLXCIRZB2DHCdSoyi28Me7igBwXF9Ui
 HqFXNkn7jxMQtgsXidhA==
X-Received: by 2002:a17:90b:57cd:b0:381:77cd:38ca with SMTP id
 98e67ed59e1d1-389417e432fmr977538a91.4.1783491534182; 
 Tue, 07 Jul 2026 23:18:54 -0700 (PDT)
Received: from kali ([122.162.146.188]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117d847e17sm12888463eec.18.2026.07.07.23.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 23:18:53 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v2] drm/amdgpu/discovery: validate table offset before IP
 discovery header cast
Date: Wed,  8 Jul 2026 02:18:34 -0400
Message-ID: <20260708061835.111986-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624184444.D4A401F000E9@smtp.kernel.org>
References: <20260624184444.D4A401F000E9@smtp.kernel.org>
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

Sashiko AI review of the previous fix flagged three remaining gaps in
the discovery blob parser, all stemming from the same root cause: the
ip_discovery_header pointer itself is constructed from a firmware-
controlled offset with no validation before the cast.

  ihdr = (struct ip_discovery_header *)(discovery_bin +
                    le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));

This offset is a firmware-controlled u16 read directly from the
discovery blob's table_list, with no bounds check against
adev->discovery.size before being used to construct ihdr. Every
subsequent read from ihdr, including num_dies and die_info[], is
downstream of this unchecked pointer.

The other two items in that review (unbounded ip_offset advancement
via num_base_address, and num_dies exceeding die_info[]'s capacity)
were already addressed in the previous fix.

Fix by validating the table offset in amdgpu_discovery_get_table_info(),
which is the common path used by all callers except
amdgpu_discovery_read_harvest_bit_per_ip() (which reads
table_list[IP_DISCOVERY].offset directly rather than going through
get_table_info()). Add the equivalent check at that direct access site
as well, so all paths that construct an ip_discovery_header pointer
from a table offset are covered.

The check validates the offset itself against adev->discovery.size,
independent of any specific downstream struct size, since
get_table_info() is shared across ten different table types
(IP_DISCOVERY, HARVEST_INFO, GC, MALL_INFO, VCN_INFO, NPS_INFO, and
others) each with differently-sized table structures.

Fixes: d0c647a6aae2 ("drm/amdgpu/discovery: support new discovery binary header")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b4ee5fc8e..9b55c56cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -564,6 +564,12 @@ static int amdgpu_discovery_get_table_info(struct amdgpu_device *adev,
 		return -EINVAL;
 	}
 
+	if (le16_to_cpu((*info)->offset) >= adev->discovery.size) {
+		dev_err(adev->dev, "invalid table offset %u for table_id %u\n",
+			le16_to_cpu((*info)->offset), table_id);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -766,6 +772,14 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 	int i, j;
 
 	bhdr = (struct binary_header *)discovery_bin;
+
+	if (le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset) >=
+	    adev->discovery.size) {
+		dev_err(adev->dev, "invalid IP_DISCOVERY table offset %u\n",
+			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
+		return;
+	}
+
 	ihdr = (struct ip_discovery_header
 			*)(discovery_bin +
 			   le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
-- 
2.53.0

