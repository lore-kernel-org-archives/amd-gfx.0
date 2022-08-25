Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F18EC1B0E9
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 15:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7182010E7A4;
	Thu, 25 Aug 2022 15:49:28 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2085.outbound.protection.outlook.com [40.107.96.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F35ED10E7A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 15:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQuK5oxAg6NRLQzVAxJODnqJUfFBumGtyejUIWzcvRR3+F8ejV5IErm+3kDZT1N1KAtEM7dTJBXaIpFG/F08JSEESi39X78Xnx+XfxtE2ifKkGCqmb7WMKg5dyh1DrirORV0e9P8YOMxc4athvVGUnsBGQcQUcdUvXZf72Jy8t/2w+HiRMxrU9PzIQVAj2A9PUn/5Q73h/mLCvnz87lMh2QpXFQgDvxOTlf2Md+wCb0WakL8eDfFxfxjC5utD/fDo10oq4e8at7u1rBUq97KS5sMfHgG+fCuiUGvSEc6IHY3LC/ozjfcLN5BmPipiGPxxlsy4Nff1b3+5gwhUtjPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zywH/+JPdQg+XRmI5HyqCJeeDM8sQ9s8ryNmO6NtvqQ=;
 b=M3GZSut0aJ4Da0aTCYh6sru7geca5sxsRUblNkyXFR+/NTMf4vkFm9K7K9Ema8UMnp4t/yAuz3xPtsMsRtJ6n86R8sv5AP06LbWnRqT+E3lrCdu3yRIpc+q7RblpiAsq9Rs/9D+rIjzqewzDDr5nc4UJVHXBWJCfk5AEyvRaU/yNO+XN6BqPeRNlfK0Jw1vYzyRPhStILsIUCN8/o8ag8bMwv+iHHajWlnJpJnwNkIYdCwvnEPfWQzRXzJ30VbphUUZP1UrLZULSyyZrRRZelEJ2GJcPgB04PXMEPJ0YvotNtR22YiPJsNuwZKWJ6ruW+DBTIzGVA9gbqgcJghgTsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zywH/+JPdQg+XRmI5HyqCJeeDM8sQ9s8ryNmO6NtvqQ=;
 b=vOqUYpPPBKwxp9U0bN80rB5zul97YsWqt9nqGrU7hOfwuPpJ/G9QR3p25htURDz8heSwMj4Qz1LZYSupILMt6KBGT2vSOQ5cPl7kzPPsrjo9uju4Dl0SBcXNWeJff9r/NAwBnO0Si2PnWyES188adSaSfiw8OJ2TpZc7AKFPSAY=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by BYAPR12MB3095.namprd12.prod.outlook.com (2603:10b6:a03:a9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20; Thu, 25 Aug
 2022 15:49:21 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::98a9:195a:29f5:dcc9]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::98a9:195a:29f5:dcc9%6]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 15:49:21 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Fix page table setup on Arcturus
Thread-Topic: [PATCH] drm/amdgpu: Fix page table setup on Arcturus
Thread-Index: AQHYtj8zMk3i2rTxGE2jwEc3+nh4xq2/ocmAgAATPyCAAAxagIAABc6w
Date: Thu, 25 Aug 2022 15:49:20 +0000
Message-ID: <BL3PR12MB64252DCB0A1E033ADD94528AEE729@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20220822155217.911506-1-mukul.joshi@amd.com>
 <CADnq5_OGYxgEVOahp9wAvoVmhHDazhZwERK2s+x-gc43114URg@mail.gmail.com>
 <BL3PR12MB64251CF377D41A059954E76BEE729@BL3PR12MB6425.namprd12.prod.outlook.com>
 <CADnq5_P7p8fwwK5-AEeup6hB3TU8HPNsas28JL5RMJVv_qv4bg@mail.gmail.com>
