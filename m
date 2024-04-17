Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57D3C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 14:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E77010F651;
	Wed, 17 Apr 2024 14:32:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SONcZokC";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B472610EDA7
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 14:32:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHyRb81m2NCTVB28Frwz+nDl83L2rVza4mkm7hkr5+9HJy1RKuheys3yGWcDz4vy947LJDfSqIXsPYfEobEVaZTCkSjajqEjGNvEbCJYGxmMiIbnsYGKdH2u22Bhk5KZNxt7tqBBKqZ8TdZHqW0T7Gwj9r4xTIxt70RXJgY7JRIGN3TbJVdzlg03HZAHpvyTLC45x0E+3YL0FArpgjncuGAGkTBs0XLW4DlNjPfbcBvbE16Mxon/ia8JIGZ4O4FZztfwlvlwVo2wxM+AbsCWVV8g509KlVbgOhPZW3RwbMvKns5xO51aWQCKdfPzn49YEnhjMKPPaMMMwixKbHg8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uF7txsk77+gRSfNkDza2Q8lOcwqqJNdSZOfDpXbpljc=;
 b=RwXrV57b+Z3hKfnGoh5F8fQSLsZrbPxY2Vw2AsQLyTYZK7ADDkKYSQjn6O1oefbzPqj95/NH6kuE36CuJ7F9dH1dWetXRuaEg0iQl/PrKqGVtrUiqZtummhytbf++IrmrOPVki0DIDB9kYxpE6kBZqMOqeC/JCL0yc8SIRy5EbxV2a0Aa8OMUjMt//Pc5GxHbqZT/xHytDu7bl3S8VGKHlGCE6n1uU9WIxJYftsHc/6XfLSalTW+CuWkejp/NfTjlquK6ucMyjitjUnfitPa7icZ7sJWYbyhZg3KcjETzADr3S1mU/UV9ewOOHpXaEbN4sHmWNos7smNpv7/5NKeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uF7txsk77+gRSfNkDza2Q8lOcwqqJNdSZOfDpXbpljc=;
 b=SONcZokC3nElLNzMM6Cmi9JpCN4LJcPVYMq/qJZXCP/K0mLTAWLI75q/+1W9gjfPZ5FWcOQgtB+iU57u5hMpX58ofCYyuzWwA4uN0gcsBIKQilg8Z63/N92zV1CoSTuUXLgT0ENEdQRRVSmEB0ybs1rzGaeRLxwXWGoUjPba+fA=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Wed, 17 Apr
 2024 14:32:37 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::e45c:ba8b:1eac:6dc4]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::e45c:ba8b:1eac:6dc4%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 14:32:37 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Support setting reset_method at
 runtime
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Support setting reset_method at
 runtime
Thread-Index: AQHajKH8jzIAFWg8wUSKRpOvgm25FLFscSWAgAAdR8A=
Date: Wed, 17 Apr 2024 14:32:37 +0000
Message-ID: <PH7PR12MB79885780EFB29A724D7C89679A0F2@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20240412062114.3581242-1-Stanley.Yang@amd.com>
 <c3ad7cc0-8c1a-4371-8087-9327c0e14c20@gmail.com>
