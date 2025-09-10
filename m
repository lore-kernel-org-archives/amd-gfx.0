Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01800CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 11:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01B610E8F6;
	Wed, 10 Sep 2025 11:41:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="na7YatwP";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B88BD10E8F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 11:41:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7Mi6TZNNXYTxbbAgWiXVA8Q40FlU3tPuAN7fmzlsMuSiWSLnmbTHt19/Xi2roWBtHpyo95tCSLCr/88CePuBvLpdSxF3w+2EFeFwpL4djg5P/8EfwvO6Zm6yZgvTNeCqQvv58uBMdc9chPCU3ZT1oP/7lsdV9yui4nc78Rs8C287JxmwkYwSGoxBFT9mVD9m/BaRybBXa3I46aUUG9YopTnAz1AnP4WtPv24USZ5kxhkNVNRRVMUG3BkAk1GMW4uISJOOmqe8bTwjQ6iF+Ulr1bN/DMoAxglSZECgyeJ0z8dYDYOvZDsjgLu3hKQj5xaMDhe9j6EPL6LkGK4Oa34g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cuiy/3PmJlE/hqdRc0TyWmm8kpELVODW1W6OJQcO70A=;
 b=I4weniREF5GKErycy0MzvZIPMZ8OD0GYa8vuNStUT8RlSQQe1HXJjk+qxO9SHR1C5DbBhEAOqghxvhMMWy51E0uKwLAFUADrg6MsdqYfuMCd9G6F1tB0jRcgKosbn+NxIJHPs76PEW9v2BWg21Feh1Qmm6jVm7GMyVwlqApfQXEZHUiwc7AZIUK0+s6MaPxcneDIkt5aZ4EjWCKEID3bZ+YLEynfKNdOTaLCb97gsn4YTbVHx1GR1iwEwjGG9m8g61AAfWayJyVx/BXhBZOXgyF9p3JhwuVJ5o1c9j3jPZ4LCTYM+bn3saFut1CBi2QcjeDh7PgzCs7HANBBHbU+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cuiy/3PmJlE/hqdRc0TyWmm8kpELVODW1W6OJQcO70A=;
 b=na7YatwPrYILKYH4ih7lk4oo0J18N+FkbISfbcPnfgNkCJ5LL0H9hLuLvEc61i0idrkd2YyQcS2HZkUJUPSsTz0kOmAdU22SinxHCUaAXRRPsBqadP51wk9pMEGBLYT/cSMzLhQfBpTrTZ7x7X6p4PyB83R9KVopmt+CQeee4WQ=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 11:41:02 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 11:41:02 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
