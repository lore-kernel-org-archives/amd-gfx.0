Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01A2C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 05:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A29310E64B;
	Fri, 28 Jul 2023 05:39:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B6AA10E64B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 05:39:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQRnMuV9PMH8PC9rRr4NC0dUEbYztmc4vtLK8Qt9oVcEtYtXkh3tTCZLsNCQFuH8XrUq2qH0siefvScHVQfDtQLSJ/YYOS8IL2OhQriIndMMHY5epa0Y/W3bX/51XUq8LPnjyyyGaNoRsNWYk2sAtjv3+fsCSxFIRiD/PKqq+X02FVyv7lGxmqDmY0hS5LgVPwAcJivu+1Crtq4KFjbruBdHWqucdOU6zfwyS9ggHAfkWQsivYoJ4GARFbmi3qGwjEeNUTEJaPqg6BxDTNkKSiknWHpqw+29Hc2Ou+MYwne3gBmFIdlyDPJvfyYZFpAsEhrlPSYA03kyPvcm1H4Iag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlpJSAxgDndAYDrxTEpopIeyOsvNVtfVGA1hwYsQXyQ=;
 b=bs2iHVpsgJYLrIW63RSGPdx4jqKZeg39UpDdlVcPKvuE/lbLnl/MwSJoFkCGtvZ1C8UlurpFzzUH3ExNgxHMIsNC5LttunxvRNa/G4rc6c5AVyeX+uU5bMum0w43gK10IFXxBDG9ROhGM3H2n9G4g+AOUhzG+jqEUvh6Djxvx8yiemo9Ah/Zz/7u5lMDaRlqLJmbZLTvV3ZRWQ9z9YTo74M2JWpD5LGMmlAIVIgtMjZ7fbxdcUGdirXC6r1ZP7DfC336DNWAeKaqM78MwmAZpFEnRt1E6lNBY+bVG6sTg53hIFu+gGffAWvU5w+FD8OaG52SSxz5lWqisWUpI+Yyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlpJSAxgDndAYDrxTEpopIeyOsvNVtfVGA1hwYsQXyQ=;
 b=QQ1fhRIirJbfMzBTJUTNJ6CvDNPMvs54gt+TJPD4zRfC9zQgi2BgGJYfWaeBmh3JNXjws1vRUorfYWjk6JPbWJQFXeJTGJeyXqGcWAJ8jcQt9KK9kZMrX0u63nnzlD2+MuGGbw+Y+wmg6kaAYlVnU2n1jRRe69vyCumrLFw4hwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:38:58 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 05:38:58 +0000
Message-ID: <5d5290e8-9c16-45b6-a48d-eb2cf8372c55@amd.com>
Date: Fri, 28 Jul 2023 11:08:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/8] amdgpu/pm: Implement emit_clock_levels for
 arcturus,aldebaran
