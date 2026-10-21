Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BA0606A321
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L5mR6Ve0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64BDA11246A;
	Thu, 22 Oct 2026 09:45:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E9ED10E185
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 14:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792592847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=BgJaPN7+t/OnIjDm3FJwmimpkBmmVbBpAVjo29bLXO4=;
 b=L5mR6Ve0BNw9oV+ft9tiRl9w8eTlcn3isFkj08VYDFWZDyvfIf98+0Re8cM4AqXdBlaQ1H
 84o90NECoMMG5ao9hY1EOzud/y6+ZZsLuCoR2w1aL5AAtr7Jg4wXwGr2/MgpgWQPs8S5yo
 gIXmPVU1EN9tnAXyn5VuFbx+urJbU94=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-NrkFuog6OAepRPq8vDBSUQ-1; Wed, 21 Oct 2026 10:27:19 -0400
X-MC-Unique: NrkFuog6OAepRPq8vDBSUQ-1
X-Mimecast-MFC-AGG-ID: NrkFuog6OAepRPq8vDBSUQ_1792592838
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1bfd5516bso7795125e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 07:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592838; x=1793197638;
 h=organization:subject:from:to:content-language:user-agent
 :mime-version:date:message-id:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P0qFP12+ZS53KgWT0UxspP70Gni03wnpVKp/Bk8tFDc=;
 b=oRqtMP7jTxAfIbdHmqb6kiCoF6UqtbKt+kET6KdAJbU2rsqc2HHECbhdp9C1TPPow1
 lcrcFFQE3kY8907yuJBY6Gv6hOMaq2bIPvRqQZhlNSRX60vtbcDLQiJ/glJppdvXCr3w
 W0uzCguKQgdbP6FqjyvPGW7PMmPZ7xRATQvLBPtbjMDr1/NChbaAHPlratkR7dLJZahc
 /n8/2jC/Ra4twAHVq8McxFiCexKWVmac8bqzZesapWFXCQUAKfczRgXrw6pjEd7ptbgB
 Tv5UBdKoEyToNYIxfFM5ICbbtTvTKCGR7msni21aFoysKpjzhUe+8JcfMMdP6+tT5kq9
 30zA==
X-Gm-Message-State: AFq9FYK0IQntaLWNQQqQN0PkKANCArPm/ffLfxFDhhRhkq3CqBiX3+09
 P8CWXI7GFJ4lzGH/28x6m6KqUIC1E18o5lBAZuO4BHvzbxLrYElNIi4MEJqXJQ1oVdUykfD+Nho
 JSagguofN+Pxn+/e9ZctOmaD1tPa/utCIJ2QXYidHR0EAEGPtAj3jfnTaN3f1UukLCud7wl3b5C
 ZMtkKUVjv3Fx1o3/cIlBW/6UiIPb2zhAKFYYKkqyM7YYDHKKBwPAM=
X-Gm-Gg: AYBFou1BDQNucXPYxc12tEJvcwX+J3Pcbcj8U7+JgnP33TZxKRvHOE/dM58o0XzB3nk
 pfsz2UVKDd0lnBfMrOfA8Jk8YOZz1RblUreWDEfSqjs40IVZuGITKOHUvjbu4MG8SOyEVDO5L/e
 kU9XHPqxeEMJZ7z6I2m9gUV7G7GWpe2zLu2qka2fhsAPmn8LUDhvHje/pQTlX1UPjGxyVG0cogJ
 XJT4KVLMou3JUdnwID9qJDEqnaE8c4LBBmQxljneBydjF4Tj6MZgl/lfKQ0AaGgP2oemdep2p22
 oy1V7MAvlneex8E8NsStJvA0YUxaGjeaicXRP78daVtz9SDjoeE/AoIX048dumJqDjQAOhL9eBg
 vhw==
