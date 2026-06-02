Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D62CD6E57
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 19:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2093310F54C;
	Tue,  2 Jun 2026 19:45:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uYgbExXc";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D68410F54C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 19:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmvF5JKBAvaXYUtxgwc/4Oa+u0RpF6IpNPY5xxMkoQtIbvbJR4TD5WoRGCXd0V4mB5Jqz8ki/u/AVE1KZKenJK2WN6HQkkuEZFFxI18sq+Saih+HP8T312OFmX+HH8VFnDXyG34ffFgMk5egqunod2dZCq0GI+uzfREHlA3lZWzjOJolF86bhPXbPpR/B40D7ACA8IOWzx3c6djL5CpmWndywHI/LMuBxWMVVdVruQ24/CIbwWF+CPFz0WuuSexh8XIqgRPzBM9rxIaKhIRSkPn7r6wbgPEC3xJPK1BZ070x7E0euKAn5HrkQb3/zqdwMi3sD41ER3HKL9kMOU6nQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BF4Xgo9v6tU5/N83ketlY1ls8ul3KCC/V2O+6VQ2K6w=;
 b=dbMYUUhPN8+ve3V6ajOgpXEJkoI+OmrTQhhTbt5VtA8y3rsK1TNYRw5cnp/m47W4KYe2tsmSzEdX/ngmwKZjiwqpTurue+LI/gKhvJG7xT115YmUtyyjqIgp+j2nCxhCJ5geqtRJ8/JOKNGOhb5HNwJN+P3ei/7UDR3EbNnj5qRn06lU7Uzxef47AXD4nYETwLmnWtin5KEZFLJbmHHiX5z8UGmt4I3tJQFmnyoxvqqNyVgH4rqfCmEuXceyaeqsH0lQ4DLwV/CJglOqVF9t/RdnW1bcdbl3fFgI5kb6nze6c8iAMLT2yjzTWTunqdvRf2KZu8nde1qIyFdW0r5S5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF4Xgo9v6tU5/N83ketlY1ls8ul3KCC/V2O+6VQ2K6w=;
 b=uYgbExXc8PwWkXBaGXbIHvcqgrlDJT8g56hcoWPQAtsuwv990ukbr0FvMgjyXp/a+sMXQWh57WyxSQUiCOYfSuqxqX3QuVaB+IEfHyCGYoLz8bO4f9f5ZVeBZrh1LJp8yo9bF1PYaWVCg20mo1vasY0WetyS5zHVfT99X6ibJJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Tue, 2 Jun 2026
 19:45:22 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 19:45:22 +0000
