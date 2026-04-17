Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F91F436BF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 18:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 257E310EA90;
	Fri, 17 Apr 2026 18:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HnGEG9DS";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 470CA10EA90
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 18:51:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmenDg3CADtlD4F3+ig59vCR/g+cADZcwLEO4z0avpo3AgKKN6LmGtnBmM4uNhKWf8Xeqlz0pF2M/eIMeLmkC4VZSpmaHLtHQ8Wk07c0zVMVnRcQPSAjxoop1ADv+EHhLM0fvD9CNLXE0JTvvAmgcA4HuhfaQ492FvbPiK/6k1UXH2xpTJzfQKrSWiDTm4+TJDTdk5EZfYAl5FObofI7GJcciYAd4HNZpCI7Pwt+RlLgFOhJ+jRX+C8WWp9CxWstxzg1SIIqFY8gI4g9ou2jwCbcgw4iSeLqABNsOdCSQ+qp3LfPt9DdI0mSiLyjbBtgzHmRGzTL60msMt5BsM1Rdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Psn4Uxw24z029NSn8LluFTYdCZ1MuzLwbhgunUPd5/k=;
 b=r187i9R6nrViSrDxckHRheuhdhyTNYFa7wiJQT/F0/gzLgfLnoKL+EujPyVSQt+qBQWJiemkzRSI+5z4ig8Vds3eHHZYRGQ896QTidaiirRsf7wpa8OQ4ZhhOcY5P0ePZ45nCHRbmf3QVl8broJjQYz8pBUWjdDjk/uVkanLqDu/cO/enJ83DHztkqu92YxKf5U9R1ZnRd6fV56cL0Pz+7bY6BodNOOx5Jw7QsHCvvzIT4CQdn88AtKLPb7V5Mn2Q8ezpKY+XLU/+NgiLzGeoXL5fOX/OTzmJzdOcwEmewFiDSorG5/ERzx51+0RxqFp+zzPdZPDLpVfBNVSav8Alw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Psn4Uxw24z029NSn8LluFTYdCZ1MuzLwbhgunUPd5/k=;
 b=HnGEG9DS010UEwYpViCZYXGghoT9KCAvAXUScQjAWBrjKix6Mk3h2k3M7c1Uqc6YLuOJ8bcRvZESnHZF7FNxiJ4vSY+mdzPo9NVz1Qxz2rOGzwoLoj4lSdzD6f2dBjLhmxw7yLNGcbO8qdN+fq83n/zo6jojpXaBdph5n8bz5wM=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 18:51:53 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 18:51:53 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 08/16] drm/amdgpu/gfx12.1: align mqd settings with KFD
Thread-Topic: [PATCH 08/16] drm/amdgpu/gfx12.1: align mqd settings with KFD
Thread-Index: AQHctuDOTx09f8686UObTZz57jHwebXNd5OAgBZBLwCAAA/4MA==
Date: Fri, 17 Apr 2026 18:51:53 +0000
Message-ID: <BL1PR12MB58981148312ECB64334E2D1285202@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260318140837.582776-1-alexander.deucher@amd.com>
 <20260318140837.582776-8-alexander.deucher@amd.com>
 <CADnq5_N-b61C4=n_L87J6Pyf_Tv7UCGse317qYzECPtK_OgnZw@mail.gmail.com>
 <CADnq5_N-r_Y=p-n4BM3C_-KouuLkapiNbjYvcEcg2J3j512cXw@mail.gmail.com>
