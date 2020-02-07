Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA28C35247
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 00:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC3220838
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 00:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JGI/b3P1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC3220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E77B6E4E6;
	Fri,  7 Feb 2020 00:09:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 222AD6E4CA
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 00:09:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdLHyvnOp8uAeYpkAy0wAwjiTMa2eYcc/pA0tuyTyhaOHpUuBG1z9V6w5aFKOyX3g4Ks2YPPsPAeboeb10IMPFP2PZ0pHa02U0sszHQmCkTjPyBMrALMqiHsrNSzunuBAYNM5fvMRI/F2NNupksRS+UZ1wn4z+HxMXEHpK2t2UZicY61gLqZd006XiG90em9xJOQTGIN7ksKxaM8dmBVm9xX0+jpiAu8sExW5k6tpIhzp9kGYHf6zfTWuN7JFjw4CnrmPkze/bBYK4FEFn4g/Z7TwspUUHa6mlNbAA53+DZjIq/jpjwZB6IMcBOrhTRpPLRKrfKLBLNJpec2PGv3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEivH5zKNcRMZqZhyKi6zY2BS+dxUFYeJZkz6uFD9Vk=;
 b=icxSNQgwrZXo1R9U7VKV6Uor/yoyCeZvqTnGmeH7eQe1XaVBJ2eT6XoJB+JbB4hkUSs9NhBxIJOUj6vY8QUN7Z5iRol8nQsq9DHIPFVRuQpo7c4t4QbbTXd/4MgZ103KNfhalEVCDouiqBh6VNeQePhZTMC59CXaQpoGIxPPuSNDrgXlXnYgYRVCziWxCKClmuFl7mbHDnqXVl16gPSjSelFOAAnbkJD0zot9FTq+XmO7ohsuKpE7E9yTsqOwxrjnqW8DFbJsL+RKDJv5zPPge5GLpuah/FMvz1WDjUAyEU5+a9L8z5oLgT0KDtYkWCdShr2qWJoNVxybkmrqDKDXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEivH5zKNcRMZqZhyKi6zY2BS+dxUFYeJZkz6uFD9Vk=;
 b=JGI/b3P1ToFPM7IexDAbKAb3I0KLWq8lB30Mc+lFo0GkNtDf6812/N3G8f8Tdj28u0r7BXOB62lyenfm265qVVdVlbAzR0Sk3jFniZuJsobSSvkNwKh/eRFhO5x7K/T2jVxoPPzOyl2O0/C0Ywzlz400bXlHYmG8mhOZzudqeBk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from DM5PR12MB2359.namprd12.prod.outlook.com (52.132.141.12) by
 DM5PR12MB1530.namprd12.prod.outlook.com (10.172.34.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Fri, 7 Feb 2020 00:09:28 +0000
Received: from DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f]) by DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 00:09:28 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v3 2/4] drm/amdkfd: show warning when kfd is locked
Date: Thu,  6 Feb 2020 19:09:09 -0500
Message-Id: <20200207000911.19166-3-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207000911.19166-1-rajneesh.bhardwaj@amd.com>
References: <20200207000911.19166-1-rajneesh.bhardwaj@amd.com>
X-ClientProxiedBy: YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::33) To DM5PR12MB2359.namprd12.prod.outlook.com
 (2603:10b6:4:b4::12)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 00:09:27 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 435717d3-8fe3-465a-201b-08d7ab61ff27
X-MS-TrafficTypeDiagnostic: DM5PR12MB1530:|DM5PR12MB1530:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15302655491E78EB004B6F47FE1C0@DM5PR12MB1530.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(189003)(199004)(26005)(66946007)(44832011)(66476007)(5660300002)(956004)(66556008)(478600001)(6486002)(7696005)(6666004)(186003)(16526019)(2906002)(52116002)(36756003)(316002)(86362001)(8676002)(2616005)(6916009)(81166006)(1076003)(4744005)(4326008)(8936002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1530;
 H:DM5PR12MB2359.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rkpOWTr5egnVIBDr/2UxWJzFVHsA/JwAQJyqKFqztOwcxFVT6OEQoJRfhqwXBLICf6SH9wbOyOy1ZEKtSyXj3LroJDfiQyUDX/JIpeMS9TVJYHp8V/4/wvE0ejesi+qYE43BjnW1YLZaWo2Ey/5lDIukPx4FGDV3HGIpbJGty4V0c1ONiU4HJVRCelxZA6LzU/99dpAm4cZgaGuLpK7h0Hbf8sya5ns2CnZAXk7VEmhawVMQmXxC3ty/YYj118bK2WGTNKolRRtpD0ARPWe98NUSA/4rEzgSndrSnRlqjeWfakLhJ+EBlL7roiN2PWEcUsDjZeNqXG3gD+TGK9GXZkYYkqE4Vjk1qmPnfA5Kbd71vptzgvamwezJaTBLta4X+eCMGqFYQBSOGPdMAkT8nePyyHmc3LL9ZEDTwVsWCDBWX7sMq62lpiBiAwcJI1ps
X-MS-Exchange-AntiSpam-MessageData: Hu3zmzzzeE6oS5pD+EojF1Ld6iOWDCm3CD2/dbIge8JjTrX82uZ5YKwZGYnxU4m3lNU3ILgKdu4HYvFKtp1LrMEYVkUCw52ajVj4Xzd9/R9ZoJQ02/jjECj0jleMvqWtsZ3ad6F3m6shjJCO7vqFXA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435717d3-8fe3-465a-201b-08d7ab61ff27
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 00:09:27.9025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLgqwsUYmIKVgYsQt7kErC9DHEfFRZwQJJ2v7B6mbnIIt03craouSd5BMfuuIpWYel7dDHnmTzPunMRKrgw+Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1530
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
