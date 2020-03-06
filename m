Return-Path: <SRS0=1gsM=4X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AA3C3F2CE
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 03:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7FF820732
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 03:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QBRRKYCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FF820732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B62889CA0;
	Fri,  6 Mar 2020 03:31:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B13AD89CA0
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2020 03:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoVt4fM2fNcYjcTaMbzI0qwvOlJ917rHsty/ny2Uau2aAT4VodfpBUfGBYElCt/Kr0/SBBmCtkzLPjIKoY5vOfbD7+ixU31BNwhlaQRoQUUix0AZVW+0lGIQMzMHe+2G7vIeYHRe/TtXlUAjeCXqX5bbVIDLSk1KiFT3gBGC1vchHNZqCRhA1aHAR/+LBLu1QmxhWigcS3bAyztZH1x7xX5aU1hYvUpQTvvZ/3EWhLetipXf/j091hRU0XOIPoY77f4dfoiofmiuZNIjH3UGshYBfPxkGrtsobYnOStQYS+M1FR6vr1pqFfJMqEh6uoy6wepEtmGeAtI26BBOyoplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP1zEffWQW9xaO8b9VY0LlPkga9V3pXMyg7x+1URysY=;
 b=CjN+z7xaWmOIBhEOgResdUlVP2doLOQ6PdeM4o3/CaqXprNur22AxkFN6MDV1m8vaMRYa+3TA51X0nkULLuC8h186FVL+NgyrlwRFjJYQV98woharZgt4ySZAncufdc12nWPW9maB9RBHvUuI9CT+omUFd6tKt5RQOoK5BOa4p/rnv5jFuRN8Rdz7buLdaw/8GXRArocNW6lpTLtj9ey62ZAXdhHiSbuBTOonBZ8VTKGHwTb9ehVUp++u7rHCjKU/bJx/GBJvkXCG0lR8BHvpIDMKwRWIor81mmaHxt2vF6RJCA0SKBMw4G1tnq/RUO/8jhMvEN/oexUBc1sbbAUEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP1zEffWQW9xaO8b9VY0LlPkga9V3pXMyg7x+1URysY=;
 b=QBRRKYCWqhag2Vu5qsFI5hxQbTXY9BtRagDGkVeimYp0FoRtQ7uRy1wSWio3t0ZNQDCwDIYFljdQz7lVGDFA3qcqmczX9gpH7oVCn+pDcvX933UvcYGUOHY9086vuje68OD11p2JKz4nKiZzvOlxv7aOLFAmrHQbVJZuiCSdIQ4=
Received: from MN2PR12MB2975.namprd12.prod.outlook.com (2603:10b6:208:ce::14)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Fri, 6 Mar
 2020 03:31:14 +0000
