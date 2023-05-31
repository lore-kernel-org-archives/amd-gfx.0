Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304C9C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 14:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9ECE10E4EA;
	Wed, 31 May 2023 14:42:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78FC010E4EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 14:42:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMNd7WXnajRa3pvRZFv9UScKM0p7H2k2NPj6vi25yXOMWvJqVW6PPXCeZBBJ6xBXHf56yqm3Fc4l4bQEBxhdO+KuCtsjEHrqSYHvV7IihmB4x7zEKOCzFNwnQ0T80kjv5Zgy6UOIiAVozs5ds3ciAwFcbSACeAK25ZFOnxoD9lCcc3+dYosQT5voNelTW8F3XFi67471VWKJK0h5JLRVzj4chkZUdzbAN+MmirKMS+NX1Xw4w7xK/cEa5u2NIfnAo6xka7FMtClg2C2nAqmtUTpZsNKA9jCpX0icAmySP8qwJql9diz7LwfgkgisVCCPKxmqHwe4bT6DQbVEl0IJUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MiFHted1ESHGu6VBcnJOGA/SHRoJr7NVM9DdfPZlVw=;
 b=UsyGQRihM2S2yygx8VFNAhxjPsYGVIoDc0QErSifbS1E7M9XJrFONWC4e8ECR1tHBiJNZB9MRjFsRfaOYTTynLTCZuokzxBnENr1p2BdP+oWQkgkFeMFykNFuXDgz0ZGTYLZYl+CM9GAlrk3ecRoNAV2hclaIQnIfS9D/9sw0I7rVqgo7o/vXUAds6lr1/rXEAse2o7IWVcaTMHLqgM1muyEhO1y7aOW8WRiLP7bQja3lGhm8/6ro/ZpFpDxjW3yXQ85nzkZ/1DtZPMU0OMvIhX1bTVwbQ5pcFlIapgDxB2htvLlF+NWWqe+E4M3EcvdzZMH2j/zHS/j4SQsOMfesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MiFHted1ESHGu6VBcnJOGA/SHRoJr7NVM9DdfPZlVw=;
 b=M4Tm/0Mj0f44Zp6gVJJaU8WQVqSE0RwILJ/6uJmchdbowmLsW9WtFkndGsD9wpFsBOcZ7Z29Tum8soXBGvPQ4xxiZTrzQw6m9J2ZGfM+vnt2Ht+3xsPDBe/iMDM2pK0qbNQxGL3jsSUY1mXuSAaDp611/RatYeU595L+3S3+hDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 14:42:30 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4d3e:94ab:56ef:6e11]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::4d3e:94ab:56ef:6e11%3]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 14:42:30 +0000
Message-ID: <2a56acbb-a7b7-25c5-41e2-3a3ab689a80a@amd.com>
Date: Wed, 31 May 2023 10:42:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amd/display: Fix up missing 'dc' & 'pipe_ctx' kdoc
 parameters in delay_cursor_until_vupdate()
