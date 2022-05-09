Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50698C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 04:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD25611212A;
	Mon,  9 May 2022 04:51:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7933C112129
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 04:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/pOgMIryoiA+nGEXUBXStiSINQcO8zSkJuUgUvWsZlfThU4UC5qBUfowg1AXuvSigOVA9oy+j4KIUDINxuDK26gD1R0ei623VfzaSL3UNu/frCXgHd4WW1YjuTl4oTHBmWrDR+nSel96Jgw9Dz8q/oP803+ng23ZwIXDuFC7SnHnLw8TE2BdyqTymMXcdfEZyLhp6o2xHBsulL3o9EtP9leZ6gnGaBcT8r1HTEKpVPjX6o/SagMfRH+Xg7G/w5XTIe0HTRYpCrxXyJt+iDsJVNsbO3hWi8bFNakuVOvwxac8cjF9tj2aqJ49DB2aLK4PA3E987AgNAg6ofBnuH0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuQMUROm2S8t+em4JyAXkuJSSVeG0O5k1uUlWWjM1Po=;
 b=IjLQJGlwAlbljhaVMNtZtwbelJSZMoxEviDsshqfJnhl/40UPRG1trganKDUAod/YkCbcMIshnRCSCgByqDj2ELsWpFzrswag2UIgfZ+Hf6ftEB2J1oBTQ37Q2Db9fsy9Md2KHIehZP2cihWKz7PEvic4bgz3HwtLnGv3Mg0LOlA0SGeRpPZyTlGkV7OcUmAKU0poeMS8fvSTukUpqYDdIr9fjhVMG2sZEkxLKukyNw8TWYhQtGuL6ASvQsTm+g7ra7sqhZusIH8GR3GLcVRYZ02NX/Kit+SslkRyAXnKux4bTdRcHfDzRdrHo535Sxc68YySpAkCl70U3p6LrLwBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuQMUROm2S8t+em4JyAXkuJSSVeG0O5k1uUlWWjM1Po=;
 b=m5/j2kRncocuj3yXmUHn94om/VufDj30dfOvnuNKXRnPHhNSgc5pqd9i3Gy2FWr5Nn4pkBqjOIyaGGuTN8ElCULIWIUKX+hti9rZzkoB+C2WR3Ok/awt6oArA6V5QhYDf2356zZSrAwHaOpS0jzxJHUVa6SHy1rm0zKkLF9SpvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB3056.namprd12.prod.outlook.com (2603:10b6:208:ca::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 04:50:59 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b1d2:8be:626b:7c2f%5]) with mapi id 15.20.5227.021; Mon, 9 May 2022
 04:50:58 +0000
Message-ID: <8125e521-2319-a74f-481c-ac0effd060f0@amd.com>
Date: Mon, 9 May 2022 10:20:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v1 2/2] amdgpu/pm: Fix possible array out-of-bounds if
 SCLK levels != 2
