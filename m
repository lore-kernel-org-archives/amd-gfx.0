Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A159EC35242
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 04:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E6620842
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 04:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RNkvEMUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E6620842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC1D6ED9D;
	Tue, 11 Feb 2020 04:16:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7F5B6E293
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 04:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kplE+AZCwOL5faaIRDbkCIYQ4UyKLBO50L8zL7Ehs7zWZiPWVod+DOxnAOqh6dfVaL4//RoMyuDZxooMrBGFJMwmhXPHvzkS9TJKxlyCJ8ee6y8eLfwAWh2dJHs+Z1upsfj2WnZqberXDJxQEE52JB7rB8EayZLvZInnDrsteZ2OXRQF0PNMPWysTACnmZHUDR+WibKyo7OepVplV8MSq3exCquXTNW0gXiObOrSGm4RqVI7QgLxvGLZ/Ws5IDe0fLuqSgFTwhynDjSzCaVLle6rL906UaKo26wfAgNWKs+dFWQl2DzrzYSCv5bj+mkm9AiF3rnIXQPkh8yZlS0xFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DumiEQPQ8iFmuLwfu9kZDOwMM42my4UeQi8dLRzp30=;
 b=QsGHg8ngptGed1TjbkwIxaKfpcuskyxfjlxSXPDGAO0EYVEA0YnEAKlz3EnskHiqqqjvRdFZuC3QNiXTYS6nql9JUc1DsRhGFOcW8Dt+HEG8w/maIE4C5+IsH+WOh3QQtywccW4ifk3YGGsrx+Jc81Rlj3xrt0I3w5MjADwYRsdTW3NGcCRtHft6LHR/SNbQxzoJw66siYVeX+JV8GAG5DQS8Q+8kHYlBoV4BOLyR2MsuJcEqBV48bSAPESSRFbmlsWFRzuoQ4VBm+VYc6V0xfVuyGcvcoIHuM49pHaiDZYR1BTc+GRUyuzWiNtei9hrjPXjU3aepOWLS8otmCqm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DumiEQPQ8iFmuLwfu9kZDOwMM42my4UeQi8dLRzp30=;
 b=RNkvEMUmKybqCLa6m9vDt9k1qZzPObFtkdX/0FFCCktBtr82yU2CVUxc2WkNPyDvYREVojDh88jBG1727c/l8nrilbyz2To/yYKqlACVZmtw575It8Q1Wy+lTakkPjmAsUzOzCp19NZuF3EqKTZYTIlofKaV43iw8y0vpj0XZ4Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB3319.namprd12.prod.outlook.com (20.178.54.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Tue, 11 Feb 2020 04:16:23 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::5034:d0dc:246d:399f%7]) with mapi id 15.20.2707.028; Tue, 11 Feb 2020
 04:16:23 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 christian.koenig@amd.com
Subject: [PATCH] drm/amdgpu: correct comment to clear up the confusion
Date: Tue, 11 Feb 2020 12:16:07 +0800
Message-Id: <20200211041607.9828-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:202:17::34) To BYAPR12MB2806.namprd12.prod.outlook.com
 (2603:10b6:a03:70::20)
