Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D79C5AD55
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 01:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0A1610E250;
	Tue, 11 Aug 2026 01:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R1RweVcY";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C88D10E250
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 01:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYuBm+sgBp3vzu9+8g4wT4drVOZj0WaKaiz0Gm49UahNJy2tUTgBKk97V+is95eFppxTyBJ7Cz7V2jSVSww1wCNW5dEbaoIAfFUplaMt9+UbN0LyCq5Zq3MgVHZJw/+6a1RsHf38JntZuFEjemN1WJoXqCOAeOyk5G4wji+7PSf1bp/LbKFGoXBXvaXAiJOfSOMPfUw2u2eqoMoe3QMqA1guizZjp14QNAnjNcup3WdkSTtXJZxDiouxY6MEBVQhGupCXHnYlOiDzb1rskLXwDnCESMRO9aCWiwvAGpr3rlMaeegYCqEubIzETk9siHWRbGGprs+RkfivKZlwA6euQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnNXhivgJyIev3K8TjgOBlV6ggnhqK7SMkVMxmuAs0Q=;
 b=jRkytWK0o5eHLkJ0hzs1rXsLtykuj48D2qZD1Kg7MJ0SQdC6e1bhoNaekcEpI49+chPLT+D+E9ZLwHYM6RyO5+RWOOAtKCyzqGKBhvYgCroLvLMxN2eiDagKAeH7jGz3OPDqo/Vj+w6Uxz1gSkcBpCh4wX547JBjLYxryBzL/0TPNitOxlIheAiaHehPlaNJZArW0QC6a0t8fm2lzQ415BLAROUChK2xRfKwsbqkiOtHgcMh/91dMh40FoD5CVaH99GlJ6lsKRtbiO4jDAEl9qjwgmROX85L0FhUSEW3L02k82oHntVvVhH1xTWOPpSaeehkoMS24zoglhMt7tRqnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnNXhivgJyIev3K8TjgOBlV6ggnhqK7SMkVMxmuAs0Q=;
 b=R1RweVcY7E8NrvdoBfmk9ULnARGFRgE7FGNlFJi3aCNKvHZF0d26Sbo0hkgauaiaNPvE9rUYWIn8YisOh+H80Ij7Kj/RDw1jVt9zrT0sa1WMgkJM7xfUoe8tj/nfqV6tkcH8O/k9WhSHCfUnaruuQyTFm3EQ+0a33S1jvGJjPho=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 01:48:20 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 01:48:20 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: keep PRT mappings off the vm_bo state lists
Thread-Topic: [PATCH v3] drm/amdgpu: keep PRT mappings off the vm_bo state
 lists
