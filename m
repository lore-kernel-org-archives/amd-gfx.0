Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE26AD111B6
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 23:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD9710E733;
	Wed, 26 Nov 2025 23:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XjLejYgk";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012046.outbound.protection.outlook.com
 [40.93.195.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA77310E733
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 23:06:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIQqBAn0ls4RyV7uRxA6/M6eeugE5rb7TGTc0ie/dxSaHujclgjByi8MmP6cMHgF4BwXfKbfk9z66DCdk02KIlfd8zL/BBams7nSy5oORo1vnr1R1CQ2PdqfEXqmdqYQISmjTToAnm+Js8GuyvfAw8lthUDRKW4ln3n5NMaKg4HgTAgpaDaILCyjZ24PY0GHmCagFp6zXVjsab6/pNyXDImzudERlSs1W4uzP7AdA2RC2FP1T4j7gziXo+RF73ChZhlq9B5h8FllLTRK418JAVfs077TFYCeGBDWPCT1eSUmNUne2mKWpFszz7wa5qTaH02QIAEewQNUtEjfTmLdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPN+NBVZ1nT68EM+wQxWI1UYuKmyz8/m7AGcNKue59s=;
 b=AkVuc37MZqB5oMonTrx/hxLE0xM2x9jC9oY7PpF/LsIaZsk0JhtcQxWr40wYV9Cca+h0RGnyIR9KmvAtuJeoh3VtKK7ViBemtFyNvT4Lst4y0no+Q6yLFZsln7pLu+pMyjYec8P7AFvggM1LMP47vf0+xjgOg86t1EUvVn1joEMHZfvvbsAIFg/qno8jzFYAwGZsokXgXoIc4j+8UNphMSYubFV4m0ZNUbhaXC2TD3idShb2a/XduTnCa2kpWCHKnCvtPBRS6vvkB3CugB/mCQEp1GMsdhMUCyLs3DAtlYE+8ybGXgzRICvw5iAPwhyr+nbOjRv5e5T1Mg0u+9GqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPN+NBVZ1nT68EM+wQxWI1UYuKmyz8/m7AGcNKue59s=;
 b=XjLejYgkuubgDXD7WohsZP1CcKTwPaxwiLIEY4xSaECBA0iz+OTr3p47WQPteU37HOBkEeplQ68dj7FLKzs++WsmQz8EGrF+tMXB51eUMQxPz0hMl+/99mqVcma0MxrbKtpWqTlNRNAh1W/hjmta0gdCixBWcjXzvyEIrzx1afM=
Received: from BL6PEPF00013E0C.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:e) by PH0PR12MB7838.namprd12.prod.outlook.com
 (2603:10b6:510:287::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 23:06:44 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2a01:111:f403:f901::5) by BL6PEPF00013E0C.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 26 Nov 2025 23:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 23:06:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 17:06:40 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 15:06:39 -0800
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Jing Zhou <Jing.Zhou@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 10/14] drm/amd/display: Correct FIXED_VS Link Rate Toggle
 Condition
