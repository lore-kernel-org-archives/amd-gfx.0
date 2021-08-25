Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DB2C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 12:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078316112D
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 12:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 078316112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA4BF89B3B;
	Wed, 25 Aug 2021 12:01:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F1889B3B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 12:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8S+cMPRDAMAyv5ONhjq6oa6oDzda7et3etHJ1zqX7Nv6L3ZU+ORX45R2xj+7kAdOEKV8WrEe8hhZ5bFyOQgVLIy3xE/khOVWQSG4JuTAybgf196sZ5fHbAQpgh7p+b5dkaK1B44yBjbsTHMwfXn/MzGBqv1CFZr71Gn9tMNBhsqDAL2Dv8NmgdMfB6qXkupC+qN2WZiL5J2EzE8Hc41hcIJwMOdsxMQB5gpqEfBQrV/uljS2oAVM02/o5ByW7/PpxHkMVF1sVuuTKJQhz8O2Oo7kVLetZdT4iz+UfeLeWvo5O6Rg+dM+ITeqtDwFINyhbYZqcyKmL3/gZSHQM+hsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gb08Ijk/AGwFiRB+75VhNDJeLI1DwbQFN+lJmagZ+ns=;
 b=IHYB/fzeChQrriaqrCY23JnognAQ7GnlHkd+obOLpF4hh/i5ek42z0vT7Xh0TKz39T0ZubDAaps2b1kQQpvPJtDtO2S8g88/clL7WEWSsGI8jYrAU4KUqm++zgfqcgIHDVJZsD6ne0UEMIGLDbxpPNwo1bFXODz/6jroCDJQlAfa7Eohl3m3JUqhJ2Szi6GU8roInDWyLCSzr4pno5W3HHkKw9FzvkvFMGollFUHbuyqU6WPe/IQRKmr54l3gSdSrMmGzaNJuClQ9m/qQ+e5rsGifAzzHiD3Jm/xAFLYUbhGx7Q+EcWZCEtojfpHU8CE9sdQPz1HZG5Uqz5EU7QEpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gb08Ijk/AGwFiRB+75VhNDJeLI1DwbQFN+lJmagZ+ns=;
 b=Kg5ft9ohEtKGcPt/nqwrpKXmK0nMOzm7PWt+kIGYXZnBEGWUQG7pbYigHRCbOd2suXEoa/yrMD3lv0uQOTkDcikiNRSN6Shk5ddLaQViI/QZZBou95A5vPfcSHnYpvD8G7LJs25kXr7YH8ElEZwgR4v72LsCMpPQHu/lR1wYwh0=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL0PR12MB5555.namprd12.prod.outlook.com (2603:10b6:208:1c2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 25 Aug
 2021 12:01:27 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::acc6:c407:1353:6a]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::acc6:c407:1353:6a%5]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 12:01:27 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/sched: fix the bug of time out calculation(v2)
Thread-Topic: [PATCH] drm/sched: fix the bug of time out calculation(v2)
Thread-Index: AQHXmWev/1s0G88H/USG8+ifveLzjquDwuuAgABVUPCAAAYaIA==
Date: Wed, 25 Aug 2021 12:01:27 +0000
Message-ID: <BL1PR12MB5269E736907243FDF42D97F384C69@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <1629864857-4252-1-git-send-email-Monk.Liu@amd.com>
 <1ef452fc-1f76-8dda-1c74-c540576fe6c6@gmail.com>
 <BL1PR12MB5269567906F233C0B938C32C84C69@BL1PR12MB5269.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5269567906F233C0B938C32C84C69@BL1PR12MB5269.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-25T12:01:26Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=51cc4fd5-d3c2-45a6-aa60-a9a0f3d2aeca;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4b957a9-dbeb-4ef3-e284-08d967c01163
