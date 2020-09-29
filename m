Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783E7C4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 14:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5A620757
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 14:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4ZtXJXtp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5A620757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 432F689C60;
	Tue, 29 Sep 2020 14:46:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 736A289C60
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 14:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksLCoFFc0z2es8a6IXUfwiNfLRuEpL1gyTVrsvjbWZYotd8DQXqPCMhr0hO6eS+o0/n2Q3g80nnNv8izaQluQygwZjD2IW8CYA6GZEf8tq+IFNQy5qM3cbgOdXHcDZWErltzxdrxXEbuiEaozqOv1vtpnu3d5GlQIFrRjAIS2rUYY1QhCBxzcywdST5Qd45QqwF+p3CKlUfwpvCRUqC3U6FJyzOE2+HuR7VBcNYCIP7m7G95vBilrAt2XG5rJ0Js/sGn6TTuCqPp8d1LTuKTqtECTvQUGuTN0nsXFapxuat20BB63rDd1J1Nl5eycO/YlS5wiR4y64IJf+rVYxezUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+9wcPNxgbhp4ci8U2inKc0Lv9SM0OEF3tOF5Csvw6c=;
 b=GxUnghg0Z6QESCINe6B6FF3aHKlLZwUwZDcBzKcXk4Na7947ECdO1RRbLZa4t7bV5T4GjiEufyWaVGJyHwQJaD7NLVTQnCZqoUprNyCZ8VkAOoIgYdw/MHfHsFM9a5n5s2il9gPWjZAtrldK61yT+4fRaHnjEFvb1jl+o5n8xAZq/wNXgNlwesSOSLdCrl5YVko1tuKzuT8dt7/Wuw5dCEHvmM2kUTvGDuobT768B5oRJjIskJNSDULc1j6mS/w67Ib3L7mg3x1uxkrIRD4Tb8v1Xsjd4zoVndJ2MXKtPX5okabm6MmrzzJhARYgfzExwYjIUhkXXJi5Y4MHekpeXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+9wcPNxgbhp4ci8U2inKc0Lv9SM0OEF3tOF5Csvw6c=;
 b=4ZtXJXtprtwNLZeeSrNbf3iXi4ojLygc8jd2Fy8OBhXe1PBeN62plfdYPhm7oeHl8sd41eoQBLfQbsMLILZLCs+Tp/w7ep3A8y3u6jHdjKPS2Z7E2ePfSPGOPnA5liiDeH94hA2l5eqK/HjYqT/XsaTvu/DoZH2qJeT9vVmQbYc=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Tue, 29 Sep
 2020 14:46:07 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 14:46:07 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Use SKU instead of DID for FRU check
Thread-Topic: [PATCH] drm/amdgpu: Use SKU instead of DID for FRU check
Thread-Index: AQHWllQhSz4VjgQUnkyADJ6vlmBNDKl/r3KAgAABy9A=
Date: Tue, 29 Sep 2020 14:46:07 +0000
Message-ID: <DM6PR12MB37212497F5C52CD722E81CD185320@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200929113139.5069-1-kent.russell@amd.com>
 <83ef8e06-940d-dd0b-68d7-278cbd4b309c@amd.com>
