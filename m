Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D44C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 00:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD29A10E6BC;
	Thu, 21 Mar 2024 00:17:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ptbF0SbF";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9A0310E6BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 00:17:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeaFZOpLqSQIyDzqtOIhWHkW2CBiszEzIcAFSR+/dYFNRuPSn0nsne/Cz2RpBhD7sb8+3aHsZl9LqXV0It+2tUQSIHK9Nn6GTN5YHP3r5UjzitKxrKjJ9KK6Rpc/cd03mrS89i+MOUTRUme2K+SUQV77G+hTuqVMtNYri5h4XuN0uLB3/C2jpySWYOEDmtdolr0u1NQtWta7oaE8ZkZpcodzsYPoUnSPcG8OKjiy1npmaLqwcwcvPpzxhL40Qt+LsFKPxtsnG3qtiTJ6K0snc8TI8mzE29Xf/LCqA1izfx44lCwEQPzkW4pgaOIOE7fUZvqQC2wrv4yijypCP57ACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rF/c3/prggjpUbTjPvSWzS+RwZK8YCWGwNb4jYQdSE=;
 b=DjMhR8h0HwkrxyjOcTKyLS8fuFCTZ2yLCnVPFqG7sKUt0JeaAI2h4ws53RP8gSmRsp9Q+8ScHMXP8DNjeVQMGsIM6T3cLnhFUl5U7qVbzP/RTWuvRRTJpGR6J9UsSVt6lgctq6g5cHZfp4EK+vZTkATIdKp0uQ/Rd1RsY8qCzGYU/mRcqxHsoo8zeN0wtA46BBOI+G/QPoRrNr8hFJLNyS9RApwp6jBBw1QXqgWN07Fm81iU0vtp82cCj7Ib/oyBTKRTNx088CQBuy+72p9dEzr2eupsIF57IlKBwyeCGm588Mj5dVS9CLFWQdCIm+PLoT9FiqqZPAqPuT3CZnXUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rF/c3/prggjpUbTjPvSWzS+RwZK8YCWGwNb4jYQdSE=;
 b=ptbF0SbF0my+m3FTe9AGftBCS43iPKs59q+iUaKESGTYvNVPrasOIJzYi0+z83OeSbBsOx2EjinrI0KeFNT+F7oj/jYLcnWFOCi2utheif3s1CaC1mHCpkh7xAosWo3gEv4EZBHydWLo6WD9bvpReA5Mm7zixP4X9WPXGlzVvvo=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Thu, 21 Mar
 2024 00:17:50 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::7451:c058:bf5a:aa26%6]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 00:17:50 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Check cgroup when returning DMABuf info
Thread-Topic: [PATCH] drm/amdkfd: Check cgroup when returning DMABuf info
Thread-Index: AQHadwUjojiieaO15U2Bov9k599SB7E98zWAgAMnMQCAAD2ZAIAABB4g
Date: Thu, 21 Mar 2024 00:17:49 +0000
Message-ID: <BL3PR12MB64251A2EFBEAEF410F20BFC5EE322@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20240315181756.685335-1-mukul.joshi@amd.com>
 <48148998-5124-4a66-8d1a-767d94f6c284@amd.com>
 <7e4eb11f-feea-46ab-902f-891f1e15e58b@amd.com>
 <5888a34a-eb37-c1ea-54d7-896b0dd6665d@amd.com>
