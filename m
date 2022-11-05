Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0BEC4332F
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Nov 2022 23:10:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79C0110E16B;
	Sat,  5 Nov 2022 23:10:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA79210E16B
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Nov 2022 23:10:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGuXzsOiBMc82ebglq8strXacPHyaczpjSBPOvMZVmT4Ndo3vMPoRveydlozigzb7glVE/wKsWEYUi8esgjf737WlwXS1DzrcSM4FENv4qqf2RUve2aIervtqqbC/rhMyi+ujiQuvTLnhdQdsbkqIPj4vLXiTy66MwSHVvtPzTPBB0jBpif8M6OG63zZI/QXvPdp6B/3JxrdFgdIZPxeo5U4lvmrlVsGr7rG3IF/6R8sNUX5l0bGhic8/mdlURxEki5AMdjOm8RNZyVMe+PNZTHHGtVVInnpt4Mor/cxnY2tiqQm1mOpTknWYfDq7tiCYD6Ov8GRn3qeHPbCi+2MiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyL86+bLXUBazP3ig8m2xeOXZymkV1UVUN7OWocFljA=;
 b=BBO9NDx3qqDpydvpwqAf5RAZBP80h7ap6ipbx/BlsKSN7D3IKjH+bVSOi/DQlZoPFA0G0DCAhS7byoBYFaXG8PZuGjTgPD8xqZOIXlsSgrRB4n4eHVbtmmSR4AEPy+DiQIQtEyiGV9XexLUn2azClCPeZizCVbpbHCQ9CHZT5MFqcvDdk19I04omUaPxFL2sTCDfdGMWCkOxS2oH9zi7Em3RA8Snqu+vnDuXOCHq0/BF0oXRHH9o+yrfDaxM8fmQk/FDAcs6szSsrJ3bOzLr5SF4XDVl1UUFD7vdlX7ZxzNDmJhkhxGmBmXsVQgqJ4s5gcX700rWwqXsGG8TKZYYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyL86+bLXUBazP3ig8m2xeOXZymkV1UVUN7OWocFljA=;
 b=z8pdZH/UKQYnZCBnPNGKsp0Ppa8BTjX5g1kItVBT1eR9+CfKVzO4xh/FN5PaQyfAoBnFKPQR1tgYGyaPylyu4t62EdLpxZPmPW2bBGu11h0MvcNbIWmw7q5PyY4ypEFyK1hAnCbYnftP3fZeOAz4NPCx3ZQWvSIpLIC7Y7y/LJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Sat, 5 Nov
 2022 23:10:37 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5791.024; Sat, 5 Nov 2022
 23:10:37 +0000
