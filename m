Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C420C25B74
	for <amd-gfx@archiver.kernel.org>; Mon, 27 May 2024 14:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B70810F576;
	Mon, 27 May 2024 14:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ua9YGLm9";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71CB010F576
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 May 2024 14:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/rsupPlHbqzhucmrkmwUqe3aOGngjGbaHYmdvkvX7+bCBFGX/RM8VhS1N7vC3s6VonNkTJENFbQV1ZaNJJQCFGQJuUvXJZE7x2+8+B7gQTI3snAmef6FbQOea3EU2TZxs8NpyL9kTRQwyxLiG8qBKEGNDwRlPSaz8tP2oekvdhrHR37U8pasB/DqxLBpCre3u0uc92tXRXGylrdJR4io8ZKKo18+Sxz2iYTwAskOqyJhf41z1efWFWpZPZSOr29LSgJvfIVd3jHEo+5cngZobBKUxSplkSIiW2r4qmihS+PjPmVal5hV+PWGLvP13nJIS/LiQ3uU6lP5oA18pT3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJGdnJzp4Ylv3kk/6mozt+ndPgyvLIagRYFBgPEWc4g=;
 b=nnWjz5qOTbjr2ocSZBo4EfWxH6TPrKQao6cEJW+0ZPNc1S4aF7YQ4umLcWuT4+5WZbFEluYewgglkpRKKZk0tgMqG7O1EChcHs7uvFQJ0ql/rZvjl9+rOpjftlZ7jH9mxL03kwQnMS2+Dc2GwJnBmxpFyBt3GoH52PmKNXk2wdqY0ZKgJ3yUbVT6y5L9KajIq9YE5ezlZ1Fd2l8ZtFtiBqhrPHeBKw50miuPPwX5fRcic0TI6mND4EREHTmYKCUjRaQ7erMN3Rgi3qVGkj3xsBoVj5SfXZEyjU/MDyUieckE7Fo/fMysw2IWHy/bXDoD6HyrUUfw+QKfnZhHGnnUIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJGdnJzp4Ylv3kk/6mozt+ndPgyvLIagRYFBgPEWc4g=;
 b=ua9YGLm9Dml5qlCkl75nieU010ukgRV4ivbvhMzbp0lOVEn2ThFT/xbWynmdxzkYGsM8P/E6Ld3BUZO7Q4KhWIgQugVMucwRAjaxCGEtQug0cuu4cNJUW9pWSZZbA1NmV6MqK51lyIYg/9xAaz9rLhg8FT7EB3t4+T5ldqxYfZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 14:50:12 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%6]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 14:50:12 +0000
