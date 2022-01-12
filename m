Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A71C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 02:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3169E10E36D;
	Wed, 12 Jan 2022 02:08:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B6B10E3D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 02:08:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXq4s4xcxHHHgFA3yBkviA7B9oPEZD3lvvWbBuM7y88lRlEeiMrJTSX5oWA2coq2loeYq45ODhFxb2GP7FTT1PukV/ghmGTRll1LD8Z/RPhTtq3GDUTo2uYK8Q2GDjtUXcaUDmqi4Ndv/6eAPQEIai5MXHMV3nDwanx6jLqOFpYeDfeLoIDBO9n1I0lY6CdMTxLl57xSwemQn3daTUD2Q7IZ047GXBiCSwd4AdlNkvfIDgsbzy3jg3UZ/SsmM0C4kZNOraBAigw36EHmHqD65czVyr4KXxRBGMurECSifJLoDQRBc5pwmt8xnXREJY2QeVLTnr0NcM0SvGswZJESBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbitsxjyXUJt3xjQysMmPtO+a0Ck99uiZiAH798uSLo=;
 b=GFk2jDwoM1jt00ss+e4cVbEFsd9n4OlzWuHFc5Hh3rz9aEZjQ0kG9NqrFrsQtFg7g5pqjk8IQ1pHVqqVCgMeG7YULs3m+FVUxqy7zci1iwLYdM2ttJ42foaHvmeQtws/HQJwHzYdyCilrfSZzQmbhawFsVTXPlxHBhwk+SyZkRIRHk6InosN9aNvdZEuUtMv0eV/vLR4k0NRDzfe6+fgI1CFRzCS4VqPA086D2EHoaGKctjGIPh5/1s1V8pAuHkJdArWEC4bUif98XM3o1o2LISTvcori11Erdw+bhY7ZYQsgNvZTMfGGZz60XVQ3TeLhFhObX5bx9wh2qiomku/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbitsxjyXUJt3xjQysMmPtO+a0Ck99uiZiAH798uSLo=;
 b=FjDz8T57+kcJIl3wwwmonT18KgeNaUs6bHM+FRRqPGb4kUSlj5rv8d+eq+28K8TdN878ubKanlpNeCeOZAHfXEhl11pl+w+9fKNWDwF8qPPJ8iiGa44sBh4oNjhAwD655Z1Hyqn7jmWPnkcQ1kpsHmZZxH1QAxoVkEIu9PYZA6U=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 02:08:12 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4888.009; Wed, 12 Jan 2022
 02:08:12 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Bert Karwatzki <spasswolf@web.de>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
 DCN20/DCN21
Thread-Topic: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
 DCN20/DCN21
