Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0560FEE49B7
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 01:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF3910E0E1;
	Wed, 13 Sep 2023 01:40:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BFA810E0E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 01:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdRzi0+8TuhC8vFO3yEGEM8pkUbt9i+LLuyHfME54Uvtq8xYrPs8iu9ZZrLA8ld3xSVW5FUxRYi9uRe7ZYLLzR3X7y9kgbA+aGte4UNBdVj3qUJZOPOnseXzst8bRiwbImOyfaAesU+VMtDvSXtZIf0waihvm4veYoYSOv+R7aJmPqF5uDUjbxfW1Vud/UsHvrjeyQBLFMFCOW6qSZJ6/cetE6U+lWsnw+v+LFcwr7YTeEQqAn4PmVgrm3ML6obA3UVo6bAkbeTVh4v2BxZGh+ZIxoNRZMNsgEtePLns3jsJpsyrCvxP4UO/I6z25AdhGkhpd3nr4Q2BLrr1F6qEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ur+egjykK/64kbFVi7E0U/Wa5yYOW5cQxQMjRPw4kWw=;
 b=E3nCyh56uMEp2j04Gr8cVnJZWcIQGFGs4yavezt7pfd3QRdCrwRoVK+hUbODBo1YIZDfkoyctKh7Z4P9w1GIWKRKamHXQhsOQH/CEkdhLCqJjwjMwS+As1KNhe6Voz0v2GoZxaf+Wr6DZeVcSav34oR7N6uNgBJANT3ucdyWRp55VLH+e8io1tnXh6OdTn3jo4hJCzn/W91rrF3ffZlBXJYJVc6aohDO7gfZpoJQvK4ByLjaFUZWFBDHSu89j6+RRH1zOzIHabSljGqlCX0ZYRRssQs/bxW1Dzd5ukuyg0pDPLVWjnvhIjErFi1I3cnI/rv4nLMDD9VxROERXKXVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ur+egjykK/64kbFVi7E0U/Wa5yYOW5cQxQMjRPw4kWw=;
 b=11izLR8Zzj1cQ7hUVu7IXq20omqVxOzIUj9wJg3grWTt0Ho4UbPNLzYAhAfX1GJsoeznr2SfYVzFRE/yEWAQ59LRSnMS4eT7Z0WsL2z+Z00D3wOQOuWpXl4c/u00SDuX9KMGy9cTsMER5oPMzUZL3tHB8d6M3hodkyYpaWUYAJc=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.32; Wed, 13 Sep
 2023 01:40:07 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::31b9:4cc2:1b9a:3989]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::31b9:4cc2:1b9a:3989%4]) with mapi id 15.20.6745.030; Wed, 13 Sep 2023
 01:40:06 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix add queue process context clear for hsa
 non-init cases
Thread-Topic: [PATCH] drm/amdkfd: fix add queue process context clear for hsa
 non-init cases
Thread-Index: AQHZ5XMkxEqviQodZ0qOUDkc78dhGrAX6YeAgAAErICAAAKCgIAACd2A
Date: Wed, 13 Sep 2023 01:40:06 +0000
Message-ID: <CY8PR12MB743522967A8A30A9C0FE4A8585F0A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230912121721.3035694-1-Jonathan.Kim@amd.com>
 <97d7d655-66b8-e117-471e-0785affeb660@amd.com>
 <CY8PR12MB7435E5A7985CB9D26AF0D64C85F0A@CY8PR12MB7435.namprd12.prod.outlook.com>
 <7cc164f2-e44d-a96c-4791-4d400ff6e0c5@amd.com>
