Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849F9C43617
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2004B61441
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2004B61441
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D540A6E7E6;
	Wed, 12 May 2021 17:31:17 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65C2D6E198
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO4jVNBPuKNtJsQ1hElFHvWht/UfYd4AK8ZvLtjfWemihQiHqE6z0Zt9ulklMRcn9YW03J4FegOE4K1uMK6OIDXxiQiL8BJ+u/afXj0Z7fJwg5lFWQQHILlo0xbtYBxMOjqUs1yuGH6rEcGfM1i8XvJBGhFavEgiTmCc12U27edyVP2bs6ES6/WCxeT3nSwVlnln4EduqtIqzubcl4Gt3RsRwu2IuxFB5tJ9KOPNbMatRUWcRiiLCOz4DL1vOQJ1nhzMAPkVObE10rDQjiC8+xY2Qln87k9A5SVccdL0XYBUKrNaV67CAVct7gHHJ/loEc/fkiUeV5Ijkq3tcWBcbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9HVvo4YX5euMCXFRhm9gND7h41ISy+FNhA58u1WjWg=;
 b=WxIiD9gYSisvpspnCzUt+lq5/e7JXfpijRc3Ns7cVGguKN/qK3MIa/ucZsgS6LOwuZqx1yIgmUllVJ5lE5sYU5htrN3WRlsGRHeZqKm/f4atxr+o5LPRHAwhF2TQR0fdh17q7EVAhq6ScA78fnzlc0YMOO9j7f/TWzsdvmbjAX/P4bWKqYbFwG52SQUobV3LN2kFnOOFVAAF69NqprNp87981dAsdc+ZeTkW8PGAaZzaC+NytohR7XFmmf8EmJDuT0AAtQ2E1ZVNxPCQe9xq9gZxvPnD6YaERLcpOdsUoFLnWz+Wr1OiZGBSfv94ZoWVmorJuhd/lTHaH7mBOBW6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9HVvo4YX5euMCXFRhm9gND7h41ISy+FNhA58u1WjWg=;
 b=NQcqqesknmqW0LUemrYcrknUXOupB1cbtdS+GqcLFSvc71FWVbL/XoO69UpVW723AXPmpZsY1jjqU8IeXUbYkjiKYCZye9okNru/ChZ+dnOKsD4FFhPBgSEnZFa9dB9FbT+yx9+EEtuByh8mz13XDKVtwqqzI6CoQnjht/+ccJA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:15 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:15 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/49] drm/amd/amdgpu: add support for beige_goby firmware
