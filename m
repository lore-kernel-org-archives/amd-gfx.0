Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A12C77B6E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 20:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD1A10EC0A;
	Thu, 13 Apr 2023 20:01:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D834310EC1B
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 20:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5H7k0hLCyc80hPHLwdHIZGmvXa1GllaDWAhztL7xTSHEoOaf3dv2xkl1OBGmHtT8hSm1oSm5+GS9RLPiyqMjUoJYcbx1Zz47SZGx/imnl+oDArTlpowzVGn9m7kfQUuWph1Yh4jAQTjZylPWEJkybFMs88Hu/I4eRjizzFo10wZ0XwhQmBz8wBSmMBRWflePSTR73A5dkPzS1qlLaPNiN82sZMnoW9exep/SVf8Dg3uDigwVt/4YVZcYWNTnqZzgf0YOPkF9KV6K3gglwkk9wpe/qauW4RivDHIQcObDTOSRrYgMyW3k/9YbEoCl0hFe1+mCuZOiDblDID2UwFeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIi3SLl9fvWgTHOSpk/+O26DVVsTy49D7BNXZsc48mY=;
 b=XqGH6ZoIX6wez6muuAqvLK+YZwr4hUxqti2SA2iBF6h/i7MDrJ6nq6j4mURdjX/pDrjzUKcTUwXAbzbwK7sxXL2QNlXMurEO2Q71b4UbzpdlxYwBKBawnQ41cmfMD1DshvKiIoyqGSfyqxBxOK0tK54LUpI0h/a+L1Ukwv3Bnxki+s6L9rMe0qJnyxZ9NnDErjUQ+ycXtztW2kn+wyvlf7ZZNjM1D6OIEdNywYqxlwu+3nR4AdelBNeKyLJzMxkkjWb069n+dReOsI8xbzMBLIhd87A83X1VjjgVVaMKGCUek0yLVBKT+jzgt7kKw0X6MA4M+BYUm3e4dgDxYzAd1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIi3SLl9fvWgTHOSpk/+O26DVVsTy49D7BNXZsc48mY=;
 b=L57+ifuuRErRJtlU9htoFABmrMSdQ3jZFyaZwINGGz3+InOJ864BOIiyLOwaDId19U2Ip9neLNzurbOI9n9nwocSxR2t6ZApqVML9aF6XEfNggynCIAXqWQo/ELO9693LitKqqQvMSWl0c6aFQdwlbDx9F5ECmEg6f2vNvUlTsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SA1PR12MB6823.namprd12.prod.outlook.com (2603:10b6:806:25e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Thu, 13 Apr
 2023 20:01:12 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3e54:627b:ceee:ed2b]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3e54:627b:ceee:ed2b%4]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 20:01:12 +0000
