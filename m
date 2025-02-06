Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50548C02199
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 13:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED29010E836;
	Thu,  6 Feb 2025 13:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hH4nujyt";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6710A10E830
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 13:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTj8se9CVMJFZ3B3fCyq9sTsIhoJpwR3IHHd4UEjEj54DyMEMqwZZH7MMkE5zLfktWVBKqgu64CBU+t5kW0yG9syDKiwBqeGgqC5tVIL8GTZoq9y6yW+1La7Gzm2peuvPohjSsSY4Gs79rOBMTuZK9U2nJR1uZ4Jj0EkClHD73AccPhdM4dzoNAkfnItwWPbuSBmSEzj64tOisZLHjqfmFs7JufGlt9Z9WKvTtD17A/IZKFNAm5by41msE3qTVoXxbeidIP6luVDNAsvZirgiIDEuqIroFvu3EAe+GVPWb/mwyPFHufa46ueBCYu19agMYFqyPf2EOf1W4t/mBoNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SHWwgG/sC4H/4jfCBXW0eZ00zCy9hpBLFZsBCQMGzI=;
 b=LSRP+H+O6IWPECydUEBExtJK6SHAhf1A5qr4UuJT8Yoeij6ZabWbbTczCuwBGBXifcE9K04EabJBJmmitaIMqLpeRAQPkGc0DMKjFCcez/wpCoAhkKuTAlQ505PcLH4tmn86qY/9rmlTjtbn1dbW+R5vyCHWup1zQDarcOl8Vk8LoGpSsQSGY/mHCGZbZjY0wHXhqVueQXqnWNnB5TNT8k1KMGNAwaNc8e9FFLp1A0HFLM2RgAryvdCrU5TEi9y5E/w4FWCc2+AlHtTHf+3zqSUfqlhz5VUiD1dz7R4UlhEDPTBgeWYnHwTxJhlCj5P/keNUgUhVicoID8bUiCdfaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SHWwgG/sC4H/4jfCBXW0eZ00zCy9hpBLFZsBCQMGzI=;
 b=hH4nujytbWLTCTARcbIrmntrXUTTQhPIJunKbniQd6QhaxFhuAvuS9vXBu95CquYNns6YzUjbbBGMTzBVhkSMmTpvsP+h2PWFevCp+E/O/B7xb0E3IRYxeSXQ2HSPl/pvTnERPSL/0qTnGX7omaFzvSVk9iY+wmuvKbYmz2MPnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 13:40:17 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 13:40:17 +0000
Content-Type: multipart/alternative;
 boundary="------------aWxp0yk0XE9kKCjFHQJJ2G0a"