MIME-Version: 1.0
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR03CA0064.apcprd03.prod.outlook.com (2603:1096:202:17::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.12 via Frontend Transport; Tue, 11 Feb 2020 04:16:21 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e029546-471d-4ebf-7996-08d7aea9277d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3319:|BYAPR12MB3319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB331990C13887AA1B137B17EFF1180@BYAPR12MB3319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(199004)(189003)(36756003)(86362001)(5660300002)(6486002)(1076003)(316002)(66946007)(66476007)(66556008)(44832011)(81166006)(7696005)(2906002)(16526019)(52116002)(81156014)(8936002)(8676002)(4326008)(478600001)(6666004)(66574012)(956004)(2616005)(26005)(6636002)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3319;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gtU64Q34lOEIfrmEezuU8CWP7sT9njcXKXNqmOsgY/uwOPrjdfoeIPT9NOBo0hzKtDnXlsPRmUZ0TWtChfz4gOv5HGrS5ctWJDTIU9X4id5YqV9PxwMAHp6UhrLOcb2xtb7ddqk5A6HJ9aMwcfjZASjoO8t4FprBtzgIHsk8Zc5cM55ACJhEB2wgdpErEjeZ/B21HnBZpgoshJdGfGuCo1ow7tgvJhNCHjeh96lg5GpFpG6MqlFvD/d0mg4Su7cmpuKd1bXzkeA92VBbvYH9O+k5x6hzXkEXtzCcZyP5UW/Dg7vaSgH8X29awG74MgKQhRd/jpgEvrNM2a/bgiffExKU7nxiWIeq0RRTnzldeu2iWD5kKasKpBaw9S/ej7sAUz/53KvXNHg8TKYs7KBT8UlRjAhKBrCSgbc0MpqLYPUNF5yZSE3dmnvzBnvCFV40
X-MS-Exchange-AntiSpam-MessageData: 3/i9L8c9xpjDtAYrPxnOwrv8ZVHD/BHaxtswVIjVI7lGcYhUkjFIBD3QZ9Lh9w3eA0oBnC1GAfbN3UoT3t0NnSF9AR5RuzCT4djgNgUn7vS1Is5Iw7WmgGhYPi1qcmRHRaizwNJyiVxNMEQTjxbjWg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e029546-471d-4ebf-7996-08d7aea9277d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 04:16:23.6262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSlTjhkvsnkQYoFxRJNU/gaPuudOmYtTcYN8k0JykY5vKsel9QWhS7yhIMN9Isa1ACQcwyTGq/SCTKJXsvyk7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3319
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rm9ybWVyIGNvbW1lbnQgbG9va3MgdG8gYmUgb25lIGludGVuZGVkIGJlaGF2aW9yIGluIGNvZGUs
CmFjdHVhbGx5IGl0J3Mgbm90LiBTbyBjb3JyZWN0IGl0LgoKU3VnZ2VzdGVkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEd1Y2h1
biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OV8wLmMgfCA3ICsrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwppbmRl
eCBhZjM0MWEyNzJlMzAuLjgyNDc2ZjZhY2ZhZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
ZnhfdjlfMC5jCkBAIC00Mzc0LDcgKzQzNzQsMTIgQEAgc3RhdGljIGludCBnZnhfdjlfMF9lY2Nf
bGF0ZV9pbml0KHZvaWQgKmhhbmRsZSkKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKIAlpbnQgcjsKIAotCS8qIGxpbWl0IGdkcyBj
bGVhcmluZyBvcGVyYXRpb24gaW4gY29sZCBib290IHNlcXVlbmNlICovCisJLyoKKwkgKiBUZW1w
IHdvcmthcm91bmQgdG8gZml4IHRoZSBpc3N1ZSB0aGF0IENQIGZpcm13YXJlIGZhaWxzIHRvCisJ
ICogdXBkYXRlIHJlYWQgcG9pbnRlciB3aGVuIENQRE1BIGlzIHdyaXRpbmcgY2xlYXJpbmcgb3Bl
cmF0aW9uCisJICogdG8gR0RTIGluIHN1c3BlbmQvcmVzdW1lIHNlcXVlbmNlIG9uIHNldmVyYWwg
Y2FyZHMuIFNvIGp1c3QKKwkgKiBsaW1pdCB0aGlzIG9wZXJhdGlvbiBpbiBjb2xkIGJvb3Qgc2Vx
dWVuY2UuCisJICovCiAJaWYgKCFhZGV2LT5pbl9zdXNwZW5kKSB7CiAJCXIgPSBnZnhfdjlfMF9k
b19lZGNfZ2RzX3dvcmthcm91bmRzKGFkZXYpOwogCQlpZiAocikKLS0gCjIuMTcuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
