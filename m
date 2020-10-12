Return-Path: <SRS0=L/30=DT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08664C433E7
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 10:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683D5208B6
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 10:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HNRFQHdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683D5208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A602C6E247;
	Mon, 12 Oct 2020 10:00:28 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760044.outbound.protection.outlook.com [40.107.76.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 010BD6E247
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2020 10:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bq7YAc6pGSLFQ7+an4BDnRoqn4AlRg83P0LP4yRODkN++jgqNK4JqJlC8W3X5svTHcdTgwYFoqIYxyaWpGaCWduzIypJu0CLVU6Gb8rbW+0Engxx8nWr6IacaQ/DYSMKkhfAiclcIDUVLGRCoXTUmfg+CT0wwARvYhoJ/VAdHfV+zyXV2LL8x+hDj0gZDDCaGAQMaMJTopsto5YPkgx60fde6mNV9kYhy1tGQPfkXUmEsILtYv60HY0WPJSDwhrmYLuDEO6kRWLSXWvsV0dG1ROJST9loRcELwjdURCE5M22E59m5w6TxDcjIUJ8j81LgFBopXUtQ6bBG5sRM1PAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZMUIlCQt+GtVyqzi38Cx0uGPubxs14z9peiYEsPPJ8=;
 b=a2ndXPCRu29jNo77pAEcT8PjAvHI/ScusnzDDLQrgx9NCEXFX79Nc4HcoKW0rHE/3sEb6kvOf5z7SryaOtD4XyauaO9U7UqKNmrwDqQNnpNMSWYs1ZGBIpikI2shMvhrfjiDqjQzIvju5aF4D+vXLYAI9pz//QUhnTUK3/Vf3X6yfB2AQasE4GwrmKsK8h7kb1TW71YXH7wuPMRQy8unbjuy9l8x9O+ga3/JPOGmWQZ+ze06COhoNJwDDJ/NgJrqAx09KSG4lS7uQ7XHPhCOPsytS1gVAwCPyJBrnLLCN1WRGSIw39nvvDLlP1lgyxWUrlVGO6TOqsRCzfTd0T0IbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZMUIlCQt+GtVyqzi38Cx0uGPubxs14z9peiYEsPPJ8=;
 b=HNRFQHdWQfO5vRWOm1VXfKbhuYQ91gpGCQ8CmE7fT+QbU2knTJmgeDxNb8In6TVAmM8cMka9M0O+cf+QQ30Ey95Q2lT9F0Cmj9HyG7cTnynkosVP5fT6/UGQWQScD6cFpzIp5wI9MRvzPNNLDjUtPMyxYngN4Oh2Ek2RXZWDErw=
Received: from DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17)
 by DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Mon, 12 Oct
 2020 10:00:25 +0000
Received: from DM6PR12MB4452.namprd12.prod.outlook.com
 ([fe80::3061:cd92:9bf4:8380]) by DM6PR12MB4452.namprd12.prod.outlook.com
 ([fe80::3061:cd92:9bf4:8380%6]) with mapi id 15.20.3455.030; Mon, 12 Oct 2020
 10:00:25 +0000
From: "Patel, Mihir" <Mihir.Patel@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdgpu: Add debugfs entry for printing VM info
Thread-Topic: [PATCH v3] drm/amdgpu: Add debugfs entry for printing VM info
Thread-Index: AQHWoHZuBGHcWtM0WkurDINF7fN4zKmTrkOAgAAFz8CAAAOGgIAAAVuw
Date: Mon, 12 Oct 2020 10:00:25 +0000
Message-ID: <DM6PR12MB4452CDAE4721D598694241B8E8070@DM6PR12MB4452.namprd12.prod.outlook.com>
References: <20201012090159.28825-1-mihir.patel@amd.com>
 <d2d63bd0-61a0-33ce-67da-78143412d6b1@amd.com>
 <DM6PR12MB44527C86830BA20463BCFE6BE8070@DM6PR12MB4452.namprd12.prod.outlook.com>
 <64b13a59-f5c1-ff4c-f76a-0e1a00b249a0@amd.com>
