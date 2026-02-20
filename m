Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480B6C5CFF1
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 22:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A782810E049;
	Fri, 20 Feb 2026 22:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WeY//jxx";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10DFA10E037;
 Fri, 20 Feb 2026 22:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Content-Type:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P8B+6GXZ399ZWge2H0cM69XOHnrsD1JgRoJzji7/1GE=; b=WeY//jxxlCYd+7abkehDiel/sa
 EuW99dwTqYOmaj4RoIMr18+M3hEeSb52CPMjA5BoQbHMxJqoXpGl7koSDP9ysTZzIjAOlIySc0iAI
 KbrXEQIPj5cv8jz/nSKqJqSUhZ6TpShoNK7zqUpSsa4Dq+c3YP7CT8KrQ66XwEvBz4HSV5A1lHTFU
 me2HFhvUgEyo+KDLKz8C1VD6Cp1B9oB0eGym+Otr+zni4vUjiXf75tPqhpfJxWB+wIIuik1ots9gO
 8GARBdSh5WOCt+2tnK7rdJRMIeJJaWUj1xJ8+000nVYsXW2IN8gjSivH6qYJQ+y6cVo37sGBN3dZH
 ZzatUY+g==;
Received: from [186.208.68.119] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1vtZHy-003Am8-6d; Fri, 20 Feb 2026 23:47:58 +0100
Content-Type: multipart/mixed; boundary="------------OEMSXoTdQf21wgWlM0UBxwwI"
Message-ID: <bed447c7-07a3-46a8-9bcf-da352810883b@igalia.com>
Date: Fri, 20 Feb 2026 19:47:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] VRR not detected on a DisplayPort monitor using an
 AMD GPU
To: Ivan Sergeev <ivan8215145640@gmail.com>,
 Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, regressions@lists.linux.dev,
 mario.limonciello@amd.com, alex.hung@amd.com, daniel.wheeler@amd.com,
 rodrigo.siqueira@amd.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, christian.koenig@amd.com, huangalex409@gmail.com
References: <CAKx_Wg7_HBxuq5W4T_AmoFYJGQpa6TAS_Fx9SUzyy1itPmj5Bw@mail.gmail.com>
 <090d89a2-4f80-44ef-827c-6462d8948493@kernel.org>
 <DGJFVPAQJA15.378GMU7XZXLU@gmail.com> <DGJGDIRQWDG7.XHHKF6UQP0HG@gmail.com>
 <c70fe261-7fb0-4af5-b755-f02b193c8c5f@kernel.org>
 <DGJH30US2XMK.S2HOHR14LIW0@gmail.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <DGJH30US2XMK.S2HOHR14LIW0@gmail.com>
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

This is a multi-part message in MIME format.
--------------OEMSXoTdQf21wgWlM0UBxwwI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ivan,

Thanks for reporting this issue and follow-up bisecting.
Can you check if the attached patch resolves the issue?

Thanks in advance,

Melissa Wen

On 20/02/2026 00:35, Ivan Sergeev wrote:
> On Fri Feb 20, 2026 at 6:14 AM MSK, Mario Limonciello wrote:
>> Can you check out at your bad commit and apply just 7f2b5237e313 at the
>> bad commit?  Confirm that fixes it.
> Applied 7f2b5237e313 on top of 0159f88a99c9 and the issue persists.

--------------OEMSXoTdQf21wgWlM0UBxwwI
Content-Type: text/x-patch; charset=UTF-8;
 name="vrr-without-continuous-freq-support.patch"
Content-Disposition: attachment;
 filename="vrr-without-continuous-freq-support.patch"
Content-Transfer-Encoding: base64

RnJvbSA1ZDVjNDA1MmZjNjRhNjM4MDNmMmYwYWNmN2MyNzYwYjViOGI1MjE4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNZWxpc3NhIFdlbiA8bXdlbkBpZ2FsaWEuY29tPgpE
YXRlOiBGcmksIDIwIEZlYiAyMDI2IDE5OjM4OjQzIC0wMzAwClN1YmplY3Q6IFtQQVRDSF0g
ZHJtL2RybV9lZGlkOiBpZ25vcmUgY29udGludW91cyBmcmVxIHN1cHBvcnQgZm9yIG1vbml0
b3IgcmFuZ2UKCkdldCB0aGUgbWluIGFuZCBtYXggcmVmcmVzaCByYXRlIGV2ZW4gaWYgZWRp
ZCBkb2Vzbid0IHNheSB0aGUgZGlzcGxheQpzdXBwb3J0cyBjb250aW51b3VzIGZyZXF1ZW5j
aWVzLgoKU2lnbmVkLW9mZi1ieTogTWVsaXNzYSBXZW4gPG13ZW5AaWdhbGlhLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vZHJtX2VkaWQuYyB8IDMgLS0tCiAxIGZpbGUgY2hhbmdlZCwg
MyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2VkaWQu
YyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZWRpZC5jCmluZGV4IDI2YmI3NzEwYTQ2Mi4uMTdj
MzJiMzMxNzJlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2VkaWQuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vZHJtX2VkaWQuYwpAQCAtNjUxNiw5ICs2NTE2LDYgQEAgc3Rh
dGljIHZvaWQgZHJtX2dldF9tb25pdG9yX3JhbmdlKHN0cnVjdCBkcm1fY29ubmVjdG9yICpj
b25uZWN0b3IsCiAJaWYgKGRybV9lZGlkLT5lZGlkLT5yZXZpc2lvbiA8IDQpCiAJCXJldHVy
bjsKIAotCWlmICghKGRybV9lZGlkLT5lZGlkLT5mZWF0dXJlcyAmIERSTV9FRElEX0ZFQVRV
UkVfQ09OVElOVU9VU19GUkVRKSkKLQkJcmV0dXJuOwotCiAJZHJtX2Zvcl9lYWNoX2RldGFp
bGVkX2Jsb2NrKGRybV9lZGlkLCBnZXRfbW9uaXRvcl9yYW5nZSwgJmNsb3N1cmUpOwogCiAJ
ZHJtX2RiZ19rbXMoY29ubmVjdG9yLT5kZXYsCi0tIAoyLjUwLjEK

--------------OEMSXoTdQf21wgWlM0UBxwwI--
