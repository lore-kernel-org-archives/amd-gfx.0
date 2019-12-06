Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458F5C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 03:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F006921823
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 03:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F006921823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A3B96F95D;
	Fri,  6 Dec 2019 03:36:08 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680089.outbound.protection.outlook.com [40.107.68.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B4C6F95D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 03:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuL1PBYieQM9/XgSYW+P13LpC9VyOd9SAibpoLrthD2cyOZ2wDTc0GhzxwtJdne/nSIxniKoIIb32TVlC6v3mFSfKK+sTdGl8gU6/K2nCz+EdLeQUJ1DhofXAvlhvHZ2iyyHr6dXZTP2gGKpfdfx+66MEYdrk633lBZ06nvj3X3CQiFC3Axh9q53GnOp47dgI0clKXLLxdXBD6vjuA04QIK1K5YA1YJL1af7+fqADwA1Re6pmDCpExNbHDY+9cxzo8LQGg70A7sVEsE5I9mR0t4L6zMO4KvEwy2u5pdCr3LRzIHByt5rOcOu7TbAWVwnlon2vCIOFf9s0vW0jcN1Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVb9igygMEh0qIesjh1w2d3A9f4ybQg2WCt22NvcRHI=;
 b=Lv64Yy4UdPEFkp8OSUeoixfUJWUpo1QOeSXml1va3frixdB+fz0BAPNN/C5XxVAbX4W66FhDG3Hyi5FZcYLKg6CvJ3eXeLo9STbwfdtec2rOZrcu8PLsmHy8WcLNWCdTvF9JXeJpnpnfujBInbN2JELduUihMNbhcVnaYy6PeIWI/2DGLiYeSS2270QIn70vdmtsOHrfGGcCYa+kWQWVz+wlOJpMdcEEruEV5uNFLmZ4hXDqtIhmG+3hDPrBFUi69W7U7Cmo5Fx65JrDZxig9PYY5tMRyrmVzUo8h0xvjp7WySv40JAnvqvcsl7jbja33MqUibKtyNdyMTt48kBJOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB4061.namprd12.prod.outlook.com (10.255.125.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Fri, 6 Dec 2019 03:36:05 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::3cb6:a512:f4e1:5d9d%4]) with mapi id 15.20.2495.014; Fri, 6 Dec 2019
 03:36:04 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: clear VBIOS scratchs on baco exit
Date: Fri,  6 Dec 2019 11:35:43 +0800
Message-Id: <20191206033543.3131-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 528c8a17-79f4-4989-c726-08d779fd6c1e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4061:|MN2PR12MB4061:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4061D4C010F346A8440BAD3CE45F0@MN2PR12MB4061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 0243E5FD68
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(8936002)(6506007)(48376002)(6512007)(50466002)(2870700001)(6666004)(66476007)(66946007)(66556008)(81156014)(81166006)(4744005)(86362001)(1076003)(4326008)(99286004)(186003)(316002)(5660300002)(8676002)(25786009)(44832011)(26005)(51416003)(2616005)(50226002)(36756003)(305945005)(6916009)(478600001)(2906002)(14454004)(6486002)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4061;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTwEpsQspLHnaky7yZQcvs4yBsJCWd1hD5rg+q0UCCcVbOBzrnpHXy6ozJj4L0+xg0UXjpzfNdvLvGNvWUxqyuSOs6GRN1Of0hyB9EhlTRjpl7BiAgiRPh7WW5YJXJls1K3sHEz3eNvFdRfa+L2ZY6545EQpZ9CbVTaPHhHsATwUIQAdoW/fOfSPdS+W++ODFBJhsG+lf/7uC+cFd7orOjUJt/HLD4wox5eOP0wKYls7dIvCV17bfVmsoc4y96pl2ov6GqK3aYBsDVg466IBK9J75lh9a3YEaY2xNFBtRaLP4Kx0BO5NjsfUFpWqLsKpg/Sfv9MnPorBlzW2QK49evtQ/GXp84Mk0Sok364fn+WbhphUhKUdOUG1htol8ieAuHJWFsfG3MT1wcnG7OSqnO6tH9E5ZRcvVXgSqcGW84OaE7pNceDCurbyZRSEnFj+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 528c8a17-79f4-4989-c726-08d779fd6c1e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 03:36:04.8634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+P/FjWbDsrRhi42cnlE6wgHcsbHRu3Zf6FVQ2BKK2FXuO4wnRgaZk+JCrGPCPxK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVb9igygMEh0qIesjh1w2d3A9f4ybQg2WCt22NvcRHI=;
 b=lSLdDn17qfWDtWu8mpf8bc8s7Z8DUbgGI0rjAad8T550RmNBbsgC5+FosJW6mFToeVCGAkeU5bus6uzRIncLQxi5toOZfyZi7/olJgiP7fiQGjKu9LwtB8EBz8HdkgaB+jDr/ofjr8+GMP/Zpyuhb2T1gjKqi2G3bDAQB9hWjOE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: Evan Quan <evan.quan@amd.com>, Zhigang.Luo@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBpcyBuZWVkZWQgZm9yIGNvbWluZyBhc2ljIGluaXQgb24gcGVyZm9ybWluZyBncHUgcmVz
ZXQuCgpDaGFuZ2UtSWQ6IElmMzY3MWEyNGQyMzllM2QyODg2NjVmYWRhYTJjNDBjODdkNWRhNDBi
ClNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211X3YxMV8wLmMgfCA2ICsrKysrKwogMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L3NtdV92MTFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211
X3YxMV8wLmMKaW5kZXggMzllYzA2YWVlODA5Li5hYjgwOWRmN2JjMzUgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L3NtdV92MTFfMC5jCkBAIC0xNjU5LDYgKzE2NTksMTIgQEAgaW50
IHNtdV92MTFfMF9iYWNvX3NldF9zdGF0ZShzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwgZW51bSBz
bXVfYmFjb19zdGF0ZSBzdGF0ZSkKIAkJfQogCX0gZWxzZSB7CiAJCXJldCA9IHNtdV9zZW5kX3Nt
Y19tc2coc211LCBTTVVfTVNHX0V4aXRCYWNvKTsKKwkJaWYgKHJldCkKKwkJCWdvdG8gb3V0Owor
CisJCVdSRUczMl9TT0MxNShOQklPLCAwLCBtbUJJT1NfU0NSQVRDSF82LCAwKTsKKwkJV1JFRzMy
X1NPQzE1KE5CSU8sIDAsIG1tQklPU19TQ1JBVENIXzcsIDApOworCiAJCWJpZl9kb29yYmVsbF9p
bnRyX2NudGwgPSBSRUdfU0VUX0ZJRUxEKGJpZl9kb29yYmVsbF9pbnRyX2NudGwsCiAJCQkJCQlC
SUZfRE9PUkJFTExfSU5UX0NOVEwsCiAJCQkJCQlET09SQkVMTF9JTlRFUlJVUFRfRElTQUJMRSwg
MCk7Ci0tIAoyLjI0LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
