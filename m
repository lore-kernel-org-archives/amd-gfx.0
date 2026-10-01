Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBE3CA5FCB
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 13:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC16510E37D;
	Thu,  1 Oct 2026 13:49:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GZAKjc2f";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A8610E37D
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 13:49:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFvwlUddDDPHlgFBy+R1gplK7zkXOMouQBltKylU1gUgN8K10lXijvesY23iQXal5vf4zvU168cmgUNktNnIdK8luMOsbL4WR1ipMLM0eUe4/ku2E4aWXwtqsNs5Kk/QMPzJwMSAe9i7RCcHLi++AoAjsZKOA9R1p5TZ9MaMR6xipwKzGv9GjuD2y8yqYY33fNZrNHJhH8oNyclLa6i90VxiaQ6dLG6Lcs9CdjjAICV+prp43Q9yO7hx+tS3q/yW1laWvOzpvnIfRfMNv8nQFgo+NXyo1L1qj5NtHEm4UFYDox2op1SxIlHgH8ph3NPOMOCyfDxN3ew2YxVUK7PglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvRBR5WEO+t2TB2hNYssj/7nBHI0XeQWeVaKH1Uf4Q0=;
 b=CRLULgAJvn1j561g1GHwTfHF2Ou8OekKqGHcPh3ql7P30oyJD4I4VUyWO/x/+Tzt2xTdHQ0XhjZK4fuuFQ61QZQypXj6RT4ldOtw30JhjjCfsktZgKQmGNRSatiSWsJUpXhPn3cNJhJYjXkMbpxBfaWaHYlyF3APFAmm9JBIdXGkUTE1gy70dnF8VZVsF3AXF+3hpoAjswGeoPS2I+aixxUDaTeS/xRCiqnnLBZ2IMW9oduuIZCbOSGTllAOKnxae6xlb+oHiOfy3UYi7+YprGvYvyCYGtvn5SeaIL3vhLC5xomnOzMSG3uQ37vpNVOxiKcLeI0vcZAlaFvDncJ1og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvRBR5WEO+t2TB2hNYssj/7nBHI0XeQWeVaKH1Uf4Q0=;
 b=GZAKjc2fBDLf0fmScjVYGkEhF7wW9y9W71I6Cb7bNXrYvkik2Cwwltyku8G07R1PXnmOJ/SomK2opJinqgAPygzhoUKnDHwGdOiBPI/GzBGMq76C2wLJypYRScTirRDvR/aLhfRUQRM6A+91wHOqNFLRvy5rJ5QgyRCOpRnc+nw=
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by SACPR12MB048696.namprd12.prod.outlook.com
 (2603:10b6:806:542::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 13:49:46 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%6]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 13:49:46 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 =?utf-8?B?VGltdXIgS3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
 "natalie.vock@gmx.de" <natalie.vock@gmx.de>, "Huang, Honglei1"
 <Honglei1.Huang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>, "cascardo@igalia.com"
 <cascardo@igalia.com>, "tvrtko.ursulin@igalia.com"
 <tvrtko.ursulin@igalia.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/9] drm/amdgpu: fix cleared PDE/PTE flag generation
Thread-Topic: [PATCH 2/9] drm/amdgpu: fix cleared PDE/PTE flag generation
Thread-Index: AQHdT1uRfnRA7ydejk+BA9BRBZq05bbkWtKAgAJ7TwCAAF+cAIAABDgAgAAUZQCAASOSAIAARjRg
Date: Thu, 1 Oct 2026 13:49:46 +0000
Message-ID: <PHXPR12MB9992565EDF4369644C9B5D4614EE8A2@PHXPR12MB999256.namprd12.prod.outlook.com>
References: <20260928151041.1857-1-christian.koenig@amd.com>
 <20260928151041.1857-2-christian.koenig@amd.com>
 <P3WG6T-ATwauPO6Yp0bWtQ@gmail.com>
 <cd5af67b-d2af-43a5-be86-216155f46ff8@amd.com>
 <7b1ec2f8-0619-4132-ac35-bc2722755b97@amd.com>
 <9b181f91-4de1-4c0d-8a38-dfd75c8eb98c@amd.com>
 <33693b8d-ed0a-4910-af87-eb29e887a1d5@amd.com>
 <610259c5-bffb-4440-8e3c-43dbcd0038c6@amd.com>
