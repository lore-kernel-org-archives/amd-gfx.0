Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921BDC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 14:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67DA4207D3
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 14:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HFdqlz4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DA4207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB056E581;
	Thu, 28 May 2020 14:40:08 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750054.outbound.protection.outlook.com [40.107.75.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A1636E581
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 14:40:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFt9ihhMAwn6pBPN0nrxGBIvFDHppYgDstt6p8YI/Ltwo5kdOifwa2QhKQWNIkgf2UEJcj3uAeDzSevBi4qtGAQrVzSAjYJ5RHdNSAfeLfsXm5S/Y0jRoV2ryVQ3jRpnIhCne/H5Es8w9O0LI2Bd44jXG4oC8c41hT7MnqQ+NzYLh8iFkqwVmuhzVWfgPwzfa+LAUJATx1QOJNZKAgfbSIyCo7Q6maU3r+QmuJjAoRRa9e1DIkXpxvjSvXiYhqILDVu1OxrLROWpEL3KLBeEwR97C9a9obyUKCJDndL6NCnPVSgtzBXY+RUabsI9kcol+7iW/8H2bqH8lUgoiDMHsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gk6fY88xWqqHfxMtXz3mdQDKE2CwTsZHLD3/UvDYRKg=;
 b=L8MUqkLsIV5qIeLH/VD0VuxkSHr1t2MVnuBPxXfLS0CKew3A9F3OPN4oletxU8Dzo7ueD4o4M7zYhTkzd386Aiwb8dE7WVTwZ+TAEMBmXjMk1vjbAkmMB2CQ0243vQtxDDblVx9++p8BJ+gH8rd8+fzfVUu7nSiDfXvfukyvFmsa5wOsOcUPzZCDSRhT/QfckTvG2vMxeAqxIYepyqdOSQumjJmipmK7m7nMhi1fo32vy6ynqyt9JSas1DnNoVh4l/btM6fXKpdfg96/H/s1iP26VIyLoc512Z4d0QCexvYjVc+GqFsm3g5WMDcL49iIOHvg7HqQwkY5Qi7nCUSn8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gk6fY88xWqqHfxMtXz3mdQDKE2CwTsZHLD3/UvDYRKg=;
 b=HFdqlz4s5jJwneJpsrRqZfs1GC8lnOlsCo6Bq4Pbi14KCYD+orWJveHXnQM8JUu5+W+UsXm64IkeSMG7F+JbGeWNygCr3xr9hDQhiu+vEEQj2maXFb/EzfsJRqq1rXMT3QJjTtkd+NQjIuWIo3Krd+crWkTX1QV65qxzKMP7da8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3980.namprd12.prod.outlook.com (2603:10b6:5:1cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 14:40:04 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 14:40:04 +0000
Subject: Re: amdgpu doesn't do implicit sync, requires drivers to do it in IBs
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <CAAxE2A5Kv9oB7TnoAKSLfuB7unYZzgggSY=BaNyHZq0Fvi+5Qw@mail.gmail.com>
 <CAAxE2A7wy4CBevdHwQzGgYFZHkEUP4Fokj2CzET9GmJWHA+kww@mail.gmail.com>
 <1b4cc0a0-b690-3f54-d983-76975fe788bf@gmail.com>
 <e2f2843b-db9f-bba3-1925-55af2a68432d@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1adb6ee4-7472-fa3e-fd67-6e5c6668cbc3@amd.com>
Date: Thu, 28 May 2020 16:39:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <e2f2843b-db9f-bba3-1925-55af2a68432d@daenzer.net>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0902CA0016.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::26) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR0902CA0016.eurprd09.prod.outlook.com (2603:10a6:200:9b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend
 Transport; Thu, 28 May 2020 14:40:03 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 631ed360-b0f0-4636-e888-08d803150230
X-MS-TrafficTypeDiagnostic: DM6PR12MB3980:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3980B3CD3E4483C6111DDCEE838E0@DM6PR12MB3980.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gorp05CKoQ0eE2o33WEFZA+ZlQ7OhlH6WZ+Qax909ngAd9uLMkiBs57ZMF4bCAqksWH+bdwBsVMJqqENfyzTEObZ5p5fWaphjHxFbzQSv+FnIaEfJJ+8CGi01uAlLzlg3MQhswDmFQDDpzvIC/fTp8vn1VgtT0cVRw2KJJTq+AbXQFS5VCpkvRkIudoGtBTHVLepFaMZT1z8kU8+yDeJxKt+pkOimwdCzBq6tNatrDeOTQHW4Im13eaBiaRGMGzWgZK0dcTW9wuZGkLBCEN6U0uyfVd7iyUL0aagpmxE/Tm7fmxfBn0x2Dz0IsH41WKfAfV5hlgIQWVZoJgbZYO0Vjc5Od4PgX88tl5/9nb9ohLi/wRgnk8DRhKfDQcycNOv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(66476007)(66556008)(31696002)(66946007)(316002)(86362001)(6486002)(36756003)(6666004)(110136005)(31686004)(2906002)(83380400001)(4326008)(8936002)(16526019)(52116002)(186003)(8676002)(478600001)(2616005)(5660300002)(53546011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xMTa7/dpWZ7jmWsGbKGLNeNcO9ldU+7sAKw8xe1Gr35wr+SVwTkLyzj+7I3YKjlC6t/wuJPjwIWH0UMaEuuDuaKXcqzXWOJTZ15ifs4mNNNuzJFkdIrIsd8HmgZ16GJvF3VnFdTHAPrzYXI8Z7roKSTDOQzo9InGxi3pHE7KMODtePcOQrJTueJ64VfdVjORTLcsjd1o48eOQfYbjE0u+FHfU+YR238MGblyM36ZjfQ5Y49IoZwByp+8vdh1LI2G29edEyg/+rI1t1X21SielTAnzozC0x1wZ5B5wZ3OC0fruqAAgmxMoE543RhuRQYV0Ls2+Jiwxg96ylo32l/xNUa1xvdi3N+9G2cryBnn4oM1En0C10upBxq8dFSWEHUYo0wxlWSWHgdailUzCnM/dwFQWe0LORuV1oNIQXz67FDfjKyD3cLRmsiNnnSfL1LwQH5sGwiHluRXYAc+KmLT5JLWBIwbDBAox5jWjSr6nQHjDco78kqMQgAJfIPxkhjwDdDIXe2Q8vtfzjwNv5podr+h/7PZRGxZrpLeoxmRlghZyvLGy80KgdX3zTJGBOPx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631ed360-b0f0-4636-e888-08d803150230
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 14:40:04.0494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0fCBEh4qhaEwEjlKUloPFBwuB2aNvso+fyvms+u8fFm+IFh2yEBeo7DDExJcuzS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3980
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjguMDUuMjAgdW0gMTI6MDYgc2NocmllYiBNaWNoZWwgRMOkbnplcjoKPiBPbiAyMDIwLTA1
LTI4IDExOjExIGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFdlbGwgd2Ugc3RpbGwg
bmVlZCBpbXBsaWNpdCBzeW5jIFsuLi5dCj4gWWVhaCwgdGhpcyBpc24ndCBhYm91dCAid2UgZG9u
J3Qgd2FudCBpbXBsaWNpdCBzeW5jIiwgaXQncyBhYm91dCAiYW1kZ3B1Cj4gZG9lc24ndCBlbnN1
cmUgbGF0ZXIgam9icyBmdWxseSBzZWUgdGhlIGVmZmVjdHMgb2YgcHJldmlvdXMgaW1wbGljaXRs
eQo+IHN5bmNlZCBqb2JzIiwgcmVxdWlyaW5nIHVzZXJzcGFjZSB0byBkbyBwZXNzaW1pc3RpYyBm
bHVzaGluZy4KClllcywgZXhhY3RseSB0aGF0LgoKRm9yIHRoZSBiYWNrZ3JvdW5kOiBXZSBhbHNv
IGRvIHRoaXMgZmx1c2hpbmcgZm9yIGV4cGxpY2l0IHN5bmNzLiBBbmQgCndoZW4gdGhpcyB3YXMg
aW1wbGVtZW50ZWQgMi0zIHllYXJzIGFnbyB3ZSBmaXJzdCBkaWQgdGhlIGZsdXNoaW5nIGZvciAK
aW1wbGljaXQgc3luYyBhcyB3ZWxsLgoKVGhhdCB3YXMgaW1tZWRpYXRlbHkgcmV2ZXJ0ZWQgYW5k
IHRoZW4gaW1wbGVtZW50ZWQgZGlmZmVyZW50bHkgYmVjYXVzZSAKaXQgY2F1c2VkIHNldmVyZSBw
ZXJmb3JtYW5jZSBwcm9ibGVtcyBpbiBzb21lIHVzZSBjYXNlcy4KCkknbSBub3Qgc3VyZSBvZiB0
aGUgcm9vdCBjYXVzZSBvZiB0aGlzIHBlcmZvcm1hbmNlIHByb2JsZW1zLiBNeSAKYXNzdW1wdGlv
biB3YXMgYWx3YXlzIHRoYXQgd2UgdGhlbiBpbnNlcnQgdG8gbWFueSBwaXBlbGluZSBzeW5jcywg
YnV0IApNYXJlayBkb2Vzbid0IHNlZW0gdG8gdGhpbmsgaXQgY291bGQgYmUgdGhhdC4KCk9uIHRo
ZSBvbmUgaGFuZCBJJ20gcmF0aGVyIGtlZW4gdG8gcmVtb3ZlIHRoZSBleHRyYSBoYW5kbGluZyBh
bmQganVzdCAKYWx3YXlzIHVzZSB0aGUgZXhwbGljaXQgaGFuZGxpbmcgZm9yIGV2ZXJ5dGhpbmcg
YmVjYXVzZSBpdCBzaW1wbGlmaWVzIAp0aGUga2VybmVsIGNvZGUgcXVpdGUgYSBiaXQuIE9uIHRo
ZSBvdGhlciBoYW5kIEkgZG9uJ3Qgd2FudCB0byBydW4gaW50byAKdGhpcyBwZXJmb3JtYW5jZSBw
cm9ibGVtIGFnYWluLgoKQWRkaXRpb25hbCB0byB0aGF0IHdoYXQgdGhlIGtlcm5lbCBkb2VzIGlz
IGEgImZ1bGwiIHBpcGVsaW5lIHN5bmMsIGUuZy4gCndlIGJ1c3kgd2FpdCBmb3IgdGhlIGZ1bGwg
aGFyZHdhcmUgcGlwZWxpbmUgdG8gZHJhaW4uIFRoYXQgbWlnaHQgYmUgCm92ZXJraWxsIGlmIHlv
dSBqdXN0IHdhbnQgdG8gZG8gc29tZSBmbHVzaGluZyBzbyB0aGF0IHRoZSBuZXh0IHNoYWRlciAK
c2VlcyB0aGUgc3R1ZmYgd3JpdHRlbiwgYnV0IEknbSBub3QgYW4gZXhwZXJ0IG9uIHRoYXQuCgpS
ZWdhcmRzLApDaHJpc3RpYW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
