Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBB6C2BA1E
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501A320644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="I2VZpwDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501A320644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A7A6E2B8;
	Sun,  5 Apr 2020 20:42:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 625306E200
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUJxwcWP22NfMN16vbF8wXYpA1FVNnMAKBmWdyKHWHHRIP9LeFFxmxP4mZTCuK9o6U18lpdFcikNuly5ZBP6FeKfHthMm7rfs/fh1NRZIs+WYJx54kR9IHgFufv66Osi/EDMSbxDS7ZEUHgHM8aiehm0chxQiJCIKDgk9+olFQ7CYTM5af+uDSbFHmjuupymO+r9vQSR0koNPGonP61mwIv+pG7hcTV19khsl9Auzuy7xSFsYOg7wfpOJ1vv9WRKEzJfw61Pe51Bn7d+D0T0is4ZdHo5qVwQZAecpT4thJwWNfa6uY2JrF0pMttwv7GU1OcFdaXcdNwodbycmolvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+pOyz8jvyk1OGWLg65J0z+l5mKa+ZnXw99kh5wYukI=;
 b=JFrtS4EHem87vZakhGl4fmzQncRVmk7MmZ3kd+4PitT/6b2odCvuSK8U2GbSqUdgi5oY4PG9ACJ3DO+2wkB7ELBl4UpNrczySJonKfKhYqmRygMVHYTMMqeF4g2H0h7iJtpb+6OPfJBp7ANmex31DG0a/jLd6SPVRgFO9ntYgCvBRC0z8TgZURaIMpxsclc9TGVe6kF5OhrUINe+4s/cy8JNHmCy4eOHFoUKjQpLv6txP9XHJa0wIioiKsySyEeQ8bGEQcu+5bzV9GRUG3eFu1VvxO25P+16wnMuU6OcLWEcsdp87ZGaIF6cpEV3mJ/bFowza8glSWv4RFEg5HBJKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+pOyz8jvyk1OGWLg65J0z+l5mKa+ZnXw99kh5wYukI=;
 b=I2VZpwDARUVst7TL6xmYn6C/LjGZZGqpUKP4+grx0gWjZLAm7btXI+l1jZ/DVdkHXWVPostWsZDUxGvpkhynMR0Gb/FKOr9xxMDRQOMku7MiEW+FaG3pO2+hvi8k8OYqyQISmCi3fwXWjqnBr8z/6NfFEOKnmA1/ubfO2WyaJZc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:42:00 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:42:00 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/36] drm/amd/display: Update stream adjust in
 dc_stream_adjust_vmin_vmax
Date: Sun,  5 Apr 2020 16:41:01 -0400
Message-Id: <20200405204115.683559-23-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:41:59 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: abef11fd-31d6-493a-75b0-08d7d9a1ca4d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555A6ACADD59F59AF11691598C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(15650500001)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(6666004)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tnfU9YhDj0H9Yvfv7LwUpz4rAdp8ZWUNkuUxaxNLb3zuteqBijxmEU8u1FwiSn73CszdiWfmnImBCBeRxt1SO/XoJ7NJ1BDI1OVsZ8gYPdDw8oW8eGbWWSnqYcwVXo3qNieKkHXrhtrk2lsdu3TiQrnQqsKmBd7SwBiO1qkbGOM3vGWucTPKTulxK3VDfpx+TM1Ix9ZTY1NpBNrKXvnoUFDn0GE9Vcwl2A1P7AMVS0ygfNZ3yqMePc4cWbmy4A7ejyismLtZD8Y5/AWs67na0Y5bKPYPOL+Uf+aWYpKCWDrY9jzw8ujcpovE6vrXzy8CoMjdRSN6B1I5DnDyx5aGXi4LhtGolt+ATRnHEVUcMg7WoFSh5hfHomJossLLVyAlRxITLKikkkBOfs9TxQZ17wzeF3FbkcqqW1AEtIP7+TmyL7o2cyMGaIk85Q7uQ+bt
X-MS-Exchange-AntiSpam-MessageData: SmmIHMFnoAroowqqtNm4SMg23GeKxZPDTKTgSy1TLhWG4Sr8j91l3CU5OBGIhpAoYUPP6Mz5RPOEZCCnJE1dVjrpJaD4y1r6FjbHWJ5WKzlDCxWTzAETURB29XCIFfvYjatwmyyCbQKylsuIQ65XGG9M4q8egXaNNRcmjfZPbbA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abef11fd-31d6-493a-75b0-08d7d9a1ca4d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:42:00.6118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhpCq7oEskiLXau7x3YhT7GAF/NxQM6s+06nD3phA7wf0qrOmyL8QnKsPxSoBaIINaLH/RUwynv6tDD9Ux4MTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, Isabel Zhang <isabel.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Isabel Zhang <isabel.zhang@amd.com>

[Why]
After v_total_min and max are updated in vrr structure, the changes are
not reflected in stream adjust. When these values are read from stream
adjust it does not reflect the actual state of the system.

[How]
Set stream adjust values equal to vrr adjust values after vrr adjust
values are updated.

Signed-off-by: Isabel Zhang <isabel.zhang@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6379cf71d9d5..512703eeaf82 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -283,6 +283,8 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	int i = 0;
 	bool ret = false;
 
+	stream->adjust = *adjust;
+
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
