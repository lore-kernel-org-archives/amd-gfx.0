Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FA9C3F2D6
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA0A246B6
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SH+9rxQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA0A246B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEB8D6E1BE;
	Mon,  2 Mar 2020 09:22:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C8906E187
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 09:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clsjLPoY4Ic0uiXy/JKb8ekARPpHz6oY5UgCpGuHkRsuuEb4hTtoWA/lwlCpN+qzCvp+nMiYsbD1uRdLyk1wHDfcs0b1x1axGI/+TzHLYTt5MZ+5KLWRtd+PaId6dtRGuuZs3ZnEaVfXGeTsxvVFzcYkO5Q4cNq1+DCZKYxWLqggclUEZF9s1gsGnuS8oMmxTziOz07uZ9kmN30auJDHDmt9jtwPHR0B6Ib7oxYqO0ucUtlMMEyzWZH08XdVU4zF6D26Q3RkFeIv1RVoRyv9DDA28l4oq7QA6LU5hUDXiuMFjaIrVFH9SfyLOMTK7X43KUOUd+1LNtbdq1ZbOOPN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Usu1w1V+Be1p4ENf5OTNqcPQwrGdL5vWBViN8kP6Xwk=;
 b=FP9jilzbvdiVGpOjBVr8Q0H1j2k46i6yhuXgA+VbuBOE6dRX7HbS2f6amC4gSPET/wjYG3a+aCShCU4fcavGtxcKO3MZYZawFTvuArYBMJpCHs6Li2HKxq/ERBHgC/Py6PQNJDpfmfLYbsM1KMkWmjNLpXdJDbf1LwZ6DgAI6yHAXdbCu3G/rkNT79jffxi1jmAta0RnXYXUy9nkRLnYuomxYQ/7QMOcW77JRUhVW70193OoWPbXi7zeWUvZIbBxHBMCl8qFmXOpUxsDwwmhQQlKA3wYprrVqqe6V0phLelafkzbS2cPMNtstM+eZIRWAADrcuJ/5CT5Vo6R+WCmcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Usu1w1V+Be1p4ENf5OTNqcPQwrGdL5vWBViN8kP6Xwk=;
 b=SH+9rxQGIkEDTbg71rDAkrP0XHdFrKvhbr96ExvLTx/q2FmgghdN02EXQx5MQWJzsdMmPm9V5mOnifi+tO6ErRZNThd4KOu76m+tKN0A68r5VZA5BqkO3aVxyBtpt/lPgWMKF6bcV1ChHaZcGJzDj4Vz6hoMdR3KgnhWYC7IvFY=
