Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B44C4BA1E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 17:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B091424656
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 17:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j/tHfHDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B091424656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 972E66E442;
	Wed, 26 Feb 2020 17:58:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A3596E442
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 17:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0EoKOalLXiZORW87ovI8i0zFUMoN7OPev8RbOFdeK+fa7Bm8sXdeEOH1oaDDT1PY2OazVOlnT330h3fivwgKhX8THEMT29bA20tqby6McVFVy+vq+pwkR/iPCMzJwAx7o+IbUiJvZuU4Zvx4qCBudPyyAYu1NeIoXI46YdRveMc8Hl/l0VYm5K632KazQITJYgl+eM5lNvHlJnkiUO/Ijm3sqhsN7j7mIqoqsbumkvGzUd0JVP5VrbD+BLDxQ/eoIf4YPNQCA8bUziuR+7N8PuheZcUoQ90HiUh/E3cP5WyGe6ZkAaIcyWmIt0rbWH5SoRa9x2M0sMYf/mvCDqsuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2nGQn6oE2akkf2ECgn9HhOJViyxEJvqQTYEX91A41Q=;
 b=TBaRPRfg4LAT5XCG1PqKuWe52TEI+sZn4N6eugjg735BWbm+kwk8MzS2cBgD+2gYsesNtZlAZS/Plj+SDuCld3ex2KmsTXZBbwV0/s1cemI8B5noxsApieMD0teO4g49BlQU96WkIQ8mhMnUg4gmA1gUKre/qDDduGqRDG3LO4qkDg+3B79GGnuXy7LKe3q89W72rkBOoorS8L5fMVDbX4VfUhYL/d9U9iVCNcT1zgJCt3WVPX1OiClf3flMZMTLoJKZYbAuj8FDc/pLZvp36sAwMwID+ZmKlI6aRHJtPUJEFIRjfMSaybpZVgJJpn42sPQlZgV1kxixDG8ikXFLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2nGQn6oE2akkf2ECgn9HhOJViyxEJvqQTYEX91A41Q=;
 b=j/tHfHDjAghaiC2bLUj36ZEdUvx3sPDPgi6usdxRQKRIuMavH3v4dIRsOtSj0B4tkgsUjl1h52TV7xsvkNnXh/af/AeGmHMIhmR1Vt1zwXWroab8hlesJCHBU5ALnxZQnMr9a3CALHV9qzy5ZwVnpCvbyJE/roh67neLuR7FdN0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Wed, 26 Feb
 2020 17:58:25 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 17:58:25 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Add num_banks and num_ranks to gfx config
 structure
Date: Wed, 26 Feb 2020 12:58:11 -0500
Message-Id: <20200226175812.31788-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::35)
 To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YT1PR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Wed, 26 Feb 2020 17:58:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b83bf51a-4e37-4bf9-c8c2-08d7bae579f4
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:|CH2PR12MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB39253516078027C8E2224301F0EA0@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:114;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(199004)(189003)(16526019)(478600001)(2616005)(186003)(956004)(7696005)(66946007)(26005)(5660300002)(8936002)(66476007)(66556008)(6486002)(52116002)(6666004)(2906002)(36756003)(81166006)(316002)(81156014)(86362001)(1076003)(4326008)(8676002)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3925;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILVYPt1TCeVBGKMLnSJjxbuF/uHw/rDOmzZ/PNNM1jfFHdbmfFFR/0QhRqwVMYg8qTWp8wUpV8nmQhgQnJd+9BD03l4J/2nnZ6W/yk+XKWyzlvyqnrXrmSl+o0FfTooQQgFDE1pY4fQQr+7vBLHRaMkC9/r+juPQLwA/Q3odq2LRPL2z8XGd628ivav+/ib+56Uf2e6WftcW8DGrEl9TtxD2frkPMD2UZzyMhbD4LB6O70IkAFheFR5O0rfVE3j8Gib3umc4vXnvavexHNwT+xq6dQcZNqWum04wf2B7gR9cmDiR+VsvbdVsA9W0/+Zmxvi1hLUrWnfgITPdyV0ubISmJ2iVmkNudO+o0tAxy5soRbFZV7YlQvrL9jSoPEw+IQ/7D3RO0Lk6+KHAWI5KdSBjx+RZs/inAGebtdoNrHj77K776XJQO0rsD9gwEZZe
X-MS-Exchange-AntiSpam-MessageData: /77S+H7b4pOwVksjQ0mkPIThjP8LCAVScqunlq6vOrfY3GqWNXA/Dlr2vvS7HsfSQ27G9Z7ZyJhufWPix+5B3+4Sw0f+sjBrpRPix+QzrtM/0eK2YzXerEsbFrn2bRdTgukaZ/aoQGR1ec/akuAEMA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83bf51a-4e37-4bf9-c8c2-08d7bae579f4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 17:58:25.4765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeyeATC1HmPldb+kxDpgOPWZRME4k+6znOpUG/9b8MGQ1p4Bip77pS3/6pu8kXpi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The two members will be used by KFD later.

Change-Id: I36a605e359b242f2fe546fb67f8e402c48a62342
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index ca17ffb01301..37ba05b63b2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -151,6 +151,8 @@ struct amdgpu_gfx_config {
 	unsigned num_gpus;
 	unsigned multi_gpu_tile_size;
 	unsigned mc_arb_ramcfg;
+	unsigned num_banks;
+	unsigned num_ranks;
 	unsigned gb_addr_config;
 	unsigned num_rbs;
 	unsigned gs_vgt_table_depth;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 8f20a5dd44fe..172905dadf9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -4338,6 +4338,11 @@ static void gfx_v7_0_gpu_early_init(struct amdgpu_device *adev)
 	adev->gfx.config.mc_arb_ramcfg = RREG32(mmMC_ARB_RAMCFG);
 	mc_arb_ramcfg = adev->gfx.config.mc_arb_ramcfg;
 
+	adev->gfx.config.num_banks = REG_GET_FIELD(mc_arb_ramcfg,
+				MC_ARB_RAMCFG, NOOFBANK);
+	adev->gfx.config.num_ranks = REG_GET_FIELD(mc_arb_ramcfg,
+				MC_ARB_RAMCFG, NOOFRANKS);
+
 	adev->gfx.config.num_tile_pipes = adev->gfx.config.max_tile_pipes;
 	adev->gfx.config.mem_max_burst_length_bytes = 256;
 	if (adev->flags & AMD_IS_APU) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index fa245973de12..e63f98b2d389 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1820,6 +1820,11 @@ static int gfx_v8_0_gpu_early_init(struct amdgpu_device *adev)
 	adev->gfx.config.mc_arb_ramcfg = RREG32(mmMC_ARB_RAMCFG);
 	mc_arb_ramcfg = adev->gfx.config.mc_arb_ramcfg;
 
+	adev->gfx.config.num_banks = REG_GET_FIELD(mc_arb_ramcfg,
+				MC_ARB_RAMCFG, NOOFBANK);
+	adev->gfx.config.num_ranks = REG_GET_FIELD(mc_arb_ramcfg,
+				MC_ARB_RAMCFG, NOOFRANKS);
+
 	adev->gfx.config.num_tile_pipes = adev->gfx.config.max_tile_pipes;
 	adev->gfx.config.mem_max_burst_length_bytes = 256;
 	if (adev->flags & AMD_IS_APU) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
