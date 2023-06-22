Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E009EB64DB
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 12:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6AD710E03F;
	Thu, 22 Jun 2023 12:21:23 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6266D10E03F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 12:21:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVuA5hBLo0CPsy+tVGXJhVa8Anx1jpJzdBp/NqRk69CBhW64R+mt90P5WT4Knxz5arEGqM2C2ZSIRnxj0uOJyX1E0Ic4IKdhmNG3zOs75ET7CDIxmXt2GM54fxC6QZntVAk0Vmfq4Jks+PMfdsP1h+9llTro4FUagjs1eCaX5Hy/1mFc937+K2/cDSmghDN5xqumKrGspZzBCRe+dcL+OhwqT81OaGUu7e/TMPFuHXjwYYGicnC3/u6v2deOlIxawXoi+DdL1Uv3M4Icr38qA5ze8M2fF/tE1v3NO3m8rLk8lNTKDAx4qoyD4eldAgrqqQSllUlV8J/CJJx19xpxPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qUzXVrsYYjsPk8dSMarV77ZXXQeCiGpAXO/4bNfaJA=;
 b=nRLWX9BKW7+w3a7AiV22SfTnihr8E+YOTw3+Y94ZgivzgK/Hf7iQ8ZRV8kyIW/YL6784oHpfCYqAkw8fGZBVeJxG0HDQMkY3h85Pxp5cdtGXZE+f9tbokAACc9GGI5sDZ2Jujvpaf5tbhqaN2JdvuXvjERD/UXt67VgxcW/VnQXGvPmoPX7uxk9Ejh2+AqZQ80SFZnYcBqRMyAyrAMH9WnC2cCWwFQkQ1A3+FJZtreFzEimTOK4k4oOP3FG1mFOhgg2EtwwRPJG6mnU++7TEvmWl6hkAW8U5H13PGFWdTUlEpOWHFeia+dy5kUyGFrE/B2yXFKFUaYu/8jUvhpKwKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qUzXVrsYYjsPk8dSMarV77ZXXQeCiGpAXO/4bNfaJA=;
 b=g0lJ89saI/5wJ2WPCuMzw9+xhdSUHKcun9Q27T6UXPHOC+X8AbiKoM7l56bay39Snx6y/zz1R3d7Gr8wp4tOuOGj1pxNACKByIezM146tMMZmIGuLjxFPGggCoOx3DhL5ZJ6G/ihxSOOnF72If22pmBCbngUNXFZlVnuYRMhGaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 22 Jun
 2023 12:21:19 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::10e9:7f44:45ae:4f94%5]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 12:21:19 +0000
