Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01071C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A2B10F526;
	Sat, 16 Jul 2022 14:35:42 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58DAF10E06A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 13:33:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQRrSr4uwHp0JGHFonuRzc1ln90ydBzUW6tIGuo4xFpFRKvY6czdag/C/SBsfU/HNkVuvs22pDMFWfvvH5J1HH2jFlnYhhtnhLkqMB5JGOImROYCPmxKhnGZJdRmEUdiYqPr5vvoNF+FQB4QZtmt6Gslh7Ktc9AuT8PKZ4AdhqIQlPMgdnB9l0hhWhtQKRQwBLdepJJdcD7id/VqBDHMf/fSq/yms7B4ZUDjSKhrQgOnF5uuJNzq3bp+7BHLCKH0IyOK5bXtK8sHmn6wsBCBrZztOM6nc9icP+LqQhS3UsH8a60sPpDePRcwjXad4kLWU5aG/fQhhkw7GZJVad7qtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DH9AHWC6qfjyDikMf36hT2DwHJNQ9q0f1r0Sxk8gmFA=;
 b=TRjuSFoQAyDSM65Zq3Am6r3AtTU9FFCu9efrNdeoowAhqMbWzCX8PGPGqjBljgdnMv5HrzEpbKjJWIst/mjoCIaAiZn+QuIKfLY7j33nPzKcsswk1YJbIG2TU/sZjURiD9bFjhsKpryGoZ2QPZom5sjQlwHK5N3AI7KiZTDm+kqo6/mQ9j0k0RbS3nD1JnRuVbbAvg4FVm/OaHNNnef+5lDiADPBEfaI2xmHds9VHg94k0kx3TZY87+GcK4AE6laHP/1Bjl/DDoZuJtfdIzRELwScwj9M2lyKS3HcZ+UJn+OG4T5l+oFmlAw+yuZC9rfvwxJOBAnEZGI8Lwwyg9sYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DH9AHWC6qfjyDikMf36hT2DwHJNQ9q0f1r0Sxk8gmFA=;
 b=PDyff/cYQFT+ES9DpkuDMYYsClMqZ6nV5fYscVaY4pdOuPnj3pUPBxEeiyH/CmLR/oa0kdHpBEDsz+/tA+oBbdsYhhMDC4A2UrAjOB9KK48eO6Btn6Qq3zo+3JbLQb9dLPaxbU7f1Fm5b19TRd7Bxz3GwFlXsW7v25WswpA00ek=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by MWHPR12MB1728.namprd12.prod.outlook.com (2603:10b6:300:112::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 13:33:06 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::bc88:3db6:f931:98fc]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::bc88:3db6:f931:98fc%4]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 13:33:06 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: align between libdrm and drm api
Thread-Topic: [PATCH] drm/amdgpu: align between libdrm and drm api
Thread-Index: AQHYl8fgwlNFmLzs2UyfSxY7hMIk7K1/HcGAgABPxBA=
Date: Fri, 15 Jul 2022 13:33:06 +0000
Message-ID: <SJ1PR12MB6194978742183900BB898D0A958B9@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20220714212233.14571-1-ruijing.dong@amd.com>
 <e1c41136-18a6-7747-ce18-b6fb6e1797c2@gmail.com>
