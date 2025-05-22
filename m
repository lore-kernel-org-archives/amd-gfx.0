Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3AAC54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 15:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD6A110E154;
	Thu, 22 May 2025 15:20:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pLfATgYw";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E49310E154
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 15:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4xlUq57W//V4vK6/6zlru4QigSoq3N/MzzKPWbtels9p1E9RaAkG35pzoYQUqLLlK9EZrH7O0t9w6J9iS7GTSzKSVtOU27dxlEpFTO8ohYqXpa3ayiVRwndiHl3fyhC2Ss+2AasEEMP9qMVWGT3b0km8QB6xc477rgvCSgtSP29ZgiqMLpFoBhdKdKKBRkc49A/HBwMNZiJtppDZWlbpft/oyOk3NyQlsy69aFJ7x54vx4re3LtSoBl7TkQhIGgsDgNwxdqiaMGwQEZJhutKr77V++UBImFx01/m+LHXKNUwhQqTOtIXEykmU86Njbn/CN4AaCpbvzj47f+NiN4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A05HEI2v+WCB/QCReZvrgccZ9366CZaVRsnD+nSPe4I=;
 b=nTIhKiQJxnwVV6Pg0T8wsQNqRviBU8d66N038czxMPt9DMMqUGmjw8JRLQ+7PpZDw5l4SKaF0NP44P4XeS2zbMmDz2aXODEtBLa7KawrzvASO76MtqDNRHWP+CUa+SOy0ElqjqYwK+ZV1sZ+tSIDYVbZ2qyOrMXbNJQCaNQvb/Q9oVWO9XQzy8+sI47OM/HYMw0UnoM2WoL0I0O6ADdZNtUl/EEhKFSbOZoD3lEvloD4VSmAvMMEfkT9Rv1erdh1Pi3kyIQJhh2Jteflj/Q3j5f73OgU5ogLeoDYXTkQCRQai+lRuaTOJCuUDyzEo6r+TZ527s2PWOUR1qgNE1oxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A05HEI2v+WCB/QCReZvrgccZ9366CZaVRsnD+nSPe4I=;
 b=pLfATgYw1AJ/oGZjvWgzKdSPn0s3aFVWJz9+dYEUL41Su+zAMvhR9qXbhY8Yl052NxfLRkD9BGBzTxh5SyhuNkjSW0608wvzU3P/tYFxF/SM4qcmS3GKRagAciYovwz8O0EgdT+TS8T3DVdYtarjTy0YPAMBSnJhFQtO7ekIovs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5300.namprd12.prod.outlook.com (2603:10b6:610:d7::22)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 15:20:06 +0000
