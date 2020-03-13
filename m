Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28407C2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 07:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00230206B1
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 07:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JKvAuxlA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00230206B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C25B6EB7A;
	Fri, 13 Mar 2020 07:44:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0C3D6EB7D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 07:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fulggvSN9QfxPaTeVHXECMyEi539BAmBysM6m1q0OcT3mUKND1DGbcol3CrctLLwNvJaE9f3Q9Vrm4s4Fp2KiYrKeneYziNoUvTeaJ1blGTUClYHwM88O/alalGH0jeN8L6o6aPEylwhsrYP0qdkKfKbcTeTAiQRvhFuhPuLk+DNZvYZf0gkplUZEYqAL11IbjnodPcJzY3TOqidG50w18RsQQrxzndy0N0zreCIFD1C3q1y3bgII8Z6URr9mwyeDGj3qzk+C6ancTCiVsM2NWyaMXmKVxfq2rHFVFS7fbDVHV295WRtT5VvWO5wolGsDSaJIuj3ccMy7oNT+r+BhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lEPxLEP4+DqGklSAYKe8Kc3WK/KKDr0dBXdQJu/S8s=;
 b=fcZB9BOK3s7Pr75Bx15wnarLpG36YwcjrcpXILtX+xUHIMUHPlCqqTdDjTBucRdQnXjjG+wdxbdh7xjjEXffZ3zST05gEwouDE8pd0XFM5yI0ttNn2X5me6BVMW7onygXjIcc/rtgH/tl3lW13j5bprRABzEJedW4/lcLf2v7rU2DSbWBAHzY4xwVcZsYbvDbv8B+tyx/eNA/DQpF8CZ++OYr4cP6nnZ+dV48G1hOkdm0jzsvfSIaOvnoVjb6/ZE1pDswo9Dl+mL7Vp0GII7/Pl4iE5S5v6BwwbmhPSTxf64braIoICRH7XUS9RH2Hh8DdFlaxoRWzbAGizl2CdsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lEPxLEP4+DqGklSAYKe8Kc3WK/KKDr0dBXdQJu/S8s=;
 b=JKvAuxlAs+eGIKJNwfZT+ptakIDhAv2vKkDIIojJQ8ca1hmzqucdUFIrIly9fZbHSx/GL2zYaiDhwzHWq+EX7DU+sn6CbVko2tU3P6RBfJ1Q0HJNFYOtHCt3pZO6w0/5ITglCTZmgS/eE4eCEb49ldmOfg1wKDa44xjpm0HSyHQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2781.namprd12.prod.outlook.com (2603:10b6:805:67::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 07:44:03 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 07:44:03 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/2] fix gmc page fault on navi1X
Date: Fri, 13 Mar 2020 15:43:34 +0800
Message-Id: <20200313074336.19545-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR03CA0048.apcprd03.prod.outlook.com
 (2603:1096:202:17::18) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR03CA0048.apcprd03.prod.outlook.com (2603:1096:202:17::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.7 via Frontend Transport; Fri, 13 Mar 2020 07:44:02 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d6af13c-7257-4739-88db-08d7c7224d1d
X-MS-TrafficTypeDiagnostic: SN6PR12MB2781:|SN6PR12MB2781:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2781395774EF585A388D7DE187FA0@SN6PR12MB2781.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(199004)(8676002)(5660300002)(81166006)(81156014)(6486002)(52116002)(7696005)(4744005)(4326008)(66476007)(66946007)(66556008)(8936002)(1076003)(186003)(26005)(16526019)(2906002)(6916009)(2616005)(956004)(316002)(86362001)(36756003)(6666004)(478600001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2781;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TRWncey90vY95QVJsn4vdwIsRbhIgI2Uf0fiQE7736pAwrThERfj5dOSZQCHRcJxrekoc45aS+Pk1c+kd5R5QLkyH6s3izbUHU/o7JawWN60vB2evfu9KZENWGnzzkaPntdTeEES7dJhqiBcOTDUf1h+3X5X7GUN8lkIuPdE+J+QmL6L78EcacGFmop0OaBTCfy31XT69jwmGja79OvMVoqOtBkt3urjSUE9m4HYlWIBIDhTkLeF3XnwUcVgQDHK+dm9LlHXxuMU6LbuT3pGdJx2e++eD0coZLYHK2aPfNMOwZ6FzGeOY+26l6WE9XtYouEC7FwwBtfxxfe+aAg7ftBga6UbNlPRuTOnAS6lb59g14HeJjSDwQbOjk5oRj20ncnvO1V16rlgMGlCfeEaTq9gLP0s4Dnf4cl3iPuVk/CSN3QKXZ3AMoNZcSAwqq2jVBTH68O5pRitmHGFGNjwUeIBAPnXtwz6P/vd6Rif4jROA/U777agEW6LcLE7opPm
X-MS-Exchange-AntiSpam-MessageData: dV9ehgaXhgUTbfjC22Z9z1yYUlUMBtNbLTJLcc2KedoCxoFFXzTMdqp5BoASXRQm30SauAFkt+NcY+Erpfk/FMwt8hz/pzv4bgKyNmYE5B/H8fBZMJul9ZfDqfvSoBLT7DI1XXrv1yyPQPkEioF+mQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6af13c-7257-4739-88db-08d7c7224d1d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 07:44:03.7058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lezc4stOxjrWnBVQsRpi+U94NSNBQ4AsVGi9ZfE+gSZuS72WJor7y6QS5sGxpzYq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2781
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
Cc: xinhui pan <xinhui.pan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We hit gmc page fault on navi1X.
UMR tells that the physical address of pte is bad.
Two issues:
1) we did not sync job schedule fence while update mapping.
we sync resv, but the last fence is not there. So any wait on the resv
finished before job completed. say, bo has been released while job
running.
2) we might unref page table bo during update ptes, at the same time, there
is job pending on bo. and submit a job in commit after free bo.
We need free the bo after adding all fence to bo.

xinhui pan (2):
  drm//amdgpu: Always sync fence before unlock eviction_lock
  drm/amdgpu: unref the bo after job submit

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 46 +++++++++++++++++++-------
 1 file changed, 34 insertions(+), 12 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