Content-Language: en-US, en-CA
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20230531051159.3266467-1-srinivasan.shanmugam@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230531051159.3266467-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::16) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ba0416-1fbf-4f5c-3a24-08db61e54332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3nzimH4pq7J0dIFg689W0h25hmoWGdwRZyXA85XZOv7C5uy5O8TCXCna0dz3JFgsyMwUKRu/QzUIqW4THkQwNC5AAqf+Jni8pWVQ0ZBrsZS0tohyKME+0iALMYjqAZEZU4lg5VGB6DhavJ/8VWeLUk7VduuHQoATA1sTKlU2xBLM2LXfxV+z0c46m6g2/LFw1oICmFP1vVC4MV7aGInHN8NlHt+MsFUVJWozAC8ejYvWdQ9tuAyb0TOhoVO7MxLudiRknywzHuVgrqxN98SuiJqFfdxpi3xarbM3loO/PmTLGfu2gBvMLc+lUjHzvfzfkTYchN9xxn4TDKNeeonKzHk5t0nvsViajAsTPkSf3Yv6GTyzn+EptYadnOzI/OtVNhwsqu8UkRZGCaObgkwuy0zrY6tus1e5G58POWxyrcrEmpbvti0IFrpLIQEi390hWxSuuGi1rguQAqDN//ZdxuNvzidF5hTrV5LKbUqCwQqeX7ZabNVebuRBo7RZO7qDNZTBWrGeUcEkGBefqir3DYQJIAJXaYkgdHl2S4lys0m08+DscZ3sNM4yvzCMGlVj+GKRHUUBN9miARIkKSZxTUGG6l3l9sWakq+dx+bLO63ArDob4QGqOhwWrvr3Db9cfG/iJ3Nkd/bqpNE9X4+HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199021)(186003)(41300700001)(38100700002)(2616005)(31686004)(83380400001)(53546011)(6512007)(6486002)(26005)(6506007)(478600001)(110136005)(66476007)(6636002)(4326008)(66946007)(66556008)(316002)(5660300002)(8936002)(8676002)(44832011)(2906002)(31696002)(36756003)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEsrMGM3MFFDTUUyTmdZT1A5RmVLSlBTQnlRL3oyYzFiNTl2dENKK0dCOGY2?=
 =?utf-8?B?YTdhRkhSckYwSEQ1OWpEMklwRVZBSmc0WDlZc0JqSlVSbmJsL3BVQjhsVSs5?=
 =?utf-8?B?c1V3NEtoZHVXZDI5a3JscXhlMkZjNDF4ZjExWjQyUUswY0R0UHVHNGhYbWgr?=
 =?utf-8?B?Skxxd2c1TTVxMEkzenJ2Z2dldkcrOHJoS1JKQzA1TFhoQkp2bmN3bjlneUFz?=
 =?utf-8?B?WWN3ZHFOUWkzOEhYbU9IS1dNR2l2OWxJTlp4R0xkdm5JR2Vjb29VMlByMHpI?=
 =?utf-8?B?U0JjdFd5OUJ0NDRFRXd1cGU0YWgvQy8xZkpwOGQwdnU1dnRFQSs0R2ZJS1F5?=
 =?utf-8?B?SmJnK2lpVjJuOU5mT28vOHk2VzJVYWVUV2pMMzg1UEIxbjNOMUpBZUlPcXRs?=
 =?utf-8?B?Q3RZR0d1ZmQ0eUd0MlQyQnFQbUtDMmRBWGdpbjhJUzBmellZMWxvMjd0NjBs?=
 =?utf-8?B?L2VwSHI2UTZzQ2NGdlZabTd0WWFkckFmM3IzWTI1WnBjQ1FLRko0QWsxWmJV?=
 =?utf-8?B?NzZ3REtkWEY0eDBwa1NZbEVCWXZoU3pmOFYyTWQxWktYbXRGY3ZuK3BWM2Na?=
 =?utf-8?B?RUZUVWt2SjVPUFRkVWc0L2ZnNDFjM2ZSenRoZGFlUlIxc1Z4VUxuMzB0YkE1?=
 =?utf-8?B?RmtCVUZIWkJENXNLSzR6d3hZZWlmSzZ0SFpyRzFZZmlnQ3Vmcnp5bGNzb0pn?=
 =?utf-8?B?YXJZVEdMdG9Tem5SUlliNEdFYkdRTGlPTDdDWGMwSVdWWHRqbjlVYTc3bk9G?=
 =?utf-8?B?bWhEZ3lheEMvakxCL2p1RmVadFhwNlhLK053dG9oUVRTVTZZTTBlbStqYU9h?=
 =?utf-8?B?OXlVdVZUWkxkR2doMlYvTUMxcUpBalNkOW1UTVQ2RlM1cWJrTkN1UHNzWGRn?=
 =?utf-8?B?S0J4NWlYWFNOOXBHcVRjOHpjZmFiRFhWM1lQUG1uUjJFSEhwNitxTHAvek5q?=
 =?utf-8?B?TERPdnZwbDRHRXhub0tvb2gwemFrNW5QblhmcVk0Y1hQQllNVEx5cVZmdXdJ?=
 =?utf-8?B?STBFbXNpYzI4QkxXbEdhY1Q1RUpiWkRRRG1USEdzM2UxSkkzQWxGZ0ZBOWNM?=
 =?utf-8?B?NE9PL1BocEc1WUY1MW1wYjk3QlNCd0taVFZqcHVqeU1yZ2ZBT29yUEdGYmpj?=
 =?utf-8?B?WnFQMTFQY3I0c0Y2NlA0b2hLam42UjdvWmxvUld0Sk9zU1A0WTM5YUhMZkh2?=
 =?utf-8?B?dW52bUt1SUdEZ0IrdGtiMEp3SnlUNEF5a1RwRU9rMi9hSXNucDc3TjNYY2ty?=
 =?utf-8?B?V3ZnaVRtczNsdVlYRytDbHNlQSttOTBYU2d0NUdydnNhVjBIQnZ3UG9LQStL?=
 =?utf-8?B?MmVLdGw1YURtS2Uxc2ZqNUpEcDlkNVhvYnhlaUhuQ1A4WGhhK1VlQk5IdWtr?=
 =?utf-8?B?VW40Z2g3R2NmMy9TbitFaVlvdEk5N2pXTHV2QzdqdHh1c0JlWG1BRi9TdDBs?=
 =?utf-8?B?YUtIZTJTdThHOTYrTElNYlhBY1V2bC8vK1lFZjBSbkJ1TTc2aVh1UEJPeXAr?=
 =?utf-8?B?TVNPLzRFNTlKY2l0eUpIa2llcXBKZkVNMjMwRUQ0dkwxbExvV2s1cnlxUER6?=
 =?utf-8?B?WnlwVVFVZUtQM1l2c0N1WXNTeFdGT2UrY2VVeEovOThkZFhVOHZsd1RvSFBS?=
 =?utf-8?B?OW5SdS9rK2p4UmlNV3VydGhodElNMzRxUGlUYWhwQzF2WExySnlpTzFWMks2?=
 =?utf-8?B?dExJSm5UN2IzZGh5YzFCemJvVUVMMWNuRU9HSFppNjVPcGNIaUZoN0l4ZS82?=
 =?utf-8?B?dGlUV21DTDJ2TlhuQXZqTVBBbFhPR0JYZWxNVEdkcjI4R3l3SW5wc0p5aFlv?=
 =?utf-8?B?cFVONUNYWWF1ekV5anJXK2RpVW0xRjhPZkd2ckdGR3l5dHk1dnZORW1MSms3?=
 =?utf-8?B?bjJkSHlzNFoxVTFxM2lVaXA0NE9NQnVLQ2NJNTIvSFZnQ3RiT3B1VDFFYUpy?=
 =?utf-8?B?RDd2Vys5VUZXL0lRRmN5dVFISHg2Yk1JSUliWHN4T3hQM29QdlRYeUplWi9o?=
 =?utf-8?B?K0V2a0pPYkFoVWpkYTVNVisxanRzS3RNcEUwdTAvS3hMYm9kaVZjZHdlQlFy?=
 =?utf-8?B?UUUrRnB6MmdwYzFERXR5UUs2eWJaankyZVRDTTJTbzhpYkdOVStkSXp5dSti?=
 =?utf-8?Q?zQ29jVW303NFlfAs3QRpFIxOV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ba0416-1fbf-4f5c-3a24-08db61e54332
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 14:42:30.7923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKg4XBhTfvnngwCKROubh+bFzxBf9EZPTrpgrgMqAUJadV7fw6BcPU2k/9GMzqL92V3PKbTakoVwTZojggAaLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949
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

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 5/31/23 01:11, Srinivasan Shanmugam wrote:
> Fixes the following gcc with W=1:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1904: warning: Function parameter or member 'dc' not described in 'delay_cursor_until_vupdate'
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1904: warning: Function parameter or member 'pipe_ctx' not described in 'delay_cursor_until_vupdate'
> 
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 13b4e5118459..20a1582be0b1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -1899,6 +1899,11 @@ void dcn10_pipe_control_lock(
>   *
>   * TODO: Optimize cursor programming to be once per frame before VUPDATE
>   *       to avoid the need for this workaround.
> + *
> + * @dc: Current DC state
> + * @pipe_ctx: Pipe_ctx pointer for delayed cursor update
> + *
> + * Return: void
>   */
>  static void delay_cursor_until_vupdate(struct dc *dc, struct pipe_ctx *pipe_ctx)
>  {
