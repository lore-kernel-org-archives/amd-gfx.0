Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD400C388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 17:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5997E20781
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 17:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U5e8xO2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5997E20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F0A88912A;
	Tue, 10 Nov 2020 17:55:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8FC18912A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 17:55:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoCoftPra8V9GGTWCSY09bdIIyOXIejgGITdqL1PBzCoRgYTS/nPpWrBRE8E6a+OdH/FNWBPUw77PXEl6WRzpwaEtxDZwnctRHc+TFnIEjWCgdZh+9518U6RNPnHbug6UvH2Isb0P/X0GhBEbs8eE9mq6xckwvd5MFJfe1fO66iZZVrTQLFHvr3YpamWSvk9SmBG/L1BhSnL4jCXcfcODKlg1+ryfBQaekkrP7fQcm64C54h0rRytsTSkZBAvRKpBvI6h4bEV6RMhPD6ohRXWROzacHwCCLUCQZAPdHYwQkc8d5Hg4URNnOqMnBFiVKtG68HVoEtVI024RWYElTRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fcWXccCKLpMova85WcVhidAVyshd0A1gJp8e8ZHcJI=;
 b=j7ftKablYg3mK7Em/ofVNVI7U2bURVMwmCljJ0FC5vjPivryrdEwfYFppq6JQ2zqx4nY/x3MznD/XBMkF82CswnrERPcrOsjPk5HQBvzeYOgY/+n3W6CKe/5FnI1lZD9LRSK1hwsJc/s/W2TCPXITQVnF/qCJTUv1HKAGUhM8+Ffvp97vj2qCpgSu16i28Bic6GZaVEX7S7nWc48ws6f2KMMae4SD79UjecVDiASrNGEHAQykEdaXs5kqIw8o4PMIdz904vynkxm3X2XZbLEFiVsxKnYJQSXEefBW7rVWWf/2uP/KBukm+CocmUxgpYCCOyPmC9TZntggc63TZHe+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fcWXccCKLpMova85WcVhidAVyshd0A1gJp8e8ZHcJI=;
 b=U5e8xO2sOcVNpf+BT+xyDLrWv963s+RwrsIkuSys3AIIkIfik8W7H/O/M6mKYS8nBuJT4IYl7Lj+E9T9YageCfMB+TVywJLYj+dEERowSO3FeHbOchDGkfwR5LTAVqdUjq0POmZxAB2QxhHmqOrBoWbOpoFZi3cp4MIUE3aTIWU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2415.namprd12.prod.outlook.com (2603:10b6:802:26::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Tue, 10 Nov
 2020 17:55:46 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d436:e21c:e4e8:7deb]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::d436:e21c:e4e8:7deb%5]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 17:55:46 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable 48-bit IH timestamp counter
