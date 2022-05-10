Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88669C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 19:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1914210E341;
	Tue, 10 May 2022 19:37:01 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C93810E341
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 19:36:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZc87LoHkbv3SeLpE+5anIx7Mt1xkr755UUl7CrONeSO6vRXvAuY/K67k+4rtI8YmytZODo3f3Iar58TClybtpvEjtZnm04G/VOPuITDL6f4LYXAJBj8XDX4cIuvtGEfvXBllnNM2YHqSbD1zpJky7qbMg48IZD2TkY86BGEfmXDB/lbtRYqkqpfB/TetMP3jcPUgfyL3B+BVPaNedtUS8E8eoeosOVqYtF74ZWPWdjipQ5JYyXK3fTxu0qsZDUYETvs1H5uorcM7pvnmfsdSBXECZv3BaRJxXRwlAGJCk0HLAFKFQIRPfA17QrZ+q5DnW1J3JcfYb8Ef+rZywoGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99psJsPf5qY5W2JK9PTxYN03F+KhSShSdH4hpTYNG/U=;
 b=ScoIo8w9q9Qxfz1xp0geO+WuKyEx6GG/1F4guznTaOTc0LiWH4k1wDZ1UJepPsbswwSjoYErdEd1ecEZc2c62aoHi5N10BpV5q1zolYxMoGn6Yn4mupg56V2TmV1reRyHvNbNsAU3F3Zo70YOdkA/3k+rU+7B14X5TCbNQ9/NpBH2oxaejjDr1TIUjxFiWP83wbVa2DYg+5Rl+XHbJ5Ay+h1E/hsoAy2VBZRkSK/M4MLpmc9LbZ1fIDQ5cgRUmgVxD2+gCC0Uy4Y2EtlhwdWE+jJePzYiCNGACR3R35uQ3biUpvOn/T5fz9HiTAIckYfouWoWI9z00S1v69xWTEZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99psJsPf5qY5W2JK9PTxYN03F+KhSShSdH4hpTYNG/U=;
 b=ervjAWSMMUBnO/2jB4Z8M+ta/6y8mbNeVVpha5ih0hE+CuumJXvCTgWb47AZEQFZTorQUXbL5R6/WkD2yOhAtTTXRPXBhhPzBn4tdHlGmNxnQOoM1voU83gf64Sz8EyRY34s6KJqSeoGa6gQOZ6HJntDPgQXmUktMAPLOHK7NUs=
