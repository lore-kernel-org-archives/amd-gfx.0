Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52920C28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 18:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E656910E062;
	Fri, 28 Mar 2025 18:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BekVE37K";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B431610E062
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 18:07:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHbepoU4ge9ziIFaBVvuBgahW0jA2Tn5Z2uUu89UbObH72ikClaLxLUrKp4LaKqsPteTkNiNskb+VKqMY2ztgnFoVbloRmM37uhuvF7jZM21iRc7Rs0ha6/xYJ5CdiDtjPjLWd/CztgE1+FUSRMHwC9IjmjzMfcbX5yI8Q7AygTVwkRebNru7pXeFTkuu0bBGN7wfHGJLKys6gaCy13F82053gGLIn7EWK7SC1238ohFZaStGVzCa6J68UlKqyavSUsMje1nzrC6M+oFI91SGFEfed5XV4x1qi+pagbsrggJYdFig3d1wh3ClbcSDOjBbhyc9dnQzGJ0fplAlyVlsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RVfveL7ur/9XwlunnsXPC8ChwGazX7/J6xpicTpl08=;
 b=vTI+YP95k/bqtef0wVy8xMrYkuh6F44HGAf+qAYVtYhGK+J0Jp777dU5dJMQC+TFmJgTf6G2PN+HmxRuNBZhSLb33fjJkO0luhpP630j8vriyBiUZ1NfDlrYp/5+BNNU7igo/dEEYqgCCaTe1Wca/AM2xLQd33i2loVkMoagVlqSODZWmIKDphaTKTOrTxTa5MdymBEMowo0WG39eERa9wfi8dLvS3nXQ3IOpZSTHTJygC6lyVRX7ei2Q5GJjpj/gGHBEmbxgB5HfasEl/l535B0pOaMhcMXHhCf41zRNz3IChe4IEUn844aqySP8/Km2ZsGoSclUxqrHDF2rh/A3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RVfveL7ur/9XwlunnsXPC8ChwGazX7/J6xpicTpl08=;
 b=BekVE37KEjWzIHR0BsLsrqoQ34uI+372iCMG4NQGBGjNqiIZVIRU9X5jHQaeklxUxWcy2LrkyB9JOcN4uYNLQcPrRBvsXda0tsDL2fBxzJ5pmkmQ2X1nvWNIagrn367ikZcmtQEhcvrz3INPgUF22/PkIVWF/lBNyPdcACh0tPQ=
