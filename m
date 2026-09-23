Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C9AC98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 19:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26DE910E150;
	Wed, 23 Sep 2026 19:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IJAj8fyg";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010006.outbound.protection.outlook.com
 [40.93.198.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 687EC10E150
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 19:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccWjR7vBUdsH9pOwoJD19wv/BWstE1CwIUxN8HL7cN7rTGk+00iw/QBHEnKXAyZAdAgcE3mJsExFmjijhz75FYIzFfQgq4acvAdGrNnzYsyvba2+0Ie3KKyv93Hc5bzPpkNfy/cfiz2Qnr3K/Cfs/AUxDtBqX0lCcig2X2VeSlaeB9WsIEOZOAdMT4KZwXdk5aam3ozMw0uvbdG/vDOR9AoI5CXa1tlaKAzpWMNKKvRjRX8rjU+K+QRVhJgvU6ACXK+A3mHrqIgLHuOk713yYFAIXomfsXBJRzOb/crO3K8fT1peWAtjkTrdkB3WbOdVgJKQvDM7xZn26Id4Wr+K5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SyzquQQog4GUqfWlX4PTvGucFvwx6quQZCEUHdN9/w=;
 b=FifMqtkSdkbFALqZLWXkWmP/VvPmJLKTfRBNP71GxEe1NTewAgunkkRwTTwVm8Kz7SxF6+3w7iG9pnpnh7MTFyd3XmsawdrAVl8rP09gYczkqAlvwIKdREHGaC1Vai/mtreKqTTikquBcZxivWxvsOiKftsUZVqAgCCjcVZf+YV49S0kyQq/ElUEq0WFmYrvtowFyfXrSGFVRpc8iWi7FHqsvgdxXEd4YFX1YcF0E66GpwrJTltQBQOaMo3UNoQp2Cfp5FmNa/nREyufwdq17aPJnjGDwD4P7vovvbanVW41XeGtCXqWLJhgD9aVZNRbwWHuMAeBGQkLRCmlS2lWRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SyzquQQog4GUqfWlX4PTvGucFvwx6quQZCEUHdN9/w=;
 b=IJAj8fyg8vscJtxKDeZPryBQNm9QLplrvUOM8qChD+OAIydIYjMRt21uUmQMOhpU7dJhc3wEKjv5dwK4l5MNQC+3MTSd74qVYAFb28lWXCFw2musUi27Htc8y8+rg5WKvBEG0WXQvvYLTgdQ1DvYyj6PvSJS/Gzes/+H46GMygk=
Received: from BY5PR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:1d0::17)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 19:49:06 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::38) by BY5PR04CA0007.outlook.office365.com
 (2603:10b6:a03:1d0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 19:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 19:49:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 14:49:02 -0500
Received: from [10.254.92.96] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 14:49:02 -0500
Message-ID: <6f8195c5-9016-45c2-ae2c-5e879ef3f89e@amd.com>
Date: Wed, 23 Sep 2026 15:49:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix dml-wrapper file discovery for
 out-of-tree builds
To: Prike Liang <Prike.Liang@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Harry.Wentland@amd.com>, <Jun.Lei@amd.com>
References: <20260920123555.1843011-1-Prike.Liang@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260920123555.1843011-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c87aa8d-c39e-43d6-9447-08df19abb96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|42112799006|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 9E3w46PXSRjtMhBQSAciPwqoLIh/iITriEz1OJANdxF87MNKi8jW+jwgG+h7oxopXbqoMa19BIrCI+VS66cXi0uuYdu0hV5YB9FUF0MVE+YfqDBhk3l56/4amfLOxL1hoStWUkDEhYrqIQcH7HIIsmiJZ0J/jnELDtUQRyBOhYR/3rlmfvMCpbHop1S6fmpWLgf7P4JAU/dl6+TetiOpvce2gGpSs2qnlrd5A2uZo0E0OsMU7B/DiUNSFdAAY7Vy+zcPe5O5DvbOr4JUD7I5GmRU1PwwirCAlbVV6wlXxMpS+WeSQ1e0HWdUmyTvrssf6pSicMndLsapjxoK8+c9eITbMeO0f2I/T8V8gCiqehRD8UAUU2MhQAU1dUkQeTC2bhk0UDDfVRNmAgNuY4xKVKUXNzuJZ1PtdJNp/jTxLJZKhqMLk4Oor0TfjKjHacIjXybCEPu9h6pJFDo19lojfnA94Sq79O/0ZMJr4LhaLytZDtDZOt7j+qDs8+c+0wEC2nEIukvWvq4Yp4HZAfI2Nz9GE/4qDgEdbUkE1EoXEsotSnIvg9qlmdrfmjsQAbiDOnOrD4dxCi3FZNdGk7/1d2CidSmnM4apVJgZcwTVJGQhqgQTFo/FGwSunS0Cds8u3TpkiicP3YPwgQmGKWp0cieXF2QWZLeWRXeigSuJRFVE0kuYLY/p6svoRYCj/p2Bf2yUXowPw+utcFBoHQ1g+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(42112799006)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ewYQUl7pDJoEnTIwkQKaoeWqnPkagFihqg7ntFkrtZ+HSP7JWDT8f358fZnxeagiQsQ3RmH5WADyeIYnSZwGKYfYPMVcASnfspscKUefeP1NyG4elnqMP86S+XgRnDyUtLlT67ZqNjuZFNQdXVIOMtFTFCvWi56NMMw79SiyDIP2VgCGG/qTQjuUczgx/G1Eig9oDapP2no9N3ovowgvm1qQVeNqdoJdFeM/ZuhaSeI7MV9mbuFDAK6Avhs2pm+P+jKb0CaUMspF96VxxhgkfwPrI8RnFl8xTlhCPQZ321kE1gP0IpK63My9e1wp1nvElPTkpqn1GmTTNfTOIXmihLJTDvxwZKAkSSu5iwCGiCsjAhNr7qet3eAoEQaWiJxBpNj727IDUqs0gBOMdj1SlXH92ZQhOH2B9RLx7td/B0/5gGOCyx+PavG42BgVA85Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:49:05.0116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c87aa8d-c39e-43d6-9447-08df19abb96b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491
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



On 2026-09-20 08:35, Prike Liang wrote:
> Anchor the object search to the DML wrapper top-level Makefile directory.
> This allows source files in subdirectories to be properly discovered and
> compiled with the required FPU CFLAGS, fixing SSE compilation errors.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!

> ---
>  drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile
> index f8a17d622c32..2c84233db00c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile
> @@ -32,8 +32,9 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dml2_wrapper/dml21_wrapper
>  
>  # Add FPU flags to all dml2_wrapper files by default, remove NO_FPU flags.
>  # FPU flags step 1: Find all .c files in dal/dc/dml2_wrapper and it's subfolders
> -DML2_WRAPPER_ABS_PATH := $(FULL_AMD_DISPLAY_PATH)/dc/dml2_wrapper
> -DML2_WRAPPER_C_FILES := $(shell find $(DML2_WRAPPER_ABS_PATH) -name '*.c' -type f)
> +THIS_MAKEFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
> +DML2_WRAPPER_ABS_PATH := $(patsubst %/,%,$(dir $(THIS_MAKEFILE_PATH)))
> +DML2_WRAPPER_C_FILES := $(shell find $(DML2_WRAPPER_ABS_PATH) -name '*.c')
>  
>  # FPU flags step 2: Convert to .o and make paths relative to $(AMDDALPATH)/dc/dml2_wrapper/
>  DML2_WRAPPER_RELATIVE_O_FILES := $(patsubst $(DML2_WRAPPER_ABS_PATH)/%,dc/dml2_wrapper/%,$(patsubst %.c,%.o,$(DML2_WRAPPER_C_FILES)))