In-Reply-To: <610259c5-bffb-4440-8e3c-43dbcd0038c6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-01T13:47:37.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PHXPR12MB999256:EE_|SACPR12MB048696:EE_
x-ms-office365-filtering-correlation-id: 691e32cc-9579-4054-4a5c-08df1fc2da9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|921020|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: ul4InKR4Vb4JcWIVrWQHuc5JPFVhlDA4mmbmCA0jgezetuAlr22Ms32+irwD+UgsYkcTRFZDxWGr32oba6FZjWwhULF8j6GXVXt22KIRgKPvQJAI1w4fSfecrzV6E8/XArhQOi44aneVD449wESEc45sdS16l2s+rvl9eM3Ur9NHiSD6CmPRBzfb0I2LaBKVaFEZsnW4eq3letOdywPq5gpOL3wH2dk/m3fZzYcnakUyGp+YqBxRMgBfHau9N50XxnD9seiZf5x4JDQ35I0/yTKCeF45yacHWUo6b6mmmYmUcNsxtDxzG7x6q9qy85TWQxdLBnykUV813/z0lWbu4vYNizYku/Yw83QGQxQIKKOGxLSnUnCVu8GDcmEj8s8ExOApWk0C7giRrg9PwtTNhLWO+cPi8QxzhJMf0QNXfsNJ58yf3pOd6qP6JBMkjP+SNPI0dAsay+uAaDTs9khPnh36bwy7u62RNYXul94PkJVzTJ++qYLdYarDT3r2DyIE98nBocaszJNDNUKWK8b4GcCsMRX/oo1YzS3p8QLoPoYJPdsXOLIs+lDEAiH18B4t8B+0+1nFhTWfX/g32lfzlDZAL6DRWMhlCsfwTmqA5B1/vB3icF3vCS3deVNTIxMt0qlvmvsrnAuXaNdlmvrsbP2JOORRYkvngUlN788jepW41RTM0huSJHOZ+HDdv9scBB6JekDP3N6z8U2t7i+XHfbe/r0ExIWYOxLWXEhoDxd5RXXkerb8Sc2GQvN7YemL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(921020)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmVsYTY4SEtjT3JhYlN3M0kwVGRtNnU2VlBzeGxpOU8yMm9CS2UvZG54MWRN?=
 =?utf-8?B?RzR5Y1JQdzZPL3I4UUQxQkkwZnJkTjQ5Y2Rza211MWU3WDNzVXZ1NkRzQkY3?=
 =?utf-8?B?ZjJhOUFaSVhCMGJSQ2V1NUV1TGQ5ejJtbUdIYW9rR1BlQzZMMmdVa3RneVAw?=
 =?utf-8?B?dk95VUhsTnhZejBHVVdFbmUrbkJnZGJBS1BIV2NBbDZkekh0c09FNUxDZFho?=
 =?utf-8?B?ZTEwM01LTVM4OVVBY2h6TE1qZFZFWTY1WWxDOEVkOTE5MDFrdkh5aUgyTDBi?=
 =?utf-8?B?RkIybHFIVDJOMTBKcFV1MU1NVUdwQk5SRTJqRXZZRlYyRUdpWWt2WHZZOVly?=
 =?utf-8?B?bXZTL29mTkc2bjE5bDVNK1Nxb3FmTFRJcFRjNFc3c0d0T2ZqdHJZN1FCdFJw?=
 =?utf-8?B?SDlJODRPbWs4YWZWUnNKVURTeGlROVJJRmlQUGFibmVYMkJyZElPZGRVSitT?=
 =?utf-8?B?VDh2Z2NwTURwS2owKzNGT0dIQ2VReFdTRy8ySmpBTFJoVVBQay9HbFVoNFBt?=
 =?utf-8?B?NzJDdC9tTkZWYjlPRzBIdThPdkE4L3VyblZ4eVc2TzBRMUtIcHZhUlZvWmg3?=
 =?utf-8?B?eEI3NDVIZnZkcUtWWDRjUHJMUk1Nc2VTY2doUjN6djMwWExNREhJWkRhWnBx?=
 =?utf-8?B?LzlqeXZyN3p4ditaQ0QxRDFSM3RJOG9SU0lRdWZZblZPZjFsb3piRm1YaHNx?=
 =?utf-8?B?WjJ0SlFrcFBCYS83ZG9EVURDd3MyVkN4UlNCOFppZUttaEpkTEF6UVFjaFh6?=
 =?utf-8?B?MlRsZ0dlYWNSakZscjhGb01oUy9GMnNGNitqbDlUOUwxUTdQdW5GcWJ5enRs?=
 =?utf-8?B?RWt4N2wxcnJwNk9zUGJ5ODdaZ2lnSGlUUVVSSjc5ck11LytweG5ETU5LbEVF?=
 =?utf-8?B?eVEyUG1yQmtBdk95MjUrWnMvWXpkZGZEUjRIOHJ1Q2ZOU0I4R1hxaVBHTitO?=
 =?utf-8?B?Z0tNdTF3dk01RnJjTFYxWmU1VEYvOVpvdllxdWRLbTRhSzNSOTMvNTlwS1pS?=
 =?utf-8?B?OWY4dFZrY0l2OGJhbUJsek4vMGlmNysvUElBdjNoaVpPZ3ZaQXMvWWlIekhO?=
 =?utf-8?B?cG9ZeWpyblZtV3hmV3dxK3hlT0ZDSGJHalkzMWpDUExzYmVBZlVZWGEzSy9w?=
 =?utf-8?B?WW53aDFSb2RtN0JpcmlUeUZSS3pHWUxYUVlzYk9IWHE4ZHNjNU9RRGlWN0tw?=
 =?utf-8?B?Rm1WbjJFWEdPZStUSlg0WjRRZmtsSlpwRjh5WHd2SG5kdjRnMHo3RWRwVE0x?=
 =?utf-8?B?UlFJckVzVWQ5UjhsWU1NVEd3RUNQK3BLNmJCbmx0MTR5NEFRNzRhQ29xMmp5?=
 =?utf-8?B?SEdJSEV6aTJOTURhc2VwZGR1MGlaOUF0Y1hKQThWVmxJVEJmeG1YbkFVYkhz?=
 =?utf-8?B?VTVmaDE4YXZtUmRvSDZrd2syVE9MR1Y1MXJVL0FlR3g1NU8zb08zRzQ1dDZx?=
 =?utf-8?B?UDNjeTNBSGRSdzl1YVpBUENnT0p0WktKRDM1Z1RocDZ6bDlXWUxLNzdYZURQ?=
 =?utf-8?B?OG5sYlpHYnhXV3Y3SWJramRiTXIzOXk5ZytrT3ZqdUs4T01MMDdqb0VrZ283?=
 =?utf-8?B?UTZpN2Y2emo0MVlUdVBqc0tHWmFucWRISXV4VkY2OXNkNUoxRmErUWdLWG9T?=
 =?utf-8?B?NG5TUVZnSGZpc0xWb1BUZTRPNkZ4WHRveUJra2wrbkpPbXBubWM1UFJlcUtm?=
 =?utf-8?B?V1pWZC9pNUh2dCt6NW1WQUlkU3d1ZnJpWFFRNSsyZTh5c2xLZUNEYjBXSk0y?=
 =?utf-8?B?VVVhZERLdVBuSnNMcWo3QzFSOERiM0I0czFSZzhxK0ZrR2hMUXhER1lnN1lH?=
 =?utf-8?B?VWNaTDBac21VU3BrakJId0VxQmRYZFI2emJGSmlzREJhRXl4TmJ2VG5zNS9a?=
 =?utf-8?B?MndYMUJ6M1U5S0RQQTdhbDM0U1NMZXpVYi9ITUVoZWxRUnB1b2Qvd1VSWjZC?=
 =?utf-8?B?cFd6ZVZ5dWxxUkZNbG00NC9zMythNDZMTXZmaVN2Vko4NENYVk9zZjMvR2VW?=
 =?utf-8?B?Qk5mZVorS1BQM0NabDBndkc5TzMwTkkrcjdoUFl2N1FQSjZYUVA4WllVOGtq?=
 =?utf-8?B?OVJyb3pBMkJkRUl5aW0vSEpCbVB4OWNOc2FZbE1DTGUycVhTRlQ1dlJzWW03?=
 =?utf-8?B?VTVoWkNKcFV1a1IrUmRlNEV6eTd5aVlnL1pQQkdzQzFBZGpJNGx0aVBaR1F3?=
 =?utf-8?B?ZUg5c3I2b2ZOclFZdmx1Tkx4dEJwMCtxbVZBWk9WSjdyVDVNb2V4dTRyNk5G?=
 =?utf-8?B?RjFvMFNYQkhmNnJpREQxcWJZdUU0NURhNXBTaXErU3BmTEpoWVlJNWJhUE1z?=
 =?utf-8?Q?MRot8IZXq6nyD2z1jn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691e32cc-9579-4054-4a5c-08df1fc2da9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 13:49:46.1117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: veb8vrhyGvBMIKoTzBYr0SBqw2b/kRRtFVjR/YIlf6WUIE7T7X/IsTj+L84ldY4nFMrL4QC4TNz9iZSM3ut2bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SACPR12MB048696
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQt
Z2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2Yg
TXVrdWwNCj4gSm9zaGkNCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMSwgMjAyNiA5OjM2IEFN
DQo+IFRvOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBLb2VuaWcs
IENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgVGltdXIgS3Jpc3TDs2Yg
PHRpbXVyLmtyaXN0b2ZAZ21haWwuY29tPjsNCj4gbmF0YWxpZS52b2NrQGdteC5kZTsgSHVhbmcs
IEhvbmdsZWkxIDxIb25nbGVpMS5IdWFuZ0BhbWQuY29tPjsgRGV1Y2hlciwNCj4gQWxleGFuZGVy
IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWWFuZywgUGhpbGlwDQo+IDxQaGlsaXAuWWFu
Z0BhbWQuY29tPjsgY2FzY2FyZG9AaWdhbGlhLmNvbTsgdHZydGtvLnVyc3VsaW5AaWdhbGlhLmNv
bQ0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCAyLzldIGRybS9hbWRncHU6IGZpeCBjbGVhcmVkIFBERS9QVEUgZmxhZyBnZW5lcmF0aW9u
DQo+DQo+DQo+IE9uIDkvMzAvMjAyNiAxMjoxMiBQTSwgS3VlaGxpbmcsIEZlbGl4IHdyb3RlOg0K
PiA+IE9uIDIwMjYtMDktMzAgMTA6NTksIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+ID4+IE9u
IDkvMzAvMjYgMTY6NDQsIEt1ZWhsaW5nLCBGZWxpeCB3cm90ZToNCj4gPj4+IFsrTXVrdWxdDQo+
ID4+Pg0KPiA+Pj4gT24gMjAyNi0wOS0zMCAwNTowMiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToN
Cj4gPj4+PiBARmVsaXggYW5kIEBQaGlsaXAgYW55IG9iamVjdGlvbnMgdG8gdGhpcyBwYXRjaD8N
Cj4gPj4+Pg0KPiA+Pj4+IEl0IGlzIGFjdHVhbGx5IGEgYnVnIGZpeCBmb3IgdGhlIE5QQSBzdXBw
b3J0Lg0KPiA+Pj4gQXMgSSB1bmRlcnN0YW5kIGl0LCB0aGlzIGZpeGVzIHRoZSBmbGFncyB1c2Vk
IHdoZW4gdW5tYXBwaW5nIG1lbW9yeQ0KPiA+Pj4gZnJvbSB0aGUgTlBBIFZNLiBXZSBwYXNzZWQg
YWRldi0+Z21jLm5vcmV0cnlfZmxhZ3MgZnJvbQ0KPiA+Pj4gYW1kZ3B1X3VhbGlua191bm1hcF9u
cGFfYWRkciB0byBhbWRncHVfdm1fdXBkYXRlX3JhbmdlIGV4cGxpY2l0bHkgaW4NCj4gPj4+IHRo
ZSBmbGFncyBwYXJhbWV0ZXIuIEkgZ3Vlc3MgdGhhdCdzIG5vIGxvbmdlciBuZWVkZWQgd2l0aCB5
b3VyIGZpeC4NCj4gPj4+IEJ1dCBJIHRoaW5rIHRoZSBlbmQgcmVzdWx0IHdvdWxkIGJlIHRoZSBz
YW1lLCByaWdodD8NCj4gPj4gTm90IHF1aXRlLCBwYXNzaW5nIGFkZXYtPmdtYy5ub3JldHJ5X2Zs
YWdzIHRvDQo+ID4+IGFtZGdwdV92bV91cGRhdGVfcmFuZ2UoKSBpcyBjb21wbGV0ZWx5IGJyb2tl
biBhcyB3ZWxsIGFuZCBhbHNvIG5lZWQNCj4gPj4gZml4aW5nLg0KPiA+Pg0KPiA+PiBUaGUgZmxh
Z3MgcGFyYW1ldGVyIHRvIGFtZGdwdV92bV91cGRhdGVfcmFuZ2UoKSBjYW4ndCBjb250YWluIHRo
ZQ0KPiA+PiBBTURHUFVfUFRFX1RGIG5vciB0aGUgQU1ER1BVX1BERV9QVEUgZmxhZyBiZWNhdXNl
IHRob3NlIGFyZQ0KPiA+PiBvdmVyd3JpdHRlbiBieSB0aGUgUFRFIGNhbGxiYWNrcy4NCj4gPg0K
PiA+IEknbSBwcmV0dHkgc3VyZSBNdWt1bCB0ZXN0ZWQgdGhpcyBhbmQgZ290IHNvbWV0aGluZyB0
aGF0IHdvcmtlZCBhcw0KPiA+IGV4cGVjdGVkLCBhdCBsZWFzdCBmb3IgYSB0aW1lLiBJJ20gbm90
IHN1cmUgaWYgaXQgcmVncmVzc2VkIHNpbmNlLA0KPiA+IG1heWJlIGR1cmluZyB1cHN0cmVhbWlu
Zy4gQE11a3VsLCBjYW4geW91IGNvbW1lbnQ/DQo+ID4NCj4geWVzIHdlIGhhdmUgYmVlbiB0ZXN0
aW5nIHRoaXMgYW5kIGl0IHdvcmtzIGZpbmUuIEhhdmluZyBzYWlkIHRoYXQsIHRoZSBwYXRjaCBs
b29rcw0KPiBnb29kIHRvIG1lLg0KPg0KPiBIb3dldmVyLCBJIGhhdmUgYSBxdWVzdGlvbiBvbiBv
bmUgb2YgdGhlIGNoYW5nZSBpbiB0aGUgcGF0Y2ggYmVsb3cuDQo+DQo+DQo+ID4NCj4gPj4NCj4g
Pj4gVGhhdCdzIHdoeSBzZXR0aW5nIHRoZSBBTURHUFVfUFRFX0lTX1BURSBmb3IgZ2Z4MTIgdGhy
b3VnaCB0aGUNCj4gPj4gaW5pdF9wdGVfZmxhZ3MgaXMgY29tcGxldGVseSBicm9rZW4gYXMgd2Vs
bC4NCj4gPj4NCj4gPj4gV2Ugc2VyaW91c2x5IG5lZWQgdG8gc3RvcCBkb2luZyBzdWNoIGhhY2tz
Lg0KPiA+DQo+ID4gSXMgdGhlcmUgYW55IGRvY3VtZW50YXRpb24gdGhhdCB0ZWxscyB1cyB3aGF0
IGZsYWdzIGNhbiBiZSB1c2VkIHdoZXJlLg0KPiA+IFRoaXMgaXNuJ3Qgb2J2aW91cyBhdCBhbGwu
DQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gICBGZWxpeA0KPiA+DQo+ID4NCj4gPj4NCj4gPj4gUmVn
YXJkcywNCj4gPj4gQ2hyaXN0aWFuLg0KPiA+Pg0KPiA+Pj4gUmVnYXJkcywNCj4gPj4+ICAgIEZl
bGl4DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+PiBSZWdhcmRzLA0KPiA+Pj4+IENocmlzdGlhbi4NCj4g
Pj4+Pg0KPiA+Pj4+IE9uIDkvMjgvMjYgMjE6MDgsIFRpbXVyIEtyaXN0w7NmIHdyb3RlOg0KPiA+
Pj4+PiBPbiAyMDI2LiBzemVwdGVtYmVyIDI4LiwgaMOpdGbFkSAxMToxMDozNCBrZWxldGkgw6Fs
bGFtb2tiZWxpIG55w6FyaQ0KPiA+Pj4+PiBpZMWRIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+
ID4+Pj4+PiBUaGF0IHdhcyBicm9rZW4gc2luY2UgYWRkaW5nIHRoZSBOUEEgc3VwcG9ydC4NCj4g
Pj4+Pj4+DQo+ID4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+DQo+ID4+Pj4+IFJldmlld2VkLWJ5OiBUaW11ciBLcmlzdMOzZiA8
dGltdXIua3Jpc3RvZkBnbWFpbC5jb20+DQo+ID4+Pj4+DQo+ID4+Pj4+PiAtLS0NCj4gPj4+Pj4+
ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9wdC5jIHwgNjQNCj4gPj4+
Pj4+ICsrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ID4+Pj4+PiAgICAxIGZpbGUgY2hhbmdlZCwg
MzMgaW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRpb25zKC0pDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9wdC5jDQo+ID4+
Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9wdC5jIGluZGV4DQo+
ID4+Pj4+PiBjMDMzMjdmMTI0MmQzLi5lOGY0NDFlMDE4ODM5IDEwMDY0NA0KPiA+Pj4+Pj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX3B0LmMNCj4gPj4+Pj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bV9wdC5jDQo+ID4+Pj4+PiBA
QCAtMzQ2LDYgKzM0NiwzMyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdm1fcHRfbmV4dF9kZnMoc3Ry
dWN0DQo+ID4+Pj4+PiBhbWRncHVfZGV2aWNlICphZGV2LCBhbWRncHVfdm1fcHRfY29udGludWVf
ZGZzKChzdGFydCksIChlbnRyeSkpOw0KPiA+Pj4+PiBcDQo+ID4+Pj4+PiAgICAgICAgICAgICAo
ZW50cnkpID0gKGN1cnNvcikuZW50cnksDQo+ID4+Pj4+PiBhbWRncHVfdm1fcHRfbmV4dF9kZnMo
KGFkZXYpLA0KPiA+Pj4+PiAmKGN1cnNvcikpKQ0KPiA+Pj4+Pj4gKy8qIFJldHVybiB0aGUgZmxh
Z3MgdXNlZCBmb3IgY2xlYXJlZCBQREVzL1BURVMgKi8gc3RhdGljDQo+ID4+Pj4+PiArdWludDY0
X3QgYW1kZ3B1X3ZtX3B0X2NsZWFyX2ZsYWdzKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ID4+Pj4+
PiAqYWRldiwNCj4gPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfdm0g
KnZtLA0KPiA+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGxldmVsKSB7
DQo+ID4+Pj4+PiArICAgIHVpbnQ2NF90IGZsYWdzOw0KPiA+Pj4+Pj4gKw0KPiA+Pj4+Pj4gKyAg
ICBpZiAoYWRldi0+YXNpY190eXBlIDwgQ0hJUF9WRUdBMTApDQo+ID4+Pj4+PiArICAgICAgICBy
ZXR1cm4gMDsNCj4gPj4+Pj4+ICsNCj4gPj4+Pj4+ICsgICAgaWYgKGxldmVsICE9IEFNREdQVV9W
TV9QVEIpIHsNCj4gPj4+Pj4+ICsgICAgICAgIHVpbnQ2NF90IHZhbHVlID0gMDsNCj4gPj4+Pj4+
ICsNCj4gPj4+Pj4+ICsgICAgICAgIGZsYWdzID0gQU1ER1BVX1BERV9QVEVfRkxBRyhhZGV2KTsN
Cj4gPj4+Pj4+ICsgICAgICAgIGlmICh2bS0+aXNfbnBhKQ0KPiA+Pj4+Pj4gKyAgICAgICAgICAg
IGZsYWdzIHw9IGFkZXYtPmdtYy5ub3JldHJ5X2ZsYWdzOw0KPiA+Pj4+Pj4gKyAgICAgICAgYW1k
Z3B1X2dtY19nZXRfdm1fcGRlKGFkZXYsIGxldmVsLCAmdmFsdWUsICZmbGFncyk7DQo+ID4+Pj4+
PiArICAgIH0gZWxzZSBpZiAodm0tPmlzX25wYSkgew0KPiA+Pj4+Pj4gKyAgICAgICAgZmxhZ3Mg
PSBhZGV2LT5nbWMubm9yZXRyeV9mbGFnczsNCj4gPj4+Pj4+ICsgICAgfSBlbHNlIHsNCj4gPj4+
Pj4+ICsgICAgICAgIC8qIFdvcmthcm91bmQgZm9yIGZhdWx0IHByaW9yaXR5IHByb2JsZW0gb24g
R01DOSAqLw0KPiA+Pj4+Pj4gKyAgICAgICAgZmxhZ3MgPSBBTURHUFVfUFRFX0VYRUNVVEFCTEUg
fA0KPiA+Pj4+Pj4gK2FkZXYtPmdtYy5pbml0X3B0ZV9mbGFnczsNCj4gPj4+Pj4+ICsgICAgfQ0K
PiA+Pj4+Pj4gKw0KPiA+Pj4+Pj4gKyAgICByZXR1cm4gZmxhZ3M7DQo+ID4+Pj4+PiArfQ0KPiA+
Pj4+Pj4gKw0KPiA+Pj4+Pj4gICAgLyoqDQo+ID4+Pj4+PiAgICAgKiBhbWRncHVfdm1fcHRfY2xl
YXIgLSBpbml0aWFsbHkgY2xlYXIgdGhlIFBEcy9QVHMNCj4gPj4+Pj4+ICAgICAqDQo+ID4+Pj4+
PiBAQCAtMzY2LDEwICszOTMsOSBAQCBpbnQgYW1kZ3B1X3ZtX3B0X2NsZWFyKHN0cnVjdCBhbWRn
cHVfZGV2aWNlDQo+ID4+Pj4+PiAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sIHN0cnVjdCB0
dG1fb3BlcmF0aW9uX2N0eCBjdHggPSB7DQo+ID4+Pj4+PiB0cnVlLCBmYWxzZSB9Ow0KPiA+Pj4+
Pj4gICAgICAgIHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcyBwYXJhbXM7DQo+ID4+Pj4+
PiAgICAgICAgc3RydWN0IGFtZGdwdV9ibyAqYW5jZXN0b3IgPSAmdm1iby0+Ym87DQo+ID4+Pj4+
PiAtICAgIHVuc2lnbmVkIGludCBlbnRyaWVzOw0KPiA+Pj4+Pj4gICAgICAgIHN0cnVjdCBhbWRn
cHVfYm8gKmJvID0gJnZtYm8tPmJvOw0KPiA+Pj4+Pj4gLSAgICB1aW50NjRfdCB2YWx1ZSA9IDAs
IGZsYWdzID0gMDsNCj4gPj4+Pj4+IC0gICAgdWludDY0X3QgYWRkcjsNCj4gPj4+Pj4+ICsgICAg
dW5zaWduZWQgaW50IGVudHJpZXM7DQo+ID4+Pj4+PiArICAgIHVpbnQ2NF90IGZsYWdzOw0KPiA+
Pj4+Pj4gICAgICAgIGludCByLCBpZHg7DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gICAgICAgIC8qIEZp
Z3VyZSBvdXQgb3VyIHBsYWNlIGluIHRoZSBoaWVyYXJjaHkgKi8gQEAgLTQwNCwyNg0KPiA+Pj4+
Pj4gKzQzMCw4IEBAIGludCBhbWRncHVfdm1fcHRfY2xlYXIoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsDQo+ID4+Pj4+PiBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwgaWYgKHIpDQo+ID4+Pj4+PiAg
ICAgICAgICAgIGdvdG8gZXhpdDsNCj4gPj4+Pj4+DQo+ID4+Pj4+PiAtICAgIGFkZHIgPSAwOw0K
PiA+Pj4+Pj4gLQ0KPiA+Pj4+Pj4gLSAgICBpZiAoYWRldi0+YXNpY190eXBlID49IENISVBfVkVH
QTEwKSB7DQo+ID4+Pj4+PiAtICAgICAgICBpZiAobGV2ZWwgIT0gQU1ER1BVX1ZNX1BUQikgew0K
PiA+Pj4+Pj4gLSAgICAgICAgICAgIGlmICh2bS0+aXNfbnBhKQ0KPiA+Pj4+Pj4gLSAgICAgICAg
ICAgICAgICBmbGFncyA9IGFkZXYtPmdtYy5ub3JldHJ5X2ZsYWdzOw0KPiA+Pj4+Pj4gLSAgICAg
ICAgICAgIC8qIEhhbmRsZSBsZWFmIFBERXMgYXMgUFRFcyAqLw0KPiA+Pj4+Pj4gLSAgICAgICAg
ICAgIGZsYWdzIHw9IEFNREdQVV9QREVfUFRFX0ZMQUcoYWRldik7DQo+ID4+Pj4+PiAtICAgICAg
ICAgICAgYW1kZ3B1X2dtY19nZXRfdm1fcGRlKGFkZXYsIGxldmVsLA0KPiA+Pj4+Pj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgJnZhbHVlLCAmZmxhZ3MpOw0KPiA+Pj4+Pj4gLSAgICAgICAg
fSBlbHNlIGlmICh2bS0+aXNfbnBhKSB7DQo+ID4+Pj4+PiAtICAgICAgICAgICAgZmxhZ3MgPSBh
ZGV2LT5nbWMubm9yZXRyeV9mbGFnczsNCj4gPj4+Pj4+IC0gICAgICAgIH0gZWxzZSB7DQo+ID4+
Pj4+PiAtICAgICAgICAgICAgLyogV29ya2Fyb3VuZCBmb3IgZmF1bHQgcHJpb3JpdHkgcHJvYmxl
bSBvbg0KPiA+Pj4+PiBHTUM5ICovDQo+ID4+Pj4+PiAtICAgICAgICAgICAgZmxhZ3MgPSBBTURH
UFVfUFRFX0VYRUNVVEFCTEUgfCBhZGV2LQ0KPiA+Pj4+Pj4gZ21jLmluaXRfcHRlX2ZsYWdzOw0K
PiA+Pj4+Pj4gLSAgICAgICAgfQ0KPiA+Pj4+Pj4gLSAgICB9DQo+ID4+Pj4+PiAtDQo+ID4+Pj4+
PiAtICAgIHIgPSB2bS0+dXBkYXRlX2Z1bmNzLT51cGRhdGUoJnBhcmFtcywgdm1ibywgYWRkciwg
MCwNCj4gPj4+Pj4+IGVudHJpZXMsDQo+ID4+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgdmFs
dWUsIGZsYWdzKTsNCj4gPj4+Pj4+ICsgICAgZmxhZ3MgPSBhbWRncHVfdm1fcHRfY2xlYXJfZmxh
Z3MoYWRldiwgdm0sIGxldmVsKTsNCj4gPj4+Pj4+ICsgICAgciA9IHZtLT51cGRhdGVfZnVuY3Mt
PnVwZGF0ZSgmcGFyYW1zLCB2bWJvLCAwLCAwLCBlbnRyaWVzLA0KPiA+Pj4+Pj4gKzAsDQo+ID4+
Pj4+IGZsYWdzKTsNCj4NCj4gV2Ugd2VyZSBwYXNzaW5nIGFkZHIgYmVmb3JlIHRvIHRoZSB1cGRh
dGUoKSBjYWxsIGJ1dCB3aXRoIHRoaXMgY2hhbmdlLCB3ZSBhcmUNCj4gcGFzc2luZyAwIG5vdyBm
b3IgdGhlIGFkZHIgYXJndW1lbnQgbm93Lg0KPg0KDQpTb3JyeSBJIG1lYW50IHRvIGFzayBhYm91
dCB0aGUgdiJhbHVlIiBhcmdzLiBFYXJsaWVyLCB3ZSB3b3VsZCBnZXQgdGhlIHZhbHVlIGZyb20g
YW1kZ3B1X2dtY19nZXRfdm1fcGRlKCkNCkJ1dCBub3cgd2UgYXJlIGlnbm9yaW5nIGl0IGFuZCBz
ZW5kaW5nIHRoZSB2YWx1ZSBhcmdzIGFzIDAuDQoNCldoeSBpcyB0aGF0PyBTaG91bGQgd2Uga2Vl
cCBpdCB0aGUgc2FtZSBhcyBiZWZvcmU/DQoNClJlZ2FyZHMsDQpNdWt1bA0KDQo+IFdoeSBpcyB0
aGF0Pw0KPg0KPiBSZWdhcmRzLA0KPg0KPiBNdWt1bA0KPg0KPiA+Pj4+Pj4gICAgICAgIGlmIChy
KQ0KPiA+Pj4+Pj4gICAgICAgICAgICBnb3RvIGV4aXQ7DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gQEAg
LTcxMiwxNSArNzIwLDkgQEAgc3RhdGljIHZvaWQNCj4gPj4+Pj4+IGFtZGdwdV92bV9wdGVfdXBk
YXRlX2ZsYWdzKHN0cnVjdCBhbWRncHVfdm1fdXBkYXRlX3BhcmFtcw0KPiA+Pj4+Pj4gKnBhcmFt
cywgZmxhZ3MgfD0gQU1ER1BVX1BERV9QVEVfRkxBRyhwYXJhbXMtPmFkZXYpOw0KPiA+Pj4+Pj4g
ICAgICAgICAgICBhbWRncHVfZ21jX2dldF92bV9wZGUoYWRldiwgbGV2ZWwsICZhZGRyLCAmZmxh
Z3MpOw0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IC0gICAgfSBlbHNlIGlmIChhZGV2LT5hc2ljX3R5cGUg
Pj0gQ0hJUF9WRUdBMTAgJiYNCj4gPj4+Pj4+IC0gICAgICAgICAgICEoZmxhZ3MgJiBBTURHUFVf
UFRFX1ZBTElEKSAmJg0KPiA+Pj4+Pj4gKyAgICB9IGVsc2UgaWYgKCEoZmxhZ3MgJiBBTURHUFVf
UFRFX1ZBTElEKSAmJg0KPiA+Pj4+Pj4gICAgICAgICAgICAgICAhKGZsYWdzICYgQU1ER1BVX1BU
RV9QUlRfRkxBRyhwYXJhbXMtPmFkZXYpKSkgew0KPiA+Pj4+Pj4gLQ0KPiA+Pj4+Pj4gLSAgICAg
ICAgLyogV29ya2Fyb3VuZCBmb3IgZmF1bHQgcHJpb3JpdHkgcHJvYmxlbSBvbiBHTUM5IGFuZA0K
PiA+Pj4+PiBHRlgxMiwNCj4gPj4+Pj4+IC0gICAgICAgICAqIEVYRUNVVEFCTEUgZm9yIEdNQzkg
ZmF1bHQgcHJpb3JpdHkgYW5kIGluaXRfcHRlX2ZsYWdzDQo+ID4+Pj4+PiAtICAgICAgICAgKiAo
ZS5nLiBBTURHUFVfUFRFX0lTX1BURSBvbiBHRlgxMikNCj4gPj4+Pj4+IC0gICAgICAgICAqLw0K
PiA+Pj4+Pj4gLSAgICAgICAgZmxhZ3MgfD0gQU1ER1BVX1BURV9FWEVDVVRBQkxFIHwgYWRldi0N
Cj4gPj4+Pj4+IGdtYy5pbml0X3B0ZV9mbGFnczsNCj4gPj4+Pj4+ICsgICAgICAgIGZsYWdzIHw9
IGFtZGdwdV92bV9wdF9jbGVhcl9mbGFncyhhZGV2LCBwYXJhbXMtPnZtLA0KPiA+Pj4+PiBsZXZl
bCk7DQo+ID4+Pj4+PiAgICAgICAgfQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+ICAgICAgICAvKg0KPiA+
Pj4+Pg0KPiA+Pj4+Pg0K
