Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1BBC6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 09:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 362B110E0FD;
	Thu,  2 Mar 2023 09:13:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 317DC10E0FD
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 09:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmCKK1RpKXcRPYX4kik6eH7hnPGoBmd9hfuKGi5/f+FEQaEafojczev2Z1NQaiDh99tksQ+zmXiVkj43q6exMw7hltjlrsLk8NP8HMXNYawwAWEDZNSIFPoeqgea7tYm4nYPCE2V0aHgmBsDomLcPnHkv2MWbHXLhupbbbHNVcB9/z3OjF0YUDWkVIQyB+PFzFnwx490/nEZRxxrC3RNOdIoGwwtstMFTlwu8Ky4wHm0AeOq0BzMSqShcQ/aDS8GSzbIiYXqUy9Q7lmBV4sAqYjYjHMHUReixU2HijwmwtDG3eHjo8mEfn1T7JPKiv3cKknuW0HcoKxnBK4GdFGM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpUKyW7SkXG3ucyCbjGfW9WXw5mvU9NXb6/adWARZLM=;
 b=UY1x4S0qwpRmspHH3IIkW+6TgODuieG5lLwpqnwNRri9t7mey2GrE8+RGKCEE3g1ibWiTzrNjUpp6VlnwJIV5jf3sPfKJL5lsKMhbZRkgHZMhAB8BBKOhAU8Vu0OgUyQzU9035DA9B08FHxVokFd7CZeJKOw6v7XLsHZiijsDEho68lmis78gAht9AjQJh5va/TunfNM1TtZHu1DcAY9YhJ/rvh9kRTXM5wIS2M1JwOkdF+vQFte9m9GexqGO23b9TZTukwZ5oauTcCQnUzLcydB6GLOcKqf9cTj8kbrQB9L86v8LB8BeVqTt5CB3Lg65nY0VRfhfxspGv+W8oE13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpUKyW7SkXG3ucyCbjGfW9WXw5mvU9NXb6/adWARZLM=;
 b=YA2p6HHkmwS5xRkh7LWpzNRM/pnVT0zW8DZRhgzktj+rMCylZkIVa15n0gA2c2YwsAch6pmfAO0z4QUfMyyBDxx8sbujziO01iuyBqxE7DgjqQbTIPyRlw4605ui228cLGVcjOGxeohMDWiY89ArcDoUogYkZQ0fC3/QHucumlo=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 09:13:46 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%5]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 09:13:46 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: disable cstate properly for driver reloading
 scenario
Thread-Topic: [PATCH] drm/amdgpu: disable cstate properly for driver reloading
 scenario
Thread-Index: AQHZTNSN4d29W/wiL0e5VWf8g5wtfK7nKA6AgAALmwA=
Date: Thu, 2 Mar 2023 09:13:46 +0000
Message-ID: <DM6PR12MB26199B972F0D02381059933EE4B29@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230302065835.3905147-1-evan.quan@amd.com>
 <47d45518-bad2-0855-170c-31022ada6dae@amd.com>
