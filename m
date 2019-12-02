Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9137DC432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 727D520848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727D520848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD8406E2DA;
	Mon,  2 Dec 2019 17:35:58 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800050.outbound.protection.outlook.com [40.107.80.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 930266E2E2
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUSjhCChGhG6DZynMoDBXxtljpecZmYiJMUvk/Xq2luWiLUU0EhD6aI+Yors+Mgdy0TiexJJXrLX2L0ZsPjhUUys4uycizUUshLcDS1CtbNKKsLF6dqV9Qm5ZawtMlIk+DkPLrpQ3544UHeLnuiKZgsWWBCk/FcWTj2Ho9FaWyG3rtE7cIjWpoKrTi+qFHzdyyXHrKk0hGALSyrtoL06Q1+bSt34Dz2qpGavyjOCKHDrsosiv4YPiGO/uTAziTJLuAluUs5deaE23qtSMWTO8JRobj7l0ixoCEjtMep1xwGKVGM+uVVQ02ZbtjFSKNzPWm26dylKIRMDcdT2O2ieWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSaskrpxYDU9/pwFGy2m+B6poeiP8cKsLNQgAnI5+kg=;
 b=XfKjv5WmtkwCMgxE5CGCxbFo5WaVUBR7C6DBg7Z1EunzX6OSjBIegf4AetwffW/E2rQs3FpIlzFVAcfblCeicNpPvUkKhnfDQJ24iGmPfQrAh770BZMWz/R+naUYmU/wdO6rpEEOFmF2VnPftJZ2t0OXDIhbqdzFFejiFLgu6xkAH2nTnDMGsLE/3/MkbIP5ISlIV2oxonN+3/Mgzo1oQ4BTd0G2Llfled0pG2FGY8vp8K1345IuGjlfGUMqxLLO93urrHSlbjAcLRtaiytPtaP2326zyQEQ4nAQ1lVFq4tOU8V9lwC7BVSk66rvw1uXb83o55qX+SOJ3D0u4ta/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:56 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:56 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 48/51] drm/amd/display: Compare clock state member to
 determine optimization.
