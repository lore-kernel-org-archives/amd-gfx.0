Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0EEC48BC3
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Feb 2024 09:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C209110E285;
	Tue, 20 Feb 2024 09:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="snNZz8xZ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5800B10E285
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Feb 2024 09:20:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwInHto38IRdxCvx7+59yMuafcq1Rgrv7965QjEO7rs6vuk+4lNBQwvNHWICMuFenGOPKEbE3lhgk8Tu+SUTC2qZZvojz0Rpf728xtLAQOjAijKPH2J31cFJ5cDUkClSroN1Bvu45CW5RXMhrm3v2JggzNR0serq5MsPNUytT/6v2l5WuYT1vw84Ol7eM2SJGDnDAyCwZcx1WAiB349yKxTufR/zudz2K1dNaKFBMAORGdecK0RoTya11GHXrGKvt66HZnBkHQ1EnrRZd2BV2fKtIHRQT1fNQUBTvmd4L7BoNp8fJ9f9hIl6/0ViuEgyZOPsQ9fukaxl//OQsx8OEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMi9SBQkS2uwG25radB0a3DJH+yt46hKctcId05zRO0=;
 b=n4XoZqboJQbqKVnYuBYLyXTBhM6QlYwd10RA8zVFLw9Pm3v5RgKOkKY+PTEYPCHhT8++/mHiSgYaet4unB1TT6TDwmE2EbN0ZUwFE4zMWqiwcbbH6AGT9nrhuQhbHH75V9KSLWO3PYBO5W2wrZEhZ6K+cLgMpckV8lTTIMlpAe3pPOaU350MhfwPsVlKMpKNypluLA82aesdnxWhpTe13puOLJaGhwTBuXwgLVLRKOEX0orqbSUf+0vZnxuJsdJfBnlo96HOPGJEGIxzkGqlyq9vamU/AjYaeiRZwy0gTCNj6FIhXrLkCpwcSi42D51wmEmLHEtD+GBg0dJijZbK7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMi9SBQkS2uwG25radB0a3DJH+yt46hKctcId05zRO0=;
 b=snNZz8xZzbHa3f2HqMCSny7mPiOtBAuymX0H6HJ0kaq6leVhtVtma0YxbO+LH9qOIRtINam7YYkmzcnIckiMoFHyfCSmi1vtbGGS0CAXNX8YzNeHRQqhc6O0zpKCEdactv3CY4B2SMD8OAlvKiyz7ACg4tdATNYl+3IgZnz8Auo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.20; Tue, 20 Feb 2024 09:20:46 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::6b6c:cbf4:9ab:59b8]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::6b6c:cbf4:9ab:59b8%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 09:20:46 +0000
