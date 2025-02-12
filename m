Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6C0C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 14:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6916810E046;
	Wed, 12 Feb 2025 14:45:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MUNRgSbT";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3184310E046
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 14:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jA/Fmm35gyE2H+FTfdXve41fY12k1iUQUR3izW9HzFbUCZUL0eFsyQCG9WB6dds/dgQTO3u4aCuuDTURG5qsf0BWtynL+vhwVF+b2z8xjQBh68sGOInLP6FwsKa45tWYYkxzEdnTPui0/oYZMGCAnn78hVuYEDUSUBabFPm5I6eR8UHuuNn/XTTe0jQiMQ0I5fsLnDEKou9u+pUeXoXuwdImGFsRjyPObQP1u9dnEDJ2XInHueuk7EuCYSvVA8uhTPqkfSY0jVBFtXnGu4HAGiMpZLeWHXwJzNlQqjfhWE7YUzHPbDU+/R3LQ2/MsIhf/jG0gvU/dla8W3ImlcN6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNGD9CqdG2XEcViBN7TTriGIfcjaf6cMHcO4zafSVUk=;
 b=EUogBkzN1IqdrckCn6N8D6WdL3mKd+qFc9LmoqlOXlui5SnmSv+2b1hLOW/PclDnxMkiE3BvJ6Yjcne8n7cyWKVBrWU1rxot5jpowBQyl3+mp0005Z6n54UiAy/R0Y30W3+qOLINQes6vTEba5U7Um6YkpqzVA6spfwsy6ZW1ZtdeHxRMZvL0Bo74FefwmocYanKWoV8IdfV8DQJXMxjNnNqVURZdkMiGxxAWBYeIgDioBzug/50wn5hwGnNBK7IB4X/tF4TUhwfFXtOJW9A0IxISIFd4WJfm91znhgjZutmSIeIH4nQEb0xCgW56kjiDNZ0ndZXpbjtPyma01bW1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNGD9CqdG2XEcViBN7TTriGIfcjaf6cMHcO4zafSVUk=;
 b=MUNRgSbTE/khrUVi+qLRURfm/+A1Sb4nJ965lhlverf8I1aQImrRm77DLb+NkHGZyqxRa9UQ4e1bNt6YEOOw02uLVZ1AXdxxGlp9EzQ8lb8h20+mNK9+Di9dJLarGmsihhCceC8bDhnBl1pqw6DUE1iPB/omUwJPqET2WE5Qxw0=
Received: from SJ0PR13CA0191.namprd13.prod.outlook.com (2603:10b6:a03:2c3::16)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 14:45:12 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::af) by SJ0PR13CA0191.outlook.office365.com
 (2603:10b6:a03:2c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.11 via Frontend Transport; Wed,
 12 Feb 2025 14:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 14:45:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 08:45:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] MAINTAINERS: update amdgpu maintainers list
