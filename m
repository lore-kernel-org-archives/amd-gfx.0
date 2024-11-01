Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698C8E6B27E
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 133F210E9D4;
	Fri,  1 Nov 2024 13:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nID/ugsY";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD8610E9D4
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUHw5fOiCUcW8fwA2dY4UIvGb3s8bv4WXRFzyrnxjshLnIsrT47adAAfcPH/WrBAyIvF5DUKSNiMAs2uC4GHI7Csa2PwRwpvCa3CSkDpQSVuL5/rJN92o10gGVlRfNYUQRVbIsihMQ8cRy2eo5yE8cpRPhZhsxiHZDb40q3ybgOUDAHs2mZEbt035eSjPyGSDAiadJXvIRY7whpIWZzIkuKXYwzBU5z5t8EcFA6ggCFyf/Olh8C4XKJOVCQOELI2KDNQCC/redizCc1Ug5h4Rfrv39ZHfC+SV1un+z4ZratNbFVvRYZgCz1TBNU6pb6IEPWrFW6uMxuUHhltzxFDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0EjerfHwuyp48r9RaM1CIK3M5hjbtjcgX6IQdqmGAQ=;
 b=SINPoKoMEoJFBBvKGkZSN0tP1tw8LKwhXJ1mxbdf/n2WkGyEQuk2+dvuRWNcSxKhdvtCE9fozneDvzdTPN0c0/C5eBsP4A0IUKBFt+qBLf+j9ZbwN0OdWS6s9ATlSZ1H3dUuodc08cMJNeXFI6Q5BLQVFDsFdMVNrfZXmjprXS4DQtQOmCt0vzQsIwGncoyOjR5sZD2OUXHSM3VQG0agA8W/F8QvqHyTYKWBiK+mok8iYefdjmeal39naO+4X55MuLSfNX8daEYiYwz90qjbSkdeLGceHYgQExmrM2A4S8XanwxwL2J/38d+VbdiMBpcWilWjNVE1w7DNHFZKKIryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0EjerfHwuyp48r9RaM1CIK3M5hjbtjcgX6IQdqmGAQ=;
 b=nID/ugsY2rkgMiipJ9luBaCq5EN9vdzx22iGUTKlGtCJrooM6sY9T12BRw/l6cyVCpkMLT67x/jIcIwk+BY9tZ6f2UYhSTdl+bSnz6jUb5w8NPaEYEwek9C5g/lJiL/ZqVzM6pchSS7TeicehyehYm/llO701keGcnnInDzWKwU=
