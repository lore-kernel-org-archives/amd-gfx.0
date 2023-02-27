Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D173CC64ED8
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 19:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7633410E2EC;
	Mon, 27 Feb 2023 19:09:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A28C710E2EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 19:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofoc7C8ElxH0MDI5mTjyiMEjaC3kG7gKYiVDLrGi6lUnDgMRqj8mSrKtwumB0Pkk1QeDbywTsO7z/JwqrPvTFmzVwADPObnnxaGes8GLls8fmLpLgzwDIPEWDkxeS5CmCRvcH9Bcl2lbBxvzU+aJ9rwGyGDSUboKfMdubgdtTXnO0JrbGRAXWAm45JyUa+r9O2zexOh9ZwLgX6Sob8zh5o5ulojOrqbV7WXCwGQZY5eM1p+VnSXGhMaBG7haRnbgqWm7SwQEK1i09M2ZvLe6mio2RxQsYxAnH1oz28NNu8nzgR07/N0p8EDGDL9HkqNP26BZSp5zQnlgtG3I82R8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQc3M0STRTdNYmyGq5i6lez6E4BTcxsui426v5gxfdU=;
 b=KlwM9CcEo+IBbMqdKUpJ0+JxqDeQwV7mJtCxc9Fzp+1wPUCse9MqaL0ORY95nVXfkHbwMoM0oromQ1Bv9OrTNXaufvD0Zp+7YnZ9ukqMvmnb/0143Uez+BHfw73l30iGdMSra5Z3TzElwvlmXWQeG7ro0adAPhwnMavgjN4JAOP0jbwyzLx4YSdy2IjifDxM3D48UEgwVCuW0/7bhzlgXTQt79bfsEZ60R2lNKAxHxElb9FY4NSdGR6o34tz5xtqghdq3IRzElHXFKfFRdELJInTPTwREdTieGMnL5KVvMdo43rKmZL+FDjYCsmf5cV9emXHnnQPZg6gIcP7buKrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQc3M0STRTdNYmyGq5i6lez6E4BTcxsui426v5gxfdU=;
 b=zDbIlBEgnDittHoDdoNxFoqSx2jHJZNER/C/lDmOAPXAOR4KMjjhdAbKvsbsuFsGzZWhoNB1cgBhCsBPo48EtuZlJ4L6JjQPQ8lF9mUMMAp7l3RQ8TskDpR1feTnmw6Bq1lnTEq86ZcCUONR+5jlxgub+u6645l7mJSvpJK5USs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH0PR12MB5140.namprd12.prod.outlook.com (2603:10b6:610:bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 19:09:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da%4]) with mapi id 15.20.6134.028; Mon, 27 Feb 2023
 19:09:51 +0000
