Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4A5C27C75
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jun 2024 10:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57AEB10E813;
	Wed, 12 Jun 2024 10:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eqxZzmb1";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C220A10E813
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jun 2024 10:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=We4U4QxB7uwc/EWzTm/MeMmCTHBwQw6sBCm4mjTstNhh9kY7LECCC3M/B+ouZH11MF7Zx9j6omi8WpZYoobpE9EcrEq65h+9LFZbjpbzQaqHHxxh1ZwpdQkgelO/DsURwFJDQahDoJaLoPqH6lgYLmVT2Gp2wSgG+59iabztP5AwI3+oMVkvCJtS4/1lMR5sKJj9Ub6JVyZvunY0UKQVz2q5SrvK+uKB6pPU4Rfugh4B+u4/WCpwgZu2qh76Yy4V9WAbTfJvWUHKA3eWtKtF4hi9i48J5Pj1uKvynEji4m1qhNF3+rcRbq7vdAruq3/oRfh+duYY5c6zBNhkgJ8Whw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViUoggSXxFo10VykKd1C79C61LW6uY1UyhEOSJ/ujBo=;
 b=JedD1SPUSWEnO+hFLeRmD4Q8Tv3FZy/I/gz+cdSdB2OPL7l/aRqCdTg5G+a4GXnounEuW4oFPpNhasCfBH4ekIdGHI8N2DHXDglsxdneu/xrzO8addn+/wNcw8MNNYvJbV0g2E72lFlfkHOxCKWwVXVP19YgeUIIBO2wYK7kRRJIHDc4vwab1SHRoT2y6Z06e8txgATFtUxvMXxR9HyDsfmaXdt1Ql+3jzokiWonmokRqQg+95CZBPJZxUAxdJ+UoNm+sn1W4l8A3CmPMmVpJ+nIhHkZVDO0PzXAauyd38KlahYPGzcEffd/H31CB3NXw8xraY2hZMrbzb5R7tp18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViUoggSXxFo10VykKd1C79C61LW6uY1UyhEOSJ/ujBo=;
 b=eqxZzmb1NQSTcq5oYfN5BkEk8nzHR9NjGyASMrgh5+mnp2KHS4cCNf/6tNirMPjD7EUyLR2CR3HjWGWq0NstIwqN4U4gjNkpeTXrobBsZg379h6mY8x7pqtzDCj2tn/8QSY32s8ye/ERDXZ0GOCw4Ytpwj8vLvfGPMJA6rtP178=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Wed, 12 Jun
 2024 10:58:46 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%3]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 10:58:46 +0000
Message-ID: <e2fd8fca-ff7b-4c7e-a04d-cd757dabd6f6@amd.com>
Date: Wed, 12 Jun 2024 16:28:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: use local xcc to flush tlb
To: Yiqing Yao <YiQing.Yao@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, alexander.deucher@amd.com
Cc: owen.zhang2@amd.com, haijun.chang@amd.com, horace.chen@amd.com,
 qing.ma@amd.com
