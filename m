Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B099D2F7E5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 03:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FCA110E2EC;
	Thu, 17 Oct 2024 03:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5UcQ9bR+";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BEC810E2DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 03:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DE1dxV7NSw6zqCETZt50SPdS3+aLvAhEM4dK3KU+dHz3FOlp0Y2AVU77o1UpvuF/qk+0QzFmiQLMSpAQ8TfMyMZaPHqmUqJjQD4rLN6Qg5cZj8BqN88FiXzkKGXmoN/t6QuiI7Uz/scBT6MDqFIMJQ0wASr7Ue+LLCbrGIF7cVCk1b/TSONQtgE4Ef0qpBRFGxUrVWwZ+F2TvQKRXKF8z5gJzmbRcpYqKyO0jmigqf4UXeTJjd8/xthEexE8fRpyIlzBYkZEycco0ItRZzJwqS85nr9eon+fnJkbPHia2Yc/11wSgswshOEGnHYFKpGqPSb7ZtMECMZ4xq5/dvAC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6C0iDleZzsK61Y8LGad53SeCGh6MpYuF5G0wI5BDv0g=;
 b=uh4M45JpQyNdSzBvrVZHZ0YieVq4rL6MMXdt8RQcV5Ox4xUchUBbWca3vnTi2pp8UFwrFeW8aGtXzJklkCgCUABI/TsthSR5H+K3jfWtYtJVXrsVsl4hTxu28aLah5YTxO/fhoRgLyFrIbrF/on6nLn+u6U43/OotxoDeP4aYfyvRQLu1uJci2hsedGsskgIlCjn6E76EDpScUenZJShscIo2Wks3FJEOv/5mpwd4nHyxJSDVcFyvkBeZtmLQL6vSsZ2gQ0twLHyxyn2161WpQNHB2e1mzvb5rbmjpUucrDcLIRjQ6UMfHFj+TVOu3FIUSd6PIDdAVdmGh114yEAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6C0iDleZzsK61Y8LGad53SeCGh6MpYuF5G0wI5BDv0g=;
 b=5UcQ9bR+a6vcRkv7S3nej9iq+l2HGYOj/eWaJWrlbNSAvoMt6t9GekG0ZBnenHOEYgjkIKCk1mONZktEfHd+2FVurYaJtZQK0lFPnV13LUGxbsLFowksDTiyHhEpx68Fg7QWCB1iPGd2Vx6dAgE68Q4t0X5o5C3YEMEUnqEwp/o=
Received: from BN9PR03CA0477.namprd03.prod.outlook.com (2603:10b6:408:139::32)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 03:43:47 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:139:cafe::88) by BN9PR03CA0477.outlook.office365.com
 (2603:10b6:408:139::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Thu, 17 Oct 2024 03:43:47 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.1 via Frontend Transport; Thu, 17 Oct 2024 03:43:46 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 22:43:44 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Christian Konig
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] Documentation/gpu: Document how to narrow down display
 issues
