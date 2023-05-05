Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241DDC77B7C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 May 2023 09:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC2710E5B1;
	Fri,  5 May 2023 09:10:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C4A910E5B1
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 May 2023 09:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuAQPakXpR2xoRezmxvTzbjvxo/vm9wXgdusgbRQv8KTXmDH2bHMwD7ulnDYHYfa8EvlhkE8lgpqh6SuYzASYtTiNxyXqENarOTGJdd9xi2g4vFiPblT57AdbYqkMkcPxl0qz0P2M+K+yBCRbgcTykzafSl+m2Q+EZIcZqspWrLmjwo6BAdUm8g56pjhh+X5BBbZpF63s9CpD+zURRlVveazP/X4D3ehSK6IKY0Q4MvSWp1QPQwg9fa2oPhzAuJMMbwjNGIDWuB6nRVDrHGj9ucnmRQ1/2mwj9YDi7eah+JDIje78fE1ac+jACpEy5Sdph6SSYcuJ6xDG5wO4CaFCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLNRQDQbCTip8FaREVBSXa7PctcEaHvLcR8I6lLnG+Y=;
 b=KaJ6P0YCtmoOpUQlUAzdbm7pcV22T2DrtRpP/guP/L45KAP2ySyp8GORhR6X25blhyb5fFIQVdbdieRxytJyS5KEgRUTx6HXqCLQgrZSOf20QEhfioa+qQK33/qw9acPn7zkxRsNTmJxvkOrCraNM00Q0hJkZJpoyZnDeYjqyXq7MUSOOaTs4pk0P6ZbtWesooZOVZY/YNFxpqDHlUVi1+9Ipx5xScXzAksgdMANemAjxfVBsxZhAb5NDVyASfYe/F3hehTxlaUopx8XDGxnGsPEgzDUvgyZXInoMob0nvd+EOvIFoxmNfJixLFIoSCNMOXvehJ9HR/x+9bfLoCJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLNRQDQbCTip8FaREVBSXa7PctcEaHvLcR8I6lLnG+Y=;
 b=EnbqFkbhbHzkQ7vvHX+CCZc8iUCcEWrOm+zaYG2IG0JuHa+AzKOFsU6sW9/2k/BB3dXKC+Tkj1L0WMZY5J2mVZxCRnVBHRvZR1xA/ooT0HiFGV6YQyC1q3sMZONBM/ygMc/9CK6F4HdATx1S5c7WsN1LIp4Nejq4dbfjbu3TPK4=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.27; Fri, 5 May 2023 09:10:07 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c7b1:f457:da06:8bc8]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::c7b1:f457:da06:8bc8%3]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 09:10:06 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Quan, 
 Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [PATCH] drm/amd/pm: parse pp_handle under appropriate conditions
Thread-Topic: [PATCH] drm/amd/pm: parse pp_handle under appropriate conditions
Thread-Index: AQHZfysFmefWCCX+dEmDCdU4VrHk+a9LYX8AgAACMhA=
Date: Fri, 5 May 2023 09:10:06 +0000
Message-ID: <DM5PR12MB2469FDC7B81DC38D43FFB0FBF1729@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230505082414.1194477-1-guchun.chen@amd.com>
 <c2c1d11b-e81f-eeab-68bc-042282d4918b@amd.com>
