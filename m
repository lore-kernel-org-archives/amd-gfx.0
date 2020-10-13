Return-Path: <SRS0=VV5o=DU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A422C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 12:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADED722370
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 12:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a/Slln7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADED722370
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CF416E30D;
	Tue, 13 Oct 2020 12:19:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 995B46E30D
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2020 12:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dN7OfpNpSrQmJ5f+4qa40J7tJ7usWnj9f/AH+iYoms71NhNxlLy031lZ3fS++yKZGt3H91lXvIXPIN3vJdz6rIzQ29oE6LxcNg05wsCjDaAhLsUdJA5PZjYORFGIMecQNRGvOrVgZj1V++FoKkAuWc+O8cmL41GidqKFrxqG5cMROWQQKMTS8gJlJnNKw0WQmlHn+deAzPK5kna6PIso6bFqozEzHJ4J21nstcyTPDR9SCOiQ4DFqljzx8jR07AcA8hCTklEePPPAtv5jUO317k+vDTzyfPKyoEJbrhIoI9Hs5xe2pw7Ho6WywPVrcxm4cMvZvn6158YUFnncNYBzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7o3H32r28fAq7+R/4DWzgfeN2TCKkLIfnjM0aIBpLTw=;
 b=OcvVYKpHR/dlfcVr2Ib1bYR3ZDIhbvDvjsB6HS9ZDxsX+KLr4L+qV/tQ1Jgf+heqT0mJNBFSUT49RgRxsp38R9ShBaI/RkjdDKTMztztHh63rKTGwGtwJebNp+79gr/ZMmg8EuYx9BWCmkyqjNmoZu+yhgHaItwOaMgOpRQhXbT+dW4qrdWnQKZR6TUcOBRVa7C0D0DhzP4sF9iYYnBOjsW7aFq5HcQtoDUDvWqsVWbZij0CTk+4aCxBgHzxw7WL18h1SXbdBkNOy2E7uqtfmmy5hbId3uuZA2AQyPZmth05Fxxh7uTeXQuEsk1aKlaSfqkkgCXHAFbB6NO0LMdGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7o3H32r28fAq7+R/4DWzgfeN2TCKkLIfnjM0aIBpLTw=;
 b=a/Slln7IVswJIgx+f5Dm1EeGhvZfs/AgK2QW2gGVPYEAEcSUSWKdO9kyQvaZg6rcsLO9hCCZupXZQtuTxug4MzminxtsSA0wrkOUJbzk8bjZ0wR8PHIe2MPOtzencRxk4G8caJ6y2NfhnOYtkogwFplPwTzhrW+i7ZxvsSFUkSo=
Received: from BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25)
 by BL0PR12MB2338.namprd12.prod.outlook.com (2603:10b6:207:4c::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 13 Oct
 2020 12:19:21 +0000
Received: from BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::bd7a:2354:a2d4:97fe]) by BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::bd7a:2354:a2d4:97fe%7]) with mapi id 15.20.3455.031; Tue, 13 Oct 2020
 12:19:20 +0000
From: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Patel, Mihir"
 <Mihir.Patel@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdgpu: Add debugfs entry for printing VM info
Thread-Topic: [PATCH v3] drm/amdgpu: Add debugfs entry for printing VM info
Thread-Index: AQHWoHZuiUDKLjM9mkOmkrmH0CerF6mTrkOAgAAHcYCAAAHkgIAABH2AgAAN3ICAAAEqgIABpHNA
Date: Tue, 13 Oct 2020 12:19:20 +0000
Message-ID: <BL0PR12MB2433165202ECE6FF54999D809C040@BL0PR12MB2433.namprd12.prod.outlook.com>
References: <20201012090159.28825-1-mihir.patel@amd.com>
 <d2d63bd0-61a0-33ce-67da-78143412d6b1@amd.com>
 <DM6PR12MB44527C86830BA20463BCFE6BE8070@DM6PR12MB4452.namprd12.prod.outlook.com>
 <64b13a59-f5c1-ff4c-f76a-0e1a00b249a0@amd.com>
 <DM6PR12MB4452CDAE4721D598694241B8E8070@DM6PR12MB4452.namprd12.prod.outlook.com>
 <24df1d90-04ad-e444-306d-7c2e16979b80@amd.com>
 <3d9496e3-74ec-288d-4736-eb583d0f1c92@amd.com>
