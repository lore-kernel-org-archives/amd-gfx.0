Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8421ECFD647
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 14:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12B3A10E612;
	Wed,  7 Jan 2026 14:57:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JFIScKDo";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FF910E5FB
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 14:57:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YD818xMY/4jitWbfIRD19RmcfDBcAU2x/pT3LugPeeI1v+tBb1uXb8QFbU9mAW9QKAOoGuds2hAuOxqBigxKv4js0OYCo+sSJwL95uLtqkSdEaWWc5tOun5t0JpdrFEVeLFeBNZgHd+2waMimpY41tF6Vya/mq9Gs85xyIOSCqm6Ku0nemo6/RhnjgVZhjczgN9MrUUowK+XUq/+C0cwd/F38X33IYUdtNe0jfnWd6xsjTW++d22b9k8GrANuR02rnSPE8Wpy8bkkt0XZ/bY2IkzQI5nl1D6+zKcqfgnKJh+A3SacOojjPtUFYi1ta0C9O99wfk8ZNunYS76R1bR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MScRSPAxyNzac2RzmY9YOgQ17mXXiEa1IhOmBGg/7Vs=;
 b=ol220mQErVwBnN4y/ZBJth+VJAQ1q+2X4RydUzwsu0xVKgEwvk23ozq79wN+Z4qBCG2jdYuttRv0D2BtCy3ic5hMK7W60Db8CV5A78TCN9RbHwvSLXIksWHqufVjKi+5x+T4hqJGF+A+dAQtebi21ujkvpQLpLS8cjcgCflNJ47jgINQ0g0IPSiR9k7g+K0ZbAJaI/ETxMkwkHQkkUsQWV7Fv3ebEO9LrE2Usp/VI9AN+GYYIIpHZu1cJuV4MEVFzs8rAIzDCqIDjslpPl5r2TWm4gdOia6cPyixS5Y8FGVCm42WeUiVdo2twW6ng41L5aifAyKx7WYGkhteE827/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MScRSPAxyNzac2RzmY9YOgQ17mXXiEa1IhOmBGg/7Vs=;
 b=JFIScKDo7/TTCEtfKlUltJAWGD8yNgQ/J1lB8IjoB9DFLKrGecvBTVFjXLQzwrDKRxaLxvt6oCH65j5jTdm2pyks9sJIKvI/HEenYcCan6fQOZO3kNYQ8L8akrSz5M84TFZsjKIugBtg2zDOpaPxzBWE83FXpal0bAJLs1b/AaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 14:57:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 14:57:31 +0000
Message-ID: <432d84bf-9201-43cc-ab73-aa3664bac32c@amd.com>
Date: Wed, 7 Jan 2026 15:57:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Force-signal fence when job is submitted to
 killed entity
