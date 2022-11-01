Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE64C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 19:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3539E10E049;
	Tue,  1 Nov 2022 19:25:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C8910E049
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 19:25:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcMV04Pd5uNm4OusrrbYmH+tyqhrFUbUkYHGpeBUCyRG0odQUpy/bU2jNahrBAegmjHQdWXy4J1am9Egx9E7PiEirWShx74H3Ka/zFfOip/HVfavHa8xScA5e0Szp3CiyG7AZAmJ91EeZ6YUTwqnx8mjvkapyQNXtPt/GFR+UPIqRXonAhbL1jRw9dPrMYQHv8mc4JhBSmrboYgacjL8boJIe66RlTvH/pVdkQr49rvIohrT4eu+Lni82/lfjL87Q8GjdrTaNEAfPuDwNtyEly80xnyjFfcR+57KAj+Gv57ROTiloxzUoZyyno/fa9zOlYtr0EsbL9sr+t8pLL5aRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ESoNfpAClzsulBlkW2nTHcr3lkp3SwIP4emYMEH1QQ=;
 b=EweTKNKGJzE9BWcxUFy4PRALf7xvhB53RjwVydBertbLn49hvkwT+wDV1L+C1ch1OpRPQAulk91aKYJl4Q8z+aNBcvrO5u1AX1hjzMH08L5QRXMq/FeYnYFpcMY1yz9ca5fcEjvp/4TLhacfU9O+NO5JXM1HCe31WwQ36s5eiq8LDQGuhefBp6qx/q2DZYjoxBd2JnMBvsuNyRgLDBqOLIK/0B7FPXKB4/4jIAyl0tasuKSr8qhSMnfYBQarq9deCVMsF2cisS8hZR0AJLXRVeDkrEyVEE8B7RY6f1O1udgYY3BNJ0DV+3HUXouESZBC4nAuzPooi+VmRAS4gE4jyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ESoNfpAClzsulBlkW2nTHcr3lkp3SwIP4emYMEH1QQ=;
 b=MG3GmKhfTq9tHzxtUwQGdOOvvjr06+J7Nh/US+Qj+NWAgW6bNJtcf+zmf9gQbwZNu8RD4Oog9VL913w5o0qGyv/kx1QrxFP7ry3cjlKUcekonsGio/cE1dyLfmTUyVyKOkQ1Ilhg5/3xCLW2+MzRThI3m8lHeUBr4xrjDIAlAVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Tue, 1 Nov
 2022 19:25:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1%9]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 19:25:26 +0000