In-Reply-To: <c2c1d11b-e81f-eeab-68bc-042282d4918b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|MN2PR12MB4224:EE_
x-ms-office365-filtering-correlation-id: 02e1714e-c061-4cdf-c71d-08db4d4884c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 54I2MT+u5cNWsC5heZDwMeJqERXPbdlmtU6hzpmcflY012YhRi/H6HRvoBhslLydM0edJeo0j0aTb6Go50/xnx1ETCoGtWzcN4edhfDVNEcJJWGAbeJLkId7Hnb7StH+O8gNmq/anLua9s5Yz5lebTexAqcEc1VzcL0lBsq01w7+K0I/+iSDHQFnHQf1zjOtIc5BoMKT/vhxz93S2bHJgevzYKoCqRWqSpI/HStvS9Ir6D/+sMtQz0BYpZmHmqUkPvI/WEXR2H1FkoQ1VbLWt+NQA/xSI1+Re3vlukye3cK7bH4MsjKwsLwVbUFOzUFyea5ZKODwN9Ynz/woY6iHoKJHY6f+viYBCvqKipEmvzXTJlSz68IRROhUGN32j6nOVYIxbyX/hF01g+x1kfqIRdlRnwGPeN1QoGFvRGVxAJSo4Su3AYLkvVSrakdt3ar4CN1J3FLzgRlww1xWOYVczQoA4zqaCPylppuL9D1XxwOWRTRF4A8zxVCgQaC7y0PN11Kq4xXLIgGIjBvbcdvOwehRbEZjXbnVtlFsUvJIEt73f4K3wjpw1PjwPB+0FLycRm3bm0LrrfUPBMclUcsXdQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(83380400001)(186003)(33656002)(2906002)(55016003)(38100700002)(122000001)(38070700005)(921005)(86362001)(8936002)(8676002)(5660300002)(966005)(52536014)(6636002)(64756008)(66446008)(66556008)(66476007)(76116006)(66946007)(41300700001)(71200400001)(7696005)(316002)(478600001)(110136005)(26005)(6506007)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3NSNGIrUkFiSVp6YVhBM3FGZXFLaFJFOUkrNUNSQnVROWZDc3NSYTloUHJ3?=
 =?utf-8?B?V0NwdXYvdTFGcXQzVkQ2YkRiZFptVG40Y1ZMQ21xQmZzOEVrSHQ5ZWZOd3g2?=
 =?utf-8?B?SzdyL210cUZqeVJDU3Y1N21tMDJka0lTRVlLZVd4WnJKMWJ1d1VZL1kzcWRx?=
 =?utf-8?B?Mm82ZGVCTEh0cXJ4a1g2MmJ2SVMxR3RkSjEzay9JcEN5aUtZVkVObm1RSmU2?=
 =?utf-8?B?N2hEUExJWXJOU3dCMjRoR3dmNTJaL01TUTgwSjVPYzJUUm5IUGtFN2Q3eVlv?=
 =?utf-8?B?b2VJQVRRV3paSDAvUmpWNFRQTmRHUVdrbnM2MTJLWDE3QlYxM0NvNDdKOWEz?=
 =?utf-8?B?bGlxTEpGYzUxQktpcmRzMFBLUVhiNDVUQUtUZHhuZnZhRExRWndueWFpaGJn?=
 =?utf-8?B?eXByVFpkaUhlZS9jYlQ1ajQ4SVNSRXFOeWxjUTVLUnptSVl6WHdCWFRDQzN4?=
 =?utf-8?B?OGNBRE5RdHB4OTVocDk0eEgxUWEvZTVhV0habGo0b1hnWGQxOUZuY0NkdU1S?=
 =?utf-8?B?dDRxV2FudTJxWnBGTXZoZ1RMcTZXcHliRWtUcmV2bkU3WXA0SUtiVzVxcHY2?=
 =?utf-8?B?aExTT0E2OGVvS29IVHI3a0NDUWh4dnRQb2FRalpDeWZEMldFbjB2ZW8rcjhS?=
 =?utf-8?B?M1NFZkFKS2g1RG5uZmxGekpETWZGRExZNTEvTDJSYjQzcVNXRG45OGEwNm96?=
 =?utf-8?B?OGZDUTZ3R1NJMytpZzJWQUF5cVhOVDZ6QlJkZURIalNoSnM5RXIycm5YR1JF?=
 =?utf-8?B?M2I2bXQrRjlDWDdMeElxY2hjVUplTWdwR09kL3VRNDFDNTNPUE5RMnJqdWhv?=
 =?utf-8?B?dHlVOWhlRUFoTjRtMjhKdkpVbVpMMnkxa0hEWXloM21ScHNUUFRKZ3V6ODJM?=
 =?utf-8?B?a2dsSFloWnVVd2NjZFUweGttNTVEazlEYzlScmowSUM1YnlZbXJNZFpDMUp6?=
 =?utf-8?B?MiszZS94a3p4UEx1RnB1dEp1K1BXQ2kxdEZ1L1ZMQjVLUjN1VWU4SERtK2Ix?=
 =?utf-8?B?Y3BPcGxEbHRSTXkxZS9FMGo3WTByc2NEOHVNRk51NVIxMXBSKzlUajlZK3hu?=
 =?utf-8?B?clYzMFc3YUM4dXhXaTVnQUwvM0xXNW5Ycmg5cWkrYzVHeHRlRFNyWFBlL05P?=
 =?utf-8?B?cGgyVUVCd3VuTW9sWHB0MG1aZ2xTaTY4dS8yMXhSZTBFUWVmNE40cHM0V3Bu?=
 =?utf-8?B?VmxJc1h3RWZicVBDNkJmdDdsdUNyQ0lJMms4aFRlNW1aWkVOazVZWktPZUgz?=
 =?utf-8?B?dmFmU0ZCUkxHSXBpbVZPSjFNTkVjWnlRaWd4amYrT1dKelFIbjhCek1mdWVT?=
 =?utf-8?B?REIvMHVGenppdi9PeW1nejB4OWZjWVlmVEFuSGl3MkRUT3VRc0tLYnZHdlQ2?=
 =?utf-8?B?akJ4TkV5Ynl3OTlkODRTdUZzcG5tQ1FsekhjT01UemRCby9oS2VCNDVNZ1Iy?=
 =?utf-8?B?Ui96eWxhNHZHZTRPNkdidVJRT21sU2oyZGVzM2dpdFloSnVYcG5UcG9HcVpp?=
 =?utf-8?B?WDhnMDhtZVpsb3B3S0hqa1NBQXRMd2pMclEvYlpFMVZFOXdrZVdBOEFpdGxs?=
 =?utf-8?B?TnNkWWRGNGI4K2VKc1JxTXJHdzc0dHQ0OWxrSk5QN3ZWVTUyaTRQL1BUS0Fz?=
 =?utf-8?B?R2JoMnk4bEhvRFIzcDkvYVZnUE44amkwU0JBeXp2Y0FGZmhCVzllekxNSUhr?=
 =?utf-8?B?SHVYNFE0amhSTmZkcXB0TXh4RnpPSUZ2Q1dDd0o2MFN3RGxsSG91dUtFckxF?=
 =?utf-8?B?NmVPUGluUXYvK1lVQnp6bHpEcFk0Umh3TUZ6Qm9IbU5XVFN2b1ZtbWI2aDZl?=
 =?utf-8?B?N0c0eW44b1VvVEI2ZE1FdzlQaTVkcmlBMDZKN2lSdExjUEN6elNUMU82Vmg3?=
 =?utf-8?B?VVFFMjhmL1l1MFFSVy96N1lXVG92SDRGeEJ5VkJ3L2paM2MycGFLbzNxTG9l?=
 =?utf-8?B?Z3JMbW9URExXcEtTS21hZHFrWWg5ZGN4YVh0eFM4dzVzaDNEazhLOCtVQ2p5?=
 =?utf-8?B?eUhIVzFVOHNrUFgzRzFlRGxkbEFFS056S2hsUUM1SHVxL254TXl6SmI4SlRJ?=
 =?utf-8?B?SmtlY0J1U3pXNEc1R2QvT3dsK3dWS05BZW5SVFFoS0wveVRCMHFRV3B4RjhN?=
 =?utf-8?Q?6KD8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e1714e-c061-4cdf-c71d-08db4d4884c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 09:10:06.3290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dp1GquyUtomrsbtuzUYqU4ksPyEBti2vsybQBYHZVNdhMqP2I2uuMmUo+IOo88mAqVoyr1o1Sbgk3ph/C6IfCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExp
