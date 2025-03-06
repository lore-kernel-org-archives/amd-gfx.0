Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252DFC19F32
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 01:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B916110E0E2;
	Thu,  6 Mar 2025 01:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aEC7Tf/+";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1663110E0E2
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 01:24:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFoK4vOYMI+d6Q27mbZ1pdZP2B8W5411hyrov4y/OVEIFRxtfp1tKoL02DGmuXwS2i4k5zU7oX+6jJcZCPm8/XdgxmyLH0dvMSuWRv6etldjq+93jZpqJQxbNssScq2Lq+glvqsonqw63X7wH0dbbaAqMRGvyGH1yPpgQxDI0epZk6B8WUWajVyi6vbNyjwgCVLCDHwoA1gUFdfPnfzbWrcgCT9Zs/h6t7FDY5gI7ECh0oAchTthfdxLYpUBPk4GcpNTuZMpAUQkpeVsTq3SpAz2URjBl22Ghh6I49pTBN7dNCZcPzVyi9mRlX/dplQOigB5l04AddpNEG0Y00glRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psHml3nAlwW+N29W6uPGOzav5PLgGDR10Gu43Z/OVBw=;
 b=DC0RnmnRNSQA6v2smecECVGHVPmSgektsOnvd0C4e3U2L3FQI2jtAbaZZDhwmY9L0hqLk1qALG3VANNo/jAZyJXw8HMOaMSWpevtldPf/KpRCn/mdR5aeQjiXItcMNvcapcAuM58zfUhJqry7IpgIUfyb/zIkhw/gGxeRtA1VDZcteLXY1H80VGUInJju//+km8RrljKpyiuBNGhgtXuW90Ipnq+N7+SssbBKtK34Z+MrRyx64Vqmz8EUssCkcBnzTFfWXI1wwqzZOwjJc/AtRyUjaVQP0soqz6fpvDrj51JWMJjhd/i4MnKTnqeGsyVksYL8kFjT+HEeMJNh52ccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psHml3nAlwW+N29W6uPGOzav5PLgGDR10Gu43Z/OVBw=;
 b=aEC7Tf/+QXb7NEOyxpoT6YnWg/qrJdXpkpylNfw9N2WBJ3FK51L77fbN5qrF50uSCLcwqJYG6qpWjscqVCtSQhH38cM1P6aiHNgydUhDw00x4qld4XPLwODVlZV8N3KsWyqZjAftfosMNprMGl9kuX1npmLB9e3XYAQ65Qj3G5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 01:24:48 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 01:24:46 +0000
Message-ID: <6e6192a0-5772-4aae-b22f-5a34b07809b9@amd.com>
Date: Wed, 5 Mar 2025 20:24:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix the race condition for draining retry
 fault
