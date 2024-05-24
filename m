Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A67C25B74
	for <amd-gfx@archiver.kernel.org>; Fri, 24 May 2024 13:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E0A10E200;
	Fri, 24 May 2024 13:36:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jy9wp2ya";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15E7710EA05
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 May 2024 13:36:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9eHl48WrmJOgtF6aeAs7TAoTn5uHv0ct1m48EexOCs0WNe+1qKfpl+WPXFJPbl5a/0NmQhj0hutTBhI5tYUJdW4/c8lTqotNjauRYHNj7/LXORTlWv/UxCwZK2U8mXrmFMclMq0wdS1bHV9UljDa3EFgNYjlsvPW7CwjxkNRGbmnDCxgGusLse2yeBAoJFxeLW5fS33I1MVRJxnFingwV7vYYv6E6QJAetWS/LD+NlL0oYoTTWRCiVIDM0yKWpcVyZQSmLNom6YW/c3SytCMY+HX7A9KlNK43vOIw/TMznDTQ9OJMwXV+hEK8kKgS8CQ/OunOr+00jVxsEKgux2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/k+paAMxTwg8bhjxxWj9LkCcru8bLaAMCcX/p9yxAbc=;
 b=CnD6aCmlFkRlKGBUNeKYtGaDD6jbiBMivo1M+x+OXzMOdbvIgMQYs+gcn2WLQZM/zxnMTvtGEVZ+hssxN3nRiQJVhHWMrPkr6bkpBS7HssaKNTBL6jD1YPF710uP1h9HS8M0BGvJ7KjeYX2xFagY0wapDQfY7tYDtc7WsoOJPTmC93MzTo2EtGIMq42FlKmS7CZEjFAsfP7Dc0+JkRp5YIwtjOIcRSO1/JsCslVkIkI3oG1Zohc9WKxBy1oHZSIyM6UmUsN7aVMag+wdMSbLqyku173fy7I7nor49gg3C64ydgLsKeRXbH2mtDEfu7KCD0pFJv1mWoWuDJYanoDrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k+paAMxTwg8bhjxxWj9LkCcru8bLaAMCcX/p9yxAbc=;
 b=Jy9wp2ya4FsR8L78xdfAkcGNTvyc8wj7m850C5tqvuWopIbmrAFYscqMXBiexpf8OB3ZpBlyqJRw73LzlEnJga9TmTsNWzvg93La4a7yTdfTf80VNp9Pqpz6BN8bsJi4IjuNJoEaDJqJKLQYYLbVR/pXFWbQ/N6ru/sCMLve92M=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.26; Fri, 24 May
 2024 13:35:58 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 13:35:58 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gao, Likun"
 <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: prevent gpu access during reset recovery
Thread-Topic: [PATCH 4/4] drm/amdgpu: prevent gpu access during reset recovery
Thread-Index: AQHarG1nW5oS5CkfwUKJjHmhvnayr7GkaWCAgABFTCCAADpRgIAAA26AgAEYaICAAF+8sA==
Date: Fri, 24 May 2024 13:35:58 +0000
Message-ID: <SA1PR12MB8599A254DFF05857C8F59669EDF52@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240522172721.14085-1-Yunxiang.Li@amd.com>
 <20240522172721.14085-4-Yunxiang.Li@amd.com>
 <5025dc06-8471-4f74-affc-1070fc7e6dca@amd.com>
 <SA1PR12MB8599116F019C2EFFF427C50AEDF42@SA1PR12MB8599.namprd12.prod.outlook.com>
 <38598dc3-c815-4328-afa5-6eaa9997c755@amd.com>
 <SA1PR12MB8599A25B022AE47DFD501021EDF42@SA1PR12MB8599.namprd12.prod.outlook.com>
 <5e4b57b0-441c-4207-96c6-63d54ee62f29@amd.com>