In-Reply-To: <47d45518-bad2-0855-170c-31022ada6dae@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-02T09:13:40Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=083a8e0f-27e0-474a-9223-fa4a1611412f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|BL1PR12MB5378:EE_
x-ms-office365-filtering-correlation-id: bbd1326b-a9b5-46e8-0906-08db1afe6d6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xjeHa+Tee8xeTQRK02LW+o8Ov6DZ4yC3+mfTmMXomcnUEPapBr3VqR3xr0iqWfZDNdDdtx3OD0sxg828LW5jWw+1iQWAPS67LJOqIJWrd+udec6Nfy9FTV07AiGpxioKJi/7/YJ+tZZQnpHSBoGC7uanZJwiDAuXEcIFxNp/lBtqZZuCi0FUws3QGM4yXznQsGUmuPxo/FLFVD2XCja1wwEg9Qaq5MKG79R5ucYVzPCjJ5bN0/SeiPJFbsCUR56Gr5bCnlop+4v0YJ3l/kv9Owf5bBkk1BEGacfi5k/xBIip2rnk/pkPt4rcIhLuDS8bjP7/Q25Xta+z84h+GmXLggLjBTdcN96TB3jVg8ktPilQbWIvMTZodf4OdlE1Uj5l+bERt+PGUmdHC9c5H/m/7Q0UcP4468RNAcege86qSGK3r4ft2OUXOrm8rM+wr/vCm6lLPKv4cQJ4u5bjkFa16ZyWGfF7kWJYxRo4lGTAUBNzxppJcmcwPo8IXaXh6zomU2t7JqW8e1V/tLe/SEkZSTVP4W/It24M47BHUIvL7k7D9a43BXQ524XwBSOn/ispj0sCo4llNn/B2QZlH+8uCQkeuJlUrJ3iIm/Ou8SGzFv2QLHMr2yqAKsKX0VB3vLGa/j8sbvRAOatg0R7boAg/64afTWds7ADJbROXRrmhD/4PHdltNlEUm8fdpjg0ccg1VFz3XicrL7d/+5/XBYTTw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199018)(83380400001)(122000001)(71200400001)(5660300002)(478600001)(8936002)(66556008)(33656002)(86362001)(55016003)(52536014)(38070700005)(38100700002)(26005)(186003)(9686003)(53546011)(6506007)(66446008)(66476007)(66946007)(2906002)(76116006)(7696005)(64756008)(8676002)(316002)(4326008)(41300700001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWZuSjRtTnhkbHRLaGxyZDV3aTVLNlc1QmpZRXV0WDlxSkRXYWs1MkRKR04z?=
 =?utf-8?B?VS9CbVJHM3BaMm85KzFMSWRBRjVuZmN4UVFqWGFLY2Vpd3dBTmJiOTRyZmIy?=
 =?utf-8?B?STVhdWN2dWpMWlRoMGJiMHY3NnU1cUlxNmhNOXpMTW01N25zS2N3amg5NEhk?=
 =?utf-8?B?SWZmNzRaMFYrWTZTdFNzV1FBdzRHWDUyQVJQZ0VrS01aVWFLSS9jSWR4VVRs?=
 =?utf-8?B?amt4NVhrMlc5SHVIcDdSYi9KZzdvdXJBVW1qazVxeXQzdzVMUmoxTkJYemE5?=
 =?utf-8?B?czV2K0pUZVNKS093QmdDY2RWOGFONU9zdGg5U1RkOWk3cFVnRkpicjA0aHgr?=
 =?utf-8?B?aGRsZmI4RlViYmxwSEtJM0ZQTDdmbmpnclBwNGdxdklEdDJoUWZJN28xMUVY?=
 =?utf-8?B?UEN1Mi95S0wvT2hvRzVFNGdHaUN3eTlPK3FLQ2s5bTRPd2dQQ0RGSUdFbzNz?=
 =?utf-8?B?aUJkTEZrSzI3UzFieHZmTnI2ZTdyQ2xQMk5mRk41L1pJRHQ2cTRkS2taaHdK?=
 =?utf-8?B?ZEM5YWdjeFBFWUlmbGE3dUxQbkxLV2xaYTJaOHJob3g3K3c1alo4VWI1dmVM?=
 =?utf-8?B?WXpLVFNhbFp1eFpUYWl2NGs5bm9PS3FFeUdWZ1ZIV2F4QzVRd3dWOHJJLys2?=
 =?utf-8?B?TTdWMkwzdndPL0h1L0F4YVZMeStmNkpYUzM2WWQvbS9uVlpYeHZxeGozZWg4?=
 =?utf-8?B?aTNWSStmbkJlbkNwbE9WSDFsMUZJUTNOVkIxRWFkdzhpbDJKeUZHaWRYNzRM?=
 =?utf-8?B?ZndhSk5OK3dHeXBKMVovNFFIVHRTQU1OQWVOT1d4Z29zNk5JdW1iQ21qNndm?=
 =?utf-8?B?UFJjaHRxS2RQZUxNRHNNNmwrQ1ZkbmE5TGgvZVdNV0pEZ2pKeGIwRThCNFMz?=
 =?utf-8?B?TC93cDcxa0wzU0hoWjJUcUNZSzBSMndnR2ZrU0pjSEFia1o2MUp5eVRINGdH?=
 =?utf-8?B?L08rWXBBY2Q3d3ZFM1hZQkczS3F0ZmdMT2xDbG96TFZIcUVveFBRK1JvM0I2?=
 =?utf-8?B?WUdwSU5iM2xJWlFuTVJHZEtwRmRrTHNveWF2SDJremZ5Qlo2bHdHOXNCUHNT?=
 =?utf-8?B?OXFKQW5NNFZ3QzNMZTRNbjl0WVA5QXdwaXc4M1l5OWgxajhvditKTjFTUUtj?=
 =?utf-8?B?S0FCTFl2VmFnQ0JydGxydGhLaE1XdncwLzNFdllnbmg4RDlYSnQzc2xrZ21x?=
 =?utf-8?B?NUVYQXR4bU1kb04wbi9rS1pueFFLOWhHZkRKS2Y3Z3MrNDdjRG9QTWhDemJ3?=
 =?utf-8?B?d1QwcmtOSkZxU3FZY1M4UGg4aE5xNGFsT25xZE54amZDQ1ZsdnJxTnJvaFFX?=
 =?utf-8?B?cGVjRFhQRDdya0pFRmtmdk80WUZKVnFFUXMwY09JT1paTUlGblNRU2R0dzZk?=
 =?utf-8?B?bURLK0p4em9iaEc5czNmbjQ3dHl2SzdvenNZVWE0R2diS1hRY1pzU0dhUlhS?=
 =?utf-8?B?b3RDZGhFWFVXQ2tmeTBzT3crT2d3ejZKSTY4OUp0OTlsNGluTU1TclZKaGt0?=
 =?utf-8?B?R0p5djhVQjU5MVlBUHlYbHdwNXJraUlYVlRybDczaVNMbWQ3UDBKQ1krWVBL?=
 =?utf-8?B?clBmcXBuZHVZL3Z6RzI3RWszQnJiSmVwaks0VkVEKzlEZ2pxaWxrbkwwdFJG?=
 =?utf-8?B?Znlaa2dFWmZtdnN4YStzR3Z2R3J0TVI0VmJldUxnU1FkLzhScGQxL0IyZ2xv?=
 =?utf-8?B?K2wvTUpHclRUTmhtZ21ibXpJRWhBUmlkcE1zVHZ0dTF5MlM1Y3cxNlY2Z0xF?=
 =?utf-8?B?NmNCQmJ0R0Ftb2dKMGlVYkpIQmEwWmlGTk4xSEhsT0NsV1RFdjIxNXdzYmww?=
 =?utf-8?B?UFQ0bnN4VWlLcyszUEZnRDVhaStNaVcweUlsY29PMnJKWW9YM21yVWZ1ZnZL?=
 =?utf-8?B?MW14R3lEV3JxOUxhbzlGTW9DTVpFRmdsVDNDdGd4SkIyR3V3MExDVVgwUTRz?=
 =?utf-8?B?aGkxaENTaUlsNWRMSHM1blE2UVYxdjZBdm5vQUpsV0E3ZTVSUjIwWFBKODM3?=
 =?utf-8?B?UGlMNW40WEM3RllYMjV5cCtKSUNGblluL0NhbXNiaEhRdU1Wa1dNTFZGSDg1?=
 =?utf-8?B?Q1ZXTjNkaHRYaDBnWnRwOTRhc2xxMThCRm1uZnQyMGJ5YnVDQmRBZzhkL2ht?=
 =?utf-8?Q?ltas=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd1326b-a9b5-46e8-0906-08db1afe6d6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 09:13:46.2687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dModfANZuTazCh0uUW4uaIiYgEKdXHwUzvZpL22E5p88hLzrNiEFqLx0VGtDPXAO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyLCAyMDIzIDQ6MjggUE0NCj4gVG86IFF1YW4sIEV2YW4g
PEV2YW4uUXVhbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6
IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogZGlzYWJsZSBjc3RhdGUgcHJvcGVybHkgZm9yIGRy
aXZlcg0KPiByZWxvYWRpbmcgc2NlbmFyaW8NCj4gDQo+IA0KPiANCj4gT24gMy8yLzIwMjMgMTI6
MjggUE0sIEV2YW4gUXVhbiB3cm90ZToNCj4gPiBHcHUgcmVzZXQgbWlnaHQgYmUgbmVlZGVkIGR1
cmluZyBkcml2ZXIgcmVsb2FkaW5nLiBUbyBndWFyZCB0aGF0KGdwdQ0KPiA+IHJlc2V0KSB3b3Jr
LCBkZiBjc3RhdGUgbmVlZHMgdG8gYmUgZGlzYWJsZWQgcHJvcGVybHkuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KPiA+IENoYW5nZS1JZDog
STVjMDc0YzI2NWMwYjA4YTY3YjY5MzRhZTFhZDlhYTNmZWQyNDU0NjENCj4gPiAtLS0NCj4gPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDkgKysrKysrKysr
DQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBpbmRleCA1MWJi
ZWFhMWYzMTEuLjNjODU0NDYxZWYzMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBAQCAtMjgxNiw2ICsyODE2LDE1IEBAIHN0YXRp
YyBpbnQgYW1kZ3B1X2RldmljZV9pcF9maW5pX2Vhcmx5KHN0cnVjdA0KPiBhbWRncHVfZGV2aWNl
ICphZGV2KQ0KPiA+ICAgCWFtZGdwdV9kZXZpY2Vfc2V0X3BnX3N0YXRlKGFkZXYsIEFNRF9QR19T
VEFURV9VTkdBVEUpOw0KPiA+ICAgCWFtZGdwdV9kZXZpY2Vfc2V0X2NnX3N0YXRlKGFkZXYsIEFN
RF9DR19TVEFURV9VTkdBVEUpOw0KPiA+DQo+ID4gKwkvKg0KPiA+ICsJICogR2V0IGRmIGNzdGF0
ZSBkaXNhYmxlZCBwcm9wZXJseSBvbiBkcml2ZXIgdW5sb2FkaW5nLg0KPiA+ICsJICogU2luY2Ug
b24gdGhlIHN1Y2NlZWRpbmcgZHJpdmVyIHJlbG9hZGluZywgZ3B1IHJlc2V0IG1pZ2h0DQo+ID4g
KwkgKiBiZSByZXF1aXJlZC4gQW5kIGNzdGF0ZSBkaXNhYmxlZCBpcyBhIHByZXJlcXVpc2l0ZSBm
b3INCj4gPiArCSAqIHRoYXQoZ3B1IHJlc2V0KS4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKGFtZGdw
dV9kcG1fc2V0X2RmX2NzdGF0ZShhZGV2LCBERl9DU1RBVEVfRElTQUxMT1cpKQ0KPiA+ICsJCWRl
dl93YXJuKGFkZXYtPmRldiwgIkZhaWxlZCB0byBkaXNhbGxvdyBkZiBjc3RhdGUiKTsNCj4gPiAr
DQo+IA0KPiBUaGlzIGxvb2tzIG1vcmUgbGlrZSBhIGZpcm13YXJlIGJ1Zy4gRHJpdmVyIHNlbmRz
IHRoZSBVbmxvYWQgbWVzc2FnZSB0byBGVy4NCj4gSW4gdGhhdCBjYXNlIEZXIHNob3VsZCBkaXNh
YmxlIGFsbCBmZWF0dXJlcyBpbmNsdWRpbmcgQy1zdGF0ZS4NCkRyaXZlciBkb2VzIG5vdCBzZW5k
IHRoZSBVbmxvYWQgbWVzc2FnZS4gV2Ugd2FudCBQTUZNIGFsaXZlIGFuZCByZWFkeSBmb3IgaGFu
ZGxpbmcgcG9zc2libGUgZ3B1IHJlc2V0IG9uIHJlbG9hZGluZy4NCg0KQlINCkV2YW4NCj4gDQo+
IFRoYW5rcywNCj4gTGlqbw0KPiANCj4gPiAgIAlhbWRncHVfYW1ka2ZkX3N1c3BlbmQoYWRldiwg
ZmFsc2UpOw0KPiA+DQo+ID4gICAJLyogV29ya2Fyb3VkIGZvciBBU0lDcyBuZWVkIHRvIGRpc2Fi
bGUgU01DIGZpcnN0ICovDQo=
