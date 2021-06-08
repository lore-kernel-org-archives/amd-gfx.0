Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0E1C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 07:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FDE261184
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 07:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDE261184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1835B6EACB;
	Tue,  8 Jun 2021 07:23:05 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB6A6EACB
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 07:23:03 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id r9so3641040wrz.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Jun 2021 00:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=qEYk4rO04sFb5hZYhqpzWGO+a2baUyk9rfjywDsF2e8=;
 b=dRmbkdQdhh9IMXHSaKX6lPxy9BUIpgElArg9G+csn7p7GJ0fvhPV17CbwSCTIS1/KX
 46XvOmOL663OGtO8liima16o4Rxt9OF2Yjn9Jn33fpJARb9qqAbkunvz98CT2g8iZPC/
 D9BRRloAO2G2PJ95W3Ch/3Bm5FbSXJ9s4rAc+lJ4KeoUXVG7EHau8jU8mqt94Zifus6W
 U9w9q0w/j8+LelavM+kZy7iHp7qZNzzghzxLMPAsXc4zqYIvT7+BzUy/rCNsp4X1b8em
 +7O5jR9zB+z8f6Kisaq1oyuXnWzAeshGKYdhpdo2Rdt/n0vB9N+p1F4ygBRlSTmyEdAB
 sZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=qEYk4rO04sFb5hZYhqpzWGO+a2baUyk9rfjywDsF2e8=;
 b=S4JNxyrza3ewEI2kiF75vVsaKALht7U1QS/uajdxaIEPjx+MAUfDaolv3La3TnmBfc
 aEI85lG5zAVHqFVhERAYpmQHPbToCLeal+3dSVcS9n1dnj8sxM2jKoDqmwJHgQTPiCR7
 LFeiopthlXRBN9Mq/jtDAdbnvabNBEgkjncbLeH12xWBspSPrXHbbDJJyjI6XA5VK6Em
 rOV1rtSXfcKnP+q45dI8H5a55qJCaUW+BO1VVFrVQm6oqGLMu2nsv4eApqUSl6B7CgKz
 hC2HaoxJcq+ggwkkbxhamXcGzg22O3eMEw8hKkw2SG7jGTzavXjb5hyqYjHEppwBtzMY
 1a4w==
X-Gm-Message-State: AOAM531lK0YZZKli5ZUUoG4auTcmomP2RHDR/L3I8WGt1kG8vRN3C+cu
 ENTB2yHoucFCgdYevoJEDEOJj1vswSM=
X-Google-Smtp-Source: ABdhPJxIEC0jq9joko9RB2EcBFSLVJXlidHxT99zh1bC7Hed3+PnfGyPlVqQZ5b8LYL1csTe240ABQ==
X-Received: by 2002:adf:bc07:: with SMTP id s7mr21080531wrg.301.1623136982612; 
 Tue, 08 Jun 2021 00:23:02 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:197a:8536:afbe:3762?
 ([2a02:908:1252:fb60:197a:8536:afbe:3762])
 by smtp.gmail.com with ESMTPSA id p16sm19258459wrs.52.2021.06.08.00.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jun 2021 00:23:02 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/vcn: drop gfxoff control for VCN2+
To: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210607202841.2120465-1-alexander.deucher@amd.com>
 <DM6PR12MB4843FC5C5BF8086C627A0BC887389@DM6PR12MB4843.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <558a24e0-3057-873b-e7fe-261975f9dc40@gmail.com>
