Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B85C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 11:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898EB61077
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 11:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898EB61077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4375B6EE6B;
	Fri, 30 Apr 2021 11:43:46 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2047.outbound.protection.outlook.com [40.107.101.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59E9D6EE6B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 11:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjcmBzs+UR3WcmJqo95XoqpdOkNf+yVTw74CwmyFtA48M+RZRlzJmoDKHZGqImazibX+9/NgI+TPqAoEgA3KHLuO5+IcspYsbO7umpK1SD946TRYuwbkjzI9A7OAbBDc9Vs3vKB6DT+E94EpTVm1/D037RDSs4VjVUWxL726CchDpMRD+k7Nz3YzyXLBan6Sh154pOP4PxYaXIiPhyHTdPeIFTeYZdS0TXngA0f102ZTlKXgXV6Be6fBs6V9StaWthlWJ3DD5Qpjg8jmD9uuZQqxtmyZ6q9u4NmoQXLhG6Acxge7+eNDefriKkV/k11cCEoS9sURj/lAKlyWe/kqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/JC3t45Dj/vctPegheCkow6HJjXHfXYrzG06Kezg7U=;
 b=G9GFJvOxWddTefDuodbsm8jV/fzJq0pIAIlM/rcJ5W1mAz2WNl5UTJ67R4ymnr97mRLirAwbugUsqchcawyvKk3sVHIxDRSrwiYNknvgUEwebo5g0vyj0zIiCyXqVBjC37uD/CIbcwpgszZPRkbLrMpp5YE8aqXT9y7CcER+iptq1Xcuu+95WrpwiIUu4CIYiRyPq79glPNaaEwMFS+a0r3cs/wiesKrYF0WjOumsy3yWWklSpPtrNRFHK5wH4tojWV7VNkKslyo3ZGYng3gGHZZ68HUCv91jeCiffudHp98x4w0v7gTgU0KQdIpndFkBIJLiSgvhwouKxXIjTmwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/JC3t45Dj/vctPegheCkow6HJjXHfXYrzG06Kezg7U=;
 b=4QA5/Gcs6il15ZmPIasZwp6ytfe2jG+XTPWNyjka75htboBmPYTr2SyndzQsUKU8FPhiQLQ7SJD5+NLOGQBTHlfXLbSXkXBdhorb4dtYrZDuh2N5sAoOJRp902uBEwVOfh+XVQc7WmsTwbAir8x8Ci+YVvu6x0hzF5bb3u+EM+8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1831.namprd12.prod.outlook.com (2603:10b6:903:128::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Fri, 30 Apr
 2021 11:43:40 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.026; Fri, 30 Apr 2021
 11:43:40 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: remove excess function parameter
Date: Fri, 30 Apr 2021 13:43:24 +0200
Message-Id: <20210430114324.14959-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR2001CA0043.namprd20.prod.outlook.com
 (2603:10b6:405:16::29) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN6PR2001CA0043.namprd20.prod.outlook.com (2603:10b6:405:16::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26 via Frontend
 Transport; Fri, 30 Apr 2021 11:43:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3af7d39f-a9fa-446f-9ef7-08d90bcd32d2
X-MS-TrafficTypeDiagnostic: CY4PR12MB1831:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1831C9C5BD2F2743E269C2AB8B5E9@CY4PR12MB1831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fkUvyhvn1dt+JA4rX5EtiaZi3CpcYolVznDeqldzGtxekHc6GQtiFg1iCTRv8Km3pwr38MEj3Fkuw99shvxT2A02ytOf6gkzyXhpbBIvTdyW6aopOqAOix6oWogRjVG0WHIm8CxbF/hgpD4ixgwD7ujRzOKMTeR+ZJLRHIwtTOFKUAqLV58opi5IgmzDeggiOVRF9awZzP124K/VCcPXndR5GXrC1EnQNpwPYjTo65Iep27gGhOWYeRYZ457ZkQdVfBHDBA4FzdifdSAn7hV2Ksno7Un2lR9Y8j1yVm7leZslGJLbfMpSz81JBF8YGCsVHBdYPC+9tt/cetupuU4ka/V08hq5OottN3gG+4T38uL2KmXTaBwlcQiLfCKgV8CS5srr42+FfSa+PVs3OeNADSz1DQAVSZQMxT3lerpVqQf4z7k9pq6tAXRNp4NFONYan7kHIBuxxL4i0LPfE6/hC1q4hJax5w7+E5nYUXbWcTglFTg1Ugk/QFRdXPVYpHgdVDb8fecj+SI/mgdqZk7Xr4co/bTqFYDTOsddlWW9rvEtyLqtkBTwUsfABb+EnuJBCW4f2UxBgQQPsNW7F54iYWvSX2iyDbxTQkJ+DfWDsFc0WRdq4uSeWenuXhtcVyGBcMxXWsUPj1eddJuSBQhAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(83380400001)(316002)(66556008)(66946007)(36756003)(66476007)(4744005)(6486002)(1076003)(38100700002)(2906002)(38350700002)(44832011)(5660300002)(478600001)(2616005)(6916009)(956004)(186003)(6666004)(16526019)(86362001)(4326008)(8936002)(52116002)(26005)(8676002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qIH0FLbjRlypgC/ctmI7VXVZ816vXRp4gxVNdVTnxadEp9+GxjPPvGIWIfIj?=
 =?us-ascii?Q?Y0lwpWWt7ir8cU26tjOQo6qHKYT1NiBQd/1mAWfCFugUehYcxMzF3zLvq56D?=
 =?us-ascii?Q?cmvrvuUcae7aAoKyuoW3sLXpitEGCOVbd0g2Woxu5cXAloYJajg1Uun27AMF?=
 =?us-ascii?Q?Id5uNfzYSXgI7Bmelibj86L1BD4fkMuRYnDn7kqH0z4ckyYUWH34ceAlZqCh?=
 =?us-ascii?Q?s2aNA7uVHafnICYPiNNvQ83ASy99uNCEFYqHg4kVLooUmSWC0KfL/bfVGShv?=
 =?us-ascii?Q?X6EOPBBrRKg/rxqp9Aud0aF2wQtpfoF7St/1E6dXBQjFs7IY0WVu8cIOndEm?=
 =?us-ascii?Q?HO0XJZkkqZ9ZlccfvbaMxFF7D12qT17D/5G7D0HjsG2+/myXROeRAWsd0zCB?=
 =?us-ascii?Q?YAttectkCKL/jzFqKKDQmTiSZFVM+6i4sdGMJWSXqyvC/C3/YbYoaav3LWa0?=
 =?us-ascii?Q?c9Qq3gkukp/f5zl/8umHdg6b+hOw8n5kY0PH0yspQOt0CgXIBYSJElRlZpRu?=
 =?us-ascii?Q?Ojs2XfiJifAkfDaMn4ZkTppsOe+QHLssMARRvh4XcnNXw8+iFYPcOp6S7K0S?=
 =?us-ascii?Q?E6NSGaZ3lDbvrUk6q/+H4Mzjyh7zCKdY/aZXkRK+pz725Jx80I9sdfmqTDY7?=
 =?us-ascii?Q?5jkHSSjcoUmxBAr+nxWtMPOvw5+5yh/+1V83Bp24e0nIhEu+iuiAqLbjBDNW?=
 =?us-ascii?Q?j7lZ+V81L9vUvUH0zNWfjDwxgTdUY8DEBRLkXcUk4ZKVVTMy6lGNMoUREhI6?=
 =?us-ascii?Q?bcDCBrDOWvdXBIVjktGGt/mbXL/NMd6IxHs6ptocXZX7Cpe7E/wuEQo8Jd11?=
 =?us-ascii?Q?0+gxUw/WhbVD5EfIWmy8tPvlJoV+HwIZtlcFuAYgQvTFwbFlSV3OHokrYAFC?=
 =?us-ascii?Q?ksSKISoeM5gHc6AYrCN8B+mpj6SG3pOWvl/XoIF+SO+aZf0fUdmekrgBLLic?=
 =?us-ascii?Q?KPpYcm7vKr7oLJQrFXntZWX4poKYLDQU3i/6fnbxSU7bk3x2pWFoCoIBZ/G0?=
 =?us-ascii?Q?i4OMFL5M4boldaFlRpPWmzpAl4jVfIZRYN9AFixH6sF/GXK5Sqpkx6bBxBWA?=
 =?us-ascii?Q?KJiRYxKp8bFYdA2thoEdWq223uSu1W9KNiRpelXY+HMAAPo8kBIVyV3S0UfB?=
 =?us-ascii?Q?CwMWjjX3mWhnFAPZxvQyHoCy6Taz784dDPXR37WRzIJ3CEbEb/4TARjAYJ+T?=
 =?us-ascii?Q?q4KuX8mRfoPL4m05OAofvP7n8EDgMMJnTwR3Ntj2i5/JKT88iJD1pO2IXHDN?=
 =?us-ascii?Q?0cq+T09NVnnvKoFGkJbhe+7ZHMHrnPx5Ve7RYWlJTd/lKnhF6Jyy4ZoudbQC?=
 =?us-ascii?Q?DDo1eMFRnat0K6D/iaE/KcvT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af7d39f-a9fa-446f-9ef7-08d90bcd32d2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 11:43:40.2419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6S0pVEnFiW8IrFmEsDIAVirxeTi/jMRZICqLNqRigUFlX+VFC4zHOqeHjPeFrMDOHcHVZAYas5hMC4qXOW6S+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1831
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 49020fc1f5("drm/amdgpu: cleanup amdgpu_vm_init()")

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index dae51992c607..f2513be72980 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2796,7 +2796,6 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  *
  * @adev: amdgpu_device pointer
  * @vm: requested vm
- * @vm_context: Indicates if it GFX or Compute context
  * @pasid: Process address space identifier
  *
  * Init @vm fields.
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
