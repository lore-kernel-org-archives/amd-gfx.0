Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F44BC6FD19
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Mar 2023 03:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D36A10E062;
	Thu, 16 Mar 2023 03:59:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E9F810E062
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Mar 2023 03:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGPVDEeh7S96SSRzAfVf1B4LkMhv0opoCpfuzAGbzQT7fikLIbrDXFxUc1Q6wxainfyQcfAOW/++Yem1P+tXpF2NmPvv1Ak+gRb38CSV09UQHx/DSx/FAzc20pEJf49QE6RNYWbIUmnzYU702ex78aEFQ/TRgj8wTyPFvzviGNyk4Z7cBrQsjQi6Pgj4GRNVutaNsyi2Pc4C1VRtreBZ4Zsj3zSlw8TcRO2bfWV0e7QUIs4pw0U7eHAYbq47VklIFZp5Ny3amoL5/J3/63ubU19FoIEP0o/bcO0XNy3z5Xq/59cyzP5hL0/MI6RsZA/IZBagGngNl6w5hLYqOmksUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIdW5P7nCTUJEnCiaz4ETdrIJVhIICAiuvey1dBwBoE=;
 b=fSSxUsik/z7GqDVQwCuSQe3fgyQtlQvkBOzQDqBBaXz9RwuaEzgiuxbTaT6aFrEBpXIHrmZylSIXnX4iaEAnY4XcvPx4cUvdIw2fxQOXD2petxxt44z3YuLj81MzqxteRCKDu5IBVT47XogZ80sjWJBLzxlzhdImfP91DM3YuwatQXzn8MvoJpNuEGVSxyUEReOiu5XlVhCewzyK4uRbCafQ6VthdJVYfdXrxOXOGhp3t+ETx3xgPULzK1eEE9uh2jJLRxlUHfU+TLoWl/rQoqn6f9zD4SAx2ZfeuQ4J+AzVZ9bhl4AlQaRV8fxsqGsv8sN/7BbxHzAMlnmUg8LVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIdW5P7nCTUJEnCiaz4ETdrIJVhIICAiuvey1dBwBoE=;
 b=tdNEi/bOuPly4cO7SnUylc1ZcHCbsPiqVcszC2E81qhgc11BARkHqDEV3QN//1SgPO70rkyG0wrEfeJ3vIynPJ0RZN0yQdn+cUY9k4jDFOBgAU2eJ4mqbhV2t7HsoGvk4EFUN8xIuT6P1NlQXEa84NxNiImaOFdN7e3TGaEGQEE=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by MW4PR12MB5641.namprd12.prod.outlook.com (2603:10b6:303:186::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 03:59:28 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::b043:d740:d48e:26d3]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::b043:d740:d48e:26d3%6]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 03:59:28 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "Tuikov, Luben"
 <Luben.Tuikov@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Force signal hw_fences that are embedded
 in non-sched jobs
Thread-Topic: [PATCH v2] drm/amdgpu: Force signal hw_fences that are embedded
 in non-sched jobs
