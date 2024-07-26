Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4298C3DA63
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 07:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41A7210E1C2;
	Fri, 26 Jul 2024 07:23:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aXjFpN+t";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FFF210E1C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 07:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTpy5p34vJxKy4I0WL4BMdgsrZ6TL6KkxI4zhW9tANyWkKP/lCNQnymrjlM7LBhRqVzZC0xXFg5APvaLB9Ey5+bQi3DjyNTJ09hqmDk4RNJtq6nUWgH9FGE2eTVxf3HdI6tvN6M7qaXzN/Np9lsZm5L/Q0wMaz4VTVpXikI9UJ7zoL4JWCwlXvtcd3Bu6fBVW/3Md1JbbXYOU07CSuUkYRlCFRIcD4TWPXMGGlLelwsBW5gCzSiop5cAxytWt5KpG77XcReS6RsK6h+1Ne0UoXprg/DfsXo3WsyHnvyp8BbUromC7V1ehCx/kchBEG6jAkpUf3OH7AjkU0+et9soPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2O4RgVIZQE2h+aa5mC4+X9/HSYax6T79uQwm8x/wRjw=;
 b=BcJWFyuJI3lVP2s1rg3wXyMJF+2KFElLHvQqClet9b54zcLwfMW+hM/L9dmLa2wR/1h6q2eNJoLF4jGW+4CFwWvYd+BgD2r5mRfc4Z6zp35dOaVvHHRfV2aMR4yyQ7gHamhtnzuGqq0PEsUrdBBsRNYU4rki8o0IJY+aQ35v3GTOJBvUnj7ogVqE6nPEtYnwIlEpfgNn6UTAFxMsJTZxwf8wFvYLge8uRkbhiTWZVIN6NV+cih4y81SgbQslLcmAZ34pQk+8HupAuN6zY+e/TI09HmFbaEYCQrgvvCN2KXAdw8OobzSKqPVNy7noCcwshAcvIgPQ1kfvhipJV2PyGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2O4RgVIZQE2h+aa5mC4+X9/HSYax6T79uQwm8x/wRjw=;
 b=aXjFpN+tmrtxAdn5Z5ZPZXO2Sr5EM7iJ8pN0Utt5MO5f7YeC7fCZlBILc5iCRDaaKkZxnpEbLJmp501ciihOoKkbAb62X3oyTLqktNdedoOFeTNY3uEZOpjXxoUjragoIIGmb5lz6dTd6of4XoB37ogvmE653kWtZZ71VkaiZss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 26 Jul
 2024 07:23:25 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 07:23:24 +0000
