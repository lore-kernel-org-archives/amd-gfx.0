Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577ABC35274
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Dec 2023 17:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C402A10E6D0;
	Thu, 21 Dec 2023 17:35:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 580B510E6D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Dec 2023 17:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kY4wfx2l4bEtJY4zrx2LKiPMrp49I2PzbcaQYHh0ijZrYsvq8cnJPhyADz0kusaVdXllu8NuSBvt+w1cYK2CFMKSq/25E3GUWceCuYbN8a5NvJMve3pQ1s32AIq7+VmgASRjZXqWJ58l1WPul20AwZi6vNyp40ooNT/yoo1jSvvknivtaf0p5xFfgmh9leR55XLTyzwPZ68YydXYQ9P9NansmqbN0Gxrpou/JAxBqbMsRELfUxnYftPD9rxtfPP195pAiKdtCCOXliS0JLYzXtlST2UMTY11ttbKotX0AFImHxLGc7qzDsBGrYm8y/GnN/gKtupvC2HWyoDJS6kpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFUL3evj21fEZ7MKg2Y8RaebFBJQk7xBI+DjQd+imq8=;
 b=cdeV+0L7tDBkuvmimTcTEpxpvnIZHNsOy9DrHUdPEtkScvxFwyaexso+qW4BbqE0jAOne1Gnl883wRDDMwBsmgSg/xG3PydT8B22ba4fu/QTzDtKyH0b3c9xdjcjen5kUK1LiGUkmioEZfWlUdTZABhE8ENvge2f8AJwVxbJrYmB6QKC9SnWOxTHfR1zIwMNVTe1ORmLuOWURMEfgxJJae0UVTHRo/gwOB7n3Q9bNRVDk/CVLe1S/RfjvhnBbqSbnDDZxXJNT5nfYnjgpKU7xhPMWHJR6ClrbvLu5ifR4GlGfUORonhqN89NMrpLj35eNr57JcpD/IouGoKo5fFZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFUL3evj21fEZ7MKg2Y8RaebFBJQk7xBI+DjQd+imq8=;
 b=hjjEDNIDn2Tebu0C4Ph9usV29OZgCRV9zLhIAxphfGkoFcHJebV/u/Q8Y7VTo0ZTUIPLUlLk5D3yyReshFPy+woYNfe9iuNkxIqBXSTtaijVUfk+KDZftKLwmcsXdCF7HxyO596Mb7VHXncOcqQcPbXAlSsXh56SJgrxqoe732g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 17:35:37 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::5f1e:bfb0:43e5:dc81]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::5f1e:bfb0:43e5:dc81%2]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 17:35:36 +0000