Received: from BN6PR17CA0019.namprd17.prod.outlook.com (2603:10b6:404:65::29)
 by CY4PR12MB1528.namprd12.prod.outlook.com (2603:10b6:910:6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 09:22:12 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::fa) by BN6PR17CA0019.outlook.office365.com
 (2603:10b6:404:65::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Mon, 2 Mar 2020 09:22:12 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 09:22:12 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 03:22:12 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 2 Mar 2020 03:22:11 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: don't use pipe1 of gfx10
Date: Mon, 2 Mar 2020 17:22:06 +0800
Message-ID: <1583140927-19809-2-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583140927-19809-1-git-send-email-Monk.Liu@amd.com>
References: <1583140927-19809-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(428003)(199004)(189003)(70206006)(336012)(478600001)(186003)(2906002)(356004)(70586007)(7696005)(8676002)(81166006)(81156014)(4326008)(86362001)(6666004)(8936002)(26005)(6916009)(36756003)(2616005)(426003)(5660300002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1528; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09c3c5f9-b487-4b49-82e6-08d7be8b30dd
X-MS-TrafficTypeDiagnostic: CY4PR12MB1528:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1528337DDE7CC2B207A7E31884E70@CY4PR12MB1528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RYP00faJnu028kzXsNdaQ+YP0j5xgk94cXQ62OiJGRH8pqlmWRKBHLETtYrtI+Gjiuw3cvRhB0WzzN6NcecLMCqlWoYdjZwad7DuYzlbq0CIdLHg7SqBEIsz9k5y6jk0mth8KFdK5YvTY7xVVbZ9t4gS2a11Hh8l/9H1BFbz6d6p65pV5rwmC38dIg/b3gvJLlf0cYHb4FTqvsA8RZrHs3gdkkSq0pb2vDA8hor/yjOfRN//gipP9N/+A41NvDFjnWSUyN0QO3oA0xbXawe5vd8FT1TiODTBO6MtrN7/ZA5rLaGHfpvkxFE3QW6AQdLHzOahMIkTSshwJwZ9kuQGYHXbFUyptwI1DrghmDQ0JMdwdPKEs3euR3+RsQ2c8bmpdvnvZIu7/PttbLm1b7YxlmFkppHQ4iZfneismwhR7B1/HsL7mFewJbFyd8qscEtx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 09:22:12.5339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c3c5f9-b487-4b49-82e6-08d7be8b30dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1528
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

d2hhdDoKd2UgZm91bmQgc29tZXRpbWVzIElETEUgZmFpbCBhZnRlciB2ZiBndWVzdCBmaW5pc2hl
ZCBJQiB0ZXN0Cm9uIEdGWCByaW5nMSAocGlwZTEpCgp3aHk6CmJlbG93IGlzIHdoYXQgQ1AgdGVh
bSBzdGF0ZWQgKE1hbnUpOgpHRlggUGlwZSAxIGlzIHRoZXJlIGluIEhXLCBidXQgYXMgcGFydCBv
ZiBvcHRpbWl6YXRpb24gYWxsIGRyaXZlcgpkZWNpZGVkIG5vdCB0byB1c2UgcGlwZSAxIGF0IGFs
bCwgb3RoZXJ3aXNlIGRyaXZlciBoYXMgdG8gc2FjcmlmaWNlCmNvbnRleHQgc28gYWxsIDcgY29u
dGV4dCB3aWxsIG5vdCBiZSBhYmxlIGZvciBHRlggcGlwZSAwLiBUaGF04oCZcwp3aHkgSSBza2lw
IHNldHRpbmcgb2Ygc3RhdGUgZm9yIGdmeCBwaXBlIDEgYXMgZGVjaWRlZCBieSBhbGwgZHJpdmVy
CnRlYW0KCmZpeDoKc2luY2UgQ1AgdGVhbSB3b24ndCBoZWxwIHVzIHRvIGRlYnVnIGFueSBpc3N1
ZXMgdGhhdCByZWxhdGVkIHdpdGgKZ2Z4IHBpcGUxLCBzbyBiYXNlZCBvbiBhYm92ZSByZWFzb24s
IGxldCdzIHNraXAgZ2Z4IHJpbmcgMSAocGlwZTEpCmV2ZW4gZm9yIGJvdGggYmFyZS1tZXRhbCBh
bmQgU1JJT1YKClNpZ25lZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgMjkgKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxMSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCmluZGV4IDA1
NTU5ODkuLmFmYWU0Y2MgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92MTBfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCkBA
IC0xMzA4LDcgKzEzMDgsNyBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9zd19pbml0KHZvaWQgKmhh
bmRsZSkKIAljYXNlIENISVBfTkFWSTE0OgogCWNhc2UgQ0hJUF9OQVZJMTI6CiAJCWFkZXYtPmdm
eC5tZS5udW1fbWUgPSAxOwotCQlhZGV2LT5nZngubWUubnVtX3BpcGVfcGVyX21lID0gMjsKKwkJ
YWRldi0+Z2Z4Lm1lLm51bV9waXBlX3Blcl9tZSA9IDE7CiAJCWFkZXYtPmdmeC5tZS5udW1fcXVl
dWVfcGVyX3BpcGUgPSAxOwogCQlhZGV2LT5nZngubWVjLm51bV9tZWMgPSAyOwogCQlhZGV2LT5n
ZngubWVjLm51bV9waXBlX3Blcl9tZWMgPSA0OwpAQCAtMjcxMywxOCArMjcxMywyMSBAQCBzdGF0
aWMgaW50IGdmeF92MTBfMF9jcF9nZnhfc3RhcnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
CiAKIAlhbWRncHVfcmluZ19jb21taXQocmluZyk7CiAKLQkvKiBzdWJtaXQgY3MgcGFja2V0IHRv
IGNvcHkgc3RhdGUgMCB0byBuZXh0IGF2YWlsYWJsZSBzdGF0ZSAqLwotCXJpbmcgPSAmYWRldi0+
Z2Z4LmdmeF9yaW5nWzFdOwotCXIgPSBhbWRncHVfcmluZ19hbGxvYyhyaW5nLCAyKTsKLQlpZiAo
cikgewotCQlEUk1fRVJST1IoImFtZGdwdTogY3AgZmFpbGVkIHRvIGxvY2sgcmluZyAoJWQpLlxu
Iiwgcik7Ci0JCXJldHVybiByOwotCX0KKwlpZiAoYWRldi0+Z2Z4Lm1lLm51bV9waXBlX3Blcl9t
ZSA9PSAyKSB7CisJCS8qIHN1Ym1pdCBjcyBwYWNrZXQgdG8gY29weSBzdGF0ZSAwIHRvIG5leHQg
YXZhaWxhYmxlIHN0YXRlICovCisJCXJpbmcgPSAmYWRldi0+Z2Z4LmdmeF9yaW5nWzFdOwogCi0J
YW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgUEFDS0VUMyhQQUNLRVQzX0NMRUFSX1NUQVRFLCAwKSk7
Ci0JYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgMCk7CisJCXIgPSBhbWRncHVfcmluZ19hbGxvYyhy
aW5nLCAyKTsKKwkJaWYgKHIpIHsKKwkJCURSTV9FUlJPUigiYW1kZ3B1OiBjcCBmYWlsZWQgdG8g
bG9jayByaW5nICglZCkuXG4iLCByKTsKKwkJCXJldHVybiByOworCQl9CiAKLQlhbWRncHVfcmlu
Z19jb21taXQocmluZyk7CisJCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIFBBQ0tFVDMoUEFDS0VU
M19DTEVBUl9TVEFURSwgMCkpOworCQlhbWRncHVfcmluZ193cml0ZShyaW5nLCAwKTsKKworCQlh
bWRncHVfcmluZ19jb21taXQocmluZyk7CisJfQogCiAJcmV0dXJuIDA7CiB9CkBAIC0yODIyLDYg
KzI4MjUsOSBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9jcF9nZnhfcmVzdW1lKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQogCW11dGV4X3VubG9jaygmYWRldi0+c3JibV9tdXRleCk7CiAKIAkv
KiBJbml0IGdmeCByaW5nIDEgZm9yIHBpcGUgMSAqLworCWlmIChhZGV2LT5nZngubWUubnVtX3Bp
cGVfcGVyX21lID09IDEpCisJCWdvdG8gZG9fc3RhcnQ7CisKIAltdXRleF9sb2NrKCZhZGV2LT5z
cmJtX211dGV4KTsKIAlnZnhfdjEwXzBfY3BfZ2Z4X3N3aXRjaF9waXBlKGFkZXYsIFBJUEVfSUQx
KTsKIAlyaW5nID0gJmFkZXYtPmdmeC5nZnhfcmluZ1sxXTsKQEAgLTI4NjAsNiArMjg2Niw3IEBA
IHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX2NwX2dmeF9yZXN1bWUoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCiAJZ2Z4X3YxMF8wX2NwX2dmeF9zd2l0Y2hfcGlwZShhZGV2LCBQSVBFX0lEMCk7CiAJ
bXV0ZXhfdW5sb2NrKCZhZGV2LT5zcmJtX211dGV4KTsKIAorZG9fc3RhcnQ6CiAJLyogc3RhcnQg
dGhlIHJpbmcgKi8KIAlnZnhfdjEwXzBfY3BfZ2Z4X3N0YXJ0KGFkZXYpOwogCi0tIAoyLjcuNAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
