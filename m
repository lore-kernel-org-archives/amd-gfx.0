Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6373C77B76
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Apr 2023 17:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58CED10E58E;
	Mon, 17 Apr 2023 17:15:35 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7191F10E56C
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Apr 2023 17:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUC/iwgEaXFR1AGQCHA0EBz6xDUWKjwf9+hMnRRkdUHrLfvehzW8peKMWDHPkIsm09CXof2nh1uCq9IZkafMLiYnMNC/2VmrZM/ZPVcHHYVtGslxSLSUaat8Uiueusi8HPE7vjLXvEz0bTj+LTeZtl4XvmyW275IVvKKRjAkqbL4KzeznbWRTRQcDkE+iw8VRytsBVp4wtVxBBwxRi2R5DzHCaJ8qUUwHFYijQiTz5aU3W+8Z00OUMbM1mnA15w5ac9B5qnq8nn+TxKjHhJo5C+3IRLvbsN/dxT/QOgPZaQ7yY9b1ajHfQfcXzwR33WDaQxvYFMRjDm9280y+aBhHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wd/nI+Ns0PPtXkRKfixCoONldkcJTdodtFhdo8TXlXs=;
 b=FVw/Yrgtd1R+RhtT4U+UjDCJ1NNQe8JP1PA3nsPOl0PjiDlfvelSvy67G9gPt4vT1S5SqNXtNcXOiodDOYIBGzjQRzRkoajwu4rmsgq2qQtj6L59bMBfZhTQqSGIMTTarUSKzSh4zZLMUUOIiAP/De5BMeAuJXNukqk6Op/obQDRhpuXSgfEtDFBeMe+60M2PuB9U86WNvrsZ9WTOgN4qKpH+I0Na1GDkWy0tK+if2fHVLR/RQOKKWuFSL7QAI7CSXNgSIuC+3bgokxK5MfKBoDgKjnGYMv9Lh02dlWPXlTNrky7NY8PORcr6nq+/Z3RiqV9SMEyKzxqYbid+2DJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd/nI+Ns0PPtXkRKfixCoONldkcJTdodtFhdo8TXlXs=;
 b=W/9hRASZ8hCK2+z345v4K0Dg9RZ3fhot9ZGWiKi0/2GaGOhBwnXKMSPgYL/DMJEcbQpzZvuSz+JrwFrsEbDP4y/4T3yFFhY8D4ikgpYUZ+jJ21ItYzKB1mXTnhb42I4gPbCYBai0sQ3g771As1fx+e4NT7Ebqni1u1h5CyKJG4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by PH7PR12MB6834.namprd12.prod.outlook.com (2603:10b6:510:1b4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Mon, 17 Apr
 2023 17:15:30 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3e54:627b:ceee:ed2b]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3e54:627b:ceee:ed2b%4]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 17:15:30 +0000
