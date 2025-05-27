Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E579C54F30
	for <amd-gfx@archiver.kernel.org>; Tue, 27 May 2025 11:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E002210E429;
	Tue, 27 May 2025 11:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NGd4l+TR";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E403882AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 May 2025 11:27:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=St7qM0fKUiz9kTim+WfBkYXYsfiiZNNnTCaVv7Iu53PGymZz3bcvQUdQxIm99hgN8Z2OssqWlz81/97HuhM+9PffYnYyEN+wgx2Fw7xy2DmBH4D2es5DPZCrAIZVrBd3NbJmWdZfCcS3pdCWJAj8xEK0tJxUzFBqWq+69FmM9uSHxdvwF7axS00FYVWYm7rorgzBGsEROOwLIPHtfOmw7+feNTpkU9+S8gq2n9b7UDYrxe+RruerE6OxKuxoy5pLFjePQsVrglvsp5UFedumH1cXgqg+9FEl5fL9cNYNDPE/rK6MS4NQqEYMb4evBjpAEh5YdSi9Kl9x4+ppqBuftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7q8rVJN2qFhflYQ1x2uYGdDHhUrBAIqRuH4DmK2hMEQ=;
 b=SKKHAGkqtm5XWDfqCKHzAqq6gNsh+3uPGbivuDgaXTY2u7ACu5+uamAPgejgWXUC5HnDz/eMTy90ViMlzF2dNnS115+X4h8gst3SyS3VINNzmLDoeSTzkOZnwntOBJ9J3ZhEqlQtnbDVIxkr+WOSm54FOClni77ESU22+T7mYoCdmB8baaYNjzbtSAp0nlyc2Z99DZ40dlvwbslUbd/lOSvkCdCYIebB65F5GVNYOP0Yn4CKQmn8zfmAsFgiJc3qY5dfQrbIejl9B+8RB8zCsAnvlha7STwKbp0symG8EklIRuOxyskyoGZwbuOp3S93l0m7rXvMU+FNGQTF3qB9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7q8rVJN2qFhflYQ1x2uYGdDHhUrBAIqRuH4DmK2hMEQ=;
 b=NGd4l+TRKjFOOIJ3XskRdZkpYmeqGcEofQ1m88eY0p7iuAprpm93H4vXUhtpJBmv7B79cLDkpWl+oLjh1np59rxXchz14utUmmeqK+ZUtXfY5ARu62aw9OHxcDCqv2qG05P+7n7qP43wCDiXF2N0Iub1f7Whk3Y5UpuNjNsqNN4=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SA3PR12MB8801.namprd12.prod.outlook.com (2603:10b6:806:312::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 27 May
 2025 11:27:25 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8722.027; Tue, 27 May 2025
 11:27:25 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] Revert "drm/amdgpu: promote the implicit sync to the
 dependent read fences"
Thread-Topic: [PATCH] Revert "drm/amdgpu: promote the implicit sync to the
 dependent read fences"
Thread-Index: AQHbzuWAG/e538xK5EC45CFfeC02iLPmLhqAgAAnTfA=
Date: Tue, 27 May 2025 11:27:25 +0000
Message-ID: <BL1PR12MB5753D89DC58DD90E37F22D159364A@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20250527085814.3853953-1-sunil.khatri@amd.com>
 <6316cfc5-5b63-4a0b-b290-087c19f68790@amd.com>