Content-Language: en-US
To: "Powell, Darren" <Darren.Powell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230427062718.1172269-1-darren.powell@amd.com>
 <CH0PR12MB5387598198E7CE8281D5F77AF001A@CH0PR12MB5387.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CH0PR12MB5387598198E7CE8281D5F77AF001A@CH0PR12MB5387.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: d7caa053-d492-475e-06be-08db8f2cf088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qULJ35gH6p+x/clZttUNDmHY9uqX0Lzbb5Z/zhijgMXE0f0oci3Pfa9FsN7EPqgkf0xSuFYpWgYSObFgOsNdRTrJase8I0LCFKOEKWdtSQHn1lpl7PoagkeO43KO9n5dWuNyRd9OVoQgUwP7VYMspQG3SA3FlfeDxbm2/wE7pwb3BHmpUy4LAyfI2PLxufKiz80/cIkUDz09321OYG50zaskyN1JfAnkOllNtR8P25nV/38bJbTEWNV491bnGzepCL/Ore2G4soEKZYt2XmJmMk/EPkj0ILrmagTE6yRWKuMEHHac/AbPAK79PfInXyfz4jy7+32KiXFvigqrMA8x7jJgx8JSOgbyEsL85r++5rkk43NHTdjvo7OQqmBI3bPaqFrLaN+qhfJ5YG7Ee/y72MiQvrVz0DZYTik/rO2dF+uvGvumpmNQ3EnwhdfwmcKZw5cq7G9aNJ8kG/CDT9xArdQ8MR1r+/LV6zUwKb7iK+CHUxOmdBt0VftlI2dY6rloQMYGg/Lp337+Rs2DAC7a+4tqBIJx7jTUkGFSGb4jXG2MfHCtxHHJGSdioSvHmOm8/VDjYNYw2RZ9GFhKHBfyBZNU7RzU5l0/wWYaV32yz95+nkpUdQ5ICm7LtACoRwTGlPZ+qPB0XEI11q62FAauQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(31686004)(83380400001)(110136005)(54906003)(31696002)(478600001)(316002)(8676002)(8936002)(36756003)(41300700001)(2616005)(2906002)(86362001)(66556008)(38100700002)(66476007)(66946007)(5660300002)(4326008)(26005)(53546011)(6506007)(186003)(6512007)(6666004)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTRVYjI0eTJSc0RyVjh2ZFlsbjVoREZCVCtWWFRqZ3NtbDFEU1N0M3FNbjJh?=
 =?utf-8?B?cGlJZ3FibEZnVFhZR0M1WG9FSXZLRlBFRXVkbW9MaWhvRXRuSUIvY2NzOEtD?=
 =?utf-8?B?ekVmVVNsY3FoTVB5emlvYkVGc24vMFJMTm9SaHBvYW81UHdaY0VMZlZxRUFz?=
 =?utf-8?B?eTQ2bStpSGhNKzNHNFYrVnFodVQxOFNiaHQxU0Vwb3RJSE9OYVBwdHFYZU5I?=
 =?utf-8?B?WnBacU1LaWxYWGQ0Q09id2dqWkZ2a2QxZ0lvcWJNaFg5YjF1M0prcVE4eHVI?=
 =?utf-8?B?dWZaMEYxMVFENkxFcU1lTHRFUjR5NXNUL28xNCtvUEdYKzRxNndVb00wd054?=
 =?utf-8?B?alpXZjk4WjVjeCtaaVoraFZISVBxQ0hLL3Q0T1FTQmt3a3hHTkNybkRHWkVp?=
 =?utf-8?B?RFRQemhBREhUTXc5MlJzOFpvbC81YUJpY2p1OFhJY1VUdTVTbVRiVkY4NW11?=
 =?utf-8?B?cGVjU3lKR1hUcVFybklWZlVMa1NoNDdsRmhScHBGai9USW15c2FOYTVqOTBN?=
 =?utf-8?B?UHBwaENVeW1xMkdZUDVyMitvL2pQdEluckJEWCtzTUhFZ29lOVJURXlUSDZF?=
 =?utf-8?B?eGdVS0QvTTBPWm1lY29OSXFHbGJsTzZjTTNvYmNKVHVGRXJhQUlzWHNLSlhE?=
 =?utf-8?B?aGgvN1JYamJOcTFDbU91dk5udU9kVFU4MFJXdlgwcWpMZXpKZHNhdk92QXdz?=
 =?utf-8?B?eE9EMWd3bmJDV1BwYnNwYlNnSmV4N1RVRTNLSXVlYmRMLzVCNHlZYjVPYUhZ?=
 =?utf-8?B?aFR0N1NHZ1AvZW5XMGorT2VZR3lYRTFxQlA3bGJhcG5GNnFBaE9nckYzVWVM?=
 =?utf-8?B?WTJuZHRBTUpmb29xZk5YaS9GbnFTdVJ6a1MyU1pQdGdWRm02eXNicmExKzVj?=
 =?utf-8?B?cEl6dHN1VmlYYjhjZkNwUW9aSllLcDNwWXQrMEVtd3VpN0VPQll2c0lSYTdO?=
 =?utf-8?B?L3VQSklNR3I2T0dVY0RMSFVSMU1UdXFHNGtGMzhQeUVnR3g2Q294NGE4cjUz?=
 =?utf-8?B?TmViWkRhckE3R1FyczJxczhWVDlRSVN4dUl1TW5JOUp3a2J6dzE2K2RYM0x1?=
 =?utf-8?B?SUppblJFV3Btdm4wVkJGNE4wdmhFdmpqaGs4ZUlJeHpJeVRRTkFpRlpTOUMv?=
 =?utf-8?B?UzBsRHhCS2FjQTlTVThtUEE1d2hEMVVnSURaeXlKeEZyS253SFdGa1F4dlBh?=
 =?utf-8?B?NThYR1U4TDJkajlPRmZrVjVHRmxhUmxmMjRNREZZc0k5aDNIMldycDhkNFE5?=
 =?utf-8?B?VHpHUE8wSWxJMS94WUlxOW9QQm9KMldzRGdmLy9CN1dDV3pzcnFLb3ZpY3h5?=
 =?utf-8?B?VFV2cjgrcUk1eEJhakIvYzhscWFNRUVnMDhLeW9IdmdxZm0zVktrZElEaVg4?=
 =?utf-8?B?YTJHbjRHRFlCMmx3cUx0b2tUaXRmNzRzUXVYSXdwZlZMajRia2oxVFpPaVZF?=
 =?utf-8?B?MkhUc0lpeXdLdGpGalNhNE5HREFGd2lQUzJuWlppeDRXYU1zVEdsYnhlRlp3?=
 =?utf-8?B?MzZtc3g1YXAxeFZzZmNyVGM0L0N2OWlQd05KVmF1T1I0Y2hRSjZLTEd4R3d5?=
 =?utf-8?B?ekxwemViNi80VW9NRHdQOFB5WHBwQk91VllGNFF6N1RhbjFwSkhqbXY0Z3Jk?=
 =?utf-8?B?dXpKZWFmOEUybENwWDQyTXBJNG14VUNkK3M0cC9ORldpVGFoelpUaEZjdlg5?=
 =?utf-8?B?b3hUYWx6N2Y5SWUyY29PVUtNUnlCN1R6bmpNUW12RHNaVW1wTjBRTlR0Zy9Z?=
 =?utf-8?B?ckdWZnd1U3JDUngvMUZvT1hsZTlZMWZLTnp6YVo0RXlGWkFUT0twNTByMUJF?=
 =?utf-8?B?blhaWmdrNWU0RXBJNW5rcUNGVXhFTTdUL3l4OFM0VE9xT1YrUFRhTUV1NVEv?=
 =?utf-8?B?cmlpL29mME0zL3RGQzE3b0lYdmhQNzdXTWQweTQ5TFd3c1k3RXVPNFJKYmwv?=
 =?utf-8?B?eDBWdEMrc3QzYnlVaDdNUytGUld0NTZCdEJLeS8xQzhQcEVKYWE1dG9Mb1Rh?=
 =?utf-8?B?WkFGMU9tMks2aGRCbVZtSVA2WTI2Sm1kUDZ3TVVRVDMwTUF4Rzh1Q21sMmNM?=
 =?utf-8?B?YS8ySmdhdmIzdDdaUW5CK0s0aEFGc09XYkIzOWxSY1VnclRVUUM1Zi80Nnpm?=
 =?utf-8?Q?6yFNJz6Y6NIuXjYIwIV76bC9i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7caa053-d492-475e-06be-08db8f2cf088
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:38:58.3573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZD0SvCnL5/msLOpnt+hyB827ig8Ta9e7AoH8eXqvc90tdsb84ga9sNP53JGObHe6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Yu,
 Lang" <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/28/2023 1:21 AM, Powell, Darren wrote:
