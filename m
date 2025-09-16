Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B205ACAC59D
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B54C10E7AC;
	Tue, 16 Sep 2025 19:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ld0NTlFO";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90CC910E7AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaaXMjASxtUm777TUDaeH41ysnOrYt4uxBNZqKBuChWmclNspDR2k6m/yLfb6/QqEbwrSQV+awJUX9eiOJdGxRQCcJ+JAwyCyklhCFtse9x6AsoJuXaNdVuJY3alWdDWFPqV+gLa5mjV5lLsXg3J88OKNoxWdnC08eey3gQ0hOlzFIb7znbUSTXCZ49Ns9vQQGkTEdbqy6pcyMjcmWYWTOR1O4DnNIMqv7zcjoIB+ZcuESMO7rVLXGOkHf143v5/QY88bfwphy18CV8bg/GF3vC19cgwThuEZckfH/wPp18my4T8ZJJPF+GTGRtA7dpGBH4giAp4zbWGkgWUr/Njvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4378tRmuIQBZjzDOiT4r6ur+ONpdVPYg480tAyMIjF4=;
 b=t0wDUTqNl6Adb0HxotCUwB8JBUZ+qDH/HQ/81SxkHAwF5gXmJCJM8rMSR2qkLA2DDbsQxkg5iofhEwgx64NxeaC70Z5Fu/gZurfu5ql1q8Crvwsb2o5nguFv+rlNtKLOCEp3cXWEXWh0IR6e8DNN9DRAbWhuJaPx6yQ6gmlmdcrV2m9n98S1zoKfQ2wHFKZFms2jrSY0FTZUuzcE+eZlV6A1Cu3I36S2uMfmqZfVsVUH/Hxnyhk/RLNUAEcsmbhdDqsdaWw6FjlcA7OStxXJ2FMpnyYSLJaYnM5Qae/odVy3gek+xYVIhLcvoNe5aoEx0hlBRElueL3BQrKYUz1FKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4378tRmuIQBZjzDOiT4r6ur+ONpdVPYg480tAyMIjF4=;
 b=ld0NTlFOJ43ErAp98v5EI2ln8QEXgT4cBU4GLo4zwo601tAaGFXlp1uUYBFrsud/PlAAE428zqzptLt5w/1Fhr4QiffKhPfR6ZS1jOh1yNS/Nux5lGvi+1utSk0lUSWwvfKKxtz0MCH93Q4O948bB2SSBcS/h1lo1DScnsAkEus=
Received: from DSZP220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::8) by
 MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 19:12:31 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::a7) by DSZP220CA0007.outlook.office365.com
 (2603:10b6:5:280::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 19:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:24 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Sep
 2025 14:12:24 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:23 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 20/20] drm/amd/display: Promote DC to 3.2.351
