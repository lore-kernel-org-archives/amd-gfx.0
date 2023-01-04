Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3004BC54E76
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jan 2023 22:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E06810E0A2;
	Wed,  4 Jan 2023 22:20:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D808710E0A2
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jan 2023 22:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgUwnT0ILKOX18c9JLCnrj0fNXYkYDXz6ON0ErHiXSbgFqIoZ7QH7qDWluyV4mYb0IcMHa0gWUT9zDKxvjkdVOHOtsAK8JvPBGWs4XGcVPaJOpVT8teqG1isxzsNla6phHIA0l6Is0KFLqIQV6i1ss6Et+lRSZW12JKbHrF27plaiP4awGRUrTtVPK/aartq/puxlCzhSJYVA5FzpkOeuvs9USiJKFspWNTAR54yPLMIFX5EagGuLpMaL1yM754Dq6b2ytBlQszltjUNZq3B6Nyjupp31NSi885ABHWxB98qieetQRqkTH7jE94x6Ph7tiQp6MPoDuSj1VCJ8ClCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qh3TPOlDvOw0L5h4r1xiq5Ck79SUNXGaMprtmb7MILs=;
 b=Btt//0NOSRWk0Iwf0ObxQVRUq7V/Oqh38MHwjsibOI0nHqYqiuWYFT8Sa8o+j/bOPwFszV5QmggioxVlo43ocsd8QYcyzb/uK7cdGhgCENsqpP107Xx+Yuxj8qw9+v+sZbvTp+UPOvP7jON5WzbbkELIjTxhQybmMZFwO8jMIxfaRQNp7OOjZ5zYPk5//XH/JX3djzlAZrNiVc5J6f7NgAl2WoWrUZSAjqDInNW4LBWfI3lIKEh5rLzsMfOQ76v9eG2ymV4rRY7A/pDeZFhtFroFMM4tGMtqEe9U4QDhPy0Ob3kDQg74sXJGAJvd9xKr4Y0mjB5KCq8Qxa2wRrOWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh3TPOlDvOw0L5h4r1xiq5Ck79SUNXGaMprtmb7MILs=;
 b=J7EZzv4EUs4P5RHYLOta5dxZzkqSs+NbwCLsKkcr0Ts/g7mf+oTxBcRbltdQz4cM3TS+ebZuNLisxV79M+JP2mjAm2KNH39ZpKNiG8vDT/4U7xDZjuYWlZY09o/IJf+cjPI0pt54jbkDDJapaWZscogUj7QoSFNq2b1o0nkarz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 BN9PR12MB5081.namprd12.prod.outlook.com (2603:10b6:408:132::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 22:20:43 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5935:7d8d:e955:6298]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5935:7d8d:e955:6298%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 22:20:43 +0000
