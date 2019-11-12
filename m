Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E7FC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E664D2067B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E664D2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB40F6EBAF;
	Tue, 12 Nov 2019 18:04:16 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790079.outbound.protection.outlook.com [40.107.79.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DF66EBA5
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 18:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F35rk+vAP5n38swexfkWEM3tcQryOddZrdsFzch+GKBgl4VPVfXjnsGto8gH/KDzyLCs+yQYotyDFfgKIpNDGrfl6WjUhh+Y6RQ/2EpAL1QQu9kX+gFAEU6cQQpz+y1j9URwVSSCKvJDO/yabZl0DAfwxfgBYyInjZHxe1UofunRLv2ueqPCBrBnVMyZjwzdVV9MuJ3fP8OWkIcrbjQDbRqc+EPHa1rE7yI/Pkg4iw/lqHfqy/CHJ8YNQ5GD5TNKAhL4XJ6RzEV0SNTi77ImTYNmW/uK7muQLVeubfV5u3vtwq6hA4iM1UE+byCO1cgdg64AjDCvSnREamlk14T9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHIM8yoXvGoj4+EvFBSlJFj9Rpv+7tc8vFVsRMUjPd8=;
 b=ku8XKC0CSn9NeKP4L69ccRfZB01tK0VQoPPIhlecVoN6NUmo33pPb8lxgLUAokBOqAgMhCcO4HHrzqXZ1zp7oCezqaDq5/qYxxbx1RNEHoxjrAnM1931zRAa9TFctuJl2RbTPi5LZr1cb3i0YDMKsTeqYxJn9+J52rdeQu7HLGGhtiRmZUqcffsKsUjbuEkwkcrJQrKxnbXnQESYY1NUTGs6lnYXD4XkM99YfDbyQKO6PLWGB0cCGEtR2Is+mTeyxr5KmXISd6Hlx50vICJ07nz+WMzoO5hmvy9fPl9SNBij5c7Wl4dVyjhd+mlhfW5bXWTcqWjI+01LejfN+Jc+YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB2405.namprd12.prod.outlook.com (52.132.140.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 18:04:13 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 18:04:13 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/21] drm/amdgpu: add JPEG PG and CG interface
Date: Tue, 12 Nov 2019 13:03:17 -0500
Message-Id: <20191112180329.3927-10-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112180329.3927-1-leo.liu@amd.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c348de1f-69e1-4900-4a4b-08d7679ab956
X-MS-TrafficTypeDiagnostic: DM5PR12MB2405:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24050C345E0DC9DCC5D52556E5770@DM5PR12MB2405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(4326008)(6512007)(76176011)(66066001)(47776003)(2351001)(478600001)(51416003)(52116002)(14454004)(6916009)(44832011)(486006)(186003)(476003)(2616005)(6506007)(386003)(7736002)(26005)(25786009)(2361001)(36756003)(86362001)(305945005)(446003)(11346002)(6116002)(8676002)(3846002)(99286004)(16586007)(66476007)(50226002)(66946007)(2906002)(6486002)(6436002)(8936002)(81166006)(50466002)(5660300002)(316002)(1076003)(48376002)(81156014)(4744005)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2405;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0yDvMXC3chfERk4321ad2r+mM3GxXmMoPkPdf3f7f+nA4g3qQ7Haa1n6ZEH8CZh0me7RSYqxiROHaiVRzJiXT/51itKHXQyJ+7EcL8KyTPqGOhKGTToj7Ki0HITjb2nBO4tHphEt736pTpt//FCzGhgXF/MNqZ9Qlpo3rNAPcTvG2JYa3TRi/eBX66lJE2IFuYYWWKP8Hpeb3c+BUhj5GvhfyqA98W1Sm+WP2JTTt+aJRmQ+2rDs2QuICZyAqdVq0taf57S0+MLUI2NlTLXjTFS1L8q2WzxFGWfCKwQjkTC7kqh4L22vVzsdA7Ah5EUkP4nYH8pRcctRgPuT26Q6JBZ7qYxTtnVPAy3H6uXL1/XJy4cAArpz5eU3ejAl5ArX5XWoJoZg50DcRbYiZ/2ASilDnnjq1Xv6iKpOkoRV7VL7HHxdYDXkc7iuzYi9E5F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c348de1f-69e1-4900-4a4b-08d7679ab956
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 18:04:13.0687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jj2dhFOS6BXgdDTl8yzyeyNlQ5HLokrk1KIHVugXBNtZlEy4wy3ZP3CdtqG8gGoA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2405
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHIM8yoXvGoj4+EvFBSlJFj9Rpv+7tc8vFVsRMUjPd8=;
 b=JJR3Z1KAUyKOJXhL90iCKJom1+Y6D3qXuUtox4yvuwlzK3wTRgzCMiV9PgitGhUVEDwI9TdBvDCDcH7MhatdXFiAMqst4nWukzxz9F8gPc0//8CBqfRNgiu3+MFd8Fye7Npo6y8sWjKfz8zoohIbtTBGule6qpPjDq+YrQIJ7lk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112180317.6ikMI9JxZyqxoI3MbgvV8_7LzqPnH_sE5luG2u5kMUA@z>

RnJvbSBKUEVHMi4wLCBpdCB3aWxsIHVzZSBpdHMgb3duIFBHL0NHCgpTaWduZWQtb2ZmLWJ5OiBM
ZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRl
L2FtZF9zaGFyZWQuaCB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQuaAppbmRleCBkNWJjOGJlNGQ3MGMu
LmQ2NTVhNzZiZWRjNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2Ft
ZF9zaGFyZWQuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5o
CkBAIC0xMDAsNiArMTAwLDcgQEAgZW51bSBhbWRfcG93ZXJnYXRpbmdfc3RhdGUgewogI2RlZmlu
ZSBBTURfQ0dfU1VQUE9SVF9JSF9DRwkJCSgxIDw8IDI3KQogI2RlZmluZSBBTURfQ0dfU1VQUE9S
VF9BVEhVQl9MUwkJCSgxIDw8IDI4KQogI2RlZmluZSBBTURfQ0dfU1VQUE9SVF9BVEhVQl9NR0NH
CQkoMSA8PCAyOSkKKyNkZWZpbmUgQU1EX0NHX1NVUFBPUlRfSlBFR19NR0NHCQkoMSA8PCAzMCkK
IC8qIFBHIGZsYWdzICovCiAjZGVmaW5lIEFNRF9QR19TVVBQT1JUX0dGWF9QRwkJCSgxIDw8IDAp
CiAjZGVmaW5lIEFNRF9QR19TVVBQT1JUX0dGWF9TTUcJCQkoMSA8PCAxKQpAQCAtMTE4LDYgKzEx
OSw3IEBAIGVudW0gYW1kX3Bvd2VyZ2F0aW5nX3N0YXRlIHsKICNkZWZpbmUgQU1EX1BHX1NVUFBP
UlRfVkNOCQkJKDEgPDwgMTQpCiAjZGVmaW5lIEFNRF9QR19TVVBQT1JUX1ZDTl9EUEcJCQkoMSA8
PCAxNSkKICNkZWZpbmUgQU1EX1BHX1NVUFBPUlRfQVRIVUIJCQkoMSA8PCAxNikKKyNkZWZpbmUg
QU1EX1BHX1NVUFBPUlRfSlBFRwkJCSgxIDw8IDE3KQogCiBlbnVtIFBQX0ZFQVRVUkVfTUFTSyB7
CiAJUFBfU0NMS19EUE1fTUFTSyA9IDB4MSwKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