> Hi all,
>    Just looking for anyone who could RB or ACK this patch set so I can 
> submit it?

Apart from a few nits mentioned, the series looks good to me.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Thanks
> Darren
> ------------------------------------------------------------------------
> *From:* Powell, Darren <Darren.Powell@amd.com>
> *Sent:* Thursday, April 27, 2023 2:27 AM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>; 
> Yu, Lang <Lang.Yu@amd.com>; Huang, Ray <Ray.Huang@amd.com>; 
> david.nieto@amd.com <david.nieto@amd.com>; Powell, Darren 
> <Darren.Powell@amd.com>
> *Subject:* [PATCH 0/8] amdgpu/pm: Implement emit_clock_levels for 
> arcturus,aldebaran
> 
> amdgpu/pm: Implement emit_clock_levels for arcturus,aldebaran
> 
> == Description ==
> Scnprintf use within the kernel is not recommended, but simple 
> sysfs_emit replacement has
> not been successful due to the page alignment requirement of the 
> function. This patch
> set implements a new api "emit_clock_levels" to facilitate passing both 
> the base and
> offset to the device rather than just the write pointer.
> 
> This patch set replaces print_clock_levels for arcturus and aldebaran 
> platforms with
> emit_clock_levels, and also optimizes the code to reduce the code 
> duplication for each
> different clock. This was spread into three parts to show more clearly 
> the changes made
> to the code, followed by combining the common code into a second switch 
> statement.
> It is similar to previous work on vega10 to implement emit_clk_levels
>   commit a63e6b83 ("amdgpu/pm: Implement emit_clk_levels for vega10")
> with the addition of the optimization to reduce code duplication.
> 
> == Patch Summary ==
>     linux: (git@gitlab.freedesktop.org:agd5f) 
> origin/amd-staging-drm-next @ 2d8c6b82e241
>      + 9a269da4c047 amdgpu/pm: Replace print_clock_levels with 
> emit_clock_levels for arcturus
>      + 51ce0fcc9599 amdgpu/pm: Optimize emit_clock_levels for arcturus - 
> part 1
>      + dcaa5b7551dd amdgpu/pm: Optimize emit_clock_levels for arcturus - 
> part 2
>      + 1d16d820e4ee amdgpu/pm: Optimize emit_clock_levels for arcturus - 
> part 3
>      + b374fbf6013d amdgpu/pm: Replace print_clock_levels with 
> emit_clock_levels for aldebaran
>      + 2ecf48d3e83c amdgpu/pm: Optimize emit_clock_levels for aldebaran 
> - part 1
>      + fd8c21e1d1e4 amdgpu/pm: Optimize emit_clock_levels for aldebaran 
> - part 2
>      + a67ce808f18c amdgpu/pm: Optimize emit_clock_levels for aldebaran 
> - part 3
> 
> == System Summary ==
>   * DESKTOP(AMD Ryzen9 7900 + NAVI10(731f/ca), BIOS: 1.11)
>    + ISO(Ubuntu 22.04.2 LTS)
>    + Kernel(6.1.11-20230412-fdoagd5f-g2d8c6b82e241)
> 
> == Test ==
> AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
> AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk 
> '{print $9}'`
> HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}
> 
> lspci -nn | grep "VGA\|Display"  > $LOGFILE
> printf 'OD enabled = %X\n' "$(( `cat 
> /sys/module/amdgpu/parameters/ppfeaturemask` & 0x4000 ))" >> $LOGFILE
> FILES="pp_od_clk_voltage
> pp_dpm_sclk
> pp_dpm_mclk
> pp_dpm_pcie
> pp_dpm_socclk
> pp_dpm_fclk
> pp_dpm_dcefclk
> pp_dpm_vclk
> pp_dpm_dclk "
> 
> for f in $FILES
> do
>    echo === $f === >> $LOGFILE
>    cat $HWMON_DIR/device/$f >> $LOGFILE
> done
> cat $LOGFILE
> 
> Darren Powell (8):
>    amdgpu/pm: Replace print_clock_levels with emit_clock_levels for
>      arcturus
>    amdgpu/pm: Optimize emit_clock_levels for arcturus - part 1
>    amdgpu/pm: Optimize emit_clock_levels for arcturus - part 2
>    amdgpu/pm: Optimize emit_clock_levels for arcturus - part 3
>    amdgpu/pm: Replace print_clock_levels with emit_clock_levels for
>      aldebaran
>    amdgpu/pm: Optimize emit_clock_levels for aldebaran - part 1
>    amdgpu/pm: Optimize emit_clock_levels for aldebaran - part 2
>    amdgpu/pm: Optimize emit_clock_levels for aldebaran - part 3
> 
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 166 ++++++----------
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 181 +++++++-----------
>   2 files changed, 132 insertions(+), 215 deletions(-)
> 
> 
> base-commit: 2d8c6b82e241f2d1a802ae6bbc24c127e689c724
> -- 
> 2.34.1
> 
