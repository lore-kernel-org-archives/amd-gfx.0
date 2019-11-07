Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1715C5DF60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 15:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A08206C3
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 15:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A08206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ABFA6F73D;
	Thu,  7 Nov 2019 15:56:54 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820044.outbound.protection.outlook.com [40.107.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ED7F6F733
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 15:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXgSHj3CU2+xIuRv9oWBceveT2XLjWyO7KckBp7nuBMNBLn4fXvET9klDsB6UoqLBM8DuOjDKG/gvCObU3WHHC7yhhJRd4ZTK1+N9DiFk6/8AHCVD10caTX4WJv2rULIqwzRFVW/A5FZN2KhKG6yE9E/36wNlEJG1KprOSIywgJdB5GcAoCn+1maandiykhqK00Hq6KilFRl3fWx8VBilpq6mQ6Ggi8QnkjKmQS/vc1JcHJKHZkpufisl5p97qW/QQL9p/rYhcXOKb2lNIO2XEzprvtgtFi7CelQDwiGxl/LpCIkccxcFgCn4x9NTLgex1BJhluJr532fAO57Z2hPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U1+2ba6KzdG3T9G6C3jED0fgoso3jis4NhOyD+46OQ=;
 b=JdvuQbIQHmoIaIo3OYV/tyPvFETEaqgtO83MWeHB1tv8E65lotcf5WXgGH2Km/6PFuU8XOcZ0dUhzNpQUiM68q7pF9F6urAFPcbdIDdZF0UOta5xEqdr8fRvXYfh9CEscBevxEV5ldV/634TAELdywzGpl8gUI4thfzVTRiEK2A5kArQK2P24zJglDh3jbpDhSUfHvGgj8sMQBkbQzhON2QDBJWfaP5ofVm5e0wnQ93QEFwcYxHQjg48t1r28TmqCbhrDSpahX113isBrGQaC2LXAdv0OQgQUUTJKSSxr7g43j+VWeOC6f3QyDfL/WZdyWMarAUdq/mZmQwPNsk3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN8PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:60::29)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.23; Thu, 7 Nov
 2019 15:56:48 +0000
