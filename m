Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA0EC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 19:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74708206F6
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 19:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xmRQ3vvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74708206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1536E073;
	Tue, 24 Mar 2020 19:48:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E98F16E073
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 19:48:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQG5mjYSiRIDEKLwyAVAXMT/VGwgJFgoJuPaGJxSxcembjT27MICKWIx183omzwjAMnfRZoJL9m2sv7wpF9Bzw4HqaopDwO1fBsMiyEktj/A7mmikMilxuo2Bc9LyMzLNKbT6jlDwpi1nzwm5aGfrxKtzW6q60STdWQ6Bd45pnzvhAjrK598Izh4HyAK5X2WvFZoVUr93n0ot9d7lP6JAoVJ3PUqWVsWqOMrqs3uezKgYb7xfPOM4mt5mEfYkjI+0ZjC3zw87XR6df109gBI8rDFtZ2DI17WMG+Gw3EYmJTsiV5fGxf0IeTDfSwnyvrXGKtU8EQczgYryDNVJKSHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpPkAHMf7n96Kfs/ahfdGkXLmp/21vfE/8UimHFvA8M=;
 b=oah4blWiLdeMn9OOz4Hg5+sAvzZ2GcvyznboqERuhKr2rHw7dkaj2Usf2dyxnsD6+6Y7/sPHriWJkjtiANYoKMIe2JcLL4JQM8NjOg0Xe81AhAP0NGC/fg45YxHVLg6k0WfJsYFkbsx2XcwhGO84L+4eU0zeipiDw4XUrdrr1mFCKlQfnPf7nsKGiFjV2QoklraH2CsxrAJNBsQC0Li4+gwusim/8MToEhd3y6NAP7Fw2v1NFnQo+tiuwgv2l7SfoF/xwPulnuG2Ip4Qk+Vr1tJmfcGwRPBPX7+XTeO9kfWjAM7kXpteeH8lM82lJkzFDN5EvWIi7UJKupGEpxGh9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpPkAHMf7n96Kfs/ahfdGkXLmp/21vfE/8UimHFvA8M=;
 b=xmRQ3vvvFX+I9AMQOtRl2nqq9Piw5ePcXw/BNYgimKFSvAexj/QFG3h8J2aVMsiyy5d4y9wO/9Lg1OrF/JTOJIK8Ve4OL+GQfGNBFzQE8tbdkwItxOZQqJ55bv08/b6McZCqw7sLOJMtnaoBR9/Ubtq68BSJ4cmvCX9JKyWS6VI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhigang.Luo@amd.com; 
Received: from CH2PR12MB3685.namprd12.prod.outlook.com (2603:10b6:610:2d::14)
 by CH2PR12MB3687.namprd12.prod.outlook.com (2603:10b6:610:2b::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Tue, 24 Mar
 2020 19:48:06 +0000
Received: from CH2PR12MB3685.namprd12.prod.outlook.com
 ([fe80::adbb:a132:630b:6f77]) by CH2PR12MB3685.namprd12.prod.outlook.com
 ([fe80::adbb:a132:630b:6f77%7]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 19:48:06 +0000
From: Zhigang Luo <zhigang.luo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add SOS FW version checking for CAP
Date: Tue, 24 Mar 2020 15:47:45 -0400
Message-Id: <20200324194745.8276-1-zhigang.luo@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To CH2PR12MB3685.namprd12.prod.outlook.com
 (2603:10b6:610:2d::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Zhigang-WS.amd.com (165.204.55.250) by
 YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15 via Frontend Transport; Tue, 24 Mar 2020 19:48:05 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a00a6419-10f9-4498-2c63-08d7d02c456c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3687:|CH2PR12MB3687:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB368711E0F8F79FDAAF0EF9B0F1F10@CH2PR12MB3687.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(44832011)(8936002)(6666004)(8676002)(81166006)(2906002)(26005)(4744005)(316002)(52116002)(16526019)(7696005)(956004)(5660300002)(36756003)(6486002)(2616005)(186003)(81156014)(66476007)(6916009)(66556008)(1076003)(478600001)(86362001)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3687;
 H:CH2PR12MB3685.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hJ1fWeg/ECqZ0Af9JPmT9PjSMiNnrYST65l2NKu+XeqHmd4nLqjh3CUay8MPEDU4zRhGXY655c6IEILLniJHjqjJWHTTRsH+NRPWdBXd7BeNoOwCjRDx+QC/Wr26oZ42H4vHrudMwzAfowzjq5vBh2gI18ZvDJLK5jg95amxOx3wjYMxYVHTIQAWL+ufF9dfs86K7SgfwVvIUKkBtipDNNDAyX9R20SN4bg2EdGFPZOonfClI7Dea2juRkpPjW+DV+6p4lkspit18bJjs1UcgEv3PqEg2aMPCYLoOx0qm29OwtyF0rKzfuVEtaIziNgIm6SQ3E+XTioREo51yiw+1fhZjWy3YP4ballUGJuGbleDTFsVVtWETkzPHfMIBsXwwkHtJ+E75nLRSgVoxyTO39VHUBVrnlKPruQwLNy300lB4VGMr1tcn6a2ytdUAPG
X-MS-Exchange-AntiSpam-MessageData: wSEdf59/10Duc5e6bnOy4KnhWJt0eP1xA3jlovV5wdbArR6DdXUB5gpD5L/YpocQAFZ618vgKRanKo5DqmpEaDihrKz4wiJUjgyloaC5NSsQEFA7VFcY5XbdS56VoHr+FKOJ41HukYkGyTOgnXnWGQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00a6419-10f9-4498-2c63-08d7d02c456c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 19:48:06.0298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bf8J2w5pK5eYbizJLNqLJcb8Ib5FUXvaLDzR7hgjQr6kKBfGoXg05MfBWHCqoy3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3687
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
Cc: Zhigang Luo <zhigang.luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To make sure the CAP feature is supported by the SOS, add SOS FW version
checking before loading the CAP FW.

Change-Id: I7aa1c09f9c117f67ede0db6cd5911d56c8568495
Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index dc42086a672b..c2bf2d900039 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1407,6 +1407,11 @@ static int psp_np_fw_load(struct psp_context *psp)
 		if (!ucode->fw)
 			continue;
 
+		if (ucode->ucode_id == AMDGPU_UCODE_ID_CAP &&
+		    (psp->sos_fw_version < 0x80F5B))
+			/* 0x80F5B is the first SOS FW version with CAP support */
+			continue;
+
 		if (ucode->ucode_id == AMDGPU_UCODE_ID_SMC &&
 		    (psp_smu_reload_quirk(psp) ||
 		     psp->autoload_supported ||
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
