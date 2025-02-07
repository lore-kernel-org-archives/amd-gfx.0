Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A719EC02192
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 04:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FF710E247;
	Fri,  7 Feb 2025 04:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DjbwiACb";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B6B10EA17
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 03:56:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPl07+kfgsoGE69gzbOk4wA0KK7t+fE6vMjJ2pYaDHH+muhaRH2WxDBQDAu+IY44gGeKVMFu+/+BpB2et37E9FhLIfJnYuysu5E77e2/mrlxv3W27nP8BDFp4BQfzzF9ei4lZqFRQ2Di0bClmGUng9552p+L5ZHsoeF5kwWp4KH4osPwtK7WtAmsCHVZmI02o6zO4DYTPEOecsfHm/hpxFho7XhImBjE3jkELRdyW/Lgetfs9sD+UkipYuwcnv2eBUcUKWlXNdeUgesKsPRsIQCF2j2s4MGS/h0zvQshAKJgxyqKHIzIvr37zujG9V75f3PkA3qw9igEazhBP5WYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxzWuhbFWnX73jpOJPH5oUuilSFL2Sr4/gGRoHSpqn8=;
 b=Hs/z803nt9Wmy1c/hCDzX7P94U2qydJwQc/havnmKyX7yV4XXdn36+4glmsXa0kQizmnDvmdjzhK5mfRjS8hUTHtuzVoriNikScEGIlBTSXsAfKshUz1STyvpyYNIhu5OZxKdbmn99+eHewjlx31q0dnvXMPKZ1njh2gOHvmFGpq2g7zf3yqQWfnaqxblyH4oM95OxZQ5HXbB/RKLFC4kXDtr19XZQYTt6tHNSzVfyJ5DixhqNiIKAm+YJ8FdsBU/1bZ+UMoQm01X8FwV+5Qb1+tg5JxdOGhHNS2Z0OsLpSO7Ys1QOLnTFxP6I9mhhUuE9DQXytdUunT7fbv3VAJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxzWuhbFWnX73jpOJPH5oUuilSFL2Sr4/gGRoHSpqn8=;
 b=DjbwiACbi630tY5YkR80nMtVrcpHQO2dtFyCEBENNasHnIQCyqlmbXb0j4fB/PUjV31OExQO6QfLRwbJO8+0R/LFbyUG5CDVrDDqbeawym95usLCyjZLnGpByk5lssd5iHTzFdSX0acWYJLoDHXSINknaZPS1U+YvQjjs+ZQ8FU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 03:56:24 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 03:56:23 +0000
