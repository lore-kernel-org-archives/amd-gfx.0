Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C1AC4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 17:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCB423B23
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 17:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCB423B23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7AD98913D;
	Tue,  8 Dec 2020 17:41:35 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D4708913D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 17:41:35 +0000 (UTC)
Received: by mail-ed1-x544.google.com with SMTP id b73so18406892edf.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Dec 2020 09:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=RpUzZF2Q8Wg4M6KhoZQGKKLKeyPK2Vo3YLy+vit6Tsg=;
 b=pHGYpXx/NOUFgDD9CGNHUwV/uAFdnMqMdKdt+aB5QO+sFNmWsoJvZirHce3ooRj+f2
 yKSTuXLxV74wI75s6N+LNQj5QN88Ok9jp4+NW2LStkbX650QH1SrMcH+5FGuj39D9zgB
 e3LmmBFFw7/Aa3Qe7VodULpgeP5dz1DTxuJ3pCG3mXJGSfD0xf/Q0v25rAj7imXBVgPr
 nmgpQbxWqEHssd90D88OxxVu7g9dhFhyHQYcWuqb1JYEFR2bCPveJt8KgaaU5A/VQgmS
 IBNJcdCrJzxWvFC+YP4TQOtYFBdKDwFl0US5jzvUIKP5cjBDgyelfZgapca1fdGo2ZZ3
 4Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=RpUzZF2Q8Wg4M6KhoZQGKKLKeyPK2Vo3YLy+vit6Tsg=;
 b=S8pt0mVGuwLqpxHWCqqhE+4nndrvhBYWQ/AC2MiF0apFwzcIiwlFf/ND2NtC4OX64M
 PVavnzE3VErfZfU7sjypXHCMdGdxaeY9XiUSolsnZ9MZ+Jt9R6pe5Pgc6B0hA6LhFxFL
 rLa8ptycOWokI76htpUzcjzDW51mb7qnDnWheXEDpVVBENgGBmW81h5ujGRwuf22EN5x
 S+eRoy8sKV9dN8cZ5GRDb1GcaxnrvVGiNhGyb4Ml3cu4agw8oR6caUU0lFiBQs9YB+ZL
 2k6AZ8umKSLEn5b4POmUoXVfYDsigrAt70jbR1gJDgzH5TjCdeHY3cgOiPiblhRWRiP4
 RZ5A==
X-Gm-Message-State: AOAM531uR+KGttYL5jeSHt98b/aDVkR6+4fB/FYsAE51evBJh25EpsZ7
 VPVUOYJA2ta3tVH+GT2jqHg=
X-Google-Smtp-Source: ABdhPJxLe3wBEyL5arMrMHSgVGoujiAMi6K8gouLqrsZks4l3J8qDlfiiLDr0lXbJUTP4/Z0O/rnlA==
X-Received: by 2002:aa7:d784:: with SMTP id s4mr25528894edq.215.1607449294061; 
 Tue, 08 Dec 2020 09:41:34 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id op5sm15961380ejb.43.2020.12.08.09.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Dec 2020 09:41:33 -0800 (PST)
