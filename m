Return-Path: <SRS0=i1uT=OE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E509C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 15:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2666060FD7
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 15:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2666060FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDACB6E4F9;
	Tue, 14 Sep 2021 15:08:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F916E4F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 15:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxlGLWhi+clWWDfKqpl2xdqmBXKOwMwFp+2kDvOKyMBUuS/9BTpjbVHbdt4pZ1tvQFkuE3IPxlY1yrvDsYps3CKH6Xw+RbcaJTreFRWRHM6RB+agYVDFJEIAYpA48cKcTnEuRlx4nTmhXzXthSvPTTciY+l+4FqsiV8dd06oHAszaLFB0FPvOdG6MfLmW+5qRz/8K9tnq4dh1MG31cGVJ8CO+VMCd4y3jQJ4mGA1kH4SULvZ+jbv5qz2t1K0OdczctismH6X734TQOf9dkof9oULMZhyBsdP+WcaNDf8gQ7jsYnLfVAKUYN76HAE5Zqg2kquVBB6CgfpjvtExCWAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=zq0YRzPF7Cv7sETwiPdfsBogIEP3ncv+8Ez2VyQ4zZ8=;
 b=M+CtzPDGlM5+PS/L0f72g/e4IV2WPjRNUEKr/QWAUgq487BQiZj/0cksuRiVVWngb1DVk/Fg+sUqNaGPpubx3VAwyOZ0Pb0fUNVnLsbNt8WW2+Ds+3xREOk1shIYwRtzyGeHLAtTtMs8goVwgY05V0MBnzP0u3LtfJ7AtpKg/6BxNOhe6/LTnLrZzr5uHAbmTE0PM9S2CeU6ka2XqFrem16ZbSrVdAyuNv/H0W9kPAk7vez1IFGKNEPJUh3BJbZ2bAbkvbP8ZqMMBo+T4q8mLVnn/tt0w19OcTbzFAfHrbn1e9ywMNdHiCk0RflykLDDS5k09i2xmP04QcPuvhIqNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq0YRzPF7Cv7sETwiPdfsBogIEP3ncv+8Ez2VyQ4zZ8=;
 b=vvWLx/ehJygnlCxVH9g3liXUqoF4RqNVCcj/Qj26zX8XMEWX4vOLYPTGtq9yo85WE7B0BbKW9OzWCe5qYUD0rmFXa2+KNmi4NFmCmPyXoYIrY125POl/AbUYwWJJWaP+VmWR2hbKTQyBewg8hEy2oAEje4WS9Zw01yOIXQNPOKs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23)
 by SJ0PR12MB5456.namprd12.prod.outlook.com (2603:10b6:a03:3ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 14 Sep
 2021 15:08:36 +0000
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::384a:ae5d:717:8ba0]) by SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::384a:ae5d:717:8ba0%8]) with mapi id 15.20.4523.014; Tue, 14 Sep 2021
 15:08:36 +0000
Message-ID: <b25690b4-fe4b-7154-1b29-0b5b0a6f9ba3@amd.com>
Date: Tue, 14 Sep 2021 11:08:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 1/2] drm/amdgpu/display: fix warning about indentation
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Leo Ma <hanghong.ma@amd.com>, Mikita Lipski <mikita.lipski@amd.com>,
 Aric Cyr <aric.cyr@amd.com>
References: <20210914145912.1569716-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20210914145912.1569716-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::43) To SJ0PR12MB5438.namprd12.prod.outlook.com
 (2603:10b6:a03:3ba::23)
