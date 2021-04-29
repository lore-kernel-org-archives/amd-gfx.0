Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02824C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 09:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B52600EF
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 09:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B52600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 278AD6EDC8;
	Thu, 29 Apr 2021 09:36:25 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2065.outbound.protection.outlook.com [40.107.100.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C696EDD2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 09:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3wKqow+QjqHxrxbsIP9xV7NUojm28Xv8Mvbe4mWF9TXGYeexFXkAKqVGcXrWAUfXp3GV6hBKXoeqtE5ec37IPlikW0mdgVUkcGWjorTEVC8OAbPmzjg/X/5/khcVrnV2F7xaUuTNHEfTvl8yS9nKitOiUKiWHuy+5TQZ3CbU2AyVVduNrBmRx3AF3goHHPFY7Tu7yT2lkslzIio0O5+BSjtCeWAy/Th4DBEn4ZpHR2k4bjBtWBXcnIJN1U+rG5WNBWD4hJ6g+v1AE0cJY94Ig9AjRUBdBIegDdLrHopFX+6dS/1opps9RP0koLqG/yuE9/SCmXPBfu6ha8SvciCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfIYZeoLDuElHwatnuW4fgPVGQEd4SM+H7w2ms7+lB4=;
 b=BQKECGehwEon80IOyAvV8lbaWl3SNrZO+1B+hPwnnLVDnYGNNSrPyMzK0w0H261Nmh2hEujRclRSWkm69HHXJDS5DSnGzYC6lqezQsOzYkFvlfWsVMQsEfZPuZgTux+FVGg2cJArZgiZ0AvvTa2tFNREoovUkiNFrMmL42mBApJmKdU/uoLqDv/FOpLslCtnlV0VIXr+8Ouff+V8sIvWaVtOGYrOZDjVW8p5mTRIlmowveT+AcDVOmSAL474PtxCS15CRUUOwy3YzDQLGHSDSc2/dbxNeZFtam+22afbLw4d99RUQpJDna20GBzRCTIJJ/Y1dVbsOZ4KN8hZdIYHew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfIYZeoLDuElHwatnuW4fgPVGQEd4SM+H7w2ms7+lB4=;
 b=gupxCMWcF4gbptS28Uo9+zL9KV0UWxzjl0IiJi8bo5FslPfTSnO4vXVWvqswANKi7m+xScm6qkkW/kEImbnd1YsKCW92oCzMDNaZWeQUeP/L3nOC2nb+HMh0o7BA7UAKIshI4M6clfAJm7nkKL3m/akNwMnQFOAbbm32wOf66a4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM5PR12MB1353.namprd12.prod.outlook.com (2603:10b6:3:76::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.23; Thu, 29 Apr 2021 09:36:21 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::8d0b:598b:27c2:4b58%3]) with mapi id 15.20.4065.030; Thu, 29 Apr 2021
 09:36:21 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: report atomics support in io_links over xgmi
