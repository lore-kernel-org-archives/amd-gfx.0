Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49158C982DE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 09:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D586E10E14A;
	Mon, 21 Sep 2026 09:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tFMiXVDB";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3C610E14A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 09:04:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKP+qmh+zWd50CdUXcYCtw9EBkCRrQYE3/TiU1w8rLO81OsyfrxYpUKW9454li1BQe2Zl7NvVJpszA58oPefVsE2VCti9kIT9FOUvt+/CyHPodrvBstm8aS5+35JLWuWcFoIux/MboVc6nnc3wsTYAS2vMgLXt1YNW8BYzM5BMNYg3emQmkbPT2nw1+G4tZdXgPkofhFbuyNKP/jyByCN9sHA4VsQMgEHiEOLa+FbHt31lzhpP1nC/DxEBvnYT3E8nPP6bvCHM986WOJnrckuvKKW1v9k+cTrE4u/AVLsS6qEopyEPQ8rhLcozQlGGmafJkU1MIT0DtmkYE8aKpK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I77NLMsJlghd7nECFAiv/OH7lHOyxHv3ehp0AVG+ipo=;
 b=E4MhxM1hi7j8AlHVFOiKyag6eomvTXnkm0LqIl+vq3BNLSU+A6F3upxte81rOAfiWsfNf8ImVW8MhBL3FIUbtji1OHNPCrKyTQ7B7uKgQRbVa06eEcKMjobwr5RnQWtt99+ug3NVZZylstbE871phQV4ONbBOJg9sXPNIWVntNAy1p4gZ/j8CzOWfg6VJdYF+MZfXc7zAnu1Xdwj6zRxxQ4YK+8E/hmaySrz1uL3LutC0ENRuBV7YSStW6YOyx2sMSDsBCQ+QxfYOrWzfQMvhI0614FgrbsY4/VnxHtIkgyW1qa0ObFsriREfnVux0bBJV1YS3pJOcGFDXteUOhQ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I77NLMsJlghd7nECFAiv/OH7lHOyxHv3ehp0AVG+ipo=;
 b=tFMiXVDBV1tVXl7d284m1MYLWcwbexNmx76g+FEKBSplOoN/x0K0hJ8L6IkT+IpKblpFmfa+VbtUBKeXTgKzflEzFtHjfS6yJ4TiOX0zhL1KOsJ1hsj3CMOxDnik0wWQjsktihnAu0vbLAasHhrD/lB3StPPWl01eIU5SExTEEM=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 09:04:45 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.21.0428.014; Mon, 21 Sep 2026
 09:04:44 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pelloux-Prayer,
 Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH v2 5/5] drm/amdgpu: mark queue and process as guilty for
 hung user queue
Thread-Topic: [PATCH v2 5/5] drm/amdgpu: mark queue and process as guilty for
 hung user queue
Thread-Index: AQHdROKq5LQe8E8Vfk6Hvw/GiuXcxrbPq/EAgADetpCAALG9AIAHYEEw
Date: Mon, 21 Sep 2026 09:04:44 +0000
Message-ID: <DS7PR12MB600598044BD8E228DCD172FEFB842@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260915071946.710846-1-Prike.Liang@amd.com>
 <20260915071946.710846-5-Prike.Liang@amd.com>
 <633738ea-bde0-4658-83e7-9cdf0f47c2e5@amd.com>
 <DS7PR12MB6005BB1C3565E77FA94DD005FBB92@DS7PR12MB6005.namprd12.prod.outlook.com>
 <43e91c31-ace4-437e-afae-26297102176d@amd.com>
