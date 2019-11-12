Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9828C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2B82067B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2B82067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B1C6EBA8;
	Tue, 12 Nov 2019 18:04:08 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam05on062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe50::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 363B16EBA8
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 18:04:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaDOujpmlJ1uLSblYZL6RqnZUm0pDiFBjwfhaDuSMkCg2Wr3uw1isY2YDxhOOVStnGM8cBB8dN5fTNM4U4cYwz10r7N2d8SgZcgaLsKLhE7wGb7HKB+DIoXcWIfziJABxpMp2WVWORjwP/nAG0cnnesEPhgRRfY40/oXGwMzVDezMcbdenhDvsJLPXwr7HyPuLSYKBONGaiM2/K6V+Iq/7Fd2/6c7i+M/hrPwm8qZ1RFLrD4nbFhB144v4DTQjeqOViLaDDxRNKwzfZMibaumcguoxuAEvFdolxfnPpFWLohwPdOHoZLLmYkXe7bEH6VowuxYJAWY3BcbFf9EMewrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpZzZAzrHxPo4yw4H1Yox34aEYZI6MRZFmNGO3yBKzw=;
 b=nYW3azGbpvBdveXFBWJbQWGQhoHCPZVfDE7HOPSTB2dwWLBiFrp1+63aIpm1ZJftZ+xih9EwhddueN1zew2abBr2VDYtJNJcxo83hlywYPpytJ5XXM7l9zWE1m7/BFpuX9RcWPfvuojwXt6R/fOzUpLfZFOMR3V7C9RDa5O4af5Ed8raqtXQ2YsKI+O2M7Fdkfox18Ce1BI934f/2fVGpP0Tj5sk2E6VY6el20HXl0w7gBAnCOCrNw+UXgl/smlgohT559GlZ/MDtXKuGnMeyIgct3+OF4dMCKykv+CM4p+PH/RI2B16CgvDmCmpHRuRwMleppwQSaVgSZzD4UaOvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB2405.namprd12.prod.outlook.com (52.132.140.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 18:04:04 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 18:04:04 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/21] drm/amdgpu: add JPEG IP block type
Date: Tue, 12 Nov 2019 13:03:13 -0500
Message-Id: <20191112180329.3927-6-leo.liu@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5da59d14-ecdc-4678-8de9-08d7679ab46d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2405:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2405AFE4AD2AA849763A5846E5770@DM5PR12MB2405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(4326008)(6512007)(76176011)(66066001)(47776003)(6666004)(2351001)(478600001)(51416003)(52116002)(14454004)(6916009)(44832011)(486006)(186003)(476003)(2616005)(6506007)(386003)(7736002)(26005)(25786009)(2361001)(14444005)(36756003)(86362001)(305945005)(446003)(11346002)(6116002)(8676002)(3846002)(99286004)(16586007)(66476007)(50226002)(66946007)(2906002)(6486002)(6436002)(8936002)(81166006)(50466002)(5660300002)(316002)(1076003)(48376002)(81156014)(4744005)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2405;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KEBsD61rvHHvn9AHqojCAnxh4+EA2nYFYqfuqheZjVwm2drB9Zn2Fb84VvIFhn6PFZgNpVZ+iYXERWik9zWac3i+8b4JUnV7aUT37ZwKc5EZKDjNYjJpohp7DZujnMcXyTh1U2nQoALs4VASPopKRP3jchIS2P38R7wczCb+SOSY16iSMi8qcDJ/glLKbdMMB9nQRrFb1GnDLTo+0ShVePDsRCeqb+xtujqR771yfbRPGP29/jYeXC+68F412spT21n88SrVQqXortWaJmRQznrQgyYRbVVXMjga7++jPV45RO7DcZgGchcAgFIq5GfSQ75tnClYXo93hACvSKd6Bs5l04I/ze5n1+J5DJvz1E69RVM39Pqujxl/Esh0JDe7B9SrcCmk1gJrTKGZrDkAroyScpNSEChYxXXKzaOY4GwlvAw4SVBgjcLcCQ7dghbb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da59d14-ecdc-4678-8de9-08d7679ab46d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 18:04:04.8955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuPwVEybb+jp1BxeAiBlDP+hNsYP7wjDmSjhITOMexT6pxtHcU0GKNn+607iE0QS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2405
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpZzZAzrHxPo4yw4H1Yox34aEYZI6MRZFmNGO3yBKzw=;
 b=X4XRHvTEGMJMVe30QubTc/l2uWVg8E9E3eGqVP/6XrX3FQ5FYvR73n3W/ZJp5Z9rGfcl7HHnk/cEfmp1g+ReIwZxO0nnqHjZe/YgcJsxh9f4Kjr5U3A5KL6O4DmC/80X3jJj13JQ0CHP6o0tXxyrcYZuqEJMcxR16Io2X/xd2Q0=
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
Message-ID: <20191112180313.sg4Gq0lyreFgP4CTpvnAk2fYoFP_-4XmMA4q8c2kuoY@z>

RnJvbSBWQ04yLjAsIEpQRUcyLjAgaXMgYSBzZXBhcmF0ZWQgSVAgYmxvY2suCgpTaWduZWQtb2Zm
LWJ5OiBMZW8gTGl1IDxsZW8ubGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9p
bmNsdWRlL2FtZF9zaGFyZWQuaCB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNs
dWRlL2FtZF9zaGFyZWQuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVk
LmgKaW5kZXggZGM3ZWIyOGYwMjk2Li5kNWJjOGJlNGQ3MGMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9pbmNsdWRlL2FtZF9zaGFyZWQuaApAQCAtNTMsNyArNTMsOCBAQCBlbnVtIGFtZF9pcF9ibG9j
a190eXBlIHsKIAlBTURfSVBfQkxPQ0tfVFlQRV9WQ0UsCiAJQU1EX0lQX0JMT0NLX1RZUEVfQUNQ
LAogCUFNRF9JUF9CTE9DS19UWVBFX1ZDTiwKLQlBTURfSVBfQkxPQ0tfVFlQRV9NRVMKKwlBTURf
SVBfQkxPQ0tfVFlQRV9NRVMsCisJQU1EX0lQX0JMT0NLX1RZUEVfSlBFRwogfTsKIAogZW51bSBh
bWRfY2xvY2tnYXRpbmdfc3RhdGUgewotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZng=
