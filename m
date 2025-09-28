Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B0CCAC5BB
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Sep 2025 14:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC26910E124;
	Sun, 28 Sep 2025 14:15:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="266GSC3i";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F5410E124
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Sep 2025 14:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OshSsZcxAVCnYwQhQ/WqPWsD+X1dmXBB5/f1w22yjR5Je6Fmtl+cJh2Xe8V8Ks80SUQ/nSSpVILAeCIJ8QJbI1bPX1XrbGnjlGynkGf9tgTK53S7p/iotxiuGuzUS1T6cetqmm8wOwPuYDLkuMEwaPiChehvoeqr0TVzYYTkgNbuk31axqG8m0IOu/AwUki/yyXuQHQ1d68s7WctLXIkC8jeCLMvBUbENkYFOPtU879pUUbBTC+s3y8rfpDzPbCUdZx7+kCKls3gJhGNNsk8bzoGvGhnCYob3AQKlyLFUHYF/GK7VGNfiWn738Tg0M4C8MtIj7vBLZwzk+dUFOVXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGc2fgFqeLvHfvmaj4o1uI5PhkmpDS9qZfAPRBLLy84=;
 b=r0ZW/LQZ6yf2lDrl16G19zgSquaotNF8TIJ4gS4DL24hJyiSl5GC9MbcGM6msMRrn8c4To7izm1bOd6vjqVnSMboNJH1wa28WpqZ2j06BUujzbTfWMS3S84YtFKgGT+ekjLt5oRRFudkswJnTFzXTCWKCV28vWDRldc51tu0I3cyjgn9MMf9eWMhi+RNXDVkD6SMYfUm9y3P8IONCF+J5yg0gJuMfpsLIffeVWC8/d4YWsDHIe6syme2Jaid1uo1ZtVkCTYHZdXd7kv1L84ktO6qLLRnrtBRtetfiI1uveA4Emitc+/qVIpvoqskFo3flBlGut0kj/kM50y44CcS4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGc2fgFqeLvHfvmaj4o1uI5PhkmpDS9qZfAPRBLLy84=;
 b=266GSC3i9gG9k/IhAdh8Yteb+y9QSjGWpAZ7TjrWzQxyLahHgRZ6T3dOV7Xc9M3wM1qbHuSzfBq0nmDZ7bBwTgnCZKpMc/JNuMGo976WE1IDso2yucdMCepBS9C+CIp9Q17Wc/MK0nxBWqlv9s3u2N+ov3nh1Z5g1o0cY7Uc8U0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 14:15:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9160.010; Sun, 28 Sep 2025
 14:15:01 +0000
