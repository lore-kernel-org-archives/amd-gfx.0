Return-Path: <SRS0=aySl=3V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46DBC33C9E
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2020 03:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786BF20663
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2020 03:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gjKaRcA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786BF20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 394F86FC77;
	Sat,  1 Feb 2020 03:37:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3643E6FC77
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Feb 2020 03:37:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WU1jMsMiMO3ULnoTtEGsfOJ7BzN7IMdLW9WJB3HUueaBrryxllK0VLFz7UELPZqoGxbdrHMNTurC2rPh46H0u48Rv6jUC1H89Nt83iuQO4wkxJ+g1bqgQOkpNOZBIj5B1+8+S3xOirHnn0jPnWsWZKU7/3dAriLUHI+dguuGeh4VhbdWSqr3Tvn7uYcgEtsTRWuTIC8G8ggt+YtEjz8QI6rIk2NyY0Xo9a0AA1bgqJUixEfUfqsEZROUswT+HDAl7N0TDVrNTjZASTYUaNx815KKT2I7im7okRiSm1xNSo5Ecun+onZu3n4WUolCmyB+Qk/p/+o7nfp6VOsGOW/uew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mczYanT8yJZSHP8RCvreLc6Ci86CdMfmJyss0SAH2zc=;
 b=c2b4o0ic3gdXUi/8aqOztSmvHLxdabybuvA0jlaC19T89XvF6MmcX33131S1zN/gbfm/ntppCjuAokWOlhSkYaV8OVdxDzpR+O/UCyT0MuuEHpLvvh51SLSxvBC5vO0zrbfEN47wp+ufbhjuY6sFWtKMe0wd4wy/Vbis0/bB4ldx6dk20BY8RztVMcyc0+AJIR2l95IegUABhXoCQAfU74ozxBMkkrUWVnBnC/AtJgHTVmA1kUTrGRtmr1ZopCOsqsq0pEIiaNhw/8NPcBr4ST5sodmId2zpas/aYrCW58Iw6zgnKBelwdHO7e9N1WABJSoLAFIxsZNxcKvsQoTocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mczYanT8yJZSHP8RCvreLc6Ci86CdMfmJyss0SAH2zc=;
 b=gjKaRcA1j3ks9ikaUdlCICCc/zQLPgZ0vgVQl7BevDiajwQw7bxbfxRRA+wEDXpv5oThXQ4eQoOq4iO2GvNRJLVMyeseUBYmHFyPqaAkHpKDyOBWkcl0l5c+NBq6pyTKhyM5PReFxZRXmgDKQdmk/bSbtbRitVighNOVea3EAds=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from DM5PR12MB2359.namprd12.prod.outlook.com (52.132.141.12) by
 DM5PR12MB1849.namprd12.prod.outlook.com (10.175.85.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Sat, 1 Feb 2020 03:37:28 +0000
Received: from DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f]) by DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f%6]) with mapi id 15.20.2686.031; Sat, 1 Feb 2020
 03:37:28 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v2 2/4] drm/amdkfd: show warning when kfd is locked
Date: Fri, 31 Jan 2020 22:37:05 -0500
Message-Id: <20200201033707.16351-3-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200201033707.16351-1-rajneesh.bhardwaj@amd.com>
References: <20200201033707.16351-1-rajneesh.bhardwaj@amd.com>
X-ClientProxiedBy: YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::19) To DM5PR12MB2359.namprd12.prod.outlook.com
 (2603:10b6:4:b4::12)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Sat, 1 Feb 2020 03:37:27 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4660ae20-3488-4dab-e4cf-08d7a6c80f50
X-MS-TrafficTypeDiagnostic: DM5PR12MB1849:|DM5PR12MB1849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1849FD7DE4A19A6627EA301DFE060@DM5PR12MB1849.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 03008837BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(189003)(199004)(478600001)(81156014)(8676002)(44832011)(4326008)(36756003)(81166006)(52116002)(7696005)(6916009)(8936002)(16526019)(6666004)(186003)(26005)(86362001)(2906002)(6486002)(2616005)(956004)(66946007)(66476007)(66556008)(5660300002)(4744005)(1076003)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1849;
 H:DM5PR12MB2359.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBbYw6Ck9pn2XkVZEh613XW7fdTiBDEhnnanIlf3s2d+lLZR2w8aVOA5Z5MrnGUT1ytobAhLoYxjP0i+0hSU9fasUtcxgGUBvLKG8G1FQo9PMru3PC8wGDL7lH4ATR1m+l+O5Ob8TRzdyO/tZLHCwAhublwd96EJD6WMlo+4MnowC8pIpCqH+zsLEMojePYCfk92coNUvTqm2E4Zol9wJS+Y+ysm8xpkeNu3SMoAFdlffAm+wQpsJF6/22aCezYuFX8BdqEQoAzzN2eeWpkDfOPzrGM91QEGlEI4CT/JtXs+hWrUbZxJBLIwM5JNrIuydlRhhAkh82mNzJ1/cv2ikE1qM0jZRU9c9kKqGwwYjEL91JsvEkORUHbGL6lPhoLfSED6q0065rMK5Q2F0xg+eVx2aO2jjjT/079WDvOrw87v8SQTkRTY4FJAe9x/fzzg
X-MS-Exchange-AntiSpam-MessageData: 0J/U1VuoHWQ4cULD0XPx6XDnAHj/vdNLMgVmM3kH/nJLoU2sOpxfOQnl8cZPl/uNqRp/em6oIKTtwMjMESSWh1ewDIK/eS+Pl2rY7CluGBjqf3taE5/1W39tqu8OKhxLhbcZF6WGAvpg9iHLCMmavQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4660ae20-3488-4dab-e4cf-08d7a6c80f50
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2020 03:37:27.8962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAq9iDlQu6/TXy/rbAZE548s6EsCZDMJdVUUgOb/jDitt8YO8JiwcwhY23WHRn8RHuN5IVe1PU50JVpXUv/a5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1849
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
