Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72349CD98C6
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 17:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A49510EB27;
	Wed, 10 Jun 2026 17:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q3svnt4s";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE29D10EB14
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 17:04:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/3b9h2oAnDZlPsIFJ88X+LIOW0Yc3aT0iZdIlFsGfikouUlygwsrbZbkwC9maNIqrtDjBqy+BUjZA4GU6ifpVOkZFPK7vKEE7BFKD2yzWcBIoFkCLyc911IjY8m8pUQh/q1jXkDAl2rJEyHC3idt/ruEaFK4A7sGt5FjZjR9BORXEg4s9pZL4EBID5Q4Nm5yEP37kkqYTUfNNAWLEw47u5dthmJqCkUsIgFvHLoocMxsf5DhHsaWL7Bf5FfZ1l25B1WCHvB2yjaEs+MZcFXzqwqjXgI4NMywBDlRr3qtX5yHhi1FUdGb3CMB/I4mKs4byswUOt5D2w6MRTAlAxA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7XRBUOdQa/KnLt0m9vvjdFqYTt/HjrbM7C5X8cIooU=;
 b=NZGgzV6qe+J0OuLHaKZNrPnWUEiitQbcLI/UBBAg94Y2ytmiIHw+BQ4UZj1cr9iSOhx9ug1JCEcFaXSIyvidg8GFTSbuxZjBUOjFbt0c8XNGu9WGlfOdjpRMUN9vZ1BHpz+gLj7pMDqVvaOHx/ZjefBTV7KEjRGmRCii1EJF6zZ1EJmOlX0L2g7AlDJMTkHLFCZTp0ecM/KPFWKzqcvnf98hoayRzyANUMWpGnLKwr7ncYsrlbWkzQQMLLD9taiNdG8vQd3LWnQt3SWuH7TusWd3spCS1oVor6mu887V6cerihbKHmIkyDn2RxZdX0ms5U3vhMzJmpojmM5PL7j2wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7XRBUOdQa/KnLt0m9vvjdFqYTt/HjrbM7C5X8cIooU=;
 b=Q3svnt4s87UnLx5pUsdrVxs+yViZbgr/eVP9MFFw84JYvjQDcBA2MWJVwXAUAhuHyme4Wd2e5gbcb8KtqJJfbdV/Mn9Xj1eies9WHnDVQOSGl6AVYwhsDH/k9GbkYxYKbas6cQEzhSx3ZATjUi4egRqvxIrAZrzTUPJLrlHIAQo=