Message-ID: <87c215bf-53ff-4049-bac1-22a6c94096a2@amd.com>
Date: Fri, 26 Jul 2024 15:23:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add null check for pipe_ctx->plane_state
 in dcn20_program_pipe
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240725025409.1507764-1-srinivasan.shanmugam@amd.com>
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240725025409.1507764-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:404:42::21) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c18a77-477a-471c-00c7-08dcad43d5b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTdNVjU0TWdHS3JLaVdmQVA0akpGL0xtK0JrTFdPNGpZa2p0QnExSURyREpX?=
 =?utf-8?B?NHRCaHBRSzJBRzZkY0ZLMi9zVHFiV0NqcHRwNE40cjR3MVBoOE96eG5PRmsw?=
 =?utf-8?B?QmxyblpXVDUrMm41WWxZSVVRZzBCaGh0V0JJVUhSM0JJOGZISExHb3NDZUx4?=
 =?utf-8?B?UWl0eFY0MkFRRk5abDFVWlZZUXNGWHcvdCtJdVNFK0k1elRZdWpvSzNqRER6?=
 =?utf-8?B?V2gyUG5QYVdhWlpESjI3a0p3NHh6c3puZlRtV1YwQ2JBa0d3dERTZWtRVXVB?=
 =?utf-8?B?Skc5QVZwSC8vVkI4QzdwUGJuc2RmR1JKYzFmczk2VDltcjhCMVBMUi8ydUo2?=
 =?utf-8?B?NnYvQWdQUkFhdlFFbFlrcHBjMXpPYUFlQ0pFbGVzaEE1UTM1bUVIWDM5VFQ3?=
 =?utf-8?B?TGJBSGtFdU5tbHlTVnRaSk51cVZnVExuck9EZVU2MFhTMGwzTFRwS2dKUGJG?=
 =?utf-8?B?RHJubTNvMUE1Nm5QOFZTYi9sS1h3ZUdJOCtJamJockRLNkNEazFOSHVGQ2Y5?=
 =?utf-8?B?a3hhRjU2THBDTWpLVUJQN0gza3BuMXozUkpFTmE3UWU4T2tmZ200Qzl2QVRX?=
 =?utf-8?B?bmhuempNdFl2Z24xTzBUdW9RL0xqeHJZRXFqclZJR1BxSVVzWXN1NEZlZ2pZ?=
 =?utf-8?B?UTVwVmNkVHhMN01UV3FlNlRUNG0zelVTU1Y4SFlOVXVpM2M0a25xSzBkR0VE?=
 =?utf-8?B?dXlmQ09iNld1YUR5WWRwL3JuZzJ1NWkwVytlTHMzMEZ4MVpWRTN6M1c0cVNC?=
 =?utf-8?B?VzJJbzJaNldrSll4anJpQTMwMldlbk5oc21NdkVoN1Z5OFVWNHF1QVpBdG1Y?=
 =?utf-8?B?d3Z0RjlCcjNTMlZtYjBBTUVoTXo3UzdkNVJMRmtpQVNHbUkwaEYvMlRYaXhl?=
 =?utf-8?B?QWFlRHJLMVo4RGpFc3hHamZINWExc2VNdERicGRLQ2xmQVVDL3dMejUwSVhm?=
 =?utf-8?B?aHd3MlRubEVudFlIeUVxU2hCNit2RkFQRlBkYTByZ0VuakpUR2p3NmVidDUw?=
 =?utf-8?B?WC8wdlZmTkxsYW14Sjk0VTVWQ1preTFLU0d4aHR3TEFSekhFcFFtakVFTUY3?=
 =?utf-8?B?bzFiSTNHclVRQUJiUjF2OFJEQTRYdHMrUnN2TGtZNk94WkhBZ3JabXpIbCt3?=
 =?utf-8?B?YmN6b0RKTS92VFBjSnhtOWV4WXhVdnlaVEE1elpJRzhXWFdQd0RNYWppTTkz?=
 =?utf-8?B?OE9rRENtRFhJYXJMTG9wdWJHUlB6QU1zZlJtc2U0T0JxRVY1aVk3Y29SVktm?=
 =?utf-8?B?U3VzMlcwQjZpS1BhWlVOTEdUUHIydTRoNnZUL2FWdldYNit3eHd2eHRRRlNz?=
 =?utf-8?B?bFhQTHlrV3J1QTROREkyV1hveW1vMUMxZ2tpMm9QNzhwM2pRdVlITU9UYjdW?=
 =?utf-8?B?SVVYTXBwUVJpc2JSQW9LdU40YlUxaTF6cWNLT3d2MWJKQW1sUktvRTdIdVpz?=
 =?utf-8?B?ZE9Wa2g3UGF2anN0T3pua0F2a1NWYWl4bThCcjY0WG1leno2ZFdNakg1RTZW?=
 =?utf-8?B?eHFOZVQ5VVNpSFBKblRpMnIvYXFaWE00cG1DdW03TWp1UjkzQUJHK29tc3BW?=
 =?utf-8?B?NEwwZjRKQnhjc25KWnM4R2RCMjZHWEhZc0FoSXkvY0ZIajlDSW54WVM2dmhv?=
 =?utf-8?B?Qzg0VVZxNTdiN2xwOEVYeTlXODlrUzNseWxBTkZxTlJqR1FLVE5IbFNabkhj?=
 =?utf-8?B?MEdmdkdMK3pBcUlHR2txQkFFN0RPSHlNNjFZQ1g1V3p5MHE5WGVpem8xY1NJ?=
 =?utf-8?B?Y3pXQmhSMng4MWdkVmVKTzZtYVhMUTZ5cDB4eXhDNUx1SThhQWZxN3R5VEQr?=
 =?utf-8?B?MHpKdTZXNDJZT3dHckVVdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFV3Q0JUdDA3Vm5NU0dFdTI1bDdTMWh2OWFWRlB6VjFtUlpIem8vQjBIY21Y?=
 =?utf-8?B?SVpNUmJBZCtaNzFSK0F4SklPdmRxM2U4M2toa1BWUTNtWGlmNHlzMjFmVjJa?=
 =?utf-8?B?aStQMVpheDVvM3hzNlI3VTVyZHNTR2h0ZWdCMlhWOWtqYWxCNGJ2dDlMWWpE?=
 =?utf-8?B?c3JBR3hSeFpqTm5TR0c1am83MmJYdm1HTXhpOUhwckxGZnhJMDBVS05sN2Nk?=
 =?utf-8?B?c1lGWExYMWpGdU5BWE90Qi9Vb0xta1JobDg4Sm51Sk5mMjRNUDVEdUd1L0FZ?=
 =?utf-8?B?VktFTDY5WmpFZjhma1JPR2s5SGRyN3ExRllSVll4TnF4WFhwSkNRSmh0b3V3?=
 =?utf-8?B?Mko0UkZod0U4dTdKMzAwTEtCck03N256c1crTURmZStCazByc1pJenYvcW8w?=
 =?utf-8?B?a1NTWXh0THdPd1Avakl5bEQ5bFBMZ2NJM1dZSzc2M0plTVMyOHUvRER5RTVJ?=
 =?utf-8?B?REphR2RISXF2RHFRbStNT1ZEK1E2M3lqZXJXSEN2Y1ltWnRjNFd1QjZBT3c2?=
 =?utf-8?B?bEhka3NqT09NUnNkRnZMUmdIQzdtS2VCdENCaEZZQ1hrUmJZR2JrbzJqUWdy?=
 =?utf-8?B?ckp1alQ0RWFRYis0OWoyVElNcjhsWjVPaTY0dndwaWswcUl4WndUUng1Tjgx?=
 =?utf-8?B?dERpd1VQc05iQnpqS2NINTVxeFg3bGUwSGMrZTBQcEg0TE1aS1JpeG5ZcWhG?=
 =?utf-8?B?a0o0NDhuNmZGQUduSDk2UkRLNTFXR1V0UU50UzZWdDZtc1VJODdMcmEzRG1I?=
 =?utf-8?B?RlBBKzR4WFlBb1o3SjZRdmlvRGw5WFRBZGlyOE54K1FvbHZYcUx3Q0RlelI2?=
 =?utf-8?B?WjVqdzQ0dVZuY2UvM0xIVCtKT2s2OGppN04zNXVQVEFQOFBScWowQmxycWoz?=
 =?utf-8?B?L1VoNWJaT1c0SnVKQjUyRVlpMS9UbGNIeEc2S1JkN2lmY2dSd29QRVR5L3B1?=
 =?utf-8?B?TkhoUXBOelhiQlhFUkhyK1AyZUhKMjRGTFpoQ3BHYllTTDdaL3dFcDFXZ21h?=
 =?utf-8?B?N2lVME5sL2N3L0VMWkkvbWowL2dRUFJYV1Z5bWIwWFR6UE00ck5LVjV1ajBm?=
 =?utf-8?B?Y1k1YmRIU1ljQUtEZkF6cDlaZ1VOYit4eUdEU2lOeFhneWcrcVhjQy9EYlM1?=
 =?utf-8?B?UllIV0czd0dUSFQrd1dIaFRSY0RXSkNYc1M4K1RCcGt4c2llb0poUUZmRG8v?=
 =?utf-8?B?TDA1Y3Z3eWh0OWV3VGlvMlowY2hiOFQveHkwUzd1aHlEY1RPL3JvYTI1dWZH?=
 =?utf-8?B?QTE3QW8xcW9TSmtJbG5EdXdtNHVRL2JtRFJnVXFaUVZvUUpoWUVRcHBKUm4r?=
 =?utf-8?B?MlJ5dUNObVNSNXBmU3RxUE5RME1MaHBKN0VwNGlNWURGdEVRbEs2b3dySnBt?=
 =?utf-8?B?TEFJaTdlZ0ZQNGVXVExDVmFZbHFJNFZOaW12Ui9keE8za0hNNTlYeTFMbTN4?=
 =?utf-8?B?U2R4WlRaekVrdG0yK3J4OURqMHlDM25NSWcwdTBhTHN2S2xJdFJvaDlwbVQw?=
 =?utf-8?B?Q1BLYWFCUVV6eGU0SUZPNS9LN0hDRXFud09ocDRza3owS1I5QjVnMkF5TU02?=
 =?utf-8?B?ZG5oclJWTHJWN0xjeWZWUkV1d3p4cWp4YzZ6YVo0MHBORVRSc2FVYVdxbnQy?=
 =?utf-8?B?a3JXZURweFErT3phcmNQSEI4Q1k4d3FMN1NIc2I5bklIWGlEZlBjcnQ3Y0l1?=
 =?utf-8?B?d0Jndi9Ldng3b1dlZEF4TUVMNnBaQ1ZGUWpRelVzcE9YZTFaZE1FMTJoN2g4?=
 =?utf-8?B?MEJBNWNhM1RoSEdxclNSZ0pwZkRoVXR3UVZRbmt0ZXNwOWFDdjRNY1Q3THVP?=
 =?utf-8?B?SXlDWGd0K3pvVUdjSWx1V09kSldHY3JtUk0va2tiL1ZYS09jWnZlSGNtRlRS?=
 =?utf-8?B?Qkg0VnJpY3pkOXVUeXFEVGtGUFlFdEFleDA1UXVITE1aN2VCR0NPdllhR0U2?=
 =?utf-8?B?Rk9WTlRRYktJcTRxYjZCZnNiSTdzZEpGbE45TnNIclc3Mk0xT0g1bnB5ZkJB?=
 =?utf-8?B?blNxR216QUFSVTBxVWYwMUROcHJXL0JlSW4venFQZnFnbmRWcjFTTzJaQkEw?=
 =?utf-8?B?bmRCQUR4blBkVzhlMVUwNHl3SVBpNC85b1BEbEJpRUYyK2hIaGhWUFZUeWJw?=
 =?utf-8?Q?Mv80nAGylT10yUJdyZ4VM98SG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c18a77-477a-471c-00c7-08dcad43d5b8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 07:23:24.1770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATOoPw3F6JiqTK7W1Zdsy1aR4H6mytPAUsxkjzRGPreaGzTC3XdF1JSGcrP27Gg9O0Cm+/Pl9UCfmdc9nv7qgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 7/25/2024 10:54 AM, Srinivasan Shanmugam wrote:
> This commit addresses a null pointer dereference issue in the
> `dcn20_program_pipe` function. The issue could occur when
> `pipe_ctx->plane_state` is null.
>
> The fix adds a check to ensure `pipe_ctx->plane_state` is not null
> before accessing. This prevents a null pointer dereference.
>
> Reported by smatch:
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn20/dcn20_hwseq.c:1925 dcn20_program_pipe() error: we previously assumed 'pipe_ctx->plane_state' could be null (see line 1877)
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 30 ++++++++++++-------
>   1 file changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> index 270e337ae27b..5a6064999033 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> @@ -1922,22 +1922,29 @@ static void dcn20_program_pipe(
>   				dc->res_pool->hubbub, pipe_ctx->plane_res.hubp->inst, pipe_ctx->hubp_regs.det_size);
>   	}
>   
> -	if (pipe_ctx->update_flags.raw || pipe_ctx->plane_state->update_flags.raw || pipe_ctx->stream->update_flags.raw)
> +	if (pipe_ctx->update_flags.raw ||
> +	    (pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.raw) ||
> +	    pipe_ctx->stream->update_flags.raw)
>   		dcn20_update_dchubp_dpp(dc, pipe_ctx, context);
>   
> -	if (pipe_ctx->update_flags.bits.enable
> -			|| pipe_ctx->plane_state->update_flags.bits.hdr_mult)
> +	if (pipe_ctx->update_flags.bits.enable ||
> +	    (pipe_ctx->plane_state && pipe_ctx->plane_state->update_flags.bits.hdr_mult))
>   		hws->funcs.set_hdr_multiplier(pipe_ctx);
>   
>   	if (hws->funcs.populate_mcm_luts) {
> -		hws->funcs.populate_mcm_luts(dc, pipe_ctx, pipe_ctx->plane_state->mcm_luts,
> -				pipe_ctx->plane_state->lut_bank_a);
> -		pipe_ctx->plane_state->lut_bank_a = !pipe_ctx->plane_state->lut_bank_a;
> +		if (pipe_ctx->plane_state) {
> +			hws->funcs.populate_mcm_luts(dc, pipe_ctx, pipe_ctx->plane_state->mcm_luts,
> +						     pipe_ctx->plane_state->lut_bank_a);
> +			pipe_ctx->plane_state->lut_bank_a = !pipe_ctx->plane_state->lut_bank_a;
> +		}
>   	}
>   	if (pipe_ctx->update_flags.bits.enable ||
> -	    pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change ||
> -	    pipe_ctx->plane_state->update_flags.bits.gamma_change ||
> -	    pipe_ctx->plane_state->update_flags.bits.lut_3d)
> +	    (pipe_ctx->plane_state &&
> +	     pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change) ||
> +	    (pipe_ctx->plane_state &&
> +	     pipe_ctx->plane_state->update_flags.bits.gamma_change) ||
> +	    (pipe_ctx->plane_state &&
> +	     pipe_ctx->plane_state->update_flags.bits.lut_3d))
>   		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
>   
>   	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
> @@ -1947,7 +1954,8 @@ static void dcn20_program_pipe(
>   	if (pipe_ctx->update_flags.bits.enable ||
>   			pipe_ctx->update_flags.bits.plane_changed ||
>   			pipe_ctx->stream->update_flags.bits.out_tf ||
> -			pipe_ctx->plane_state->update_flags.bits.output_tf_change)
> +			(pipe_ctx->plane_state &&
> +			 pipe_ctx->plane_state->update_flags.bits.output_tf_change))
>   		hws->funcs.set_output_transfer_func(dc, pipe_ctx, pipe_ctx->stream);
>   
>   	/* If the pipe has been enabled or has a different opp, we
> @@ -1971,7 +1979,7 @@ static void dcn20_program_pipe(
>   	}
>   
>   	/* Set ABM pipe after other pipe configurations done */
> -	if (pipe_ctx->plane_state->visible) {
> +	if ((pipe_ctx->plane_state && pipe_ctx->plane_state->visible)) {
>   		if (pipe_ctx->stream_res.abm) {
>   			dc->hwss.set_pipe(pipe_ctx);
>   			pipe_ctx->stream_res.abm->funcs->set_abm_level(pipe_ctx->stream_res.abm,
