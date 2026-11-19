Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C185606A326
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 23:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=r9YHzzlC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B9FE1127F2;
	Thu, 19 Nov 2026 23:45:00 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ACD21127F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 23:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IByqB/l8PPsQ3ind/WGblXcqUCcePBPsaPGqOvAPX9jWBy9XYydi6I7WgBI2EYA06K3TXR8Mu7sDzmIzL1oULilYxbRho6T1ey3UYPiIt30Db+M7OzF6Cg4bfK/ZhNNXW9wV4GTKpUXI5/UN3MhDfPwjMete0g6ig5e0VzUSCe87s2UwO950Z3NCLSPTZOLml7RiEkZdFwbH84tH1/FHNpEHo0DjD0AOyAMyAsXqPYO5kJYGUFOQ6MJ1ZmdJlLD6csaQDAXv+EZ4Ce6tS2vCqpBOB7FQdQhaQb/q31x7z/XfywinnMwk511RwPjxFAP2KtuOx4nNGCVkKwEMA/PNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpP5TPQ7wHly1imnrPQvnyRYkqm7nRQJPBGb64pn6tA=;
 b=qmIdXTvWPaPQMFwnmFzbwckTajxYLVf7P8gZup62sa/RBHyh+72IdXLMBxOc5RQs9ChD3pZ6Nr1sDBADQhKdWUCS17F7FKV1soB//KMQbEsjbl2nXxuy4c2KGtzIkN9pM7oGCwrZ4JThv2GOgNsx+L7M+pgMSRC7ny6DZjGlUNMyKS3QoIhw1QmZYsX7rgwM7RUMo9SWactekhzJetsn8trF+nhuodp7jb8YefeJWUnPu+ksjCppFOqo5lv5HmPTurN/Nh+96cxfFieAjS26a18tygH+vIouh6MXzNapao/4BT6S9OAeC+9QEsPWp7s5Fcpt6upSlAHYCmlUaE52JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpP5TPQ7wHly1imnrPQvnyRYkqm7nRQJPBGb64pn6tA=;
 b=r9YHzzlC3JMDeCqdTiO6Zq61byLWEzVsYMqVZGFRfjsNwCapD+3DHMfEHT1HBH4WY43Gq0zC+OTs/VD8AnGS4VMkwvDV3ysWyfybCig71cYVNM0m25zptKm2knUgCTwSw9dlhA27Xlspa7I6lx8qIc9jrhWhprKc9COEFHbW7Yw=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 23:43:40 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0639.011; Thu, 19 Nov 2026
 23:43:40 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: don't unreserve the freed root PD in
 amdgpu_vm_init()
Thread-Topic: [PATCH 2/2] drm/amdgpu: don't unreserve the freed root PD in
 amdgpu_vm_init()
Thread-Index: AQHdeAxS51puyb0GV0CGGXWdHFgmJrc1eXQAgAAS7ICAAILD0A==
Date: Thu, 19 Nov 2026 23:43:39 +0000
Message-ID: <DM4PR12MB515233FDF2622F0116CB7ABDE3792@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261119095652.3510341-1-Jesse.Zhang@amd.com>
 <20261119095652.3510341-2-Jesse.Zhang@amd.com>
 <6cd1af3d-4647-4cdf-a351-b65effdfab48@amd.com>
 <CADnq5_OmSYu9GN=hcXYD4VLztb0BnBG1nGyLANz9v_gX-3GbiA@mail.gmail.com>
