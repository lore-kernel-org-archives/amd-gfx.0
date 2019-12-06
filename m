Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144FCC43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 08:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C283A2466E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 08:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C283A2466E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ACB96EABB;
	Fri,  6 Dec 2019 08:14:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05AC76EABB
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 08:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcvuprQF40qMuORwnt9ktepTNYVEEEa5kt3ONJc2UPDC+dAsDkM5Ktf09TZhVWd8eqbUNzLwF0ZCzWUnF2UBMO0ER2bHBnsjlTPDZyYFkzLeffPH+MiWsmZtTge2SEjjeP9M0MoD2mEL3w7iEOnRMgCAo7285zQlyztXiv/fFgLE6VAoco2eIag+mYiBYtUWcwqR8p/cqwwKd9E42NnxCXw4Y88ZSRcO2iqUS0TUkrNjCTiZ8qm3l3I94Fpzp0aQG5Ua57HP6li7r7pbP3kdnXbKriksQUq0ImsiGKDe+EIYkaSyckQEAC9W69myrxUyaetCCxff9S5WQKx0WFWTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzEed+w8d0Upoer0HLH/9hZaRMFwdcQVNA2w3ZV/qXs=;
 b=b8Mi1mVV3cqFBHU8JuFdGOUfnTRkIjviMd9aksFYTnS5E/i3eotNwCv8k0ZPTXjAPqn2xxRDxheZQOwxF3mAzQLFmbpLPmiB6Pd033Y1J8T3mQUnO6e6iqnHKburunUueDFtFu2BGwxlVujN8W8wzzME5vjoXdSNe1J1tYEYHFZGvpA8ulOE7PnXWWP01A8+E6kLXD2//AtgEhzd6sMVjNE5FQztLFgF3tyYHe/L3XHnwtWwzJ4VPC6FU4bGn6/v95BVQrpiQ1FgXO87/mAlS8DP2m5I8+tmVVBc7S7+s/SuIBJySOe5FLS9b1z5Osi0OAht3x0LCrjxONVYOD9H9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1424.namprd12.prod.outlook.com (10.169.206.135) by
 MWHPR12MB1760.namprd12.prod.outlook.com (10.175.55.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Fri, 6 Dec 2019 08:13:57 +0000
Received: from MWHPR12MB1424.namprd12.prod.outlook.com
 ([fe80::e931:14f6:ce41:812f]) by MWHPR12MB1424.namprd12.prod.outlook.com
 ([fe80::e931:14f6:ce41:812f%8]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 08:13:56 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Quan, Evan"
 <Evan.Quan@amd.com>, "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: clear VBIOS scratchs on baco exit
Thread-Topic: [PATCH] drm/amd/powerplay: clear VBIOS scratchs on baco exit
Thread-Index: AQHVq+ZVAtbmf8jej0a7L9A8c6Be7aesgQcAgAASzgCAACtuoIAAAlOg
Date: Fri, 6 Dec 2019 08:13:56 +0000
Message-ID: <MWHPR12MB1424D71574C6994EB8D64ADFFC5F0@MWHPR12MB1424.namprd12.prod.outlook.com>
References: <20191206033543.3131-1-evan.quan@amd.com>
 <BB0A14B8-3288-4EE0-8352-162F81477E1A@amd.com>
 <MN2PR12MB334455F883AD2A8F4DD09AD7E45F0@MN2PR12MB3344.namprd12.prod.outlook.com>
 <MWHPR12MB142482E36A82A54C0BD53F6DFC5F0@MWHPR12MB1424.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR12MB142482E36A82A54C0BD53F6DFC5F0@MWHPR12MB1424.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=74d7fe04-4d38-4c0d-98d9-0000961feb3b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-06T05:16:53Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e17f32e-92db-4a86-ba28-08d77a243dc3
x-ms-traffictypediagnostic: MWHPR12MB1760:|MWHPR12MB1760:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB17600DC8169C49EC021F272CFC5F0@MWHPR12MB1760.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(13464003)(199004)(189003)(43544003)(6506007)(2940100002)(6636002)(229853002)(2906002)(305945005)(478600001)(74316002)(45080400002)(9686003)(53546011)(55016002)(81156014)(33656002)(11346002)(25786009)(81166006)(8936002)(8676002)(64756008)(110136005)(76176011)(966005)(66476007)(316002)(4326008)(186003)(52536014)(66446008)(66946007)(7696005)(26005)(5660300002)(102836004)(66556008)(71190400001)(14444005)(99286004)(86362001)(71200400001)(76116006)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1760;
 H:MWHPR12MB1424.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DAJ+ADDLi6GWGm9u2OERs18/QkqRPsdl5PQxatOvltdGpkCF1385OUaCDvw78SSktYypqlVh7i8m1tU6NlzqgjS8xOimk1KUth85RjLo5hgJnTgyzvHdCYUW4Tn0jh+nVH16E+mhB45Z9v0EXsEut/051ux7uiU2q8zP0jOKCj3IcJ1jJ8afLDSgxzTrQPrX18mzQZEO3jyEDo83dPvstti8DjlnTRfu5HQOEmaWO08jSyd5i8zEHqbyJtCt7I9hH0SE8SyrHRhWn58enC6s8URGlceVMiKcfauqGdWhhwDX/iW2kyrUTHET55xr2Uli7/lsxhfnfVa+JdV04ejF60AtLY008Pz9jsC9AtALHrklZO1ORga/jonAIrj76VejkZUiuF18XC3qyAYLuUoUr2Ti3E0Q0mp9GSzTs7oA+m0eDRITTPjOqkB42uah+2H9hy+HXW3+5xxCx6TXRI8flKgpCpCn6qnfI+LqCjOZvQYC3tGaBEvPk9ZcYP4/36nVomGP7EtX6OFSTZ7/3TZSN7yRZEDvJNSyRnmxz4ZId0ykZP26TIiDaFCxkfa72BFE
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e17f32e-92db-4a86-ba28-08d77a243dc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 08:13:56.6824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6UtVMRzkOyIPbuN8MT6LBffn5MccNMQot9dFLLxtcKkOdEaGktAtEngQSsdao1pgCCWzPC9DX/LMiRsZuIlJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1760
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzEed+w8d0Upoer0HLH/9hZaRMFwdcQVNA2w3ZV/qXs=;
 b=pw1ivUtN6h4NimA1UYQKWtoW4HhfYP2t2AExMod3zRLADjZ2bWz4+1uK3O/hqavAri0Qz1/lrSu3Wjsx6QdQcGcg5cpdwXhMq/HuHWkiSsGxPe8SMd0+A/5EaNUXglymMTQwlXicoFiwCT7j5tI3FDJiM9GwQLM8qQQGoO86RII=
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Q29ycmVjdCBteSB0eXBvDQoNClRoaXMgaXMgaW4gaGlnaCByaXNrIHRvIGJyZWFrIGdwdSByZXN1
bWUgYW5kIHJlc2V0IGp1c3QgYmVjYXVzZSB5b3UgY2xlYXIgdGhlIEFUT01fUzdfQVNJQ19JTklU
X0NPTVBMRVRFX01BU0sgZmllbGQgaW4gc2NyYXRjaCByZWdpc3RlciA3LiBBbmQgdGhlIGF0b21f
YmlvcyBpbml0IHdpbGwgYmUgc2tpcHBlZC4NCg0KUmVnYXJkcywNCkhhd2tpbmcNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgWmhhbmcsIEhhd2tpbmcNClNlbnQ6IDIwMTnl
ubQxMuaciDbml6UgMTY6MDcNClRvOiBRdWFuLCBFdmFuIDxFdmFuLlF1YW5AYW1kLmNvbT47IFl1
YW4sIFhpYW9qaWUgPFhpYW9qaWUuWXVhbkBhbWQuY29tPjsgTHVvLCBaaGlnYW5nIDxaaGlnYW5n
Lkx1b0BhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0
OiBSRTogW1BBVENIXSBkcm0vYW1kL3Bvd2VycGxheTogY2xlYXIgVkJJT1Mgc2NyYXRjaHMgb24g
YmFjbyBleGl0DQoNClRoaXMgaXMgaW4gaGlnaCByaXNrIHRvIGJyZWFrIHNlY29uZGFyeSBncHUg
cmVzdW1lIGFuZCByZXNldCBqdXN0IGJlY2F1c2UgeW91IGNsZWFyIHRoZSBBVE9NX1M3X0FTSUNf
SU5JVF9DT01QTEVURV9NQVNLIGZpZWxkIGluIHNjcmF0Y2ggcmVnaXN0ZXIgNy4gQW5kIHRoZSBh
dG9tX2Jpb3MgaW5pdCB3aWxsIGJlIHNraXBwZWQuDQoNCldlIHNoYWxsIHVuZGVyc3RhbmQgYW55
IGxpYmd2IGZpeGVzIHZlcnkgd2VsbCBiZWZvcmUgImNvcHkiIGl0IHRvIGJhcmUtbWV0YWwuIExp
Ymd2IGRvbid0IG5lZWQgdG8gdGFrZSBjYXJlIFMzLg0KDQpSZWdhcmRzLA0KSGF3a2luZw0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0Bs
aXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBRdWFuLCBFdmFuDQpTZW50OiAyMDE5
5bm0MTLmnIg25pelIDEzOjI3DQpUbzogWXVhbiwgWGlhb2ppZSA8WGlhb2ppZS5ZdWFuQGFtZC5j
b20+OyBMdW8sIFpoaWdhbmcgPFpoaWdhbmcuTHVvQGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWQvcG93ZXJwbGF5
OiBjbGVhciBWQklPUyBzY3JhdGNocyBvbiBiYWNvIGV4aXQNCg0KSGkgWGlhb2ppZSwNCg0KVGhp
cyB3YXMgcmVwb3J0ZWQgYnkgWmhpZ2FuZyB0ZWFtLiAgVW5kZXIgdGhlaXIgc3BlY2lhbCB1c2Ug
Y2FzZSwgc2NyYXRjaCByZWdpc3RlciA3IGhhcyBiZSB0byAwIHRvIHBlcmZvcm0gYXNpYyBpbml0
KEBMdW8sIFpoaWdhbmcgcmlnaHQ/KS4NCkFuZCBjb25zaWRlcmluZyBvbGQgYXNpY3ModmVnYTIw
LzEwKSBhbHNvIGFwcGxpZWQgdGhpcyBjaGFuZ2UuDQpTbywgSSB0aGluayBpdCdzIHJlYXNvbmFi
bGUoYW5kIHJlY29tbWVuZCBieSBTTVUgZncgdGVhbSkgdG8gYXBwbHkgdGhpcyBvbiB0aGUgbmV3
IEFTSUNzIGFsc28uDQoNClJlZ2FyZHMsDQpFdmFuDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IFl1YW4sIFhpYW9qaWUgPFhpYW9qaWUuWXVhbkBhbWQuY29tPg0KPiBTZW50
OiBGcmlkYXksIERlY2VtYmVyIDYsIDIwMTkgMTI6MjAgUE0NCj4gVG86IFF1YW4sIEV2YW4gPEV2
YW4uUXVhbkBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEx1
bywgWmhpZ2FuZyA8WmhpZ2FuZy5MdW9AYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
ZHJtL2FtZC9wb3dlcnBsYXk6IGNsZWFyIFZCSU9TIHNjcmF0Y2hzIG9uIGJhY28gDQo+IGV4aXQN
Cj4gDQo+IEhpIEV2YW4sDQo+IA0KPiBKdXN0IG91dCBvZiBjdXJpb3NpdHksIG1heSBJIGtub3cg
d2hhdCBpc3N1ZSBhcmUgeW91IHRyeWluZyB0byBmaXg/DQo+IEkgdXNlZCB0byBzZWUgdmJpb3Mg
cG9zdCBmYWlsdXJlIChoYW5ncyBpbiBhdG9tYmlvcyBpbml0IHRhYmxlKSBhZnRlciANCj4gYmFj
byBleGl0IG9jY2FzaW9uYWxseSBvbiBuYXZpLg0KPiANCj4gQlIsDQo+IFhpYW9qaWUNCj4gDQo+
ID4gT24gRGVjIDYsIDIwMTksIGF0IDExOjM3IEFNLCBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgaXMgbmVlZGVkIGZvciBjb21pbmcgYXNpYyBpbml0
IG9uIHBlcmZvcm1pbmcgZ3B1IHJlc2V0Lg0KPiA+DQo+ID4gQ2hhbmdlLUlkOiBJZjM2NzFhMjRk
MjM5ZTNkMjg4NjY1ZmFkYWEyYzQwYzg3ZDVkYTQwYg0KPiA+IFNpZ25lZC1vZmYtYnk6IEV2YW4g
UXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvc211X3YxMV8wLmMgfCA2ICsrKysrKw0KPiA+IDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3Bvd2VycGxheS9zbXVfdjExXzAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5
L3NtdV92MTFfMC5jDQo+ID4gaW5kZXggMzllYzA2YWVlODA5Li5hYjgwOWRmN2JjMzUgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMNCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVfdjExXzAuYw0KPiA+IEBA
IC0xNjU5LDYgKzE2NTksMTIgQEAgaW50IHNtdV92MTFfMF9iYWNvX3NldF9zdGF0ZShzdHJ1Y3QN
Cj4gc211X2NvbnRleHQgKnNtdSwgZW51bSBzbXVfYmFjb19zdGF0ZSBzdGF0ZSkNCj4gPiAgICAg
ICAgfQ0KPiA+ICAgIH0gZWxzZSB7DQo+ID4gICAgICAgIHJldCA9IHNtdV9zZW5kX3NtY19tc2co
c211LCBTTVVfTVNHX0V4aXRCYWNvKTsNCj4gPiArICAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAg
ICAgICAgICBnb3RvIG91dDsNCj4gPiArDQo+ID4gKyAgICAgICAgV1JFRzMyX1NPQzE1KE5CSU8s
IDAsIG1tQklPU19TQ1JBVENIXzYsIDApOw0KPiA+ICsgICAgICAgIFdSRUczMl9TT0MxNShOQklP
LCAwLCBtbUJJT1NfU0NSQVRDSF83LCAwKTsNCj4gPiArDQo+ID4gICAgICAgIGJpZl9kb29yYmVs
bF9pbnRyX2NudGwgPSBSRUdfU0VUX0ZJRUxEKGJpZl9kb29yYmVsbF9pbnRyX2NudGwsDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICBCSUZfRE9PUkJFTExfSU5UX0NOVEwsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICBET09SQkVMTF9JTlRFUlJVUFRfRElTQUJMRSwgMCk7DQo+ID4gLS0N
Cj4gPiAyLjI0LjANCj4gPg0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+ID4gYW1kLWdmeCBtYWlsaW5nIGxpc3QNCj4gPiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KPiA+DQo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rp
b24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3QNCj4gcy5mcmVlDQo+IGRlc2t0
b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLQ0KPiBnZngmYW1wO2RhdGE9MDIlN0Mw
MSU3Q1hpYW9qaWUuWXVhbiU0MGFtZC5jb20lN0M2ODJjMTQyZWYzMDc0OGJiZA0KPiAwMDUwOGQ3
NzlmZDZmODIlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3
DQo+IDExMjAwMjIwODkyNzczMyZhbXA7c2RhdGE9YmFqYWFqM0N3Mkl4VzVuUnVjZzNGWFVqY3lJ
aTUwa0NTUFE3ZWtucWsNCj4gNG8lM0QmYW1wO3Jlc2VydmVkPTANCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQphbWQtZ2Z4IG1haWxpbmcgbGlzdA0KYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCmh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9wLm9y
ZyUyRm1haWxtYW4lMkZsaXN0aW5mbyUyRmFtZC1nZngmYW1wO2RhdGE9MDIlN0MwMSU3Q2hhd2tp
bmcuemhhbmclNDBhbWQuY29tJTdDYjU3Njg3YTExNDJhNDk5Y2U5YmIwOGQ3N2EyMzU3ODYlN0Mz
ZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTEyMTY0NTI3Nzkz
MjI2JmFtcDtzZGF0YT1WbmZBUURpa2FobEJOc3ZhR3diRkhXVGNZb25tbzlxNHRXVlJ1VHc5d0hr
JTNEJmFtcDtyZXNlcnZlZD0wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KYW1kLWdmeCBtYWlsaW5nIGxpc3QNCmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQpodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGlu
Zm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTAyJTdDMDElN0NoYXdraW5nLnpoYW5nJTQwYW1kLmNvbSU3
Q2I1NzY4N2ExMTQyYTQ5OWNlOWJiMDhkNzdhMjM1Nzg2JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFh
ODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzExMjE2NDUyNzc5MzIyNiZhbXA7c2RhdGE9Vm5mQVFE
aWthaGxCTnN2YUd3YkZIV1RjWW9ubW85cTR0V1ZSdVR3OXdIayUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
