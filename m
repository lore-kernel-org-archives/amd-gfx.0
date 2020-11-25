Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7907AC56202
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 14:09:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060342076B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 14:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TeXnKfoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060342076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90AE06E9E5;
	Wed, 25 Nov 2020 14:09:53 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750045.outbound.protection.outlook.com [40.107.75.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 714456E9E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 14:09:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QD6F0ClXj+Awwk0vrAWWuOAg4M3dNuy90Er23NoMbfsWkkOXTJt33aF40Ew4PvphsZt57QygH152cDsHSBxf2ri2HOxUrgP3KW6g/aIind1HzfvyLdqIxKSFUY2STh3XuEMGBbNuReawZl4ng5CYpBvaGlNpK1ORAg45SA47oG4dKPJx8OdU8Ri1QH2iYFKGg2Lth/DJv6DXWZblHXDWAB22jJKRq9P9mlb06fXFav0fkOl5b7oPo11y9npfPrQH+nFuUBB3wGf+K0qBSKUqYHQL/D5rqj6AsFkaAOtVJPgZjMUL7Qkvy6cIlehf4diI+86WKHml7WQKVy/HjOYslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn2jO7GJT6FtExCL+pt0EaP9q6BGI5KQWxIHufykmBs=;
 b=Wf6LjAAdPLcUjWaeKIVJIKepE/uYL2Ggef5WwcAigv+uFp+9zcy44VLKa2y/3FdCVwua6CRkwbt4+PpKTtIgcsLwEPxeB3BbsNWVBj9PBkt70ABQT6xd8RM6zMIHvcOvtcHO8kXMr5k58e54THVit06/SEZW+YF6X9SxtMu9nqAmiAvqNh13Ke40JwzJSCVdYRrks0iZyavykpGheSjlFrk1RNwXdUApu5qIbXWJnene0NVflaIiW3qSNicOIc2AhAbVjQe8nrZdegsMBEsAMIJZcB3oGtoxju7iYc7+bZVleXncUx2p7/seOFUULJF65rw0ISNI7+X3ZEeeSfZ4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn2jO7GJT6FtExCL+pt0EaP9q6BGI5KQWxIHufykmBs=;
 b=TeXnKfoPBB9bnfIdZMO/rwzCYz6pKZe+PRSUIIGO1px4sIBsj9hkA/A2mdA0ANuAQLCRcYMST57/QWbUlt9X7FWhAF1LudlhdZuohLzNwLXm3gSrbQqRoLYpbqWYZjGmJIV7oCluXjpx8pcOhjwZQ5u0ZWenkh1aWLg7mY/qkis=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4911.namprd12.prod.outlook.com (2603:10b6:5:20e::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.25; Wed, 25 Nov 2020 14:09:50 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a%7]) with mapi id 15.20.3589.030; Wed, 25 Nov 2020
 14:09:50 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/vcn3.0: fix compilation warning