Message-ID: <73312a60-049f-47b6-980d-6018681a8470@amd.com>
Date: Mon, 27 May 2024 10:50:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] drm/amd/display: Enable copying of bounding box
 data from VBIOS DMUB
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com
References: <20240523192027.50630-1-aurabindo.pillai@amd.com>
 <20240523192027.50630-13-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240523192027.50630-13-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0386.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::7) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: f5dc53e2-439e-4c22-2f20-08dc7e5c4ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODd2empqZ0cwUHB4VFdRM296a0pLam5JVDIra1Z5UDRycWpPMU9BbThJOWJn?=
 =?utf-8?B?QWFXelR5cFVJRnZaRHRVUXRHSElrYmZSM3RhVmloaUN4dDNrcW5BaHdMNVVQ?=
 =?utf-8?B?bTAvRmhURlppSm9IZDRFVENnOEZQdWVFRjY0UFArWGFONW9IbVFJQnIvdGdE?=
 =?utf-8?B?V0V1WFJtNFhtcFdzN2dMWURHUU5uaFFvckd0VEN3TjFyQjFHTG12b0dqQ1JV?=
 =?utf-8?B?UlRNVTFJUDVzVWZCaUFEdEhtV1pmUDZwZHdHcGJicTVydFBFQmJXMkZUZTBI?=
 =?utf-8?B?bkdZeXcwS2NEQzNDMjFkOWEzUzZHUHRPNi90MkFBRkpuSWl3dkVmQWpnSUlu?=
 =?utf-8?B?dXkwQmhDTjl4TWpLQ05FYVJQeFNLMk95SitEVmFEUW85ZWhYSjZpM1o4UTVx?=
 =?utf-8?B?Z1pxby9zQklZaHlWdmh4VG9NVjUyeWN4eVpWbjBPR2RDZTRVYzFaM2VrU1hI?=
 =?utf-8?B?bm1KS294U1Z5MWZrbjNEbXhCaEJ5SHNQU1UzeVJiRXZOZXdMRW5Kd0JlVEp4?=
 =?utf-8?B?T2JzTmQ2cytibi95cFJjZHJxdUJsdlVOZTFELzZqOXBoWFdybDNGYlhVZ1NI?=
 =?utf-8?B?ejkwakM0Y1V2cU12MkZPYUROYkVWMkFrbjZlQXFpNUF5K09pWDl2VXRTWFFY?=
 =?utf-8?B?Q1U2UTVYaVE3VCtaRHRZVTlZQ2NMb1Y4Q1pON3UxMXNjKyt2N1ZFMEFtVXlH?=
 =?utf-8?B?TkdGelp4SFlYWnkyYmg3WWJ3QytkV0Z5SUt3SFljVXI1NGgrcFdDTkkycWF1?=
 =?utf-8?B?aERDRVhhSzRmaU92NldpR0VNMmI5aHJmcGgvZjNvdW9wNXpOTlR4QzNxTVNq?=
 =?utf-8?B?ZEhuNkloVVdQZzh3QjJGUGJROWZ2SUl4S3dIRVhMRnJ2Ulh5SGFKVjZxdXIy?=
 =?utf-8?B?cE8rOVVFL1Z0eXhGb2VaK2ZodXJ1OHBrYmppV3l2M0pIVDM4M1VTRVZWSGZn?=
 =?utf-8?B?b2o1T2VvbndIOVp5QUF3dmRJLzR1TUd5cjhTR3BjTzBDRm55WjlqVDIxaTVs?=
 =?utf-8?B?Q2hZSXZ0alVlMVdKT0JYNElNNXF2VXBHVTM0cE96aktBVHdHdGU2MDhOQ1V2?=
 =?utf-8?B?ZWlMcWNCeE0rNEpxRUVrb0dJUE9KOXFYcmRrbFpMZFh5akFmWDNROHFvYTRS?=
 =?utf-8?B?dk5OWEE4ZVVJeGxpMHBqU0EvUzM2K1ZEWUhoU0ZBWU1hL0FkRVo5ZUhib0ZZ?=
 =?utf-8?B?aGRtSWVpUkgxeXVnZ2o4QWJlOUZGcS9VSGh5Yk0wcjJtYjZ1TGZrUVdFWDlT?=
 =?utf-8?B?YnVHTngyVjhUdXFueHBvUUlLakxDb1pnWU1rSDd5aW5pdTVYdFFoUkpST3Fx?=
 =?utf-8?B?L1N0L1dIazcyRk9NSk5SSkdvMTZYUjN3elVtYzZ5anFScTVzL1o2empoK1Qv?=
 =?utf-8?B?UzV1aFpXMXRxdG1OSE1qdXF0ZlhUclVTNDkwejkreVcyeXU3aDh6YWZsUzRu?=
 =?utf-8?B?NmtYbkVVYisvN2FIQVhHYmVuUnZEc1lHT09oelBVMUR5Q05GSjhnMUdLQWZ0?=
 =?utf-8?B?dlR1UnRva0pnc0tmUnpIbXR2c2UwbUdSZnNLWGk5ckJhSW8xeGMvbGZManNx?=
 =?utf-8?B?LzhtdnRiQzJJUGRqS2xkNDVRNHRjbThuc2NvM3dKTjVHUTRtallxVmF6VnBX?=
 =?utf-8?B?Q1pJZk9McGpISlpMK3B5MXhaa3UvR1FMTVI2V3RZakhONExDUmdVc2x3Y2VD?=
 =?utf-8?B?RU1aR1VKWjVzU203VVpxaGxNajFodUVNYXlBUnBReXJ6d1F0S1l0S21BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU9vRVNmMGt4dmxPRG55VFRPN3dEVUdncVk0THVFVUVtY0VNdkFTZE5GUmNn?=
 =?utf-8?B?aWtBaXY2ejhWQ1hFMEFPa2lYM0FEMk9FemhxRC9EeVdWbXBSNHJlT21PYk5h?=
 =?utf-8?B?KytDblRFdTJGdFF1eDhnSitMNDQyeUFDOGFBU0VYbGVwanptMTZKczM3ZHhN?=
 =?utf-8?B?NWNxVVlxdjhCV2NxRldhK3RXSCtsNUNCUUprZHJLVUdZVXYvTkdXV2xWd3pn?=
 =?utf-8?B?K0FrU3JaOFZwR0s2eGZlaXRLcFFWRHI5L0RhcXZwL2EyN1lHVnpJQURSTGpz?=
 =?utf-8?B?RE5jUjhWbVgxL3RQejJTMnFsdHdJZjF6bEtQL29lWk41ZmJYRjNDZkE4WThw?=
 =?utf-8?B?VHdIMEx6eFhaa29LODR3SjlUR0lZYkZwY09WNjZZYkowTCthTUErWkY5RnVU?=
 =?utf-8?B?ZVEwNG4yb1JpcDc5Qk9jbGRuZzdBcTROMWRvR05Yb205bFFGOVFWOEZpWXZZ?=
 =?utf-8?B?TGNGeGVyK0JCdUFmd0lkSm9CSEJYUzE5UDE3aldEZFdKQW1ZQXZ1eWZkQ2Vi?=
 =?utf-8?B?K052ck9zM1lrd1BIM1FLL25Bc045aW9DMTlxdjVSUWVITGhsZUVNQzlQbTJT?=
 =?utf-8?B?akdRYmNMdXNZTWlaN3J5QTlGVDBzVk15MTdkR0lVSjRreHVaTGtyT1E1TUVI?=
 =?utf-8?B?RXJpMGNkOE9JeTB2UHR6RkJoclZPcWN4SkF2UTNMKzdybXQ0QkJ0bDMwV0wz?=
 =?utf-8?B?NDluYWV1RUJ2U1F3MVlOWTZ2aWVEVzExMlVGL0JOZU9jNFhNZ2w5YXdzK1A1?=
 =?utf-8?B?NWJrSGl6U3BNZXIwRy9BZ252SURFMDRoQkxrdjhkRGFnRUduZ25rUFFva2FK?=
 =?utf-8?B?SG5Db2ptSWNleEhyVzFUODZxenM2cEt4V1ZuOWJpNVdpQTBaa3JENm1PYlNu?=
 =?utf-8?B?U0hveVBGWFFjMWNiUmM2STJuUUV1eWpmbEQ2WFhXTk1UQUpUdDdYTjNBMkxr?=
 =?utf-8?B?T2VDamxNUnpQVkY1bzhJRitJMlhEVi9oUTA4MlNNVzhFNmNubzhzeXc4bXVU?=
 =?utf-8?B?MGw3aXQxMjJkMWltZzNzNWNtV2pKZng4eVZWR0JiT252QzI3M1ZodjBCOWVx?=
 =?utf-8?B?K05PV05nOERKMHJZNXM5UWpmblpDRVlick1zWWVxMjJuV0hpVnNHYVpWek9z?=
 =?utf-8?B?bnF3c2ttVTRBME9rTkxOUDBJcFFWQU4rNkQ1dDNYUTgvK3RoMkVKUGt0T0Qx?=
 =?utf-8?B?UFg5UVROams4NkIwN3NmRm1UR2hMK1RyQkNTenlWRmgrVitZZEp3TU1DQzJ0?=
 =?utf-8?B?aG03cjZWMzlkdWdQTFFjNW5iSzVmWncxWkJYaXpsVDNnbmVBNERlRWVJbjZo?=
 =?utf-8?B?YS84N0VjaEdrT2VKaWtHaTV0Ylp6QXRnNXYzM2RBQmdMZVV4NEJnZFFTUjNn?=
 =?utf-8?B?VmVEcnBRbE1XeWZVNEdDbjVXd0wzSUN1N1JWL3pnMTlYYnJYN0cyYUhkbWZM?=
 =?utf-8?B?ajlEVTY4Nk15eDlweHBnZWJEdmNxWmdSdnc3ZXIwVHpjWVUwSXFkR1ZJVTR0?=
 =?utf-8?B?MndFcElUdERrNG9TQUxEREU1VTk1OFEraWJxNGcrM3h0TXhUdFNYcUNDRDNw?=
 =?utf-8?B?RWd1dGE2WnQ1bWRSTnNwYm53UW51Rng4SVVXZVZCKzJsZ2xoUC8rblkxSSs4?=
 =?utf-8?B?eDNKeUpLdUdjVEhhWFNqU2tIRGlZQlpsWTZOR0R1RzI5azJFNlprUmh1MHV0?=
 =?utf-8?B?cGZwS08xdWcxVmxwa2ZYL1N3dkVETnE4VW1GVW5yQzhDWEJsWDIwZnFsanJt?=
 =?utf-8?B?dGkrbmVtck5qazlGdlVKSjVKbDh0b1UvLzVSS1ZTekF5VVl0Wm5VTXlzU000?=
 =?utf-8?B?dzQzeGxrTktVVnBUakpuMnIwUXRVUlo0ZjczQktvdEJCblNjSTJ1OWlqcFJE?=
 =?utf-8?B?OEdSUVY3L3duWlEwQ0RVR0dQRlBxM3JHUWJoQmVUbmh5bHkzeGFURjRoUmdT?=
 =?utf-8?B?bjhPKzVSRzFaVk1mSGhsb0E5enZpUG5pUDZEMnlKV1lOTlZQcEhWR2FIbUc2?=
 =?utf-8?B?YzFrdS9iampQMEp1L3NFZXJTMEI5Wk1wSjNicFAwMjQ0WXkwVHVHMDNGeE9l?=
 =?utf-8?B?UlN1QUQ0T2tHejJ2ajNmWFN0ZVVGSVVkY1pvVVVDVGhmTDRjYjk0T3RHVndS?=
 =?utf-8?Q?yBM/3uLckPZ2M6cmDveBLWLWV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dc53e2-439e-4c22-2f20-08dc7e5c4ff9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 14:50:12.6306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Q0U29LNkWAiY+fWzLq+Kj63Ol/FlCHpSsnzcxCGULoItSK6gt56f8QJls+OFUR6YO8PuiGvym8AxvPzCHvujg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
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