Message-ID: <ec80dd9d-cd01-43f9-baf5-ef2d95f995a1@amd.com>
Date: Mon, 27 Feb 2023 14:09:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdgpu: fix return value check in kfd
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230227145201.2323-1-shashank.sharma@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230227145201.2323-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH0PR12MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e72a0ea-b266-4034-3ad2-08db18f633a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3q8FotclWtDpU6NX5jka1tAnEgP2rPdOS9JvgvIyS5edeYmnpIsVfR+m2u37yaWoq4wjdHIeytpP6w6jk7zxNrpTe3zOH0nVgYyuG4q7ItVENZ7N9WgWKstx2RPIOUQCyW9ZqQqXpemwtFfWd3PtyB2+f3cB9H3l79Ah5XLMPwkioQoYQrPaidO6iaoUpsKSC8u+mlJyAfioru5YK3hj7QFJzyJT2YWZNvaJ5ihaALvQM4fUcdWjR800fAuBU9sLBDs/5sAfEshxIpuFor8d+eGm9gg5RtaU21tQrNT7SIUCBfeNA6GYD2VqtGRkexw37SBfOy4xi5RDsXjy0nWX/NlwV5j+gZdTTop8bsAboibhPsN/vcz+njGVtxGujXOU/w/P/+ObfAmqkvyGm4nNB+CEqe8UnBS1uKszIQyUN5YpoYXOpITxGm3zZuHDMxAJzG23IJtOQV6lCZuB1/JP3VSbu3ex6Y1M9OLbMiTpKyQgj2pAGfbGV9cvV2rmZbxydpYapgUuxdaO/9jUlTvm1BFsXJog2ab8SkHuvnEel43qdp2AQXyZfY+o3IcAZUP+3oiQyDf2Wzhw5h166OBDbVVYXs+k3iMXYOHNrth1Bo5qEVJYjt06F5dP2wFBfRtUgu9wUW+SdlJaszJ3oZKw5BfTu9b6D54rtMLl1fxY+Vn62/0nUAMXKihgGtiHqf9E7Kze0cgFOA/JdrqN/DHmaVseop6A3l3chkdhjRF/VTA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199018)(186003)(38100700002)(83380400001)(8936002)(41300700001)(4326008)(8676002)(2906002)(66556008)(5660300002)(66946007)(44832011)(66476007)(36916002)(478600001)(6506007)(53546011)(6512007)(26005)(2616005)(6486002)(316002)(36756003)(31696002)(54906003)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW1BZGFSbE9XZlcrbDViVUxQcDllNXlFVnZhRUpPTFdQQkFVU3lCNllOb3RP?=
 =?utf-8?B?c3dNSXd4U2ErMUd5VkZXN2tESnhKL1d0Y0tDWW85VkNaVnBzRzNtNW5ML3ZU?=
 =?utf-8?B?S25IWWFBTHZaS0hyQkF4dFlIRWgrY0FmbVF0czVDQUpsUmw1UFVaK3JEOWlx?=
 =?utf-8?B?bExKSVFHVUVxN2pmWGVHM3Fydno2QXZBNEtpQmZQTHp4NHptdGV5Z2VuMFd0?=
 =?utf-8?B?MjdPZ2I5NzE0eHNtTXVheDNyQ0lMbGthWE54S2cvb2oxSVhXQWVVRFY3R3g3?=
 =?utf-8?B?dENFUVorMkdPeCs3eWg4MGZLU3ArMWt3U2Q1VTRUTVNqYTcySEFOYlE1V3lv?=
 =?utf-8?B?N3hTZXlWK3oyNlRMVHM3YWFzUXhxWVUxeUZJREFSR3ZlK1RMOUJ2N3Z3blU4?=
 =?utf-8?B?U3ZwMUZnODVBWnY5U0U3QTJac053TDc3Y2FsZkdYRzYySGNvekNmZ2xtWmR0?=
 =?utf-8?B?TmcyQW5YWnVWYi96a2lJNEREbU1OM3Y2Yk53MHFmMDQvQjVMcU9SQWtFUlZD?=
 =?utf-8?B?dTBRb05veXFESjdJOXA1R21sTmNOVVV0UTVaeklxeWVGK1l4bXQrRlpkdlJw?=
 =?utf-8?B?T0t6d0JLcnppS0xxMHFEYm9yYVNJUlV1R09xYU9GN3F5MzBMQ0x1QWlXYUln?=
 =?utf-8?B?b1VScWM1cWUrUXBhSXQyaFhFM01McXNySURBTExabkVRZ3A1SWxlOHo2OWRp?=
 =?utf-8?B?YnlxbGZLYmZNYjRoUlUvVVFuaXdXRkJ4U3BwY1lBSmFsVjBOWng3NnZ4d0cw?=
 =?utf-8?B?QUVrbWJXb2FSSmxsUUYwNFZoOEVRdkVzQmJDa1ltYzZ6TEphZGdveTVaTXFM?=
 =?utf-8?B?STMrMVdNaGkrOVhNYmJYSnhuMmZxNnN0UVdnMHBiUmxQNU9ycXBXYUdrMjRS?=
 =?utf-8?B?MVp1SXFYZG4wSkZhVXhFUzkvYnNpSnZiNmlONGVDNGwzYithbTEvbnlYRzVO?=
 =?utf-8?B?ckZCdG5zLzh2blpmSTFFREw5U3huUVg0TVlSajVaNEN5VmdpQXhad0oveHdi?=
 =?utf-8?B?K2RTZEtyZ21wY0w1NlVJdWg2YWE0bkV3eVJDcFJHU0hyTW5CdlorS0xaaSsv?=
 =?utf-8?B?ZUhoTzdRa05Jd2kvQjVCTlB1eHZwYThyaEpVWHp4cHZkZ3N4c2lNQjgyY053?=
 =?utf-8?B?a1FxY24vQXg3ZVBWNElJZGtqTForK2tSS2ZvRFhkR3RQMHhPbHpycEd3bS9S?=
 =?utf-8?B?Y3EzcFh5MGE3V09lWDJlaGlFUThlWmNjTnhaYk1iUzVkY1hlcnNNOUdEOTZi?=
 =?utf-8?B?UndLSUxuVG0vOThZYkgzdHNIb0dMZjM4VTFodlJsTnh2eFU4S1VFckFta1NB?=
 =?utf-8?B?UEZGQXVhb1p0OENMdDVHYnhIWXhYeTk0MHJ2YjZKVUxQeWU1YmZ4SjB3OTJq?=
 =?utf-8?B?aWQ5cVo0Qk0yUlFhaXpGWHdKdmxid3hQVnhocFRFcHNma1dhdStXRVZBZE5L?=
 =?utf-8?B?SlcraWtzNERPdjJlajlSOTAyQnkyWllpTThSNThtOS9ka09RQlkxcHF1WU1J?=
 =?utf-8?B?RFIzZ2xmaGtkTXhiOGpxWkkydWlpUndRSktVUFkvZGRuemRqTTJXaVZvMjZy?=
 =?utf-8?B?V1Z5dFpaL2RVT253WFduN2lscmF6Vjd6TmhtL0FFaUhiSjE5dm0raEp2TGtT?=
 =?utf-8?B?eFI1TFlYRVJPR0VLT3g2OEhWV2VUaE5iWlMyVFNocFh6OStpZkh5Z0hCU0N6?=
 =?utf-8?B?dk9IYTUybjhYNDliRTVSQllRWExFTEw5SG1PWXM0UElQRmJldlJPV0h2NWsr?=
 =?utf-8?B?b1gxM2twdHgyOFdFM2NPYm4vSUcvdUxIeDFSY2VEQ3cyQ3YxTU1ySmlwRUJN?=
 =?utf-8?B?TGRJbm9TUVRiQjhLTVpSbnFHRUVsTDZLL3FQejJUYWE4SkF4OVU2VkpGdTJx?=
 =?utf-8?B?aUdUUlFYNU1DSG1raWlIR0JGOXgxRUxmZ0U4RGgyL2RrRUlUZ01VellnaXB0?=
 =?utf-8?B?V2tPdU56VDFqcFhWS3JFU0VkVlNPbFBvTy9oTzBUNElhOGpEM0FJc256azVU?=
 =?utf-8?B?eUlqd2hSNWZsUWJoblV4QVpWMnovL0N1d3pxOUhJUVF0blFqSEREU25odHdR?=
 =?utf-8?B?SFRPK3Z6SyszekJpRlBDZ0ZkbnJwN2JiUkVNKzJ4Q1MrT2JSN1J5cVlOQ3RO?=
 =?utf-8?Q?IstAH92j7Edwdnvb0fZTHDGvs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e72a0ea-b266-4034-3ad2-08db18f633a0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 19:09:51.1792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vuie+7K7oaDHqeAr1SJb1MfU+uVaXCY6eOrh+IZzP/GuErblPin2op5XT9aMzJBCbk8yWI4MjFSHMqYViEvpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5140
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-02-27 09:52, Shashank Sharma wrote:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch fixes a return value check in kfd doorbell handling.
> This function should return 0(error) only when the ida_simple_get
> returns < 0(error), return > 0 is a success case.
>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Thanks for catching this. I wonder why this hasn't caused any obvious 
issues before. You could add

Fixes: 16f0013157bf ("drm/amdkfd: Allocate doorbells only when needed")
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index cbef2e147da5..38c9e1ca6691 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -280,7 +280,7 @@ phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
>   	if (!pdd->doorbell_index) {
>   		int r = kfd_alloc_process_doorbells(pdd->dev,
>   						    &pdd->doorbell_index);
> -		if (r)
> +		if (r < 0)
>   			return 0;
>   	}
>   
