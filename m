Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A4DC433FE
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59AE522AAD
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59AE522AAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 171106E86F;
	Sat, 12 Dec 2020 15:46:57 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690048.outbound.protection.outlook.com [40.107.69.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C7416E86F
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:46:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DB5xVFFnsuIPH3MskVf1q4anVeB91mPmAUvQbGVWtkabqH2EcGSiHkN8yNTm5oHisgnvASFzqIcqTsPWdqltquXLNSwgNXSNY0+7gMIeO0+xSMi1yI3YN5Nx43vIXBn7IgPCSuGfOJkSpPrRS7vGgzIy6XnnKomzQ2tN14aHKqjfuJ8Kcs9/u5mCX/m0PKi5qrp7qeIbwwZYayRtr+I7EMStGup94TTn8rYgTAkVmoOAA5CnybqiZh57qg7ZL5NpjnVNPB5GNEPOuYuVs5QCwRCz+Eff72oQyIemXxkN/x9WWtDrQ2+PkNlUu1minLk05Ern56qco0PvwfdXLhNfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZULk7tLU2fzOZp4fOeabAXXwHdDr67wWZXyUjy4++w=;
 b=R1USa5rdKiUBAE2rmD5D7ypcbhNVihaF5m2xh+72StMpvy2NSk9yrlfpKrC5fSZDRfB3AktoT4B8fDRXFEPvMGvcVKWAa+/CWNSfOGD/ZTmowmsPMOGj9uPYfsTMiHlzQRZyeGKFfQZ944Mdf7W82UYleoGb/lIk4utI63Q/kmHmqGeiRgqZntgRw1IRTzM7qm5xZ8clg8pDaO5qDu6sofO2oaLvyVOpUUJ1A6+kBjx0Yqpc4QS59n7lJ8YJsXdD4dffl8GEm4YvfxJECbCB8B11n5WjMa+wjKOznPd5JSNXm/mO99WxbNwT47MS6i1cRQUgKG9eef5BvWbOBkvCbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZULk7tLU2fzOZp4fOeabAXXwHdDr67wWZXyUjy4++w=;
 b=nOLOdqZj850draBomEdc9MRf9bmhVgLBaawmWZLiWN25NmuKet0qYBcjtibc9Eau3MZ0gjSJlxljiynGesrfvGbY0EDveP4oRi2jhybygYX4br7nSBGxo+5Nzw9osgqIYx3uRV8iH1iMh3JN0colNVj/OS8GbNaWUusf9PXNpcs=
Received: from BN6PR08CA0051.namprd08.prod.outlook.com (2603:10b6:404:b9::13)
 by SN6PR12MB4622.namprd12.prod.outlook.com (2603:10b6:805:e2::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Sat, 12 Dec
 2020 15:46:53 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b9:cafe::be) by BN6PR08CA0051.outlook.office365.com
 (2603:10b6:404:b9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:46:53 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:52 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:46:50 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 15/27] drm/amdgpu: switch to ih_enable_ring for navi10
Date: Sat, 12 Dec 2020 23:45:48 +0800
Message-ID: <20201212154600.21618-15-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb32bc84-2696-432b-5268-08d89eb525ca
X-MS-TrafficTypeDiagnostic: SN6PR12MB4622:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4622E5EEB1C113B18DE85657FCC90@SN6PR12MB4622.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2alojbYtHA0+8PfSjDDFDvU43xV76wjm4RaxldNloOp9uUcf8+ZIOypVh+O56Rg232Kk0sw5ehKSeO7RRYYQETi7hz5NRoRoX3Y7JdBbEUEmeHuBMTT5drUF9wK8hRb7JJm2hnjBYi5lq/rEt9Fix33uw39fBhRkB9pa8wqJLL+aAcLUe5MTHzIvORIRiGbyLtTe/dGaVvNjiIn9x16mOthFnV1KBTtP4YMHMHmJzud2cd+mbQfL7r+V1lHQie+pVBWiPtCzmFebt5txE/ClfDFabZjQofYo8ygJYasQkKuT89ROGpO/17kB5ouYiBU+IeYhRZiwEMEa/MPyJ4cQtd1rVY5Df+im6G/2yDHonDbgRHRiwkbSINJOZLjVmxcVXpMvQAJRirOVhKYtRo65Zux8epZOxzbEsz+x2Pme+MMBijZ2IIoWjsw8n065vZwvlkG14va4ymURQJfvuOpfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(46966005)(26005)(426003)(8676002)(36756003)(186003)(70586007)(86362001)(4326008)(5660300002)(47076004)(356005)(336012)(2906002)(110136005)(7696005)(82310400003)(83380400001)(81166007)(2616005)(508600001)(6636002)(70206006)(66574015)(1076003)(8936002)(309714004)(357404004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:46:53.2770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb32bc84-2696-432b-5268-08d89eb525ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4622
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dXNlIG5hdmkxMF9paF9lbmFibGVfcmluZyB0byBlbmFibGUgYWxsIHRoZQphdmFpbGFibGUgcmlu
ZyBidWZmZXJzIGZvciBuYXZpMXggYW5kIG9ud2FyZHMKClNpZ25lZC1vZmYtYnk6IEhhd2tpbmcg
WmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQWNrZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxp
eC5LdWVobGluZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogRGVubmlzIExpIDxEZW5uaXMuTGlAYW1k
LmNvbT4KUmV2aWV3ZWQtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMgfCAxMDIgKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDkwIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9paC5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMKaW5kZXggZjIxOTM3ZTE5
YjZmLi43ZTQwMTcwYjM3OTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L25hdmkxMF9paC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9paC5j
CkBAIC0zMjMsMTAgKzMyMywxMSBAQCBzdGF0aWMgdm9pZCBuYXZpMTBfaWhfcmVyb3V0ZV9paChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKICAqLwogc3RhdGljIGludCBuYXZpMTBfaWhfaXJx
X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7Ci0Jc3RydWN0IGFtZGdwdV9paF9y
aW5nICppaCA9ICZhZGV2LT5pcnEuaWg7Ci0JdTMyIGloX3JiX2NudGwsIGloX2NoaWNrZW47CisJ
c3RydWN0IGFtZGdwdV9paF9yaW5nICppaFtdID0geyZhZGV2LT5pcnEuaWgsICZhZGV2LT5pcnEu
aWgxLCAmYWRldi0+aXJxLmloMn07CisJdTMyIGloX2NoaWNrZW47CiAJdTMyIHRtcDsKIAlpbnQg
cmV0OworCWludCBpOwogCiAJLyogZGlzYWJsZSBpcnFzICovCiAJcmV0ID0gbmF2aTEwX2loX3Rv
Z2dsZV9pbnRlcnJ1cHRzKGFkZXYsIGZhbHNlKTsKQEAgLTMzNSwyNyArMzM2LDggQEAgc3RhdGlj
IGludCBuYXZpMTBfaWhfaXJxX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAKIAlh
ZGV2LT5uYmlvLmZ1bmNzLT5paF9jb250cm9sKGFkZXYpOwogCi0JLyogUmluZyBCdWZmZXIgYmFz
ZS4gWzM5OjhdIG9mIDQwLWJpdCBhZGRyZXNzIG9mIHRoZSBiZWdpbm5pbmcgb2YgdGhlIHJpbmcg
YnVmZmVyKi8KLQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX0JBU0UsIGloLT5ncHVf
YWRkciA+PiA4KTsKLQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX0JBU0VfSEksIChp
aC0+Z3B1X2FkZHIgPj4gNDApICYgMHhmZik7Ci0KLQlpaF9yYl9jbnRsID0gUlJFRzMyX1NPQzE1
KE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMKTsKLQlpaF9yYl9jbnRsID0gbmF2aTEwX2loX3JiX2Nu
dGwoaWgsIGloX3JiX2NudGwpOwotCWloX3JiX2NudGwgPSBSRUdfU0VUX0ZJRUxEKGloX3JiX2Nu
dGwsIElIX1JCX0NOVEwsIFJQVFJfUkVBUk0sCi0JCQkJICAgISFhZGV2LT5pcnEubXNpX2VuYWJs
ZWQpOwotCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikgJiYgYWRldi0+YXNpY190eXBlIDwgQ0hJ
UF9OQVZJMTApIHsKLQkJaWYgKHBzcF9yZWdfcHJvZ3JhbSgmYWRldi0+cHNwLCBQU1BfUkVHX0lI
X1JCX0NOVEwsIGloX3JiX2NudGwpKSB7Ci0JCQlEUk1fRVJST1IoIlBTUCBwcm9ncmFtIElIX1JC
X0NOVEwgZmFpbGVkIVxuIik7Ci0JCQlyZXR1cm4gLUVUSU1FRE9VVDsKLQkJfQotCX0gZWxzZSB7
Ci0JCVdSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfQ05UTCwgaWhfcmJfY250bCk7Ci0J
fQotCWlmIChhZGV2LT5pcnEuaWgxLnJpbmdfc2l6ZSkKLQkJbmF2aTEwX2loX3Jlcm91dGVfaWgo
YWRldik7Ci0KIAlpZiAodW5saWtlbHkoYWRldi0+ZmlybXdhcmUubG9hZF90eXBlID09IEFNREdQ
VV9GV19MT0FEX0RJUkVDVCkpIHsKLQkJaWYgKGloLT51c2VfYnVzX2FkZHIpIHsKKwkJaWYgKGlo
WzBdLT51c2VfYnVzX2FkZHIpIHsKIAkJCXN3aXRjaCAoYWRldi0+YXNpY190eXBlKSB7CiAJCQlj
YXNlIENISVBfU0lFTk5BX0NJQ0hMSUQ6CiAJCQljYXNlIENISVBfTkFWWV9GTE9VTkRFUjoKQEAg
LTM3Niw3NyArMzU4LDE3IEBAIHN0YXRpYyBpbnQgbmF2aTEwX2loX2lycV9pbml0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQogCQl9CiAJfQogCi0JLyogc2V0IHRoZSB3cml0ZWJhY2sgYWRk
cmVzcyB3aGV0aGVyIGl0J3MgZW5hYmxlZCBvciBub3QgKi8KLQlXUkVHMzJfU09DMTUoT1NTU1lT
LCAwLCBtbUlIX1JCX1dQVFJfQUREUl9MTywKLQkJICAgICBsb3dlcl8zMl9iaXRzKGloLT53cHRy
X2FkZHIpKTsKLQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX1dQVFJfQUREUl9ISSwK
LQkJICAgICB1cHBlcl8zMl9iaXRzKGloLT53cHRyX2FkZHIpICYgMHhGRkZGKTsKLQotCS8qIHNl
dCBycHRyLCB3cHRyIHRvIDAgKi8KLQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX1JQ
VFIsIDApOwotCVdSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfV1BUUiwgMCk7Ci0KLQlX
UkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX0RPT1JCRUxMX1JQVFIsCi0JCQluYXZpMTBfaWhf
ZG9vcmJlbGxfcnB0cihpaCkpOwotCi0JYWRldi0+bmJpby5mdW5jcy0+aWhfZG9vcmJlbGxfcmFu
Z2UoYWRldiwgaWgtPnVzZV9kb29yYmVsbCwKLQkJCQkJICAgIGloLT5kb29yYmVsbF9pbmRleCk7
Ci0KLQlpaCA9ICZhZGV2LT5pcnEuaWgxOwotCWlmIChpaC0+cmluZ19zaXplKSB7Ci0JCVdSRUcz
Ml9TT0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfQkFTRV9SSU5HMSwgaWgtPmdwdV9hZGRyID4+IDgp
OwotCQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX0JBU0VfSElfUklORzEsCi0JCQkg
ICAgIChpaC0+Z3B1X2FkZHIgPj4gNDApICYgMHhmZik7Ci0KLQkJaWhfcmJfY250bCA9IFJSRUcz
Ml9TT0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfQ05UTF9SSU5HMSk7Ci0JCWloX3JiX2NudGwgPSBu
YXZpMTBfaWhfcmJfY250bChpaCwgaWhfcmJfY250bCk7Ci0JCWloX3JiX2NudGwgPSBSRUdfU0VU
X0ZJRUxEKGloX3JiX2NudGwsIElIX1JCX0NOVEwsCi0JCQkJCSAgIFdQVFJfT1ZFUkZMT1dfRU5B
QkxFLCAwKTsKLQkJaWhfcmJfY250bCA9IFJFR19TRVRfRklFTEQoaWhfcmJfY250bCwgSUhfUkJf
Q05UTCwKLQkJCQkJICAgUkJfRlVMTF9EUkFJTl9FTkFCTEUsIDEpOwotCQlpZiAoYW1kZ3B1X3Ny
aW92X3ZmKGFkZXYpICYmIGFkZXYtPmFzaWNfdHlwZSA8IENISVBfTkFWSTEwKSB7Ci0JCQlpZiAo
cHNwX3JlZ19wcm9ncmFtKCZhZGV2LT5wc3AsIFBTUF9SRUdfSUhfUkJfQ05UTF9SSU5HMSwKLQkJ
CQkJCWloX3JiX2NudGwpKSB7Ci0JCQkJRFJNX0VSUk9SKCJwcm9ncmFtIElIX1JCX0NOVExfUklO
RzEgZmFpbGVkIVxuIik7Ci0JCQkJcmV0dXJuIC1FVElNRURPVVQ7Ci0JCQl9Ci0JCX0gZWxzZSB7
Ci0JCQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX0NOVExfUklORzEsIGloX3JiX2Nu
dGwpOwotCQl9Ci0JCS8qIHNldCBycHRyLCB3cHRyIHRvIDAgKi8KLQkJV1JFRzMyX1NPQzE1KE9T
U1NZUywgMCwgbW1JSF9SQl9XUFRSX1JJTkcxLCAwKTsKLQkJV1JFRzMyX1NPQzE1KE9TU1NZUywg
MCwgbW1JSF9SQl9SUFRSX1JJTkcxLCAwKTsKLQotCQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBt
bUlIX0RPT1JCRUxMX1JQVFJfUklORzEsCi0JCQkJbmF2aTEwX2loX2Rvb3JiZWxsX3JwdHIoaWgp
KTsKLQl9Ci0KLQlpaCA9ICZhZGV2LT5pcnEuaWgyOwotCWlmIChpaC0+cmluZ19zaXplKSB7Ci0J
CVdSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfQkFTRV9SSU5HMiwgaWgtPmdwdV9hZGRy
ID4+IDgpOwotCQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX0JBU0VfSElfUklORzIs
Ci0JCQkgICAgIChpaC0+Z3B1X2FkZHIgPj4gNDApICYgMHhmZik7Ci0KLQkJaWhfcmJfY250bCA9
IFJSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfQ05UTF9SSU5HMik7Ci0JCWloX3JiX2Nu
dGwgPSBuYXZpMTBfaWhfcmJfY250bChpaCwgaWhfcmJfY250bCk7Ci0KLQkJaWYgKGFtZGdwdV9z
cmlvdl92ZihhZGV2KSAmJiBhZGV2LT5hc2ljX3R5cGUgPCBDSElQX05BVkkxMCkgewotCQkJaWYg
KHBzcF9yZWdfcHJvZ3JhbSgmYWRldi0+cHNwLCBQU1BfUkVHX0lIX1JCX0NOVExfUklORzIsCi0J
CQkJCQlpaF9yYl9jbnRsKSkgewotCQkJCURSTV9FUlJPUigicHJvZ3JhbSBJSF9SQl9DTlRMX1JJ
TkcyIGZhaWxlZCFcbiIpOwotCQkJCXJldHVybiAtRVRJTUVET1VUOwotCQkJfQotCQl9IGVsc2Ug
ewotCQkJV1JFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMX1JJTkcyLCBpaF9yYl9j
bnRsKTsKKwlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShpaCk7IGkrKykgeworCQlpZiAoaWhb
aV0tPnJpbmdfc2l6ZSkgeworCQkJcmV0ID0gbmF2aTEwX2loX2VuYWJsZV9yaW5nKGFkZXYsIGlo
W2ldKTsKKwkJCWlmIChyZXQpCisJCQkJcmV0dXJuIHJldDsKIAkJfQotCQkvKiBzZXQgcnB0ciwg
d3B0ciB0byAwICovCi0JCVdSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfV1BUUl9SSU5H
MiwgMCk7Ci0JCVdSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfUkJfUlBUUl9SSU5HMiwgMCk7
Ci0KLQkJV1JFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9ET09SQkVMTF9SUFRSX1JJTkcyLAot
CQkJICAgICBuYXZpMTBfaWhfZG9vcmJlbGxfcnB0cihpaCkpOwogCX0KIAorCS8qIHVwZGF0ZSBk
b29yYmVsbCByYW5nZSBmb3IgaWggcmluZyAwKi8KKwlhZGV2LT5uYmlvLmZ1bmNzLT5paF9kb29y
YmVsbF9yYW5nZShhZGV2LCBpaFswXS0+dXNlX2Rvb3JiZWxsLAorCQkJCQkgICAgaWhbMF0tPmRv
b3JiZWxsX2luZGV4KTsKIAogCXRtcCA9IFJSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfU1RP
Uk1fQ0xJRU5UX0xJU1RfQ05UTCk7CiAJdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIElIX1NUT1JN
X0NMSUVOVF9MSVNUX0NOVEwsCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
