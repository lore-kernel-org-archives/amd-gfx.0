Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A76C34031
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 03:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98C82072C
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 03:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="16iYCMRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98C82072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6327C6E124;
	Tue, 18 Feb 2020 03:37:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12C496E124
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 03:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBwh2JrRczmVPWv4iDs9BP/mJtTfID7arU6JWMYA4hwF8+3GaOCPEQgC7wQDdbq3tkp00mCMUzwRojTgUTHZS5La/NNRUyuTNRa2UvubPi+r5g5Io5X3CHdQPtTOaIE+PvB2pHebuZiLb4njYX2z92Nu+Ono3NDRThcT6MZd+eoCimVC/PRyftOksD5CjHgqPfTd0zro4pjU9UnPoJ06btNkstbNlYFAz+r54oimbSqsrDlxgTpIor/4w5uh8PdpPKFAQLvqkWUq8Ir/EbcqY18CTNPYGvlXQHb2gVLu1UF+WvG7FKsd961ynKT0fnGAyJ7ujyUCLO9FjY0NNaOD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dkGP2EHE0m9HkW1PxbhPaxwrFMA5ROft1jBA5ZRyPM=;
 b=GC/oWUk1Svfp60x3aMbgLMg/CaU1RTXByE1J+gebmaTnWg2M8xzWWFfgea3NgarRPJ7JUIgTVMQdnjIZhYI0LJoA2ueqzKimq6O8yMNQ9VjY3O2LxSweFA6hDRXhJEvwofFKAcwynKQgCZ4IQmhyEqtUWXbi8JLYlddPdtG18tuyl8xKm0W/CYelyixGDCmpMcxNJIuTxrQcCNTXBdAyHAmoBaVgSzzMF/wt+kgbVSCGOh3mS+vPdzdLrpEH5UBtgVKGHtX0H4F5y5lX0Jk9JUx+Fbhf0kcCkW3OhtF9Gc9Dz5ooIepPpka1kqh5N1Khjs9nHxyMXk/DamB5h0P8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dkGP2EHE0m9HkW1PxbhPaxwrFMA5ROft1jBA5ZRyPM=;
 b=16iYCMRVEI9J2iKh7VV2h9tc4sB0nDiMpAweXNvnCD3TTiglR7vGWjE9lcl1H1Ax0Y/vWa9aFoa/TnVCDqaJfPjW0JBD0KbWOLdIA1rqGu/BhAMd4180iMl+Vt8IIJTo9PJjQAXqY56UmfX/AD+2fy4bZCMPlus31wK8lPwZ19w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (52.135.101.138) by
 SN6PR12MB2606.namprd12.prod.outlook.com (52.135.102.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Tue, 18 Feb 2020 03:37:23 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::b99c:18c0:8685:1c10%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 03:37:23 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH v5] drm/amdgpu: Remove kfd eviction fence before release bo
