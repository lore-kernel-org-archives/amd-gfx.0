Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA39C388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 16:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0F02470D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 16:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pnxJQbwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0F02470D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFBDF6E4A2;
	Wed, 28 Oct 2020 16:02:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97B316E4A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 16:02:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkvkUicoxI+Wwvmq47mKKY8Lg6MQLTgQ5ZEML0RW25dkBHAqicUJFblVKg3tkxRlebZp0Z0PxIgfr1mEJEpEW90qq9IQY6YkZpCyXz9dY27F8wPWOD1A1W9Uh5i38iwH1Iu9HiY1JrIY3EkmPBuIiFqdQqiopyyqjaWLwymR4owssoVm/c41m1klfB0i1X/5m0MJdNsBJo4TOZTjSRL4HN7cyIMRyt092toD2mMnMh0prS21Wvak5UiftPiRYcuEqnE+mHrN+CstjAoFiGJTwC3+9I3kc71xp3Oy4l46mkwV3rg18bW4+TMVsmhN51vsklUvIQH7m7cUeij37Ro7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTUnasAzx8D372lLSZZhZFjIzdcYRQYh0w+aa1gaA8E=;
 b=S3SMdb15ACkDTn1D0cMyaX+x8lBmAsP2CXuCAsbfqFhCjBX9zmDRordCj7gkSlimRiVBN8gsrxmmShv+vfYifWUiL6tBoHJQ+sHm7gTZhFZ4x78VJOIt9JE/vFFN5XEj0NLjmAS/v+cQdV5am7cF/UboCF4Zvwh3cT3tN9Jo+u7/eN3Qe6u0MdcqbtnSVPGrTka3ejESLpThwGDMOwqVm8bI6auRiBoD53gyZYfWUZmUTqyFO1AsxnPFAoih1CGcudAmpDLTwSMSKMMdiYsEA/lfRxHzwPRir66cx9NIodmLynqtMut3Cmh/X0C49DweCyIH/I9liGxltlxSuGFyhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTUnasAzx8D372lLSZZhZFjIzdcYRQYh0w+aa1gaA8E=;
 b=pnxJQbwEYHyp9FwrDw7FlT0Am/7h2/QLQRVd+xdNKvALeJ57vBsnuO9pO7B2v2nklKwMB4FP9Y/2GJ7RAVC9nvVeebburW7fZpYyNEpNdmVI9QacXedmgw/gq1G/OAaU8yQ/7CLZTrRHKjZEUdKtEZ8ZGA5+YNaJb5rOUeHqb50=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4515.namprd12.prod.outlook.com (2603:10b6:5:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 16:02:25 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 16:02:25 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdkfd: Change unique_id to print hex format
Thread-Topic: [PATCH 2/2] drm/amdkfd: Change unique_id to print hex format
Thread-Index: AQHWrT4sCDuV8Hl6/ECkZlyZ2ksCOKmtKsKAgAABdYA=
Date: Wed, 28 Oct 2020 16:02:25 +0000
Message-ID: <DM6PR12MB3721E1DB3577D7B76A0ED52385170@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20201028152218.18485-1-kent.russell@amd.com>
 <20201028152218.18485-2-kent.russell@amd.com>
 <077bdbef-51f2-ac28-6392-84727a640525@amd.com>
In-Reply-To: <077bdbef-51f2-ac28-6392-84727a640525@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-28T16:02:23Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=7a33a05b-6ccf-4716-9816-000057262eab;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-28T16:02:15Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: dc25526b-4b44-46e7-acbc-0000cdc3c0a5
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-28T16:02:24Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 66bbb965-bd9d-4a7f-8377-0000f379a608
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65ae1950-0f0e-418f-eab0-08d87b5add13
x-ms-traffictypediagnostic: DM6PR12MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4515B8E13415C288B701376785170@DM6PR12MB4515.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:376;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x/Ox+TkzBIKMbEdwlzo7GCvMHOP0W+ynN9+Ek+VGLUxy5JDCnfXjmK0kVr5oP51EbyDFytXY8z6cHD9KkQzQcJig+FSN4Bn9RVGjoo2BpJy6uel4O7yQp/GqQx1n5/uttA1p2wNv7Ro9KsE5D1lsraCE6sr/zn5baNY7uY9r9ysLmLDBzZab2HbabaH7kLg4MKV1++0LBw5s3bbeZQqrJC1gKM6/9aWnHNXbKOmV1jr9IU4BaTDhccgIKiRf5+WUCJDicaDswXyXtC+uRnjnzHYxbkW+c+yfzxwuDCMjybmScywd0pWjD8uTxXplSZGPDEhj2iBWq2MKNYk5ovlJhw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(53546011)(478600001)(86362001)(9686003)(26005)(110136005)(7696005)(316002)(4001150100001)(55016002)(33656002)(76116006)(2906002)(8936002)(71200400001)(52536014)(66556008)(6506007)(186003)(66476007)(83380400001)(8676002)(64756008)(5660300002)(66946007)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: GYUbJNfzzBN/XEPeUTchxrY5mxd4NzprysBfkgtlZHfbA5IfXoadYl4ekNeyeAeCrapIW+wG4y2MAIOdf3CQcbb7YYbLAPvSXgnfg1KD3wo6B4uV3lffdz4hgKMp2Wwf6PiW5Ei3s/yQhf0Ed21HVhIoV2tKiORsYZXbvhwTHqw0SVtlEGac4H8NA42Hu9gdG3sHSWYqQl++5ZmBe14Xe7ZGZG799kI79uRti4e7oNRwXxOnSlu5C9Q5z6xB1K1ZEh8Xmjn6Wf1gqc4Q/qJtdYNRjKIJdyzsIHoSDg53ETebwd3NCTZEnNPdzbKceVKyN0MAvYZVumPaio9ap9yMbhDzlqi2IWWP6zm2RngDZzyocr47T8FhH2qm5edYa6AypzUWaJaeAPB17u9rn+J7R8cq6h2joE3NfoohLwHl+7nOSi98enRPFY1ZBtzVP4/LaPWqUgbctfZojmdc0zLhwETqZPwIiH67ZA2AYJzvrN6o2TlbVPOoh08EX+R8E3BrNSjCA1yNFM2A3R5RKp1GRIk4QJCtX2f4RJbya6Ew3cWboOxrs/Hk1NNjFDFS3wPkh6qnPYqF92EyhjMofdKbACHC3IznHhpAWtCZ2XkIBC1REZ60mpRc/4fhBsfB9aKCL5p81AHHKsfgfk5tor2SNg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ae1950-0f0e-418f-eab0-08d87b5add13
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 16:02:25.8468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90G7GGzM/GlO0A1bdnRmHbXcvybXH79tz/Uf7003qEf5K+hsiG1m0kJuQY6nuBUhRjExaghCccoJ2yTepyUg/Q==
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

W0FNRCBQdWJsaWMgVXNlXQ0KDQpyb2NtaW5mbyB1c2VzIGl0LCBidXQgdGhhdCdzIGFsbCB0aGF0
IEkgYW0gYXdhcmUgb2YuIEkgY2FuIGRyb3AgdGhpcyB0aG91Z2ggYW5kIHN0aWNrIHdpdGggcGF0
Y2gxLCBJIGp1c3QgZGlkbid0IGtub3cgaWYgd2UnZCBlbmQgdXAgZ2V0dGluZyBjb21wbGFpbnRz
IG9mOg0KIldlbGwsIHJvY20tc21pIChhbWRncHUpIHNheXMgdGhhdCB0aGUgdW5pcXVlX2lkIGlz
IEYsIHdoaWxlIHJvY21pbmZvIChhbWRrZmQpIHNheXMgdGhhdCB0aGUgdW5pcXVlX2lkIGlzIDE2
IiAuIFByb2JhYmx5IHRvbyBsYXRlIHRvIHRyeSB0byBjaGFuZ2UgaXQgbm93IHRob3VnaCwgYXMg
eW91IHBvaW50ZWQgb3V0Lg0KDQogS2VudA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBPY3RvYmVyIDI4LCAyMDIwIDExOjU1IEFNDQo+IFRvOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgUnVzc2VsbCwgS2VudCA8S2VudC5SdXNzZWxsQGFtZC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBkcm0vYW1ka2ZkOiBDaGFuZ2UgdW5pcXVlX2lk
IHRvIHByaW50IGhleCBmb3JtYXQNCj4gDQo+IFRoaXMgaXMgYW4gQUJJLWJyZWFraW5nIGNoYW5n
ZS4gSXMgYW55IHVzZXIgbW9kZSBjb2RlIHVzaW5nIHRoaXMgYWxyZWFkeT8NCj4gDQo+IFJlZ2Fy
ZHMsDQo+IMKgIEZlbGl4DQo+IA0KPiBBbSAyMDIwLTEwLTI4IHVtIDExOjIyIGEubS4gc2Nocmll
YiBLZW50IFJ1c3NlbGw6DQo+ID4gYW1kZ3B1J3MgdW5pcXVlX2lkIHByaW50cyBpbiBoZXggZm9y
bWF0LCBzbyBjaGFuZ2UgdG9wb2xvZ3kncyBwcmludG91dA0KPiA+IHRvIGhleCBieSBhZGRpbmcg
YSBuZXcgc3lzZnNfcHJpbnQgbWFjcm8gc3BlY2lmaWNhbGx5IGZvciBoZXggb3V0cHV0LA0KPiA+
IGFuZCB1c2UgaXQgZm9yIHVuaXF1ZV9pZA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2VudCBS
dXNzZWxsIDxrZW50LnJ1c3NlbGxAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMgfCA0ICsrKy0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMNCj4gPiBpbmRleCBhM2ZjMjM4NzM4MTku
LmQxM2M2OGM1MmJiYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfdG9wb2xvZ3kuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF90b3BvbG9neS5jDQo+ID4gQEAgLTIxNyw2ICsyMTcsOCBAQCBzdHJ1Y3Qga2ZkX3RvcG9sb2d5
X2RldmljZSAqa2ZkX2NyZWF0ZV90b3BvbG9neV9kZXZpY2UoDQo+ID4gIAkJc3lzZnNfc2hvd19n
ZW5fcHJvcChidWZmZXIsIG9mZnMsICIlcyAldVxuIiwgbmFtZSwgdmFsdWUpDQo+ID4gICNkZWZp
bmUgc3lzZnNfc2hvd182NGJpdF9wcm9wKGJ1ZmZlciwgb2ZmcywgbmFtZSwgdmFsdWUpIFwNCj4g
PiAgCQlzeXNmc19zaG93X2dlbl9wcm9wKGJ1ZmZlciwgb2ZmcywgIiVzICVsbHVcbiIsIG5hbWUs
IHZhbHVlKQ0KPiA+ICsjZGVmaW5lIHN5c2ZzX3Nob3dfNjRiaXRfcHJvcF9oZXgoYnVmZmVyLCBv
ZmZzLCBuYW1lLCB2YWx1ZSkgXA0KPiA+ICsJCXN5c2ZzX3Nob3dfZ2VuX3Byb3AoYnVmZmVyLCBv
ZmZzLCAiJXMgJWxseFxuIiwgbmFtZSwgdmFsdWUpDQo+ID4gICNkZWZpbmUgc3lzZnNfc2hvd18z
MmJpdF92YWwoYnVmZmVyLCBvZmZzLCB2YWx1ZSkgXA0KPiA+ICAJCXN5c2ZzX3Nob3dfZ2VuX3By
b3AoYnVmZmVyLCBvZmZzLCAiJXVcbiIsIHZhbHVlKQ0KPiA+ICAjZGVmaW5lIHN5c2ZzX3Nob3df
c3RyX3ZhbChidWZmZXIsIG9mZnMsIHZhbHVlKSBcDQo+ID4gQEAgLTQ5Nyw3ICs0OTksNyBAQCBz
dGF0aWMgc3NpemVfdCBub2RlX3Nob3coc3RydWN0IGtvYmplY3QgKmtvYmosIHN0cnVjdCBhdHRy
aWJ1dGUNCj4gKmF0dHIsDQo+ID4gIAkJCSAgICAgIGRldi0+bm9kZV9wcm9wcy5udW1fc2RtYV9x
dWV1ZXNfcGVyX2VuZ2luZSk7DQo+ID4gIAlzeXNmc19zaG93XzMyYml0X3Byb3AoYnVmZmVyLCBv
ZmZzLCAibnVtX2NwX3F1ZXVlcyIsDQo+ID4gIAkJCSAgICAgIGRldi0+bm9kZV9wcm9wcy5udW1f
Y3BfcXVldWVzKTsNCj4gPiAtCXN5c2ZzX3Nob3dfNjRiaXRfcHJvcChidWZmZXIsIG9mZnMsICJ1
bmlxdWVfaWQiLA0KPiA+ICsJc3lzZnNfc2hvd182NGJpdF9wcm9wX2hleChidWZmZXIsIG9mZnMs
ICJ1bmlxdWVfaWQiLA0KPiA+ICAJCQkgICAgICBkZXYtPm5vZGVfcHJvcHMudW5pcXVlX2lkKTsN
Cj4gPg0KPiA+ICAJaWYgKGRldi0+Z3B1KSB7DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
