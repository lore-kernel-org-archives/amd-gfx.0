Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAFDE6FE3B
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 14:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31FE510E682;
	Fri, 22 Sep 2023 14:36:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A47DC10E683
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 14:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtS/GODuQeR72DKG6cvfCGHpnSFJBcR1Iw+Ino7miYpHTi/eoFHnGO3lNw3/21O/odGFRI8hLc8ZwG52fzSeABOvuaQo17lzZNGLUHKttMZjUfxHxc6yDAvxbOBmY6/ZPX9+r8U/OAS7yJMjQz6uu0RVSgrzlBYxjFKHy1qZBht5i0+JFwx2j+5Pgg6B2tkjbdKKoZtZCLgwUpa/nyiouSEdJ7SXsxsMZhmPIQWrIG8h70ib0d0T55i3UbQj1EbQ7S4kmTyH1pBcN80wtq9ueRVYjKowW9Z0WhT9tfEowyGWP18n5gnM9BL7SNXdd38iZ1ixIyodSDVfhTcZp0MLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kxnqezvoufV6ZtwZUR6Ti5u0Yhmh5qHQ2WV6uyhOpY=;
 b=VhIR/q2unDhemp/aNmYahcTCRU0eFxHwkHIuLWLTCQQVklcgbefQeTfHdwNfWOd7Nbbyn4RTecZD+j3Ha0VgrcJMNn1MxmoZ807IGH9q2icuNPOiaBVmfiv1ZBSwn7KV2F46nby6lkhyH0+p/tkPm2DsAVzPwnSjLFwLGGO/ceauzy211jRBLzFssGHJRj469RuLDQLU5+6/MySQjsjSQ91o5Dc8tayHfZuQf9UnbSmFCrrDDRP2wUTeE3wJwYSDdFK+QJjkBSEq2beV6k5tLBtsjyH/fy8eMfUFeBHU4emQvhNF5kKnr4egpNegpbZv203TIXLxjBgrltm8olRVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kxnqezvoufV6ZtwZUR6Ti5u0Yhmh5qHQ2WV6uyhOpY=;
 b=jP4DV8szdaYXHW4a2dt/yC7fGtU3J3ZVHE3zgwe05YnxJyU+XNK/XVJIhjefteCHlXe5djNgyukmQMUvPSJh4iNYoxCf4rQvaYa61+DS0WBjfEh2j0PEAADOOPjtABnXsf1SQeGfXL0O03QHUvGFFQlSeln4bfqlpOEGvz0M0+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 14:35:31 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f%3]) with mapi id 15.20.6813.018; Fri, 22 Sep 2023
 14:35:30 +0000
