Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB3BC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BAA206FA
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t4g2LiEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BAA206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA96D6EBE3;
	Fri, 13 Mar 2020 14:20:51 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 487CD6EBDB
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 14:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4YhTQjBSmg3wA8GTr2lJd47gl+hnVCu3oupL/rJszg7l880p4Om1wgjwvFgFcOJzI16eobqAWSFRXAvcuaZCTKqbAYQeUkCIq/0TetHpO8WeStxIYnFv7vEEWLjy3GO3ZaUPun9i8ZHfLEfiFE6sqw/XR1ILtFeT5Pg7NKt9WzLjj9MuDKekPPq9HYfFI6G7YomnndFDp9uQuycmWH4IES/reJQvsUJt0+ZdZYDdKyJMMSpZeyh0q6+c+pPTXjrwVD+ScEsOeWyUp02HZaFabgB4l/mKhyzMbadLnfHtN8QrcQRmjsQrkxcJyrQOQrVykhSJvzljkh13jldpZi1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mvbw00eaIMLeKKZjGVFNeYdqodQPaRbopwNL4oc1HS0=;
 b=T5v7RdskRQZbmhuzQ4D2/cpGcfuVJQP54sGkL1rBDljcj0GPq6sOtUdKCaLQ2tOhd3in/5vHc8ypctR0DkbLj+G4rn0oFGUKVNLGI7FMJVWvCvffLerE+6PPP7w/YPoOEbohwswX8ZbElOTQ3fxgxh+NFsIaMgOnyksCyo4n6ziiXJp8snEmf1kjuzNy1ONRe8rN5GiXPxisxXlSW7YHQvf3bYVDvqdjqj7jv1542urXRsUi6s7hP63Etq1mxwTP7af0Hd66CMltOxRlQevgt5C2B2RobDuznOJoXplloWjQA830lQcLvHMm/T7kePR6iueor3q1N4pyIVwCKTF+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mvbw00eaIMLeKKZjGVFNeYdqodQPaRbopwNL4oc1HS0=;
 b=t4g2LiEdlKb5aDcTPUwUY9CCMLvAV0qtJwkNjEisz1RmKHOYtRTYQJKthcd5mMqARExyaKxc28wMz3ZK04qg3u6YC5ZXEWX7q/9qNWWSgLarpkruKU2vpwDBlMk0DWshdmhitGdvNP8ZMRVtXQKONPHTJmeq1vXdvhuKJDI0jgc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16; Fri, 13 Mar 2020 14:20:49 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c%7]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 14:20:49 +0000
Subject: Re: [PATCH v3 2/2] drm/amdgpu: unref the bo after job submit
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200313140758.6607-1-xinhui.pan@amd.com>
 <20200313140758.6607-3-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <cb5459d4-2e17-0259-2dd8-1f787a762d6b@amd.com>
