Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D99C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 04:06:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABFF210E654;
	Wed, 25 Jun 2025 04:06:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gdhHk8nM";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF48A10E654
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 04:06:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLRewZNkODYVZLklr7Z+RaEVMHVFfXqp/D7SUZI3cKXEhLNYT99xD2NE6ITC/g9INdIQQsFaeUhwEWU9g/Oo3bXqDWkHPafMBFj6K8UdYO91Pm35jv9ohaeIVXSe1knNIFeeXxdeO6FXM905IFHvmFZ9iLJdDHDBSvsHreZgf8pk5/0bP7YKrMYFrCGRLyEGHo4c59aiqClTbu0WsaRpT5f4IKx3MKTBzIbt8wRXGxeoWxfw9rwX5lkdZ9xq0obiB0P+aChRLzjr7vJsbGBHQ9vsk6i2t1CvkSVPqqh2NzX4nO6/dhn6cUmxwTmyvhflLPa87NUhsQMcRPKx4ZRl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VSKNiadWWRFaHF8fahTvET4Azg6+N+EYcnjWtDHx0s=;
 b=Keq2YCSXemR3JfB6rVLW+UYjFJbLd/UL1H5bBoYR/RHLT+d56ggp0U11t253th3izLIpT7DixiLhzSI4VdmqtRr0KJk/d4hbd40NIvCdFJxANqEM8OPIz6Yfbb95y4lmpy3MRWsKnascrCcKbC00L7URqSVdEvj10jxYGUFWKTEJRen+qebnJoF4H0c0qhHENJ3o79muUBFFufCjs21IRhqU1PnNm2rjhjpvC05A0m53Uuh3coT4T/Q7htfTVzwNBA05PY8sGT33uQxPlQFxp4vQjh7Lz62E9QjpBIRwWG2V3JwEDLRE57ewQZ23fDotv/lQevaF+2TeoajV3dKAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VSKNiadWWRFaHF8fahTvET4Azg6+N+EYcnjWtDHx0s=;
 b=gdhHk8nMyG5+oNGR0eetze5/bWeBzfF7amNdZbYvVJ1OWj1bZV0Rvla0rorwdJgVOBu+7Qyk+vBFLqqrcTTyl7BRV8yIQEEC+eAAo2rhtzjWCWzvu1nFnp4zA35z1hFspg8CSQfXQxB9YmFqIkmBD2ZQQV1HUgcaAkEAG7Ddt/Y=
