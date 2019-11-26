Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1FDC432C3
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 19:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F1B62071A
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 19:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1B62071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F26F56E194;
	Tue, 26 Nov 2019 19:33:47 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690072.outbound.protection.outlook.com [40.107.69.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C58446E486
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 19:33:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evrhK2UmRolnesw5Mopgp//Vcn3rfIawf4E/ZD3oVFkgMbUZBUhJwLpVp1LLOgyJz3ZvyHEbKchZYaufUr0jyEaC0lunknmxjrcrcLj7yZ7+9XL1VmElxaA1lCj3M8MCya48RH1bcQHqXg66A8AwCk1t6bY4VnYmTS3GPJf335UlyfUkSgMkdyycBjkPH0msQaX8e7D+YFDDQtEk/BqkDuGnBsYBtUFXykQz7i/ZaVYGEY15zNcP968T8kxtnx/V+4RF6Tgx1v3DtT5KLeaDt9kD3b6+2j0iPJp1DLdXxhI63iNfl81u7ZhatuhZJIVSZxtM7J6Jk57CtmKdmmHA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ML/aYY6fA3NmOxTzcgt9/8gbebKLPDwDILOKkQeFlts=;
 b=Hen1S0YyBse/ZohjUig80qpeB1dpnC1cEWZq7/JQTauKXWiYamAF2ghg16j9LbuKcoLIeksSc40AWRwFmqQAoovCgMk5f4pZCutQCrw/eZgulQeJsTQO1KQLm0lXBUra24NH+48h+VXkfKnfJR/w4Xk7k8JLxv53Ec93BM8HdiwxsCT+g4WA7EyZp3rmH8h/9YTn+VYEGIvJsKoSUixjyOmxlsoHV+CjdkR+md22baH5v/N1jq7v81tXvb75WbjGZICu/YdfaGEOIPKF5Q2bfNLs8vUE97h7SBWjWnNwQ/lZvMM7DQIb1Gpa22/Y0VufOZzuhMB3aBE9bkpQY+HAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CY4PR12MB1254.namprd12.prod.outlook.com (10.168.169.17) by
 CY4PR12MB1798.namprd12.prod.outlook.com (10.175.59.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Tue, 26 Nov 2019 19:33:45 +0000
Received: from CY4PR12MB1254.namprd12.prod.outlook.com
 ([fe80::a4e2:1fed:2676:7d16]) by CY4PR12MB1254.namprd12.prod.outlook.com
 ([fe80::a4e2:1fed:2676:7d16%6]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 19:33:45 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/gfx: Clear more EDC cnt
Date: Tue, 26 Nov 2019 14:33:37 -0500
Message-Id: <1574796818-11648-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTOPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::38) To CY4PR12MB1254.namprd12.prod.outlook.com
 (2603:10b6:903:41::17)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 48b6259b-69f5-4e4e-e6fb-08d772a78cf2
X-MS-TrafficTypeDiagnostic: CY4PR12MB1798:|CY4PR12MB1798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1798063D3812B2D9DD7A3CCAE4450@CY4PR12MB1798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(199004)(189003)(5660300002)(2361001)(99286004)(66946007)(2616005)(66476007)(66556008)(6506007)(305945005)(186003)(26005)(36756003)(386003)(7736002)(51416003)(6116002)(16586007)(3846002)(4326008)(50466002)(316002)(48376002)(6486002)(52116002)(8936002)(6666004)(478600001)(2906002)(8676002)(6436002)(81166006)(81156014)(66066001)(6916009)(6512007)(47776003)(2351001)(25786009)(86362001)(14454004)(50226002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1798;
 H:CY4PR12MB1254.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CKdTpaaDN7i0KKgQ+eUrQmza/PhgqCMAE+wi5DUt1kkQ3K7dDLZKGEvrMsJLVwMT5MD2+n1XnNZYRmWygUR1muiLk0S7C4pdaVvMg5Al2VIeKyz3mqTDtkj69D9UZG5TtJRtGCeNAXIDDkAgq00uTn2KcSBLlMgI+Gh2i8OHvDK0enx4rG2awTFYrs2dBDTftWjIbuNFAJ5LW2A6/4ok6khRRoda7nU+UQessNRYCkamLuiWdpb7mF2QLe7B1HIdZpnCnN5xeMULtQFv/juUogx/x4GX9ZzTUXS6rDmObRMRSiRtvZYZNDhJEPB0Eha28o5L43nVrdRlNZXwGLrKZohVjjdjUvBefjzP7CRFcARqHw3ViRA6ubsaktn1xyq+qXAAIzvyoQrWZN4/4FBh+TGW3ximf5r/U+ak6u+9+4/7X6ih9RNgEFjQ70kmCeIh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b6259b-69f5-4e4e-e6fb-08d772a78cf2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 19:33:44.9497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djiNNXzG0Hh5sSDfJ9QSJB8zEiRZLTsFEPC6Eac/Y8lfmk/JwKoTrYYsrUftPier
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1798
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ML/aYY6fA3NmOxTzcgt9/8gbebKLPDwDILOKkQeFlts=;
 b=AFrlV3dqm4wa/5XsRSI0JxnVi33r0u7t8w+2qUuf1Xj9B6Pr/0P8c7cFd68lb1ixUv2TmMn3ipmLgBv0BwNmDzeSaYZcrKJfh4BnZDqDAPCMUdeO7F8SNRWfVSdADb+tibZt9e/7zPuS8ETHL7rWOvL4n7+El89MCV/hxkG4vHs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126193337.vk4P41nCS2iI_gM4HpY0b-2Q-lCT1a0-ujzJWytgSwc@z>

Q2xlYXIgU0RNQSBhbmQgSERQIEVEQyBjb3VudGVyIGluIEdQUiB3b3JrYXJvdW5kcy4KClNpZ25l
ZC1vZmYtYnk6IEphbWVzIFpodSA8SmFtZXMuWmh1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyB8IDUgKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwppbmRleCBjOGFj
ZTUxLi5kYzM4ZGY4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKQEAgLTQ4
LDYgKzQ4LDggQEAKIAogI2luY2x1ZGUgImFtZGdwdV9yYXMuaCIKIAorI2luY2x1ZGUgInNkbWEw
L3NkbWEwXzRfMF9vZmZzZXQuaCIKKyNpbmNsdWRlICJzZG1hMS9zZG1hMV80XzBfb2Zmc2V0Lmgi
CiAjZGVmaW5lIEdGWDlfTlVNX0dGWF9SSU5HUyAgICAgMQogI2RlZmluZSBHRlg5X01FQ19IUERf
U0laRSA0MDk2CiAjZGVmaW5lIFJMQ0dfVUNPREVfTE9BRElOR19TVEFSVF9BRERSRVNTIDB4MDAw
MDIwMDBMCkBAIC00MDI5LDYgKzQwMzEsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNvYzE1X3Jl
Z19lbnRyeSBzZWNfZGVkX2NvdW50ZXJfcmVnaXN0ZXJzW10gPSB7CiAgICB7IFNPQzE1X1JFR19F
TlRSWShHQywgMCwgbW1UQ0NfRURDX0NOVDIpLCAwLCAxLCAxNn0sCiAgICB7IFNPQzE1X1JFR19F
TlRSWShHQywgMCwgbW1UQ0FfRURDX0NOVCksIDAsIDEsIDJ9LAogICAgeyBTT0MxNV9SRUdfRU5U
UlkoR0MsIDAsIG1tU1FDX0VEQ19DTlQzKSwgMCwgNCwgNn0sCisgICB7IFNPQzE1X1JFR19FTlRS
WShTRE1BMCwgMCwgbW1TRE1BMF9FRENfQ09VTlRFUiksIDAsIDEsIDF9LAorICAgeyBTT0MxNV9S
RUdfRU5UUlkoU0RNQTEsIDAsIG1tU0RNQTFfRURDX0NPVU5URVIpLCAwLCAxLCAxfSwKKyAgIHsg
U09DMTVfUkVHX0VOVFJZKEhEUCwgMCwgbW1IRFBfRURDX0NOVCksIDAsIDEsIDF9LAogfTsKIAog
c3RhdGljIGludCBnZnhfdjlfMF9kb19lZGNfZ2RzX3dvcmthcm91bmRzKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQotLSAKMi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
