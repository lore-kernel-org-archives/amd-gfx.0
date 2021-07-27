Return-Path: <SRS0=HC41=MT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A977BC432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 00:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7262A60F02
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jul 2021 00:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7262A60F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 331466EB88;
	Tue, 27 Jul 2021 00:53:12 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2BB96EB88;
 Tue, 27 Jul 2021 00:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsVtlXpy357UfO3a2gZbW1FXRG3mI0a7tQP6xw5Rv+MQ1jrjFLfvSxDMJOt83aM4/ycyFPN0dqQJ4lJbp1Xp39XVhU7Tc89HthmLl46ehFBmc/pe6jRiYK1abxrpTEsJP0RI79teUdhgb1UtbsS8DZVk7OkLu5zAOcyL5TVEWv+zIRZT+AWX9414vvkQ+6bmiG9/xqdGLRb0cHwodz2wRf+GNfCnS6I/fdQfS6gx3gSMTEcCdHoAKlANgf9vjbpi0MOno1cMzrkqlLtsQP1RuyE5ISZcHCO65kCmPkKGMpXxfRgQBAhwXDLfDgyEAGmeJhjI0x2JMDbFAaHcC0fNjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lk4egyIKcjvBaFY4mvCuAqi0rpWDBk9OAvkyznT7x0I=;
 b=I1aMWXSU0akvcualrMz312g1r27GmSR591km01NDsR5GUtpKipptlyPXmYyJVnwdKJkYby8eAiSiQat2xCbIT3ELUrDLrXvIPylZwS+2RHqDQPSXngZ5EKOHeGzyQjJEfOlmjwnM3AqLxpek1mTYoSPuFn+geMX37hk5gtK24mZSe5SLm/z1UkYDhC9E66ZRTTQNsn6+T0TF6gW9UqTta8b3CuqyKmeU01VwhkDRwylbWerzA89dcSU5z2tIMVTSVWi8yTETTXN8j0d1cMGAwZPt8pGCFCzAbjTT9djgHXb2CAr+y+QQVcc4fkXvhFDqWrDmB2UVvF25PieFjn3bew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lk4egyIKcjvBaFY4mvCuAqi0rpWDBk9OAvkyznT7x0I=;
 b=g6LEohQmImPnXhPR5wfaW5SE8Khz8SICMAsgWjlZrYJL4aGd8nmNICEGA8HgOD9WHfG4tBIvyFjntnsW0WTdiRwpojRHjlUbYJ8/sFGuLfKuq9PJ6Xn2zHLX6hjHERF0mYRpIJkOv1LwR6X0hKLC3f/MVp9ct+ZLUo7qpy+6u2I=
