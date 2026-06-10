Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21937CD98CC
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 17:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD43510EB24;
	Wed, 10 Jun 2026 17:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hM0zP5L8";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D68C10EB20
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 17:04:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJTJOYBWQXXmqUyOVy+hFULanJcCDcGE8peg4iCv5AqfkGP/SNS/7SfQKFYD1aPtsZgtCfJSZ5PjyRzSVDSpGWBtIHvP5n/zOm3lQpwEShUUP3rWhNPSwqA0U/EXOItCRRUlOHvJzdAvAdde+Jyw6g5e+veKdI/sA9xGZGbnXsccNjU8suxzdipiIZ5Q0rU88LGIwrPUMvqSEMtreFifUkG4wwmX/p+qyMUSCzBNTUqP56ZlFKjE/TCrOcRBBK3muKJM9y/6hyDNZoI92V109DyzYGVbK4tgRZPEde15ji5Yyx/t7qVZarsKJzK2ZG1Q4UbLal9suY+6VTGOcQ+UPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tIep61tGwv/iGIEwPghHdutFagtasmZh0/DhUhQ3+0=;
 b=R2Ur8qRRYgBuQOn3mInCWfmKb+5FApraP8+e9JcsnD90jrCNgEbJ33MXmgHdHb8VtAoJ1ZNJJ2BV9hnl7Q7HP/gpiKkEJDhXokoV6MHPbEF++/oC27N0ehzH8mQbSXvvRVdTeesxP7F7D2R7M1yDcTP+jJinjKSPurB1mXCI443aV2oCL5x9GU3xu8kBCJeff2EZ5ttaIJmGcAy+ljmngFCGH6TJlY94+RJsAfeXfxc5zmoyNpR8UOHUIi5ovKdCC3XliKTD7QdEQ3/H8a16xsIcRak15m5DAQppFbU2NimHfX36wWNSNrTmAvgM50ksqxDGiFEeS1cNszLMODauSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tIep61tGwv/iGIEwPghHdutFagtasmZh0/DhUhQ3+0=;
 b=hM0zP5L8hdl7rBtkdfM51eY2oWeUYEiVIn98BznYc1TGEclKcu7QLN+eRLeWhyAPPrRnA8wQIsOVuRr0GVpBY89EHEEht/P5jroBXvjakAY3Up6s4srtaT5/rqKSbH6keapGxPjvnLMjTP2AakVlnSXwpvd9w5kXR5As8vstTZg=