Message-ID: <8025af84-97b5-a5bf-3a79-19041b993168@amd.com>
Date: Wed, 4 Jan 2023 17:21:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] drm/amd/display: Remove redundant logs from DSC code
Content-Language: en-US
To: Praful Swarnakar <praful.swarnakar@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20221216103518.308578-1-praful.swarnakar@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20221216103518.308578-1-praful.swarnakar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::35) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|BN9PR12MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc5b85e-90f5-455b-e783-08daeea1eb38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qf0jQh8/SMozTo7/RhWnqtjyo0cog4nI0zPdwvvZJERyRG7G960PW7unm6flVb+eMyA33MGkbWbWyDjGmMMPM9OlkwDbxTLOZlyZ8ooaZYbD6j0mU2EVCZg2TQd/Soc8NfVSc1iaxHYF0Ttyyy/9U+1VUq9phttbZprAS7pwBLm4sx3iapXvbz1EnmPygvmM3/cybZRECwkubwDLrww261Zo77Ojvqnz5eJEMWjmX8jVSQ4g6Yjh1f2jmud2VOR8lUKWeXjzrW6MvcL3qxjfS6yqHE4qk0XlHK20TSNZnUgyei8rWAGsAtUVvTjoqRfOXFsZMo9FJHswqesTVO+TAwX2Pj0r5SGxWqruU3G+8gW0KX1pg0PJOCE2ZSMHJjEYq+CHnw9JqPJroxSjXxjangXbG285FNBvnK39m5Ezxp9wfpp60X/3tko4f+29hiPhpVz8IrqPTZk12kHJPWyh+aXfPK2E9M3llnM67PK5oilu0Io8bEbFtyXqnSiZzJ2bmi1KA4iXSty565SS1GIGWAyeU6Ko5dsCPZwQWKMJhlPCQF8TW3IbAFoCrnJBGbpp7AgnHW6lx9wR1fAuvgwTB9uQVguYVOS1DoXpnQh8EXR55Sp7mavssr9wCFBV8H58pBnxhw+vwLgC1sNBaY4Wpnsk9VDWWBOQIynSPxa8E+YDBXZehPNRnd1fN7qVI485jpsTnHlPN8fkFzI4WAnOZvn2hm7Xe1gRkka3VcqFavo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199015)(8936002)(44832011)(2906002)(41300700001)(38100700002)(66946007)(8676002)(66476007)(5660300002)(6666004)(31686004)(66556008)(4326008)(83380400001)(6512007)(478600001)(26005)(186003)(2616005)(6486002)(316002)(53546011)(6636002)(31696002)(110136005)(36756003)(6506007)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTE3Y3ltYmdjbnZpZEtuM2VZVWxZdm82cUhjN1RXL0hhV0JYaWc0MFNYZFhJ?=
 =?utf-8?B?U0p4SXA2YnR2WTFzQURvRTQwSGxNOFpDMC9UWTVJMklTK0dnVUVGL21kblpF?=
 =?utf-8?B?enNMYjJ2cEIwV0JidU41UUVhZy9rM0lMaDhqZDcwT3I4RUs3eCtJaXNGMzZI?=
 =?utf-8?B?N3YvMkI2Z0hoandsVVgzejM4ajVYVjZsZUs4WnJrSU9HaFVoN1pmUGJ5bUcr?=
 =?utf-8?B?T1V3QWZYbzRTVnErWGdUY0NMOHVkS0EwNjB6MXZXUHRFWDRPdndIZisrZlR6?=
 =?utf-8?B?eUtFK25lUzhQYktjeW1OS3JTcGdzVVE2OEphVHc3WXFIU0hsOUg3Z29vZkY3?=
 =?utf-8?B?MkgrV3NyVUYwVGZDWnAwZklHUXZhcllXcVB0U3JBTWQzZS9kNzQwNTRFWHVR?=
 =?utf-8?B?TGFmL3lndGtScmpUNGkvV2JRTm1OTURLOUFsUDZrSkd1RndiMnNpNzQ3M1pM?=
 =?utf-8?B?V2FER0tkaWI1cDdadXc5cE9xdXJ5U2lyYlhUWm8zY2xXUTNIekNBajRIc1lH?=
 =?utf-8?B?Nk9RWnA5U2F2a2hScThNVE9pbXpBQzNSWXJ3dU9mTExTWjFRRUFPMzVJMWRy?=
 =?utf-8?B?ZzlFb0hEeXVzVFJxR3F3REZoeC91MlN0QmlxcnljTFp6WElVKzROcDZhbkxU?=
 =?utf-8?B?dVNNeGo4aU01ZEdwRHM4SzAwVEFFTCt2Z0VJYVp6MkZtRFRtOG9NVlAzVkFU?=
 =?utf-8?B?MDFxQ1NiTElMTWx4Uzk4dWxkTXNWWUU2Skt5V0Vjdy9lQ3FzMkRCblI4aWdG?=
 =?utf-8?B?b1ZZZk94SnF0aEV5eitpdTdSTkJzL1JFVjFQSDhiaUJZczMybXBQdHpHdXM3?=
 =?utf-8?B?M3d0RUZnWWZQZHk3Nmc3R1dSSEVlR0lWa0VpU1FpN0RnS1lNNFNkVXRjbURs?=
 =?utf-8?B?QnlURmxCc2J6MTdjeHRKQVo0S1crclNTdlp4dVNyNUNYbmpUS1MwWFdrRzdH?=
 =?utf-8?B?Y1o5SnBFYVFNV1hDNFZZUFFGTHN6T2FOM2RhMWUxMzBabHlEbUdmMXMwYnAw?=
 =?utf-8?B?djBNRnNzdStjSFRPZ29RaS82eUtNdm9MNXFweXV6cjRaMVVrOEpxZ0w3WVI4?=
 =?utf-8?B?bEx1K2dXcUwvV205aGkxd3BJNGhGdjNZR3BKTXlyVmQ2Q0p4NmtHZC9sM0Na?=
 =?utf-8?B?N0d6U09CdUp0M29HdFRERU03Vnp1aTRMK3VGeFBtc2srRnczenhnLzhLeVNQ?=
 =?utf-8?B?QS9kT1ZqdGJJd2tGS0ttSWl1R21aRTVnSHZIdVFzc1hJTXNLWksrV2JlQ3pw?=
 =?utf-8?B?czBERWtCWFlGUENTNWlRNkdmeVY2ZWlyUzF3WkV4ejF1eDVWZm83Rkthdkg1?=
 =?utf-8?B?aUtxUjRwRW1kVGJMVW9wTlk5KzVqNUZzWFZrNEllTnNPemRlZ1NJaTFsMloz?=
 =?utf-8?B?M1A1ekRhdFlXOFBTeGhub2pvRGhxVkpVdUVLd2ZPaVZLYzhNaHJjOFV3SjQ5?=
 =?utf-8?B?c2VncFJLU1BVcUNGVFhRcEhtQ0tXNEM4em9XQ3doTmZhM0doQ3lkOHpXc1Ft?=
 =?utf-8?B?VmJ3MkZwRnBMUWRGZFlXL3BKYm5jVnIwdy9GcmJndjB5S29FY20yQk56dTZj?=
 =?utf-8?B?Q0xva0I3akpWcFYzblN5YW1qbGFXV0lOc3pwNjNnWHlhZjZBUTJKR1M5Wk51?=
 =?utf-8?B?MUJNeUNKRTRUVTIzQW1ONFFmMUx4TWllc0p2STBMc3dqK3hTYS9PWjlIYjZ5?=
 =?utf-8?B?YkFiYXdQTWo0L2J6ZDEvd2dCQjYwSlltT21idWduN2hWOHRjRm1jUEZDSkoz?=
 =?utf-8?B?YkdsbmNsK1NRcFlxY2tTTDFIMjJERFBRcWlObmZHTVpoMTkzQnJ1dUFWWm1G?=
 =?utf-8?B?dWhLcVdRVXFyNkUwVUgvSHJhY0c0U3l6TksybEdRZzBFR0x5N21xTjJvR3FV?=
 =?utf-8?B?WFIwNTgvYnlGb2E0Q0FaM0NmUWZqZ0UybUI3U3Y1UmxwZGFZWURBNU9JZkhC?=
 =?utf-8?B?TEtQNFhSNGQyamlCdklCVEtaWlA1UFZOZ3p0WU5UYVh1STFqbS8rMmttTjlr?=
 =?utf-8?B?MW9wWU1pNThsaHJFQ0xzZHM0ZGlJSFkxNDc3VlZWSnUvaE5xOFpDR3lNcFM2?=
 =?utf-8?B?Q3FOWHd0V2FxZk5wdmJsdVBZcXJLRm5JQjlrZ1JkYlJrOEdObW9qM2JOcVZt?=
 =?utf-8?Q?yLyvTpK8C7B0nOvCmcWfKjFtI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc5b85e-90f5-455b-e783-08daeea1eb38
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 22:20:43.1429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10mHv/eyrO3oPvdmW/BdFOJkN4haSgD/ZLOBJd0EvOOCUtMIyLzsniEKYZD1z0RYEOG2HfAkaDj/JhdW6H8BqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5081
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