Subject: Re: [PATCH 1/3] drm/amdgpu: free the pre-OS console framebuffer after
 the first modeset
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201208160556.39899-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c60e4b0d-5b1c-1b4f-49a6-7756176a4217@gmail.com>
Date: Tue, 8 Dec 2020 18:41:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201208160556.39899-1-alexander.deucher@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDguMTIuMjAgdW0gMTc6MDUgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gUmF0aGVyIHRoYW4g
aW4gbGF0ZV9pbml0IHRvIGF2b2lkIHJhY2UgY29uZGl0aW9ucyBiZXR3ZWVuIGZyZWVpbmcgdGhl
Cj4gYnVmZmVycyBhbmQgdGhlIGluaXRpYWwgbW9kZXNldC4KPgo+IFNpZ25lZC1vZmYtYnk6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGZvciBwYXRjaGVzICMxIAph
bmQgIzIsIGFja2VkLWJ5IGZvciAjMy4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdHRtLmMgICAgICAgICAgIHwgOCArKy0tLS0tLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDUgKysrKysKPiAgIDIgZmls
ZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+IGluZGV4IGU0OWI1MTlhYWI4MC4uNmJlMTMx
ZGYyMWY1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90
dG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+IEBA
IC0yMDI2LDEwICsyMDI2LDYgQEAgaW50IGFtZGdwdV90dG1faW5pdChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKPiAgICAqLwo+ICAgdm9pZCBhbWRncHVfdHRtX2xhdGVfaW5pdChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKPiAgIHsKPiAtCS8qIHJldHVybiB0aGUgVkdBIHN0b2xlbiBt
ZW1vcnkgKGlmIGFueSkgYmFjayB0byBWUkFNICovCj4gLQlpZiAoIWFkZXYtPm1tYW4ua2VlcF9z
dG9sZW5fdmdhX21lbW9yeSkKPiAtCQlhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmFkZXYtPm1tYW4u
c3RvbGVuX3ZnYV9tZW1vcnksIE5VTEwsIE5VTEwpOwo+IC0JYW1kZ3B1X2JvX2ZyZWVfa2VybmVs
KCZhZGV2LT5tbWFuLnN0b2xlbl9leHRlbmRlZF9tZW1vcnksIE5VTEwsIE5VTEwpOwo+ICAgfQo+
ICAgCj4gICAvKgo+IEBAIC0yMDQyLDggKzIwMzgsOCBAQCB2b2lkIGFtZGdwdV90dG1fZmluaShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAo+ICAgCWFtZGdwdV90dG1fdHJhaW5pbmdf
cmVzZXJ2ZV92cmFtX2ZpbmkoYWRldik7Cj4gICAJLyogcmV0dXJuIHRoZSBzdG9sZW4gdmdhIG1l
bW9yeSBiYWNrIHRvIFZSQU0gKi8KPiAtCWlmIChhZGV2LT5tbWFuLmtlZXBfc3RvbGVuX3ZnYV9t
ZW1vcnkpCj4gLQkJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5tbWFuLnN0b2xlbl92Z2Ff
bWVtb3J5LCBOVUxMLCBOVUxMKTsKPiArCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRldi0+bW1h
bi5zdG9sZW5fdmdhX21lbW9yeSwgTlVMTCwgTlVMTCk7Cj4gKwlhbWRncHVfYm9fZnJlZV9rZXJu
ZWwoJmFkZXYtPm1tYW4uc3RvbGVuX2V4dGVuZGVkX21lbW9yeSwgTlVMTCwgTlVMTCk7Cj4gICAJ
LyogcmV0dXJuIHRoZSBJUCBEaXNjb3ZlcnkgVE1SIG1lbW9yeSBiYWNrIHRvIFZSQU0gKi8KPiAg
IAlhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmFkZXYtPm1tYW4uZGlzY292ZXJ5X21lbW9yeSwgTlVM
TCwgTlVMTCk7Cj4gICAJYW1kZ3B1X3R0bV9md19yZXNlcnZlX3ZyYW1fZmluaShhZGV2KTsKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMK
PiBpbmRleCAyNTUxNzFiOGM0MzQuLmU2NGIzNjVkMDdhZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+IEBAIC04NDQwLDYg
Kzg0NDAsMTEgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2RtX2F0b21pY19jb21taXRfdGFpbChzdHJ1
Y3QgZHJtX2F0b21pY19zdGF0ZSAqc3RhdGUpCj4gICAKPiAgIAlkcm1fYXRvbWljX2hlbHBlcl9j
bGVhbnVwX3BsYW5lcyhkZXYsIHN0YXRlKTsKPiAgIAo+ICsJLyogcmV0dXJuIHRoZSBzdG9sZW4g
dmdhIG1lbW9yeSBiYWNrIHRvIFZSQU0gKi8KPiArCWlmICghYWRldi0+bW1hbi5rZWVwX3N0b2xl
bl92Z2FfbWVtb3J5KQo+ICsJCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRldi0+bW1hbi5zdG9s
ZW5fdmdhX21lbW9yeSwgTlVMTCwgTlVMTCk7Cj4gKwlhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmFk
ZXYtPm1tYW4uc3RvbGVuX2V4dGVuZGVkX21lbW9yeSwgTlVMTCwgTlVMTCk7Cj4gKwo+ICAgCS8q
Cj4gICAJICogRmluYWxseSwgZHJvcCBhIHJ1bnRpbWUgUE0gcmVmZXJlbmNlIGZvciBlYWNoIG5l
d2x5IGRpc2FibGVkIENSVEMsCj4gICAJICogc28gd2UgY2FuIHB1dCB0aGUgR1BVIGludG8gcnVu
dGltZSBzdXNwZW5kIGlmIHdlJ3JlIG5vdCBkcml2aW5nIGFueQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
