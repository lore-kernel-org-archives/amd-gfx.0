Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D55C4361B
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC27122AAD
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC27122AAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77AF16E869;
	Sat, 12 Dec 2020 15:46:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF5B6E869
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:46:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWoQjvtLjo4OUBil3P9qGLmcYTaXfS/wYQRP7xlK7Z1G0DuO3Qq2fVVxohboepI+Z1N0zu91k0Ty76YScRZrfAR4L8LrwKJDeDJr+uNvSMOaB6uatO+6QOw9ueU276eY5Wh915Ic2UrGaV4sQn00rXE3Z+52FMOI2ECgJ+mS5k51vs/pl5wDRVrIth1a1DTp1N7FwrNEBbOBLJWeiuTkfW3pYNwm93Fel1sWBYV+OQX45fA9HjQem+VyMvVemwi9puVgN0PO6E0UsOlWtDNeS8vg1AzPgKpLuCA9dAN8f6x8372cU0Vg5tvMkNAc4SvKg8egq2H1qE/mv7BFtE6dag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcpbNaJx3w8H/GYQ0lsjNZM+JXLcXGkKIzewG5Shi3E=;
 b=ls486s/Xrj7T7v8ysPD+slXvlLJiti7KvUrYP+PpnV3Xm9/Af7cw3GAALAEV/Qzf0F0nJRJZ+Eb+b5+ddFhR1GCWGzhF6OWuHBeHC1ABTirFnoljGDiiIwP/jus5lkMi35WatRExGxdnXt3vLHYoS8uNax4Yx5kEA2B1GsVuvuWDICQ1DkJDx1qCIEIeKXJcGMtfsxTIa6d58clanETeCBtVMZ9ndtNoA55tVddK3QsqBE3aveLWf5kvOT/ppdJMCmzo6AGloQoq1yzOUvxI0rXiq9oLrIPZpQl4b7ZFEzmHZShHL/u/HBQntHOeMB4Vy54odFWldfqF/S1lT9eJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcpbNaJx3w8H/GYQ0lsjNZM+JXLcXGkKIzewG5Shi3E=;
 b=mCVM4vgo4k/IDY1AXxT8bFlCWyFR6fR7XsPCRcbehaUwvzuHqNwFT+FzGT0hL1Bd/AA5tBu6JWL2xV2VBr+X1UV43Wbv+o/gviXKTHQWpixerdXHQhUtoWRCAL73JuinOfU7dwN4cvYwfAz+9BLSHx6FFY/M9E8uJPuzi9mldRU=
Received: from BN6PR04CA0100.namprd04.prod.outlook.com (2603:10b6:404:c9::26)
 by MN2PR12MB4015.namprd12.prod.outlook.com (2603:10b6:208:16e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Sat, 12 Dec
 2020 15:46:46 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:c9:cafe::f2) by BN6PR04CA0100.outlook.office365.com
 (2603:10b6:404:c9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:46:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:46:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:44 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:43 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:46:42 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 12/27] drm/amdgpu: add helper to toggle ih ring interrupts for
 navi10
