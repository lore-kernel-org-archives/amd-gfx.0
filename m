Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AAEC47097
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813B761C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813B761C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C796ED6B;
	Wed,  2 Jun 2021 16:49:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 389616ED1B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPOrA3fLgFdT1KZpoK1BLkClISYjWlKNyiJLy+1c+VTWjrKD6goWDMV8sVKPTaGt5Y3M4fW1CH3G849aw3LUPOsZTCxhwjJqm4C89tN8yxhRFdiT4Grkq3e884wLqmz+t7lLsWUilIVUErTNB8JXQ/i3igB7SrzAEITADZ8IrN7G9bN60HngViG6TBwJnuCc/ZXcV/YUJuoegV3hpmsA+r3Ameq9+zsVEOqeQych2shmgRN5tp/6Nz2UrVumng+buMgOtRzbb9eEGD41WHXzIqas9efPZGyhDhUvDu9m8bclgb7nStUfOtJgQ8TcedxLNHvpX6GX5Pr7uSjJCF6sUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieF7SZG/vwhNMNCDnYsxnRjyePD8BhrzfRemJsFH7Zs=;
 b=N99TafDLgXAt0Vtgj8j+QKSvGJXejmII5jSigyksAUapTLREoeYIyGV7BvUZQIAU8G/SxhdOH2XRbOxQLIetxnIqUgYJszFOMRd2WqBzzq4nZf/VbAqo74UTFmjnM04icR0vE31GGOOtXVdXOC6AX9liO6NW1HKi+v1txG4UlmSInzvUhcMuDRUlCPvuDiXfwOONP2UlWckwCrlIB1+sWxoC7vdcUeIuTsr5Z6N5wUROhwvdKacgrtjHnnbC+RS5m2Ygog/vByw+p1ispc5HicSIrm7R5Wy+sQhQ5WT3DGsuAeeUFMdagZfvpiab5JHlmsdM5kphqaRGo+bvYpPKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieF7SZG/vwhNMNCDnYsxnRjyePD8BhrzfRemJsFH7Zs=;
 b=sBYO2fcw640Wg85qa6RJBpPvzQVWG6vp2PCSSflQxzwdh/+EsP3h5tqLrZjeSycptPUZZipjBtVOgcB3HVXCPCsjHK6jLctQBTzvZU8Ckbp8RJ3zw/DFIyUtXpbHaF+Wke/P2Vh7b57CPflc4sJBivxY1zEq08Bi4Tv4Lv5x1zg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 2 Jun
 2021 16:49:36 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:36 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/89] drm/amdgpu: set ip blocks for yellow carp
