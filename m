Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98217C4361B
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5930222AAD
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5930222AAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 128726E861;
	Sat, 12 Dec 2020 15:46:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26CB16E861
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:46:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBpVp0zZSWI2MmwMYht+uKodteXPeXeX/KeqNI3fExjoTQQa+ZOb+fO4Df5i7uM1RU6td728sf8YezQojTqMaz8rHOrA03+WRK/Z97CvSuq5+iurXgag2UXheqSJkeFIr/PI6OOcifXGJxHsgyhZC0xYe94oVISj2y+HlbirtPixLd2GcTz5uN/iCJR4L4SKBvzskf+G5rJiaG+GbMnPv6CGaVo3VbyFPxDHvYYREDaVYASny+TrGAaB3hv53oz5No+CEEAmAtht8KGsNQzd9a6vud8QyZwWokTQ42tuwgIMhE/LgqCxR8osjv26sp7+fojR7hazl4kNLc+yVSJshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XEDFxxZsxh9ARJifcR5iwsvs7FdRdYWd9WQA8i0pKg=;
 b=MDFBsfv5VSo/QmYBpIhX9zf2M0bUNm0rUQNUmN5s+/OU9eVZWPTc4yXoH2swv5smAkgpYcjzSwLNvrFpImwkPwIKle9SmU+ze+GmfM7odgLJc3VRP5nDm7OB0RlwXhjoBreG2s2NG9ckudB3nn9ABx7vRmu1oqVy49ZjjpROPmWyP8yKkDYhiTBcVxOtCUrO0SYZOR9goJnWivB5e926f7X80YygPxaFfpiRGwhUzqdjlGobOXjprNQFIljFodpagCirlvCB7MGFAmmFjaJEgCYrPZlelx5fllbV22Mlg3Sxso9s5LVa3NNUzq0BxUoeaHPFASA0SEu3CvVjsV9qrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XEDFxxZsxh9ARJifcR5iwsvs7FdRdYWd9WQA8i0pKg=;
 b=w2PH4AnaA4Larja8cgh8ilEu15CcXXlcJRjOUufyazF78BJZzF5OgxmZk0NDnSWtsp/WNeIpimnTT/o+D7iDLBWcyreUkfIo/Lmren8wkhHAKU/9RNJcENuE/Eu6bQKWf3BDTCVf4zv6aet+ciwGOw26+w5yG///fRT+s6ff3WM=
Received: from DM6PR13CA0026.namprd13.prod.outlook.com (2603:10b6:5:bc::39) by
 DM5PR1201MB0172.namprd12.prod.outlook.com (2603:10b6:4:51::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.13; Sat, 12 Dec 2020 15:46:13 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::89) by DM6PR13CA0026.outlook.office365.com
 (2603:10b6:5:bc::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.9 via Frontend
 Transport; Sat, 12 Dec 2020 15:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:46:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:11 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:11 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:46:09 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 02/27] drm/amdgpu: add helper to init ih ring regs for vega10
Date: Sat, 12 Dec 2020 23:45:35 +0800
Message-ID: <20201212154600.21618-2-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1634c327-5f33-4946-6b26-08d89eb50d8e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0172:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0172A952F9A3C03A48688EA0FCC90@DM5PR1201MB0172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: myoSbGC3x4jFEXTgsQkpHhZcDSZLdE4pXXRml8oTZC2cB/idrNOrH02+VnSgCJbBjnt2IMcSMaTayEg11f2id20J0jiYny1rZE2A07qbtUOo2mY+Ax77SuJDxiTenoC88v0I8tzq/M64cIJ5+L+to/NJ9/emzfqBFloEJrPzsVKwJ9CxfQ/oNPiFLJ88bdJiJjbhdRTJxfTpYvUPQmz/za1HZRYhvg6uFy4BC90127zMN3MEgKxM9UWwi3vfkXGZYP/KKnKIdQz7Uk8In4y5vAA8xafBX3R+tQipC9kFzgx7m9eH3WxfThHgR3/MGjQrP1yv7k3NxbXyw38ujOSW3vLgLgY2ZhE55EMJVjWTWdEog8tu/p/w2lzYhZU47BpK9ECZBLazwAGf+LT6hpEHWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(46966005)(26005)(8676002)(7696005)(336012)(81166007)(1076003)(356005)(8936002)(47076004)(36756003)(82310400003)(6666004)(186003)(508600001)(86362001)(70586007)(70206006)(6636002)(110136005)(5660300002)(2616005)(426003)(2906002)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:46:12.5682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1634c327-5f33-4946-6b26-08d89eb50d8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0172
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