Received: from MW4PR04CA0104.namprd04.prod.outlook.com (2603:10b6:303:83::19)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 17:04:00 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::5f) by MW4PR04CA0104.outlook.office365.com
 (2603:10b6:303:83::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 17:04:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 17:04:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 12:03:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 12:03:59 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 12:03:57 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Priya Hosur <Priya.Hosur@amd.com>
To: <Lijo.Lazar@amd.com>, <Mario.Limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Kenneth.Feng@amd.com>
CC: <Priya.Hosur@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Pratik.Vishwakarma@amd.com>
Subject: Re: [PATCH 1/4] drm/amd/pm: smu_v14_0_0: add DCLK and VCLK1/DCLK1
 metric handlers
In-Reply-To: <20260610120944.124040-2-Priya.Hosur@amd.com>
References: <20260610120944.124040-1-Priya.Hosur@amd.com>
 <20260610120944.124040-2-Priya.Hosur@amd.com>
Date: Wed, 10 Jun 2026 22:33:56 +0530
Message-ID: <008079be-50a9-44c5-a5a7-aeaac2047957@satlexmb07.amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: ec990b5c-81e6-4a78-5a32-08dec7124442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: h0KtHvYaWkMbjIzKr1LLk5jo4EeWDZjEvblwDh61ccAzMMbsP0yz6mWrfGAn8P22u/DXXPSp0DrniDBXfWgk5+9tNpWEkJQtkGcm5QWR2xNCTKXCHV2LdVdPUdtwjmd/N/y/iNIv5KAxnP0QdpxHuQ/bpiNh7RkODAEynyY9PZAsAqxWDNAnaG/J2f9zhdiUDI+MghieTgOws87ClMJKy8b2YfreIKS71FErBGchlipKrljScseqi/75/zqcNOAi5lSX7MysxQxUh2+1NyQOwgJ+PJ2qsFXYE4/Rj8AexT5UKNlnxT6BHDPm9t1Vg+OYi8T5UJKQEdDxX/3szoNyYnqvCRhbta3/tjAHRo4aU51a99BmPuU2Yp5Far9ok3QQkdnV5tXhRTwvJZnQrozuGg6zWfwFFfkoZpEfS2iMHNSKhfQ4nU9PVqtd5nkPA1/GD1Jq658NjWY9K87YAF6eZCks+UG+7cbCieFBU0EraKUwy+AlLelYOyyL47nkpPY7sfSwdsDkupoPJzEgdFbxGT9y8uTX86vmFb/oiJX+cKk7B9CKnOcvFOPQlHg/Eq8FBpGKwRoBbWzcVY2gK49+2o5xrqYGrYSP4vj1V0wecqzUR3EVDKIGqMSLbDw3BlheyhsCK3RIQO9gmrz7jDMHC1pV+u4a8gefMBz57nRUmS4XcaQi0Dnq3GIVCJmueSHyoBlnTR8AU5XZLYnYqZoE8ZPYd1yXiNIOHvgTAV3wCuc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8AneKYJrmJVIxwW4N6QiijbVPK44cbyllOl8a5GR0ZVAuH46ZFVoBe1Yw5o5Vpu+nQoLw/1wCoJ3MzjYDE4DHxPFGXeRO7RV+syE8kncE7zs1GwP/liPEVCo7zuds4LSOxJ8e6L1Ic5KHg5Q96MM9L3O2iMhXmUE5ZMuS7p5JeAHqrioc8hS3yWnEAOvuRb1LAKL2qntk7RNJQ2n/IAr840Rbs6OhHtYP4RODkeIgky2yLG3irRAk2zJIgw0hFn9ujcrk18dOSSuv4W0wP1CnI1S6S+2ei3F58eW9rS9xAKSvWsyhhUl5I8RAIAQzyeX0il8v1uXusNHRc5sEpNF8VATgqE9P01XpXSQ2GVJ7eQivLPxo+ydh68DQ51glXU2scYKHCA0CQau0Gd+vzc6S0Cm96NmABfIfsQMHmt/DnUTw34NXeB06xvzfyS8TzFy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 17:04:00.0636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec990b5c-81e6-4a78-5a32-08dec7124442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332
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

T24gNi8xMC8yNiAwODoyOSwgTGF6YXIsIExpam8gd3JvdGU6Cj4gVGhlc2UgYXJlIGNsb2NrcyBm
b3IgdGhlIHNlY29uZCBWQ04gaW5zdGFuY2UuIElmIGFkZGluZyB0aGVtIHRvIEZXCj4gbWV0cmlj
cyBpcyBub3QgYW4gb3B0aW9uLCB0aGVuIHJlcG9ydGluZyB0aGUgdmFsdWUgYXMgVUlOVF9NQVgg
aXMKPiBiZXR0ZXIgYXMgdGhhdCBpbmRpY2F0ZXMgTi9BIChub3QgYXBwbGljYWJsZS9hdmFpbGFi
bGUpLgoKQWdyZWVkLCBJJ2xsIGRyb3AgdGhlIFZDTEsxL0RDTEsxIGhhbmRsZXJzIGFuZCBsZXQg
dGhlbSBmYWxsIHRocm91Z2gKdG8gdGhlIGRlZmF1bHQgKFVJTlRfTUFYIC8gTi9BKSBpbiB2Mi4K
Cj4gRG8gdGhlIHR3byBpbnN0YW5jZXMgc2hhcmUgYSBjb21tb24gY2xvY2s/CgpPbiB2MTQuMC4w
LCB0aGVyZSBpcyBhIHNpbmdsZSBWQ04gaW5zdGFuY2Ugd2hlcmUgVkNMSyBhbmQgRENMSyBzaGFy
ZQp0aGUgc2FtZSBjbG9jayBkb21haW4gLS0gdGhlIERQTSB0YWJsZSBjb21tZW50IGluIHNtdTE0
X2RyaXZlcl9pZiBzYXlzCiJBcHBsaWVzIHRvIGJvdGggVmNsayBhbmQgRGNsayIuIFNvIG1hcHBp
bmcgTUVUUklDU19BVkVSQUdFX0RDTEsgdG8KVmNsa0ZyZXF1ZW5jeSBpcyBjb3JyZWN0IGhlcmUu
CgpPbiB2MTQuMC4xLCB0aGVyZSBhcmUgdHdvIFZDTiBpbnN0YW5jZXMgKFZjbjAvVmNuMSkgd2l0
aCBzZXBhcmF0ZQpjbG9jayBkb21haW5zLCBidXQgU211TWV0cmljc190IG9ubHkgZXhwb3NlcyBW
Y2xrRnJlcXVlbmN5IGZvcgppbnN0YW5jZSAwLiBUaGVyZSBhcmUgbm8gZmllbGRzIGZvciBEQ0xL
LCBWQ0xLMSwgb3IgRENMSzEgaW4gdGhlCmZpcm13YXJlIG1ldHJpY3Mgc3RydWN0LgoKVGhhbmtz
LApQcml5YSBIb3N1cgo=