In-Reply-To: <3d9496e3-74ec-288d-4736-eb583d0f1c92@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-13T12:19:15Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=71a6ce70-f04b-4b13-8ae8-000092ae3737;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-13T12:19:07Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d3a34340-47d8-47fa-89d0-000094e3fded
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-13T12:19:17Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 272f9e2a-cf4b-43a5-bd99-0000a37a757c
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.158.249]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da816315-98a6-42f7-ef6f-08d86f7236d0
x-ms-traffictypediagnostic: BL0PR12MB2338:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2338C1E6C5D77FE7CA2CFDC49C040@BL0PR12MB2338.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ck/+14gOKlcjSkkJmqHGJ076+eDKVnciXzT3nh330SIMrTOMxfxOWb8g7h0a1SUl6uMnKBUUwVgOZ98Nu0yXDqUkXeYH+TbinUCM+oifgdivkHsW5yEkcuQbIEvH+1TzLriF988tvdFt7ttZDsn9XLmS/0nVgGp7/MgM7QW75y/RR2JvdzdmbDSagOIl3lP0IVFtd1cZH+SyCpNStDXzf94OGz7hE6yKONhs2D34mJAisoEhL3RgHVKjEzjxhXln2VnW873QRt7AgivTGrlhsmWpUFsF/iHiUgKVFGHmgryek7J/gCu5VEG6m9DdrQTXMnoQdLdnaR60txdI44m6FOE1gMCmEa5nVdqXHHthlho=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(83380400001)(9686003)(66574015)(8676002)(33656002)(316002)(110136005)(54906003)(71200400001)(8936002)(64756008)(66556008)(66946007)(2906002)(66446008)(66476007)(7696005)(5660300002)(966005)(76116006)(52536014)(86362001)(6506007)(53546011)(26005)(186003)(478600001)(4326008)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: LWIi4Qn2YiL9Jb+sqyEn+2njyOvMfkV23DqQPWk/vLUp/D6BN9zRcgckUBa0ofnpMRTrPNUvTw1T3Gsw18a8ZKm7Lff2tqMAz5weHkmZ6vbUduWssi4zZC0l0LEC0Iu8VrlScLm58XR2rdHKg6TaVNd5g0gBUunDFeFz5lOD4fCRlWd7NabUpzwUVJbzAAvLnd7TFaTXxR/Ssai+5ZTMMy6AguIArU5rawVnLx4mOc1ZkKes3z0OzCf7t0SigLjzKi9u28Ic4aLhf72N9R11v+rjHskdRxMMBR0sPBSI8Up0uw6zToLPKInmKgScR1JbyqFVcpt8dtSpAKF5JRtgsqXBYmNT/ypfKr9pL95w0iZR0aVXMDm4sXaVIpLpU3nE7yKBJ0Eet8rs+z/nrjKxRpcb8MR/CZvew/1kt07hg+WXwStUIlyF8O812LxvgCEHuu/b2G1XDda5obZ704aV2agAc6d8uRP2FOHsY5HwsV06iiBIYU34jve5/33/R6wR/rSUf1I/500e6U4geJ7UhopLEsVvLZX5LXnOHe3B6hVmIfGXX703NQQHsk4YU9Gz9SK61xFzkU41XybkahcRuTxRLNCyx/9Y6CdaaWcPaGfpBLQP3xMax2bu1j0J6ZAlsZZaO6cMeCZTX9klAXMwgQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da816315-98a6-42f7-ef6f-08d86f7236d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 12:19:20.8103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5z9M46ravtL6t4IzCC1w71egJwDwnHSe/wZ3vsNo4IuNcPn7BTFk7Yxa0iwDUJPLzq8+yc+q2B0gp0ernUMFRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2338
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamliya,
 Prakash" <Prakash.Kamliya@amd.com>, "Surampalli,
 Kishore" <Kishore.Surampalli@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBQdWJsaWMgVXNlXQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS29l
bmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4gDQpTZW50OiBNb25kYXks
IE9jdG9iZXIgMTIsIDIwMjAgNDoyNCBQTQ0KVG86IFBhdGVsLCBNaWhpciA8TWloaXIuUGF0ZWxA
YW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogQ2hhdWhhbiwgTWFk
aGF2IDxNYWRoYXYuQ2hhdWhhbkBhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPjsgS2FtbGl5YSwgUHJha2FzaCA8UHJha2FzaC5LYW1saXlhQGFt
ZC5jb20+OyBTdXJhbXBhbGxpLCBLaXNob3JlIDxLaXNob3JlLlN1cmFtcGFsbGlAYW1kLmNvbT4N
ClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIGRybS9hbWRncHU6IEFkZCBkZWJ1Z2ZzIGVudHJ5IGZv
ciBwcmludGluZyBWTSBpbmZvDQoNCkFtIDEyLjEwLjIwIHVtIDEyOjUwIHNjaHJpZWIgQ2hyaXN0
aWFuIEvDtm5pZzoNCj4gQW0gMTIuMTAuMjAgdW0gMTI6MDAgc2NocmllYiBQYXRlbCwgTWloaXI6
DQo+PiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHld
DQo+Pg0KPj4NCj4+DQo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gRnJvbTogS29l
bmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4+IFNlbnQ6IE1vbmRh
eSwgT2N0b2JlciAxMiwgMjAyMCAzOjE0IFBNDQo+PiBUbzogUGF0ZWwsIE1paGlyIDxNaWhpci5Q
YXRlbEBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+IENjOiBDaGF1
aGFuLCBNYWRoYXYgPE1hZGhhdi5DaGF1aGFuQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIg
DQo+PiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFN1cmFtcGFsbGksIEtpc2hvcmUgDQo+
PiA8S2lzaG9yZS5TdXJhbXBhbGxpQGFtZC5jb20+OyBLYW1saXlhLCBQcmFrYXNoIA0KPj4gPFBy
YWthc2guS2FtbGl5YUBhbWQuY29tPg0KPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2M10gZHJtL2Ft
ZGdwdTogQWRkIGRlYnVnZnMgZW50cnkgZm9yIHByaW50aW5nIFZNIA0KPj4gaW5mbw0KPj4NCj4+
IFtTTklQXQ0KPj4+IEhpIENocmlzdGlhbiwNCj4+PiBPbmUgcXVlc3Rpb24gcmVnYXJkaW5nIGdl
dHRpbmcgdG90YWwgYWxsb2NhdGlvbnMgYnkgYXBwIGFuZCBhbHNvIA0KPj4+IHN3YXBwZWQgc2l6
ZSBmb3IgdGhlIGFwcC4NCj4+PiBTaG91bGRu4oCZdCB3ZSBwcmludCBtYXBwZWQgZW50cmllcyBh
cyB3ZWxsIHRvIGdldCB0b3RhbCBhbGxvY2F0aW9uIGJ5IA0KPj4+IHRoZSBwcm9jZXNzID8NCj4+
PiBBbHNvIHdoaWNoIGxpc3Qgd291bGQgcmVwcmVzZW50IHN3YXBwZWQgbWVtb3J5Pw0KPj4gTm9u
ZSwgd2UgZG9uJ3QgcmVhbGx5IGhhdmUgdGhhdCBpbmZvcm1hdGlvbiBhbnl3aGVyZSBzaW5jZSB3
ZSBkb24ndCANCj4+IHJlYWxseSBoYXZlIGEgc3dhcHBlZCBzdGF0ZS4NCj4+DQo+PiBTZWUgd2hl
biB0aGUgYXBwbGljYXRpb24gYWxsb2NhdGVzIGEgQk8gaW4gVlJBTSB0aGUga2VybmVsIGRyaXZl
ciBpcyANCj4+IGZyZWUgdG8gc3dhcCBpdCBvdXQgdG8gR1RUIGFuZCBzdGlsbCBkbyBjb21tYW5k
IHN1Ym1pc3Npb24uIE9ubHkgd2hlbiANCj4+IGl0IGlzIGZ1cnRoZXIgc3dhcHBlZCBvdXQgdG8g
dGhlIENQVSBkb21haW4gaXQgaXMgbm90IGFjY2Vzc2libGUgYW55IA0KPj4gbW9yZS4NCj4+DQo+
PiBTbyB3aGF0IHlvdSBjYW4gZG8gaXMgdG8gbG9vayBhdCB0aGUgQk9zIGluIHRoZSBDUFUgZG9t
YWluLCBidXQgdGhpcyANCj4+IG9ubHkgZ2l2ZXMgeW91IGEgY2VydGFpbiBoaW50IG9uIHdoYXQn
cyBnb2luZyBvbi4NCj4+DQo+PiBSZWdhcmRzLA0KPj4gQ2hyaXN0aWFuLg0KPj4NCj4+IFRoYW5r
cyBDaHJpc3RpYW4gZm9yIGNsYXJpZnlpbmcgYWJvdXQgc3dhcHBlZCBtZW1vcnkuIEhvdyBhYm91
dCB0b3RhbCANCj4+IGFsbG9jYXRlZCBzaXplPyBDYW4ndCB3ZSBwcmludCBtYXBwZWQgQk9zIHNp
bmNlIGFtZGdwdV9nZW1faW5mbyBpcyANCj4+IEZJTEUvZ2VtIGhhbmRsZSBiYXNlZD8NCj4NCj4g
VGhhdCdzIHdoYXQgeW91IGFyZSBhbHJlYWR5IHByaW50aW5nLiBFLmcuIGlmIHlvdSBzdW0gdXAg
YWxsIHRoZSBCT3MgDQo+IGluIGFsbCB0aGUgZGlmZmVyZW50IHN0YXRlcyB0aGVuIHlvdSBoYXZl
IHRoZSB0b3RhbCBhbW91bnQgb2YgDQo+IGFsbG9jYXRlZCBtZW1vcnkgZm9yIHRoaXMgcHJvY2Vz
cy4NCj4NCj4gRXZlbiBpZiBzb21lIG9mIHRoYXQgbWVtb3J5IGlzbid0IG1hcHBlZCBpbnRvIHRo
ZSBWTS4NCg0KVGhpbmtpbmcgYSBiaXQgbW9yZSBhYm91dCBpdCwgd2hlbiB5b3UgYWxzbyBsb29r
IGF0IA0KYm8tPnByZWZlcnJlZF9kb21haW5zIGFuZCBjb21wYXJlIHRoYXQgd2l0aCB0aGUgY3Vy
cmVudCBkb21haW4geW91IGNhbg0KYWxzbyBmaWd1cmUgb3V0IGlmIGEgQk8gaXMgc3dhcHBlZCBv
dXQgb3Igbm90Lg0KDQpDaHJpc3RpYW4uDQoNClRoYW5rcyBDaHJpc3RpYW4gZm9yIHF1aWNrIHJl
dmlldy9oZWxwIGFuZCBkZXRhaWxzLiBTdW1tYXJpemluZyB5b3VyIGlucHV0cyAgYW5kIHNvbWUg
cXVlcmllczoNCjEuIEFkZGluZyBCTyBmcm9tIGFsbCB0aGUgbGlzdHMgd2lsbCBnaXZlIHRoZSB0
b3RhbCBhbW91bnQgb2YgbWVtb3J5IGFsbG9jYXRlZCBieSB0aGlzIFBJRA0KMi4gIFdlIGNhbiBh
bHNvIHByaW50IGJvLT5wcmVmZXJyZWQgZG9tYWluIHRvIGNoZWNrIHdoYXQgdXNlciBhc2tlZCBm
b3IgYW5kIHdoZXJlIGl0IGlzIGN1cnJlbnRseS4gDQpCdXQgd2UgY2FuIGhhdmUgYSBzaXR1YXRp
b24gd2hlcmUgdXNlciBhc2tlZCBmb3IgVlJBTSBidXQgYWxsb3dlZCBkb21haW4gYWRkZWQgR1RU
IGFuZCB3ZSBldmVudHVhbGx5DQpBbGxvY2F0ZWQgQk8gaW4gR1RULiBTbyBkbyB3ZSB1cGRhdGUg
Ym8tPnByZWZlcnJlZF9kb21haW4gaW4gdGhhdCBzY2VuYXJpbz8/DQozLiBXaGF0IHdpbGwgYmUg
dGhlIHNjZW5hcmlvIGluIHdoaWNoIHdlIGFkZCBCTyB0byB0aGUgUmVsb2FjdGVkL01vdmVkL0lk
bGU/PyBIb3cgaXQgaXMgZGlmZmVyZW50IGZyb20gRXZpY3RlZD8/DQoNClJlZ2FyZHMsDQpNYWRo
YXYNCg0KPg0KPiBDaHJpc3RpYW4uDQo+DQo+PiBSZWdhcmRzLA0KPj4gTWloaXINCj4+PiBUaGFu
a3MsDQo+Pj4gTWloaXINCj4NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
