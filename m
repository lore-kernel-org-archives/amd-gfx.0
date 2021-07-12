Return-Path: <SRS0=L2kD=ME=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F6BC07E99
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jul 2021 09:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79F9D6108B
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jul 2021 09:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F9D6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A2C89B51;
	Mon, 12 Jul 2021 09:57:03 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9CA889B51
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jul 2021 09:57:01 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 d9-20020a17090ae289b0290172f971883bso11835561pjz.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jul 2021 02:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=5Ite8DmGr8LTHkNX2uAzERMgGyLghRyEa+Pi0pXsPIQ=;
 b=JLVM+j1ptmaLzNl/RODQotu8VtORjIRCjUDB18PpwRNooddcEU6owmBtxZpL6knSLw
 hpjyxBctsnmfryfeOk8E4eG6sWpX+f0O7p0rc/IusPcrtgAYKMShyQyhGo3OtZoYEdNu
 Kyuz1i1VsS3tjhZNJUcu3KRgFsnfw7go2NYcP933O10xPNMeD8WfrEKB+0eH55/oGZTH
 dk5sJCJEAvGBoyqtxOgm6HaK0s/9BY7wEZvJRTnOYiOor3WUfOXPRW7Ry7+ktaVpGe3I
 RtO78c19pJ6uYC8V2jNSy9k+TS8bP2U74ilWO1SoXj/pD3uUmlDM8quq4isQD5mzGQdL
 D4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=5Ite8DmGr8LTHkNX2uAzERMgGyLghRyEa+Pi0pXsPIQ=;
 b=Z0NBt6OxXDD0Hz0+7t+XEai/T8ECgTHdzhr+/F7jxCxlH0wufVGgEcBn71ge1S3qWr
 1VOIfR855m4/MY+5pXY0BW+7gQGQ8w5q7tTw2ikQHIozbcp0l2BogeBZgsfsfOWuKY2z
 WFSY8mrUIqjT36NS+tCei0rTidWvf8W4z3qSn+svnqnKus7foyNevsBhX/zyNi/77O6u
 auMYyEkSnMdvKSTzNoXHckjgsjP/dj/tUg8Dr+rFYHptjI6V6PpcrSRjJsEB17tWI5PP
 hmirSerqqkxVLN5R5BvdodZDQ7WnPc6q9Nakv5mDCg6qGeyelp0idjQ0ea4PFU27+fLl
 QhMg==
X-Gm-Message-State: AOAM532yyfSfPqhFN6ObReMJXQDUX3a5nyZbiY8HjqPM0FI5Y5ardMGV
 a0Lj9cBRRK9zp/VK+71D+fXzlLcw34g8kCTHNzSMWU6T89GqBQ==
X-Google-Smtp-Source: ABdhPJwCwaJvIcW+CyLVdUdiBZ4gILqw3H0hwoDiL1YT/kdWv/+yL4jW1im5g7yY6kOAe6Yo3towmHQmL/ENTkOMGoY=
X-Received: by 2002:a17:90a:17c1:: with SMTP id
 q59mr52101587pja.231.1626083821564; 
 Mon, 12 Jul 2021 02:57:01 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Tomasz_Mo=C5=84?= <desowin@gmail.com>
Date: Mon, 12 Jul 2021 11:56:50 +0200
Message-ID: <CAOHtt3_wfx1kpcjA3s63x+TaHS8DmCSk629OAN+Bi5nZzwrb5Q@mail.gmail.com>
Subject: Waiting for fences timed out on MacBook Pro 2019
To: amd-gfx@lists.freedesktop.org
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
Cc: alexander.deucher@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGVsbG8sCgpJIGFtIGhhdmluZyB0cm91YmxlIGdldHRpbmcgTGludXggdG8gcnVuIG9uIE1hY0Jv
b2sgUHJvIDIwMTkgd2l0aApSYWRlb24gUHJvIFZlZ2EgMjAgNCBHQi4gQmFzaWNhbGx5IGFzIHNv
b24gYXMgZ3JhcGhpY2FsIHVzZXIgaW50ZXJmYWNlCnN0YXJ0cywgdGhlIHdob2xlIHN5c3RlbSBm
cmVlemVzLiBUaGlzIGhhcHBlbnMgd2l0aCBldmVyeSBMaW51eCBrZXJuZWwKdmVyc2lvbiBJIGhh
dmUgdHJpZWQgb3ZlciB0aGUgbGFzdCBmZXcgbW9udGhzLCBpbmNsdWRpbmcgNS4xMy4KClVzaW5n
IFNTSCBJIGhhdmUgYmVlbiBhYmxlIHRvIHJlYWQgZG1lc2cgb3V0cHV0OgpbICAyMDcuMTEzMTQ0
XSBbZHJtOmFtZGdwdV9kbV9hdG9taWNfY29tbWl0X3RhaWwgW2FtZGdwdV1dICpFUlJPUioKV2Fp
dGluZyBmb3IgZmVuY2VzIHRpbWVkIG91dCEKWyAgMjA3LjExMzE2OF0gW2RybTphbWRncHVfZG1f
YXRvbWljX2NvbW1pdF90YWlsIFthbWRncHVdXSAqRVJST1IqCldhaXRpbmcgZm9yIGZlbmNlcyB0
aW1lZCBvdXQhClsgIDIxMi4wMjk4NjZdIFtkcm06YW1kZ3B1X2pvYl90aW1lZG91dCBbYW1kZ3B1
XV0gKkVSUk9SKiByaW5nIGdmeAp0aW1lb3V0LCBzaWduYWxlZCBzZXE9MTAyMiwgZW1pdHRlZCBz
ZXE9MTAyNApbICAyMTIuMDMwMDgzXSBbZHJtOmFtZGdwdV9qb2JfdGltZWRvdXQgW2FtZGdwdV1d
ICpFUlJPUiogUHJvY2VzcwppbmZvcm1hdGlvbjogcHJvY2VzcyBYb3JnIHBpZCA5MTggdGhyZWFk
IFhvcmc6Y3MwIHBpZCA5MTkKWyAgMjEyLjAzMDI3Nl0gYW1kZ3B1IDAwMDA6MDM6MDAuMDogYW1k
Z3B1OiBHUFUgcmVzZXQgYmVnaW4hClsgIDIxNi4wMzAyODZdIGFtZGdwdSAwMDAwOjAzOjAwLjA6
IGFtZGdwdTogZmFpbGVkIHRvIHN1c3BlbmQgZGlzcGxheSBhdWRpbwpbICAyMjcuMzk2NTkzXSBh
cHBsZXNtYzogZHJpdmVyIGluaXQgZmFpbGVkIChyZXQ9LTUpIQoKSG93IGRvIEkgZGVidWcgdGhp
cyBmdXJ0aGVyPwoKQmVzdCByZWdhcmRzLApUb21hc3ogTW/FhApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
