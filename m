Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF39BC83F22
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 16:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E11C10E226;
	Tue, 15 Jul 2025 16:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="umWUBswO";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDE7610E226
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 16:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRH9HRbTe/BTW1Rf/AKFqzzH5QZ+XpTpDY/wrgi35wWgFZNZr2Fv9+q0+N7Qr0GopYb8WhNMXSQdZcCgmv0ZcyKhXnmn0ZpCHrKABlkV8+KBZnnvsR7KoAlXiEs2AUkv/SBw2L4g7KvQlu0W8OxMBx3nfYRY8Eb3d3XovXwVEwZqZ5KJMHVEK6OPUzNWoTGl8etkbSncdbEeGRZQDrIRNKwXLtOgy0d0YZdl6EM758e5qjkpTagexSXyGG+KI6psKE8jJbBQAgEwWg4BKBVowQXJ+pshH9tbleBWe/KrG5h6gQbdJbSGTq7hPEzeCym6QRWRLaS/YnUiz8ylZ7Y37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KQmOIYiDYTpKri8UcRXDkx0ZyowPom/18rOOgvgL9I=;
 b=KSOKn/a3zVn2l41mXMTeHmgXp5D5u5WaKXnIqa1RkTn91X/4Bd6jQWIOz7JK4vymNmTg9ax+xA1vpQSNWvO7TB/RIGBepMJqkH5/zAgvL2oM5XblkRSzA5h+hJN8fe7MujxktPM/+LgL+YvHMu0d1ih+LEo6eb0vcAVyVoiv1BWNCW+sa3H/YaJi/8bFEBWOkB8o7BLPmi/RwFQ55D1+GjG8JcJfi/7/xKdPlxmCDIXb0kBGZGArMozO5RS66dnebn6P3z/iVEWkoyjbnykO4Ra4Xeg9bmL85btbyFv4tMNP5478GPvP/CX4MGlTYNsbHRSAqSpBTwu4AQv4/+SaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KQmOIYiDYTpKri8UcRXDkx0ZyowPom/18rOOgvgL9I=;
 b=umWUBswOS5VIk/vtamyd/LsQWshoo8gdH6Ew9YjrCyhXGLLbosRrQDcjjKAvGauILMLUJnnRxqMUwcZZlFU1nE+1oUsx2ayYKtQBrFgzR0OqyzLxlMQSf6HOHr/5AS6G1fNYjo1cNqX6VKrGt3fT951kYh+PYpXmhZtbTIRKIvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by CH3PR12MB8533.namprd12.prod.outlook.com (2603:10b6:610:159::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 16:46:43 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 16:46:43 +0000
Message-ID: <a298a543-a1af-00e4-d584-524d34225fce@amd.com>
Date: Tue, 15 Jul 2025 22:16:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] drm/amdgpu/jpeg: clean up reset type handling
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250715160051.533747-1-alexander.deucher@amd.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <20250715160051.533747-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0039.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::10) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|CH3PR12MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: 102b36ee-7ed1-484a-a519-08ddc3bf2dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2lrWkk2Ylhvd0grL1pndnJ5ZHltUkxtZEVMMlhnRFpJaHRUVW5wdFRuTllv?=
 =?utf-8?B?WnN4YmJkMTdLNWRTZlBHUmtoUXR4QlJhdzNkN0Q3VFFkSm5vckluS3MxUHRv?=
 =?utf-8?B?dmcxU1JwT2lzVTlFVUVkMXdmUEdUMWNQenBCMTNjNUhoTWhGcytaekY5bmcy?=
 =?utf-8?B?djlUd3BtaVlkelNDYkVLMEFaWEMvZUE3SGQ5dlNEY3YycWtEeG0wNlpyZHVv?=
 =?utf-8?B?ZkU4b1pGT1dZRVNRVjB0RFUwaUNyWUg0YlFNSG41OTRkODlWL1NFZ0ZFanZR?=
 =?utf-8?B?SHByLzlOZW5xbXdlN3c5N3BqSU9pNllqT3FsamNUdVkyZGYwcThMWTNsL2lq?=
 =?utf-8?B?Y1c5NCt6RkZ1NGY3OXltblZueCs4Yld3R3VDdHg5WDFTOGxiU1ZoZldtQkZ6?=
 =?utf-8?B?YS9RaTE0K1lTMHlmNEdpWTlMaXM2aUNmRldES1RJTDN5dExuaWFDc1lYZ3pq?=
 =?utf-8?B?RVBmZmZuNTB1Nko3clJLTWZtVTQzakh6emFpUllVTENSM2dWbHV0NHhMVnNp?=
 =?utf-8?B?MGNpeUY1dTdTdDZMbFRjNkZ1dHFSeVJscTR5Tk5sUDF5WlFsWFFUdUpnR3po?=
 =?utf-8?B?cW9MNXZyRjBQRHVpK3NGRHl6cDB2RmJCNTFyRTFrZ3VOOUpXZktSZTJjRW1j?=
 =?utf-8?B?UzRIcEFMVDFLaWtwd2dtS3dOYUl2eHBSOVBJeGFDSVcwRlprVUw2QVZaLzl5?=
 =?utf-8?B?SlZ0MG5EYzFhZkREUUc3MmFoNmdZMGMrbldiaUJvM2JJV3VCUUdVa2lHdlY4?=
 =?utf-8?B?UVhPZGNWTkdOVkZqTDdlSkUyS2VXTU4vTlFrei9xWk8wdS9ERnBveDVFR1li?=
 =?utf-8?B?RW9FVWsza2ZGRjZoQWFFUk5mN3RnSFhYNUZaam1JNTZKYXBZYk41TmdVRVlQ?=
 =?utf-8?B?NWlTZUVFaGxOSU9GSmZ6c2hZN2tNSEJmcVgvVnJCSjdXd3RXNDNxRGdlc0JO?=
 =?utf-8?B?dFdiWjFwK2gyZjc5cm9MQVpNWWVvUUNaT1B3cTZYcjRkNHNGby9QaEgwZFJ0?=
 =?utf-8?B?U3VUTWJEMW9aUzNPbFQ2SVR4UXZOM2xVckJGK2gvZUhvTGlraHBVZ1ZUYWMz?=
 =?utf-8?B?dENwZW9zQWNLSE1ZMzIwNFlHM1JKZlE5MnBNV29BNW9BYmorSXI0WHhUTHU2?=
 =?utf-8?B?QWpjeVJ1YXRRZVpLOSthVzlhS2hHN1lUZ2RLRDRHbGJQRWQwZFRXbWZqRHF6?=
 =?utf-8?B?c0IvVnFib3M2Q2F2dFhYT2JqV0wrOHVTMzdHeVdZTFhaQ3RLRHAvZnRNcGto?=
 =?utf-8?B?UCtCRU8rcS8zdjBOYnVSbUd0bEtNSmViQWZNclc0eXRPVTJabk9leGdJOXZD?=
 =?utf-8?B?RHVOY0NZTW9YNFozSVdZdUVCcytWOVVjNmllK3l4cE1wZUZpMTlDYjh5NFZw?=
 =?utf-8?B?WTE5c1Zkc2ZWNGxKYWNmc2I3WWRJYU5EeFgxVk9PK3J1enovazhjbFNpU0pM?=
 =?utf-8?B?S0hIditROFVMUVU1bXh6QkZ6U3F6eEZNREJENDdjWXdGK2FNRjEremRwM0ZM?=
 =?utf-8?B?ZmtGN1hpNnpJN0c0b2s2VUFoUVVlL0xVeWVQMEU4NDk4Z2loTVpPMU04TmQ4?=
 =?utf-8?B?TlRTWGU3ZndGZGY4NmdNeVRXZ0s2SVhVdTRRSkhkTFBHTG1nc0t3TXJHR2NH?=
 =?utf-8?B?MjBJazU2N2RUbkN0MFVHcEdqVmlIMXpvU29ycHV0M25YYmgzMUpZSmlaeDNK?=
 =?utf-8?B?eFBLZklHeGlyUzRXd3A1UjRTUU5qaGJiU2U4UDMxRGtHUFYzUStramVzZ3BF?=
 =?utf-8?B?RTJzbGRGQlJocUtyWHJvaFB3a0pSbU5FNWNtc2dLbFZTR0YrV1VLaUYxUHo0?=
 =?utf-8?B?NmJxWmVkNExKaTYxQVJiZTF1NEVDZkF5bU93UkVEaTlmOEtCNHdhV0pSVVht?=
 =?utf-8?B?NGV6YW9HQmxDNWNhSG1iZGJhVkpKZTgrTm1rSU1aeldQTTZDM0pJTjg0a3NI?=
 =?utf-8?Q?erZAiBOE8fM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUN5UlJvRkpaMnAzTHR3M3NUcFR4Y1I5M0lRY0x3WHc3NWFDSm1nTDdUTVNI?=
 =?utf-8?B?OWdMbE95bjhRQWFBa3dKV0hoeDZXaWc2MnErVVVkRFhCTktHWkFDMjdtb1lh?=
 =?utf-8?B?RDByM0FzQk1KMDh2Rm5qM2NqdVdrQnM3cWlCZnAxY29Bc1VrdjdpYlNuWit4?=
 =?utf-8?B?TCtPNEhBbXRZai9jcTE5N1cwS3NNSWpidGRscFl0RlRQTEliR2F6ajR0NG5p?=
 =?utf-8?B?S1JPelM3RldwRjlhOEtXQmJwdEFwWUkwNFM2NEo5cFFvS2tuMWNEdDdIa1E0?=
 =?utf-8?B?ZmdTRUhhS1FQenlsQ3hiQkJzSmdWY0tZdElDT3hxS3prMnErSzJ1aVZKWDFw?=
 =?utf-8?B?eWlZWWNTMkQvNTQxVjJ1OU5xcDIzS2VrUUdWQVhCTEVpVEdRSWMzall5c253?=
 =?utf-8?B?VXFuSzRoUEpHQVRES2pCMFR0TGUwWnUzZEVvTElnSmY2SVpBRC9nT096M09z?=
 =?utf-8?B?L0NjTDlzb3BIY3RqNDROVE5NWm10c2FuWDRPUUlESzlQMjZzVjd4ZTVsd0d3?=
 =?utf-8?B?b1FXaVh2VEVXSTF4b2F4aVVnYkwrUVBqNlpwVjJ0TFlBQW5oM01VVG9CUmNI?=
 =?utf-8?B?NElPTjFsYnhZTGlBaXBCcFBicnNpbUVleG03SGc0WVVSempETTNiZ2ZaN2th?=
 =?utf-8?B?OWU5N3JrcGRIUTAvQTRGd0ppTXc5WmRSWGxtcTRiSU5yRFJnRlJUaC80ZkdD?=
 =?utf-8?B?b285ZmxUaFZDYlhpZms0TkNpMEFHMjZBblBxWm9KTUhHeG9WQy83M0JtYWRE?=
 =?utf-8?B?a1RtNmJ4WGt1dXk2R05JNGcxV0RaZnkyZTNGUk5sN3kzY05sMkJTS0lyRGor?=
 =?utf-8?B?MGEvMjNOeEIyemF2RFJjNFVmSEUxcUVoaVBmTVJQTkgrb2o5ZlhhdW50eFRM?=
 =?utf-8?B?NWFLbVhrMERLL1kxYUUzNWFBU2ljelEzTTlta0s4Mnk5R0lGWkQ4TkJIL3B3?=
 =?utf-8?B?R2JzeFhmaGhXeFY4V3d1Nm5tMVZMYnpYcWp2L1hldDE5NFdCaFovVit6OU0w?=
 =?utf-8?B?Qk5YOVE0VzM5L2RPcDZSVVFETjdLTlpjQkZWcUU3SXRMd2xIdTBMYTRiUkly?=
 =?utf-8?B?REdjY1FzY21JZ2c4VkdrT01tS0dvc1BuVFJIOGlSUnBkbkVNVXBCcUh0Qlp0?=
 =?utf-8?B?YXBZUXlnY3picVZTbXdxeXJwSERyMnVPdS9Wd1RSMDMySUJLS0Y5SGlxSVlN?=
 =?utf-8?B?TXVxbjJGRHZkbE9DOGxRYUpmRlFHN2xpUWZxVk56cG0rODBlbTZVODlhTnlC?=
 =?utf-8?B?a3drcnFJam5nMFNyZUlHS2FxQkVLdUV6OVpHVjVYQXBCUXAraHYrdEJteXhr?=
 =?utf-8?B?T1V0dkVCVjY5dXl6VURzcjVYNDdGWVVWL2cybkpXbE9lQjJ2dnk0bkRxYytr?=
 =?utf-8?B?OHo4RHg2Q1RaSVU2clI5dHcxYTRnZHkwaGsvTDUwMy9HSWdwSG9Bc1ZkblA5?=
 =?utf-8?B?bjNKc0tMeFByZFhmQ3BFajdvT28vU3V6NThTdEs3b1p2Zlc1MHhlNWpEUnhN?=
 =?utf-8?B?U1FDNlErUkJaNEhRZVZOVkJZbUh3dXFqcVhpMXo1UC9VcmQwNWtIK0RXbzlX?=
 =?utf-8?B?QnA5amZKOGNydjlTa0VGczh5cGxjLzBaYWR1VUhaSUMzK09VQWF4dW5KU3RB?=
 =?utf-8?B?ZDdTdEhZRDRkdzc4R0xqQWZVeDF1R3d0ZmRvWm5yOHdzYVdVdWd5ZmNRdklk?=
 =?utf-8?B?VnZkTjd5Q3FhYmlYRWlyM3Vxc3E2R3U2R25QMGMzc25paU9yRzdUbEgxSlNh?=
 =?utf-8?B?aUN3bzF2SnZYbFFtcXA5ZmZvNnp5UHY2M09nalVzMTlkdUJCTHg0Qk0xZG4x?=
 =?utf-8?B?Tk5QNnRPQnVaN2NZV3RMZmJFb1RmYUdjeDk2RHd2cjNqSWtjVDd4dGpQK21J?=
 =?utf-8?B?Q0VpVTQwc0RNNTIwN25HdnErNzYrTGN4eVhONjNManpKZlA0aE03ZmQ4YTk3?=
 =?utf-8?B?SVpWa21tTnY3dXZPSDFNQzU0eURJZDk0MTFVSThyMXZjem5VblJVYmNaSTVx?=
 =?utf-8?B?MWs1NGl0S01aSUxjSFBtMm4rRUhWNVRMNXdSVjdhdGRIL0ZiUEtTS2NWRHFy?=
 =?utf-8?B?Z2VYUElydjV6UlpwYkp4bHhmenZaWEFjMGZlUGRFRVpqSGFIT2xrazRlWUpv?=
 =?utf-8?Q?/Y5nWUkh7GDpGcXiM0Z0hrgc0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102b36ee-7ed1-484a-a519-08ddc3bf2dee
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 16:46:43.6387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgZh5sJK4KkUVAemyXaekWxdKzqxbrLsiLUOI0jbUh7aMJXI+fPAvDO1p7WJEeplHlbp7r5F+8eYjIJzCNTqWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8533
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