References: <20240612093641.3682677-1-YiQing.Yao@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240612093641.3682677-1-YiQing.Yao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::29) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 4310c8a7-83da-4f6e-ad08-08dc8acea1aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|366008|376006|1800799016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmFQZ1lKdCtOMVZQbUdMa05sWnVyVU0yNHczbUJnY1VXdUI4TXBXSm92K2hz?=
 =?utf-8?B?WkxnemExRDBSZHhhOU04dGEyTXRtNnNCZzVid29MeklpazQyLzl2SnY4VFcv?=
 =?utf-8?B?WStHdm5tZVlNL1E3bnZCdG5hUHl0NTZha1QvTFMwNnVoTGtRY2xmVHNIOUNo?=
 =?utf-8?B?V3pHTEp5WkdWakpUWTYzNHI3ZVN6dkt2OU0rOFQ1UDlGcnpaMFJVVG03eld3?=
 =?utf-8?B?dHU1eUNDeW1yRFNiYWJKMFlpSFZNenM0YXRXdUd2a1VRY2w3amdWWTFsZit0?=
 =?utf-8?B?VTQzbmFRSVFPYVdFenpGR1I5Uk5GdEZNRHlmWGsyUmNSNlJ0OHpyZzJIbUcv?=
 =?utf-8?B?VHdKaGFNb0hyam5tOEVzd3hmc01tOFpNRU54cEliSUNjV2lLaTFDeklwZXhH?=
 =?utf-8?B?VlpCeTRrU3RFdHRMelg2RjJmSDJoMTBrWkVKSC9jS3ZKRWNCV0VTSnBoTjJL?=
 =?utf-8?B?ejBieERHaThrYUkxSWYrQmo2dlNxekxuckdtR0NZa1YvZy9yeVQ0SjJpR0lk?=
 =?utf-8?B?dGdDUEI3SE1vUUNGL3NITFI4SmlLTU5ZdGx2Q0c2TVF2UTlKWmNTUDhYU284?=
 =?utf-8?B?ckNwNDVTbjNueUN1WFd2RGpyQ1dPSEJNT21xZ0ZWKzg3T0V6T0ZsU2ZoSS95?=
 =?utf-8?B?RC9rZEJtcW9DdUR1R21CdUZUL1RROFBCTG11eDFzTEdkSmp3V08yRWQ1dEFE?=
 =?utf-8?B?bGo5aU1ycEhsT0d1d0RNOHFrN2xPOTlvODNYR3ZYbHR5WGRJV3JFTDVpays0?=
 =?utf-8?B?SnhrcE1JMDlNNFMvRjd4RmRkdEo3Z0ZGZCtRamNrVFJWd0h4MGt2YjQxNHNh?=
 =?utf-8?B?STVNeHhVVk5TWis5UGxjdEI5SEtMQWRtQ1JXZnNncVdRa1gyTkg4NDZyRGZV?=
 =?utf-8?B?bGxUUjQ5azRYNWNDL0hsSGk0ZThubUR6aVBZdE5OcEh1RmJhV2tlZVh0citu?=
 =?utf-8?B?NStsN0ZtNGpTT0VYVVlFVmQ0dkZvVGJlc2J1YkpzTUtLenNsMk1jeUk1UHVi?=
 =?utf-8?B?a3hWSVpuNk82NmlhT2xLUjhRR045RnJVcDdZaVlpMUNxVUY3SVhpT0pjcjlI?=
 =?utf-8?B?MXR1Y2lMTnBKRUN6RFZxOEpXb0pjaGxqOG1oQ21EOXNzcWtOWEhzVUFvNzg0?=
 =?utf-8?B?amdlZWd4ZEc2cmJ4aU0wdS9YcExtMDhUdzdEb1FWeHRsc1lUYjV5M1VmSUJB?=
 =?utf-8?B?SHhnSnlXRjFoSitqZzk3QURQbXRNN2UrOHF5alVvK0oyQjJYamZjTE1XWFpa?=
 =?utf-8?B?WlU5VDQ4NEMwZFRhYkp6SlMyTkhiNGdmSnF2azJ0TElBUWpnL3dYVHpJOWp0?=
 =?utf-8?B?ZTVQYng1elBDb3RHS3gzaHZxaVNweEgxcFVuekE2SEZDQ0FYN2ZoRHpjYWdW?=
 =?utf-8?B?RmlUN1A2eEFxaXF6Tm0wTWtFMTd6MWU2SE9EOStEbkJqZ0FCeks1dC8yK20r?=
 =?utf-8?B?aFc2aGthZWJFUkdBUUFCL2FkeUNLeWExYXUrYkJER2tnVW1EbU9Edk40a0Zp?=
 =?utf-8?B?NlJ3ZzVWRWFMQVF2K3JaNDRnVHdlNjFNanlCYUxxa2MxR3o2ME1YOTJmN3da?=
 =?utf-8?B?QnNEUjB5MEE4R1ozcDZLTUJ0c3QzRmVoK1ZRWmRkZHNvREpRTVhCeDVmOEhB?=
 =?utf-8?B?Z1pLRGpiS2UvcTFyWnFQbHpLSnlTRGpzUldscjRMMm9uL3p6N0xwQVFid0sw?=
 =?utf-8?B?Z3hVQkVyQVpVMUNmM3E0YUZ3UUJlWDJOSThsN3QyZlYrUzhaK0FZem1JRENp?=
 =?utf-8?Q?Zw3t4+Htt/ihEBowfxOsRM9/pYrH21y/mmi9jaC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230032)(366008)(376006)(1800799016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE5nUmNhVWhURGt1cm9EeDNuUkVXdzJSUmd1cVRmV3cweDgxeWlnNDNOejcw?=
 =?utf-8?B?ZjdyUnhBemtGUTh0Y0M1L1BiUDRFMWhOMk0rN3p6VUQ5QnpPaGtma2t4NGtW?=
 =?utf-8?B?YnFPakhmcjBKSENJQi81d2h3dVdNK2g2MnI2Mk12WjFwbFJxa1BSRERpSDVk?=
 =?utf-8?B?VUhPcVhLT1ZrZkJCR0l6VVdLYlc5b0tDVDI0VnYrcXA4ZEZQdzlqYVgxbW1C?=
 =?utf-8?B?Q2lPMjVkZDJkY0U4My9EMmVTc3dOV3R3TDFFVXlBN2lHMEh2cElXRldoVUh1?=
 =?utf-8?B?ZVNuV0NvQ3NOZ2x5TDhiRUR2SERJSTJGMHJ2THZHU0NZYm9wWVRxRUtUZCtH?=
 =?utf-8?B?dWQ4TURsT3BRMDFnS29mMDhZRHZPcUM1QytGN09aRFdnMElvY2tzNE4zM3o3?=
 =?utf-8?B?Y0VUNmppa2lxMzA1bFBVcjBWdi8rRXNNY2h2Tkd0MWhjTkFGcW1LTzJ5ekla?=
 =?utf-8?B?OGVZUzhFNFN0R0I0MGVmY3JBSTNlLzdVc2dtd3JMZUdwcE4xL2N5cW5leW5o?=
 =?utf-8?B?N25xMDV3MDE4VTRJenIrRnRGV1VoWXV4dm8zUGNNN2FSazJ6dkNIR0hRMHA3?=
 =?utf-8?B?dHFQRWZ0VEZ3MU9Ed3l6dTRWbWUvK1V1SnY3NElxZ0JDWkJnZGRzNkdBbVVR?=
 =?utf-8?B?bllOT201Mk5MWCt6a1ZDN0VCYTFORnU4a29jaWxPN2ZjczlzUG82K1duME9U?=
 =?utf-8?B?N0JSRlBGdkFlVzJ3azZyZ0JXM2VKRlR6SWYyWm5Yc3BGOGIxV3lkUDVIVDRs?=
 =?utf-8?B?dU1MUk1rbXYzeEUyOWZuUUZydnRxcEZudXlMSllkTE5reWdFcGpscDl6L21w?=
 =?utf-8?B?bWVjUFpqRzZXdWRzaElWSExLRkVUQjhtbmlMYU1wNm9WS214WDM2Q0FBVDhO?=
 =?utf-8?B?dnNZMFZMSFpQNDNpQkJaTVVwR3BWSHhBSHp2QnI2NVdBQS95cmRXcFcyOEpL?=
 =?utf-8?B?V05FYmJHMG9BV2ovekhZbytUdDBEOWphR0tnb1BaVDhLWk1vTFMzRmRZSFZT?=
 =?utf-8?B?YkxnREVPYXZzUVZ5N3B1dVpjUG95c1FHdWZJdk5uMHhWVGVHRitZbWJ3UjQ1?=
 =?utf-8?B?bHM3Zk9XSDZ3Qm5xcTNqSGRuaE44cDBxWlZqc3ZHWXRzUThhVHdvV3NYdU9j?=
 =?utf-8?B?eWp1WTkvbDBSQnF2WVlyRjZlNEdtb0twSHNFR0dmbVE4NUppUmhxMkZDMi9Y?=
 =?utf-8?B?eG5kVVB5M0NaY0lySFJEVTFDSFZqSEZTZ0JkYzQzWVplQ0FCNmMwQ3ZBaFpJ?=
 =?utf-8?B?UkFtQnlIcmNnd3BFZ2krOVpCb1hEUDlNbURVYmxsVGdaM1VlZG5kaitXSGll?=
 =?utf-8?B?RXltMlE3bzhwME0ySmxRRHhxSUVWMHc0QzBCRjdJVUpMVE1qb2pWbnFiNVB0?=
 =?utf-8?B?bGVrYWdHcy9rU1hURmx6bE5iTVAxNXFnYjFlWnlqUlR2U2VjakZmZ1c5MUoy?=
 =?utf-8?B?MHdoQ0RRMHprc0dWOER3MzJHTUJhS2lXYTJsL3dwS1dQRVg1ZGYxSGJxRTA2?=
 =?utf-8?B?Yk0xaEg3TllLWks2akgxVVBUa0FiM1RFU28yWHN0VVJ0UVZLV3ZDbk5FUlBH?=
 =?utf-8?B?R1NpblNtMWJubmlJSHA1RHNTNW5FdTZ1enN5NkRqRHVVUkJBRXVTSVdyc1Yz?=
 =?utf-8?B?WGZiampEMmVGWWZqQldQSE1kSHlvZ2VBVlRQYUNjeDRnRmZSWkx5bm9TQjFC?=
 =?utf-8?B?MHk5TERTenc4ZWNuOW1YVmxVVE5TMmZxUy9MTFFRakUrMEY3UEpnK09kTG9x?=
 =?utf-8?B?WkJ0dTZkcUJ5b01Kc2g1eVV5MVhkVjM0Qi81b2NvRUd3VS9RV2lYbkwrajIv?=
 =?utf-8?B?R2c1dk5OcmU2cEhnSGNVMTlqcUc2TllNVExnOGM2N3I5dkptc3A1TUY0T0xi?=
 =?utf-8?B?ODMyWDNMSmhaMlJ2c0Z5WU10aHZ1Sk02Y3RNbWdHOXhIZlFCdER4YlZFYWtn?=
 =?utf-8?B?bUkzZzRldEhRZDBKbDFtcXh4Ym44K1h0YnZCNmZENm1MejhKZlB4RTFxbVlO?=
 =?utf-8?B?aDBXckMvU0Q0K01jZC9hU1phWlBzS01ZQjJwQjV6MDhjUU9CTUtmMEtTUU10?=
 =?utf-8?B?YnlSS3pkL2RST1BQdVZQMk5mZmVObVM0ZkZPVjV0QU5Ra01aOFQ4RGJCK3pU?=
 =?utf-8?Q?7CL8fLpFAS/3GJbE3qHnkTyB/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4310c8a7-83da-4f6e-ad08-08dc8acea1aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 10:58:46.3626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrwveCPRbA5kLRnOUDuVZu9Bimiecu4maXmmCOmtfS45V36XZG4AU3x2nshwbD7b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
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



On 6/12/2024 3:06 PM, Yiqing Yao wrote:
> When flushing gpu tlb using kiq for gfxhub, kiq ring is always
> local by selecting kiq instance. Test shows mmreg write data packet's
> higher bits then 16 have no effect when flush using kiq on gfxhub.
> 
> Also some variant have policy blocking higher offset when req/ack is set
> with extra bits and can cause flush to timeout.
> 
> So keep the lower 16 bits only.
> 
> Remove redundant code.
> 
> Signed-off-by: Yiqing Yao <YiQing.Yao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 350f6b6676f1..f3fe318e0c1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -853,8 +853,16 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  	 */
>  	if (adev->gfx.kiq[inst].ring.sched.ready &&
>  	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
> -		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
> -		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
> +
> +		/* 
> +		 * Select lower 16 bits to write in local xcc when flushing
> +		 * using kiq to write gfx as higher bits are always ignored
> +		 */
> +		if (vmhub < AMDGPU_MMHUB0(0))
> +		{
> +			req = req & 0xffff;
> +			ack = ack & 0xffff;
> +		}
>  

The issue is incorrect mask passed by host driver in discovery table
which results in incorrect register offsets. The fix should be in
discovery table passed by host driver and RRMT mechanism will then take
care.

Thanks,
Lijo

>  		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
>  						 1 << vmid, inst);