Message-ID: <a5edf25f-3718-417c-b68a-5e4d1c851685@amd.com>
Date: Thu, 6 Feb 2025 08:40:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/44] drm/amdgpu/vcn: adjust pause_dpg_mode function
 signature
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-22-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-22-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBPR0101CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::24) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: f7990437-5711-4e82-485d-08dd46b3cade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDFJU2djc0NhUCtCbUlUaXZZYlc2UEtPOUE0V3E1YzBRVFZ6M2NJbCtTZTJS?=
 =?utf-8?B?Wm94dzhZTDAzWUlLVHg3THhMTnU0R0R5SHo1REZHS2NXNjZ6OFdMRzZhczZQ?=
 =?utf-8?B?cGVrSFZKQk94NWx6OUdTQ002Z3E3ck5PQTVpK2dLandSalFFTkNOZGJqa01s?=
 =?utf-8?B?bUJZTGFnNXo1dTArSDNYd050QmNzTDV5SjFNcXN5Zm12YW51NThHMWJva0dJ?=
 =?utf-8?B?YmdHeE5HM2NVM2phS3VsanliNVQxZTM0MFVqSE1qV2xWNDNtU0pTTTZPQ2h4?=
 =?utf-8?B?K0U0SXRvUVNicGZYMmJ0ckNQUGp0V2FXbWVYK1M3Ylk5ZmJxSW1sTEpFcUJP?=
 =?utf-8?B?SFdVRWIraHc5bXlSRVRSbml1SytmbHB3ckFXVG1hR3FVL2FUeU51MGNwQncr?=
 =?utf-8?B?dWdoNVZhcVBYS1MrdGgxZnpRRFdvd1ZpVC9QS3RRaWZwK2Y1Q3ZXMUJaenlM?=
 =?utf-8?B?MWpmeUp6UjRmYmVVT0p4bVZ6UlFmWlJuamhtVmUrOTB6TjdSN2ZIV2Qwb3FO?=
 =?utf-8?B?TzFUc0IrUFNRbGZXZDVVSkVOblR1NWNOYm9yaXJtMjdCTmJYWnBCR3VFZi9Z?=
 =?utf-8?B?SmU4Unc5azJSa2pFNHhXRERzK0VoOFQzQVdyRFZNbTNidDQ4SmRFNURzQ0to?=
 =?utf-8?B?WS9kWGczK3dYcFhvbjNzWHVBWEtTdUJQQ2NSQXZISk8vWXMwZEVGa3dKU0JM?=
 =?utf-8?B?Ty8xdlMvcERlQXN4dmxVUTlVSUs1MkQwZGpGSDB5QkdDMUdRSHlyWHVWcnZ5?=
 =?utf-8?B?UzFmQ0lERlZudVVrMTJ5L3BYSEdZcnNrVXhZTGoybUs5MkRZTFM2YUlEWkpi?=
 =?utf-8?B?b1U3UVhrNjZwSjZ6TFMrQlVwaUlJREJCblhncTh2c3BacEU2V1BnNU10Y1lm?=
 =?utf-8?B?MVZ6Nzc4bUtoUVQ1eHU5SUdmUU5FVWhUbXNpdytidDZEQWpjbFpXVkVLS2Ur?=
 =?utf-8?B?cFBoR2hMZTJ4Q3htZmYyQkFES0krSDIvV1VkYUxnOU1PNDhLNFA3am5SUVF6?=
 =?utf-8?B?MTJEVTYvWXgzRDBLbHVpOXpRN2VNcnF4NEkyRCttTjAzWjBveHowU3dNdHVz?=
 =?utf-8?B?Y3JRSVRtRW54OW9GS2FHa1NJYldyNkdDMlhuNkxENElMRVVXdXdRaE9VSjc1?=
 =?utf-8?B?cGY3N01iKzdBYzVyZS85azI1S1NMdGg3c2lueDlrMks3SkpYTDE2Qy80MmFv?=
 =?utf-8?B?MXFsc1JKYmFIdVBubXJreEtBY1hJeStsSjlvNllkMDBrdWdKNkhWWmpNNHVT?=
 =?utf-8?B?c1cyU1lYVWNPZVllcVhxY2p5M0dUUkg0MnBOY0FIYVh6L2VKQVdQY1pIMVBj?=
 =?utf-8?B?ZHBSUDBaZVFBS0xYU2JLdStuTjVTem1UUWNTWVdOQXV5ZnB5cXlKMW5WOXF5?=
 =?utf-8?B?bnVINW5ESlE2MW1aOGlQUGt0OVBQVjJNYVE2L1NGdWtBVXVLT2ZmenF3U0Qx?=
 =?utf-8?B?RGoyOEd3TmVXMnZYV2V2ZFVEeDdyYTlpSFllWVVDa1FMRWdRNmQrUjYrS0V2?=
 =?utf-8?B?aFlmVnFQM3pCcFFOemREU3kvWTJFT3pQYkNOQ0owaVF3VGlheXJCYzBoM21z?=
 =?utf-8?B?czVSTWw2NEZnL3FCMy9VY3lvRzB0SXcxUHY2bXBZZG9xMDNqbVhTbEF2OWlZ?=
 =?utf-8?B?enNuZzZzRm9MK0tLUFY3MXozdUxSQVhaNmF6V3BXOG5yWEJ0OEhIY0xEQWZS?=
 =?utf-8?B?eFBPeUdQRGVqSi9WWGhxQnFxUGMwOEh2bnZ1Y3JaWk5sSXRwNW80NzRnMUx3?=
 =?utf-8?B?VmpYQUpnWUNKQVpYVmYraGVKd3k4TGRpL3YvN0hxdU4zYXJFeFpmajFnamQ1?=
 =?utf-8?B?TXRXWVVJa1p1dFZDNUkzQmhIOFBEUy9tcXFQMVlGd3p1NXl0b1Zmc2VZcjFP?=
 =?utf-8?Q?Ti0Jqm1JG97X7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVY3QkhaZVUwTkVBd2pvQUd3U2ZiSFlMQnNZOEI4dWdFVGllSEpNaks0a0ZF?=
 =?utf-8?B?REhkMGVBZlFnNytDTTFtcTU2VkFScFZXemZrZlY2VFlzMlZYU2dSbzA2VDBS?=
 =?utf-8?B?NG1GSkNHZHFhU2hXM0FHZmVQZkhMNTc4UlZLaVgrOVBaLzRnT0MzWmlHMVh1?=
 =?utf-8?B?dkFHWUJPSUZpcUVXc29ZaWFyL0JiU0FLOU5CcVlHR1VWbTVHdHI1UTRxU2Za?=
 =?utf-8?B?UXRCTWRTb3pYY2R0U1FBdHFldCt3emNkanNCblRVL2NleHQvNmZNMjdheGFw?=
 =?utf-8?B?M2E1eVMzZkkzZTBzUWlBdWphOUhCdXBjVXlmdEtkN1M5bWcyR3FoQnNsQWIr?=
 =?utf-8?B?OVZBSDBlR3hlZkhNTHhHOStxam42dFRRV0dPNWJEVGhidjU5MEx1VUt6UDB4?=
 =?utf-8?B?S3JFbnI1QWwyOVRvcFF0dHJDYkdQbVJLR3NtQ0F4aWRzaTBZZmhwMk1MWU9D?=
 =?utf-8?B?RTErQWNKUURPWmJXMXgvcGdGamZidU1pQ2hSOG1NUk50ZnFJc0U2NHZtc25S?=
 =?utf-8?B?NEhXb3ZiUG9DbUN0eEk2WW9ta0pXM3dMaGs5ejhWZStoMmdsQjdqZkZkay9D?=
 =?utf-8?B?NVg3Zkd4S2xEZ0xvRnpsOVNWUXdBOHZYUzR0aEtWdFltbGU0c1B5ZTIyRmo2?=
 =?utf-8?B?MlJiMDNxTk5oT0ExNHZZNFdPQXU0QlI4UERJVGVvcGJ2ZmJOMEUvWDdaWGVX?=
 =?utf-8?B?WGs5RTlBcFhTRWJBVnZ1cGFpQTdEWSt1alJMOU1CRDlMdGZlWW42bFRja3F1?=
 =?utf-8?B?RU5ENGNnV3pNYmp1SUs4ZXJsemRGM0Nzamd2SkFQN3llN2NKMkdLWU9Ba0du?=
 =?utf-8?B?NzYwYVh5RkdJayt2YVhITlFYOG9yeVAveVprNVE4WEtGSlZCSTAwT01oLzFT?=
 =?utf-8?B?WEx6NjJGQmZlUTdkOFBMUjZOb2xyV3JwVlBmMEFtNkRrWkt2SUV2T3FZK0Vu?=
 =?utf-8?B?WSt5elNuYXpaa1NXMlp1RzI3Q0kvbEZNZFVZZkRaakl6WU5QRVZLdXJXWWF6?=
 =?utf-8?B?TDREQ0xrazY5bXZrdVVvV3BvUGtubG9DN2dwRDg3bFVBSTR6T3Vuakw0bEtI?=
 =?utf-8?B?dGJHRHRKRTl1aHBhakhSMVZkUC9SdzZHMEFNaHdUdGJnK2hYQ0RUL2UwUENo?=
 =?utf-8?B?a2Frb3Y4N2pJQmJXamhHSzZtaFk2SURFeEZSY2ZrbklCOEQ1cGZoTWtHd1dh?=
 =?utf-8?B?czZtbnhlcFNlS0cyVE5kaGtCRFhFY2g5NENLa1JwK096dXcwTCtnUHB4bS90?=
 =?utf-8?B?RFF0Ry9XWTQxZVdlQWJLUEJQeHU0cDlZck5Jbmp1SGNDb2RzNVNOT3pIaGFy?=
 =?utf-8?B?ZXhuc3BuTUJqOFFXbTZUMkpXRHltd0NTejAxak4zK0JGd2J3WlpDUnhGRG41?=
 =?utf-8?B?MWlrejZqVXRuRTJxSWkxWmEweFhNNDNha1AzZEtHRVZ1MDFuVEQvMWx2cXZO?=
 =?utf-8?B?UngwQ0dBeEtQNWY1V1VBR0p1Rk1lMGZzWXhQUE1BTmxtZm1nMzA0RERjMko2?=
 =?utf-8?B?U0ZualNQaERRVkhreWhmbjJLWXZvWUVzMDRTdEdKak5Yekt5Wmxsc1ljTDMz?=
 =?utf-8?B?RFFkS04xMC9acVlOWG9MdVhpR3dXMkZGN29YN1VSY2h5ZURiTFhtaTJ3bDJn?=
 =?utf-8?B?d01vOWQ1OWV6U3daekUyQy9GcHpMTVk2NlNLSDJQZFJwTWhLWDVqb1lWR1pL?=
 =?utf-8?B?azdJbHpVRC9Fdm9rcU94SXhvU1RzZjRvTUVmdml0NVJvWmZZQWVOZXEzbGp2?=
 =?utf-8?B?ZWIvazRKbE9kcmthY09nWWlPeDNVWS9WQ0JaWmVvYU8vTUhCaVMvV25kb2RC?=
 =?utf-8?B?YXpWSFoxcjlpQnpnL3NEMWt1N2pBT3pxaXpPalZEUmpQVDVSeTNsQWRwVTdU?=
 =?utf-8?B?M1hVdlZ2Sk9NZ0hsYUYvdWhJaVJzVkZJV1VDdXAzZzRMM1pjY29HaSs1d0dI?=
 =?utf-8?B?ZlZEeThTYnhRd0JoTmVtbGJjS2p3cW5jZXpRbTRJbVNnZmhmWDR0ZHZZUmgv?=
 =?utf-8?B?elZJZnBicWZQUkMxUU00dU1ub1V2NHYyazJsWko4aTZLM0NtR0djd0lZelAr?=
 =?utf-8?B?RUMwcjk2V0Q1aXR0Yk5kVG5haGJRcitJbE0waGdoY2tPSkxZd0x3NmlDOTN3?=
 =?utf-8?Q?wCj5JPkenHiIJttxaaC3XiBm7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7990437-5711-4e82-485d-08dd46b3cade
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:40:17.4992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dA9gT59uVvm5+pnRrVTvJrHvQRFXTEp+4VB65hQ/r/r6y5pWGyxA5iPujHCv3Wg57m1MqYW+THJPWFJDFZB6cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410
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