Message-ID: <240af47a-c0bd-625f-3c39-e9f58cc36035@amd.com>
Date: Thu, 13 Apr 2023 16:01:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/amd/display: Add logging when DP link training
 Channel EQ is Successful
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>
References: <20230413195635.2368590-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230413195635.2368590-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::27) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|SA1PR12MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: f41891a5-07a2-412a-7f8b-08db3c59d4bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rKjGCtBV3trPLbSm8PcoaAXglZEE6ngqaK0hYDtW/ThzGIpFqJVaz2ykOkrUlMeGkCpELqPrjN/ydCKsl+ZoXVv1sl6WIRBPVHsyoJ2bNa8Pc6KODbBaJey3GTCGxQ3hiK0K5Vgswfpc9j2G+fPiMXS6fcmBURkegC+n5wOpYzOQkHYuNG5EzENkvuQMiuIjaWUY0iix8XFYwQ2Sv/uqiB/8ByWfY1y3v/peVfmb/AXGmDWT9DQPRsUJ2j/2zoZDQAnjkQvfKyNfSNAOf4PO3jPEcdDzI9KYC3BEzBMNnUmzpBl09auBEkBnR5j9mwxokWTs/PGGvvkUEcJxG9H8HN0nOPu69giQGa4o081qNlZz9PwpAs9WvVFEAH2XQCqsKzJcU3LiH8c7VkDim08CgPDhd0M9hoV6B0aq1b1jeKRDeb8oXR7hI24hE6eVQ0Px7s7H3Ek3NCwvzjiBXjxAfez9ayZ5m0ZDpiS6ImIcdAZXhNAR9uYGLkWb3VMF/vhGhbXUkE403VPJf06qbdaFUl2Evzb2ArLS+SRN8yj+H9dASO705ax5W8HdM++S+zX5UTjp+DAq2v4A25o2EumscjEPSGUjfM85OUyzVe2Prfh/tXFs4ptOqVAqu0fYx8qokc8ih7RMwPWA6KleeuDZ5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199021)(8936002)(44832011)(6486002)(5660300002)(31696002)(86362001)(4326008)(66946007)(2906002)(66476007)(66556008)(8676002)(478600001)(38100700002)(110136005)(316002)(31686004)(6636002)(53546011)(6512007)(6506007)(26005)(83380400001)(41300700001)(36756003)(2616005)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUZGcGE5SmZTTk85SHpDQXR6YjA0SmpCSGpJT3FqcUNUdlFxY0krb0I5d1la?=
 =?utf-8?B?UUVRSk1wd2J0K1JBUkxOdHQyY1pFNno2RFlibXdPTlVLb0s3NU5hdy9pd1NY?=
 =?utf-8?B?RGZHUDNiWHE1aFpPNE5COTlCYXh3K25RMUo4T3cwc2hQVWErL1dmYXhhVHNp?=
 =?utf-8?B?Tk1MU1ZBdmxUR2VkSzZxbG9hYXk5MGc0azYyc0JWaklxbWxZajlITDZ4VGtk?=
 =?utf-8?B?MjY5S21UWERiOUFsZ3J0UDR2UGZRK0FCbWtoakN0cDNmSVRSK3htUkxlQ1ls?=
 =?utf-8?B?RHA2UEhVOVNrL0pkcmxwbnRVQ0IrbkMxbkg1bUF0STFxMmVnSEZIcDdRQmJT?=
 =?utf-8?B?SmZ5bHBhTWpmTGh1UWhOOUIyZ1d2K2N4SHFQNzNXdTFXNURyLzdhQUZqSnFs?=
 =?utf-8?B?b1RYZVlWWEpLMEZKQ00rZUZySFpWeXNQWVluUnZleFk4RVBPT1YrS0J6THhU?=
 =?utf-8?B?bWdCT1NQbTYxQ2t2ZmxSbjJLM0hKemJGcnZ2TS9iNkJVK21uS1p2ajF5ZEVO?=
 =?utf-8?B?d25Nak9XaDlMWVFtSGpvcE56dDk2L09ORUs0aitBTmRyV0VuSmJCbCtHeW5T?=
 =?utf-8?B?a2pDL1hyUGFCanZ2MjV0RFZUYWwwdmNyNUppNGQzSUpnNTQvV0gvS0NlZjds?=
 =?utf-8?B?Q0JjZXRxYVBWeGZ1RXc3WVp3SFNURVp0bWI5YU5uM2gyUSt2Sy9qVy9BaUhQ?=
 =?utf-8?B?bXd1NSt2QkhIMEk3d0Z4OVJXblo1bEFsODRQNkVIVk9MYmRGSkkrQmN4OHV6?=
 =?utf-8?B?aWQ2YXlFOFQrQUsxWG9GZkZZcmFmaXhHbFhMRzBHdTVmVjluTzVZSUZVU1lK?=
 =?utf-8?B?WUtrWlA5aW5pMWxaUy9hMElwSlZkdURiWXZ1OG1Pd1VUZWZ1bU1GWFFDMGlD?=
 =?utf-8?B?MzdPUkg2dEpVWWxYek1tZ25sWFpvOGorMmZXL3o3L09KV3BmWlhldG5pYmd2?=
 =?utf-8?B?aGNVUllGS0sxdmRKeW9kWmhxRDVHMEpmbkRxTXR1TlBTSUY0cnJmeVAySStI?=
 =?utf-8?B?VmE2SU1VVmd3dzZndmU2eVdGR1RNQzhLNDVuSThHTWNMWnFWYkY1ZUxKRXJE?=
 =?utf-8?B?M2VPOFpBc0lKdXhXZCtsVWNBS0N4KzVGODYzUHZ1SCswa0ttNUx6alFTYjcw?=
 =?utf-8?B?OUQwL2ZPeDgzMnVKTUM5UGhjTWZiMHpKSlBKbExrY2pUbWpkODU4NytzcGRy?=
 =?utf-8?B?L3ppTmFsclg4RENhMkl0cmI4cmRDL3ZaN3Fob01Ocmpla3R5czBSd1hWbmU4?=
 =?utf-8?B?NzJOZGFBdElYN3JxOGZXQXVVbnlnNzA3ekRvbGFwaHk4Sy8rUGs5eG5qcWVv?=
 =?utf-8?B?WWJoYVdMdm4rdGhqNkxwSHAwQXNmWEF6NnBOdWgxLzMvdGFhZXZoYU1oQXBZ?=
 =?utf-8?B?Z0orcFhPbGQrT1UzNzc0UXEyOEluR2l2R1o3dHNpWTcrbFhaUTRRU0FQWFdM?=
 =?utf-8?B?RmJPSjlWQ0I3VWM5ZGpIOGU4VVU5ZG1uU2NvZnZtUzFDTjNLdTNJeTRYZ1E1?=
 =?utf-8?B?bDFlRXdIM1ZIVFFkbEZQMkNyNGRlN2JpNUZUMDNhd09MclJYQ25UdktnRnJU?=
 =?utf-8?B?MHVML0h4OEN5dEhuY1NRZ1BPa0F0aUs5dFhIL01vYjRQYW9IOHFKb1hnbjgz?=
 =?utf-8?B?Y3U2UmJ2RHg0aXA2QVZHZy93UnJ0V3UxRkpqNTRmdklEZ0JIZG03dkdkWEpH?=
 =?utf-8?B?L24xUzZaN1JuaXYrZlU3MjFQd3hQeWE3dmIzV3k4THVSM0xsQTNZYit4Tmlq?=
 =?utf-8?B?RUdRUnNydWFGa3BqVE80RTRXY0RRTW96S0pOdHNIQmVmSDVBK0lXMnplc0E5?=
 =?utf-8?B?T094RXo0SVEyWVlwT0FaMXByMXhYUWNOUHJBZG5DQTlaaEtndm45ZVRMQXVz?=
 =?utf-8?B?ZnhJWkNIV1VXUlNadU1Kb1A3LzlURjJzdnZCN1UvbFRoazFldGdNUGFhRWNK?=
 =?utf-8?B?dU5UdHNxWmc2QzdSR1IzQU9uVUpxRitxR2dQdXpsQzZMcWxNZGlWdEh5Z1pj?=
 =?utf-8?B?M2lSbjBwaHNSSUZPa3VUbnhGUnBZeStDRlVQaGlHZFBMc1RBKzdscHd2bi9o?=
 =?utf-8?B?Z0VObDJXVWg5MkhLZnFna1NsNFdraG5WbVdpSTFNZE1OcEY3dThPNUJLYVlQ?=
 =?utf-8?Q?RMGYF1fzOP6Av5OVIsD2SVy2e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41891a5-07a2-412a-7f8b-08db3c59d4bf
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 20:01:12.4185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExYnHSmB+LynOIhCkY6UdYzAV2uEw1iWWvQnJXiBIMqX0rdWuIMu41mMyhZlbEBcX7qK0p0z8NfM9HJNmOymZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6823
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



