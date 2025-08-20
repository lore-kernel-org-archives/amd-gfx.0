Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF82CA0EF8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 21:49:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C70EA10E7FE;
	Wed, 20 Aug 2025 21:49:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i+f7yfUX";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A32B10E7FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 21:49:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgRQKg6Hh4zWlb04q2+0qGU7nHLr0MOKVgGyXmHZub28o/NL8o+ox3ToH1I6SaPiqVhJ4EWTlNnv7FkyJRZ4WlC39h6qruXXbLgY1nNUO72x+Y7yoXE0QC63L6kLHEZEgoQsultVH5LkQ6qQDnozwWQ1OD+QABYaqqY3ljkmFqMuEs06//dSMpvD0BfH0FAZ2+dNVbqQRo0zPrBouw3CrUyxmqBfeZLuiveefdfjzdbAw0Jv02SXeoWKiCrihw+5HRd/PEv9gp9haJ5ZMZH7A/WNlcVf1Gc0akVO8bBZ5aN158yFT++2rAcwPNFOcxEZEZMcAwjbJ/v50JmMHvKrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku9sxQr9e9xR62EhF9ZxFWcZI7xy6/XbOpw4JQtG/t8=;
 b=DozOXg69qdzDWGiFffd3pfOcSELTwx95z7QP5MtaFgKr3ifyLJt8tMb8EThNjHCebCfOU/kbjhCZvQ9dBQ+83UvJty4nx3bA9+3NVUKJb9m+lvwmduyaqwreRPSYWiwImpJdZM450hTbaLUhi0w3V5xTLPq3L1ZX2lG/NoK64OqbsRZME6fsG8/bDR4zZah2uA25jnFSSLSA0LsVZeE81byJCViIafEcJcUgbeRRAdcn9al8i9DlK1XFg/iosI8i2UA1dddYNFD7X6Ximh1NWmSdc7B/HH/2geWF7Cy1ULCrwvtALKZYhZir770vc3DM85cTRME5U7IW4sv0FLxVvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku9sxQr9e9xR62EhF9ZxFWcZI7xy6/XbOpw4JQtG/t8=;
 b=i+f7yfUXJTJcwk2GOmx3kuzE7tirLTvc9IvS70uIUbMrQvsndxSvp2jdJPv6r74dHbY9BjRCmHZUTvs5saOyWYSqAlBqkp9RFf7nEP3EL6RmsLvFDuGPZZCYLHzgB8CXycuX64oeM+WQarZdj/i1keXxLGLEQ+wcIxxlqq9cUC0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 21:49:31 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.9009.018; Wed, 20 Aug 2025
 21:49:31 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC PATCH 4/7] drm/amdgpu: Add mmio_remap fields to amdgpu_device
Thread-Topic: [RFC PATCH 4/7] drm/amdgpu: Add mmio_remap fields to
 amdgpu_device
Thread-Index: AQHcEcZBP5O+rknIiEy4OTevG3f967RsCEMAgAAMg+A=
Date: Wed, 20 Aug 2025 21:49:31 +0000
Message-ID: <BL1PR12MB514462D354F4C2AEF0B8423DF733A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250820113254.3864753-5-srinivasan.shanmugam@amd.com>
 <BL1PR12MB5144D6009B4CDB9327AA805EF733A@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144D6009B4CDB9327AA805EF733A@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-20T21:03:51.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA3PR12MB9225:EE_
