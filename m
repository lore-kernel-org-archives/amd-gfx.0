Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9E3C48BC3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C121010E815;
	Wed, 14 Feb 2024 18:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0JeU3MLc";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57BC110E815
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:48:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiMtV39IwKq69gg38VXJEZ/AtH/KbS5NSFdp3s9uCgb3os5MFQN7p8lU2KPTTZVm+0B6HWA8Q0x2D7tWo++7zQ1JBd8KWWoT33uCOmbI2xw6Ir+AYPm2CO40/22Uj0STvqwUzFOq7+GHmzGUbLrnCAymQi5+Sh5bUqcKjAD4M7+iMZU6XPPGcMZTB0/L5N1cVkKKb3QEeUPzaOmrEI9mEgPPHbEQRobCDMN7VGQVBadaKCE0KsFUSrrJQxHCrZ7IjRL5bkMD12VEvr3ZHTQKel2xm68FRUOLNy4zNuwiE4bKlA+AMif+/Bw11hub2XYiRChn4iIUxgUO/mavqCiDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZeC9VzHmStkF0AtO4TydgIx+YPt8N4Az2DeJksPS/k=;
 b=ZjvBD4FxRwGX+uaVsMVPV7Rk1S5Liyk1vFwz/kJXv7IjXbtutPTUVReZgm5ctE1h9N2GT9iiNGQYHkvKNswu3fYuvYcXtpF57/YPTyTm8/FjrQlcC0k3EpHyJnz/5miBlQC1A/OVWARhMav7e/+2zl1RXqaHt/gQvzBbvuTKGdWM3owde8eLGdeHvQX7Itxh6zALv/IhYW88tDJ1kAnTKsAlauOyPB7P8b6Y69GgmVj4ML0Ic2EBMktLoZtGWq7dErZZ3FfAqt9rWXmh2MfjZoscQWLECaoSKSd1Z4Z0z886J6EiYANYI5MlO2L1B42sReei0Dmu7XI0m5BNmXNnAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZeC9VzHmStkF0AtO4TydgIx+YPt8N4Az2DeJksPS/k=;
 b=0JeU3MLc0CxFeGAleI+Z7HEg5CIJ0SW2b+4s6gFZRyiMoQZECDXL9wcJZYYZLQY7BRCRZ8riS/xfEt6EY95n7Fw5I8u8Oseb+ZgkzWgbzkEK+7Kp6nG9xKtpeN1IojNKZPoImQuoZG5hy/DSC4EQOwjtO/bTfIxgdXbitf4piBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.26; Wed, 14 Feb 2024 18:48:28 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::3301:dfb9:528a:1fa5]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::3301:dfb9:528a:1fa5%7]) with mapi id 15.20.7316.012; Wed, 14 Feb 2024
 18:48:28 +0000
Message-ID: <1250df65-90e6-43f7-9704-959d8bbc5130@amd.com>
Date: Wed, 14 Feb 2024 13:48:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] drm/amd/display: Remove redundant FPU guard
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Aurabindo.Pillai@amd.com,
 roman.li@amd.com, wayne.lin@amd.com, agustin.gutierrez@amd.com,
 chiahsuan.chung@amd.com, hersenxs.wu@amd.com, jerry.zuo@amd.com
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
 <20240214184006.1356137-6-Rodrigo.Siqueira@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20240214184006.1356137-6-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::25) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DM8PR12MB5461:EE_