Received: from BLAPR03CA0134.namprd03.prod.outlook.com (2603:10b6:208:32e::19)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.25; Fri, 1 Nov
 2024 13:50:32 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::f9) by BLAPR03CA0134.outlook.office365.com
 (2603:10b6:208:32e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.25 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:32 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:30 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Aric Cyr <aric.cyr@amd.com>
Subject: [PATCH 17/17] drm/amd/display: 3.2.308
Date: Fri, 1 Nov 2024 09:49:40 -0400
Message-ID: <20241101134940.1426653-18-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f7ad37-66d7-4350-bab2-08dcfa7c274c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6y2jNaVjTKmDqDc9/P/pehPaKbp95+XtadJCdlP8fO++mDWSslVZEMs8urh6?=
 =?us-ascii?Q?se1NCZ3Da8vDYXpON5/adKfyrgJug1Nc0Qyx4e1On3+/536qXpYndtqdxkEM?=
 =?us-ascii?Q?ObEvBi4VQsrdtaRxTDQ0YC2d+RdXPN69f02fpGIC3XzOLHKmqyGZVQ9dL3Pk?=
 =?us-ascii?Q?fKqG7/ee1p6gAsRvJ5xyxgCzlInhkyxkvXLjCe3Y5NOlDWN28OL4uBDFJZ7G?=
 =?us-ascii?Q?CwFv4lUsIghx+MUWCr0P7LF/sZjIKP69hE+ZttTvM/tbHrwUa+/c4gGBrQC9?=
 =?us-ascii?Q?KWRcvVeJZMGZiigu1pwaXyQj1AWVY0iU4uO8LtJ0U87G4TqeItJC+afXwzJB?=
 =?us-ascii?Q?VKZF0MoX1tMJocAMRQejYWiDTIzQyEq8igcWlEB8YGbx7LQdijz7yZg0ScOa?=
 =?us-ascii?Q?iVhK9V+nZpFjz5klfSS97nxFYqQGuFx+adSwWVEACtY+tXYEtsgCIvvh515Q?=
 =?us-ascii?Q?mkRneL7MLZJybO05NOU2skbgn1jCjFdUjOQNmjuoWeoOClUNbGtkFCqBoK1j?=
 =?us-ascii?Q?iK2a8udDM1n1b8nbDz5GG4TcRrYyWUndOT16AP4u6+6b9q6U6ht97FtOTGBg?=
 =?us-ascii?Q?aV3M8p6A1i2yzkLCewMPCegA6yfjPhbCWQLcMI4BrOPxytFqIhL4QfUKpJ6a?=
 =?us-ascii?Q?zLaUh9YmTwtA4uxZ4sGSLrEip22PyKiu8c0wmXj8tf9Q6vOkMumHVA6eRUYO?=
 =?us-ascii?Q?o828CjktaVrPLLL1hFhF/q1ec0bbqYdwi6hwNVg2JUOnZhrDSGcUMcsBdFhT?=
 =?us-ascii?Q?mj9zkK/tEWl8vDlWXaDhJqhQG5W3mvn4nwRcfE0EqFFDB0rPz9ptC47T9nLU?=
 =?us-ascii?Q?W/ghw/+6+fqCM4e16NubslY6x5fv7Vkl7tcsWEuopO7B4P69Ut3dgHfFFzNt?=
 =?us-ascii?Q?z0yokIfv37mrbvHZzo10yY0Sf8ONb2qfNzbMA2Ht0/zjVoo94z593FskAqx3?=
 =?us-ascii?Q?IzkT3hZ9bEbgbNr7vOigfw6rFFChlzdndrorn7SQQOK62/7QJ8JVA9u0Qn8Z?=
 =?us-ascii?Q?xTRL0I/DCC0J5cS4hA3hBP8GR+oF9xcoXBOQLqcjvNXTJnRwBDr4sJSFZTZv?=
 =?us-ascii?Q?Rakyr8L1AXK/29ltr7s1lgEkqoprSFT12n2E/ZfhmNQo1D/Qa9hoMdVr9Yck?=
 =?us-ascii?Q?+trix05xDhHevlORItGXCKZPIA5FhOKh9lIJkOpEBOAVtmBNThIuAiCehl1s?=
 =?us-ascii?Q?qBrcHCpuGILHixzCm5KKOj9ssTgGTkkSRQekW+i3GowKpyIuDOvg92m5ce2a?=
 =?us-ascii?Q?3fiP2N0MZp4TvaDiUwC7La5LtyesyZ1VtWfi14YVlfrMlsopKRyr6dH4+0xJ?=
 =?us-ascii?Q?u73dfOwlNrRJKdeFrHAl2hXioQC4JlHyZYJYjiQpNillt1fF0yPeT2LiuoA4?=
 =?us-ascii?Q?HcxbTwi/O5w7cYDH+uKxjmYdsIk+7BWkaPw2dZVXr+/n+AjJwg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:32.1215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f7ad37-66d7-4350-bab2-08dcfa7c274c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
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

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Prune Invalid Modes for HDMI Output
- SPL Cleanup
- Fix brightness level not retained over reboot
- Remove inaccessible registers from DMU diagnostics

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5cb58ca77890..ad9ce3d0bfcf 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.307"
+#define DC_VER "3.2.308"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