--------------aWxp0yk0XE9kKCjFHQJJ2G0a
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Change it to take a vcn instance rather than adev to align
> with the vcn instance changes.
>
> TODO: clean up the function internals to use the vinst state
> directly rather than accessing it indirectly via adev->vcn.inst[].
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +--
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 14 ++++++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 12 +++++++-----
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 10 ++++++----
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 12 +++++++-----
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 15 ++++++++-------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 11 +++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 13 +++++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 15 ++++++++-------
>   10 files changed, 59 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 010cc64a950a4..a2250747a7c81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -417,7 +417,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   		else
>   			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>   
> -		adev->vcn.inst[i].pause_dpg_mode(adev, i, &new_state);
> +		adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>   	}
>   
>   	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
> @@ -474,7 +474,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>   		}
>   
> -		adev->vcn.inst[ring->me].pause_dpg_mode(adev, ring->me, &new_state);
> +		adev->vcn.inst[ring->me].pause_dpg_mode(&adev->vcn.inst[ring->me], &new_state);
>   	}
>   	mutex_unlock(&adev->vcn.inst[ring->me].vcn_pg_lock);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 5f92cf28cc752..8d34e3814ab19 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -327,8 +327,7 @@ struct amdgpu_vcn_inst {
>   	bool			indirect_sram;
>   	struct amdgpu_vcn_reg	 internal;
>   	struct mutex		vcn1_jpeg1_workaround;
> -	int (*pause_dpg_mode)(struct amdgpu_device *adev,
> -			      int inst_idx,
> +	int (*pause_dpg_mode)(struct amdgpu_vcn_inst *vinst,
>   			      struct dpg_pause_state *new_state);
>   	bool using_unified_queue;
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 613f17be9d829..3d56660fd90a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -87,8 +87,8 @@ static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
>   static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				enum amd_powergating_state state);
> -static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
> -				int inst_idx, struct dpg_pause_state *new_state);
> +static int vcn_v1_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				   struct dpg_pause_state *new_state);
>   
>   static void vcn_v1_0_idle_work_handler(struct work_struct *work);
>   static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring);
> @@ -1264,9 +1264,11 @@ static int vcn_v1_0_stop(struct amdgpu_vcn_inst *vinst)
>   	return r;
>   }
>   
> -static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
> -				int inst_idx, struct dpg_pause_state *new_state)
> +static int vcn_v1_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				   struct dpg_pause_state *new_state)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	int ret_code;
>   	uint32_t reg_data = 0;
>   	uint32_t reg_data2 = 0;
> @@ -1866,7 +1868,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
>   		else
>   			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
>   
> -		adev->vcn.inst[0].pause_dpg_mode(adev, 0, &new_state);
> +		adev->vcn.inst->pause_dpg_mode(vcn_inst, &new_state);
>   	}
>   
>   	fences += amdgpu_fence_count_emitted(adev->jpeg.inst->ring_dec);
> @@ -1933,7 +1935,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
>   		else if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_JPEG)
>   			new_state.jpeg = VCN_DPG_STATE__PAUSE;
>   
> -		adev->vcn.inst[0].pause_dpg_mode(adev, 0, &new_state);
> +		adev->vcn.inst->pause_dpg_mode(adev->vcn.inst, &new_state);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index aa61d3b54f8c2..e4305687749a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -94,8 +94,8 @@ static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev);
>   static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   				enum amd_powergating_state state);
> -static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
> -				int inst_idx, struct dpg_pause_state *new_state);
> +static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				   struct dpg_pause_state *new_state);
>   static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
>   /**
>    * vcn_v2_0_early_init - set function pointers and load microcode
> @@ -1158,7 +1158,7 @@ static int vcn_v2_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>   	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
>   	uint32_t tmp;
>   
> -	vcn_v2_0_pause_dpg_mode(adev, 0, &state);
> +	vcn_v2_0_pause_dpg_mode(vinst, &state);
>   	/* Wait for power status to be 1 */
>   	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS, 1,
>   		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> @@ -1252,9 +1252,11 @@ static int vcn_v2_0_stop(struct amdgpu_vcn_inst *vinst)
>   	return 0;
>   }
>   
> -static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
> -				int inst_idx, struct dpg_pause_state *new_state)
> +static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				   struct dpg_pause_state *new_state)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	struct amdgpu_ring *ring;
>   	uint32_t reg_data = 0;
>   	int ret_code;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 69cf42a4a3f18..d5921a954948e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -100,8 +100,8 @@ static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
>   					       int i);
>   static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state);
> -static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
> -				int inst_idx, struct dpg_pause_state *new_state);
> +static int vcn_v2_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				   struct dpg_pause_state *new_state);
>   static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
>   static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev);
>   
> @@ -1506,9 +1506,11 @@ static int vcn_v2_5_stop(struct amdgpu_vcn_inst *vinst)
>   	return 0;
>   }
>   
> -static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
> -				int inst_idx, struct dpg_pause_state *new_state)
> +static int vcn_v2_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				   struct dpg_pause_state *new_state)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	struct amdgpu_ring *ring;
>   	uint32_t reg_data = 0;
>   	int ret_code = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index f6f4f04d74339..2a17a7e108001 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -110,8 +110,8 @@ static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
>   					       int i);
>   static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state);
> -static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
> -			int inst_idx, struct dpg_pause_state *new_state);
> +static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				   struct dpg_pause_state *new_state);
>   
>   static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
>   static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
> @@ -1581,7 +1581,7 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>   	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
>   	uint32_t tmp;
>   
> -	vcn_v3_0_pause_dpg_mode(adev, inst_idx, &state);
> +	vcn_v3_0_pause_dpg_mode(vinst, &state);
>   
>   	/* Wait for power status to be 1 */
>   	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
> @@ -1680,9 +1680,11 @@ static int vcn_v3_0_stop(struct amdgpu_vcn_inst *vinst)
>   	return 0;
>   }
>   
> -static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
> -		   int inst_idx, struct dpg_pause_state *new_state)
> +static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				   struct dpg_pause_state *new_state)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	volatile struct amdgpu_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t reg_data = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 3d70e2cc81982..2ad217470c8c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -101,8 +101,8 @@ static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
>   					       int i);
>   static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state);
> -static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
> -        int inst_idx, struct dpg_pause_state *new_state);
> +static int vcn_v4_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				   struct dpg_pause_state *new_state);
>   static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
>   static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev);
>   
> @@ -1565,7 +1565,7 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>   	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
>   	uint32_t tmp;
>   
> -	vcn_v4_0_pause_dpg_mode(adev, inst_idx, &state);
> +	vcn_v4_0_pause_dpg_mode(vinst, &state);
>   	/* Wait for power status to be 1 */
>   	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 1,
>   		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> @@ -1671,15 +1671,16 @@ static int vcn_v4_0_stop(struct amdgpu_vcn_inst *vinst)
>   /**
>    * vcn_v4_0_pause_dpg_mode - VCN pause with dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    * @new_state: pause state
>    *
>    * Pause dpg mode for VCN block
>    */
> -static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev, int inst_idx,
> -      struct dpg_pause_state *new_state)
> +static int vcn_v4_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				   struct dpg_pause_state *new_state)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t reg_data = 0;
>   	int ret_code;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index a3fbfaac76603..ae7733c0d032e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -92,8 +92,8 @@ static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
>   						 int i);
>   static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					    enum amd_powergating_state state);
> -static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
> -		int inst_idx, struct dpg_pause_state *new_state);
> +static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				     struct dpg_pause_state *new_state);
>   static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
>   static void vcn_v4_0_3_set_ras_funcs(struct amdgpu_device *adev);
>   static void vcn_v4_0_3_enable_ras(struct amdgpu_device *adev,
> @@ -1449,14 +1449,13 @@ static int vcn_v4_0_3_stop(struct amdgpu_vcn_inst *vinst)
>   /**
>    * vcn_v4_0_3_pause_dpg_mode - VCN pause with dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    * @new_state: pause state
>    *
>    * Pause dpg mode for VCN block
>    */
> -static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev, int inst_idx,
> -				struct dpg_pause_state *new_state)
> +static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				     struct dpg_pause_state *new_state)
>   {
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 295f39b2222d5..a00c74d287a69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -100,8 +100,8 @@ static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
>   						 int i);
>   static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					    enum amd_powergating_state state);
> -static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
> -		int inst_idx, struct dpg_pause_state *new_state);
> +static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				     struct dpg_pause_state *new_state);
>   static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
>   
>   /**
> @@ -1321,15 +1321,16 @@ static int vcn_v4_0_5_stop(struct amdgpu_vcn_inst *vinst)
>   /**
>    * vcn_v4_0_5_pause_dpg_mode - VCN pause with dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    * @new_state: pause state
>    *
>    * Pause dpg mode for VCN block
>    */
> -static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev, int inst_idx,
> -		struct dpg_pause_state *new_state)
> +static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				     struct dpg_pause_state *new_state)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t reg_data = 0;
>   	int ret_code;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index a71960d899e38..91b57b86dc58a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -83,8 +83,8 @@ static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
>   						 int i);
>   static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					    enum amd_powergating_state state);
> -static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
> -		int inst_idx, struct dpg_pause_state *new_state);
> +static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				     struct dpg_pause_state *new_state);
>   static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
>   
>   /**
> @@ -961,7 +961,7 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>   	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
>   	uint32_t tmp;
>   
> -	vcn_v5_0_0_pause_dpg_mode(adev, inst_idx, &state);
> +	vcn_v5_0_0_pause_dpg_mode(vinst, &state);
>   
>   	/* Wait for power status to be 1 */
>   	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 1,
> @@ -1064,15 +1064,16 @@ static int vcn_v5_0_0_stop(struct amdgpu_vcn_inst *vinst)
>   /**
>    * vcn_v5_0_0_pause_dpg_mode - VCN pause with dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    * @new_state: pause state
>    *
>    * Pause dpg mode for VCN block
>    */
> -static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev, int inst_idx,
> -	struct dpg_pause_state *new_state)
> +static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				     struct dpg_pause_state *new_state)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t reg_data = 0;
>   	int ret_code;
>   
--------------aWxp0yk0XE9kKCjFHQJJ2G0a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-22-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Change it to take a vcn instance rather than adev to align
with the vcn instance changes.

