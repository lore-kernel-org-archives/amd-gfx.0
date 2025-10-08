Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED882CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 17:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A40D10E87A;
	Wed,  8 Oct 2025 17:27:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dj06Idp4";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A40F810E87A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 17:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxijaoQYMkRNo426HUlb7iPU0swQKyKhhDJaVjlVRycK9PjBrHgeRvXHPPnu5aVGUisQAUtlKcKyzTydi19oXiqVKZbcophZ5gEB2KVF02vAbgtxA09T7lbWYALItdUbr8iKbX5q6OwRj7Qhp7fWNphQ0LX9AggAvEJI+wqH9ENeak8gYvUHMc8Rg9CpV1F9BNJJCwoOoXsEQODBMY7vOuXfPRMQ38YT1W8gu9VnnhtBBzMQHvXYanh22A6iNQXWyWP6Wx5gWZ60+uiWklEDEoKtK6iVS2qTfU+HkhMVsu8s52Qr1pLXYRGc5/5mxLxPFJpJulRz0VA7uroF+ild4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCl8fpo2RDS/RGZSomoASqhzP3MjbscbHQ35OpRnNAA=;
 b=UCBoXiz8BY/lJ1Wc5TcmkB/TwXIx8/5t0zNbsuAmhsa8mC3sNbLDqFG//JVe0HJgyHGfKhekDeR+ardI7jr1mLUcAQzTE1/KZIVNhyeYwPt+nNbDX267jTbgqK+Ou/H/O8qsiG32itkbYbpSjeJIwhZG4IbNiqlQpj68sNbu3aMkMghQiPIK7kWNlxie78xMU57DtXtRXrRDy7011vFyqDYNCU5trbZlFLiKwLjGtKR4Zr7a8KS+rGW5cPerjvuZoMW2qnedp2ezbIp2LTRbniJ+EEpdhlT+ZGTku+gPeHyiy0+UcZETvQ381brte1VFftbayR21dcpSTgkGGsYlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCl8fpo2RDS/RGZSomoASqhzP3MjbscbHQ35OpRnNAA=;
 b=Dj06Idp4cbEdjZxUy/AXEKN1h4a015qBK/+WQbLH2Aec86mf66s09daxq6VEtsr6mWI4Ov7Pu/U2iyZyn1ZZFW61KRm0doV3hYmm0W6jR+KgiyBoflJk7HNNodzYJO1ZJGMGF3AkhNJr0khWsPbWzd/2NJnmQkSIsRrNP+bDhiI=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by DS7PR12MB9552.namprd12.prod.outlook.com (2603:10b6:8:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 17:27:44 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8%4]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 17:27:44 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Shaoyun" <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status check
Thread-Topic: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status check
Thread-Index: AQHcOHLJRL0QRFecdkyxa3OjtALBLLS4fGsAgAACRdA=
Date: Wed, 8 Oct 2025 17:27:44 +0000
Message-ID: <CY8PR12MB74354BE47029963B8FEDCD4385E1A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20251008164408.850834-1-jonathan.kim@amd.com>
 <CADnq5_M_Rk9KX_5Vw+3pxPfrReKqhtF5rn+1P2LidFSJ5y7Wzw@mail.gmail.com>
