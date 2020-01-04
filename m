Return-Path: <SRS0=l1g4=2Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030C6C2D0C2
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jan 2020 16:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B020D2464E
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jan 2020 16:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="POYP7pTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B020D2464E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E2E789DB9;
	Sat,  4 Jan 2020 16:03:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F1E989DB9
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jan 2020 16:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXGEyaKYHcZHpSvwW38BcQbBWXtGJsCbMFbjJBQ5+cLV6bAEC+0J41WGX3PWytsen1jDJsAgQllueR0sqhZVnKJpElF8kvZ2l8iEnT7NbDZ5O23O98DVAxkbKbrrHxToEtCxRILYmfUtiRlHNUFe0Jy+5sYUd3jHJ3DI2Jg2BaMAIALB+m3XoI0ZfZOezy72CJ0QO/d2s4y/ScQ1lXJA/ukAxSGWLsI0F7dNCpg1/2Fyuy0KlIvj5rHKVpeI8R7x2uikLYw7n/5hJPgj1AHunFzksq0RX4nQV9I36ZQqO85xOVUFvdeTQZf0awM9BI4a1lMFTPmucFvauzeoZA/xNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp+n0IuM0E3M3Ljq545c48kFVFgBgebbdJ9HaxprT4Y=;
 b=bC6iwfMjUkX0KdJZoKgTFjkC5SL19+lFABt2b8La9jJTCYVE3iIyc/VVI0y/qC4Eh4jvKjbqsbKLbGJTYXJRgkdfegEydZFolFWnRlaYspduKVUBGDRlg/Hox0yPmmnEOAVhakFYnJzfFQEBMj6GNqXvsGvV/JJZaPeTNFThnlk97O8SsQasht6SFPzx/oEg5M3JOT/Lsxf8vfqE4oikNRLMRCfKxijwB7N/4hbMoEihffNrVAz2qs3So6m6YPPqbznKtwjHrOeK/lb0zt3j8oHSnaeodCa41iMlE5zF48fvU3U6dLJXeJkaAd+aGd2tomrOHJGIP5TS6WvAEKd1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp+n0IuM0E3M3Ljq545c48kFVFgBgebbdJ9HaxprT4Y=;
 b=POYP7pTE5DaoojDjso/kSn4dg/TCa/4xYr6ssW+CJTpf62+L4Mo4Pl1jXuDZe0IvUhZ8X1jZL++QBaZ3G5GUmcH5kRWF72NjYsmalYHg3YiGgUp93bC5LOFNvVfp32xBWfVa2Rq7bi6XRjqKsmoCFBf5re7/37CtDLhZx9PzptE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1243.namprd12.prod.outlook.com (10.168.237.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Sat, 4 Jan 2020 16:03:51 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2602.015; Sat, 4 Jan 2020
 16:03:51 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu: immedially invalidate PTEs
To: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20191205133940.3865-1-christian.koenig@amd.com>
 <20191205133940.3865-5-christian.koenig@amd.com>
 <afc4a884-dc56-867e-580c-7845e7de2257@amd.com>
 <98ce952f-f52d-bf60-00b3-d984b7c2184d@gmail.com>
 <SN6PR12MB26214131AB40026EB0D05382FD230@SN6PR12MB2621.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5132893a-88b9-0b77-f897-27cf4bc0cc5b@amd.com>
Date: Sat, 4 Jan 2020 17:03:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <SN6PR12MB26214131AB40026EB0D05382FD230@SN6PR12MB2621.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0043.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::12) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZR0P278CA0043.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Sat, 4 Jan 2020 16:03:49 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 40cfd91d-33b0-488a-f09b-08d7912fb067
X-MS-TrafficTypeDiagnostic: DM5PR12MB1243:|DM5PR12MB1243:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1243F66F7968D525AAC10CA383220@DM5PR12MB1243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02723F29C4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(13464003)(43544003)(54094003)(199004)(189003)(5660300002)(6636002)(478600001)(36756003)(6486002)(966005)(8676002)(81166006)(81156014)(8936002)(31696002)(52116002)(110136005)(2906002)(2616005)(86362001)(66946007)(31686004)(53546011)(66574012)(16526019)(186003)(6666004)(66556008)(66476007)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1243;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agC9O5etTrSaJn4r6jJM2fUGGtTJdpjwtkWb2tPkUTGVbnHh1WEvjvihfDFnYQOSBuJqAxPMI19F/OLQkbDXzuo/5g/rIahv2YsLCJERLqEE8nTi6AlyGsczSenTH+77uCcjvWuPzasIbSVxfPz7qMaW2m1ptNxJi/gCNF23XghpCJ6e81rkKm/y6DxbGw36AaaJtQZOejJ0RdyDrnOgOi+PK2YrOdBov/HWbBmE9unZtikEj05I0BaOrvpj9ocTDP/1W/7xT4dL9/sljWFan1aq0KmWRWZatGaas+r2LVVY5B/jmU/A58+1yUGj4Vh6CSWLaOIFc2Zq2cYUXky2jza6gV8LTXJAuE0fB2K9Z1kBvqAkvk2wwd6ASTYgzCX8c6NRKZ/qQ4SjJHDa0RMkBvkfLDhravnuO74naTfY10J1sGHtTTXxh2+cSa1efl6wAGitK9iXy4SwdTQtgZPbxsro+9nOzO0fi1t0tN53TNDomaDXkVijy7XQEplQwKo4CGJwe59dDVPRZ9yc8gJTvh5YfAqh+xDMuzJkp8mVaQG6yVRU57+8zzD8pobvYHmKxfh+s7aGxhABsUh7olAaUg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cfd91d-33b0-488a-f09b-08d7912fb067
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2020 16:03:51.0874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scDJeFinfcsArglMPU1zA1DLWke5qkVOZrtiej65h7dtgtOjo/VMLCzgXg+Zf7z4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1243
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQWxlamFuZHJvLAoKeWVzIEkndmUgaW1wbGVtZW50ZWQgdGhpcywgYnV0IEknbSBzdGlsbCBo
dW50aW5nIGRvd24gc29tZSBidWdzIHdpdGggdGhlIApuZXcgbG9ja3MuCgpJIHdpbGwgc2VuZCBv
dXQgdGhlIHBhdGNoZXMgb24gTW9uZGF5IGV2ZW4gaWYgSSBjYW4ndCBuYXJyb3cgdGhhdCAKcHJv
YmxlbSBkb3duIGZ1cnRoZXIuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgpBbSAwMy4wMS4yMCB1bSAw
NToyMCBzY2hyaWViIFNpZXJyYSBHdWl6YSwgQWxlamFuZHJvIChBbGV4KToKPiBbQU1EIE9mZmlj
aWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4KPiBIaSBDaHJpc3Rp
YW4sCj4gSSB3b25kZXIgaWYgeW91IGhhZCBhIGNoYW5jZSB0byBsb29rIGludG8gdGhpcyB3YXJu
aW5nLgo+IFBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSdzIHNvbWV0aGluZyB3ZSBjb3VsZCBo
ZWxwIHdpdGguCj4KPiBSZWdhcmRzLAo+IEFsZWphbmRybwo+Cj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0KPiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2Vu
QGdtYWlsLmNvbT4KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMTIsIDIwMTkgMjo1MiBBTQo+
IFRvOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgWWFuZywgUGhpbGlwIDxQaGlsaXAuWWFuZ0BhbWQuY29tPjsg
U2llcnJhIEd1aXphLCBBbGVqYW5kcm8gKEFsZXgpIDxBbGV4LlNpZXJyYUBhbWQuY29tPgo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggNS81XSBkcm0vYW1kZ3B1OiBpbW1lZGlhbGx5IGludmFsaWRhdGUg
UFRFcwo+Cj4gW0NBVVRJT046IEV4dGVybmFsIEVtYWlsXQo+Cj4gSGkgRmVsaXgsCj4KPiB5ZWFo
LCBJJ3ZlIGFsc28gZm91bmQgYSBjb3JuZXIgY2FzZSB3aGljaCB3b3VsZCByYWlzZSBhIHdhcm5p
bmcgbm93Lgo+Cj4gTmVlZCB0byByZXdvcmsgaG93IGRlcGVuZGVuY2llcyBmb3IgdGhlIFBURSB1
cGRhdGUgYXJlIGdlbmVyYXRlZC4KPgo+IEdvaW5nIHRvIHRha2UgY2FyZSBvZiB0aGlzIGluIHRo
ZSBuZXh0IGZldyBkYXlzLCBDaHJpc3RpYW4uCj4KPiBBbSAxMi4xMi4xOSB1bSAwMToyMCBzY2hy
aWViIEZlbGl4IEt1ZWhsaW5nOgo+PiBIaSBDaHJpc3RpYW4sCj4+Cj4+IEFsZXggc3RhcnRlZCB0
cnlpbmcgdG8gaW52YWxpZGF0ZSBQVEVzIGluIHRoZSBNTVUgbm90aWZpZXJzIGFuZCB3ZSdyZQo+
PiBmaW5kaW5nIHRoYXQgd2Ugc3RpbGwgbmVlZCB0byByZXNlcnZlIHRoZSBWTSByZXNlcnZhdGlv
biBmb3IKPj4gYW1kZ3B1X3N5bmNfcmVzdiBpbiBhbWRncHVfdm1fc2RtYV9wcmVwYXJlLiBJcyB0
aGF0IHN5bmNfcmVzdiBzdGlsbAo+PiBuZWVkZWQgbm93LCBnaXZlbiB0aGF0IFZNIGZlbmNlcyBh
cmVuJ3QgaW4gdGhhdCByZXNlcnZhdGlvbiBvYmplY3QgYW55Cj4+IG1vcmU/Cj4+Cj4+IFJlZ2Fy
ZHMsCj4+ICAgIEZlbGl4Cj4+Cj4+IE9uIDIwMTktMTItMDUgNTozOSwgQ2hyaXN0aWFuIEvDtm5p
ZyB3cm90ZToKPj4+IFdoZW4gYSBCTyBpcyBldmljdGVkIGltbWVkaWFsbHkgaW52YWxpZGF0ZSB0
aGUgbWFwcGVkIFBURXMuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDE3ICsrKysrKysrKysrKysrKystCj4+PiAgICAxIGZp
bGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4KPj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4gYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4gaW5kZXggODM5ZDZkZjM5NGZj
Li5lNTc4MTEzYmZkNTUgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMKPj4+IEBAIC0yNTY1LDYgKzI1NjUsNyBAQCB2b2lkIGFtZGdwdV92bV9ib19pbnZhbGlk
YXRlKHN0cnVjdAo+Pj4gYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+ICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IGFtZGdwdV9ibyAqYm8sIGJvb2wgZXZpY3RlZCkKPj4+ICAgIHsKPj4+ICAgICAg
ICBzdHJ1Y3QgYW1kZ3B1X3ZtX2JvX2Jhc2UgKmJvX2Jhc2U7Cj4+PiArICAgIGludCByOwo+Pj4g
ICAgICAgICAgLyogc2hhZG93IGJvIGRvZXNuJ3QgaGF2ZSBibyBiYXNlLCBpdHMgdmFsaWRhdGlv
biBuZWVkcyBpdHMKPj4+IHBhcmVudCAqLwo+Pj4gICAgICAgIGlmIChiby0+cGFyZW50ICYmIGJv
LT5wYXJlbnQtPnNoYWRvdyA9PSBibykgQEAgLTI1NzIsOCArMjU3MywyMgo+Pj4gQEAgdm9pZCBh
bWRncHVfdm1fYm9faW52YWxpZGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+ICAg
ICAgICAgIGZvciAoYm9fYmFzZSA9IGJvLT52bV9ibzsgYm9fYmFzZTsgYm9fYmFzZSA9IGJvX2Jh
c2UtPm5leHQpIHsKPj4+ICAgICAgICAgICAgc3RydWN0IGFtZGdwdV92bSAqdm0gPSBib19iYXNl
LT52bTsKPj4+ICsgICAgICAgIHN0cnVjdCBkbWFfcmVzdiAqcmVzdiA9IHZtLT5yb290LmJhc2Uu
Ym8tPnRiby5iYXNlLnJlc3Y7Cj4+PiArCj4+PiArICAgICAgICBpZiAoYm8tPnRiby50eXBlICE9
IHR0bV9ib190eXBlX2tlcm5lbCkgewo+Pj4gKyAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfYm9f
dmEgKmJvX3ZhOwo+Pj4gKwo+Pj4gKyAgICAgICAgICAgIGJvX3ZhID0gY29udGFpbmVyX29mKGJv
X2Jhc2UsIHN0cnVjdCBhbWRncHVfYm9fdmEsCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg
IGJhc2UpOwo+Pj4gKyAgICAgICAgICAgIHIgPSBhbWRncHVfdm1fYm9fdXBkYXRlKGFkZXYsIGJv
X3ZhLAo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgIGJvLT50Ym8uYmFzZS5yZXN2ICE9IHJl
c3YpOwo+Pj4gKyAgICAgICAgICAgIGlmICghcikgewo+Pj4gKyAgICAgICAgICAgICAgICBhbWRn
cHVfdm1fYm9faWRsZShib19iYXNlKTsKPj4+ICsgICAgICAgICAgICAgICAgY29udGludWU7Cj4+
PiArICAgICAgICAgICAgfQo+Pj4gKyAgICAgICAgfQo+Pj4gICAgLSAgICAgICAgaWYgKGV2aWN0
ZWQgJiYgYm8tPnRiby5iYXNlLnJlc3YgPT0KPj4+IHZtLT5yb290LmJhc2UuYm8tPnRiby5iYXNl
LnJlc3YpIHsKPj4+ICsgICAgICAgIGlmIChldmljdGVkICYmIGJvLT50Ym8uYmFzZS5yZXN2ID09
IHJlc3YpIHsKPj4+ICAgICAgICAgICAgICAgIGFtZGdwdV92bV9ib19ldmljdGVkKGJvX2Jhc2Up
Owo+Pj4gICAgICAgICAgICAgICAgY29udGludWU7Cj4+PiAgICAgICAgICAgIH0KPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGlu
ZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
