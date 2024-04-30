Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CE5C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 13:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D98310E5E9;
	Tue, 30 Apr 2024 13:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5X2c9u5r";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F81410E5E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 13:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beCMadW54xRobccR84PtmE2Adzwj8pmISOPh3vea3mcu3O+FPmLpF5RDLOa9eeobVpsEcdDv+wsJBwb9kZ4MQhXfz0r/uA7ik2f2v0inaHyFfY3ssdWRi9hJcpd5LEXj/labr5rvKUKkThjIBSxS5AX/6w4wk4sXsUJDG/zxhcYo4eKlWeVZQ0rzoHOZGFafAL+lF5CtHrFBwv2wq8M7OqnHzcsA4YQLnNHK8AS2L4XtwEnDdNQ7DKbS20cgyKYSaA1JMmT1GUqGUEQJDBJZ3tCZ8c5l/fddLn0i4CZHPrM/2C2ppgd2xqAlUIGVbgzsTQnnBMaloL98bA5sQaglHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPhUSf/2c8zbFb+Hhc858Via5O6Wj0KjZT9tP9tY3GA=;
 b=d9tkDB9FH1Vr6ZMZZ+CY3ZdHimTC0beahK5q9vn5J+/7oL+4ph4OXCfcdcVHlIbWaJhkawL+ftMOpKgkzrFYRXoKUjcwvjD0uOihSVpAkYcKuwgMrEkmGYCohhLbrsCdPBQ2IOh5FBOf8CD0XWi63pSFgtKwzBxlg0mKWMU9yn3OxTSMGtJ/9CH9/7/6amc2YarwnV6U95t6bXIQkUEBXanHEsbqniBUxY8z37/r7fS6w2Sc+jP2/903fINvR+YUItAfIE0JMu6iY/GM2dO5NT7nPw6oulh7RIpGfaUnatOUZdQsth4f5IEVRIZ/AxgHY6avPH/HF0AfTCGuDgiJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPhUSf/2c8zbFb+Hhc858Via5O6Wj0KjZT9tP9tY3GA=;
 b=5X2c9u5rDymVtkbI8udjPtf3iFMXE+TdGQUKgbcE190yd4RYuyCdPVeRI8SCfNu50V/202adrDO2nuaaPu8o3RSGaDHOMNVEtIsvTDNDO0pHszGtt/PNGnrhiZt+csK7tLPNOQKpQj38reO0MGf1yNkfLRqspMO1/9lHVS75WOs=
Received: from SA9P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::21)
 by MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 13:43:08 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:25:cafe::da) by SA9P221CA0016.outlook.office365.com
 (2603:10b6:806:25::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 13:43:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 13:43:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 08:43:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 08:43:06 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Tue, 30 Apr 2024 08:43:06 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <rodrigo.siqueira@amd.com>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH v2 2/2] drm/amd/display:  Override DCN410 IP version
