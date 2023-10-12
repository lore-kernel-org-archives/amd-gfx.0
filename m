Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D48CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 01:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B90FE10E3E9;
	Thu, 12 Oct 2023 01:49:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 685A110E3E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 01:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmBJQ3PKN5QjzwaPyz/65Kkx+4zXs7+8WoJTotfm1gZAxQ3wdrw8/Un64WL1Y5bNufnAMFMF6KeLqfFF8bvj7sAW3ccosHYy3EwCLENTmkDilk4ha2RyMiVPymzhxlLEOcRIi9EoH328Xsl0ChJIJ0ty62/6pNpSoQURjWMQ14xTyL1YM8u0kBssJEmEx2br1yvnJhGBRSRKwn5/HaMcDm6QahBF1IRXnopoPWBaYzX1Phu1xPLlWtIUGW8cjkW8U93RqDYTTcjlutwKhcqVprcotZNfc/Db/auHbaNUifMeiEJt0xhr1ARKRFACmoWKqZuWPBT5JG2NOTcVfMv4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThKTzZljr0YmRVfnqFWppvPYr0zaM5ASiPIpvjO79cM=;
 b=X7PqPLKN189n/mtSy0luCqAF1sw00zjdnFQ87d2NkFPCD2FEG9ucdoCgkVyOhhXFoKzV7fgV3wI3AH9aU/3Umn5275Qlcan0cRQa/+IV8CMLevLir+CRkIRxB3MR73yObewjJO85kUIi2JlO4Od76AwyKTkpXF5PtnhvZqvTGdN/Ycksf4ejxSkQHuD/wmcIzWqgLEsdDM2MMg3pPeyzAPqd4bmWR0v/OBaXLM9jSTrQXAZuTjgNewgTOy+yf7H8PQhgKGZl1CIwaBVfqdMnwSYGh9RX0Z5noVfu7fM88IyOB+GUxJVfkXKpyTLUdOfr9TAcV18IbR2SvVBy7oiEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThKTzZljr0YmRVfnqFWppvPYr0zaM5ASiPIpvjO79cM=;
 b=ZzUKSlVAct13yNiWljz+MbtfwZsj42moBmk49K5Lzif+jI/alswg0nLYT1+iKvo4GdPf14uEVmzHPeaMyJ+V+4IhtYgE1FD+CAleH6U7rPMEMFNX62HNJ1w3jeA2zqHMI3pWbEqdC7qAdQ0nfEj7lrp9MHmYZPKzTlZRdUau1S8=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Thu, 12 Oct
 2023 01:49:12 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::2d0:bf6d:1f10:a57c]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::2d0:bf6d:1f10:a57c%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 01:49:12 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: disable GFXOFF and PG during compute for GFX9
Thread-Topic: [PATCH] drm/amdgpu: disable GFXOFF and PG during compute for GFX9
Thread-Index: AQHZ/BRdFWjJp0/+eUmAdAHP8jHc07BEo9sAgAC+XsA=
Date: Thu, 12 Oct 2023 01:49:12 +0000
Message-ID: <DM4PR12MB51523C891778FFA624256806E3D3A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20231011072631.1901764-1-jesse.zhang@amd.com>
 <CADnq5_PUDDYMpajRmMqnqgaUh39SDFj6LDD_pxjwHNGr7jqPTw@mail.gmail.com>
