Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD47C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 22:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 533B810E049;
	Tue, 11 Oct 2022 22:08:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3036610E049
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 22:08:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T84w6aTwNQ+n8ZUViTrsFwwSzaiJfepu1ytwq2w4xFJ3GAMumZzRgLdiJzyPeZ8A21aPKSQ453SdT34endHGgrKZoBZGDtdKDYiKYX80NIZeQqXYGrabdKsSX7MzII3cpInQfQuruw6fPaTAyFY99g+YwNkrgETM/yJMJ8GMOdGhbfZAbW7EHMwxtoouwQWQV1Xnq9ai1c21CKFuufMaiFmFCauzG0o+/5iFbqtfBfzApM2rBzZczyEmbIVQD6QQpa+1NuIEim1hnDNreI9UVLTJghXgeIqMVrSlKZML5qufIVYZ2zm4bm3RuYgYv1mloEAAV/z902m2niAPfk9SGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUFLDrXZ0Ml8XafX1vIIzvU7m6IrCmsq2MXfqHqnGOk=;
 b=bhSzrI5TGlhlMPHkH9vGjxC9jMKYlYOHTBYuFO6NY/xXj86lbv6A7e80O+6rmGGAUjHAB20Aq1c1nZuzLKaOW+NfQoQxKyhbxI6yOLDrmx/gBrkVB9xFJ3QS+eeTI+6Vsz6+zuo23N45OpYMV4w07bkbT+k8/EY69TOBYaPVXkEgr7sn8HXuHC+psdn+XYmQw78dK/8ELWTs2kAcihhIMqdY2O9gZGabYWj5ZWC4NapeP8llN/I6VGLcWySYpbuT4y/0f4xM7Z2tzby2lao6bQGUwXctPK+qKfEK0Gtl99PSEfPHD0N0R7sl8QtkKgIn+Y2pJzfrpHcCLXyMRig4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUFLDrXZ0Ml8XafX1vIIzvU7m6IrCmsq2MXfqHqnGOk=;
 b=ANbDnR4mYEgtq+xuL3TZy1bENookiBOUmn6kJRJ9+BkWLLkVBJEm/raKRElIrsoQcSJg/A0hIL5Zipqhb6ClfZ913vTWOTRsPxXlPH8g7R28nW7MKOWsioa0yua7zrAjkYNSBBPBDvtVidUtUcNMZzh6FbbpESaJY/JtpFxaaHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 22:08:13 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395%6]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 22:08:13 +0000
