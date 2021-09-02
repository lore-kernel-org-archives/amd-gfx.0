Return-Path: <SRS0=HxPN=NY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0906AC432BE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 15:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78DC610A2
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 15:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C78DC610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 624956E5B9;
	Thu,  2 Sep 2021 15:23:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71BA46E5B9
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Sep 2021 15:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VelFXpMSenLFE8Gvi1UDVAe+rKVlzoeohWUgxNfqqzC4vcWnn3t64TXYiTVuHPBbWsIDljAn9MSty1tSpjq/Ocu4IWeK5+ZaY8/YAI0BqzaWCM/vKCixlu2EGguV5Tp+4OTlTkWfKPSGGsrwx5cmnH57VAD2zgNb4+f3UbbUOeph62sNcMUGa8vKVXjtzcX7MywPoPYm73z+eIQD0fVD6MJT6yK5Lq6dp/j2pfkaGPmVsrbZA+5JarHIZI7Okiozl+HxLw6cpKNB6Polm1Cg61b9UGMCjzJzIVXO6PErBj6S53/oZDvaGKHL8i5ir9J2TqSa1GiTafP84np1POL9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=CD9hL9nQsoDJ5KZjZ59eLXW7A+OBxTG/Z3ici8mmnk4=;
 b=hGNnS1N5h2k+ui+w8OGbOyAsyUcWkNDNZICN/IyT/mtFN1Icg9G8O0So0DCf8jyYdyMqurmSVVatqmc+VpbMxO1BROYGr3EMJskMdvS3FQC9nN14ZXmfK145MpRLdpP5kAN0MfziLYwfsl2VzYwrfG3XvCEnwcZLUfml+V5BwiOWKUHZJin1csxSdUU18gmYVVqx2RqwswLX5lP+Rs34Ob4bMCJefPmtK6Iy8/o8OkKSmhOURFG3b3fd1mRQdl0yk8YYvs4lltSFfhfVTmdmEFojv7mQkMmdNKPcS/FI8cuaEFmqlVKSKGHMo0Vn9zznKojNSLo4K56i4NaoXcBpiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CD9hL9nQsoDJ5KZjZ59eLXW7A+OBxTG/Z3ici8mmnk4=;
 b=JwV1AFyPESOXFu+8bHhEL9iph1/k/agUcNRsreQ5uaSoJhTK4fqgJNKPw7+T3FG53REI6L37dfC57YLaLWrLD4givnJCA2sCqWHrJcPc45lS2xGgrmq8ZCxChhHhbq5thZKfVFVGfs/kVZL11ZhASgi18qNLyVzGRxR+xPydeVI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Thu, 2 Sep
 2021 15:23:22 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b%8]) with mapi id 15.20.4478.021; Thu, 2 Sep 2021
 15:23:22 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: use IS_ERR for debugfs APIs
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20210902114459.3866-1-nirmoy.das@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Message-ID: <29a90b06-6bb5-3a73-3932-8208f8fa6faa@amd.com>
Date: Thu, 2 Sep 2021 20:53:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210902114459.3866-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::21) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
Received: from [192.168.68.104] (106.51.20.251) by
 MA1PR0101CA0035.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Thu, 2 Sep 2021 15:23:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38273f9c-e439-4f91-6da3-08d96e259979