Message-ID: <8a763f9c-7787-e3ad-a26e-5c9c622933a5@amd.com>
Date: Tue, 1 Nov 2022 15:25:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: Check hive->reset_domain not NULL before
 releasing it.
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, "Wan, Gavin" <gavin.wan@amd.com>
References: <20221101184913.62291-1-Gavin.Wan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221101184913.62291-1-Gavin.Wan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR19CA0008.namprd19.prod.outlook.com
 (2603:10b6:610:4d::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: d149293b-5609-4c8b-90ca-08dabc3ed48c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mtTVTdA1/KRAuv73mqAw72e3H5eO0dAj2i060BNYww/jLt49+z81D30022QA0Vg2w+/CllmF6oFviWkp4ctZ5jfb58sS+aNzRxLXab/EaQZmnvh3Dd5rQGx6JB1F2ZFNUtGDmv2rHSL0jNQ7VslDGwCHCPvKLfW2t+UJcJncn1kX/qpEIVOtcUS/2CoasU1uqJHApxb9z7wEd/p0I9YocbYhG3v0xV2au/EmIV9GvGLdjui53JSYfNvbdMsCtd5kFwcEJtoXJuRe3huayIWyCRD2xxSP1mhJQGkZE9Xgf9Lpnm8juTjyTrgU168Jt6b1W6lD6U6XqQA88862h6GWcp8jsrIxUQIb3tYQbyv1xOlVqPNNUF+7zQ+30RNw244LUA7zF3rTvB/99wukHmwd15Rv5GAy0I/eZ6lAIeal0uBRSDoMG2Nd6SuzsQw8eFJYYwu1ZDQ6Sx+CEfIV0s8pNGEFmUykMJ80oXE4N6kL0GzA6+K04ooUsXlPokAW/ibCbcSySS9Uj+M1WmV0zZYpgilxx/zynnjT5s+H03vNCRhLi1mKF6JwDGPXv9taBlnUd5Yzmy2dTQd/Qc4wIlDFfM3Wgr2idsttv0+WrWvKvTzDnD7WQBx3hC2cjIMi/oF1c1EqdduUjSjyCiOlY6pPo6VMX9TYw04yw/ccVn5I0GJ9cOxZHF5JoTaromKmzHEonpiK38ae/KNYJRGRLKYlrL5YLVkFDWKDB/IfQI+e7IrPF8t6Rld28Jd2IL1dRCCL4ZNIapvN1GvuO5z6sQ0E6K7JeGEjdlPc7G4TaETVvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199015)(83380400001)(6512007)(31686004)(186003)(26005)(66946007)(41300700001)(36756003)(8676002)(66556008)(86362001)(6862004)(44832011)(5660300002)(6636002)(478600001)(66476007)(36916002)(53546011)(2906002)(31696002)(2616005)(316002)(37006003)(8936002)(6486002)(6506007)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWxPNUlGcVJmeU43T0ZwTWhyK1lUaHNYUTBwZHNJVFBuYTRoV3pLbFpTbTRr?=
 =?utf-8?B?L1lYNmRDcXNqY2szU0t3ZVVtSVh5NVoxR3lHSDFJSGpjdXZiUEk1STFZTDVF?=
 =?utf-8?B?cUNEQjNVcnh6Umo4ZGJzcHcrUlo0c0FTNXNhWXFxUWViYkg3bVoreDFkTDVv?=
 =?utf-8?B?RmEwaFd1TDE2R0hZdlR0RzFoRUR4aTBCMm55eDg2aTVIcDRzUlhPRzBpWHpO?=
 =?utf-8?B?WDl4MW5MYmVNMUtBR2prL0xydTFKdDJoN2pCeXVkM1BhWFNXRXhsS3JJdlY5?=
 =?utf-8?B?bFQxN0Q0alNkWnBReFpWa3VOclRTdEIyZ1FseG5qdEhKUXRsTXQxZ0lXRVNS?=
 =?utf-8?B?Tmx2cGg3TmlDZ1RRaytlZ2hmM05pcGhZZnRRcjJLU2ZvRGF4Ly9YclQ3bjVK?=
 =?utf-8?B?bUI5d2sza3lnUGlTZktOQXJPb1N2bEdkVVFjMDVMUGhvUFEzeTRCc21MQ2lP?=
 =?utf-8?B?dzkzQUNwemJLQWNHWTlqR2JXYkoxTlJqblVOcFhXQjIrTllHTkU5MEFpb2R2?=
 =?utf-8?B?VlJhTXQzVDJsOSt0VS9BSS9qV29kNlVkby9Cb1FXR04yRlNkZWJ3bjRWM1NE?=
 =?utf-8?B?eUg0MkpOR0xIOTFOVWNyY21ZQUdtVldiaUtJQnpKaUZpNlpRY0Z5eXZoMERy?=
 =?utf-8?B?MDErc1pNckswRzFrRS9ETWpWTzJacGJSNjRQc1JyTU4zYjNaanZ1MjI0bFVw?=
 =?utf-8?B?TVRjdGtTUGt3K0lzMFlBWXBJTW96ZHBpb21PVG03eVVxOVgxU3BzSWhrVTh0?=
 =?utf-8?B?VXh0OHp0K2c2bXkxS0VicloyaUVKeDNzV2VHeW9EK0lUK2QzcU1scVVJZTE5?=
 =?utf-8?B?YlhHNzhSOEpLaG5LbExuUWEyUWozODFTYkpjQTFiQXVLeWRNSnIrM1NxS3Jp?=
 =?utf-8?B?MUJESnoxSzFzeUtxeExicEJjV05vS0FzSE9rbXl5dG93dkdJa0ZkOURoUVdq?=
 =?utf-8?B?bUV3eVA3UW5tbHZBQWlFNHkrU0pMMkRoV3JkWk45UTV0S0lWTlp6U2F4cG1B?=
 =?utf-8?B?NGpqQXppSkpGeU04VjVaY1A5QkZKMDVSbG1TL05hZkxaN0hRNis0WnNicjFJ?=
 =?utf-8?B?cjFzQURNNDRsSFNvQjBwNFBwbFJHaTFZYVIxKzlRVUt3M2xDN0k0M1MxVXNh?=
 =?utf-8?B?MmJyQlBxcVhvNHlzSTBXR01JUzFWbWxld0VtYnBYTEFsdEVRdnBJRUVqdGMv?=
 =?utf-8?B?dkIvZFo0Qlk3Y01BTVlFNHM5VGFpUHNnMEpNaXY4RUJpdDhzdk50SnhKY216?=
 =?utf-8?B?VkZtTUlCazhOMmNZckJFdGJpc2dJSUdtNmJTanZNT282ZlkyQUt1Z2x4anFJ?=
 =?utf-8?B?RzVTa0UwSThFY2tOYmM2Zm9rMWxvQW9tcW1NNy9DZVhaTlBJSDJkR01FU25x?=
 =?utf-8?B?UFZNS3EyWFNWYVUxUWVQRTM3d0Q2WlpwR25UVlFLM0E0SFJDWjR5Z0Rob2hB?=
 =?utf-8?B?aWNjU08xZGJWQW9Db1VFcHd2UkN6TytQNTFKU0ttdWhsY3dKVWVXNFIrOGh6?=
 =?utf-8?B?VXBnTGpBVm53UUVBdTVBNFRFcDFxS09YNnQ0aWtSYm1EZlZwY205SDBleXhs?=
 =?utf-8?B?T1dYUUFvNHJxK0J3NTFHQ3NMdHEzRDNaRHI0dlVhRkprSlR3M2s2MEVKMHhz?=
 =?utf-8?B?ajNjVmozZGlLUXR1d0JEdk5LZi8vcUhhTlUwRlpVT1hFeGt1Zk8yeGR6OEtD?=
 =?utf-8?B?aW42U05LT1ZLcElVR1VXUFY0b1JKNXZUbWphSi8zbmlqRDI3cVpFNlVEdWd4?=
 =?utf-8?B?M3owai9hdk9sNmZCUHZHUENHdUtOQ2kvYkJoZm5hVWVhK2RTRE9EbXJNcmxl?=
 =?utf-8?B?Nm43cHQyaXpJV2h0UGJzald1ZlRIVzRvTE5UeTVqdmtMVkRocXpLMGQxUGRB?=
 =?utf-8?B?Z2s3SE5aY2ZHMlNuR3UzNmticEI5ZENsMnVDSzErWEdGZGZoRkVIV1VIa0FO?=
 =?utf-8?B?bk14RDhvUXBTNE9BbDdGVjhqRE9JZnRJR1Yzb01DS0RKenpEZ3plcVBKQVdu?=
 =?utf-8?B?NG4raDlUWWZLZi83d1EyTkFqa0F3WVdPbEtvdkxKUkVqNkxULzlRM1JTREJq?=
 =?utf-8?B?eVBrMVpEZFVjS1ZXcUV2TXZYdkdWSng3MUNlOTFlUkVOL05DejBsa0k5RWNu?=
 =?utf-8?Q?RwUN+wU4v2FD3WK0keojnQDp5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d149293b-5609-4c8b-90ca-08dabc3ed48c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 19:25:26.7259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8WYuq6OpI9Eha4kLEAMVk2cLI7aP00lu2tbjCk+5Ydg2DY4gOVHHWlhqbAs3YRvEx9Rnir+OEQpMTh7INqM9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758
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