am8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXkgNSwgMjAyMyA1OjAwIFBNDQo+
IFRvOiBDaGVuLCBHdWNodW4gPEd1Y2h1bi5DaGVuQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nDQo+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBR
dWFuLCBFdmFuIDxFdmFuLlF1YW5AYW1kLmNvbT47IEtvZW5pZywNCj4gQ2hyaXN0aWFuIDxDaHJp
c3RpYW4uS29lbmlnQGFtZC5jb20+OyBQYW4sIFhpbmh1aSA8WGluaHVpLlBhbkBhbWQuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL3BtOiBwYXJzZSBwcF9oYW5kbGUgdW5kZXIg
YXBwcm9wcmlhdGUNCj4gY29uZGl0aW9ucw0KPiANCj4gDQo+IA0KPiBPbiA1LzUvMjAyMyAxOjU0
IFBNLCBHdWNodW4gQ2hlbiB3cm90ZToNCj4gPiBhbWRncHVfZHBtX2lzX292ZXJkcml2ZV9zdXBw
b3J0ZWQgaXMgYSBjb21tb24gQVBJIGFjcm9zcyBhbGwgYXNpY3MsIHNvDQo+ID4gd2Ugc2hvdWxk
IGNhc3QgcHBfaGFuZGxlIGludG8gY29ycmVjdCBzdHJ1Y3R1cmUgdW5kZXIgZGlmZmVyZW50IHBv
d2VyDQo+ID4gZnJhbWV3b3Jrcy4NCj4gPg0KPiA+IExpbms6IGh0dHBzOi8vZ2l0bGFiLmZyZWVk
ZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzI1NDENCj4gPiBGaXhlczogZWJmYzI1MzMzNWFm
KCJkcm0vYW1kL3BtOiBkbyBub3QgZXhwb3NlIHRoZSBzbXVfY29udGV4dA0KPiA+IHN0cnVjdHVy
ZSB1c2VkIGludGVybmFsbHkgaW4gcG93ZXIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEd1Y2h1biBD
aGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9hbWRncHVfZHBtLmMgfCAxNiArKysrKysrKystLS0tLS0tDQo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X2RwbS5jDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0uYw0KPiA+IGluZGV4IGYwMDY4ZGYyZDA3My4uYWU0
NWFiZWFiNWI1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1
X2RwbS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfZHBtLmMNCj4g
PiBAQCAtMTQ1NSwxMyArMTQ1NSwxNSBAQCBpbnQNCj4gYW1kZ3B1X2RwbV9nZXRfc211X3Bydl9i
dWZfZGV0YWlscyhzdHJ1Y3QNCj4gPiBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+DQo+ID4gICBp
bnQgYW1kZ3B1X2RwbV9pc19vdmVyZHJpdmVfc3VwcG9ydGVkKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQ0KPiA+ICAgew0KPiA+IC0Jc3RydWN0IHBwX2h3bWdyICpod21nciA9IGFkZXYtPnBv
d2VycGxheS5wcF9oYW5kbGU7DQo+ID4gLQlzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSA9IGFkZXYt
PnBvd2VycGxheS5wcF9oYW5kbGU7DQo+ID4gLQ0KPiA+IC0JaWYgKChpc19zdXBwb3J0X3N3X3Nt
dShhZGV2KSAmJiBzbXUtPm9kX2VuYWJsZWQpIHx8DQo+ID4gLQkgICAgKGlzX3N1cHBvcnRfc3df
c211KGFkZXYpICYmIHNtdS0+aXNfYXB1KSB8fA0KPiA+IC0JCSghaXNfc3VwcG9ydF9zd19zbXUo
YWRldikgJiYgaHdtZ3ItPm9kX2VuYWJsZWQpKQ0KPiA+IC0JCXJldHVybiB0cnVlOw0KPiA+ICsJ
aWYgKGlzX3N1cHBvcnRfc3dfc211KGFkZXYpKSB7DQo+ID4gKwkJc3RydWN0IHNtdV9jb250ZXh0
ICpzbXUgPSBhZGV2LT5wb3dlcnBsYXkucHBfaGFuZGxlOw0KPiA+ICsJCWlmIChzbXUtPm9kX2Vu
YWJsZWQgfHwgc211LT5pc19hcHUpDQo+ID4gKw0KPiANCj4gTWlub3IgY2hhbmdlIC0gcmV0dXJu
IChzbXUtPm9kX2VuYWJsZWQgfHwgc211LT5pc19hcHUpOyBhbmQgc2ltaWxhcg0KPiBiZWxvdyBm
b3IgdGhlIG90aGVyIGNoZWNrIGFsc28uDQoNCk1ha2Ugc2Vuc2UsIHdpbGwgdXBkYXRlIGluIHYy
IHdpdGggeW91ciBSQi4NCg0KUmVnYXJkcywNCkd1Y2h1bg0KDQo+IEFueXdheSwNCj4gDQo+IAlS
ZXZpZXdlZC1ieTogTGlqbyBMYXphciA8bGlqby5sYXphckBhbWQuY29tPg0KPiANCj4gVGhhbmtz
LA0KPiBMaWpvDQo+IA0KPiAJCXJldHVybiB0cnVlOw0KPiA+ICsJfSBlbHNlIHsNCj4gPiArCQlz
dHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyID0gYWRldi0+cG93ZXJwbGF5LnBwX2hhbmRsZTsNCj4gPiAr
CQlpZiAoaHdtZ3ItPm9kX2VuYWJsZWQpDQo+ID4gKwkJCXJldHVybiB0cnVlOw0KPiA+ICsJfQ0K
PiA+DQo+ID4gICAJcmV0dXJuIGZhbHNlOw0KPiA+ICAgfQ0K
