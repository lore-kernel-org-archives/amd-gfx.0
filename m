Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84DAC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 09:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 384B910E7E0;
	Tue, 29 Mar 2022 09:17:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E24A10E4D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 09:17:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQe5rPWNzEnQRTMO1SBTZkEMSe77Xre2k1VqbDPlJcePWzU7Hu8p4PY7Mg6o9CAGb7lXlhuAj31aKLPoS4Ko6oNJl40mlSMdmv80wr6G0VgzvYvIYmtBAmajKeIIr0iOGfkTK3uHdrLbKAZ6WUN3OzBtds5bokRkg8MKtn1f2nKht6GTwuzZqYo7uh6ALPvGvLfSGqbDuDUWvWPfUfkZhIhQV5Y20wXAl4dMs9Klbaqr98crKLBlBnbqjPJQZLKyCwIlWNtM/PBBTFxqP/8ozSHkZrVdW0g/HtUBv2hgq33PQTynygwTtxLvtsWtRkMy0dF5JEqCrFlE+WzVuEPzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avC/ylgqp/m8UaxWU0ZGExKM9plwSOiU/YbS2GA9kNY=;
 b=m3ABD7EF65JG3YWtnAqGkUzuzFw3Nc5Z9c7X4IT8KIM5loCR0mL80iCZjIcXfY1XHNh0Fy/q+ZEsdRB5d1OZo29fUXY1eUA6vGLwQhPt13QDA+5lY2KA8gI4qIMHou7DywCV1glKoaVQYui9Da1GsuVyqXiXr4Z2jBmLULPUQejUv39fs1+cyXdg958GLxPNSLVGc2Dc8pxMGvyToY0EMnIArIA2OqtgCZNuh6/PpahYtBWDvU2qZldtO2+Hn/LPwHoERrTcPnPJJt8oq/bFgrWiLTD6XHeRn0a+vnGnAP2FTC8O65SAopjB+OoKTRSIHdVdgUBKi7sIltFxus/B3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avC/ylgqp/m8UaxWU0ZGExKM9plwSOiU/YbS2GA9kNY=;
 b=ii/724EFbZE3SYazaq13HqA5nIZKUVaneg9AFjyDCMHlTYSugAbHxMhPoEbiE9X+34EfTVQYpUkBSYlqEqMou/oK7xP4kMEzt9Qgzb+t7JNQDU36G5GrLXBOZNSaokDU28S0nQDvgofSPVqNOlgbk7/czBsJPuj1r/P4LdgVCuc=
Received: from MWHPR1201MB0079.namprd12.prod.outlook.com
 (2603:10b6:301:52::22) by DM6PR12MB4862.namprd12.prod.outlook.com
 (2603:10b6:5:1b7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 09:17:43 +0000
Received: from MWHPR1201MB0079.namprd12.prod.outlook.com
 ([fe80::78cc:dd3a:a314:34f7]) by MWHPR1201MB0079.namprd12.prod.outlook.com
 ([fe80::78cc:dd3a:a314:34f7%4]) with mapi id 15.20.5123.016; Tue, 29 Mar 2022
 09:17:40 +0000
From: "Ji, Ruili" <Ruili.Ji@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH V2] drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address
Thread-Topic: [PATCH V2] drm/amdgpu: fix incorrect GCR_GENERAL_CNTL address
Thread-Index: AQHYQmDLA91PZs/ix06fNazRq24B0qzWBcsAgAAPsXA=
Date: Tue, 29 Mar 2022 09:17:40 +0000
Message-ID: <MWHPR1201MB00791612FD34CFC916828CAE9B1E9@MWHPR1201MB0079.namprd12.prod.outlook.com>
References: <20220328045845.1986195-1-ruili.ji@amd.com>
 <1b99c19a-b2fd-5ad3-4313-eea56f42e369@molgen.mpg.de>
