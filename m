Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B49CCF9EB
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 07:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D78B10E2EE;
	Mon, 27 Oct 2025 07:56:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EdIsIAq9";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75AD010E2EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 07:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yC06/5USRaF9FrUyPC5Zj8tnq3mnkrcEkbc+ONSGPb720r65R0Z0LnvlWpSwLCx6OOxvdXIHUbjg+X23+qor1ABDnC0WnpgJDpakCc2mmejBVNqqinTVvAPHnpms+KtKHZhYNJgFZ13Oul9Rbm8U3TPjd0JyGXmJLnwdUKdDEY6AoEX9nI6U3UkkGRnZHEN/qQHDVRPYds/8zRM/AFUKEnPcbuIBECZmSP72ZHIdJlMmuUMIdS5koC2MoKi2NvA03Ng2aGF0kjKO1QU0GMSpgHb06Yd73PCdGYSv1Nuz3OY2lfhah1VnJfmJuiFQ5MF5/+/0+LPl17Ydx4hnZnjZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9A3ea8DiP2iblXkQTos74vnAnH3f0d0EeY/N4x3i2nM=;
 b=T4uVT7jbL6MpNuuRELFPdtXBNg40JVI8ShzXblrQD9mVG4vEyoI69WhM64QUWJl5LT7TCoAm51Sa9neL7w7lUBqk9VzI9HJnGQF1cNHGEBHBmigiwjT+tfMcVMRFuKOsH9TsLz0ncfUzOXQfAikA7Ec6sE7D+vuJrKsPfE4ks7G+x6ejPxiy3q/h2Y3kSyHTBWrjfodMJH8V9VUn07QgJIP8oC9o91YRVt3VK8FmoQAr0iswCiW7ss77EDKqXVyxvvIxsxq9JTkznZNoxuBhM9lFGQ5u9sW3sTr6uT4BxQGM0lSrVjYFpe9jsgfwysHGVtRJo91NZ+IVr0gxY82AfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9A3ea8DiP2iblXkQTos74vnAnH3f0d0EeY/N4x3i2nM=;
 b=EdIsIAq9r67dt2ONqonGSlPUuzFh8MYPpM0QfzRMrrCF3YreGgrepgdRqzGr9UdXg5fDu6fpqzEKW9czC0FC9A+c3A3TlKCoBRRK+o6bG1uBp9oK+KaGzDzKJUlId8aIQ+HMglxiGSEijJjjiFTPYzlmRNJvA4P4jpT+GERQZCU=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 07:56:31 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9253.011; Mon, 27 Oct 2025
 07:56:31 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix incomplete null pointer issue for smu
 v13.0.6
Thread-Topic: [PATCH] drm/amd/pm: Fix incomplete null pointer issue for smu
 v13.0.6
Thread-Index: AQHcRxNIG+0t4FgUXEGrmY7dewBlgbTVnLwAgAAAlgCAAAJ1sA==
Date: Mon, 27 Oct 2025 07:56:31 +0000
Message-ID: <PH7PR12MB5997017BADC8B6DA24161F8182FCA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20251027072757.1267995-1-kevinyang.wang@amd.com>
 <fc5a13a8-12aa-46c9-a660-12ea7e99b3b4@amd.com>
 <46213d03-25e7-4c29-82b8-2c078990f524@amd.com>
