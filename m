Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09CFC2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 16:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43897217F4
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 16:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N2hhbtoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43897217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C17C56ED9E;
	Tue, 21 Jan 2020 16:19:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 708B36ED9E
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 16:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBJqBi0joCy3qKlUMubDljtTXzvd+NlqHZN0S8jNUl/fqIOp5akH1LAlHLWHn2TjDdRU4ilnvCF30GREEGH2CpVVz6wXkyZr+tcaViy8s1OW6Z/Vpdz9swpxQzKtyN4f1gGgfaJLi9rTv5R7+hPpAq+yTwHbvLwr+0WpkvUOxNWcpfW/9344cql97wLRiXG/ylaWxlfi0T42DjXqOxYLzx/+XFENXStHW/CWFC9vEznd80EZuAk/FB+bW88pRCPhx/MtbsaZWCVW67Y0rGeTLoPsyI5E4CrwSyaLdTi6IUP3JQxAAdo4t9jveNnxfpuDT+TWImOcZv1WXPfYOG3SSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzUjKaDxTQPOEnjmIJfEdh9VAuDN02bxps3rG0GlVfA=;
 b=cGUzTlTscWozUweC+ewTVCO9SVzY3IeeApcHo3/An5HcYSZEHVcDYWMOCkhaPO2SNlqKT9qG99Jjs5tpi1Ivgm2WPyhj0hXJVPwBmqUCkWBCxN2yWMIt42FiKsokVWgqtJUJ02ErtrhtIx7fht+qaoVIuCy+qqoS0Yvqaj+RD9959uX/6ri0+DRzAfgbz7Be/AVgcmisOjDY6kJaa0Zc7Mg87RiNwrrqPyQIynWZSE9suwHs5fumYdcO46z+a99Od6Gx369qrpiGtIOG7gNYPZ7UiMG34IqoINLjOVLYJKqXQiNbkM5lUjnKrvzO1rbFGNhGOljYV3xoPcnEP+eU6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzUjKaDxTQPOEnjmIJfEdh9VAuDN02bxps3rG0GlVfA=;
 b=N2hhbtoMYlrt6RIalV4GB8nyjeBcijZpmjJI1/j+RWDTOhZAnkEkWxgR/WIQBNj1PjkFJOX+iAwyTDbS0Al20a1rsvYVJQPtnY4h/tk6+7A6WvQYPS2VrjTuG9w+CT4yGna5Mnhaj4Qarzm3+mGJO+9ILP+YSs2yN0/vdP59kbs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB2696.namprd12.prod.outlook.com (20.177.124.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.26; Tue, 21 Jan 2020 16:19:27 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 16:19:27 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu/vcn: Share vcn_v2_0_dec_ring_test_ring to
 vcn2.5
Date: Tue, 21 Jan 2020 11:19:13 -0500
Message-Id: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::39) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.19 via Frontend
 Transport; Tue, 21 Jan 2020 16:19:26 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3303a06e-3647-4d10-63da-08d79e8dafb3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2696:|BYAPR12MB2696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2696C7BBD3C422C06AF1E19DE40D0@BYAPR12MB2696.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(6916009)(36756003)(86362001)(81156014)(8936002)(2906002)(81166006)(8676002)(498600001)(52116002)(6666004)(7696005)(26005)(186003)(4326008)(16526019)(66556008)(6486002)(66476007)(5660300002)(66946007)(956004)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2696;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYzSqMHEdpSXaC+y8iVk0cSOJEnHyS3d367M1I0B3JNr07sQO+56x6iq4A7K9L51hWXcYs0L5kJrbFNm72TFnuFqQ486hrk49Mjg3EbTRYuFJYsXI+Gox8KlPAdxn2yWqETE5z/wOa+RCxBqa1DDZPh5j7Z87HqUhYHD/JMns2yOA0xWAkLo9eng0j1zI6gujC+ErqIjEOWLdCI9w/UjYgtvn6Sch3GMt/Se8HXRcPv8ew+umamFY7Ech2MX8RokXCXuA+VaGQcHSCtouOhpmX0NYLaTlk+5nmq1ZxSf8McBDIRKvxjjelG4boyDq2qRsHG0A35XkzSeCPiG+Hduux1T83cJNhC+4KrG6D2mllm5+LKC48k/imyhhhNJ723cow+y5DroEP1Q+zy5JBz0JQT8an4zwDPsJVBLZprd3QHDjvCM0+2pTKaZwmxcwDqx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3303a06e-3647-4d10-63da-08d79e8dafb3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 16:19:27.2910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yB9ahEKDZ0siPaEPNyfdDveuHK9uUPAYRjAj+kYZZZcLIaNqJnGgRAGi2/FZiuob
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2696
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

Share vcn_v2_0_dec_ring_test_ring to vcn2.5 to support
vcn software ring.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.h | 1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index f4db8af6..e2ad5afe 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1624,7 +1624,7 @@ static int vcn_v2_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
+int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t tmp = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.h b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.h
index ef749b0..6c9de18 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.h
@@ -37,6 +37,7 @@ extern void vcn_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 				unsigned vmid, uint64_t pd_addr);
 extern void vcn_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring,
 				uint32_t reg, uint32_t val);
+extern int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring);
 
 extern void vcn_v2_0_enc_ring_insert_end(struct amdgpu_ring *ring);
 extern void vcn_v2_0_enc_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index c8b63d5..c351d1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1488,7 +1488,7 @@ static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
 	.emit_ib = vcn_v2_0_dec_ring_emit_ib,
 	.emit_fence = vcn_v2_0_dec_ring_emit_fence,
 	.emit_vm_flush = vcn_v2_0_dec_ring_emit_vm_flush,
-	.test_ring = amdgpu_vcn_dec_ring_test_ring,
+	.test_ring = vcn_v2_0_dec_ring_test_ring,
 	.test_ib = amdgpu_vcn_dec_ring_test_ib,
 	.insert_nop = vcn_v2_0_dec_ring_insert_nop,
 	.insert_start = vcn_v2_0_dec_ring_insert_start,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
