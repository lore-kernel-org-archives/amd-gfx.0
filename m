Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C6ACD98CE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 05:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1244610F245;
	Fri, 12 Jun 2026 05:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LTL3asbm";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C9C810F245
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 05:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koyG4yj7atAeozhiy1zErXIYiPYRgalJX0bCO7Ra54VmPT3X98/6RhbR8PYT2k0A9qMUDuNvCEXdaWs3RlkagCOZWootp9/ZXB1/SDKV0UBC8dhifANStoddUVBUmb85DaDqgpk/10DfURFtQNDlHpsfBuM0uEcbLSQuINBgQknvR5dbMZznW5VHWjGTqVJ8yeOKGOd775vBXqo1nPgWEBEQsDqFDRuTA+f+PhWHiElI7ZrRdbk6e9UcObY69HpKVp45g8X3yP8nfJ7u5qN6W0EdlChwlpsDs+xUK6bwbiI0Db7CWJzaovMdQ+R8yO7i2OLJdel8abAB+spDEovRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZ+wCMa+PIbl84yzvS//ixJc1HKUjsQnojDgYZgLD7I=;
 b=Kqvdp75RSAhyuMJeYLavmDHZ1/jA0ppi3cVI0ufHGeZ0u9hlBjHMGTn/Ri5XOC3ECSuK3jMeDiXqv8L1hGZQEoeH+v5aao61MIeXHmTeItHMEPHS2YLRoIHYo2cRL0aW3Hm95yzTZDBgOmJdRhI9rRiB+3LgbxR+reNJ8LFg5fRdZR6gd5dhAyaIHAtvEDB5i4yJ0m7MNC7UDZzu++2HXxBvqz/li5a743iZxdixx+6j3XN52FYOzQKzU8osYbC/DC4upLDEkxJ96GxeEcYJvp1DEfx1j8QYIQOBu9cP6R+6TRZudEKQlKgBICPE7g2j8wQevMoeTAS6iYFAIY/p8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZ+wCMa+PIbl84yzvS//ixJc1HKUjsQnojDgYZgLD7I=;
 b=LTL3asbmMdkquZ9PWqQ94S0eyjxHrH7nDIfD9oG0m/mVthsRwbwZVxeWKHPivNk6LwfhbSvlqRU5x7l81cdq81pOV+odjV1qfWeNWLLO5vrGeO6miN8Ct1t1ltMRB32iaF3ZsEfNHDKWyhzoTilwL9xlxt2DClgcANGkZXoe3SY=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.18; Fri, 12 Jun 2026 05:54:23 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 05:54:23 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pelloux-Prayer,
 Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH v2 1/3] drm/amdgpu: set the userq xcp_id
Thread-Topic: [PATCH v2 1/3] drm/amdgpu: set the userq xcp_id
Thread-Index: AQHc+Xz4iXjh7Jr96Uq7OPpTSwEu0rY5FUSAgAEW7jA=
Date: Fri, 12 Jun 2026 05:54:23 +0000
Message-ID: <DS7PR12MB600538A6167F6ED15084FBDBFB182@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260611083311.191012-1-Prike.Liang@amd.com>
 <08c056a2-c425-45c8-8442-978ce0f9357f@amd.com>