In-Reply-To: <43e91c31-ace4-437e-afae-26297102176d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-21T06:34:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH8PR12MB7110:EE_
x-ms-office365-filtering-correlation-id: 51550a94-f76a-4c25-3534-08df17bf614d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 8BSH9+ZjDrIbEGOI5oW0tWhbzQR3hBFFWpRICz/gcjsHQsCF2uVAzpVtQC8UrnZgb9HwxzrCBnY2mtCDvILU4DWjb1leW7FpLEct0mIt+l0P0f+u0HkwxIMP7johm+GLRnk17kKerBA1yT4tmdtfeuGKceeZ3xaHYnKfcKPz3L4BT+nqZmRZ3NZxuVmrZQYCqQOLOGTD2pTr94bxZ1UcKcIpHWGoTCsX0SogASv82NL/2uFckQAw7yy8E5nfEjZzkXp5ezyXVj0kZB/O1Qmk6PwWAVirrwMZhkxunTqFHuvBvDdmznA/nKvVpXd6y9TdE11tto8UDpDQ/6V4f4+O/0lutpFVyCrptd6noNIimNKcYCZszOFn+IDHFWSLtjFx95JkZJsGiTRVrlHyKObX1AKb4vvFbtqyS5aIEdZSIhaJ4XszSFxIzTWXnkcgWkKyS9UV38y/WzFcWdpO2XgoI6pANYhg5VPk4nP6brkhbgwWTeaTYCdI1CEL0svkiVvf0e8T8Ei4CUhU9c04zfgIo7VN3VKrEihomn9Lb6UTCekAktedpVz6eu47CTMRJRB4o3NxYGgmS2OjNUNkHQF5YpwrL9xJvKY01aQ0qYaivQehd4WyjTtxpBgtr2GnEVn9IaoYaZ66FY03TC5MxvOYuTCP4LqIL2/XIZ23YocOWcCvR9d53JMIsH5D+s3f6Mb6hB+wAia+0hkg2AaNpHqbWyizUXJp9lCb/FfqRnbVkiI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3p6d09TQUluSFpsSkljU1FodjVJL3doYU9yb3c1TWQ0Wi9VM2tGQ0lWbVE1?=
 =?utf-8?B?VlpzV1gwV2xIYm93cUNEeFRsWTZmNk1RVzZ2LytTN2pIWVdOTGhrWjVyMmI5?=
 =?utf-8?B?Z010ak16Z2xWVmczVWV3ekFkK1dsSlZGZUh2ZFdxbFl4d2Y2Q3RyVVh3aTdv?=
 =?utf-8?B?WS9zNGZUYVFzUXZ0RUI5bWRXRzMxSDZodkgwY1RnK1U2eW5ZSzUrY3lnOENq?=
 =?utf-8?B?WW1RNmkvc0dOOE1hSXZPZVVsUlUyLzlpc2pOaS8wbStTMENuaEdjZUxTL3hN?=
 =?utf-8?B?bWN6aTVnd2h4VDdvY3hWN1FzYzNFeTBadWllQjNNMGlpbXlJM0lnU1Zlamln?=
 =?utf-8?B?aFN1OEJkV3MwbVhuQnpWMmtmOEFWZzk1QTcySjN5bElVUXhEeGJ1ZnlLYmh5?=
 =?utf-8?B?Y2N4U2VzUGd3aEdMT1pHd0NtRjloclpkQTJadlREMTFsR0ZBYWVDZnMxV29j?=
 =?utf-8?B?T3ZwT3BvckprYzFYVkZtM1ljaFdzcGYzQUx4a2NXK3lKbGdlOFVzdm1XLytu?=
 =?utf-8?B?WERGdVVKTlVpSjZ3OFBudmZqM2RVK1g0akYrTnZod0JvYk5HamtTZHQ4ZkRV?=
 =?utf-8?B?OXFRNjViUEhXSHBVTUxoTjQzeHpRQ0QvVzNSQVFWSGhuczdHQjV5blZEdDlZ?=
 =?utf-8?B?bys2Yks3Q1pRZzlCK3VGL0lNMlZtWkZ2SDl0L3dJTC80R2dIZks1a2RtNDEx?=
 =?utf-8?B?UUVIUFJaSm9BWEY5VFI1ZXJsQ2VwcStmUnJlY3dNWEZoWkFjc3NTZ3BHVWJl?=
 =?utf-8?B?eW9EUkZ4c3E3QTJKQUVBOGczQWwwcmUwVDRMejl2dHFteXhPdHFvUmphT3M1?=
 =?utf-8?B?c1Q1OFNSNVFHSHpYL0FlZDVFRVNBK1NrL3h2MFBxcGU0R2xocmV3dUdvSlRx?=
 =?utf-8?B?c3ZXMGVkQ1c0QzkrL2dXaUFZck9kak9OcTdsVFVIUEk1SVNrSnFsMmdvOFpp?=
 =?utf-8?B?SHhyUmdDZ2xJQmJwVHNYOFB0YlhXUUtpdDVLM1JoUnpkajNLQXdPRWFFQnla?=
 =?utf-8?B?bXI3WUZMQzY0NHZicU0wN2RDcUM0WG0xcUh5MWt1OE5YZ2xlNy9sdExIblVx?=
 =?utf-8?B?MlJEUFljZTllZFB3RWVkNmUwY2pvSUlSSlYyNkVYckRYR0MvTnpZenBtWTFo?=
 =?utf-8?B?V3hyVmdxYVllcUlvUXVPUTdBOHNxUktBOU54TnVLWjRkMUdxL0QrdHJtNm9S?=
 =?utf-8?B?bk42bVpCcTFOREFwQ3MvaXcvMVBabjFiRE5sN3NPd0dROVBsOXRvV1NPNm9Y?=
 =?utf-8?B?MGlpZHVKOTZOVEVsRlliNzc4YXQxNThIUThPZldxd2cxTlJFSnJ2TCtHdTk1?=
 =?utf-8?B?UnZ0NmNJbGNWSnE2VWQ0Y2Z2bzE3WTF5RXFQMzNxZmFkdWd1S2c4bW80T2pq?=
 =?utf-8?B?cE8rdEdsc2M1SG1Xb0U3R1p3RzBxUWh5TkVHUDlmWGFXbjZwWE0rRXZpbm5x?=
 =?utf-8?B?ZmxKN0lhRnBWOTVjbHVqVkRnbTVuell6K3R0d0JKWVBvTzlEelJ6RFFaTTlx?=
 =?utf-8?B?L3NuSjFNbGR3TmNxWjhkK0tBeGoxL2VQWUFhbUJ0OUVpbzhhZ3NwT2hNaGxh?=
 =?utf-8?B?Z21DWmtqMVZ0cmM3SEFCajNGaFBhY0kzK2ttbDlUSXgyV1I2dE8vOFZrLzM0?=
 =?utf-8?B?eitiUWlhdUNjTlAxNUFtRWUwck1kd3BKWjNDT1VNS3Y3RmZoaUZlY3MzNnpP?=
 =?utf-8?B?REh3V04zQVFSV1lwVHZVdS8xZ0NsZU1HdlZaNTVsOFRNSjF1L05UVlNkbEQr?=
 =?utf-8?B?SXVDUEp0NlpoUEZpQ1haUlV5ZzBWSFFEd3dUOTUyemJrN2pQUlNJYm1jRVQx?=
 =?utf-8?B?cGRBQ1BDVC9hSjFnc1ZtampxajV5ZDJLa2tJNGJab2prOVdEN3BmNHZ1SGY1?=
 =?utf-8?B?T1RmTit1YXVwUERORUJDMjBweTJyaUZZWi9wYXZudFQvdDJYTTVURFRENmZq?=
 =?utf-8?B?N0t0VmhlNWtWWTdoMDJZaDNXbE84QVdLUGp5QnlKRHd6NTlHSzZZM2tGSWxP?=
 =?utf-8?B?b1lFZ1RGc0JGRnN4RXo5cWFmKyt3cU1udWg0SERzT0NaZkp5L3lpVzMwZXZY?=
 =?utf-8?B?eWxaZVF0T2dqeTJpMmhiZ2tXTjdqK2Z4RlNKWHBlZGxiY3BEMXN0WjJBL1pW?=
 =?utf-8?B?UWx1YzQ5UUpEVW82MHVDaFpNSjRvaEE4Y0hSamVGRGd1d3JKTUFOMWNZS3hJ?=
 =?utf-8?B?alhzdFpkc0xka3VFL0pSVGpiTkZyeWN3TzdacDJINktqSTg0Z1N4THNFVksx?=
 =?utf-8?B?WDlqSGlMd0dNVUUyWDVpVjlSUWJwVGpQeHc3d2FvYjlqR3NMMWZqS0EwOHRN?=
 =?utf-8?Q?tMX0LYOhnP0w6XG24n?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51550a94-f76a-4c25-3534-08df17bf614d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 09:04:44.8004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7twhvU3TUQOwC2lU2jhc7uKSenKFtu3F0Z56/jbtNz/P1lUT10oRxyswgf8JoFm+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110
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

QU1EIEdlbmVyYWwNCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdA
YW1kLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTYsIDIwMjYgOTo1NiBQTQ0K
PiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT47IFBlbGxvdXgtUHJheWVyLCBQaWVycmUtDQo+IEVyaWMgPFBpZXJyZS1lcmlj
LlBlbGxvdXgtcHJheWVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNS81XSBk
cm0vYW1kZ3B1OiBtYXJrIHF1ZXVlIGFuZCBwcm9jZXNzIGFzIGd1aWx0eSBmb3INCj4gaHVuZyB1
c2VyIHF1ZXVlDQo+DQo+IE9uIDkvMTYvMjYgMDU6MzgsIExpYW5nLCBQcmlrZSB3cm90ZToNCj4g
PiBBTUQgR2VuZXJhbA0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiAgICAgICBQcmlrZQ0KPiA+DQo+
ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtvZW5pZywgQ2hyaXN0
aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIFNlcHRl
bWJlciAxNSwgMjAyNiAxMDowMyBQTQ0KPiA+PiBUbzogTGlhbmcsIFByaWtlIDxQcmlrZS5MaWFu
Z0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gQ2M6IERldWNo
ZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFBlbGxvdXgtUHJheWVy
LA0KPiA+PiBQaWVycmUtIEVyaWMgPFBpZXJyZS1lcmljLlBlbGxvdXgtcHJheWVyQGFtZC5jb20+
DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNS81XSBkcm0vYW1kZ3B1OiBtYXJrIHF1ZXVl
IGFuZCBwcm9jZXNzIGFzDQo+ID4+IGd1aWx0eSBmb3IgaHVuZyB1c2VyIHF1ZXVlDQo+ID4+DQo+
ID4+IE9uIDkvMTUvMjYgMDk6MTksIFByaWtlIExpYW5nIHdyb3RlOg0KPiA+PiAuLi4NCj4gPj4+
IEBAIC0xMzIsNyArMTM0LDggQEAgc3RydWN0IGFtZGdwdV91c2VycV9tZ3Igew0KPiA+Pj4gICAg
IHN0cnVjdCBkcm1fZmlsZSAgICAgICAgICAgICAgICAgKmZpbGU7DQo+ID4+PiAgICAgc3RydWN0
IG11dGV4ICAgICAgICAgICAgICAgICAgICBwcm9jX2N0eF9sb2NrOw0KPiA+Pj4gICAgIHN0cnVj
dCBhbWRncHVfdXNlcnFfb2JqICAgICAgICAgcHJvY19jdHhfb2JqOw0KPiA+Pj4gLQ0KPiA+Pj4g
KyAgIC8qIFNldCB3aGVuIGFueSBxdWV1ZSBvd25lZCBieSB0aGlzIHByb2Nlc3MgaXMgcmVzZXQg
Z3VpbHR5ICovDQo+ID4+PiArICAgYm9vbCAgICAgICAgICAgICAgICAgICAgICAgICAgICBndWls
dHk7DQo+ID4+PiAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcm9jX2N0eF9h
bGxvY2F0ZWQ7DQo+ID4+PiAgICAgdWludDMyX3QgICAgICAgICAgICAgICAgICAgICAgICBwcm9j
X2N0eF9hcnJheV9pbmRleDsNCj4gPj4+ICAgICAvKioNCj4gPj4NCj4gPj4gQWdhaW4sIGNsZWFy
IE5BSyB0byBoYXZpbmcgYSBmbGFnIGluIHRoZSBxdWV1ZSBtYW5hZ2VyIGFzIHdlbGwuDQo+ID4+
DQo+ID4+IFdlIHNob3VsZCBub3QgdHJhY2sgdGhhdCBoZXJlLCBlc3BlY2lhbGx5IHNpbmNlIHRo
ZXJlIGlzIG5vIHdheSB0bw0KPiA+PiByZXNldCBpdCBhcyBmYXIgYXMgSSBjYW4gc2VlLg0KPiA+
DQo+ID4gVGhlIHVzZXJxX21nci0+Z3VpbHR5IHdhcyBvcmlnaW5hbGx5IGFkZGVkIHRvIHRyYWNr
IFZSQU0tbG9zdCByZXNldHMgdGhyb3VnaA0KPiBhbWRncHVfY3R4X3F1ZXJ5MigpIHNvIHVzZXJz
cGFjZSBjb3VsZCByZXVzZSBpdHMNCj4gRUdMX0VYVF9jcmVhdGVfY29udGV4dF9yb2J1c3RuZXNz
IGhhbmRsaW5nLg0KPg0KPiBIdWk/IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuLg0K
Pg0KPiBhbWRncHVfY3R4X3F1ZXJ5MigpIGRvZXMgdGhlIFZSQU0gbG9zdCB0cmFja2luZyB0aHJv
dWdoIGEgVk0gZ2VuZXJhdGlvbiBjaGVjay4NCj4gU2VlIHRoaXMgbGluZSBoZXJlOg0KPg0KPiBp
ZiAoY3R4LT5nZW5lcmF0aW9uICE9IGFtZGdwdV92bV9nZW5lcmF0aW9uKGFkZXYsICZmcHJpdi0+
dm0pKQ0KPiAgICAgICBvdXQtPnN0YXRlLmZsYWdzIHw9IEFNREdQVV9DVFhfUVVFUlkyX0ZMQUdT
X1ZSQU1MT1NUOw0KPg0KPiBXaHkgd291bGQgd2UgbmVlZCBhbiB1c2VycSBndWlsdHkgZmxhZyBm
b3IgdGhhdD8NCg0KV2hlbiBhIHVzZXIgcXVldWUgKHVzZXJxKSByZXNldCBmYWlscyBhbmQgZmFs
bHMgYmFjayB0byBhIGZ1bGwgZGV2aWNlIHJlc2V0LCB1c2Vyc3BhY2UgbmVlZHMgdG8gZGV0ZWN0
IHRoZSBpbnZhbGlkL2RlYWQgcXVldWUgc3RhdGUgaW4gb3JkZXIgdG8gcmVjcmVhdGUgaXQuDQoN
CkN1cnJlbnRseSwgdXNlcnNwYWNlIGRyaXZlcnMgKGUuZy4sIE1lc2EpIGNhbiBxdWVyeSByZXNl
dCBzdGF0dXMgdGhyb3VnaCBlaXRoZXIgYW1kZ3B1X2N0eF9xdWVyeTIoKSBvciBhbWRncHVfdXNl
cnFfcXVlcnlfc3RhdHVzKCkuIEhvd2V2ZXIsIGFtZGdwdV9jdHggaXMgbm90IGRpcmVjdGx5IGlu
dm9sdmVkIGluIHVzZXJxIGxpZmVjeWNsZSBtYW5hZ2VtZW50LCBhbmQgTWVzYSBwbGFucyB0byBk
ZWNvdXBsZSBsZWdhY3kgY29udGV4dCBkZXBlbmRlbmNpZXMgZnJvbSB1c2VyIHF1ZXVlIGhhbmRs
aW5nLg0KDQpUbyBzdXBwb3J0IHN0YW5kYWxvbmUgdXNlcnEgd29ya2Zsb3dzLCBJIHBsYW4gdG8g
ZXh0ZW5kIGFtZGdwdV91c2VycV9xdWVyeV9zdGF0dXMoKSB0byByZXBvcnQgZGV0YWlsZWQgcmVz
ZXQgc3RhdHVzIGZsYWdzIChhbmFsb2dvdXMgdG8gYW1kZ3B1X2N0eF9xdWVyeTIoKSksIGVuYWJs
aW5nIHVzZXJzcGFjZSB0byBpZGVudGlmeSByZXNldCBmYWxsb3V0IChlLmcuLCBndWlsdHkvaW5u
b2NlbnQvdW5rbm93biByZXNldCkgYW5kIGluaXRpYXRlIHF1ZXVlIHJlY292ZXJ5IHdpdGhvdXQg
cmVseWluZyBvbiBhbWRncHVfY3R4Lg0KDQpUaGFua3MsDQpQcmlrZQ0KDQo+DQo+IFJlZ2FyZHMs
DQo+IENocmlzdGlhbi4NCj4NCj4gPiBJZiB1c2Vyc3BhY2Ugc3dpdGNoZXMgdG8gcXVlcnlpbmcg
dXNlciBxdWV1ZSBzdGF0dXMgdmlhDQo+IGFtZGdwdV91c2VycV9xdWVyeV9zdGF0dXMoKSwgd2Ug
Y2FuIGRyb3AgdXNlcnFfbWdyLT5ndWlsdHkgYW5kIHJlbHkgZGlyZWN0bHkgb24NCj4gQU1ER1BV
X1VTRVJRX1FVRVJZX1NUQVRVU19GTEFHU19WUkFNTE9TVCBmb3IgaWRlbnRpZnlpbmcgdGhlIGNh
c2UNCj4gb2YgdXNlcnEgdnJhbSBsb3N0Lg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+ICAgUHJpa2UN
Cj4gPg0KPiA+PiBSZWdhcmRzLA0KPiA+PiBDaHJpc3RpYW4uDQoNCg==
