Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CD9FD88D2
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 23:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB74C10E112;
	Tue, 10 Mar 2026 23:50:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qAzRn/yO";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5124810E112
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 23:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gA6J5FL3PqUujVTEJPcNgPH3ztlpW0sq6NTmz34k8WMVHuOcUnYX8tDT0Un4LknG+k8uBrQC5I84ZALCKDD1h4O9xBaha6qOFNNhtVISGd9bkRsbSJpuU35m/I9DgvFY87KNrqCaUFiT9emhsvMZWspZi+pU3eZCZtuDcCfLsXkN/Hy6l1rU9nrITWNOSn9gzAxDoTTLGSLI26saph11JO0N4MIv72ojO/WEz5C/PYb03j1bIrpX2XOH5+se5DWTP5AgmjK/mYsofltXk5M0X50gRpx59IRO+MxApgol+qCfHQkDxDTn4m7MfTny5dHCjDEynpHbZp7QHixzuI2x6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Su8fTFCo/1xCAlmSFfZyVJ6EX8na9sJuHsHw7+kxHg=;
 b=j6uWVbRJ9x1XUKio69i60l9C/li+kE7suafJFD835rM4wiCgD9andXfGHIDOD0UiyXwWc1FbdxeC7ve8YXQOu/aPYLnRECi9QTUwIw8NbtczDtghoB+9dtcbr2MVu0jCJs9jTg31BFcyLxxk7Pv0htgNWezmxy5pTo+cy0yLxhjiU4gec5yRDhf6iIDdYU3BvgQVhzg7qLehsRHnd76blqMLPUk6/NufGgbPJ6CTfNqawlyXG0hSsAa88KOXT8+TaTGSVukz9w4rXQmED+74CgX0gRNzgcehTgdT9VjUlyoes04G7bJlN5BjsfnQS3eURwanB6/uoLxcCTF41de6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=m1k.cloud smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Su8fTFCo/1xCAlmSFfZyVJ6EX8na9sJuHsHw7+kxHg=;
 b=qAzRn/yOuozpXRISmhzsiP0bcHwNZiRqb5XA0Y16ySIskeQgS0sCCkOmBpa23a/hp8MnWwZGsNfgPdLbxhSbjydfWSJeX4dDutZoAZtYbltSI9APhmlrI3Cbgo5Q8awYR7RX0Gw1lk5Worf/8vn4+BHlG2CmXERr4H2hdWjREsk=
Received: from PH1PEPF00013316.namprd07.prod.outlook.com (2603:10b6:518:1::5)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 23:50:11 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH1PEPF00013316.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 23:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 23:50:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 10 Mar
 2026 18:50:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Mar
 2026 18:50:06 -0500
Received: from [10.254.95.179] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 18:50:05 -0500
Message-ID: <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
Date: Tue, 10 Mar 2026 19:50:05 -0400
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
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <6e1f5a30-82c3-4872-add3-7d46a266c37c@m1k.cloud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: sunpeng.li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 70640d0c-2090-4a19-8dbe-08de7effc410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|32650700020|376014|82310400026|42112799006|1800799024|56012099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: H2G7lzgL9tvDRhcQLrrjnAcPaOcm8IJ8w6tc1WaRk3ZDr4itxGs3a9shdzi+fGlPrNHsICbSpoh+vN0dy+F2j7NOuAqjOyVfxSBfCgeVoynpf/tY6cHfHNPlscOn0ftE2t3sO6HAr6YuMa8NIjHtrTaqYw4IEbYzyNpQV68VWOUrA8cj9PrcgI1VTRvZsbtgh3sykiAbBVHvw6miODAQsHzYpNcPcDGN8lFyQzj2kWoWUzwTaeL9f0TuTQQZzbnlFu/Ir7yCKMFQLJNIalUUAGWb6zZXU/UvGZKtiIU/ewFKxForPJ/8KvZFH+0RC9Hsvmby/07fy5RN/+K8HUMvPwcMwvqpA+y46saDRqlwLIX+7DuW5VT0UZ7eoefN887qvmlTBhrPFSCxMF2KoJJtKwxBXrjzGm9gvFh4nqiUDtjafB/HeTMvoXYhYzt2G/eit25OZlO9qDKuZmZQhh/QTvYF2M+eMsGeUPciczOxerhG+rUT31IziJ13a5zYNjwFGlDdimQK5SZRqpoM9+K4SISvRBfwX8QpBcaB2icX0YAk9MGyK/g1LQGjE9SJAkSBP70VMaLh/GvBzzFJoT6M/2iakXE/epKrTWqtTQcZq4KIO8dUmVwNGOMScG0bsMA5bEgPdqKR4UNpj/22uzFeLcPSqWIx2jAdZwOy2WHz02lF+Ti7mGZSvk3MztnBLo2qwlnCKOsQenPS6jUbkvyZcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(32650700020)(376014)(82310400026)(42112799006)(1800799024)(56012099003)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hozykjD0iHQTe8opmN4GDGPpqihq0gAdk0z0/PB56Xrg83iK4eOuCq30Omy+DgVljDT9pmdardqsY01uT4W5p+Z0H4SXM6+fixyQVeIg21Wxl5BNUUfgpUYX/r7L01AJDI/v1nMNdRdx77EAqaPVcq8+3pqScOD8zGm1t8KtuMMujnXr72V4ng08e/1Zwq9XfIJVQJcno+3nEltUI3KvU9mRZHkE9/ml/nKeFoBlg/soViEt04pf82EWhiKTZQmUsX5e1yxOO/K2IjX/k8hL1qKrZCSTdgBzVtSqtOdNx2nVJmQSk9WlteG/aQqPkqe842XKnMkYG/IyWsUWNfCXzKWQAIIbZVVaPIcMWai504OHM+/hVmk85it4cryAga7Snx2At2kz6ZnKN6Ns6jhsmWpSttaPcbo65vvqyinOxseImsDJ0AuhE+9t7PyP8eok
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 23:50:10.3691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70640d0c-2090-4a19-8dbe-08de7effc410
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440
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