Date: Wed, 26 Nov 2025 18:06:10 -0500
Message-ID: <20251126230614.13409-11-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126230614.13409-1-Roman.Li@amd.com>
References: <20251126230614.13409-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|PH0PR12MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 933dbd47-5f44-47fc-4ae2-08de2d407788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mh6Itq6daljXhDsY9/RLEov+f4IaPfKx2ibWXVPmTnOHaEQM56YXDT1erPFo?=
 =?us-ascii?Q?V2w7rb0LAFS30YLlGWhsOMQofGxdJU2JTWOKtYQ0qy/GasVSsXWcM3ESCK/b?=
 =?us-ascii?Q?CEJoqoV8rx61sf22y9jNp+QPi0y9TnRH1BQZaFijPOhwwjz1yRhCpkTJM6XY?=
 =?us-ascii?Q?dzhG4hs86hoPKroh1rEAeJiETd1dYGXCzgGJTHzPrKYVgy1PCT0jXKNNkVSH?=
 =?us-ascii?Q?TqVpYhNeYqIlrFxzaVaUtQ81dbLtl6vd55/vRN9JhQ9fH4QFTIN0t7FRDI6I?=
 =?us-ascii?Q?N3175ZRK8+FujUjuyFR8DtMrFTpnVljfNCvrvIr7a+zXM9BM00vZI0RfrP5k?=
 =?us-ascii?Q?9sEhvXStBKbrJWnfGAggnvKNIvxCRieoc94whHxxGqwigM2wZizLbDlD/e8G?=
 =?us-ascii?Q?+x/VRM3O+4JE88moKXvgzP7YBHsQ0OsrwSXca+UOa9+hkdL5NGdYwYHJLWII?=
 =?us-ascii?Q?sWZvNAg8smAy3vb6begTWoQNkrWlm4jOib5BndgWT0eyMdHVn+PUVksbUKaw?=
 =?us-ascii?Q?sF6NgdQ4Se9vpkn5zm/TqPavgfw8b6cujwFZQIZopSsCrhosEK9bUsjlUf4b?=
 =?us-ascii?Q?roo7BulBngEoNIDZckXKn6OpGRN/DO9eGTM+PIH1I/ObjwX9xKcSG1fQIV9h?=
 =?us-ascii?Q?DJfvBYhMBFxIveWZBZSZanUA85Rpgol81N6SUjLdUAcBD1iGgMUONBXKftZw?=
 =?us-ascii?Q?4ZfG6EXnOv9Tmq2KLQmexnrIYREzw/bHrg6JMoM+Keq9Mz0sx3T6w1ooGU/S?=
 =?us-ascii?Q?hViuUFBQq9F9g5S50PxJnA+96MwgNsu++HvsmTZvofwBkXfZqFv2s7UhFdvo?=
 =?us-ascii?Q?6uMeH+jn8MLTc7Ehi+6ouik2C8NbIiM6tgfF+Ljw0nO6ZHGfzg8b7q5GEgBs?=
 =?us-ascii?Q?BY6CYR0RAai6xmbCOvvjtdLqFkDRvpP00JC/NmNX+k8+mM6bhH32RLYR/9mR?=
 =?us-ascii?Q?W+0J5ok7ywSrHD6XZb3fhN0PqCIZaQm+4Tp/lkNGTbNc08tNC1cF1+geKJpP?=
 =?us-ascii?Q?D2f48NjUO0VhBg4WPZOTFtNdMorgvUzAcoP6wZvB3W2W8HwFd3gOZn6BCxy0?=
 =?us-ascii?Q?H74Vgw9y8N4Gd8kUEF5FNe9OodH0iIG2TomyjTkwO+e7uy9q2ms7XEeWv1d/?=
 =?us-ascii?Q?eYYT6gouQj/dfzUtqp9RcGMoywauFE99PcSD335A3fkdnANzPTIOx+fvOhgy?=
 =?us-ascii?Q?iGDPMopGOKBlqJxdGfojbKeUlDtYDLvLEQUQkR5qEgxIKuQaiGNzePV/vjju?=
 =?us-ascii?Q?93hwU9mdI+8A/hUhFs/e/ZN2OfvNeIg9dJBHcPQlmdaBoQ/HDA/Tm+sexZpz?=
 =?us-ascii?Q?kRwWoKfyGtTpUBlafAUEeXSh5TqSkn/wzMS+j49TC+anDA2S0JUQ5mlrV8Gr?=
 =?us-ascii?Q?olQUjV6HrW3W7oeetD53QlyxdHFagSk+tCEzNCNzMrMkjzMJbFqb1jAUDMQw?=
 =?us-ascii?Q?ajbfUnULSqzVETBVjM2gy+aalC7UkJd6sPsj1nypmbGVya3O2A8prRPrazBv?=
 =?us-ascii?Q?8ryOhZwHhCj1+GrJwY3iybwS+ZRxICKkkqXAA/y7NRYtWhGIVgKR/+I0bQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 23:06:43.9408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 933dbd47-5f44-47fc-4ae2-08de2d407788
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7838
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

From: Jing Zhou <Jing.Zhou@amd.com>

[WHY&HOW]
The condition is only perform toggle if FIXED_VS LTTPR reports
no IEEE OUI.
The literal "\x0,\x0,\x0" contains commas changes the
bytes being compared to {0x00,0x2C,0X00}.
The correct literal should be "\x00\x00\x00" without commas.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Jing Zhou <Jing.Zhou@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index ce174ce5579c..6a7c4a59ff4c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -271,7 +271,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	rate = get_dpcd_link_rate(&lt_settings->link_settings);
 
 	// Only perform toggle if FIXED_VS LTTPR reports no IEEE OUI
-	if (memcmp("\x0,\x0,\x0", &link->dpcd_caps.lttpr_caps.lttpr_ieee_oui[0], 3) == 0) {
+	if (memcmp("\x00\x00\x00", &link->dpcd_caps.lttpr_caps.lttpr_ieee_oui[0], 3) == 0) {
 		/* Vendor specific: Toggle link rate */
 		toggle_rate = (rate == 0x6) ? 0xA : 0x6;
 
-- 
2.34.1

