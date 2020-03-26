Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542A8C43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 02:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E5120737
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 02:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g64KhoN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E5120737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 839AF6E884;
	Thu, 26 Mar 2020 02:02:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C4D76E884
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 02:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdsmfigEp8bF7fBAlZmPhtQOFuhumPnJVdL7asR94iWoi0HaM5CoHx2Mmg+PYBbIq9n4DLrD4bSRXwqtlmAgwvCv/aIn6vOl1gJOcDwTZq6wFH8Pfor/46YgLrnBQan4XuDUkAOI6sHX9RdD3H/SfpIpMEbaNkKEg5VkYe5Do+9vbnTpEq/gBggAIC1oIRtYpyN6xAskyh6wlk1zjrEbVK0VCt+o5ZKnzqyKwSu1blCUlbevddyQLzA/l4kJ7+Z/ug0iZTd58ZeVo59hWu8rv79xNADeMcba7l86PRM+IBX3imlGJmqTWbLBmvAOK2wVUKmenyjStDPZVJ5PmMm60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oCGTeB2owLjF9op763t5GqRBMx5wVOLons1TKw5ZSc=;
 b=A4nXMAoVPCEWLb8U7nxMkr5dLgJoEkkJO2UcDLqwWmRx1KszrRpEORt1M4stmfECxagovRWfi5DACEmGIqW3pYsbpH5fxFhZMgtkUIr0IAHnHykq3jiualOkLBHby57iHqy+KgtXI99/Ut+J70MJMR9PSPLgTI/ulvRfKsAzG9joWW8qB+QVs/lwj76YnInaT1amfCUAy8P/L5a/9mQud+CXmSuWPHlrK43fiLvpOps6pXoQYQhCW7jNwpEkmTiAaj6mEq9xOFvG2XN7G/VvVWa3tOojvUWshPv9FW8viYisMNcVdEFZlhG+fjlD9WOuj65C50EPgaMJLe8oibdHIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oCGTeB2owLjF9op763t5GqRBMx5wVOLons1TKw5ZSc=;
 b=g64KhoN24+aVPKEyNkiB7GByWhNC8iHK21GoNleQGdlbe+ktha4X3jdSE5TrJyoI6MI9TAww3/LHJR/Fhydk/Da5855SUe2JC1czmOeRSZ74gxR4l9GhoA+gRPObR7gnPYgGbgoTdLHVEzddxcw4GxQCgrOyUF4cq/ro1vPL6AA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2655.namprd12.prod.outlook.com (2603:10b6:805:72::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Thu, 26 Mar
 2020 02:02:07 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 02:02:07 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 0/2] add direct IB pool
Date: Thu, 26 Mar 2020 10:01:42 +0800
Message-Id: <20200326020144.5953-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: KL1PR01CA0104.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::20) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 KL1PR01CA0104.apcprd01.prod.exchangelabs.com (2603:1096:820:3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Thu, 26 Mar 2020 02:02:04 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be880d14-c38e-45cb-fc78-08d7d129af42
X-MS-TrafficTypeDiagnostic: SN6PR12MB2655:|SN6PR12MB2655:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2655D340CFA24A5D51138EE287CF0@SN6PR12MB2655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(86362001)(2906002)(2616005)(26005)(186003)(478600001)(16526019)(956004)(4326008)(6486002)(66476007)(66946007)(5660300002)(7696005)(52116002)(81156014)(8936002)(81166006)(8676002)(36756003)(66556008)(316002)(6916009)(6666004)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2655;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pbgdslg+EBB6QZnVM+ueNZ6hZ+sIUq/tJompggFbeBQDe9h7jXWOuf6xgWqBNEfkdbJynWNiU5nDdmvDFzBPRmthJiZnVYPr2OHD7feUKTNRHrKfhq6qtDM9hQ5Yhh503ZT1rgZpIscAmjyZdMpJfr3SY68P8Uxbs8XkArWzkLFtAuFRFWnjtLydjG317MbFwFgsuuU4EEmduByuV2tEm5irNqteXj21ovpuA7oEFvtSWR+j5womuYmMKZ0oov2oHjEzDazcez5QHC7MGh/gTntQO6uFq+/QqrlfHa8OsD3cppareYP4lzat9rRpgzpc7rTHXOKpFmkd4gcZMLOAEkcjF9FH8ybmGS+W2fSrKJZS5SKgfmkzSZoItWvcbcc9U+/z9wPkLbdfrICgTbQIz04eiuzNGQnA53VuV7E/vWYGYluDD1d+LMoYzKXNN+C0
X-MS-Exchange-AntiSpam-MessageData: 7fUx7semiW9dU7NZd2RWRMYruR3Jsp+yC+9FX55ub2BOiNB8ksUc86miNVaMA0SEVpZIATq5r4skAH17ZB0rkYDMkffvRx5zCmOS4GynIBZ1P4WCQtYiu7dh/jo5lJsEhhBZiFJ+oLx0R3h81ABF5g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be880d14-c38e-45cb-fc78-08d7d129af42
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 02:02:06.7247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdvaYH5VhxMLSngQ+6eKrhzwB+XFxA9OcB3woG/HkEG+Tp2Avbamx69Lh/o1muR3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2655
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 xinhui pan <xinhui.pan@amd.com>, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

druing gpu recovery, we alloc ibs for ring tests to test if recovery
succeed or not.

As gpu recovery parked the gpu scheduler thread, any pending jobs hold the ib
resource has no chance to free. So the ring test above got stuck if no
ib to alloc.

If we schedule IBs directly in job_submit_direct, we can alloc ibs in
the new ib pool. It should have less contention.

If the IB could be freed in time, IOW, not depending on any scheduler,
nor any other blocking code. It is better to alloc ibs in direct pool.

xinhui pan (2):
  drm/amdgpu: add direct ib pool
  drm/amdgpu: use new job alloc variation if possible

 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 12 ++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c       |  4 ++--
 13 files changed, 35 insertions(+), 18 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