Message-ID: <3ed545da-2937-4f3e-974f-7f18d2d50a7b@amd.com>
Date: Tue, 20 Feb 2024 17:20:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Fix potential null pointer
 dereference in dc_dmub_srv
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, "JinZe . Xu" <jinze.xu@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Josip Pavic <josip.pavic@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>
References: <20240220090623.4156779-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240220090623.4156779-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|DM8PR12MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d5d4a7-8c06-4424-112a-08dc31f5380a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byc8uJfsd8UTTYRCDwvqdhGqfYv/F5DdEX1ICspeVgtDLDELvcaqZ32a2dW8EMXnzGO0QPdYByyNrLSaLd/IZgz/xGou1OCYY6l/rIahiXCJv1SeDXPZCKo/4ubZJZU1eTyEnJP7uBixHLzoo9l0zotyab0hX5BOICqw2ZyVjsXzoCSLW0bUnL6S79dQAnGQJk+eCUht6jyLrLlrPYkr1fm1xyNEu9FYyO9QaNmp9c6bvDRWrfondTg0SoGdaP3IWPEXKwW6yO8eb3+7CSktZ3IWbCfS4rMwyLXaSxg8zdX2f+AsgNJeGW50et9zMZHztVt4cKBpCbBmhwjMjvUjdVyySfu3dudhgi2oDi1Et/iEyZd0DyK1gxc30ViMkTx0QwCBFp/APhvNmm7YfptCv4UG7NoXBzsYVGQwCgVypsA72eMwI+Y9+ihlyQz+Np1jA2NpISsJStOi15PZDIpKS2b92uiZr5sctSoyfS99siJmfU1TQAfFsnQyC0hxyyeLRL3AM1uaRcOnMEkQWR6s4vXQZAFLqpc0c8eHhw+i9Hg4+Du+lfvnMglWXQ0i+BCo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFFkSUNLeGZ6YVJ0cjVmTGNDTnFMZkNyMUFFdFRzMXRMWjdPT0MvTGpLTFgz?=
 =?utf-8?B?cE5HYVNjblpWUjhLNUJrcFNBc0FjOENhV0FBQ3pGVUk4bjlHNzA2NzBaUjNB?=
 =?utf-8?B?SkJnZ3d5VWFFMExCNDh3ZW41QXdidTZ3T3RWVkxrOE1IMWdDeGZGUDZUZllk?=
 =?utf-8?B?MUtsbDhJV2swZVQ0aGdNcFAreTVwdEYvN0FpOFNGd1dtWUN0WU9HSk9zdGVx?=
 =?utf-8?B?bWNZRldSeVRNSmh1STF1aGR1MDBUSktxeWRWQnZqa1ZKcHpmVzBhdVZlcHVN?=
 =?utf-8?B?cnFzdHd4aW5IRk0yMnllZ055SHNGTGsyMEcvMDRxTjdUc2NWaDlkR3p4eFov?=
 =?utf-8?B?NGxya0tiQjdXazNWVERUNzZHdHhGOFkxZ2dIMTdEWVJMV1BOVnExeDU2elE3?=
 =?utf-8?B?OG5KSHVPTTZnL0U0SzMrRDhNOTBtZktZdURaRCtLTVVGcTBXRjVQdGhKdE4y?=
 =?utf-8?B?K0w2aTUyS0VYb3BhRnRQOFhpbS9hdDF6V0tpdFJEK0dOL25UQ0pHMlJXOERM?=
 =?utf-8?B?N1pHTlkxYmhCY1dhTWFxK3E2NGZYNTU2MEdzMlJiQmRVd2N6NW55ZTAzb1ZI?=
 =?utf-8?B?ZFVhdGo1QXdHRVNHQzBrWGJ0b0lCc1lKbTRiRW4wSVBPK2hjT0dpcnZLeHlr?=
 =?utf-8?B?eWJqb2VTQzIxZ2gxL1htU012eStvNXdsanFseHF2c0FyTmVoOUdoVXBMN0pI?=
 =?utf-8?B?WkxXTi9zUkRkNnVxd2hzNnNkMmV3dWloNVB3Qm9TellaUnJnb2JpQ2swdGo3?=
 =?utf-8?B?UHc5QTlSZXFmSVlpbUpTYnI2ZTgxZjA3bmhQZTh3RFN5MlVNNTBQZmFiN3k5?=
 =?utf-8?B?UVhpSDZNSytpeWV6ZjhMOTdYSE1aQVhXdVJ2UVJwOTFsRC9HODNrSDlsRXBk?=
 =?utf-8?B?K3BQT3ZodGliTURybkoweW9Za2RhWW9VRkxaSkpYNlRCY0g3MHVPamJqbzl6?=
 =?utf-8?B?UUxTeGVJMzJDWlJYbjVjdXBGNHZ4b2RTbnNmWThIUE85UnNnYVdOOE42NS85?=
 =?utf-8?B?c1dUYU5uRGx4MkFZblVJa0FFSXZFcUk1UFprNFpjSllkYU9HekgwdGg5N09v?=
 =?utf-8?B?OThQNXg3dzhGdjNyYUh6VU54MWpaZFBOeG4za1EyUnphYXQwYnU0dE1wOVFM?=
 =?utf-8?B?R05hZjEyM2hLTWNOMmIxM05XVjk3NHRvL2NPN0ZGY1R6UVIwVzdjV3ljQVlR?=
 =?utf-8?B?c3dKc3NDUE9JYjlHYXJXWTl1Z3F1elhyZnd2a25TdS9pSm1QbmRrbGhHN20v?=
 =?utf-8?B?MnlCN2FLZ01WMXdsdzVuNTMva1lrYXlva3pSTkM0MzF2UjYwVWNqSm5YZnRU?=
 =?utf-8?B?ZzV3RVdONXJXMEpzaDZiSE9HaFpGVkFTWFRHVDFsVENqZGtOQ3ZGbjRNTGNS?=
 =?utf-8?B?MWJDWEc5a2E2dXVVVERleSsrUGxnUmZXNGxyQlhYeWhlcXR3WVBUWEx3R2lN?=
 =?utf-8?B?NUkzdlJXZVlOeGVoV0NVTGhTV2N1VWgyVjRqVEh5WklPUExMQmgyWUpNT0x5?=
 =?utf-8?B?a1NVZmFUOTBNaGwxNkhiNG1DcUdpTkNrTEtuWHNENXJ1bGMxSHcwcXF0QjhW?=
 =?utf-8?B?Yjl0TTJZYmtpWDNrRjBCVXpkMDY2WndJNXlZaEVQd3AyeU1WU01CeHphb0Z4?=
 =?utf-8?B?c0g2bHEzSWl3c052Q1R0Q3M1TFUvQnBQZWFBcGxWLzQvQ3NMaTR1SnFUYlVF?=
 =?utf-8?B?WDVEN0tYT3hZVS9lbWx4OTBLQmczU0dYd0hTVTFPNThJWmFlNkFoZDVkaTQx?=
 =?utf-8?B?ZTdvS1l3UkM0VTdXalJGdDIzYWVsM3EyUGxadUxPNkYyV3Z4Y0d3dEhuYVU0?=
 =?utf-8?B?VkVRYVIzdjRSS3JNcUVQcERubi9sbmVBWDh6azVQTWN6cDIyak5TbHhLL0RZ?=
 =?utf-8?B?MC85Q1R3aDR4aGFzWVhEaWlxSzI0VTkva2dGRmwvT2VCVkR2SWRzYXNNMjFR?=
 =?utf-8?B?dDVuK2VaZTdxUnlTQVFYUVpGdjJPcmpIa2E4bGlnMzA3Q0Z3bTl1bk9FYVRN?=
 =?utf-8?B?aFcrcXQzTENCTUs4aDVLSEhQZUpNRXl6QlBZalRnMW9mOFI2eHRoQzd1TUR5?=
 =?utf-8?B?dUZXV2QydnBlRUU2UmRqbFRhVVdDWlRwRVdFOXZxVnpsRzFFYmFxR0gva0dv?=
 =?utf-8?Q?fS52ePTmYVv+1AjuCUOh6wL1C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d5d4a7-8c06-4424-112a-08dc31f5380a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:20:45.9781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixAZCaCpIpBCf+SCzN4re8tnuFqKrisrQG6O//NoRjdc7ECVh0yVmYPL1rTRnvv/2FgswDuVtkzxgI2222ZDyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5447
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

