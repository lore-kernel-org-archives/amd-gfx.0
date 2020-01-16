Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4C7C33CB3
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 00:45:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2030B2077B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 00:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sfHn93Rz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2030B2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 497A06E1E5;
	Thu, 16 Jan 2020 00:45:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B50EE6E1E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 00:45:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELx/ePfX8PucBxyJw2ne16xbvYSQHL3lmWuJIMLD2AXPmXt05tMArRB4nsbM5YhsMBMxKuv+/yqWKPcgbFl7JymuIvRfZxNvVggQCeDsvIX5JjTitYeHYXqhnbhH7OSvz+R7NR058/R+cVFpdeX0NU1F6jJHM8zl3UoKUitHN42ZVF2bGsUpc/+DzTbq+d/NwlICJYv+oQ8sZiD4slyo2QCzqnS4p2s8S/KM62xZ3U4H/trPErVVidHBFrgoiWl6BIqWlKZiN7OAo9wj+nU1IO/SiyxcQ9EVz+I3ne8wqE45hpdlB/EC4SJtyt4VxW7s8XeyijapOR1Sz0mK1mSNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQUsB2HcR642rSCawSqP9jgqerh0vMPy37BGEAG4Lno=;
 b=egvL0691vrlmfgQBCaRCUIct+7WBidLUOXAVJFtmP0KqyWIT4IlwFVIVcdTvjcQVNyCSOSB7gjjsP0Q56bDG2eSsf6aK6e4USTuXFNIm+A2nGmv9ZUlCB8QDuEURFlUZ3s5CID4xshPVPoimDeK+C2qELMxi6pg5enx+Vu17gGZUXm8Ctus9KZA9dOo72sqVNlktnctmDcBTHO2gewRgYTgpi/bjg6mzRqSdthv+NjBhgUOVGVHdAfCA2gETWsgZ1KU9G+ZsBgCanq1n8I9OVoBVhvfWsG4YS8x3Kwt8D1Nwt2olxZ1PKi/37PrQxEDEe23dBZV/SMHWBm66447xzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQUsB2HcR642rSCawSqP9jgqerh0vMPy37BGEAG4Lno=;
 b=sfHn93Rz1S/zOvFXC4Ikk9Pon2lW5S1gd6n9QJ042yYcvqKnITy7fYUUDZ8gAYXUIMZYYQg9avH4dfuzpYMerlUHJGmRSCUakarqkT27H8UwWF2+4UkRoJoIjZSAO+rIiTKg89VKNUPrR0jZ61TN1jQ6Ot5I4c3XvMxKgGeCPQY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB3564.namprd12.prod.outlook.com (20.178.31.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.14; Thu, 16 Jan 2020 00:45:48 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2623.018; Thu, 16 Jan 2020
 00:45:48 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: fix the instance loop and build warning
Date: Wed, 15 Jan 2020 19:45:08 -0500
Message-Id: <20200116004508.26678-2-leo.liu@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116004508.26678-1-leo.liu@amd.com>
References: <20200116004508.26678-1-leo.liu@amd.com>
X-ClientProxiedBy: YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::18) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from ubuntu-desktop.amd.com (165.204.55.251) by
 YTXPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Thu, 16 Jan 2020 00:45:47 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45ef1b95-93fa-41d8-4def-08d79a1d6d87
X-MS-TrafficTypeDiagnostic: DM6PR12MB3564:|DM6PR12MB3564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3564376552905055EC4C6900E5360@DM6PR12MB3564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-Forefront-PRVS: 02843AA9E0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(66476007)(66556008)(6666004)(956004)(16526019)(4326008)(81156014)(186003)(66946007)(4744005)(26005)(1076003)(2616005)(36756003)(2906002)(6486002)(7696005)(52116002)(44832011)(316002)(6916009)(5660300002)(478600001)(8936002)(86362001)(8676002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3564;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zCb007hgzBnw6CNM8EqtkxZWonpsAUSrSSP62ySNQrlmRTrFLFA+3KL636Jw4ssWP1o03QmKrPAMXXgwBk0VQX0Ff2HS7qI+sOzp9BA/KRpY15nWm+ZxZonIIH2UWlyWV9yBWfvUk4SuW8JRTKRv4g3+imyjQB5LZNoM6oE9JggcBNX4r0IKO9L7k7hCfV3pUs4rNoScRlvR67Hdcfg6DWDEOvCJEY8d2PReS5bmVvZ2rymsUhhBID+dmhu2pMW/xvLBNb+unky4RRdjUhu/0EuZOfDhnMqJq14KWx6G9SUpUk9fGa8EziESu8aH5fGDNxEpZ0WGL7+x1m1wdKLohsUcbEPylIn3+La86+9q3JgKeDpoLTOv3G4Wed6qzUZVtyt6pi98+yXokxtk9dfbicQMGQTKmcNZAcCVpOTwWwyL3F8FCFrDZIrGauKpmx7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ef1b95-93fa-41d8-4def-08d79a1d6d87
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 00:45:48.3084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3jKwR3j/o3FF1WRVTnxOnX8owMi+n6lfblu1btZ18rQt6o7bjXezY0OFHLsVXj0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3564
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 8ae1e132 "drm/amdgpu/vcn: support multiple instance direct SRAM read and write"

Signed-off-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index ab51f0e9539c..f96464e2c157 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -193,9 +193,9 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
 		if (adev->vcn.indirect_sram) {
-			amdgpu_bo_free_kernel(&adev->vcn.inst[i].dpg_sram_bo,
-						  &adev->vcn.inst[i].dpg_sram_gpu_addr,
-						  (void **)&adev->vcn.inst[i].dpg_sram_cpu_addr);
+			amdgpu_bo_free_kernel(&adev->vcn.inst[j].dpg_sram_bo,
+						  &adev->vcn.inst[j].dpg_sram_gpu_addr,
+						  (void **)&adev->vcn.inst[j].dpg_sram_cpu_addr);
 		}
 		kvfree(adev->vcn.inst[j].saved_bo);
 
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
