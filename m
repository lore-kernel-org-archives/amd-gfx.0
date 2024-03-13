Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF7CC54791
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 06:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3223410EDF9;
	Wed, 13 Mar 2024 06:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lF9lBC9i";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C99B10EDF9
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 06:35:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLCmtPSmTPNrbE8AGKIPYaMUi6UlIZ1FWSmY8ufn2bVdx4QZU6TVy2docPGpIwm7+ALN0L61+OoOnXE+ABos9fF/poyJx58n5qLwXiIEpVYbfpvMdSfb8MeZyVDl/smrLjWnRRqiaE+TJ7ic4tHm8OA1n2OA/yaGBmQZFOjOtYWqPE7Mjk7D45kTClEWz4dPsbYhGSYFzqmP2nWpJJeTDVy8enmWmAZEQWEJRe1myPO3AIYZ3Yefp8ahSedHSBujzInd7W2A6+l1YSHxhm19CHdBBtAjUhBi2AqqF9d2tczw+Hepgjj51yvhPMTlNofS0R1fcG9uLRGsj+v7NjBdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEZ80kd0pI+TWVBeH4Gthq/UbIwp8OmzQbGn0Ik/i1w=;
 b=HCp8IzPWJuB/jcC1jyb9uqDSRuebJ2rt6VxLFcBYWjpI7T83rJAfV3wsgF0Os6SBslObWIuhpuQwOvUrlbpxY4RM0UA0Z41fiMG8mxl+5U19nR15UJXfo3LF4a8lC9WfLEJMpaYGIC34BQ3mZuB6dlW9IiNtDnDDEvk3l6OIAuYsquXlDlF7lEkBv28IBIR9vU1XG6olYRNgVjCSqYA2Pqed0I9FTu/jjBVTyXs1bsmudtj0yq7BYrnBMddv1+Uu+3dfYXB3vS4hHXOZIi0lTbOKWksM6DEDX3IjHvPy1vOFSyKRrPSTiFhqTsth7ngbuTzYCx8GW46ebsiGI2EIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEZ80kd0pI+TWVBeH4Gthq/UbIwp8OmzQbGn0Ik/i1w=;
 b=lF9lBC9iNzCiwAV0BpshZ6mESV4PimxoqA8k8ujwbTLLiFdDW3yYjq9019sAUKetjRCvMHcxQat/Y9/rGio0fu3fJJRgvBMwf4p+UChnM/V2eL7+vRaMCvJsLpFfMtaz7xrAApIZs/xdj1x/vPZuiM1dHWzIPNNjv++7/AAiXj8=
Received: from CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18)
 by SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 06:35:18 +0000
