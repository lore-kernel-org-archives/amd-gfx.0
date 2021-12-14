Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE2DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 04:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7228210EBFB;
	Tue, 14 Dec 2021 04:00:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5296910EBFB
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 04:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpyKmoSUhGPJf2hFY2XcLjPpXTyaWUKbBQGz2szdh4x//0EKJ66Ej5bMnkE3BEG2HX0qHjqC24uoBVOHEqWD/9YYakma6xaHjvWdM5GaD5wpvJZIGlHJd+UsDNXm4FZgFUx0c7b4+YVaweh3tku8r7Ekysv7j7o2ts02zWChlG6OLcktZIhClkXFyln2sw8of0V6URpLUqbzXYfTt1rFSL0xws2MeFWZmBd3d/N2wLURT9nLALGloZnz+yRBzUAFsv2e+ZW7Yo+znH0uYw6E7+ohjoRSgZvECz6Bnb8n/5rbkpVKBWFLYBt80J2u5Z0P2Thy7m57EPMdHQT5P0HVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFoxCvNY7WRhXuZpRAIpIdiobVBR8O2KjT4+7SACPgg=;
 b=MuL+eIsJe4pOHav4Q1/kayO6c5+nv0jLxmRLJ8RsmpjPJBykq1s4473LsMflvlLzIysNSi9SbEjq6AdxgxYqzwQQI/THRKQxfXU88M8FK9WjZmeZBUhQwtOwLDmOaNJuafArPRSFO02SJyWUYCch4Djqbvng8Xxy8SA1syKTKj1msSLZvqTCaKEMS/grrggUNdHB4rqGWPbJ/MbSXx2btoXFClmDG7NnKuLAODjasPV5zekhsgJ5rZvEVhsRxRPxEZL/BKJzUQhYPmfb1mIMgyWVTI9sdXMaBVh4qOZ0FV58YdoWaFRm5oJwNxJCAd4PcZzCCnJ5ceu/c9f7ZnZqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFoxCvNY7WRhXuZpRAIpIdiobVBR8O2KjT4+7SACPgg=;
 b=kzUJYnRfGg2BFKpI6WVH/W2GheIBqrTuTWizdpJ2pIBYq+6y+/Z0veMCG4/Hp5upQ5mGfhrFxu0jtacH8962oc2AMP835rOmFn1wn1NB0+mq+WC6tRe12xjSGpFUSIjg63jYRHvNrv7OKrQ4PeTThWV+FJClSAEUekIoctMzR4o=
