Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757FFE77184
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2024 15:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F9810E32E;
	Thu, 19 Dec 2024 15:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rrm+2qMw";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D1E810E32E
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2024 15:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtFHysp7dJs1uBtL5ZRB+3ao7CFJQS2c7TPHXbL8OZ/LP4AUZjPKwr3xHVWFydvKfH7tVNLE/W16VfgFDrpks8uhxAZwUA9XWPWFuNSO4+MjrbSYMZAmcDp1AqU8YDc75fi8ko/4grAMZ7tQVuILjcSt78Ii4KCh2ZkNtjyyXxr8llDPHuAVUUDpjcK/9F7AcRrb6QfrFaQmeUJbCtnYbtXKyIfxPSnMSzwKMVGMT2DMitnAvIy576soiYp4rImlA3uwKFDvAT2m0iRHr0FPyvXbgpXF9S6eiTqjlbOVRqoNoHGSYrG7NLhKBH5WGjTJ34KGlXJ0ubcu8guhNInVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QY6EiUgIRHxGpt15weyuz28rO3BU1z9TniGpdOWOY3s=;
 b=QD/51UYNtSQ1jDPN/ZEO9tDnhAhKT2c0Ukh+DWXFnbFc5+jSxcNIO9945yfqkB4OuUXirsKod9/qtBMfqiNa9zJfxy4j/iAsR5Q3Wp4mUDtmWDIWpKmT30rsmvkzAC0kU3S2RdBsgJp8SZ1/CvaBVtTIMfc/Nk0WJZ3eDChHGAJ6HCT7rE25y3mk6Flhkt4Fczhny4+9WmNwzi4VpEoZfgva/BKAfUKFT6gu/VKT0q/VDwQzj4g2S8ZubZ+2TVTi0/TtzqOJH+AQkEY7fHnQq3gfurtDeum7V6h+caPsBQwZ2NbWVyFylOkyzt+1lWJusj6szgVCTSVqvX6uU7/oSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY6EiUgIRHxGpt15weyuz28rO3BU1z9TniGpdOWOY3s=;
 b=Rrm+2qMwq1Y+QXu6iQW9UGtYwHVdfPnU+zfaIHG9jafGDtjP6dXiM6egWmsaaUh8lKQLGtGuIuyrRAz8D6ju/ogBQ7y15BHWDjAJFuiIKMGL8lNM0DjiY3AsdysnljV6WUqKC/t1nLW9d78IhOUbb3C9dHLr1QjtjBso4s1GYUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.14; Thu, 19 Dec 2024 15:00:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 15:00:17 +0000