Date: Wed,  2 Jun 2021 12:47:51 -0400
Message-Id: <20210602164908.2848791-12-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 26788b1b-1dad-4435-35dd-08d925e667a2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB407768627FDA345DCE32ECB1F73D9@MN2PR12MB4077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uY8bRhxgdX+TGc6i/69if5yeeq/7Epr0vpNouUr+DmCi987Rpkb2b4h+EkO1XfB/TU1UGO6a2YXBtDRU1Anl/5dh/U73ckvS+Rrb93XTO4BJMmPT6k0Trr+3EaHzUr9FPHgwLMBHviKNyOMyKKXxfBlE8ds0EnGCvlizNaChZYZeN5rVaXRnJ+0h1YrTjVlusHV3IcrzpIdiHwUVmbqO6YWTszbRjuogdf21k2V1HMcXS1UTnpwVFS57K50KGG4QPiVi+boRm0zK8twICxLR8Bl/19Gy0GGHL26nCyqswcvQoEqxpZ204Tz8+zRyQbPB9dbY4o38NEmbYdDylXQWpBSe7aurAcWyXtfyb0XbbSX1FecOaoE7wUjdmCi2x5FRMv3fwrtMUVu57riMufMZYhqBpGIrIOECvpnRUKn3URH4K1MPy83K8qfMCTG2xbihx+rqr6SmJXBkoo0ifhLRERkwMmkZX+C/BZQs1ZgWhacKwAvDqlUZeFXUzndLvj43eDxfNIgnAH1WpxulSB+DS3hlj1c+6Pt39tI9RJAs6pka53IlhftDRznCr6NOfO1Yt8BX5WjFYdLQO6mhRywL8Vc8rg0na9E/lJvvGbjLmyrWKEDJHrItIe0q43le1vmd1a0S9/GzV5GYyRunZbMmKWqWAo0KHdKQguTfN0I+3CYzF7UpbyvDwMGeFjsDzStB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(8676002)(54906003)(4326008)(5660300002)(8936002)(6666004)(478600001)(316002)(83380400001)(16526019)(1076003)(6506007)(956004)(2616005)(52116002)(66946007)(26005)(66476007)(66556008)(2906002)(6916009)(38100700002)(38350700002)(36756003)(86362001)(6512007)(186003)(6486002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Gpm+xUts44w1UavAHcLvvDZGQV2/uJo7BuObw+b50rz/DidX+9i0/3mC4VsY?=
 =?us-ascii?Q?ilKD5DE7za+UQEYxQcALGEn+Oxrl2lvT6V6XKkM4LJPjAy90+Sdue6I6BIDi?=
 =?us-ascii?Q?O7iTICmexzNvAOVR9fX+pKTANIMNGnagwP/Ss3wvlZt9GIxYwV7LpBOjCvO7?=
 =?us-ascii?Q?YeRa60DE1QJxv9BgUScvMo5/ZbmvTiGzGtZ0FGcRRcGvsnTOh/yQcXt9qhI/?=
 =?us-ascii?Q?lY5YSYCC7pJR3pvsg5PtBH4HbaBSeL19584MB97+oUuIkzV/cLA+2EQgw72I?=
 =?us-ascii?Q?RPYf8MR0o3zr3yB+CmMITbZGl8GmIXwOtIUNMZgvaTQA/Z+m8gXs1kyJbH8C?=
 =?us-ascii?Q?uzDDrgLJhOE/PzbVpblWhGyzfsiIxqrMWcxE8cZ0TboHHfL59S57PwsCUV40?=
 =?us-ascii?Q?B0OhAt/O9NC8uUtcj/JB4Ub90erl9WPznhYFwiLAm/vvaj0Vl3QZTOO4Kxn0?=
 =?us-ascii?Q?4eex6x0+VKhkKG0ef85zNo64oufBYZ7u2uSUNeg+i+OzUaqxd/oPYkXTl1BK?=
 =?us-ascii?Q?DT3ueI8K0rrA1y1Eh90njr1MTpYxIxr9uUpTCyDJBgt6btGn0Bd7MwJMjAQB?=
 =?us-ascii?Q?zVxARfuf5F5ShK0bZXqUBa4cKrJhU4S8FSVuBOMQokRGfKwbzAHUN4wI2cbF?=
 =?us-ascii?Q?CuCuMvK5h2tWpsdUTYSq6tvu5tq2ovACTx9Q4hjL5HMqxUcWiMTylV6w+Ii2?=
 =?us-ascii?Q?x+j1WwStF8KAcrcSGLwX/ZHPiybZhTLe7Tp1BizxvaGeCPfFwmXhXL7y2/sT?=
 =?us-ascii?Q?CBwqFWnfTrFA1d3PV6ZaefsuzSfRTd/ySS2kdDYpP1XvigsqMm39K1frtoO6?=
 =?us-ascii?Q?oQ5OGANmlUs32UfMdQJLwis9mWqPE2t6MRBwfVP3qG2rDfqw/lOuvVAOULU+?=
 =?us-ascii?Q?dpuD38ssHas+Faia6+9dnHAeCd5DjESWSGAmPRJvais6NRugOG6XLo3QWCzD?=
 =?us-ascii?Q?OdtiD+CMWSjYPBMWJfinKmiGAXCNQxC//TnBLXQSXBYHn5Vd/S/TF/eQh07p?=
 =?us-ascii?Q?MUApe9egdSZurweY+SNNdpPzldVEpo0VclFZhFNQwHKlWimOPvizgZqSpT/S?=
 =?us-ascii?Q?9sOdqAiG/0BI9uxfqeMaTg/PbADVWSaT+v7a69sBj/SmHjGX2WMdwXvopFV0?=
 =?us-ascii?Q?BOVBU4eYbZVH5X9aMOPANzMBogwslvCtC1dAdVcmiWM2UcXJnxVEl18VY7NJ?=
 =?us-ascii?Q?MsTcaUOq3330NgRDCSoHRO+EKC/t1gVlrtcCoHKFUpoO6EqOIkfvtsdbHmTI?=
 =?us-ascii?Q?cxponDEkED4t0ZvnhKEhXwZFTeTsZMlxZuODq74MdLDS/TDfMbMM09qxnyxx?=
 =?us-ascii?Q?YFxDEpVQa05ByiqrGW5JVfb0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26788b1b-1dad-4435-35dd-08d925e667a2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:36.3494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ircdYhr/cL+TYEp+2/oEj2MScCFuEfNLw0Irj2dyxfzJqtTELL1tKavBlqPRI3XRYflsszY4seVJAUYjxK3AhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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

Enable ip blocks for yellow carp.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 91ad7536781a..d15f99624e4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -988,6 +988,15 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 		break;
+	case CHIP_YELLOW_CARP:
+		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
+		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
+			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
+		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
