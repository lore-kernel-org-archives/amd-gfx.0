Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB49AEB64D8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 04:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CA1210E593;
	Fri, 16 Jun 2023 04:29:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C605E10E593
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 04:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECq2e0g46NlsMIiGYtQar6gQ8AYPl5wy6Tjs7X+L0gp8muhIGZBebaK6lpsjVurcu/UbffLWOzk+KaaSzgtMdgfT5O8HV3DV7w0RT7/hCcAPWUcSk3/XP6EUWeMjlz9BqsLanFe0onXMoBYBYHR3YPpySgNTeXMs8mWCjLeNEfASxxjDFO6pTMBF5gZr1YxAvd5VBleffMzml/wjWZUDPEeTn6Z1HAVEa1xJB4+c75ADRdHW7kX2bLaPFY7ozPY/CHEdzVoSIxTEeJUzNligpoiKaYeT0rDjex2pb/koSenKMIWxkmzmJGxRRZ3aAy9LUbbsLJqt2NVLOaXpaAe91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDxzXfvf3r8tFRoJOQUnmlT60pvRXvhBARcVjNN1AQQ=;
 b=ZS7vSkmrkmzjGI0LsXqtKyz/ajROlX8gCpPWOpR//CZQuPYuTdekt+O0gV+jQ9FvIUi3nZ2wJJ8PY6TS9CasOOZr8ZKMATwgPsAbrxj2seihO2bET/7DJfiFHRBKjzKSB4QdHsrBtF8jmqG8xcT7/QbBhPwdlVMZ0Wl+z5nFnWtftyqflhPvUxALGGpnlZVzigN4Tihwa96F/UyRkn4gxpAPmgpJWNcsF0zZwSN6ET9eY2lYvY/+8q5HOW6t/xnfg7PmISpkJ5iBG5j/sbCcTKTCJLv1AUwOCg/qynrC268Jyy7cozhyrqyZlWnlDs5f/2k5GQ+XbjRT62lPsD/J8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDxzXfvf3r8tFRoJOQUnmlT60pvRXvhBARcVjNN1AQQ=;
 b=fw0R4QL4qK4K263s+3fNwF0dTC7QdvpXPvnPBAjDKU40uKNqqHGvt+8O01nU4RV5MAF2Ui/0BYpbNdz6ZxPM1WbCSKuAVs5ZH7EfVy1WAX1/Ll/1Rhf313MRkfaeTV6u2wJgk7ZQb0h91EEiYHHwkCCOZlALDv5pwykADd+Q/WY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 04:29:51 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::5c06:6ce6:fe4f:41da%5]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 04:29:51 +0000