X-MS-TrafficTypeDiagnostic: DM4PR12MB5231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB52311BFC6AA6F30FC28F6371F2CE9@DM4PR12MB5231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBQSUIj/zkDQq7xbXWnLO1Udz3Gp//Sn0NnBxLDkO9WE8TXlWc363Nnf/n9vb/+zditPFCX/IwreFJsbEmgf0M7lTgF5/RMYP+z4MGGLwj3m4qy473xvLVbI+x0TFVJEhlrY4eAnFsmaBF2Sqw5ivfjmHo3pDvX4wmzs4SEp0BV+dmRh9YWuLxMR7Eg0l84MPwDho3OvWPPu20Q2t1RA0yoJZKe/AI5tGH5ZmcRnPkJxuw0yJFLLNSBM7ruNPXGoWrD6IpOYza99Go5SZJ13a5nBRN1CnwsNsynh3dQaMIMJGcz91IBsburNYtvchwHoSKR+DSH1kqKjh25XiMZbhHEG10xFU1aLFx00lyIgZuXmETy8o+zCOfsFqS76MUq0h9vNdt0I6szprqJl2o9p6hFDsDWqUBUNr78B1FF64UxSpLOGBD/BbMPcG9ydQ+uN/yIJeSxx1RL4s1dslLpcRGDdkoOSihVvAzn0Q0wJMQUXAAKrKfA/n43lk6QitVxsyYo+kw4vJGqBToDoqkvi14jdFNSHDKQf/ENVnlKd/bSerssJjuZ3aJsmQs1XNE1Shh+XWROWgSoAsa+TX7TAu7e6B6j9SQcW8RZDvK08Uzp2zdyNDiNZX1T6M3oDmdmRj/DQJTAbocByUFAgtYLpzg8XeM/agxEANgWYY3oQ1pSNJELxd5cCl9BfSCTz7Fzn1jsQk04HR6h4SNzrjLQLy0iZOlfIH2vGqB/DWm7KCqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(86362001)(66946007)(16576012)(83380400001)(31686004)(4326008)(8676002)(6486002)(5660300002)(1006002)(38100700002)(26005)(186003)(55236004)(6666004)(53546011)(2616005)(966005)(36756003)(508600001)(66476007)(31696002)(956004)(66556008)(2906002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW94WXcxTDJNRjFxdEJacDd6c1Y3WjVZdTVESjVxZzRoVk9VSGVuOGkxSURi?=
 =?utf-8?B?bFFrTXoxdHBsbGJlYzgvRXJ4cWtGRXpwRjNDOE1wWFk4Uk10WHBiYUxNU2w1?=
 =?utf-8?B?ME0xR0ZHTjZEWW9xSWZiWDZSM3RZUmpaS0RWU295bSs3WlJOcm9YU3o4cEto?=
 =?utf-8?B?MmZZTTZQVkVGMmFBK0JOdVBXVmYrRUM5MlZ4S2l2NnJnQys0T0RpY2tPS1FW?=
 =?utf-8?B?S09TdGREaFZJY2pVelF2dTlmc2NvaytmeVFvTG45SDcwd3RFL3I4dm5zMlV5?=
 =?utf-8?B?ZWp6Qmp3UXZyOG1yUFVnSjBSTVA2eTUvWUpXSEc5QVVtajZIVVY3R284QkZS?=
 =?utf-8?B?TTVtTXRQaG5tQ3dKOFlRWGZQTHR6eVg4aXlZZDZhMDJGS3RRMjV1cTVvL1Ew?=
 =?utf-8?B?dUw4MFR2VzM0STNsTlhYNjZvTm1KMTBsanpTSXpUakRkeEh4RURNeDEzbFo1?=
 =?utf-8?B?Q2xpVU8vNTZXaVBIcUUvVmZkNGxrajVtZU0wVExJcFhxa2w5TVozZSt5amhn?=
 =?utf-8?B?VWNIbWh4OHZSQzBtVkJhNi9ZT0V0TWlTSEJiV29oMVRnZ1BmZUNXRGVFS0gy?=
 =?utf-8?B?c08yRUduTU1YenNoMzNWUXdDdVllUmlkN0hOZGMxVWtZKzBVSnRwMXA5U3d1?=
 =?utf-8?B?MHFza2JMMXUwUVFzcDlOU2ZkdVpRQldUdWkzTElpZlVvNjRTWldyZTJyRXU5?=
 =?utf-8?B?S1kwOFRLUEEwTDdHWUtpUVlrQzMyeHBWT05NeHh0aS93Z2FIVDBFZW1Ba0hv?=
 =?utf-8?B?R3p3Wm9lYU5zQmNET01KR0l4WG15dnBIUXdhR05MeVRRVXN0T1piZDdGSmpl?=
 =?utf-8?B?Q0FCVmdXNFRoUVA3dnlMUnlVMjR4WmFNOTlSblFqM0s4eTZqWkRHanRoUFFV?=
 =?utf-8?B?OTdIc3dVQWxDenE5bzYyOW1hNVNYUDlNYUVVZG9aeVBBa011MmFGY3J2TDZa?=
 =?utf-8?B?anR0eC84eU9VeXlleld2SjJ6YU94dm9LVzA0eGR5YVVtL3pvd3V2cDYxY05E?=
 =?utf-8?B?TGk2TnNDYnRML3NaR3RHb1ByaktHQVlickNNU1FMMXB3VVBPM29kUXdUa3VD?=
 =?utf-8?B?VVpuWWtXeGgzTmpveWNhbjBFWWdaclR5ZFZXYXdIMkJBMUFrYlZlSDBlRWRX?=
 =?utf-8?B?eG95cCsyZFhiN1pMaFZaK25mUVZHbndTSUtyak43NFZFdkdTbWxmZFFRTUZi?=
 =?utf-8?B?ekRXa1JoQyt5ZGM5RnhuRDNGMXZGOWZqZ3pCbldDdU9ydVFwbUUzaW5JbndW?=
 =?utf-8?B?TDliN0ZMTzZOMEk3TjcxOXlMZUpTcnVxbmdpbUpxWTRxZlJFQW9aMk50RVpP?=
 =?utf-8?B?QUdjcExxVXhMT2xsMnZqTldYKytQSmxoeFB1ZTJCY3EyKzd3MmlpbXBMVHZH?=
 =?utf-8?B?NXdyQTlOdkcybUJ0QWhYOWk3SnlRckJCRmpTeExCbUFzZ05kNEZGdXJQd2tD?=
 =?utf-8?B?eHJCYW1ucjJ0WmVsWDJFeGtuQ3JQR3NXYWM1MzlHS0kySHA3NWkwWmJkTDgz?=
 =?utf-8?B?bitXOTA4ekZiallJQ2tlVVhXeERXdkdUMi92TVUzU2hFY3NPQkpaOFNEMWZp?=
 =?utf-8?B?ZXptMEF4ZTJRZjZVRHdYeVpiY3B3VkE4TlRYWHpNdDhUckZLV2Q3MExYNTlw?=
 =?utf-8?B?emJieGdSM2g2RWg3L29KM3Vwb0VuTFNhM21oYW82NGRheXdlcFp1c20xMGhj?=
 =?utf-8?B?NnBzL09IdWZpOTN5SGJUcGNGMzNscURCRmNoSEUwNmVLZUlWMmdRelFXUGlo?=
 =?utf-8?Q?Ji630hXcEE+cLsbbIRprZdGJzDjUOZ3EtPf4DK4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38273f9c-e439-4f91-6da3-08d96e259979
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 15:23:21.9672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVBgG9Dr+OvIjzkmXKKLIG/oBIUyeOYUsxc8efeJq9sFz8i29DZc8FWX3CNj3PH6qGRx1KLOst495CcfejZN3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
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