Date: Sat, 12 Dec 2020 23:45:45 +0800
Message-ID: <20201212154600.21618-12-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ec7fdd4-8461-4148-cdef-08d89eb520aa
X-MS-TrafficTypeDiagnostic: MN2PR12MB4015:
X-Microsoft-Antispam-PRVS: <MN2PR12MB40152CD4EE878CC182C2B4A3FCC90@MN2PR12MB4015.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ezdNclE/BPYfk2tubVT4rNxvFIb4tZkYSjpCoycogqy3Mz8tTObJINsEdDW6DJ4dbGhVYvuVXZnnB+sl7WJ2VbKI9uIDRt7aFdy6MujGEL2RFBb6/3VP2gJlpmpvgBDn7EusR+NpMTAbtLFo6lP3vHSroGX4de2ZDwIUU+0OmtJkUzJTuzpGIfrqFLEeQWRkJ0WzWPHd6C+S7gQczNhpNRc1oR9B1I0JjONOpwIXjCEl+/aFv7gxeobxg6y4T6AskPtFWbXK5akvNISy42cMEucfSivd5OyhNkFP9WVLTyp43C6ztDIeEleQfZWUUCDq6Zj88QxdX+aZm11H/xlzI+zWDSsknvKTRDUJCRniqRowly1IrA67MA3jJr29VPtlxxS/SMkErEngZQbgqrS1XBu57B9A3OKQOmdXY8g/eg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(46966005)(336012)(81166007)(7696005)(5660300002)(70586007)(8936002)(66574015)(8676002)(26005)(110136005)(1076003)(2906002)(6636002)(186003)(70206006)(86362001)(82310400003)(36756003)(4326008)(83380400001)(356005)(426003)(47076004)(508600001)(2616005)(357404004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:46:44.6809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec7fdd4-8461-4148-cdef-08d89eb520aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4015
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

bmF2aTEwX2loX3RvZ2dsZV9yaW5nX2ludGVycnVwdHMgd2lsbCBiZSB1c2VkIHRvCmVuYWJsZS9k
aXNhYmxlIGFuIGloIHJpbmcgaW50ZXJydXB0cyBmb3IgbmF2aTF4CmFuZCBvbndhcmRzCgpTaWdu
ZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+CkFja2VkLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkFja2VkLWJ5OiBG
ZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IERlbm5p
cyBMaSA8RGVubmlzLkxpQGFtZC5jb20+ClJldmlld2VkLWJ5OiBGZWlmZWkgWHUgPEZlaWZlaS5Y
dUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25hdmkxMF9paC5jIHwg
NDUgKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2lo
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYwppbmRleCBjMmEwMDZk
NTc4MTguLjc4NmYxNWY4MjllOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvbmF2aTEwX2loLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2lo
LmMKQEAgLTI1OCw2ICsyNTgsNTEgQEAgc3RhdGljIHZvaWQgbmF2aTEwX2loX2Rpc2FibGVfaW50
ZXJydXB0cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAogfQogCisvKioKKyAqIG5hdmkx
MF9paF90b2dnbGVfcmluZ19pbnRlcnJ1cHRzIC0gdG9nZ2xlIHRoZSBpbnRlcnJ1cHQgcmluZyBi
dWZmZXIKKyAqCisgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCisgKiBAaWg6IGFtZGdw
dV9paF9yaW5nIHBvaW50ZXQKKyAqIEBlbmFibGU6IHRydWUgLSBlbmFibGUgdGhlIGludGVycnVw
dHMsIGZhbHNlIC0gZGlzYWJsZSB0aGUgaW50ZXJydXB0cworICoKKyAqIFRvZ2dsZSB0aGUgaW50
ZXJydXB0IHJpbmcgYnVmZmVyIChOQVZJMTApCisgKi8KK3N0YXRpYyBpbnQgbmF2aTEwX2loX3Rv
Z2dsZV9yaW5nX2ludGVycnVwdHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCisJCQkJCSAg
ICBzdHJ1Y3QgYW1kZ3B1X2loX3JpbmcgKmloLAorCQkJCQkgICAgYm9vbCBlbmFibGUpCit7CisJ
c3RydWN0IGFtZGdwdV9paF9yZWdzICppaF9yZWdzOworCXVpbnQzMl90IHRtcDsKKworCWloX3Jl
Z3MgPSAmaWgtPmloX3JlZ3M7CisKKwl0bXAgPSBSUkVHMzIoaWhfcmVncy0+aWhfcmJfY250bCk7
CisJdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIElIX1JCX0NOVEwsIFJCX0VOQUJMRSwgKGVuYWJs
ZSA/IDEgOiAwKSk7CisJLyogZW5hYmxlX2ludHIgZmllbGQgaXMgb25seSB2YWxpZCBpbiByaW5n
MCAqLworCWlmIChpaCA9PSAmYWRldi0+aXJxLmloKQorCQl0bXAgPSBSRUdfU0VUX0ZJRUxEKHRt
cCwgSUhfUkJfQ05UTCwgRU5BQkxFX0lOVFIsIChlbmFibGUgPyAxIDogMCkpOworCWlmIChhbWRn
cHVfc3Jpb3ZfdmYoYWRldikgJiYgYWRldi0+YXNpY190eXBlIDwgQ0hJUF9OQVZJMTApIHsKKwkJ
aWYgKHBzcF9yZWdfcHJvZ3JhbSgmYWRldi0+cHNwLCBpaF9yZWdzLT5wc3BfcmVnX2lkLCB0bXAp
KSB7CisJCQlkZXZfZXJyKGFkZXYtPmRldiwgIlBTUCBwcm9ncmFtIElIX1JCX0NOVEwgZmFpbGVk
IVxuIik7CisJCQlyZXR1cm4gLUVUSU1FRE9VVDsKKwkJfQorCX0gZWxzZSB7CisJCVdSRUczMihp
aF9yZWdzLT5paF9yYl9jbnRsLCB0bXApOworCX0KKworCWlmIChlbmFibGUpIHsKKwkJaWgtPmVu
YWJsZWQgPSB0cnVlOworCX0gZWxzZSB7CisJCS8qIHNldCBycHRyLCB3cHRyIHRvIDAgKi8KKwkJ
V1JFRzMyKGloX3JlZ3MtPmloX3JiX3JwdHIsIDApOworCQlXUkVHMzIoaWhfcmVncy0+aWhfcmJf
d3B0ciwgMCk7CisJCWloLT5lbmFibGVkID0gZmFsc2U7CisJCWloLT5ycHRyID0gMDsKKwl9CisK
KwlyZXR1cm4gMDsKK30KKwogc3RhdGljIHVpbnQzMl90IG5hdmkxMF9paF9yYl9jbnRsKHN0cnVj
dCBhbWRncHVfaWhfcmluZyAqaWgsIHVpbnQzMl90IGloX3JiX2NudGwpCiB7CiAJaW50IHJiX2J1
ZnN6ID0gb3JkZXJfYmFzZV8yKGloLT5yaW5nX3NpemUgLyA0KTsKLS0gCjIuMTcuMQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
