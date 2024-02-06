Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB22C4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 17:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D7510FB38;
	Tue,  6 Feb 2024 17:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U05K6GdG";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFB0610FB38
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 17:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgeKeVVvZFGl9HdNDlgq3RrjQCavaREHsgurjdxEVLzYtqVWZE5pTMcvZqVlNLIoDIZDRMy24b+PAH/4qZGbRqE771Shuy7lqpvgU4rq7WqNwuPkyL85IG5KxCyxzW81cAAhrz2fcjFOHwiGVtU4ktbYhJzaX7OtlVE7dEIyv060veyDZLgtzq0RGz2TaI7Prnxli1XWj3AjfoELVVYpIrF0QOJG11zH/V4eDOHYqODWZZbIVL0PRG3P9UXfQyjBZ/zby3QyUhge6LP/72b/Hq4aqFRWWGzWQBaR9iAK/IBPPawQ/jXV+GsDp+l0zLCdTiUdYZ6O6kXEGaHyiXQfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ni9EqN1J2oOQr5s4uZ/utYR9/bnJ05Z8V3/iqJbHRI0=;
 b=XsUGoOcO/7cZoB0IXfMofQQUdy7XLY3S/XKgYrL9ZYcqokclEaB1TlcGH9wMpAF2b6xbzzWD/mCGjBN+D58VJjhLd942XENWbhZF220tSHjpXdYqLcFNyHvTmOX1GAmrgTJgicCosvKzqa070eB7MUP3TUFtNzUYJPO07J/hptIlSDvD/ebrd87U1MulxFAVIbLGGJv16UVAqeZEgQMXppPfY3uJwZ0mr2VE4lYsHbrjnTn59eNUs5EIJp8GeFCVC/spDvNVYNPdoPCyJIK5bwfUfaDlZqXGxcEh3zGWkahBQT6ulTOjmG7u/BXRPuAY2xu6qYMhNCWwbcbPDpws3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni9EqN1J2oOQr5s4uZ/utYR9/bnJ05Z8V3/iqJbHRI0=;
 b=U05K6GdGKwj1PnAB0dKCvImGA69XEIJXApbJeQn4wJSvT6SS3REMHmMNXLK9tuzK4LzEtMt3LowXflMeNRUa6U4HpDb4Yw93VWz6/04LWffHR9AlJNayDLiUSWVYA2f28HWK1WgSd4LLVNgeAUAPYJnnp3e2sfgDt7nhTxhxZlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.17; Tue, 6 Feb 2024 17:02:17 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3f6b:792d:4233:f994]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3f6b:792d:4233:f994%6]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 17:02:16 +0000
