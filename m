Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CBDC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 15:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4643510E242;
	Fri, 14 Jan 2022 15:38:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8128910E242
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 15:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHAtpeZe75SVOcXOHycTTSUHKonP4ZRNGJoHJwHQI8ejdqPMwqvKnCyvyp/Xm6Lw2eZYW0MULYvjpWKfEwHIuT+zOHM8fjIZznVUsz8AAFdZ47NcyC+s6vtf0isNEgFP8oIyidRjdVpFCJxP6/7Kmw3mQGvaJF9K3eKIsYjd1JGlVhSEyp9pWLRHO7sfMkn7lccCD2DfaREAp0ibVX02DQzf5zM9nnopYrSh0EkrPXggJjhsPPPZre4EzFA3FyB9HvPQpDOIOyuL6LLSfNy2mrjnd/1OCklKNfHUPX/RRMwwb1CrtaNMo9DEwIDnZwwaTRkmLSrHrjnx08VWohlAYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PB7q9hZ3Nj2P8L/uzPEKMfjItcEY0GhcG8cGE86aMbk=;
 b=ZNRq5QbTIF9BFNQFXArac8+YB6Fl3u/l7c1A1HylmoDZurwc9q6eQQOL7Fao3yNWeKElgywcDmzutuirTWHWkEbXVbW3ab9nt5U7VhqGkxSADI1Ox1vt2Bk8c73uVLVLw+MS0/9Cbnef3m7iGNqhUZryFrztbvvger9VIcv9C8fUzFCazjgpFHgSD5YlBuWeq6ygTfYiajG4eqQ9JAIevAFoag/2/WAWWZneNhEa6XcJe0mve1tHNv1UVWHznUIz4ImtCtZ+5NApNEEvsWyLtcncFMV/PA0WO1o7FNluVXA79mXwLgyiux17SRKMxZ8l1x8KBUAW0HBrSl9gxgMG1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PB7q9hZ3Nj2P8L/uzPEKMfjItcEY0GhcG8cGE86aMbk=;
 b=Aojyz2PWSBIfDI3JlGVHlejtmHRf5+0OeW2AFH4Cus2BfzgSbORqn67ga6j3GTWcqmfqU2fH2vOTbMmqFYfBSMm7yCXXAnGrG2nLovAczg8irPx14+TAlGHSTCalyPE1PdmrZOX6/PafJ+cKDVGOI09pQ4Ia/IsMLgTWNICGzGg=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by CY4PR1201MB0261.namprd12.prod.outlook.com (2603:10b6:910:1c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 15:38:22 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 15:38:22 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Chris Hixon <linux-kernel-bugs@hixontech.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
 DCN20/DCN21
Thread-Topic: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
 DCN20/DCN21
Thread-Index: AQHYA+aejevROlcgOU6dQwnYNuIzeaxXxwkAgAAeeiCACpYLAIAANTxA
Date: Fri, 14 Jan 2022 15:38:21 +0000
Message-ID: <BL1PR12MB5157374DD79D0BF24D907DE3E2549@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220107164959.12511-1-mario.limonciello@amd.com>
 <DM4PR12MB51821C74C0F9C8254A8CE048EC4D9@DM4PR12MB5182.namprd12.prod.outlook.com>
 <BL1PR12MB5157D5DC6BE941A1C1294DFDE24D9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <991bfaea-2978-321d-deb8-cefa4572877e@hixontech.com>
In-Reply-To: <991bfaea-2978-321d-deb8-cefa4572877e@hixontech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-14T15:38:19Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c4c08a8c-47c3-4021-8bae-3a9ce83b7385;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-14T15:38:19Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: ce1efe4b-cd31-4ce0-ba57-38e9d88b358d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0b89e91-44c4-452c-5ab7-08d9d773e577
x-ms-traffictypediagnostic: CY4PR1201MB0261:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB02619D7BF200DABCDFCBBA29E2549@CY4PR1201MB0261.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zIpC4Dsr5oyda4ZpihQQWx7Q41A8tHatvyGxgPJSR0rZFOmxSyULMKyWoH9M38v7WGBdyWxMo7zx3rkc53mD7CzSDCs/fIPaaYUzriCc+E72q7L0pTXFIiife54JFyX6w5pQk41MrJoXvHLShlM4vCN0QZ5TlR+6958IQxGnC0Y4NZwT617dewEwmY3G44KpPA9pT7TawICYGObjDzyZpoZwwrgGsc940FblcQpfEc6oZt3ultHW/iFeQaT9/wmL7a3RijVKIzRrsw2519io+Ee5R14ogQaJIgqlhRxEGLIhUFO64AjkCdnJAKUMZPXfRKvRSGtV32IYi1nr9sT2m/SkB7T+MVWWk2hdmd207yREGbG9M9B26zEk0qnKEIO4hsSW+tBnFsjcpXDDQMpw/N1GmcKVa97LAmvDpZ7ZXEzNUOPLk1pVtvlkta5hJ4PIO5RHKJyBVFpEDTRWRL22Bdf9YFXhngZbG4N2VoGRlXTjmL9C5mUanOwSbEBIrKeMPz5zlGPammKVUbrzefAWkLY9f4L0AetyLQVcADt0C121LCePa0w1qY0B5UeLuOTjz+Sn5Sw0yaVVgqlGP6E5WPgqmr+7qE+6BGbkbCjuzPxJaU3d2CWi0Kgy6KcT0p86JCoGr+akUkv1Xn2ArSDBoiYxNiulr6oi2ytf7ypqOx9Qr/mSsA0SqAzgGLy+mKDp5lk6+bN9NQ73NnvRIQpdbxhGbFZpKEYlc8c6QP5ixVg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(110136005)(5660300002)(64756008)(4326008)(66446008)(316002)(54906003)(33656002)(66476007)(38100700002)(122000001)(38070700005)(66556008)(66946007)(76116006)(83380400001)(55016003)(52536014)(86362001)(26005)(186003)(7696005)(6506007)(8936002)(8676002)(2906002)(71200400001)(9686003)(473944003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm9YUGVVUUdDTDVZY1RYazk4aUNUbmNib3Jnc21hOTZRZytSbnZyTE9sWSsx?=
 =?utf-8?B?MVNsSGhwMEpZTFh1dzhxTWxuMy9tRWw4cVpTTGVrbDhjWGhZRHpoMUJpQzUw?=
 =?utf-8?B?WUlVd00zYk5KMGUxNlVLWnVDMmF1dDlRNUFNQ3A5VGVZamhDYlVIdG5VSVg5?=
 =?utf-8?B?ZkNrQVYzeXh2NnBqSklwMzF2MVQzTW9wRDVqekc3L2tRMVdSbEhvTXhpUFNu?=
 =?utf-8?B?cnlEQVFaKzF2QWptR0c3WUg3aGpRenVIN202SlJyeHk3RHozRVlDZnEvSUY1?=
 =?utf-8?B?cUFhRW41ajUxVC9yU2xSUXk2VkZCNXFYTkw3bEFsNFZLL0M2RTkydytsR3hO?=
 =?utf-8?B?UHFOckFPVnphaUFsaDNXazlTU0hoOHE2ZHVKRFJsWExvNXUwZlJyVkhhTXo3?=
 =?utf-8?B?MURwUVl0U3VsRDJsNnkyVy9nS2U1SVpvTGViMXBEcWNlbU5DUWZsVSt3Zkll?=
 =?utf-8?B?R1Y0cWFCMlBGOVZiSlkxeFdtL3paTWs2RXBtZGZyZWQrSThOSmZGaGlDTjFU?=
 =?utf-8?B?UXVUeUhoei95Sk1rd2VtUzdpOU1QVlR1WVVZZXloOG5kbTBPMHczNmtxMUJQ?=
 =?utf-8?B?RHhFaXdKaU4xSmIvSHd0eDF6Nk1BaTFMQmJaYy9OWHNwY2VGZTI4NlRjUkg5?=
 =?utf-8?B?Ums3VEkvK0l1Vm5GRklzU2V4ZnBrbTRTYzYvWUQ4eW1vRlJJWmNyOTVJZFNm?=
 =?utf-8?B?ZGQyWXRLWDhVTk5CdU1IVnZnT2Fla1BXZWsvU2NKUXBQTGZmYWlJRnNjaUlR?=
 =?utf-8?B?SXF5eFE3QTlaNk9BTGszVWxzeU1zYTJwejN0S0JHUWxLOUJ6WFhTbldveGxR?=
 =?utf-8?B?aU9GS2ZaSm9jbDZ5VVZEdEFsTFBTLzVKa0w1bjhyVW5waytkaks0dWxSdWxZ?=
 =?utf-8?B?N2lzU1RXaUUwTmtSSGl5S0MrY3RrUkthalk5MVVyUWlsdHExd2toeGx6NFNK?=
 =?utf-8?B?QkV0ZElvOVl1WWFMWDBuS1lqTVhMbDRRclNLbzZ2OUUwSHFRYlVnaDMxblZI?=
 =?utf-8?B?SWVJaERKSkNVaTRUV3lrdTIrTDUvL0hCM0crbElSaXNBRkd1SG5JeVdCVVQ3?=
 =?utf-8?B?SFpTd294K3poOTZodGNhSXlyRFYreXpQaE9IVFY2cGtSMTFhdjl6YnQrVGRH?=
 =?utf-8?B?cndNT0VyUFVZTEtrR05QYmoxUytCQi91bFJaV2hGbnEwUVl3RVBSMzRVYXJu?=
 =?utf-8?B?dnhWWE9vYnB2b0tsR3BtRGxVYk5XYnF4NHc0SVpyUm9QODJ5cnhtc2k3VXZO?=
 =?utf-8?B?di9aRU1Ld2NMYmxKUXJ4QVd2VndSR2Y0eWZwNGpUSUt6UzQrQlY4TVE5TE1z?=
 =?utf-8?B?dnJQUmtIRlI3YlVLM2ZNRHY4eW1Sb1Q1NldGYU9yQjJacEk1MlhqanZlQUFR?=
 =?utf-8?B?ZFR0aStBU1lTczhUYUd3ZlY4YW85RzV6M25PRmxVRytSZkJLOSs2MC9Pd3Nk?=
 =?utf-8?B?V2ZrL3RyS2ZTQUphNUYrNUM2TmxXa2x0SWh6Mjg4cVpoeVhSbkh6cVZTY2pp?=
 =?utf-8?B?RVhDb2JSZ0pZQVJ3NWc0cVJ4RjRhbGtHOVh0U0NVU25zN0pmSjZYdnI4VS83?=
 =?utf-8?B?SzJ5R0lJOEt1T0xUSGVTWXZmMHhkMmxqRExIamV5VncxM1BtVHp0SWU4VUZU?=
 =?utf-8?B?YmxJSzFGamsxaWE3T01GMzZTSzhYUUtIdktDNERpVHFyNGFXV3VIMXhlaUw3?=
 =?utf-8?B?akVoTXNxUVBqWmFnbmhVL2VvVlRwNWJkU2FDbTZZZ3lad3ZNQ2w2Q1RvejNM?=
 =?utf-8?B?YzZJMWRYQi8xcmR2YjlqVUVvNUk3a2lpbjU4bkVlZXg0MzY5K3VmaVZXdEJH?=
 =?utf-8?B?VXRzTldlMDdsYXBVUHpXcUlwOEFJOEtWOEFoVndGUXdXZW9jLzZGUnNUbkgv?=
 =?utf-8?B?YXdvYWowYXRVOTE5MjIyMG82ZU9OOFpEZVJpMExkMWUyTktGRGEwL2N0Rkhh?=
 =?utf-8?B?Z2UxYkhOV0ZxV1RUYlM4NzNjNG5IeS8zcDI0U3N4cEZBYVdYemhmbkFiaFhE?=
 =?utf-8?B?dXZMS0tOdEFVVGx0eDRYN3ZqK2FMQ3NrVHFsQ1dxbjdvc2xucmVnSk9xOGhh?=
 =?utf-8?B?eWN2ZXg3TDRFWFE2L1NNUGhyTzhMa1hNZnEzQldYS043QXo3b0hkNGIvYklX?=
 =?utf-8?B?bWFqSnJXODNwd1g4Mm1JR2RIRWJ4dVpnRlpkY2xYZWNIZVh0eUgrNDhrcTdl?=
 =?utf-8?Q?9YmfOHec8Ia0o8MCPxOy3ys=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b89e91-44c4-452c-5ab7-08d9d773e577
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 15:38:21.8920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UoEV7p5eKpYyicX5fEBHg8L6ly3sZjJNf/ccHlMili7kZIB4Ys1OU/6qAnldqFMemJJekquN+r0OJQ2aok9i8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0261
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
Cc: "Zhuo, Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>,
 Scott Bruce <smbruce@gmail.com>, "spasswolf@web.de" <spasswolf@web.de>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiA+DQo+ID4NCj4gPj4gSSB0aGluayB0aGUgcmV2
ZXJ0IGlzIGZpbmUgb25jZSB3ZSBmaWd1cmUgb3V0IHdoZXJlIHdlJ3JlIG1pc3NpbmcgY2FsbHMg
dG86DQo+ID4+DQo+ID4+ICAgICAgICAgIC5vcHRpbWl6ZV9wd3Jfc3RhdGUgPSBkY24yMV9vcHRp
bWl6ZV9wd3Jfc3RhdGUsDQo+ID4+ICAgICAgICAgIC5leGl0X29wdGltaXplZF9wd3Jfc3RhdGUg
PSBkY24yMV9leGl0X29wdGltaXplZF9wd3Jfc3RhdGUsDQo+ID4+DQo+ID4+IFRoZXNlIGFyZSBh
bHJlYWR5IHBhcnQgb2YgZGNfbGlua19kZXRlY3QsIHNvIEkgc3VzcGVjdCB0aGVyZSdzIGFub3Ro
ZXINCj4gaW50ZXJmYWNlDQo+ID4+IGluIERDIHRoYXQgc2hvdWxkIGJlIHVzaW5nIHRoZXNlLg0K
PiA+Pg0KPiA+PiBJIHRoaW5rIHRoZSBiZXN0IHdheSB0byBkZWJ1ZyB0aGlzIGlzIHRvIHJldmVy
dCB0aGUgcGF0Y2ggbG9jYWxseSBhbmQgYWRkIGEgc3RhY2sNCj4gPj4gZHVtcCB3aGVuIERNQ1VC
IGhhbmdzIG91ciB0aW1lcyBvdXQuDQo+ID4gT0sgc28gSSBkaWQgdGhpcyBvbiB0b3Agb2YgYW1k
LXN0YWdpbmctZHJtLW5leHQgd2l0aCBteSB2NSBwYXRjaCAodGhpcyByZXZlcnQgaW4NCj4gcGxh
Y2UpDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rt
dWIvc3JjL2RtdWJfc3J2LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9z
cmMvZG11Yl9zcnYuYw0KPiA+IGluZGV4IDkyODBmMmFiZDk3My4uMGJkMzJmODJmM2RiIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXViX3Ny
di5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJf
c3J2LmMNCj4gPiBAQCAtNzg5LDggKzc4OSwxMCBAQCBlbnVtIGRtdWJfc3RhdHVzDQo+IGRtdWJf
c3J2X2NtZF93aXRoX3JlcGx5X2RhdGEoc3RydWN0IGRtdWJfc3J2ICpkbXViLA0KPiA+ICAgICAg
ICAgIC8vIEV4ZWN1dGUgY29tbWFuZA0KPiA+ICAgICAgICAgIHN0YXR1cyA9IGRtdWJfc3J2X2Nt
ZF9leGVjdXRlKGRtdWIpOw0KPiA+DQo+ID4gLSAgICAgICBpZiAoc3RhdHVzICE9IERNVUJfU1RB
VFVTX09LKQ0KPiA+ICsgICAgICAgaWYgKHN0YXR1cyAhPSBETVVCX1NUQVRVU19PSykgew0KPiA+
ICsgICAgICAgICAgICAgICBBU1NFUlQoMCk7DQo+ID4gICAgICAgICAgICAgICAgICByZXR1cm4g
c3RhdHVzOw0KPiA+ICsgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICAgLy8gV2FpdCBmb3IgRE1V
QiB0byBwcm9jZXNzIGNvbW1hbmQNCj4gPiAgICAgICAgICBzdGF0dXMgPSBkbXViX3Nydl93YWl0
X2Zvcl9pZGxlKGRtdWIsIDEwMDAwMCk7DQo+ID4NCj4gPj4gVGhhdCB3YXkgeW91IGNhbiBrbm93
IHdoZXJlIHRoZSBQSFkgd2FzIHRyeWluZyB0byBiZSBhY2Nlc3NlZCB3aXRob3V0IHRoZQ0KPiA+
PiByZWZjbGsgYmVpbmcgb24uDQo+ID4+DQo+ID4+IFdlIGhhZCBhIHNpbWlsYXIgaXNzdWUgaW4g
RENOMzEgd2hpY2ggZGlkbid0IHJlcXVpcmUgYSBXL0EgbGlrZSBEQ04yMS4NCj4gPj4NCj4gPj4g
SSdkIGxpa2UgdG8gaG9sZCBvZmYgb24gbWVyZ2luZyB0aGlzIHVudGlsIHRoYXQgaGFuZyBpcyB2
ZXJpZmllZCBhcyBnb25lLg0KPiA+Pg0KPiA+IFRoZW4gSSB0b29rIGEgUk4gbGFwdG9wIHJ1bm5p
bmcgRE1VQiAweDAxMDEwMDE5IGFuZCBkaXNhYmxlZCBlRFAsIGFuZA0KPiBjb25maXJtZWQNCj4g
PiBubyBDUlRDIHdhcyBjb25maWd1cmVkIGJ1dCBwbHVnZ2VkIGluIGFuIEhETUkgY2FibGU6DQo+
ID4NCj4gPiBjb25uZWN0b3JbNzhdOiBlRFAtMQ0KPiA+ICAgICAgICAgIGNydGM9KG51bGwpDQo+
ID4gICAgICAgICAgc2VsZl9yZWZyZXNoX2F3YXJlPTANCj4gPiBjb25uZWN0b3JbODVdOiBIRE1J
LUEtMQ0KPiA+ICAgICAgICAgIGNydGM9Y3J0Yy0xDQo+ID4gICAgICAgICAgc2VsZl9yZWZyZXNo
X2F3YXJlPTANCj4gPg0KPiA+IEkgdHJpZ2dlcmVkIDEwMCBob3RwbHVncyBsaWtlIHRoaXM6DQo+
ID4NCj4gPiAjIS9iaW4vYmFzaA0KPiA+IGZvciBpIGluIHswLi4xMDAuLjF9DQo+ID4gZG8NCj4g
PiAgICAgIGVjaG8gMSB8IHRlZSAvc3lzL2tlcm5lbC9kZWJ1Zy9kcmkvMC9IRE1JLUEtMS90cmln
Z2VyX2hvdHBsdWcNCj4gPiAgICAgIHNsZWVwIDMNCj4gPiBkb25lDQo+ID4NCj4gPiBVbmZvcnR1
bmF0ZWx5LCBubyBoYW5nIG9yIHRyYWNlYmFjayB0byBiZSBzZWVuIChhbmQgSERNSSBjb250aW51
ZXMgdG8gd29yaykuDQo+ID4gSSBhbHNvIG1hbnVhbGx5IHB1bGxlZCB0aGUgcGx1ZyBhIGhhbmRm
dWwgb2YgdGltZXMgSSBkb24ndCBrbm93IHRoZSBzcGVjaWZpY3MNCj4gdGhhdCBMaWxsaWFuIGhh
ZCB0aGUNCj4gPiBmYWlsdXJlIHRob3VnaCwgc28gdGhpcyBtaWdodCBub3QgYmUgYSBnb29kIGVu
b3VnaCBjaGVjay4NCj4gPg0KPiA+IEknbGwgdHJ5IHRvIHVwZ3JhZGUgRE1VQiB0byAweDEwMTAw
MWMgKHRoZSBsYXRlc3QgdmVyc2lvbikgYW5kIGRvdWJsZSBjaGVjaw0KPiB0aGF0IGFzIHdlbGwu
DQo+IA0KPiBJIGFwcGxpZWQgcGF0Y2ggdjUgYW5kIHRoZSBhYm92ZSBBU1NFUlQgcGF0Y2gsIG9u
IHRvcCBvZiBib3RoIExpbnV4DQo+IDUuMTYtcmM4IGFuZCA1LjE2Lg0KPiANCj4gUmVzdWx0OiBu
byBwcm9ibGVtcyB3aXRoIHN1c3BlbmQvcmVzdW1lLCAxNisgY3ljbGVzLg0KPiANCj4gQXMgZmFy
IGFzIHRoZSBoYW5nIGdvZXM6DQo+IA0KPiBJIHBsdWdnZWQgaW4gYW4gSERNSSBjYWJsZSBjb25u
ZWN0ZWQgdG8gbXkgVFYsIGFuZCBjb25maWd1cmVkIEdub21lIHRvDQo+IHVzZSB0aGUgZXh0ZXJu
YWwgZGlzcGxheSBvbmx5Lg0KPiANCj4gY29ubmVjdG9ycyBmcm9tIC9zeXMva2VybmVsL2RlYnVn
L2RyaS8wL3N0YXRlOg0KPiANCj4gY29ubmVjdG9yWzc4XTogZURQLTENCj4gIMKgwqAgwqBjcnRj
PShudWxsKQ0KPiAgwqDCoCDCoHNlbGZfcmVmcmVzaF9hd2FyZT0wDQo+IGNvbm5lY3Rvcls4NV06
IEhETUktQS0xDQo+ICDCoMKgIMKgY3J0Yz1jcnRjLTENCj4gIMKgwqAgwqBzZWxmX3JlZnJlc2hf
YXdhcmU9MA0KPiBjb25uZWN0b3JbODldOiBEUC0xDQo+ICDCoMKgIMKgY3J0Yz0obnVsbCkNCj4g
IMKgwqAgwqBzZWxmX3JlZnJlc2hfYXdhcmU9MA0KPiANCj4gSSBtYW51YWxseSB1bnBsdWdnZWQv
cGx1Z2dlZCB0aGUgSERNSSBjYWJsZSAxNisgdGltZXMsIGFuZCBhbHNvIHJhbjoNCj4gDQo+ICQg
c3VkbyBzaCAtYyAnZm9yICgoaT0wO2k8MTAwO2krKykpOyBkbyBlY2hvIDEgfCB0ZWUNCj4gL3N5
cy9rZXJuZWwvZGVidWcvZHJpLzAvSERNSS1BLTEvdHJpZ2dlcl9ob3RwbHVnOyBzbGVlcCAzOyBk
b25lJw0KPiANCj4gVGhlIHN5c3RlbSBkaWQgbm90IGhhbmcsIGFuZCBJIHNhdyBubyBrZXJuZWwg
bG9nIG91dHB1dCBmcm9tIHRoZSBBU1NFUlQuDQo+IA0KPiBJIGFsc28gdHJpZWQgYSBVU0ItQyBk
b2NrIHdpdGggYW4gSERNSSBwb3J0LCB3aXRoIHRoZSBzYW1lIHJlc3VsdHMsDQo+IHRob3VnaCB0
aGVyZSBhcmUgb3RoZXIgaXNzdWVzIHdpdGggdGhpcyAocGVyaGFwcyB3b3J0aHkgb2Ygb3RoZXIg
YnVnDQo+IHJlcG9ydHMpLg0KPiANCj4gSXMgdGhlcmUgc29tZSByZWFzb24gdG8gdXNlIGFtZC1z
dGFnaW5nLWRybS1uZXh0IGZvciB0aGlzIHRlc3Q/DQo+IA0KPiBJIGRvbid0IHVzZSB0aGUgSERN
SSBjb25uZWN0aW9uIG11Y2ggYW5kIEkgaGF2ZSBuZXZlciBleHBlcmllbmNlZCBhIGhhbmcNCj4g
d2l0aCBIRE1JIGluIHRoZSBmaXJzdCBwbGFjZS4gQ2FuIHNvbWVvbmUgc2VuZCBhIGxpbmsgdG8g
YW4NCj4gaXNzdWUvZGlzY3Vzc2lvbiB3aGVyZSB0aGlzIGhhbmcgaXMgYmVpbmcgZGlzY3Vzc2Vk
Pw0KPiANCj4gSFc6IEhQIEVOVlkgeDM2MCBDb252ZXJ0aWJsZSAxNS1kczF4eHgsIEFNRCBSeXpl
biA3IDQ3MDBVIHdpdGggUmFkZW9uDQo+IEdyYXBoaWNzDQo+IE9TL0Rlc2t0b3A6IEFyY2ggTGlu
dXgsIEdub21lIDQxLjMgKFdheWxhbmQpDQo+IEZXOiBsaW51eC1maXJtd2FyZS1naXQgMjAyMTEy
MjkuNTdkNmI5NS0xLCBETVVCIHZlcnNpb249MHgwMTAxMDAxQw0KPiANCg0KTmljaG9sYXMsDQoN
CldlJ3ZlIGdvdCBhIGhhbmRmdWwgb2YgcGVvcGxlIG5vdyAobXlzZWxmIGluY2x1ZGVkKSB3aG8g
aGF2ZSBkb25lIGEgYnVuY2ggb2YNCnBoeXNpY2FsIGFuZCBzb2Z0d2FyZSB0cmlnZ2VyZWQgaG90
cGx1Z3Mgb24gYSB2YXJpZXR5IG9mIHBvcnRzIG9uIHRvcCBvZiBib3RoDQphbWQtc3RhZ2luZy1k
cm0tbmV4dCBhbmQgNS4xNiBhbmQgbm90IHNlZWluZyBhbnkgaGFuZ3MuICBHaXZlbiB0aGlzIGlz
IGxpbmdlcmluZw0Kb24gNS4xNiwgYXJlIHlvdSBhbWVuYWJsZSB0byBpdCBhbmQgbGV0dGluZyBM
aWxsaWFuIGRpZyBmdXJ0aGVyIGFmdGVyIHNoZSByZXR1cm5zIG9uDQp0aGUgc3BlY2lmaWMgY2Fz
ZSB0aGF0IHNoZSBoYWQgcHJvYmxlbXMgd2l0aCB0byBzZWUgaWYgd2UncmUgbWlzc2luZyBhbnl0
aGluZyBlbHNlPw0KDQpUaGFua3MsDQo=
