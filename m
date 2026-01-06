Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CA7CD0430
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 02:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5EDD10E43F;
	Tue,  6 Jan 2026 02:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r70/AzDi";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011058.outbound.protection.outlook.com
 [40.93.194.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE5E210E42F
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 02:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvpNSUxp0KCHqUhkdWJYQAboQjMvZ8Dko/LS019bP1GMEEOukpc7IA4PhRkpm/P9h6xjg3bLDfiFy5R9smORfQ+h77PeQ2LfOjyPtq+wZzNs5O6X+xyhpA2z1h//G5o1N0S7Acvfm/4Kj6c41uuH8MuGCGq75hZ4oiAeyql6c6UhxXSlvDNBK/hEkfqhLFvatKaxnn+Z4QTMMNOro0OW5ry+tn4CHtavvmzcnlLjLHDfF2vcBZnbEUDg6uTXKuwzPjLqiYlOJjCp1bMrnmCT2vdSyn/Cq7HCOgz5/HkDB+sflWPcB/jpwuY6WF6BWCdR6jFqd8mZqvNznRcfU+x34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC9UgdI7EjLV0SY5sek7tsNKvU/02CuGxZ5xSgwi3M0=;
 b=HiYal4e5FyTYMKvcGljLg5aloD0cJtCgeQsemOvMju/+p5OMoEcZ3U5vXHtIjYbsOgkyMuWensfDHzHQeArD3kyJmODoq1fdKKPIe1aobsuYq14W4tZ6Dmcj6J03TrHU3VqBXJXLgYxHqznQEI5xGA0hD1XFGNW15LoE10cdErJDSwq9QQ0UQwsnumk8m8peIytj+MYSTTxJr65Mr1oemM/Biy7n/fMReOjTbCkH6ezvF/M/0me1oeeGpUQ664rOuQBXhfZJNclVwsAQQ5Tfa4p0bqoe5G/unkz3dWOoWR2KO1+QFshVM2yF+3Ks5gZBm8l46G8+SJ021HSP9W76/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC9UgdI7EjLV0SY5sek7tsNKvU/02CuGxZ5xSgwi3M0=;
 b=r70/AzDiGGJFDnx/xuFatMzqYz1bDI/75Nx204xN/kI+X5RUcUsNXoDbazw3KPBrSpyF9ms4PGSaHa/028C2yRkc4RXT2rEWru9o4oOG0EnQgGIC7TjwXXl0bef3xg5JCeKw0dw2+GAQuQPpQkSQRHfxqWq3rwoLJR2PSMqZBX0=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 02:46:33 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%5]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 02:46:33 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Disable MMIO access during SMU Mode 1 reset
Thread-Topic: [PATCH] drm/amd/pm: Disable MMIO access during SMU Mode 1 reset
Thread-Index: AQHcdkA5cwuXUrPLhE+hNzDnl1DWZbVEO+eAgABEuAA=
Date: Tue, 6 Jan 2026 02:46:32 +0000
Message-ID: <CYYPR12MB86555F6353D522C3B96820299C87A@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20251226081800.2475186-1-perry.yuan@amd.com>
 <CADnq5_MSrvCuE6_=kx2xNw38-XZUVVa5sp_-3WUhVV2+Ey4RGw@mail.gmail.com>
