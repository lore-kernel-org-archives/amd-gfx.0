Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05997C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 15:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F95A10E745;
	Mon, 13 Dec 2021 15:16:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BCB610E745
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 15:16:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H71bWyLyIWmPzNepipm8dGlCIclbix3OK4UPmVD5q+2o9+dgT3U4HO1o2r3nfeVCnpmWSf2Y/dgIhPDGR2vmZhP3i/C/bQysDkbcvzY++LO88INaF9YY7MxEBLr2zOJRNfqMvgH7paSpG8FDQbLkLzWmQAYMKAgqzqzYjPFCsxYABTnBNQNp6H8MuMLoKUeOoZzhTGtHxqpCdEN4SLW1pAyJ7XesrNY9ZluAB1HLcn9DQXmJDjA+uM+4NecTCNRFtBicAqr0RDX5GyEdfgcbXjVtnFebGsX/WH4cfc2XUq/MdGQSxD1bMCLm28xBZbt/y/L9tpy03sS5W9RoM9ddIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKGYXijr1bnblOrcIiCf9YBqd8psLeJpP3eGPUQ5Jxk=;
 b=XGGeoGnRTh/8yqEuoYlj/eVOLabUqrqzUIbVXOIOB2b8IcDll+HTqHU/9BJz7CX5avudgKC+B4e4yOaPUg599WWdeQ1SslBhXsQ8LUw45aSCZZWlanKcbI+HYvLU2aNikhxis7/cNq6QQUJyJlNYgOgoVOqpGKtRqoZ70sgYh0ME49gXRjdEQjRZbUlMlN3S7GSi3etuuUwGxSNKDAzJqW30dtuaESvRAq7N+yxsmr4atm/I/TtZkG4KmSZPKg5WyjkScDokB58//LbyVsiSU30uZfq9jznRoIJxQuQ3E94pa+eEUAG4P40N+Z8RMByInmHwkzUeV4poBPLIIhlzKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKGYXijr1bnblOrcIiCf9YBqd8psLeJpP3eGPUQ5Jxk=;
 b=g6NwYN9GQWaZD8dsAImtjph9rEN5U0Y93wRJD3p+DuGWKDBA3RTvhNeFg0IDevyATEiYlJARnfdz6kb8sWzwDGbtBXWD4G9wM61qdciVr34qKwzOZOBMUj2m2iXxGexM25ZS0XY0GDgk5ANA/Hd0er46i6Itj60/yn4NjompYkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 15:16:51 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::fc8b:a234:609b:884b]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::fc8b:a234:609b:884b%9]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 15:16:51 +0000