Received: from CH0PR12MB5300.namprd12.prod.outlook.com
 ([fe80::5313:a4b0:89d7:7b76]) by CH0PR12MB5300.namprd12.prod.outlook.com
 ([fe80::5313:a4b0:89d7:7b76%7]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 15:20:06 +0000
Message-ID: <496f10ad-6a27-4048-9466-47c3ae97532c@amd.com>
Date: Thu, 22 May 2025 11:20:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add some missing register headers for
 DCN401
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, alex.hung@amd.com, alexander.deucher@amd.com
References: <20250521200144.74369-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20250521200144.74369-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::11) To CH0PR12MB5300.namprd12.prod.outlook.com
 (2603:10b6:610:d7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5300:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 5731182c-5a32-465a-93df-08dd994421df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUZEaThQL1hXVFR5NStFTDRzUVEyelUwUTlRdXRPMHpES2JFVW5qV3ovVytJ?=
 =?utf-8?B?dUtMNHAyZFpoOUNzM3VTbDBFTE85Skk0aGdOVDRxVXZEb2s3KytqOEJhMm1N?=
 =?utf-8?B?MTAxTVhDVVNTSVNWYVJldTZSMUpnVkZ5UmsvTEwvSDVubCt3a1lRQlBJWlRi?=
 =?utf-8?B?ZEpiQVhKbUVXSTFqSU5uR0hSV1k3WEtLc3dIQWxPUTlkMDlVY1MrNFkzcjk2?=
 =?utf-8?B?OFkyMmhPTVdkaFh3SDlsWVpZdi9ubjgrNTBWSEp5NFVRNmxyWmNKaHZYNTh4?=
 =?utf-8?B?Y1RUU0l0WHFtUEpIRlovU2ZBWVpCTUM2SlF0TnVsbm56M2I4QXMwQmlxa1cz?=
 =?utf-8?B?a0dmWk1Wa29UZEF2MUVGbVNlSDFHaWp0aVBCZlFzRWZwd0lnRmJVRDBSTHc2?=
 =?utf-8?B?V3NmK3FPdlJXL3lRUnorWU5wUlpWM0RUZ0VRQXBNVXNKMTRVeDBHb3BqSWxi?=
 =?utf-8?B?Qm04eUF4bDlJLzFqRWJnSTM1bmJreEZ4djhwamczQUloWmFlNHdNeEdhY1NQ?=
 =?utf-8?B?THF5dzg2QWN5N3pxUUliU0tURS8xd0NoMXFQNzdXeHpnaU92WE04b3QwVUlT?=
 =?utf-8?B?NWgvUmhua3ZvMGY4TXdYcHh1aW44a3VWeml2cFltYVNHVDI2YWVXeG5mNkFz?=
 =?utf-8?B?MjJxWW1VQ013SjEvdzZHbTNmTHRnWmJrS1FGdU4vRDRRdyt6cnIwUzNxRndp?=
 =?utf-8?B?ME5RS25vclVPTEhnZVRWWlV5REN4U2pUSnkweXkzc3l2TndSODZKc2dQTFZq?=
 =?utf-8?B?aU1TUi84cDRTbllmZFFtS2dDYmFIWThoQ2x5UUlvRGlNcnhJdk5TKy92M3c5?=
 =?utf-8?B?MTV2NVJxc3lFcEt1bzZhQ1VFbmtrd0pFNjViU25DNThJbnpNdEQ1MFlDVm1U?=
 =?utf-8?B?VGEycWxLU1BWS2d4Ui9KeFB4L2duaGk4SjFyWDdvYjNiVlkzSGlBUUpDbGM3?=
 =?utf-8?B?TXBXSlJ4T0NjSWVPQUxtK1hINGk0bjV1dFpXQjU5OW90aGd0b1FXQXZxSFVm?=
 =?utf-8?B?UUM4bGp3WFFKYVUvMVhxUWxnU2s5bG9EQzlhaFhwSTJ1cng2RUZWeVM5RUFB?=
 =?utf-8?B?UVoyeDJvOVVIZ2UveGJwNHRqbm1DMENlb01na3o3WmU5cllxM0xhc1NNYmwx?=
 =?utf-8?B?dHdRTVpZWGxVZEFNS0xJbitMTjFYVUFXd2hqOHNCMGxlRWgrdlZkN1VWM0FT?=
 =?utf-8?B?a04ybkxYdWdrWXZuNmUrMytpN3hUQklma0VMNlNueG5LT2NIRE1LUVNBUVI5?=
 =?utf-8?B?ckdkb3JOY0txZW9vaXNvWFR6V01iS3pxQzhydGFlU3Y1eXNxblZ6Tm81UVZt?=
 =?utf-8?B?WVA1M0d3TDYvY0Nub1phWU5KVk5QNGx0YUxIcmdXUml6WHZSOEtMaXBUamUy?=
 =?utf-8?B?TzhiQWRhZnpqUVdnVGU5QUVvbDY1SXcxTFV5aVNFekd3L3FxaDlnQmZka0Jx?=
 =?utf-8?B?OEJqMVF1bS8xSHJKVFRMQVg1YlBtQXlaYzlLNGlCNlgxUGt4NGFBMVAwMVN6?=
 =?utf-8?B?aDE4UVcyRWRXYm5EditzY3dRWjhtTmF6aklKVlpIN3cycHpENkZlYllKQzFv?=
 =?utf-8?B?SndoZWo0Zkg4TzFUK0sxQTZvN3d2NUJBMWNBM1ZOODdoeCtWcWdhT0pubmtX?=
 =?utf-8?B?aEZ2aTFuQWRkVmliOE5Hek51T0FwdlQzUzdEdjJqYjN3c0cyNG9nU0dTYWNN?=
 =?utf-8?B?MEM2T2dIalZkemFJbDdXTjJKTVVpUVduWlQ3dDVaaVhIdWt6Zlh2clUwZE5j?=
 =?utf-8?B?MXo2UW4yOGEvUWFaSnR4VEx3YTBMTlBOR2pZTEpPaUdkaWZZaDE5bm5ZZUZV?=
 =?utf-8?B?NU1vcEFNcG8yK25CektPWFl6Tm5NZFVqYU9HbWs0ZWxWS0hnR0kvTkFZell4?=
 =?utf-8?B?dGx1UlhBWlRFVWt2d0pTZm5reEhWZlp1WGZmNUY5K0N3TDBFSmxTUFBLOUM2?=
 =?utf-8?Q?kFxj3iI0TDU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5300.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzNxbGpXZ1NMek1tSW5VTnFUdjBGa1RyN21SMUlGRUpFRkpMcFBBSUl6bDVU?=
 =?utf-8?B?Q0Z1dWU5ZWFIYWlHTWRVc0JhUTQ2SzR0TDZKK3d5VEsxd2hNTzBiNSt3RGtZ?=
 =?utf-8?B?aUxXZm5Sa1IxeityTy8xT1JrZys5a0lOTjRVeWNUZzNqTE1SZzlMTzM2MVVv?=
 =?utf-8?B?K2xhRTJJOEp2eEhsSWVoMlpGaWdaR2swdmMrNEwvd2JLMHJYUTh4MytLYlhu?=
 =?utf-8?B?aGJOZ055WkpzWkFaSXU3dWRUWXA1Qi9TVUl6TkhHamFrc2VmQkhidjNkdW55?=
 =?utf-8?B?bElyemp2TW1oU21XeEwyQ0xEK2FJYUVaTEtWSi9UQ2svMTh1Y09NelNQYTlh?=
 =?utf-8?B?L1h2VWhNRHlLVFVZc0hpUGZZdnpza1dReTYwblVDcVNGVXNDaUkyeGNuWU4r?=
 =?utf-8?B?aVdiUGVoVUlLa0hVcU5odjFWdEtoVU1TZytWeEh6NE4zR1huNnB5Q3RiRU9S?=
 =?utf-8?B?RStmeVUwOGpzYW1BN0tBMjUyajlEZEthcG1hSmVrUjdYNkVLSzYxWWhjZkVm?=
 =?utf-8?B?bWVEeStEV2JLMlM5elYwd1F4ZytjaXlxMDZ2Ri9BeUFNMnFjUGRIZFFQWEQw?=
 =?utf-8?B?T3Z4WlBGSlYxVXcwelBCZWZwdEdsdnVYL25RK3NJdXVlSjJQVHlYN1hZUjNV?=
 =?utf-8?B?aHFGUVF4QmNwMU1POE5HVDZ6Q0Rnc0VVeDJNeHFySWJsOUFoME1pdVM4Tzlu?=
 =?utf-8?B?cCtha3QzVWlLWHZ6K3U3allLZjZ5VXhKQkJUQ2RXdTFDenZQS3JhWXJ2RWZq?=
 =?utf-8?B?eU1UWFhTMy9YZ3AwaW5rSlA1SlpWL2VuSXd1SEQwbUVrSVBrTzRuaUF6bEVk?=
 =?utf-8?B?MXpPeUczeTBQTzRzSTNSalNsZzVLcGY1RnlOM3ZSY1VHaUExRHhscWlIR0FP?=
 =?utf-8?B?T2hWTUFheXhhYThNOFRuNk5ZMndoeTRjaFZFT1VvVHZwcGxpQWIzK0xMdHFB?=
 =?utf-8?B?MDYybU9WeGR5Y0ZaZWp5UExDZ2NXZzRReUpyaUlYN0ZYMnluOFJJZ2RoSlBU?=
 =?utf-8?B?ais3TGp1eXhuRXJ5VWxOckpwYTRqK0swUjlkRlh0VlY1SVN3NG4wcGo4WlJ6?=
 =?utf-8?B?U0dBK2JWQ3ZyaGNPYmdoMmgzTEdQb1NpUGZGOWFXdklwc1lJSjZFTU53anMv?=
 =?utf-8?B?ODNVZ2JwWnB1Uk1QOE41YzFmY0RLelc3L014SGl3RElxQUtHUFNsY3E3cUx0?=
 =?utf-8?B?TTk0RW9uTGtyWFhEVTVjRnBCcU1JZHpHc3ZmNk5mRXZTTXljakJmK1l3aEVF?=
 =?utf-8?B?RmxOdDMzWkJVZVZSYjBwVlJVNmR4Sy9TR3BIM2F5TEFGTkVtNXNaaDVmc3U2?=
 =?utf-8?B?cVphZHVSZ3I2RVpVVmVwaHY3Tk12T1FFME15eDBzN25lTUJCRG5ObFB4L2FY?=
 =?utf-8?B?NGRoWGtVQTV3VGNMVUNrVlRTL3dtT25OWmVZUWk5TWREaGYwa3JVTVBoSVNE?=
 =?utf-8?B?UHFDb2h4UDRwSFB5L2NzcnZ5dnh5cHpUOEprNm1FREEreWZ6YnVRZTc0cmgz?=
 =?utf-8?B?eElqaHdsbVJ1OGQzRTdtRFZ1dVZTMmg0UVBmUHZLdkd3ZHRDK2hQa0g5Uldj?=
 =?utf-8?B?R2x0eWQzK1dvY3lxOUtIeTRDVk45cThodERVRktNZmZJbmI2S3hBZkpsN2FY?=
 =?utf-8?B?SkJUbzR3N1dEOWZlNEhGdGJLNEF3Wk04eG5DMGZ0Y0ljZ2UzMm1LRjM4SXNv?=
 =?utf-8?B?Ukl5YU9Mb3hLSkd3WW4wL2ZGbDluWGpOcUhYZDZmMnA2Ym9XNFBOUlJnaUJO?=
 =?utf-8?B?bUN2anJIWGFSdWdnWWFpa2dBKzhLRmw4YUs5TE8vb2RKUEd4NG5udHJFOGh1?=
 =?utf-8?B?cjlmNmg4SE92cnlqaG45dXNVeUVOYTg2alBtV3FrUmhoeEJoR3o5QldLWmNt?=
 =?utf-8?B?cStsaUQ1MU43Y0NvbGpKVmJUNWpVcGIzTi9HQUJVMmJJczhxTHVGeHR0Mm1h?=
 =?utf-8?B?czhzZitUaC9NTStqS3dNbE9vUjRYYVJGWGx4azI1cDdzdnNtdE1mT2JDVkJX?=
 =?utf-8?B?eWwxVUxNeFJQVmtnRyt2aWhOVUhYa1V6WnppZ1NQQ0NOdUE3NGtKenR6UWFv?=
 =?utf-8?B?eHFoTUE2SFM3RkFWcDgrdGdteHBqbzhlaFNXaElJM3AzNEF0QW5sL0l4bEdR?=
 =?utf-8?Q?R0AFmXBoJWqyKsCDxJfgXNV4S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5731182c-5a32-465a-93df-08dd994421df
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 15:20:06.4266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqYgqBcmzjMA8nOoSKQJUrxJ9wZaASlw9Xgs3jF04MDLJvfZxdknXDY1WppLan+w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405
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



On 2025-05-21 16:01, Aurabindo Pillai wrote:
> Add some HDCP related register headers for future use.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>

> ---
>  .../include/asic_reg/dcn/dcn_4_1_0_offset.h   | 26 +++++++++++++++++++
>  .../include/asic_reg/dcn/dcn_4_1_0_sh_mask.h  | 16 ++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h
> index 15e5a65cf492..70ee6be94a9b 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h
> @@ -9776,6 +9776,14 @@
>  #define regDIG0_DIG_BE_CNTL_BASE_IDX                                                                    2
>  #define regDIG0_DIG_BE_EN_CNTL                                                                          0x20bd
>  #define regDIG0_DIG_BE_EN_CNTL_BASE_IDX                                                                 2
> +#define regDIG0_HDCP_INT_CONTROL                                                                        0x20c0
> +#define regDIG0_HDCP_INT_CONTROL_BASE_IDX                                                               2
> +#define regDIG0_HDCP_LINK0_STATUS                                                                       0x20c1
> +#define regDIG0_HDCP_LINK0_STATUS_BASE_IDX                                                              2
> +#define regDIG0_HDCP_I2C_CONTROL_0                                                                      0x20c2
> +#define regDIG0_HDCP_I2C_CONTROL_0_BASE_IDX                                                             2
> +#define regDIG0_HDCP_I2C_CONTROL_1                                                                      0x20c3
> +#define regDIG0_HDCP_I2C_CONTROL_1_BASE_IDX                                                             2
>  #define regDIG0_TMDS_CNTL                                                                               0x20e4
>  #define regDIG0_TMDS_CNTL_BASE_IDX                                                                      2
>  #define regDIG0_TMDS_CONTROL_CHAR                                                                       0x20e5
> @@ -10081,6 +10089,12 @@
>  #define regDIG1_DIG_BE_CNTL_BASE_IDX                                                                    2
>  #define regDIG1_DIG_BE_EN_CNTL                                                                          0x21e1
>  #define regDIG1_DIG_BE_EN_CNTL_BASE_IDX                                                                 2
> +#define regDIG1_HDCP_INT_CONTROL                                                                        0x21e4
> +#define regDIG1_HDCP_INT_CONTROL_BASE_IDX                                                               2
> +#define regDIG1_HDCP_I2C_CONTROL_0                                                                      0x21e6
> +#define regDIG1_HDCP_I2C_CONTROL_0_BASE_IDX                                                             2
> +#define regDIG1_HDCP_I2C_CONTROL_1                                                                      0x21e7
> +#define regDIG1_HDCP_I2C_CONTROL_1_BASE_IDX                                                             2
>  #define regDIG1_TMDS_CNTL                                                                               0x2208
>  #define regDIG1_TMDS_CNTL_BASE_IDX                                                                      2
>  #define regDIG1_TMDS_CONTROL_CHAR                                                                       0x2209
> @@ -10386,6 +10400,12 @@
>  #define regDIG2_DIG_BE_CNTL_BASE_IDX                                                                    2
>  #define regDIG2_DIG_BE_EN_CNTL                                                                          0x2305
>  #define regDIG2_DIG_BE_EN_CNTL_BASE_IDX                                                                 2
> +#define regDIG2_HDCP_INT_CONTROL                                                                        0x2308
> +#define regDIG2_HDCP_INT_CONTROL_BASE_IDX                                                               2
> +#define regDIG2_HDCP_I2C_CONTROL_0                                                                      0x230a
> +#define regDIG2_HDCP_I2C_CONTROL_0_BASE_IDX                                                             2
> +#define regDIG2_HDCP_I2C_CONTROL_1                                                                      0x230b
> +#define regDIG2_HDCP_I2C_CONTROL_1_BASE_IDX                                                             2
>  #define regDIG2_TMDS_CNTL                                                                               0x232c
>  #define regDIG2_TMDS_CNTL_BASE_IDX                                                                      2
>  #define regDIG2_TMDS_CONTROL_CHAR                                                                       0x232d
> @@ -10691,6 +10711,12 @@
>  #define regDIG3_DIG_BE_CNTL_BASE_IDX                                                                    2
>  #define regDIG3_DIG_BE_EN_CNTL                                                                          0x2429
>  #define regDIG3_DIG_BE_EN_CNTL_BASE_IDX                                                                 2
> +#define regDIG3_HDCP_INT_CONTROL                                                                        0x242c
> +#define regDIG3_HDCP_INT_CONTROL_BASE_IDX                                                               2
> +#define regDIG3_HDCP_I2C_CONTROL_0                                                                      0x242e
> +#define regDIG3_HDCP_I2C_CONTROL_0_BASE_IDX                                                             2
> +#define regDIG3_HDCP_I2C_CONTROL_1                                                                      0x242f
> +#define regDIG3_HDCP_I2C_CONTROL_1_BASE_IDX                                                             2
>  #define regDIG3_TMDS_CNTL                                                                               0x2450
>  #define regDIG3_TMDS_CNTL_BASE_IDX                                                                      2
>  #define regDIG3_TMDS_CONTROL_CHAR                                                                       0x2451
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h
> index 5d9d5fea6e06..e3d841b2e9af 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h
> @@ -2847,6 +2847,14 @@
>  #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP0_AUTH_FAIL_INTERRUPT_DEST__SHIFT                                   0x1
>  #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP0_I2C_XFER_REQ_INTERRUPT_DEST__SHIFT                                0x2
>  #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP0_I2C_XFER_DONE_INTERRUPT_DEST__SHIFT                               0x3
> +#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP1_AUTH_SUCCESS_INTERRUPT_DEST__SHIFT                                0x4
> +#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP1_AUTH_FAIL_INTERRUPT_DEST__SHIFT                                   0x5
> +#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP1_I2C_XFER_REQ_INTERRUPT_DEST__SHIFT                                0x6
> +#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP1_I2C_XFER_DONE_INTERRUPT_DEST__SHIFT                               0x7
> +#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP2_AUTH_SUCCESS_INTERRUPT_DEST__SHIFT                                0x8
> +#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP2_AUTH_FAIL_INTERRUPT_DEST__SHIFT                                   0x9
> +#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP2_I2C_XFER_REQ_INTERRUPT_DEST__SHIFT                                0xa
> +#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP2_I2C_XFER_DONE_INTERRUPT_DEST__SHIFT                               0xb
>  #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP3_AUTH_SUCCESS_INTERRUPT_DEST__SHIFT                                0xc
>  #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP3_AUTH_FAIL_INTERRUPT_DEST__SHIFT                                   0xd
>  #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP3_I2C_XFER_REQ_INTERRUPT_DEST__SHIFT                                0xe
> @@ -2871,6 +2879,14 @@
>  #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP0_AUTH_FAIL_INTERRUPT_DEST_MASK                                     0x00000002L
>  #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP0_I2C_XFER_REQ_INTERRUPT_DEST_MASK                                  0x00000004L
>  #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP0_I2C_XFER_DONE_INTERRUPT_DEST_MASK                                 0x00000008L
> +#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP1_AUTH_SUCCESS_INTERRUPT_DEST_MASK                                  0x00000010L
> +#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP1_AUTH_FAIL_INTERRUPT_DEST_MASK                                     0x00000020L
> +#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP1_I2C_XFER_REQ_INTERRUPT_DEST_MASK                                  0x00000040L
> +#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP1_I2C_XFER_DONE_INTERRUPT_DEST_MASK                                 0x00000080L
> +#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP2_AUTH_SUCCESS_INTERRUPT_DEST_MASK                                  0x00000100L
> +#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP2_AUTH_FAIL_INTERRUPT_DEST_MASK                                     0x00000200L
> +#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP2_I2C_XFER_REQ_INTERRUPT_DEST_MASK                                  0x00000400L
> +#define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP2_I2C_XFER_DONE_INTERRUPT_DEST_MASK                                 0x00000800L
>  #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP3_AUTH_SUCCESS_INTERRUPT_DEST_MASK                                  0x00001000L
>  #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP3_AUTH_FAIL_INTERRUPT_DEST_MASK                                     0x00002000L
>  #define HDCP_INTERRUPT_DEST__DOUT_IHC_HDCP3_I2C_XFER_REQ_INTERRUPT_DEST_MASK                                  0x00004000L

