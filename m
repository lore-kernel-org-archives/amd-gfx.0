Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D633C432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 22:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6477B206EE
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 22:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6477B206EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB576EE8A;
	Wed, 13 Nov 2019 22:39:21 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720072.outbound.protection.outlook.com [40.107.72.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ABFC6EE8A
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 22:39:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYEbHVu4eBRrfisHBMAL8vGE3Fx8GW8vwKVguZ0+ty74TUx2mW7T6W0rSfuNYAojALEFVjv6O2nBtCH0Teu5Tn/jhOd/3ogLSi3RIIHI5vffRtZyxeuSkYHq7G79BjICSPtabCew7Ri21OBnRpzNk8O7a1R0Pb0y6CBuYAs6cKkgsqHh5UcEgSiP2ZvwgJq24sfTpeDFtMlIzqeQOMkOjgdGxcY5qveJlN+yGId6ivnCtZX1ob/qNNMPe3PZH+Pq+oJ0xNOzhzSxHr+Zp/4ZZrnzIGG+5hW0/C0cemVtkaaGL2UGXHB9pMYewV7e594lrenP2xeuFeDnjLRKrIuDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JamxkSChjK6y5+sMXNkT7PRZFAH4L4iLpvg+KNu07BI=;
 b=m8G+UMcLuHfibAR8raVThLzxoltyFxEFEGiyFlkF69Iiz7hcbeoZnl6K+KnEdt9Wv7Xkdr33aDkEAtF/NGf8T/9Ve7l8HZAGraCsVRStpZZo2UGDjJZxEnM8kYyR5RfuGh/H8b7DBi1Lnd9V6fvJRVaHBQEaWWqmQ6XD36rmKJWMAZOD3XXmnUR98Cey6J1TJLZsgZneO97itFFXLHSL30rWCvL8iFmfOQY6lVoz6eiFwUc7pJg4+nt6OacHKgelUqv1LEJBgfr05rklr5VN4JZQDQIc880LqhMx2ZlTc3WXZQ7dmPOuOo2IJ5UkqRuTGC7/3Gvjcar7HJVcptX/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (10.255.237.150) by
 MN2PR12MB3613.namprd12.prod.outlook.com (20.178.240.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Wed, 13 Nov 2019 22:39:18 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::49f3:af31:eb8e:569b]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::49f3:af31:eb8e:569b%4]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 22:39:18 +0000
Subject: Re: [PATCH] drm/amdkfd: Rename kfd_kernel_queue_*.c to
 kfd_packet_manager_*.c
To: Yong Zhao <yong.zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20191113220946.32529-1-Yong.Zhao@amd.com>
 <5105f095-d0b9-cd87-180b-4a378c775d46@amd.com>
 <ae6b718d-41d8-c2d2-875a-9ffa0e23dd26@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <47415111-61b4-ae83-e456-5a4175cd23c0@amd.com>
Date: Wed, 13 Nov 2019 17:39:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <ae6b718d-41d8-c2d2-875a-9ffa0e23dd26@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::23) To MN2PR12MB3949.namprd12.prod.outlook.com
 (2603:10b6:208:167::22)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ef1d57a-07c1-43f2-8bf4-08d7688a51bf
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB361336E99336A33AD41BA42092760@MN2PR12MB3613.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0220D4B98D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(386003)(2870700001)(53546011)(3846002)(2616005)(5660300002)(11346002)(58126008)(6486002)(44832011)(6436002)(316002)(476003)(2906002)(6116002)(6506007)(36916002)(26005)(186003)(14454004)(446003)(36756003)(229853002)(6512007)(76176011)(23676004)(478600001)(4001150100001)(52116002)(8676002)(66946007)(86362001)(31686004)(99286004)(50466002)(8936002)(66556008)(6246003)(305945005)(2486003)(47776003)(25786009)(65956001)(65806001)(66066001)(7736002)(31696002)(81156014)(486006)(81166006)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3613;
 H:MN2PR12MB3949.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CCgHhck0L0+RsSiSkKqCtE7rSRypNZIa57CYCDvskgPe8NG+woJyslAim5crpbJzM4LTWEB3syyH4en6Ndtowpcxf+Lgt6/DpV7wqvyE9Ikl6ltMPwrUGFaOs3EyA4GyatA7wFXllWVaqRRwoQL1WWNJpgC8GOau9B7Xp17DsVoz3s0MjaZ7u5dL2Mk84anvELe1fqFTW+CuBU9upSkvSbMT1cngKblB3iWMIWLIQSaopNpW5udKJ72PuIaTsUzQ86EFHWiO+Y1cVVV19bFqMJ6+3VUmttaxEVRyVZ89S+bHnu/Ew9AG7BrvfmY04ivCRy3zyrY4KH2SIksAF7HMM5pblJ+1LTN4aJKDMSPXGQhKR4JD3mrGzJDtv3CtvTVzVYYDJfKaUNscrMU4PyCGAVgmWSFNHJYkOaYC62qp/i0yeOO7Do3UOVz91YiBN5TH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef1d57a-07c1-43f2-8bf4-08d7688a51bf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 22:39:18.5026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UJ+2xZnawW3znhc2X7A5Qr8PPiwxDMAIrteYN/FKSL7DUwNJuzECUi3vnJ8jDdVW3ihp25r2vPiWTUn+wFzVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3613
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JamxkSChjK6y5+sMXNkT7PRZFAH4L4iLpvg+KNu07BI=;
 b=4e0mto4ZM/4pdg5wLNNy/YUqzwr5v9EuDjN/X1D92xUrqii0BZNcQYtcxOhOSOt1NzrgNVWUTxQA46PplRgD4nRnTVkdNa4XoCKlsx0F7eCYAaUGDX/rXwrn3bBN96nk8fd60zCety61OllnVIGzYuB4PCXXiOb0B6i3XvRNOaE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113223917.3W96O5ZEcIxpyiG_pRzgsjDlKc_Vx-jETMdVmQjvOnU@z>