In-Reply-To: <e1c41136-18a6-7747-ce18-b6fb6e1797c2@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e6d6181f-5d4b-4e3e-bbe4-15ac0335dd51;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-15T13:26:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fd379f6-860d-4f2c-f880-08da66668cd2
x-ms-traffictypediagnostic: MWHPR12MB1728:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XtP47rKXCYoiJN1VH1HT+uW3e0MIiMAFqLFmDZkRVIAKZnzSoz/o/IZVfaciLjAbxPiZ786yjUkqdWMEADjY9Ex2AdSMWAqWRGSE/vXfLqgky9ESdZt2kxVXKmfCCwT09GHDNpYowfW3o0FJhObOvA3t3iGs95gukSAWhsJembDIj6BMtIQ0LfUDkfEWt8dJJIF86M2Bdxj6IL8Fd/PO+CaUqsjC1BeoEyr3VM+mj0X/EvxkOlzBRA5W/T3JfgUXVXFCrg6P3WhE1ydB3VIO3Da7AX8aXrF88zxgtHgB/Fs/GX39HttsrREmhy92618fgXfNIOCjtsFn7AQ1hptJHBJ+YB7UYeV8CtpVHmoTpOO6Udz+eiYYwrrdZN5HrHeUv2vzbHecTcH65kfBXIWWJwpHOpA4CRKFEeHgVNfntPOA7Y+Jc6i30JYlaLph59EL69tjCL8Me0K13gz4m2eaPdq9vHfYkHj87fWbP2VSpW36lD8QbwUsEoYrqG7DR3rG4AalmbMXjXz4k8EpIXbCPFSeML4E7jEKf7moWhbQ0tfVh2XGI8/1/bHvO6lpXgpFep5bh8OfN6JqUK5u0qTkONx5xHA5rghUeYRFDSaCz+Twps1Ay4mOGTkMvr9ZbATmPO8H8wYD+d8LQ+MYpHv6TvhVxTDtrUd1Sm38YcrmaFG0+bBWQUIFJOV5LL6NyS8JBQd9sm3cxXaCO+ruMqwMpY159esztVJfTpR+/siJmbOaTOQDIxo2ZhNgyJybV0pw/ZUwmoZRzsnFhQ0ljHEKHPmoJXonxsWWAE2E6SBrvwiYfTuaSKcxWee4lWTmNLNO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(66446008)(64756008)(76116006)(5660300002)(186003)(66946007)(33656002)(8676002)(4326008)(83380400001)(66556008)(66476007)(8936002)(52536014)(71200400001)(478600001)(41300700001)(316002)(55016003)(2906002)(26005)(110136005)(54906003)(86362001)(6506007)(9686003)(7696005)(38070700005)(38100700002)(53546011)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0ZObDNVaWNreXFoOC9PdStJdXkrSGg4TjU5NkJ3T1BYbFlwT1FaNFY3VStR?=
 =?utf-8?B?SWJURjduQ3lWemNQbDZmazZ3d0FNOFFrRnBBMm9iQ05VODY3dTlZelBmay83?=
 =?utf-8?B?SjY2cW5qWFhjTzE0K0hsZTdoSWNCM1JTNWdSNFhWYmNaeVhVb2RlbFo2Zk5a?=
 =?utf-8?B?WUdVZkhZK0pKWlBLa0NoTmRxbklVVVFreEhNOFQvdDlZcXVuWU4yNTQvcVBw?=
 =?utf-8?B?Z1lmbnJBOTM2ajFkNU5BOUUySmlrOWFORjZSQXdFU25KS1c1UVFaYTNQYW1F?=
 =?utf-8?B?SjhQTFpsYXNCTnV1U2IwU05ha0V6eHR0dm1ZT1o2K2s1eFM3aWNMRkdTaE5R?=
 =?utf-8?B?VnlpRFA4UkhJOS9DTUF1ZnhlN0FQZ2pGUEl5ME1ZRWY0WDg2NTFqT042UVB4?=
 =?utf-8?B?ellmQzI4Q2RDWEUvOW1NS0NOV2lNMDJoalR1ZElqMkowdUloUTZ3ZHRBWmpS?=
 =?utf-8?B?NHZ2QXVmR2l5RTdEcmtsTjc1SVI5Vm5aQ3ZnMjVYdS9RdEFvWlozbjlkSXRr?=
 =?utf-8?B?elQ1SkxpRTZvcE8zOG41amZTTGRnV1NITTFTZnVjbFYrSEJST1VVaS9NNWcx?=
 =?utf-8?B?cVUra3lIWmVkZHFtV2ZBaGdldkhuNC93eHY4eklGUUx0ZTJVSXA1bGppOTI4?=
 =?utf-8?B?MmtXMUoxVCsrTm5tWHFXRFErY0p2MG15UjBEVytQalVwdFpzQjdZVHdHWnd0?=
 =?utf-8?B?S2VVcXJablgxa2lSWUNkZDZ3WUF1NHMvUTdyQ2c2NjdVMXJUV2RZZUU4d1pO?=
 =?utf-8?B?Sk1mdW9hazJNSGV6eG9aODVJUkRueWdwTmVYMEN5SjRPTnpqUXZwZ041RVRB?=
 =?utf-8?B?OW1ySWl3NGltQUd2UHBKcldyLzBoSkNQTDVGUGZDVTJhdzdmSnNTb3lhaEs5?=
 =?utf-8?B?ZmtmZEpBTFVLNWRiUndqTXNraFZiTkhaV0pReG9YQlB5VHUvSnFpc3J3bUZG?=
 =?utf-8?B?R2UrYzY4Y25sMmJJaFFPaDlrNTFqUUxCVWN2VlZHOWhuUU5YS3BvRFYxbjRa?=
 =?utf-8?B?VDF0V3BFYkh2TEJQejhYVTRhbGorMTdWemk4Qm5ib0pZaVlsMUZnMldvODRE?=
 =?utf-8?B?aUFQOUU5RDRFclpzdzkvRDIzWWZzdkdLZythRVFhLzc3Q1Q2aTRpVlVaT1NM?=
 =?utf-8?B?RFJxbXFCMGlxSXo0dXJkeWxxMHhza09NTW1UVWZHLytDYzYvUU83Qm9TOEpW?=
 =?utf-8?B?V3hSdWZ5K1k1ejZQaTAvRi93ZkdRdmZOWXd2ald2RWRHZHJTQ3FuTENvQ0Z3?=
 =?utf-8?B?MFpEUGtnOWg2QldkRFFEVjE0QUlzSDZOazBQTTVYdUIvYXhRRVZCN29PajVO?=
 =?utf-8?B?eG9RN2x2YmhCY3VuZTYzK2tITHp3TEpjdlpmZFAza3ZSNUFzZm1GQzVsUEFW?=
 =?utf-8?B?YXNsSUthUTdyQ0lrQzUyelVTbFEvSUdDdEIvUWdnQkZuVHhzcDArUG5qMm1y?=
 =?utf-8?B?WG1uLzNRT1ljTXFEYVBqOTVFV3dpeTViZkhIMTlxcUs0cWYrZmdST1oxUVVx?=
 =?utf-8?B?VDNTMmVBUjFwYXJBeFZtN2lLT0hINjNWSG9XRlFxUzkxVXBoRWVjU1R0QXdE?=
 =?utf-8?B?VkFIMC9yemFaUGZOVnJ4N2hkQUVFYUtMOGRBN1lOR3ZnWDBHbjNJbmQ2cEZX?=
 =?utf-8?B?L3o1K213WnFaR3lhTHlkUTYvVExGWUN1Qm1wSHRpMTErYnhFUWRibWQ0QVNx?=
 =?utf-8?B?SnA5RytqdEpGYWdCamtFclRTbDYyRkVWRDUvSmozRFZTWkpjUUdnL0kvc0ls?=
 =?utf-8?B?YytKb3N0NUdwTGkrcWhySWkrTU1rWFk1Q251VjkvdmU0NWE5ZDk1c1VGZ1No?=
 =?utf-8?B?emQ1UTRZc2RORHVLQWc5SHJWSnRKalRjOXc2anVjYTJiNHA3SDNUaC9ZaFZt?=
 =?utf-8?B?MTB5WFJRQW9qZitYNmlxQ0l4R3p0ZVFqSGZKaTBkS21rNjIvOGRCTTFzb2lY?=
 =?utf-8?B?TTF6a1kxRkJNUGhuQkRmUzJaVmxZTjJkOWEvUUpxWnd5NDRFT2NOQUxhdVFE?=
 =?utf-8?B?OGc0S3dwb01NSVYvMFlpRHBUVVU5c2dxa2I2UEFlSk9HSk5UN0g0bWxmTXVW?=
 =?utf-8?B?SFRvMWQ4U1k0S1R6dEJ5NmdDVTVTOEM1bTdHQXduaS9oQ1RjZTd6NEpUL3lE?=
 =?utf-8?Q?Bdyw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd379f6-860d-4f2c-f880-08da66668cd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 13:33:06.1367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0vXGtDYFRLhvFTY93FHeBoNKZ6X31iiSTYcinuesCXeww1XwXczEac94rHtqX7T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1728
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIENocmlzdGlhbiwNCg0KWW91
IGFyZSByaWdodCwgd2hlbiBwcm9jZXNzIHRoZSBsaWJkcm0gY29kZSByZXZpZXcgKG5vdCBjb21t
aXR0ZWQgeWV0KSwgd2UgcmVhbGl6ZWQgdGhlIGNvcnJlc3BvbmRpbmcgZmlsZSBuZWVkcyB0byBh
bGlnbiB0byB0aGUga2VybmVsLg0KU28gd2Ugd2lsbCBuZWVkIHRvIGhhdmUgdGhpcyBoZWFkZXIg
ZmlsZSBjaGFuZ2VkIGZpcnN0LCB0aGVuIHRvIHByb2Nlc3MgbGliZHJtIGNvZGUgYWdhaW4uDQoN
ClRoYW5rcywNClJ1aWppbmcNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENo
cmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPg0KU2VudDog
RnJpZGF5LCBKdWx5IDE1LCAyMDIyIDQ6NDEgQU0NClRvOiBEb25nLCBSdWlqaW5nIDxSdWlqaW5n
LkRvbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzogRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGl1LCBMZW8gPExlby5M
aXVAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBhbGlnbiBiZXR3ZWVuIGxpYmRybSBh
bmQgZHJtIGFwaQ0KDQpBbSAxNC4wNy4yMiB1bSAyMzoyMiBzY2hyaWViIFJ1aWppbmcgRG9uZzoN
Cj4gZGVmaW5lIEhXX0lQX1ZDTl9VTklGSUVEIHRoZSBzYW1lIGFzIEhXX0lQX1ZDTl9FTkMNCg0K
VXN1YWxseSB0aGF0IHNob3VsZCBiZSB0aGUgb3RoZXIgd2F5IGFyb3VuZCwgbGliZHJtIGFsaWdu
cyB0byB0aGUga2VybmVsLg0KDQpXaHkgd2FzIHRoYXQgbW9kaWZpY2F0aW9uIGNvbW1pdHRlZCB0
byBsaWJkcm0gZmlyc3Q/IFRoZXJlIGFyZSB1c3VhbGx5IHBsZW50eSBvZiB3YXJuaW5ncyBiZWZv
cmUgd2UgY2FuIGRvIHRoYXQuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gU2lnbmVk
LW9mZi1ieTogUnVpamluZyBEb25nIDxydWlqaW5nLmRvbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICAg
aW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCj4NCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1
X2RybS5oDQo+IGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggaW5kZXggMThkMzI0NmQ2
MzZlLi5mZTMzZGI4NDQxYmMNCj4gMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvdWFwaS9kcm0vYW1k
Z3B1X2RybS5oDQo+ICsrKyBiL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oDQo+IEBAIC01
NjAsNiArNTYwLDcgQEAgc3RydWN0IGRybV9hbWRncHVfZ2VtX3ZhIHsNCj4gICAjZGVmaW5lIEFN
REdQVV9IV19JUF9VVkRfRU5DICAgICAgNQ0KPiAgICNkZWZpbmUgQU1ER1BVX0hXX0lQX1ZDTl9E
RUMgICAgICA2DQo+ICAgI2RlZmluZSBBTURHUFVfSFdfSVBfVkNOX0VOQyAgICAgIDcNCj4gKyNk
ZWZpbmUgQU1ER1BVX0hXX0lQX1ZDTl9VTklGSUVEICBBTURHUFVfSFdfSVBfVkNOX0VOQw0KPiAg
ICNkZWZpbmUgQU1ER1BVX0hXX0lQX1ZDTl9KUEVHICAgICA4DQo+ICAgI2RlZmluZSBBTURHUFVf
SFdfSVBfTlVNICAgICAgICAgIDkNCj4NCg0K