Received: from DM5PR07CA0153.namprd07.prod.outlook.com (2603:10b6:3:ee::19) by
 DM6PR12MB2971.namprd12.prod.outlook.com (2603:10b6:5:118::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.29; Tue, 27 Jul 2021 00:53:07 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::6c) by DM5PR07CA0153.outlook.office365.com
 (2603:10b6:3:ee::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend
 Transport; Tue, 27 Jul 2021 00:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Tue, 27 Jul 2021 00:53:06 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 26 Jul
 2021 19:53:05 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <sunpeng.li@amd.com>, <roman.li@amd.com>
Subject: [PATCH v4 3/4] drm/amd/display: Add control mechanism for FPU
 utilization
Date: Mon, 26 Jul 2021 20:52:47 -0400
Message-ID: <20210727005248.1827411-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727005248.1827411-1-Rodrigo.Siqueira@amd.com>
References: <20210727005248.1827411-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0a7c56d-d0be-45f5-eec7-08d95098e5ca
X-MS-TrafficTypeDiagnostic: DM6PR12MB2971:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2971D7F3FAA6C805E985781F98E99@DM6PR12MB2971.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:156;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WzhmdymUq5xytOhnIFWalqM6yr5+FhrtSjxWJIuv/Ipg00AwUGV6xcYkwnICEoBhbGZ4brLZSNwsrhOv1alR/bLhxEi0zRzKZUVNCtn2MJUeGSipGFldGIoiZrL/G7F17in5xN/2TYh/4YJHPDKELqDW47uGPBhkhaH4QqCHbnsLFSGPzmEbZb+dCcVliR9VNKY3FtqYahI4Pg/b/DtlitDln/okMIuyRU3KlJmnuGzHlWh2bHnwpqs/VJ8a8cmkDOU8FUMUqOliQ9clzVokOyziEOLfqvJv2oMXMwr5gJtvPZXhFAihFwAT1oNOq56JWlXOrRQk/LwbC+avfmUG51+EYbXT/JbL7HvZpHGzF4oioEJhgUmEx3Sl4prxu+3+rTy3Rhl1Bc9uRt5YlVDEk4MmuAY/LNrniY/WticMxyqozk3gu5hVbvcm15hmk3YX+9d6fNg/TZZOcaxp7VmbLVSevEVRKO2bzlT1Pr5rCyBnyvsH+zVlyIr50pUH7TLwX092G2Ndz/ouhuzPiNbRm8/5BiPC8aB+v6Qc2mcgZ14D4mRW6tMEraEKiRj6Wxs7nX2ygxr2hYygtYmiq3dVtseN0k0DpQMb1J06fVwRBBRnGyAfqq47nmRYa29dSqkUXFnaifI3Rn+C37ZqaGe3RUTsMOC+SpO7s/68kSHddYWpzgAarV291VYC/6TEL4IDTriS6pKjuAFDV2aDb/5fHUWHv9P/TXv+KjMRYhcJad8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(46966006)(36840700001)(2906002)(16526019)(356005)(47076005)(81166007)(186003)(1076003)(336012)(2616005)(5660300002)(8936002)(66574015)(8676002)(426003)(36860700001)(6666004)(82310400003)(26005)(4326008)(110136005)(70586007)(82740400003)(86362001)(83380400001)(54906003)(316002)(36756003)(478600001)(70206006)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 00:53:06.9189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a7c56d-d0be-45f5-eec7-08d95098e5ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2971
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
Cc: Aric Cyr <aric.cyr@amd.com>, kernel test robot <lkp@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Qingqing
 Zhuo <qingqing.zhuo@amd.com>, Anson Jacob <Anson.Jacob@amd.com>,
 Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jun Lei <jun.lei@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

REMgaW52b2tlcyBEQ19GUFVfU1RBUlQvRU5EIGluIG11bHRpcGxlIHBhcnRzIG9mIHRoZSBjb2Rl
OyB0aGlzIGNhbgpjcmVhdGUgYSBzaXR1YXRpb24gd2hlcmUgd2UgaW52b2tlIHRoaXMgRlBVIG9w
ZXJhdGlvbiBpbiBhIG5lc3RlZCB3YXkgb3IKZXhpdCB0b28gZWFybHkuIEZvciBhdm9pZGluZyB0
aGlzIHNpdHVhdGlvbiwgdGhpcyBjb21taXQgYWRkcyBhCm1lY2hhbmlzbSB3aGVyZSBkY19mcHVf
YmVnaW4vZW5kIG1hbmFnZXMgdGhlIGFjY2VzcyB0bwprZXJuZWxfZnB1X2JlZ2luL2VuZC4KCkNo
YW5nZSBzaW5jZSBWMzoKLSBSZWJhc2UKCkNoYW5nZSBzaW5jZSBWMjoKLSBDaHJpc3RpYW46IERv
IG5vdCB1c2UgdGhpc19jcHVfKiBiZXR3ZWVuIGdldC9wdXRfY3B1X3B0cigpLgoKQ2hhbmdlIHNp
bmNlIFYxOgotIFVzZSBhIGJldHRlciB2YXJpYWJsZSBuYW1lcwotIFVzZSBnZXRfY3B1X3B0ciBh
bmQgcHV0X2NwdV9wdHIgdG8gYmV0dGVyIGJhbGFuY2UgcHJlZW1wdGlvbiBlbmFibGUKYW5kIGRp
c2FibGUKCkNjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KQ2M6IEFu
c29uIEphY29iIDxBbnNvbi5KYWNvYkBhbWQuY29tPgpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogSGVyc2VuIFd1IDxoZXJzZW54cy53dUBhbWQuY29t
PgpDYzogQXJpYyBDeXIgPGFyaWMuY3lyQGFtZC5jb20+CkNjOiBKdW4gTGVpIDxqdW4ubGVpQGFt
ZC5jb20+CkNjOiBEbXl0cm8gTGFrdHl1c2hraW4gPGRteXRyby5sYWt0eXVzaGtpbkBhbWQuY29t
PgpDYzogUWluZ3FpbmcgWmh1byA8cWluZ3Fpbmcuemh1b0BhbWQuY29tPgpSZXBvcnRlZC1ieTog
a2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+ClNpZ25lZC1vZmYtYnk6IFJvZHJpZ28g
U2lxdWVpcmEgPFJvZHJpZ28uU2lxdWVpcmFAYW1kLmNvbT4KLS0tCiAuLi4vYW1kL2Rpc3BsYXkv
YW1kZ3B1X2RtL2FtZGdwdV9kbV90cmFjZS5oICAgfCAxMyArKy0tCiAuLi4vZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vZGNfZnB1LmMgICAgfCA3NyArKysrKysrKysrKysrLS0tLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfdHJhY2UuaCAgICAgfCAgNCArLQogMyBm
aWxlcyBjaGFuZ2VkLCA2MyBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV90cmFj
ZS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fdHJh
Y2UuaAppbmRleCAyMzBiYjEyYzQwNWUuLmZkY2FlYTIyYjQ1NiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fdHJhY2UuaAorKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV90cmFjZS5oCkBA
IC02MzgsMjMgKzYzOCwyNiBAQCBUUkFDRV9FVkVOVChhbWRncHVfcmVmcmVzaF9yYXRlX3RyYWNr
LAogKTsKIAogVFJBQ0VfRVZFTlQoZGNuX2ZwdSwKLQkgICAgVFBfUFJPVE8oYm9vbCBiZWdpbiwg
Y29uc3QgY2hhciAqZnVuY3Rpb24sIGNvbnN0IGludCBsaW5lKSwKLQkgICAgVFBfQVJHUyhiZWdp
biwgZnVuY3Rpb24sIGxpbmUpLAorCSAgICBUUF9QUk9UTyhib29sIGJlZ2luLCBjb25zdCBjaGFy
ICpmdW5jdGlvbiwgY29uc3QgaW50IGxpbmUsIGNvbnN0IGludCByZWN1cnNpb25fZGVwdGgpLAor
CSAgICBUUF9BUkdTKGJlZ2luLCBmdW5jdGlvbiwgbGluZSwgcmVjdXJzaW9uX2RlcHRoKSwKIAog
CSAgICBUUF9TVFJVQ1RfX2VudHJ5KAogCQkJICAgICBfX2ZpZWxkKGJvb2wsIGJlZ2luKQogCQkJ
ICAgICBfX2ZpZWxkKGNvbnN0IGNoYXIgKiwgZnVuY3Rpb24pCiAJCQkgICAgIF9fZmllbGQoaW50
LCBsaW5lKQorCQkJICAgICBfX2ZpZWxkKGludCwgcmVjdXJzaW9uX2RlcHRoKQogCSAgICApLAog
CSAgICBUUF9mYXN0X2Fzc2lnbigKIAkJCSAgIF9fZW50cnktPmJlZ2luID0gYmVnaW47CiAJCQkg
ICBfX2VudHJ5LT5mdW5jdGlvbiA9IGZ1bmN0aW9uOwogCQkJICAgX19lbnRyeS0+bGluZSA9IGxp
bmU7CisJCQkgICBfX2VudHJ5LT5yZWN1cnNpb25fZGVwdGggPSByZWN1cnNpb25fZGVwdGg7CiAJ
ICAgICksCi0JICAgIFRQX3ByaW50aygiJXMoKSslZDogJXMiLAorCSAgICBUUF9wcmludGsoIiVz
OiByZWN1cnNpb25fZGVwdGg6ICVkOiAlcygpKyVkOiIsCisJCSAgICAgIF9fZW50cnktPmJlZ2lu
ID8gImJlZ2luIiA6ICJlbmQiLAorCQkgICAgICBfX2VudHJ5LT5yZWN1cnNpb25fZGVwdGgsCiAJ
CSAgICAgIF9fZW50cnktPmZ1bmN0aW9uLAotCQkgICAgICBfX2VudHJ5LT5saW5lLAotCQkgICAg
ICBfX2VudHJ5LT5iZWdpbiA/ICJiZWdpbiIgOiAiZW5kIgorCQkgICAgICBfX2VudHJ5LT5saW5l
CiAJICAgICkKICk7CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9h
bWRncHVfZG0vZGNfZnB1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2RjX2ZwdS5jCmluZGV4IGQ0YWIyN2JmOGQwNC4uMzM4MDdkNzQ2ZTc2IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2RjX2ZwdS5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vZGNfZnB1LmMKQEAgLTMzLDYgKzMzLDE5
IEBACiAjaW5jbHVkZSA8YXNtL2NwdXRhYmxlLmg+CiAjZW5kaWYKIAorLyoqCisgKiBET0M6IERD
IEZQVSBtYW5pcHVsYXRpb24gb3ZlcnZpZXcKKyAqCisgKiBEQyBjb3JlIHVzZXMgRlBVIG9wZXJh
dGlvbnMgaW4gbXVsdGlwbGUgcGFydHMgb2YgdGhlIGNvZGUsIHdoaWNoIHJlcXVpcmVzIGEKKyAq
IG1vcmUgc3BlY2lhbGl6ZWQgd2F5IHRvIG1hbmFnZSB0aGVzZSBhcmVhcycgZW50cmFuY2UuIFRv
IGZ1bGZpbGwgdGhpcworICogcmVxdWlyZW1lbnQsIHdlIGNyZWF0ZWQgc29tZSB3cmFwcGVyIGZ1
bmN0aW9ucyB0aGF0IGVuY2Fwc3VsYXRlCisgKiBrZXJuZWxfZnB1X2JlZ2luL2VuZCB0byBiZXR0
ZXIgZml0IG91ciBuZWVkIGluIHRoZSBkaXNwbGF5IGNvbXBvbmVudC4gSW4KKyAqIHN1bW1hcnks
IGluIHRoaXMgZmlsZSwgeW91IGNhbiBmaW5kIGZ1bmN0aW9ucyByZWxhdGVkIHRvIEZQVSBvcGVy
YXRpb24KKyAqIG1hbmFnZW1lbnQuCisgKi8KKworc3RhdGljIERFRklORV9QRVJfQ1BVKGludCwg
ZnB1X3JlY3Vyc2lvbl9kZXB0aCk7CisKIC8qKgogICogZGNfZnB1X2JlZ2luIC0gRW5hYmxlcyBG
UFUgcHJvdGVjdGlvbgogICogQGZ1bmN0aW9uX25hbWU6IEEgc3RyaW5nIGNvbnRhaW5pbmcgdGhl
IGZ1bmN0aW9uIG5hbWUgZm9yIGRlYnVnIHB1cnBvc2VzCkBAIC00OCwyMiArNjEsMzAgQEAKICAq
Lwogdm9pZCBkY19mcHVfYmVnaW4oY29uc3QgY2hhciAqZnVuY3Rpb25fbmFtZSwgY29uc3QgaW50
IGxpbmUpCiB7Ci0JVFJBQ0VfRENOX0ZQVSh0cnVlLCBmdW5jdGlvbl9uYW1lLCBsaW5lKTsKKwlp
bnQgKnBjcHU7CisKKwlwY3B1ID0gZ2V0X2NwdV9wdHIoJmZwdV9yZWN1cnNpb25fZGVwdGgpOwor
CSpwY3B1ICs9IDE7CiAKKwlpZiAoKnBjcHUgPT0gMSkgewogI2lmIGRlZmluZWQoQ09ORklHX1g4
NikKLQlrZXJuZWxfZnB1X2JlZ2luKCk7CisJCWtlcm5lbF9mcHVfYmVnaW4oKTsKICNlbGlmIGRl
ZmluZWQoQ09ORklHX1BQQzY0KQotCWlmIChjcHVfaGFzX2ZlYXR1cmUoQ1BVX0ZUUl9WU1hfQ09N
UCkpIHsKLQkJcHJlZW1wdF9kaXNhYmxlKCk7Ci0JCWVuYWJsZV9rZXJuZWxfdnN4KCk7Ci0JfSBl
bHNlIGlmIChjcHVfaGFzX2ZlYXR1cmUoQ1BVX0ZUUl9BTFRJVkVDX0NPTVApKSB7Ci0JCXByZWVt
cHRfZGlzYWJsZSgpOwotCQllbmFibGVfa2VybmVsX2FsdGl2ZWMoKTsKLQl9IGVsc2UgaWYgKCFj
cHVfaGFzX2ZlYXR1cmUoQ1BVX0ZUUl9GUFVfVU5BVkFJTEFCTEUpKSB7Ci0JCXByZWVtcHRfZGlz
YWJsZSgpOwotCQllbmFibGVfa2VybmVsX2ZwKCk7Ci0JfQorCQlpZiAoY3B1X2hhc19mZWF0dXJl
KENQVV9GVFJfVlNYX0NPTVApKSB7CisJCQlwcmVlbXB0X2Rpc2FibGUoKTsKKwkJCWVuYWJsZV9r
ZXJuZWxfdnN4KCk7CisJCX0gZWxzZSBpZiAoY3B1X2hhc19mZWF0dXJlKENQVV9GVFJfQUxUSVZF
Q19DT01QKSkgeworCQkJcHJlZW1wdF9kaXNhYmxlKCk7CisJCQllbmFibGVfa2VybmVsX2FsdGl2
ZWMoKTsKKwkJfSBlbHNlIGlmICghY3B1X2hhc19mZWF0dXJlKENQVV9GVFJfRlBVX1VOQVZBSUxB
QkxFKSkgeworCQkJcHJlZW1wdF9kaXNhYmxlKCk7CisJCQllbmFibGVfa2VybmVsX2ZwKCk7CisJ
CX0KICNlbmRpZgorCX0KKworCVRSQUNFX0RDTl9GUFUodHJ1ZSwgZnVuY3Rpb25fbmFtZSwgbGlu
ZSwgKnBjcHUpOworCXB1dF9jcHVfcHRyKCZmcHVfcmVjdXJzaW9uX2RlcHRoKTsKIH0KIAogLyoq
CkBAIC03OCwxOSArOTksMjcgQEAgdm9pZCBkY19mcHVfYmVnaW4oY29uc3QgY2hhciAqZnVuY3Rp
b25fbmFtZSwgY29uc3QgaW50IGxpbmUpCiAgKi8KIHZvaWQgZGNfZnB1X2VuZChjb25zdCBjaGFy
ICpmdW5jdGlvbl9uYW1lLCBjb25zdCBpbnQgbGluZSkKIHsKLQlUUkFDRV9EQ05fRlBVKGZhbHNl
LCBmdW5jdGlvbl9uYW1lLCBsaW5lKTsKKwlpbnQgKnBjcHU7CisKKwlwY3B1ID0gZ2V0X2NwdV9w
dHIoJmZwdV9yZWN1cnNpb25fZGVwdGgpOworCSpwY3B1IC09IDE7CisJaWYgKCpwY3B1IDw9IDAp
IHsKICNpZiBkZWZpbmVkKENPTkZJR19YODYpCi0Ja2VybmVsX2ZwdV9lbmQoKTsKKwkJa2VybmVs
X2ZwdV9lbmQoKTsKICNlbGlmIGRlZmluZWQoQ09ORklHX1BQQzY0KQotCWlmIChjcHVfaGFzX2Zl
YXR1cmUoQ1BVX0ZUUl9WU1hfQ09NUCkpIHsKLQkJZGlzYWJsZV9rZXJuZWxfdnN4KCk7Ci0JCXBy
ZWVtcHRfZW5hYmxlKCk7Ci0JfSBlbHNlIGlmIChjcHVfaGFzX2ZlYXR1cmUoQ1BVX0ZUUl9BTFRJ
VkVDX0NPTVApKSB7Ci0JCWRpc2FibGVfa2VybmVsX2FsdGl2ZWMoKTsKLQkJcHJlZW1wdF9lbmFi
bGUoKTsKLQl9IGVsc2UgaWYgKCFjcHVfaGFzX2ZlYXR1cmUoQ1BVX0ZUUl9GUFVfVU5BVkFJTEFC
TEUpKSB7Ci0JCWRpc2FibGVfa2VybmVsX2ZwKCk7Ci0JCXByZWVtcHRfZW5hYmxlKCk7Ci0JfQor
CQlpZiAoY3B1X2hhc19mZWF0dXJlKENQVV9GVFJfVlNYX0NPTVApKSB7CisJCQlkaXNhYmxlX2tl
cm5lbF92c3goKTsKKwkJCXByZWVtcHRfZW5hYmxlKCk7CisJCX0gZWxzZSBpZiAoY3B1X2hhc19m
ZWF0dXJlKENQVV9GVFJfQUxUSVZFQ19DT01QKSkgeworCQkJZGlzYWJsZV9rZXJuZWxfYWx0aXZl
YygpOworCQkJcHJlZW1wdF9lbmFibGUoKTsKKwkJfSBlbHNlIGlmICghY3B1X2hhc19mZWF0dXJl
KENQVV9GVFJfRlBVX1VOQVZBSUxBQkxFKSkgeworCQkJZGlzYWJsZV9rZXJuZWxfZnAoKTsKKwkJ
CXByZWVtcHRfZW5hYmxlKCk7CisJCX0KICNlbmRpZgorCX0KKworCVRSQUNFX0RDTl9GUFUoZmFs
c2UsIGZ1bmN0aW9uX25hbWUsIGxpbmUsICpwY3B1KTsKKwlwdXRfY3B1X3B0cigmZnB1X3JlY3Vy
c2lvbl9kZXB0aCk7CiB9CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNfdHJhY2UuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY190cmFjZS5o
CmluZGV4IGQ1OThiYTY5N2U0NS4uYzcxMTc5N2U1YzllIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfdHJhY2UuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNfdHJhY2UuaApAQCAtMzgsNSArMzgsNSBAQAogI2RlZmluZSBUUkFDRV9E
Q05fQ0xPQ0tfU1RBVEUoZGNuX2Nsb2NrcykgXAogCXRyYWNlX2FtZGdwdV9kbV9kY19jbG9ja3Nf
c3RhdGUoZGNuX2Nsb2NrcykKIAotI2RlZmluZSBUUkFDRV9EQ05fRlBVKGJlZ2luLCBmdW5jdGlv
biwgbGluZSkgXAotCXRyYWNlX2Rjbl9mcHUoYmVnaW4sIGZ1bmN0aW9uLCBsaW5lKQorI2RlZmlu
ZSBUUkFDRV9EQ05fRlBVKGJlZ2luLCBmdW5jdGlvbiwgbGluZSwgcmVmX2NvdW50KSBcCisJdHJh
Y2VfZGNuX2ZwdShiZWdpbiwgZnVuY3Rpb24sIGxpbmUsIHJlZl9jb3VudCkKLS0gCjIuMjUuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
