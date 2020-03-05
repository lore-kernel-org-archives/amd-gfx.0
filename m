Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FF9C3F2CD
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 05:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E33CE2072D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 05:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GjWEeL9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33CE2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 907D56E14B;
	Thu,  5 Mar 2020 05:24:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C006F6E14B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 05:24:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPi5NIzNbSk+ERYK9emFnGESr9aX7l8kCU36P22ouTtGrKwy4PYADnWtUTgEc+ZJV9219Hw4xnjWq1R8SBqiWNIkq64wOw8LxBESm6BpRu6HiBzIBQjudCIMIxKmjjLqVLCVdf8n2ArwVmF+TaahUwHvn8muPpST2ayuTfU1aSyIiVR+Vm9dagVOV6JtJGJuuLAJq0dauP6hTJSBR3h09in0UaYA0tXABI1lt19q2vaamPIRxeGHcprI2aWyCfNl0+0Iyuf/iaLHxEy9pFa15UtoMOV+YP9A6f4tJtcje7YCcJOn2xhQCaLZ1TmXiL9i6FxxWGDOn6gBkHqanUOsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcAvk6Wgm6AKZrG6HXt3tTJf+Z7JZuFK3srf2gVFk1o=;
 b=H2pOMgpFhT3y8drvh5I5Yy8WdTZbYt56oTO4vP0megshhWGtR25BSiitjjTdnfmcwZsTvii9dpxvtStctbY66j9PzTSGsYA9nGLF51h1cZpZzxcMrtwDn1TjG1lhhrAiuLfj+auGSwIscZJ/hc7DU53JTec03ZSwRGt3OdjYqefQe7o27tV6DNafmBSJnvYACRLUJ+n3Uqvpfzt+HRpJYNbm60SyMLyxt/Fs2lNSapUVCq+BU/f3XPTfVVmk6WgIZF+Eor4XW1EMuIdDBjHTFPC1IhtDC/X8UNvLpXMyF5x0WEax3r+596bskWIji0y5rx8/AEkDuhWFxNqPWzR8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcAvk6Wgm6AKZrG6HXt3tTJf+Z7JZuFK3srf2gVFk1o=;
 b=GjWEeL9l1z4elHW3o+5SaCOBNCX7exk7LSD5d0k9UuH8ZmP+Y1riPNHx14EyHsoE9kiPVpQ7HGQ9kYJBjt5/VjnNZFkKODeEnKVXtuAnYjLg9ydgK5+xoALz82dpjTIvzg/WR+WAxpd5Ei7w2CJEj+UKviXPwmOp3ivornZqxYg=
Received: from CH2PR12MB3767.namprd12.prod.outlook.com (2603:10b6:610:26::21)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 5 Mar
 2020 05:24:17 +0000
Received: from CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::703e:37ee:ddb1:d321]) by CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::703e:37ee:ddb1:d321%3]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 05:24:17 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fetching
Thread-Topic: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fetching
Thread-Index: AQHV7Bq468Vjz2GRSUea0X3otJp4SKg5hAkAgAAASmA=
Date: Thu, 5 Mar 2020 05:24:17 +0000
Message-ID: <CH2PR12MB3767A6BF43D694CD494E0B58FEE20@CH2PR12MB3767.namprd12.prod.outlook.com>
References: <20200225203224.1129396-1-alexander.deucher@amd.com>
 <CADnq5_MGixxj8tdOhb7Tg1hNEGGd7Ue0bgCEtKOYaD7n-u0K8A@mail.gmail.com>