This patch is :-
Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>

On 7/15/2025 9:30 PM, Alex Deucher wrote:
> Make the handling consistent with other IPs and across
> JPEG versions.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 14 ++++++--------
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  7 +++----
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 16 +++++++---------
>   8 files changed, 29 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 554af4b9930e3..b93d6af8f6e54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -118,8 +118,10 @@ static int jpeg_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> +	adev->jpeg.supported_reset =
> +		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
>   	if (!amdgpu_sriov_vf(adev))
> -		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>   	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>   
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 4e489a7e21157..b6d5ba0bdc143 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -167,8 +167,10 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> +	adev->jpeg.supported_reset =
> +		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
>   	if (!amdgpu_sriov_vf(adev))
> -		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>   	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>   
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index d4bc4fca460c8..a229d7eb900c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -132,8 +132,10 @@ static int jpeg_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> +	adev->jpeg.supported_reset =
> +		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
>   	if (!amdgpu_sriov_vf(adev))
> -		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>   	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>   
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index ca3debe371c5a..f3a9073b8b243 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -143,8 +143,10 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> +	adev->jpeg.supported_reset =
> +		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
>   	if (!amdgpu_sriov_vf(adev))
> -		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>   	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>   
>   	return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index c3f73a2a911b4..b86288a69e7b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -216,12 +216,11 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	if (!amdgpu_sriov_vf(adev)) {
> -		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> -		r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
> -		if (r)
> -			return r;
> -	}
> +	adev->jpeg.supported_reset =
> +		amdgpu_get_soft_full_reset_mask(adev->jpeg.inst[0].ring_dec);
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>   
>   	return 0;
>   }
> @@ -242,8 +241,7 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	if (!amdgpu_sriov_vf(adev))
> -		amdgpu_jpeg_sysfs_reset_mask_fini(adev);
> +	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>   
>   	r = amdgpu_jpeg_sw_fini(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index 5a69a44e0f855..1892c278ea3c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -177,7 +177,7 @@ static int jpeg_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
>   	adev->jpeg.supported_reset =
>   		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
>   	if (!amdgpu_sriov_vf(adev))
> -		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>   	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index d6b565c29b4b2..0b4de0c6476ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -123,11 +123,10 @@ static int jpeg_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
>   	adev->jpeg.supported_reset =
>   		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
>   	if (!amdgpu_sriov_vf(adev))
> -		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> +		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>   	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
> -	if (r)
> -		return r;
> -	return 0;
> +
> +	return r;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index 5473cbaa5c0e8..e622db1f818bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -200,14 +200,13 @@ static int jpeg_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	if (!amdgpu_sriov_vf(adev)) {
> -		adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
> -		r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
> -		if (r)
> -			return r;
> -	}
> +	adev->jpeg.supported_reset =
> +		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
> +	if (!amdgpu_sriov_vf(adev))
> +		adev->jpeg.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
>   
> -	return 0;
> +	return r;
>   }
>   
>   /**
> @@ -226,8 +225,7 @@ static int jpeg_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> -	if (!amdgpu_sriov_vf(adev))
> -		amdgpu_jpeg_sysfs_reset_mask_fini(adev);
> +	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
>   
>   	r = amdgpu_jpeg_sw_fini(adev);
>   
