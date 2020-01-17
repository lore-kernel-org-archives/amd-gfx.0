Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441ADC33CB1
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 17:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E6F206D7
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 17:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YuzbsAKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E6F206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B2D6F639;
	Fri, 17 Jan 2020 17:07:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 441486F639
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 17:07:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W95QuwD39TfeklMXjS+anmwCMb8eWoYNRHYas2c9Ud008/KteJf56MU1G/YTNqKIHcf0gDkocPKyM0J6y/265Lpp+OZaA8V/LV1JyXAoEDgAFsOqNqqtJiFJfDTThju8kDQ5fZWX8hUEGxols+OYFy9avlvoXoqhabuRPZz4EgMMgt7wiORpR7RQeT+vxB/4vaNYVFjYsrmupE7gdNQX4GTvhktftkOB0HSdH6gNrF3EiD6IuhmXLifHg6/PLNEZSJ4grrV0s89zx+4g8FjA6OZfz+ZEVvGELtnKIgkHnwQGPbcnpqJCi8RWLeL349cnSj/sN0jGvinb95K/0USCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kE1sNhrwsaiaUxKPtzxX0p+9J7tTPa7VV66bD+bBE+M=;
 b=gHMUS4ceJhtHcjhWnh37Lx/UIc3GjtIA7eeA9QJ9TVJkKik1ExG8cObGT2VBTl1/Bx9XVot+EKV5LsQ9qwLSCsAhWksNVr94NSXIorPLraHCawfV8V49rKmsxe9d28lnk3ln3xu3/pCOOWwUWpvXCx0N2rahfJPZrlKW7X/LCRu0wgLWJRoGiXkKpOHpVPeGzKbCbm+Ax0iZWQfYsdOby1AERDSrsYz8wVgF9uq94KF8ja95fVCy9h64N2IIoHAOFR6JxxkA/ijoWnFlRsSUHMWXzTVGote+dxEtSjTgPpP/3TGWeT579Fq6DOe+CYq8RG6WJw2ieb8kdZ7U69JlSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kE1sNhrwsaiaUxKPtzxX0p+9J7tTPa7VV66bD+bBE+M=;
 b=YuzbsAKjRAKuT4gUk7ZtdpTMiiGYKQu506GMmu3EzCAjNuj0VP7xkA4XOgINXFtqfsyTT4fD3cr75APfNugdkhbym/okU7aUUrFrQ0/RmNgmJsWh/AeW21iG2fmL/sOounYL1l5UpusCnZy9PTuNw4Olrho4pbaj0tKq9JT0uI4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0074.namprd12.prod.outlook.com (10.174.107.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Fri, 17 Jan 2020 17:07:43 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 17:07:43 +0000
Subject: Re: [PATCH] drm/amdgpu: add coreboot workaround for KV/KB
To: christian.koenig@amd.com, fredrik.bruhn@unibap.com,
 amd-gfx@lists.freedesktop.org
References: <20200116130907.22410-1-christian.koenig@amd.com>
 <c5aa1227-adc0-f7d0-1786-deec7ca681c1@amd.com>
 <3c1b6bea-d5bc-0532-9805-2eb2c1003653@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <2f992eda-75c8-570b-fc77-584ad4959168@amd.com>
Date: Fri, 17 Jan 2020 12:07:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <3c1b6bea-d5bc-0532-9805-2eb2c1003653@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::20) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Fri, 17 Jan 2020 17:07:43 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 88a9f5ca-b4e3-4171-b1df-08d79b6fc44b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0074:|DM5PR1201MB0074:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB007440B11228B13588334F2C92310@DM5PR1201MB0074.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0285201563
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39850400004)(346002)(376002)(366004)(189003)(199004)(66556008)(66476007)(2906002)(478600001)(6486002)(66946007)(36756003)(16576012)(316002)(45080400002)(53546011)(81156014)(66574012)(8676002)(81166006)(36916002)(31696002)(86362001)(52116002)(31686004)(8936002)(16526019)(186003)(26005)(2616005)(5660300002)(956004)(44832011)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0074;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zx9+xA5G1nkI2hmJbuYYZbrMOIw7Cye8Ho5ISIfVKAbbQ2zdxsu7hRap5c2gljVcqrlLzetUeIQZCI8G36rKnZsFf6IZLDiyn8XRiFFQLvsK9eReihNQ00mYib9MAlKTCQftYOPU293NiKGEZ/Y7DF0DFhXE1e+s2QuNIWo2kNmeSN/ScK5eo3Y5Q8lH3uDhDSIOrHBZM/sstB7/EZelGM5PL8cmIFod4LqwkOp7c0Lv3tI/Be5ksW9hVe85ICKnIh2rkykw9W+OlU01zhzraGswTUlFYolx11YgUGbJQVw5Q1RUML8l/Ga3zKIky+hZf6ubAOWP6FnHwdRGttJYT0KxGwBUgJlfVPf5/gbclPnoTux/CN+7Wk26J6BOlKhJGNPM1jCIeVxMKNbrxYOnu+4Z0LB0OkTRfSToFYUapDjOQgfCc6IJjacWNg7v6wgh/sOm6mhWObH+MAzxQzjjeW0sdS7ZMb8V1iUiLt+fug4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a9f5ca-b4e3-4171-b1df-08d79b6fc44b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 17:07:43.5203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Heu2xkS7ikR/TDrHa3QZyXJo0XOFrDjHIrvVNIUnOVvKNCMDRd29rsmWMe0apmQXVRz2fp910ZRlmnfoXNJmKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0074
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