On 2/20/2024 5:06 PM, Srinivasan Shanmugam wrote:
> Fixes potential null pointer dereference warnings in the
> dc_dmub_srv_cmd_list_queue_execute() and dc_dmub_srv_is_hw_pwr_up()
> functions.
>
> In both functions, the 'dc_dmub_srv' variable was being dereferenced
> before it was checked for null. This could lead to a null pointer
> dereference if 'dc_dmub_srv' is null. The fix is to check if
> 'dc_dmub_srv' is null before dereferencing it.
>
> Thus moving the null checks for 'dc_dmub_srv' to the beginning of the
> functions to ensure that 'dc_dmub_srv' is not null when it is
> dereferenced.
>
> Found by smatch & thus fixing the below:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:133 dc_dmub_srv_cmd_list_queue_execute() warn: variable dereferenced before check 'dc_dmub_srv' (see line 128)
> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:1167 dc_dmub_srv_is_hw_pwr_up() warn: variable dereferenced before check 'dc_dmub_srv' (see line 1164)
>
> Fixes: 01fbdc34c687 ("drm/amd/display: decouple dmcub execution to reduce lock granularity")
> Fixes: 65138eb72e1f ("drm/amd/display: Add DCN35 DMUB")
> Cc: JinZe.Xu <jinze.xu@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Josip Pavic <josip.pavic@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
> Cc: Harry Wentland <Harry.Wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2:
>   - For dc_dmub_srv_is_hw_pwr_up() move 'dc_ctx = dc_dmub_srv->ctx;'
>     below 'if (dc_dmub_srv->ctx->dc->debug.dmcub_emulation)' (Tom)
>
>   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> index 0bc32537e2eb..a115e1170ef5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -128,7 +128,7 @@ bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
>   		unsigned int count,
>   		union dmub_rb_cmd *cmd_list)
>   {
> -	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
> +	struct dc_context *dc_ctx;
>   	struct dmub_srv *dmub;
>   	enum dmub_status status;
>   	int i;
> @@ -136,6 +136,7 @@ bool dc_dmub_srv_cmd_list_queue_execute(struct dc_dmub_srv *dc_dmub_srv,
>   	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
>   		return false;
>   
> +	dc_ctx = dc_dmub_srv->ctx;
>   	dmub = dc_dmub_srv->dmub;
>   
>   	for (i = 0 ; i < count; i++) {
> @@ -1169,7 +1170,7 @@ void dc_dmub_srv_subvp_save_surf_addr(const struct dc_dmub_srv *dc_dmub_srv, con
>   
>   bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait)
>   {
> -	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
> +	struct dc_context *dc_ctx;
>   	enum dmub_status status;
>   
>   	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
> @@ -1177,6 +1178,8 @@ bool dc_dmub_srv_is_hw_pwr_up(struct dc_dmub_srv *dc_dmub_srv, bool wait)
>   
>   	if (dc_dmub_srv->ctx->dc->debug.dmcub_emulation)
>   		return true;
> +
> +	dc_ctx = dc_dmub_srv->ctx;
>   
>   	if (wait) {
>   		if (dc_dmub_srv->ctx->dc->debug.disable_timeout) {