In-Reply-To: <5888a34a-eb37-c1ea-54d7-896b0dd6665d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d9bb8147-645a-4fed-9b56-cd0a70d10dc9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-21T00:16:53Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|DM6PR12MB4236:EE_
x-ms-office365-filtering-correlation-id: c7c1a636-c2e1-4c19-f67b-08dc493c57d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: msmKRK4vIRgaiQNqCrYAj+PXKBp7D15x4Wea0ocdN61q4SnNZFi4dSduInp+NHCgMMk0eYpCBVfYfUIWstoepRDP23pHboYe6mVgCQI65foVnN9Htl5J1z4RyXm3IuDg3V/GIXZe3In8MA7wwBkYP6Mu9egg5ATiZwVONgYM+Dx4gZgw4tHDV2MZYwcsoPdEMJ+/gCq/0ldxZKV3MMkZNyK4MEKhzfajgFx3KH/ofsqRGiWkVcjH02hWodn0nIYITBfDTSr8Ue31dT0s4GZEyeAuTEFcpACqwR8qx2jQFPSAnhK5l5+Nl2gBUw4MGBQPg7F2ll1ToMA1bNvUK3a7/3XCGaWkImueqrShofT9/Xu8qFi/UkYx7zX4xh3Q0WAFn/Hx2rXyuBWRY497QDBkYnxkJIJEnHFFVQlt4d8K9WpH9Od1XGdaFzyNIc7uKELwk9sRIjadsePukKk/q63Gst/sNB6xGYBr0+ReTRXqTTVQhT8/voxkdS1W6T8OZovXmF8+kW2RX/jwI1nNLdH5QGUD+AZzafFp7ACpZmoWnzpw6161bbRFUMEv1Ehlp2eBaH9O1sVM2wQYwxe5LYcmLBN2Wka7rW2rtX/jT9Ge+UD5LLEto1p9G3NWrh+kSh0QSWmBnay5TVgY3O/E3l3byYPWMDhXIwjfd9FzdhjNnmExSOzIfoet3h9wTtgjPcMhTlQFisc7EbEfzytFdGt6/JXUZ2PGJzWiRD+MOKMqGKU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlJMM2Y5YkI0SVdZdGFzVXExUkN1T2FzRkxGZU1aRUlpRnlyZmFvUzE5MG9n?=
 =?utf-8?B?cDY2YnlwZkJLdUNYbC9BN3JpVzZYeFVwditzL2orWnRkTTJ4ZHBoNExtRzJ3?=
 =?utf-8?B?YTIwS1crRk04T1NQb2dMWERmQXdLblJVSUFlQlo5czR4T1gvNVVSR1dGR0to?=
 =?utf-8?B?NytyN2pmNGZFWEU1Mk5LRnh3Wk1BcklUSnVpeXIraFcwN2gwTVVxTkRnYlNP?=
 =?utf-8?B?bUNIeWU3b1pxZnc4c3Fpak5nMDNHQW5SVVhCM2VISGNzRHBqNjFxMDkvbElH?=
 =?utf-8?B?Q2RxaUN5T0dYcjltWVF3OGVuTWVXaTQzTk11Ymo0NkxUc1NxOGNYeDUydjM1?=
 =?utf-8?B?LzZPRnpIaWF2V0x3bFZlVVJRSTZKUi85MUllZ2RZUXZ4SS9kSjVRNDQ1Z3g1?=
 =?utf-8?B?ZXFvT21IbEx3OENRbll2NWh0Y0JaT3IxeWJLa1lMWEd1RnA5cUZnbG5aVElo?=
 =?utf-8?B?Tmh3NndEcmJpLzc0VzNHTXJMblYwcndoT3lHNWoyVTBlTmJ3Y3RiWDlXZDB0?=
 =?utf-8?B?OTA5VWVzVXhybTliZmdyY1RvSDFKclE3cnZmY1p0b01VK0YyTGNvR0N2cGw0?=
 =?utf-8?B?cmNoNDBDUU9FajRMU0RMQm5Rd0JpandydEVEYWpRK2VNR3JtN1Y2VER5b2ZN?=
 =?utf-8?B?WTJMeGkzSTJIS2I5aHZkcldoQ0p5UWcrMC9FWG1BOFhTQUFqRXJIQUlRVytT?=
 =?utf-8?B?UExNdW9VSjJja0RXYkpBaUNiVDh6bWtiMXBaaCtQaDNZL01RYlhrNEUrZnFB?=
 =?utf-8?B?bzU1cWtDOGZUbE14UzkwYUE1WG9jTVRHR2dxaDhMSGs5aTVUeXhFcUVLY3RD?=
 =?utf-8?B?RnhlMHYySDk5S3Uzcmc2WTJYcS80U0MrbDNlb1J5dlRyRStQZHFkTnBhZENz?=
 =?utf-8?B?eXhWN1o5TGg1NEowK3BWT2FLcUFmbkl3QlQ4L04ySWZjWjVhaTErMEYxWEtu?=
 =?utf-8?B?VzNUVncraCtZMFJVckNMbVVCcUxHME1nRjJFVzhodm9YNm05V1FGN2pDVUpT?=
 =?utf-8?B?OVVYeUwzdzJmanVVT0plelhzbGFETFUzdkhXejhtdUFHMmtuRHdmemt3enZj?=
 =?utf-8?B?WmFHcEdvRzVKRGNrZFpOaDdHb2V2aGR4bnMxNHArMmR4L2drSmM0Wm41cFVJ?=
 =?utf-8?B?MmFMK21QSzlZNnZFUThZU05NZDJCaTJwOVFacU5VdmpRSm11SWVTSnU5Mkhi?=
 =?utf-8?B?MENGOHlxQmNNNlBwb1ZZUGFFMzRtWTJZMW9yUi9Ga1l3bndoU0Fyc3hIQjBC?=
 =?utf-8?B?UksxVTd1YjRKWGhNc3FWU3dCUXVWL2wxNmp0SWQ0RmcxN1R5S1dVZ2J5aWk4?=
 =?utf-8?B?dFhJV3VpMWpCWE5aK1UvelN2bjZSSkZNVzRlVFNvVDNrWEdIMjFiNXRRNnY5?=
 =?utf-8?B?M2hveSs1djJBQkIrNTczVjVHaUYvdlM4VnArZjg1NkdKUUpBTHZqcmg0Sk40?=
 =?utf-8?B?WENFZlZSK0ltWnFwdUJJR2diLzByaW4xVmNvV0VsN1RSdGtSSHh5TmhDOVcv?=
 =?utf-8?B?ZENQOWx2SksrYnB1ZmFsSWpXZzFUT01SdVVvMEdLWGJnWFJkY3ljbStiY3pR?=
 =?utf-8?B?M3ZHWW42TkJWSmRsU2ZmQjJFc1o0MlBVa1pKOHNuM1hGUW95SW5DSWhCRWJG?=
 =?utf-8?B?NTE0SFBtNFVUMzVXZW5YeFRNUTcvNkhHb0FTcHFCajdtNXNiRzNjc1RTay80?=
 =?utf-8?B?Uk83ektQbC9CajBZM0UxT1FQMUpuL016V0Q4d0ZBK3Y0QTdXQmdsOS9PYkZP?=
 =?utf-8?B?ck9WUmV3RkpjMFhIaE5VR0RkVG9OMkp0RW9hQ0wrdmRzVnVabURXRUV6eTJn?=
 =?utf-8?B?bWk0MHJpTCtneDllclpKd3RCWE83a1hqWVg5V0xUbjZaSUppczg1QVRQWGdu?=
 =?utf-8?B?ZTlpekFCdVdiZGpYUWxBQjBseUVqN0I1WGNIMCtBTDVQdEJyd3R3M05Ydmhi?=
 =?utf-8?B?NW5iSEFYMHVJQUNEWGZFVnEzUzRjVG9jdE9Ha1pXNllKMEJFYlZEMzlHclVO?=
 =?utf-8?B?cTFuUWxCazdZdGxtcEVNcmYrSjNBVVUyR2N6Y1d5VXBzWDhyOCtRMkhrTTIy?=
 =?utf-8?B?RnY2Slpnc1NrbjVqTi9KSGVHVW0wOVFMWTlmdGhhSktuTEJ2QUZwOFFNUTBJ?=
 =?utf-8?Q?UKmE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c1a636-c2e1-4c19-f67b-08dc493c57d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 00:17:49.9956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OP1k8Oalm/2H36rjTpQ/gIdWq1spqGv6lyoQDPGeNTZUx7FKsBOg3M+jMKbnGtJZyWs+eMyfaXEsHThUVcex2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogYW1kLWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZz4gT24gQmVoYWxmIE9mIFd1LA0KPiBEYXZpZA0KPiBTZW50OiBXZWRuZXNkYXksIE1h
