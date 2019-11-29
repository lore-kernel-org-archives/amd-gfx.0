Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690F8C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CEAC217AB
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEAC217AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 075D96E02F;
	Fri, 29 Nov 2019 08:43:03 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730071.outbound.protection.outlook.com [40.107.73.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 180256E02F
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 08:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbFuZKKugMBYMhQ4KN2Autm4hTwnS5mulixkdmSkAfNTRY5Vy31vH5fqh8b1WsfbNG6Kmo7fOEloLACvfW6ONxPJxnvFcXifkF00+3yTVxlU6gxX9aaAaXfsTWCXjicg29rDa1/CBDAHwQJFkerOTFq09YrVUG2O8Mksf9g7CPBI2+8IYY6abrzg94ARns0o1OQYTLh+rJ5ZG64Gn4SBYL6RUdBQjIJjiT9uVbxL4amgmZHZ91U8v8GPcBh7PQ22mo3t2fRpl4dw8zZErW4jzlwIHTJo33UQxfy6TiYyOymlQLAEycBqCuD3vx6X1PRfsImmk3PmmLRl6VyvQhGiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtGd0NldY7fyoUOHXEdeK6hrBBEANB43iIr6Nvfsdxg=;
 b=GMf4ZB4pa2/BOZTm7c7+oykZmjWM95O/1yaHgab0j/bXNCxwdsaSpAjoAoWZQegbQa/CPJDVCIfqsIUn5aZ+T3ZhP+ODbazQk+ImXqF6yPOo9GGsZvgOrk0wT99GKrxcxmIrnEI1xoOPWH+4rEYUzFSGauaBJzMS6LVEmftjTdQgzIzfN6buNK+sI+GWZ0HK22UDuUEQTJjIsosrt45Inf54+FuUnzjAU/ATpp3GCKD53w45XWWaZxzLgodnpUStLjrbzhidjCt0YqYLstzdVoiVeJm3VJWwGrfVQgQLjuukqmDrkECua8ApldE9I/kuPUsox4WXJ4Ivm+3TMXS86g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1289.namprd12.prod.outlook.com (10.168.239.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 08:43:00 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::b011:48ff:bf60:75a7%8]) with mapi id 15.20.2474.023; Fri, 29 Nov 2019
 08:43:00 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix GFX10 missing CSIB set
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix GFX10 missing CSIB set
Thread-Index: AQHVpo6OZhUrafAMD0WsHkOCG51Braeh0m+g
Date: Fri, 29 Nov 2019 08:43:00 +0000
Message-ID: <DM5PR12MB1418C0672D65E71D75E039DDFC460@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1575015812-26634-1-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1575015812-26634-1-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-11-29T08:42:53Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=35f992a8-ce68-4de1-928c-0000be5751a9;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-11-29T08:42:53Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d0dc12ae-be47-412b-bac1-0000084b11a9
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1778b038-43d8-4f99-1fa9-08d774a823f1
x-ms-traffictypediagnostic: DM5PR12MB1289:|DM5PR12MB1289:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1289CDCE165D8E3076D2F44CFC460@DM5PR12MB1289.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(189003)(199004)(13464003)(52536014)(478600001)(25786009)(229853002)(86362001)(186003)(2906002)(5660300002)(66446008)(71190400001)(11346002)(446003)(102836004)(256004)(74316002)(64756008)(76176011)(66476007)(66946007)(99286004)(55016002)(71200400001)(33656002)(8676002)(966005)(81166006)(4326008)(76116006)(53546011)(81156014)(7696005)(66556008)(26005)(6436002)(8936002)(45080400002)(2501003)(14454004)(6506007)(66066001)(7736002)(305945005)(6116002)(316002)(9686003)(6246003)(3846002)(110136005)(6306002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1289;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N/IQbTmDAkHPit0k3hFpChbrDcnOtbaOWQCPbIu3E+hyiUq0sC6xMsKk3a3/mrVAGqu3EUXnnYRZF2QnKOr2vr+JXWHk/Lhd5Gpl2v0/FKCI+J7juCYrQcus+kKQr6r3ksCQEWOyTnybEvXxrQXoHluJDDxTPt5rstkibvH+BPbN+tyYU6p7RF4h5iRHrNH6av76hv++3AYT7PkT2Rgxk1SV0YGdmUIWFB2edQDjc5icbZIciCAPE8Br7OV6AAVGbojd8T7zdp+cZDgSw8k0FW5DfGM20QXbdyxakux7U9LQGM8baqlOmn9X6iiTutX4ohK8tbZR5FvnvmCWWS0vj87BzLmottc/itNWxWl5Q0jNmSPA5mbw/XQPiVx1C8asf9uvO9arVXvxDgNq9koqE/6ZEb2LoUSqud23dLxu3ic/3KJI9/VJDhuKCclfiHl8OoYq5IX5z8nNOj1t7zotcJFDObT7NIsqSNdeg4J93Jc=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1778b038-43d8-4f99-1fa9-08d774a823f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 08:43:00.1317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: drvfNON/Cifa53rDyrSWanD26MW+pRRb/pXL1HhexZ81WnmzezuYNT+hfsr5IuteWLExlTWWQ/yyDBkhO+U7aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1289
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtGd0NldY7fyoUOHXEdeK6hrBBEANB43iIr6Nvfsdxg=;
 b=Nd3mS1ETQ+nUMMSPLkxWzknQT49xLRrPzoc+Pc3qLTNzJ3apdGGvyuftOOFBe8teDM25Bst92V0IKCdcmLtGGTkF8Rf7ovhhP+N1VfWe5ZIIdASIN+sSiA8BBEsVWvxofizvUvUfR8hWHWJfoAfwbQwbF/YZTR5pNo0ldbfWEP0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpJ
IGRvbid0IHRoaW5rIHlvdSBuZWVkIHRvIGludHJvZHVjZSBTUklPViBzcGVjaWZpYyBwYXRoIGhl
cmUuIFRoZSBnZnhfdjEwXzBfaW5pdF9wZyBzaG91bGQgYmUgZ29vZCBlbm91Z2ggdG8gY292ZXIg
Ym90aCBiYXJlLW1ldGFsIGFuZCB2aXJ0dWFsaXphdGlvbiBjYXNlLiANCg0KWW91IGNhbiBkcm9w
IHRoZSB0bGIgZmx1c2ggaW4gdGhhdCBmdW5jdGlvbiBpZiB0aGF0J3MgeW91ciBtYWpvciBjb25j
ZXJuLg0KDQpSZWdhcmRzLA0KSGF3a2luZw0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJl
aGFsZiBPZiBNb25rIExpdQ0KU2VudDogMjAxOeW5tDEx5pyIMjnml6UgMTY6MjQNClRvOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IExpdSwgTW9uayA8TW9uay5MaXVAYW1kLmNv
bT4NClN1YmplY3Q6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IGZpeCBHRlgxMCBtaXNzaW5nIENT
SUIgc2V0DQoNCnN0aWxsIG5lZWQgdG8gaW5pdCBjc2IgZXZlbiBmb3IgU1JJT1YNCg0KU2lnbmVk
LW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDggKysrKystLS0NCiAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjEwXzAuYw0KaW5kZXggNzRlZGZkOS4uMjMwZThhZiAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjEwXzAuYw0KQEAgLTE4NzQsMTQgKzE4NzQsMTYgQEAgc3RhdGljIGlu
dCBnZnhfdjEwXzBfcmxjX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikgIHsNCiAJ
aW50IHI7DQogDQotCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpDQotCQlyZXR1cm4gMDsNCi0N
CiAJaWYgKGFkZXYtPmZpcm13YXJlLmxvYWRfdHlwZSA9PSBBTURHUFVfRldfTE9BRF9QU1ApIHsN
CiAJCXIgPSBnZnhfdjEwXzBfd2FpdF9mb3JfcmxjX2F1dG9sb2FkX2NvbXBsZXRlKGFkZXYpOw0K
IAkJaWYgKHIpDQogCQkJcmV0dXJuIHI7DQogDQorCQlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYp
KSB7DQorCQkJZ2Z4X3YxMF8wX2luaXRfY3NiKGFkZXYpOw0KKwkJCXJldHVybiAwOw0KKwkJfQ0K
Kw0KIAkJciA9IGdmeF92MTBfMF9pbml0X3BnKGFkZXYpOw0KIAkJaWYgKHIpDQogCQkJcmV0dXJu
IHI7DQotLQ0KMi43LjQNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCmFtZC1nZnggbWFpbGluZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJs
PWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZv
JTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJTdDaGF3a2luZy56aGFuZyU0MGFtZC5jb20lN0Nj
MzQzYWZhOWFhMjM0Y2JiODI3NTA4ZDc3NGE1NzI2OCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgy
ZDk5NGUxODNkJTdDMCU3QzAlN0M2MzcxMDYxMjcyNzczNTMwODYmYW1wO3NkYXRhPUt0JTJGZDE2
ODBSYzNseUZ3ejRuZzVlQTdKeGlZV2pmMXdoREJwZm5IelRKcyUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