On 2026-03-09 12:49, Michele Palazzi wrote:
> On 3/6/26 09:37, Michele Palazzi wrote:
>>
>> Your new patch is an approach i already tried, and in my previous testing i still had flip timeouts, so while i think separating the cursor events makes sense and is correct, the root cause could be different from what i initially assumed and sending the cursor events immediately was masking it by relieving pressure.
> 
> Leo i finally reproduced with a bpftrace that tracks event ARM (flip vs cursor) and DELIVER using kprobe offsets into the inlined prepare_flip_isr.
> 
> The hung commit is a cursor-only update on CRTC 0:
> 
> 31088420  dm_pflip_high_irq [tid=0]
> 31088420  DELIVER event=ffff8b519225c580 crtc=0 [tid=0]
> 31088420  WAIT_FLIP EXIT 2ms [tid=203071]
> 31088421  ARM flip event=ffff8b4f26184c00 acrtc=ffff8b4ed1ddd000 [tid=203071]
> 31088421  commit_hw_done [tid=203071]
> 31088421  WAIT_FLIP ENTER [tid=203071]
> 31088422  dm_pflip_high_irq [tid=0]
> 31088422  DELIVER event=ffff8b4f26184c00 crtc=1 [tid=0]
> 31088422  WAIT_FLIP EXIT 1ms [tid=203071]
> 31088425  ARM cursor event=ffff8b519225ce00 acrtc=ffff8b4ed1dde000 [tid=203071]
> 31088425  commit_hw_done [tid=203071]
> 31088425  WAIT_FLIP ENTER [tid=203071]
> 31088428  ARM flip event=ffff8b4f26184480 acrtc=ffff8b4ed1ddd000 [tid=208580]
> 31088428  commit_hw_done [tid=208580]
> 31088428  WAIT_FLIP ENTER [tid=208580]
> 31088429  dm_pflip_high_irq [tid=0]
> 31088429  DELIVER event=ffff8b4f26184480 crtc=1 [tid=0]
> 31088429  WAIT_FLIP EXIT 1ms [tid=208580]
>            ...
>            10036ms silence for tid=203071
>            no dm_pflip_high_irq, no DELIVER, no drm_vblank_disable_and_save on CRTC 0
>            CRTC 1 continues normally throughout
>            ...
> 31098462  WAIT_FLIP !!!TIMEOUT!!! waited 10036ms [tid=203071]
> acrtc ffff8b4ed1dde000 = CRTC 0 (confirmed from ARM+DELIVER correlation) acrtc ffff8b4ed1ddd000 = CRTC 1
> 
> Event ffff8b519225ce00 was armed as cursor on CRTC 0 and never delivered. No dm_pflip_high_irq fired for CRTC 0 during the entire 10s wait, and vblank was not disabled (no drm_vblank_disable_and_save in that window). CRTC 1 kept flowing normally throughout.

Hi Michele, no dm_pflip_high_irq firing makes sense, since there's no new fb
addresses being programmed on CRTC 0 due to the timeout.

Did you see any dm_crtc_high_irq() or dm_vupdate_high_irq() on crtc0 after the
timeout? An easy way to check would be to enable DRM vblank debug once you hit
the flip_done timeout. The drm_dbg_vbl prints will start outputting to dmesg:

    echo 0x20 > /sys/module/drm/parameters/debug

I'm also curious what the acrtc->event and ->pflip_status end up being when the
timeout is hit. This debug diff should dump that without masking the issue:
https://pastebin.com/u7hGR7L4

Thanks,
Leo


> 
> The complete bpftrace is here https://pastebin.com/Xiju44Cy
> Note that i did this on tag v6.19
> 
> 