On 12/16/22 05:35, Praful Swarnakar wrote:
> [Why & How]
> Remove redundant log in DSC that just add additional blank prints
> 
> Signed-off-by: Praful Swarnakar <praful.swarnakar@amd.com>

Applied, thanks!

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 1 -
>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index af9411ee3c74..f2b6d40e4f5c 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -7510,7 +7510,6 @@ bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable, bool immediate_u
>   		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe ? true : false;
>   		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
>   
> -		DC_LOG_DSC(" ");
>   		dsc->funcs->dsc_get_packed_pps(dsc, &dsc_cfg, &dsc_packed_pps[0]);
>   		memcpy(&stream->dsc_packed_pps[0], &dsc_packed_pps[0], sizeof(stream->dsc_packed_pps));
>   		if (dc_is_dp_signal(stream->signal)) {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
> index 784a8b6f360d..c08c01e05dcf 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
> @@ -200,7 +200,6 @@ static void dsc2_set_config(struct display_stream_compressor *dsc, const struct
>   	bool is_config_ok;
>   	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
>   
> -	DC_LOG_DSC(" ");
>   	DC_LOG_DSC("Setting DSC Config at DSC inst %d", dsc->inst);
>   	dsc_config_log(dsc, dsc_cfg);
>   	is_config_ok = dsc_prepare_config(dsc_cfg, &dsc20->reg_vals, dsc_optc_cfg);

-- 
Hamza

