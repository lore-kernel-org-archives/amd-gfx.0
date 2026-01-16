Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BFCD4A619
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 10:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0969A10E841;
	Fri, 16 Jan 2026 10:03:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q8owR7vF";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012070.outbound.protection.outlook.com
 [40.107.200.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A80F410E841
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 10:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJZXKE4eELTMN3h2Ej4l9+KT2aAAj8cmO6Nd05NlsiLgnzCplTdHs8MioHGmz5kIXkMaZX7Goa+Hu36+tna8JlHLgoJwax6P6EM3wPNFhnCXBC+TgmETJvB5LZ9VOZQoKiWRe4hD9RuyF3r3wibxFOJgWGIaRHRGYnmwx633lejw+U/qVdWvriHZXYM1ReGUS77VC7n3WJs7xjwofLSe1ohgw9XaAQMe1D37opph7xVIoWyM9risxy+K0duE/ZnVTv1K4Y605RM8Ur2+WRjCD3LS2Jmjmk/NanGHwWOBLFFsUaEyqPx/sFRW+Bborjywxbd69oq5LOhzcNbQJBDHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vE9lZuujxvBd4r4lpBsh3UmB5167hHZEo6v7vUIJH+U=;
 b=lijb8ANSCyiUN4jYg5axBnWJ+FzGoA5UXvE7o4k2USRR8CWUfYUeaN40elf9B5OX+wff4tpEvc9g9PVKbyFw189SNrrYvCqj9QRENOYtfmCfle4fwhfD++trzg2BPb9eoWQQr0mr8xad7QadhrHzuP3e4laRioWSk9DFa7+5ySZfQt/OxGSEEzVFlAzaybZfWEcTWDG7KJKUpJC5USsdgQG6jc/qHBjQCsvtU93RUD4Ibu3SbAI+roP6ADoYNhWTNcjmo0DD4SogzYsRKYeo+EPiKbGW9SJydkjYBDQd1yOY6UxyCotqVwKt6KsVpPVfqY99edX+U3ZrIu0zXizWzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vE9lZuujxvBd4r4lpBsh3UmB5167hHZEo6v7vUIJH+U=;
 b=q8owR7vFG9FXghBSX6QAL95G/NZSnpwCoRJ/mDlZigsWKr7nfVxIIpIWU/xYvKolMBUT1oRdwKBbCa6c3q31EoTbjK2Ep8RfIY9AZuKqe28odIdzVQFDd4xcYYXLw904xc6bgBsaSNeMALF/ozFslmLXNC/x/u9+4mHt1qn+2Z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 10:03:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 10:03:17 +0000
Message-ID: <1673a119-838f-455e-88fb-528bbd72e1ea@amd.com>
Date: Fri, 16 Jan 2026 11:03:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm/amdgpu: Avoid unnecessary Call Traces in
 amdgpu_irq_put()
To: Tiezhu Yang <yangtiezhu@loongson.cn>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Alan Liu <haoping.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260115012830.31182-1-yangtiezhu@loongson.cn>
 <6ac02ffa-5d62-4fc7-9882-6ccf7b44eaf4@amd.com>
 <0afdb83a-d2db-53d9-3b1b-253e466a5cc3@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <0afdb83a-d2db-53d9-3b1b-253e466a5cc3@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0425.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d218483-e098-4a21-366e-08de54e67836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXZ5d3FGUVErbktsclFaY0xyYjcxcXZzRkNSZk9WQlJ5aS9jRGNHTGE3cEVq?=
 =?utf-8?B?a2NDT1MxYnluNzl1QURDUTlSOXBJQkNzSHc4N0tKL0lFcUxWazRLRHNYMGRY?=
 =?utf-8?B?VlQzdnR5clhHb1hrWVpCY3lmcytsWWhGdkZnZWFKbEZGa1J3YzU5UXZkeE11?=
 =?utf-8?B?VHV0bG1LN2JzYUtyM3QzZG1XR0s4aW5GWTBZUTNjOWpjSFJteUJvOFZFOURG?=
 =?utf-8?B?SkhQWTZLSEFqY2RUZXpNbmhNOFVYaVpaQU8vVkJCZytVWktFTTRWK2tsVWg1?=
 =?utf-8?B?OGJvSmtqbS92U3BPSnZmZHErV09VZGZvSEFlajdZaTdUWWFzYUpkRDBDbzQy?=
 =?utf-8?B?UkJoZ2U1dG13WXRvVEIwS3E0SFlZV0ZwOU9jNzZ5UjArVkFuYVZVRTB0dGlr?=
 =?utf-8?B?clE1SEJZbUtMZVZvUWN6cy9ROVZFS3RyVlJWQjc2RVphMytZckZLakRCV1RR?=
 =?utf-8?B?SXBkZkFwUTR4RURSSC81eWJTZGpoMWs4K3UxNnpXQTR2S2VtcWZqSC9WYkI1?=
 =?utf-8?B?ZjFsbTJydDBrenprSC9hZkt3aFBGRUtnanhsdTlMQmpuYk5kWlBhbitJSWpC?=
 =?utf-8?B?NGhqckVGd2M0ZU1YSDZxR25BalhiajUwN2Nyc1laWmxGZENxQ1BvZnlaTk5J?=
 =?utf-8?B?eDBadUJCdVNLM0hOYTFBcVFZcjJia0JONFhpWldoVWhEQkNOZXBjckxqdVVN?=
 =?utf-8?B?TDVLbFN0WFZ2UUtRcUptckVnOGFlVDJtTjFFQmVFb0RRMjhoeEw5R1ozb2lx?=
 =?utf-8?B?RjlzdFFsUW55Z3hXNzRUa29IZWQweEJ4TnRSRGE3Q3JHS0picE1BS0hMbktu?=
 =?utf-8?B?UlI0QW1yVzRFYUk5RW1GZGpuOHJGOWV5dGxZY0cvK2N2c0NCUGMvVnlIejB2?=
 =?utf-8?B?TnphbzVkcGhaeG9aNGplRnNUdkdma2xXQS9kS0hyY2k4TXJYdTJWK1g5cHRV?=
 =?utf-8?B?Q1QycFphYnBDeUJObnd3aFBDMUtMbUMyaStSdk5iRUdNQVJSb1BsK2hvOTdv?=
 =?utf-8?B?ckw2ZG1JM0w2S2kxUU1xeGVWQXZsTVR3VzFhTzQzNTZndEJtZGMwMkp0M2lW?=
 =?utf-8?B?WHBtYktreDFJbFZhU3lBTGI1YWc2UXNUYklVS3RqT0Q4Vk55UXkzY0RObDZP?=
 =?utf-8?B?dG9hWFp1eEpYeVViUWUxdnZPNllSTWFtVURGWWx4ZFFZZE1CeGtOcjVWOW54?=
 =?utf-8?B?TlE3dDQ2LzhsV0Q1V2d6RkJLWHFPcG03d053ME1Qczk2bEZXU2tmWElQT0s4?=
 =?utf-8?B?MzVqVnJKYUVxN0xreEljbjN3UUJwcjNkOVFqUXpkeGJkMUZFOGlQZWRTYnIr?=
 =?utf-8?B?b3ArbGVJMkNXREZHVCszZ21rZHgrY1dsMjdmVDZYZ1gvb2xzM2NmZTZPczdx?=
 =?utf-8?B?Zy9jWEVkeGVwREhvQVROM2RON015S3hQQWdCMmw4ejdzenp5eGxVb1hNQVI0?=
 =?utf-8?B?bVlvZnVwaFU0OVhQZWV3aGhRc29QRU5vNEt5VmZ6WlM2Yy9qbTkyY2FoQXNi?=
 =?utf-8?B?TnYyMG93VlhPZ0VoOHFMZ0xneGZ2eTVQK1hLY2tnbzZVbEV4SEk0OGhpZ3h2?=
 =?utf-8?B?SnNXMm40N3c2S3dIQWxUbHpDMGpNaWl6L2Z0YjdKQ3dBaW00OEgwVlVzeHJJ?=
 =?utf-8?B?MlFjVit2U05TRHRpZVZDQXNSVGJnK1J2WnkyU0krYjdrbWNHdWFiWjdsTEh3?=
 =?utf-8?B?M1pGdmp6WWd0eGFhMHlmNHVkZFlYZVFWMHAwOGt5REtSWmhEZjcrdUpLYmNT?=
 =?utf-8?B?b1pwODkxcWY2Mi9nTDRBUUUrdWFzdndFNWFRc3pSdmR2d3BiUTMzYkJ2UTZC?=
 =?utf-8?B?ekVvMlRlRlNhQTJmWUNFRVpjdUs0UnYrWjR3SkRMaFNQRGwwZTN6Nm1oZzhC?=
 =?utf-8?B?Q0pZUFVGYmpITHRWNTFlblhzQmRWNWJjeXBIcE9hZC8yTDljN3A5R1lWSzl0?=
 =?utf-8?B?WHlhRUFTcnRublN1MjlGSndEUWh1azdBajNoMlNXRmJMbEF5U0lGSzVkYXhH?=
 =?utf-8?B?Y1krdWtoVXZiNGliWC96aEFUOWVXczRRUGdBbk9EVUw4Sk4vV2xvVmNGTVpZ?=
 =?utf-8?B?N1A4RytRaG5GajJ2MWNBQ2VXWEtERFZZWmJlQW00OVZLaW9NaDRSU21WcEhP?=
 =?utf-8?Q?hxw8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzNVN3VmZkt0VGZ4QnpncnQzZ0l2cXF1ZnRhMUJtVGtmY2x3VXlES2I3cDll?=
 =?utf-8?B?MDcxSWxtK1FjL1pPRUhIS2VRU20vanc1NSs5cnhBYjlZTDg4SG9CMnkxMkxw?=
 =?utf-8?B?S0hDTHhwaTh3QzMrSG9lN2kwYUJnK0IyVXNVUmF4MlBRUjBBZ2xpQ3doTytM?=
 =?utf-8?B?WUdJNFJvOVdvYVdWYUNkUUdzc3JaQnFqbCtVcURDQ0lHb2RWTkdHb1lhTEwx?=
 =?utf-8?B?eWI0cE50a1ZyaWg0WkhST3hpQ29XSWl0Y2VGamN5YmhEazZHWnY4NjM1N3Rt?=
 =?utf-8?B?MDJZOGhpdXBzZ1pFdkpCZnRnMGhPcnlsWVVSbVdlN0kvNFd1SDlUWDFKOUc2?=
 =?utf-8?B?M2R1Y0JNOXdFMllXL1N2L09UYmJlVEk5V3BxUi9aZ0swNXdDTkUvZmZZT1RH?=
 =?utf-8?B?M05DelNTWFhTUTBwM0paclFSVTZ0dGFYNGpXQ3FiWUE2cmFnTGh3c3dkNHgy?=
 =?utf-8?B?UnBLZ2F1Z0ZKWVRKY1ByOG5mdUpGeU1mVzNUK25MekpiT1hCNjIvdXh5QitL?=
 =?utf-8?B?TVdsT3IyaHJFY01tZDNDd2kvcjU4VDdYbmxvMjgvM0VIcVVQbGY5YTVZMzRO?=
 =?utf-8?B?N2VuMTB3eTh4YjhJcjJObE5nbGZSSytuZ3dHY3NzKytHTUFZR1g5elU1QjNy?=
 =?utf-8?B?UitqYmhHZW5tNTRia09ydlVhWmovbWROb2NnS1BCdXlKbkl4ZVVTOC9vc09H?=
 =?utf-8?B?WHg5bDU1S2NBamhzbVFTL3BKbm1vTmFBOFgrbUpVK2FJWmZQVkJ0Zjg1aUtV?=
 =?utf-8?B?UStzdXZHK25KZTJmVGp2a3Ayajk1MHlFRHZSRGloNE9BTDNNUGNMc1FWc0NY?=
 =?utf-8?B?UjNyVzNXUFdqZmZRTyszaTA4MXBMcTVNZUUrd3NsRTd1MTJCL1dIbVp1ZDU4?=
 =?utf-8?B?Ni9NRmwzVWxWMVROcDZVQ0pmZTBYelgwV1VyV3Ryc3p0bTNaRG9Dc1pwNUxU?=
 =?utf-8?B?SW1HbEIxcndDVXN6eEtCY0MwTjQwcGk1OEJEZkVBTXZkQjBHNmN1YlZnQ3JO?=
 =?utf-8?B?cGpHRmtuV0s2b3UxeG5pS0I0ZEVVd1NvRzRKdTBkK0RTSEUzQTBiSEtlcHZu?=
 =?utf-8?B?UkUvMjZNZ2F5dVBIL1ZHUGZLTlFnR0tHblppS09XTysyRHhneTk3aWlVMHNz?=
 =?utf-8?B?ei9ZaG00TmFrcHZFYkMwMS9lekQvbDVlRllrc1JWd2tNN0hVQVpqUk53dWlv?=
 =?utf-8?B?aDZuUzNzSkdMbkRMcHBVUWQwOEFnV2pCNk9WTFlIRGVlRFcwM0tCZCtNc054?=
 =?utf-8?B?NGJjTVJMT3RVMU9QUFFVL2p1OGM3eWgvVllUNWF2aStkbmZxVytNT1dSRUlH?=
 =?utf-8?B?MlJXOStiTEphUm1pbVdGbTZ0QmhBZnRrdVVPZ1E2VGoyWUUwV1dPS3BHSTlO?=
 =?utf-8?B?eWhBOHMxVXVqMjNYV25aRGJoai84enNmYmRURW5MeHBJOGtvdmxFL0REMmZ3?=
 =?utf-8?B?bmlIZEdEQkFocnBJMnp2Rmx2Tml5U2I1OFFISDk0bWNQYlQvRm90RUFmUUhY?=
 =?utf-8?B?bVVpUVVhaVYwNTdsQ3lRaEd4MFQyejlrR3BDT0xOM3hTUUlKTmlmVFErYVZq?=
 =?utf-8?B?MlFrMS9ITGhoY3hNcEd5clRwQXlRQXdhUWQ2b3JCMm5ycEYyVEE4UjNpb3hz?=
 =?utf-8?B?ZTQ1cFJoeXZ6YW9zdGhxK3Z1WWZ4ZEdDdUlVRjZ1NmE1NkFxZDFtU3A3aWVR?=
 =?utf-8?B?M2pMaUVsdkdNNG43cVRqQS9pSW9zdVdiMmVLNjlOeFFUcDVwUlBvcjcrQjBh?=
 =?utf-8?B?d0ZjUlpCcmhINVlJczZrNFcrMGkvQTFTV1BSZFV2RmZ5bGNHeXFhY2svYk1q?=
 =?utf-8?B?cjB2SnRMMWZjNDNac3N2bWMvV0dwK21yMnJFSDU0ZjV5NEpTcnkrRURiYjRX?=
 =?utf-8?B?eW9DV0k2YXVJem5OU1J0L3dLSXg4Q3FHZkFvREpQdlczSVdldUxmMU1PT3Uv?=
 =?utf-8?B?a3NLZVFOTXJzQUtkVldqRXg3ak9aNXRhellEcit2aUJhbG1va3JYenYxcXpU?=
 =?utf-8?B?cnJNQ2VDQ0p3QmxoZm1iV2VkOXFEbk1lcWMyQ3ZXemdFUFBrYmIxU3RqSEww?=
 =?utf-8?B?MTFZWUpubWhML09DeTRoZ1RXSUFCOGR5Uklra1hyZFl1S2MwM3JacG1SSmh6?=
 =?utf-8?B?Kzk1UDl1Ky9hTTVvNE1nNE1VaFh3czlpN3h3Sk84R2lsRjFGRzRRaXBRSko3?=
 =?utf-8?B?emlDUkQxamdhRXpIZU1NNjJzeTEyNTBtK3c5aWZONjlvNno2UGpYQUh0VG5P?=
 =?utf-8?B?ZUJvd3diNWpra1YwT3Yzc2NoNjh2UEZaeVRzZEFITDdYSlVkQU4vaHQxVEdS?=
 =?utf-8?Q?T5+wGdlGhv0tWPCS94?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d218483-e098-4a21-366e-08de54e67836
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 10:03:17.0729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsfZ6lXAdKNd8h9cQ3RaeA0ZTr0VkdqnQFrEE9tYY7oGOxLmhYvD2OwhQBQBS783
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989
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

On 1/16/26 02:20, Tiezhu Yang wrote:
> On 2026/1/15 下午9:47, Christian König wrote:
>> On 1/15/26 02:28, Tiezhu Yang wrote:
>>> Currently, there are many Call Traces when booting kernel on LoongArch,
>>> here are the trimmed kernel log messages:
>>>
>>>    amdgpu 0000:07:00.0: amdgpu: hw_init of IP block <gfx_v6_0> failed -110
>>>    amdgpu 0000:07:00.0: amdgpu: amdgpu_device_ip_init failed
>>>    amdgpu 0000:07:00.0: amdgpu: Fatal error during GPU init
>>>    amdgpu 0000:07:00.0: amdgpu: amdgpu: finishing device.
>>>    ------------[ cut here ]------------
>>>    WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 at amdgpu_irq_put+0xb0/0x140 [amdgpu], CPU#0: kworker/0:0/9
>>>    ...
>>>    Call Trace:
>>>    [<90000000047a8524>] show_stack+0x64/0x190
>>>    [<90000000047a0614>] dump_stack_lvl+0x6c/0x9c
>>>    [<90000000047cef34>] __warn+0xa4/0x1b0
>>>    [<90000000060a4884>] __report_bug+0xa4/0x1d0
>>>    [<90000000060a4a88>] report_bug+0x38/0xd0
>>>    [<90000000060df330>] do_bp+0x260/0x410
>>>    [<90000000047a6bc0>] handle_bp+0x120/0x1c0
>>>    [<ffff8000028bff40>] amdgpu_irq_put+0xb0/0x140 [amdgpu]
>>>    [<ffff8000027b1a8c>] amdgpu_fence_driver_hw_fini+0x12c/0x180 [amdgpu]
>>>    [<ffff800002f2c04c>] amdgpu_device_fini_hw+0xf0/0x3fc [amdgpu]
>>>    [<ffff80000279e2ac>] amdgpu_driver_load_kms+0x7c/0xa0 [amdgpu]
>>>    [<ffff800002791128>] amdgpu_pci_probe+0x298/0x810 [amdgpu]
>>>    [<90000000054d04a4>] local_pci_probe+0x44/0xc0
>>>    [<90000000047f4ab0>] work_for_cpu_fn+0x20/0x40
>>>    [<90000000047f93e0>] process_one_work+0x170/0x4e0
>>>    [<90000000047fa14c>] worker_thread+0x3ac/0x4e0
>>>    [<9000000004806824>] kthread+0x154/0x170
>>>    [<90000000060df5b4>] ret_from_kernel_thread+0x24/0xd0
>>>    [<90000000047a62a4>] ret_from_kernel_thread_asm+0xc/0x88
>>>
>>>    ---[ end trace 0000000000000000 ]---
>>>    amdgpu 0000:07:00.0: probe with driver amdgpu failed with error -110
>>>    amdgpu 0000:07:00.0: amdgpu: amdgpu: ttm finalized
>>>
>>> This is because amdgpu_irq_enabled() is false in amdgpu_irq_put(), then
>>> the condition of WARN_ON() is true.
>>>
>>> In order to avoid the unnecessary Call Traces, it can remove the check of
>>> amdgpu_irq_enabled() and only check atomic_read(&src->enabled_types[type]
>>> for three reasons:
>>>
>>> (1) The aim is to prevent refcount from being less than 0, it was added in
>>> commit 1fa8d710573f ("drm/amdgpu: Fix desktop freezed after gpu-reset").
>>> (2) There are already many useful failed log before the Call Trace, there
>>> is no need to WARN_ON().
>>
>> Well completely disagree. The call trace here is absolutely intentional.
> 
> If so, since the call trace is same, is it enough to use WARN_ON_ONCE()
> here?

I also don't see a justification for that.

>> That you get a lot of other backtraces because the driver doesn't initialize at all isn't a good rational to remove this one here.
>>
>> Regards,
>> Christian.
>>
>>> (3) The following checks in amdgpu_irq_put() are same with the checks in
>>> amdgpu_irq_enabled(), there is no need to do the redundant operations.
>>>
>>>     if (!adev->irq.installed)
>>>         return -ENOENT;
>>>
>>>     if (type >= src->num_types)
>>>         return -EINVAL;
>>>
>>>     if (!src->enabled_types || !src->funcs->set)
>>>         return -EINVAL;
> 
> Is this reasonable? Only check atomic_read(&src->enabled_types[type]?

No, absolutely not. That are two completely different things.

> That is to say, does it make sense to do the following change?

The warning can basically only be triggered by two conditions:
1. A fatal problem while loading the driver and the error handling is not 100% clean.
2. A driver coding error.

And we really need to catch all of those, so there is no real rational to limit the warning.

I mean when you run into any of those they should potentially be fixed at some point.

Regards,
Christian.

> 
> ----->8-----
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 8112ffc85995..d10d6fcc525e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -636,7 +636,7 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
>         if (!src->enabled_types || !src->funcs->set)
>                 return -EINVAL;
> 
> -       if (WARN_ON(!amdgpu_irq_enabled(adev, src, type)))
> +       if (WARN_ON_ONCE(!atomic_read(&src->enabled_types[type])))
>                 return -EINVAL;
> 
>         if (atomic_dec_and_test(&src->enabled_types[type]))
> 
> Thanks,
> Tiezhu
> 

