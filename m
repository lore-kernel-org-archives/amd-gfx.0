Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17232C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 21:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD2C910E20D;
	Fri, 18 Mar 2022 21:49:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB3310E20D
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 21:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSjVzJU39h0Y2FxZ7CAAbRr/YjEXFH97aqoCgJaT1Wk5Vgpf0qDE1Mdw+Mn36l7UMi5r/FRCQm9A6WkOjlzMjbVV+UsLuoQ6krlGSRnNz3VLOlwdO9THbT6bxEC7KRiFnAqVDX8In4Sjee0sf3PVuWoe8F+Y3DLrpxm2PKcIjTYk3owkGIGMuar2+gXLVwD4RV6goNsbKoccRGMBeHcv3yZKtVd5myELhmloCY0M91309toeKGVGqZxKwryYaZRBoOPA9lz2DTMHEGY4jrOp+2mJ2ItZr1+nm1gcD+kRmJvU9maon4ydSbCTrsV1+no0rb6aep2Wq0a7jtDwTd93lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XN/W2hlk2LTej/HaO67Pwr8+75T3/+OmyS36Jn2qCWA=;
 b=MMUrotR0MVLQrt+v2FKSmpf0cJJ4N7UKXqCLxgLDZHP/aOY9MAjOPzFc/sQMNUz7hJLsJYRpuSs5pvHALuuxsUqcXv/2ItQpEbzy4jcRXyo708EoKPPqOfkfBtizkxNcfvth6wMpAMajVlQuBrpVeePjNtfYcPXPh1FhGsIH5xfo+Sdlu4ISJye4Bn/M6M2IZMGQvFZbWa2SwBQAJlT2gyOyEMD1OqRVBb2qGJurtJHT/PyaKKsNNUY84VjqyjoYj5eCsmDc6BBq4699Qj+RWFVjaT4ZVekVPPoxhKW/yPeThc1Jel5Bh7uMhhvdGwjuvb0mNYGwhTjR321S1Udrvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XN/W2hlk2LTej/HaO67Pwr8+75T3/+OmyS36Jn2qCWA=;
 b=jNAKnJe7NIKuEy8iEfEwGMRwiQt+AFygdIiKsIG+9CrdckUNwy5ub0Dp6wql2NtVveymfB5gy/Hrot6UDEf7mlAnbEnSrB9fPF+8bRi9APIklHSpYplDb453GzO2y6KjTJRnNR/hjJhKFwKnDF7SFs8jzjMUzu4s5y73tN9FFA8=
Received: from BN8PR15CA0020.namprd15.prod.outlook.com (2603:10b6:408:c0::33)
 by DM5PR12MB1130.namprd12.prod.outlook.com (2603:10b6:3:75::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 21:49:36 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::60) by BN8PR15CA0020.outlook.office365.com
 (2603:10b6:408:c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18 via Frontend
 Transport; Fri, 18 Mar 2022 21:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 21:49:35 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 18 Mar
 2022 16:49:33 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/13] drm/amd/display: Update VTEM Infopacket definition
Date: Fri, 18 Mar 2022 15:47:53 -0600
Message-ID: <20220318214800.3565679-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318214800.3565679-1-alex.hung@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acdd691e-46ae-4526-bb10-08da092931a4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1130:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1130B3543EC0318180378EEEF7139@DM5PR12MB1130.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ilsZjvxRvHqe3h2Mx4uM2tGUMY5qN/SmZ7vua0LQAxxRN/GK5wYF01e9Z12xj25/31TDyE8ZVZbe+Ris+NAAGZlaPwygjhNT0V3kUunuFqDtf4ff20YPSMOYEAvF7XlKB3tQWqMndIlE7PsH4s+WNnx1h0Usk39cZ7OH2UjnihIRWsGyK/h+sPyY8Kf/3TCm5voH0Wumun42cY4DQbbVk7snhsJXNxWXu4Oj93cMNdda1T4LpaLawoThYExDal4KmHWmVrT1jgsKkcmAJF0KxzrW13W44AFN64vgTJK/7k9qtibftyLpB2KM2lr7wMmLLzj5aA8aE8MXW09VATnhG8JQRIR4i5Hv8tg6mbPG9L1L8N8GQTSkuiVOI2PT0gYtteB4xJRlyLSZtixvBQMoMkwoDkHvcLq0JrsWpqv90AF7Dfd/4S1ay7V/pi9dPcv74iGAxj8l+lQoFlQkiQLHfHQDftmDW5N36hh00sAZFPxQRl26udel5Puv3MX3qzqWJG4zF2t83Scl+umEuJQp6etgZvj9v9+v933JF+jXXtXuRAElimhk/Esi3jhnNSCEIzzmtq3bWQ+p7z8NWFgIK7eaVh2H52CYn3Kaj7bOOGGVZt4b/CxXi/rP2TAcG3xaBYXmW+/KapI4MNqrvsrQz8PIC/QHil6oy84+utW2CEhIJIOJw9sg13PiHzJO+XFISETIXzJDNQUQll5FmguEkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(8676002)(26005)(70586007)(70206006)(4326008)(16526019)(336012)(426003)(8936002)(6666004)(1076003)(54906003)(6916009)(82310400004)(86362001)(7696005)(508600001)(316002)(36756003)(47076005)(83380400001)(2616005)(2906002)(81166007)(36860700001)(44832011)(5660300002)(356005)(15650500001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 21:49:35.6753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acdd691e-46ae-4526-bb10-08da092931a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1130
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
Cc: stylon.wang@amd.com, Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why & How]
The latest HDMI SPEC has updated the VTEM packet structure,
so change the VTEM Infopacket defined in the driver side to align
with the SPEC.

Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 .../gpu/drm/amd/display/modules/info_packet/info_packet.c    | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index b691aa45e84f..79bc207415bc 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -100,7 +100,8 @@ enum vsc_packet_revision {
 //PB7 = MD0
 #define MASK_VTEM_MD0__VRR_EN         0x01
 #define MASK_VTEM_MD0__M_CONST        0x02
-#define MASK_VTEM_MD0__RESERVED2      0x0C
+#define MASK_VTEM_MD0__QMS_EN         0x04
+#define MASK_VTEM_MD0__RESERVED2      0x08
 #define MASK_VTEM_MD0__FVA_FACTOR_M1  0xF0
 
 //MD1
@@ -109,7 +110,7 @@ enum vsc_packet_revision {
 //MD2
 #define MASK_VTEM_MD2__BASE_REFRESH_RATE_98  0x03
 #define MASK_VTEM_MD2__RB                    0x04
-#define MASK_VTEM_MD2__RESERVED3             0xF8
+#define MASK_VTEM_MD2__NEXT_TFR              0xF8
 
 //MD3
 #define MASK_VTEM_MD3__BASE_REFRESH_RATE_07  0xFF
-- 
2.35.1

