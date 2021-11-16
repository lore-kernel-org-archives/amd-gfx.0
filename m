Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F8AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 08:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDB561B4C
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 08:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6DDB561B4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2FDA6F3FE;
	Tue, 16 Nov 2021 08:47:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A536F3FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 08:47:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YALEhh6UwlA2GJc/qZziUFick+DBb6JeGxCiLt5bj+/VnLefF6xtyKf8XptPPN+rYZRDsuPBM7glXsKr7j2L+BoxG1B+g1THPM0hn3R2RAxObZGPzm4jwj5Od9pSc6ybDDs+XjwKGZGw7X/yv0ABSJzyFYIub3gpjRJ6t6dIZlwqs3vht++zxQojpLrexzRQ7GawGtAB9K9ZypSuYk/xTLfY61G5SaSj6N0wzAKxNugLXURnLRYo5m5SIn/b+n5NxH12ltOrigKwEG5UiwetrAqmihX8nFDRwFOMkGLZ+aPB2uv7MxYx0HdqMC7WHCv6xVE4bagTpdM4m6Kv1fvG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg28sNlrSNgRqOhnb2AIWHbahz+TOYSyn56NCho72m0=;
 b=Ov6rouhE0HVfYeuJvSb3jMe/l3I8PQ7O0AtLfMzjl0kcehZQXf5b//Wr7rdmxqBOnDla1XGqonaJ4ZJhQdqYiaLBlJPOqJAOa9F8wAzQ4A9abHxAafokCHhhH8zBbQmfVsWtGM1S/b3Wyk5TLm/570ziGOAoeVb2SvqURQzHxwCLEatuN2J+q+spIPssADSSrcHLus4Fz7hYQrx06Z+GQjcJ6g/0fkXRzv5KVXwmTFp5Qq0ajIRrz7RnvdkRaxAOSE+4NC7oaWbEnbjkfwhjDsSvqhTZqPLPky8Ea1fo9bouTDPsF0DhTml5tD2AN01mYC+cOE0bxzgmik6jyQTaww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg28sNlrSNgRqOhnb2AIWHbahz+TOYSyn56NCho72m0=;
 b=1AvG/JigA0S5gjNqQoxEOuRll/Jiy9ljjCY4idX/bsWhSZ45H1VOoMMHhZ4dwmB0vnNLrPZZ8m5PsLufCnhYahe+CJR5MvL1ZkjJA7fWMruCCIb/0aBkBPSfDepMoFD+t0Ccpmv1p4L0zfFmEzMMVOD6X+oWpNLnn6qebiDy+ig=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB4825.namprd12.prod.outlook.com (2603:10b6:5:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Tue, 16 Nov
 2021 08:47:26 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::a530:22e9:332c:532d]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::a530:22e9:332c:532d%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 08:47:26 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: support new mode-1 reset interface
Thread-Topic: [PATCH] drm/amdgpu: support new mode-1 reset interface
Thread-Index: AQHX2rrnZUASiHOW0Umanjf78p3a4awFxgmAgAAPmCA=
Date: Tue, 16 Nov 2021 08:47:25 +0000
Message-ID: <DM6PR12MB46504CA4EDBDF823266985DCB0999@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20211116072337.29600-1-tao.zhou1@amd.com>
 <d7384968-1a5c-bb76-2b5b-010f42fe65c2@amd.com>