On 2024-05-23 15:20, Aurabindo Pillai wrote:
> Allocate some memory, send the address in chunks to dmub, and finally
> ask it to copy the bounding box data into the newly allocated memory.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

The entire series is
Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 121 ++++++++++++++++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  10 ++
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  24 +---
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |   5 +
>  drivers/gpu/drm/amd/display/dc/dc.h           |   3 +
>  .../dc/dml2/dml21/dml21_translation_helper.c  |   6 +-
>  .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   1 +
>  7 files changed, 146 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bb4573603479..74accbcaae28 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1627,6 +1627,117 @@ static void retrieve_dmi_info(struct amdgpu_display_manager *dm)
>  	}
>  }
>  
> +void*
> +dm_allocate_gpu_mem(
> +		struct amdgpu_device *adev,
> +		enum dc_gpu_mem_alloc_type type,
> +		size_t size,
> +		long long *addr)
> +{
> +	struct dal_allocation *da;
> +	u32 domain = (type == DC_MEM_ALLOC_TYPE_GART) ?
> +		AMDGPU_GEM_DOMAIN_GTT : AMDGPU_GEM_DOMAIN_VRAM;
> +	int ret;
> +
> +	da = kzalloc(sizeof(struct dal_allocation), GFP_KERNEL);
> +	if (!da)
> +		return NULL;
> +
> +	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +				      domain, &da->bo,
> +				      &da->gpu_addr, &da->cpu_ptr);
> +
> +	*addr = da->gpu_addr;
> +
> +	if (ret) {
> +		kfree(da);
> +		return NULL;
> +	}
> +
> +	/* add da to list in dm */
> +	list_add(&da->list, &adev->dm.da_list);
> +
> +	return da->cpu_ptr;
> +}
> +
> +static enum dmub_status
> +dm_dmub_send_vbios_gpint_command(struct amdgpu_device *adev,
> +				 enum dmub_gpint_command command_code,
> +				 uint16_t param,
> +				 uint32_t timeout_us)
> +{
> +	union dmub_gpint_data_register reg, test;
> +	uint32_t i;
> +
> +	/* Assume that VBIOS DMUB is ready to take commands */
> +
> +	reg.bits.status = 1;
> +	reg.bits.command_code = command_code;
> +	reg.bits.param = param;
> +
> +	cgs_write_register(adev->dm.cgs_device, 0x34c0 + 0x01f8, reg.all);
> +
> +	for (i = 0; i < timeout_us; ++i) {
> +		udelay(1);
> +
> +		/* Check if our GPINT got acked */
> +		reg.bits.status = 0;
> +		test = (union dmub_gpint_data_register)
> +			cgs_read_register(adev->dm.cgs_device, 0x34c0 + 0x01f8);
> +
> +		if (test.all == reg.all)
> +			return DMUB_STATUS_OK;
> +	}
> +
> +	return DMUB_STATUS_TIMEOUT;
> +}
> +
> +static struct dml2_soc_bb *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev)
> +{
> +	struct dml2_soc_bb *bb;
> +	long long addr;
> +	int i = 0;
> +	uint16_t chunk;
> +	enum dmub_gpint_command send_addrs[] = {
> +		DMUB_GPINT__SET_BB_ADDR_WORD0,
> +		DMUB_GPINT__SET_BB_ADDR_WORD1,
> +		DMUB_GPINT__SET_BB_ADDR_WORD2,
> +		DMUB_GPINT__SET_BB_ADDR_WORD3,
> +	};
> +	enum dmub_status ret;
> +
> +	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
> +	case IP_VERSION(4, 0, 1):
> +		break;
> +	default:
> +		return NULL;
> +	}
> +
> +	bb =  dm_allocate_gpu_mem(adev,
> +				  DC_MEM_ALLOC_TYPE_GART,
> +				  sizeof(struct dml2_soc_bb),
> +				  &addr);
> +	if (!bb)
> +		return NULL;
> +
> +	for (i = 0; i < 4; i++) {
> +		/* Extract 16-bit chunk */
> +		chunk = ((uint64_t) addr >> (i * 16)) & 0xFFFF;
> +		/* Send the chunk */
> +		ret = dm_dmub_send_vbios_gpint_command(adev, send_addrs[i], chunk, 30000);
> +		if (ret != DMUB_STATUS_OK)
> +			/* No need to free bb here since it shall be done unconditionally <elsewhere> */
> +			return NULL;
> +	}
> +
> +	/* Now ask DMUB to copy the bb */
> +	ret = dm_dmub_send_vbios_gpint_command(adev, DMUB_GPINT__BB_COPY, 1, 200000);
> +	if (ret != DMUB_STATUS_OK)
> +		return NULL;
> +
> +	return bb;
> +}
> +
>  static int amdgpu_dm_init(struct amdgpu_device *adev)
>  {
>  	struct dc_init_data init_data;
> @@ -1748,6 +1859,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  
>  	retrieve_dmi_info(&adev->dm);
>  
> +	if (adev->dm.bb_from_dmub)
> +		init_data.bb_from_dmub = adev->dm.bb_from_dmub;
> +	else
> +		init_data.bb_from_dmub = NULL;
> +
>  	/* Display Core create. */
>  	adev->dm.dc = dc_create(&init_data);
>  
> @@ -2305,6 +2421,8 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
>  		return -EINVAL;
>  	}
>  
> +	adev->dm.bb_from_dmub = dm_dmub_get_vbios_bounding_box(adev);
> +
>  	return 0;
>  }
>  
> @@ -2334,6 +2452,9 @@ static int dm_sw_fini(void *handle)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
> +	kfree(adev->dm.bb_from_dmub);
> +	adev->dm.bb_from_dmub = NULL;
> +
>  	kfree(adev->dm.dmub_fb_info);
>  	adev->dm.dmub_fb_info = NULL;
>  
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index a01f3f5bf2c0..94fc4c15d2db 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -578,6 +578,11 @@ struct amdgpu_display_manager {
>  	 * Guards access to DPIA AUX
>  	 */
>  	struct mutex dpia_aux_lock;
> +
> +	/*
> +	 * Bounding box data read from dmub during early initialization for DCN4+
> +	 */
> +	struct dml2_soc_bb *bb_from_dmub;
>  };
>  
>  enum dsc_clock_force_state {
> @@ -964,4 +969,9 @@ amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
>  
>  int convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_depth);
>  struct idle_workqueue *idle_create_workqueue(struct amdgpu_device *adev);
> +
> +void *dm_allocate_gpu_mem(struct amdgpu_device *adev,
> +						  enum dc_gpu_mem_alloc_type type,
> +						  size_t size,
> +						  long long *addr);
>  #endif /* __AMDGPU_DM_H__ */
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 6d0f78b9ec0c..8eb2f10f2c38 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -1045,30 +1045,8 @@ void *dm_helpers_allocate_gpu_mem(
>  		long long *addr)
>  {
>  	struct amdgpu_device *adev = ctx->driver_context;
> -	struct dal_allocation *da;
> -	u32 domain = (type == DC_MEM_ALLOC_TYPE_GART) ?
> -		AMDGPU_GEM_DOMAIN_GTT : AMDGPU_GEM_DOMAIN_VRAM;
> -	int ret;
> -
> -	da = kzalloc(sizeof(struct dal_allocation), GFP_KERNEL);
> -	if (!da)
> -		return NULL;
> -
> -	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> -				      domain, &da->bo,
> -				      &da->gpu_addr, &da->cpu_ptr);
> -
> -	*addr = da->gpu_addr;
> -
> -	if (ret) {
> -		kfree(da);
> -		return NULL;
> -	}
> -
> -	/* add da to list in dm */
> -	list_add(&da->list, &adev->dm.da_list);
>  
> -	return da->cpu_ptr;
> +	return dm_allocate_gpu_mem(adev, type, size, addr);
>  }
>  
>  void dm_helpers_free_gpu_mem(
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 3a2101b052ea..1526ab0b4884 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1014,6 +1014,11 @@ static bool dc_construct(struct dc *dc,
>  
>  	dc->dcn_ip = dcn_ip;
>  
> +	if (init_params->bb_from_dmub)
> +		dc->dml2_options.bb_from_dmub = init_params->bb_from_dmub;
> +	else
> +		dc->dml2_options.bb_from_dmub = NULL;
> +
>  	if (!dc_construct_ctx(dc, init_params)) {
>  		dm_error("%s: failed to create ctx\n", __func__);
>  		goto fail;
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index 31e3371b1b2e..d0ed01ac460d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -1067,6 +1067,8 @@ struct dchub_init_data {
>  	bool dchub_info_valid;
>  };
>  
> +struct dml2_soc_bb;
> +
>  struct dc_init_data {
>  	struct hw_asic_id asic_id;
>  	void *driver; /* ctx */
> @@ -1099,6 +1101,7 @@ struct dc_init_data {
>  	uint32_t *dcn_reg_offsets;
>  	uint32_t *nbio_reg_offsets;
>  	uint32_t *clk_reg_offsets;
> +	struct dml2_soc_bb *bb_from_dmub;
>  };
>  
>  struct dc_callback_init {
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
> index 37998f2c0b14..9f641ffdc924 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
> @@ -26,7 +26,11 @@ static void dml21_init_socbb_params(struct dml2_initialize_instance_in_out *dml_
>  		break;
>  	case DCN_VERSION_4_01:
>  	default:
> -		soc_bb = &dml2_socbb_dcn401;
> +		if (config->bb_from_dmub)
> +			soc_bb = config->bb_from_dmub;
> +		else
> +			soc_bb = &dml2_socbb_dcn401;
> +
>  		qos_params = &dml_dcn401_soc_qos_params;
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
> index dcb4e6f4d916..20b3970c0857 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
> @@ -236,6 +236,7 @@ struct dml2_configuration_options {
>  
>  	bool use_clock_dc_limits;
>  	bool gpuvm_enable;
> +	struct dml2_soc_bb *bb_from_dmub;
>  };
>  
>  /*

