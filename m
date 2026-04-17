Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B73F8DFF9
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 18:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1EC610EA81;
	Fri, 17 Apr 2026 18:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W8oqGx1F";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013026.outbound.protection.outlook.com
 [40.93.201.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4056510EA76
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 18:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wyug3fdw0lZRIpGaUVb4Ny11TUC8j8MPvqz8BJ1cuYcwYQ6kWvJxVkpp4ZkvbJhDQz/SK7IXZTXgV18nP3hyIrdAvK7rdUgZnOnF55VzWK1nkPym8CSC8+McmW42fNAqAMWMMm2pldDwhHSEOd77IyqbOuH4LjQZIhkxaUQMbAVxLARiaQYPoRI98iZT5nLzJYksNOwjzrheVku2ams+iYIMgBoUlzVjVy2bitqZnGHpHDe8NMWjMTD4sS1I2jk5hofI+FwKIw6XdhPBC4wnDm3QnWQJi1JGkQyIDFZsBO/agnqMHeqrGtPZUYi7ekvTC3lN08oG/xH1tiYhItRHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmK1vOw4UEKgB77Hnp1Dahxm0lDE9lvrwBjSD0UyoHs=;
 b=nLHynxmRLoC24MatAXi6OK6HPjj8WS/vupmf6m/HG88PHhxXD4FpRuBbKaitqGq9sAoU6szvgL/4jnUkE1ebL5Tg2Cc7kkamBUxIGVEdeP49lkKN88FZeb6vm1qtlAe+LF5WodLKV4LBu0eCMgsAy0uen1B1uNeUEv8bO0J9M42Y2Vm4wJl+FPFRac21ytuWXTI2y4FZwsQw7lOLdgLViWHgHUb9FgoDXo+2Ucv5MRM8VFEIBGENgSmM004daXf4cbx27DhgbjPV/TtZFP9gYvlPZklnmEJM7GzCAypUcoAqXWEAQdCYMmJC7VRg+3PwvedhhxLdK/zCSIjRdHUNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmK1vOw4UEKgB77Hnp1Dahxm0lDE9lvrwBjSD0UyoHs=;
 b=W8oqGx1FJ67rqPNesaw6f8/dX8JCcCzYKphNpoKkY+TwRI+hsowsLcJ8RDHO8dyNkp+QHLraGJACKklLqIN8SmqvFSYg1hicNlDLd8DLknA5FrOtar5y8nourw2GQLNo7RR/DpdTJFt8d+1hOB1a0fv+h8STg4KiZk+Qm43dYBc=
Received: from BL1PR13CA0432.namprd13.prod.outlook.com (2603:10b6:208:2c3::17)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 18:32:50 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::54) by BL1PR13CA0432.outlook.office365.com
 (2603:10b6:208:2c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 18:32:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 18:32:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Apr
 2026 13:32:49 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Apr
 2026 11:32:49 -0700
Received: from [10.254.92.211] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 17 Apr 2026 13:32:49 -0500
Message-ID: <e276ad4a-72d9-401e-a88e-8e8542b6f2bd@amd.com>
Date: Fri, 17 Apr 2026 14:32:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Undo accidental fix revert in
 amdgpu_dm_ism.c
To: Alex Deucher <alexdeucher@gmail.com>
CC: <amd-gfx@lists.freedesktop.org>, <Harry.Wentland@amd.com>,
 <superm1@kernel.org>, <Ray.Wu@amd.com>
References: <20260417175430.47434-1-sunpeng.li@amd.com>
 <CADnq5_M+DfU0_PO7DW-q3hCJzCWDa2kngG5onds_5XJqQO--tA@mail.gmail.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <CADnq5_M+DfU0_PO7DW-q3hCJzCWDa2kngG5onds_5XJqQO--tA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c2a6dc-188a-48d0-a920-08de9cafbace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gsxRoD3dbIB1JAU5vVfnWFWYoXYuRhTRoT2nubLDjjCcacTu6AFfMpmJ6iFL0v3t08+p6yc6d+lAX16iLwNtDwdQCBNOo53CfHPt+JhbMRGfJ3RHzMlCL+NL2CxhsdIuxWAQlVublDyA5vsF+S4AFF7qnDVT6+jR4mFcnB6Gq9nDaclcy1MU4vjRSeKgWUzoib/oBmGi2pDD/jcFaVpSnBG4xOKy94Gp6XCsRnBfxCeoKlVjkN79+xqnpj4MZBiX578eFH/fEsw95dlhUo2LKTMKHw8KCWKmr5A/SSASg1JsjZcRkZfJfrAB59tCNBJfFcuBMjZmZD8fa7tnn3CjNwEfxj0Y2HzALiOmGKFe3EGVKDWUkWg5vJlTuYrU+gUcnyZT1Zee1oRp030+bLyftpn3nZ42QGUmr8nxD0gKJ8B9Z+zLFijNov+A3VBZADcNilUgcCWd0xU2KMIE/kudrNRam9OE0+QBbqgKtDUQaFb944w899Pn9DXmURz8Mg/pUW0qwOMQNJ4S7kQZ4Y/WMZ62/oVb8R77b+84n5QQPwY+3jzH9g2itzx1IsZ2Cl3dc1WYqYjYMNDdhMgiPk8/ceRxiHAT70NMcemYLmDV2p01ouCmTzDJNkFR0WXLJEM3ps5dtShiAPkVCBzFv+UAe5d3eC1TmrOvaLHmpkLfgorcxwI37TkII/qUCccCcZUwKWNzlRDtU1PJcAO+o9KRVrLsrDRxYKS8Ax/xSLKxkWczPSbIaxek3neJl4TrsIajKJfD8bjjXNH/9arS26JdzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tms08w+D2V1JWVo6mzjC9BePmpSPQXgIAwNjsljeFlb+19l+w0bkM5WSu+5nWEyoIlMz3dCMDdM6vhpltkSzPdDRdJaBQgb0wneg0e0Q+SNJ21n2ME2fdSmjaj7k0+t/760XwVbiPCeS4Amks+5fRN6km8DXoVc0L6FfqaPu+S0QeOxnzph2X9hPW4aJilg0pHyuKf3eKHjnFSedtq1i7uLEt7BziZkqoMCsrgmK+Fb0zwc0wncJCsScuB14UCqbWrRJ6egGJD7qm/chPpQ8yVIme2m0zCytEZB8qWcYV8RGLFeMI/wPfN6fzK4btVZXr8xjPXiaegNmeWQuWqnTKNgD2dbQKHfeIBmWnKCSakX69TjA8mIOich0Z6xdZPp/0/w0UBwa9gOYX81FVBemSK+IpZQJPwCt7G0+0M88JaiDDeXZCD79BsqXPjEUj1A2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 18:32:50.0049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c2a6dc-188a-48d0-a920-08de9cafbace
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287
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



On 2026-04-17 14:18, Alex Deucher wrote:
> On Fri, Apr 17, 2026 at 2:14 PM <sunpeng.li@amd.com> wrote:
>>
>> From: Leo Li <sunpeng.li@amd.com>
>>
>> [Why]
>>
>> Pausing DPM power profiles during static screen caused a bunch of
>> audio/performance/clock issues that were addressed in this fix:
>> 1412482b7143 ("Revert "drm/amd/display: pause the workload setting in dm"")
>>
>> This logic in function amdgpu_dm_crtc_vblank_control_worker() was moved
>> to amdgpu_dm_ism.c, but the fix was lost in the process.
> 
> Do you think ISM will fix this so we can re-enable pausing the power profile?
> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

This regression was caught in our testing this week, so I don't think so.

The ISM doesn't differ from the original vblank on/off logic much. Instead of
idle features relying on the drm vblank off timer + a dm-specific worker, we
moved it to a dm-specific delayed worker + hysteresis to prevent idle state
thrashing. 

I guess the question is: what exactly is amdgpu_dpm_pause_power_profile()
doing? Does it enter some low power-state? If so, what are the needed
conditions for entry and exit?

Thanks,
Leo

> 
>>
>> [How]
>>
>> Reapply the fix to amdgpu_dm_ism.c
>>
>> Fixes: 0b572a6bf04a ("drm/amd/display: Add Idle state manager(ISM)")
>> Signed-off-by: Leo Li <sunpeng.li@amd.com>
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 10 ----------
>>  1 file changed, 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
>> index d2f47c69921d4..d03ea3bafd469 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
>> @@ -270,7 +270,6 @@ static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
>>         struct amdgpu_crtc *acrtc = ism_to_amdgpu_crtc(ism);
>>         struct amdgpu_device *adev = drm_to_adev(acrtc->base.dev);
>>         struct amdgpu_display_manager *dm = &adev->dm;
>> -       int r;
>>
>>         trace_amdgpu_dm_ism_commit(dm->active_vblank_irq_count,
>>                                    vblank_enabled,
>> @@ -315,16 +314,7 @@ static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
>>          */
>>         if (!vblank_enabled && dm->active_vblank_irq_count == 0) {
>>                 dc_post_update_surfaces_to_stream(dm->dc);
>> -
>> -               r = amdgpu_dpm_pause_power_profile(adev, true);
>> -               if (r)
>> -                       dev_warn(adev->dev, "failed to set default power profile mode\n");
>> -
>>                 dc_allow_idle_optimizations(dm->dc, true);
>> -
>> -               r = amdgpu_dpm_pause_power_profile(adev, false);
>> -               if (r)
>> -                       dev_warn(adev->dev, "failed to restore the power profile mode\n");
>>         }
>>  }
>>
>> --
>> 2.53.0
>>