Received: from BN9PR03CA0756.namprd03.prod.outlook.com (2603:10b6:408:13a::11)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 04:05:57 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::9f) by BN9PR03CA0756.outlook.office365.com
 (2603:10b6:408:13a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Wed,
 25 Jun 2025 04:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 04:05:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 23:05:55 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 24 Jun 2025 23:05:47 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Taimur
 Hassan" <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 10/11] drm/amd/display: [FW Promotion] Release 0.1.17.0
Date: Wed, 25 Jun 2025 12:02:28 +0800
Message-ID: <20250625040420.886013-11-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625040420.886013-1-ray.wu@amd.com>
References: <20250625040420.886013-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a78ee5d-6182-449c-780d-08ddb39d9600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dbs9J6KgKoK9oOjG23aNxroBHD9dB2ZS8BPGrrcIbqd0Q/8Kua72et0sqcQo?=
 =?us-ascii?Q?pMV4IRa1LGwEfrik6JCm9lP2XU9XOLZdjh+0m7gMkVDN2ErqCEcYjWuHB1ZC?=
 =?us-ascii?Q?LqkUpv3wwgNC3Pl94+w1xfqx23Ix5AeUtIm3cNQFmdqxBswapJQ7fl+DhN/0?=
 =?us-ascii?Q?Kae6wElPaqhTsJlOwYgT0F4ykHSq07ZFDm+kHzeHC3D/JfE4Wn/Vkjqt//oA?=
 =?us-ascii?Q?M4mtZ/a0xIHRi0d22Fed3Lm8zKWMuNP8sfZRL8nMi17thz0rH0TLs24Pxnx9?=
 =?us-ascii?Q?NH7jLbYw/fRbMXkI3ruw3q7DYj8HjUsGhb6BORqEiLWnui/kH/ArPoloBK37?=
 =?us-ascii?Q?hR1aGmvKA/PxRSGJMUzLAl49Q8OZ8pTndqLMWzmFsug6kG1QaPyu/D40u0g4?=
 =?us-ascii?Q?6JID0edsFePumAv0z3g+cszYz16gQf6WdV56pqBLhwDld8NkAkCnd+nNIYPn?=
 =?us-ascii?Q?mHGrVZoe+mXkESKjm+DogmUXxYaXgxTIr/quLzuFpybKs8/EZMFP5akgnPN0?=
 =?us-ascii?Q?lRWWiDkIxo7S8KYU7jCNE2ccZ9ZEaKP5tQ5Cbqt5uI48+DSbUP3ktr/en8bi?=
 =?us-ascii?Q?cupY1yHN6F1H0QTHUpkEIoZH0t8Ai8XNTWQGp2tRuI7FO90F0pdl0qV27Efz?=
 =?us-ascii?Q?BUWYrxz3SfUQI6hl0umJQgtmrW35K95ps/oexayp8jdaAFtV0nuC0w5wkXFU?=
 =?us-ascii?Q?ethLTE+br2v2xMQRKvBMrOfP8dvwW5GS57t9sIDNVQoaqefOMLPJ3taG/oPy?=
 =?us-ascii?Q?ratn8FcV4kcFxj4ntmcSShHX7bcX4U6/ISfQF8NgpOb9saoyFA/d1YeF1hlK?=
 =?us-ascii?Q?22r/s5jc0qfygBmyeLo5Zk+kzEOVg71RphD2plYfn+g/4lxagJ07LcPDa3Ts?=
 =?us-ascii?Q?GsqhdmcrvPsFrZKjjNo3Ex2Ak8mtIfvGt9GFnPOq1+wyA+GvFJcXjLJfknft?=
 =?us-ascii?Q?8s7sTvwrW9EoBYH1+xvvdZppJlck0jLgMBEoylPul/sEs5I9hTRr5RR3Tnn/?=
 =?us-ascii?Q?EKGZrkQ1JpYFjvKflACwcQoeFUoQYUq/AyKNqOZDsd2IX1vrMWJMvtrz6lqY?=
 =?us-ascii?Q?Sm4AUnwpavc2HSL9DvXN1vgT8CWF457XLLSQYubo6H7b35qev7IAlAJjTwKp?=
 =?us-ascii?Q?U3OT3tkR8cUcmvCY6tFjq5AxEJv5ddGNgBnxR8n64C+0+1Nr128snewY0z5f?=
 =?us-ascii?Q?kxVW49/PKtlz9nwAhjp6pHUs3eQZZk+6fsgSCAh61VF9miS53xJLBt5FpNXH?=
 =?us-ascii?Q?6KitQKZGP2u9cOVxI0gwmx0FaV3AsFsCvi8Cnm0WVKYOzihMypOD0td0t8ml?=
 =?us-ascii?Q?Jea55z4b/TostJx6mU8JEOyFBlG4tNDeKnyxBVfSUg6SZDjHL2DbHJu1Husp?=
 =?us-ascii?Q?DF6cxv7XJgkbm+Zjnm953ahtdSdUe1j360tDzY7cdePdUt4X6taasqqRGeoG?=
 =?us-ascii?Q?vPNEeFkuSnb6sHIibNUCyPlqMVi8xCOZFIQqnkpek9pEQzzloHofu9eO//+f?=
 =?us-ascii?Q?bNv2AhZqw2+vJO9oZqTTcmWEeRfLXQCfJId4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 04:05:56.3883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a78ee5d-6182-449c-780d-08ddb39d9600
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Summary for changes in firmware:
* Add AMD brightness adjustment feature for edp
* Fix BL enable
* Revise low power init sequence
* Fix brightness delta after IPS1 entry
* Adjusted DP blanking sequence

Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 93f35ac7f5b9..5cf5dd5831fc 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -900,7 +900,9 @@ union dmub_shared_state_ips_driver_signals {
 		uint32_t allow_ips0_rcg : 1; /**< 1 is IPS0 RCG is allowed */
 		uint32_t allow_ips1_rcg : 1; /**< 1 is IPS1 RCG is allowed */
 		uint32_t allow_ips1z8 : 1; /**< 1 is IPS1 Z8 Retention is allowed */
-		uint32_t reserved_bits : 24; /**< Reversed bits */
+		uint32_t allow_dynamic_ips1 : 1; /**< 1 if IPS1 is allowed in dynamic use cases such as VPB */
+		uint32_t allow_dynamic_ips1_z8: 1; /**< 1 if IPS1 z8 ret is allowed in dynamic use cases such as VPB */
+		uint32_t reserved_bits : 22; /**< Reversed bits */
 	} bits;
 	uint32_t all;
 };
-- 
2.43.0

