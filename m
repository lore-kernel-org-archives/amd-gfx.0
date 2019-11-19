Return-Path: <SRS0=44+a=ZL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E4BC432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 09:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A58B2082F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 09:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A58B2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D50396E4D4;
	Tue, 19 Nov 2019 09:22:59 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790047.outbound.protection.outlook.com [40.107.79.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC92B6E909
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 09:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0DXw68yByxel65F/S9UgSh8xzdZwXK8dRDAz+ZGZW8pOIXB5ty02D4tp6of0uJ3t335Av01E5NkOZAl9OqZ3A4CCUw06CKC4svbxyzfGmzbzYS66e2qe7ftPp7wTlA/8i4paenlwT4PnSo4PfG8cKAFPq4JaIeIReDpOXCSIAF5aJ7rddfAuc0geMzla05mYCsN4DNRSS7EvaugtgnhI5JoMkPEgrr8nM1mrTv60oyt7u9xs98cRJP30K0Si+QouRDQd/dYEOxs0PuzonEosI6y4Z1o8CmMeWLWu23hb12GGMZBuGBdCs6TuSCVGh352QuBvIDGuFtw3MlhuBqcbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0GnLBtgz6yTFID6xThQvRqcYift9ve8EPZWBJdTZCo=;
 b=LG8Ay+0pOUZsnaebRoAxpniu3Um5oQnJfUijpS+KPSEXm58Ud/04JSt1V3fnoVTIPSqchMeL0dPt4Mk5vQqhvDi7i7sADbZ5hY2/o35dJa4Lbeg9QwiYA+mN8zAdaPXQGr5u2K28zoLqK0NUWpNQ36ASAte6rFkz1SudLGmJ1jxNTbLzSqZtPKJiHVINz3paXJHSKsrmDzonRTKMNjAaU7rEtjpi+w0qyDixxsq5jUNY+O9bp9gZtWLQiKYWwZTMbZdTvyhfnoyYnM0YGgAdh4zw6T9lwnZoJbVsxkJLmrIJBTuOgfVmHIgkCFiQ5MDioAGJyqul7leLoVuZN0hvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1866.namprd12.prod.outlook.com (10.175.88.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 09:22:56 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 09:22:56 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu: initialize vm_inv_eng0_sem for gfxhub and
 mmhub
To: "Changfeng.Zhu" <changfeng.zhu@amd.com>, Jack.Xiao@amd.com,
 Tao.Zhou1@amd.com, Ray.Huang@amd.com, Xinmei.Huang@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20191119091149.4543-1-changfeng.zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <bbfc5a48-0e34-d61e-ff0f-630892e31c15@amd.com>
Date: Tue, 19 Nov 2019 10:22:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191119091149.4543-1-changfeng.zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR0202CA0002.eurprd02.prod.outlook.com
 (2603:10a6:208:1::15) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b457ce90-13f1-49e3-cbc8-08d76cd21017
X-MS-TrafficTypeDiagnostic: DM5PR12MB1866:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18662AB32A3E90ABE7B561F3834C0@DM5PR12MB1866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 022649CC2C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(189003)(199004)(25786009)(386003)(31696002)(2616005)(229853002)(8936002)(36756003)(446003)(6666004)(6116002)(50466002)(186003)(66476007)(66946007)(7736002)(66556008)(11346002)(6506007)(305945005)(65956001)(65806001)(47776003)(81156014)(8676002)(81166006)(478600001)(99286004)(76176011)(31686004)(2870700001)(5660300002)(86362001)(2906002)(14454004)(46003)(6436002)(6512007)(23676004)(6246003)(476003)(58126008)(52116002)(6486002)(486006)(316002)(2486003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1866;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7w3x0KIFK300Qw1KI0+dbvCxw9tizk6W7KZiaeT2REf2F+9Kf3p4+3Demg7h4cdMLLD47qMKB+Rtudv1yqXp1mZGIZ4VN/Te7L6nUuNXRkYDa8dZinPGXImInfRg4jc+3cnvBvJW2jYsEvK6jM911B3Bjvqpzm71+P8OARJmce/cy4eT/t+IyPgXEiELGIB+H1nfP3gjao3STHTrkFNpbuy77NLWzYMDrdMlL7M3u54tuomL4NsDD2beA3pzqYvo52+8dxKn5b8w9k/zYao54gZbBZpJNsXobSRRZML2pNEPLPXNW140C4HOYPOJaK1TVeQ7m0nwYrXR1NthNos8+kxXFAkGOKM/Jzw1kly2R2Vm6lJMyAZhuOthcZ130PwZNr37hVCJvqqAJeTH/j7Ct5nszAw4o4BXtU5L2pX4wqoIVR+XmyOPhHO4aTKjegKr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b457ce90-13f1-49e3-cbc8-08d76cd21017
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 09:22:56.6720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCKWOf+HyxJ4kThaJhZqlGRpGRdULlY/GrEyTxfjqDxkUl/b2m3FkhOeORyHqNay
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1866
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0GnLBtgz6yTFID6xThQvRqcYift9ve8EPZWBJdTZCo=;
 b=lV7z/3exSokCNYt1V3U358Rdgjiyrok9S1KD1EKVORSbJTS6xk/NX/jGRpFLfMAqWJgC5NsOfkoiKpslMtHB+RgQBytV7atvFJJQeUN47lSqTceaRyBycAFsvw6ruLGEXMD0ArTmIIJso2GNJZr3HPRXKPcPLifokmhVBbIwpS8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
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
Message-ID: <20191119092249.YEg2oVJkxr3_4L6wAgRBzOR5ej91ibSJeHZHxduQ5t8@z>

QW0gMTkuMTEuMTkgdW0gMTA6MTEgc2NocmllYiBDaGFuZ2ZlbmcuWmh1Ogo+IEZyb206IGNoYW5n
emh1IDxDaGFuZ2ZlbmcuWmh1QGFtZC5jb20+Cj4KPiBTVyBtdXN0IGFjcXVpcmUvcmVsZWFzZSBv
bmUgb2YgdGhlIHZtX2ludmFsaWRhdGVfZW5nKl9zZW0gYXJvdW5kIHRoZQo+IGludmFsaWRhdGlv
biByZXEvYWNrLiBUaHJvdWdoIHRoaXMgd2F5LGl0IGNhbiBhdm9pZCBsb3NpbmcgaW52YWxpZGF0
ZQo+IGFja25vd2xlZGdlIHN0YXRlIGFjcm9zcyBwb3dlci1nYXRpbmcgb2ZmIGN5Y2xlLgo+IFRv
IHVzZSB2bV9pbnZhbGlkYXRlX2VuZypfc2VtLCBpdCBuZWVkcyB0byBpbml0aWFsaXplCj4gdm1f
aW52YWxpZGF0ZV9lbmcqX3NlbSBmaXJzdGx5Lgo+Cj4gQ2hhbmdlLUlkOiBJYzdhYmY0ODFiMDhk
ZjA4NWMzMjZhOThlYmE0YjAwZDc4ZjMzNTYwYwo+IFNpZ25lZC1vZmYtYnk6IGNoYW5nemh1IDxD
aGFuZ2ZlbmcuWmh1QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nbWMuaCAgfCAxICsKPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eGh1Yl92MV8wLmMgfCAyICsrCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJf
djJfMC5jIHwgMiArKwo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjFfMC5j
ICB8IDIgKysKPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3YyXzAuYyAgfCAy
ICsrCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMgIHwgNCArKysr
Cj4gICA2IGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ21jLmgKPiBpbmRleCA0MDY3MzZhMWJkM2QuLmI0OTlhM2RlOGJi
NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmgKPiBAQCAtNzcs
NiArNzcsNyBAQCBzdHJ1Y3QgYW1kZ3B1X2dtY19mYXVsdCB7Cj4gICBzdHJ1Y3QgYW1kZ3B1X3Zt
aHViIHsKPiAgIAl1aW50MzJfdAljdHgwX3B0Yl9hZGRyX2xvMzI7Cj4gICAJdWludDMyX3QJY3R4
MF9wdGJfYWRkcl9oaTMyOwo+ICsJdWludDMyX3QJdm1faW52X2VuZzBfc2VtOwo+ICAgCXVpbnQz
Ml90CXZtX2ludl9lbmcwX3JlcTsKPiAgIAl1aW50MzJfdAl2bV9pbnZfZW5nMF9hY2s7Cj4gICAJ
dWludDMyX3QJdm1fY29udGV4dDBfY250bDsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4aHViX3YxXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eGh1Yl92MV8wLmMKPiBpbmRleCA5ZWM0Mjk3ZTYxZTUuLmU5MWJkNzk0NTc3NyAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjFfMC5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3YxXzAuYwo+IEBAIC0zNjcsNiArMzY3LDgg
QEAgdm9pZCBnZnhodWJfdjFfMF9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAg
CWh1Yi0+Y3R4MF9wdGJfYWRkcl9oaTMyID0KPiAgIAkJU09DMTVfUkVHX09GRlNFVChHQywgMCwK
PiAgIAkJCQkgbW1WTV9DT05URVhUMF9QQUdFX1RBQkxFX0JBU0VfQUREUl9ISTMyKTsKPiArCWh1
Yi0+dm1faW52X2VuZzBfc2VtID0KPiArCQlTT0MxNV9SRUdfT0ZGU0VUKEdDLCAwLCBtbVZNX0lO
VkFMSURBVEVfRU5HMF9TRU0pOwo+ICAgCWh1Yi0+dm1faW52X2VuZzBfcmVxID0KPiAgIAkJU09D
MTVfUkVHX09GRlNFVChHQywgMCwgbW1WTV9JTlZBTElEQVRFX0VORzBfUkVRKTsKPiAgIAlodWIt
PnZtX2ludl9lbmcwX2FjayA9Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeGh1Yl92Ml8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjJf
MC5jCj4gaW5kZXggYjRmMzJkODUzY2ExLi5iNzBjN2I0ODNjMjQgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3YyXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeGh1Yl92Ml8wLmMKPiBAQCAtMzU2LDYgKzM1Niw4IEBAIHZvaWQg
Z2Z4aHViX3YyXzBfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAlodWItPmN0
eDBfcHRiX2FkZHJfaGkzMiA9Cj4gICAJCVNPQzE1X1JFR19PRkZTRVQoR0MsIDAsCj4gICAJCQkJ
IG1tR0NWTV9DT05URVhUMF9QQUdFX1RBQkxFX0JBU0VfQUREUl9ISTMyKTsKPiArCWh1Yi0+dm1f
aW52X2VuZzBfc2VtID0KPiArCQlTT0MxNV9SRUdfT0ZGU0VUKEdDLCAwLCBtbUdDVk1fSU5WQUxJ
REFURV9FTkcwX1NFTSk7Cj4gICAJaHViLT52bV9pbnZfZW5nMF9yZXEgPQo+ICAgCQlTT0MxNV9S
RUdfT0ZGU0VUKEdDLCAwLCBtbUdDVk1fSU5WQUxJREFURV9FTkcwX1JFUSk7Cj4gICAJaHViLT52
bV9pbnZfZW5nMF9hY2sgPQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9tbWh1Yl92MV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92MV8wLmMK
PiBpbmRleCA2OTY1ZTFlNmZhOWUuLjI4MTA1ZTRhZjUwNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92MV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9tbWh1Yl92MV8wLmMKPiBAQCAtNDIwLDYgKzQyMCw4IEBAIHZvaWQgbW1odWJf
djFfMF9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCWh1Yi0+Y3R4MF9wdGJf
YWRkcl9oaTMyID0KPiAgIAkJU09DMTVfUkVHX09GRlNFVChNTUhVQiwgMCwKPiAgIAkJCQkgbW1W
TV9DT05URVhUMF9QQUdFX1RBQkxFX0JBU0VfQUREUl9ISTMyKTsKPiArCWh1Yi0+dm1faW52X2Vu
ZzBfc2VtID0KPiArCQlTT0MxNV9SRUdfT0ZGU0VUKE1NSFVCLCAwLCBtbVZNX0lOVkFMSURBVEVf
RU5HMF9TRU0pOwo+ICAgCWh1Yi0+dm1faW52X2VuZzBfcmVxID0KPiAgIAkJU09DMTVfUkVHX09G
RlNFVChNTUhVQiwgMCwgbW1WTV9JTlZBTElEQVRFX0VORzBfUkVRKTsKPiAgIAlodWItPnZtX2lu
dl9lbmcwX2FjayA9Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21t
aHViX3YyXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3YyXzAuYwo+IGlu
ZGV4IDk0NTUzMzYzNDcxMS4uYTdjYjE4NWQ2MzlhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L21taHViX3YyXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L21taHViX3YyXzAuYwo+IEBAIC0zNDgsNiArMzQ4LDggQEAgdm9pZCBtbWh1Yl92Ml8w
X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJaHViLT5jdHgwX3B0Yl9hZGRy
X2hpMzIgPQo+ICAgCQlTT0MxNV9SRUdfT0ZGU0VUKE1NSFVCLCAwLAo+ICAgCQkJCSBtbU1NVk1f
Q09OVEVYVDBfUEFHRV9UQUJMRV9CQVNFX0FERFJfSEkzMik7Cj4gKwlodWItPnZtX2ludl9lbmcw
X3NlbSA9Cj4gKwkJU09DMTVfUkVHX09GRlNFVChNTUhVQiwgMCwgbW1NTVZNX0lOVkFMSURBVEVf
RU5HMF9TRU0pOwo+ICAgCWh1Yi0+dm1faW52X2VuZzBfcmVxID0KPiAgIAkJU09DMTVfUkVHX09G
RlNFVChNTUhVQiwgMCwgbW1NTVZNX0lOVkFMSURBVEVfRU5HMF9SRVEpOwo+ICAgCWh1Yi0+dm1f
aW52X2VuZzBfYWNrID0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bW1odWJfdjlfNC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jCj4g
aW5kZXggMmM1YWRmZTgwM2EyLi42NmVmZTJmN2JkNzYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvbW1odWJfdjlfNC5jCj4gQEAgLTUwNCw2ICs1MDQsMTAgQEAgdm9pZCBtbWh1Yl92
OV80X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJCQlTT0MxNV9SRUdfT0ZG
U0VUKE1NSFVCLCAwLAo+ICAgCQkJICAgIG1tVk1MMlZDMF9WTV9DT05URVhUMF9QQUdFX1RBQkxF
X0JBU0VfQUREUl9ISTMyKSArCj4gICAJCQkgICAgaSAqIE1NSFVCX0lOU1RBTkNFX1JFR0lTVEVS
X09GRlNFVDsKPiArCQlodWJbaV0tPnZtX2ludl9lbmcwX3NlbSA9Cj4gKwkJCVNPQzE1X1JFR19P
RkZTRVQoTU1IVUIsIDAsCj4gKwkJCQkJIG1tVk1MMlZDMF9WTV9JTlZBTElEQVRFX0VORzBfU0VN
KSArCj4gKwkJCQkJIGkgKiBNTUhVQl9JTlNUQU5DRV9SRUdJU1RFUl9PRkZTRVQ7Cj4gICAJCWh1
YltpXS0+dm1faW52X2VuZzBfcmVxID0KPiAgIAkJCVNPQzE1X1JFR19PRkZTRVQoTU1IVUIsIDAs
Cj4gICAJCQkJCSBtbVZNTDJWQzBfVk1fSU5WQUxJREFURV9FTkcwX1JFUSkgKwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