Content-Language: en-US
To: Darren Powell <darren.powell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220509035838.17410-1-darren.powell@amd.com>
 <20220509035838.17410-2-darren.powell@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220509035838.17410-2-darren.powell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3980469-c69a-4844-1a7f-08da3177825b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3056:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3056D7259AF561E16DEEC24897C69@MN2PR12MB3056.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oglBYH5nipFundmPhqYcUwbuZaFo7uyLbGujjMxN51lstdcWwsYHeWj+uY8Xrca0TWAK1vIZri0b+2QAXLRUkdhGgnif1c7kSLOdzpfqWlZzLCjjmvUBHnFwFsIc/FDrmE+p5M5D4I8qf/5/5FcP+RUaoD6VXVUezkAqZQDRGkqTRY5njrhIxUESa+Uclb9AAmaAAW/kXHoo+Ry5FRVBpox6yJe1vc+t1hSurqIO76jEe56AypWLmu4q9UPG65vkE2LE6rGRh62oBunJncDEIXqR93XePiZpBWIRrVyvzAPIatiPU2amK4jQbRrLdBMkUKnp2mMpWfcBWDbdYR2Vo/ZVuyK1eKvO0wUATr8yO7EPDiYYQunIyRWwBvh4hDVCQmdSGiNjKwmkejjOMA+Q4XZXo536/98frOYMkmLQY6C44miyon6x8s8t8pUk3oLDgFoippZqD6nHbU7AMLrxE42rP5vuOOOJG8reck/+bJI6OG+GpW/xZH5kKmQcx9Xkj+mtBhr47CvtxrFI+ShPSiO83g7jK42gLM5ecpKn0Sp83GhX8N4yXb2jysK/MMuC5vE8adzt7SQvpNtUyjXujofl/4ekrEd8LFNv2aIWWb94ZHpohWd5uQYFIKhiVb5jYxGlvSL7c5Ud9BoTxDgUyo20kmC7l6aQcRQbU77hfvTRvLnDrDsfiOBQvBgnR2MJ3aocsSUBK0tpW2kYL2nqy6lx38fQVaqMe/EIGTo9k9yAr4sxCDaRntwq8UFxe2zA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(36756003)(8936002)(31686004)(31696002)(38100700002)(5660300002)(508600001)(83380400001)(186003)(4326008)(66476007)(2616005)(66556008)(8676002)(66946007)(316002)(6506007)(53546011)(86362001)(6666004)(6512007)(26005)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEVPL3dUS2ZNQmlUcnA2dlpET1E5RVpsZE0wakpoeVlHbUEzSEU1S2NDMTlu?=
 =?utf-8?B?T24yY2tuL0twdFo5WVBUSzVmYU9nRExHWjdrM2ZqQ2F1d1BkV3VBVEhjcWQ4?=
 =?utf-8?B?RHR3Y29mVEJKUlNkL0NHQmRzeXFnYlF4VVUyYko2dGFieHJtWUNZcHozNkJ5?=
 =?utf-8?B?NkpyTlZ3SU9YeTQvY0dZalByQTNRaU1wWWEycVczYnlBOW1xVjBYWWtKU3ZR?=
 =?utf-8?B?YmxQOVVnc2NSZEJoZzd3RkJ5UmlHTHRaNnhNbERWNjc2Z1RoQmxIVjVzWHor?=
 =?utf-8?B?ekdDNDFpOG5vK1Y3RjNpVzVEaXp3d1FuMUdEMG1WaTJhR2gwelpmcSt6Zlg3?=
 =?utf-8?B?NzdlUDFZODFWcHhaWXBkMGpqcUVTaUNrTTRSSFBDUEd1Wkd2S3p2TURWNWRW?=
 =?utf-8?B?N3daVEtOZmloNDI0U1BEUTBqbWVvK052L2svWTNrR0ZQWkdvN2FyWFBWd2Rz?=
 =?utf-8?B?ZTdqYlNIeGRYY21qUEMxLzlmVTZnYStoWHBDMWNCMGR2c0c2Q3pQWGV6ZStj?=
 =?utf-8?B?QzZNN2d1dEhTa3J5SUhkMVp2QmpEaWxXbzcxakRXaTZLeVZHdFBVMkg5N1NI?=
 =?utf-8?B?bkdCTlY5aTFUckJvZnpIT21GQ2dkOU0reGxRamRNdXJTa2J6bFVFRVJKQ2pO?=
 =?utf-8?B?MVd0TTc5eDR3eVhSajJDd2R5KzcrOHZEcGVXVEFxU25Gc2I3d0xoWllzMEtR?=
 =?utf-8?B?eXgxRUxIZ3FLTVJvaE5NdXZHTWxLTkVUNExmdW95SFRTU003R1hkRmkxR2pa?=
 =?utf-8?B?bmU2NmxOdE9NQlZWc0doc2JjNFhzNVFaQkpFSUpxR1N6YkU0WGhCRkEvQk9I?=
 =?utf-8?B?YW1oOE9qVUFyK3owTnBhQmIxS0dWQjJuWklsSFVDa042VTZlaUJ0U0VyRyt1?=
 =?utf-8?B?VENCQkEwZXBlNG8zdXhMSjlSYks3ME5jS1FpMlB4VVFMOVhESnk2Y2p1cFNT?=
 =?utf-8?B?ektWUUVTcW9zT0FjSEI3bmxwNmxndm5TVUxRMmU4SzNxRnE2YlU0eng4Rm5Z?=
 =?utf-8?B?S2NFVFhSYURzOUU5aEg5MHg1UDZ6eTlBakU2OGc2QW5QSzdlL1MxNGdVV2Jo?=
 =?utf-8?B?ZTdtL0VoL2pQN0JKbjVIUG03ZFdFUHdPSXRKQk5DYmhaVzhhR09LMS85d0ZL?=
 =?utf-8?B?K2RFd0piWWFnTDVIQjlYYnBndjZqaTk2M2RtdnpLSjV6V1FZWXEyRlh2Slhl?=
 =?utf-8?B?YkpNRFQ0OVdUcHBiZ1gvR2hhWVFzd0dBbUZNTEhTVkVyWGt4cWZQaGVOamVl?=
 =?utf-8?B?ZGR2WkMzbUV1aUNVSStselBMMXRtc2MvcFMvVVNrNy9iLzZyalZSMjlCcWli?=
 =?utf-8?B?T2tGaEJnekJMSzdRdVpubURvSW5wWExldm9FZm45OW5lZHA0T2RLZCs2N3k4?=
 =?utf-8?B?dmc2eGY4a1RxMlExK1BRUnhwSUhOK3lyalo3UHhFdXgvNmRRYlBqS3djR0VX?=
 =?utf-8?B?SkxGOS9PaTJQdWRIZStJeXJSYUtWVE15NDM0T3U1TDBZN0JIWTIrR1BnZCtq?=
 =?utf-8?B?bFpzVHVQTlVuc2lBTk9JMncydk14YnQ5VjErblFsQnQ1b2pMc3NTaFJjZ3pF?=
 =?utf-8?B?YXdIeFU0cG9ZT3ZpUHNubG1BdlF1VE5Kak5SLzFMeFFibldKOFJIbDVxcGNI?=
 =?utf-8?B?enlFUE5qbUdzcHM5WlFsUXZYVy9wQVcvQ3hpM1ZjdHM1M0p4RWNPaVNwQUI2?=
 =?utf-8?B?dE5MTm9vV0YyRkNXdXJmWlh4ZGZ2Y3M2amxGRGhBTmFTTnVLZXk1SHRtVTY3?=
 =?utf-8?B?cmxQMGh2U0tTUnJHVkxSbnRtN00yZSt4bWd0OW4wenAxVnVOTlZ6ZUtLU1Uy?=
 =?utf-8?B?SEMwdmsyRjJYdWM1S05EL3pFNTg2eG0xbWxBaWI5RnVVUTR1L0Z0aFZZTE5y?=
 =?utf-8?B?QkQ4YVVNSFhhTnNBWGFqb0tlV3BwcnBYYUZ4MkNDeGN6TnQ1OCtKQjM0dXZa?=
 =?utf-8?B?UzZRWUx1Q3h0UTk4KzhPV1pWOTNqYjlnMmN6NldrVU96QWFPbmw4UldXamVo?=
 =?utf-8?B?dWNUT21JK2tMVmZieWVOU0xIYUszUWI4TkVRSXhlQ2JUNUI4YTJCUURta3cw?=
 =?utf-8?B?RmM3ZVRMRndFMDY4LzhuVUg2VjU0MWpGUDJOdlZNZnZHZGFpNU4wRXhXWlFr?=
 =?utf-8?B?TmdCN2RBczJiZUNtV1ZnbGVtMlIzZS95MHcyRG5aZzJTeldxZ29qbWc3L2tw?=
 =?utf-8?B?dDJzeW9zRzdxTzYwbGNVdlJjM0VSdFRkUVkzWDlRbzFmNkJYUTF3ZG5hcVZ3?=
 =?utf-8?B?OVVJWWYvOXJ1NlA2MkdSTmJUM0JXanFJanZKb1MrUUFhdGZWbDhpeXdyelBo?=
 =?utf-8?B?Y2pvQmxBR3l5UytWczk4bHZjYkhtM2owYWNvOVV3MnVlZ3FKcitBdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3980469-c69a-4844-1a7f-08da3177825b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 04:50:58.7505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvV8eA1I/NR3tJUD76Y1opDc7rv1bJl/v1kL6+ZsraErlpTIRMRa+b+2WxZ/QCVa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3056
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
Cc: Le.Ma@amd.com, kevin1.wang@amd.com, kenneth.feng@amd.com, evan.quan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/9/2022 9:28 AM, Darren Powell wrote:
>   added a check to populate and use SCLK shim table freq_values only
>     if using dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL or
>                           AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM
>   removed clocks.num_levels from calculation of shim table size
>   removed unsafe accesses to shim table freq_values
>     output gfx_table values if using other dpm levels
>   added check for freq_match when using freq_values for when now == min_clk
> 
> == Test ==
> LOGFILE=aldebaran-sclk.test.log
> AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
> AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
> HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}
> 
> lspci -nn | grep "VGA\|Display"  > $LOGFILE
> FILES="pp_od_clk_voltage
> pp_dpm_sclk"
> 
> for f in $FILES
> do
>    echo === $f === >> $LOGFILE
>    cat $HWMON_DIR/device/$f >> $LOGFILE
> done
> cat $LOGFILE
> 
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 60 +++++++++----------
>   1 file changed, 29 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 6a4fca47ae53..a653668e8402 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -740,9 +740,8 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
>   	struct smu_13_0_dpm_table *single_dpm_table;
>   	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
>   	struct smu_13_0_dpm_context *dpm_context = NULL;
> -	uint32_t display_levels;
>   	uint32_t freq_values[3] = {0};
> -	uint32_t min_clk, max_clk;
> +	uint32_t min_clk, max_clk, display_levels = 0;
>   
>   	smu_cmn_get_sysfs_buf(&buf, &size);
>   
> @@ -765,46 +764,45 @@ static int aldebaran_print_clk_levels(struct smu_context *smu,
>   			return ret;
>   		}
>   
> -		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
> -		ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "Attempt to get gfx clk levels Failed!");
> -			return ret;
> -		}
> -
> -		display_levels = clocks.num_levels;
> -
> -		min_clk = pstate_table->gfxclk_pstate.curr.min;
> -		max_clk = pstate_table->gfxclk_pstate.curr.max;
> -
> -		freq_values[0] = min_clk;
> -		freq_values[1] = max_clk;
> -
> -		/* fine-grained dpm has only 2 levels */
> -		if (now > min_clk && now < max_clk) {
> -			display_levels = clocks.num_levels + 1;
> -			freq_values[2] = max_clk;
> -			freq_values[1] = now;
> -		}
> +		if ((smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
> +		     smu_dpm->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)) {
> +			single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
> +			ret = aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
> +			if (ret) {
> +				dev_err(smu->adev->dev, "Attempt to get gfx clk levels Failed!");
> +				return ret;
> +			}

There are only two levels for GFX clock in aldebaran - min and max. 
Regardless of the mode, gfxclk_pstate.curr.min/max should reflect the 
current min/max level.

Could you explain the issue you are seeing? It's not so clear from the 
commit message.

Thanks,
Lijo

>   
> -		/*
> -		 * For DPM disabled case, there will be only one clock level.
> -		 * And it's safe to assume that is always the current clock.
> -		 */
> -		if (display_levels == clocks.num_levels) {
>   			for (i = 0; i < clocks.num_levels; i++)
>   				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
> -					freq_values[i],
> +					clocks.data[i].clocks_in_khz / 1000,
>   					(clocks.num_levels == 1) ?
>   						"*" :
>   						(aldebaran_freqs_in_same_level(
> -							 freq_values[i], now) ?
> +							 clocks.data[i].clocks_in_khz / 1000, now) ?
>   							 "*" :
>   							 ""));
>   		} else {
> +			/* fine-grained dpm has only 2 levels */
> +			display_levels = 2;
> +
> +			min_clk = pstate_table->gfxclk_pstate.curr.min;
> +			max_clk = pstate_table->gfxclk_pstate.curr.max;
> +
> +			freq_values[0] = min_clk;
> +			freq_values[1] = max_clk;
> +
> +			if (now > min_clk && now < max_clk) {
> +				display_levels++;
> +				freq_values[2] = max_clk;
> +				freq_values[1] = now;
> +			}
> +
>   			for (i = 0; i < display_levels; i++)
>   				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i,
> -						freq_values[i], i == 1 ? "*" : "");
> +						freq_values[i],
> +						aldebaran_freqs_in_same_level(freq_values[i], now) ?
> +							"*" : "");
>   		}
>   
>   		break;
> 
