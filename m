Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BABD40D13
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 00:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E55E10E640;
	Wed,  6 Nov 2024 00:31:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C0olJjqy";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94B1410E640
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 00:31:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eue2+E1BIt+e1Q4f1Z0tf7cIG1fBQ649Ma/8dt5nKtjgL33B+PSP8S5FVjHN0QJZwt62yhgLqh3MneFUgE8ynxb4cXRvM3NStD+0G4kQSdgQlW0WRWMkoOg5vZWL0B57ey7z9WdNMG5hgJSmV26WiHE2eBlnuLUKKtFPXBUuP4jIKAwWXiRG6TZX4Kmf0Z5ojygJLxZrc7Mb8pwJ//JAyCvE9LAkEIE9Zuoxz8j73v7wEQyg2dcNAyveVvcKR20B6SbHjBYtpnfG0/iRqMsdFnZVMsh7P1xOcSI0K9y2nkjWpUnc3CkMCF0FseU99ERmXzB9h+3vsFIhgUnMQ2XOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQWxO/VawBYguzyQibO3pok4S3oWC6+mPRqvaRH8Fso=;
 b=ho1zqamDyqx+rUjm7GpvEgJu6LEhV4NveaZG4X+jCKhrb2v9JdCQNtHbW8Vy813n4akkhNmDzM65jAT3ZpGObmARcwP5YrEr4wpwLS78cvdWO3Uib9M3y6IJ/dMjHJzwtbIPcHmw8wr3CI1BHBrQWP6z6yAzT85dFL/EILARrL0CtV/wvJE01b280u6hYvkRcRxvWA5MPUGr3peLIBv8w88ZVTKPXXopt82pbymTPjOfPPqAhEh0gwxAMQGdX9bGYJhgqU6lKPoBXEGAF+MJzT1A9owkEeZYVT3gEPHRhJMXNW7brbx4ErZVois4RC9O6cm942OFJ2S6jkVWCR8sag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQWxO/VawBYguzyQibO3pok4S3oWC6+mPRqvaRH8Fso=;
 b=C0olJjqySe6Om/j0eGcW407GLRY4ShxCRRzql/rHZEaolz/IB4p09rXbtp/9mD6BPJvxIGzW5AE5nVrnZPATn9lrPnB2PbTkBuSIhMtanuB87NROR0vn7DP/JNn4DLM2dkGhXAOj8WSvwTaRAxw5wreiqku4cniwweo430CVuCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 00:31:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 00:31:26 +0000
