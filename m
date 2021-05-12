Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90405C18E7B
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37CB461432
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37CB461432
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B85546EC61;
	Wed, 12 May 2021 17:31:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E615B6EC6C
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVhFsDpB4xf4hF1nTRUpxFNuQrYiOHuXX0Q8+m5lXDhpCs4cqmk1QKEUYdtFwE83SJ+86ElxQWiAmngWypFcMJJMRNRDGDcRnvjHKydA5zVSBH6MAlrV5VnbqYPfE/dYfBrFghAFvmcE6SUoDanA/D3+Ds4g5Hz90bOjizG2RraIruzcvFFNhIm9kDAr47xSGpWUTynstM5rv8Rb6S/Lg80BJqqGfN64ebDTt2/dMycI0L8SsicazpMHtNXSrCZxy4+bMnoaghFSPznAXWM98EhNtMOvCq/Pmek9xFONG2kqq/IVSPm763Hr8miMJycVOKT4HgShOoO5y1T3CQWdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnCwJ8q18d/KQCN0HNHGlnojcOo7VUzWf/orcE2nBQc=;
 b=lxmMePrDRZT/m2pw62B5P7E3Vowxz4TQNp8AY/R2ldnf7QM2OheLL6uDAo/bZLFP60po+4YYmbPBcuKJeTgOunrtk7vKqh0oITAGnYOOZK21Cfn825dt5DVHVasuIBa6dMRa7NQWn6caT+lcrJo7BPBRb0CAcHi2vCqmSNaaNrX93n5t6UKUXqC2XoBqZEd9qbqQ7A+piXN2Eny3y5MgLkBgwMA8M4dSDHByu6XcLM5rARtnvJxY2fdpj5legrDzWiM05fSyFveW17PWe1V8wx38A0kiLDRcIDbe2oHNnfGR9/f/5PtJkcY8hAxPtka739u8GYs5EwPuQLUcuCDwMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnCwJ8q18d/KQCN0HNHGlnojcOo7VUzWf/orcE2nBQc=;
 b=ImcBjXTOfCozhlf7/S5Gpb4u6m35OSVloVaa60wM28AUyvqCvv6nGveN/Q0vukDJWswgGwNJflDsP9o1U2rtlcAIzotgTVNZkLEEmA2GV0MBp/WIDzdC9rWTPyL0n54W6HzbGt3J7DkU8ztZgVr9g7HFHQVcV94aPn752i+vohE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:20 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:20 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/49] drm/amd/amdgpu: add gfx ip block for beige_goby