T24gMjAyMC0wMS0xNyAzOjE3IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTcu
MDEuMjAgdW0gMDM6MDEgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPj4gT24gMjAyMC0wMS0xNiA4
OjA5LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4gQ29yZWJvb3Qgc2VlbXMgdG8gaGF2ZSBh
IHByb2JsZW0gY29ycmVjdGx5IHNldHRpbmcgdXAgYWNjZXNzIHRvIHRoZSAKPj4+IHN0b2xlbiBW
UkFNCj4+PiBvbiBLVi9LQi4gVXNlIHRoZSBkaXJlY3QgYWNjZXNzIG9ubHkgd2hlbiBuZWNlc3Nh
cnkuCj4+Cj4+IEknbSBub3Qgc3VyZSB3aGF0IHlvdSBtZWFuIGJ5ICJuZWNlc3NhcnkiLgo+Cj4g
TmVjZXNzYXJ5IGZvciBiZXR0ZXIgcGVyZm9ybWFuY2UuCgpSaWdodC4gU28geW91ciBwYXRjaCBk
ZXNjcmlwdGlvbiBzYXlzIHRoYXQgc29tZXRpbWVzIGJldHRlciBwZXJmb3JtYW5jZSAKaXMgbm90
IG5lY2Vzc2FyeS4gVGhlIGNyaXRlcmlhIGlzIGJhc2VkIG9uIHRoZSBzaXplIG9mIHRoZSBCQVIs
IHdoaWNoIApkb2Vzbid0IHJlYWxseSBoYXZlIGFueXRoaW5nIHRvIGRvIHdpdGggcGVyZm9ybWFu
Y2UuCgoKPgo+Pgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y3XzAuYyB8IDMgKystCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dtY192N18wLmMgCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192N18wLmMKPj4+IGluZGV4IDE5ZDViMTMzZTFkNy4uOWRhOTU5NmEzNjM4IDEwMDY0NAo+
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y3XzAuYwo+Pj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y3XzAuYwo+Pj4gQEAgLTM4MSw3ICszODEs
OCBAQCBzdGF0aWMgaW50IGdtY192N18wX21jX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgCj4+
PiAqYWRldikKPj4+IMKgwqDCoMKgwqAgYWRldi0+Z21jLmFwZXJfc2l6ZSA9IHBjaV9yZXNvdXJj
ZV9sZW4oYWRldi0+cGRldiwgMCk7Cj4+PiDCoCDCoCAjaWZkZWYgQ09ORklHX1g4Nl82NAo+Pj4g
LcKgwqDCoCBpZiAoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKSB7Cj4+PiArwqDCoMKgIGlmIChh
ZGV2LT5mbGFncyAmIEFNRF9JU19BUFUgJiYKPj4+ICvCoMKgwqDCoMKgwqDCoCBhZGV2LT5nbWMu
cmVhbF92cmFtX3NpemUgPiBhZGV2LT5nbWMuYXBlcl9zaXplKSB7Cj4+Cj4+IENQVSBhY2Nlc3Mg
dG8gdGhlIHdob2xlIFZSQU0gaXNuJ3QgcmVhbGx5IG5lY2Vzc2FyeS4gSSB0aG91Z2h0IHRoZSAK
Pj4gbWFpbiBtb3RpdmF0aW9uIGZvciBhY2Nlc3NpbmcgRkIgZGlyZWN0bHkgb24gQVBVcyB3YXMg
YmV0dGVyIAo+PiBwZXJmb3JtYW5jZS4gWW91J3JlIGRpc2FibGluZyB0aGF0IG9wdGltaXphdGlv
biBvbiBhbGwgQVBVcyB3aGVyZSB0aGUgCj4+IEZCIGlzIHNtYWxsZXIgdGhhbiB0aGUgYXBlcnR1
cmUgc2l6ZS4KPgo+IENvcnJlY3QsIHllcy4gRm9yIHNvbWUgcmVhc29uIGNvcmVib290IHNlZW1z
IHRvIGV4cGxpY2l0bHkgc2V0dXAgdGhlIAo+IG1lbW9yeSB1c2VkIGZvciB0aGUgRkIgYXMgd3Jp
dGUtcHJvdGVjdGVkLgo+Cj4gVGhlIEdQVSBjYW4gc3RpbGwgcmVhZC93cml0ZSBpdCBub3JtYWxs
eSBjYXVzZSBpdCBpZ25vcmVzIHRoYXQgCj4gcHJvdGVjdGlvbiwgYnV0IHRoZSBDUFUgY2FuJ3Qg
Y2hhbmdlIHRoZSBGQiBtZW1vcnkgYW55IG1vcmUgd2l0aCB0aGF0IAo+IHNldHVwLgoKQ2FuIHdl
IHRlc3Qgd2hldGhlciB3cml0aW5nIHRvIEZCIHdvcmtzIGFuZCBtYWtlIHRoZSBkZWNpc2lvbiBi
YXNlZCBvbiB0aGF0PwoKVGhhbmtzLAogwqAgRmVsaXgKCj4KPiBObyBpZGVhIHdoeSB0aGV5IGRv
IHRoaXMsIG1vc3QgbGlrZWx5IGp1c3QgYW4gb3ZlciBjb25zZXJ2YXRpdmUgCj4gcHJvdGVjdGlv
biBvZiBhIHJlc2VydmVkIGFyZWEgb2YgbWVtb3J5Lgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4u
Cj4KPj4KPj4gUmVnYXJkcywKPj4gwqAgRmVsaXgKPj4KPj4KPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBhZGV2LT5nbWMuYXBlcl9iYXNlID0gKCh1NjQpUlJFRzMyKG1tTUNfVk1fRkJfT0ZGU0VUKSkg
PDwgMjI7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYWRldi0+Z21jLmFwZXJfc2l6ZSA9IGFkZXYt
PmdtYy5yZWFsX3ZyYW1fc2l6ZTsKPj4+IMKgwqDCoMKgwqAgfQo+PiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+
PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL25hbTExLnNhZmVsaW5r
cy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVz
a3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDEl
N0NmZWxpeC5rdWVobGluZyU0MGFtZC5jb20lN0NkNTk0OTBmMGU3ZjU0N2QzYTNmYzA4ZDc5YjI1
YmVkNCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxNDg0
NTg3NTk2NTg2MTcmYW1wO3NkYXRhPVRvOWZzRUh2UTRkb2taS1N3VFpRN1Y4TElSRUElMkJqNThv
dXZhVVZ0SGZwSSUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4KPgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