In-Reply-To: <CADnq5_MSrvCuE6_=kx2xNw38-XZUVVa5sp_-3WUhVV2+Ey4RGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-06T02:45:47.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|MW6PR12MB8835:EE_
x-ms-office365-filtering-correlation-id: 17e91cb5-a385-43ac-aab5-08de4ccdcd52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NDJyUFhaekJ1S004a0k3djQwcEtFb1VJREJPZ2RyRGdoSDljbkFUcE9EVzRN?=
 =?utf-8?B?Y2RsS0s0ZWlDdExLcHJzYitkMFVCK0ZickFIWWpIY2hqRTNvL1dUWlVod0J2?=
 =?utf-8?B?RElNVTN2Z3lFUlVwZXpNMm5IOEtNV0F1SUpoazcwMkY4Y2Q4TGU1UGFCRkZj?=
 =?utf-8?B?TWpDVUlLdVhuMlNvSnQ4Q2M2a2xZejhLbXpoRmx5OEVmU05qSmxFaWQxRXpN?=
 =?utf-8?B?eWZuRVVzMllmWWxpNUdpdEtRT2pnL1RlRGdkdFRyZkhKMnRDcFhCR3g4RkNu?=
 =?utf-8?B?RGV2N0V6ajRuOGJ3WTFVWHIrTjBDRjk4TllVdER0WC96ajhmbEUzQXJIakFH?=
 =?utf-8?B?bzl5SmxTN01kTnVnNkVLam8xOFJwcGljMjFLVXFBRElhZ2RnKzJyK1NEa1Fo?=
 =?utf-8?B?bjQvL2xDRlVBS0RSUHAvcDZldkFxd1VOVkYyRW44UlI4bERnZ3ZJRUpUeVdP?=
 =?utf-8?B?TStGRFo5N0dGQTdha0p0bEN1dWM1dHZzeE4wREtJRW1jdnk2cnA4MExtdC9R?=
 =?utf-8?B?ZXVWWmxzODI5b1g2WnpYMnhuQ0RvNnBMM1haSC9vVnN3NzlCd3pXdVVEVW1k?=
 =?utf-8?B?UnRqUkt2S0phR0tSK3UwSGZnTlQrL3VNdVQ5T2pobDNsMnhsNEpsanVCVm9U?=
 =?utf-8?B?OTJGK0pzQnM0YURqb0hJSFhoa0ZBR2hOL0IxUlNWdUZRR3lYQ0pKa3A5V3Fn?=
 =?utf-8?B?SDZGanBra0FLcXA0TVRuZkFSS1NyVGZPMGdKdm1ROU1GNE1XOVRTL1lCR2c0?=
 =?utf-8?B?YmxYYVVEWE0wUVNoZGFDd3hZUFRXR3JpeEVRMHVTcnFjM29KVWYwcERWMUE5?=
 =?utf-8?B?dzY0N1dZbE4rV1Zybmh1cTdYQ28xdjNUd3pDY3hxekhTVDlUQ1YybTdmNDN0?=
 =?utf-8?B?T2FkdGtPdGdWUEJzbnArL0g4dDhFWncvU3FRZ0FLSHNEWUFZOEM3UFFLNkpK?=
 =?utf-8?B?dEtaMVNUVXpNbTM1eml4cmFkT0JyZitCOHFsMFBwSlNYTWkrS2dXQ3JFV0pk?=
 =?utf-8?B?K0RpbFVoK0thNHlZOFIyUVhmVUxLQTFEb3BET05mbHRRc1ZEVzJCYk51WEpy?=
 =?utf-8?B?TkRNTkkzNEpSUnZyQjUrWHBzOWY3UGNNNkJjTUZlUzlNMnRIUVg1aGdQZkt4?=
 =?utf-8?B?eDJJaFd3Rkw4ZW9CbWZFMWQxZFpXMFJOUUwyc3VSY1BiaVg2amFEeG4zdXQw?=
 =?utf-8?B?SytmcWtMZUd5VEJKVnl2REJ3eTdpQkZnaGZkdklJMXB0cVYxc01FRFM1WHli?=
 =?utf-8?B?QjRYdG05bTBtcVZ0QytGdStSWjNyU1k1aCs5Sk1HL1Y3RGkvQTJTSUZtbjh5?=
 =?utf-8?B?UGRTdDBVbi9qcGh2OFF3alBXOXczcVozS09KVmVuUGZLMmRYM0JsWVFkR1gv?=
 =?utf-8?B?R3lFclBzQkZTbHFtVHB3Ym1zQVlHQkdxMTJHd2lYNS9EaW9BWmlXRXA5c1lL?=
 =?utf-8?B?c1NadVJtUFNJNG5STzFGS0RUUHBpMHlDYjduU1VGYWtla0U3aUJMRkJBRjE2?=
 =?utf-8?B?WTF1R1ZZSDd1NkIrc3FTQStNcmVsS2srOGRzc3ZkOHAzelFYUlArOUxPOEVi?=
 =?utf-8?B?T3VxM2lQaFVieTF0RjNtZEpubnl3Z09QcWNMZkpPa0xwTTNuNEJ5VkR1ZnZp?=
 =?utf-8?B?a1d0WFUwTVZ5S01FeDdEK1IyNThYT3E1WHE4LzdFNDFtUURhUEtPdTNXSkMr?=
 =?utf-8?B?bHZBR21PTm9IcUVEbW5LOThHTGtLd3FCOTI1aXgwYTJpVzVQYmNpT1JNRWI5?=
 =?utf-8?B?Qk5OeVppV3JzS1U5RmNIMFEvVkN0Ynh5NDd5UnlCVENITjM2ZHYzVEgrTDZR?=
 =?utf-8?B?bVRaUWdnM0x4a3l0NlhKajRYWU1JMTNqaTFrcnJ4RHgrZXFhd1F4TFgyNXRh?=
 =?utf-8?B?ZTJtdTllT0NJY3ovVG0wd3VJTG1heUVYU2t6cHZET3dSY2luUDJVL1VNUnV1?=
 =?utf-8?B?dnE4S1BjZUpEaEtDOGJsaGZBSGYvWHNFQUZRV1B1NzJEK2RCUEFxY3loZmFu?=
 =?utf-8?B?WHZTZExSaExMN0ZmcmE0UUU2eUJLMFpDbnJaVTF6V3c3L0hIRDJobWMzejJh?=
 =?utf-8?Q?5Qa88l?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8655.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THJDQWdmdXAyd1N0WEN3c0ZybGVLVmFRcStQRDdQSXl3S0RyUVFlbGJxNXRF?=
 =?utf-8?B?NFM4cDMrZXNkY0M3TDJESjBjc1FWMGpBUW0rcThHdXNtWEg0eTYvU09EZ1J1?=
 =?utf-8?B?SjJFcUZsaTI0Y0xpa1dTQXJET3hkZlRGOVVPYnlDWWtERy9qK1JDRUEwK05o?=
 =?utf-8?B?a0RXR2NlSjIrTG9NSjhFRHhVaFdsb2x6b0RLZmIvbFlpOXBUOWx3Q1lDRWFW?=
 =?utf-8?B?OWxsaEp4Q21DNE92Um1yaktYbU9BREpibEJnenkrRzExWTRTTDdnc1hEdGNs?=
 =?utf-8?B?ek1FMkVNN3pGRHc2am1neVl1T1lPQW5tL2Jmc3E1LzdWVjFaWG1janQ3TkZE?=
 =?utf-8?B?ZTRSUkh3djV1UlpjWDI1dHB4Vy9TL0FnRnpvZ01QRzFBK3RxWEJvRWl0akZp?=
 =?utf-8?B?NDRCYWZpNzdBT212R0J2MXRSKzIvOG0vZjRtMTh1Sk92ZVp1TEExb0ZHYlcy?=
 =?utf-8?B?N1ovSEtabGY3NUxLMnVWNVcyYllnd0Q0VzRMZzQ2YXNEVzljblRleS8yaEhh?=
 =?utf-8?B?QVppV21PckxRQ2kreXRqVUxsSkFHanAwZzc1aW1abC93RzkvaG1kbmJ3SzRU?=
 =?utf-8?B?Qk1QY052L0QzbkRxODVpc1pCR29KenlTSXQ4Um1aK0tvOExoQWFLVk4wMGdP?=
 =?utf-8?B?akhFUnZBT2hEVFZWS0oyTkJWZGVLSWlzcW5sWEZJaG52VEV5d3BhM3duN3oz?=
 =?utf-8?B?cElOczVTSjVRQ2o2elk4SFhjenVWV0dVTzhBK0k4K01uTlNaSDVIVmNoVXhJ?=
 =?utf-8?B?ZUpYL3p4RmtZcjhLc0xzK3JLa3ZpQnN6bmd6VTFXSUhybHh3dTEwbSs5cGlm?=
 =?utf-8?B?S3NWTTA1cFVXT2NHSXhEZTBmbXN0cCtMb2ZFNHkvZUt0a2ZTUWhlQlpOSEtY?=
 =?utf-8?B?Q0lpL3dManZ3aHVFbVVia2h4ZHQvME1LQkMwU3RQOHlBWit3Q2EvK1NvRWJx?=
 =?utf-8?B?Mzk4YU00VE5UME8vVjBVYkRBR3FQN2o4cklBYmhoeG1YV0lUdnRNcmZIMXJw?=
 =?utf-8?B?dkdoWVZJRkpESXBPZ3l1Q01lZzkzOVhyNWZpTk82cXM1dWlzbEhqNEtzU1hv?=
 =?utf-8?B?WnBFNzNYYTJsMGJDbGphd2VtUkw1L00zdmZ3aVpyaG1oVDFTdjBrQktDb2VS?=
 =?utf-8?B?ekJKWFdvbk9seitjTlJNNEhzeHVOU3creXA1VENHUEtveVhoR1dTZEdkTnRP?=
 =?utf-8?B?Z0s1TUNuU2ZWRVpEVHNwZnREdWszazRDMHdabEhlRndDcVFOdkdEQXl4eXpP?=
 =?utf-8?B?T2c3NE50M2tLMFE0cGkyUFprL2ZIK09KU2NnTFdzL1c1ZlYvMW1QamtBbzlV?=
 =?utf-8?B?dWsybXFzc2dGMlFyVHRhd3lOUVdva1hXT0twZGZlaG1TRVpZeEFSSFRjUGtM?=
 =?utf-8?B?bUdRQTIwMlpkZzlkNVhqakl1aStoWThCekdEUEx3c3RHWmgweXN2WmtHNEo1?=
 =?utf-8?B?UURlY2M3NUNraWVTVDF3emlCWmovS245cis3bEMrWDlxV0cxL1RHNzNUVzBI?=
 =?utf-8?B?K0hSY1ljSDFzakdtRVV5eFNLRkE1SjE5YXMyakZBQnN5Zmc4enQ3azV4N3l4?=
 =?utf-8?B?ZGlYR3VmcEhFSWROd3FLOEpOQlV3c0l0VWZRdXAydmFlWUk4YUx2N3hwRXZS?=
 =?utf-8?B?V2t1N2xMc1VkcHlwRFN3eXZzR1M2RU5SbHUyNERDSW5pUUFITEJrS3l1Mjlo?=
 =?utf-8?B?alJ2VGhNdkdyQTVCNnpDYXhiY1RVbm1adnJaSU1RTDVYWUVEV01YRXptd05G?=
 =?utf-8?B?b3ZXaUdGdU9mT1lXOG1wM1BCMDNHY3BCNG1kT3k5WWdHWHZ6Z2hmY1k0bE1j?=
 =?utf-8?B?NGF4L2NhaU5LeW8wcEhldzdOU3R2ZDh0Zk14b3JuRkNRc1BPZkxoQ3pxOVph?=
 =?utf-8?B?SUY2eXE1dWlxNzFoWmVRck14TTAvNk9NQ05WcjhVa1FMM1haNW1CK0lDZXRH?=
 =?utf-8?B?NjVCN3dNZUVldzJnd2FITG1yRVFQQVZlckhFZGxsUlZKTFNIbUUzVWhHZVF6?=
 =?utf-8?B?ZHgyNmNqeW90ZDVJVE52andyWlZ5Nll1Q0dxNzV0cER4bEUzeXZpMmFWcTF2?=
 =?utf-8?B?NXdFclBOTXFmSWFhZStDS3ZsbjgzaWtEZnBLbHVsUEVzeHhXQlh1aUxSbmNi?=
 =?utf-8?B?SWFNTFFRUlMvRUErc050RkFMMkQraUN0d1ZERWJZNjVjV0dZbk5HUmxhcTZh?=
 =?utf-8?B?SHBnZjkyRXpwY0tNSGYxWTByRXJXWlZkZHY5bERvMXVhVkV1MGhPbmVEcVhU?=
 =?utf-8?B?bDZEQUhKK0pHalFzNnlBSjFnWnhNeUFnYXlsclFreXY4VkpqR2theHhWaFE0?=
 =?utf-8?Q?OhLyFHEHvrbCPk0v6v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e91cb5-a385-43ac-aab5-08de4ccdcd52
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 02:46:32.6689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXC/hSrG42hf/wscaAPxmPYwFSZlqBcUmyUzAl8Y0Alf6IYifDYxLGewXT8H8GH9e3jrCaKru6+VlgSCNseIBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835
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
Cg0KSGkgQWxleCwNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFs
ZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKYW51
YXJ5IDYsIDIwMjYgNjo0MCBBTQ0KPiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNv
bT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5k
ZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBaaGFuZywgWWlmYW4gPFlpZmFuMS5a
aGFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL3BtOiBEaXNhYmxl
IE1NSU8gYWNjZXNzIGR1cmluZyBTTVUgTW9kZSAxDQo+IHJlc2V0DQo+DQo+IE9uIEZyaSwgRGVj
IDI2LCAyMDI1IGF0IDQ6MzbigK9BTSBQZXJyeSBZdWFuIDxwZXJyeS55dWFuQGFtZC5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gRHVyaW5nIE1vZGUgMSByZXNldCwgdGhlIEFTSUMgdW5kZXJnb2VzIGEg
cmVzZXQgY3ljbGUgYW5kIGJlY29tZXMNCj4gPiB0ZW1wb3JhcmlseSBpbmFjY2Vzc2libGUgdmlh
IFBDSWUuIEFueSBhdHRlbXB0IHRvIGFjY2VzcyBNTUlPDQo+ID4gcmVnaXN0ZXJzIGR1cmluZyB0
aGlzIHdpbmRvdyAoZS5nLiwgZnJvbSBpbnRlcnJ1cHQgaGFuZGxlcnMgb3Igb3RoZXINCj4gPiBk
cml2ZXIgdGhyZWFkcykgY2FuIHJlc3VsdCBpbiB1bmNvbXBsZXRlZCBQQ0llIHRyYW5zYWN0aW9u
cywgbGVhZGluZw0KPiA+IHRvIE5NSSBwYW5pY3Mgb3Igc3lzdGVtIGhhbmdzLg0KPiA+DQo+ID4g
VG8gcHJldmVudCB0aGlzLCBzZXQgdGhlIGBub19od19hY2Nlc3NgIGZsYWcgdG8gdHJ1ZSBpbW1l
ZGlhdGVseSBhZnRlcg0KPiA+IHRyaWdnZXJpbmcgdGhlIHJlc2V0LiBUaGlzIHNpZ25hbHMgb3Ro
ZXIgZHJpdmVyIGNvbXBvbmVudHMgdG8gc2tpcA0KPiA+IHJlZ2lzdGVyIGFjY2Vzc2VzIHdoaWxl
IHRoZSBkZXZpY2UgaXMgb2ZmbGluZS4NCj4gPg0KPiA+IEEgbWVtb3J5IGJhcnJpZXIgYHNtcF9t
YigpYCBpcyBhZGRlZCB0byBlbnN1cmUgdGhlIGZsYWcgdXBkYXRlIGlzDQo+ID4gZ2xvYmFsbHkg
dmlzaWJsZSB0byBhbGwgY29yZXMgYmVmb3JlIHRoZSBkcml2ZXIgZW50ZXJzIHRoZSBzbGVlcC93
YWl0DQo+ID4gc3RhdGUuDQo+DQo+IFNlZW1zIGxpa2UgaXQgd291bGQgbWFrZSBzZW5zZSB0byBl
eHRlbmQgdGhpcyB0byBhbGwgYXNpY3Mgd2hpY2ggc3VwcG9ydCBtb2RlMQ0KPiByZXNldC4NCj4N
Cj4gQWxleA0KDQpTb3VuZHMgZ29vZCwgSSB3aWxsIG1ha2UgdGhlIGNoYW5nZSBmb3Igb3RoZXIg
YXNpY3Mgd2hpY2ggaGFzIHRoZSBtb2RlIDEgcmVzZXQgY2FsbGJhY2sgdGhlbi4NCg0KQmVzdCBS
ZWdhcmRzLg0KDQpQZXJyeS4NCg0KPg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVh
biA8cGVycnkueXVhbkBhbWQuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBZaWZhbiBaaGFuZyA8eWlm
YW4xLnpoYW5nQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYyAgICAgICAgICAgfCAzICsrKw0KPiA+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMF8wX3BwdC5jIHwgNyArKysrKystDQo+ID4g
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0XzBfMl9wcHQuYyB8IDkg
KysrKysrKy0tDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYw0KPiA+IGluZGV4IDgyNGM1NDg5ZWM4NS4uNzViMWI3OGMwNDM3IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYw0KPiA+IEBA
IC01Nzc2LDYgKzU3NzYsOSBAQCBpbnQgYW1kZ3B1X2RldmljZV9tb2RlMV9yZXNldChzdHJ1Y3QN
Cj4gYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiAgICAgICAgIGlmIChyZXQpDQo+ID4gICAgICAg
ICAgICAgICAgIGdvdG8gbW9kZTFfcmVzZXRfZmFpbGVkOw0KPiA+DQo+ID4gKyAgICAgICAvKiBl
bmFibGUgbW1pbyBhY2Nlc3MgYWZ0ZXIgbW9kZSAxIHJlc2V0IGNvbXBsZXRlZCAqLw0KPiA+ICsg
ICAgICAgYWRldi0+bm9faHdfYWNjZXNzID0gZmFsc2U7DQo+ID4gKw0KPiA+ICAgICAgICAgYW1k
Z3B1X2RldmljZV9sb2FkX3BjaV9zdGF0ZShhZGV2LT5wZGV2KTsNCj4gPiAgICAgICAgIHJldCA9
IGFtZGdwdV9wc3Bfd2FpdF9mb3JfYm9vdGxvYWRlcihhZGV2KTsNCj4gPiAgICAgICAgIGlmIChy
ZXQpDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMv
c211X3YxM18wXzBfcHB0LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
MTMvc211X3YxM18wXzBfcHB0LmMNCj4gPiBpbmRleCA4ZTM1ZDUwMWU4MWQuLmRjYjE2OWIyNTkx
NiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3Nt
dV92MTNfMF8wX3BwdC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9z
bXUxMy9zbXVfdjEzXzBfMF9wcHQuYw0KPiA+IEBAIC0yODUwLDggKzI4NTAsMTMgQEAgc3RhdGlj
IGludCBzbXVfdjEzXzBfMF9tb2RlMV9yZXNldChzdHJ1Y3QNCj4gc211X2NvbnRleHQgKnNtdSkN
Cj4gPiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAtICAg
ICAgIGlmICghcmV0KQ0KPiA+ICsgICAgICAgaWYgKCFyZXQpIHsNCj4gPiArICAgICAgICAgICAg
ICAgLyogZGlzYWJsZSBtbWlvIGFjY2VzcyB3aGlsZSBkb2luZyBtb2RlIDEgcmVzZXQqLw0KPiA+
ICsgICAgICAgICAgICAgICBzbXUtPmFkZXYtPm5vX2h3X2FjY2VzcyA9IHRydWU7DQo+ID4gKyAg
ICAgICAgICAgICAgIC8qIGVuc3VyZSBub19od19hY2Nlc3MgaXMgZ2xvYmFsbHkgdmlzaWJsZSBi
ZWZvcmUgYW55IE1NSU8gKi8NCj4gPiArICAgICAgICAgICAgICAgc21wX21iKCk7DQo+ID4gICAg
ICAgICAgICAgICAgIG1zbGVlcChTTVUxM19NT0RFMV9SRVNFVF9XQUlUX1RJTUVfSU5fTVMpOw0K
PiA+ICsgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTQvc211X3YxNF8w
XzJfcHB0LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTQvc211X3Yx
NF8wXzJfcHB0LmMNCj4gPiBpbmRleCBhZjFiYzdiNDM1MGIuLmIxMDE2ZGViZGYwNiAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTE0L3NtdV92MTRfMF8y
X3BwdC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVf
djE0XzBfMl9wcHQuYw0KPiA+IEBAIC0yMDY5LDEwICsyMDY5LDE1IEBAIHN0YXRpYyBpbnQgc211
X3YxNF8wXzJfbW9kZTFfcmVzZXQoc3RydWN0DQo+ID4gc211X2NvbnRleHQgKnNtdSkNCj4gPg0K
PiA+ICAgICAgICAgcmV0ID0gc211X2Ntbl9zZW5kX2RlYnVnX3NtY19tc2coc211LA0KPiBERUJV
R1NNQ19NU0dfTW9kZTFSZXNldCk7DQo+ID4gICAgICAgICBpZiAoIXJldCkgew0KPiA+IC0gICAg
ICAgICAgICAgICBpZiAoYW1kZ3B1X2VtdV9tb2RlID09IDEpDQo+ID4gKyAgICAgICAgICAgICAg
IGlmIChhbWRncHVfZW11X21vZGUgPT0gMSkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
IG1zbGVlcCg1MDAwMCk7DQo+ID4gLSAgICAgICAgICAgICAgIGVsc2UNCj4gPiArICAgICAgICAg
ICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAvKiBkaXNhYmxlIG1t
aW8gYWNjZXNzIHdoaWxlIGRvaW5nIG1vZGUgMSByZXNldCovDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgc211LT5hZGV2LT5ub19od19hY2Nlc3MgPSB0cnVlOw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIC8qIGVuc3VyZSBub19od19hY2Nlc3MgaXMgZ2xvYmFsbHkgdmlzaWJsZSBi
ZWZvcmUgYW55IE1NSU8gKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBzbXBfbWIoKTsN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBtc2xlZXAoMTAwMCk7DQo+ID4gKyAgICAgICAg
ICAgICAgIH0NCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICAgICAgICAgcmV0dXJuIHJldDsNCj4g
PiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
