Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A246DCA9ECB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F9120873
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F9120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 215346EEB5;
	Thu, 31 Oct 2019 14:42:45 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730067.outbound.protection.outlook.com [40.107.73.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C7C06EEB1
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 14:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfuS1iJYfjz0stkFTZ43TdaCiPRSZ32AMB/rUP7Ee1TIiKmdrYMgo1tVars1R+G/qRYn9/IIXy2M4b3CYbGRjGW19tcrMYz8ksiw8O7KSKN5FfHgm7ty7aUoGtxHz3NkMTFtYD3CrzkAiiAASwlvnsMHcQgzR5AclWiptxjVAONJ6DrbQe5bC5eIWe3pgjyGmdQYDSq5dyBUj5H8l8CQ3xQTOgwZNIOM6C9rxpz4PAt1YtPYqkZqV417r0WHOIa77JBYYtSK+t5kyySaa/ZOcUyhKauU9Oq19lJKM+6x/9nMn4Fi+gV05pygGx5n9ee8JdIhHDhKXbasDxoKxUg9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9Puea5xmhMuKsqKVfIBR2/WUoNQYp+Qr81VYgrjc1c=;
 b=oVXdVo02wkS87y0a22R1T2EtsPEGYdE4uaHg3NzgLuQhwkjlxrmLN59vlpiRIppvQeoOGqC1e6eBkhkL95QFdmc6k2GBfJxFygbmlQOWsa/I/jExvACTRsv9aQ0w4/b18UeKQ60PH6MvQftIXf3Bz3gqsGYMiyVHlSgIRZ1srNquTz+DVctxThppBenWsDLKzs2tnZSTTT6cMiMWoSGDsMkcfAjl81xeT0BBSGEQ7A+r5na9I4bujc7PCMwlE/4ObjlX+U+SDMUgKZyVN43WVIIja2IkHUMBVp3cmhkBUXeyDLICUOH9vafKAwnUPT9eyxVMRCpfINwrP1phbso0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CY4PR12CA0035.namprd12.prod.outlook.com (2603:10b6:903:129::21)
 by CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Thu, 31 Oct
 2019 14:42:40 +0000
Received: from CO1NAM03FT024.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::207) by CY4PR12CA0035.outlook.office365.com
 (2603:10b6:903:129::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.19 via Frontend
 Transport; Thu, 31 Oct 2019 14:42:39 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM03FT024.mail.protection.outlook.com (10.152.80.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 31 Oct 2019 14:42:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:37 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:37 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 31 Oct 2019 09:42:37 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/20] drm/amd/display: optimize bandwidth after commit
 streams.
Date: Thu, 31 Oct 2019 10:41:59 -0400
Message-ID: <20191031144210.24011-10-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
References: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(428003)(189003)(199004)(50466002)(6916009)(6666004)(86362001)(186003)(5660300002)(4326008)(356004)(478600001)(26005)(47776003)(48376002)(70206006)(16586007)(51416003)(81156014)(50226002)(126002)(8676002)(81166006)(2351001)(316002)(76176011)(476003)(305945005)(336012)(2906002)(426003)(486006)(446003)(11346002)(53416004)(8936002)(2616005)(7696005)(1076003)(70586007)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3895; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 175e3162-644b-4771-343e-08d75e109458
X-MS-TrafficTypeDiagnostic: CH2PR12MB3895:
X-Microsoft-Antispam-PRVS: <CH2PR12MB389588AB05E798700AFB7420F9630@CH2PR12MB3895.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:181;
X-Forefront-PRVS: 02070414A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMh7NPxV/kcMxPy/8b7HuzyxylhUG9Y2X/ODJOMt5JJbTkZTQC3ECaBLBmkGzMLcAriVOyt/lZXCMwAJJj2h7OG2mSvQsaEFiwm+2/AI0EPECU9EgUiRLEFptYH86arSKcNOTReWGb1ql0srNgzN5QUwpE/LMSrmCXmNb1ZoeVrv/V9O4UGWaQQhZw7N4u0ZbFTi2wzPxmGvyZnwc3jbbinwi0rRRCoAFEIU/2f8QfI5DGaFLnclMj3W1/BMur9SPlH2QsmtWVVBkdNWoNPRrzZIeSzcYefRCVryE3HfQdaQm0DhOfop7Mq0NP8lll7UTDeLDFWgBVom5TI5shWMqCTpnTKRM97Txq1bUcg0HH19RU67inJfO6jrsKP7yZKzoNJcRK5k9CdvfnssHJOCvRRbksYs3VRfX4TWJOqLtrlHTZQzYnZU3yWqedVZwQeZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2019 14:42:39.5879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 175e3162-644b-4771-343e-08d75e109458
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3895
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9Puea5xmhMuKsqKVfIBR2/WUoNQYp+Qr81VYgrjc1c=;
 b=wx71w4a5oJSpNzQvAhBrCYj69ptR1OjF9F28t6+V98iSOTAEppO+/RFFrXZ4FxSOZRL2bFMEUHYKd+tfo5gzVJfucsnD1ETe/l12wQblZyqE+Q4QuTKfnJgfNagJdnYbx8x5KNlpVQX6240SBKJB5wheB4y/ou+zsPUN3alFV2M=
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
Cc: Yongqiang Sun <yongqiang.sun@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031144159.acs4JhMB6oQlhBYy8bd60EMiFcPSCBSwrwKOJNOYgjc@z>

RnJvbTogWW9uZ3FpYW5nIFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgoKW1doeV0KU3lzdGVt
IGlzIHVuYWJsZSB0byBlbnRlciBTMGkzIGR1ZSB0byBESVNQTEFZX09GRl9NQVNLIG5vdCBhc3Nl
cnRlZAppbiBTTVUuCgpbSG93XQpPcHRpbWl6ZWQgYmFuZHdpZHRoIHNob3VsZCBiZSBjYWxsZWQg
cGFpcmVkIGFuZCB0byByZXNvbHZlIHVucGx1ZwpkaXNwbGF5IHVuZGVyZmxvdyBpc3N1ZSwgb3B0
aW1pemUgYmFuZHdpZHRoIGFmdGVyIGNvbW1pdCBzdHJlYW1zIGlzCm1vdmVkIHRvIG5leHQgcGFn
ZSBmbGlwLCBpbiBjYXNlIG9mIFMwaTMsIHRoZXJlIGlzIGEgY2hhbmdlIGZvciBubwpmbGlwIGNv
bWluZyBjYXVzaW5nIGRpc3BsYXkgY291bnQgaXMgMSBpbiBTTVUgc2lkZS4KQWRkIG9wdGltaXpl
IGJhbmR3aWR0aCBhZnRlciBjb21taXQgc3RyZWFtLgoKU2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5n
IFN1biA8eW9uZ3FpYW5nLnN1bkBhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9ueSBDaGVuZyA8VG9u
eS5DaGVuZ0BhbWQuY29tPgpBY2tlZC1ieTogQmhhd2FucHJlZXQgTGFraGEgPEJoYXdhbnByZWV0
Lkxha2hhQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUv
ZGMuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCmluZGV4IDMyZjMxYmY5MTkxNS4uYjI2ZWQw
N2MyZDJjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9k
Yy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMKQEAgLTEy
NDUsNiArMTI0NSwxMCBAQCBzdGF0aWMgZW51bSBkY19zdGF0dXMgZGNfY29tbWl0X3N0YXRlX25v
X2NoZWNrKHN0cnVjdCBkYyAqZGMsIHN0cnVjdCBkY19zdGF0ZSAqYwogCiAJZGNfZW5hYmxlX3N0
ZXJlbyhkYywgY29udGV4dCwgZGNfc3RyZWFtcywgY29udGV4dC0+c3RyZWFtX2NvdW50KTsKIAor
CWlmICghZGMtPm9wdGltaXplX3NlYW1sZXNzX2Jvb3QpCisJCQkvKiBwcGxpYiBpcyBub3RpZmll
ZCBpZiBkaXNwX251bSBjaGFuZ2VkICovCisJCQlkYy0+aHdzcy5vcHRpbWl6ZV9iYW5kd2lkdGgo
ZGMsIGNvbnRleHQpOworCiAJZm9yIChpID0gMDsgaSA8IGNvbnRleHQtPnN0cmVhbV9jb3VudDsg
aSsrKQogCQljb250ZXh0LT5zdHJlYW1zW2ldLT5tb2RlX2NoYW5nZWQgPSBmYWxzZTsKIAotLSAK
Mi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