Message-ID: <22d2c3e8-98f9-4ea3-9737-08e9812d312a@amd.com>
Date: Fri, 7 Feb 2025 09:26:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
 <20250206131258.1970391-3-lijo.lazar@amd.com>
 <CY8PR12MB743505FC4310A69D4B2C372685F62@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY8PR12MB743505FC4310A69D4B2C372685F62@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: fd580ccd-90e6-4f32-4511-08dd472b6381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YktDeVBFV1hreHg1RnZSWWNMR3IxQUhITkRzcUNFemJPM2U2Qm1vaW1rM2pP?=
 =?utf-8?B?cDF6aGdIVmZZNEVUQTAyN05TM2FWSFFQdVVhU25rdTNzdmxFd216alQvN1ox?=
 =?utf-8?B?bElXZW9wdU54ZUtEQ1lIdVpmQ1BBdWtGc2VLQlllM3ErTmtYc3FnTTgvZk9w?=
 =?utf-8?B?QTRqNHNqeDB0cVpEUXV4RkNGcnVicG1SbnBCeWlCdmErY1prWUFWQkF4NGJ5?=
 =?utf-8?B?dTkzQlNRVTA2S3RNNm5aVHJqZmpqOGFWbUVXVDRjRENETHRqY29Xd2VPLy9r?=
 =?utf-8?B?dm9LbjNnVVZKS2VOZEsrMjU3alRueUVxYmQyUmdXWUJ0QkdGelVIMzlmY0Ft?=
 =?utf-8?B?d1hHZnJmdFJFMGs1WllFSGpvODBibUJwaWZKZTl6NDBTTWJpK3Z5bGV0WGpi?=
 =?utf-8?B?aUJ6VDQvMUwrY2xZSkdqSCtXMWtvY0svNGhrUEgzeHQxeG1WL01ONE9aYWdQ?=
 =?utf-8?B?dW4wc3FVU1J5YkY1QlJFNk1OWVAzWkFaTTJ3UUpTbzBsRlRxbnNFVWZqdEIz?=
 =?utf-8?B?T2lpRzg3MEdWajBFRkRONng5a3djdG92bTk3QjN3RUxOSWh2WWJhZDZTajIv?=
 =?utf-8?B?OVdKVXdlaERWYzR4STV1MWVvMllBanQ3OXJ1RWRMM1ZlYlNoSG8rZEc2WmlJ?=
 =?utf-8?B?MGZzdnRUYWJpQXUvOE1QOFRPbXdUaURwcnNoZk10U05GQTc0Z0ExOHNaVkZy?=
 =?utf-8?B?d2tuT3BZNlo2L2QrSmtPNno0ODNiWTlrS2pGMFVUZmx2eWNHVHlPQjNEbm1p?=
 =?utf-8?B?S2F0bklCZTFVOUV5U3lIWnpaaldmaXplSTFNQkQvQ3NSWVB0Vkh0NW9Ia3Vz?=
 =?utf-8?B?N1FBYmlBN3FaaW4zcUlJQnUwSnFTbitqdlI2Wk1nNDVxaXBDS0xxcTRaTjha?=
 =?utf-8?B?R1QxK3h6UlVOcFRaT1Z4T2xZaUpWNzA1NXFwcWF6NHFqa0hidUh3dFY1K05X?=
 =?utf-8?B?bkljTnpnWFB4a1pGcGNlUXZGSG9tQktZeTJDZzV3UE8yckgxRHdZK2hoNXJC?=
 =?utf-8?B?SjB0dS9JOFJ5NlQyekdSM0VTQW5vbFVCdE5NTlFMOXFCMmcwdVZ5ck84OFdG?=
 =?utf-8?B?WnhIRmxlTU5vb3k3R1VoTDk4MEpsMEw3UDZHZGw2RjJBTHJ5aVlRYTNST3JC?=
 =?utf-8?B?WHk4SEFvZWJlSzcwYWEwLzZQSkxLaEgrd0xxSnVRakhtUUE4V21JZyt1czRZ?=
 =?utf-8?B?QWNRTkpSOXZOd1l4Z2Q0bGxLeW1lSVFVZ0tvblp4a3RsYlRmRlJNRTdHSnNJ?=
 =?utf-8?B?MHRUQzVaTTE5RXRxTU1FcCs4amZ2OHR1cEwwQ0RmUjBwRnFGNWNDekZpb01h?=
 =?utf-8?B?ODM0SjE1Z2lzaExMSkt0RDRNcVJURENKa21PdDJPems2bmFMUjZQTXlDSnNw?=
 =?utf-8?B?Ym1nelo0U3B6UkJ4WUxRYU13Y05xZk0xblRsUG0xWDh2VjJxSVNqSlhJcG9r?=
 =?utf-8?B?eHhGczVpdWNDSXJ5cVVDRVBtbHZ5TDJ6NkxMRjNSeUZGeWV4K1ZyaFpBUXpK?=
 =?utf-8?B?THhHWWZhdkU2d1ZPM2RWMEJQclVHNStsYi9RWlMwRkFhODN5bklNVkdEUlI5?=
 =?utf-8?B?K2I3V1JsTVNpdjBaYzIxbGZnRU9XSzRrZ3RBa3ZXbWhWT0JBRDY5UjJBVmZp?=
 =?utf-8?B?dFl0Y2dsTk80Vy9CTW15ZDlWaDVRejM5bFJ3VmtPZmgyUkVUalJqc2NEeTBk?=
 =?utf-8?B?cUZGbGIrL2dMa0sraStLcWoxNTcwNDlKSEdTTGoyaEQ2VU5EVC9DWU4yYm5k?=
 =?utf-8?B?WVZ2RHdFQURNTmUzaUpqNW5CQUhKZTMxQWFhTXoyTzJtclpITTVoN2h1WURu?=
 =?utf-8?B?dzFvaENkQUNXa0Nsc2ttT1ZlSlNOenQwc2VUcFl6Tlg4ZS8zVzRsOXUxMExu?=
 =?utf-8?Q?bEXPtuW+Bdom4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3JONmFCN3RZQ1VkKzBuVUwxb0FSWTA0Y0RWTU1iMVVTY2FlMlhHODFlOUV5?=
 =?utf-8?B?MWlDcVFrVytKQm9PblBSdHE3dTBsS0RtRnNiZklaakhVVVl6aklJNy9zeTRF?=
 =?utf-8?B?K08xYmY0MHhpdTYzZkM3dnZtSlpzeEFPS3hDS3V6a09EN2xtN2psZ1hodTZp?=
 =?utf-8?B?dDQ4VU5XQnRkRzZEOFdId1NWeVJ4UjVBeXRBNWpHMTltQVJybURONGFlZHhD?=
 =?utf-8?B?VGMzMzNaQjhNOTdJRXBLZFVjTFFzcGI3MmN0WThoVHdwNUNKcmtKa2tnYUhU?=
 =?utf-8?B?YTFsT1B4Y2N1SXNwUUpxQVB2T2YzcmRKYzRqUVkvcXdsZ0FtQzVFc1ZFRm1t?=
 =?utf-8?B?WlBPMjljYmN2dlp2di9xSGpBWmRmM0FtaHpqL2p3RldxSGFKT1pGN0pnUldF?=
 =?utf-8?B?OU10TDBKY21tOGhyMjU1a09XaE5hQmRtbWZRQ245bEY4bHk3N0xjVVhXTDk4?=
 =?utf-8?B?Y3llUmw5QjRHanhRZVNiTVJVdHAvZjFwQ3dLSm5ISml5U1pZR3BZREgwd3A3?=
 =?utf-8?B?bzR0NmdwOXZDQVRaWFFvZG8xclFVUzV4V2k0K0lGYnNrWlkzbUhYQU94ak9s?=
 =?utf-8?B?Z2piTDBiS3RKTWZzNlN2UzNQdFRRbG4ydm44cFhVQldIMUZYVnRkN1phZ3NR?=
 =?utf-8?B?V3hIVVo1Mnl3aUlxdE5Dd2tDNitwRzJwVW1yY0QxRGg5dUlMeE9zenR4akZC?=
 =?utf-8?B?aU03Z1J0OC9iZWd4eitUMzVXZTI1eWM4YUNKTWxyQW52dHlRZDVjOXFUWE9F?=
 =?utf-8?B?NUxPZG55QTRzeEdmS3NyMjNQb3lZOFlXeXZNRXBsWndKSFdTRXdDYjJ1eGV4?=
 =?utf-8?B?NUZzMkgxcnkwaXRYdjlHWnFlS0Zka1d5OXV1N0szOXN4T0FYMGI2cWZsNzNa?=
 =?utf-8?B?MGs1UllFZEZPeWMrai81NTJwYUl0QmtQTVBKRnVBczVLL2Fja2k5NDU2cVJi?=
 =?utf-8?B?cDhRRWFHdVlBcG9VRDNJVi9qQTBpalUwWXNOYm02cEZPdEI3aGZMQkpMa2Vs?=
 =?utf-8?B?Y0VBVXY3SHZOYUo0VDJER1Zjb1d3T2dJSmxIQldmUmYreXlOb3VjV2dZbHcy?=
 =?utf-8?B?SnZsNlM0MUlRZi9YRGcwb09PWWNIekRPendnQ2N0Z1dUM1dtRkJiRkVtSUlH?=
 =?utf-8?B?cUFPYjltYStkK3c2eGhpa3lxTzVkOGk0aE5COTh5ZS96aE5QNHVSRmx2bndk?=
 =?utf-8?B?Y1hKMlZqa2pMSWw2VWdxYVE3Y1Z5ZGZDZ1FYYzIxMzNpcXhDZFIyakRwdktN?=
 =?utf-8?B?bHVVblZ2b013eC9yWVd3MmUwUUxjb0ZPYTBuMUwrUjVVNkZrVjhaUWRmWHNV?=
 =?utf-8?B?OUpwYzJhMGtoa0RhZitjWFI4dWN0Y3ptTDE5Sk1pQ3lJOE9DSjZ6dCtuSG5O?=
 =?utf-8?B?K0pQT0FzdmJIU0N5TFVMYXZQTGJHbmMzSFBacEJoNlE1RGcyRkRXelZ6UFJM?=
 =?utf-8?B?RWhmTXpvQ21pRE9EYThzaU1xWE5EL1MzK0N4VllFNGJSMEJXQVFXbmY5R1JX?=
 =?utf-8?B?L0plLzMybkVrbjN4NXdCeURxNmw2OWJkTjUzcUJudzJ0RkFPL1pVeGFrc1V2?=
 =?utf-8?B?MFQyOWc5d0tIVERUcDBNSEFwRzNsbU9YMEJrTHdnMWZBUDVyd2xzWFU3ZGNB?=
 =?utf-8?B?aFpMN0hyZFBrbU9zVE1Vbm5MNEhJQTJhWXZZVFRQT1d2Y2ZBcldPQnZPSWhk?=
 =?utf-8?B?ald6VGhIcXVVRjNMRmRYRzg1ZHpvd09tckdwWnI0WDFaZVZ1OXhZUVVWSnR0?=
 =?utf-8?B?b2hoVkUwWkMwU3VYeVIyeDkvSDd1R1QvRnA4QVRzcXlHdENCanpFUTNDdnpk?=
 =?utf-8?B?ZkFhWVZCS0RDTC9hbWdTUGlyVVlRVFhJNFJRS3I4d0VqNDNHbk4yVjZqWWVH?=
 =?utf-8?B?VXlTOVRMQ0F5bnkzeEtTQWhXMlpJNkFQUjB1YnRHRXFvTGNwb2Q2QTh3UFRE?=
 =?utf-8?B?WXJndXNuY3dKOHJyYkF4UWJGb0MyZFFQWjdGTWlWZjl6ZzFJUXU1Z1RhclJa?=
 =?utf-8?B?eWo5L1hTaWJjZU5NRnJKbmNqSW01S1B2VHE4cjZxMWt0UFF6MjNLM1I3TWFw?=
 =?utf-8?B?Tk4zVnRlUFNjc3BXdVY0YmNObUxiRVZDZmZwRWhYdmM4anBnRUlzRUM0ZlVu?=
 =?utf-8?Q?PXCff+EMd3cqLsmeXyLDtDxrY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd580ccd-90e6-4f32-4511-08dd472b6381
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 03:56:23.8757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COd21AhWrNiCb1wV264xgZ4yvHqYSnd1pPkJIiKb2sY5TsPkSJCDwO0+QzW2jg0m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941
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