In-Reply-To: <1b99c19a-b2fd-5ad3-4313-eea56f42e369@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2ff8d5c7-c2d1-4fbb-9316-b6b49823ebae;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-29T09:12:31Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af7f6e14-ed91-4b0d-373b-08da1164f991
x-ms-traffictypediagnostic: DM6PR12MB4862:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4862C9B2EE438E3D5E92FE1F9B1E9@DM6PR12MB4862.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U2m1QlWv0ON2KLIUA5qx683DUtTe/K3R6cuWY2Rv2+h/zaODIbJuKIX7mVpj80BRTHZdBizJaxvhQaIKUFMM/i9Ly5T6KKmgXLEEP2h0pOn++YLsiSbU/h6H4cnTNKCORzg1OEs3ABsBM2zs13QKV2kvBWlmTsQlLEC/KRS5yQfORtgUla7KNUGiJS0SI8APaxaXeievEtipY3xGR33MeDLyJwITZsKpY39KU/l1USg1pddOtRddxKzDWZRCYweIulN+/CpH5XADegBlnKvEE1WERbswl7a386TSIwVQUp6KWDA5qxO4Dxut2otebAaV6NCTH5ScQn1VnIYmepm1HewHp9hqu2xgNIjc3FyJd/djT5M8w9sk35xEEIOrdV7KLsM8lFDozmyE+7G0wfnlOASWdyq2HnoNknwXtXBTZHsv751lO8rAnnlcxeMniGcEq5+RF/BaK73MIZAZ9+ayjQhtrQtaROIYbwVO0IEIpmV4JXPlpJTobcGjkFjRdh/XmZNokqiT0FisZW7zSQXd4U1WRGfsfm9toxvIHl7Ij4362bbZZsMYt5qN6rFB2fc8hT1A0dl/tmIWk1VYJ8Fx4UHWdUbaY41Zi+I3r45lTfwGPGq+T1tsTOm+e9ahA1jvVg1f/r9tSuYThVmB1pPaqYj3CwdcCqbpvvEqbrkYEsfNUBcyJcn6fnAbAyfdDJ02BqIWGQgN8Z9WEYB9G7hMhQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(52536014)(122000001)(33656002)(8936002)(2906002)(6916009)(38100700002)(38070700005)(53546011)(316002)(54906003)(26005)(9686003)(186003)(71200400001)(66446008)(7696005)(66476007)(508600001)(6506007)(4326008)(64756008)(8676002)(66946007)(66556008)(76116006)(83380400001)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTFEOHNiUzJUb3dkU3ZSVDNIb0tIaWR4VFhZazJFU1FqbkFpL29vNHJ0bFpT?=
 =?utf-8?B?NXM4UGpCVUlhMVluOWJmL3psRzUyZDc1NmFCNDdLQkpueVhyRjVIS1MyWWMx?=
 =?utf-8?B?VzFUTVF3bUVkRnV3b2o2TVc4cWI4Z256NWxpNXkzYkpEYkFKLzhBaXlsRUNs?=
 =?utf-8?B?Z2pMa095UGY3Q3RhcjRNY3dXRDRSQVNTMHlaY0l6OFF3anRkRWZhUy9RdkFE?=
 =?utf-8?B?c2RicVZBVjJhaVdyZGZETUN2bHZDM2xBSzIvMFZnSGRRK3gvQUxtcmh5c3Fa?=
 =?utf-8?B?aFBCS3NCQ3h4ZjNPbHlHUHlRbWc1T3FaWXdVelJ4MXdxUi91VDVvcldLWldV?=
 =?utf-8?B?UnVXOTlNbEZmUnA4K0h4R3Yrdkc0Y1psTEI2dWExdkw2c3NUWmxocDJTNnNi?=
 =?utf-8?B?S1NmNXpNZzB3eE9HU2RZUnlGbXZRWFIxQUxDUStrUUdsRUNzYkFHOENzNit1?=
 =?utf-8?B?WXFaUHhRd1R5Z1QxS293VkZWdStHc2o4bU1IRVdqYjgwbEdFNDVCR21TeVRU?=
 =?utf-8?B?cjBjQmlzdUp6QVVjL01hUmozNmVMN2FkSisyemtBa2daeGYvRXZseThGVWJz?=
 =?utf-8?B?emlheVg0ZGVWS2ZMNXZWSEZPOEpoNjhnM1B5K04zQzNDMFNURGFLbWl0MWsv?=
 =?utf-8?B?YmpVelA4bVNuY3RLZW0yb2ZhK3BXZzRMVkNUc1VscU44Sk5nOGRoTzJrVmdO?=
 =?utf-8?B?aTM0YWY0a28xUHM1dGg0aUpzRlVsSWFSb2N3WU1MMjJmOWY0VkZBY052ZlJu?=
 =?utf-8?B?Y1pYSDhmZDFTTHp3RmFUc3NFb0wwZFQ4MDJRamQvQUdub3ZYUGQ3QjNyUFZQ?=
 =?utf-8?B?VlUwL1h0cDQwMXFBUnRvYlowUXU3THhoazR6N3hXNVloK3NZcGoxUDNTaWd0?=
 =?utf-8?B?S2sydjAvbnBMeGdtOGxkbis3RFk3c0RrMDExOGIxV1UzUCs0aXlBbUJXeGtO?=
 =?utf-8?B?VVFSUENjK09oL1lYRVM4ajJqbnh3UEZxQUpXblpjNlpWS0xHWTFlSTl0bjUz?=
 =?utf-8?B?U0JETlpwQmhtT0NNT2VhWTlZSzBkV2JLYTZqYTV6RHBNZ0ttdVBERWVIVE1r?=
 =?utf-8?B?THM5SW00bkJhM0lFV05qeWtWN3BlaCt1Rnp6dzkzTE45aVpyd1FYRUxCM2sr?=
 =?utf-8?B?K3IvczI4M2VoNEtZSTFzdjlWQ3BzUDVxRVJSdXFZQkV5VzZDU1dIbXAxSjdK?=
 =?utf-8?B?NnRsUmhZeCsxdGJwTER3YlFuaGxkemNYUlI0dkErc3BOYnFXczlxZ05ITVp3?=
 =?utf-8?B?Umh3TU5IQ0lGUVdheit4TllBSWRjTDBQTi82SUhlUlcxMExKbE1DcXJ5NnZn?=
 =?utf-8?B?MnhMdUgxRXl1Qnh5QkJFUkQ2TC9qYk02NGp6bnZ0TzJHanJ6ZFRsWCsyUWs2?=
 =?utf-8?B?RW4wcGduMTJVMjJEL1ZJaDFkZWdIazFCT01IcFV4TjRFQXV1aDVtUXMzNmx5?=
 =?utf-8?B?YVpvZzZpM0tlR2hTRm9URVRMZkdhc3oyUFJESUtUTUc0QWhydlBzbXF4R0FP?=
 =?utf-8?B?VmtIUHMzSXRVaXNJMEhuZkp2RlVrZjJqVm5GSXNoQVRTcU12c2pmOHNrSkFi?=
 =?utf-8?B?VzZjTUNoeFhabjZtQzBxVG1YZmlYUEdtcFk0WWdjZ2IxckxmUGV0L1FvQ2RC?=
 =?utf-8?B?V0x6ZTB0dE8yVVJGTlBkZmJCVEZEdEZhbkVNdDJhS2tNc093aWlXSDRJWVRy?=
 =?utf-8?B?MmNobHU3ZUF2SDduZkZnTkQvbllXSGREclZSZTZDeU83NkF5NWpBYjJSZ2da?=
 =?utf-8?B?T2d4M1RQZlVhd1cvTW1YK2hwYy9EbjIzWnJSNGhSYjF5RWF1UW5mMlBrYUlP?=
 =?utf-8?B?UzZUTFNSbWlmYWlGNUxtV3dMSTR5eVhSZnpsaTBKS1dIdUxXazdIU2ttdjhv?=
 =?utf-8?B?dEhpVDZZV2gybFh2ekZoQ2Q0WlQwcmVmMkgxMGhpWGZsQVkwTThJWkhJUERR?=
 =?utf-8?B?blQ3UjVPN2dodGJrUStMaDJWRVBmMGhqOUZNbHlSK2lxZnFvWm5UczhMTEtQ?=
 =?utf-8?B?aE8yRnhKNldBNkNIYkRqUmRWNHNwcngrSjY3WHFTNEd1QzdsQkxMRWcwNkNl?=
 =?utf-8?B?ODdVN0UrZ3BMK3o2Y3J6b2FheDJNRFkzQjNtWHVDVmlDeEJNQVdHbEpVSHdG?=
 =?utf-8?B?MHJsM084akRPWFYydTVFYjN5QnN6d3RiejF1Z3ZWWWwvWllxYjhCNEw3amxx?=
 =?utf-8?B?TXVsWjczNVRrR1hxMmt1aDZrWVlxeUVwK3FZZ2NrSTh1MFBmSFpudVVacW40?=
 =?utf-8?B?NHdVb2hRTFd1WWsxM3V2dFdLVHk1WFk4eDZaUnUweE5uaTB3TDMyeTVwZ0tN?=
 =?utf-8?B?a3ZYSWVnZnc3TVhEYkpOaGdaNCthdlk4SFY5OS9NeHg5MndtWHNodz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7f6e14-ed91-4b0d-373b-08da1164f991
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 09:17:40.2167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxYU6hxg/IcM9mcHHLvYSyAzBMuED1Cze4cA1k6nWhzZPw8tPGdawYOpmE6mxSwGI0zjkUQ9wF2eKi9e5C+Bmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liang, 
 Prike" <Prike.Liang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSGkgUGF1bCwNCg0KVGhpcyBpcyBub3QgcmVsYXRl