TODO: clean up the function internals to use the vinst state
directly rather than accessing it indirectly via adev-&gt;vcn.inst[].

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="mark5quw442ch" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-22-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 14 ++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 12 +++++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 12 +++++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 15 ++++++++-------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 13 +++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 15 ++++++++-------
 10 files changed, 59 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 010cc64a950a4..a2250747a7c81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -417,7 +417,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 		else
 			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-		adev-&gt;vcn.inst[i].pause_dpg_mode(adev, i, &amp;new_state);
+		adev-&gt;vcn.inst[i].pause_dpg_mode(vcn_inst, &amp;new_state);
 	}
 
 	fence[i] += amdgpu_fence_count_emitted(&amp;vcn_inst-&gt;ring_dec);
@@ -474,7 +474,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 		}
 
-		adev-&gt;vcn.inst[ring-&gt;me].pause_dpg_mode(adev, ring-&gt;me, &amp;new_state);
+		adev-&gt;vcn.inst[ring-&gt;me].pause_dpg_mode(&amp;adev-&gt;vcn.inst[ring-&gt;me], &amp;new_state);
 	}
 	mutex_unlock(&amp;adev-&gt;vcn.inst[ring-&gt;me].vcn_pg_lock);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 5f92cf28cc752..8d34e3814ab19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -327,8 +327,7 @@ struct amdgpu_vcn_inst {
 	bool			indirect_sram;
 	struct amdgpu_vcn_reg	 internal;
 	struct mutex		vcn1_jpeg1_workaround;
-	int (*pause_dpg_mode)(struct amdgpu_device *adev,
-			      int inst_idx,
+	int (*pause_dpg_mode)(struct amdgpu_vcn_inst *vinst,
 			      struct dpg_pause_state *new_state);
 	bool using_unified_queue;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 613f17be9d829..3d56660fd90a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -87,8 +87,8 @@ static void vcn_v1_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
-static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
-				int inst_idx, struct dpg_pause_state *new_state);
+static int vcn_v1_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state);
 
 static void vcn_v1_0_idle_work_handler(struct work_struct *work);
 static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring);
