Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F37C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 03:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14466143F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 03:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14466143F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F35E86E1B1;
	Thu, 29 Apr 2021 03:48:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FDF76E1B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 03:48:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4UFu7mg8/rSYNiOurjZQJk4wgCVzPkqvN2X6FLzbeSdjeAGMSD5gzIH65Wt6SNMKCFpmC1ycDIWEapaupHHg3ROZFCWvHokd/kZcslKknbG0kAQvBqwOjP4kpu+AliLCl0d7IF0mzPtAsWrwhQntJ6LG5Cxulssck4F85FcAJqrARA+qJMvYihV+Qd+OxwyJK35s7iDJs5Wy1OLRMsKL5dRN6J5q/5BObcuu2SNk6QQc31upwFSlFNvmz/2n8a+FWPejtaRK5IRcUS1ekmjTqH+Ghq7QhA4PMTWnwNCljNL3h5+dvJOgNCsaN5Z08dYK3J0/giIyVVHP/i/ErVivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vwVjkvSnvLLnWU/XaLsXfVKmQaGAapc82M/tQHVqW4=;
 b=WFpbjEZaGxFZ9loSNJw91aMgjU9LtICQpBwCCn4nx6PAR4QAPZr62iysCCKRSflvj7MWzoCDE4XW0dwyxecSyK0aTZQX9lnT5clFIvrC2si+BvYZOwM0WSPWmMhaK/FFjVr9AhU0sJq4wmrvfle/iSfAvlqOAcKIjIU2T/XiGC4CvcJVSpRwoVJYzVtHw+s6WQFSJ2KBVpsEWJtqc0PkoVla+UqAw2hLVYpAFboaDpNYTEs6CWmQ5pMRXDi5tmcq+TibQowbFyYcq5AIky7C/xBgRyVjwBA5i0n+lkg71tTsq3KqG7NjW07HqY90IoY0Kr75jMJo8xtPioXPn/Bj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vwVjkvSnvLLnWU/XaLsXfVKmQaGAapc82M/tQHVqW4=;
 b=FjCyoYXiTMqjOdpRVhOr/hfXF2ZZXdl9EG3WV8xU6UdiBXCObrzYR6OV0gDfOenauCLVr86C7UHG1zHwBwIq5NmxZ0w+Ifpy13RljskecnXYt1m6HsNi9QGDqpAW2Qnoqi+KtzwZx4VDg8dPdPUNnrfqXsgziQ2e1fqH7aixGdM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0123.namprd12.prod.outlook.com (2603:10b6:4:50::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.24; Thu, 29 Apr 2021 03:48:37 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4087.025; Thu, 29 Apr 2021
 03:48:37 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add new MC firmware for Polaris12 32bit ASIC
Date: Thu, 29 Apr 2021 11:48:14 +0800
Message-Id: <20210429034814.1754882-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR03CA0063.apcprd03.prod.outlook.com (2603:1096:202:17::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.8 via Frontend Transport; Thu, 29 Apr 2021 03:48:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4125623c-4c72-4b21-052c-08d90ac1abbb
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0123:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01237146AA0A21DB0C1CCB66E45F9@DM5PR1201MB0123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:71;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvPLy1BIp/2zzfcLc8a84dnbxiv3i8Fae9Ah0+ESiMNa1Q0KaTNdwxicVXAa33P5XI9wgx6W2rn/Q68V1NlIN5jL71U3ZBp9em1sEjDeSXzHz6ziqQ/kOcwrnzK7S/Oj73lWT+Dfj5kZoAcW+77xy8IeLVaLog8q62JSu4XzC1dOr7M85lwlJQZVlWbXVgPWyOGwFI9BCth3bH5aPHWOoIhmeO3rk52zXI9sgbYlZSUKHTZqtjwqh9o6ztX6riV3dggoUatRwn+i03NXL8XNgo0k0KH7F6/SThDsotfAnklDKsksk9KaiJZaKWLZWuzecaBLM2mWD6BgpSk18O80euZuJptVrKKf94S3WEQUkmb4EVp0I4meJgjdlWIYUA9vSxKcETl3JYYsB8KAFTjNuVhloqBCtcbCeL5RL18GeMHVoINVkBW/2p5fnLDKq1n47NzX5DoBOgv7B5E9QBchn9ul8UhzCfXRWk4Lx66iKqB5J2Uw6TopwQwOj5f2Efkv+ycGn0zv0ViaXzzvv6rtAposzuEqNpHMWBz6deg/FT6P/Nq4rMSXCJBZaTnBzgjbHY3v0bkneponUfoOGKYhMLwc9XqSq2br7D0ey645QgKTvyfRtVQqPY+2Py7FB0wdqFHkV1fxvDEtryEv0o15Cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(6916009)(8936002)(66556008)(26005)(83380400001)(6486002)(16526019)(38350700002)(956004)(2616005)(38100700002)(4326008)(66476007)(1076003)(6666004)(86362001)(186003)(478600001)(2906002)(7696005)(8676002)(52116002)(316002)(66946007)(5660300002)(36756003)(44832011)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gcRtaGPtuq6BaZ+bSfoRk1jVPHUV67s4P6aFbcSbZ7ccrdbKywGpuCVT+COp?=
 =?us-ascii?Q?/xoncMTTEpYWzdjIUFvCsngHeOEFDg0XPZGB9hUbJkticRr/OxWh7NL94DR7?=
 =?us-ascii?Q?8nzebftG57D7H9LP9CgNL8TcNdhD2uggb+78H2G5z9gMuvZMu4IWEs8I+Dhz?=
 =?us-ascii?Q?KSea4RFR6MR0w/HbStuMBHW+cyl1bV+toxQfRXOP1pBzBY4gIODonrcVhCsZ?=
 =?us-ascii?Q?Dm7qtSE5bWFLcUuOBJx173kZeePDJC/3n++aTvDwK+jw4ciFIdzcqp1KYcTE?=
 =?us-ascii?Q?rVdbVEfgzgZ+5xZc0sioya+LDfDAJthAOTHQHasJUYV2YRlV+qJOLGFLO5K3?=
 =?us-ascii?Q?JdIhoTwdz9+6J4PQa4iZyJMDujqoRNW8xkUN8hZlkU3LKpq5iUDV2Efc+KWF?=
 =?us-ascii?Q?3pPdOQ0y5mpovo38q569znF+2i/L32uA2U9B74qWeZWxSsYA9GAyh8kPCcCL?=
 =?us-ascii?Q?gjpgWhmubGUZrJ+sbsdTnS1yyZAoSmvAl0sBqd/Ez0DB/Y6TW38ouVUkQNCm?=
 =?us-ascii?Q?BRksasragJDL1GiuZgswBOoZg7qfrpNJpHA4PJ8QPL4gRgKMOeMuJLwbHFz4?=
 =?us-ascii?Q?5RPd8xu5yXWU3bz6TYGwu0SPQh7gulElKtw1NC2OVhezGKLVyPjlPs/9eExg?=
 =?us-ascii?Q?UQlz7ohqCuRjEtNMyRDqRtf32BEaHYlXF0SfjpHZtSTQogyc4/3YdOs0Ip1Y?=
 =?us-ascii?Q?Oi79Xz7cnaBBGGRUb2m/s1+/vt55QqUSAO29RDfkGoeMXyWMd6ig0QT9VWO5?=
 =?us-ascii?Q?dnkHRGZmnHWZJKTpt4AJTqvrxiIlrxz7qDIC41nwkVqu4F0KzkwuA+Cs3ska?=
 =?us-ascii?Q?POpOF9Wf7s3VRg2wDxRQG63LFon659kHkbvlz8nkR6EecleyjJoNa9P/z+Ow?=
 =?us-ascii?Q?ipNrkIPcD3o+GRJvD07Ts2Chu2HsNrIbpwBPaNFZnmsLMyxqApH2R2vh6ofV?=
 =?us-ascii?Q?0MgpRBg4pCoGXW11unnsTjVxGCLPyrNVjZthUvkP70BvHypEgEvH3c5iEESs?=
 =?us-ascii?Q?Rrb2jNF4gGZphBzT0721LBrny1lR7sFYz8ImO2PT/aqm0nx9Rhe18gByY4P8?=
 =?us-ascii?Q?TOMvi3h/fhJ65cPiIU1KEVzwcaotEAWLsGHdB4ymuPUkz5J7kmZAggKsGvNv?=
 =?us-ascii?Q?cixJyDL8NOJ7uasxthM8dpSdvxE+926AGjE+yTpi3cLWpbt73laKOvtM07bL?=
 =?us-ascii?Q?/FBBpMiGR6SXIle54i0yP+c6qVwsgnqFWBS0HKRQ0y1cYgc69mb9GJRwMtxp?=
 =?us-ascii?Q?/w1flADXQIA0/DiqGBN10CmwycMlVbhaLYEONtVC5I2HZy4vB4DE4WQpFHgt?=
 =?us-ascii?Q?hDPJQWU+f5QzgQ1XF/2p59uO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4125623c-4c72-4b21-052c-08d90ac1abbb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 03:48:37.7261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WavIXyg6/2R9pvpfQQZVtYIte4zs/BxPYsfsNQNWuSiOgOxDDaPlTbXRhpqJZYM6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Polaris12 32bit ASIC needs a special MC firmware.

Change-Id: I1eea9cc1d5c81a370c8fccf139f4f77bac4a1baa
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index c1bd190841f8..e4f27b3f28fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -59,6 +59,7 @@ MODULE_FIRMWARE("amdgpu/tonga_mc.bin");
 MODULE_FIRMWARE("amdgpu/polaris11_mc.bin");
 MODULE_FIRMWARE("amdgpu/polaris10_mc.bin");
 MODULE_FIRMWARE("amdgpu/polaris12_mc.bin");
+MODULE_FIRMWARE("amdgpu/polaris12_32_mc.bin");
 MODULE_FIRMWARE("amdgpu/polaris11_k_mc.bin");
 MODULE_FIRMWARE("amdgpu/polaris10_k_mc.bin");
 MODULE_FIRMWARE("amdgpu/polaris12_k_mc.bin");
@@ -243,10 +244,16 @@ static int gmc_v8_0_init_microcode(struct amdgpu_device *adev)
 			chip_name = "polaris10";
 		break;
 	case CHIP_POLARIS12:
-		if (ASICID_IS_P23(adev->pdev->device, adev->pdev->revision))
+		if (ASICID_IS_P23(adev->pdev->device, adev->pdev->revision)) {
 			chip_name = "polaris12_k";
-		else
-			chip_name = "polaris12";
+		} else {
+			WREG32(mmMC_SEQ_IO_DEBUG_INDEX, ixMC_IO_DEBUG_UP_159);
+			/* Polaris12 32bit ASIC needs a special MC firmware */
+			if (RREG32(mmMC_SEQ_IO_DEBUG_DATA) == 0x05b4dc40)
+				chip_name = "polaris12_32";
+			else
+				chip_name = "polaris12";
+		}
 		break;
 	case CHIP_FIJI:
 	case CHIP_CARRIZO:
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
