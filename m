Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCF5C352A4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 18:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708CD20733
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 18:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JVBGTE4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708CD20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05DB6ED15;
	Mon, 10 Feb 2020 18:48:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 355116ED15
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 18:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0mQmjaIXHeQrsyG+RlIyVBIgKjKHXsEY9ZZ3wJo8JpNR8J7ZgYDnqpafMRnzRFKScIi4fRazGRG62euUgs9IqEJJU0ZE4cCvengOth/aYfTRzwiRXg25EV/fVCZvfhl79GYEJsV09c2vyFCFrv5fAMUZ8Xm7ouSsPVpdEJcHG1lh14u3YAOMqLtFsFrtqeW5HvqLFMZRAci7n4O2OrmoBEcaqMKWtndb8Kcf2x+a49dcTDZg4PYnF5Wj5QV3kn6LGFZ86/pvI0NVsWdG1RVcJgXEuVfi4MJCoeLLr2qdoDNx0dpHr6ezrQeicZvN9kdO6xIdCIDbNIsYUdbpOmfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEivH5zKNcRMZqZhyKi6zY2BS+dxUFYeJZkz6uFD9Vk=;
 b=FXbBGHy45DKHhGmn667qJDyqJ1acCV6gFHn1v+qlqwdxuP8YIUFkEBPO1G138EwkjJgANE1qRaiEDS6GiME8LxruFuC2fK8r7vAtlOOSzu0A+Gg9NkeJCwXsF3QzuYiF/MkfeP09IVCWCN3FAUfmZv9zX9xO2wGYrLTv1jDTpuMlRuy566akRsBQ06QXgjCIHAGrifgr7aoE9H4ahAXjHovprgGgjXPtHRBNdw6WaixUa6OmznrfYOKQIE8giMzW8yJpCU+j7mCx6ZVNciRyWjZB7ohGyBBXbiyiVdpAc7tgsvyIvSbcRpctpmgW/nMChjsn8j0lRcBLxPj9eNJD0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEivH5zKNcRMZqZhyKi6zY2BS+dxUFYeJZkz6uFD9Vk=;
 b=JVBGTE4nZlSX3ow0bL9+ZdtA/MVwyepg4odpBuneKTIX2ye1FS55vfYXbswr37Pi+uGPF/2jWSDeFir88BDkCw5tAVA6ny7sD8nguzyMRLMjnTadWucZi+B7Dh9rK/c/ddOFcGC5kSo0ma6dL6CgcB4YfkCMMfO99ProtQMsKy4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from SN1PR12MB2366.namprd12.prod.outlook.com (52.132.194.147) by
 SN1PR12MB2384.namprd12.prod.outlook.com (52.132.194.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Mon, 10 Feb 2020 18:48:23 +0000
Received: from SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::c6:3b8f:a441:6bd4]) by SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::c6:3b8f:a441:6bd4%7]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 18:48:23 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v4 2/4] drm/amdkfd: show warning when kfd is locked
Date: Mon, 10 Feb 2020 13:48:05 -0500
Message-Id: <20200210184807.6271-3-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210184807.6271-1-rajneesh.bhardwaj@amd.com>
References: <20200210184807.6271-1-rajneesh.bhardwaj@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Mon, 10 Feb 2020 18:48:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28cab6b2-a7c8-40df-1404-08d7ae59cdd6
X-MS-TrafficTypeDiagnostic: SN1PR12MB2384:|SN1PR12MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23848D5EC0A60269F0582B0EFE190@SN1PR12MB2384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(366004)(376002)(199004)(189003)(6666004)(4326008)(16526019)(186003)(26005)(316002)(5660300002)(4744005)(956004)(2616005)(36756003)(66556008)(66476007)(66946007)(478600001)(8936002)(1076003)(8676002)(81156014)(81166006)(2906002)(44832011)(86362001)(6916009)(7696005)(52116002)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2384;
 H:SN1PR12MB2366.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3vK9BRko+IReKpUChptRruFapdR2Niv7l8ISRc/JTr/ddZnIX5uCGGR1WVJp/MhKVeZzd8q1eeo6nqFh7CVOvVF5nRg658Wz5H8V4bcpk9Syr2bcq72X+TWjgIUUg7+9OVsipfraMCCR+EHPmb9ax7Ic5DVCUTjdhtdb1SU9h2VBdH2DJm8xUb2tVDODIiq4bWUFS/7mK9Y5hELyOfqE9iqsFHPEUMpwqExqWKokgA0M86dCz2QDECb2f2S9JDzXiRZizOIqx9WLj92BVRApoL5j63MALZqlX50odRlZfAqIngsXofeYTed8wpu4Opzdtb2cIs+z7CTxqIsji7e5x64V+hwOrft5LWWHSGZANSTFtUf2CuMjj8wwYFf2Jh1dtU5R1H5meib1my1tPqtaR6CYsVxN6J4b+NsIJBUzgeYInWtnSy0SLi+NzegNt3h
X-MS-Exchange-AntiSpam-MessageData: RTizS8nLXBErzy8PQCfG/0N4b9bHVCNTIovgMh+82AxJ6reJ7rCtACdhyMuCXv6fZa+orL4Yugh2zdlfsHHl9n36ZoAANccgP5tsulgrLqOnVib4uiV8/H2Ecn9nmKAj5FdEx3dXJaN2BLEH6oPlSw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cab6b2-a7c8-40df-1404-08d7ae59cdd6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 18:48:23.1342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gt5yEjS499qc/gXBY4kV6sCnUz1Bb1us/U3dxuGfX6f3CggTQrP92qjYDobMoAZeeeDkp7TBaB0Y33naVl6PFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2384
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
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During system suspend the kfd driver aquires a lock that prohibits
further kfd actions unless the gpu is resumed. This adds some info which
can be useful while debugging.

Reviewed-by: Oak Zeng <oak.zeng@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 275f79ab0900..86b919d82129 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -127,6 +127,8 @@ static int kfd_open(struct inode *inode, struct file *filep)
 		return PTR_ERR(process);
 
 	if (kfd_is_locked()) {
+		dev_dbg(kfd_device, "kfd is locked!\n"
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
