Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C891FC55193
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 12:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8242076C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 12:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRavvSFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8242076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6956B6E52A;
	Thu, 23 Apr 2020 12:27:53 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA986E52A
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 12:27:52 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id t63so6202698wmt.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 05:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=W4QHK0i6fPlYTCtfRolEDHIKKzr1c93DED00GIoZd9w=;
 b=eRavvSFQvO9CzhEQfgZF2+BJorOj2IpEBaVwrhf40QOtQL2h95tatb4dJJGPr8TpfS
 955qrm1k20AJRBxxUnrUlXb9zPlvSy7cR5VnhJ1bELlpmtlFjmOAtQN01shGJHmLdmgz
 78prIFyVBnGUDctuMt1mlYotoP79pnb34eslRC/pbfAXzCcIGYVGzb1UovAqbdlRJigp
 WaBQWJdoGDz5jqGwTbz5vYfqz8/A0vNaiR4CSPsfnJtheIRRh7DCyr5v3p7ErEXbbmQx
 a8znjiAMiHjQXIkpWl5SlOTrorYEpDR438apf4A12CG+3rk69sW5+aqGDVojp+pOdbKE
 koTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=W4QHK0i6fPlYTCtfRolEDHIKKzr1c93DED00GIoZd9w=;
 b=TyLrqv2uPOiO7jMHXqKuOrcsK9l881CqLVDL82f7nP+4c7ls+zWeoh2ngssEjEKfks
 97IvSbGxgZ1HcCXkIgNcf5F3YdjNUAdC8QbER73zSMv8vap1lWs126Sf1pLDWEQqdXfa
 lgPOsdzdy+g3YFlNTFkHCMz78MwDmMgj86yT5njqNDeoDfIhqX+gXo4qfYBVnaZqm0uE
 kTcN3oPGUQWC//72Fq+9XTd0A3RLTral2rhboyKcHNaw95WYpkVLq9J892gJW3TePFS+
 9NteGM/3/KXfhKitZ7YOPF4N2KqOwJU25yUxEYUgFX5rdH0k+IaGNvE8UNhTuIjwQrUo
 F7hw==
X-Gm-Message-State: AGi0PuZSImkxkwr0tcGZDfW1VhA/MwhRQcokYO4tYHufw2ToqHEuuagQ
 +bEsUujzsF5hgnRyPVdfoR39J6zA
X-Google-Smtp-Source: APiQypL7PThUi74TpMdqgjpYVU6yl4ORqIj6/09bPpnDwPypGK9A3n1UeaBY77EkNr1woc2mv5+6gA==
X-Received: by 2002:a1c:6741:: with SMTP id b62mr3875660wmc.22.1587644870699; 
 Thu, 23 Apr 2020 05:27:50 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id w83sm3628341wmb.37.2020.04.23.05.27.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Apr 2020 05:27:50 -0700 (PDT)
Subject: Re: [PATCH 4/8] drm/amdgpu: provide RREG32_SOC15_NO_KIQ, will be used
 later
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
 <1587625306-20704-4-git-send-email-Monk.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <935b724f-0474-efd5-089b-46faf22af972@gmail.com>
Date: Thu, 23 Apr 2020 14:27:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1587625306-20704-4-git-send-email-Monk.Liu@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjMuMDQuMjAgdW0gMDk6MDEgc2NocmllYiBNb25rIExpdToKPiBTaWduZWQtb2ZmLWJ5OiBN
b25rIExpdSA8TW9uay5MaXVAYW1kLmNvbT4KCgpZZWFoLCBJIGFsc28gc3R1bWJsZWQgb3ZlciB0
aGF0IHJlY2VudGx5LiBQYXRjaCBpcyBBY2tlZC1ieTogQ2hyaXN0aWFuIApLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4uCgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMTVfY29tbW9uLmggfCAzICsrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1X2Nv
bW1vbi5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTVfY29tbW9uLmgKPiBpbmRl
eCBjODkzYzY0Li41NmQwMmFhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NvYzE1X2NvbW1vbi5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29j
MTVfY29tbW9uLmgKPiBAQCAtMzUsNiArMzUsOSBAQAo+ICAgI2RlZmluZSBSUkVHMzJfU09DMTUo
aXAsIGluc3QsIHJlZykgXAo+ICAgCVJSRUczMihhZGV2LT5yZWdfb2Zmc2V0W2lwIyNfSFdJUF1b
aW5zdF1bcmVnIyNfQkFTRV9JRFhdICsgcmVnKQo+ICAgCj4gKyNkZWZpbmUgUlJFRzMyX1NPQzE1
X05PX0tJUShpcCwgaW5zdCwgcmVnKSBcCj4gKwlSUkVHMzJfTk9fS0lRKGFkZXYtPnJlZ19vZmZz
ZXRbaXAjI19IV0lQXVtpbnN0XVtyZWcjI19CQVNFX0lEWF0gKyByZWcpCj4gKwo+ICAgI2RlZmlu
ZSBSUkVHMzJfU09DMTVfT0ZGU0VUKGlwLCBpbnN0LCByZWcsIG9mZnNldCkgXAo+ICAgCVJSRUcz
MigoYWRldi0+cmVnX29mZnNldFtpcCMjX0hXSVBdW2luc3RdW3JlZyMjX0JBU0VfSURYXSArIHJl
ZykgKyBvZmZzZXQpCj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
