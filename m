Return-Path: <SRS0=jMTE=63=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0025C2D110
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 13:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6996F207BA
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 13:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="D61Ngs7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6996F207BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 743216EA50;
	Wed, 13 May 2020 13:33:25 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87D566EA49
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2020 13:33:13 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200513133312euoutp019887fdc58ea0cdac6e9514ed39b9629b~OmcV-O-4u2196321963euoutp01n
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2020 13:33:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200513133312euoutp019887fdc58ea0cdac6e9514ed39b9629b~OmcV-O-4u2196321963euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1589376792;
 bh=25k9eKiRX3J34TeqF/vBEPAfhsULwcRZAJqITrVJfzw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D61Ngs7VNNxJEtr8uXQMU2SX8trzwtkN5KpJJGU40xoMzU/q1+sVVsxPPt9QxvCXW
 R5NK3k70mlLugnUbVEt4UNXJw4hBNfj4+nMsRqc0npQzpmLpFHZaoVnulKLqK29u3K
 4CFYjyH4PvvaUNiZo3WIJ44ON24+MOh4xGeSDNbM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200513133311eucas1p1b5912233949edfc862c9bf62174d30b5~OmcVtYY1N2350623506eucas1p1N;
 Wed, 13 May 2020 13:33:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id E9.D8.60698.717FBBE5; Wed, 13
 May 2020 14:33:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200513133311eucas1p261d84f947b03e4fc733137048aab55fb~OmcVSC_Vt1009610096eucas1p2D;
 Wed, 13 May 2020 13:33:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200513133311eusmtrp1cbc89a111ded0b5b1626fb75b1957bba~OmcVRGpG61011910119eusmtrp1S;
 Wed, 13 May 2020 13:33:11 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-dc-5ebbf7178c56
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 5F.37.07950.717FBBE5; Wed, 13
 May 2020 14:33:11 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200513133310eusmtip15a961a7c1de5f2c3e3944c8c366b7dfe~OmcUlWgKD3222032220eusmtip18;
 Wed, 13 May 2020 13:33:10 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 20/38] drm: radeon: fix common struct sg_table related
 issues
