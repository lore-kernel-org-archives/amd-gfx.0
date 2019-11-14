Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5AEC432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 03:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885FC206E1
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 03:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885FC206E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ACFA6E130;
	Thu, 14 Nov 2019 03:45:03 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800058.outbound.protection.outlook.com [40.107.80.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BE546E17C
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 03:45:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4KTrkbonAL1Py8dnCcb++NIUKXU2oTBiX4Icysl+oqu7ASgWDBkNhtczP/uq4kXy2T/1H4F50unM+PvB8mtnrnqbgfimKG7dpWESEAKsKdYuGA/kDG/t8G3V5qw5sHuErlkE4HY0Gb3hyKnNX5ZlLDRxAFFuutaNUX9tlLhn9Vv8F1KAnJlYjJkdYef5c4+InQq1U/U3cyON0GuCUjQ26omQmcdudHgLLYVnEVTPkNeR7YZud7iza9vHUjEM49f6ewqkaqcX6iLKML9mgT1VJQhICNwC/CuQUf6gPozAgEdho+LS3ssIErgRfMcTUJsR+c/IAQ+YXFBoL/dfKrapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jv+OCDDn4XfrmS5T6GWTDUByboKxW4JTg1Y33ySG9QQ=;
 b=Vc/Ge240xNShUYaIFedacKHKSKZcyfYt0y2iLNhjCuAn05of72/TAVYPOEcQCCj451AlIkksFemGVWPE1ZtTUz4naRlrp1ars3AuoEZJPtBrUIXAZOE+jNTKGrMA3JcimTeNVi4mMmh+jmQ3GriEvlXrvaARThNX6p3goeY2f+g+eDUfDd4bKsufx3c0ncjkb7dt5xrAdt2mXJuGzjNLVA/Ppg4pvi+WXPkOBwKPCE3ini+LQjylKq7ub+P7QeX29ZMIbZBjQqZHQSyqea+15rMLZhlNrEuW3ST1JJpDcVTLIQpcztE8VWZxI933ifhr1OP3yoCoeykchks4yrjewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN8PR12CA0025.namprd12.prod.outlook.com (2603:10b6:408:60::38)
 by DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22; Thu, 14 Nov
 2019 03:45:00 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::206) by BN8PR12CA0025.outlook.office365.com
 (2603:10b6:408:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Thu, 14 Nov 2019 03:45:00 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Thu, 14 Nov 2019 03:45:00 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 13 Nov
 2019 21:45:00 -0600
Received: from swae-HP-ProBook-455R-G6.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 13 Nov 2019 21:44:58 -0600
From: Louis Li <Ching-shih.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/display: Fix Apple dongle cannot be successfully
 detected
Date: Thu, 14 Nov 2019 11:42:12 +0800
Message-ID: <20191114034212.1106-1-Ching-shih.Li@amd.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(428003)(47660400002)(189003)(199004)(50226002)(53416004)(81156014)(86362001)(486006)(126002)(2616005)(186003)(476003)(336012)(426003)(26005)(1076003)(50466002)(8676002)(81166006)(2351001)(48376002)(70206006)(70586007)(4326008)(7696005)(6666004)(356004)(51416003)(36756003)(8936002)(2906002)(14444005)(5660300002)(316002)(2870700001)(478600001)(47776003)(305945005)(54906003)(6916009)(46800400005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4058; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d34bcda-f977-41d5-5141-08d768b5069d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4058:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4058B2203C043519096EFF88AA710@DM6PR12MB4058.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02213C82F8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /SnERlA1uLaP4FPAbedFBfl92Usw5RarHZkGKhXYvrjVbLAuUCaOs9cGkML9rr5TkCn9WEbTI6NBV+GbMAOuyTHycwFAQA0vhTbuBR46BM2GIc0mQrBSud5lfjUf+7UiHhDapJWomU1ef8OBoc27siJfZ8EyotYJVvwD5XQmCxH+6Uy1AwQGllx1IfGWv4jwHWcUFj3GIEfYYo5smuDnYFi0t17s4cWwleqqVrMhui6izqm96Tm/rOxBFrYVWXSdVRSOCrJsS9XUrk8AQodjelTGe4qwMt0r/+dDW+Ok0uGSgG/YYt4pgEvFl4NieMQzEpvD8UicyLQolMS2N6IXd+CM8xLm01ihm9fLeR/kwDh/jUeQk0J9tJwdpjkv2l5Hb642S8bgcISciaOnQNzeQz/Wn8VNQeY8CR7MNqveU0NOjqYxBh9TizDGQ7FQFNjR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 03:45:00.5136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d34bcda-f977-41d5-5141-08d768b5069d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jv+OCDDn4XfrmS5T6GWTDUByboKxW4JTg1Y33ySG9QQ=;
 b=VBoPQX9SEFWIa4TqDCGVYOkaMWrRMSlRAvC/e/fBtSLBECkLYbvLrarEPjJuThQFxWFX7XZZwz1PL3lyFWkdPgvVfDpp6RA0auUMGf1NefeVAf8uPch91A4Wkh9Cga3MV3461lUj72Ps3etXMpNPDkTQ3+M80oPbEZmiN4hTHPo=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
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
Cc: harry.wentland@amd.com, nicholas.kazlauskas@amd.com,
 Louis Li <Ching-shih.Li@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114034212.MD8HtAaYfhoAZwjnR_PE9d269hde2SiIF5QN4pcM3ng@z>

W1doeV0KRXh0ZXJuYWwgbW9uaXRvciBjYW5ub3QgYmUgZGlzcGxheWVkIGNvbnNpc3RlbnRseSwg
aWYgY29ubmVjdGluZwp2aWEgdGhpcyBBcHBsZSBkb25nbGUgKEExNjIxLCBVU0IgVHlwZS1DIHRv
IEhETUkpLgpCeSBleHBlcmltZW50cywgaXQgaXMgY29uZmlybWVkIHRoYXQgdGhlIGRvbmdsZSBu
ZWVkcyAyMDBtcyBhdCBsZWFzdAp0byBiZSByZWFkeSBmb3IgY29tbXVuaWNhdGlvbiwgYWZ0ZXIg
aXQgc2V0cyBIUEQgc2lnbmFsIGhpZ2guCgpbSG93XQpXaGVuIHJlY2VpdmluZyBIUEQgSVJRLCBk
ZWxheSAzMDBtcyBhdCB0aGUgYmVnaW5uaW5nIG9mIGhhbmRsZV9ocGRfaXJxKCkuClRoZW4gcnVu
IHRoZSBvcmlnaW5hbCBwcm9jZWR1cmUuCldpdGggdGhpcyBwYXRjaCBhcHBsaWVkLCB0aGUgcHJv
YmxlbSBjYW5ub3QgYmUgcmVwcm9kdWNlZC4KV2l0aCBvdGhlciBkb25nbGVzLCB0ZXN0IHJlc3Vs
dHMgYXJlIFBBU1MuClRlc3QgcmVzdWx0IGlzIFBBU1MgdG8gcGx1ZyBpbiBIRE1JIGNhYmxlIHdo
aWxlIHBsYXlpbmcgdmlkZW8sCmFuZCB0aGUgdmlkZW8gaXMgYmVpbmcgcGxheWluZyBzbW9vdGhs
eS4KVGVzdCByZXN1bHQgaXMgUEFTUyBhZnRlciBzeXN0ZW0gcmVzdW1lcyBmcm9tIHN1c3BlbmQu
CgpTaWduZWQtb2ZmLWJ5OiBMb3VpcyBMaSA8Q2hpbmctc2hpaC5MaUBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCA1ICsrKysr
CiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKaW5kZXggMGFlZjkyYjdjMDM3Li41
Yjg0NGI2YTVhNTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uYwpAQCAtMTAyNSw2ICsxMDI1LDExIEBAIHN0YXRpYyB2b2lkIGhhbmRs
ZV9ocGRfaXJxKHZvaWQgKnBhcmFtKQogCXN0cnVjdCBkcm1fZGV2aWNlICpkZXYgPSBjb25uZWN0
b3ItPmRldjsKIAllbnVtIGRjX2Nvbm5lY3Rpb25fdHlwZSBuZXdfY29ubmVjdGlvbl90eXBlID0g
ZGNfY29ubmVjdGlvbl9ub25lOwogCisJLyogU29tZSBtb25pdG9ycy9kb25nbGVzIG5lZWQgYXJv
dW5kIDIwMG1zIHRvIGJlIHJlYWR5IGZvciBjb21tdW5pY2F0aW9uCisJICogYWZ0ZXIgdGhvc2Ug
ZGV2aWNlcyBkcml2ZSBIUEQgc2lnbmFsIGhpZ2guCisJICovCisJbXNsZWVwKDMwMCk7CisKIAkv
KiBJbiBjYXNlIG9mIGZhaWx1cmUgb3IgTVNUIG5vIG5lZWQgdG8gdXBkYXRlIGNvbm5lY3RvciBz
dGF0dXMgb3Igbm90aWZ5IHRoZSBPUwogCSAqIHNpbmNlIChmb3IgTVNUIGNhc2UpIE1TVCBkb2Vz
IHRoaXMgaW4gaXQncyBvd24gY29udGV4dC4KIAkgKi8KLS0gCjIuMjEuMAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
