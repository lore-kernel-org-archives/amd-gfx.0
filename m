Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36965C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 07:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A853C11B715;
	Tue, 11 Jan 2022 07:20:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA99811ACCE
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 07:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAV3itN1dsrhWSdvnE0O449IlAHiq9AixmpCmAta2REi4q5sLZGVEosjrzRiTBM+0pIuXe+RVHG0nvpU7twUc+GCDrR5CGX80G0PMqRRbjL3CuiL86mGcv8fJWdjTA+UUtfaLSgkspXFlIZ5pmgl893qUx6jT1kyG7iY3zl4JMEc8+BV2hG5U24DVPJDqJRNu9aPoDPG3Z5tk1GJJYYKsjqMrFR6wVlKdAaDACahggiPDHF7FEsSm8BV2smylhuBU42hMlTc+syiWIawUd3vh42cMrb+PdtrESSpTsDTneBCJ76uKPBxmRv1/pvfovhD583JAUDMjJpdfbcStAJKng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJMeJ6/MrZTTlfdKTi9iVrsrBWRkaYYYsotw+b925ig=;
 b=h0HnAwmN7oYGSeEzQY2x5Y7rqjFTxy+6DCtVb1MfjEFxUjlKhcMSZpeJDpFUKALZ3TiESbIwOsf6L4nz78k7WUSFbXFvrVlL4sMnDgrXA1O1odPWbABEnXod0miDPZUozr9cybIOAlp3dpuEnAz1AQ1TTgKapScYfOiJwbkA55FEuI2PWu+vUT5B3BOOZ9daQVQz1F0O3uBFRsK9JvfqigpHQQGH76G/YpxUGnuOP2PnPPgyBSr3JxLR6UYHnRqOfp3jjc3QKxjA8YBD5JuuMmupuVRtoiRAog3ukpLUF/xN3uvdImDKV1o51LNPl0cxXMWme7irh2Uyiju9r+wHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJMeJ6/MrZTTlfdKTi9iVrsrBWRkaYYYsotw+b925ig=;
 b=v8ynscqRV0psxh4Ov387O5gDepBMnxsfw1dFjvqWQsVhchXw2eopi75c2qsBVAkPoYm4XaesSW3E59ZIgdyAcBP5knW2fPGTaxBKYVYLOrYWUBEWM6OyuYQa5/WcS95MY1sf4LT5o2HRHa2o11byoqroipOeZc9QxOb/+nSHpHU=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB4699.namprd12.prod.outlook.com (2603:10b6:5:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 07:20:50 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934%11]) with mapi id 15.20.4867.012; Tue, 11 Jan
 2022 07:20:49 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amd/pm: only send GmiPwrDnControl msg on master die
 (v2)
Thread-Topic: [PATCH] drm/amd/pm: only send GmiPwrDnControl msg on master die
 (v2)
Thread-Index: AQHYBrU8qPWORYZ6X0O8cdsguXty86xdZEgAgAAFBOA=
Date: Tue, 11 Jan 2022 07:20:49 +0000
Message-ID: <DM5PR12MB1770DB00C1A6495AEB173416B0519@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220111063352.16123-1-tao.zhou1@amd.com>
 <8172b93d-cde7-9c89-a81f-647466ce6891@amd.com>