Date: Wed, 12 May 2021 13:30:17 -0400
Message-Id: <20210512173053.2347842-13-alexander.deucher@amd.com>
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
 Transport; Wed, 12 May 2021 17:31:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbc0143f-a7b8-4690-1b5b-08d9156bc1a5
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB23402F46E8D4C94F8CE1D84EF7529@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PsqU8ATywVVPcqA5BLp/PBY9bN0vB7uLvXkBi2BQ3yRf6SwMR6kb7tUcI4LvsnoWX2NcMUGVjnYKNt2Q3veYHZZKq111qcT453ICUD1P9JvgRW36PC0Gh4k3DKgn+qUGRrFbs+R9TdkVpDvqddhBu6FZshoGTZ/awxMNRTB/FnTNgPyRiIK9vcfJZtCsytOTVSE6c9uPXA5dTQK//oY9Qn/Pt4mK0XK7fGPf2oWvWnVgNBoaInxq43YyWuM3i1tBfpB5Wo1FWPMecS5C45tsTuO0A5P6KtmunXRTOoltO/FxCdkF/TgaC/kCX9tKxFVGQIE2+4dTfZaFRltAXAHlgTFpzyU3VI7TS1YlWx4KIO5yqAlcjFM4CAeJsOLRTy5acL+oelEEBYQB8tbdNUqgPBNbceScWtYN0EfJwFMBtILqMUqh9W00Ec2j914QvNcHX7ygAyM/5VA/OUzGyII/8jwCG9LFgU6B1NnVsdCFRifHcolKOU6842GWCllnMAl0M8BxSlDuWZhkFwHAJuvAc47VLChEwSx0qCt6P+9QI7pHSxa/1//aoPDJJyExYD4JwEgkXYDLYpxaMW0LyV5vQzzLT+eRVBAwNuv5GAubaSGL8HKF4cQrrSAidEdZ7njX6Mmfg0Mfq3MoRArpVyckEh/jooRH2OGI2DCGqkiAdTqUSZsSj7HdwP+eC8lFBypb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(6666004)(6506007)(26005)(38350700002)(66476007)(38100700002)(86362001)(4326008)(316002)(478600001)(2906002)(8676002)(52116002)(66946007)(66556008)(36756003)(5660300002)(54906003)(6916009)(2616005)(956004)(6486002)(8936002)(16526019)(1076003)(83380400001)(6512007)(186003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0RGccsrzw+DZUrhe2op8E7NQsSHRa4PZl06PzEfy4C7OwGSoDux70V/2ri1i?=
 =?us-ascii?Q?TqWIxuReU82FS/U2SOQeHKj7/r10tJxsa0dxwbI2A9jsykPVgCm3LFH6pb3P?=
 =?us-ascii?Q?pP1kaR8G/rjRaFm7z2dl/Hv91pAhalxIKgSB10Dd6hEXIaoCZ2mIxq1u/mrW?=
 =?us-ascii?Q?lEoCWB7dVVEGwdD/ZY/2+aViEmRVG7WcyLa0eYXoWs9UdAkFJggvhKm+941w?=
 =?us-ascii?Q?o3yLuf5mhXjmnY4tkJ35Uvdx9GWOrq+1fNpHsoRwZpdq9KHCygtJNvYTHri/?=
 =?us-ascii?Q?dDsIpQEff2g1s62X1zi6EWsP5dR7xZNlCj+TR72Z8gLXOdC4woanInSQURk6?=
 =?us-ascii?Q?7sawyNcUPR2mnq1/vUdCVFdGMly57mPxcCM7Fh4lnVm6AiO61oHin+NnHOCN?=
 =?us-ascii?Q?e9IxX8XkawkTvirkXJ5leBdGiCD6T7G1xNgIMg4EBxPmPdnQv/Xhs/C71SYv?=
 =?us-ascii?Q?RmPMllgvDW8iZOn1xjsj6Ja3VYZXU00C8EL4cnnVUN/quYtRe5ZbSaukJyd1?=
 =?us-ascii?Q?LL3ZZSYgFbrc4SuOmxOkdrTEsWsV70C671zmWQxX26v2+aKMm6Z6SxioT7Cv?=
 =?us-ascii?Q?qp9wjbeQlvOikQPVneIGeOFSHXbTQV8DlJ3dkT+5KmOv/j/IsMarbXVB62sQ?=
 =?us-ascii?Q?5T22eslMOLvweTWXoFlCK42dQbiQfJer1hW5oiECPJY7ibxFsSm68aAGbx+p?=
 =?us-ascii?Q?4tP0X0VkNvonSQZz08JGORBz6pr/3msZOK+k5s81eDcGjOaD0DCJOPgO2EGZ?=
 =?us-ascii?Q?SOm3B1RO+5OVqIQas4Xetxpsl+QUducuEdkzxcMOGoLwbu0ssSaeZOO5iJ+q?=
 =?us-ascii?Q?WT739EsKbTUc14LlT1bxWW+SCjPjRMzJDVTNriB8/DoPH+SFOriWBnWTaLbN?=
 =?us-ascii?Q?5BhTcrr6nrt8xWiN24oqS3TCULfSC+0ynYym4RM9iHLvAyJLXcosFL7NHmpX?=
 =?us-ascii?Q?56bztEvFOwWmgyC6Uh7+rE2jrW3NWh8njepGwMJVgrRQSKZypcl6mBJAvjvU?=
 =?us-ascii?Q?tRE4mU17fmvSaPXY4AbRRpjBjskib8AiapoxnpgXCwjklHbzXOgR4bST5Zav?=
 =?us-ascii?Q?P1+zPVWcTvkIcZXNqCRH2HPxIS+gj3QlhjoYpagpWfBf3j+0x5wy43/NMhz8?=
 =?us-ascii?Q?OblcB8aauru/lxDwELlN9M5n5Q1LjtxDiF/xh9rbDckAKTsVNbmnmtM3zMdF?=
 =?us-ascii?Q?25r6Pd6zxcYBSshyn79G0qLyOT29Ff6Lkz2DvK7GmVK/ORB4sGzFe++jfF+g?=
 =?us-ascii?Q?190eApT4l4rDAvY6mYcBivUly/n6Q7vEEHPP1OPhaEPXuiByawRAWGaRallT?=
 =?us-ascii?Q?SgVw+iTxW29gR5+uMNPVXbsc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc0143f-a7b8-4690-1b5b-08d9156bc1a5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:20.5686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgntJuJWDSafd3d/B6d5kbZcWsf+25yyoAGYtCkD+O8B70+uvfIBcBQrIzJt5VmSj7crXKdWMOSkr5jpvYk/cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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

Enable gfx block for beige_goby, same as dimgrey_cavefish

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/nv.c        | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b5972ad107f5..408691ad100d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4506,6 +4506,7 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -4630,6 +4631,7 @@ static int gfx_v10_0_sw_init(void *handle)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
@@ -7555,6 +7557,7 @@ static int gfx_v10_0_early_init(void *handle)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		adev->gfx.num_gfx_rings = GFX10_NUM_GFX_RINGS_Sienna_Cichlid;
 		break;
 	default:
@@ -8040,6 +8043,7 @@ static int gfx_v10_0_set_clockgating_state(void *handle,
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		gfx_v10_0_update_gfx_clock_gating(adev,
 						 state == AMD_CG_STATE_GATE);
 		break;
@@ -9150,6 +9154,7 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev)
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		adev->gfx.rlc.funcs = &gfx_v10_0_rlc_funcs;
 		break;
 	case CHIP_NAVI12:
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index ccc534fc4109..224b2add60ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -849,6 +849,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
