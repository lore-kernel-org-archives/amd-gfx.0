Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6673CFA74F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 08:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4480310E7FD;
	Fri, 21 Nov 2025 08:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hd2602qv";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D7F510E7EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 08:48:17 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so19977215e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 00:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763714896; x=1764319696; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1kGnhBYedj07jgrtU61n1wwYc4o6bXtsan+BCdu9qgs=;
 b=hd2602qvSqZAOA/wJPDFsMPXgkCYUIpelK3jtqBEXeM/a3j/eKdy0dVmXBXJiolyUU
 WRznONpii9XaWBGFkjXIccyGp2UQTqZ0fMiTNDrNVpFQam7LhftnS1zcq4qT2GBLcxOs
 5CjqCjL+JDFC/IyjwiSL2EbO2o8g/iL5EdIEeS9GSoT9zcKfBqq4Zani0mMk6CaARWoH
 VeD1UVtuLlHq1je9RV0L/HHNWsABxMPSpzypIIZ29pJbirK8x4+5R9x5cF9P6mKxBhf0
 T6Fypv4ojdmE9E/8bDhqt1wl9np9vPJfhk0gTY//wv8AGDIKe6Hj3k3xGEdIEESUb5yq
 Cb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763714896; x=1764319696;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1kGnhBYedj07jgrtU61n1wwYc4o6bXtsan+BCdu9qgs=;
 b=t8XZGxA1DXW4nnIXmLialgcZVJHrV+snhSu1dh+olqjx/wrCoE8gBDAFm/w1l72DvK
 iu1qtAb8DIerKvXqbh8Uo0E4WNt4WhD0+FpAd2xpAzy5PaD00kAUSCqc/LAlnovVPsKU
 Yyt0pFRFQ1QmUadKA81hAYSuKUZG3Bs24bBBXyZR8Ij5/0rLIkTy4nsK0gchg3exDUe2
 TwpdO7lKGk0W0SRvwJOZ9tkRkW9RV0HuI9KTaFmUkm4m7XXBzZ97mA7w3kPqRQaweSQA
 4Vj1wkMgep4A6QDK8Y/k3iDqDXAdvyfSWIHg8DDSP0kzAg91plPpvFhdH/w0m3I/DZIr
 I+Qg==
X-Gm-Message-State: AOJu0YzIRzb7z2iUHQ9RqAXKeTweb2vyt7cp3hvgzY+knebLJyy61sZv
 09tGmiNDxSmokqYxlmJ4KQdYrdAW01lUgJmMHDxcpEXyzotBGfTwtPX209gphozxJ0E=
X-Gm-Gg: ASbGncvAWKvhNEOkJCsXTnvdgG6PzadhKtfwWyfe+orK7A/x1vy6PX2Lb8DNyD1DSXa
 Cm9cTHtjJUCi1kYbE5h2OoJmcWCtfpc03LYnKHJkifWxpicBXvwRmEQEBO1b6siQ2PaOQNnN4jc
 ElTxnKS6HrBkmuarFcR4srNrKBop8fZcD5vWXiEcbXX/5Ci/T7j9pG12NeJubnbz11bYfRJbtV/
 XCkHn2zoB4EazXPeHIsE6IUtAoK6H1FkQSLkxLQDX51InbK6ydiBN5e9dadsRXat6MKJni7WnIk
 l8aeTpBl3j4PjldvkpYmvD1rIWng+TglFGs/Q1orC794CmwS8lve8TTLXUZSwQGRy3U4fmEIptF
 ARSzHgDGxZog/tcqAFsGxoK9+14PEWJjkj25tCaMk/+bj+45r6SVmW6E6as5KoilAHMO1wskVQz
 ha15miiPDStV18khAB
X-Google-Smtp-Source: AGHT+IFmf1W033HdRfK+fsvcqI0zTImDxFP5wSkIMEfA6iLkGATqPhabdlA1f1tw1YX5tV+qxaEaFw==
X-Received: by 2002:a05:600c:314d:b0:477:7975:30ea with SMTP id
 5b1f17b1804b1-477c01f2cc7mr13694045e9.29.1763714896047; 
 Fri, 21 Nov 2025 00:48:16 -0800 (PST)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-477bf36d1fasm30638435e9.7.2025.11.21.00.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 00:48:15 -0800 (PST)
