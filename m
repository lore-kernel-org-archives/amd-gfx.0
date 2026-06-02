Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01699CD6E5D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 19:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BF3610F54D;
	Tue,  2 Jun 2026 19:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Iomax7pr";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA6F010F54D
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 19:45:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtrwqFcDITBsseiTZw/J64lGKffGKWDanj5h2gcLle007r2UyAz+L9Gi+WFzOMWoC6eJryYPLTQY8liDRfZOTUe4Bus872D9fdQQ7F+Bt1+B5aenXGLU03uD88f0e9AjcJRwFWk+pnH/O8diCauJpUs9RTRfyRRHIQ8LdFg2c4YAuRNFS+besBc7E6JTxnZQwoGJqaSRhVTOBYaeemgV/yYHsxV/fesSLDyIMX1cNrHxcPkSLk8SC3prMKsuNQeemycv/fMD58d8Ug96gYzhgALuIvi7w4rBYaWuSAd//kbqfMbU3JmiJpz9IyhhdPL5yM0L25DoQ48p4uUfhWTdoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3/fFmQhvfmdXKmeqfKQHCBqRNo9/Yml1Lbti9c3MbA=;
 b=XN+HbBnI+ROvE1DT+Q8iZsaEuyo3wVam+9LDYJxTm7sQetJjA1XL7IFbMkuhJoqPx2Gi0XA7H2Fl6sBV3R5U6lSfTNUVz3yeN9mzkSBe6j8EZ/bmU/tqtF4B+mUQrURYF+6Hvfq7j7KFiEic5jUdNMBSXwCz30U2Qlzgb0z31bxcVJYo+6Q4UAXdHaCmWEBV2aVzSr9KqVET2IZuMn2+2yd7Mp5XJ7bgfX3YX/CR88E+We2BBXE0/sBpcvjJ9Q7o6mY60NAEVhsGVCVWUni5qRkMRXvj1GHSHPtYjC+5Ad08GN4zXiVqppmMsjMRPPD+wc8TPkQ51IgcuAkwmX+CEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3/fFmQhvfmdXKmeqfKQHCBqRNo9/Yml1Lbti9c3MbA=;
 b=Iomax7prJcoauBpO493V21PuTNg3EyPKiVtsNJR50nWdRMKvcET7QeRk9UCuQC/YCjtgzESDcOhpEHK0AzoUVWfP3oCK+FPOkxPMtVrXh14mDNywG39x1vV3ofafRanh+J2NDycJwSmMs5dyaYmVeX44+5AEM4/wtfdVLDtoWkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Tue, 2 Jun 2026
 19:45:38 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 19:45:38 +0000