Date: Thu, 29 Apr 2021 05:36:09 -0400
Message-Id: <20210429093609.71616-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::7) To DM5PR12MB4680.namprd12.prod.outlook.com
 (2603:10b6:4:a6::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Thu, 29 Apr 2021 09:36:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f07697ea-18e9-4ec6-c9cb-08d90af23f66
X-MS-TrafficTypeDiagnostic: DM5PR12MB1353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1353FBE8F17A919EB7D1E305855F9@DM5PR12MB1353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E08SgJMBDibulopTYBuUr4ZYOFV4Omm7w/cCQktADhydH3QImhkXQrl7W2Pb2m2ALXR5+ARIupa5vxNK/DVDORr8YbRhGDVBeUNL6j20eSyBABVYzEc2q4MtIkqocivuZN5HmJWbnbfQlk/o3baf55IPXCekm86nu78Hux94ckPU5vtJXKWh9CkAWp9udKVfw+r6KJQnIVBH0oD+YwmuPWwr/DHQlazsMwODbN3DCWHegxFAb7d4E7UM0/xIRisK36B/OjGOwtflhmoCcue9G7WgANACAHHT8yeMfrZbgDiSuaONp/lUzrPyP3BbUBE1TU/rDn7biNeSVa0tsMu5I2DBcTQS91UvQFb6HxcH33MaZfaZ+qmW1+RgyGHutXP8XEM7AGnKvhl7Uee2gjGAM8ZJgE28gr/zhTSbtqxxFRAXFoAd3bPsa3e0aJXT09PzDpx67eW228irOY1iuQS0z8ZfSFYLIeSiLtJTLhReEMRQjgEa2ZMht/ggo38Ys1zORFsVP6gk4tpOPfZ8+3ahALIBCPoL41b4ru7l7JbnnWWxbIumbdCBqZNLAStLPL6XdkD/hJ4yWBr3RDaATwCDvv5HHr2l2ED4MbjM+p/cLU9+ZTaiDptr5PNQmLhFgchNz51T9K7GYB1mPeNfc/m/u4nWX+af2XFxBrZbgVGQ3VImGmf1arvn3BwUSwW6er4+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39840400004)(376002)(346002)(136003)(6486002)(1076003)(8936002)(16526019)(508600001)(7696005)(186003)(5660300002)(2906002)(8676002)(4326008)(86362001)(34490700003)(66476007)(52116002)(26005)(38100700002)(66556008)(66946007)(38350700002)(6916009)(2616005)(36756003)(83380400001)(6666004)(44832011)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PWmlV1mCMz82/e+pUDwr+n/A169NxUbHNKQfpjtwgbINc2xQXGFx/v91AHSa?=
 =?us-ascii?Q?mp/bpJ7soHkZNWX4EvzVwVzoyM5hE7jDA9pjk2bnePZqJ1z3FpxlsImiQftS?=
 =?us-ascii?Q?xXdBM4pQO/PXf1Vr/Hg0+hKmt8GMQzqhW0q6g61DKqz3/nZQ4oIgLPr0WbSh?=
 =?us-ascii?Q?am2U0RoPw0PGGFS88aSagSrPJxEYueXl253W/ucyaNA88GfncKwuyZFFdF5R?=
 =?us-ascii?Q?jt/n+JmWQxeIoAWtLI8FgWIfwHBvu3iQqIF54h+/MeEe8FufJ4cb+MoK8EPS?=
 =?us-ascii?Q?oGD6WrEGirmx4MOcRAMtbiG3pOctGowNxFLTVQnjSaMXVteWedg+cCCyUj7n?=
 =?us-ascii?Q?qxMRiZJeyl4rC9rjgaEtjq2pIzQTs8J8dbM+BeeVzQHZncQJGSJn9gghS2lW?=
 =?us-ascii?Q?9MfE4+Es3CqECIOh6xPkh7pBB3oY9XplbNmMrDrilnGgABT0jZmFOs0zfStT?=
 =?us-ascii?Q?I5LIcyLrUGyIAbO49sGfyKCAVIUssrGmkuHMoP0g3c51zXNWW8Ifi6lh12+k?=
 =?us-ascii?Q?s0Gcnr1tUkS0KEKy61uEidcyqt9hh32AgfL1kgFbXvfo7VxM2MRIcZSyhZhi?=
 =?us-ascii?Q?DGwWZ5yx0u9z3CKiXPbvF/02u9MRXjzO3ArvIWm2WuW6rWKDTFTurn7VCPlJ?=
 =?us-ascii?Q?lJXGyXAn7hSM7UlGLPBQlyA+FJD9D1aLDmR3vcl+0EIA9G7eyHstQ6EScNgz?=
 =?us-ascii?Q?pt0x6PtKNwjjKrTFa+1yt4huI5HWZf9SSq5eUSl6ms99sUf19mNvMK4N3J/Y?=
 =?us-ascii?Q?/LGwt5tGQSZZ7hSyCcMjvhWM6R2a5+mGipYmwPJyREuY8JAKqhSfBW/AJH5u?=
 =?us-ascii?Q?MBR6ghagU0bdXkPLLmZdh6eP7HvXejY0j3Xo1Z6A2iRmSfzF+MABP2Qg3WM1?=
 =?us-ascii?Q?KG5TRZJlMEou1lcgZWnMJT0l8OYPb1aUDne8f7ImJVQOnhOKHdiK+vNpbyPX?=
 =?us-ascii?Q?DCudWXpciXfC1Eff5G4ySEwrUIY40yiAt8zZ4w6qoQ/dkWDBzNlhm6ubz5fU?=
 =?us-ascii?Q?oKZap+Ig8zLs1SOYCc0pk63ZnUPJfoMUkX3ypgBCE1kr1bzLcw4eixYrVcZf?=
 =?us-ascii?Q?LDAZ1SC7Vj7fEEO48RW9mjmXKA0OFPIkU9mbJ1uF5/LCDrDRiZh3kmSfHhez?=
 =?us-ascii?Q?Kh06vkVI8aWCDvDyIVsYpyoCu9dJ8SkNve4hpeZiL/GkvUQhZaGPOe1rFKBb?=
 =?us-ascii?Q?YKbA4e4uZszEKfNYPL8sJDFqaJ9OzqycU8dPDCQdcIDuK6EI883qGKRQ9QA5?=
 =?us-ascii?Q?a4HGZG7tiJBpEodffoRBbkiczwwVZpoBPS3IfE7IteREv8794mmUfUmBQCa5?=
 =?us-ascii?Q?SWSbS8DH1kLW8edfnOEhj7xf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07697ea-18e9-4ec6-c9cb-08d90af23f66
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 09:36:21.5518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1XeGMWz9YlncF4GvCcF65Lzr2Zo/c4Sq4DcdHz8WSEhGUcrOQbzaPcsbpn1fxMv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1353
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
Cc: Oak.Zeng@amd.com, Jonathan Kim <jonathan.kim@amd.com>,
 Ramesh.Errabolu@amd.com, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Link atomics support over xGMI should be reported independently of PCIe.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Tested-by: Ramesh Errabolu <ramesh.errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 29 ++++++++++++++---------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 083ac9babfa8..30430aefcfc7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1196,6 +1196,7 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 {
 	struct kfd_iolink_properties *link, *cpu_link;
 	struct kfd_topology_device *cpu_dev;
+	struct amdgpu_device *adev;
 	uint32_t cap;
 	uint32_t cpu_flag = CRAT_IOLINK_FLAGS_ENABLED;
 	uint32_t flag = CRAT_IOLINK_FLAGS_ENABLED;
@@ -1203,18 +1204,24 @@ static void kfd_fill_iolink_non_crat_info(struct kfd_topology_device *dev)
 	if (!dev || !dev->gpu)
 		return;
 
-	pcie_capability_read_dword(dev->gpu->pdev,
-			PCI_EXP_DEVCAP2, &cap);
-
-	if (!(cap & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
-		     PCI_EXP_DEVCAP2_ATOMIC_COMP64)))
-		cpu_flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
-			CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
+	adev = (struct amdgpu_device *)(dev->gpu->kgd);
+	if (!adev->gmc.xgmi.connected_to_cpu) {
+		pcie_capability_read_dword(dev->gpu->pdev,
+				PCI_EXP_DEVCAP2, &cap);
+
+		if (!(cap & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+			     PCI_EXP_DEVCAP2_ATOMIC_COMP64)))
+			cpu_flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
+				CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
+	}
 
-	if (!dev->gpu->pci_atomic_requested ||
-	    dev->gpu->device_info->asic_family == CHIP_HAWAII)
-		flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
-			CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
+	if (!adev->gmc.xgmi.num_physical_nodes) {
+		if (!dev->gpu->pci_atomic_requested ||
+				dev->gpu->device_info->asic_family ==
+							CHIP_HAWAII)
+			flag |= CRAT_IOLINK_FLAGS_NO_ATOMICS_32_BIT |
+				CRAT_IOLINK_FLAGS_NO_ATOMICS_64_BIT;
+	}
 
 	/* GPU only creates direct links so apply flags setting to all */
 	list_for_each_entry(link, &dev->io_link_props, list) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
