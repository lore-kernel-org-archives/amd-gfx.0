Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B5AC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 03:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76156124C
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 03:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76156124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BFF6ECCE;
	Wed, 19 May 2021 03:22:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F74F6ECCE
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 03:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fa4Mt+cu1uBXkYJpUhY231fZQzEkA0A3/kigoF24SdkBuPl5Otr450Yc/GP48BC7kkMbtwwlY1fh+oDiXHvS1GfhHUUCa8dh93G+WNEqSrJataN+0OQMpebhyqEBoKJLj8X8/rsuGB/KGVRaUB6AadNqHBuaQ6AvSjleLwaxntIl/Xt/mPFBWHmeTDA6FQUt4l5cQ8EKy2vtgsn6STQ4ucuBvDFzyfj/lKiGHitH4pbENRa3/bcdB3aYjxZtmQ7WQq3zGQCBMY8yCoCaO9pqSFwGdESi69GeDMzBabfVcNSZYcADLq2KKnWRmY9cqIWryXxv1tdRYOYXWH63eKzlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzKihlaqiKPIKIdt0OUNPiRzo8CqRdREZ7EYrKv7RWk=;
 b=HxLqB0UKh84VCZxfqT/9YlhpYy4K+fWJKjiaIKQP/bBLmZMHqDQd6mrvim3O7WK9gMpvILxX7957kz+ZvjnIK0bPIc2yal4Ps4AS+su603t/nYWek1tg/3AZ1fhk/fKdNL9UCtLaQRApLSDI7OfUcwGtX4LYKzgrN6ZUhs5S399LtPTUal4NKD9JwcASGZWFgQ3aSqLGeVMU+TsO5hDJTDBjDqpyavbop2M2cxrGI3qYEFICmcztrH5LNAhA6YxISGYfVEbJtDwq6DEmXk3aR46zPh4HmEP3qXu7okBuqz4sU6SRzQpymnUkRUTu0EEU/+zmTOoU0ihd+7t/wwX9kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzKihlaqiKPIKIdt0OUNPiRzo8CqRdREZ7EYrKv7RWk=;
 b=AM2ZPeCOJOOmTgDmatxin6lViaMsvd4ZNWtM51b6a1XBaP+jpgidgC4zayIE7dUqCg8XKEdPp6z1Yz9hFd1A8lkN0Y+NVfzoGQmYq/vqPJNdcWJLtMrxgjE5xAtU2vEMG/WrU5co6/eccxg/oEJecIBhXwVk7egTWPijqV9tQB8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5491.namprd12.prod.outlook.com (2603:10b6:303:13b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 03:22:34 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::6d0f:e659:2a89:c67b%6]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 03:22:34 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: correct sienna_cichlid SDMA RLC register offset
 error
