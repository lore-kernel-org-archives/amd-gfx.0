Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFFCC7115C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 04:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C10610E65B;
	Wed, 25 Jun 2025 04:48:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bh215DGz";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A57C310E65B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 04:48:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPBMBvM9qZFca3LS3iHUDZUPCEdLzRWSFdDwLqnnWzUNJciKIvjXCJKWRya6MxHvagDPEDrUR0wBffRV5RyeHlhu2XSOuDqGPbXMFQvtm533ia4mPdTNXeESBeFZKve6uC110OLQcCqqjclA3xviFlotKP3KexF52z6A59Y+snBCHqY4PSL3nrU3slg1uuKwg5gw/O7jC2V7fu09ig4BJTwtUXpKjrb/0wvnIGu28mGX4Sa4aljGhYt1QEqo4h6eK2FbiKvPN7GbH223JAn3TteWJ2mx+w8EbHbA8rf46tey+xpqw+CJEteempvH9l62OMVO+evHIa/sqehreypiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oj0BG12ek4qn2Po9c5aGDlt+tCWARgz90XQFLBvWKAM=;
 b=Zj7B0PauBBgXOREOM/FRoChx7u9yNbWRXpUdQxExkUas+fE8gUILAA+vzHTCHZTReuH0fTuSNshn8RJAciCQp8jzQp7Sh+sQQehI0iWg+b44s5jKVwosUk+qEp/3o2WObDtYFoja/ecj0yG3OLt+Uenv9QFZSdeat8ldmPyf4WXApl2ebNPQqJfkFdOWLGMy/xUmH/lHTaNA0wgRaCh+mlPRAeU1bXbsucSB3KDDp0hzbyOl3/+lU0aFlkXfwc/yyJrPYOjTIp8s8bm8coI3bO0E9D6w4zanJrTmAMVifEvUZtE+HY4HiOgZgFeL2QkM1l5qcrZVXVN5FDjzJ7WSew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oj0BG12ek4qn2Po9c5aGDlt+tCWARgz90XQFLBvWKAM=;
 b=Bh215DGzTtykctPzobnkBmdw3I2rQ72mEGiwV0/8s34ok01XEFMl/m2sZj5K+aegOaeLGr5yDjEwrqFCOAhsGE1sWMqd/yvOL6vMWXZeh0NuKFS9uBCo9sZfYE8xONo4edlm7CKXlKBAS2YNE9110WFCJhz0HVnMHhlqZvYv6Q8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS0PR12MB7582.namprd12.prod.outlook.com (2603:10b6:8:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 25 Jun
 2025 04:48:50 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.8857.020; Wed, 25 Jun 2025
 04:48:50 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Add user queue instance count reporting
 for gfx12
Thread-Topic: [PATCH 1/2] drm/amdgpu: Add user queue instance count reporting
 for gfx12
Thread-Index: AQHb5B3m8MDQrDIldkmp0xFrUy1eMbQQ5R+AgAEkYgCAAUZxgA==
Date: Wed, 25 Jun 2025 04:48:50 +0000
Message-ID: <BL1PR12MB5144A2F2D02331E60ECFA799F77BA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250623090439.3811614-1-jesse.zhang@amd.com>
 <CADnq5_OZt-6DYOyNXE2JfexmznBqxbNuEdgeHYOK++OMGF6ZGw@mail.gmail.com>
 <DM4PR12MB51521682D8D73D21A0CDF636E378A@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51521682D8D73D21A0CDF636E378A@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-25T04:46:25.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS0PR12MB7582:EE_
x-ms-office365-filtering-correlation-id: dc55aa91-2e70-44f8-7471-08ddb3a39470
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OFM2cnJVcmF0dzcyRGZDalNhMkowYWJKVVBqSko5a2h2TXNqY2dqMmhTMUdo?=
 =?utf-8?B?ZVVsZVQxMEQ2NSt3cVgrNFA2cU5XQzFMazUvMm1XUEpDODhkZjFXVkh4NC9N?=
 =?utf-8?B?WmQ1cCtUTW80TUVOTit5STRUS05RL2xzM2NkYVlNVGtRVGhEOE5aektyR0Y1?=
 =?utf-8?B?b2xOdU5CUHhWTmMwb2tPSzFxM05SR0ZjZ3F1VnIvRFBjNTdRVVdoaFlKa0VJ?=
 =?utf-8?B?SGdvVUFnRjhiOEFENWlsMWhHU2dlUlpCS2gvM2M4WW5CMmJSSmxnWmJ3eWhO?=
 =?utf-8?B?dHFqZyswZFNuVEY1dU0veWRkL2cvTEVlcnJFMEJjcmgrMWwvbGFjZDRvbzVt?=
 =?utf-8?B?RTNzYVZaSmd2dGh5cVROekdHbHMyOUwyYkdhdmJMUVovS3Uzd1JUOHh3M3Nv?=
 =?utf-8?B?aWxaaDlVSGVzSmR2K0xtaWZtZ1BRK3FGdDJDdWloSVdna3pFcjdnOSt1UFhC?=
 =?utf-8?B?RTBzUlFqaG9qakxHd0dNT2thSjJqdDdDNFBtRDQ4YmR0V3B1dCtWM2M3ckFa?=
 =?utf-8?B?YWFzK2RJN2RneFNLclpVWXZHeUlXRWZqamhlcDhnZm5nYk1RQTlsRUkwYjZo?=
 =?utf-8?B?bXcrNEZkVTErdGlOeldsWmFXUW1iV25abkZwc0dnb095YzdsZXpRaDF6ZGRF?=
 =?utf-8?B?SHMwdFN6Z2Z3YWhtUG82V1g5cnd3NGRPbm40ZEF0WHh0VUZveHZaU05mKy83?=
 =?utf-8?B?L0FNbm4vM2Z3N0lKcUMyeHdSNmhXNXQ0NUh0cXN0bURNVTd1YVFYOHBLUjha?=
 =?utf-8?B?SUthRjltcFQxVGxCV2hWTDFHbjR5aDlIbGc5bFBRWHdXM1ZrK1d6MVpvRUNU?=
 =?utf-8?B?V05oTW05UDM2Ym9YWjZBQ1FCSEM5SFhWQ2NRenpaeDJGbkh5QzNnTUxRSllU?=
 =?utf-8?B?SXMvemxEWGdsM3ZkVFNLLys0bUhGNTZCRWF0REJISDRtQjhWd1pIdjN4Qm03?=
 =?utf-8?B?ZUFnbWlZWWxvcjNwSllEWGJhR1BNQldGOUlkSFRjVTlLT2k1b242UnZMZ3Iw?=
 =?utf-8?B?eVI4Rk4xSk5PN0dSR0RUQ0xLRFJ6OFRubmVoMjFOUjVIZElFQzFvbElDd1ND?=
 =?utf-8?B?NndsU25WdlhFMU5YeXFsOE5rWEtVeE9EeHlyZVRIYjJNTDVtV21ITmtpQ09Y?=
 =?utf-8?B?cjluRHZvWnJPeWtzK0NLRXRvaEV4YUxad2dLV3FQQW1lcXo4VHNOTHVtL0do?=
 =?utf-8?B?dnBuRVhrK241djh5aFQzZDhTQXdoSGR6Rjd4cmprd1pla0wxMUErRXVpdDlr?=
 =?utf-8?B?RTVvQUNmcUFwVTdrRC83Kzg4NEt0TEk4OFVOclVjTmdZTnpmVSt4UXVrN09X?=
 =?utf-8?B?ai9JSDBoYURZcUc0cXJoNXlMZHQ4dVkxZkFEdlVjalIyZmpKM1JRNVAwb3hR?=
 =?utf-8?B?T24vdjZWZmdobkdtaDhJRkJodU45RytSdUNzUC9LQUN0bm5VNXdMK3ZPaXZw?=
 =?utf-8?B?ajIxbC9EVjQ2bFdmZkhUdkxIOXlOK0N4WWphSytNbTdvK2JScFVZQ3VBL2tF?=
 =?utf-8?B?bWVQRWc5RmNSNFJSdjdkUHc5Mk0rUVV2bllHNlZvOXVXWEZYMWFhVVNjQzZ2?=
 =?utf-8?B?OFVTUzVVYVdHZDZ0MHlJWmJ5VkF1bDZkYlI3QTF6aWh5UGh6YUM4Q29jQ0l1?=
 =?utf-8?B?eUlleC81a2NaMzdWcFlpMWMyTGhmSWRFdmlhTnFRMlpaNTFjREJBaFJNY0g5?=
 =?utf-8?B?eWNCMkZDYUxqSFpJVXpnWHA3aWFNendNSWJRb205ekYxREU5WjBERmR0akVX?=
 =?utf-8?B?K1gyUXhRZmJTelM2V2JWRmkxenh2cE42eE43L0pVT2Q2b3ZzNlJkU05jNmRm?=
 =?utf-8?B?ckppUW9CY3BXbnR1aStCWkFWdklvREFub1JhZENHODlucnpmZ3hjT0dRTmtp?=
 =?utf-8?B?bVJ4Yjg4dnM2NDI3ZjcyRGxNelh3ZlNhMjJ1TGl3ZXpoK3A5T2lYVFlUdDFl?=
 =?utf-8?B?R2QxOEQySjN3bWRNMDNiYjZxdDVNcktDVHFRVWVFSXpuSW10YUxHdWxRVlFR?=
 =?utf-8?Q?2FcZ+wmpYsYhEkjY2mH7e9E1s1xUnk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THh3T0E4M1JmY3NDZFBCd1hUNXFNcFo4Njd1RTgxU2c0Vmg2T1pWanp0VEVI?=
 =?utf-8?B?T2kxL0lzdEtJRExxcGcrRjJ0UWZVZGM1VzRvTXAwUTV2RHBBWm9HZ2Q0ZUw5?=
 =?utf-8?B?cjFxTUV6VEg0eDJkN3pROUhvRUNhb1U5cXhXS3lZY29lQVBWMEM4UHA5NFhX?=
 =?utf-8?B?aENMbVk2NVRYNis0THNBWTYxeHV4MDkyNjJwUVdCWnE3UDJXRmZQK01CNTZU?=
 =?utf-8?B?WjhBTkY2SnNkNElwQnVDeHh2L01jWmdOQ3VCV1gzUzcxbnNrM2pSeHlwdVB0?=
 =?utf-8?B?YXo2TjFqY0hjK1dmMTh2dmhOQjZ3YlozYkVxZzhySmlqZXFlQ1BxWTlUeCtt?=
 =?utf-8?B?SVZ5YmZEQnB5WjUvMHg4NTdVRnFOWGdkWjdUaGRzNmUyZFhPWTdVam1KNit5?=
 =?utf-8?B?ZVdZbnVnMHNPeEltUDJuVWhnTlBhM3QxLzBNYk40V3BWbTRaWWZaRGV0YXcy?=
 =?utf-8?B?WkM3OExtVEtEek9lbjhDMU8yZk9QeTVSZWhYVFhWVVhsbU14ZW5mM3FxTkoy?=
 =?utf-8?B?K3VSYjVucDBBOEJYejg4MTF5Uk5RdG9VWnJYaVFMelV6WVBDYmZRdElGbkg0?=
 =?utf-8?B?Q1IxUWhURmtNeUVjSHJFYkhBWlVDM2U1RHN1UHRZUGt0WWZWVnc2WXE2SFdZ?=
 =?utf-8?B?M1g0aU00aGQwV1IxWEtQWDBsYTBVRy9LK3ZNdzR1VmhvZGorYSt5VEQ3WUgx?=
 =?utf-8?B?dTdhS0ZBc2ZEMm1qZ2xycnBzTWNaV0RNamVLM0RXaVZtUmhrUVZtS1cvOTlL?=
 =?utf-8?B?YUhPY0NxYzBOeU9WNEV2YXA0bWxYQ2FIM2pmTUNsK0U4cDRHZitVTW1IUTJw?=
 =?utf-8?B?SUNkU3orNHVtLzRaKzdqMmErSFF6QkUyeFcrNC9GSnJRa0h3aHd0SVREYVNJ?=
 =?utf-8?B?NlVFL1c2eGhPZEQyTCsyZkRTMGJhSU8wd3dKK2F0eW1xWGdQcWN5Q3RPL2NU?=
 =?utf-8?B?TW1IWkVHUnNDQ3pBTXNxWVZxcU5pRHFENDBJZXhHY3R1WFBQU1lsckVGelJu?=
 =?utf-8?B?TjI5aWtNTE1MVVhCb2kxVXptN0RoVUl3ek5RbThPL2wrdWExRU5ZTEFpNFQ2?=
 =?utf-8?B?SiswL21LU1FmRC9HcEhkVTdqSFA4NG1hVkF6cmlGUWg5Rzg3c2pPeStubkt1?=
 =?utf-8?B?SU1MbkJyZlE1ODlCOWdIZmUrYU14aEhiK0VZSUtRVitsYXQ5bElhalNwbVpJ?=
 =?utf-8?B?UTRjRnFvWVpGZFVkd3ppN29UTG5UVFY1TFVUelBhK2dsQ0JscTdiQ0QxV2x5?=
 =?utf-8?B?QXpzQW5GY2RHdTZnVzNpOUV2YnlKMUdzQWlva0dGTnRFV2h6M0JrV2NELzlm?=
 =?utf-8?B?alFDNHBtTStHaHhNS3ROVlE4VUE5OGdRUW52WTI3Z1VEZ0h5anNzalFVVWhS?=
 =?utf-8?B?YTN5aDVlRTJ4d0NzU2tVTE4vRXJoODI3TVUzZEpCTVpnRlRGT2xGSTdQVEtk?=
 =?utf-8?B?a3RKVEdSTmFHUnBwdWxhcTZNclZaUDg5dXI2MmxMSERHTC8yM0xTZ1R4ODcv?=
 =?utf-8?B?WHN1dWFJZ0UrV21UTGFPMWs1UEplOUR5dldhWDZFWGdGdjJuQlRDNWhwbDF5?=
 =?utf-8?B?UUY2SHRNRmFrTVV1UTUxaTJBT1VxekxiQW5DcXFBSHpzaW9KRk5IbnB5TjBB?=
 =?utf-8?B?eXA5OUdlVUZwRWw2SHdMTGdnL3dGeVRJaThYbGtKQlM4dm54OEtVT2N3NndS?=
 =?utf-8?B?czcvWUoydytaQno2Ym55Z2xFYmV3dTBvZVVEcDRYTE55WnNGdU13TEZpTGNY?=
 =?utf-8?B?QlJKZGFRbjhiWDVVTXhuUkdHdExoMmFpNXRqRE9jc2ZLQzE0aENrMkVYTitm?=
 =?utf-8?B?bGphTVBEb1NXSTRESVlDVTNPRitvbjBKUm15U3VWeVd0OHhoOGpmZkdDNVAw?=
 =?utf-8?B?WnFPc1NMNE54SjRQY3EzUkt2U2ZlSEgxMkFWbmhST29BZTdxQUYxTzlrMnBD?=
 =?utf-8?B?YklJcTBUSVYrMEZHb3hkbDBGQ25yMkxoYm14TjJLU0pCZjNsc0h3R3BmUGxD?=
 =?utf-8?B?RE5mWTZ3bVdNQk9ZdXVhTmozaVZFYm5CbmhKSFpqNWhTTlJFeU1oUkQyQ0tO?=
 =?utf-8?B?K1JibFNOOWtiZlVKbklaSnFZK1BEVnBwWWgwYmxiRFRxUVJoQktocWhISWRa?=
 =?utf-8?Q?/le0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc55aa91-2e70-44f8-7471-08ddb3a39470
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 04:48:50.7709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIcpAK1KDcA7loY2K3CdoqmkxHNjJ5fgloBpwNiypbcdYeCCoHx3lnK2/nXIA6BWauKrr9Miu+tdaRDAW+2cbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7582
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBaaGFuZywg
SmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVuZSAy
NCwgMjAyNSA1OjE4IEFNDQo+IFRvOiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNv
bT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5k
ZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDEvMl0gZHJtL2Ft
ZGdwdTogQWRkIHVzZXIgcXVldWUgaW5zdGFuY2UgY291bnQgcmVwb3J0aW5nIGZvcg0KPiBnZngx
Mg0KPg0KPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlv
biBPbmx5XQ0KPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERl
dWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdW5lIDIzLCAy
MDI1IDExOjUxIFBNDQo+IFRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNv
bT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5k
ZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHJtL2Ft
ZGdwdTogQWRkIHVzZXIgcXVldWUgaW5zdGFuY2UgY291bnQgcmVwb3J0aW5nIGZvcg0KPiBnZngx
Mg0KPg0KPiBPbiBNb24sIEp1biAyMywgMjAyNSBhdCA1OjEz4oCvQU0gSmVzc2UgWmhhbmcgPGpl
c3NlLnpoYW5nQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBjaGFuZ2UgZXhwb3NlcyB0
aGUgbnVtYmVyIG9mIGF2YWlsYWJsZSB1c2VyIHF1ZXVlIGluc3RhbmNlcw0KPiA+IHRocm91Z2gg
dGhlIEhXIElQIGluZm8gcXVlcnkgaW50ZXJmYWNlLiBUaGUgaW5mb3JtYXRpb24gaGVscHMgdXNl
cg0KPiA+IG1vZGUgZHJpdmVycyBwcm9wZXJseSBhbGxvY2F0ZSBhbmQgbWFuYWdlIHF1ZXVlIHJl
c291cmNlcy4NCj4gPg0KPiA+IEtleSBjaGFuZ2VzOg0KPiA+IDEuIEFkZGVkIHVzZXJxX2dmeF9p
bnN0YW5jZXMgYW5kIHVzZXJxX2NvbXB1dGVfaW5zdGFuY2VzIGZpZWxkcw0KPiA+ICAgIHRvIGFt
ZGdwdV9nZnggc3RydWN0dXJlDQo+ID4gMi4gSW5pdGlhbGl6ZWQgdGhlIHZhbHVlcyBkdXJpbmcg
R0ZYIElQIGVhcmx5IGluaXQgZm9yIHYxMg0KPiA+ICAgIChvbmx5IHdoZW4gdXNlciBxdWV1ZXMg
YXJlIG5vdCBkaXNhYmxlZCB2aWEgZGlzYWJsZV91cSkgMy4gRXhwb3NlZA0KPiA+IHRoZSB2YWx1
ZXMgdGhyb3VnaCBkcm1fYW1kZ3B1X2luZm9faHdfaXAgc3RydWN0dXJlDQo+ID4gICAgdmlhIGFt
ZGdwdV9od19pcF9pbmZvKCkNCj4gPg0KPiA+IFRoZSB2YWx1ZXMgcmVwcmVzZW50Og0KPiA+IC0g
dXNlcnFfZ2Z4X2luc3RhbmNlczogTnVtYmVyIG9mIEdGWCByaW5nIGluc3RhbmNlcyBhdmFpbGFi
bGUNCj4gPiAtIHVzZXJxX2NvbXB1dGVfaW5zdGFuY2VzOiBOdW1iZXIgb2YgY29tcHV0ZSByaW5n
IGluc3RhbmNlcyBhdmFpbGFibGUNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEplc3NlIFpoYW5n
IDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ2Z4LmggfCAyICsrDQo+ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2ttcy5jIHwgNCArKysrDQo+ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3YxMl8wLmMgIHwgNSArKysrKw0KPiA+ICBpbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0u
aCAgICAgICAgICAgfCAyICsrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nZnguaA0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oDQo+
ID4gaW5kZXggMDhmMjY4ZGFiOGY1Li42M2E3ZjBlMGRiNWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oDQo+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oDQo+ID4gQEAgLTQ1Miw2ICs0NTIsOCBAQCBz
dHJ1Y3QgYW1kZ3B1X2dmeCB7DQo+ID4gICAgICAgICB1bnNpZ25lZCAgICAgICAgICAgICAgICAg
ICAgICAgIG51bV9nZnhfcmluZ3M7DQo+ID4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3JpbmcNCj4g
Y29tcHV0ZV9yaW5nW0FNREdQVV9NQVhfQ09NUFVURV9SSU5HUyAqDQo+IEFNREdQVV9NQVhfR0Nf
SU5TVEFOQ0VTXTsNCj4gPiAgICAgICAgIHVuc2lnbmVkICAgICAgICAgICAgICAgICAgICAgICAg
bnVtX2NvbXB1dGVfcmluZ3M7DQo+ID4gKyAgICAgICB1bnNpZ25lZCAgICAgICAgICAgICAgICAg
ICAgICAgIHVzZXJxX2dmeF9pbnN0YW5jZXM7DQo+ID4gKyAgICAgICB1bnNpZ25lZCAgICAgICAg
ICAgICAgICAgICAgICAgIHVzZXJxX2NvbXB1dGVfaW5zdGFuY2VzOw0KPiA+ICAgICAgICAgc3Ry
dWN0IGFtZGdwdV9pcnFfc3JjICAgICAgICAgICBlb3BfaXJxOw0KPiA+ICAgICAgICAgc3RydWN0
IGFtZGdwdV9pcnFfc3JjICAgICAgICAgICBwcml2X3JlZ19pcnE7DQo+ID4gICAgICAgICBzdHJ1
Y3QgYW1kZ3B1X2lycV9zcmMgICAgICAgICAgIHByaXZfaW5zdF9pcnE7DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYw0KPiA+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jDQo+ID4gaW5kZXggMTk1ZWQ4MWQzOWZm
Li5mZjA1YzgyYTNkZmYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2ttcy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2ttcy5jDQo+ID4gQEAgLTQxMSw2ICs0MTEsOCBAQCBzdGF0aWMgaW50IGFtZGdwdV9od19p
cF9pbmZvKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ICphZGV2LA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIGlmIChhZGV2LT5nZnguZ2Z4X3JpbmdbaV0uc2NoZWQucmVhZHkgJiYNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIWFkZXYtPmdmeC5nZnhfcmluZ1tpXS5ub191c2Vy
X3N1Ym1pc3Npb24pDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArK251bV9y
aW5nczsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIHJlc3VsdC0+dXNlcnFfbnVtX2luc3Rh
bmNlID0NCj4gPiArIGFkZXYtPmdmeC51c2VycV9nZnhfaW5zdGFuY2VzOw0KPiA+ICAgICAgICAg
ICAgICAgICBpYl9zdGFydF9hbGlnbm1lbnQgPSAzMjsNCj4gPiAgICAgICAgICAgICAgICAgaWJf
c2l6ZV9hbGlnbm1lbnQgPSAzMjsNCj4gPiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gQEAg
LTQyMCw2ICs0MjIsOCBAQCBzdGF0aWMgaW50IGFtZGdwdV9od19pcF9pbmZvKHN0cnVjdCBhbWRn
cHVfZGV2aWNlDQo+ICphZGV2LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChhZGV2
LT5nZnguY29tcHV0ZV9yaW5nW2ldLnNjaGVkLnJlYWR5ICYmDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICFhZGV2LT5nZnguY29tcHV0ZV9yaW5nW2ldLm5vX3VzZXJfc3VibWlzc2lv
bikNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICsrbnVtX3JpbmdzOw0KPiA+
ICsNCj4gPiArICAgICAgICAgICAgICAgcmVzdWx0LT51c2VycV9udW1faW5zdGFuY2UgPQ0KPiA+
ICsgYWRldi0+Z2Z4LnVzZXJxX2NvbXB1dGVfaW5zdGFuY2VzOw0KPiA+ICAgICAgICAgICAgICAg
ICBpYl9zdGFydF9hbGlnbm1lbnQgPSAzMjsNCj4gPiAgICAgICAgICAgICAgICAgaWJfc2l6ZV9h
bGlnbm1lbnQgPSAzMjsNCj4gPiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTJfMC5jDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEyXzAuYw0KPiA+IGluZGV4IDEyMzRjOGQ2NGUyMC4u
NDgyNDkwNzgzYTBhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92MTJfMC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Yx
Ml8wLmMNCj4gPiBAQCAtMzg1Miw2ICszODUyLDExIEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMl8wX2Vh
cmx5X2luaXQoc3RydWN0DQo+IGFtZGdwdV9pcF9ibG9jayAqaXBfYmxvY2spDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBTURHUFVfTUFYX0NP
TVBVVEVfUklOR1MpOw0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gKyAgICAgICBpZiAoIWFkZXYt
PmdmeC5kaXNhYmxlX3VxKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGFkZXYtPmdmeC51c2VycV9n
ZnhfaW5zdGFuY2VzID0gR0ZYMTJfTlVNX0dGWF9SSU5HUzsNCj4gPiArICAgICAgICAgICAgICAg
YWRldi0+Z2Z4LnVzZXJxX2NvbXB1dGVfaW5zdGFuY2VzID0NCj4gPiArIEFNREdQVV9NQVhfQ09N
UFVURV9SSU5HUzsNCj4NCj4gVGhlc2UgYXJlIGtlcm5lbCBxdWV1ZSB2YWx1ZXMuICBJZiB5b3Ug
d2FudCB0byBleHBvc2Ugc29tZXRoaW5nIGxpa2UgdGhpcywgaXQgc2hvdWxkDQo+IGJlIHNvbWV0
aGluZyBsaWtlIHRoZSBudW1iZXIgb2YgSFFEIHNsb3RzIGF2YWlsYWJsZSBmb3IgdXNlciBxdWV1
ZXMgZm9yIGVhY2gNCj4gcXVldWUgdHlwZS4gIFRoYXQgc2FpZCwgd2hhdCdzIHRoZSB1c2UgY2Fz
ZSBmb3IgdGhpcz8gIEFwcGxpY2F0aW9ucyBkb24ndCBrbm93IHdoYXQNCj4gb3RoZXIgYXBwbGlj
YXRpb25zIGFyZSBkb2luZy4NCj4NCj4gSXQgaXMgdXNlZCB0byB1bmlmeSBrZmR0ZXN0IGFuZCBJ
R1QgdGVzdHMuDQo+IFVzZXJzcGFjZSBuZWVkcyB0byBnZXQgdGhlIG51bWJlciBvZiBpbnN0YW5j
ZSBvZiBlYWNoIHR5cGUgYW5kIHRoZW4gcGVyZm9ybQ0KPiBjb25jdXJyZW50IHRlc3RzLCBqdXN0
IGxpa2UgS0ZEUU1UZXN0LkFsbENwUXVldWVzLg0KDQpJbiB0aGF0IGNhc2UsIEknZCBzdWdnZXN0
IHVzaW5nIHRoZSBhZGV2LT5tZXMuZ2Z4X2hxZF9tYXNrW10vY29tcHV0ZV9ocWRfbWFza1tdL3Nk
bWFfaHFkX21hc2tbXSBtYXNrcyB0byBkZXRlcm1pbmUgdGhlIG51bWJlciBvZiBxdWV1ZSBzbG90
cyBhdmFpbGFibGUgZm9yIGVhY2ggZW5naW5lIHR5cGUuDQoNCkFsZXgNCg0KPg0KPiBUaGFua3MN
Cj4gSmVzc2UNCj4NCj4gQWxleA0KPg0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiAgICAgICAg
IGdmeF92MTJfMF9zZXRfa2lxX3BtNF9mdW5jcyhhZGV2KTsNCj4gPiAgICAgICAgIGdmeF92MTJf
MF9zZXRfcmluZ19mdW5jcyhhZGV2KTsNCj4gPiAgICAgICAgIGdmeF92MTJfMF9zZXRfaXJxX2Z1
bmNzKGFkZXYpOyBkaWZmIC0tZ2l0DQo+ID4gYS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0u
aCBiL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oIGluZGV4DQo+ID4gNDVjNGZhMTM0OTlj
Li44MDgyMjcwYTdjZWIgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVf
ZHJtLmgNCj4gPiArKysgYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaA0KPiA+IEBAIC0x
NDkzLDYgKzE0OTMsOCBAQCBzdHJ1Y3QgZHJtX2FtZGdwdV9pbmZvX2h3X2lwIHsNCj4gPiAgICAg
ICAgIF9fdTMyICBhdmFpbGFibGVfcmluZ3M7DQo+ID4gICAgICAgICAvKiogdmVyc2lvbiBpbmZv
OiBiaXRzIDIzOjE2IG1ham9yLCAxNTo4IG1pbm9yLCA3OjAgcmV2aXNpb24gKi8NCj4gPiAgICAg
ICAgIF9fdTMyICBpcF9kaXNjb3ZlcnlfdmVyc2lvbjsNCj4gPiArICAgICAgIC8qIFVzZXJxIGF2
YWlsYWJsZSBpbnN0YW5jZSAqLw0KPiA+ICsgICAgICAgX191MzIgIHVzZXJxX251bV9pbnN0YW5j
ZTsNCj4gPiAgfTsNCj4gPg0KPiA+ICAvKiBHRlggbWV0YWRhdGEgQk8gc2l6ZXMgYW5kIGFsaWdu
bWVudCBpbmZvIChpbiBieXRlcykgKi8NCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQoNCg==