To: amd-gfx@lists.freedesktop.org, Emily Deng <Emily.Deng@amd.com>
References: <20250306011023.3220173-1-Emily.Deng@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250306011023.3220173-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0198.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::35) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f40cee9-35e8-4634-ab0f-08dd5c4dae4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDl3TmFrK1Rla0djcnhwdndIbm1TdWVUS0lHeHB4bXlmY1ZySzZOajRubDFW?=
 =?utf-8?B?UzF6K3N3QmtiT0U4emNFWHY0emNBak9mVVIxdDJCL29sVkUrWkZIb2R4VDFa?=
 =?utf-8?B?SlZjTUtSdUpSRFo1bVpRZG9KTkY5eTFDcjl1YmZwK0NkWTlSR0VHR21xT0l5?=
 =?utf-8?B?dWV0ajlkbzdtWStuUkIxSlJyVCtDN2VRbDhCVHJIRWFXaUVnQlMzZ0xIWkl2?=
 =?utf-8?B?Q2NXQUNVK0tpck5QcXBiVWZjbDFkVFE1Rkh2Y0NoMms4KzYwYW95UTl0R25o?=
 =?utf-8?B?Q2FNdkpZTjFjemhFaFlYTVAyaUtIb2t3aHlZUi9HSXpLU2tyTjVWaXQ2cC9x?=
 =?utf-8?B?TVZnQldnVHB3bVBiUmMwZ3lZaytiNi9DN284bnBqQ2tRcWtyNitwYmovS0sx?=
 =?utf-8?B?SC9UQmJlOFdDbmlZVURHaUwzU1JmZmw0Tkc3VGo5dUt4bSswRWYvcTMwOFg3?=
 =?utf-8?B?aHFPNEpFSEUyNXMrNlh0QWR2QWJHQjdLSEZ6c2pSN1JaeUdTQlRWYmZwWE03?=
 =?utf-8?B?TGFOWE5nM0FhTlNmbjFRejJ3QWNnL3p0blFnLzhQUkZabm51ZTgrVlZSdjhh?=
 =?utf-8?B?RjhRbU9jbFF5cEl3dnBqWDhpRXMwdnl0d09SMzBGQTcvM1k0YkFVQXBOalcy?=
 =?utf-8?B?U3BZMkhQT2Y5dFVLTGJmUWR2V2NFbjJkTlpjb2hWTGJ5czJOWVpFWkxtS1Z5?=
 =?utf-8?B?UlpxVUwzNmd4QUdzRjF3NXJkcE1ycXlTT0VuT3VVYWMzZlRpbWNQL0EvSEFE?=
 =?utf-8?B?N1BLWHRudlB3LzhKK3VRaXB1alJIZjZwY2Z6eThxcW42OWIzeFZhSXBiKzZB?=
 =?utf-8?B?cHB2SDdnUW5yek1hTzZqRHhpWjNhMUNYSWtMYjJQSXlCb2dxZmFVUjdraURr?=
 =?utf-8?B?WkcxMkoyeG1TMGNVWmQzSG53c1ZabWZKbXJ5aDUwZjFzeGZLZnV6UDVSeGh1?=
 =?utf-8?B?cnhnSkdsWVNaZXZpam14N2d6dzd1SjFHT2hDYzZaQ1RqaFVqa012R28rZlVR?=
 =?utf-8?B?WDBJMFc0S0FuMjJnYUFCQzJQbUpyQkdGOEYyM3lmNFlxMHBsYnBwcEVseHFo?=
 =?utf-8?B?aUJSdXhBMUJjYVVBdlowbmlMekpOTzZTQ2JWMEljeDQ0UVpETXlCNkhHQzhv?=
 =?utf-8?B?Nk0vRHdrRElrKy9tVTc1MTg3S3FHeHNlb0prUG9sQi95MldPakxyQk5zWEFy?=
 =?utf-8?B?RjB3NHF6Q0EzSlFhL1gzbVhVMElXb3hGV0VhRlRmNUVSVEF1b0VGakl1bU9s?=
 =?utf-8?B?aXJOSDhKZzZaZGJ4akw0NEtscnVMeGFJS1pzNjM1NzBqL21EdjFGUEVPMlZY?=
 =?utf-8?B?cm0xRDFMdnBTYTZNMEtkYldReTR3VTM3VEJOVjBMQVVHWlliTURMMHVGMWR5?=
 =?utf-8?B?VnRxemNWWjBvUE1HTDk2MWZJY2p5cHJLeHhwQ1c4REQydUZldy94a3Vzc0xZ?=
 =?utf-8?B?bU9HRDIvT1RCSjlPNlFQWlVOMG93d3JPUEZyL3ZUbG55eWY0OUxMQmRoa081?=
 =?utf-8?B?cytxRTB4TmlyS1AzY0pQVWFTNVFmMG1YK2R5cFcrb0Q0bmZvaGFTdmlxZWps?=
 =?utf-8?B?R0FuMjVDOXVRU2U4ZHpZYUs2WVpYMEI4OHFxRWI0V2lEei93a2wzbFJYd2RB?=
 =?utf-8?B?eEt5aEJJV2Nza0ZjcmtTenZYMW9MemJyL1ZIUUx6Rk80L05FT05JNXdmM3RG?=
 =?utf-8?B?NnN2VzZKM0RjRlBJanJrZGdZanBaYTZPMnorak14bWFFYTd0UDJ1bzVPQ2NB?=
 =?utf-8?B?QjljY3JIL0grdG1mSjBLRWI1RmZhRGg0b3RBNVdVMnFIWXpkd1czWUxMcnFq?=
 =?utf-8?B?dUtKVCtVa3p2ZGhsUnZtaVU5VFd4MGVKL1VYcmp0QUEzTmNTbUgxejM3ek9O?=
 =?utf-8?Q?V+noNVWslQIs6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzNXWVdhaUVPZ2FaU3pxeGR6cEVPeDB1bFBvK3JJa2k2ejNYRXlxcGdjUE1Q?=
 =?utf-8?B?b0g0MmJxY0E1a0tFK1JKdmw4WGd4bTBvZ0s3Qll3N1BtYW05SW1qclBXeStm?=
 =?utf-8?B?YlZoVVZBNkxYRDJOSi93Zy81QTlWKzZ0cCtGYkFvUFVpdHY5MzlVZnQvdHM0?=
 =?utf-8?B?bi90UUx5RG44VGxTMkpxZzBDakZubllVOXE2ZFpaMXFUbzFOSHROaDg2WDlL?=
 =?utf-8?B?Zk1ReElaN1ZhY0ZqU1VuaThnZlZEL2NGam5EOG1mT2x6Z2VXQ1pkZVhyL1NU?=
 =?utf-8?B?a3BuVDJNTnZ1bTZ2SWlyODdnc1lleUl1UzBMYXAvaTlsLzlHcnJvSHJGbGk2?=
 =?utf-8?B?eDY0UGZsVm00SDNnYnNZQS9GWnpPL1JJTDJKUkMxc1BrekFvNW9vMUZITTA0?=
 =?utf-8?B?TzJQd29qWUJmdkpYWUJSaFo5MFdvWlhSY2JPRFd6UU1wUzA0RVg5V05WVkRW?=
 =?utf-8?B?aGtHaDdvNkVlVFNpS1B5dURndHFxcFFQb0I3RkllMVcvVXRhMURCeGt5MzNv?=
 =?utf-8?B?SFhzVUxjNjJoQmxmaVFNR1QvTWtKVnpkMHRuUTJTY21HMllVRHNWbDJmYTFX?=
 =?utf-8?B?dlNXY3dVY2M0OUZPaC94WDZDMC9WaVdZT3AwVHN4MzVCN1hiajhXc3lCUmEv?=
 =?utf-8?B?cEM4SlNPb1RMRllmcUQ5djZic2ovekRzdTJKYTRXRVhyVkE3WEdHZTN3emFx?=
 =?utf-8?B?LzBiaUo4eU9MMG1SMFV5ZHY1U0x0OFQvaHFGU2xmamZLRWpob01WRE1EVFJM?=
 =?utf-8?B?UVBVeHRyaUo1THhoZDBucVpRbHdNcFJ5VEZwbXZWc1cwSjA3VUkzNC9GS0E4?=
 =?utf-8?B?SENwTThIZEVaOU9FSE5UTWwwOTYydUNQNkNWU0JaZW0xUW9yUDZXeFJ3Z2Jq?=
 =?utf-8?B?dE52MnhpakhYSVU3eENyQzJDVWRwQXp0MGt5OWVmaTV2WkRVb1ZHZk9heW1E?=
 =?utf-8?B?TjBHOUJtN00zSmI1N251d3FScjVTT1A4SStsZFlxdk9JOXRNN2dNUmg5c1lP?=
 =?utf-8?B?QVdTTUdlaDhPQ2JXSWVXR1ZST3ZlMnpXZ2M0TWRIUUp5TFVuZGJEUWk4Y1F0?=
 =?utf-8?B?SzNyRXYvckl4MlJ3U3FyTHJlMlVZTTc1am13ZUppRXF5Qnl4NzFmMW5lMVhC?=
 =?utf-8?B?Ym12VldoNkkrQlRicEpFb2tETU05V2lKankxSkUxSjJFRTA2cSswSTIweTFR?=
 =?utf-8?B?MVBDUy9taU5wR3pVT0ZOWi9zTTF6Q0tVNHZqOHpoWmpGZ0JUd3EwMmI4YVRJ?=
 =?utf-8?B?ekIxS3g3TmFPUXBOaXphcjBDT2l0Vm5kUE12KzNFcGtzTm5hUFExNUgrTi9j?=
 =?utf-8?B?S2RWNmhHL0ZaWnVPeDZadTRyNWRJS2d3dTdIaDRLUTVuUDBKa0lnZ2JrQkVz?=
 =?utf-8?B?UWFoU1RvZ3J2Q2s1T3pka2VVZnFGV01ad1NlOXdITG9ic04rYnN5WnBjS2ZZ?=
 =?utf-8?B?TGhnS1E5b0RqTERpenlpbDVUcVlWZzFmRXRteDlpWHMxTVYzTGlHUlJzR0lW?=
 =?utf-8?B?Wm15ODhXOTJvb1BTV1RoRTN5Y0UxRUhhSGdRMkZndDdRQnJjMnhwdFAzUzND?=
 =?utf-8?B?clFLQ3NXcHhEK2dnT3Z5NWpsWXN4NG9QMWsxdzJqbkRaanhXOFpwaGk5azYz?=
 =?utf-8?B?NitGa2ZZa1hJSW10RkZYWXhnanNOUi9UTWxCZ1V6YWhkWXlpZjI3bEQ3Zld1?=
 =?utf-8?B?emt2bk1WWGRsR25aYzdDbTZQd2ZZSndKbWYzQnNUNTUzSjFJQlNESGRBdmJ2?=
 =?utf-8?B?WWNQTnNsQmNRUDFUSHBVNWE2UEhUdmNyeWpEbXVNelBMRVlPSmJXemcyUzVU?=
 =?utf-8?B?K0FUYWp0Q1NQdHlWaURLN2MzR1NlemFmZG1nclZtRFA3U3JkSHZsSW1iSnRP?=
 =?utf-8?B?aFF1RHJxNVJ1SVd1K0t5OHJ0NVQ3MGNnMmRZQ3dBSDdsMkZldk95TDdpUjdu?=
 =?utf-8?B?d0UwTWxXbmV0WnZrajRmeDEyM1dwUDBFNjJlaFdWSWkwRTNGNlFOSWYvUkMy?=
 =?utf-8?B?bFZnYWRvYmNER3dpOThqR1dFL2Z2dW1xV25EZ1I0K1pDcklSM0VCOWZUVkFC?=
 =?utf-8?B?TlR5S2ozR3IrTWE0ampjbCtCTXg5ZFFMcEJ3UW5ha3lua1ZEUGpaOHdkeDQ3?=
 =?utf-8?Q?WB1ttxdKsZzsloiL1MDxtNldf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f40cee9-35e8-4634-ab0f-08dd5c4dae4e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 01:24:46.5268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JIAa7iQT7aUljRTHgRQtRQ9gdD9uggdCbUHkMaCI7LK7xPTj1U1/BxrjFolW7WHWYWBO2dt1gt7hSJgaCCjOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
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


