Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919C3CD3436
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 06:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE1E10E2F6;
	Fri,  8 May 2026 06:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mBMXYrXW";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02B7510E2F6
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 06:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyK7ZRAFt0+laWmFmH/v04II8EPScDxRXlucS3YS7onm09hoqezCPkVZoeEh7nrTH7U5mzOGx2xZGmjs5iQE4AaWeL8lJsnkOY+EK8hcriAAvUzM0BXiVDPWQnPK1dydRiU8ObT8ONgfRWVzdPKQ4S2nqk0ulBfNSQys/5Fqzdj87IuebbFyZEwvfDAYxMxZDYyZjyc/c+WNrpFsKzWw6zTlqmGevsnfLwAZ8jTjZR21JMPtudOW/I9EilwcwwlFK1eGMCO01IS+IRaomDFgDImqOW5MfKkrIl6ZWTAGdRlNzNEC8R2c/8OW6yuo6CeRmC8NqNfEZuwP9auYiSwWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1E1fg1Im979hphhXJlydZs4KLBqqwKyv37dRVAbfIY=;
 b=aufnjb/2aZouh5bb1PEvEliYnvnrD42pjEqdzcgdxhY9VS5QaBLfLrS0Iib+uq4xySOiFhsPeVUNkC+d+w8GzgRCqlJKJgVo5WbewIPb0YhElcKHpGM/WE2iQICO2XpAKTm2agdtMrJz4rTVscoXEBpCFATwSWOH1K5CJfCO8QqQk++yj9yE3ZhZT9+4Nv6/3y5HCpOpRtrvanS5uGmNitJKIh0qbkNaDKnFFW2Zu9OYqiqUICySrjRfm+9dyjlh69x5aiYeHkzMY8MX38waQ5+p/f9XhFyFtgT9wGufiuPwWHwjnBaAbq3Xx/rA9wz8OnvqxfnvKyqNThCTDaPIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1E1fg1Im979hphhXJlydZs4KLBqqwKyv37dRVAbfIY=;
 b=mBMXYrXWfZnYJB7eIGqh0B7gSmSAc9SyS7NTmIhYcJKVj2Q2WxPNeLjuHEexmAOEhlPeaIF4GJpgYso20DwT/BB4xdHUMNOWXL/OZJZ8vVmp0rDHGNZ+acYYFkgceeHT6SVpTHK4bC4kWMqmb1gSxewHb/8SmRY+wzm4cymrN9A=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 06:13:53 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9891.015; Fri, 8 May 2026
 06:13:53 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: update dpm clock pm attributes for aldebaran
 (gc 9.4.2)
Thread-Topic: [PATCH] drm/amd/pm: update dpm clock pm attributes for aldebaran
 (gc 9.4.2)
Thread-Index: AQHc3pmu+DrUhsRdEkSk2VnZnwL4H7YDitwAgAAD7fSAAAxIgIAACw/A
Date: Fri, 8 May 2026 06:13:53 +0000
Message-ID: <DM6PR12MB29728E30FAD31A3CFDDED1DB823D2@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260508032019.1617320-1-kevinyang.wang@amd.com>
 <dcfc25a2-5aaa-4c62-b684-a70f97f82516@amd.com>
 <DM6PR12MB2972C70BEDCA9C6D968AB851823D2@DM6PR12MB2972.namprd12.prod.outlook.com>
 <1c6ae354-1490-47ca-8b96-079660dff210@amd.com>
