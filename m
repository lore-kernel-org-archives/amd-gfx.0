Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADF2C4361B
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8854C22AAD
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8854C22AAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43ADC6E86D;
	Sat, 12 Dec 2020 15:46:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EFDB6E86A
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iM+wrYkC6Pm6h2VeJA8XWVyTyQMmOLz9EZVR8nsMkNdfIDIQejs2pT5x1w3oK1ute9kPw+3qahNe3xMmNSmTSF1jtjJx/aXyyAiDbedcd+k0pncwWBt8RB4Zx1/78fnVr3pPDaNHaTVzULwzcJf3zKOF65ldBZunIa/9J+so4eCiV2iRqpsuYhpK/CF0XirvpMJdmS9RLj9+EWn9CoEU9R9IsVuPFdcG/S7QHV1PvudqMmU1EPPumMTGltnGYBXLWCzsOhJDwEUzjDphg/adbn/2hUAZhZZl8smBisdKbNevnn+N6ahsDljWRPmSkiJV3EUA3h3U+TTgmaHI6/q3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC3WqP8uh0eSSCamwCrh6gxEuHrgEtPajcAK9jLeBno=;
 b=DT9BrrpLriksP3rPuzzYBclTWKhXky+1vh+6W6EB/QAsJQkGqL1NZLK/rrzIUh4aDdO417jk7ynmDKus4pW/XBHL2JXk08Uk7xK+xHuHuykGPy2Y3Ny6c3YReqysxHT0k5dMyHw90k7IcqYQxGs8bt9nE07qDc34xinV/IrGmJf+wiZfLU5n7uJ/rQ/nTHbEylrjLG+1jteFUkm/iDoWCdYT1KqkUtkxOruyuOVOTmdlmSfhQF4RrV4WSKn98UT5wPgFJeQ8bsGaVnFCN46CEsCRiIUswO9OWt83nQ0Bl6A58lzGufCRUk9rmrvaNH1m6RK7F8xwzvzFkghlu51c6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC3WqP8uh0eSSCamwCrh6gxEuHrgEtPajcAK9jLeBno=;
 b=bAoo8uVcJWOCHh8mr96xI8/3nz2v+sxybd9n1peOwa5WapZYD+92Fp8Veetazlh9mrBtXTtr1OnLJmYcLuuQiShp80Kf6TQ5S7CH8ej7fSmUtouk31ppuZC3WewH1V7ziWwGbKhm2ne6x10uzkXbw/p8DBV20AcyWaANpU+oD10=
Received: from BN0PR04CA0115.namprd04.prod.outlook.com (2603:10b6:408:ec::30)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Sat, 12 Dec
 2020 15:46:39 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::62) by BN0PR04CA0115.outlook.office365.com
 (2603:10b6:408:ec::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:46:38 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:46:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:38 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:37 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:46:35 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 10/27] drm/amdgpu: add helper to init ih ring regs for navi10
Date: Sat, 12 Dec 2020 23:45:43 +0800
Message-ID: <20201212154600.21618-10-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd7953b3-523d-47f1-897e-08d89eb51cef
X-MS-TrafficTypeDiagnostic: DM6PR12MB4172:
X-Microsoft-Antispam-PRVS: <DM6PR12MB417257473D9B411F6CBB648FFCC90@DM6PR12MB4172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0R+Gjb/9isLBL9sCb31OKgas3v0sZiosAwujheHKvYnUCfDq7CuuoRqGII3UawbBw1uDZJ34ep6liSls324x7h+gxpKf5dBSXdQxJoL6CW8y4AdRqiN6kn/N+YfiyetgrjZ8uxIDFitY/DiK0j8F4neAPF9S2wsvQ27bo+rnVvtU5GW94Gv6chZqOVG0aiv8WYtNqiF8VJi+t6WTs+05zIHzdSNiVi9UlFHZtpn0Q7zQMwANlBPOf6ub0bGJOmMZ5uhZH9Nl6OKxqLruO7hIQKHWGHX5e1kpuXJNLw8M3I4ehjLDnTuGF9IaZqx/8IOpelEuL/aCsE6bZfsRBFfkeCFY8bnM087SYpQuCGL2RCEYleyY3fO8Wi1xoop67WM1AL0mS6N4LZmJgWZ48a1hFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(46966005)(82310400003)(86362001)(5660300002)(70206006)(8936002)(508600001)(110136005)(83380400001)(2616005)(336012)(2906002)(66574015)(6636002)(426003)(36756003)(70586007)(8676002)(186003)(47076004)(1076003)(356005)(6666004)(7696005)(81166007)(4326008)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:46:38.4214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7953b3-523d-47f1-897e-08d89eb51cef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172
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

