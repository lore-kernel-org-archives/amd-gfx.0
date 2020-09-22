Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E66C4363D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 14:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AECC20936
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 14:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ioPzWXUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AECC20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A35A189AAE;
	Tue, 22 Sep 2020 14:00:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8403E890BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 14:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5/KiFmqVrv2972eW44YDgOkloG1QLjUob0i3Sq38thWhbqkZpwVXv/QNzdTvpKzSlvFmVOTU84magRNThR5hmPyLlUfkruB+z2Mu7JeZm2GrodWYqIEXEIvPxZwWGtVjEUztfOvPFLoOJsGt0+iOMAE+l+kUvGoQDMnow5Ch2z4dDolMfOnYBcFCM5+Z363F37Asj6mqHcRktoNhadpluCPZdDt8nSqugKILm0GsGXcOxKuXTYbudhVs8xxLAGE4OB1CBsQVGI+0vT/Vm+nJvhOmK19bwOI03R8oGWQHLk7jbMvMDFeDF4cMxB8r45ln6fVb3yiAV+LAxpIARtZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7tCnj1LGH7Ygn8Ww2o8c1B6DGX/Fw+kxS1s1XpvZig=;
 b=b5BaCmtPe1iDAXL3NqUySJDrujkvHK20mR7s4KdlpDILiDvn190Vqg//k3POitDg6r14dcFkVP85ZcESd7Xehj9JQibktEQEB6B5oVAoWOCB9CeY7B9ynFnDhNL7sY3oNzwSgLT1fqnoBBOrWTiTkwLEXNyVNFjkFVdmjGurfTccVch84wgk4EmcaLI8SZQwTcgDPznCRCpcZnGlMJyDl+bgQOqeT7q7jjVDTjViKXbCYon5tsclFE5Z8HX1+bM5X0hU12G7LQq06xfrRwi4g5ASFuYTcADMNAyltMpBvu41cClvBTj/O/f1U8DS6z2S7wh8p6ZOh/k3bduDgJQvXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7tCnj1LGH7Ygn8Ww2o8c1B6DGX/Fw+kxS1s1XpvZig=;
 b=ioPzWXUIEikRxVyDR+jqZ2NmF1/9OKnIaO4K964REgiiPM7VlY6EeeUSFekEH+RS78zcwxYEuAh1hCumCEv7lyrXA5kWnYO4XZmXYtS/rh+Wj7AERP5h8wvFCQYZKvoE2tmbkIdHKWqAQr+EhQtn0CxUc0jseZIN/m6g+77Ww8U=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 22 Sep
 2020 14:00:40 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 14:00:40 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdkfd: fix wanting in print statement
Thread-Topic: [PATCH] drm/amdkfd: fix wanting in print statement
Thread-Index: AQHWkF0S4ZbUek2vxkGaUWHudWtbmalznLSAgAEStsCAAADqgIAAAFYQ
Date: Tue, 22 Sep 2020 14:00:40 +0000
Message-ID: <DM6PR12MB3721A1538D5D4418B1268A28853B0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200921212026.364094-1-alexander.deucher@amd.com>
 <CADnq5_M58bpM9WjFbM9NrmhwVVwtzyvFGC-3ev5J=kHaLBfs4Q@mail.gmail.com>
 <DM6PR12MB3721639FE926748D47E245F2853B0@DM6PR12MB3721.namprd12.prod.outlook.com>
 <CADnq5_OHSmBu4Jk5nsy_O8SVdA0Cs-S0GSt+tQV_SHqY+hKUzw@mail.gmail.com>
