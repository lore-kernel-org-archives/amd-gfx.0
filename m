Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD05AC48260
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 17:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F4A10F7A1;
	Wed, 24 Jan 2024 17:15:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605C810F79B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 17:15:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEC0Us/imRMvpYZqONV42aZGbXv3AcF7T0k1YR/30eubfzii+GBPicGq2e4xZ1cijaPvB3XUgZyAfCOwL9J099f5FCHNhLi8VT2m8+Cveirch0GFTyBv3308UpywpSqlV9OJqAtSODxv2NTvjn+9F7LukXpgI+zHAH5RuD7paQ5lrr3e9c7ebwAfXHEtcCD4rwG13QrxKeZAjJr2+5uzh2TLVBuxNPQHPtohcMI/VQekvhdXnkho0pZQNpL5ODXM2HiZOhWH1jlgN2/PoM+jX+fFspfC0YxZGUaIvdnLKkwzoEidSYwb1TiTHvzSEJrmFT7zTfBvT/opD7W+SuIy6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKNCOLPEsp7yRAZ+gkzIOrTquPH7NwMZjPVo8omWqO8=;
 b=LSvSAnZIICidHNdJjJnHA7tZt6x3yRgehbmVIvRX/wzOrQ24T+5LUklxNU8lo67hdvXKvN9W8CmwLDt2mVwd8QGPHlhgV/8bMK3APfgwAMW6SNRQLMxL50Iook6LnrKW2VQERJ1aenkvcsumPGjeU5AlvaRGfou3qeqeOhpMdF4SqRe18hZ1ieS7O3C94gpDHoHJ73cFYNP/cFGLKIXYyM1sIMVOB0EPrzO+fEo+hV2OnEh/9ogfMvC0UzlPAHU6SO4JqaCePt1OD8PcuqGbEo3ujJV8Pb6W0nYKkQhQfbchDTOEJX8wCm3tA+FLpfkq8SbAbvkRIg5WTY7RrN4ANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKNCOLPEsp7yRAZ+gkzIOrTquPH7NwMZjPVo8omWqO8=;
 b=MX3gDH4Qh1OarwR/2fL8mDBbrcJjakQ+BPrwvPz359D5LnNd43ndlw/3qVfZ5fwtlODmrUxUf/ak05H4h6xyzNeUJ438LJDL7r8+fF7UtSej20FnrCDQYQy540mKWa7gZcP/3tVx5k2++oHdZTGzJjwjntSrRomYGVnn+W2GppY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 17:15:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba%4]) with mapi id 15.20.7202.039; Wed, 24 Jan 2024
 17:15:31 +0000