Message-ID: <2340cd6f-a89e-4e97-b1f4-e3034b020790@amd.com>
Date: Thu, 21 Dec 2023 10:35:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Adjust kdoc for
 'dcn35_hw_block_power_down' & 'dcn35_hw_block_power_up'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20231219073734.149142-1-srinivasan.shanmugam@amd.com>
 <20231221171346.1394528-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20231221171346.1394528-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0682.namprd03.prod.outlook.com
 (2603:10b6:408:10e::27) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: a57a7ff1-4444-4df3-0661-08dc024b3e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HiobqLRl1uO30wlB/z/ImfP7iIhCdO/4g5vS2oiPz7Fs+LKw56JNz0vN5t9ZRqJd+LgWn8qzPpIsLtUw8+jtc/KeoeuFRMazzhkcSqqvV3sSxFgZTIwLxIvCzJai20R5vSYVgokqvCIKNfWGi5aYqQo89Fjp3w2klNQuihOOpfZ5F8Ioag48dcfx5Gd/ZZN5s+6p9E/EjfUlMut2dsc71NpU7EBc2MkPqxy62hOipRbcaeRBagSAhN9nWaCYFZq5f2ISR8+T6u0tmsueDfPU0H78KrQfRk6u1e7PvEM7Zagpw/NfFwjkPtb/LcQ6nHKn+dYzAPmFGb+g+ABwtPJLvqtq5uctOgLD/+9N/A0NqPFa7RaZFoLNcQqHY3YkbYsu+JMxZ/BrcJ97gvH3hXEjXBOWUxPiGYyg4B9Vpp/oO+RcEnum4d6stp7fPhxun3xg3RUmetco1R7riMiesvBflXvNCvYJ27n8kqltjF5shd1xOy5PtGD8gJAfWMjKwVLiEUjq2HXczYIFhNJkUTtoDrxircapRXXWwH/uzBdlQNsrGX1SYqrr2dSEJLgIcmQ+i8tyE79B1YUaPMFLsCyBGZlY1751qCKLXUKGlDu6Qbq49uhMAWaPQY0Y6abGYul32QCHZCSUl7Crl7XJKjyFJVKy9cRXz4c68FGeGDEaOzH9OkWNDtipDTTz1Zhkj0lA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(39860400002)(376002)(366004)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(2616005)(6666004)(6506007)(6636002)(53546011)(6512007)(110136005)(5660300002)(2906002)(478600001)(6486002)(41300700001)(8676002)(4326008)(66946007)(8936002)(66556008)(54906003)(66476007)(316002)(86362001)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q044WHo0cmNJakJvMU81ZE82U1JQQVc5bXV6a0M2OVFTSWFWYnZTR08wTk44?=
 =?utf-8?B?QXpBaTNLU1Y4OEdwQWNhQ2syQ3dFUDMzam9JRVI5MWFDc1phUWhKZmZNaDEw?=
 =?utf-8?B?Y09FSTV4SENSb1FjbmkwNVQveGRTZW0zdkZjWUFLekRFNlZhY3AyYkkxWVJt?=
 =?utf-8?B?RERvdFNYVW5VcjYzZjJZdGtmdmc1QUJLdjJGNmhTUDRJdHI3Unl3aGk5cFkw?=
 =?utf-8?B?TC9yYjIwOE8wcXNBNnFscGR5ZnNWTHJyS20wUW5DbGUrWkhwZnlzMkduZEVK?=
 =?utf-8?B?WFJqc09JdUJtLzd4aUkveXNxM3dzcGdtKzIvK0trKzZyVEdueXN3dGxmQVFo?=
 =?utf-8?B?NUtuNi9yUkgxMXZDUVhJWkg4bHROMEl3NmhoRDhHNnY4bXM0WU91OCtQUXE0?=
 =?utf-8?B?dk92SFFCbEVNNzhRUk9YTWs1OXZIejBLTEdZRHd2dkQvQWhSMHlCbm5QUXoy?=
 =?utf-8?B?Q2VVOEtaNTljRytqR0FnQUY5ZDB5b0NFQkdmR2FZV1l3d1pTaUFUM09uU2NK?=
 =?utf-8?B?Y2VwNTF2M1VoSTE5bDcrcGlMejllTVdxU2dVVnBObDgyVUpwZEU5T0xjRno3?=
 =?utf-8?B?ckZubGFNSWlIWnkyQmhudGwxbTNraDFwOGxQQnJkU2lEdzc0R1c4YTVKeExq?=
 =?utf-8?B?QURZWWE2dCt3TVQ2TldXcCtMbEpBL0VZRCtMSWhzelkzTVh2alI3b1dBNTFD?=
 =?utf-8?B?b2lDaEtMR2MzZVZWL05nTy9rWnY0R3RGeTBXclB1WXN5Vk5xNkkxd3VPVE1L?=
 =?utf-8?B?MDhEUnB6WmdvLzUzU2p5NndJdkxhbXZTS0xoK2l5eG1FWnRxcE14UHBUcUtV?=
 =?utf-8?B?blZwOWptTTFHdVV3VlZobGlxcmV6TWZRbWE0Mm44VHBIQU1BK1h0UTN3OUFJ?=
 =?utf-8?B?WllEOEN2azF0azFLYXBsRmlQbmJ2VXJJSWtMVm9CSEZzcjdEREVrT3NiUk5Q?=
 =?utf-8?B?N0twWGdPMlBsbk5jMTZWRkNkcGNhcng0bHRGQ29mY3NoVTBGQkkrVFZLelgy?=
 =?utf-8?B?ak9jWDhocmMrN05lamRzd212d1Z4N1hTWVZ3Yk1MbXRKZXFCRW9HYlpxRmFs?=
 =?utf-8?B?YW9ITjRGZEZFVkxyOCtsd1VJbGd6ZnA4Ylkzdyt1N0VjQzNIYXcrR29vY0Zo?=
 =?utf-8?B?THJLd3E3a0R2bHNzVzdNU2h1SmdiRHM3UEZxd3c1cDhMQWs5VW1NWnV6QmNE?=
 =?utf-8?B?MHM2S0hrcWZwclZ2THhaMWhRMWR3OVc1bWR1OE1jaDRickRjQVdPWG0yL3I5?=
 =?utf-8?B?cEkwSm1OZTVuc05qMnF6NXA3d01jMHlJZ0dkSEpzVVJrdklSVFMvN2FMYy85?=
 =?utf-8?B?VXE5OWlsMFl1MjRrNGNrcmlPa0lGWTVwZzhSWFdxTzVMV1Q1TU5hcTNPU0pT?=
 =?utf-8?B?VWQxR25ZWDhqdWlzZGpkM1I4RjVSNkpjNGIxdDhHQVI1OEdPRlN5UUFsYnY0?=
 =?utf-8?B?dWVqUmFad1ViejNMVTcrMjZmRGJaWjVKQkF5VDlLdGJsZWxvTHNicDZKV3dP?=
 =?utf-8?B?Y080cjBnUnV2RDgwNWtEUVpSQWRPNXVaNTRRM2E5anpTS045dmQzTkt4ckdi?=
 =?utf-8?B?U2hOeFFoTE1xUmt5KzYxY1dNaGN1RlZMVGFudUo2N3JjQnFNdzI0TmRjU0ZC?=
 =?utf-8?B?SE04T05NYitXek5KQnR3NnN5eS8zRFZaUnkwRElxOUhROTl6cDdMeXg0eHRK?=
 =?utf-8?B?emd2QllHOXNITThXWkdHVjErZitpdGVwMW9CRlZRWjNQYVVEekRFU2laTlZ5?=
 =?utf-8?B?S2RqWXNxMGcyVzJOT0h6UlFGYzc0VDJYSjU5QzcxbVNCamhWRE93SjVWdXlv?=
 =?utf-8?B?NGk1VU5VWGsxcXAyR0VOd2JLbVBsS1RyV0NwbDNKU3I5MXFoSU1pZk1NeG5u?=
 =?utf-8?B?enlncW1qK21BMG5UUGdGRE5zb0dnTkNUZ0xvbUM1UmdFYjhMWS9Nd25WdXdN?=
 =?utf-8?B?OVQxUlNmdTcxYkdtNkx4Sk54emVmMi9hUkwrdHFCMHA4OXE5bExpdWdqSjV0?=
 =?utf-8?B?dG0wTjJ1Sk1keDlKWUNIN3RLMXVSRW9RYXJ6QVdiNVY5WnZYazNScWNwTEcy?=
 =?utf-8?B?V3duaWVBTTdXd1U3NGdIeWRjQlVYeW44Ti9KaWhTL3NvZjAzRUFNdEE3RU9x?=
 =?utf-8?Q?vMteb4e0zBB/LmXjItglXxu0/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57a7ff1-4444-4df3-0661-08dc024b3e08
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 17:35:36.7694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAm48YVQuOoyzMZSTE13B2jSK/QmeH1D8pdA/xPcLUwzqNlIx6cyUHu7bIpBQO0swXJ88Mb0A1+/pksBGf1pBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
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
Cc: Charlene Liu <charlene.liu@amd.com>, Muhammad Ahmed <ahmed.ahmed@amd.com>,
 amd-gfx@lists.freedesktop.org, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Srinath Rao <srinath.rao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/21/23 10:13, Srinivasan Shanmugam wrote:
