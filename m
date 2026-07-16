Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E7FC44512
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 19:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6937D10E042;
	Thu, 16 Jul 2026 19:43:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pkXA0vG9";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DDB810E042
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 19:43:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=womKgb+quQQhsRNKy7B6ieFd3rDUpoBlz2BLJ9fMMIhf+SDdFY4MpklJaYox93w3mAFsbalfSpy8kHxjlJEWdo5cwBeDvN0ehAlwB9GPOdBju6QryOGnya6eUAbjZIXAq43Ix07Y8/RfdWGhMD5mKc2FPZzP9ryNqBUxeaNNi5qgf8r7e72MwmNfh2Z1Nc2s52G63eQkPUyOyW0odqIhhEzuAAezaAoPFki00JzbWE+RfbUWYoVyr4IJqPlrFXBomkPYwZXqJkdhHf5Gy6JxSDMCjm0Vj7JdI4o/HCRbcqa0FmVWPXfYezh0F4N3HupCXluco46kjEbRHxlJT/5mqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4GiwKDofO0yP209daN0HkPMBbJebfY87j0qAEXmLuw=;
 b=u69G5Yh8Kyy6cjWaOmLEcTmNI7IWsR8r8UTVBIUT7qbDJEXFe689FxZzYY7D8ehu2hf4MEdzR0b2r70ks8yjJ2Vp2ZOXq0yOlPl3+9ONTdajMFDv06kuFgZRylWNU38gE3UgEzfavDx1Y76sjRIcPtdYp3YNh8ID6eU3PkqHl7X4vXKxGACXvCCGWh+qvxXqsoQfrDaCA73MQo2dvprjuQTh150Z0e4bt+jw2ZlF82cF8B2rJPRmcdypYt6GZ/xiKK8nnArBIN0nuGrkS8mlbSNLx0X7EjEhO91k1I4raV5xps/Ii3OHk5S1jkGuyt97cwr/k5VC9WfMmEjP0u3lvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4GiwKDofO0yP209daN0HkPMBbJebfY87j0qAEXmLuw=;
 b=pkXA0vG9XnIDhI1EPN5F4nOO+qPnGJKNzniVJZFrXFDvwxkDB0HHeM8DieFDElo7GabV9eEcKbd7HasWzTr/EN3/yYhJn6aGgyipkFr9ODP5HzX8+LLY5i767Tp4BZ++JwVDlD9Qac+NsawpLnn26a8pPXOp3rhX52qQ4od7ttA=
Received: from SJ0PR05CA0095.namprd05.prod.outlook.com (2603:10b6:a03:334::10)
 by PH7PR12MB8013.namprd12.prod.outlook.com (2603:10b6:510:27c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 19:43:01 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:334:cafe::6e) by SJ0PR05CA0095.outlook.office365.com
 (2603:10b6:a03:334::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5 via Frontend Transport; Thu, 16
 Jul 2026 19:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Thu, 16 Jul 2026 19:43:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 14:43:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 12:42:59 -0700
Received: from [10.4.12.116] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 16 Jul 2026 14:42:59 -0500
Message-ID: <31e840f7-96dc-437e-834b-cb376a691e4a@amd.com>
Date: Thu, 16 Jul 2026 15:42:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Switch order of GC and Display IP blocks
To: Matthew Stewart <Matthew.Stewart2@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>
References: <20260716190844.368565-1-Matthew.Stewart2@amd.com>
 <20260716190844.368565-2-Matthew.Stewart2@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20260716190844.368565-2-Matthew.Stewart2@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|PH7PR12MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8e93c9-b7e4-4a81-916f-08dee37271c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|22082099003|18002099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 5kqZObW4hTLzn37u3dW/t6Fv9Rk0iG3vIDUSSNg2pcGo2QsZpruLFzS7AVAcf99hL9hzX9T2aCD8IyMqgeCKzfXL4+HQHSHdpR3OSFGsyYNSnIlUkv0Gg4lFog75IE3MxqJGss7/DT/PmgpeD2YchDq8Z5kk9yOkn2S7jXbPhHc85aGXmk88ZSxs4nSzW6TaAeoYixOnDiip0iGBErRMyoBGxYPwxdZxDsJl2DNtVD+EI1+AQNXqAkiUDfEN68EBuA+EaejaMJsKZuZlubuoUYjfMka8bHaa7B49CAYDzC3JzRisx4l3foncjiBvjYDE1K+QahtKzAANHR+Tmk7zWPMAnauqaW6TRpf1L0lZNygos9KBOul8a5hbtaqMcW/WB6586pybgiNJ1bODz7Ypad/Ajh5c1wKQh/fD04QMYHnXS9xDYZg21O713EXjfqelv51f3k8ulFP9bNY3nmKe9DtLKgY0E8PO3LePuTd+bAmTxDljvKgzARSL+KvN4DKvw+xhboRKAF/vTnZoMzfZDrvsEZXhT4WhACbLf8RSuoPADsHHfQzYUfaE0NGskgGNvbs//p0Z6rL9GKRzJE8O+SFMhqp0i/SW6XAYP66XULIgexI3/yLWMXJLgYfiApga0O4iLq98KBeANfZ8GuiSCPBKeSzV8WjIyQTypUe8odSZ06k8/WJKV2kuByVoO4ApZULghFMKEf+o3VJDesa15A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t/++/mmkiXZRL9C1VBadWiRjo4T+YnlnXe8iWGM/UqIxiavtrD4RWHOXM9U+O+lMeSYgTKuDyU3stliLsx4exL7oaqMNnnXpJQx3g4PNAa8SG8wVaWo7PAS4b4afZf6GgGjKQwbqm6518pqdDGTdytXOLEqNMBbiCEFWzWGuYRoO3jZsx5ZfNCXJZqm3CBWMDuhA0xma0Q1D/v49SgIpIXTcLjBaGN8z2De5d6ZdMAuqjYFQIkKcc2uiXNgs0E6nfHIJX6teOkK/2P8obXt0mNUsQz3WAcAWYZC7utIbQ0ez4W+HAlTqAoh3P+GRV1BURrjMaEwgHIdegOawlpVFlckU9dFR0sdbatU4RHYNT5rkkSCS/DvDAwQ9XGLm29QNbm3TFAf4p2Qd1Q5Bo+pZxfQcB3C4B2GZn9NMzdMtnoqG08RT2pJvEEa0lp1G1tKd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 19:43:00.6625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8e93c9-b7e4-4a81-916f-08dee37271c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8013
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



On 7/16/26 3:07 PM, Matthew Stewart wrote:
> For DCN42B, GC hardware init should occur before display HW init.
> Otherwise, the GB_ADDR_CONFIG register accessed in
> amdgpu_dm_plane_add_gfx11_modifiers will have a value of 0, causing
> plane modifiers to not be set correctly.
> 
> Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 44e7d2e3e6df..76b6efc8768b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -3657,11 +3657,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>   			return r;
>   	}
>   
> -	r = amdgpu_discovery_set_display_ip_blocks(adev);
> +	r = amdgpu_discovery_set_gc_ip_blocks(adev);
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_discovery_set_gc_ip_blocks(adev);
> +	r = amdgpu_discovery_set_display_ip_blocks(adev);
>   	if (r)
>   		return r;
>   

Series is:

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

