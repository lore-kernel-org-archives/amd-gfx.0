Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021E4D49205
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 09:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A843810E1B6;
	Mon, 18 Nov 2024 09:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K/jy87q4";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1A9610E1B6
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 09:58:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRBXc+WLLIWQc9xB/R/T7ih6lIZh/8ZBh3npsqeJ064M/HsOrT9erGV0981tWqdSZ4y/wUFKGZ//BQV0+vjPrJEWs9k3Vhk61OQ1Em/JIO6J1q1FoqKtX0sM72lMruN/sJ21eoE3lsh4puFARpuRx7hH7vs9MNqWhiLZ0WAS0nTlGPTAl1LJQLxk8k6wcwAlQiAmGU3CwhwMVHpR2L7M5CLrkx0fLm6mQz6tQ0ltjwWZdMjrue9QSAF6alsyTCRE/gHb3ihIMUcvQSpNo06zWP0wS/XNBe0U5+Pi6R0mgbtQIgloZPMeGkhKsKmwo7On0EKYGAxS3niUsNYXnoaQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdOQU45bGg17pW8ggslrNZ062DGmj9MMGg/uuq8B8rs=;
 b=IXXzBQflnBUwEq3He8aOWKw1gwzcoyZb0QztdVGsGKbkMXFajplH/mvQWbpQiVDWgBsN1gGZECGdNz129L4sEYffjz9haxertfaae1dAEy+EocUMUDyNb9M5tOyaiXi4YEGUEP9J/pX/2RyUO9aFZ4SNHK4dn9D8R7NqcWwGQ6nnNBHRXHZPtpqvDFkuATGRtyLDIFHZHJIl7nFjtyIJ4Owdu/e+TDcf0BYwj6TQeu9TT9rBHmxUhnIEemv+m9fJViAmvbYBaiyTWcrEaRP+FTIKL4bDTbtq90rL3nrGb0Bvtb1+k/KCJGrKOIfurpdoguhkrp6wu9A+r7FFo15krA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdOQU45bGg17pW8ggslrNZ062DGmj9MMGg/uuq8B8rs=;
 b=K/jy87q41JLQHz/nr9Px+dOennlHMcsMvBhYYJRpQ17taS0LCew3cNbb7NBHOXp2NwtvDqVNoHE/sjmLFyxAV/+8MFdkHyRD8c2WpDUb9TRGzwM4ubupuc6kl+WHL4K8iIgTvvGrQxfqaTV5fGrNFhA46idLtr1lRUebVjz2J7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.20; Mon, 18 Nov 2024 09:58:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 09:58:17 +0000
Message-ID: <582143c8-b424-4b1f-8aae-8ebbba8a832b@amd.com>
Date: Mon, 18 Nov 2024 10:58:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix sysfs warning when hotplugging
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, vitaly.prosyak@amd.com, Tim.Huang@amd.com,
 Andy Dong <andy.dong@amd.com>