Thread-Index: AQHZUi8B6yoNgD0m6kiewBfh7y8wBK70PgmAgAWbdgCAAvlNAA==
Date: Thu, 16 Mar 2023 03:59:28 +0000
Message-ID: <BL1PR12MB52698CD617040177D3D43A3184BC9@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20230309022707.4141252-1-YuBiao.Wang@amd.com>
 <2669032f-5780-6eab-d5a0-c0075109bb2c@amd.com>
 <DM6PR12MB303591B3C5307E4E8FA7075FE5BE9@DM6PR12MB3035.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB303591B3C5307E4E8FA7075FE5BE9@DM6PR12MB3035.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-16T03:59:25Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=106d8695-0b60-47e9-9619-45fb48f161d7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-16T03:59:25Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 9dfdbe1f-e4bd-4bf5-a8dc-1792ee65e2a4
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5269:EE_|MW4PR12MB5641:EE_
x-ms-office365-filtering-correlation-id: 839773ad-9a2e-4a82-4a51-08db25d2d6ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PzdEhkImEtLIC9DAgiKeDPPP/TODkMa4rgdn3motbGYqesgX09QHBFTGMyxWwIHzGID5vDhKyw/LHYJvf86l0gK10jAOQkU9vsbyMmIgxqKyNLmval89D6SO/r9gGAhgHfrEsTYi/zROpQ7rUIgJi3NepMffovXhJqOoerUJKAGAceyCyJgQaK5//HeNRUltA+JU7D6606aNXF4tnndUb8rBL3pirytLn5YUj3Ai8U1XK+LM54dD9hg16ydf6Cclx5wCpc3Nr6nZ3RR57yOOCWorokYckSuQnzwAEziaXJNSnXRX/O8HGO8BbWenAXIerotydWLs7+XIBUZr9mlKA2hd4Dpl0RRHTNd8Wj55yCaM6y8uDVw9ZzzlAAjXq9Ph5qB4nlC9P79vQdB94pc/020rmiWXzqRyaNiT/TONswMvbf32DelTuoZczzZ7Ivw5EurZacoDnRZQLJKnE6Wz6sppGhTU/DxkOJcrJTN5Q4luVaf7I5C5cs6ztWJ7W1rkBTHKHJnGRKZ+oUzMxrdUeDjAJ9a0ztAEUWHX3Nle3DYJ13f3L2uqYJHtNPDN5u5zSSPDFdaaL4z3VcooFIYctj/9GpvAgM3uahk5C0Z0wHhIAZ2RBtcNxgV2A2GKG9K3afeVUDZNZqeR8lQLuw7oCpxEApFjomNMmd1ihMqEb4TUe8Wih9XIfBa0+/yZvrMCYLMf8MlnKC734namuZ/a7A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199018)(5660300002)(83380400001)(86362001)(55016003)(66946007)(478600001)(6506007)(53546011)(71200400001)(9686003)(64756008)(7696005)(4326008)(316002)(41300700001)(66446008)(52536014)(8676002)(66556008)(38100700002)(33656002)(38070700005)(76116006)(186003)(66476007)(8936002)(6636002)(54906003)(110136005)(122000001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFc1am81OW9LTmZLT1JPTGwzUDFacWRQVVFUOTFSaWZqRG5WLy9nVkRxUGto?=
 =?utf-8?B?bDl4SzJ0WWRaKzFRWXZzLy9SWFYvbmFPMlFqYUIwQmQ3d3QwZHd2bmFTTUNk?=
 =?utf-8?B?OHVKbk9uL3hkTVZKZUtUV0NPbUJaZGN3RmJhWVJSZitwOWNTTVB3MUV1MWJQ?=
 =?utf-8?B?TjdoT3lqeGhJUk9mZ1l6OEFyVWRnNjkxQ0IwRFE2RXRMZ3NUd05seTR1K3pa?=
 =?utf-8?B?dDVXM0xuQlpML2NVYkhjTUtlOEhlcVNxUEJ0Z3M3eER1SG9rM2daQXVSVUdI?=
 =?utf-8?B?clBaV1hiYThGVE90OUVSSjlhQWRSMXllR3VWaDZMZTNpVTJPbjB4clk3bUlh?=
 =?utf-8?B?WC9oM0RKUkt1c1pBNnZuYldvM1BObnoxa2RFVTdBNER0c1VYVEp6YVVITnBY?=
 =?utf-8?B?T2lkeFJOR0VuYUN1KzFRRUhqckJoeWk0YXBnUTdyVGNwL1FNRmhmVm0zb2hK?=
 =?utf-8?B?c1VUL3gxdUlIbGZLZUhoZ2V2TVlFTERWRVpDOUIzcGVpL2gwOFc3Z2UybW9V?=
 =?utf-8?B?TWcyYTlvMk9EdUtobkZ1ZCtLUE5NYXpFdWNsVjJQTHRzUmZ5K3BxSTdqZmFB?=
 =?utf-8?B?emFBNGdTbXBvWSs3cGxkbVZPV0VqVnZFKzRMeVBvZzhkZnVjSDk1SWlHUDZQ?=
 =?utf-8?B?cUEvb28rWWNPT3NiS1JaZ1gweFFVekJxcVhjK3Y0QkhXU25lZW9MTDhUMjdD?=
 =?utf-8?B?d2VENUcyUE9ldDM3OEc2L0hLekdQVTJ5eDZBZm5rRzBMWjlYN3kzZFpzNVlZ?=
 =?utf-8?B?cXBwNTFPMm9WUDhnSU5DdFBKTmlNSUdBeUhZM3lVc2s0TVhsOWU2UW1wdERJ?=
 =?utf-8?B?KzNYSVBoNENNejJFdmplUWlCZE9uRm81SENNOXREZFlRM0F6YjJBL3Z4S3Bp?=
 =?utf-8?B?dkhFQVBkbitnLytqbVMrWnY3ZUVhUkZQdngyNUdJd3J2Z3JXdnN1c2JLZmdk?=
 =?utf-8?B?emFLclNSZ1M0TWRDcFV0YTdwQ3RBY1JibDd2WU81VGQ1S1BTYjdLa3Q4OW45?=
 =?utf-8?B?a1VyMm05ZFlXaWVRRnNZK3ZGbmQ2eGRxR0tGamN4Mmp0dTkwaThneXV0VjE3?=
 =?utf-8?B?dWVBc0gzZUx5SVh5S3YyRE5Ua09leW1aWURYWE1LWlJUM01rZEZQd0Z5a2ZE?=
 =?utf-8?B?bzZiVUZtSnBtKy9MR0MzZjFUdHc5QXJCRlNzMitmYjhFZ0NJZkZTMkRhaFNI?=
 =?utf-8?B?djgyaGVkTUY1V0tSMk44aEhKejhZOTJxMFVIUzJqMnYvZ2pPczlRcEkzTjdq?=
 =?utf-8?B?QjdYcG1PeXpjZGVuZ3VDV3ZMbkVsYXNJVDBwaUY5T3VNRnI0ZXFnVGtIWkVq?=
 =?utf-8?B?SkdndDhLdElneWZBYU9zbWFvN2RPcUxhVmFWcnNoWUFQbWQ2M25TbitjcjE3?=
 =?utf-8?B?czllT1Q4ZWMvNWsvbVZQczlDbFBSaDF0NkRvMS93ckZlbVZKcDRlN1A0TnJx?=
 =?utf-8?B?VUJlUWJmQzN1UHJHVjN1ck9qVC8zOWxjMEFaZ2ZBeHV4dGtmcU5Oa3pYVEQz?=
 =?utf-8?B?Qm1IWXhXcXYrYzJVV21UZkNyYXltaWRST2FOc0JpNHVzYUhHVmRoWFVwSzhX?=
 =?utf-8?B?dk54LzBsL0x5bExSekdjdFlDU2lKbjdxYXBIZWpjUGtQRUFtTGg2a0YwdE1y?=
 =?utf-8?B?UHdETkxEajdJY0FDdnU2TEs1dlRDR3MzUlhha0VGN1FVcy9hZFB2ekhtVGpF?=
 =?utf-8?B?M3FBNEx1NFJaalU1WFZ6c0Y5U0xrTE9pYkxNanZUUE9IMjJEYi85ZWdTVndF?=
 =?utf-8?B?OEpVR0UzZHpsYUNKMFJHdmhrMWJ6NkhhUVgrbEJkUVBJaTNMYzNaRnBhKy9P?=
 =?utf-8?B?R0FnZkx3SkU1MHQzRFB0ak1OUXFEZlR2SWowZysvdDNjM0F6YnQrbVJzRWVI?=
 =?utf-8?B?SU8wdDhHUlc4bWdjNUdiV3NkZDk5QkxpR283ZDdva1V0bHZXTys3emFSZWlk?=
 =?utf-8?B?eHhZNUZxcVhjbFFUWnIxaDlseEpmUGZLOEZobDBpamg5R05EZi9xWVIxMm5o?=
 =?utf-8?B?cGZSV1RLeFlPVHlxSi9IQ05sdXYxSnBlb3pCYWdjT2U5Y2JKd2drN3UvS2w0?=
 =?utf-8?B?UjQxV3pVSHgwSjRLdVF1SzJuV0lkeUFGWGphQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 839773ad-9a2e-4a82-4a51-08db25d2d6ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 03:59:28.2045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NBvJFBl5kF01dGSn1tFHf6Thzj8KBdO/Ax6qIBzARNE2eG73qfhN022BuRrQI3XC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5641
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
Cc: "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEx1YmVuDQoNClBsZWFzZSBs
ZXQgdXMga25vdyBpZiB5b3UgZG9uJ3QgaGF2ZSBiYW5kd2lkdGggdG8gcmV2aWV3IGFuZCB3ZSBj
YW4gcmVxdWlyZSBvdGhlciBwZW9wbGUgdG8gcmV2aWV3LCBwbGVhc2UgYmUgdW5kZXJzdGFuZCB0
aGF0IHdlIGFyZSBpbiBhbiB1cmdlbnQgc2l0dWF0aW9uIGFuZCBuZWVkIHRoaXMgY2hhbmdlIHRv
IGdvIHRvIG1haW5saW5lIHRoaXMgd2Vlay4NCg0KVGhhbmtzIA0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KTW9uayBM
aXUgfCBDbG91ZCBHUFUgJiBWaXJ0dWFsaXphdGlvbiBTb2Z0d2FyZSB8IEFNRA0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogV2FuZywgWXVCaWFvIDxZdUJp
YW8uV2FuZ0BhbWQuY29tPiANClNlbnQ6IDIwMjPlubQz5pyIMTTml6UgMTQ6MzQNClRvOiBUdWlr
b3YsIEx1YmVuIDxMdWJlbi5UdWlrb3ZAYW1kLmNvbT4NCkNjOiBRdWFuLCBFdmFuIDxFdmFuLlF1
YW5AYW1kLmNvbT47IENoZW4sIEhvcmFjZSA8SG9yYWNlLkNoZW5AYW1kLmNvbT47IEtvZW5pZywg
Q2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIg
PEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5aaGFu
Z0BhbWQuY29tPjsgTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPjsgWHUsIEZlaWZlaSA8RmVp
ZmVpLlh1QGFtZC5jb20+OyBXYW5nLCBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNv
bT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpTdWJqZWN0OiBSRTogW1BBVENIIHYy
XSBkcm0vYW1kZ3B1OiBGb3JjZSBzaWduYWwgaHdfZmVuY2VzIHRoYXQgYXJlIGVtYmVkZGVkIGlu
IG5vbi1zY2hlZCBqb2JzDQoNCkhpIEx1YmVuLA0KDQpJJ2QgaGF2ZSB0byBwaW5nIHlvdSBiZWNh
dXNlIHdlJ3ZlIGdvdCBhIFAxIHRpY2tldCBjdXJyZW50bHkgb24gdGhpcyBpc3N1ZS4gV291bGQg
eW91IHBsZWFzZSBnaXZlIGEgdmFndWUgdGltZSB3aGVuIHdvdWxkIHlvdSBjb25maXJtIHdoZXRo
ZXIgdGhpcyBwYXRjaCBpcyBzYWZlPyBUaGFuayB5b3UgYSBsb3QgZm9yIGhlbHBpbmcgZG91Ymxl
IGNoZWNrIHRoaXMuDQoNClJlZ2FyZHMgJiBUaGFua3MsDQpZdWJpYW8gDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBUdWlrb3YsIEx1YmVuIDxMdWJlbi5UdWlrb3ZAYW1kLmNv
bT4NClNlbnQ6IFNhdHVyZGF5LCBNYXJjaCAxMSwgMjAyMyAxMjo1NiBBTQ0KVG86IFdhbmcsIFl1
QmlhbyA8WXVCaWFvLldhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQpDYzogUXVhbiwgRXZhbiA8RXZhbi5RdWFuQGFtZC5jb20+OyBDaGVuLCBIb3JhY2UgPEhvcmFj
ZS5DaGVuQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQu
Y29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgWmhh
bmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IExpdSwgTW9uayA8TW9uay5MaXVA
YW1kLmNvbT47IFh1LCBGZWlmZWkgPEZlaWZlaS5YdUBhbWQuY29tPjsgV2FuZywgWWFuZyhLZXZp
bikgPEtldmluWWFuZy5XYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBkcm0v
YW1kZ3B1OiBGb3JjZSBzaWduYWwgaHdfZmVuY2VzIHRoYXQgYXJlIGVtYmVkZGVkIGluIG5vbi1z
Y2hlZCBqb2JzDQoNCk9uIDIwMjMtMDMtMDggMjE6MjcsIFl1QmlhbyBXYW5nIHdyb3RlOg0KPiB2
MjogQWRkIGNvbW1lbnRzIHRvIGNsYXJpZnkgaW4gdGhlIGNvZGUuDQo+IA0KPiBbV2h5XQ0KPiBG
b3IgZW5naW5lcyBub3Qgc3VwcG9ydGluZyBzb2Z0IHJlc2V0LCBpLmUuIFZDTiwgdGhlcmUgd2ls
bCBiZSBhIA0KPiBmYWlsZWQgaWIgdGVzdCBiZWZvcmUgbW9kZSAxIHJlc2V0IGR1cmluZyBhc2lj
IHJlc2V0LiBUaGUgZmVuY2VzIGluIA0KPiB0aGlzIGNhc2UgYXJlIG5ldmVyIHNpZ25hbGVkIGFu
ZCBuZXh0IHRpbWUgd2hlbiB3ZSB0cnkgdG8gZnJlZSB0aGUgDQo+IHNhX2JvLCBrZXJuZWwgd2ls
bCBoYW5nLg0KPiANCj4gW0hvd10NCj4gRHVyaW5nIHByZV9hc2ljX3Jlc2V0LCBkcml2ZXIgd2ls
bCBjbGVhciBqb2IgZmVuY2VzIGFuZCBhZnRlcndhcmRzIHRoZSANCj4gZmVuY2VzJyByZWZjb3Vu
dCB3aWxsIGJlIHJlZHVjZWQgdG8gMS4gRm9yIGRybV9zY2hlZF9qb2JzIGl0IHdpbGwgYmUgDQo+
IHJlbGVhc2VkIGluIGpvYl9mcmVlX2NiLCBhbmQgZm9yIG5vbi1zY2hlZCBqb2JzIGxpa2UgaWJf
dGVzdCwgaXQncyANCj4gbWVhbnQgdG8gYmUgcmVsZWFzZWQgaW4gc2FfYm9fZnJlZSBidXQgb25s
eSB3aGVuIHRoZSBmZW5jZXMgYXJlIA0KPiBzaWduYWxlZC4gU28gd2UgaGF2ZSB0byBmb3JjZSBz
aWduYWwgdGhlIG5vbl9zY2hlZCBiYWQgam9iJ3MgZmVuY2UgDQo+IGR1cmluZyBwcmVfYXNpY19y
ZXNldCBvciB0aGUgY2xlYXIgaXMgbm90IGNvbXBsZXRlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
WXVCaWFvIFdhbmcgPFl1Qmlhby5XYW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgfCA4ICsrKysrKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZmVuY2UuYw0KPiBpbmRleCBmYWZmNGEzZjk2ZTYuLmFkN2M1YjcwYzM1YSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMNCj4gQEAgLTY3
Myw2ICs2NzMsNyBAQCB2b2lkIGFtZGdwdV9mZW5jZV9kcml2ZXJfY2xlYXJfam9iX2ZlbmNlcyhz
dHJ1Y3QNCj4gYW1kZ3B1X3JpbmcgKnJpbmcpICB7DQo+ICAJaW50IGk7DQo+ICAJc3RydWN0IGRt
YV9mZW5jZSAqb2xkLCAqKnB0cjsNCj4gKwlzdHJ1Y3QgYW1kZ3B1X2pvYiAqam9iOw0KPiAgDQo+
ICAJZm9yIChpID0gMDsgaSA8PSByaW5nLT5mZW5jZV9kcnYubnVtX2ZlbmNlc19tYXNrOyBpKysp
IHsNCj4gIAkJcHRyID0gJnJpbmctPmZlbmNlX2Rydi5mZW5jZXNbaV07DQo+IEBAIC02ODAsNiAr
NjgxLDEzIEBAIHZvaWQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9jbGVhcl9qb2JfZmVuY2VzKHN0cnVj
dCBhbWRncHVfcmluZyAqcmluZykNCj4gIAkJaWYgKG9sZCAmJiBvbGQtPm9wcyA9PSAmYW1kZ3B1
X2pvYl9mZW5jZV9vcHMpIHsNCj4gIAkJCVJDVV9JTklUX1BPSU5URVIoKnB0ciwgTlVMTCk7DQo+
ICAJCQlkbWFfZmVuY2VfcHV0KG9sZCk7DQo+ICsJCQkvKiBGb3Igbm9uLXNjaGVkIGJhZCBqb2Is
IGkuZS4gZmFpbGVkIGliIHRlc3QsIHdlIG5lZWQgdG8gZm9yY2UNCj4gKwkJCSAqIHNpZ25hbCBp
dCByaWdodCBoZXJlIG9yIHdlIHdvbid0IGJlIGFibGUgdG8gdHJhY2sgdGhlbSBpbiBmZW5jZSBk
cnYNCj4gKwkJCSAqIGFuZCB0aGV5IHdpbGwgcmVtYWluIHVuc2lnbmFsZWQgZHVyaW5nIHNhX2Jv
IGZyZWUuDQo+ICsJCQkgKi8NCj4gKwkJCWpvYiA9IGNvbnRhaW5lcl9vZihvbGQsIHN0cnVjdCBh
bWRncHVfam9iLCBod19mZW5jZSk7DQo+ICsJCQlpZiAoIWpvYi0+YmFzZS5zX2ZlbmNlICYmICFk
bWFfZmVuY2VfaXNfc2lnbmFsZWQob2xkKSkNCj4gKwkJCQlkbWFfZmVuY2Vfc2lnbmFsKG9sZCk7
DQoNCkNvbmNlcHR1YWxseSwgSSBkb24ndCBtaW5kIHRoaXMgcGF0Y2ggZm9yIHdoYXQgaXQgZG9l
cy4gVGhlIG9ubHkgdGhpbmcgd2hpY2ggd29ycmllcyBtZSBpcyB0aGlzIGNoZWNrIGhlcmUsICFq
b2ItPmJhc2Uuc19mZW5jZSwgd2hpY2ggaXMgdXNlZCBoZXJlIHRvIHF1YWxpZnkgdGhhdCB3ZSBj
YW4gc2lnbmFsIHRoZSBmZW5jZSAoYW5kIG9mIGNvdXJzZSB0aGF0IHRoZSBmZW5jZSBpcyBub3Qg
eWV0IHNpZ25hbGxlZC4pIFdlIG5lZWQgdG8gYXVkaXQgdGhpcyBjaGVjayB0byBtYWtlIHN1cmUg
dGhhdCBpdCBpcyBub3Qgb3ZlcmxvYWRlZCB0byBtZWFuIG90aGVyIHRoaW5ncy4gSSdsbCB0YWtl
IGEgbG9vay4NCg0KPiAgCQl9DQo+ICAJfQ0KPiAgfQ0KDQotLQ0KUmVnYXJkcywNCkx1YmVuDQo=