To: Bingxi Guo <Bingxi.Guo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Deng Emily <emily.deng@amd.com>
References: <20251224082535.527138-1-Bingxi.Guo@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251224082535.527138-1-Bingxi.Guo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0329.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 794b38cd-300e-4f8b-b7e6-08de4dfd1552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGZPVVBSVWNuUklkNEduU2xPZkZoVHhVZzAvRXpZQnFoTUZqQW5sUTlIc3FZ?=
 =?utf-8?B?OUQzT0V3MFlTMGkrMEgzc25WbjEzOWNMbGh1bHUyaVMvWFM3UE9hQk11OW1G?=
 =?utf-8?B?NnhQYWFaWGdCOHRmMUpRcmZwbXg3MkN0SnpTaDlOMFNvNzNwNXVzUjBjQ2xE?=
 =?utf-8?B?eHR5dE5yS3kvWG42KzBPNlZOUVZBbUcrMHNjRXpqUVpETksvQlNCbUcwT2Vv?=
 =?utf-8?B?VTFOaElySExacldPaWs4Z29iWGd1R3htTkNRZG1aQVh2WG9LeG1JYy93bW4y?=
 =?utf-8?B?YWw5VUlZUlVOSWljZE8vOTBkbkVnRnpTTm9idkkwRWFJbkVPeE5DdkZxd1Ba?=
 =?utf-8?B?dW9qVTJrdjFuWTcxek00eEkrY29GekZGVmk4QnpFcTdtWkErVnpyVXhwVGt0?=
 =?utf-8?B?eWxqK1pGZEE0TXZ1bU53NkIvVDNqOUZzeEdRdysrYjlwRVBXUW5rb1lwSUYv?=
 =?utf-8?B?bnhOYjhVRzNib2V5VWxTT3M0SEFodEgxL21GKzhEd01HS09LU3BSL0tXTFBp?=
 =?utf-8?B?dnVBd2szcGZNbjJjaU5Ib3ZPWmRWQSt6ZksrT0ZZMzcrUHRmREt1Q24yUFBs?=
 =?utf-8?B?dFNjOHBPZTZWa3BCbkcvQ1M4dHF4TTBiOGxBVHZpQUVHcGVXVHA3SzdyaWhh?=
 =?utf-8?B?UnZvZlZZZU5ZZVRJYVpTeU9UU2dhc0txeFJDWkFONWJhQWNRN0p6N3ZwOGVK?=
 =?utf-8?B?Zm5ZdkdidGd0ZGF3Y1hqbVVFYnBuWi9WQmpmNHpKdU1wUmZzdzlWTy8ybEE4?=
 =?utf-8?B?MThPcDZRQlhJNm5CS0NFQ3hKRnJ0OU9QdzFpcWpIZXZzR0pYY2NVcmZXcG5N?=
 =?utf-8?B?czVLSkN0RnRHblo2N3VzbytoZStpZU1UOEZsR2drN2hKaUErNUY1T2VGWU9x?=
 =?utf-8?B?U05sU0cxR3ZEVEV1ampmaytiQmZjNTQzb1gwdnF3Rk0vemhad2NUdU9jWXJt?=
 =?utf-8?B?ekhpTHF6TFJ6aFAvRlFYbThOWXFvRlM5NWlGN2RPSUFHTVZBNFJPWXZsSlVi?=
 =?utf-8?B?azJuSFIvYVNVSXIwNkJkZ1BsUko4aVh0NVFCSkpaWVpnQkdXK3RSOE5TbGM3?=
 =?utf-8?B?c3lIRUoxVWp0SFpJRWJkMDQwOW82T051VnAwUmNNMHdWZHVkL0NrYjNSaTFu?=
 =?utf-8?B?L1J3cThzd3lFMGtXNW1LRU1Pb1ZFVmh6L2xHdUJFRW1iL2gvOXQ5Tnd0SllV?=
 =?utf-8?B?R2tVb2diellvblZST2ZNN1M4cUZzU3RWMENNNGxnRUVGVTdCeXlFQzYzZmhl?=
 =?utf-8?B?c2FGT2tnbmVDS3hkczlPdllKVDBTanQ5TWlYTWNSL0F1bUM3V1dNSDd1b3RD?=
 =?utf-8?B?UVZNbHV5QUFXRjhNTlpVRnJYZ0xRNG5ZT1pySlI5a0tlbjM4T0tVNGVUdjdJ?=
 =?utf-8?B?OUFLM3p6K1NpeDVFb1ZGRFgzWTA0QllMT1FESWRUdFE1TDNjWTRDSVVNeXNy?=
 =?utf-8?B?WVdhUFBtZTgzRG9VRzdJcFJFWjVPQ2tlRE9STTFWUWR1aDhLa25Qc0FFdGlU?=
 =?utf-8?B?WW4yODdNR3phZ1dpamNlV3ZOSk5xbWgyR25DanBTMGhpTDFENC91UUs1RXpY?=
 =?utf-8?B?dk5scXN1cnBSVDF4WGdpc0daQS9hWFloVld6MEdBODVBaTRhelJFL0xiSWlL?=
 =?utf-8?B?RFpMZmNTUGhHOU5lMVhoWThENUlxWm1UL1ZjRWcvekVkLzRBdnl3REY0RWIw?=
 =?utf-8?B?SktFZ21GSFBVSHM1Zkw0WklCRTJtcU1QRVRzdVU1emtWTnlRRUkxdzF6OEdH?=
 =?utf-8?B?SzdGWmVVbU11bkRSNnloRHA3dXpVNndlSS82NHJObkdWM3BDNDM0NEs5dUtm?=
 =?utf-8?B?L2lrVHRPbkNjNFFScEo1QUY3VFVZMTdjaXM0WVhKYjdYMkVuRDgzRkNYcXM3?=
 =?utf-8?B?cTY0citUZDVzdGN1bUE1YVhjNlVmODJkREhwb0NZN2pPV1lJTWVDdGFHL2Jr?=
 =?utf-8?Q?iD76fSltE9+LH/xqkZvAYgwlcoJC0xBH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHE5WWFyOGVWSHNoWHV3R09uMzgyT3NOL1VWMGxOcXMyMWlzT2RHZUErazdk?=
 =?utf-8?B?WVVQbmhDQUljNkdBeW5GZnpkRVdabHU2bVQvSjQxeVhqMUVtVUJKRTZkTlRp?=
 =?utf-8?B?SkR1cW80dnpEeE00Z1RVRG03cVpRZElUdXZsYVpmZWo0TzZGbFJZaTg3NVhq?=
 =?utf-8?B?YmloaEJkWDh1UVJtdlAwUWplcEM2QzBrenJ6M0h0T3ZoOUhzcGlKZ0JjMEpO?=
 =?utf-8?B?T2oxVGMwamxJaldOWVc2S1B5UWVvM2RGV0cyTG10OThiZnFVdVJLNEJBWFdP?=
 =?utf-8?B?V2RtL3F2SkQ4TXFuUGQwcFBDYjZrRDhjRFg5RkRlaisrbkNRK3duOTNteFpH?=
 =?utf-8?B?YWFyT0NIdzN0R3lZb2dXeDJPanhDK25oL2JVRnQwNnArc0ZyRUJMZnNaamc2?=
 =?utf-8?B?UWdqbGJTVU1VM3FFREpXak1zV0VMcVN0ZVc2QnRaN1ZzbThvYjd2K1FDdUFp?=
 =?utf-8?B?RTRTN1VuUU44eHBZVVovLzJUMWs4MURrMVduSlc5Si85aVZWM1I4MWoxYmZJ?=
 =?utf-8?B?QnZSVDFIQ2VVZkFINGhqYW5zd2ZnaTF2a09xbTZWUXRKK2djT3FVcm5TNFZw?=
 =?utf-8?B?bHhoMnRrWE9QOEIzeCtYWXBmcEJUREFtalMvcE5OWUE4bUxacjgxd2lSMFI4?=
 =?utf-8?B?VkNkZ2tkcVd1OWp2RlhJd3JBbjRvYjA0M3ZRVnd4TjBqNkVaakQ4Q3lYRkpo?=
 =?utf-8?B?RjQxNjNpa24rU2JMZ1R6N1YrSGdRVzBTQ0gxSE5DTGg2OUNEb05oL2p2ZktT?=
 =?utf-8?B?K2NZMml4RXZ5R1pHU3FLTm5sTTRrSmVnSG1rU1F1UmZCcmJhaGVaS25ZMHBr?=
 =?utf-8?B?VkgzQm9ZbnJWNVVPaldkVFlJcm90Y1J4RWp0Nnd4aGRlV2gvam5CSHllSXpj?=
 =?utf-8?B?TVRabURDUzg0cThsVTBvbkNMaVpwamtpRGs2YmYxdzh4eSsyUUpBWUVHN290?=
 =?utf-8?B?L3kzNlZtWE9GRGY4Qkpyb1kreFM3L0hpU3NvbnRCaWlST2lNa3RHWEs1cGlG?=
 =?utf-8?B?ZTVNNXNtdHRlbkNpckFuNlJzcVBZa2FPOXVwcjdjTExYNVJmZ2FHQTI2UkF3?=
 =?utf-8?B?My9LZzZXVXRyTkRhMEs0TDdUQUJDcyszcDFkaTlCTEE1T09hZlIvVmQwRXlS?=
 =?utf-8?B?STkrWUVEQVdaN3NxVEgzU1pEZy9JVWRjV0FnNHdjd1g2S1Z6YnIvME84dC9m?=
 =?utf-8?B?cUJlYkVnSnJzWEdGNGJUM3Y5THU5UmU5SUJtTzlKdVYrRExQaHRaZFR3d0FD?=
 =?utf-8?B?azBLK01scW9jakhNT0xCOE1RS2hrZzY1MHJTdUE4d1cxbHMyK2lVK012UzhR?=
 =?utf-8?B?NDliQ2crL3hYK1JrRG0vUldXS0RQTmc3SUljOFlHNitkRWFOMlpZZVFmSVhH?=
 =?utf-8?B?Y0hLRzJwS3BFcFdnM3I0a2loN1haYWxzVVR3QzczTnJCSFNXS21WMkFOQVNa?=
 =?utf-8?B?bkVoTVVIaHpDTlRKQUxuTXl3b0ttMTBRZExDbGVKYWJoZUhPTERJbWxCL1hQ?=
 =?utf-8?B?aWcrVGJVR2F6QnQyZmY1SmdzTVZXZ1JUa3cyeWRMMXpNOTl4S2c0QXZHMm9k?=
 =?utf-8?B?eDdXUTJvaUcrNys5UTU2NWJNN3Q3Vk5aaDUzTjNSMG1SSFQ2U0RJaDF5YVdJ?=
 =?utf-8?B?aGp0bWtSby9QQm4xbEZHbnNUVHZGRkRJd01JcnFuT3VvYVl2Tkh5clhRWkdG?=
 =?utf-8?B?cUhuWFNneUtldHRwcUc4WXZoSUZkRElmQTdBaHAzSmcyT2duOG80Z0I5R1lx?=
 =?utf-8?B?Y2F5Y3IyQWk1dUlyd21FRDRCSUprODNLUnBaMkpCNEdTNFBhZndpMmNYWlJJ?=
 =?utf-8?B?YXRYSHN5QWwvN3lNTjJ4T1VvZXFTUWlUK2NBd3FhVHlKYWZrVHVaWFU0d0Nu?=
 =?utf-8?B?cWRvSW9nZTFPOFYwWm9hcXl2Vm5uRjIrUHNJcWcwVGpnV3NqQzFTczZhREJV?=
 =?utf-8?B?V3JRd3FVcDBmT1ovMTYwcHV4azhCRG1nbFNEa0U5TFBvaDlpZHUwdDE5RURC?=
 =?utf-8?B?cmtWRnRKdlZyVU1IYnpqeC91RUpxaEk0ekgxYjFJNEtIS2hnMWdYZ2Z0Q3BP?=
 =?utf-8?B?dzhOb2FUKzYrVEtMRmlnWG5LeDJlSmxDeEZaT1RINEpkSWx3MUdwQ21OdWRt?=
 =?utf-8?B?VDdXUGxVTFVGbDRRK1JlQ3U3cjFJdHRDYTdLbkhwZlNVR2NkdEgvQU4vak9x?=
 =?utf-8?B?c3ZkdjU4UW1FU0ttd1U1d2l5b1NpdTJ5TVdtT2pON0ttUG9mTDUrVGZsOGph?=
 =?utf-8?B?bjEwa3QyYnZobkVFUWFmR0M4c0RWaEcvOFJWeng3UnJUU0RGTG9GbHpxNXFy?=
 =?utf-8?B?WExhMld0ZlNwb2JFNzEzMk9zbi90Uy9JRUVVK1huQUIzdUhFRGUwQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794b38cd-300e-4f8b-b7e6-08de4dfd1552
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 14:57:31.5337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/rAFC5ToCwcg3PM7gG7gbOwP4pLxDnLxQiZwkZzzC5pDozOK0QLY9xyjn+1gqTP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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

