Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7255C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Nov 2023 09:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CE8F10E328;
	Mon, 13 Nov 2023 09:44:26 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A85B10E328
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Nov 2023 09:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgx8up4AMPV2b6zgzKw2B3qbMPxSYdkaTMv8ci7tsbtvkzZJ5nPct145Odkhww/pD9xbvgy0iDrQbe5+LQby9k2+u6PE0P3K5hH+vn4NSXwiXSFz9hdU2jH8cA4tt9Q0VRcT/liTHSumjbQ5kjePg836W11xQFrwzhAWFQ2K7Nte/z85MslUEYWeNW8+saMjedYnCsbjo3EYblsxFVKnXDW9ESOcnqdW5V4O0OEs9mggSEA7rIyv3eLxivnty8x5N1HLDMo0sv0Pxso+uum82l9u7wFWZ8ue2rmexQtVRGG6AXdojwAdt8CT89e2wSuOBw6BTmbKQO6opeFUzh0uIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fi4bSx3P73ayckXKty/Douf6kNrsHy2JaTYz9N5n4go=;
 b=fGuc9XwdiI85jNmoGRHct/nmfqbgR9KLnLbPOKRYDudhWFzvOf++oUHepgbXBLnHvjwUz7iCsRE8ZCXQK87fPEsjvIiDkk/Uru43Q9tX3LqjDUtY+YMUd2u1Gf8u+R+zbSuf4DSZ2f6pprIhihu7VVbZcNoUVmcOLUUfCJ1BqgayiRmBm/cQY73YPTpYFmtqeC0MChfP3vDjOIqb67/VHhs5JzvLvH2qm2J7n3uUqGqsUf4ipGvl6An1LbnZ7C65RiVl4JIc+vKZezD5gAT2qg4smM3Abld3akNYRkLOmIbv1fqSacG6HQLrK8ZNq5fk9ucETeTgHhilkEu8e2IilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fi4bSx3P73ayckXKty/Douf6kNrsHy2JaTYz9N5n4go=;
 b=oCQ2sBnC23mi7yRQjMgjTXjY0Drvb6hFGyakke57MO+zPNr2DsnLhMicmsaGy9FdN3KCt9OtrN8CHuv5StZd+AB/bVPk9vaj1T1+xDYeUSwY+q6zFlYHksq3k9zrxfDWXQ9EFndkAqIGQJlqdnghbGMa3rcXIqP7x46GmRiAqVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 09:44:22 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::3388:5dcd:ae1f:6411]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::3388:5dcd:ae1f:6411%3]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 09:44:22 +0000
