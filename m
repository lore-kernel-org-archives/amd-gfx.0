Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AEEC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 18:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 781B9611C4
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 18:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 781B9611C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1642E6E9D0;
	Wed, 15 Sep 2021 18:02:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C844C6E9D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 18:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNqgkN0Qc/LRt7WOBH2A4PDb/rcE49BcY1Eg2MEDvkURqxVOmwAkaiakomNC/I3hhFMRCa7nq1d8cs6UJ2AzBpQvfxLavM+fJs2DsUFtIGLHX+WkL4YQ0OjAxu8fwhtSysE0+tceBZVPaQ5jwRYwPFIHvjf1/45cJGaZCqqTruTweh6gQwo/5xdQQTBEyC8Iksh9sOMqgIkdBMPzj2STO1xYK18UVvcxju+13Xyht9cPwZ8zIPOReiAgqpK8gsh1wa/3CMVcqjrt1P3Yg1xevJAjg44aJySJk9b+0ssCJJkDInN9lylVCxdIQY3FnRYJBojBluwTS22s3ipce0JxRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=FY2+IXpW8KT0awKJ+WalZVAgDYvU6bQjKErAteLRSso=;
 b=ULfQSYUQC0+BzCSwiQ21Lo49y35DX6hLK5qC7g5xM+uepLmePYDOa/JN8sSQnHWko/SZ5fg0okn3B+F/a3/Cwo5tQIV0tONaF1F9hiK1oTDFC37ljT94qUebvr+E0ONpmMiCWkIZVhOijX6mhvXRzxQOKch3I0Ko9/qOs5b3tFrJRbSxVIQHz3MlahGLuTcCvsB6DV0mLD8xNP0zYHVFf4vP+gNnbTEe3TojXHaNxqxUiSbCJ1S0lBFOV53mbpaxw7jGNxF4/GvCLFG+zxjIZCWBmK5BVWgcTeJju4Is5Vl0RGoAdQPQQ9hrAyarW9mEzxhQin2JVSNpmTBuy9NmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FY2+IXpW8KT0awKJ+WalZVAgDYvU6bQjKErAteLRSso=;
 b=jXaHf9gXuGZfZVoAHxwkLpHMdHPUCJZjVQvPjW05B/i+X3uXADS9xsyycDG7jWHWZAwqLqJZWHQ3IlwBF0lrwj8ILoydKXHNAgBXETtqL4rrcyP+fDXg5Q9KTsB/IFT3lgmwRGJRcxehx3mrXAl1m2NRhf9vxsjZiJ8gEIs51lE=
Authentication-Results: froggi.es; dkim=none (message not signed)
 header.d=none;froggi.es; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5396.namprd12.prod.outlook.com (2603:10b6:303:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Wed, 15 Sep
 2021 18:02:54 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 18:02:54 +0000
Message-ID: <d8cd6940-70ba-9c4d-38cb-4b1938f3c19b@amd.com>
Date: Wed, 15 Sep 2021 14:02:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 3/3] drm/amd/display: Add modifiers capable of DCC image
 stores for gfx10_3
