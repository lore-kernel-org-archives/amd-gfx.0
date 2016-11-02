From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Fwd: [PATCH libdrm] xf86drm: Parse the separate files to retrieve the
 vendor/device info
Date: Wed, 2 Nov 2016 12:07:20 +0900
Message-ID: <071ab37d-9897-760f-5a63-5f5ede867bd3@daenzer.net>
References: <20161101181334.8225-1-emil.l.velikov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------F59B51A1BBBB39BACCE76362"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161101181334.8225-1-emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--------------F59B51A1BBBB39BACCE76362
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


The first attached patch will result in drmParsePciDeviceInfo always
reporting revision 0 on kernels without the second attached patch. Will
that be an issue for the amdgpu-pro stack?

Please follow up directly to the patch e-mails with any comments on the
patches.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------F59B51A1BBBB39BACCE76362
Content-Type: message/rfc822;
 name="[PATCH] PCI: create revision file in sysfs.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="[PATCH] PCI: create revision file in sysfs.eml"

Return-Path: <dri-devel-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Delivered-To: michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org
Received: from mx2.mailbox.org ([80.241.60.215])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	by dobby7.mgmt.heinlein-hosting.de (Dovecot) with LMTP id 4qqzFPm3GFgUugAAGHKPgg
	for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>; Tue, 01 Nov 2016 16:42:50 +0100
Received: from hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172])
	by mx2.mailbox.org (Postfix) with ESMTP id D7A7A434F7
	for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>; Tue,  1 Nov 2016 16:42:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Authentication-Results: hefe.heinlein-support.de (amavisd-new);
	dkim=fail (2048-bit key) reason="fail (message has been altered)"
	header.d=gmail.com
Received: from mx2.mailbox.org ([80.241.60.215])
	by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.170]) (amavisd-new, port 10024)
	with ESMTP id l7tvDKpdByRn for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>;
	Tue,  1 Nov 2016 16:42:46 +0100 (CET)
X-policyd-weight: using cached result; rate: -2.5
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
	by mx2.mailbox.org (Postfix) with ESMTP
	for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>; Tue,  1 Nov 2016 16:42:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by netline-mail3.netline.ch (Postfix) with ESMTP id 7FC4720207D
	for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>; Tue,  1 Nov 2016 16:42:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
	by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id APIGUX2duTzf for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>;
	Tue,  1 Nov 2016 16:42:46 +0100 (CET)
X-SMTP-Auth: no
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	by netline-mail3.netline.ch (Postfix) with ESMTPS id AF5CB202048
	for <michel-otUistvHUpPR7s880joybQ@public.gmane.org>; Tue,  1 Nov 2016 16:42:45 +0100 (CET)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E4FE89650;
	Tue,  1 Nov 2016 15:42:43 +0000 (UTC)
X-Original-To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Delivered-To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E3C89650
 for <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Tue,  1 Nov 2016 15:42:42 +0000 (UTC)
Received: by mail-wm0-x241.google.com with SMTP id c17so23199026wmc.3
 for <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Tue, 01 Nov 2016 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ni4MMw7ocC1Y7s35uCkUfL+NYLt8lDUOyqaCICpuEJY=;
 b=GJ2n8k/9G7+/3o0Wz/Q38+wkzQWHYBqM8cKnoqxk4cxsHi4QV8okqq8P8rCoTiBJky
 GOf5MQOvi5KoqmXP59Y5nlDDvj7t08cD3La0a1uvv2H0teenQm5OkIyxXxtIaQAQpN3a
 yxp69el4jYIyqJF6rBg37RqJHhDyNE4Nr/iLJ+2VI7Mj0A0iQLlY9RQbFO7BHgZ/AwO1
 iXXPlyGFUnjt5S0W8b883fvB61LJqvWmcRUjGoLffYNTZi/8jwdhblpHCAnVSnPXLk0+
 OKLqqd3qy55T1+yEPD2ncuf54IYPjiqHF8VGVmf12roRY81g25bLU6gCH7ZG9u9eTLnT
 KGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20130820;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ni4MMw7ocC1Y7s35uCkUfL+NYLt8lDUOyqaCICpuEJY=;
 b=iF1i/qlk1aN7c7m3VHTG/9OfSneHTg9C8bZ1Q5HMd54BaTldzlIOUjAg2jmymi4Xhe
 nCYOS9HYX4NhO2baVlk48iO6ecGaYxvWgTTOEUnDYtSrgO5HavdbSXnsWrR4MAmXOC/w
 sOL67JT6OhU+AtOKwiUafqt/rGS2pXbKAGOknisTUYSTjd6pCBhdfbfNbXr2LnqmDzkN
 LIUSPvg/orK/dk+ZdwSPqpaV9p/2XFEvgTTdGFp6PuqXvGW4yiz/0zQxL1liX20/RL/L
 9HXWxHkkw2XfAtxQihSYFVpvV/QKLo7StkWo6iAtTqdMF4VMjbuIfz+b8npXuukhu8Bh
 Slsw==
