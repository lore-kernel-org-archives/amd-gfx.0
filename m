Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08B8C77B7E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 15:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DEC010E236;
	Thu,  1 Jun 2023 15:33:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DF2810E23C
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 15:33:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKbm2ClZN4ERC/rt7SvmFZ1e0rG9zQbvhP7j8w/UrUjUK54j13ak2bqL20x5iwIcIm4wZgAIsv2lavqRqKNuhmt9guV0MwhbwBS77uTH6cBW8cFETLfrQCXn3CGkrzbhHG88RUEBrUijqNy+Z6o5gL7KaOk/RCnvCwFNIF5dAtfk6Y1Qjp++ky+/U1q+cd8RZFxZCKomAPFZ1rjtel/WEd+aHkFrV//aiQAKULjNTXGMXc8R6TKIajJ41R4JQCzpWqkKWMadSs/qRMVB8uLMFIF1ypQAPZoQgwXKPuhTAw2QTyFs9G8jGpU9DFvsuWvDEUSOrW4LvJ+CmD0xTCAkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ib02hRJDclQuPCkpaHnykGKADcd5oukp8AFH2ui1dyc=;
 b=YMCGRzcF7YcYUlBufqXfVPsPewLUFyWP8lwSFHFchjkck/rvaBsMV/WxD8nktnn6ZNMNU5KyBfQZouatHDhPHxbUduKRcm6AYKZsCanrZNrJ9sQ/F6MKVYlAI5AwBl7EUbotcPpWvu7fjMH/yFj70TC5HAk9oaDjnpIZeKYeCtQ9Tj1E1Y6rAJKeBCxQRJ/bTx1+vV8P30BicL0W56Vy8rXkptH6gZEk0OeooeQ9t/zZ1yg+tuc9LL3RiyPZpiA9Xe7VyyWJotqaCUeBvfMxbJcOylSyEED0AoelufZge1sFsebuCuLU3kZztWljFEStOUnR4OBVBAMRtzRWi+dfUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib02hRJDclQuPCkpaHnykGKADcd5oukp8AFH2ui1dyc=;
 b=QqMYGQJiHpU1DZmGuJOsFyVkB67fDGDVmkN4uTHWO0a2o2/8v+QQHcnvNwlfIZPzPmw8MwkqMslmSG0BX8EtOouRg2Vq8pltDbRT+A+mPwQNYKMzFjdRaLjV5pfvu0l5xFsl+Lidrv4CjT8T7yKnfB/aHrOByidQ1NaGoDTuxqU=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV8PR12MB9261.namprd12.prod.outlook.com (2603:10b6:408:1ed::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 15:33:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 15:33:36 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH v2 1/2] drm/amd: Disallow s0ix without BIOS support again
Thread-Topic: [PATCH v2 1/2] drm/amd: Disallow s0ix without BIOS support again
Thread-Index: AQHZk0by55pnFViFU02apb6xRrle1K90YHIAgADpawCAAMuUQA==
Date: Thu, 1 Jun 2023 15:33:35 +0000
Message-ID: <MN0PR12MB610115263A4DEE12FCAB5D69E2499@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230530204848.231842-1-mario.limonciello@amd.com>
 <CADnq5_N64zscFAjTj2JtBGqyoZRUjazSrW75NGAJqPKWBXL68Q@mail.gmail.com>
 <CADnq5_McnF0W+zS0t+tShb0PH4bRLzRcPnSrWNryV06+0biYvg@mail.gmail.com>
