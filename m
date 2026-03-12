Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA37106703A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 14:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2701B10EA24;
	Thu, 12 Mar 2026 14:23:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QF0Pk996";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D790410EA24
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 14:23:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSlXT3eT8NzwdPlDE+rQV9JcHgO5KQH+GWieC+hTvBK7VJpPdwpJ8urlZUvlCjhiziEgFjNvMqsmWQrZU4fEOvUyF+MCLY5jWBs123BKgZRpvLKF4DjxOc1vfLkWSmJ5lalEAdKM63capXU0ZaPot6ntAh7GEP6iYfvHVchmZzftuW+WtT45UwxlJH3SBA4RFxNcjvqx0ahqAe3uI/W8WLtaiiiNxAMglthc+QymbXItoZKJsD8k93fGGRLw83hRJ8a/hE2VyGM5NueWQ/34/lrD/X9lJmWFH/jQ+uabDSg26I1VwVjF/47J5R5KAjKT7669gs2kfZKzMNxwjtY4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqCjj7VMwhRaxI79IHh2jSsehzVD49chue0tClJN3UQ=;
 b=zTgmP7Ud2/XzNzgQNWyAQDvqpd208uNUILWbQ3qWuRpVK1d5JS5BOyCgdlb7nJEkZV4FrpESdTBMsl/NVTFpuvugYr+4y4s6/hCWL1dPzSqz3CD5G++QUmTVdNqF236WPnKo0xa0RW76L3pmWtV7DRc30UdXcuN0EfOWTbNTLT/JnDXwAJK97YgWA/u9zD+VhUlUXHXUIl5nwOknzfKsYyhxJZjRMdp11LRtEmUGGUYoCzGTjviJvuWHW5KVvz9kRT1GAJijg+7da6FGsS7rvmNb9RRfGCyZNLxj2bA0m9VuzsNMyJypmqE2Kl2xdWo0NUAcJryIMIXBH6fex7euQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqCjj7VMwhRaxI79IHh2jSsehzVD49chue0tClJN3UQ=;
 b=QF0Pk996/0rL6x56MQWa11J4f+hC3OVhC58K2lQKXtEPaSPm1iFcWFatlfjg1ak8cmeBkpN3CF7RANzETJcPHY8Ix82VJ6be79q5ljJK8HEi+64VoAuOBIDBj4PcV3QchleIFkwgFpnlTOoarr4tyPECT2SLqr15jinogAmkotw=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 14:23:23 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%5]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 14:23:23 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Dan
 Carpenter <dan.carpenter@linaro.org>
Subject: RE: [PATCH] drm/amdgpu: Make amdgpu_dma_buf_attach() return paths
 consistent
Thread-Topic: [PATCH] drm/amdgpu: Make amdgpu_dma_buf_attach() return paths
 consistent
Thread-Index: AQHcsiZo5akAuvyYlUyScEPKTTXgpLWq7b8AgAAEWZA=
Date: Thu, 12 Mar 2026 14:23:23 +0000
Message-ID: <IA0PR12MB8208C9AC84D03A600C146F2C9044A@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260312134415.1839742-1-srinivasan.shanmugam@amd.com>
 <a10eead2-24a4-4974-950c-a9cbf2f1b135@amd.com>