T24gMjAxOS0xMS0xMyA1OjI2IHAubS4sIFlvbmcgWmhhbyB3cm90ZToKPiBPaCwgSSBkaWQgbm90
IHJlYWxpemUgdGhlIHBhcnQgaW5zaWRlIG9mIHRoZSBmaWxlLiBJIHRoaW5rIHY5LT5haSBpcyAK
PiBiZXR0ZXIsIGJlY2F1c2UgdGhlIHBhY2tldCBmb3JtYXQgaGVhZGVyIHVzZXMgYWkuIEFsc28g
djkgd2lsbCBnaXZlIAo+IHBlb3BsZSBhbiBpbXByZXNzaW9uIG9mIGdmeDkuCgpUaGVyZSBhcmUg
YSBsb3Qgb2Ygb3RoZXIgcGxhY2VzIGluIEtGRCB0aGF0IHVzZSB0aGUgInY5IiBzdWZmaXguIExp
a2UgSSAKc2FpZCwgaWYgd2UgZGVjaWRlIHRvIGNoYW5nZSB0aGlzLCBpdCB3aWxsIGFmZmVjdCBs
b3RzIG9mIG90aGVyIEtGRCAKZmlsZXMgYW5kIGZ1bmN0aW9ucy4KClRoZSBjb2RlIGluIHRoZSBw
YWNrZXQgbWFuYWdlciBkZWFscyB3aXRoIHRoZSBNRUMsIHdoaWNoIGlzIHBhcnQgb2YgdGhlIApH
RlggZW5naW5lLiBTbyByZWZlcnJpbmcgdG8gdGhlIEdGWCB2ZXJzaW9uICh2OSkgbWFrZXMgc2Vu
c2UuIEFJIHJlZmVycyAKdG8gdGhlIHdob2xlIFNPQyBnZW5lcmF0aW9uIGJ5IGl0cyBkZXByZWNh
dGVkIGNvZGUgbmFtZSB0aGF0IHRoZSBWZWdhIApjb2RlIG5hbWUgZm9yIHRoZSBTT0MgdGhhdCdz
IHVzZWQgZWxzZXdoZXJlIGluIHRoZSBjb2RlLgoKUmVnYXJkcywKIMKgIEZlbGl4Cgo+Cj4gWW9u
Zwo+Cj4gT24gMjAxOS0xMS0xMyA1OjE5IHAubS4sIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+PiBP
biAyMDE5LTExLTEzIDU6MDkgcC5tLiwgWW9uZyBaaGFvIHdyb3RlOgo+Pj4gQWZ0ZXIgdGhlIHJl
Y2VudCBjbGVhbnVwLCB0aGUgZnVuY3Rpb25hbGl0aWVzIHByb3ZpZGVkIGJ5IHRoZSBwcmV2aW91
cwo+Pj4ga2ZkX2tlcm5lbF9xdWV1ZV8qLmMgYXJlIGFjdHVhbGx5IGFsbCBwYWNrZXQgbWFuYWdl
ciByZWxhdGVkLiBTbyByZW5hbWUKPj4+IHRoZW0gdG8gcmVmbGVjdCB0aGF0Lgo+Pj4KPj4+IENo
YW5nZS1JZDogSTY1NDRjY2IzOGRhODI3Yzc0NzU0NGMwNzg3YWE5NDlkZjIwZWRiYjAKPj4+IFNp
Z25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5jb20+Cj4+PiAtLS0KPj4+IMKg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL01ha2VmaWxlIHwgNCArKy0tCj4+PiDCoCAuLi4v
YW1ka2ZkL3trZmRfa2VybmVsX3F1ZXVlX3Y5LmMgPT4ga2ZkX3BhY2tldF9tYW5hZ2VyX2FpLmN9
IHwgMAo+Pj4gwqAgLi4uL2FtZGtmZC97a2ZkX2tlcm5lbF9xdWV1ZV92aS5jID0+IGtmZF9wYWNr
ZXRfbWFuYWdlcl92aS5jfSB8IDAKPj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+Pj4gwqAgcmVuYW1lIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL3trZmRfa2VybmVsX3F1ZXVlX3Y5LmMgPT4gCj4+PiBrZmRfcGFja2V0X21hbmFnZXJfYWku
Y30gKDEwMCUpCj4+PiDCoCByZW5hbWUgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQve2tmZF9r
ZXJuZWxfcXVldWVfdmkuYyA9PiAKPj4+IGtmZF9wYWNrZXRfbWFuYWdlcl92aS5jfSAoMTAwJSkK
Pj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvTWFrZWZpbGUg
Cj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL01ha2VmaWxlCj4+PiBpbmRleCBmOTNh
MTYzNzIzMjUuLjU1YmZlY2YwNDIzOSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL01ha2VmaWxlCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9N
YWtlZmlsZQo+Pj4gQEAgLTM4LDkgKzM4LDkgQEAgQU1ES0ZEX0ZJTEVTwqDCoMKgIDo9ICQoQU1E
S0ZEX1BBVEgpL2tmZF9tb2R1bGUubyBcCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgJChBTURLRkRf
UEFUSCkva2ZkX21xZF9tYW5hZ2VyX3Y5Lm8gXAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgICQoQU1E
S0ZEX1BBVEgpL2tmZF9tcWRfbWFuYWdlcl92MTAubyBcCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
JChBTURLRkRfUEFUSCkva2ZkX2tlcm5lbF9xdWV1ZS5vIFwKPj4+IC3CoMKgwqDCoMKgwqDCoCAk
KEFNREtGRF9QQVRIKS9rZmRfa2VybmVsX3F1ZXVlX3ZpLm8gXAo+Pj4gLcKgwqDCoMKgwqDCoMKg
ICQoQU1ES0ZEX1BBVEgpL2tmZF9rZXJuZWxfcXVldWVfdjkubyBcCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgJChBTURLRkRfUEFUSCkva2ZkX3BhY2tldF9tYW5hZ2VyLm8gXAo+Pj4gK8KgwqDCoMKg
wqDCoMKgICQoQU1ES0ZEX1BBVEgpL2tmZF9wYWNrZXRfbWFuYWdlcl92aS5vIFwKPj4+ICvCoMKg
wqDCoMKgwqDCoCAkKEFNREtGRF9QQVRIKS9rZmRfcGFja2V0X21hbmFnZXJfYWkubyBcCj4+Cj4+
IFRoaXMgbmFtaW5nIGNvbnZlbnRpb24gaXMgaW5jb25zaXN0ZW50IHdpdGggdGhlIHJlc3Qgb2Yg
S0ZELiBXZSB1c2UgCj4+IF92OSwgbm90IF9haS4gQWxzbyB0aGUgZnVuY3Rpb24gcyBpbnNpZGUg
dGhpcyBmaWxlIGFyZSBuYW1lZCBfdjkuIElmIAo+PiB3ZSBkZWNpZGUgdG8gY2hhbmdlIHRoYXQg
bmFtaW5nIGNvbnZlbnRpb24sIGl0IHNob3VsZCBub3QgYmUgCj4+IGFjY2lkZW50YWwgYW5kIHBp
ZWNlLW1lYWwuIEl0IHNob3VsZCBiZSBkZWxpYmVyYXRlIGFuZCBjb21wcmVoZW5zaXZlLgo+Pgo+
PiBSZWdhcmRzLAo+PiDCoCBGZWxpeAo+Pgo+Pgo+Pj4gJChBTURLRkRfUEFUSCkva2ZkX3Byb2Nl
c3NfcXVldWVfbWFuYWdlci5vIFwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAkKEFNREtGRF9QQVRI
KS9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIubyBcCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgJChB
TURLRkRfUEFUSCkva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyX2Npay5vIFwKPj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVsX3F1ZXVlX3Y5LmMgCj4+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wYWNrZXRfbWFuYWdlcl9haS5jCj4+
PiBzaW1pbGFyaXR5IGluZGV4IDEwMCUKPj4+IHJlbmFtZSBmcm9tIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWVfdjkuYwo+Pj4gcmVuYW1lIHRvIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9wYWNrZXRfbWFuYWdlcl9haS5jCj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZV92aS5jIAo+Pj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcGFja2V0X21hbmFnZXJfdmkuYwo+Pj4gc2lt
aWxhcml0eSBpbmRleCAxMDAlCj4+PiByZW5hbWUgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfa2VybmVsX3F1ZXVlX3ZpLmMKPj4+IHJlbmFtZSB0byBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfcGFja2V0X21hbmFnZXJfdmkuYwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
