Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0AFC4CECE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 08:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9D2A206FA
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 08:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wNgLvNIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D2A206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B318B6EB99;
	Fri, 13 Mar 2020 08:52:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 806066EB99
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 08:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vx84fbN8APTa9MiJHUJPBII7HL5cVzFXbu6lMfTiRtaQqkQjyDN7RyydVgM5tdZ0xwuYNNSfnN912wYVIcVgS9vJRaqdJUk3YwucEzIxioJN3JWES6rUQHdMnh2c+7Rhixffin8VnJv0fTQlO4wUMBdqQii3eNRPKPIm82h2APSL9JnIH5PXjN4NfcOev7UXePD9tZ7EiiHjxFSvBwM4bsuvBsbGmDNORo6p8SDuSuFIRlAHyqdjq1R/HnojhxA5IqWsh723Yp4y08eIykKbGBz3tvsGDqOb6wtx5nkKMy17HwZg/MWDn9u/JjtOrHvqvcEaZbfLXfgZ+KjDfnHRUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIiAs9T+m85KfVJeUaezJlJEK2C4x4Q6zfBqrwze7i8=;
 b=YhIbnW1DkLeFA03m5UiJBCptcDakfAqNefhMW3rSXXRNCQsexz5ymcSOZzFf+fj7FWPqBdOw/Ra9v7T0lZzuNxv9lSDcmoJ8yG0VElzxhGIX+jIadYejC8PNMW4UcrqxYlYpzb0PnpXhYeH4sl9F3untQ265eiLS2poTc2ufPAiZhT2EXaso/UEG+H9UW54SeMzwGzBU7vkGHwUGy3mvfT1/a0m/8RjfVWIezTTJEuEz/YKd2+bRQrXiKSY2jYVDvypJqWx1KQAKO9eC62i38aOZgQMkzMHgVD/W1kGMG0GZ2mxkIZcylbkYs/7QkA7xB8BDex1rsSMkT8npK3aL1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIiAs9T+m85KfVJeUaezJlJEK2C4x4Q6zfBqrwze7i8=;
 b=wNgLvNIYcabXPM14kSQ2yAFr0ojZYv7QFaL6Olc2byGX3AEidh2p1lvtsUNLYxmm/obboVj5YQK+trbVlptXWg1CM4T6sVAJUddhEt/kJydoUbeoDjfN4gd7X3sExz1CpwIpzJ8FLGfQO0QDImzIyXikeCQk4FtNREgJXGg7uX4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB1275.namprd12.prod.outlook.com (2603:10b6:3:75::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16; Fri, 13 Mar 2020 08:52:25 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c%7]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 08:52:25 +0000
Subject: Re: [PATCH 1/2] drm//amdgpu: Always sync fence before unlock
 eviction_lock
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200313074336.19545-1-xinhui.pan@amd.com>
 <20200313074336.19545-2-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <91022e2e-67fb-ef65-09d6-2814b10493d8@amd.com>
