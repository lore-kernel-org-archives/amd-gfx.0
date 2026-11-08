Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D557606A31C
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Nov 2026 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LEjNCV10
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE9510E7DF;
	Sun,  8 Nov 2026 15:02:48 +0000 (UTC)
Received: from mail-qk2-f1.google.com (mail-qk2-f1.google.com [74.125.230.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F61710EB9E
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Nov 2026 05:24:53 +0000 (UTC)
Received: by mail-qk2-f1.google.com with SMTP id
 d75a77b69052e-534b7b19206so2850661cf.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 07 Nov 2026 21:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794115492; x=1794720292; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lk+rm88B0oTn3JFpBCPa55zvIWRJD/9kM2yE66jnksQ=;
 b=LEjNCV10UK6/GCLJc/4BqEDm0d+JOgCUQDZLCpXidzeyWrAYB2Epb8YXaay6/qQLRM
 HWeSJC6DrnEWAeSqxYB30Ls2iGyaKr6BTvpzSmss+EQEVri0I5v7pPa1uDx8QK1fPR+i
 gYcI74qeT9AQ3jgY7LnQberOAtHrYWhs4LqE+aghLj+svBoflBw9RK1tCg1s41lzvWKt
 bzCL6Nilu8hb9B2lCIQ6CnT8kmtTV5DdNCMXqlAOPpmLIlDuocxdtTc5XGb5E2pw2GZJ
 PzAStS5PNcGXKsmNUQkXEkKT76SfXwUScvl2tgiGHlP17DHaeOktAr9AnbaGxMeLnWYd
 QNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794115492; x=1794720292;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lk+rm88B0oTn3JFpBCPa55zvIWRJD/9kM2yE66jnksQ=;
 b=hT+QqZxk8pE/8HmN+BWWMzOa/gvknPjOBIdhgysP4q/CBMBaqR6hFIuQJit5Fi+asZ
 odDmKYP+p6f9e6hfRx89QqFxCfAkURLHq4LPomTCJE9FV7e92KQVH4gMx8Xh+cIUUOeT
 gHW4CbANwohLe6E7aemGfWYh7xMBj9ku9Dpr0DuM18WXGzUBraTO2VsenEhfEpsJhhWb
 lRgGPQ6tlM9gh1MrppbL/2qb2AlF5rRYAxHUPd4vzURMMrbKRkqGjY9JRHIY01N0a4u5
 s0B+zHlb9bkdQsP1lNeSec6ArPpe+cUPjFoDo9anFsVZzztdeZ4XZ8AxpjU09VmDZQkw
 sULA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3C44jpJeFPOaXS8vhen/Gtd1VNi43cg4YZF7aMCqdLBfTysEU/OgTEzZMzNqqQMGLC2XNGp71@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+WXeU92fNJGrk1Q6tnHv/HcR9OJffTrNsgcO9I5UC6ZWziExE7
 D9aTu9tlJtX8oi2LRJcw+skCVakK3zaRfDvPnZ+HKE5B1vALq/QbjOPz
X-Gm-Gg: AYBFou1tJPHV1ZV014L6LuZT18ogHgw0Rq24uZFXHhzl59aQq9NnBXIbo4vSHSh6bXS
 sXP5Vw1VUyEFz/76ZZdSx5TDK7lv9wCMdn2JMm3J/9nvxzERFlnc+0acGPqfrzqCCOrzsRDkROu
 Mb+yl6vkKVNulagsM5tEHFF4m1yM5NzRPXPszJzEzzKuPRrwrQyMcxNg/PTCA96T0KTB2F8BaHr
 lM5qis6ajyrzlSMNwvdnC2WimO3EYsyLXa3PxhA3ov6cbonBWXfVGqYaQooGxXgxT6IbGVJR84e
 ycWyIj4efpUqcyRvvQQ9wivabEjaei9oIzwVSdNoQnG3/tiUgGn/Dx0EnxnDV5TnDDMCQmqPLlk
 7mgr9EXUEHaph7hI3e2x37kfT6NmsrdMc+VnLWQ7N0CnYK1jkSXENAdPG48atYyc7TFD6L/LXRA
 KMraCBuYawGehP9JU07UmyZ4P5LU0MuOu3eUvqAGqDZ6TP6CwJRDbn/LPf1nkJpGGNE0sw48swN
 N2rIrWNJBh2LIfLw4UJE73zQYvxNSkR3TlEcANGsEb5gITlbDQNDU8q9QJ7ObwlvQLpsoccfb1q
 Sw2PGzNeRHhrMBB57W6VzJH5IYhmVsr5X5xJc1K9QagOsj3AnFti+CU6bt2UrpfUxAfGKmy5kRR
 Eks0DPFJ3UdJRPUVj2yzFQuHy5g==
X-Received: by 2002:a05:622a:1c0e:b0:536:65fb:fff5 with SMTP id
 d75a77b69052e-552a59777b8mr7617241cf.60.1794115491901; 
 Sat, 07 Nov 2026 21:24:51 -0800 (PST)
Received: from [192.168.50.20] (42-98-155-143.static.netvigator.com.
 [42.98.155.143]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55264249f97sm10491941cf.14.2026.11.07.21.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 21:24:51 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Sun, 08 Nov 2026 16:13:34 +1100
Subject: [PATCH 2/2] drm/amdkfd: check HMM errors before testing range validity
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-kfd-svm-baseline-errors-20261107-v1-2-9ef4008019ab@gmail.com>
References: <20261108-kfd-svm-baseline-errors-20261107-v1-0-9ef4008019ab@gmail.com>
In-Reply-To: <20261108-kfd-svm-baseline-errors-20261107-v1-0-9ef4008019ab@gmail.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Philip Yang <Philip.Yang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, 
 honghuan@amd.com, honglei1.huang@amd.com, psirt@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Sun, 08 Nov 2026 15:02:42 +0000
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

If the first PFN-array allocation in amdgpu_hmm_range_get_pages() fails,
the allocated HMM range still has a NULL notifier. The validity condition
in svm_range_validate_and_map() calls amdgpu_hmm_range_valid() before
checking the error, dereferencing that NULL notifier.

Check the error first so failed requests retain their original error and
reach the existing cleanup without testing an uninitialized HMM range.

Fixes: c0de552910bb ("drm/amdkfd: clean up the code to free hmm_range")
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 8184cbbb829e..79455e23a030 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1901,7 +1901,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		 * Override return value to TRY AGAIN only if prior returns
 		 * were successful
 		 */
-		if (range && !amdgpu_hmm_range_valid(range) && !r) {
+		if (!r && range && !amdgpu_hmm_range_valid(range)) {
 			pr_debug("hmm update the range, need validate again\n");
 			r = -EAGAIN;
 		}

-- 
2.56.0