Date: Wed, 16 Oct 2024 21:34:26 -0600
Message-ID: <20241017034244.223993-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241017034244.223993-1-Rodrigo.Siqueira@amd.com>
References: <20241017034244.223993-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 061632ca-9e8a-44e8-e809-08dcee5de777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|30052699003|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTBJT2dDNnQxSEc4YWkydDFMd05JUnhYRnBXQ3M3VkJGYlBFRnMvWXhtdFN1?=
 =?utf-8?B?eHJTV2I2SlRwUzJ3ZFkxUzNhbmlCWVEwMEszNk5oK3B4MVIrOEdMQ21NSDZm?=
 =?utf-8?B?S2Nyd2UxczFaZXlzS20ydjRlcFFnelprQzZaUjJNSlhjZWJnaGNPcWVGMmkz?=
 =?utf-8?B?RVFwSERwTnJSak5Xd2ZKOGVPdkFzODZ5cjdwN1BSUTRpQzBNb0lhemMyUi9k?=
 =?utf-8?B?WmdUTCt6QkpRWGtXNFdGYzZ0SnAyTlZJeU90YWYzQlVWcWdPQWVacExUOEFi?=
 =?utf-8?B?N2lxbkVPaVp3SWwwZkl0djNJTHNER2M1VXFWaUFNdnpKck5sU2wwb0hwM0Vz?=
 =?utf-8?B?VXU0bndPVmdJYlpZSVI0RllSNUp6cGp6enp6U2ZSeEZhT3laM1NJV3JoOVky?=
 =?utf-8?B?UFl5b1lrY2wxOEtaYzFFR0hSQUI1RkE1SlBUOUNJSVNrOUdLVzJCQklHamlk?=
 =?utf-8?B?T3F4RGNKSE94Tjg1UHNJT2VFbUhsck00QUo2MmpUajAwbUt1eVh4TFppam1o?=
 =?utf-8?B?UHg2RXI1T25TQzhkZkkzRzFYNEYyVXRsT05pSUQ3S0pnTFhnYnhaMjBzT0VB?=
 =?utf-8?B?YUExUWZJOFpKaXErNExpbVpGZDFmelZOdzZ6ZFpMK2NwRmxnTWNEbEF3bmpN?=
 =?utf-8?B?b09EajJRTkZHS0pmZzloekd4OXpoN3JBVmJUQTIrQlpkbTVHci9oaFdtUE10?=
 =?utf-8?B?UTZBMWkzR3FsTnB2SFdUZTFidHZtcDBPNVlHUlZUUFc2cWgvY3VjMmRtTVd2?=
 =?utf-8?B?NldERkJpUlplL0x3N1ZuR1lYemdyRnZVeEpHM1Q1UUZUSjE5eWtmMXBEZTJE?=
 =?utf-8?B?SGhmT3FkWDNBdkR6Vnl0dHBWU2VnYkI2WTg1ZWFLanU3bHYwZEFoNjdRajRM?=
 =?utf-8?B?MXkzZFA2eW44dGtydXJleGpXMHk1bnBrMnhndE9XL1BQOEJUbmo4QlN2ODFm?=
 =?utf-8?B?Wi9kRDdPOTFHcE9XS1dmOWpVM3BmaVdiVitrUXB1anhUM3Jsc0VaaDE5UjdI?=
 =?utf-8?B?VlZiWVcxamdmQnVVRHU0SWhXR3BFcGJhK2xCV3EyeHRlQVRQTjkzUHZRU2o0?=
 =?utf-8?B?eWo4NUJNRG9DVHpMVXBBQ1g1Y0tXbTdKVTcwUisrN3NSUkR0eUtiNGtLVXpU?=
 =?utf-8?B?T2J6VUgvMFMrUEU2Wm5FUlcwQjdaeWZMc3lQd24wNHVBM0Zzdk96N0NLZDJB?=
 =?utf-8?B?Rmhnazh3OVBBcjRVY09YcHpoZjhnTE9ua3g3RFNHTjUvVGl6Qlhickp4OWQ4?=
 =?utf-8?B?QnBCU2wxMTl4anBVYUhldUtmdk5ZSXJtUk0vYVlCMGU4czZEeEYvTFgxZkNh?=
 =?utf-8?B?UUxjWURyMmVSZ29UejhKY2FNeUl5c0dhcFlxUHp5ODJoLzhxTkpXcEtSVitF?=
 =?utf-8?B?cm44SlFyeWVSR3ViSWNJRnlxdStOOG1maXloMEpYMVV0dm41WTVMOGxwVGpW?=
 =?utf-8?B?am9XMlV6Tk8wOUcxdTV1SDFVU013Z241WmNBbGhTeDg3U3dKTnpOZ1pXR0ZK?=
 =?utf-8?B?bHI2SlA5MjBuR28rOHdkcXpTeXJ4RWVEVXhiOGJOU0RCZUd3LzRacW9qRnl6?=
 =?utf-8?B?azJWc3o2MEE5d3dST0JTUXJpNkltUnRzUTAxODVyVjlaU1VUai82SThZUzE0?=
 =?utf-8?B?b2pYQURFNXBNbVN0RmY5OS9oeWpkam50Qlphc1RoU3hsUkp2SHRIYkFVUy9u?=
 =?utf-8?B?T3hWYklIUWV3WVprNHBRRmFaZm9HV09tdStVQ0ZZdWRuTnQrZ3BTZHdYTm55?=
 =?utf-8?B?dlZsS0RDaU91eXNKUU1jTnlUc1pFQ2V0OHZxZ2dJOEFydE55SWtpeEU4TlFw?=
 =?utf-8?B?SHNUTjhubTZYQ0JIVW13WW5hQ0VteWM1S0tFTzlKV0p6ZzhPZlVRRVlFakZL?=
 =?utf-8?B?SXI4QkFPQ1JuVWEvajlTbWE3YnEvaHc5SUF2OGdYYllnMEE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(30052699003)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 03:43:46.1750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 061632ca-9e8a-44e8-e809-08dcee5de777
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
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

The amdgpu driver is composed of multiple components, each of which can
be a source of some specific problem that the user/developer can see.
This commit introduces steps to narrow down and collect display
information.

