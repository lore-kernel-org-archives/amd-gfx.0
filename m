Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78721C433E6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B7864DAE
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B7864DAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C3216E45C;
	Tue,  9 Mar 2021 04:10:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A4F56E456
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 04:10:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cnp9s6dm1/X/qhug+g9qejaLGQ7+UKczyqgmNDoGeo7TPKg80WJOnwwW6wsMgcNQ8RfMEeliXTqmeShopbMTu48r1BAoT54/q4YyAyCWkhXoD9rS4C2rq42cJvuUjrK63LaowuK4hlhHpj6X00T8H21SNWicNvb4NFcMjBKfeWed4bI6H4gOyW8zxDmaBhcH8JpkON9bgylNH+B+0OCcCnai0PAGyaAzBnNT516gx8yJFiwoVp2eWRQnVJZ8LtJDOHfLhn9GWtLXd3cbTGyJ19dK9ory6A1WrIxJXqja1mV3uKjVhHJJLzBPwtwz/2LZoqNAeAASjq72q7SJFN1BeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCcuBjD7iY2jeqFwMag7DsmQazp4cxjMypuQcppcbmI=;
 b=GTzhMbBL/vDkJ9xLUt0/KpM8sqFaZ+l1a9xIj78Gr+RSO2DXMT0whWTbl4vp0h/Q/bJ0aqK8IvIg0ysgQpPA1NhiwxffR5w/622C7YU/Lub0P+TXLdxKUrz9AcqhcZNcDuq7ckbE73eq7M06Yr9t8pldGD7gAE1bnU8qs6aPEtx7Yypt9g4MuBeSZHTGb5AZrxJqmUK6qGNwsdK9dNYQwdyD0VvDNeUDHPUOmL9XvSRhZcTN7w16BRu90WD4QF3bKpj9yI1NCOuOcQ5Q6/bym/2d+l6FALWL4WPUHBkrAsoZTHcpONUYbmfSDZF5ZJboPTfWAigvBykbLYPWGAH+Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCcuBjD7iY2jeqFwMag7DsmQazp4cxjMypuQcppcbmI=;
 b=MKNCyhTtSjlBRu8y1FZzw+A7dFpSB5dB/XrFz06rYe7FjS1tlXsRFDTzxxQzLSLZFhFuJM8rt6vckaWP8jktq1X9sqKa3iEDma/wWl7mBG9ENxDC9SIJlR0qhgxD+TZ5+rL84PBP76n3W8LLgIIG1pZR+7SvWXAVje5Z4yiA2B8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Tue, 9 Mar
 2021 04:10:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%4]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 04:10:33 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/7] drm/amdgpu: track what pmops flow we are in