> Fixes the following gcc with W=1:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn35/dcn35_hwseq.c:1124: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> Cc: Charlene Liu <charlene.liu@amd.com>
> Cc: Muhammad Ahmed <ahmed.ahmed@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Srinath Rao <srinath.rao@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> 
> v2:
>   - Added explaination for power down & power up sequence (Rodrigo)
>   - Removed documenting return void. (Rodrigo)
>   
>   .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 68 +++++++++++--------
>   1 file changed, 41 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> index ad710b4036de..1cb61c46d911 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
> @@ -1120,21 +1120,28 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
>   		update_state->pg_res_update[PG_HPO] = true;
>   
>   }
> +
>   /**
> -	 * power down sequence
> -	 * ONO Region 3, DCPG 25: hpo - SKIPPED
> -	 * ONO Region 4, DCPG 0: dchubp0, dpp0
> -	 * ONO Region 6, DCPG 1: dchubp1, dpp1
> -	 * ONO Region 8, DCPG 2: dchubp2, dpp2
> -	 * ONO Region 10, DCPG 3: dchubp3, dpp3
> -	 * ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will pwr dwn at IPS2 entry
> -	 * ONO Region 5, DCPG 16: dsc0
> -	 * ONO Region 7, DCPG 17: dsc1
> -	 * ONO Region 9, DCPG 18: dsc2
> -	 * ONO Region 11, DCPG 19: dsc3
> -	 * ONO Region 2, DCPG 24: mpc opp optc dwb
> -	 * ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED. will be pwr dwn after lono timer is armed
> -*/
> + * dcn35_hw_block_power_down() - power down sequence
> + *
> + * The following sequence describes the ON-OFF (ONO) for power down:
> + *
> + *	ONO Region 3, DCPG 25: hpo - SKIPPED
> + *	ONO Region 4, DCPG 0: dchubp0, dpp0
> + *	ONO Region 6, DCPG 1: dchubp1, dpp1
> + *	ONO Region 8, DCPG 2: dchubp2, dpp2
> + *	ONO Region 10, DCPG 3: dchubp3, dpp3
> + *	ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will pwr dwn at IPS2 entry
> + *	ONO Region 5, DCPG 16: dsc0
> + *	ONO Region 7, DCPG 17: dsc1
> + *	ONO Region 9, DCPG 18: dsc2
> + *	ONO Region 11, DCPG 19: dsc3
> + *	ONO Region 2, DCPG 24: mpc opp optc dwb
> + *	ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED. will be pwr dwn after lono timer is armed
> + *
> + * @dc: Current DC state
> + * @update_state: update PG sequence states for HW block
> + */
>   void dcn35_hw_block_power_down(struct dc *dc,
>   	struct pg_block_update *update_state)
>   {
> @@ -1172,20 +1179,27 @@ void dcn35_hw_block_power_down(struct dc *dc,
>   	//domain22, 23, 25 currently always on.
>   
>   }
> +
>   /**
> -	 * power up sequence
> -	 * ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED
> -	 * ONO Region 2, DCPG 24: mpc opp optc dwb
> -	 * ONO Region 5, DCPG 16: dsc0
> -	 * ONO Region 7, DCPG 17: dsc1
> -	 * ONO Region 9, DCPG 18: dsc2
> -	 * ONO Region 11, DCPG 19: dsc3
> -	 * ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will power up at IPS2 exit
> -	 * ONO Region 4, DCPG 0: dchubp0, dpp0
> -	 * ONO Region 6, DCPG 1: dchubp1, dpp1
> -	 * ONO Region 8, DCPG 2: dchubp2, dpp2
> -	 * ONO Region 10, DCPG 3: dchubp3, dpp3
> -	 * ONO Region 3, DCPG 25: hpo - SKIPPED
> + * dcn35_hw_block_power_up() - power up sequence
> + *
> + * The following sequence describes the ON-OFF (ONO) for power up:
> + *
> + *	ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED
> + *	ONO Region 2, DCPG 24: mpc opp optc dwb
> + *	ONO Region 5, DCPG 16: dsc0
> + *	ONO Region 7, DCPG 17: dsc1
> + *	ONO Region 9, DCPG 18: dsc2
> + *	ONO Region 11, DCPG 19: dsc3
> + *	ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will power up at IPS2 exit
> + *	ONO Region 4, DCPG 0: dchubp0, dpp0
> + *	ONO Region 6, DCPG 1: dchubp1, dpp1
> + *	ONO Region 8, DCPG 2: dchubp2, dpp2
> + *	ONO Region 10, DCPG 3: dchubp3, dpp3
> + *	ONO Region 3, DCPG 25: hpo - SKIPPED
> + *
> + * @dc: Current DC state
> + * @update_state: update PG sequence states for HW block
>    */
>   void dcn35_hw_block_power_up(struct dc *dc,
>   	struct pg_block_update *update_state)

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