On 12/24/25 09:25, Bingxi Guo wrote:
> Issue: jobs submitted to a killed entity can still succeed, except for
> a dmesg error when the job is the first been pushed to the killed
> entity
> 
> Force-signal fence when job is submitted to killed entity

Well once more absolutely clear NAK to stuff like that.

Please read up on the dma_fence documentation before touching the code because patches like that one here clearly shows that even the basic are not understood correctly.

Christian.

> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> Signed-off-by: Bingxi Guo <Bingxi.Guo@amd.com>
> ---
>  drivers/gpu/drm/scheduler/sched_entity.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
> index 8867b95ab089..998e35a1a261 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -570,6 +570,14 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>  	bool first;
>  	ktime_t submit_ts;
>  
> +	spin_lock(&entity->lock);
> +	if (entity->stopped) {
> +		spin_unlock(&entity->lock);
> +		DRM_ERROR("Trying to push job to a killed entity\n");
> +		goto error;
> +	}
> +	spin_unlock(&entity->lock);
> +
>  	trace_drm_sched_job_queue(sched_job, entity);
>  
>  	if (trace_drm_sched_job_add_dep_enabled()) {
> @@ -597,12 +605,6 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>  
>  		/* Add the entity to the run queue */
>  		spin_lock(&entity->lock);
> -		if (entity->stopped) {
> -			spin_unlock(&entity->lock);
> -
> -			DRM_ERROR("Trying to push to a killed entity\n");
> -			return;
> -		}
>  
>  		rq = entity->rq;
>  		sched = rq->sched;
> @@ -618,5 +620,12 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
>  
>  		drm_sched_wakeup(sched);
>  	}
> +
> +	return;
> +
> +error:
> +	dma_fence_set_error(&sched_job->s_fence->finished, -EPERM);
> +	drm_sched_fence_scheduled(sched_job->s_fence, NULL);
> +	drm_sched_fence_finished(sched_job->s_fence, -EPERM);
>  }
>  EXPORT_SYMBOL(drm_sched_entity_push_job);

