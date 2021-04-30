Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7CFC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 16:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7526761264
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 16:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7526761264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A8306F56A;
	Fri, 30 Apr 2021 16:42:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B077A6F56A
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 16:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxR9EkjMDka5j7Bj+twcmQhWvFnNQN183U8/qgdPXnvT13VeFnQ/wxWU7fLT0ZOq6IQ6Bush9zeb281Z2D3YkGYrdSDgVsBHOza39N7c+87VuaAngb094FxMnn1kKITVlto1Cf8Lipl6biohy9hDagapGEGIiCxzei0WxagLCpywxSsFdXuzOGqPNLQE13osOSKTXE4copJDX/7Aq4e6HeD5KIUCMEj4+pirGpGKb9H/IOu98curkqYRyqDzzlOAuCF7TJ8nKXkxccsnO7DcRn3ibBRWzQIGDLV0yZlScUHf4KJYkw0cJHWNdQbpTlbbFFUR59UdheiNrB49J5DCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/++zgH2YCaKFe5lNTbTZ52Hz5rhO0qzIWuFCHf+E/Q=;
 b=eDaBGppGsLRuOfvUn5urA8SXgrfIRHxtwoYdQ9/BYoPlHskXlViMxCxPWpVSfpnHply4yQX0YVdx9BNs0JRpwdSuCb4Ro+tJ0VYVwjTuWYj12hMBmfkdhBYmu1N+OJZki58IQ5Gdd9EFIJHljCw/iAwLwpIuiKWeQxmuN+65jMq7OfywROwGRt9QUAumx/P9EYo633EiWdfms0jHYlkUuJWZg3rJOX4PppmPZkUE/9s8Ls2QcLzT/UPUDw1i7Kgq9WWa3WFdR3pwqTUnsr1nM8c1dQRURHq589vf2KG+0d7qPlgAvf0fl/1z19IYwfi1NovFbZyTpPsKd1gsGwmX0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/++zgH2YCaKFe5lNTbTZ52Hz5rhO0qzIWuFCHf+E/Q=;
 b=ub/HUzq5fb5OWRJxQ2kJ+tQd6YDDGhlL12vlfCwldHlH+M95T10ne/JMuy41PFL91AARqOdbEuyxN++xZKeyIkyJmPTx12ah4hoc2rOsTZaQrUr64poz6y2HXcgB1IzCHzQmY87SM30fk9eJRLxiFtpowGFafEQuEfPJtqYU+/U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 30 Apr
 2021 16:42:51 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4087.026; Fri, 30 Apr 2021
 16:42:51 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/pm: add documentation for pp_od_clock_voltage
 for APUs
