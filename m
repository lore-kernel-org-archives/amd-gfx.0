Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3B5C47097
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3014361C21
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3014361C21
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 160A16ED20;
	Wed,  2 Jun 2021 16:49:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0707F6ED16
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKtJLaWDmSU3gTESAVU8ypBKh6VYM3bqAVPm4m8KGL+UUPLzdqq9Aha1ude6ImlYXlct1MnX3eQ1guWCLiMJnu36kOEf/6MHT0pRDwcx4snKriiFlYfGiEZ04XyNAyWAm6/scOsJbi2t8W+RItgCM6+n5XtchpmMXovdcp7Vy4DDr4S6gqOhY+Qj8P3mebFL+G2TQPeSQwK4SmnG1bf9C3rOFxdZSYBC5kkd3J/7IkXZQqZkEYriDk5sbm7fCFhh7XFPCqUQq4uqkS/Bw7UW3Pa+7sJXKT13FzXX8qH4JYwbQHuosWWnZH0SvSiTVIQa4UVoY1irnqV69ieswpEmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tIgiW65My9aegC60U3ml2He26TaTga+y05rT7a9baU=;
 b=k9GZsJpiQlcw+m0eUL/6zfH+WzdEgjAZ5bTeSF0D4L8frwQ0HPg4fEwtZ0H/NFGg1oi+IE60vyNv4FGySP9Dj4/r6BCGfhgnC/FZ34ZDvwanae1GafQgvt41ttbnWkXUcbSCfS0VjhkTWMHr+zv2rOlASGpDKyZRDEzhAPRcLTu8/Mtltz77uVcM9NIFXfNg3eAHVkIgj47pu3JhX5gtJwIPbUHMW8R6XZNXRdLiG6LYzCwR0r6Qz0/KEsFp6TD6nB/Hpjjmg/4NNlju0rkVzW2mB2sNY8hqfLtA97xaQgO4GqEMsje4uHcQLGRu+lMhQTLvH4u1SlQ0sF235OklQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tIgiW65My9aegC60U3ml2He26TaTga+y05rT7a9baU=;
 b=D24QcIOWB+zZzAFSn+ORM6ZW9AX2jISl5RLiTozffDaj8J+1xP/ISSHMWoJwIWj9yRbdDvSC+EHuTrrvUgi12tZmr6HxviOPMLafeFhV36AfERdMhjXiz+xYoLQs0j6D9sxcno+cp+3l+TuBnqLQw4YhVqiw4/z+BXiFA+YN/1I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:49:35 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:35 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/89] drm/amdgpu: add sdma support for yellow carp