In-Reply-To: <a10eead2-24a4-4974-950c-a9cbf2f1b135@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-12T14:19:11.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|SN7PR12MB6885:EE_
x-ms-office365-filtering-correlation-id: 34792d3a-b5ed-45a0-e0a8-08de8042eb19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003|7053199007;
x-microsoft-antispam-message-info: UTOfJRKg7yTYdtBq20f/McV92Cxj+JJmPdNQA/fnpe3ckuVn1qMxjExoHaZ09/3WfHelB6IlOxxOB0+5cMmLnkpa4WIAJ9iOUdWt2dW4Fym10lfXcw/SRVz+qWw+en1joXTMNHGGGoEp+VasXwYnUIWhTRXy/rIQiy6XUh9qdnDrvYop4TndsozO/Qwknv9oQ2a8pGVQw21glAeZJxOgNAOga20syPi0OKusnXCJG8PVJRCEZnAzwdtLz0YklmlrvZWZp5nMPSwV4avdF32dtXGdMeTFDbQMxMO+FaIdabodTpSy2gX+wV3JSbHxSaoQhWl8MpWbqbk9cn9OrcDppziU+b2KnVBNADcCsizVo+g0Y2XwalzdMuRdEDihXrkr/0W+ekDsI7QGWZTY2Px9NPYx9QctMI9r09O7aHLkITEpHH99esoRA5xFE2kRWqh/N/bsu0Tq59C2q9U84+QirEnoc9Tc0GKd/6oZgcB4SQLgi5x3CZ0Vjz12/ncluNs6GPLLOQ0MggdttSXo6DzO2OSBezrNCjUiMNddC1/wp9KzcF0FFxGjfhnwU3U0SRi6gytQuvlmcgX0Srr7k1jVeMkGUoQ1TpbFw+t1OhyWbqcbwEGYPVo4Shkd5VIsd6rhjSfHdD8y07x+KNs4yUiNwJ/VBFDB0Uf8ldaGx15+hC7gBrwdrF/K3z0z9RriL1DxNFXL6jC89fTimzGIY2aj/OkA956LK6EMdTB/yJJ39o8b7rw6H2xYNSLJuRVuhZQV6X4XdElqj5ETgRi3jmF9fMrt1JSlAKAe0SEIxDiyBHk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW9TdStwR25lRWJCWk8zSFBCbk5wVEtkUmpJS3RnMGVhajJXZXdWNmZ5Rkt1?=
 =?utf-8?B?SFdhVERNNU9vTkcrUDlXaGZIcnoxTS81Y3BDVlZiQ3o4ZG1GWHVPNWlvVnFR?=
 =?utf-8?B?YkZEWEZDSXpSSGJtTG9MMGx1eERyTnIyY1hQZE5JUEtMYnVhZFFMbXBnemxC?=
 =?utf-8?B?R0o3S213SG1HMkZTV3p2L2VndjFrbVcwMEdDc21zQlZZOGNFVEhjQXhpL2pZ?=
 =?utf-8?B?NjlRV3ZjTnhLbzBhSCt3Z0UwaTZkMzQwaXQrQXA5SFMrY29ueExvMFhwYzBr?=
 =?utf-8?B?ZERxbEZiRHoyMWd1MUFBcVpkZklMK2RqVS9XK2swbk43WHI4QXN0WmdPRHNi?=
 =?utf-8?B?Kyt2eC93Vnc5cWk4UitKWUpBZklNbnd5WG41d0ZXYUFnLzJ6K3ZXcDlxRlRq?=
 =?utf-8?B?dU1HVUpqSVNPWGtxb0oxb2pqR3pGRzBTazE2eVlUYnJaekREeG1LcmI2NUl2?=
 =?utf-8?B?Rm9qNUdMek5HNXRnSmdIekEyaTdpVVVienA2dXdPL0MrVVh1czZqSjlic3Vk?=
 =?utf-8?B?akJ5N0NlOHA3dEp0TjJ5V20wRWlpUlNLTjMyU0lyL1NVZ3hFN1g1ckVEMjU2?=
 =?utf-8?B?MTNKNlFwYjNkakgrVlY2eXE2RnZXZFR3NFhaeVQ5K0x5eGpxNnNyRW9yektr?=
 =?utf-8?B?VHRNTzRPTEhURjdPaU5qdE9jUXFEY09UR01kdkZBSzc4SkZLVG1qbDRqK1ov?=
 =?utf-8?B?NEVNNFp3UzZUbEJVbmxSNzE4TjE5RHRQQWlwM3E4a21yTjdiNGQ5M0EvY2h1?=
 =?utf-8?B?S1VQYVVrUFNvaWpWemlveWtMMlBOSTZ4SDVSVEVzMjh4SFA1TVhHRXJ6Tngw?=
 =?utf-8?B?VHczOFNlb3ZwaWkweThuYWVhVkZPd0VaTDk5ZFBiSVVSdDh1SnZBTmIxVmlp?=
 =?utf-8?B?Z3NiRnRpdTNITTc5d1o5S2x1UmhJUmJ6dTZ1eXUveWtuNHR1NEZjTUlIVVBL?=
 =?utf-8?B?YzNRQXZKZUxzcjloVHQrbk1NNVpKTHpWNkE4RnFaRlJjRXJOcUlqYnBsNEhP?=
 =?utf-8?B?WTdROUxNRnR4U3o0akFDeXlnRTkzV3YzV0lKR1NGak1CQldQOSt1d1JYMGRH?=
 =?utf-8?B?amh3K0w0R3FlUXBhWW9UN1o5ZkgzMDBJK0lZNVdHNGdqL3I0aTczbGRwcCs5?=
 =?utf-8?B?RjVhZk45WEkwU09DaTJpeFBYQ0R0elY3a1NaeEhlM2ttN2kzWUtCdlFFYk5y?=
 =?utf-8?B?TjFXVjI4N1hyN1U5eXI0RnZFUVBTbko0M1NRc0FVa1JybnFnTndzb2dKY0lR?=
 =?utf-8?B?QkJLYlNLOTRseW41U1VvOUp3R0ZSNThmSXczV0g0TGhobzhaT2pQNEwrcm5S?=
 =?utf-8?B?L01HUjM0ZnpTWWw3UjZQaDdnbUFpREExSlZlaGFOSFdrZUd1NXhPUVB4UzUx?=
 =?utf-8?B?bTZKRTh6akRRbGZ6YUZBby9nQlF0UjRYRCtFWmowQzJMRU1jN2lMdHd6QU9M?=
 =?utf-8?B?WDFiRjI0WFRoMzhnSWZhSjFkb2FDa0VFU0tRWkh1OVNjNHpISkN3S2NrUWIy?=
 =?utf-8?B?cG40Sy9GdlpVUXErWjVhbW9JWEdHVGZkUUVLYzI3YWJlVnpOSzQvanVFakhz?=
 =?utf-8?B?Q1UwVS9RemE5UlZUVkV3R1pBOUlKaitIdklkUXVPSE1DSE1YZVowM0pwKzE4?=
 =?utf-8?B?aDI5MnBTd1dydTRBZDc4WTdpMHpNVkY0L25SRkdSbGZVNlFJOU1pMjYyeHox?=
 =?utf-8?B?OWhlU2E0cVhSTnBzZjNOdlR0QWExUGMrRWNhWWo4b2RDTEdtUVVJK1lHNGVH?=
 =?utf-8?B?Zm9IcHdXaUQ0aFQzRUFIQmtwaWN0TzAyY1JtZjAyMitvTlYwby9rbGhpMlEw?=
 =?utf-8?B?QTRZTmp4ZGtZVzBpSVZEQkJSZ3d3a0tSdTBNT21xLzE1a1BROXhqdlFMTFAz?=
 =?utf-8?B?WHZvbE9tRC9GdHVKR0JlOUsxKzBWcS9mQnl6THF2TFJucWlydnBIczViWWoz?=
 =?utf-8?B?YXlVRDVFMWpuZ3ZMemk5a3h2RGh5LzREMWhSWEhUOVRWTWZ1ZFNyNDVkZDMz?=
 =?utf-8?B?NStMMlpnQnRzcnRhcUhWQ0lqeTVBV1BkNFd1elBFYTBwd0t0Z1hpcXNROWpi?=
 =?utf-8?B?MzFaNEVmNmhNMnk0VDdjUEJXQ2QwZ25zQUlRVmthOElrNnQzKzNSSE1WOEcx?=
 =?utf-8?B?MitoU1Y4M1JtemVJWGVkeThNb2R5VFBQREYyS3JvU09XeEhVelErM1dZYVhV?=
 =?utf-8?B?aWY0cTBBREtIdHpLcXpvUzZqeTY3ODF1VjMyRjJWcjlFVVhybUFVN2JmblQ2?=
 =?utf-8?B?bmkwelNXaUkzR3ErU3QxYm1WS3BBNXhQSTNKaVVXc1dUVzhRdGpXK3NrTU1X?=
 =?utf-8?Q?3m1S+iB6wJi1l/vWrv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34792d3a-b5ed-45a0-e0a8-08de8042eb19
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 14:23:23.3629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3OjMVVSCquSnlHLB+4wVV4lnZiZtklpv949YtzUSm1da5F1J3MyYdTDiGqMGw3VkKjlOtX5PGHy9YlbIfydKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMTIs
IDIwMjYgNzozNCBQTQ0KPiBUbzogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNI
QU5NVUdBTUBhbWQuY29tPjsNCj4gRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERhbiBDYXJw
ZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
ZHJtL2FtZGdwdTogTWFrZSBhbWRncHVfZG1hX2J1Zl9hdHRhY2goKSByZXR1cm4gcGF0aHMNCj4g
Y29uc2lzdGVudA0KPg0KPiBPbiAzLzEyLzI2IDE0OjQ0LCBTcmluaXZhc2FuIFNoYW5tdWdhbSB3
cm90ZToNCj4gPiBhbWRncHVfZG1hX2J1Zl9hdHRhY2goKSBsb2NrcyBiby0+dGJvLmJhc2UucmVz
diBiZWZvcmUgdXBkYXRpbmcgdGhlIEJPDQo+ID4gc2hhcmluZyBzdGF0ZSBhbmQgdW5sb2NrcyBp
dCBiZWZvcmUgcmV0dXJuaW5nLg0KPiA+DQo+ID4gUmV0dXJuIHRoZSBsb2NhbCBzdGF0dXMgdmFy
aWFibGUgYWZ0ZXIgdGhlIHVubG9jayBzbyB0aGUgZnVuY3Rpb24gaGFzDQo+ID4gYSBzaW5nbGUg
Y29uc2lzdGVudCBzdWNjZXNzIHJldHVybiBwYXRoLCB3aGljaCBhdm9pZHMgdGhlIFNtYXRjaA0K
PiA+IHdhcm5pbmcgYWJvdXQgaW5jb25zaXN0ZW50IHJlc2VydmF0aW9uIGxvY2sgaGFuZGxpbmcu
DQo+DQo+IE1obSwgdGhhdCBkb2Vzbid0IGxvb2tzIGNvcnJlY3QgdG8gbWUuDQo+DQo+ID4NCj4g
PiBGaXhlcyB0aGUgYmVsb3c6DQo+ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RtYV9idWYuYzoxMTEgYW1kZ3B1X2RtYV9idWZfYXR0YWNoKCkNCj4gd2FybjogaW5jb25zaXN0
ZW50IHJldHVybnMgJ2JvLT50Ym8uYmFzZS5yZXN2Jy4NCj4NCj4gQXMgZmFyIGFzIEkgY2FuIHNl
ZSBuZWl0aGVyIHRoYXQgd2FybmluZyBub3IgdGhlIGZhY3QgdGhhdCByZXR1cm5pbmcgdGhlIGVy
cm9yICh3aGljaCBpcw0KPiBhbHdheXMgMCBhdCB0aGF0IHBvaW50KSB3b3VsZCBmaXggaXQgbWFr
ZXMgc2Vuc2UgdG8gbWUuDQo+DQo+IFdoYXQgZXhhY3RseSBpcyBnb2luZyBvbiBoZXJlPw0KDQpI
aSBDaHJpc3RpYW4sDQoNClRoYW5rcyBmb3IgdGFraW5nIGEgbG9vay4NCg0KTXkgdW5kZXJzdGFu
ZGluZyB3YXMgdGhhdCBTbWF0Y2ggd2FzIGNvbXBsYWluaW5nIGFib3V0IGluY29uc2lzdGVudCBs
b2NrDQpzdGF0ZSB0cmFja2luZyBmb3IgYm8tPnRiby5iYXNlLnJlc3YuIFRoZSBmdW5jdGlvbiBs
b2NrcyB0aGUgcmVzZXJ2YXRpb24NCm9iamVjdCB3aXRoOg0KDQpyID0gZG1hX3Jlc3ZfbG9jayhi
by0+dGJvLmJhc2UucmVzdiwgTlVMTCk7DQppZiAocikNCiAgICAgICAgcmV0dXJuIHI7DQoNCmFu
ZCBsYXRlciB1bmxvY2tzIGl0IGJlZm9yZSByZXR1cm5pbmc6DQoNCmRtYV9yZXN2X3VubG9jayhi
by0+dGJvLmJhc2UucmVzdik7DQpyZXR1cm4gMDsNCg0KSSBhc3N1bWVkIFNtYXRjaCB3YXMgY29u
ZnVzZWQgYnkgdGhlIGRpZmZlcmVudCByZXR1cm4gcGF0aHMgYW5kIHN1Z2dlc3RlZA0KcmV0dXJu
aW5nIHIgaW5zdGVhZCBvZiAwIHNvIHRoYXQgdGhlIGZ1bmN0aW9uIGNvbnNpc3RlbnRseSByZXR1
cm5zIHRoZQ0Kc2FtZSB2YXJpYWJsZSBhZnRlciB0aGUgdW5sb2NrDQoNCnRoZSBwcm9wb3NlZCBj
aGFuZ2UgZG9lcyBub3QgYWN0dWFsbHkgYWRkcmVzcyB0aGUgcmVwb3J0ZWQgd2FybmluZy4NCnIg
aXMgYWx3YXlzIDAgYWZ0ZXIgYSBzdWNjZXNzZnVsIGRtYV9yZXN2X2xvY2soKSwgc28gcmV0dXJu
aW5nDQpyIGluc3RlYWQgb2YgMCBkb2VzIG5vdCBjaGFuZ2UgdGhlIGJlaGF2aW9yLg0KDQpTbyB0
aGlzIGxvb2tzIGxpa2UgYSBTbWF0Y2ggZmFsc2UgcG9zaXRpdmUgcmF0aGVyIHRoYW4gYSByZWFs
IGlzc3VlLg0KSSdsbCBkcm9wIHRoaXMgcGF0Y2guDQoNClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhp
cyBvdXQuDQoNClJlZ2FyZHMsDQpTcmluaQ0KDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4N
Cj4NCg==