Message-ID: <221fd37b-e2a4-419c-9ac7-bb9eea0b4f78@amd.com>
Date: Sun, 28 Sep 2025 16:14:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd/display: Set stricter clock dividers on DCE
 6-10
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com
References: <20250926182614.26629-1-timur.kristof@gmail.com>
 <20250926182614.26629-4-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250926182614.26629-4-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0140.namprd02.prod.outlook.com
 (2603:10b6:208:35::45) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c9b72f-c60f-47be-6b26-08ddfe996975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXpuN1Z2Qmw0UTM2dTV0WENvb0VnczhrdHkyRUhUVUU4NXV2eTIveG9xTXRz?=
 =?utf-8?B?K3BiVFlRdjM3MlVVbGc0aHlmY1UvZ3pYTDdmYjBma2pQWEJWdHBxSmhyWG9L?=
 =?utf-8?B?MFNnZURhZjhTSEIvdWNqcTdnUGhuRU1nNmZKWVJQODhiMTJsaVF5bUdNUXdL?=
 =?utf-8?B?S0lJOUh3UERCMXZvbERiVy9PZVRXSEpMdDlnc0tVOWJkdUQzK0hEbTloNE1k?=
 =?utf-8?B?WCs5OVZwOTcyQnZXcTVzamtWRFNUQkxWa0xkTWNMTm5UZW8xb2NtaGVRVEVp?=
 =?utf-8?B?MHpSVm5tZVFWMlRiWUJIVldrY0Urd2ZNb0k4aUVVT3VLZ2hGSjAzL2dqaVdr?=
 =?utf-8?B?V0xoV1o4NG96aUY3TzJyelBVZkM2cm54NEcvL3ZOUkhneWt5RmJVUTJYbHJD?=
 =?utf-8?B?dzA1bE56OVRJUHY3cDFvWlNQMVJpWThoRXdiKzkyWC9zMnV4TkVpK0FmMjV1?=
 =?utf-8?B?V3NiZkJJQXVsaE0wN0FYdTEvMXNoUEErU0VDSlhwaUdXWU8rWnF5ZkpWVVl0?=
 =?utf-8?B?OWJzdDRxbmtEOUcwR3RBRGIzaVhDM0VONWhpQmRVTHY3Lzhhb3V2YUNUWDFz?=
 =?utf-8?B?VjZWME1ndUU4aVEzcDFRaTF0N0x5amRYODVxbWlGS1lOa2RDZ0wzK1hkTGkw?=
 =?utf-8?B?QzFIcG50WVNLTzBidHdTQllFd3pTdncyWFVyc0dOYnhlWmdZNzJNY29yWnJz?=
 =?utf-8?B?MENSejFoWFlxaUFvV1JBUlkxLzRUME9MSzBvdCtyc1FQV3hIMURkWlA4bFNv?=
 =?utf-8?B?Mjl0M2FCcldWeU95a1ovVm92U3BKT0dhYjNiblVya1Z2d2ZnSFp0WGVXVzR2?=
 =?utf-8?B?ZWVVQVFiOEUzN2dnSW9DeSs4YmxaVlhjbHF5a3FqTTA5NGJTZ0R1dGtUQjN3?=
 =?utf-8?B?T1NDR1I4d0taMEdZOUlKWG9oWk1JUVh1SUhqSFgwWnNSRkd2d3RoSVcrd3Nz?=
 =?utf-8?B?b3VyNWpheEZRYy9Ia2FRdDYzOVNPMnZFYWR0WGZUSXV6K1U4SHdTbGd4YWN3?=
 =?utf-8?B?WWRPTlJOQnVYMEFxRWsyV0pjVXRrR202UGwvTy9YZmdEMGNPSEZ3VjFBUDlx?=
 =?utf-8?B?K0U3Mk5MZHZJY010aWk2MnhUK2hZTDA1ZUhiaVhuNHFYOXQzaU9Sc1hpcEZW?=
 =?utf-8?B?cjBuWGw0QldrYUFweDFRRFo0SXJBVElYWTBLc1BEVGl4ZlZlRTErVlU4UXhW?=
 =?utf-8?B?SWlmdGpCQzJVdGhneGdiWUxiVW50K2Z2SnRyT3pmMzQxK3htdzlYM1JEZHNl?=
 =?utf-8?B?YXZqRXpLM2xHLzcydUpUWVd2ZW1MVENBNndJNXVSTWUxSWpxZzJLRE9UMlpI?=
 =?utf-8?B?UGs1MDQ5QjMvS2FoSkxWUnZ2M1NPUkVMNURWZDJPOFIzVG8yYmN0MUtBTXA0?=
 =?utf-8?B?M0hkMHZGZnNLNlprZzUrRkQzWHJMc0pqWmxMOWxSRVczZmo1aTZGNFdlUVJE?=
 =?utf-8?B?TEdDTkJnbmwvQTJKeEIrWG1sYkl0ZkwxalhDREZpOC9GK0dTU09SUW9BcjFT?=
 =?utf-8?B?MlZSTThVdnphTWxVemRSbi9zWHhtLzg0ZU5yZmFybXo2WCtKV2d4N3lFQ1RE?=
 =?utf-8?B?OUt0Qk9idkxNVTdpTUpvbEp5ZTUrMFpEV2tKaHR1Q2sxekU4VmE1RzJEV09Z?=
 =?utf-8?B?d1BvdVd4Y3NtbGRHWXlEMXZjY1lRZkdTNlFrcC9WODluRFJNNXhNblIwUXhs?=
 =?utf-8?B?d2lIMDMyaG8zRFlTZWpxaklpT3o5M2lHV0VUSmUvRy9xN2NVc0RHZjltVlNx?=
 =?utf-8?B?enZBam1jTjVLNGlON00wbjVCcjBqSVowZm9ZWVJGdGxpVEJ1TXJCVzU5ZHBr?=
 =?utf-8?B?dXNROU9vbzVWKzdjQmxTZjhoOGM0RmVXZnRoeTcrank5eHRYc0M2bDBZNENH?=
 =?utf-8?B?bGNvY2M3WkM3cjliSVNnUWxPRVRpNG1hNW03WmE0aEJWS21nNVNCdDhDcWNU?=
 =?utf-8?Q?ws+ex7ik1BBeuX495K7d5wZOq9gU/uRp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2Q3eno1L1VHY3JXaWhzSUxIZmN4dENwZ0FZZy9PS2h0NXF4ZWFaNDdQREpj?=
 =?utf-8?B?ckowenhKWUxGQWJWb0RobU13QUIrOFg1MmUrZDljYUZRc2htY1ovczFnVEdq?=
 =?utf-8?B?TURzbU82ejEzYklFQTdUSC8vUWpDT1BvZ3BMNVBIRUV3UkdUc2dvbHN0a09y?=
 =?utf-8?B?YmQ5Q0NoSFF3eXdudDExcktzYnNkOUt1NXFFUk9XMVNwL2x0Z0gyVmVvUTVj?=
 =?utf-8?B?N2lZMitoZmpNSDcxWmtvb1loeFE5S0EvSXJZN3ZIMld0dkR5cWxsSmtCaTNa?=
 =?utf-8?B?eEs5UFZqRG1sak9sUG9zZFhzWlhxdG1PT3pZdGRVV1p1alYwcDV1MHF0dUI2?=
 =?utf-8?B?eW9MaTFVOFR3VGw2WEVxcEwrVVU3bHJXU1JHblRGM0syb0ozek1BU2NjWkVC?=
 =?utf-8?B?T2s0V2owS0JPc2drc2FBNGRGREpXejd2VU9PenZMYjE4cVFkdWxoYjZlazVu?=
 =?utf-8?B?TlhndTk3VmNOTWIxWmNJbHZ0N1NUeWxFQlJkY0lGUmxaWExIbDcwMU52Q2th?=
 =?utf-8?B?SnZVNXFOTVhkd1VHamd1aFhQNUxCdEJiL3ZMMHhFT3VsdEhTYWlBUEVXQUdh?=
 =?utf-8?B?RU5hUWV6VHlOL2locGlRN1F2UFlCQnZNNEFNb0YramVDbGVYN3pYSHpMNEtY?=
 =?utf-8?B?SkVIZmJLUlI5SG1LeWlQdHJYZmFMcXBsYkxIOFpmSldrZ3YwQzF5Z092d21r?=
 =?utf-8?B?OW9iMmo3clB6bDBLcisvQUg4VU1wTWVpRks2UHpkbVFwSktGYnZLc0YzRzkw?=
 =?utf-8?B?Q0FkaDFCL252WlIrdmkyb2M0bldkSnEwWCtsVHNVU2JrNmN5YmhTVmtnZmRo?=
 =?utf-8?B?clZxVHlCM05aSjJyaENZaFIvb2NEa1VxNWY1Nm04ZE41VzJCRUUyT0p4NnE2?=
 =?utf-8?B?VTlwYjZqYXlsNEM2TzZaTnQ0c0ExVjZ6RTMxa2NXWmdGMENKOW82TnpaZ0VL?=
 =?utf-8?B?czJGeGxZNVNFVDV3V1hHS0l1RzBSQU1VVmFMT0VMOWVSZGVGMVRKSDQyVVU4?=
 =?utf-8?B?dWJzaWdTaS9EejJqeFFhVmxRYTAwbkdXZGoweURwSnVpd25EZVZWYXpiOGo4?=
 =?utf-8?B?N0E0bUJKd2xpS243UlM5Z21Lby9zbVF2TEFXQUltQjdKZ3VFdWhZdnBIUGV3?=
 =?utf-8?B?MUJCSFdEVmNGSEVJcTlLU2g0TUpVeUdua1FTTlM1cGQycW92MEVKcUhVdjAr?=
 =?utf-8?B?ak8rWlJEVXB4ZVRnVzh2aTIrOURZTlhWV0dURlR2QWlUS0txbHVJdjRmNnhU?=
 =?utf-8?B?VmwxNVo2SXZ6dVFVRjVhc2p3YnVoRzg5R0FCR1E4UmZWSFd3N3IrVldOYVQ0?=
 =?utf-8?B?MVUzVnp1RU1acnJRZzlXSVJFZ3pBZGJHRWRKckEyTzByZS9iZnZWMmUwam1I?=
 =?utf-8?B?Z2Q2MXpCWU0rSG16ekJPMmxOSkF3QlQ2d0xia09VK0FNU3NWSWNnWkU3dFk4?=
 =?utf-8?B?cksvSnpyenB0RnBVa055ZHR6NXE3SHVMa0JjSmc5TEhuVFJERUIzcmtRSzI5?=
 =?utf-8?B?cXZEaVp4S09wZWZkRlk4alk2MWNSSVdGVXRxZi9yKzRIeWMxRW9tV1U4cW9Y?=
 =?utf-8?B?Z1dYRU4yd1RPU3NmS1dVdEc3ZHdxMUd6RHdGSzhKUUl4MWFNVEZNTGZ0clQ2?=
 =?utf-8?B?T21YVzNCTERNaDlXai83eHVyU2trdmUrTWJzTmpHYTNpbko0eiszM2NVM0ZZ?=
 =?utf-8?B?b0R3eGxCOHpCWGVMdnluVHNuRERYdkYwdXhBTUQ2UFZmR1NIeDMyZGJMd24z?=
 =?utf-8?B?Q2pDSlJOU1BIQ2lIU1hFRDJaRFd5WXpjQStuYy9zSVJLZEdYT1MvWncvU2hW?=
 =?utf-8?B?aC90ZGtESjdWZlY2SDhIMzZmcU94ajZDUHZ4NEhqa2JHeFErbGlkditjaU9j?=
 =?utf-8?B?VldhKzU4SXZxMWRwRGV3THZpaXQ3a1pNVWxteHFzWk9lR1cvWXBhUjI4QkU5?=
 =?utf-8?B?dk9lTTREZDFheldyanlScXJ6Q1ZDNmhrRWRlTWlzQ0dhYlY0UWo3RzVpRldH?=
 =?utf-8?B?dklJc0JPYk9oaW5IK1FzVVVIbEw1dE0rT3Z6SkU2MVBsRlZxYUdpQ2piM01a?=
 =?utf-8?B?L3BhVFpVZGVrT2JJUjR5ZnRDcyt3SXNUeUkzUzZEQlVjR3lqdWlYWDJKMmc2?=
 =?utf-8?Q?bdurYkKGYviKpzI8yLergZbQY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c9b72f-c60f-47be-6b26-08ddfe996975
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 14:15:01.1374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UopoF9cDIhYNbphGvC+4KRNhfN3wWwJIbWWmeTTJIKd3t5AVZbLy51Lwwekj5dPY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015
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



