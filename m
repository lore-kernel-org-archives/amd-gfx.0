Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C04C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 15:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819F66120A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 15:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 819F66120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DDB56E424;
	Tue,  5 Oct 2021 15:58:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 592266E424
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 15:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DARFvlVUTa+o8D3ZJXVUmze7B828znulbFfZBzRbHi+pGdZveOFyf8r/WS1jSbKArA5JaVS7ZCamRk/I1jizgkEcc9lf0EMsyaR5j0JpVPpo1Vh3lcI/LoWwBNs0ZrbD5lel6UoGo4VdInSEld3Cf5ac1hvY/chmJ3CYWNI2JPnW2AMZqqk/ps/3pcS2IscJxT+7ueqI4UNSzeUhekB8v46Qa8wmnaZLqnew1yfDlMOanVra/104FWfKJvMxRVLDMUjmXkxe5cBPlTCVKwGsDnzTqze/eOUStQEokCmzYexjuLzB1SRMJ1mWCLJFsKJ03JGZDOoKriqpyLsjN5446g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDhaVK/FWgINhREXXMBA9POtAP6DYKNZ8bXAyL3Iu5I=;
 b=EfLewoSkt3T518JwvqVkIWaqSEpNJEXORpWlg6ZFGcOG3/u7xWxol8Ij0ubw6vR6wn7zKcnVZ+mFpqX+Hgf6MCESaXNf7FzFrnW3LXEYHovfDNM7eIqTqsylKSCkeABZgL2w7x8Ess/DqhclnTGwtlxN7jdcApEVihkKjXxuoy7mVZCYDJF+ejKlRM1ZeEUShnHWe34wg7s+d2vm2uDSehoE+3vDL6sYbsJBueQmQr6mQi+295QPxoQc+mvmx83ih/fpw6m921J7kEy3upYrQNdHVd4+qvGhBCQ8pK0m8PeStm7R6N3Ao2xIzA2qrmC7JwXJp2GaidSqvlZtmlFmdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDhaVK/FWgINhREXXMBA9POtAP6DYKNZ8bXAyL3Iu5I=;
 b=B4PDOTT8g1OBbmCNJ15yQbj3UGFOXVNTQxqBWPN1sLeod0AxERVNlJVPBIs8CAhB6Q5MPbkdGooSKWM1XEs3LE9qcS+VSFx0N/a3zlA77TqEX6KBtjBbtgvAGmjt84Lp6bJ7FSshELeG+eiZUCQu8svujpUSQP7QmRFbvgqCXKc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21; Tue, 5 Oct
 2021 15:58:49 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 15:58:49 +0000
Message-ID: <892bc0cb-3593-071c-388e-d8eeb87be08c@amd.com>
Date: Tue, 5 Oct 2021 11:58:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 07/23] drm/amd/display: Update training parameters for
 DPIA links