x-ms-office365-filtering-correlation-id: ff335181-7bad-4455-de8d-08dde03371e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?ZE9UWkx0ZlB2Y3Z2T1FTM1VNRlBJV2xCeE5WNFRCcEZUd1dQZDZNQitSa1lo?=
 =?utf-8?B?aXY3M0Z1d0ZLcEJlQXZON25TMzJadGkxei9UaXNKZG4yRGtGRzdWb1FSQlFx?=
 =?utf-8?B?T0lDQ0RWRDh1eGdwODRsMzNhVUx5UUMrSFFId1B0cW4rOGZ0SXBMNm1wTUM0?=
 =?utf-8?B?dnBEUi9DLzQ5QkNFc1lFcTR5WHpOb0l3SllUUnNEWGN5bXpFVlpYamMrOHJC?=
 =?utf-8?B?UVlxc0V3Z1JjYkRBMU1hNnI3b0FKT3ZNQzhjOVJWUnc5aURXZVAvQmRlVTdT?=
 =?utf-8?B?RUJhcVljMlMzZEdCWHN4OGlTN05IM25CbEZxVlNqQkNPYmNFWE9aQ1dndDlR?=
 =?utf-8?B?ZnRMd1hYcml5Lyt0aE54UHkrZUNrWkJWaSsraTM0NVd2a3ZCQjRCNGI2OE03?=
 =?utf-8?B?TjlXS0VOTGRhYUtwQUFHaGZ6a3o0WFFqZmFlNllRS3dCeEs0U1JhVmxlTjlE?=
 =?utf-8?B?NnBGQVFkNTNOYUl4c3lTT2EyZzl0Q2VGY2dmamIzKytKSTl2eW5sUEx4ck5O?=
 =?utf-8?B?ZXFCMTd5WDcyeXZ3bXphV091VTgvbWxpaGVwVk5WMGs0cDZ5SkR1V3ViUEIz?=
 =?utf-8?B?TGNYRExydUI3VmdnUzNMTGF0VU9OdklOMlZxS255bVJKTUJrQXByaHg1Z2hQ?=
 =?utf-8?B?SUpuUHJDY21xem9WczVvc2NvRVVBT0s1SEd1c25EVStib3RlUmFsUVJFYnZK?=
 =?utf-8?B?NXN3NWR3ZkFmczNUeTJqc2FjWFl1dS9Yd1d3ZUQ3ZjAzL2JXNzJxdU1panRT?=
 =?utf-8?B?SWdMWk5aTWRFYWFJeW93NlNnNTVlUUoxOU9lYnR1OG9nd3NSTnBiQU53L09u?=
 =?utf-8?B?V1ZvL0EzaGlMRHlEVWdWK3BVdXBJRjcvd2Y2NHRqdGczQVRvd1JjSVhaSHI2?=
 =?utf-8?B?OThWOSs0UVhNTWNkT05PUzNLVUQ1TmRObnVZUTh2aTdaNWcrb0cxNS9naHdx?=
 =?utf-8?B?VjJJTHhPNEZ6aUtuNDkvOFV3SVlCZEFlOVZicjk1VUFjeFNYL1pka0pvdm9a?=
 =?utf-8?B?RE9vVGJLM0hkY3hKS01vMzFPUGRZbFlVdXUyV2V0MW03WFlwckRta011N1Nz?=
 =?utf-8?B?Y3ZJOGJDcFdKbEp0d2FtcThUZFlTOFBaR1N4d3lleG1aV0UxcExxQkhuQmNP?=
 =?utf-8?B?MTAyUDQ4MXVrOGkzVHNDMkZ2TGF5Y0MrbVQzdEMzVllOUUxtL092cWxsTUc0?=
 =?utf-8?B?aFJJYUc1OTBFSjJHbVN5M1Q0SkkzK1VVYW9LU1ZWVFdkanZCb3VVa01CalpQ?=
 =?utf-8?B?TjZjZURvREY1UmpaTWJkdlFpT0h4RC82UmxTTmVqYjcvbk1teVVQOFlYaFht?=
 =?utf-8?B?RENaYjh3aE00cU9HRzdOVGdubUhQRFhZeXNoeTFsMng4aFBZWkhFK0J0N0Js?=
 =?utf-8?B?cVdvZU4rN0FNckxYcEl4dDVYMEFBNktmTjVlc2F5RC92dXRKVmUySW9DNVo1?=
 =?utf-8?B?MUhoNHBuSm1ocFdWVCs5V05aMHlwQmVrbDVvakxkT0RycXFPbjV5ek5lNmFZ?=
 =?utf-8?B?TWNjYk9mR1BkUWpxSXZmVjZxNzJXQ1ZlR1Z0dUpwdTBONy9oSDFEdnNVbnRO?=
 =?utf-8?B?aFJncnBxaUp5T0VDaVJHaVk5SWRFYnRKMUw1Uk1vQSs0c01rNEVnbWl6MjhU?=
 =?utf-8?B?NjUxUDcvMUFzdWE2UG4vaVcyRCttT0M1ZzI2NHdOQkFOWGJXOW55RXdON0VX?=
 =?utf-8?B?bmh1cGtuNjY4THJYQ3M0L0pubU4yNUtBSUlBdjdaZ1JLWEoxZ21mMnRxTWVk?=
 =?utf-8?B?WXlDTXJLUWVnSlZRMlkvNmk2NUgvc0ZnemtBOW1Xd2MrUFByMFlDeXhYdE5F?=
 =?utf-8?B?b2NXS3dhS2RoMXlsRTNvYlk2ZHIrbXRUdmVML2pQL01FZHgzUExEU0srZTFL?=
 =?utf-8?B?M3R0MGc0S29TT0VuTkdyMXR6UGRDV3F4QkNiMVc0cGFEWDRjMjRTU2NiNjNt?=
 =?utf-8?B?UngrSlJubkY1VDRlM2l5aG5kdWZIeU12Y1EzdnViamYzMzdjK1NZSFdOczdy?=
 =?utf-8?Q?w3bz8UvzWgnJBxEkZMMiB5T2W/ZfhI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2RQYzBBMDNGUGdxUnVFVjBYUjk4RVI4ZDZIRW1aZmVQbWdFUTlzRXNIVzNL?=
 =?utf-8?B?ZlA4d2VGSnBsd09lbVZ2L2w4aXdZTUQrUDdac3BETUtsbU1IY3hQaXVWR3Rp?=
 =?utf-8?B?czdQUTVMRU5oQTh3RzhQbzNnS0kxV09PVWZXVjNhdW1jM1U3Q1VxSXl5OVZC?=
 =?utf-8?B?bklvbHhFV2x4anJjRk84U3Rvc3BqSHI5K0VzS0NjdUNOWTZPSFRYTExQMEVS?=
 =?utf-8?B?TmZaYndsT3FNYXV2ZWtvMVkvK1FEZXNsby9IN0l2aTNqZlJ1L2ZxTjNjSFVM?=
 =?utf-8?B?L1d5L0ovM2ZnWGZ5QmpINmpaVnRBS0xlUXRIaTZKR1lPeEZqUzZxbjV2L3Bv?=
 =?utf-8?B?L04vaTRQM1RMRmVrMWo3cGp5ZUI5cFVXeWJHZnRIL0ZvUVdUcWZudVNENXl4?=
 =?utf-8?B?VVBZcFplU0t0Q09QbkFKREpFaTJuVW5aU0F2VlRySEVwOXkzU1o4dDhhaDdE?=
 =?utf-8?B?ZEFyaVBDVXZ4L2FZdE12K3FqWC9pRGk4RWljUUVvejVXQ3o2UWs0eHdrT2I2?=
 =?utf-8?B?dUJSZmYzc3VLZVhFRFJTTE1lY0laY2YwVVBpTGtLdTd4OFM4YTF6TWwrY0NH?=
 =?utf-8?B?M1dUZUxKVTVXWktxQmgwb3l1blh5c1ZJQjRaeUVablQwYlhoZmhNVHViSWlE?=
 =?utf-8?B?Z2RTSGUxSlZDRWlQN2UyQm1Pb1ZrT1JxMXhwRHVMRUNralF5ZU5pRjZzdWow?=
 =?utf-8?B?VHFHa3ZEVVRCR3hvSE5SN241YlZJaVNMVkhETVBZNWNSUDdyU1grTlNxWTJo?=
 =?utf-8?B?QmloM1YyVkhsRjlVR1EzK1NIWVU4c0JKdFc1Sy9HRDREcnZBSy9jRFZVYTNZ?=
 =?utf-8?B?aU5FQjZ6Vnh4S09PTlRjdUpRbU1qSmoyUm1EaFE5MXZma2tTekxCUnRLSmhu?=
 =?utf-8?B?MGZTUFcyTkRpZUVtT2lUeEo1ejgzTHdhNzN3elNBRWZCWWtGVkxBSEU3Tmwy?=
 =?utf-8?B?UWpFQTVyRlZKV0lhdFRoTk0rYTN1V2pwM1Vsbms4YmM4dTRyQVpWSFFQWW5t?=
 =?utf-8?B?bkduNXNXZkdTc2hrUnoza1pUVjNHaGhhVlQzYllQNGFzZGFqdWVEV1VvdXho?=
 =?utf-8?B?Z245eHIrejAvQ0ZTRHRQSzlETEp5TnJ1S0d5UmZYeG5NZklVM1pnWEN0cDhw?=
 =?utf-8?B?TDRRTUFpMkZTOUsxU0lMK05nSUUxOVdadTJsdmY2QlZRSHQxM1VLS3Y0OEk4?=
 =?utf-8?B?UGNDNWphWnAwTUYrNXE5bWpTcDdGNDh0clBkRHFtYlRJT0w5d0d0N2FRenB2?=
 =?utf-8?B?aTYycVlVdEZsMjN1Smpqck94VW9ua2ZVelhTTWJoMHJRTTVoNkZlUDJIQThl?=
 =?utf-8?B?RHNLOEVUOVRZcE5vZ1F6OGtBMnUycm9FeEdnN3poSVhsbUYyK1JVS0U2N3RM?=
 =?utf-8?B?TWkyV0t5ampiaDNaQ1BTdW8vczJ3Z0dWbFpzQ2pLZURIK3VIUGRGZExCWXQx?=
 =?utf-8?B?cDVnUFluajBXd0tTR01DTHFxWlZVYWNTbTFjVGRwWkFoN2JnQnhHQ3VNRllz?=
 =?utf-8?B?bFRkNWM2T3VnOGtxeHZKN0xGQ0dkWms4a0ZCcSttZEx3dlkxMUREQUdUVHRy?=
 =?utf-8?B?aTZad05SQjBOQ2xVNVM1d3IwVXV3aWVDK28rMHB4d1NJNUpNRng2YXVBRkx6?=
 =?utf-8?B?S0xpOEVlendFbHZoN3RSZlhLTzBxMWx4cEgrQ0x0c3lkKzhOV1VzL2loVmtt?=
 =?utf-8?B?cUZOdTJPTEMra0ZqdmxzUVY5UXBndDVCNlhWNmJKcE42dVI3ZFJYOGk5dC9N?=
 =?utf-8?B?NUdxZ2swUDZGZmJBVkcxZHgrUHF4aUhhRnVSVVk0K29Ya3dwdElCZnhhSFpw?=
 =?utf-8?B?TkJyRjNwSTMwKzdRUkFGbHlqUEszajI5NlRVVEtkeWYyRzVCdStsTG83VWtO?=
 =?utf-8?B?aGovOHljckMycFNTNVMzQ1hUUXFlRzZHYWdPMDNXbmJKYWFIZTdoVnlWd2FH?=
 =?utf-8?B?NUc4aVo5NkNYSUhDT1BhSWFRZnhyZG5LV3EvV1piOGcvYm45T3F1eFpzektl?=
 =?utf-8?B?K3BRanVwY2g3WG9rUDNiN1pwTWxyUTBWUkxrb2luMFFQN1JoVGVNekhuUVBO?=
 =?utf-8?B?RnREVmpuUVc3dWhFY2swZjRwT2xZSGE2SnlHYVRGcFBjWTlqenhOa2JZK0dh?=
 =?utf-8?Q?oHBY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff335181-7bad-4455-de8d-08dde03371e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 21:49:31.4905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdIRSbsfuJobUDwqC3S7W+o1z3Q8EAkQP7IH7y64jkE+me8fAf2s+ZRy0U+uzQsLBUGZ7RbC0OOc1fWa/r9Y+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBhbWQtZ2Z4
IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgRGV1
Y2hlciwNCj4gQWxleGFuZGVyDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDIwLCAyMDI1IDU6
MDggUE0NCj4gVG86IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJTklWQVNBTi5TSEFOTVVHQU1A
YW1kLmNvbT47DQo+IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSRTogW1JG
QyBQQVRDSCA0LzddIGRybS9hbWRncHU6IEFkZCBtbWlvX3JlbWFwIGZpZWxkcyB0bw0KPiBhbWRn
cHVfZGV2aWNlDQo+DQo+IFtQdWJsaWNdDQo+DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiBGcm9tOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FN
QGFtZC5jb20+DQo+ID4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjAsIDIwMjUgNzozMyBBTQ0K
PiA+IFRvOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1
Y2hlciwgQWxleGFuZGVyDQo+ID4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+ID4gQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBTSEFOTVVHQU0sIFNSSU5JVkFTQU4NCj4g
PiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT4NCj4gPiBTdWJqZWN0OiBbUkZDIFBBVENI
IDQvN10gZHJtL2FtZGdwdTogQWRkIG1taW9fcmVtYXAgZmllbGRzIHRvDQo+ID4gYW1kZ3B1X2Rl
dmljZQ0KPiA+DQo+ID4gQWRkIGJvb2trZWVwaW5nIGZvciB0aGUgcmVtYXAgcGFnZSB0byBzdHJ1
Y3QgYW1kZ3B1X2RldmljZToNCj4gPg0KPiA+ICogbW1pb19yZW1hcF9ibyAoc2luZ2xldG9uIEJP
KQ0KPiA+ICogbW1pb19yZW1hcF9iYXNlLCBtbWlvX3JlbWFwX2JhcnN6IChyZWdpc3RlciBCQVIg
YmFzZS9zaXplKQ0KPiA+ICogbW1pb19yZW1hcF9vZmZzZXQgKEJBUi1yZWxhdGl2ZSBvZmZzZXQg
b2YgdGhlIHJlbWFwIHBhZ2UpDQo+ID4gKiBtbWlvX3JlbWFwX3NpemUgKFBBR0VfU0laRSkNCj4g
Pg0KPiA+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQo+
ID4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1k
LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1Lmgg
fCA3ICsrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oDQo+ID4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaA0KPiA+IGluZGV4IGRkZDQ3MmU1
NmY2OS4uNmM0Nzc1OTY2MTdiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdS5oDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1LmgNCj4gPiBAQCAtMTAzOCw2ICsxMDM4LDEzIEBAIHN0cnVjdCBhbWRncHVfZGV2aWNlIHsN
Cj4gPiAgICAgICBhbWRncHVfYmxvY2tfd3JlZ190ICAgICAgICAgICAgIGF1ZGlvX2VuZHB0X3dy
ZWc7DQo+ID4gICAgICAgc3RydWN0IGFtZGdwdV9kb29yYmVsbCAgICAgICAgICBkb29yYmVsbDsN
Cj4gPg0KPiA+ICsgICAgIC8qID09PT09IE1NSU8gcmVtYXAgKEhEUCBmbHVzaCkgYm9va2tlZXBp
bmcgPT09PT0gKi8NCj4gPiArICAgICBzdHJ1Y3QgYW1kZ3B1X2JvICAgICAgICAgICAgICAgICpt
bWlvX3JlbWFwX2JvOyAgIC8qIHNpbmdsZXRvbiBCTyAqLw0KPiA+ICsgICAgIHJlc291cmNlX3Np
emVfdCAgICAgICAgICAgICAgICAgIG1taW9fcmVtYXBfYmFzZTsgIC8qIFJFRyBCQVIgYnVzIGJh
c2UgKi8NCj4gPiArICAgICByZXNvdXJjZV9zaXplX3QgICAgICAgICAgICAgICAgICBtbWlvX3Jl
bWFwX2JhcnN6OyAvKiBSRUcgQkFSIHNpemUgKi8NCj4gPiArICAgICByZXNvdXJjZV9zaXplX3Qg
ICAgICAgICAgICAgICAgICBtbWlvX3JlbWFwX29mZnNldDsvKiBCQVItcmVsYXRpdmUgb2Zmc2V0
IG9mDQo+ID4gcmVtYXAgcGFnZSAqLw0KPiA+ICsgICAgIHJlc291cmNlX3NpemVfdCAgICAgICAg
ICAgICAgICAgIG1taW9fcmVtYXBfc2l6ZTsgIC8qIGFsd2F5cyBQQUdFX1NJWkUgKi8NCj4NCj4N
Cj4gQWxzbyBtYXliZSBwdXQgdGhlc2UgaW4gdGhlaXIgb3duIHN0cnVjdCwgc2ltaWxhciB0byB3
aGF0IHdlIGRvIGZvciBkb29yYmVsbHMgYW5kDQo+IGRyb3AgdGhlIG1taW9fcmVtYXAgcHJlZml4
LiAgRS5nLiwNCj4NCj4gc3RydWN0IGFtZGdwdV9tbWlvX3JlbWFwLnsNCj4gICAgIHJlc291cmNl
X3NpemVfdCBiYXNlOw0KPiAgICAgcmVzb3VyY2Vfc2l6ZV90IHNpemUNCj4gICAgIHN0cnVjdCBh
bWRncHVfYm87DQo+IH07DQo+DQoNCkFjdHVhbGx5IHdlIGFscmVhZHkgaGF2ZSBzdHJ1Y3QgYW1k
Z3B1X21taW9fcmVtYXAuICBKdXN0IHVwZGF0ZSB0aGF0IHN0cnVjdHVyZS4NCg0KQWxleA0KDQoN
Cj4gQWxleA0KPg0KPiA+ICsNCj4gPiAgICAgICAvKiBjbG9jay9wbGwgaW5mbyAqLw0KPiA+ICAg
ICAgIHN0cnVjdCBhbWRncHVfY2xvY2sgICAgICAgICAgICBjbG9jazsNCj4gPg0KPiA+IC0tDQo+
ID4gMi4zNC4xDQoNCg==
