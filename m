Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6557C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 18:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04BFD10F6B0;
	Wed,  1 Jun 2022 18:24:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAD5310F6B0
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 18:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUML43LI01GPIv2K8AlAt15Z/3xVFAH64qwYX9z0f1DhNanrdgGTIJGtlKpyc/dpl0wQQFX9NT3enV3Z+s/u0exrCeNSfZOP66eKRW4Z+HrF5hUGWhCe9G9k5FBhtf2CrGC/SGv9wBt0qoL2gblxR8kfgZ+1SWBbaO5YF+zVDJPz4IUiF5cG+cxVXK2K+yKX+5Fc6yc/iSmMFKEYg3wRQKXCotFLu63BtFr+RnkprystK8lD9LQ02LaONfDnCDGMQXsMrOfQ3X6leRd2+oHhjk+0V1A/AjrwTIZuyGRcDUjqYucCG14/myOgtVDfgcuusYL4voaXlbk4i+c22Un+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmVYhl3BLzXisddSHTOiUAuVdk3WmpoYlH/cSacstNo=;
 b=CkWFdQV2mHTmtvztDYxpjuavvc9VGOcPIvnuInfBpZWFQWNLdk/7WG2rA0qOu93gl1426wGIV+/JUKEiWOICNVxvdSx6tfmA+6LM7jYOyhELPcz7tWUVytU9moqAL42wsP5NbWBEIUuj+jSEefERtCnBV15xaIEvOOscLd+dALP9uKojnnq1M7HzhoIiHMOxPbIoIbE1pf/AF6CsuHSEyIEd501b1avVpZgOIm4yQBJKNSMuE+zjk20kB3zroEl4yqMjMSHJEJnantqrrHgFmSWGddauMT3nIdYVsjPKZKtxI0Aez/wZ36LL5x4LfIsfUrhPxlVl3KGJ9vH1PZ87nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmVYhl3BLzXisddSHTOiUAuVdk3WmpoYlH/cSacstNo=;
 b=L+nuie+5BTs7mreTDr7OF5lq5I8DMdvtYgDtml1K+GntxsLhgsPmJlUvXUGMTme4eO2WeoZu7W+JJyddrQ6vQl37cAF96RudMUgB1yMx8iP+8ulvgY7bKyTs0aEAygMuKQLSTmaizX96ACQESwcbnUt+RheQC3+jwpPGlKsEj/4=