In-Reply-To: <6316cfc5-5b63-4a0b-b290-087c19f68790@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=418b4445-4263-451c-a5d0-74e10d40f4cc;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-27T11:22:14Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|SA3PR12MB8801:EE_
x-ms-office365-filtering-correlation-id: 35859de5-5742-4403-8ff8-08dd9d11748d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dCtRUW9jNVRHdzNLVEt5eFZIcCt6OU5BT3ZCdkVNaFhOczB1UE0wRUd1MU1t?=
 =?utf-8?B?aWNqdkcyUWluQU9CRkxTNXlBSE9ZRkphUkQzbW45TFd6Q3YrOWw2b2VnNC9l?=
 =?utf-8?B?aUtFckRta2x0YmZRaEVZT0I4TmJoTHVRWDdlcEpQTnhCeC9kZXhWaWJwNlIy?=
 =?utf-8?B?YzZ1RmQyR1ZBcUhWUmozOUlsYzVwZnp6SWovRlBaVE1OVEtYRHlaZ09sSnhP?=
 =?utf-8?B?NmhlcU1KOGhVTThKQ0pJZUdkM1lBYkRYd2NvSC9rbTZCWitIK0V1TkZ5bFhp?=
 =?utf-8?B?d2krMWNnRnJZR0FBUi9Eai9mZmUvOW1lbHhScUczTncxeWdtK0NpK0gyQ1BM?=
 =?utf-8?B?RlRoRk9JNjRERXpJMlJVV2wvKy81Nk5GL0xEcXA4dGtGWVh3VWdDM285azZt?=
 =?utf-8?B?SFZBREtoTzhoTU5YZTBrMDJoayt4cEdEMDhOblQxalV1STQ1ekhERnhadkJM?=
 =?utf-8?B?dHhaK1JrcmxFeFp5RWlLay94WUREY3QzRWZHMGNwTG1LeW51UDltMTAydUtG?=
 =?utf-8?B?OWwyVXlYQkZ1THUzVlVrem1NWVlmaVZxZHBZOUpZVVl2M0lqMVZCdXk1THhL?=
 =?utf-8?B?U3dtb0RWbTMrQ1BmdFkxVEdmRFdGcFJXaVBFK3hiRWIvQzZ2T01pRHhDY0hk?=
 =?utf-8?B?VDVucytLckJId1JDSEc0TGNRSXFVRlZHSFBQV2Q2VGtJazFaUmxlM2Y3VG8r?=
 =?utf-8?B?eDhxMEcwQkwrNWUyOElQV3lpVXVVL3lBcDhDNDNMMFdNSjhFVWNoNEpWd2Zx?=
 =?utf-8?B?ZFh4bW1weWRTTXpUaDZkbFFURUlraityd2RZZkxxa0kyVEZxS083RGwxMm5S?=
 =?utf-8?B?NHJ4MXdhdEJsL2d3OFhBbDlJdU1yUHRaNGdYOENCMkVxeFFnSlNYSFdlQ0pQ?=
 =?utf-8?B?RG54QTAxbW1XdE9kVGEzdlEwM0xYNm9LMlE3ZTdhUDVvYnBraHp2dmg1TldX?=
 =?utf-8?B?WDVucGZQbzNjdWNPVjlsaFN1MW53S3ZxNWdUa3JPN0hvejdSNGdscDJCd2c1?=
 =?utf-8?B?eUNtdVRqYUQ3TU1uRGl4MC9MajN0a3YrRlNFKzNLbnorQ1pnREVKUHFKZVJ0?=
 =?utf-8?B?Y3MyeWE4V2xaS1NXeTZBNnpWcHpYbmlEb3pCdUhISy92dGQvRVJRdmRsNzVj?=
 =?utf-8?B?Tis3dUxtcHdZdEVJRFRaU0QwUFByeWNMTm5jT1FLRjdTZWF4ZTdyczd2OTg3?=
 =?utf-8?B?Ym83NlMzT0EwcjRaQ0JVUXhUalgzbjFZdEZyenZiTVdUMkRTU29TbVRPd3dT?=
 =?utf-8?B?bFkwTE5wMVgxQnpQckJ2WFJXMWZnRnplbHdJdHE0YURyK0tTMC9KeExwVjdl?=
 =?utf-8?B?enJCWUlMTlRjSkZ1V05WZkFVcWVqdXU5U21ET3VtSmI5RzNDK3dXUExvUjBU?=
 =?utf-8?B?aTVoR3hFc3NxK2VKTmlsMklFVGRMQnN4czRZNmRPTFB6Z3pFSDRpWUUraE5U?=
 =?utf-8?B?aWtLN2wxc3l5TjVLVm5XeWZlR08wZnV0MDZrODMvb2EyQ3duWGpRa0JnYmpL?=
 =?utf-8?B?dGdEc3pqbVZaWEM5VjNkcDIvQnBtQUd5NHJNdFYvNWYrVTlqL0xRRm9rNHVT?=
 =?utf-8?B?Snp4TTUzdDliZVAzbFZFVlQvczdBa0dxUmpmLytxbDU0UXFyMTdmZEpIS0Jo?=
 =?utf-8?B?Y3kwVUwwa2llYXc1S2hMSVM0aDVSR0g0RzlCOXVLVlFmU1lhQ0ZXYlY4ZnFw?=
 =?utf-8?B?YnROT1RGTWhzWnRVelFpamNTejFLeGN6KzFicHlTYlViclJscXliZVJIazUv?=
 =?utf-8?B?Zm1NeFU2Y0ljNUR0cHd4ZENYS0NRcko1dGt6U1J0VzVLQzVFTFhKaUUxUDIz?=
 =?utf-8?B?MFV2blpmbHlhV0g1Q1RZbUlXYThmV0d0ek0vWGRTMFpKOVZsbXhWdlRWbnl2?=
 =?utf-8?B?aWc5WHJlZENyKyt4K2drb1FrMW9sNWNVdDNkUis5U3Z5MTJsOHYwcHEzd3R1?=
 =?utf-8?B?ZVF2SjF5bTNyZTJSTmc5eWhIekI3dVNMSksxVGtDRFBrTEM3cy8yL1BsdlB0?=
 =?utf-8?Q?1uP7MNgTTZu3aGvUOx2usV5KLbTM9A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUNNUjk1c3h3SHNSelR5MndWZlR4VWhpcFZGSU45NFRNL2o1ZVFQdXBaQVlQ?=
 =?utf-8?B?blo0bXNIVm9vVEpkWXJENU1UUHFwSFV5SDRJRjJ0VEk5RGVxUldFdnA0V1o2?=
 =?utf-8?B?cVNSd2VYZCtGakc2djlVSHFxaStJRmhxZE9uOW1KSDduNk1KaHVUK3ZQOCtE?=
 =?utf-8?B?WTZwU0Y2TWtXcHBDek5SaDRDNVVNNnRnamdadkE0M2RacXBud0lpLzZyb2Ry?=
 =?utf-8?B?dkM5TllwcVFZWEgwcVdpM011bHRCUjd0T1hSTWxuelQvOVVzVXh0NE1ZOUZ5?=
 =?utf-8?B?YWFsSFJPZVVNY2N5aXRjYURLL0svR3FOajVmOENNSW8rZmtNdGFrYjBrRVRQ?=
 =?utf-8?B?dm9ZRWlqMWpZNkpJMmh2MkUxQWdMYk5SSUhVTkYzd21OelZGem1jUklDSVMz?=
 =?utf-8?B?a1RZOUhIQURKSlFZWmVCUVY0MWdvQy9yK0NxUDAzUDIrYlB6ZjlRdVV6Y1dG?=
 =?utf-8?B?TlVibUpDWm1nUFdOaU5QYWdQSFB3Vy8rcmM0OGN6bTYzRC9kN1YrTEVVbVVY?=
 =?utf-8?B?RGxMWXdCOVRnYUNwZElOYTRvWkNJYXgyYWJnMndua1hnQ3cvblNNMmc2Vk00?=
 =?utf-8?B?T3dHbHpwOG9KK3hCak1mdW5La2RlMjBRUUtXY1dzNEs1cXVPc3lDV3huYS9i?=
 =?utf-8?B?eHZTY3JOeElFNlhtdDZYaXVGb0tPZ25SL2ZZSDVNRmc1ZXBEZnAvQitubFhN?=
 =?utf-8?B?V0lvanN0eWRKSWwyMXJKNzh6UjFhWkNtNWcxZDBRYTFLQm1qeTZZT3F6dG5L?=
 =?utf-8?B?MzNuVnFuTkRoTkdKL2pJajdBWnRJaWNxYTdvUThrUVR6bWE5UEdkK3pLUXQz?=
 =?utf-8?B?RFYrOE9RWFF1RGpubDBHRWRmTm9aMGVzOW1ZMWhtdjdRUHZtN1daeDJwaVRm?=
 =?utf-8?B?OEFBUldyc0s5c1lvbzFsazdWRlUydHphSTUzOUowNWZPY1AzVlh4OVpYamEz?=
 =?utf-8?B?bUx0b2pRQWpXVkorTDlrMHJxWGU1RG4zWTdKM2FzUXVZYnFNQU1NNXVyOFRz?=
 =?utf-8?B?U0RJc2VOUTlVNS91QVpEMTM2TVRBZ0dGUFRjV29CdytlZEhEMnM4SEhxbW1K?=
 =?utf-8?B?NXhwTm1QMmQ0eTV5bmtPQXQyZjFXSGJsYVRrY2JyVnlmUlc1clluSnRFdWxW?=
 =?utf-8?B?b0w2RHZSaXRSRTRzRHpFS25udkIwRldVL3dDbnZvN1pvNFVGUTRiUWtReWIy?=
 =?utf-8?B?NVB4RmRsSklCNnRNZzJVTHBVWmpTWUtYbkxXNkh4VU85dXpOWHI3MjB3VERZ?=
 =?utf-8?B?d28yeHgxVUJhSmFXL1owSFV5RFRnZmpkdnhxN000WDIxcitxdkhuWDhSZjJa?=
 =?utf-8?B?em4wSEh1eG9tekk5OEU4R25BMUdnb3NYc2VOVlIxQTFxQ3ZVQ3llNkRsUmpZ?=
 =?utf-8?B?MFBkRGc4SEJ0RDMwdzYrR2hseVFXZExmcGFTRWV3b3gzQm5uVUQ4MDZQa3d5?=
 =?utf-8?B?QjVLdVJ1empNaDF5Q04vR0VEMnphcFFrNEl6cGFiSjZDdTRZR2FRVFFpdU9C?=
 =?utf-8?B?SG4yTDJMNDlSNHNaZXJ4elJBNkViUjRxRTBMTFB1bG8vdG12am9DY3pGRU5O?=
 =?utf-8?B?T0VBdzkxNHI3QndQc0V5OWVPMTBmdEVpSm1JeUNPN0ZwNlo5TTZrN1F0TU1r?=
 =?utf-8?B?V3N1dklZR3oweWYreDI2QTFLRUtORnR5eVJRYWlRNC9COG43bHhuVFdnald0?=
 =?utf-8?B?UmxrN2JheS81dE1iTDROQTN0L3V2aE56aFJuVEgyVCtkcUR1VFBMZnptbjRy?=
 =?utf-8?B?bGZDQTR2UHczK1BPc2tVb1VDR2tjVnlwRXlFd25zdHh1UG4xS05xemtvd0lZ?=
 =?utf-8?B?WTNBVjZoMDl2SGI4Vjh6bkwyWkhkaWN3eStESndLcEpLZEUrZS9CblpyVlF4?=
 =?utf-8?B?SDVZNmNuTEZsSWI5Q3U5VitzY1BvcmNUQlR6eG5hdVVZRDRZUFNsQUdZV0Jo?=
 =?utf-8?B?Sm1iTzNiaTlMUzBJb0hMM1Vyc1lOQUl3cGNlQ1BYTWpxWUtZSlo3c29vT2Qz?=
 =?utf-8?B?M0p2UGZUNWt2QjVsMWcrK21IYXZNUFJPbmtycGRuZnI0TjZlSWpoNTZMVDNk?=
 =?utf-8?B?QjdNMkl5V3pBNjdsT0RsUHVMK0cyV0hvdTFZUVhQQzdQVjJ3bisvUkdWVURt?=
 =?utf-8?Q?r8sE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35859de5-5742-4403-8ff8-08dd9d11748d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 11:27:25.1810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8Ag8WHff8Vwvq7CmfhnRS7vbdUUD1Aa9YbRHkGgiHbAZqE5fAwGO74hU15JkbAcjWkS0976vjUItn5cLHePrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8801
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxD
aHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTZW50OiBUdWVzZGF5LCBNYXkgMjcsIDIwMjUgMjoz
MiBQTQ0KVG86IEtoYXRyaSwgU3VuaWwgPFN1bmlsLktoYXRyaUBhbWQuY29tPjsgYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNo
ZXJAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIFJldmVydCAiZHJtL2FtZGdwdTogcHJv
bW90ZSB0aGUgaW1wbGljaXQgc3luYyB0byB0aGUgZGVwZW5kZW50IHJlYWQgZmVuY2VzIg0KDQpP
biA1LzI3LzI1IDEwOjU4LCBTdW5pbCBLaGF0cmkgd3JvdGU6DQo+IFRoaXMgcmV2ZXJ0cyBjb21t
aXQgNzE0YmJiZjIwYTcyNjZlNDg2MzJmYWI0NjY1NjNlNjk1YWY5YWNiNS4NCj4gYmlzZWN0ZWQg
dG8gdGhpcyBjaGFuZ2Ugd2hpY2ggaXMgY2F1c2luZyB0aGUgZmxpa2VyaW5nIGlzc3VlIGluIHRo
ZSBVSQ0KPiBmb3IgdmFyaW91cyBhcHBzIGxpa2UgZ2x4Z2VhcnMgYW5kIHVuaWdlbiBoZWF2ZW4u
DQoNCklzIHRoYXQgZmxpY2tlcmluZyBhbHNvIHRoZXJlIHdoZW4gdXNpbmcga2VybmVsIHF1ZXVl
cz8NCg0KSWYgbm90IHRoZW4gd2l0aG91dCBhbiBleHBsYW5hdGlvbiB3aGVyZSB0aGF0IGZsaWNr
ZXJpbmcgaXMgY29taW5nIGZyb20gZm9yIHVzZXIgcXVldWVzIEkgaGF2ZSB0byByZWplY3QgdGhh
dC4NCg0KVGhlcmUgaXMgbW9yZSB0byBqdXN0IGZsaWNrZXJpbmcgaGVyZS4gV2UgYXJlIHBsYW5u
aW5nIHRvIHVzZSBhbWRncHUudXNlcl9xdWV1ZT0xIGluIG91ciBDSSB0ZXN0aW5nLiAgVGhhdCBt
ZWFucyBib3RoIGtlcm5lbCBhbmQgdXNlciBzdWJtaXNzaW9uIGFyZSBlbmFibGVkLiBXaGVuIEkg
cmFuIHRoZSB0ZXN0aW5nIGFtZGdwdV9iYXNpYyB0ZXN0cyB3aGljaCBydW5zIGJvdGgga2VybmVs
IGFuZCB1c2VyIHN1Ym1pc3Npb25zLCBhbGwgdGhlIHVzZXIgcXVldWUgdGVzdHMgYXJlIGNvbnNp
c3RlbnRseSBmYWlsaW5nLiBXaXRoIHRoaXMgcmV2ZXJ0IGNoYW5nZSBpbiBwbGFjZSBhbGwgdGhv
c2UgaXNzdWVzIGFyZSBmaXhlZCwgQm90aCB1c2VyIGFuZCBrZXJuZWwgcXVldWUgdGVzdHMgcGFz
cyBjb25zaXN0ZW50bHkgd2l0aG91dCBhbnkgYXJ0aWZhY3RzLg0KDQpUaGUgcmVhc29uIG9mIHdo
eSB0aGlzIGlzIGhlbHBpbmcgaXMgSSBhbSBub3Qgc3VyZSBvZiBidXQgaXTigJlzIHRoZSBvYnNl
cnZhdGlvbiB3aGljaCB3YXMgb2JzZXJ2ZWQgZWFybGllciBieSBBcnZpbmQgdG9vLiBXZSBjb3Vs
ZCBpbnZlc3RpZ2F0ZSB0aGUgcHJvYmFibGUgcmVhc29uIG9mIGl0IGluZmFjdCBBcnZpbmQgaXMg
Y2hlY2tpbmcgdGhhdCBidXQgdG8gZW5hYmxlIENJIHdlIGNvdWxkIHJldmVydCB0aGlzIGlmIHlv
dSBhZ3JlZS4NCg0KUmVnYXJkcw0KU3VuaWwgS2hhdHJpDQoNCkl0IHNlZW1zIHRvIGJlIHRoZSBy
aWdodCB0aGluZyBUT0RPIGFuZCB3ZSBhcmUgc3RpbGwgaW4gdGhlIHByb2Nlc3Mgb2YgaGFtbWVy
aW5nIG91dCBhbGwgdGhlIGJ1Z3MgZm9yIHVzZXIgcXVldWVzLg0KDQpSZWdhcmRzLA0KQ2hyaXN0
aWFuLg0KDQo+IEFsc28gd2hlbiB3ZSBzZXQgdXNlcl9xdWV1ZT0xLCB3aGljaCBlbmFibGUgYm90
aCB1c2VyIGFuZCBrZXJuZWwNCj4gc3VibWlzc2lvbnMgdGhlIHVzZXJxdWV1ZSB0ZXN0cyBpbiBJ
R1QgYWxzbyBmYWlsLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBTdW5pbCBLaGF0cmkgPHN1bmlsLmto
YXRyaUBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9zeW5jLmMgfCA1ICsrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3N5bmMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9z
eW5jLmMNCj4gaW5kZXggZDZhZTk5NzRjOTUyLi41NTc2ZWQwYjUwOGYgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zeW5jLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3N5bmMuYw0KPiBAQCAtMjQ5LDggKzI0OSw5IEBA
IGludCBhbWRncHVfc3luY19yZXN2KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiBzdHJ1
Y3QgYW1kZ3B1X3N5bmMgKnN5bmMsDQo+DQo+ICAgICAgIGlmIChyZXN2ID09IE5VTEwpDQo+ICAg
ICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+IC0gICAgIC8qIEltcGxpY2l0bHkgc3luYyBv
bmx5IHRvIEtFUk5FTCwgV1JJVEUgYW5kIFJFQUQgKi8NCj4gLSAgICAgZG1hX3Jlc3ZfZm9yX2Vh
Y2hfZmVuY2UoJmN1cnNvciwgcmVzdiwgRE1BX1JFU1ZfVVNBR0VfUkVBRCwgZikgew0KPiArDQo+
ICsgICAgIC8qIFRPRE86IFVzZSBETUFfUkVTVl9VU0FHRV9SRUFEIGhlcmUgKi8NCj4gKyAgICAg
ZG1hX3Jlc3ZfZm9yX2VhY2hfZmVuY2UoJmN1cnNvciwgcmVzdiwgRE1BX1JFU1ZfVVNBR0VfQk9P
S0tFRVAsIGYpIHsNCj4gICAgICAgICAgICAgICBkbWFfZmVuY2VfY2hhaW5fZm9yX2VhY2goZiwg
Zikgew0KPiAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRtYV9mZW5jZSAqdG1wID0gZG1h
X2ZlbmNlX2NoYWluX2NvbnRhaW5lZChmKTsNCj4NCg0K