Date: Wed, 13 May 2020 15:32:27 +0200
Message-Id: <20200513133245.6408-20-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513133245.6408-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURTN60ynQ6FkKJg+0YjWqIFEoAGTSVii0Y8xUYPKl4lghbGgtJCW
 RYxRVjUVDNKwFRcgbLJVAStS2ZrKGvbVCJZNjQ0EDZsYBFtGkb9zzj0n592bhyN8I9sRD5VF
 0nKZOEyIcVFt61rPUcGqLsB9XXOETO3pYJGZ4zo2WaSJ55CvsjVsct5oppvaxwg5tLyAkS/K
 37PIvCYvcmloikVWz4ywycH6JxhZaZjgkC3fZ9nHbankgd8YVfGsAlANK3ko9WZlkk0ZH7ax
 qJrCu9THjRmEUo2VAEr3IQ6jHtWWAWqxep+f9SWudzAdFhpNy918r3BD8rtK0YhZwc3ujW5O
 HNi0VwIch4QnNGS4KAEX5xOlAGZNKzGGLAE4MfMWZcgigEu5k0AJrLYSVZmdHGZQAuBA+3Ow
 HVHFazGLCyNEUDmv3MIORDKA7ak2FhNCFCKwcLwRtQzsiQswM62PZcEocQiOdFdyLJhH+MCE
 bgPK1DnB8pfNiAVbmXXTeBPKeOxgR87sFkbMnsTXuYilABJrHKiqa8CY8ClYq/7KZrA9NLXV
 chi8F3apUlAmkAjgVE8lhyEpAA4mZP/d1AuO9/zCLHdCCGeoqXdj5BNwtTgfMOezhWPzdswj
 bGG6NgthZB58cI/PuA9DdVvVdm1L3wDCYAoO9yZhaeCAesc66h3rqP/35gGkDAjoKIVUQis8
 ZHSMq0IsVUTJJK5B4dJqYP52XRtty3Wgcf2qHhA4ENrwJkd1AXy2OFoRK9UDiCNCB945jVni
 BYtjb9Hy8EB5VBit0IM9OCoU8DwKvl3mExJxJH2DpiNo+b8pC7dyjAP4Hb0/uOjqcubpbtHp
 8oikH6kiI7fgZP6gYU5lss/xkfjEzRmy/Kz51wP3/2zNKP0S1J88Wpz6CZcFDDXjcwd8vfu1
 AeBYnqlJqIt1918uHO28b7wWuCs3o6J32LmoRrhwcFJXILgdNi01cT1bEjucYs72f06Xqdzf
 8XvheZEQVYSIRS6IXCH+AzVrLwJyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7ri33fHGXyfxWvRe+4kk8W0O7tZ
 LZaub2S32DhjPavF2/tA7v9tE5ktrnx9z2axcvVRJosF+60tvlx5yGSx6fE1VovLu+awWaw9
 cpfd4uCHJ6wOfB6tl/6yeayZt4bRY++3BSwe2789YPW4332cyWPzknqP2/8eM3tMvrGc0WP3
 zQY2j74tqxg9Pm+SC+CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJ
 Sc3JLEst0rdL0MtYeHoFS8ET8Yqz/86yNzD+F+5i5OSQEDCRWDftFDuILSSwlFFi/UxfiLiM
 xMlpDawQtrDEn2tdbF2MXEA1nxglTjRdYwNJsAkYSnS9hUiICHQySkzr/sgO4jALrGGWuPd9
 OdhYYYEAiT27roLZLAKqEtfOrgWzeQVsJZrOHmGBWCEvsXrDAWYQmxMo/urOfhaIk/Il9i7e
 xwZRLyhxcuYToDgH0AJ1ifXzhEDCzECtzVtnM09gFJyFpGoWQtUsJFULGJlXMYqklhbnpucW
 G+kVJ+YWl+al6yXn525iBEbwtmM/t+xg7HoXfIhRgINRiYfX4tbuOCHWxLLiytxDjBIczEoi
 vH7rgUK8KYmVValF+fFFpTmpxYcYTYFem8gsJZqcD0wueSXxhqaG5haWhubG5sZmFkrivB0C
 B2OEBNITS1KzU1MLUotg+pg4OKUaGJ0aNndxn3w6fe+Ma8ccraL2z7mWFOfQr3pjn7tT5a9o
 FR/hNe/srzRKTWd/+iD3xbrvbxzC2TcHcn0uDrm1XT7xLIPnbpO/f7d4poec35XUnsKVYhl4
 +Ovi5uvrJgZuDygQErtf6dLiyMaa1fDF4qDM/B/FG5d/S00NzPs+r/j2mQ6VHT18okosxRmJ
 hlrMRcWJAP1Nkov2AgAA
