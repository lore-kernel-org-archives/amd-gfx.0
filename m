Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0122C33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 12:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970F8207FF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 12:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JDYZCoLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970F8207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4A4C6E9C3;
	Wed, 15 Jan 2020 12:52:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D604D6E9C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 12:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcKNzeBKKEIX23YRpSTjtOKkl/vhg2uXs1rN1nhNtWK7woB/yw4A/ORj0lV5pQLLUm8jUHVO9jKM9EBdWH8fyg4lheFuLpZmk9K3njSh1j4u1Uaj4rJx4EqKbFiDEDvChbXuNeOxfsFOlVvDjkaSb78RPYMzBCwuVRJ7RDCCilDWXfjqSIyaeFjeQ+EiKYN+pynE2jnuh0G2x/KXDrn5jcDc2ziSn8kRAaUYmp2CcGUTUynXeAdXh88jn0wKR7MphTVH2mxkTm4vBX1zBKRFJu7OZk6pZpZpIWcPGIqhrMnbjDDsK6YGuJ6E+s7A9QjkYLFz2/wnsGHUyfSmOVeiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwR1xEeLjoLcLXK1QKEtgpjj87mqqqhpx12EUQCreKA=;
 b=W942EaYx1L2HCviSoMeJ/8NOVqx2MbZYB2M9dqMKo8KQI9Qe906mchYLqIzMFwjeKR4/ZQcEE4O5Ay5AZo5MRH5XwcCuLtHRnkCrpwmbfthaEtH/3TewCKMgBmUyBbLovvgN31nr8uC7l68NQFSsUhztCxmR+bWlVa8/wPfFLGIgGtxqEAuGMPajG2lDXIHh6o9Ab4m9YInMuzpcJ+h4Bn0Fd9/9Z4c+4RcJ+EluW7iIubxjNOyVh4ycRi/dBhrE26KAYQ/QQe9PQ0jZgaCQGTUEr/XC3k2hVKkeyq3iG4vrlz4QVeN0Mx44OVMtix7GmIDhx6LBZhnzWfv44zJefw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwR1xEeLjoLcLXK1QKEtgpjj87mqqqhpx12EUQCreKA=;
 b=JDYZCoLHOTDR148eCcIxnyFWJphf9XLdAdrGcTBIPDd3Af0ol0YXcStBlzzXtX0SIVTZhuK1UhvdKc0Op1cfYqOoyzIznS7+scTQzwftMVJyeAP4GcoIUevLmK1t5++LzF4/9FEZNi7YYOL2SusaXVAGi0sbdrp2wzrIYPYGKIs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1209.namprd12.prod.outlook.com (10.168.234.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Wed, 15 Jan 2020 12:52:06 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2623.015; Wed, 15 Jan 2020
 12:52:06 +0000
Subject: Re: [PATCH] drm/scheduler: fix race condition in load balancer
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200114154339.3519-1-nirmoy.das@amd.com>
 <5deb3805-f7e8-3d0d-4259-a3be1c5d3cf5@gmail.com>
 <862ad550-082d-7ece-1d4d-99801ab10428@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <8b4d2ea2-a28d-6eb4-2d50-02b5c450922f@amd.com>
Date: Wed, 15 Jan 2020 13:52:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <862ad550-082d-7ece-1d4d-99801ab10428@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::23) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZR0P278CA0054.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 12:52:05 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6cfa95a-ef08-4775-5f5e-08d799b9b9e3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1209:|DM5PR12MB1209:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1209CABD414A8CFE57AA575383370@DM5PR12MB1209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(31696002)(66556008)(66476007)(81156014)(8936002)(81166006)(8676002)(186003)(4326008)(31686004)(2616005)(53546011)(2906002)(36756003)(66946007)(52116002)(5660300002)(316002)(110136005)(478600001)(6666004)(6486002)(86362001)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1209;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nnSRTP1J05XMqOi5sys3Gh4F/49Rhy4xpx8SrNRhKjqQQoivzEZXZEbgUxeiZDUymQtPc+Vwj38jDNLg+FUrsNE3PtOzG3xGttfFSJHTvG+k/s3VcgtCkDKnSTDpK/6m4PImUVqJm6O/dF+9id2PCJkHox8q+RHwtjNwW4gF4xOcz0NfmXqpKlvqJ7FeQIT20tsRzDwsNs5ox/yNi6SSoz/J79v8g8akHJIaNf/U8mwxwVNkMnzA6WXr5BdLyP740oKjWIi6EH2+0wAFo3c5sKTqS0udd+mUuL/rUuUnRCo1OsA4AISARdX/BnejO1hhybjknaxkJy88PP5mBqQH0zCrZlak5jx0ndE5oz4NALL9WGVmAZ1bWkcJNEAYoTnW1zRObq+bDjrMEcfe7QVIgeqX4+JsshBTyqFztynnnzfWo3Sladj7WQLqcQTzqRjK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cfa95a-ef08-4775-5f5e-08d799b9b9e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 12:52:06.5508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiHYbSlcY1dNx+Dv+/i38MrZ2B3IltGxMavH/e5YEN9FS5LRkvthlLWmICpwYZHA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1209
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 pierre-eric.pelloux-prayer@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgTmlybW95LAoKQW0gMTUuMDEuMjAgdW0gMTI6MDQgc2NocmllYiBOaXJtb3k6Cj4gSGkgQ2hy
aXN0aWFuLAo+Cj4gT24gMS8xNC8yMCA1OjAxIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+
Pgo+Pj4gQmVmb3JlIHRoaXMgcGF0Y2g6Cj4+Pgo+Pj4gc2NoZWRfbmFtZcKgwqDCoMKgIG51bSBv
ZiBtYW55IHRpbWVzIGl0IGdvdCBzY2hlZHVsZWQKPj4+ID09PT09PT09PcKgwqDCoMKgwqAgPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+Pj4gc2RtYTDCoMKgwqDCoMKgwqDCoMKg
wqAgMzE0Cj4+PiBzZG1hMcKgwqDCoMKgwqDCoMKgwqDCoCAzMgo+Pj4gY29tcF8xLjAuMMKgwqDC
oMKgIDU2Cj4+PiBjb21wXzEuMS4wwqDCoMKgwqAgMAo+Pj4gY29tcF8xLjEuMcKgwqDCoMKgIDAK
Pj4+IGNvbXBfMS4yLjDCoMKgwqDCoCAwCj4+PiBjb21wXzEuMi4xwqDCoMKgwqAgMAo+Pj4gY29t
cF8xLjMuMMKgwqDCoMKgIDAKPj4+IGNvbXBfMS4zLjHCoMKgwqDCoCAwCj4+Pgo+Pj4gQWZ0ZXIg
dGhpcyBwYXRjaDoKPj4+Cj4+PiBzY2hlZF9uYW1lwqDCoMKgwqAgbnVtIG9mIG1hbnkgdGltZXMg
aXQgZ290IHNjaGVkdWxlZAo+Pj4gPT09PT09PT09wqDCoMKgwqDCoCA9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09Cj4+PiDCoCBzZG1hMcKgwqDCoMKgwqDCoMKgwqDCoCAyNDMKPj4+
IMKgIHNkbWEwwqDCoMKgwqDCoMKgwqDCoMKgIDE2NAo+Pj4gwqAgY29tcF8xLjAuMcKgwqDCoMKg
IDE0Cj4+PiDCoCBjb21wXzEuMS4wwqDCoMKgwqAgMTEKPj4+IMKgIGNvbXBfMS4xLjHCoMKgwqDC
oCAxMAo+Pj4gwqAgY29tcF8xLjIuMMKgwqDCoMKgIDE1Cj4+PiDCoCBjb21wXzEuMi4xwqDCoMKg
wqAgMTQKPj4+IMKgIGNvbXBfMS4zLjDCoMKgwqDCoCAxMAo+Pj4gwqAgY29tcF8xLjMuMcKgwqDC
oMKgIDEwCj4+Cj4+IFdlbGwgdGhhdCBpcyBzdGlsbCByYXRoZXIgbmljZSB0byBoYXZlLCB3aHkg
ZG9lcyB0aGF0IGhhcHBlbj8KPgo+IEkgdGhpbmsgSSBrbm93IHdoeSBpdCBoYXBwZW5zLiBBdCBp
bml0IGFsbCBlbnRpdHkncyBycSBnZXRzIGFzc2lnbmVkIAo+IHRvIHNjaGVkX2xpc3RbMF0uIEkg
cHV0IHNvbWUgcHJpbnRzIHRvIGNoZWNrIHdoYXQgd2UgY29tcGFyZSBpbiAKPiBkcm1fc2NoZWRf
ZW50aXR5X2dldF9mcmVlX3NjaGVkLgo+Cj4gSXQgdHVybnMgb3V0IG1vc3Qgb2YgdGhlIHRpbWUg
aXQgY29tcGFyZXMgemVybyB2YWx1ZXMobnVtX2pvYnMoMCkgPCAKPiBtaW5fam9icygwKSkgc28g
bW9zdCBvZiB0aGUgdGltZSAxc3QgcnEoc2RtYTAsIGNvbXBfMS4wLjApIHdhcyBwaWNrZWQgCj4g
YnkgZHJtX3NjaGVkX2VudGl0eV9nZXRfZnJlZV9zY2hlZC4KCldlbGwgdGhhdCBpcyBleHBlY3Rl
ZCBiZWNhdXNlIHRoZSB1bml0IHRlc3RzIGFsd2F5cyBkb2VzIApzdWJtaXNzaW9uLHdhaXQsc3Vi
bWlzc2lvbix3YWl0LHN1Ym1pc3Npb24sd2FpdC4uLi4gU28gdGhlIG51bWJlciBvZiAKam9icyBp
biB0aGUgc2NoZWR1bGVyIGJlY29tZXMgemVybyBpbiBiZXR3ZWVuLgoKPiBUaGlzIHBhdGNoIHdh
cyBub3QgY29ycmVjdCAsIGhhZCBhbiBleHRyYSBhdG9taWNfaW5jKG51bV9qb2JzKSBpbiAKPiBk
cm1fc2NoZWRfam9iX2luaXQuIFRoaXMgcHJvYmFibHkgYWRkZWQgYml0IG9mIHJhbmRvbW5lc3Mg
SSB0aGluaywgCj4gd2hpY2ggaGVscGVkIGluIGJldHRlciBqb2IgZGlzdHJpYnV0aW9uLgoKTWht
LCB0aGF0IG1pZ2h0IG5vdCBiZSBhIGJhZCBpZGVhIGFmdGVyIGFsbC4gV2UgY291bGQgcmVuYW1l
IG51bV9qb2JzIAppbnRvIHNvbWV0aGluZyBsaWtlIGxpa2Ugc2NvcmUgYW5kIGRvIGEgKzEgaW4g
ZHJtX3NjaGVkX3JxX2FkZF9lbnRpdHkoKSAKYW5kIGEgLTEgaW4gZHJtX3NjaGVkX3JxX3JlbW92
ZV9lbnRpdHkoKS4KClRoYXQgc2hvdWxkIGhhdmUgcHJldHR5IG11Y2ggdGhlIGVmZmVjdCB3ZSB3
YW50IHRvIGhhdmUuCgo+IEkndmUgdXBkYXRlZCBteSBwcmV2aW91cyBSRkMgcGF0Y2ggd2hpY2gg
dXNlcyB0aW1lIGNvbnN1bWVkIGJ5IGVhY2ggCj4gc2NoZWQgZm9yIGxvYWQgYmFsYW5jZSB3aXRo
IGEgdHdpc3Qgb2YgaWdub3JpbmcgcHJldmlvdXNseSBzY2hlZHVsZWQgCj4gc2NoZWQvcnEuIExl
dCBtZSBrbm93IHdoYXQgZG8geW91IHRoaW5rLgoKSSBkaWRuJ3QgaGFkIHRpbWUgeWV0IHRvIHdy
YXAgbXkgaGVhZCBhcm91bmQgdGhhdCBpbiBkZXRhaWwsIGJ1dCBhdCAKbGVhc3Qgb2YgaGFuZCBM
dWJlbiBpcyByaWdodCB0aGF0IHRoZSBsb2NraW5nIGxvb2tzIHJlYWxseSBhd2t3YXJkLgoKQW5k
IEkgd291bGQgcmF0aGVyIGxpa2UgdG8gYXZvaWQgYSBsYXJnZXIgY2hhbmdlIGxpa2UgdGhpcyBm
b3IgYSBuaWNlIHRvIApoYXZlIGZvciB0ZXN0aW5nIGZlYXR1cmUuCgpSZWdhcmRzLApDaHJpc3Rp
YW4uCgo+Cj4KPiBSZWdhcmRzLAo+Cj4gTmlybW95Cj4KPj4KPj4gQ2hyaXN0aWFuLgo+Pgo+PgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