Message-ID: <db7208d0-f36b-4223-a6da-b8b050f7a074@amd.com>
Date: Tue, 5 Nov 2024 19:31:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Differentiate logging message for driver
 oversubscription
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241028214014.59940-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241028214014.59940-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 97337fe8-ad7b-4645-28fc-08dcfdfa59b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkRpQVE2ZWJiL0E5ajlIMDZRcXRhbmpZQTlGOVdSV3h1ZlBzNGp2RGo3Y2hG?=
 =?utf-8?B?MTRDN21hcnZBSmJ5QUUwQzl3eWdxWitsSUx4c2w0aEorSXhRV2FRYnNkZkhU?=
 =?utf-8?B?MldoWlVBU3dnaTdJaEh1QVh3dVRBRWRHS0RldHNGRFplTGRra3JkenV3MnUy?=
 =?utf-8?B?M0NQL0lYU3U5Vnp3TFlIRmU5dE5YWlBVREJPYW53Y1d6NGNudWNGZG5PT2NQ?=
 =?utf-8?B?SlF4cVFQbmU5Rk1sQU5jNTM4VUVFVFg4L2VPNkJSZTZjNWN1TFB1RHEzMTdn?=
 =?utf-8?B?S2tpK05SL0NGdTNjSC9iUE80UnBtWXlQNVJEd0V6STBHT1BxeFJKa1pwNjJN?=
 =?utf-8?B?bWdXKzlSMnZvdC9XYVprUk9NODRsYWhoMGgwM2lTUktPcG03ektzMUxCNWxr?=
 =?utf-8?B?NU93RVBPbXlLb3BlaDROQzR0REVCZEVRdERmVmFKRlJKMXEwREl3QzVJblE2?=
 =?utf-8?B?NkdRRklwSkNCb1JQUGVqaHU0UzlMQXZYNXZZM3hjZzZjcGNJOHdhWmE4WnlL?=
 =?utf-8?B?WDdwZmhXTGs4VGRPcEJRM0NXTVMyRnFsVXJUSXVQSVc3aUpsR3FLU1h4V25v?=
 =?utf-8?B?U3dvZm1xT3cyWU5UNSs3TUdGeGl2cHVwTnFHZHNpbmZyWUFrSnI0eGNWMTRE?=
 =?utf-8?B?R2pTWnRvdEVVd2hvcnMxdk9oTUhzMHg4SU5tRVJ3M2NXRjJUSjVBRmNpQldj?=
 =?utf-8?B?M3p3bkNYVDYxajZLc3d4VUQxcXBkbzBYL0xJRDdPZlZ0RzZWY3JxZmtxUFg0?=
 =?utf-8?B?MWFYczVUd3lpK0xtS2JwQU5JM1I5SzlFZGMvR2k3QmI3Mks4aXhLeFRPVE80?=
 =?utf-8?B?RXN5S2pPa1hGQVdwckRERW5HYzRvdlpsZC82UHQvMlduVlB6dzhGa090b0Nq?=
 =?utf-8?B?azlQamFPNnlEeVBhaTc5emVwcld2bjM4VlVCSXlUTjZWWkY2TW5lRzhxM2Ny?=
 =?utf-8?B?cWFHWVlmUnBxQnYyNUVldVdheUtCdmdGbUo3WVA4TDZtekhnTHlDZWRidmw3?=
 =?utf-8?B?UWZ5WUxtdTdIQnRWbUhOeG1yRkpYTVhUbkpmNndpVFhKSEs4dDQ0ZVl2eGI5?=
 =?utf-8?B?N1NtTlhIUFVUSmRTRUk2ektEVjlEQXpuUnAxZGF4S012SkVJeEJzWE4yenZN?=
 =?utf-8?B?M1BVeEF5WWNWVE1PYXNXMlZSLzN5MlN0c0prM01pamg1cDFpVWZkcXN6ZU5z?=
 =?utf-8?B?YzUxRy8vRXllOGxjRnJ0UmRzMXVqUWtjeW1iVTdUVFJ1SzhkaUNPY1pyRXBG?=
 =?utf-8?B?aVpnRElqQVVZcDBNZE1uK3MzMWNXN0VGeGJGdlpwb2YrMlluZTExOGhpaFVO?=
 =?utf-8?B?azBVT1ZQRVpUZ3NVUmd5eUd2aEtWTGFhTld6V2dHSTJ1T05aSWp0T2J6QUhm?=
 =?utf-8?B?eGcrOFJ6L2J0T01mYWF2MFZoUTlnazd2NlNQZGFQcnhkbjAzVDdiaTc0aHdU?=
 =?utf-8?B?UnZBY016SVppVVVsUFh2b0t3Y2VqbU9leVdUOEU2ZW8wZzE2eCtKNEZTbFZX?=
 =?utf-8?B?WTkzb0MrODhnQVRxaVNaTXBlK0IwMDkyRUdyc0UxOTNJRFV1K0RxUThjRm5a?=
 =?utf-8?B?Um03VGVBdWQvUEhENmR2aWhoNlFzQk0ydW5Dbk9lUGowbmhTdlJjdUwxMzVa?=
 =?utf-8?B?ZnJpdE1qU05SWjdnbWpZT2RIT0pVeUZoamNvTUZPeDl0cmUwRHIyOUpOazd1?=
 =?utf-8?B?ZDRuaHlRRkJjL1dkeWFDdTJtNzVtMm1pU29BNGIxUEg2ejZHeUJ3K3JMVHpu?=
 =?utf-8?Q?EFSUMCFdSPk4aYKpTk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SktRN20rZUN1eitOTHFCZEljeml4eG9FTGMzeUg2dCs1UXlTYzhFZ3lGYnJQ?=
 =?utf-8?B?T3JxVWRZRDZ1bnlic1FlUUhwK1oxSjRhYWZKNlZzdnhwUmp0bDRveUpXRW5K?=
 =?utf-8?B?QnVFL0hnU2M2amZnaDRFMG1obkUvTWxjMlhxUWI5clRTaHozSk1xa3RFTW8w?=
 =?utf-8?B?eXpGOThzbWtkL21FNEpUN0NseXBTektrYzJJMVRmSkNhelpnbjh5UC9OK0NR?=
 =?utf-8?B?aHAwMDlHdW9QNHgxZ25zaDM2WS8wTGVaMlhwNThCejJ1N2JDczJDaUlwTHdv?=
 =?utf-8?B?Rk5GbVJxTEV4emNhUjVFaThPYytPa0dhVHFwZDc1bkQ2ZmN1L0hRa2p3ZGov?=
 =?utf-8?B?ZUNPNTJ1RlhBcVhMS0JXUEUvZVY3alUxYVpwQTJoRkdpcnJTN2NQOVdxT0hN?=
 =?utf-8?B?TEw1Q3JGRVJvdzhJdSsxdDZoZmh3azFja1Vnd2g5M0xpKzVWTFJGWmdMcGtM?=
 =?utf-8?B?RTNLTkFCWkxpZGJsdlFqdVBQMjkvWXBlT0pkeUZnTlZLczBCSXFEQUtKUGFm?=
 =?utf-8?B?NWdlT2RVQjVjejdRelFHSTlNUXdON2MzWUovcXg3cU9ZUlZ1RU1CdTQ4c3I2?=
 =?utf-8?B?b2Z4OWN4OXBHaWpHaklZemRKTndkN1BMZzJ3S3VMd1lxanpYYjY2b0JGWlRm?=
 =?utf-8?B?MG94MEVIZFV0N202dFpKaVJzVURzYzM2ZzlCc0RKL0lSR0IyUjBHVGV4N2l6?=
 =?utf-8?B?NDdNcGZIWVZNOElZa0I0bUZDejdXRFJjTlkxYTdXNk5EcmhicVFGWDNJbkRG?=
 =?utf-8?B?SURnb2hJT3MxQUh6VzJUNHlDSjFmRHRURk14dFB4MmxTNkN0R2swaWVaS3Q0?=
 =?utf-8?B?U1dENmhBWnJ2bk1BeUNyQzVuRVNNVk5vMUFjc3lNWlQxYTJqU094aWxBZmNL?=
 =?utf-8?B?Z2V2eHhqOHRqb2FIRi9ZemVCQ0M3cjJuUXhnZUt2dnRXSXVrcXkyRHJoa1pj?=
 =?utf-8?B?NjgwMzR1UHlpL1ZzVktUQmdqRWhrTVljWWNNMUI0Y3ZEdGx0LzkwQVRsZVBM?=
 =?utf-8?B?VFFTKzNIS3A3OWtZaUtyOWRGMGFpMEZMSEtWSFJJSDRwanYzUmFFZ1lVV09G?=
 =?utf-8?B?Y0F6YzVSaGNjcm9NaXVrMWMva2c5clJSZFhjeDl1V1JGL1lQWE1aYlRzOVYv?=
 =?utf-8?B?Q1VUeExEQ080eHJBd3phS2xCL3hxMmhrUnk2NjVGQkNYWnFxdWE0WGxiRGVQ?=
 =?utf-8?B?S1BCM21mM0FrTmw2TWRwcTFQSXBEbXBmYVJoMzNIN3ZoZ05NeEVnNDhza2V0?=
 =?utf-8?B?Sy8yYW13LzRKRXpUeDFnR1gyR0dTTXlJY2RMa3kxalFqNFJ1M1R1ZFpYUkti?=
 =?utf-8?B?RG43WkZtYi9Qb1ZZSEQ5Q1dxSTJKMWlpNkF0SUM5YS9ja0JQWk5JQUVJT1dU?=
 =?utf-8?B?K0FwVUl4TjZQT3dldW1WbGlBSVdtaHB1K29Xdmt4b3Y4WE03TDd3aTJGSEx4?=
 =?utf-8?B?NmIvaC8zekpLK080Q2Qwdnd5ay9CcStmU1NPZ3VvSHg0VFRSN0c2OXdvOGpL?=
 =?utf-8?B?UkVPUlJ4U2JaQkNkWUFMZ2p2d1ZGdzlvdjh0VVRHSTRmbW1XWVBRNmhzeWUv?=
 =?utf-8?B?WldWNERSM1RHNXVRYm93ZTNyN3MzSk1kd0ppNm1QM2pjd3A5ZGZ1bVpXOW5V?=
 =?utf-8?B?aHN2eDVFSVBwQzlyUDZSK0FxRys4UTlJcDFiekk4aUkrekRlemE5d28wbjE5?=
 =?utf-8?B?TG9xalhYS05TVkhnT2JpMzJRRFp1WHlreTQrdWtuS01FakVxWkdkRkJ0cUV3?=
 =?utf-8?B?cGRNVnBYZHJRYUdUbWVWbHFVRzN4R1gwODZjM0pXanNiZnhVOUQ1c2E3aFdB?=
 =?utf-8?B?a0FUS01UeEVjd2RGZG11cHp3LzF4cTFnOUE0aW5xV0QrQVNDMUJmMG4wMThS?=
 =?utf-8?B?ZzBXTEloemhmSXVTNjVIQ3pKMEtQckhqZU5BVGlhSVJNSFlGUi9GT2IzTnZ1?=
 =?utf-8?B?QVJPSGd6cWI1Q2pjQzF2c3VVc2dvUUlpY3QxMVBObDRNS1hKWmhEQkdsSndy?=
 =?utf-8?B?cmV6VStrTU1ycVBKY3JlMWRJRmQyQklqeDJPUkZxSEpuYy8xUWYyQnZjbDJy?=
 =?utf-8?B?aFlYcnlHdWdjZHM5NzVFek9OaTN4SEp1ZkJEZCsvVW0wM283dnluOS81L3dO?=
 =?utf-8?Q?yvUTioQmY+8RJOoN7bEVZRwPz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97337fe8-ad7b-4645-28fc-08dcfdfa59b3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 00:31:26.9574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5uFcYqpPkWSJylBoGiTiPsih2CZbJbo/q628XDqik75uIR0wgb/EiWhoYnQH74VpUyPDi/ivuwapfBo7PzuSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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


