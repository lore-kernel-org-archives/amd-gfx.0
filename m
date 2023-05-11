Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6154C77B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 May 2023 17:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5423910E0B7;
	Thu, 11 May 2023 17:51:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A12910E0B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 May 2023 17:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THuBGw4QnNJ8Yjj9ZC1re+z3ZgxeuQmMBk54GdQmXl1BgJfMwIvrcBzGdMdepj+mmBmGeTMuecYOiTa20ZpQZkS5Yv/yYkiYJ6oHCagxStBojFBBokeBN/aVe8VRKhlxMOWWu1JSY9KuI9ggk4uVXcVZGxwzNwbXyey8iXntWU0+ssqW194N/KF+klgqQMVdqe/+f/cYGQSwl3e+ScBbvrWcIrZ5bKzQYwtcio1XJIM20KZflC1//Sd/aToykFaNGv4RjQvn2+x/ZLKjIeLbG/UMxcbUAI7hO+m6JOyBo7cFQ2oys6QEJxFcDZ6xtTymOjw5jDbQsuiJ1crUCIqEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVMPOsiO1budrp3MdCIeGBKPTDXFB1muEw3Cc4y3Xfg=;
 b=mrmVeEG5elPrDDJbaMLehC/LbpBczS06GiKqlTQZxC8l/E/a7EKSOPzfvGtyLmYr5hMY1bLIoNx/RmGG290cbtlhSn4ONpD033Lj8GXiB3iiRIE31QvGH6QQBmPQNlp1OfNTOHOS95bzbDzPW1S4KRvva1vr7Xbz4CqR8dkXyiPPg2rexFVUH9vyDv7WPbKjdDG9/mO9Cgvmc4U2FKiKpoLokXbCGpJg/X76RwP7ZMaDLRHX+PlDkvcfLMURmiA+vW56O3DUuecgcPYHTGoC2QzhiUGtAUm09sF56R58GbjyxTGdspSet2mgD89QeyuSM6DH7cyKNyZI+4JSSA9RmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVMPOsiO1budrp3MdCIeGBKPTDXFB1muEw3Cc4y3Xfg=;
 b=lhaaDbtdxLUwkizA4lPpv6D8RZ80umLivdn4XdwXPATCUfsaXqt4gRivNK41my16Qh8B0GXjjizpTD4ufYE5CazM9OCFWy/AsEEGaBs4zqJ2uWBvEgDoF3QOH2VQ7REh6eRUku170xtlWldGid1x2vTi2tTOLrclkVMnsHh0fKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 17:51:08 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::3d88:4b4e:e0aa:3c36]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::3d88:4b4e:e0aa:3c36%4]) with mapi id 15.20.6387.019; Thu, 11 May 2023
 17:51:08 +0000
