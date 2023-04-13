Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E754C77B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 20:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0960E10EC1B;
	Thu, 13 Apr 2023 20:02:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA6D10EC1B
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 20:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SE8zsjRPajuoaB1me+UEfJPiGcqxfNCdnaSgLWL/68v4d7vWDeQde+9gMDNgMahtszkUBxtvbOPUREZzpDRQIMLTgillgCE+jhyIi3bcAwylDKWO7O9jAfLEdEXCUnx1DSkgTsZpMqln/wA5Fi0V5ORN8G4S8bUVSwuGZbmmhTJzacX6zOewLK0ezSGqs6wS8MXO22C+K+JrecHB5V8aAqkNXSfauTF4QswXt+c8hPLn34UUqlEyBP0vqMokE3Wa/aFItEa6icx1BhXhQyy74HOQIIcQGn2V8UmJz2AxcsFNtKlSdxM9VM10ZWpPOrRg0kMTW0rIM6yo41FvCIJrrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yZropclhQzCQdEfaDQgPZRNsUTjPm/IC5e7Sb5mhg4=;
 b=hbCfrcLmiEA/jrkp1RgwaXnQSBOBkIxurxoFPrb03vOMTSWAibfCwnZrJ3yDtPCoq2TMqArxJLttAMuqgRsNWGoKkqD60KTDWb6EIr88fsaMQv4ljooeLjDg5IJMzSVPQDIwgWhhKkJysCaC0csCo6d5Enz/MeTo6KzeDKbGAXwRKsiDyF/aOv53ZaT21q64uxAbde2yQLLr84s15im19xOH9DAwjVYqc6QOqMh193UDH2iRfoUoWlqhe+MGimk7h0ZsX4Mp350T0EdCOp6xTaBI8jIdZfzT07eDSIy9GjZhkbnyXhj97um389wSjD5uVD7MXkRojWXCkgiwr3SkIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yZropclhQzCQdEfaDQgPZRNsUTjPm/IC5e7Sb5mhg4=;
 b=dJ0tpaK6s7OT6tFJ6hLo00wEs1k3XAcypxpqHL8/6AjExhVCJOS0+elPVVsiytFC0EIs72dJbhVnOqPZy5juRXorkNJPLRPSIIbh/DpZI70eSrCTUtbbuSgW9JnIRUJ4ZAkn+GrTc9k1CE9iuBqX9Y78ZSqJIX2BOZawdaQ+v+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 20:02:13 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3e54:627b:ceee:ed2b]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3e54:627b:ceee:ed2b%4]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 20:02:13 +0000
