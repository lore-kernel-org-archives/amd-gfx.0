Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB321FD9E37
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 04:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B33310E5A1;
	Fri, 27 Feb 2026 04:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zi2M4byf";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89F4E10E5A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 04:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1kjDbCiSpulD3SGl8K568e26UVrRxETrjFywwrNvhcyUL85WWCabWx2qYPNW7xCWsASkzqgkaRZPGt64MfhHR7+vIcnCK+geqMaBr8oJibMfYmyzruA2A/5WB0dgV0wxN2XIqPkaCj5/Ol2h28ES8ROipYiFuvTFM2y3i9DY9qUT91MbuBj2hIIP9Z9GkewY93TWsr+pWAUrqqlH6J1lzveaHTFgeklvESoI5BB0l3Wegmcv76YR2t5DhMHDn/CAGB92v5awEdvzo6NAIpi7ysYauFVf/PL8A7jpA1BDQSaTvUK0vRPKp3P1Ch91eGq/U7KEqNV+OVwl+d3GzYT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzcvSMlBjASNC/rXgRNZhum0bZbomdUV0Zj64SIgawI=;
 b=RMq4IwZ5jpfr6105pmQnt5VNMWowNX+oR43mkOFPzjYI9iGRCzZUuHH5oZFGI1KPQAuplfQMNLacc0HCkVUcwEfvDDSFR4MfyTMwW478HlRoILj4qBjPz21WSJ8eXNwtBoKPh/YRAp9VXIkpGZZ1Axn/TrM7UdYLci+mJUAOuF1/ygNMO9PkRKgapUcngGycuoli5s2MDBQANoNAZSCIjzp2sCc5ErkXWA5fjXN2Z8DHhAr5VPiVWlGA+BfO+6zx0qOL5dg3QuOJTjUSYF3euLM3kwnDZ30XHB+wz2W/PnSwlp7reIPwqC/ob20HHuQPif7pKDkNJvg27CGD9/I7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzcvSMlBjASNC/rXgRNZhum0bZbomdUV0Zj64SIgawI=;
 b=Zi2M4byfYG7j7dkJkxRBNduoQpUus61qb21Un0ZKSCXJg0cQhbFXMbcfaynyWYlnwT+C7Qmo8Z8GdOTYh33wJGy6mB22VxiFWJ01vGnFx3Acc5LHlwipsY7bXPLpeZy2N7BfE4SK+/1uwWc5xxy9DHQXA3t9BM9I7ahF6oGjl9M=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Fri, 27 Feb 2026 04:44:21 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 04:44:21 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: restrict sensor load values to 0-100
Thread-Topic: [PATCH] drm/amd/pm: restrict sensor load values to 0-100
Thread-Index: AQHcpjny217/7Nl9CES1HXuG3NSqnLWTUUCAgAAnDYCAAoKpoA==
Date: Fri, 27 Feb 2026 04:44:21 +0000
Message-ID: <DM6PR12MB2972FEFE85BC8F6C684E25068273A@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260225093406.498727-1-kevinyang.wang@amd.com>
 <96885b73-a1fc-4b3f-a35e-0177a415a331@amd.com>
 <CADnq5_O4u+v9f5XNFipKHPa1qC6tEr0k4ppZXX0tUqrAjY8PXQ@mail.gmail.com>