Message-ID: <d32ef44a-a963-0063-743c-559921a9d314@amd.com>
Date: Fri, 16 Jun 2023 00:29:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: set coherent host access capability flag
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230615225442.11083-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230615225442.11083-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0411.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::28) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 6faf84c5-b48d-4e58-7682-08db6e22532d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZQtMF2iEtd1qa/VNquhWIFH3KySAvY8SntXSNriwqRk+Z/Nz/kO1TixPt95zXeZL5zwjZ0FSWk3zej140ySX6gVXKOftxfLGawRFL9/hrgHlvQxR/19sVZEAv85aYjh6PoYIcgSz7E7EVb/uIbD3yRnQW8UNTn/onmI4voa5xW9t62Wo0JrrWoZ91dIIo4wIQVdJcI4P0CmVZ5rUXWOWRyen9uz6rkJg0i3qXYCf2r2rrpbQOjx3WGtJw+gqbk7XnV5m0/jaO2M7wZzEJn3wLKGSAixugohrgOD86XwE6PzXq1LTEHKT5RxBddWEjb8Q/BLX19B8pghjKc5tHuZ9LQR+lgUE0eejGm3P4Xew0QksL9IGuNCAwDFiI0svvN96jHkxFBsjS06oJ03OAPfJQPrz+LaJlla1CVXGZ+PA2O97x9PpvDrFuPOGXg51YYSDz8RU+iPPfrWlLyjjKtTDWlgPUMuOBXHJSZwKYjLRsAubG8Rn/euiJt3avUIC3MnOASgTwiFfK2fyj4d8ZOezcb7AcqS8HuOttaBVQdyWy6BumAfIZTFR42fMZeaBkjfLBIDjQL+grPCtOa1+O/h0fM0hn/WX+w3cigILz6ZYgbwZbDP024eKSohYkt3Ga+vSvXZ5pZk43wTXMvikN6xyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199021)(31686004)(83380400001)(6486002)(2906002)(44832011)(31696002)(478600001)(66556008)(66946007)(316002)(66476007)(8676002)(4326008)(2616005)(5660300002)(8936002)(6506007)(86362001)(26005)(38100700002)(186003)(36756003)(41300700001)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vmw5WGluSk1rQ0J5MFFCZUd1akR5STgvR2FudDNXemhHNENsNzZ6R040b0FF?=
 =?utf-8?B?N1IvWTQzeUdMSTMzTmlLdGtIa0ZOR2V0YzF1ck5zUVRWNkF3K1cwMCtQSkla?=
 =?utf-8?B?SW9pcEJhbGJpcFRDTmYrRUtITXdYVGF6Z05JUXdERXREbHRNMGZLdU9wbU0z?=
 =?utf-8?B?THRKaVFZVm5wWVBlNkViZ2s5TEtMeWcrOWJzdk5KT2RJTnVQZmJUWHBPUm0w?=
 =?utf-8?B?Q3RpeWFsUHl0dy93WitESFREckExWmRuRFlCdUJ6eldjamk5N2RjczIrY243?=
 =?utf-8?B?eDVFdi9qYU1ZYWEvcXhmSmMwNVlpdEN3NnBSc2lnVGQ1TWgycU4weFBic0xS?=
 =?utf-8?B?S3UxTERCcDFNbEdsTEo2bHc2WEhzOTltQU1nTVI0TVA5cUF1RUpkMTE4dzMv?=
 =?utf-8?B?VjkvUXphaThqeHNyVlVnTUptamhWeVFialhDdjYrdXJQbkV3ZFBaWlRSYzdL?=
 =?utf-8?B?Nk1zSlgzR3Q3U0duOEhFTXp1OVdQVjJ4QW9CM0NNY2lvSWcxQ295MS9QZ1R5?=
 =?utf-8?B?QTVpbXBMcWZnNmNNMGoxY0lVY2lnNFdoejJWekVWSVExVjRLZmdvL2JjRnc2?=
 =?utf-8?B?TG5kZ3drWE4zRWs4MXYrdUtnNFdBdTBqYk1nN1JPckZ2Nk9jMzF6MGlqeHc4?=
 =?utf-8?B?RlJWcHRVNjdsQmpaMmVFYTJqT2pFNUs4S2szMXdBRkM5Z1MzY2F2aXFDejE1?=
 =?utf-8?B?WDFMNmNjK2FuanBIVFl2QlRnUXJKeDA0S0ZwWGhYbE9VQU1qSERZS1M3OWtF?=
 =?utf-8?B?OHdpZGZ2QjgyemVIdjg3SkhJZjI1WjNxNHBQT3NtMWtTSXpOM0Q4YzVYdmxj?=
 =?utf-8?B?M0JZbG95SHVlOW5icDJzVStyUGhxYmR2RDJhcWs4dHJHdXFwaTVsTFJ2MEtl?=
 =?utf-8?B?UzBuSnRsMlJYcVVDUEVLcWF5eDVnZlEvbFJudjZiQVpiUWJzY0lnT1RrMVUw?=
 =?utf-8?B?eGJIL0Z6ZWpza3FYRm5WVU91enZ5VDBjakowcU53c3RMN0k0ZEkzTVUzRmVM?=
 =?utf-8?B?c00wUDRHaGdLUVJyTk5aM1duS1JwN2EyTDdOQWN1TDlYUWl0SHdhQlFCUWdD?=
 =?utf-8?B?dXJ3dXFBM2hucDNCZGpTS3hlSmwrU05hWnhmZUlaQmlFd1Y0RWwwbnVSK29K?=
 =?utf-8?B?ZkxlK2NIdkZrQUN1V01MU3J2TzVQcWV1b1hpWlJxU0p1VEpqZ1NlUlNuZnVH?=
 =?utf-8?B?N1lBMkdwMUR6T1lob0NjOW40THMxOXNDZ2VNbnhnVllvQ3pUbU91SmpCblJQ?=
 =?utf-8?B?dXlIa3lFKzd0Z21YZVdOS3hsVVlnNmVWRDhRcXhQbExiRExBcU50S1FUNEIv?=
 =?utf-8?B?aUs5ZlFWdGdLRmZ5SHNSZ05OL0NuL1dpU0JNNnVwa1pNZ1lVZlM3WSs4RlVB?=
 =?utf-8?B?ZDlqNHdSNHJVNHcvaFpxd1hYMURib0NHUEpXOTdyQWcrR1R4RTMrU0s5V2Mx?=
 =?utf-8?B?YTVmR0k2VTF1TUlXNjFDdVU1NEN2bTBXRFlLWnJVaG9WL0tJYXp1dUg0QkpM?=
 =?utf-8?B?eG94bG14UVBYMXhhbHVDL0V4dWduMjRnYStzbHAvQklnUSs1NUFZTktENWNC?=
 =?utf-8?B?Wm9YZVpRQkJtYWExMkJrZ3BmeGIxQXg2Y1NRaDZ2M0lmbVhCWENNTWVjSWlS?=
 =?utf-8?B?WGYvY3piZU9rVlFLbVArZ3g0cnBSRHp0Wlo3WWt6Z1hMOVZFNHRKL2Z1ejhE?=
 =?utf-8?B?WGp1T3poNkUvQWF3WThab1ZaZEFLRDN4MiswRUg1bXYzTTVOVFBlRUZDNkg1?=
 =?utf-8?B?MUkvUTgxTkIyS3FENU5ocGFTK0g5WjRtUzh3ei8zbEVaWjBFd001aEVaa0RB?=
 =?utf-8?B?T2QwbEE4Qzh6N3ZNK2E2UkE4dk9FYlFYZTRnL09VQ1BMUXRCQThnVGJWQWd6?=
 =?utf-8?B?RFZoRUNDMklrN1JSL09YcllkeWtyOENCOEdiNEZkVVNJY29xWFJybEZ1Snlk?=
 =?utf-8?B?ZG8wN1A5YTE0UFowRDZTaGhUKzdOa3NGQktzZXVCU1FkWTVwMVh5MGN1THRx?=
 =?utf-8?B?TndqRW1BYnhjRC9MT0ZQc0VZN1lZVzBLY2phVlZyODNnRHQ0MjdPbk1Ja1F4?=
 =?utf-8?B?c2l2cE84WGUrRldjTHpWUVJPQnJmVVVMNWFQN1Z0QjUzekJIcTk3L0h5QXJV?=
 =?utf-8?Q?kMQW6+W+xL+9PwkJNxi2uKXSC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6faf84c5-b48d-4e58-7682-08db6e22532d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 04:29:50.8159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9Hv97ozx5/HXrIeWCFiaJeHx4Zi/BNB75yHfqsLfxxSlUL1w/vgY8ooMgEtpKzsq5av1Re29ou+yE/xmMjdQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
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


Am 2023-06-15 um 18:54 schrieb Alex Sierra:
> This flag determines whether the host possesses coherent access to
> the memory of the device.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 90b86a6ac7bd..7ede3de4f7fb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -2107,6 +2107,10 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   	if (KFD_IS_SVM_API_SUPPORTED(dev->gpu->adev))
>   		dev->node_props.capability |= HSA_CAP_SVMAPI_SUPPORTED;
>   
> +	if (dev->gpu->adev->gmc.is_app_apu |
> +		dev->gpu->adev->gmc.xgmi.connected_to_cpu)
> +		dev->node_props.capability |= HSA_CAP_FLAGS_COHERENTHOSTACCESS;

I believe this is not true for "small APUs" because they map the 
framebuffer as WC on the CPU. I think you need to check specifically for 
APP APU.

Regards,
   Felix


> +
>   	kfd_debug_print_topology();
>   
>   	kfd_notify_gpu_change(gpu_id, 1);