x-ms-traffictypediagnostic: BL0PR12MB5555:
x-microsoft-antispam-prvs: <BL0PR12MB55550E87E599B6B9A887FA5884C69@BL0PR12MB5555.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3jL2K1rpmKX4pxxCE7Ipa5XBQWmmQxHolTkGOiJRm0Qr/5lh2pNOIOn3DrZdE9mtiCYXLazO04qSCuoCWiAOTdh65u7qA9e8BQPgiuaYFlGDIkFeeBnvYgTgSmgNug+1SycfgpUN8e/KsM2nBHWsveGj/jLbqEzu6Jh8AWTvF8rbvcQBeOAlja7VYgnoBtF5UeQaY3GWsQxV2XpR7SekjzPcWKlKQ81fIQJ1MnVb07HKPaDl+NZfUi//eY40+1eYksJpP7o7rz3DHSLhfjm/xWplUmWnBhcU1F3FJNyKj7i/eRp89IaNDI+7Bl26+Z57Fmz00lXF779ctJbUaNFH6H9UWS99s4sW0wGVvBYxcrx1n4Z52MJzX+wvBiKHkYepdajmOYTUPIdLMovd9CwhJHrWJBPzuGmaejZDC79KrnK7YUWwE/SZs2ZBtMTldjHcoXQPOBXBlGTkAnrTVRcgxEElfE7jjyMMpzA3iQrh25fKQ8H0XHGLRb5KiNXPCSpQ3LSz84vJA8KdskHsy3N9gl2qAQ0FBrZi9HPzusTm7Ww3k7FtljB6tRTbUpImo+mm7d2SQRg/AXdvF7EyHmGU24dYnNW3HPLfJDBcKEbSISi0YXVJUjd3viaIUPXCCEmZ5XMsTXd+3ij/j5BaxAL+UZmUWrVwqkoxw/y4QCPdsldn8ZaK9xK05H5+Auc++uSB2t+yNyBBuGm24ShHFMkm4A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(76116006)(38100700002)(66476007)(66556008)(8936002)(8676002)(53546011)(66446008)(66946007)(6506007)(71200400001)(86362001)(64756008)(7696005)(26005)(2940100002)(316002)(66574015)(52536014)(2906002)(110136005)(9686003)(186003)(5660300002)(55016002)(122000001)(478600001)(83380400001)(38070700005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VU9sWndESzFYeTZDWkNidm1DT1VVbzRZNGRVZUIrTGJVaHJCbmFaaXJueUpm?=
 =?utf-8?B?L28yQTVKTVIrTVlkVEdTZU42eWc3N1JkMitydjJ3aEJZZFRPcjl0SEpDSG9C?=
 =?utf-8?B?dHRSUndnMk0rVmZTenRoSmFKNmYydXJXMEczdm5FUDl3QzVXSWkrbkNWK2V0?=
 =?utf-8?B?cUhjZzN1QmZOcHI2Wm0vcHNjclgxVDZ6RDFCbFF6MUhQYmt6SXVIanRKWjJE?=
 =?utf-8?B?RWZKamJBRk9qVkZaQ3NMVTNOTW1FcjB5Wm5iTGpxY0VPUyswV2YyeVNSdFNa?=
 =?utf-8?B?T0tYTDZZNUdQV0FrbXdQU3IrVWZOSk80VE9HczRkZGoyWkVMRlJWWmR5a01m?=
 =?utf-8?B?ZUhWaWNkVUkxVVhWMVdOVExjZk5MY0FjNDdJRGN0TzhucitzbE84dER3dC9X?=
 =?utf-8?B?R3NpSzZUZkpaNUQxVzlRR1doWU1iM0N3MDJ4QS9jQjB5NnI0Z0tibHk4S1NP?=
 =?utf-8?B?cGZnbm9JQkZPUTRpSEdjTk5VVzBYcElieFc4aUFKeFlFdXJhdkhLbHExTTFh?=
 =?utf-8?B?NmJoLzZBMGlYdlBWWFlXMW03N3V4aUZhRmlEZnB0TFgwTk8yZGZVZDVUZXgz?=
 =?utf-8?B?dTduSWkrTjJVeGwwSTQ1eUNQa051WGRSQVE2OFZaYm4zRThwTUp5TEU0dnkr?=
 =?utf-8?B?SHVTWEVSUTZSVjBnaUgzL2x0dmVEQ0pVaWdjM1NGcFpjTVFyNkZuNGhDV3Yr?=
 =?utf-8?B?dUk1b2pFTWZyV0xOSHpVQ1F0RTZ3Rk5Fc0F3bjRiZEs3Nzd5c1p2UjQ4UXE0?=
 =?utf-8?B?di9VNXg2MkdTcGUwQTIrS1QwM3NkVjlhZ05NUjZYRFNQdXkxYTF4cFN6TnMz?=
 =?utf-8?B?SkhEVzJSOTFOMEZaS1VkeDVjd25zdGFGL0ZOQmFHcktPNXFYY3dHRmZxRXNS?=
 =?utf-8?B?NDVaMkVid3lVS0FJWHdSNjJJVlZzUzZXd3NoQ2ZpblMrWUVUSjlDY1pwdUM0?=
 =?utf-8?B?MWtrdWM5b0k4akl4ZHFqRXhCTEJIckpzdUt4MkpQVkFoRjBXMzZidm5qcWhO?=
 =?utf-8?B?S3pXNStpbXFUQitYZ0pxckdQRitXancvUy9xcy8zNnVwa3VxR21ZSWpweVF6?=
 =?utf-8?B?MlN0bHcrNVl2QWpuc2U0Q0o3NTVYYk5Vdnd6cHpRV3JHejJkM0VIMEdyaVlO?=
 =?utf-8?B?V3l3akFoZGdXUkgzQWM5enBEOHc3S0pZSnV6c25MMGVhbnJqTEJGRlFaQXRs?=
 =?utf-8?B?N3JJanlWNTU2MFBxSGZvWlFEZnN6emtoSFAyTGtzQVhhWmJRN0s5eGNDQVgv?=
 =?utf-8?B?dWVHSEN0Tkh5K1V2aGhXSzY0cVJCNFV5NWZ1MEFlZlRQRURUbW9CWFNrYkZw?=
 =?utf-8?B?TGZCdkxRWE5aVXZrZlozV0NUeVVCM1M3aFJCYVJxbkJOVW5VZ0tncmxNMEZz?=
 =?utf-8?B?bmtKNkt1dzNrWGFYQ0plZ2tyVm9yMEpCUzh0SlgvRVlPZHN2QXJSRHQzbG9x?=
 =?utf-8?B?YmlMbFBidmJBRWg1UFBpSDRMUFB0NVNmRVF0dHFNcnBFZUxNQSsrT2wrenlk?=
 =?utf-8?B?Z3dicU9Ibzhubk13dkllQmZHNFM2ZmtRMnhDVVY1M3g0Y3hoTHkyS1IzclhK?=
 =?utf-8?B?NFZiVE5PYm9iWHpiTy9UcHVwRldZWG0xVFBDK0VIdVJNK2FjQTJWMHdmOWNP?=
 =?utf-8?B?RmFjbGlWV2I1dzhuVUNObmk4eHZIU2V2NEhEY1dqaXI1TXF5RmVLa1MvaFND?=
 =?utf-8?B?M3M3VHJhVkVaeFZNQm51bHpNellSejFmK2w4ZTVWVWV6L2hFdHRibCtRZXlr?=
 =?utf-8?Q?m/UT4orgDtC7yeukw4Wf3Al03Ox1iXvDby+PC/T?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b957a9-dbeb-4ef3-e284-08d967c01163
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 12:01:27.1491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMkOMcG9kx+H03bmIh1PEgOAv+Feyt7QNHz54YLkVC8S0P+ijqWpsweQnttEfK+Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5555
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KSSB0aGluayB3ZSBzaG91bGQgcmVtb3ZlIHRoZSBj
YW5jZWxfZGVsYXllZF93b3JrKCkgaW4gdGhlIGJlZ2lubmluZyBvZiB0aGUgY2xlYW51cF9qb2Io
KS4NCg0KQmVjYXVzZSBieSBteSBwYXRjaCB0aGUgIm1vZGVfZGVsYXllZF93b3JrIiBpbiBjbGVh
bnVwX2pvYiBpcyBhbHJlYWR5IGRvaW5nIGl0cyBkdXR5IHRvIHJldHJpZ2dlciB0aGUgVE8gdGlt
ZXIgYWNjb3JkaW5nbHkgDQoNClRoYW5rcyANCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQpNb25rIExpdSB8IENsb3VkLUdQVSBDb3JlIHRlYW0NCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogTGl1LCBNb25rIA0KU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjUsIDIw
MjEgNzo1NSBQTQ0KVG86ICdDaHJpc3RpYW4gS8O2bmlnJyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtl
bkBnbWFpbC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KU3ViamVjdDogUkU6
IFtQQVRDSF0gZHJtL3NjaGVkOiBmaXggdGhlIGJ1ZyBvZiB0aW1lIG91dCBjYWxjdWxhdGlvbih2
MikNCg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPj5UaGUgdGltZW91dCBzdGFydGVkIGJ5
IHF1ZXVlX2RlbGF5ZWRfd29yaygpIGluIGRybV9zY2hlZF9zdGFydF90aW1lb3V0KCkgaXMgcGFp
cmVkIHdpdGggdGhlIGNhbmNlbF9kZWxheWVkX3dvcmsoKSBpbiBkcm1fc2NoZWRfZ2V0X2NsZWFu
dXBfam9iKCkuDQoNCk5vIHRoYXQncyB3cm9uZywgc2VlIHRoYXQgd2hlbiB3ZSBhcmUgaW4gY2xl
YW51cF9qb2IoKSwgYXNzdW1lIHdlIGRvIG5vdCBoYXZlIHRpbWVvdXQgb24gdGhpcyBzY2hlZCAo
d2UgYXJlIGp1c3Qga2VlcCBzdWJtaXR0aW5nIG5ldyBqb2JzIHRvIHRoaXMgc2NoZWQpLCBUaGVu
IHRoZSB3b3JrX3RkciBpcyBjYW5jZWxsZWQsIGFuZCB0aGVuIHdlIGdldCB0aGUgaGVhZGluZyBq
b2IsIGFuZCBsZXQncyBhc3N1bWUgdGhlIGpvYiBpcyBub3Qgc2lnbmFsZWQsIHRoZW4gd2UgcnVu
IHRvIHRoZSAicXVldWUgdGltZW91dCBmb3IgbmV4dCBqb2IiIHRodXMgZHJtX3NjaGVkX3N0YXJ0
X3RpbWVvdXQoKSBpcyBjYWxsZWQsIHNvIHRoaXMgaGVhZGluZyBqb2IncyBUTyB0aW1lciBpcyBh
Y3R1YWxseSByZXRyaWdnZXJlZCAuLi4gd2hpY2ggaXMgdG90YWxseSB3cm9uZy4NCg0KV2l0aCBt
eSBwYXRjaCB0aGUgdGltZXIgaXMgYWxyZWFkeSByZXRyaWdnZXJlZCBhZnRlciBwcmV2aW91cyBK
T0IgcmVhbGx5IHNpZ25hbGVkLg0KDQpDYW4geW91IGJlIG1vcmUgc3BlY2lmaWMgb24gdGhlIGlu
Y29ycmVjdCBwYXJ0ID8NCg0KVGhhbmtzDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCk1vbmsgTGl1IHwgQ2xvdWQtR1BVIENvcmUgdGVhbQ0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWls
LmNvbT4NClNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDI1LCAyMDIxIDI6MzIgUE0NClRvOiBMaXUs
IE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
U3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL3NjaGVkOiBmaXggdGhlIGJ1ZyBvZiB0aW1lIG91dCBj
YWxjdWxhdGlvbih2MikNCg0KV2VsbCBOQUsgdG8gdGhhdCBhcHByb2FjaC4gRmlyc3Qgb2YgYWxs
IHlvdXIgYnVnIGFuYWx5c2VzIGlzIGluY29ycmVjdC4NCg0KVGhlIHRpbWVvdXQgc3RhcnRlZCBi
eSBxdWV1ZV9kZWxheWVkX3dvcmsoKSBpbiBkcm1fc2NoZWRfc3RhcnRfdGltZW91dCgpIGlzIHBh
aXJlZCB3aXRoIHRoZSBjYW5jZWxfZGVsYXllZF93b3JrKCkgaW4gZHJtX3NjaGVkX2dldF9jbGVh
bnVwX2pvYigpLg0KDQpTbyB5b3UgbXVzdCBoYXZlIHNvbWV0aGluZyBlbHNlIGdvaW5nIG9uIGhl
cmUuDQoNClRoZW4gcGxlYXNlIGRvbid0IHVzZSBtb2RfZGVsYXllZF93b3JrKCksIGluc3RlYWQg
YWx3YXlzIGNhbmNlbCBpdCBhbmQgcmVzdGFydCBpdC4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4N
Cg0KQW0gMjUuMDguMjEgdW0gMDY6MTQgc2NocmllYiBNb25rIExpdToNCj4gdGhlIG9yaWdpbmFs
IGxvZ2ljIGlzIHdyb25nIHRoYXQgdGhlIHRpbWVvdXQgd2lsbCBub3QgYmUgcmV0cmlnZ2VyZCAN
Cj4gYWZ0ZXIgdGhlIHByZXZpb3VzIGpvYiBzaWdhbmxlZCwgYW5kIHRoYXQgbGVhZCB0byB0aGUg
c2NlbmFyaW8gdGhhdCANCj4gYWxsIGpvYnMgaW4gdGhlIHNhbWUgc2NoZWR1bGVyIHNoYXJlcyB0
aGUgc2FtZSB0aW1lb3V0IHRpbWVyIGZyb20gdGhlIA0KPiB2ZXJ5IGJlZ2luaW5nIGpvYiBpbiB0
aGlzIHNjaGVkdWxlciB3aGljaCBpcyB3cm9uZy4NCj4NCj4gd2Ugc2hvdWxkIG1vZGlmeSB0aGUg
dGltZXIgZXZlcnl0aW1lIGEgcHJldmlvdXMgam9iIHNpZ25hbGVkLg0KPg0KPiB2MjoNCj4gZnVy
dGhlciBjbGVhbnVwIHRoZSBsb2dpYywgYW5kIGRvIHRoZSBURFIgdGltZXIgY2FuY2VsbGluZyBp
ZiB0aGUgDQo+IHNpZ25hbGVkIGpvYiBpcyB0aGUgbGFzdCBvbmUgaW4gaXRzIHNjaGVkdWxlci4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogTW9uayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+DQo+IC0tLQ0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jIHwgMjkgKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygr
KSwgOSBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hl
ZHVsZXIvc2NoZWRfbWFpbi5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9t
YWluLmMNCj4gaW5kZXggYTJhOTUzNi4uOGMxMDJhYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3Nj
aGVkdWxlci9zY2hlZF9tYWluLmMNCj4gQEAgLTMwNSw4ICszMDUsMTcgQEAgc3RhdGljIHZvaWQg
ZHJtX3NjaGVkX2pvYl9iZWdpbihzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqc19qb2IpDQo+ICAgCXN0
cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQgPSBzX2pvYi0+c2NoZWQ7DQo+ICAgDQo+ICAg
CXNwaW5fbG9jaygmc2NoZWQtPmpvYl9saXN0X2xvY2spOw0KPiAtCWxpc3RfYWRkX3RhaWwoJnNf
am9iLT5saXN0LCAmc2NoZWQtPnBlbmRpbmdfbGlzdCk7DQo+IC0JZHJtX3NjaGVkX3N0YXJ0X3Rp
bWVvdXQoc2NoZWQpOw0KPiArCWlmIChsaXN0X2VtcHR5KCZzY2hlZC0+cGVuZGluZ19saXN0KSkg
ew0KPiArCQlsaXN0X2FkZF90YWlsKCZzX2pvYi0+bGlzdCwgJnNjaGVkLT5wZW5kaW5nX2xpc3Qp
Ow0KPiArCQlkcm1fc2NoZWRfc3RhcnRfdGltZW91dChzY2hlZCk7DQo+ICsJfSBlbHNlIHsNCj4g
KwkJLyogdGhlIG9sZCBqb2JzIGluIHBlbmRpbmcgbGlzdCBhcmUgbm90IGZpbmlzaGVkIHlldA0K
PiArCQkgKiBubyBuZWVkIHRvIHJlc3RhcnQgVERSIHRpbWVyIGhlcmUsIGl0IGlzIGFscmVhZHkN
Cj4gKwkJICogaGFuZGxlZCBieSBkcm1fc2NoZWRfZ2V0X2NsZWFudXBfam9iDQo+ICsJCSAqLw0K
PiArCQlsaXN0X2FkZF90YWlsKCZzX2pvYi0+bGlzdCwgJnNjaGVkLT5wZW5kaW5nX2xpc3QpOw0K
PiArCX0NCj4gKw0KPiAgIAlzcGluX3VubG9jaygmc2NoZWQtPmpvYl9saXN0X2xvY2spOw0KPiAg
IH0NCj4gICANCj4gQEAgLTY5MywxNyArNzAyLDIyIEBAIGRybV9zY2hlZF9nZXRfY2xlYW51cF9q
b2Ioc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCkNCj4gICAJaWYgKGpvYiAmJiBkbWFf
ZmVuY2VfaXNfc2lnbmFsZWQoJmpvYi0+c19mZW5jZS0+ZmluaXNoZWQpKSB7DQo+ICAgCQkvKiBy
ZW1vdmUgam9iIGZyb20gcGVuZGluZ19saXN0ICovDQo+ICAgCQlsaXN0X2RlbF9pbml0KCZqb2It
Pmxpc3QpOw0KPiArDQo+ICAgCQkvKiBtYWtlIHRoZSBzY2hlZHVsZWQgdGltZXN0YW1wIG1vcmUg
YWNjdXJhdGUgKi8NCj4gICAJCW5leHQgPSBsaXN0X2ZpcnN0X2VudHJ5X29yX251bGwoJnNjaGVk
LT5wZW5kaW5nX2xpc3QsDQo+ICAgCQkJCQkJdHlwZW9mKCpuZXh0KSwgbGlzdCk7DQo+IC0JCWlm
IChuZXh0KQ0KPiArCQlpZiAobmV4dCkgew0KPiArCQkJLyogaWYgd2Ugc3RpbGwgaGF2ZSBqb2Ig
aW4gcGVuZGluZyBsaXN0IHdlIG5lZWQgbW9kaWZ5IHRoZSBURFIgdGltZXIgKi8NCj4gKwkJCW1v
ZF9kZWxheWVkX3dvcmsoc3lzdGVtX3dxLCAmc2NoZWQtPndvcmtfdGRyLCBzY2hlZC0+dGltZW91
dCk7DQo+ICAgCQkJbmV4dC0+c19mZW5jZS0+c2NoZWR1bGVkLnRpbWVzdGFtcCA9DQo+ICAgCQkJ
CWpvYi0+c19mZW5jZS0+ZmluaXNoZWQudGltZXN0YW1wOw0KPiArCQl9IGVsc2Ugew0KPiArCQkJ
LyogY2FuY2VsIHRoZSBURFIgdGltZXIgaWYgbm8gam9iIGluIHBlbmRpbmcgbGlzdCAqLw0KPiAr
CQkJY2FuY2VsX2RlbGF5ZWRfd29yaygmc2NoZWQtPndvcmtfdGRyKTsNCj4gKwkJfQ0KPiAgIA0K
PiAgIAl9IGVsc2Ugew0KPiAgIAkJam9iID0gTlVMTDsNCj4gLQkJLyogcXVldWUgdGltZW91dCBm
b3IgbmV4dCBqb2IgKi8NCj4gLQkJZHJtX3NjaGVkX3N0YXJ0X3RpbWVvdXQoc2NoZWQpOw0KPiAg
IAl9DQo+ICAgDQo+ICAgCXNwaW5fdW5sb2NrKCZzY2hlZC0+am9iX2xpc3RfbG9jayk7DQo+IEBA
IC03OTEsMTEgKzgwNSw4IEBAIHN0YXRpYyBpbnQgZHJtX3NjaGVkX21haW4odm9pZCAqcGFyYW0p
DQo+ICAgCQkJCQkgIChlbnRpdHkgPSBkcm1fc2NoZWRfc2VsZWN0X2VudGl0eShzY2hlZCkpKSB8
fA0KPiAgIAkJCQkJIGt0aHJlYWRfc2hvdWxkX3N0b3AoKSk7DQo+ICAgDQo+IC0JCWlmIChjbGVh
bnVwX2pvYikgew0KPiArCQlpZiAoY2xlYW51cF9qb2IpDQo+ICAgCQkJc2NoZWQtPm9wcy0+ZnJl
ZV9qb2IoY2xlYW51cF9qb2IpOw0KPiAtCQkJLyogcXVldWUgdGltZW91dCBmb3IgbmV4dCBqb2Ig
Ki8NCj4gLQkJCWRybV9zY2hlZF9zdGFydF90aW1lb3V0KHNjaGVkKTsNCj4gLQkJfQ0KPiAgIA0K
PiAgIAkJaWYgKCFlbnRpdHkpDQo+ICAgCQkJY29udGludWU7DQo=