On 2/7/2025 5:03 AM, Kim, Jonathan wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, February 6, 2025 8:13 AM
>> To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kim, Jonathan
>> <Jonathan.Kim@amd.com>
>> Subject: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
>>
>> Initialize xgmi related static information during discovery.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 +++++++++++++------
>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index eca431e52038..d4eade2bd4d3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -2502,6 +2502,19 @@ static int amdgpu_discovery_set_isp_ip_blocks(struct
>> amdgpu_device *adev)
>>       return 0;
>>  }
>>
>> +static void amdgpu_discovery_set_xgmi_info(struct amdgpu_device *adev)
>> +{
>> +     if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(4, 8, 0))
>> +             adev->gmc.xgmi.supported = true;
>> +
>> +     if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
>> +         amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
>> +             adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 4, 0);
> 
> Can this stuff get rolled into xgm_init_info and called directly into amdgpu_discovery_set_ip_blocks?
> Breaking up discovery_set_xgmi_info and xgmi_init_info as 2 separate things seems a little confusing.
> 

Intent is like this -
	Set IP version info. This is the job of discovery and kept inside
amdgpu_discovery.
	Set any static information derived out of IP versions and not available
in discovery tables. This is kept outside of discovery file.

Thanks,
Lijo

>> +
>> +     if (amdgpu_ip_version(adev, XGMI_HWIP, 0))
> 
> Maybe roll this check into xgmi_init_info i.e. void early return if null.
> 
>> +             amdgpu_xgmi_init_info(adev);
>> +}
>> +
>>  int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>>  {
>>       int r;
>> @@ -2769,12 +2782,7 @@ int amdgpu_discovery_set_ip_blocks(struct
>> amdgpu_device *adev)
>>               break;
>>       }
>>
>> -     if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(4, 8, 0))
>> -             adev->gmc.xgmi.supported = true;
>> -
>> -     if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
>> -         amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
>> -             adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 4, 0);
>> +     amdgpu_discovery_set_xgmi_info(adev);
> 
> If you do the suggestions above, you can just call amdgpu_xgmi_init_info unconditionally.
> 
> Jon
>>
>>       /* set NBIO version */
>>       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
>> --
>> 2.25.1
> 