Date: Fri, 13 Mar 2020 15:20:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200313140758.6607-3-xinhui.pan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:e6::35) To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR01CA0058.eurprd01.prod.exchangelabs.com (2603:10a6:208:e6::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend
 Transport; Fri, 13 Mar 2020 14:20:47 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0e25557-0843-4d6c-02c1-08d7c759ba50
X-MS-TrafficTypeDiagnostic: DM5PR12MB1884:|DM5PR12MB1884:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1884E0BB160A3BD4D821EEF483FA0@DM5PR12MB1884.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(199004)(6666004)(54906003)(316002)(8936002)(66574012)(52116002)(8676002)(81156014)(81166006)(31686004)(478600001)(2906002)(5660300002)(186003)(36756003)(4326008)(66556008)(66946007)(66476007)(2616005)(86362001)(31696002)(6486002)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1884;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJ04qi8TorLudO5ZcojN4IQD42/ilyGPb+wWpIhs4MDn14FaJXk22kCaYXGgJOydhF9gMsucAlRrtsNu/JKMa9TsNuBhG0/FgR0x8iSVR4O81xkkvp1N9w0JDXkcNG+NX5qLmaXPksbx47LFTr80n9GG1yl8lBMtcPsaityWaoveQ8GE9vxmfaZmveJA7WWinhWsmpTiH0TFHFvYmhOu9bpQBXHQK12aUaxspiFbKxpewi4Jgjs3bV+/8s9Q2s2E83XEeOwNrMQxPYv6WEQzDo3IHLeesXcYq6k+zoktAgTOv1CZYEElL/MsmwlnkPKjx93WLuYSBXIMLj9amEVK46qnflFvYEOEjFqC44BfsjlhfPVTVPcjAbwcUWOkwhzRiJjEQuuAHiMTLhBYF5OawdV34+tlZIr6eKYjDfKTBEbwTqENVzVpBFp+KyMUM+PR
X-MS-Exchange-AntiSpam-MessageData: erWAwGEPlKZ8VyGwa9IN0y1p9Mg868sbzIk3vMHH/x/rdlIB4sWMfN15N5cvThpGxmE1gfCj9jz/W/89sXfOxKuUJwFMD3IsZQoLV3z6OCPobAM9UOdiSWTczINQRSMXUR03KMr6FO07SWB3CHRYq6pndM+LVetloIkEirtabcyKiFgAe/T1jHUkxAzJHezMPJ5ZI+OHkjtqCcs7IsRQvQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e25557-0843-4d6c-02c1-08d7c759ba50
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 14:20:49.0316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5jPbqdSInwMrWKqnPMuhaG7SDwtTNLd0A9tiLlOnQbuhYCfBlogaL+wGuJG2rxb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1884
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

QW0gMTMuMDMuMjAgdW0gMTU6MDcgc2NocmllYiB4aW5odWkgcGFuOgo+IE90aGVyd2lzZSB3ZSBt
aWdodCBmcmVlIEJPcyBiZWZvcmUgam9iIGhhcyBjb21wbGV0ZWQuCj4gV2UgYWRkIHRoZSBmZW5j
ZSB0byBCTyBhZnRlciBjb21taXQsIHNvIGZyZWUgQk9zIGFmdGVyIHRoYXQuCgpJJ20gbm90IHN1
cmUgaWYgdGhpcyBpcyBuZWNlc3NhcnksIGJ1dCBwcm9iYWJseSBiZXR0ZXIgc2F2ZSB0aGFuIHNv
cnJ5LgoKU29tZSBjb21tZW50cyBiZWxvdy4KCj4KPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Cj4gQ2M6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29t
Pgo+IFNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5AYW1kLmNvbT4KPiAtLS0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMzggKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAx
MCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4g
aW5kZXggODA5Y2E2ZThmNDBmLi42MDVhMWJiNDAyODAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC05NDIsMTMgKzk0MiwxNyBAQCBzdGF0aWMgaW50IGFt
ZGdwdV92bV9hbGxvY19wdHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAgKgo+ICAg
ICogQGVudHJ5OiBQREUgdG8gZnJlZQo+ICAgICovCj4gLXN0YXRpYyB2b2lkIGFtZGdwdV92bV9m
cmVlX3RhYmxlKHN0cnVjdCBhbWRncHVfdm1fcHQgKmVudHJ5KQo+ICtzdGF0aWMgdm9pZCBhbWRn
cHVfdm1fZnJlZV90YWJsZShzdHJ1Y3QgYW1kZ3B1X3ZtX3B0ICplbnRyeSwKPiArCQkJCQlzdHJ1
Y3QgbGlzdF9oZWFkICpoZWFkKQo+ICAgewo+ICAgCWlmIChlbnRyeS0+YmFzZS5ibykgewo+ICAg
CQllbnRyeS0+YmFzZS5iby0+dm1fYm8gPSBOVUxMOwo+ICAgCQlsaXN0X2RlbCgmZW50cnktPmJh
c2Uudm1fc3RhdHVzKTsKPiAtCQlhbWRncHVfYm9fdW5yZWYoJmVudHJ5LT5iYXNlLmJvLT5zaGFk
b3cpOwo+IC0JCWFtZGdwdV9ib191bnJlZigmZW50cnktPmJhc2UuYm8pOwo+ICsJCWlmICghaGVh
ZCkgewo+ICsJCQlhbWRncHVfYm9fdW5yZWYoJmVudHJ5LT5iYXNlLmJvLT5zaGFkb3cpOwo+ICsJ
CQlhbWRncHVfYm9fdW5yZWYoJmVudHJ5LT5iYXNlLmJvKTsKPiArCQl9IGVsc2UKPiArCQkJbGlz
dF9hZGQoJmVudHJ5LT5iYXNlLnZtX3N0YXR1cywgaGVhZCk7CgpJbnN0ZWFkIG9mIGFkZGluZyBh
IHBhcmFtZXRlciBtYWtlIHRoaXMgYSBuZXcgc3RhdGUgaW4gdGhlIFZNLiBTb21ldGhpbmcgCmxp
a2Ugdm0tPnpvbWJpZXMgb3Igc29tZXRoaW5nIHNpbWlsYXIuCgo+ICAgCX0KPiAgIAlrdmZyZWUo
ZW50cnktPmVudHJpZXMpOwo+ICAgCWVudHJ5LT5lbnRyaWVzID0gTlVMTDsKPiBAQCAtOTY1LDcg
Kzk2OSw4IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92bV9mcmVlX3RhYmxlKHN0cnVjdCBhbWRncHVf
dm1fcHQgKmVudHJ5KQo+ICAgICovCj4gICBzdGF0aWMgdm9pZCBhbWRncHVfdm1fZnJlZV9wdHMo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCQkgICAgICAgc3RydWN0IGFtZGdwdV92
bSAqdm0sCj4gLQkJCSAgICAgICBzdHJ1Y3QgYW1kZ3B1X3ZtX3B0X2N1cnNvciAqc3RhcnQpCj4g
KwkJCSAgICAgICBzdHJ1Y3QgYW1kZ3B1X3ZtX3B0X2N1cnNvciAqc3RhcnQsCj4gKwkJCQkgICBz
dHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQo+ICAgewo+ICAgCXN0cnVjdCBhbWRncHVfdm1fcHRfY3Vy
c29yIGN1cnNvcjsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X3ZtX3B0ICplbnRyeTsKPiBAQCAtOTczLDEw
ICs5NzgsMTAgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2ZyZWVfcHRzKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAo+ICAgCXZtLT5idWxrX21vdmVhYmxlID0gZmFsc2U7Cj4gICAKPiAgIAlm
b3JfZWFjaF9hbWRncHVfdm1fcHRfZGZzX3NhZmUoYWRldiwgdm0sIHN0YXJ0LCBjdXJzb3IsIGVu
dHJ5KQo+IC0JCWFtZGdwdV92bV9mcmVlX3RhYmxlKGVudHJ5KTsKPiArCQlhbWRncHVfdm1fZnJl
ZV90YWJsZShlbnRyeSwgaGVhZCk7Cj4gICAKPiAgIAlpZiAoc3RhcnQpCj4gLQkJYW1kZ3B1X3Zt
X2ZyZWVfdGFibGUoc3RhcnQtPmVudHJ5KTsKPiArCQlhbWRncHVfdm1fZnJlZV90YWJsZShzdGFy
dC0+ZW50cnksIGhlYWQpOwo+ICAgfQo+ICAgCj4gICAvKioKPiBAQCAtMTQyOCw3ICsxNDMzLDgg
QEAgc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2ZyYWdtZW50KHN0cnVjdCBhbWRncHVfdm1fdXBkYXRl
X3BhcmFtcyAqcGFyYW1zLAo+ICAgICovCj4gICBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRhdGVf
cHRlcyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywKPiAgIAkJCQkgdWlu
dDY0X3Qgc3RhcnQsIHVpbnQ2NF90IGVuZCwKPiAtCQkJCSB1aW50NjRfdCBkc3QsIHVpbnQ2NF90
IGZsYWdzKQo+ICsJCQkJIHVpbnQ2NF90IGRzdCwgdWludDY0X3QgZmxhZ3MsCj4gKwkJCQkgc3Ry
dWN0IGxpc3RfaGVhZCAqaGVhZCkKPiAgIHsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diA9IHBhcmFtcy0+YWRldjsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X3ZtX3B0X2N1cnNvciBjdXJzb3I7
Cj4gQEAgLTE1MzksNyArMTU0NSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVz
KHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAqcGFyYW1zLAo+ICAgCQkJICogY29tcGxl
dGVseSBjb3ZlcmVkIGJ5IHRoZSByYW5nZSBhbmQgc28gcG90ZW50aWFsbHkgc3RpbGwgaW4gdXNl
Lgo+ICAgCQkJICovCj4gICAJCQl3aGlsZSAoY3Vyc29yLnBmbiA8IGZyYWdfc3RhcnQpIHsKPiAt
CQkJCWFtZGdwdV92bV9mcmVlX3B0cyhhZGV2LCBwYXJhbXMtPnZtLCAmY3Vyc29yKTsKPiArCQkJ
CWFtZGdwdV92bV9mcmVlX3B0cyhhZGV2LCBwYXJhbXMtPnZtLCAmY3Vyc29yLCBoZWFkKTsKPiAg
IAkJCQlhbWRncHVfdm1fcHRfbmV4dChhZGV2LCAmY3Vyc29yKTsKPiAgIAkJCX0KPiAgIAo+IEBA
IC0xNTgzLDYgKzE1ODksNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGlu
ZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAlzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0
ZV9wYXJhbXMgcGFyYW1zOwo+ICAgCWVudW0gYW1kZ3B1X3N5bmNfbW9kZSBzeW5jX21vZGU7Cj4g
ICAJaW50IHI7Cj4gKwlzdHJ1Y3QgbGlzdF9oZWFkIGhlYWQ7Cj4gICAKPiAgIAltZW1zZXQoJnBh
cmFtcywgMCwgc2l6ZW9mKHBhcmFtcykpOwo+ICAgCXBhcmFtcy5hZGV2ID0gYWRldjsKPiBAQCAt
MTU5MCw2ICsxNTk3LDggQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmco
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJcGFyYW1zLmRpcmVjdCA9IGRpcmVjdDsK
PiAgIAlwYXJhbXMucGFnZXNfYWRkciA9IHBhZ2VzX2FkZHI7Cj4gICAKPiArCUlOSVRfTElTVF9I
RUFEKCZoZWFkKTsKPiArCj4gICAJLyogSW1wbGljaXRseSBzeW5jIHRvIGNvbW1hbmQgc3VibWlz
c2lvbnMgaW4gdGhlIHNhbWUgVk0gYmVmb3JlCj4gICAJICogdW5tYXBwaW5nLiBTeW5jIHRvIG1v
dmluZyBmZW5jZXMgYmVmb3JlIG1hcHBpbmcuCj4gICAJICovCj4gQEAgLTE2MTcsMTMgKzE2MjYs
MjIgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCj4gICAJaWYgKHIpCj4gICAJCWdvdG8gZXJyb3JfdW5sb2NrOwo+ICAg
Cj4gLQlyID0gYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKCZwYXJhbXMsIHN0YXJ0LCBsYXN0ICsgMSwg
YWRkciwgZmxhZ3MpOwo+ICsJciA9IGFtZGdwdV92bV91cGRhdGVfcHRlcygmcGFyYW1zLCBzdGFy
dCwgbGFzdCArIDEsIGFkZHIsIGZsYWdzLCAmaGVhZCk7Cj4gICAJaWYgKHIpCj4gICAJCWdvdG8g
ZXJyb3JfdW5sb2NrOwo+ICAgCj4gICAJciA9IHZtLT51cGRhdGVfZnVuY3MtPmNvbW1pdCgmcGFy
YW1zLCBmZW5jZSk7Cj4gICAKPiAgIGVycm9yX3VubG9jazoKPiArCXdoaWxlICghbGlzdF9lbXB0
eSgmaGVhZCkpIHsKPiArCQlzdHJ1Y3QgYW1kZ3B1X3ZtX3B0ICplbnRyeSA9IGxpc3RfZmlyc3Rf
ZW50cnkoJmhlYWQsCj4gKwkJCQlzdHJ1Y3QgYW1kZ3B1X3ZtX3B0LCBiYXNlLnZtX3N0YXR1cyk7
Cj4gKwkJbGlzdF9kZWwoJmVudHJ5LT5iYXNlLnZtX3N0YXR1cyk7Cj4gKwo+ICsJCWFtZGdwdV9i
b191bnJlZigmZW50cnktPmJhc2UuYm8tPnNoYWRvdyk7Cj4gKwkJYW1kZ3B1X2JvX3VucmVmKCZl
bnRyeS0+YmFzZS5ibyk7Cj4gKwl9CgpNYXliZSBwdXQgdGhhdCBpbnRvIGEgc2VwYXJhdGUgZnVu
Y3Rpb24uCgo+ICsKPiAgIAlhbWRncHVfdm1fZXZpY3Rpb25fdW5sb2NrKHZtKTsKPiAgIAlyZXR1
cm4gcjsKPiAgIH0KPiBAQCAtMzExOCw3ICszMTM2LDcgQEAgdm9pZCBhbWRncHVfdm1fZmluaShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0pCj4gICAJCWFt
ZGdwdV92bV9mcmVlX21hcHBpbmcoYWRldiwgdm0sIG1hcHBpbmcsIE5VTEwpOwo+ICAgCX0KPiAg
IAo+IC0JYW1kZ3B1X3ZtX2ZyZWVfcHRzKGFkZXYsIHZtLCBOVUxMKTsKPiArCWFtZGdwdV92bV9m
cmVlX3B0cyhhZGV2LCB2bSwgTlVMTCwgTlVMTCk7CgpBbmQgdGhlbiBhbHNvIGNhbGwgaXQgaGVy
ZS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4gICAJYW1kZ3B1X2JvX3VucmVzZXJ2ZShyb290KTsK
PiAgIAlhbWRncHVfYm9fdW5yZWYoJnJvb3QpOwo+ICAgCVdBUk5fT04odm0tPnJvb3QuYmFzZS5i
byk7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
