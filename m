Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA8EC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Dec 2021 01:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61BA010E68A;
	Sat, 11 Dec 2021 01:04:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF82410E68A
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Dec 2021 01:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRUwfGUsXGoF7DbHymKgjbCdlfsYEQNA38QS9EwAjb2fhi03Fmh2Pm0LAY3iR9yccOlydg85ZJidkuCMpAkj3J6MryGFDGuELeDzARFYA3XNJzgsM3yrWLe7XLFI2lqFaJMA7JDZr0T+lFp7XViDZq+1NJI3kf5ea9pPzxyM26Gwec3kgUuCukzRc5L13lJCuVqsL16bUhGkMtCwL2hCHhy7raMdYKpQVA1j4YbWX9rcTt0E8wBkUbz37Eg2RySYSTOyQD7eWVOjscSD3Dzyps5LHkcvT/fCnezl9sqMspipEOqUfH39ylQt4YZprf0W4zyicjqJTZH6K5AZpbzw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A28qS2Q89exXuEf7a49ylF2NT2a2oQOYGSivae/lUfM=;
 b=U/BwhyKf1HXSzsvgBKm75tUI51tQ0Ix3bCRV2eW0Qx6TzWvUWLK4eArhOH5AP5ZpQqJwG4dzw9xjhFnrMNRT8l8bFegr+96eufe4zbQXJIOsNxqwRDaeyh4cAwHwOGtZA/1DsXmjbSUBO7ow+tn43tpuIcf5eZDd/rDMh1MfAqzdjpaLCbJ2dTar0VNb7Wvv4KTOZc8ZUSIzhTkJdjErlryztpgx5UcBovyE8mbMTkUuCgpJVvqoQPVWpx2G9jeRpO4GZ7kMOHrCzibbufeU73d43Mfe4DZUxo0448PSI1ltug1EDMR7UnTU6JevDhjw0BN4CUGvwhiIZHo+EQfdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A28qS2Q89exXuEf7a49ylF2NT2a2oQOYGSivae/lUfM=;
 b=kzChfiJJ3SSmO5dxN80QsL2ewCHl3RYtF5HWVdpuxcLjwxG1327zmu21QiTxcUEmr1W+G2YNhSw50eipGIDP6ste7Clu+0D2ATSC/X3bQHbp3PS3tWLdu287ZF97puND/9/DwAls3AP8av0kvSMzX460m+ur+Rkm/PwiJr6tGoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5242.namprd12.prod.outlook.com (2603:10b6:408:11f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Sat, 11 Dec
 2021 01:04:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%7]) with mapi id 15.20.4755.022; Sat, 11 Dec 2021
 01:04:17 +0000