Date: Tue, 10 Nov 2020 11:55:19 -0600
Message-Id: <20201110175519.21308-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0601CA0013.namprd06.prod.outlook.com
 (2603:10b6:803:2f::23) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN4PR0601CA0013.namprd06.prod.outlook.com (2603:10b6:803:2f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Tue, 10 Nov 2020 17:55:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c9eb659-a005-481d-52a6-08d885a1d9ad
X-MS-TrafficTypeDiagnostic: SN1PR12MB2415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24153280C76A7D59535E2CADFDE90@SN1PR12MB2415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7H8SNp6sGx0TarzUbJqkzGJiw4qBmpT1coiCfeDR274DCEw++RpPohekyEg3Od/owZVgR8hfMCCt8cRT5XCS3/4Q0Dpyf9JQllw4En8TRJvPSnhHK7fQmjeWhiG69InOiYTV0VrxjxNNXtjJSIkSutXtO++tkZ3/1P/LLZ1cOPAkV3pphfnnAIGIbi+nRJPe3VjIIxAHJzLWMXIz179KFxHnzZxTYxlHd8/Z8us0WXD0FM7j4CZqOO6C2oYqFTo2l4G4r4y/8YcKxz6UgLzlXW3F56wdEJzgiq9JVGGbddPUHxN6HMdstSlzU0dN4ja
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(6916009)(186003)(8676002)(4326008)(956004)(36756003)(66476007)(7696005)(8936002)(66946007)(1076003)(2906002)(66556008)(52116002)(86362001)(6666004)(26005)(2616005)(5660300002)(316002)(44832011)(6486002)(478600001)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UwTUYYDHn2pfKxFtew1SvsBH53TCcCnj4EVJHaw+xEX6jZFrULYK++3O0sJLvP0wNd9wux7oetZykVShWoMjKMniU7fuSG7qGNZQMhj6DZzdGOZk1KlVXu3oF22jL2OKFQLGUQQtDnnMQP68tA1AnFZqOJUDhz0/FVb/n2B1UGOwvBd+xHGVhCct1OtvEShfcvqmd1eFB94v5er8xlolo7pflO7mOH2tbb12r3/ivDmCaRF6gzTTBmNt7k+pXkhdNMSF66LDIR60IKMDcwjQGvF5UwddKLK+osxnQ+LSlCvNlx896xCEmsvUkr0mgBysZlbg1uVXZTriXGkMD+12dcX5mtX235cU4Oto3rgaDRPKOz69WRmcWm/njvzcbQEeQBrMWK0Pk/ST4sAoBvdlsLv3GagwKt1z9TgTklJFbte18y7FdJpVM6sSa3UkfIV8CHvY6DV9MzRVsTuDPsnEudMQIY8jx3jwTDXFupldNcq/zWApi+aaSnfeVgqO1NpTGnX5azpBi/DOooWbNmKg4f5s4Fg5mB1LpH+NnPACbU5U79lVPpskFiZIkCt+6WatCe7/s3rVXJB6a4K54kW0w34Jb3cMxcZDxagxgyRBunL+vbprWqQIzuExWpspo8oU9lrjC1MVRn1kyeKK1Phz3rWCrZyhAf3VecCzIGkxNbOp5F7ZDd+vSUuGrg8NXjFG+znzu1LIEwUQTfLYGidSelL3Od7TyXCzff4pWXjROSCbiLCUZzJdaLS8UQ9IEuG6u7O4rACVa9TSADoquqZ9Kg+bBKj6FPgk67rj0DukaifEacd97J1fFLHy/k/XZR9njMyvadwOJ28LJ5f4HykbLNZUIlxrJGQTwhSLkpmCBANX6iQVXplAvT24iqI274aIAjAtD/nCTvnJCLlYwvOXIg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9eb659-a005-481d-52a6-08d885a1d9ad
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 17:55:46.5529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtLtT1xfekKrh5w+0IWoJh2ylUR5epdll8NrbHaZdDdu8j0ouBlg76EpjhlDHjUPZyKrznbsINHlrPyDSHdbug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2415
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
Cc: Alex Sierra <alex.sierra@amd.com>, Felix.Kuehling@amd.com,
 christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By default this timestamp is based on a 32 bit counter.
This is used by the amdgpu_gmc_filter_faults, to
avoid process the same interrupt in retry configuration.
Apparently there's a problem when the timestamp coming from
IH overflows and compares against timestamp coming from the
the hash table.
This patch only extends the time overflow from 10 minutes to
aprx 455 days.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 837769fcb35b..bda916f33805 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -94,6 +94,8 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 1);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
+				   RB_GPU_TS_ENABLE, 1);
 	if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
 		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
 			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
@@ -109,6 +111,8 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 					   RB_ENABLE, 1);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
+					   RB_GPU_TS_ENABLE, 1);
 		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
 			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
 						ih_rb_cntl)) {
@@ -125,6 +129,8 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 					   RB_ENABLE, 1);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
+					   RB_GPU_TS_ENABLE, 1);
 		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
 			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
 						ih_rb_cntl)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 407c6093c2ec..35d68bc5d95e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -50,6 +50,8 @@ static void vega10_ih_enable_interrupts(struct amdgpu_device *adev)
 
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 1);
+	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
+				   RB_GPU_TS_ENABLE, 1);
 	if (amdgpu_sriov_vf(adev)) {
 		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
 			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
@@ -64,6 +66,8 @@ static void vega10_ih_enable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 					   RB_ENABLE, 1);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
+					   RB_GPU_TS_ENABLE, 1);
 		if (amdgpu_sriov_vf(adev)) {
 			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
 						ih_rb_cntl)) {
@@ -80,6 +84,8 @@ static void vega10_ih_enable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 					   RB_ENABLE, 1);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
+					   RB_GPU_TS_ENABLE, 1);
 		if (amdgpu_sriov_vf(adev)) {
 			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
 						ih_rb_cntl)) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
