Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A989D606A31D
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pPnnW6Cb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40ACD10E15D;
	Fri, 30 Oct 2026 17:12:05 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013056.outbound.protection.outlook.com
 [40.93.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFD8710E15D
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 17:11:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUh05JdHCA9sGIMdIvSfN50L0vH9jyDh/747Ov337B4WpmoIJo5ab36RCQdNGGJkykKsSupkx9SFPmUBmVgwdSFIQQoJ641Qzf3+vPC+ihOmeEIZgBjrZA6sqitZhfUNw9woR3n/TB4hhGDIqAKYF8wgBzQ68Q3EIuSJYB4y5IqMEEYsFEWqQBtY6bfJxgNDfj+a6KYpGzKJRA7/aUI9iGMu8T+RDPdkmoEJFCs9A3C35XgRgY4KCPZg1NOPHT+ysO1NyYUnafsZM6CITXgG/ozTyRfsl1QhX2W8MyEguQPqSFwb3g4+nG8mUL1R5BCI7U47DGJk0qzxSAlaS2gXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCC9uf+EvWh4XwPJgw+wNkufKD61Lt0ODuif+BzsjYk=;
 b=hGX2k5pon+HUGu9r9/ZQGu9jWXATa4aNqFdQhjqbSI59l4t9wYxYJI41j9g4PGmB8JrWJ4F0rx7UsnkaAvUfn31cXRwyFVIBMyyOJN03Tnpwjl+FCaSLjdzZwiGqWATBz8jPQgBPnm5jbYOV7a3+TkePCxtgmbYYdbC+f/XdjXML7I6lCgBEoGExTaorOt4v3eRoqOaWEKzw+WmP1/awBeJHSfZK+bXFCwZMo+qeNh1+X03+IQwZOQmq5ns6ju1IT3/O0DD46ahF+eFT060n26ThebYZD2420tf9xIgOReyCnXMfD3bZ58mns2O6HxEkwRcuscWUbWYslj3hnMmd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCC9uf+EvWh4XwPJgw+wNkufKD61Lt0ODuif+BzsjYk=;
 b=pPnnW6CbQg2kU1X486wGLqkJqh4gN5/01z2SlvHg1n222H5DlLKgzSLtiHx6/kpgpwzKeR60R0S/Y5UC+5BqHg0oITe0iGy6RKOu9Iduzs9KxA4jqJ3pt/2TT15bzr7opxDSOyF08d+PMO/J+CuHOHJkJY91egyNqiQd9Q/93Cs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH1PPF12253E83C.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::606) by PH5PR12MB394451.namprd12.prod.outlook.com
 (2603:10b6:510:502::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:11:54 +0000
Received: from CH1PPF12253E83C.namprd12.prod.outlook.com
 ([fe80::fe06:fdca:73c7:3675]) by CH1PPF12253E83C.namprd12.prod.outlook.com
 ([fe80::fe06:fdca:73c7:3675%5]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 17:11:53 +0000
Message-ID: <3e5c31bf-fe59-46a3-8848-3e76db722109@amd.com>
Date: Fri, 30 Oct 2026 13:11:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Keep the nominal vtotal while VRR is
 inactive
To: Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, jerry.zuo@amd.com, aurabindo.pillai@amd.com
References: <20261020025157.2700490-1-matthew.schwartz@linux.dev>
Content-Language: en-US
From: Ivan Lipski <ivan.lipski@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261020025157.2700490-1-matthew.schwartz@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::14) To CH1PPF12253E83C.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::606)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PPF12253E83C:EE_|PH5PR12MB394451:EE_
X-MS-Office365-Filtering-Correlation-Id: f534cce9-8a2a-4c6b-88d1-08df36a8e494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|56012099006|261009223027099003|261026121527099003|10067099003|261022075727099003|261021123027099003|261021121427099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: C4Lsfm2DbFSKGMmdXsDqNDXVMduKWJAeWHdGVuLt7PrQAcbzOpE32sWltzQ5IEAXweOFe4w88+uNJn7n7KvcJ/Qboa0zThCcydtAGw9XU9EXRsLRMDpqy7ngTw9h6ioiC1RN1zmd5NpFD9lVxTTGRcLsqenQta5mhyunK2vvqV5/z53BoTcECxefh4vLQYATBFsSz++/0ybbD1uiLrXgesI+anUfW5LFJxXn3WgNl6qeeWxYx4nWW39kIoq3sSYOqXl3N+6D15Jnej6kJL5Dygr5cMlFBbWYcAA08Ls3gr4PP7klLKedWlfBwY3xdNbcxEzN9jBCINk1Z868rQNOZt08PWmhR5T5obwAV1IGYbd9nj1Ys5YCkTe5Gf9otCVMQt8ZvxeFyhHVIVw4+kToUvvndNDxI1zX+OnlVjqqqJlXBfwA6I4mQZjPmLMpTn0/SepVKDoU9xdktYzqhTNSTn18WejUhCwVOM7uc7uvej1u8sTHL4VhdIGl9/XEvBd5U0RQOudzmEwO1K9C3gYXH2XylaBNZ3av+rvkpRwFG3vrMCHAo8Uc0R5vVmR7h25lPioLDVDnnLCsKfSA/1QFvqZc5anli8SBuNjryaaadxs9R0kaPwvW1WrdY7zZJ6ASUMbivTmAtTRZEihZXDhrSEhJ81sipLgOl4FCTAjOVm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH1PPF12253E83C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(261009223027099003)(261026121527099003)(10067099003)(261022075727099003)(261021123027099003)(261021121427099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzViT29iUXQzREZuZnFPUnROQ3hYYjBzSWVmV3JCMVFsKzkrbUk0djhHL2lM?=
 =?utf-8?B?UFhCUExTZ295WFMxL1ozaHpMTjNsZUxEeHpCdjEwbTJTNm83bUZmQVRpeUEw?=
 =?utf-8?B?LzNoYTAyNUpYR3dVY1RPRDhpU3h6WG1aUnV0VWNBZHJ5eDR1a3N0YlRaem1O?=
 =?utf-8?B?aW9mS3Y2YTBkakZUWUpNcFdPVHNPSHBtOWUvUDhHUWJWQmdpQzYvWXpaUktH?=
 =?utf-8?B?enF1dmpnOXgvaHk5NjU2empDM1IwY3pNRThLcnhpL2s0YXhLNUNPcnVKdkRH?=
 =?utf-8?B?emZ6UXprbk9uK1N1Z3VLNFNZK1ljVFdFRU1Ga3l5bkYza2FsenFGUGNDQWJD?=
 =?utf-8?B?dTU1aEUrakVWOEhVZmRLRlFNWklmNGpUcUNidUVPdXFRWWdMN0dOMUlpU01H?=
 =?utf-8?B?YUpIbFBoby9oODNzRTdjTlVKT21MbHRCZHBCU2xEdnJlS0VSYnJlMHVBZGw4?=
 =?utf-8?B?Q2Mybm1rbUlSVU9LQXBLV1Q2YjMvNzhkSjBTZGVOY0ZuRUZxUHN6M2FuMlR6?=
 =?utf-8?B?WGhpWkVwcm53RjRIdktQd2JyeHJvamVHSDBRZ3RmcHUvVXBjSThVVzBuTnBr?=
 =?utf-8?B?Ym9OdTNQalpmWHl5QmovYVpaODNWblJET1VYMUF0MjdrYnRQR1k4VWUyT2Ji?=
 =?utf-8?B?SVQ0c2l1ZTZITkVJSy9BR2U4Njc5bmtpb2NLS3BUN2F3TzFOVXJyMkdmYlFk?=
 =?utf-8?B?OUtFRXFzL2hqRmJrVU5sSExJSVovQ3IyZHZVVDBDMmx6dHdrQ0srRWUzTXcx?=
 =?utf-8?B?dTg3RDNrejBDYkVxaG9MdDkxUkxMRzFWY0VWV1A1L1V1QU9Ia1JSR2JHSFFI?=
 =?utf-8?B?by84MzNHeVhWZFVxS3dpRi8yZEJaVmlVRlArRTY4T2dhV2pzRERKSWR1S2Fp?=
 =?utf-8?B?dXlFak9BS1RDNldTck9sT0NTOE5TcEkreWdEVHU1TFo1TjBpaVhMQm5zdU5x?=
 =?utf-8?B?R29xMWROaW9OalFiSEp3VjZuZTR6S0hwUkVQSWRQSXB5dHVDaTJHVlgrUkNs?=
 =?utf-8?B?LzFLTmFlWlpKSDAwZ3dxNE4rSHltUzduc0hDQmhWVG1RZ0J1WHhjWnNnYUhX?=
 =?utf-8?B?b3NKYk5yTElJR1dyY2tTaTZadUZCbldVYlQ1WGc4NFdEelhMSFNFSktzZmE2?=
 =?utf-8?B?d0ltaGJsYW1Wa2srVmRNVFVBTmJrcS8zZjJhTUpNS1ZHbnprdURSOW93RDA0?=
 =?utf-8?B?S2xKNUU5RlU1Z2JEbkNnbmg0NXNUa1ZxOEhhbFp5VStHUVRiQ3NRNEpRRXFz?=
 =?utf-8?B?NmNnZitGZXRTYXg4SCtNaERaTlJ3Wkhjc3dpbVYvQnVvOWQ1Z3VlR0ZOUlZP?=
 =?utf-8?B?RWRTTlIyOHd4ZVNxY1l4N2M2eGRzbGFRbnN4SEZLUlZzTG1VOFpscGgxM01h?=
 =?utf-8?B?TzQ0eTl3UzdvSnRiTXdOTFJSZUU2ZmdCbnlyRkF0REs0NXJMOUtuajJvV2N0?=
 =?utf-8?B?Z1NzUSs4MVRDZytXNXpCR2c3V0FoUXFuZmxDMzVwTGNhdDJ4blFRcHRIODg0?=
 =?utf-8?B?bjEwVW1DbkMyajFIaUFKSnNNaU1Pb1RvVExFTCtqdGlCSWNMWHFFdzVZNWo1?=
 =?utf-8?B?NDN6QTNURmlLemx6RTdyNG5uR25CS1ptcUVMaEYxbkQ5bEo0Z21UUmZjZWxp?=
 =?utf-8?B?Z1c2VDlkaVczV1RCNFFtZCt4WXFVM3J1K2xQV1FkMmh3TzdnRGdYUFgyNjVJ?=
 =?utf-8?B?Q0tNelpNSWhlU3NTb1pOdVhPK1FSNjU0ZjhHb0tIekoxL1kyZGtCbERqbkk2?=
 =?utf-8?B?aVl3TUFtNWtXemowRVRuMHQzeDBsZVZrbE5LYnM3ZnlFYldvdUNaTmJNdTdX?=
 =?utf-8?B?VlhXZUU5WDQyNVBXNzV5UHpIUjZaazBkcFFQRitWU2tHdGZpTGVQWmNpbWxG?=
 =?utf-8?B?VkZJSGRZbTBNQWZlZXZ4c2F4NkVNaUVtMlhYUDJocDIzMENqalQ3bFRXWnBM?=
 =?utf-8?B?TzhSSGhWSnUzM1dVSmtiWjh6WEsxRGdESjhLcGNkUXVMQWxJTnQ0VFRQd2ll?=
 =?utf-8?B?dGRIbEhaQm5SQTljQndpa3A0MEF2WjZlVG9va1pKK2NweElYWkhMUG8rRnVV?=
 =?utf-8?B?YXcwM21xRXBzRWFJMVdhSndLU241Z2NKcUoxQmt3K1BrVHZjOXpBdWhoWVRG?=
 =?utf-8?B?M056MHNObVpsNHNXK09tUjBJQmxwVFFEVlV6Smg2TzdFOGxFN0lZcUQ0dnhR?=
 =?utf-8?B?UGJSQjhuVm1LcVQ1eE1seWlxd0FhNGxPSG5wdDVPM2hiS2dhaUJORXJTUU9w?=
 =?utf-8?B?U1JlUHJsc2dLT1FZWER2N3AwdDJjM2w4RUxoQUFQNkc0OGU4cHFzM2FIdmhl?=
 =?utf-8?B?OHNwQnJVVEZCYnlPVlB5L3JNMTc0T1U0bCtxNE1MRVZqZHcxVE4wUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f534cce9-8a2a-4c6b-88d1-08df36a8e494
X-MS-Exchange-CrossTenant-AuthSource: CH1PPF12253E83C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 17:11:53.6447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfWmhtyFE50ber/6R9+btul0POG1zQSUiI+CR4UFYR/+ZiXQu0assv/xoN03BgOHyc96RGCyNOrAXs3z4vjBcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR12MB394451
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/19/26 22:51, Matthew Schwartz wrote:
> Commit 33c995709121 ("drm/amd/display: Allow VRR params change if
> unsynced with the stream") derives the inactive vtotal from
> max_refresh_in_uhz and rounds it up. The round trip through integer
> rates can add a line even with VRR off. The ASUS ROG Xbox Ally X20's
> 120.0004 Hz mode exceeds its 120 Hz EDID maximum, so 1152 lines
> become 1153 and the CRTC vblank counter measures 119.89 Hz.
> 
> Take both limits from stream->timing.v_total, as
> mod_freesync_build_vrr_params() does, which keeps the resync to the
> stream's timing. Active VRR keeps the helper's rounding.
> 
> Fixes: 33c995709121 ("drm/amd/display: Allow VRR params change if unsynced with the stream")

Reviewed-by: Ivan Lipski <ivan.lipski@amd.com>
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
>   drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> index 4bd060e30799..f154a619b533 100644
> --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> @@ -1281,10 +1281,8 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
>   	 * If VRR is inactive, set vtotal min and max to nominal vtotal
>   	 */
>   	 if (in_out_vrr->state == VRR_STATE_INACTIVE) {
> -		in_out_vrr->adjust.v_total_min =
> -			mod_freesync_calc_v_total_from_refresh(stream,
> -				in_out_vrr->max_refresh_in_uhz);
> -		in_out_vrr->adjust.v_total_max = in_out_vrr->adjust.v_total_min;
> +		in_out_vrr->adjust.v_total_min = stream->timing.v_total;
> +		in_out_vrr->adjust.v_total_max = stream->timing.v_total;
>   		return;
>   	}
>   }

-- 
Thanks,
Ivan Lipski

