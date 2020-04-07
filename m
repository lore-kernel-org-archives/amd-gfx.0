Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85E2C2D0EC
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 20:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FCC2074B
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 20:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Cp7H/wrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FCC2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CF206E8FD;
	Tue,  7 Apr 2020 20:29:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B75D6E8FD
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 20:29:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUNh3WtmnF87A1N8SIqAdZEp8aGJ1JFpk7ZacIZDGXeQLWakqIxAkqVbcShIBKPOXIO6goBSrYBhwK2Td24qWUJ8hLKCuC9siD9IlA4205nv9XO0bPsCnFZb1gvP5hFfjyA13loI1AWvFMKocERm7dsjvccF0aXNvaEDNd09Pj3wKeKwmZTpNpdseMKK7gLD/MBh7SeKTgKdb7cbA9bmJ1T0GOt4+H+MvkOeDNkmJXAFhrfc9A18ZnCPA33e8XPdcm2XingjW+znfLD9LGDRboLnrTEweRHeVqyT+2Xp+egejY2Eftnbsnr629lQiv0S9HJoBifXaTdiX+Lj8J5iSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pskC9fPP8/QAJoRReuj5mv4nHskRWhft83LIypjam04=;
 b=UTs4JfhIDoAwq7kBsHEO5fkpIbdfnwFvuN8sY34ATaUHK8FwtMPLMBvQuUyXM2jalZobBtnEzaXG3RdvarSXH8OVc7ncP1Ggw2Jkwrcfl4m4adpXkhQjUqigt6LJkuryov4/ykDvLMhIkwHID/kfxvZjAKMraATJvBwH3L6loabcBKmGN3x4FqjOe1qyX2fzRK3vc12a0OlYF4+q+b/I+t5XLgNNdLWWr1I6xYXv8wvj99ktUHOL5OjR0T4WpOZnNHwmMVqhzGG6O8av9xfhGE1TVcbMuXsO2XoTxXZQt8/+pl2v2oM7PtamS83+Jv/iwYiF9nqmAVwlKWulMYvNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pskC9fPP8/QAJoRReuj5mv4nHskRWhft83LIypjam04=;
 b=Cp7H/wrUY65Nbce7Vn2oL286odnp3YKeZZGLzzqYNPqWOh320lK8jiFBJ44ffdmVbEDoyg1529nciOue/0BwWX3ZtwAHksLs29gAC5szJ1WxA3QoR8LzkiU2obUzaBly7h73c9uH0MIG0otb0DkTgpiDoQoDbomgl9MeHUKQmiU=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3867.namprd12.prod.outlook.com (2603:10b6:5:1cf::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Tue, 7 Apr
 2020 20:29:27 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 20:29:27 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/eeprom: fix possible read overflow in memcpy
Thread-Topic: [PATCH] drm/amdgpu/eeprom: fix possible read overflow in memcpy
Thread-Index: AQHWDOx/6mtNBQXua0q+B1/79IYCY6huHIjA
Date: Tue, 7 Apr 2020 20:29:27 +0000
Message-ID: <DM6PR12MB372164AD3A91FFDC824C5F1D85C30@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200407145431.1090867-1-alexander.deucher@amd.com>
In-Reply-To: <20200407145431.1090867-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-07T20:29:25Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b62799d6-8053-4de3-8f2f-00003ac36017;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-07T20:29:25Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 16710d0c-1b70-42b3-8a82-000039ab5049
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
x-originating-ip: [2607:fea8:1c80:c44:bc29:3f7f:1ee3:a6d4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ffcd7ff6-3205-4db7-7d72-08d7db325e60
x-ms-traffictypediagnostic: DM6PR12MB3867:|DM6PR12MB3867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3867CA2482A2762052319DF585C30@DM6PR12MB3867.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 036614DD9C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(81156014)(186003)(55016002)(4326008)(2906002)(76116006)(316002)(6506007)(9686003)(7696005)(66946007)(8676002)(110136005)(81166006)(53546011)(64756008)(66556008)(71200400001)(66476007)(8936002)(66446008)(478600001)(86362001)(5660300002)(52536014)(966005)(33656002)(45080400002);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SEY7IRrZ6HVGMJi+D0L78xXOzA5hYN+Z9H8XUWxap0AsFycGs67dYzsHpz4rs/KJdOTCmO8zUV0yxMihO3QjamW69Vqpg42zw/uPZGEdiLw3yw+UyBgQHkMQd+1dN7ulj6eirTzjZu8Vk+3c9L+y548irMs2FQmH3OFC4vglLtn0Uo9BmMZu+mAKJWzUY58qo9w58SqspyZ5E0GFFm053BxGumF1TwAOx6INxrufjW3cuNcbBRgyXyfG9TAyIyU13XkdR0NH+gM/MEb2Txpcy0j8e2LJG5FDxN2PWHO8cBZOVyS+CmSCRK9VfnAvso79IPOzQzH2b/2V19wkWWt0sIv+SHaBI3Zyqhg1Vg86oUI0rOXi8Qlp2uA272cCMfitB+bd0dBSVZeMP5mKpHfCJOjyyvyG3qt+YZlaT8uUEiCVJO9Y80f4t2ZrjGNE3gZL8Ba+VVhVAUuRy1ZfGbbFuNuybPbHbnwaeK/y8jlyigKHMpbLHoECv0hpqAfU5CDBe7jcqlfWCIj7tDE1mKDc1w==
x-ms-exchange-antispam-messagedata: N1lKQ1gXhZEzPAC0HIuzEyyGUFgqO8kwgD7MfCUP3HZAovh5jB8tQrmpEfq5g2agPdSfOlzfDFZbgZgpYBsggN9Y8CnCBQ/wOS4RX1GBpBms9xrZjWDmWBzc87PI26yP3VMVInoNGKercikTlRoDdZZs4cEeGekf/olKJBprLIk75pN4AWK3KhmwSs98r2KDKhTYN1yeDdSiOFVAbklN6A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcd7ff6-3205-4db7-7d72-08d7db325e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2020 20:29:27.2905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VH1cASgDf9k0FGkArwlV9Aq8BiQqGda68Z5rdgPTH2lRgX7GMfZLjyH6l3oNYh6iggCUiiCyTU+exBbYpZfCzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3867
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpU
aGFua3MgQWxleA0KDQpSZXZpZXdlZC1CeTogS2VudCBSdXNzZWxsIDxrZW50LnJ1c3NlbGxAYW1k
LmNvbT4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4IDxh
bWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleA0K
PiBEZXVjaGVyDQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDcsIDIwMjAgMTA6NTUgQU0NCj4gVG86
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIg
PEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdw
dS9lZXByb206IGZpeCBwb3NzaWJsZSByZWFkIG92ZXJmbG93IGluIG1lbWNweQ0KPiANCj4gVGhl
IHNpemUgY291bGQgYmUgdXAgdG8gMzIgYnl0ZXMgYW5kIHdlIHN0YXJ0IGZyb20gaW5kZXggMi4N
Cj4gDQo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuL2luY2x1ZGUvbGludXgvdXVpZC5oOjEyLA0K
PiAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L21vZF9kZXZpY2V0YWJsZS5o
OjEzLA0KPiAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L3BjaS5oOjI3LA0K
PiAgICAgICAgICAgICAgICAgIGZyb20gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2ZydV9lZXByb20uYzoyMzoNCj4gSW4gZnVuY3Rpb24g4oCYbWVtY3B54oCZLA0KPiAgICAgaW5s
aW5lZCBmcm9tIOKAmGFtZGdwdV9mcnVfZ2V0X3Byb2R1Y3RfaW5mb+KAmSBhdA0KPiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jOjEzNzoyOg0KPiAuL2luY2x1
ZGUvbGludXgvc3RyaW5nLmg6Mzc2OjQ6IGVycm9yOiBjYWxsIHRvIOKAmF9fcmVhZF9vdmVyZmxv
dzLigJkgZGVjbGFyZWQgd2l0aA0KPiBhdHRyaWJ1dGUgZXJyb3I6IGRldGVjdGVkIHJlYWQgYmV5
b25kIHNpemUgb2Ygb2JqZWN0IHBhc3NlZCBhcyAybmQgcGFyYW1ldGVyDQo+ICAgMzc2IHwgICAg
X19yZWFkX292ZXJmbG93MigpOw0KPiAgICAgICB8ICAgIF5+fn5+fn5+fn5+fn5+fn5+fg0KPiBt
YWtlWzRdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjY2Og0KPiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5vXSBFcnJvciAxDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZydV9lZXByb20uYyB8IDIgKy0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9t
LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jDQo+
IGluZGV4IDlkMTc3NjE3MjFkZS4uYzdlNTVmZTE3MGJkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZnJ1X2VlcHJvbS5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mcnVfZWVwcm9tLmMNCj4gQEAgLTg1LDcgKzg1LDcg
QEAgaW50IGFtZGdwdV9mcnVfcmVhZF9lZXByb20oc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFk
ZXYsIHVpbnQzMl90IGFkZHJwdHIsDQo+IA0KPiAgaW50IGFtZGdwdV9mcnVfZ2V0X3Byb2R1Y3Rf
aW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikgIHsNCj4gLQl1bnNpZ25lZCBjaGFyIGJ1
ZmZbMzJdOw0KPiArCXVuc2lnbmVkIGNoYXIgYnVmZlszNF07DQo+ICAJaW50IGFkZHJwdHIgPSAw
LCBzaXplID0gMDsNCj4gDQo+ICAJaWYgKCFpc19mcnVfZWVwcm9tX3N1cHBvcnRlZChhZGV2KSkN
Cj4gLS0NCj4gMi4yNS4xDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcg0KPiBlZWRlc2t0b3Aub3JnJTJGbWFp
bG1hbiUyRmxpc3RpbmZvJTJGYW1kLQ0KPiBnZngmYW1wO2RhdGE9MDIlN0MwMSU3Q2tlbnQucnVz
c2VsbCU0MGFtZC5jb20lN0NhYzM2NTc0YjE2MzQ0NjhmMg0KPiA2MWEwOGQ3ZGIwMzljYjAlN0Mz
ZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNg0KPiAzNzIxODY4MDkz
ODQxNTE2NCZhbXA7c2RhdGE9dWF4U3d6MTI5SFZLYjFBM3JHN3l4em9ic2lRQU5ucjZlV1QNCj4g
SWF4VmlqWU0lM0QmYW1wO3Jlc2VydmVkPTANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