On 2025-03-05 20:10, Emily Deng wrote:
> Issue:
> In the scenario where svm_range_restore_pages is called, but svm->checkpoint_ts
>   has not been set and the retry fault has not been drained, svm_range_unmap_from_cpu
> is triggered and calls svm_range_free. Meanwhile, svm_range_restore_pages
> continues execution and reaches svm_range_from_addr. This results in
> a "failed to find prange..." error, causing the page recovery to fail.
>
> How to fix:
> Move the timestamp check code under the protection of svm->lock.
>
> v2:
> Make sure all right locks are released before go out.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 30 ++++++++++++++++------------
>   1 file changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index d04725583f19..db898757f92e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3008,19 +3008,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		goto out;
>   	}
>   
> -	/* check if this page fault time stamp is before svms->checkpoint_ts */
> -	if (svms->checkpoint_ts[gpuidx] != 0) {
> -		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
> -			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
> -			r = 0;
> -			goto out;
> -		} else
> -			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
> -			 * to zero to avoid following ts wrap around give wrong comparing
> -			 */
> -			svms->checkpoint_ts[gpuidx] = 0;
> -	}
> -
>   	if (!p->xnack_enabled) {
>   		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
>   		r = -EFAULT;
> @@ -3040,6 +3027,23 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	mmap_read_lock(mm);
>   retry_write_locked:
>   	mutex_lock(&svms->lock);
> +
> +	/* check if this page fault time stamp is before svms->checkpoint_ts */
> +	if (svms->checkpoint_ts[gpuidx] != 0) {
> +		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
> +			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
> +			r = 0;
> +			mutex_unlock(&svms->lock);
> +			mmap_read_unlock(mm);
> +			mmput(mm);
> +			goto out;

I'd prefer goto out_unlock_svm. That way if the locking logic changes, 
we only need to update one place that releases all the right locks in 
the right order.

If you're worried about counting the fault with svm_range_count_fault, I 
recommend setting r = -EAGAIN and only counting faults when r != 
-EAGAIN. That way you only count successful and failed faults but not 
retried ones.

Regards,
   Felix


> +		} else
> +			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
> +			 * to zero to avoid following ts wrap around give wrong comparing
> +			 */
> +			svms->checkpoint_ts[gpuidx] = 0;
> +	}
> +
>   	prange = svm_range_from_addr(svms, addr, NULL);
>   	if (!prange) {
>   		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
