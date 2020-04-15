Return-Path: <SRS0=+yFv=57=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3B9C2BA2B
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 04:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 300132084D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2020 04:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EVS/ZJgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300132084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B616E834;
	Wed, 15 Apr 2020 04:23:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB8FA6E834
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2020 04:23:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxMPlZMRGewSBHFP2solrp64/l7T1feZDJwY7Hc/SUZ5PR6hckxKy7/bI5/7E+w+Tde6pc2K6SWoS37qaCzdJ+FjESL3sHrp28Y1XXLoQLyfUXKoDVCbd6Esh3T99DzEQLNB1ydq5YjOhxmecsaGGUcLBHRlYofeOECY0TjUJ4UFhYor7hWo13ky9w4CELvcSPmXix3Vp9Dw7B8jHKzpOPXksKIfW0/dAb1qFUYDR7bEGrT4GtRg4pZTNWK/igvY3Z2JiKkXyKGEWFG4Twe3CasA/wDdHSNu2OkL9iOkxmAUOjEB1Is7f4pvtyZ6FAAndzYygNpmr9PfZYWl3yjErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6daKAAcfuJXDvQO+MbAqZpK8PT7kRpaZ8pg8ndNqMU=;
 b=D8khKtFibtPYHw/uBlxYsSDd9YVXq/+Z81Mbl3UEbA0o/XjGcumAcZhvvzElHYQ4qMBn1mjypkegT+W+rRb7YK4SQfBe6RL7MRKcBl3sT2T0BTeYtdra1BEAg/W46mIVick4SIX7Q7beZsM1ItA42iZu8BbcdfeagYvKQPSSx5aoFCQr3AMFOO8ICCKJ4/LpGiBrFR0IoIxA4vfshn+4zbl0GsPUbn0FkYVuK5jeF8YSgv5OdDsa2fr/dABOestvzv5XaRDPSYUxJ3KRXd2nQMUwdqfzKBKTlCCs1GBRMTFLHz8gGqGjTgiSAGMsaeZnTdJRLHMUb5FTWicl5Rkhlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6daKAAcfuJXDvQO+MbAqZpK8PT7kRpaZ8pg8ndNqMU=;
 b=EVS/ZJgwdXKSXXSCw1exP+m+2/jT7oNRz0klHX8njx+380Xdsv8B6WP6p2dQZtpon4JUDKUdkAwtGYONbUMUyG2Gr7sfeylYqekaI49uL1EsyZMBBCMsZItcnl2j315GjH+oXEyB61NqnxfrEnTZN4rjTrRV7GeLoAtmYDBByaY=
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB3005.namprd12.prod.outlook.com (2603:10b6:208:c5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Wed, 15 Apr
 2020 04:23:15 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::ddd6:ac9e:b531:f3f8]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::ddd6:ac9e:b531:f3f8%3]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 04:23:15 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Zhu, Changfeng" <Changfeng.Zhu@amd.com>, "Zhu, James"
 <James.Zhu@amd.com>, Alex Deucher <alexdeucher@gmail.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vcn: fix gfxoff issue
