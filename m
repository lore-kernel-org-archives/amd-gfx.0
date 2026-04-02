Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49941112246
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 01:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2286510ED2C;
	Thu,  2 Apr 2026 01:37:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A9ocQb3+";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5055510ED2C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 01:37:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1maUxMCW9QfArzAv7Xw1jT8e6OYi/7aaiIkRCEZ4lc586UADZBOIaVAQ37sNoqOE9b9Trl0tQDoeAmfolR6YVOhh7AjYG9IwLfY65Ms2jbxVLWa2HpySLS9JBWa6mMectTwmnmsF+k6vBYNY2Yh7SrLgUqMxzDwZ6aTfG+Mx55NSfQwHgMBJnuMP8NsSCa3KLC8pJfwf04jqoFUB30LjYaFXz9RSkOd4u/f2EORxZkM3cOosbwfDUaxNyYbgGB/baqnwBILQxaF+9XXnrRmiu8c9R9F4hRj89TsWjPu8yOCJxzVZJfip3DLRpv9Nx0e+54GUJa9penq3KE53XKjZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ryy84DWaFdSem9frI/HDhvD2OwYQyz9FMsI/l4qDHw=;
 b=qKmpXKC8Bc8gIY2etASG4F+UVXOEtDprqRSIGnDAIJZ5OIKQC8FKVMCMMWwOcWz+0MKzRDxGz8lmy5I/B9Uv/lQ/dJwcwvADqbMNADrueMnFImmJsHDT46yFh0QFXESkv/rrtuZ5ejHvYQLtUn/4BtuH7p/xwlow2Tk9N3VGPrY4hAqpMuo6Ik3I9CdXfIyVS+ln/x1zdJBDxZZAxLVCRDtswfGuLU5EgK4ersfIpdZppuNYeTCcOiCV+CmtqjlvcuqbohvFGJdOSw8toOxE0yikR43wOm5SXiwvzWWfGwJZMN8pFZ9iPQk/9ebwrG4KcEbMAHcyQmHB/Bcz9j6vcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ryy84DWaFdSem9frI/HDhvD2OwYQyz9FMsI/l4qDHw=;
 b=A9ocQb3+ixQ8Y7k5pA/zDEim9U7G4k1HID0+FONlgw+2QocB7uVrJgzBxQSFBWwNgI1vLFaXyWGfDoERsjch4175tj60Xma2rSbKnla1rOXkLdetd4JXTtnAVh/lgY30pdXXEIHsvmdgzuoZPxnNC7VFr3g1TQ+ewcBCcKz8gOk=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 01:37:19 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%2]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 01:37:19 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: make userq fence_drv drop explicit in
 queue destroy
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: make userq fence_drv drop explicit in
 queue destroy
Thread-Index: AQHcwb8PXOWtVSas7EqNo4dfPzFAJbXKNxqAgADGIzA=
Date: Thu, 2 Apr 2026 01:37:19 +0000
Message-ID: <PH7PR12MB6000F78271983CD2B436864BFB51A@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20260401100508.3397962-1-Prike.Liang@amd.com>
 <20260401100508.3397962-2-Prike.Liang@amd.com>
 <e5dc9c66-170f-41d0-920a-396ac94c6660@amd.com>
