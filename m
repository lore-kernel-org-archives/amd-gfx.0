Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD18C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 13:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C04A10F5CE;
	Thu,  9 Jul 2026 13:31:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PRM3SvTB";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D33E610F5CE
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 13:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WU5TBo/IngwEWnVbBwqrNkU1z7932bfh+cp0Q5GuDk3l37peT/L2oSrhStS53T97JyuSG8mXATXu0VvXBmY1Ce5XWni/EADQqdM/XHW9BYvt2tdGNZmkcvZktR0PR4JqIUDk0eV1eXC4A1bO4TCrYWIE16Q2+u6YjjAcvf8r2GeJNUw/WQzioMY9ifuqxpvQglK0IYsKu9keakWQ7LrVZH5Iwm3AvkhGwvmNUIyM0rQxDzArfZl/qhQNHrvdCBUf3CU8V3ldrb5nRZBsHzWuFWpA7crJhj4lk7lgie8iTEMOzkHkRRhM6VmRNJxd5CKV/TBtcDtBa9jviTDxI8t8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlA1URMlq8mPQWnSVFlxxG9GX1rMU50i14TWMc8F5DA=;
 b=tJgYzxHxKrz2GvL+kuBiK69DdJ4H5NTc8ACGkMgZsWCkcUECw8Kpe17XAcDwBPNcb6HFxJ/S+PbbIY4VGTmcl/vxOvCmLXNUhNJelCU7kSd7VGDkWIxSTEigV64sCj3Axxr5fOjllXOhOgKdpb4c4kPB7QJBdngIBO8W2Vi9EmjsathIYLVn3Iz1C6wuAN41t1GtvcAyVYGZZ8ET1x2exN+OBNk0ecu9zlrrW5a/mQ659cgdrCkkYcH7IVDfMYlVIdIp0IQxP21wWiH462cqgh4utNwpHCxI4H8+v7wot8BDeJJCpZz6U8RXuPPRGOZ9/I6UehydyFar8HIDH0B1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlA1URMlq8mPQWnSVFlxxG9GX1rMU50i14TWMc8F5DA=;
 b=PRM3SvTBJ+dY2jg2h0rqUq8FayWw8SrXSHzxvQVFVlxSOfJCNGziaEQhNSrw6hiIzC7aBf/U3qVkg3cOf0hHQdBe212KkV4G95c3FfN9PMbN8mI9kp28PGkVtZUJ5Q/tL8+ie1aA4kbYW9151A3ToMNU8SOY63xNU7wPGleDUJs=
Received: from MN2PR01CA0066.prod.exchangelabs.com (2603:10b6:208:23f::35) by
 CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.15; Thu, 9 Jul 2026 13:31:04 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::2b) by MN2PR01CA0066.outlook.office365.com
 (2603:10b6:208:23f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 13:31:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 13:31:02 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 08:31:00 -0500
Received: from [10.254.93.144] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 9 Jul 2026 08:31:00 -0500
Message-ID: <22251404-06fb-499d-8b4e-703d5896286c@amd.com>
Date: Thu, 9 Jul 2026 09:30:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amd/display: Fix DM IRQ teardown races
To: Geoffrey McRae <geoffrey.mcrae@amd.com>, <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <Harry.Wentland@amd.com>
References: <20260709031835.3395558-1-geoffrey.mcrae@amd.com>
 <20260709031835.3395558-2-geoffrey.mcrae@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260709031835.3395558-2-geoffrey.mcrae@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2f5e1f-3be0-47c1-4f3e-08deddbe523f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|42112799006|82310400026|36860700016|1800799024|22082099003|18002099003|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: LrGe72UKs48OV0w8+7LHsII98A3kd+CmWnp/rmte0dwRKvnmkW7LCByqIYEwygPSm81ykWTziM+1vnLIyNMbEbScYACYwTfuf37/ZW3FgR0v4tNdRDJCebfsi0QMkc9kx89aLxRjUejrJWcX8hy52NX9iD2UaSxltcciyoA9bXC/F6IN6dmSHdNggK8jA6p9GBAAaab9xzTR169VXwgxk8+SXXHv2lHkNhzwiFgGZxn+ISru0W9qYBzhQgI3UBX5F41o7gT4NeCkK4i3hPHQ47EtqHQFA18JAy/n9/24tlpQQqtNQcSand3SqZUlePclplUfq2D66SCRtO/rmI2UgDX4kSb8vm0p+19g57iMQRxjXVSC06C7m+l/qCa7WCUfvMsqXAcrKMnSE1hyPnC/05lcYJiAfleKLwFO7amLqr7d2t1UwyN1aYCIWjSM6VyGsnW5z8lUDhF3BJ4QJA6pDgUhYwrgjGnEC3igkrP6N8sppEmWxfSaY/T4E/NGbRh5uoXHWAZxFZONdYtnKtFsQZvZFg3+ftI1+ArTrfmzm24GOWUZC0QFYV43WKw55mAtwV/cDbtPE48EgXDvd52MjsG5aO5mlK3wmIK+/AaiuPL1sRBmlOf1PPNO7kEppbxrU2GBc2TTyAFsst6wGR6Eo1z8Nwum34ByiEBhhZ65TcrFfPSKLouI7cnsYx+mMST4IKHZSha9d68bOQwZklerQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(42112799006)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9OwDRvp19feWCX2yJ7CyDAH3RPc0BwAfRSh7084fHIZu0gDsw0SNVrt4WIcbFbjEyUOGGTkOuisGMSwGfIR0JjcADbkXYwqkSMe1FpBTZMDSDiqBC1LyXlkp/Mp/ExWrfo40ITiNo0hWyXxhgUNsnDbr45hoMtOohJEr+r2bbiKqfhiadf6Zy9MOwSUqPV1gPKYYly8Dl2fya6MmdOMkPixJN/vT9F0PPdS8p2PUkSiwmqSQiyMJiHc55rmMDrwYXdBjwqEjmQv4xcF7iJMLrqGN8qTHaj8ZgR6s5XXE0YElo6PpcyOet9w90ZyZmSQ0dkJYyjJ0c68o6i7vfTFbAIWSrvkCIhWDdXBSXRl1eYUiJgVsUP1min6gBNEgGvKqcel42fT0ZsWUfLXKhaFEo+0aNo49kFl18a9WWAp1ZXJFV58Kpp0K685ePzFAqNZr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:31:02.6122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2f5e1f-3be0-47c1-4f3e-08deddbe523f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279
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



On 2026-07-08 23:18, Geoffrey McRae wrote:
> @@ -678,9 +673,9 @@ static int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
>  				 struct amdgpu_irq_src *source,
>  				 struct amdgpu_iv_entry *entry)
>  {
> + enum dc_irq_source src;
>  
> - enum dc_irq_source src =
> - dc_interrupt_to_irq_source(
> + src = dc_interrupt_to_irq_source(
>  			adev->dm.dc,
>  			entry->src_id,
>  			entry->src_data[0]);

With irq_fini_in_progress removed, this hunk does nothing and can be dropped as well.
With that:

Reviewed-by: Leo Li <sunpeng.li@amd.com

