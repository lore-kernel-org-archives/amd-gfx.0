Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA67AC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 08:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BBE20BED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 08:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SoSBHiIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BBE20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CDAC6EA21;
	Wed, 14 Oct 2020 08:26:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E0CE6EA1D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 08:26:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePjmI5BvkzahBanPjs62p2ZjYTytlDOAk1XwuF7BIqkQdSyaqG7C50K5DYDwnPOkzGXIGntNbJLF7Pabnc+pZb2D/MiVna+sE37ySOcePJVXhBJPIpCCyXdurGku0sSJ1mBpMTjzesjAl8nMXvBeDpZZAfVOQCZ7nBt9GVDwBX+wZqVvQHeeetmciugupZ1wEs2qMjl+pnba7zX9uCtB22lu+DMWrh+/U2uoEMMYFdo2fAPZmQYd7O1Y+iDpm7iWZCfI+TRKp3Jq09wRtpEzgP8Ln/HybtqL3DTbtuhNTSTt8JVSVX7eOlDbEdF12no2XEgvp70bfkr1cQnqYVW4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KC83dtwC9DWa/2Y4bVmyZ1tRr1GS89q8M058ZjbAnes=;
 b=dIkPk20hahnQfHNAvcnwaXSS3Bd9ZUogXbrnkjB3tPdKLf3AozjJiYDyG6XKVb8ylwaT6aJSZZ3+qOuE4oQWP1v5dYRaiBa88W7RR1uKe63V8k+jV08KPExRmuCi4IaPfXOu65WRRxg13KQwfOr/tqvvbt7miJyLb6BU0H0gQW8w/dhMrcs2lvnNqVigNbDzsV1vt1tmSQAaCBReR5yuyRvLSg3QQTD1AC1ZWrc+DTa9LuPnffeRrS73c1m3JmpP/IyOqKhbwm3lF2q/piZbrHF/deERPZdf+k0niN+xZK+CLnftAqN2VrjZUGhs31wRlnGmMcoPnvQh86w6tt3ppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KC83dtwC9DWa/2Y4bVmyZ1tRr1GS89q8M058ZjbAnes=;
 b=SoSBHiIeT2xQ4hvknmJZAcH3+FbGq8p++MyLJph6mZEicBmBabYWYavdqz/R8nv3DDNC32fV1sN5Tgy/bVr5FFV4LqpS5vN+yWTxkuzojI95zi5JV+7EbUkQ9JSJytrBsiJltwV9+XT4vrq7xbiy6c6n8AZIl7GpAreC+G7HUFA=
Received: from BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 14 Oct
 2020 08:26:17 +0000
