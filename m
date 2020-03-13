Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9247AC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 18:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E9420674
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 18:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NbPDYV3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E9420674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE7B89C9A;
	Fri, 13 Mar 2020 18:06:05 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760048.outbound.protection.outlook.com [40.107.76.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B5B08972C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 18:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyL5kxghjUJSUpW9rm6W5vjpNuNNV9V9qKatGrpZEZAQ4oF8XBKGbnC/ZxiAIwbDGVTKlHmJCp5Fo4zE9avCdwsmC7MM0vi69V2V7fTMBojeOXNPbEv1wokTYhFut27A1yRE2M6z7XSlehEyUtHoCHMG6KdcOypo4TsWAfIeC/HcEhUS5nTLokbnIKYwQU9W0WJk1jI9bcV/vOFZCZq1kQ5Mn6N8hE2Y1ZY6BDyOhczGr4vI3QvFOP8gJe4oi7yvMx7ct5D+AF4nFCqebLgeuUq8gfVo8bWrNHR8Dxzuzg6Lk1XTT5dBeBECL8LUDo65qYvFkDO11L2LZ0AZchRmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llewgdke45fnD3KT77O231DzzYQTFijMHkzMwE+vSqU=;
 b=RXZPELnprm2496Vo4mcp1AgHi8z9J8zkTPl6mSjPX7+vCCft9bBaAM2MqZ1q9bsnwDSbQOew8RSoAZPE5veOLZJGUWJ2IKRp7l+ki5Ho5MNsBhqBtXYvH79cHUokhR5MF5jrUrFQIwXwJyFY2usG1JCK5LlgNCDqWWHq/FdEiNHQqVuLfgn5uelEbTARz7VE+utwtJ9jj6ngykURmHc0w/qosH06PwEa9edWGZ6v+i4U7wNA1VYj9PKtS0pSGDwgDAkWCzluwnwmk7UipO9wGmRAPtIkpwI7YeOMtytTn6YgflaeXGaluj7kYTHtX3qSgK48yzQY9tnWhXgSUkvt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llewgdke45fnD3KT77O231DzzYQTFijMHkzMwE+vSqU=;
 b=NbPDYV3iyrmw2/VQls7zYfkTZQ75DbxMb6xQqkVeRfl3NbNp4RTzuoOEdQnOftxlSEqUM08gmhzEgdk7B/WNT1tL29tUMMxae7VJWdQVnLZwjNjcubtvWi//pdAf0aGQA9tvXVK64jyT7daO6xHMMAiE/g3nDrdELda/KRXYjQQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB1241.namprd12.prod.outlook.com (2603:10b6:3:72::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Fri, 13 Mar 2020 18:06:03 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c%7]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 18:06:03 +0000
Subject: Re: [PATCH v4 2/2] drm/amdgpu: unref pt bo after job submit
To: Felix Kuehling <felix.kuehling@amd.com>, xinhui pan <xinhui.pan@amd.com>, 
 amd-gfx@lists.freedesktop.org
References: <20200313160933.10394-1-xinhui.pan@amd.com>
 <20200313160933.10394-3-xinhui.pan@amd.com>
 <2b38aa48-40c1-2830-0005-2ddca7672535@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0b809d9d-8e25-46c0-9799-09a36f15a37c@amd.com>
Date: Fri, 13 Mar 2020 19:05:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <2b38aa48-40c1-2830-0005-2ddca7672535@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::18) To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17 via Frontend Transport; Fri, 13 Mar 2020 18:06:01 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2dc18b39-286c-4da7-968b-08d7c7793130
X-MS-TrafficTypeDiagnostic: DM5PR12MB1241:|DM5PR12MB1241:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1241B6F67FB718FDDF7830D583FA0@DM5PR12MB1241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(199004)(8676002)(66476007)(36756003)(53546011)(2616005)(16526019)(66946007)(186003)(31696002)(86362001)(81156014)(2906002)(81166006)(8936002)(52116002)(31686004)(4326008)(478600001)(6666004)(66574012)(5660300002)(110136005)(6486002)(66556008)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1241;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LlqVE1lKbIj3dUWRcOJKYehhDnTZN3O7nk64d9icdRjQVOcpiCnjEYer7jyAXcj4HOd+zQB62Nozdz79Mgxr+IqsBgVOcEmG0q2TU3ohLcYVvLj9Shx6Q0sQ0JFqKO1E9+kYSvfUyoQXzg2GYCs3SGPRSkPKENIydQgLUiN3NpzcXpP8FtMAS7lIV/q8ozSSsIScV8CIirZHG8/6MF3MwWF5M0VrkDqoiUN+1H7G+X1P5B7WtmSQTqLFdBkg1hMqyLCxSNAuhrvLvtUT+X3hab8GfqxTnm5riS2RKx4c/giFLoI89WyIBmE1Iqv8W3urfXI49C7Hk9Wkum4Mm1wcFNMUiNj/v1t9+USAMOvry8jJOZY2r1w6hZj/1RQLL1mef+9m+z9s1XsqnX0WVcy8y/qKOJ/l8D65Ll6KLl7UQL1gvLuQgYm4UtoEaQyOG9iY
X-MS-Exchange-AntiSpam-MessageData: mBHxKfWQaYHsmrNUzA27xznESkfT+vQZ6nMkt8HSaWY4jh+2T7ZbjtdwGZO3pEm6g1AHRB+6LftfBMOqyLnqVOyY1wUtqc68A+s4/3EUEvotLAF+FTOdr6WSkBMpJf2CfHl66lAQSs1dQ869vY/Bsg216Bl8d1W7yw+CW9TYhbe9A/9hWKw5gIbIq+vQzknjdtP9h4hgfoBrDxms3mILIw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc18b39-286c-4da7-968b-08d7c7793130
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 18:06:03.0150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idRk2flirWqUnwvtafHaUZPmxXqaG9mVf5WdAqpT0Qpms0oqpKpJ+pLwgNMGFqUI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1241
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIHBhZ2UgdGFibGUgaXMgbm90IHVwZGF0ZWQgYW5kIHRoZW4gZnJlZWQuIEEgaGlnaGVyIGxl
dmVsIFBERSBpcyAKdXBkYXRlZCBhbmQgYmVjYXVzZSBvZiB0aGlzIHRoZSBsb3dlciBsZXZlbCBw
YWdlIHRhYmxlcyBpcyBmcmVlZC4KCldpdGhvdXQgdGhpcyBpdCBjb3VsZCBiZSB0aGF0IHRoZSBt
ZW1vcnkgYmFja2luZyB0aGUgZnJlZWQgcGFnZSB0YWJsZSBpcyAKcmV1c2VkIHdoaWxlIHRoZSBQ
REUgaXMgc3RpbGwgcG9pbnRpbmcgdG8gaXQuCgpSYXRoZXIgdW5saWtlbHkgdGhhdCB0aGlzIGNh
dXNlcyBwcm9ibGVtcywgYnV0IGJldHRlciBzYXZlIHRoYW4gc29ycnkuCgpSZWdhcmRzLApDaHJp
c3RpYW4uCgpBbSAxMy4wMy4yMCB1bSAxODozNiBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IFRo
aXMgc2VlbXMgd2VpcmQuIFRoaXMgbWVhbnMgdGhhdCB3ZSB1cGRhdGUgYSBwYWdlIHRhYmxlLCBh
bmQgdGhlbiAKPiBmcmVlIGl0IGluIHRoZSBzYW1lIGFtZGdwdV92bV91cGRhdGVfcHRlcyBjYWxs
PyBUaGF0IG1lYW5zIHRoZSB1cGRhdGUgCj4gaXMgcmVkdW5kYW50LiBDYW4gd2UgZWxpbWluYXRl
IHRoZSByZWR1bmRhbnQgUFRFIHVwZGF0ZSBpZiB0aGUgcGFnZSAKPiB0YWJsZSBpcyBhYm91dCB0
byBiZSBmcmVlZCBhbnl3YXk/Cj4KPiBSZWdhcmRzLAo+IMKgIEZlbGl4Cj4KPiBPbiAyMDIwLTAz
LTEzIDEyOjA5LCB4aW5odWkgcGFuIHdyb3RlOgo+PiBGcmVlIHBhZ2UgdGFibGUgYm8gYmVmb3Jl
IGpvYiBzdWJtaXQgaXMgaW5zYW5lLgo+PiBXZSBtaWdodCB0b3VjaCBpbnZhbGlkIG1lbW9yeSB3
aGlsZSBqb2IgaXMgcnVubmlnLgo+Pgo+PiB3ZSBub3cgaGF2ZSBpbmRpdmlkdWFsaXplZCBibyBy
ZXN2IGR1cmluZyBibyByZWxlYXNpbmcuCj4+IFNvIGFueSBmZW5jZXMgYWRkZWQgdG8gcm9vdCBQ
VCBibyBpcyBhY3R1YWxseSB1bnRlc3RlZCB3aGVuCj4+IGEgbm9ybWFsIFBUIGJvIGlzIHJlbGVh
c2luZy4KPj4KPj4gV2UgbWlnaHQgaGl0IGdtYyBwYWdlIGZhdWx0IG9yIG1lbW9yeSBqdXN0IGdv
dCBvdmVyd3JpdGVkLgo+Pgo+PiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgo+PiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
Pgo+PiBDYzogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4+IFNpZ25l
ZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMjQgKysrKysrKysrKysrKysr
KysrKysrLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIHzC
oCAzICsrKwo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+PiBp
bmRleCA3MzM5ODgzMTE5NmYuLjM0NmUyZjc1MzQ3NCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gQEAgLTkzNyw2ICs5MzcsMjEgQEAgc3RhdGljIGludCBh
bWRncHVfdm1fYWxsb2NfcHRzKHN0cnVjdCAKPj4gYW1kZ3B1X2RldmljZSAqYWRldiwKPj4gwqDC
oMKgwqDCoCByZXR1cm4gcjsKPj4gwqAgfQo+PiDCoCArc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2Zy
ZWVfem9tYmllX2JvKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+PiArwqDCoMKgwqDCoMKg
wqAgc3RydWN0IGFtZGdwdV92bSAqdm0pCj4+ICt7Cj4+ICvCoMKgwqAgc3RydWN0IGFtZGdwdV92
bV9wdCAqZW50cnk7Cj4+ICsKPj4gK8KgwqDCoCB3aGlsZSAoIWxpc3RfZW1wdHkoJnZtLT56b21i
aWVzKSkgewo+PiArwqDCoMKgwqDCoMKgwqAgZW50cnkgPSBsaXN0X2ZpcnN0X2VudHJ5KCZ2bS0+
em9tYmllcywgc3RydWN0IGFtZGdwdV92bV9wdCwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBiYXNlLnZtX3N0YXR1cyk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBsaXN0X2RlbCgmZW50
cnktPmJhc2Uudm1fc3RhdHVzKTsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2JvX3Vu
cmVmKCZlbnRyeS0+YmFzZS5iby0+c2hhZG93KTsKPj4gK8KgwqDCoMKgwqDCoMKgIGFtZGdwdV9i
b191bnJlZigmZW50cnktPmJhc2UuYm8pOwo+PiArwqDCoMKgIH0KPj4gK30KPj4gKwo+PiDCoCAv
KioKPj4gwqDCoCAqIGFtZGdwdV92bV9mcmVlX3RhYmxlIC0gZnJlIG9uZSBQRC9QVAo+PiDCoMKg
ICoKPj4gQEAgLTk0NSwxMCArOTYwLDkgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxsb2NfcHRz
KHN0cnVjdCAKPj4gYW1kZ3B1X2RldmljZSAqYWRldiwKPj4gwqAgc3RhdGljIHZvaWQgYW1kZ3B1
X3ZtX2ZyZWVfdGFibGUoc3RydWN0IGFtZGdwdV92bV9wdCAqZW50cnkpCj4+IMKgIHsKPj4gwqDC
oMKgwqDCoCBpZiAoZW50cnktPmJhc2UuYm8pIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGxpc3RfbW92
ZSgmZW50cnktPmJhc2Uudm1fc3RhdHVzLAo+PiArICZlbnRyeS0+YmFzZS5iby0+dm1fYm8tPnZt
LT56b21iaWVzKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGVudHJ5LT5iYXNlLmJvLT52bV9ibyA9
IE5VTEw7Cj4+IC3CoMKgwqDCoMKgwqDCoCBsaXN0X2RlbCgmZW50cnktPmJhc2Uudm1fc3RhdHVz
KTsKPj4gLcKgwqDCoMKgwqDCoMKgIGFtZGdwdV9ib191bnJlZigmZW50cnktPmJhc2UuYm8tPnNo
YWRvdyk7Cj4+IC3CoMKgwqDCoMKgwqDCoCBhbWRncHVfYm9fdW5yZWYoJmVudHJ5LT5iYXNlLmJv
KTsKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgwqDCoMKgwqAga3ZmcmVlKGVudHJ5LT5lbnRyaWVzKTsK
Pj4gwqDCoMKgwqDCoCBlbnRyeS0+ZW50cmllcyA9IE5VTEw7Cj4+IEBAIC0xNjI0LDYgKzE2Mzgs
NyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgCj4+IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsCj4+IMKgwqDCoMKgwqAgciA9IHZtLT51cGRhdGVfZnVuY3MtPmNv
bW1pdCgmcGFyYW1zLCBmZW5jZSk7Cj4+IMKgIMKgIGVycm9yX3VubG9jazoKPj4gK8KgwqDCoCBh
bWRncHVfdm1fZnJlZV96b21iaWVfYm8oYWRldiwgdm0pOwo+PiDCoMKgwqDCoMKgIGFtZGdwdV92
bV9ldmljdGlvbl91bmxvY2sodm0pOwo+PiDCoMKgwqDCoMKgIHJldHVybiByOwo+PiDCoCB9Cj4+
IEBAIC0yODA3LDYgKzI4MjIsNyBAQCBpbnQgYW1kZ3B1X3ZtX2luaXQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYsIAo+PiBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwKPj4gwqDCoMKgwqDCoCBJTklU
X0xJU1RfSEVBRCgmdm0tPmludmFsaWRhdGVkKTsKPj4gwqDCoMKgwqDCoCBzcGluX2xvY2tfaW5p
dCgmdm0tPmludmFsaWRhdGVkX2xvY2spOwo+PiDCoMKgwqDCoMKgIElOSVRfTElTVF9IRUFEKCZ2
bS0+ZnJlZWQpOwo+PiArwqDCoMKgIElOSVRfTElTVF9IRUFEKCZ2bS0+em9tYmllcyk7Cj4+IMKg
IMKgIMKgwqDCoMKgwqAgLyogY3JlYXRlIHNjaGVkdWxlciBlbnRpdGllcyBmb3IgcGFnZSB0YWJs
ZSB1cGRhdGVzICovCj4+IEBAIC0zMTE5LDYgKzMxMzUsOCBAQCB2b2lkIGFtZGdwdV92bV9maW5p
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCAKPj4gc3RydWN0IGFtZGdwdV92bSAqdm0pCj4+
IMKgwqDCoMKgwqAgfQo+PiDCoCDCoMKgwqDCoMKgIGFtZGdwdV92bV9mcmVlX3B0cyhhZGV2LCB2
bSwgTlVMTCk7Cj4+ICvCoMKgwqAgYW1kZ3B1X3ZtX2ZyZWVfem9tYmllX2JvKGFkZXYsIHZtKTsK
Pj4gKwo+PiDCoMKgwqDCoMKgIGFtZGdwdV9ib191bnJlc2VydmUocm9vdCk7Cj4+IMKgwqDCoMKg
wqAgYW1kZ3B1X2JvX3VucmVmKCZyb290KTsKPj4gwqDCoMKgwqDCoCBXQVJOX09OKHZtLT5yb290
LmJhc2UuYm8pOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmggCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgKPj4g
aW5kZXggYjU3MDVmY2ZjOTM1Li45YmFmNDRmYTE2ZjAgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92bS5oCj4+IEBAIC0yNjksNiArMjY5LDkgQEAgc3RydWN0IGFtZGdw
dV92bSB7Cj4+IMKgwqDCoMKgwqAgLyogQk8gbWFwcGluZ3MgZnJlZWQsIGJ1dCBub3QgeWV0IHVw
ZGF0ZWQgaW4gdGhlIFBUICovCj4+IMKgwqDCoMKgwqAgc3RydWN0IGxpc3RfaGVhZMKgwqDCoCBm
cmVlZDsKPj4gwqAgK8KgwqDCoCAvKiBCTyB3aWxsIGJlIGZyZWVkIHNvb24gKi8KPj4gK8KgwqDC
oCBzdHJ1Y3QgbGlzdF9oZWFkwqDCoMKgIHpvbWJpZXM7Cj4+ICsKPj4gwqDCoMKgwqDCoCAvKiBj
b250YWlucyB0aGUgcGFnZSBkaXJlY3RvcnkgKi8KPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1
X3ZtX3B0wqDCoMKgwqAgcm9vdDsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgZG1hX2ZlbmNlwqDCoMKg
ICpsYXN0X3VwZGF0ZTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
