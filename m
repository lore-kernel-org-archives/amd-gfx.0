Return-Path: <SRS0=hrZh=AL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC09C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 01:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38CDE206C3
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 01:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mk4KySor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CDE206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9323F89C8F;
	Tue, 30 Jun 2020 01:55:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE1B89C8F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 01:55:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdxgKUcIuwbzcgcwFqoKRMxRDDtIogf+Gn6Hcyoe3DYaBrBEr6K91jgEw4iASDMgVfqfg6Ct1FCJ5DidjIH6j1F27V7RCYfnjBk/O2qC4B9G4BEItfth2z0RTIH17cVdJKJDCGZuT/yvbVJ7PtaAeklW2dP4XC4XQOe8i7PmQq07PMoOs2vXCY8YcVCakKm2MZkvgL9zRVdSmT1TMfVwN6y85dR/SLdgrh8Hft20JjvfwMV8FN8frqq2yG0CHGUiPks5k7NcUVojfuItF1H7DFmYAsNi+G7XOefqsdKvgaHzF7/iTaECLe+6+u8gtc41fYXJVR+1ZdPW1nV59Tr3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuWKZyVxMwTAHFD5Syxx3KHFmU16EgPJKVIzZADTqLw=;
 b=mzGCkOMYGq70V5WWaHpEodKumQjv6lxbXA0w7x7UXKei8pdpvw9Gwiy+j7pFFwnT0DZXJPFhfSyqy7TObyR5qtv4bOH7XxGQ3SB7jjoOyIU3Kg9UEPz/CzhDl6SPUB1omBaJrhZA/QykBmqa1WLpprouZei9lWB4w4iRvQjiDex+2YFy87GfsUqEzsSpF8zwvdMLRW377bektjWPsWBzV/BJZOncpVheNN9sRRJflvSRb9Yaze748nMSkr6iPPR+bK3Y6yC4kWRa3ZkwL0zuxV3SR6eLyqGuGsUlrrFsjdlHCFfiORjcDpHb1YsrFOkf+fkMIzJJzBGMc5gSaup0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuWKZyVxMwTAHFD5Syxx3KHFmU16EgPJKVIzZADTqLw=;
 b=mk4KySorXngISgawiIT8sA/NyPZTblbNb47bGYEx0SFv3NVGfZOttJNe35x2fvFrKfwrgB8K8RFiRJnmSeuzG04DKVM98A+5Rt7Ivv48JJRE2WcZlyFm1WfmwebJq200SGMYoQ1D6u5zi3uYJrgqWFcJtJ2ydZ5Gwi8bP91HJMc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 by SN1PR12MB2591.namprd12.prod.outlook.com (2603:10b6:802:30::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 01:55:36 +0000
Received: from SN1PR12MB2382.namprd12.prod.outlook.com
 ([fe80::8cbd:c948:840b:3a69]) by SN1PR12MB2382.namprd12.prod.outlook.com
 ([fe80::8cbd:c948:840b:3a69%3]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 01:55:36 +0000
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Add Arcturus GWS support and fix VG10
Date: Mon, 29 Jun 2020 20:55:26 -0500
Message-Id: <20200630015526.197720-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: DM6PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:5:100::48) To SN1PR12MB2382.namprd12.prod.outlook.com
 (2603:10b6:802:2e::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rocm-perf01.amd.com (165.204.78.2) by
 DM6PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:100::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.23 via Frontend Transport; Tue, 30 Jun 2020 01:55:36 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e67e397-ca77-457d-4ecf-08d81c98aea9
X-MS-TrafficTypeDiagnostic: SN1PR12MB2591:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2591E4D0747881E1A7BDAADCF96F0@SN1PR12MB2591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8mo56pfGunQZfE2wBl+JxoFZ115wyABOf9s4nQlj5XfPqnMAXmd4+BZQrKwRIeum7tMdUardcHen/P10BnEzbYfmK6B9OH8+5UtsDyAuymrALW8pc0Qngt1y9KpHml1RsyeZoFYkobs+8LHrKfPmfd7BhmId1tcgqjD3r8BOVUUyDT4vQOP6s/L5dWfaWHCNy2AKwzZWZJ6MggDEE7P8yADcKyHsXxfQiXbmpQhc1Y/VjwLX+ccSjOMmm3IcIpmxBnP3njHeeepedgL6u/sq2x4fLdPzTIa9cGs3a97BIOAOtLFNNfpgSRS2HfL9veJ/2IULzVOnlJ8F5Qq7DrChw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2382.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(36756003)(5660300002)(316002)(8936002)(83380400001)(6666004)(86362001)(478600001)(8676002)(66556008)(66476007)(4326008)(6486002)(2906002)(52116002)(26005)(16526019)(66946007)(1076003)(6916009)(2616005)(186003)(956004)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: IaomXNWmliZJh+t+1aTkKVTmoU1CNzjAnBlrnFN3DYnoioT78e75rKRGEsdLyRBSOyAKpDUd2zgaozK7Ny0WZSnP0vPLWh6kZi1LGN7y1mLliEiIpU6y6LAPk3KB9ypGvMdeHvV573ShyIXSmbSFyLuAOx7O4SdMMYxbupxUw+bSp1VH0/i9mZ6ZfsPBxyyrKKudnccv0I3engEktMG9J2FbkMfVVegd1ry9TxKukCvOJhX0hmln8LhYlGKCSaC/Kw87s6fEXfiruIk2aG7IoAvbAiHqTVAWUoAYqrsXOIfayGWU34NZ42EvlSt6bebkCA9XP0CctamoCQ8Y+hBieJr33GwwSoCCd9k/CY/wNp62jylYCNIWrttutzZhr7b/NabT9i3hB4uhDAgbV2wC4zm3BaU902lQdw2iubGW/dbHWM3nm5SYbgGvCafg3bGf51H5aDktDMKINC4efyUgcXsLONx9iNXnseuKe1fTNXI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e67e397-ca77-457d-4ecf-08d81c98aea9
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2382.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 01:55:36.5972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrt3vLjUZrzFQCZauIrTP8EjxZH1+PAl0v961BUaAL6ySHHUTOKXgcqVTnbphKKWy6r+SiBvNojyMG7n/ufNjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2591
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
Cc: Joseph Greathouse <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support for GWS in Arcturus, which needs MEC2 firmware #48
or above. Fix the MEC2 version check for Vega 10 GWS support,
since Vega 10 firmware adds 0x8000 to the actual firmware
revision. We were previously declaring support where it did not
exist.

Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
Change-Id: I9b44dfe59bdd8a38a0342e5155cdb071cf646cc5
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 80393e0583bb..50886de3ba0a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -602,9 +602,13 @@ static int kfd_gws_init(struct kfd_dev *kfd)
 		return 0;
 
 	if (hws_gws_support
-		|| (kfd->device_info->asic_family >= CHIP_VEGA10
+		|| (kfd->device_info->asic_family == CHIP_VEGA10
+			&& kfd->mec2_fw_version >= 0x81b3)
+		|| (kfd->device_info->asic_family >= CHIP_VEGA12
 			&& kfd->device_info->asic_family <= CHIP_RAVEN
-			&& kfd->mec2_fw_version >= 0x1b3))
+			&& kfd->mec2_fw_version >= 0x1b3)
+		|| (kfd->device_info->asic_family == CHIP_ARCTURUS
+			&& kfd->mec2_fw_version >= 0x30))
 		ret = amdgpu_amdkfd_alloc_gws(kfd->kgd,
 				amdgpu_amdkfd_get_num_gws(kfd->kgd), &kfd->gws);
 
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