cmNoIDIwLCAyMDI0IDg6MDIgUE0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IENoZWNrIGNncm91cCB3aGVuIHJl
dHVybmluZyBETUFCdWYgaW5mbw0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRl
ZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3Bl
bmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+
IE9uIDMvMjAvMjAyNCA0OjIxIFBNLCBGZWxpeCBLdWVobGluZyB3cm90ZToNCj4gPiBPbiAyMDI0
LTAzLTE4IDE2OjEyLCBGZWxpeCBLdWVobGluZyB3cm90ZToNCj4gPj4NCj4gPj4gT24gMjAyNC0w
My0xNSAxNDoxNywgTXVrdWwgSm9zaGkgd3JvdGU6DQo+ID4+PiBDaGVjayBjZ3JvdXAgcGVybWlz
c2lvbnMgd2hlbiByZXR1cm5pbmcgRE1BLWJ1ZiBpbmZvIGFuZCBiYXNlZCBvbg0KPiA+Pj4gY2dy
b3VwIGNoZWNrIHJldHVybiB0aGUgaWQgb2YgdGhlIEdQVSB0aGF0IGhhcyBhY2Nlc3MgdG8gdGhl
IEJPLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IE11a3VsIEpvc2hpIDxtdWt1bC5qb3No
aUBhbWQuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9jaGFyZGV2LmMgfCA0ICsrLS0NCj4gPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYw0KPiA+Pj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+ID4+PiBpbmRleCBkZmE4YzY5NTMyZDQuLmY5
NjMxZjRiMWEwMiAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9jaGFyZGV2LmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9jaGFyZGV2LmMNCj4gPj4+IEBAIC0xNTIzLDcgKzE1MjMsNyBAQCBzdGF0aWMgaW50IGtmZF9p
b2N0bF9nZXRfZG1hYnVmX2luZm8oc3RydWN0DQo+ID4+PiBmaWxlICpmaWxlcCwNCj4gPj4+ICAg
ICAgICAgLyogRmluZCBhIEtGRCBHUFUgZGV2aWNlIHRoYXQgc3VwcG9ydHMgdGhlIGdldF9kbWFi
dWZfaW5mbw0KPiA+Pj4gcXVlcnkgKi8NCj4gPj4+ICAgICAgIGZvciAoaSA9IDA7IGtmZF90b3Bv
bG9neV9lbnVtX2tmZF9kZXZpY2VzKGksICZkZXYpID09IDA7IGkrKykNCj4gPj4+IC0gICAgICAg
IGlmIChkZXYpDQo+ID4+PiArICAgICAgICBpZiAoZGV2ICYmICFrZmRfZGV2Y2dyb3VwX2NoZWNr
X3Blcm1pc3Npb24oZGV2KSkNCj4gPj4+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4+PiAgICAg
ICBpZiAoIWRldikNCj4gPj4+ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPj4+IEBAIC0x
NTQ1LDcgKzE1NDUsNyBAQCBzdGF0aWMgaW50IGtmZF9pb2N0bF9nZXRfZG1hYnVmX2luZm8oc3Ry
dWN0DQo+ID4+PiBmaWxlICpmaWxlcCwNCj4gPj4+ICAgICAgIGlmICh4Y3BfaWQgPj0gMCkNCj4g
Pj4+ICAgICAgICAgICBhcmdzLT5ncHVfaWQgPSBkbWFidWZfYWRldi0+a2ZkLmRldi0+bm9kZXNb
eGNwX2lkXS0+aWQ7DQo+ID4+PiAgICAgICBlbHNlDQo+ID4+PiAtICAgICAgICBhcmdzLT5ncHVf
aWQgPSBkbWFidWZfYWRldi0+a2ZkLmRldi0+bm9kZXNbMF0tPmlkOw0KPiA+Pj4gKyAgICAgICAg
YXJncy0+Z3B1X2lkID0gZGV2LT5pZDsNCj4gPj4NCj4gPj4gSWYgSSByZW1lbWJlciBjb3JyZWN0
bHksIHRoaXMgd2FzIG1lYW50IGFzIGEgZmFsbGJhY2sgaW4gY2FzZSBmb3IgR1RUDQo+ID4+IEJP
cyB3aGVyZSB0aGUgZXhwb3J0aW5nIHBhcnRpdGlvbiB3YXNuJ3Qga25vd24gYW5kIHRoZSBhcHBs
aWNhdGlvbg0KPiA+PiBkaWRuJ3QgaGF2ZSBhY2Nlc3MgdG8gdGhlIGZpcnN0IHBhcnRpdGlvbi4g
SSB0aGluayB0aGUgd2F5IHlvdSB3cm90ZQ0KPiA+PiB0aGlzLCBpdCBjb3VsZCBhbHNvIGNoYW5n
ZSB0aGUgYmVoYXZpb3VyIChyZXBvcnQgdGhlIHdyb25nIEdQVSBJRCkgb24NCj4gPj4gc2luZ2xl
LXBhcnRpdGlvbiBHUFVzLCB3aGljaCBpcyBwcm9iYWJseSBub3QgaW50ZW5kZWQuDQo+ID4NCj4g
PiBOZXZlciBtaW5kLiBJIGRvdWJsZSBjaGVja2VkOiBPbiBzaW5nbGUtcGFydGl0aW9uIEdQVXMs
IGJvLT54Y3BfaWQNCj4gPiBhbHdheXMgc2VlbXMgdG8gYmUgMC4gU28geW91ciBjb2RlIHdvbid0
IGNoYW5nZSB0aGUgYmVoYXZpb3VyIGhlcmUuDQo+ID4gVGhlIHBhdGNoIGlzDQo+IHNob3VsZCBi
by0+eGNwX2lkIGJlID49IDAgZm9yIGFsbCBjYXNlcz8gaWYgeWVzIHRoZW4gSSB0aGluayBhbGwg
dGVzdHMgY2FuIGJlDQo+IG1vdmVkLiAobGlrZSBiZWxvdykNCj4gYXJncy0+Z3B1X2lkID0gZG1h
YnVmX2FkZXYtPmtmZC5kZXYtPm5vZGVzW3hjcF9pZF0tPmlkOw0KPg0KTm8gaXQgY2FuIGJlIC0x
IG9uIEdQVXMgdGhhdCBzdXBwb3J0IHNwYXRpYWwgcGFydGl0aW9uaW5nLCBlc3BlY2lhbGx5IGZv
ciBHVFQgQk9zLg0KDQpSZWdhcmRzLA0KTXVrdWwNCg0KPiBEYXZpZA0KPiA+DQo+ID4gUmV2aWV3
ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGluZ0BhbWQuY29tPg0KPiA+DQo+ID4N
Cj4gPg0KPiA+PiBNYXliZSB0aGlzIHdvdWxkIHByZXNlcnZlIHRoZSBiZWhhdmlvdXIgZm9yIHRo
YXQgY2FzZToNCj4gPj4NCj4gPj4gICAgIC4uLg0KPiA+PiAtICAgIGVsc2UNCj4gPj4gKyAgICBl
bHNlIGlmDQo+ID4+ICgha2ZkX2RldmNncm91cF9jaGVja19wZXJtaXNzaW9uKGRtYWJ1Zl9hZGV2
LT5rZmQuZGV2LT5ub2Rlc1swXSkpDQo+ID4+ICAgICAgICAgIGFyZ3MtPmdwdV9pZCA9IGRtYWJ1
Zl9hZGV2LT5rZmQuZGV2LT5ub2Rlc1swXS0+aWQ7DQo+ID4+ICsgICAgZWxzZQ0KPiA+PiArICAg
ICAgICBhcmdzLT5ncHVfaWQgPSBkZXYtPmlkOw0KPiA+Pg0KPiA+PiBPciBtYXliZSBhIG1vcmUg
Z2VuZXJhbCBzb2x1dGlvbiB3b3VsZCBtYWtlIERNQUJ1ZiBpbXBvcnQgd29yayB3aGVuDQo+ID4+
IHRoZSBleHBvcnRlciBpcyByZWFsbHkgdW5rbm93biBvciBub3QgZXZlbiBhIEdQVS4gVGhpcyBj
YW1lIHVwIG5vdCBzbw0KPiA+PiBsb25nIGFnbyBpbiB0aGUgY29udGV4dCBvZiBpbnRlcm9wIHdp
dGggM3JkLXBhcnR5IGRldmljZXMuIFRoaXMgbWF5DQo+ID4+IHJlcXVpcmUgdXNlciBtb2RlIGNo
YW5nZXMgYXMgd2VsbC4NCj4gPj4NCj4gPj4gUmVnYXJkcywNCj4gPj4gICBGZWxpeA0KPiA+Pg0K
PiA+Pg0KPiA+Pj4gICAgICAgYXJncy0+ZmxhZ3MgPSBmbGFnczsNCj4gPj4+ICAgICAgICAgLyog
Q29weSBtZXRhZGF0YSBidWZmZXIgdG8gdXNlciBtb2RlICovDQoNCg==
