Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E41BC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 19:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEA83112D31;
	Tue, 23 Apr 2024 19:32:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qqSemJIv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E37F4112D31
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 19:32:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hx78TrFvs4IqB09SZQLzoxckIn5h0yMJZLN8gjOFX4AqTWp0NF8tVXIa2VBocqOCqbwa6zZpARhfMJZ6po+/P5kYvdfBahsUwPKh1jYQCXIgBmvIS11OpQPoVlwqC1EL08Ynf0ia5tEnBrR2BKxd/LcHj1n/ft2Bv07oJM9EIzvJQtSq4jGOlfXc9f5mGB73CpJ+U5bGMKzdYkGVYKH6kAmRReBw+T7AO5uQVChVC6inbUXuq1eQtR19UPWKoh8dQsmyaybSlxyuFoB3ZOMXbpES52QkYE/Arbse0Q58wObTN+7o2nUlZvU2X7tmPQyrCJEMcoYxzMvi4DCfOzXABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX47wVtbTiJID0G8Cin3hEfxOwLFxzBwZ0xZBLoPRpI=;
 b=k6ldddk14evJ+zpFfzOOD+law+rAsp/TFbD5Hj4R+mGYH9tyiIlWxI8Cc+CvFLU4iDg2ojBh6kT2tVXOswkVvFYYplK+CzN72Y30HIwTq8qxP0nDSAym05WSwfqdMucKlQ/Ei4Cm/Uzqh+J4xmajT8GPszbB1vAP9IeE39l1pTmlq9kTL3esal5wM4lTQaxH5tBpGDQ2HDg5jUtzjTb8acIVzDPD1TCGkCZ7dD7duNfF/JOBI9CX3xmjKp41RHVSMqWOngW2A4NC5KnVUT+mHo2xymqt+VSCe0uZk8Rfi0bdxRjndTy0kvMB46VvvnLpstMjYOVJ632sZ8381s4y7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX47wVtbTiJID0G8Cin3hEfxOwLFxzBwZ0xZBLoPRpI=;
 b=qqSemJIvjSpW7TeEcSA3gRKg+0pDG8rvsRthnuzudj3IoYrJBXl90mTPz6ylSzGZc5+tJRIb/KjOyEMYZdvFtxTWsveiT3VFFsLysDrOY3nN+O5Rw/fm+16dirhgqprJ1zdvl6tA8CmsvnvYfWYqOaiFpysjhgu+/o8XDB4Hlpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 19:32:46 +0000
