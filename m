Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C16C4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 05:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776CC20BED
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 05:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T/YgqW1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776CC20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5BAB8987A;
	Tue, 29 Sep 2020 05:39:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E498987A
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 05:39:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghJi0zNOCq5V1iKlGa1g1CB/wcs8mg8ojcztSX4WhXLshWknGaydMR/5b3zkyfVfj/Lr/FvRhEWeg9Rl3W6NUWsH3RpprXavKlUP1NZX1OTAeet2p2X/dnMcq1R4uSXabWDsWf0ehyJVyvutc3nwgYcSplM10+lH+XfhlsywszaHBfTDZBDlELRVaWtnhS2YZLNenWpKMfqqBST9nIF1HbCFX4zNYtRwyukhu3xoFw06TAoZ8XuQIKONnkLAt6NewyceaOyDsYF7ELSJDEBia+NLyc0JccC8+xt5ArrOlPoAYE3A5e7ZvhTSgiG4z/JmxhPpoJcAIme3YCzIDYUL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ednh7SkYt+NqUfeTlTIoru3TczuMUyCMTgS3hbTpfu4=;
 b=mEEVd8iF266do/UU9NTKgKcU5nKVLYtabBxC5bva/suLrwokJm+BwZxI19bZxzfqmi/2Yg0JHX8OnVA3VIC+ExYUjvZsXDzLFIk9piO4ZUTbJIGUXIRTtLRtwRF1VVHy8u5El9aLOkSjPwB/qQgaGI33n+X6DSJGQluIU6s+jCAjHxMBUgnT+nwINqiWlbSZ15HXJIzaMm9PMVppdYpLgc6j8Q7dbFUWiok+vua1L1mTe5hfjUX5ckf87NkPk3cftgmRpjHRJ/waGMdrTSshn614r/mzjAQg4tLBPeOLSihui/TCd4iZL+VC3LQnNiUqJQXFRu44JDvw5nLBs7Hemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ednh7SkYt+NqUfeTlTIoru3TczuMUyCMTgS3hbTpfu4=;
 b=T/YgqW1gomAosCbvDsDfAI3nD5WRL3XOIi0a/ezZe+uFoZHQaWiztPfg42XVR9anlbl01JqB9lls9MGwY5kaXM/QC4PUB2Q5S7Y2dF4xbeVZrEX/U9v7H/ZcW08wXzbdcN9ZdQpukGNkson5wUfV5VfsM3yGz5b+dTCoXLBfHNg=