Message-ID: <b96a8a16-832b-4b77-be8a-7512e4858ee1@amd.com>
Date: Tue, 6 Feb 2024 12:02:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Clear phantom stream count and plane
 count
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240203003059.1333-1-mario.limonciello@amd.com>
 <BL1PR12MB5144A6B5116757AD3D053F09F7472@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <BL1PR12MB5144A6B5116757AD3D053F09F7472@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::16) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DS7PR12MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bc0193-d17a-4eee-ddc7-08dc27355f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kh//VOUqdyNecOBWlMRCKIP4v9MVTD+5fxdiOBodLma7vUKni+rqQn/dxmYy5/WqBLSCb1E4790PH2bkBjtJkiV3wZpXxBwFt+lMs0Kc4Hg/dxsliDLIlbyD/wZSgkoXPZ8bw4sN7Pybt6vc19kVT8MivmtIlmvaKqypztLvP2w5NyRjYqoD5lKLqB9DimWHOW4Hcf44SgE0zFtm3/8QcVYJR5FEK1N2fj/m3jAU00FXj/p/PZARdh37LpKCNoEOFbVaKZUGoTN7vE05qcAmPy9sX58DRP9RoLUNspT0LxT7ViLSZjmU8hGOqC28+umVVb+Ksaj8s6HjBtg3J37ALcdFnjRPtsAj+YAn+PcBMv+fYZze0wlsi4sSHWsrtW3misWo4EcTC3Llv4CqzgVz9e/U0nE5v94qChQjzSQQEGMNECajD8nf7KLHi4/agQqqLdeZbS2nPw9R/h6LueDaZvdWFa/JhTgyuqJ5QjlagpnAys96+b4dIby/iNcNzaR/yLC2usp0RIOtOF2yy48M9tRXdrqgzq6MzRq5T8lQstoLubnDskfpO68HNxQ20XqUhLpQYeA4Y35D2k7/TbkeyYa0N8Srrtx6tU/zO7FiUbFqRNsO8oy9g7Mz2AA/IC4qLm7y9wMmZ7sI00HYwqOKrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(39860400002)(376002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(36756003)(6486002)(6506007)(2616005)(26005)(478600001)(8936002)(110136005)(8676002)(38100700002)(66556008)(2906002)(316002)(5660300002)(6666004)(66476007)(66946007)(44832011)(6512007)(31696002)(86362001)(53546011)(41300700001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDJjUHdwS2JBQ1pZRGl5SzRMVU5JTzJqTW5YdGZrNXdNY3J6R1VtTEJ6S1Q1?=
 =?utf-8?B?dEcwWEVUaVFTOHpmMlFQaVhwbGdXVllsWkV4ZllPU1NRSHRQS1QvZ3BwZ3FF?=
 =?utf-8?B?R3haeXd5TWhLMlA3c1VVUzlzOXRIT2tMQnZmbGkxVkQ4NDNpNk9hQzVOSEh6?=
 =?utf-8?B?NTRIcG85dU50YzlzTnFENWlMVFFqWmV5UDdVdUVIVUJleTRFWk5kUG50MnU1?=
 =?utf-8?B?RHhlUGZNVGFLazhHNzBQTGc0UnNRUGozYVFMOWl1SWplTFc4eHhoODVFV0JG?=
 =?utf-8?B?bTYwRnFjNVIrTGJRWDVsTy8yVDNXYUt5QVRhRmFlK004TXB1Vnk4bDNjQ0dV?=
 =?utf-8?B?RWtVUzdpdVlrbDNpOTQ3YndvZmRRRENRbG92cnZYRnJzRVpEblVRTndVZkpV?=
 =?utf-8?B?WUZOMVhPemhYc0thcHZCNzVhY0w2L1poNUtqZHN6VnVxdFBkY001OE1nN3JZ?=
 =?utf-8?B?ZDJwOW1lUkZRWE0rcVNzUkI3dVd1SDdDYU1nTlAxM1E1eU53MVZCWnBrNUlm?=
 =?utf-8?B?RDVZeDNRT3BtRU1HMXB6K0luREFranYvdDcvcDUyc3dBWGtoQ0gyOWh2dUs0?=
 =?utf-8?B?N3ByY0s4eGtpRkFFdWpqWE5wSzlJUWJhNURONUM1NWZGU1JxbEVmS1o4Zmpx?=
 =?utf-8?B?RWs4eUlYTEJ0cWhFd3BJcmJyaDhlYVlLOXRQWEtTb0pzVFpBMjVhWkptYXJX?=
 =?utf-8?B?Qzd2SzdBOFFOdWR0alFpV2lEbDI2WFFzbWlqSlk0dVZZTDFab1VlN2VwOThq?=
 =?utf-8?B?bEh2bmkzV1Y1aHU0MG5yWEoxdXlrMnd2WFJ2blkzR1ZXZ0Znek1iclpxa1lP?=
 =?utf-8?B?ekZVcStTdW56cmVOakt6U2xjaDFoQTlOSWlMUVptdnFHZ0cxSDByL2ZRZ2N2?=
 =?utf-8?B?SURtNWVhM00xNXlUKzdOc0xWcHc2SzcxMzQwMW1pMktXdDgySUJJRUJSeDNx?=
 =?utf-8?B?cCt2NDN4d3ZVSm1heThUQmY5L2x0NzIvTy83REVYTWVJdGdJdEtrU3h4andW?=
 =?utf-8?B?MC9XblpId2gzREhIT3g2M2dxUTRVcmN1c3NhZzRsL3MxTmZuOEM3Q3NROEpk?=
 =?utf-8?B?ODVhejJJQzF0ek03N1BJU0lvcDl1cWJaaDRQSXY4NGU4dWEzSTRIVzVpSnR4?=
 =?utf-8?B?NUpnQTJ4VFJxZHFQaDFIM3V2TXpaSDRpN2RtY1FQeisvUkVUcWpjcnozUTdj?=
 =?utf-8?B?U01QK2YxSzJNaWVFUkpucUhxWEQ1S3dscnlKY3IzM1NEbnZXZnJ0Z25VNThv?=
 =?utf-8?B?VmhoRVNFeDBBWUlnZDhUR3RRTnc5U3dHcUdQQmwrZjFDaFdDck9mMk1weVJW?=
 =?utf-8?B?cS8zQk5RdmVZK3Nlc2R1elU0U2w0a2RjaVNUWVQzK0lFeHA3elJVZ1FuT2ZK?=
 =?utf-8?B?dzV4VWhMQmRuTm92REdqd2IvM0pPZHBoQXoxQnZxUVN2bTh6REN0ZnNUdkdl?=
 =?utf-8?B?WU1iZWVTYVhPcGZQZGovN1NDcXlQT3RSZ1hMNXlWWFNKV2MxWVVFVFBSVDZG?=
 =?utf-8?B?RzVJb0xmNDhEQVRWTWJtL2xIQkxoeCthT2k2UVdFV0hTclhEdGlnb0JHRGJ3?=
 =?utf-8?B?Nk5vK1VFUDdHZlR0YUc0UWhQRUJtS3BIRzZGMG01RHAvM2psaEM2ZFBMZC93?=
 =?utf-8?B?Zzh1WWFYcmgvNmptVmJkM0JKbEx4VjU0TGVZRjlLNGl0R0dmNVVYTmhRckZS?=
 =?utf-8?B?RWRIREJVdXBZWXRTbFlXVWRRbzRqMTBEdEJWY2R6Y1BLbC91SnVLTXoxRnRa?=
 =?utf-8?B?Wm9SUzR4TGlFOEFwbmg1Q3RoTEUrM0FuK2VjSGJaOFB0NFMxR0ZXcWpNRCs2?=
 =?utf-8?B?dkVuM1BybXJTZTRTdTIwaGRPancxUWtvZFoyWXlSWmw1bi94NzBmY2k0NU5K?=
 =?utf-8?B?UjZreHZhaE5nUmthcTNmV2F1VmlLUktPZDhpdWlqc3JlMStYbFF3Z3BXaU9q?=
 =?utf-8?B?RFpJajVXWFJQQlljY2ZQK1E4Z3FlOUFnUTJhZXlwL2xPWEVIYnFCV21RdndB?=
 =?utf-8?B?MnRRajUvcXU3SkhxcU4ybTdBeGpoc0tUVDVsQzF1NFNXakQ0RUkwTVlSM1Rx?=
 =?utf-8?B?UzBKMW9TaWlOYmg4bmdHcm83M3dUa2VzeGpCQytuZjcyYzFSUVRMcWJ2VGQ4?=
 =?utf-8?Q?dcw28Co2P8DZo5yq/JaGOYPQJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bc0193-d17a-4eee-ddc7-08dc27355f0a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 17:02:16.5489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7aWoQgFY9VzL7nchVs6QbwhFUHBXMSTJt6hd4Upwp3LsC3tbkHPUlZMpUmo293Gmw7qyTEyvNjuSeuZU4BoJJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8084
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



