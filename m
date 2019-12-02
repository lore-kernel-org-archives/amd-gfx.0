Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D8CC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B666220848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B666220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4117C6E2D6;
	Mon,  2 Dec 2019 17:35:50 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800075.outbound.protection.outlook.com [40.107.80.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C47696E28E
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KB+idp/CLWIzBa7h3w/GejbxJoum7u02x/O59iLONo0tca3q8FBiPMFEGXh3gPRmmF3NCCdb7RdnG5z4m7zSwawih0oOpMVQGM1fcwvB3dWLTxSi9MCff7hlyn90GapTc592MhQfqAiMblgjJlwn+rFZkXPPpjloC2+8src/XhTi0uno9TJbfUyDiusaXQ5jQ4dAeLk3ulKh+m5ufPFbAzEZqXlnkENNBwoD2IYqiXPEPLoe3XhCDwpQ/bvepRNvNIcGldzIISwLxRrKDB1TO2OqZHehse0rW8eBb/TerE5hKOwiLj+DFAbxELFlVEQ/J3aC1C8rZW0JOPgW64g7bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Amy+UTLlta9BZXm1Sv3AP0VxuO2Uh7n1xZiaqBfhGh4=;
 b=G7F0qqqYPTHb0dF54FmQXDND5OZUYyDOXQ/eWoMxg6tzRr28NywnetOCKVCiw91puuE6TliqQiMnGNHdyVZ8D2JCuKnfM2u/JCeRkPyNICWEQLlmGO2MnfvQdyRC0FjEDN3PcEiM/rHLMm+Qk5ysOhD7l5+lAB/EZPOiB9MzQMsnRwiD4vltAQsSvaT9z45Jzn+W1WhatzBCN1r/TFqG6WLZIcs4q7GJfPPps5kmtnLMmlY+SWikkCfqJeDaqJ8xekXAa3HkB31dRbdC7m8kTSxSJN8V6rUUtwEonT88AOq/NY/zIke8gc5dpV0B9O858eK21jY+DyHuOw/Eb57KsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:47 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:47 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 34/51] drm/amd/display: check for repeater when setting
 aux_rd_interval.
Date: Mon,  2 Dec 2019 12:33:48 -0500
Message-Id: <20191202173405.31582-35-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202173405.31582-1-sunpeng.li@amd.com>
References: <20191202173405.31582-1-sunpeng.li@amd.com>
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f89b2997-6d8d-49b4-abc3-08d7774dffd4
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2610604C82606BE2991FD98282430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(51416003)(52116002)(6512007)(66476007)(66556008)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(14444005)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7VeQMEvPzHyZw+5aPOiaRnSVhAIz3aY1Ci944ATPqS19XzfrvaPMRIeUwkCTmREJLLEHpavnZE4vh8pgUHOtHHEcdtba6jxTRBDT4y5G31ONrX0ctTM6W2mXr2Dq2zrzzngz8thm5uEDRNM5AOf44ZuTI47zICQgiSns2YpYyfPduISBHWsrvuuFoXGfRYvb94sUyBgLLMPjrxWI+NwwFIXzuYwOp9mgBP0YJuhZJtPeNJnkw3Ap4bAcYNRys2plV0aZ10L7gRGnQUsKK/E2zj2DZM84BTUU94XTRVC/n6R7fkDIlJ7SAMXhBdAiTZ/s8YbhWTLyhtRisaSqup623KtveO6E5qwDuRiI/aeSCKLEaC2B3KDfs1nNKLHECmkiYItPKFgzxvX2prBUnSvHPWGKIp54MLrCgzaiRRinUB+whaNm/wcasqjd93lrHt7Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89b2997-6d8d-49b4-abc3-08d7774dffd4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:18.6888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ex0Xg2uyZMGjevfMca+jQ5xtK1LQAvTNfcOuiJuDDBZiM86nLYBqwYvzm8Dt5Efv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Amy+UTLlta9BZXm1Sv3AP0VxuO2Uh7n1xZiaqBfhGh4=;
 b=SY45emKn6lSP0ARWmsrMHrB4CnQCT2Ca8nhPcKooE1vIzyZxJX1VBMFFCe2QQesmUNtzsdiV0Wvw06d1dCcAGqUrOvPAIhcGhz9C4lbCgAfO4U4pJpU4CIvFRzm9kuuolbpXgQQfQXyxG1/SOWxGY121I1mWqEb+xu3IFn5urks=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
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
Cc: Leo Li <sunpeng.li@amd.com>, harry.wentland@amd.com,
 rodrigo.siqueira@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 abdoulaye berthe <abdoulaye.berthe@amd.com>, George Shen <George.Shen@amd.com>,
 bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogYWJkb3VsYXllIGJlcnRoZSA8YWJkb3VsYXllLmJlcnRoZUBhbWQuY29tPgoKW1doeV0K
