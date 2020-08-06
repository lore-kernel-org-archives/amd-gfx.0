Return-Path: <SRS0=X6dN=BQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33531C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 15:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C3E22E01
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2020 15:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y9oTDwCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C3E22E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA85A6E8D5;
	Thu,  6 Aug 2020 15:59:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 249436E8D5
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2020 15:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWHnXFsc0oa7u1l9w9DLA33BD+I3yDdZrQ+KHDJUKEWZA9ZHAeuDcTRF+vQAsN0gZMhU2q+q2lr9jqQSGZHnRHJAt0oOeehv5zorG9qZkYpjQ8QVsQDDPv9blI27qhjF3iQixCuIMUHNl4jihrLM5OUs7AUgNj7o7JT4qLIGCiwW2KGvaKBO5/UaDbO6X3TJoRd56Kd9d1cgNDw+1n2Bj2nCXPuPygbfNQ/q1LVQ/Cm7qBfyZi8qTtWtxaOPmfr53nM4lEm9AZiqbCJZY/fTLVvd1vlXf1xv+DUPMXMM7gwtcnDhEnr5wuMelm53GTso/JzcadQaCtKNEFKoL0bkwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHbFxBPoPAgk3KR3t0PFOnxQcfzQPsFxvOkv5UsWCNE=;
 b=c1nYqlVFWCLu8yvpnCw/kS850PllJTn8/tX5P4IzmGRuFdAC69HDVt3I8Qaym0rZcThSSqstZizFT4O3bQLuWV3HVfR3PGvQt5pqQ/BkWLqJKKWiTiV68V4P/LYygMxZLfd29d7m3MkpFaNL78U8PPr50gCUojRhGIOyLCP5PvEcddIL31gbiOl26IdHeqO/3lm4NDST7QwW5QxI0b+KrlKIRR+ENbm24Qc3ZgnVc6Pgd4icht01ei6zCeW5YeEZLXF1yY3m/kMDANVkrEEeDrxlIj0sJlRiOVHlp8ANo0zaWG6zzbSxTHpM1jWnREK5Miwir9/BkwBgjXGDaWBaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHbFxBPoPAgk3KR3t0PFOnxQcfzQPsFxvOkv5UsWCNE=;
 b=Y9oTDwCbJmzmJoNCHUIJJ+QlZKJ91tSNdCN79Wsnx4lqKH7A/I8C+NNWXMzWtpZRRKYI/+NkPe6MPRCFz4PmQbtSSLcMXZ/7A0qj+bOWqizdAnn+4S8g5Q5GLJ2qxOYN2maT+LPV2sa0WobyVQmos7/q9l1PvjA9QLS6mb4MXLE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2942.namprd12.prod.outlook.com (2603:10b6:208:108::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Thu, 6 Aug
 2020 15:58:55 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93%4]) with mapi id 15.20.3239.022; Thu, 6 Aug 2020
 15:58:55 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix uninit-value in
 arcturus_log_thermal_throttling_event()
