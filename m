Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3CAC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 17:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B1D61139
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 17:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B1D61139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC9F36EA99;
	Thu, 15 Apr 2021 17:58:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD6556EA99
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 17:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXaF0FHiNS1rhJ7E9xrDY77elifBQ18KkzgQBvsHJyJyn0gWxJf760UzMMV0+KJz2+jJGuv0snLVBnTXmnocNdcRVWLsgKDTlGE55fGKiPbw/ZlFovIsw+79x1MwnZbY2yX95XXAeFhbI6NJV1TAQksyzHMHsng0SEpP+jVyETdubsLdYbJDMMjnsmFpPaRhdJDodwN21FCcxa02cUap6mt0+ZyG6fxVKkQCZ22FhmyH8BHfzNF5ZkgNp+WDk48Uay8KUqddWHaWW/pYJiXtFT0s+VGiyhhVITZAJH5HOHODeD3BejFcaWIBMIpHFcID1chOPSFVkUBZRMBGnxBvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEfWNSgHiEj5nqaj5JrfVovI5uHPS2lAM4z4JZB6A5Y=;
 b=m/zrGe7DqtlK16Qxq4s6oBYaut+JztVRhrUXm+tLp1KThxc6UpsJC803BVHau0vPVF2hT5S7+zw8umFH2qOpgG3vovBFQhgknMipAATGfyttrnQwv3kXgxHf87ob58HRLdG+Fg1lY1qrc6A1Hr2V5oE62kwMizu3pTxr3Gov2n5d8MkmZ44Wjv/e1YvyYxcfnxSFKcy/cCPJkzCVgiRQQCfsOQ3lc+sObtnxAPGwSEx5LIQUShoqV0XvHuo89qUX2MymsOBFYaX8KwKBc16SiGZzhNCIQ7xFhyxnIQzubftK5tKhEUWo3z8VIehDtMJ+BxgmSYHyFY26MqczRLHwuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEfWNSgHiEj5nqaj5JrfVovI5uHPS2lAM4z4JZB6A5Y=;
 b=kQLlSIB2fb2G8Ijavrh6dvx+VZlc3nZV7xCS35NCf6892uZ4whQUNuIeB2XpC8reKlfJgRQM6XVWwyhkKQLS+vKFNdocXq+HuWxsMlm09iK3Rsz9/MqNjPTyFtNdjNu+OcpJLlCgfF4/UYVCN401Wl/zp1smyAe+C5QI4UbKbaM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR12MB1296.namprd12.prod.outlook.com (2603:10b6:300:f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Thu, 15 Apr
 2021 17:58:46 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25%4]) with mapi id 15.20.4020.023; Thu, 15 Apr 2021
 17:58:46 +0000
