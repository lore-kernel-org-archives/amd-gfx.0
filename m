Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43007D68B34
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2024 15:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE7B710E813;
	Thu, 14 Nov 2024 15:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jCXBEZAT";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E1010E813
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2024 15:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMvpFLvkM4sx/+ItpQ3UZq6dgxrWMTX4taR4XeGUzy79YWbP+KFVVbjURAl7kz+LhXouO6sU5rb02hkCKcVIl0wFtiN+xXUUdXwn0A+BsdF8Fod6luJDrXLjzL+WF7KwYGZGLdT/+z/+E5nSb6q2khflI+tDEUUEN/aOc2M0newlQgvCdaVX/IcQuGWJK6EtHwOIy3wuFOcxflQIPXTDlBdT9mdKP5sJHHXJ0AKZFS9xPFm+OhGVJigw9mnJtJL+yAd4pnj6GXDBJ4gq3af8DcT8Iz7ohCFyEttDEVDppDNthlKLU5rqq3G79pfERKnuJe4kYkPsNWWqgARH3UwEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cf+XPRAz4UQnH1B+mdNZbOUnupSQVOLyJw72NNxWEno=;
 b=TqMLqAyITy4FTXgURsSJxgEyJXXOF5HjSCywAZjNjdA3MakkjdgdAMuW8Oyk2us1nabouW5loP3/6Lw4nWMLG90gRpdnqSifw3Zt2EP/HiuDuNjzcXdiGlUXsBpho0KmKMxLHQ+bIIC66UpC6LISeC1rI46xv/CcKcyef9iePw42IaSfWQRtR/FYsHP4w8hkwLnv90FXX52UAekWotpI3Mh9D3GlOSKUf5RPu6hTmqZvj9UgcyNdO+Aw5Rh5iEslNbWbcjJ1tOMza5c5GJ/eanxOLvqtXdXpnG1HHfI1xfW0i9Hva3EH047P+H2dec2tOTgG+bxHwvv5jkfTNwckkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf+XPRAz4UQnH1B+mdNZbOUnupSQVOLyJw72NNxWEno=;
 b=jCXBEZATno3n4go2oYe4Iw+gRwrxAGYK5bIug/2+KHdz52U2kEmn3rNMMAVz0hGFcoyoUYXDTQIAk+0HCbZKDSM5O5HS3F48ihmjR194wOXBgvbvFbtCqNxokxr8GurT4Mo5FRM34GlS2Z/Rr0N3gZxJeg3TIRsfEvLXSvCJoyY=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 15:52:37 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%5]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 15:52:37 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?=
 <ckoenig.leichtzumerken@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Matthew Auld
 <matthew.auld@intel.com>
Subject: RE: [PATCH v7 4/4] drm/amdgpu: track bo memory stats at runtime
Thread-Topic: [PATCH v7 4/4] drm/amdgpu: track bo memory stats at runtime
Thread-Index: AQHbM4cm2Qy9C3gimkGj8UdltocsKLKze08AgABz2+CAAPuMgIAAGtOAgAAUi4CAABqaAIAAEzMAgAAoT9CAAAw9gIABbALQ
Date: Thu, 14 Nov 2024 15:52:37 +0000
Message-ID: <SA1PR12MB85994AE8D9FC61F2E4D07074ED5B2@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20241110154152.592-1-Yunxiang.Li@amd.com>
 <20241110154152.592-5-Yunxiang.Li@amd.com>
 <5d1c88a5-9802-4bb7-b76a-5e501847ced1@gmail.com>
 <SA1PR12MB85998D24DDB5EB93AE88E5A1ED592@SA1PR12MB8599.namprd12.prod.outlook.com>
 <92be210e-b552-45ee-9322-1944a4bfd325@amd.com>
 <cc63f0ef-e152-49fc-90d9-ca695a8918f3@igalia.com>
 <eed6b35e-912a-4d7a-ac18-643d571f6e03@amd.com>
 <SA1PR12MB85999903EC92F7A1329D741CED5A2@SA1PR12MB8599.namprd12.prod.outlook.com>
 <76af3cc6-5535-47ca-9473-792f3e9c2d13@amd.com>
 <SA1PR12MB859954E2004C03CAAF764812ED5A2@SA1PR12MB8599.namprd12.prod.outlook.com>
 <dd23e624-c8c5-41f4-b4b0-316351d8c8e4@igalia.com>