X-CMS-MailID: 20200513133311eucas1p261d84f947b03e4fc733137048aab55fb
X-Msg-Generator: CA
X-RootMTR: 20200513133311eucas1p261d84f947b03e4fc733137048aab55fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200513133311eucas1p261d84f947b03e4fc733137048aab55fb
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133311eucas1p261d84f947b03e4fc733137048aab55fb@eucas1p2.samsung.com>
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
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIERvY3VtZW50YXRpb24vRE1BLUFQSS1IT1dUTy50eHQgc3RhdGVzIHRoYXQgdGhlIGRtYV9t
YXBfc2coKSBmdW5jdGlvbgpyZXR1cm5zIHRoZSBudW1iZXIgb2YgdGhlIGNyZWF0ZWQgZW50cmll
cyBpbiB0aGUgRE1BIGFkZHJlc3Mgc3BhY2UuCkhvd2V2ZXIgdGhlIHN1YnNlcXVlbnQgY2FsbHMg
dG8gdGhlIGRtYV9zeW5jX3NnX2Zvcl97ZGV2aWNlLGNwdX0oKSBhbmQKZG1hX3VubWFwX3NnIG11
c3QgYmUgY2FsbGVkIHdpdGggdGhlIG9yaWdpbmFsIG51bWJlciBvZiB0aGUgZW50cmllcwpwYXNz
ZWQgdG8gdGhlIGRtYV9tYXBfc2coKS4KCnN0cnVjdCBzZ190YWJsZSBpcyBhIGNvbW1vbiBzdHJ1
Y3R1cmUgdXNlZCBmb3IgZGVzY3JpYmluZyBhIG5vbi1jb250aWd1b3VzCm1lbW9yeSBidWZmZXIs
IHVzZWQgY29tbW9ubHkgaW4gdGhlIERSTSBhbmQgZ3JhcGhpY3Mgc3Vic3lzdGVtcy4gSXQKY29u
c2lzdHMgb2YgYSBzY2F0dGVybGlzdCB3aXRoIG1lbW9yeSBwYWdlcyBhbmQgRE1BIGFkZHJlc3Nl
cyAoc2dsIGVudHJ5KSwKYXMgd2VsbCBhcyB0aGUgbnVtYmVyIG9mIHNjYXR0ZXJsaXN0IGVudHJp
ZXM6IENQVSBwYWdlcyAob3JpZ19uZW50cyBlbnRyeSkKYW5kIERNQSBtYXBwZWQgcGFnZXMgKG5l
bnRzIGVudHJ5KS4KCkl0IHR1cm5lZCBvdXQgdGhhdCBpdCB3YXMgYSBjb21tb24gbWlzdGFrZSB0
byBtaXN1c2UgbmVudHMgYW5kIG9yaWdfbmVudHMKZW50cmllcywgY2FsbGluZyBETUEtbWFwcGlu
ZyBmdW5jdGlvbnMgd2l0aCBhIHdyb25nIG51bWJlciBvZiBlbnRyaWVzIG9yCmlnbm9yaW5nIHRo
ZSBudW1iZXIgb2YgbWFwcGVkIGVudHJpZXMgcmV0dXJuZWQgYnkgdGhlIGRtYV9tYXBfc2coKQpm
dW5jdGlvbi4KClRvIGF2b2lkIHN1Y2ggaXNzdWVzLCBsZXRzIHVzZSBhIGNvbW1vbiBkbWEtbWFw
cGluZyB3cmFwcGVycyBvcGVyYXRpbmcKZGlyZWN0bHkgb24gdGhlIHN0cnVjdCBzZ190YWJsZSBv
YmplY3RzIGFuZCB1c2Ugc2NhdHRlcmxpc3QgcGFnZQppdGVyYXRvcnMgd2hlcmUgcG9zc2libGUu
IFRoaXMsIGFsbW9zdCBhbHdheXMsIGhpZGVzIHJlZmVyZW5jZXMgdG8gdGhlCm5lbnRzIGFuZCBv
cmlnX25lbnRzIGVudHJpZXMsIG1ha2luZyB0aGUgY29kZSByb2J1c3QsIGVhc2llciB0byBmb2xs
b3cKYW5kIGNvcHkvcGFzdGUgc2FmZS4KClNpZ25lZC1vZmYtYnk6IE1hcmVrIFN6eXByb3dza2kg
PG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCkZvciBtb3JlIGluZm9ybWF0aW9uLCBzZWUg
J1tQQVRDSCB2NSAwMC8zOF0gRFJNOiBmaXggc3RydWN0IHNnX3RhYmxlIG5lbnRzCnZzLiBvcmln
X25lbnRzIG1pc3VzZScgdGhyZWFkOgpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21t
dS8yMDIwMDUxMzEzMjExNC42MDQ2LTEtbS5zenlwcm93c2tpQHNhbXN1bmcuY29tL1QvCi0tLQog
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMgfCAxMSArKysrKy0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX3R0bS5jCmluZGV4IDVkNTBjOWUuLjBlM2ViMGQgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX3R0bS5jCkBAIC00ODEsNyArNDgxLDcgQEAgc3RhdGljIGludCByYWRlb25f
dHRtX3R0X3Bpbl91c2VycHRyKHN0cnVjdCB0dG1fdHQgKnR0bSkKIHsKIAlzdHJ1Y3QgcmFkZW9u
X2RldmljZSAqcmRldiA9IHJhZGVvbl9nZXRfcmRldih0dG0tPmJkZXYpOwogCXN0cnVjdCByYWRl
b25fdHRtX3R0ICpndHQgPSAodm9pZCAqKXR0bTsKLQl1bnNpZ25lZCBwaW5uZWQgPSAwLCBuZW50
czsKKwl1bnNpZ25lZCBwaW5uZWQgPSAwOwogCWludCByOwogCiAJaW50IHdyaXRlID0gIShndHQt
PnVzZXJmbGFncyAmIFJBREVPTl9HRU1fVVNFUlBUUl9SRUFET05MWSk7CkBAIC01MjEsOSArNTIx
LDggQEAgc3RhdGljIGludCByYWRlb25fdHRtX3R0X3Bpbl91c2VycHRyKHN0cnVjdCB0dG1fdHQg
KnR0bSkKIAlpZiAocikKIAkJZ290byByZWxlYXNlX3NnOwogCi0JciA9IC1FTk9NRU07Ci0JbmVu
dHMgPSBkbWFfbWFwX3NnKHJkZXYtPmRldiwgdHRtLT5zZy0+c2dsLCB0dG0tPnNnLT5uZW50cywg
ZGlyZWN0aW9uKTsKLQlpZiAobmVudHMgPT0gMCkKKwlyID0gZG1hX21hcF9zZ3RhYmxlKHJkZXYt
PmRldiwgdHRtLT5zZywgZGlyZWN0aW9uLCAwKTsKKwlpZiAocikKIAkJZ290byByZWxlYXNlX3Nn
OwogCiAJZHJtX3ByaW1lX3NnX3RvX3BhZ2VfYWRkcl9hcnJheXModHRtLT5zZywgdHRtLT5wYWdl
cywKQEAgLTU1NCw5ICs1NTMsOSBAQCBzdGF0aWMgdm9pZCByYWRlb25fdHRtX3R0X3VucGluX3Vz
ZXJwdHIoc3RydWN0IHR0bV90dCAqdHRtKQogCQlyZXR1cm47CiAKIAkvKiBmcmVlIHRoZSBzZyB0
YWJsZSBhbmQgcGFnZXMgYWdhaW4gKi8KLQlkbWFfdW5tYXBfc2cocmRldi0+ZGV2LCB0dG0tPnNn
LT5zZ2wsIHR0bS0+c2ctPm5lbnRzLCBkaXJlY3Rpb24pOworCWRtYV91bm1hcF9zZ3RhYmxlKHJk
ZXYtPmRldiwgdHRtLT5zZywgZGlyZWN0aW9uLCAwKTsKIAotCWZvcl9lYWNoX3NnX3BhZ2UodHRt
LT5zZy0+c2dsLCAmc2dfaXRlciwgdHRtLT5zZy0+bmVudHMsIDApIHsKKwlmb3JfZWFjaF9zZ3Rh
YmxlX3BhZ2UodHRtLT5zZywgJnNnX2l0ZXIsIDApIHsKIAkJc3RydWN0IHBhZ2UgKnBhZ2UgPSBz
Z19wYWdlX2l0ZXJfcGFnZSgmc2dfaXRlcik7CiAJCWlmICghKGd0dC0+dXNlcmZsYWdzICYgUkFE
RU9OX0dFTV9VU0VSUFRSX1JFQURPTkxZKSkKIAkJCXNldF9wYWdlX2RpcnR5KHBhZ2UpOwotLSAK
MS45LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