References: <20241118043128.3834919-1-jesse.zhang@amd.com>
 <20241118043128.3834919-3-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241118043128.3834919-3-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: be3eeeef-3371-4be2-a991-08dd07b78658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rnd5M3I1d1QwdTE3K0Uza0ZoeXQ5eEU0blAraXU2Y0t1U2NKMkRuV2gwSHJZ?=
 =?utf-8?B?WkZySzBuWmo5NS8zL0QyQ3Rpb0ZjbUM4K1h6K3ZwVVdoV2QrQWM0eVBLbGgw?=
 =?utf-8?B?YUhhYk5FSHR3WTQwdk1JK2xNcDRQWlNFbmF6YTE2M0d5N3NKWEpuTTBOam1X?=
 =?utf-8?B?cDdkM2xCVWhNaURKWXVrNnVHQVFDb0dYaDhLNGRzUUVXUFRqcWxVSW02WGs2?=
 =?utf-8?B?KzQrOFhJSXIxSmZMYWlCc2FQb25UNU14ZnBzaGU2SmhGZkFRZ2U2YkF2MEhq?=
 =?utf-8?B?UVRoWDlkQ0lDNUdYdG53QkRuYjVaVTJpRGNxaXVtNEFmK1ROZ0doRk1ESmVM?=
 =?utf-8?B?UW5haWh5VTAva0tWQ2pNM3c5NEtTNUFib1cya3RWV0tQTmt5ckw0RkJ2OU81?=
 =?utf-8?B?Sk1HVFZvRUpaa0RsMHU5ZnZwRit0cUlhVk1SZDU5aVZSdEIwZktETXgxMi8v?=
 =?utf-8?B?UXhDRExkb04yQU5PMzQ1a2g0SndBTkw3anc4bFhBZC9USmRwdUVIWlZ3ZUNq?=
 =?utf-8?B?VWg4TERtdXREVktwZVBGTVVBVVNrZ3ZRR3FKelJNdHRVRkJSL2RSd1pWMVk0?=
 =?utf-8?B?VHpDaHBzZFdYUzNxOGVUWGhWMFdPN1h6eW1OSmVDMk9ncWRRYkU3dzFnYzZa?=
 =?utf-8?B?Q1Flck1WUk5TcDhna1JmbHVoMnQ0d01JRnlTaVVjdHZyTDlxbHpRMGlDbjBF?=
 =?utf-8?B?N3BkNGVRQllQTmwxWHZybkRUMWV4UDU3Y3BLNEFPRWxZbUVZWkhIVG11Vlhx?=
 =?utf-8?B?czF0NlRJeHp2ZUhDMWtBalNPVTJvYXVGWEFoczJac21pd3QyN2tzbjF3dytO?=
 =?utf-8?B?Z3duSVZKNHFVclhVMHROTkJUR1B0YzM4aUNpU21Bd2hMam5YUGd5R1cxaURl?=
 =?utf-8?B?a2YzY0w4Q2FHM3dqdWhTRkk4cXVNbHFSY3hMMDdCdHU4Z2VJTXFVaFZ2cGh0?=
 =?utf-8?B?dEc0eEhCb2FFYm9IUEQzcmFZMUZnVXM2N0NSSFhWRDRvZ2EraGtnZXFYc3F2?=
 =?utf-8?B?U2hDNExvd2wxY053UjBaTWhhOVdTZGxWMG1IMjFwZTdDcUx5OEtOMmpwb0Ju?=
 =?utf-8?B?aUkrSFF5RVdMZXN6U3lLbVVQY1d0YWdJYitGMm9JSHVQbUQrdTJ4Q2loMXBy?=
 =?utf-8?B?SlpweWFoMjM2MUwxZVJyeC8vRUpkU01VSjlwbTNHbzBaMnJIZ0tvWWFIYW96?=
 =?utf-8?B?SW1vSklGa3FSWGNqd2tZNWdTQzZrMk9pQm9jQlVUcko3aUx2aVN5aTRYWGxz?=
 =?utf-8?B?WlRZMmVKU1NTTFJFb29WOEdCNG9WdVorT2RJeEtadVQ2cTFCUEpxU2tzYlEy?=
 =?utf-8?B?MkFUVG0wZjdRbHI5Q0krSVVHWSs2MU10WFgxM1EyS3N5MnRYMEhNRGQ3NmZP?=
 =?utf-8?B?M2g2WDYraTNENVhIUzBQWGRTZGxBTkVRcks3Z2lOUHdHTUlhaUtyRzIxd2pZ?=
 =?utf-8?B?a2l6N2liZUN4WnBjL3oyNDI2L2VTMm83ZEtCYjVaaS9HN2FSTnFhMnMrZG9K?=
 =?utf-8?B?S2NZL3F4MDFnOFB0b1VCYlFpQktzQUF4OFZrYlVlWUlWWm1jNUxMODlzdFZ5?=
 =?utf-8?B?MTJyaWtqbFp3T3VGd2NrRWxEVGwyTGw2UEdvYzkwZVpvK1NDRVQ0aENZVEt4?=
 =?utf-8?B?L3ZrYW5waUJaSzQrM0dOMEtYS1pIMjBxQjBub1ZjK0J4MCtzUUpvNEttb1N6?=
 =?utf-8?B?cUtkTjV5UVYrMHhmVFhRNTVMcG5OemNYWFcwMXpma2tndFNmZDRNMWtaWkEw?=
 =?utf-8?Q?Uy6Xv5WdBXf5jvfHqCtteyftTSm9BpzGyX9u4Kx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGtmdHNuRVNWcnQ3VnBSbHB2U0phQlFrZC9lRE1FWExKZXh5QTJ6SUU4U1RI?=
 =?utf-8?B?c0Z2cVpFSHFjZmxHODZoVVltUExMUXA3d0RZK3RWVTJmSFEyVmhTMnJjN3NY?=
 =?utf-8?B?dytPNjR6NW9vZGhoaklMMC80WURtL3lVQlZzdUpvSGkvdTM2a3dtSUpiRHpK?=
 =?utf-8?B?RWtSK25XZWRwdTRwcmMrNys5WXUvNmI0WkEzOW1BTUplQ05ZMmJmSXQ1MUZQ?=
 =?utf-8?B?THVNMGwwUnoveTQzUE90SDdGRXhDcjVEUXJhT0EzT0dhOXJHZ1NaK1h0ZFl6?=
 =?utf-8?B?bWx2RXowYjFtQWFKL1YzYTV2aTJmUTl4S2Z2ZzVhMEtuQk5zQm5lclBZRVph?=
 =?utf-8?B?L0RRN2U3MlI0WXF2UFF6b3RPUURJaDFnbTZURDE1VWF1U245eUN3bGNMZDVo?=
 =?utf-8?B?R1pTd2RDTk5VRUJZM1JRQjhDZHRMenhwTWJxMjIxdFVpbnRmclpwNHJieUdt?=
 =?utf-8?B?bnZibmoyZGFZQSs0citQYnlOdzVDcVJCYmE3dm0xREE3Q0o0MzAvRGxSdDJK?=
 =?utf-8?B?ZW96VTRPSkowQnRESG1YdHFyRDh4VmpOSUVLb0dJN2ZWR1hJU01RVU0xU3h6?=
 =?utf-8?B?TUc5UC9EVCsrT3NaWmdXQy9QRUpuUU5wTFZNclM1ZUNpK2prNC9ZcjVHa3hB?=
 =?utf-8?B?aStjeWIvczZBU1dEejBaRjh4dzAxNFFpU2ZXdE9JaWNhbzNFc1ZPWjZRY0ZP?=
 =?utf-8?B?SHpkNFpDV0FGSERYakREZHZ6bVdOK1RVZnQ4SzRKTGE5NXpXU2RvS3FBWlEv?=
 =?utf-8?B?S0JYQkRlU0Z6ZVNRY0JoUU1WVWZPc0RlZ21UTnJxeFFuYy9sdXVqQUk1UjJn?=
 =?utf-8?B?RENhZVZhRXVjNDYxcXQzYzE4YXMzaitVQTZXcThiMEtmZmJkZ1dLNDBiTXM1?=
 =?utf-8?B?S0tPRXNLQmdTaXpzcHdBdElWY0w3ZHpHWUxDckdWeXdtS0ZqWk1kTzBBU3Bp?=
 =?utf-8?B?UXdyRk5NcG1nMi9LVWxScUlQS3AzMy9tWEZ1cXcwT3dqcEZMZEE2eWl1MTUx?=
 =?utf-8?B?S2I2SkI1WWtMeW5RWFBid1dJMTVaVy9wL2J6RjNvVUpsdVpCZWlFWmVjUzMv?=
 =?utf-8?B?U1hkMlU3WFZJVVdVWnUzY0ZEVDNZd3JiVk4vRVIzWTlFUVZ2dGF4TWhyVFQ1?=
 =?utf-8?B?TUtGcUcwakE2K291Y0FndlpCaXlTbkZJMFJsa3dkR2cveGszbVhDbXNOdlJB?=
 =?utf-8?B?VDMveGpYaDhUU1FFU205SW1hU09sMFd3YnFIZDBpcWRRUWI2YlVvVTRqbTRQ?=
 =?utf-8?B?amZueDRNVGZ1Y2V3L0VpTUFFNHFsYnpRRkFTa3M5UFZGOWlGNWo5UE9XY1Zu?=
 =?utf-8?B?ZWhCM0FROTR3SEhJdGJWRXdSbWVZVzREbEpBQ3FoOHk2VCtJV1psVmhGeUtJ?=
 =?utf-8?B?bWNxL01NZ2wrZG9uVWJxSWlnNU1TNTRlbER4YTZiZitpSDNyMDBQU25jUUNx?=
 =?utf-8?B?MXNRQjhUVmJmSVRFZ3RnNEJkQ3NFTnlBcFFPT1YyaWdEYUt4VG1KQ2Z3UUF0?=
 =?utf-8?B?MUtxWXllNnZqajg0VUZWNzdpLzFXWW1WSHNBa2hoM0ZLSjZTTTVPaHprUFNn?=
 =?utf-8?B?MEs4Y0xXTVkxVTVKL0F3U0FxQitnalp0QlFxaGZ4eTRIOTVCVDdWeTFVTmZP?=
 =?utf-8?B?eXRYQ1ZTU0xnYUdPd1JaY2NDeSthNGJDWDhZYzJvckQrY3dkVkhjV2ZSTmR4?=
 =?utf-8?B?K3BlcFFBeWVkZGVIdGZ4NFhkNXpKb1c1em55ekp2Y0FtRkloM0dOMmlVcDZ4?=
 =?utf-8?B?am9NendrandHUU52d3owNjVJY3R1UnJ2OVBGdHQ2OFQ3em10VUJ4ZFc1eStO?=
 =?utf-8?B?eU83cnd6SU5USTZtbjJBR29oYVUydysvV28vS2U1L29YUHZwY1VIS015YkNZ?=
 =?utf-8?B?c1dMcmNTbTZWbzZObEEyU24xdnJKbGR4cmNCa2Q1WllsaXVUTkxsRFpyMlhS?=
 =?utf-8?B?RjB2MVVZVFN2SUhUV2QydmZYZzIzeVEyM0lTN3IvMWViU2ZFeXd4QmEzWTIz?=
 =?utf-8?B?VlBFaVRJYlBnSlg5ZmVRMnF4UUJEL3cwK2V0TXYrb3E0aitkU1lQb2pzU3BT?=
 =?utf-8?B?ZTJ5RG5lenpIN0lOejNCZnhnRmVCOVhsUFJpZDVpNG9wSCtVemlRMFAxV084?=
 =?utf-8?Q?nbFU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3eeeef-3371-4be2-a991-08dd07b78658
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 09:58:17.3292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fCF3AznlWhkzXwDbXlw+wI5sPO03j3y3DDdEEzCquRj5wkXXM5IqEzQQXOHutz3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435
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

