Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862C9C10F27
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 06:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7E821655
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 06:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fvDVTDxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7E821655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 260696E41A;
	Wed, 11 Mar 2020 06:47:24 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750057.outbound.protection.outlook.com [40.107.75.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD3B46E41A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 06:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlihFcbkv33+9wdohgcEWl6m9H+v2IBwTIpvL+IRVsZhBFNjsBIQWtxPk+VnoP7WeXD8CiaTKG3FOmTfYDu5a9QWsqyAXyu06HxqqVOJ0DRiu5YxaFTm4AkT6laCYUh5Jm935Ylvs0ncRMGsubTFcKw8bwiEkKguIv1omfpkCMFYSH3mjtYwImIpx6byB26XDBENkxi/PF7Ks8fbFudR25xkKASKN++WtyJj2A1JTBBtrJnu4iD1wkUIL2pNNIH4lB0/A79lM+6eBvNOXj0DBEWHjx7RXHOaqKOR/eblI1iF3a2gldvhrt/X/Z6ZAmSDp529HdelgN3S0fmuJTEnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTg79XhpIMVLZwroNjo9v3rIVzlZ0co3O2wb/u/Vhhk=;
 b=FjZy+av3EgCjogu6HVZHV/75hpomAC38823SIO5F/f56YXFHlShVNOOLMq+Lsp5sukkaBBqUDBeptZvLp5nKDlfv3vnUI0lKGM9v8TSG09dpcyy5hPhQS5EBNq8ClihYYuZASVudqxCkwUVsNz7YvdfTM62puS7fVOedenX1uHxhxEY89nh1sZn+v0i5oboZlQhzqnYWPh9gcqcZ9yiPziqZbU2SIfJJvqv9R/KUbdw04T/BfqsCFK1IleXmiK5sCRfx9QeSfGztPBKJTYiD3KsMNiZbBRrhJwRlWVdX38RxB8/6Yc3AsZQIXcq+KaEWVztXaoOZHUgRSUSY3hSh1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTg79XhpIMVLZwroNjo9v3rIVzlZ0co3O2wb/u/Vhhk=;
 b=fvDVTDxVBE1LarMWFKBE9DLxJSXWSkB9T+iCPlbKnuohjuhmqXqzHlde8x3O5dCAj30W4t8jbqzevhqRn3vIDEOKcMa8MSkQOxV4YJMo5mrcASOW0P6tLx9rP9cbPsUAJ+egn6+C43T0ZDPLB4Q2jNwMOTauozGa1UpPJcocR90=
Received: from MN2PR12MB3054.namprd12.prod.outlook.com (2603:10b6:208:d1::15)
 by MN2PR12MB2943.namprd12.prod.outlook.com (2603:10b6:208:ad::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 06:47:18 +0000
Received: from MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::700c:bda1:a8f8:2dbd]) by MN2PR12MB3054.namprd12.prod.outlook.com
 ([fe80::700c:bda1:a8f8:2dbd%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 06:47:18 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: use amdgpu_ras.h in amdgpu_debugfs.c
Thread-Topic: [PATCH] drm/amdgpu: use amdgpu_ras.h in amdgpu_debugfs.c
Thread-Index: AQHV92+Ubvcq8L8MJ0GefGfWkSaDlKhC8mgg
Date: Wed, 11 Mar 2020 06:47:18 +0000
Message-ID: <MN2PR12MB3054CFAD89819537015DC3DCB0FC0@MN2PR12MB3054.namprd12.prod.outlook.com>
References: <20200311063730.4156-1-Stanley.Yang@amd.com>
In-Reply-To: <20200311063730.4156-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-11T06:47:16Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=27f87c1a-f57d-4fe5-be91-00006a14b040;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-11T06:47:16Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e1c183b5-146c-4adc-a7c2-0000fa863f81
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tao.Zhou1@amd.com; 
x-originating-ip: [183.232.44.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4939dedb-8cf7-49af-f6c4-08d7c5880b0e
x-ms-traffictypediagnostic: MN2PR12MB2943:|MN2PR12MB2943:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2943E1643C30CF8B3F804819B0FC0@MN2PR12MB2943.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:364;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(186003)(316002)(54906003)(110136005)(81156014)(81166006)(26005)(9686003)(55016002)(8936002)(8676002)(86362001)(66476007)(4326008)(966005)(71200400001)(5660300002)(33656002)(6506007)(52536014)(45080400002)(478600001)(2906002)(66446008)(66556008)(64756008)(76116006)(53546011)(66946007)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2943;
 H:MN2PR12MB3054.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ikGvKkuNQkAsHXW7Cs9qXVp4hxz+Ud05BybZ7J+pZLZjLdV5tjIgmK+8IO1qLIXW35CGWdCCkjkCgjZDEgrbK0SC2SCaU3ocGpuNEPMdJjSoVf4BAdhNCXbR2NRaKRuzX7rsX5nPqn5GtYHworRkSSB28/MkLicC4eWliDxpYXTyLqLt7vyImBQ/hoGzA4v7leAOABpwhz3uWpwGJ+7ZkQ12arf1Y/JSj/DyZ3sx0hGAtsanRyH2DaThT9w5UcwMfXro9SkElOpzU1PrQ5+/67ne6H9hu6zJBAl8V1m5pi4JI9zk0qUXJBrwFYjJMXNFD2ukDAqHrHIFuAcGUBB8hwcGiOC+w1OQVWMrrXmaIigZYz6nf36kf2o0cSLI3bAkQB08ZQH12DMJTwTgVIzwXETGBBgEoWXBaekZ5sTerqr8u8AEcIERJHG57KBuYXx7fP+speD8PB/TmuPal3gWEV2y9N8Mdd46VtIiCmoA6vQkomqA4iztf5x8AZnrkEy/IWLs+Ojt5Bj1cUqWgIHtDw==
x-ms-exchange-antispam-messagedata: rdeQlff2aD7yqzQ59+h357QANqRNAxedw/jEHPg7eXkPOpBY7j2cEoQLo+mSjW7xYZlhfbV1og9f2qMy95ImBxfEmdD72Xdarw5vrEfgLw/m79g+8GtSPnywEhNdquuMmMnW4cu1UYaZqpp8PemFWQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4939dedb-8cf7-49af-f6c4-08d7c5880b0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 06:47:18.6959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FAbXGxgR2XuTOuJiodUNgvrb85mOtxtsPnDVxtKtQp79jEbTmLu37cZc4qE+26YW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2943
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
Cc: "Clements, John" <John.Clements@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Li,
 Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpS
ZXZpZXdlZC1ieTogVGFvIFpob3UgPHRhby56aG91MUBhbWQuY29tPg0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5m
cmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZg0KPiBTdGFubGV5LllhbmcNCj4gU2VudDogMjAy
MMTqM9TCMTHI1SAxNDozOA0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4g
Q2M6IFlhbmcsIFN0YW5sZXkgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPjsgQ2xlbWVudHMsIEpvaG4N
Cj4gPEpvaG4uQ2xlbWVudHNAYW1kLmNvbT47IExpLCBEZW5uaXMgPERlbm5pcy5MaUBhbWQuY29t
PjsgQ2hlbiwNCj4gR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPjsgWmhhbmcsIEhhd2tpbmcN
Cj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBkcm0vYW1kZ3B1
OiB1c2UgYW1kZ3B1X3Jhcy5oIGluIGFtZGdwdV9kZWJ1Z2ZzLmMNCj4gDQo+IGluY2x1ZGUgYW1k
Z3B1X3Jhcy5oIGhlYWQgZmlsZSBpbnN0ZWFkIG9mIHVzZSBleHRlcm4gcmFzX2RlYnVnZnNfY3Jl
YXRlX2FsbA0KPiBmdW5jdGlvbg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3RhbmxleS5ZYW5nIDxT
dGFubGV5LllhbmdAYW1kLmNvbT4NCj4gQ2hhbmdlLUlkOiBJMjY5NzI1MGJhNjdkNGRlYWM0Mzcx
ZmVhMDVlZmI2OGE5NzZmN2U1YQ0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZWJ1Z2ZzLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RlYnVnZnMuYw0KPiBpbmRleCAxZDUxM2U0Zjk5MzQuLmE5YTI3OGY4NzQ5OCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jDQo+IEBA
IC0zNCw2ICszNCw3IEBADQo+ICAjaW5jbHVkZSAiYW1kZ3B1LmgiDQo+ICAjaW5jbHVkZSAiYW1k
Z3B1X3BtLmgiDQo+ICAjaW5jbHVkZSAiYW1kZ3B1X2RtX2RlYnVnZnMuaCINCj4gKyNpbmNsdWRl
ICJhbWRncHVfcmFzLmgiDQo+IA0KPiAgLyoqDQo+ICAgKiBhbWRncHVfZGVidWdmc19hZGRfZmls
ZXMgLSBBZGQgc2ltcGxlIGRlYnVnZnMgZW50cmllcyBAQCAtMTMxNSw3DQo+ICsxMzE2LDYgQEAg
REVGSU5FX1NJTVBMRV9BVFRSSUJVVEUoZm9wc19pYl9wcmVlbXB0LCBOVUxMLA0KPiBERUZJTkVf
U0lNUExFX0FUVFJJQlVURShmb3BzX3NjbGtfc2V0LCBOVUxMLA0KPiAgCQkJYW1kZ3B1X2RlYnVn
ZnNfc2Nsa19zZXQsICIlbGx1XG4iKTsNCj4gDQo+IC1leHRlcm4gdm9pZCBhbWRncHVfcmFzX2Rl
YnVnZnNfY3JlYXRlX2FsbChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7DQo+IGludCBhbWRn
cHVfZGVidWdmc19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSAgew0KPiAgCWludCBy
LCBpOw0KPiAtLQ0KPiAyLjE3LjENCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmYNCj4gcmVlZGVza3RvcC5vcmcl
MkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtDQo+IGdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDdGFv
Lnpob3UxJTQwYW1kLmNvbSU3QzE5YmZhMDU3ZGE3NzQwY2E5DQo+IDk2ZjA4ZDdjNTg2YjU2NCU3
QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2DQo+IDM3MTk1MDU0
Njg3NTk0NDIwJmFtcDtzZGF0YT1aQnZhUHJUeDlvVW9HZmx0SW0zSlFFeTVodFVRWWpYWnFrMGp1
DQo+IGZjYzk4USUzRCZhbXA7cmVzZXJ2ZWQ9MA0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
