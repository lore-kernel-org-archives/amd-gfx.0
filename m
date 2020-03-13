Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451A4C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B5C2072C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L6Nq8XC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B5C2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A73556EBCF;
	Fri, 13 Mar 2020 14:14:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D2D6EBCF
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 14:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvFfsicJQ8XNvh1eTwii9iL5S+TyJpuhiki5nEzu9o6ZPoLmJZGUMNhhLakkSF4xo4N0OJU+bSTRrWylysV8gRO6PP7/jI+hAc3iYR8/IKMOlHstrT0MLZ5gNC3AA4eYtEh6WI50bw3PKY7DNe5bgCdnG0I3tWo6jyNpa4OsJcOCtPW0yQPXj+olbpTIKg5G1+nud8RsqzNRS7XIZGc5nPVcVbdDCl3cnhA0E7mBkpqM5j7fkWv2JMR3V6Uu6BfFJ4/4bVmNXoRD/hAfNmuzhRun8pZ5IKTkX2gdRgVVt4US0O1RSymiMT7PEyLik1N3UE/qP+RJ/IP0K9iVUqtktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GnncMoJRBWpY087xbL6Th9pTry+Oi/PnPbLKEc01P8=;
 b=FVHrirzxxjxzjRDs86TRKDveiJMRLsdRXbb7umjd5PWO5t6/wvQZeQFeYi6cTNmycHltHlxCoO7dp8Heg+K/q4JSQZCmwrzSpunnNeGpL1RppDxvQ4e91LRtFFF2/auNuut9HCgixDjgGpTemTPgBvQtxSzWc0ZogYLVD45oTPjL+gYrDJpMj6WuqjUAXCyM4eHRcOrhObs52PbN/84dlr9PiOHWHwhmlZ1+G4I4ueKlitTk02tvGZOqit7ot/XhIbXCvvPtXnZ/JJ7bDsJEY0XJ1YsSitQDFIrikVOShM6O8LMXukCZxmwjNg9HPbuTvKoOU23m5aBq+1yxILE2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GnncMoJRBWpY087xbL6Th9pTry+Oi/PnPbLKEc01P8=;
 b=L6Nq8XC2WA4rsPM9w8Vsq0V5hZDk4ImCbcOfpgd0MutvyhFgmsstOsN+GqP1A7X3ccMNRbaEBQuV7tl7wuqrhjrVoKhyvOjbiwO7e7U/Y+bMtLC3fnRAz9b5vdLIjap/o13wcCNMyS0eirmFMMSBHssVDB7hyk1d1yjTPovkbAM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1578.namprd12.prod.outlook.com (2603:10b6:4:e::7) by
 DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Fri, 13 Mar 2020 14:13:58 +0000