Thread-Topic: [PATCH] drm/amdgpu/vcn: fix gfxoff issue
Thread-Index: AQHWElUqtqXa7qn2u0CZyR8wuED6f6h4q6YAgAAISgCAAAIWAIAAu7SAgAAjiMA=
Date: Wed, 15 Apr 2020 04:23:15 +0000
Message-ID: <MN2PR12MB3309694AC06295F0B4EDF8D2ECDB0@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <1586865913-11415-1-git-send-email-James.Zhu@amd.com>
 <CADnq5_M6g8tsrNdAmuZLGZsJ9PktZFXoSRV24RYBuxKSEQ=Jdg@mail.gmail.com>
 <bbc0099a-55ea-02ca-f1c2-40dabe1354a0@amd.com>
 <bcdda259-143f-f677-cb02-cef51dc4b530@amd.com>
 <MN2PR12MB28968609F3BC15F64232D3CAFDDB0@MN2PR12MB2896.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB28968609F3BC15F64232D3CAFDDB0@MN2PR12MB2896.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-15T02:11:35Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=39c7a867-0d14-422e-9b6b-000073985680;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-15T04:23:11Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 757bdb0b-7801-4a9c-9388-0000a62563b0
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e7d1429a-6acf-4238-5c43-08d7e0f4b7c5
x-ms-traffictypediagnostic: MN2PR12MB3005:|MN2PR12MB3005:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3005F45B0557BE69EE49734FECDB0@MN2PR12MB3005.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3309.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(9686003)(52536014)(66476007)(5660300002)(26005)(8936002)(316002)(966005)(8676002)(81156014)(6506007)(45080400002)(186003)(110136005)(6636002)(66946007)(64756008)(66446008)(71200400001)(33656002)(55016002)(53546011)(66556008)(2906002)(478600001)(86362001)(76116006)(7696005)(4326008)(83080400001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1j7YSApCV7UJUhW3aoar7PRDgUaNr5vojOA5n1tXQ3PYOozxQuzgDdc2eHB0uTlY0U103MudqBIZxQzEAlNBNtKLV+mEji6BUC8D4V5+MeQ7yAAajypF4W5/YW2izdULxer3ezlz5BfEdK2U1QJyQOgIr98L3WgdL1CfLq2KO2/s9Lzu7nO5SJ3FgfkeDKhm7cX5rirkTXHJxH43rly1A0gFnIuVBiuLg2R9Ei7FAQHxjyjRv834Dyqw52ebJtChwv3SrAjwWDn+CPmiyCdXHKfYXOEWEFON30Q2IIsQxSD+ar8EU1ws0vX2MWfGsFHYRcAFU2dLXBHJQocHCfGYBYP7iBK9swsR4+f19tVvWdZ+2Dl5Z1ssIfayEiaKbQ57MK//8oKBGDaAGVUbnEfdSwmnzAbXZZSwv0DVcWHLudplCaxxytIAkMH8I/iLeuEVhIMBpNy1RB+wZ5C+6bF6/n3BB9nMzIoDbzEvhS8UZDBx5ZspR67rIUaikA8Dt7Z+ACTzLyMKBTYMRDLJ8dep0g==
x-ms-exchange-antispam-messagedata: KfEBMoG+S/VpIS6jtpYD5Ni8HsfZJmgYSgAgXTUqF6tgmZkCH9WYXc03FC5Toe43YCIZX4DuQIBfihvPgl7Qdz7gcX/jjClDUzaqT5cMLoUaYnFkSCuo/ah9k9UPBuuAQ8XR1hUosTjKVdig73+1AA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d1429a-6acf-4238-5c43-08d7e0f4b7c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 04:23:15.4432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aObYiTsrRGKY4lRS3ZFEzCFleeAuGijr3Wa2so9NormPX/LOWmrzporBHyXBr21ClZ/W3Sk8mfqF5bQmH1qxtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3005
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpU
aGlzIHdvcmthcm91bmQgaXMgdG8gZml4IHRoZSBzMyBpc3N1ZSB3aXRoIHZpZGVvIHBsYXliYWNr
IG9uIHJhdmVuMSBiZWZvcmUuDQoNCkNoYW5nZmVuZywgY2FuIHlvdSBoYXZlIGEgcXVpY2sgdGVz
dCB3aGV0aGVyIHdlIGRvbid0IG5lZWQgaXQgcmlnaHQgbm93Pw0KDQpUaGFua3MsDQpSYXkNCiAN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFpodSwgQ2hhbmdmZW5nIDxDaGFu
Z2ZlbmcuWmh1QGFtZC5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBBcHJpbCAxNSwgMjAyMCAxMDox
MiBBTQ0KVG86IFpodSwgSmFtZXMgPEphbWVzLlpodUBhbWQuY29tPjsgQWxleCBEZXVjaGVyIDxh
bGV4ZGV1Y2hlckBnbWFpbC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQu
Y29tPjsgSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+DQpDYzogYW1kLWdmeCBsaXN0IDxh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NClN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9h
bWRncHUvdmNuOiBmaXggZ2Z4b2ZmIGlzc3VlDQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJ
bnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCg0KK1JheQ0KDQpCUiwNCkNoYW5nZmVuZy4NCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFpodSwgSmFtZXMgPEphbWVzLlpodUBh
bWQuY29tPg0KU2VudDogVHVlc2RheSwgQXByaWwgMTQsIDIwMjAgMTE6MDAgUE0NClRvOiBBbGV4
IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT47IFpodSwgSmFtZXMgPEphbWVzLlpodUBh
bWQuY29tPjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCkNjOiBhbWQt
Z2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgWmh1LCBDaGFuZ2Zlbmcg
PENoYW5nZmVuZy5aaHVAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHUv
dmNuOiBmaXggZ2Z4b2ZmIGlzc3VlDQoNCitIYXdraW5nDQoNCkhpIEhhd2tpbmcsDQoNCmNhbiB3
ZSBkcm9wIHRoaXMgV0E/DQoNClRoYW5rcyENCg0KSmFtZXMNCg0KT24gMjAyMC0wNC0xNCAxMDo1
MiBhLm0uLCBKYW1lcyBaaHUgd3JvdGU6DQo+ICtSZXgNCj4NCj4gVGhpcyBpcyBpbnRyb2R1Y2Ug
YnkgYmVsb3cgcGF0Y2guDQo+DQo+IGNvbW1pdCAzZmRlZDIyMmY0YmY3ZjRjNTZlZjQ4NTQ4NzJh
MzlhNGRlMDhmN2E4DQo+IEF1dGhvcjogUmV4IFpodSA8UmV4LlpodUBhbWQuY29tPg0KPiBEYXRl
OsKgwqAgRnJpIEp1bCAyNyAxNzowMDowMiAyMDE4ICswODAwDQo+DQo+IMKgwqDCoCBkcm0vYW1k
Z3B1OiBEaXNhYmxlIGdmeCBvZmYgaWYgVkNOIGlzIGJ1c3kNCj4NCj4gwqDCoMKgIHRoaXMgcGF0
Y2ggaXMgYSB3b3JrYXJvdW5kIGZvciB0aGUgZ3B1IGhhbmcNCj4gwqDCoMKgIGF0IHZpZGVvIGJl
Z2luL2VuZCB0aW1lIGlmIGdmeCBvZmYgaXMgZW5hYmxlZC4NCj4NCj4gwqDCoMKgIFJldmlld2Vk
LWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQo+IMKgwqDCoCBTaWdu
ZWQtb2ZmLWJ5OiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+DQo+IMKgwqDCoCBTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQo+DQo+DQo+IE9u
IDIwMjAtMDQtMTQgMTA6MjIgYS5tLiwgQWxleCBEZXVjaGVyIHdyb3RlOg0KPj4gT24gVHVlLCBB
cHIgMTQsIDIwMjAgYXQgODowNSBBTSBKYW1lcyBaaHUgPEphbWVzLlpodUBhbWQuY29tPiB3cm90
ZToNCj4+PiBUdXJuIG9mZiBnZnhvZmYgY29udHJvbCB3aGVuIHZjbiBpcyBnYXRlZC4NCj4+Pg0K
Pj4+IFNpZ25lZC1vZmYtYnk6IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+DQo+Pj4gLS0t
DQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jIHwgOCArKysr
Ky0tLQ0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Zjbi5jDQo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMN
Cj4+PiBpbmRleCBkYWIzNGY2Li5hYTlhN2E1IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0KPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92Y24uYw0KPj4+IEBAIC0zNjksOSArMzY5LDExIEBAIHZvaWQgYW1k
Z3B1X3Zjbl9yaW5nX2JlZ2luX3VzZShzdHJ1Y3QgDQo+Pj4gYW1kZ3B1X3JpbmcgKnJpbmcpIGNh
bmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+dmNuLmlkbGVfd29yayk7DQo+Pj4NCj4+PiDC
oMKgwqDCoMKgwqDCoMKgIG11dGV4X2xvY2soJmFkZXYtPnZjbi52Y25fcGdfbG9jayk7DQo+Pj4g
LcKgwqDCoMKgwqDCoCBhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIGZhbHNlKTsNCj4+PiAtwqDC
oMKgwqDCoMKgIGFtZGdwdV9kZXZpY2VfaXBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlKGFkZXYsDQo+
Pj4gQU1EX0lQX0JMT0NLX1RZUEVfVkNOLA0KPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBBTURfUEdfU1RBVEVfVU5HQVRFKTsNCj4+PiArwqDCoMKgwqDCoMKgIGlmIChhZGV2LT52Y24u
Y3VyX3N0YXRlID09IEFNRF9QR19TVEFURV9HQVRFKSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBmYWxzZSk7DQo+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2RldmljZV9pcF9zZXRfcG93ZXJnYXRpbmdf
c3RhdGUoYWRldiwNCj4+PiBBTURfSVBfQkxPQ0tfVFlQRV9WQ04sDQo+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBTURfUEdfU1RBVEVfVU5HQVRFKTsNCj4+
PiArwqDCoMKgwqDCoMKgIH0NCj4+Pg0KPj4gV2h5IGFyZSB3ZSB0b3VjaGluZyBnZnhvZmYgd2l0
aCBWQ04/wqAgV2FzIHRoaXMgYSBsZWZ0b3ZlciBmcm9tIGJyaW5nIA0KPj4gdXA/wqAgQ2FuIHdl
IGp1c3QgZHJvcCBhbGwgb2YgdGhpcyBnZnhvZmYgc3R1ZmYgZnJvbSBWQ04gaGFuZGxpbmc/wqAg
SSANCj4+IGRvbid0IHNlZSB3aHkgdGhlcmUgd291bGQgYmUgYSBkZXBlbmRlbmN5Lg0KPj4NCj4+
IEFsZXgNCj4+DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoYWRldi0+cGdfZmxhZ3MgJiBBTURf
UEdfU1VQUE9SVF9WQ05fRFBHKcKgwqDCoCB7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc3RydWN0IGRwZ19wYXVzZV9zdGF0ZSBuZXdfc3RhdGU7DQo+Pj4gLS0NCj4+PiAy
LjcuNA0KPj4+DQo+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18NCj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdA0KPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+Pj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGkNCj4+PiBzdHMuZnJlZWRlc2t0b3Aub3JnJTJGbWFp
bG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0wMiU3QzAxJQ0KPj4+IDdDSmFtZXMu
Wmh1JTQwYW1kLmNvbSU3QzNkZDkxMzVjNzE3YTRiMzAxMWUzMDhkN2UwN2Y1MmI2JTdDM2RkODk2
MWZlDQo+Pj4gNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzIyNDcwOTc2MzM5
MTg0NSZhbXA7c2RhdGE9WSUyQnQNCj4+PiBzSlFOQjFUWENROXY4NkRXJTJGMEZDNjNnT1NIc2Z6
elpGdTBNRHZDSHclM0QmYW1wO3Jlc2VydmVkPTANCj4+Pg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