On 2024-10-28 17:40, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> To allow user better understand the cause triggering runlist oversubscription.
> No function change.
>
> Signed-off-by: Xiaogang Chen Xiaogang.Chen@amd.com
> ---
>   .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 55 ++++++++++++++-----
>   1 file changed, 42 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 37930629edc5..e22be6da23b7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -28,6 +28,10 @@
>   #include "kfd_kernel_queue.h"
>   #include "kfd_priv.h"
>   
> +#define OVER_SUBSCRIPTION_PROCESS_COUNT 1 << 0
> +#define OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT 1 << 1
> +#define OVER_SUBSCRIPTION_GWS_QUEUE_COUNT 1 << 2
> +
>   static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
>   				unsigned int buffer_size_bytes)
>   {
> @@ -40,7 +44,7 @@ static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
>   
>   static void pm_calc_rlib_size(struct packet_manager *pm,
>   				unsigned int *rlib_size,
> -				bool *over_subscription)
> +				int *over_subscription)
>   {
>   	unsigned int process_count, queue_count, compute_queue_count, gws_queue_count;
>   	unsigned int map_queue_size;
> @@ -58,17 +62,20 @@ static void pm_calc_rlib_size(struct packet_manager *pm,
>   	 * hws_max_conc_proc has been done in
>   	 * kgd2kfd_device_init().
>   	 */
> -	*over_subscription = false;
> +	*over_subscription = 0;
>   
>   	if (node->max_proc_per_quantum > 1)
>   		max_proc_per_quantum = node->max_proc_per_quantum;
>   
> -	if ((process_count > max_proc_per_quantum) ||
> -	    compute_queue_count > get_cp_queues_num(pm->dqm) ||
> -	    gws_queue_count > 1) {
> -		*over_subscription = true;
> +	if (process_count > max_proc_per_quantum)
> +		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_PROCESS_COUNT;
> +	if (compute_queue_count > get_cp_queues_num(pm->dqm))
> +		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT;
> +	if (gws_queue_count > 1)
> +		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_GWS_QUEUE_COUNT;
> +
> +	if (*over_subscription)
>   		dev_dbg(dev, "Over subscribed runlist\n");
> -	}
>   
>   	map_queue_size = pm->pmf->map_queues_size;
>   	/* calculate run list ib allocation size */
> @@ -89,7 +96,7 @@ static int pm_allocate_runlist_ib(struct packet_manager *pm,
>   				unsigned int **rl_buffer,
>   				uint64_t *rl_gpu_buffer,
>   				unsigned int *rl_buffer_size,
> -				bool *is_over_subscription)
> +				int *is_over_subscription)
>   {
>   	struct kfd_node *node = pm->dqm->dev;
>   	struct device *dev = node->adev->dev;
> @@ -134,7 +141,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
>   	struct qcm_process_device *qpd;
>   	struct queue *q;
>   	struct kernel_queue *kq;
> -	bool is_over_subscription;
> +	int is_over_subscription;
>   
>   	rl_wptr = retval = processes_mapped = 0;
>   
> @@ -212,16 +219,38 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
>   	dev_dbg(dev, "Finished map process and queues to runlist\n");
>   
>   	if (is_over_subscription) {
> -		if (!pm->is_over_subscription)
> -			dev_warn(
> +		if (!pm->is_over_subscription) {
> +
> +			if (is_over_subscription & OVER_SUBSCRIPTION_PROCESS_COUNT) {
> +				dev_warn(
>   				dev,
> -				"Runlist is getting oversubscribed. Expect reduced ROCm performance.\n");
> +				"process number is more than maximum number of processes that"
> +				" HWS can schedule concurrently. Runlist is getting"
> +				" oversubscribed. Expect reduced ROCm performance.\n");
> +			}
> +
> +			if (is_over_subscription & OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT) {
> +				dev_warn(
> +				dev,
> +				"compute queue number is more than assigned compute queues."
> +				" Runlist is getting"
> +				" oversubscribed. Expect reduced ROCm performance.\n");
> +			}
> +
> +			if (is_over_subscription & OVER_SUBSCRIPTION_GWS_QUEUE_COUNT) {
> +				dev_warn(
> +				dev,
> +				"compute queue for cooperative workgroup is more than allowed."
> +				" Runlist is getting"
> +				" oversubscribed. Expect reduced ROCm performance.\n");
> +			}

I like the concept of showing the cause of oversubscription. Maybe we 
should add "process isolation mode" as a special case of "process count".

The messages are overly verbose. There is a common part of the message 
that could be printed if is_over_subscription is non-zero. Then just 
print some extra info about the cause, e.g.:

	if (is_over_subscription) {
		dev_warn("Runlist is getting oversubscribed due to%s%s%s. Expect reduced ROCm performance.\n",
			is_over_subscription & OVER_SUBSCRIPTION_PROCESS_COUNT ? " number-of-processes" : "",
			is_over_subscription & OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT ? " number-of-queues" : "",
			is_over_subscription & OVER_SUBSCRIPTION_GWS_QUEUE_COUNT ? " cooperative-launch" : "");
	}

Regards,
   Felix


> +		}
>   		retval = pm->pmf->runlist(pm, &rl_buffer[rl_wptr],
>   					*rl_gpu_addr,
>   					alloc_size_bytes / sizeof(uint32_t),
>   					true);
>   	}
> -	pm->is_over_subscription = is_over_subscription;
> +	pm->is_over_subscription = is_over_subscription ? true : false;
>   
>   	for (i = 0; i < alloc_size_bytes / sizeof(uint32_t); i++)
>   		pr_debug("0x%2X ", rl_buffer[i]);