Message-ID: <35a512b1-e5d6-4466-ae3c-90f2103dba6a@amd.com>
Date: Thu, 19 Dec 2024 16:00:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix Illegal opcode in command stream Error
To: Arvind Yadav <Arvind.Yadav@amd.com>, shashank.sharma@amd.com,
 alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20241219145632.15734-1-Arvind.Yadav@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241219145632.15734-1-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: ca65c520-f9bb-4536-69ff-08dd203dd9cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGVNQnFHWmJxZ3JvVzk0VFBUY1V1WWxPNGROZzM1SFNPS2pBbE1uWlVuNVk1?=
 =?utf-8?B?NW9CT0g4T0Z6KzFaQXFPb1F1NjV4ZU1pMTduam1kREg2S090bHc1QUFxTEV1?=
 =?utf-8?B?YlNSaWJlZ2wwVUFaTml0bzZDVVdtendMREovTDMzRWVDbGFSb3JtcVBGYjBn?=
 =?utf-8?B?ZGxyR2ZPMFlPNHBPSlhBSEFlUXJhNGhxS24xcDk1cFdqTWJYaVpkakNBRGhm?=
 =?utf-8?B?Q1lCVTRMYTFaUEdVR0hrRnVpKytsYmo0R243akVaM0sxellRdHBnMGxqeXRa?=
 =?utf-8?B?a1ErTTVyU0Y5dHZEM2YxYTdad0VaMWp4QUlFeXU5UWxDOXNkNmRreHBVZzVr?=
 =?utf-8?B?NmpOb2VjREEvU1VXZUJHcFYrdVowcEVLeUxOamJVTVNMTlo3OWhmSklsbU9Y?=
 =?utf-8?B?Ny9QRzlZWjhTVytJOHdmd3VDY0xKakVNTU5xbTVibng4QzRhUnExeUM4YXVo?=
 =?utf-8?B?VXowV2g1akoyOW5KdElzWFZhN041VWh6UEkxMnJPaUl4UDhzREtDc2x6d3NN?=
 =?utf-8?B?amtYOU1qdXZGbW02RnpKcXJWZHVLTFdyMHN4bTVzeXRYOUdFcEFCai9weWhH?=
 =?utf-8?B?VnA0ZGYwaVA3eUF1MGpPY0NLanE3ZFRDVTVEcFlrRkdCZmp1TkhZYWpDNElX?=
 =?utf-8?B?bkxVc01IZi9QdUVjRjA1UEhLYktEb29KNzMzWFFOdnJEWlJwUi9YdWdwS2lI?=
 =?utf-8?B?ZVJkS0h2dHd6M0d6L05oK3YvQTV1K1VnOVlJVlBSemVHSUpmT1k3TTRlbXA0?=
 =?utf-8?B?c29qeDVybzlnSEJTUWsweXpnRkdNaUgwT0FabDIrZzNpbnphcXUzQXNveHFr?=
 =?utf-8?B?bUZZQTFVUzE3MThaL3d1a285ZGdvU2NoUXl6TC95cFUzaTBDWFkxYnVuZ3Fn?=
 =?utf-8?B?SmxkZzhwU0lnVVc2YXhMY2R3Z21EMVlITTBVRmF0UnhSeFBnbGtqVEViYnhh?=
 =?utf-8?B?TFJ1Ni8rcWFVcENBdTF5bXNOMXMvM3VoV0EzQUF4aXJvcUgyenZQQUV1YUYw?=
 =?utf-8?B?NmwrUmlwSlVTNXd5SUlkVVhWVVlIZHBWejczMFk5Z3FOOWRPN2ZYTUdnR3BB?=
 =?utf-8?B?UndiWFR1Si9reXdjTis4Y1ZsYVhKN1IzK2sxUlpEOUlWaDJFNkkySHIxaDhv?=
 =?utf-8?B?dVFTd1FCUDZ6dU1ZckxMOXdBWXd3NUZCT0lkVWkzb1VOY2owZForUUpEYnZ0?=
 =?utf-8?B?bkdDdVNvNlk0V2YvdU5YVUFjUm5rSC9NaHFuVjRlS0JkdnZVcFZFNEl0Z3Vu?=
 =?utf-8?B?aDQ1M0pya0xSZDJDRnBOY2dVQVowUjh2bzlXU1g0RVJ1b01IZkk1bElTRVN5?=
 =?utf-8?B?RWJqNWVlY2FWYmJxZzlZRkE1SHhlZ3hkZzRZRHFyenVrcUlITHNpamlCSXZH?=
 =?utf-8?B?eCtMR1Q3dENuc2NPcDVhRnJCK2Y0TENUcG1sVkhsLzlUNnZPcjNhVDlUZWll?=
 =?utf-8?B?eGxlaHN3UnJ0eGJxdnVrYUVndHVOQTRPUExYY2ZrUENEOE9udDN0TElFL3dT?=
 =?utf-8?B?dGl1NnN0NVJtelpVbkUwM3Z0YkVIQnhabmNGTmw5eStpSVNHb1o0VHNha0Zp?=
 =?utf-8?B?NUdYa2FLVDlyR0p3WEFEVXJWZ0tQVXJIYUFwMEwvc1hlbFROaHRNOVh0VDJ4?=
 =?utf-8?B?MDZYNEtXSlp1ZndHbThkWWpjV2VqOG9oeFBycXBoOEVRckp2WERjTFhjU3NQ?=
 =?utf-8?B?WFNnNWs2MXoydVludjJ1WDV0Z1BxWXQ2TUhqakFURExIbmljQ1Z2MEdFVjlW?=
 =?utf-8?B?L1NDMU0yUzMvSk1xcVl0blB5U2VWL0FLTXFUR2ZmZjJ5T0dlRmYzUGRRUjVY?=
 =?utf-8?B?R2toMkFnUVJjUjFMT0RYRHhIczB4MktJVjhKTW41VHpYU1R4eVRUamV1VHBP?=
 =?utf-8?Q?9NSqwjoMIIMBx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVE5ZUlvejNjU0xYamtJNmhDYnBQa2VIYjRhSUI1dmNQOHNuOHN6OW44OUVy?=
 =?utf-8?B?V3BNVUhNTHVkOS8valRVOUdCLzVlbHoyRHl1TXpzbEVSUkdBdHBSOXQxOTZk?=
 =?utf-8?B?VUc0UG5hMEVjaitESnB5STUxU1IxSVQrQ3RvcmQybUE1ZFZPaEZ4RU5iNTY5?=
 =?utf-8?B?eHRaRGNWUFVkWGowZ0E3TUhDMUsyVll1djJDaHpmRm12Smo1WmVESW9icWF4?=
 =?utf-8?B?YTFQODAxTk1DUVk4SUZnckdRQTBEam8rcWRLN2ViTlg0ZVhkZHNPVkJWRTl2?=
 =?utf-8?B?UGIyZFVsRVordzE1SVpjL2ErM0ZoanhPVlNNWVF3em55a3J3dFRPMDI0MFRk?=
 =?utf-8?B?OGE1aTV6T0hFaWl0ZFlESmczMFg5S3BDSytKTFJTT25oZllwMmhLNERjcFk2?=
 =?utf-8?B?SThMaUxNN0Nqc1M5K29lYm44NGhEVmNYMDlNRUZHWitSQkVhRUNBWUkxaVNa?=
 =?utf-8?B?MWFmYUZISk5mRldMQkFOZ0J1SHNXanNLV01ycHRTc3ZCdklmenVjbTcrVFNm?=
 =?utf-8?B?Ymp5OXhZRjZxQkFYQU9vZ0NONFNscFIzdGkvekF4dGNMa0U2Rzk1MEVBMW9B?=
 =?utf-8?B?TFBkdVJPTTRTZ2liRms0eVQxS1VlNjJhbUtlNVZNcWlkOEllMytiMlRtYmNn?=
 =?utf-8?B?NkxXd25mOFB0WWtPVEVtaWpPaVV2SGs1Y1Z6NnYvcmlkcFBpUTZLS2tsNGhh?=
 =?utf-8?B?U1dCYWRPazMwa2dxS0JNbitDazFjS3A5dG1rK2J0YzZjNlJvMTlzYmRONUpx?=
 =?utf-8?B?S1RGL2x3czllTVBCby8rTldTVzNtYmp3RjRRUldyM1FnUlhjeUdwSWo4U3Rj?=
 =?utf-8?B?Nmt6SkhPQ1VKdVVhQjNRRWJLVkRZUjhtbGZJcWQrVnlFTndMNWFGcmRQUlFl?=
 =?utf-8?B?MytFOW50OXUvZ0FwUHRmbS93VmZjWkpndGI3WEx6aC9QWll4bFBaOHErV3l5?=
 =?utf-8?B?TzdBRk5QRTJpR2lSSHd2M2NkOFJJbE1jUlpZZndyN3lOL3d1OHBVRVc4eHhj?=
 =?utf-8?B?L3pCUFRrUjdsZ3RVOFUxbExteWVESDdXZDlXMkg4TkFBTnl0bHlCdXBtN09k?=
 =?utf-8?B?dTFPNUw5OGoyTUc5RU8yT2RMVCtXYXl4TXEwTUNpaWNodS9nRFg3cmg3bXlx?=
 =?utf-8?B?dXRxUmszRnI0N0NXcXhZczZnVUkyOFk4cm50a2ZEOERsWjZlN3d5ZWtsYkRs?=
 =?utf-8?B?NEdXVGxjKzhWc3g2dGU1VkJDTURLbVZ4TDk4eFlPbHRkWE1PaHprMjdwSm13?=
 =?utf-8?B?UUZUWG1oQ0RIQW1FUE5ZNVhVbkxyait3U2ZSMUNpUzVyTWFVT2tqVUI1OXpt?=
 =?utf-8?B?TzdOZ3NieHdyenF0WldXVXdaeG9xSXgxRURQMk5OeG5QSXo3RERYWGNMM0R2?=
 =?utf-8?B?ZldKTUsyVy8zMVRuajBMWW80Njl2SjYvS1dpdGxKdUR2bFkzZTYxRkhEQ2ZV?=
 =?utf-8?B?QmE3c2p1MWd6RmFUMkJGa3ovS2FyWTZxNmRvK1VJOWtKMjVzWWlobm9DQTBq?=
 =?utf-8?B?d29XVFNqNUNJYnRqQUNXQXFMYXhhUURldlNXRWgrT2kwYnBQeTBwc0hCK1RO?=
 =?utf-8?B?bXMwL3JsSXBnMlUxV2c4aGEvNmpwMTlnUzBwUnRkaGEvOWp6NUhabnl0ZUhS?=
 =?utf-8?B?QTdOclpwUnh2YldodVhTdnpSVk50U0NqZmZ3Z1ZFaUx3eE50WXp1ZFc1STVx?=
 =?utf-8?B?bElrTTQxYmV1R1ZaclFvZzNuVmp6MUp2TmMrSjFTQS9tSDdxNmV0aThlbE9y?=
 =?utf-8?B?OEFKRlJQM09nT0Zlc28rVlJOUi8yUjI2TjBlT05HQ3N1cGJadm15VUphK1JP?=
 =?utf-8?B?TzR1RVY2dG02aTNzd09SVG1UYkFKdlFIbFVYSEplNDVldDJJbWF2NEJ3azI4?=
 =?utf-8?B?dStBMlVIUEJPeTZ5T2NZNUxjck5ZK1ZsT3I4SkpidzFHTDk5dGpaL0x0RG9x?=
 =?utf-8?B?VzlCR3pnTkhSd242MlpNWW5zNFlTQVQ2ZkZIZUNJc1BVakR5OHlRSkdwNWhz?=
 =?utf-8?B?NGZicWQvK3Bic1FqMlR5VEplNldKZWhlTmI5RHRLNmxkZDlTNHFLSVFYNGxt?=
 =?utf-8?B?cExsZTRpaHFtZ0F5SmNLU1A0TFA5NzRBVmpYNWJ2OXphYm5HVzJIUXNFY3Fn?=
 =?utf-8?Q?yHkVXeqMPECNI4hOnbA7KERzK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca65c520-f9bb-4536-69ff-08dd203dd9cd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 15:00:17.7440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZyxIia/uBUWQAH1FFKKahiwI1rqYphh3ujM3zOMLjBTwKZnJTcTx3eckVXyh1Aj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
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