Date: Wed, 25 Nov 2020 09:09:44 -0500
Message-Id: <1606313384-7808-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: CH2PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:610:5a::34) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 CH2PR08CA0024.namprd08.prod.outlook.com (2603:10b6:610:5a::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3611.22 via Frontend Transport; Wed, 25 Nov 2020 14:09:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6dbd0c39-4842-4b23-6992-08d8914bc619
X-MS-TrafficTypeDiagnostic: DM6PR12MB4911:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB49115D4854F72FA2AF697EDCE4FA0@DM6PR12MB4911.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJX0GKl8yGFWNWqGrDmmlImqaphInhdhAba/uFMq6fnV3XupTuTdYRRAWEQF56AdGMgIkIVe3eWGC5jkdmD05w85gqpj3wQckjZBYD+Vlfa26EK82EpXEFOA8VdJrOziRgllYBTInUNwMS6dVqvICOXeh+b/lYluLHVP9r4FPPwJ+oyiNQyJOVZF29/sUzg0QVhJiLPLbwyePe9kqbEZ9xx68WtngS9lKsu6tYdnPIT5kzGBrXkg2/Zb+ZG+1+oWV8myl13MoBERNpyJAnCaEy8G4jZNmddh6IqXxv9oVfPhZPelR5tj96E94eSmepzdzIqbY/frJU55MPHgusmg4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39850400004)(396003)(136003)(8676002)(66946007)(66556008)(316002)(2616005)(36756003)(8936002)(7696005)(478600001)(956004)(52116002)(186003)(26005)(16526019)(6666004)(6916009)(83380400001)(6486002)(2906002)(66476007)(5660300002)(4326008)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?q32PHknBIgFS+gcJrdlV9j3OpDtG9+8cWaEoGZB7J2Q7CuV2pSE3ugutt5qX?=
 =?us-ascii?Q?FxCiXCl5/Q5fPvf2+B4ECgMpuzYeOC4mDA7Mcik1O8mTHPx4LeK9aFp8V2I2?=
 =?us-ascii?Q?j+nQ5uzZmtiJEncbvi0TURBYIdkwNEMfuQvIz0FYGD+Jt1ZtpzKMZ55YaM6W?=
 =?us-ascii?Q?96uuvR9+jA/+2MbkootFC+86vG4lZs14vsy36Feg5aaY56j5XbNj7ipqgjpy?=
 =?us-ascii?Q?7rR28AEypNutoYQ59NTgqu7MNkq1eZWGJ/voLYWpB59mh/T4JCIWoIihOTk1?=
 =?us-ascii?Q?bF49It7stixWK5ah62vCc0AF+SY7uaai9G0/F+jT/e/QnJslvZU+kx+PsvEC?=
 =?us-ascii?Q?XpSSrSCUscT2vVqYcJYoirW54vw4d42gSbpwxQHWf1MSJmC9/jGZCyQPbLyJ?=
 =?us-ascii?Q?TI9d8E0QffeZrUtZ+U0qMfA5yUqt5fQ51KhFMjK9392qk1NMFQB7X5QMgB5Q?=
 =?us-ascii?Q?1NhQ6R6wU1jfsBsy1troPSthR6N39DrLXe1msOSkWndhwvImyFAcmv/ed0Dk?=
 =?us-ascii?Q?FtaZ2wrwVmRP4oLCLRPYvS6V3BlbcCPhaBsC9mafwgfHM/Aqx/TmJGsFRmgh?=
 =?us-ascii?Q?7ax5f3+QLCPxM6rzRloLMvsEa/1cNT4w/oS4V6dxcIccZMoxA8ABu54BFQ5/?=
 =?us-ascii?Q?80BtEIb5SaKXewd9OEpzHtx7yKEoNSbEiFwJDJsgSnYb779WlXMtfHczAqpB?=
 =?us-ascii?Q?3m3A7k6VpdkEFypFRV/Bz/RxwN+GKTezEMgqrYgEa6iICRe5GQAuKqr2ib6N?=
 =?us-ascii?Q?KqSyRHXMIP4UFpliWg4wxVUUZ/cCyzwoOu02UorayaIYMONyYy/GvNJ4skgN?=
 =?us-ascii?Q?oYaye13Q2ll9ZKU7mt/gZFQG2Z05ssbGrrDWvgDkUnwEREbIVCTN249h2xvv?=
 =?us-ascii?Q?VzzhzSyS3SljMCsP32cNx/vJhEVUlAzeGS61gnzu9haFVT6lFzISBIt35jQk?=
 =?us-ascii?Q?6SmxD6bejVpA1r16nyVgHHCXdwLvHFvrazwM8HVGVZYhh4vH3A0W+m/tVMWo?=
 =?us-ascii?Q?sMOi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbd0c39-4842-4b23-6992-08d8914bc619
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 14:09:50.6553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYNJVBhj9wmkmsZIRQxrM5JKYkzdDaLuhrOfnWEtUymNDKt0O2zaJTHOWSp/T1Ks
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4911
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixed warning: no previous prototype.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 71e10bf..0c97322 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1701,7 +1701,7 @@ static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
+static void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 				u64 seq, uint32_t flags)
 {
 	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
@@ -1713,12 +1713,12 @@ void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_TRAP);
 }
 
-void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring)
+static void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring)
 {
 	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_END);
 }
 
-void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring,
+static void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring,
 			       struct amdgpu_job *job,
 			       struct amdgpu_ib *ib,
 			       uint32_t flags)
@@ -1732,7 +1732,7 @@ void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, ib->length_dw);
 }
 
-void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+static void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 				uint32_t val, uint32_t mask)
 {
 	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WAIT);
@@ -1741,7 +1741,7 @@ void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 	amdgpu_ring_write(ring, val);
 }
 
-void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
+static void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
 				uint32_t vmid, uint64_t pd_addr)
 {
 	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
@@ -1756,7 +1756,7 @@ void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
 	vcn_v3_0_dec_sw_ring_emit_reg_wait(ring, data0, data1, mask);
 }
 
-void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
+static void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
 {
 	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WRITE);
 	amdgpu_ring_write(ring,	reg << 2);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