Content-Language: en-US
To: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20210914235948.893422-1-joshua@froggi.es>
 <20210914235948.893422-3-joshua@froggi.es>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20210914235948.893422-3-joshua@froggi.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:405:75::49) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.37.203] (165.204.84.11) by
 BN6PR17CA0060.namprd17.prod.outlook.com (2603:10b6:405:75::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 18:02:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6774e4e6-ecb6-47e7-6eb0-08d978730aa9
X-MS-TrafficTypeDiagnostic: CO6PR12MB5396:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5396BF5C201FD3BEA782EF9D8CDB9@CO6PR12MB5396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNVYnsKI9TLAwW+oxTmfACIglICgdy6p5kEMWhrhr7vzQemBI37p4EM7NR6+77KObxvD38ZqITUkt8uv4bTeM9c2YRK37HipaW9oNOITAsa/bT928uT3xLRfHsKqm9jTAsyK5ATRcp3tmJogfCdbKpSflHyevhVwoQuNpN9YZQGH34YGK93ULBLKvHfM+Njxp/gN3se8sAiAxgm0L2TfrOxad2EuvrKGvb2Dsn/xkun0HdiK876xbK7bLiwd7McKf4e445KjVmQqikj2S3zxhrVH3G05fxve9pWdAzH4Cd/76UjFX9J7x5UmLP+kUsTYR55HRQzQvPqrq5LynH3uFalZMwXhTRDRd731EZcNvGsXQ3Olnlve8yNKCqg+RIQkYRJo5zIlfE00jffClsd8RTeOM1Tc53wfCyihHxq+osETPBn7L9bCtlelxcOfKZvUHubJ6yeQDvHWW7cwe4ndAJGKAGGdRJXs83+DFxnAlSEMarWl2PzBZcEllRBWbksum8Jvq84KHPLMuYKT0lNgvpnxVIH43CW2QT+UdbK9eOswqt0D+wl3pc/K14ye2OsC4fJwdJtk6ilr1j8yR8r6NC1uxmAdq431GGYoG3dHsrS0HUYnFTe6YcBOZcfebgKCXMTTXwH9zPi4CqKPegGM6uv35gxmGGnIUyiRa4tRT+zngy/Cd1ZSY2uGFWYn9FqdEWcG8hUOwBsdMqX4uSCip5ZBy/ia9vxlxMEIhHc7ceg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(8676002)(83380400001)(31696002)(6486002)(956004)(8936002)(478600001)(66556008)(4326008)(36756003)(186003)(66946007)(2616005)(53546011)(66476007)(16576012)(38100700002)(26005)(5660300002)(2906002)(44832011)(316002)(31686004)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWtMTzdPQjZLZmYxVFNPa3czQ0N0UzFHTkp6WDhtcElNRGRGbUVOVEhIcW0z?=
 =?utf-8?B?NlZZN0R3VmpGbUFMM1V5U0hiRnJKQ2g3UGNScnlOQlEwa2xnb2xhNHZUdzZW?=
 =?utf-8?B?bnk1NkxZRVJocTJjQ1h3WUozbzExc2daZ1BpZG84SUJ4VlVlY0FSM0htTmN2?=
 =?utf-8?B?Y0dORXdteHpPMkU4Q05sbURLa2x3UnlRWmlPdXBjZ1ZIRC9jV1ZWQTZ5ZDdq?=
 =?utf-8?B?L3MvZEhuRFNla1lwMFZ3Nndidmx5KzdkeGN3RXZVOUZWTVlQcGVUUkZKZlBY?=
 =?utf-8?B?TEZQTjlURy8vOVI1d0RPYy9IZ3gyN1IySENtY0lwWFplZVNnV24ydlNmcU04?=
 =?utf-8?B?ZVZjUVNuMjF6Z1RMLzRrU0xubnB1aTF3Zk9iMVpESjBEdmFIMG94R1NNdFBp?=
 =?utf-8?B?VmRKSGNCNXI0Z09nU2dLajNSeEt1MWR5ZVhpNmNoQUJyZFV3UklIMGs2ZXZK?=
 =?utf-8?B?NzdqNlgzOGlXekVHZkwxUUkxVFRUci9yUTVLS24yNFdLMzFSaWxXZTJYWVFk?=
 =?utf-8?B?QUVKTDhXM3lMUkdyYmlKUXpNZlNmV3F6Q0hNd3o1VTN6U2JobW43dCszaHox?=
 =?utf-8?B?ZzZwSHFqVXpOaE5qVjhWbndPRHJPdjd0OWRYRWFuRE0ySnRITXRqc3VDdDND?=
 =?utf-8?B?MUZpMHljRTlZS2RZR21PNGZXTXdoMUJRZy9OUkozNmJ0WVNyTVRkdUJJM0dJ?=
 =?utf-8?B?c3NZNUphL2NSaWFHWFVmRTRoSGY1bEdwRzZuUjNUUnh2KzlTYzh5YU9JR3Zq?=
 =?utf-8?B?Y051V053MDFHYjBNODQ0YzFNbFExM1Fva1lmcmY2dUd1NkVEbGV3a0FCRjEy?=
 =?utf-8?B?SXRFYmhraWhDRlNMUHdxeEo4RFpwbk1mMG5oUE16akhINjQ0MWxKYjhQN3l1?=
 =?utf-8?B?ejczQXJEanpPWWtDTVY2bWdvc2h4MUk0STNDOUdvSlJOY29uOVNETDJ4NHM1?=
 =?utf-8?B?anY4cFI5YUFPeTVSeXpiamxUSG1HUzZ2dm9NNlR6SkJOdXQ1THRJNVp5TmY3?=
 =?utf-8?B?Y0ZHbHlxTG9tL2J4TVVpdmFkNDlpRUc2dVVUdTcyNEdtdFlGSm9ibmtwY1lN?=
 =?utf-8?B?VUVCaXFFaWZKVGtFSCtBSyt2a2JXUWhjSFVjTmtqMFo3Uy9kVmNqQkpROWhn?=
 =?utf-8?B?QWYrWGtWZkFBK1pCUlMvdEhzZHNrdlZXcSt0M0E3SFNyNGdSam4wTEVEZ0h4?=
 =?utf-8?B?MkFFWlBrQnZ6ZmxoL0ltT3BVd1ZjYnQ1TCtUSkE2eStiQ2x6alhHam9uTElS?=
 =?utf-8?B?aXVKc1BNUGgyT2dOYmtJK29HZnJReW5FTmRwdloxVFhSSjhOUFVrdmZ4Z1pY?=
 =?utf-8?B?MFdEUVdkelNNV0FmenB4amhZQTVBSlpIcUwyeHh0WlB1bFRRYlRVTzNBRUk0?=
 =?utf-8?B?SWJIWUhoeWRKQkpGK2pwUVpBOEZEYXpnQk0wM2lOUlFHV2MveWVsbFZDMThF?=
 =?utf-8?B?V3A4RmhjSW90bTE1Q3hIaDRUYlJyZEJLTGJybXZmek0yV0VCRXAzQjRFSDBY?=
 =?utf-8?B?ODc5M1VJa1lhT09JTi9VbHlTVDdyS2VCWFJ4dE1odlloaHU4dm45cDd5SDZo?=
 =?utf-8?B?Q2REVzVBZWpoSHFCVDVyaHJNdVV4OXUzU2plOWNNTmtiQjZaZjV4U1M4QjlJ?=
 =?utf-8?B?c1pQY0lQeC9LODAxaHJjdCtGUWZqREs5d0xUR3FCYmIxQXZQQlhISEY1QzlP?=
 =?utf-8?B?MkIrVnZyOVdBcjZEV2RKQkt6bnMyT1E1ZVJYeForYnZ4SmZVemdnUUJNb3Fo?=
 =?utf-8?Q?8GkZKbH+u8e+Vi6pflzKtL1OGPb+B5J1lVHOn5H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6774e4e6-ecb6-47e7-6eb0-08d978730aa9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 18:02:54.8897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsEK8K+yQJbiTd1eovhYNMNxLcbJ02dAAauer7sQUBi2ut8ZUkBcxhUSMs4UMbwbVhL7XZt8BSc6r4xZE99rLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5396
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

On 2021-09-14 19:59, Joshua Ashton wrote:
> Some games, ie. Doom Eternal, present from compute following compute
> post-fx and would benefit from having DCC image stores available.
> 
> DCN on gfx10_3 doesn't need INDEPENDENT_128B_BLOCKS = 0 so we can expose
> these modifiers capable of DCC image stores.
> 
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> Reviewed-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

Series is
Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2a24e43623cb..a4e33a4336a0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4817,6 +4817,16 @@ add_gfx10_3_modifiers(const struct amdgpu_device *adev,
>  		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
>  		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
>  
> +	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> +		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
> +		    AMD_FMT_MOD_SET(DCC, 1) |
> +		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> +		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> +		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));
> +
>  	add_modifier(mods, size, capacity, AMD_FMT_MOD |
>  		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
>  		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> @@ -4829,6 +4839,17 @@ add_gfx10_3_modifiers(const struct amdgpu_device *adev,
>  		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
>  		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
>  
> +	add_modifier(mods, size, capacity, AMD_FMT_MOD |
> +		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> +		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> +		    AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> +		    AMD_FMT_MOD_SET(PACKERS, pkrs) |
> +		    AMD_FMT_MOD_SET(DCC, 1) |
> +		    AMD_FMT_MOD_SET(DCC_RETILE, 1) |
> +		    AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> +		    AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> +		    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));
> +
>  	add_modifier(mods, size, capacity, AMD_FMT_MOD |
>  		    AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
>  		    AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> 