Message-ID: <73c16516-bc16-47f1-8178-f1dea30f1434@amd.com>
Date: Tue, 2 Jun 2026 13:45:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd/display: widen
 dc_hdmi_frl_flags.force_frl_rate to unsigned int
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, harry.wentland@amd.com,
 sunpeng.li@amd.com, alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260602192152.4173277-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260602192152.4173277-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0128.namprd04.prod.outlook.com
 (2603:10b6:303:84::13) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 90940a2d-25f0-414f-58c8-08dec0df7ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: TgNiFKvmgLKAUuhXd2xKASTQAvOAa7NofJjUPKValW6T0+f/vECH7hMa2svRXtBuYTOjxWuK+PIRrhNq0KDh9kz9Q8XSRsNMoDplGRUVCbaTNYtjT6DbBCzJz0Lr4i2fMD5zlgquXg699NCsZcbz0kd0KZP5fIXqJFXp+7Ha9GbzUiRDSf1P818OOFAW5ofEa+OU9IXbPVMWh0IGu3sznP904odZTxZPXIfQJKrVpxBdKf4Y3kjdnyOq2vOahewU2avJJgcfdxInc/vW9blnDWG5oNxdFUhoZSVyUlf+sNKcl6zmK6inJu/mAcJyM/+HEO8kCG4qwXHSZYKKLZ27X1lUUS0nBf90tUav2cDmeWI5BGEIM1WnH7AvdyGT38WVRKCDOIBL9+IkYPG8HWFgr4O2eIDnyKdb7vFHxeFX1Hp5KP9s9JYbuQgJiGLGg+xR630XBZDVaAvOtOjNScyhj5qFGlRvt4EqdE/qLzOv+7C+lvZHEjgYduaySI8nI7W+ve8f2rcbgmv3pfB6eyImWUbyk990GlJvN3CQNWZlF47xxcCftqgZ4oU6z3vCrfo+xuf6lwkaWZJ+ms0WeS6WAOgcIPP5TMcopIsdh8a51ytKCFfFb3PyaikCOJahxz4geH1RRGUe2Q2y1j1fAnrX94BfNYjYBX90H2cDP72TSOBM7of/pSOQt1fh03bUcs3W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um4rS2l0TlZoR21nb1k1bHF2elFUWS8wclpySjZucEtYbjZiYjU1VHhiUUlt?=
 =?utf-8?B?VG45OEVtRTM1cXM5TGdRNHZJdjhtMkxIVDZMWFd2MlF5Mk5hWmpqUGVrN0VD?=
 =?utf-8?B?cUJkMTVSbjhPWkpkb1JPQUwrdFlOSktZbGxUWWxtL0NaSXE2c3AvNTN2dzZD?=
 =?utf-8?B?TnYzT1l6aFlOTDZ5VjlLVTlLV2VBQkE1aVNCTVJYaGg1L09oY3RQOTdwbkVE?=
 =?utf-8?B?U0ZjMndweTJSeC9zQXp5RFc4N2VsV2FoQzNTZWIrVlJZelBZZ0NSTzhRT3Fy?=
 =?utf-8?B?bDZUbXhPUEZqUTdUNlBvem91MjJSZDIxVVMyOURPaVFnY2RpMDYvaHBiYnFP?=
 =?utf-8?B?dEI0V3hWVTRqWEJTNjV2Y3EvM3lYeHB0dEdjd0xiV1RLbW9tcEd6N3lRakVT?=
 =?utf-8?B?MHpuM05WUlV5R29vQ3ZILzljNTB1OVd2NG1tVnY1ZmEvVURCMHZFSWdISno5?=
 =?utf-8?B?eGVNcWhJa3JsQ2V0a0tXYVliUG5xbHVZeW52TUhYNDVXamRweXcwS0dCc3ds?=
 =?utf-8?B?dGF1bG51dU0zN1JGSTFNYlVTYjhPYmltUkQ0UHhjTEpzTGZudWpkb3N5VFpo?=
 =?utf-8?B?Qmg2NGxCNXJKZ3hsR3VPcEl5OGlzRmtxU2hwMGRpcmVkUmltNG1KdXNiR1pE?=
 =?utf-8?B?V0FKWGwyZTF0eWFGeCt2Ym04bGFYbWZwekVPRFVpUERkNTRDUng3QSs0Yzdv?=
 =?utf-8?B?Wm9ING9zbG5EL3k1aEVFMkJHWkswR2d6RHhKaVYxdmV5V3AxMDBHYkUzYzZG?=
 =?utf-8?B?RWFNdWZYeVQzREpSUk1weVY1ZGNEdTJsazYwZHJDRkhGNVhxNmVqQmFTNGZl?=
 =?utf-8?B?UStpUzhBZXFmdDVzZ214cVdNbVZtRElZendGYjBGdGxYeDBaVFlMcHlxVnB3?=
 =?utf-8?B?Ui80Q2lxalZ2WXJKNDB2YWw4R0puc25FWWxQQ1VjTzF6U1RTY0c0aERnRnNo?=
 =?utf-8?B?eHJmNThUY3lqU29NS0x1bVA5N1ZveFROU3hsc1BobnVOazd5V0lvTWIzVit5?=
 =?utf-8?B?ODdPZU9mVU9wZ3hXenBUMmx4MFcxWTM3VVRJb25VeThib3BDR25XMU1abFpZ?=
 =?utf-8?B?djEvNnoxZUhsUnYzWUhOSzl5Wk83M0h6cFFPeU1adGM4clEwZEV6OW1ENmRo?=
 =?utf-8?B?OVRBWnd5SmtNcGQ3SUFTblFiamdYSHRNM0ZoaVI0dzlacWdpY3lqRmRMbS9o?=
 =?utf-8?B?dFFaZUtVWFg3Q0JQeDVFRjhVMlZEN0xtK0F6ZXpCa0xMUElOU2J0dFRpby96?=
 =?utf-8?B?ZjRPbnF2VHR0bVFMT09XR2VEd1NNcWlBTWl0elJIVUMxMXRqQlVVNzhUbjFa?=
 =?utf-8?B?V1RLWTJObDFRb3BzMjJiaytIRm5lb1hwZWEyb3Z5aXZmWkU4d3VKdFlWV25n?=
 =?utf-8?B?OWZWT3VlUGNhdGxyWk9HQ1Vob0pnYlQreTFiNFYwaDYvU1o4ODNoa1VQMFZX?=
 =?utf-8?B?N2ZnRXJhUEJ1ZGdUR2FWMEQ0Vm9pRFYvSEdyUVVkdWJIOVMwWXk0Smk1U0tX?=
 =?utf-8?B?NXFFZXBNRGJCZlF0ME13Ukk3OVQvbCswNDBkUHFxSDlPV0U2RHNoZGlNM24v?=
 =?utf-8?B?T0txYVc3OGdPNlFaYk5ZcFdnQ3JGMWV3T1Uza0FyVGxBUmlkQ0JQOVBEb3VS?=
 =?utf-8?B?WXJqQ3V4Tis2bzhxUzZXYUlIbndCa2lJeE9MaXBZM04vVGxwdVJTSXlSazBr?=
 =?utf-8?B?UlFacE0vU2VtUnpybm02dGFhRXptT3Q3TXlYd0NVOGE2SGdoUmQwQ1lISjJX?=
 =?utf-8?B?d09Md0RITnFjK2Y0clJ1R0FXOHJRaWNGOVVsdmVpSXlzWHlpQ0FtYnczcCtm?=
 =?utf-8?B?Q3JoQ0l4djR2VVpuZytJekc0eU5yOERuMTBLY1F0SktUSnhYQnR6SmozQkFq?=
 =?utf-8?B?R29id0ROanorbXlmUEM5R0swWDB6U0Zsd2FlSUVidDhmL2JCRDZxMDRFKzBa?=
 =?utf-8?B?WVFLSWUrVmpuM2hramhDbTZMbWJuM1RHL0pjZGxLMnlTNHhiaUl0Ukpqd0hj?=
 =?utf-8?B?ZTNZdXptQWZMQzk3MHowTTVxTnVMTUJYUm85R2s4WnZpLzJNTUtlM29TdDJS?=
 =?utf-8?B?OVNrNWJqazFMZkdnVFpNV0VOQUYvQXFOZlAzVFFYUC9SeExrcjZpTWdNeHZ3?=
 =?utf-8?B?VmhOSXJwRXUraG1hYlUxcEE1N20yVmpyR0cxcWpCTjMvSm9ubUJpWFVBYk5J?=
 =?utf-8?B?RTZvUDZVamNBa0tFTXg0VHFabC9MaS9lWU9sYkpzUXpoVExoZVY0SEV0N3NZ?=
 =?utf-8?B?S2x1TVRtQ3d5RUJPQllIUlRUaDhBcURoRElPMHlHcWRnakxWeVRCRXBkd3ZB?=
 =?utf-8?Q?5z7GKlOZpJnQbHTrdj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90940a2d-25f0-414f-58c8-08dec0df7ba3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 19:45:21.9456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMYRQVZLx3swOqdpbupdemnaMIgIUnULAUlc3nrsVvebZ0rY+4PYbBPWKLPh6v72Fp4Gu7kNTflx4SsoQgIeag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 6/2/26 13:21, Aurabindo Pillai wrote:
> dc_hdmi_frl_flags.force_frl_rate mirrors dc_debug_options.force_frl_rate,
> which was just widened to unsigned int. Match the type here too so the
> assignment in link_hdmi_frl.c does not narrow from unsigned to signed.
> 
> All call sites in link_hdmi_frl.c only compare the value against 0, 0xF,
> or an hdmi_frl_link_rate enum whose values are non-negative, so the
> change is behaviour-preserving and does not introduce sign-compare
> warnings.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
> index 0da03eb794aa..eb6e7f4043fd 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
> @@ -266,7 +266,7 @@ struct dc_hdmi_frl_link_settings {
>   };
>   
>   struct dc_hdmi_frl_flags {
> -	int  force_frl_rate;
> +	unsigned int force_frl_rate;
>   	bool ignore_ffe;
>   	int  select_ffe;
>   	int  limit_ffe;