Date: Thu,  6 Aug 2020 23:59:53 +0800
Message-Id: <20200806155953.76389-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR02CA0194.apcprd02.prod.outlook.com
 (2603:1096:201:21::30) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-pc.amd.com (58.247.170.242) by
 HK2PR02CA0194.apcprd02.prod.outlook.com (2603:1096:201:21::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.16 via Frontend Transport; Thu, 6 Aug 2020 15:58:53 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7738d7e0-5eed-4513-c69d-08d83a219f05
X-MS-TrafficTypeDiagnostic: MN2PR12MB2942:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2942F85F183E5964EC7FEE8FA2480@MN2PR12MB2942.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nPiH9ZPb6lhPdq+ar38rQwqLE5Ma002XUrzSK1Zs1LWPbRwRQIunjOWhvnEvKVSvhRrqjGI6YmB0xUkhCD0IB/u2onyG+fwXILF13Q4ldt0ICWocM5DleE5liuKXK/XBYKv9dq7sEQ+xCHTGWmF/NBzfjkTPPN8w2kZxsNcML7cNSTm/ZzkTyvBmk+GNl3CewBWZyA5y3pjhzO0nKYmSP8rAzKdjnijRH/9jSUV4IKGbsMySgj/mOOzxxEqKWeDdalqvQ/FTGehUJDpmEErlyiVnfw6maS01BthfPppLl6cL/FbDRYlFGTfYdQ8ahOOJoA9mfY3pjarj6WmXj97nv2T2OKnb9PSVLTU0arQjtk0Ig8XQyUI/3QC665tbgQRU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(2616005)(956004)(478600001)(83380400001)(66556008)(66946007)(8676002)(66476007)(4326008)(316002)(6916009)(86362001)(7696005)(52116002)(1076003)(6486002)(8936002)(5660300002)(2906002)(186003)(36756003)(26005)(16526019)(16060500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: LWjal6S//9kdezV8GM2mpuWME1jmlV4BHlGe25T/ffL5j3hR5fTLy+K+fUShRnlCW8yXmPTq0sneRomvhsqvgTVGaYzyOyKe8PY64qTVLwj9SzNZuuJkbh78cz46XdGh6ZdA9pdZdrxJBMe/yj/eVPCsyVcaL+kTX6V009s0gVfXvltXKuSweaJG9jU28sLCQY8qP93xaQeVkg281Abm+cOIJWVvkdxOq3YFFPw5geMVNJi35caaLV8S7XDmHztq3T4QEV4a+YmCCksfMVK49sRR7oU6lyXdMGngd9QwpDOgPr0tYIQ3x529S9r+avlMRYTgulueFhROBrnFwdUQwlVKmzLmZl3sAQbtzS6H5urfVU+/Sm4v7Jq/+Z+LZayVJZXgVugqiUVveVJaC8b54MhRsIMr6shTcl4sCG3J2bUrknYEpNDGh/jvpAMbo2XEH1v7tDOOy7KGdl+7s63+KHtRLxocvrdrQvF48m2Jp2Db3BlXBFtPSVz/DpYfvgLQL8AIO8NMb3hVIS23RIAbZmCw+M0Z/vxH9cFScR/+7jGn1Phw3Hr8tbNtB3ikClcEPXW321dUIsKhbd/IJnPQyeDNaY0s4pGSGExCn9ppyHBbQbNhEo4Ehx/eOAknj9durKGRYsBXe3Oh+LwP4TYIVg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7738d7e0-5eed-4513-c69d-08d83a219f05
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 15:58:55.2491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjEUtAUfQdVulj3FSLWT8UK9e1IBONAtnJrI454qmyrZv7eaYyhcpqsnj2oG2RLy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2942
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
Cc: alexander.deucher@amd.com, Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

d2hlbiBmdW5jdGlvbiBhcmN0dXJ1c19nZXRfc211X21ldHJpY3NfZGF0YSgpIGNhbGwgZmFpbGVk
LAppdCB3aWxsIGNhdXNlIHRoZSB2YXJpYWJsZSAidGhyb3R0bGVyX3N0YXR1cyIgaXNuJ3QgaW5p
dGlhbGl6ZWQgYmVmb3JlIHVzZS4KCndhcm5pbmc6CnBvd2VycGxheS9hcmN0dXJ1c19wcHQuYzoy
MjY4OjI0OiB3YXJuaW5nOiDigJh0aHJvdHRsZXJfc3RhdHVz4oCZIG1heSBiZSB1c2VkIHVuaW5p
dGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdtYXliZS11bmluaXRpYWxpemVkXQogMjI2OCB8
ICAgaWYgKHRocm90dGxlcl9zdGF0dXMgJiBsb2dnaW5nX2xhYmVsW3Rocm90dGxlcl9pZHhdLmZl
YXR1cmVfbWFzaykgewoKU2lnbmVkLW9mZi1ieTogS2V2aW4gV2FuZyA8a2V2aW4xLndhbmdAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYyB8
IDkgKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVz
X3BwdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMKaW5k
ZXggZTU4YWY4NDQzM2M3Li45NDZkYmMwZGIxYjEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jCkBAIC0yMjUzLDE0ICsyMjUzLDE3IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgdGhyb3R0bGluZ19sb2dnaW5nX2xhYmVsIHsKIH07CiBzdGF0aWMgdm9pZCBh
cmN0dXJ1c19sb2dfdGhlcm1hbF90aHJvdHRsaW5nX2V2ZW50KHN0cnVjdCBzbXVfY29udGV4dCAq
c211KQogeworCWludCByZXQ7CiAJaW50IHRocm90dGxlcl9pZHgsIHRocm90dGluZ19ldmVudHMg
PSAwLCBidWZfaWR4ID0gMDsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHNtdS0+YWRl
djsKIAl1aW50MzJfdCB0aHJvdHRsZXJfc3RhdHVzOwogCWNoYXIgbG9nX2J1ZlsyNTZdOwogCi0J
YXJjdHVydXNfZ2V0X3NtdV9tZXRyaWNzX2RhdGEoc211LAotCQkJCSAgICAgIE1FVFJJQ1NfVEhS
T1RUTEVSX1NUQVRVUywKLQkJCQkgICAgICAmdGhyb3R0bGVyX3N0YXR1cyk7CisJcmV0ID0gYXJj
dHVydXNfZ2V0X3NtdV9tZXRyaWNzX2RhdGEoc211LAorCQkJCQkgICAgTUVUUklDU19USFJPVFRM
RVJfU1RBVFVTLAorCQkJCQkgICAgJnRocm90dGxlcl9zdGF0dXMpOworCWlmIChyZXQpCisJCXJl
dHVybjsKIAogCW1lbXNldChsb2dfYnVmLCAwLCBzaXplb2YobG9nX2J1ZikpOwogCWZvciAodGhy
b3R0bGVyX2lkeCA9IDA7IHRocm90dGxlcl9pZHggPCBBUlJBWV9TSVpFKGxvZ2dpbmdfbGFiZWwp
OwotLSAKMi4yNy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