@@ -1264,9 +1264,11 @@ static int vcn_v1_0_stop(struct amdgpu_vcn_inst *vinst)
 	return r;
 }
 
-static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
-				int inst_idx, struct dpg_pause_state *new_state)
+static int vcn_v1_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	int ret_code;
 	uint32_t reg_data = 0;
 	uint32_t reg_data2 = 0;
@@ -1866,7 +1868,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 		else
 			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
 
-		adev-&gt;vcn.inst[0].pause_dpg_mode(adev, 0, &amp;new_state);
+		adev-&gt;vcn.inst-&gt;pause_dpg_mode(vcn_inst, &amp;new_state);
 	}
 
 	fences += amdgpu_fence_count_emitted(adev-&gt;jpeg.inst-&gt;ring_dec);
@@ -1933,7 +1935,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 		else if (ring-&gt;funcs-&gt;type == AMDGPU_RING_TYPE_VCN_JPEG)
 			new_state.jpeg = VCN_DPG_STATE__PAUSE;
 
-		adev-&gt;vcn.inst[0].pause_dpg_mode(adev, 0, &amp;new_state);
+		adev-&gt;vcn.inst-&gt;pause_dpg_mode(adev-&gt;vcn.inst, &amp;new_state);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index aa61d3b54f8c2..e4305687749a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -94,8 +94,8 @@ static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
-static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
-				int inst_idx, struct dpg_pause_state *new_state);
+static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state);
 static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
 /**
  * vcn_v2_0_early_init - set function pointers and load microcode
@@ -1158,7 +1158,7 @@ static int vcn_v2_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
-	vcn_v2_0_pause_dpg_mode(adev, 0, &amp;state);
+	vcn_v2_0_pause_dpg_mode(vinst, &amp;state);
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS, 1,
 		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
@@ -1252,9 +1252,11 @@ static int vcn_v2_0_stop(struct amdgpu_vcn_inst *vinst)
 	return 0;
 }
 
-static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
-				int inst_idx, struct dpg_pause_state *new_state)
+static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	struct amdgpu_ring *ring;
 	uint32_t reg_data = 0;
 	int ret_code;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 69cf42a4a3f18..d5921a954948e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -100,8 +100,8 @@ static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 					       int i);
 static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state);
-static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
-				int inst_idx, struct dpg_pause_state *new_state);
+static int vcn_v2_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state);
 static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
 static void vcn_v2_5_set_ras_funcs(struct amdgpu_device *adev);
 
@@ -1506,9 +1506,11 @@ static int vcn_v2_5_stop(struct amdgpu_vcn_inst *vinst)
 	return 0;
 }
 
-static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
-				int inst_idx, struct dpg_pause_state *new_state)
+static int vcn_v2_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	struct amdgpu_ring *ring;
 	uint32_t reg_data = 0;
 	int ret_code = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index f6f4f04d74339..2a17a7e108001 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -110,8 +110,8 @@ static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 					       int i);
 static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state);
-static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
-			int inst_idx, struct dpg_pause_state *new_state);
+static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state);
 
 static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
 static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
@@ -1581,7 +1581,7 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
-	vcn_v3_0_pause_dpg_mode(adev, inst_idx, &amp;state);
+	vcn_v3_0_pause_dpg_mode(vinst, &amp;state);
 
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
@@ -1680,9 +1680,11 @@ static int vcn_v3_0_stop(struct amdgpu_vcn_inst *vinst)
 	return 0;
 }
 
-static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
-		   int inst_idx, struct dpg_pause_state *new_state)
+static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	volatile struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t reg_data = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 3d70e2cc81982..2ad217470c8c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -101,8 +101,8 @@ static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
 					       int i);
 static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state);
-static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
-        int inst_idx, struct dpg_pause_state *new_state);
+static int vcn_v4_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state);
 static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static void vcn_v4_0_set_ras_funcs(struct amdgpu_device *adev);
 
@@ -1565,7 +1565,7 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
-	vcn_v4_0_pause_dpg_mode(adev, inst_idx, &amp;state);
+	vcn_v4_0_pause_dpg_mode(vinst, &amp;state);
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 1,
 		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
@@ -1671,15 +1671,16 @@ static int vcn_v4_0_stop(struct amdgpu_vcn_inst *vinst)
 /**
  * vcn_v4_0_pause_dpg_mode - VCN pause with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @new_state: pause state
  *
  * Pause dpg mode for VCN block
  */
