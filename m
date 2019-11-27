Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13387C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98152070A
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98152070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 913BE6E4D4;
	Wed, 27 Nov 2019 09:15:44 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740070.outbound.protection.outlook.com [40.107.74.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E52F76E4D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 09:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+/SUkb3+X9sReQI/CuwbgInXqo9ouUVlt8Tr7PD7ydrYokNQEmy1D+Th/DVn9uaEzqCBtRUKmc3L1C1P8tJ5bxKIwjtzgcsjqWcloEMeSgLFYk05pHx/HvX12XtNvK8IQqZA+QkU4ViEP8M0NzA9Y4aKxSjUXIy+8W602sX9V/XEwW25X0YUYOcTaiQ/moA9lQG0J5MwkhkzTnQFvMJL80xY1CHy4Zojs4YFHz3XQVShyJsNYp7mC7gcYKQLSfrrVGTik2m8Jgab/7gxO+8lBeAPN1+9R5sPNQt8qASOxL0YTY0o+B3z+clAdEpbHmdJOSZkIzdeJsEZF24J0Secg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JO+7lT6f+JaLP7r3mNWJulWrArqxcxoW4jGKVCGhrb0=;
 b=iwONSVOAvPJ8uakYIBMM2VM01CvxY0LTprfUucaBrlFnp8rMSEevi0OCKaTXHrTR0oMPBE2eKG0D0QyiJDvRIbnnRY/NRIYA0zuP7tq6bnrSgK+SWXdP7g7agcSN6fqXtK34F8W5aSuBqS3gY/Y6R5NQJpywUX/cNSj9Z77Zt31Ta09UguL7s8BR20A4/8k/cb9VpUhyFGd2DzXsoV0cBS9B2Jt/vW/FS0M7E/DL0Mp4Cs1alfnCwnhcr/KenZZlRBjo1DOBWKKdcejjkNNQu1b7Vfz2dB4+zgyKcD2N26JXD71Ixy2lVZfPsDTgpKLpoRy1C00EIfcbZeaa8kKdLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from SN1PR12CA0109.namprd12.prod.outlook.com (2603:10b6:802:21::44)
 by DM5PR12MB1372.namprd12.prod.outlook.com (2603:10b6:3:77::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Wed, 27 Nov 2019 09:15:38 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::201) by SN1PR12CA0109.outlook.office365.com
 (2603:10b6:802:21::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19 via Frontend
 Transport; Wed, 27 Nov 2019 09:15:38 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 27 Nov 2019 09:15:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 03:15:37 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 03:15:36 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 27 Nov 2019 03:15:34 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/10] drm/amdgpu: remove ras global recovery handling from
 ras_controller_int handler
Date: Wed, 27 Nov 2019 17:15:21 +0800
Message-ID: <1574846129-4826-1-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(428003)(199004)(189003)(36756003)(48376002)(8936002)(2351001)(5660300002)(336012)(186003)(86362001)(6916009)(51416003)(54906003)(16586007)(316002)(478600001)(14444005)(70586007)(8676002)(26005)(81166006)(81156014)(4744005)(356004)(6666004)(305945005)(2616005)(47776003)(44832011)(426003)(2906002)(4326008)(70206006)(50226002)(50466002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1372; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6808a75-e7e2-4742-b315-08d7731a5df6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1372:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1372EDA2B90A3BE07890F0FDF6440@DM5PR12MB1372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 023495660C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sXDSCYxr0xZmpVI+J/sdefU1+cAFE5XlMeFAWkRsCi7J2S9n87ToxyceAwYro5AjVVzDI1xiSRRq0UfvjDfMFMB+IsJ/jztJsw2l83/nLAQvi1eCx7gICgluoAGS2Nm5HTuQkGGD2ufzrTt+2t1CiNkWwyj86SibuLEPrrcgbagD4gLVAy5pXg/tvIgMZkY9QInnfY3/qFpIMcZGyaecPNj+jNWUHgZoftH6c9dwTw9Vjp+ZtQ56CaH/KSjcT7iLMa8RxN6hhGm4ndP9ed2eG6lC1gQs/XhdQTJA2IhP6uIfEMHRsnOVHEU67Bu/S+3A8bTPEqMUV4kZ55JKKTtUGyIaVz8nWW5s3sM49NylNFlWXCLQbltATyFR9Be0TNkGnmEtMck7dAD27O5G3gCjIfXS7c0CN/QIwnjZxI1rNVIGQbdzTJUUY56md96aG3l1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 09:15:37.7596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6808a75-e7e2-4742-b315-08d7731a5df6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1372
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JO+7lT6f+JaLP7r3mNWJulWrArqxcxoW4jGKVCGhrb0=;
 b=a5bmOAkOSxyrBJCySG6xJAdUUa2v/z/34Hefv++QLHPPZlxqgRg6u6VywVqOW6EAqs1oOGb06SAxyfl8Vo1k0ocujvT3RhoyZZuQPYqGic/n2a6KknVMWis6tLELoMhZ5+Tkr16R3pXfTms+rVQaf7CRhFuggK7r4rqeE9uH7OQ=
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
Cc: guchun.chen@amd.com, tao.zhou1@amd.com, Le Ma <Le.Ma@amd.com>,
 alexander.deucher@amd.com, dennis.li@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127091521.fm0kLceri9K6oX2K77W-Z0iE48eIKGRpfXvksMf4ZkU@z>

RnJvbTogTGUgTWEgPExlLk1hQGFtZC5jb20+Cgp2MjogYWRkIG5vdGlmaWNhdGlvbiB3aGVuIHJh
cyBjb250cm9sbGVyIGludGVycnVwdCBnZW5lcmF0ZXMKCkNoYW5nZS1JZDogSWMwM2U0MmU5ZDFj
NGRhYjFmYTdmNDgxN2MxOTFhMTZlNDg1YjQ4YTkKU2lnbmVkLW9mZi1ieTogTGUgTWEgPExlLk1h
QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmJpb192N180LmMgfCA3
ICsrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3XzQuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25iaW9fdjdfNC5jCmluZGV4IDBkYjQ1OGYuLjI1MjMx
ZDYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25iaW9fdjdfNC5jCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25iaW9fdjdfNC5jCkBAIC0zMjQsNyArMzI0
LDEyIEBAIHN0YXRpYyB2b2lkIG5iaW9fdjdfNF9oYW5kbGVfcmFzX2NvbnRyb2xsZXJfaW50cl9u
b19iaWZyaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlCiAJCQkJCQlSQVNfQ05UTFJfSU5URVJSVVBU
X0NMRUFSLCAxKTsKIAkJV1JFRzMyX1NPQzE1KE5CSU8sIDAsIG1tQklGX0RPT1JCRUxMX0lOVF9D
TlRMLCBiaWZfZG9vcmJlbGxfaW50cl9jbnRsKTsKIAotCQlhbWRncHVfcmFzX2dsb2JhbF9yYXNf
aXNyKGFkZXYpOworCQlEUk1fV0FSTigiUkFTIGNvbnRyb2xsZXIgaW50ZXJydXB0IHRyaWdnZXJl
ZCBieSBOQklGIGVycm9yXG4iKTsKKworCQkvKiByYXNfY29udHJvbGxlcl9pbnQgaXMgZGVkaWNh
dGVkIGZvciBuYmlmIHJhcyBlcnJvciwKKwkJICogbm90IHRoZSBnbG9iYWwgaW50ZXJydXB0IGZv
ciBzeW5jIGZsb29kCisJCSAqLworCQlhbWRncHVfcmFzX3Jlc2V0X2dwdShhZGV2LCB0cnVlKTsK
IAl9CiB9CiAKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