Received: from MW4PR04CA0114.namprd04.prod.outlook.com (2603:10b6:303:83::29)
 by SJ2PR12MB8719.namprd12.prod.outlook.com (2603:10b6:a03:543::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 17:04:02 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::72) by MW4PR04CA0114.outlook.office365.com
 (2603:10b6:303:83::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 17:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 17:04:02 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 12:04:02 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 12:04:02 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 12:03:59 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Priya Hosur <Priya.Hosur@amd.com>
To: <Lijo.Lazar@amd.com>, <Mario.Limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Kenneth.Feng@amd.com>
CC: <Priya.Hosur@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Pratik.Vishwakarma@amd.com>
Subject: Re: [PATCH 4/4] drm/amd/pm: smu_v14_0_0: add closest-match fallback
 for DPM level marking
In-Reply-To: <20260610120944.124040-5-Priya.Hosur@amd.com>
References: <20260610120944.124040-1-Priya.Hosur@amd.com>
 <20260610120944.124040-5-Priya.Hosur@amd.com>
Date: Wed, 10 Jun 2026 22:33:56 +0530
Message-ID: <bfc104c8-41fb-484e-b022-8c7132599d6c@satlexmb07.amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|SJ2PR12MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: 389ed607-9d82-49f6-19ac-08dec71245c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: +RvSDf+HYLlmpdo/A9+Y6mq1zx18KB/BaiI6ocO4oPuEF6KUy+WlLc8SHyYMMzUACgQ83uFSpj3E+f4OwN8sEy4m7HbaGnDnq8sb+Q7woG0POUyRBmKGj3rnQ4W4zzFffDI+s5ZpP8h7jDMYgvm24Hb8bTiX9/WBxvHwpWOOaQjB+tqwV5GMJUkNYmRT7/ZClhAXDJ9XfNEmcxBjCc8DtNVHMue79q6f6cXkrNiRBtYYp2LNGYuCaOYIlCD6T0fCMJ0otL4YK145YpKk3ulKiNv4NUivE8YHTtrLm3WH3xg7+ctRQqABF4MRp0CNrduQVq3k9nZNQ0lwPJJbIAtrssggR+bMQpgq7XmbcJS7J0TyQmOS1+0O4cnccM2qTdw9SyVySalgm0O+PvThcSLRVSOsJXGCxvAsZr4ij6N90yN3Zpu+yD+VlDaN/wWCfqV/5bf2woq97x0iMqr5zlLPvBmRPSl4XKO4faXZr1hYxkGc8vRoDkc9wXeaELCu5XnnoQuahNr9VXUb06YZIpQERE+qt5XAjUP/cHr2JockGefQDcBKvyBoMxwFEjZyvOiTA5wzw7tQK4xDuWyFAparbiG+siYHCzosPcm9dSLjxKiS4bwv1DrbY3U9n25wIQsPb/YSvoFSBxsBW9+GMiIHhZReAkBSo+rsgP1KVwooD0SJVqAK3j/VCdPyPS7vLMDv1GQ9Y6LjKRrR3vylruwkRo4kb+VHMfh704SlrmZJ8lI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ILMsbricQiDwbSWKqwFCfw820EmcAbIi6Ep8LVXuGq/CwO49iKMC9vtjTYlvDDZbNeOnifgHqPd/6L6ssvTeU4TNTM11Ft37BnOLLJ0KTItf/jkd49qhfdalU5cYovddXMd78YY4TGfwSJibMfJKRsvsYECOhD8Gd+E/cqG1JYBtva9xBCDnm9Gj9RW/2yjd9KEUz14wdkDSk4YRXWLQ3U3Y50iP5XsUBkbB9mrjlzkqbEFAoVFdPZtlzpYuPDczASXbOE4pxQ6ZSPAL66FCaQ1lkgj6V/NSqMzKsGpZk7w6gYgFmTYELsYNnrx7YRoN3Jt5S4X0RhPO7bVumLxNP3JUrdquWy6PElky3967Qej9K7ZjFnSQuJ4vYmMEqFgI1xBmG1gbbRFTEsds++7ofS4mE74Lq8WxfPy5yAuYi1rD8ppX3/vO2vPy+OqrEAmK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 17:04:02.6171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 389ed607-9d82-49f6-19ac-08dec71245c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8719
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

T24gNi8xMC8yNiAwNzoxMiwgTGF6YXIsIExpam8gd3JvdGU6Cj4gV2hhdCBhYm91dCBjbG9zZXN0
X2lkeCA9IGk7IGFuZCBicmVhayBoZXJlPyBZb3UgbWF5IGFsc28gYnJlYWsgdGhlCj4gbG9vcCBp
ZiBuZXdfZGlmZiA+IGNsb3Nlc3RfZGlmZgoKT24gZXhhY3QgbWF0Y2ggSSdsbCBzZXQgY2xvc2Vz
dF9pZHggPSBpLCBicmVhaywgYW5kIHNraXAgdGhlIGZhbGxiYWNrCnBhdGggZW50aXJlbHkuIEZv
ciB0aGUgY2xvc2VzdC1tYXRjaCBzZWFyY2gsIEknbGwgYWRkIGFuIGVhcmx5IGV4aXQKd2hlbiB0
aGUgZGlmZiBzdGFydHMgaW5jcmVhc2luZyAoc2luY2UgRFBNIGxldmVscyBhcmUgbW9ub3Rvbmlj
YWxseQpvcmRlcmVkKS4gV2lsbCBhZGRyZXNzIGluIHYyLgoKVGhhbmtzLApQcml5YSBob3N1cgo=