On 2022-11-01 14:49, Gavin Wan wrote:
> The recent change brought a bug on SRIOV envrionment. It caused
> kernel crashing while unloading amdgpu on guest VM with hive
> configuration. The reason is that the hive->reset_domain is not
> used (hive->reset_domain is not initialized) for SRIOV, but the
> code did not check if hive->reset_domain before releasing.
>
> The hive->reset_domain need be checked not NULL before releasing.
>
> Fixed: d95e8e97e2d5 ("drm/amdgpu: refine create and release logic of hive info")

The tag should be named "Fixes", not "Fixed".


> Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
> Change-Id: I17189e4d7357e399c6b70e43c24051356c025a3a

Please remove the Change-Id.


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 47159e9a0884..371c4f1aac2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -217,8 +217,15 @@ static void amdgpu_xgmi_hive_release(struct kobject *kobj)
>   	struct amdgpu_hive_info *hive = container_of(
>   		kobj, struct amdgpu_hive_info, kobj);
>   
> -	amdgpu_reset_put_reset_domain(hive->reset_domain);
> -	hive->reset_domain = NULL;
> +	/**

Remove the extra *. /** is used to denote doc-comments, and this is not one.


> +	 * The hive->reset_domain is only initialized for none SRIOV
> +	 * configuration. It needs to check if hive->reset_domain is
> +	 * NULL.
> +	 */
> +	if (hive->reset_domain) {
> +		amdgpu_reset_put_reset_domain(hive->reset_domain);

It may be better to do the NULL pointer check inside 
amdgpu_reset_put_reset_domain. In fact, current staging already has a 
check there, so this patch is unnecessary. Just sync your branch. It was 
added by this commit:

> commit d6a7ab1e0168a96b6cb0e386399e54af4fe39af4
> Author: Vignesh Chander <Vignesh.Chander@amd.com>
> Date:   Wed Sep 28 14:59:45 2022 -0400
>
>     drm/amdgpu: Skip put_reset_domain if it doesn't exist
>
>     For xgmi sriov, the reset is handled by host driver and 
> hive->reset_domain
>     is not initialized so need to check if it exists before doing a put.
>     Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
>     Reviewed-by: Shaoyun Liu <Shaoyun.Liu@amd.com>

     Regards,
   Felix


> +		hive->reset_domain = NULL;
> +	}
>   
>   	mutex_destroy(&hive->hive_lock);
>   	kfree(hive);