Date: Mon,  2 Dec 2019 12:34:02 -0500
Message-Id: <20191202173405.31582-49-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c22e4900-2bf6-4a42-ce55-08d7774e06fe
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2610A7A7FB903758886B47BC82430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(6666004)(51416003)(52116002)(6512007)(66476007)(66556008)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(14444005)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7tWeXNVGpAm/kKv6oCYzPgs8SaUbyfYDAjsbMLmU55eAkzmpUV1X9ShCsy5S9p8+AXPBazVMj3xtuT6IeHApt4smnZ2uralGKnzKsWK3Od3Eciz6XDGBqFITchqxZLh9ZotsvBEf8SzPx21HdMOT9jAlwNMYm2Wm97S6whOOZs+4z22Hu1Okq55R71EOfEcHXVW/r8j1K9FGNxsz6PA0xGBvDFJ6ZWUi17XZOW4FVNpGmfT/MwBRKH3d9vK48DGuVD5pG8crYMbjJ+uoi8vcUl8BkNakppdzrRwRKHigMXXvXkcc7rfcHyJnHod0OJDy0DVzLKphA+PmECWJ+h+o6zV7P5mmxfV+OGI3TrcnhXcJyNAKnQBzqM8CjD6CRrvArdpTLpOVPoi9H0htIPZWN5wRslhQJyGT/s3npwmO+kYu3GKENRzDoPLKY4/SUPnM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22e4900-2bf6-4a42-ce55-08d7774e06fe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:30.6989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HV+dSSUI7952tsrEz5vtJXOUPKeTgCtoBmngdqgUoOdeRbfh9WKIaujNmtuenC8K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSaskrpxYDU9/pwFGy2m+B6poeiP8cKsLNQgAnI5+kg=;
 b=Xa2KX5g8uhFL+otcIYTIsRIRrnVZs/uqEHBh8uXGvKX4P0Db0X98dCxVS5p8Bi/RZ/p9oGuUxI+KehdvgFrU0H1z1YYx1RfTkBu9krq3xBSNJ45FdSlQ4JnfhGCZG8BuGwdG4Ebe309HhKD46i/tSUtjFzVAi2For6CXKwu/ggE=
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
Cc: Leo Li <sunpeng.li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 rodrigo.siqueira@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 harry.wentland@amd.com, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgoKW1doeV0KSXQgc2Vl
bXMgYWx3YXlzIHJlcXVlc3QgcGFzc2l2ZSBmbGlwIG9uIFJOIGR1ZSB0byBpbmNvcnJlY3QgY29t
cGFyZQpjbG9jayBzdGF0ZSB0byBkZXRlcm1pbmUgb3B0aXphdGlvbi4KCltIb3ddCkluc3RlYWQg
b2YgY2FsbGluZyBtZW1jbXAsIGNvbXBhcmUgY2xvY2sgc3RhdGUgbWVtYmVyIHRvIGRldGVybWlu
ZSB0aGUKY29uZGl0aW9uLgoKU2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5n
LnN1bkBhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9ueSBDaGVuZyA8VG9ueS5DaGVuZ0BhbWQuY29t
PgpBY2tlZC1ieTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQogLi4uL2FtZC9kaXNw
bGF5L2RjL2Nsa19tZ3IvZGNuMjEvcm5fY2xrX21nci5jICB8IDE4ICsrKysrKysrKysrKysrKysr
LQogMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2xrX21nci9kY24yMS9ybl9j
bGtfbWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2xrX21nci9kY24yMS9y
bl9jbGtfbWdyLmMKaW5kZXggMzcyMzBkM2Q5NGEwLi5kZTUxZWYxMmUzM2EgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jbGtfbWdyL2RjbjIxL3JuX2Nsa19tZ3Iu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY2xrX21nci9kY24yMS9ybl9j
bGtfbWdyLmMKQEAgLTQ3MSwxMiArNDcxLDI4IEBAIHN0YXRpYyB2b2lkIHJuX25vdGlmeV93bV9y
YW5nZXMoc3RydWN0IGNsa19tZ3IgKmNsa19tZ3JfYmFzZSkKIAogfQogCitzdGF0aWMgYm9vbCBy
bl9hcmVfY2xvY2tfc3RhdGVzX2VxdWFsKHN0cnVjdCBkY19jbG9ja3MgKmEsCisJCXN0cnVjdCBk
Y19jbG9ja3MgKmIpCit7CisJaWYgKGEtPmRpc3BjbGtfa2h6ICE9IGItPmRpc3BjbGtfa2h6KQor
CQlyZXR1cm4gZmFsc2U7CisJZWxzZSBpZiAoYS0+ZHBwY2xrX2toeiAhPSBiLT5kcHBjbGtfa2h6
KQorCQlyZXR1cm4gZmFsc2U7CisJZWxzZSBpZiAoYS0+ZGNmY2xrX2toeiAhPSBiLT5kY2ZjbGtf
a2h6KQorCQlyZXR1cm4gZmFsc2U7CisJZWxzZSBpZiAoYS0+ZGNmY2xrX2RlZXBfc2xlZXBfa2h6
ICE9IGItPmRjZmNsa19kZWVwX3NsZWVwX2toeikKKwkJcmV0dXJuIGZhbHNlOworCisJcmV0dXJu
IHRydWU7Cit9CisKKwogc3RhdGljIHN0cnVjdCBjbGtfbWdyX2Z1bmNzIGRjbjIxX2Z1bmNzID0g
ewogCS5nZXRfZHBfcmVmX2Nsa19mcmVxdWVuY3kgPSBkY2UxMl9nZXRfZHBfcmVmX2ZyZXFfa2h6
LAogCS51cGRhdGVfY2xvY2tzID0gcm5fdXBkYXRlX2Nsb2NrcywKIAkuaW5pdF9jbG9ja3MgPSBy
bl9pbml0X2Nsb2NrcywKIAkuZW5hYmxlX3BtZV93YSA9IHJuX2VuYWJsZV9wbWVfd2EsCi0JLyog
LmR1bXBfY2xrX3JlZ2lzdGVycyA9IHJuX2R1bXBfY2xrX3JlZ2lzdGVycywgKi8KKwkuYXJlX2Ns
b2NrX3N0YXRlc19lcXVhbCA9IHJuX2FyZV9jbG9ja19zdGF0ZXNfZXF1YWwsCiAJLm5vdGlmeV93
bV9yYW5nZXMgPSBybl9ub3RpZnlfd21fcmFuZ2VzCiB9OwogCi0tIAoyLjI0LjAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