Thread-Index: AQHdJMRaUr8oKNhiW0m7UbhJUw42bbaYHVug
Date: Tue, 11 Aug 2026 01:48:19 +0000
Message-ID: <DM4PR12MB51523C01D30B1ABB7E9B49F0E3DD2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260805102230.4060525-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260805102230.4060525-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-11T01:48:02.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CH0PR12MB8552:EE_
x-ms-office365-filtering-correlation-id: 6c10cea7-5596-4399-ffb1-08def74a9ee6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 4/gyzpn7bWMBB6un+HScnn0iZpN1BhTTJMmWY9DgVG6SjM7CvI9oJLD0xMDQv5aVfHMMzW6GwTVvQtp8KCHmX2T+JoX6ucxV/viwdJ8xourw+Y1oN1xZTA5FZW08PMVWHOXbkGBSyLN5MSlL8ILo/rFhUK819XvbNW9hM0yH+3O+mz/lz7nsulac2JNkk1V7ZyU6LYNhkKdry4nljKhunS3Br0xO1rWkRIaAEwAJ+iZAAbzKdTPB0wuXkNyUDsre+mLXCJsAMlLf5EiN5E2sUNYdKF1Q3ti1RUsm0+A2DeUlI3whEQ3UN7I7W0Kt3lnpp3t4nLTWaNAXPfDeYakcxGGCAs2XV1h482z5aSJxXR5DHXk4MKwaltWfc3UhpV52cljljlqN0FSRY/uAPj5Lum8tGE5M2vOUKadjZeZTQ+QFotYMZ8jLYRooQvoha43lHpAfEpJHWS6cdWUDPNm65TjWgezS3Vi/33Lvx7HfAhR8lp0Q1lHNFs+wNqZIZruuigW2Xz0MNwoFsneQqH/J8XCoXoTR0gX1UFWOX5vdGZ5Rn2LhmqQC9iSiMKrJO4zGiikr9XQMy0jixUa+5tqle73wElsuLft6XMrdZgs7PLoQwBnNEUg1jWKakmE8yQ/GbOjzUAdGdZH7YNHOmDOQer/DkYbrwn3NnwDDNzY0G2R3V7BJIftTJldRh5rANCx7IgaOPUhg/xBnpUfkwzkEGb4c5hQCEGlrYNdtqmavAjk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STFjZ0xwWjJGMlZXU2NQOG9XeDBOYXNPdm9nTUZteXJ0UnJ6QURuMnFtL0ho?=
 =?utf-8?B?OTVxY0Y3NDhHbTFZRVRWRzVGWWtiMndYbkM4Sk1JdUYyWDRVUk9VOTFMR1do?=
 =?utf-8?B?WkF3SitaeUN6MUxIcGZHU1JmMEFWekFZRDVxb0dzM1hzNmNYLzVBNGhUei81?=
 =?utf-8?B?bVNrZmY2Z1RVZStxOXNOWkkzUFlOMjdrcWZWak1HUUhHZTY4UlczN2s3TVhV?=
 =?utf-8?B?emwrSEs2ay95MU9UMkVDYjE0Nlg2R2ExaHQ5TVZpYTlEaitxR0dzQmswbkc2?=
 =?utf-8?B?WUJVU0tZdWRTMTBrWXpsUEpSNXVKY3NVNDMrejQzUXUxMDEyVnlSTlhCT1Qz?=
 =?utf-8?B?cEN5RFQyN3g3ejRMUEdqNXpBK1VZZDczUUZRZVVzcTNsbDZkMmVlUHVrUzlF?=
 =?utf-8?B?dmRlcUM1VGtNNzBoeDV2UVhYMEFlZ2tjR0lQRnMwb2pVSlV3YjhlQ3dack9B?=
 =?utf-8?B?YzYxeFNoTzFFL2xqeGYyZVNqcmZZaUF3ZzJ0a05qSUwrMTZMbDlWTUpIZm9h?=
 =?utf-8?B?L3hFSUpXMmVjNk5DaVZlbVpnWFlhb2YvL0IxOTJyUFJiRStneFZSOHNQdDZB?=
 =?utf-8?B?eDFRZWR2K0h3WTFoY3JaWldncUVYUHJzSmJQbGFVeGtSZ3hhM3ZaR2FySzJs?=
 =?utf-8?B?RkVvM1c5ek1LY3hGZ1JBdy9nZzVKL3lqRnhqbUhGQnRVTlFEQ3Erc0htK1dP?=
 =?utf-8?B?MHVXYXU4L1VqbjFjemJZLyt0azk1VnJ3U0kwL1ZJRDBXbGR1ckNwSWFnMlhF?=
 =?utf-8?B?N0dybG5hNDBhcDFvaWM1MDhVUHEwVW9VbWNGWDhzOXpWeFZJeDVrUUdPU05F?=
 =?utf-8?B?M1dlODArK1FNS1ZZK0p4V3pudkk0MEF6a2VodmUreXVBMlBPUW1nU0NLdGVT?=
 =?utf-8?B?WDhiSHUyMEZURXhXNXZyR1VGRnJydEdZa1ZGVGdVN2t1T2REU1RlVHNDOTdm?=
 =?utf-8?B?WG1YVStpdWN3N2FFWTNxVU50bUtWQjl2YUJrUDFHUXltamFrUWpjLzR6R2Vl?=
 =?utf-8?B?QUZiVFcvWkNSQ0xiU24xb3NSNWhnSUFDaWZHQ0JYTlVOTzFuejNHdU55cmRF?=
 =?utf-8?B?WmVQS01BZ1JBU2hJa1BybzVaK0pHM1oydkpiWWpraEpFbG5zbmVwdm1Cclp0?=
 =?utf-8?B?SGxBNzVhNFFzWFZwaTRFZVpncVU0Y25lT2ZhVGpRSjRiQzhlRFBxdzU5MnVx?=
 =?utf-8?B?Z2VkTTJQWFhUem85TzEyZkVKdk9YRitFbk1BV2ozak5CcDk1dDhpa1gwQmtM?=
 =?utf-8?B?dFpzdHJKME9wMHNHWGxyTUlCeTR4eTlvQXpQbUMxYUhKZ0FnelJCcE1XSjBh?=
 =?utf-8?B?aVg2akFTLzJLR1NibXFiS3ZJOE9sOVpXTjExOXlpSVF0SVRsdHd1MzZvbkZ3?=
 =?utf-8?B?SFZzUHNXZ29tNFRrNFpnWHliaTlzR1hBZmRwdDVtN1BLbUFTWGxSd0FkN0x0?=
 =?utf-8?B?L1ljUWVMSlpEK3dnQ2lCK2JZRk13R2FPMldjWlNXbGRHNkVXVlFZVnl4bytO?=
 =?utf-8?B?Z0lYNkNvblVYdjBqZWdOTDBleFliWjd2ZzlnWndMZkVCR3MvYUNxY2JEZXRW?=
 =?utf-8?B?L2NtTlVrVTQyaVdBb2xjbksrRFFxOTJBRmhJZVVmUjdRTTJnOGdPUVpXU0dj?=
 =?utf-8?B?US80endvOWsvbW4wdElodVFPVUtTeXFCTUpXUTNXdW9jNjI2emdCN3l0MlQx?=
 =?utf-8?B?THJ3NkVHcVY0MWMrU0tlWklxZHBWMFBkdnVSYm5mVGI4OVd2L2Rsb2d4MEVZ?=
 =?utf-8?B?VlBhelNHRTY2M3JNWEFrS3BMOVlTS1FZeVZGaWkzdTN0OW9HbU5XZE5KWlBx?=
 =?utf-8?B?eWdYbjhRYVNQV2V5VUZnS3VxR29vZGpqUFpzNGxxWEx2dVVjVWlXWlJ4S1JU?=
 =?utf-8?B?QTFsaDhSemlFaTU4MUxyVEZwMDZkOGRQWVlieXR5R3JIQW9UNHhjQ0VJMlE5?=
 =?utf-8?B?ZDk2K2ZOcEh5KytNR0Z5c0syeE1NZzNOc2xhSUV3Y3VuaTE1QWVNZHdwVU95?=
 =?utf-8?B?YWdsRUt5UnFRSnlrTWFEd0J2eGlZR1AvMkI1ZGJBekl0ODNROEVQUnZjc2ZJ?=
 =?utf-8?B?TEJ5Ny9jMnhOQXEzTmlRMG9xNXV5QTdUcGg0cVZaZElGdzVaY0pLOFZnZWhD?=
 =?utf-8?B?Wk0xK09UVXY0RWJ0V0RjczFyNzZTMEtrOW56MHJBZS80NFNzYnFNSWhzVjJX?=
 =?utf-8?B?OGxieHhIU2owMU1xcUNRSUEvSUpYcjFBMDVETUE5NmNaWG5tQlRQOWw5TFZy?=
 =?utf-8?B?MnBoM0hQa2VKTEVlSFhMeVdvUm1aQWJaSHkxNlg4SllxMHJnUUp6T3hnYkla?=
 =?utf-8?Q?5hzNsvJc9Kw0gDN8CG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c10cea7-5596-4399-ffb1-08def74a9ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 01:48:19.8624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: huRuloXNzERWYSq/85OHRlIMKK/N3iK1Th7Zgo7c9PxIplIexidmP+DAqNE6JYxCN1XCkKNbBMWps1HXwTVG3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552
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