Date: Tue, 8 Jun 2021 09:23:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB4843FC5C5BF8086C627A0BC887389@DM6PR12MB4843.namprd12.prod.outlook.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCkFt
IDA3LjA2LjIxIHVtIDIzOjMyIHNjaHJpZWIgWmhhbmcsIEJveXVhbjoKPiBbQU1EIE9mZmljaWFs
IFVzZSBPbmx5XQo+Cj4gUGF0Y2ggaXMKPiBSZXZpZXdlZC1ieTogQm95dWFuIFpoYW5nIDxCb3l1
YW4uWmhhbmdAYW1kLmNvbT4KPgo+IFRoYW5rcywKPiBCb3l1YW4KPgo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mIEFsZXggRGV1Y2hlcgo+IFNlbnQ6IEp1bmUgNywgMjAy
MSA0OjI5IFBNCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4KPiBTdWJqZWN0OiBbUEFU
Q0hdIGRybS9hbWRncHUvdmNuOiBkcm9wIGdmeG9mZiBjb250cm9sIGZvciBWQ04yKwo+Cj4gRHJv
cCBkaXNhYmxpbmcgb2YgZ2Z4b2ZmIGR1cmluZyBWQ04gdXNlLiAgVGhpcyBhbGxvd3MgZ2Z4b2Zm
IHRvIGtpY2sgaW4gYW5kIHBvdGVudGlhbGx5IHNhdmUgcG93ZXIgaWYgdGhlIHVzZXIgaXMgbm90
IHVzaW5nIGdmeCBmb3IgY29sb3Igc3BhY2UgY29udmVyc2lvbiBvciBzY2FsaW5nLgo+Cj4gVkNO
MS4wIGhhZCBhIGJ1ZyB3aGljaCBwcmV2ZW50ZWQgaXQgZnJvbSB3b3JraW5nIHByb3Blcmx5IHdp
dGggZ2Z4b2ZmLCBzbyB3ZSBkaXNhYmxlZCBpdCB3aGlsZSB1c2luZyBWQ04uICBUaGF0IHNhaWQs
IG1vc3QgYXBwcyB0b2RheSB1c2UgZ2Z4IGZvciBzY2FsaW5nIGFuZCBjb2xvciBzcGFjZSBjb252
ZXJzaW9uIHJhdGhlciB0aGFuIG92ZXJsYXkgcGxhbmVzIHNvIGl0IHdhcyBnZW5lcmFsbHkgaW4g
dXNlIGFueXdheS4gVGhpcyB3YXMgZml4ZWQgb24gVkNOMissIGJ1dCBzaW5jZSB3ZSBtb3N0bHkg
dXNlIGdmeCBmb3IgY29sb3Igc3BhY2UgY29udmVyc2lvbiBhbmQgc2NhbGluZyBhbmQgcmFwaWRs
eSBwb3dlcmluZyB1cC9kb3duIGdmeCBjYW4gbmVnYXRlIHRoZSBhZHZhbnRhZ2VzIG9mIGdmeG9m
Ziwgd2UgbGVmdCBnZnhvZmYgZGlzYWJsZWQuIEFzIG1vcmUgYXBwbGljYXRpb25zIHVzZSBvdmVy
bGF5IHBsYW5lcyBmb3IgY29sb3Igc3BhY2UgY29udmVyc2lvbiBhbmQgc2NhbGluZywgdGhpcyBz
dGFydHMgdG8gYmUgYSB3aW4sIHNvIGdvIGFoZWFkIGFuZCBsZWF2ZSBnZnhvZmYgZW5hYmxlZC4K
Pgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyB8IDIg
LS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+IGluZGV4IDFkYzExZGJkNjJiNy4uNjQ3ZDJjMzFlOGJk
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+IEBAIC0zOTMs
NyArMzkzLDYgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Zjbl9pZGxlX3dvcmtfaGFuZGxlcihzdHJ1
Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4gICAgICAgICAgfQo+Cj4gICAgICAgICAgaWYgKCFmZW5j
ZXMgJiYgIWF0b21pY19yZWFkKCZhZGV2LT52Y24udG90YWxfc3VibWlzc2lvbl9jbnQpKSB7Cj4g
LSAgICAgICAgICAgICAgIGFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgdHJ1ZSk7Cj4gICAgICAg
ICAgICAgICAgICBhbWRncHVfZGV2aWNlX2lwX3NldF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LCBB
TURfSVBfQkxPQ0tfVFlQRV9WQ04sCj4gICAgICAgICAgICAgICAgICAgICAgICAgQU1EX1BHX1NU
QVRFX0dBVEUpOwo+ICAgICAgICAgICAgICAgICAgciA9IGFtZGdwdV9kcG1fc3dpdGNoX3Bvd2Vy
X3Byb2ZpbGUoYWRldiwgUFBfU01DX1BPV0VSX1BST0ZJTEVfVklERU8sIEBAIC00MTMsNyArNDEy
LDYgQEAgdm9pZCBhbWRncHVfdmNuX3JpbmdfYmVnaW5fdXNlKHN0cnVjdCBhbWRncHVfcmluZyAq
cmluZykKPiAgICAgICAgICBhdG9taWNfaW5jKCZhZGV2LT52Y24udG90YWxfc3VibWlzc2lvbl9j
bnQpOwo+Cj4gICAgICAgICAgaWYgKCFjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPnZj
bi5pZGxlX3dvcmspKSB7Cj4gLSAgICAgICAgICAgICAgIGFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRl
diwgZmFsc2UpOwo+ICAgICAgICAgICAgICAgICAgciA9IGFtZGdwdV9kcG1fc3dpdGNoX3Bvd2Vy
X3Byb2ZpbGUoYWRldiwgUFBfU01DX1BPV0VSX1BST0ZJTEVfVklERU8sCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdHJ1ZSk7Cj4gICAgICAgICAgICAgICAgICBpZiAocikKPiAt
LQo+IDIuMzEuMQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJs
PWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZv
JTJGYW1kLWdmeCZhbXA7ZGF0YT0wNCU3QzAxJTdDYm95dWFuLnpoYW5nJTQwYW1kLmNvbSU3Q2Ex
NDk2Yjk5Nzc1YTQ4NWIyOTdkMDhkOTI5ZjJlOTUwJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJk
OTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzU4Njk0NTU0NzcwMzgxNSU3Q1Vua25vd24lN0NUV0ZwYkda
c2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dp
TENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT0zNVVmWEkzZ1RZRVdjV0tuNGZGVmhhYzhy
SEt5WmxrNkFTSVpxaktJTkpRJTNEJmFtcDtyZXNlcnZlZD0wCj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