X-Received: by 2002:a05:600c:310b:b0:4a1:e7c2:9f48 with SMTP id
 5b1f17b1804b1-4a1fdaef8c6mr45541075e9.10.1792592838197; 
 Wed, 21 Oct 2026 07:27:18 -0700 (PDT)
X-Received: by 2002:a05:600c:310b:b0:4a1:e7c2:9f48 with SMTP id
 5b1f17b1804b1-4a1fdaef8c6mr45539565e9.10.1792592836884; 
 Wed, 21 Oct 2026 07:27:16 -0700 (PDT)
Received: from [192.168.0.99] ([212.20.115.16])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fb698cebsm118349035e9.1.2026.10.21.07.27.15
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 07:27:16 -0700 (PDT)
Message-ID: <ca473b96-51f7-4b93-a9c1-5beb04bdb7f9@redhat.com>
Date: Wed, 21 Oct 2026 16:27:15 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: amd-gfx@lists.freedesktop.org
From: Zdenek Kabelac <zkabelac@redhat.com>
Subject: Wayne Lin <Wayne.Lin@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 dri-devel@lists.freedesktop.org
Organization: RedHat
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8jZ_yFTdsaUVt7vXHRjNRfx0KTw6u1AEBjRIumh9f1M_1792592838
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="------------uEQaEkJ0j2EildDrAy1oI3kX"
Content-Language: en-US, cs-CZ
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:44:57 +0000
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------uEQaEkJ0j2EildDrAy1oI3kX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch should fix the display-resume failure reported in
https://gitlab.freedesktop.org/drm/amd/-/issues/6012

Mario Limonciello asked me to submit it for review and to CC Wayne Lin.

When the USB4 link to a Thunderbolt dock is lost during s2idle, the DPIA
tunnel feeding the dock outputs is gone at resume, but dm_resume() still
re-commits the cached pre-suspend atomic state. Link training fails, the 
commit is nevertheless treated as successful, and the MST connector stays 
enabled with a stale payload and no disconnect event, so the monitor stays 
dark until reboot. The patch keeps the CRTCs of connectors whose DPIA link is 
gone disabled in the cached state, so the commit drops their streams; the 
output then returns through the normal hotplug path when the dock is 
re-enumerated.

The commit message credits the AI assistant that helped write the patch.

Since I'm not really an expert on AMDGPU and it's also not exactly trivial to 
hit this failure intentionally - I'm not yet 100% sure it fixes my problem - 
but the idea looks reasonable - so please review/improve/extend....

Regards

Zdenek

--------------uEQaEkJ0j2EildDrAy1oI3kX
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-drm-amd-display-do-not-resume-cached-CRTCs-of-lost-D.patch"
Content-Disposition: attachment;
 filename*0="0001-drm-amd-display-do-not-resume-cached-CRTCs-of-lost-D.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbTogWmRlbmVrIEthYmVsYWMgPHprYWJlbGFjQHJlZGhhdC5jb20+CkRhdGU6IFdlZCwgMjEg
