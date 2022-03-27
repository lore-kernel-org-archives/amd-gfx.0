Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF93C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Mar 2022 10:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A218810E339;
	Sun, 27 Mar 2022 10:42:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ADE910E339
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Mar 2022 10:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSHtfYoTvgnwrSDb5V1sq3eX+2DFWbKDVMkGkTwPP5+ZgIh1YzXuEQH6zG9xDAUwgQUjq/4MlZ9q/ptC7iWZmoSrx0HdTU4ojP66zFFYCdC1DdQLQFNYzRx+efOy1eAjxrIaMvN1SIUxVkfxxrih921B04IBC+PazDLnMGhfSid4PwFlhBUYXh/K/iDypY8n37VKP7kZftR4o/SLW3pHbi+h7liNyBiVH0JVpTmGxO7Ev6tMV7t/CBYOgiujJqo1mNZlsDhcxmYL0tda572J+Pm1aPMMNA4xfcGWAL86jqJ21Pkww8f8aQUTz2QIIQ+G7CjevmP5ZTEfXwJxch21Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/j2HMOLdZkDf8TiKwZseJE/1YkYXZAZuS/nHm2AyYSY=;
 b=mnV5LcWDv4iVafxqajdKoVaF1dBtDTz8NHkCBwqcGurnIuM8HYa/wBT9nfbWaxrZ5bmZyu72FirczCjmGEweiqU7ttozm59r0G3oa3aR1jT7zOA0dtjdueXDwvk5WHtUUEafEf0CdM9aNV7GwBu5RwnUqv8Xvvl+aoMHkpgvTKx1f+RGvT8HYJRgE+H4Kw5uTwSe+sxFrFIt6yQZlKvm95yHRFvZ/M4uZv/hEZtWnUWBazbnK/nAE8ZhPpHd/X5YV6xGr2qk00Q8wzMPdInJ05x8S3AFWMIC9hv2loTSSkQUfhKzndgSKq+HpOF+vfa/OxQieUjxP3wvjHSgOEoIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j2HMOLdZkDf8TiKwZseJE/1YkYXZAZuS/nHm2AyYSY=;
 b=osOAIL1MfqJ9yzd6dfzDPZmb8TCw/ec7QQp38JY0g3b1d/KVWliXK0Ys7bdc77SmI9LFp//Sx43cSQ9/ezMI+pkMX03jvj4p9t9RQ49F7EHMDYnRM7yOv+CTGsNZRxLPw0spufK+wITpctAKWqKrajdLmynPu5BEU3CLNwaBOD8=
Received: from DM5PR15CA0038.namprd15.prod.outlook.com (2603:10b6:4:4b::24) by
 DM6PR12MB3241.namprd12.prod.outlook.com (2603:10b6:5:186::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Sun, 27 Mar 2022 10:42:35 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::e9) by DM5PR15CA0038.outlook.office365.com
 (2603:10b6:4:4b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Sun, 27 Mar 2022 10:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Sun, 27 Mar 2022 10:42:35 +0000
Received: from pc-32.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 27 Mar
 2022 05:42:33 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] umr: Document new format command line options
Date: Sun, 27 Mar 2022 06:42:13 -0400
Message-ID: <20220327104214.106340-4-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.607.gf01e51a7cf
In-Reply-To: <20220327104214.106340-1-luben.tuikov@amd.com>
References: <20220327104214.106340-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b9a1236-4106-4de1-8ccd-08da0fde8158
X-MS-TrafficTypeDiagnostic: DM6PR12MB3241:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB324114B37F5AC55C103519AB991C9@DM6PR12MB3241.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xi28/49nDMI2Acgb8FWQrdyIhDRdQ9wxYY/UaxNz29lkCKAOQ4qKeVMcC7W0h9XMqsypYqd1ovdGcjvUT9gDSRj2LunJpjaPL58/XpMsMlIbwvDDuI/y1fLDJ66wc9soROhfIFiNOWvA7Aam/AbPr+sk4pn8XEagsJ62a75j9lgBwiaQMfurfLS3dzbbAfhd0hWDZ9rqZEqJJVvhqEssbUH3VO4pfJiuEHZ0CNmKhkN8RRaThrvuTDEoXIzdW9RkfBKZbUFInMF6hKDlpoBQ303nU8Ok5lxBrC4zZiU3/HXbQTanoEjRULM2g7NDt+evpB45tMK5O3SELp6VH4yRI3ooDmxxDylJ4q3IDouh0DYal3TUXKR6bETgY1SpZQO6bro/JP02NNN2BUmgPYWVYEMAhZD4Xlk16MRFGGHH2M04wdc/VfKhs5FIpK1p//gEW0j7XErpatLk3cNFM84CNxRsqK3giuBimIknBKfxlYd1uRtWmaOfwrka1dUW4MR0BRARknqFO/JZldOq3JZnwSaSlEyUMTkmZJLSoVRMaYatane8uU0hf4XjqCPFsC1uORRBqRo5PI6AawKUt87QRtO4iNs5H+E8uP6HAy2/0FpI5X1L4e2vCyR11/sS4yvAGFDa1dnu/A72PB0oWb+YIkuvxw3b5t9iGuuFCLc6v+N/hIud1TJJYSOBsVT4e1oPH/OtX88TDO1a0RyxBXHRxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6916009)(40460700003)(186003)(426003)(336012)(54906003)(1076003)(2616005)(8676002)(70206006)(4326008)(36756003)(316002)(2906002)(356005)(26005)(16526019)(83380400001)(81166007)(5660300002)(47076005)(6666004)(44832011)(36860700001)(86362001)(8936002)(508600001)(70586007)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2022 10:42:35.2473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9a1236-4106-4de1-8ccd-08da0fde8158
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3241
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
Cc: Tom StDenis <tom.stdenis@amd.com>, "Jinzhou . Su" <Jinzhou.Su@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Document new format command line options in the manual page: "--ppt-read"
and "--gpu-metrics". The old format using underscores is still supported in
the main app, in case it is used in scripts, and so on.

Cc: Tom StDenis <tom.stdenis@amd.com>
Cc: Jinzhou.Su <Jinzhou.Su@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 doc/umr.1 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/umr.1 b/doc/umr.1
index 62eea7db320b88..ad518e0fa7451d 100644
--- a/doc/umr.1
+++ b/doc/umr.1
@@ -288,11 +288,11 @@ Set power_dpm_force_performance_level to low.
 .IP "--clock-auto, -ca"
 Set power_dpm_force_performance_level to auto.
 
-.IP "--ppt_read, -pptr [ppt_field_name]"
+.IP "--ppt-read, -pptr [ppt_field_name]"
 Read powerplay table value and print it to stdout.  This command will print all the powerplay table
 information or the corresponding string in powerplay table.
 
-.IP "--gpu_metrics, -gm"
+.IP "--gpu-metrics, -gm"
 Print the GPU metrics table for the device.
 
 .SH "Notes"
-- 
2.35.1.607.gf01e51a7cf