In-Reply-To: <46213d03-25e7-4c29-82b8-2c078990f524@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-27T07:54:47.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH8PR12MB7255:EE_
x-ms-office365-filtering-correlation-id: 779e46e2-c223-4d3c-d936-08de152e5785
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?d0p4R3NobU9oYUdtZ3V3Uk5PeVhZOWRiMzlnRTV2RDBnWVFoYWpQaGp6aVV2?=
 =?utf-8?B?VnRnck5QNDRkWHZ4RXkxOTZVTnpvNGx2dEhtZ3VlM0JlMXF0dzdidk5BRmdB?=
 =?utf-8?B?UVcvaGloUDQwRmdKMnhvMmlQbDNZTEg0c0xLT1hBdVJqbXQ4T28wRUk0cEVR?=
 =?utf-8?B?NndiSlZpRDNSN1k5MG1wb09SNTFBUk5NMnFVTTc2bGt5ZUd0ZWg5ejVFek9D?=
 =?utf-8?B?cVpLMDJpbFprK0FkbkM5Qlg4YjNqQ3ZMQldsTUlsb09BOVo0bTFiRjlRNmVR?=
 =?utf-8?B?NlU5WVZqMitwSGcxdHpaYm1SMGtianlIcjVsSmEwTldySlluR0NJUkhMczBJ?=
 =?utf-8?B?V0hPRmNVL2VMaVJQRk1GV3dJWjVVVTB5TWNpZE5FRlRsZERueWV3K1dPZXpZ?=
 =?utf-8?B?TmlqODhoV3hNZU5heFVpNnVRV2p0cDVPM05zWElaU0ZPbmsyb1JJbkFIMmJN?=
 =?utf-8?B?Ri83aDBPNUsrTW1PTngrYmRKcHBoY3NKRnp4U3FTV0I2RmNEeHhIVzJxUHJ3?=
 =?utf-8?B?ZXg4VGtQTEhjdUl1d0RQNnE0ZzRGVS9EU1A1NC9GTmZabHhMeFRGZFpWN2Vu?=
 =?utf-8?B?Q3VubTJKOHJGanZZZ0wyZUtPK0xyRTg3enZHVDc4QlgrVTI3NzJwREtIRzRn?=
 =?utf-8?B?VjBzVno0VG52QUkveTJrYTY1bERJSnh3Yzd6VmRmbXJVN1ovdHVNUU5UcVFx?=
 =?utf-8?B?VHZHSXdRL0d1ODZmQUExSEtHRGhKSjErbVZnR1RIYnNpcHZXZGdjaENYYk42?=
 =?utf-8?B?OW1oNlpqZzNrWm1IbllKblRiZ2MxNzUzS04rckt5YTc1STRrRjcvSlVqTERG?=
 =?utf-8?B?VkFPWWVLeVFlL01lbkgzN3g5RVVRQ1pTU1NXdkwranhNcUFsdEZ1ZnZ5amFo?=
 =?utf-8?B?WExsbHNXazkwOVpNanYrTG1Za0FEQ3dFZUxsT1pMaFo1WEJXUENRTTRRSElZ?=
 =?utf-8?B?ZUZsZWo5OEZLVXFwNzJlTms3eWdBa1FvUm13dkUwWEhYa1cwcmxqc0tGay9v?=
 =?utf-8?B?eU9wbm1XeE9HeVhQTDhabllWcy9XZU1DSk1wVDlqd2hqT21rSlRYRjVmT1RX?=
 =?utf-8?B?WUVwbXF5aXgrcjdhdjVCMi82clg2a0RPV2ZHdXI1elc1akZhTUd1Nm02czJz?=
 =?utf-8?B?V2JCMXZCOXhHelVVc3dzVlVvQ2RTVnlKQjVkWm4yZFpIbXRyUnNmZy9VeHVV?=
 =?utf-8?B?N09ubEJZSE1BaDFFZUlHYkpGQ2dvMW5ZYUNpdmFOZ0FlSFNPQ0JrNzNVeFE4?=
 =?utf-8?B?NFVTVmVYZzRuanZZMlE4d3VRVG9RM08vM2dhNkxlR1RhSGtFdUc2aGtLZ2xy?=
 =?utf-8?B?QVloTEp3eHRUOTAzL3NMU2J1cnlKLzNIR1UxNCt3aEZia0ZKUEtZN2RsZkh3?=
 =?utf-8?B?cng1U1YzbERVVXJFREc4MzU2SjlWWHgyOHVLc01mbmEraUc1ZlIxREExWVpv?=
 =?utf-8?B?elVCM01TSVBwaFJ4V0JPbjF3VWs3VGhnS2JGWmFzS2RUdGxUWjFaZCtVbENO?=
 =?utf-8?B?TXZ1NEZzWFFNSjdZeUg5Tm9vcmZvb3p3QldySFhvdUpoRmFIOTdTaDF6QnVR?=
 =?utf-8?B?SmJXc2liSFVnb3E4QjlDcXJCYWhBN3BwQWljZFZyTHBBbWhYVGs5Y0hLWDB3?=
 =?utf-8?B?KzFya3pFUVlWS1hna1J2Y2g3MDhYU09PS1pUVHlnd2NKRklvdG1UVnhmczUz?=
 =?utf-8?B?NitDUDF1dXlGa3A2R0R2WW5LU0duazhQZ0phbG4yZ1FOWXg1M2QyN2h3NWMr?=
 =?utf-8?B?L2wwRDAvSTZjOVFqTFdYN0drWHJoVlBqM2JIcWNqVXVRRmNOdGVFeXNCTWhU?=
 =?utf-8?B?MDRIVGxid3ZkQmVNTG84K2RmNUdsR2VYY0F0eVROcTZUTFhBTHFEMzNEM05u?=
 =?utf-8?B?bzg1TVBzajVrR3NnSk5XSlY1cytWVk1vQ2IzYXV6VUIvZ21BSXlOenBzT0Fv?=
 =?utf-8?B?TGRidTJWZURpSUIvTHRoVnliNVFIQTVUcnhkeGFDc0dUaWxEOUlwOElqQVBL?=
 =?utf-8?B?SlpKME9MdXd6RjN3VkFPeVlQZWRLZFV6WGszSXdpZkhZVFhHN0RGcy9VQS9H?=
 =?utf-8?Q?/+rGW7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDZzRzhtRVlmN09xY2xjRGNOVGM0RE9qSlJZUjNFRXFpcE1BbFJyYkUrR3gx?=
 =?utf-8?B?b1Jpb3F5Uk81UnZZbFBNL1NZSUVsWjduRU5HbW9MRGdzdFJIRUFvM1pQQ1Rp?=
 =?utf-8?B?R0I4NGYwT0h6YVRJZWpqYWNTVzlzM08rWE9vNEdWRWM4YkliM3ZVanhxWWNY?=
 =?utf-8?B?TURzZ2d4WXVyYlVoRkhiSmh2Q1VvdUlSN25DRVlzaHhZT25UWC9zVW56QWli?=
 =?utf-8?B?OFpuUXVMd04yMVRSZ0dMWHR5RTFFcWd0dHFxc3c4d0RvdEFybkVlWnBKNTRy?=
 =?utf-8?B?dGVsU2JnMjlhczhld2NtTDlnYkU5MS9mZnVIai94SGZRZ1hNc003RjlRdkl3?=
 =?utf-8?B?MVoyeFkyU0VpTElaSFVZeTEvdGtYKzExZnB5S013bWdFTXRYNHgxNW0yQkkr?=
 =?utf-8?B?eHJWK2JPUllTcmhWQTJPNXNRU1JEME5uQ2pyNC9iOVI2MkNiVzBINUlYZ0RJ?=
 =?utf-8?B?N0IwMFlnR1M5eHI4VDc5SnpBY0xNZkg5OGw0emFGSmhaNGwvZkdKK1lDeVhE?=
 =?utf-8?B?YVRPS0xyd1VpcllFbWVwb3BmYTdRZnNvR3ArMU0xeWpMRXkvNEtyUWV6enZQ?=
 =?utf-8?B?M0FVdWt0Skw1elZML1pGVzR0cldEMW1rZ2cxVDNvdU1TSXJZZ2x6eE5rYXFN?=
 =?utf-8?B?REJEQlFPSEtuYW8yM2hsbk1OVnkyRStuQ0hsUGJiU3VlYWhjK3NvTStBRE1a?=
 =?utf-8?B?djJNS0h1RjRlMEtDRGMxWUFKcFRyc045RkxtS1g3QTZ5VlZ6em40UDlxQUx4?=
 =?utf-8?B?aUdGU09JWldjU2x3U3hWYlpCRDdpVzMzTm0ydDN0QVVVKzZ3ZzZCUFo1SkIx?=
 =?utf-8?B?NGltQWI4YW9BVWxFazFlc21hWm1GWWd6Qko4RVZNdEVKU3lJbkNqUG4rd3ht?=
 =?utf-8?B?VnJSRXZ0ZkVYUkVPekFqSFBRSDVTSkMwZW5Ja1VTMWpmVmdiVXJCZVZuV2Ro?=
 =?utf-8?B?NURLdksyQzNGS3AxNGp3cElQUFR4YVJtbStNTTdtOGF3ejNLT2QzdXRVRGNm?=
 =?utf-8?B?b2JNOWRHQjJGQTdqaEwydTBzYVVlNGhOdDJBaHVqNGRyWCtrdU13bkE0amxT?=
 =?utf-8?B?OEpYazJwSEx5K0prc0FNYkNUdXVONjJkZXBxTlBpT0xOMzZDa2xjZjN0V0JT?=
 =?utf-8?B?WTJMSmRjek9POXF4NnVTbStGVUFveVM4MjUxdHB5am1yTUE4c2dGUmJXMjVt?=
 =?utf-8?B?YlU5ZTh4WmRtRFBGYjRneUdMK09JZERJNzE4K1BlcXNrRlQ2cUlpS01DdEJV?=
 =?utf-8?B?ZmhjSlNyeUwyMWNwdEY1R3MxMVZBaVhSTUQyOEpNakErS3lKZVJQMitkSkh3?=
 =?utf-8?B?Q3U5aU40MlZGMC8walQ3OEZKMndNR200OGVBRmlHTUJBSGlQL1VqanZxSWJN?=
 =?utf-8?B?WGlxK1JkeXNqRXE1dEhhZ1hNMDJCK2hRQzNTNkY0YVpTaS9TTDJTQTBJMU9O?=
 =?utf-8?B?K1JsdmZYVzFKNkpqYUpCbkR0VERJTjJZdmdNNU1YVEhKNzFEZ204Q0lGcWln?=
 =?utf-8?B?SzN0WWtjM2g2RUlPYWU0bHYraVNuSHBjaFdBYklHd09DS1IxSVdZRTdRZ2hE?=
 =?utf-8?B?T3lZRkFaUGNMcStkajNKSWJldDFDSmRJWGhoa2JreGUvTUhjNVRiMWIwTzhZ?=
 =?utf-8?B?dkJTT3A3RzhJSG1QYVhQNWVURlRtNUZOTWhvdVlTdE52M0FJc29GVmFXZ2o0?=
 =?utf-8?B?SnhuSTl3WkhWdGY1MGxleXBuYkY2YXBadFpKOTJrRGlhNnpGclJKMHZjNlNp?=
 =?utf-8?B?cit2Q3dBV1hpNmYxYnFsa0p5d0tGL1Z5MG5nNjJHRjBqYjUxcXRVWEtEeWM5?=
 =?utf-8?B?b2t6NzJsaWpKM3FBSWZMMS9YYVBWVjd5ZG5jM2JKUmZuYUhYaEY3dWRtK0pw?=
 =?utf-8?B?T1JwNm55ZzVHdmRMZ1ZTMithS1E5V3htTUtVdklGdXBoWmFNbmNKNTdGNWk1?=
 =?utf-8?B?NkpUYlpTNXRsd0R3RUtmZkpCZVozNEZRTGlIa1htdzZSK2QrenJnS3NSUmtM?=
 =?utf-8?B?dVZWdjNrbVcxbWpSRjE2VlRWdTFvL0hEWFlOaVZHT2FabE5oaC9TR0c0aWdE?=
 =?utf-8?B?dDc1UEJHQldGVEJRQS9rQkI2SlNFVzNSL2duQ2hBWkNiU2lSb0phWGJ4dVMv?=
 =?utf-8?Q?meAY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779e46e2-c223-4d3c-d936-08de152e5785
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 07:56:31.3244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VQ6xIiTpZ9rd5o4GSOjHYGDsBcyGx0dRTgNtqu61j8ltQFo04hEW2gEsSLPdd/R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255
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
Cg0KPj4gUHJvYmFibHkgdGhlIGZpeCBuZWVkcyB0byBiZSBpbiBzbXVfdjEzXzBfNl9wcmludF9j
bGtzPw0KDQpJIHdvdWxkIGxpa2UgdG8ga2VlcCB0aGUgY3VycmVudCBjb2RlIGRlc2lnbiB3aGVy
ZSB0aGVyZSBhcmUgY2VudHJhbGl6ZWQgZXhpdCBwb2ludHMgZm9yIGNhbGxlZCBmdW5jdGlvbnMg
dG8gbWF0Y2ggdGhlIGtlcm5lbCBjb2Rpbmcgc3R5bGUgcmVxdWlyZW1lbnQuLg0KDQpodHRwczov
L3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y2LjE2L3Byb2Nlc3MvY29kaW5nLXN0eWxlLmh0bWwN
CjcpIENlbnRyYWxpemVkIGV4aXRpbmcgb2YgZnVuY3Rpb25zDQoNCkJlc3QgUmVnYXJkcywNCktl
dmluDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMYXphciwgTGlqbyA8TGlq
by5MYXphckBhbWQuY29tPg0KU2VudDogTW9uZGF5LCBPY3RvYmVyIDI3LCAyMDI1IDE1OjQ2DQpU
bzogV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFt
ZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBL
YW1hbCwgQXNhZCA8QXNhZC5LYW1hbEBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJt
L2FtZC9wbTogRml4IGluY29tcGxldGUgbnVsbCBwb2ludGVyIGlzc3VlIGZvciBzbXUgdjEzLjAu
Ng0KDQoNCg0KT24gMTAvMjcvMjAyNSAxOjEzIFBNLCBMYXphciwgTGlqbyB3cm90ZToNCj4NCj4N
Cj4gT24gMTAvMjcvMjAyNSAxMjo1NyBQTSwgWWFuZyBXYW5nIHdyb3RlOg0KPj4gdGhlIHNtdSB2
MTMuMC42IGRyaXZlciBzaG91bGQgaGFuZGxlIHJldHVybiB2YWx1ZSBvZg0KPj4gc211X3YxM18w
XzZfcHJpbnRfY2xrcygpDQo+PiB0byBhdm9pZCBudWxsIHBvaW50ZXIgaXNzdWUuDQo+Pg0KPj4g
Rml4ZXM6IDAzNTRjZDY1MGRhYSAoImRybS9hbWQvcG06IEF2b2lkIHdyaXRpbmcgbnVsbHMgaW50
bw0KPj4gYHBwX29kX2Nsa192b2x0YWdlYCIpDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWFuZyBX
YW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9kcm0vYW1kL3Bt
L3N3c211L3NtdTEzL3NtdV92MTNfMF82X3BwdC5jICB8IDQxDQo+PiArKysrKysrKysrKysrKy0t
LS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUx
My9zbXVfdjEzXzBfNl9wcHQuYyBiLw0KPj4gZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9z
bXUxMy9zbXVfdjEzXzBfNl9wcHQuYw0KPj4gaW5kZXggMzlhZTY3MDExNDdjLi4yMmZlNGQzNTA4
ZmQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3Nt
dV92MTNfMF82X3BwdC5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3Nt
dTEzL3NtdV92MTNfMF82X3BwdC5jDQo+PiBAQCAtMTUxNCw5ICsxNTE0LDE0IEBAIHN0YXRpYyBp
bnQgc211X3YxM18wXzZfcHJpbnRfY2xrX2xldmVscyhzdHJ1Y3QNCj4+IHNtdV9jb250ZXh0ICpz
bXUsDQo+PiAgICAgICAgICAgc2luZ2xlX2RwbV90YWJsZSA9ICYoZHBtX2NvbnRleHQtPmRwbV90
YWJsZXMudWNsa190YWJsZSk7DQo+PiAtICAgICAgICByZXR1cm4gc211X3YxM18wXzZfcHJpbnRf
Y2xrcyhzbXUsIGJ1Ziwgc2l6ZSwNCj4+IHNpbmdsZV9kcG1fdGFibGUsDQo+PiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICBub3csICJtY2xrIik7DQo+PiArICAgICAgICByZXQgPSBzbXVfdjEz
XzBfNl9wcmludF9jbGtzKHNtdSwgYnVmLCBzaXplLA0KPj4gK3NpbmdsZV9kcG1fdGFibGUsDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgIG5vdywgIm1jbGsiKTsNCj4NCj4gUHJvYmFibHkg
dGhlIGZpeCBuZWVkcyB0byBiZSBpbiBzbXVfdjEzXzBfNl9wcmludF9jbGtzPw0KPg0KPg0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZSArPSBzeXNmc19lbWl0X2F0KGJ1Ziwgc2l6ZSwg
IiVkOiAldU1oeg0KPiAlc1xuIiwgaSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBjbGsxLCAobGV2ZWwgPT0gaSkgPw0KPiAiKiIgOiAiIik7DQo+DQo+
ICdzaXplICs9IHRvIHNpemUgPScgc28gdGhhdCBpdCByZXR1cm5zIG9ubHkgdGhlIHRvdGFsIHNp
emUgZW1pdHRlZCBieQ0KPiB0aGUgZnVuY3Rpb24uDQo+DQoNCk5ldmVyIG1pbmQsIHRoaXMgaXMg
bm90IGdvaW5nIHRvIHdvcmsuIFRoZSBmdW5jdGlvbiBtYXkgcmV0dXJuIHRoZSB0b3RhbCBzaXpl
IGl0IGVtaXR0ZWQsIG9yIGl0IGFsc28gbmVlZHMgdG8gYWRqdXN0IHRoZSBiZWxvdyBjb25kaXRp
b24uDQoNClRoYW5rcywNCkxpam8NCg0KPiBUaGF0IGlzIHRoZSBjYXNlIGZvciB0aGlzIGNvbmRp
dGlvbiBub3cgLQ0KPg0KPiBpZiAoY3Vycl9jbGsgPCBTTVVfMTNfMF82X0RTQ0xLX1RIUkVTSE9M
RCkNCj4NCj4gVGhhbmtzLA0KPiBMaWpvDQo+DQo+PiArICAgICAgICBpZiAocmV0IDwgMCkNCj4+
ICsgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKyAgICAgICAgc2l6ZSArPSByZXQ7
DQo+PiArICAgICAgICBicmVhazsNCj4+ICAgICAgIGNhc2UgU01VX1NPQ0NMSzoNCj4+ICAgICAg
ICAgICByZXQgPSBzbXVfdjEzXzBfNl9nZXRfY3VycmVudF9jbGtfZnJlcV9ieV90YWJsZShzbXUs
DQo+PiBTTVVfU09DQ0xLLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZu
b3cpOyBAQCAtMTUyOCw5ICsxNTMzLDEzIEBADQo+PiBzdGF0aWMgaW50IHNtdV92MTNfMF82X3By
aW50X2Nsa19sZXZlbHMoc3RydWN0DQo+PiBzbXVfY29udGV4dCAqc211LA0KPj4gICAgICAgICAg
IHNpbmdsZV9kcG1fdGFibGUgPSAmKGRwbV9jb250ZXh0LT5kcG1fdGFibGVzLnNvY190YWJsZSk7
DQo+PiAtICAgICAgICByZXR1cm4gc211X3YxM18wXzZfcHJpbnRfY2xrcyhzbXUsIGJ1Ziwgc2l6
ZSwNCj4+IHNpbmdsZV9kcG1fdGFibGUsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICBu
b3csICJzb2NjbGsiKTsNCj4+ICsgICAgICAgIHJldCA9IHNtdV92MTNfMF82X3ByaW50X2Nsa3Mo
c211LCBidWYsIHNpemUsDQo+PiArc2luZ2xlX2RwbV90YWJsZSwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgbm93LCAic29jY2xrIik7DQo+PiArICAgICAgICBpZiAocmV0IDwgMCkNCj4+
ICsgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKyAgICAgICAgc2l6ZSArPSByZXQ7DQo+PiAr
ICAgICAgICBicmVhazsNCj4+ICAgICAgIGNhc2UgU01VX0ZDTEs6DQo+PiAgICAgICAgICAgcmV0
ID0gc211X3YxM18wXzZfZ2V0X2N1cnJlbnRfY2xrX2ZyZXFfYnlfdGFibGUoc211LA0KPj4gU01V
X0ZDTEssDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJm5vdyk7IEBAIC0x
NTQyLDkgKzE1NTEsMTMgQEANCj4+IHN0YXRpYyBpbnQgc211X3YxM18wXzZfcHJpbnRfY2xrX2xl
dmVscyhzdHJ1Y3QNCj4+IHNtdV9jb250ZXh0ICpzbXUsDQo+PiAgICAgICAgICAgc2luZ2xlX2Rw
bV90YWJsZSA9ICYoZHBtX2NvbnRleHQtPmRwbV90YWJsZXMuZmNsa190YWJsZSk7DQo+PiAtICAg
ICAgICByZXR1cm4gc211X3YxM18wXzZfcHJpbnRfY2xrcyhzbXUsIGJ1Ziwgc2l6ZSwNCj4+IHNp
bmdsZV9kcG1fdGFibGUsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICBub3csICJmY2xr
Iik7DQo+PiArICAgICAgICByZXQgPSBzbXVfdjEzXzBfNl9wcmludF9jbGtzKHNtdSwgYnVmLCBz
aXplLA0KPj4gK3NpbmdsZV9kcG1fdGFibGUsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
IG5vdywgImZjbGsiKTsNCj4+ICsgICAgICAgIGlmIChyZXQgPCAwKQ0KPj4gKyAgICAgICAgICAg
IHJldHVybiByZXQ7DQo+PiArICAgICAgICBzaXplICs9IHJldDsNCj4+ICsgICAgICAgIGJyZWFr
Ow0KPj4gICAgICAgY2FzZSBTTVVfVkNMSzoNCj4+ICAgICAgICAgICByZXQgPSBzbXVfdjEzXzBf
Nl9nZXRfY3VycmVudF9jbGtfZnJlcV9ieV90YWJsZShzbXUsDQo+PiBTTVVfVkNMSywNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmbm93KTsgQEAgLTE1NTYsOSArMTU2OSwx
MyBAQA0KPj4gc3RhdGljIGludCBzbXVfdjEzXzBfNl9wcmludF9jbGtfbGV2ZWxzKHN0cnVjdA0K
Pj4gc211X2NvbnRleHQgKnNtdSwNCj4+ICAgICAgICAgICBzaW5nbGVfZHBtX3RhYmxlID0gJihk
cG1fY29udGV4dC0+ZHBtX3RhYmxlcy52Y2xrX3RhYmxlKTsNCj4+IC0gICAgICAgIHJldHVybiBz
bXVfdjEzXzBfNl9wcmludF9jbGtzKHNtdSwgYnVmLCBzaXplLA0KPj4gc2luZ2xlX2RwbV90YWJs
ZSwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgIG5vdywgInZjbGsiKTsNCj4+ICsgICAg
ICAgIHJldCA9IHNtdV92MTNfMF82X3ByaW50X2Nsa3Moc211LCBidWYsIHNpemUsDQo+PiArc2lu
Z2xlX2RwbV90YWJsZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgbm93LCAidmNsayIp
Ow0KPj4gKyAgICAgICAgaWYgKHJldCA8IDApDQo+PiArICAgICAgICAgICAgcmV0dXJuIHJldDsN
Cj4+ICsgICAgICAgIHNpemUgKz0gcmV0Ow0KPj4gKyAgICAgICAgYnJlYWs7DQo+PiAgICAgICBj
YXNlIFNNVV9EQ0xLOg0KPj4gICAgICAgICAgIHJldCA9IHNtdV92MTNfMF82X2dldF9jdXJyZW50
X2Nsa19mcmVxX2J5X3RhYmxlKHNtdSwNCj4+IFNNVV9EQ0xLLA0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZub3cpOyBAQCAtMTU3MCw5ICsxNTg3LDEzIEBADQo+PiBz
dGF0aWMgaW50IHNtdV92MTNfMF82X3ByaW50X2Nsa19sZXZlbHMoc3RydWN0DQo+PiBzbXVfY29u
dGV4dCAqc211LA0KPj4gICAgICAgICAgIHNpbmdsZV9kcG1fdGFibGUgPSAmKGRwbV9jb250ZXh0
LT5kcG1fdGFibGVzLmRjbGtfdGFibGUpOw0KPj4gLSAgICAgICAgcmV0dXJuIHNtdV92MTNfMF82
X3ByaW50X2Nsa3Moc211LCBidWYsIHNpemUsDQo+PiBzaW5nbGVfZHBtX3RhYmxlLA0KPj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgbm93LCAiZGNsayIpOw0KPj4gKyAgICAgICAgcmV0ID0g
c211X3YxM18wXzZfcHJpbnRfY2xrcyhzbXUsIGJ1Ziwgc2l6ZSwNCj4+ICtzaW5nbGVfZHBtX3Rh
YmxlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICBub3csICJkY2xrIik7DQo+PiArICAg
ICAgICBpZiAocmV0IDwgMCkNCj4+ICsgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKyAgICAg
ICAgc2l6ZSArPSByZXQ7DQo+PiArICAgICAgICBicmVhazsNCj4+ICAgICAgIGRlZmF1bHQ6DQo+
PiAgICAgICAgICAgYnJlYWs7DQo+PiAgICAgICB9DQo+DQoNCg==
