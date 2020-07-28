Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A7AC433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 10:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7740D204EA
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 10:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X2RfTVis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7740D204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 418B56E261;
	Tue, 28 Jul 2020 10:57:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A042E6E261
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 10:57:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjwqPqHCvTVb9FMf4OzTSX5ks9r0YvB2Y5veur6xUMklVU0lZWePGtcRJGB8BJq2B+9EB9Ub0AUTnYUQqdKRiO+6oxtDIqJ3UmnJk5dgOTJ1wLWiq9/8aT/xchzEtB/Z45TfOTtm6fA/d6doxX8PkrYtpPCM3L4QpVIBfHrMoeZ9ohNMtSXop2yLh9P3G83dBS/dtKyBafgy9XEQIkAmHeU4v9kkE/SVnMdjtju8VLoJqAeiDGIUN7kd3jEolRJ5j0JqcQGX1fjG0bvXaKXOs+lt0ugbMYbbIwSp8fQ8yvpk9SG9juC+8aXLdpgR1zoFJF+rWKmoQXh7ysF85IGySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ub7ly35W9rbW8+2WpcX+OJXyTRupOLmrphHp7QBi1k=;
 b=FfnKM14/wuOU13WachDqi+k5LIHNFjCcug1jTXQyQHu5qGAOQ6ywoBX0fXFwGNCF4MDppRTLRQaq1siFTSrvFXMi00ASBgN2N2aYpqeyK+ZWRYUEJrGVDvPOBvEgmUPY6yGAAXH8k5aGaO6YIS+rzu/1QFjP/8H0Pe6wyS3/6QrI5KdrhBoRdab4K904u2gG871v9j5eDkVxjYXUcDz+fvLAvtoYGRCOI0xJFpeJ/u50oEUPJCDuP3aSGiHRIOUJmrXRzU+jeyOYLaZT8HEJopGb6sZ8O3/GjtLbVcNefuWHSZYT3CUAnwa35y7MkB/EcE1X36Jg56nHqCtaigNEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ub7ly35W9rbW8+2WpcX+OJXyTRupOLmrphHp7QBi1k=;
 b=X2RfTVisPIzkSOUwdCx0PAnsXYbV/uLm9vSR8zpK0ZuFBG3T8pAtoXA4bRwD4saCsCf7pcQo7vbmZUpBB9QXU0wE7L1eFU8o/JAbDTe/saTGXjEj5vfxAmuuh/CYNDcWhUw0ulv0oNr6fa6mll1UZcs98RGLXqlyd/dmthvuYV8=