Message-ID: <68baa20e-8983-e941-d617-04663c65f808@amd.com>
Date: Thu, 11 May 2023 11:51:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] drm/amd/display: Add some missing register definitions
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230511153807.1154612-1-aurabindo.pillai@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230511153807.1154612-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:408:ee::17) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 10cc3a89-4e1f-4c5d-5dad-08db52484cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVT1MgC777GM8AtmpZcb1MJBNQ05ZVoX2syO52cbFHM88yHGBqQOTpZURg6AGv892dQHMHiJg3vsdtrLVkomCY3hKm77Tq7NKyZ+f3jNIWekBFKMpHQPbmAoOAg8vpveEu9vJL5X1Gfr6aMU3NDGl24SLEAbR2GTNi9ggUcDKqQgY6yTNKpGOEFvf4HNv6BFnIol+NUkh8H8LPBPDyLEB9KW2iftjXP8FC9fsSL7E4SpJ3i6N/WxGC2c4vHJsipzssYKFxFqsOPiXlzOYzX8a/6RlG3Da+F57jiPc0gFe9GwHq4xJSaLq1lEwZ29qdbphVvs7StvJYUmJXlATpAejhJLxUkSNukd+Q5i/fkqZeRD6L4tSBbkVyiYtEQxVkvx6/L3pDXgmUOAaSCL6nVm2gJh6ZllNKUAKO+xEeQWpvOS8Yodx3ky28rulKOLg+mibMSXZjudhf1yOWyaD3lrWCfyzRXVckQXi/XCmdrNkPkK1KHkVVBSB72lhxGVoLpXfvk7k3hLxlBk4WZA56M4K/nuvnerp56d/NbOuII9f1MihRVKgm0YPybp8sfXA5zjS+nMUllYYmr+RINXf5/EoBlLuENeBGzKiVOmpsUsXMRs6ZIcKV96CXAG1cTuNqeYVnoLHPfLgcwPvuBNVlc6yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199021)(36756003)(478600001)(6486002)(2616005)(83380400001)(41300700001)(6512007)(6506007)(66476007)(66946007)(53546011)(86362001)(38100700002)(66556008)(4326008)(5660300002)(316002)(31686004)(8676002)(186003)(31696002)(8936002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eSsrY2RvQWFiMGVxbzduTk55SmdYVVMzRWZ1aGh1Y1krYVFybUx4YjdXSDhq?=
 =?utf-8?B?VGE2NEZvcUpTSFgzaFFpL2IxUEpZYWUwV3IyUDlPL2VLN2pHbThYZFlnMTFk?=
 =?utf-8?B?YmF1YU1YNms3Q1pad1RMVXNoVTh1S0lnZkFaUGkyN3QwL3lOV0xRZjdMZllO?=
 =?utf-8?B?S3c5Qy8wY1dtWlhoYkJ5bk1hcXBJV3VYMTVoNGw2UWZCbWMvYjh0M1U0U3Zx?=
 =?utf-8?B?T2dkZVRMV1R2VmJqWFBtaUNQWSt6aFFLMGlTMFVEQWhDcVpYcnlrYjBMU0VP?=
 =?utf-8?B?bWNsTktYV3lMdEtobmZ3L0ppK3RLeHZTWlorS2ZJQXJHTUw3TGVCaHNwQ2Ny?=
 =?utf-8?B?NllYT29KWVJTVlY1WUhUNzdsRFp1QU9taXFoWElNTmN5a05CWk1NL05OaXRj?=
 =?utf-8?B?VHdnTWxtQXJvdkZyczY2a1RhNFg1Skt0NlpKaXRKR2F4Ulp3U21YOXRNS2ZB?=
 =?utf-8?B?QkdJOGwwcHFKQWx3RmMxalJDdDVBSmxlQnFIZGErdTc4NkxRQXorSmlVeWwz?=
 =?utf-8?B?b2JmZEpuOVNuR1V5ZVpYdFdTY2tRY09nTTE4M2poOS9KMFVMK1VsakViUW9t?=
 =?utf-8?B?Y2VqMGEwSFdTT3l4WVR3dFpSeHIvYmlyWDNTMWdhMzFrbWVRR0RSbUhITEpj?=
 =?utf-8?B?VWVMVkNILzhMemplNnN2enV2V2N6SklxYVZiKzYyRzh4Rmozdi9ZYUljVU9L?=
 =?utf-8?B?cm1lQ2ZIY05sZyt4RnY2NEp6NFg3RUl5SjlSeVFBYzExcVJLRkk3akc3cldj?=
 =?utf-8?B?Snp1ZXdQRHZQVzRVTW0wMk03b3J2djVENkFvdmx0R3BWV0U1ZlU1M3BESzk0?=
 =?utf-8?B?TVRVbC9rcGhRWkVvMW02NnprQXZZT2VpTllXYi9iU1dGakMram5hRzFOYVVZ?=
 =?utf-8?B?OXhBTEV0cVF6OXJEYzR0U0doS1dwdHgxZGJrRk9PTG1IVVBNc3Zod0FPNStV?=
 =?utf-8?B?cjdTclpqaGg3UHh6MTQ0TW15NGdTT2dJd1pJK1ZOWndOb2dzZHJIRHhqd1cv?=
 =?utf-8?B?ZTBoU3RzZS9wWGFINnRYS05PNkJ4aEEyWVJiMmJhV25oajBjbThhd21QTVNo?=
 =?utf-8?B?MGMvVk9aREFRU245b1V3SndxekVISjdrZXhkeDNpQXNraFZaUTgxUm5GVXdN?=
 =?utf-8?B?TEc3UllWTjdGTGt1dVJFVzBRZGpZczk3NHVtQ2FhcXE4WjFtSjVxQ0tBdDNs?=
 =?utf-8?B?MjhkTnJTenZ0RWYzV1VvSENVMllkT3lnQ1lGWHB6d3JPVllrU3k2TW03QnZa?=
 =?utf-8?B?U3E0SFhSYXJiV0x6Z0VjMndaR0hkWFNWV0V6Qk1tM3pnSGxiZ05MWjZkZU5V?=
 =?utf-8?B?T24zVDlmRjd4cGxJb0xvMGxmQ205MVlpdDd2VDdiWU00dEhZVlMwVDZqczNX?=
 =?utf-8?B?T05yR1RXUU9ZNTlDYVpqOE9nU1VVZlREM3c0dEZISTRKRGVCb1lBZWRnVTRO?=
 =?utf-8?B?NUpYS0hOSE5RbGN3OUh1QWQ3OExWN25jRk10bkRRMWo5WVk4RC9hU1FHYk85?=
 =?utf-8?B?eWp2MXhqWmFMbkhTU3ErWkV3akdPWU55UU41aEtDWW44M1B1Vnlkc0R0UlVy?=
 =?utf-8?B?ZElhTk9kTm9GZ25MSC9xYU5oNnArVVNPZFlGWDFOaHJ3bW5HNHFjYmtxSU5C?=
 =?utf-8?B?cXllZnZVc2JvcEpnVG5EVUI0MGZTcjlhQkF1bnhmdTNrMnYzb2gwTG84bTJK?=
 =?utf-8?B?UFg1RlFVclR5VHdPVVJ4M0pYZ1FWYkVoMjI0eEZ6SGF2SllXSFpROG54dnQw?=
 =?utf-8?B?aFlmVkhFTmZrUk84ZzVpelB1S3dqQVVVdEhrSHNPRDl0MmRHSVB4VUI0YVI2?=
 =?utf-8?B?RGdhU0REWGszQmpQR290Ynp1aXpwWXlIRituOGNBSGw0YUJOaUxDRFk2Nm1r?=
 =?utf-8?B?RTloY1EwbmJsRE9ZaW9ySW9Ed1JZUDQyK1QrWXRNWUpEak93Q3hFSjJ0Rkl2?=
 =?utf-8?B?OHhyNWZpelpiWm1CWVhTc0VKbUUrbUM0MjFiV3ovZ2dQdVZuTHlndTd3TlU5?=
 =?utf-8?B?MmRWSXlDNmhVdkpnRmdnK1g4NWRGU2hSV0EwWGY5amVmMkYvYXhKQmo2c3Nn?=
 =?utf-8?B?cHNGRnZpUWFrSGppTUNtU0hiTy9RWnJETU4wM09GaHpDRVB3ckRrTktXSkE0?=
 =?utf-8?B?OENGenp5ZnJYZjJaRWFUNGxOVmtUbG5aUVBTMm5nUjQ3dFpxK3Mvd3c2SE1T?=
 =?utf-8?Q?jBDU4zkqwPKNqMN/1TrwYXVf6fSpW30cPdIw02MV/CoV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cc3a89-4e1f-4c5d-5dad-08db52484cc4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 17:51:08.4485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w95325ZYJ05hVqjYEr5oP0tLKxcBc93J9xWvFkEaRXS5DL9SidHoPK8IVboezZcPIKWUVOVBCztT4ImQ1sRa9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
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
Cc: harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/11/23 09:38, Aurabindo Pillai wrote:
> [Why&How]
> Add some missing register definitions and rearrange some others to
> maintain consistency with related definitions.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    | 69 +++++++++++--------
>   .../include/asic_reg/dcn/dcn_3_0_0_offset.h   |  5 ++
>   .../include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  |  5 ++
>   .../include/asic_reg/dcn/dcn_3_0_2_offset.h   |  4 ++
>   .../include/asic_reg/dcn/dcn_3_0_2_sh_mask.h  |  5 +-
>   5 files changed, 58 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
> index a3fee929cd12..86233f94db4a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
> @@ -98,6 +98,29 @@
>   	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 4), \
>   	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 5)
>   
> +#define HWSEQ_PIXEL_RATE_REG_LIST_302(blk) \
> +	SRII(PIXEL_RATE_CNTL, blk, 0), \
> +	SRII(PIXEL_RATE_CNTL, blk, 1),\
> +	SRII(PIXEL_RATE_CNTL, blk, 2),\
> +	SRII(PIXEL_RATE_CNTL, blk, 3), \
> +	SRII(PIXEL_RATE_CNTL, blk, 4)
> +
> +#define HWSEQ_PHYPLL_REG_LIST_302(blk) \
> +	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 0), \
> +	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 1),\
> +	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 2),\
> +	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 3), \
> +	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 4)
> +
> +#define HWSEQ_PIXEL_RATE_REG_LIST_303(blk) \
> +	SRII(PIXEL_RATE_CNTL, blk, 0), \
> +	SRII(PIXEL_RATE_CNTL, blk, 1)
> +
> +#define HWSEQ_PHYPLL_REG_LIST_303(blk) \
> +	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 0), \
> +	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 1)
> +
> +
>   #define HWSEQ_PHYPLL_REG_LIST_201(blk) \
>   	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 0), \
>   	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 1)
> @@ -387,7 +410,11 @@
>   	SR(MPC_CRC_RESULT_C), \
>   	SR(MPC_CRC_RESULT_AR), \
>   	SR(AZALIA_AUDIO_DTO), \
> -	SR(AZALIA_CONTROLLER_CLOCK_GATING)
> +	SR(AZALIA_CONTROLLER_CLOCK_GATING), \
> +	SR(HPO_TOP_CLOCK_CONTROL), \
> +	SR(ODM_MEM_PWR_CTRL3), \
> +	SR(DMU_MEM_PWR_CNTL), \
> +	SR(MMHUBBUB_MEM_PWR_CNTL)
>   
>   #define HWSEQ_DCN301_REG_LIST()\
>   	SR(REFCLK_CNTL), \
> @@ -508,8 +535,11 @@
>   	SR(D5VGA_CONTROL), \
>   	SR(D6VGA_CONTROL), \
>   	SR(DC_IP_REQUEST_CNTL), \
> +	HWSEQ_PIXEL_RATE_REG_LIST_302(OTG), \
> +	HWSEQ_PHYPLL_REG_LIST_302(OTG), \
>   	SR(AZALIA_AUDIO_DTO), \
> -	SR(AZALIA_CONTROLLER_CLOCK_GATING)
> +	SR(AZALIA_CONTROLLER_CLOCK_GATING), \
> +	SR(HPO_TOP_CLOCK_CONTROL)
>   
>   #define HWSEQ_DCN303_REG_LIST() \
>   	HWSEQ_DCN_REG_LIST(), \
> @@ -540,28 +570,6 @@
>   	SR(AZALIA_CONTROLLER_CLOCK_GATING), \
>   	SR(HPO_TOP_CLOCK_CONTROL)
>   
> -#define HWSEQ_PIXEL_RATE_REG_LIST_302(blk) \
> -	SRII(PIXEL_RATE_CNTL, blk, 0), \
> -	SRII(PIXEL_RATE_CNTL, blk, 1),\
> -	SRII(PIXEL_RATE_CNTL, blk, 2),\
> -	SRII(PIXEL_RATE_CNTL, blk, 3), \
> -	SRII(PIXEL_RATE_CNTL, blk, 4)
> -
> -#define HWSEQ_PHYPLL_REG_LIST_302(blk) \
> -	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 0), \
> -	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 1),\
> -	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 2),\
> -	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 3), \
> -	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 4)
> -
> -#define HWSEQ_PIXEL_RATE_REG_LIST_303(blk) \
> -	SRII(PIXEL_RATE_CNTL, blk, 0), \
> -	SRII(PIXEL_RATE_CNTL, blk, 1)
> -
> -#define HWSEQ_PHYPLL_REG_LIST_303(blk) \
> -	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 0), \
> -	SRII(PHYPLL_PIXEL_RATE_CNTL, blk, 1)
> -
>   struct dce_hwseq_registers {
>   	uint32_t DCFE_CLOCK_CONTROL[6];
>   	uint32_t DCFEV_CLOCK_CONTROL;
> @@ -663,14 +671,15 @@ struct dce_hwseq_registers {
>   	uint32_t MC_VM_XGMI_LFB_CNTL;
>   	uint32_t AZALIA_AUDIO_DTO;
>   	uint32_t AZALIA_CONTROLLER_CLOCK_GATING;
> +	/* MMHUB VM */
> +	uint32_t MC_VM_FB_LOCATION_BASE;
> +	uint32_t MC_VM_FB_LOCATION_TOP;
> +	uint32_t MC_VM_FB_OFFSET;
> +	uint32_t MMHUBBUB_MEM_PWR_CNTL;
>   	uint32_t HPO_TOP_CLOCK_CONTROL;
>   	uint32_t ODM_MEM_PWR_CTRL3;
>   	uint32_t DMU_MEM_PWR_CNTL;
> -	uint32_t MMHUBBUB_MEM_PWR_CNTL;
>   	uint32_t DCHUBBUB_ARB_HOSTVM_CNTL;
> -	uint32_t MC_VM_FB_LOCATION_BASE;
> -	uint32_t MC_VM_FB_LOCATION_TOP;
> -	uint32_t MC_VM_FB_OFFSET;
>   	uint32_t HPO_TOP_HW_CONTROL;
>   };
>    /* set field name */
> @@ -915,6 +924,7 @@ struct dce_hwseq_registers {
>   #define HWSEQ_DCN30_MASK_SH_LIST(mask_sh)\
>   	HWSEQ_DCN2_MASK_SH_LIST(mask_sh), \
>   	HWS_SF(, AZALIA_AUDIO_DTO, AZALIA_AUDIO_DTO_MODULE, mask_sh), \
> +	HWS_SF(, HPO_TOP_CLOCK_CONTROL, HPO_HDMISTREAMCLK_GATE_DIS, mask_sh), \
>   	HWS_SF(, ODM_MEM_PWR_CTRL3, ODM_MEM_UNASSIGNED_PWR_MODE, mask_sh), \
>   	HWS_SF(, ODM_MEM_PWR_CTRL3, ODM_MEM_VBLANK_PWR_MODE, mask_sh), \
>   	HWS_SF(, DMU_MEM_PWR_CNTL, DMCU_ERAM_MEM_PWR_FORCE, mask_sh), \
> @@ -1012,7 +1022,8 @@ struct dce_hwseq_registers {
>   	HWS_SF(, DOMAIN19_PG_STATUS, DOMAIN19_PGFSM_PWR_STATUS, mask_sh), \
>   	HWS_SF(, DOMAIN20_PG_STATUS, DOMAIN20_PGFSM_PWR_STATUS, mask_sh), \
>   	HWS_SF(, DC_IP_REQUEST_CNTL, IP_REQUEST_EN, mask_sh), \
> -	HWS_SF(, AZALIA_AUDIO_DTO, AZALIA_AUDIO_DTO_MODULE, mask_sh)
> +	HWS_SF(, AZALIA_AUDIO_DTO, AZALIA_AUDIO_DTO_MODULE, mask_sh), \
> +	HWS_SF(, HPO_TOP_CLOCK_CONTROL, HPO_HDMISTREAMCLK_GATE_DIS, mask_sh)
>   
>   #define HWSEQ_DCN303_MASK_SH_LIST(mask_sh) \
>   	HWSEQ_DCN_MASK_SH_LIST(mask_sh), \
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
> index 537aee0536d3..f2f8f9b39c6b 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
> @@ -15805,6 +15805,11 @@
>   #define mmDME6_DME_MEMORY_CONTROL                                                                      0x093d
>   #define mmDME6_DME_MEMORY_CONTROL_BASE_IDX                                                             3
>   
> +// addressBlock: dce_dc_hpo_hpo_top_dispdec
> +// base address: 0x0
> +#define mmHPO_TOP_CLOCK_CONTROL                                                                        0x0e43
> +#define mmHPO_TOP_CLOCK_CONTROL_BASE_IDX                                                               3
> +
>   // base address: 0x1a698
>   #define mmDC_PERFMON29_PERFCOUNTER_CNTL                                                                0x0e66
>   #define mmDC_PERFMON29_PERFCOUNTER_CNTL_BASE_IDX                                                       3
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
> index f9d90b098519..e0a447351623 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
> @@ -60666,7 +60666,12 @@
>   #define DME6_DME_MEMORY_CONTROL__DME_MEM_PWR_STATE_MASK                                                       0x00000300L
>   #define DME6_DME_MEMORY_CONTROL__DME_MEM_DEFAULT_MEM_LOW_POWER_STATE_MASK                                     0x00003000L
>   
> +// addressBlock: dce_dc_hpo_hpo_top_dispdec
> +//HPO_TOP_CLOCK_CONTROL
> +#define HPO_TOP_CLOCK_CONTROL__HPO_HDMISTREAMCLK_GATE_DIS__SHIFT                                              0x9
> +#define HPO_TOP_CLOCK_CONTROL__HPO_HDMISTREAMCLK_GATE_DIS_MASK                                                0x00000200L
>   
> +// addressBlock: dce_dc_hpo_hpo_dcperfmon_dc_perfmon_dispdec
>   //DC_PERFMON29_PERFCOUNTER_CNTL
>   #define DC_PERFMON29_PERFCOUNTER_CNTL__PERFCOUNTER_EVENT_SEL__SHIFT                                           0x0
>   #define DC_PERFMON29_PERFCOUNTER_CNTL__PERFCOUNTER_CVALUE_SEL__SHIFT                                          0x9
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h
> index 476469d41d73..b45a35aae241 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h
> @@ -14205,6 +14205,10 @@
>   
>   
>   
> +// addressBlock: dce_dc_hpo_hpo_top_dispdec
> +// base address: 0x0
> +#define mmHPO_TOP_CLOCK_CONTROL                                                                        0x0e43
> +#define mmHPO_TOP_CLOCK_CONTROL_BASE_IDX                                                               3
>   
>   // base address: 0x1a698
>   #define mmDC_PERFMON26_PERFCOUNTER_CNTL                                                                0x0e66
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h
> index b9de0ebc8b03..3dae29f9581e 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h
> @@ -52401,7 +52401,10 @@
>   #define DC_PERFMON25_PERFMON_LOW__PERFMON_LOW__SHIFT                                                          0x0
>   #define DC_PERFMON25_PERFMON_LOW__PERFMON_LOW_MASK                                                            0xFFFFFFFFL
>   
> -
> +// addressBlock: dce_dc_hpo_hpo_top_dispdec
> +//HPO_TOP_CLOCK_CONTROL
> +#define HPO_TOP_CLOCK_CONTROL__HPO_HDMISTREAMCLK_GATE_DIS__SHIFT                                              0x9
> +#define HPO_TOP_CLOCK_CONTROL__HPO_HDMISTREAMCLK_GATE_DIS_MASK                                                0x00000200L
>   
>   // addressBlock: dce_dc_hpo_hpo_dcperfmon_dc_perfmon_dispdec
>   //DC_PERFMON26_PERFCOUNTER_CNTL

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