-static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev, int inst_idx,
-      struct dpg_pause_state *new_state)
+static int vcn_v4_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				   struct dpg_pause_state *new_state)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t reg_data = 0;
 	int ret_code;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index a3fbfaac76603..ae7733c0d032e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -92,8 +92,8 @@ static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 						 int i);
 static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state);
-static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
-		int inst_idx, struct dpg_pause_state *new_state);
+static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     struct dpg_pause_state *new_state);
 static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
 static void vcn_v4_0_3_set_ras_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_enable_ras(struct amdgpu_device *adev,
@@ -1449,14 +1449,13 @@ static int vcn_v4_0_3_stop(struct amdgpu_vcn_inst *vinst)
 /**
  * vcn_v4_0_3_pause_dpg_mode - VCN pause with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @new_state: pause state
  *
  * Pause dpg mode for VCN block
  */
-static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev, int inst_idx,
-				struct dpg_pause_state *new_state)
+static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     struct dpg_pause_state *new_state)
 {
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 295f39b2222d5..a00c74d287a69 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -100,8 +100,8 @@ static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 						 int i);
 static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state);
-static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
-		int inst_idx, struct dpg_pause_state *new_state);
+static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     struct dpg_pause_state *new_state);
 static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
 
 /**
@@ -1321,15 +1321,16 @@ static int vcn_v4_0_5_stop(struct amdgpu_vcn_inst *vinst)
 /**
  * vcn_v4_0_5_pause_dpg_mode - VCN pause with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @new_state: pause state
  *
  * Pause dpg mode for VCN block
  */