V2hlbiB0cmFpbmluZyB3aXRoIHJlcGVhdGVyIHRoZSBhdXggcmVhZCBpbnRlcnZhbCBtdXN0IGJl
IHNldCB0bwpyZXBlYXRlciBzcGVjaWZpYyBhdXhfcmVkX2ludGVydmFsLiBUaGlzIHZhbHVlIGlz
IGFsd2F5cyAxMDB1cyBmb3IgQ1IuCgpbSG93XQpDaGVjayBmb3IgcmVwZWF0ZXIgd2hlbiBzZXR0
aW5nIHRoZSBhdXhfcmRfaW50ZXJ2YWwgaW4gY2hhbm5lbAplcXVhbGl6YXRpb24uClVzZSB0aGUg
cmlnaHQgb2Zmc2V0IGluIHRoZSBhdXhfcmRfaW50ZXJ2YWwgYXJyYXkKClNpZ25lZC1vZmYtYnk6
IGFiZG91bGF5ZSBiZXJ0aGUgPGFiZG91bGF5ZS5iZXJ0aGVAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6
IFdlbmppbmcgTGl1IDxXZW5qaW5nLkxpdUBhbWQuY29tPgpBY2tlZC1ieTogR2VvcmdlIFNoZW4g
PEdlb3JnZS5TaGVuQGFtZC5jb20+CkFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmMg
fCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlu
a19kcC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5j
CmluZGV4IDAxNWZhMGM1Mjc0Ni4uZGZjZDY0MjFlZTAxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jCkBAIC05MDYsMTAgKzkwNiwxMCBA
QCBzdGF0aWMgZW51bSBsaW5rX3RyYWluaW5nX3Jlc3VsdCBwZXJmb3JtX2NoYW5uZWxfZXF1YWxp
emF0aW9uX3NlcXVlbmNlKAogCQkvKiAzLiB3YWl0IGZvciByZWNlaXZlciB0byBsb2NrLW9uKi8K
IAkJd2FpdF90aW1lX21pY3Jvc2VjID0gbHRfc2V0dGluZ3MtPmVxX3BhdHRlcm5fdGltZTsKIAot
CQlpZiAoIWxpbmstPmlzX2x0dHByX21vZGVfdHJhbnNwYXJlbnQpCisJCWlmIChpc19yZXBlYXRl
cihsaW5rLCBvZmZzZXQpKQogCQkJd2FpdF90aW1lX21pY3Jvc2VjID0KIAkJCQkJdHJhbnNsYXRl
X3RyYWluaW5nX2F1eF9yZWFkX2ludGVydmFsKAotCQkJCQkJbGluay0+ZHBjZF9jYXBzLmx0dHBy
X2NhcHMuYXV4X3JkX2ludGVydmFsW29mZnNldF0pOworCQkJCQkJbGluay0+ZHBjZF9jYXBzLmx0
dHByX2NhcHMuYXV4X3JkX2ludGVydmFsW29mZnNldCAtIDFdKTsKIAogCQl3YWl0X2Zvcl90cmFp
bmluZ19hdXhfcmRfaW50ZXJ2YWwoCiAJCQkJbGluaywKLS0gCjIuMjQuMAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