Received: from CY4PR12MB1496.namprd12.prod.outlook.com (2603:10b6:910:10::8)
 by MWHPR12MB1469.namprd12.prod.outlook.com (2603:10b6:301:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 18:23:57 +0000
Received: from CY4PR12MB1496.namprd12.prod.outlook.com
 ([fe80::b802:f477:9024:61a2]) by CY4PR12MB1496.namprd12.prod.outlook.com
 ([fe80::b802:f477:9024:61a2%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 18:23:57 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH v2] drm/amdgpu: Resolve RAS GFX error count issue v2
Thread-Topic: [PATCH v2] drm/amdgpu: Resolve RAS GFX error count issue v2
Thread-Index: AQHYdeD2EbPRQJ2jWk+UO+QhUfCeCq0612MAgAAALgCAAAXO0A==
Date: Wed, 1 Jun 2022 18:23:57 +0000
Message-ID: <CY4PR12MB1496554255E2E051947A05C791DF9@CY4PR12MB1496.namprd12.prod.outlook.com>
References: <20220601175610.28448-1-candice.li@amd.com>
 <CADnq5_NbW5PvP=-VpFY7w1RaUTCM16RS+YoaRft8D5HoGLfsSw@mail.gmail.com>
 <CADnq5_PGWok_hBnYde5uW_g9ynk6cdE5BMzV7fuNkYxPW0rokg@mail.gmail.com>
In-Reply-To: <CADnq5_PGWok_hBnYde5uW_g9ynk6cdE5BMzV7fuNkYxPW0rokg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-01T18:22:34Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=07752e49-0a50-4dbc-aec4-b95abdd54571;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-01T18:23:55Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 5e208264-6aa8-47a6-a8d2-22cce165c77d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8483b327-807a-481d-4c2e-08da43fbe461
x-ms-traffictypediagnostic: MWHPR12MB1469:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1469E6DE66BE464F8AEA74AF91DF9@MWHPR12MB1469.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JXIYMnA5XOnoWvyCELrBJv7+zUBuTO2UEP8zn/TTFwlpMDU9JC2vv4fEGqcEmU1LdEiTd9EZ+l50fFORA3lOuhwKPkLa9IOvctuObeu20vLBNr8OPK9AU1KWMUuoveh8jByKiE+dts0STLdshoSagn1Ol1P/8mQ2i4lpCjCkdsJ4BIQbGreWlJ/XsCS1nhZ4bzwRtEHDlQecxFVt+AYddp6eTRUMtV8ducTt4y0g8bLuTILqBu3ANS9oGhmKyBV+xK9KG3W+DSKg9dMQvzbbTyGMMbQgy3/faSO2Lje+FjkcuMnDdxMZ4BKIeFcQmf/nvn7ELYMBzvCvkyuB2H9TSc0837MFNk5V11RdlwHtOd6p+lQTQIy6O3/qO/qQARLTLUwZmC6YwzuQiRJKe+P2yrh7kMHocdoUk7ngrUkRCfgFaZSdIIGFSxcrcjynfKpYiddEJAfwkPkhnTZUjgx0oaanNancU/b/m1N9H2zbi7CGIxMgkEYz8+k9DzjLOXyl1bhmUARSHPz+f2OEfuOM1Zr8CdXpIoOOQGNbB8VzF3R8ZY4gIyRkfT2ZiFaV5dZaBej69S+oF+mYi4a4UiDtU9nkBeakEmLT54m+kPVHNKmFzsOe230idhdQjdhGty5JVZjK2Xisz5lPacxDftyOSDbTwB8Er1gIuvW8rPARYB5BAjk/HI/xRGi5vgGQ3km3GMkeDNmC070UgreTie1VnQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1496.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(186003)(55016003)(52536014)(8936002)(38070700005)(33656002)(71200400001)(6916009)(86362001)(5660300002)(83380400001)(66946007)(316002)(4326008)(6506007)(8676002)(7696005)(38100700002)(64756008)(66446008)(66556008)(66476007)(76116006)(2906002)(122000001)(508600001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHJmeUNDbzNMVGE4QldkUE9abVNGdDhuSC9sVGw2Z0pjdkk0NjRMVnAvN1hC?=
 =?utf-8?B?L1NDSHZzVXY1MnpVQldsNnV3YXEwU2Zjc3dJZGliSllWcXlMcFZFbjhkQkwv?=
 =?utf-8?B?V2NzaFBLTVh1UUlBbHh3UEJ0Q0NPalNFMENhMHFJb1RXOGFvOXZiMWRvSi9B?=
 =?utf-8?B?bmlQbDF4VlRkTlhJeTlEUTJyWTB5UG0rOXh0N2tOL1FLRHZhaHBVQUU0TlBj?=
 =?utf-8?B?a1d3L0dESzBrT0Z6RXkzaGFkWUpaNmdOTlJpWlNXR2JDdGpGZ3V2OVE0Qm9x?=
 =?utf-8?B?dndwM2NCM1l4b0FMYTFOakdac29iYmJyRll0RzRkRGVoTmpnSXBXanNKNjVq?=
 =?utf-8?B?Tmh1SlZrNmNtZVkrSG9lazJjQTAvWkEwcEJBcHNGYVcvMEwvelJlL2IzYy9v?=
 =?utf-8?B?eHkySGJ3L3FkUldFQVdSc3Bmb0VkbzkwNUk3b3dhQ1ZEL3dFYmJoK213MTJs?=
 =?utf-8?B?OGFENm5GN3VPcG5tbitNeWs2TEZUMnk2aVpOc3NYTFY4Slc0ZjZEcUpnbk40?=
 =?utf-8?B?V1VZUm9kV0dTUlVvbVRWbmtOMTBpSW9uZkpoak1wNVhIb1k0b3V1cGxLWjJ4?=
 =?utf-8?B?cTNIQVBWc1pTMVI4dWVOT0Q4NnNoczFqYWkrKzM1ZDdVeXVIQ3dsVVozSElo?=
 =?utf-8?B?UlRZS2xpN3JXSkw5dTBsVjlMRm1sanJrcnNRV2tPSWkzREtFUE1oblJXY0Jo?=
 =?utf-8?B?TWt1Y0hzaUpPOTV1ZkRYSDMvWkF1UnBzQy8wQXh0eThMSFZJS25VNUxuTk9D?=
 =?utf-8?B?SmRhaGg0cjlJd0lWTHRtV0J1LzRGazYzaEpka0RtTkV3R1RPMVIwTWwzK2sr?=
 =?utf-8?B?bHVOaGJjcUNXcHpDNkMwRlNwbUJyNkZ4bVZKMGJxWnFjaytkRm1rUXdsMUhO?=
 =?utf-8?B?WEhuZzBNajB6UnVPNVdZcDVacTVtRVZSczg2NERKOWYzSHhKd3JuOHMrbE5T?=
 =?utf-8?B?a2NnaUd3VUJVOUVLRnJUYU9UZm5Ya3FLNnVTU0dnUjgranBiVFZUV1hTZ05l?=
 =?utf-8?B?SktxSFdqWnA0SVBzd0g0ZlhBWFpyQzBvRWNHaFhlYVVJNS91UHVjRUk3RWp5?=
 =?utf-8?B?MXNNVUZQSHl1TTZWcFZaU3pVbWVkam83MjAwL3RwcGN3QUI0ZmxWM0xPbTNl?=
 =?utf-8?B?TUJKWXV0NG9LYU5aNE5YU1lvZmRkNDYwclROODFqOG5RaDRYTi9ldGlUdU5Y?=
 =?utf-8?B?NjZuVC9qeit4TE4wNlhjelRxQkI2WHVqQUpLR1NyK3N0TmdLbC8yV1pOci9l?=
 =?utf-8?B?QkprV1dETVlOT00vR2djd003WTlSdTE4T3JiMXBSckpRYnl2U2Z1VCtUM2p5?=
 =?utf-8?B?Yjdkcmt0bUF1TmpzV2NVVWIzUWErcXorS0hicHc4d1lCSXlmUzREYk1GMndl?=
 =?utf-8?B?SFV5QmJndTZ3ODgzb2pDRzlnR2YwWnpmMU0vUUJ3M2xkL3JBS2NpV1lSTE42?=
 =?utf-8?B?aXdPOVBObnJGYUx0WVRtQzZYT2JUSXdWUjEvWnRwWWthdzI0T0V0TXJnWjZu?=
 =?utf-8?B?c0o4SnFqcGd3RVVidyt6RmhvcHQyS0RNVGg1L2xSQVN1VWV0Y0FuNWVybmsr?=
 =?utf-8?B?dGpJRUxISjhRZlcxYW1UZEZiVjljRjQ5MXRNQXlkUjhpSWRRSUlTSVJ4ZFhR?=
 =?utf-8?B?NUtjVWM0QnJGcDI0blFpalFnU21YZzVkT3pjSmRzeVE5MEpHZHdhMVNmQW13?=
 =?utf-8?B?TWdMeXB3OExnZFNjb01DL2VLdXVNczZIZDJWQTJuellXZDI5OVdPMHA1TWtx?=
 =?utf-8?B?NXgxWkFZTWdiTWJYdk9ENEp6OHJJNFdqWkNRcTJvdUNTN09FWUYweVZaSTRl?=
 =?utf-8?B?MXJVbXVYOFQwUXJ5eHVnSDBxNmJuMWpqb1pvajFiazYvM21ka1pPamdyRC9F?=
 =?utf-8?B?Vi9mei9DRDB3QldjdFBTc09nb01JKytHQTRKampTV0ttMjdrYWN3L0VCQk14?=
 =?utf-8?B?QTZTU0tNbGNqSUFGVFdldWErSWJMU0ZsbTJyZWgwdW1QaXh6cEZpZ2lxcHJu?=
 =?utf-8?B?cHNhb1lCWjdPdER5QkNmcS82WHZIeEVYa01tZUU2VmY1MjdNUW92U2tmYVdM?=
 =?utf-8?B?aEdkc0VyMW40NXZTYVN6bmRSL2ZIYWZNZDlYMm9KU1JNOFQyU2hEUFlxaWhs?=
 =?utf-8?B?Wm9EdndjU3ZMLy85T1NNa3o2ZEhsKzEwNjFZTU8vbkxxMGNiWmI1NzAySlhr?=
 =?utf-8?B?bkduQjl3Y1FnaUtpV3BXQndrdHY4YWJqWThWUGRGK041dGtQRkVJRXFIS3RD?=
 =?utf-8?B?QnZBbGVDMUdKc2JYOXdsRXpXSGw0eHB4ZzE2Q1RtOEtUQXE5RDVpWlJQb1VK?=
 =?utf-8?B?L2ZVUnNHUVJXM1g5MFlyNGJiUWZUTmRsdHV6UHVyekQzM1A5QVJVeExQVFZu?=
 =?utf-8?Q?bhQh4WdHZpbclO46gctVcjdi/moMzMmFeROU8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1496.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8483b327-807a-481d-4c2e-08da43fbe461
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 18:23:57.3468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PTBwv0r1uNB9JXhOGYjbSQ/pkRP2PkfIcmuOGu7ZWBmn9YnMV16eF0RoOn650kXo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1469
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcywgYWRkZWQgdGhlIHRh
ZyBiZWZvcmUgcHVzaGluZy4NCg0KDQoNClRoYW5rcywNCkNhbmRpY2UNCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29t
PiANClNlbnQ6IFRodXJzZGF5LCBKdW5lIDIsIDIwMjIgMjowMiBBTQ0KVG86IExpLCBDYW5kaWNl
IDxDYW5kaWNlLkxpQGFtZC5jb20+DQpDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGRybS9hbWRncHU6IFJlc29s
dmUgUkFTIEdGWCBlcnJvciBjb3VudCBpc3N1ZSB2Mg0KDQpPbiBXZWQsIEp1biAxLCAyMDIyIGF0
IDI6MDEgUE0gQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOg0KPg0K
PiBPbiBXZWQsIEp1biAxLCAyMDIyIGF0IDE6NTcgUE0gQ2FuZGljZSBMaSA8Y2FuZGljZS5saUBh
bWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZpeCBtaXNsZWFkaW5nIGluZGVudGF0aW9uIGFuZCBh
ZGQgcmFzIHVuc3VwcG9ydGVkIGNoZWNraW5nDQo+ID4gZm9yIGdmeCByYXMgbGF0ZSBpbml0Lg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2FuZGljZSBMaSA8Y2FuZGljZS5saUBhbWQuY29tPg0K
Pg0KPiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
Pg0KDQpBbHNvLCBpZiB0aGlzIHdhcyBhIHJlY2VudCBjaGFuZ2UsIGEgRml4ZXM6IHRhZyB3b3Vs
ZCBiZSBuaWNlLg0KDQpBbGV4DQoNCj4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dmeC5jIHwgOCArKysrKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nZnguYw0KPiA+IGluZGV4IDk5YzFhMmQzZGFlODRkLi4xNjY5OTE1
OGUwMGQ4YyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ2Z4LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4
LmMNCj4gPiBAQCAtNTk5LDEzICs1OTksMTUgQEAgaW50IGFtZGdwdV9nZnhfcmFzX2xhdGVfaW5p
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IHJhc19jb21tb25faWYgKnINCj4g
PiAgICAgICAgICAgICAgICAgaWYgKCFhbWRncHVfcGVyc2lzdGVudF9lZGNfaGFydmVzdGluZ19z
dXBwb3J0ZWQoYWRldikpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X3Jhc19y
ZXNldF9lcnJvcl9zdGF0dXMoYWRldiwgQU1ER1BVX1JBU19CTE9DS19fR0ZYKTsNCj4gPg0KPiA+
IC0gICAgICAgciA9IGFtZGdwdV9yYXNfYmxvY2tfbGF0ZV9pbml0KGFkZXYsIHJhc19ibG9jayk7
DQo+ID4gLSAgICAgICBpZiAocikNCj4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIHI7DQo+ID4g
KyAgICAgICAgICAgICAgIHIgPSBhbWRncHVfcmFzX2Jsb2NrX2xhdGVfaW5pdChhZGV2LCByYXNf
YmxvY2spOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAocikNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gcjsNCj4gPg0KPiA+ICAgICAgICAgICAgICAgICByID0gYW1kZ3B1X2ly
cV9nZXQoYWRldiwgJmFkZXYtPmdmeC5jcF9lY2NfZXJyb3JfaXJxLCAwKTsNCj4gPiAgICAgICAg
ICAgICAgICAgaWYgKHIpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byBsYXRlX2Zp
bmk7DQo+ID4gKyAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgICAgICBhbWRncHVfcmFz
X2ZlYXR1cmVfZW5hYmxlX29uX2Jvb3QoYWRldiwgcmFzX2Jsb2NrLCAwKTsNCj4gPiAgICAgICAg
IH0NCj4gPg0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0K