Date: Tue, 30 Apr 2024 09:43:01 -0400
Message-ID: <20240430134301.18555-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430134301.18555-1-aurabindo.pillai@amd.com>
References: <20240430134301.18555-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|MW6PR12MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 667de8b9-47c0-41a3-bc48-08dc691b77f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400014|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OXwnVm+Y48YSw7fmhfbDRbljZaDJk3re2BTTLRxQ8TriF9h1d2Zh4sTpqCCV?=
 =?us-ascii?Q?xtFZycTQydViJFVi80T1/iXzu/fz2oW1loj2PSQt+NL8Lf3uzGs24+3U50UE?=
 =?us-ascii?Q?Ja+yQ50gjNI7GEzqjYxe8c2gXDGANHgRkr3uhNXrD1o4CP5GOCsmzUwk+xfA?=
 =?us-ascii?Q?UANvXQ3zv14dJlQm+XRxPgUQ06eGpLK9QyYmwQgElu74U1x3Fqoc41cc4IwT?=
 =?us-ascii?Q?2YM1tt/4LMCWNDw4bdxidEnn33LcgP6Xb8tl0kAhI0uupwqBLvF1OIMLOtpu?=
 =?us-ascii?Q?47M5+dk9HoD6GwAbqr0DlDQCYymffldTPIKgfzZ8wrmHibNazM0/tN6E1Sfl?=
 =?us-ascii?Q?7IC60H+c7n2FRqFrIyj4gd+muOlc2dpBj07a37bdEY8SF5jL22wInaEpq6/u?=
 =?us-ascii?Q?xFk1w/PEa0IdbOtr8STtmxG1Xdj7CAHmLlLcRwy6Pzm+pV7pFbjz3JvMkBQN?=
 =?us-ascii?Q?TX48I9Q0KWUH9b/hd/dJSlsDaSEwvLFw0mHxn3xj1Wkvm3Wr3jYtwGI4EqbX?=
 =?us-ascii?Q?qSCwm6Fuy7Iq493wVPvlwAca+L0K/zq7LagRlnKYjvRY8YIfHfh6lNIlKgaK?=
 =?us-ascii?Q?l9XautLgvOp2R+oHR0IdnbnES0v2d0PF6yNaASTBs6WnaZPR6/zvkGf3WN//?=
 =?us-ascii?Q?86UN8h8raYo5LqvAQiNhWx34HUOKWDRC3teA801my6OoKzTHN0ghBdRECJQf?=
 =?us-ascii?Q?RpsIJaQBzt9/fjepZEdFX51WJSk9+fIf5rsG2/WHDFWdd59bZAKreMt1f27o?=
 =?us-ascii?Q?Tbz6YzDchtSD79vS7KrFfmOWXpdEdQKCtHPDiXHLakjlQXPZefpRafVzGoie?=
 =?us-ascii?Q?ajSR/wbgddxrkNjVp4vIF5mj1jkJDB2G+SoeWxYeus5dgsotIqfzbNnGM5up?=
 =?us-ascii?Q?GkBHXczIERPV4CJ36oG92KDtkL8rnVobEKs4/d/B4pYyg0uq+caSK/jaaMna?=
 =?us-ascii?Q?/BAu8uzYrZw6VRGIU/yTmA2e2t0CW5WIiJFi8pLeLfZ59GdcxrBx4E6vKsOY?=
 =?us-ascii?Q?w/ROh3sQCkYLfHHJS4n+xkHL8Y4dMKYK4uc4H7BpUBNBnNdqwvmyO5XhlAoJ?=
 =?us-ascii?Q?d5s8oFN5Ft+IIPKGYtPbwFBumjSrsxUuQPVGhDHNn7UE6LooyiLk2mGitiS9?=
 =?us-ascii?Q?IrdPoZctj0GCxlS3H1eKLTdBrl6ZT9Yrj6vnhTRMwHdMy/EJm7r5fZ+qVgrV?=
 =?us-ascii?Q?ti325n/yzdzhRztB4H0ZLm1HbjbwnXEUSpXEBlCX51OIF48zsXV3SxOgHHIJ?=
 =?us-ascii?Q?Ld8eStc1kOFsQKQqjV04yoNeeDHt6uvfH3iaQiyRIOiZydrg8l/4ppy8GoFD?=
 =?us-ascii?Q?pe/Bykzjx5A+6Dnk7hN+T/i8MNVJy/ZurZpaj7JGcXgVBIYG7H8UJvYEWfYW?=
 =?us-ascii?Q?Uy0CRjQszU8Dt0dY5cr39m4Qei3Z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 13:43:07.6507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 667de8b9-47c0-41a3-bc48-08dc691b77f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867
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

Override DCN IP version to 4.0.1 from 4.1.0 temporarily until change is
made in DC codebase to use 4.1.0

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index d7f948e84e4f..87a2f15c8a64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1966,6 +1966,10 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 5, 0):
 		case IP_VERSION(3, 5, 1):
 		case IP_VERSION(4, 1, 0):
+			/* TODO: Fix IP version. DC code expects version 4.0.1 */
+			if (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(4, 1, 0))
+                               adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 1);
+
 			if (amdgpu_sriov_vf(adev))
 				amdgpu_discovery_set_sriov_display(adev);
 			else
-- 
2.44.0