In-Reply-To: <CADnq5_OmSYu9GN=hcXYD4VLztb0BnBG1nGyLANz9v_gX-3GbiA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-19T23:42:19.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SA0PR12MB4462:EE_
x-ms-office365-filtering-correlation-id: 1bbc6e8f-0e0d-4cb0-2397-08df4696f045
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|10067099003|261026121527099003|261026140227099003|56012099006|4143699003|11063799006|261022105027099003|261021135927099003|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261028144727099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: yVsVLzlE5ILxLdEbJESu68E0/UBAjNRmccgd1/8aQzXOtrXJJbJIS3w95DQxY32u7MhawGZXrM1CcEbkIuoi+3QcD9ii/URMXNNPW6VuA/pc3SznvK6byIL8OQKAudjbgKo5wYVb1TYhbpl/Um4knhhMr1y57eOImK/2P+KIwgEN/G6wrKn+G8T4D1LKFY7xy18fJQ5z09pxsugnU4IqwiQwGtm+S44w4RqBqgMd0iCQDXyVfFVWbUixEv6l923VHxKt8qNLfVAkxgix3XH38xB9uvctKoeisdaRZRO5mLIFB/J33bZUWj5ZcAIzXRO4ILWRwgCmGbGP7taVY+QG/bpInCJhGQng5MgCBQUyoMjpIUNiSFVdiqVCfGgExRtij2CwQUG0QmrVbvKsFefKCXmO2cTkJH6rGJ5NKlB/ctaWzPGtXuAL0wuWvbAo55txEmYhu0QnacGgi6/Qr/vBnaIlBuKj27upUjrnUhG+uVXPmZ8u08KKvgulWVReDBVsHwj5kZ5+fBjoW1wGM6iSPZ1DgCDSpLzGShk6RRAaU+1CAuNW7J9RJGiINY+EgdA49LQI9akHINoFHy0H8lz+tmIQbIj+WkUo6hypSgS6CYxhGJGb5GlbDk56R03KwKMx2h5LYx/3jvSy8mDdq9nlwmklnYHpLFllxQNjIO98GnzEnjGfW6uEEj//1Z0iRLtWMG8CdS8/8ReOxiWrEZAiIzG3+A//QTfd8idobvscWyc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(261026121527099003)(261026140227099003)(56012099006)(4143699003)(11063799006)(261022105027099003)(261021135927099003)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXN1MXY4TFdHbHFTZTM5VHZxcVp5bGFSZGF4a0NqZ2ZONFl2VXFORWRHamt0?=
 =?utf-8?B?RWxXdSticTIzbVVFalp3UTF0VWI2NkN1L3BxUU8vZ0gyTlQxSU5uaTI5T2gr?=
 =?utf-8?B?UytqeGJnWDk4bmQ2VXk4alBwVnN0andSREFubkhRdVJnOXp6TFV2alZGOFAw?=
 =?utf-8?B?S2hsQUtndHUyZDBJanhONlY1ZXJXaTgvL050SDdpd0hKL3d2akRxQ25QRHFh?=
 =?utf-8?B?ekFISFV3ckJWYy9MOEFIMC9oTGNRb1ZrVE1Kazk2TDFzZ0h1bnM3OUpWSnI3?=
 =?utf-8?B?UGRRQ1RHcVYyUTNjQmxCeGtKZDBpUzJpaHF6TWdtODJ1NG9xYXRidWU5WDhn?=
 =?utf-8?B?S3VWOHROV21pR1Q0dkdBL2xwSVluTFNWbXZWOHgvT1Vyam1LT1JhMnJaU2da?=
 =?utf-8?B?TUkyWU9TelNZeEdOQzFCNklKd2txWDRvWDZHSlRvNkdlMENRS3F3M0lhMzhV?=
 =?utf-8?B?TTBFSWNWT2Y2clBnSnI0aGFkdW01TnhzVjRveGFqelRhSDIxeElHdkg2aS9i?=
 =?utf-8?B?aHJvbVJLTFkydGtuclEzQkNiN3NhY25PdkNiaFBDSTlSanBRWWdEWFhBWEZ1?=
 =?utf-8?B?VFNoM3dqQXBxM2NhR3pjTzM0YnlGNjRyZ3lLMWc1b1NDek5YVVhXS3pDd3NF?=
 =?utf-8?B?OEJ1dXg0blFRYUNhbzI3c3VBY21qRzBjcDVwT2tYZk83cUFwWEkzSlpjQSt5?=
 =?utf-8?B?aEFId2REUnlZQ1dodWVTaGN0MGY5Y3VrTDBhR1NwWEtoMU5nYTlaM2x2STR1?=
 =?utf-8?B?RFpwRFBWZ0h3VS9ha1gxUHI3N2JNak1CUmdzdGZERmlBcTc1ZVU5YjBncWdx?=
 =?utf-8?B?a3FzTFVqNHRnbGw5MEVHOGRmRUxqSHZTa2JheEdCRGdoZ2F3V2xJTTF3UFJk?=
 =?utf-8?B?NVkySzhpNFpiSHF6V2VOcFBqaklla0tpdkY1cURrSEMxNHJ6dHVpUjdFT2s1?=
 =?utf-8?B?aFRoVmtuaEdKQkhGb0lYNVAzNUR4elh0TWMrOHVpZVUrdGVtYlhqME5hNVdD?=
 =?utf-8?B?SlhYeWoyU3JOUFpIc1BUejJuQjRtdCsraGRUVG1lTEpxcXd6OGhNbUFZbnZS?=
 =?utf-8?B?VElaeXNDZDBqaStVbXp5N0tKeDdGNXFmZGplZGYxZDNCTFptc2t5MTUxL0lo?=
 =?utf-8?B?MVBTblVVOTV3aTFRYnNseWk5Vnh0QnFmdTRXaDZMTEJxalplT0xTQnNaMlZa?=
 =?utf-8?B?MTk3TnkzL3hUdStWaytLOUVTV2doL1dUY0drVUs2d2pQNXA0WjlHWEhyQk9o?=
 =?utf-8?B?V29GN21LaDVORGdOdnF6cTNKNzZwYXF5OFFVRGlhdzQ4bHNPc0k2cU5Tdi9X?=
 =?utf-8?B?UTQyTzBmaXFSOXVwVTVqMGNoRnZackdmYVlVRlg3L1ZpMFRRQnpXRzVDTWor?=
 =?utf-8?B?RkxsV0NnS083ZUJYTkRleU5KNXp0WmQ2cUk3d2RYaVE4amNFWWxHU2N2QWJY?=
 =?utf-8?B?SDY3dHhlSmRZcmVXcmVHQ2h5QTRQelA5cWhWbTBhcDZUU21LczlqbDE4Z3Ry?=
 =?utf-8?B?eWZ1TGEzN3IwOG1NWEE1REtGR1REQUplM2ZRSzMxaE1CVEJFenZPRkVSWFVS?=
 =?utf-8?B?djRxTUczZlhPeTl4Q3RISGxJZGxXZHR1WkE0RUdxSjNTU0hxRDBzaHBJLzRy?=
 =?utf-8?B?SUFIMnlDMG5rYVBFTGVNSFNVYW90ckZEZS84eXRTTmF1aDJXQWlvcjJKOTZ0?=
 =?utf-8?B?QzdxckpkYzhzdlBqOFpWQVdQcHlualBWbTBzMDZNU2d2dmxHTmhjMG0xeHJT?=
 =?utf-8?B?d3l4WEJRVUxEcExXcFZjS3Vla1hMOFdMcDVRYjREOWw0cE80cFBPSEhtYlJO?=
 =?utf-8?B?K1poVm53UzgzM01tR1MveXpaODEwT1AzUFo1aThpTVpLcXMxLzZwTlJqclMw?=
 =?utf-8?B?UCtiMjU3ZkN2azVUVG9LeXBBZHU5WHN1OS9rQmhrVFFJeGxzVCtmSHhUY3Mx?=
 =?utf-8?B?eWZkcUFxUDVVbEJCQUp1WDZEOFpnQTcvM2FTTFQ4clZ0Z3pkdlhMa1pEamlz?=
 =?utf-8?B?VkN0eXdWZEFsMUo4MTY2NTFkdk92b2RpR1N1WmNnSDFxMjhaRFFTblQ1NmFn?=
 =?utf-8?B?bm5kTy9OaGJ2VksxbkZ2dmFvempPemRaZUhnd1MzVit3c3c0Q2x1VWZxakJh?=
 =?utf-8?B?WVlSVHRZVFkrN0tPT1ZsbTRKblBYMUZJMXR5eVNyRWVRU3MydUk5UkNjYk1H?=
 =?utf-8?B?RzN0TGR4R2xLanFPREE3Q1pnVG9uWHdIK0xBWHB5VlUwVkErcWkyMStncC9u?=
 =?utf-8?B?OVhtcVBHOGtuOEhtT1k4NUlIczJFczZFNEw4S0xBN0ZFMDlxQ2ZLNFJCOEZp?=
 =?utf-8?Q?DU4AeJEI9WpQmAfwKo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbc6e8f-0e0d-4cb0-2397-08df4696f045
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 23:43:39.9947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6R1YMuetn3XNGEUWLMaGcCWDQ1Zk4hmvwwJ3woVqNZj+6pIatjfbwwoCfIwRiuUBKcGJm0zGQsKqc4cgxyoNeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4
IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE5vdmVt
YmVyIDE5LCAyMDI2IDExOjU0IFBNDQo+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFu
LktvZW5pZ0BhbWQuY29tPg0KPiBDYzogWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFt
ZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhh
bmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtoYXRyaSwgU3VuaWwgPFN1bmls
LktoYXRyaUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZHJtL2FtZGdwdTog
ZG9uJ3QgdW5yZXNlcnZlIHRoZSBmcmVlZCByb290IFBEIGluDQo+IGFtZGdwdV92bV9pbml0KCkN
Cj4NCj4gT24gVGh1LCBOb3YgMTksIDIwMjYgYXQgOTo1NuKAr0FNIENocmlzdGlhbiBLw7ZuaWcN
Cj4gPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+DQo+ID4g
T24gMTEvMTkvMjYgMTA6NTYsIEplc3NlIFpoYW5nIHdyb3RlOg0KPiA+ID4gVGhlIGVycm9yIHBh
dGggb2YgYW1kZ3B1X3ZtX2luaXQoKSBmcmVlcyB0aGUgcm9vdCBQRCwgd2hpY2ggY2xlYXJzDQo+
ID4gPiB2bS0+cm9vdC5ibywgYW5kIHRoZW4gdW5yZXNlcnZlcyB2bS0+cm9vdC5iby4gT24gbmF2
aTQ4LCB3aXRoIGFuDQo+ID4gPiBhbGxvY2F0aW9uIGFmdGVyIHJlc2VydmluZyB0aGUgcm9vdCBQ
RCBmYWlsaW5nIHRocm91Z2ggZmFpbHNsYWINCj4gPiA+IHdoaWxlIG9wZW5pbmcgdGhlIHJlbmRl
ciBub2RlOg0KPiA+ID4NCj4gPiA+ICAgT29wczogZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0LCBw
cm9iYWJseSBmb3Igbm9uLWNhbm9uaWNhbCBhZGRyZXNzDQo+IDB4ZGZmZmZjMDAwMDAwMDA1ZTog
MDAwMCBbIzFdIFNNUCBLQVNBTiBOT1BUSQ0KPiA+ID4gICBLQVNBTjogbnVsbC1wdHItZGVyZWYg
aW4gcmFuZ2UgWzB4MDAwMDAwMDAwMDAwMDJmMC0NCj4gMHgwMDAwMDAwMDAwMDAwMmY3XQ0KPiA+
ID4gICBSSVA6IDAwMTA6YW1kZ3B1X3ZtX2luaXQrMHhhOWYvMHgxNDgwIFthbWRncHVdDQo+ID4g
PiAgICBhbWRncHVfZHJpdmVyX29wZW5fa21zKzB4MmIxLzB4ZDEwIFthbWRncHVdDQo+ID4gPiAg
ICBkcm1fZmlsZV9hbGxvYysweDU4Zi8weGFjMCBbZHJtXQ0KPiA+ID4gICAgZHJtX29wZW5faGVs
cGVyKzB4MWIzLzB4NGIwIFtkcm1dDQo+ID4gPg0KPiA+ID4gVW5yZXNlcnZlIGl0IHRocm91Z2gg
cm9vdF9ibywgd2hpY2ggc3RpbGwgaG9sZHMgYSByZWZlcmVuY2UuIFdpdGgNCj4gPiA+IHRoaXMg
YW5kIHRoZSBlbnRpdHkgZml4IDQ4NDIgb3BlbnMgd2l0aCBhbGxvY2F0aW9ucyBmYWlsaW5nIGlu
IHR1cm4NCj4gPiA+IGRvbid0IG9vcHMgYW55bW9yZS4NCj4gPiA+DQo+ID4gPiBGaXhlczogODQ3
M2JmZGNiNWIxICgiZHJtL2FtZGdwdTogZml4IGVycm9yIGhhbmRsaW5nIGluDQo+ID4gPiBhbWRn
cHVfdm1faW5pdCIpDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKZXNzZSBaaGFuZyA8SmVzc2UuWmhh
bmdAYW1kLmNvbT4NCj4gPg0KPiA+IFRoYXQgaXMgYWxyZWFkeSBmaXhlZCB3aXRoOg0KPiA+DQo+
ID4gY29tbWl0IDI2NDAxYTQ5OTlmMTU5NmE1MTViMmU3MDRlNzA2NmFjMDkzMDY0ODgNCj4gPiBB
dXRob3I6IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29t
Pg0KPiA+IERhdGU6ICAgV2VkIE9jdCA3IDE0OjQ2OjU3IDIwMjYgKzAyMDANCj4gPg0KPiA+ICAg
ICBkcm0vZXhlYzogZG9uJ3QgaW1tZWRpYXRlbHkgYWRkIHByZWxvY2tlZCBvYmogdG8gYXJyYXkg
b2YgbG9ja2VkDQo+ID4gb2Jqcw0KPiA+DQo+DQo+IElmIHRoaXMgaXMgbWlzc2luZyBmcm9tIEFT
RE4sIGZlZWwgZnJlZSB0byBjaGVycnktcGljay4NCg0KSGkgQ2hyaXN0aWFuLCBBbGV4LA0KDQpU
aGFua3MuIEFzIGZhciBhcyBJIGNhbiBzZWUsIDI2NDAxYTQ5OTlmMSAoImRybS9leGVjOiBkb24n
dCBpbW1lZGlhdGVseQ0KYWRkIHByZWxvY2tlZCBvYmogdG8gYXJyYXkgb2YgbG9ja2VkIG9ianMi
KSBvbmx5IGNoYW5nZXMgZHJtX2V4ZWMgYW5kDQpkb2Vzbid0IHRvdWNoIHRoZSBhbWRncHVfdm1f
aW5pdCgpIGVycm9yIHBhdGguDQoNClRoZSBzYW1lIGZpeCBhcyB0aGlzIHBhdGNoIGxhbmRlZCBp
biBhbWQtc3RhZ2luZy1kcm0tbmV4dCB5ZXN0ZXJkYXk6DQoNCiAgNzY4ZTEwNjgzM2E5ICgiZHJt
L2FtZGdwdTogZml4IE5VTEwgZGVyZWYgaW4gZXJyb3IgcGF0aCIpDQoNCmZyb20gUGllcnJlLUVy
aWMsIHNvIHBsZWFzZSBkcm9wIHRoaXMgcGF0Y2guIEknbGwgY2hlcnJ5LXBpY2sNCjc2OGUxMDY4
MzNhOSB0byBhbWQtdW5pZmllZC1pbnRlcmZhY2UsDQoNClRoYW5rcw0KSmVzc2UNCj4NCj4gQWxl
eA0KPg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBDaHJpc3RpYW4NCj4gPg0KPiA+ID4gLS0tDQo+
ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAzICsrLQ0KPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+
DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gPiA+
IGluZGV4IDhjYzU5NjRmMjljMC4uMjcyZWFjMGVmMzE3IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+ID4gPiBAQCAtMjcxOCw4ICsyNzE4LDkg
QEAgaW50IGFtZGdwdV92bV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ICphZGV2LCBzdHJ1
Y3QgYW1kZ3B1X3ZtICp2bSwNCj4gPiA+ICAgICAgIHJldHVybiAwOw0KPiA+ID4NCj4gPiA+ICBl
cnJvcl9mcmVlX3Jvb3Q6DQo+ID4gPiArICAgICAvKiBUaGlzIGNsZWFycyB2bS0+cm9vdC5ibywg
cm9vdF9ibyBrZWVwcyB0aGUgQk8gYWxpdmUgKi8NCj4gPiA+ICAgICAgIGFtZGdwdV92bV9wdF9m
cmVlX3Jvb3QoYWRldiwgdm0pOw0KPiA+ID4gLSAgICAgYW1kZ3B1X2JvX3VucmVzZXJ2ZSh2bS0+
cm9vdC5ibyk7DQo+ID4gPiArICAgICBhbWRncHVfYm9fdW5yZXNlcnZlKHJvb3RfYm8pOw0KPiA+
ID4gICAgICAgYW1kZ3B1X2JvX3VucmVmKCZyb290X2JvKTsNCj4gPiA+DQo+ID4gPiAgZXJyb3Jf
ZnJlZV9kZWxheWVkOg0KPiA+DQo=