Received: from SN1PR12MB2558.namprd12.prod.outlook.com (2603:10b6:802:2b::18)
 by SA0PR12MB4527.namprd12.prod.outlook.com (2603:10b6:806:73::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 05:39:32 +0000
Received: from SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03]) by SN1PR12MB2558.namprd12.prod.outlook.com
 ([fe80::c8c0:9bc9:57ed:cb03%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 05:39:32 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amd/amdgpu: Fix resv shared fence overflow
Thread-Topic: [PATCH] amd/amdgpu: Fix resv shared fence overflow
Thread-Index: AQHWlh/AmbrlqZntzUSWaZ8P7JHwV6l/GXhQ
Date: Tue, 29 Sep 2020 05:39:31 +0000
Message-ID: <SN1PR12MB255854341F209891978617B887320@SN1PR12MB2558.namprd12.prod.outlook.com>
References: <20200929051632.8737-1-xinhui.pan@amd.com>
In-Reply-To: <20200929051632.8737-1-xinhui.pan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=13dd1785-e653-4469-898f-a4ffba443607;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-29T05:39:12Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e19992b6-fc99-43eb-d7ae-08d8643a0a8c
x-ms-traffictypediagnostic: SA0PR12MB4527:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB4527F2F37A66F96BAE80A7BF87320@SA0PR12MB4527.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PLGKk2dOhpGGrqZIugZ8ooWOSEIWTdIGPuMGDWPpy4slMpeuzffZ45jmqA6hJtRXXMfSeAUeX6xuprlINHPQiPhYMWt2iz6O+Qgz+8BBKYKhIPwUV/ESIE5EW28FlObHz5VKqGhod4ma0bsqp/+wrgn6VGV+TNNHHVJqGy3Xo4EV/nhGv42h6DgCUDSr2n4C9C5hTyVtblg7QVZt9R3WYCNi6UymajfiM3DVmzVOnR6oxJ3It5DFYa2TxPePDzwCKUCvxzRYagOYbF1zkQpKf8ZvjsPfOKuHOolCydFZxOGnAE/Xo9PjQwedpTyEsW5J4lHboLwaaRqrbY1j9JPoI/hRsl6lAH2qRNBbQNb1Pry/Cb6f6pLvndqwkyV6FtEn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(316002)(52536014)(6506007)(186003)(26005)(7696005)(54906003)(53546011)(4326008)(55016002)(9686003)(478600001)(6916009)(71200400001)(8936002)(86362001)(33656002)(64756008)(8676002)(66476007)(66556008)(66946007)(5660300002)(66446008)(76116006)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: koyQjmWPZNv/5I5aNxHU1ywlm6dqBKabVZCADVQlAFh/W7gMnw9cCyQ+ib3kXpYPVKF4i1x5iY7qdeBudvSk8aKfdPtLsJXfPl6Mjd6umtUdV1v1QBZqrYNKIIviI/63V3ROiMAICUC/78eZc3f7Om1EnS/q0SP5OFF7eGlPGEL+OeMVV03ezENven47jKWVUExa0j9qJhV7c7vuQlM9xPzc35ihkBGNMyO3EO8fxgfNFTFgGUksAlzceiSAx10UtoJ+lrWU/5kvw0WIH6AV5FJ0DPjWPs74qbbygorO4Pp/yehcRi1dLNEsU9WQKDAC7FZzJEhqNmZAhFIKIRUQqglAZWT77NlhCD9r03jKwIg5tci81qyy9gA9pMjo8ijNA8r4C8r9RXZrCmgZ9cDbNhr/I7IOZIr86+m/ucr+yxm46Hu3x9Z4i+QH99q0NE1xjpHDW2LQqKf0Q6waIuUUIvU+3J3wYbCWy9iP5P1iZbzrJZ5SQXNOfojQET+BvVdeke6rzP+M6ZexnW2tPkBCoFIkqFDjiF3braRi6fOp4ZgUgxgMo5d1FMcyBOBs+Yt6DL7f5ie/YZmV5Oroz4auG5TajmDEl3feQNXkq73b3D/8Wdy4w38iMJxPAATChGRA/ZMd+j+eIiXuePYrue4UGQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19992b6-fc99-43eb-d7ae-08d8643a0a8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 05:39:31.9519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kaW5V7DryPMlXwLEgVdU/gR8U/odBUylqPUnu6CwUNfdNurit0Bb9eeBwD/9PxaQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4527
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpQ
bHMgaWdub3JlIHRoaXMgcGF0Y2guDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBQYW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPg0KU2VudDogMjAyMMTqOdTCMjnI1SAx
MzoxNw0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogS29lbmlnLCBDaHJp
c3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxl
eGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFBhbiwgWGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+
DQpTdWJqZWN0OiBbUEFUQ0hdIGFtZC9hbWRncHU6IEZpeCByZXN2IHNoYXJlZCBmZW5jZSBvdmVy
Zmxvdw0KDQpbICAxNzkuNTU2NzQ1XSBrZXJuZWwgQlVHIGF0IGRyaXZlcnMvZG1hLWJ1Zi9kbWEt
cmVzdi5jOjI4MiENCltzbmlwXQ0KWyAgMTc5LjcwMjkxMF0gQ2FsbCBUcmFjZToNClsgIDE3OS43
MDU2OTZdICBhbWRncHVfYm9fZmVuY2UrMHgyMS8weDUwIFthbWRncHVdIFsgIDE3OS43MTA3MDdd
ICBhbWRncHVfdm1fc2RtYV9jb21taXQrMHgyOTkvMHg0MzAgW2FtZGdwdV0gWyAgMTc5LjcxNjQ5
N10gIGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZy5jb25zdHByb3AuMCsweDI5Zi8weDM5MCBb
YW1kZ3B1XSBbICAxNzkuNzIzOTI3XSAgPyBmaW5kX2hlbGRfbG9jaysweDM4LzB4OTAgWyAgMTc5
LjcyODE4M10gIGFtZGdwdV92bV9oYW5kbGVfZmF1bHQrMHgxYWYvMHg0MjAgW2FtZGdwdV0gWyAg
MTc5LjczNDA2M10gIGdtY192OV8wX3Byb2Nlc3NfaW50ZXJydXB0KzB4MjQ1LzB4MmUwIFthbWRn
cHVdIFsgIDE3OS43NDAzNDddICA/IGtnZDJrZmRfaW50ZXJydXB0KzB4YjgvMHgxZTAgW2FtZGdw
dV0gWyAgMTc5Ljc0NTgwOF0gIGFtZGdwdV9pcnFfZGlzcGF0Y2grMHgxMGEvMHgzYzAgW2FtZGdw
dV0gWyAgMTc5Ljc1MTM4MF0gID8gYW1kZ3B1X2lycV9kaXNwYXRjaCsweDEwYS8weDNjMCBbYW1k
Z3B1XSBbICAxNzkuNzU3MTU5XSAgYW1kZ3B1X2loX3Byb2Nlc3MrMHhiYi8weDFhMCBbYW1kZ3B1
XSBbICAxNzkuNzYyNDY2XSAgYW1kZ3B1X2lycV9oYW5kbGVfaWgxKzB4MjcvMHg0MCBbYW1kZ3B1
XSBbICAxNzkuNzY3OTk3XSAgcHJvY2Vzc19vbmVfd29yaysweDIzYy8weDU4MCBbICAxNzkuNzcy
MzcxXSAgd29ya2VyX3RocmVhZCsweDUwLzB4M2IwIFsgIDE3OS43NzYzNTZdICA/IHByb2Nlc3Nf
b25lX3dvcmsrMHg1ODAvMHg1ODAgWyAgMTc5Ljc4MDkzOV0gIGt0aHJlYWQrMHgxMjgvMHgxNjAg
WyAgMTc5Ljc4NDQ2Ml0gID8ga3RocmVhZF9wYXJrKzB4OTAvMHg5MCBbICAxNzkuNzg4NDY2XSAg
cmV0X2Zyb21fZm9yaysweDFmLzB4MzANCg0KRm9yIHVubG9ja2VkIGNhc2UsIHdlIGFkZCBsYXN0
X3VubG9ja2VkIGZlbmNlIHRvIHJvb3QgYm8gcmVzdiBpZiBpdCBoYXMgbm90IGJlZW4gc2lnbmFs
ZWQuDQpBbmQgd2Ugd2lsbCBhZGQgYW5vdGhlciBqb2IgZmVuY2UgdG8gcm9vdCBibyByZXN2IGlu
IC0+Y29tbWl0KCkuIFRoYXQgY2F1c2VzIHRoZSBzaGFyZWQgZmVuY2UgY291bnQgYmlnZ2VyIHRo
YW4gaXQgcmVzZXJ2ZXMuDQoNClNpZ25lZC1vZmYtYnk6IHhpbmh1aSBwYW4gPHhpbmh1aS5wYW5A
YW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwg
MSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jDQppbmRleCAzNzIyMWI5OWNhOTYuLjc3Njg5Y2VjZDE4OSAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQorKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KQEAgLTE2MTUsNiArMTYxNSw3
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LA0KIHN0cnVjdCBkbWFfZmVuY2UgKnRtcCA9IGRtYV9mZW5jZV9nZXRfc3R1
YigpOw0KDQogYW1kZ3B1X2JvX2ZlbmNlKHZtLT5yb290LmJhc2UuYm8sIHZtLT5sYXN0X3VubG9j
a2VkLCB0cnVlKTsNCitkbWFfcmVzdl9yZXNlcnZlX3NoYXJlZCh2bS0+cm9vdC5iYXNlLmJvLT50
Ym8uYmFzZS5yZXN2LCAxKTsNCiBzd2FwKHZtLT5sYXN0X3VubG9ja2VkLCB0bXApOw0KIGRtYV9m
ZW5jZV9wdXQodG1wKTsNCiB9DQotLQ0KMi4yNS4xDQoNCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
