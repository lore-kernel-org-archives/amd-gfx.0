Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DA1C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 16:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 360D810EDD6;
	Fri,  4 Feb 2022 16:38:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDE4110EDD6
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 16:38:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIthQf43Y+gD4/UzUBbogjcyaLCYKziR5+S5y4wodjhQ8Zc/+2VHO3t64RIU+z0bHMAw2fbofCzdeJaN3UUGYDszWM0yCL5bVP0I6xmxiAx6Owr6/DR5xAp/5B7QVfmTXgjZ43tK9Gsm8qY4UnK+0by/tyN5F+XVLgxGv8Uj5Zlhy3ljwtEtL056+/eoeIsHHdb9NDcqZ6O8gwThBfCWHp9qw3qI5XWyuu22HNS0xPW91z0Vd6PJcFttEcQXbjU6h/9gHufX6433WyPjFmxC6zdyf52HECsmnGssb6UjwtlIK/WeGdnKyoxcGfSPBv4nw6CWeAxoMxJDoe1PiKlcKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmDk4vuGm3zHTaU+R5bj+cx5xiWfLPk+iHF7JFj/ykA=;
 b=lyZoSieYNgalqr7kYyhUdhhHtQNcZFVx/5buU62LsvgC9MDfsqGLjJdNJqnRmE5rZtgNHkRNmyiUwR1Q2pQWCvxKcProwwfurMEOYSwbhKwmqsRGGy/KcG9Ni8pwI5BMMbvc9Q74XpQ4mZQOkRUAacvG4acx07gjovYoj+06dqjZzK1BBz1D1h+SlDL+fNXG4enYsS5UCKyhQDWByOBNC5fHKlsGQtnCQ1+SQU86fMO51uEoNIx5qMTwxf9TYmk6Hl7ai+gblFg+HUT2tp0Zx8X63f04exdbhnezuvQ6J4J1N83euufaHXAbjazSefq96eWlU41wUHYTHqDnW5qXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmDk4vuGm3zHTaU+R5bj+cx5xiWfLPk+iHF7JFj/ykA=;
 b=FWVq1HxJXffFLmtBn4h6CKt6gzaAYYHEF0QHrzzMc5ND3EWNkDzESxJCh0VHKr511vboQI6WEAcOq1MvgDvNRodPQ8p7o1M7lhLaegVFCESrXQlKXAOu/mmGT5JYxHdoPV0GYcGARSgNE9WxNACxaNIsL/2ETE02taG8+3U8oZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BN6PR12MB1666.namprd12.prod.outlook.com (2603:10b6:405:3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Fri, 4 Feb
 2022 16:38:47 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 16:38:47 +0000
Message-ID: <d951ccbb-ab9b-c98c-99c6-a8cced444ad8@amd.com>
Date: Fri, 4 Feb 2022 11:38:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] drm/amdgpu/display: change pipe policy for DCN 2.0
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220203185804.1473979-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220203185804.1473979-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::8) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ece03203-25a4-41e4-bc9b-08d9e7fcd110
X-MS-TrafficTypeDiagnostic: BN6PR12MB1666:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1666C681305F2A8AB739BED68C299@BN6PR12MB1666.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTKnrjy/mYymzpxwv+dsvSb3GeZ+H0+DsXp931Cqdf9esz1pcLyWi3TfmdyNcdzfZvlvgL44jrvtehaXiamlXQEzRar5RzbKeKXtIrF5V8+wKgfnAGhPifm6UIghtngvZNAT1lMLBv49LPJ5rfmkf/vnDCgbZepjopD28bOUKrLoT6herilIuCOsXiLTJSfzlis3byFT8fN4/J6Awm7u9UesSAa9+u55VeiDasNeoZX1fhTzceNeXnd967juTKPXaryt9mXIcYtSh7ShFvabnds9nKhWY61Ie2byoGKr9SPuIja0UWBd4nxaR//M/n+x4ZwwAaPXHrsxxLh/36XJd6NkmF/izm1jMdFQth/QT3OHpqAbV/mPxAFelFKOeQhXjjmj0MO3y55EE9phaqJ1uH/+Nb92K7yc6mufJw3wgLuKaJRK2dow5HmZkzm6EYUEHyUqxkl2unYaA/lf5U8DB12jdSE3rW3fffGX04eurrHd+PVLn34vX4i6BzVcEM54J+wCg/VnCQV0GU361RVGKZwgiIbBU18kmIzkxOXLQtwjEOzF/r3/h9cUPyTxNTSQTyKJkUL0MmXP04h+hiDf4deqaibSTjN50RS+TpkY76t+3QeDYpu6OVbnXXJR+dKq0Cf9QEUe/r9Y3pwtTxAMoskcOw+YlG/4E62hTAkQTsIwfZvRiAdMIciv4syIWz6hgAobnXUGxQ4ImpGuKUiXCfTxA0hC8hisGq4UktDv+TIuZBOtX/4gKUH2FobnsSMs/5+gv+AgmH1vSHdNs25A7hxYdEm4TJlNK8YzDUNTTuJcxSptaWj/OmpaYx8KzXkp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(83380400001)(6666004)(5660300002)(6512007)(44832011)(186003)(53546011)(26005)(2906002)(31686004)(36756003)(2616005)(508600001)(6506007)(38100700002)(31696002)(86362001)(966005)(316002)(66556008)(66476007)(66946007)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TldNOFRWTER0dS9KREtJeGpQb0lSYTNVNGNBTTdxNnVLL1hvRUxMc2Exemty?=
 =?utf-8?B?SXVKN3dmOTl0YkNWRlMzWWhBSmE1ZmhXanRVQTdaeUxsZGVYTml1ZDI4aDhR?=
 =?utf-8?B?dldoQU5qd2FxMDhWb1MwaGNoQkpHQ3Y5QnFFMDBTcVFjYVJGcmI3MjgyRTFW?=
 =?utf-8?B?b0tHS2tLaEJJY04rSTIxbzRtN3FmOWs1c2I1dWVQZThxMWRZMzgyRnR0TWIy?=
 =?utf-8?B?U01VemZjb1Z4d2JtYk1tSEZsc0h6ZVlKZ0g5bnZGZUt1L3M3cGpKRkFDRFBC?=
 =?utf-8?B?SW9FYTYxejgxaVZtT0EzNGVFYnQ1VkJvUWZReXBwNElVSXBsQzM2MlVCTUND?=
 =?utf-8?B?YTVLTGhING9CZ1B4OWw3eEZ1Wncwd091eW1ObXc2RXZiNmQzb0FNTWRxWkpu?=
 =?utf-8?B?RUZvU25NV1BMTlJVZVM3TE1adWxtVktVbUdwZktwWEN5azdOb013LzkzV203?=
 =?utf-8?B?aXFmUWZnTnZSTzY1VDJvVnFQV1JGT3g0alFHRFN1Z0R2Ui9DcEx5QXZQV2g5?=
 =?utf-8?B?TzVpM3ArNWxSRmNFQmhLaGFtTmttTlNoWFBzK2pnVXpnUVVGeTI0N3pWQi9w?=
 =?utf-8?B?L0tubUhmbCtJcmZBTklPUU5pSU1wVHJzaVpkM2JPMklBeFdOR2hUaHFEQy9m?=
 =?utf-8?B?cloxYWNQT3lOWWFWOXVTNXZWaGZxQVQ4aEt1S21ad1FWdEt6RzlTM0hLNTl3?=
 =?utf-8?B?SEw4TWpsMm95SmdzeWhCVEpGT0NZL1NlczJmRFRhU3AyOWV2YWtYeWpncGhG?=
 =?utf-8?B?bGlQOEd4am84QkxNbW9kdmkydFJlWkoxUkIvZmcwZVFJa2ozcVJsZU1xQVVY?=
 =?utf-8?B?SUZDT1NiSGZZQ1crK2hkOWYyYzlwNEtqdGZMdDY5TWhZMlhBMTkzVmQ3NXgr?=
 =?utf-8?B?VTU3R3p0NFQyQktXam1Pb1M0bWxTZDJwaEdkSTYraVBPaFRMZnVBZzRzTWxh?=
 =?utf-8?B?NmFvNWsrY3JDUkcrcCtTRUZ2RDJYWEVLUTQ4OHNEa1NtTHdTaUFHMGJGQlFr?=
 =?utf-8?B?Ry9TUzhBSVR5aFpVNjhsZlFaazBFTFhxTVViNTE3RU5FNzdxS01BUzRIbzJo?=
 =?utf-8?B?WGZmMmZPaVBhYW9XMmxVYk5LbWhMWXhsRGIrQVBNT1d5Qkt0cHpQZlpQVlNR?=
 =?utf-8?B?V2xrMU1LZ3JUWmF0WFh3R2h5blQyTG5XQmtDUUk5S296MXdieC9KZ3RmR085?=
 =?utf-8?B?OUtRZ2IvUFkvQTd4TDdCR05QZDVONS9kUzBOQ1kvWUZGTGc4KzYyeGRUbFl3?=
 =?utf-8?B?ZDBMU1gvQnZVVGFkZ3U1UTRKWEtwSlpNSnlHbHlkUzlxN25VTWk2RWRob2FS?=
 =?utf-8?B?dW1sckFIQjVDU21kQUl5L3lrbWlSK0t4dE1QVVd5VDdLVmpYT09OYzNxMFYz?=
 =?utf-8?B?OUZGK0Y1U2cyelZ3b3lMc3BGb2MwM0thREpJYlgvREhvcWJpaGgwTUMxOWN6?=
 =?utf-8?B?anJtVE9lSjF3MnhSRjdkci9ieXUreDhlVDkxaDA2NjZtYmNjbERCWkdRWlRU?=
 =?utf-8?B?cnAzNkhLVjhvQ0FlYjNKWkZQTm4wNUJ3U05jcDNzUjFFaGVnajlNL2hLWldZ?=
 =?utf-8?B?WmNmSWVDaTNZSXVYcy9sODBQWWVqb0Qzd2VvVHB2WHdYT2dpQzV3ZjlHalAv?=
 =?utf-8?B?L3ZVbW0vVlNNekJxSitsb2xwdGNxc2dYZEFoamN6Y3RPVzgvelBZUVRoRzRS?=
 =?utf-8?B?TG83MXdCKzNmTnFqUGFjcWxJU25qQVIzbDFsZ0xRcVd1bTRETlUxMDZyekxt?=
 =?utf-8?B?Wm1VUVIvOFRUZmFMM2xtNitvTEdBaDFBdXZEV1BUZENla201SkJxb050SUZt?=
 =?utf-8?B?bS9RK3NBSHN3eHFZKzdJdHczZ0c2OEhWTDI5K1FaS0dZMEZVcW9hMWRrQXZz?=
 =?utf-8?B?dW42bE4yTlpUWDNTM2s2bG0vSCs2SmJzS2NMLy84TkZxMUkzUHhiUmlNRkFY?=
 =?utf-8?B?OVVjLzNKWGlSLzhlamg4Q3V2cUpTTlVMTW9KcFBCK0lKSk9XdXpnWW4vVzlR?=
 =?utf-8?B?U1gzbUQwcUoyT2VxaDR1M0NMUUUrYzIxb3ArV3FJYUVDS0ZwaEhva2EzdWRR?=
 =?utf-8?B?cEJkUDVMQ3A3UktKTStJSTdmWXNFckFmcGxLZ0poWlRvNjNXNXU3SzVxQkVi?=
 =?utf-8?B?YjR1MmI4ZE15Yk1XaHAwMjdnTDJ1MXdVRUJxNHFOYjZrMUpZc25yT1RMRyt4?=
 =?utf-8?Q?Gf5bey4eAGv1yX2vcXrGuSo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece03203-25a4-41e4-bc9b-08d9e7fcd110
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 16:38:47.7601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TA8qyfKtZLmdE/Dajyk9ZF0YwzylNUDaNbWZwHvRG4JVL3XU84FfDM/m8rzXJnlje+JfmclPx6tz3Ftz0mmN8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1666
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

On 2022-02-03 13:58, Alex Deucher wrote:
> Fixes hangs on driver load on DCN 2.0 parts.
> 
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=215511
> Fixes: ee2698cf79cc ("drm/amd/display: Changed pipe split policy to allow for multi-display pipe split")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index fcf388b509db..d9b3f449bf9b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -1069,7 +1069,7 @@ static const struct dc_debug_options debug_defaults_drv = {
>  		.timing_trace = false,
>  		.clock_trace = true,
>  		.disable_pplib_clock_request = true,
> -		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
> +		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
>  		.force_single_disp_pipe_split = false,
>  		.disable_dcc = DCC_ENABLE,
>  		.vsr_support = true,