T2N0IDIwMjYgMTY6MTE6MzYgKzAyMDAKU3ViamVjdDogW1BBVENIXSBkcm0vYW1kL2Rpc3BsYXk6
IGRvIG5vdCByZXN1bWUgY2FjaGVkIENSVENzIG9mIGxvc3QgRFBJQQogbGlua3MKCldoZW4gdGhl
IFVTQjQgbGluayB0byBhIFRodW5kZXJib2x0IGRvY2sgaXMgbG9zdCBkdXJpbmcgc3lzdGVtIHN1
c3BlbmQsCnRoZSBEUElBIHR1bm5lbCBmZWVkaW5nIHRoZSBkb2NrJ3MgZGlzcGxheSBvdXRwdXRz
IGlzIGdvbmUgYXQgcmVzdW1lLgpkbV9yZXN1bWUoKSBkZXRlY3RzIHRoaXMsIGJ1dCBkbV9kZXN0
cm95X2NhY2hlZF9zdGF0ZSgpIHRoZW4gcmUtY29tbWl0cwp0aGUgcHJlLXN1c3BlbmQgYXRvbWlj
IHN0YXRlLCB3aGljaCBzdGlsbCBlbmFibGVzIHRoZSBNU1QgY29ubmVjdG9yIG9uCnRoYXQgZGVh
ZCB0dW5uZWw6CgogIHRodW5kZXJib2x0IDAwMDA6YzY6MDAuNTogMDoyOiBmYWlsZWQgdG8gcmVh
Y2ggc3RhdGUgVEJfUE9SVF9VUC4gSWdub3JpbmcgcG9ydC4uLgogIHRodW5kZXJib2x0IDAwMDA6
YzY6MDAuNTogMDoyOiBsb3N0IGR1cmluZyBzdXNwZW5kLCBkaXNjb25uZWN0aW5nCiAgLi4uCiAg
W2RybV0gRFBJQSBBVVggZmFpbGVkIG9uIDB4MCgxNSksIGVycm9yIDcKICBbZHJtXSAqRVJST1Iq
IGRwY2Rfc2V0X2xpbmtfc2V0dGluZ3M6MTE1NjogY29yZV9saW5rX3dyaXRlX2RwY2QgKERQX0xJ
TktfQldfU0VUKSBmYWlsZWQKICBbZHJtXSBlbmFibGluZyBsaW5rIDQgZmFpbGVkOiAxNQogIFdB
Uk5JTkc6IC4uLi9kYy9saW5rL2xpbmtfZHBtcy5jOjE0MTggYXQgYWxsb2NhdGVfbXN0X3BheWxv
YWQKICBbZHJtXSAqRVJST1IqIEZhaWx1cmU6IHVua25vd24gZW5jb2RpbmcgZm9ybWF0CgpFbmFi
bGluZyB0aGUgbGluayBmYWlscywgYnV0IGxpbmtfc2V0X2RwbXNfb25fcG9zdF9lbmFibGVfbGlu
aygpIHN0aWxsCmVuYWJsZXMgYW5kIHVuYmxhbmtzIHRoZSBzdHJlYW0sIGFsbG9jYXRlX21zdF9w
YXlsb2FkKCkgb25seSB3YXJucywgYW5kCmRjZTExMF9hcHBseV9zaW5nbGVfY29udHJvbGxlcl9j
dHhfdG9faHcoKSBkaXNjYXJkcyB0aGUgc2V0X2RwbXNfb24oKQpyZXN1bHQgYW5kIHJldHVybnMg
RENfT0suIFRoZSBjb21taXQgaXMgdGh1cyB0cmVhdGVkIGFzIHN1Y2Nlc3NmdWwgYW5kCnRoZSBN
U1QgY29ubmVjdG9yIHN0YXlzIGVuYWJsZWQgd2l0aCBhIHN0YWxlIHBheWxvYWQsIHdpdGhvdXQg
YQpkaXNjb25uZWN0IGV2ZW50LiBObyBsYXRlciBob3RwbHVnIGNhbiByZWNvdmVyIHRoZSBvdXRw
dXQ6IHRoZSBtb25pdG9yCnN0YXlzIGRhcmsgdW50aWwgcmVib290LgoKVGhlIGRldGVjdGlvbiBs
b29wIGluIGRtX3Jlc3VtZSgpIHJ1bnMgYmVmb3JlIGRtX2Rlc3Ryb3lfY2FjaGVkX3N0YXRlKCkK
YW5kIGFscmVhZHkga25vd3MgdGhlIHR1bm5lbCBpcyBnb25lOiB0aGUgRFBJQSBIUEQgcXVlcnkg
Y2xlYXJzCmhwZF9zdGF0dXMgYW5kIGxpbmstPnR5cGUgYmVjb21lcyBkY19jb25uZWN0aW9uX25v
bmUuIFVzZSB0aGF0CmluZm9ybWF0aW9uIHRvIGtlZXAgdGhlIENSVENzIG9mIHN1Y2ggY29ubmVj
dG9ycyBkaXNhYmxlZCBpbiB0aGUgY2FjaGVkCnN0YXRlLCBzbyB0aGUgY29tbWl0IGRyb3BzIHRo
ZWlyIHN0cmVhbXMgaW5zdGVhZCBvZiBwcm9ncmFtbWluZyB0aGVtIG9uCmEgZGVhZCBsaW5rLiBU
aGUgb3V0cHV0IHRoZW4gcmV0dXJucyB0aHJvdWdoIHRoZSBvcmRpbmFyeSBob3RwbHVnIHBhdGgK
d2hlbiB0aGUgZG9jayBpcyByZS1lbnVtZXJhdGVkLgoKTGluazogaHR0cHM6Ly9naXRsYWIuZnJl
ZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvNjAxMgpDYzogV2F5bmUgTGluIDxXYXluZS5M
aW5AYW1kLmNvbT4KQ28tYXV0aG9yZWQtYnk6IE9wZW5Db2RlIDxub3JlcGx5QG9wZW5jb2RlLmFp
PgpTaWduZWQtb2ZmLWJ5OiBaZGVuZWsgS2FiZWxhYyA8emthYmVsYWNAcmVkaGF0LmNvbT4KLS0t
CiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCA0NyArKysr
KysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4
IDQ3YTBmZjJlZDAzNS4uNThhYjE3MGIwMzQzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTE1MTQsNiArMTUxNCw1MSBAQCBz
dGF0aWMgaW50IGRtX2NhY2hlX3N0YXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCXJl
dHVybiBhZGV2LT5kbS5jYWNoZWRfc3RhdGUgPyAwIDogcjsKIH0KIAorLyoKKyAqIFJldHVybnMg
dHJ1ZSBpZiB0aGUgVVNCNCBEUElBIHR1bm5lbCBmZWVkaW5nIHRoaXMgY29ubmVjdG9yIGRvZXMg
bm90IGV4aXN0CisgKiBhbnltb3JlLiBDYWxsZWQgYWZ0ZXIgdGhlIHJlc3VtZSBkZXRlY3Rpb24g
bG9vcCwgc28gbGluay0+dHlwZSBhbmQKKyAqIGxpbmstPmhwZF9zdGF0dXMgcmVmbGVjdCB0aGUg
Y3VycmVudCBzdGF0ZSBvZiB0aGUgdHVubmVsLgorICovCitzdGF0aWMgYm9vbCBkbV9kcGlhX2xp
bmtfaXNfbG9zdChzdHJ1Y3QgYW1kZ3B1X2RtX2Nvbm5lY3RvciAqYWNvbm5lY3RvcikKK3sKKwlz
dHJ1Y3QgYW1kZ3B1X2RtX2Nvbm5lY3RvciAqcm9vdCA9IGFjb25uZWN0b3ItPm1zdF9yb290ID8K
KwkJYWNvbm5lY3Rvci0+bXN0X3Jvb3QgOiBhY29ubmVjdG9yOworCXN0cnVjdCBkY19saW5rICps
aW5rID0gcm9vdC0+ZGNfbGluazsKKworCWlmICghbGluayB8fCBsaW5rLT5lcF90eXBlICE9IERJ
U1BMQVlfRU5EUE9JTlRfVVNCNF9EUElBKQorCQlyZXR1cm4gZmFsc2U7CisKKwlyZXR1cm4gbGlu
ay0+dHlwZSA9PSBkY19jb25uZWN0aW9uX25vbmUgfHwgIWxpbmstPmhwZF9zdGF0dXM7Cit9CisK
Ky8qCisgKiBEbyBub3QgcmVzdG9yZSBhIGNhY2hlZCAocHJlLXN1c3BlbmQpIGF0b21pYyBzdGF0
ZSB0aGF0IGVuYWJsZXMgYSBkaXNwbGF5CisgKiB3aG9zZSBVU0I0IERQSUEgdHVubmVsIHdhcyBs
b3N0IGR1cmluZyBzdXNwZW5kLiBXaXRob3V0IHRoaXMgdGhlIGNhY2hlZAorICogc3RhdGUgaXMg
Y29tbWl0dGVkIG9uIGEgZGVhZCBsaW5rOiBNU1QgbGluayB0cmFpbmluZyBmYWlscywgeWV0IHRo
ZSBDUlRDIGlzCisgKiBlbmFibGVkIGFueXdheSBhbmQgdGhlIGNvbm5lY3RvciBpcyBuZXZlciBk
aXNhYmxlZCwgc28gbm8gbGF0ZXIgaG90cGx1ZyBjYW4KKyAqIHJlY292ZXIgdGhlIGRpc3BsYXkg
dW50aWwgdGhlIGRyaXZlciBpcyByZWxvYWRlZC4KKyAqLworc3RhdGljIHZvaWQgZG1fZGlzYWJs
ZV9sb3N0X2RwaWFfY3J0Y3Moc3RydWN0IGRybV9hdG9taWNfY29tbWl0ICpzdGF0ZSkKK3sKKwlz
dHJ1Y3QgZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yOworCXN0cnVjdCBkcm1fY29ubmVjdG9yX3N0
YXRlICpuZXdfY29ubl9zdGF0ZTsKKwlzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKm5ld19jcnRjX3N0
YXRlOworCWludCBpOworCisJZm9yX2VhY2hfbmV3X2Nvbm5lY3Rvcl9pbl9zdGF0ZShzdGF0ZSwg
Y29ubmVjdG9yLCBuZXdfY29ubl9zdGF0ZSwgaSkgeworCQlpZiAoIW5ld19jb25uX3N0YXRlLT5j
cnRjKQorCQkJY29udGludWU7CisKKwkJaWYgKCFkbV9kcGlhX2xpbmtfaXNfbG9zdCh0b19hbWRn
cHVfZG1fY29ubmVjdG9yKGNvbm5lY3RvcikpKQorCQkJY29udGludWU7CisKKwkJbmV3X2NydGNf
c3RhdGUgPSBkcm1fYXRvbWljX2dldF9uZXdfY3J0Y19zdGF0ZShzdGF0ZSwKKwkJCQkJCQkgICAg
ICAgbmV3X2Nvbm5fc3RhdGUtPmNydGMpOworCQlpZiAobmV3X2NydGNfc3RhdGUpCisJCQluZXdf
Y3J0Y19zdGF0ZS0+YWN0aXZlID0gZmFsc2U7CisJfQorfQorCiBzdGF0aWMgdm9pZCBkbV9kZXN0
cm95X2NhY2hlZF9zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAlzdHJ1Y3Qg
YW1kZ3B1X2Rpc3BsYXlfbWFuYWdlciAqZG0gPSAmYWRldi0+ZG07CkBAIC0xNTYwLDYgKzE2MDUs
OCBAQCBzdGF0aWMgdm9pZCBkbV9kZXN0cm95X2NhY2hlZF9zdGF0ZShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIAkJfQogCX0KIAorCWRtX2Rpc2FibGVfbG9zdF9kcGlhX2NydGNzKGRtLT5j
YWNoZWRfc3RhdGUpOworCiAJZHJtX2F0b21pY19oZWxwZXJfcmVzdW1lKGRkZXYsIGRtLT5jYWNo
ZWRfc3RhdGUpOwogCiAJZG0tPmNhY2hlZF9zdGF0ZSA9IE5VTEw7Ci0tIAoyLjU2LjAKCg==
--------------uEQaEkJ0j2EildDrAy1oI3kX--

