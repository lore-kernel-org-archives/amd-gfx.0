Return-Path: <SRS0=WxFm=O3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45C8C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 14:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766FA610C8
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Oct 2021 14:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 766FA610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2ADE6F4A3;
	Thu,  7 Oct 2021 14:28:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1A4D6F4A3
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Oct 2021 14:28:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cO8WTUXqA0A/xKhtuvfJvz6vMpUjrA1OHxRva+UP8dRGOnZt4uzlheadLXHk+33ulV7PcOpjjw+PvJdZ7vF/QLcw7mdTZuf+Ag4YUPMrUudHSQSuDvLTfOzlykvLl5rTULFXpe6wnXp1BmXjjmh4bXfvRrUlmX28tdarHXOjUI7wk9Q/qpTZrCUSjZM8aRfdq+3aqll8Ueo6NkiOV/NwXwf4qq0yVCkjrLQvMWNrYrJcVUEaUy8RM0gZk93Ii5k7Nt6AzSv/oVHYJf0fVinKdtrIQ6lk8ryaFFILH3rGofDNKga+nj8YDTd1Rbmxzc6HZjk3vME1774VdfRFTioJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QO3unQAWqTAnVoNuK1lPio8YXt5/REMlQeREZcm2eaM=;
 b=FVT094kJhmCLF93A/Aw7sPR57LaGKJJMge6krN21v1XxkjkuXPtMhLFZ9eWc52fjYhcc3CvtaYh4LqehEyWGTBb9fZnD7JqIgO+ywQqoki9E42EiznzdelwlLAAt9C0AhpjHvlCor82HniNC7SlZrwIsLW6d/mmD/p1dmHT6vYUsIZI0AZwXv18GpH+n/wGgLBOEgBMbNqgCEydlGVahVBrFRTicPsAsKJJhBCpHnUxL4Lnl+INBaC2U3MXa32emxJSjpCCWYgA5F2tqdcVHm260p+kuZ4P+K0T6G3tYV1AExQM74L8PrlZ9LEy0W/ENFq5JwSXHfLwBugM9UCN5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QO3unQAWqTAnVoNuK1lPio8YXt5/REMlQeREZcm2eaM=;
 b=p1Bag485aqWYBUABzpK+X9INVrYTYBa0k7y8tt24iyYqskcRsxyJMthUPwG9MXSzhPeC/tpaJQXy9GdN4fs5LqHAiXvEpiYlSKXnp/lVWXO7O2HFxF0yyFCEXUudj8geq9kTMy2cXkbNifYYzQTTVg9XQrFFtgx7WykzVpY+Cds=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 7 Oct
 2021 14:28:52 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 14:28:52 +0000