Date: Mon,  8 Mar 2021 23:10:09 -0500
Message-Id: <20210309041012.23367-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309041012.23367-1-alexander.deucher@amd.com>
References: <20210309041012.23367-1-alexander.deucher@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0389.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::34) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0389.namprd13.prod.outlook.com (2603:10b6:208:2c0::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend
 Transport; Tue, 9 Mar 2021 04:10:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46a43962-a6d6-4d6f-db54-08d8e2b14878
X-MS-TrafficTypeDiagnostic: MN2PR12MB4486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44867A00FFABC8C3C8C73E58F7929@MN2PR12MB4486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X43E7sKjCk/NqQX5NR4pIfyBi9Wrv7jgsrbfwSr9Hp7VZcQPNDZLexwrSjbUav+bW8oNwcBaNW+z16T8pHLA0BwyQ5hiPA+GwRds2Y+dpsN0RSqLc048naLeVkJ4gs3Gj6kRuSjiadfXUMHOJ9AoicBXKLQStB4MZs9lBCLKuWsoLiTRgdq2bWEkQNgY+at8TQucuG4Ed8VKjIWVb1GVwrpoq+DpasfHoGLmD1eInfxM154O0eJ8fxStZ3wwxBgLJP0T/fbdzr7Z9a7aMLWetI+Qx8Kpw4Z7BpmyDXDiArDw5RF+yS9RkE2H/ZBP9rJvClls72GVFup90+GZqZ2PMlWl2vqkJ2vmLt1xq0u9ELwAXPElpwTm53ML85Xtm2gS91cgF8qX+LH9OmeCA51IRZacLLHDhenaUZOvb70U1pIp5ObjtUwRuNSD/Sj3kkMwlgfVFzqf4N/+okHuQPanAzxyym5XIy0VSY2Onm2k7hy5bAt36nUaVPuLJiy7k1ryka4IiHJIu6JbyGOr0QQHMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(478600001)(316002)(66476007)(5660300002)(16526019)(6916009)(8936002)(26005)(83380400001)(2616005)(8676002)(186003)(36756003)(66556008)(66946007)(956004)(86362001)(2906002)(4326008)(6486002)(1076003)(6666004)(7696005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Qc3aOdTGyw77t8hnmUwd7a5UoL02p4yuhKRjt5Huw4se/qqd8xLjBqpySycT?=
 =?us-ascii?Q?kkq1Jp58E8SoVUudDDEeHt5IpL+0LjIS4dwM769qOGF0uLMSdRnhgEQZiO1e?=
 =?us-ascii?Q?cNEJ8SGq61u2OdCkXmnMY1XgsjMG1zZMe5v637yHZBkTN5+uS/jtuVJ2/Ev0?=
 =?us-ascii?Q?bUD8L72vfMNi9YeYVo43Psrt5fuhpQcxqy7FxAGZ+4p6H30RGrsptodoHPMC?=
 =?us-ascii?Q?nLbRXI2pX6svTrkrmWXW25O7rn2x0dB+rW0GdumjMyuTTNFcPGcUt6z6Jxlv?=
 =?us-ascii?Q?yC+a3hDF169IIU8+rycW6ZFUVbcadqAaFShSaVqvgRRqyI1LlrTW+HxeEdif?=
 =?us-ascii?Q?0ej5cHRHAj6Q+aq2gDqDVORwxdw2aNAW9c0tIq/jU+AYsaVhgRDDIVZunvt+?=
 =?us-ascii?Q?mzhX0HcjnsCfF0azkj1GSGVG4pU6J7lpcTUciRc7Z1PnfBqC6ojYRbtNDi3X?=
 =?us-ascii?Q?vW8gmuWDuVtL6+y+ERb1UKqunmG0+/KqOtnMGlMuwlQKqCMNMNgNUTwrgwb7?=
 =?us-ascii?Q?05LhCHh9torngjB9yYljY+DlaIAdcT3mba7xq0J4cdk0tqGvJAsAMQj33uaZ?=
 =?us-ascii?Q?3h6k/tQvUkqtKYjBJDswxKncsUcaSNKyJqxxrPXK946diJ76vvKHQvH37RDY?=
 =?us-ascii?Q?DcLXEDyPNdCor2kUiOPECeQlOTGYz+boyG3zGqFyqe9GtZbcmqFsZjg6JQoV?=
 =?us-ascii?Q?HZ/tHFzlA4qwaQpDK0dJF6XrP8BBG5CNtDVRkjiP9jfZ1XQfNdfHc5thZxw1?=
 =?us-ascii?Q?y1OF85Gm4g36eLHfHACDzZX85shoT+TxXWvHG/hA1+v9WGDMQL9EYYDDQ21C?=
 =?us-ascii?Q?cY2zVIcB1XYM/Gn7f5D02XpEzDeSoDxtTRFM/GdgMZGzBE+FE4KrEF0B1Z9r?=
 =?us-ascii?Q?6bbjU32r3yBzK3NEyJoD8KRIdWcvC++9FYE/LrxB6o8ZIC/l4UtTEVb5jS6g?=
 =?us-ascii?Q?2ESd6E2tD3vnv5KtT9PQDAsjCKBPALsBwQYqXscHgg34kxv/Bm6h8Y5SxPnA?=
 =?us-ascii?Q?uhbkITzYzNxqLrTsxbCt1fCeaW7ipikRoMnaA33WJ9lq7G1pudssuW4j3PHR?=
 =?us-ascii?Q?zrsc9F9n4YSJ8exnTHuOnYtzSu8Ai2Qnr/hxD99nYfgTAlPFf3DxkgV9iJbm?=
 =?us-ascii?Q?vgLVMjM4Dt9o8ZykhCldp0E2engRt76M/y70pSNERZ5IheEkxnnxfG615Pg7?=
 =?us-ascii?Q?uLplzFG4dzJhI2qT9oTt4ToKyyLh1mnuV3F0DiDQzCKX2ZleZxPdfqA/Q9nD?=
 =?us-ascii?Q?5ydGBUrXDm40c4moCsLE07KRENSbGct+D5Z5KKCY2EtW84TcxDmgU0R1KjuQ?=
 =?us-ascii?Q?ijd3UhHJ9zBooyK71Eebn2uY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a43962-a6d6-4d6f-db54-08d8e2b14878
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 04:10:32.9418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXC7v26xTh+gNs2OtltSHE3xXkgj70k95qc9fUE90T1FJKpiZqAElUXWPg06A36Qx5mFkXMLP6qmJQRS7qvXYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
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

We reuse the same suspend and resume functions for
all of the pmops states, so flag what state we are
in so that we can alter behavior deeper in the driver
depending on the current flow.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 20 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 58 +++++++++++++++++++----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  3 +-
 3 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d47626ce9bc5..4ddc5cc983c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -347,6 +347,24 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
 bool amdgpu_get_bios(struct amdgpu_device *adev);
 bool amdgpu_read_bios(struct amdgpu_device *adev);
 
+/*
+ * PM Ops
+ */
+enum amdgpu_pmops_state {
+	AMDGPU_PMOPS_NONE = 0,
+	AMDGPU_PMOPS_PREPARE,
+	AMDGPU_PMOPS_COMPLETE,
+	AMDGPU_PMOPS_SUSPEND,
+	AMDGPU_PMOPS_RESUME,
+	AMDGPU_PMOPS_FREEZE,
+	AMDGPU_PMOPS_THAW,
+	AMDGPU_PMOPS_POWEROFF,
+	AMDGPU_PMOPS_RESTORE,
+	AMDGPU_PMOPS_RUNTIME_SUSPEND,
+	AMDGPU_PMOPS_RUNTIME_RESUME,
+	AMDGPU_PMOPS_RUNTIME_IDLE,
+};
+
 /*
  * Clocks
  */
@@ -1019,8 +1037,8 @@ struct amdgpu_device {
 	u8				reset_magic[AMDGPU_RESET_MAGIC_NUM];
 
 	/* s3/s4 mask */
+	enum amdgpu_pmops_state         pmops_state;
 	bool                            in_suspend;
-	bool				in_hibernate;
 
 	/*
 	 * The combination flag in_poweroff_reboot_com used to identify the poweroff
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3e6bb7d79652..0312c52bd39d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1297,34 +1297,54 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 static int amdgpu_pmops_prepare(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
+	adev->pmops_state = AMDGPU_PMOPS_PREPARE;
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
 	if (amdgpu_device_supports_boco(drm_dev))
-		return pm_runtime_suspended(dev) &&
+		r= pm_runtime_suspended(dev) &&
 			pm_suspend_via_firmware();
-
-	return 0;
+	else
+		r = 0;
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
+	return r;
 }
 
 static void amdgpu_pmops_complete(struct device *dev)
 {
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+
+	adev->pmops_state = AMDGPU_PMOPS_COMPLETE;
 	/* nothing to do */
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
 }
 
 static int amdgpu_pmops_suspend(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
-	return amdgpu_device_suspend(drm_dev, true);
+	adev->pmops_state = AMDGPU_PMOPS_SUSPEND;
+	r = amdgpu_device_suspend(drm_dev, true);
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
+	return r;
 }
 
 static int amdgpu_pmops_resume(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
-	return amdgpu_device_resume(drm_dev, true);
+	adev->pmops_state = AMDGPU_PMOPS_RESUME;
+	r = amdgpu_device_resume(drm_dev, true);
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
+	return r;
 }
 
 static int amdgpu_pmops_freeze(struct device *dev)
@@ -1333,9 +1353,9 @@ static int amdgpu_pmops_freeze(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
-	adev->in_hibernate = true;
+	adev->pmops_state = AMDGPU_PMOPS_FREEZE;
 	r = amdgpu_device_suspend(drm_dev, true);
-	adev->in_hibernate = false;
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
 	if (r)
 		return r;
 	return amdgpu_asic_reset(adev);
@@ -1344,8 +1364,13 @@ static int amdgpu_pmops_freeze(struct device *dev)
 static int amdgpu_pmops_thaw(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
-	return amdgpu_device_resume(drm_dev, true);
+	adev->pmops_state = AMDGPU_PMOPS_THAW;
+	r = amdgpu_device_resume(drm_dev, true);
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
+	return r;
 }
 
 static int amdgpu_pmops_poweroff(struct device *dev)
@@ -1354,17 +1379,24 @@ static int amdgpu_pmops_poweroff(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
+	adev->pmops_state = AMDGPU_PMOPS_POWEROFF;
 	adev->in_poweroff_reboot_com = true;
 	r =  amdgpu_device_suspend(drm_dev, true);
 	adev->in_poweroff_reboot_com = false;
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
 	return r;
 }
 
 static int amdgpu_pmops_restore(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
-	return amdgpu_device_resume(drm_dev, true);
+	adev->pmops_state = AMDGPU_PMOPS_RESTORE;
+	r = amdgpu_device_resume(drm_dev, true);
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
+	return r;
 }
 
 static int amdgpu_pmops_runtime_suspend(struct device *dev)
@@ -1389,6 +1421,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		}
 	}
 
+	adev->pmops_state = AMDGPU_PMOPS_RUNTIME_SUSPEND;
 	adev->in_runpm = true;
 	if (amdgpu_device_supports_px(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
@@ -1396,6 +1429,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	ret = amdgpu_device_suspend(drm_dev, false);
 	if (ret) {
 		adev->in_runpm = false;
+		adev->pmops_state = AMDGPU_PMOPS_NONE;
 		return ret;
 	}
 
@@ -1412,6 +1446,8 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		amdgpu_device_baco_enter(drm_dev);
 	}
 
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
+
 	return 0;
 }
 
@@ -1425,6 +1461,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (!adev->runpm)
 		return -EINVAL;
 
+	adev->pmops_state = AMDGPU_PMOPS_RUNTIME_RESUME;
 	if (amdgpu_device_supports_px(drm_dev)) {
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
@@ -1449,6 +1486,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (amdgpu_device_supports_px(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
 	adev->in_runpm = false;
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
 	return 0;
 }
 
@@ -1464,6 +1502,7 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 		return -EBUSY;
 	}
 
+	adev->pmops_state = AMDGPU_PMOPS_RUNTIME_IDLE;
 	if (amdgpu_device_has_dc_support(adev)) {
 		struct drm_crtc *crtc;
 
@@ -1504,6 +1543,7 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_autosuspend(dev);
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 502e1b926a06..05a15f858a06 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1327,7 +1327,8 @@ static int smu_disable_dpms(struct smu_context *smu)
 	bool use_baco = !smu->is_apu &&
 		((amdgpu_in_reset(adev) &&
 		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
-		 ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
+		 ((adev->in_runpm || (adev->pmops_state == AMDGPU_PMOPS_FREEZE))
+		  && amdgpu_asic_supports_baco(adev)));
 
 	/*
 	 * For custom pptable uploading, skip the DPM features
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