In-Reply-To: <64b13a59-f5c1-ff4c-f76a-0e1a00b249a0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-12T10:00:20Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=81235082-6d87-40be-924d-0000afe69bb8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-12T10:00:20Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 207c27db-7bf6-49cd-a2ef-00009f966e54
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: My manager approved sharing of this content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [183.83.139.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 25eb8e15-04ec-424e-a311-08d86e95a3ed
x-ms-traffictypediagnostic: DM6PR12MB4452:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4452E134174F1BF06038FCDEE8070@DM6PR12MB4452.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IYcm/YFcix++SdY3MW+fvTuZql4MX+xbCIR2mXXL0Zq9PzB82y5kx9f2e3OGq8KQV86Pi+n/n8e/sgJDMRG9hpmgyXz5eDkNzavHnX7Tq8mIw4Xk9U4wEOENEZHrCGsH/lYkCwFisXF4OyVgJFWZ3Xt9xNNEP8/dZId/iGWwKyEYQFYphnR1skG/zc4a0vN4QavD+N9DLvFqKZjRMQ9MKE3SZbcNM2cCjLJFbpgfmOd2ngz+T0t+nDEsdnI7h1R96mQh6s+wf4NarzdSkrUiEd94rU95CkAK1r4E2EMBGtzzVDEyULlMrR3KT1pHoN0fjmQONgmbwsGn/GV2HYvLSw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4452.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(8936002)(316002)(9686003)(110136005)(26005)(54906003)(52536014)(2906002)(71200400001)(7696005)(5660300002)(186003)(8676002)(83380400001)(4326008)(33656002)(53546011)(86362001)(478600001)(76116006)(55016002)(6506007)(66476007)(66946007)(66446008)(66556008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: EAFKY+YjT+JF4pS2XC/8t1kyYsiDMpPH5ZlDZlmxtUCnkdirFSdCf//LQsZvsxy0aiXZ8aF/HjdtwoIqxT9c8BHxO7EUCSycgmf1l1GJfItlQtFJmcdM2kwiqnKTbooY5wpX645n51xXAFKe0Qjg8urr+0lYsFcjdJ5yKzff4V8vHpEb4OKLmTM9KC2DK6iT/dcm3KLYl2a22uWKedBDUHf4urWI0Tc+97Nc1nJirQjC6v3ApCYPR2WT1yPj8xPA2WN7le1yn9ExsgF+5FaJ/hiIf4ibOScv3AitbZE2cfuyOeZ0MF7S/Ps/do04aB2mDcwDLjqRtE1c1PAr6IxTxbGXeDDSJ7ZWkrv7PHonAchTTyu5RQahD5WxG5gm2aB9uVZc+eMDQhzz1kvLrsSKweJM/7BtVLlkmJkzHFaiZq2ubIMaFX5rHH9buVwQsCTlUDulBaZLnSQAsSeQpFKaYLA07BwRRpFw1+RxcROE0pdpe/0OPf1Ff0qcJbMFqvGgF+wxE6Nybh2x2cmM9RcVzzOWbi8ieR6mD1x2UYoJypgO8eKLh8AdzVjeEmcUQ/JBBI9V+kkOOGc3kXfxns1ZQcA049HbkVmcOphNGXxuUrg0ccPgk0rUTcvcRxcVEET6SppGrYu/ifYlia41wOa0Aw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4452.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25eb8e15-04ec-424e-a311-08d86e95a3ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 10:00:25.1342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SjqlhynhD3ZYOKAhF0q/liiqnJaSImo+zf1FgTpZNKw/HWEun0AwRcVNwDUCAM+ZHNEEpJb9sL252+6XevNaHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452
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
Cc: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Kamliya,
 Prakash" <Prakash.Kamliya@amd.com>, "Surampalli,
 Kishore" <Kishore.Surampalli@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQoN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxD
aHJpc3RpYW4uS29lbmlnQGFtZC5jb20+IA0KU2VudDogTW9uZGF5LCBPY3RvYmVyIDEyLCAyMDIw
IDM6MTQgUE0NClRvOiBQYXRlbCwgTWloaXIgPE1paGlyLlBhdGVsQGFtZC5jb20+OyBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IENoYXVoYW4sIE1hZGhhdiA8TWFkaGF2LkNoYXVo
YW5AYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IFN1cmFtcGFsbGksIEtpc2hvcmUgPEtpc2hvcmUuU3VyYW1wYWxsaUBhbWQuY29tPjsgS2Ft
bGl5YSwgUHJha2FzaCA8UHJha2FzaC5LYW1saXlhQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BB
VENIIHYzXSBkcm0vYW1kZ3B1OiBBZGQgZGVidWdmcyBlbnRyeSBmb3IgcHJpbnRpbmcgVk0gaW5m
bw0KDQpbU05JUF0NCj4gSGkgQ2hyaXN0aWFuLA0KPiBPbmUgcXVlc3Rpb24gcmVnYXJkaW5nIGdl
dHRpbmcgdG90YWwgYWxsb2NhdGlvbnMgYnkgYXBwIGFuZCBhbHNvIHN3YXBwZWQgc2l6ZSBmb3Ig
dGhlIGFwcC4NCj4gU2hvdWxkbuKAmXQgd2UgcHJpbnQgbWFwcGVkIGVudHJpZXMgYXMgd2VsbCB0
byBnZXQgdG90YWwgYWxsb2NhdGlvbiBieSB0aGUgcHJvY2VzcyA/DQo+IEFsc28gd2hpY2ggbGlz
dCB3b3VsZCByZXByZXNlbnQgc3dhcHBlZCBtZW1vcnk/DQoNCk5vbmUsIHdlIGRvbid0IHJlYWxs
eSBoYXZlIHRoYXQgaW5mb3JtYXRpb24gYW55d2hlcmUgc2luY2Ugd2UgZG9uJ3QgcmVhbGx5IGhh
dmUgYSBzd2FwcGVkIHN0YXRlLg0KDQpTZWUgd2hlbiB0aGUgYXBwbGljYXRpb24gYWxsb2NhdGVz
IGEgQk8gaW4gVlJBTSB0aGUga2VybmVsIGRyaXZlciBpcyBmcmVlIHRvIHN3YXAgaXQgb3V0IHRv
IEdUVCBhbmQgc3RpbGwgZG8gY29tbWFuZCBzdWJtaXNzaW9uLiBPbmx5IHdoZW4gaXQgaXMgZnVy
dGhlciBzd2FwcGVkIG91dCB0byB0aGUgQ1BVIGRvbWFpbiBpdCBpcyBub3QgYWNjZXNzaWJsZSBh
bnkgbW9yZS4NCg0KU28gd2hhdCB5b3UgY2FuIGRvIGlzIHRvIGxvb2sgYXQgdGhlIEJPcyBpbiB0
aGUgQ1BVIGRvbWFpbiwgYnV0IHRoaXMgb25seSBnaXZlcyB5b3UgYSBjZXJ0YWluIGhpbnQgb24g
d2hhdCdzIGdvaW5nIG9uLg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQpUaGFua3MgQ2hyaXN0
aWFuIGZvciBjbGFyaWZ5aW5nIGFib3V0IHN3YXBwZWQgbWVtb3J5LiBIb3cgYWJvdXQgdG90YWwg
YWxsb2NhdGVkIHNpemU/IENhbid0IHdlIHByaW50IG1hcHBlZCBCT3Mgc2luY2UgYW1kZ3B1X2dl
bV9pbmZvIGlzIEZJTEUvZ2VtIGhhbmRsZSBiYXNlZD8NClJlZ2FyZHMsDQpNaWhpcg0KPg0KPiBU
aGFua3MsDQo+IE1paGlyDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
