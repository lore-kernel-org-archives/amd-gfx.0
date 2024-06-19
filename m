Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89616C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jun 2024 03:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F78B10F22F;
	Wed, 19 Jun 2024 03:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F9aRcdj0";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E16F210F22F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jun 2024 03:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuiJY0tu9iv/5B5iSo9mVY0x63qQ/QiW/q5G+Ibv35Uuc+vfISgoBRaZs7+u2+NQVBkHZ4J8QVn8kYrsy7KnKK5Koy251mUdlktjBXprZS9ZO6jnyjzORgU6dyUHS+ESQyFOMPHzajtHW1mBOtaELOza1PihKb5QxUi/aZU+lgzxTx4QVBIlQ/n+KvZBm9SVaXVebBqGhFDkm7JPdNYGSEnF7uZ07Ft2ZUipnKNPFJeMQSdxw40mM8VO2vFIN1nzj4IKGCIqxhm+BgHgZeGC3eTmoWzKIUKQ6n3BilpdyBBCg1DFPSs9/N9XBH4dKrtX7w8mmIIsJRbmwDQ1GvOHIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=on7EdeUSP6VJ1DqBb1+MR/GH6ZjBtKTmTMAetqUAfgQ=;
 b=HIrJqFushoZoGTHJY1bMqNJsj9ItkHDoDFc/dfUVfOED4AojaOKM7mMmdsRx8+qutjHNE1WPAdOf8QUcuPo5GK38zBHr2AJ92f3TRm0upwz2Wjoma+2BJPXwJcNQrj18/sK4IASTAC7egxx8sJPRuQHhr22OHGeyIx8Ki9AxdLXvtukaN2X8cZ8broEAXldAkPr3TM2WVLmLZ0cRtvZT6vc9Zpotq+xRbUPV5puwQG7uO2XcK+paWv6AlGPpEmljHrJTl5qlwQ6J50eXN3roKiVKRYSJ64PFzmprC4WecHL32H0fpTCna3iYjKwWeJujrg1esmYdIbJQr9jrB1YG4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=on7EdeUSP6VJ1DqBb1+MR/GH6ZjBtKTmTMAetqUAfgQ=;
 b=F9aRcdj0iCDpOxWgMjEHy82mIp+g+htDioZhKHGJbTKNeK7Zfbp0iw/4OoJ/3UTOPwpeyWMmedeHTZE0Q6EnwRUJdMoxswZqjBozmZrUdmZKRcw8xhuVoVD/aB5sFh90US4w44do7zAcLkDlhfAL35Myrt+kcpdn4BeF3v4Nv9M=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 03:04:22 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%6]) with mapi id 15.20.7677.019; Wed, 19 Jun 2024
 03:04:22 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 4/5] drm/amdgpu: add completion to wait for ras reset to
 complete
Thread-Topic: [PATCH 4/5] drm/amdgpu: add completion to wait for ras reset to
 complete
Thread-Index: AQHawUmZh+cnncTiokiQg6Zfrfp0irHNTJuAgAAQDmCAAADmsIAADgKAgADnqGA=
Date: Wed, 19 Jun 2024 03:04:22 +0000
Message-ID: <CH2PR12MB42158E1880923E5D4C17F15DFCCF2@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240618063359.304293-1-YiPeng.Chai@amd.com>
 <20240618063359.304293-4-YiPeng.Chai@amd.com>
 <cb616e09-aad2-433a-a7d6-a6a322687d17@amd.com>
 <CH2PR12MB42153B70D0E1F0EC8719E371FCCE2@CH2PR12MB4215.namprd12.prod.outlook.com>
 <CH2PR12MB42153072563764BFF1BC294AFCCE2@CH2PR12MB4215.namprd12.prod.outlook.com>
 <6edd52f4-6f5e-470d-863b-a4df04724065@amd.com>