On 4/13/23 15:56, Srinivasan Shanmugam wrote:
> Log when Channel Equalization is successful,
> and DP link training completed.
> 
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../display/dc/link/protocols/link_dp_training_128b_132b.c   | 2 ++
>   .../amd/display/dc/link/protocols/link_dp_training_8b_10b.c  | 5 ++++-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
> index 23d380f09a21..db9abb7ceeb9 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_128b_132b.c
> @@ -118,6 +118,8 @@ static enum link_training_result dp_perform_128b_132b_channel_eq_done_sequence(
>   		} else if (dp_is_ch_eq_done(lt_settings->link_settings.lane_count,
>   				dpcd_lane_status)) {
>   			/* pass */
> +			DC_LOG_HW_LINK_TRAINING("%s: Channel EQ done.\n", __func__);
> +			DC_LOG_HW_LINK_TRAINING("DP 128b/132b Link Training successful\n");

For consistency of the printed messages, you can either drop the %s or 
add it for both the lines.

>   			break;
>   		} else if (loop_count >= lt_settings->eq_loop_count_limit) {
>   			result = DP_128b_132b_MAX_LOOP_COUNT_REACHED;
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
> index 14b98e096d39..41b38da9feb4 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_8b_10b.c
> @@ -337,8 +337,11 @@ enum link_training_result perform_8b_10b_channel_equalization_sequence(
>   		/* 6. check CHEQ done*/
>   		if (dp_is_ch_eq_done(lane_count, dpcd_lane_status) &&
>   				dp_is_symbol_locked(lane_count, dpcd_lane_status) &&
> -				dp_is_interlane_aligned(dpcd_lane_status_updated))
> +				dp_is_interlane_aligned(dpcd_lane_status_updated)) {
> +			DC_LOG_HW_LINK_TRAINING("%s: Channel EQ done.\n",  __func__);
> +			DC_LOG_HW_LINK_TRAINING("DP 8b/10b Link Training successful\n");

Same here.
>   			return LINK_TRAINING_SUCCESS;
> +		}
>   
>   		/* 7. update VS/PE/PC2 in lt_settings*/
>   		dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