Subject: RE: [PATCH 1/9] drm/amdgpu: add UAPI for user queue query status
Thread-Topic: [PATCH 1/9] drm/amdgpu: add UAPI for user queue query status
Thread-Index: AQHcIkdYO5+qqZTWh0KlKZhRZTSyALSMStAQ
Date: Wed, 10 Sep 2025 11:41:01 +0000
Message-ID: <DS7PR12MB6005AC5B8C71606CDCC613AFFB0EA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250910113731.2688320-1-Prike.Liang@amd.com>
In-Reply-To: <20250910113731.2688320-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-10T11:40:29.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA1PR12MB7520:EE_
x-ms-office365-filtering-correlation-id: 789e969a-dccb-48b9-aaac-08ddf05eeb30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WlZXL2xmajdTNkE0ejU3aVlUajFNRjJNSzVUSXBNZUd2K0xFRkpMcVduSTNP?=
 =?utf-8?B?VksxeGtObHZ3YWlieWJ3emdmQjBhM1U4djkwenFkUS9XYUd4WmQzbXcweXpv?=
 =?utf-8?B?U2pMenErVjhjQTh5M3FpUVBTSEZuc05BUWhNQy91R3IvV1VhdmFYMHlucXp0?=
 =?utf-8?B?RWhlcFFwaFordUxZMTJFQ2Z4Umx4em5GTGlTNTJyTzZSN05kdlVubWo2eUdm?=
 =?utf-8?B?VE5oam5mbWVoQS9SZTZlZnVNNzZQT3V4WTFPTFRYZjBycVRRUFl0VFVQSUJZ?=
 =?utf-8?B?eThlTGptdWh2SURCVjlkWWRaMHIya2xzclZRK3ZsT3hzdU05b2M3bzBFQ3l2?=
 =?utf-8?B?dTcxWVQrU0lSMFYzZmpDeFRjK3NwRjVWRzdhNStxOGZBNHFUT3FYelhoT0JT?=
 =?utf-8?B?UDVVM0lFK2dYM0tSTTc4VjF5WDR4L203Q083OFR6ejAwdERNNHZSRHZhbUQy?=
 =?utf-8?B?bkdVNHNIY2ZwTTg5VXdIUE5IKzlZdmVPek45Q1dhV0VYbDU3c3FpVUFUR1p3?=
 =?utf-8?B?RzRNWjZiT05nQVp3MmxYMEttTXFyWUlkVHozc1ZMTEpXVWNOaklWSjJESGFG?=
 =?utf-8?B?T2tsVDMzWStlNWFyVFh1bllobXVsRVJTOHRramMwWUlaYVI5bFg5dk15Rlcv?=
 =?utf-8?B?R1lyYi94aERNSE5aalZOait1R3Vjdk5yU01KMjhxQ1BwU2FVOGNnaHE2WU9n?=
 =?utf-8?B?YzFJNDV6L3dCR2ZnL3Y4Sm1qckU2dENvWXZjNWtYMlpmREtuelduNVIyUnVE?=
 =?utf-8?B?RVkxeUM0cUZiT3BRMFFodS96cVdZQ1M4VjB3NW1yT29NVUI1c0o0R1JhTTk0?=
 =?utf-8?B?Uk5uY2RTUU9PZ0QyZTFJSFV6N284T0NtS0o5WTZCZlE1aUVZNzZpeGFIQ3hm?=
 =?utf-8?B?NzVqU2xaRkJuczdkR0Y1eU50UzNxVXhoVTVSck1OMFZydmhURGJWNEloalRn?=
 =?utf-8?B?OVU3NEFONmZqU3BNcllySzFHeDJheC9wSCtzYmh3VUdDRzBJNWJ5RVVmaDVO?=
 =?utf-8?B?eS81Rkc5RUhTL2h2Z2FWTm9mNEFsTnhuVHhTNWJZTEhJTU1FRnRUY2k5MVcz?=
 =?utf-8?B?ekZQY0labVdGbEQ4Z21tT1ZwQXZ6eWFwMjU5SEtoZXVSd2RqUEd2aVM3bDY4?=
 =?utf-8?B?dm1DL3N0eHBCRWZLZDg4d25jTkZ2NWxFWldQNFZaVGpRdjdvM0dUZTQrSkd3?=
 =?utf-8?B?cWoyeUdXdXlpU045ZXNHc21iL055MmpSRENxY2JHMCs1WXZrem5CT0tmRGhP?=
 =?utf-8?B?R2FxSWhoZ2xQMEpNeEVvOVRaTWlBWFdGaHFQbmZNdFFHR2ZJV0RqL0pIc29L?=
 =?utf-8?B?QjhCVXovbVBBWklyalhxWUJOWkNCNEsxYmVqeGltQkExOGdTc2VuYmhrK05Z?=
 =?utf-8?B?aDhlbER4YWNnR1lJWjN6RmUzYzdUME5JS0VWTGdHY2R4a2MrNjBaNXlsdkwr?=
 =?utf-8?B?aGV4V2JHUXhxMkdleTV6eXBxVHVEK0srcUhQNGVYVEljNkRyVEcreWNqQW5l?=
 =?utf-8?B?V0RiNHhRL2dUSGVUN2RPS0RHV3lrL2RSeXBubXJzVE1CeUJHZ1RXMHBXM1Vl?=
 =?utf-8?B?MHFwRWVsYU9DdlFOWk9nTThEVEthSkgrVVlreXR4TDF1TzZFMVprcHovOXJk?=
 =?utf-8?B?amRvNEVFbjNkNVNmbXlXZWFvWVo1TGhHV3phN2J0NzNNNENmN3RGVHR0VUVq?=
 =?utf-8?B?RzNjeGxFbFlpVG5sZVA0Ui9xOUpwaUtwVjAzYUUxY3dNNEFwTllWM2xTejlL?=
 =?utf-8?B?a3g0UmZWTUYyNkRqczd6aEcxcGZWQzVyckxMV2hkVUFOaHNvbVZVamFXVHlD?=
 =?utf-8?B?WmNYOE51aGl6cEFNN1hId3hTNVBHa0RUQzdHQkovQjNSWnBYSU92UWdJcFVG?=
 =?utf-8?B?U1QwNUxRSWpqSm9LTWFQb1NuSmtpSlV4Z3ByeHM3UFNYUVRmWnNNN3NSUWtv?=
 =?utf-8?B?UHQwMWVLT3RqbXdrd3dkOU1JMGcybXZWTG1xWkRhTjAxL3VtdTlKVG9pS1VX?=
 =?utf-8?Q?c92RqEnEO3cIOLBn543mZEbB1MoMVY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czJkOUowSmNTTmdvQzQ5NGx6bkowRDBwaFo5NnhCZU54OVFwTTVWS1dSZDNN?=
 =?utf-8?B?bUV4dVRENDNHVVNSNDUzOHcvanZzMStPWkdsVjZzdWxsbC9yOXNBTCtheGtp?=
 =?utf-8?B?QXEwaFpHVDdvbU5tZ211YWZwZFpJaHplWmc3UjJRSW40ZFhrWStvUVJ6Nktp?=
 =?utf-8?B?N0tySXNHTlM1RThubTFBWFJhY2V0ZTYxbUxSRzNXR01idG02ai9IcStYeENY?=
 =?utf-8?B?WTk4bGYwVzYvd0ZUc2crY0p2OGxLcnM1NUdJejA4M0o4RzRMenpkZG9aWGs5?=
 =?utf-8?B?U1dnVEh6UlBFUmprMUEwVEQ2SHAyYkhnMmVCZ2U2UDRvdktESnNGR2RmUEs4?=
 =?utf-8?B?Q2dxd2lBTHFJdDdMLzNzaVVleWt0cjgySnhFRFozQi9FL3RRYjdCM3ZoT1lY?=
 =?utf-8?B?c0dVcU5HYlBTM1NUdE9qbXBTc1I3YkpHSi9XWEJJY0VDU2o0RDg4ZGl1VUUw?=
 =?utf-8?B?OW9LWWhHbnNBVU9vdnZEcEpPZFZBMCtkRDVSL3J0cWdUdVEyMThpeWM2aEVy?=
 =?utf-8?B?NnJJMWx3aklheTFEb1NqQUR1M1Z6ZnNvd3hMdXRYSnplOWJpRkxkYUpOZ2Nw?=
 =?utf-8?B?SEZwbmVEV1ZpNERDY0xUcTBRQkNpTlIreVlkWGpXenkrSlRTL2QvaG1KZzNu?=
 =?utf-8?B?UCtVNGtSQ1pwSTArNDR3RTZ2cHV5Rjg2a1BvL2JiVXlKZmwwM0VmY1owRzZs?=
 =?utf-8?B?TDA3UWtZYmVHbWJJZmMvTlJYQ1o1MHZpQXFmOWF1bU0rT1dkTkFVSmRDUkZZ?=
 =?utf-8?B?NldOMlRpZ0VLOUd4alYzMVJha3kwQzVwZ0NRdG9OUXNqeWVDZiswSmkweXd4?=
 =?utf-8?B?b1BTK2dSNjh5MXZjZWlXK3dPblpjUWdrb1k4Ty9rdllpbGRCZzZTVTRTckFs?=
 =?utf-8?B?UHR0N1lhc1lQL3pBWDZySlJFM3ZobkFpVy9teXdoQ282SGZRN0tNc3o0ZFo3?=
 =?utf-8?B?UmJGQnNkRldOTXg5Sy9MSnROcFVuUXcyUXFiZitML3JnOGxrMDNUaSsyWm1m?=
 =?utf-8?B?TmsvY0x1TThZV2NRR1UwSS9TRUpGVWdEWVU0RFFnWEREdm1Vd0dVWXNMNU5x?=
 =?utf-8?B?NEs1N1NMVFJEYVhxRHpMRjI4Y1d2NFZDd3hwUXdiMGhUZnZMdlY2azRKZHF1?=
 =?utf-8?B?M3hWWit3VmxaZnZydEo2aEk5QjRlMGQvQncwcm9qUFd3cnF3VzcvcG13eVFp?=
 =?utf-8?B?YVpCV0s4MStmT1F0MURHV0FEVThoci9icW96SHRsWGk2RVBDZ0IrcEVIQlFD?=
 =?utf-8?B?VlN2c0FVS3plc2cyZDJOaXRQM3BGamEvR0NtYURQUXpNU1gzV2xxSHJhYUtK?=
 =?utf-8?B?WXUwZUVGSE0vaHUvS0tqdjBDSWRlOThWUFhKQk1CZmcyWkpDN1o5UmN0eUZp?=
 =?utf-8?B?TndyejM4dWp4WTdWb000aFdFL2dzZk0yaXEzeGl0alFHTEFFQXJQT0s4NklQ?=
 =?utf-8?B?VS9ITjAwT0dXaWFnSFhwOVk2L1BCVHhjbzBJN0xPSGJMcGhQNWNUNmhjenNK?=
 =?utf-8?B?OWc2RlZTYzU1UEZFR2MwR1ZFYWdnYnR0TjViYXlqeU05eHN6Qk0wUlpFZlQz?=
 =?utf-8?B?K1lQRy92cGxnbTAxK1ZYTktIZ1JPUE5kd2k3M1Jad2pIT2lHVEJDeVA4RnJ6?=
 =?utf-8?B?SStWejhNTjVhVDNpaUxZS2l3TEtVaTB0QUNTU2EybTY3eFU4QmxTNmVuZjh2?=
 =?utf-8?B?S01iWmwzckpqNzVoSVUzd1pWM056YXpjZ2tQTTV6SFhHN1dHZ3NUQTlzYVdH?=
 =?utf-8?B?VUU5RzJmTzNLOUtjbkhKUmdLcXVDOUZmT0RoUE1EN3g1MjB5WjR6dTBOS0lJ?=
 =?utf-8?B?LytpS2VXanpGN2VzZWxDYm5xSm9JSTY5Y2w5eW0vNm11ekQvVnBkSTR2aHEy?=
 =?utf-8?B?TFpuSGJndEIzQjh4RG9xR2RReDdjVnZKd3Z2NG5NMXFZMnYwRS9NNStvTTZI?=
 =?utf-8?B?L2YvQ0d6RXZIUzFsSGMzWUk4Y0d0MG55S2k4a2piQzFNakNNZ01PRWVWcWxN?=
 =?utf-8?B?VzJKR3IyY2RBS29ic2xOOXJLNHN2Rkg4NmI4cFltcnlzUS9nMXVRWnNqaUd2?=
 =?utf-8?B?MldKdDIzTjg2VGVvb0dvUXA3TTQ0cUN5RnRTelhuWENteklJVFVxU1d4Qmhv?=
 =?utf-8?Q?w55Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789e969a-dccb-48b9-aaac-08ddf05eeb30
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 11:41:01.9710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6NpBCo3GHp5dIwY/AMwZdsqcUOB0OuSHXl7Wg61WdTkNySJzCrd5/5tkXv2t9gWr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520
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

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29t
Pg0KDQpSZWdhcmRzLA0KICAgICAgUHJpa2UNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
PiBPbiBCZWhhbGYgT2YgUHJpa2UgTGlhbmcNCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIg
MTAsIDIwMjUgNzozNyBQTQ0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4g
Q2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEtvZW5p
ZywgQ2hyaXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4
YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsNCj4gS2hhdHJpLCBTdW5pbCA8U3VuaWwuS2hhdHJp
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAxLzldIGRybS9hbWRncHU6IGFkZCBVQVBJIGZv
ciB1c2VyIHF1ZXVlIHF1ZXJ5IHN0YXR1cw0KPg0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+DQo+DQo+IEFkZCBhbiBBUEkgdG8gcXVlcnkgcXVldWUgc3Rh
dHVzIHN1Y2ggYXMgd2hldGhlciB0aGUgcXVldWUgaXMgaHVuZyBvciB3aGV0aGVyDQo+IHZyYW0g
aXMgbG9zdC4NCj4NCj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFN1bmlsIEtoYXRyaSA8c3VuaWwua2hhdHJp
QGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4NCj4gLS0tDQo+ICBpbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaCB8IDE0
ICsrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggYi9pbmNsdWRlL3Vh
cGkvZHJtL2FtZGdwdV9kcm0uaCBpbmRleA0KPiA4NWIzY2ExNGY4MWUuLjcyOTJmN2JmY2QxMyAx
MDA2NDQNCj4gLS0tIGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCj4gKysrIGIvaW5j
bHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgNCj4gQEAgLTMzNCw2ICszMzQsNyBAQCB1bmlvbiBk
cm1fYW1kZ3B1X2N0eCB7DQo+ICAvKiB1c2VyIHF1ZXVlIElPQ1RMIG9wZXJhdGlvbnMgKi8NCj4g
ICNkZWZpbmUgQU1ER1BVX1VTRVJRX09QX0NSRUFURSAgICAgICAxDQo+ICAjZGVmaW5lIEFNREdQ
VV9VU0VSUV9PUF9GUkVFIDINCj4gKyNkZWZpbmUgQU1ER1BVX1VTRVJRX09QX1FVRVJZX1NUQVRV
UyAzDQo+DQo+ICAvKiBxdWV1ZSBwcmlvcml0eSBsZXZlbHMgKi8NCj4gIC8qIGxvdyA8IG5vcm1h
bCBsb3cgPCBub3JtYWwgaGlnaCA8IGhpZ2ggKi8gQEAgLTM0Niw2ICszNDcsMTIgQEAgdW5pb24N
Cj4gZHJtX2FtZGdwdV9jdHggew0KPiAgLyogZm9yIHF1ZXVlcyB0aGF0IG5lZWQgYWNjZXNzIHRv
IHByb3RlY3RlZCBjb250ZW50ICovICAjZGVmaW5lDQo+IEFNREdQVV9VU0VSUV9DUkVBVEVfRkxB
R1NfUVVFVUVfU0VDVVJFICAoMSA8PCAyKQ0KPg0KPiArDQo+ICsvKiB0aGUgcXVldWUgaXMgaHVu
ZyAqLw0KPiArI2RlZmluZSBBTURHUFVfVVNFUlFfUVVFUllfU1RBVFVTX0ZMQUdTX0hVTkcgICAg
KDEgPDwgMCkNCj4gKy8qIGluZGljYXRlIHZyYW0gbG9zdCBzaW5jZSBxdWV1ZSB3YXMgY3JlYXRl
ZCAqLyAjZGVmaW5lDQo+ICtBTURHUFVfVVNFUlFfUVVFUllfU1RBVFVTX0ZMQUdTX1ZSQU1MT1NU
ICgxIDw8IDEpDQo+ICsNCj4gIC8qDQo+ICAgKiBUaGlzIHN0cnVjdHVyZSBpcyBhIGNvbnRhaW5l
ciB0byBwYXNzIGlucHV0IGNvbmZpZ3VyYXRpb24NCj4gICAqIGluZm8gZm9yIGFsbCBzdXBwb3J0
ZWQgdXNlcnF1ZXVlIHJlbGF0ZWQgb3BlcmF0aW9ucy4NCj4gQEAgLTQyNyw5ICs0MzQsMTYgQEAg
c3RydWN0IGRybV9hbWRncHVfdXNlcnFfb3V0IHsNCj4gICAgICAgX191MzIgX3BhZDsNCj4gIH07
DQo+DQo+ICsvKiBUaGUgc3RydWN0dXJlIHRvIGNhcnJ5IG91dHB1dCBvZiB1c2VycXVldWUgb3Bz
ICovIHN0cnVjdA0KPiArZHJtX2FtZGdwdV91c2VycV9vdXRfcXVlcnlfc3RhdGUgew0KPiArICAg
ICBfX3UzMiBmbGFnczsNCj4gKyAgICAgX191MzIgX3BhZDsNCj4gK307DQo+ICsNCj4gIHVuaW9u
IGRybV9hbWRncHVfdXNlcnEgew0KPiAgICAgICBzdHJ1Y3QgZHJtX2FtZGdwdV91c2VycV9pbiBp
bjsNCj4gICAgICAgc3RydWN0IGRybV9hbWRncHVfdXNlcnFfb3V0IG91dDsNCj4gKyAgICAgc3Ry
dWN0IGRybV9hbWRncHVfdXNlcnFfb3V0X3F1ZXJ5X3N0YXRlIG91dF9xczsNCj4gIH07DQo+DQo+
ICAvKiBHRlggVjExIElQIHNwZWNpZmljIE1RRCBwYXJhbWV0ZXJzICovDQo+IC0tDQo+IDIuMzQu
MQ0KDQo=