Message-ID: <e38f9c02-bca8-7328-81a6-f630b5a2ea85@amd.com>
Date: Thu, 7 Oct 2021 10:28:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] drm/amdgpu/discovery: add missing case for SMU 11.0.5
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211007140540.223897-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211007140540.223897-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:408:e1::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.47.177] (165.204.84.11) by
 BN1PR12CA0020.namprd12.prod.outlook.com (2603:10b6:408:e1::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.19 via Frontend Transport; Thu, 7 Oct 2021 14:28:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac755820-a313-4d65-1c59-08d9899ec904
X-MS-TrafficTypeDiagnostic: CO6PR12MB5394:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB53944A5F9F2E30692193E01F8CB19@CO6PR12MB5394.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbXvHotS48XwUBrwU3sacRZZ83VkgSCApuVrLVy7Xr+ZhOr0tbwHMIf9wDiU1K0Tfyl8Ir6dliEjOqMXJW/Pj24Ef6NQyBFlHSDst19Z/1NXPM1Qu23rf7v+H0fE7n27MzsNzkfZYeMmYhSJPdaIpOZU9tN+4iu5o4lqjVuf6UnbApoYRyQE5FkNOvqFmLefNzPGPrzU5dvhmhi+X0y3vbEKEqMPDIXkRmjxmBrJwCdQolLJ9RHoZ7ukEYTgt+rGT/INQh4679ynq6hT3YidWtZN8+FvwqdPoPXf+gNdR/aBd6FqEbhsqqzEahTw1bw61s89YG/oBIG7FVVj/cI5sx+GZfntcs76oPQxoRZk7beJZGbsgzFJdo/dm+I6khGePdg1DCyWfFUOZJ8eWSbOxl6TrMjqqq6pI8bvtUjiVvvGuN0+czdni9QMvtD85X1ICGYEmZ663SnSj7a8K7+I5qBsF2rQOZa/DH2a6gEMkHWFcdU7w+7vdBWCikh6JDnQqTHRvt2hCzfrtOWEcrEZXrYjh5becgwGo/J14LJ1qLCUbbA/uy5/umoti1fo3fqXPWts0cjxwYVguXPT9gh+cI5D3ARAdY911TwAnm8BrevMfBZ2d3SkDc/xtAMjVibqM0nK2YzBVXN9jU1kxhA3qY3t5+80Hie0eLtxMJUCJaKceLNkRWfrQvLfOevxb1CDTYWampvaTRf4ajaSCQv/bzEjjiFvcwGBuy9V1P6lWGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(5660300002)(508600001)(6486002)(2906002)(186003)(36756003)(44832011)(53546011)(31686004)(38100700002)(2616005)(956004)(83380400001)(31696002)(8676002)(4744005)(8936002)(86362001)(66476007)(66946007)(66556008)(16576012)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1ZCSndZMkR6ZkgwakE2eTh0Q0VSNTBDTmxBVUNwd0NCaGJ5NGNTVmNScFZC?=
 =?utf-8?B?WXhsRFNzT1BzOVZNOENLYmNEZVE4bkhzVUJUSFBobVJ2Y2JGcm15dCtpRkdn?=
 =?utf-8?B?Y1JRdy9JZzJjYTJTa0hUT0F3NE15QnR5dFlTTG56aFlRZm5hWW9wcnU0QUFC?=
 =?utf-8?B?emZDT05IZHdXQmwvRUFJL0lKL3dyOGx4N1EvYk1YazVDSTFmakJKa2FwM1BF?=
 =?utf-8?B?QjVqNVRreEQyNzBLSU9vQmlJOHlSTHRBTVp5QW93RlVRTjg3cm5WUVppRXhI?=
 =?utf-8?B?YUtqVDZ2NDF5cHAzbUlYSjBxeUNuWGZJSzlxZXNXQSs5MmlHeVcrZVBZalQ5?=
 =?utf-8?B?UndkZ2pSVXQ0Umh1VjBQNDJ1QlZURit1Sy9LOVVoaHQzOHlWck95ajUyUTMx?=
 =?utf-8?B?TEUvRFFxS2VSQVFmZitVN2RLSlB1YUhrRkFUTnVMRTJiQ1B6Qlp3QS91UWg4?=
 =?utf-8?B?eUdmMzBvRnNwcGlKaGs0QnFXbjJub0QyeFd5R2JrUWFRNW1GNmpaQWRUTHpk?=
 =?utf-8?B?a3lLUTRyUENZVlBpdHI1TnM3dVNYVVZLdDRRSWRmeWJPQjNSQytYZjBNb1Z1?=
 =?utf-8?B?R1pWVEVJZ3dNaW93N0NsQWFUVWZSVVJEM0hhdkVvWnRxUTlKOTFOVFZTWDZN?=
 =?utf-8?B?NENzYm45My8rNElJYjFpVlMyRS9hL3paTVlvVHJFaDVIVTJpdy9wZkwxNTRD?=
 =?utf-8?B?VTVDeUFyV0U4M1NzdEtKOElHaFc4eFBvVUJwb2FjOHhZNWhackRUOHBOQUs5?=
 =?utf-8?B?L1NMTG0vdW1zQnJTSUY4RytHTkorSFJiZXM2ZUNVNkEyR0FRVXNWRlZPMlF3?=
 =?utf-8?B?NXBVL2JvN1o0Y2lkN05jeUdDRlQ0TERFRk9pdTQrWmFQbU9Nc0FTbHRRaVVZ?=
 =?utf-8?B?OHF6NWpLdnB5dktLRWtjbG8yd1J6TlN6aHRPTG9CaWNqVHo3MUJHSWhFL3pU?=
 =?utf-8?B?U1BFVlphdWxsMXBDWTJUdERzWStrYlBDYU1CVC94dHJFMVJVOVdSWVc5bE9o?=
 =?utf-8?B?eUpwRC9NZ3loTStJYkRJaHh4T3F5WEE1LzhaRGMzRmJEeWFJcEtmUVB4SHFm?=
 =?utf-8?B?eXhVaFRPbnZ2L3lRWEk0SHdJczhmMjY3eDI4a25CZWRza2NKd2xnQ0VRdldH?=
 =?utf-8?B?VE1yRE9QN0NBUEZ3S0NVWGZReFFUUTAvZ3pSYkhYMG15QUhTdEE1WmJLbjk1?=
 =?utf-8?B?c3YvL2FyLytpSGFaR1I5NGo4UkZ2LzFEYVBtVHAvMmFBNXpxNVFLNUk4TFBV?=
 =?utf-8?B?RG1tRUhJUlJTaDd2ZktmVjZYR2JtdHlWekJuWWkwZUM4eW5adzlaOHZKeEpv?=
 =?utf-8?B?WUhSd05Nbi92V0dUZW9XVHhubkEzSXZtRW05R2lJYXdOSDN5U3F6SUg5TE9l?=
 =?utf-8?B?bVNNNHc5K3lGd2g2RFoxcE9pRUJLanVxWncycXY5aUN5aEptaG4xa2NsOGJD?=
 =?utf-8?B?MVBQeGYyWXpmaDA4a0kvTFd4ZnRBaVVsc0k3SHZGRU1TU1M5NnRXbEcwTlhY?=
 =?utf-8?B?eGcrLzVncXBGSlhJVytYM0dFWWphVWFTaXlNYm0yNVM5ZGhJTE1Hd0gzclNj?=
 =?utf-8?B?eHZtMVV6N05rcGJadzM0VUJOeUlsVnk5Ry9kWWVSZy9hMkMwZUc5VUIrTDIr?=
 =?utf-8?B?OGhxL0MrN1p6OTNVTFV6NVpvNkdBRjJ6RXNHT2EyOEVuQk1uQkVwRyswWEtR?=
 =?utf-8?B?alIxNFZkUUNJa2F2cm1CT0xyRForbWl1QjZEdENqNVdlNWJsOWtJOEhNbnlq?=
 =?utf-8?Q?P+4BOJ8THJl8K8OtgtjE0AcBUEmpSMR2Io+GP03?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac755820-a313-4d65-1c59-08d9899ec904
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 14:28:52.1516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VB7QzIumSX/L+4usBwH/rID/ZZKwpzXnkWq7/u3SsDms77W4WCbInsSQwSRg2R9LVxWToT3wrqsaNn93yfY6OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5394
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

On 2021-10-07 10:05, Alex Deucher wrote:
> Was missed when converting the driver over to IP based
> initialization.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Tested-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index daa798c5b882..90d7de17d81c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -700,6 +700,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
>  			amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
>  		break;
>  	case IP_VERSION(11, 0, 0):
> +	case IP_VERSION(11, 0, 5):
>  	case IP_VERSION(11, 0, 9):
>  	case IP_VERSION(11, 0, 7):
>  	case IP_VERSION(11, 0, 8):
> 