X-Gm-Message-State: ABUngvfWPlw1dN3ktJ5SlHz2/Sn1h9w5Sfjm06DG5vHrN4eFC8RuRgOxNFIuxpgDhmGWjw==
X-Received: by 10.28.111.71 with SMTP id k68mr2007016wmc.109.1478014960905;
 Tue, 01 Nov 2016 08:42:40 -0700 (PDT)
Received: from arch-x220.cbg.collabora.co.uk
 ([2a00:1098:5:0:120b:a9ff:fe8d:c914])
 by smtp.gmail.com with ESMTPSA id a1sm36283640wjl.28.2016.11.01.08.42.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Nov 2016 08:42:40 -0700 (PDT)
From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH] PCI: create revision file in sysfs
Date: Tue,  1 Nov 2016 15:42:32 +0000
Message-Id: <20161101154232.6451-1-emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Cc: Jammy Zhou <Jammy.Zhou-5C7GfCeVMHo@public.gmane.org>, emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer-5C7GfCeVMHo@public.gmane.org>,
 linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
X-BeenThere: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
X-Mailman-Version: 2.1.18
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:dri-devel-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: dri-devel-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "dri-devel" <dri-devel-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

RnJvbTogRW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KCkN1cnJlbnRs
eSB0aGUgcmV2aXNpb24gaXNuJ3QgYXZhaWxhYmxlIHZpYSBzeXNmcy9saWJ1ZGV2IHRodXMgaWYg
b25lCndhbnRzIHRvIGtub3cgdGhlIHZhbHVlIHRoZXkgbmVlZCB0byByZWFkIHRocm91Z2ggdGhl
IGNvbmZpZyBmaWxlLgoKVGhpcyBpbiBpdHNlbGYgd2FrZXMvcG93ZXJzIHVwIHRoZSBkZXZpY2Us
IGNhdXNpbmcgdW53YW50ZWQgZGVsYXkKc2luY2UgaXQgY2FuIGJlIHF1aXRlIGNvc3RseS4KCkV4
cG9zZSB0aGUgcmV2aXNpb24gYXMgYSBzZXBhcmF0ZSBmaWxlLCBqdXN0IGxpa2Ugd2UgZG8gZm9y
IHRoZSBkZXZpY2UsCnZlbmRvciwgdGhlaXIgc3Vic3lzdGVtIHZlcnNpb24gYW5kIGNsYXNzLgoK
Q2M6IEphbW15IFpob3UgPEphbW15Llpob3VAYW1kLmNvbT4KQ2M6IE1pY2hlbCBEw6RuemVyIDxt
aWNoZWwuZGFlbnplckBhbWQuY29tPgpDYzogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xl
LmNvbT4KQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogRW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29s
bGFib3JhLmNvbT4KLS0tCkdlbnRzLCBJJ20gbm90IHN1YnNjcmliZWQgdG8gdGhlIG1haWxpbmcg
bGlzdCBzbyBwbGVhc2Uga2VlcCBtZSBpbiB0aGUKQ0MgY2hhaW4uCgpUaGFua3MKRW1pbAotLS0K
IGRyaXZlcnMvcGNpL3BjaS1zeXNmcy5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaS1zeXNmcy5jIGIvZHJpdmVycy9w
Y2kvcGNpLXN5c2ZzLmMKaW5kZXggYmNkMTBjNy4uMDY2NjI4NyAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9wY2kvcGNpLXN5c2ZzLmMKKysrIGIvZHJpdmVycy9wY2kvcGNpLXN5c2ZzLmMKQEAgLTUwLDYg
KzUwLDcgQEAgcGNpX2NvbmZpZ19hdHRyKHZlbmRvciwgIjB4JTA0eFxuIik7CiBwY2lfY29uZmln
X2F0dHIoZGV2aWNlLCAiMHglMDR4XG4iKTsKIHBjaV9jb25maWdfYXR0cihzdWJzeXN0ZW1fdmVu
ZG9yLCAiMHglMDR4XG4iKTsKIHBjaV9jb25maWdfYXR0cihzdWJzeXN0ZW1fZGV2aWNlLCAiMHgl
MDR4XG4iKTsKK3BjaV9jb25maWdfYXR0cihyZXZpc2lvbiwgIjB4JTAyeFxuIik7CiBwY2lfY29u
ZmlnX2F0dHIoY2xhc3MsICIweCUwNnhcbiIpOwogcGNpX2NvbmZpZ19hdHRyKGlycSwgIiV1XG4i
KTsKIApAQCAtNTY4LDYgKzU2OSw3IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpwY2lfZGV2
X2F0dHJzW10gPSB7CiAJJmRldl9hdHRyX2RldmljZS5hdHRyLAogCSZkZXZfYXR0cl9zdWJzeXN0
ZW1fdmVuZG9yLmF0dHIsCiAJJmRldl9hdHRyX3N1YnN5c3RlbV9kZXZpY2UuYXR0ciwKKwkmZGV2
X2F0dHJfcmV2aXNpb24uYXR0ciwKIAkmZGV2X2F0dHJfY2xhc3MuYXR0ciwKIAkmZGV2X2F0dHJf
aXJxLmF0dHIsCiAJJmRldl9hdHRyX2xvY2FsX2NwdXMuYXR0ciwKLS0gCjIuOS4zCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--------------F59B51A1BBBB39BACCE76362
Content-Type: message/rfc822;
 name="[PATCH libdrm] xf86drm: Parse the separate files to retrieve the
 vendor/device info.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="[PATCH libdrm] xf86drm: Parse the separate files to retrieve";
 filename*1=" the vendor/device info.eml"

