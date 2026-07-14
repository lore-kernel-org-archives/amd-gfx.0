Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F24C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 13:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41A1410ED5D;
	Tue, 14 Jul 2026 13:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wfFkFEma";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011060.outbound.protection.outlook.com
 [40.93.194.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D1010E067
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 13:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pP+K3cLm5lfrtHYczRRpu8ceZophdWzI7IOnCmWxlo0OTYQUSpc+6hcdILPdzM3eEz7dHhZZZdJKfGe0PbnsNPF2/hVo2ZtEWCc4b/eAG7RYWEUpXZtjzCtHFc6mFpyaLJlr2u/xdngID7Ap1vX9MJ6mDE7XZ0XVU3dWfNAOhUf3+tTUGeou4wDsjptYwQ6oW4Gu2zRf+8XPBCqPkjFGX3wLketKnkfwhfoCAJ8MOu4ZMKB2zsTv0aDDNa2BPFGpX/tDqI1Sz4IfTYdEFXiYqtUc2mXUndMCJYt/2STOCvotTobIrT8iC51xlUqnBLZbZuUxs45WUcy0zfYZ0bmGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSy8yk6QiDIKNuc4HpKGOi94X91djBmVDeMs7JkCbv8=;
 b=gpFMlG9uM6znm7wCoeDqvuuYBqN60N0FqI//IwR59N5oL8j18ZhVEetL0rVuBcp4XsSUcuVC7/fQAssfU6s9fuEL/yAsu1F18V0JvxRSutlknhEg8NbWN0mbY9cX3M9x64v2afFk9zQTac8bgOPo5BI0XLyktlDuVU7z6D5SoE699aWOFWg0FoLR7vEf7zmdrXD2oFujzVJqYWMlnHBSb7ZWvvYsNeP7zPFVSRc92zvOsjcVoKt9ho9cgTU00DYsLcuatr4d4Qi8nDTM5zXF9+Hghkl/LijyKeaAWC+v3bPd8MywkyqcEQ+9aQQ9ty4Dwek2C/Wl/WhdbLyM4kq59Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSy8yk6QiDIKNuc4HpKGOi94X91djBmVDeMs7JkCbv8=;
 b=wfFkFEmaU6Gi+0ZP6ZHwi7jEdYjbGZbMB95/cegoSI3CyIglRlY80pEOkfhP5fDzf1n7i2hYNbw/Kz+95VtiOBlwh0dmIy7zY6Hy0s3Dj0L8fgPo8Qvr13kRM8v01W2cI0ZnI2Y7Q1b3X0awIOtHDAEtgbXT80sgKsQ1FC8Gr2Q=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 13:44:40 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 13:44:40 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v9 4/5] drm/amdgpu: Record USERQ_EOP WAIT_EVENT
 notifications
Thread-Topic: [PATCH v9 4/5] drm/amdgpu: Record USERQ_EOP WAIT_EVENT
 notifications
Thread-Index: AQHdE2hFWBQSylRjdUOc3sGQeynPV7Zs+3YAgAAK2uA=
Date: Tue, 14 Jul 2026 13:44:40 +0000
Message-ID: <IA0PR12MB82083D69FCA2B03907A4E10B90F92@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260714081023.3395485-1-srinivasan.shanmugam@amd.com>
 <20260714081023.3395485-5-srinivasan.shanmugam@amd.com>
 <56ed16c5-4b30-48b8-9140-375bf8015a99@amd.com>