Content-Language: en-US
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, nicholas.kazlauskas@amd.com,
 Rodrigo.Siqueira@amd.com, stylon.wang@amd.com, jude.shih@amd.com,
 jimmy.kizito@amd.com, meenakshikumar.somasundaram@amd.com,
 Jun Lei <Jun.Lei@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
 <20211005075205.3467938-8-Wayne.Lin@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211005075205.3467938-8-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0767.namprd03.prod.outlook.com
 (2603:10b6:408:13a::22) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.46.98] (165.204.84.11) by
 BN9PR03CA0767.namprd03.prod.outlook.com (2603:10b6:408:13a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend
 Transport; Tue, 5 Oct 2021 15:58:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b23f4e4a-63a7-4fe8-49f1-08d988190545
X-MS-TrafficTypeDiagnostic: CO6PR12MB5395:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB53950CE8609AF2C3656145BB8CAF9@CO6PR12MB5395.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35yarHZe2/8s4fgo/99bEfkvgfkehJGWN2A5W3sO09jQto0MdCDrCLrQwgYgMemOFvxA64jx4kWXlAzFIEm/rln6OG7A6busuh7JKe7W+lOUNJ4p+xMtYOmn9WeWs42GVy8Jp3S3oDKlGc/l8pAwJx9IJdcxreXJBaSumv9c2YlbesKai8SjWVfEYoCSKy28WIcvA1K9focuNxL0kvikywRx0jOradyk/vTRPVJNgwMDcdSrkoJBgXyAQLP5xWNdAsO32HytBCPS5OimgLlAA7ti7FAe39wo9h/utlrYQ4WkhHmH5yYoXDYxW5NUGe18YEhZ9CyQs2BDW3jWjzlCiz8skBQ5RSzRrCzbdFIT1/ltR1uxs3XPcEw0xp5qYYKN6qHuc3vcGOsY8fkBljBbEmw+WBu9SPDaXvn6Ct3a5QqYc7cfWSMF/u18BKNmVxXo0kct70rrFwO8ywL0zmJLmCIQdvdUIqVvPKeAUXvHRxawjOtR/CPKWsVm7a6TjK9TQFB6BlvrGe5X2hVLQNdz3ER8nWgtRYl8+TtFeflgIndjR+UuCyJ2To31FJbSNddRtyCDJBGQlgt7Xnjd8dqSDl6lIkRMLxQVvkTbWUDRmPzGNPjvwnHmwJ4iVfeHp0LUO8HrXIl1BDKillVkUAH9EEHIhE7ST95y8Ootb6kk2Ff/dBf7VLz+KAt9TvuPW0ofHkQZwnjQJSN0CUSrNAVOG24AFisHRH2udniYIAeWoi0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(83380400001)(8936002)(6486002)(66476007)(4326008)(26005)(2906002)(186003)(38100700002)(44832011)(316002)(8676002)(2616005)(66556008)(956004)(53546011)(66946007)(16576012)(15650500001)(6666004)(86362001)(31686004)(31696002)(5660300002)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzhsQkJyYURTNFd0MEJkZ1Z5UEdBMFVYTGZSUWc0bFhpYVNYU1JNMWRmU0F5?=
 =?utf-8?B?VXM3Y3F3UXhyNmJsdzdGc2tVS0hFOExXZjlOQ2g3dEpvZWFpVjZ4eW55eElN?=
 =?utf-8?B?UjQwUzZvdGU4SGVRRVIvNytxQlJTNExqeldTSzJ4RldhcFBOWG1oSnRVTERP?=
 =?utf-8?B?QnNVTkJJOXJDc0FnM3MwV2pUOVNGcjg3eFhQUU9nM3I4clpkSDd3alg0bW00?=
 =?utf-8?B?QlJmZkp3Vk81R016QjRYc3UyMHJYVFlGUTFaUkFTRUZoVnB3ODhYRHVBQ3VP?=
 =?utf-8?B?RmJTS2FQb2tiUkVLYU54M3FWaUh1NWptL0pkY2FvN0hZVnZuYjZza2Ribk9L?=
 =?utf-8?B?MlBQZVJPdEp6S3FBQThqeEVRUWRGRXM0MjVqK1NneXBHRTRwVTF1T1BVc0Qw?=
 =?utf-8?B?VmJodmhidjZjZUFVL0pBZHVtNnBaRHpXQ0VRSU9zR3grSmRWR3hNR093N0Y2?=
 =?utf-8?B?NWY2WlpsZjhFNWpKazZQcEt0TE56QmMyMTdqYlJBWmRrRG94eDdpKzlXc1V0?=
 =?utf-8?B?M2VVVG9XT2FybEwxQ3RRaUJLTnhKNEVzbVpQdmIzWFphQW8rOUF3dFhxQk83?=
 =?utf-8?B?eWVOUExLKzYyRWw1RXd5Yjh5UkRBMnIrRUxEL2pSbkMwSXdjYWltam1DeE1V?=
 =?utf-8?B?TDlRamsrSVI5VU90V2dkcHE2MCt6ZlFQY3lZUjQ3dlZrYlhnM1pDWmtBci9Z?=
 =?utf-8?B?QkhPNVRaMVZkeVV5aU84cTNwaGZTc244eWNZa21vZTFSL3Q1T1JtZ3lyZE9w?=
 =?utf-8?B?WnNQaDZrL3ZSMG1LNXAxbkZwOXkxM0pLRG1HQUhUV2hnM1FubW50Y0oxb2tv?=
 =?utf-8?B?RnRvNDRKc0tzRnRRMUdqUWY1MEJlU2xuZjlBVVN0SWlvZW85VVRxZVdnSnVV?=
 =?utf-8?B?Uk9QY09MWGhJK3RBS0xCdGlBelpsVEVxaDVtQUdrNkdIcHc0cm4yMFJRY3J6?=
 =?utf-8?B?dmo4cXdOVXA2aDFSSXovMVdEbE9jU05VTVd1SmxGUHM5Yko0aG5MNVhtMUxp?=
 =?utf-8?B?Q1E1WnhXRUh6M081U2F4M1lJQWJKSHJPRDFXb3NncjRMcFhGNWZoNnBxTjlt?=
 =?utf-8?B?Y1FNY3MwemZsSW9kR05rZ2VXTWsxQUZCU2JGRVZ6emV1SGpGdmhnM21QQlpK?=
 =?utf-8?B?ZDUyTGtJTlMyTzArcFdOZ1ovcStRT1RiZkxqOExsbkswLzR3WFpkNGJ6N2dW?=
 =?utf-8?B?NE1MT3dLWEdkQ2FDTnRMZE04WFZzYkUzRVZEWjFia3IwWFU0cjdUTGxJMzBV?=
 =?utf-8?B?NW4vN3hpODA3eG5uMFdKWjhRQkg1c0ZZMWRwMGRjTkw2M1JkK2tDNzBDTTRz?=
 =?utf-8?B?NUZCNXRCbUs2QlhLUS9DaEZRdnRVcFRTNUZKNExCa3JOOFhuTlVQVVAwTzNC?=
 =?utf-8?B?amlMeEJmZTdDSytOeEw1cWgvNS8yWVpQeENnZnJ6QVRBUVo4ZWxsSTFnMjE5?=
 =?utf-8?B?cld4VXZLRE14djdSSWJHU0h4bkw4K3hiOWhrK2IvNjhiYkRKZS9sdnNqNHJZ?=
 =?utf-8?B?ZDRwUDVXQldEQlZqZy9FOVMzUHQ0T3RFTTQ0YjdIRUJIUStuTU1lTlZSNEhy?=
 =?utf-8?B?ZWQ0LytYUmtubWs2NTFGTW4wMDc1Rnl2WTdIeDJMeEpyZ3p5MmZIWlpXOWhC?=
 =?utf-8?B?dVVxdVpvNSt1NWgvQ2U4a0dIR2VneWJ0RUJvWE9XS2VXTmxUc2VHSFJsRTRz?=
 =?utf-8?B?RHBpS1VWckp6N2xuNUlDaXVkbEdjMnRHS2hTcC9OTVAvaFV2clBNeFFsbkRB?=
 =?utf-8?Q?NtfCPqWiz5S+8LBLi6Ch6ejqvqJjSI9AcMozMjG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23f4e4a-63a7-4fe8-49f1-08d988190545
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 15:58:49.5345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFtqNKYOWCy+Ixhm8jZCiehaXpE2tYV+o86yfDXZnqMc8eChbSQ5XZ2LnLY4JGlvjoSEKlJOJ1aLZQUdiyC0Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
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

On 2021-10-05 03:51, Wayne Lin wrote:
> From: Jimmy Kizito <Jimmy.Kizito@amd.com>
> 
> [why & how]
> Add codes for commit "ede4f6dac99e drm/amd/display: Update
> setting of DP training parameters." to support USB4 DP tunneling
> feature
> 

Suggested title: Skip DPCD read for DPTX-to-DPIA hop

Suggested description: Driver does not need to train the first hop.

Harry

> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
> Acked-by: Wayne Lin <Wayne.Lin@amd.com>
> Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 9bc5f49ea2ec..dd1d0262ba40 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -1777,6 +1777,13 @@ static enum dc_status configure_lttpr_mode_non_transparent(
>  
>  		if (encoding == DP_8b_10b_ENCODING) {
>  			repeater_cnt = dp_convert_to_count(link->dpcd_caps.lttpr_caps.phy_repeater_cnt);
> +
> +			/* Driver does not need to train the first hop. Skip DPCD read and clear
> +			 * AUX_RD_INTERVAL for DPTX-to-DPIA hop.
> +			 */
> +			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
> +				link->dpcd_caps.lttpr_caps.aux_rd_interval[--repeater_cnt] = 0;
> +
>  			for (repeater_id = repeater_cnt; repeater_id > 0; repeater_id--) {
>  				aux_interval_address = DP_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1 +
>  							((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (repeater_id - 1));
> 