Message-ID: <2ed258e5-8b6f-930b-e48a-a4222dee1154@amd.com>
Date: Tue, 11 Oct 2022 18:08:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 2/3] drm/amd/display: Enable new commit sequence only for
 DCN32x
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221011181140.94595-1-Rodrigo.Siqueira@amd.com>
 <20221011181140.94595-3-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20221011181140.94595-3-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::28) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|BL1PR12MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a12cbd-13ca-44b2-7d5a-08daabd51713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83tXGkHLXoCu/jdI65guAeN6QNiDhAfF0dDTbME5p+iIce314LhbYPYP0MtTS/oKBYJRryipyZ+2Bt5plO3AuWk9gFm9fHmYYAWjmTE/cKiDkqObTT8aFtVTnLebUER8k64eWwQ343dgU2RTeqFZPIptrpf6mOjo4XV09De4qG6KhrVuuhHEx1WBOE1NnBfO8fYJfkDYG93U0E9hzNPo8zbeUJZEs3yWqywjUT2GB0IsqfffiLszbBNLVlizDHJZHtqFbu8M1pT6e2TBsiawfgyzMURoqCsObW6pZFhNQCxg5O7t6oyY4LtU+6fg3N6WkBPQMQniS0GHQUR9TR+buicZ4uoJETA5pbqbFkWk8srOZbf8kI3XMBLM1MneAF0KlkYzf8GKOUt23Kf6frjDQr5Vd3brEq5zbO5c0n5H2p+7NJpxK164cR6zMkaGAK3jwIr6NgoGZ0vB6onEulDHKDf9aw6/RG0L1LJLXpNB1UR+C+fg6c/kbVXt8Ro/VD7HT1PGICRLkL0GT9dYxWk2R1JPOyvQUJTQniY57qVPq4d1AgVC9mkuhWfc0O6xs4+zJCk3zPXMX+X2ig6IZGgeiHsn4E7XN2wKTxLR3idaLfwc2quwCcKq6hoUHwsNTZlZeV0nW+mP7a2ZE3FPUlcjR9PHDEYnU/OGLbz3cqIfhVZjci+V+v1q7mhw8C9RJ7TSsVvSP6WzkkwXxfOfEUTLpPUj9DG8lEoy+Y7SMwaDbBkSEcReQloK9IY+F+lizF8JwUlEzD4GJmHO4sqT8iMEmrpYBtXtya+qlorXeTiN1WE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199015)(31696002)(31686004)(38100700002)(36756003)(86362001)(2906002)(186003)(83380400001)(5660300002)(44832011)(2616005)(6512007)(66556008)(26005)(53546011)(6506007)(8676002)(66946007)(66476007)(4326008)(54906003)(4001150100001)(41300700001)(316002)(478600001)(8936002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGVKbzVTelpVZ3FBSGZhRWxLdy9qMW9lUnJES20rZnNIQmdJK21Ha2U3QU5T?=
 =?utf-8?B?THVNQk5GclNsajZuL1hzZm4yQm84OEpJcmZkc0FQQVZiWm02ay8yd1FyWlc5?=
 =?utf-8?B?dC9JdHc4Y2dpK01KNGZ1Um1YN3VEOGV0L2laempZOTBBK25JbGsyTGxtYkpa?=
 =?utf-8?B?TXk4anVWaFA1MVFPb1dHb3B5bW9iNnI0MEZNUk03eDBNY1dleEgyWUFSR0Iy?=
 =?utf-8?B?YlNYc1IvaEpobmRLWTdsLzhvSkxHVHA4SEx5RnNKVDlYR0VLeEFaK2ZjelZ3?=
 =?utf-8?B?RFFidFBQZ25xUktNK01NUEZNOWtBQ1NZU0FCei9vT1ZYd1Fud0pQUVQ0VHh0?=
 =?utf-8?B?ZWkweml6dmt6ZlNvSklGdlBnd0ptOXJJTWpFVTFQd0xCdVAzTnloT2tCNURB?=
 =?utf-8?B?c243ZGtxb3phV3NobXhVbVh6cDlBc2dIbkpYTGpIQWZYT3ZiNUljZGlKd2w2?=
 =?utf-8?B?NWVkS1oxWnI2M3FYNjlrWG9YR2VnQzBRRmViOEVjalZZbFdpQmFNRnI0L2Z4?=
 =?utf-8?B?RkpWQnRubnJrL25pTHIvVEVCeFc0MU5uNFY0Tjc2VklnWm9vamlXUGxTUm9Z?=
 =?utf-8?B?OVJOZVNDZ0JGSkVUbi9tVk1iaXlORFNaeWlEbllpYWo4cklWVTB1blNpMEd0?=
 =?utf-8?B?VENLb2pMdkthTWZrbThhUk95b25MOXMwWVdzdEJ4ZlBrUm5ycitycW53QnFV?=
 =?utf-8?B?RURWMzFIenJjaWZaYVZETWtYd2ZQY3poRzkzTW0xbkE5ZDdObWRIQjI0L1Vj?=
 =?utf-8?B?NDUrL2RqWU9sdjNoQlBjcndveVViVWxGeS9rY0VOa2tVNzdPNFVSbTBETHph?=
 =?utf-8?B?UXN0RjAxU3U4YTd2dEp3VVRwQ1JpM3BMbEo4OHdPbHhPMllaVEg1ejFGaVdR?=
 =?utf-8?B?SlJOOWtlWXEweVRvcmFVVTRmeW8zYW1Qc0JEZkx1QitDTTBDQ2syS0Nmc2U5?=
 =?utf-8?B?SE5NSzNwbUJGc3Myb244cm5sSEhhdzJvc1ZvSGJhazBtR1lIcWhveEJ1TWZI?=
 =?utf-8?B?T3pyU1VEYnV6RVBiVkhYbk5aWUFjam5GYkV4bXRhUUl1Mi9DdTNKOE05T3NZ?=
 =?utf-8?B?S05QSHJkd1RnajVQMTViYlNXbTVDS3Azb2pibit5Wk11ZW1GVmxFWlIwcTZn?=
 =?utf-8?B?MThvQlgrSFNmYnVJRTVsaTZDbEQrRWRnZzhycnQ1OW1UdnhHdWNhZjc3QTQy?=
 =?utf-8?B?ZGlwWnlyKzhHc3VVdnNaYWV3Y1NGb2VNbnN0YlBXSFdTQXlpN2FOTFZkZWxC?=
 =?utf-8?B?OGk5ekVFcEpsVTQ0M1lnMWVrZ3J1QStKUitrMzBxeTZ2MkhaSm9QSlJZVnpQ?=
 =?utf-8?B?MFlyUkR0NEpjMjlNWEJsUEZpT2hnVGdia2t0REx1QWlZRlNZNGpwRnNoZFUz?=
 =?utf-8?B?dTk4akExYVIrNWozMWVBYUxSMmNSOXZ1TGIwTTgxbE5LdWU0U3FKMlF0Q3Jr?=
 =?utf-8?B?UWZGZnpQbjljdms5OFg4UE9jczlNdTBrZHpOb1ZhWkRTU1dSVDhoVGJrYlRP?=
 =?utf-8?B?cUEzdElJN1ViRWI0eVFnQkxRZHdHbC9IQnNaWmRwR1cvTWRhRlRaS05LQkFy?=
 =?utf-8?B?TVRFTEFNRFNZTHU0OXFFeUtQaGkyQys0ZEJ5MEdZY3BZa2x5ZHBkQ2J5MnB1?=
 =?utf-8?B?ZmEwUTR1MWM1V3ZQZjUyY0hVeGcyOGo3bnlGamY0NHNhSElBK0pyeHpjbE1E?=
 =?utf-8?B?RWtLWFdFYmUrY3ZQSTNlRW9kMWd6eWU4U1EraU9rRDNFSS95dVJmUXFWeG04?=
 =?utf-8?B?TE44NlhydHZGVzBLbGFISXIyd2c3Z0VuRlJYS2tZa3hpUzVLMGdvRUtzWlR3?=
 =?utf-8?B?M0xaOExqR0hhdDFIYkU3SE9JWTJwd0ZIZ0V5YTREd2JqcitVc0FjSmVMcTdT?=
 =?utf-8?B?bVRmYXF1LzE1cU1oaDBGRDFodmFKUElqVmFoVFYvc3I5VW85R0kySm9tVWJk?=
 =?utf-8?B?L1RySzBXZ2YzNFdPMUNVT1FZMzU3bVpSQ3ZlWW1Ualpmd3IyY2JwYm4wT3Va?=
 =?utf-8?B?aTZTS2ZwbG5ONi85RDBJZGVidGZwQlJvZ2VSaEQ3YnkyTmhya3JTbjVReVli?=
 =?utf-8?B?QkVDQ0E4U0ZKSTdBZ05HSmk3WTRqZkUwQlRMbnJFOHVFUDBndldVRjB2WTBJ?=
 =?utf-8?Q?hO2Ock/Po2xojc/sqwVRqNlkP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a12cbd-13ca-44b2-7d5a-08daabd51713
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 22:08:13.0665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NciCLiglL605dyxRiVKZsbT2lTy/7fs1ImI2dtIiIgp1ewgXxApO79xvUgjtTPfleV2awRKnQDpU4hj4pax1LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-10-11 14:11, Rodrigo Siqueira wrote:
> Change commit sequence might impact multiple ASICs; for this reason, it
> is better to run it only on DCN32x for the first set of validation.
> After we get more confident about this change, we should expand it to
> all ASICs.
> 
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index ad3aafb73cba..21d20900cfe3 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1913,6 +1913,13 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context)
>  	enum dc_status result = DC_ERROR_UNEXPECTED;
>  	int i;
>  
> +	/* TODO: Enable the new commit sequence for all ASICs */
> +	if (dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_0 ||
> +	    dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_1) {

Why not check that dc_ctx->dce_version == DCN_VERSION_3_2?

I don't like using the family ID in DC unless we have a good
reason to.

> +		result = dc_commit_streams(dc, context->streams, context->stream_count);

Wasn't this function initially intended as a crutch for other OSes
that couldn't use dc_commit_state directly for some reasons?

I'm not sure this change is moving into the right direction, at least
not without a much more detailed explanation of why dc_commit_streams
and dc_update_planes_and_streams are the better solution.

Harry

> +		return result == DC_OK;
> +	}
> +
>  	if (!context_changed(dc, context))
>  		return DC_OK;
>  
> @@ -3898,6 +3905,15 @@ void dc_commit_updates_for_stream(struct dc *dc,
>  	struct dc_context *dc_ctx = dc->ctx;
>  	int i, j;
>  
> +	/* TODO: Enable the new commit sequence for all ASICs */
> +	if (dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_0 ||
> +	    dc->ctx->asic_id.chip_family == AMDGPU_FAMILY_GC_11_0_1) {
> +		dc_update_planes_and_stream(dc, srf_updates,
> +					    surface_count, stream,
> +					    stream_update);
> +		return;
> +	}
> +
>  	stream_status = dc_stream_get_status(stream);
>  	context = dc->current_state;
>  

