Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7D2C04A68
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 08:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B3C95FD2;
	Thu, 28 Jul 2022 08:38:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 430E695FD2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 08:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cakJ5Uxj8fNcERBOX4ZpD9uKSlimKk4dkaTHS5Wo4tfHHQWcUMbhNU2EhsGdto3m0sjFqNuRoivyGIar0CIsB24SJYvXv1HmwnQ9931sIblbEKwkOGi6MZEjAzcHiIowI2Aelt/4BiF6Typr3Q4zFR791jIJJJMv9mWbxs7TDZxAiWM7o8f7/4m4LFhGD+uzLUpYoLtifhei5Zti7KqPkzr9d3OiDObDTTCKvnCZ56CSDSA4OuH5Ybnc3RoF+DaI6l50dRrkhcCfueG8v5whQWooC5QYTzzC7vyRh8G7X+07iveAzxX7hOy20n92K2BVeO+7cpYnJx1QMsQTGj8Q+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpTZ8CptOv7R45fjjiDvBxmHWnY6fztfVGSgjffV+KA=;
 b=KXRQNYbAH1HzckiTqtwYHcn/we/AhrvLsMXWsp6DfIlsSdQwc0UFd1fmktoajHmwFgEeW4eY2pYnEOb2hcCg5iLS8FomhCOai0t76Yn2Em2yZCZRlowO58X4dD/Jv07ZSR3fPANeJbcmYcaBfpp5WbQ2QnNzthx0TtaJN3auFTHNKCopHRp2llOpb4He5ABSNmIKTTLAWsMguT4LBq5mNygHz7TO1/PyQvhYWDCnAufAUeLGnjmlwEKvwm0kxzx+ZNtgzHDAgf2/f7Q/qFxtnh3f1d5x5CFCzC0XM6FmkuJGFs8bB22RTdM9oNt/eMXa7J4hrqyZfYbhnBGnyjhTxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpTZ8CptOv7R45fjjiDvBxmHWnY6fztfVGSgjffV+KA=;
 b=ru/4b4EHuzIrPPxdgEP4It4wSp1HsbTOx9s5/aBDuoGY01lEnBTDS88plHdogLJsZP9/rpFM3sOWZg5tRiTNZeaUMdsqn1vp4qkaNqou+PxIrm1G1V1IE8EKffc4mEVMpfgMoINA9yRbmIHERtwvQ7rpvnCY86rYecNwqnydooY=
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by BN9PR12MB5365.namprd12.prod.outlook.com (2603:10b6:408:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.22; Thu, 28 Jul
 2022 08:38:18 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::f5ef:8d41:ed3a:7df2]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::f5ef:8d41:ed3a:7df2%6]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 08:38:18 +0000
From: "Du, Xiaojian" <Xiaojian.Du@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: send msg to IMU for the front-door loading
Thread-Topic: [PATCH 1/5] drm/amdgpu: send msg to IMU for the front-door
 loading
Thread-Index: AQHYolBhdwWtrU5ZVE2/U2Pd7IeD/q2Tb2sAgAAFzXA=
Date: Thu, 28 Jul 2022 08:38:18 +0000
Message-ID: <DM4PR12MB513612128400F6869E3FF6D5F1969@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <20220728070419.2485384-1-Xiaojian.Du@amd.com>
 <DM6PR12MB26197587B46A7F479795BC3BE4969@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26197587B46A7F479795BC3BE4969@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-28T08:14:10Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=745eb2d8-695b-40bf-b7af-f21220ee6db2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56ffc1bc-859d-4065-e33a-08da70748561
