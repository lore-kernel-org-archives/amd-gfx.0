Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88486C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 15:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02CBD10E164;
	Tue,  7 Jun 2022 15:34:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8681710E1D0
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 15:34:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrRZPmZ4phKEmDPer4n1gb25rj9Yh1MgKjKyc9nnvKYBaEIIoVY0ejgdPR1Cu69TdNdnszSV7Vlfdc3NAx0eiup4ECN5mzmcH87W7u4pk9TV9wpq9JbcrhkcpfoKTbT9DWiiSS4s7MSM4kqYsrNeh/OdDe5zvSP8ozva44yBPw8hidqe1s0iBdYpwLVJpiPp4X5jmk/Yw2rurD3uwY1jE7KOqYTHzhg6DAx4TwdsG6PpeUrEGsQG1OHTzvobXfZQ6b4cSYEv8JCd3RHi20LTVKj9pAU2o5QC88xNSXFwN7sXrhKGGECX20LQ6cKjzmn6eiFTavDJZJF1M7p/ulzPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whLSWUeXo63reTZihJUu9NZ/7SaMFY+mGoo2fnnqVA0=;
 b=MxEBJycPvsLt5Q4+/zBMOk8OLncpYq1SIcEGstBSvVivKOWUSPaImv80G/1tN8gOYQ/sVf9bSRk/l6+UiKKw5Br4+x+Sr4m5BCl3tuTdPYsdKnamwykxqlo4d6AtSLVqnu4OUNp1MP7lXfo1WnWpIfzJ9wGUWIApyrxJ1EWY3+qkaUwg+yxu5z8cF6MBWKQdHGva5/FO9Zk8GEbfM4DE1BD+g5cFSCUttayzzV0G8ns7LbUnhZJ/Jxtwn122cm4mxNkSPKGsfS+fiwpfxQboAhB5xhDvb+sSyOKkD/c22NARjEmdhpIvtI0CLsrDbXkZ4atKvMI7ypSq0xH7iyvdFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whLSWUeXo63reTZihJUu9NZ/7SaMFY+mGoo2fnnqVA0=;
 b=HhQ8lgmycBwo9RK45KDLrEI5HZxZC7vHeKQBBnhFBhv+o9jfMjQv912KdnQX29lSHK7mYCIRGdw1wBGmaPM7YgHV/RRfjT4mwvUF6pZcy/emvu839QCJpuKf9gsxRGGSJ1/MLu/5VbA/o89V8c4N5Yznj0ZttZciGXau0CBQ+tg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.19; Tue, 7 Jun 2022 15:34:22 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::c89d:e4eb:6abe:38fd]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::c89d:e4eb:6abe:38fd%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 15:34:22 +0000
Message-ID: <639ad722-f32b-0d50-4244-ae6bb0b15f23@amd.com>
Date: Tue, 7 Jun 2022 11:34:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu/display: Remove unnecessary typecasts and fix
 build issues