Message-ID: <9e4df618-c7d0-4c20-8073-e3e8fd0a99f3@amd.com>
Date: Mon, 13 Nov 2023 10:44:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Address member 'ring' not described in
 'amdgpu_ vce, uvd_entity_init()'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20231112042559.1631414-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231112042559.1631414-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::7) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 358465b0-2e2e-42f3-b2b7-08dbe42d1d68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfP9bX9sJPeoW0ICINiUcjoSt+G9whUgUUzg/2Ay8Irx8cuLw8qZfK8ofmNhycwEJUssIxJsO2ZCw6gB94mYW/myYHe0JM3nhUFWv7mknhhC5uXK8fcvAs3ELGiRqPZB1lv9rkhQYQxG4OPCmPb8je8IFQ0rISpNmA6ecqLVd6wzw1kWrLvg2MRsAkLd3rRORbcoQuoGz0G79jSEeYdrnXmT4DaMFR0oWROVhky9YvUP/nJfqoZysHIYLgpKKgR4tf2C4AfGU6UIXKWOoQUkm0+Kf7DQwMV5l5cl28Y0x/Ivhth8AYDjUgkn9klZdR62HTVfNU+it0FByuraJpjR4gT91AFDvddR53m48CmdIfO28svS0GcfyXi2C34GsbpbTTC4kB/d3kEsLUaYgws8ish+eb5kSgh2ugBrUlmzLBr/e+baTsjDPti/TE7ioeKmS319t4BNBUpJ0kFkcayAJiZhdTmHyeFnPTkdXqLPcDfDlMsSOo/0Lbny3U2pbQZKwhJ5K4VOqirXyYTYyy9YLzZIBKnDfqwcpKloPXoRjU1chr0Z3kmDjZZ9zTFG+RmtyPXJ0IdXhWitUKNzjeb2RjD9BzLfjwObjzVOv7dujMCfkMU37TD2fcSN5N2UgJxjhI480C49U/LZJfWR48TcLQvVa5lRN55UZZkXwARUXvQwLoiaPnLLawPp35ig6RMa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31686004)(66946007)(66476007)(66556008)(110136005)(6636002)(316002)(38100700002)(31696002)(86362001)(36756003)(6512007)(83380400001)(66574015)(26005)(2616005)(6506007)(2906002)(478600001)(6486002)(5660300002)(41300700001)(8676002)(4326008)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWJlaHRhVjliNEpoSDRLRTVOWjRrM1lPZlFSWGg0VElKWDBLL2NDTVpTdWFP?=
 =?utf-8?B?U01EOWUveS9PSVJLMGdicHlwc0pSRE5lQ1MybURKMFBBTXBoOUxrbktRam8y?=
 =?utf-8?B?QXZmc1JIOXMwV01sT3dTUlRsRWhlOHVnajgyUUdhMmI1TnlLN0RLeGlpZ1NM?=
 =?utf-8?B?TXM4b0VrakQ3UXVNdGk3WnpLeXI5b0hFMEt1WjJiTjM3eWYrcEV3aVdFVG90?=
 =?utf-8?B?OFU1cHRKSnpySWlsQ0txYzBSa1NBeWVhNEJHYWtzbXFNa2JndWl5QUs2UFNV?=
 =?utf-8?B?YXVTUnAzbDJXcWtId25SU3JIaFY4RzZFV3ljV3E5M1JhZ090SnNoYncrbzJt?=
 =?utf-8?B?a24xMmNjZ1JvQjc2UEZxekNaZDRiN0JTcU5hWG1vdXJCZUxQMnJlODVzTmRB?=
 =?utf-8?B?d3J1TDM5RnYxaXBOdkhIVzRLUTgxQTIxeEVpUmxyeFY1VmVBaWVEUkFtalp2?=
 =?utf-8?B?TUtRUkFoNnNaaG5kMHNsK2tMSXlIU0JkaGFaQTBOMmFVRmpTMTlTcm9GN0RP?=
 =?utf-8?B?cEY1b2dlSW9tRk0zVUQ4SEtkeGpCSTJDQ0l2QXhFaXhKbU9HUk1GVnZ5ZlZC?=
 =?utf-8?B?eTdRSWU0SDQvT0Q3dkRiZkFoTGw2NUFSRk92eVdRRmYyS2JrRUp5S05wRkZQ?=
 =?utf-8?B?cjVBTnZtQXIrT2hlTndsUFNmQnlMYzlrRnZoNkdTOTJHWG0xZC9HcW5LUXZY?=
 =?utf-8?B?NS9BRWhsUjJ1VVYvdVNFejJiL3FvSml4VlBadWR1OUhndkdrbUJHOTdJVlN2?=
 =?utf-8?B?bHYzRE53SHlwbFkyMzZNTll3UG5henJOaGR2elpaZXpqQVJDNllKak9RWlE3?=
 =?utf-8?B?TG1TbXhIeEdPZkFxODhKeG1PazZZM1JSUExrczR6WGFmQ3VmdFNBZE9lb0xp?=
 =?utf-8?B?T2VhdEJDQTdCNG1BQ1pyL1pkYWFwVmw1SzNDekNNSVFFQlBmQ21JeUM2N2hN?=
 =?utf-8?B?Z3hZOVB0dzdRTngvYVFKMnRiYzJ6M3c3ajVGeEdseExZN3ZpV1ZFeGRuMUpi?=
 =?utf-8?B?N1FTbVl4NUdpK2N2cGtQQjBZTFlLd3VUdi9pYktmNThyaW5iczZQNm40aGY0?=
 =?utf-8?B?NG1zVFYvb2pLVXdsSXJWQjJRZVk0MUJ1S0xpc25CL3FacmxDek9vOTV2QytE?=
 =?utf-8?B?YndzYnpBT2w3VGpIZjZpVjdrNERSTnU2T0U5a3RhNS8xWG42NGdHdTAwNzRp?=
 =?utf-8?B?MjZMeGhKa1l5SURab3UxakdrN044dVBMMGpIMlYwQUhzMkRObTBvdHNxamQ4?=
 =?utf-8?B?RnRzMU5mamt0ZVNrdDIwOHhScXgyOSt1K2lZUlZTSEF4L2NlTUtnS2x1cS90?=
 =?utf-8?B?aXFKSC9jaW5qZkhHU3FpQzlNV1VJaHRkTzV2aEdQSTJUM2VWZmlTWVBZeUhr?=
 =?utf-8?B?RVNWZ25aOXZWOUhPb0xjQ21LLzFFZ2lhOC9Fc3N1VDVDZ0ZLTktQSHBSV05j?=
 =?utf-8?B?eElWU3QzQjJaZ0FMZ04yazhhZWt4MStpK3NKMVI1SkhjbDNiWlZ1UC9HaFh0?=
 =?utf-8?B?NWpZWEVLQkovQ254VjBiWEpEYytUdkdxNzhNaU1NSGdWVUhkQk5mdWsxZ1VB?=
 =?utf-8?B?d0tYNC92L0VwbmlNWjltNzc0ZjVIbnRwVGE1UDJXTHZ4Q1RML2NTLzJodHlQ?=
 =?utf-8?B?Ry9Cck5ST0k2L3pEWDMvT21SNWErZDV6cUhrK3NhVXRRdEFoWGJzaVcvSVlZ?=
 =?utf-8?B?bGMyMUdvaXVsaTBQYVllQnZEZ0lobEdlc2ZyR3pJWUE0OWpvcHV1amk0dkkw?=
 =?utf-8?B?dFpUZjhrVU5NenlKbXdXYThXV1k0YlREYkZ4R2JoMWQwZFBGY1ZOK2RjRlRa?=
 =?utf-8?B?bkxxTDE1SEpYUU1rb2dtalZaY2ZZcGxGaDQ2VkZic3dvTVBSOVliemZEZjRv?=
 =?utf-8?B?Y3prd1cyYzZ2WWlKN0V2ZURscnBidXBzdXk5TDZJUi80N2FPbDhrVXRSR2k3?=
 =?utf-8?B?bExNYzU4ZEh5WURrb0t6TlZPUmtnSWZKYi96U2d0cURXYjh2SmExTXZVSFBT?=
 =?utf-8?B?WjkwTlJLSUdJY1ZtWnlZeENMU0p2c2Y5OTFWYTVyNnFsNUgweVJzc1JQYzlJ?=
 =?utf-8?B?c0hJbjN5a1o1Y3F2U05LQVJyVkxlcUpZalhBS2hocE9iYnpsZjBPNW9yV0hv?=
 =?utf-8?Q?UYIjS9aYdsYIHva0y3RzEzHSS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358465b0-2e2e-42f3-b2b7-08dbe42d1d68
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 09:44:22.2603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dmOflr25nnFqehSLqvs1dHfBU02JVYsEuRDYAeha18f/Yb2dnX1rlrghJP7N/ey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.11.23 um 05:25 schrieb Srinivasan Shanmugam:
> Fixes the following:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:237: warning: Function parameter or member 'ring' not described in 'amdgpu_vce_entity_init'
> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:405: warning: Function parameter or member 'ring' not described in 'amdgpu_uvd_entity_init'
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 65949cc7abb9..354317c9e47a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -398,6 +398,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>    * amdgpu_uvd_entity_init - init entity
>    *
>    * @adev: amdgpu_device pointer
> + * @ring: UVD scheduling entity on ring

Better use something like "hardware ring the entity might want to use".

Christian.

>    *
>    * Initialize the entity used for handle management in the kernel driver.
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 0954447f689d..578c5c90448f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -230,6 +230,7 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
>    * amdgpu_vce_entity_init - init entity
>    *
>    * @adev: amdgpu_device pointer
> + * @ring: VCE scheduling entity on ring
>    *
>    * Initialize the entity used for handle management in the kernel driver.
>    */