In-Reply-To: <83ef8e06-940d-dd0b-68d7-278cbd4b309c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-29T14:46:04Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f4e29f07-1cb4-486c-bd7d-000009353d6f;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-29T14:45:52Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: cf6a8b73-395b-4b51-83ba-0000ffdbd3f3
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-29T14:46:05Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 77027bef-2cc0-42e2-9135-00002bc6f9fc
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1c80:6680:54ad:8bfd:9ea8:457f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 129b1c93-5fc3-4559-b2b6-08d8648665fc
x-ms-traffictypediagnostic: DM6PR12MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4515D9C5FD8C567C43904C5C85320@DM6PR12MB4515.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jI2H+06hSXeaQWAWtwR7A5rJ+xiquC0Icste+JYwb33r1QCzZqUWVceUfLAw93b9X7hWwXAmV4XSBT5r9URKdF6drbA0WNipdHOaNwYSyvms1L6rNIYGcgq5uqRnGI7JZeLeLZxp940uHMjzgnwsD/ACtrXrvjEI0vlZyRnHrT1tT2KXkdCVcFmsW6RvfNYso+UO0i/K9CuyP8DyIIxm93+XarrbnIP7PQLsaJUooidc6o+KCIZMLCp//+hj3CGuLVGXae57dKHG0rcpSCVfL8Jzn6msmduRtqp09Dqmw8CPSFOZNQZk9ihWbR7IQny94QvXj7svgw3tS8SR5Ep31g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(8676002)(8936002)(478600001)(33656002)(83380400001)(76116006)(71200400001)(53546011)(6506007)(66446008)(64756008)(66556008)(66476007)(66946007)(86362001)(55016002)(9686003)(5660300002)(186003)(52536014)(2906002)(7696005)(316002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: hBOfddjL3hZJb7JYv8AscrD4RIkzpACSAWkhWwbQnZ1cy0RCLpGbUG21SOF9k9acGpiJhz2MNIMnrxfZJxQTHBQ5YSToc2JYueeVz7HGvc46gMxCp6KOWhGpGf0MiNV1Ok5XmT72QW8cvixpo+co7RmctMzZDafpw7X1z1q5l+PO5pJ3Po81p/8CN0o1GVUa7C1Xz1MqZOJJtb/7hGAjE778oCdlVEkv5bIUCJatD9hhNrWFQjAsP4mfMZrW+kG1nhscf7NtJML4HK3/MzFt+UkVhefzt20MtEvTo8DGIXr61Qu5ie+PAQTddJO/nc2cBPuTUAPFPkyF+C4x4EU7t1kerXhlotib/trNLLDMwKlA0WgKtL4Xvv0Vi36YUYcUzv4r9RcmoSAPQo9U0cumxsCjx6GQnaptNHj7kTq+bJlsz5IB6AMX32tnVLLyIE0tOJRKQuiK9krjHZmH7J9v7ybty2YW5gkwjPIObo1iIMc7dtkmwO40bijBcLneIhQaTkRT+wla0GLJKdWfxXYz1uo0ilJ0VYRWYuS9MKUJUCtD9SoKj2XD9oF7aVM5rHE2F4nbZS9BdUb5tIgtB0DLsLe/zNfznflnbmHQ+Et2DNjnEiKO4q16nphwWlX/gEJmTgz+UOy2M6LZGm97HuiEbYg8f42jrQUta0WVPfnmXpDZ1/3XqO9nz3AJ6SMsJg5Gotim+Umk0tnj7uHYYvqVZA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129b1c93-5fc3-4559-b2b6-08d8648665fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 14:46:07.1640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ifaq5sR+Zbj6yIsFjARXx1o8YAA6weY3BXsHhLMBzCD+w3YafM1LfLUAs/SIgDuhj9YkraKmp78jfv/ZX/C+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4515
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IFR1
ZXNkYXksIFNlcHRlbWJlciAyOSwgMjAyMCAxMDozNyBBTQ0KPiBUbzogUnVzc2VsbCwgS2VudCA8
S2VudC5SdXNzZWxsQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBVc2UgU0tVIGluc3RlYWQgb2YgRElEIGZv
ciBGUlUgY2hlY2sNCj4gDQo+IA0KPiBBbSAyMDIwLTA5LTI5IHVtIDc6MzEgYS5tLiBzY2hyaWVi
IEtlbnQgUnVzc2VsbDoNCj4gPiBUaGUgVkcyMCBESURzIDY2YTAsIDY2YTEgYW5kIDY2YTQgYXJl
IHVzZWQgZm9yIHZhcmlvdXMgU0tVcyB0aGF0IG1heSBvciBtYXkNCj4gPiBub3QgaGF2ZSB0aGUg
RlJVIEVFUFJPTSBvbiBpdC4gUGFyc2UgdGhlIFZCSU9TIHRvIGNoZWNrIGZvciBzZXJ2ZXIgU0tV
DQo+ID4gdmFyaWFudHMgKEQxMzEgb3IgRDEzNCkgdW50aWwgYSBtb3JlIGdlbmVyYWwgc29sdXRp
b24gY2FuIGJlIGRldGVybWluZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLZW50IFJ1c3Nl
bGwgPGtlbnQucnVzc2VsbEBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMgICAgfCAzNyArKysrKysrKysrKysrLS0tLS0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1
X2VlcHJvbS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZydV9lZXBy
b20uYw0KPiA+IGluZGV4IGU4MTFmZWNjNTQwZi4uODIyMDdiNzU4ODAwIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jDQo+ID4g
QEAgLTM0LDE4ICszNCwzMyBAQA0KPiA+DQo+ID4gIHN0YXRpYyBib29sIGlzX2ZydV9lZXByb21f
c3VwcG9ydGVkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiA+ICB7DQo+ID4gLQkvKiBU
T0RPOiBHYW1pbmcgU0tVcyBkb24ndCBoYXZlIHRoZSBGUlUgRUVQUk9NLg0KPiA+IC0JICogVXNl
IHRoaXMgaGFjayB0byBhZGRyZXNzIGhhbmdzIG9uIG1vZHByb2JlIG9uIGdhbWluZyBTS1VzDQo+
ID4gLQkgKiB1bnRpbCBhIHByb3BlciBzb2x1dGlvbiBjYW4gYmUgaW1wbGVtZW50ZWQgYnkgb25s
eSBzdXBwb3J0aW5nDQo+ID4gLQkgKiB0aGUgZXhwbGljaXQgY2hpcCBJRHMgZm9yIFZHMjAgU2Vy
dmVyIGNhcmRzDQo+ID4gLQkgKg0KPiA+IC0JICogVE9ETzogQWRkIGxpc3Qgb2Ygc3VwcG9ydGVk
IEFyY3R1cnVzIERJRHMgb25jZSBjb25maXJtZWQNCj4gPiArCS8qIFRPRE86IFNlZSBpZiB3ZSBj
YW4gZmlndXJlIHRoaXMgb3V0IGR5bmFtaWNhbGx5IGluc3RlYWQgb2YNCj4gPiArCSAqIGhhdmlu
ZyB0byBwYXJzZSBWQklPUyB2ZXJzaW9ucy4NCj4gPiAgCSAqLw0KPiA+IC0JaWYgKChhZGV2LT5h
c2ljX3R5cGUgPT0gQ0hJUF9WRUdBMjAgJiYgYWRldi0+cGRldi0+ZGV2aWNlID09IDB4NjZhMCkg
fHwNCj4gPiAtCSAgICAoYWRldi0+YXNpY190eXBlID09IENISVBfVkVHQTIwICYmIGFkZXYtPnBk
ZXYtPmRldmljZSA9PSAweDY2YTEpIHx8DQo+ID4gLQkgICAgKGFkZXYtPmFzaWNfdHlwZSA9PSBD
SElQX1ZFR0EyMCAmJiBhZGV2LT5wZGV2LT5kZXZpY2UgPT0gMHg2NmE0KSkNCj4gPiAtCQlyZXR1
cm4gdHJ1ZTsNCj4gPiAtCXJldHVybiBmYWxzZTsNCj4gPiArCXN0cnVjdCBhdG9tX2NvbnRleHQg
KmF0b21fY3R4ID0gYWRldi0+bW9kZV9pbmZvLmF0b21fY29udGV4dDsNCj4gPiArCWNoYXIgbW9k
ZWxbM107DQo+ID4gKwlpbnQgbW9kZWxudW07DQo+ID4gKw0KPiA+ICsJLyogVkJJT1MgaXMgb2Yg
dGhlIGZvcm1hdCAjIyMtRFhYWFhZWS1YWC4gV2Ugb25seSB3YW50IHRoZSBmaXJzdA0KPiANCj4g
SSdtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCB0aGUgZm9ybWF0IGhlcmUuIFRoZXJlIGFyZSBmb3Vy
IFgsIGJ1dCB5b3UNCj4gb25seSB3YW50IHRoZSBmaXJzdCB0aHJlZSBvZiB0aGVtPw0KPiANCj4g
V2hhdCBhcmUgdGhlIHR3byBYIGluIHRoZSBlbmQ/IGFyZSB0aGV5IHJlbGF0ZWQgdG8gdGhlIGZp
cnN0IGZvdXIgWD8NCkkgdHJpZWQgdG8gZWRpdCBpdCBidXQgbWFkZSBhIG1pc3Rha2UsIGl0IHNl
ZW1zLiBJdCBzaG91bGQgYmUgIyMjLURYWFhZWS1aWiAuIEFuZCB0aGUgbGFzdCAyIGFyZSB1bnJl
bGF0ZWQsIHRoZXkncmUgZm9yIGZ1cnRoZXIgZGlmZmVyZW50aWF0aW9uLg0KPiANCj4gDQo+ID4g
KwkgKiAzIGRpZ2l0cyBhZnRlciB0aGUgRCwgYW5kIGlmIHdlIGNvbnZlcnQgaXQgdG8gYSBoZXgg
aW50ZWdlciwNCj4gPiArCSAqIHdlIGNhbiB1c2Ugc3dpdGNoIGZvciBlYXNlL3NwZWVkL3JlYWRh
YmlsaXR5IGFuZCBwb3RlbnRpYWwNCj4gPiArCSAqIGV4cGFuZGFiaWxpdHkgaWYgcmVxdWlyZWQN
Cj4gPiArCSAqLw0KPiA+ICsJc3RybmNweShtb2RlbCwgYXRvbV9jdHgtPnZiaW9zX3ZlcnNpb24g
KyA1LCAzKTsNCj4gDQo+IFRoaXMgcHJvZHVjZXMgYSBzdHJpbmcgaW4gX21vZGVsXyB0aGF0J3Mg
bm90IDAtdGVybWluYXRlZC4NCj4gDQo+IA0KPiA+ICsJbW9kZWxudW0gPSBzdHJ0b3VsKG1vZGVs
LCBOVUxMLCAxNik7DQo+IA0KPiBVc2luZyBzdHJ0b3VsIG9uIGEgbm9uLXRlcm1pbmF0ZWQgc3Ry
aW5nIGlzIG5vdCByZWxpYWJsZS4NClJpZ2h0ISBUaGFua3MsIEknbGwgY2xlYW4gdGhhdCB1cC4N
Cg0KPiANCj4gUmVnYXJkcywNCj4gwqAgRmVsaXgNCj4gDQo+IA0KPiA+ICsJc3dpdGNoIChhZGV2
LT5hc2ljX3R5cGUpIHsNCj4gPiArCWNhc2UgQ0hJUF9WRUdBMjA6DQo+ID4gKwkJc3dpdGNoICht
b2RlbG51bSkgew0KPiA+ICsJCS8qIFRoZXNlIGFyZSB0aGUgc2VydmVyIFZHMjAgU0tVcyAqLw0K
PiA+ICsJCWNhc2UgMHgxNjE6DQo+ID4gKwkJY2FzZSAweDE2MzoNCj4gPiArCQkJcmV0dXJuIHRy
dWU7DQo+ID4gKwkJZGVmYXVsdDoNCj4gPiArCQkJcmV0dXJuIGZhbHNlOw0KPiA+ICsJCX0NCj4g
PiArCWRlZmF1bHQ6DQo+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+ICsJfQ0KPiA+ICB9DQo+ID4N
Cj4gPiAgc3RhdGljIGludCBhbWRncHVfZnJ1X3JlYWRfZWVwcm9tKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LCB1aW50MzJfdCBhZGRycHRyLA0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