dmVnYTEwX2loX2luaXRfcmVnaXN0ZXJfb2Zmc2V0IHdpbGwgYmUgdXNlZCB0byBpbml0CnJlZ2lz
dGVyIG9mZnNldCBmb3IgYWxsIHRoZSBhdmFpbGFibGUgaWggcmluZ3MKClNpZ25lZC1vZmYtYnk6
IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQWNrZWQtYnk6IEZlbGl4IEt1
ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogRGVubmlzIExpIDxE
ZW5uaXMuTGlAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMgfCA0NyArKysr
KysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jCmluZGV4IGU1YWUzMWViNzQ0ZS4u
YTExNTUzYTIzNTM4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdh
MTBfaWguYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYwpAQCAt
MzcsNiArMzcsNTMgQEAKIAogc3RhdGljIHZvaWQgdmVnYTEwX2loX3NldF9pbnRlcnJ1cHRfZnVu
Y3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogCisvKioKKyAqIHZlZ2ExMF9paF9pbml0
X3JlZ2lzdGVyX29mZnNldCAtIEluaXRpYWxpemUgcmVnaXN0ZXIgb2Zmc2V0IGZvciBpaCByaW5n
cworICoKKyAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKKyAqCisgKiBJbml0aWFsaXpl
IHJlZ2lzdGVyIG9mZnNldCBpaCByaW5ncyAoVkVHQTEwKS4KKyAqLworc3RhdGljIHZvaWQgdmVn
YTEwX2loX2luaXRfcmVnaXN0ZXJfb2Zmc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQor
eworCXN0cnVjdCBhbWRncHVfaWhfcmVncyAqaWhfcmVnczsKKworCWlmIChhZGV2LT5pcnEuaWgu
cmluZ19zaXplKSB7CisJCWloX3JlZ3MgPSAmYWRldi0+aXJxLmloLmloX3JlZ3M7CisJCWloX3Jl
Z3MtPmloX3JiX2Jhc2UgPSBTT0MxNV9SRUdfT0ZGU0VUKE9TU1NZUywgMCwgbW1JSF9SQl9CQVNF
KTsKKwkJaWhfcmVncy0+aWhfcmJfYmFzZV9oaSA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAw
LCBtbUlIX1JCX0JBU0VfSEkpOworCQlpaF9yZWdzLT5paF9yYl9jbnRsID0gU09DMTVfUkVHX09G
RlNFVChPU1NTWVMsIDAsIG1tSUhfUkJfQ05UTCk7CisJCWloX3JlZ3MtPmloX3JiX3dwdHIgPSBT
T0MxNV9SRUdfT0ZGU0VUKE9TU1NZUywgMCwgbW1JSF9SQl9XUFRSKTsKKwkJaWhfcmVncy0+aWhf
cmJfcnB0ciA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBtbUlIX1JCX1JQVFIpOworCQlp
aF9yZWdzLT5paF9kb29yYmVsbF9ycHRyID0gU09DMTVfUkVHX09GRlNFVChPU1NTWVMsIDAsIG1t
SUhfRE9PUkJFTExfUlBUUik7CisJCWloX3JlZ3MtPmloX3JiX3dwdHJfYWRkcl9sbyA9IFNPQzE1
X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBtbUlIX1JCX1dQVFJfQUREUl9MTyk7CisJCWloX3JlZ3Mt
PmloX3JiX3dwdHJfYWRkcl9oaSA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBtbUlIX1JC
X1dQVFJfQUREUl9ISSk7CisJCWloX3JlZ3MtPnBzcF9yZWdfaWQgPSBQU1BfUkVHX0lIX1JCX0NO
VEw7CisJfQorCisJaWYgKGFkZXYtPmlycS5paDEucmluZ19zaXplKSB7CisJCWloX3JlZ3MgPSAm
YWRldi0+aXJxLmloMS5paF9yZWdzOworCQlpaF9yZWdzLT5paF9yYl9iYXNlID0gU09DMTVfUkVH
X09GRlNFVChPU1NTWVMsIDAsIG1tSUhfUkJfQkFTRV9SSU5HMSk7CisJCWloX3JlZ3MtPmloX3Ji
X2Jhc2VfaGkgPSBTT0MxNV9SRUdfT0ZGU0VUKE9TU1NZUywgMCwgbW1JSF9SQl9CQVNFX0hJX1JJ
TkcxKTsKKwkJaWhfcmVncy0+aWhfcmJfY250bCA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAw
LCBtbUlIX1JCX0NOVExfUklORzEpOworCQlpaF9yZWdzLT5paF9yYl93cHRyID0gU09DMTVfUkVH
X09GRlNFVChPU1NTWVMsIDAsIG1tSUhfUkJfV1BUUl9SSU5HMSk7CisJCWloX3JlZ3MtPmloX3Ji
X3JwdHIgPSBTT0MxNV9SRUdfT0ZGU0VUKE9TU1NZUywgMCwgbW1JSF9SQl9SUFRSX1JJTkcxKTsK
KwkJaWhfcmVncy0+aWhfZG9vcmJlbGxfcnB0ciA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAw
LCBtbUlIX0RPT1JCRUxMX1JQVFJfUklORzEpOworCQlpaF9yZWdzLT5wc3BfcmVnX2lkID0gUFNQ
X1JFR19JSF9SQl9DTlRMX1JJTkcxOworCX0KKworCWlmIChhZGV2LT5pcnEuaWgyLnJpbmdfc2l6
ZSkgeworCQlpaF9yZWdzID0gJmFkZXYtPmlycS5paDIuaWhfcmVnczsKKwkJaWhfcmVncy0+aWhf
cmJfYmFzZSA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBtbUlIX1JCX0JBU0VfUklORzIp
OworCQlpaF9yZWdzLT5paF9yYl9iYXNlX2hpID0gU09DMTVfUkVHX09GRlNFVChPU1NTWVMsIDAs
IG1tSUhfUkJfQkFTRV9ISV9SSU5HMik7CisJCWloX3JlZ3MtPmloX3JiX2NudGwgPSBTT0MxNV9S
RUdfT0ZGU0VUKE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMX1JJTkcyKTsKKwkJaWhfcmVncy0+aWhf
cmJfd3B0ciA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBtbUlIX1JCX1dQVFJfUklORzIp
OworCQlpaF9yZWdzLT5paF9yYl9ycHRyID0gU09DMTVfUkVHX09GRlNFVChPU1NTWVMsIDAsIG1t
SUhfUkJfUlBUUl9SSU5HMik7CisJCWloX3JlZ3MtPmloX2Rvb3JiZWxsX3JwdHIgPSBTT0MxNV9S
RUdfT0ZGU0VUKE9TU1NZUywgMCwgbW1JSF9ET09SQkVMTF9SUFRSX1JJTkcyKTsKKwkJaWhfcmVn
cy0+cHNwX3JlZ19pZCA9IFBTUF9SRUdfSUhfUkJfQ05UTF9SSU5HMjsKKwl9Cit9CisKIC8qKgog
ICogdmVnYTEwX2loX2VuYWJsZV9pbnRlcnJ1cHRzIC0gRW5hYmxlIHRoZSBpbnRlcnJ1cHQgcmlu
ZyBidWZmZXIKICAqCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
