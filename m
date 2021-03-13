Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1691C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 08:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB63464E38
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 08:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB63464E38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E411589D8A;
	Mon, 15 Mar 2021 08:04:27 +0000 (UTC)
X-Greylist: delayed 1145 seconds by postgrey-1.36 at gabe;
 Sat, 13 Mar 2021 14:07:28 UTC
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990846E0CD
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Mar 2021 14:07:28 +0000 (UTC)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12DDXxmI190261; Sat, 13 Mar 2021 08:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=Aezt22k7nI1/dEk1EZX87rLj6hGzbx2k2MzYvcp7d6E=;
 b=U6NR5DsIOySWOYxJ5kWVnhMpLY6JDrqTH78/y5DEo3KDFtLiIA9wlbaCJekJsqRfFhLy
 c+IZSahFN1vniZpFss9oKcoANj+YZuI96A1WikVa91sDhQQzUH5z6khOHkz3aPKWXRz7
 /vvUAu3qKXhdb1nWdAuvtlmEFyPzTVjS1riK1H3VDeW2X6cHoBE0kTmJ/6s+HZSRN9pk
 4SlVzZy/38/Po1tRiyiuC7nKEY3fxSZAYa9MV4PQJAMOnMHAl7BuXSPm76AinoIVvUX7
 6Zx1GJ9HYifxTz8Q2mz2cgrXjMExI7HeKZEa7wSsipCs7bVE1+/bvSBARXn/a28TVGM4 pw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 378te0byyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Mar 2021 08:48:18 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12DDmINx032872;
 Sat, 13 Mar 2021 08:48:18 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 378te0byyf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Mar 2021 08:48:18 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12DDlnqa013157;
 Sat, 13 Mar 2021 13:48:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma03ams.nl.ibm.com with ESMTP id 378n18gacm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 13 Mar 2021 13:48:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 12DDmEro22086114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 13 Mar 2021 13:48:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 294B152054;
 Sat, 13 Mar 2021 13:48:14 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.23.212])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 12E6C5204E;
 Sat, 13 Mar 2021 13:48:12 +0000 (GMT)
Date: Sat, 13 Mar 2021 15:48:11 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Message-ID: <YEzCm/Uwvw7kKpd7@linux.ibm.com>
References: <MW3PR12MB4537B49678884A1EB1F75AB5F36E9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0AE49D98-171A-42B9-9CFC-9193A9BD3346@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0AE49D98-171A-42B9-9CFC-9193A9BD3346@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-13_05:2021-03-12,
 2021-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103130104
X-Mailman-Approved-At: Mon, 15 Mar 2021 08:04:21 +0000
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
Cc: "Liang, Liang \(Leo\)" <Liang.Liang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 George Kennedy <george.kennedy@oracle.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGksCgpPbiBTYXQsIE1hciAxMywgMjAyMSBhdCAxMDowNToyM0FNICswMTAwLCBEYXZpZCBIaWxk
ZW5icmFuZCB3cm90ZToKPiA+IEFtIDEzLjAzLjIwMjEgdW0gMDU6MDQgc2NocmllYiBMaWFuZywg
TGlhbmcgKExlbykgPExpYW5nLkxpYW5nQGFtZC5jb20+Ogo+ID4gCj4gPiBIaSBEYXZpZCwKPiA+
IAo+ID4gV2hpY2ggYmVuY2htYXJrIHRvb2wgeW91IHByZWZlcj8gTWVtdGVzdDg2KyBvciBlbHNl
Pwo+IAo+IEhpIExlbywKPiAKPiBJIHRoaW5rIHlvdSB3YW50IHNvbWV0aGluZyB0aGF0IHJ1bnMg
dW5kZXIgTGludXggbmF0aXZlbHkuCj4gCj4gSeKAmG0gcGxhbm5pbmcgb24gY29kaW5nIHVwIGEg
a2VybmVsIG1vZHVsZSB0byB3YWxrIGFsbCA0TUIgcGFnZXMgaW4gdGhlCj4gZnJlZWxpc3RzIGFu
ZCBwZXJmb3JtIGEgc3RyZWFtIGJlbmNobWFyayBpbmRpdmlkdWFsbHkuIFRoZW4gd2UgbWlnaHQg
YmUKPiBhYmxlIHRvIGlkZW50aWZ5IHRoZSBwcm9ibGVtYXRpYyByYW5nZSAtIGlmIHRoZXJlIGlz
IGEgcHJvYmxlbWF0aWMgcmFuZ2UgOikKCk15IHdpbGQgZ3Vlc3Mgd291bGQgYmUgdGhhdCB0aGUg
cGFnZXMgdGhhdCBhcmUgbm93IGF0IHRoZSBoZWFkIG9mIGZyZWUKbGlzdHMgaGF2ZSB3cm9uZyBj
YWNoaW5nIGVuYWJsZWQuIE1pZ2h0IGJlIHdvcnRoIGNoZWNraW5nIGluIHlvdXIgdGVzdAptb2R1
bGUuCgo+IEd1ZXNzIEnigJhsbCBoYXZlIGl0IHJ1bm5pbmcgYnkgTW9uZGF5IGFuZCBsZXQgeW91
IGtub3cuCj4gCj4gQ2hlZXJzIQoKLS0gClNpbmNlcmVseSB5b3VycywKTWlrZS4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