QU1EIEdlbmVyYWwNCg0KUGluZyAuLi4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogSmVzc2UgWmhhbmcgPEplc3NlLlpoYW5nQGFtZC5jb20+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgQXVndXN0IDUsIDIwMjYgNjoyMiBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBaaGFu
ZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYz
XSBkcm0vYW1kZ3B1OiBrZWVwIFBSVCBtYXBwaW5ncyBvZmYgdGhlIHZtX2JvIHN0YXRlIGxpc3Rz
DQo+DQo+IEEgUFJUL3NwYXJzZSBtYXBwaW5nIGhhcyBubyBiYWNraW5nIEJPLCBzbyBpdHMgYm9f
dmEtPmJhc2UuYm8gaXMgTlVMTC4NCj4gYW1kZ3B1X3ZtX2JvX2Jhc2VfaW5pdCgpIGRlbGliZXJh
dGVseSBrZWVwcyBzdWNoIGEgYm9fdmEgb2ZmIHRoZSB2bV9ibyBzdGF0ZQ0KPiBsaXN0cywgYnV0
IHRoZSB0YWlsIG9mIGFtZGdwdV92bV9ib191cGRhdGUoKSB1bmNvbmRpdGlvbmFsbHkgY2FsbGVk
DQo+IGFtZGdwdV92bV9ib19pZGxlKCkgZm9yIHRoZSAhYWx3YXlzX3ZhbGlkIGNhc2UsIHB1dHRp
bmcgdGhlIE5VTEwtYm8gUFJUIGJvX3ZhDQo+IG9udG8gdGhlIGluZGl2aWR1YWwuaWRsZSBsaXN0
Lg0KPg0KPiBPbiBhIEdQVSByZXNldCBhbWRncHVfdm1fYm9fcmVzZXRfc3RhdGVfbWFjaGluZSgp
IG1vdmVzIGluZGl2aWR1YWwuaWRsZSB0bw0KPiBpbmRpdmlkdWFsLm5lZWRzX3VwZGF0ZSB3aXRo
IG1vdmVkPXRydWUsIGFuZCBhbWRncHVfdm1faGFuZGxlX21vdmVkKCkgdGhlbg0KPiBkZXJlZmVy
ZW5jZXMgYm9fdmEtPmJhc2UuYm8gdG8gcmVhZCBpdHMgcmVzZXJ2YXRpb24gb2JqZWN0LCBjcmFz
aGluZyBvbiB0aGUgTlVMTA0KPiBibyAoZS5nLiB0aGUgdXNlcnEgZXZpY3Rpb24gcmVzdG9yZSB3
b3JrZXIgcnVubmluZyBkdXJpbmcgYSByZXNldCB3aGlsZSBhIHVzZXIgcXVldWUNCj4gaXMgdG9y
biBkb3duKToNCj4NCj4gICBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFk
ZHJlc3M6IDAwMDAwMDAwMDAwMDAxNTgNCj4gICBSSVA6IDAwMTA6YW1kZ3B1X3ZtX2hhbmRsZV9t
b3ZlZCsweDE3YS8weDIwMCBbYW1kZ3B1XQ0KPiAgIENhbGwgVHJhY2U6DQo+ICAgIGFtZGdwdV91
c2VycV92bV92YWxpZGF0ZV9hbmRfcmVzdG9yZV9xdWV1ZSsweDJjZS8weDkyMCBbYW1kZ3B1XQ0K
PiAgICBhbWRncHVfdXNlcnFfcmVzdG9yZV93b3JrZXIrMHhjZS8weDIxMCBbYW1kZ3B1XQ0KPg0K
PiBTa2lwIGFtZGdwdV92bV9ib19pZGxlKCkgd2hlbiBibyBpcyBOVUxMIHNvIGEgUFJUIG1hcHBp
bmcgbmV2ZXIgbGFuZHMgb24gYQ0KPiBzdGF0ZSBsaXN0IGluIHRoZSBmaXJzdCBwbGFjZSwgYW5k
IHJlZnJlc2ggdGhlIFBSVCBwYWdlIHRhYmxlcyBleHBsaWNpdGx5IGluIHRoZSB1c2VycQ0KPiBy
ZXN0b3JlIHBhdGggKGFzIHRoZSBDUyBwYXRoIGFscmVhZHkgZG9lcykgc28gc3BhcnNlIG1hcHBp
bmdzIHN1cnZpdmUgYSBWUkFNLQ0KPiBsb3N0IHJlc2V0LiBCZWNhdXNlIHRoZSBQUlQgYm9fdmEg
aXMgb2ZmIHRoZSBzdGF0ZSBsaXN0cywgaXRzIFBURSB1cGRhdGUgZmVuY2UgbGFuZHMNCj4gaW4g
cHJ0X3ZhLT5sYXN0X3B0X3VwZGF0ZSByYXRoZXIgdGhhbiB2bS0+bGFzdF91cGRhdGUsIHNvIHdh
aXQgb24gaXQgZXhwbGljaXRseSBiZWZvcmUNCj4gcmVzdGFydGluZyB0aGUgcXVldWVzIChtaXJy
b3JpbmcgaG93IHRoZSBDUyBwYXRoIHN5bmNzIHRoYXQgZmVuY2UpLg0KPg0KPiB2MjoNCj4gIC0g
a2VlcCB0aGUgUFJUIGJvX3ZhIG9mZiB0aGUgdm1fYm8gc3RhdGUgbGlzdHMgaW5zdGVhZCBvZiBO
VUxMLWd1YXJkaW5nDQo+ICAgIGJvIGluc2lkZSBhbWRncHVfdm1faGFuZGxlX21vdmVkKCk7IGEg
UFJUIG1hcHBpbmcgc2hvdWxkIG5ldmVyIGJlIG9uDQo+ICAgIHRoZSBtb3ZlZCBsaXN0IGluIHRo
ZSBmaXJzdCBwbGFjZSAoQ2hyaXN0aWFuKQ0KPg0KPiB2MzoNCj4gIC0gdGhlIFBSVCBQVEVzIGFy
ZSB1cGRhdGVkIHNlcGFyYXRlbHksIHNvIHRoZWlyIGZlbmNlIGlzIGluDQo+ICAgIHBydF92YS0+
bGFzdF9wdF91cGRhdGUsIG5vdCB2bS0+bGFzdF91cGRhdGU7IHdhaXQgb24gaXQgaW4gdGhlIHVz
ZXJxDQo+ICAgIHJlc3RvcmUgcGF0aCBiZWZvcmUgcmVzdGFydGluZyBxdWV1ZXMsIG90aGVyd2lz
ZSB0aGUgcXVldWVzIGNvdWxkDQo+ICAgIHJlc3RhcnQgYmVmb3JlIHRoZSBzcGFyc2UgUFRFcyBh
cmUgd3JpdHRlbiAoQ2hyaXN0aWFuKQ0KPg0KPiBTdWdnZXN0ZWQtYnk6IENocmlzdGlhbiBLw7Zu
aWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSmVzc2UgWmhh
bmcgPEplc3NlLlpoYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3VzZXJxLmMgfCAxNiArKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyAgICB8ICA4ICsrKysrKystDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gaW5kZXggNmQzZWQ1NWU5YWI0
Li5iY2ZiZDcyMTNkZDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV91c2VycS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV91c2VycS5jDQo+IEBAIC0xMDcwLDYgKzEwNzAsMTYgQEANCj4gYW1kZ3B1X3VzZXJxX3ZtX3Zh
bGlkYXRlX2FuZF9yZXN0b3JlX3F1ZXVlKHN0cnVjdCBhbWRncHVfdXNlcnFfbWdyDQo+ICp1cV9t
Z3IpDQo+ICAgICAgIGlmIChyZXQpDQo+ICAgICAgICAgICAgICAgZ290byB1bmxvY2tfYWxsOw0K
Pg0KPiArICAgICAvKg0KPiArICAgICAgKiBQUlQvc3BhcnNlIG1hcHBpbmdzIGFyZSBrZXB0IG9m
ZiB0aGUgdm1fYm8gc3RhdGUgbGlzdHMsIHNvDQo+ICsgICAgICAqIGFtZGdwdV92bV9oYW5kbGVf
bW92ZWQoKSBkb2VzIG5vdCB0b3VjaCB0aGVtLiBSZWZyZXNoIHRoZWlyIFBURXMNCj4gKyAgICAg
ICogZXhwbGljaXRseSBoZXJlIChhcyB0aGUgQ1MgcGF0aCBkb2VzKSBzbyBzcGFyc2UgbWFwcGlu
Z3Mgc3Vydml2ZSBhDQo+ICsgICAgICAqIFZSQU0tbG9zdCByZXNldC4NCj4gKyAgICAgICovDQo+
ICsgICAgIHJldCA9IGFtZGdwdV92bV9ib191cGRhdGUoYWRldiwgZnByaXYtPnBydF92YSwgZmFs
c2UpOw0KPiArICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgIGdvdG8gdW5sb2NrX2FsbDsN
Cj4gKw0KPiAgICAgICBrZXkgPSAwOw0KPiAgICAgICAvKiBWYWxpZGF0ZSBVc2VyIFB0ciBCT3Mg
Ki8NCj4gICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShib192YSwgJnZtLT5hbHdheXNfdmFsaWQu
aWRsZSwgYmFzZS52bV9zdGF0dXMpIHsgQEANCj4gLTExMjcsNiArMTEzNywxMiBAQCBhbWRncHVf
dXNlcnFfdm1fdmFsaWRhdGVfYW5kX3Jlc3RvcmVfcXVldWUoc3RydWN0DQo+IGFtZGdwdV91c2Vy
cV9tZ3IgKnVxX21ncikNCj4gICAgICAgICovDQo+ICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnko
Ym9fdmEsICZ2bS0+YWx3YXlzX3ZhbGlkLmlkbGUsIGJhc2Uudm1fc3RhdHVzKQ0KPiAgICAgICAg
ICAgICAgIGRtYV9mZW5jZV93YWl0KGJvX3ZhLT5sYXN0X3B0X3VwZGF0ZSwgZmFsc2UpOw0KPiAr
ICAgICAvKg0KPiArICAgICAgKiBUaGUgUFJUIGJvX3ZhIGlzIGtlcHQgb2ZmIHRoZSBzdGF0ZSBs
aXN0cywgc28gaXRzIFBURSB1cGRhdGUgZmVuY2UNCj4gKyAgICAgICogbGFuZHMgaW4gcHJ0X3Zh
LT5sYXN0X3B0X3VwZGF0ZSByYXRoZXIgdGhhbiB2bS0+bGFzdF91cGRhdGU7IHdhaXQgb24NCj4g
KyAgICAgICogaXQgZXhwbGljaXRseSAoYXMgdGhlIENTIHBhdGggc3luY3MgaXQpIGJlZm9yZSBy
ZXN0YXJ0aW5nIHF1ZXVlcy4NCj4gKyAgICAgICovDQo+ICsgICAgIGRtYV9mZW5jZV93YWl0KGZw
cml2LT5wcnRfdmEtPmxhc3RfcHRfdXBkYXRlLCBmYWxzZSk7DQo+ICAgICAgIGRtYV9mZW5jZV93
YWl0KHZtLT5sYXN0X3VwZGF0ZSwgZmFsc2UpOw0KPg0KPiAgICAgICB4YV9mb3JfZWFjaCgmdXFf
bWdyLT51c2VycV94YSwgdG1wX2tleSwgcXVldWUpIHsgZGlmZiAtLWdpdA0KPiBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMNCj4gaW5kZXggNGM5MGU4OGUyZTMwLi4wMmUyZTU3NmYxNTQgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+IEBAIC0xMzkxLDcg
KzEzOTEsMTMgQEAgaW50IGFtZGdwdV92bV9ib191cGRhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UN
Cj4gKmFkZXYsIHN0cnVjdCBhbWRncHVfYm9fdmEgKmJvX3ZhLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgYW1kZ3B1X3ZtX2JvX2V2aWN0ZWQoJmJvX3ZhLT5iYXNlKTsNCj4gICAgICAgICAgICAg
ICBlbHNlDQo+ICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfdm1fYm9faWRsZSgmYm9fdmEt
PmJhc2UpOw0KPiAtICAgICB9IGVsc2Ugew0KPiArICAgICB9IGVsc2UgaWYgKGJvKSB7DQo+ICsg
ICAgICAgICAgICAgLyoNCj4gKyAgICAgICAgICAgICAgKiBBIFBSVC9zcGFyc2UgbWFwcGluZyBo
YXMgbm8gQk8gYW5kIGlzIGtlcHQgb2ZmIHRoZSB2bV9ibw0KPiArICAgICAgICAgICAgICAqIHN0
YXRlIGxpc3RzIChzZWUgYW1kZ3B1X3ZtX2JvX2Jhc2VfaW5pdCgpKTsgcHV0dGluZyBpdCBvbiB0
aGUNCj4gKyAgICAgICAgICAgICAgKiBpZGxlIGxpc3QgaGVyZSB3b3VsZCBsZXQgYW1kZ3B1X3Zt
X2hhbmRsZV9tb3ZlZCgpIGRlcmVmZXJlbmNlDQo+ICsgICAgICAgICAgICAgICogdGhlIE5VTEwg
Ym8gYWZ0ZXIgYSByZXNldC4NCj4gKyAgICAgICAgICAgICAgKi8NCj4gICAgICAgICAgICAgICBh
bWRncHVfdm1fYm9faWRsZSgmYm9fdmEtPmJhc2UpOw0KPiAgICAgICB9DQo+DQo+IC0tDQo+IDIu
NDkuMA0KDQo=