In-Reply-To: <dd23e624-c8c5-41f4-b4b0-316351d8c8e4@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a2143640-efca-46a5-944d-dfde6ea28696;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-14T15:13:22Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|IA1PR12MB8311:EE_
x-ms-office365-filtering-correlation-id: 5225fcfe-256f-41f8-4168-08dd04c45d05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M1RMWUhsYWhpTk9WcDB4TGNmMkNONnNHeDdOQnFFQ0Z2YkhTaHdkZGVaR0Fq?=
 =?utf-8?B?V20xZ1hnWndnZDYvbDMxWnN3OURMb3lQNHB5RnVpWVh1aWkvQVFsZ1N3dmhY?=
 =?utf-8?B?dHp0SWs5L3YzaisyRlFMcnRCTEltMStpaWQ3UDU4UTBpWG5PekU5VHo3WFNF?=
 =?utf-8?B?N04zSDZTdXhjVWl3c0ZzdmtRRVNIcCszUCs2Ynd4SEZnUGdYa2xOZ2tYdWRz?=
 =?utf-8?B?ak9WR0ZVOGd0dC9VeWoyZi9leEwzZ3pWQmk1RmdxYXI1WUkxUXVWMEpPYWFa?=
 =?utf-8?B?Z1JkalprbFp3TXRDUytiZC9KS1hHakNpblZNYUpOdWFEcWlORUpGSUVWblQr?=
 =?utf-8?B?UnA5eEtTemlmWkhjWG5OTVR1Y1FCWWFKYVJjbThockVUaVcycmFsNFJZSURm?=
 =?utf-8?B?QnlMZ0Y5OTJwRStOendYMmdTZEQ0eVNPRlJsU2xBdWx3R0RhMUZydndCTkgv?=
 =?utf-8?B?Q2dtN2FHSVVCSk9mWXFnWnZrNnhrdFdINjR3Mk8xMEluNkt1NjlDMUJvUFRY?=
 =?utf-8?B?dDZTd3RXVnBXbElNODJaTkc3RzlBSXJ1cjdndTFkRkpYdGhTTktZZVN3ODJn?=
 =?utf-8?B?bWlJSUNUaG0wM3YrZXExb1g2aXZxZVFoYkt5SkloVUcxbGszK29DTHFyZVZU?=
 =?utf-8?B?SkhWWlkwd0dCK3I5ZEc0VnhzbDk2d1BSM0E1d0l6RjNvbCtYK2daTWVkRzE4?=
 =?utf-8?B?OHdoVnhOVE5WcXp4R0ZQL0FMNGh4U1lkdmF0ekphdWdNVy9ZU0NCeGV0Qlll?=
 =?utf-8?B?V2dFM0xXRTFUcUNLV2RJZTdvSG96YW8zYWk3MHZPNTFHeXVGM2RiMzZvNVFK?=
 =?utf-8?B?Zk9QbTNqOFlVUmVFK0FJMzdTU05wcWR0QnFJWmxWVVdkY2hpNUhHdnZxZk8v?=
 =?utf-8?B?YVBEdjNHR2NLZDhJU1FHQWdzdkhKVE02R1BRRG1FOEV5bGx3TlJJYXcyUHhY?=
 =?utf-8?B?cnpYbWtINHFydytjK3ovbzl4bGVCdFJ3Rmp0cXUrc1dQbERHSlVmM0ZmbUhO?=
 =?utf-8?B?Rm5OdlR5NDMvaWkra1dsUGJEenZtOWFvL0lEa2lHOS9mUnlTWTZmdWxySXVX?=
 =?utf-8?B?U2VPek9YRUVXS2FkNW8rVGlWVVFVN0NrMW5QYnVtSlBGVHh6L0lHTDByTnZX?=
 =?utf-8?B?Z0Yzc2VMakRDRjUzakxMTTluR0pBVXVTTGwwdFBTRWltMGQwSk9kOWkvU2Rr?=
 =?utf-8?B?aG9EelNld3g4bEdreXh0RUFxbXpBRmczVUhWSW5RZlVoSy90MHVhZmZUenlu?=
 =?utf-8?B?NkMyMGJvTGZTeDlCd2RLdTBYOFdiYnphYzQrOE4rQitCRENUM3BaYmFRRDFN?=
 =?utf-8?B?eXA1WmhZUjdVRU1OdDlWaGJDU2NPZkdYNHRPTGJVaDBHVGJkV0lxOXEwYmhz?=
 =?utf-8?B?MDVKb01LbG41ejVIcXM1VVZnY25GNENsSXJQUFpDdzh1RUYzYkFOYk9tTVVs?=
 =?utf-8?B?a1dGRnFrcDdtdHJyTnMvWk1WQzYrWVVqTFNjOGMxdjhzNFJqOTZGYUdpeDhk?=
 =?utf-8?B?dlIrUUFMeFhyVjdKRzZZRFh1OWZ3K3FSSTIrTEoxTTNGN3pqa251Yjk4WWwv?=
 =?utf-8?B?c3A5ZGt0Y0JYblMwQUJ0UGtBV29FL3RVTTJjNUlUVTY4OEhPeUxQV2h5S2dj?=
 =?utf-8?B?dWJKejBtTEhhTm9aY2E5V2FRdWY4dmFHSEM3VjVQMlNvblZOTytiNkFGMUlw?=
 =?utf-8?B?ckgyM2dIT0lZdStFM3V6dmIzOCtLR2xhWnNLOS9td2FQQTBKY2RpOWpBR2Vu?=
 =?utf-8?Q?ynoIlbQwJRvQO50ws+1CJJQ7eLfjXRwJU2IpVN2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmJQS1pUbC9QQkc3SENLbmxScHc1UVFzMFVOM0ExYkpRS2xGN0lidDMwWUtm?=
 =?utf-8?B?R3RMR1BYKy9TYUQrM3dHR0Y0L2NJM05tVTZqVVZudmdONmJsV0hDdDlVY3Fo?=
 =?utf-8?B?OHFXZ005UHRhdDNtbXdab0NwYlZwc1cxMFR3ZVlPbUVxNTZlT1ZPblRuSThN?=
 =?utf-8?B?elFPV0w3Y2dtcUQzZE1jUnVBMlVYOWs2bnc5K1J2Skd0L2w5TWFMSGNwVUYy?=
 =?utf-8?B?TXRzdnd1dlgzOVp5SjFUSFV4Wk5Fb2hOU2R1c0pYR0FBUG9KNU0rRnJGa21m?=
 =?utf-8?B?MFJoN3huZnR0QjdKVDBkdXhnUlJaUjE5OUU0eVY5WG5TQWUvVlBZVVFHN2ZJ?=
 =?utf-8?B?VVk3T3VMZy9yUG1CTlNpMmxRUXZvTThENDMwUkQxRGVjS3RQUUZJZTljL2d3?=
 =?utf-8?B?ZDRydmZpOG8xVjhjakZueWExUjN1QkxtOTBybTFRK0ljWWhNcjJlak9WYjBM?=
 =?utf-8?B?U3dFSGZvSjFxWHVLWVhCVXM5MEtsdkRaQnAzQ3dvWHJ2RXo5QU12K3hHNmkv?=
 =?utf-8?B?THI3a3RPL0wzREhDcDBUTTBSbjArSi9YS2hyOEhVRi9lV3p3NVhSdWhPM1Nl?=
 =?utf-8?B?VGRnY2lVSlJyOE9nK2pzblJQSVMwWU1OQUxseGp5ei9IU2tGMzNTSWN3a0R3?=
 =?utf-8?B?ZFVyTDBJSHZxdkJhR0VGbk1EUXcxbS9TV2tyeGVJVUxSVUxacGFaa3RzOFJx?=
 =?utf-8?B?RHFtclF6bC8vcHloUUc5ZHRnd25BWXBteFVrZkV1VVNQY3ZSeFpnWFRlMU0x?=
 =?utf-8?B?WVBheFI5WnozS29lQXpWZzVUbXA3ZGliNWxYVWlxVWUvYVZCNkR5dTBCK1FM?=
 =?utf-8?B?elduUmxjM1lpMmxNaHpQL1Z2eXZSNWMxMUg4Z0JsRFU3aWlYc1FqUy9xdTA0?=
 =?utf-8?B?ajhXYjBzdmhEUDdnZlFqWFpVV0s5bUVIbUZhaUZuUXllQmkrNXN1Q09pbzdS?=
 =?utf-8?B?dzJQUjRSUEY4U2Z5akoxaDlOZnJMb0NYUU5GSlo5Z1hBaThxa0NWM01DaU9F?=
 =?utf-8?B?cjl0WmNmNHpCcWRJb1JDdWNBOXpQR2ZidXJFQy81SldPbTRPVnovL3pPems4?=
 =?utf-8?B?SUhyK0lObGNxR0duZUVobHFnS1NYWlRTWnNUM1FHSENIbUNrNzZ5K2I5KytR?=
 =?utf-8?B?MEN5emYxaDNmdnJoSnRQV2dsU0pGemxvTG5kdWRmRGRsRlhxZ3pxN3FVQWxS?=
 =?utf-8?B?UnBaZDUwWFJ3R0d3Rk1uRGRaZ0Vnb3hpTm1MY1ZYUHRCQlI5UmJZdXBNelpY?=
 =?utf-8?B?NHpyZEZBb2FHSkNlbDlEM05xejNPNTlHMWJTeHkyTVZoQUUvR0pQVytINHhM?=
 =?utf-8?B?Sy9JeldrdktReDF2VVd6VWJoU0RrM3FhVjNSYzY2cEJNVlBlTDNHSlQ4d1g4?=
 =?utf-8?B?QmpNZTFyNStKZy94K3RhYVpURFNvVmo3L1huU2daak5GOTlnV3BvaCtIdjN1?=
 =?utf-8?B?dmQxcXM0QSs1eWdhcXRIRklzM2hlb0NTd3RkaktNS0V3Y3hLMy9ZMzNnTnhP?=
 =?utf-8?B?VktiWXoxZ3pEb3NUQzNpZGczcVFkeGFHc2hGSWJoQ3RzQWQ0NG8wVWl4ZThD?=
 =?utf-8?B?aUZiMGo1RTIzbCt3VTE5bzdZbkpEa2puWFBKOTU0SnB3RS9PMzFGZ3JDZ2Rl?=
 =?utf-8?B?VmdoRGxHUldWYnBuNmMrWi9CYTZ4SlFkVEd2THF0MDRKRXJsdFJEU1NjUHpq?=
 =?utf-8?B?TGtIMFdhbHBNVEhiTDhta21FSEFpY2lnR0dSYzhmREc0dnlRR0pyeUhxM3Rj?=
 =?utf-8?B?dmxuNFhGUkk0bmUxb0JnK0ZVSGZaajhSZGtuczZ0NWgyelBrTWtzMEEvQjVC?=
 =?utf-8?B?RTlOeU0yNDgwc2tHeU9VU0ZZcnc5aXVkWFJtdngwQWlFOFkrbVl4Wm9RRU8r?=
 =?utf-8?B?OXZLbi91Q2EwS1o3N0tCWm1uTmROLzBGOTFQVmJwWTlzejFZV2NIMVo0S2w3?=
 =?utf-8?B?QmoxeURvb2ZSZXhpNnRaS0dJakNrNzdJMlZiMFFYa3puZTZRcTRSSEtIektt?=
 =?utf-8?B?b3doNFVSVHpiMzhCamtxRkN6bGs5cU5hZGxWLzY4MTlybGxZbCtJNTc4MGlU?=
 =?utf-8?B?SWhiZUV4L0FUZDZQU242NFlQa2J6WWxUN3IzVjJrODdtbkphSEVHYkhONVY0?=
 =?utf-8?Q?2240=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5225fcfe-256f-41f8-4168-08dd04c45d05
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 15:52:37.7100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMOcNY72BOtX0EAYq8YNfBB45WqSVgpGFXe4T9xOtg0i9Q+fCqP6p5ymV20Eg1fcK/AF4S3X2o6uRHD3ElPvuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiBGcm9tOiBUdnJ0a28gVXJzdWxpbiA8dHZydGtvLnVyc3VsaW5AaWdhbGlhLmNvbT4NCj4g
U2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxMywgMjAyNCAxMjozMQ0KPiBPbiAxMy8xMS8yMDI0
IDE3OjAxLCBMaSwgWXVueGlhbmcgKFRlZGR5KSB3cm90ZToNCj4gPiBbUHVibGljXQ0KPiA+DQo+
ID4+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+
ID4+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTMsIDIwMjQgOToyMiBBbSAxMy4xMS4yNCB1
bSAxNDo1MyBzY2hyaWViDQo+ID4+IExpLCBZdW54aWFuZyAoVGVkZHkpOg0KPiA+Pj4gW1B1Ymxp
Y10NCj4gPj4+DQo+ID4+Pj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2Vu
aWdAYW1kLmNvbT4NCj4gPj4+PiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDEzLCAyMDI0IDY6
MzkgQW0gMTMuMTEuMjQgdW0gMTE6MjUNCj4gPj4+PiBzY2hyaWViIFR2cnRrbyBVcnN1bGluOg0K
PiA+Pj4+PiBPbiAxMy8xMS8yMDI0IDA4OjQ5LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOg0KPiA+
Pj4+Pj4gQW0gMTIuMTEuMjQgdW0gMTk6MTYgc2NocmllYiBMaSwgWXVueGlhbmcgKFRlZGR5KToN
Cj4gPj4+Pj4+PiBbU05JUF0NCj4gPj4+Pj4+Pj4+ICsgICBzaXplID0gc2lnbiAqIGFtZGdwdV9i
b19zaXplKGJvKTsNCj4gPj4+Pj4+Pj4+ICsgICByZXMgPSBiby0+dGJvLnJlc291cmNlOw0KPiA+
Pj4+Pj4+Pj4gKyAgIHR5cGUgPSByZXMgPyByZXMtPm1lbV90eXBlIDoNCj4gPj4+Pj4+Pj4+IGFt
ZGdwdV9ib19nZXRfcHJlZmVycmVkX3BsYWNlbWVudChibyk7DQo+ID4+Pj4+Pj4+IEFnYWluLCBp
dCdzIGEgY2xlYXIgTkFLIGZyb20gbXkgc2lkZSB0byBkbyBzdHVmZiBsaWtlIHRoYXQuDQo+ID4+
Pj4+Pj4+DQo+ID4+Pj4+Pj4+IFdoZW4gdGhlcmUgaXNuJ3QgYW55IGJhY2tpbmcgc3RvcmUgdGhl
IEJPIHNob3VsZCAqbm90KiBiZQ0KPiA+Pj4+Pj4+PiBhY2NvdW50ZWQgdG8gYW55dGhpbmcuDQo+
ID4+Pj4+Pj4gSSBkb24ndCBoYXZlIGEgcHJlZmVyZW5jZSBlaXRoZXIgd2F5LCBidXQgSSB0aGlu
ayBpdCBzaG91bGQgYmUgYQ0KPiA+Pj4+Pj4+IHNlcGFyYXRlIGRpc2N1c3Npb24gdG8gcHJvcGVy
bHkgZGVmaW5lIHdoYXQgZHJtLXRvdGFsLSBtZWFucy4NCj4gPj4+Pj4gVG90YWwgbXVzdCBzaG93
IHRoZSB0b3RhbCBzaXplIG9mIGFsbCBCT3Mgd2hpY2ggZXhpc3QgZXZlbiBpZiB0aGV5DQo+ID4+
Pj4+IGRvbid0IGN1cnJlbnRseSBoYXZlIGEgYmFja2luZyBzdG9yZS4gVGhhdCdzIGhvdw0KPiA+
Pj4+PiBkcm0tdXNhZ2Utc3RhdHMucnN0IGRlZmluZXMgdGhlIGZpZWxkIGFuZCB0aGF0IGlzIGhv
dyBhbGwgdGhlIG90aGVyIGRyaXZlcnMNCj4gd29yay4NCj4gPj4+PiBJbiB0aGF0IGNhc2Ugd2Ug
c2hvdWxkIG9ubHkgbG9vayBhdCB0aGUgcHJlZmVycmVkIHBsYWNlbWVudCBhbmQgbm90DQo+ID4+
Pj4gdGhlIGJhY2tpbmcgc3RvcmUgYXQgYWxsLg0KPiA+Pj4+DQo+ID4+Pj4gQnV0IHRoYXQgbWFr
ZXMgdGhlIHRvdGFsIGlkZW50aWNhbCB0byB0aGUgcmVxdWVzdGVkIHZhbHVlLCBkb2Vzbid0IGl0
Pw0KPiA+Pj4gWWVzLCB0aGUgaXNzdWUgaXMgbm90IHdoaWNoIEJPIG5lZWRzIHRvIGJlIGNvdW50
ZWQgYnV0IHdoZXJlIHRoZXkNCj4gPj4+IHNob3VsZCBiZQ0KPiA+PiBjb3VudGVkLiBUaGlzIGdl
dHMgbW9yZSBjb21wbGljYXRlZCBpZiB3ZSBjb25zaWRlciBCT3MgdG8gcHJlZmVyDQo+ID4+IG11
bHRpcGxlIHBsYWNlbWVudHMuDQo+ID4+Pg0KPiA+Pj4gSU1PIGl0IG1ha2VzIHNlbnNlIHRvIGhh
dmUgZHJtLXRvdGFsLSB0byB3b3JrIGxpa2UgdGhlIGxlZ2FjeQ0KPiA+Pj4gYW1kLXJlcXVlc3Rl
ZC0NCj4gPj4gd2hlcmUgd2UgbG9vayBhdCBCTydzIHByZWZlcnJlZCBwbGFjZW1lbnQuIEZvciBt
dWx0aXBsZSBwcmVmZXJyZWQNCj4gPj4gcGxhY2VtZW50cyB3ZSBzYXkgdGhhdCB0aGUgaW1wbGVt
ZW50YXRpb24gbmVlZHMgdG8gcGljayBvbmUgb2YgdGhlbQ0KPiA+PiB0byBhdm9pZCBkb3VibGUg
Y291bnRpbmcsIGJ1dCB3aGljaCBvbmUgaXMgdXAgdG8gdGhlIGltcGxlbWVudGF0aW9uIGFzIGxv
bmcgYXMNCj4gaXQncyBkb25lIGluIGEgY29uc2lzdGVudCBtYW5uZXIuDQo+ID4+IERvZXMgdGhh
dCBzb3VuZCByZWFzb25hYmxlPw0KPiA+Pg0KPiA+PiBZZWFoIHRoYXQgd29ya3MgZm9yIG1lLiBK
dXN0IGRvbid0IGxvb2sgYXQgYm90aA0KPiA+PiBiby0+cHJlZmVycmVkX3BsYWNlbWVudCBhbmQg
Ym8tDQo+ID4+PiB0Ym8ucmVzb3VyY2UgYmVjYXVzZSB0aGF0IHdpbGwgY2VydGFpbmx5IGJlIGlu
Y29uc2lzdGVudCBpbiBzb21lIHVzZSBjYXNlcy4NCj4gPg0KPiA+IG9vZiwgZnJvbSB0aGUgY29t
bWl0IG1lc3NhZ2UgaTkxNS94ZSBpcyBkb2luZyB0aGUgZXhhY3Qgb3Bwb3NpdGUsIEJPIGdldHMN
Cj4gY291bnRlZCBpbiB0aGUgdG90YWxzIGZvciBhbGwgdGhlIHBvc3NpYmxlKHByZWZlcnJlZD8p
IHJlZ2lvbnMuDQo+DQo+IFdoaWNoIGNvbW1pdCBtZXNzYWdlPyBJIHdhcyBkb2luZyB0aGF0IGVh
cmx5IGR1cmluZyBpOTE1IHBhdGNoIGRldmVsb3BtZW50IGJ1dA0KPiBzdG9wcGVkIGluIHYyOg0K
Pg0KPiBjb21taXQgOTY4ODUzMDMzZDhhYTRkYmI4MGZiYWZhNmY1ZDliNmEwZWEyMTI3Mg0KPiBB
dXRob3I6IFR2cnRrbyBVcnN1bGluIDx0dXJzdWxpbkB1cnN1bGluLm5ldD4NCj4gRGF0ZTogICBU
dWUgTm92IDcgMTA6MTg6MDYgMjAyMyArMDAwMA0KPg0KPiAgICAgIGRybS9pOTE1OiBJbXBsZW1l
bnQgZmRpbmZvIG1lbW9yeSBzdGF0cyBwcmludGluZw0KPg0KPiAgICAgIFVzZSB0aGUgbmV3bHkg
YWRkZWQgZHJtX3ByaW50X21lbW9yeV9zdGF0cyBoZWxwZXIgdG8gc2hvdyBtZW1vcnkNCj4gICAg
ICB1dGlsaXNhdGlvbiBvZiBvdXIgb2JqZWN0cyBpbiBkcm0vZHJpdmVyIHNwZWNpZmljIGZkaW5m
byBvdXRwdXQuDQo+DQo+ICAgICAgVG8gY29sbGVjdCB0aGUgc3RhdHMgd2Ugd2FsayB0aGUgcGVy
IG1lbW9yeSByZWdpb25zIG9iamVjdCBsaXN0cw0KPiAgICAgIGFuZCBhY2N1bXVsYXRlIG9iamVj
dCBzaXplIGludG8gdGhlIHJlc3BlY3RpdmUgZHJtX21lbW9yeV9zdGF0cw0KPiAgICAgIGNhdGVn
b3JpZXMuDQo+DQo+ICAgICAgdjI6DQo+ICAgICAgICogT25seSBhY2NvdW50IGFnYWluc3QgdGhl
IGFjdGl2ZSByZWdpb24uDQo+DQo+IF5eXiBUSElTIF5eXg0KPg0KPiAgICAgICAqIFVzZSBETUFf
UkVTVl9VU0FHRV9CT09LS0VFUCB3aGVuIHRlc3RpbmcgZm9yIGFjdGl2ZS4gKFRlamFzKQ0KPg0K
PiAgICAgIHYzOg0KPiAgICAgICAqIFVwZGF0ZSBjb21taXQgdGV4dC4gKEFyYXZpbmQpDQo+ICAg
ICAgICogVXBkYXRlIHRvIHVzZSBtZW1vcnkgcmVnaW9ucyB1YWJpIG5hbWVzLg0KPg0KPiBJbiBj
b2RlIHRoYXQgd291bGQgYmUgaGVyZToNCj4NCj4gc3RhdGljIHZvaWQNCj4gb2JqX21lbWluZm8o
c3RydWN0IGRybV9pOTE1X2dlbV9vYmplY3QgKm9iaiwNCj4gICAgICAgICAgIHN0cnVjdCBkcm1f
bWVtb3J5X3N0YXRzIHN0YXRzW0lOVEVMX1JFR0lPTl9VTktOT1dOXSkgew0KPiAgICAgICBjb25z
dCBlbnVtIGludGVsX3JlZ2lvbl9pZCBpZCA9IG9iai0+bW0ucmVnaW9uID8NCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvYmotPm1tLnJlZ2lvbi0+aWQgOg0KPiBJTlRF
TF9SRUdJT05fU01FTTsNCj4NCj4gU28gZWl0aGVyIGFjdGl2ZSByZWdpb24gb3IgU01FTSBpZiBu
byBiYWNraW5nIHN0b3JlLiBNYXliZSB0aGF0IHNob3VsZCBiZQ0KPiBpbXByb3ZlZCB0b28uIEdy
ciAodG8gbXlzZWxmKS4NCj4NCj4gSSBkb24ndCBzZWUgeGUgaXMgY291bnRpbmcgdG90YWwgYWdh
aW5zdCBhbGwgcmVnaW9ucyBlaXRoZXIsIGFwYXJ0IHRoYXQgbWF5YmUgaXQgaGFzDQo+IHBvdGVu
dGlhbCBudWxsIHB0ciBkZXJlZj8NCj4NCj4gc3RhdGljIHZvaWQgYm9fbWVtaW5mbyhzdHJ1Y3Qg
eGVfYm8gKmJvLA0KPiAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZHJtX21lbW9yeV9zdGF0
cyBzdGF0c1tUVE1fTlVNX01FTV9UWVBFU10pIHsNCj4gICAgICAgdTY0IHN6ID0gYm8tPnNpemU7
DQo+ICAgICAgIHUzMiBtZW1fdHlwZSA9IGJvLT50dG0ucmVzb3VyY2UtPm1lbV90eXBlOw0KPg0K
PiBPciBpcyBiby0+dHRtLnJlc291cmNlIGFsd2F5cyBwcmVzZW50IGluIHhlPyBBZGRpbmcgTWF0
dCBhY2NvcmRpbmcgdG8gZ2l0IGJsYW1lLg0KPg0KPiBSZWdhcmRzLA0KPg0KPiBUdnJ0a28NCg0K
VGhhbmtzIGZvciB0aGUgYmFja2dyb3VuZCwgeWVhaCBpdCB3YXMgbWVudGlvbmVkIGluIHRoZSB4
ZSBjb21taXQsIGFuZCB0aGUgaTkxNSBjaGFuZ2VzIGxvb2tlZCB2ZXJ5IHNpbWlsYXIgc28gSSB0
aG91Z2h0IEkgc2hvdWxkIHByb2JhYmx5IG1lbnRpb24gaGVyZS4gTm93IEkgZHVnIGFyb3VuZCB0
aGUgbWFpbGluZyBsaXN0IGFuZCBzZWVtcyB0aGVyZSB3YXMgc29tZSBjb25mdXNpb24gYW5kIHRo
ZSB3cm9uZyBjb21taXQgbWVzc2FnZSBnb3QgbWVyZ2VkLg0KaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvYXJjaGl2ZXMvaW50ZWwteGUvMjAyMy1BdWd1c3QvMDEwODg1Lmh0bWwNCg0KDQo=