Received: from DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c]) by DM5PR12MB1578.namprd12.prod.outlook.com
 ([fe80::113e:3059:1470:c73c%7]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 14:13:58 +0000
Subject: Re: [PATCH v3 1/2] drm/amdgpu: Add job fence to resv conditionally
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200313140758.6607-1-xinhui.pan@amd.com>
 <20200313140758.6607-2-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3d604156-be87-9f74-69f0-d78f7a2c2879@amd.com>
Date: Fri, 13 Mar 2020 15:13:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200313140758.6607-2-xinhui.pan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::14)
 To DM5PR12MB1578.namprd12.prod.outlook.com
 (2603:10b6:4:e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FRYP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18 via Frontend Transport; Fri, 13 Mar 2020 14:13:57 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 72f109ee-90e2-46f0-92a9-08d7c758c5a1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1418:|DM5PR12MB1418:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB14185873CF15620F54D7BF6583FA0@DM5PR12MB1418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(199004)(8676002)(31686004)(31696002)(4326008)(478600001)(186003)(16526019)(66476007)(66556008)(66946007)(81156014)(52116002)(81166006)(6486002)(5660300002)(8936002)(86362001)(36756003)(6666004)(2616005)(54906003)(316002)(66574012)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1418;
 H:DM5PR12MB1578.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SVayZ4fi+9dyZHUe/DF9pWTlEMNsmLgk8rw8zcFck/Ya3v1FLPzH9dGnE2rPix73bACcaeIu2MgDVSDUiqSh0anlS6llQ1g1Ane34o2Czedukq7c9Ppat4XR05x7YOx82goSR4GNU9V3RAMyp9bjuh002B/UDxybr5Zv8Di/BNknYlgyLSzvsj9Z6ceWxslkbMOsugWp3lAqsk+BuySgJ/93kpTVoI5r2oqweu4/2O5rHilBReWd6v3JC/vC/H5L9ZFV3ugnxclz256uKlnM9b1oJ7dD07qLibaH2pO02DmHuF6/2xUvPyHQtK702U2TBezrD0WrgTGzkx45jZ8gGY1D5MB+ePlZpFJoGV/849vj3cZdZziSb28zrL6jik2vPxo3tcypqn6zZQDFYFUj1/b8KkIundQdt/it5max74pp6pyT5G7HxTzxU8v2Okx1
X-MS-Exchange-AntiSpam-MessageData: KB+ohC+m25539eYAjsP4sJ9qEeXmNzX0a9NvXBzK/J5bKjs2ei5Uhe9y3iXEWRQXLSAqvktqaJRdaMD9ecjdYbAiwq1jRfXkaYTAzXoYHnFLzsjLcrBpXsgUVRrW6HJMy8tSFH3M5OG/8eDp0mrddHt53YMNI4/QauGVBL98EJpWC8HAWM4m1shASI2BzCtnir9wOvJjMa/xMRI7080tJw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f109ee-90e2-46f0-92a9-08d7c758c5a1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 14:13:58.5433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kc667U5PGd41QQssaCBtVcOiWFVsJb7LHPmClzodLdzDAJLENoT3icsesUob0MRr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1418
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

QW0gMTMuMDMuMjAgdW0gMTU6MDcgc2NocmllYiB4aW5odWkgcGFuOgo+IFByb3ZpZGUgcmVzdiBh
cyBhIHBhcmFtZXRlciBmb3Igdm0gc2RtYSBjb21taXQuCj4gSm9iIGZlbmNlIG9uIHBhZ2UgdGFi
bGUgc2hvdWxkIGJlIGEgc2hhcmVkIG9uZSwgc28gYWRkIGl0IHRvIHRoZSByZXN2Lgo+Cj4gQ2M6
IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiBGZWxpeCBLdWVobGluZyA8
RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPiBTdWdnZXN0ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiB4aW5odWkgcGFuIDx4
aW5odWkucGFuQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uYyAgICAgIHwgNCArKy0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uaCAgICAgIHwgNSArKysrKwo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtX3NkbWEuYyB8IDcgKysrKysrKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMKPiBpbmRleCA3MzM5ODgzMTE5NmYuLjgwOWNhNmU4ZjQwZiAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTE1NzksNiArMTU3OSw3IEBAIHN0
YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LAo+ICAgCQkJCSAgICAgICBkbWFfYWRkcl90ICpwYWdlc19hZGRyLAo+ICAgCQkJCSAg
ICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICoqZmVuY2UpCj4gICB7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2Jv
ICpyb290ID0gdm0tPnJvb3QuYmFzZS5ibzsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9w
YXJhbXMgcGFyYW1zOwo+ICAgCWVudW0gYW1kZ3B1X3N5bmNfbW9kZSBzeW5jX21vZGU7Cj4gICAJ
aW50IHI7Cj4gQEAgLTE2MDQsOCArMTYwNSw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3Vw
ZGF0ZV9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCX0KPiAgIAo+ICAg
CWlmIChmbGFncyAmIEFNREdQVV9QVEVfVkFMSUQpIHsKPiAtCQlzdHJ1Y3QgYW1kZ3B1X2JvICpy
b290ID0gdm0tPnJvb3QuYmFzZS5ibzsKPiAtCj4gICAJCWlmICghZG1hX2ZlbmNlX2lzX3NpZ25h
bGVkKHZtLT5sYXN0X2RpcmVjdCkpCj4gICAJCQlhbWRncHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxh
c3RfZGlyZWN0LCB0cnVlKTsKPiAgIAo+IEBAIC0xNjEzLDYgKzE2MTIsNyBAQCBzdGF0aWMgaW50
IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwK
PiAgIAkJCWFtZGdwdV9ib19mZW5jZShyb290LCB2bS0+bGFzdF9kZWxheWVkLCB0cnVlKTsKPiAg
IAl9Cj4gICAKPiArCXBhcmFtcy5yZXN2ID0gcm9vdC0+dGJvLmJhc2UucmVzdjsKPiAgIAlyID0g
dm0tPnVwZGF0ZV9mdW5jcy0+cHJlcGFyZSgmcGFyYW1zLCByZXN2LCBzeW5jX21vZGUpOwo+ICAg
CWlmIChyKQo+ICAgCQlnb3RvIGVycm9yX3VubG9jazsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uaAo+IGluZGV4IGI1NzA1ZmNmYzkzNS4uY2E2MDIxYjQyMDBiIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgKPiBAQCAtMjI2LDYgKzIyNiwxMSBA
QCBzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgewo+ICAgCSAqIEBudW1fZHdfbGVmdDog
bnVtYmVyIG9mIGR3IGxlZnQgZm9yIHRoZSBJQgo+ICAgCSAqLwo+ICAgCXVuc2lnbmVkIGludCBu
dW1fZHdfbGVmdDsKPiArCj4gKwkvKioKPiArCSAqIEByZXN2OiBzeW5jIHRoZSByZXN2IGFuZCBh
ZGQgam9iIGZlbmNlIHRvIGl0IGNvbmRpdGlvbmFsbHkuCj4gKwkgKi8KPiArCXN0cnVjdCBkbWFf
cmVzdiAqcmVzdjsKPiAgIH07Cj4gICAKPiAgIHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX2Z1bmNz
IHsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3Nk
bWEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9zZG1hLmMKPiBpbmRl
eCA0Y2M3ODgxZjQzOGMuLmExYjI3MGE0ZGE4ZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm1fc2RtYS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtX3NkbWEuYwo+IEBAIC0xMTEsNiArMTExLDEzIEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X3ZtX3NkbWFfY29tbWl0KHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyAq
cCwKPiAgIAkJc3dhcChwLT52bS0+bGFzdF9kZWxheWVkLCB0bXApOwo+ICAgCWRtYV9mZW5jZV9w
dXQodG1wKTsKPiAgIAo+ICsJLyogYWRkIGpvYiBmZW5jZSB0byByZXN2Lgo+ICsJICogTU0gbm90
aWZpZXIgcGF0aCBpcyBhbiBleGNlcHRpb24gYXMgd2UgY2FuIG5vdCBncmFiIHRoZQo+ICsJICog
cmVzdiBsb2NrLgo+ICsJICovCj4gKwlpZiAoIXAtPmRpcmVjdCAmJiBwLT5yZXN2KQoKWW91IGNh
biBqdXN0IHVzZSBwLT52bS0+cm9vdC5iYXNlLmJvLT50Ym8uYmFzZS5yZXN2IGhlcmUsIG5vIG5l
ZWQgZm9yIGEgCm5ldyBmaWVsZCBpbiB0aGUgcGFyYW1hdGVyIHN0cnVjdHVyZS4KCkFuZCBpdCB3
b3VsZCBwcm9iYWJseSBiZSBiZXN0IHRvIGFsc28gcmVtb3ZlIHRoZSB2bS0+bGFzdF9kZWxheWVk
IGZpZWxkIAplbnRpcmVseS4KCkluIG90aGVyIHdvcmRzIHVzZSBzb21ldGhpbmcgbGlrZSB0aGlz
IGhlcmUKCmlmIChwLT5kaXJlY3QpIHsKIMKgwqDCoCB0bXAgPSBkbWFfZmVuY2VfZ2V0KGYpOwog
wqDCoMKgIHN3YXAocC0+dm0tPmxhc3RfZGlyZWN0LCB0bXApOwogwqDCoMKgIGRtYV9mZW5jZV9w
dXQodG1wKTsKfSBlbHNlIHsKZG1hX3Jlc3ZfYWRkX3NoYXJlZF9mZW5jZShwLT52bS0+cm9vdC5i
YXNlLmJvLT50Ym8uYmFzZS5yZXN2LCBmKTsKfQoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPiArCQlk
bWFfcmVzdl9hZGRfc2hhcmVkX2ZlbmNlKHAtPnJlc3YsIGYpOwo+ICsKPiAgIAlpZiAoZmVuY2Ug
JiYgIXAtPmRpcmVjdCkKPiAgIAkJc3dhcCgqZmVuY2UsIGYpOwo+ICAgCWRtYV9mZW5jZV9wdXQo
Zik7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