Message-ID: <1e935240-fdae-cff0-5aca-f57703b3e6ea@amd.com>
Date: Mon, 17 Apr 2023 13:15:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3] drm/amd/display: Check & log if receiver supports MST, 
 DSC & FEC.
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>
References: <20230417165734.3812299-1-srinivasan.shanmugam@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230417165734.3812299-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0368.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::9) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|PH7PR12MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: b0846756-a932-4953-1a86-08db3f6758b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mCix1ZEcsbYAsl0fksIvQPZD1ND+vCKjlJ3nBZq/m3n6Mc5invH7xUlsv9h586Sn+wgEYVfgh055X+9UkCaoxANO5sivpxr9HoYYDLtdWJWhyI54uXOLk8WOeg0+11t6/kxda3WIO31QE1hg67EAsJ+dZoF/wd6y+cN2bXff2EhUy8mrdeVP5PWJh6rcOqGoBvwke1C7cxenVv7fImW8faxHVPekx2AAArTs6kjy3uN5cIC8kbRZmbAXlbUyNI+cY1REA1/pXJgDcwsc4XnNzPHamv6bXQ4yctF/OdP1R3wvB7mmZM1JsOrCXrRdNjpHphRrf9qo9YjHpJwL7RcPpBwTmtVd4Ute7h9za9x/cQwMg8qJnDXqus7553Ax2ng2Q7traF0IvCUC5D6waZJtk5VwhEgoLtbAP7zmisO9YvA5srSytKoHITsLQuQ26mp2r/w+XZFzDyCwi2quslq9VeCGtQcolH2E7XmKFPpd0n28DkK5DGs/JI/H9iX+J1EOEfH9LWbE3nxZoQaG7LRHk2A8A6blh5zWeiM+1HFV+QerzMzD4WuwjD6wfvj9rWfK0Qmt+ErGaO5SDRqrHEweLGCf1ML5Eup3NnKjK/zVejILH1W9CvKDfHYySakKSyVTMH4JlXvVhf7TxkPckI6cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(53546011)(36756003)(66556008)(66476007)(4326008)(316002)(66946007)(6636002)(110136005)(6486002)(478600001)(8936002)(5660300002)(41300700001)(8676002)(86362001)(44832011)(2906002)(6506007)(186003)(26005)(6512007)(38100700002)(2616005)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTYza1JQbzJjbmxYaEpscGpjVjRmSFZZc3EwTCs2S0lhMnpGTGJWalh1Q1Jt?=
 =?utf-8?B?czQ1elp0aVJOeEtPQ3VFdlBGMDdPNkZRV0tac085ak1ZcFEwQm95dE0xZkdJ?=
 =?utf-8?B?S1BabENKQXNCY3pDZlZRZG1DL1phWnZ2VUlzTzg2eFNFbFcwNVExYUM4STcz?=
 =?utf-8?B?dzVvNGVMNmV4TzVyMFMyeXRubzhURmpOMTVuUXQ0ZzBHaWJ2bFh3T2VqZ2Nt?=
 =?utf-8?B?c3hHenMyQXQxSHNjUkdsNU1jYkdLZEl0SkZ6blY0RWU4dkVCdXBxd0pBVGt4?=
 =?utf-8?B?Tm85Y0dsZ3VNSDdsVkZnUDM1SVU1UURtRDFWL0JiRDM5L1MydnNMN2tuZW90?=
 =?utf-8?B?MHYwTExjY1FLeGNtV2RRbzc5aXJLbTY1a01Ed1NZRUkxK3ZvWHpQbUJOSmlz?=
 =?utf-8?B?eEludGJaY2JFY2txbEc0SFJFWk9yMnVYUGR5N1g4Mm1OS1FiRm01bHA1NE5w?=
 =?utf-8?B?cTc4cTdnZnYxdVRSQjhWTmptUERLMXdxRkF4bEh2VUtWK2UrWnpGcmFMNUEz?=
 =?utf-8?B?TTBvN25vWEl6MDhKOWh2d215cDhuYjlrL1B4ZGt3SUNwNUo1R05IYTdrMkw4?=
 =?utf-8?B?SG91SUVzVUNsQjNDdVM4S1BqMDN0cnRVUmY4MlZHdWJ4anNZMkE0RGZWRFNL?=
 =?utf-8?B?RzFSZ25yYndHUHlVdklCWDlXWmVEeGx1OWpJMXptS1Q5dllCSmYxMWd6NUN4?=
 =?utf-8?B?OWZ1R2tGSWh4eXdyRlVONEF2ZkZXN2Z0RnZUa0VyQ0hIWHVkeDMwZUMyUURF?=
 =?utf-8?B?alVnV1JaMjZ0Yyt6VnpPNXhidTBWdkVhZElOSER5VU5wcGdhV293QlEwRUNl?=
 =?utf-8?B?UmdWMkZxT0Y4dm5YZ2gxZVJ3Q1FnaktvMkRVN0VqNTNuWEZvd3lmRFpHSkZs?=
 =?utf-8?B?bTJzNWtnbVNCMTRtNlJMZFBlK2pmaUk5NDJxanR5UVZBbVdxK2hJcmhUUFFx?=
 =?utf-8?B?dFdzZkk0Tm5CWlBURWRjajVhblBXNnV2TDNiT0sxQ1pKV0dIVzFMdkVPWW5V?=
 =?utf-8?B?K3ZnV2czc2RXQWxBR0pnWWxCbHA0ZWd6aW1UdGdmbjZmT1lCZXBMbXZRejZR?=
 =?utf-8?B?THE5UXNsTUFpN29HSkk0T1FneEw1ZEdTbnFNQkZDcHBaWHR6a0NuOG5rdmFz?=
 =?utf-8?B?bmNtdVJXaVAyVWRrV3NpTzdQVkhZcmYyV0hYN1V5TFZ3RWcvYmhLaVRDdkJ4?=
 =?utf-8?B?OWs0SUprT1FBTFgxSCswN1kzZEREc2JlN1lSSHpDRzl0czFPOFJwWkFGNlMx?=
 =?utf-8?B?QXBWb0FubFlDaVJFS0g2aU1OQW9LUXV5bjJ3ZUpIWVI0TDR3S016UE9GWm5k?=
 =?utf-8?B?dGc2MjFhNm1xOUptUDBldlRZUUVqcEVxSUVTcmdCV3BBcEZVVStna01FUnkv?=
 =?utf-8?B?Wmd4VGlLalZVTm1JTG5yOWhBRUVGZERCcWcxWTBUUXVVN3h1OWcxS3ovNFl6?=
 =?utf-8?B?SURyRFBwbG5ldS9zcktRY1pxNmJncTVyU2ZwaXhLUEJ0V0lNRXZiQU80eFI1?=
 =?utf-8?B?TTl1VWFNM3hZUE1EeDFjdFNYRXlKWk5KU1VSR1VQVW9MT2o2VmRlS3ZlazZX?=
 =?utf-8?B?WUZjcWVKTDVnT1hTd2d1Y1FCaWhkdWc4ckNFVDdSWWVzOGU1TUJ1dXZJNmFr?=
 =?utf-8?B?cWVvc0xNeFQvR093clBEd2N3MVZmRVdMUFlKUFFFZnZNTHNZa2VaaW1kcjRr?=
 =?utf-8?B?SitsNmN6NjNSb1VoemUvY3NvV0Nvd0JXV2ZIZFcwNnJOOGlsU2VkUmNmK0JQ?=
 =?utf-8?B?WmtkYlBCam84YkZsbS9pY282bVgzQStzc1I4TnYwT053SGdlNm5rMWtybkFx?=
 =?utf-8?B?LytxMW5sNVBKUVhNUlNGckR1eUpvL0JUSE9sNkhZWllQUDV0ZTRlSHRIOUZN?=
 =?utf-8?B?NllUZmcrbXQwUHlpK3NGNUg0bzI1YkllZktzTGpWTS9PbW5hNXNCZ1o0S1ht?=
 =?utf-8?B?T0dWY3dxOTVzNmdCVHQ3SFN5WHZkUXZKN1BHdGRxSm5XQXJONlhMcHR3WSsw?=
 =?utf-8?B?K2tnZEpic1F4cXdhVnBmdmNhR3V2citUNkFZdDFQNDNqTytnL0tIcDBLR0V5?=
 =?utf-8?B?eEFqcGdHQmlUaEJaNi9SdGI0TnhVRnVsUWJwNlFIWFhyYndMKzRLSWptNGJR?=
 =?utf-8?Q?8B++jBNIYgmfGKFhRyOimk+kk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0846756-a932-4953-1a86-08db3f6758b6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 17:15:30.7026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFZ3aKpJ9LO+/qsefwc9BVG30nj6LPVZdjnpazh/Qc4dP8lf0k/ToqMByYuG8RbpTaqPfTIy6p5DN1Rt5XZR1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6834
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