In-Reply-To: <CADnq5_M_Rk9KX_5Vw+3pxPfrReKqhtF5rn+1P2LidFSJ5y7Wzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-08T17:27:19.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|DS7PR12MB9552:EE_
x-ms-office365-filtering-correlation-id: 119cf9bb-c03e-4cb2-1709-08de068ffe1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?R3VsdHJiK0NpRzZIcS9xcmxTdExmMWRBSW5lVWJNRVJOc3pkUkE0SEpxaVI5?=
 =?utf-8?B?VnhGbEs2bnRCdXFadUY1Z1VvbDViUVVqRUNCU1E1dWRkRllsWnNiS3pORlhv?=
 =?utf-8?B?YkdqeVNzd3pzc1VxbnpRSkFJeHRJTS9yUm43ZzkrdmdlKzJPZE9scG1RQ3Z6?=
 =?utf-8?B?OG5pU0pLWnpLOFcvUlFhYmEzTzNmdlNkL21ZSkx2QzhhMU12Zmd3bUltZ0o4?=
 =?utf-8?B?dmpxSUNzYW1oSUx5K2NWU2cxSjN1K3lTeWU2MjFRNEYzQkE3dEVBaHJjcHRj?=
 =?utf-8?B?VVZaREt3M2tid0pQV0dPNU9CZGQ3YkJPamNvb0EwMmJIUnY4N3FXSU5Sc1p5?=
 =?utf-8?B?c2hWSUFQaU9VWlBBK1l2Y2hkb3B5OGdHVUZIOEVWRVlwbGVYV1h4cS9TWkhI?=
 =?utf-8?B?cFR0L3JhanFDeDJDN3BwZ3NMb0NvYjh3ZE13RExLbUZEUTh5R0xjWUcyNitv?=
 =?utf-8?B?Uzh6UWluU2U0cWVqZE5vS2tITXR3UTYwMHEwbnZ0bTY4N0x5RkZGanNjWG5H?=
 =?utf-8?B?MFA4T2RmcDFDSnR1bTY0T0s1bHhEckVuRndDd1I3RENKV3l4NGI5WTdNQmJj?=
 =?utf-8?B?RGVoTDVxVWE4OFZhaldJdnFhakVJaUkrOVRBVjRUdHBCUW1JWmMrM290bjZn?=
 =?utf-8?B?Q1lwbWZTMjBCaENVRnhpakxUVk55WXhXMEVlTlpDbm1CVVdSbTlpYmdId1RN?=
 =?utf-8?B?eUR6TkVOL095aW9ZNThKd3A5NHd6NkIxZjA3b2Vlc3VuWmFRamRTbmJSWDJp?=
 =?utf-8?B?R3YvY1lGTGU0aGZuNXNOS1dkUHErcUc3bzgwZk9WSlZ6MElZbytNdi9BRnNP?=
 =?utf-8?B?THhCWlhvK1dJVERGQzBIanBFb1RQanM3aXN0aFBua2daVXZJRnp0U2ErSUJQ?=
 =?utf-8?B?N3pQOUNsckVBdzc2UGRxV0p3YjBjUnEvMTNlTWdnZ3A2NXFrdGQxYXVqNS84?=
 =?utf-8?B?NnRHRDlYS0ZQd0NCTXdKK3pZUng1TFpQUzN2T2J2dGlhUzE3SmpaRmtOMUZx?=
 =?utf-8?B?SzU2ZEFBQzd2L1VRTW5qZlBKS1ZiOWZ0TGUxYTY1djdCZzZSTDZqeHI0Myt6?=
 =?utf-8?B?clJETkNWY0hoM3kvZFpTS0grd3pyd3k0SXRvZ25EMVBDcE9mL3NhWWppMEUy?=
 =?utf-8?B?d2RkdXJpVmplaGRjc1hhVVRUZmpVN0F6V2paWnRaQWltdnh0TmNLTXhjZ2Rp?=
 =?utf-8?B?SUg1TDEvOXVVOU50TXZ0cklweUJnMXY2Ukl3TllnMEFyd2FTNDF3U0VtVmNu?=
 =?utf-8?B?NURoYVBidHhoZnUzelk4UCtORjNXMGduVFBiMGcvMEZqUm5RNmtERjliQ2xl?=
 =?utf-8?B?UEFaY1JqOEtBbDBFbk9MYWRCREh1U09hKzhnejJMcTNKc0JRQmlpdHh5Rmtu?=
 =?utf-8?B?eU11RkY0blo5dDc3OTNGdldOMEVROXZwdEZxaGxjdUxpaFpLSVBmcWVMeG44?=
 =?utf-8?B?bjkwbVVpL0ttRzV2cGIySW42UzE5TkRhYkpPWEkzWUQxNldrMnNoczZGRGFF?=
 =?utf-8?B?UElZMHlDMStJNWJHU204d1pVeXA5VkMwYXlSUjVWUGdYeWVVUGFqbGpYd3B1?=
 =?utf-8?B?cmhRUEl6RUJuWk1xREtiV09QUm95Q1UvWU96N1ZYaytwV2QxVDdWYkdCRmRW?=
 =?utf-8?B?NGN6VFU5clB6QThtczlXNUNOMGVBTXZML3QyYVBsZC9nR1N3NmRjQk1Ed0Jj?=
 =?utf-8?B?QkhGaGI1dWF3MzFTVUsvbGVWS1ZvcGFwY2Y1VFltSXdpOGhVa01yeFR3Z2R5?=
 =?utf-8?B?M0lKR2I1d1lhYk1rVTREbytoNVVmSDFsRG9Ub0pBVlB4ZER1NGZydE4xSEJh?=
 =?utf-8?B?aHozSGZ3eDdxU1MwTGZXT2tjd3dmbXhES3ZaMTNpTjhqVTNreUpjQlB1MHNV?=
 =?utf-8?B?STNKZDhvUDJGbmlGaldFd21EZXR6VUNoVEdldHlpUHJxdG0vUlBUcnF6S1BC?=
 =?utf-8?B?a3RBVGd4TllPd1RMSXRvNXJ0Q1hkbEc1SjJ6dFI1ck8xcWFtTmYwMWNnNEZn?=
 =?utf-8?B?WXczNDNhV0hJUWcrT25ISnNwRWpBbkUxK3A0ajJNOUFjNnM3VXA0d0s4MzBD?=
 =?utf-8?Q?1Emkx2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TCtCVnEvY1ZoWGlZaVB0SWVpeUpEbnpNbDdVbllIRnJSVEVONm81Y092STNP?=
 =?utf-8?B?Y2hJQmdudFNvcGgrcEJxcmw0MmRkTjJ3TG5pN0hlNGhBU1hrTDQrb3ZLM292?=
 =?utf-8?B?cTAxYTF6K2tBKzNkRnZTVDdQSjR0MUxyUGtZZzgzcEZkbjRPeGlhYmRRZEFB?=
 =?utf-8?B?clhnMDRLTEFEdVZvOEs3REJ2Tm9qRm12Nmt3cEVlUE56TXhwY2FHUkNxcnRj?=
 =?utf-8?B?WTFnQ3pJbnVxNkl0dlBUZEZINVRldXJtbFdrVCtyQ2NwYWUvV2htNDgzWkxF?=
 =?utf-8?B?VkhoYjI5VlhOWTlaVk9WOGFPbnozQkFZbWlwS0ZhN2pQZXVNZGlJaFdLRWNU?=
 =?utf-8?B?OTJNOG5Db0VXS3ozTFd0VnRrcktWdnNuR1Nna1Z5Q1gvVGUrRmVPQnBVNTFI?=
 =?utf-8?B?QjlnTTl2VHMzWWgrNzBVUHAxM0tjcm5wbjZGWlNVbVhKTEZDYldxdGpheTBj?=
 =?utf-8?B?bjlIZVl1KzF4RWlHbWJyODdYQlFENzdjdEpVeHhQNlR6TFNTc3hyUmJGR3J6?=
 =?utf-8?B?Vlc0b1AzT2tmdVhqNVd4L3V3TExZQ2hLTmgra1ZDS3EzR01McC9NWmZOa2pQ?=
 =?utf-8?B?U3JnWWRBMUVuMFoxdnhQamw4cjB0bmhtRXdDdzB0bHNLcUVsaC9hOEFwODJs?=
 =?utf-8?B?cHhuQ0NGWlRzQTBTNVVFK21MbWgrODJmcVVYcDYxOEUvWVhlc2UvcGsxZDl1?=
 =?utf-8?B?UE44cEFvUitKS28xNk5ybEl6ZlFVcERlY2R3M293Yy93aU10S05nRkRyQ2JP?=
 =?utf-8?B?YUo0M01LL0Vwd2N0b3ZwRXNxL2M4TVovUGxUczVXdVpvRUpDNjZscEdLcytT?=
 =?utf-8?B?Wi92TmZmQ0ora3Z1ZUhITE1OeXRMRldMNERDYnpoVE5MM0VnYWF4TWZQeHlk?=
 =?utf-8?B?TCt1WXRveGFuL21VNTZ1Q002WVY5SjZnVlRyZlh6OVBmMWxvZ2RLdElIMTFj?=
 =?utf-8?B?Y3NjY3RBTVh6L3pKSG15WmxYb3pSdW9KSHpjV1VCZEhScTFVVjBPNEpXMEZR?=
 =?utf-8?B?RFFqbGtlUUVUSnd2Sk0yZU02SFEwNklOS2JVbERCQmxjUEx0VnBmUXd4Wmkx?=
 =?utf-8?B?Q1V1ZzI4ZDlCaUVXTHJZYS9Cc3VqRjBhU2tRMTdkcDFlek9RUllmWitVQnFv?=
 =?utf-8?B?NnVIejloMjQ5UGRWVnhKTjhOd0dWY1dyS1N6TmwzTDM3VUhqcmlRRGt1YmxE?=
 =?utf-8?B?dVZvRDFKRTdUUUlZUFBpaklpWHhHVzIybjdiUmI2SkZYMjhyTi9KbUVFS0VN?=
 =?utf-8?B?TlBOVmJzRE9LK1JMVWlta1dqVVNrcUJLbytjRDN0cVBrZTNrNytiUUdCSDFO?=
 =?utf-8?B?STRXc0JjOHJJOWRGdjJaOEFrSHc3OXIxUzFrczdQY1BoWlRFS1NVTEJHdDNT?=
 =?utf-8?B?eWgxTjZnVkVCSm51YmdCZ2Ria1dBOVRtRW8xYmNiRnRlTk12VmZad0Y0V2kz?=
 =?utf-8?B?TjdScFpWYUIzaGdEdERXOVkyRkF5YzA2dEVXeDBPMjVwVWZRSmsxNCtvOFVZ?=
 =?utf-8?B?cm9vUVVEaE95SmxXK3orWThFUEMzTEZNSkFUdU1OeWRvRDJJV1FZYU5IQkd1?=
 =?utf-8?B?dldTNEhyZEI1WFpPRTR4SHFhcDlwQUFTUVhvbG1sREZrMW5yWXpSemlOcko5?=
 =?utf-8?B?NDl6LzhrV0FuY2Y4ekttRnVmRGJKZHBEVnpoOXNURDZaeUNYQWhCL0NkdmxO?=
 =?utf-8?B?aGptN2U1YTFOcytRMmEvQWJPamNFU24xaWVsaVZnaHVaN0pHMXNQcExPeDZZ?=
 =?utf-8?B?YTBRVURBR2E1UmFGcDBNMUkxcE9zNmkrYVZZWXhqbHJaaVUzUzN0M3Z4WjRp?=
 =?utf-8?B?VGIzR3lXT2dIeFhid3VNdnN6RVNITlBUVytvWUNmOUNoY0NTakQwNExSWHEz?=
 =?utf-8?B?dE9lVWVYVTFyNGErNVhoaC9QWFkzbGs5WU8ybGhPN1hMTWxCa3F1Tk92Slpt?=
 =?utf-8?B?N3Ztdy9TdU1Sa2I4TUl2YXBJZFFBQWczUUR0YTVrUjF3a1VVZWhjekJTVHE1?=
 =?utf-8?B?Smk4aVdqWGJCdFAwSHo1RjAyb1pXbFY5WWdNN3VNS3prSFp2dEpSZXZ4NnR1?=
 =?utf-8?B?ZXdIb2lmWW1NbXovOXRrZTJIaTI2eTh0YkNhWTFrOWl1QUlSQU5pWkJCc3E1?=
 =?utf-8?B?bWlMRk81c1dVNCtVTEIyWUhrVEZwcXpORTA2U2pnVkx1akpPUm1KcW5DQkNC?=
 =?utf-8?Q?zYjhItmgaNfN3LO6l1V6PfA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119cf9bb-c03e-4cb2-1709-08de068ffe1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 17:27:44.6235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQt6OCDiTIwvZkEMKOhmXYf83u3+RnJZaHwk4qnRvGAiE51ohNNbwYzHlzKLVYI7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9552
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERl
dWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVy
IDgsIDIwMjUgMToxMiBQTQ0KPiBUbzogS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5j
b20+DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTGl1LCBTaGFveXVuIDxT
aGFveXVuLkxpdUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBm
aXggZ2Z4MTIgbWVzIHBhY2tldCBzdWJtaXNzaW9uIHN0YXR1cyBjaGVjaw0KPg0KPiBPbiBXZWQs
IE9jdCA4LCAyMDI1IGF0IDEyOjUx4oCvUE0gSm9uYXRoYW4gS2ltIDxqb25hdGhhbi5raW1AYW1k
LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgZHJpdmVyIGN1cnJlbnRseSBvbmx5IGNoZWNr
cyB0aGF0IHRoZSBNRVMgcGFja2V0IHN1Ym1pc3Npb24gZmVuY2UNCj4gPiBkaWQgbm90IHRpbWVv
dXQgYnV0IGRvZXMgbm90IGFjdHVhbGx5IGNoZWNrIGlmIHRoZSBmZW5jZSByZXR1cm4gc3RhdHVz
DQo+ID4gbWF0Y2hlcyB0aGUgZXhwZWN0ZWQgY29tcGxldGlvbiB2YWx1ZSBpdCBwYXNzZWQgdG8g
TUVTIHByaW9yIHRvDQo+ID4gc3VibWlzc2lvbi4NCj4gPg0KPiA+IEZvciBleGFtcGxlLCB0aGlz
IGNhbiByZXN1bHQgaW4gUkVNT1ZFX1FVRVVFIHJlcXVlc3RzIHJldHVybmluZyBzdWNjZXNzDQo+
ID4gdG8gdGhlIGRyaXZlciB3aGVuIHRoZSBxdWV1ZSBhY3R1YWxseSBmYWlsZWQgdG8gcHJlZW1w
dC4NCj4gPg0KPiA+IEZpeCB0aGlzIGJ5IGhhdmluZyB0aGUgZHJpdmVyIGFjdHVhbGx5IGNvbXBh
cmUgdGhlIGNvbXBsZXRpb24gc3RhdHVzDQo+ID4gdmFsdWUgdG8gdGhlIGV4cGVjdGVkIHN1Y2Nl
c3MgdmFsdWUuDQo+DQo+IFRoaXMgc2hvdWxkIGJlIGNvcnJlY3QgYXMgaXM6DQo+DQo+ICpzdGF0
dXNfcHRyID0gMDsNCg0KVGhhdCdzIG5vdCB3aGF0IEknbSBvYnNlcnZpbmcgYXQgdGhlIG1vbWVu
dC4NCmFtZGdwdV9mZW5jZV93YWl0X3BvbGxpbmcgY2FuIHN0aWxsIHJldHVybiBmaW5lIHdoZXJl
IHN0YXR1c19wdHIgIT0gMCBub3IgMS4NCkZyb20gd2hhdCBJJ3ZlIGJlZW4gdG9sZCwgb25seSAw
eDEgPT0gc3VjY2VzcyAodGhlIGNvbXBsZXRpb24gZmVuY2UgdmFsdWUgcGFzc2VkIHRvIE1FUyku
DQpTaGFveXVuIGNhbiBwcm9iYWJseSBlbGFib3JhdGUgb3IgY29ycmVjdCBtZSBpZiBJJ20gd3Jv
bmcuDQpJdCdzIHByZXR0eSBlYXN5IGZvciBtZSB0byBwdXQgdGhlIEhXIGluIGEgYmFkIHN0YXRl
IChkYW5nbGluZyBxdWV1ZXMgcG9zdCByZW1vdmUpIHdpdGhvdXQgdGhlIGRyaXZlciBrbm93aW5n
IGluIGl0cyBjdXJyZW50IHN0YXRlLg0KDQpKb24NCg0KPiAuLi4NCj4gYXBpX3N0YXR1cy0+YXBp
X2NvbXBsZXRpb25fZmVuY2VfdmFsdWUgPSAxOw0KPiAuLi4NCj4gaWYgKHIgPCAxIHx8ICEqc3Rh
dHVzX3B0cikgew0KPg0KPiBBbGV4DQo+DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhh
biBLaW0gPGpvbmF0aGFuLmtpbUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9tZXNfdjEyXzAuYyB8IDMgKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjEyXzAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L21lc192MTJfMC5jDQo+ID4gaW5kZXggYWZmMDZmMDZhZWVlLi41OGY2MTE3MGNm
ODUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMl8w
LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdjEyXzAuYw0KPiA+
IEBAIC0yMjgsOCArMjI4LDcgQEAgc3RhdGljIGludA0KPiBtZXNfdjEyXzBfc3VibWl0X3BrdF9h
bmRfcG9sbF9jb21wbGV0aW9uKHN0cnVjdCBhbWRncHVfbWVzICptZXMsDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgcGlwZSwgeF9wa3QtPmhlYWRlci5vcGNvZGUpOw0KPiA+DQo+ID4gICAg
ICAgICByID0gYW1kZ3B1X2ZlbmNlX3dhaXRfcG9sbGluZyhyaW5nLCBzZXEsIHRpbWVvdXQpOw0K
PiA+IC0gICAgICAgaWYgKHIgPCAxIHx8ICEqc3RhdHVzX3B0cikgew0KPiA+IC0NCj4gPiArICAg
ICAgIGlmIChyIDwgMSB8fCAqc3RhdHVzX3B0ciAhPSBhcGlfc3RhdHVzLT5hcGlfY29tcGxldGlv
bl9mZW5jZV92YWx1ZSkgew0KPiA+ICAgICAgICAgICAgICAgICBpZiAobWlzY19vcF9zdHIpDQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2VycihhZGV2LT5kZXYsICJNRVMoJWQpIGZh
aWxlZCB0byByZXNwb25kIHRvIG1zZz0lcw0KPiAoJXMpXG4iLA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcGlwZSwgb3Bfc3RyLCBtaXNjX29wX3N0cik7DQo+ID4gLS0NCj4g
PiAyLjM0LjENCj4gPg0K
