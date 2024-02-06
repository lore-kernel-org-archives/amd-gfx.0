Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F0EC4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 21:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F7651125D0;
	Tue,  6 Feb 2024 21:46:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QeVi672F";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA00711224A
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 21:46:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1Vlk/tqD1A5vHt5+S5iELJMgWSMjAxUAhhJYng5PEyVc56NYtyoXH23qHhxvcJ8YZd1RhcerUfI1UTbdNVlOlQDtusbY9FldB99AATh5NkGhK3bLYLsHKgLAaoyH9odm5ww5jnsJ88NohxVyVUlXVNZHHR3v3kYFrz67kSX0swCYfxdEl220bZxtTbEUwR36Elna3QCWIMlVnmFPjG3YpBG0s+xbBmFcs739yNoGmT6dDCk1eHZqH2yZ70wHHly0zmsujvmawmZOPvIb113oPBRcQGm7ee/RSGj6V3USRsvSggv80ZTR6rrnJ8i0iVgi7gxPUQ1yL9BqRHinaH9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vk+JazoWII5lOOOMcVqXkd7rpFUqG0/6JPiSDPmxBck=;
 b=Q6kRAm/x5LtGj7iE8ORDGl2OXGU/cWU53FofZ4BXiMjLKKzw9E/TYbivtZ9zYAO29KuYc4oqPhriqz89bG8ugBisc8GYw7c621mz/+/LXjVsb2zagcuo9JuKIMKiwGI2B2V0CYBllXiLQdoMhcNOZUv5GUH91Fbf4zeVWXq0m3joMHP7Blo63fCKU4fGFBS6U9ZnkkQ6lzgntsCQ877RHSuWfNG6igIzesjTG6HztX8heLyuC5fYuIHOuV/5Bx4rfJ2suARH87zxBuxah+vXc4Q1JQDGkGQVPVAYGm3WeVA/ICBG/FMjhVRRQHvsSZXbkHd69BmzLFPFHvWRuIfnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vk+JazoWII5lOOOMcVqXkd7rpFUqG0/6JPiSDPmxBck=;
 b=QeVi672FkXzJ/RLFJCLzEhDN6iEhOjuXOVx63sS0IxUR242U1Cn92ig+wzArVaTWbGG497u26FK8dP2OYI8IuTu7/StnwU3BB6G4JzQ0KhkvXyrAjUxVEFc448ZMIlm+sd2h8upbUdp+4yHXNc6F/2CeFnsgqtP0rc+vzzEMCj4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 21:46:36 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::9288:f78d:b34e:9b52%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 21:46:36 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Greathouse, Joseph"
 <Joseph.Greathouse@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Initialize kfd_gpu_cache_info for KFD topology
Thread-Topic: [PATCH] drm/amdkfd: Initialize kfd_gpu_cache_info for KFD
 topology
Thread-Index: AQHaWT7nP7oPgrcQvUOHbwTBN234p7D90KeAgAAIluA=
Date: Tue, 6 Feb 2024 21:46:36 +0000
Message-ID: <BL1PR12MB514443F0D45FA423718E73D8F7462@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240206205524.2697359-1-Joseph.Greathouse@amd.com>
 <d4f0a9e8-54df-42d8-b130-e1b2977b8bde@amd.com>