Content-Language: en-US
To: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20220607094004.946093-1-chandan.vurdigerenataraj@amd.com>
From: Leo <sunpeng.li@amd.com>
In-Reply-To: <20220607094004.946093-1-chandan.vurdigerenataraj@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:2d::29) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26e9adce-aad8-40fb-16b2-08da489b31ae
X-MS-TrafficTypeDiagnostic: BL1PR12MB5875:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB58750195545E688616155BE582A59@BL1PR12MB5875.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+/0SVgAmEZ/sA8DdvzJ26aSpVrQaQG19U56RbBtlGLITqPLaAue0XtSq7dhvdkLYTTcS8n3Pob2LZZTVX4F2SVwHO4yaqbEfsd/Mx7BZuLqhlAfrVbe5R0IDNFAbCFSwp9PXx6pqUNRNj0pHI269ruOGQ6ljbhQbezxL9EF7naik5W6Wh3XocwN3U1OxUzUj0D6EURduMb4iCKRRj0fsSMIWKqnE0T1XcJH8BdOtRrhZt8I41yc9gs0r83EIQDU8DqPRk+XsnUHFyTbeDfQVqSFFPBi/ZbhxUrndNsxDPEf2hlhN/U2KODGNtCiP1T2tSitSS6sfMLt6Cvre2Sg/lsZsdcXHC3jx10rM91h/3IXurtA52pu1Mgg+VicW06xDWj5Pec7dLSYMWC0mH3F1Jawe6jQgWAZXr4e6Zyox+sZW6oec1GevU+8hinBThUbkgP7rfayfKfZVYN7zSGrm8Gb6TPbvIA3YUDQfitiU+cEvi1EdQVjou8Ri/AJjoIEbFbRm+4ytCWFUDwusA/wAKsvr8oQUGSdM/rL4q0FxGXkmOM0MMLBTsRHy+CllQVEG0Omenwg7fEaL90YUM0Bzw6gUHVm7xeGEu+BhHllp5f5U1MO0kWuCMSCwSF04CKo4q38qHVmkncFqcXQdPPY2pUELxI32dN77arDpzRs+52IxGk0awt3alG4r2S69NMk7mczV2OsmnlXDbxNTJuUoy98fMu8un+vSJO3IChbRsw3KBGexmZkM4LJwVtNHyyH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(86362001)(66946007)(66476007)(66556008)(5660300002)(31686004)(8936002)(31696002)(2906002)(83380400001)(316002)(26005)(4326008)(8676002)(110136005)(53546011)(186003)(6506007)(6512007)(38100700002)(2616005)(6486002)(508600001)(6636002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU5wTENodHhsZXFtK21SbFRqanFSL3grdEM1bXMxcS9DRW1KWDQ1K2daR0hG?=
 =?utf-8?B?Tm5ac1dVNVg3TEhDSzdxd1BvTEYwTGNobzVNcnVoMEFYbTZaU0kxRUVVNmts?=
 =?utf-8?B?dU96VWZaTUxxMEJ6aE9YYUZ4OTFmelRNRGJicllRejUxVEFJbisxUVFkdUJZ?=
 =?utf-8?B?dGxoMFluZG1XZXQzL2RHYWtHYnhWNmlsM2xyS09QcHhwbUQ3blhTaXlaRitV?=
 =?utf-8?B?OEhRQ1piRTk2cnlsQjVmQk1ZVXhlaDh4YUJpNzdsOHpQL252VVpxSlFyY3BO?=
 =?utf-8?B?eXQ3OEtkQ1BUdVd1TUdXU0JpZVNOUmpWVUszOFMzdzQ4YVhVVGQzWW12Tktv?=
 =?utf-8?B?M2RSVGtSOC9adysxZkYzVmI5cWI0WkVmRUZFc2p3bG5hb0kxcFJIbkdSSDhx?=
 =?utf-8?B?Und1MnZ4RDBUYWVma3BlYWRTVVN0Yjh3L0h5RjB2ZW5kc0gvYVdaRTl0Nkpn?=
 =?utf-8?B?WmpnTEExaVFZWFNSNCtoVnZzUllRNlF4S2oxcU9QMW81RmhXUVdwSmN4bi9K?=
 =?utf-8?B?UlFUT3QyRnZuaDVnNGRlTnJsSXpqYm5qcWE1MjNuUVFFNGhTd3BtNTI0MkIr?=
 =?utf-8?B?K2J3ejdlZXgyamlaaEpNcjRoUVZHZnY5UmFEd3drVVBNNjU5TnNncW9vcjl2?=
 =?utf-8?B?WDV6OUVpbWN2RnhhdGtyaGNPWHphbWI5SG5Kb0tJQWJWZlVIYnp0eXRwc3Aw?=
 =?utf-8?B?SUFWZ3pqVzJTMU5zbHdldi9JMmtLaWVJOFVJeFN0TGszYmJLR3kwMndRR21x?=
 =?utf-8?B?Y1ZJUFVOQ3ZVcTZiREk4SW1MVnFNZ3d6VytvbDh4ZzJkNGJYT0sxM3ZUbVlv?=
 =?utf-8?B?L2hPSGpiMjkvY2JlMnUyd2dkQnpsY25GU2JDWnhFRmVkYUVGNER6ckdVanpP?=
 =?utf-8?B?bjh0UTBQMUpGRGxueld0dHNNcUlWTVpYTDgwNkpvRXEwK01qMXJWMWxQeWZG?=
 =?utf-8?B?R091QVZDTXdXeklFbGxwemtwS3ZpT1JFV0MyS3ZITTBLcWdWbEU1dWlyV3V1?=
 =?utf-8?B?TE9xdEJBR2hRaDhJNDM0RHIwdkJFdmZrZ2poKzJTcVNuRkpOOUQ1R0pFcmpa?=
 =?utf-8?B?cUhGRldYY1BjQ0pzQUNMOCt2bEhTQVd1dTAvaFlhVzZjN29QSlBGcFlDUTZ3?=
 =?utf-8?B?UE51ZmtZdUZsVmRZN2VVSzR1aldiNWIyNXM3ZWIyTnlxd2VFbWM4QUxmRFFV?=
 =?utf-8?B?WU5oblcwWkpiUWxpM0NKN2ZLSmJVTVdlNmZTc2JBK0xmM1p5OXhiamEwRS9a?=
 =?utf-8?B?N3pWUDlyNkZpNW5UTXEzVERIZmJ2RjhCT255dWJUbStTMW81TTNSRWtVUmto?=
 =?utf-8?B?MjlTQUZTK3pOZklxR0Z4d0dlU2lhQUpyQ1dxY09xUVF6MTR3djVxYVA0WUpF?=
 =?utf-8?B?SDdnU3FPSkU5eFVmaFJHMTduRGhJNFkwZ0tuNkxGSzVMeUZYS2xKeS9OZlRR?=
 =?utf-8?B?MUxyTGxMWExRNVgzVWl1d2VBNC94WmNyK0RaSEtQSXdDWkpBSjM1Z2orV0Q5?=
 =?utf-8?B?RkZ0QWFQWlJaS3IwZTFQbzJWMmxrZGNzMWtxT29uN1RnQi9sMEZVZ25qdzF6?=
 =?utf-8?B?a0JLV3M0bGI1cWdaczNWZ0VPcTJ0L2lENUZCbnlmQTM0L2NWdXlWL3pVQmsw?=
 =?utf-8?B?eHgwRHladHhrL0lLQW4yTC9KeWdHUlJvR05CZzNzRWxtRnNseVdYV1ZzUmZP?=
 =?utf-8?B?YThLMVFWQjNiQnhXQlUraDd5UDhKNk0vcmxnQ1NrcXNUMisweXcyTEJIT2J2?=
 =?utf-8?B?WlRVQld5bDJYS2ExbVA2c3NTU3FYWFNQdzNZQzloR3FCMU0yNzJrZTVubGlp?=
 =?utf-8?B?a3JNTUlhQitGQ1NaMk9mbkZQNTcwMkpJUmR0bjBZRGc0RE44MURhYzA4YVcy?=
 =?utf-8?B?SjRDL1lUVHk2U0VsaXZGbW0rSWxBc1FvRWhrRTBkYnhSMUVkZU5TdmQ2WHA3?=
 =?utf-8?B?d1hKUlVaY3ZlSS9UOXRabFlsdmNWLzE4ZXlvSXRSNmw0aXdINGw2N2VmSzdo?=
 =?utf-8?B?V1EzWnR2VU1zS055cHFabDJNMVRWUTk5Z2V2KzVyQmszZldzM0ltaEs1ZFlm?=
 =?utf-8?B?OTV4VnB1eWlIa09SWXJoVEc2NmU1ZnJRN25zelkxbkJlYStzbEFTRUlZZkQ4?=
 =?utf-8?B?a0dwYTJOSGxaTWxOcTA2NmVLZUpXRDk4SUs1UkhBL09mZmQwdFZUZExUN3Fn?=
 =?utf-8?B?L2d5QzFPL2ZlcjZuNDlkVzVTZmZwVk5hcVJyMlJ4U3N6aTlMdTZSZWZuUTdL?=
 =?utf-8?B?NTRjbGFUQ0k0bFhTTFJEb3dZQ1p3VmlGUGNmRWVBR0hBVnlCSFpSV3o0UGhG?=
 =?utf-8?B?eUlHTW5tOGg1bTJmdGNRN3BRcnhoY0tvcnJzREtNS0VnSzhHWlE0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e9adce-aad8-40fb-16b2-08da489b31ae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 15:34:21.9157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GY24hlBapxlXrxDC+jRjoleaS5UZJLuIgeVdKVcNLVXeQkoH5To3xwevNoiLe87Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875
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



On 2022-06-07 05:40, Chandan Vurdigere Nataraj wrote:
> [Why]
> Getting below errors:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1414:5: error: implicit conversion from enumeration type 'enum scan_direction_class' to different enumeration type 'enum dm_rotation_angle' [-Werror,-Wenum-conversion]
>                                 mode_lib->vba.SourceScan[k],
>                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1744:22: error: implicit conversion from enumeration type 'enum scan_direction_class' to different enumeration type 'enum dm_rotation_angle' [-Werror,-Wenum-conversion]
>                         && (!(!IsVertical(mode_lib->vba.SourceScan[k])) || mode_lib->vba.DCCEnable[k] == true)) {
>                                ~~~~~~~~~~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 2 errors generated.
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5484:18: error: implicit conversion from enumeration type 'RequestType' to different enumeration type 'enum RequestType' [-Werror,-Wenum-conversion]
>                         RequestLuma = REQ_256Bytes;
>                                     ~ ^~~~~~~~~~~~
> 18 errors of similar kind
> 
> [How]
> 1. Add typecast at relevant places
> 2. Move the enum RequestType definition ahead of declarations
> 
> Signed-off-by: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> index b77a1ae792d1..5828e60f291d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> @@ -1411,7 +1411,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>  				v->BytePerPixelC[k],
>  				v->BytePerPixelDETY[k],
>  				v->BytePerPixelDETC[k],
> -				mode_lib->vba.SourceScan[k],
> +				(enum dm_rotation_angle) mode_lib->vba.SourceScan[k],

Hi Jay,

This seems fishy, dm_rotation_angle and scan_dirrection_class are very different enums.
Comparing dml32_CalculateDCCConfiguration() with CalculateDCCConfiguration(), it seems dm_rotation_angle is new for DCN32. Is passing vba.SourceScan correct here?

One more comment below.

>  				/* Output */
>  				&v->DCCYMaxUncompressedBlock[k],
>  				&v->DCCCMaxUncompressedBlock[k],
> @@ -1741,7 +1741,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>  	mode_lib->vba.SourceFormatPixelAndScanSupport = true;
>  	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
>  		if (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear
> -			&& (!(!IsVertical(mode_lib->vba.SourceScan[k])) || mode_lib->vba.DCCEnable[k] == true)) {
> +			&& (!(!IsVertical((enum dm_rotation_angle) mode_lib->vba.SourceScan[k]))
> +				|| mode_lib->vba.DCCEnable[k] == true)) {
>  			mode_lib->vba.SourceFormatPixelAndScanSupport = false;
>  		}
>  	}
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> index 6509a84eeb64..07f3a85f8edf 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> @@ -5314,9 +5314,15 @@ void dml32_CalculateDCCConfiguration(
>  		unsigned int        *IndependentBlockLuma,
>  		unsigned int        *IndependentBlockChroma)
>  {
> +	typedef enum {
> +		REQ_256Bytes,
> +		REQ_128BytesNonContiguous,
> +		REQ_128BytesContiguous,
> +		REQ_NA
> +	} RequestType;
>  
> -	enum RequestType   RequestLuma;
> -	enum RequestType   RequestChroma;
> +	RequestType   RequestLuma;
> +	RequestType   RequestChroma;

This might need a wider cleanup, enum RequestType is defined in display_mode_enums.h and is already included in all the display_mode_vba*.c files I've come across. Unless I'm missing something, we shouldn't need to redefine RequestType.

That said, there doesn't seem to be any functional change, and it fixes a build error. So
Acked-by: Leo Li <sunpeng.li@amd.com>

Thanks,
Leo

>  
>  	unsigned int   segment_order_horz_contiguous_luma;
>  	unsigned int   segment_order_horz_contiguous_chroma;
> @@ -5350,13 +5356,6 @@ void dml32_CalculateDCCConfiguration(
>  	double   detile_buf_vp_horz_limit;
>  	double   detile_buf_vp_vert_limit;
>  
> -	typedef enum {
> -		REQ_256Bytes,
> -		REQ_128BytesNonContiguous,
> -		REQ_128BytesContiguous,
> -		REQ_NA
> -	} RequestType;
> -
>  	yuv420 = ((SourcePixelFormat == dm_420_8 || SourcePixelFormat == dm_420_10 ||
>  			SourcePixelFormat == dm_420_12) ? 1 : 0);
>  	horz_div_l = 1;
> @@ -5527,11 +5526,11 @@ void dml32_CalculateDCCConfiguration(
>  			RequestChroma = REQ_128BytesContiguous;
>  	}
>  
> -	if (RequestLuma == (enum RequestType) REQ_256Bytes) {
> +	if (RequestLuma == REQ_256Bytes) {
>  		*MaxUncompressedBlockLuma = 256;
>  		*MaxCompressedBlockLuma = 256;
>  		*IndependentBlockLuma = 0;
> -	} else if (RequestLuma == (enum RequestType) REQ_128BytesContiguous) {
> +	} else if (RequestLuma == REQ_128BytesContiguous) {
>  		*MaxUncompressedBlockLuma = 256;
>  		*MaxCompressedBlockLuma = 128;
>  		*IndependentBlockLuma = 128;
> @@ -5541,11 +5540,11 @@ void dml32_CalculateDCCConfiguration(
>  		*IndependentBlockLuma = 64;
>  	}
>  
> -	if (RequestChroma == (enum RequestType) REQ_256Bytes) {
> +	if (RequestChroma == REQ_256Bytes) {
>  		*MaxUncompressedBlockChroma = 256;
>  		*MaxCompressedBlockChroma = 256;
>  		*IndependentBlockChroma = 0;
> -	} else if (RequestChroma == (enum RequestType) REQ_128BytesContiguous) {
> +	} else if (RequestChroma == REQ_128BytesContiguous) {
>  		*MaxUncompressedBlockChroma = 256;
>  		*MaxCompressedBlockChroma = 128;
>  		*IndependentBlockChroma = 128;