In-Reply-To: <8172b93d-cde7-9c89-a81f-647466ce6891@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-11T07:20:47Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a6ba79c2-57db-46c4-832e-744e935170c7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-11T07:20:47Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 9c56bf01-5578-47a7-88f6-68bafee88f4b
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4a459c0-de1d-4d5f-a77b-08d9d4d2e4ef
x-ms-traffictypediagnostic: DM6PR12MB4699:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4699E0819F1FEFFB0783AA48B0519@DM6PR12MB4699.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XBnknfXxA78p26mPhfDztrSJP22rQ2Fw8rsquzDLtwroTwmK/U+GbdHdjNnVi2JLokggJp0UynODLHaBAd21cFBi18MI5fJbG30+/CaIvHDWkC8uWE99wEhMrVU3tWRILmM8wIhd//KNLXrj1gorSm7csffTXAOLpCygJy2FTKFxwVLeiOhePCVlgipIqDIclz7LFbSf7Vze9y43JRn7OhtKKsxS3YJbeKudfuMnhrU/d55huHKOiy15T8KCmevWEYJpFn9EeEQ/9aGorKqy5myxPvKVzDUq9MGAe7o+5XHCgKZc6goHfYesCE9IZ+RRRbg12kF2NsmTNJfwqTIMvhN/inksw0K7vEZJZAM45qG1PO8xgYprusM4WMEeK9jRnJhYrrbk35w4nQAeQnp24YjXC531HEfGgW4UEIHwD2Bh/6IKkZ8d0lXDbdPMDuNGjBY92mcs3DL+yELTiqBwiqZOlU/V21QgUKLxNdPfm+XowAhvMqo27BbM59fjTQyXP84jgl9Pi+JthtpdJo6GzUcPzQamYJcnUher8s/dlvghQ9+0wm4rG3ymwFzO0B4WHVlyAczVAFZk4wDhn0hrI4U6iGw4cJQp9PDjezvQ/rQ9o1XNk+MEpHdM8rBU6RMPnb+6ziYcCQ9tjMn7zdi6MEU4hslpYGCEljU3pE8tHKuZA5hf1dvuh3J/XdNnOgnGa3Hq7cmdmbUZJSywwUBNYw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(6029001)(4636009)(366004)(5660300002)(7696005)(66946007)(26005)(64756008)(38100700002)(186003)(55016003)(122000001)(6636002)(76116006)(71200400001)(52536014)(66556008)(8936002)(66476007)(8676002)(53546011)(33656002)(9686003)(110136005)(316002)(6506007)(86362001)(66446008)(2906002)(508600001)(38070700005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3ZEZHpMd3k1ZHRWcXFhRlZtM0w1aXVIVXgrck1remwzbGFrRmhvd01NRkNa?=
 =?utf-8?B?MUFxTnhPL21oQnZmVGZVQVVVNzFqSGtmQUpaZ3VqM1BhYWFKK3ZqZm9NMkU0?=
 =?utf-8?B?MmRTcTYwUVdrVklnTloxdFYxb2xIbHVQT0VOUWN1eVNlUDY1Q29Jekl3dFJB?=
 =?utf-8?B?V014aExVS2NnM3RDd3VhNE5BdmJxaUFuR2FISWRGeld0TmRZRDN1ZDFSa3J3?=
 =?utf-8?B?NGFQS21DdjFETGRlTE1VN2g1VUhIcWFIT0xQMEozRnFUbGdnYmxuRnJEVC9Z?=
 =?utf-8?B?cWx0R2xPcUxvOVJucHhTellwbG15YmNyVkdlQnVaQmNDRS9MOGpZSFhjK09m?=
 =?utf-8?B?YU5hbzBKQXIwemlTWW9DUVNwN29oak9wMG41YzRkalk3L0ZJNHpORnU3YU50?=
 =?utf-8?B?N1BQU3BtNWlKYTdlQTNOMjU1aWpCbi9EUFhtUTQ4OUdNQmp6UVRNNmkxbjdQ?=
 =?utf-8?B?a25HZXppNUxJaTJNWkdTVWVtb0llYkZNZ0RsOTlvYS9NRGlQQzc3K2RocmpZ?=
 =?utf-8?B?dmRoZGMzVzQ3V2Q4dW9Cb0IwcHlXWXhLdU45cUJ2dXRPWjF3dXJMTkFhTkor?=
 =?utf-8?B?UWxvREw0L1NtMTNxMG5oWllZK002amZhVUlUZFZNMU5tRmpWL0JrMUtnbFZO?=
 =?utf-8?B?NjVHbk9RVzdnZGZ5TU9tTkpTQnVJNEIyeVdFN1czbUtoTUFoSlRaMHdQMUFi?=
 =?utf-8?B?eU1pZ0M1ZjNZRnR2RUJlQy9HdTFnRUt1bXcrNWtjQ3hIdklPNm9MUnA5bXND?=
 =?utf-8?B?ZXVpVDJBT3FKZm1USGYzQmZJczR1Ykkrc0pXaXFhaEpPNFdXZ3ZWbFIzVTVQ?=
 =?utf-8?B?L0dWQnZCR3MyYVZlelFrTy93cHVPZDZrVVFzTi9EamtyTEl5Vm1DMjZsbTAr?=
 =?utf-8?B?RXVpQTRMbXhaT1ZIVXV0MnRwblNFaEUzSlNLdThyM1VKdGNwY3htaGlUV1VI?=
 =?utf-8?B?YU5zV0ZtQ09MQmUwdWpGNzJIaXRXdktJQnI2alR5ZmEvZ3c4YjBDcmlMYjlU?=
 =?utf-8?B?QTFtczVwUUhpekprUklUWmozOC9pWVNaN015RGhnUkdlNDVLWXl1UWMvSTF2?=
 =?utf-8?B?NkoxYzQrTHU0alRxVnlZYUthb3o1ZUxFdmZoQmlqcTdFTThzajlNdmpvOXZE?=
 =?utf-8?B?ZlUrUGdxaEF6TkJCeEpYZnNrSjIweHJRZ1Y4bjFOUW10SndmQW4yd3pvbWth?=
 =?utf-8?B?blZuVStCOXJ5TXFMK0dYaEpQNWtZcThMeWpKeU16c0pzT0ZTZUEwSVFwK0p4?=
 =?utf-8?B?UEloSzdiQXA2ZmFNMDZvam9Nam1XQlM1dzFjTkJFWnlaU3JEK251S3hXZjFx?=
 =?utf-8?B?d1Nxd2lQMDBXeWtNQlFsSHJIVjVRTXRoSzgvWEdsb2UweTYxT2tnM2c1USt0?=
 =?utf-8?B?enMrTG5qR3cyOEh3RkV1ZHNRNnhLU2V5cTNkWTF1ZjUvbjVXL3pDRzFZRWhQ?=
 =?utf-8?B?NGl5VSs1NWpCTGxKeGtLb0EwRURSNjFlV1YvSVYzUVlEbjRpSXE3Y1hHS2Ev?=
 =?utf-8?B?eGUza0JTZFhmSVNtWDV1bFNkN2pCLzgxTGZKQWFIK0J3V1BQeGlBMTZJYm8r?=
 =?utf-8?B?OXVlSVFQbGFwc2Rvay9jU3FlbkRuZngyeEJhS2UxM0I1dnhMalZ6cUVKYWhE?=
 =?utf-8?B?c09ZOUx6MXRwV2UrMi9UTUtCakluUVJUdUpJY01FNU4yMXFEa3hTcjdZbTRN?=
 =?utf-8?B?aXhhYXp0STd0ZU5mVGZJRGZSdHBOTmpkWHliVUN5WEhXRldUckpsV0M0MWph?=
 =?utf-8?B?aEFkdmN4bGNORVFoQjBySy91OUNteU0yZ05jSDNCVGN1aHFEcTFPanpRcXhR?=
 =?utf-8?B?TzBwcmZiK3hWS0gveGxnd2prUHZVRlNaelEzTlZjOUdubWEyU0lJdmp3cStS?=
 =?utf-8?B?NVQ4Z1RGT1hoU0ZKTmJaSzVySVB1SEl1bVdnUTNsOGtQb2lQZ1pqa2djTGNE?=
 =?utf-8?B?ZXNyR2tFQ3BaNm1qM3R4Q0s3d000WXppbnJOM2ttUUZIZTRjenVQVkNoZVp0?=
 =?utf-8?B?SXMySFBRVHRQUzZCZ0F0S0Yxc0VwM00yb2RxTS9QWS9yNVU4TDZSbUJsdnlx?=
 =?utf-8?B?UVFJYnQ5aU9XcWZIczZFR1hPc1ZKTmw5QmMzVGtnOW9JTUp1WGJDMzluUk1I?=
 =?utf-8?Q?9NJ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a459c0-de1d-4d5f-a77b-08d9d4d2e4ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 07:20:49.8142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ku4KDMQ+e2sma/Vgi0N55aBdM7RwF4jtVkvVQVBuS1+Uhyw9EPUr0MMgT5ULzfYv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4699
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEphbnVhcnkgMTEsIDIwMjIgMzowMCBQTQ0KPiBUbzogWmhvdTEsIFRhbyA8VGFvLlpob3Ux
QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWmhhbmcsDQo+IEhhd2tp
bmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL3BtOiBvbmx5IHNlbmQgR21pUHdyRG5D
b250cm9sIG1zZyBvbiBtYXN0ZXINCj4gZGllICh2MikNCj4gDQo+IA0KPiANCj4gT24gMS8xMS8y
MDIyIDEyOjAzIFBNLCBUYW8gWmhvdSB3cm90ZToNCj4gPiBQTUZXIG9ubHkgcmV0dXJucyAwIG9u
IG1hc3RlciBkaWUgYW5kIHNlbmRzIE5BQ0sgYmFjayBvbiBvdGhlciBkaWVzDQo+ID4gZm9yIHRo
ZSBtZXNzYWdlLg0KPiA+DQo+ID4gdjI6IG9ubHkgc2VuZCBHbWlQd3JEbkNvbnRyb2wgbXNnIG9u
IG1hc3RlciBkaWUgaW5zdGVhZCBvZiBhbGwgZGllcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIC4uLi9kcm0vYW1k
L3BtL3N3c211L3NtdTEzL2FsZGViYXJhbl9wcHQuYyAgICB8IDI1ICsrKysrKysrKysrKysrKyst
LQ0KPiAtDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdTEzL2FsZGViYXJhbl9wcHQuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9zbXUxMy9hbGRlYmFyYW5fcHB0LmMNCj4gPiBpbmRleCAyNjE4OTI5Nzc2NTQuLjNmZTVjMDVj
ZWQ3NyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEz
L2FsZGViYXJhbl9wcHQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
c211MTMvYWxkZWJhcmFuX3BwdC5jDQo+ID4gQEAgLTE2MjUsMTAgKzE2MjUsMjcgQEAgc3RhdGlj
IGludCBhbGRlYmFyYW5fc2V0X2RmX2NzdGF0ZShzdHJ1Y3QNCj4gPiBzbXVfY29udGV4dCAqc211
LA0KPiA+DQo+ID4gICBzdGF0aWMgaW50IGFsZGViYXJhbl9hbGxvd194Z21pX3Bvd2VyX2Rvd24o
c3RydWN0IHNtdV9jb250ZXh0ICpzbXUsDQo+IGJvb2wgZW4pDQo+ID4gICB7DQo+ID4gLQlyZXR1
cm4gc211X2Ntbl9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbShzbXUsDQo+ID4gLQkJCQkJICAgICAg
IFNNVV9NU0dfR21pUHdyRG5Db250cm9sLA0KPiA+IC0JCQkJCSAgICAgICBlbiA/IDAgOiAxLA0K
PiA+IC0JCQkJCSAgICAgICBOVUxMKTsNCj4gPiArCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gc211LT5hZGV2Ow0KPiA+ICsNCj4gPiArCS8qIFRoZSBtZXNzYWdlIG9ubHkgd29ya3Mgb24g
bWFzdGVyIGRpZSBhbmQgTkFDSyB3aWxsIGJlIHNlbnQNCj4gPiArCSAgIGJhY2sgZm9yIG90aGVy
IGRpZXMsIG9ubHkgc2VuZCBpdCBvbiBtYXN0ZXIgZGllICovDQo+ID4gKwlpZiAoYWRldi0+c211
aW8uZnVuY3MgJiYNCj4gPiArCSAgICBhZGV2LT5zbXVpby5mdW5jcy0+Z2V0X3NvY2tldF9pZCAm
Jg0KPiA+ICsJICAgIGFkZXYtPnNtdWlvLmZ1bmNzLT5nZXRfZGllX2lkKSB7DQo+ID4gKwkJaWYg
KCFhZGV2LT5zbXVpby5mdW5jcy0+Z2V0X3NvY2tldF9pZChhZGV2KSAmJg0KPiA+ICsJCSAgICAh
YWRldi0+c211aW8uZnVuY3MtPmdldF9kaWVfaWQoYWRldikpDQo+ID4gKwkJCXJldHVybiBzbXVf
Y21uX3NlbmRfc21jX21zZ193aXRoX3BhcmFtKHNtdSwNCj4gPiArCQkJCQkgICBTTVVfTVNHX0dt
aVB3ckRuQ29udHJvbCwNCj4gPiArCQkJCQkgICBlbiA/IDAgOiAxLA0KPiA+ICsJCQkJCSAgIE5V
TEwpOw0KPiA+ICsJCWVsc2UNCj4gPiArCQkJcmV0dXJuIDA7DQo+ID4gKwl9DQo+ID4gKwllbHNl
DQo+IA0KPiBUaGUgZWxzZSBwYXJ0IGNhbiBiZSBkcm9wcGVkLiBXZSBhbHdheXMgZXhwZWN0IHNt
dWlvIGZ1bmN0aW9ucyB0byBiZSBwcmVzZW50DQo+IGluIGFsZGViYXJhbi4NCj4gDQo+IFRoYW5r
cywNCj4gTGlqbw0KDQpbVGFvXSBPSywgSSdsbCBhbHNvIHJlbW92ZSB0aGUgcG9pbnRlciBjaGVj
ayBmb3IgZ2V0X3NvY2tldF9pZCBhbmQgZ2V0X2RpZV9pZC4NCg0KPiANCj4gPiArCQlyZXR1cm4g
c211X2Ntbl9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbShzbXUsDQo+ID4gKwkJCQkJICAgU01VX01T
R19HbWlQd3JEbkNvbnRyb2wsDQo+ID4gKwkJCQkJICAgZW4gPyAwIDogMSwNCj4gPiArCQkJCQkg
ICBOVUxMKTsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCB0aHJvdHRs
aW5nX2xvZ2dpbmdfbGFiZWwgew0KPiA+DQo=