On 9/2/2021 5:14 PM, Nirmoy Das wrote:
> debugfs APIs returns encoded error so use
> IS_ERR for checking return value.
> 
> References: https://gitlab.freedesktop.org/drm/amd/-/issues/1686
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 2 +-
>   2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index d256215ab2c7..077f9baf74fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1696,18 +1696,16 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   	struct dentry *ent;
>   	int r, i;
>   
> -
> -
>   	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>   				  &fops_ib_preempt);
> -	if (!ent) {
> +	if (IS_ERR(ent)) {
>   		DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs file\n");
>   		return -EIO;
>   	}
>   
>   	ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, adev,
>   				  &fops_sclk_set);
> -	if (!ent) {
> +	if (IS_ERR(ent)) {
>   		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
>   		return -EIO;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 7b634a1517f9..f40753e1a60d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -428,7 +428,7 @@ int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>   	ent = debugfs_create_file(name,
>   				  S_IFREG | S_IRUGO, root,
>   				  ring, &amdgpu_debugfs_ring_fops);
> -	if (!ent)
> +	if (IS_ERR(ent))
>   		return -ENOMEM;
>   
>   	i_size_write(ent->d_inode, ring->ring_size + 12);
> 

ACK: Shashank Sharma <shashank.sharma@amd.com>

Regards
Shashank