In-Reply-To: <CADnq5_P7p8fwwK5-AEeup6hB3TU8HPNsas28JL5RMJVv_qv4bg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-25T15:49:19Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8226a47c-cc25-4438-9208-2ca92f790885;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae5dd7b6-e15c-4948-8d8f-08da86b16057
x-ms-traffictypediagnostic: BYAPR12MB3095:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /f7bn7rvkjvvfpi9wZuRxq4omNroKhClL4Y1ngNkUaYuIc8hKsTFYX2HdvNOJ27J8OebSoEGjF/m1KT32YLcc8ctYsRnxbOAqm9nq6bMAoqLM4h1Rd1H5wJ/JyhZ5qzeI6e3c/N9yvEafwzCNlmIZBpnvb4zSUFxKNYluH3yo4tSVL8PGihy4L8a/wFN9EaSzurVKu0IIQg0d2E85HwAjV+KsZ/v6ckJMdR8Ih34+FdnYKvYn8jzXsICREBxUo1GBkm2NWJWYNkUE1FG7unuuqLv7/yivoEBVOJGfUxv/PF1M5YM9P0hMI2Js8WbsbHJ0svrKm33K5AMrqUXM7vGD3xvjtqvEZdskj3RRg/OLWhjq01RalOPJE17Dak3BhONWk0jtUqdauvQL23wKxm4hWUodV356eCfbjpr8tIj3NT/af7UwN2/NFMOoLKfv5oOkkn5k/SPSFgM4NebaFWNJNsSEckGLXjZYhPsCgokdhBt1PX+rKlxMmYiDriwUVXFpPDI6KVia541B5a5dmJsL+2zNOa/o0+6FTcm+GIa9UfG/z2DvtzqrqlgN/Aq1G9ts10p8oN2J9Ppr3qBtrG65KX6qIXkkx+Fh33rO6efOaA5bYESdJ3IzXSi8astgRSKlJcArDsusfW7HaTTemfCPPyimNtQUu+bp99wgVKA8vu4yMLmuqGi8WHjHKPbX2qAxiTC/CbvD5LtaJ9Xcycug8wp3N7DD1XWtIaeYfS0cfxjz4toL4Gt+4s6sCvCPVQ+uXHY42UBNwqrxRdEhFx8Pg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(52536014)(478600001)(9686003)(8936002)(186003)(86362001)(2906002)(7696005)(66946007)(26005)(53546011)(4326008)(76116006)(6506007)(66476007)(8676002)(66556008)(66446008)(64756008)(83380400001)(71200400001)(38100700002)(41300700001)(55016003)(122000001)(5660300002)(38070700005)(33656002)(6916009)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlZBbk9JUHRiV0JyeERZbldYTEZCbFE4amRZOWZJYTBnVFgzdG5va2VOYzdx?=
 =?utf-8?B?Kzk0WitMd0ROMTJUVWsxTWJzZkhTQ2EzaDU0b2lwVkx0d0FVVXRGdXFEMGt4?=
 =?utf-8?B?Q0RpZ2lmdjZ3RWJFeHhHbVJjbW82VFY2YVJrMlJvUTZCZlRIdVpWZEcrbjV6?=
 =?utf-8?B?OHpTdThnMDg4RTNNYlpPZVM1aW9MQVNEajlCMlZyeGpDVjlWckZOeVg1cVdH?=
 =?utf-8?B?bDRuN1dySStaTkxSSFFsNm5VUlNRT2xOemQ0VklKcUVXbmxDelVYNURVNG9P?=
 =?utf-8?B?MTA0Z0JCaHZYZEJYbFVxTTlDQmExMjFHc0owRGdGMTQ2dUFRTmZPazJYdFQ3?=
 =?utf-8?B?VllxL1FkamJlZ2FCbG9UZTNsVjZSQmc4NkppZzE0SEZ5ODRDR0EyK2tMdG1K?=
 =?utf-8?B?S0hXem94RCtnaEFXUEFDdFhaZ28yck5tTVJ0OEpwUERsWFlkVTMvemMvUDRh?=
 =?utf-8?B?dlJxT05CUnhRRjRiRkg5ak5WcXlCS09NTFliY28vZWRFZE1QbVNHYkJxdzlP?=
 =?utf-8?B?RXc5SXZObGNxTkRnSlMzTFgwMkYzZDVpN2pPRmpHVEYra2Rhb0dTRng1M0xW?=
 =?utf-8?B?RHZxNlM1emhIZnFFaGVyKzUzM1I1MXhwa3FVYStLcThLRVQxU1dMWGp6cHNm?=
 =?utf-8?B?MmFXdDZSeUt1RUhuZExRV2JFbUVWN3dkV0M4cEg4SmlLaHBoTjlsVXNTVzVw?=
 =?utf-8?B?ZWJZaXIvYUowYkpjN1h6aTgwd0VKTCs0WEpva1RvZlp3VVpUZ0JJQTlySWZ1?=
 =?utf-8?B?RURtbjVFQzFmck9YWHFZTmRnR0dmbkNSV1Vvcnp1clJhdHhrd3RGUU5PaWRt?=
 =?utf-8?B?WjI3YTRBdlUxZ3dnNllqWEF1TnZCOVpFa3dMWDNqbTBwdW83bWpldFhMQlF4?=
 =?utf-8?B?ZDJqaytwN05XeDRQelZYNFcwUHp6ck9XY0s3bENpYjFUM0c5a3JVc01xVk1L?=
 =?utf-8?B?emdGeTc1cFVQZEhUYkVzUXJkS1hrYVdoemRsdkd5eC9vZ0dUZlEwTEJZa3F2?=
 =?utf-8?B?U3RZaHVLRHNnZU5WSitvZjVKVk9MSmptUENvTW1rTjNjTG9yOHl6L1ZwTUdx?=
 =?utf-8?B?MDFPVGd3SHM0QTJRK1RieWhGK01EL3JHdU4zT2doeHN1RFdKbVVJZER5QzRu?=
 =?utf-8?B?Sm9CQU1DRHJHeUdOVG1LNStQOWxGaVJ4YUtNSmk1Q29iR0VvUlNVT1kvblo2?=
 =?utf-8?B?TWNNTTlJbVNpNlRBcmJtV2VidVM2dEpWUkhtN2NDWmVlK0UrUHNvbGorT3I1?=
 =?utf-8?B?QjZjeHF2b2UzMnpnYlVpenVlMFB2emxOcEtGdnd2OTZ0ZzdGb1RnNnZ6dEpR?=
 =?utf-8?B?a3hLVHF4WFBoYVRqckRYZmR0OUNlTXJxMFdPeSt2NnhMSHF5NXVCNUkxV0ZO?=
 =?utf-8?B?bWpjbjMyTTg5YUZzZzA5bXk5NjFRaCtsYllCSHVjRzluakpFdURWc2sxcC8v?=
 =?utf-8?B?ZldTKzducG9GU1FWN2VPU0p2VDZVOCtZNmV3WFptOEx0NGhzRFAvcUJ5UDNC?=
 =?utf-8?B?UGNUNUliNldIOVlSaTdyeDNCN1F6ZUxPVnh2aDc5MFdjMmFrU3ZGU2hyaElQ?=
 =?utf-8?B?dEErY2U3dGVJWVYwUUV6MENJdkdJN2pQM0FrOGRkdVJrSlBpT3h6K3VNem5M?=
 =?utf-8?B?S2dRd2hyVDVMKzJMZllveG5PUS9PejBmMVl6cTRrdE1GMkc3WU5sUmFhR0dn?=
 =?utf-8?B?WDdWYXhWSXBxbWtTa3c1UC84RG5KRjVMNHRrd0IzdS90ZW9xdTMvZWhWN05k?=
 =?utf-8?B?ZVBjNjFYWnJVeDhSSEJaZTROejN1dktYRXlxZ21abEJJZEJDN3hNUDZIbU05?=
 =?utf-8?B?b0JMUGFnRmdZaTVqcVFKOUtML09SMlc4UG11WnJ6Rk96OTdVbGRxbEJKTFRE?=
 =?utf-8?B?Qnl3RkpSZEQrUWxBK2Z6dCtzQ3dZT2d3V1Qrb1Z1T0hFWUpLcnNLMmwwRUhW?=
 =?utf-8?B?ZEhPNEhVQ3A5RUpNMmV5ZHlKRElJb1REOE1YbW01d0hSRkppVVRRWGZpN2Q5?=
 =?utf-8?B?NTRRbUxOZjhZVEowWUxqY1hOZmhGU1puSG1oOGRRQnBEZjdId01uMEJ6S0xF?=
 =?utf-8?B?OGdsbkM0ZStxWDNydGtwQWd0dGE3WWtaZUEzNkl5YWdUUEFJU1RuN29VR0ts?=
 =?utf-8?Q?AQBA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5dd7b6-e15c-4948-8d8f-08da86b16057
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 15:49:20.9718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3E+8Am3/LIt5/ipPN6xtFYQ5hSUy2pYTvYqwJJ8DHiazbLfSQFLTpRO0j3v4aBq2pqK3t17IS+n4E9bm6ZQMrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3095
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29t
Pg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDI1LCAyMDIyIDExOjI2IEFNDQo+IFRvOiBKb3No
aSwgTXVrdWwgPE11a3VsLkpvc2hpQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBGaXggcGFnZSB0
YWJsZSBzZXR1cCBvbiBBcmN0dXJ1cw0KPiANCj4gW0NBVVRJT046IEV4dGVybmFsIEVtYWlsXQ0K
PiANCj4gT24gVGh1LCBBdWcgMjUsIDIwMjIgYXQgMTA6NDkgQU0gSm9zaGksIE11a3VsIDxNdWt1
bC5Kb3NoaUBhbWQuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9u
bHkgLSBHZW5lcmFsXQ0KPiA+DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiA+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0K
PiA+ID4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAyNSwgMjAyMiA5OjMzIEFNDQo+ID4gPiBUbzog
Sm9zaGksIE11a3VsIDxNdWt1bC5Kb3NoaUBhbWQuY29tPg0KPiA+ID4gQ2M6IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1
OiBGaXggcGFnZSB0YWJsZSBzZXR1cCBvbiBBcmN0dXJ1cw0KPiA+ID4NCj4gPiA+IFtDQVVUSU9O
OiBFeHRlcm5hbCBFbWFpbF0NCj4gPiA+DQo+ID4gPiBPbiBNb24sIEF1ZyAyMiwgMjAyMiBhdCAx
MTo1MyBBTSBNdWt1bCBKb3NoaSA8bXVrdWwuam9zaGlAYW1kLmNvbT4NCj4gPiA+IHdyb3RlOg0K
PiA+ID4gPg0KPiA+ID4gPiBXaGVuIHRyYW5zbGF0ZV9mdXJ0aGVyIGlzIGVuYWJsZWQsIHBhZ2Ug
dGFibGUgZGVwdGggbmVlZHMgdG8gYmUNCj4gPiA+ID4gdXBkYXRlZC4gVGhpcyB3YXMgbWlzc2lu
ZyBvbiBBcmN0dXJ1cyBNTUhVQiBpbml0LiBUaGlzIHdhcyBjYXVzaW5nDQo+ID4gPiA+IGFkZHJl
c3MgdHJhbnNsYXRpb25zIHRvIGZhaWwgZm9yIFNETUEgdXNlci1tb2RlIHF1ZXVlcy4NCj4gPiA+
ID4NCj4gPiA+DQo+ID4gPiBEbyBvdGhlciBtbWh1YiBpbXBsZW1lbnRhdGlvbnMgbmVlZCBhIHNp
bWlsYXIgZml4PyAgSXQgbG9va3MgbGlrZQ0KPiA+ID4gc29tZSBvZiB0aGVtIGFyZSBtaXNzaW5n
IHNpbWlsYXIgY2hhbmdlcy4NCj4gPiA+DQo+ID4NCj4gPiBJIGFtIG5vdCBzdXJlIGlmIHRoZXJl
IGlzIGEgcGxhbiB0byBlbmFibGUgdHJhbnNsYXRlX2Z1cnRoZXIgb24gb3RoZXIgQVNJQ3MuDQo+
ID4gRm9yIG5vdywgaXRzIG9ubHkgZW5hYmxlZCBmb3IgQXJjdHVydXMsIEFsZGViYXJhbiBhbmQg
UmF2ZW4uDQo+ID4gSWYgd2UgcGxhbiB0byBlbmFibGUgaXQgb24gb3RoZXIgQVNJQ3MsIHRoZW4g
eWVzIHRoZSBvdGhlciBtbWh1Yg0KPiA+IGltcGxlbWVudGF0aW9ucyB3b3VsZCBuZWVkIHNpbWls
YXIgY2hhbmdlcy4NCj4gDQo+IEl0IHdvdWxkIGJlIG5pY2UgdG8gZml4IHRoZW0gdXAgcHJlZW1w
dGl2ZWx5IHNvIHRoYXQgaWYgd2UgZXZlciBlbmFibGUgaXQgb24NCj4gYW5vdGhlciBhc2ljLCBp
dCB3aWxsIGp1c3Qgd29yay4NCj4gDQpTdXJlIEkgY2FuIHRha2UgYSBsb29rIGF0IGFsbCBtbWh1
YiBhbmQgZ2Z4aHViIGltcGxlbWVudGF0aW9ucyBhbmQgc2VuZCBvdXQgYSBwYXRjaA0KZm9yIHRo
ZSBvbmVzIHRoYXQgYXJlIG1pc3NpbmcgdGhpcyBwYWdlIHRhYmxlIHNldHVwIGNoYW5nZSB3aGVu
IHRyYW5zbGF0ZV9mdXJ0aGVyIGlzDQplbmFibGVkLg0KDQpSZWdhcmRzLA0KTXVrdWwNCg0KPiBB
bGV4DQo+IA0KPiANCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gTXVrdWwNCj4gPg0KPiA+ID4gQWxl
eA0KPiA+ID4NCj4gPiA+ID4gRml4ZXM6IDJhYmYyNTczYjFjNjkgKCJkcm0vYW1kZ3B1OiBFbmFi
bGUgdHJhbnNsYXRlX2Z1cnRoZXIgdG8NCj4gPiA+ID4gZXh0ZW5kDQo+ID4gPiBVVENMMiByZWFj
aCINCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTXVrdWwgSm9zaGkgPG11a3VsLmpvc2hpQGFtZC5j
b20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1o
dWJfdjlfNC5jIHwgMTIgKysrKysrKysrKy0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYw0KPiA+ID4gPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYw0KPiA+ID4gPiBpbmRleCA2ZTAx
NDViMmI0MDguLjQ0NWNiMDZiOWQyNiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYw0KPiA+ID4gPiBAQCAtMjk1LDkgKzI5NSwxNyBAQCBz
dGF0aWMgdm9pZA0KPiA+ID4gPiBtbWh1Yl92OV80X2Rpc2FibGVfaWRlbnRpdHlfYXBlcnR1cmUo
c3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYsDQo+ID4gPiA+IHN0YXRpYyB2b2lkIG1taHVi
X3Y5XzRfc2V0dXBfdm1pZF9jb25maWcoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gPiA+ICphZGV2
LCBpbnQgaHViaWQpICB7DQo+ID4gPiA+ICAgICAgICAgc3RydWN0IGFtZGdwdV92bWh1YiAqaHVi
ID0gJmFkZXYtDQo+ID52bWh1YltBTURHUFVfTU1IVUJfMF07DQo+ID4gPiA+ICsgICAgICAgdW5z
aWduZWQgaW50IG51bV9sZXZlbCwgYmxvY2tfc2l6ZTsNCj4gPiA+ID4gICAgICAgICB1aW50MzJf
dCB0bXA7DQo+ID4gPiA+ICAgICAgICAgaW50IGk7DQo+ID4gPiA+DQo+ID4gPiA+ICsgICAgICAg
bnVtX2xldmVsID0gYWRldi0+dm1fbWFuYWdlci5udW1fbGV2ZWw7DQo+ID4gPiA+ICsgICAgICAg
YmxvY2tfc2l6ZSA9IGFkZXYtPnZtX21hbmFnZXIuYmxvY2tfc2l6ZTsNCj4gPiA+ID4gKyAgICAg
ICBpZiAoYWRldi0+Z21jLnRyYW5zbGF0ZV9mdXJ0aGVyKQ0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgbnVtX2xldmVsIC09IDE7DQo+ID4gPiA+ICsgICAgICAgZWxzZQ0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgYmxvY2tfc2l6ZSAtPSA5Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICAgICAgICAgZm9y
IChpID0gMDsgaSA8PSAxNDsgaSsrKSB7DQo+ID4gPiA+ICAgICAgICAgICAgICAgICB0bXAgPSBS
UkVHMzJfU09DMTVfT0ZGU0VUKE1NSFVCLCAwLA0KPiA+ID4gbW1WTUwyVkMwX1ZNX0NPTlRFWFQx
X0NOVEwsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHViaWQgKg0K
PiA+ID4gPiBNTUhVQl9JTlNUQU5DRV9SRUdJU1RFUl9PRkZTRVQNCj4gPiA+ID4gKyBpKTsgQEAg
LTMwNSw3ICszMTMsNyBAQCBzdGF0aWMgdm9pZA0KPiA+ID4gbW1odWJfdjlfNF9zZXR1cF92bWlk
X2NvbmZpZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgaW50DQo+IGh1YmlkKQ0KPiA+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFTkFCTEVfQ09OVEVYVCwgMSk7
DQo+ID4gPiA+ICAgICAgICAgICAgICAgICB0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgVk1MMlZD
MF9WTV9DT05URVhUMV9DTlRMLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBQQUdFX1RBQkxFX0RFUFRILA0KPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBhZGV2LT52bV9tYW5hZ2VyLm51bV9sZXZlbCk7DQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG51bV9sZXZlbCk7DQo+ID4gPiA+ICAgICAg
ICAgICAgICAgICB0bXAgPSBSRUdfU0VUX0ZJRUxEKHRtcCwgVk1MMlZDMF9WTV9DT05URVhUMV9D
TlRMLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSQU5HRV9Q
Uk9URUNUSU9OX0ZBVUxUX0VOQUJMRV9ERUZBVUxULCAxKTsNCj4gPiA+ID4gICAgICAgICAgICAg
ICAgIHRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBWTUwyVkMwX1ZNX0NPTlRFWFQxX0NOVEwsDQo+
ID4gPiA+IEBADQo+ID4gPiA+IC0zMjMsNyArMzMxLDcgQEAgc3RhdGljIHZvaWQgbW1odWJfdjlf
NF9zZXR1cF92bWlkX2NvbmZpZyhzdHJ1Y3QNCj4gPiA+IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGlu
dCBodWJpZCkNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRVhF
Q1VURV9QUk9URUNUSU9OX0ZBVUxUX0VOQUJMRV9ERUZBVUxULCAxKTsNCj4gPiA+ID4gICAgICAg
ICAgICAgICAgIHRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBWTUwyVkMwX1ZNX0NPTlRFWFQxX0NO
VEwsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBBR0VfVEFC
TEVfQkxPQ0tfU0laRSwNCj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgYWRldi0+dm1fbWFuYWdlci5ibG9ja19zaXplIC0gOSk7DQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJsb2NrX3NpemUpOw0KPiA+ID4gPiAgICAgICAgICAg
ICAgICAgLyogU2VuZCBuby1yZXRyeSBYTkFDSyBvbiBmYXVsdCB0byBzdXBwcmVzcyBWTSBmYXVs
dCBzdG9ybS4gKi8NCj4gPiA+ID4gICAgICAgICAgICAgICAgIHRtcCA9IFJFR19TRVRfRklFTEQo
dG1wLCBWTUwyVkMwX1ZNX0NPTlRFWFQxX0NOVEwsDQo+ID4gPiA+DQo+ID4gPiA+IFJFVFJZX1BF
Uk1JU1NJT05fT1JfSU5WQUxJRF9QQUdFX0ZBVUxULA0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjM1
LjENCj4gPiA+ID4NCg==
