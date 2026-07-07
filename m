Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E72C43602
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 16:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8387F10EE5B;
	Tue,  7 Jul 2026 16:27:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RbGw4x/y";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012054.outbound.protection.outlook.com [52.101.43.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C2BB10EE5B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 16:27:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmI2HzFTsfjpKXo8yB3T+emX+nGr00hnFhK/cd5iuKyFYrWTtJdzmV2ry/OeS+ov9ElozY5XyL9iirq07Nl+GmJi3vIDawcFZ/MuD2E1rYHS2q7grvpXLe3h/fHAayONZmhsmsvaFPsiQ8ZBFc37HOHOSvdBZkaRmq554YCHxK5iF/Y91g0B/I4ws1tARZyt4/86Q6l0XuPGf/C5DVA6xoitrGOdJQShK/EROhzFYKFgfZLN34w01R4QDbzZR/KuQNsDQT5ZyHUhlRGh6QKPNh+BpiGC6woGkglTrX4BLzOqVFJqXsaAugQp/GIFFg4N7QzcHORyHyF69JkimtfvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3RRxXTgeZWGh0KoO2+hlewnNgaFKQXyZWu0/NCflFk=;
 b=zRnTFeDZX5wqhFaU31szzKrBaVQMIGJET9ADhOzrw6jpsFKBDvpOw4EyPWLdErz5ftEzAH1RYNWIvRA+6zxTJzx2uNPFLXjR5Bnqf3fpeDGxYFYQs+PsNzL2MRj/OXVLk8pYs+TGeJthPUm4zsN8rouHc8tX9ltDgWxeTUzid1+ifhUe7Mzv2fMyrPiCuWO0UYUik87QuqebIlYWRCMSNpZr+hQmmBGxRm3DznfDoeWd9YRV24mMKtI76tI4cgx/m7K2qaKD5RrlVV7Dc8ng9TbJYJnskUsli4xPYvXs3133G5gh6tPvL5tuH0Qzt7s6CnhWyuIMFhjKotSarQVKug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3RRxXTgeZWGh0KoO2+hlewnNgaFKQXyZWu0/NCflFk=;
 b=RbGw4x/y7s2Sa5hagDhWITlcOxkvvt4dpc0/1UDaalWfJyrXc3YmzF8rIvGKjKVSwvqlo4PBbYNQhLsE1XCnBg1QUTZ7+zLjU18l+X03Mk+GKkIISfYMDd82mGSlTXGEqLN2YC5kwTxijV/RwZFTGhyM2ONb7Gsz1zL+cmxwIgM=