Date: Wed, 19 May 2021 11:22:14 +0800
Message-Id: <20210519032214.44849-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2P15301CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::25) To CO6PR12MB5473.namprd12.prod.outlook.com
 (2603:10b6:303:13e::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-ws.amd.com (165.204.134.251) by
 HK2P15301CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.2 via Frontend Transport; Wed, 19 May 2021 03:22:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a21c92ec-0ba4-45f4-c119-08d91a755805
X-MS-TrafficTypeDiagnostic: CO6PR12MB5491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5491A9E2DBAD522DACFF4571A22B9@CO6PR12MB5491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4uRYyqOmICmWgv1+JLsywqEIoS6JfVzpgxcE3IPNqgnMXhPZ4oQXG1HeIKGAR/FFzZUjupsIj4NnG7bJUN0+cDjquRMWIZqfNwXLkWfNnp4EZdOXbeSVcbJvOCYdfkTokcSOhqlVoTwRTRtfsZ7UL0KbtAWJMMYdTEUFCDBwJAqD1uhcejh2RGtCszUHxzDJguyOwcwc1JJeW+jd0V6om4bXtmzXG4B/8SRRgmz34QByyWIo1/cG5me1o7mRqOWtEplofuCdu5OqYSHecOX6YHww2tLJkp4qV2wLCsgaKI/8Z+I3d2GLyq6KxyQtiD7ilk+TwQdW9dxKq+KFcapLN/pfVe+3gurXpa9SlKihPs1WZNeb6c7+ugrtlk1yjpVU3gQtm5yHPyYl31UguxIBlr1VUaIyjHlbwLxNQOLLzi+RkmIrRGcOfJIrlirA4t7Mj/6OddHKJ3GRn4qXvK0ZVhdhhmp2L4WdXuke1Up4pQ5sYrS7jZ+6IXnavXbInRfmn6KAF5jHtbRgw+3r9nzRZQppc/B9kp8Jrq5oSFHUiMSV6q/Y9HBSTc5NZAA3OpGXz+l5dbYYI6M1BB2OV3/SM8KKJd1mjJW6WgNMI4T7ZMU/19WyMQrXThfP1kZIJmHVWlDsOd0nIW3/C61hIqsXPKWwr7KqnzrkdSv1UrjkzE5QFrWF1cPqM5x4VPxl0PH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(16526019)(4326008)(2616005)(478600001)(956004)(1076003)(8936002)(6916009)(2906002)(5660300002)(66556008)(8676002)(316002)(66946007)(6486002)(66476007)(83380400001)(36756003)(38100700002)(38350700002)(86362001)(26005)(186003)(7696005)(6666004)(52116002)(357404004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WmlJqIeJbgYORXwOuCqggtRXSBSAt96521hQMPsbm1Mdry8FBMg71eMrBJxD?=
 =?us-ascii?Q?rE+T4bzyh1BDav/jsmlOv7y4Fdu5K8Lx0M5U7CMpRpTc8uN8vKubcBC08YtM?=
 =?us-ascii?Q?Lk2hcE84258V21oEXJqzh95gecPM4EmRpOqrK8HXAT8unk0kwz+V9Lt/paSK?=
 =?us-ascii?Q?vowvNiJdYVpSR7/muD+2GuHiIMGiORi9Ms2gA7RvcxA98B/De2l8kPR9lm2n?=
 =?us-ascii?Q?yzOoEtyZm0FphLKCxEZUGggHHB0/NpndjK4Bs/Wan/0+Bk9xjQLdb3yDl4En?=
 =?us-ascii?Q?V7aBjzoGHz/M3tbwdPWDq1QvSoeSIV04ea7KXzni/gegt1ju1CdvIZcYFIo9?=
 =?us-ascii?Q?tM4AgBgv84xBj0tKd3ogfMwk/txd81kCCPs1LwmG6DbN1banJrfr2LyNpSvI?=
 =?us-ascii?Q?gx59d1uvF1m2TnjlG4H893eNPqlIIg0+ICVwwjqEru1XQkyp6ATJVqeKFjqb?=
 =?us-ascii?Q?Lozvv8hJC64QKxlc5k/zJGuoXUkaFr9xIYKJg90EVggKeQA7ayY8SACJU8Z0?=
 =?us-ascii?Q?gIds3iiOf0JcsJiRZ64wQyCx2q5M284VCERdhuBOUr2vdEmPT7WG0WNuUdIO?=
 =?us-ascii?Q?X7kZy6kuf9m8G+2vwpZqMw+Dv5rgYQqAbPZQ7Q4ix0pS2FfflIecqXX95tSz?=
 =?us-ascii?Q?Mj0RJLUqqGiVqBVoG/D0WxUAtgFilLWslMvD0px3Yh06HO7tbzsyInqm12IW?=
 =?us-ascii?Q?0gM25DnqgNy+Xsu3qw0yfXkz+8H1x1kv9Urq4l4VlINBm2Y4WgstOxpWoAf+?=
 =?us-ascii?Q?+fsaXl0e8BygLCR3N2IMX7OJoqlfpfWmY2sMbPC8bsdqnx+1v/+EexOei3yX?=
 =?us-ascii?Q?PTjNDmzBKwaLo27xwOfSof/OyCs5YOzRM8KahJh37KjkxbQfqUy/WGQRmHHG?=
 =?us-ascii?Q?ACDUHiPI7mMAkkHinEX0783umOL8CUro5gOnoXG272JP2HnNfi3BFNRyvz9S?=
 =?us-ascii?Q?gKabCEC8FuAZY6D+V8JhT3s4HOw/YdZmNJTyVyLxjkGl3oF2HVmstWehS6Vb?=
 =?us-ascii?Q?blfrlHg8mg6odmrgrSZ6NzIEJH9hGctppG0JvD529/L9QptJfadXNENyGGGt?=
 =?us-ascii?Q?pRtlWV4oIaiUEmSN5QdtQSZ/ZDMQNOqC/SZ9c878EvnJKFdxj32YmWuzSLKB?=
 =?us-ascii?Q?RbQ0xGqd4fcTPYd+9zMJLqbRIFYzqCOJg5gLhHD9jCfYad2V96kMyEd/bLVY?=
 =?us-ascii?Q?Zi68wVsof8Yw9ZWXh0s9HYol2xmfEI07ANZZSL2mSLj90127c60Wm7Hwholz?=
 =?us-ascii?Q?sdAQ6LzCjNHVr4YV7g91BP27vxvaXFwYRWI8lmvkKgFGosmBQZN2a+BvKN4l?=
 =?us-ascii?Q?geYb9IHolB9/FPhOEYwkNDl4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21c92ec-0ba4-45f4-c119-08d91a755805
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 03:22:34.1466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaslHHdWzuu/+ZOPoWJSESmIwPtGm4x8nRWTxo1eqHkZfDvukuPzkehncbL3wcHY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5491
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
Cc: felix.kuehling@amd.com, Kevin Wang <kevin1.wang@amd.com>, frank.min@amd.com,
 likun.gao@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1.correct KFD SDMA RLC queue register offset error.
(all sdma rlc register offset is base on SDMA0.RLC0_RLC0_RB_CNTL)
2.HQD_N_REGS (19+6+7+12)
  12: the 2 more resgisters than navi1x (SDMAx_RLCy_MIDCMD_DATA{9,10})

the patch also can be fixed NULL pointer issue when read
/sys/kernel/debug/kfd/hqds on sienna_cichlid chip.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index fad3b91f74f5..d39cff4a1fe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -156,16 +156,16 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 				mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
 		break;
 	case 1:
-		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA1, 0,
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0, 0,
 				mmSDMA1_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
 		break;
 	case 2:
-		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA2, 0,
-				mmSDMA2_RLC0_RB_CNTL) - mmSDMA2_RLC0_RB_CNTL;
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0, 0,
+				mmSDMA2_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
 		break;
 	case 3:
-		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA3, 0,
-				mmSDMA3_RLC0_RB_CNTL) - mmSDMA2_RLC0_RB_CNTL;
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0, 0,
+				mmSDMA3_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
 		break;
 	}
 
@@ -450,7 +450,7 @@ static int hqd_sdma_dump_v10_3(struct kgd_dev *kgd,
 			engine_id, queue_id);
 	uint32_t i = 0, reg;
 #undef HQD_N_REGS
-#define HQD_N_REGS (19+6+7+10)
+#define HQD_N_REGS (19+6+7+12)
 
 	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
 	if (*dump == NULL)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