Received: from CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::7a06:2a38:4667:d5a7]) by CO6PR12MB5489.namprd12.prod.outlook.com
 ([fe80::7a06:2a38:4667:d5a7%4]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 06:35:18 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>, "Chung, 
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Wu, Hersen"
 <hersenxs.wu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>
Subject: RE: [PATCH 03/43] drm/amd/display: Enable 2to1 ODM policy for DCN35
Thread-Topic: [PATCH 03/43] drm/amd/display: Enable 2to1 ODM policy for DCN35
Thread-Index: AQHadF6kTi2DNp2xjEqAOJ0YKvA9uLEz5RyAgAFSz9A=
Date: Wed, 13 Mar 2024 06:35:17 +0000
Message-ID: <CO6PR12MB5489AD488F4F64D72065DEA7FC2A2@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
 <20240312092036.3283319-4-Wayne.Lin@amd.com>
 <bbd11daf-edba-4986-ae33-4abf2ee36f61@gmail.com>
In-Reply-To: <bbd11daf-edba-4986-ae33-4abf2ee36f61@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5e4464d1-dbb4-4353-a35d-760b7d72026c;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-03-13T06:33:35Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5489:EE_|SJ0PR12MB8616:EE_
x-ms-office365-filtering-correlation-id: 631b37b2-b2ad-4827-2d77-08dc4327bfcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Io5Jtm85TruJqkRV0ntIr8xlExKrCAMy5QWVwMoM9ibmBSfqA4Gz5UJFKj5e+Trzmv0XqOLY17R0PTkJmCsLMNBXxgDdOs1YYlyegWng+P5WtNdX6BslWIqHyKb3bCxG35P+FHTOn+UeDH8kRvUKW0VIqw+XtIotuyWrPZ8LWSfTwTAAMypmj6LsQ5WKPSDvG53zCKHHDYR0avi7LbsX3+VDP37hZcK8j7vbuvjvWz01gqY3zmMicicozfiCVIfcYgtfrhepJzFs0WFH0HJBlAwuKGNLZFNOlflZjG4WGktn3gLhnuIm5VQ0Lw6Exq3JZWbcI8fAV6sKPzT5k59XW7B+jEvcz0wuWcWnyzjxJ11xRdmCdAjhGJwzEWD4p8ikOisFbx5jQtxrbCJ+bHIxIPOLRqHOWFDfItjhdyVwdBDdoKFAeLAMa1EbOeKcUIV3IjcU4IZCbwKq8dWJ6A3aIL8G2knU2rPDDqkXKjNDmO7OVSLD+35x551C8Imm9efuUIopsEbxWqLHhj/QHwgMYbyKiJps0+RzSPJpl+UefTLM0KmM4nhFJxtWw5RfJJfqJGP2/WJT+MHDB+0XEOt/dH0KYgu4vUgoRSyLuKaFlM1iiUBSIUfus3mPrfa4UY5HCDnhMa7T0YgqEhRcjixHdki4QVg2NroxPB8aQtr4psHo4MHXxrUJmpz2eegGqQg9Ihjh5rhqvEvnPaP+TlGcTg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5489.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFN5VUhhb0hFMThGNzUwZUVwekk4clYyR25HMkVkVU5DNzZOa3hycWw3d2tN?=
 =?utf-8?B?MzdlOHZqUGl1Tnpnb08wZGxZSXljRSthTXFRVTUwWDUzdTVHVGxJckdPV0dC?=
 =?utf-8?B?QVdkNW5VMEZ6bDZZR3BEQ1V1bHNQWXY5M29WcW9lUTdVTEtlTmtWSm9wK2tX?=
 =?utf-8?B?MFE5NVI3NHFyc3REUWpIQTBjV0pNZW5waDBuNGgwbElDSGFlTlRhWVd4WDha?=
 =?utf-8?B?ZjY4MkpYRHAxRUpLbTFhaHhyMTlsdEJ4bWtmekp3bEpHZll0ZXZSQ0dDT3lC?=
 =?utf-8?B?SThNYU9mMWM0Qm91UVFkT0lSN3ZCSzU2ZFp5S1JibXBKdWU0OEVwa1FaMVJI?=
 =?utf-8?B?VVdiOEZveWRVUE9Ldm53Z1FxR2xHZVBiMXhJc3A3VVRvN2VONU9GZ211L3Zl?=
 =?utf-8?B?NDd0M1Y3b2JRQU9KbURHR3JtcXFXTHVMandzR2R0WFJpak4vMVZJUDJBOXpB?=
 =?utf-8?B?RHBmWVRmSHpteWYyVkFTWm1kRkwwSUNsL1RwdFN6MGpreW5LU21hM1FqTFhh?=
 =?utf-8?B?TGo4MmYzWlNtOW9ZbHRCd0swTWdlQmRrQnBnYWkrL04vak1XVXhkbkVYYW1R?=
 =?utf-8?B?VWwyR2xneThDc1ZoN3J1NkdZRElHY2dXTmFPZkN0RjVNanJ1VmlaRjdNQkgx?=
 =?utf-8?B?RXVxcWZZWGpGUWJ4MTBGTVFpOTRtVmtvdys2NmZERTRvaVVLeVk0Y0RFUFRz?=
 =?utf-8?B?SHN0YUp4WVJkN00xaHNGeS9wRFJPUzBpWGZCZ3JhU256WXZ4eFdRcmwrU045?=
 =?utf-8?B?MThJZlhVdlN3ZzV6Ti8yUkViWVZCZGwvNVR2NmJZNm9CUElxRmhtSWVka1p5?=
 =?utf-8?B?WmswTHhKcXUvVkFqaVU0OWR3NmQ0bWs2aytjWWxjTGI4SHJGYS9BQk0xRHVT?=
 =?utf-8?B?WEFmUHZITWdwYVoyMWozUWJOeGdLNHRNY21kbzkyRXJIeGxCNDc2RzBVdHBj?=
 =?utf-8?B?RlRhUFdwRXlGbHp4S04rd1ZSa1hoZlhPRzBzZ1Nnd3VjMk8rSjNta2hJMGNr?=
 =?utf-8?B?WVFjYUM1OG1sa2dNSjlMeXdpcE83dmhIWTArbzdlZ25KcUxVTlMwTHVET2pC?=
 =?utf-8?B?RXhoR0k5RGdBR0NEcE5SRE9sai82Vnh0WU85K2VkTWt1VTNpN0l1RTByUkZ1?=
 =?utf-8?B?L0dIK2dHZE9BMm5WNDZtM09zQUZkZkJibDZoWCt1ZGhXb25qYzlBRWJkdU11?=
 =?utf-8?B?Q1o2OTh6Q0ZycWpJdEhDdk40Y2ZJK0ZWV2ZIbFBCTXVRdkpwRUhiVVkxRTRB?=
 =?utf-8?B?QzRxRllTakVsN0twVm1VNG15dUhKK2R4aGxOYkRpMGlOSnRyYVRNS3hidzFs?=
 =?utf-8?B?ZGxQZUZqeUgzaER1R0ZlK1FuZUNWdjRBK2dvT1VLaTUwMWptN1hyV0R2dWxG?=
 =?utf-8?B?bkFiNDBtYStqMjlabUtSdDNWYlIxN2ROQXkvR3BhVnRqM1JkU01Pam90QW1w?=
 =?utf-8?B?Q0U4N1FhbWZYa05nZGJrZnFicDRKc0lmSWplMTdiYUJxcGdnRU94ODEzNTR1?=
 =?utf-8?B?dnNMOEZqUTVJemo1alNaTFdZV0VYYXFRVUZua3BrVDRRekowQ0tScWNnMUhI?=
 =?utf-8?B?TUlRTnpNcFdsNVRnTG4vNWtnZzdQQTFoYXZkalI1dEE5MW5pSXp3bHlnYzBH?=
 =?utf-8?B?d3IzWXVuVi92c1JpN3lUdUtBRWxYVU1hZjlxMENKTG50NTh5QTRHaUJ2S0U3?=
 =?utf-8?B?SzJweG0yc0lBcEh2ZHJLVitrYmRhcnlCL1hNWkJFZld2UytwQ2NOZ3BxNUZ0?=
 =?utf-8?B?SGJ0ZHl1RWxldjJSbUZJYnhQWi9iUllQUThZYy9LNytCdndVQ1o3S0h1Nkhp?=
 =?utf-8?B?RmwxTTdqOXZhc0t0WkJ2Q2kxK3ppZ3JYM0I5Vm85QlE3V2ZMZkMyclN6eXpy?=
 =?utf-8?B?U3QyQlFBUm9GNElDem9sQy8vcmV6MGZtRTUzZmd0eVl0YURIajRPV3p3SVZK?=
 =?utf-8?B?MTAzN29BZm5GdENxVENlSkprVHVHUVNGRG1yM2JELzJYUEF1VVJXRlNkd2VG?=
 =?utf-8?B?SGozYWlpWE93QWN3ZUl0c0FLTDNkSm9VUm1nbmRicWpZRFk4eElEOGluRHNM?=
 =?utf-8?B?THIrazFwb2JYSGtXTEthR1QvRTU4Mjd0RStPbWlnNDh2ZzlkaHNNNlFXd3dL?=
 =?utf-8?Q?CEWg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5489.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631b37b2-b2ad-4827-2d77-08dc4327bfcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 06:35:18.0113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lphFpgUetl/FOl7i7sFp1PGbiF1G4qbntXFPfdzVC0sO1w6uWTXIoQa7lVzCgUOFEjz7ssFAubY2pkfKTT4K6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616
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

W1B1YmxpY10NCg0KQXBwcmVjaWF0ZSBmb3IgdGhlIGZlZWRiYWNrIQ0KDQpSZWdhcmRzLA0KV2F5
bmUNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1h
cmNoIDEyLCAyMDI0IDY6MjEgUE0NCj4gVG86IExpbiwgV2F5bmUgPFdheW5lLkxpbkBhbWQuY29t
PjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IFdlbnRsYW5kLCBIYXJyeSA8
SGFycnkuV2VudGxhbmRAYW1kLmNvbT47IExpLCBTdW4gcGVuZyAoTGVvKQ0KPiA8U3VucGVuZy5M
aUBhbWQuY29tPjsgU2lxdWVpcmEsIFJvZHJpZ28gPFJvZHJpZ28uU2lxdWVpcmFAYW1kLmNvbT47
DQo+IFBpbGxhaSwgQXVyYWJpbmRvIDxBdXJhYmluZG8uUGlsbGFpQGFtZC5jb20+OyBMaSwgUm9t
YW4NCj4gPFJvbWFuLkxpQGFtZC5jb20+OyBHdXRpZXJyZXosIEFndXN0aW4gPEFndXN0aW4uR3V0
aWVycmV6QGFtZC5jb20+Ow0KPiBDaHVuZywgQ2hpYUhzdWFuIChUb20pIDxDaGlhSHN1YW4uQ2h1
bmdAYW1kLmNvbT47IFd1LCBIZXJzZW4NCj4gPGhlcnNlbnhzLnd1QGFtZC5jb20+OyBadW8sIEpl
cnJ5IDxKZXJyeS5adW9AYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMy80M10gZHJt
L2FtZC9kaXNwbGF5OiBFbmFibGUgMnRvMSBPRE0gcG9saWN5IGZvcg0KPiBEQ04zNQ0KPg0KPiBK
dXN0IGFub3RoZXIgZ2VuZXJhbCBjb21tZW50IG9uIGhvdyB0byB1cHN0cmVhbSBwYXRjaGVzLg0K
Pg0KPiBXaGVuIHB1Ymxpc2hpbmcgYSBsYXJnZSBzZXQgb2YgcGF0Y2hlcyBpdCBpcyB1c3VhbGx5
IGdvb2QgY29udmVudGlvbiB0byBzb3J0DQo+IHRoZW06DQo+IDEuIEJ1ZyBmaXhlcyB3aGljaCBt
aWdodCBldmVuIGdldCBiYWNrcG9ydGVkIDIuIENvbW1lbnQgYW5kIG90aGVyIG5vbg0KPiBmdW5j
dGlvbiBjbGVhbnVwcyAzLiBGdW5jdGlvbmFsIGNsZWFudXBzIDQuIE5ldyBmZWF0dXJlcw0KPg0K
PiBPbmUgZ29vZCByZWFzb24gZm9yIHRoYXQgaXMgdGhhdCBpdCB1c3VhbGx5IG1ha2VzIGZpeGVz
IG11Y2ggZWFzaWVyIHRvIHBvcnQgdG8NCj4gb2xkZXIga2VybmVsIHZlcnNpb25zLCBidXQgaXQg
YWxzbyBtYWtlcyB0aGluZ3MgZWFzaWVyIHRvIHJldmlldy4NCj4NCj4gSWYgeW91IGFyZSBpbiBk
b3VidCBpZiBhIHBhdGNoIHNldCBpcyBzdGlsbCBmdWxseSBjb21waWxpbmcgYWZ0ZXIgcmUtb3Jk
ZXJpbmcgdGhpbmdzDQo+IHlvdSBjYW4gdXNlIHRoZSBjb21tYW5kDQo+DQo+IGdpdCByZWJhc2Ug
LXggbWFrZSBiYXNlX2JyYW5jaA0KPg0KPiBPbiB5b3VyIGJyYW5jaCBhbmQgZ2l0IHdpbGwgcnVu
IGEgbWFrZSBiZXR3ZWVuIGFmdGVyIGFwcGx5aW5nIGVhY2ggcGF0Y2guIFRoaXMNCj4gd2F5IHlv
dSBjYW4gZG91YmxlIGNoZWNrIHRoYXQgZXZlcnl0aGluZyBzdGlsbCBidWlsZHMgZmluZS4NCj4N
Cj4gV29ya2luZyBsaWtlIHRoYXQgaXMgbm90IGEgbXVzdCBoYXZlLCBidXQgcmVhbGx5IGdvb2Qg
cHJhY3RpY2UuDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4gQW0gMTIuMDMuMjQg
dW0gMTA6MTkgc2NocmllYiBXYXluZSBMaW46DQo+ID4gRnJvbTogUm9kcmlnbyBTaXF1ZWlyYSA8
Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPg0KPiA+DQo+ID4gW1doeSAmIEhvd10NCj4gPiBFbmFi
bGUgMnRvMSBPRE0gcG9saWN5IGZvciBEQ04zNQ0KPiA+DQo+ID4gQWNrZWQtYnk6IFdheW5lIExp
biA8d2F5bmUubGluQGFtZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUm9kcmlnbyBTaXF1ZWly
YSA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL3Jlc291cmNlL2RjbjM1L2RjbjM1X3Jlc291cmNlLmMgfCAyICst
DQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9y
ZXNvdXJjZS9kY24zNS9kY24zNV9yZXNvdXJjZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvcmVzb3VyY2UvZGNuMzUvZGNuMzVfcmVzb3VyY2UuYw0KPiA+IGluZGV4IDVk
NTI4NTNjYWM5Ni4uYThmNDAyM2ZmM2IxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9yZXNvdXJjZS9kY24zNS9kY24zNV9yZXNvdXJjZS5jDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL3Jlc291cmNlL2RjbjM1L2RjbjM1X3Jl
c291cmNlLmMNCj4gPiBAQCAtNzY5LDcgKzc2OSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGNf
ZGVidWdfb3B0aW9ucw0KPiBkZWJ1Z19kZWZhdWx0c19kcnYgPSB7DQo+ID4gICAgIC5zdXBwb3J0
X2VEUDFfNSA9IHRydWUsDQo+ID4gICAgIC5lbmFibGVfaHBvX3BnX3N1cHBvcnQgPSBmYWxzZSwN
Cj4gPiAgICAgLmVuYWJsZV9sZWdhY3lfZmFzdF91cGRhdGUgPSB0cnVlLA0KPiA+IC0gICAuZW5h
YmxlX3NpbmdsZV9kaXNwbGF5XzJ0bzFfb2RtX3BvbGljeSA9IGZhbHNlLA0KPiA+ICsgICAuZW5h
YmxlX3NpbmdsZV9kaXNwbGF5XzJ0bzFfb2RtX3BvbGljeSA9IHRydWUsDQo+ID4gICAgIC5kaXNh
YmxlX2lkbGVfcG93ZXJfb3B0aW1pemF0aW9ucyA9IGZhbHNlLA0KPiA+ICAgICAuZG1jdWJfZW11
bGF0aW9uID0gZmFsc2UsDQo+ID4gICAgIC5kaXNhYmxlX2Jvb3Rfb3B0aW1pemF0aW9ucyA9IGZh
bHNlLA0KDQo=