-static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev, int inst_idx,
-		struct dpg_pause_state *new_state)
+static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     struct dpg_pause_state *new_state)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t reg_data = 0;
 	int ret_code;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index a71960d899e38..91b57b86dc58a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -83,8 +83,8 @@ static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 						 int i);
 static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					    enum amd_powergating_state state);
-static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
-		int inst_idx, struct dpg_pause_state *new_state);
+static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     struct dpg_pause_state *new_state);
 static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
 
 /**
@@ -961,7 +961,7 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
-	vcn_v5_0_0_pause_dpg_mode(adev, inst_idx, &amp;state);
+	vcn_v5_0_0_pause_dpg_mode(vinst, &amp;state);
 
 	/* Wait for power status to be 1 */
 	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 1,
@@ -1064,15 +1064,16 @@ static int vcn_v5_0_0_stop(struct amdgpu_vcn_inst *vinst)
 /**
  * vcn_v5_0_0_pause_dpg_mode - VCN pause with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @new_state: pause state
  *
  * Pause dpg mode for VCN block
  */
-static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev, int inst_idx,
-	struct dpg_pause_state *new_state)
+static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     struct dpg_pause_state *new_state)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t reg_data = 0;
 	int ret_code;
 
</pre>
    </blockquote>
  </body>
</html>

--------------aWxp0yk0XE9kKCjFHQJJ2G0a--