Date: Fri, 30 Apr 2021 12:42:31 -0400
Message-Id: <20210430164232.1335629-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::21) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0106.namprd13.prod.outlook.com (2603:10b6:208:2b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Fri, 30 Apr 2021 16:42:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aa4a573-7ce7-42c4-662a-08d90bf6fed2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB417682AF110F43C021F04938F75E9@MN2PR12MB4176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6uIWvmhvaieyaKEnZMvyoHN84UvDPTdglXaaHEnKLKZEHAq4E4G6vUWKlfUY408uJixC5DW0Z5E6Pj8Vm2gGjLVHqmtoMlpd5y21x+QPQLl4RCevt5/3AAipI5QJU9GxxUh32OH8Lpm6q423upTUikeCCPg7yPRkXFjV73Khnzh75Gog4PbPw7vsIYR36y5luV1P5KWgWw5VMqPNyfozQF+oYQpa4SXUSgjJtPLqiO+yrX5KEFVuEs5PTgWyB92IFScAOr5tppKxzqz6WguJYCOe/mXIpneuK9OqT4dS/EmsvyUTZxMD7J6jAAYigIztdeWcN5RJ59nw4et4bHoi7AVfTMQcjH5QU7fLCEw/pGt3P41vTEJWYc4Vf24myrE9Qdt8P+jjVTr1i0ydMtnTjiw0pXoRQSCPLHPLxI0RZ3TtecYafn9e7Fq6tKP3q4RfVuGC9x4/OU0iILSg4hcoCK7hSL8VlzO7ajLOeHtMdbqTaeuAm69BjLKTJJpdyLxzKYO2oGu6B2s+BoO9gEmZfNPXqqx0FtA/RvHZK85D4gWdew9dykUipp/f/9p6DTWdIFV4gKZEqkXe/bJzi+nDVWq2hHCFCvVi4KV9/7FDSw1pHIEDqe9XaZsHt5RqQUZzYnDmInC5U2yiLwS6XYBDBmWqwya8k9kytRL94yd7dGmMsclvyBcltxTCvhQVX3c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(346002)(39850400004)(396003)(6486002)(1076003)(2616005)(66556008)(36756003)(478600001)(38350700002)(956004)(6506007)(2906002)(6512007)(8936002)(4326008)(83380400001)(6916009)(6666004)(5660300002)(86362001)(186003)(8676002)(4744005)(38100700002)(66946007)(52116002)(26005)(16526019)(66476007)(316002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dv9mpXU4wVspe8Ubb4TlA/aRF+PeKX86K893GuUc2iMobE5VNbBo9qcC1HIG?=
 =?us-ascii?Q?k0h5+gsKnX/+7b3rwrsZEyCv89j3y9p/za26BvF4D15rNPZJLCVmsuVhMq+5?=
 =?us-ascii?Q?J0wMymAWcv0mTPERosPDTEqlsbeZmDBwXRZ72cCoeH14nLTwCx7bRiYU55on?=
 =?us-ascii?Q?XM5IA4NdTGKfg/6bSGOKzVeKEnAepeYgOU68YotVCuBnNVg6OdWwrQh6eroy?=
 =?us-ascii?Q?L0EcXDB5royX+quYxQjewAwMDXsuTBqyzaWhR6IOoHWs2WFNKDUNsT4u0fF7?=
 =?us-ascii?Q?6NtE+7eP6gLtV5PYFF0F14p6ZVdeupLak5/S0sflwiqebZo1TPcouQ2FPcH4?=
 =?us-ascii?Q?Np0oFjH9xodwNueIYyVF7GPHGgVTKcbPNn3Azk4L1QtyoecDCGoNwqZZ5HMV?=
 =?us-ascii?Q?p27K0gKGZoeHqtCJLE6Y/C0GCXYqhB3ln1OSgkZuJNfYeP5kTx90PnpArC9S?=
 =?us-ascii?Q?3vmzrFEoCrtUI73KRK6U4eH6aynUp6cTXMFEz4klLSZLyxeBkPqzq5DaFn3b?=
 =?us-ascii?Q?IiW6kbdWBr/KkNVjAhjyxNnhgtBD9fbckPSSU8MBgXljfUQhj2pM4M9Y+5pc?=
 =?us-ascii?Q?H8rg/80mUVT8lco3dMbgjBx7S8VaA8QceAaIrRP5l6raIXdOFj2B0ciH0qX9?=
 =?us-ascii?Q?t4hXWOrT01yS7yHVR1Om05xRmqT9MHpIE3Yh//A1rWYhMOwm1gj6DjsoMcfP?=
 =?us-ascii?Q?1Of70MTVXeDc+DCtSzxaKhFxaPFwC4MjhEfiyGingeOxt6p9KoX0qd5CVD9+?=
 =?us-ascii?Q?KrOzqesA0P0mHMZXWBu96UnjNMaIovm5apfUrRe47d4Y2BWR9NMuiPRPxzRs?=
 =?us-ascii?Q?zRMCYcYJjJddTZeHNG5Vl3BQqB8PNPlcwE5ZvGfkiPYlYi6z0dud7e5Vykyz?=
 =?us-ascii?Q?f/fsBhGtyxemEZO4iHBrzN//6bDNY3Qrl6TiIP9bn5rjvP7yVJwQMhyLmb1p?=
 =?us-ascii?Q?0LPrOO1Wj4a90kS6XBzsFteRwdmgGbIUhrrozeKNzD2CfNppeh5Hda1Woo1k?=
 =?us-ascii?Q?Ug0gpG6wp4j8pGPHzPXTuRU1jFxDXiBBl3Z909VYBN/+yHskf6PijAe3d5Q9?=
 =?us-ascii?Q?zOFq16RooFQDK7FJc/GT98UvyWE6/WXfKwHsqMXvGSqzGSysV3KTCrY9/9g2?=
 =?us-ascii?Q?cSuQexTWSVayXLUTo/bwvHBtX1qhd73blVn+Q6CedR7xVOT+r+b+rlHi+s37?=
 =?us-ascii?Q?ZBMhvBD7Oy48YdCf/9gwOdF6eQ6wTfe9u7k21IrtrBkZgqlGgrPhogv7cpe5?=
 =?us-ascii?Q?KY/MSldkT+OrJOreWBvNE70qi+2bjDKXGgltPT39DztbKwAM+dXXwWOj/wuk?=
 =?us-ascii?Q?Upbfc+zv1Ry9DmYsDmCuMLpk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa4a573-7ce7-42c4-662a-08d90bf6fed2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 16:42:51.6320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Q5FcalCTWgFEDHkWFMFiZ5DLUgQRjoRjw8TfyfP0AODldGAYVGhUOqd6KNOFtjMdF0fvGNi6eFH5KDh+xRHTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

APUs only support adjusting the SCLK domain.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 4e459ef632ef..cbd38f2be958 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -735,6 +735,14 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
  * - a list of valid ranges for sclk, mclk, and voltage curve points
  *   labeled OD_RANGE
  *
+ * < For APUs >
+ *
+ * Reading the file will display:
+ *
+ * - minimum and maximum engine clock labeled OD_SCLK
+ *
+ * - a list of valid ranges for sclk labeled OD_RANGE
+ *
  * To manually adjust these settings:
  *
  * - First select manual using power_dpm_force_performance_level
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