In-Reply-To: <08c056a2-c425-45c8-8442-978ce0f9357f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-12T02:03:03.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|MN0PR12MB5788:EE_
x-ms-office365-filtering-correlation-id: 95bc4c01-f9f8-49b5-6822-08dec8470e18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|22082099003|18002099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: xJZxslq8Xb/nPHdw0wuPrANBs0Jpj+2X2z3iVryU4/Rlk2YN2o7cZNJD0PQWWkTyTYGVgKfv7GgVaZ6pfbggqjQINI72LYZwcjLWaLinmCnVJbk+dv22yS5cnIMP+NKQBGvp2P8AHlcifg0TotN5uDt5qHGMYXompMrdlHt4RBMG80KpGjkZY5Kxjw9VrYyiaO1ZRyhw5e+jOGGiMNiBf27RcuBheZMwstXGFJg/zLDiyN/zVlLx5I5YEaZO3M4Wen8wJ9G5cBw2T9EBUxOX5nRUwyRI7q3mceL/uHDleJzovp8B1Qu+yOaMOB/E4kEMsCwzLjlQ4EKieip61ZAi0bejCn4GvPQFj6sLgMIqt9KvN9QP0kETHLzvBzrY0G4TCf6SMK5W/9WlZVE2AcmHcxJhZOIZyW7ncUaHXVNq7TYgXrTxnfFlZPOthEplWSOF7JaMGOSe/BAu9bmgNA+voYOHlW7fPGxEFeQf4XJz4V1cNVci/+KXlyAvJMvhR8+I4xWFlMPTVY/biJfUSfasp12WmZZha9MIIoXcEMQlrLub5SEHSQa9xVFqDDLaQtin7kZev3vjwk1JFJ6lCbhuoL7zO6zG2mNjL1kPA+NhzwXpxpJy5Q2M8IIYOxekAxNuCP8NdxwVFAxbzuK1VNCod9qwg2z7mqq74RqqHkdxmdPPf4k2BcEq1rGlFdjUzy/ICTFwSaFuMxP1Iq1E2PtM13hpH08MOeLqZ3Tl1awY4ARgUOAsPBgb21ryGwi5ih/i
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHQxKzZ1SzFPM2R1NE5KK2JhZU00WE44amF4b1FtNnF5TjBubVV5RXV0S1ZI?=
 =?utf-8?B?cVJRK3U1VjRnYzZFSkNPTzJNM0JDa2JLeTNSM3Q1dXhDUnZSRjB3ZkxoL3BR?=
 =?utf-8?B?QzhCRnZuU1VsOEpWUGdib0VZVG9LNkl3bko2aEwyVzFDUUdSZ3l3QWZBODBm?=
 =?utf-8?B?TFZFZXVBVzg1M3VkRVR6anU5cXJkTzh4MDdLMW5vNUFrcnlVTnNyTGxpZDFP?=
 =?utf-8?B?V0hkR2xycFowMU1HM1NVaUo1TnM5bWxSRTJpeGhqK0tMbktXTGNwTUJwUlZ2?=
 =?utf-8?B?dXlWTSt3T0NSQ3pGVTVmaEx5TW5va0lFQi9XQkl6UXJkOFFsMlRQd3dJR3pE?=
 =?utf-8?B?UFNBS1Zsc1lFa2l1Snd1cEtQWmNxR3I3dm94Ukh1WWVtbnJTdTBPeThjSjdR?=
 =?utf-8?B?dmFraVZmcVJQZnZDbkxvUHhxUGY4U28zaGg1VkhsbE5kVnc0U2NrODd5S3VV?=
 =?utf-8?B?NitNUDI5VUl6QjZWS25ob3VieitwU3I0MUtzaEVVNDlhb01VenFtVWgvdmJY?=
 =?utf-8?B?TlFFaTR6cjVxQWR0YkwxSXlvcmNEdjVOMGdKQnNrSkl6eFZ4VDZrQk5OcW9q?=
 =?utf-8?B?YmFPMFBqYUpvMEVCZVpxWklwVWN6TGZxMVFxM3BVSmh1YkVRQ0M0Zloxd0FX?=
 =?utf-8?B?cmx3cWFjY3dSYmw4NDloWEFiSGhLRXdiSUdXamFENFpiU3YyWGNlak5HZ1Q1?=
 =?utf-8?B?dU5DbEE4aUNkUjdHU094bnZXazZjTEM1dnZCRHMxclJBbnlScUE1a1k2ejVo?=
 =?utf-8?B?RVBudlo3Q0w1S2REeXE2Qzl4S2wza09IbXdJUnl4VmE0dThjSEIyVU1LVVpq?=
 =?utf-8?B?bTRuM2locU9CVzArYzdYdXVXSkEyd25ZR1lCRVBCL0NVclA0TXdkeWVNV3NF?=
 =?utf-8?B?bGkrb1crTjIySmN4RXBnNEdGTSs1clM0bnFiVXRPNXhTWHZvSDFLNEdFNkMr?=
 =?utf-8?B?RjVoQXdyaGl4NDhUMTZaQlBIeHVqMmxseThTNnMrU2xkbUs2dThtR3hkcHFn?=
 =?utf-8?B?eG9HeXpNcjJrZTAwLzBYNkxSc2JETlVxOWZqTW9tMVN4OEtCeUxwcmNaSEZu?=
 =?utf-8?B?Q3RLbExjcjFhSHZEZy83bUdsSUJhcjF0RXFYcFEzT3J1czZjUy8yaTZmNnJJ?=
 =?utf-8?B?QlJIbG9xNWJiMmNLNGdWQkFKTjBrbEFSbFZ0blZSZGIveGxnNTNaS3ZzZEFn?=
 =?utf-8?B?blM4Q0NXTE1LWGlDWnhaQWF1VHBxeHR2UFNCckMwQzlVWlRESjB3a202d3Bu?=
 =?utf-8?B?VVpOUFVlWDVMdGoybUwrVGppcnEyYmM3dWpLUHBkRVM3T1hCaVdIbDJtQVcy?=
 =?utf-8?B?eUdvdlZmcGxzOGJyZGF6VHNOSXA0bldla0IvMHI1MWtpRGxxbWdlYTZYbC93?=
 =?utf-8?B?aENGV2tnTXFRNFluLytWdVhEODd1T0R0SURvK0NUZVUwZzdNczJrSEdlVCtX?=
 =?utf-8?B?c2htY0pKc0ZKR3puV045ZEVtRk5oQnB2OGdwTWVVbEtGcFVMbS8vbVRvZERY?=
 =?utf-8?B?S0YzZWt4TlpldnVRaEJ6dzhOUG50M3l3STluY0VzZ2FwYTNpVG5aRm1lc2ZB?=
 =?utf-8?B?YnMvSE85dVdvdGZ1SDdEa2s0WmNmVHNtYkYwd3BFMjFqU1pWNGxJb3NVem1p?=
 =?utf-8?B?cTFMZ0trMjhxNnJPaHJjZjFrYmdWRWlib2dweFEwd04vWHhLWFQrOFowQnNW?=
 =?utf-8?B?S2QzdlVNbkxpTTlTYnk2bHllUXFZRTJxdDJxOTVPYW9ZNnlSbVo0Qnl1OXp6?=
 =?utf-8?B?a2pYY2NDV3c2RXZzSk1kSkY4TmJRbmd1OHJzUUU0aUZBbUc1K1RLMlhldlFC?=
 =?utf-8?B?M2EvUmgrVU9Vb1NrRE5xTjY3UXNqQ3NaWWhPZEVtd2JLaGpCNHROeWlKbjho?=
 =?utf-8?B?dGw4ZjVodDlUc21TMy95WGNZc3FRNTcyUkVGZkhGSWVDbzdkKzE1cGd1M2Yw?=
 =?utf-8?B?UGdhWlBsUGRDUVVkM3NoRnhRbldEWWhuUFdHVGFmYSsxWHRBVE9PYlFkZUJs?=
 =?utf-8?B?L00xMWw1bzVBZS83ZnQxMEdxS0NJemp0SHNYYStPclJjaXd0VDcxNDhNbnpq?=
 =?utf-8?B?M0xPN05BQ2Y2SmpmOFVjL3VkNENyMFJPdGtPdXBoQzBTUjNPaEtOR21nMk5G?=
 =?utf-8?B?am9ZTFl0S0lobVU0RzZpNnZUSmtWM1FGN0tMOVRoU082K1dBMzQ1eDFxdUNq?=
 =?utf-8?B?QWVFeU9DZHoyRkFGUDdIZVhqMzVXa3RsOXNOUG1WT1Nvc2FZT3IyVlRFVWc3?=
 =?utf-8?B?M0QzWWthcXVyQVVMQXU0S2tUK3pTRGllTEl3TGErUDNJVTkxeUV2d0lEU3Rz?=
 =?utf-8?Q?CNMARKNHkogCRK/lsE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bc4c01-f9f8-49b5-6822-08dec8470e18
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 05:54:23.7747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLGrmFbk1gkyfkQzP6BcTt2jebWMno+G9ZRLu++vFtC4DLuJOvlwF2T5HPXlnJSj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788
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

