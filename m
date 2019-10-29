Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8975CA9EAE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 17:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97EF8205C9
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 17:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EF8205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F13A6E49A;
	Tue, 29 Oct 2019 17:52:04 +0000 (UTC)
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78A4D6E49A;
 Tue, 29 Oct 2019 17:52:03 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9THmxsn162116;
 Tue, 29 Oct 2019 17:51:59 GMT
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2vvdjub3nx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Oct 2019 17:51:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9THmTcB178984;
 Tue, 29 Oct 2019 17:51:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2vxpgfcfxt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Oct 2019 17:51:58 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9THpu8D019070;
 Tue, 29 Oct 2019 17:51:57 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 29 Oct 2019 10:51:56 -0700
Date: Tue, 29 Oct 2019 20:51:48 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: Re: [PATCH] drm/sched:  Fix passing zero to 'PTR_ERR' warning
Message-ID: <20191029175148.GA3866@kadam>
References: <1572361484-9828-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1572361484-9828-1-git-send-email-andrey.grodzovsky@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290159
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=mAOkhdSS8tQnMlVJEVG5u1xAFBLhN8dMvPlB1LiA4Z8=;
 b=j8wFBTE8aRvoX3NxgIGGFkj+NUJdXnxwxTdIH51zNnEqDJ8jdH+bIUrV+uxy31AQgvdK
 jhYWbXfqoc5GqxCMYe28Po5gd0twu9xXr8J4/6lkWjaPgjJshyRsw/JfQ1RPgndkq83Z
 d0HIwAiY4KXemF+i92MpdwRDv9ZO+K1HNmLSbh9N7UlXKD6BAo0igBLi7rKarKpoOgPW
 RKhW8PIM7ZL1DAIxDMH1J871VEs3QUIiHxKTP1d2z24UOAqCylj/YeHnOmbnFL40LwQH
 dcduk8Dil2xXYFRTBwpOiMIWRRvvlMyNBG2gev84NXReL4LATmyoPO0Uzgr1h93EUqKT 2g== 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029175148.J582J2Md5dOE273Nv4A3irpvqUZcLASbMib4ZS8Uj-Q@z>

T24gVHVlLCBPY3QgMjksIDIwMTkgYXQgMTE6MDQ6NDRBTSAtMDQwMCwgQW5kcmV5IEdyb2R6b3Zz
a3kgd3JvdGU6Cj4gRml4IGEgc3RhdGljIGNvZGUgY2hlY2tlciB3YXJuaW5nLgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpvdnNreUBhbWQuY29tPgo+
IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYyB8IDQgKystLQo+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYyBiL2RyaXZl
cnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4gaW5kZXggZjM5Yjk3ZS4uODk4YjBj
OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4gQEAgLTQ5Nyw3
ICs0OTcsNyBAQCB2b2lkIGRybV9zY2hlZF9yZXN1Ym1pdF9qb2JzKHN0cnVjdCBkcm1fZ3B1X3Nj
aGVkdWxlciAqc2NoZWQpCj4gIAo+ICAJCWlmIChJU19FUlJfT1JfTlVMTChmZW5jZSkpIHsKPiAg
CQkJc19qb2ItPnNfZmVuY2UtPnBhcmVudCA9IE5VTEw7Cj4gLQkJCWRtYV9mZW5jZV9zZXRfZXJy
b3IoJnNfZmVuY2UtPmZpbmlzaGVkLCBQVFJfRVJSKGZlbmNlKSk7Cj4gKwkJCWRtYV9mZW5jZV9z
ZXRfZXJyb3IoJnNfZmVuY2UtPmZpbmlzaGVkLCBQVFJfRVJSX09SX1pFUk8oZmVuY2UpKTsKClRo
aXMgd2lsbCBzaWxlbmNlIHRoZSBzdGF0aWMgY2hlY2tlciB3YXJuaW5nLCBidXQgaXQgd2lsbCBz
dGlsbCB0cmlnZ2VyCmEgV0FSTl9PTigpLiAgQW5kIGl0IHNvcnQgb2YgaGFzIGluc3BpcmVkIG1l
IHRvIGdlbmVyYXRlIGEgbmV3IHdhcm5pbmcKYmVjYXVzZSB0aGF0J3Mgbm90IGhvdyBQVFJfRVJS
X09SX1pFUk8oKSBpcyBzdXBwb3NlZCB0byBiZSB1c2VkLiAgOlAKClBUUl9FUlJfT1JfWkVSTygp
IGlzIHNob3J0IGhhbmQgZm9yIHRoaXMgc2l0dWF0aW9uOgoKLQlpZiAoSVNfRVJSKGZlbmNlKSkK
LQkJcmV0dXJuIFBUUl9FUlIoZmVuY2UpOwotCXJldHVybiAwOworCXJldHVybiBQVFJfRVJSX09S
X1pFUk8oZmVuY2UpOwoKcmVnYXJkcywKZGFuIGNhcnBlbnRlcgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