In-Reply-To: <6edd52f4-6f5e-470d-863b-a4df04724065@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4569a326-3cda-416f-9f94-9855969bcce3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-19T01:49:19Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|CY5PR12MB6346:EE_
x-ms-office365-filtering-correlation-id: 2e3464ba-accd-4141-d9a9-08dc900c8516
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?czFOYkNkYkV4SWRIcG9EcGdNa0lQK1k2VmNCMlB0TjY0bGdMMlRUR1E1NWhr?=
 =?utf-8?B?OCthZ0F4VDB4bmhJZzQ4M3ZkRDRPWTROMnFuS1RxZGRTY3NVdElxMy9Tak5C?=
 =?utf-8?B?Yk96WUxXV3dHbW1DNkFwWHVkSXRhZ2tCRTlyV2JpQmRVYkgyUjFYQjVRSlEr?=
 =?utf-8?B?SGJTb2czN2diNTZ6ZXRYTVE3Sk0vaUFJTVNBdnRUUURtd1B0czBGVTRxK25y?=
 =?utf-8?B?NWFOYUE2SktINXN1VzNnaFdvNWM4T2xPTXdTMit4YVFqUXcxd21Denp5aHpD?=
 =?utf-8?B?QWpwVzJCWjZLTlprdDJBaThsTHYrdG5ibHQvd1BtcWpsUG9jNy8wN2tPeS9J?=
 =?utf-8?B?M0dWeEJrMmtIS2VHakVXYm9pTUZ1VGtWanQwTndtSEVoUVdlUXdBVU1FMTFk?=
 =?utf-8?B?akYraDhaZFBRNitiNjRTcjFnVHE4UG55WUcrTVZmZWNuZmNKVUJCd1NUanFI?=
 =?utf-8?B?bkthZ1RUNkNGMjY2R2F2V3JqWWx0WTJCcHRKZlJtSVA3MlFpUFNlYVFGT2Vq?=
 =?utf-8?B?a0VSK0NCRDAxVE9wbHp5cVV0bUNYTGVRMndaNk10OUhiN0dUWGhoWTVVSVFs?=
 =?utf-8?B?K28rdXNZc1BOWksxNk9rQnlocVBRbHdJcFBVb3NzZXN1UGdpd3JxT2V4SGpi?=
 =?utf-8?B?Nzg3a1NiSXlaNTZjbnF5R1dwZ1l3M0ZnSkIrMDdINmVXU3FUc2FwNzhmR3Bx?=
 =?utf-8?B?N00xbEFMYWRNSnhiOEp2a1FwMVF3Qno2SjN5U0I4WGo0Tlc1N2cvdXpLTi94?=
 =?utf-8?B?ckcyM0hTUVh2SnFIZEpFbGxwYndKM2lDTUV1S2cwQkc1STQzcVdoa0FMNjFB?=
 =?utf-8?B?V1ZHZDgxdTdKNGNuWW1pbDBYeTFCL2RYK1c0U3Zhb3dlbXJsYnFmVTVvditj?=
 =?utf-8?B?YjBSSjY3NFV2MW9VL1k2WlJGTWlydXQyeGNwRmE0cEV4OXd5TVhLMXVwL2s1?=
 =?utf-8?B?OWhaRTFTbXJKOXp0aHRqbzlxWEMxc3BxelFteHhQZXZXbnVxOTN2blhoNU9E?=
 =?utf-8?B?YUNuYWNFUVh1Y0czeUg3VUFxOFRyNHo1dm92NG9aaFYyQXpPQm9FbXdKcGhn?=
 =?utf-8?B?NkNHdkltNkZ0RU1Wd1pnM3ppaVpKL0tjV3NwOWptcXdjZUMzSXpZaVNCOFds?=
 =?utf-8?B?RHFjV3ZzdzhUM3lwN2pZdGJyQmRXSFZoak5pRkpWc3dSZ1ZlTlFsVVZSZW9C?=
 =?utf-8?B?Mno0RnZhVlFNTmpZcnVoTXdaWnliSVZiRElpY1pYb3NSSklUc0ZKUXYyMjNv?=
 =?utf-8?B?Y0NYaUtaaGJWOG9PdWFvQVR6bURHUFNaVFlGM2lRY1VTSndkQnEwcGFDSGgw?=
 =?utf-8?B?K1p0Ri9rUlFFazk0bW83czhiUGRQVk5obnR0aE1jdDEyOEgxT2ZOdFVjYURO?=
 =?utf-8?B?bFovSkphSHJCNGNkdFArQ0ViUmlXR21qNmtidkFtZk5adVoyZjBKdVl3cFdG?=
 =?utf-8?B?ZEdTNXMvQWxvYWd0ajc0NThzNUVTWE5BcGpUdklyYTBVazJjMHVZMDRicUFT?=
 =?utf-8?B?SXlDakgwOC9mSkhMUjNEWWJ4WGhoaEg2RWQ2cm11OEJXdUo4U3lVNG9GVFFP?=
 =?utf-8?B?WW9tcTdiajlBbnFuZWtQU0Zkc25vbTRGakVqcmZ0cmFiZCtGdm4rUFNzeE5i?=
 =?utf-8?B?bEFRTDAwajhXVFpUR0tiMHlPZ3RhY2laeEFndGkxZ2NsVFZ1dEdtazNyc2hi?=
 =?utf-8?B?czRQa1VTbzhpUC8yVFQ0MlBhbEYzcm5YK0Vuamc5MXJyYmJpYVBNU2doL25s?=
 =?utf-8?B?a0xnWkRvblVCczBjc3RwMHBCcUtFRzYwdlFuT1Q5UmFHZDBGMDJCK2N0aktF?=
 =?utf-8?Q?1F1Msr69/3+TDAf7hAVSGRpoJg1W5zUthCDbU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHJWbEVJRms1aXAxWlJYczdWellpWm9Cc3hlSzh4T1E2ZkY1aXpIZ3gzMXJI?=
 =?utf-8?B?Q1JIVEYzOWp0QktPTG1pWmcycUJBQnZVYTA5SForL0YweUJIRWVPNlNac2pr?=
 =?utf-8?B?TDEyQVp2VGhNRllxQ3JidTdDTkoxbUtEVVFvNkJyWlR5SDBkQzQ5ZUkzRzJx?=
 =?utf-8?B?eUZiZUNVKzhKSysvMmlXWUZ3dXorWmtyUEJJZjlpNU1EUmN2cW9NSktNYkp6?=
 =?utf-8?B?aHNWbFRxL2hicVM3Qk1EZG9aWHp3RDdCckZPdWo2eTZJMEVUQ3hSS1k2MFQy?=
 =?utf-8?B?Q2piNGZrS3huTmMyTkROQXNrK3dwSDJSdW9VQVFsLzE0U3FRMjBrTjhRd2pT?=
 =?utf-8?B?VVhOaHdBVEluNUFieEJpbWNzS3M2Yk9ZOXQybGVXM2xvM3NnRHZuOFF2Tm1S?=
 =?utf-8?B?V2VITmw2ak80eDNwQU55NUt6U0hzdzdvR0hVOG1hQVkxV1RDWGlwSU1OWHdL?=
 =?utf-8?B?S2EwYUtncTNwWUhVZThNNjMreUFBeXJNNlE0Nk1oejlQTytFU1Q4MUJUM0xO?=
 =?utf-8?B?eFBLaHFPM1ZxM2Y0aXArbVROZ3NoR01wQVFnQ3JKeXRHeHZIQ1ZMY01JM0NL?=
 =?utf-8?B?ZU92eDVoSnNScnNjd3NZMTIzeGUwWGN5cjY5NnM5NHNOZFowSzV0NVc2TEZv?=
 =?utf-8?B?WXVHSHlaZXI2b0pEMUlqTVdPaHl6bEpMcnduSUlnV3RyOWQ3ZjFDK2RKaDBa?=
 =?utf-8?B?MDJOcUoxV1daRVd5dHhOZ1B5dzJDNWRGaXRnTDVHUG9PZW9BSjNTbGRtRVR3?=
 =?utf-8?B?aEtzT0VNWTNiZVVTL3JGbTRjNzRXNDYzRlJMSDlzL0dGcnAxT1I0N1NKaElt?=
 =?utf-8?B?eDNacjVBNXBOcjRMdHhNTEx5dXJEVmtzMUxTckpCeDF6RXhMcTVLNTYvOEZ0?=
 =?utf-8?B?S20yLzlvdDA3Y2ZOQVppbEdTTnU0NlVKTVRGOVRMTVErcVkvMXZ1aGxyMzc4?=
 =?utf-8?B?ZHBTVVplcHlNL0hnaEN1bVpGSnNEYjZ6U1gzcGwxeEZUK2dibXNPZktIV2hh?=
 =?utf-8?B?a0NnVzFmTkRNUWxrVXRJMXh6alZCSU5DZm4yMVNJVFJUckk2ZUwvSnE0YVA0?=
 =?utf-8?B?MEQ4M05FK2VxbFZySTI2Um9XOVM3RllqUVo4THc3RmFQenlaTUNMQW9reHZh?=
 =?utf-8?B?OFlQYTJGSUR3b29oZE8vTHNHQjY4WGpCMnNUMUk2ZGh2eUtQM2NTbjNIb0FZ?=
 =?utf-8?B?eVBTbWcrVGRYYzlkVHZUZVdnb0xCSGlDbFpRMEFDVTdxWUlJbFo5UGNDdUtK?=
 =?utf-8?B?REtOc3Mrd3o0bTBnaW0xdDBTTWVEZTRkeStIUXQ1cm1IVEtaYWtGZ0FJNnZD?=
 =?utf-8?B?RWhwV3ZxL2x1VCtKVzNOUGFybWlYb1Fad3hRbWJnUHVZMjFqakxlL2xPdDl2?=
 =?utf-8?B?UGNOeEoyeGsxL2laeU1nVk1USjdzTFlPUDRNWnI5eFBjUytJOG5aRmdsUXBn?=
 =?utf-8?B?dktScEk0V0pDN0RadStqNVpWalY1ZmFSeCt1enVYcldvbzNhVWZpdUVSL1lZ?=
 =?utf-8?B?WFRXVkthcTRSelk3US9hNWdJN0h2QnlDT0pNVnlXQ3BGT3NTemVxbzlXM242?=
 =?utf-8?B?UG1JbThENW1GYk1Qc2RNcXV3aGVsano3c0NkL3U3ME1oRlQvalg4TmpLRCtU?=
 =?utf-8?B?WVhYMGVXdDF2RDMyTzNnYVRaSitHNWFYMDZoMGdpV2Z0eHJSd04zdzQxQnVG?=
 =?utf-8?B?Z2JMSThWdk5RMEpNbHNwTC9PWXhpcXhkVEFmY1pidUFYUFo3NGQ0QldPRU5Q?=
 =?utf-8?B?Rkc4OUtydGV2cnVvWTdrSzdqd1pxdXQ1eDhEeFo4Nm1lK3ROUFFQVnVSUFJR?=
 =?utf-8?B?RHB3VW5SRVJFSXMxVllucWFWek1IZEVVRDMzTGwwS0JlNWNkWGwzUndKU1hO?=
 =?utf-8?B?QW5mUDRDN0lRc3ZKNjE0Wnk1UzYxckR4N1NaYi9XY1VMdWNMZWJwTzZEblZv?=
 =?utf-8?B?ZkxqdnVWZWtieENxelJSMWU2eXpkVklZNHorYmxLMGxvbnQ3aUtDODVRUnk0?=
 =?utf-8?B?cDlpVzVmK2JuUk9BMUFHeVRKVVZrKy9NTzNxSG9HdkFSYWs3ck1nbXY5VjZ6?=
 =?utf-8?B?Slo5UTJKWWVDYnpYcjJCMkp4djI4aGRIcENzVjcxRWhHVjEvVC9RdVk0L0pU?=
 =?utf-8?Q?4coc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3464ba-accd-4141-d9a9-08dc900c8516
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 03:04:22.6565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /mZ5oTVNZqj7xORc2nhenkN+48EL/sdhtCeG7wztXjVBTPSS+5A0iAbw30RTPH+NcsC6droQ/XRVg+P5Jl+RaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
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
Cg0KLS0tLS0tLS0tLS0tLS0tLS0NCkJlc3QgUmVnYXJkcywNClRob21hcw0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4N
ClNlbnQ6IFR1ZXNkYXksIEp1bmUgMTgsIDIwMjQgODowMCBQTQ0KVG86IENoYWksIFRob21hcyA8
WWlQZW5nLkNoYWlAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpDYzog
WmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT47IFpob3UxLCBUYW8gPFRhby5a
aG91MUBhbWQuY29tPjsgTGksIENhbmRpY2UgPENhbmRpY2UuTGlAYW1kLmNvbT47IFdhbmcsIFlh
bmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPjsgWWFuZywgU3RhbmxleSA8U3Rhbmxl
eS5ZYW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDQvNV0gZHJtL2FtZGdwdTogYWRk
IGNvbXBsZXRpb24gdG8gd2FpdCBmb3IgcmFzIHJlc2V0IHRvIGNvbXBsZXRlDQoNCg0KDQpPbiA2
LzE4LzIwMjQgNDo1MSBQTSwgQ2hhaSwgVGhvbWFzIHdyb3RlOg0KPiBbQU1EIE9mZmljaWFsIFVz
ZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPg0KPiAtLS0tLS0tLS0t
LS0tLS0tLQ0KPiBCZXN0IFJlZ2FyZHMsDQo+IFRob21hcw0KPg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGFpLCBUaG9tYXMNCj4gU2VudDogVHVlc2RheSwgSnVuZSAx
OCwgMjAyNCA3OjA5IFBNDQo+IFRvOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsg
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+OyBaaG91MSwgVGFvDQo+IDxUYW8uWmhvdTFAYW1kLmNvbT47IExp
LCBDYW5kaWNlIDxDYW5kaWNlLkxpQGFtZC5jb20+OyBXYW5nLA0KPiBZYW5nKEtldmluKSA8S2V2
aW5ZYW5nLldhbmdAYW1kLmNvbT47IFlhbmcsIFN0YW5sZXkNCj4gPFN0YW5sZXkuWWFuZ0BhbWQu
Y29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDQvNV0gZHJtL2FtZGdwdTogYWRkIGNvbXBsZXRp
b24gdG8gd2FpdCBmb3IgcmFzDQo+IHJlc2V0IHRvIGNvbXBsZXRlDQo+DQo+DQo+DQo+DQo+IC0t
LS0tLS0tLS0tLS0tLS0tDQo+IEJlc3QgUmVnYXJkcywNCj4gVGhvbWFzDQo+DQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5j
b20+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMTgsIDIwMjQgNjowOSBQTQ0KPiBUbzogQ2hhaSwg
VGhvbWFzIDxZaVBlbmcuQ2hhaUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4gQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBaaG91MSwg
VGFvDQo+IDxUYW8uWmhvdTFAYW1kLmNvbT47IExpLCBDYW5kaWNlIDxDYW5kaWNlLkxpQGFtZC5j
b20+OyBXYW5nLA0KPiBZYW5nKEtldmluKSA8S2V2aW5ZYW5nLldhbmdAYW1kLmNvbT47IFlhbmcs
IFN0YW5sZXkNCj4gPFN0YW5sZXkuWWFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDQvNV0gZHJtL2FtZGdwdTogYWRkIGNvbXBsZXRpb24gdG8gd2FpdCBmb3IgcmFzDQo+IHJlc2V0
IHRvIGNvbXBsZXRlDQo+DQo+DQo+DQo+IE9uIDYvMTgvMjAyNCAxMjowMyBQTSwgWWlQZW5nIENo
YWkgd3JvdGU6DQo+PiBBZGQgY29tcGxldGlvbiB0byB3YWl0IGZvciByYXMgcmVzZXQgdG8gY29t
cGxldGUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWlQZW5nIENoYWkgPFlpUGVuZy5DaGFpQGFt
ZC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFz
LmMgfCAxMSArKysrKysrKysrKw0KPj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Jhcy5oIHwgIDEgKw0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMN
Cj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+PiBpbmRleCA4
OTg4ODk2MDA3NzEuLjdmOGU2Y2EwNzk1NyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Jhcy5jDQo+PiBAQCAtMTI0LDYgKzEyNCw4IEBAIGNvbnN0IGNoYXIgKmdl
dF9yYXNfYmxvY2tfc3RyKHN0cnVjdA0KPj4gcmFzX2NvbW1vbl9pZg0KPj4gKnJhc19ibG9jaykN
Cj4+DQo+PiAgI2RlZmluZSBBTURHUFVfUkFTX1JFVElSRV9QQUdFX0lOVEVSVkFMIDEwMCAgLy9t
cw0KPj4NCj4+ICsjZGVmaW5lIE1BWF9SQVNfUkVDT1ZFUllfQ09NUExFVElPTl9USU1FICAxMjAw
MDAgLy9tcw0KPj4gKw0KPj4gIGVudW0gYW1kZ3B1X3Jhc19yZXRpcmVfcGFnZV9yZXNlcnZhdGlv
biB7DQo+PiAgICAgICBBTURHUFVfUkFTX1JFVElSRV9QQUdFX1JFU0VSVkVELA0KPj4gICAgICAg
QU1ER1BVX1JBU19SRVRJUkVfUEFHRV9QRU5ESU5HLCBAQCAtMjUxOCw2ICsyNTIwLDggQEAgc3Rh
dGljDQo+PiB2b2lkIGFtZGdwdV9yYXNfZG9fcmVjb3Zlcnkoc3RydWN0IHdvcmtfc3RydWN0ICp3
b3JrKQ0KPj4gICAgICAgICAgICAgICBhdG9taWNfc2V0KCZoaXZlLT5yYXNfcmVjb3ZlcnksIDAp
Ow0KPj4gICAgICAgICAgICAgICBhbWRncHVfcHV0X3hnbWlfaGl2ZShoaXZlKTsNCj4+ICAgICAg
IH0NCj4+ICsNCj4+ICsgICAgIGNvbXBsZXRlX2FsbCgmcmFzLT5yYXNfcmVjb3ZlcnlfY29tcGxl
dGlvbik7DQo+PiAgfQ0KPj4NCj4+ICAvKiBhbGxvYy9yZWFsbG9jIGJwcyBhcnJheSAqLw0KPj4g
QEAgLTI5MTEsMTAgKzI5MTUsMTYgQEAgc3RhdGljIGludA0KPj4gYW1kZ3B1X3Jhc19wb2lzb25f
Y29uc3VtcHRpb25faGFuZGxlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4+DQo+PiAg
ICAgICAgICAgICAgIGZsdXNoX2RlbGF5ZWRfd29yaygmY29uLT5wYWdlX3JldGlyZW1lbnRfZHdv
cmspOw0KPj4NCj4+ICsgICAgICAgICAgICAgcmVpbml0X2NvbXBsZXRpb24oJmNvbi0+cmFzX3Jl
Y292ZXJ5X2NvbXBsZXRpb24pOw0KPj4gKw0KPj4gICAgICAgICAgICAgICBjb24tPmdwdV9yZXNl
dF9mbGFncyB8PSByZXNldDsNCj4+ICAgICAgICAgICAgICAgYW1kZ3B1X3Jhc19yZXNldF9ncHUo
YWRldik7DQo+Pg0KPj4gICAgICAgICAgICAgICAqZ3B1X3Jlc2V0ID0gcmVzZXQ7DQo+PiArICAg
ICAgICAgICAgIGlmICghd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZjb24tPnJhc19yZWNv
dmVyeV9jb21wbGV0aW9uLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNlY3Nf
dG9famlmZmllcyhNQVhfUkFTX1JFQ09WRVJZX0NPTVBMRVRJT05fVElNRSkpKQ0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiV2FpdGluZyBmb3IgR1BVIHRvIGNv
bXBsZXRlIHJhcyByZXNldCB0aW1lb3V0ISByZXNldDoweCV4XG4iLA0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmVzZXQpOw0KPg0KPj4gSWYgYSBtb2RlLTEgcmVzZXQgZ2V0cyB0
byBleGVjdXRlIGZpcnN0IGR1ZSB0byBqb2IgdGltZW91dC9od3MgZGV0ZWN0IGNhc2VzIGluIHBv
aXNvbiB0aW1lb3V0LCB0aGVuIHRoZSByYXMgaGFuZGxlciB3aWxsIG5ldmVyIGdldCBleGVjdXRl
ZC4NCj4+IFdoeSB0aGlzIHdhaXQgaXMgcmVxdWlyZWQ/DQo+DQo+PiBUaGFua3MsDQo+PiBMaWpv
DQo+DQo+IFtUaG9tYXNdICAiW1BBVENIIDUvNV0gZHJtL2FtZGdwdTogYWRkIGdwdSByZXNldCBj
aGVjayBhbmQgZXhjZXB0aW9uIGhhbmRsaW5nIiBhZGQgdGhlIGNoZWNrIGJlZm9yZSByYXMgZ3B1
IHJlc2V0Lg0KPiAgICAgICAgICAgICAgICAgUG9pc29uIHJhcyByZXNldCBpcyBkaWZmZXJlbnQg
ZnJvbSByZXNldCB0cmlnZ2VyZWQgYnkgb3RoZXIgZmF0YWwgZXJyb3JzLCBhbmQgYWxsIHBvaXNv
biBSQVMgcmVzZXRzIGFyZSB0cmlnZ2VyZWQgZnJvbSBoZXJlLA0KPiAgICAgICAgICAgICAgaW4g
b3JkZXIgdG8gZGlzdGluZ3Vpc2ggb3RoZXIgZ3B1IHJlc2V0cyBhbmQgZmFjaWxpdGF0ZSBzdWJz
ZXF1ZW50ICBjb2RlIHByb2Nlc3NpbmcsIHNvIGFkZCB3YWl0IGZvciBncHUgcmFzIHJlc2V0IGhl
cmUuDQo+DQoNCj4gUmVzZXQgbWVjaGFuaXNtIHJlc2V0cyB0aGUgR1BVIHN0YXRlIC0gd2hldGhl
ciBpdCdzIHRyaWdnZXJlZCBkdWUgdG8gcG9pc29uIG9yIGZhdGFsIGVycm9ycy4gQXMgc29vbiBh
cyB0aGUgZGV2aWNlIGlzIHJlc2V0IHN1Y2Nlc3NmdWxseSwgR1BVIG9wZXJhdGlvbnMgY2FuIGNv
bnRpbnVlLg0KDQo+U28gd2h5IHRoZXJlIG5lZWRzIHRvIGJlIGEgc3BlY2lhbCB3YWl0IGZvciBw
b2lzb24gdHJpZ2dyZWQgcmVzZXQgYWxvbmU/DQpbVGhvbWFzXSBEaWZmZXJlbnQgYXBwbGljYXRp
b25zIG1heSByYW5kb21seSB0cmlnZ2VyIHBvaXNvbiBlcnJvcnMgYmVmb3JlIGdwdSByZXNldC4N
CiAgICAgICAgICAgICAgICAgU2luY2UgcG9pc29uIGdwdSByZXNldCBpcyB0cmlnZ2VyZWQgYXN5
bmNocm9ub3VzbHksIG5ldyBwb2lzb24gY29uc3VtcHRpb24gaW50ZXJydXB0cyBtYXkgb2NjdXIg
aW4gdGhlIHBlcmlvZCBhZnRlciBncHUgcmVzZXQgcmVxdWVzdCBpcyBzZW50IGFuZCBiZWZvcmUg
dGhlIEdQVSByZXNldCBpcyBhY3R1YWxseSBwZXJmb3JtZWQuLg0KICAgICAgICAgICAgICAgICAg
SW4gb3JkZXIgdG8gYXZvaWQgcGVyZm9ybWluZyBhIHBvaXNvbiBncHUgcmVzZXQgYWdhaW4gYWZ0
ZXIgY29tcGxldGluZyB0aGUgY3VycmVudCBwb2lzb24gZ3B1IHJlc2V0LCAgSXQgbmVlZCB0byBz
dGF5IGhlcmUgdG8gd2FpdCBmb3IgZ3B1IHRvIGNvbXBsZXRlIHJlc2V0IGFuZCB0aGVuIGNsZWFy
IHRoZSBjYWNoZWQgcG9pc29uIGNvbnN1bXB0aW9uIG1lc3NhZ2VzLg0KDQo+V2h5IG5vdCB3YWl0
IG9uIHRoZSBSQVMgcmVjb3Zlcnkgd29yayBvYmplY3QgIHJhdGhlciB0aGFuIGFub3RoZXIgY29t
cGxldGlvbiBub3RpZmljYXRpb24/DQpbVGhvbWFzXSBZZXMsICJ3YWl0IG9uIFJBUyByZWNvdmVy
eSB3b3JrIG9iamVjdCIgaXMgYSBnb29kIGlkZWEsICBJIHdpbGwgZG8gaXQuDQoNCg0KVGhhbmtz
LA0KTGlqbw0KDQo+PiAgICAgICB9DQo+Pg0KPj4gICAgICAgcmV0dXJuIDA7DQo+PiBAQCAtMzA0
MSw2ICszMDUxLDcgQEAgaW50IGFtZGdwdV9yYXNfcmVjb3ZlcnlfaW5pdChzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikNCj4+ICAgICAgICAgICAgICAgfQ0KPj4gICAgICAgfQ0KPj4NCj4+ICsg
ICAgIGluaXRfY29tcGxldGlvbigmY29uLT5yYXNfcmVjb3ZlcnlfY29tcGxldGlvbik7DQo+PiAg
ICAgICBtdXRleF9pbml0KCZjb24tPnBhZ2VfcnN2X2xvY2spOw0KPj4gICAgICAgSU5JVF9LRklG
Tyhjb24tPnBvaXNvbl9maWZvKTsNCj4+ICAgICAgIG11dGV4X2luaXQoJmNvbi0+cGFnZV9yZXRp
cmVtZW50X2xvY2spOw0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yYXMuaA0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFz
LmgNCj4+IGluZGV4IDkxZGFmNDhiZTAzYS4uYjQ3ZjAzZWRhYzg3IDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oDQo+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmgNCj4+IEBAIC01MzcsNiArNTM3LDcgQEAg
c3RydWN0IGFtZGdwdV9yYXMgew0KPj4gICAgICAgREVDTEFSRV9LRklGTyhwb2lzb25fZmlmbywg
c3RydWN0IHJhc19wb2lzb25fbXNnLCAxMjgpOw0KPj4gICAgICAgc3RydWN0IHJhc19lY2NfbG9n
X2luZm8gIHVtY19lY2NfbG9nOw0KPj4gICAgICAgc3RydWN0IGRlbGF5ZWRfd29yayBwYWdlX3Jl
dGlyZW1lbnRfZHdvcms7DQo+PiArICAgICBzdHJ1Y3QgY29tcGxldGlvbiByYXNfcmVjb3Zlcnlf
Y29tcGxldGlvbjsNCj4+DQo+PiAgICAgICAvKiBGYXRhbCBlcnJvciBkZXRlY3RlZCBmbGFnICov
DQo+PiAgICAgICBhdG9taWNfdCBmZWQ7DQo=