ZCB0byBhbnkgaXNzdWUuDQoNCktpbmQgcmVnYXJkcywNClJ1aWxpDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0K
U2VudDogMjAyMuW5tDPmnIgyOeaXpSAxNjoxNg0KVG86IEppLCBSdWlsaSA8UnVpbGkuSmlAYW1k
LmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWmhhbmcsIFlpZmFuIDxZ
aWZhbjEuWmhhbmdAYW1kLmNvbT47IExpdSwgQWFyb24gPEFhcm9uLkxpdUBhbWQuY29tPjsgTGlh
bmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFt
ZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBK
aSwgUnVpbGkgPFJ1aWxpLkppQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBkcm0v
YW1kZ3B1OiBmaXggaW5jb3JyZWN0IEdDUl9HRU5FUkFMX0NOVEwgYWRkcmVzcw0KDQpbQ0FVVElP
TjogRXh0ZXJuYWwgRW1haWxdDQoNCkRlYXIgUnVpbGksDQoNCg0KVGhhbmsgeW91IGZvciB5b3Vy
IHBhdGNoLg0KDQpBbSAyOC4wMy4yMiB1bSAwNjo1OCBzY2hyaWViIEppLCBSdWlsaToNCj4gRnJv
bTogUnVpbGkgSmkgPHJ1aWxpamkyQGFtZC5jb20+DQo+DQo+IGdmeDEwLjMuMy9nZngxMC4zLjYv
Z2Z4MTAuMy43IHNoYWxsIHVzZSAweDE1ODAgYWRkcmVzcyBmb3INCj4gR0NSX0dFTkVSQUxfQ05U
TA0KDQpJcyBhbnkg4oCcdXNlci12aXNpYmxl4oCcIHByb2JsZW0gZml4ZWQgYnkgdGhpcz8NCg0K
UGxlYXNlIGFkZCBhIEZpeGVzIHRhZy4NCg0KDQpLaW5kIHJlZ2FyZHMsDQoNClBhdWwNCg0KDQo+
IFNpZ25lZC1vZmYtYnk6IFJ1aWxpIEppIDxydWlsaWppMkBhbWQuY29tPg0KPiAtLS0NCj4gICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDYgKysrLS0tDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMNCj4gaW5kZXggOTlkZjE4YWU3MzE2Li5l
NGM5ZDkyYWMzODEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92MTBfMC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5j
DQo+IEBAIC0zMzAwLDcgKzMzMDAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNvYzE1X3JlZ19n
b2xkZW4gZ29sZGVuX3NldHRpbmdzX2djXzEwXzNfM1tdID0NCj4gICAgICAgU09DMTVfUkVHX0dP
TERFTl9WQUxVRShHQywgMCwgbW1EQl9ERUJVRzMsIDB4ZmZmZmZmZmYsIDB4MDAwMDAyODApLA0K
PiAgICAgICBTT0MxNV9SRUdfR09MREVOX1ZBTFVFKEdDLCAwLCBtbURCX0RFQlVHNCwgMHhmZmZm
ZmZmZiwgMHgwMDgwMDAwMCksDQo+ICAgICAgIFNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0MsIDAs
IG1tR0JfQUREUl9DT05GSUcsIDB4MGMxODA3ZmYsIDB4MDAwMDAyNDIpLA0KPiAtICAgICBTT0Mx
NV9SRUdfR09MREVOX1ZBTFVFKEdDLCAwLCBtbUdDUl9HRU5FUkFMX0NOVEwsIDB4MWZmMWZmZmYs
IDB4MDAwMDA1MDApLA0KPiArICAgICBTT0MxNV9SRUdfR09MREVOX1ZBTFVFKEdDLCAwLCBtbUdD
Ul9HRU5FUkFMX0NOVExfVmFuZ29naCwNCj4gKyAweDFmZjFmZmZmLCAweDAwMDAwNTAwKSwNCj4g
ICAgICAgU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1HTDFfUElQRV9TVEVFUiwgMHgw
MDAwMDBmZiwgMHgwMDAwMDBlNCksDQo+ICAgICAgIFNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0Ms
IDAsIG1tR0wyX1BJUEVfU1RFRVJfMCwgMHg3Nzc3Nzc3NywgMHgzMjEwMzIxMCksDQo+ICAgICAg
IFNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0MsIDAsIG1tR0wyX1BJUEVfU1RFRVJfMSwgMHg3Nzc3
Nzc3NywNCj4gMHgzMjEwMzIxMCksIEBAIC0zNDM2LDcgKzM0MzYsNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHNvYzE1X3JlZ19nb2xkZW4gZ29sZGVuX3NldHRpbmdzX2djXzEwXzNfNltdID0NCj4g
ICAgICAgU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1EQl9ERUJVRzMsIDB4ZmZmZmZm
ZmYsIDB4MDAwMDAyODApLA0KPiAgICAgICBTT0MxNV9SRUdfR09MREVOX1ZBTFVFKEdDLCAwLCBt
bURCX0RFQlVHNCwgMHhmZmZmZmZmZiwgMHgwMDgwMDAwMCksDQo+ICAgICAgIFNPQzE1X1JFR19H
T0xERU5fVkFMVUUoR0MsIDAsIG1tR0JfQUREUl9DT05GSUcsIDB4MGMxODA3ZmYsIDB4MDAwMDAw
NDIpLA0KPiAtICAgICBTT0MxNV9SRUdfR09MREVOX1ZBTFVFKEdDLCAwLCBtbUdDUl9HRU5FUkFM
X0NOVEwsIDB4MWZmMWZmZmYsIDB4MDAwMDA1MDApLA0KPiArICAgICBTT0MxNV9SRUdfR09MREVO
X1ZBTFVFKEdDLCAwLCBtbUdDUl9HRU5FUkFMX0NOVExfVmFuZ29naCwNCj4gKyAweDFmZjFmZmZm
LCAweDAwMDAwNTAwKSwNCj4gICAgICAgU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1H
TDFfUElQRV9TVEVFUiwgMHgwMDAwMDBmZiwgMHgwMDAwMDA0NCksDQo+ICAgICAgIFNPQzE1X1JF
R19HT0xERU5fVkFMVUUoR0MsIDAsIG1tR0wyX1BJUEVfU1RFRVJfMCwgMHg3Nzc3Nzc3NywgMHgz
MjEwMzIxMCksDQo+ICAgICAgIFNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0MsIDAsIG1tR0wyX1BJ
UEVfU1RFRVJfMSwgMHg3Nzc3Nzc3NywNCj4gMHgzMjEwMzIxMCksIEBAIC0zNDYxLDcgKzM0NjEs
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNvYzE1X3JlZ19nb2xkZW4gZ29sZGVuX3NldHRpbmdz
X2djXzEwXzNfN1tdID0gew0KPiAgICAgICBTT0MxNV9SRUdfR09MREVOX1ZBTFVFKEdDLCAwLCBt
bURCX0RFQlVHMywgMHhmZmZmZmZmZiwgMHgwMDAwMDI4MCksDQo+ICAgICAgIFNPQzE1X1JFR19H
T0xERU5fVkFMVUUoR0MsIDAsIG1tREJfREVCVUc0LCAweGZmZmZmZmZmLCAweDAwODAwMDAwKSwN
Cj4gICAgICAgU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1HQl9BRERSX0NPTkZJRywg
MHgwYzE4MDdmZiwgMHgwMDAwMDA0MSksDQo+IC0gICAgIFNPQzE1X1JFR19HT0xERU5fVkFMVUUo
R0MsIDAsIG1tR0NSX0dFTkVSQUxfQ05UTCwgMHgxZmYxZmZmZiwgMHgwMDAwMDUwMCksDQo+ICsg
ICAgIFNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0MsIDAsIG1tR0NSX0dFTkVSQUxfQ05UTF9WYW5n
b2doLA0KPiArIDB4MWZmMWZmZmYsIDB4MDAwMDA1MDApLA0KPiAgICAgICBTT0MxNV9SRUdfR09M
REVOX1ZBTFVFKEdDLCAwLCBtbUdMMV9QSVBFX1NURUVSLCAweDAwMDAwMGZmLCAweDAwMDAwMGU0
KSwNCj4gICAgICAgU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1HTDJfUElQRV9TVEVF
Ul8wLCAweDc3Nzc3Nzc3LCAweDMyMTAzMjEwKSwNCj4gICAgICAgU09DMTVfUkVHX0dPTERFTl9W
QUxVRShHQywgMCwgbW1HTDJfUElQRV9TVEVFUl8xLCAweDc3Nzc3Nzc3LA0KPiAweDMyMTAzMjEw
KSwNCg==