Date: Wed, 12 May 2021 13:30:09 -0400
Message-Id: <20210512173053.2347842-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fac95dd-82d7-4b8e-8c34-08d9156bbe42
X-MS-TrafficTypeDiagnostic: BL0PR12MB4915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4915A08DEC5E06F3D3B64853F7529@BL0PR12MB4915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dd+cpG7vMAwiNExpQxREoGagPdeUpq60l4Qce/x3FR0WFXfHE9ROxcDdH0BFlKqEpSizXDGNagnnw7kv2B9yaWcwpvySs/Fff3Z8KL154/XRVb2QdjiT2kmhStFlzubXAlXdNh6TpZESoeisr6wIPy/HMbMBDls/pBrCp0+ut32HN9X0LNYdue4Oqy2fQszFRann7o1ytHA1+AAQwqLjgZ/GiLJ9RTHtXOpuXzlGCza0qf3UTULrS7xGxrNt+o/PsiWIWMxJNpnjhZBuASjWiq+Nxide2qxuAQZztpPXsA49VVf38OZ7RjW+MR6r3O0SypW885N/eJ2WqqogdkT6IzQUI97oDjDZJ5gzoqm4vcRzrwqIRvjde3TTpqz3PrFczMHYYgKDOgODrRltzbgxABY948/xwwcXzr1+3tcsDfEmoBshxTaYCMQ8rWvnZBoz6iugu0kCqR7P167IIJNuLY5YoktW1OaGJTXJ2Tdhr+9fuNUCv5YdXIvjvlQePs8vdQ3ZRYQWc2WGIwxlehTmVpMtzVzbhqJ/7fU55BqO/9IuAR40ngly31Q7ku4izCDgsj5vshMr++0Bmw1qsYs2JMgb4RZUu5/deW32K1GRrQWWvJvSLYYQ5xQNxMl91Q9Xkwz5s50Jh2EFJ3RdU1qb7xlTb55zAP56ikNdK0FRRPA6x1s4/v0ZYgEjkhecsvPl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(8676002)(186003)(16526019)(8936002)(54906003)(6506007)(66556008)(478600001)(52116002)(6666004)(66476007)(38100700002)(6486002)(956004)(5660300002)(6512007)(26005)(36756003)(66946007)(6916009)(2616005)(86362001)(4326008)(1076003)(2906002)(316002)(38350700002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?S+n6zmGLxWCVd+k1GtSnxS9aaO+WAGZMBrVQ71la44wjgKytIK4lQlm/+ByM?=
 =?us-ascii?Q?VYuFB662M7+E+rnowyfYhI/X8SmC/Jib1hpze21El5Ejfylj+ZU/RFIVDoIf?=
 =?us-ascii?Q?sMR8H4UzoXLTxm6NQgn/fN4rbBSwvZnByeQQOFb/KBUz35Uu3Xgy9wdrkqYY?=
 =?us-ascii?Q?ObJD03FUlOWP3VY6Ak0yGBFWFt7vkQO2f9RyLoMFME2sn1sPxHzckFzaUPBM?=
 =?us-ascii?Q?t/DeXt2bBJ25b/ffJ8eMzo6Q1dAQ8qOLP1WnyMjLvVdf8eBFTiDSgBUGOIYe?=
 =?us-ascii?Q?B+LNuOOE9T+xCufHyIlrpLEa/duwLflIYMnfeow7KpuK9zx2rI/mpgRpzN8u?=
 =?us-ascii?Q?JRMh1gP7kCTnTqZaVNGxlNDdgJNYwoB7qr7OUgWMQFokhJhUISFPwsQRPlOS?=
 =?us-ascii?Q?tLNzSHE98L/9tMl+blABmyP+Nf+5Ky1h7kh+u0lyU4ZSZJRNtig4mOAw6vey?=
 =?us-ascii?Q?wQwWIuUyW4wtUk1WF9jmeCx8XXYz7tmxGMlTNEveHnBHkj6OuQviT76OdKFO?=
 =?us-ascii?Q?XVOLpa2EHwIRHO6LoJhMppVTkGZWDVuj154BFlU0h52po5EV5IK0U33YwgWX?=
 =?us-ascii?Q?H2GSpoweJTKPT151e8S8v6lviaexA5PowKS55JreeSmrcE3e3xjOwdUuzhYE?=
 =?us-ascii?Q?KrzzM8ESzZybtaHNKsLPP/LPMQ/Ke2u1vc0NyToSzYWte6Fof2wTIBl5KN5c?=
 =?us-ascii?Q?nPi/gFxhS/qwZlso6gY1DGLHmgQyR9jhYyrNyZhfqIATSaCdMBJ1T+VJFqko?=
 =?us-ascii?Q?C5f5sIscrVWhdpOWH3rxtpjxCqZtpkuWbKfOQTkJDctQJt4ir5xnHtZPsPX6?=
 =?us-ascii?Q?2ZDSkzcQd77PILLNsMm2Fq3B95ubJIK6fczn2ono9cAsoPG3FLLymePZcoth?=
 =?us-ascii?Q?1oznNaLAuL8DLJdtyBcs+83SRTQpSx4ansG5g8/J2wu7zPo4dkTZFcaWzeFD?=
 =?us-ascii?Q?xnzhKyerRNh64uesQ0oNHwT5TWMqgoKmAMVchyUaY5QxSEO4zBcQov1O2Ga9?=
 =?us-ascii?Q?YUhyI05VJFSWxHkB2cTLzEpfxDRuqXFtdFvXMb8tEXh6WiZlLJJJGGcpWSRD?=
 =?us-ascii?Q?elEV7WhjR5RdHfsyGbCdpa49MkF5FjbMnUat0hy2dorKNoeq7Y2GOsvsJT+G?=
 =?us-ascii?Q?jPm4uNvw2JhNukIGmaXqZ90GyLmscfAyNsacjWxKN/NpxRDewRVNu2ueCTub?=
 =?us-ascii?Q?vgXbFe282fylMdDiPsA/RLkFzYuE28QwnBav6dQg1aKIQj3lp4hgoy/WR7eP?=
 =?us-ascii?Q?wZu3Uy/Hx57WHxrtD9+iEV+OnJoRf3evPXTzecBnLsFeq71TJ3Rpda1lDnbl?=
 =?us-ascii?Q?IbFqSiyylVf7Dlu0i/MgdSrX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fac95dd-82d7-4b8e-8c34-08d9156bbe42
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:14.9154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfnie7iUUq+pVhH+rSwsyNMZTl9FE7qT9EoUa5UkdAtisYThaDxD3lcuaGPIKfvzhYpvkAlFM4UVHxVAIaqglw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Add support for beige_goby cp/rlc firmware

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 49fd10a15707..b5972ad107f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -236,6 +236,13 @@ MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_mec.bin");
 MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_mec2.bin");
 MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_rlc.bin");
 
+MODULE_FIRMWARE("amdgpu/beige_goby_ce.bin");
+MODULE_FIRMWARE("amdgpu/beige_goby_pfp.bin");
+MODULE_FIRMWARE("amdgpu/beige_goby_me.bin");
+MODULE_FIRMWARE("amdgpu/beige_goby_mec.bin");
+MODULE_FIRMWARE("amdgpu/beige_goby_mec2.bin");
+MODULE_FIRMWARE("amdgpu/beige_goby_rlc.bin");
+
 static const struct soc15_reg_golden golden_settings_gc_10_1[] =
 {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
@@ -3928,6 +3935,9 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 	case CHIP_DIMGREY_CAVEFISH:
 		chip_name = "dimgrey_cavefish";
 		break;
+	case CHIP_BEIGE_GOBY:
+		chip_name = "beige_goby";
+		break;
 	default:
 		BUG();
 	}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
