Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4001FED2FE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 10:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 489E910E3E8;
	Thu, 12 Mar 2026 10:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KzTptf6A";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE47E10E3E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 10:02:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LS6Yfpu6KUaew0hDwDJN0e/RY7U1DI7BqKf2vN2/rVsOHXtzRYo6yLJMxM5CL/nk7yqKIK0v6dcRMeOla2HdhKaqzoM1cZtfDvEG27eQ9dJAm79k330OWF14Rxy9xie/l+4vy5KomWg7i1QbqWgDIh1sbj/8ywoKqchM6rSK27W1kntRI4AhANoDgucbQ0/zDrLkViLVEpbbo+P2K3+dXG2q5QUbVPd8b2gGxJ9a4fVIyND+a9BNkKqFWVR1hSe8i7GsIc//sfcYRSXWi7Zy3CPiezISR+vpYN6x5ANygXuF2F+kJHaCDIGYVDqRK+CcfFosDXpXhg/AVAjNLCy5og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VgKGPegaAvSYRmfiltceCfm1dCIkL9ovSP7GWX9L0g=;
 b=GTPWmXxrZbN2fab4FWBiLQp2KXlAgxX+/6EgR2PCJN9BwZnNP2p3hWEtYiVGsOhe/MBS2itU6Ywbv/1CICmTDxj96+xEBp1Sw1dSm6yUiEQ+osyx7iEv4Mk/j/07VX158zLDa7UPMukEgyHr9PJsHmK6gY8mx23VPhoRxiBeknIiev81SfWv8vavNbYTpdQcUTtKGyb76B/PF0gwOrcDUBnT055F8y682nKqZ8PqDW3gARJXPiYTwzCPhYu/xCrWikBhi/R798SKYRC7y9L28MmtF0DWqRpLmOzBR7VWUpP23ANEG1vvwLPa7N/Bdc4zh2gLBqkTehCohiARO4YqTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VgKGPegaAvSYRmfiltceCfm1dCIkL9ovSP7GWX9L0g=;
 b=KzTptf6AEF+b6m/rCFJ/IO12tqhPRTqh0HoJ77EeF+SsCVQQo2ox8tjw+htazylYnOqKve+btExRe5QzQICCPoFFikh8O6BMJzyf/OTtd2rGgVn0NEN20GXDH/UQzkUX2cc+HTa+9e9F0+If4LapCUrwzfCOgfxn18wR4WVzZWE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB6693.namprd12.prod.outlook.com (2603:10b6:510:1b0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 10:02:52 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.20.9723.006; Thu, 12 Mar 2026
 10:02:52 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add overflow check for BO list array
 allocation
Thread-Topic: [PATCH] drm/amdgpu: add overflow check for BO list array
 allocation
Thread-Index: AQHcsfjR6VM9S6ppOE6vIukI9J/9krWqjuGAgAABrQCAAA2egIAAAobggAABQwCAAAIL8IAAAxsAgAADjhA=
Date: Thu, 12 Mar 2026 10:02:52 +0000
Message-ID: <BL1PR12MB514426FD82F640AF5F616696E344A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260312081827.1484742-1-Jesse.Zhang@amd.com>
 <ff117d6b-943a-4555-834c-96b53bd20057@amd.com>
 <DM4PR12MB5152B6F41902A41DAF0364B0E344A@DM4PR12MB5152.namprd12.prod.outlook.com>
 <893e3235-b291-45c7-8644-913e22b432ce@amd.com>
 <BL1PR12MB51440DF0B4763FACFFFE9045E344A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <0c94049a-1743-4e93-831a-5bcb5b43aa89@amd.com>
 <BL1PR12MB5144221F15AC59541C403161E344A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <2bb6b6df-7332-42a8-9db9-26decd4ee298@amd.com>
In-Reply-To: <2bb6b6df-7332-42a8-9db9-26decd4ee298@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-12T10:02:15.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB6693:EE_
x-ms-office365-filtering-correlation-id: ca2c7fd8-c9fe-4dfc-b8c2-08de801e861d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: WG00PIIFMKZRJLTP887U36glFmo6OAykfO9bpTmyu48WS6tASG8XcMfZmf3283GvJEn5YX9Ifhqry5Fa+FCT6vfVZ3TzlySUO/APshg5lpvJENkvGdCskP/QEop9qfsOFzi21YrJXQJLN3B2VHaQyIjxHkK7YrpbT1mS5pB/0FCpGUpIQA0vFT4UdqNWyNAGOCG7SOh/Rqwz8mMe65IiCnD0coYbzX1mmpC/VBDTkaQF23r9PKbPlRJqVlY9QDTr33Qx1jo/NGM6f+Jp1vpOPXwdE85uNtbUFE0jkvRKaAC0uhTA5gNOKyiRVieL14BUO5rNHerYOzUOEEqzVDtX/th8OSZSR4JrwfZ4BJHe1Ygq9EpkQ1LRdUsVqM7DYjZVKWYh66zkD/au6g8/JoYGCW59FdNDGsYssehdhGPJvMm1ZOIJ54wa4FD3rig8VMKflqIrjAqkWwsReKL6gNax9jgeCtW/eMoYBPxZTwbCA8zfgMROiAZRF6i3R5/EuWJm/CZyggWxualZbzArRBtjEWIVwlnSNOwi9ZHqRQfnT/vCRrO8ZaB1JSmhctnNrkkzB3BifCEbhOfSEgMS5VsFsciSyG8AsqGXGqjWEycwc9itqE7z0Q1/aXNFzQmY0oJhZy23OHMKVPJyRSWc24eD2bp0OjmdleN1VFVrLHvJCU0JV44Nl7b95fhTOvhb1LSQP4LQxFNPm8mtqIWzyltQa42TnXEmPW48GZtd97p/q90HgwwNswiJqGJIltDGOQ36K1m3d98g4st6KUlbEWPqlcPGC9MObPy6I+b6niH6YGE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a21JKzV2NUtuSGFmaTZzSmVHbW1XNDZiS01MRFRhOHJNek9ZbUpJc3ZxbmZB?=
 =?utf-8?B?MjJqNTFnM0lGenhUREI2Y0hJN09QSktKMXNOUmFCUFRRUVRaeFI5MkVnL08r?=
 =?utf-8?B?L3dCWXYvNG0xcGVsbmlkWXVZYURCaVZmOVdCc0pBeGxMTUgvM2kra25FV1BH?=
 =?utf-8?B?U2tJbFJ2MytBSzhVd0VwcmlEeVlLbm9WMUlDZTQyR0UyWDJ5WFJwZHU5Y2du?=
 =?utf-8?B?Zi9VMndmZmwxNGNiNnlZZUZUK0NSNHZyZ0ZNQlpFbWVqVmYvRWJZVjB1YklO?=
 =?utf-8?B?NHhhTWR3Ni9RZnNnSms3bHlLbXBwdmgvWXMva1lPTnZSRG1pYzRqMGRWSnlQ?=
 =?utf-8?B?UTJIbmFjR1l0RGliWllEb1F5ZzBIL09ORUthbVFOSG1CaFQyc1ZQWE4rNktu?=
 =?utf-8?B?bWZrYU5oTXVodGZNYlBPK1QzcjhuUEpkR1g2c0s5WHZoOFFaeTFvdVUzVHF1?=
 =?utf-8?B?czI1c2NOeDlYcDBEc0pacUUwS3dXNjFZL1A0eHBoRjhsMFlRSHdsVmY0YlhX?=
 =?utf-8?B?dGFOVDBxaGNHME1HSzk2cXgxNzBad3VPeGQxdXBhdksybCt0SVpNQVg4aDRp?=
 =?utf-8?B?eU45a203SWJ4Zk9qVFVVY3JYSDFraHloaHZSUDZ4OUJJSW9nNlcrRElTeHZy?=
 =?utf-8?B?ajRDZURWUStEaGNnSlZISStjQW5NaTd0RFNKZ3FGSnQ3SG5peUJHejJBQWl3?=
 =?utf-8?B?VjJ4ekVucWRzbk9SWDcwU2Ntd0tWVHAwL1lsUlpkdnhPUUk1RTdoZG9POGN3?=
 =?utf-8?B?ejNXQ3RBVE9qVEl3TW4vejBqdWIwZVQ0RXdLUFFhNWFUV2JnemJhY25JR09o?=
 =?utf-8?B?U2FNY0VTTmp2SGdUWHRseEMrREYrV20wWXBsTENjY3FWT05wTGJTUjlvVGJa?=
 =?utf-8?B?eVRtWUNTQVo4ZXJkNUk2aFlZY2lUL0dyZkJxVEtYMURqWDNJa0taM001dCtV?=
 =?utf-8?B?RVVkc3JCMFozNnROSXNWV2pSa1lsYlJ6YkVwVzMzeDE4Zjk5YXdVWjZidG9l?=
 =?utf-8?B?SWhsM2xaUTdndVRJTjlIU0VmVVE4ZGlxTGphRHVPZGRTR2JMSkNIN042aDl4?=
 =?utf-8?B?a1R5eUxERm9DUE5jM1NFUXZ2T2FLMkNhdGRBTkZHVmFzZG9xMENxL1BmOEFU?=
 =?utf-8?B?azlqb3h0VUdUM0ltVVNXWDltU0JWT1ExbXRnQVZFY2ppNDJMU3VvQUJhZy9D?=
 =?utf-8?B?ek54SGtIbnc2Ui9tMnUxN3NxTkJENkZURGJJL3R2Q3I1clR5TkZqM2tydEsy?=
 =?utf-8?B?MTNjbzUxYkswZWtiVGlkVE1zZ2ZGVkY4eE5yUmpLYkVtMk0wcmlkVkpwVTdF?=
 =?utf-8?B?YUd5ajY3V3hSamd6SVE0N09DOEhnd055bEZmWkc5cTFCOEsyQzErUVI5TFJI?=
 =?utf-8?B?WVJabDNnMWY0dmJTRjlCQXpSb05HTGExcVN3dStMMUViclVRSTdiblZISVZk?=
 =?utf-8?B?V1dHTkxuRTMycnpHNHpSN1E0cFZwK3ZTVVhQbExQQUpoVlRVak9JK3MwYnRq?=
 =?utf-8?B?d1FnVkQyVTY5RDZFeDhzclNBOEJJdnhsSlBLTDZEcjl5UU5pQk5xYmRuZGlZ?=
 =?utf-8?B?YXNlN25udE1RbGJybHU2K2N2N3RieXlMblNnTU1LVUlUU2hYdjZRZEtHaHhI?=
 =?utf-8?B?S3Brdk1aVTZOMzVnRlhRVlhEVjNmMGNONysxK2c5amZ1UTJVN29ObkF6T01T?=
 =?utf-8?B?MVNKRlVDTmlHWTdhZ2xJWDNFWjl0czduK3Q5RS84dXpROWRLbFYrWTdrZUt0?=
 =?utf-8?B?QjBZZy94QUVtcit1bVpaT28raENLSlZYTmx2N05pZzY4VlpFLzBkM1BmU0Fo?=
 =?utf-8?B?QlUwWTMwa3NqMGdKUm1RRkF2YlhQM0g0UGwrL0Q0NWpEaUlxMlc5c21sQmY4?=
 =?utf-8?B?TncwRWVRbElCWFZia3V2K0ljSjlZZEc0M3lYQTFvTStaZ21MSG1CMmkrWnpF?=
 =?utf-8?B?MzVWVU1rVldaM2pDU3dhVUx4VWFpNlRwUzhSV1E2OVFLODh0STQzQmhIMUhV?=
 =?utf-8?B?V1c3WmNEd2pXMmJOUUo0K0Vmc0s5TDFzMVJ5c3pyOVBYeWY4cXh3VG5BVE1w?=
 =?utf-8?B?MFE3YUw4L0h6UUJaQm9sb1ZuUDBNaVM3SC9vQ2ltRzVoa2tkYzd6RmdJNGhX?=
 =?utf-8?B?Ulk5dXRTMmQzMzlOTWhqNTBCc3d1YVIzdGh6ako2ZFhzVGdRVnB0N09BeW80?=
 =?utf-8?B?NHlJR3JJYVJodXFlUE04ZnpCU1J3R0U4dkM5TGhwVmFWOUZFTlM1bTFBQVFm?=
 =?utf-8?B?LzV4OWhET3QvZlhpWUEvOWY0ejYvWEVHY015Njl2dFFFUkQ4N21vNVluVXoy?=
 =?utf-8?Q?sHWi8feMM0uFVHdDm3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2c7fd8-c9fe-4dfc-b8c2-08de801e861d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 10:02:52.0466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTF2dN3fD1CkKcnUHV2LjIlrWYu+8BQIKevABEwqzD3osAOMNRfgrkNrbVfClqu/ETugjOtDQiJtiNiL8mSO5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693
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
IDIwMjYgNTo1MCBQTQ0KPiBUbzogWmhhbmcsIEplc3NlKEppZSkgPEplc3NlLlpoYW5nQGFtZC5j
b20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vYW1kZ3B1OiBhZGQgb3ZlcmZsb3cgY2hlY2sgZm9yIEJPIGxpc3QgYXJyYXkgYWxsb2NhdGlv
bg0KPg0KPiBPbiAzLzEyLzI2IDEwOjQ4LCBaaGFuZywgSmVzc2UoSmllKSB3cm90ZToNCj4gPiBb
QU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0K
PiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEtvZW5pZywg
Q2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5
LCBNYXJjaCAxMiwgMjAyNiA1OjMxIFBNDQo+ID4+IFRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVz
c2UuWmhhbmdAYW1kLmNvbT47DQo+ID4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+
ID4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+
ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IGFkZCBvdmVyZmxvdyBjaGVjayBm
b3IgQk8gbGlzdCBhcnJheQ0KPiA+PiBhbGxvY2F0aW9uDQo+ID4+DQo+ID4+IE9uIDMvMTIvMjYg
MTA6MjcsIFpoYW5nLCBKZXNzZShKaWUpIHdyb3RlOg0KPiA+Pj4gW0FNRCBPZmZpY2lhbCBVc2Ug
T25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4gPj4+DQo+ID4+Pj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiA+Pj4+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAx
MiwgMjAyNiA1OjE4IFBNDQo+ID4+Pj4gVG86IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNzZS5aaGFu
Z0BhbWQuY29tPjsNCj4gPj4+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+Pj4+
IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+ID4+
Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogYWRkIG92ZXJmbG93IGNoZWNrIGZv
ciBCTyBsaXN0DQo+ID4+Pj4gYXJyYXkgYWxsb2NhdGlvbg0KPiA+Pj4+DQo+ID4+Pj4gT24gMy8x
Mi8yNiAwOTozMywgWmhhbmcsIEplc3NlKEppZSkgd3JvdGU6DQo+ID4+Pj4+IFtBTUQgT2ZmaWNp
YWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+ID4+Pj4+DQo+
ID4+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+Pj4gRnJvbTogS29lbmln
LCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NCj4gPj4+Pj4+IFNlbnQ6IFRo
dXJzZGF5LCBNYXJjaCAxMiwgMjAyNiA0OjIzIFBNDQo+ID4+Pj4+PiBUbzogWmhhbmcsIEplc3Nl
KEppZSkgPEplc3NlLlpoYW5nQGFtZC5jb20+Ow0KPiA+Pj4+Pj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj4gPj4+Pj4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5E
ZXVjaGVyQGFtZC5jb20+DQo+ID4+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1
OiBhZGQgb3ZlcmZsb3cgY2hlY2sgZm9yIEJPIGxpc3QNCj4gPj4+Pj4+IGFycmF5IGFsbG9jYXRp
b24NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBPbiAzLzEyLzI2IDA5OjE4LCBKZXNzZS5aaGFuZyB3cm90
ZToNCj4gPj4+Pj4+PiBXaGVuIGFsbG9jYXRpbmcgbWVtb3J5IGZvciBhIEJPIGxpc3QgYXJyYXks
IHRoZSBtdWx0aXBsaWNhdGlvbg0KPiA+Pj4+Pj4+IGJvX251bWJlciAqIGluZm9fc2l6ZSBtYXkg
b3ZlcmZsb3cgb24gMzItYml0IHN5c3RlbXMgaWYNCj4gPj4+Pj4+PiB1c2Vyc3BhY2Ugc3VwcGxp
ZXMgbGFyZ2UgdmFsdWVzLiBUaGlzIGNvdWxkIGxlYWQgdG8gYWxsb2NhdGluZyBhDQo+ID4+Pj4+
Pj4gc21hbGxlciBidWZmZXIgdGhhbiBleHBlY3RlZCwgZm9sbG93ZWQgYnkgYSBtZW1zZXQgb3IN
Cj4gPj4+Pj4+PiBjb3B5X2Zyb21fdXNlciB0aGF0IHdyaXRlcyBiZXlvbmQgdGhlIGFsbG9jYXRl
ZCBtZW1vcnksDQo+ID4+Pj4+Pj4gcG90ZW50aWFsbHkgY2F1c2luZyBtZW1vcnkgY29ycnVwdGlv
biBvciBpbmZvcm1hdGlvbiBkaXNjbG9zdXJlLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gQWRkIGFu
IG92ZXJmbG93IGNoZWNrIHVzaW5nIGNoZWNrX211bF9vdmVyZmxvdyB0byBkZXRlY3Qgc3VjaCBj
YXNlcy4NCj4gPj4+Pj4+PiBBbHNvIGVuc3VyZSB0aGUgcmVzdWx0aW5nIGFsbG9jYXRpb24gc2l6
ZSBkb2VzIG5vdCBleGNlZWQNCj4gPj4+Pj4+PiBJTlRfTUFYLCBhcyB0aGUgc3Vic2VxdWVudCB1
c2VyIGNvcHkgb3BlcmF0aW9ucyBtYXkgcmVseSBvbiB0aGlzIGxpbWl0Lg0KPiA+Pj4+Pj4+IFJl
dHVybiAtRUlOVkFMIGlmIGVpdGhlciBjb25kaXRpb24gZmFpbHMuDQo+ID4+Pj4+Pg0KPiA+Pj4+
Pj4gVGhhdCBpcyBjb21wbGV0ZWx5IHVubmVjZXNzYXJ5LCB2bWVtZHVwX2FycmF5X3VzZXIoKSBh
bHJlYWR5IGRvZXMNCj4gPj4+Pj4+IHRoYXQNCj4gPj4+PiBjaGVjay4NCj4gPj4+Pj4+DQo+ID4+
Pj4+Pj4NCj4gPj4+Pj4+PiBBIGNyYXNoIGxvZyBpbGx1c3RyYXRpbmcgdGhlIGlzc3VlOg0KPiA+
Pj4+Pj4+DQo+ID4+Pj4+Pj4gWyAyOTQzLjA1MzcwNl0gUklQOiAwMDEwOl9fa3ZtYWxsb2Nfbm9k
ZV9ub3Byb2YrMHg1YmUvMHg4YTANCj4gPj4+Pj4+PiAuLi4NCj4gPj4+Pj4+PiBbIDI5NDMuMDUz
NzI1XSBDYWxsIFRyYWNlOg0KPiA+Pj4+Pj4+IFsgMjk0My4wNTM3MjhdIGFtZGdwdV9ib19jcmVh
dGVfbGlzdF9lbnRyeV9hcnJheSsweDQyLzB4MTMwDQo+ID4+Pj4+Pj4gW2FtZGdwdV0gWyAyOTQz
LjA1Mzk0N10gYW1kZ3B1X2JvX2xpc3RfaW9jdGwrMHg1MS8weDMwMCBbYW1kZ3B1XQ0KPiA+Pj4+
Pj4+IFsgMjk0My4wNTQyNzddDQo+ID4+Pj4+Pj4gZHJtX2lvY3RsKzB4MmNiLzB4NWEwIFtkcm1d
IFsgMjk0My4wNTQzNzldDQo+ID4+Pj4+Pj4gX194NjRfc3lzX2lvY3RsKzB4OWUvMHhmMA0KPiA+
Pj4+Pj4+DQo+ID4+Pj4+Pj4gVGhlIG92ZXJmbG93IG9jY3VycyBpbiB0aGUgYWxsb2NhdGlvbiBp
bnNpZGUNCj4gPj4+Pj4+PiBhbWRncHVfYm9fY3JlYXRlX2xpc3RfZW50cnlfYXJyYXksIGxlYWRp
bmcgdG8gYSBjcmFzaCBpbg0KPiA+Pj4+Pj4+IHZtZW1kdXBfdXNlciAodmlhIF9fa3ZtYWxsb2Nf
bm9kZV9ub3Byb2YpLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEhvdyBhbmQgb24gd2hpY2gga2VybmVs
IGNhbiB5b3UgcmVwcm9kdWNlIHRoYXQ/DQo+ID4+Pj4+IFdlIGFyZSBkZXZlbG9waW5nIHNvbWUg
ZnV6eiB0ZXN0cyBmb3IgdGhlIHVuaWZpZWQgcHJvamVjdC4NCj4gPj4+Pj4gVGhlIHRlc3RzIGlu
dm9sdmUgcGFzc2luZyBkaWZmZXJlbnQgbGV2ZWxzIG9mIGdhcmJhZ2UgZGF0YSBhbmQNCj4gPj4+
Pj4gZW5zdXJpbmcgdGhlIGtlcm5lbA0KPiA+Pj4+IGNhbiBoYW5kbGUgdGhpcyBkYXRhIGNvcnJl
Y3RseS4NCj4gPj4+Pj4gVGhpcyBpc3N1ZSBjYW4gYmUgcmVwcm9kdWNlZCBvbiB0aGUgYW1kLXN0
YWdpbmctZHJtLW5leHQgYnJhbmNoLg0KPiA+Pj4+DQo+ID4+Pj4gRG8geW91IGhhdmUgdGhlIGZ1
bGwgYmFja3RyYWNlPw0KPiA+Pj4gWWVzLA0KPiA+Pj4gWyAyOTQzLjA1MzY0OV0gV0FSTklORzog
bW0vc2x1Yi5jOjcxNTIgYXQNCj4gPj4+IF9fa3ZtYWxsb2Nfbm9kZV9ub3Byb2YrMHg1YmUvMHg4
YTAsIENQVSMxMzogYW1kX2Z1enppbmcvMjc2NQ0KPiA+Pg0KPiA+PiBBaCwgeWVzLiBUaGF0IHBy
b2JsZW0gY2FtZSB1cCBiZWZvcmUuDQo+ID4+DQo+ID4+IFRoZSBtYXhpbXVtIG51bWJlciBvZiBC
T3MgaW4gYSBCTyBsaXN0IHNob3VsZCBiZSBsaW1pdGVkIGFuZCBub3QgdGhlDQo+ID4+IHJlc3Vs
dCBvZiB0aGUgbXVsdGlwbGljYXRpb24gY2hlY2tlZC4NCj4gPj4NCj4gPj4gVGhlIHByb2JsZW0g
aXMgdGhhdCB3ZSBjb3VsZG4ndCBnaXZlIGEgZ29vZCBudW1iZXIgb24gdGhlIG1heGltdW0gQk9z
DQo+ID4+IHdlIGNhbiBoYXZlIGluIGEgQk8gbGlzdC4NCj4gPiBUaGFua3MgQ2hyaXRpYW4sIGFn
cmVlZC4gdjIgc3dpdGNoZXMgZnJvbSBwdXJlIG11bHRpcGxpY2F0aW9uLW92ZXJmbG93DQo+ID4g
d29yZGluZyB0byBhIEJPLWNvdW50IGxpbWl0LiBXZSBub3cgYm91bmQgYm9fbnVtYmVyIGJ5IElO
VF9NQVggLw0KPiA+IHNpemVvZihkcm1fYW1kZ3B1X2JvX2xpc3RfZW50cnkpIGJlZm9yZSBhbGxv
Y2F0aW9uL2NvcHkuIFRoaXMga2VlcHMNCj4gPiBiZWhhdmlvciBkZXRlcm1pbmlzdGljIGZvciBm
dXp6ZWQgaW5wdXQgYW5kIGF2b2lkcyB3YXJuaW5nLXByb25lIGh1Z2UNCj4gPiBhbGxvY2F0aW9u
IHBhdGhzDQo+DQo+IFllYWgsIGJ1dCBJJ3ZlIHJlamVjdGVkIHRoYXQgYmVmb3JlIGFzIHdlbGwu
IElOVF9NQVggLw0KPiBzaXplb2YoZHJtX2FtZGdwdV9ib19saXN0X2VudHJ5KSBpcyBqdXN0IG5v
dCBhIGdvb2QgbWF4aW11bSBsaW1pdC4NCj4NCj4gVGhpcyBuZWVkcyB0byBiZSBhIGZpeGVkIGNv
bnN0YW50Lg0KVGhhbmtzIENocmlzdGlhbiwgYWdyZWVkIOKAlCB3ZSBzaG91bGQgdXNlIGEgZml4
ZWQgbGltaXQsIG5vdCBhbiBJTlRfTUFYLWRlcml2ZWQgb25lLg0KSSBzd2l0Y2hlZCB0aGUgcGF0
Y2ggdG8gYSBjb25zdGFudCBCTy1saXN0IGNhcCBhbmQga2VwdCB0aGUgYm9faW5mb19zaXplIHNh
bml0eSBjaGVjay4NCmJvX251bWJlciBpcyBub3cgcmVqZWN0ZWQgd2l0aCAtRUlOVkFMIHdoZW4g
aXQgZXhjZWVkcyBBTURHUFVfQk9fTElTVF9NQVhfRU5UUklFUyAoY3VycmVudGx5IHNldCB0byAx
MjggKiAxMDI0KS4NCg0KVGhhbmtzDQpKZXNzZQ0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4u
DQo+DQo+ID4NCj4gPiBUaGFua3MNCj4gPiBKZXNzZQ0KPiA+DQo+ID4+DQo+ID4+IFJlZ2FyZHMs
DQo+ID4+IENocmlzdGlhbi4NCg0K
