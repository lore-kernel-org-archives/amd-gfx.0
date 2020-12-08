Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AF1C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 17:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE07B23B23
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 17:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE07B23B23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43C7A8913D;
	Tue,  8 Dec 2020 17:42:39 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760088.outbound.protection.outlook.com [40.107.76.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A48278913D
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 17:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOZv6GmVpHdyPSHqPTJrKcHg1OyL9HCSm7Hmi9dzt31Wo5W/PjoZnFr8qw0DseZaRSHb8tAvo+jKTxHnfDZBmARHzca2X+AnMNq1FagRYwUfb+OuL5B48xsVy7Qk6mLRE4k/hd3I96fyrLa+vbv0bFqXbycbedwYawZpQWq5QLzUgS5vFGvlshoCfR9Z4h/zXVl1da5WDB1mUvdUtKYi4pNn6YBnWkGS12LCdFaaMgQCNa3wr83Lbyz6RlZWINcYGZ548hu7hRJ1xXM1jXR1ifcs8bstzOACx/rQ8KPwxx14YtYoNAuZKVY7daqXWPF5st2aT4xqdqFhqCN2BC3C/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeuIIONxjRWPQX6hg1UUXhJhYeUa7wdd0/7MfzZlfd0=;
 b=JbTbH3sWSnI+f+sF5KsmddatZOriB1IdmLwfncqbsXBKapOj/ze0RZAPeAqwUdgovlg0NN+K4KLq97gphqf1q0Gv7Y2PEg2wPpceZpF6C1K1PfhYySN4fhuBmTEUz/5JGDIxkJOl0B9qj0xy7zppLwr14ghdSCblj4kyvJL5/qTXP8hTeGu8MwUzDCon4T+PHwmf9HDDiiZZCffTZCUluNu2BqbQ98lCYwx46VbZf7DBnV3rdAO3nXZxSQWH4/gcBsSM7E074MrIAc6h1187VAL5tBCbjOwFzl+mKx3f39Z8wknZK1nbVdusDfYQ6SLeOhXMvAK/zEx9qCExL+IwyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeuIIONxjRWPQX6hg1UUXhJhYeUa7wdd0/7MfzZlfd0=;
 b=ddsck6/c3SyEYL1eG59VsjyxwfDwV70OoEVJI1GIoV7YQZ4H486LjOcvPqiSazojBqTnbESHcdDhCfnKHyHf8nDjz8+jNrF3g8AVLmaMYEWhd0PeKTjAEeqzFYQ8Wi8d8N2BD8hffTMT3HHmMhBYHfoMeVSdy1r6ii53vX0CUDU=
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Tue, 8 Dec
 2020 17:42:37 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::45a1:6d50:60d6:9d68]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::45a1:6d50:60d6:9d68%7]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 17:42:37 +0000