Message-ID: <e651a63d-5baa-d749-f888-633d26bbcb63@amd.com>
Date: Thu, 22 Jun 2023 08:21:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu/vcn: Need to unpause dpg before stop dpg
Content-Language: en-US
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230621012954.2273614-1-Emily.Deng@amd.com>
From: Leo Liu <leo.liu@amd.com>
In-Reply-To: <20230621012954.2273614-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0240.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::14) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: d6cffb22-eae2-4062-77b4-08db731b2f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLXDG5ifLd0jSmgXeKhC2OdR/I+aS//ra40mUW6YWvkelpBjJh+TMbFN2Y70RGeZXtnpfaiFijZN/y6qa/C8kzeOOxI87/dmzYtQi+SLy2T20bNC5HazAO5AAv+p4n71ApUlF43WlnD4vDMla2PFvxdsIUVpEtWlYV9wIOYrzkq/nCfGasozMxMOVIGHOCbRFDWmSl+vly0lk74IKI2b4su0MNcRbLMzJGYLB9Ftf8VTKy8RQifBTD4yTH6GQd9pN+o4np2HvkMEoRpJUJOPkOV8FQkW3zZC9SbeXBi0YUSMj5av9dgErwSZljvgGePcInGEarKSlF/C4sj5meZuKbnJ5fEasLwBMJIIMiYhCE9eXHXrHCthE2YLOdn0ZMIlfd0k8VLs6ClPN/z4/MftOGAKJwhWCOr1vCXPMOASSANon4bVwXcEW+SVbXHN+o9QFHjawODT0zXSV2/Mq0Z+n4ZVdyAro3maBwkV+WH6iTsX9raQ0aQ8iEpadpPfemuLqxvQgXfPeJl7PwPf24xjYKXT+6B8nGxo/tHhtLeaZcvfbU4ly8/47vOLz+lz+RAxkmi74tqIqVU0o5MaDqulem8yGv+8XnCI8hq8+9tYRKG1kcNXPVYQ1aphNzv07De/vFaf60cejzQ83odaJ9OGHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(26005)(6486002)(478600001)(6512007)(186003)(6506007)(53546011)(36756003)(31696002)(86362001)(38100700002)(2616005)(66556008)(66476007)(66946007)(316002)(8676002)(8936002)(44832011)(5660300002)(31686004)(41300700001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFdHYmdZcGZJY2NpKzNTN25XRW0raGhEZHJLbnVtUnlZRFZINi82elR3YUFW?=
 =?utf-8?B?aTdFcWdsYmpJSzdoTFBLd3VzSWNyZ0xzQjBDaTlFM3c3S2hBeGdYS2ZnZDcv?=
 =?utf-8?B?S1VlUGZzNG9saUdveG9NNmxsdm5SL3F1UU5SL0JMaFNUSERqRkpsVVdHSUwr?=
 =?utf-8?B?MWovWTNaTnBReDhJRVB6TWg0V3ZqSHZJTnF1dWJVTitGN2VtZ0VzTjZvbnZ5?=
 =?utf-8?B?UURzLzczWm56VW53TXVOcExuUUhic2lSenRkaFRFZ0FDcVZRTDhjUWpSRUVR?=
 =?utf-8?B?amJQdVBSTmtIT2hrYXEwb3lFKzhNMVo5UGNSYjRvVHhXWTNWTjZHTk1WQWJP?=
 =?utf-8?B?akl5blViZit0cThucHpySHBVYVpVTGJOMSt3S2Fpek1wWUJWbzM4QzVSLzNT?=
 =?utf-8?B?UVZ2a1UwWXVJMW1yeFN5WE1TbElxNHlCQzVTaWxtMmNxWkU2bVN0NlRNSjVD?=
 =?utf-8?B?cjRPSUI5Q2NQTEJtUk4yNVFnWTA1L3N5bExpUjRkWUdRa3ppODRoRkxkbjc3?=
 =?utf-8?B?bkl3RHZ1NGtBdk93RlNuamNFL3MvWE1OOWxLU1hHbHU4bDdvbnI2STV0MDZa?=
 =?utf-8?B?VkhpMWlRYmg1ZUJFWHBVUmhJbUw2eUxaS0UvUllJYmVmbHpaQTBBZERYbUw5?=
 =?utf-8?B?azZRZit3cHVTYnZNcU5PQUdNOEFmenVVNGNGaTZQYVlzUExmTXVUTXp3UDJH?=
 =?utf-8?B?UEZYZUphdnR6MXFGcXJ2SjVycHQ4c2VIak9BSHVORHIvdmpnMWpycllEWExC?=
 =?utf-8?B?cVJ1WSszY1NWRVhpWUNKRjNZYkt2Rzg3WTZuaE1RZ2NTdlpGejQ1OE1xanZK?=
 =?utf-8?B?eXJXTTZ2VmhSajhWVUVSblNtR3lnZ3dSWmQvNWlETlJyZXNXaldMUTBkVC9l?=
 =?utf-8?B?eG9wVkQxdnZVSzF1MGVzYm93Q2RBVHNyZEFacEw4M0RnTGZ2WnZYOWovbXVk?=
 =?utf-8?B?MjhPcjdDdWxpRlNWUEJ2Z0YxWXZtZGFEQ2pCS1kvd2Y5K2cvMmZSZWs2Tkhw?=
 =?utf-8?B?bkU4OVgvQXY4b24wRE51bjZ4NC9lVlNyRmtqdUpBaFV4MXphQWthc2NYUVI5?=
 =?utf-8?B?cWljZ2dGaXhjcGY4bVdMdDVsTFdHU0tqUzA0d0pFa3d5UlhiWXlaSkJWQ0hu?=
 =?utf-8?B?SS9ZR3JFeUFtWlBFWDRrVXE4MmJEZzBUZTEzbUlCd3hhc2NzcEJtRXJUTy80?=
 =?utf-8?B?dzFFVFNsc2NDSUtFamFiTzQ3R210ejJwOTdDdmQrZ0h5QlRoVzYwMURyT1Jp?=
 =?utf-8?B?NDY4L2NMQUNEdzljbGZxWEI5MjVRRE4rblZ4QlhVcGRrTmhPVjF1QXU3bHly?=
 =?utf-8?B?b25LdFd0d1lOV3F3YTlhSCtla2YvTCtGRDBDbHhqdEkxcVVpTGxOQndJNWpY?=
 =?utf-8?B?OUE1eitCUGZ2ZkZXL1h4SWkzZFNvSzlJMkRKRTM2RnNtOUVHSmV0d1laSVFC?=
 =?utf-8?B?T1VoZGtzcnpKQnh1QVpmcmd3RU8yZGtiWkZjQ2FJZm4yQ1lDZjFvYy84MWdl?=
 =?utf-8?B?Rk42UlpQR2NlWU5jYlJOcTh5alNKdldReGpKMzZSNFJybU5yME9EY2ZHYzZH?=
 =?utf-8?B?L2tkVGFQMEVSaS9JcEw0S1k4bm9xK2prTFZLZkhWbi9Yb1FGMXppa0M0K1FY?=
 =?utf-8?B?emdmZ3hWbjdmb0lqSnJoVTJISFI2a01rNElSS0d1QjhWZWZ5Tnh2TllGc09Z?=
 =?utf-8?B?WDcrVnllR3lKR29XU1oxbXU5Ulpxd1NXVGZmeDBnL0tORVByRzZJRFdza2Ja?=
 =?utf-8?B?M3hBeDlLQXp1dHQvcDgzb25Hc1BBaDltbGU3ZUNGazlSeXNtMFJVOXJUb2tx?=
 =?utf-8?B?Ly93YkJFTUFMQjkxMVlkNVZCYVRMMGtWRUhaWDdicThzbjJwMEVWaVdiR2Nz?=
 =?utf-8?B?VEoyRUlHd3EvSlVCR2cyQThkQnZwLzFpNnIrbHZISThoQytGOURwcEhGUC9T?=
 =?utf-8?B?UG5zdWRDN2ZJeU1PZml5UzB5ZG5CTGJXSElBYTlqU1MzVUVKUWxjOE5TNVFQ?=
 =?utf-8?B?Z2RUbEg5Y05OY2hwVENWWnovYklqVjY4M0JXeWcrSnl1UkVHWmwvcCt6MkVo?=
 =?utf-8?B?djV0ZUxuNFh3cmZ6ZkRwZ21XcW9pWUQvT0JBVkVYV2E1N3B0U242Q1JDN3A1?=
 =?utf-8?Q?mu9o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6cffb22-eae2-4062-77b4-08db731b2f33
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 12:21:19.7675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EkfitMut0KLJS4ur/1csqh3mlJDBtQhHCUvW7EkM/tUqfWsU0hZRRCJqkTJD0bm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950
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

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 2023-06-20 21:29, Emily Deng wrote:
> Need to unpause dpg first, or it will hit follow error during stop dpg:
> "[drm] Register(1) [regUVD_POWER_STATUS] failed to reach value 0x00000001 != 0x00000000n"
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index b48bb5212488..259795098173 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1424,8 +1424,10 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
>    */
>   static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>   {
> +	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
>   	uint32_t tmp;
>   
> +	vcn_v4_0_pause_dpg_mode(adev, inst_idx, &state);
>   	/* Wait for power status to be 1 */
>   	SOC15_WAIT_ON_RREG(VCN, inst_idx, regUVD_POWER_STATUS, 1,
>   		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