In-Reply-To: <CADnq5_MGixxj8tdOhb7Tg1hNEGGd7Ue0bgCEtKOYaD7n-u0K8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-05T05:24:14Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1469de53-9319-4ac0-93af-00000eee6d7c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-05T05:24:14Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 8a715594-0419-4b15-973d-0000a05a5457
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Feifei.Xu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1d03078f-6448-4b82-f3b5-08d7c0c5738d
x-ms-traffictypediagnostic: CH2PR12MB4231:|CH2PR12MB4231:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4231925CC82247298C75BCEEFEE20@CH2PR12MB4231.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(66476007)(66446008)(66556008)(66946007)(110136005)(76116006)(33656002)(316002)(54906003)(64756008)(52536014)(2906002)(5660300002)(53546011)(9686003)(6506007)(8936002)(55016002)(966005)(4326008)(478600001)(26005)(8676002)(81166006)(71200400001)(81156014)(86362001)(7696005)(186003)(45080400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4231;
 H:CH2PR12MB3767.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wIC/TPcAUa+jIjO+KUTw7KOCUNgEi9c698MCb32Os+1Ctp1QLsTuuGV2IxwEXJfBJTdLWISCx8hIXxh/63TDlHJleYR3C05EvCadRFuwrQFwYa2u45sizYl8n4JcpNVe09i8Xlb/BpuKtX05Fl5XhDKR3h5kn43HEMNcM4zKY/vRui8Xe9B29YCpV6tOW2Eki5cNfEL0aa9nrvyTHOjmZLUW/FMNZCSeSjJ8LOforwA84WL+Fpx5MX+PXOwAup9D4QhNkh+Y4H3AlKicDkLJgf2larVbL8h4NZbP/ya+x/Ty1vjPCbro1NeQI5rxzgy/RX3c9h2OwNUd2VUtdtiEZroCPyhDbjUDRuApCXZs1CWz7Q7O18ES9t0biTGnCvAt8acssE6BzJ4NE1Wa+ObOciiJXEvjIseBgNzHcWsN/b3L48GzxEb/8FtKb4bCydBosqKIsfXItv5wHIG1wzBJ4AaGGzHPNAOEsaVGzAUDVdk=
x-ms-exchange-antispam-messagedata: Qzt2UI5+zHh8SHwULVrWBM/HyyYS2i/cjus89mBmOtAyrQIDXct7aVIYstgGxE0ouk4TsB1zR8gl4j/BsrstfC/PAQ9/SL5zlhR1MZk9KZsCEKrJ5RsDE+nvjyBk3ztYZPXfIepej9N26nKneI+KZA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d03078f-6448-4b82-f3b5-08d7c0c5738d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 05:24:17.4468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Nkoo3NqY7xUM/WsFEPwa8h/vKsu2QHR+DoPLxSOInx+HEtS5YXH70aX1bsgr+cg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tawfik,
 Aly" <Aly.Tawfik@amd.com>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQoN
Cg0KUmV2aWV3ZWQtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+DQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleCBEZXVjaGVyDQpTZW50OiAyMDIwxOoz
1MI1yNUgMTM6MjMNClRvOiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPg0KQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47
IFRhd2ZpaywgQWx5IDxBbHkuVGF3ZmlrQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDEv
Ml0gZHJtL2FtZGdwdS9kaXNwbGF5OiBmaXggcGNpIHJldmlzaW9uIGlkIGZldGNoaW5nDQoNClBp
bmc/DQoNCk9uIFR1ZSwgRmViIDI1LCAyMDIwIGF0IDM6MzIgUE0gQWxleCBEZXVjaGVyIDxhbGV4
ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPg0KPiBGcm9tOiBBbHktVGF3ZmlrIDxhbHRhd2Zp
a0BhbWQuY29tPg0KPg0KPiBVc2UgdGhlIHBjaSByZXZpc2lvbiBpZCByYXRoZXIgdGhhbiB0aGUg
YXNpYyBzaWxpY29uIHJldmlzaW9uIGlkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbHktVGF3Zmlr
IDxhbHRhd2Zpa0BhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4gaW5kZXggMGM1NWQ0NGM5ZDViLi45
MjE2NjE1MGJmOWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9h
bWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG0uYw0KPiBAQCAtOTAyLDcgKzkwMiw3IEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X2RtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+DQo+ICAgICAgICAg
aW5pdF9kYXRhLmFzaWNfaWQuY2hpcF9mYW1pbHkgPSBhZGV2LT5mYW1pbHk7DQo+DQo+IC0gICAg
ICAgaW5pdF9kYXRhLmFzaWNfaWQucGNpX3JldmlzaW9uX2lkID0gYWRldi0+cmV2X2lkOw0KPiAr
ICAgICAgIGluaXRfZGF0YS5hc2ljX2lkLnBjaV9yZXZpc2lvbl9pZCA9IGFkZXYtPnBkZXYtPnJl
dmlzaW9uOw0KPiAgICAgICAgIGluaXRfZGF0YS5hc2ljX2lkLmh3X2ludGVybmFsX3JldiA9IGFk
ZXYtPmV4dGVybmFsX3Jldl9pZDsNCj4NCj4gICAgICAgICBpbml0X2RhdGEuYXNpY19pZC52cmFt
X3dpZHRoID0gYWRldi0+Z21jLnZyYW1fd2lkdGg7DQo+IC0tDQo+IDIuMjQuMQ0KPg0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCmFtZC1nZnggbWFpbGlu
ZyBsaXN0DQphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KaHR0cHM6Ly9uYW0xMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3
QzAxJTdDRmVpZmVpLlh1JTQwYW1kLmNvbSU3Q2RkNDkyMzIyNjFhYzQyNjdhMzNmMDhkN2MwYzU0
YWQ4JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE4OTgy
NTkwODY4MzgwNCZhbXA7c2RhdGE9c04lMkJHU3ZybW56NVFkcmY0SlIwc0ZVRFdNV3l1N3RzT2g2
Wkc5bGI5STVZJTNEJmFtcDtyZXNlcnZlZD0wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