Return-Path: <dri-devel-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Delivered-To: michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org
Received: from mx2.mailbox.org ([80.241.60.215])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	by dobby7.mgmt.heinlein-hosting.de (Dovecot) with LMTP id aFgqBLzdGFgqLwAAGHKPgg
	for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>; Tue, 01 Nov 2016 19:23:56 +0100
Received: from hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172])
	by mx2.mailbox.org (Postfix) with ESMTP id 5615E435AC
	for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>; Tue,  1 Nov 2016 19:23:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Authentication-Results: hefe.heinlein-support.de (amavisd-new);
	dkim=fail (2048-bit key) reason="fail (message has been altered)"
	header.d=gmail.com
Received: from mx2.mailbox.org ([80.241.60.215])
	by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.170]) (amavisd-new, port 10024)
	with ESMTP id Fbo-yPBcXXe6 for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>;
	Tue,  1 Nov 2016 19:23:54 +0100 (CET)
X-policyd-weight: using cached result; rate: -2.5
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
	by mx2.mailbox.org (Postfix) with ESMTP
	for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>; Tue,  1 Nov 2016 19:23:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by netline-mail3.netline.ch (Postfix) with ESMTP id 3F22820207D
	for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>; Tue,  1 Nov 2016 19:23:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
	by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WVBIF5tUPQXD for <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>;
	Tue,  1 Nov 2016 19:23:53 +0100 (CET)
