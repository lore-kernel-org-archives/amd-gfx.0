Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3B2C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 21:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E0422D01
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 21:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E0422D01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE4BD89DCF;
	Mon, 11 Jan 2021 21:05:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D7589DA3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 21:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610399157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OkwN5vYCUrXN1gSw+5AUEXR+ndNOEnKeN2JIlRxKH3E=;
 b=LxXqF8UrqTs1x67LaCbg38QZOcSLHLxtPgNqHPioWQV8aIKKRGTsR6xfnK9Elv9aWCmRQ7
 VhRlBNBqEi3CWVLG5K3tAvhChZfWJ1HqoAQDilUPAKa3wxXYpHaBi5NAJV7CU/Kt3EG6bV
 JSny/Laq0Q9mrDZVYAVO9OSWkL5e9G0=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-qtQ1R_Q4Mway5U8JrzMolg-1; Mon, 11 Jan 2021 16:05:55 -0500
X-MC-Unique: qtQ1R_Q4Mway5U8JrzMolg-1
Received: by mail-io1-f71.google.com with SMTP id h206so92285iof.18
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 13:05:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OkwN5vYCUrXN1gSw+5AUEXR+ndNOEnKeN2JIlRxKH3E=;
 b=gmqruwJwvJyRRMZzW16l4fKbTtlx4J7Xujf/sLWsJwnQ5H8cQlmoeJKrAjrsEYKxHm
 0vASedLVHe0RyHKeDkH/eiC5ZUWp8VaWRxB5KqrW3hsD5BLnWjUb41QXIOen7UbHK/wX
 Itv6TeFQyJAIY82NYtOGmwqYKFRSQI61G+9m2il+hqatokDuOJcd6ElLcCLMmHZrsXpu
 Ks4zxwVVw350iWqv054SDasl8D8lTMdK+23MhOSTOINkXhav7/xez48TwM28zQxA4Jwl
 XSkJka0Dz6BXlV2laOcyuzrHmnpgGXz/iXwDihlQesagVTtBmyaUvrjrDNxPS+t5WSod
 Rsuw==
X-Gm-Message-State: AOAM532chDN2usOdY+tC1Oc8yy2o8DfmUQvDaCEmlSHQ9RptvhOqy5tW
 nd1EoGdS8JBd5YTqfYKCvkX8VGvYXa9wCv3HTOPs/FLkBziDSvUrsUifOjgmonqpUc2HNODGB9L
 FIipZRpJdLUnZeb8DwbP1EB+HZA==
X-Received: by 2002:a05:6e02:10c3:: with SMTP id
 s3mr973996ilj.269.1610399154546; 
 Mon, 11 Jan 2021 13:05:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6Ev4z4M7iiQ4IWIhPmz+JCzu3mpjfTGAREfYqUmeQmNUT4RarijTDgpFFHOnVLiRQw5uChA==
X-Received: by 2002:a05:6e02:10c3:: with SMTP id
 s3mr973984ilj.269.1610399154354; 
 Mon, 11 Jan 2021 13:05:54 -0800 (PST)
Received: from dev.jcline.org ([2605:a601:a63a:4d01:c440:5c61:43ba:350c])
 by smtp.gmail.com with ESMTPSA id k15sm711468ilp.10.2021.01.11.13.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 13:05:53 -0800 (PST)
From: Jeremy Cline <jcline@redhat.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdkfd: Fix out-of-bounds read in
 kdf_create_vcrat_image_cpu()
Date: Mon, 11 Jan 2021 16:05:28 -0500
Message-Id: <20210111210528.734483-1-jcline@redhat.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108163104.411442-1-jcline@redhat.com>
References: <20210108163104.411442-1-jcline@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jcline@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Jeremy Cline <jcline@redhat.com>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

KASAN reported a slab-out-of-bounds read of size 1 in
kdf_create_vcrat_image_cpu().

This occurs when, for example, when on an x86_64 with a single NUMA node
because kfd_fill_iolink_info_for_cpu() is a no-op, but afterwards the
sub_type_hdr->length, which is out-of-bounds, is read and multiplied by
entries. Fortunately, entries is 0 in this case so the overall
crat_table->length is still correct.

Check if there were any entries before de-referencing sub_type_hdr which
may be pointing to out-of-bounds memory.

Fixes: b7b6c38529c9 ("drm/amdkfd: Calculate CPU VCRAT size dynamically (v2)")
Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 8cac497c2c45..a5640a6138cf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1040,11 +1040,14 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 				(struct crat_subtype_iolink *)sub_type_hdr);
 		if (ret < 0)
 			return ret;
-		crat_table->length += (sub_type_hdr->length * entries);
-		crat_table->total_entries += entries;
 
-		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
-				sub_type_hdr->length * entries);
+		if (entries) {
+			crat_table->length += (sub_type_hdr->length * entries);
+			crat_table->total_entries += entries;
+
+			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
+					sub_type_hdr->length * entries);
+		}
 #else
 		pr_info("IO link not available for non x86 platforms\n");
 #endif
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