X-MS-Office365-Filtering-Correlation-Id: 350f792d-9e41-4ced-5d69-08dc2d8d884f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VH69oGQXNxylrAaGsC28DOASWc6F++48Qp9RYRevGqNxGx9GgnRw13u4I/wzU+yO0Vu8U7JsZSXPSwfkM6vXVuJ1CBR+SXBbVUbE+fuKrxTg8irKdOqzNr6i6AoS5JnsQ7iBU5e8ZFVOUtrR6sDnz75dDdIruVSKTfa8VVsKOGcMR4JYEmeoFsjGxwywjrT3PNs2zNO3RJGNVcNx8BaH+7KBTjwkTA1hEmJ57rGfiP98qye8CW5F7ikguVS4VZIv/Daa5uWalM4pB3HTfeTkKBvrd72+WaP5booDYPKwdgQdJ49pjp84pfnpUMhUVoRr1Lawz9RtUtHKa8N7z+kCYMHGSaeXf3ggwg3pmSTJKfFZoYZ2QBCn/ftbVYpEP9XNCdm1WAl37DWDjdR8IEbp+5oIwDeJuS+iLswtgrPfVQ6V5NJccwwvKpNJK7a3vus5K6zCZC2gpgZOsMWkB+6QF92laBEHoinJcbY8883Ocw0P1lDAGlAdSuyIKeh5MrDX4om3XMQhAsXTFsoSFVBw1t2oDRdroh9+N8Zka90xuCovvJKukE5D8/3MZDOcmqR6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(8936002)(4326008)(66556008)(66946007)(66476007)(2906002)(83380400001)(26005)(38100700002)(36756003)(86362001)(31696002)(316002)(5660300002)(2616005)(41300700001)(53546011)(478600001)(6512007)(6506007)(6486002)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3pUNncxNU9jZDFJN3BEQWd1RTJHUThYazU5RjJmclVrS0VmYzJ2Nm1aVkln?=
 =?utf-8?B?MGZIT0V5cjJsUzNUUXl5bnB0alo2Znhmd2RteXhWQ2NOU0JpMGxaQjkwMkp5?=
 =?utf-8?B?TkxnYUw0N29mbFMvZ2dOSkpxUS81MGhlaC9qaGp5WFJVRFVoZGYzVTFIN3oy?=
 =?utf-8?B?VkI0anJWMUVkZHpZWkE2YkdSaVRxczVNbWFsSUdUNGRLeVBZMGR6RlE3VVFI?=
 =?utf-8?B?RDR2M0RDUmlsYjZxOE1BR1VXcFV4eGgxU0JRVXNMaWtSS0hHNXlyc2szZ0pI?=
 =?utf-8?B?UDhIQzI0SGhkWnVuRWJ4dEtaWWRiUTZqN3ZYOW9nUXVpbjVxNWNOdGhENXc2?=
 =?utf-8?B?YjlOZmIwUEpiZkNqTHcvcGFXQ2JBa3VmRDQra2FmQ1kxb1NVUEFIUUdyamdE?=
 =?utf-8?B?c2c0NGl0T0JLOW9Hb2NPWDI4MUZmVzFpWm9GQTMrTm5KVWV4amw5b0RWcUJR?=
 =?utf-8?B?REpyUkFzb2t0MEY5bzlRZytCYThVOGtzOVlNUGZXQlFSZVRrNlFGYUNvYzlY?=
 =?utf-8?B?YzlaeDZDd25DS2tlQzdRRXllQmV6Tm1PcFg0bDQvSHVNV0hNeXh1N01GcW4x?=
 =?utf-8?B?NTR2aTRiM0U2d1dCS3IrcmhGSUxPMnZDMU1uSjNwVWVidDB6NS9hZnlWQmxn?=
 =?utf-8?B?a0dCZTRvUEpEN2xtT0dzZE0xTTJkSmVBemFXS3JQWS9ITDBUblFIQS9jTkJa?=
 =?utf-8?B?UnZlODl0NURBS3NQNlp4ZGRmVXo5WTgvUG9URVlFV00yVlk5KzBMMURveWlr?=
 =?utf-8?B?UzNtK1I5eDBVSlVnMnlHYndFTnZ3UTNSMFZ4OGFxZEh4d0cwM2NUUjRWck51?=
 =?utf-8?B?TEY1bzVoR0kvczc1elpPVzBCN3RBeS9naFJaTDdzK3I3T2hyK2JPSnBpU09Y?=
 =?utf-8?B?N0dNd1c1WnNRc05kc0hZekN4QWhxLzhHTzd5WVYyV0p3MlZ0WHdIdGtSd1dU?=
 =?utf-8?B?QlVaOC9pZXRDbGRGblpjSU9hQlhLUm1wdVhzdndiRkFPejVEb3hDVUtXMWNz?=
 =?utf-8?B?WjRpbE50OG1rd1VFUDExb01wNzA1N3kzK2FOelc2NHBhakFGOVRDTVl2cHcv?=
 =?utf-8?B?Ui9CLzNyenVwUGZqUGJkWFh0amlSY2lOek9YNDh0N3FwdjVxcisxbFpXek1x?=
 =?utf-8?B?NlM4M3RKS1pTZnFaZ1NaQWE4WjVXSGRxRUhDT1N0aEpqS1FkNks3N3Z2R2NE?=
 =?utf-8?B?a3JGanphQ3ArVFZvVS9hRmFVSHRnWkhTdHRMYTVaN3pGdjFPZ3pSQWZxZ1M1?=
 =?utf-8?B?Vk1zYnhVVlZLM0xyU0hpcWdkRDRsMWNiaXBENUkwdHg5WSttdHV4Q1VNeTJJ?=
 =?utf-8?B?Wk05bGRCY2xXU2Ixb3p3emg5ZWF5eTd2Ry8wVkZVU1NRanB0UGUxb3pIc0E1?=
 =?utf-8?B?OTJrSVVtY1FmS1l1VE5pRTkxUkM5VW5yc2hkSFBBeStJRWwyTGVHbEFUMDcz?=
 =?utf-8?B?blZoSGVBMTJ0Qm9halhHQ0JVa0lBMEdGVXdqS1BVYkd2Nlg2c0UzeWVWSTY0?=
 =?utf-8?B?K1YrbmluTEtEaDFkRE9QdFF2SkF0SSttcWxCa1Jpc2twTE52QjM1Mk1CeFFk?=
 =?utf-8?B?MWFUdHd6NUFVZUNqdUZXOThEam16c2piS1JyR3owQklKVm95b3ZzZDdXVVUz?=
 =?utf-8?B?dmFkZEpwNmRGOHNaaG9zcVJNUFpoLyt3UVJsTEN1KzE3SnJYS3lkVit3U0M1?=
 =?utf-8?B?NHY4U0RaUTlLbDNDdWF0OFdycmFpWldiVnI4UEZDWGRBRDZOUkNIR2tZYlFH?=
 =?utf-8?B?Q24vNFlZOHZSaW44TWhYV0xLSys4Qm9nOFdQZzRpSGs1bEk1WmRJYVMzS1F2?=
 =?utf-8?B?WVE2SkgyY3MydFhiWWN2eFlRRmtFQzMvQlhRa0RIeitpa05rdlk5azVNcnhO?=
 =?utf-8?B?Y2drMFJESkJSZHo2TkQwQ0RManVkQzV0Q1NBdmJZOTg4amw4M0FJWis1MU9n?=
 =?utf-8?B?dEw3a2lXUlFXNGtTLzRZMzVtWko5U2ZLRkdEMmFxcm0wdTRuVW5oaEFSZ1ZG?=
 =?utf-8?B?U3VrYnJmWTFJVXZIMHBUdG5mQlRtNktTVUF4SlFJMUJTTVVGMUlQOFBkdDN2?=
 =?utf-8?B?NGhDZ3hsaHpyUFI3RHo4RUNia09BMThJZnZ3emoxVm1ZZ1JqU1RjNUJ0OFZn?=
 =?utf-8?Q?EoI6T0GfhnD+0PvR4oIZ1IK53?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350f792d-9e41-4ced-5d69-08dc2d8d884f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:48:28.1895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/4UNob4fteKnKTWXPcb1m7wf/rM1t66pbB9Ukt+2kDYvP4E0KGNGaRkG4/paV+DeG1F59HRKVQypocWmrHS7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
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

On 2/14/24 13:38, Rodrigo Siqueira wrote:
> The function dcn32_build_wm_range_table call DC_FP_START/END. Drop the
> unnecessary FPU guard.
> 
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> index e64e45e4c833..ee5e7512a7ee 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
> @@ -243,10 +243,8 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
>   	/* Get UCLK, update bounding box */
>   	clk_mgr_base->funcs->get_memclk_states_from_smu(clk_mgr_base);
>   
> -	DC_FP_START();
>   	/* WM range table */
>   	dcn32_build_wm_range_table(clk_mgr);
> -	DC_FP_END();
>   }
>   
>   static void dcn32_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
-- 
Hamza