Received: from DS7PR03CA0063.namprd03.prod.outlook.com (2603:10b6:5:3bb::8) by
 DM4PR12MB5216.namprd12.prod.outlook.com (2603:10b6:5:398::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.16; Tue, 14 Dec 2021 04:00:25 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::d9) by DS7PR03CA0063.outlook.office365.com
 (2603:10b6:5:3bb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Tue, 14 Dec 2021 04:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Tue, 14 Dec 2021 04:00:25 +0000
Received: from [10.65.96.204] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 13 Dec
 2021 22:00:23 -0600
Subject: Re: [PATCH 2/2] drm/amd/amdgpu: fix gmc bo pin count leak in SRIOV
To: Jingwen Chen <Jingwen.Chen2@amd.com>, <amd-gfx@lists.freedesktop.org>
References: <20211214035252.15798-1-Jingwen.Chen2@amd.com>
 <20211214035252.15798-2-Jingwen.Chen2@amd.com>
From: JingWen Chen <jingwech@amd.com>
Message-ID: <6725bb57-3570-7764-730d-5c766707b54a@amd.com>
Date: Tue, 14 Dec 2021 12:00:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211214035252.15798-2-Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe67cc82-9b7b-4d4a-e897-08d9beb6420d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5216:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB52167D2D76D908C2F41A1CFCB7759@DM4PR12MB5216.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSZ/HY4yUv1EEcfkypCpeniL7drGddhAqUFwhJuDHHaHMpweUqwA6Hb3HYUfTdeGqzrxfEix6blXZgzKLZYz/eg7aAlVvzwky073afOH0Oc+xMK5tIuxg09/QFm1ROJkPCSlUI0xbXZzE90axE2qhUwYqPvEBR2pTUowRxTygcVyS2EvuQANvt6WHFzFVeosKP8D/2Sh+rTUS2iPXmAVrZNKowtTOKckYmFpdMnDwzk3X7Q/heSUPHg55Tdd7alGgWGFxyR+vh6YpH2tmKGfS/9UUJ5GeH5BukUi0x5+nTOAY9yJWtEca0WStUVoBB+H+tn4O7ovnikz/goDFcYNC1LVaVCVMnclADE5yPheNs5jDzR7quHKSiMgSkEjLEohcOmA6rpz6MaNiPqVV90HO4Lj8sNDtwVHGUVZlire4ZgHuOop68xsRIc0kdBQ3r2+IsVYtjiIvQeBgSaqrYSs8+gjRat3JHEjHlN1Ty6X++x2e+AB3SdnW+HJGuffxpEOpRaoy4xlYeL4YjIWGhaVc4QiJK9I1zWoOW4F5bxvjg3rOU1HoabR418hq5Y1iOfNs+49eU5m73HozzfSfjKkXvK6u+lFxhBqftiyupDra1gTbhbYr59jtrYEZRkCRcLaYw1Amxxf92gV8tN7oI/yh5qqmumnc6vP2EfJYDi/AhilR1zkiwdg6Zzx75eCH4F972M1kcdJHBKlmmAj4DWct5SxP7iyJIpdyF5FAkWlPx1vOvWIVOoZeu4jhGfs4dSFBF+lIRklSEd44zahZAtIy7LiMXN056h8Y5bhdF3lIoGuyODGTiFnOgLzl4dEPxpVf08CfM54TkXvyFDetxVOJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(4326008)(81166007)(426003)(356005)(316002)(36860700001)(5660300002)(508600001)(83380400001)(8936002)(16576012)(47076005)(16526019)(36756003)(2906002)(26005)(40460700001)(336012)(8676002)(54906003)(82310400004)(31696002)(110136005)(186003)(70206006)(2616005)(70586007)(31686004)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 04:00:25.0387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe67cc82-9b7b-4d4a-e897-08d9beb6420d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5216
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
Cc: horace.chen@amd.com, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

patch abandoned

On 2021/12/14 上午11:52, Jingwen Chen wrote:
> [Why]
> gmc bo will be pinned during loading amdgpu and reset in SRIOV while
> only unpinned in unload amdgpu
>
> [How]
> add amdgpu_in_reset and sriov judgement for pin bo in gart_enable
>
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 8 +++++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 8 +++++---
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index d696c4754bea..b0f4d1ded977 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -992,9 +992,11 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>  		return -EINVAL;
>  	}
>  
> -	r = amdgpu_gart_table_vram_pin(adev);
> -	if (r)
> -		return r;
> +	if (amdgpu_sriov_vf(adev) && !amdgpu_in_reset(adev)) {
> +		r = amdgpu_gart_table_vram_pin(adev);
> +		if (r)
> +			return r;
> +	}
>  
>  	r = adev->gfxhub.funcs->gart_enable(adev);
>  	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index db2ec84f7237..c1adb212276d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1717,9 +1717,11 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>  		return -EINVAL;
>  	}
>  
> -	r = amdgpu_gart_table_vram_pin(adev);
> -	if (r)
> -		return r;
> +	if (amdgpu_sriov_vf(adev) && !amdgpu_in_reset(adev)) {
> +		r = amdgpu_gart_table_vram_pin(adev);
> +		if (r)
> +			return r;
> +	}
>  
>  	r = adev->gfxhub.funcs->gart_enable(adev);
>  	if (r)