Message-ID: <930077a3-f598-78e5-f0f6-545b2d928676@amd.com>
Date: Sat, 5 Nov 2022 19:10:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: Fix the kerneldoc description
Content-Language: en-US
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20221105214606.14892-1-rajneesh.bhardwaj@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221105214606.14892-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::39) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ac9d8e-1ab1-4a61-9991-08dabf82f329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6x8mlrw3HGabkcem6Kjii02V08NBcEZDxS4rByktXvxxSX26tXoLqEoJSRwrWLAe5e6jOk21P7rf1vfWYEPv6DL9DCOJPfHecaOTozJTpH6dPy21MmfbuzG5hdRY28VlxXizi228yxfV25pA2ewkVO9snck4vxeiq55j9EM6h653de2UadCuaYTvOPwsLnC2tD3rNsTKUAA+wIC+ErJ1JZquUWTkkgvw5DaYVUSBdjC0CHlK/l9wbDKQzoiDH/RKjY9N1nKaw/SyZSFkWp/e95GwA8kgNKA5dGHlpW2L5a4zTn8QnAubvpbo+t6vG1i0vrHaPwnvrROVNhDRv/HRI63MtQjL3HYlLWLZbCgc5XBx1qHmPXQP9Rd6Emwdv9kLIO/moXHlLdy+p/f/oJgrFOc6qWXzLFPxwpq0pPeM0aIjDYem1kFj5VoBzfvfSapvpBD0fICzzvRe5BLsS0599WOHu6j9PrgDXpX93xRLEDS/6HVVnSLlMdi5eaqWPZqW+Q/d0UOm1nlERA/VvCdKyAfnuQSyp5zjkIsGpl8cwj4MCFeOAE4I9gaq35NLUr1o8yqb7snADd2PFX2fVqehEE1G4pHFXrJKRwFs96pnjysNwWWiPNjA49HyG7gjfYpcx7zIdRTM5av9NwtJ6g+hDbtFJ0Kkv/GLoECItvS9S9h0H/aYQN5fylmG7hhJIm69wU2SimDRkiWQkMlc0zTkTtjV7lcGv8+W0jRegEJbQKRa5CBSpAmmussbk0DSiwKn7WjK1sBpkL097IUTk/TG+WBchuPsrVwXfr2/1zuKZwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199015)(38100700002)(86362001)(31696002)(8936002)(26005)(478600001)(6486002)(6666004)(6512007)(6506007)(2906002)(316002)(66946007)(66556008)(66476007)(4326008)(8676002)(5660300002)(83380400001)(41300700001)(44832011)(2616005)(186003)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFFqLzJkYk5LaktvZ3JwSWNoVDF1TUhYeXA0MDZwd1ZoZlN1UzB5c2lpRzMv?=
 =?utf-8?B?cnRwbTFXcEh6cGhRQXBlb0FtdEpQNlZSY1B0ZVlQWFNpMGI4ZTQ4Nm1NVS9k?=
 =?utf-8?B?MU5OYVNNVTJQZGhaMmdTcGhxTEFiRWV6QlUrZHNyMlVPSGh2QnJrZjRJcnor?=
 =?utf-8?B?MSsyajVXbUt1bFBSL1hWUlhBSE9NakVzNWZ2a01taWVwQ1dKMXlTS2xtdFBn?=
 =?utf-8?B?Z3RuYzVvejgwYlJnY1M3OCt2cVcwWnhURktqNmY1K3hSS2MzeFMweWVFdnNs?=
 =?utf-8?B?Zmg5cXFMOHZUNFJVVUFzV1hKVXgwWFVhci9Zbm5xb3JUdkQ5bHFabllwaE5a?=
 =?utf-8?B?R2FlLzNYU2FkNFRyNFFDQ3pFUUNENEJqbjZmV1FaMWtLc0hDa0FrekwwOHhk?=
 =?utf-8?B?SXNhamE1MHh0WURzWTJUVVlDQ0ZuQWN4UDIrZzNlRXprdS9FamZpTitiL0Uv?=
 =?utf-8?B?ZXRua3NJWXpQS3dhbktLTjRCcTExQ3BMVVFyR09RR21JWkF0Y1BFZFR1bmxn?=
 =?utf-8?B?TG1KOFU5KzJzSlhsZE1Xb3lsRWNMVzA4ZWNGYWY1VHI3U2VOdVhuZ3ZhVGts?=
 =?utf-8?B?T3JESkw1MG9mOWloUFZkT05oZDRmZnVheFFVVEM5UlZkQW9PL3krRlByZ3Bt?=
 =?utf-8?B?bEtRaytWaEpVY3VPZUxnNmRlNk9Kc3g2VmFuMGNnbVcxcXBkaHlSdnNLV0JZ?=
 =?utf-8?B?MDF1MHZMNkdXRjRLS1BKYnJHY0xWY2UzZTQzTmpYYU8rSlJTb1pYT2I5a3dr?=
 =?utf-8?B?NzU0R0pmYmVzK3VKaVF0QytSQlU2cjJodlNCZkZEWUNLcWpxS0xML29NVlo2?=
 =?utf-8?B?V2ViRzZWMkxiMThtTE03bW8xZXBnaWN0K25KTkkwSFF4eWR5SDhEMENDMTNu?=
 =?utf-8?B?dDRwNXhseHU5alYxdjBUR0FlWXdoa1NhVDNDcGtEUk9YdER6WjYwT1g1NC9M?=
 =?utf-8?B?SkZJS1M4YWF6cVNhRzZvUkxyNG5tMFVxMTZVbEFLSDNINVpIUlBXNGM4UUN6?=
 =?utf-8?B?MUF4RVRUT3dBUXo2YUtPb3MyZ0ZKMVBzYmlDcnJIRXNjb0x5OS9mRG44TC95?=
 =?utf-8?B?SEsxeUdqWnM2Szd3aGRyaGkzL3VYNSsrS1R5Z0UrSW12cGE3QjJ1U2g0Snly?=
 =?utf-8?B?KzlYVVlESnBuTTl6RmRhWUg0TEgyR1hoYjhZR0R4YzBHQnE5MittVkNOUUpx?=
 =?utf-8?B?WGtaZFd4T1JGTFlqOWorN3cwRzF3ZEI3a0tOc25hN2RaOFZxalAwcFpSdUVW?=
 =?utf-8?B?dUc0cWhnNnRlMVBBZFdXaVJlRzN3VE56eVZJTFhkVXQwV2xjVnVkZHpnc1VH?=
 =?utf-8?B?RlJDcWdQSzZFZy9WTXhsNjhUVmNzMlcvZ05KMFR1UjJwLy9BT2xlSlV4Z05X?=
 =?utf-8?B?YkJaWkMyaDN6d3RXV3I4ejdSUzBvY2xVMGhHYmlDSU1LZ01penYzcTdsM0RS?=
 =?utf-8?B?OXhtMitHRHdWak9WRnlaTlE2U1NNbW9HN0lEK3owSUpNUmRRdVNvSWxpKy9Z?=
 =?utf-8?B?QnlhdzdWbThNQ0ZPTHRTUVNEMW5GYlRQOTdIKzU3d1Zjamp1aVN6ZzZVQms2?=
 =?utf-8?B?a3R2VXI1a2krWlR3MXNpWnpvYUUzZGFjK05QY1lKN3dPV3pUNFhDUkM2c3NZ?=
 =?utf-8?B?TnNOclVxQTdMbWowWi9UeFNvL0t0aVR3bnNCVDlYdnQwSDMrR3NKU0Z3N1Zk?=
 =?utf-8?B?RGdqcGFqbm5MZW9TZ0pRaS9ZMlZJL2xFejd4RDF3clhyTHo5VnY4SU4zVmor?=
 =?utf-8?B?L0IwR29nd2xjbXlwdk1OVjZUTnJubW1WUGlBTHU1UVFCSmtBeU5CdU5zbmYy?=
 =?utf-8?B?YUZuRTJUaGZ5SllzVkI1aERJV2psZFY1ajNROXN1S05IbzVUYW85NEtRZHdO?=
 =?utf-8?B?em9kOW5sbm9HbzBna0dUZ2tGVGZGTXVLRUZXWUVlM0NTbGlrMlhyVVMzdis4?=
 =?utf-8?B?QXpidVMrL1l5djhvOVphZW9zenNGNEltWHJwUWR5RVFyRDdVSndPNEI3czFJ?=
 =?utf-8?B?R2RJaW5UamszWXhpVDZVeWx0c2tYWFNVYjJGVDJRSHhaTXdTM3R0cTA0TVZw?=
 =?utf-8?B?WVF6bWVnQmVxc25RaHJWN080L1FQUmhISW1kbURSdFZjcWd1dmFNVVVOVDlN?=
 =?utf-8?Q?uoW9MCbwh+6b20/I0df/lyUPW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ac9d8e-1ab1-4a61-9991-08dabf82f329
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2022 23:10:37.4308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnuWobKgyhENkRzHI36csONOCqGEFp3Swk5q9+zqoj1bm8m6aczvWZup354Mkw3UtLrtZxe5DGIX/68y2c0DhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-11-05 um 17:46 schrieb Rajneesh Bhardwaj:
> amdgpu_ttm_tt_set_userptr() is also called by the KFD as part it
> initializing the user pages for userptr BOs and also while initializing
> the GPUVM for a KFD process so update the function description.
>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index ada57a37a020..bcad26a3b009 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1409,8 +1409,9 @@ int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
>    * @addr:  The address in the current tasks VM space to use
>    * @flags: Requirements of userptr object.
>    *
> - * Called by amdgpu_gem_userptr_ioctl() to bind userptr pages
> - * to current task
> + * Called by amdgpu_gem_userptr_ioctl() and kfd_ioctl_alloc_memory_of_gpu() to
> + * bind userptr pages to current task and by kfd_ioctl_acquire_vm() to
> + * initialize GPU VM for a KFD process.
>    */
>   int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
>   			      uint64_t addr, uint32_t flags)