Date: Tue, 18 Feb 2020 11:36:50 +0800
Message-Id: <20200218033650.7665-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:202:16::22) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR02CA0138.apcprd02.prod.outlook.com (2603:1096:202:16::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Tue, 18 Feb 2020 03:37:21 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aab765c8-0514-431c-5d85-08d7b423dd8e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2606:|SN6PR12MB2606:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB260667828F09E55ACBEFCE9787110@SN6PR12MB2606.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(199004)(189003)(4326008)(54906003)(81166006)(316002)(8676002)(6486002)(5660300002)(8936002)(1076003)(66574012)(81156014)(66946007)(2616005)(956004)(16526019)(52116002)(6916009)(2906002)(478600001)(86362001)(186003)(7696005)(36756003)(6666004)(66556008)(66476007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2606;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITo0DiLAUEjD/+z6u8Z1J6MfFmIdBpwDmgep4pMIA4DA5s3EHem25Vnmn4qFIq49iMYbMq7s+3EeWAdcEJvr4gci6t+0cGETjzHnlx1V+bB+2zWiyktIaIOcce+TIgk2zXL25d5vpw4Vpyq2ufF1ig2tSwp5Wkcct+tjt1VkBGfdcSkd9SXjM3eTcVgnx5ICKjIyHeeS48JGiJT2/52Ug03Ffwced0+IJeFhdcvAVEns6V/BV3MC69CndF9gyJHKu1ufddJtgt9YB8K4Re4qBClcsSutwJXjefM7KbGaGEl6O42NR/szszU3FxWDmCxc/Ik6NkYOMu+t/DrOKoi5cWHNsDSjbiJeUa/rWHIJ/e9srRghHd7RLapIsBy7KsaKVHB6ktL9Xaifw0r19KfynxAKDMSX5Fg9v+F/oWW9IqCqm8pVYupQVB0i114ub4+C
X-MS-Exchange-AntiSpam-MessageData: UcBb6U3qUGW+z7D7tTseJ/sqTAhJz3tarKXd1XsNb7X+74cHnNRbnctbJ52dNhFHo+LeNqedl2qTPeNacuIOmYdrdi0JS0oAovxiY839li9RVxl/B/CwET+KFOYwFNzw/BGb12g1uWPPoV72k5DfBg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab765c8-0514-431c-5d85-08d7b423dd8e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 03:37:23.1553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpU/TaEygjotKKOqm68E9+ZMuxcSiHs6Fe9ig1TrfrAfoEU9tWsdLEgYihLS/GPS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2606
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, xinhui pan <xinhui.pan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Tm8gbmVlZCB0byB0cmlnZ2VyIGV2aWN0aW9uIGFzIHRoZSBtZW1vcnkgbWFwcGluZyB3aWxsIG5v
dCBiZSB1c2VkCmFueW1vcmUuCgpBbGwgcHQvcGQgYm9zIHNoYXJlIHNhbWUgcmVzdiwgaGVuY2Ug
dGhlIHNhbWUgc2hhcmVkIGV2aWN0aW9uIGZlbmNlLgpFdmVyeXRpbWUgcGFnZSB0YWJsZSBpcyBm
cmVlZCwgdGhlIGZlbmNlIHdpbGwgYmUgc2lnbmxlZCBhbmQgdGhhdCBjdWFzZXMKa2ZkIHVuZXhj
ZXB0ZWQgZXZpY3Rpb25zLgoKU2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBh
bWQuY29tPgpDQzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpD
QzogRmVsaXggS3VlaGxpbmcgPGZlbGl4Lmt1ZWhsaW5nQGFtZC5jb20+CkNDOiBBbGV4IERldWNo
ZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQpjaGFuZ2UgZnJvbSB2NDoKYmFzZWQg
b24gbmV3IHR0bSBjb2RlLgoKY2hhbmdlIGZyb20gdjM6CmZpeCBhIGNvZGluZyBlcnJvcgoKY2hh
bmdlIGZyb20gdjI6CmJhc2VkIG9uIENocmlzJyBkcm0vdHRtOiByZXdvcmsgQk8gZGVsYXllZCBk
ZWxldGUgcGF0Y2hzZXQuCgotLS0KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkLmggICAgfCAgMSArCiAuLi4vZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmRfZ3B1dm0uYyAgfCAzNyArKysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgICAgfCAgNCArKwogMyBmaWxlcyBjaGFuZ2VkLCA0MiBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5o
CmluZGV4IDllOGRiNzAyZDg3OC4uMGVlOGFhZTZjNTE5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oCkBAIC05Niw2ICs5Niw3IEBAIHN0cnVjdCBhbWRncHVf
YW1ka2ZkX2ZlbmNlICphbWRncHVfYW1ka2ZkX2ZlbmNlX2NyZWF0ZSh1NjQgY29udGV4dCwKIAkJ
CQkJCSAgICAgICBzdHJ1Y3QgbW1fc3RydWN0ICptbSk7CiBib29sIGFtZGtmZF9mZW5jZV9jaGVj
a19tbShzdHJ1Y3QgZG1hX2ZlbmNlICpmLCBzdHJ1Y3QgbW1fc3RydWN0ICptbSk7CiBzdHJ1Y3Qg
YW1kZ3B1X2FtZGtmZF9mZW5jZSAqdG9fYW1kZ3B1X2FtZGtmZF9mZW5jZShzdHJ1Y3QgZG1hX2Zl
bmNlICpmKTsKK2ludCBhbWRncHVfYW1ka2ZkX3JlbW92ZV9mZW5jZV9vbl9wdF9wZF9ib3Moc3Ry
dWN0IGFtZGdwdV9ibyAqYm8pOwogCiBzdHJ1Y3QgYW1ka2ZkX3Byb2Nlc3NfaW5mbyB7CiAJLyog
TGlzdCBoZWFkIG9mIGFsbCBWTXMgdGhhdCBiZWxvbmcgdG8gYSBLRkQgcHJvY2VzcyAqLwpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCmluZGV4
IGVmNzIxY2I2NTg2OC4uNmFhMjBhYTgyYmQzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCkBAIC0yNzYsNiArMjc2LDQxIEBAIHN0YXRp
YyBpbnQgYW1kZ3B1X2FtZGtmZF9yZW1vdmVfZXZpY3Rpb25fZmVuY2Uoc3RydWN0IGFtZGdwdV9i
byAqYm8sCiAJcmV0dXJuIDA7CiB9CiAKK2ludCBhbWRncHVfYW1ka2ZkX3JlbW92ZV9mZW5jZV9v
bl9wdF9wZF9ib3Moc3RydWN0IGFtZGdwdV9ibyAqYm8pCit7CisJc3RydWN0IGFtZGdwdV9ibyAq
cm9vdCA9IGJvOworCXN0cnVjdCBhbWRncHVfdm1fYm9fYmFzZSAqdm1fYm87CisJc3RydWN0IGFt
ZGdwdV92bSAqdm07CisJc3RydWN0IGFtZGtmZF9wcm9jZXNzX2luZm8gKmluZm87CisJc3RydWN0
IGFtZGdwdV9hbWRrZmRfZmVuY2UgKmVmOworCWludCByZXQ7CisKKwl3aGlsZSAocm9vdC0+cGFy
ZW50KQorCQlyb290ID0gcm9vdC0+cGFyZW50OworCisJdm1fYm8gPSByb290LT52bV9ibzsKKwlp
ZiAoIXZtX2JvKQorCQlyZXR1cm4gMDsKKworCXZtID0gdm1fYm8tPnZtOworCWlmICghdm0pCisJ
CXJldHVybiAwOworCisJaW5mbyA9IHZtLT5wcm9jZXNzX2luZm87CisJaWYgKCFpbmZvIHx8ICFp
bmZvLT5ldmljdGlvbl9mZW5jZSkKKwkJcmV0dXJuIDA7CisKKwllZiA9IGNvbnRhaW5lcl9vZihk
bWFfZmVuY2VfZ2V0KCZpbmZvLT5ldmljdGlvbl9mZW5jZS0+YmFzZSksCisJCQlzdHJ1Y3QgYW1k
Z3B1X2FtZGtmZF9mZW5jZSwgYmFzZSk7CisKKwlkbWFfcmVzdl9sb2NrKGJvLT50Ym8uYmFzZS5y
ZXN2LCBOVUxMKTsKKwlyZXQgPSBhbWRncHVfYW1ka2ZkX3JlbW92ZV9ldmljdGlvbl9mZW5jZShi
bywgZWYpOworCWRtYV9yZXN2X3VubG9jayhiby0+dGJvLmJhc2UucmVzdik7CisKKwlkbWFfZmVu
Y2VfcHV0KCZlZi0+YmFzZSk7CisJcmV0dXJuIHJldDsKK30KKwogc3RhdGljIGludCBhbWRncHVf
YW1ka2ZkX2JvX3ZhbGlkYXRlKHN0cnVjdCBhbWRncHVfYm8gKmJvLCB1aW50MzJfdCBkb21haW4s
CiAJCQkJICAgICBib29sIHdhaXQpCiB7CkBAIC0xMDQ1LDYgKzEwODAsOCBAQCB2b2lkIGFtZGdw
dV9hbWRrZmRfZ3B1dm1fZGVzdHJveV9jYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAls
aXN0X2RlbCgmdm0tPnZtX2xpc3Rfbm9kZSk7CiAJbXV0ZXhfdW5sb2NrKCZwcm9jZXNzX2luZm8t
PmxvY2spOwogCisJdm0tPnByb2Nlc3NfaW5mbyA9IE5VTEw7CisKIAkvKiBSZWxlYXNlIHBlci1w
cm9jZXNzIHJlc291cmNlcyB3aGVuIGxhc3QgY29tcHV0ZSBWTSBpcyBkZXN0cm95ZWQgKi8KIAlp
ZiAoIXByb2Nlc3NfaW5mby0+bl92bXMpIHsKIAkJV0FSTl9PTighbGlzdF9lbXB0eSgmcHJvY2Vz
c19pbmZvLT5rZmRfYm9fbGlzdCkpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X29iamVjdC5jCmluZGV4IDZmNjBhNTgxZTNiYS4uMTY1ODY2NTEwMjBmIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCkBAIC0xMzA3LDYgKzEzMDcsMTAgQEAg
dm9pZCBhbWRncHVfYm9fcmVsZWFzZV9ub3RpZnkoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpi
bykKIAlpZiAoYWJvLT5rZmRfYm8pCiAJCWFtZGdwdV9hbWRrZmRfdW5yZXNlcnZlX21lbW9yeV9s
aW1pdChhYm8pOwogCisJLyogV2Ugb25seSByZW1vdmUgdGhlIGZlbmNlIGlmIHRoZSByZXN2IGhh
cyBpbmRpdmlkdWFsaXplZC4gKi8KKwlpZiAoYm8tPmJhc2UucmVzdiA9PSAmYm8tPmJhc2UuX3Jl
c3YpCisJCWFtZGdwdV9hbWRrZmRfcmVtb3ZlX2ZlbmNlX29uX3B0X3BkX2JvcyhhYm8pOworCiAJ
aWYgKGJvLT5tZW0ubWVtX3R5cGUgIT0gVFRNX1BMX1ZSQU0gfHwgIWJvLT5tZW0ubW1fbm9kZSB8
fAogCSAgICAhKGFiby0+ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9WUkFNX1dJUEVfT05fUkVM
RUFTRSkpCiAJCXJldHVybjsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