Received: from MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::2243:aadd:acd3:3455]) by MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::2243:aadd:acd3:3455%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 19:32:46 +0000
Message-ID: <82dba3e9-ace3-4c4e-b48f-ba3cb6bbd61c@amd.com>
Date: Tue, 23 Apr 2024 13:32:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: use mpcc_count to log MPC state
Content-Language: en-US
To: Melissa Wen <mwen@igalia.com>, Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>,
 christian.koenig@amd.com, Xinhui.Pan@amd.com
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20240412163928.118203-1-mwen@igalia.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240412163928.118203-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:805:106::37) To MW6PR12MB8733.namprd12.prod.outlook.com
 (2603:10b6:303:24c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8733:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: c408ac45-09a5-4b82-5421-08dc63cc2713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlAxSm5iYlIxaFdrWVYzOTR4SWVQQlNCTWg4SFA4cHBGckg2ZTNFcW5KMjN4?=
 =?utf-8?B?VjNsZTlZSFBFVXB0QlE0RFNXaHgvQnhFTGt1cEx2b3ZQQjkrTGkzalNkdEJh?=
 =?utf-8?B?ZVkxRmRlZ09EV2tGVkJmbU1scjN0MnJTdzVvU2h6WHpLT1BuUjFNcHRSZVAv?=
 =?utf-8?B?Mm1DTklzNENNWlViM2dzcDE1cGR1UlczNUppdmt4MWI2SzkwS1V4eVhEN3Jj?=
 =?utf-8?B?TjUwclg4QTdZdi9GblNNTktRRWFvU0d4SkIxdkxxZ2JTVC9IM1RNazRnQ1VK?=
 =?utf-8?B?S1crRVFNTkNXNElvOWRsZnJUTjk3Q2pJZE9sYnJVWHA5T3hqaFlXUU80eFkw?=
 =?utf-8?B?SlZKUnJTZVB3eElseUpqV1crMjhBSWgzaGtmTHhqR3JsQTV4NlJzSUJmNy95?=
 =?utf-8?B?YTYvejZBUm5SWEZudk5PODFJNjJiV09waU83SkcyQnJYNnd5NDFUMERwYjBq?=
 =?utf-8?B?SVVvRUZaVjM3UGNNdm5KUno0emNNNWNYbTZRRzJPOTU1VVFxLzRVbFd5SnRK?=
 =?utf-8?B?ZGRkK09YZ09GUFIxVjdYYnlQZC85cXdmSEVHSkVnNmtOcmhERUQ5UmYxbzBR?=
 =?utf-8?B?Y2ZUSFFDeFpXRTlOQ2wyUWtON3hzbEp4STA1VmtweVZSMXhTRDBPaHA0R1hx?=
 =?utf-8?B?Sk16YzBIS0V0K2ZJS2VxZkxSMnZoTjcvUmV5OXBZUHpkUlRqWFZWdnFSUUo0?=
 =?utf-8?B?ekFtbjhVUCt4WEJ3dElFVXB0ZG51M0ZTdlhKdDJZaXJKSndZU3VHZGU5RnVN?=
 =?utf-8?B?dHJOTmVEbW1pQjI2eXBTSjdLdUkzMklUTjkxTmk4NWJkU2xkSmtrcTNtZkFG?=
 =?utf-8?B?dzhENTZRa1NCV3lzWkNQSVRLbzFXalVjNnRkYUhCUlhaR2M5elFUR3Fpenlk?=
 =?utf-8?B?MmR2V1AvMkFSak1WZVRNei9scS82bEFpMUVTeTB5M1ZGU2p4WmRNNWRUNmh3?=
 =?utf-8?B?OGw4K200b0RVN0xMZ0ZsQzd1dUpuUDFYVHlXM2dmMWpHSmhrMk9sR3ZZV0ty?=
 =?utf-8?B?aGdjczh1SDlZSDRQNHhZeUdJREtINUlEUjgwU2VvVEF0di9sMXAxa0FIdE9S?=
 =?utf-8?B?UUErM2loNXB3dXkzNENVek9ienVOMEFzZEI2T2FwcTNTRkpTVTJ3R2pmL0pH?=
 =?utf-8?B?bFNRREJqd09LMDJqZWdxYXFHM1U5NWZUQ3lrbWtuekl1aHd0YnJrRmc0MHdF?=
 =?utf-8?B?dW9GaE9UdEJTOEdjNEozNWg2b1RxVUlsRnduQkNDdk1iK1FQR0Y3cm5wbVJV?=
 =?utf-8?B?UFhWaDdDMG92UmNCdUgzMVArSHRFZnFncnZ6UnVFUnRUQU9XVjVXMys3MWdH?=
 =?utf-8?B?TEUybnpwOWc3QnNsS3ZyajFxMldPVjVYWTBGcWF3eXpaQUtUWTM4d1hZSlpB?=
 =?utf-8?B?cWY3WDk4RHBlc2ZFeHdqSGpVdE9HU3h5MXBRaG9tMVFDYzlycWJjWFVhVTFx?=
 =?utf-8?B?czlSN0wvSWpnS0VpdnFteGJqR0Q4SDRjZFRtL1RQOWY0SDhEbU1aOHFvOGY0?=
 =?utf-8?B?SWVtUis0NVA4U1ZtQnJBd1ZUUTZuSEU2TTBJcUZ3Qy84L013K1dubUFUR0RS?=
 =?utf-8?B?T0NnY0VIdjJhQlc3SnRFeHd5cGkzMzZYUFBiMDZGcWxUVzNLTW94TEYxREhi?=
 =?utf-8?B?bVZMQjR6RHIxYUY5bkVaWWp1SlQ2dHhZMlZjdXpVT2FiTDFoZUJpNUljb05i?=
 =?utf-8?B?UkVsRjNPTnA0eE0weEd4RVpDRFJSYzdqNG90Wjg0eC9wVk9EY0tXUFV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8733.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUErVFZMN0FRQW93UVUvRnNJTmFpeU0ra3JZWitMa2RWK2M5ZUxBdzJaUmVv?=
 =?utf-8?B?YWJqOFg2aXNzVHlIenBEdlh2RFZCSkhSRFpqaUhPYVFISzl3c1ZyTkhlQS9U?=
 =?utf-8?B?NThVK2dwTXVqTWNndzV3Yy9oVDFQaXVyNnRDNnY0L3dHYU12MXFhV3ZKellp?=
 =?utf-8?B?V3pCMHBadm9pa0RSSzR1NmFTcXpZQ2k4SlgyV0gvRTN4ak1KRFFGMGNQY013?=
 =?utf-8?B?aXdjUDdBTi9obU1OSFFRTHZ4UjV6cHBWcGtiOC9zdGVrQi9oRkRzL0g0SFJ1?=
 =?utf-8?B?bldjbWhxNzFqUXlQWlE3cGkvVnZKVVFYU3ZtREZkalh3QkZ1dzVzUStTOG9l?=
 =?utf-8?B?YzdTLzFjNldjVUhweTZZSTgrMlFCRG11M0dMb3hFd1N0dUFFdjY3M1ZiN0o2?=
 =?utf-8?B?RUVoWDgzVUJQdmJtSjNXbFcyOGxHUG1TNTZJL1hXTS9jQ25IaS9SczQvYTVE?=
 =?utf-8?B?VHhFU3M4UFhweUNRakJJZkFybjNmREY2R0c5NTRjejU4YXk2eTRONWFZWi9a?=
 =?utf-8?B?RlZYOStNcEtpNW9xKzdGdmVKTlN4K3RnaGhPRWlJVGR3THZRRUN6Nk51SjJJ?=
 =?utf-8?B?ZnpBSmJYUnhHSzZ6WGpZOG1pZjRJdUFKZno1SG5XNmJzZkRMNzNTQ2hNQ1da?=
 =?utf-8?B?M0hJWUxkSVh4YU5ta1pTWEVsb0U1RU5Vb0JaL1hVaGpuRGhCbzB5Vlp4WnNK?=
 =?utf-8?B?S3YyU3VDVVN1dkltbWxkMGxFTm9DM21IYmN3L1UweUQxdy9MQXp4a0ZUYzhF?=
 =?utf-8?B?dExORTBoTnp6THFxbEFSNnRHTGtNd0ZYNjA4SGpRemU4ODVIZHRDSHQzTE96?=
 =?utf-8?B?QmlXUHJVLzhDbGhKSEljZUFpaC9Rd3hVYVRDOVJjNFJVWDdWcWJDYmxCQmpn?=
 =?utf-8?B?UllnTlhrdHpmcWVsTFUzcWtTT1dwNGEyMllFaWp0SGUrdWxnc2VHWXkzZmI1?=
 =?utf-8?B?MHVGdjZoNXVJYXh0MzRwMlk5MGY3cUdNL2ZYeGdYSFdCaWhyYmpsYnNNejZC?=
 =?utf-8?B?RFR5RHhYVEtzZWs1eHBOWGxBMDZQVjlhSWNLVlROVjRCVTV0SjJUNGl1cGtN?=
 =?utf-8?B?VXpIV0ZiR2JsNVo2eldEaldackxHb1BJZnZCVmhISHcxYXEzVXE3bXNWWDdp?=
 =?utf-8?B?SmJVRDd6MFhpd2V0WThFL3hZUzB4L280MEwwSTc0L3V1ekVpaHc3TFFHUlhI?=
 =?utf-8?B?NzlwOUlvdk1mTFN5K2Y5TXpIMy84aHg4MEpKcFZBQnNETWYvKzhVSmZLVWpn?=
 =?utf-8?B?YVhNQWFSR2h5NEpRM2x1NVdUY0U5dGdNMmF6WHU3ZTh3WTluemwxWWpvN3R5?=
 =?utf-8?B?Y0RKT0Zod3pmQnJ2RDZzSFo0SGtmc3czR3RWeEZsaFpWZUZxNDdPK1B1R0RB?=
 =?utf-8?B?Z041dGFpQnI5UjFRUmlMNzV6ZWhVdE5XT0VrZmhXczBzLzQ0RDlsUjNwWWZy?=
 =?utf-8?B?UlRudks5K2ErbWordU1CSDRyejJxSmhQWktTZEFDVWI3bUtKcFljUmRCTnJD?=
 =?utf-8?B?ajUzMFJaeGkzUzZ4MUh0UUFBSTBSeUFoMHU1Wlk1SWh1M1poekNvT3RvNEZM?=
 =?utf-8?B?NGpVTlZYL2VENzIwV3YwOE1sWVJyTXJaQWUwOU9pYkVKOHlrZUViK0NZVktP?=
 =?utf-8?B?ZTdySVRONmkvNnRWY3ZCTzVJN0lkeVNZN1FuemN6YTJKMUNXZjUwK2JWeEor?=
 =?utf-8?B?cHpJRXlFaHQydFh2eGNQUnVTSVNYay9aYXB5ekRaRW9ZNm9PYndsTEFGU3B1?=
 =?utf-8?B?amZ1aVhBSllnZWlBVXBCc1JUYk1HQ0VSWm0wamphZTJLRXRUclpNMFA2YVFz?=
 =?utf-8?B?ajJ2bzNjZmh0OHQ2MUNhaDRxS2JHaDRYZEF0WmxXZ0tHMkEyYnJTNmdGMi9n?=
 =?utf-8?B?ek5CK0xDYXB2eXplR2c5elFSbTl1dzRmbUE5S3BSYXpzeWJSU3ZuVm4zd2JJ?=
 =?utf-8?B?dkJHcEhnemV0a3V6ZERudm9lQnhDNmJ6T0x0ZDJqd1R1aUk2SlBrT0dOaUNO?=
 =?utf-8?B?dkxIazgzS2w2ZmFtWVBJWDNFYTMvTDJoaHliam56OStKbVJ1bE85amErbmNC?=
 =?utf-8?B?T0JweExNbllRVHRCUWRIUHZXc0RScXZoQ0xDMWxqTFJpZHI1U3Q0bWEzWnRt?=
 =?utf-8?Q?pHu4VRFLPsHBFkzRY7XhQR3SH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c408ac45-09a5-4b82-5421-08dc63cc2713
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 19:32:46.1138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyKeK4j4rhl4CHhzFGqdVEoxc9UuPfV8Y+497veSbYlds+SM3Jr17BrDd888OrqiOKCELezj9o1RiGqJRDjAmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
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



On 4/12/24 10:39 AM, Melissa Wen wrote:
> According to [1]:
> ```
> DTN only logs 'pipe_count' instances of MPCC. However in some cases
> there are different number of MPCC than DPP (pipe_count).
> ```
> 
> As DTN log still relies on pipe_count to print mpcc state, switch to
> mpcc_count in all occurrences.
> 
> [1] https://lore.kernel.org/amd-gfx/20240328195047.2843715-39-Roman.Li@amd.com/
> 
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 2 +-
>   drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 2 +-
>   drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> index 3940f25f7d9f..088224571029 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
> @@ -367,7 +367,7 @@ static void dcn10_log_color_state(struct dc *dc,
>   		 dc->caps.color.dpp.ocsc);
>   
>   	DTN_INFO("MPCC:  OPP  DPP  MPCCBOT  MODE  ALPHA_MODE  PREMULT  OVERLAP_ONLY  IDLE\n");
> -	for (i = 0; i < pool->pipe_count; i++) {
> +	for (i = 0; i < pool->mpcc_count; i++) {
>   		struct mpcc_state s = {0};
>   
>   		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> index 87b43cb50c1e..a38333152654 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> @@ -155,7 +155,7 @@ void dcn20_log_color_state(struct dc *dc,
>   	DTN_INFO("MPCC:  OPP  DPP  MPCCBOT  MODE  ALPHA_MODE  PREMULT  OVERLAP_ONLY  IDLE"
>   		 "  OGAM mode\n");
>   
> -	for (i = 0; i < pool->pipe_count; i++) {
> +	for (i = 0; i < pool->mpcc_count; i++) {
>   		struct mpcc_state s = {0};
>   
>   		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> index 40391dd16944..ed9141a67db3 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> @@ -166,7 +166,7 @@ void dcn30_log_color_state(struct dc *dc,
>   		 "C21        C22        C23        C24        "
>   		 "C31        C32        C33        C34        \n");
>   
> -	for (i = 0; i < pool->pipe_count; i++) {
> +	for (i = 0; i < pool->mpcc_count; i++) {
>   		struct mpcc_state s = {0};
>   
>   		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);

Hi Melissa,

Thanks a lot for your patch.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

I already merged this change to asdn.

Thanks
Siqueira