In-Reply-To: <CADnq5_N-r_Y=p-n4BM3C_-KouuLkapiNbjYvcEcg2J3j512cXw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-17T18:51:46.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|LV2PR12MB5944:EE_
x-ms-office365-filtering-correlation-id: 37c437ee-345c-44da-7b83-08de9cb26478
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: vRw9dGcUVKXbZdo10M01hhS7JHlQQqQujhTcYoQVsEN7QyGghVcqvIPICeww1Yw2WwuRsmHMHDpdQEf94Nl27uwM4kXcy4/XWuYd2BkqgegE6QeuC1PsomQmUlSj6iYHRmnjXuSMP0msjAuLlRy5cAx0JJq/MLgX4o3kz/664lqOIYWIxFsM/5cZBJPMAv+tGd2Nmimni3DrT3gFKRb/+TMb5BKJZIqjJEoWSEGzTuAzoG7bF83Pd+FsUD5gdkv+h+stp+5zel8OKMqvaDJvO1jDyjQ+WU6Co7IP4Z6sN+UjmTkwtH5btF4ZJ4VNpKEoaiLZWR2EL167RVOU5NKk49x62S4cg6MpNRn4zMB0BG9esMD5i+EZ3j5hhhUmmPc9+mZPDKnQ5QEPrw+1CVmvtnAKr8uSKBrYOZUwG/HUw0K45dTx6cAHzfH/IUTR0KZdpLwj/yIHYiAU7+jV/LXLJP0VnU3a08W3EohYjospE561Jv451NMri6Xn/3bKWEmPZhVGxJ5L9kdfXAvd3qq0Lm6Z6HvB1LZ6apjyO7hdKypLzPOe+daZc3cO7YqArgiflCdNuaUtGyPU7q5tUDweukXwHLT6Y1C/xq9AaEZhEjDcho75FWGDOXAgZb8LNXzKO1J5DfwRyx3NqS5LFwuA13xl68EuaV2W/iT2KOaI3mA8AMaqeYjjr5x9I7a212RLbEb4FWFsvw2l8q4DVQrxAIFQsx+UUKR/vlTlK3L2FNFqI2X1X4XNL6Zde5h+bSmMERRHL5/FxXciBQ1B2RXoCfflbq3GW2iiwq8+sE7xLM8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NU1DUG14cWpKTVNoS3NTak5wTGtDOG4rcFlEbVN6RXQzdm52RkpvMzdaSklX?=
 =?utf-8?B?UzAzZlFoQzQzZ0NxTVhwdm80enpkQmVWellxWHUxRTJuaHg2Ym4yY0RmbzZq?=
 =?utf-8?B?cjl2VmRPeksxYlU1MmNUSDdqVFM1Y21jOCt0NFBGcTBuaG9xbm9rU1lZWHo2?=
 =?utf-8?B?SDc4bmRQc3VnSk0zSVQ5bm1MOVc5SHcrQzYyUlIxZzBoWG9aZ3pGN2lwNk1a?=
 =?utf-8?B?Y0RLSHdVVDBnMzFJTkhpY3NkQzViMHoxMDkyNVhEY1ExUkk4K1lYbUpBdkh3?=
 =?utf-8?B?bWlWSWMzNGlrMmVudFA3Yk42ZkdVdWgzMlV5b1hXTVVlVm5oWGtRTEQ1Z05a?=
 =?utf-8?B?U0NLUm9FeWZrZkc4aWMyNUwrL1JZOUtZT3ZrcHIzWjdycndpRDQxUUV2NWdU?=
 =?utf-8?B?dzVKQUhzelRSMlM2b3F0N21MdE5tS1ZCMnFENUVnK1E0dzBWUVQ1a2lDb2cy?=
 =?utf-8?B?KzlUeDFMYzloaWJTTE5aWmpwTUd2cDczS1A4L2JsdzhXa0w2OEFFNTM2MHlL?=
 =?utf-8?B?R1BQOUhqdWtUTThuQlpia3JqYjRXR25ta0R1dEhhdk1VODZJaktVcEg2TC9O?=
 =?utf-8?B?QVdpOHgvT1YrOEVZQVN4RVZLZ2RrZ0Jpb3hGM0NGVDhabVRTWXJQNzAxdzlK?=
 =?utf-8?B?QWNza3YzWkVtcGM2VmNIKzJyNGpRMy82aTlVa0RPcFh5aHZDSzhqZ3k0cCtT?=
 =?utf-8?B?Y1RPSWd1TFl2RlVhVGZzSldER3FQejd3eWNsSjZGcmlJTURCTTlaQlVCdFhs?=
 =?utf-8?B?d0IwSXoycVdlR1VSWmJpVVM4TEg2WmppTFo1cUdraTI4NXdNeC9LcC9lQU9r?=
 =?utf-8?B?dno3Ly90eDZmRGJiY1c2K3NsT2pPUDJjSGRMRWNva3pJUHF2T3pRRUdnWlNV?=
 =?utf-8?B?MXJSbHlRT0oxbkFCcno3Z2dhcWdFMUlyVmhKUXh2a0JGZm1mUmFxcWhvN1VX?=
 =?utf-8?B?U0RIblVXcVhkT0F3WmtMOVFIeDFzdDZWRVJFbkdIa3Zhci9rQWRVbW5jQUs3?=
 =?utf-8?B?WlU4UUkrNWprUHVHR1YxQVpIU05yUE1UczM3NFNGMGhOdU9XSGcrc2w0Mmpt?=
 =?utf-8?B?SnV3Q0tPV0pPdlZYc3lxcFM0cTJHdnVrV1NiaFhpeDZCcjlvMllIVmI4MTMz?=
 =?utf-8?B?Um52VnRESGI5RzlCSmpSOGV3TWl0RnlHbytpQWtlTUdGZmFOWGFiL1p0S04w?=
 =?utf-8?B?MXVobk1rYStKOWlQYUlieERJb0I2b0lPakc4NldscXNxd0tsRW4xbks5TEJ6?=
 =?utf-8?B?VytGYUFyTjBST1BjbENoNlVQaVdidDY1VUNhSXdIV3NyakxXOHZtdkI0WGNM?=
 =?utf-8?B?dklFZVhVVGFDOHVYTTFGOE1LWnZtTzZVOHdxK2NjcElZaGpLN1FuNTU4NERD?=
 =?utf-8?B?d3B3aXNlTXEvektoVlhHVU9WWlRTZSs1bVFrcjlvc0YrbmR6NXNLOHp5NVNr?=
 =?utf-8?B?M2xJL3M4RWxMYzR5OHVoeEdocG1meG5BUUNCNkI4MUs5QzJVUFc1NFlYMEM0?=
 =?utf-8?B?QXVvdnlKa3NyME5HcFZ0MDROMHJ1allFYlVyQVlqdkVTa3haSTd3cmVMWnpv?=
 =?utf-8?B?blViVE43cGZMRDBsVktSNExyNHNqK1B2TWRMSVlCU2Z1Q0dIMDFvRm11cjV5?=
 =?utf-8?B?aGRTVDd1emI3WER2SE1SblhaODRLZGI5ZVZObHdhc2oxTTYrV25VUk1RODlt?=
 =?utf-8?B?SndVanZ2T3lLcmhveUNSZUxIc0M0czkvZDdneFZzdHM5S3lVL2hKQ3FJRjJz?=
 =?utf-8?B?SmdqVm5EMHVuMFd6NE05OWZ6Vkkrc0tzMktWU3kxNmorRUVtWHVYdUhtR2ps?=
 =?utf-8?B?QmNibGlGdFA5WEJDc3ptcUM1aWVKUUp1bGd5blFsdURsTVJzRkh5VWVDZGVz?=
 =?utf-8?B?TkJMQkYxZEJieVlqVXlYVmNxNnp0aWpvVmJPbFIzUHZVQ3BFY05WYVdvdlJS?=
 =?utf-8?B?ajBWalhERURHRGw1eVdhS3FkMlI3ODZac3pHL24vWEYvY3ZvOGRJT2NxR2t1?=
 =?utf-8?B?TUgwaTY2OXBoMEhRQ0paQXYzNlJpYkhkTklKNTlVTlRXK081REZnUEhyTXp5?=
 =?utf-8?B?VGl0UUgyc2xaT0s5UFJ5ZFlFa1Z0RHN0bGNmQVVmdndFVUh2ZjJoR3NudW5P?=
 =?utf-8?B?alZaUkZZSXRCMDMxYllkOWVoMjNzQmlKcFdseFkrS3k1VW1OcXdQc2t3eFZm?=
 =?utf-8?B?ODZ6a2RuWVorWUY3RXQrV3V3N0xCN0FYZSs4Z3dYNmx1WHZUbzRUNTlHRHdl?=
 =?utf-8?B?SHd5MC9KWmFGNGlGNUpiYWU4dTUvNDAzZzJ1VXBxM21lWkFHR1ZySkltRVFw?=
 =?utf-8?Q?IjikTaaNP3CUrF3GhG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c437ee-345c-44da-7b83-08de9cb26478
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 18:51:53.6886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1M4C1Z9uWnAS/M5jS5vRY2ZqIvQwJukPDbVRX8ISuzXbhn6dyqvRAp4+ZNYQ7v5jmonz1WrjA2m2Yd/2nD9VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
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
Cg0KUmV2aWV3ZWQtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFtZC5jb20+DQoNCg0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngt
Ym91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBBbGV4DQo+IERldWNo
ZXINCj4gU2VudDogRnJpZGF5LCBBcHJpbCAxNywgMjAyNiAxOjU1IFBNDQo+IFRvOiBEZXVjaGVy
LCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDA4LzE2XSBkcm0vYW1k
Z3B1L2dmeDEyLjE6IGFsaWduIG1xZCBzZXR0aW5ncyB3aXRoIEtGRA0KPg0KPiBwaW5nPw0KPg0K
PiBPbiBGcmksIEFwciAzLCAyMDI2IGF0IDEwOjAz4oCvQU0gQWxleCBEZXVjaGVyIDxhbGV4ZGV1
Y2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gUGluZz8NCj4gPg0KPiA+IE9uIFdlZCwg
TWFyIDE4LCAyMDI2IGF0IDEwOjE54oCvQU0gQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPg0KPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBNYWtlIHN1cmUgdG8gc2V0IHRoZSBx
dWFudHVtIGJpdHMgaW4gdGhlIGNvbXB1dGUgTVFEDQo+ID4gPiBmb3IgYmV0dGVyIGZhaXJuZXNz
IGFjcm9zcyBxdWV1ZXMgb2YgdGhlIHNhbWUgcHJpb3JpdHkuDQo+ID4gPg0KPiA+ID4gU2lnbmVk
LW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+ID4g
LS0tDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMl8xLmMgfCA1ICsr
KysrDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEyXzEuYw0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTJfMS5jDQo+ID4gPiBpbmRleCBkYjQ5
NTgyYTIxMWY3Li45OGRjNjU4MmI3YWE2IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMl8xLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeF92MTJfMS5jDQo+ID4gPiBAQCAtMjI0Niw2ICsyMjQ2LDExIEBAIHN0YXRp
YyBpbnQgZ2Z4X3YxMl8xX2NvbXB1dGVfbXFkX2luaXQoc3RydWN0DQo+IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsIHZvaWQgKm0sDQo+ID4gPiAgICAgICAgIG1xZC0+Y3BfbXFkX3N0cmlkZV9zaXplID0g
cHJvcC0+bXFkX3N0cmlkZV9zaXplID8gcHJvcC0NCj4gPm1xZF9zdHJpZGVfc2l6ZSA6DQo+ID4g
PiAgICAgICAgICAgICAgICAgQU1ER1BVX01RRF9TSVpFX0FMSUdOKGFkZXYtDQo+ID5tcWRzW0FN
REdQVV9IV19JUF9DT01QVVRFXS5tcWRfc2l6ZSk7DQo+ID4gPg0KPiA+ID4gKyAgICAgICB0bXAg
PSBSRUdfU0VUX0ZJRUxEKDAsIENQX0hRRF9RVUFOVFVNLCBRVUFOVFVNX0VOLCAxKTsNCj4gPiA+
ICsgICAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQX0hRRF9RVUFOVFVNLCBRVUFOVFVN
X1NDQUxFLA0KPiAxKTsNCj4gPiA+ICsgICAgICAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIENQ
X0hRRF9RVUFOVFVNLA0KPiBRVUFOVFVNX0RVUkFUSU9OLCAxKTsNCj4gPiA+ICsgICAgICAgbXFk
LT5jcF9ocWRfcXVhbnR1bSA9IHRtcDsNCj4gPiA+ICsNCj4gPiA+ICAgICAgICAgbXFkLT5jcF9o
cWRfYWN0aXZlID0gcHJvcC0+aHFkX2FjdGl2ZTsNCj4gPiA+DQo+ID4gPiAgICAgICAgIHJldHVy
biAwOw0KPiA+ID4gLS0NCj4gPiA+IDIuNTMuMA0KPiA+ID4NCg==