Received: from SJ0PR03CA0151.namprd03.prod.outlook.com (2603:10b6:a03:338::6)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 16:27:14 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::7b) by SJ0PR03CA0151.outlook.office365.com
 (2603:10b6:a03:338::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Tue, 7
 Jul 2026 16:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 16:27:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 11:27:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 09:27:12 -0700
Received: from [10.254.93.144] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 11:27:11 -0500
Message-ID: <d717d697-17ad-4026-b958-bd20ce41d7ec@amd.com>
Date: Tue, 7 Jul 2026 12:27:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/display: Add amdgpu_display.c documentation
To: Mario Limonciello <mario.limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>
References: <20260701170004.465737-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260701170004.465737-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 4adc7038-100e-4941-c69a-08dedc4499c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|36860700016|376014|1800799024|23010399003|82310400026|6133799003|22082099003|56012099006|18002099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: tPoOJY6hGJLYVynfuNPMiQhHx3LVGExn03188v6Vm1r0rEpJlT16mySGgQ9YhBHLI1++81YLyEaKhzPLn9x/tt9gADX20nFJVRgUFRX1fCYjtyIW2rVJ1DiEzMph29E+X85GR6pVW4HF3qZmY6L50UYqD0R3UX42YpqzWwdnHT/9XZo1RROFuis8ebAjmntp0zPLzVNf2MjBM5LEDg3f3IutNYk8J/M9fdKoUQHyCd/WgydA3s9jqYSm48JU3VXGay2BgnQpb0p/dZZVbry1+bp+AzgIqx8uGc1fey8B8vdfpxbWY5zHdX/KFEnvJDUn4udHv9dIa9hilX8Ve2DSkgSxn2z2OnfkHDa3audc23Gj+5M6hKxV1syHZRdR3QU+UPXOqi1Z+XEhp3sX2oY0B1qDNuhx9mm/CiHpx7qcG4O+Gu1PLpYht+E5A3dNVN2owWSJ5CcewYpl6MhIIpn0NeGUwGiyJM2Xi2F17F2Isy7dFBiU4F780l4eI9kzDuSMPKqhOkSIbS0aubQnBygWK+LPdS7BM1Nc8IZ0PZG82Kj3aWTv95E/S03r+UJCzb+y0xGZqpkvmfpF/TU0qz6XILBG/bkc/RnUPPu6jHg1yIiItdt1qU0nwJkYRhRZxsKiEucslEZuqYJeMiVgtizG7cpz0VGA0y+wmrPujPP7YPOgz51k4mTYzgU7ePASQgRZ+PyxSjRAMVcjw03GrChmDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(42112799006)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(22082099003)(56012099006)(18002099003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eNJObo6gx/Em9+KsgQ/IHwNaCbaT/8oT7YQEdda7lzKjZ0E4cVAzjQn57i4++SnECgVwk7znRcbDTMC+OlLV7pwSY2AtstwF8H+dEAUJX7vYgq0dZz5+WIqpKoI5UeTCsiQurSuo2iycRZjOywp52x3qJUenGEwRKsdF2AHruRy2r04nbva72VNCNxDWoNc/5RlRECj926SOIXeaZezCia9SlYdLMiAgWmzu5gkqQX2LE/CXfdiuiAW0U0zm9T1T+I8n/V3ZNuHUzAfb6tZpnnJUOM7C+ztZ781+pjxFW/3N8GUf0OxaHEHMVRLKmAFtkfOdXzNttzQXKxIiYqN3T4KQzL0mgNJoXimbsZPN4PPfzqXuR4IQqSWlt2AVb93Zs6TeWJ7tsO0EZYWrEzQCTtmRRO/CWEdXbevHunBFSbz1xeUFc1fUcFT8mvXX8L2t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 16:27:12.7870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4adc7038-100e-4941-c69a-08dedc4499c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
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



On 2026-07-01 13:00, Mario Limonciello wrote:
> Add kernel-doc references for amdgpu_display.c to the display manager
> documentation. This pulls in documentation for display core functions
> like the hotplug work handler, and the adaptive backlight modulation
> property.
> 
> The :internal: directive automatically includes all function documentation,
> while the explicit :doc: directive captures the property documentation that
> :internal: doesn't pull in.
> 
> Fixes: 1454642960b0a ("drm/amd: Re-introduce property to control adaptive backlight modulation")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/gpu/amdgpu/display/display-manager.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/gpu/amdgpu/display/display-manager.rst b/Documentation/gpu/amdgpu/display/display-manager.rst
> index b269ff3f7a545..4584a3fa48155 100644
> --- a/Documentation/gpu/amdgpu/display/display-manager.rst
> +++ b/Documentation/gpu/amdgpu/display/display-manager.rst
> @@ -178,3 +178,15 @@ following path:
>  2. On DC interface, :c:type:`struct mpcc_blnd_cfg <mpcc_blnd_cfg>` programs the
>     MPCC blend configuration considering the :c:type:`dc_plane_info
>     <dc_plane_info>` input from DPP.
> +
> +Display Core
> +============
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +   :internal:
> +

Since this only adds the doc for hotplug_work_func(), it would make more sense to 
append under the "Interrupts" section as:

.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
   :functions: amdgpu_display_hotplug_work_func

With that,

Reviewed-by: Leo Li <sunpeng.li@amd.com>

> +Display Properties
> +==================
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +   :doc: property for adaptive backlight modulation