In-Reply-To: <CADnq5_PUDDYMpajRmMqnqgaUh39SDFj6LDD_pxjwHNGr7jqPTw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d44b9380-ae3c-4fda-8804-c1b9b3b131e2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-12T01:41:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS0PR12MB7535:EE_
x-ms-office365-filtering-correlation-id: 1d843f75-f006-4d63-1a58-08dbcac56efd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2GOy+JSa5xZkQQG4HEs2ErbSUSdCM7HwCV5wnKIHYZ7yBKDcN2HntDLRzIyNmvtCOImB+hwmD4PwNuUDfOl1lATw45s1OBtP+MqtrKksMzoCFIS3rTG7uCNPnAO9cL3vAZD5Dh1b0XbwbpyAC6jAA7FL0iAHdtyYdjdJmmMGdBExmQlNDqgtF7gl/Ayt9/9N2H/nwO/ULft9pEg3nWr0JyJLvm9gXiuDZ3DncnVrqK+N0Iciw/3/cQMtMlsGdiX7UV5xvRO/AGiZHmfHhI6rs4PPFTxcKyWRb8eE3rp5iCRaoPRS59ZC0SxdFz981jY8AstkIuScdK2/SWDmpwtHqwuPwV8r6FA35kM0Ku1CtcL81IFH9GWKgUk3M+jfqDmul/YLwgl6iXhPEaBo3UVG1J+BsvWoeok3gyAzq3l63bBMuw9OVHhu7LQfbrxpiFxH7KEQ/pKrvEmTPlH7rOgZmWTSngIacrWab0fM05xGzI2KyWuHPk/65igkRPULdUUuqZqILDdLwmx8RO4/EaHOw3lC3skhC3XPsgu13xGH3nfG/BrQvKMIiV830TiIeJfQuuDgM8JMvUVagAeyWls0nUyu9V7kg38joWSTwpWlpkwsOk8nirqMtg0/LllQ8MeU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(396003)(376002)(366004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(26005)(478600001)(53546011)(7696005)(55016003)(6506007)(83380400001)(86362001)(71200400001)(41300700001)(8936002)(8676002)(4326008)(54906003)(6916009)(316002)(76116006)(66946007)(66476007)(66446008)(66556008)(64756008)(33656002)(9686003)(2906002)(38070700005)(5660300002)(38100700002)(52536014)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3BBSWl5OXBBZ28wYWgwMHRCKzJMM21HUmFIeTQ0QVBhenZ2ZWEvUkJheG1I?=
 =?utf-8?B?a0U0anBZejZnamdGRENDNnpsZU9aemVlRStIY1Q2TTFTRnBBV0VzLzY4NmQ4?=
 =?utf-8?B?VFhUS0w2ekpsTkhoOGRnZzZCQTBKWXdMbmNoUlBNWDIxSEZXZGlFZC9GZDNl?=
 =?utf-8?B?ZjhzS1doRGUzTmRScFI5a1Y1YktkdjcvYTR0S2FBN2RTZlJiUDFudE50STNU?=
 =?utf-8?B?SkxJN0FxQkxubk51ZloyUXlLUmhHOFpFdjZGNEp6M0xnQ0thT2lyTkZzbzJL?=
 =?utf-8?B?Y3laRHhlNGhLT1E1TGtrYXlrbWZVc3dOMVZKcVhMcUNuaGsxZEprekNITStt?=
 =?utf-8?B?VjZidHNxaEtPYXJoR1l3ZTRlY09VTjd2Rjd0Ritteko4Mk1aYVkzYzFFWWp3?=
 =?utf-8?B?N21IMjE5aGp3d24xTStSQzFYR01SUHNWTnZuamQxZ3dZU1l4M3ZJcksvUFZI?=
 =?utf-8?B?SUJUMHUraDd3c0tiWEtnRldwOXBudUc3a2g4Q2lRNXAwYTBQZDgva29UdFl2?=
 =?utf-8?B?aXhQeHJROEVaR1BOS2VnOFhuL2N2YzYyV3M4RnJLQnVSdjlRaXhPblhZYzQ5?=
 =?utf-8?B?OXU0YVR1VGN0L3RYb0NTcThZb1lMRndkVVpZZ3k0N093UmZkNmJYc2lLUWRE?=
 =?utf-8?B?VEl1Z1ZpbCsxR0dZaWRzSG9uKzBEeGJUdTl6Vy9ab1RrVEdjd1JncFVlY2l0?=
 =?utf-8?B?UkpIeHRYSFpiQ0k1a3JZaTlHWkk4UjI2TjFRZUlDbU1ucVZkNm5yRE5RODY2?=
 =?utf-8?B?VVdSbUdaLzFTbjdvTUJRbW9WYVJydHk2RXVBcUthdCtOZFcyVjBZRWovWENq?=
 =?utf-8?B?WGdQVGtjTGhxdGxSL1pOQUQ3VGNKakZLUkVtdkJDRDJSZkdaUFVQUFBNckpG?=
 =?utf-8?B?NGgyRnprbTc1ODJKWU0xTmFtREgxZTdKcUVhZkxsc085RTJzU01TK3EzdEFT?=
 =?utf-8?B?REtmY2NPSkFTeVJqaUFnTUVsbm5udFZrajFTWHNpTzdaL1Q1cEZvZzdlKytz?=
 =?utf-8?B?UjhCeWdTWFJ0dkIvenJIRVBEa0hTS1g4VmNUaG5pRld1eHlJQ1ZwRTd2MFRo?=
 =?utf-8?B?ektHWlVZRkladVlUQlRDeCtlTmI1NEdCdTBoSnZLdFNKTS9RWFJvN253enVL?=
 =?utf-8?B?YkFxalpJYnhWdUNGaXRKTXdRcmJDQUZEV1V5WkEwVmpPTjFyZ1hpd3Rrdm9u?=
 =?utf-8?B?V0d1TG13RktkQTM2NGVDRnBmQzJpbUNMNFhaQzkxVkVQWmE0UnBBWFRSS0Fh?=
 =?utf-8?B?MUZSS2RnOVUyQS80YXBia09CMXB3cld6ZGFVMzFKanlQSFNDa1Y5dDRFWTdt?=
 =?utf-8?B?Rnk1TGZKT2VaNzV3ZWZ2N1FSdStXLyt6ZlBuSnN4bno4Zkt5NnRBMkxnV2ta?=
 =?utf-8?B?dklFdm1HNTlQcnhJTy94WFhqZHBFSVg3UzNiK0JYYUw5Z0RNQ2lJQlkrV0Fa?=
 =?utf-8?B?VHNrcDdMT3UvRUhGYVJibmlQSUwxNjdhTlUzcExtSWNqNk85Qm15U3F4RTRj?=
 =?utf-8?B?WUIzVlQ5aXUrSTdDL3ZTRUZhU0ZCSkxaa0RuS1ZHeWtjUTBHdjIzUjBWM09i?=
 =?utf-8?B?MWdVNjJlRmlVZmprRUE0c0N6enh0NFNRTmlEMFJwZm1QRm9qWGhiZG1yUmx2?=
 =?utf-8?B?Um0rOFA4aFJTZUVHM241U2tmOXpzTGgrdld6b3FHekgrZjBycjI4RFNPb3hy?=
 =?utf-8?B?QnB6dExHUG4yelRlVUlkaktrZU15dUg4am1kN2hXRGFUTUxyeVRMNlVQbXA4?=
 =?utf-8?B?ZHZ0RWRZL20xSnhNaFN3QlJXRlcwblFZNWJncWdHcUMzOHBkUExYQU42K0h6?=
 =?utf-8?B?eW1Sc2RlSUhmeVJEampJUjRiTVd3M1RBWkNBR1ZsL3JsWVE5UXlpMlJndlFx?=
 =?utf-8?B?RzI3RWVTaFNmb3Q2akVBejFaVk9LUjBPVWJtUzFKd1pIaEVLdlBNV1VLUVBR?=
 =?utf-8?B?NkFNUnl6VlMzQll3b0ppN0NXL3NrVnJicWhhbzRsWSt4WGNQSFZxV0VzeWFl?=
 =?utf-8?B?eE9HbC9SaEFseTd4M3pPU1NuNW4yaEVpZVY0UHFtMXVXcjM4UEw4N0dlZzk3?=
 =?utf-8?B?bnFXWm9YSWlITWUwS3BGR0cwbmpacG12VmZnaXNIRGs5YlZrUklKK2Y5dnRN?=
 =?utf-8?Q?H3RI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d843f75-f006-4d63-1a58-08dbcac56efd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 01:49:12.2144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u5Ildrcti128R47r5luUb2IbSBTbKaXOnlVYz8Qh8Pgf2fjaJQ4yhvlvfLN+jgt80n2Bj13JDmc/YM8pszDs3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535
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
Cc: "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NClNlbnQ6
IFdlZG5lc2RheSwgT2N0b2JlciAxMSwgMjAyMyAxMDoyMCBQTQ0KVG86IFpoYW5nLCBKZXNzZShK
aWUpIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBZYW5n
LCBQaGlsaXAgPFBoaWxpcC5ZYW5nQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+OyBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPg0KU3Vi
amVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZGlzYWJsZSBHRlhPRkYgYW5kIFBHIGR1cmlu
ZyBjb21wdXRlIGZvciBHRlg5DQoNCk9uIFdlZCwgT2N0IDExLCAyMDIzIGF0IDM6NTLigK9BTSBK
ZXNzZSBaaGFuZyA8amVzc2UuemhhbmdAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IFRlbXBvcmFyeSB3
b3JrYXJvdW5kIHRvIGZpeCBpc3N1ZXMgb2JzZXJ2ZWQgaW4gc29tZSBjb21wdXRlDQo+IGFwcGxp
Y2F0aW9ucyB3aGVuIEdGWE9GRiBpcyBlbmFibGVkIG9uIEdGWDkuDQo+DQo+IFNpZ25lZC1vZmYt
Ynk6IEplc3NlIFpoYW5nIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyB8IDQgKysrKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZC5jDQo+IGluZGV4IGQzODA1ZGJiYmI2Zi4uZmVmOTNkNGVkY2JjIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jDQo+IEBA
IC02ODMsMTIgKzY4MywxNiBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9zdWJtaXRfaWIoc3RydWN0IGFt
ZGdwdV9kZXZpY2UNCj4gKmFkZXYsDQo+DQo+ICB2b2lkIGFtZGdwdV9hbWRrZmRfc2V0X2NvbXB1
dGVfaWRsZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbA0KPiBpZGxlKSAgew0KPiAr
ICAgICAgIGVudW0gYW1kX3Bvd2VyZ2F0aW5nX3N0YXRlIHN0YXRlID0gaWRsZSA/IEFNRF9QR19T
VEFURV9HQVRFIDoNCj4gKyBBTURfUEdfU1RBVEVfVU5HQVRFOw0KPiAgICAgICAgIC8qIFRlbXBv
cmFyeSB3b3JrYXJvdW5kIHRvIGZpeCBpc3N1ZXMgb2JzZXJ2ZWQgaW4gc29tZQ0KPiAgICAgICAg
ICAqIGNvbXB1dGUgYXBwbGljYXRpb25zIHdoZW4gR0ZYT0ZGIGlzIGVuYWJsZWQgb24gR0ZYMTEu
DQo+ICAgICAgICAgICovDQo+ICAgICAgICAgaWYgKElQX1ZFUlNJT05fTUFKKGFtZGdwdV9pcF92
ZXJzaW9uKGFkZXYsIEdDX0hXSVAsIDApKSA9PSAxMSkgew0KPiAgICAgICAgICAgICAgICAgcHJf
ZGVidWcoIkdGWE9GRiBpcyAlc1xuIiwgaWRsZSA/ICJlbmFibGVkIiA6ICJkaXNhYmxlZCIpOw0K
PiAgICAgICAgICAgICAgICAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBpZGxlKTsNCj4gKyAg
ICAgICB9IGVsc2UgaWYgKChJUF9WRVJTSU9OX01BSihhbWRncHVfaXBfdmVyc2lvbihhZGV2LCBH
Q19IV0lQLCAwKSkgPT0gOSkgJiYNCj4gKyAgICAgICAgICAgICAgIChhZGV2LT5mbGFncyAmIEFN
RF9JU19BUFUpKSB7DQo+ICsNCj4gKyBhZGV2LT5pcF9ibG9ja3NbQU1EX0lQX0JMT0NLX1RZUEVf
R0ZYXS52ZXJzaW9uLT5mdW5jcy0+c2V0X3Bvd2VyZ2F0aQ0KPiArIG5nX3N0YXRlKCh2b2lkICop
YWRldiwgc3RhdGUpOw0KDQpXaHkgbm90IHVzZSBhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIGlk
bGUpOyBmb3IgY29uc2lzdGVuY3k/DQpbWmhhbmcsIEplc3NlKEppZSldICBIaSBBbGV4LA0KICAg
ICAgICAgIGFtZGdwdV9nZnhfb2ZmX2N0cmwgb25seSBkaXNhYmxlIGdmeG9mZi4gSXQgYWxzbyBu
ZWVkIHRvIGRpc2FibGUgZ2Z4OSdzIHBvd2VyZ2F0aW5nIHRvIHdvcmthcm91bmQuDQogICAgICAg
ICBTbyB1c2UgdGhlIHNldF9wb3dlcmdhdGluZ19zdGF0ZSB0byBkaXNhYmxlIGdmeG9mZiBhbmQg
UEcuDQoNCiAgICAgICAgSmVzc2UNCkFsZXgNCg0KPiAgICAgICAgIH0NCj4gICAgICAgICBhbWRn
cHVfZHBtX3N3aXRjaF9wb3dlcl9wcm9maWxlKGFkZXYsDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBQUF9TTUNfUE9XRVJfUFJPRklMRV9DT01QVVRFLA0KPiAtLQ0K
PiAyLjI1LjENCj4NCg==
