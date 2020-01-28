Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFD7C32771
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 01:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D8D214AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 01:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nkVc8wZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D8D214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA8588635;
	Tue, 28 Jan 2020 01:30:12 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9D4D6EC4B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 01:30:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQdTSpQo41TMU3bwuD1Jn8tr/DOvHl0D8kYNeSWZKUQqqIlaNlp9VO6hGNG/Cvf0srt/rB0o6lyM/s/zhwReF7WAAO7M0scGvEmDEDYHUldA8gJ6gySUKh1BN7i0iOcT86rHNy7Rvfk64fT6JIMaLNYf4tt9CNPchB4sBVqVcpBKueZT2rxNChIXawqZclrX0M3mmbHkMQ4/5cEDQ0UV5NK8Zmne7psoHagnYA8DFuCpEkGJnjEtk+zJhGctTitmufYVv+D37Qjp8XPl5h9kKwqQRmGWpZ1mQ/6kao6IoWCMYhEpFqQOvo3/K4kgS7Yj87v/9jo8YavyaqG8ro312w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc/BiKp+ubA8D2MnmdP/8VwU9Qj9GWzQV2mketRcw6s=;
 b=HeMSFhhziJ7PYJbdmy4kxxXAdN/FdBsxN10zEGwz++tw78AcWtWmqvNF7SOF6137OW0P+M5jgNhEHfWjL79PkDhTKTwJisIB2ZusxVqWmTrG7eGzeqs+oqMO2571B2v/PE9yHKNNQFLX8T+JdVtgWHrsV44t+Q/QiH3vcFVI9yJGiiMDKuD0xARyBj5LFm0zPTH0mWTYes0moNx2AaSfJrbMMK7jv6InhIdVuu1rkNYK1Eh9mQM7XtCGRTjrujOHP6NEPG4eF0XmRlmBDrqfW3S0iCgKM+NV0dleERyXx2raLSh6abh98q2zS+4tw/AGI/AcyGyotUm0eIsqOfX/bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc/BiKp+ubA8D2MnmdP/8VwU9Qj9GWzQV2mketRcw6s=;
 b=nkVc8wZAt1HEJhtEf/WK7uesXdN5YKXWQXhBkicZTijWKJCT1fwnK06yAyczkuQkSFexAmjrERn4yPrtc0HVy9KLhLhAzquJLm8a90hz/dQKa61wwx1PxbG8kXDVshNEF57Q7JoATBM5LAZseM8mg833wb2hTIUFj6YJaFimy1U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from SN1PR12MB2366.namprd12.prod.outlook.com (52.132.194.147) by
 SN1PR12MB2416.namprd12.prod.outlook.com (52.132.199.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 01:30:07 +0000
Received: from SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80]) by SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80%7]) with mapi id 15.20.2665.025; Tue, 28 Jan 2020
 01:30:07 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v1 4/5] drm/amdkfd: show warning when kfd is locked
Date: Mon, 27 Jan 2020 20:29:22 -0500
Message-Id: <20200128012923.25536-5-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
References: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
X-ClientProxiedBy: YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::46) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.21 via Frontend Transport; Tue, 28 Jan 2020 01:30:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 447d9ef0-4eb8-4b39-7c2f-08d7a3919b51
X-MS-TrafficTypeDiagnostic: SN1PR12MB2416:|SN1PR12MB2416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24167E94C801BD018FDB3725FE0A0@SN1PR12MB2416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(199004)(189003)(26005)(186003)(16526019)(6486002)(956004)(2616005)(44832011)(6916009)(36756003)(86362001)(8936002)(8676002)(81156014)(81166006)(2906002)(6666004)(66946007)(478600001)(4326008)(66476007)(1076003)(66556008)(316002)(7696005)(52116002)(5660300002)(4744005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2416;
 H:SN1PR12MB2366.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7lsgMC3hl10pn1Af/8ItH0reO2/EjUuHhbKd3IiXH7LJfl/hc4jS/VimyeuuRe9QWsW1vz4r63nU2vjSCErOsR3qGwdd3mJuabMp98+dBP4h5IliHtO+/sBZ+IcxJVEmuPz3YpjZOEDd1xd7BXniovnm0EcKkpUR4eSsF15rqigSbu1fb/JgV0/CzJ1SA+SxDAeJp0ByxJBTNuyLKnUz7MrLDTTFc3vvkEnjiBgDljSf3SxSYqlxzmirmA8anfgz5HwgQ+jZ86D0+NohR3ZdXAfCOHaDpHBktKhVMxw7GfUY1VNsNjhShUW9IfHSMKte53tX2UCH+qvi+O4gPSVXw0pezvwoh/XRiK52jdJUk7U1zRqHY73/20z1Dbicd36D6fAa0cmlHov2FxHl4JMdn5DhZjLRTYzHvKSiK+tLx6ZD4kI16DoI2VUF+hFHaSt
X-MS-Exchange-AntiSpam-MessageData: KnwrFBT1giDD4EL3zN8AY0OCij2yBl+3YlINRs8YiP+1gl2q3dBGpVBmbiVc0z4paUDNptEnFDJCmTaV2XUSczwEkYEThIwQfXxEqvNH+x71qjRwLTrCqi/o0JZuOs3gtlxDCTZ1bTqJ19Y2SJq2vQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447d9ef0-4eb8-4b39-7c2f-08d7a3919b51
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 01:30:06.9367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1F4L/InQhTZjxECMVMcuaaapIVol4m0xcJfdYFtOktCOQxD7h+lKwr0HuwHb+cMveKEkwbk0fQYnlPMNhv+9Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2416
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During system suspend the kfd driver aquires a lock that prohibits
further kfd actions unless the gpu is resumed. This adds some info which
can be useful while debugging.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1aebda4bbbe7..081cc5f40d18 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -127,6 +127,8 @@ static int kfd_open(struct inode *inode, struct file *filep)
 		return PTR_ERR(process);
 
 	if (kfd_is_locked()) {
+		dev_warn(kfd_device, "kfd is locked!\n"
+				"process %d unreferenced", process->pasid);
 		kfd_unref_process(process);
 		return -EAGAIN;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