Message-ID: <7ad99374-481f-d72c-c7cf-b50a7b6bdc07@amd.com>
Date: Thu, 13 Apr 2023 16:02:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/amd/display: Add logging when DP link training Clock
 recovery is Successful
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>
References: <20230413195746.2369084-1-srinivasan.shanmugam@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230413195746.2369084-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0160.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::33) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|IA1PR12MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 18bb8c6b-5e4e-4c22-e126-08db3c59f8d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKgL7v2TmlOTGLZPLn3zXEvdKlHYy41bY6+zzNLFX0mEPxhMEtkTBZ0NaA11wq4tSoNmeEVwBHbV4IWpRCIPIT6KdnsNRTXyUXyrVWLbIDSpBwtq2oJ+VvUjKKVqnxNTBrxqrWkKGPVYqJPbiYPEtThPMF5quRuo0ruAIcJVD0krjMA2h6PXCAQFph1unm3UaedIKRY9LJG7YAmXsOATcqE6/9Az2ugKiWRgMAyS1RuLb8t2AUkaUcdFier3VZLcVCdmzL0/DqVmDlYYjthh4Pk+oSSKnUK7MD7Tz0YbbcDhZg/Mv2eOlP8ap+ZL2riZfyhyOiiEx3nNRD5/mYXP3S359vS5LNF6UoGjt9N80/Mup12jfFaJNYDV794X9pjvIRku2LVGNjCfa8V2bkcKv6+ouu/QzbW1v7AbKQDibyo7xMHqGvtECkZZlr0O5+hNokqYRmpBPDtGRFel8gt8IDgGbmcdy9eMlswXy9oRVZwh9LlbCxEFVCAthipdA+vMb2qNmmwtFER8Otupsxou5HFlx5a/GaV0RFc+GFNX0Rg4SFPladppp7zhMPFHtUb1ZKGNOIr74Ii2/TWntNSr6AN4ptDQfsSqYM5NuCnj2g+VsM/WfDeEpCTcPeD4/z48JfMI0qAk6Ev2KW894ezRJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(316002)(41300700001)(26005)(6506007)(6512007)(53546011)(38100700002)(6486002)(31696002)(86362001)(2616005)(83380400001)(66556008)(66476007)(66946007)(36756003)(4326008)(186003)(110136005)(6636002)(8676002)(8936002)(5660300002)(2906002)(31686004)(44832011)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk5mQ0FLeVB6eWxtRHZEWm1hUitCVk9YWCs2cDFOMjFPZlpqREpJblU1N1VS?=
 =?utf-8?B?VjkyWkgyUWwxUU1nL20zTE1MRSswT25TQkRndVVxVE10T1ZYclJDMXM3V2hi?=
 =?utf-8?B?ck1BaWdjdDdweWI4TUYxelFGN1R2RjRkSUVuNUVha20xdEhCeTZzUkdBMllu?=
 =?utf-8?B?QlpuZ3J0YTIrOHhHcWhVbFJ4OExCTHRpM0hCNmZ2elBCSkxsN1JLaFRwVUpq?=
 =?utf-8?B?bUZKaUM1WW9qdFZ2L3lyQ0NnR3lSQnNZNUlxeHl0M2pHUisySGNuaXc5S3dH?=
 =?utf-8?B?OWdJNE9EbFVmRVc1OWtudncxLzZtRGVPVDljcDJ1eWtjdEpzR3pTaTAvTGJI?=
 =?utf-8?B?d1IvL3hMV1UrODZxa0xBcms2Sno0bm5hRmh5bTNmVFVSTHpCdkRpejJoT2dU?=
 =?utf-8?B?YVhoOEc2SWYwZFEzc1pzYWJXUWlqYnFIUC85WC8wdmdjVHpQYVJYZG5hd2hO?=
 =?utf-8?B?dlljdlBQdUltVzNKdjhZUnQ5VXlCZDJXdE03R0xSbzVhMVFJMG4xRlprSjhw?=
 =?utf-8?B?UVFRUklpY3lPTGIwelRTTTByMURJRzNxMUdKRHIzakduSld2ZzJ3eWNRSUNj?=
 =?utf-8?B?clF6VW5oVURIbUR5cExWODNZdkhUSXVoWFlJSHo0SHI0TmRvSjlIRXJIR3Zo?=
 =?utf-8?B?eEIwTWlTVDViUzc2NHhKMHpOV1V0QWMzWTMzRXJ4ZC9nSnpCazd4NmlLTGVE?=
 =?utf-8?B?bXN1T3UrZHJuWEFTWmx1cFpobVBaWjVOaU5JeXVEbzdmNEJFZWlIMUZ1bko3?=
 =?utf-8?B?aVpoY0NDQ2wrdVkyTmlXTlFpT3QrQkc3RU5SUHVPL094YWJ0bWhQMlV3WDRD?=
 =?utf-8?B?YmZGOWp1cTRjWnZpdE0vSkh4WUVTSjNMK0krRENzZVduNStIYjM5MUFVWUhQ?=
 =?utf-8?B?NzhHclFwRmo0UHZycXFJWjFiS2QvTC9oRmcxc3BNWnJENVRqV1UrcmpyZWFI?=
 =?utf-8?B?NndFQlAxeWxmMitSSmUrOENQSGpPN21BdTkyL0pLVTdZTDB3TWg2bWoyVGhB?=
 =?utf-8?B?VHY2cFRxeXdzR3E1c3ZJWVYzUFhxWFMwbWlMaU9FeVNtMk91M0lmMDdxWXRN?=
 =?utf-8?B?Uk95bHA2a00rUUpRUU8vM05sd05XcDFKQmlqak5Ed0pxOFB6M3hwYUljMEhn?=
 =?utf-8?B?NXFZNEtpMkV1ZzJ1alFucUtJVmJlYWpnbXVrZUJORjZHTU8rcVRmWXVaOWlU?=
 =?utf-8?B?NkhoYXV3WWtianVNTGlTV3NiT2FBMWdTVzRFWmw5ay8zdTZJMXI4VzUzOVdY?=
 =?utf-8?B?SlArRm9rTE5VS2w4ci9Ud255MFhLdnk0ZWdGeUtQREgxRHFTbjNpaW54b3Uw?=
 =?utf-8?B?RGhSQjVYZHovcGZYVVFIWlFTd1VWNEJlamxGazZicEMrQmF3WnQ4M2lOZDdG?=
 =?utf-8?B?WEZmNjEwa2NXQjdLTFlHSTE3eEFxUlQ2UkRIL0dpU2ZDaW5ST2JCRHNkblFR?=
 =?utf-8?B?b1hScE1iNGlPbDhlVmFNZlVvY0NhaFZ1bm5nUzNoai9LZmVXTmF4bmJ5ajAv?=
 =?utf-8?B?Y3d0b1JRSUxUWUI0aEFKN05CcWJ0OTdUT1c0WnRIUEpTMlpHOS9TditCYmUr?=
 =?utf-8?B?RUxCbTB0Q0NuRU0xR1ZLU2J1VUUrQlQxTlJqVkZMa05QUW0wWnd6UFIxNitu?=
 =?utf-8?B?T0pwRlpvNnk4VEJTbndEWmk4cmNWVXlBS0g3SnQwZUJBREpIckxDdE5WbEVG?=
 =?utf-8?B?Q1A5SFdvZVJuWUlscXRZa2RRRktqdVpvZkwwTjQ3RzQ5RDcyNXFCRmVwK2ZJ?=
 =?utf-8?B?d3RpekJ1TkRDbk9KRTV1UWZOWUptWi9UTE9ONUo1d1JEK2tUdWplMnVtSVVl?=
 =?utf-8?B?RTdiaENSSU9VMm1iMVBOeGFEUVlVT0YycjJlSXh6RXpaVUtDZ2tGRUFlQmQv?=
 =?utf-8?B?MVZjLzBrVlhOQ2R4RlhPNzlhNU9jWWtXZmlVTSs2a2tndGJxa0NFUU9SOGpq?=
 =?utf-8?B?UERRMDl6WktHSEV1cE9yTjIwTDFMWFF6SXR0Vk5RSWNUMno4cDRRbG1tc2FH?=
 =?utf-8?B?NWU2YXlIbFlPcWFQUXhLSStUbFJFZGVXbXdMQVZkRXRBSzQrL3V3UzNNTlJz?=
 =?utf-8?B?Vm5KUnJpNlhxaG9mcFkyUFRPdXJwUytPYW1iMU1VTXJFcTM3ejVVa3BydWVJ?=
 =?utf-8?Q?9ykpXmS2v5/v55rVWtpJ/WZOO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bb8c6b-5e4e-4c22-e126-08db3c59f8d6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 20:02:12.9022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjGNVKMK49RLNInNHXYZRRl4hKoPXZ1IS7MF2a7yeA8C7OBYUWJLCdg0rRm/NV89vCqc/TEA/+TllX5aYAhjhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/13/23 15:57, Srinivasan Shanmugam wrote:
> Log when Clock recovery is successful, as part of
> DP link training process.
> 
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../amd/display/dc/link/protocols/link_dp_training_8b_10b.c   | 4 +++-
>   .../drm/amd/display/dc/link/protocols/link_dp_training_dpia.c | 2 ++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
> index 41b38da9feb4..8ac4e879032c 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
> @@ -225,8 +225,10 @@ enum link_training_result perform_8b_10b_clock_recovery_sequence(
>   				offset);
>   
>   		/* 5. check CR done*/
> -		if (dp_is_cr_done(lane_count, dpcd_lane_status))
> +		if (dp_is_cr_done(lane_count, dpcd_lane_status)) {
> +			DC_LOG_HW_LINK_TRAINING("%s: Clock recovery OK\n", __func__);
>   			return LINK_TRAINING_SUCCESS;
> +		}
>   
>   		/* 6. max VS reached*/
>   		if ((link_dp_get_encoding_format(&lt_settings->link_settings) ==
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
> index ab4aafdb5e5c..4f4e899e5c46 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
> @@ -401,6 +401,7 @@ static enum link_training_result dpia_training_cr_non_transparent(
>   
>   		/* Check if clock recovery successful. */
>   		if (dp_is_cr_done(lane_count, dpcd_lane_status)) {
> +			DC_LOG_HW_LINK_TRAINING("%s: Clock recovery OK\n", __func__);
>   			result = LINK_TRAINING_SUCCESS;
>   			break;
>   		}
> @@ -508,6 +509,7 @@ static enum link_training_result dpia_training_cr_transparent(
>   
>   		/* Check if clock recovery successful. */
>   		if (dp_is_cr_done(lane_count, dpcd_lane_status)) {
> +			DC_LOG_HW_LINK_TRAINING("%s: Clock recovery OK\n", __func__);
>   			result = LINK_TRAINING_SUCCESS;
>   			break;
>   		}

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