In-Reply-To: <c3ad7cc0-8c1a-4371-8087-9327c0e14c20@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=63fff6b2-b146-4797-b546-5fd01e2b81db;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-17T14:30:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|SA1PR12MB6917:EE_
x-ms-office365-filtering-correlation-id: 7b95c3ab-f768-476e-7698-08dc5eeb3a9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6FSuqDvFadpNpwLhV519p2VIQ8mxGVE1i4PyNhsnhMWDLcQp1+VUMRaeLHPvWc72v455bwzUCHKtw8xOWoHHwt5CWwRTaRZcZ+KJuzMmyeOXw4WdWc75aDLaxmFvwlhagDtfJNNNWUb9dxhB0ajIwRGJKjN1YLMumP2MaAwMSVuKqibCtBddDH8+VW+5EOZEBzCibgEhytWIeLBIid28NDR2w/gc3zM1QH0L6R/xYEOslb9wz6sCrQhsZYxHLpy00NrJpBWiIQWk+3A72y+XdJDFwYQ7uacVQXG3ZwlEjKvXMY8JjCori70aDCL5AR3QzHiqNvZM7WQpz31UQFfFZcBL+BVITRhiO2K3L38rTic/5bR7a4MWZK+p4e2WUJ2OP4SrK5sPN+npoVL9o360B8fZ+fk8CJn3Ya2GSPo778m67l1E1DOLs+J6x1LZARzzdnI2G7F2kHML61yfhog8nGKaUSDBldJLVC7zrm7UMprFVDoHrBzmw3Hmoq2Y9JJKtbbhWySP1s18W0slRIGbjnvn/zpaZ3pNlw/IQW+MvFDPr3KneA+Yip+8h8UOEXO1FieCCt9mBiLaXYFGV56q43KnFehfYPwAJtWvhLiq21RsP4rdJ1EDsPJdqXJ+64nXX4Bo51SWxx3AIXY/0zZ698ZoJWFcoSQqaXKxtR5wlLm0+PoFJ5jJiE+z9vF8/5uHQrUEmc4+6dfQerEwxTmFcBeHoWDAJg+P/iY7fmVpS/8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enRhY0YzK2dCYTQyMGdSNnZyeGJUbm5pakdrajZHYjhVRkErblV3SEhaSklm?=
 =?utf-8?B?d1l2cFF4Z3NGMHpjdW1nYjRnOENQb0ViVzZZNkxmaklXN1RvVFFBaFIrSzhj?=
 =?utf-8?B?MHhua0NpTW90aFFJU2FQc1pDRUpoaXFBMm9Oa2Y1VlJmMDNjczZYY3J4cVRl?=
 =?utf-8?B?MjVIN0JSSDFyb0NZOE9wbDVXOHRHNlU1UVdycEZkaDl1emdRdHk4Nm4vSHVF?=
 =?utf-8?B?T1drcitvUDFaNmtVcytESDNuaGRjRFJrOFRLYm4raVN1SllHRThsYkIyUkt4?=
 =?utf-8?B?WEMvemlmelJrMmdFTTJkSzZlWHFnRXB0cWhuTVMvcnVFeG43bm1qUy9LbHhG?=
 =?utf-8?B?Y3FOMkx0SGlVKzluNVNVOTdmR21XOE9RTXl1ZTZhcXVDZGI0U2hTYzVHalhr?=
 =?utf-8?B?TEZkQkpBODBlQWNFa1VQVUhiR2UxRXlmcUhrdFMrUTluZDNxcFA3VE9Td3Q2?=
 =?utf-8?B?R09XbmVEUEIrQUpPM2FmYWxpVTYrRVBXczNZMHVGcTVBZ0dxbHRucTREeVRD?=
 =?utf-8?B?YmdxanYxdzg2OG9rZkxPR3JSaWdGV2R1UlFoa0RDVEdWeFI0Q1V2cTdiTUkz?=
 =?utf-8?B?Q1p1aG1CZi9rVE5tOXZmU1hyYVl1MVFKdEFjSU5pYTY0cUVZYVY3WEVuaWEx?=
 =?utf-8?B?cjEvOW95aEgxMWp6UE5pZGRkM2hqYnFQTzFydlBLS1VndWVoN2VwQm1ZMXNU?=
 =?utf-8?B?U2FmUThRUk5qSjVFaGppVjM1d2FJdm1DZGN6R0JjOElKQ0U4bitFNmNtdlpi?=
 =?utf-8?B?SGF0akhNV2lTUVBZc1krMkpDWW0xaEJOZVFUdzNkNE54aDdwV0FLR2xDQzd6?=
 =?utf-8?B?U3krU3VBV1RqNE8yQzMrM25QeUR0VUhibENFVmNJZWdSMG1GUUVacndtWm5o?=
 =?utf-8?B?Nm1zZnRza0pIODBHdWUvQUJucEY4TVhpRHcrcmZYVEJRUnR6elVQYjFtK0tr?=
 =?utf-8?B?SmpmSTZERFFodEtVb3FPRFdlVE1aOHhrREpCU1REOUJEWDJoNVptWjNvNXc3?=
 =?utf-8?B?enVRalM1RVJhaHMxdjRiaXdEWThFa2dpRUQyQ2VKcnJyMGhmZWI3UlcwQXBt?=
 =?utf-8?B?cjgzTU9mS3p4ckd5eXEvVE9Rd0FicjEwUXJDaGR4NmMyQzJuWWpOYXZJMzZz?=
 =?utf-8?B?RWRsdDhlaS9JRVRwQ2NWbWFrZTZQTVJjcE1NTE1EUWJpak1qM1lvK3FDK1Jp?=
 =?utf-8?B?cEQyamZaOFBicnpYQ2gzQnJBbWk0V3VpSFRQbEE2YS9DTWE3Sy8ydmpBb0c5?=
 =?utf-8?B?QnhyWnRrSllnVXA0WmRNVG1ZeXBDc2xUbFo4Y1ZOWkF5c2FObmU3RURnSXB2?=
 =?utf-8?B?Sk5lL1hZUFlrWkhXdWtOb2xOaVI4UU9YdUZlRi91cTY4ZW1SRUJQV2JPSUtG?=
 =?utf-8?B?MndPMmIvYkpVQ3J1bVBXZVlrTEx2bFdXN05RaW40SFNHUHRpU0R5TnU0RW15?=
 =?utf-8?B?OWl0SHZGWVlod21IS1VJYjEyaXdzVWR2OEJVRzN4MGRtOW1UYUZDU1FiMlpu?=
 =?utf-8?B?ZHZ5amw3dlk0S2ZpNHRNNXZ1V1krR2crd0N3Y2ZrblZHQ0t6dUZodVc2YXVo?=
 =?utf-8?B?QVNsYkhrTXpZY0N2dXQ1Y3l1RnNQNUxrdEcwdytXQ3Vpc0h0UUM4UThsUitk?=
 =?utf-8?B?U0haTysvMUE4dWFmS1dVL2R6ZjRoSVZuSW9CRWVxMXJIMEpwYi83VXQ4c2Rh?=
 =?utf-8?B?ajN2RjJHa2JHK1grUit2cnRuSnRwYXkxVFFWY29oZWxLTVZuSGV3cVBvaHZE?=
 =?utf-8?B?VVE4U3Z5dUdGYitCWE9TdXp3cTVWYStZMFlKY2p2MWl5UjdHZnhDUmJqMnBX?=
 =?utf-8?B?ZGt4blNMQ21TSDd4eDFQeWpPb3lwbTZISXdpeW5sbENBbVZwVW16QkxoTWNw?=
 =?utf-8?B?V1l0N0hjS2J5SUd2cWVOS05pbHhHL0oxZXRlS051TjVXZmJSdTJ5UnFUOFEz?=
 =?utf-8?B?SW9abEM3RStJN2c2OVRqSFlZMVVMRUdXUUZUUjlsbEFXVXp2UmtyRFZPRG5a?=
 =?utf-8?B?T0xHamNvMDRmR244QTBVRGRYTlR5OVBua1hOZk1Vd3o5cTZjVmdmV1d1QXAy?=
 =?utf-8?B?dVlRUzdXZVZFRVdJckh5RWU2cnUydXh1UEhHRFFCWUdDN0JTb0RTVm9DeGJK?=
 =?utf-8?Q?Rq1E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b95c3ab-f768-476e-7698-08dc5eeb3a9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 14:32:37.2681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NEr62inUV9MJtv3upBV9Gs0hIKuYqesPrsTNRtp7/48eELtzlMBquenLSlDOhfFSqCt7/n45/qrit1Q8f5B9Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtl
bkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMTcsIDIwMjQgODo0NiBQTQ0K
PiBUbzogWWFuZywgU3RhbmxleSA8U3RhbmxleS5ZYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJldmlldyAxLzFdIGRybS9h
bWRncHU6IFN1cHBvcnQgc2V0dGluZyByZXNldF9tZXRob2QNCj4gYXQgcnVudGltZQ0KPg0KPiBB
bSAxMi4wNC4yNCB1bSAwODoyMSBzY2hyaWViIFN0YW5sZXkuWWFuZzoNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBTdGFubGV5LllhbmcgPFN0YW5sZXkuWWFuZ0BhbWQuY29tPg0KPg0KPiBZb3UgYXJlIG1p
c3NpbmcgYSBjb21taXQgbWVzc2FnZSwgd2l0aG91dCBpdCB0aGUgcGF0Y2ggd2lsbCBhdXRvbWF0
aWNhbGx5IGJlDQo+IHJlamVjdGVkIHdoZW4geW91IHRyeSB0byBwdXNoIGl0Lg0KDQpUaGFuayB5
b3UgQ2hyaXMsIHdpbGwgYWRkIGl0IGJlZm9yZSBwdXNoLg0KDQpSZWdhcmRzLA0KU3RhbmxleQ0K
DQo+DQo+IFdpdGggdGhhdCBhZGRlZCBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gPiBpbmRleCA4MGI5NjQyZjJiYzQuLjVmNWJmMGMy
NmIxZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZHJ2LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMN
Cj4gPiBAQCAtOTE1LDcgKzkxNSw3IEBAIG1vZHVsZV9wYXJhbV9uYW1lZChmcmVlc3luY192aWRl
bywNCj4gYW1kZ3B1X2ZyZWVzeW5jX3ZpZF9tb2RlLCB1aW50LCAwNDQ0KTsNCj4gPiAgICAqIEdQ
VSByZXNldCBtZXRob2QgKC0xID0gYXV0byAoZGVmYXVsdCksIDAgPSBsZWdhY3ksIDEgPSBtb2Rl
MCwgMiA9IG1vZGUxLA0KPiAzID0gbW9kZTIsIDQgPSBiYWNvKQ0KPiA+ICAgICovDQo+ID4gICBN
T0RVTEVfUEFSTV9ERVNDKHJlc2V0X21ldGhvZCwgIkdQVSByZXNldCBtZXRob2QgKC0xID0gYXV0
bw0KPiA+IChkZWZhdWx0KSwgMCA9IGxlZ2FjeSwgMSA9IG1vZGUwLCAyID0gbW9kZTEsIDMgPSBt
b2RlMiwgNCA9DQo+ID4gYmFjby9iYW1hY28pIik7IC1tb2R1bGVfcGFyYW1fbmFtZWQocmVzZXRf
bWV0aG9kLA0KPiBhbWRncHVfcmVzZXRfbWV0aG9kLA0KPiA+IGludCwgMDQ0NCk7DQo+ID4gK21v
ZHVsZV9wYXJhbV9uYW1lZChyZXNldF9tZXRob2QsIGFtZGdwdV9yZXNldF9tZXRob2QsIGludCwg
MDY0NCk7DQo+ID4NCj4gPiAgIC8qKg0KPiA+ICAgICogRE9DOiBiYWRfcGFnZV90aHJlc2hvbGQg
KGludCkgQmFkIHBhZ2UgdGhyZXNob2xkIGlzIHNwZWNpZmllcyB0aGUNCg0K