Subject: Re: [PATCH] drm/amdgpu: disable default navi2x co-op kernel support
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211210032026.1275383-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <3873a53f-516f-d2b5-1701-e1b8b1cd7c1c@amd.com>
Date: Fri, 10 Dec 2021 20:04:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211210032026.1275383-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MN2PR18CA0007.namprd18.prod.outlook.com
 (2603:10b6:208:23c::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 MN2PR18CA0007.namprd18.prod.outlook.com (2603:10b6:208:23c::12) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Sat, 11 Dec 2021 01:04:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4858784f-939a-4e17-29e2-08d9bc42280a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5242:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB524299997584C48347AB99B392729@BN9PR12MB5242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /GQs7npQHCIWlRHPaAtfgyRryhlu5N7rxXhKBJ90FSfOGI0pTA/yDiu4RvKWoX0+TmasVBlU5h4JFmEyQRvguwUUhC+fVqshl4zkClwdbu9OZrT1qQ2D1qZzW2JnLv1jfDfFGLBdIVIgoM8q6ggwuBJxYrXDHbmVZ4rFg9J/1iQeUKKBqI9MX5/xlifR8z78FzYkU3idoUiRW6BgcC+r3dx0n2b5g5BW6FNEIzSVdnMJptV1XnqYjnRcdPJueg0g3uzxIRYxn9O9Whl1UF8P0RJzOAQflyiooolGqSBKwvYuuy/41XzvnnBW6ea4xyUuX1DBabnNHWXGzMwbHlRbnx1DFe1e8xVcfx6lF/sbSFOL4nSg7f62P15bhiISokSQBgBGLLPa/xmRPr6oSJJPk3sorwHps9vnOODd4BGpmvmYsCXeFNOoaUJ6B9Yl29u6evndUeNKvPDwecBJgSDG82bgOvQr3Aare4drFtwdpDzDvGWJNcqXVB7Qg+mnBemXSTnaj3Wpx3wUnXTUsEGxGdTWNRM3Zmpagr0tv2DX2c4hdVt2Rlndqfu6CcH5PnP3xpKk1i4/lBvQzi7KWzeC2/c6MsjyBWh5NRffwFs4I1HqRyAkBLzcNHIEnuVJy1XB1Tp+2l4G3vNANGTnq1J+kiMveEAI3kg9qe2Zi0W4QJjj+jU4Iwd7fYHw9C/3Btdg7utrOVxm9f4qe4VsqgQZ8K3jvFwIgRbMJwN1y72Q9qKpV3se4iEt4sshh2i86L13
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(83380400001)(86362001)(8936002)(4326008)(2616005)(66476007)(66946007)(66556008)(508600001)(2906002)(36916002)(6486002)(44832011)(31696002)(26005)(5660300002)(38100700002)(53546011)(31686004)(36756003)(8676002)(956004)(16576012)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTFUUFJOakdFR3RnbW1JcmgxNmJqS2lEYWhGTi9UMWthOWNhYlhRZHIrS1d0?=
 =?utf-8?B?cVFONy9hNmRPOG0zdTRuUlJmQXE1WS9tRWVGOUtGNEUyRjY4dE5HYXM2eXVi?=
 =?utf-8?B?b1YzSmNCR1d3WGE3KzRIdVlPSHN1bHYxYXduTi9WKzJKVm1TNUllRnEvUGp3?=
 =?utf-8?B?eUVZZWJtcjlCdTdBWVkyWXU0LzVhOWx0STgzMTVlZUJYeDgzVVhXOGswaGNE?=
 =?utf-8?B?SUtCVTY1RUdGV2szdUVzaDdqYmxQOEVXdzdOZVdCaFZMcjRWSnVhUmt4ZjZK?=
 =?utf-8?B?RzdMNjlWV0RMRHlWbTF4a05KYnpWeS9HaHVEWlVzNHNxU1NZcXRCVnBkQWZL?=
 =?utf-8?B?T0JXa3RrMlRBZE1DLzdjYXlXRHAvQURncHRReG1ER1hYYzBVMEJCNEFkQXpG?=
 =?utf-8?B?dVNDSHo2NTB4bXVxSXZVNEw0V0lGaEtzaHA1WVRGanRHOWsxL2o1UGhUNXdJ?=
 =?utf-8?B?eWxYMzBvWkNYYXV5SGYrTnF3bGxQOWZheXgzMG1aRnQrTnp0eDM5aGNzRkt0?=
 =?utf-8?B?c0V4S1ExY09sejd3Yll4QndBd3ZNNWJZRVFTTFBQcTBIaXZVWU5qRkhrUDJz?=
 =?utf-8?B?TjJVcHNGdFliSlVSRXJqSDNoU1BueXRFWFk0dXRQK3lxR3NNTmdXQ0swWnZh?=
 =?utf-8?B?Q2JBbFhZQ1FBcEwraVZ3SlgxQ2tzSVRGOHpZdWYwTTM3THFYcGloUjBZTGM4?=
 =?utf-8?B?WDRLODNVdDE2OCtaUVU4aitIQ2xNUDdDa2xtUU9pS1l1WldaOXVHQ2dSOS8x?=
 =?utf-8?B?L3JUWVdLREFxR0IwaUxKUWhybTVsVEh3WXlPbWg4Rlc5bXBvT0JiZTAxamFw?=
 =?utf-8?B?Q1N2ZjJPM3pMT0hKN3NYRFYwSEhCZzlvN2lrVHlvVDQxNXZtaGVxdldCQURr?=
 =?utf-8?B?djczUjhkemFwbmVsQm5qMmliQmlXaFJRUFVLWDlLeUJUUUhmcEEwU1FmMnVT?=
 =?utf-8?B?SzdyVzh3ZUsyYkdUeWlrT3hpUEdTNHd2VVVOL3ArZTBPZ3ZoV2FwekVmOWt4?=
 =?utf-8?B?emZiUEh6d2RKQmJGTnF1ZWR1d1U2anlDWHpmcFZMSFJvalYrVmZnUyt3WXpp?=
 =?utf-8?B?eGh4Z3BWUWN4OFFYYkJ4VkN1ZGFQenVwU0ZnOGtNWkZpalBsU1NSNUZxK0tK?=
 =?utf-8?B?aEh0emE4RHNLZnhITityY0RRd0o5dUFPVnI4YmpZempuY05VOE52Zml1MXhw?=
 =?utf-8?B?MjM3OVdoNHN6Q2VhQnlGTTNRY3hVR2E5a2NiaEIxTlQzakZ0Y05DS3JZTjF6?=
 =?utf-8?B?RzdQckdNSC9CSG9IWTRacEtSZUtxMVM1L2VnL3FiNkVma1hkOFBNeVJRM0RK?=
 =?utf-8?B?Sk1mMk1UeVRpUXpuTjdTNzdDUUJkVi90WWZIV0ZNbUd6ZHNjRGIzbnQvaDFk?=
 =?utf-8?B?SkpERXhhUXlXVVRTbVQ4K2JMNE1oN0F0Q3N3SDVDY1hpWStWK090NUM5THF3?=
 =?utf-8?B?QU5yNXpxY2FQU2ZHbGhFQnoxMWVzYm1Jb3lubllReWtIeGx1S1lRVUdLU2c1?=
 =?utf-8?B?N3p3c1V6dUwrY0lQVGJlREYrUXZHMFRFNWpXS3RCZE5hZmh6ZVd2U09JVUlp?=
 =?utf-8?B?MUxpYk1rZzZKbjRpRzVRdHFZa3dsVlc0S1VTaHR4TDNMV1RhVGg1elBLWURl?=
 =?utf-8?B?TU5mVnkxMytkYllYeGJVcnZpNnV0N2l0Ulo4STVSd3daNTFzbFNQSEFGVmF5?=
 =?utf-8?B?Tktud2xvV3ova2c4OUwyY05XT294K2NEVEZNMkFPSDcxREh2aXVSOGFCMVdn?=
 =?utf-8?B?VVVRSUNtUVpzUVJTK3h1ejdSMXJCYk01a2w1NW42QnYrajRQckhuWGJXcXJX?=
 =?utf-8?B?dnpaTzlJelVldC9rQktURmd0c2svVEl3TXJnTXJkSHlRVFdVMWtFQjU3NWRE?=
 =?utf-8?B?ellIVzkvS1JlNnFtUkc2anRHcUJzTkgxdlF0Q3pjZUpoS2RHdzl4SmNkc0gw?=
 =?utf-8?B?NG9CK3VONjdONW5oZXR2cEltUHB1UktmQmhPdGl2SEdYaDVmNUhwSEwvS3Ur?=
 =?utf-8?B?Y3RXN0syRDFlUElVL1ZDd3NmdzZmNGVWbjFSR05CODcyVk9tYmFPalJQZFEy?=
 =?utf-8?B?ZGF3aG9uNHdhM3gxdzV1ZkVaNTNNUVRJbWJITTErcXVvZy9IUUtYcTFRdzho?=
 =?utf-8?B?ZjRhWkRrbWkxNXdOa1pBVmtaV1pLSUR0eVFqTXNJanZtYUphaXNXcjNNTEkr?=
 =?utf-8?Q?JQAHWIiFkDxIChw2Kuxks+c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4858784f-939a-4e17-29e2-08d9bc42280a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2021 01:04:17.7424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTl/qZPbCfZSkxy4xZZzbNy21Ls64F7p9kI/Jimy1L2njI3CeWuq5+KySkmN3HbdGYZrHGvl1C6vNp4Wa12w0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5242
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
Cc: Graham.Sider@amd.com, Joseph.Greathouse@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-12-09 10:20 p.m., Jonathan Kim wrote:
> This patch reverts the following:
> 'commit fc547b2b1816 ("drm/amdkfd: add Navi2x to GWS init conditions")'
>
> Disable GWS usage in default settings for now due to FW bugs.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 67dd94b0b9a7..facc28f58c1f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -368,10 +368,7 @@ static int kfd_gws_init(struct kfd_dev *kfd)
>   		(KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 1)
>   			&& kfd->mec2_fw_version >= 0x30)   ||
>   		(KFD_GC_VERSION(kfd) == IP_VERSION(9, 4, 2)
> -			&& kfd->mec2_fw_version >= 0x28)   ||
> -		(KFD_GC_VERSION(kfd) >= IP_VERSION(10, 3, 0)
> -			&& KFD_GC_VERSION(kfd) <= IP_VERSION(10, 3, 5)
> -			&& kfd->mec2_fw_version >= 0x42))))
> +			&& kfd->mec2_fw_version >= 0x28))))
>   		ret = amdgpu_amdkfd_alloc_gws(kfd->adev,
>   				kfd->adev->gds.gws_size, &kfd->gws);
>   