On 4/17/23 12:57, Srinivasan Shanmugam wrote:
> After reading from receiver via DPCD, check & log if it supports MST,
> DSC & FEC
> 
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2:
>   - Added %s: to print the function name.
> 
> v3:
>   - Used the defined struct instead of the bitwise logic here, like
> fec_cap.bits.FEC_CAPABLE. Makes it more readable. (Aurabindo)
> 
>   - For DSC, it would be useful to print both basic DSC and passthrough
> capability. (Aurabindo)
> 
>   .../dc/link/protocols/link_dp_capability.c       | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index ba98013fecd0..59adc61156cb 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -1554,6 +1554,9 @@ static bool retrieve_link_cap(struct dc_link *link)
>   	int i;
>   	struct dp_sink_hw_fw_revision dp_hw_fw_revision;
>   	const uint32_t post_oui_delay = 30; // 30ms
> +	bool is_fec_supported = false;
> +	bool is_dsc_basic_supported = false;
> +	bool is_dsc_passthrough_supported = false;
>   
>   	memset(dpcd_data, '\0', sizeof(dpcd_data));
>   	memset(&down_strm_port_count,
> @@ -1696,6 +1699,7 @@ static bool retrieve_link_cap(struct dc_link *link)
>   
>   	/* TODO - decouple raw mst capability from policy decision */
>   	link->dpcd_caps.is_mst_capable = read_is_mst_supported(link);
> +	DC_LOG_DC("%s: MST_Support: %s\n", __func__, str_yes_no(link->dpcd_caps.is_mst_capable));
>   
>   	get_active_converter_info(ds_port.byte, link);
>   
> @@ -1803,6 +1807,18 @@ static bool retrieve_link_cap(struct dc_link *link)
>   				DP_DSC_SUPPORT,
>   				link->dpcd_caps.dsc_caps.dsc_basic_caps.raw,
>   				sizeof(link->dpcd_caps.dsc_caps.dsc_basic_caps.raw));
> +		if (status == DC_OK) {
> +			is_fec_supported = link->dpcd_caps.fec_cap.bits.FEC_CAPABLE;
> +			is_dsc_basic_supported = link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT;
> +			is_dsc_passthrough_supported = link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_PASSTHROUGH_SUPPORT;
> +			DC_LOG_DC("%s: FEC_Sink_Support: %s\n", __func__,
> +				  str_yes_no(is_fec_supported));
> +			DC_LOG_DC("%s: DSC_Basic_Sink_Support: %s\n", __func__,
> +				  str_yes_no(is_dsc_basic_supported));
> +			if (link->dpcd_caps.is_mst_capable)
> +				DC_LOG_DC("%s: DSC_Passthrough_Sink_Support: %s\n", __func__,
> +					  str_yes_no(is_dsc_passthrough_supported));
> +		}
>   		if (link->dpcd_caps.dongle_type != DISPLAY_DONGLE_NONE) {
>   			status = core_link_read_dpcd(
>   					link,


Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