In-Reply-To: <CADnq5_McnF0W+zS0t+tShb0PH4bRLzRcPnSrWNryV06+0biYvg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=da439e37-5fe3-4a0e-93e5-05d51d5b01d7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-01T15:30:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|LV8PR12MB9261:EE_
x-ms-office365-filtering-correlation-id: 06c4e3d1-776b-4dbb-63cf-08db62b590c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hn80E/AEWNgwzbvuifEeQt3KBM5RIwTBksy5i3iPwCOZbLNlNkDJsTlsIaUNuGmPWZ/YIOA4nP2ftW/Epz4ebCQi1LjLp6SIco4XxvNyLjpBW/HDf/JmGM5NQXHHRnuvKhCiy5o5nlbhPTtw3svJYjbH3Kw9FnoIskvVSxk7Iw4YlintSzMGOFHpZuMIe/uWZRYAq9YuanfRT+vSkNJNSjN41JC3O3y39+whPiA+8P59DUCGiSL1UXHtzrcSvnbbBMURfHIifp9AZjW2e00+obhzVhrf0HBUIVvYs53NoBsazV4BdFRpsSm6V1egPg2L9xXUIlucRoW61qFrkEv6PxnNCqVJ/l9hSO7+kVIVqTeVizkucKLz9OVsQ8g6GomRb07zSlGxpQIJK9O1BB5UBfoDUV6Iwc9f0fOW6dRG4gT1uOrnTnaJBZJzoAPvEnGEuoqBaAsg0UQvQXVXcQa6hkJ9MbZaRgKnrZpMPEMo3QTX5Fz1xDqviThs7PB+GXezYseXPne7abqOvjRZI+aBRvqkxz+0N24/WKCiUysb1pCN82hLKdQXIkfOyrb3auOPKKENMod8TDQqGv77g/S5hyBtxvdmill3QRBSAZkzec/uESPR1GeJzpz35IX9FpMm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(122000001)(38100700002)(86362001)(38070700005)(33656002)(8676002)(41300700001)(966005)(5660300002)(26005)(53546011)(6506007)(9686003)(52536014)(55016003)(66556008)(2906002)(186003)(66574015)(83380400001)(7696005)(71200400001)(316002)(76116006)(66946007)(66446008)(54906003)(478600001)(66476007)(8936002)(4326008)(6916009)(64756008)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk04cVdEVk9NclZMN2J4ZWtlMjhQT0NRWS9idHpSWlNaaXJzY3pSdmt5Ykp2?=
 =?utf-8?B?ZFVlc3R3NGtGTGEwRzYxWnNHRnN6dnBXa28wU2VJWXl6ekxmSE5PeDNVRWVw?=
 =?utf-8?B?VllNNEJyYXd1MnBaK054aks2Tzk5N1lEbU5OUGU3N3dsWE9yRlBvREY0U1Zu?=
 =?utf-8?B?UERTQi91ZitXajltbDR0NXdLWlc1MTI3YVVldHkrODZOOWgxc21jWFJWTG42?=
 =?utf-8?B?S1Zmc1h3c2FPNXFBb25vNVNBOE96THhGZExlU2ZyYXJ2TGFQNWdtdnlXMlpO?=
 =?utf-8?B?V1FDOHhXNjNKMUgrc2lTMWdJWU5SUEYvcDZ1ZVNLeVdRMHZLd3dwaFpSMDA0?=
 =?utf-8?B?aVpFM1VOQityRWFVTnNRbEpLaHpvclNNQ1AvcHQxdGhFOWlHQWNwMUhnOE5D?=
 =?utf-8?B?R0I5QkJHRnk3L3BBbm9zVWlXcTJGSElWbmFYTmU4TzV4c0ZHd3hYWVZWampu?=
 =?utf-8?B?c3Q3TWFQRk45YnNMa2lPd0FvUUNlcUxkZDRIRzVZTzd6YUVBbU1Pd2VxTmdy?=
 =?utf-8?B?dERXbUswUFVKdzEzNUI3Z1lmV09rNjJyU2d6ZEM2RWV3VXFZVEh2ZGdqWXkz?=
 =?utf-8?B?anowcHpVSW9nYkEvbXZVbXBJd0Y2cjdjS1Z1QVRuL0RsNjRXUDJlYldHN3I4?=
 =?utf-8?B?V051N05QVWk5M3pOeFFHSFRHbVdaaDVRSEphSTVkTnI5eGR3Mzg1MXNsNlJH?=
 =?utf-8?B?ejh5RnRQZnVEMVlDZzgzb1piRGFwSzg3SUNFak1Cbm1PdnY4TEkzNXRXenM2?=
 =?utf-8?B?VlFUcnV1N1FNVGFMbGYvQXFSbDl0dFBJb21GVWVsYjdYTlRDeEhJaGI1cE5w?=
 =?utf-8?B?d1dtL3hSTzlkNmdxQkhaSS9jaG54VWVpSTZvRnpOQTU0MHpITkhVUUdUQUFo?=
 =?utf-8?B?MDVSK2Mvb0pKQk9YUlFDTXI3ZzRiQWZQY05QNmxqYldib3BZSFgrVHJsbVhO?=
 =?utf-8?B?OGxGOGFsc1NjUkVIRGMySS9Bc3lkNVpRcXVQRlo4V0tsYmVTRDllUUlaNVls?=
 =?utf-8?B?aXVaM1AyODhubHZPYWdTbm9RUTNVaW0wam01VERiSm9TV0FpQVVKZHdJZStl?=
 =?utf-8?B?ZW5DY0o2RHBwUUtUU2l5NVg3VW1WR3JiOHM4b2NCNW83S0QyWFdESldBdVRV?=
 =?utf-8?B?WjBpSHVtdWpya3ZFanhLRWhCdFN1YWp1NXR0Q1hxbUpzWU93RzV5ZDkxWlls?=
 =?utf-8?B?eTk1cE9UOHRWZ2lEM2pwU1hjS2lhNzdFd3BhbFNGY1F6VTQ2ajgrMFAxMVQx?=
 =?utf-8?B?amV2MzIxQUpYYmM1OVBIYkh0dEM2OGpPdzZ4cy84MmFHWVNNTHBaT2ZJZEtN?=
 =?utf-8?B?MUZqYlduQWQxdHpEY1JOVTJONk1ud3I0ZU40VVhZbkxsWitoYmRwL2M4bFF3?=
 =?utf-8?B?c05QUEVaRXphMWg3aTF6Q1NET0tCakhRRjdmUE9FOUthNHRueUJBTXhSNGdV?=
 =?utf-8?B?djJGTEYwN3hNaC9VVXBzZDRrM3hFaUhmVDBZa3pIcVhYcVlZUW5qS2tlak44?=
 =?utf-8?B?WkcrODQ3MkhNb1gwR2NWQ0VublZRVmk3ZjlJYkdKTEtuWGFPdWZWTkFMMmk0?=
 =?utf-8?B?bG13MG9tcjNCZFBIWnk5TlY0UVBJZ1hTalh0bEg0TXJaeEpGUkJOTkk5cE1K?=
 =?utf-8?B?aG0rNGNrMkYrOWFvdG1RZXlBcm1lQi9QZk9UaFE0UkY0ZTh1M1p0MzNYMy9C?=
 =?utf-8?B?dkQ4OEJDZDFqWnRNUmlYb0ovNVhCV3BNQ1dzN3BtYjRRV0Y3by9QaHZ2Vmp4?=
 =?utf-8?B?bC8vc3ZnMkxRbWZZZkk0NU9qaGs3Y2NRb0cwWkx2NThhR0kza2o5QnNxT1Fz?=
 =?utf-8?B?aDdFMUNmMUw1bUJRbVJseHl4dFZZc3NSc1o2Wkc5NkdxUWtTRkJnWnNlcnh5?=
 =?utf-8?B?WStyTGppZlg3QWgvQzM5c04wVXhlcWFNVG1VMyt3dDUwVmUxMHhnbDhOb3FL?=
 =?utf-8?B?RVRLUTV5QXZxTUNTU2haWWdFWDdHSjNKSTRubCtVaytMR0FoTllCTml5WUtz?=
 =?utf-8?B?cEdwNjVQNVdrL1pVZ3ZnYjRHOFBRR0RicDV4RnNjRHIzNXRXdFpIby9pa1V3?=
 =?utf-8?B?TjZab29UU0JDK0ZuZEhJYncvdzM2NDZzMnRzSTM2MUZmUVI3amRkb0h2eHpk?=
 =?utf-8?Q?ITjA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c4e3d1-776b-4dbb-63cf-08db62b590c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 15:33:36.0209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jc2yOqZ5A3MtsPJrAd7BOoRQqPRiKTc1R/IwM+klMsWp7pIMG61/4ng0YGCKh+TWKpdsNcjpeQHb8Lnf9E96Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9261
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
Cc: =?utf-8?B?UmFmYWVsIMOBdmlsYSBkZSBFc3DDrW5kb2xh?= <rafael@espindo.la>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+
IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDMxLCAyMDIzIDEwOjIyIFBNDQo+IFRvOiBMaW1vbmNpZWxs
bywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZzsgUmFmYWVsIMOBdmlsYSBkZSBFc3DDrW5kb2xhDQo+IDxyYWZhZWxA
ZXNwaW5kby5sYT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIGRybS9hbWQ6IERpc2Fs
bG93IHMwaXggd2l0aG91dCBCSU9TIHN1cHBvcnQNCj4gYWdhaW4NCj4NCj4gT24gV2VkLCBNYXkg
MzEsIDIwMjMgYXQgOToyNuKAr0FNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29t
Pg0KPiB3cm90ZToNCj4gPg0KPiA+IE9uIFR1ZSwgTWF5IDMwLCAyMDIzIGF0IDY6MzTigK9QTSBN
YXJpbyBMaW1vbmNpZWxsbw0KPiA+IDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPiB3cm90ZToN
Cj4gPiA+DQo+ID4gPiBjb21taXQgY2Y0ODhkY2QwYWI3ICgiZHJtL2FtZDogQWxsb3cgczBpeCB3
aXRob3V0IEJJT1Mgc3VwcG9ydCIpDQo+IHNob3dlZA0KPiA+ID4gaW1wcm92ZW1lbnRzIHRvIHBv
d2VyIGNvbnN1bXB0aW9uIG92ZXIgc3VzcGVuZCB3aGVuIHMwaXggd2Fzbid0DQo+IGVuYWJsZWQg
aW4NCj4gPiA+IEJJT1MgYW5kIHRoZSBzeXN0ZW0gZGlkbid0IHN1cHBvcnQgUzMuDQo+ID4gPg0K
PiA+ID4gVGhpcyBwYXRjaCBob3dldmVyIHdhcyBtaXNndWlkZWQgYmVjYXVzZSB0aGUgcmVhc29u
IHRoZSBzeXN0ZW0gZGlkbid0DQo+ID4gPiBzdXBwb3J0IFMzIHdhcyBiZWNhdXNlIFNNVCB3YXMg
ZGlzYWJsZWQgaW4gT0VNIEJJT1Mgc2V0dXAuDQo+ID4gPiBUaGlzIHByZXZlbnRlZCB0aGUgQklP
UyBmcm9tIGFsbG93aW5nIFMzLg0KPiA+ID4NCj4gPiA+IEFsc28gYWxsb3dpbmcgR1BVcyB0byB1
c2UgdGhlIHMyaWRsZSBwYXRoIGFjdHVhbGx5IGNhdXNlcyBwcm9ibGVtcyBpZg0KPiA+ID4gdGhl
eSdyZSBpbnZva2VkIG9uIHN5c3RlbXMgdGhhdCBtYXkgbm90IHN1cHBvcnQgczJpZGxlIGluIHRo
ZSBwbGF0Zm9ybQ0KPiA+ID4gZmlybXdhcmUuIGBzeXN0ZW1kYCBoYXMgYSB0ZW5kZW5jeSB0byB0
cnkgdG8gdXNlIGBzMmlkbGVgIGlmIGBkZWVwYCBmYWlscw0KPiA+ID4gZm9yIGFueSByZWFzb24s
IHdoaWNoIGNvdWxkIGxlYWQgdG8gdW5leHBlY3RlZCBmbG93cy4NCj4gPiA+DQo+ID4gPiBUaGUg
b3JpZ2luYWwgY29tbWl0IGFsc28gZml4ZWQgYSBwcm9ibGVtIGR1cmluZyByZXN1bWUgZnJvbSBz
dXNwZW5kIHRvDQo+IGlkbGUNCj4gPiA+IHdpdGhvdXQgaGFyZHdhcmUgc3VwcG9ydCwgYnV0IHRo
aXMgaXMgbm8gbG9uZ2VyIG5lY2Vzc2FyeSB3aXRoIGNvbW1pdA0KPiA+ID4gY2E0NzUxODY2Mzk3
ICgiZHJtL2FtZDogRG9uJ3QgYWxsb3cgczBpeCBvbiBBUFVzIG9sZGVyIHRoYW4gUmF2ZW4iKQ0K
PiA+ID4NCj4gPiA+IFJldmVydCBjb21taXQgY2Y0ODhkY2QwYWI3ICgiZHJtL2FtZDogQWxsb3cg
czBpeCB3aXRob3V0IEJJT1MNCj4gc3VwcG9ydCIpDQo+ID4gPiB0byBtYWtlIGl0IG1hdGNoIHRo
ZSBleHBlY3RlZCBiZWhhdmlvciBhZ2Fpbi4NCj4gPiA+DQo+ID4gPiBDYzogUmFmYWVsIMOBdmls
YSBkZSBFc3DDrW5kb2xhIDxyYWZhZWxAZXNwaW5kby5sYT4NCj4gPiA+IExpbms6DQo+IGh0dHBz
Oi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL3Y2LjEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUNCj4gL2FtZGdwdV9hY3BpLmMjTDEwNjANCj4gPiA+IENsb3NlczogaHR0cHM6Ly9n
aXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMjU5OQ0KPiA+ID4gU2lnbmVk
LW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+
ID4NCj4gPiBQYXRjaCAxIGlzOg0KPiA+IFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gUGF0Y2ggMiBzZWVtcyBhIGJpdCBtdWNoLCBidXQg
SSBjb3VsZCBiZSBjb252aW5jZWQgaWYgeW91IHRoaW5rIGl0DQo+ID4gd2lsbCBhY3R1YWxseSBo
ZWxwIG1vcmUgdGhhbiBhIHdhcm4gd291bGQuICBVc2VycyBhbHJlYWR5IGFzc3VtZSB3YXJuDQo+
ID4gaXMgYSBrZXJuZWwgY3Jhc2guICBJJ20gbm90IHN1cmUgdGhlIGF2ZXJhZ2UgdXNlciBtYWtl
cyBhIGRpc3RpbmN0aW9uDQo+ID4gYmV0d2VlbiB3YXJuIGFuZCBlcnIuDQo+ID4NCj4NCj4gWW91
J2xsIG5lZWQgdG8gcmV2ZXJ0IGQyYTE5N2E0NWRhYWNkICgiZHJtL2FtZDogT25seSBydW4gczMg
b3IgczBpeCBpZg0KPiBzeXN0ZW0gaXMgY29uZmlndXJlZCBwcm9wZXJseSIpIGFzIHdlbGwsIG90
aGVyd2lzZSwgd2UnbGwgYnJlYWsNCj4gcnVudGltZSBwbS4NCj4NCg0KQ2FuIHlvdSBlbGFib3Jh
dGUgbW9yZSBvbiB5b3VyIHRob3VnaHQgcHJvY2Vzcz8gIGQyYTE5N2E0NWRhYWNkIHdhcyBhZGRl
ZCBpbiA1LjE4DQphbmQgY2Y0ODhkY2QwYWI3IHdhcyBhZGRlZCBpbiA2LjMuICBJIGNhbid0IGlt
YWdpbmUgcnVudGltZSBQTSBpcyBicm9rZW4gdGhlIHdob2xlIHRpbWUNCm9uIGRHUFVzLg0KDQo+
IEFsZXgNCj4NCj4gPiBBbGV4DQo+ID4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMgfCA4ICsrKysrKy0tDQo+ID4gPiAgMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMNCj4gPiA+IGluZGV4IGFlZWVj
MjExODYxYy4uZTFiMDE1NTRlMzIzIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FjcGkuYw0KPiA+ID4gQEAgLTEwOTIsMTYgKzEwOTIsMjAgQEAgYm9v
bCBhbWRncHVfYWNwaV9pc19zMGl4X2FjdGl2ZShzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRl
dikNCj4gPiA+ICAgICAgICAgICogUzBpeCBldmVuIHRob3VnaCB0aGUgc3lzdGVtIGlzIHN1c3Bl
bmRpbmcgdG8gaWRsZSwgc28gcmV0dXJuIGZhbHNlDQo+ID4gPiAgICAgICAgICAqIGluIHRoYXQg
Y2FzZS4NCj4gPiA+ICAgICAgICAgICovDQo+ID4gPiAtICAgICAgIGlmICghKGFjcGlfZ2JsX0ZB
RFQuZmxhZ3MgJiBBQ1BJX0ZBRFRfTE9XX1BPV0VSX1MwKSkNCj4gPiA+ICsgICAgICAgaWYgKCEo
YWNwaV9nYmxfRkFEVC5mbGFncyAmIEFDUElfRkFEVF9MT1dfUE9XRVJfUzApKSB7DQo+ID4gPiAg
ICAgICAgICAgICAgICAgZGV2X3dhcm5fb25jZShhZGV2LT5kZXYsDQo+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAiUG93ZXIgY29uc3VtcHRpb24gd2lsbCBiZSBoaWdoZXIgYXMg
QklPUyBoYXMgbm90IGJlZW4NCj4gY29uZmlndXJlZCBmb3Igc3VzcGVuZC10by1pZGxlLlxuIg0K
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIlRvIHVzZSBzdXNwZW5kLXRvLWlk
bGUgY2hhbmdlIHRoZSBzbGVlcCBtb2RlIGluIEJJT1MNCj4gc2V0dXAuXG4iKTsNCj4gPiA+ICsg
ICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gPiArICAgICAgIH0NCj4gPiA+DQo+ID4g
PiAgI2lmICFJU19FTkFCTEVEKENPTkZJR19BTURfUE1DKQ0KPiA+ID4gICAgICAgICBkZXZfd2Fy
bl9vbmNlKGFkZXYtPmRldiwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAiUG93ZXIgY29u
c3VtcHRpb24gd2lsbCBiZSBoaWdoZXIgYXMgdGhlIGtlcm5lbCBoYXMgbm90IGJlZW4NCj4gY29t
cGlsZWQgd2l0aCBDT05GSUdfQU1EX1BNQy5cbiIpOw0KPiA+ID4gLSNlbmRpZiAvKiBDT05GSUdf
QU1EX1BNQyAqLw0KPiA+ID4gKyAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gPiArI2Vsc2UNCj4g
PiA+ICAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gPiArI2VuZGlmIC8qIENPTkZJR19BTURfUE1D
ICovDQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+ICAjZW5kaWYgLyogQ09ORklHX1NVU1BFTkQgKi8N
Cj4gPiA+IC0tDQo+ID4gPiAyLjM0LjENCj4gPiA+DQo=