Message-ID: <a4b985df-8fe3-44c8-94dd-38b6b387ecef@amd.com>
Date: Fri, 22 Sep 2023 10:35:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Remove unused DPCD declarations
Content-Language: en-US
To: Stylon Wang <stylon.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230922095816.702784-1-stylon.wang@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230922095816.702784-1-stylon.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0211.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::22) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MN2PR12MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9365fc-3663-4392-4491-08dbbb792bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fh89DlB8NwM4bDvtVPAMKAWX0Jm5/qGmry0jGPee68dVC7FpevJGABUNAtIV7Ryd/lKKzaLBpTxYxJTd3lbSoDkDyjXhpDsbcgDRkdWzIvhHlzlL+GLYmEvNIOLB8GUHcjztM6ce1SyZjq9AS4aK1SmdIiDWEIlr6L412TCWDNsmYBmGFQIW2zu3r6Rd4JpXLzjN5gud0A39wyy6zPhjfcscpkLB2GSCSNoMFzkGDcbwnTG6Ymtl1Jp7p4BM+gs81LaZmxwXt7fgEstPrAwpY9/zXGx3xumeZI5EvnNcC7nJjZ+7ZOTmwVFBUTK2+Gk+k+NGYbzz22UWcsNeHLDVKawnFQGxm9rJ2hbXX5/tGKs8APFcxx07/dAqDJT+oNQ2ZY/x4jltj66OP2rWUX8QEJWF2T+c41GloB035o2e6gv8Z2/lnDBKBV20RP2eYc1R+/dWXglq8f84Kg+/1r0wHJdcqsnt/u0vf4bZEQrXWuBkMwiFxIu1Oj2DMAwmfOmp/mV3tBLeYVD4lYjRpW+id+jtTGmDrbVRhNZ+ZVbSBdIrCNX4IZCI17h5zddvsfS6wQgIJA1L8evhrxeXVwGbM0CP6pGpWT8BP6kqzqmALmmEfj5xGkB/htuWOhJs9kXUcqLS5CHwjUbx2tDCwuFGQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199024)(1800799009)(186009)(8936002)(8676002)(31696002)(31686004)(86362001)(44832011)(38100700002)(5660300002)(4326008)(66476007)(66556008)(66946007)(316002)(36756003)(41300700001)(2906002)(83380400001)(478600001)(6512007)(26005)(2616005)(6506007)(53546011)(6486002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGlUbU5NbkMrSXQ1KzMyR1hWbFlpN1IzR2NESFNhK0Z6c1JwblhhbEtkbUpq?=
 =?utf-8?B?LzBIaExON1pkcktJdk9BZGZNbXR3QXI2SkxFbGRMQ0YxeWhaaDFiZ2NBa1l6?=
 =?utf-8?B?YzFoWkpiUEdDczFONkVyRVlsZlRrdXBZdURKMTlZV0ZlbmdMVnRaenlIMFRZ?=
 =?utf-8?B?azdQaFprV29SNmNtWWF6N3FFc3UwcmY2aVhlWTY3QmlzbW9HN3dleENFVXFZ?=
 =?utf-8?B?TUhJVXJuenlPUkMzRTBWVzJqTGZSb2Jqb2RCVmk4N04xb3AwOFJSMENhTTcw?=
 =?utf-8?B?bTVhNi93b1lNc0R1K2tyMUMvTmVHY0xuOE9LNTRXWU96RldHYTB6bzlWSllC?=
 =?utf-8?B?ZjB5bjROOWw0dUQ4MGdKamlmdFR5M2VnTjErVHZzVDBCU0ZyN0RGVkdES1gx?=
 =?utf-8?B?WXFCZkZ6cEpGNDlIcVdmKzRWQ00wQ3lpR3lxKzkrT2lNRDZ4YkxsRHgxTEVH?=
 =?utf-8?B?RlE0Qi8wbE4rWDNrRlVHQ2xnZGNzNXRKSnN4am9zQ1FYYnVPWkxDSjlUNG5P?=
 =?utf-8?B?YkRSd3NSRlRLNDhmNkR3Rk4zNVc4N3RJb1c1R3dKQ2JWQTRabW9Va0JjSFF4?=
 =?utf-8?B?ODFTc1NwVkgvU1NVWkRvK2xCT25KZFpRazF3RGRiWHJxazZhUkZBNlZkWkc4?=
 =?utf-8?B?SnJhNG1xSG1BcDVRTE1ITDNhaGNUay9kQnh1QnlSZnJuN3A1c005d1hjK1Vt?=
 =?utf-8?B?TCt6cTVhMzYxM1JtM1hoL2NNTnpPQmhaN1JsRG9jV3I4VDYxYUlmZTE5OUZ5?=
 =?utf-8?B?dlJLRXl1TmN1TWNZZnZlRVVVeUhGdklIVFNkVXk4bUw2OHJJTEhXd0FHa3Z5?=
 =?utf-8?B?eFRLcnNYb28yR04wSTMxTVMzbnc2SHFWaUcwOXRrWkdjWWs1TjQrKzV0K2Z1?=
 =?utf-8?B?Nk41L21RTHdISTVSUFhRZExiSUxraGtaY00wWk1GeThvcjgzM3VqeHRjMjZa?=
 =?utf-8?B?am1QM3JkTmp2aGs5T0FkVTVGei91cXFnY1RINHd2VGVUWXlHTzdWWlpacDhl?=
 =?utf-8?B?ZVpCRHZUaUtnSXdtdmROeGcyb0RuYWtEeVpJdUhlMXlxSE5Ubm53MXJ0U1Nw?=
 =?utf-8?B?NFlMOWtYenZqTWVzMGl3V052N2JrUXNXM1FpeGZBNi9VYWtvanZFVHRLa1Nu?=
 =?utf-8?B?Rm9adnRXMEc1SjIxSk1jNmRHK1AzT1NMRGh0cTZDWUdpcjZOckp5QktHK3dD?=
 =?utf-8?B?RWM5dFY1QWpsMERpdFc3d202OCtBYXpvZ01YVk9KeFc1MGswbUJDZkx3aWZa?=
 =?utf-8?B?eXRoTCtTT3NBWm5jczB5bFF4V3k1SVI3QktYanlGeGZFR2VrbUh6QXJlOGhG?=
 =?utf-8?B?MDI1UnNiamhCTFdhVHZxMlJpVUtSUXkvc0d4Q1FtWnRMZ3FwWGhNeURweCtO?=
 =?utf-8?B?bEVNQXR5dkhQRTBiVVYwaGlxbzhzaHU3bEhMTjM0U3ZmSzdUS0ZkZUd3S3ZI?=
 =?utf-8?B?TVNIU3ppREFkM0hBK3ZnVTQyS3VEYWJVR0p5ZzRKL2xKbnZZYmVvakluRG5N?=
 =?utf-8?B?WFpKcFU1cDRpZ2VTbEpObFpiN09JT1Q0YWJOdzYwVnNDSjNnalpjdWJiZlBy?=
 =?utf-8?B?YzlQUmpTVWZPZzlnTHVZNEg5U3dFSEJoUjNtRjdiMnd0OW9vZmZwQ28xOXNW?=
 =?utf-8?B?cEljQlpULzl4ZVlhMFVNT2Z4VmFxT3I1SlBYcWxJREFMUGp3WkJJQ0orNlFv?=
 =?utf-8?B?Y3Q2TDdjcGxaVVNnREh2SllveXZLTTFXMm5zK0l5SWR4M3UrNzFZTWV6M2tt?=
 =?utf-8?B?V3BRb2VaY2czWFJtaDNEei9aaTBMUGc2NFd3d0VqUTd1cVNOTk5hSFBIOU4w?=
 =?utf-8?B?R3lDeVRsQ3lZSCtWN3QyV1UxTmpXZ1FaNUxVLzBreHY2Qm92SHU2eitwV0h3?=
 =?utf-8?B?RVIvREVVZWwyT1ppby90bTZURi9MenFjTitiUU85U01LL0xhN1l3TlVrVXZj?=
 =?utf-8?B?bEt5NkZVd2U5UzB4YWpDejhhVGdySXZBRFZPOUlqRGhsYVNTVEh1OUNMMUl0?=
 =?utf-8?B?V0ZHcVhaQ1BUUGVGYldaSUlSd1J0Tjd3MENqSWxKME03bmdBaTdCK284bHR6?=
 =?utf-8?B?aXpidEErMXFYYjdyUkpFWGo3YTRHYjhrQVRrR05DN2xFUVV5UHlnSEZDZm5F?=
 =?utf-8?Q?sXDVM4V+fQ76LTkIMyOJ5ep5Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9365fc-3663-4392-4491-08dbbb792bfe
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 14:35:30.8967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhNd6JDFf1roCCwyW/mjreEXPzdH/N7bkQ7IWT1lA/oN9BhLUC70JNykN8zlYaJXHd/R1eRlfBoXaDR3vraroQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2023-09-22 05:58, Stylon Wang wrote:
> [Why & How]
> These DPCD addresses are either declared in other header files
> where it makes more sense or simply not used by any DC code.
> Remove them to reduce redundancies and potential confusion.
> 
> Signed-off-by: Stylon Wang <stylon.wang@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/dc/dc_dp_types.h | 59 +-------------------
>   1 file changed, 1 insertion(+), 58 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
> index cfaa39c5dd16..35ae245ef722 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
> @@ -916,73 +916,16 @@ struct dpcd_usb4_dp_tunneling_info {
>   	uint8_t usb4_topology_id[DPCD_USB4_TOPOLOGY_ID_LEN];
>   };
>   
> -#ifndef DP_MAIN_LINK_CHANNEL_CODING_CAP
> -#define DP_MAIN_LINK_CHANNEL_CODING_CAP			0x006
> -#endif
> -#ifndef DP_SINK_VIDEO_FALLBACK_FORMATS
> -#define DP_SINK_VIDEO_FALLBACK_FORMATS			0x020
> -#endif
> -#ifndef DP_FEC_CAPABILITY_1
> -#define DP_FEC_CAPABILITY_1				0x091
> -#endif
>   #ifndef DP_DFP_CAPABILITY_EXTENSION_SUPPORT
>   #define DP_DFP_CAPABILITY_EXTENSION_SUPPORT		0x0A3
>   #endif
> -#ifndef DP_DSC_CONFIGURATION
> -#define DP_DSC_CONFIGURATION				0x161
> -#endif
> -#ifndef DP_PHY_SQUARE_PATTERN
> -#define DP_PHY_SQUARE_PATTERN				0x249
> -#endif
> -#ifndef DP_128b_132b_SUPPORTED_LINK_RATES
> -#define DP_128b_132b_SUPPORTED_LINK_RATES		0x2215
> -#endif
> -#ifndef DP_128b_132b_TRAINING_AUX_RD_INTERVAL
> -#define DP_128b_132b_TRAINING_AUX_RD_INTERVAL		0x2216
> -#endif
>   #ifndef DP_TEST_264BIT_CUSTOM_PATTERN_7_0
>   #define DP_TEST_264BIT_CUSTOM_PATTERN_7_0		0X2230
>   #endif
>   #ifndef DP_TEST_264BIT_CUSTOM_PATTERN_263_256
>   #define DP_TEST_264BIT_CUSTOM_PATTERN_263_256		0X2250
>   #endif
> -#ifndef DP_DSC_SUPPORT_AND_DECODER_COUNT
> -#define DP_DSC_SUPPORT_AND_DECODER_COUNT		0x2260
> -#endif
> -#ifndef DP_DSC_MAX_SLICE_COUNT_AND_AGGREGATION_0
> -#define DP_DSC_MAX_SLICE_COUNT_AND_AGGREGATION_0	0x2270
> -#endif
> -#ifndef DP_DSC_DECODER_0_MAXIMUM_SLICE_COUNT_MASK
> -#define DP_DSC_DECODER_0_MAXIMUM_SLICE_COUNT_MASK	(1 << 0)
> -#endif
> -#ifndef DP_DSC_DECODER_0_AGGREGATION_SUPPORT_MASK
> -#define DP_DSC_DECODER_0_AGGREGATION_SUPPORT_MASK	(0b111 << 1)
> -#endif
> -#ifndef DP_DSC_DECODER_0_AGGREGATION_SUPPORT_SHIFT
> -#define DP_DSC_DECODER_0_AGGREGATION_SUPPORT_SHIFT	1
> -#endif
> -#ifndef DP_DSC_DECODER_COUNT_MASK
> -#define DP_DSC_DECODER_COUNT_MASK			(0b111 << 5)
> -#endif
> -#ifndef DP_DSC_DECODER_COUNT_SHIFT
> -#define DP_DSC_DECODER_COUNT_SHIFT			5
> -#endif
> -#ifndef DP_MAIN_LINK_CHANNEL_CODING_SET
> -#define DP_MAIN_LINK_CHANNEL_CODING_SET			0x108
> -#endif
> -#ifndef DP_MAIN_LINK_CHANNEL_CODING_PHY_REPEATER
> -#define DP_MAIN_LINK_CHANNEL_CODING_PHY_REPEATER	0xF0006
> -#endif
> -#ifndef DP_PHY_REPEATER_128b_132b_RATES
> -#define DP_PHY_REPEATER_128b_132b_RATES			0xF0007
> -#endif
> -#ifndef DP_128b_132b_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1
> -#define DP_128b_132b_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1	0xF0022
> -#endif
> -#ifndef DP_INTRA_HOP_AUX_REPLY_INDICATION
> -#define DP_INTRA_HOP_AUX_REPLY_INDICATION		(1 << 3)
> -/* TODO - Use DRM header to replace above once available */
> -#endif // DP_INTRA_HOP_AUX_REPLY_INDICATION
> +
>   union dp_main_line_channel_coding_cap {
>   	struct {
>   		uint8_t DP_8b_10b_SUPPORTED	:1;