x-ms-traffictypediagnostic: BN9PR12MB5365:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JCPTkEAGBsOkKOsyiMBzpWccoSkcraYOQfkkR+iZoDD3kuJG05dckaEeEigzj2ea9bpObYXdiy5MLfWHFrHPRi1JJ8riREeALCL5UZW3EgJUFwI1GVsfH+jYGhcx0zdVfot5iuPtrMQs9igB38NlJiCJ4BG/pLq61+m4jez0fKgOBUS8EyoUc+g5V1dbm+0tDbcJbQO4/jxHdODHqxSlTicuh6scJuVz4Mx5UJzp1MJtf5BWd1W3w4HqoP8WO5EhiuDKAlRxsgt8GdvXWXUmSXw0xPJgbSJbO0EdCV6VmuFUDQis0YRPtxY85VtxCr/uaFgNcXoAFcFRYBu8HBEDWABroa3vDDYZSNGYukVcwuxL9WDooAZGvn/qLXJomjTt7gEslBRRUXLwCJD6cyHn/4m004NFo9MGeGwpKNPnkpFGMuUGvqlc+ZxT6sRIqqBL6errxU98jjfM5GNxPx9aCjObuA5qWnn3JrRyhlWHHe7qFTlAqkua/piM8DKbxq/sEaRChF1fuhkBxvn2rDW7T+q5b71+R8Bq3x0cStgFAy85HdhD6JRnGuCFEH+V9Y2MmqIXyvcJTiiSsajnTX5f1HBvGHgFgUi6OImDEKeNMF+zxl71gXiVqAl5rDqvhEy/iYrTwTqQfTs40oU6UrWo4eH3hMjZwiVlmX1kMjCha5R6AWsny2dDzQvIgM13Zp4wSO5opGWz0uD8Nnv3PZpMpByrxSXCdfgzxAhWE+6kln5Ok+5y4yTN5JrjXoh1/GTwTBlHxwJzHaiFfLGWA96jN2/yc88TQ1QQK8H8BDxB1Xw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(478600001)(52536014)(76116006)(53546011)(7696005)(55016003)(86362001)(4326008)(8936002)(186003)(33656002)(5660300002)(122000001)(316002)(71200400001)(110136005)(83380400001)(66446008)(2906002)(6506007)(66476007)(64756008)(8676002)(66946007)(38070700005)(66556008)(54906003)(26005)(38100700002)(9686003)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?b2w3OFVJd1QvVjlpeWNueGpUNUFCZmpTdnBGYm1zU2c5NDFXMThZaVRIRHF0?=
 =?gb2312?B?K3EvVFJyVnQ1MVoxMW5ubjN6WGZ3R2Z5aGJsZnFmSGdoeEhiTDkrVWRvakNS?=
 =?gb2312?B?MGRUZUhKQ2M4NytiSkxsUStqUGtOOHFyRlBseDNOMHVmT0xteUJ2UFdQNWhW?=
 =?gb2312?B?aThMRlM0VnVBSmFRbG16c3Erc0trOUp6Uk5ObVAzMVdxWTVtYlp3eXIvYlpE?=
 =?gb2312?B?MXAzQnZBNm9FaWVRMFVPdndiSDA1bS80QlNZcGhHZzkvOEc5K3RPVlQyQ2pp?=
 =?gb2312?B?dXdFNExOd05jeFh1Z3RqQkZaVFQycGZtT3o2TlJQN1g5Z2dkVWkwckp1VGhh?=
 =?gb2312?B?b0hTWWxCdURoayt1a0NUS1E1T1BZRVNzTnV5N2tMK1VHQVRNYXBHTytvMUFI?=
 =?gb2312?B?ZFpicTNpMlpWSzZMMDRMWDQrU0dUYjkwbzRSNVZES0EySVdpT0tHR3QvNzZx?=
 =?gb2312?B?VzF4ejdOaFdpTkVuajBUa1dML2QvcEF5aGx5a01Tc3BjbXhaZlBDUVFXVkRV?=
 =?gb2312?B?a0NVcmRRNi9FWDNDVUlYQVAyTGE4MHoxK0VkNXRMeXlRc0wwWm4yczBvNEhw?=
 =?gb2312?B?RmZRcTA5QzFWak12U01jYUJYaktnNSt3d0pjWnZPQTFJZ05lT1h1MGE0dHdU?=
 =?gb2312?B?SkZmTGRlWjgzS0c3MG5lOWx5TFhQSGlTRll6ME1pL2l6ZFhHQXpiMTNXMWlE?=
 =?gb2312?B?SmQzdjRoMnprSE9kQ1docm5JaWdhTGxobXlacHd0dzh5UUw5c1RxMG15elNT?=
 =?gb2312?B?OTJKRVRsbFk0cHpVRlIrQ2FRcVJiQ1h0OWdTOThFMllyRFFUSDA5VjIwNCtm?=
 =?gb2312?B?Q2JsYVAyUHRISUZyRmw4WE1HQ3g4K3YxY2djajRabXVOOUJYUmZLaTNTa1Fi?=
 =?gb2312?B?aGVlNXVCQUFteE9aNXZMWFBDZnBvUFVIaXE2OFVIM2Jncm1yTndWOGpscGhh?=
 =?gb2312?B?d09SMGhsSlcvQXVTL0dpRVJhMjlzUE15K1BmRW04YWxYS1doRXJpWG80VGo5?=
 =?gb2312?B?aGE0a3lMZzJGMXFzbjZobzJPdUhJUktrSW5XWDBFZUJyL0swaUw4V0JFRVNK?=
 =?gb2312?B?eHhVVHpZdi9SS0R1L29ya0J4Zy9SRHV4c0t2d2hnMjZXcU1ieWRzZ1hLbXBp?=
 =?gb2312?B?QjZZelRqc0hHdktteWlpRHJlTmNTL1hXeEJXd3crcllJR0pVa25WZGJGc1Ey?=
 =?gb2312?B?ejFXTWpyUUhWVEJNWUNnNCtXYjZFUGZLT0xyWmVZZnJUSGRudlR2aC9uTGJo?=
 =?gb2312?B?V2ZSak94SExiQjBVeVNhenJ6dHRZRDRCWGd0U0ZnbWp1cG9iRU8xZnlBRUhp?=
 =?gb2312?B?M3dsQStObm9uUjczUGVWeVFMcVdiaE5weVB4Q1ZLcTlPaWRWeXBybHFmNGNQ?=
 =?gb2312?B?R1JRdG5oZlk1VmtvdHhFa2RzNTJBRU92OXA0UHZRdTBXdzY3WWJWcHloYkVh?=
 =?gb2312?B?U3h3Y3JhN0tManRPOTlUOWRxWHdjM05Zbk9YQlN2c3VCZHhnMUQyRFhQRWJM?=
 =?gb2312?B?UVZxRnNCMUs0b2xMUHFjbmQ4Skl5YXE0YVlFY1NOeTIvYlFPdnNtSGM5a2Ni?=
 =?gb2312?B?dWFiaTV4MUhEbUN4QzdVckFyV291ZFhyQ1F0cEcrbXJHYWlkMjhFUWF5ZlpC?=
 =?gb2312?B?RndMVlVaZHVBM1RMcHFGN21YREJ2aDJNVFJvUm1rOGljeVdtam40bUx0aTE2?=
 =?gb2312?B?MDVJWkdzeVR3dWhxNVIvQmd4R3BWUFc0anRRMHduVW13WGY2ZWllSlU1OXRJ?=
 =?gb2312?B?YWMxRmpPUUMyMXh3cXR6NUY2L0kwNVVWZUNnejc2OTdrVjRDTXpua0xEekVm?=
 =?gb2312?B?eEFJeTBGQ2JYS2lsY3pCalAwYjFMTjNVUkxLRFBCR2RSWldDNXdwRzNBL2J3?=
 =?gb2312?B?VkprT1ZzOWxUdlp1ZkdJRE9XOTJVUkFUUmNYV2FQNFhXcjlSOUFoLzEzVW1a?=
 =?gb2312?B?RU1QUE5xTkNoMGkvOUdNRkNieWJQbzZGTVVyQTZhS1FnY3d3a2ExTG5hVElq?=
 =?gb2312?B?UmpweU5hcFpuY1I1d2Q1VzZJLzVrZFcxdkhSSUtzSGdZWTZMekp6WnVQNy9Z?=
 =?gb2312?B?RTB6NUg4TitBWGNHM1BXSUE0YTgyL1pHeXRMMThxeDNIOGNsYWRTaDVtdVBi?=
 =?gb2312?Q?9CNoY1XPCwD4cQQ7XIiGJQ00x?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ffc1bc-859d-4065-e33a-08da70748561
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 08:38:18.2180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /eVTvLfr+NFjz7dACun2RnItVLOZgS1JJBCjIz6zsiyD1ZmHMVLlsSipCvEIex56s60a6MjAp/LmL9K2Xc/oFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5365
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T2YgY291cnNlLCBJIHdpbGwgbW92ZSBpdCB1bmRlciAic211LT5pc19hcHUiLiANCg0KVGhhbmtz
LA0KWGlhb2ppYW4NCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUXVhbiwg
RXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+IA0KPlNlbnQ6IDIwMjLE6jfUwjI4yNUgMTY6MTQNCj5U
bzogRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj5DYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgSHVhbmcsIFRpbSA8VGltLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4gPFhp
YW9qaWFuLkR1QGFtZC5jb20+OyBaaGFuZywgWWlmYW4gPFlpZmFuMS5aaGFuZ0BhbWQuY29tPg0K
PlN1YmplY3Q6IFJFOiBbUEFUQ0ggMS81XSBkcm0vYW1kZ3B1OiBzZW5kIG1zZyB0byBJTVUgZm9y
IHRoZSBmcm9udC1kb29yIGxvYWRpbmcNCj4NCj4NCj4NCj4NCj4NCj4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgDQo+PiBYaWFvamlhbiBEdQ0KPj4gU2VudDogVGh1
cnNkYXksIEp1bHkgMjgsIDIwMjIgMzowNCBQTQ0KPj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBh
bWQuY29tPjsgSHVhbmcsIFRpbSANCj4+IDxUaW0uSHVhbmdAYW1kLmNvbT47IER1LCBYaWFvamlh
biA8WGlhb2ppYW4uRHVAYW1kLmNvbT47IFpoYW5nLCBZaWZhbiANCj4+IDxZaWZhbjEuWmhhbmdA
YW1kLmNvbT4NCj4+IFN1YmplY3Q6IFtQQVRDSCAxLzVdIGRybS9hbWRncHU6IHNlbmQgbXNnIHRv
IElNVSBmb3IgdGhlIGZyb250LWRvb3IgDQo+PiBsb2FkaW5nDQo+PiANCj4+IFRoaXMgcGF0Y2gg
d2lsbCBtYWtlIFNNVSBzZW5kIG1zZyB0byBJTVUgZm9yIHRoZSBmcm9udC1kb29yIGxvYWRpbmcs
IA0KPj4gaXQgaXMgcmVxdWlyZWQgYnkgc29tZSBBU0lDcy4NCj4+IA0KPj4gU2lnbmVkLW9mZi1i
eTogWWlmYW4gWmhhbmcgPHlpZmFuMS56aGFuZ0BhbWQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTog
WGlhb2ppYW4gRHUgPFhpYW9qaWFuLkR1QGFtZC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYyB8IDggKysrKysrKysNCj4+ICAxIGZpbGUg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3N3c211L2FtZGdwdV9zbXUuYw0KPj4gaW5kZXggNmQ5YjNjNmFmMTY0Li43OWMwMWZhNGI4
NzUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9z
bXUuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMN
Cj4+IEBAIC0xMzYwLDYgKzEzNjAsMTQgQEAgc3RhdGljIGludCBzbXVfaHdfaW5pdCh2b2lkICpo
YW5kbGUpDQo+PiAgCQlyZXR1cm4gcmV0Ow0KPj4gIAl9DQo+PiANCj4+ICsJaWYgKHNtdS0+cHB0
X2Z1bmNzLT5zZXRfZ2Z4X3Bvd2VyX3VwX2J5X2ltdSkgew0KPj4gKwkJcmV0ID0gc211LT5wcHRf
ZnVuY3MtPnNldF9nZnhfcG93ZXJfdXBfYnlfaW11KHNtdSk7DQo+PiArCQlpZiAocmV0KSB7DQo+
PiArCQkJZGV2X2VycihhZGV2LT5kZXYsICJGYWlsZWQgdG8gRW5hYmxlIGdmeCBpbXUhXG4iKTsN
Cj4+ICsJCQlyZXR1cm4gcmV0Ow0KPj4gKwkJfQ0KPj4gKwl9DQo+W1F1YW4sIEV2YW5dIFBlciBt
eSB1bmRlcnN0YW5kaW5ncywgdGhpcyBzaG91bGQgYmUgbmVlZGVkIGJ5IEFQVSBvbmx5LiBDYW4g
eW91IG1vdmUgdGhpcyB1bmRlciAic211LT5pc19hcHUiIGNvbnRyb2wgYXMgb3RoZXIgZmVhdHVy
ZXMgYmVsb3c/DQo+DQo+RXZhbg0KPj4gKw0KPj4gIAlpZiAoc211LT5pc19hcHUpIHsNCj4+ICAJ
CXNtdV9kcG1fc2V0X3Zjbl9lbmFibGUoc211LCB0cnVlKTsNCj4+ICAJCXNtdV9kcG1fc2V0X2pw
ZWdfZW5hYmxlKHNtdSwgdHJ1ZSk7DQo+PiAtLQ0KPj4gMi4yNS4xDQo+DQo=