UHVibGljDQoNClJlZ2FyZHMsDQogICAgICBQcmlrZQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5j
b20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDExLCAyMDI2IDU6MjUgUE0NCj4gVG86IExpYW5n
LCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+
OyBQZWxsb3V4LVByYXllciwgUGllcnJlLQ0KPiBFcmljIDxQaWVycmUtZXJpYy5QZWxsb3V4LXBy
YXllckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvM10gZHJtL2FtZGdwdTog
c2V0IHRoZSB1c2VycSB4Y3BfaWQNCj4NCj4NCj4NCj4gT24gNi8xMS8yNiAxMDozMywgUHJpa2Ug
TGlhbmcgd3JvdGU6DQo+ID4gSW5pdGlhbGl6ZSB0aGUgdXNlcnEgeGNwX2lkLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jIHwgMTIgKysr
KysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMN
Cj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gaW5k
ZXggM2Q2YjFjZmVjYTI0Li5jMTE3NWNiNmQyNDIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IEBAIC01ODUsNiArNTg1LDE3IEBAIHN0
YXRpYyBpbnQgYW1kZ3B1X3VzZXJxX3ByaW9yaXR5X3Blcm1pdChzdHJ1Y3QgZHJtX2ZpbGUNCj4g
KmZpbHAsDQo+ID4gICAgIHJldHVybiAtRUFDQ0VTOw0KPiA+ICB9DQo+ID4NCj4gPiArDQo+ID4g
K3N0YXRpYyB1MzIgYW1kZ3B1X3VzZXJxX2dldF94Y3BfaWQoc3RydWN0IGFtZGdwdV9mcHJpdiAq
ZnByaXYpDQo+DQo+IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCBhIHNlcGFyYXRlIGZ1bmN0aW9uIGZv
ciB0aGlzLCBqdXN0IGlubGluZSBpdCBiZWxvdy4NCg0KWWVhaCwgd2lsbCBkbyBpbiB0aGUgZm9s
bG93aW5nIHZlcnNpb24uIFNpbmNlIHNpbWlsYXIgWENQIElEIHJldHJpZXZhbCBpcyBhbHNvIG5l
ZWRlZCBpbiBvdGhlciBwbGFjZXMsIHdlIG1heSBuZWVkIHRvIGV4dHJhY3QgdGhpcyBhcyBhIGhl
bHBlciBmdW5jdGlvbiBpbiBhbWRncHVfeGNwLmMNCg0KPg0KPiA+ICt7DQo+ID4gKyAgIC8qDQo+
ID4gKyAgICAqIFRoZSBlbmZvcmNlLWlzb2xhdGlvbiB1c2VycSBwYXRoIHVzZXMgaWR4IDAgZm9y
IG5vbi1wYXJ0aXRpb25lZA0KPiA+ICsgICAgKiBkZXZpY2VzLCBtYXRjaGluZyB0aGUgZ2Z4IHJp
bmcgaXNvbGF0aW9uIGhhbmRsaW5nLg0KPiA+ICsgICAgKi8NCj4gPiArICAgcmV0dXJuIGZwcml2
LT54Y3BfaWQgPT0gQU1ER1BVX1hDUF9OT19QQVJUSVRJT04gPyAwIDoNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmcHJpdi0+eGNwX2lkOw0K
Pg0KPiBUaGF0IGNhbiBiZSBzaG9ydGVuZWQgaW50byBmcHJpdi0+eGNwX2lkICE9IEFNREdQVV9Y
Q1BfTk9fUEFSVElUSU9OID86IDA7DQo+DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQN
Cj4gPiAgYW1kZ3B1X3VzZXJxX2NyZWF0ZShzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHAsIHVuaW9uIGRy
bV9hbWRncHVfdXNlcnENCj4gPiAqYXJncykgIHsgQEAgLTYyOSw2ICs2NDAsNyBAQCBhbWRncHVf
dXNlcnFfY3JlYXRlKHN0cnVjdCBkcm1fZmlsZQ0KPiA+ICpmaWxwLCB1bmlvbiBkcm1fYW1kZ3B1
X3VzZXJxICphcmdzKQ0KPiA+ICAgICBxdWV1ZS0+cXVldWVfdHlwZSA9IGFyZ3MtPmluLmlwX3R5
cGU7DQo+ID4gICAgIHF1ZXVlLT52bSA9ICZmcHJpdi0+dm07DQo+ID4gICAgIHF1ZXVlLT5wcmlv
cml0eSA9IHByaW9yaXR5Ow0KPiA+ICsgICBxdWV1ZS0+eGNwX2lkID0gYW1kZ3B1X3VzZXJxX2dl
dF94Y3BfaWQoZnByaXYpOw0KPiA+ICAgICBxdWV1ZS0+dXNlcnFfbWdyID0gdXFfbWdyOw0KPiA+
ICAgICBJTklUX0RFTEFZRURfV09SSygmcXVldWUtPmhhbmdfZGV0ZWN0X3dvcmssDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgIGFtZGdwdV91c2VycV9oYW5nX2RldGVjdF93b3JrKTsNCg0K