Received: from CH2PR15CA0022.namprd15.prod.outlook.com (2603:10b6:610:51::32)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Fri, 28 Mar
 2025 18:07:06 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::18) by CH2PR15CA0022.outlook.office365.com
 (2603:10b6:610:51::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Fri,
 28 Mar 2025 18:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 18:07:06 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 13:07:05 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <David.YatSin@amd.com>,
 <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>,
 <tvrtko.ursulin@igalia.com>, <dcostantino@meta.com>, <sruffell@meta.com>
Subject: drm/amdgpu: Support dmabuf IPC with amdgpu CRIU (v3) 
Date: Fri, 28 Mar 2025 14:06:49 -0400
Message-ID: <20250328180652.2108029-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 4837784b-26c8-4482-2de3-08dd6e235983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|34020700016|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ig9pcR3zex44gAs+w2wQ1i9kvqoDC8abPIxP+EUidMfEDJYvotKuglHchHEp?=
 =?us-ascii?Q?Zphwn2r0amzhiymkg/aJGkyhBWeX4ArnaeJcdb7pUTDyOmzfk+NARgnyk6LT?=
 =?us-ascii?Q?8BmFXmpsmaJxv7sGV1pY7SjRUsY/LsD6GTCfnHVy8qJ9M3gkgCnhcxXJmd4S?=
 =?us-ascii?Q?nsc+rU/ELbdeCOsiq6QVd0j/u7zy056Eo8kXSDwHGndwhgA5Nb2+f0mVDRcm?=
 =?us-ascii?Q?kJVXTJnd6LZxvNpuwhyMX1PHVFEepTCfxEwzlJ9ULi7Mab/XKCPdNtEUG5mq?=
 =?us-ascii?Q?WCOSTTawMd/Pj1oh0/1aF8D3uHszent/XEXe0gA6+iv54W03ZP9cv4+eQ6e7?=
 =?us-ascii?Q?2sGTd/ffM6p0lrjRsVuRX6bVr23Z76gC4umPHfNmoIXy234Vc/84hxuNYtUp?=
 =?us-ascii?Q?LciAH4AQRqIedbtH8Bd3KHMeAWEWUCd+ixlFyHiKxzthh3mdYSGdtwOJE5lN?=
 =?us-ascii?Q?1T07ouvVmmaAcHRC++7um0sqYMQUjAOFXyJZsSnANDaAk23Z/Rk0T2fk4Q8S?=
 =?us-ascii?Q?1g/v/oVK0aqZyP52oBN+0mG2YiJwESbpWDxr3xr8lr4yR9Y8g63ysKGmvHM7?=
 =?us-ascii?Q?mrUMD2JUboFm4YBHODn0tyv1PvrwiJf9MFHfbrxspNjaSQaGCMfoZr5SjSxX?=
 =?us-ascii?Q?Mc35vf/9Uu2bvhzt/gFwAHJJUD91l0DYXb2x5ouFAMKWyiPY4T923qKjR+2k?=
 =?us-ascii?Q?v/7KNvQVq9/KPpCCdbd4VXPtuFhzqM2zelTekafbNQ+53y7FJg57jncoRm9w?=
 =?us-ascii?Q?3dsF78Se+gCnB//4U3+F7LCzUzJ9xb4y+ta9txIA+xntgMDLVN7yMSRDJEIb?=
 =?us-ascii?Q?gFJm1M8f3mzu9cb+/gWupK3kfprnN7YXHcmD4PEur34QzqIwSvwakFu3G/+p?=
 =?us-ascii?Q?PqRQYWeHklVV/cgaFlxCqjRnepOZVbpi7DV9JOarqYgWVqeC41mEvca6rG6o?=
 =?us-ascii?Q?fxIO6jEM0mNZnF9ilIo3W0ARBfNjys3LsTHCMQC13zjuPOI9VUpGmfsrYzlV?=
 =?us-ascii?Q?3tgt7fXKx5bGrd1BjAgs+I/kH7d1WJqaj2OKmAnUgw1F/JFf2uPLolEV4OkM?=
 =?us-ascii?Q?OCRVsIRXdyAYqq6i3B90rq4ngvEZeoeeNv4nfWcB/GqXYFpm+G+2afG+UNBw?=
 =?us-ascii?Q?I2+XZFKK0UD4nPhvZsLvssbmettavQtOq0sv7ggz6aOSgYkRNE+YiNPoQwpI?=
 =?us-ascii?Q?7EhRM0k4RVIkZ7ESParYlaI9zn/WFuWV/8WRcm/nl2LlbNkeDkAizNTZRZf7?=
 =?us-ascii?Q?u0OQGTXVOxu3N2UeBjhvwvZTriPfqJTgZ0fhI/YrO13iyzOuTn0o80y7hyUs?=
 =?us-ascii?Q?GLRom/dUpfFEX+G4HAeS7539G8CfOsMv8RsvVnQaFfcqsV0q4oBYCBfASlQJ?=
 =?us-ascii?Q?RVtmuLGUUZsTXmYeNJgUZ5lnG30P+KEvNbVccb3PIoQ0Sd1pIKs9DutvAOX0?=
 =?us-ascii?Q?K8QupkZs6C7lEma40Dwb4i3ZmmynQJzkdd6/4Z9CM+LOgMkpRafp58szdIjo?=
 =?us-ascii?Q?F5sPoop3v1davYg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(34020700016)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 18:07:06.0377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4837784b-26c8-4482-2de3-08dd6e235983
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
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

This patch series adds support for CRIU checkpointing of processes that
share memory with the amdgpu dmabuf interface.

In this v3, the drm interfaces have been changed from creating buffer objects
with specified gem handles to changign the gem handle of an existing buffer
object.

In the accompanying CRIU patch set, the sockets used by CRIU to exchange dmabuf
fds between restoring processes have been refactored to be created within the
amdgpu plugin itself.