Subject: Re: [PATCH] drm/amdgpu/dm: Fix NULL pointer crash during DP MST
 hotplug
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210415175524.63137-1-shashank.sharma@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <accf1407-9427-c49f-c8d8-3e1169678a94@amd.com>
Date: Thu, 15 Apr 2021 13:58:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210415175524.63137-1-shashank.sharma@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YT1PR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::44)
 To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YT1PR01CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.22 via Frontend Transport; Thu, 15 Apr 2021 17:58:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14e8ccda-156e-4569-065e-08d900381d3b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1296:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1296DE61D0A65E3DCCEA6E0C8C4D9@MWHPR12MB1296.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YO6XQUPDFI+yiyBwesgQKSRahO3BJoNkLqAA9E5vbtDF0Xp68dOrMLdtG4gZSEG0QqJMOEZEYeUgxorrQgBaV9T8f3bnYwVqZFEiuSrxpinxBtiz8US1FTsS6g6/yhVMHKt6sPc1pqPMdYqvpBMmr/+XzUWJbi23i7M//hZvVgzTXW1jTGtXmRW2DOo2MPm2gsCGWgfAxxUpGBktDhfrbPC5tAMesiGZSrW/TNuEFcNHWJVI4FcqVsR9Zng0N7gXT2jShTgtJXK1CZ72hJ5pGOwpudaM7o8McCxBRV1uRWP6xvCSVVZ/AssPLIi5lpkMOWihD+uJv8DAttpobKrRhgmqc/wdexVEbp/Ne+7JOxmEtEnn+o8gautrvLhLlAcpacnAhUbUqWtLlY8c6jVvrwiVTWuumLJjIFkad9y38cIcw2qL1qR0tCXGnH2dhdJ9t3xNKthVuG4FSHF972fG/9xAk+HZ14l2TDBH0aPKukDxvEaZErbu4R0ux5YJPqNEP1eU3eHj/4hu02Pn5Vk8H78McDKwEhTgf0L/I5YJ2Vw3k44LDiCbIQzKbGQu+EBPfZuD25MsfNu/4FvVBXN4uM+YD4R9bw06xQA+uMSbjz1kSf1zPCmjfzPFVXRhJZmEOF8lcxbkOBA1HTq2McMXEQCtXRo4gik7+pxSUBXVBKUNO7UUD35x+vAgPBTzxvJe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(8936002)(66946007)(316002)(5660300002)(16576012)(86362001)(6666004)(8676002)(2616005)(4326008)(26005)(38100700002)(16526019)(66476007)(44832011)(956004)(31696002)(66556008)(53546011)(6486002)(36756003)(2906002)(186003)(478600001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eVBlK3VQNTRBbXduNVg0R3JSZk54Y1hkeDdPa2RKOHVhY0d3WWtCZ2d6UVVw?=
 =?utf-8?B?T2xPZ09RM3M0L1JhcGwrTjNlbEp5OVkwVG1SZmY5VDdhNTdVeTFCMXU1Nndh?=
 =?utf-8?B?RnNPTk1vNXVmQzRCT2RkZXozZnBidHBmZ2JPcUlMd3piTmhTdkh2TTZXemc0?=
 =?utf-8?B?RTdBNnNmU093WHYrN0hSMEhmRUs5Z3Bpa1p3alZ3R21RRkdyUkpoSWxUZTVQ?=
 =?utf-8?B?dnNFdUlVMFAxaUlUZVk5cVFjakd0ZmU2MVRKUnQwcjhjOWxJMmtxVU5EYUxl?=
 =?utf-8?B?LzB2cGVzbFppWnV1Mnk0UzYxYlpPVW81Q2dmNERQUmFIaTd3V244MFRkYnFW?=
 =?utf-8?B?eDRLcTZuRkxIQmhKNWMwUG10MDMyck5jOW5WSjF5TkxHWFo4Vk1uUUM0RVpI?=
 =?utf-8?B?MEExOElVRG9DNmxrbHQwU0tnTWhBZXdPaWJDbFdCNUM1b3ltUjFrOWpPc0F2?=
 =?utf-8?B?bVJxQkNmb0d2U0NsalE5djFMVktLTjFQdWNNWHA0M1NJTHE2VEdwSDluV283?=
 =?utf-8?B?UkpGNXZPYVpzNUZtZDZlUktBb1c4N09LU3loZzkvcUt5a1J5WldjNUNKMFMv?=
 =?utf-8?B?UTB2L3RHY1E4S293NUlIT1k0cCs5VjdrdnpVRldwNjdRSEpiVjFPR2xKUVFN?=
 =?utf-8?B?eTFrRXB5NWVyd1IzYjlDczVlTzZkL0pMZkV1bHBMQ1B3bjg0Y3h3R3pxRVFV?=
 =?utf-8?B?RDhkMDZjUDYxWU44ZTJjUFpYVVcvMHJVVmNtbnpjamJ1TERqMVhoMUlYSzVz?=
 =?utf-8?B?Y2ExNWhXQUl6NkdabXdoSEVmSjFCRmxpanB1SGNSbS84cFBzb0tvb2VRZXRt?=
 =?utf-8?B?NjFwUUtvWU9UOElIRWtHR2NybzJ3TW84VDJ5M0VtZzhUQXg4dG9GeHBMUHJJ?=
 =?utf-8?B?OGdqazMxSEN0SzFQTnpuWHpSVTlBOXlvRXl3dVN0QmlweXdNR3phbDFPa2V1?=
 =?utf-8?B?R1pzakNDdHNHNTlwS2lrWDhCdExvWjgxc2hmVG1wSktockQ5ZjRLOUIwOFNj?=
 =?utf-8?B?NFRobVZCZXMxN01kcEFmamNENmZOL0pBQy9vak80aEsxcEQwcCtzNmtaOHd0?=
 =?utf-8?B?TG9ldkdaY1ovMHZNckxKZGZDODFXRDVSUlBzRzE4RlF4TGZDOGJoK0ZsS0dm?=
 =?utf-8?B?cHBHWk1QbFdTenZTZjhUMkVLVUFzeVBUR2c1dDcwemxGcHU5WktaZmg1Qmhm?=
 =?utf-8?B?K0lHTmx0Q3NmK0ZCVFdyZ0xtWW1XTmg0WkQ4Y1UzMzFvQTU2Z25kSWVLRlYw?=
 =?utf-8?B?b21BTkJLZ1ZRQjI4MzZaOHZ4SU5DcU5Ec1lVc1JSK0dmZXdwMm8vdnFHckV4?=
 =?utf-8?B?cXVDSW00NHYxV0hZV1VTWktQN1FQeG5XYy9JTU43dkg1c1BmUUk1TnZ0WDN0?=
 =?utf-8?B?VnJ2WGxGMmp1Yjd6RDNGRzdGOERGaUUzS1R6S2ZhRHhwUnBtd0EwMjdBNGxL?=
 =?utf-8?B?T2lpRGF5d2FlcnBSakVsdmZ5UkdlRlF3ZHJKTjVqNWY1M01WbGxDUmRpVzZN?=
 =?utf-8?B?TE1CbWQ0SVR0ZUZKb0F2NlJJRmdHREIrU0Jkc1hPQ0xjRWJkZm9OU3BzcENz?=
 =?utf-8?B?OGxxajE2VGc3YnRUMTQ5Zm4xR2hYWDdYbWw5NDVydHpsVUFwTmtTMStXY1Zh?=
 =?utf-8?B?TU0rVVRqU3BEU0RDSUtzMWorQkErNnJmc3V5UzJheHk4VmxOdmFKcis5bWpy?=
 =?utf-8?B?ZEh6SUFINmNVeW41TjdnaXJFZEtEeERqRkgyWGFCWHBLQmp1VC9YYmgwSkkz?=
 =?utf-8?Q?/O+Dq90yjvgdQvGtndN+yGKBQZgEVSrJDVSt2sj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e8ccda-156e-4569-065e-08d900381d3b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 17:58:46.0392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBD+ywTaE5I4HmIQNIH5GA7AbxrIvJfaAGt2PEWHhLx0C2gLBlWpQE2R7zBxeiRUgYTkglMbZ4UGeTyqPDQL0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1296
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-04-15 1:55 p.m., Shashank Sharma wrote:
> This patch checks the return value of the function
> dc_link_add_remote_sink before using it. This was causing
> a crash during consecutive hotplugs of DP MST displays.
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index eee19edeeee5..8dc5005bec0a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -226,6 +226,11 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
>   			(aconnector->edid->extensions + 1) * EDID_LENGTH,
>   			&init_params);
>   
> +		if (!dc_sink) {
> +			DRM_ERROR("Unable to add a remote sink\n");
> +			return 0;
> +		}
> +
>   		dc_sink->priv = aconnector;
>   		/* dc_link_add_remote_sink returns a new reference */
>   		aconnector->dc_sink = dc_sink;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