MIME-Version: 1.0
Received: from [192.168.50.3] (198.200.67.104) by
 YQBPR01CA0107.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 15:08:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 150da65a-81e2-4f36-9d41-08d9779186c3
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5456:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54567BF8599CBF4DDC2797FC8CDA9@SJ0PR12MB5456.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XGOjp6zOFiqhfZHsMaj/7w8SObaXj5YAUfLZS9W7QyvyKw0Cc/ZMDP6+iAouIJt6cgLLpPkgO84X2OOPQZM+JLJQClLBeDZemiSOb3P2kffX4dcnUU840kDqiYL3sMBsoeU2V2XRo8L6HGi1FUQ9dXs+abfigpVRVogg60CeHrG2vysr6GnPCuFFNX/x3ZHNDj7p8aS/Zs27GQ2SBWI8rVKD0f6qjdoBE4eRz2BKG1kzCE5TgNFsvZuPHCKaw0JDLUSBpE/4XmAwTZWUcbozu+z74VbXdbRQLUaryXgico8zaiontbwiKKroGI/aIVhAQPOkDqHXinM5Itkv83Ah6j9gCfpapuL9I+CKRgLUwgKueXj85FGS0Hr3W3f+YFlrXSfiuCRBiCpaIPrVfRWCIChAvKO+/yTMXGCeB3+L9LImW4gKRwp/iT/nYfVrQqIpOFne+ViK6ZezB50hpsRbW/tnDg2oUu3EOiC5WYrPX2y9UxH6DoM5ZAAt49+NVnlLaR5W2oqxydvyC3A/E2u/huueBxcsb27SYfAoF3Dwz5KHEA7DxDZTuGksZY0hF0sa3ezaK3WGVV6ZwP/vYFCH1mEVE032hGhnOTaJC3A0i/cXHQdErlbtA3Zf5ignmpD/mN8cF3BRVeuhM3hZIn5ewVW2sdahDYnq+0cde+5VSHdOXz5YN9yHPrnt+03Ln39eo0cNJkLWnc4tH+olM97PUqS6aGTyEtDPC+XSIJ7cwmLlbBG8q5vwkuhbNx6LdxqK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5438.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(8936002)(186003)(478600001)(38100700002)(66556008)(44832011)(86362001)(26005)(316002)(31686004)(66946007)(4326008)(66476007)(36756003)(53546011)(31696002)(5660300002)(16576012)(8676002)(83380400001)(956004)(54906003)(2906002)(2616005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2RoY0ora01qSy9BRUZuYTlqZkxHVWVlZUE1a2FuUDZON1RCcTl4cTFFWjFP?=
 =?utf-8?B?MlNKTjJEZTFPLzNCNUltNFgvbVhESk52bU9oZHdFdE1hVHNkNzlLaGVHdWpH?=
 =?utf-8?B?L3VrK2Q4Nko1cGwwRm5SdGtSZUVwWHlWSHhrUWU3QTdNRFpTZ1dENkhNNDBY?=
 =?utf-8?B?cjMxYlNWS053UjZBUG4zamxGdldPRjF0Q1B6dXZicGNKY1cyNVhjTjBONXp5?=
 =?utf-8?B?emdHQkpveGljZm13K1pEV0V2cFRKZUc0ZkxMQ0RrZWdxbjAzWXZzY01kdm1T?=
 =?utf-8?B?d1haRnF6bnFvbFRISE9JUFJORTM4TDY1Ym1YQXVBbDVuc2VLTDR1eWt2SVpH?=
 =?utf-8?B?YkJ4eGlFTlRwRk04SDlCUk5PZmk4V014ZVpidnJkVmlYWklHVzJKNHl5aDlv?=
 =?utf-8?B?RUNRY1J0dmo2UE5jWEVGangyTVlMbEZ5UW9vVFRRTi8ycnJHMWhSVVZlNUpt?=
 =?utf-8?B?U0hHa0I0QkdGYW1UWC9MOVhoTGdmb0twRnRsQVRPcWk4bU9VcVR3dWdUV2tN?=
 =?utf-8?B?Qmp1cE93NmFsR2xwUGdMTXR5bHVFdXlsaWVvaEZ4b3krSEptSlhuTFlwNENC?=
 =?utf-8?B?MHQ5R0NrZHZYWDlRZVJ0Q2RlTUNJU2lQVzZPL1NiOGswMXBpS3lyNTVDbm8r?=
 =?utf-8?B?clJKMVliZTF3cmYwTFF4RkVKeXN2QXF5SFE1dXdlVm5aRmNBeUIva0o3WjVj?=
 =?utf-8?B?RGh0UHFzMG1NU1h3K3hMQTRtSzZIUFl6NXJEd3FuYmJZQnlOR2s0cmw3WTBL?=
 =?utf-8?B?RlVlSC9HRXpDOWVzZmlNNTNCUnBRZ204U2ltWmEzSWdKNnZxRi9ac0hGL1F2?=
 =?utf-8?B?YWswVW1wdEdsY2M1ZjJUYm9MbG9ZV0gwbmFvSDZwWjZiK3NLOFdMazNtMU5q?=
 =?utf-8?B?OEtzcVQ1Q1hMbGl6Mlh4b0tWeE4rVStwR2l4Z0F6T2w1T1BscFFKS1F5OFFk?=
 =?utf-8?B?bTNIVnJGSTIrTUlUVllRQVZQSUFEejJGY2JkUUZxN1hIdmo1enZyaXZFYVdm?=
 =?utf-8?B?ZVhDZ1RGc3pUQ0xEWS9yZHVub21qcXVHTXljMkZoZFhqT0d3MVJubDBYcUp5?=
 =?utf-8?B?ZVdOZWRBWGw1V2txRjI2NE9LUldKN3FDTnFKTkpOQVlEVlh2NzJOMktMUTVt?=
 =?utf-8?B?azNja3lwZjBjZUtKZ2gyY0l0VkZoRXhMajFUL1hwR1E1Ym82dlowblkxYTRE?=
 =?utf-8?B?T0tHM3AzM1doL1lzNFcwaWp3bUt4M0tEKzZVQ2c1ZStncWNQcUV4OHFyUjU3?=
 =?utf-8?B?K2ppV3ZnSFlHOEpBTlZPbWFvTUcyeHR6cytzdW9jbzhuNkhwUUNiemMrTTZv?=
 =?utf-8?B?NW0xL004Yy93YzJSRDRDeThEZ3VJeVVWS0J5Nk5VY0p6aytma20wY2huUXpB?=
 =?utf-8?B?emg5aUg3eVNwUFg2djk1NEE2R3BpK09aMGFVZVZITURIN3F4dVlEZ044d0ow?=
 =?utf-8?B?RHRMczFhMjNtT2F1eURNUlF6cmg0Q1UxcU5sb1ZGclljVVhTakVBa0ozNkRW?=
 =?utf-8?B?V1RUWjVQRzNCRHZGSDRqTFQvNTcyT2x3Y3BPQXM3ajZuMlNhNFFVSlVlTjBp?=
 =?utf-8?B?bmxXUTU3bGNFbzNDZkdhQ0d1YUIyS0lWYWNnM3pOQUpkelJWMUNoRnNQbzJ1?=
 =?utf-8?B?bFFmNVZKWklScjVwdkJXSUUxSWxGTmFMdWZUMXpuSXRLQUJXbnRNUklXU1NL?=
 =?utf-8?B?bnBFODFYK2RSd1FtVHR2QXBoelNGOWZqdm5sSW9oTU5WekxGSzl3TmFXYWc4?=
 =?utf-8?Q?55h1r5fMcgiD+oo8Jdq6qoGbaB/kgkOkBK9VO3p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150da65a-81e2-4f36-9d41-08d9779186c3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5438.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 15:08:36.6527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjFMYMjDV5bbRVRDpW1l7sjdqotqNelCZdUOUdxnHpoQxHlRe6D/gqAIB3HF/UoIxB9C01baafpsP4+KVcyvnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5456
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

On 2021-09-14 10:59, Alex Deucher wrote:
> Looks like this code block was missing parens.
> 
> Fixes: c0ffd1945147 ("drm/amd/display: Add DPCD writes at key points")
> Cc: Leo (Hanghong) Ma <hanghong.ma@amd.com>
> Cc: Mikita Lipski <mikita.lipski@amd.com>
> Cc: Aric Cyr <aric.cyr@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index ac4896ff912c..6663cfc4eb71 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -2370,12 +2370,11 @@ bool perform_link_training_with_retries(
>  	/* We need to do this before the link training to ensure the idle pattern in SST
>  	 * mode will be sent right after the link training
>  	 */
> -#if defined(CONFIG_DRM_AMD_DC_DCN)
> -	if (dp_get_link_encoding_format(&current_setting) == DP_8b_10b_ENCODING)
> -#endif
> +	if (dp_get_link_encoding_format(&current_setting) == DP_8b_10b_ENCODING) {
>  		link_enc->funcs->connect_dig_be_to_fe(link_enc,
>  							pipe_ctx->stream_res.stream_enc->id, true);
>  		dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_BE);
> +	}
>  
>  	for (j = 0; j < attempts; ++j) {
>  
> 