On 2024-02-05 08:54, Deucher, Alexander wrote:
> [Public]
> 
> 
> [Public]
> 
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Limonciello <mario.limonciello@amd.com>
> *Sent:* Friday, February 2, 2024 7:30 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Limonciello, Mario <Mario.Limonciello@amd.com>
> *Subject:* [PATCH] drm/amd/display: Clear phantom stream count and plane count
>  
> When dc_state_destruct() was refactored the new phantom_stream_count
> and phantom_plane_count members weren't cleared.
> 
> Fixes: 012a04b1d6af ("drm/amd/display: Refactor phantom resource allocation")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_state.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> index 88c6436b28b6..180ac47868c2 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
> @@ -291,11 +291,14 @@ void dc_state_destruct(struct dc_state *state)
>                  dc_stream_release(state->phantom_streams[i]);
>                  state->phantom_streams[i] = NULL;
>          }
> +       state->phantom_stream_count = 0;
>  
>          for (i = 0; i < state->phantom_plane_count; i++) {
>                  dc_plane_state_release(state->phantom_planes[i]);
>                  state->phantom_planes[i] = NULL;
>          }
> +       state->phantom_plane_count = 0;
> +
>          state->stream_mask = 0;
>          memset(&state->res_ctx, 0, sizeof(state->res_ctx));
>          memset(&state->pp_display_cfg, 0, sizeof(state->pp_display_cfg));
> -- 
> 2.34.1
> 