In-Reply-To: <CADnq5_OHSmBu4Jk5nsy_O8SVdA0Cs-S0GSt+tQV_SHqY+hKUzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-22T14:00:37Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ff48fb92-69ba-4a10-a864-00001bce8e34;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-22T14:00:33Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 96e7aeab-f252-4ed5-b266-000063eb180a
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-22T14:00:38Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: e512849a-6a35-4a7f-a4da-000070a92868
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1c80:6680:9dce:1d67:cc43:ab08]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a33bbf5-d4fa-4952-2b8e-08d85effe3ac
x-ms-traffictypediagnostic: DM6PR12MB4107:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4107664CD6544F3F0F05ABD0853B0@DM6PR12MB4107.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZhiWjteuhqGYDotkPUlSMe78ZOTrI5UTmNkgkD9OqiH3h1d8JatgO0zHhej4+SPWlJojB+177TBpgvR/u6uWhxvLl5ghrGfgnXc48v5eQpBsJbdFyf7aeNraGxg510E4XTgNtwsfIZq+eOPIaxP2rMt9irie3HMMyvodEYxsHTjyWIhkxCZwvoRwjLGDePoomx86trLhmytqKcOkrswxcHKiauljMzedVWkQTklMdzvKSb6NmDTSRRT5Ld0Pc9n/P8228jkaIVNmf4CHren/sZ3qsVVSFTBeABMHMs6l3VucNWokLhfHzr7BrmFZqQjE0KtXfMAjaWTp8k4cLYg4V/L6lgxYSYmyp7tMulBaSj4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(33656002)(5660300002)(52536014)(83380400001)(966005)(71200400001)(66476007)(66556008)(66946007)(66446008)(64756008)(76116006)(53546011)(9686003)(55016002)(186003)(316002)(7696005)(86362001)(8676002)(6506007)(54906003)(2906002)(4326008)(45080400002)(478600001)(8936002)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 08r024I6+Z08fbPLhZMDA5SkBXHyhmkXDGqDf1a/wl/CHHM7OJ3Qt3xiUYybpTIMXkMyMC8oYWC6laEqINtgFl/h3lnl0lfreJ026U1aE6hTW+QPEEhXIag/InjpSPlv555GpX8Lg5TaFXPNGwu7fPBw0hKMcJp/7fVdv6I84uuNMEcZ5Eqq/k0Ad0TAI4ADhWZelE/I7AFnz5f4Ix0bOHypRye3DR/KNhmc5gczc8Q20PIuUeoOVyebTMoDlafkG01pR6zOPALPJV8Pyvzo6k/kJyzH7VRe3ITe3i1sVZxZ1WgBIzKfWllczsNOZbly17hoKlg/WmFiAlB5nQB6o1UNubwB8slYrpX0q+93authyAeIZgTltO+O4zpV++pdrHUyZdjUKDR5ABieloC93sQqKHySalroFJL/BjutGBMzRNuKO+DHz5bkkIk+abWDSYimIjcOEh+9FSKrMdy2TQN8l1Q+StDIBgdk5diJ+bUXxfh48QO2B/EBeCetkrMeFqCFMeVpkQrNfV9VLfEKCpKfRkLgZb/ZzIL5cXdJe8qxYQC8BuyvAaODIauO8bmAfpACpfkk1RWxI8KRl1ercYl1HGoz+8xe15mrUIaNIPC5n0RiQdERz43GSS70LAAWDaEPhxK+x+Kr9hy96yAn+7O0U4Dr62IQPIODstfJhA2i1bJ0hAGZwpNvwWgRTdcwiYNS6KEcdN01K0grp29DEA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a33bbf5-d4fa-4952-2b8e-08d85effe3ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2020 14:00:40.0269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Z4CD6ukuVVvhoTuMjuad417Tn49QSBD36/Ug6hMRuOkRe/ldAwLMsNKfpJhpjIoxV7TiGIi9l4stfwpsnyNEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQpEZWZpbml0ZWx5LiBSZXZpZXdlZC1ieTogS2VudCBSdXNzZWxs
IDxrZW50LnJ1c3NlbGxAYW1kLmNvbT4gLiANCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDog
VHVlc2RheSwgU2VwdGVtYmVyIDIyLCAyMDIwIDk6NTkgQU0NCj4gVG86IFJ1c3NlbGwsIEtlbnQg
PEtlbnQuUnVzc2VsbEBhbWQuY29tPg0KPiBDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogZml4IHdhbnRp
bmcgaW4gcHJpbnQgc3RhdGVtZW50DQo+IA0KPiBDYW4gSSBnZXQgYW4gUkI/DQo+IA0KPiBPbiBU
dWUsIFNlcCAyMiwgMjAyMCBhdCA5OjU2IEFNIFJ1c3NlbGwsIEtlbnQgPEtlbnQuUnVzc2VsbEBh
bWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IFtBTUQgUHVibGljIFVzZV0NCj4gPg0KPiA+IFRoYW5r
cyBBbGV4LCBzb3JyeSBhYm91dCB0aGF0IQ0KPiA+DQo+ID4gIEtlbnQNCj4gPg0KPiA+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBBbGV4IERldWNoZXINCj4g
PiA+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDIxLCAyMDIwIDU6MzMgUE0NCj4gPiA+IFRvOiBh
bWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0KPiA+ID4gQ2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gPiA+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IGZpeCB3YW50aW5nIGluIHByaW50IHN0YXRlbWVu
dA0KPiA+ID4NCj4gPiA+ICJ3YXJuaW5nIiBpbiBwcmludCBzdGF0ZW1lbnQuICBGaXhlZCBsb2Nh
bGx5Lg0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgU2VwIDIxLCAyMDIwIGF0IDU6MjAgUE0gQWxleCBE
ZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9hbWRrZmQva2ZkX2NyYXQuYzogSW4gZnVuY3Rp
b24NCj4gPiA+IOKAmGtmZF9jcmVhdGVfY3JhdF9pbWFnZV92aXJ0dWFs4oCZOg0KPiA+ID4gPiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9hbWRrZmQva2ZkX2NyYXQuYzoxMzkxOjEyOiB3
YXJuaW5nOiBmb3JtYXQg4oCYJWTigJkNCj4gPiA+IGV4cGVjdHMgYXJndW1lbnQgb2YgdHlwZSDi
gJhpbnTigJksIGJ1dCBhcmd1bWVudCAzIGhhcyB0eXBlIOKAmHNpemVfdOKAmSB7YWthIOKAmGxv
bmcgdW5zaWduZWQgaW504oCZfQ0KPiBbLQ0KPiA+ID4gV2Zvcm1hdD1dDQo+ID4gPiA+ICAxMzkx
IHwgICBwcl9kZWJ1ZygiQ1JBVCBzaXplIGlzICVkIiwgZHluX3NpemUpOw0KPiA+ID4gPiAgICAg
ICB8ICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn4NCj4gPiA+ID4gLi9pbmNsdWRlL2xpbnV4
L3ByaW50ay5oOjI5NzoyMTogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyDigJhwcl9mbXTi
gJkNCj4gPiA+ID4gICAyOTcgfCAjZGVmaW5lIHByX2ZtdChmbXQpIGZtdA0KPiA+ID4gPiAgICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgXn5+DQo+ID4gPiA+IC4vaW5jbHVkZS9saW51eC9keW5h
bWljX2RlYnVnLmg6MTQzOjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybw0KPiA+ID4g4oCY
X19keW5hbWljX2Z1bmNfY2FsbOKAmQ0KPiA+ID4gPiAgIDE0MyB8ICBfX2R5bmFtaWNfZnVuY19j
YWxsKF9fVU5JUVVFX0lEKGRkZWJ1ZyksIGZtdCwgZnVuYywgIyNfX1ZBX0FSR1NfXykNCj4gPiA+
ID4gICAgICAgfCAgXn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+ID4gPiAuL2luY2x1ZGUvbGludXgv
ZHluYW1pY19kZWJ1Zy5oOjE1MzoyOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8NCj4gPiA+
IOKAmF9keW5hbWljX2Z1bmNfY2FsbOKAmQ0KPiA+ID4gPiAgIDE1MyB8ICBfZHluYW1pY19mdW5j
X2NhbGwoZm10LCBfX2R5bmFtaWNfcHJfZGVidWcsICBcDQo+ID4gPiA+ICAgICAgIHwgIF5+fn5+
fn5+fn5+fn5+fn5+fg0KPiA+ID4gPiAuL2luY2x1ZGUvbGludXgvcHJpbnRrLmg6NDIwOjI6IG5v
dGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhkeW5hbWljX3ByX2RlYnVn4oCZDQo+ID4gPiA+
ICAgNDIwIHwgIGR5bmFtaWNfcHJfZGVidWcoZm10LCAjI19fVkFfQVJHU19fKQ0KPiA+ID4gPiAg
ICAgICB8ICBefn5+fn5+fn5+fn5+fn5+DQo+ID4gPiA+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1Ly4uL2FtZGtmZC9rZmRfY3JhdC5jOjEzOTE6Mzogbm90ZTogaW4gZXhwYW5zaW9uIG9mDQo+
IG1hY3JvDQo+ID4gPiDigJhwcl9kZWJ1Z+KAmQ0KPiA+ID4gPiAgMTM5MSB8ICAgcHJfZGVidWco
IkNSQVQgc2l6ZSBpcyAlZCIsIGR5bl9zaXplKTsNCj4gPiA+ID4gICAgICAgfCAgIF5+fn5+fn5+
DQo+ID4gPiA+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2FtZGtmZC9rZmRfY3JhdC5j
OjEzOTE6Mjc6IG5vdGU6IGZvcm1hdCBzdHJpbmcgaXMNCj4gPiA+IGRlZmluZWQgaGVyZQ0KPiA+
ID4gPiAgMTM5MSB8ICAgcHJfZGVidWcoIkNSQVQgc2l6ZSBpcyAlZCIsIGR5bl9zaXplKTsNCj4g
PiA+ID4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgfl4NCj4gPiA+ID4gICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiA+ID4gICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGludA0KPiA+ID4gPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAg
ICAgICAlbGQNCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMgfCAyICstDQo+ID4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMNCj4gPiA+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYw0KPiA+ID4gPiBpbmRleCBjNTBl
OWY2MzRkNmMuLmQyOTgxNTI0ZGJhMCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfY3JhdC5jDQo+ID4gPiA+IEBAIC0xMzg4LDcgKzEzODgsNyBAQCBpbnQg
a2ZkX2NyZWF0ZV9jcmF0X2ltYWdlX3ZpcnR1YWwodm9pZCAqKmNyYXRfaW1hZ2UsIHNpemVfdA0K
PiA+ID4gKnNpemUsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICBpZiAoIXBjcmF0X2ltYWdlKQ0K
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiA+ID4g
ICAgICAgICAgICAgICAgICpzaXplID0gZHluX3NpemU7DQo+ID4gPiA+IC0gICAgICAgICAgICAg
ICBwcl9kZWJ1ZygiQ1JBVCBzaXplIGlzICVkIiwgZHluX3NpemUpOw0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgcHJfZGVidWcoIkNSQVQgc2l6ZSBpcyAlbGQiLCBkeW5fc2l6ZSk7DQo+ID4gPiA+
ICAgICAgICAgICAgICAgICByZXQgPSBrZmRfY3JlYXRlX3ZjcmF0X2ltYWdlX2NwdShwY3JhdF9p
bWFnZSwgc2l6ZSk7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiA+ID4gICAg
ICAgICBjYXNlIENPTVBVVEVfVU5JVF9HUFU6DQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIuMjUuNA0K
PiA+ID4gPg0KPiA+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18NCj4gPiA+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+ID4gPiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPiA+ID4NCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlv
bi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJlZWRlc2t0b3Aub3INCj4g
PiA+IGclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtDQo+ID4gPg0KPiBnZngmYW1wO2RhdGE9
MDIlN0MwMSU3Q2tlbnQucnVzc2VsbCU0MGFtZC5jb20lN0M2MTFmYzI1NzM1ZTA0MWZiZDNkNzA4
ZDg1ZTc1DQo+ID4gPg0KPiBlMzU1JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2Ql
N0MwJTdDMCU3QzYzNzM2MzIwNzcyMTczNzc2NiZhbXA7DQo+ID4gPiBzZGF0YT1Cdk1SQ1BZSzBX
dVhUSkFvdE5NRmZHN2xCbjJ0NGRZb2dEVW9SWlFyVGRBJTNEJmFtcDtyZXNlcnZlZD0wDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