Subject: Re: [PATCH] drm/amd/display: Guard debug option for dp_force_sst_set
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: amd-gfx@lists.freedesktop.org
References: <20211213145110.910626-1-aurabindo.pillai@amd.com>
Message-ID: <63390566-9a48-0cc0-dc9e-49aefe0e5291@amd.com>
Date: Mon, 13 Dec 2021 10:16:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211213145110.910626-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:610:5a::21) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 842777f0-2ea4-4e20-2989-08d9be4b96bf
X-MS-TrafficTypeDiagnostic: CH0PR12MB5348:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB53480979604CA636186268688B749@CH0PR12MB5348.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +WvT1VfI9aUx6dBw3B4t6xdtkr1m+cqG6DpCQdrIxJ4L6jDRxaq4XWfE5mLCj23WQ0CE+IIJqB6xVhMbMTT0V///RwBot7nkvoPkHMcFDCetLIqSRWuog9id+HgROCkAhTzXt/wVieg+6awDGYNdXhzuHDQr80X8fy7cfDpFV+KblhtGZvEu+sOxEUCMbsvO+/aCaVHCKuq0YpQlaVlm5C0iGai58/eNHG2UUWuIRuKmEP2ED841vI7eeZvnJsclv0aqVaTAXhyafXugaJI1Q0v3WoG2bzoH0ZFK1veUT3N0DPob1XM9l5Xxr+5l+ggRfbhtVOPhytujTiQxUGCu9xccAzYTPT+TMMu3L4FSuumOicmFkY9eqsXeJj8Yq6mT6nWE4rgB0crxHRctVuWZjEYRGHdV5UZI+SM8KFa1PMvjqu20QjOGzyEPvdP13aPVHyYVoQBA4V85oaFNAalaux4aT57BHl9e61+fY9UFiMKwSlF2vo3GUFMErg0sVexiHBXcTxMAjQx7esV/YQBqQqm9aCShEFQvjrqSCyfDxOLwPF447vrSTe2dszusVCxRn07a/Pya9RJ0/ApAeZ4tyKeMf8dc1xsw7H6q39wG/+PUlXkHunki5e/eMilMM12TSdg4v8d2PSkNG/suYKUHVGX0DVocokyDZZbTX1y/MsK0JNdBmH8wTyWSFoTot/ZDN4Dx06hvLPOSZwBIpJBWrSrIHa+o9mZGlFm1Jh6Bl6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(186003)(66556008)(66476007)(66946007)(53546011)(6512007)(2616005)(2906002)(26005)(6916009)(44832011)(508600001)(36756003)(6666004)(5660300002)(6486002)(38100700002)(31696002)(6506007)(316002)(31686004)(86362001)(8936002)(83380400001)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0kyUkY5SVBUOCs2Y2ViRlZSR2RESy84WG01Y3JTN0RhVzZnRXdvVUVEeGo3?=
 =?utf-8?B?MHdyREZaWDRxK2NjS1FKZENEcDNWS0VKQzY2ZmFHWXRYNm42OFBlb2QwMktX?=
 =?utf-8?B?VlNNYVRJT3dKa0RjWDBNTUtEZFhyTzVpWGtkUWozNmJGM0xjcGxWN2RpTXNp?=
 =?utf-8?B?RGpPSDVMdVlrQ3VkYU1CNE43V3hVKzZwdThQLzJBRXhXZXVsb0hJVDJoMUd5?=
 =?utf-8?B?V0FnSS9xelM0ZHIvclo0ei9YY3hnZ2w2RGZ1WXhTOHczSDA1M3ZwNUc1M09a?=
 =?utf-8?B?WXZqNFNvL2hjTlEzWkFMVU1ISy9xYms4K3JHNElVOEk5eTNnNlVYblVsdFRW?=
 =?utf-8?B?Q0xibXVlcDVhOXlwWXNFcE9SZVg3ZU5CRWFQdGpyQmNxT3F0TkswQ2hNNGRv?=
 =?utf-8?B?M1NXU0VtbGw4a1F2bFFBS1hUb3kxU2RoSVo3L1VCV0ljbkluSXRyNC9YTWRX?=
 =?utf-8?B?am1tRmo0UlVPYTFuM2JmNjZYclZBcnlyQVBXaU9QVU4rTXltajVZNFpISG9r?=
 =?utf-8?B?WE9pVld0Smt5bFo3Z0FybDhEYkJ2dmgwbmgyVEx1bDhwWHJ6NUloNGIrNkwy?=
 =?utf-8?B?eUpDNlN4R1RZMS85RU9TbGZxYzJzTUw2NXAvTHJ5RXNKL3ZmRCt6RlhHaklh?=
 =?utf-8?B?Yi9MM1VXT0hjbys5dTN3NkZRUjlyL3puTDB1Ylp3R09ublNPRnJkb0tGdmtt?=
 =?utf-8?B?UTk1dFhSaHdYenJ6WEV0cndobGN1Nm9qNnBON0lxd1dRaitzOFZ3SXE1aWJP?=
 =?utf-8?B?RGtCKzY3UzZ3TW9JTWZlSFhaeHg4V3VlVFl2VzZXY3A5L29EbThqeEZReThP?=
 =?utf-8?B?aVJObmlhWlEyUXY1ZzVrZmoxenpJeG1lYXJKdzRHQ2NhMVEzMVpIWHkwTUlt?=
 =?utf-8?B?R0VQQmc4WlVodW9GclRpdC9naVBtMzFzbk5QQTk3MFRDMURKYkdZemdCYmtG?=
 =?utf-8?B?K2JMQzdGZVRycFJuRVQ5QU8yTUE2eVk2c01GVURXb1BMZU9rcVJSMGpKRmdq?=
 =?utf-8?B?dVlvb2VabXF2cmlqU3VJSGV1YkV0NHJKSkx4TEROaHRIRDdMNm9Id2hvVnB5?=
 =?utf-8?B?R2dVZW5Wa09kU3h6YmFCMDhRS084aG53OGdzd0NxeURzK0NXaGovcmVpNFZw?=
 =?utf-8?B?TDlDNjJ3NitVMVVXVXV4WWp3TDltdHEyT0dpNU94bk1lbDA5T2dvR1NOeDlj?=
 =?utf-8?B?TTZwU1p5bVdCa3dwUlVvL1h1V3BtNUFxaVJydzhiclNRZU82Ni95Z1FJeklY?=
 =?utf-8?B?WmR1WmtIb08va2V5MGttdGRNSU1IZ1pTdnYvekZnUW9TWms4dUgzN0J3ckdT?=
 =?utf-8?B?TWxyTm9mSWlTVVBlSVBDOEVmdjZqbjQwMCtENW1NUTNSbFl3MnB4cmlMLzdt?=
 =?utf-8?B?OXF6UG9lS3ZHWnVTTXdqcm9sd3NLdU9nYkE5RGdLdkIwb3JQVThLVWNTZTR4?=
 =?utf-8?B?QkU4dDB3d2VWRys3ZWpsamlwb1FrZGdpSVVvTXg5emVwbEpiM1VqUE5VZVBk?=
 =?utf-8?B?blZuZmRmSWJkNVQ4L2ZvZldEZEN4NFBrbUlBUnk4RitSSHVYWHNCSnkvbVU0?=
 =?utf-8?B?cloxZFVMMWtmcGV1VHNNdjRCVG5WNjJ1dzBINVhxOWdjNGpPMG9pQTdxTjg3?=
 =?utf-8?B?WUppc0xKQjFaSlBYdlIvWEdtZGZoS1lZQUZEUXN3QVF0Z2tXUDh5OUF3a2pK?=
 =?utf-8?B?Q1RNazFVV0JndU5nSXdRS1UrTU9CREtiWWs5ek8yK0ZYQS81Zm5XQzkwcEwr?=
 =?utf-8?B?SjJTNHVXQThqNEM0aXF5am9paUowQkUxcFJYcXZpZ0lBa09namlib1VZWGVG?=
 =?utf-8?B?a0Mvc0JoNXl2WE9CYzI3V2pyU0ZHM1NMZFM4OTlHK1JJN05ONEFDZ09Kd1NU?=
 =?utf-8?B?eThTNHBGbFRDc0VveXZBbVZROHIwUHlNc2xzRmc0cWp0SmwreGQ1THFrUkky?=
 =?utf-8?B?TVc2bjdMTjdzdFNyMXRBTFRKRUpXYXBOZnNKTlJmSzlFVm1ZK2EvUWZwK1U1?=
 =?utf-8?B?N0o4MThIbFM0UDdxVWcrdmtrWVBXWUx2MlBhajRYWkxhQmQrZnpFZmRZaEh5?=
 =?utf-8?B?ak5TcnVWVHpJMDZOR0NnMFlYbEJpdmx5NjNLbTYvc2NMMVNMUEE1UzNWWmta?=
 =?utf-8?B?elN4MXNLTGhBWVNmNTh6OVYvTHo4R2o3SkJmTXRsYVBkVGtpVVhCWTZFRzRF?=
 =?utf-8?Q?F3QmMw0eQb3OrRBL8RY544w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842777f0-2ea4-4e20-2989-08d9be4b96bf
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 15:16:51.2914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6A8bm6wszVrG3nDUxaGxep+oVO3suEbqJBddLCAjW5n//g33H4Oh8ZiGKGI4O6XbwYeFe+yjUCrVq4BFX1+LEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5348
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
Cc: alexander.deucher@amd.com, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Please disregard this, Jerry already has a fix.