On 26.09.25 20:26, Timur Kristóf wrote:
> Set stricter dividers to stabilize the PLL's feedback loop.
> In practice, the actual output isn't exactly the target
> clock, but slowly oscillates around it. This makes it
> more stable.
> 
> The values here are taken from the non-DC code.

There are also a bunch of other restrictions which need to be kept in mind.

For example what is the minimum feedback divider value the DC code uses?

We once had a longer discussion with the PLL HW engineers to get this working because at least the display code we used as reference back then got it wrong.

Regards,
Christian.

> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index b4f5b4a6331a..00f25e2ee081 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -1700,6 +1700,13 @@ bool dce110_clk_src_construct(
>  			clk_src->cs_mask->PLL_POST_DIV_PIXCLK;
>  	calc_pll_cs_init_data.min_pll_ref_divider =	1;
>  	calc_pll_cs_init_data.max_pll_ref_divider =	clk_src->cs_mask->PLL_REF_DIV;
> +
> +	if (ctx->dce_version <= DCE_VERSION_10_0) {
> +		/* Set stricter dividers to stabilize the PLL's feedback loop on old HW. */
> +		calc_pll_cs_init_data.min_pix_clk_pll_post_divider = 2;
> +		calc_pll_cs_init_data.min_pll_ref_divider = 2;
> +	}
> +
>  	/* when 0 use minInputPxlClkPLLFrequencyInKHz from firmwareInfo*/
>  	calc_pll_cs_init_data.min_override_input_pxl_clk_pll_freq_khz =	0;
>  	/* when 0 use maxInputPxlClkPLLFrequencyInKHz from firmwareInfo*/