Received: from CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15)
 by DM5PR1201MB0076.namprd12.prod.outlook.com (2603:10b6:4:55::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 19:36:57 +0000
Received: from CY5PR12MB6155.namprd12.prod.outlook.com
 ([fe80::dcfe:d9f5:9d16:5258]) by CY5PR12MB6155.namprd12.prod.outlook.com
 ([fe80::dcfe:d9f5:9d16:5258%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 19:36:57 +0000
From: "Swarnakar, Praful" <Praful.Swarnakar@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix incorrectly reading prev_dppclk
Thread-Topic: [PATCH] drm/amd/display: Fix incorrectly reading prev_dppclk
Thread-Index: AQHYZJyo7YVTppt9/k+W5xtaAm1CX60YcQOAgAAMlOA=
Date: Tue, 10 May 2022 19:36:56 +0000
Message-ID: <CY5PR12MB6155EA1F86A04C518119A0318FC99@CY5PR12MB6155.namprd12.prod.outlook.com>
References: <20220510183431.895489-1-Bhawanpreet.Lakha@amd.com>
 <33674196-4054-c626-4ea8-19797f3679ff@amd.com>
In-Reply-To: <33674196-4054-c626-4ea8-19797f3679ff@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-10T19:26:04Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=eeaf9938-88a0-4ed5-b845-bee2d51aaa27;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-05-10T19:36:53Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: eda72d24-6e58-45b9-986e-948a15d97d5b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e8e5b33-786d-4053-9826-08da32bc71c6
x-ms-traffictypediagnostic: DM5PR1201MB0076:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB0076F1752C95E93058822A798FC99@DM5PR1201MB0076.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yd42XqvUq45S2gmEUBlZuXiFr0pxR6Sy/UbpuHdWe77dqZ5+Xheqgxkok4QclXfuMDMcSNtiYRwoGMkvr7ekpekJCJ6zhdrdYHffIUtjMdv60QErmB8mHaJ+lghDy1q3PvWWI0KnE7EfyS1jL8Ppz7tPb+aTi4mc6Ct1M6dcCynPLtJmTOS/285uasD2bG10r7fWYZWBoFVwMVc4Z9x1nsqL612K9/aqCoQkhVeXLcn1apoSY052EvgY1uq0rU4dN3SuuFb6FB2stsuax3dw/FX/YBCBrwpbQ4A6/n/f2d/2A4FMgUukRc7tW0akmdw3jrtgPF/jim34iqrJ1iGgC9s/OUymx3eWsjWOVhv/FYAP7+roKZz3nsF0rOgtoFZLLLyllw+/U0bnkjQzgfNmgAC9o4QPmE5JIUuy/AVLpU4t23P9/606eWCbg7MxHENlid/MdNDjOAiYQ13bHYclD5kz3zGUyImxbSXVyhIMEyRH3IrGQ+GLARPlnyOJvH8X7lO6cIQk479Poy9WA6mBNSF5zmDfb3mvj1Yr1lHSWLEbmeNmkvKnP2nhkgBEVTGFVUps2kUo0yV6ypjSdW/eVXrchX1fK/ebdg/6f+36OyfkldJb+EmDezMvqHI0YDTaDQ5oyaN9VyJAV2Qprq6XLqKkWF54/0HudRU+LuaAGD2R6Bi6cbpcHHovVCxDEmtl3sh3ink0oDzx9d4tn7yo6Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6155.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(76116006)(66946007)(33656002)(52536014)(4326008)(55016003)(8936002)(66556008)(64756008)(66476007)(316002)(66446008)(8676002)(71200400001)(7696005)(54906003)(6636002)(110136005)(5660300002)(508600001)(2906002)(6506007)(38100700002)(53546011)(122000001)(86362001)(38070700005)(186003)(26005)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjU5MXZCSWRZWW1vUGdaU0hRR3JTVURCbytrbGcyWWZJVUpmN2lza1ArWThq?=
 =?utf-8?B?VWk2R3hocXp6Tk5QUytIT0pXNUdRcUpkb3pkVUpKU0F4ejlXZVk4bXliOVpn?=
 =?utf-8?B?MlYxVU1zeWNCajlONWFBRHF3MlRQdHgyYTRiNFduOGt4M1RJOXVXNW0rS01M?=
 =?utf-8?B?VjV2U0FxR0dKOFE4NU9QN2tTSnpMWTRoZE55SW10UjFwOUhzVjBDVThmWjhl?=
 =?utf-8?B?VXpRSVVUY3BJR2RKb0xJbnhQR1orWWhVbUg3eXAxNjgxNllMSTM4cVhXQit2?=
 =?utf-8?B?QzJMczBjSE1sUFlXeko0Q2VKbmNIZUFHbVlJemN2cFcrSytmNC9hYXoxcENx?=
 =?utf-8?B?STNHZ2R2UWhNUlFDa2tCKzM5WnhoenNlVENRcmFpTEtqYmN3WlpzeExZbHBx?=
 =?utf-8?B?SWhOL1liK0dlZjZmSGJNRUdUc3NLVnBXM2l4YVlRZzY1UTdJM25HSlJwbWRn?=
 =?utf-8?B?UTdWZFdJN3ZGdmhEZFRydXd5QzMvUFJITXAxbzkrNG02ejZtTXRYb21hNTdI?=
 =?utf-8?B?MDBnQ3l1QWVKcnlMTTZOSkR6QUtUNXFXeGpCOU9qRzRoQ3hTT3R0ekswYWox?=
 =?utf-8?B?L0d3dWFxRFZVbHpkSXlZMkc1aThDa0NrSWdhSkpyTUMwNzZwK0tkQnR2TklV?=
 =?utf-8?B?dExBSnBlS2tLUzNkZTVNUjhLKzRldHo5eHV5YWNPK2JybE02UUJvQnZweEVk?=
 =?utf-8?B?a3hBUTY0eXYvUXlmQ0NiNktEdkI5L0ZqZk5rR1NxSmpqZm10VENuTGtYTUZB?=
 =?utf-8?B?R0pEUFJMZTFvUjdJV3o4Zm5iWmpNZEdVZUs4R0lLMTQ5K2ZWRk0yZmZpYTBC?=
 =?utf-8?B?NEhWN01GNXNLNVhuLzFTREdQRkxpbldBRnN6RGxlcmhnZnBHZ2NCc29uMDIr?=
 =?utf-8?B?TDZOK3RlL0xNMWFBOUEzYkJjVHgyUStaVXFjMVpNN3JOVnVaM21KZVJCdDlS?=
 =?utf-8?B?UUNoUjU5aUlyQlA1NjA0NEphRjZqMEROcHhpdi9SM1AwY2dXOXpYQW9VZUJ2?=
 =?utf-8?B?Yy82d05CMW4rT3FJV3l0UXlNa05xcjV0UU5naUwxd0JYbmpJaXZIamxjazI2?=
 =?utf-8?B?d2M1TDhUWlJyTzlDUyt3MUUzTXdob3M3TTVDeE5OcGVpZWFieWxsVDVDazRB?=
 =?utf-8?B?R0Y3WEEvVW84ZHFvbXBQRlV4Z0FVV1Y4cVNvd29MRHNIMG9QU2hSUW55eFVm?=
 =?utf-8?B?UGNSemtnd3FKWVhHVG1WZ0EzTGpFRjE1azZnTzY3N1hpTExtZzhaZXY5OW82?=
 =?utf-8?B?d3lzOEtkT012azd6Nlc3REhId1JoTTFsZTAxdVlQVnNVb1Zpa0pXMnhKa0hX?=
 =?utf-8?B?b3EwSmJxbWJ0WkYvbExkK0V6Y1ZzYytqWWlmMm5rbDJpdW9HdGlIWXR1eWtE?=
 =?utf-8?B?T1VPUjZrNkFWSXBNVHp2dG1mang4cWxRR3o3S0VMZlJPdTBFNGh5ajdqcXhN?=
 =?utf-8?B?ckRHR1FyTWhrRHdvZ1kxZ0x2Z1pLSUFJN2o2OVk2WWN6T1ZIeTdieCtvcjFt?=
 =?utf-8?B?ZHFSOU1IM2JwQmI4eWlvTHBmbVRGdkRhSi9MRExSTkNEYlpwZ3ZRWFVKWmNx?=
 =?utf-8?B?Sm5CZU9yT0lXUTJ6RS9wQXhCK0hocmFoYWVNaFp2QWZCUHNBM2FQelhCT2NL?=
 =?utf-8?B?NFgxM1pLai91dHFKQ2twUlFzVFhENXRnNjFSeHV3QWVtbHpWY3RtSVN6ZkFU?=
 =?utf-8?B?WXMyaE0vdjdUd2NJSno4TVVMZ0YxVlFhcWdEUFJwRXA2clg4WjFjYThWbFJm?=
 =?utf-8?B?aTQyNkVCckJtYUc5L1hwalZZTlhvd000U0dzL3lFb2VGcU1CeDBFNFZySHBC?=
 =?utf-8?B?bHlQY2dHeU1xdURZRGM2VWJuaXcvbWd3cHB4WE5ZdXlKaWpDZGRtNTNQYW9w?=
 =?utf-8?B?M3hwVm9mRVREUWN6aW0ydWVyNXV6Tll2S0xpTnR4dkMzZHRxL0wva1NvRWF6?=
 =?utf-8?B?ZFJVUWl4dXBZY3V0VElJenRZdm9SMXFFQkhhOW9MSGRPMmxaazhqakZmTWFz?=
 =?utf-8?B?bWtPMUxEOXZ2Tk1qQU14RUdnTmNINHUyK1F1bkpCVHc3VE40STZFbWREQ0Ir?=
 =?utf-8?B?d3Y2NnVxTUpjdGRNNkwxSVl4OUN3dzNUQ0tTZ0ZoVEhNam15ZVhPTmdZS2JF?=
 =?utf-8?B?d2l0a0VBYWhTSkFPMFFaUWNsZzRJcFZZUkJZZlRHdnE2RjRhOE52UzVmUkFT?=
 =?utf-8?B?aG1nK1hQYlpNQUlnT3kvSzc5bUlNZHppMUZzQXpaVFZjL3RvNUlseVBRdCtX?=
 =?utf-8?B?OHlsZnJFQnhLTXNZbnB4RlQ3OHlveHdlVlV0VjJGdjJiNVRDUjd0NVZwdzJu?=
 =?utf-8?Q?OMQNjAwKWnEva9EWfK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6155.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8e5b33-786d-4053-9826-08da32bc71c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 19:36:56.9958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fECU1aLuum9kgXNvbYLQvzN1pXJwCQWhg5dy0LOsAdHwJaJUNoJEknfMG2EYYfy+8/ErQZzVkWQpsfV6fSNi4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0076
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.corp-partner.google.com>,
 "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCk9uIDIwMjItMDUtMTEgMDA6MDgs
IFdlbnRsYW5kLCBIYXJyeSB3cm90ZToNCj4gRnJvbTogV2VudGxhbmQsIEhhcnJ5IDxIYXJyeS5X
ZW50bGFuZEBhbWQuY29tPiANCj4NCj4gT24gMjAyMi0wNS0xMCAxNDozNCwgQmhhd2FucHJlZXQg
TGFraGEgd3JvdGU6DQo+PiBGcm9tOiBCaGF3YW5wcmVldCBMYWtoYSANCj4+IDxCaGF3YW5wcmVl
dC5MYWtoYUBhbWQuY29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+DQo+PiANCj4+IFtXaHldDQo+PiB3
ZSBzYXZlIHRoZSBwcmV2X2RwcGNsayB2YWx1ZSB1c2luZyAiZHBwX2luc3QiIGJ1dCB3aGVuIHJl
YWRpbmcgdGhpcyANCj4+IHZhbHVlIHdlIHVzZSB0aGUgaW5kZXggImkiLiBJbiBhIGNhc2Ugd2hl
cmUgYSBwaXBlIGlzIGZ1c2VkIG9mZiB3ZSBjYW4gDQo+PiBlbmQgdXAgcmVhZGluZyB0aGUgaW5j
b3JyZWN0IGluc3RhbmNlIGJlY2F1c2UgaSAhPSBkcHBfaW5zdCBpbiB0aGlzIA0KPj4gY2FzZS4N
Cj4+IA0KPj4gW0hvd10NCj4+IHJlYWQgdGhlIHByZXZfZHBwY2xrIHVzaW5nIGRwcF9pbnN0IGlu
c3RlYWQgb2YgaQ0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBCaGF3YW5wcmVldCBMYWtoYSBCaGF3
YW5wcmVldC5MYWtoYUBhbWQuY29tDQo+PiBSZXZpZXdlZC1ieTogRG15dHJvIExha3R5dXNoa2lu
IDxEbXl0cm8uTGFrdHl1c2hraW5AYW1kLmNvbT4NCj4NCj4gUmV2aWV3ZWQtYnk6IEhhcnJ5IFdl
bnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPg0KPg0KPiBIYXJyeQ0KDQpSZXZpZXdlZC1i
eTogUHJhZnVsIFN3YXJuYWthciA8cHJhZnVsLnN3YXJuYWthckBhbWQuY29tPg0KQWxzbywgdmVy
aWZpZWQgb24gdmFyaW91cyBhZmZlY3RlZCBzeXN0ZW1zIHRvIGNvbmZpcm0gZml4Lg0KDQpSZWdh
cmRzLA0KUHJhZnVsIFN3YXJuYWthcg0KDQo+PiAtLS0NCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvY2xrX21nci9kY24yMS9ybl9jbGtfbWdyLmMgfCAyICstDQo+PiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+PiANCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2xrX21nci9kY24yMS9ybl9jbGtf
bWdyLmMgDQo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jbGtfbWdyL2RjbjIx
L3JuX2Nsa19tZ3IuYw0KPj4gaW5kZXggMDI5NDNjYTY1ODA3Li5jZjFiNWYzNTRhZTkgMTAwNjQ0
DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2xrX21nci9kY24yMS9y
bl9jbGtfbWdyLmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jbGtf
bWdyL2RjbjIxL3JuX2Nsa19tZ3IuYw0KPj4gQEAgLTEyMiw3ICsxMjIsNyBAQCBzdGF0aWMgdm9p
ZCBybl91cGRhdGVfY2xvY2tzX3VwZGF0ZV9kcHBfZHRvKHN0cnVjdCBjbGtfbWdyX2ludGVybmFs
ICpjbGtfbWdyLA0KPj4gIAkJZHBwX2luc3QgPSBjbGtfbWdyLT5iYXNlLmN0eC0+ZGMtPnJlc19w
b29sLT5kcHBzW2ldLT5pbnN0Ow0KPj4gIAkJZHBwY2xrX2toeiA9IGNvbnRleHQtPnJlc19jdHgu
cGlwZV9jdHhbaV0ucGxhbmVfcmVzLmJ3LmRwcGNsa19raHo7DQo+PiAgDQo+PiAtCQlwcmV2X2Rw
cGNsa19raHogPSBjbGtfbWdyLT5kY2NnLT5waXBlX2RwcGNsa19raHpbaV07DQo+PiArCQlwcmV2
X2RwcGNsa19raHogPSBjbGtfbWdyLT5kY2NnLT5waXBlX2RwcGNsa19raHpbZHBwX2luc3RdOw0K
Pj4gIA0KPj4gIAkJaWYgKHNhZmVfdG9fbG93ZXIgfHwgcHJldl9kcHBjbGtfa2h6IDwgZHBwY2xr
X2toeikNCj4+ICAJCQljbGtfbWdyLT5kY2NnLT5mdW5jcy0+dXBkYXRlX2RwcF9kdG8oDQo=