bmF2aTEwX2loX2luaXRfcmVnaXN0ZXJfb2Zmc2V0IHdpbGwgYmUgdXNlZCB0byBpbml0CnJlZ2lz
dGVyIG9mZnNldCBmb3IgYWxsIHRoZSBhdmFpbGFibGUgaWggcmluZ3MKClNpZ25lZC1vZmYtYnk6
IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KQWNrZWQtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQWNrZWQtYnk6IEZlbGl4IEt1ZWhs
aW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogRGVubmlzIExpIDxEZW5u
aXMuTGlAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMgfCA0NyArKysrKysr
KysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9paC5jCmluZGV4IDdiYTIyOWU0Mzc5OS4uYjVh
MDMyN2VkYWEzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBf
aWguYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYwpAQCAtMzks
NiArMzksNTMgQEAKIAogc3RhdGljIHZvaWQgbmF2aTEwX2loX3NldF9pbnRlcnJ1cHRfZnVuY3Mo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogCisvKioKKyAqIG5hdmkxMF9paF9pbml0X3Jl
Z2lzdGVyX29mZnNldCAtIEluaXRpYWxpemUgcmVnaXN0ZXIgb2Zmc2V0IGZvciBpaCByaW5ncwor
ICoKKyAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKKyAqCisgKiBJbml0aWFsaXplIHJl
Z2lzdGVyIG9mZnNldCBpaCByaW5ncyAoTkFWSTEwKS4KKyAqLworc3RhdGljIHZvaWQgbmF2aTEw
X2loX2luaXRfcmVnaXN0ZXJfb2Zmc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQorewor
CXN0cnVjdCBhbWRncHVfaWhfcmVncyAqaWhfcmVnczsKKworCWlmIChhZGV2LT5pcnEuaWgucmlu
Z19zaXplKSB7CisJCWloX3JlZ3MgPSAmYWRldi0+aXJxLmloLmloX3JlZ3M7CisJCWloX3JlZ3Mt
PmloX3JiX2Jhc2UgPSBTT0MxNV9SRUdfT0ZGU0VUKE9TU1NZUywgMCwgbW1JSF9SQl9CQVNFKTsK
KwkJaWhfcmVncy0+aWhfcmJfYmFzZV9oaSA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBt
bUlIX1JCX0JBU0VfSEkpOworCQlpaF9yZWdzLT5paF9yYl9jbnRsID0gU09DMTVfUkVHX09GRlNF
VChPU1NTWVMsIDAsIG1tSUhfUkJfQ05UTCk7CisJCWloX3JlZ3MtPmloX3JiX3dwdHIgPSBTT0Mx
NV9SRUdfT0ZGU0VUKE9TU1NZUywgMCwgbW1JSF9SQl9XUFRSKTsKKwkJaWhfcmVncy0+aWhfcmJf
cnB0ciA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBtbUlIX1JCX1JQVFIpOworCQlpaF9y
ZWdzLT5paF9kb29yYmVsbF9ycHRyID0gU09DMTVfUkVHX09GRlNFVChPU1NTWVMsIDAsIG1tSUhf
RE9PUkJFTExfUlBUUik7CisJCWloX3JlZ3MtPmloX3JiX3dwdHJfYWRkcl9sbyA9IFNPQzE1X1JF
R19PRkZTRVQoT1NTU1lTLCAwLCBtbUlIX1JCX1dQVFJfQUREUl9MTyk7CisJCWloX3JlZ3MtPmlo
X3JiX3dwdHJfYWRkcl9oaSA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBtbUlIX1JCX1dQ
VFJfQUREUl9ISSk7CisJCWloX3JlZ3MtPnBzcF9yZWdfaWQgPSBQU1BfUkVHX0lIX1JCX0NOVEw7
CisJfQorCisJaWYgKGFkZXYtPmlycS5paDEucmluZ19zaXplKSB7CisJCWloX3JlZ3MgPSAmYWRl
di0+aXJxLmloMS5paF9yZWdzOworCQlpaF9yZWdzLT5paF9yYl9iYXNlID0gU09DMTVfUkVHX09G
RlNFVChPU1NTWVMsIDAsIG1tSUhfUkJfQkFTRV9SSU5HMSk7CisJCWloX3JlZ3MtPmloX3JiX2Jh
c2VfaGkgPSBTT0MxNV9SRUdfT0ZGU0VUKE9TU1NZUywgMCwgbW1JSF9SQl9CQVNFX0hJX1JJTkcx
KTsKKwkJaWhfcmVncy0+aWhfcmJfY250bCA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBt
bUlIX1JCX0NOVExfUklORzEpOworCQlpaF9yZWdzLT5paF9yYl93cHRyID0gU09DMTVfUkVHX09G
RlNFVChPU1NTWVMsIDAsIG1tSUhfUkJfV1BUUl9SSU5HMSk7CisJCWloX3JlZ3MtPmloX3JiX3Jw
dHIgPSBTT0MxNV9SRUdfT0ZGU0VUKE9TU1NZUywgMCwgbW1JSF9SQl9SUFRSX1JJTkcxKTsKKwkJ
aWhfcmVncy0+aWhfZG9vcmJlbGxfcnB0ciA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBt
bUlIX0RPT1JCRUxMX1JQVFJfUklORzEpOworCQlpaF9yZWdzLT5wc3BfcmVnX2lkID0gUFNQX1JF
R19JSF9SQl9DTlRMX1JJTkcxOworCX0KKworCWlmIChhZGV2LT5pcnEuaWgyLnJpbmdfc2l6ZSkg
eworCQlpaF9yZWdzID0gJmFkZXYtPmlycS5paDIuaWhfcmVnczsKKwkJaWhfcmVncy0+aWhfcmJf
YmFzZSA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBtbUlIX1JCX0JBU0VfUklORzIpOwor
CQlpaF9yZWdzLT5paF9yYl9iYXNlX2hpID0gU09DMTVfUkVHX09GRlNFVChPU1NTWVMsIDAsIG1t
SUhfUkJfQkFTRV9ISV9SSU5HMik7CisJCWloX3JlZ3MtPmloX3JiX2NudGwgPSBTT0MxNV9SRUdf
T0ZGU0VUKE9TU1NZUywgMCwgbW1JSF9SQl9DTlRMX1JJTkcyKTsKKwkJaWhfcmVncy0+aWhfcmJf
d3B0ciA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBtbUlIX1JCX1dQVFJfUklORzIpOwor
CQlpaF9yZWdzLT5paF9yYl9ycHRyID0gU09DMTVfUkVHX09GRlNFVChPU1NTWVMsIDAsIG1tSUhf
UkJfUlBUUl9SSU5HMik7CisJCWloX3JlZ3MtPmloX2Rvb3JiZWxsX3JwdHIgPSBTT0MxNV9SRUdf
T0ZGU0VUKE9TU1NZUywgMCwgbW1JSF9ET09SQkVMTF9SUFRSX1JJTkcyKTsKKwkJaWhfcmVncy0+
cHNwX3JlZ19pZCA9IFBTUF9SRUdfSUhfUkJfQ05UTF9SSU5HMjsKKwl9Cit9CisKIC8qKgogICog
Zm9yY2VfdXBkYXRlX3dwdHJfZm9yX3NlbGZfaW50IC0gRm9yY2UgdXBkYXRlIHRoZSB3cHRyIGZv
ciBzZWxmIGludGVycnVwdAogICoKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