From: "Sharma, Shashank" <Shashank.Sharma@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: limit the amdgpu_vm_update_ptes trace point
Thread-Topic: [PATCH] drm/amdgpu: limit the amdgpu_vm_update_ptes trace point
Thread-Index: AQHWzYfnUzUrd9rHyEuRjYeFAR3H0Kntd4rQ
Date: Tue, 8 Dec 2020 17:42:36 +0000
Message-ID: <BYAPR12MB3126B67C7813E6440474166CF2CD0@BYAPR12MB3126.namprd12.prod.outlook.com>
References: <20201208173059.11076-1-christian.koenig@amd.com>
In-Reply-To: <20201208173059.11076-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2020-12-08T17:42:20Z; 
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=3de23581-f977-4cac-b82c-000085795bbb;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_enabled: true
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_setdate: 2020-12-08T17:42:33Z
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_method: Privileged
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_name: Non-Business
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_actionid: 13963dce-ffea-47c4-8c38-00008adf3cb8
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_contentbits: 0
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-08T17:42:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: bb904847-a682-403f-beeb-0000a133a4ce
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [106.51.105.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dcb37303-97e1-4251-ad57-08d89ba0a703
x-ms-traffictypediagnostic: BY5PR12MB4997:
x-microsoft-antispam-prvs: <BY5PR12MB49978A8FFFDB5F460EAB5D72F2CD0@BY5PR12MB4997.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:199;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: alcf+ouU/k4zm087Gf9UnJO6SWIvh+0IsudvuWYuxWZOII0kPB+xf7EzCR4i5yTjyLV9/Vmaxdsk9AC8d4C6o2UM3pTlpOYIqDVwaFdDiARmSnd9pLIvreaUSxLlHARqedbPFGeIshw0Mc/ukD1RcHiInw8E634f7XUxuGQMaYHqYLavIV8uCXBFFL6sPTMqq+7yv43yPa0cJtTX57JWTrMq4QENx4+8hg9E366RAev2cgAQwwoBM+dJL9CzkVzkv5jPbNQKWp7Z3lrteUbN0Wz8FDcW8AtT/ZlKX+HVVzfDWhKLJzFREPk5mlLwtY+MeVo1iR+tRJ2GgJAy6a9gBw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(83380400001)(186003)(7696005)(6506007)(53546011)(26005)(55016002)(55236004)(9686003)(66574015)(86362001)(8676002)(110136005)(316002)(8936002)(33656002)(2906002)(71200400001)(478600001)(66946007)(5660300002)(66556008)(66476007)(66446008)(76116006)(64756008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?cno3Q3JvSnFHUVdyZTBuay8vQ3FOSjdBdDdrZHR4bUU5bzN4bnE4TDBub01S?=
 =?utf-8?B?Q0U3RVJ5RTk1am9zdlZBVjh5TTZnQ2p3SzU3QlA3ZFRmN2swWHZZb1U2Tkkx?=
 =?utf-8?B?VmViYWV0MUlKVFBqbi8xa0hseVRTVW5iRDh1WnhNOWcvQUN1Wk1IL1RveTFn?=
 =?utf-8?B?amdCNitNTDBFbUE3QTdxTFZJQWIyVzJJR0k1NzN4ZWx0Q09UNUpOamRrdGoz?=
 =?utf-8?B?ZGVJemlHVXByb0phaHpTaXAzZDBFWlRGMG1SNnRJT3RLeFZkWmZIaXAxSnVt?=
 =?utf-8?B?Wi9JbE5jM1drZW0zQWc0V3B1WjEraVgwRTlQK24zR3JRTzRTc0IwMWFjbWdK?=
 =?utf-8?B?d0p2YnRFeENLVWlPOEdvSjFuUWw5MXdxd3NxUmcrM2FET2g0a04vdmhzQi9V?=
 =?utf-8?B?dWpkRU5TZlA3OFNCbTNQUFdiSENnbThXMGVFK0p0OW12U0JLYVI1Sy9ld0Ur?=
 =?utf-8?B?TEFmV2xEMlo0TktFRGsyUmFiSmUvK1BhRWVtbUtiRDdDQ3pFbUNyc2w0Nm0x?=
 =?utf-8?B?VjZnTVlaVVh4bjdpRE1TUWthMTdrOU1rK09yYUl0Zjd3ZnA2WTJhOHpSTGcy?=
 =?utf-8?B?WkErTGM2OTZ4eTFGZzIwZ2JpbU96VGlRa1gxeHNvZWRxUzEvdEhZaE4vclhP?=
 =?utf-8?B?Rmk0aWZCK2dxQUE4cVBWTWdWMmxLRjUyQzh0aTRpbUl6VTdYeExDenlpaTc5?=
 =?utf-8?B?RXhLczUzSHdjTmNVWEtuQ1hERGpjK1hNajl2d3llM1F3K1lJRnRFbFJlRTE4?=
 =?utf-8?B?L2hDREx5WnNuRU1RcEZYVE9adlpxaFJKUk5hWG1PeTRkS1I1OUpPRjhlOHRJ?=
 =?utf-8?B?Z2VOcVY1Q1pVVnNDWGFZK0wvbE5yM0Rxa0dCa3h5ZGpJejNPQWVNM2hzc2ZR?=
 =?utf-8?B?bk9scWdMTno4ZTNQNjdYbUVTSnY5VndwV2UzaVBjYk96cy9xdkE3eWRvVUdT?=
 =?utf-8?B?azVMWWJ5cm9wVkxmUGR3SE1VY2U2eFdJa3pFdnQ1dWxkUjVWdmpGbU1WMTRl?=
 =?utf-8?B?QmJ0bmZMNXBxSHBnd2NVU0syVjdEMnZhSllzTHN3b1hlVWIrNk5UZ3JVdVFi?=
 =?utf-8?B?eGRkQ25zWVNOYldHT095Q3JsNXByUHJBYTBrNGthNjhQd2RJWnBGNHBxWE9L?=
 =?utf-8?B?TTVzalJRYTkybzFwWGg3RnUzZkQ2SUJSVFJPTnBOSDhxdGxnQUd4b29NaEdU?=
 =?utf-8?B?ZjJmajR1aDhWYWtPcDllUDQxaTc3TWN3bzRObXlLbTk2WTNvb2ZNRTg5dzF6?=
 =?utf-8?B?OHJ3NXZZM0pvT1JRTzZRQjBXQ3Brc2RaTTJZRzhGVU1RUkNwUWo5OGVxUjUy?=
 =?utf-8?Q?ZBAm+V67Kg7oM=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb37303-97e1-4251-ad57-08d89ba0a703
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 17:42:37.0564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n933ujPNmztg4JZz1ANFn3QsUs/ng/REx+5zDU6FTPnXE8JXnVAq1PRaHDPm7ZmCYHnEiZyPUVNKTbW6ySlHEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
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

TG9va3MgZ29vZCB0byBtZSwgUGxlYXNlIGZlZWwgZnJlZSB0byB1c2U6DQpSZXZpZXdlZC1ieTog
U2hhc2hhbmsgU2hhcm1hIDxzaGFzaGFuay5zaGFybWFAYW1kLmNvbT4NCg0KUmVnYXJkcw0KU2hh
c2hhbmsNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDaHJpc3RpYW4gS8O2bmln
IDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBEZWNl
bWJlciA4LCAyMDIwIDExOjAxIFBNDQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
CkNjOiBTaGFybWEsIFNoYXNoYW5rIDxTaGFzaGFuay5TaGFybWFAYW1kLmNvbT4NClN1YmplY3Q6
IFtQQVRDSF0gZHJtL2FtZGdwdTogbGltaXQgdGhlIGFtZGdwdV92bV91cGRhdGVfcHRlcyB0cmFj
ZSBwb2ludA0KDQpUaGUgdGV4dCBvdXRwdXQgc2hvdWxkIG5vdCBiZSBtb3JlIHRoYW4gYSBwYWdl
LCBzbyBvbmx5IHByaW50IHRoZSBmaXJzdA0KMzIgcGFnZSB0YWJsZSBlbnRyaWVzLg0KDQpJZiB3
ZSBuZWVkIGFsbCBvZiB0aGVtIHdlIGNhbiBzdGlsbCBsb29rIGludG8gdGhlIGJpbmFyeSB0cmFj
ZS4NCg0KU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgg
fCA1ICsrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFj
ZS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgNCmluZGV4IGVl
OTQ4MGQxNGNiYy4uMTFiMWIxMTIyYzM0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV90cmFjZS5oDQpAQCAtMzU4LDEwICszNTgsMTEgQEAgVFJBQ0VfRVZFTlQoYW1kZ3B1
X3ZtX3VwZGF0ZV9wdGVzLA0KIAkJCX0NCiAJKSwNCiAJVFBfcHJpbnRrKCJwaWQ6JXUgdm1fY3R4
OjB4JWxseCBzdGFydDoweCUwMTBsbHggZW5kOjB4JTAxMGxseCwiDQotCQkgICIgZmxhZ3M6MHgl
bGx4LCBpbmNyOiVsbHUsIGRzdDpcbiVzIiwgX19lbnRyeS0+cGlkLA0KKwkJICAiIGZsYWdzOjB4
JWxseCwgaW5jcjolbGx1LCBkc3Q6XG4lcyVzIiwgX19lbnRyeS0+cGlkLA0KIAkJICBfX2VudHJ5
LT52bV9jdHgsIF9fZW50cnktPnN0YXJ0LCBfX2VudHJ5LT5lbmQsDQogCQkgIF9fZW50cnktPmZs
YWdzLCBfX2VudHJ5LT5pbmNyLCAgX19wcmludF9hcnJheSgNCi0JCSAgX19nZXRfZHluYW1pY19h
cnJheShkc3QpLCBfX2VudHJ5LT5ucHRlcywgOCkpDQorCQkgIF9fZ2V0X2R5bmFtaWNfYXJyYXko
ZHN0KSwgbWluKF9fZW50cnktPm5wdGVzLCAzMnUpLCA4KSwNCisJCSAgX19lbnRyeS0+bnB0ZXMg
PiAzMiA/ICIuLi4iIDogIiIpDQogKTsNCiANCiBUUkFDRV9FVkVOVChhbWRncHVfdm1fc2V0X3B0
ZXMsDQotLSANCjIuMjUuMQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