Message-ID: <297dc8ae-578f-490c-9c42-17fe9cf0b4cc@amd.com>
Date: Tue, 2 Jun 2026 13:45:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/display: use unsigned types for local pipe
 and REG_GET counters
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, harry.wentland@amd.com,
 sunpeng.li@amd.com, alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260602192152.4173277-1-aurabindo.pillai@amd.com>
 <20260602192152.4173277-2-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260602192152.4173277-2-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0133.namprd04.prod.outlook.com
 (2603:10b6:303:84::18) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f83b55-521d-4075-3461-08dec0df8584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|11063799006|4143699003|3023799007|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: sInlJM6MRoB8mWWNuUd1vEWhiNNxa563a+iiSRSPAfMWAfYeV1HfNsCbWBCL+ukKlPhbEKm+BKkjSvGNiHodAnLDLS6a3u4CsaAmPZnRrn4tIQGp0ANCjydOLJQSDRDnEd03vlZXwmIjmnuitiJk0nzMltgEoBpqCj9y+LjrUcauLBTCbFSXc4uUI64azzYt61pMG1zTX0S+5Xgpq6MWmIItlk37LBTsPlb2yZXHulCpo5qBVI7GfS32ElbylZPf7dUumgieEIYaaQCbyNbORjDb730R5amwAxk80dCZmy5mS8Va4Tv+s9G4SKrkc6mjtMocn3TzXDxD/l48PuP4+S0OdbKFyvOqn9VRsMpLSV2LAGHJ7lu5mJvB5X8l55zTct4MkGgpZe4g3wG/gkm1YgExsnQyha0sZX68u8BQt9PAxBAw7CCeETNPQuWqPCGpeAtR0WeI9z3S4+TZMGBK74iARSRXeAwxvaQt4Lq1om5dX6Nq7jvh7ayy+Bx146NFEYfGDFiav5wGkSidW5vSj6XLmq9tGoBXyBRXtruVkbRV8dS90OrhJJWp7RY9K1vWIbhHxhEIT/2B8AfeafD6Xw/ciE9MkmOxs4QyX8uLTuyDgAEzNaVhAdTNr18ysRbP1X4n2Ya/d6iteukLba6wxRxxtOqzl9zQpS/BApLHNG9WjJP+slmU6mF5jKVGcJtA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(11063799006)(4143699003)(3023799007)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0diaTdiQk9wMTRhWkRoWlRhSUV4RWlUK25HWGt1V0JYVWd5QURHM1pUcmMw?=
 =?utf-8?B?WW9MWkg2bnRRSEFreS9qMVo0SzQ5QlZ0QW5hWE9hU3VnRmNIaXhMUFJxemlK?=
 =?utf-8?B?d0pJZ2kvZldkSmNua05jcWc2b05mYWtrTHdqZkoyOFVxS1ZpUkNOQmE0MDRn?=
 =?utf-8?B?SVhMdnNvU01ieENxanVGS1ZMU2FORGdYQkVqMnBiTStLRWlrOUpCbzJwV25U?=
 =?utf-8?B?SEJURmFMRkdubi9EbVNXRlc4RkRnbXBjcE90bHpJd2hFM0VhWGlzNFdIRm1W?=
 =?utf-8?B?alpyTVZKVU4zMXgwYjhHUVhBc29uYU1ZaGxmeHFVanJuQ1pxb2l0VDlmbHZw?=
 =?utf-8?B?YkFDUEhsYktmdjQ1a3RUU3h6Q3d3dGQ3R09LODRnNGxMZE1yZkw4SEVUNGhx?=
 =?utf-8?B?UHJZc0p6WXEzeCs3VU5tWlBtT21oYVp3Z2Vtd1pjNjRqSHdmM0RZUmhDbERu?=
 =?utf-8?B?OGtmVHgrV1IrVHhscU1YYUZJcFdEOGcveHVRblcxWGZ4MS8rNTlqK0F1RHpE?=
 =?utf-8?B?WFBZVHdqR01ua09oSjVEQ1JocmZnT3lRTFlKc2JUQmovaFFTd3VKU0xMdHRx?=
 =?utf-8?B?ZGpVZXdLNkM3VjdBUUxodzdSRnRWOUc2akY3TGZPVDQxblFoa2dpM1kyV2cx?=
 =?utf-8?B?OXZOaHFJQkF4cmxpWEd6bFJCUVdoUldFV0hLSmJGR3RhV0xDVjZkZHdBU2RH?=
 =?utf-8?B?ZVMwcUR6TjVGbmllWER1UHVNa1pqSHczMFRST2dyWFdJVkh3MmhQUk5GMUZv?=
 =?utf-8?B?aFB4Q2dCNzNPclkrc0d3MGpVYjc3MGRvWUpILzZxbWRpSkZFcE0zSXArYWNQ?=
 =?utf-8?B?NEFMcW8wWFZNdTlwemo1ZmJKRzRHWStXTXByVU0reDBCbldadDBMeFNHd05B?=
 =?utf-8?B?WGQvN2ZJdWhMUm1vTWpnYjdPWGg0MGdudXZsbGVBZG1idWFPa1F3MjM5SDNs?=
 =?utf-8?B?MjE1QWR3dGVEUjB6ODdSZ0c3UStzcnlwTEg2eU1EYTk5SjRWdVNHeHNsKzZz?=
 =?utf-8?B?MlBUQTMvNXAvR3haQXNFbkRBYlJ1b2NGSkp3alJYbWZBMThHK2E2VnRvVmtJ?=
 =?utf-8?B?RHZRRVVqdk5lUUtZbFg2Qnl2MWlUWTBxalVjNDNMTmhaWVBzSGlVOHZlQXJz?=
 =?utf-8?B?QnVPQTBac3J5VEtmZWRRdDdUT0NoV21WOW1LZmZ6S3VpRlZUNVpSVTR1S3lr?=
 =?utf-8?B?Q0hSQklsaWxmRTlxTENKUGpESHVoMkVxNmlIMjlzQy9BK0g0TnphUW1DOVRo?=
 =?utf-8?B?ZkxWUENPMDJ4MU9wOTZTSkV0eGFsY1k3RUhNWXV0bEh0VEpBS25FRWlkajR2?=
 =?utf-8?B?aXRhempNeDQ4NExRUk1nM2trcGJ1ZFBMaDZxMWt1alNjeUY1dTJHTGxzUTQz?=
 =?utf-8?B?K25ldXF6Q2l1UTlkL3IrZ1N4WTUyUGRDWXNsRFJ3eVhVYUtlQUJFNHFYWnFE?=
 =?utf-8?B?dGJPSDZ3am1xbFNLZ0JFRnF2a0xBZzBXS3ArdW1UaU9jTWdxR2RMTGZzTjM5?=
 =?utf-8?B?NmpjV1NFTUVETFlISVlpS21BZVB5cU10amRVaWFzMW1JajZMN091MEduRWFJ?=
 =?utf-8?B?a1NSK3k1QkZwS3lGQ3ovYm5ZWFNOcDRYd3Rkc2ZqcncwSTl0Mkw0SWlDU01D?=
 =?utf-8?B?K0ZoSVJTMTBuYWwyZTZPN3pWQ3pGeUMxR0hvcWtqVmRPWWR0Vkk1V0x4a1BE?=
 =?utf-8?B?YkJ4VEwrbldFcDVmeWhFL1k3d1B2NFJkVTBLV1VTNnBnMWhXMUYrYzcweTA4?=
 =?utf-8?B?RERmdnJVL2dMTGZobjN1K0k1NVlKRlFKRnp3SmtyVFUrWXZHdHJYc0wwaGZi?=
 =?utf-8?B?Z2d4ZHBES3V5UFloYjB4Vy9OZjk2RGJjVU0yQVQxSnM3bi9IRDlweEc5UTRL?=
 =?utf-8?B?UVFiN3dqZDZlZmp0ck5SbThZU1ZjdzZBSHJQejhKWFFUNm1aNjllcXRuNksr?=
 =?utf-8?B?S0pydjdEenBYUnh2eCs4WjYxdVFNRUZEZ09TSWNVSEt4Y0NJQXJKTmNBQ09Y?=
 =?utf-8?B?M1phWThHdFA5SkVDb1hOQzBwK2VtMEovakdOZmMwb25NS25Vc1VHSW93dTZz?=
 =?utf-8?B?S3RtZk95eDFSdkdON05HZGNmMWo3UStLVm02V24vb0Jhb2dmUTBMU3VLMm9C?=
 =?utf-8?B?Q09oMUZ2UWloVjRORy92S0dvanUrTW51QVZlOXc2cjFvZDhUdm5CZ1pHR25v?=
 =?utf-8?B?Y0x4ZW5Qcmt6OS9reG16SXN4N0xwemRETTdtOExoQ3g5QWVtV05rZGVoRHdE?=
 =?utf-8?B?NlcvSG9zTjlDRzJXdWVYbUhzOVFzTk04cjBpdUxVUXdXclFXMWMzVTZvZHRl?=
 =?utf-8?Q?kzX+7TsXMtY7oKgL4e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f83b55-521d-4075-3461-08dec0df8584
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 19:45:38.4867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0XIWuzbClluIs/Cm2iTQMRBmrshJQaYdX0ta/7owRBS+bg/v0r9+QgJuYeFNT2/ZYsHXObxwjaXM4fP3RvWuQ==
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
> Two small type fixes that match how the values are actually consumed:
> 
> - decide_zstate_support() iterates from 0 to pipe_count, which is
>    unsigned. Make the loop index unsigned int.
> 
> - hpo_enc401_read_state() reads HDMI_PIXEL_ENCODING and
>    HDMI_DEEP_COLOR_DEPTH via REG_GET_2(), which internally casts the
>    output pointer to (uint32_t *). Passing the address of an int is a
>    strict-aliasing wart even when the sizes match. Declare the locals
>    as uint32_t.
> 
> No behavioural change since the values are only compared against small
> non-negative constants.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c          | 2 +-
>   .../amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> index 5f088d113b9f..38c79239004c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> @@ -1060,7 +1060,7 @@ static bool is_dtbclk_required(struct dc *dc, struct dc_state *context)
>   static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struct dc_state *context)
>   {
>   	int plane_count;
> -	int i;
> +	unsigned int i;
>   
>   	plane_count = 0;
>   	for (i = 0; i < dc->res_pool->pipe_count; i++) {
> diff --git a/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
> index 28cb14dc87b0..85b7a44c0a11 100644
> --- a/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
> @@ -143,8 +143,8 @@ void hpo_enc401_read_state(
>   	struct hpo_frl_stream_encoder *enc,
>   	struct hpo_frl_stream_encoder_state *state)
>   {
> -	int pixel_encoding;
> -	int color_depth;
> +	uint32_t pixel_encoding;
> +	uint32_t color_depth;
>   //	int odm_combine;
>   	struct dcn401_hpo_frl_stream_encoder *enc401 = DCN401_HPO_FRL_STRENC_FROM_HPO_FRL_STRENC(enc);
>   