Date: Wed,  2 Jun 2021 12:47:50 -0400
Message-Id: <20210602164908.2848791-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9db3bdf7-4708-4f2d-c11a-08d925e66746
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40637FD79010D47AD307883BF73D9@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RgbNVYplBLHdd8qnN77P+848bRfiL7vJ7D6nYJWlxWfsr4E/xrqAAjLrQNyScXO6M/DsOq7oO3FAfgw8bq+8lgGMDTJLV6MYZ8muLn8gZ7PSP4GgfciS603hS7FQ6WDOBZvKlWMCLeKqtzQ2qF1uupHb8uSqugn1Pn7uFsxlfbgMPNdF+NqVcUwXzlL90c5D5tCmR5LmBEkaKRRUYzbfX5KjRobXdD65rslZh+dphruvzauDudj9VK7qheWNSp3NDLBKTG8jVZvKA9+/ab0BmMuT7PgLPV10+Pd7bNsP2pfAIvIjnOD6r+FJHjoAdNz+KD87jTOGb15su/4r/DHNhz0rKVmXsluO3VJOisoL+XEKa8MJx2/7htkBSa7NwYlZtFCX9sV9kCRMej506w5Hs9YmzXVOwu8vi4B/bllI/WI+L2peuV9WuhdYcQXWM5f7APEpdbyuNvswmHXegBKQm18DrpG1sPUfWPBqNmyg9k7MbM5V97N5jww+RiYo7JzkWXg49XUVM8FlSpZBFCcbSM+JcRmVs3OfxSHEjpXzhku2mTm0dvojmHlxdPrYdSwTB/FDYNk4jbiCygmoV4ksw+RI+OFwWFMM3kiY3QGznS6z1ZqVKyW749EGYPwYwQ0YmEgizV1IzplkjgPJj54iW5FaddJ8y/mbAPbqgJo94HvntlIaxcFlt9oLxthJ5/Nh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39850400004)(54906003)(16526019)(186003)(316002)(4326008)(52116002)(38350700002)(66476007)(86362001)(478600001)(38100700002)(2616005)(956004)(36756003)(6506007)(6916009)(2906002)(8936002)(6486002)(6512007)(1076003)(66556008)(6666004)(5660300002)(8676002)(83380400001)(66946007)(26005)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0YZg0eeD1ju06ywB+9HGjMehkC9VTKO3mKaTjXGnlCoLKpXSnqcCCjjmQgK6?=
 =?us-ascii?Q?0H47MwbinnI6+7711tBqxKND4yvLh0g5Y1lWEcmhpfydCasD7FpL/XWraMFR?=
 =?us-ascii?Q?qDpLaEJ9jKexaD/dZoM7AZlAGPs4bg/czcR9VmLMxvrPzAeTeKe710ReffBp?=
 =?us-ascii?Q?Eo7J33pfTU0w3iESYgpKmd4v214P1LKyvlhGLeLoXwzmCIl1UqP4k/IFKCCR?=
 =?us-ascii?Q?4vWjilPNX7W1qzMIrZzcEdZoZjsjjr8WqxI4t2/HqpYOxm/JnjhHVm20YXAY?=
 =?us-ascii?Q?dTZmirKJSoiZs9VTcwvAHg72eRAKkJooF6rTPOAeU2/FmRRwwtsHdbvIMw/p?=
 =?us-ascii?Q?HN6UYda3uTWjtBx0LDA1gDQ3GTYXZnlLlWEMAOSEU43Bm3wOQUuf13MTDNB9?=
 =?us-ascii?Q?tcw4LVYK5bDi9u5PzKbVrvh4rB5cjx/YgyBpfq0AqKPFPYL86DqFuzKR6GUu?=
 =?us-ascii?Q?yeULvE7cXTe+HlRUlUOfDsodM193Hq2Pv7GuxZCOYbohE+B6IjuvsZaacnt9?=
 =?us-ascii?Q?LrC61AhK5g8GdchIeDVeWwMClSmy3T0fw9TwGdkkJaqjiAPmuOXQrAnSIs+W?=
 =?us-ascii?Q?yh5iM/+ix9sIQcvOmN4rJ3UpOj9/xh1F+S1T0H15slK8pLeUbE/hZLO0jtR4?=
 =?us-ascii?Q?TqrRLfmxLOkrEAArteVfBHUIPlfGdXZ+qDy3ACNMTic72WjI+AsFvyoJYXza?=
 =?us-ascii?Q?5RpGDgH3yp863JvE35WLx6CYpKmDeGaOHafLXdOwGVfr/g2HjGC+KHac6C7o?=
 =?us-ascii?Q?H1H91d8EMqww3azp4QYk9ZtX/z91u3c3rXrNgcNRg0shj+loaqM6qDgVU7h2?=
 =?us-ascii?Q?KhS8xWen+xUElZ+tqVJT6BImHCC3d1H9zGznK2PS4Ps+Nub6wikjtImK3oAT?=
 =?us-ascii?Q?BBHPnOjMGIovXDcKfEM/rsMCKih9+8HKIxHC1sxITqwx+TdQt3+1KU5JbbAH?=
 =?us-ascii?Q?3vITF1mpP2Riosf/9u73VMwpzy/i/EqgXTlmK9mAg07rlC9CzEYm9AFiPCvd?=
 =?us-ascii?Q?EGsEPB67WHXstaHHxgy6ayEVHt1ttyPylkwltnhpYhmUtiaLnH4SVnC86w+Z?=
 =?us-ascii?Q?a/CBiePZKUfpt9egH0uLiaGbXbvjRzARa6dVi3Bu9Ioo1hfJdsSe9w7Qmsi9?=
 =?us-ascii?Q?HPxWWqxIRjs2sivvYVVKdN+2mLW3oq6UcbykmL4PLm3XvZI5zZu8fZKiTNE/?=
 =?us-ascii?Q?uXVJr1DBmScddfP1fVAQeiTM6tDMoWgkOdZ0uRMmGCqM19OTUW366WOGlI1c?=
 =?us-ascii?Q?H8C1qgN4eMIsP530L768O/oxf7TC1TapznNT+1cNepGdz5FxnkTSjRTMLffz?=
 =?us-ascii?Q?N7QC5hMEZbgN0VEQjKzcRRB5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db3bdf7-4708-4f2d-c11a-08d925e66746
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:35.6565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ks7CNKgwDv0FAmJ6zJ/Vg0ESiiF7mFRt/BmfcUREMKPKXiUwpVZ7fmt4lq/ow74rBJv8nbwznxl22Ztg3RvMqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

This patch adds the sdma v5.2 support for yellow carp.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 98059bce692f..310fa65c725c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -50,6 +50,7 @@ MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_sdma.bin");
 MODULE_FIRMWARE("amdgpu/beige_goby_sdma.bin");
 
 MODULE_FIRMWARE("amdgpu/vangogh_sdma.bin");
+MODULE_FIRMWARE("amdgpu/yellow_carp_sdma.bin");
 
 #define SDMA1_REG_OFFSET 0x600
 #define SDMA3_REG_OFFSET 0x400
@@ -94,6 +95,7 @@ static void sdma_v5_2_init_golden_registers(struct amdgpu_device *adev)
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		break;
 	default:
 		break;
@@ -165,6 +167,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	case CHIP_BEIGE_GOBY:
 		chip_name = "beige_goby";
 		break;
+	case CHIP_YELLOW_CARP:
+		chip_name = "yellow_carp";
+		break;
 	default:
 		BUG();
 	}
@@ -1229,6 +1234,7 @@ static int sdma_v5_2_early_init(void *handle)
 		break;
 	case CHIP_VANGOGH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		adev->sdma.num_instances = 1;
 		break;
 	default:
@@ -1630,6 +1636,7 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 	case CHIP_BEIGE_GOBY:
+	case CHIP_YELLOW_CARP:
 		sdma_v5_2_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		sdma_v5_2_update_medium_grain_light_sleep(adev,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