Am 19.12.24 um 15:56 schrieb Arvind Yadav:
> When applications closes, it triggers the drm_file_free
> function which subsequently releases all allocated buffer
> objects. Concurrently, the resume_worker thread will attempt
> to map the usermode queue. However, since the wptr buffer
> object has already been deallocated, this will result in
> an Illegal opcode error being raised in the command stream.
> Now the usermode queue will not be mapped if the wptr buffer
> object is freed.

Clear NAK to that approach. Instead we need to suspend the queues and 
prevent them from restarting before freeing any BO.

Regards,
Christian.

>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 22 +++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index c11fcdd604fc..378a6284e05b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -28,6 +28,21 @@
>   #include "amdgpu_userqueue.h"
>   #include "amdgpu_userq_fence.h"
>   
> +static bool
> +amdgpu_userq_validate_bo_mapping(struct amdgpu_usermode_queue *queue,
> +				 uint64_t addr)
> +{
> +	struct amdgpu_bo_va_mapping *mapping;
> +	struct amdgpu_vm *vm = queue->vm;
> +
> +	addr &= AMDGPU_GMC_HOLE_MASK;
> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr >> PAGE_SHIFT);
> +	if (!mapping)
> +		return false;
> +
> +	return true;
> +}
> +
>   static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
>   {
>   	struct amdgpu_userq_fence_driver *fence_drv;
> @@ -390,9 +405,12 @@ amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)
>   	userq_funcs = adev->userq_funcs[AMDGPU_HW_IP_GFX];
>   
>   	/* Resume all the queues for this process */
> -	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id)
> -		ret = userq_funcs->resume(uq_mgr, queue);
> +	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> +		if (amdgpu_userq_validate_bo_mapping(queue,
> +				queue->userq_prop->wptr_gpu_addr))
> +			ret = userq_funcs->resume(uq_mgr, queue);
>   
> +	}
>   	if (ret)
>   		DRM_ERROR("Failed to resume all the queue\n");
>   	return ret;