Am 18.11.24 um 05:31 schrieb Jesse.zhang@amd.com:
> Replace the check drm_dev_enter with sysfs directory entry.
> Because the dev->unplugged flag will also be set to true,
> Only uninstall the driver by amdgpu_exit, not actually unplug the device.

Clearly a NAK to this one. This looks strongly like you are just working 
around the issue that the functions are called twice.

What exactly is going on here?

Regards,
Christian.

>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Reported-by: Andy Dong <andy.dong@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 8 +++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c        | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c        | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c         | 6 ++++--
>   drivers/gpu/drm/amd/amdgpu/df_v3_6.c            | 4 ++--
>   7 files changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 3c89c74d67e0..e54f42e3797e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1778,9 +1778,11 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>   
>   void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>   {
> -	amdgpu_gfx_sysfs_xcp_fini(adev);
> -	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> -	amdgpu_gfx_sysfs_reset_mask_fini(adev);
> +	if (adev->dev->kobj.sd) {
> +		amdgpu_gfx_sysfs_xcp_fini(adev);
> +		amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +		amdgpu_gfx_sysfs_reset_mask_fini(adev);
> +	}
>   }
>   
>   int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 43ea76ebbad8..9a1a317d4fd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -447,6 +447,8 @@ int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev)
>   
>   void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>   {
> -	if (adev->jpeg.num_jpeg_inst)
> -		device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
> +	if (adev->dev->kobj.sd) {
> +		if (adev->jpeg.num_jpeg_inst)
> +			device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
> +	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> index e8adfd0a570a..34b5e22b44e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> @@ -137,7 +137,8 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
>   	if (ret)
>   		return;
>   
> -	device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
> +	if (adev->dev->kobj.sd)
> +		device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
>   
>   	ttm_resource_manager_cleanup(man);
>   	ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT, NULL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 8c89b69edc20..113f0d242618 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -451,6 +451,8 @@ void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>   	if (!amdgpu_gpu_recovery)
>   		return;
>   
> -	if (adev->sdma.num_instances)
> -		device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
> +	if (adev->dev->kobj.sd) {
> +		if (adev->sdma.num_instances)
> +			device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
> +	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 60e19052a1e2..ed9c795e7b35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1310,6 +1310,8 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
>   
>   void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>   {
> -	if (adev->vcn.num_vcn_inst)
> -		device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
> +	if (adev->dev->kobj.sd) {
> +		if (adev->vcn.num_vcn_inst)
> +			device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
> +	}
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index 02bda187f982..dc96e81235df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -904,8 +904,10 @@ int amdgpu_vpe_sysfs_reset_mask_init(struct amdgpu_device *adev)
>   
>   void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>   {
> -	if (adev->vpe.num_instances)
> -		device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
> +	if (adev->dev->kobj.sd) {
> +		if (adev->vpe.num_instances)
> +			device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
> +	}
>   }
>   
>   static const struct amdgpu_ring_funcs vpe_ring_funcs = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 483a441b46aa..621aeca53880 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -254,8 +254,8 @@ static void df_v3_6_sw_init(struct amdgpu_device *adev)
>   
>   static void df_v3_6_sw_fini(struct amdgpu_device *adev)
>   {
> -
> -	device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
> +	if (adev->dev->kobj.sd)
> +		device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
>   
>   }
>   