In-Reply-To: <1c6ae354-1490-47ca-8b96-079660dff210@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-08T06:12:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|MN6PR12MB8514:EE_
x-ms-office365-filtering-correlation-id: 20bd44c5-53a7-4973-952f-08deacc8fae9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099003|22082099003|18002099003|3023799003;
x-microsoft-antispam-message-info: 9HaQqWYLH7hUq1+CzKBs+0Tsqc2ula8/zFZy437oJMyKj8r8JfoC6EI+FvLqHFzB31ue+SgHOvBbe9KeCexxX6Yxg1g/ZHE8O7Jr98dyqRs2gHP0m1m6nGKL1OjYBA9W1Ykgo3EyC6oKKpCD0jPm3SjoPF0tcy8SeSfovhs/iWDQbLzR42+8Q3iaTjVJqC4tOUiDmGVs26kOI5Nf+eIcoZ6nAmCaxQhnlhykcp0WuAWgnpVs933Fn+EQluoxfF/nTLsWxq869Tc0tlAcv21eF+2MAvelYSGysTuvTkI7w+lkhiOhxq7TXK/nA5N+g1wZ/iaC4tL1jz646BcYMOcohShDb2FIEAaNLf9JKYy8Au5M1I/E84Z5N33V6u01c//9erBPWmRvcWEBwaQnxDS/uH/HmBGb3pfudiqKUcI/KxRmCePPNoUbt0xt3FB9POPG0PJJCBjjxFgu++/cOw4NCT4mzK7YGohlGu6y/O7eRYeUlhQoZ161dRcCps4+YFN8si/viWS0vpBFqw74Cu4o6OBS9U3UV4vvkhf2RwbLNU3B6J56jhwZT/iwofZJDFTlHmMte8RIehj4Mios0cYwTZ3e5vF4IrGqw1tk9xaI60eRNFa9udcg2Qk61biY08FA0/U5fvykKcJYuBnZKve9YlcQFzKmHh0g5SHb/AqV/fvxl+Jse1aA8zpt26+HHn0+qgrbNRFnrfsWxmnW8Lds7M8FHqyEvwkO9bQ3bRG39ME4Ns8RmSJGoEQ4N3Q/D0Jx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUlkWWUrdlRrTVhkbEZoTjJha0phZ2toTVlSdHk3VmVONTNxSEN2N09tQlFM?=
 =?utf-8?B?ZUFScDZVcXBJd0dSdEZidDJmT0g2b1BkZWdISURoUTBsOG5KVVRPWU1xbXB0?=
 =?utf-8?B?emlXUDBtRFBIWGRudXB0bVU5TjJqd2RZaWJJdXRveFVMak1XM3lZbWdtWG5K?=
 =?utf-8?B?eWNzak1paUIzQk9YdlRENkxrc3lXWnJLazUzYkpLT2JkWFZGdE5Iazd3L0ps?=
 =?utf-8?B?N1d6NXZwblc0TU9hSVRYNkpRMjUrN0JxcGNTSFAvL0NsME9DbFRhcll1cDdw?=
 =?utf-8?B?TXpieFljUkFDNXlPd3ZEUjUvUVM1YlljRkd4bmdsVmtOb2dGYW1Obm5yTFNz?=
 =?utf-8?B?MGFab3QzSjF3dkZTeC9GUk56Rm9wTTlZYmMzNmdZK0t0YlNmY0V2RmRQd0Uy?=
 =?utf-8?B?N3Z3NmljMXFjYm9uaGZ3OWp4bjhmUTBQZ1JXRHFoYis2NkdpNkhtdXRCcUwr?=
 =?utf-8?B?ZlE0UkxlWFVNWkpTNTM1amlhRFJnVkJ4eWtrWjRQZlR4Tmlqb0lncjNIQ1dW?=
 =?utf-8?B?T01FeDIvN1JQZTIyb0dqb09jVW1vd1NPY2E4ckV4cVJhUFFCazM4TkRTUkV6?=
 =?utf-8?B?Ni9nTXRmeHJNY01xR20zY0ZZc2NibVlpYjlMNkVFUDdJUDdReks3REYvRXll?=
 =?utf-8?B?dHZnM1J1U0tac2JSYlh3MlN0SHozK3R0Q2FVR281cGFLR2FqUW04NUxYazFi?=
 =?utf-8?B?djFIbGhPcmVIUEJYYncxdHByc21tbzlUMFQ0S2FETm1iSFpjVEpGSDlQczdP?=
 =?utf-8?B?enpUU0JCWDNyRjZGMmx4L0oxVE4zU2xZejQ2MzZDRmtTMWdtWUoyeTRjWEZQ?=
 =?utf-8?B?TnAyTXVZT3djMkFlbHF5QUpvblhuR3VSeEJYV3NrUko3dXRnaFNSM29lN1Yw?=
 =?utf-8?B?dTVKUjBxS2lzQVdSbXZMeHp0RmZIenV2MWFBQVRhTGkxNVJ1OElyUDJYWHds?=
 =?utf-8?B?UWRjeDZMOXhMM3FDTWJUZERpcFM1Y1dtOWFOaVdra05TaDU2SnNNaUZwSDBW?=
 =?utf-8?B?RFVtSFo0TU5FUHVvRExhN3Y4bnlkNGp0MVJoOGs5dVRQMmhVVFQ0LzlJNmdH?=
 =?utf-8?B?WGczWUwrTzlRRXJCemFVS0paS0l4QzNDeDdOWkp6MmlhSmxXK2YyT2J1MDdV?=
 =?utf-8?B?cG9QZnpJZTlwZEdpUnVLclJkUFVpOEtxck0xa0dIUUhYaWtodFlXUWNRekln?=
 =?utf-8?B?b0lFb0k1dlMwWE9oMGI0RlltMGlCQmNGb2hnU1I2aFZnbjlxZitPeTlaU3Jk?=
 =?utf-8?B?R1BBTXovUmFXMkkzU0xxV2NZcUQ1UlhUMzhUVDhpaVc4T0l3QTZ5ajIzYUdn?=
 =?utf-8?B?R1NWUFdXckQzbGZaN0M5eGoxMnIwZWtFYzdwMUx1N1M3TlBQd1czN28yV0Jz?=
 =?utf-8?B?WXdidmt0azBMZ1o1U1BBWkMwaFpFemplbVNlYjMxU0Y1R2VRejFQY1g0Z0Uy?=
 =?utf-8?B?YktnTEVJbU9xak1TMG1mTDRGN0p3WXpJUGxzL3BWWWxsN0hTZDVIUXhiTTFQ?=
 =?utf-8?B?WFkyYk5pMzN1eUtkMkh2YWZBbmM2dElFOGRnSVRQajl6SXhzaCt6SC9hWVVY?=
 =?utf-8?B?dkNyTGNzb1VqZXpQZktEb1hLbnl6amdqOHM3SG0xaUJnUW9kQWFId2pBcEdD?=
 =?utf-8?B?dksvVDI2eFFqb3FCNW94QndIcnJzZ2MwSjZDUGtyRit6bnRONFAxVDI1M2xO?=
 =?utf-8?B?NE5KSWlPTVFPOURrR3hPU3VFOE94ZlBmOFpCWVB6aDVJK0hSNDh2SlFXL3RV?=
 =?utf-8?B?S0hPOEtkd0NLb0N5aTZXNDhVQ3NLWStvK2Q3TmFZU3p6dGpXdVRSdXJ3Qmc3?=
 =?utf-8?B?Vy9QYU04MTRkbThzZmEzYXM5K2V6RU1qZmRxTzdpdmFSQlVNYnNMNDNoYXBp?=
 =?utf-8?B?d20wY3NDWGFhTytiQ1o0dUtJREZERDlSVUllQkVnQlBjSE5hZXVxUXVBeTY2?=
 =?utf-8?B?U3NKYzdiRXZGRjhpa01WUEZRS2s3Y0gyVDRUWTZrMVBaaW43aG1xUjZxaFdM?=
 =?utf-8?B?cU93WDcrV1VZSkFjRTRaUWRwZ1FWaE9TTzR5aHBKTXlPWVZNa2RnOXhKSjFx?=
 =?utf-8?B?azhhbHBVd25HZmJRYU1IMmZXTHF5bmI0VXhFbk84WGtCUnB5enRDb2c4WkxT?=
 =?utf-8?B?ako1RzB5VFRnelV6aGVYYzlzUkVzazZFazFHN1VIUi9zMzcrMUthZTVkODdp?=
 =?utf-8?B?T3BJelFKekpRNSttcHA4SGp2Z3pRWGE1ZHJMakN4NG9yc0RpQm5ETHI0N1Z0?=
 =?utf-8?Q?jEY4wvv59b19tFUFKonbQ8xSQ1K8HGf5Yg8QahG1k0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bd44c5-53a7-4973-952f-08deacc8fae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 06:13:53.6132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2aLZz318Usq6Cfs1NrOpdIV9Yx6zXBXUZSQJ38qBoE8sDbn7Q+Ges+Yix5rTX5t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXph
ciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIE1heSA4LCAyMDI2
IDE6MzMgUE0NCj4gVG86IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29t
PjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZw0KPiA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPjsgRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5nQGFtZC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWQvcG06IHVwZGF0ZSBkcG0gY2xvY2sgcG0g
YXR0cmlidXRlcyBmb3INCj4gYWxkZWJhcmFuIChnYyA5LjQuMikNCj4NCj4NCj4NCj4gT24gMDgt
TWF5LTI2IDEwOjIxIEFNLCBXYW5nLCBZYW5nKEtldmluKSB3cm90ZToNCj4gPiBBTUQgR2VuZXJh
bA0KPiA+DQo+ID4NCj4gPg0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAtLQ0KPiA+ICpGcm9tOiog
TGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gPiAqU2VudDoqIEZyaWRheSwgTWF5
IDgsIDIwMjYgMTI6MzUgUE0NCj4gPiAqVG86KiBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5n
LldhbmdAYW1kLmNvbT47IGFtZC0NCj4gPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnIDxhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCj4gPiAqQ2M6KiBEZXVjaGVyLCBBbGV4YW5kZXIg
PEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywNCj4gSGF3a2luZw0KPiA+IDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+OyBGZW5nLCBLZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT4N
Cj4gPiAqU3ViamVjdDoqIFJlOiBbUEFUQ0hdIGRybS9hbWQvcG06IHVwZGF0ZSBkcG0gY2xvY2sg
cG0gYXR0cmlidXRlcyBmb3INCj4gPiBhbGRlYmFyYW4gKGdjIDkuNC4yKQ0KPiA+DQo+ID4NCj4g
PiBPbiAwOC1NYXktMjYgODo1MCBBTSwgWWFuZyBXYW5nIHdyb3RlOg0KPiA+ICA+IFNwbGl0IGFu
ZCBjb3JyZWN0IERQTSBjbG9jayBhdHRyaWJ1dGUgY29uc3RyYWludHMgZm9yIEdGWCA5LjQuMQ0K
PiA+IChBcmN0dXJ1cykNCj4gPiAgPiBhbmQgOS40LjIgKEFsZGViYXJhbikgQVNJQ3M6DQo+ID4g
ID4NCj4gPiAgPiAtIEFyY3R1cnVzICg5LjQuMSk6IEtlZXAgcmVzdHJpY3Rpb25zIGZvciBtY2xr
L3NvY2Nsay9mY2xrLCB1cGRhdGUNCj4gPiBjb21tZW50ICA+IC0gQWxkZWJhcmFuICg5LjQuMik6
IEFkZCBkZWRpY2F0ZWQgcGVyLWNsb2NrIGNvbnN0cmFpbnRzOg0KPiA+ICA+ICAgICogbWNsay9z
b2NjbGs6IE9ubHkgc3VwcG9ydCB2b2x0YWdlIGNvbnRyb2wsIGRpc2FibGUgbGV2ZWwNCj4gPiBz
ZXR0aW5nICA+ICAgICogZmNsazogTWFyayBhcyBmdWxseSB1bnN1cHBvcnRlZCAgPiAgICAqIHBj
aWU6IE1vdmUNCj4gPiBtdWx0aS1BSUQgY2hlY2sgaW50byA5LjQuMiBjYXNlLCBkaXNhYmxlIGxl
dmVsIHNldHRpbmcgID4gID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5nIFdhbmcgPGtldmlueWFu
Zy53YW5nQGFtZC5jb20+ICA+IC0tLSAgPg0KPiA+IGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1k
Z3B1X3BtLmMgfCAyNiArKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAgID4NCj4gPiAxIGZp
bGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkgID4gID4gZGlmZiAt
LWdpdA0KPiA+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYyBiL2RyaXZlcnMv
Z3B1L2RybS8NCj4gPiBhbWQvcG0vYW1kZ3B1X3BtLmMgID4gaW5kZXggZmQyZTYzNTMwZThjLi45
ZWUzMDUzOTczY2YgMTAwNjQ0ICA+IC0tLQ0KPiA+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9h
bWRncHVfcG0uYw0KPiA+ICA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3Bt
LmMNCj4gPiAgPiBAQCAtMjAzMywxNiArMjAzMywxMSBAQCBzdGF0aWMgaW50DQo+ID4gcHBfZHBt
X2Nsa19kZWZhdWx0X2F0dHJfdXBkYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1
Y3QgYW1kDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgZ2NfdmVyID09IElQX1ZFUlNJT04o
MTEsIDAsIDIpIHx8ICA+DQo+ID4gZ2NfdmVyID09IElQX1ZFUlNJT04oMTEsIDAsIDMpKSAmJiBh
ZGV2LSAgPnZjbi5udW1fdmNuX2luc3QgPj0NCj4gMikpICA+DQo+ID4gKnN0YXRlcyA9IEFUVFJf
U1RBVEVfVU5TVVBQT1JURUQ7ICA+IC0gICAgIH0gZWxzZSBpZg0KPiA+IChERVZJQ0VfQVRUUl9J
UyhwcF9kcG1fcGNpZSkpIHsgID4gLSAgICAgICAgICAgICBpZiAoZ2NfdmVyID09DQo+ID4gSVBf
VkVSU0lPTig5LCA0LCAyKSB8fCAgPiAtICAgICAgICAgICAgICAgICBhbWRncHVfaXNfbXVsdGlf
YWlkKGFkZXYpKQ0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICpzdGF0ZXMgPSBBVFRSX1NU
QVRFX1VOU1VQUE9SVEVEOyAgPiAgICAgICAgfQ0KPiA+ID4gID4gICAgICAgIHN3aXRjaCAoZ2Nf
dmVyKSB7ICA+ICAgICAgICBjYXNlIElQX1ZFUlNJT04oOSwgNCwgMSk6DQo+ID4gID4gLSAgICAg
Y2FzZSBJUF9WRVJTSU9OKDksIDQsIDIpOg0KPiA+ICA+IC0gICAgICAgICAgICAgLyogdGhlIE1p
IHNlcmllcyBjYXJkIGRvZXMgbm90IHN1cHBvcnQgc3RhbmRhbG9uZQ0KPiA+IG1jbGsvIHNvY2Ns
ay9mY2xrIGxldmVsIHNldHRpbmcgKi8gID4gKyAgICAgICAgICAgICAvKiBBcmN0dXJ1cyBkb2Vz
DQo+ID4gbm90IHN1cHBvcnQgc3RhbmRhbG9uZSBtY2xrL3NvY2Nsay8gZmNsayBsZXZlbCBzZXR0
aW5nICovICA+DQo+ID4gaWYgKERFVklDRV9BVFRSX0lTKHBwX2RwbV9tY2xrKSB8fCAgPg0KPiA+
IERFVklDRV9BVFRSX0lTKHBwX2RwbV9zb2NjbGspIHx8ICA+DQo+ID4gREVWSUNFX0FUVFJfSVMo
cHBfZHBtX2ZjbGspKSB7ICA+IEBAIC0yMDUwLDYgKzIwNDUsMjUgQEAgc3RhdGljIGludA0KPiA+
IHBwX2RwbV9jbGtfZGVmYXVsdF9hdHRyX3VwZGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwgc3RydWN0IGFtZA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICBkZXZfYXR0ci0+c3Rv
cmUgPSBOVUxMOyAgPiAgICAgICAgICAgICAgICB9DQo+ID4gPiAgICAgICAgICAgICAgICBicmVh
azsgID4gKyAgICAgY2FzZSBJUF9WRVJTSU9OKDksIDQsIDIpOg0KPiA+ICA+ICsgICAgICAgICAg
ICAgaWYgKERFVklDRV9BVFRSX0lTKHBwX2RwbV9tY2xrKSB8fCAgPiArDQo+ID4gREVWSUNFX0FU
VFJfSVMocHBfZHBtX3NvY2NsaykpIHsgID4gKyAgICAgICAgICAgICAgICAgICAgIC8qIEFsZGVi
YXJhbg0KPiA+IG1jbGsvc29jY2xrIERQTSBvbmx5IHN1cHBvcnRzIHZvbHRhZ2UgY29udHJvbCwg
ID4gKw0KPiA+ICogbm90IGFsbG93IHRvIHNldCBkcG0gbGV2ZWwgZGlyZWN0bHkgKi8gID4gKw0K
PiA+IGRldl9hdHRyLT5hdHRyLm1vZGUgJj0gflNfSVdVR087ICA+ICsNCj4gPiBkZXZfYXR0ci0+
c3RvcmUgPSBOVUxMOyAgPiArICAgICAgICAgICAgIH0gZWxzZSBpZg0KPiA+IChERVZJQ0VfQVRU
Ul9JUyhwcF9kcG1fcGNpZSkpIHsgID4gKyAgICAgICAgICAgICAgICAgICAgIGlmDQo+ID4gKGFt
ZGdwdV9pc19tdWx0aV9haWQoYWRldikpIHsgID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKnN0YXRlcw0KPiA+ID0gQVRUUl9TVEFURV9VTlNVUFBPUlRFRDsgID4gKyAgICAgICAgICAg
ICAgICAgICAgIH0gZWxzZSB7ICA+ICsNCj4gPiBkZXZfYXR0ci0+YXR0ci5tb2RlICY9IH5TX0lX
VUdPOyAgPiArDQo+ID4gZGV2X2F0dHItPnN0b3JlID0gTlVMTDsgID4gKyAgICAgICAgICAgICAg
ICAgICAgIH0gID4gKyAgICAgICAgICAgICB9DQo+ID4gZWxzZSBpZiAoREVWSUNFX0FUVFJfSVMo
cHBfZHBtX2ZjbGspKSB7ICA+ICsgICAgICAgICAgICAgICAgICAgICAvKg0KPiA+IEFsZGViYXJh
biBkb2VzIG5vdCBzdXBwb3J0IGZjbGsgZHBtICovICA+ICsNCj4gPiAqc3RhdGVzID0gQVRUUl9T
VEFURV9VTlNVUFBPUlRFRDsNCj4gPg0KPiA+IEkgc2VlIEZDTEsgcmVwb3J0aW5nIGlzIHN1cHBv
cnRlZCBpbiBhbGRlYmFyYW4gLQ0KPiA+IGFsZGViYXJhbl9nZXRfY3VycmVudF9jbGtfZnJlcV9i
eV90YWJsZS4NCj4gPg0KPiA+IFRoYXQgbWF5IGFsc28gYmUga2VwdCBhcyByZWFkLW9ubHkgdGhl
bi4NCj4gPiBba2V2aW5dDQo+ID4gTm8sIGl0IHNob3VsZCBiZSBkaXNhYmxlZCwgYmVjYXVzZSB0
aGUgZmNsayBpcyBhbHdheXMgcmV0dXJuIDAgYnkNCj4gPiBtZXRyaWNzIHRhYmxlIGlmIGZjbGsg
ZHBtIGZlYXR1cmUgaXMgZGlzYWJsZWQuDQo+ID4NCj4NCj4gSW4gdGhhdCBjYXNlLCBhbGRlYmFy
YW5fZW1pdF9jbGtfbGV2ZWxzIGV0Yy4gYmUgbW9kaWZpZWQgYXMgd2VsbCB0byByZWZsZWN0IHRo
aXMNCj4gc2luY2UgRkNMSyBEUE0gaXMgYWx3YXlzIGRpc2FibGVkPw0KDQpTaW5jZSB3ZSBhbHJl
YWR5IG1hcmsgRkNMSyBhcyB1bnN1cHBvcnRlZCBpbiBzeXNmcyBhdHRyaWJ1dGUsDQp0aGVyZSBp
cyBubyBuZWVkIHRvIG1vZGlmeSBhbGRlYmFyYW5fZW1pdF9jbGtfbGV2ZWxzIGFuZCByZWxhdGVk
IGZ1bmN0aW9ucy4NClRob3NlIHBhdGhzIHdvbid0IGJlIGludm9rZWQgYW55d2F5LCBhbmQgZXh0
cmEgY2hhbmdlcyBhcmUgdW5uZWNlc3NhcnkgZm9yIHRoaXMgZml4Lg0KDQpTbywgSSBwcmVmZXIg
a2VlcCBpdCwgYW5kIG9ubHkga2VlcCBjaGFuZ2VzIGluIGFtZGdwdV9wbS5jIHNvdXJjZSBmaWxl
IGZvciB0aGlzIGlzc3VlLg0KDQpCZXN0IFJlZ2FyZHMsDQpLZXZpbg0KPg0KPiBUaGFua3MsDQo+
IExpam8NCj4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4gS2V2aW4NCj4gPg0KPiA+IFRoYW5rcywNCj4g
PiBMaWpvPiArICAgICAgICAgfQ0KPiA+ICA+ICsgICAgICAgICAgICAgYnJlYWs7DQo+ID4gID4g
ICAgICAgIGRlZmF1bHQ6DQo+ID4gID4gICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gID4gICAg
ICAgIH0NCj4gPg0KDQo=