Date: Tue, 16 Sep 2025 15:09:40 -0400
Message-ID: <20250916191142.3504643-21-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 346cec87-a866-4f5f-81e3-08ddf554fbfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8Kqpxx/xdjJnHiIs2nntCr6RnjdnxDSiL9RzMtwEPOhYVzr90wdsM2FqURYr?=
 =?us-ascii?Q?+ku25e9ygT+Rigl134q8cpRETEJQu8rZxH1OgUqUf40cG04ToCyneNm3/8uS?=
 =?us-ascii?Q?VYVbYsNDe4DVzVIUJcmXyISyLovwha3nHE4wGArq2CU8gFMKNd9qKVo8KF7n?=
 =?us-ascii?Q?CvhnI1D7uxs/mJeo4c/HVkXizVHokoSPrcFvkMkPQHduXohfk7PnPQ3gAnoM?=
 =?us-ascii?Q?yLs0zTC8aSF0w8wFkrlzcJPc+nLjkc3A85PzSSTuCwNxt64q5f1kN8btEMPD?=
 =?us-ascii?Q?rnKrWQEEfdKxgBd2KK7rvJsBzDMrdhl4ZA6n8LsL8mZkUanx64c1t8zCZYxM?=
 =?us-ascii?Q?kF/NTqrXH0aqFUqxZuhWOkYYp+Fx3YceL611WtbJzht+78oEfb7uRrPipxq0?=
 =?us-ascii?Q?5QWbVk1IKXgTomeRKPhM9oZJFE62E4jeYaa1JTmxhZw7r6nHNuQq8AYUnoSi?=
 =?us-ascii?Q?sWIJv6Et6UOCdCM5C3CA9/JxbWMGF0LKpQ6ZBDOdMqcnDnExGlHFWILdOLgP?=
 =?us-ascii?Q?p6czWIHJyj7NWSJ/K+SbPabYq/yiyzCYhdQch8W34LL0wsvBuY8MU0cGh9mY?=
 =?us-ascii?Q?RTvHp6J/xPlNNMAtQHPSJ2t1YPnHqykP1ANWsacegTzSmB9VVOVA/4E2fBLA?=
 =?us-ascii?Q?nayzmv63RA8i5OOimXkxveVM1LrjT5vqqk9Ciygs3qvEKxXro7bHh7kOFjbL?=
 =?us-ascii?Q?/dS4A/iCBsX8JysU+bjObfLaAKIJUitVqRB4fThH2YOTI7LJ1t8BiTIWXX6G?=
 =?us-ascii?Q?hgXh/jpL5SztD1SPeIY25BuW4YASHI6+/5ce9f6lKp699i2JA+ciwZZSATFo?=
 =?us-ascii?Q?3XluFy3PtppwF90kh0bAtjDAXF8tG7Ez90llZ8fv3UVHImvbJRZpdAcvdm+S?=
 =?us-ascii?Q?AoG6CzHFLcxCAM+L/DNm7jfBvtiV7nfWG33TeqBXTFBMYqAAS3+/d/MPTG26?=
 =?us-ascii?Q?jIppgCATLEE1cQuRnosj8bM1yMe3SsOdqRUTFd8SGcFHOc5Rm5EBja39oZyS?=
 =?us-ascii?Q?/VbzQ7CH9KxKUexQR8kF8rVTzwm2uYEldlUVhyNRnH+0KT5oSnCvQ/d7ZfC6?=
 =?us-ascii?Q?UkZ/SttobuzGYClIoXF0+XKmoLJRtrkL+Lae+dnUczQbKk7/Umb17KCSknHV?=
 =?us-ascii?Q?5+fuHiIpfwotbdSR8pJ7soFGSkU7k2aO103PMnndEmL/S0H0w7arTEXnm5u2?=
 =?us-ascii?Q?YlyEVVIaGne1Z1P2gChEcrIFkw1XHTzWMFSGKEIeOD8npPKkjvUTC2w7DlN2?=
 =?us-ascii?Q?EHOulEa7GRpqSxZ+JAbwbFBeqU7RGJVqv62X9EN0dcSnt53WINgKsOdq00JZ?=
 =?us-ascii?Q?ayKTlMIFHIqJKEsyRwYF8lg09/pxRFBCXZL0wQMrYafruRRd8l4qFfbnqcnI?=
 =?us-ascii?Q?xjqmMNAV2MofTZ3/qRx2570gC9rG+jw5945Z1Kwy8Dqg/bHAolq4I2B8xAdE?=
 =?us-ascii?Q?1PDzzT8ny0ey0BzKkJUXy33jXuQhVSpL7OjIM56F9fEf5RrBS1KWtGy1yaGL?=
 =?us-ascii?Q?Znnjhr09cdKCAKMh2IHCHPa2JMLLxtODBdQJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:30.9482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 346cec87-a866-4f5f-81e3-08ddf554fbfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
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

- Disable stutter when programming watermarks on dcn32
- Improve brightness calculations
- Fix saving vbios clocks during init for DCN314
- Enable DTM 3 on DCN3.1+ dGPUs
- Add new ultra sleep field in DMUB
- Isolate DCN401 SMU functions
- Refactor and add logging of SMU functions.
- Add dccg logging
- Fix DCN35 clocks initialization

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3bcc7a22355b..1617c7a13916 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.350"
+#define DC_VER "3.2.351"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