Received: from MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::8d41:5fd9:6b89:c593]) by MN2PR12MB2975.namprd12.prod.outlook.com
 ([fe80::8d41:5fd9:6b89:c593%3]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 03:31:13 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Monk"
 <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [enable VCN2.0 for NV12 SRIOV 6/6] drm/amdgpu: clear warning on
 unused var
Thread-Topic: [enable VCN2.0 for NV12 SRIOV 6/6] drm/amdgpu: clear warning on
 unused var
Thread-Index: AQHV8vK+7KTdY7JPWkK9wD5RNlCIzKg6AGUAgADo2WA=
Date: Fri, 6 Mar 2020 03:31:13 +0000
Message-ID: <MN2PR12MB297596D3FD58CADAD059B50B8FE30@MN2PR12MB2975.namprd12.prod.outlook.com>
References: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
 <1583415187-16594-6-git-send-email-Monk.Liu@amd.com>
 <576079d2-c733-d13e-49f6-570311fd9573@gmail.com>
In-Reply-To: <576079d2-c733-d13e-49f6-570311fd9573@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-06T03:31:10Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=96edc305-e1cd-47ae-8de0-0000d169021d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-06T03:31:10Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 22d734ee-2f22-461f-8688-0000d6cb455e
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Emily.Deng@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20626f39-ec61-4b6d-8d9f-08d7c17ed285
x-ms-traffictypediagnostic: MN2PR12MB4206:|MN2PR12MB4206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4206579D4A4771BC37DCBC708FE30@MN2PR12MB4206.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:73;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(199004)(189003)(2906002)(186003)(9686003)(55016002)(26005)(478600001)(45080400002)(52536014)(71200400001)(5660300002)(33656002)(66574012)(66946007)(8936002)(110136005)(76116006)(316002)(7696005)(81156014)(66446008)(8676002)(66556008)(86362001)(81166006)(6506007)(66476007)(64756008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4206;
 H:MN2PR12MB2975.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0WM0kgcEoDdfw2hvMoXV99wwh+aBUtJ76VM4XeRmf3BE3onrm6eHl5aOWx8lL6xh0FqXNNwJWpxAii4IApDqqYQab0ZyMfsgF/IM6S9BwYGZOEpPYfo8yV0cM+k+od7CFeoB1mFPJp0lpvEKBsfBikBJBEPIokPX/CWnZnjrEXtyJ5Tp0uYUAwlzx/RkxwXYREYUBmbFsHlFLV5rOtAtw4qRWlmJ5IiyjIA412ptBswKW1TdHdKTSJS+hjvzz/Z8nLFhMrCuC6r8HMuxTPl1VWs/KWFx6+5qOFNpQsOV7SQ+vTQQKuERM5nwaj9iU/GSTVfR9ZqyU/HC6461xMlqHrSmAbTwpmFSEqf0EwxYxd7LpvLJaQSR0T7du8m4ci7y4/52r/NNqLQp6BNMMQsW2YdTIFDT/BvicmssJ+E8DaraGnA9jc8csjU/T6Jf5z5Elc89c+GiXJZvPVN0w4e04YFTY6tuq7Vdu/r1C0uJcT4=
x-ms-exchange-antispam-messagedata: kf6wuG55yixM3/2lNyuA1eHWFoWacGdSyV9A383Sfn3ypudR0Fa5nWdMrZP+gXQCL87k24Kl2u1B7NbC3Pn6FkP+vLDLekWD0pmbL7QENCdub/bdqEI4I1FPEepf91vlrlcbVh7eAZH2CTMJd7oZLg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20626f39-ec61-4b6d-8d9f-08d7c17ed285
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 03:31:13.6963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4y7/B47WznDqgKDp44+ltmsqD//S+lZ5yeiOHLT/RySpeeYD+lGsVk6FVJavVU6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpT
ZXJpZXMgcmV2aWV3ZWQtYnk6IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdAYW1kLmNvbT4NCg0KPi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2Vz
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mDQo+Q2hyaXN0aWFuIEvDtm5pZw0K
PlNlbnQ6IFRodXJzZGF5LCBNYXJjaCA1LCAyMDIwIDk6MzcgUE0NCj5UbzogTGl1LCBNb25rIDxN
b25rLkxpdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj5TdWJqZWN0
OiBSZTogW2VuYWJsZSBWQ04yLjAgZm9yIE5WMTIgU1JJT1YgNi82XSBkcm0vYW1kZ3B1OiBjbGVh
ciB3YXJuaW5nDQo+b24gdW51c2VkIHZhcg0KPg0KPkFtIDA1LjAzLjIwIHVtIDE0OjMzIHNjaHJp
ZWIgTW9uayBMaXU6DQo+PiBTaWduZWQtb2ZmLWJ5OiBNb25rIExpdSA8TW9uay5MaXVAYW1kLmNv
bT4NCj4NCj5BY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPg0KPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
Y24uYyB8IDIgLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0KPmIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jDQo+PiBpbmRleCBhZTk3NTRm
Li5hNDEyNzJmIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Zjbi5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNu
LmMNCj4+IEBAIC00OTMsNyArNDkzLDYgQEAgc3RhdGljIGludCBhbWRncHVfdmNuX2RlY19nZXRf
ZGVzdHJveV9tc2coc3RydWN0DQo+YW1kZ3B1X3JpbmcgKnJpbmcsIHVpbnQzMl90IGhhbg0KPj4N
Cj4+ICAgaW50IGFtZGdwdV92Y25fZGVjX3JpbmdfdGVzdF9pYihzdHJ1Y3QgYW1kZ3B1X3Jpbmcg
KnJpbmcsIGxvbmcgdGltZW91dCkNCj4+ICAgew0KPj4gLQlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiA9IHJpbmctPmFkZXY7DQo+PiAgIAlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZTsNCj4+ICAg
CWxvbmcgcjsNCj4+DQo+PiBAQCAtNjU1LDcgKzY1NCw2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Zj
bl9lbmNfZ2V0X2Rlc3Ryb3lfbXNnKHN0cnVjdA0KPmFtZGdwdV9yaW5nICpyaW5nLCB1aW50MzJf
dCBoYW4NCj4+DQo+PiAgIGludCBhbWRncHVfdmNuX2VuY19yaW5nX3Rlc3RfaWIoc3RydWN0IGFt
ZGdwdV9yaW5nICpyaW5nLCBsb25nIHRpbWVvdXQpDQo+PiAgIHsNCj4+IC0Jc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Ow0KPj4gICAJc3RydWN0IGRtYV9mZW5jZSAqZmVu
Y2UgPSBOVUxMOw0KPj4gICAJc3RydWN0IGFtZGdwdV9ibyAqYm8gPSBOVUxMOw0KPj4gICAJbG9u
ZyByOw0KPg0KPl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQo+YW1kLWdmeCBtYWlsaW5nIGxpc3QNCj5hbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
Pmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRmxpc3RzLmZyDQo+ZWVkZXNrdG9wLm9yZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUy
RmFtZC0NCj5nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q0VtaWx5LkRlbmclNDBhbWQuY29tJTdDNjU1
NTRhNzhkNDdjNDQzMTYNCj4zZWUwOGQ3YzEwYTRjMGQlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4
MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjMNCj43MTkwMTIyMjkzNDMwODI2JmFtcDtzZGF0YT1EZWFE
bWdyVUY5eXF6MWRUbmpvdklIVTZVY2pHWDRyRXk2bGN5Qw0KPmhIeGVBJTNEJmFtcDtyZXNlcnZl
ZD0wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