Date: Fri, 21 Nov 2025 10:58:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xiang Liu <xiang.liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/ras: Add CPER ring read for uniras
Message-ID: <aSAbtCGcXRqNRFq0@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 21 Nov 2025 08:57:04 +0000
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

Hello Xiang Liu,

Commit 527e3d40339b ("drm/amd/ras: Add CPER ring read for uniras")
from Oct 22, 2025 (linux-next), leads to the following Smatch static
checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:523 amdgpu_ras_cper_debugfs_read()
	warn: userbuf overflow? is 'ring_header_size' <= 'size'

drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
    499 static ssize_t amdgpu_ras_cper_debugfs_read(struct file *f, char __user *buf,
    500                                             size_t size, loff_t *offset)
    501 {
    502         const uint8_t ring_header_size = 12;
    503         struct amdgpu_ring *ring = file_inode(f)->i_private;
    504         struct ras_cmd_cper_snapshot_req *snapshot_req __free(kfree) =
    505                 kzalloc(sizeof(struct ras_cmd_cper_snapshot_req), GFP_KERNEL);
    506         struct ras_cmd_cper_snapshot_rsp *snapshot_rsp __free(kfree) =
    507                 kzalloc(sizeof(struct ras_cmd_cper_snapshot_rsp), GFP_KERNEL);
    508         struct ras_cmd_cper_record_req *record_req __free(kfree) =
    509                 kzalloc(sizeof(struct ras_cmd_cper_record_req), GFP_KERNEL);
    510         struct ras_cmd_cper_record_rsp *record_rsp __free(kfree) =
    511                 kzalloc(sizeof(struct ras_cmd_cper_record_rsp), GFP_KERNEL);
    512         uint8_t *ring_header __free(kfree) =
    513                 kzalloc(ring_header_size, GFP_KERNEL);
    514         uint32_t total_cper_num;
    515         uint64_t start_cper_id;
    516         int r;
    517 
    518         if (!snapshot_req || !snapshot_rsp || !record_req || !record_rsp ||
    519             !ring_header)
    520                 return -ENOMEM;
    521 
    522         if (!(*offset)) {
--> 523                 if (copy_to_user(buf, ring_header, ring_header_size))

Technically this should be min(size, ring_header_size) but I haven't
reviewed what other changes might be required here.

    524                         return -EFAULT;
    525                 buf += ring_header_size;
    526         }
    527 
    528         r = amdgpu_ras_mgr_handle_ras_cmd(ring->adev,
    529                                           RAS_CMD__GET_CPER_SNAPSHOT,
    530                                           snapshot_req, sizeof(struct ras_cmd_cper_snapshot_req),
    531                                           snapshot_rsp, sizeof(struct ras_cmd_cper_snapshot_rsp));
    532         if (r || !snapshot_rsp->total_cper_num)
    533                 return r;
    534 
    535         start_cper_id = snapshot_rsp->start_cper_id;
    536         total_cper_num = snapshot_rsp->total_cper_num;
    537 
    538         record_req->buf_ptr = (uint64_t)(uintptr_t)buf;
    539         record_req->buf_size = size;
    540         record_req->cper_start_id = start_cper_id + *offset;
    541         record_req->cper_num = total_cper_num;
    542         r = amdgpu_ras_mgr_handle_ras_cmd(ring->adev, RAS_CMD__GET_CPER_RECORD,
    543                                           record_req, sizeof(struct ras_cmd_cper_record_req),
    544                                           record_rsp, sizeof(struct ras_cmd_cper_record_rsp));
    545         if (r)
    546                 return r;
    547 
    548         r = *offset ? record_rsp->real_data_size : record_rsp->real_data_size + ring_header_size;
    549         (*offset) += record_rsp->real_cper_num;
    550 
    551         return r;
    552 }

regards,
dan carpenter