Received: from BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::bd7a:2354:a2d4:97fe]) by BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::bd7a:2354:a2d4:97fe%7]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 08:26:16 +0000
From: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: increase the reserved VM size to 2MB
Thread-Topic: [PATCH 1/2] drm/amdgpu: increase the reserved VM size to 2MB
Thread-Index: AQHWoYN2yF83VjUl8kiqEt4gSjFJx6mWwrLg
Date: Wed, 14 Oct 2020 08:26:16 +0000
Message-ID: <BL0PR12MB24337593D8FB1AA27A5E1AB89C050@BL0PR12MB2433.namprd12.prod.outlook.com>
References: <20201013170820.1548-1-christian.koenig@amd.com>
In-Reply-To: <20201013170820.1548-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-14T08:26:07Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=75cb61a1-fbe9-4afd-a863-00006a2f8ccf;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-14T08:26:00Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 7d1a1870-302a-41e5-bd76-00006bb82336
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-14T08:26:14Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ffed047f-3dcc-46bf-8330-000099f9f348
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [122.179.67.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83ff6ff1-028d-4278-8fd1-08d8701ad21e
x-ms-traffictypediagnostic: BL0PR12MB4914:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB49147D458F54BA8722824DC69C050@BL0PR12MB4914.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fig9LVDy55wv1JH8FlLs4FTwJxpdQ0hLwXPgfWda8Am7KQ+lih7dGs/RDG6JhKdjIX0zbqbbb40nTgQvHp6Xm4pjMKKOO5GLmgKcAuRqo6TcRHzmMw6rz7ECHlZv1bQJlKgLLqI1EjMvrQRcDZr664ACp0qxIBhhct4I0TDxedxqYWgY0GbQIcXcMtTH2+/ChCUCTR8OZZepAFoHCZnWON5AlUQGCW7GruTq3zHJjUesC1ZMQvn9RZqufZngUORXHGMfrosJ4qWVOc5L39+fwJXqw5DkDpOmEWMj5KjoA9GKs4fyZK2FnBXyCoFxqn8yx09MSRKFG/yNf65XTQnIdg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(136003)(366004)(346002)(376002)(52536014)(86362001)(9686003)(8676002)(110136005)(316002)(71200400001)(8936002)(33656002)(2906002)(66946007)(64756008)(66556008)(66476007)(66446008)(5660300002)(83380400001)(66574015)(7696005)(76116006)(55016002)(478600001)(53546011)(6506007)(4326008)(186003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: qR4URlxbZwIhSPC7eb/Ekq6ecnu3rEpN0LAB+S0vgK2cY4aQ+dB6wODbuphNrF8zkn5Ovucy8yQ0lq6NnoB4YslVFjBuMoIAkyabnCa50rnNSKj29XlKf5lUgmQ94IgQhuMzF+Vh8YMSWBYF/SbwsuZx9R6a43kyYepOMQrRTBo9rnUlE8WfQhr18kneER7J4O9xD8Pa6JPn0THM+lktWJq+QL74Ut0xeW3zexEjswN5L/dnvqoEXN52lRHEzB/dx0gAvrNE2KsTvuuS4LW65URxydjsoI6p1xHrGS3w4Tx6KhUVkyM/J+pjIvSEr4ivGWlakbwq/ncOcVwB3Ltte/q22u905mm4FEPm5IfGQ3vhjm3pS4jGVVUvZznDlwp34rhY4Kau9PrlazMNP3YsaWVi1/WaqaJAGle6HtSfXfmDD8FhEtVVH0ScFkxWybVuHy+YAmsqjKqkNJpyFohwPFUqvIEy/Z2mw2t9t1Qq11BzIuKp8pPZIL3GXNBGDl51rk/QVrssyav/ADVj5cyckptKX/nhssEgQgRR3NbmOnps8jn9p5eiX2EcRpZz8mm5uJ3US3C43+5en37lvrEDorreT4vzqNjKq94I6KxX2HsmptqTZouD+aoWYZU3XssHl4cKrA2JM7aulztlLBEhEA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ff6ff1-028d-4278-8fd1-08d8701ad21e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 08:26:16.9214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K+nWEAUA5+SX4uQbayjthqWuBjYwxusdUQCnaReNCrM6ekFBdeOXy/MaKh4FC9e5daBYyH+tKz0It/7Y7vMXMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IA0KU2VudDog
VHVlc2RheSwgT2N0b2JlciAxMywgMjAyMCAxMDozOCBQTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQpDYzogQ2hhdWhhbiwgTWFkaGF2IDxNYWRoYXYuQ2hhdWhhbkBhbWQuY29t
PjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRDSCAxLzJd
IGRybS9hbWRncHU6IGluY3JlYXNlIHRoZSByZXNlcnZlZCBWTSBzaXplIHRvIDJNQg0KDQpJZGVh
bGx5IHRoaXMgc2hvdWxkIGJlIGEgbXVsdGlwbGUgb2YgdGhlIFZNIGJsb2NrIHNpemUuDQoyTUIg
c2hvdWxkIGF0IGxlYXN0IGZpdCBmb3IgVmVnYS9OYXZpLg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCB8IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5oDQppbmRleCA3YzQ2OTM3YzFjMGUuLjgxY2NkMGEwYzNkYiAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oDQorKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaA0KQEAgLTExMiw4ICsxMTIsOCBAQCBzdHJ1
Y3QgYW1kZ3B1X2JvX2xpc3RfZW50cnk7DQogI2RlZmluZSBBTURHUFVfTU1IVUJfMAkJCQkxDQog
I2RlZmluZSBBTURHUFVfTU1IVUJfMQkJCQkyDQogDQotLyogaGFyZGNvZGUgdGhhdCBsaW1pdCBm
b3Igbm93ICovDQotI2RlZmluZSBBTURHUFVfVkFfUkVTRVJWRURfU0laRQkJCSgxVUxMIDw8IDIw
KQ0KKy8qIFJlc2VydmUgMk1CIGF0IHRvcC9ib3R0b20gb2YgYWRkcmVzcyBzcGFjZSBmb3Iga2Vy
bmVsIHVzZSAqLw0KKyNkZWZpbmUgQU1ER1BVX1ZBX1JFU0VSVkVEX1NJWkUJCQkoMlVMTCA8PCAy
MCkNCg0KTG9va3MgZmluZSB0byBtZTogUmV2aWV3ZWQtYnk6IE1hZGhhdiBDaGF1aGFuIDxtYWRo
YXYuY2hhdWhhbkBhbWQuY29tPg0KQ2xhcmlmaWNhdGlvbiBvbiBjb21tZW50Og0KV2UgY2hlY2sg
dmFfYWRkcmVzcyA8IEFNREdQVV9WQV9SRVNFUlZFRF9TSVpFIGZvciBpbnZhbGlkIHJlc2VydmF0
aW9ucywgc2hvdWxkbuKAmXQgdGhpcyBiZSAiYm90dG9tImluc3RlYWQgb2YgInRvcC9ib3R0b20i
IG9mIGFkZHJlc3Mgc3BhY2U/Pw0KDQpSZWdhcmRzLA0KTWFkaGF2DQogDQogLyogbWF4IHZtaWRz
IGRlZGljYXRlZCBmb3IgcHJvY2VzcyAqLw0KICNkZWZpbmUgQU1ER1BVX1ZNX01BWF9SRVNFUlZF
RF9WTUlECTENCi0tIA0KMi4xNy4xDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