Date: Fri, 13 Mar 2020 09:52:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200313074336.19545-2-xinhui.pan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0501CA0050.eurprd05.prod.outlook.com
 (2603:10a6:200:68::18) To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR0501CA0050.eurprd05.prod.outlook.com (2603:10a6:200:68::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend
 Transport; Fri, 13 Mar 2020 08:52:24 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22ca93e7-782a-4c3d-cabd-08d7c72bda20
X-MS-TrafficTypeDiagnostic: DM5PR12MB1275:|DM5PR12MB1275:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB12757CB03E7B6901E2DF847D83FA0@DM5PR12MB1275.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(199004)(8936002)(6666004)(16526019)(31696002)(4326008)(8676002)(81166006)(81156014)(186003)(2906002)(66574012)(31686004)(316002)(478600001)(2616005)(6486002)(66476007)(66556008)(66946007)(5660300002)(54906003)(86362001)(52116002)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1275;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wnh9ANNPQWISURZm+Y3pQeEXcTcb25A9NjVH4iykvsyd8CzZlQAdjxsUAd2lBZIoqSY9ONV73EXVFzDQDKCc5t+fZ7l8zk2rcOfqux5lz7hCbz/Whun1KkNI1hBDx7qffbBVYKFVQgtJv0ad0OO78rlCE/6govLJvMQb/UhCZkEfEDvi5NTTS+HwpjVAf8kl5vMOOz/tG0mpLLYblCjZ659cqmF023e7lS13DlWxEHEBmYQI/5xJdUn1Rb/bt4L9G044ZTznYYpC6lmpY94ZtgxbDurgf/FJdkwvvOSRe5zSkTMCoM0EQvDLgvB5Vf2rBRNzSMRRJ0CYwroE5zlSRZ8w4LsBxCwiBommtjfOFPS2V/JjS6rxlOWpotbWgJYT5uaNcVyJ0TasDuyyc+X7JeAd4Va0WDGniGdHplCnMKyQ8FmvOYDzYFVbet/iCUkq
X-MS-Exchange-AntiSpam-MessageData: 9D21xKMJ5xX3VgiK0tlVUvpN4IBPajmK5IzJRK1OO3awEx2TRO0Ri5XoUnzkO2Hukdy6df6GBGzQ9fNHLb75t7Oabd4Ls+W3V8tMZs1fC61le1GxO8b9wV1Sz0me6/bWIQkH8jCVo9JpEayKYR2VOqZPB0nDtYYLkdQoXeim3+ucHqwEc8iWt25mlQV0wmJDDd7Fmozh+6mdzwAbL1l7QA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ca93e7-782a-4c3d-cabd-08d7c72bda20
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 08:52:25.5806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bGJrpxJpZDyCh3G2gwX4Te1a+pdeTvqELZr5aHCNUxvQpVKmqifHgkjma3K1cnnu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1275
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTMuMDMuMjAgdW0gMDg6NDMgc2NocmllYiB4aW5odWkgcGFuOgo+IFRoZSBmZW5jZSBnZW5l
cmF0ZWQgaW4gLT5jb21taXQgaXMgYSBzaGFyZWQgb25lLCBzbyBhZGQgaXQgdG8gcmVzdi4KPiBB
bmQgd2UgbmVlZCBkbyB0aGF0IHdpdGggZXZpY3Rpb24gbG9jayBob2xkLgo+Cj4gQ3VycmVudGx5
IHdlIG9ubHkgc3luYyBsYXN0X2RpcmVjdC9sYXN0X2RlbGF5ZWQgYmVmb3JlIC0+cHJlcGFyZS4g
QnV0IHdlCj4gZmFpbCB0byBzeW5jIHRoZSBsYXN0IGZlbmNlIGdlbmVyYXRlZCBieSAtPmNvbW1p
dC4gVGhhdCBjdWFzZXMgcHJvYmxlbXMKPiBpZiBldmljdGlvbiBoYXBwZW5lcyBsYXRlciwgYnV0
IGl0IGRvZXMgbm90IHN5bmMgdGhlIGxhc3QgZmVuY2UuCgpOQUssIHRoYXQgd29uJ3Qgd29yay4K
CldlIGNhbiBvbmx5IGFkZCBmZW5jZXMgd2hlbiB0aGUgZG1hX3Jlc3Ygb2JqZWN0IGlzIGxvY2tl
ZCBhbmQgdGhhdCBpcyAKb25seSB0aGUgY2FzZSB3aGVuIHZhbGlkYXRpbmcuCgpJJ20gY29uc2lk
ZXJpbmcgdG8ganVzdCBwYXJ0aWFsbHkgcmV2ZXJ0IHRoZSBwYXRjaCBvcmlnaW5hbGx5IHN0b3Bw
aW5nIAp0byBhZGQgZmVuY2VzIGFuZCBpbnN0ZWFkIG9ubHkgbm90IGFkZCB0aGVtIHdoZW4gaW52
YWxpZGF0aW5nIGluIGEgCmRpcmVjdCBzdWJtaXQuCgpDaHJpc3RpYW4uCgo+Cj4gQ2M6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiBGZWxpeCBLdWVobGluZyA8RmVsaXgu
S3VlaGxpbmdAYW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiB4aW5odWkgcGFuIDx4aW5odWkucGFu
QGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
YyB8IDkgKysrKysrKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRl
eCA3MzM5ODgzMTE5NmYuLmY0MjRiNTk2OTkzMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCj4gQEAgLTE1ODIsNiArMTU4Miw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1
X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCXN0
cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyBwYXJhbXM7Cj4gICAJZW51bSBhbWRncHVfc3lu
Y19tb2RlIHN5bmNfbW9kZTsKPiAgIAlpbnQgcjsKPiArCXN0cnVjdCBhbWRncHVfYm8gKnJvb3Qg
PSB2bS0+cm9vdC5iYXNlLmJvOwo+ICAgCj4gICAJbWVtc2V0KCZwYXJhbXMsIDAsIHNpemVvZihw
YXJhbXMpKTsKPiAgIAlwYXJhbXMuYWRldiA9IGFkZXY7Cj4gQEAgLTE2MDQsOCArMTYwNSw2IEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAo+ICAgCX0KPiAgIAo+ICAgCWlmIChmbGFncyAmIEFNREdQVV9QVEVfVkFMSUQp
IHsKPiAtCQlzdHJ1Y3QgYW1kZ3B1X2JvICpyb290ID0gdm0tPnJvb3QuYmFzZS5ibzsKPiAtCj4g
ICAJCWlmICghZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKHZtLT5sYXN0X2RpcmVjdCkpCj4gICAJCQlh
bWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxhc3RfZGlyZWN0LCB0cnVlKTsKPiAgIAo+IEBAIC0x
NjIzLDYgKzE2MjIsMTIgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmco
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAKPiAgIAlyID0gdm0tPnVwZGF0ZV9mdW5j
cy0+Y29tbWl0KCZwYXJhbXMsIGZlbmNlKTsKPiAgIAo+ICsJaWYgKCFkbWFfZmVuY2VfaXNfc2ln
bmFsZWQodm0tPmxhc3RfZGlyZWN0KSkKPiArCQlhbWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxh
c3RfZGlyZWN0LCB0cnVlKTsKPiArCj4gKwlpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZCh2bS0+
bGFzdF9kZWxheWVkKSkKPiArCQlhbWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxhc3RfZGVsYXll
ZCwgdHJ1ZSk7Cj4gKwo+ICAgZXJyb3JfdW5sb2NrOgo+ICAgCWFtZGdwdV92bV9ldmljdGlvbl91
bmxvY2sodm0pOwo+ICAgCXJldHVybiByOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
