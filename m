Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20642EDEBE6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2026 19:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E1E10E8AD;
	Tue,  3 Mar 2026 19:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vAyTpVyt";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E901110E8AD
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2026 19:07:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVasTOEH0TcyPxbPWFhwAgolR/1dlEPy1XAJSovUIJ5SL/qC8hmCbeolvtsH1xxnFTvWf3YzvDRbrVxZGvYRvsWv9uaqDtkRKoh5Oqpq+XLGz5BX8cltS5qCVylnVW6qOGyB9GI42QxH4jiMIBFi1PMp/JPSaT6UTkbOj/rRdn6m5R7Of1rvtqVl+0vBTxOtDL+/hjLQaFmqyWqJPVB9ZPFWy6oRO7KZysHDMgezGfp6gUQabK99U0wIui03J+lkAPP405xDb7NVNA7khxFBiCxxgcfyyt4Dqyn6XKcPHiKM2Zgy15i37vjtKa0LFLvqjy2mLUHcTzbLqYr360UPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=viWslwX8wAYQLHozcJISZmJTsEVMupHfl6dvdECswlE=;
 b=I/P9aH0ylBaqd7m4Nt3KTXLRAVuW66MYwA3yrlK6iZJcmkZJwQoiSMm78fx+ECBJ/0n6dIj7VDRULLz9oN1t+NjYHclH3NtkQzItQNCy7TIdsaZG77RSz8OcgnxWeuF0pZZ9zPvoU20KSPkKOdpJ2xyNU+9TxioMyLQ4jxtrMLCfTF8WUOzqEbr1wQ9R2ODcnaYT0kdsTb+LK2Sraioqf3/AuloCMrIJTiSkh/xwI6Mx+4kgt76mk9YmnA2v9J7kHGeEZzdQWkfzrXiF0U9qJzYUTJkcahFJnr2teAIwDT63xUPwHmdpNno2zf4Vm0ycWgCm/QeC2f6fEiB4yefN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=outlook.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=viWslwX8wAYQLHozcJISZmJTsEVMupHfl6dvdECswlE=;
 b=vAyTpVytJhOrLrN5wzK3rO2KaPKz0zrSrHgzjUmlBdF1grvnJXxZU5CQz9IAIwF6sDrWI/lJ00rZ2iMergP6998N6PSh355EDPTKpeJ9E9k2DE4ISIh8Z1QJAWRUh2K600z7Dx1hycQoDPaNkAOgw+0R1A+1Gt6doGUSjwBx+k4=
