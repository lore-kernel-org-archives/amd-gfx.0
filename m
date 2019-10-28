Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940FACA9EC1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F69620659
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F69620659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 395A86E8A1;
	Mon, 28 Oct 2019 14:08:55 +0000 (UTC)
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820089.outbound.protection.outlook.com [40.107.82.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1616E6E8A1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:08:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJ7GibfQqNVoi0DnmzlhIiaTNMJNu2gsj4YbVpMHs8RnBJT+Mjalh8db97y57RVCVSRqUfPpAiI2sESm4r4sokbmEd7ceK+ufN59Npq4g50mYH6olnph+8WM/xUPl56yKsaGQs8RX5NPkvAeyT8G+mS3kV+ZxsePj0lMyPnYbQFBWk6tq2zCtiIMyXk4aTOnp8TOeRiC40Sv5cBsxzmiw88OAjKcu10mvCWSi8jjtbg7yxNDFBxOrbwwcUjWvDzcGSstSqFz7/1DK8HJyWB0kDgvR/UdNg5ANAwkGyDMejHiXCQuQV670/O0lLqs3MkgWy3brHMIQnlU3jNxeDOf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB5Q3eaOCMvGLXeuQ2UHuTxzfQEPAKV6wZ0DgD3Bhzg=;
 b=MFxYYd4i1rbtI9FrsSEAq/skgjPp6W0QLsBe2LOhzsxmdrh3FsJ9Guq+X+CHxSlknzUQiKxEUNL7ZZIBEBccNuMOsbViIVXAnOuNGCA9VV5dvGtRIuFhLI1DcBskRsowBTrvrF9i7igxsmU/UY3gEFeNhblmMUGSVCS/REXSLfqCQ5QN8aCYLvdoeGcfcsF7zmRmBgtkpXaOCIabsErjT+jY7GDKjYAwv9yVFebOGhSkuGwPjrJLBcg2XXr1JWRzVdz1vOBaIdKEFaPX+dqcALT6/uBcB000tqw/xPDzMepaZBMg2dbf4Z0XuTInwzueixWJF5U+ATClZiodyVga/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MWHPR12CA0047.namprd12.prod.outlook.com (2603:10b6:301:2::33)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.25; Mon, 28 Oct
 2019 14:08:52 +0000
Received: from CO1NAM03FT047.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::202) by MWHPR12CA0047.outlook.office365.com
 (2603:10b6:301:2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.22 via Frontend
 Transport; Mon, 28 Oct 2019 14:08:52 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM03FT047.mail.protection.outlook.com (10.152.81.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Mon, 28 Oct 2019 14:08:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 09:08:49 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 09:08:49 -0500
Received: from kazvm.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 28 Oct 2019 09:08:49 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/11] drm/amdgpu: Add PSP loading support for DMCUB ucode
Date: Mon, 28 Oct 2019 10:08:28 -0400
Message-ID: <20191028140837.7908-3-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028140837.7908-1-nicholas.kazlauskas@amd.com>
References: <20191028140837.7908-1-nicholas.kazlauskas@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(428003)(189003)(199004)(48376002)(126002)(476003)(426003)(44832011)(2906002)(50466002)(478600001)(50226002)(336012)(486006)(2870700001)(47776003)(5660300002)(356004)(6666004)(2616005)(446003)(36756003)(11346002)(4326008)(1076003)(4744005)(51416003)(7696005)(26005)(316002)(2351001)(76176011)(53416004)(186003)(305945005)(6916009)(70206006)(70586007)(8676002)(81166006)(81156014)(86362001)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4315; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39400ba1-b556-4bab-c671-08d75bb05ccb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4315:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4315859BDBF0B4DC65CB46B3EC660@DM6PR12MB4315.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0204F0BDE2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jPpXY8sGDPLEQN2RzjeDw0msjcGvZ8vzmXnv7yrncTkMJAtNT7R5+HCgQqxzscYazIZzVtJlnYm8ow8XDe9Ec3gBArNpSGGgKHUSunRos+d0SbKJ+0CdOy6ylc3CFwytuvU62X5kz9/1vZHanEZ4hP18jN1W53n16vw+bp0I6vftipxk6aEdd3/GIcLreQL1mvIogMfGZrm7oNx2qO1ypK35tgXjIrYXWfa914b+qKBYoUbcRGKRnz6THJXquISoD1Ha2K2UT8tlFieCiwUEgSqcC0jgjC0wIoRqgn4HQhtowJFIMp/ywvaKwa7aKPXFI8whoyhQrC6/cioRFC3/9ilriXo4+6veGgXzFcqqAZXy+9J4U4u+73zi6bXKB9KHld5ap00jmufRf7vYbgs+Ko/gt+dQ0H0ednHPhLAwVyABp623yEdHDk/qJRtDibaa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2019 14:08:52.3813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39400ba1-b556-4bab-c671-08d75bb05ccb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB5Q3eaOCMvGLXeuQ2UHuTxzfQEPAKV6wZ0DgD3Bhzg=;
 b=zSGseojzQC1914PJjODO+sgkBis9OCOBe0wx6ReAQ0AwDuaZC89HxiWbLlLSG8CkW0AqKQMJsiTAAyDTzrHo8+/BoeuI7KgJY3k6+zAEoRDtWSCgAq2+NjSq/aSF010/qu7a9BPe3UBX64dLktgOaOwxzIE3zJhtAoK2DZGuWVM=
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
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028140828.I6oEjdwfmGTHo5f2ab-1CLmqy_otpGuA164bOwpsIhI@z>

RE1DVUIgdWNvZGUgcmVxdWlyZXMgc2VjdXJlIGxvYWRpbmcgdGhyb3VnaCBQU1AuIFRoaXMgaXMg
YWxyZWFkeQpzdXBwb3J0ZWQgaW4gUFNQIGFzIEdGWF9GV19UWVBFX0RNVUIsIGl0IGp1c3QgbmVl
ZHMgdG8gYmUgbWFwcGVkIGZyb20KQU1ER1BVX1VDT0RFX0lEX0RNQ1VCIHRvIEdGWF9GV19UWVBF
X0RNVUIuCgpETVVCIGlzIGEgc2hvcnRoYW5kIG5hbWUgZm9yIERNQ1VCIGFuZCBjYW4gYmUgdXNl
ZCBpbnRlcmNoYW5nZWFibHkuCgpTaWduZWQtb2ZmLWJ5OiBOaWNob2xhcyBLYXpsYXVza2FzIDxu
aWNob2xhcy5rYXpsYXVza2FzQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3BzcC5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKaW5kZXggZmQ3YTczZjRmYTcw
Li5kNGNkZDZmZDNmYmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9wc3AuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMK
QEAgLTEyNzYsNiArMTI3Niw5IEBAIHN0YXRpYyBpbnQgcHNwX2dldF9md190eXBlKHN0cnVjdCBh
bWRncHVfZmlybXdhcmVfaW5mbyAqdWNvZGUsCiAJY2FzZSBBTURHUFVfVUNPREVfSURfVkNOMV9S
QU06CiAJCSp0eXBlID0gR0ZYX0ZXX1RZUEVfVkNOMV9SQU07CiAJCWJyZWFrOworCWNhc2UgQU1E
R1BVX1VDT0RFX0lEX0RNQ1VCOgorCQkqdHlwZSA9IEdGWF9GV19UWVBFX0RNVUI7CisJCWJyZWFr
OwogCWNhc2UgQU1ER1BVX1VDT0RFX0lEX01BWElNVU06CiAJZGVmYXVsdDoKIAkJcmV0dXJuIC1F
SU5WQUw7Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