Thread-Index: AQHYB1FpTX0NCytoV0+kyrwquhUOraxeo1FQ
Date: Wed, 12 Jan 2022 02:08:11 +0000
Message-ID: <BL1PR12MB51570343D08806D7EC08D6FDE2529@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <c0ac94855d1119e398c5607263d06c750249300f.camel@web.de>
In-Reply-To: <c0ac94855d1119e398c5607263d06c750249300f.camel@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-12T02:08:09Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=41569e96-eca8-48e4-ab88-ef54056791f7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-12T02:08:09Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 363fef7c-805d-41d3-82e0-292ee3592927
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a73db1a-f987-4417-e500-08d9d57062f5
x-ms-traffictypediagnostic: BL1PR12MB5142:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5142CB961112F84485A5ACC0E2529@BL1PR12MB5142.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RWT/7E5EnpIU1cawpARWy4dBNzmqOo0rYfVYbY5yl+kWJPpUPbtelJlzf0QHC79oShADFZOFbS50iDAxMdvm+AIorUY9sKPjI4ed9DnNjox4WLKtKK7wP2NrpQipP4eq+7YbLOSBvzbe75CVfyVktkrxTI92VkAzVF1n4jXXwJf4NSGljqNC/ZNBJcy8PD3JS5f9wKKrLpsLnEfz5etxWlp1rZGOHIpdC0cqMDolFNOLbV+N3xGutrsH0H0kl2lCm6pseHEhARIPALhZdUa+JBkqqYPavGWkgA1I+6de7uA2rQ/fAByVNuUNCoBAYktyqi87LUyBaS+aDS2zO45/RSicPDh2kAtJ0KcHE6kec1r1b5jz2JW4eO+u2UNraF+gG/baHzlrdoXko3ivUv+wVbkEkCRUBBxdMoKKZ4sS/Jsx4DVsB8WTAmrq+YXxxtkeHyMO0M3gSXdoZlmmI9hCFL0EVzjfsbWFdtCb1zWhxYQlPyogDXHdnJvVhFkgx+Q4mOILe3PFyCZUAGFrHXPNZf4jThI10ioDauz02xNd26pEIKYHkFAwbYMkBJj5JW7HlUe35k0yEoLVULXgofSzEeq8+8qKkBfl3i4RN7g4rZNjmDHUQhD2YO3jbWr1JqeW7FdMIxHSipYjTXUtwxW17SXjEp1Tu+ko9Fr1R4hF8EVbQgbPqLKkWm2XwEVMxh8DngtBT3/CReTbfUPzdLm1OA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(83380400001)(6506007)(186003)(38100700002)(122000001)(2906002)(53546011)(4744005)(76116006)(5660300002)(508600001)(33656002)(38070700005)(9686003)(71200400001)(8936002)(7696005)(55016003)(86362001)(110136005)(54906003)(64756008)(316002)(66446008)(4326008)(52536014)(66556008)(66946007)(8676002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGhwUzBiclRkbHVvNk13UHJINTdheTF2TFlpNmltcUc3dFFuOEQrbHowdDVr?=
 =?utf-8?B?d005ZnNZMzE5ZlpZU1F1dTBEWWdkQlBhRWdCZFVKeXI3ZE12bGFkYnlIbUJ1?=
 =?utf-8?B?T0hZZ3VPYlpSRHBKWVd3K3VCREFoZUhyYmpURXVUTlUxTUt1V2J1RmhjU0hL?=
 =?utf-8?B?VzJIakhyemIzTk1PZjNJNjFFTVBWcnV5QmpSODArTUw3WTFidkRmY2tZSzJj?=
 =?utf-8?B?Z1JraC9NVWQ3ZGJNWHdWK3F0SlhlV3JGK0tGNDdDOEdrMTQ0S3I0Zk9DcXZy?=
 =?utf-8?B?cnJGSmFIeWFSYjl5KzZMbTJyb3JWMkpNSmxMY2ZpQmNGMTZuamhNdExZMFFZ?=
 =?utf-8?B?aW5mSlVVMG9tY3FpYVZoNjBkNVhLTWUvS1doZDhvcE9yS2tvMVByTWZZc0Rn?=
 =?utf-8?B?N0pkQzQxaDFrZW1KVFcxb2c1dmoxK2dPLzhMM09ySGsxYnBYQ0pVTUErSWh1?=
 =?utf-8?B?UXJvQm8xVjZlN29FN1R3NGNwdGJBaVVPdjNMZ1g3SU9MODdLSENzanYxa2J0?=
 =?utf-8?B?WVUyeXRRVGVHT1VLRkVBejVrQ0xoQjhNd3lJN1hyeE4wSHcyTDVoUkx4cjY4?=
 =?utf-8?B?ME95djczRnR4Qlk3dm5iMDVkYUtjMk1OWUlGVllsMko4dThmZGcwajlRSDRo?=
 =?utf-8?B?ZEx0SXhhb0NHRXM0VkNnTTZTTU94QWJxSmttb0Nsb1d1STdPZjVMWWRUOUlU?=
 =?utf-8?B?Ty80ZXJEd1FTWXhCT0NlYWxROGRhZDY0RmkzbVpVUW11Z0lNN09VYjlqc1c4?=
 =?utf-8?B?WklZMmpodFUrZU9ndjlxREJncEwyUEphenhZWWlsamZWck1McjR6Z2lYWHlr?=
 =?utf-8?B?N1lmYUhoQ09qa2hWdU9ubmlYV2dpUm5KcTllVGVGdTBYbGZydTRsNEtUcmFI?=
 =?utf-8?B?WTdsWWJYRllvQ3BvSCtrMjJnRm1nYjY1OVlYUTJYNVI5OXdycGEzdnJCUExJ?=
 =?utf-8?B?UXhYYlVTdTUyZUwrMjM2YnMwc3E4bExyR0lMdXRoV3BWUEZ0ZnlTOWNvNVpM?=
 =?utf-8?B?VW9zMGpMNjkwcUsvaDVrSndnR1dHMG1QYVlIa0F0ZHg1RDVrbmdEWDkvT0tQ?=
 =?utf-8?B?ZkkxQUxMWktsb0VkOTdUVXM5QkpiT1VQQjNzME5Rc0FhTWxaRWM4MEZ3U0lN?=
 =?utf-8?B?cFg0a21sRFN1UjBCSG1Td2o5SVlZaHFoYVdESTNlOFk0Q21sVnJiV1dxMjhY?=
 =?utf-8?B?Sksvbzl0TSthTlcxaUsvVGYyWHNSYmpPQlpubWpmYnQ0dDJiMkVpc3B0QVlU?=
 =?utf-8?B?VlhJVWRMeE00cXpCVjFtODdqVGt2eGxuRzVhMTlYTXNIeTdWK0hQTks5TU1v?=
 =?utf-8?B?R0RtU20xMGdlS0VjclU1STlNVzJsZVZPOWdTVHFna1hxR2lDcVNRNi9MaFhh?=
 =?utf-8?B?YWF5KzZ0emF5U0ZucDN0WXZWTzlXM1VaSE11VnFEN2x1RG96NXpRRUpNeU40?=
 =?utf-8?B?M09xTmljWW5oZENXZVlZZ2trRHdWMXl4R0d1aXZhaG8yY3lQalNmU3B5SS9a?=
 =?utf-8?B?STdwVnhWTDVmbjV6VjhxNjJLb1RlZWFhak93YnB6Q1MrYi8yRkg3alA5cHNk?=
 =?utf-8?B?SEVkcGt5SFpGMlJIWkxBWi9xbE5TZ3E0UlZGV3NuZUtrZ3JISlIzQ21oeU5Q?=
 =?utf-8?B?UTRsS1o1WjJ2czNBZTZ1c2UvL1REdTh4MFdXYnpuc2R2Z213dGd1MlI0bEgw?=
 =?utf-8?B?YnV1YU9UVEhKcW01dHQrS2JYSGQvUnpjR216N1lrSG9lNG5aRysrSDl5ZDlC?=
 =?utf-8?B?T3dHUGVDTEtIWWgxNUt2azErNWVFSWpyS3NoWWEvaWdqdm0zVWkxdFhscUV6?=
 =?utf-8?B?TUwzd2ZaTkF6cXRzRnJBMkdBcCtPQWxINGkrWDZqa0JrSUlseDBxTEVBQmFQ?=
 =?utf-8?B?NkQ1L0VXZ0orZTBmblhpaXVLUHNqZXhqU0p0ZGQ2QVcvTW4zZWdrOWswd0sz?=
 =?utf-8?B?MTA0Y3JLVk53QndMN1lRc1ZGZVNoQUpiOWIyK2Zsc3pxZDFsaHRtREFrNVNa?=
 =?utf-8?B?UkVndnlKMEdyeFBBSGFuUTJHUzd3aXVCMHVGZGJCQllwRXJmOEt4Rmw1YnNR?=
 =?utf-8?B?ZlFBUE1qRUw3czcrRytYM1Uzd29zQTlMSmF5Ulo0NWJDblY0MURQSFJ4cCsr?=
 =?utf-8?B?WWptYUl0UHdta3RXUlRKR2VqN25KMXVrbU1PT05kV0IzZGlIU2JQdE4rcklZ?=
 =?utf-8?Q?rBIJiNYOByTwJCCjlJTSpj8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a73db1a-f987-4417-e500-08d9d57062f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 02:08:12.0616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JUjd53S16KnUPVBgJVYUAs3cyVMEMpKuJIHJhLiaqHPDl+pkUv6kn6ZrQrCESbqdaeuhHi1TVXbw3wRuuRLGAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
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
Cc: "Zhuo, Qingqing
 \(Lillian\)" <Qingqing.Zhuo@amd.com>, Scott Bruce <smbruce@gmail.com>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 Chris Hixon <linux-kernel-bugs@hixontech.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBCZXJ0IEthcndhdHpraSA8c3Bhc3N3b2xmQHdlYi5kZT4NCj4gU2VudDogVHVlc2Rh
eSwgSmFudWFyeSAxMSwgMjAyMiAxOToxMg0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCj4gQ2M6IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNv
bT47IEthemxhdXNrYXMsIE5pY2hvbGFzDQo+IDxOaWNob2xhcy5LYXpsYXVza2FzQGFtZC5jb20+
OyBaaHVvLCBRaW5ncWluZyAoTGlsbGlhbikNCj4gPFFpbmdxaW5nLlpodW9AYW1kLmNvbT47IFNj
b3R0IEJydWNlIDxzbWJydWNlQGdtYWlsLmNvbT47IENocmlzIEhpeG9uDQo+IDxsaW51eC1rZXJu
ZWwtYnVnc0BoaXhvbnRlY2guY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjVdIGRybS9hbWQvZGlz
cGxheTogUmV2ZXJ0IFcvQSBmb3IgaGFyZCBoYW5ncyBvbg0KPiBEQ04yMC9EQ04yMQ0KPiANCj4g
SSBqdXN0IHRlc3RlZCBwYXRjaCB2NSBhcHBsaWVkIHRvIGFtZC1zdGFnaW5nLWRybS1uZXh0ICh3
aXRoIEhFQUQNCj4gMjZjOTgxZTI3ZTY5OGMyNTFlZjMyNDFmNzNhYzg0NmU2NmFkN2ZjMykgYW5k
IHN1c3BlbmQgYW5kIHJlc3VtZSB3b3JrDQo+IGZpbmUuIEJ1dCBhcyBhbWQtc3RhZ2luZy1kcm0t
bmV4dCBpcyBzdGlsbCBiYXNlZCBvbiBsaW51eC01LjEzIEkgaGFkIHRvDQo+IHJlcGxhY2UgdGhl
IG1lZGlhdGVrIHdsYW4gZHJpdmVyIGJ5IHRoZSB2ZXJzaW9uIGZyb20gbGludXgtNS4xNi4NCg0K
RllJIGl0IHNob3VsZCBsaWtlbHkgY2hlcnJ5IHBpY2sgdG8gNS4xNiB0b28gaWYgaXQncyBlYXNp
ZXIgdG8gdGVzdCB0aGVyZS4NCkkgd2FzIGFibGUgdG8gY2hlcnJ5LXBpY2sgdG8gcmM4IG5vIHBy
b2JsZW0uDQoNCklmIHlvdSBjYW4gcGxlYXNlIHRyeSBhbnkgZGlzcGxheSBob3RwbHVnZ2luZyB0
byBtYWtlIHN1cmUgaG90cGx1Z3MgZG9u4oCZdA0KY2F1c2UgcHJvYmxlbXMgZm9yIHlvdSBhcyB3
ZWxsIGZlZWwgY29tZm9ydGFibGUgdG8gYWRkIGEgVGVzdGVkLWJ5IHRhZy4NCg0KVGhhbmtzLA0K