Received: from BYAPR12MB3493.namprd12.prod.outlook.com (2603:10b6:a03:dd::15)
 by BYAPR12MB2936.namprd12.prod.outlook.com (2603:10b6:a03:12f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Tue, 28 Jul
 2020 10:57:34 +0000
Received: from BYAPR12MB3493.namprd12.prod.outlook.com
 ([fe80::e855:8808:d701:359c]) by BYAPR12MB3493.namprd12.prod.outlook.com
 ([fe80::e855:8808:d701:359c%6]) with mapi id 15.20.3216.034; Tue, 28 Jul 2020
 10:57:34 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: assign the cpu/gpu address of fence from
 ring
Thread-Topic: [PATCH 4/4] drm/amdgpu: assign the cpu/gpu address of fence from
 ring
Thread-Index: AQHWZMkHqkwyQU55ykOrvvwtatC6Dqkc0dwA
Date: Tue, 28 Jul 2020 10:57:34 +0000
Message-ID: <BYAPR12MB3493E2ACABB6309DCFF1538BF6730@BYAPR12MB3493.namprd12.prod.outlook.com>
References: <20200728102154.2505095-1-Jack.Xiao@amd.com>
 <20200728102154.2505095-4-Jack.Xiao@amd.com>
In-Reply-To: <20200728102154.2505095-4-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-28T10:57:23Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=213ae78c-d4fc-458b-bc7a-00004abeda0c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-28T10:56:38Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 152a6301-c3ab-4265-8e73-0000dc5720c0
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-28T10:57:28Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 9c64fb60-9c2d-4dc7-b527-00006fb975f6
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f7720a2-4e89-48f2-a126-08d832e508a0
x-ms-traffictypediagnostic: BYAPR12MB2936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2936F381EB9D64869CA75E38F6730@BYAPR12MB2936.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UGlPOn4iPRfqI6wYHTiuiSzrzgqroW8nq0hEnsedLWF2HGaAMeD0Fkhd1p/5zXflfuU5/syQX4X1iKpDXy0X6vE2TCIbx7WptpXOgxmSe89GR8Te/62CjKRe2DkGHgKQi0OOx9VG0pw1cscjQkdA5v+dS8bps1SXVHUMkvSxYfeqKVaND6TS++5FtiGnXWIfn4BN75TL4Sgwtl4Tz7dBMBM8EBlWDdvVFWUhjV+qs4Zpel6TblNLpUwfDFcHgyX+eZqm0BFn1PfjKmXY1fUQ80p5FZdEvefJRpBsJf5aWjjJQBLppiAcvabDY0rCU8iq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3493.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(52536014)(55016002)(8936002)(6506007)(66946007)(76116006)(26005)(7696005)(53546011)(478600001)(71200400001)(4326008)(186003)(33656002)(6636002)(86362001)(2906002)(316002)(110136005)(8676002)(5660300002)(9686003)(66476007)(66556008)(66446008)(64756008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1dOdL5wHytv2+akRW4/8ZhN7ATwGXggXyjqWbOpryJynnNvr21FEDak9Z42GTjKDzPg64vqoqvvDrQoOX/YWnbaV805K5P6VtOfdlNXZAaARCl+Iq9V8fk/1rFPVkyzEqrj2rvTdw1f4/1JHnhHBIEhwNKWtsEJ6s0rya+nEsFI0/ucd8jCpaEuygf94kdFemtEfFfS72pNnYrdGctv5vFp4uY83NFzk0YX8amF7IaV3lEiG+BB1h6tHbm8RcrtwgCTcGYFNm9SheHvly4Zl26Ebe9WsrbmebF4W4mazVRlIX7QCWLX6pTC2Y4hkgPo/uWQl+3rHcVVvjLY/b1IT7kXSBCCjcv1jKEwNnB9ekHvzGjyCXOZOWDvJ9GUKouYxuCVgjagnbekwvBLcXoRswuHsyn58Cr6B1zBSW+Z4aEspwgj3gE+oD0IFKNj9OP7jIm2Ss01xFOSYYOTKvJP5lTKLE3RkwRH/jOwM57/B4bNAL8HQTsiKIv8gqnokM51V
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3493.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7720a2-4e89-48f2-a126-08d832e508a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 10:57:34.4030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JY0C0uug0Ygt78FlsbWYoelhtUP3tJCOh+NeCPTqsActq1WX91LqsXw+Prcl5aPy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2936
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpTZXJpZXMgaXMgUmV2aWV3ZWQtYnk6IExlIE1hIDxMZS5NYUBh
bWQuY29tPg0KDQpSZWdhcmRzLA0KTWEgTGUNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IFhpYW8sIEphY2sgPEphY2suWGlhb0BhbWQuY29tPiANClNlbnQ6IFR1ZXNkYXksIEp1
bHkgMjgsIDIwMjAgNjoyMiBQTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgSGF3
a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlh
bi5Lb2VuaWdAYW1kLmNvbT47IE1hLCBMZSA8TGUuTWFAYW1kLmNvbT4NCkNjOiBYaWFvLCBKYWNr
IDxKYWNrLlhpYW9AYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmln
QGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggNC80XSBkcm0vYW1kZ3B1OiBhc3NpZ24gdGhlIGNw
dS9ncHUgYWRkcmVzcyBvZiBmZW5jZSBmcm9tIHJpbmcNCg0KYXNzaWduIHRoZSBjcHUvZ3B1IGFk
ZHJlc3Mgb2YgZmVuY2UgZm9yIHRoZSBub3JtYWwgb3IgbWVzIHJpbmcgZnJvbSByaW5nIHN0cnVj
dHVyZS4NCg0KU2lnbmVkLW9mZi1ieTogSmFjayBYaWFvIDxKYWNrLlhpYW9AYW1kLmNvbT4NClJl
dmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQpBY2tlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KLS0tDQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgfCA0ICsrLS0NCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KaW5kZXggNThkNGMyMTkxNzhhLi4wYmUzZTIw
MDczODcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVu
Y2UuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMNCkBA
IC00MDcsOCArNDA3LDggQEAgaW50IGFtZGdwdV9mZW5jZV9kcml2ZXJfc3RhcnRfcmluZyhzdHJ1
Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsDQogCXVpbnQ2NF90IGluZGV4Ow0KIA0KIAlpZiAocmluZy0+
ZnVuY3MtPnR5cGUgIT0gQU1ER1BVX1JJTkdfVFlQRV9VVkQpIHsNCi0JCXJpbmctPmZlbmNlX2Ry
di5jcHVfYWRkciA9ICZhZGV2LT53Yi53YltyaW5nLT5mZW5jZV9vZmZzXTsNCi0JCXJpbmctPmZl
bmNlX2Rydi5ncHVfYWRkciA9IGFkZXYtPndiLmdwdV9hZGRyICsgKHJpbmctPmZlbmNlX29mZnMg
KiA0KTsNCisJCXJpbmctPmZlbmNlX2Rydi5jcHVfYWRkciA9IHJpbmctPmZlbmNlX2NwdV9hZGRy
Ow0KKwkJcmluZy0+ZmVuY2VfZHJ2LmdwdV9hZGRyID0gcmluZy0+ZmVuY2VfZ3B1X2FkZHI7DQog
CX0gZWxzZSB7DQogCQkvKiBwdXQgZmVuY2UgZGlyZWN0bHkgYmVoaW5kIGZpcm13YXJlICovDQog
CQlpbmRleCA9IEFMSUdOKGFkZXYtPnV2ZC5mdy0+c2l6ZSwgOCk7DQotLQ0KMi4yNi4yDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