In-Reply-To: <7cc164f2-e44d-a96c-4791-4d400ff6e0c5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=26908239-0d04-453f-aac4-78cc49914963;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-09-13T01:39:07Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|DS0PR12MB7536:EE_
x-ms-office365-filtering-correlation-id: a493e7ee-19ff-40a4-314b-08dbb3fa5bb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M8Ixn36qn83VzVhEsJPEXmrvOwTjujepx4jwzZihpYAmIiCvZ3zn5V7czn2HrMT25nwfsFKrosOXWDr7dZ3SjhWZQEadD1bJ6jMBktcXyxNOj8pIw+OTepUbR9ByELl5O+gaJO3Lx0AKo09nYf7sHNV5oY8VbARgKm5rr5wvDkWBZG3yQujlMwYUAJf1eTt4Xdi1pEvu0ezHc90EK2eCKMUiGicaIc8qiB6ZYiCtd96z+qozF/q8uXydSpLLGLLPrWIpkGWYQI2mjCc8tby0KJ/xJU6y/yzqQya6MD9AKUyOahEABIvm2BzwnboeDFAbrrwivj/S3EtLeNXUrCGLYg3vc0vBFjQ0K8tC1Q5Es6ZnejyFHu8KMfxooO1zdCe9g+WUG5yQlmBslItBeaVWmf4bcHPm7ADmdUPuUbd2SkSqaCA07ynBJLHg8OfzBsUpHareiZkfTIkUy77cTdj5oL0zJp3bKSoDYAVhomMPDHcSBTDvBc/ToLvxrai1gXTFO2X3u2hbC6pZdtCRS1B1nzp5UJaA6Bm1UvKQ9YDrvocPLQJp925KP79FwU1MmZ2fUoKc0WPEogLCuqOP2+iula6Y2e5QxHOLkQm9B8kD3Yy2g7mheuI0SmShoH5K2wwY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(1800799009)(186009)(451199024)(7696005)(6506007)(71200400001)(53546011)(83380400001)(26005)(478600001)(2906002)(9686003)(66446008)(54906003)(66946007)(66476007)(316002)(66556008)(76116006)(64756008)(41300700001)(8936002)(52536014)(4326008)(8676002)(5660300002)(33656002)(38100700002)(55016003)(86362001)(38070700005)(122000001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmEyaDN5MjhpWm5CWnQzRjltbUp2eVBKZGM1YVF4K0ZZaktZYnJSUzB1NU5Q?=
 =?utf-8?B?MkJYQnF0MDBsRWtWb2NoK1VFUWo5Q2hBcytWMERISVhnVGNPQXlaU2tZYU1h?=
 =?utf-8?B?VzlYTTVOMHpDbDVBSXJDRHhDWDlKVWtRMWcybk1kUm1qTzBwemlXTGRUdDFH?=
 =?utf-8?B?YmNxdVVRRjIrRjE1bXorOVRVenlXcG0zQXM2TG02dnBSWDZyU0RSb0xTOUNH?=
 =?utf-8?B?Q2x6ajZZa2VueWh2M0xkUC9LWURWZ2tXNUxsSFFmZGdVRlBocmN3Q0VybUcz?=
 =?utf-8?B?dEJvZjZEbFZmNjAwZnJJakNIQnJrRmZCdGNMckF1R1BMTEhUZ2FJUXdFUDFC?=
 =?utf-8?B?N0pmeVUxL1JtdjJvUTB0RlZUQ1ZVZ1NqcFYrZGhKZ2ZJL1UzQVZhdGhsVEsv?=
 =?utf-8?B?YVRwbE5hUTJQNmJmMGF3MzNEMnduaXVSa1JMdHBOMVRHeXVjcFg5c0g4Q2g3?=
 =?utf-8?B?WnNKMjhZT3VQR2Rab296RHdYTENweGpqOVc4bTNxSFRsdmxrVnpncGNFZDZY?=
 =?utf-8?B?bzRnN2MvOEhPSFU2SkVWYVl2Q0c1dHM3K3BBMUVZejNJYnUwYUZwR1AxcFpk?=
 =?utf-8?B?cmlocGYreHpOWnc2THFSL3RUa29KQkRGbmZGWGtpU0xkRG54TGlnMkRIZGQy?=
 =?utf-8?B?WStxUEpOQy8xM1dZM0U1ejloc3ZuWTBNdCtIRUFEN0NzR2g3cnJmbWxDanRK?=
 =?utf-8?B?dnRGcVRSenVIM1F0MXFsY3Bhd2c3WkRCak5xNXBNVmlzczNkTHdxNlRsU2xM?=
 =?utf-8?B?RWZtVnU4bVN0a0VaVjBieUxEVnhjVHNGcG9Dc3dFVVVrU1dFcXVLeUFlS3BP?=
 =?utf-8?B?L3Bjd2VzSzhvMW5JcFN2c0k0bDhBblRwNFZhaFg2K2FTTnIwRDQwVFJKcmwv?=
 =?utf-8?B?UUZrNHMxZ2xoZHoyUTQyWnVkVzZqejF1aWJod1FPSWxPT3h0VWRYWE9vSnNB?=
 =?utf-8?B?Z1VzTEN4eldORjlOUTJHRUQxendXaXZPaDU3Wmg0M3pTcmlrZjBCV0ppQkFU?=
 =?utf-8?B?K1JlZ25SVzd0WDNjY3RwbE1jcTRITkMzN25LaTA5TzluUC9vSmFVeDF6VXR2?=
 =?utf-8?B?c0taeTRLVndDSzIxdXhWV0NNOVFrTTFLTGFlSnQ0bkQxN2tYTmdsTjZ0Zkp1?=
 =?utf-8?B?akRMTjNJTG1kbFdxQUhpb2ZDbzd0dnlUZjVyUW1DSkQzaENQazRxaERWSFMx?=
 =?utf-8?B?K1JBZWpQVHNFdzA5SWJEZG5scTNsMUNwUVc2TitSR2dKNzZxaTZJZkhEOG5F?=
 =?utf-8?B?YXM0Yk1JYlpRU3pCbmpjVUIrT3FNejJ1YkNMYU5nMTFmU25FNVkwZndPTjgw?=
 =?utf-8?B?eGtYWFpEaWZNR0R3L2xrVmtENGFHN3V6QlNROVBYN3JZUEp3M1NQU2hjbXEz?=
 =?utf-8?B?cUxYTGloeW0yQ2JnMnFCOGxydlpRdUREeUNCSDZ1dndXZ0tGNjN6WEVmUENo?=
 =?utf-8?B?UW5LR1lpczZIVnVCR2xvVS8rc0xwampFZm1uWmhlRlhwOStXTzJ1NjZlaFdt?=
 =?utf-8?B?bEdpTGovVzRGUDJONXFZb1ZmRS94S3B1Q0MwL2g2RlhkNUxOMVZQL2ZsRWh2?=
 =?utf-8?B?OVdtSU5rRE9kWEpEdWxwU2pscjlHTWMwb1BsTng2RTZzOTlkK2h6K282aWNs?=
 =?utf-8?B?dlJBN0RGaWxjTlh0Z28wNjR0UGdiUTVpSEdOS0hqK2lBWHFHUjVKb1dobjZL?=
 =?utf-8?B?RmFVcGJGaDZBOHF1N0tEOUJVWGpoZlE5am9qc1ptVW9DeEpoZXJ3WEpiNUx0?=
 =?utf-8?B?ejhLSmFUem9leFVwaWdwTE1NOGhkYzA1cXZDcEsybzl5S2Uwa2JHb2xxTTEr?=
 =?utf-8?B?Y2JKZll2aEZ1d3gwQ1lwR3o1OWF2cDYwcFVSUkhhSzg1dDdXakxhYTRGa3Yv?=
 =?utf-8?B?MXRHcTBnblVzY3VVS0REdGdWUXFwRENJRlJzZXMwdXZkWDFtdVIrNFVxczc2?=
 =?utf-8?B?Q1VEVkYvUGRvbHd3WEU3bWlWS2c2SDlJaTRnZityeFcwZU02VkM5S2wvOEhQ?=
 =?utf-8?B?WEwvWDZGTnRvMTJ6ay85K005MmJNY0ZuMmF2Y3RLNDBTWTIyQWxHYkUrZUl4?=
 =?utf-8?B?cFh4V2pVN0FxZjhsdjczRjZIZmJiRkY5MkRRWDVYYnIvTThpa3N3RTgwNmxw?=
 =?utf-8?Q?kIAg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a493e7ee-19ff-40a4-314b-08dbb3fa5bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 01:40:06.4634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ip13BphNuDuEWNkeYQa6wkIeEB+2/W0OnS1XEqmqlKTme6Z3FOH4OJjCZdYvTvnL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536
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
Cc: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>, "Ji,
 Ruili" <Ruili.Ji@amd.com>, "Guo, Shikai" <Shikai.Guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGlu
ZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRl
bWJlciAxMiwgMjAyMyA5OjAxIFBNDQo+IFRvOiBLaW0sIEpvbmF0aGFuIDxKb25hdGhhbi5LaW1A
YW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBKaSwgUnVpbGkg
PFJ1aWxpLkppQGFtZC5jb20+OyBHdW8sIFNoaWthaSA8U2hpa2FpLkd1b0BhbWQuY29tPjsgSHVh
bmcsDQo+IEppbkh1aUVyaWMgPEppbkh1aUVyaWMuSHVhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogZml4IGFkZCBxdWV1ZSBwcm9jZXNzIGNvbnRleHQgY2xl
YXIgZm9yIGhzYQ0KPiBub24taW5pdCBjYXNlcw0KPg0KPiBPbiAyMDIzLTA5LTEyIDIwOjUzLCBL
aW0sIEpvbmF0aGFuIHdyb3RlOg0KPiA+IFtQdWJsaWNdDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGlu
Z0BhbWQuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTIsIDIwMjMgODozNiBQ
TQ0KPiA+PiBUbzogS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+OyBhbWQtDQo+
IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gQ2M6IEppLCBSdWlsaSA8UnVpbGkuSmlA
YW1kLmNvbT47IEd1bywgU2hpa2FpIDxTaGlrYWkuR3VvQGFtZC5jb20+Ow0KPiA+PiBKaW5IdWlF
cmljSHVhbmdAYW1kLmNvbQ0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiBm
aXggYWRkIHF1ZXVlIHByb2Nlc3MgY29udGV4dCBjbGVhciBmb3INCj4gaHNhDQo+ID4+IG5vbi1p
bml0IGNhc2VzDQo+ID4+DQo+ID4+IE9uIDIwMjMtMDktMTIgODoxNywgSm9uYXRoYW4gS2ltIHdy
b3RlOg0KPiA+Pj4gVGhlcmUgYXJlIGNhc2VzIHdoZXJlIEhTQSBpcyBub3QgaW5pdGlhbGl6ZWQg
d2hlbiBhZGRpbmcgcXVldWVzDQo+ID4+IFRoaXMgc3RhdGVtZW50IGRvZXNuJ3QgbWFrZSBzZW5z
ZSB0byBtZS4gSWYgSFNBIGlzIG5vdCBpbml0aWFsaXplZCwgaXQNCj4gPj4gbWVhbnMgdXNlciBt
b2RlIGhhc24ndCBvcGVuZWQgdGhlIEtGRCBkZXZpY2UuIFNvIGl0IGNhbid0IGNyZWF0ZSBxdWV1
ZXMuDQo+ID4+IFdoYXQgZG8geW91IHJlYWxseSBtZWFuIGhlcmU/DQo+ID4gSSBtZWFudCB0aGUg
Y2FsbCB0byBydW50aW1lIGVuYWJsZSBlLmcuIEtGRCB0ZXN0IGNhbiBhZGQgYSBxdWV1ZSB3aXRo
b3V0DQo+IHJ1bnRpbWUgZW5hYmxlIGNhbGwuDQo+DQo+IE9LLCB0aGlzIGNhbiBhbHNvIGhhcHBl
biB3aGVuIHlvdSBydW4gYW4gb2xkZXIgdmVyc2lvbiBvZiB0aGUgSFNBDQo+IHJ1bnRpbWUgdGhh
dCBkb2Vzbid0IHN1cHBvcnQgdGhlIFJPQ20gZGVidWdnZXIgeWV0LiBQbGVhc2UgdXBkYXRlIHRo
ZQ0KPiBwYXRjaCBkZXNjcmlwdGlvbiBhY2NvcmRpbmdseS4NCg0KT2sgd2lsbCBkbyB0aGFua3Mu
ICBTb3JyeSBmb3IgdGhlIGNvbmZ1c2luZyBkZXNjcmlwdGlvbi4NCkZvciBzb21lIHJlYXNvbiBJ
IGZvcmdvdCB0aGF0IEhTQSB3YXMgdW1icmVsbGEgdGVybSBhbmQgZG9lc24ndCBvbmx5IHJlZmVy
IHRvIHRoZSBST0NyIGNvbXBvbmVudC4NCg0KVGhhbmtzLA0KDQpKb24NCg0KPg0KPiBUaGFua3Ms
DQo+ICAgIEZlbGl4DQo+DQo+DQo+ID4NCj4gPiBUaGFua3MsDQo+ID4NCj4gPiBKb24NCj4gPg0K
PiA+PiBSZWdhcmRzLA0KPiA+PiAgICAgRmVsaXgNCj4gPj4NCj4gPj4NCj4gPj4+ICAgIGFuZA0K
PiA+Pj4gdGhlIEFERF9RVUVVRSBBUEkgc2hvdWxkIGNsZWFyIHRoZSBNRVMgcHJvY2VzcyBjb250
ZXh0IGluc3RlYWQgb2YNCj4gPj4+IFNFVF9TSEFERVJfREVCVUdHRVIuDQo+ID4+Pg0KPiA+Pj4g
VGhlIG9ubHkgdGltZSBBRERfUVVFVUUuc2tpcF9wcm9jZXNzX2N0eF9jbGVhciBpcyByZXF1aXJl
ZCBpcyBmb3INCj4gPj4+IGRlYnVnZ2VyIHVzZSBjYXNlcyBhbmQgYSBkZWJ1Z2dlZCBwcm9jZXNz
IGlzIGFsd2F5cyBydW50aW1lIGVuYWJsZWQNCj4gPj4+IHdoZW4gYWRkaW5nIGEgcXVldWUuDQo+
ID4+Pg0KPiA+Pj4gVGVzdGVkLWJ5OiBTaGlrYWkgR3VvIDxzaGlrYWkuZ3VvQGFtZC5jb20+DQo+
ID4+PiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBLaW0gPGpvbmF0aGFuLmtpbUBhbWQuY29tPg0K
PiA+Pj4gLS0tDQo+ID4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNl
X3F1ZXVlX21hbmFnZXIuYyB8IDYgKysrKy0tDQo+ID4+PiAgICAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYw0KPiA+
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5j
DQo+ID4+PiBpbmRleCA2ZDA3YTVkZDI2NDguLjc3MTU5YjAzYTQyMiAxMDA2NDQNCj4gPj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5j
DQo+ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVl
X21hbmFnZXIuYw0KPiA+Pj4gQEAgLTIyNyw4ICsyMjcsMTAgQEAgc3RhdGljIGludCBhZGRfcXVl
dWVfbWVzKHN0cnVjdA0KPiA+PiBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtLCBzdHJ1Y3QgcXVl
dWUgKnEsDQo+ID4+PiAgICAgIHF1ZXVlX2lucHV0LnRiYV9hZGRyID0gcXBkLT50YmFfYWRkcjsN
Cj4gPj4+ICAgICAgcXVldWVfaW5wdXQudG1hX2FkZHIgPSBxcGQtPnRtYV9hZGRyOw0KPiA+Pj4g
ICAgICBxdWV1ZV9pbnB1dC50cmFwX2VuID0gIWtmZF9kYmdfaGFzX2N3c3Jfd29ya2Fyb3VuZChx
LT5kZXZpY2UpOw0KPiA+Pj4gLSAgIHF1ZXVlX2lucHV0LnNraXBfcHJvY2Vzc19jdHhfY2xlYXIg
PSBxcGQtPnBxbS0+cHJvY2Vzcy0NCj4gPj4+IGRlYnVnX3RyYXBfZW5hYmxlZCB8fA0KPiA+Pj4g
LQ0KPiA+PiBrZmRfZGJnX2hhc190dG1wc19hbHdheXNfc2V0dXAocS0+ZGV2aWNlKTsNCj4gPj4+
ICsgICBxdWV1ZV9pbnB1dC5za2lwX3Byb2Nlc3NfY3R4X2NsZWFyID0NCj4gPj4+ICsgICAgICAg
ICAgIHFwZC0+cHFtLT5wcm9jZXNzLT5ydW50aW1lX2luZm8ucnVudGltZV9zdGF0ZSA9PQ0KPiA+
PiBERUJVR19SVU5USU1FX1NUQVRFX0VOQUJMRUQgJiYNCj4gPj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKHFwZC0+cHFtLT5wcm9jZXNzLQ0KPiA+Pj4gZGVi
dWdfdHJhcF9lbmFibGVkIHx8DQo+ID4+PiArDQo+ID4+IGtmZF9kYmdfaGFzX3R0bXBzX2Fsd2F5
c19zZXR1cChxLT5kZXZpY2UpKTsNCj4gPj4+ICAgICAgcXVldWVfdHlwZSA9IGNvbnZlcnRfdG9f
bWVzX3F1ZXVlX3R5cGUocS0+cHJvcGVydGllcy50eXBlKTsNCj4gPj4+ICAgICAgaWYgKHF1ZXVl
X3R5cGUgPCAwKSB7DQo=