In-Reply-To: <5e4b57b0-441c-4207-96c6-63d54ee62f29@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2e2a4035-3d4c-4fac-88e3-bcbfeb4e806d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-24T13:31:39Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|LV8PR12MB9181:EE_
x-ms-office365-filtering-correlation-id: b11667d2-0a42-4665-3abc-08dc7bf671d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WVZJT3VWcjM3b01RUTh1TEd2YWI5blhUSzV3cWdmdTcwVm44QmJMV1N3bVYy?=
 =?utf-8?B?WkhJZlNiLzZvSlcxZnplaUlrU1lSU3licnpxZXpHZ1NVdm8yelBTZlN3b3ls?=
 =?utf-8?B?dlMzV3hGZzdqN2l4cUNCZnE1TnFya3g3c3BOYlYrcUNLbEhkV1pjSXpIRnNX?=
 =?utf-8?B?bnF3QWwyYzVTcDdPZS8wSWtFelk5Wld4MEl3Y1J6WWRnZ0xidWVkOE0xekEx?=
 =?utf-8?B?bnFKNjBMSEpnTFEwNlNnTHh2ZnlWYU5hcHhQYVltZExFbzMxVXBvTEt0SjFP?=
 =?utf-8?B?KzREaThzdk9OTXdPTk5oWGxDam15RTgxV3V2Zm4vZmpHWmlWeHp0MUZHN2hL?=
 =?utf-8?B?MHI3VnpnVTJPMXl4YnBoUFdtK2R4aFc0anltUnNxYzNUZGp0WHNLc2dpenNr?=
 =?utf-8?B?Y2d2c1hoMFRlS0JROElpbXJXbUJFcTNHUjk0NWZpM1VYVTNOOTVoTnQvZjlR?=
 =?utf-8?B?QkRJeFVBVWQwemt3ZFg1TjF3Yklwa2d6ZDdVQS9ObXgxcklIOTRUNTQ5WWZW?=
 =?utf-8?B?UXdNVVdmYUNLdkZNdzFKOXlENWNyTWJ3THBDdmRtZGp5aWdkK1BQeGpwZWk2?=
 =?utf-8?B?WXZkK0NXQVVHVUZEeWY1bE93b0pBdXJwblZFdHpGVmRsdGJGMDRSTVlQaGVT?=
 =?utf-8?B?bDMyaU0zdVJVNTNpSE5EU00zNnFudDJtOWROTXBiNTFXTnRkQ0NBM2o1elM2?=
 =?utf-8?B?QlJrb0hLb0I0VVMvVWROdlhjeTdPVjVQbXNRZ3lxdjV0QmVuVm1tRFcybmJX?=
 =?utf-8?B?b2NyY0dBWHYyYmVTNVVqZGdoMS9TVmUzbkNpZHlRdlB1SGlmUWpxTjFXUU1s?=
 =?utf-8?B?Y2k4eU5SRGdENGVsK2dIMVY5ZFBKaUtHZ1dHeFh1b0Q4ejhSMExxQzBHTjlw?=
 =?utf-8?B?aTJJS3NXMjRoSjJlVytIVUVUbWNJTnhwRnh6Q0ljeTRCWURWaVpERm1tQlNH?=
 =?utf-8?B?TkZJNllZT3BFSzNqYnY5SnpYV3hLUUY2emkrbW0yZWxTVlNHYi9KQ0lWSW5V?=
 =?utf-8?B?SGxrLy9GQms2NWtPWDNTUWw4TkNYNXA3RTdDQlVTRnhKVjlpRWtNcHpTT2V3?=
 =?utf-8?B?NmVaWlBPU2hGc0o4a2xyck92ekkzK3daNk1kekVzQjlHMVdtdm5WRXNHQU5R?=
 =?utf-8?B?NXdpNnhab0dvSjlvcmNLblBCNDI5WU15MVVYc0RQcUgvbTEwRnFBdm5Ga2cr?=
 =?utf-8?B?SXBZQXBBV2pHaVBFd3VGQmpRb1B6bGc4V21NNnFQRVF2bUQ0ZHNYaVJYWm9r?=
 =?utf-8?B?SE83b083b1VqaGRtN3RRM0NSbWYrV2hPNmlSbXFreGJNRk0xUFQ1VG1QeUFy?=
 =?utf-8?B?NmMzaTNmTnBlWHBsUVBiUjBNVlR5ODlNUi9MNHdoQkVrR0wvVGczUjNaUVZo?=
 =?utf-8?B?cFZPMVBlempNMm12MGx4d3pMdVR3aHhJbWlNSFhPV3dTbGZKdDJncXhxWUlM?=
 =?utf-8?B?WnpJL0QzVzQzbjhzUmNDZytuc2dBalVGVlZUd3RxRGZrMWtaWVpPWnRZLy9X?=
 =?utf-8?B?V2VoYkNUUVdxVkUxRE00U1M4TW15a0JjUHBPc1VQQm5ibENSbEd1aGtrTjhP?=
 =?utf-8?B?TWw0R3YyRG1NbnB4SnMxMEdKTk9qcnprUmFyd2pyN3VXemUzdkRaektBVFlE?=
 =?utf-8?B?ZEUvUjU3WHFWaXNuS014bThFUFZEaVBQZmMxZTMyTzZFNWdOV3hXajRKRWt2?=
 =?utf-8?B?VFhxbnBteis0QXRXRmpmMmd3aHFCZkdnVzhNYmxnYTk2UnkrM3BIS1RwS3pp?=
 =?utf-8?B?b3FlS1hWSFh0OGVQK2lZZEg4Q0lsUHBkS3p5eTBxRkF0b0FTdUI1dGpTYVov?=
 =?utf-8?B?UEZ2b1hteWczNXBNRDdZQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDBKSkZuR0Q0dFJ3T21CaE5VVFI3bTFVdnd0TWtzRk1SeEZ3Uy9mTXplYW82?=
 =?utf-8?B?SGpuYmdUODBHc2ZyVi9MclRoM05Jb3ZyTHdHZklDUTBuMXM4bGQrbnBxZFRw?=
 =?utf-8?B?S1dmcjZHM2ZMSFplV3BxaVJMMkRoSExkUEZnY1F3bXo0YlhmcVpOa0MxSjZR?=
 =?utf-8?B?MHoxZDRNenhjR1NSRFl2TVBHTTRkeU9QT1lnd3RjcUlXdWlLSTBQeGVGTGx2?=
 =?utf-8?B?SEc0citmaWlmK1pwZEh5WTFEdEFmMmkzRUhkUk5TQjFSbUk1M1FoMVFrMjQ1?=
 =?utf-8?B?OVRaMG4xZzNFb1pTNnZiUDRoV2VuR1N3cVZ0YlJzLy9zNkI1N0tRai9WYmRs?=
 =?utf-8?B?cGtLemFjRUd2QVJ2a0U3UFBycXJhTzhsOW5qeGc0Lys1ZHJUY2tqMC9JMm1u?=
 =?utf-8?B?SVZReEc0QkkzcC9QOHRoa0g0SHVCdUEwbzFKell1UFFrTXVBNlJReHh0WkRn?=
 =?utf-8?B?TGRqb1U4ZkJQclAxWDhkU0VQQ2FZOUdFOFRnOTdRNTFYK1BQV09MZ2pVelRH?=
 =?utf-8?B?eVBLMWZHWlIrRnpTVFllcmp4M3J5ek9menhlaERjVnc2dlJDb0JDN3g3WFEz?=
 =?utf-8?B?R2o1MW16SlBuMGRGTElNL08rM2tnaTA3NjFGbFRGZWJ0TmNCZ2lRamFhRU10?=
 =?utf-8?B?akFkT2xiZWZrN3lseDRHNWgwTGdrd2JrMjRSdEwxODdOUE9lNU00QlBOaTJ3?=
 =?utf-8?B?ZDhDQm81YXRSaG56dEQyM2gyWG1iRVdzY2NPWDdnU3BmcDFQeFhVSWZEL21u?=
 =?utf-8?B?WkRQYklHUTg2aXlJL2FNMzAxQyt1Y09iQVpMSk0wOHdOUEN5cUY2elc2Z0hG?=
 =?utf-8?B?L1YxM3g5MHRnaSs0cWpsUjFpQmZaNGNFY2MzbDlUM0VDSUh0TkpPLzVVQ3Bt?=
 =?utf-8?B?N3QrZG13TjQzQlBFU3hOWWF5WTY2dy9EdkhXWVZUT3lpemhuT2F0QUo3b21S?=
 =?utf-8?B?UGRuOW5ucTJkbGl3RTdqK2h3Qi9LbmIwQlF5RldtQzRSN3gvelZpS25HTU5S?=
 =?utf-8?B?dUdrRUpSMEJzcjNQdUJLbk9tbFFGRG9HZ096S0YwVUozbVlDWlJHWkNldTFG?=
 =?utf-8?B?L1pYd2JUQ1NHa1h0NElTNGVjK0N5bmg4WGlRZXI0SWptOVQ3QkdxRnMrUmhS?=
 =?utf-8?B?bjY3cmdWdDlOVVZqa25vK3BJMU0xR24yKytZQjR2bDFUYUc2OWdEakQxODEv?=
 =?utf-8?B?c01kYkIrTGF5V2g5U2Y3Q01XOCtDYTBEdVh1dlA5amxsVTdQZVNFVWpoMXJE?=
 =?utf-8?B?OVRXMVFaQW9sMmlBU2kvSkN4UzVHNHdBQzBWekRqeDNMeXJrSkRxQ1lBMDQ0?=
 =?utf-8?B?cHZHSWhvSHVpLzVaekFuQ2pNNDdXZEV1MHdubFVpTXFncTVFWndnS3ZlYWtl?=
 =?utf-8?B?SlhrVDdYeGw1V3Z5SGxLd3VqMWc5US9wY0krbU5JekRPWGJHUmhIV0ttOTlZ?=
 =?utf-8?B?MEtzdWM1VnYzbEZPdDhBbk03M2dXOWUrTmJIQllFajAwOWxjU25ZVzJ5QXha?=
 =?utf-8?B?ZHdzMm5uVnN2T1BnbmoyUS8wdEt0eEh3U2RJbUZyd1lFWS9sTCtERDlyRS96?=
 =?utf-8?B?cHNWVW1VWGJOU1hJcTJqcEg3YThkVksxZ1VUeCtWMEg2c3lpUDljRkh1WWYw?=
 =?utf-8?B?MXFNOElOMUVDcFNGcVBPcWQ0TitvQUZqSTI2YTlIZmlFT0VOMzl0alBWSlov?=
 =?utf-8?B?a0xxTEJxMmJxMEJiSHNNbFkybFNYUnhib0wxR1pQM2E0S0VMWnhpL1RNTlFN?=
 =?utf-8?B?UUR1MkRkU09uWXVjZVk2WmtTNTRKV0tDajJSZTBNQUhUMjRQNnlzS0lpenJ4?=
 =?utf-8?B?TlVLNDN6Qk5SUWMxWjBIa0dPeDR2MHZGVlNHNjZwQ1NQTlp4SFZibTRqd2ox?=
 =?utf-8?B?aHdTTW4zaFlFc1NPQTFPNHZRYTQ2UWM4dVczVjMySzV0cW9jUkd4MForcFBJ?=
 =?utf-8?B?amROMXBNeWVSMHpnaVNWTDhSOFdoaStNUlkyaytpclh6NWVEYldVQ1VqNXZo?=
 =?utf-8?B?YmVFZDUvd3g5WUY4Ly9BekNtRGlObVhTSFhOUnJsaTMzZVcxcENqVVJmZ2Vj?=
 =?utf-8?B?VXZkL21HdmVHV2xHNGpINU8wdlNIU2hBQ1ZiRkpIa2czQjBYZzZvbXlYMEt6?=
 =?utf-8?Q?hISc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11667d2-0a42-4665-3abc-08dc7bf671d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 13:35:58.1602 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARUdYToID9Ei9G394nVfM48TdWs/djOx6rityhgf1Y87B1U1ztCdhuXty5nCIjxHnBgz424x1zIouBRmfjvtcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181
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
Cg0KPiBJZiB0aGF0IGlzIHRydWUgeW91IGNvdWxkIGluIHRoZW9yeSBsb3dlciB0aGUgbG9ja2Vk
IGFyZWEgb2YgdGhlIGV4aXN0aW5nIGxvY2ssIGJ1dCBhZGRpbmcgYSBuZXcgb25lIGlzIHN0cmlj
dCBuby1nbyBmcm9tIG15IHNpZGUuDQoNCkknbGwgdHJ5IHRoaXMsIHJpZ2h0IG5vdyBJIHNlZSB0
d28gcGxhY2VzIHdoZXJlIHRoaXMgd291bGQgYmUgcHJvYmxlbWF0aWMgYmVjYXVzZSB0aGV5IGFy
ZSB0cnlpbmcgdG8gc3VzcGVuZCBlaXRoZXIgZ2Z4IG9yIGtmZCBzY2hlZHVsZXIgYW5kIGxhdGVy
IHJlc3VtZSBpdCwgd2hpY2ggd291bGQgcmFjZSB3aXRoIHRoZSBzYW1lIGluIHJlc2V0LiBJdCBp
cyBleGFjdGx5IHRoaXMgdHdvIGZ1bmN0aW9ucyBJJ20gdHJ5aW5nIHRvIGF2b2lkIHB1dHRpbmcg
aW4gdGhlIHNjb3BlIG9mIHRoZSBzZWNvbmQgbG9jaywgYmVjYXVzZSB0aGV5IGFyZSBjb21tb24g
dG8gYm90aCBpbiBhbmQgb3V0c2lkZSByZXNldC4NCg0KVGVkZHkNCg==