In-Reply-To: <CADnq5_O4u+v9f5XNFipKHPa1qC6tEr0k4ppZXX0tUqrAjY8PXQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-27T04:44:07.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|CH3PR12MB9121:EE_
x-ms-office365-filtering-correlation-id: 3168476f-7463-4a3a-cb19-08de75badfc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: g7D9kh4q0UHaT7mPRCKH7YNzwNletSTy2bE06eoCF5/0CEw+pZ30RiuXwkXPEHXg0cr7YJ3U+71RKUSA8bFkRgN96aNxviNmKflHowfJg2cjtsDfaD+uwstU4yPTBfH8b3iCfLzbsr+3RLmHFUWcNJQQ01X0MEhQQwCH2R/QkyOjtK4adO0SEhozCrYLULZ5Zl3kvdsJVJ6nfm6H2CmjxPWPxTQHPnkZz01P6u658D/p0d3zkDz28H9dK7+FXA10Bn5QQC95MQ+gRTNq3YF/l5gLSBHb3FgC9QKzQLQ91V9Inlk/zwgRcDRARYm5qdUe0o+NRi3hcJikp9c86Fnm1rTOxZNyxd2ZeLNw5WHGnKi43gmFkqjYWo8YCgFuzzLv0Mg/sY48YEVYTp3p0msLbwVtH1nZ1NbYKfHkOPMXURvOeNwtFUKHTKa5PnwgLbqVSTIixZ7SvP5KeNSvWpbtV+myJS3zCYCPUMH8pDr+1t/Fo9G0FpprfHs2prY3vuGOAxg+fhiwHIu1l0vMFDy0fT6PYIqTOxCiEn3dy7Pfh4xESux1tfQC6Dzjg93u8/Yyb2lHHpCLeImpXzo4dSoOBFOfjCAjgfbyJzKQrHMeiAZgHruium7RK3etxbHF/7MTg+vvtaE9VlKGud6B7Sw3XzK1pmRbBqAqTpdcEgGyrOowfh/0sMMssU5ErN3LqJ23RRm7PxCtW+wlcCSzZL3M49zisVSGyULopBvWXEEHtzkunagxPQokccBB0kkKuuC6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG5xSjJ3M3BKcU9mVEdTY0NVWHJVZFh6czEvMFdiYjd2VGhBeUxZQmVXc2k3?=
 =?utf-8?B?OEtadFUrOEhMbHZGcGJ0bW9hSFBUdGVhZlI0Z1NLeUp4Y1Yxd2dsZTZvNzk5?=
 =?utf-8?B?ck1sY1hvRGltSmJjTWp1RlUvNFNjZE9ocVhSSDBKSkp6dHZxd2pnZWdBSW9E?=
 =?utf-8?B?TUJKenFPUWNMRkkvWlVtakNFemdvdkh3d252VVYwdzJaYnd3T0xRRXU1ZDVh?=
 =?utf-8?B?N3hUcHVqVE9SVWlZcWYwcG05MStidlBzUFZ1THRZc0R1S3poc0prT2M0U2M5?=
 =?utf-8?B?RmxobkxZL2o5bE1lZWhMVEhVaFcza25oZ3RXdmQ4NVFxUFdFZkRtZUlZSHBB?=
 =?utf-8?B?VEM3Z1MrdmRwcGR4WkxNdUttaFBoMUV5Y0dIU3ZGcXJweDEzNnpZbWZuajk0?=
 =?utf-8?B?bHdhUGp0eU1xUkRNVEViUTRiRldXcEM0UnE0ZmhydWd0U0h1dkt5QkJhS3R4?=
 =?utf-8?B?aFJUNUhISXN1WkhudVIvUnZrVG5leFcxVGMzT0NSNldzMFRYNDR1SUxVM0F6?=
 =?utf-8?B?bmFkMU5TV1M3NG9uZGZxcFVmM0pURWpuWWtxTU02ZCtoL3FBbjgya0RaTS9u?=
 =?utf-8?B?K013U3F1dzdmd0pkUUJvZUVJMzY2ellXUkthdzdaZktBNEtuNGQ5RTNiSm5a?=
 =?utf-8?B?aGlNZStOUkliZmdOOEdvNUhuVUIyaGluTWRCeXIxL3pQWGhsdloxdUp1ajFK?=
 =?utf-8?B?ZVd2UGRUNm9qY0E4RjZHTmNvNTBiZzZCVzIzaEhmWC85UXcxMlNaa01FY0h1?=
 =?utf-8?B?Q2FDMzJOa1FLZWVFaW4wODZrMHpXcVQ1cmZ5Uk1lTkd2S21JWXhNU0QzTVJK?=
 =?utf-8?B?ZUdJK0dFbEpXbm1RNEg1VUtVcU5ncll4NG1Fa0NPaFgrc251emhsT25pbm14?=
 =?utf-8?B?WmRMYk9iaGg2Q1BRNEVJaTczVjY0TnFmblJSbUNGd1ZuYkNjNEhCQmhDQ0V0?=
 =?utf-8?B?dncwb0VFcGFrYkUyaDlKNHozb0p1ekRTaDRCUFJpL2c3WC95SCtIQVdldmM5?=
 =?utf-8?B?dmgvRC9oQUs2YXJKaXBQN2d4M2ZGVVZoR2VVQ3o3ODAvREV4S0FtTmpuUC9j?=
 =?utf-8?B?ZmRMMTZ6SGcvMFdPSEp0VDRtRHN2b00xejFBU1lPY0ZKOEJiTzZWemZ6cjdK?=
 =?utf-8?B?K2NYOXo1YkJUTFpJSTF3N1h2WGU3Q2s2cTNYdTVuNHhqcFJPaStRdUtrMFN3?=
 =?utf-8?B?d3RCcmwzUTFyZ2dTdXJRbDc3ajBjYkt1YTBrNmNjZC91VDJRcUJEU3RlUUFE?=
 =?utf-8?B?dEZ0VnQvbDhPZ1BEVXFLTVpSSjZqc2FtRDNjMEVVdis2UDZZSGluZXVyVXlQ?=
 =?utf-8?B?WFZDaUJrWE5FWGUwM3FDd3FucVViSkFrYzFIaVpORFRvTGxiMnR6b0Z3VllF?=
 =?utf-8?B?SEY5dldOWXFqTHVlV2dRS2NDb2NLeFg4TTdDdkh3NHFkRHgycURKN1lTSmhY?=
 =?utf-8?B?RGFhc1JiU25qeGhuditDL0FuMFkxZmsrczVwQU1RbWlQRDNQNTBINVI2Q3RG?=
 =?utf-8?B?WjUrdlRNMnNuWkk5RUpDN0lQVG5XaUhBZkk2M0c2dkFwb0g5OGV5NHdJZVhM?=
 =?utf-8?B?ZC9oa1drRHBCaTYwR09YVHg3QmRxNFZSZUFIaXRsc2JlSmRrWkt4UE1YcU5m?=
 =?utf-8?B?Z2ZmdGNtTWk3Rk1QdFNyZW5RYmQxYjdqTkFhRCt1WS9sYWcrYlVRWWFWVWx1?=
 =?utf-8?B?Y3plbVNOWjZXOC9yejEvbW94M1ROWTlRT1huSktMNjMrbHBkSGNpQ3R1bm1t?=
 =?utf-8?B?bGc4NWtDcC80VW9NYW1QS0tBYWprOWQzVm1sQ2trQ3pKM1Q3bjZjZE9iYzhv?=
 =?utf-8?B?ZkxHWGowRzZUbmlDZDhlcUVac2ZnS2RTYnlzWHE3UThiUCtPdDAzbzAwSlk4?=
 =?utf-8?B?WVBrM1YzZXIyWHo3WERiT1M4MktOSVN0MjVHRnM3QWdOTVE1VGJRbDVsZU5N?=
 =?utf-8?B?QkRJMjhrdkpMVWpvMFBSdnRFbFc2T2hXRThGRU1GUXlwT1h4S2JzQ3BLeWtn?=
 =?utf-8?B?MHZEQk8xc1hxVUsrSXBCK3NXZlY5NDQ4YjBpMm1tdTFONjQ3bWlNeVZTU2Z1?=
 =?utf-8?B?Y3gzdWVOTUkyaCtlOWtJOVN5cWtLcFQ1NkRiRklnRWdWOUIvTGNleVQ5NzZs?=
 =?utf-8?B?aU9vZkR2NXVHbGYrdmp2YWVtWC9XK3Y1S1dRY1poMHdvS0xpM0ZCelU4L2Rl?=
 =?utf-8?B?WmlUcTJNNVgzeFlCWEt6Z2tSZEFRc1ZldjFYc0t5Y2k4dlVGalNDc05UQzk4?=
 =?utf-8?B?QUFDVGJaTEo1dERiNTJUZkg2N3pBV25hdTdhSzI0dFNNMFpXTHpJcDIvWms3?=
 =?utf-8?Q?i1sLbFapOX8RV1nEku?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3168476f-7463-4a3a-cb19-08de75badfc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 04:44:21.1197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8cmtpL7Y9SAQAr6s+p9y81HQXvwBgEPwRW91Yo//04+cvODBMbKjxuKsrNLZYnrS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KUGluZy4uLg0KDQpCZXN0IFJlZ2FyZHMsDQpLZXZpbg0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQpTZW50
OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDI1LCAyMDI2IDEwOjI0IFBNDQpUbzogTGF6YXIsIExpam8g
PExpam8uTGF6YXJAYW1kLmNvbT4NCkNjOiBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldh
bmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPjsgRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5nQGFtZC5jb20+DQpT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL3BtOiByZXN0cmljdCBzZW5zb3IgbG9hZCB2YWx1
ZXMgdG8gMC0xMDANCg0KT24gV2VkLCBGZWIgMjUsIDIwMjYgYXQgNzoxNOKAr0FNIExhemFyLCBM
aWpvIDxsaWpvLmxhemFyQGFtZC5jb20+IHdyb3RlOg0KPg0KPg0KPg0KPiBPbiAyNS1GZWItMjYg
MzowNCBQTSwgWWFuZyBXYW5nIHdyb3RlOg0KPiA+IExpbWl0IEdQVS9NRU0vVkNOIGxvYWQgc2Vu
c29yIHZhbHVlcyB0byAwLTEwMCByYW5nZSB2aWEgY2xhbXBfdCB0bw0KPiA+IGVuc3VyZSB2YWxp
ZGl0eS4NCj4gPg0KPg0KPiBJcyB0aGlzIGEgd29ya2Fyb3VuZD8gSWYgaXQncyBub3Qgd2l0aGlu
IHJhbmdlLCBpdCBpbmRpY2F0ZXMgc29tZQ0KPiB1bmRlcmx5aW5nIGlzc3VlLg0KDQpMaWtlbHkg
Zm9yOg0KaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvNDkw
NQ0KDQpBbGV4DQoNCj4NCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQo+ID4gU2lnbmVkLW9mZi1ieTog
WWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYyB8IDI3ICsrKysrKysrKysrKysrKysrKysrKysr
LS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVf
cG0uYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYw0KPiA+IGluZGV4
IDkzODM2MWVjYWUwNS4uODZlZjFmZmJmMWRkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L2FtZGdwdV9wbS5jDQo+ID4gQEAgLTE0MTQsMjAgKzE0MTQsMzkgQEAgc3RhdGljIHNzaXplX3QN
Cj4gPiBhbWRncHVfc2V0X3BwX3Bvd2VyX3Byb2ZpbGVfbW9kZShzdHJ1Y3QgZGV2aWNlICpkZXYs
DQo+ID4NCj4gPiAgIHN0YXRpYyBpbnQgYW1kZ3B1X3BtX2dldF9zZW5zb3JfZ2VuZXJpYyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGVudW0gYW1kX3BwX3NlbnNvcnMgc2Vuc29yLA0KPiA+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqcXVlcnkpDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCAqdmFsKQ0KPiA+ICAgew0KPiA+IC0gICAg
IGludCByLCBzaXplID0gc2l6ZW9mKHVpbnQzMl90KTsNCj4gPiArICAgICB1aW50MzJfdCB0bXAg
PSBVSU5UX01BWCwgc2l6ZSA9IHNpemVvZih0bXApOw0KPiA+ICsgICAgIGludCByOw0KPiA+ICsN
Cj4gPiArICAgICBpZiAoIXZhbCkNCj4gPiArICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0K
PiA+DQo+ID4gICAgICAgciA9IGFtZGdwdV9wbV9nZXRfYWNjZXNzX2lmX2FjdGl2ZShhZGV2KTsN
Cj4gPiAgICAgICBpZiAocikNCj4gPiAgICAgICAgICAgICAgIHJldHVybiByOw0KPiA+DQo+ID4g
ICAgICAgLyogZ2V0IHRoZSBzZW5zb3IgdmFsdWUgKi8NCj4gPiAtICAgICByID0gYW1kZ3B1X2Rw
bV9yZWFkX3NlbnNvcihhZGV2LCBzZW5zb3IsIHF1ZXJ5LCAmc2l6ZSk7DQo+ID4gKyAgICAgciA9
IGFtZGdwdV9kcG1fcmVhZF9zZW5zb3IoYWRldiwgc2Vuc29yLCAodm9pZCAqKSZ0bXAsICZzaXpl
KTsNCj4gPg0KPiA+ICAgICAgIGFtZGdwdV9wbV9wdXRfYWNjZXNzKGFkZXYpOw0KPiA+DQo+ID4g
LSAgICAgcmV0dXJuIHI7DQo+ID4gKyAgICAgaWYgKHIpDQo+ID4gKyAgICAgICAgICAgICByZXR1
cm4gcjsNCj4gPiArDQo+ID4gKyAgICAgc3dpdGNoIChzZW5zb3IpIHsNCj4gPiArICAgICBjYXNl
IEFNREdQVV9QUF9TRU5TT1JfR1BVX0xPQUQ6DQo+ID4gKyAgICAgY2FzZSBBTURHUFVfUFBfU0VO
U09SX01FTV9MT0FEOg0KPiA+ICsgICAgIGNhc2UgQU1ER1BVX1BQX1NFTlNPUl9WQ05fTE9BRDoN
Cj4gPiArICAgICAgICAgICAgIHRtcCA9IGNsYW1wX3QodWludDMyX3QsIHRtcCwgMCwgMTAwKTsN
Cj4gPiArICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgIGRlZmF1bHQ6DQo+ID4gKyAgICAg
ICAgICAgICBicmVhazsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICp2YWwgPSB0bXA7
DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiAwOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICAvKioNCj4N
Cg==
