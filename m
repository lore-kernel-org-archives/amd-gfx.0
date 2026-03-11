Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48AD1125857
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 17:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B3E10E304;
	Wed, 11 Mar 2026 17:56:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dc4ie9aX";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB36D10E304
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 17:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niaxWjkMzVbLX5zF2OmOqX1BSoQjn4dwfjtT+Jt3LwiLg80nQedE1ZImppWYXISzaylx0oEJPw3l06GGsUtfeckj22zOm0rvnA+qIqVfZz+yHo4hSTQOxPJgXSZEHIquxydG2CFfCApJDhH+O1HvPDFIvLvxoOl/3SEjKqsdvB1ThZiI+Iyt5n5m/aXnqpZiJ4Lc5MeaFETCU95PoofogA0UP1p0pucOfj3dDLsQJyi95b9t2vGJ1TuAmdOwVSngOW/mPC5hkYymIuz2vliuc6qBJqaemnAYu99o0LYaagpzAAG7csYWSKb7g5/FrwgcX+bsW6eR4p4E+vEd2Zd17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tl4keAjVnf0mHB86SIH4OJdq40LTF99thPpY5AchPWs=;
 b=xqTluevpZ1b7Tm2//czLKQjMdabsd4P46K14VxTROTypsi2MQnDeNwBbsW//wAtlDhCc24YarGn4sLgNjkZcZa7MdneULvt64wykrQ4v8lXFHxinkG3lkAkjvGhmlLQoF3Y/o+ohHRBnN1gw4kUoeeK36JEoXGsRHV1IeuB6i8QoFTSziRNpI2x6HIbBnpbTAoI9TtFRPjdvBLOsAR3ccPEqoKdofPj6rQ71UdF0IchmeuMdaUFqVh9ZFSwvtb8usmt1WfsV6TnT6RyrWE2ID7MC70EeMwdxsVbq6QIjeaow7MychNu1/pddGsq1EcVmZkJAOQMHxCh/QOSA08xJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=m1k.cloud smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tl4keAjVnf0mHB86SIH4OJdq40LTF99thPpY5AchPWs=;
 b=dc4ie9aX1o76VUAvXVVGhx97yl7dC5Z2Zdt5u+izpYra+XkYIungqt+XLjemKqYB2Yk3tV2av3T3ybSLMwgiuXg2Lvmo06weVkZxdJiwR5R7Tzd1fWI/mv4xzr4RYTJ5gZWrUmkfS8b6GOrtegFEx9IRpF6S/nJz7wdZE8jGksk=