Message-ID: <96390dc4-9584-4091-8fff-94682e7c2b3c@amd.com>
Date: Wed, 24 Jan 2024 11:15:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amd: Add a DC debug mask for IPS
Content-Language: en-US
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Aurabindo.Pillai@amd.com, li.ma@amd.com
References: <20240124170906.901841-1-Roman.Li@amd.com>
 <20240124170906.901841-2-Roman.Li@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240124170906.901841-2-Roman.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0032.namprd11.prod.outlook.com
 (2603:10b6:806:d0::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6e1cae-f0a4-4158-431e-08dc1d001176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGSmh5U5IfGvtou+0Q3gIeoHpmCMNFiNexUIyv0K5u1mjS6ZdAUg3AAtto/5DyurCvxl76Ge3BFlbaFK+ywL7X3dPYsczb1ptPlUhlYttWsuuS9T6MsNSAaN2haT371V7htrmOXwv/RXgD5iof+JmxWC1E5ZmMfpELi6Gi6kH43F7FbmWolqy6Xqg0QcMB7EhvadpMJWlEfeQKaRmzILurT7T2XDu23TcYyzeMTD0SnROS02W1GD05HIJ9GsHTIycslqUongmdvUbD7ky+GLKweme0ZqpvePpTTXAl9f1I9v5CO0QaXBCrI6AJ8ophfVGl9V9YX5dYgsLaAgt7sjor5/HZV7zTi3cMcQvkFZjV5GCqVowtBtAI+H/l+SrRmbYD+xoO2VeDLXErBuz0aCO+cUsxJFjRMFn/0FuI2frl3vSJBhjfMzSGQvMfnAqcx/OhSG0RcVpJ/Qi6fr6lHuOUUuK9bJJpV91vEmw/7JVEisOpJoF90JDVoiyyAFADXqTw8fCfNVqnQiFMEClO+sLqNIpKLO5WtPrIr298j3VUoE9TquG6PegaWIpHo3BihqLEEFwvxl8CGPhSmHRpxCc3SH9IIi8N27Sij7kmjpaWp0CtB7fJKNl7s9izqwQ3f8SHp7gjDa5FyqrrqscVU2BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(4744005)(26005)(478600001)(8676002)(53546011)(6512007)(41300700001)(6506007)(36756003)(2616005)(66476007)(66946007)(5660300002)(6636002)(66556008)(316002)(4326008)(2906002)(44832011)(31696002)(38100700002)(86362001)(8936002)(6486002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0o2Sm5TYmJmL2ZwbHp3SngveTZSeFE2WWtLdmU3Wlpyakx5dHdiTFIxNkdV?=
 =?utf-8?B?cDcvQ2w2UHdIREd6K1FPUHNWR3k1QWk3WkRYQWxrUng3b0Z0bENJODZvN2JU?=
 =?utf-8?B?SUw0QldqQTNjZ2hEdkRINXdZMEZGeFh4SUV0R3MwM1dsbVVvRmxQOFNWR1Rs?=
 =?utf-8?B?dVJYSHNucGU0QnZrYk5TY2FEWUw3VVNKbitHUlRZODErTXUwNWZCY2MxTTVM?=
 =?utf-8?B?Y3RianIvdERQUEZHckNzY0hUQ3AxMGZGM0hHa0lRaXpLNG9ZcnhXVFlZdS8w?=
 =?utf-8?B?NUNrVzNhRmhPRUI2M2Y4WGNXWTZ0NGpNZzBaV2IydjlnQ0VmS0RicTM1RDlz?=
 =?utf-8?B?NStIYmxaVG9RN2ptelNaT012SlF5ZkJnR3U2bEthRTBrdTd1ODZscm1jNTdF?=
 =?utf-8?B?VHhYMlNmVzB0VWkvVzUvZVRyQWdLUmIyWi9KR2gxSlBYZ2Q1NldFc1RleUVn?=
 =?utf-8?B?NVpOVGt2VXdWL2dHSTdZSGw4TDVVWlQrcFpoOGpoT0EzanpaTmRDVFlRNThp?=
 =?utf-8?B?ZEJHSXF5K1NTZHRjcG5aQjV3ZWduR052MzBKZFZYbkVMTUNKUzRzdkJ5TWMr?=
 =?utf-8?B?OG1YdVE1dm93Q3NkLzIrWHNtTG1QbXhONCtxSEVBZm5NQmFSRmlTWTJSc2dh?=
 =?utf-8?B?clVXTDNPSmU2dHU5eDJqSjFMdFMvWTY2MEdYN2wzbXhtZUkwYW44aGpMWjFo?=
 =?utf-8?B?SDd6NmxGQVRCaHljMHBvVEtZK3M0VTJabHVyM2lGQzJGaWtRZkt5WDh3WVAw?=
 =?utf-8?B?aWNPaE9zcS9Cay9Td3lNQitoNUVneStvOTJGMk9lcE16VWl6cENKd0lBMjhL?=
 =?utf-8?B?T3FYdW9KTTVmSmwyUnNTL01vdVpJUHZOOUFJUGwzQThPdjdGd0hXYXZjMHkx?=
 =?utf-8?B?bjZhdlh2dVJDdkRhWThuOUpIUjEyY0xlZEJsajh3SDVVWDhNaTlwNGtnNlF5?=
 =?utf-8?B?bXBVL0FucFRPK3Q3Sk5ZeS9nYU1DOGtUeWFhV1JjbHFuRVNIL0dMTnhJUmNY?=
 =?utf-8?B?aTVMYWUva2YwYlVIcEtueldtbklGeU92N0oxUU0xbk1waE16V09YN1JVRG9r?=
 =?utf-8?B?MGp4Tk5IR0NtUUlJZ1Roc2QwSEpGOExDeXBaSVBNaSsvSUIvSElJSXJFNEQv?=
 =?utf-8?B?VlIyT3dBRWlTdnV4aUd6OHRLbjNvdEJ6R3NxRHBwSUtPZERMdS8xaWVsdzZa?=
 =?utf-8?B?U2JrV09oVmpQQ3FYTHNGTHl1czVlenJUTW1UWElhWXU1NWpjb2tMeE9ia0c0?=
 =?utf-8?B?WUp2VTFLWS9qS3NDZE5nL0laSXlueWZPbkVlRXJIaXVjRWFPZk9majhrT0Vz?=
 =?utf-8?B?SUVLLzVySnBSMWM0UGZKOHNIZ0FpaS9GeS83M3VCWWVJVzltL3l0Y3JET3NW?=
 =?utf-8?B?NzlZUzJwY2x3bSsxZzZQdWh5S1RtYmx5dVpCSTVGa0Y0aTFqRk9USUkvdjdG?=
 =?utf-8?B?aGZMc0tQbmU4YnFudllYRGMydHY1V3ZMTTROSHNZc3VFdTRpcEFYaUVZY2x6?=
 =?utf-8?B?cnJsV2FjdFVDVEdyYmxXdmduYVEyeXRKZHZ6dUZMYnNCdUJzTER6T2tCY1N4?=
 =?utf-8?B?a1dVZGRCM3RIZnBMelVEQVdIck9yQlpZUHJOSXdpb09WUExqRmVVa283S1dp?=
 =?utf-8?B?TUhORWpoQ3VsdzB0b0I2bmJLNS9CdEJsaU5IUG5IMmVJWTV2eGRiM2ltTmpQ?=
 =?utf-8?B?enJHZUtKL2NhSmppT2xCREdGUHFPRGtZd3dtUXFwaVk4ak02YXZJaW1GbDRu?=
 =?utf-8?B?WHFDZ0l6OEtEck5DcksyZXJVZlFyOVQ5cFdYUVMyR29iRm1jeDR3c214aE5R?=
 =?utf-8?B?QWVIUTMrTXo4VXhqb2h4dXVhQ1poald5N1hISDRSV2dTVDZzUjNEWVJOd1R6?=
 =?utf-8?B?dGNVSEN1TmJvSEJFKzl1cldPR1A4TFF6R0hURnpuUWVUVzVXbTRuL0dMVFBM?=
 =?utf-8?B?a3NhRHZZbDlnM3ZObEVISENlS0g3WmVubDRudzF6YVNwUFhyMDZna2JNQmh5?=
 =?utf-8?B?UkY2SS9kMWEwWG1NNWw2dGwvb1dSVGdnOUpyalMvNytXMkxFZzEyWTF2amk2?=
 =?utf-8?B?OFYwQTRJNE5ITGxwZzZYTW8yTTZNM2w5YU1wSnpGSzVVTEFFR0hJdGNnaTFN?=
 =?utf-8?Q?TYIhkOdjc7tTEL9S/uw2EDoe4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6e1cae-f0a4-4158-431e-08dc1d001176
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:15:31.2708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLOpV521/5o7d/3L/FFnz5ACNXnv49gIdzdHtixyKWyMatIuPiqip83v0qJam7W1r98BT3Vwq19cKUl4TWfv0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
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
Cc: Mark Broadworth <mark.broadworth@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, jerry.zuo@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/24/2024 11:09, Roman.Li@amd.com wrote:
> From: Roman Li <Roman.Li@amd.com>
> 
> For debugging IPS-related issues, expose a new debug mask
> that allows to disable IPS.
> Usage:
> amdgpu.dcdebugmask=0x800
> 
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> Tested-by: Mark Broadworth <mark.broadworth@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/include/amd_shared.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index da9b670fec86..a89d93154ddb 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -259,6 +259,7 @@ enum DC_DEBUG_MASK {
>   	DC_ENABLE_DML2 = 0x100,
>   	DC_DISABLE_PSR_SU = 0x200,
>   	DC_DISABLE_REPLAY = 0x400,
> +	DC_DISABLE_IPS = 0x800,
>   };
>   
>   enum amd_dpm_forced_level;

