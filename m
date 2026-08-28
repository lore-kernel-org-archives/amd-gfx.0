Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC819C61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 07:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A6E10F2AE;
	Fri, 28 Aug 2026 07:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b6bFEzuG";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB22F10F2AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 07:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvhRbxo0HOneGyH6VLb49o6EK11YOC9eSLlnb6pJD93YSaI7bOIcw6AUJhZaxjc6tSUFsJvEp8ZHKcXFA/px1kMyszgGdyp0GHZ9n73SkNTQ4Pxj+ZaSCttG81AjpSahhF6PsxPBIVrVwBH3xTLhAlDNQytShaKcFAGKb0j3bg1df53El4yEcMXHSb9VkT/jiRDleDpKcsQPdxvUNjks/BI/PvB8pXewkxBB7KWX4qazNaAi43edrv35ZiiXcb6JCJTbknex9VCeilIrqaEapCe65SrMjAXFfl8SVfgxmpurkn1wptv/WjT/b9rOfzTCDhG48wXDZaIbUfms21QjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AASSDytoxzKMX0QVksfLZ56WV5Qq7SjfOAb/JapNpVg=;
 b=cIKfyTAF8xYpvFWzF9sofogAvhe1B/RqH01K+XyMnZbvcgPMqgV0K9JqE7DR0ouCH2MDWbQZ+WKhVrVI2ZKQ7pdp1UckJNKOxpq6GchiPdyPcpDquDtiwBQXCPnI/L13C7GrkzHNNq+eunQoF+QYldDySVYmVoZftPE+qFzd5ZA7VZ2RI8KTyTZmrbMGDv7t5Sk0Ik/lTOaofSUmO8AVorCttsD1KhLSQKyVx939MEGIgYHkszscIeLNMla8P5LX3t1r2vrlT0CoZSdY57Reo1YlUYMyhvIKLBZKBmtAKXusDMyduccnUdJaVgyX/sc+ikcIbQnTTK0kmQujtoAHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AASSDytoxzKMX0QVksfLZ56WV5Qq7SjfOAb/JapNpVg=;
 b=b6bFEzuGOWvMtu6OxOeHnWqoc4IjgGET+Ci+tmP8i7RjXRmPfxdV3j13PvoOm2THu5R4TxvfbzTGow8WSsnz6qW7Ua2f51bukL2t1nT9mELpp42zVyxTxzLsqgaKjZFB99Vcm/T+9XAdoF2m2QFQIsa4fY7d8BhHIsK10YaoIVI=
Received: from DS1P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:453::8) by
 SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.10; Fri, 28 Aug 2026 07:45:39 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:8:453:cafe::7) by DS1P223CA0003.outlook.office365.com
 (2603:10b6:8:453::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 07:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 07:45:38 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 02:45:33 -0500
From: YuanShang <YuanShang.Mao@amd.com>
To: <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdkfd: mark queues as reset after a full GPU reset
Date: Fri, 28 Aug 2026 15:45:26 +0800
Message-ID: <20260828074526.258062-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260828074145.257673-1-YuanShang.Mao@amd.com>
References: <20260828074145.257673-1-YuanShang.Mao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 04967411-ab36-48ab-7254-08df04d85a67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: G1IyjUtPmLfXe4qdpcKH0CscCgQuNz6JnudgcK+ILx1sUmTSDqr/cJumECcww7av5D0LjDDRkBaFXnkgrXN5ZIbXHHv3IlJ/R92ApwBcRdH5DSJYrYmV3Qlhr+mk40hRZbZesVVPY4cjur92zhAUPBX/diiOtloEeETSoC134axt+jQiBUeZUieoSGlbbDtazdrcgyb2vxoGyayl/xvrm80FXPbU8+EvHOqxzDEa5KhIfSc5Op6tEG2rDTLYB5u5Sf3YPKjxmXqIA7gVvd75IwvqaVD1gEX1WHfpFavv8K9GVKiugHW+ps0TW8JH7QKqFS7O0+2SD5dpH8WqwG+8n/4wAzuTKUPOvsyjaaroxySxCYqidZYUhSJM6O4wG9ZO8qRW1PldtCDN7fiII43xe6dv0xa0EwD/S9+oog8bjS4MMEPJkrRn8TvBzmR7SNPleB0O8tG0BcgKYAYZq7N2Z6RSIXdzvEn+rBnPpi98Qy2dmAJHIGyCYuZofy+u78rasW7pU0+xjc8iyyud2UnPFrOuSMEmIR6cS08IC8YiM9V7CB69nSZuE/gRUjY9/J6jzVaP0AkhcEE9onAeli2PameBbCnrBda+bO7vmLf+7z+LB//MYT+uNb7tURuL3kRi880S/3fh3U28yDEIrpOjT23Kq4wjUWzxMOvsFB3NED2ATuDTGgQBGt2uVf5+7pKI38M/wgWNVrjm1+73ujmqEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MlyBCrVmmNz3u51NsQ75r/2Duj2ENS2oiPAx7JdkMId38ph0yuwx5Uk68nHEpVDr+CjOz5K4kMNOjGei3jY0DxPOQJGBRPGZQaqJDNcRbb8p76+qQ+IoJQbb1vNPQq6YGzIdD2es0lh+y7TjSWgwJGOY33F7pkZ7Gur8c60gdDG/+jBNCHxQzvmmn6e86rEs74EPOFeXTaGFlsvvnByxS5mhLNV4zZkonNgu5Y7E6NxIgvwNU+nADCo6P/lZZsi0aWDLw68MW6ScD0kJ3tr6/f8FOItihjxFEF0wQHJzYuTr1VvDSxtljBy/ieGNq5hm7dVnLz8huhFMoUa0D/BRyiqQnG94pyJfPaPKJ2I20m8Nz+pE+DR+3WMmCdWKm1GcF6FtIP+YEmYmzJJqoCTjCdQMNM6tW5iVzX5HBAEnJWJoNThx4syuQT/Jn+M2mxkQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 07:45:38.5293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04967411-ab36-48ab-7254-08df04d85a67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896
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

Hi Alex,

I agree with your suggestion - v2 drops the enable_mes check and marks
the queues on KIQ as well.

To be clear, KIQ itself does not hit this bug. Its evict loop has no
call that can fail, so the loop always finishes and every queue ends up
with is_active clear. Nothing is left for process teardown to send.
Marking on KIQ is just to keep the state honest: after a reset the
queues are gone on both, and is_reset says that.

v2 is out, please take a look when you have time.

Thanks,
YuanShang
