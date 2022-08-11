Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E900C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 15:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E674B446C;
	Thu, 11 Aug 2022 15:35:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02190B4405
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 15:35:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/SbFI81K/UAcdFcq0XFSckU9ieqiMY4QhfRdCiFDJgoNkrnrmZVilw+Rk/uFuj3Taux8G3L4gHxCNgWlHC1XnV22XcYiag8ijUPrFT7KWJm1wly/LH0J4N0BW+AYJI68atRTWtDhTc5JJ1+R+rOE3zDAzK0k/11tWeRJhlRlLqy6FVwTm3Zs9Cziu2i6GowyeS243HnTdSzokX/VPgkicZFtS9mCXyy7LLicsDRrJQtqMFXctyOLeCr9zj+e0R6h5zI3XflM2C1RvAX9g1UZTeVmM+exrYVVnXrTQ2Yz1cbkbu/Uo73sInoxE49uakklowV/omTBKnhOwRA5YPCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXw9X0Ea9mrIgp7i96biUUSruH0WtBx4UQN327WvfPs=;
 b=BGrIXmg2eTYenEv+cB3/GWfkEYyLrGWJ04IQs1kTqGwjsBpidz51rI1h+X3NZmcUvRQusvnxuE6BZ/oR4HuXSzPSemEnNq/sYsY48m2NBjcseZrG5x4wxfrnzrWitwjMIKloQ0b3E+LSf1ARXy+xkSxF8tPs0kX7sleXp89awkq+FF+bxBWNVECDUWLTY9fKvqI6djgssc7FrybfO5C8OZ7aS6SIxDcLFLzjQQR8+bGx8GLIWenspkpXczXXKo4AXMkqAQjmYLCKKTbrGz9/WPASn6JqJ/bUP/6VbmZI/qpDv8BACdQlf5JL9zs1rLNDBT21A463aDUQy1Ha1ov50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXw9X0Ea9mrIgp7i96biUUSruH0WtBx4UQN327WvfPs=;
 b=WYL4wxM+cVUl30XaUplOPyTxnJs6E1nBAVRHf2amAzQYrIzt/r/uy+xsazTW9eLCbKDaHcXQuctEwbLoxRvoSlXHIVSwD/cTe2J58MC/uk8gdYg2DeYgNeBpRAcAFZOsY4qGT5uDo5p1okcyllP7STrx5AmreAdcTnMMurOJpRg=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 15:35:00 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::eca4:1282:69fe:e20d]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::eca4:1282:69fe:e20d%6]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 15:35:00 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix reset domain xgmi hive info reference leak
Thread-Topic: [PATCH] drm/amdgpu: fix reset domain xgmi hive info reference
 leak
Thread-Index: AQHYrYg5/lW8Mu5bBEiEXbLJ9HcJJa2p0D+AgAAAmDA=
Date: Thu, 11 Aug 2022 15:34:59 +0000
Message-ID: <DM6PR12MB3163B08025CE90BD591C08BB85649@DM6PR12MB3163.namprd12.prod.outlook.com>
References: <20220811134217.138701-1-jonathan.kim@amd.com>
 <78c8501b-fbda-43a9-764b-2176eeff1243@amd.com>