Received: from PH8PR05CA0016.namprd05.prod.outlook.com (2603:10b6:510:2cc::17)
 by SJ5PPF6375781D1.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::995) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 19:07:23 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::d6) by PH8PR05CA0016.outlook.office365.com
 (2603:10b6:510:2cc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.13 via Frontend Transport; Tue,
 3 Mar 2026 19:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 19:07:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 3 Mar
 2026 13:07:22 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Mar
 2026 13:07:12 -0600
Received: from [10.254.95.35] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Mar 2026 13:07:11 -0600
Message-ID: <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
Date: Tue, 3 Mar 2026 14:07:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: Shengyu Qu <wiagn233@outlook.com>, Michele Palazzi <sysdadmin@m1k.cloud>, 
 <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <siqueira@igalia.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
 <84316e45-f596-49c4-b3e7-cdfc7a19a519@m1k.cloud>
 <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
 <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
 <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|SJ5PPF6375781D1:EE_
X-MS-Office365-Filtering-Correlation-Id: ff044770-d428-4a83-ecbc-08de79581996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|32650700017|36860700013|1800799024|376014|42112799006|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info: vakqfYn3EFN03i+0/XXV4zdXebX3j27t+9QmHxXrYj7kAMD2GVmSM9z8hzLwgEBoJCR3AU5Od5vDPt5WtiKq5K+WwqAT8TzDAfFbA6ecx/J6zcmJj1FZlpdZE1oQK/Ogcdq8g5df77HDv90zFyrY96oVATqGW4lov7ADyrlSIWUXoV7wGCnYtd6Kcoi3rwENrq4EfcHphBYzl3w4IBxqM+gUP2nlC/uSclldzl+hX+apivXyV58yR39kQAu5I1PPKq9EUkgi3YGqwjAxigmx1LxAlCaqVLBtUnpb9E7CtXUJicxDh4gI2Td08JAOs7FxYS1toke+EEv88jim9aw+704ugOqnRRYUZitvjx3CQx8CWfZpnV7RLiy+oEey+7m822roUFUmcwUBnlZBUImrT7IgL7zQoS+l38bTeKCxp7RGJYr3a7e8HR/GaY9MvamGAZN0jCkTyi8//s9BUrkmuWSN4gQKbKNQ0gq88v9RI8b2WgfHjStvzjb9a5HMnXRYh4I1WmxITOAk8neDgmg0UmTkVYTB9MeAJvZF06/trSYc1EDMtmXdhIl53znGc437MYvYxbZ8vcKN0UB4SjiXihXOtMmf05c0RCzadVjVZam1zjmkciK7VUiBk0QsHKAAol/Sa7OlJULr0pOgU9KX7QBs3VLpLGi8HPS+SAoURjnuzaUrN7cJkY9sOQLDCkAaq6zyWc9acWwpL84VDqrqBLemWsWaBTosDHXyzy/yHOQ+TEDQKiD5lgkjdIIOU96cXbpC8yH0xbbfXE6cqBnvH6Bn9O6R8JnZHco35zmWIODVMRh+53mg7zvnsi2X7zE1V5OYW3BWSsBvnqso41UAHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(32650700017)(36860700013)(1800799024)(376014)(42112799006)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ltezWsIbg6vBD5TBiaS5I0CLEBj/tOckv1ABAGTQedNtyawnvvc70uQwo6bjCOUfB/MaF29mTWE/5krbzJQw6TY4KKhRIKbWCFhK8ZyfrE54jZWlB8cqootzP+WO7Lc8DS8aWYdjfYM0oh/nM1qnI2Y1lPXAvF6wTKjH9r1lkPpRnenaFdBcVTrCby+zMs/DCVTAVMw77iOBuzzgMAOUPlZY3A0nCC/JomcYOMsI88LSVpZT9EZwhBm+yTkfu9FME1Ny3LfZS49PkcsyyQA9xNQ+jBtmv4TcCKS9+mlXl+aH8WXJmu2fhH9kFiRWoOtRgrZLbAroJkDXCXMSrhBZrJtJ9S/UmA6o1Sh6CSCSbwryGpLgiDVshhgYggtNcGdAtOuCBHL/KtKixyfm8jrHgumcy0bS6PHfwkLGa0ZtMqFYc20UPX9NijK9hvuDvmMg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 19:07:22.5947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff044770-d428-4a83-ecbc-08de79581996
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6375781D1
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



On 2026-03-03 03:17, Shengyu Qu wrote:
>> Here's a patch that inserts a few trace events.
>> https://pastebin.com/dpLnVSbu
>>
>> Could you try to reproduce the hang again while recording these trace events?
>> Using trace-cmd (with stack trace enabled '-T'):
> 
> I think Michele said that the timeout issue would be masked by drm.debug due to overhead?

I'm hoping that enabling a few tracepoints would have much less overhead than
enabling drm.debug. Depending on which debug flag, there can be a lot of dmesg
output.

If tracepoints ends up masking the race condition, I wonder if there's a way for
bpftrace to probe the lines where the tracepoints are inserted, and print out
the event's pointer address. If so, that's a viable alternative.

- Leo

> 
>>
>>      trace-cmd record -e amdgpu_dm_event_arm -e drm_vblank_dbg* -T
>>      trace-cmd report trace.dat
>>
>> The timeout can be found by searching 'remaining_wait_ms=0'.
>>
>> Regarding the deferred vblank patchset, if the issue is indeed racing writes of
>> amdgpu_crtc->event, then I don't imagine that patchset would help. It's
>> intended to solve a different race.
>>
>> Thanks,
>> Leo
>>
>>
>>>
>>> fixed siqueira@igalia.com cc
>>
> 