In-Reply-To: <e5dc9c66-170f-41d0-920a-396ac94c6660@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-02T01:31:10.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|DM6PR12MB4217:EE_
x-ms-office365-filtering-correlation-id: 6141a889-6360-470a-52a8-08de90586101
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|38070700021|22082099003;
x-microsoft-antispam-message-info: o8GQuc9tD6AGnvSQaAqXxYwuoWKuTJ0l8o477fgl0HnyF/4tWsN2lRoTUfb1mwUrXDW1//vz6QD9+8a7nUi6lZ8IPa3vCATVOJLpwa15b0Y4Sqi+wZFx3JhJjXvy2a0368prsbI/OAsDzpxujcFm7nzdab/6PFLa1aF67FY7hp6S0LrtRFGbIaydMsKpnV5E05bw5O5EXWwhHe7W7ga5yQQMHp7OZpvO/Ey7fEfjL+ar+HFUgVZI7O/XbwBTreLKJi7w/gMDSrHfgbRPPCh6YcHkTS2cjzAV+r6TOaqIzIB3OhjyZpkefPJqwVCiCf93jI10LXimGfxQT6ItOqoiVmYpdd/lcYYlSK4uaTO5KWg2gtrWYyFOmdX7J2mRm/DQI2Rg/eoEiof5MYOIAxM5/AvpSg4zWwxUNHSppyUYw6jImdhchKxUzQwf80e1wS4y0DYt9u/cgnHdX+eEC9UoWj2DG+P/qsSIyZOZn90GMc/DHfQKvQkhEYGOWaPm903Mdad1hCqyzqYWyuucoI/+wsDyrbLX7RsfKkuHRWLJL9CR1qkYIX4e+JgjeYjf+Zv26Ny7b0TRYYhy6TEr8WJU8xRUIOX1xJcUN1kdnyHob7+JGWSoKxJiLIZMOdmPzUznlahg3FMdWaRFDGhNr/pgOYJeGZBBMhL9f0l0gR/674hDuMUzwmVjJKd7UrEBwgmH+Jx7oJX71S+YgNrvrfFewM79CVpHm3zh7AJMYBInaBc6wWFKM+uDaBlQiQTHihBJYYorjU+UyM/TWaY6OYUjFPQkFkpNxUuBUK+gk78mlVQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(38070700021)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2ZKR3hCM1VFSW1UOHBvNFFQekUzL0VTd2tUTTArLzE3emZKamtZU2ZYbGtk?=
 =?utf-8?B?VERUQUJaMWNpWVZiU0I1WjREamJIT1BkM0RrMXN4T0xpck51QVk2K0F0WHlh?=
 =?utf-8?B?ejVEODhVcjNmOTdzanNyVFpEd3JUQ211VDB3U2FuajQ4d0xPWEF5dE1mT1B6?=
 =?utf-8?B?bmtLUmt0T0FIQkFIUXJsVTRWM3lLY2xSN2wydlI1QmpCeEo4emYwVVNESzVt?=
 =?utf-8?B?RVNmdkV5dXJ0aWJ6dVZudDlhRDZSVUNVbzlYeTI1TGVQY0JqTG5STzBYU2Zw?=
 =?utf-8?B?OGxaQW00cXZ3bXpZbHM4UkdOQndWSTRZV05LUXl5cU90ZmdoUnVvNkFWbkQz?=
 =?utf-8?B?UUkxQTB0d0swWnV0Qkt1MGYwNDc0VXREN2JzZFRsdDFJVTl0WkxjeUptNjJ1?=
 =?utf-8?B?V2dJcnFkVHY4MlRxZkRPLzVTem1YekMzNDJsNHlQVEMwM2R3aU5LaUhTUzRD?=
 =?utf-8?B?KzZ1SVFsSGdNekU5RlUvNTBpemF2c296TFZKQ1puVXh3RnFoVlRmWmZOd3lw?=
 =?utf-8?B?eFAwTTQ2dXY3VENTNTErSWNmZmZFOVZLZDE2UEUrd2pDcW9LMGcvanhPRTht?=
 =?utf-8?B?blFGbVhUWWVma3ZLQjZwcE14UTlFS0NOTFY2aFdPTG9zRjV1YXhLV2RjakZB?=
 =?utf-8?B?K2RaZGJ1NnNZTGdsL1lNYnVSRnZVcWxWWVBVc1k4SDBtcWZoa2RwVGgzQnBu?=
 =?utf-8?B?dnhNcFNYV01TTWJNa24rdWMxa1E0b0EwcVJ6SGFYLy9VUUpvNXVMV2xSTnlX?=
 =?utf-8?B?dHQyQ1NCZmd4ZFI3ZlFtUmlpbVhtTEZtTlk1cHVqK1RIOVNqWTVSVXEvalda?=
 =?utf-8?B?WEhRWHpvNGEwWkdFaWlxc1IwZUhKWDFQUTNZdEJlRDRRa0xhbUZ3N3pRMHVB?=
 =?utf-8?B?bzRwQXdwSUxXODFCbzBEb3pYUVJhL2FTaHcxcVJRa2F5TGtqajFCcTVpY0Ru?=
 =?utf-8?B?WnNyWlhIWmxab0UxYjlzMWhDUnQxMmhZRkEwZStwYzlub01UWndKa2c4QWVr?=
 =?utf-8?B?RWZjNzJhZUhhQzgrYVZXc2FBZnBVZFlzank3bHIrcm1wRWgwUGVxREN1WC9n?=
 =?utf-8?B?UG9IZHVNRXFKQ0traDB2c0x5VUJ4bnVwRDdhOGUrSUNYYWN3T0Zkb3lsZHFa?=
 =?utf-8?B?VHd3TnVRejEyQXc2ZWtNbWlsWDU1QWFtaGx6VlNnSytVSmVoRmdXQmFGeUFY?=
 =?utf-8?B?Z2VydUt2emRMT29obE5xNExvZ2FQaVZ4MHRmc014V2lIZGc4UWNjQ3ZFb2Z4?=
 =?utf-8?B?YS9INkVZazBoQzRxM3kxTGtOODBJdmZCU0gzVk02OEJvV0k4Unl4WHhEc1Ru?=
 =?utf-8?B?UWZHSzMwUU5HdldGQ3NYZzcrK3NGZnFtQU56OG1mbHNVeGx4dm9HRk1jVjlt?=
 =?utf-8?B?blRqRmxuaE5TSksrb0o3UlNFTVkvTHNsbm9iSGY2enFIWlc1ejJEUUpqd2dq?=
 =?utf-8?B?RVBITm5GNnJtQU1Mc3M2cUZraW52R2ltUm9xM3VqZldRZjlPYmZEamZmK3VW?=
 =?utf-8?B?WlRmRzVLMXVSaGNvU0FCVjVtTGZ1c3piSTNBd3NrckI5a3pTU08xdXMyUXJj?=
 =?utf-8?B?VjF4VkxPbUhLTkJGQVVZcytZcExaTzFtY0tFVVdwUFZuM045YTJqbTRuODZL?=
 =?utf-8?B?UFU1Qm81WEpzVTdQZ0M1VmZ6RkVZWWh5NG1iMTNMOTZacW9XbEliWFF3djZ3?=
 =?utf-8?B?M2kyRGJQMkRlb3dNZW9TYjJwRnRqbmNtRXJja0xIYUo5SVhnZ3graHJCSWIw?=
 =?utf-8?B?cHhFQnM4WndLdDdKSjB3RGxyUmZzOG9qQUNxK0E5cnNKMTNIeEtwV3pSZ29l?=
 =?utf-8?B?RFhXZW9TbHhjclhOMzR2SGJFZ1RXZUZyZDdCbEhsYlptTUdiRWlYa0U0b3hL?=
 =?utf-8?B?dUx6YVZ1aUxQK0xyeHFyL0t2cHJKVk5mczZFR2FiZEhUOXhoUGwydW85SFlJ?=
 =?utf-8?B?TE01eFN4TkFRdmhxWTRNNzNNdDJnNjZkUjBvN2V5Zis1NjY2SzcwaWRLS0dL?=
 =?utf-8?B?algxN25vUE9ERDhWVU1xbHF4aG9kaXArN1ZyYTIxS2czNkFHYXJwUitRSWo1?=
 =?utf-8?B?ZTZ3QTJ1NkpkQndseXdYYXJxc2o0ZzBnK3VRZjBFSjhtWjFyYk5nS2VxUllD?=
 =?utf-8?B?bzU4L0xtT2FHeXpFclI4NG5pOExRQy92Y2dIbEtsWnNtRzlyeVA1LzlrTGxI?=
 =?utf-8?B?V2IwMDNaUXA0RkJ5Z2NhQ1hPNDhHbFdESkhQb08vR3grbHJXUHBybDZ6eW5v?=
 =?utf-8?B?ZitEUE8rR0dWbU9QYVZYZ25NNU5xOVAzNUExSlJyRzNEcGdKcmRUR2NDY3dD?=
 =?utf-8?Q?eQVwxDSBUmj0SJeVBQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6141a889-6360-470a-52a8-08de90586101
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 01:37:19.1104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwKrA6QU6rbGzj/Sao3d7g7+dLczFxA9VlVHqIlnF1rbbYdGnE56ImMbu2Z0+obi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCAxLCAyMDI2IDk6NDIgUE0NCj4gVG86IExp
YW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8yXSBkcm0vYW1kZ3B1OiBtYWtlIHVzZXJx
IGZlbmNlX2RydiBkcm9wIGV4cGxpY2l0IGluDQo+IHF1ZXVlIGRlc3Ryb3kNCj4NCj4gT24gNC8x
LzI2IDEyOjA1LCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gPiBhbWRncHVfdXNlcnFfZmVuY2VfZHJp
dmVyX2ZyZWUoKSBpcyBub3cgcmVzcG9uc2libGUgb25seSBmb3IgcmVsZWFzaW5nDQo+ID4gcGVy
LXF1ZXVlIGFuY2lsbGFyeSBzdGF0ZSAobGFzdF9mZW5jZSwgZmVuY2VfZHJ2X3hhKSBhbmQgbm8g
bG9uZ2VyDQo+ID4gdG91Y2hlcyB0aGUgb3duZXJzaGlwIHJlZmVyZW5jZSwgbWFraW5nIGVhY2gg
ZnVuY3Rpb24ncyBjb250cmFjdCBjbGVhci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtl
IExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPg0KPiBXZSBzaG91bGQgc3RhcnQgdG8gYWRk
IGtlcm5lbGRvYyB0byBmdW5jdGlvbnMgbGlrZQ0KPiBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVy
X2FsbG9jKCksIGJ1dCB0ZWNobmljYWxseSB0aGF0IHBhdGNoIG5vdyBsb29rcyBjb3JyZWN0IHRv
DQo+IG1lLg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LiBJZiB5b3XigJlyZSBva2F5IHdpdGggaXQs
IEnigJlsbCBhZGQgdGhlIGRvY3VtZW50YXRpb24gZm9yIHRob3NlIGZ1bmN0aW9ucyBzZXBhcmF0
ZWx5IGluIGFub3RoZXIgcGF0Y2guDQoNCj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4NCj4gPg0KPiA+IHYyOiBHZXQgdGhlIHVzZXJx
IGZlbmNlIGRyaXZlciBmcm9tIGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfYWxsb2MoKQ0KPiA+
ICAgICBkaXJlY3RseSBhbmQgZHJvcHBpbmcgdGhlIHVzZXJxIGZlbmNlIGRyaXZlciByZWZlcmVu
Y2UgYWZ0ZXIgcmVtb3ZpbmcNCj4gPiAgICAgdXNlcnFfZG9vcmJlbGxfeGEgZW50cnkuKENocmlz
dGlhbikNCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vz
ZXJxLmMgICAgICAgfCAgNSArKystLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdXNlcnFfZmVuY2UuYyB8IDEyICsrKysrKysrLS0tLQ0KPiA+IGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5oIHwgIDIgKy0NCj4gPiAgMyBmaWxlcyBj
aGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IGluZGV4IGM0ODQx
ZGY4MGJmOC4uNGY5ZjJlMjY2NTYyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiBAQCAtNDU4LDkgKzQ1OCwxMCBAQCBzdGF0aWMgdm9p
ZCBhbWRncHVfdXNlcnFfY2xlYW51cChzdHJ1Y3QNCj4gYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlICpx
dWV1ZSkNCj4gPiAgICAgLyogRHJvcCB0aGUgdXNlcnEgcmVmZXJlbmNlLiAqLw0KPiA+ICAgICBh
bWRncHVfdXNlcnFfYnVmZmVyX3Zhc19saXN0X2NsZWFudXAoYWRldiwgcXVldWUpOw0KPiA+ICAg
ICB1cV9mdW5jcy0+bXFkX2Rlc3Ryb3kocXVldWUpOw0KPiA+IC0gICBhbWRncHVfdXNlcnFfZmVu
Y2VfZHJpdmVyX2ZyZWUocXVldWUpOw0KPiA+ICAgICAvKiBVc2UgaW50ZXJydXB0LXNhZmUgbG9j
a2luZyBzaW5jZSBJUlEgaGFuZGxlcnMgbWF5IGFjY2VzcyB0aGVzZSBYQXJyYXlzDQo+ICovDQo+
ID4gICAgIHhhX2VyYXNlX2lycSgmYWRldi0+dXNlcnFfZG9vcmJlbGxfeGEsIHF1ZXVlLT5kb29y
YmVsbF9pbmRleCk7DQo+ID4gKyAgIGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfZnJlZShxdWV1
ZSk7DQo+ID4gKyAgIHF1ZXVlLT5mZW5jZV9kcnYgPSBOVUxMOw0KPiA+ICAgICBxdWV1ZS0+dXNl
cnFfbWdyID0gTlVMTDsNCj4gPiAgICAgbGlzdF9kZWwoJnF1ZXVlLT51c2VycV92YV9saXN0KTsN
Cj4gPiAgICAga2ZyZWUocXVldWUpOw0KPiA+IEBAIC03OTksNyArODAwLDcgQEAgYW1kZ3B1X3Vz
ZXJxX2NyZWF0ZShzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHAsIHVuaW9uDQo+ID4gZHJtX2FtZGdwdV91
c2VycSAqYXJncykNCj4gPg0KPiA+ICAgICBxdWV1ZS0+ZG9vcmJlbGxfaW5kZXggPSBpbmRleDsN
Cj4gPiAgICAgeGFfaW5pdF9mbGFncygmcXVldWUtPmZlbmNlX2Rydl94YSwgWEFfRkxBR1NfQUxM
T0MpOw0KPiA+IC0gICByID0gYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlcl9hbGxvYyhhZGV2LCBx
dWV1ZSk7DQo+ID4gKyAgIHIgPSBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyX2FsbG9jKGFkZXYs
ICZxdWV1ZS0+ZmVuY2VfZHJ2KTsNCj4gPiAgICAgaWYgKHIpIHsNCj4gPiAgICAgICAgICAgICBk
cm1fZmlsZV9lcnIodXFfbWdyLT5maWxlLCAiRmFpbGVkIHRvIGFsbG9jIGZlbmNlIGRyaXZlclxu
Iik7DQo+ID4gICAgICAgICAgICAgZ290byBmcmVlX3F1ZXVlOw0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVuY2UuYw0KPiA+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCj4gPiBpbmRleCA4
NzU2MGMxMjUxZDguLjNiZTgwYTgyNzg4YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVuY2UuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jDQo+ID4gQEAgLTc4LDExICs3OCwx
NSBAQCBhbWRncHVfdXNlcnFfZmVuY2Vfd3JpdGUoc3RydWN0DQo+ID4gYW1kZ3B1X3VzZXJxX2Zl
bmNlX2RyaXZlciAqZmVuY2VfZHJ2LCAgfQ0KPiA+DQo+ID4gIGludCBhbWRncHVfdXNlcnFfZmVu
Y2VfZHJpdmVyX2FsbG9jKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV91c2VybW9kZV9xdWV1ZSAqdXNl
cnEpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3Vz
ZXJxX2ZlbmNlX2RyaXZlcg0KPiAqKmZlbmNlX2Rydl9yZXEpDQo+ID4gIHsNCj4gPiAgICAgc3Ry
dWN0IGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXIgKmZlbmNlX2RydjsNCj4gPiAgICAgaW50IHI7
DQo+ID4NCj4gPiArICAgaWYgKCFmZW5jZV9kcnZfcmVxKQ0KPiA+ICsgICAgICAgICAgIHJldHVy
biAtRUlOVkFMOw0KPiA+ICsgICAqZmVuY2VfZHJ2X3JlcSA9IE5VTEw7DQo+ID4gKw0KPiA+ICAg
ICBmZW5jZV9kcnYgPSBremFsbG9jKHNpemVvZigqZmVuY2VfZHJ2KSwgR0ZQX0tFUk5FTCk7DQo+
ID4gICAgIGlmICghZmVuY2VfZHJ2KQ0KPiA+ICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0K
PiA+IEBAIC0xMDMsNyArMTA3LDcgQEAgaW50IGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfYWxs
b2Moc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gICAgIGZlbmNlX2Rydi0+Y29u
dGV4dCA9IGRtYV9mZW5jZV9jb250ZXh0X2FsbG9jKDEpOw0KPiA+ICAgICBnZXRfdGFza19jb21t
KGZlbmNlX2Rydi0+dGltZWxpbmVfbmFtZSwgY3VycmVudCk7DQo+ID4NCj4gPiAtICAgdXNlcnEt
PmZlbmNlX2RydiA9IGZlbmNlX2RydjsNCj4gPiArICAgKmZlbmNlX2Rydl9yZXEgPSBmZW5jZV9k
cnY7DQo+ID4NCj4gPiAgICAgcmV0dXJuIDA7DQo+ID4NCj4gPiBAQCAtMTM0LDEwICsxMzgsMTAg
QEAgdm9pZA0KPiA+ICBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyX2ZyZWUoc3RydWN0IGFtZGdw
dV91c2VybW9kZV9xdWV1ZSAqdXNlcnEpDQo+ID4gew0KPiA+ICAgICBkbWFfZmVuY2VfcHV0KHVz
ZXJxLT5sYXN0X2ZlbmNlKTsNCj4gPiAtDQo+ID4gKyAgIHVzZXJxLT5sYXN0X2ZlbmNlID0gTlVM
TDsNCj4gPiAgICAgYW1kZ3B1X3VzZXJxX3dhbGtfYW5kX2Ryb3BfZmVuY2VfZHJ2KCZ1c2VycS0+
ZmVuY2VfZHJ2X3hhKTsNCj4gPiAgICAgeGFfZGVzdHJveSgmdXNlcnEtPmZlbmNlX2Rydl94YSk7
DQo+ID4gLSAgIC8qIERyb3AgdGhlIGZlbmNlX2RydiByZWZlcmVuY2UgaGVsZCBieSB1c2VyIHF1
ZXVlICovDQo+ID4gKyAgIC8qIERyb3AgdGhlIHF1ZXVlJ3Mgb3duZXJzaGlwIHJlZmVyZW5jZSB0
byBmZW5jZV9kcnYgZXhwbGljaXRseSAqLw0KPiA+ICAgICBhbWRncHVfdXNlcnFfZmVuY2VfZHJp
dmVyX3B1dCh1c2VycS0+ZmVuY2VfZHJ2KTsNCj4gPiAgfQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5oDQo+ID4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVuY2UuaA0KPiA+IGluZGV4
IGQ3NmFkZDJhZmM3Ny4uZDU2MjQ2YWQ4YzI2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5oDQo+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmgNCj4gPiBAQCAtNjQsNyArNjQs
NyBAQCB2b2lkIGFtZGdwdV91c2VycV9mZW5jZV9zbGFiX2Zpbmkodm9pZCk7DQo+ID4gIHZvaWQg
YW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlcl9nZXQoc3RydWN0IGFtZGdwdV91c2VycV9mZW5jZV9k
cml2ZXINCj4gPiAqZmVuY2VfZHJ2KTsgIHZvaWQgYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlcl9w
dXQoc3RydWN0DQo+ID4gYW1kZ3B1X3VzZXJxX2ZlbmNlX2RyaXZlciAqZmVuY2VfZHJ2KTsgIGlu
dA0KPiBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyX2FsbG9jKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdw
dV91c2VybW9kZV9xdWV1ZSAqdXNlcnEpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXINCj4gKipmZW5jZV9kcnZfcmVx
KTsNCj4gPiAgdm9pZCBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyX2ZyZWUoc3RydWN0IGFtZGdw
dV91c2VybW9kZV9xdWV1ZQ0KPiA+ICp1c2VycSk7ICB2b2lkIGFtZGdwdV91c2VycV9mZW5jZV9k
cml2ZXJfcHJvY2VzcyhzdHJ1Y3QNCj4gPiBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyICpmZW5j
ZV9kcnYpOyAgdm9pZA0KPiBhbWRncHVfdXNlcnFfZmVuY2VfZHJpdmVyX2ZvcmNlX2NvbXBsZXRp
b24oc3RydWN0IGFtZGdwdV91c2VybW9kZV9xdWV1ZQ0KPiAqdXNlcnEpOw0KDQo=
