Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942BBC531D0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 22:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025BF10E29A;
	Mon, 27 Jul 2026 22:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XK5nr/po";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011029.outbound.protection.outlook.com
 [40.93.194.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EDD810E29A
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 22:16:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7OWJXVhpMN4yuAT3CY/J8rO3GfMWOVmMqsOW3al1shWZrhhkORkuPVKIm1ekFbhpwD1URgsTe/bDG9Ec9FXy9nwh2aZjMbc1LmKvlvae3Re2c1vNduTDvkhimBUy2hi3XuXw7LQgbrRNMpSecS/rTe7HVlHTEuvZ3D7c9/Ifhfh8OxkssP/Yd+DtddyQmlz2qe4gNOSBKzlVcc0ZgDdufL7y4qMpEok63MMbICnQpjmxFXm2bJAO5II+4hKwTmIKigsfxEeFeM+j7fV5g2t0FoqB1skB4mkhzgxNKftL0Dr6lJwjHoVsM7M/rPHywYVuXIljxHAW+oqQgyavdM/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXgdcd5XLc1zkDTTiFWKD9gz3s6pyIDhY/8JY4I+5Fk=;
 b=OAcZ4SDGeIKdWsm7xMekFb5AtXwn4W22Qu+awX4Mr3TqEHt/dzhq6J/VDo5m4A9uQMoCOCimmRdoFpiimzO7armEqbNFNpUF8RENHGycEoEf+SJuV07IyQ0ABmIXGccMG7LEAVtzbar9usH/GSdqs7LsNZaemWi/OAW4Wj0sXBaPqATI2oFbs+tNX3uWKujWIIBBvUEq1TDqgQnXao8FWYnNT/YNMxNvrc+qw7/A93C3hJtfJptDQR3v6duyKOcBCkWsmrqG7zEPvomp+G5DRf4JdTkXcgJVhlg5lvIbJGqWwP36MNGKJmqy4O4DUiH+daMnESNrNTX2RUlApzYSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXgdcd5XLc1zkDTTiFWKD9gz3s6pyIDhY/8JY4I+5Fk=;
 b=XK5nr/podQAksKyOasXbRuc5H8iS5omD8+IC54bQzpQF/CB+ltfyS/c2vXrPaEesNgGnsIgKqbKsF1L6NVjvBD30QELgAInU8Ab3dHkYL+EjZ1yqlWYBQQpKtcjSNbXE4VNtZfr4YRBVkRCLMTDoDAPiLdYUx/L2CEC08khXHFE=
Received: from PH8PR02CA0021.namprd02.prod.outlook.com (2603:10b6:510:2d0::28)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 22:16:22 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:510:2d0:cafe::1f) by PH8PR02CA0021.outlook.office365.com
 (2603:10b6:510:2d0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 22:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Mon, 27 Jul 2026 22:16:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 17:16:20 -0500
Received: from [10.4.13.76] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 27 Jul 2026 17:16:20 -0500
Message-ID: <1dd00098-63c5-4d5e-a6c6-493a6c79c016@amd.com>
Date: Mon, 27 Jul 2026 18:16:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix DML file discovery for out-of-tree
 builds
To: Prike Liang <Prike.Liang@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <harry.wentland@amd.com>, <jun.lei@amd.com>
References: <20260723054448.177257-1-Prike.Liang@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260723054448.177257-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: 72261048-eb2e-4782-81e6-08deec2cafff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|23010399003|1800799024|82310400026|376014|36860700016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: APbZA1z3ZKgM32HNl1z9KIhtTWjHsbUrlybHKBpn++AWGhYAYzQ8eXsSdc+GUzqHsSZ7VYduieRGwVVFUCtLpR4U4GJBlvJDQHlatxmxyPZI/9/n49lExUON3zyF+fqngEpIEudP3eX5q7HULk0VhgzMa4d5pI7UVyG9FZdgaCgmXP4QVU6evjQQNdpAUr0RSCQtOxEJ39VHg6dkRekPTQNYR+xQAgJzBP8Gv0WDhPBpsM088Xcvy8V0R63EcaJZ2j2b1TkdEIU7uzu2twhakiH3aBwBjUqsJG5fKA9ANVW72pVGvm82lPD9OJOd+QVYS+12K6U1iPJ80me7qUQnOXVCvBVXqJJyhXDR8k7PwT6yoKx5yVPwPQ6Tg0qrl4YXkym/BxR9QvBd5f7SlS1A9sLHGrsz/qREJFhw+fZ8ma/bwb0zCG3HygpmANMwI8OYpO/zDscsGC+GvHeizGOCNvEgtCJ7tDzNdoxrQ8vj9SQhxScE25PGvIUbzN55SQ9B+F05GbAS5ePG2c0bPML4o1y30jxcPhyDK8VuWhhO+lSFapFpLDLVUshcHzpdjhVmj3VQPh1QZhQ0Kt2YcJypX0MJLaJx7rQHxwHUQbToo7yF0rRIozaqxL8Lk2D0GIWFTC78ufPUnP/55e2K4IPmy/ArOQp4aaJqcROgQkuOBRAHqSmG5LgGJ7x/27MHPSTZXCoeyp46JdJEMeTP+QKz+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(42112799006)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zT+XKZeveByEzpucawFR3ojoi1ltn87IOF986tNdGqgWpzMT7AEPmBMJISd9sA1rrpoyojiDMW1a4GcvBCfj6VTPdBTJ3pEgk9m2Gy3y7WBw/gV4ssIexUo/BBd9fRGbEh0D+y3ui5aYuWHExx16H47XavgHhnb618D+K0iaQDUJy7ElKH5QeSV6ZsSE98wAdh1Lwd/XOTteAV9YL0AUeCc7/D4o9+LC9WBNAowlw7dxMpBInFXC3esZJFZwUGNwRgmBcghA9kYfpK3HHTL7r8DoWfkVaT4U2P6zWNLZTtXN9UDFTRWzyFMCqZGUhEBUypGTBTtIQtcvnVrNfGSWfzQczhkP9TLQHU0oKG6LRY354zf8PPFgIRfBT6DUg9adDX78eTZx3N7eJAqBamDIjjhSRRyRnnKjMzlnBjDOMjUP7XHP3gdrtNjfssK/TXQI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 22:16:20.7820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72261048-eb2e-4782-81e6-08deec2cafff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176
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



On 2026-07-23 01:44, Prike Liang wrote:
> By anchoring the search to the DML top-level Makefile directory,
> FPU CFLAGS are now correctly applied to all relevant source files.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dml2_0/Makefile | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
> index 44e00c2b7ac7..e9ce7813b0f5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
> @@ -55,8 +55,11 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_0/dml21/
>  
>  # Add FPU flags to all dml2 files by default, remove NO_FPU flags.
>  # FPU flags step 1: Find all .c files in dal/dc/dml2_0 and it's subfolders
> -DML2_ABS_PATH := $(FULL_AMD_DISPLAY_PATH)/dc/dml2_0
> -DML2_C_FILES := $(shell find $(DML2_ABS_PATH) -name '*.c' -type f)
> +
> +THIS_MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
> +DML2_ABS_PATH := $(patsubst %/,%,$(dir $(THIS_MAKEFILE_PATH)))
> +
> +DML2_C_FILES := $(shell find $(DML2_ABS_PATH) -name '*.c')
>  
>  # FPU flags step 2: Convert to .o and make paths relative to $(AMDDALPATH)/dc/dml2_0/
>  DML2_RELATIVE_O_FILES := $(patsubst $(DML2_ABS_PATH)/%,dc/dml2_0/%,$(patsubst %.c,%.o,$(DML2_C_FILES)))