Received: from DM3NAM03FT025.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::201) by BN8PR12CA0016.outlook.office365.com
 (2603:10b6:408:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.24 via Frontend
 Transport; Thu, 7 Nov 2019 15:56:48 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM3NAM03FT025.mail.protection.outlook.com (10.152.82.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2430.20 via Frontend Transport; Thu, 7 Nov 2019 15:56:48 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 7 Nov 2019
 09:56:45 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 7 Nov 2019 09:56:45 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/14] drm/amd/display: Refactor HDCP encryption status update
Date: Thu, 7 Nov 2019 10:56:24 -0500
Message-ID: <20191107155628.19446-11-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107155628.19446-1-Bhawanpreet.Lakha@amd.com>
References: <20191107155628.19446-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(428003)(189003)(199004)(36756003)(16586007)(50226002)(11346002)(8936002)(476003)(81156014)(6916009)(426003)(316002)(81166006)(126002)(486006)(5660300002)(6666004)(86362001)(8676002)(2906002)(356004)(478600001)(1076003)(336012)(54906003)(47776003)(4326008)(26005)(186003)(15650500001)(305945005)(14444005)(50466002)(70586007)(70206006)(48376002)(53416004)(2351001)(446003)(2616005)(7696005)(51416003)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB4067; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9b37017-fc7c-4841-c029-08d7639b18bc
X-MS-TrafficTypeDiagnostic: BY5PR12MB4067:
X-Microsoft-Antispam-PRVS: <BY5PR12MB406717A5BD865E0FAA445CA6F9780@BY5PR12MB4067.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eaq2FY8PXLnmspzlMCKm6JP/Rj8p235zKts5g4XTBRnBVLIQYZ2BgZDFU1DRy7wfQ50G4B91sx4Ic7HODfpaNcJxvTW+/QxmDFKoRZTV24ByYAJkoPrUvsT+/g+L5rR+9X5oYINLp6fEBoIyQ9o3nChOI7SlcuIDF2zdvY52Ajgxm3L+nACSsuUySD1d+tzDiH69HAaYPAKJyl4w9oc2hhifz18aZKT98K1XEuPiMBqdGTp+KMdpHMpAd40OFET7d15D8K/3bM3iMWcN+8Lag9ct5Hu2gYaR3SFMJqMMt0fF/oJsMmt1vif0Av7kT5lsxkERov9VnGu7Ti+OpxWF+yDJzmYmGNz30r8hovH3NtMzjNjH4dWP0Ehn0VdQ8rE++6yuCkvkn2CutogNjOZLXp6HUuPU4+60BxxZPWBbqw7EQhEkWOwOw9Qy/uNzFMDb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 15:56:48.1447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b37017-fc7c-4841-c029-08d7639b18bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U1+2ba6KzdG3T9G6C3jED0fgoso3jis4NhOyD+46OQ=;
 b=P0kTXgJ4tDu/Fn5uyoxO5+0m3/YmSVRLe6ipEVgs0kdW2VQmOfHZ5xqdN2LhTAcSs+/FQTqlm4rsVM/ZP+RxGk7zgahPmrSCB/PMwxAK1GlB1P6YcqDRmqJPA5RLTn7bw3htFSTT8Uyzr2vjdLaZoYmiTRMQNyH3XEg29lOiiAA=
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Wenjing.Liu@amd.com,
 harry.wentland@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107155624.28ZZ5txOjKpXtz9BQ2zbNZQoidl8cjXSgdw-MGGgiTk@z>

W1doeV0KVGhlIG9sZCB3YXkgd2FzIHRvIHBvbGwgUFNQIGFuZCB1cGRhdGUgdGhlIHByb3BlcnRp
ZXMuIEJ1dCBkdWUgdG8gYQpsaW1pdGF0aW9uIGluIHRoZSBQU1AgaW50ZXJmYWNlIHRoaXMgZG9l
c24ndCB3b3JrIGZvciBNU1QuCgpbSG93XQpBY2NvcmRpbmcgdG8gUFNQIGlmIHNldF9lbmNyeXB0
aW9uIHJldHVybiBzdWNjZXNzLCB0aGUgbGluayBpcyBlbmNyeXB0ZWQKYW5kIHRoZSBvbmx5IHdh
eSBpdCB3aWxsIG5vdCBiZSBpcyBpZiB3ZSBnZXQgYSBsaW5rIGxvc3Mod2hpY2ggd2UgaGFuZGxl
CmFscmVhZHkpLgoKU28gdGhpcyBtZXRob2Qgc2hvdWxkIGJlIGdvb2QgZW5vdWdoIHRvIHJlcG9y
dCBIRENQIHN0YXR1cy4KClNpZ25lZC1vZmYtYnk6IEJoYXdhbnByZWV0IExha2hhIDxCaGF3YW5w
cmVldC5MYWtoYUBhbWQuY29tPgotLS0KIC4uLi9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbV9oZGNwLmMgfCAgMyArLS0KIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMv
aGRjcC9oZGNwLmMgICAgfCAxOCArKysrKysrKysrKysrKy0tLS0KIC4uLi9ncHUvZHJtL2FtZC9k
aXNwbGF5L21vZHVsZXMvaW5jL21vZF9oZGNwLmggfCAgNCArKy0tCiAzIGZpbGVzIGNoYW5nZWQs
IDE3IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGRjcC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGRjcC5jCmluZGV4IDI0NGE4
ZTgwMzM0YS4uZjY4NjRhNTE4OTFhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9oZGNwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1faGRjcC5jCkBAIC04NSw2ICs4NSw3IEBAIHN0
YXRpYyB2b2lkIHByb2Nlc3Nfb3V0cHV0KHN0cnVjdCBoZGNwX3dvcmtxdWV1ZSAqaGRjcF93b3Jr
KQogCQlzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmhkY3Bfd29yay0+d2F0Y2hkb2dfdGltZXJfZHdv
cmssCiAJCQkJICAgICAgbXNlY3NfdG9famlmZmllcyhvdXRwdXQud2F0Y2hkb2dfdGltZXJfZGVs
YXkpKTsKIAorCXNjaGVkdWxlX2RlbGF5ZWRfd29yaygmaGRjcF93b3JrLT5wcm9wZXJ0eV92YWxp
ZGF0ZV9kd29yaywgbXNlY3NfdG9famlmZmllcygwKSk7CiB9CiAKIHZvaWQgaGRjcF91cGRhdGVf
ZGlzcGxheShzdHJ1Y3QgaGRjcF93b3JrcXVldWUgKmhkY3Bfd29yaywKQEAgLTIzNCw4ICsyMzUs
NiBAQCBzdGF0aWMgdm9pZCBldmVudF9wcm9wZXJ0eV92YWxpZGF0ZShzdHJ1Y3Qgd29ya19zdHJ1
Y3QgKndvcmspCiAJCXNjaGVkdWxlX3dvcmsoJmhkY3Bfd29yay0+cHJvcGVydHlfdXBkYXRlX3dv
cmspOwogCX0KIAotCXNjaGVkdWxlX2RlbGF5ZWRfd29yaygmaGRjcF93b3JrLT5wcm9wZXJ0eV92
YWxpZGF0ZV9kd29yaywgbXNlY3NfdG9famlmZmllcyhEUk1fSERDUF9DSEVDS19QRVJJT0RfTVMp
KTsKLQogCW11dGV4X3VubG9jaygmaGRjcF93b3JrLT5tdXRleCk7CiB9CiAKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2hkY3AvaGRjcC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwLmMKaW5kZXggMGYyZjI0Mjcx
MGIzLi5jYmI1ZTljMDYzZWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9tb2R1bGVzL2hkY3AvaGRjcC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9t
b2R1bGVzL2hkY3AvaGRjcC5jCkBAIC00MTcsMTAgKzQxNywyMCBAQCBlbnVtIG1vZF9oZGNwX3N0
YXR1cyBtb2RfaGRjcF9xdWVyeV9kaXNwbGF5KHN0cnVjdCBtb2RfaGRjcCAqaGRjcCwKIAlxdWVy
eS0+dHJhY2UgPSAmaGRjcC0+Y29ubmVjdGlvbi50cmFjZTsKIAlxdWVyeS0+ZW5jcnlwdGlvbl9z
dGF0dXMgPSBNT0RfSERDUF9FTkNSWVBUSU9OX1NUQVRVU19IRENQX09GRjsKIAotCWlmIChpc19o
ZGNwMShoZGNwKSkKLQkJbW9kX2hkY3BfaGRjcDFfZ2V0X2xpbmtfZW5jcnlwdGlvbl9zdGF0dXMo
aGRjcCwgJnF1ZXJ5LT5lbmNyeXB0aW9uX3N0YXR1cyk7Ci0JZWxzZSBpZiAoaXNfaGRjcDIoaGRj
cCkpCi0JCW1vZF9oZGNwX2hkY3AyX2dldF9saW5rX2VuY3J5cHRpb25fc3RhdHVzKGhkY3AsICZx
dWVyeS0+ZW5jcnlwdGlvbl9zdGF0dXMpOworCWlmIChpc19kaXNwbGF5X2VuY3J5cHRpb25fZW5h
YmxlZChkaXNwbGF5KSkgeworCQlpZiAoaXNfaGRjcDEoaGRjcCkpIHsKKwkJCXF1ZXJ5LT5lbmNy
eXB0aW9uX3N0YXR1cyA9IE1PRF9IRENQX0VOQ1JZUFRJT05fU1RBVFVTX0hEQ1AxX09OOworCQl9
IGVsc2UgaWYgKGlzX2hkY3AyKGhkY3ApKSB7CisJCQlpZiAocXVlcnktPmxpbmstPmFkanVzdC5o
ZGNwMi5mb3JjZV90eXBlID09IE1PRF9IRENQX0ZPUkNFX1RZUEVfMCkKKwkJCQlxdWVyeS0+ZW5j
cnlwdGlvbl9zdGF0dXMgPSBNT0RfSERDUF9FTkNSWVBUSU9OX1NUQVRVU19IRENQMl9UWVBFMF9P
TjsKKwkJCWVsc2UgaWYgKHF1ZXJ5LT5saW5rLT5hZGp1c3QuaGRjcDIuZm9yY2VfdHlwZSA9PSBN
T0RfSERDUF9GT1JDRV9UWVBFXzEpCisJCQkJcXVlcnktPmVuY3J5cHRpb25fc3RhdHVzID0gTU9E
X0hEQ1BfRU5DUllQVElPTl9TVEFUVVNfSERDUDJfVFlQRTFfT047CisJCQllbHNlCisJCQkJcXVl
cnktPmVuY3J5cHRpb25fc3RhdHVzID0gTU9EX0hEQ1BfRU5DUllQVElPTl9TVEFUVVNfSERDUDJf
T047CisJCX0KKwl9IGVsc2UgeworCQlxdWVyeS0+ZW5jcnlwdGlvbl9zdGF0dXMgPSBNT0RfSERD
UF9FTkNSWVBUSU9OX1NUQVRVU19IRENQX09GRjsKKwl9CiAKIG91dDoKIAlyZXR1cm4gc3RhdHVz
OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaW5jL21v
ZF9oZGNwLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9pbmMvbW9kX2hk
Y3AuaAppbmRleCBmZjJiYjJiZmJiNTMuLmYyYTBlMWEwNjRkYSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaW5jL21vZF9oZGNwLmgKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaW5jL21vZF9oZGNwLmgKQEAgLTE5MSw5ICsx
OTEsOSBAQCBzdHJ1Y3QgbW9kX2hkY3BfdHJhY2UgewogZW51bSBtb2RfaGRjcF9lbmNyeXB0aW9u
X3N0YXR1cyB7CiAJTU9EX0hEQ1BfRU5DUllQVElPTl9TVEFUVVNfSERDUF9PRkYgPSAwLAogCU1P
RF9IRENQX0VOQ1JZUFRJT05fU1RBVFVTX0hEQ1AxX09OLAotCU1PRF9IRENQX0VOQ1JZUFRJT05f
U1RBVFVTX0hEQ1AyX09OLAogCU1PRF9IRENQX0VOQ1JZUFRJT05fU1RBVFVTX0hEQ1AyX1RZUEUw
X09OLAotCU1PRF9IRENQX0VOQ1JZUFRJT05fU1RBVFVTX0hEQ1AyX1RZUEUxX09OCisJTU9EX0hE
Q1BfRU5DUllQVElPTl9TVEFUVVNfSERDUDJfVFlQRTFfT04sCisJTU9EX0hEQ1BfRU5DUllQVElP
Tl9TVEFUVVNfSERDUDJfT04KIH07CiAKIC8qIHBlciBsaW5rIGV2ZW50cyBkbSBoYXMgdG8gbm90
aWZ5IHRvIGhkY3AgbW9kdWxlICovCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