On 12/13/21 9:51 AM, Aurabindo Pillai wrote:
> [Why&How]
> Debug option for forcing SST mode when using MST capable receivers is
> guarded under the config option CONFIG_DRM_AMD_DC_DCN. Hence the corresponding
> code exposing it in debugfs must be guarded as well, to prevent compile errors
> for non DCN builds.
> 
> Fixes: ad9601f00 (drm/amd/display: Add Debugfs Entry to Force in SST Sequence)
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 1779c7daaf72..fae3c74a2885 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -3237,6 +3237,7 @@ static int disable_hpd_get(void *data, u64 *val)
>   DEFINE_DEBUGFS_ATTRIBUTE(disable_hpd_ops, disable_hpd_get,
>   			 disable_hpd_set, "%llu\n");
>   
> +#ifdef CONFIG_DRM_AMD_DC_DCN
>   /*
>    * Force sst sequence in mst capable receiver.
>    * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dp_set_mst_en_for_sst
> @@ -3260,6 +3261,7 @@ static int dp_force_sst_get(void *data, u64 *val)
>   }
>   DEFINE_DEBUGFS_ATTRIBUTE(dp_set_mst_en_for_sst_ops, dp_force_sst_get,
>   			 dp_force_sst_set, "%llu\n");
> +#endif
>   
>   /*
>    * Sets the DC visual confirm debug option from the given string.
> @@ -3370,9 +3372,10 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
>   			    adev, &mst_topo_fops);
>   	debugfs_create_file("amdgpu_dm_dtn_log", 0644, root, adev,
>   			    &dtn_log_fops);
> +#ifdef CONFIG_DRM_AMD_DC_DCN
>   	debugfs_create_file("amdgpu_dm_dp_set_mst_en_for_sst", 0644, root, adev,
>   				&dp_set_mst_en_for_sst_ops);
> -
> +#endif
>   	debugfs_create_file_unsafe("amdgpu_dm_visual_confirm", 0644, root, adev,
>   				   &visual_confirm_fops);
>   
> 