In-Reply-To: <d4f0a9e8-54df-42d8-b130-e1b2977b8bde@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=70305db4-57f7-426e-8da0-892d7326253e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-06T21:45:56Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB5654:EE_
x-ms-office365-filtering-correlation-id: 968efff4-bd02-4b09-b263-08dc275d17a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A/IKVu0WGijL+fCewy5WJ7pOyBKE2r+iD3Y7KMw+2XeFBr6rWsoxnmJBfNSohBXoxDPsCyA0bvqbH7LmNbpt4F3uY7h7cqNsQSg0mdC6k6/5HCb5jA9x5raoXqXzK5BM6xSetPlZ1fpy0HwprDVzjlFjMk7DgleWLcKoGMde2x0J1ytqP182XrHhiWIEl5rC6mQhB2IZIQoMj63sFihLrTiOrblmeurKK8zJNhbvnmCQB/HZoFGvHSnb3sWr8HOtM74nAcUV5aNZeYJrnjalCpLFRv/J44IaGtlFhnH5EcZbfs3ajwYxRuAuOR1Wl40vhi8rCyGrqX+mhoODbfyEZLniXavSBEAeiahzSN9Qv+e2Lct1hexYLDMhOEF3QdR5vo1bThirx3w/IVUydHEac82SAdGD9IwUAWsMQ4LwMZYZfEypeE1iXB6V77siU9rwAYp/f14OQlpZ39MpvpLdNvLUqWleBPAHfVMNDfi2br6V58Wc6fbHlR9b+dsuOI/V0tlq0G4OY2LJSgwcT2DWZERh/QPGrvb6DHtML27WjEkPFGLraM0Jexq4kZMwhGTEk8k+xx1Qk/93Sg9uD/KgjrSqCeFIgfxoO0wVZVfSuuxTUqKFBJ+Frj40O3Ix4aEL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(6506007)(7696005)(26005)(71200400001)(33656002)(55016003)(41300700001)(38070700009)(5660300002)(110136005)(122000001)(86362001)(64756008)(66556008)(66446008)(76116006)(66476007)(316002)(38100700002)(9686003)(478600001)(53546011)(2906002)(8936002)(52536014)(8676002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXNpakFLZVVRN3pXZC9sUHJzZ3k0REdRM29MTlF4Q3lwTzJROVl1ZEJ0YVBH?=
 =?utf-8?B?bVlSdDBCR1hXckl0WHZzVFF0OExlV0tTM0ppcng3dklXc1J3SWdUME0wclhF?=
 =?utf-8?B?QVk1dXBlNG9kdEZNdjF2MGQ0ZlUrQnRIa3o3bUJLZmFud1cyZ1lYbkFFZkdK?=
 =?utf-8?B?WlptNGdSRjZBQVo1eUVzWjhJSlNjdldzcFNGSmNhUzJhbjFUNTJJbzN5M0gx?=
 =?utf-8?B?bksySG1vTWdMQk9ZOGEwQXZudDBrZDFYdjB5bDFUcXRLNStZTCsxR0tobUFu?=
 =?utf-8?B?eEUvMm1wVmlyTTRpRTA1aTd3Q3F1ckhVVWtpZFRPdE4zTVJXZjhKUWE5ak9D?=
 =?utf-8?B?R2drb2QzZU95bFNwbk1ZbGkxRnBrbGlWazFwS05FYmoyY21iOUhvek1GbXBC?=
 =?utf-8?B?K3VHSmpBRXJWMHpRYmpuRkFwTG5KaHp2aGFzemZoWGw4dlo1bmN2NlhkQnUx?=
 =?utf-8?B?NTM4d0JQNmh0YUJ6UzlGaHI4Rnc1RjVEUmtGT0lEWnpnRlArWmtMTE93Vm5T?=
 =?utf-8?B?K29yVThDR0piNDRJQlA5aUhDeTdudk0wK3NoZjMzQ1dqcEF1TDdkMW1nY0hw?=
 =?utf-8?B?V2RaS3lVOU9HbXg1NEorNXg2cE9WN1J1NTJxVXF0em5QOXBxZWhERDdHRWVV?=
 =?utf-8?B?NVFsZXkwZWhOa05DN21Mcm5WVHk5ZTV4dlNNL1FFalpMZVM0QkRMN3lFL0tB?=
 =?utf-8?B?UnRwNFZla0xocWNSa01McG9TdGl0T2pzUDhOK3VWZ3lyVmRjRTBMS045Nll1?=
 =?utf-8?B?emNWVTFlTUFCem9GYlJpSlUrVVlMKzVlWTRhSlV5TGVoMTFSd08vSHJZSmMz?=
 =?utf-8?B?OVhwQmoyaFJRanlMUktSNzdHWW16T1BUTSsrL3lpd2RNbWJjakl2L0d2bmFW?=
 =?utf-8?B?dFBvMUVPZjRCNHNLcVdMRi8zMmhwR1NHMG1mbmQ5UXVIdEZVU2w0amZNbVRS?=
 =?utf-8?B?WGhtakJta3g0UjlJRXIyeWRlYVcrRk1RdnNKZFk0cWkwVVpzRnU4Zm9YTE8x?=
 =?utf-8?B?MlFSZzNNTzVNWFZyMWQ3ZTM1ZTRMR0d0YlVPMm43L2JTSE9OOXhaUUV2bXpz?=
 =?utf-8?B?RDNPcDJWVzUrUmtHM2tWc3RGQi9aZHY0clBPbC9wRHpLUWh4K2M4eVZvYWxO?=
 =?utf-8?B?b25XY1lxcUYwME5SZ2VFZEE0MlhZdDEybml2ZUtIdGd0QkNhV0dOVVJQZzNG?=
 =?utf-8?B?a2FmM0UxamNEcTV2K3VrWVhCWVVxNldrZlBxZHFmSDE3RVJZVjNPZkJFcmY2?=
 =?utf-8?B?SnY4eVlEeGF2SzFyLzMrR3IyRDNRcENSN1BaTGhiMjNFS0xDcFYrUkZteTJS?=
 =?utf-8?B?SndZQjVuTktqQ0tNWnNCZ2IzUDI5RWhTODNrWUNDRzk0SllnRFBrMkFLMTVi?=
 =?utf-8?B?dDgwbUdGd21ONFBSNWZoVmdVVUlHSFF4TWJKbGhhc2h2dmU2alFiZFNtWkRy?=
 =?utf-8?B?QTNuby95M2IrSUM1Qm5FU1VVK3dYNlNNYXk0WjhNMmlRLzllSUZpNGk3bEpr?=
 =?utf-8?B?TFpjaEdGZlVIVXNXZGozMDNQS2RJcTllOTdSbTkrazdOZEtzWXVNV0NZU3ZV?=
 =?utf-8?B?dkF1WS9DK3VvU1VkSTFyUE9CT2FXeE9FY0JIeHplMG1yeDVuQkQzSjFBQ2Rx?=
 =?utf-8?B?RlF1U2haSk5jTFBGSzNSMnlRWU55elNLeVdvNVlvR1drc2I5Uk9ScW1lSTVC?=
 =?utf-8?B?ZTZKV2JRNEZvNFFhQW11OWxyNTNZTjhUVGt5VkdSM1JucERFNWxZQSt1VGh6?=
 =?utf-8?B?NUMzU05NRHBQbi9VcTc4dkFyRUFGMyt3SWlMNnRhQXArcDgvREJObGw4bDQr?=
 =?utf-8?B?US9Ua0J5VVhmSm5JNlFZUWNRWVNROUQzL0F3YkViT2lGMjEvV1NKcVV6WXMv?=
 =?utf-8?B?ZFpHQVhrUXp2SGkwWFl2Q1hZZUlyRzZmdVE5bnFpVVdnZG1RT0tXUzRLTm04?=
 =?utf-8?B?U2NlSnBtWWVhVjFjbXl4b2RNSThhWWthUDFFTHBMbmowcHUrMTIwaU9mMEZ4?=
 =?utf-8?B?Z0pCSE4rbUFadHh0UEUxaW1Eb3lmRGNySnpDM3BiL3oyRlQwWVpKSk1jWWo4?=
 =?utf-8?B?YjlteEFVY1FlaU5vdVYyVzhsTy9DZlZSSml0b2o1TUp0alFRVk5wSy9ZQ1JO?=
 =?utf-8?Q?TGXk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968efff4-bd02-4b09-b263-08dc275d17a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 21:46:36.2103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xBvZi7bc0R0r6n6iwL6Ui6+Gmb/Fn5S1JHshDYGr4brI9gVdzBSlIj/2pm31vgFx4QjBAAYVRHJezbllVHDAjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
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
YWdlLS0tLS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29t
Pg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSA2LCAyMDI0IDQ6MTUgUE0NCj4gVG86IEdyZWF0
aG91c2UsIEpvc2VwaCA8Sm9zZXBoLkdyZWF0aG91c2VAYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiBJbml0aWFs
aXplIGtmZF9ncHVfY2FjaGVfaW5mbyBmb3IgS0ZEDQo+IHRvcG9sb2d5DQo+DQo+DQo+IE9uIDIw
MjQtMDItMDYgMTU6NTUsIEpvc2VwaCBHcmVhdGhvdXNlIHdyb3RlOg0KPiA+IFRoZSBjdXJyZW50
IGtmZF9ncHVfY2FjaGVfaW5mbyBzdHJ1Y3R1cmUgaXMgb25seSBwYXJ0aWFsbHkgZmlsbGVkIGlu
DQo+ID4gZm9yIHNvbWUgYXJjaGl0ZWN0dXJlcy4gVGhpcyBtZWFucyB0aGF0IGZvciBkZXZpY2Vz
IHdoZXJlIHdlIGRvIG5vdA0KPiA+IGZpbGwgaW4gc29tZSBmaWVsZHMsIHdlIGNhbiByZXR1cm5l
ZCB1bmluaXRpYWxpemVkIHZhbHVlcyB0aHJvdWdoICB0aGUNCj4gPiBLRkQgdG9wb2xvZ3kuDQo+
ID4gWmVybyBvdXQgdGhlIGtmZF9ncHVfY2FjaGVfaW5mbyBiZWZvcmUgYXNraW5nIHRoZSByZW1h
aW5pbmcgZmllbGRzIHRvDQo+ID4gYmUgZmlsbGVkIGluIGJ5IGxvd2VyLWxldmVsIGZ1bmN0aW9u
cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvc2VwaCBHcmVhdGhvdXNlIDxKb3NlcGguR3Jl
YXRob3VzZUBhbWQuY29tPg0KPg0KPiBUaGlzIGZpeGVzIHlvdXIgcHJldmlvdXMgcGF0Y2ggImRy
bS9hbWRrZmQ6IEFkZCBjYWNoZSBsaW5lIHNpemVzIHRvIEtGRA0KPiB0b3BvbG9neSIuIEFsZXgs
IEkgdGhpbmsgdGhlIHByZXZpb3VzIHBhdGNoIGhhc24ndCBnb25lIHVwc3RyZWFtIHlldC4gRG8g
eW91DQo+IHdhbnQgYSBGaXhlczogdGFnIG9yIGlzIGlzIHBvc3NpYmxlIHRvIHNxdWFzaCB0aGlz
IHdpdGggSm9lJ3MgcHJldmlvdXMgcGF0Y2gNCj4gYmVmb3JlIHVwc3RyZWFtaW5nPw0KDQpFaXRo
ZXIgd2F5LiAgSSBjYW4gZml4IHVwIHRoZSB0YWcgd2hlbiB3ZSB1cHN0cmVhbSBvciBzcXVhc2gg
aXQuDQoNCkFsZXgNCg0KPg0KPiBPbmUgbml0LXBpY2sgYmVsb3cuDQo+DQo+DQo+ID4gLS0tDQo+
ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuYyB8IDEgKw0KPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMNCj4gPiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jDQo+ID4gaW5kZXggM2RmMmE4YWQ4NmZi
Li42N2MxZTdmODQ3NTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX3RvcG9sb2d5LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfdG9wb2xvZ3kuYw0KPiA+IEBAIC0xNzA3LDYgKzE3MDcsNyBAQCBzdGF0aWMgdm9pZCBrZmRf
ZmlsbF9jYWNoZV9ub25fY3JhdF9pbmZvKHN0cnVjdA0KPiA+IGtmZF90b3BvbG9neV9kZXZpY2Ug
KmRldiwgc3RydWN0DQo+ID4NCj4gPiAgICAgZ3B1X3Byb2Nlc3Nvcl9pZCA9IGRldi0+bm9kZV9w
cm9wcy5zaW1kX2lkX2Jhc2U7DQo+ID4NCj4gPiArICAgbWVtc2V0KGNhY2hlX2luZm8sIDAsIHNp
emVvZihzdHJ1Y3Qga2ZkX2dwdV9jYWNoZV9pbmZvKSAqDQo+ID4gK0tGRF9NQVhfQ0FDSEVfVFlQ
RVMpOw0KPg0KPiBKdXN0IHVzZSBzaXplb2YoY2FjaGVfaW5mbykuIE5vIG5lZWQgdG8gY2FsY3Vs
YXRlIHRoZSBzaXplIG9mIHRoZSBhcnJheSBhbmQgcmlzaw0KPiBnZXR0aW5nIGl0IHdyb25nLg0K
Pg0KPiBSZWdhcmRzLA0KPiAgICBGZWxpeA0KPg0KPg0KPiA+ICAgICBwY2FjaGVfaW5mbyA9IGNh
Y2hlX2luZm87DQo+ID4gICAgIG51bV9vZl9jYWNoZV90eXBlcyA9IGtmZF9nZXRfZ3B1X2NhY2hl
X2luZm8oa2RldiwgJnBjYWNoZV9pbmZvKTsNCj4gPiAgICAgaWYgKCFudW1fb2ZfY2FjaGVfdHlw
ZXMpIHsNCg==