Cc: Leo Li <sunpeng.li@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Christian Konig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 Documentation/gpu/amdgpu/display/dc-debug.rst | 187 ++++++++++++++++++
 1 file changed, 187 insertions(+)

diff --git a/Documentation/gpu/amdgpu/display/dc-debug.rst b/Documentation/gpu/amdgpu/display/dc-debug.rst
index 817631b1dbf3..013f63b271f3 100644
--- a/Documentation/gpu/amdgpu/display/dc-debug.rst
+++ b/Documentation/gpu/amdgpu/display/dc-debug.rst
@@ -2,6 +2,181 @@
 Display Core Debug tools
 ========================
 
+In this section, you will find helpful information on debugging the amdgpu
+driver from the display perspective. This page introduces debug mechanisms and
+procedures to help you identify if some issues are related to display code.
+
+Narrow down display issues
+==========================
+
+Since the display is the driver's visual component, it is common to see users
+reporting issues as a display when another component causes the problem. This
+section equips users to determine if a specific issue was caused by the display
+component or another part of the driver.
+
+DC dmesg important messages
+---------------------------
+
+The dmesg log is the first source of information to be checked, and amdgpu
+takes advantage of this feature by logging some valuable information. When
+looking for the issues associated with amdgpu, remember that each component of
+the driver (e.g., smu, PSP, dm, etc.) is loaded one by one, and this
+information can be found in the dmesg log. In this sense, look for the part of
+the log that looks like the below log snippet::
+
+  [    4.254295] [drm] initializing kernel modesetting (IP DISCOVERY 0x1002:0x744C 0x1002:0x0E3B 0xC8).
+  [    4.254718] [drm] register mmio base: 0xFCB00000
+  [    4.254918] [drm] register mmio size: 1048576
+  [    4.260095] [drm] add ip block number 0 <soc21_common>
+  [    4.260318] [drm] add ip block number 1 <gmc_v11_0>
+  [    4.260510] [drm] add ip block number 2 <ih_v6_0>
+  [    4.260696] [drm] add ip block number 3 <psp>
+  [    4.260878] [drm] add ip block number 4 <smu>
+  [    4.261057] [drm] add ip block number 5 <dm>
+  [    4.261231] [drm] add ip block number 6 <gfx_v11_0>
+  [    4.261402] [drm] add ip block number 7 <sdma_v6_0>
+  [    4.261568] [drm] add ip block number 8 <vcn_v4_0>
+  [    4.261729] [drm] add ip block number 9 <jpeg_v4_0>
+  [    4.261887] [drm] add ip block number 10 <mes_v11_0>
+
+From the above example, you can see the line that reports that `<dm>`,
+(**Display Manager**), was loaded, which means that display can be part of the
+issue. If you do not see that line, something else might have failed before
+amdgpu loads the display component, indicating that we don't have a
+display issue.
+
+After you identified that the DM was loaded correctly, you can check for the
+display version of the hardware in use, which can be retrieved from the dmesg
+log with the command::
+
+  dmesg | grep -i 'display core'
+
+This command shows a message that looks like this::
+
+  [    4.655828] [drm] Display Core v3.2.285 initialized on DCN 3.2
+
+This message has two key pieces of information:
+
+* **The DC version (e.g., v3.2.285)**: Display developers release a new DC version
+  every week, and this information can be advantageous in a situation where a
+  user/developer must find a good point versus a bad point based on a tested
+  version of the display code. Remember from page :ref:`Display Core <amdgpu-display-core>`,
+  that every week the new patches for display are heavily tested with IGT and
+  manual tests.
+* **The DCN version (e.g., DCN 3.2)**: The DCN block is associated with the
+  hardware generation, and the DCN version conveys the hardware generation that
+  the driver is currently running. This information helps to narrow down the
+  code debug area since each DCN version has its files in the DC folder per DCN
+  component (from the example, the developer might want to focus on
+  files/folders/functions/structs with the dcn32 label might be executed).
+  However, keep in mind that DC reuses code across different DCN versions; for
+  example, it is expected to have some callbacks set in one DCN that are the same
+  as those from another DCN. In summary, use the DCN version just as a guide.
+
+From the dmesg file, it is also possible to get the ATOM bios code by using::
+
+  dmesg  | grep -i 'ATOM BIOS'
+
+Which generates an output that looks like this::
+
+  [    4.274534] amdgpu: ATOM BIOS: 113-D7020100-102
+
+This type of information is useful to be reported.
+
+Avoid loading display core
+--------------------------
+
+Sometimes, it might be hard to figure out which part of the driver is causing
+the issue; if you suspect that the display is not part of the problem and your
+bug scenario is simple (e.g., some desktop configuration) you can try to remove
+the display component from the equation. First, you need to identify `dm` ID
+from the dmesg log; for example, search for the following log::
+
+  [    4.254295] [drm] initializing kernel modesetting (IP DISCOVERY 0x1002:0x744C 0x1002:0x0E3B 0xC8).
+  [..]
+  [    4.260095] [drm] add ip block number 0 <soc21_common>
+  [    4.260318] [drm] add ip block number 1 <gmc_v11_0>
+  [..]
+  [    4.261057] [drm] add ip block number 5 <dm>
+
+Notice from the above example that the `dm` id is 5 for this specific hardware.
+Next, you need to run the following binary operation to identify the IP block
+mask::
+
+  0xffffffff & ~(1 << [DM ID])
+
+From our example the IP mask is::
+
+ 0xffffffff & ~(1 << 5) = 0xffffffdf
+
+Finally, to disable DC, you just need to set the below parameter in your
+bootloader::
+
+ amdgpu.ip_block_mask = 0xffffffdf
+
+If you can boot your system with the DC disabled and still see the issue, it
+means you can rule DC out of the equation. However, if the bug disappears, you
+still need to consider the DC part of the problem and keep narrowing down the
+issue. In some scenarios, disabling DC is impossible since it might be
+necessary to use the display component to reproduce the issue (e.g., play a
+game).
+
+**Note: This will probably lead to the absence of a display output.**
+
+Display flickering
+------------------
+
+Display flickering might have multiple causes; one is the lack of proper power
+to the GPU or problems in the DPM switches. A good first generic verification
+is to set the GPU to use high voltage::
+
+   bash -c "echo high > /sys/class/drm/card0/device/power_dpm_force_performance_level"
+
+The above command sets the GPU/APU to use the maximum power allowed which
+disables DPM switches. If forcing DPM levels high does not fix the issue, it
+is less likely that the issue is related to power management. If the issue
+disappears, there is a good chance that other components might be involved, and
+the display should not be ignored since this could be a DPM issues. From the
+display side, if the power increase fixes the issue, it is worth debugging the
+clock configuration and the pipe split police used in the specific
+configuration.
+
+Display artifacts
+-----------------
+
+Users may see some screen artifacts that can be categorized into two different
+types: localized artifacts and general artifacts. The localized artifacts
+happen in some specific areas, such as around the UI window corners; if you see
+this type of issue, there is a considerable chance that you have a userspace
+problem, likely Mesa or similar. The general artifacts usually happen on the
+entire screen. They might be caused by a misconfiguration at the driver level
+of the display parameters, but the userspace might also cause this issue. One
+way to identify the source of the problem is to take a screenshot or make a
+desktop video capture when the problem happens; after checking the
+screenshot/video recording, if you don't see any of the artifacts, it means
+that the issue is likely on the the driver side. If you can still see the
+problem in the data collected, it is an issue that probably happened during
+rendering, and the display code just got the framebuffer already corrupted.
+
+Disabling/Enabling specific features
+====================================
+
+DC has a struct named `dc_debug_options`, which is statically initialized by
+all DCE/DCN components based on the specific hardware characteristic. This
+structure usually facilitates the bring-up phase since developers can start
+with many disabled features and enable them individually. This is also an
+important debug feature since users can change it when debugging specific
+issues.
+
+For example, dGPU users sometimes see a problem where a horizontal fillet of
+flickering happens in some specific part of the screen. This could be an
+indication of Sub-Viewport issues; after the users identified the target DCN,
+they can set the `force_disable_subvp` field to true in the statically
+initialized version of `dc_debug_options` to see if the issue gets fixed. Along
+the same lines, users/developers can also try to turn off `fams2_config` and
+`enable_single_display_2to1_odm_policy`. In summary, the `dc_debug_options` is
+an interesting form for identifying the problem.
+
 DC Visual Confirmation
 ======================
 
@@ -76,6 +251,18 @@ change in real-time by using something like::
 When reporting a bug related to DC, consider attaching this log before and
 after you reproduce the bug.
 
+Collect Firmware information
+============================
+
+When reporting issues, it is important to have the firmware information since
+it can be helpful for debugging purposes. To get all the firmware information,
+use the command::
+
+  cat /sys/kernel/debug/dri/0/amdgpu_firmware_info
+
+From the display perspective, pay attention to the firmware of the DMCU and
+DMCUB.
+
 DMUB Firmware Debug
 ===================
 
-- 
2.45.2

