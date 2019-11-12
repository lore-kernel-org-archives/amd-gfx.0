Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5FAC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 15:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3760F20679
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 15:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3760F20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 010976EB5F;
	Tue, 12 Nov 2019 15:16:56 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680053.outbound.protection.outlook.com [40.107.68.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11ADC6EB5D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 15:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGadmLp0Xw8JedvHfk47GF/vDZjPNxEZ5VztYw2OR6bZLWjcQblVRG9lSDIPrwFWEWo4PMZb5dlM3yax7wSx63ndv0tC6sY76a8ofeOlvwKoOOk28UGdkN7L+BWELru2alsZgv+PGEfstkgQQrd2jk4CZne9PUN7EW2sY9Kfz+V5C9odyDs16oq431cIz7kIKDQm5D1JHlctt/aYvsa9hka2Lxb3lmUpJTexu/C6O2jiOxd/XDCw/8S7km4gFMjaNMc9yDOovGjjmz+PV5Cm7fSA0hplw+GnkFYPWw4lrhkevVehdStRU6RX4lRoU5JD1K++jEyj8hlDs3MPpgCDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FgrsiM38082DCt5ZY1FYHOdiWGeaD5aMpPSLtv+TI0=;
 b=fFCm+cwE2FHKw3yVHdAv+G8A4bUZDt7qJGCm2TbKTHdCIqohflkfJavpOwCePiTV6BDtfsw4BFiOh7V0GWdBUIV/yqyWK9w3o45oQwn9sVG4FjM3ooch4H7wL5YXW0L4GxsoTq3j6SemECU0httbBRq2hsO3Rxl1Cr0LI5/YgivcjoiVV+DzDz3f0kD6gnADjN65m01X3dR+81dfLWvFqcpPiobSzdzlN6yAn0OQIYDI+kyWonBD0ow9qPkTN5Xo07Fv3HoDm/wz5Eb/7RhItEReGvtEjovCpI/LetBBTG+pE7H3XDQDdpqhb1lfmIGaQcmEyCV+6TUBrTAPfFYIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM6PR12CA0008.namprd12.prod.outlook.com (2603:10b6:5:1c0::21)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.25; Tue, 12 Nov
 2019 15:16:51 +0000
Received: from CO1NAM03FT024.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::203) by DM6PR12CA0008.outlook.office365.com
 (2603:10b6:5:1c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.23 via Frontend
 Transport; Tue, 12 Nov 2019 15:16:51 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM03FT024.mail.protection.outlook.com (10.152.80.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2430.20 via Frontend Transport; Tue, 12 Nov 2019 15:16:51 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 12 Nov
 2019 09:16:31 -0600
Received: from mlipski-pc.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 12 Nov 2019 09:16:30 -0600
From: <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Return correct error value
Date: Tue, 12 Nov 2019 10:16:28 -0500
Message-ID: <20191112151628.8267-1-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(39860400002)(346002)(428003)(199004)(189003)(7696005)(6636002)(81166006)(186003)(26005)(53416004)(5660300002)(16586007)(81156014)(305945005)(48376002)(316002)(8676002)(4326008)(2876002)(1076003)(336012)(356004)(8936002)(478600001)(50466002)(70586007)(70206006)(47776003)(486006)(476003)(50226002)(36756003)(110136005)(54906003)(426003)(86362001)(126002)(51416003)(2906002)(2616005)(16060500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4302; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc24228f-5078-4c35-de49-08d76783581d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4302:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4302A2863CFE35E0498C43C5E4770@MN2PR12MB4302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 021975AE46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uutXEG03pNP1bJxe1Gdv5dSAYJnlqF1HuadB2NqSgwsLw9jILxhknv6dXpBrma6nEJ6y5eGhO/pmULXSp6srYs1DX9dRoraU+XskscqclRmzUrL2XzXvofConQdZ5nwbRj5Kpmj1IIvR04KmozWg7NeqKb0dLsoafAamXYE3EogR+DZfTSVR8vyiv/0okj9EaWVPhGhKXrG1IjowpnmaNJdpJTyE360kWqv1ae26TaQbb6gJ6xyv4ZfACnklNjnDh082lH8BynWjcV9PVAciqBU+tMfEPownVe7AKwQOmsLKs6cFhbqokut36lAdQD6DUmjL4hlkRNqESLX4K/HJTg4snZNAVfm2/IdeytKgxBb8s8E96oOZEQDqMH8rpMe8OXuyWM03VhaS8spt0SB+OTaQJvZEatb/ijoBNpsKTdIpWuL0ISJPzqouskSwEjaN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 15:16:51.1342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc24228f-5078-4c35-de49-08d76783581d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FgrsiM38082DCt5ZY1FYHOdiWGeaD5aMpPSLtv+TI0=;
 b=CDgzO2chjkcBbPqRXUUIo6ptqDTRCL3L18+EnoOgxxAqBFPPaLn1tC3BptGPEEsw7fubTICgQsK4U9wUmWS6EHg0rvDgimCJSzwA7jEf6UDCo8xPW+iYu0xDNXmeEhyFD50awlYaakqSe6x4nl91fiFBx3sqLGe//D67j96DNJE=
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
Cc: alexander.deucher@amd.com, Mikita Lipski <mikita.lipski@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112151628.PJLNPvWrAtC23Ewl4GCS2Djo0DjkhVGiZeeUnNYiEbs@z>

RnJvbTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgoKW3doeV0KVGhlIGZ1
bmN0aW9uIGlzIGV4cGVjdGVkIHRvIHJldHVybiBpbnN0YW5jZSBvZiB0aGUgdGltaW5nIGdlbmVy
YXRvcgp0aGVyZWZvcmUgd2Ugc2hvdWxkbid0IGJlIHJldHVybmluZyBib29sZWFuIGluIGludGVn
ZXIgZnVuY3Rpb24sCmFuZCB3ZSBzaG91bGRuJ3QgYmUgcmV0dXJuaW5nIHplcm8gc28gY2hhbmdp
bmcgaXQgdG8gLTEuCgpTaWduZWQtb2ZmLWJ5OiBNaWtpdGEgTGlwc2tpIDxtaWtpdGEubGlwc2tp
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfcmVz
b3VyY2UuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9j
b3JlL2RjX3Jlc291cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9k
Y19yZXNvdXJjZS5jCmluZGV4IDg5YjVmODZjZDQwYi4uNzVjYzU4ZWNmNjQ3IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19yZXNvdXJjZS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3Jlc291cmNlLmMKQEAgLTE4
NjYsNyArMTg2Niw3IEBAIHN0YXRpYyBpbnQgYWNxdWlyZV9yZXNvdXJjZV9mcm9tX2h3X2VuYWJs
ZWRfc3RhdGUoCiAJaW5zdCA9IGxpbmstPmxpbmtfZW5jLT5mdW5jcy0+Z2V0X2RpZ19mcm9udGVu
ZChsaW5rLT5saW5rX2VuYyk7CiAKIAlpZiAoaW5zdCA9PSBFTkdJTkVfSURfVU5LTk9XTikKLQkJ
cmV0dXJuIGZhbHNlOworCQlyZXR1cm4gLTE7CiAKIAlmb3IgKGkgPSAwOyBpIDwgcG9vbC0+c3Ry
ZWFtX2VuY19jb3VudDsgaSsrKSB7CiAJCWlmIChwb29sLT5zdHJlYW1fZW5jW2ldLT5pZCA9PSBp
bnN0KSB7CkBAIC0xODc4LDEwICsxODc4LDEwIEBAIHN0YXRpYyBpbnQgYWNxdWlyZV9yZXNvdXJj
ZV9mcm9tX2h3X2VuYWJsZWRfc3RhdGUoCiAKIAkvLyB0Z19pbnN0IG5vdCBmb3VuZAogCWlmIChp
ID09IHBvb2wtPnN0cmVhbV9lbmNfY291bnQpCi0JCXJldHVybiBmYWxzZTsKKwkJcmV0dXJuIC0x
OwogCiAJaWYgKHRnX2luc3QgPj0gcG9vbC0+dGltaW5nX2dlbmVyYXRvcl9jb3VudCkKLQkJcmV0
dXJuIGZhbHNlOworCQlyZXR1cm4gLTE7CiAKIAlpZiAoIXJlc19jdHgtPnBpcGVfY3R4W3RnX2lu
c3RdLnN0cmVhbSkgewogCQlzdHJ1Y3QgcGlwZV9jdHggKnBpcGVfY3R4ID0gJnJlc19jdHgtPnBp
cGVfY3R4W3RnX2luc3RdOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
