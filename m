Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4D6C388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 06:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365152065D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 06:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gCQ7pluX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365152065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A04C89838;
	Tue, 10 Nov 2020 06:30:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 721E789838
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 06:30:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxQWiGb6IPgQVsOP2eqsRl0RXT/aCDW/8DLMVbEotrDZFzQW8XdAwdvR+2yXcGrfB0PIe2eOtlxrf4wg1Xhs3eiUi2LkLPtdPLAuM44ssM3A9UknNQ7H8p2FhGbt1g4pmizry6AZ+6zrHOIxwau9QaMhOPtTQjygHbckl2vbLEMAuB7wHZLmcuczgNT5PfyV0bUzKKKWxyWIZnMpKEh9RtJROgnLwmMuZy0oYuN2nd8twoQv/hCZL91LIfpaAeMCfwHvYRw0K5L2gx8Y6IYFRmpsf5lqiD0bVhxq4/HGzRfwbYfg6O05vcjyih+xZwYVl3MuScFnWyLKuV0sVO6U0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6BEaPETKE4Q9iG/KXIrhEaM8PtirrTmM2aGIj/G2Xk=;
 b=hzg/40XUB95j/Ii2ibKQ6XBg54/cmeO6/qcG0DUPvoMx/SrSEV947TWlBGRpKGveduThDMQ+6FeHSRK/Sr0zvE1FRr81+lsPGyfYNz09AT5ZbpZZNthR3mfgYgK4ojTaYfCabo7/+QtmJHUaGdYuWg4DmCdeJQTSo/RSmVEiQg4NWq+K4yzhUJP1O1TdhpASJlvjv9YRL1DVqITtdcB/iVT4JNU1o31m28mHjAfupOHbV9sTc03Un/Bb2UZDarsy5AkS2miCQhWCFlrQsCYlyN2CdCXtuOUGsYOU5TeSlVHN+pQU1+7+K0OOPVKMICSzWLcaEW+MxZ7hzFoX1KTRoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6BEaPETKE4Q9iG/KXIrhEaM8PtirrTmM2aGIj/G2Xk=;
 b=gCQ7pluXzX/y1iJQZOmwiKa2ytqfwYhe8018e8H3S0lS/GMoVyuUMStsYiJAXVUNIy9ZKdMx1laEbJfARE7G6s52n1YgP/ADomRXCU/00FJSXV655jjAN/oAIJ1m17wmxyY1n78r2YK3nH0h4mvqALi9go4yXiSp7z4uY0+A85g=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BYAPR12MB3542.namprd12.prod.outlook.com (2603:10b6:a03:135::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Tue, 10 Nov
 2020 06:30:27 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236%7]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 06:30:27 +0000
From: Tao Zhou <tao.zhou1@amd.com>
To: jiansong.chen@amd.com, jack.gui@amd.com, hawking.zhang@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: update gfx golden setting for dimgrey_cavefish
Date: Tue, 10 Nov 2020 14:30:12 +0800
Message-Id: <20201110063012.22549-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0401CA0024.apcprd04.prod.outlook.com
 (2603:1096:202:2::34) To BYAPR12MB2888.namprd12.prod.outlook.com
 (2603:10b6:a03:137::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from taozhou1u2.amd.com (58.247.170.242) by
 HK2PR0401CA0024.apcprd04.prod.outlook.com (2603:1096:202:2::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Tue, 10 Nov 2020 06:30:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9d3a013-e3b0-4fc8-2bd9-08d885421cbc
X-MS-TrafficTypeDiagnostic: BYAPR12MB3542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB354296B12F55623F00D7FD58B0E90@BYAPR12MB3542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8misvH1rPBQSQuCr3qFeZxPX59XsbAdMN53Qt+3Suv11oh3q16nJenA8mg1jtlyPJ3i17/9NRSZxm0z8H1KgkAKo8zExG9nEhOh4sNYLXFOY1iBqVyZUzTS3/lrceUrtsoZJgUDV/0IDrpSnu7PEmjjN/AbRYkjnlsa2bUZJy6E03DMmh1C/Hrlie8tUP7/F2OcXEsb1tyYmkHc+tHe7VusLbYErFs7ylzL+HO+wErOKUCaW/A3avfN63am/BWiNdeQHVcFzn21dk6IeRT9lnwJcnZ+j/lpYxy8ekSPBcLgHXPWfRZbArVi9gRn1XwyoNC1LDdfBcW09FoTcdL7Dlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(186003)(6666004)(8676002)(4326008)(86362001)(36756003)(2616005)(7696005)(5660300002)(316002)(52116002)(956004)(8936002)(6486002)(83380400001)(66556008)(4744005)(66946007)(66476007)(1076003)(2906002)(26005)(16526019)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RtowU9DQ02ZFLje4NRwmDtNhgJzUWt9Ujsn0fwv4SQ7mfArviyLk30LDJWo9iV89Ku0KhcwA+mTu82x5c0PceaQHV/vfgtiTrnMF5jliTgPUD+3sZJTljoo9a3pm0II8DxJPZ1FD9ibiffPzfIixQs57IwdhYAvC+a8bjBQf6qVoBUugn8TDZtdpo6wRHR8t2NdBufiH3jtT1m6qDERC10u1w4//tJreWJ/tK6fNHruuaxCKNGnl6bzGDiYmhdx/d3o9PugyfIFyD4dD3yD0cZbBLxQnsrsOFedb9bNm7Mg9c/Wdin9/VawNIXz+a1+rqVqOsunxHVkakv/7U0p5U3+YcMTx15xg9420BRVBLbhKi8mGKp6R1rxzByGWQtLCJ5sD9JGaQWCk9G1gKSgNe7t+IP9ioqRfKL6fWWdNsUjiYMTh3wU/VDcpoRaYgKs5XMPFuwEkUXPJVv8HrgyQxjvqmoAzrTqxeRV4jOetLfsEhUPpPhkIOPivZiyUdSiej8hXfSdIFJfIkpFZoFYW+FnwA0IZqcX4gcXx0U2DZw4t4DEBWS87a0wVWyX4UgF5qiPVMpKh3oyJaE0ifunxF2+DJP4H+79a35EJJb5xXrsnOijBR+0ErrFp0qd52j1y1j1oHicq9Tm4iEsaam/72Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d3a013-e3b0-4fc8-2bd9-08d885421cbc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 06:30:27.2513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHK7NaTYqmRxok4LEKG/41qzIq6sM2LbLD+WgRpULTZkNDumdRYSLgY7+wQa7/yE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3542
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set LDS_CONFIG to 0x20 on dimgrey_cavefish to fix GPU hang.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8c3bad3dfc01..e068133aec71 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3286,7 +3286,8 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_4[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER8_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_PERFCOUNTER9_SELECT, 0xf0f001ff, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0x01030000, 0x01030000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x03a00000, 0x00a00000)
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0x03a00000, 0x00a00000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x00000020)
 };
 
 #define DEFAULT_SH_MEM_CONFIG \
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
