Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0437AC531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 18:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B93A10E117;
	Thu, 23 Jul 2026 18:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KoZGMB14";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010068.outbound.protection.outlook.com [52.101.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAF0610E117
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 18:51:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5DFCBFBEtLbOgUnvtnBi+wNhmeHmWMGc7fUhy4mfnfEo4de2roWf8n7MOuP4dT3Qv34BL+/nFB787NCMvLVHZXTPh9l3PMdDk2FMW/caBh9QJqzVSQEiiz7+gH2l/DI5UQ4XL19OFlOtaPON91uMK0mrNDLRZgMRAoj/xo8MpzbLYfL59pYdaT4Rd7N03o6zbW4d2cM9tZ1P3/mGWbLum8RBvnzkExpZ2Bijs2iKkpzJh39/3vS/cE54gGNcabfDwhXtF2QZ12WPNGtJeVbUDJrUbx12dSOLLLygD4IWanObUjTTnApDaZWbVKOWJKQuholv/W9xwbrE+2G7Vq6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqkURWFN4LYIQXaoq2O8STfxmxF9KhIoKqOUBKfR6VA=;
 b=FV/TrYSJJLxnKZE1wvRoOX0qfhqeZ8iqWaNUP6jHRi/9Oxof2/8f02M7UsYaJg6pZOGjvcb2qRrox6b1Url2RxsxbFewty+JwDnFmtKAbAVsvrcMcLwnCECuRI2UH7QiRn3IS/cSSR0LyW8yWf+kQBNQNuHGFJvVyhuVOyTmlGLYMtiPvTjs1hufm8jBf/wNWfjr2+XTj0wGRx9G/1vRbTyICPZBrajxSuGzeAipSR8WkhO534mPzyWWoergemTiHcmniopzcXcpi+fd6TpjH0LexPEngq3C4u+duoCDsVN4hVpUlOjbybrZsR5wloIuicqogUg/3H1qxCfa0VkG0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqkURWFN4LYIQXaoq2O8STfxmxF9KhIoKqOUBKfR6VA=;
 b=KoZGMB140I9ijdYBFZvH5sACQPKWYPTAhq14NmrOHslTSBKOueB5zHZKXZ3At2lAR48HE+HkzzhNTvaBKva4yx93nbOkHxdSHNVsftkIAhVXNvoqPcFcCGVlRx44VryRJ7RTqdrm0iputrrkwedA4k9YMm+yasVky9xFZv1W55E=
Received: from SJ0PR03CA0299.namprd03.prod.outlook.com (2603:10b6:a03:39e::34)
 by DSVPR12MB999307.namprd12.prod.outlook.com (2603:10b6:8:41a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 18:51:00 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::c) by SJ0PR03CA0299.outlook.office365.com
 (2603:10b6:a03:39e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 18:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 18:50:59 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 13:50:59 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tvrtko.Ursulin@igalia.com>
Subject: drm/amdgpu: Patches for CRIU checkpoint and restore of userqueues
Date: Thu, 23 Jul 2026 14:50:43 -0400
Message-ID: <20260723185046.1239011-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|DSVPR12MB999307:EE_
X-MS-Office365-Filtering-Correlation-Id: cd06ad1e-d3ed-4399-b150-08dee8eb56ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|13003099007|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: MWhxcR+vm697nGm3JfhvpsoKxCVs1Jro4znplJ6VaO3xcYDGzriyv27XOaqIoRuxpTpoJggNaaJGBp1hsAikma32Zo7ULgB1ltkcthbYYpgk5HASHW+NbIpvQ26gqzHzR/shlMqa+ygVhuXz2fmXUliiXLC8Qlz7oTH64n2znCsmYDrBhGqFvgOG+f22i9FQqult2L2ICpJIqqEbYEbWOiezUIbzN52Usx/Ih/luWI/znrMe8p04YK7TzCr85OveEzgeKR/3GrNH1pwkSMA6fcqdY3zm8ktPTeVvuaIJjNCQI76VY0vwhi1IzY6AoootTBjzopvliCFOF//ihyV5hGJwyuORFw0bDYulR4uXMwTN0079QAXWT7L31CPWE/d3Qknpw3Sss2dVS9sdNJD4ICIKHE/5E9aoAfEOcUexy1NZZ9iRj52wYW3xdw8mqneVv8+2Cd47U5FMl5Y+2CQujl3aki7r6ZT5bsQopg756uMQFC7VIhvWgHYUzoOa5H8sjO+D5jSf4YdvygbnyJjIPuyEQr+Rspk1oh3O/sUqtxDZAxr4PK/bDoQOuJNcaCLHT1QjBYPT/YXs2xzX1MCgZb4Wo/LdXCHShlODwzFPIfxqhyNVT4MnrLnWa+uqx4IORi0A9JQ53IDcqHBD7ppgPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(13003099007)(10067099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ouUHN/7voinM48ic4SjhRAIixq9PKiAS7SW2I6b/fIMjpuJdpHf+Wfz7bs+gAamdXqwDbo07u1ueXi4duT7WHuvtAOzl5wJmHoj9jS+zeWp0tLgn3LF8CTw3aqRg57BZk2slLXqY99yIVOtUSME5Xai7QkNqig0yy++UoVOiKUT7r+gUQgkGnxqi6DwjluNfwFAep+/+ck7V1L1u8tW9Z84bHqEzWOhEJQLeYDobVm/26IOyFqhPvWVDRYYq8xvktpzKPLCyCe5OWwqgAW7ym98IaecbHOrIscOf2tQfCstsnv2tCvsm1wMq6PcKVHlqwPEmI0H59QrYgxRSuVQNcXck2UuzEQtxsmTAgdwy0CaMqI7fBx3cUnukp2Z4H/zLgBNr9oxuUka8FKkLRG8ELICoTPsrADt3NFOhAwmd9hN5KPshsgFuCBBKzJTWNpVA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 18:50:59.9918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd06ad1e-d3ed-4399-b150-08dee8eb56ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999307
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

This patch series adds two USERQ ioctl options: LIST and CHANGE_ID,
which are needed for CRIU to work with amdgpu userqueues.

CRIU patch: https://github.com/fdavid-amd/criu/tree/amdgpu-userq
IGT patch: https://gitlab.freedesktop.org/fdavid-amd/igt-gpu-tools/-/tree/amdgpu_userq


