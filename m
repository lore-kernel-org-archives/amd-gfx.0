Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0D9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 07:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 578D910E74F;
	Tue, 14 Dec 2021 07:46:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FD9E10E74F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 07:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjC5AcHLnTZ+hgxYMNCWLZaPYpzcDnBPqFzmnyzKSToey+/tAknggPXct64qTyb+8zM+8r8v4LP8gACLGYp5khJqurcwiiBVeV0rXHJZrtz0vqpoz5Q5MdXSbfEBNm2r2u58snt2sQ5EfTqvL/gOL7+g4R+Kzhtc1SuZpAd5LJwpquNxw0PnNeyBYhRUN6N4k9w/iedSst7LMKFooC3wKjYsgdlhLV5Hw8b1p0V8x9YSAhcCmbIcjd9O62E17q/vS3BYQxZv3xsuUNAZvWX8EowM4pVapViDxPjd7vkeEZ0fd+CCJn01xAzk3AifIDDA0QkThy0pfore3JdchgWZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYqH+sH/YnaaTv2DfscPDUaMNiOJgvgNGBMSOxS3WVQ=;
 b=E7Sp305QHA4nyBO4liZJMzONF/RxuiGibxPhOonckzBuY/9XgYXx0CJ1IfHwPpTN7ik9u9I4dOcmpGZIaLGxsl82CPMqy9aSZYyaoLXjaDGf4983b5mbI7curqsGgtkbyxGq0wGoKaDfOLOgp8bCV8N1SeLf/iOO5LIgVQpki+w3Qv4ptRX+ebYYak0uTmnAHqGXz6id61Wz/wCfl4PUV1FeHKlA1HbEgzatJxM3INn5LbRuDGROb14/lGQOqitxrO1C/EDPXIAJnI/aDDPL0Aj7fMSs1XQzqeLfGNK9H8bhJSbI+2h9kOmhmEBUGN6CCmqqbWM0spAoG/mJi096hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYqH+sH/YnaaTv2DfscPDUaMNiOJgvgNGBMSOxS3WVQ=;
 b=ZY/nnxOsHS6CEuQM3gEMDjuI3zbtwJ7m/7BDNZdEdlXqrXGzBqSmuMFGCgmhD+tG5VklYhQR56x/4I+qyBjPCP57ClMWOb/E1MOr2/No4pRsf3fuCsv7miI4QEVYy4C8gdNgCX7n1IesH+aiEIt8tRcDUYUOzGPZ2R3nb+HBu94=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4987.namprd12.prod.outlook.com (2603:10b6:5:163::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.15; Tue, 14 Dec 2021 07:46:49 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 07:46:48 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct the wrong cached state for GMC on
 PICASSO
Thread-Topic: [PATCH] drm/amdgpu: correct the wrong cached state for GMC on
 PICASSO
Thread-Index: AQHX8IrJbR0646ruvkOhu/OoGSWFYqwxgigAgAAY92A=
Date: Tue, 14 Dec 2021 07:46:48 +0000
Message-ID: <DM6PR12MB261917434000F509CAF9DE2FE4759@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211214013423.801735-1-evan.quan@amd.com>
 <c3d79f6c-b0f1-bc2b-ab80-30a8db11f140@amd.com>
In-Reply-To: <c3d79f6c-b0f1-bc2b-ab80-30a8db11f140@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-14T07:46:45Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d296f3fc-760e-4ef5-8386-60d688523b2c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5adc6ee-d896-4421-5533-08d9bed5e2a0
x-ms-traffictypediagnostic: DM6PR12MB4987:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4987383009BA1F7B03BB6420E4759@DM6PR12MB4987.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Td5aBa5CMd9lwykeHzj6MGJg1lqzaRRms5xZH5IBZyc7/dpz9n4229jQ7BxwzrA1LI2mrPssNnx2gurZR+TNnR+CmOPFOER/ydKJNKqJfajrTHO4Xe0czJJN0Pkpqz+05t6vDdA6LH5b+rogi/T1kmBKOEzp/M8Qn2eFU7cBPVtJ+OQC3yoOqC+eVIMyX4uaFPvi8wtA9vpq/T5buRP19PkF3VhyO5PzxZ5VZWhqXjebB3IE3COBo6sMbR7tdKQxEt7XaOxw/RF1XOyn+ZiSMO8ToPfdj0q1PW6YLdpchJk63q+WivvGj5tdNamPvHYind7CNKT7niGh+wAuB+4kxMfreqcmXYDfo9LwrADG5nft7k/llMNoln/iz8tDtKHwQ0DfO9YDLo0hL3jzzdgdNV1aLK6tMDtYtbr0qSQjkRilD00bfDYAY/K2P7PaX9lwyHYbef1kdWRpKR+wa4xZArC5eGykATdCdE6NMtg0o5d7QmR23gfjimaF5jaAuvtzj+nyVWNelR80fqV14mwhIXJULM9RXLfvHHFS+zWm4t3sFKGsq9KhtyPl1XKSqjO90p6TM/ib2xwi73cBGuWZYHGm7ClQqiYeyjEKRqsMnhQpeYrlLpl3plOcWolbTohb1xaaQHHZ1Ffp1rmgPlW0J3bRL6UmH3dfVNS2e9V5DSsoUJ/k2sNkyxxZtPRk4yIM6XRURO2Whi5DoIJKW86sKQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(52536014)(508600001)(9686003)(122000001)(7696005)(2906002)(54906003)(8936002)(5660300002)(4326008)(33656002)(86362001)(66556008)(55016003)(66476007)(64756008)(71200400001)(66446008)(26005)(76116006)(110136005)(316002)(966005)(66946007)(83380400001)(53546011)(6506007)(38070700005)(8676002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tkc1Mkl2aS9XWlNLOVhDSENCa2R2T0ttMk1HNTdQLzExR2x3bDIvUVZNUXJh?=
 =?utf-8?B?a0pDbkpCcjl5OWRjZ2lMNTFITytxbjZOV1JkNERraHduOXhtS3UwemZYMTB2?=
 =?utf-8?B?akMwdmJaN0dsU0JPRG5OWTQ4M2h5T0cyaXB3eXVwcUFUTTJ0blRuaUtEeGI5?=
 =?utf-8?B?RENEdkFJSFJVTmVuNE51M1ZoMVVqSHlZZUJnODFNb2FxU1pNWDFqUVk2YmlP?=
 =?utf-8?B?UG8wOGdzRlFXaU9pK2d0L2RuVEVZeWtJTG9BUGpVZVBUUCtQclB4V3NDaXJW?=
 =?utf-8?B?NjhrMWJlVGpYT0p0ZDNIYWU2Zm04dnBMSHIzZFNVN0xtamxTTFc1ZGZSRjh2?=
 =?utf-8?B?MnNUMmpsSnYxeDY3b2hyRm5EeTdGSmF2K1BFUlI2QlhneC9BbGd0TlllVlRO?=
 =?utf-8?B?Wm40VklQZHhmdkpKb2lyOXF3YlNRVlcyYTRmd3J0OGIrdWJUZXluWXR6MUF2?=
 =?utf-8?B?TTBUa0lSajhmeno1N0k1Nys4UENGcDBLT2hXRTB2bUx2MjU2NmVSWUdlQXlj?=
 =?utf-8?B?TW1MNDA4NE13U293RE9FMExaYzdMTld0TVB2Um9tdjZ4ZnN1bE5lZlNQR01H?=
 =?utf-8?B?RHVPNW1jelFhVmdFblZKYU9OMURhaXloaWpkZmRYL1BWSkcxOE5WcGZ6eU92?=
 =?utf-8?B?UVI2SEhjcU0rWVdXQ2FlM0tPMWVYcFlXRGxDYWNKWG9pS2NwRzVqWFdiYVNn?=
 =?utf-8?B?SkxMYTR1dVBLdTMzOExJUUZDamsxQ3BWY2FYMHZFNGZudmdndmc4cGszYStN?=
 =?utf-8?B?ZXhZcTR0TXlzcEx2OHdnWXVQL1RKdm0vVlMyNng1d0U5OHRuTll3cHZIdEE5?=
 =?utf-8?B?UHZTSWxPV2w0SlJnUGtyZ0VjdSt2d3VDSnRyQ2lFN3RrMnVFL2YreWtzQnBk?=
 =?utf-8?B?Ui9TUG8zSFZ1c3l3QzcrQ29Ub2FxU2pFWjJpWFBtOFRDR2hVbW9YRjROV2Zi?=
 =?utf-8?B?WERORTUrUkxxd3VlQUV4UU5oTkR5cUpVMU1UYmxwczhRdUh0S0VEWWd6eGUv?=
 =?utf-8?B?c0dKbVJnaXYxb3A3QkR5OC9vcnJ1dzBkU1YrekQ4MStETXFhR1NLeWVuSUVZ?=
 =?utf-8?B?bUQ4NjFxdmhRdzdvZ0NmME4zUWRibzBxVS9WeWFJNFhZWVNtTEpWWEhGZEhD?=
 =?utf-8?B?UnpxQUNLQzJyODlHYmdsMkFPa1ZkN2ZnY2dGOGY0K29WK3R5K0VvRkhsNmRq?=
 =?utf-8?B?ZFBJVmR5T0dHNmhxcGZKZEQzM3NodFhsQzlWcU5VWHBnQzdDS2cwQ0t4N3Vi?=
 =?utf-8?B?MUdVa1BNVXhLdlhUS3M0ZWQyenN1b1JKQTdxUEFqbkY3UE1iMnRUQnN1R1VQ?=
 =?utf-8?B?anVtTE10YTBueFdMUStyNjFndENuNkNrUHhjVkVWY3VRVG9wa2tuQkVKdEs0?=
 =?utf-8?B?SkxIaEliNUJPZUNYZmd4Y3R5VzYrR2M4SzNMU2lLT1ZUK3lCS1dEcHB6RmZm?=
 =?utf-8?B?dTlSSEhsVnVPcVpoRUpTdENkTHovUTRFVENpWDBrMUljN1J4OVJCTkQwelBv?=
 =?utf-8?B?TFY0OU1rRWF3SnZGN2V0TmNRSmxobHE0cEJwM3VQeHMxVmE1cElYNG9FQi9C?=
 =?utf-8?B?cFBDV0NGeWFSYWVUdVhJRGx5NlZVZlVFMG0wNjhMdk5oaDN2KzlQTUFURjJH?=
 =?utf-8?B?dy9ZZmtlZ1hhZ0FRMmt6K2RCRXhVclB3ZkMwL1ZIeHowUnJlUHVnMFl6OW5E?=
 =?utf-8?B?bi82WkZ2cXJrai9TUU5DZEJpMUJ1dTJlMXNwaGF3UFpPSG42NkM0NzFYL1Vn?=
 =?utf-8?B?Q094TVBSNDVlaW9jdVBLclp6L21FWTBrS1lDdGNqem9UQk1McDdndUNMSzZH?=
 =?utf-8?B?N2ZIZk9VUWY3VmlKWkVvamo3Y1VSRUd3eStPdzhlWCtWZEhLY2VYV1Azc1Ri?=
 =?utf-8?B?SjVkWUZDZldKS21McmRJRHBNNnBnZjVtOERZdFpDTkFDdEMrSmZkMUozcU51?=
 =?utf-8?B?R01lU2RjdzhPcjc5QkVzV0NCSk1zSm5Vc3pKRlJrT3ZOWUZ0Wmw3cDdmczdy?=
 =?utf-8?B?b2FBbzMzVys0VHFuVFYxdWh3bEdkR3hrdklKZ1krMkdTemFnNTBhdDhQem1m?=
 =?utf-8?B?Y1lLaHM2OVlVbHNuZUM1end5VjNoRDZweThFYlNEcUF5eWU2N0pKWHMwb0Rz?=
 =?utf-8?Q?jTHw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5adc6ee-d896-4421-5533-08d9bed5e2a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 07:46:48.7436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqm5HwOXvY+T1RQQJrsajYvb1S9fgDcByl8att8nO7huM0tzBJgrg3c4u/+hM8/E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4987
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgRGVjZW1iZXIgMTQsIDIwMjEgMjoxMyBQTQ0KPiBUbzogUXVhbiwgRXZhbiA8RXZhbi5R
dWFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGltb25jaWVsbG8sIE1h
cmlvDQo+IDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kZ3B1OiBjb3JyZWN0IHRoZSB3cm9uZyBjYWNoZWQgc3RhdGUgZm9yIEdNQw0KPiBv
biBQSUNBU1NPDQo+IA0KPiANCj4gDQo+IE9uIDEyLzE0LzIwMjEgNzowNCBBTSwgRXZhbiBRdWFu
IHdyb3RlOg0KPiA+IFBhaXIgdGhlIG9wZXJhdGlvbnMgZGlkIGluIEdNQyAtPmh3X2luaXQgYW5k
IC0+aHdfZmluaS4gVGhhdCBjYW4gaGVscA0KPiA+IHRvIG1haW50YWluIGNvcnJlY3QgY2FjaGVk
IHN0YXRlIGZvciBHTUMgYW5kIGF2b2lkIHVuaW50ZW50aW9uIGdhdGUNCj4gPiBvcGVyYXRpb24g
ZHJvcHBpbmcgZHVlIHRvIHdyb25nIGNhY2hlZCBzdGF0ZS4NCj4gPg0KPiA+IEJVRzogaHR0cHM6
Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMTgyOA0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4NCj4gPiBDaGFuZ2Ut
SWQ6IEk5OTc2NjcyYTY0NDY0Yjg2YmI0NWVlZDBjMjVjOTU5OWQzYmI0YzA2DQo+ID4gLS0tDQo+
ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jICAgICAgICAgICAgfCA4
ICsrKysrKysrDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92MV8wLmMg
ICAgICAgICAgfCA4ICsrKystLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2Vy
cGxheS9hbWRfcG93ZXJwbGF5LmMgfCA3ICsrKysrKy0NCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwg
MTggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jDQo+ID4gaW5kZXggZGIyZWM4NGY3MjM3Li5jNzQ5MmRi
M2UxODkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5
XzAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMNCj4g
PiBAQCAtMTgwOSw2ICsxODA5LDE0IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfaHdfZmluaSh2b2lk
ICpoYW5kbGUpDQo+ID4gICAJCXJldHVybiAwOw0KPiA+ICAgCX0NCj4gPg0KPiA+ICsJLyoNCj4g
PiArCSAqIFBhaXIgdGhlIG9wZXJhdGlvbnMgZGlkIGluIGdtY192OV8wX2h3X2luaXQgYW5kIHRo
dXMgbWFpbnRhaW4NCj4gPiArCSAqIGEgY29ycmVjdCBjYWNoZWQgc3RhdGUgZm9yIEdNQy4gT3Ro
ZXJ3aXNlLCB0aGUgImdhdGUiIGFnYWluDQo+ID4gKwkgKiBvcGVyYXRpb24gb24gUzMgcmVzdW1p
bmcgd2lsbCBmYWlsIGR1ZSB0byB3cm9uZyBjYWNoZWQgc3RhdGUuDQo+ID4gKwkgKi8NCj4gPiAr
CWlmIChhZGV2LT5tbWh1Yi5mdW5jcy0+dXBkYXRlX3Bvd2VyX2dhdGluZykNCj4gPiArCQlhZGV2
LT5tbWh1Yi5mdW5jcy0+dXBkYXRlX3Bvd2VyX2dhdGluZyhhZGV2LCBmYWxzZSk7DQo+ID4gKw0K
PiA+ICAgCWFtZGdwdV9pcnFfcHV0KGFkZXYsICZhZGV2LT5nbWMuZWNjX2lycSwgMCk7DQo+ID4g
ICAJYW1kZ3B1X2lycV9wdXQoYWRldiwgJmFkZXYtPmdtYy52bV9mYXVsdCwgMCk7DQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjFfMC5jDQo+
ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92MV8wLmMNCj4gPiBpbmRleCBi
M2JlZGUxZGM0MWQuLjFkYTJlYzY5MjA1NyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9tbWh1Yl92MV8wLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9tbWh1Yl92MV8wLmMNCj4gPiBAQCAtMzAxLDEwICszMDEsMTAgQEAgc3RhdGljIHZv
aWQNCj4gbW1odWJfdjFfMF91cGRhdGVfcG93ZXJfZ2F0aW5nKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LA0KPiA+ICAgCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpDQo+ID4gICAJCXJldHVy
bjsNCj4gPg0KPiA+IC0JaWYgKGVuYWJsZSAmJiBhZGV2LT5wZ19mbGFncyAmIEFNRF9QR19TVVBQ
T1JUX01NSFVCKSB7DQo+ID4gLQkJYW1kZ3B1X2RwbV9zZXRfcG93ZXJnYXRpbmdfYnlfc211KGFk
ZXYsDQo+IEFNRF9JUF9CTE9DS19UWVBFX0dNQywgdHJ1ZSk7DQo+ID4gLQ0KPiA+IC0JfQ0KPiA+
ICsJaWYgKGFkZXYtPnBnX2ZsYWdzICYgQU1EX1BHX1NVUFBPUlRfTU1IVUIpDQo+ID4gKwkJYW1k
Z3B1X2RwbV9zZXRfcG93ZXJnYXRpbmdfYnlfc211KGFkZXYsDQo+ID4gKwkJCQkJCSAgQU1EX0lQ
X0JMT0NLX1RZUEVfR01DLA0KPiA+ICsJCQkJCQkgIGVuYWJsZSk7DQo+ID4gICB9DQo+ID4NCj4g
PiAgIHN0YXRpYyBpbnQgbW1odWJfdjFfMF9nYXJ0X2VuYWJsZShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikgZGlmZg0KPiA+IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBs
YXkvYW1kX3Bvd2VycGxheS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxh
eS9hbWRfcG93ZXJwbGF5LmMNCj4gPiBpbmRleCAzNjU2YTc3YmFlYTQuLjk5NTNhNzdjYjk4NyAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9hbWRfcG93
ZXJwbGF5LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9hbWRf
cG93ZXJwbGF5LmMNCj4gPiBAQCAtMTE2Nyw3ICsxMTY3LDEyIEBAIHN0YXRpYyBpbnQgcHBfc2V0
X3Bvd2VyZ2F0aW5nX2J5X3NtdSh2b2lkDQo+ICpoYW5kbGUsDQo+ID4gICAJCXBwX2RwbV9wb3dl
cmdhdGVfdmNlKGhhbmRsZSwgZ2F0ZSk7DQo+ID4gICAJCWJyZWFrOw0KPiA+ICAgCWNhc2UgQU1E
X0lQX0JMT0NLX1RZUEVfR01DOg0KPiA+IC0JCXBwX2RwbV9wb3dlcmdhdGVfbW1odWIoaGFuZGxl
KTsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIEZvciBub3csIHRoaXMgaXMgb25seSB1c2VkIG9uIFBJ
Q0FTU08uDQo+ID4gKwkJICogQW5kIG9ubHkgImdhdGUiIG9wZXJhdGlvbiBpcyBzdXBwb3J0ZWQu
DQo+ID4gKwkJICovDQo+ID4gKwkJaWYgKGdhdGUpDQo+ID4gKwkJCXBwX2RwbV9wb3dlcmdhdGVf
bW1odWIoaGFuZGxlKTsNCj4gDQo+IFRoaXMgaXMgYSBnZW5lcmljIGVudHJ5IHBvaW50LiBXb3Vs
ZCByYXRoZXIga2VlcCBQRyBlbmFibGUgb3IgZGlzYWJsZQ0KPiBzdXBwb3J0ZWQgaW4gbW1odWJf
djFfMCByYXRoZXIgdGhhbiB0aGFuIGhlcmUuIEFuZCB0aGlzIGNvbW1lbnQgYWxzbw0KPiBzaG91
bGQgYmUgaW4gbW1odWJfdjFfMC4NCltRdWFuLCBFdmFuXSBwcF9kcG1fcG93ZXJnYXRlX21taHVi
IGlzIG5vdCBhIGdlbmVyaWMgaW50ZXJmYWNlLiBJdCdzIGN1c3RvbWl6ZWQgZm9yIFBJQ0FTU08g
d2hpY2ggYWNjZXB0cyBubyBwYXJhbWV0ZXIoImJvb2wgZ2F0ZSIpIGFzIG90aGVyIGludGVyZmFj
ZXMuDQpUaHVzIHNvbWUgY29tbWVudHMgd2hpY2ggZXhwbGFpbiB3aHkgdGhlIGludGVyZmFjZSBp
cyBzbyBzcGVjaWFsIGFyZSBwcm9wZXIgSSB0aGluay4NCg0KQlINCkV2YW4NCj4gDQo+IFRoYW5r
cywNCj4gTGlqbw0KPiANCj4gPiAgIAkJYnJlYWs7DQo+ID4gICAJY2FzZSBBTURfSVBfQkxPQ0tf
VFlQRV9HRlg6DQo+ID4gICAJCXJldCA9IHBwX2RwbV9wb3dlcmdhdGVfZ2Z4KGhhbmRsZSwgZ2F0
ZSk7DQo+ID4NCg==