X-SMTP-Auth: no
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	by netline-mail3.netline.ch (Postfix) with ESMTPS id 6C68B202048
	for <michel-otUistvHUpPR7s880joybQ@public.gmane.org>; Tue,  1 Nov 2016 19:23:53 +0100 (CET)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0A186E280;
	Tue,  1 Nov 2016 18:23:51 +0000 (UTC)
X-Original-To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Delivered-To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D6296E280
 for <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Tue,  1 Nov 2016 18:23:50 +0000 (UTC)
Received: by mail-wm0-x244.google.com with SMTP id c17so23782793wmc.3
 for <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Tue, 01 Nov 2016 11:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zElvrVXA3O72v7sOGJHXS9s5PQWrKRPirvC122nfuiE=;
 b=lf3NGpbAJhidTLm+qu1epg5zIB/Hr8TONEFAqGlpyNk9gwiWUiYyX8wTHzYb1HAVAN
 CI4SnO1psHsdbNZVi0/e3pmFSKkGpS3y2skO0pMQH02rLxX+XhQ9OXqte6uHsQmzVkvp
 6/lK1Ehmwyek4vHFghe0kbMDDkkt9lO/wGkEqZkFN+dlELUHADdXYZkk45jl88DmuSOE
 AsjaYD+Y8w6omvHf9PSPLGQ3CmXX4rpvyypRINx8FzI5Z5Q6IRB0JxinGhNBxf9CliHV
 esHFPU6N59VSei4WGoMeuemqJEyAE6sAokRafjSs2sHq11MnWhRd1J4S21l6b/7HK9jJ
 oOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20130820;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zElvrVXA3O72v7sOGJHXS9s5PQWrKRPirvC122nfuiE=;
 b=V3vZMNiR7zoZf8HTRnrgwykksB5SKlHhOsQzCLyDNnMQKXwRTCu0GOXVWvw/3qpjdH
 gRLaN/FKJSxK9qDIj4Vf24lVBBgYV+xsLmz8b+wQQY7hO61i2Yd8uOnc4ODxBXyODqGB
 L22IRTbK7CmVyJ5NbUmaCaudb0eNkyC3dpqKuvzJG2vMetm1AwFGM3dSmPGoB9MewGQG
 hV100D5u/5Qio/Alupxdq/qMJ1OYtFQj0/eMZuVhD6mTgMjf7WXUDWrGJoBjlwxzbzQL
 M5rbVkUYM3Q35ilHxvPzVrj0Cch1gW4C+MtImmv4Pb2IvAj2P7F8KcVuz5lZ5z+LBQJv
 R49g==
X-Gm-Message-State: ABUngveFNfDOlwZoOM2L1u6C2l8YhzJqIWyOtkJT3hVum2INPdsm2ommZzK3b1pwhaH7og==
X-Received: by 10.194.243.167 with SMTP id wz7mr211704wjc.65.1478024629102;
 Tue, 01 Nov 2016 11:23:49 -0700 (PDT)
Received: from arch-x1c3.cbg.collabora.co.uk
 ([2a00:1098:5:0:9665:9cff:feee:aa4d])
 by smtp.gmail.com with ESMTPSA id io3sm36984657wjb.24.2016.11.01.11.23.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Nov 2016 11:23:48 -0700 (PDT)
From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH libdrm] xf86drm: Parse the separate files to retrieve the
 vendor/device info
Date: Tue,  1 Nov 2016 18:13:34 +0000
Message-Id: <20161101181334.8225-1-emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-Mailer: git-send-email 2.10.0
MIME-Version: 1.0
Cc: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer-5C7GfCeVMHo@public.gmane.org>,
 emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Mauro Santos <registo.mailling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-BeenThere: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
X-Mailman-Version: 2.1.18
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:dri-devel-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: dri-devel-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "dri-devel" <dri-devel-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