In-Reply-To: <d7384968-1a5c-bb76-2b5b-010f42fe65c2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=256bcdab-a26e-47dd-81fd-699b609b8d5e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-16T08:40:01Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d0f05d7-f867-44df-2d39-08d9a8ddb6f0
x-ms-traffictypediagnostic: DM6PR12MB4825:
x-microsoft-antispam-prvs: <DM6PR12MB48254C56AE4B3D0C682CE7ACB0999@DM6PR12MB4825.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QWBnbUQqG1jLTZTF56MJ4jGDHeYlUSnBVhvNcs1c5py8qnemUcEOzrRdzp5qiveb5X6iW2xRbitlq1rS2bn5kwzAVV1r9hZxAZ/H50id1qjf9uEahquI86kpalKwqZJz4JhdqPGFptLphWXJKAZZzHD5garMGjHLSAt9qWZX1ELRnWfySmc9zJJf0A7yzhlt7V+3qIxeVheTeswoc8ds4vu5EPjwuK53MDejeRwaEx9TYQ5jS2tYs/iOfx55cVKw/sMHcCBksWOAtDIzlN8i3HkJsuCaaV95FE7+Q3KaRhO8X1ulF3oqsgapX10/P6VKBCha0jEivy/ZG7rLlGzymEklGr7r3Jo5We3omqrn+Wvi9EpUdSjPhYPjoXUiJpMGkNZr+tryWWG7RWXq8EF6oo1W/MwqKyqTW0aQAHtGutcybfyO2Ryxb+uun8pKCsOFCHBmVtkk5L0ldbMlp3xYIRik1UnSIPNGtgAJkmVf+M7x2zRgdGIGYDPlFI3yhkMqCRedcdE9eQjbS7RualFw/Mnmg7My12Py2qp9iK41a6RI4ErUjXUqscLUGhnNfmUG5vX0BKiO8s9A3N6YjO2l4Y3gqZ22rcIpiPb8/yxB4JYPKZkY5EHzJRKXU8o1QDhqeRuUq+jgB9A6AaIZqOr/55zE3lNC95GqYmgajZYuuPpo9gXdDo2P7qhho80KWvv45YnopbacWGzBIS+Ylz5ty+OjEZ0/jm/81U0rVTNT8SJQOqOKw1j+FEWyZgf6ucVh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(7696005)(122000001)(110136005)(66556008)(5660300002)(921005)(66476007)(26005)(33656002)(53546011)(6506007)(71200400001)(52536014)(86362001)(66946007)(76116006)(38100700002)(8676002)(66446008)(64756008)(2906002)(6636002)(8936002)(38070700005)(508600001)(9686003)(55016002)(186003)(83380400001)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sjd3NGVZWFUwbWdIWi9tUXg2aWp3MkhyL3lhV2puS0RuczJpcTY4b3puVmxx?=
 =?utf-8?B?dkt3akRnY09VTjlMYnRoK2hMY1o4UDdIZVEwNmE1R29SaVkyUHRxbkNEMitt?=
 =?utf-8?B?SEtWWHFNMkl2VWw2aFIzZTFLY2IyWVdpZ1c1VFVTVlRvalgvdnBURGZnQUp5?=
 =?utf-8?B?bVd5OEs0QWNRTzNwaHRKT0lMbGR0S0ZJZmNGaHpCWkI0UU94MjBKN3k0MXZG?=
 =?utf-8?B?cGc1R1duWDRwQUJYWlM0d0dlWXVPcmNTUlRRTjZpZVlzc1pxd3ZRU2tNanlx?=
 =?utf-8?B?aENocUFEZ0hScWNKNVJoWU1lZVJvRHBzL1FmNmVhRDZHMGlkeWtyaGlJWXJn?=
 =?utf-8?B?UWhJdjFEV2dkMnRLdXo3NnBrQVJnQVhtVTF2UFE0SDgyZTlPRUhlOWtMTDlP?=
 =?utf-8?B?ODFvMTkyRHJzWkRTZmpxYnl2THJ0MFE1WVdTS2lKQlRyczhZdGhBTHBsV082?=
 =?utf-8?B?M3VYNWgwcTBrWllzRG9sSzVqN21yRTRLOFdlU2wzcnNzRjV5cTNCTUpTb25M?=
 =?utf-8?B?TXZuWFg1QmNVdnFXRTFCNHkzNVNMMUMrU3RnVENmSld1Z3piTjNmUDN1UExS?=
 =?utf-8?B?THYvbkkwVzkrS1Qwa2xiVVAvS0haMys5ZFN2dW45dzJUSmt4UktxOWdFMjQr?=
 =?utf-8?B?UWJ1MzhRMFBYVk11RCs2aTRUclprajh5cS82WVVFelkwazBydXpKQThqSTFL?=
 =?utf-8?B?Y0x2SXJZWEhsQ2IyTEdSc003R3VmWnkwK2N0MFZyaXkwenY2WW84NVg4RDBv?=
 =?utf-8?B?ZzZtWi9la2pHb3pOUFViaHJJM0VFeGlpdHMzcUhDaWxDUlJpaVlKMzU5MjRM?=
 =?utf-8?B?NUd4dy84WWF1eUtXdlBjVi9DM3JwVGNBNUZnc2FBZEY3alZEVm5jbUEySjhk?=
 =?utf-8?B?S29Qd0N6MUxKejBWOGUxckV0MmtRWElRNkthNTFFMTlZNXJaSW14bnc5L3Zq?=
 =?utf-8?B?UGlVUDUvYW9Xd093dUlPMFdXMnNVS2Y2cktoMlVuV2x4eDhVMXdFL1dySHUv?=
 =?utf-8?B?bHpLZVprUHNBQzRJelFXOXlZNU91ZjZxeGIvMHd1MHBXZUd3WjRweGFabVFF?=
 =?utf-8?B?LzVKWVNickhMaVdZZjZiZGUvSTBWRDY5M2lFODVqN00weXU1Y25TbXkyeG5j?=
 =?utf-8?B?WmRZK0hYNW5RS0h2SGlYNXE2Y2oxUnRVQm5jUFg2eEpPVlJSbkk1YnlLdzlK?=
 =?utf-8?B?R21memdpUlovN1lOdWVhSkE3Y2xiN0RjTDhvOG8vNHdpWnhGOGsyM3hXQ25w?=
 =?utf-8?B?dnR4bGRSTUJDTmVjWjN3YjF0Z3JuQTNVMmlHLzZQZ0RGTHJXdzFZZTZqT2Fi?=
 =?utf-8?B?bHBGSXVLbnU3RlgybWNueDBSL1d0RGVWQ3Q0QmFtWCtjL1lKZDhtS1RsNXhx?=
 =?utf-8?B?eG5VN1FVMHNHSHdGaUZIZDQ3WTM2dkR6c0UyMUlXZkIxc3dIWXZkRmpOcm9s?=
 =?utf-8?B?NGN0YzU5ZEFteEFlUk5mRHh6b21CdXZLUlF5YmtVSDltTTcrRHY3UkN2ZUFz?=
 =?utf-8?B?aWNqZStlcmVxSW1uNURDYUNBWldBSkZVN29hQi9aS1RXc1RBd3dhaXVLM3A5?=
 =?utf-8?B?U2FxbXpHN2MyM0ZhQ0JMMXlwcjd1L1dhZCtscFVDWnprZnBpOEhBdTc3UUZ4?=
 =?utf-8?B?T0hIZXFrMUFDMnErYmErdUF0eUpGY3l2V0Q0Wi9KMStUQ3FKNGxTVjJ4UUl3?=
 =?utf-8?B?K3dYdzhkSFo0Z0E2Y0daOTVYVkZqU2Z6aE82SUFxZm9ZalFuOStzM1MveTI5?=
 =?utf-8?B?ZmNqb2ZMYmdxS2RTSnA4MVljRFVvbTI2K3owZ29tMTRHdTdud0huaGk3ZG5z?=
 =?utf-8?B?SXJZbFR1dEt1d0JNMXkrT2g3QXRWRi9oWEZxUkIzcGxZNUlWMzBRY284bWo5?=
 =?utf-8?B?TVNrVml6SVUvaHJzN1AxTXF2QzVYWW9qWWpFb0RMVGNUenFYNWQ0TjN1eVFF?=
 =?utf-8?B?cU5IWjNqRDNhV0pzdEtsSzV6c2dCcUNhamVwYzZ0Vm9hSDVBZVZISTlHNzhs?=
 =?utf-8?B?L3BjeFRvYWZ1YmFNMU50ekl4c1RoNUpER0g1SjNLNFFVb3pTeXFud3UrcGdy?=
 =?utf-8?B?VTNtZ0hENjdNMmgxeG8zSkk1YW9SQUtoMU5SeG94eWJpWVNndTNLdnc3NjFm?=
 =?utf-8?Q?i5T0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0f05d7-f867-44df-2d39-08d9a8ddb6f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 08:47:25.8878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 17ybwRZCDMUfFS8wApOju1EqQCBLH2fvsGk5CDz+eWox2vNbk44GOPizpjnGd5rp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4825
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgTGlqbywNCg0KWW91ciBjb25jZXJuIGlzIHJl
YXNvbmFibGUsIGJ1dCBpbiBmYWN0IHNtdV92MTNfMF9tb2RlMV9yZXNldCBpcyB1c2VkIG9ubHkg
YnkgQUxERUJBUkFOIGN1cnJlbnRseS4gSSBhc3N1bWUgdGhlIFBNRlcgb2YgbmV3IHNtdSB2MTMg
QVNJQyBpbiB0aGUgZnV0dXJlIHdpbGwgZm9sbG93IHRoaXMgZGVzaWduLCBvdGhlcndpc2Ugd2Ug
Y291bGQgbW92ZSB0aGUgaW1wbGVtZW50YXRpb24gaW50byB4eHhfcHB0LmMuDQoNClJlZ2FyZHMs
DQpUYW8NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwgTGlq
byA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxNiwgMjAy
MSAzOjQ0IFBNDQo+IFRvOiBaaG91MSwgVGFvIDxUYW8uWmhvdTFAYW1kLmNvbT47IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywNCj4gSGF3a2luZyA8SGF3a2luZy5aaGFuZ0Bh
bWQuY29tPjsgQ2xlbWVudHMsIEpvaG4NCj4gPEpvaG4uQ2xlbWVudHNAYW1kLmNvbT47IFlhbmcs
IFN0YW5sZXkgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPjsgUXVhbiwNCj4gRXZhbiA8RXZhbi5RdWFu
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IHN1cHBvcnQgbmV3
IG1vZGUtMSByZXNldCBpbnRlcmZhY2UNCj4NCj4NCj4NCj4gT24gMTEvMTYvMjAyMSAxMjo1MyBQ
TSwgVGFvIFpob3Ugd3JvdGU6DQo+ID4gSWYgZ3B1IHJlc2V0IGlzIHRyaWdnZXJlZCBieSByYXMg
ZmF0YWwgZXJyb3IsIHRlbGwgaXQgdG8gc211IGluIG1vZGUtMQ0KPiA+IHJlc2V0IG1lc3NhZ2Uu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUYW8gWmhvdSA8dGFvLnpob3UxQGFtZC5jb20+DQo+
ID4gLS0tDQo+ID4gICAuLi4vZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wLmMg
ICAgfCAyMQ0KPiArKysrKysrKysrKysrKysrLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTgg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMC5jDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMC5jDQo+ID4gaW5kZXggMzUxNDVk
YjZlZWRmLi42ZjNkMDY0YTgyMzIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEzXzAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wLmMNCj4gPiBAQCAtMTQyNiwxNiArMTQyNiwzMSBA
QCBpbnQgc211X3YxM18wX3NldF9hemFsaWFfZDNfcG1lKHN0cnVjdA0KPiA+IHNtdV9jb250ZXh0
ICpzbXUpDQo+ID4NCj4gPiAgIGludCBzbXVfdjEzXzBfbW9kZTFfcmVzZXQoc3RydWN0IHNtdV9j
b250ZXh0ICpzbXUpDQo+ID4gICB7DQo+ID4gLSAgIHUzMiBzbXVfdmVyc2lvbjsNCj4gPiArICAg
dTMyIHNtdV92ZXJzaW9uLCBmYXRhbF9lcnIsIHBhcmFtOw0KPiA+ICAgICBpbnQgcmV0ID0gMDsN
Cj4gPiArICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBzbXUtPmFkZXY7DQo+ID4gKyAg
IHN0cnVjdCBhbWRncHVfcmFzICpyYXMgPSBhbWRncHVfcmFzX2dldF9jb250ZXh0KGFkZXYpOw0K
PiA+ICsNCj4gPiArICAgZmF0YWxfZXJyID0gMDsNCj4gPiArICAgcGFyYW0gPSBTTVVfUkVTRVRf
TU9ERV8xOw0KPiA+ICsNCj4gPiAgICAgLyoNCj4gPiAgICAgKiBQTSBGVyBzdXBwb3J0IFNNVV9N
U0dfR2Z4RGV2aWNlRHJpdmVyUmVzZXQgZnJvbSA2OC4wNw0KPiA+ICAgICAqLw0KPiA+ICAgICBz
bXVfY21uX2dldF9zbWNfdmVyc2lvbihzbXUsIE5VTEwsICZzbXVfdmVyc2lvbik7DQo+ID4gICAg
IGlmIChzbXVfdmVyc2lvbiA8IDB4MDA0NDA3MDApDQo+ID4gICAgICAgICAgICAgcmV0ID0gc211
X2Ntbl9zZW5kX3NtY19tc2coc211LCBTTVVfTVNHX01vZGUxUmVzZXQsDQo+IE5VTEwpOw0KPiA+
IC0gICBlbHNlDQo+ID4gLSAgICAgICAgICAgcmV0ID0gc211X2Ntbl9zZW5kX3NtY19tc2dfd2l0
aF9wYXJhbShzbXUsDQo+IFNNVV9NU0dfR2Z4RGV2aWNlRHJpdmVyUmVzZXQsIFNNVV9SRVNFVF9N
T0RFXzEsIE5VTEwpOw0KPiA+ICsgICBlbHNlIHsNCj4gPiArICAgICAgICAgICAvKiBmYXRhbCBl
cnJvciB0cmlnZ2VyZWQgYnkgcmFzLCBQTUZXIHN1cHBvcnRzIHRoZSBmbGFnDQo+ID4gKyAgICAg
ICAgICAgICAgZnJvbSA2OC40NC4wICovDQo+ID4gKyAgICAgICAgICAgaWYgKChzbXVfdmVyc2lv
biA+PSAweDAwNDQyYzAwKSAmJiByYXMgJiYNCj4gPiArICAgICAgICAgICAgICAgYXRvbWljX3Jl
YWQoJnJhcy0+aW5fcmVjb3ZlcnkpKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgZmF0YWxfZXJy
ID0gMTsNCj4gPiArDQo+DQo+ICBGcm9tIFBNRlcgdmVyc2lvbiwgdGhpcyBsb29rcyBzcGVjaWZp
YyB0byBhbGRlYmFyYW4uIFNpbmNlIHRoZXJlIGlzIHZlcnNpb24NCj4gY2hlY2sgYXMgd2VsbCwg
dGhlIGltcGxlbWVudGF0aW9uIG5lZWRzIHRvIGJlIG1vdmVkIHRvIGFsZGViYXJhbl9wcHQuYw0K
Pg0KPiBUaGFua3MsDQo+IExpam8NCj4NCj4gPiArICAgICAgICAgICBwYXJhbSB8PSAoZmF0YWxf
ZXJyIDw8IDE2KTsNCj4gPiArICAgICAgICAgICByZXQgPSBzbXVfY21uX3NlbmRfc21jX21zZ193
aXRoX3BhcmFtKHNtdSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBT
TVVfTVNHX0dmeERldmljZURyaXZlclJlc2V0LA0KPiBwYXJhbSwgTlVMTCk7DQo+ID4gKyAgIH0N
Cj4gPg0KPiA+ICAgICBpZiAoIXJldCkNCj4gPiAgICAgICAgICAgICBtc2xlZXAoU01VMTNfTU9E
RTFfUkVTRVRfV0FJVF9USU1FX0lOX01TKTsNCj4gPg0K
