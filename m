Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5832DC3815B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 14:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CAFF20768
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 14:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xGtVcoO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAFF20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD676E142;
	Tue, 14 Apr 2020 14:19:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D356E0CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 14:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jmt69PbXXnUX4j/TGAQDBDQz2/GHuHKnASrkE2XMrGMQBNeCT++i9sEQwUhGMj1MG0R9JKtlHYMCxO6/eD+UOGbERyTy+32BSf0j9qYmbQkAyzNMI8tCv7zj5Rf/DcwAm/Bs7PHCzk80defgBnckAX/anWCKzS6iA/sDDj1JtU5cd6pNB0LW0oXL1+otzWYPaw9UffCTU/3P4H8+sCE62yuOrqmDpVWeRUXeKbRETWeaa30I7cItYYE4MzcrYz/qrafnjzZzp5f0DEh6DDeDe3pfV9XRuGk+4nJJr//8AUIMp0Sxm1g96TpkeUEDz3OOWCFNm4yOuHoiDoUVCG1ImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JhvY9sEo3VBNGRplgEZFLNjP99/5Hx7tF10IbngOEE=;
 b=EXFYuUXjhO8c1UwuHAQ9cCFsJml6KrCSieKOYSkfIF77zHBADjX99wFotztURrLBolr3LlXMD2S3dpEXepACYsgpelvC0xHizqUT/XoPNdoAmFsVWev6oyXDjN8xPK1pN1wmxBAIlko2k4oZzYVxeCRKYFJlsCzT6t1u0bR1DmPLXhaushBCpag/fwkAHalbJpw7VlXd+pNqkT9W3UH7D6jDRnx2jeLUNP5IBS902fEnRvohCKuTnHT7qoSpQZiTf4n/S3xn/Z54LEOkhlhh36eMVmh3PmWwcTCjYuSpcCMSvqTvdVIYo4i0DnpcNSL6TOUYBQ60W6aT0bdLgOeZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JhvY9sEo3VBNGRplgEZFLNjP99/5Hx7tF10IbngOEE=;
 b=xGtVcoO68+kD7ibNsq/MoJEiqOSe+obFmXYIlPYaD74DFCp9cgoBJ5OGzLhfikY7QLiz8jgCSGUboji1+d+LC0lWO0PIuQnStuE7LYH5f8zjdXaqQu6Y1bTVIQgW+AX+KqKdi+bdfQdHUT4nfRz5S85WnhGTWuEj9X9aV6aS4EU=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3753.namprd12.prod.outlook.com (2603:10b6:5:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 14:19:14 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 14:19:14 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2"
Thread-Topic: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2"
Thread-Index: AQHWEcA5+D7UIeTa4E6FAfQP6w9qZah4pBqAgAAHWCA=
Date: Tue, 14 Apr 2020 14:19:14 +0000
Message-ID: <DM6PR12MB3721FDB775B65C22B91D564585DA0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200413182026.2561-1-kent.russell@amd.com>
 <85fcb568-b0d8-b6c9-4e62-3866aa2da0c9@gmail.com>
In-Reply-To: <85fcb568-b0d8-b6c9-4e62-3866aa2da0c9@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-14T14:19:12Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=696340d6-c0b4-41ba-abb8-00004155caf7;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-14T14:19:12Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 774a273c-afb9-4f31-b341-00009022f7c1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
x-originating-ip: [99.250.168.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c561ad1-4f66-41ed-4411-08d7e07ecf5a
x-ms-traffictypediagnostic: DM6PR12MB3753:|DM6PR12MB3753:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB375396EDED199F921F3473BA85DA0@DM6PR12MB3753.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(5660300002)(66946007)(66476007)(64756008)(66556008)(8936002)(2906002)(6506007)(478600001)(53546011)(7696005)(52536014)(26005)(316002)(110136005)(54906003)(81156014)(66574012)(76116006)(71200400001)(33656002)(66446008)(8676002)(9686003)(186003)(55016002)(4326008)(86362001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LcLT1cqSPA66rlqRbFwBjaJZrPWzof36YoMb/78tzEZ9/p6PMsHU2BMtyd8Yrk3yb9yNv8QB7zdcHCegxu21sQDPThEN9ptuP5YXwXZOT6VQH8PMXamiq9A61dCLyvANumZyojbC3JWwQfiaddoLdMsAvoF94JdG+B0Xgzva+q8oDVhKyrVOpTxSTwroCT0vQdSyPz4ftF/cIyjtAmqmgB3YCIDeb0UnJ5zOvq7yz1pQIjgbOnbTNCZNBGLHa97SNPHiFWLMuGSs6ZHRJDv1aak8WKyCrI2hW1nnZzE4CsE4bhBJ7vsZugD2MINyie4i2sPulMjBkN4+1R6DPVmTCFDQ6msOpz3XSRlBLulVlryvwpgTiCwraq5Qop7Ykzmsu7gR1D9ldbBWGeuUt3b4DTo+XXdL/erhynCM8LAazlTbaYvrcBTTGAX044NyTJCx
x-ms-exchange-antispam-messagedata: CKqa4i+LWer5V6XSgSaQY2lF+kOrKSEIp88V6zhVVoRHleJ7p2nR82i+tg7hEZCGRENNRNXSaOuVFSWMMInxlc/l5jW978Nx8ewR4a7iyyikCrgs+4b1tqihxJFEPGKZS3HrpYlxL7D3Q68xH2tNMA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c561ad1-4f66-41ed-4411-08d7e07ecf5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 14:19:14.3426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2WSk6UCUEpLCyda2H8mghH4mWZItzF/YJwJo911XLK/3kUAuzjax8kVHhfDv9lMwJKp/a6MhEOqQGS3A4ev9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3753
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpP
biBWRzIwIG9yIE1JMTAwLCBhcyBzb29uIGFzIHdlIHJ1biB0aGUgc3VidGVzdCwgd2UgZ2V0IHRo
ZSBkbWVzZyBvdXRwdXQgYmVsb3csIGFuZCB0aGVuIHRoZSBrZXJuZWwgZW5kcyB1cCBoYW5naW5n
LiBJIGRvbid0IGtub3cgZW5vdWdoIGFib3V0IHRoZSB0ZXN0IGl0c2VsZiB0byBrbm93IHdoeSB0
aGlzIGlzIG9jY3VycmluZywgYnV0IEpvbiBLaW0gYW5kIEZlbGl4IHdlcmUgZGlzY3Vzc2luZyBp
dCBvbiBhIHNlcGFyYXRlIHRocmVhZCB3aGVuIHRoZSBpc3N1ZSB3YXMgZmlyc3QgcmVwb3J0ZWQs
IHNvIHRoZXkgY2FuIGhvcGVmdWxseSBwcm92aWRlIHNvbWUgYWRkaXRpb25hbCBpbmZvcm1hdGlv
bi4NCg0KIEtlbnQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJp
c3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCj4gU2VudDog
VHVlc2RheSwgQXByaWwgMTQsIDIwMjAgOTo1MiBBTQ0KPiBUbzogUnVzc2VsbCwgS2VudCA8S2Vu
dC5SdXNzZWxsQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSBSZXZlcnQgImRybS9hbWRncHU6IHVzZSB0aGUgQkFSIGlmIHBvc3Np
YmxlIGluDQo+IGFtZGdwdV9kZXZpY2VfdnJhbV9hY2Nlc3MgdjIiDQo+IA0KPiBBbSAxMy4wNC4y
MCB1bSAyMDoyMCBzY2hyaWViIEtlbnQgUnVzc2VsbDoNCj4gPiBUaGlzIHJldmVydHMgY29tbWl0
IGMxMmI4NGQ2ZTBkNzBmMTE4NWU2ZGFkZGZkMTJhZmI2NzE3OTFiNmUuDQo+ID4gVGhlIG9yaWdp
bmFsIHBhdGNoIGNhdXNlcyBhIFJBUyBldmVudCBhbmQgc3Vic2VxdWVudCBrZXJuZWwgaGFyZC1o
YW5nDQo+ID4gd2hlbiBydW5uaW5nIHRoZSBLRkRNZW1vcnlUZXN0LlB0cmFjZUFjY2Vzc0ludmlz
aWJsZVZyYW0gb24gVkcyMCBhbmQNCj4gPiBBcmN0dXJ1cw0KPiA+DQo+ID4gZG1lc2cgb3V0cHV0
IGF0IGhhbmcgdGltZToNCj4gPiBbZHJtXSBSQVMgZXZlbnQgb2YgdHlwZSBFUlJFVkVOVF9BVEhV
Ql9JTlRFUlJVUFQgZGV0ZWN0ZWQhDQo+ID4gYW1kZ3B1IDAwMDA6Njc6MDAuMDogR1BVIHJlc2V0
IGJlZ2luIQ0KPiA+IEV2aWN0aW5nIFBBU0lEIDB4ODAwMCBxdWV1ZXMNCj4gPiBTdGFydGVkIGV2
aWN0aW5nIHBhc2lkIDB4ODAwMA0KPiA+IHFjbSBmZW5jZSB3YWl0IGxvb3AgdGltZW91dCBleHBp
cmVkDQo+ID4gVGhlIGNwIG1pZ2h0IGJlIGluIGFuIHVucmVjb3ZlcmFibGUgc3RhdGUgZHVlIHRv
IGFuIHVuc3VjY2Vzc2Z1bA0KPiA+IHF1ZXVlcyBwcmVlbXB0aW9uIEZhaWxlZCB0byBldmljdCBw
cm9jZXNzIHF1ZXVlcyBGYWlsZWQgdG8gc3VzcGVuZA0KPiA+IHByb2Nlc3MgMHg4MDAwIEZpbmlz
aGVkIGV2aWN0aW5nIHBhc2lkIDB4ODAwMCBTdGFydGVkIHJlc3RvcmluZyBwYXNpZA0KPiA+IDB4
ODAwMCBGaW5pc2hlZCByZXN0b3JpbmcgcGFzaWQgMHg4MDAwIFtkcm1dIFVWRCBWQ1BVIHN0YXRl
IG1heSBsb3N0DQo+ID4gZHVlIHRvIFJBUyBFUlJFVkVOVF9BVEhVQl9JTlRFUlJVUFQNCj4gPiBh
bWRncHU6IFtwb3dlcnBsYXldIEZhaWxlZCB0byBzZW5kIG1lc3NhZ2UgMHgyNiwgcmVzcG9uc2Ug
MHgwDQo+ID4gYW1kZ3B1OiBbcG93ZXJwbGF5XSBGYWlsZWQgdG8gc2V0IHNvZnQgbWluIGdmeGNs
ayAhDQo+ID4gYW1kZ3B1OiBbcG93ZXJwbGF5XSBGYWlsZWQgdG8gdXBsb2FkIERQTSBCb290dXAg
TGV2ZWxzIQ0KPiA+IGFtZGdwdTogW3Bvd2VycGxheV0gRmFpbGVkIHRvIHNlbmQgbWVzc2FnZSAw
eDcsIHJlc3BvbnNlIDB4MA0KPiA+IGFtZGdwdTogW3Bvd2VycGxheV0gW0Rpc2FibGVBbGxTTVVG
ZWF0dXJlc10gRmFpbGVkIHRvIGRpc2FibGUgYWxsIHNtdQ0KPiBmZWF0dXJlcyENCj4gPiBhbWRn
cHU6IFtwb3dlcnBsYXldIFtEaXNhYmxlRHBtVGFza3NdIEZhaWxlZCB0byBkaXNhYmxlIGFsbCBz
bXUgZmVhdHVyZXMhDQo+ID4gYW1kZ3B1OiBbcG93ZXJwbGF5XSBbUG93ZXJPZmZBc2ljXSBGYWls
ZWQgdG8gZGlzYWJsZSBEUE0hDQo+ID4gW2RybTphbWRncHVfZGV2aWNlX2lwX3N1c3BlbmRfcGhh
c2UyIFthbWRncHVdXSAqRVJST1IqIHN1c3BlbmQgb2YgSVANCj4gPiBibG9jayA8cG93ZXJwbGF5
PiBmYWlsZWQgLTUNCj4gDQo+IERvIHlvdSBoYXZlIG1vcmUgaW5mb3JtYXRpb24gb24gd2hhdCdz
IGdvaW5nIHdyb25nIGhlcmUgc2luY2UgdGhpcyBpcyBhIHJlYWxseQ0KPiBpbXBvcnRhbnQgcGF0
Y2ggZm9yIEtGRCBkZWJ1Z2dpbmcuDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS2VudCBS
dXNzZWxsIDxrZW50LnJ1c3NlbGxAYW1kLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+IA0KPiA+IC0tLQ0KPiA+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMjYgLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDI2IGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+
ID4gaW5kZXggY2Y1ZDZlNTg1NjM0Li5hM2Y5OTdmODQwMjAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gQEAgLTI1NCwzMiArMjU0
LDYgQEAgdm9pZCBhbWRncHVfZGV2aWNlX3ZyYW1fYWNjZXNzKHN0cnVjdA0KPiBhbWRncHVfZGV2
aWNlICphZGV2LCBsb2ZmX3QgcG9zLA0KPiA+ICAgCXVpbnQzMl90IGhpID0gfjA7DQo+ID4gICAJ
dWludDY0X3QgbGFzdDsNCj4gPg0KPiA+IC0NCj4gPiAtI2lmZGVmIENPTkZJR182NEJJVA0KPiA+
IC0JbGFzdCA9IG1pbihwb3MgKyBzaXplLCBhZGV2LT5nbWMudmlzaWJsZV92cmFtX3NpemUpOw0K
PiA+IC0JaWYgKGxhc3QgPiBwb3MpIHsNCj4gPiAtCQl2b2lkIF9faW9tZW0gKmFkZHIgPSBhZGV2
LT5tbWFuLmFwZXJfYmFzZV9rYWRkciArIHBvczsNCj4gPiAtCQlzaXplX3QgY291bnQgPSBsYXN0
IC0gcG9zOw0KPiA+IC0NCj4gPiAtCQlpZiAod3JpdGUpIHsNCj4gPiAtCQkJbWVtY3B5X3RvaW8o
YWRkciwgYnVmLCBjb3VudCk7DQo+ID4gLQkJCW1iKCk7DQo+ID4gLQkJCWFtZGdwdV9hc2ljX2Zs
dXNoX2hkcChhZGV2LCBOVUxMKTsNCj4gPiAtCQl9IGVsc2Ugew0KPiA+IC0JCQlhbWRncHVfYXNp
Y19pbnZhbGlkYXRlX2hkcChhZGV2LCBOVUxMKTsNCj4gPiAtCQkJbWIoKTsNCj4gPiAtCQkJbWVt
Y3B5X2Zyb21pbyhidWYsIGFkZHIsIGNvdW50KTsNCj4gPiAtCQl9DQo+ID4gLQ0KPiA+IC0JCWlm
IChjb3VudCA9PSBzaXplKQ0KPiA+IC0JCQlyZXR1cm47DQo+ID4gLQ0KPiA+IC0JCXBvcyArPSBj
b3VudDsNCj4gPiAtCQlidWYgKz0gY291bnQgLyA0Ow0KPiA+IC0JCXNpemUgLT0gY291bnQ7DQo+
ID4gLQl9DQo+ID4gLSNlbmRpZg0KPiA+IC0NCj4gPiAgIAlzcGluX2xvY2tfaXJxc2F2ZSgmYWRl
di0+bW1pb19pZHhfbG9jaywgZmxhZ3MpOw0KPiA+ICAgCWZvciAobGFzdCA9IHBvcyArIHNpemU7
IHBvcyA8IGxhc3Q7IHBvcyArPSA0KSB7DQo+ID4gICAJCXVpbnQzMl90IHRtcCA9IHBvcyA+PiAz
MTsNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