In-Reply-To: <78c8501b-fbda-43a9-764b-2176eeff1243@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ab1641be-11c1-4ba0-909a-09def0b38df2;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-11T15:22:54Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-bromium-msgid: fbf164a1-8547-4985-982b-eabc3aa9bbf3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a950ad6-c41d-4d51-1012-08da7baf0d58
x-ms-traffictypediagnostic: BL1PR12MB5779:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OiCi2IAGugdPy55QfBHz/XjoCnP+6LPRMxlDmxqV7z+2GiZcJtkHKfmMBNa7BfA7eyJE4DaQZtXH5+wwPxT7yiXbDhXdZNLo6aKrvRofGNx+Aj708h2V6aYHyd8UOmyUe1aPLuCk5V0bB2ia2cKilHoZyY+5ZPtRls1eyTUhu3/yrJdzs24Mgh6uyECzIZpy7qtEdYam0QewRhjqamK5v7jKDXFO9ACTn/wE1pGwpLl2q0jsr2hq3lnnqFpbrEfjxYv6oSXlBEeYVJ+K0pk8873e5UeqspaqMSjFBC3wbIsKCLQeQQnfSE1Ay2kvhiZKQjHBCqM/e0hcmqwRtSp7vtWDYIbM83TLcg05eZU1VEE7ARg3ybB/1StTAh+WytwwMyAWJbwYk8yBLDZPtJ0IKLtZyZggmipVZt/Bj5Or9jL8DJ0UnpVb4InCuCfV7LLMl49uAOZnFDzrOo6D1oLWXBt9QAYKkgxg80gxeCGSYfEfZUi3gde+BGraNTp6j7XBEVVYykI9cXYK1CnDFt4tp1uuHklMOkgy/FKvqtX5glq4cp9q6VqwTojPWFF51Mg5zsjiposHDTBjYwZ0Nd0TaRQCUm6vjVKZbdofwJVhbTOEkLZ+/HWEHeQ6YKdZik/Npfl+RjMsGZ9m+CqK823E3SFrXkoX/SYga2cV+l1K5mA4dr3B9isfxCbxnc5fP1v7vS7cwMNyu7JdeEsQXvgOeP6sVTYcwJUnIgrIs7rfk676+RrYguScIWI67dHhdvlc6OXBz1Efo9nCu+TbCwFn0R+vuZCV/9ORqnTzIp7EcXA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(186003)(41300700001)(71200400001)(86362001)(53546011)(6506007)(7696005)(9686003)(26005)(55016003)(83380400001)(110136005)(316002)(4326008)(76116006)(64756008)(66946007)(33656002)(66446008)(66476007)(66556008)(2906002)(5660300002)(478600001)(8936002)(38070700005)(52536014)(8676002)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEdHSzdjaExkUHVPQkV2aHJYbU96em43TGJXVnF1bVM5MXlMbFpvd2Z3WW5r?=
 =?utf-8?B?Ylc4Wkx3aW8wcTNlVE9OeklMTXhvUkFOMUUyZDRQOW5jZnBOTlA1a29OYVFU?=
 =?utf-8?B?dWNzTTYyZWV2b1JrM3FRekZPQi8rWjF3dkhjdWtlUCt2OGlHdUtUbjRpY25O?=
 =?utf-8?B?RytuRi95VlVoZTUvT2VxR2xOQXFkQ3MxZ1lmSEpKcnoxNkhGR0I2WUl5S3hP?=
 =?utf-8?B?VHloTFhjb2tFMmZ0QlNHZUhHbmIycFIvekdYc2NXSkJqdTlmbzA3eXNjWlNO?=
 =?utf-8?B?TTFubUJvZTF1L0VpVkNuQkRSTXJOSnM2V3NlZXRmeXVmWDBJWTBSQy80OWpu?=
 =?utf-8?B?NGNmVjVCKy9KQmFZaktQNXNQRFZFWHk5d1pyZUZybU0xM1NsUWhBaXFZbjNF?=
 =?utf-8?B?MjU2aGFJejBSYzNzUUhlWHgyNGd6TEtwb3dSMFV6ZWthZFRQMHhabUE4SUVU?=
 =?utf-8?B?aGZXUlFPY0hFVVNrZysrWENETU81dHlvdnBiWjlZTG5BZERHMnEycEhEYjlO?=
 =?utf-8?B?VDUxLzlMekhNekNxa3RqSGhtV2hxNU1aeFRSbkR3QWdWRCtXMmVxbE9DbXRF?=
 =?utf-8?B?a2pIbkxZSVpCTGs5cU9sU3FrWlMrdGtjcGN3enVwR3h6cm43alhSSmhZOVpU?=
 =?utf-8?B?MFhOMVVXLzFaVGFtWVRPM292Q2RXQzhxdENmdkNSN2NIVU52VWp2Mk41Y3RZ?=
 =?utf-8?B?Z1hpbk1KZTZyQ2U2a1ZVSHV3VHUrVE96SE81REJJZmxGall2cVhqN1pSZWJ5?=
 =?utf-8?B?QWR5YUMrTE1XTFZ6WkFxZmNBN3RabUVtRUpLRkYxblZ0bUdaOWp1TytrMkJy?=
 =?utf-8?B?bHJuWFBQaFhJc0VqZlY1aXhndGJZcE43S0NQQSs5V2N5NTFPSVR0M3c4eVVj?=
 =?utf-8?B?UG5EYXMvbVFJZWlrdm5LNEVrZGl2ZURicDhyZU5rT3Q0SUFTSjI2QWE5UThz?=
 =?utf-8?B?NWZzRjkzOCtXdlNTVEw4SWo4TWMxZmZUR0NZMy82UlBGZFVEWTNmcXEzamsv?=
 =?utf-8?B?TGxhdlVhQWVpdTZPRm96N0VHYnlGSlNKdklNc011SnpJOFNyL2UvRWNQd0JK?=
 =?utf-8?B?NUJ5S3ZVaWFsamtyN0tRSlJoVUI1T01UeXp5SndzNDVqTWNGbEpsVkV6ZmlP?=
 =?utf-8?B?OExwTytzOE1OclpHdlcyR2RpZmlkd011d0pubHRCOTdHRDkxRENnUmYvQk5o?=
 =?utf-8?B?ZEsrd2VwRUFKUVBsTjczNE4vNlg5MXQySXplVFZBODdMU2ViNXBESXQ3ME5Y?=
 =?utf-8?B?eDZRRHJZVU1GTGcxZmp1VWtKTnBVUlJuMUNOYVhERWYzT3BZNWxuVkxvRW0w?=
 =?utf-8?B?NnpyVG42S1E2SU0wUFhlUFJEWTVraXY2dnd5dk12M3dkK1MyQlErazhhZU1l?=
 =?utf-8?B?REVtOXdXMndjTk9FdHEwK0NjaWs2K2t0UzZMNmlKaXNYQW10QmJZTUhVMjdn?=
 =?utf-8?B?b0ROSmNQN2YvUTNmSEtsMGFGUnRSaHdZYzEvK0ZKZFBJRzdJQ2FGdlk0MkRD?=
 =?utf-8?B?TWtaNjFLMGxvV3hTQmI2elBVTitNTGtZaDBrZ051OVUvdzl3QnlMdnpla09o?=
 =?utf-8?B?cE9mR0hqZ3FFWFUzZFg4MzVKU3diNGNyWXNNa1ZsTTdnNlBma1BjNmJVZ1Jr?=
 =?utf-8?B?S2tUekZJdXJvRWFBcThRUHVhdjhxNnphQnhGczdJcGtEcHV3bFNGaHBIaTJz?=
 =?utf-8?B?dk9ZMlRsMldnQWZHQWdNZ2JqZ29kdDk2YlcrK21ma1BGY3VENFNjQmsrWS85?=
 =?utf-8?B?SE9Udkl2L0VNdExuQlRWY3JoYW1WRjlMV3ViWFZ3WXBMaHUwM1hBVHNyQkx0?=
 =?utf-8?B?eCthMDMyZ3RTaWk1OW1uVXBlNlZmVElWelVrNFo0NkhFSGlBSGRxeEVPUWo4?=
 =?utf-8?B?aTlrYURYZm9vck42YmxhLzV2RFd4YmE2cW9lRlFrazVVVkxYQUtsc0JpbkZT?=
 =?utf-8?B?ZGErOUNGUTJ6ZGJsZmhsdFZSbE5kei9VWTg3MmZzOUxnemtmeGdjamFzbE9a?=
 =?utf-8?B?NDB5WmpjcDhQVlhKVVVFN3BkS2RuNVZBVFNvMm1NYXBHcmN4VXhaTHpiUVNl?=
 =?utf-8?B?aTJzbjg2aXN4dzVjWHlKYzlhNTVxRnpBdzVkOVlKTEhwRlZSNlpKMU1pT1hr?=
 =?utf-8?Q?tQWY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a950ad6-c41d-4d51-1012-08da7baf0d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 15:34:59.9246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A3fTBcYglFb5cYw7/007qcP5JbkX0MzHfnbc4bsowncWv5k8oolalH017uO7E5Po
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdWVobGlu
ZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFNlbnQ6IEF1Z3VzdCAxMSwgMjAy
MiAxMToxOSBBTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IEtpbSwgSm9u
YXRoYW4gPEpvbmF0aGFuLktpbUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0v
YW1kZ3B1OiBmaXggcmVzZXQgZG9tYWluIHhnbWkgaGl2ZSBpbmZvIHJlZmVyZW5jZQ0KPiBsZWFr
DQo+DQo+IEFtIDIwMjItMDgtMTEgdW0gMDk6NDIgc2NocmllYiBKb25hdGhhbiBLaW06DQo+ID4g
V2hlbiBhbiB4Z21pIG5vZGUgaXMgYWRkZWQgdG8gdGhlIGhpdmUsIGl0IHRha2VzIGFub3RoZXIg
aGl2ZQ0KPiA+IHJlZmVyZW5jZSBmb3IgaXRzIHJlc2V0IGRvbWFpbi4NCj4gPg0KPiA+IFRoaXMg
ZXh0cmEgcmVmZXJlbmNlIHdhcyBub3QgZHJvcHBlZCBvbiBkZXZpY2UgcmVtb3ZhbCBmcm9tIHRo
ZQ0KPiA+IGhpdmUgc28gZHJvcCBpdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFu
IEtpbSA8am9uYXRoYW4ua2ltQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jIHwgMyArKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3hnbWkuYw0KPiA+IGluZGV4IDFiMTA4ZDAzZTc4NS4uNTYwYmYxYzk4ZjA4IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMNCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jDQo+ID4gQEAg
LTczMSw2ICs3MzEsOSBAQCBpbnQgYW1kZ3B1X3hnbWlfcmVtb3ZlX2RldmljZShzdHJ1Y3QNCj4g
YW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiAgICAgbXV0ZXhfdW5sb2NrKCZoaXZlLT5oaXZlX2xv
Y2spOw0KPiA+DQo+ID4gICAgIGFtZGdwdV9wdXRfeGdtaV9oaXZlKGhpdmUpOw0KPiA+ICsgICAv
KiBkZXZpY2UgaXMgcmVtb3ZlZCBmcm9tIHRoZSBoaXZlIHNvIHJlbW92ZSBpdHMgcmVzZXQgZG9t
YWluDQo+IHJlZmVyZW5jZSAqLw0KPiA+ICsgICBpZiAoYWRldi0+cmVzZXRfZG9tYWluICYmIGFk
ZXYtPnJlc2V0X2RvbWFpbiA9PSBoaXZlLQ0KPiA+cmVzZXRfZG9tYWluKQ0KPiA+ICsgICAgICAg
ICAgIGFtZGdwdV9wdXRfeGdtaV9oaXZlKGhpdmUpOw0KPg0KPiBUaGlzIGlzIHNvbWUgbWVzc2Vk
IHVwIHJlZmVyZW5jZSBjb3VudGluZy4gSWYgeW91IG5lZWQgYW4gZXh0cmENCj4gcmVmZXJlbmNl
IGZyb20gdGhlIHJlc2V0X2RvbWFpbiB0byB0aGUgaGl2ZSwgdGhhdCBzaG91bGQgYmUgb3duZWQg
YnkgdGhlDQo+IHJlc2V0X2RvbWFpbiBhbmQgZHJvcHBlZCB3aGVuIHRoZSByZXNldF9kb21haW4g
aXMgZGVzdHJveWVkLiBBbmQgaXQncw0KPiBvbmx5IG9uZSByZWZlcmVuY2UgZm9yIHRoZSByZXNl
dF9kb21haW4sIG5vdCBvbmUgcmVmZXJlbmNlIHBlciBhZGV2IGluDQo+IHRoZSByZXNldF9kb21h
aW4uDQoNCkNjJ2luZyBBbmRyZXkuDQoNCldoYXQgeW91J3JlIHNheWluZyBzZWVtcyB0byBtYWtl
IG1vcmUgc2Vuc2UgdG8gbWUsIGJ1dCB3aGF0IEkgZ290IGZyb20gYW4gb2ZmbGluZSBjb252ZXJz
YXRpb24gd2l0aCBBbmRyZXkNCndhcyB0aGF0IHRoZSByZXNldCBkb21haW4gcmVmZXJlbmNlIHBl
ciBkZXZpY2Ugd2FzIGludGVudGlvbmFsLg0KTWF5YmUgQW5kcmV5IGNhbiBjb21tZW50IGhlcmUu
DQoNCj4NCj4gV2hhdCB5b3UncmUgZG9pbmcgaGVyZSBsb29rcyBsaWtlIGV2ZXJ5IGFkZXYgdGhh
dCdzIGluIGEgcmVzZXRfZG9tYWluIG9mDQo+IGl0cyBoaXZlIGhhcyB0d28gcmVmZXJlbmNlcyB0
byB0aGUgaGl2ZS4gQW5kIGlmIHlvdSdyZSBkcm9wcGluZyB0aGUNCj4gZXh0cmEgcmVmZXJlbmNl
IGhlcmUsIGl0IHN0aWxsIGxlYXZlcyB0aGUgcmVzZXRfZG9tYWluIHdpdGggYSBkYW5nbGluZw0K
PiBwb2ludGVyIHRvIGEgaGl2ZSB0aGF0IG1heSBubyBsb25nZXIgZXhpc3QuIFNvIHRoaXMgZXh0
cmEgcmVmZXJlbmNlIGlzDQo+IGtpbmQgb2YgcG9pbnRsZXNzLg0KDQpZZXMuICBDdXJyZW50bHkg
b25lIHJlZmVyZW5jZSBpcyBmZXRjaGVkIGZyb20gdGhlIGRldmljZSdzIGxpZmV0aW1lIG9uIHRo
ZSBoaXZlIGFuZCB0aGUgb3RoZXIgaXMgZnJvbSB0aGUNCnBlci1kZXZpY2UgcmVzZXQgZG9tYWlu
Lg0KDQpTbmlwcGV0IGZyb20gYW1kZ3B1X2RldmljZV9pcF9pbml0Og0KICAgICAgICAvKioNCiAg
ICAgICAgICogSW4gY2FzZSBvZiBYR01JIGdyYWIgZXh0cmEgcmVmZXJlbmNlIGZvciByZXNldCBk
b21haW4gZm9yIHRoaXMgZGV2aWNlDQogICAgICAgICAqLw0KICAgICAgICBpZiAoYWRldi0+Z21j
LnhnbWkubnVtX3BoeXNpY2FsX25vZGVzID4gMSkgew0KICAgICAgICAgICAgICAgIGlmIChhbWRn
cHVfeGdtaV9hZGRfZGV2aWNlKGFkZXYpID09IDApIHsgPC0gW0pLXSByZWZlcmVuY2UgaXMgZmV0
Y2hlZCBoZXJlDQogICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2hpdmVfaW5m
byAqaGl2ZSA9IGFtZGdwdV9nZXRfeGdtaV9oaXZlKGFkZXYpOyA8LSBbSktdIHRoZW4gaGVyZSBh
Z2Fpbg0KDQogICAgICAgICAgICAgICAgICAgICAgICBpZiAoIWhpdmUtPnJlc2V0X2RvbWFpbiB8
fA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICFhbWRncHVfcmVzZXRfZ2V0X3Jlc2V0X2Rv
bWFpbihoaXZlLT5yZXNldF9kb21haW4pKSB7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHIgPSAtRU5PRU5UOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGlu
aXRfZmFpbGVkOw0KICAgICAgICAgICAgICAgICAgICAgICAgfQ0KDQogICAgICAgICAgICAgICAg
ICAgICAgICAvKiBEcm9wIHRoZSBlYXJseSB0ZW1wb3JhcnkgcmVzZXQgZG9tYWluIHdlIGNyZWF0
ZWQgZm9yIGRldmljZSAqLw0KICAgICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X3Jlc2V0X3B1
dF9yZXNldF9kb21haW4oYWRldi0+cmVzZXRfZG9tYWluKTsNCiAgICAgICAgICAgICAgICAgICAg
ICAgIGFkZXYtPnJlc2V0X2RvbWFpbiA9IGhpdmUtPnJlc2V0X2RvbWFpbjsNCiAgICAgICAgICAg
ICAgICB9DQogICAgICAgIH0NCg0KT25lIG9mIHRoZXNlIG5ldmVyIGdldHMgZHJvcHBlZCBzbyBh
IGxlYWsgaGFwcGVucy4NClNvIGVpdGhlciB0aGUgZXh0cmEgcmVmZXJlbmNlIGhhcyB0byBiZSBk
cm9wcGVkIG9uIGRldmljZSByZW1vdmFsIGZyb20gdGhlIGhpdmUgb3IgZnJvbSB3aGF0IHlvdSd2
ZSBtZW50aW9uZWQsDQp0aGUgcmVzZXRfZG9tYWluIHJlZmVyZW5jZSBmZXRjaCBzaG91bGQgYmUg
Zml4ZWQgdG8gZ3JhYiBhdCB0aGUgaGl2ZS9yZXNldF9kb21haW4gbGV2ZWwuDQoNClRoYW5rcywN
Cg0KSm9uDQoNCj4NCj4gUmVnYXJkcywNCj4gICAgRmVsaXgNCj4NCj4NCj4gPiAgICAgYWRldi0+
aGl2ZSA9IE5VTEw7DQo+ID4NCj4gPiAgICAgaWYgKGF0b21pY19kZWNfcmV0dXJuKCZoaXZlLT5u
dW1iZXJfZGV2aWNlcykgPT0gMCkgew0K