In-Reply-To: <56ed16c5-4b30-48b8-9140-375bf8015a99@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-14T13:42:08.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|MN0PR12MB5953:EE_
x-ms-office365-filtering-correlation-id: 712b1167-f33f-4137-f03c-08dee1ae0de1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|6133799003|18002099003|22082099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: 5R54/Z3BzVJzFgXL8uqE/mPMxxHQC5IhCNiOhI4V0WdPEzBF+waKn+oVWR6xe7NZgY9YBO2OMbw5XE3qQGbsDtMRyFJjOVfRykVn7ZzGxKPcUUgpjK9dmqb1yH0dzu+Pg6Nqqq5UmktOXX6EMjDj/2dX4rXzd0E8+CWmndteyNhUNsNl3d/FNkjxbacBvhlXVZnQR0puiANNGAX6W7pE2vOPLeRNtahWYzTdRL5xaSYigPXnMtwxjBBowIYJBmz28LmtxjU3Eb064MKd9mRxwksEGqxXXFqwgzyZnH2qhuO8+ODZHYQJU+vpa+cHxDcvgS2aw+FQSzcVPeZoe0bLy2OV6me1R+h494zHT7UEl7uSjvuX8CSRwh3E5quaxirT0PwqTcEx9sIuIslvTtazfoLOXwixFmxCdEyJ1M/W++KMwGiM5UAfKE++Xnlfds3XwOCNRbfx3Csyikv+LyHiw7AYIjwYaEwc6n91tPAMJHg8Y/KhVwlDrhsPz6qbpL/UeT0u78ey6JRKEvuMaAzaZPO7p19pOfRyW/UmrW6sYzcFQElh2f3meOsZHBFSF9f/x12QxDDY0vMFUizVrRxfXib/W6WTifolGIm8qpPae4j1HQlI/xdw8XdRyoKEY1LAE272wHDAdebaTzRK7HV7tlWlrcDCUkJTC4TBY1SbV0Wf8Zgk9UXgi9/PPPZ3RNidnBH5qiOzI2ICgNCd0xuQFFAkV5rzsGWaz9OBc0DSn2U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1ZrbmpGdkhhYkNleUZ1c2czVWh4T1ZPRmFPTHBTdjhKRWNWNWsySHN3UkJR?=
 =?utf-8?B?aTZGemVWdy9manR4OXpJRFBXQzUxd1I1cDhxNWFJVE9yS2VFazV5Vk9aUWpq?=
 =?utf-8?B?ZVpOQUpqb0JJdmpSWURGN1g4Y3FNajJJL2hHVEwyNjNCaEFGSStTL3dUcGpD?=
 =?utf-8?B?aGJkZFcvd0pwVjRWMUtQbDgrZURXNVg5MHNLcFROZDRNVkEySzY4ekdyU1Nh?=
 =?utf-8?B?R0prcEh4cVBDQlRMUysvcmVJYlYzUGhtektBclFCMlA3MlhUa3FxRUtEVlg5?=
 =?utf-8?B?Unc5emozQktUaFZ2SUJUbXEwVkRNUWdqcXV1TUQ0ZUFyY2tVS3FBZlVhY3ln?=
 =?utf-8?B?RFcxZDk4V2Y2YjFmRG1WQjREeGlBT1dNcEc1WnMrY1h6bXZjczVqelc2UjU1?=
 =?utf-8?B?UHpvNXhndGNpV01yWUc0MFdsZ1dzUU5IV3hWT21lWG8xbkN5YVBtT1dtTHBR?=
 =?utf-8?B?dXl2RTRVSUJnKzIzdnVYc2NETDNHTk1Ib0k2cUxRTWI5L0pZdXRwWGhXUUlw?=
 =?utf-8?B?ZDFTZXhOV3JVc0lqN3VDUWRxcWZGcTdEZ29sdWI1RzBXam5YVjZseGZ6bWxD?=
 =?utf-8?B?VUc1YktwaitSTUc4VlVuS0p4UStRR05pemVoeFlLV1RJNnFyR2lyc2lCQlg0?=
 =?utf-8?B?aS9xRGVRaFF1UHFzZ3daMXVTOUpnbEhJY0NtbC80ZktFU1c5U3k5QkM4WEtT?=
 =?utf-8?B?eFlUc3Y2NG90UGkwYW45RGFoQ2lOQWUybzk2MnlOZzVWaC9Uc2J0ZEJIZkpi?=
 =?utf-8?B?VEdOQXpadjgva0YrV21WaWdhdVlqVG9oc3lKV0lkTnduS3c3bTlyMlY2cnp6?=
 =?utf-8?B?aW14Z0FsM2IxL09KZ3VhWndrYy9MVCtvYkdxZ0Q4eUlMcTBzUjNacThPeFY3?=
 =?utf-8?B?cmNPK01ZTm1lcEFkck8rR1JlemUzbE92UnVITzVWbElWdzAvRkpsY28vallU?=
 =?utf-8?B?SG5WRWNUM1hJem9KcElFMFRrZUIwMDZnbEhZbDJoUUcwMDBiRnpYRTBUNTVw?=
 =?utf-8?B?WFEzV05ob3Vnd1d4TkpESjlxRExPZi90L2c4djBJU2ROVk1ZN0l5NDZPR3B4?=
 =?utf-8?B?TkxWVEZ0K0xYeTkwZXk3WUVhSzJWT3NjS0RzSFk5bndwQmxPQ09scWZIbzNV?=
 =?utf-8?B?OUpQYUh6SDE3TEVkbGFZbDFNR3NIU2ZGZ1hKaFJMRUc4OU1wSHQ0ZjZqRW85?=
 =?utf-8?B?dDRKRXlOQ1p1OUtTNDNXMUF6S01WMWpNL3FhY3ZTZVFhdVp2d28yNjdIM0Vu?=
 =?utf-8?B?RnlCbkR3UG9KQzBBUUtGZkh1b21IUk9yQ20yK3U2ZG9xZmhVSjNZSWx4VUwx?=
 =?utf-8?B?MlVqNTVZTUxtYWc3NTlreVpNQXNMQVIxTlBJTnBJYSswUzh6bWYzcHFLSTdO?=
 =?utf-8?B?aDN3ZWpRanFvZkdWSUJxeERvaWg5RzFHQ1FyZkcyR3pYNmIrdCtUODd1RjVI?=
 =?utf-8?B?Y1QxR3FMZlpUdWN6WHo4dEtyTEExeHRuM2czUm13SHNLNDM3aDY2aXhOM1VZ?=
 =?utf-8?B?N3YwWVhuQUtNSUNpeUQ1OUtTN0h4bDc1RERGQnh2c1FoOFBQZnA3N2JSUWp5?=
 =?utf-8?B?c2hlWXQ3aStCSWlqdXM0NEVjWVJLQTBRbHZVRkZmMXI2c1RzOTNpa1ZKclE2?=
 =?utf-8?B?MUI2aFovZEdEVllUeUM2WlhubDd1cGU0bUZtYTBwOU5nZEVMS21MRnZENEpV?=
 =?utf-8?B?ZDVlUXNoNUJvN0dORDVOa09LN0kxNTFBSjhXUVhpTzNxZVFyR3lvNklKQTMw?=
 =?utf-8?B?SVEvbFBNekhCbUs3NHNKSUloSU9QdVlqbGI3SWJML2ZIbFhoT2E5WWx0RUJl?=
 =?utf-8?B?Q1JZZGVacTZLN3hsTlZKanY0T2hiV3ZDZlhCdkRyTzc5UUV1QkJibXBOeFd6?=
 =?utf-8?B?WVcrN3ptaUM2M3Q4dTlBTTJ5Q0FkeTJ5aklkU2g3dmdybTR6QXMyVFkvQm1M?=
 =?utf-8?B?cmx6RnFtcXBLSEloOFJDV3hZM3J4SHp6OENlWEdoM0pTdTEwTWtoTlR2TTBB?=
 =?utf-8?B?czhaQzlQdmtOSWZhSlpPb1dka0lCS3lDQWZsYU5mZjRhR01YZTJyYjhBbWZ1?=
 =?utf-8?B?THpYbmFFUXpzM200b3I1NDU5bFl1dEFDT09wWnV6WEliU1U5NTBMNEMvcjNu?=
 =?utf-8?B?YUdDUjJkcWJ3OGExK3NJRjZRdGMwNk5CV01xWnVWbjluWk95Q3ZrTFFoZjMw?=
 =?utf-8?B?TkwyZEU1WEljcG43V0hyd2VXNnFiWE05cThsOE55YTl3emV0Y1dqTXB0K1JL?=
 =?utf-8?B?YnNIRkt5cnArS3A3Y3p1WE5aUG0xNDU4dGRIMGRpZzl5a0pVUTFzSFJ5NjR6?=
 =?utf-8?Q?HF/B/XVklR2vNrgTlw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712b1167-f33f-4137-f03c-08dee1ae0de1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 13:44:40.6142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwedDputhsvtHupVQNmu4Vu4+IDCow6iwoeSXc9/NPQa5vFwdOpsuLkr3+lbTvhA/eR3OtpWEz1+73nDXdYqBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953
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

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5
LCBKdWx5IDE0LCAyMDI2IDY6MzMgUE0NCj4gVG86IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJ
TklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47DQo+IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgNC81XSBkcm0vYW1kZ3B1OiBSZWNvcmQgVVNFUlFf
RU9QIFdBSVRfRVZFTlQNCj4gbm90aWZpY2F0aW9ucw0KPg0KPiBPbiA3LzE0LzI2IDEwOjEwLCBT
cmluaXZhc2FuIFNoYW5tdWdhbSB3cm90ZToNCj4gPiBXQUlUX0VWRU5UIGN1cnJlbnRseSBwcm92
aWRlcyB0aGUgcGVyLWZpbGUgcXVldWUsIG1hdGNoaW5nLCBhbmQNCj4gPiBsaWZldGltZSBpbmZy
YXN0cnVjdHVyZSwgYnV0IG5vIHByb2R1Y2VyIGNyZWF0ZXMgcmVjb3JkcyB3aGVuIGEgdXNlcg0K
PiA+IHF1ZXVlIGZlbmNlIGNvbXBsZXRlcy4NCj4gPg0KPiA+IEFkZCBhbiBJUlEtc2FmZSBoZWxw
ZXIgd2hpY2ggYXBwZW5kcyBhIFdBSVRfRVZFTlQgcmVjb3JkIHVzaW5nIHRoZQ0KPiA+IHF1ZXVl
IHBvaW50ZXIgYXMgdGhlIGludGVybmFsIHJvdXRpbmcga2V5LiBUaGUgcmVjb3JkIHRha2VzIGEg
cXVldWUNCj4gPiByZWZlcmVuY2UgYmVmb3JlIGl0IGlzIHB1Ymxpc2hlZCBhbmQgcmVsZWFzZXMg
aXQgdGhyb3VnaCB0aGUgZXhpc3RpbmcNCj4gPiByZWNvcmQgY2xlYW51cCBwYXRocy4NCj4gPg0K
PiA+IFRoZSBwcm9kdWNlciBkb2VzIG5vdCB0cmFuc2xhdGUgdGhlIHF1ZXVlIHBvaW50ZXIgYmFj
ayB0byBhIHF1ZXVlIElELg0KPiA+IEluc3RlYWQsIHRoZSBXQUlUX0VWRU5UIGlvY3RsIGFkZHMg
dGhlIHF1ZXVlIElEIHN1cHBsaWVkIGJ5IHRoZSB3YWl0ZXINCj4gPiB0byB0aGUgbWF0Y2hlZCBy
ZWNvcmQgaW1tZWRpYXRlbHkgYmVmb3JlIHJldHVybmluZyBpdCB0byB1c2Vyc3BhY2UuDQo+ID4g
VGhpcyBrZWVwcyBxdWV1ZSBJRHMgYXQgdGhlIFVBUEkgYm91bmRhcnkgd2hpbGUgcmV0YWluaW5n
DQo+ID4gcXVldWUtcG9pbnRlci1iYXNlZCBtYXRjaGluZyBpbnRlcm5hbGx5Lg0KPiA+DQo+ID4g
Q2FsbCB0aGUgaGVscGVyIGZyb20gYW1kZ3B1X3VzZXJxX3Byb2Nlc3NfZmVuY2VfaXJxKCksIG5l
eHQgdG8gdGhlDQo+ID4gZXhpc3RpbmcgRVZFTlRGRCBub3RpZmljYXRpb24uIFRoaXMgcmV1c2Vz
IHRoZSBlc3RhYmxpc2hlZA0KPiA+IGRvb3JiZWxsLXRvLXF1ZXVlIGxvb2t1cCBhbmQgZG9lcyBu
b3QgYWRkIGFub3RoZXIgcXVldWUgbG9va3VwIG9yDQo+ID4gY2hhbmdlIHRoZSBHRlggaW50ZXJy
dXB0IGhhbmRsaW5nLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3Jpbml2YXNhbiBTaGFubXVn
YW0gPHNyaW5pdmFzYW4uc2hhbm11Z2FtQGFtZC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4NCj4gV2hhdCB5b3UgZG8gd2l0
aCB0aGUgcXVldWVfaWQgc3RpbGwgbG9va3MgYSBiaXQgZmlzaHkgdG8gbWUsIGJ1dCBJIGRvbid0
IHJlYWxseSBoYXZlDQo+IHRpbWUgdG8gY2hlY2sgdGhhdCBpbiBkZXRhaWwuDQoNClRoYW5rcywg
Q2hyaXN0aWFuLg0KVGhlIGludGVudCBpcyB0byBrZWVwIHF1ZXVlX2lkIGF0IHRoZSBVQVBJIGJv
dW5kYXJ5IG9ubHkuDQpUaGUgV0FJVF9FVkVOVCBpb2N0bCByZXNvbHZlcyB0aGUgdXNlcnNwYWNl
IHF1ZXVlX2lkIHRvIGEgc3RydWN0IGFtZGdwdV91c2VybW9kZV9xdWV1ZSAqLA0KbWF0Y2hpbmcg
aXMgcGVyZm9ybWVkIHVzaW5nIHRoZSBxdWV1ZSBwb2ludGVyIGludGVybmFsbHksDQphbmQgdGhl
IG9yaWdpbmFsIHF1ZXVlX2lkIGZyb20gdGhlIHdhaXRlciBpcyBwb3B1bGF0ZWQgaW50byB0aGUg
cmV0dXJuZWQgbWV0YWRhdGEgaW1tZWRpYXRlbHkgYmVmb3JlIGNvcHlpbmcgaXQgdG8gdXNlcnNw
YWNlLg0KVGhpcyBhdm9pZHMgaW50cm9kdWNpbmcgcXVldWVfaWQtYmFzZWQgbWF0Y2hpbmcgaW50
ZXJuYWxseSB3aGlsZSBwcmVzZXJ2aW5nIHRoZSBleGlzdGluZyBVQVBJLg0KDQpCZXN0IHJlZ2Fy
ZHMsDQpTcmluaQ0KDQo+DQo+IEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+DQo+DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCg==
