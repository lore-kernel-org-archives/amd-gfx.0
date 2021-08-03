Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DDBC4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB7F60BD3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADB7F60BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3642A6E3B7;
	Tue,  3 Aug 2021 19:39:53 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DA76E3B7
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 19:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxUs8DLR2ihLhqvpGDHW3P2tKT/1TiH8tpGezIW0iul23CXz6/tLsgELpZSyG5tf61VCUWM/eAj4tUJRIeUbIc/4G/2vjsFbidAppi6jXcGFQZylqLT5kFolwbxdGd3tx7aqxiO0lxbFOb98E6QlejX8bhJjvQRU55/fzFIZaKCnxtDu5IR7/fHvy4wbppSvjTQ1WEHyihPeCY+0TJ/UtAgq7cOJWtOGTlDK3s10X4+VODC+ARlX9Q2py1aIslcHNAoSayyFN+AEayXmqkNYFSDZK6yCOOmoViMNTgLcIayWylWbb2iIj4EAhshEu9RqKxmXJoJjBkfBaumOTvuP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLmTYrLsODo0lF+ss8elMet51ENb9LSUX8gevM0BxfA=;
 b=mVaRLrlCSrtIC6LtjU/WStdo+lcaMTKmYbSbMNO1WhD3od95rd1giPjsnYBSHi8ge+mEhRftQly31KjguSmCq3+SX5ldsxWu8zPws4xkOZOcTkGSQmlAaLghc/BfDC1FhuDAvlputF+eX85P8jrAcyzgL0udJIcrM423vgEh9E+MlRrPorlwWuuC9LpULKwCMrz7onGCNs8wwGTwy/jRd+UeIUGOB/dKJpm2oD/aNV9CEYeTJdZibkM+GrgsoE31CrY9aDsJnb6l++D9C5XGE/pD22QOqLS9llFsyP2CTERcEmJIhVMBvC4fdY4HrmotRf6fA3iFjDvfnygUcgP/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLmTYrLsODo0lF+ss8elMet51ENb9LSUX8gevM0BxfA=;
 b=jaWTRocMy84VKK53Qx3dp+a3sDmpbWxtIIcBSQx3HcEafMHWZwYwsxQ/JDqD5GsBiFX8xSTd9+28kw3VCOKcVrOSSoDTnlUOcyUDJpoz1zyOFgG7/25Y4V6C7Gy+uPzRCc6phBKuBnqO2RMvVw9a335Ai1hjNkCbqkbvFnZieXI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL0PR12MB5522.namprd12.prod.outlook.com (2603:10b6:208:17d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.22; Tue, 3 Aug
 2021 19:39:49 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4394.015; Tue, 3 Aug 2021
 19:39:49 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Chengming Gui <Jack.Gui@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add DID for beige goby
Date: Tue,  3 Aug 2021 15:39:29 -0400
Message-Id: <20210803193929.2496812-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0001.namprd17.prod.outlook.com
 (2603:10b6:208:15e::14) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 MN2PR17CA0001.namprd17.prod.outlook.com (2603:10b6:208:15e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Tue, 3 Aug 2021 19:39:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaf7c9b3-50da-4c08-8be9-08d956b674b8
X-MS-TrafficTypeDiagnostic: BL0PR12MB5522:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB55220D79BF0BA1384216ACB6F7F09@BL0PR12MB5522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:118;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GtQCu5SfPduKWX/YZ4wF32/EUZTgbAIXwG4qfVWY2YiDsw8R5gJa2fiUlO9scQwb/ZcgXt5zyu9529/TDv4gxl+dcPC2DxBu2hUoXUXurONpn6XLsb/Jm4+UViN9Z1Wcq02BbMODbO3sNaYYuGF0mpGzN9p96sRdVIp2FwEV2HGWDyrJtfZYuAgdCE5lN72CtmWYzZKd3P8gfg7NlfOodZT4Tko5v/36jVjTnRA24uw403wTlD+QbiObhdEoHG5n+tDOGGk8v5meVwZZeM27mgucpJd0wVCa2lW2SPHakt5mCH4tFlPACzYwld/4Q9tlChrwzQWHUSKqMSYg3XCBa9NzrGAkjE6/CuAVjUWjKc0vcBrULRQoiTppopp2VxCd/S4Vkj+VvSOeERClfEBMUTNqena9Lrw205CxJ+Xt44FFnu4C7QQCl3hmeTaKAAtmksIXtr0TzZgmAKB3O3JNSsfqUfQdRt9DCN8EK4dfQJTk5903mE4azEr18snLHMPa0sKEoKrNXL2kl5HHa/DwJgSJXDVCQNs1KXLsinTFhGyAfovwj/FykzzMCJlssBgvy4wcf1aKQE6Ro+ht5qLLPcS7kSihyhZVNnja9DdhO6JzyB9PG9iNrHdWfgjzZZZCBxo/yxUPNjZwX5OZD0mM6T7QA/cNi6x5cxRIJr/2IpUh15tfRj/5lpLnf/XivP2gsol6kc4DFbOAJqGAA6mkMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(38350700002)(38100700002)(4326008)(54906003)(52116002)(6506007)(8676002)(26005)(6512007)(6916009)(1076003)(186003)(6486002)(8936002)(2616005)(956004)(316002)(2906002)(6666004)(478600001)(36756003)(66556008)(66946007)(66476007)(86362001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QO1jNPKLUWaqWlM7DSswSAoOkvS3+lYUllhQ7nIJpBTwHHXXSKeCaiCCufTQ?=
 =?us-ascii?Q?tz1sJIEiJHqfKVa+mUALj/TjGL+RrvLSPvN1jAVIm2jMFq89zqIAH4xIYZA9?=
 =?us-ascii?Q?rEGzMPaRUMsvYRraDKe8BAxNY+vciC9p/sLsi0pkNyXaKd7iS/jseLbYfUAl?=
 =?us-ascii?Q?0ScZOaB/LrPKM0PtjoHi342Ex3RebdZHFDSAM7cm5lG5x45tcvPMRRxyQOQA?=
 =?us-ascii?Q?s3BBJ/2a1zgwGCnej2rqGzNbr+VFVUijRDa0DBBqdB0LKjiG/eTemOUtAfZf?=
 =?us-ascii?Q?m3ap+qPnIaSVUHSM2c12W/eqG2MCw2g9XxOzQiALz1ddGupkOtseJWMEV5ZX?=
 =?us-ascii?Q?YSBZhmVVnVxS6UwQClRtFuIEsBaebB9MZQrFFL6YPjbSIe4nm9uzHqdzOd0E?=
 =?us-ascii?Q?H76JuKjmm++G5XRGtRSWRfLpqYlGFqMfz9HpVJ3TlRGxbMg4OwETDqu61Jhd?=
 =?us-ascii?Q?urryXO4wbCAtLsPDkatiIWAnB82dN4k26fBk7SoZTI+rnEzdegeOLLNGe9L3?=
 =?us-ascii?Q?Y3LnBHurBTlvV8JnbGBBfWUmf4zv2JYqDkDxzjvwlgEX3xUAVhV+UqfzIaMG?=
 =?us-ascii?Q?Vhv2OntbOhKJHC9C6PqE5kIys0Ch3vmPwHScxPG/1vA9Rzw0GCnYHfRgA343?=
 =?us-ascii?Q?z/xcOmVBEaczfa8vGd5xLi7o9r1FBMiUCWoRGbohJujRl6xF/cQ5LY/Ja1/v?=
 =?us-ascii?Q?B3ObB72kDuLtRMs6Vij/mDVB8xrR1tV9+zm3b8xm/7tB5ZIw2anXFY3rXn3h?=
 =?us-ascii?Q?oDwOpcxaHFsOT+dL77Vg3LjXjci0SoK7DZnAk37Pqm0ebqqUsIzUQNEuUTCH?=
 =?us-ascii?Q?UCxBNFMkLPpfQI21xwBp9TmL9vHlwS1+OZCgwKKv5CpD7218814ZiooPCCDB?=
 =?us-ascii?Q?xw16nRzgj1bTrkpiO8dVkh3LMvJDb4wmQIuVpThd3v+HRvgaqx/wQr9V/KrH?=
 =?us-ascii?Q?V5KOAqYB+K8n1hZowRbuj28p4WfZigBVAE+8mtYMYM2DYpYga9CnEA+/tPtV?=
 =?us-ascii?Q?BiQkzaNU2nSdrS7x45FDhx5Kd7ydKXmF1MZO02DKnxXknTdHLCMSnlWkPZPy?=
 =?us-ascii?Q?++xJklHwXwfJXWe25paKgh1KLY/BwV/Jr85qhHP32x/foxyh79D5b3YxcvVj?=
 =?us-ascii?Q?QZetTAuetATqjMOhu80tw8ZMiJYzS0ak4tFAkgg/qE+mn3gUKLYEjSSHfmnN?=
 =?us-ascii?Q?7rAVJaFAw4WNQI1XQUIaxPZYG6lvV+7yyK4VapSAPH4wepVo1KNF38D7UlyP?=
 =?us-ascii?Q?obVTSQ5s/o4NdblMgLuOI3fxU1H15HkjV9Ygbyw7g1a0OHrUqlpfktI3DGhc?=
 =?us-ascii?Q?zktuStRkuCw4H7/6JfzEwIYZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf7c9b3-50da-4c08-8be9-08d956b674b8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 19:39:49.3974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcVgQbtW6NzRdNU64dFmS3x4Ev4/SEzymBIpUD0Kpmx59lxFDv3VOlcNE6iZUA2mINcHi7u7MIsw6oenGvc6rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5522
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

From: Chengming Gui <Jack.Gui@amd.com>

Add device ids.

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 91a5ed96bfbe..b02c87ae4245 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1215,6 +1215,13 @@ static const struct pci_device_id pciidlist[] = {
 	/* CYAN_SKILLFISH */
 	{0x1002, 0x13FE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS_APU},
 
+	/* BEIGE_GOBY */
+	{0x1002, 0x7420, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
+	{0x1002, 0x7421, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
+	{0x1002, 0x7422, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
+	{0x1002, 0x7423, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
+	{0x1002, 0x743F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
+
 	{0, 0, 0}
 };
 
-- 
2.31.1

