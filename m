Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8721FC433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 17:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F357F221F1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 17:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xe8EW6cD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F357F221F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC4C06EA78;
	Wed, 16 Sep 2020 17:09:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A73726EA78
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 17:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLeWG17Ixh1kLM3p8ZM1+qfoJrR9l/pgd1fLeCy6SqVl3gOl+V/LFxAKLVSmvk9uri/gm2MDi6RXpnKaQMBZcfV243XzqVUSddiv9XGeNU7cW1l1+x7iOnSND32dV+U2mwqxbdXmAepNGHwK6bi2set/lpcCS8IWoiqvSO6H7t2UkXjiIbPW/CWFyvQLlEoVKhsqj4NWsMznB+hLK+/Nvs/WEKXyA5UCc5FBaK3oY1btDXzuM024juFacEM9u04ojIy0yDh55SF1AvF6JbMcj2uJPZVpZX2Uc3TmXqtUuN0bGzXwmxix6yRkwqo51Zi54KrvaZieA1mvTsX1BEiYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1Oxz5kJxpFVe6X0KDvzQeGMEi4TeRWa/ybWmeKodt8=;
 b=NrCXugFuc/Irba74/cFd6ImrbJjAOfUe8lIgM71k1zCjwAC0ZABWXNmJ0PzjeMBM9ShhK3TESNWUDmcJHp1gFlXy2tfsr/X9SfvX5z+bWg5VIBLW6abpQEvFwCRBAkS37HnGOmPsLBp0fQqZSxImz5l9ZK6slZrc4zITZ1zZpsLKvMM2W6+UEd4Da8GO7vegWWBJW/MDsPFKhOTmGky8zAnoCNF0RlynCpxMHdepy0/z2CFY3X8R6vr9golfro1dgZ2Sx3vTmtjcOUoOftnL/IRRCxNSpXAkeOz5ug0li6uPaki44E+gaQHLzftf6x4tVudiPo7f9ekkwbyjpYygjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1Oxz5kJxpFVe6X0KDvzQeGMEi4TeRWa/ybWmeKodt8=;
 b=xe8EW6cD90YFuJ+D5Y1oHpspPNhz2LbRdlgrckcxbcfPZKeT8/8xWxrICwyr+BUdqvS+HxG0ppt1t1UGQKktfldlaHXeHP+znOVlEpLC3IKT1Hg5C5xDuh4qtiimLh47f1mMAWQNlWfLDVyEjeWgy+ywCU75saElZ8qzfeluOEA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 17:09:07 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 17:09:07 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: No sysfs, not an error condition
Date: Wed, 16 Sep 2020 13:08:39 -0400
Message-Id: <20200916170839.452442-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.28.0.394.ge197136389
X-ClientProxiedBy: YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::39) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Wed, 16 Sep 2020 17:09:06 +0000
X-Mailer: git-send-email 2.28.0.394.ge197136389
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e001a7f-0868-403d-f3f4-08d85a63386d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4372:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43723F40E158B6003C0B4F3999210@DM6PR12MB4372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJlcA/6xFAO+9/X0QyrcH4REIofkOiFwWQD/mXMXXQEalnGwbI1YNRjh8CwVvPNDwZ9s/dpCcmkUjTnBELBYy8agzSf3IcDOpdUJj3u1g3O+HyIYDC2SuHqt+RGj+reDVRgfwcbAgvivEz5hvSQUOzW8HnepCJDeWI9MN1bcVbVAJgE9JVhn8CL6vkwsXV8+Y5+5zBR2i5sYHDfhDk6rQxhOwKpRkz5PWAvxNYpBfVuOewapruSfhdLbcOejqjlrNrJxV5c5d2zgkar9asPhmM+mRppdrMWVH8FtuoffRHuVz+47RFHJLwvH9+iSk2nWBuH/oa0LOkbVeTT9NS6nEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(956004)(478600001)(8676002)(1076003)(8936002)(2616005)(54906003)(6486002)(7696005)(52116002)(6666004)(4326008)(86362001)(83380400001)(66476007)(5660300002)(66556008)(316002)(44832011)(66946007)(6916009)(26005)(36756003)(186003)(16526019)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ddWJAChKUrDkctoBUOzutup9JavWZjHAeyre3uRSQYiIfJfC9WrZlHH4oo0GmZEn1wVKWFetWHPyJnWc41zCP1ixcOji+GyuXRk+yrG9HcqBIvP0j8SLmmLsupn0vMC4K1Y+ffJG7QrLU9UagaC73NyRW7TugZ4Bh3wJALtfNnmmwHSxMs6oKQ1+Qk4wyVd6sjqV/g29luDgsw4K8YRyEgU8Fp33L0n0BpeDdv+lOe8I4WpfLC7XXWKPf4HFhhjHPdBzIAjOs8Ceg0ldj8AgQ/vs1hnc4czi4Eb2cYzwJdm9swmEH2HW0nX0mpx7ew5GgovTWiARKfGUDlrcRldYENzVWN6GNA5T8KlbLrvStR2LH0cVTcxrQqioT+GEzUH0sEtZ6Jt/3m9oO8g++zH8lhyFBInD0yL/QEac5PJ2PbnJ3D/5Si1/AMDFRChWiVYUMn63RGkjb64h2INUlsNHbPASsp5WY6I5PIxSIBuREeaDUhcCmitc3yUrisQcsTm1Uze4T5s7dG4ILGmjP/YtMc5RmDsWDT1aHzi4ZFssnUpwi2yvBFYs9lHDZmo/lc/EtzwDGBeh99gjqo0JSqpkDiCBDJ52XU28ED3GKWlbgslcnD/FnmBFSWJ0GaoWMG5XLGEHnyB2FBqQSJ7vv80iQQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e001a7f-0868-403d-f3f4-08d85a63386d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 17:09:07.0195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lP37Fe7pJmNlKj3IFVejCo3bEpRDzstBpxlEbzz9k8KvBEKGp0hPYejVp/lOHtSo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Not being able to create amdgpu sysfs attributes
is not a fatal error warranting not to continue
to try to bring up the display. Thus, if we get
an error trying to create amdgpu sysfs attrs,
report it and continue on to try to bring up
a display.

Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5d702f6e77de..62174f5e8311 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3400,10 +3400,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		flush_delayed_work(&adev->delayed_init_work);
 
 	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
-	if (r) {
+	if (r)
 		dev_err(adev->dev, "Could not create amdgpu device attr\n");
-		return r;
-	}
 
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		r = amdgpu_pmu_init(adev);
-- 
2.28.0.394.ge197136389

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