Received: from PH7PR02CA0024.namprd02.prod.outlook.com (2603:10b6:510:33d::10)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 17:56:33 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:510:33d:cafe::22) by PH7PR02CA0024.outlook.office365.com
 (2603:10b6:510:33d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 17:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Wed, 11 Mar 2026 17:56:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 12:56:31 -0500
Received: from [10.254.95.201] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 11 Mar 2026 12:56:30 -0500
Message-ID: <1356e93b-af76-47f3-afc5-29535a9518bb@amd.com>
Date: Wed, 11 Mar 2026 13:56:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Michele Palazzi <sysdadmin@m1k.cloud>
CC: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <siqueira@igalia.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>, Shengyu Qu <wiagn233@outlook.com>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
 <84316e45-f596-49c4-b3e7-cdfc7a19a519@m1k.cloud>
 <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
 <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
 <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
 <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
 <ca869a77-4bdc-47b7-a8f3-788224be48be@amd.com>
 <fdb2d4ad-10e5-43ca-92db-f1dad48b7890@amd.com>
 <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
 <6e1f5a30-82c3-4872-add3-7d46a266c37c@m1k.cloud>
 <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
 <7fdc3c4f-c321-48f5-93f9-17a1a8ded9f8@m1k.cloud>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <7fdc3c4f-c321-48f5-93f9-17a1a8ded9f8@m1k.cloud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 4687de0b-5b51-4367-185f-08de7f97876e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|42112799006|376014|32650700020|82310400026|1800799024|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: J2Qy/2QdvjtoBhHisN8mb5J1HTNfTFhlsRNvJHmHEg+Nx1wgsqZWkVrxYC/kD7Bi68w3J/lY1ll6qnEreC+k8BKKsfiCP6lXj3UsRnqx0JhGs5nSIFozwX/NM4io6aPlDQd9nMPB6ybsv7ciSetl4jXmBJMg+v+kztjUYpYAE04Wei4jFApvNnSzEfa0KkjokA2hMbmqf20HHc8hsvbStP3EIcZPO+sf2lcGzy+0dYvojDNlZda8QZITb6Fkv1oUkatX7ZY6FafeeX6n7ogoIKeNl+dkpb3jjgyfiAlUHKn2Z6cVVRhMZhnk0H6vSyUDN503PXnR7Ri6m4Jt4dpkbH7f1HQ7iD8Ie7SgfqWudsnexLu5AACb9bXWGf4V0wqe0RdGuQavHBBl4kdIo2PjREebNnNqzlmklBJFMJQFJG4wHLfLHdz85RoH/tRtfBcwXdUKdLztTv7FxyT0AbF1WmZicHi67pmVmIwpS2rJADnHngPQf4qzSag1M4R5YTR43/Tt9d21b8uepBZZe8sUBX1HHAFidSAtIx6wKDK69GQ7s0oo44RxRum2cGWm4D9TDnyiSj66FO4WFxcSvgLeCtREJXPTzM5fyRfh1Z7FxWmYa1crioRTx/WFsTRzkaLuiXO/p4CNsYdXSbQuk9GmQ6SF4Xeukp1djwAQfJVWirL0U67sDsOBNQOzHYj4/sxbSp1sxzdFmg7yWpXsReVgJc/iPMJxsxdyTpSpkZDzRU0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(42112799006)(376014)(32650700020)(82310400026)(1800799024)(13003099007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4f/u9zkjk5aI2Vg+dmY65CQYfK6zTVtjJzwmlaYFhWnzR5ajS6bhDr28aNFaI91As++uo+6vvCjunySyUeZ3ELTkbo/YI4ix6jYSRibdmIarTSL4rweCCgUmNx2UGUgARaoOM80ulRcq/AhQ2nsUWmfWjJEppFs0cy3ye4x1U/2EC7Bu2bCmdTjo3QZLuydfLVLtrpqNauPaN2PGCx64PI59awaqu+/ttAC7oFnFIvLezG0xRqKC0eGCcUz08yDQMn47347j2/clrMbrKx7QWs+vXmic8WrC0RcT8NzjNj2nqg6PVadDGeg9ANZwuCzCwKrLkZ9RZLqRRP45WgINTl9DvoYhToJd+Umi8CHHJuxlGEiPwPIzpvlBG37avu8mrl6xLBUbVHgV4BHdj7cn+1XzE0HJ03375ONRZFz3XBrz14nwI/DlwkY12WF2yWqx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:56:32.1418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4687de0b-5b51-4367-185f-08de7f97876e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394
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



On 2026-03-11 06:38, Michele Palazzi wrote:
> Applied your debug diff on clean v6.19, reproduced with bpftrace running (dm_crtc_high_irq and dm_vupdate_high_irq probes added).
> 
> dmesg:
> 
> [drm] *ERROR* [CRTC:283:crtc-0] flip_done timed out
> [flip_done timeout] crtc-0 event 00000000baf6917e status 0
> [flip_done timeout] crtc-1 event 0000000000000000 status 0
> [flip_done timeout] crtc-2 event 0000000000000000 status 0
> [flip_done timeout] crtc-3 event 0000000000000000 status 0
> 
> crtc-0 has a non-NULL event with pflip_status=0 (AMDGPU_FLIP_NONE).
> Note: %p hashes the pointer so can't directly correlate with the bpftrace output.
> 
> bpftrace:
> 
> 8301644  dm_pflip_high_irq [tid=0]
> 8301644  DELIVER event=ffff8b87186d5a80 crtc=0 [tid=0]
> 8301644  WAIT_FLIP EXIT 1ms [tid=36993]
> 8301649  ARM cursor event=ffff8b87186d5480 acrtc=ffff8b84958f7000 [tid=176]
> 8301649  commit_hw_done [tid=176]
> 8301649  WAIT_FLIP ENTER [tid=176]
>            ...
>            10252ms, CRTC 1 continues normally
>            ...
> 8311902  WAIT_FLIP !!!TIMEOUT!!! waited 10252ms [tid=176]
> Between the ARM cursor at 8301649 and the TIMEOUT at 8311902:
> 
> 692 dm_crtc_high_irq fired, all on CRTC 1 (zero DELIVER with crtc=0 in the window)
> 0 DELIVER for event ffff8b87186d5480
> 0 ARM or DELIVER referencing acrtc ffff8b84958f7000 (CRTC 0)
> drm_vblank_disable_and_save continued firing (on CRTC 1)
> no dm_vupdate_high_irq fired at all during the entire trace
> acrtc ffff8b84958f7000 = CRTC 0
> 
> If this is not enough i can retry to have the proper correlation using %px

dm_crtc_high_irq() not firing on CRTC 0 is quite strange. It suggests either
the interrupts were disabled (even though drm_vblank_disable_and_save() was
not called), or the timing generator in HW hanged.

Could you dump the interrupt state registers once the timeout is hit? Using UMR:

# get the GPU instance for your 9070XT, it should be the one with "dcn401" under
# "IP Blocks:"
sudo umr -e

# Dump interrupt state, replacing --instance # with your 9070XT instance:
sudo umr --instance 1 -r '*.*.OTG_GLOBAL_SYNC_STATUS' -O bits

UMR is available on aur, building it is also straightforward:
https://aur.archlinux.org/packages/umr
https://gitlab.freedesktop.org/tomstdenis/umr

----

Another suspicion is that DGPU idle optimizations might hang the TG. If force-
disabling it fixes the issue, then it would support that suspicion:

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2676865f6f943..eb4c5f13943e0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2096,6 +2096,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
        /* Display Core create. */
        adev->dm.dc = dc_create(&init_data);
 
+       adev->dm.dc->debug.disable_idle_power_optimizations = true;
+       adev->dm.dc->debug.force_disable_subvp = true;
+       adev->dm.dc->debug.fams2_config.bits.enable = false;
+
        if (adev->dm.dc) {
                drm_info(adev_to_drm(adev), "Display Core v%s initialized on %s\n", DC_VER,
                         dce_version_to_string(adev->dm.dc->ctx->dce_version));

Thanks,
Leo