Date: Wed, 12 Feb 2025 09:44:53 -0500
Message-ID: <20250212144454.2438143-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 06674d45-dfc8-4aba-7eb7-08dd4b73da6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2xXQ1dSb1N0cHViQ1lHMnFsOUIzb0R3dDBLWmZLZ0hrN3IxRVVJa1AzSVND?=
 =?utf-8?B?SlBnWjJNdytQU3JCaEkyZEtGNHNCN20xMWZzSHBMSy9YOTFGc0laZ1VUU3Uy?=
 =?utf-8?B?RUhjd0p6M29KYVhYN2txNDRmeTFyZ1NLV1NhRnlNTTZvWTV5ZE5WWU1pdHR4?=
 =?utf-8?B?LzdlNld1TFVNNUw0VWdxM1kzK3lNalVXMHpYWWFzWjh3VkQrTVF0SXNDQkZy?=
 =?utf-8?B?ejVndjZTT1FFS0dJMEpjM2NqeWtRU3hTa1h0WEMwSHl5d3pUcFFjT2xCWHZv?=
 =?utf-8?B?N3pWUlJnYWF1clJDdHlFV1BtbkxTeFpZc3NQMlB2MXhQMlBlVjFxWDJEOTlM?=
 =?utf-8?B?T0NyNDlqcndneE5kcVV0NU83YkM4aWxuRm1mQWlXcmVrYlgvbEJQTkoyWEow?=
 =?utf-8?B?OHJTSWVFZXdkREMxZGlIQmFiQTI4NTBsREp6dHBPTklFSFNnTVk5SUF4MGFO?=
 =?utf-8?B?ZGQ0QTA3RjU2OEVHSHBwbEpKTk5Sa3dCK3RDeGVlcUNpcERwU0NDbFlMdThG?=
 =?utf-8?B?NGkySHlIbjRyR01FVityMHVoRENjQUFFUzJYdFhOT3IramFSL25TQzdjZ2ZV?=
 =?utf-8?B?eERGSzRtWXE0N29UOXhzS1VCM3pZT2tXREZoUjJIT1pkZjNzdTh2VHFlSlpZ?=
 =?utf-8?B?OFNHbjJWUFhVVHYrL01UcHFLMHNhWmRsK1FhWVMraEpnMDlzS3RHci8rRlky?=
 =?utf-8?B?ZkRsL09GY0preEUxMlFiZzdiODY3YUZJNzk2ZGxpT2pUQ1pTNFBBeUNXem1P?=
 =?utf-8?B?bDJndk5QNTlPMTEyN1A1bWQyaVE4dVBtVTZ2WmZuSU9UREVldk84UEpkdlZj?=
 =?utf-8?B?ZTNreWFIRVY1SnFuYmIxNTE1RFlvekRpZWNuQmQyL3FqVmkxdzQ0N1RBWGlq?=
 =?utf-8?B?VS9vc2Urd0lTZTVYaTUyaHhYTmZqcE9HdkduSitZK0hPcTFGeUZ1T240aGFS?=
 =?utf-8?B?ZVg1RGhDRmxYTXYzVXVMc3Z6eVV5eE9wMUZhNXlVL3h3WUN5aDNXM2lvLzgw?=
 =?utf-8?B?ZDc0elhUVjhyVytNYjlaN1BaVUwweHBzRkFZOFJQcnVBNTNZSmErdC9sOUNL?=
 =?utf-8?B?bGVVSjRSbVpRbTg4Z0FKVkZhdWlyZ2MzUzFKcHdpU2VpVy9WcllMTGNhdUtU?=
 =?utf-8?B?TDRkYkFzYVVqS2NvWWw2T25vZlJhUmNpZTM1VE9qelVqcVBzSnowL01LMnIw?=
 =?utf-8?B?emdGUjIrY0FkOWE2cWFBQnhLQ1dpNVI1YkNhRHN5MVFndEpReVhJZ2FHU3Bx?=
 =?utf-8?B?OFhWQnlYVk1BTUVhRzBrdTNYeXVoZXBDZWVVdzh6ZVB2NjVrMUdmdTdpVUNi?=
 =?utf-8?B?aTNhREVIK2RoL0gvOU1RMTlJUytHTnNMV0tsNEZ6MFpvN2d1dnZBUkhjYm4x?=
 =?utf-8?B?TStQY2g1Q25kZHhuYXc1RUxPNWtya0pnRm94Q2VSUE9RK3lrM2ROUFVuSDlj?=
 =?utf-8?B?ODZHMFZTWXhKVk5ybmI0WE5ZVU1FdW96Z0xFRWZyditoZmJQL1JCSU5iOUQw?=
 =?utf-8?B?WnE3Q1UzaDBZNzEydVlacjk2R1BBK0gzaGhWbE4vTHNMdmthVUZZU3YvRVFz?=
 =?utf-8?B?bGFtdEt0SkpCV3FZTXRMeCtoNExZQm9kdVJlNmFkZDdDZzVXTTJWK2NjclpG?=
 =?utf-8?B?UVZSano3SFp2RnBZaUU4TndUQXhVVGtidWRndzl1S09vdlpBTjRPMEFRcUZO?=
 =?utf-8?B?MWM1UytOMkhmZmpWa0lYVnNEd2IvQlBDZFJDY1ZtYTU0b0Jjc01ZVmFxWGsx?=
 =?utf-8?B?b1AxVjIxU2xqVXgxZWFmZEpOZzZ5VXJHS0NBWTduQ2RKSmYrd3o2TjJqUzdj?=
 =?utf-8?B?dEZna2toNkFHaStPbytyUGlPemtrNit2dGFxMW5DS2srSkVMeXBZcDREZXdM?=
 =?utf-8?B?Zmh3endSZnJEQXFjcGN4V1RlNy9ydGZKUm1oSjRJbVVXS25JTkJ5ZzRvT3RJ?=
 =?utf-8?Q?ksqY/Csb1Jg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:45:11.2494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06674d45-dfc8-4aba-7eb7-08dd4b73da6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388
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

Xinhui's email is no longer valid.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8b35ca294a02..d39b272a6a751 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19213,7 +19213,6 @@ F:	drivers/net/wireless/quantenna
 RADEON and AMDGPU DRM DRIVERS
 M:	Alex Deucher <alexander.deucher@amd.com>
 M:	Christian König <christian.koenig@amd.com>
-M:	Xinhui Pan <Xinhui.Pan@amd.com>
 L:	amd-gfx@lists.freedesktop.org
 S:	Supported
 B:	https://gitlab.freedesktop.org/drm/amd/-/issues
-- 
2.48.1