RnJvbTogRW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KClBhcnNpbmcg
Y29uZmlnIHN5c2ZzIGZpbGUgd2FrZXMgdXAgdGhlIGRldmljZS4gVGhlIGxhdHRlciBvZiB3aGlj
aCBtYXkKYmUgc2xvdyBhbmQgaXNuJ3QgcmVxdWlyZWQgdG8gYmVnaW4gd2l0aC4KClJlYWRpbmcg
dGhyb3VnaCBjb25maWcgaXMvd2FzIHJlcXVpcmVkIHNpbmNlIHRoZSByZXZpc2lvbiBpcyBub3QK
YXZhaWxhYmxlIGJ5IG90aGVyIG1lYW5zLCBhbHRob3VnaCB3aXRoIGEga2VybmVsIHBhdGNoIGlu
IHRoZSB3YXkgd2UgY2FuCidjaGVhdCcgdGVtcG9yYXJpbHkuCgpUaGF0IHNob3VsZCBiZSBmaW5l
LCBzaW5jZSBubyBvcGVuLXNvdXJjZSBwcm9qZWN0IGhhcyBldmVyIHVzZWQgdGhlCnZhbHVlLgoK
Q2M6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgpDYzogTWF1cm8gU2Fu
dG9zIDxyZWdpc3RvLm1haWxsaW5nQGdtYWlsLmNvbT4KQnVnemlsbGE6IGh0dHBzOi8vYnVncy5m
cmVlZGVza3RvcC5vcmcvc2hvd19idWcuY2dpP2lkPTk4NTAyClNpZ25lZC1vZmYtYnk6IEVtaWwg
VmVsaWtvdiA8ZW1pbC52ZWxpa292QGNvbGxhYm9yYS5jb20+Ci0tLQpNYXVybyBjYW4geW91IGFw
cGx5IHRoaXMgYWdhaW5zdCBsaWJkcm0gYW5kIHJlYnVpbGQgaXQuIFlvdSBkbyBfbm90XwpuZWVk
IHRvIHJlYnVpbGQgbWVzYSBhZnRlcndvcmRzLgoKVGhhbmtzCi0tLQogeGY4NmRybS5jIHwgNTAg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS94Zjg2ZHJtLmMgYi94Zjg2ZHJtLmMKaW5kZXggNTJhZGQ1ZS4uNWE1MTAwYyAxMDA2NDQKLS0t
IGEveGY4NmRybS5jCisrKyBiL3hmODZkcm0uYwpAQCAtMjk1MCwyNSArMjk1MCw0NSBAQCBzdGF0
aWMgaW50IGRybVBhcnNlUGNpRGV2aWNlSW5mbyhjb25zdCBjaGFyICpkX25hbWUsCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBkcm1QY2lEZXZpY2VJbmZvUHRyIGRldmljZSkKIHsK
ICNpZmRlZiBfX2xpbnV4X18KKyNkZWZpbmUgQVJSQVlfU0laRShhKSAoc2l6ZW9mKGEpIC8gc2l6
ZW9mKChhKVswXSkpCisgICAgc3RhdGljIGNvbnN0IGNoYXIgKmF0dHJzW10gPSB7CisgICAgICAi
cmV2aXNpb24iLCAvKiBYWFg6IG1ha2Ugc3VyZSBpdCdzIGFsd2F5cyBmaXJzdCwgc2VlIG5vdGUg
YmVsb3cgKi8KKyAgICAgICJ2ZW5kb3IiLAorICAgICAgImRldmljZSIsCisgICAgICAic3Vic3lz
dGVtX3ZlbmRvciIsCisgICAgICAic3Vic3lzdGVtX2RldmljZSIsCisgICAgfTsKICAgICBjaGFy
IHBhdGhbUEFUSF9NQVggKyAxXTsKLSAgICB1bnNpZ25lZCBjaGFyIGNvbmZpZ1s2NF07Ci0gICAg
aW50IGZkLCByZXQ7CisgICAgdW5zaWduZWQgaW50IGRhdGFbQVJSQVlfU0laRShhdHRycyldOwor
ICAgIEZJTEUgKmZwOworICAgIGludCByZXQ7CiAKLSAgICBzbnByaW50ZihwYXRoLCBQQVRIX01B
WCwgIi9zeXMvY2xhc3MvZHJtLyVzL2RldmljZS9jb25maWciLCBkX25hbWUpOwotICAgIGZkID0g
b3BlbihwYXRoLCBPX1JET05MWSk7Ci0gICAgaWYgKGZkIDwgMCkKLSAgICAgICAgcmV0dXJuIC1l
cnJubzsKKyAgICBmb3IgKHVuc2lnbmVkIGkgPSAwOyBpIDwgQVJSQVlfU0laRShhdHRycyk7IGkr
KykgeworICAgICAgICBzbnByaW50ZihwYXRoLCBQQVRIX01BWCwgIi9zeXMvY2xhc3MvZHJtLyVz
L2RldmljZS8lcyIsCisgICAgICAgICAgICAgICAgIGRfbmFtZSwgYXR0cnNbaV0pOworICAgICAg
ICBmcCA9IGZvcGVuKHBhdGgsICJyIik7CisgICAgICAgIGlmICghZnApIHsKKyAgICAgICAgICAg
IC8qIE5vdGU6IEZpcnN0IHdlIGNoZWNrIHRoZSByZXZpc2lvbiwgc2luY2Ugb2xkZXIga2VybmVs
cworICAgICAgICAgICAgICogbWF5IG5vdCBoYXZlIGl0LiBEZWZhdWx0IHRvIHplcm8gaW4gc3Vj
aCBjYXNlcy4gKi8KKyAgICAgICAgICAgIGlmIChpID09IDApIHsKKyAgICAgICAgICAgICAgICBk
YXRhW2ldID0gMDsKKyAgICAgICAgICAgICAgICBjb250aW51ZTsKKyAgICAgICAgICAgIH0KKyAg
ICAgICAgICAgIHJldHVybiAtZXJybm87CisgICAgICAgIH0KIAotICAgIHJldCA9IHJlYWQoZmQs
IGNvbmZpZywgc2l6ZW9mKGNvbmZpZykpOwotICAgIGNsb3NlKGZkKTsKLSAgICBpZiAocmV0IDwg
MCkKLSAgICAgICAgcmV0dXJuIC1lcnJubzsKKyAgICAgICAgcmV0ID0gZnNjYW5mKGZwLCAiJXgi
LCAmZGF0YVtpXSk7CisgICAgICAgIGZjbG9zZShmcCk7CisgICAgICAgIGlmIChyZXQgIT0gMSkK
KyAgICAgICAgICAgIHJldHVybiAtZXJybm87CisKKyAgICB9CiAKLSAgICBkZXZpY2UtPnZlbmRv
cl9pZCA9IGNvbmZpZ1swXSB8IChjb25maWdbMV0gPDwgOCk7Ci0gICAgZGV2aWNlLT5kZXZpY2Vf
aWQgPSBjb25maWdbMl0gfCAoY29uZmlnWzNdIDw8IDgpOwotICAgIGRldmljZS0+cmV2aXNpb25f
aWQgPSBjb25maWdbOF07Ci0gICAgZGV2aWNlLT5zdWJ2ZW5kb3JfaWQgPSBjb25maWdbNDRdIHwg
KGNvbmZpZ1s0NV0gPDwgOCk7Ci0gICAgZGV2aWNlLT5zdWJkZXZpY2VfaWQgPSBjb25maWdbNDZd
IHwgKGNvbmZpZ1s0N10gPDwgOCk7CisgICAgZGV2aWNlLT5yZXZpc2lvbl9pZCA9IGRhdGFbMF0g
JiAweGZmOworICAgIGRldmljZS0+dmVuZG9yX2lkID0gZGF0YVsxXSAmIDB4ZmZmZjsKKyAgICBk
ZXZpY2UtPmRldmljZV9pZCA9IGRhdGFbMl0gJiAweGZmZmY7CisgICAgZGV2aWNlLT5zdWJ2ZW5k
b3JfaWQgPSBkYXRhWzNdICYgMHhmZmZmOworICAgIGRldmljZS0+c3ViZGV2aWNlX2lkID0gZGF0
YVs0XSAmIDB4ZmZmZjsKIAogICAgIHJldHVybiAwOwogI2Vsc2UKLS0gCjIuMTAuMAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxp
bmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--------------F59B51A1BBBB39BACCE76362
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------F59B51A1BBBB39BACCE76362--
