Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29099CA9EC1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 11:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0547220873
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 11:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0547220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4AF86E5EF;
	Mon, 28 Oct 2019 11:31:22 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760085.outbound.protection.outlook.com [40.107.76.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDBDE6E5EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 11:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vdkall+zMVqxdlFKsYmmCGnaUdiYkFqTQEf/yxIJA23ndN0pYm4RDI1+fZEAfoKDyEO5DLRN67nsNTHC0ujYiSdekkGW6Mkdt+hlk8UlcQRC+aOxBuJafpJH8/NJgli0WGfwdLzfA7kq3hQqTiQLNMUbWhFzGXfr8iB/UdE4/P0Pfo/JSHAvj0EehDcZj6GuhDFKMMVVVcWTLINL6OX6u9QDwDM8RXfaqHxEwXb1bWCpIqrr3Se3u53WzGRHuWm3lSLhgDYy6DOY1m+Oo2V7bWNmrYu1E/HWwN2lc8xvC3Qe0JzBjbX7VWa7t04ZDqn24Pw2lJzcl9kfjl1KRE4iTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdPMdukz5eFNrLGIQf4r2lp0styLRyqJF4LJal7Afd4=;
 b=OBw1/boamUoMYxRYyaZG6sC8Yp7ORtWWUsP1VzEpt9mJzB2R71/J8FCwFwrqP+Td1xPJwFqJIQOO6VRqg9B336PnUg82PuuaFSgafos/+EOjRrUAY4dk58oISsV7k69sex/vUlzJajuc+0y925rkV6XqTgJfHF5sYPtfFhkJEQUL8pIO73yJaLHOctdcaXQtxXff1kpLQ4gTkmSMVFV8snXocZB8p5fhOK0NRRfM5G7RVMWjczhfV/RZRGsxvwvH+OAR3aw+E3cX6DlkTvFb+eFoxVaJu3IktKi2q+V/i/A7D1QOP8OlbtStaQNKcX1Qj8AP28+4yfRtHHRB8PO/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN4PR12CA0001.namprd12.prod.outlook.com (2603:10b6:403:2::11)
 by BYAPR12MB3606.namprd12.prod.outlook.com (2603:10b6:a03:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Mon, 28 Oct
 2019 11:31:18 +0000
Received: from BY2NAM03FT021.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::209) by BN4PR12CA0001.outlook.office365.com
 (2603:10b6:403:2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.25 via Frontend
 Transport; Mon, 28 Oct 2019 11:31:18 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BY2NAM03FT021.mail.protection.outlook.com (10.152.84.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Mon, 28 Oct 2019 11:31:17 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 28 Oct
 2019 06:31:17 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 28 Oct 2019 06:31:16 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: remove ras global recovery handling from
 ras_controller_int handler
Date: Mon, 28 Oct 2019 19:31:09 +0800
Message-ID: <1572262269-14985-4-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572262269-14985-1-git-send-email-le.ma@amd.com>
References: <1572262269-14985-1-git-send-email-le.ma@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(428003)(189003)(199004)(51416003)(6916009)(50466002)(48376002)(70586007)(478600001)(11346002)(86362001)(5660300002)(186003)(76176011)(36756003)(446003)(26005)(8936002)(2351001)(14444005)(2906002)(81166006)(4326008)(81156014)(8676002)(6666004)(356004)(4744005)(476003)(126002)(486006)(2616005)(44832011)(305945005)(16586007)(47776003)(316002)(336012)(426003)(70206006)(50226002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3606; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c788d31-17d7-47c6-b940-08d75b9a5983
X-MS-TrafficTypeDiagnostic: BYAPR12MB3606:
X-Microsoft-Antispam-PRVS: <BYAPR12MB360601EC5724F52FE2F7515BF6660@BYAPR12MB3606.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0204F0BDE2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88Qf0zaRodTfO6/9D8cXZX7EFJ76r62ceq1/3355QUMo+3/9Kznj7AUNAelh+NQmgBgojBKpptf7VBukM5f+a7zXriatCSXyjVS+8IqowtsNoiWSY/jMkgViTkvHjLygva7qa3oZX3G5bvSKT6VYp6g6Xzy7db8R9Zw8lmxstL+orkn2KFfjcl75aMcXuh0PulhA7WaJR/vBR/RJFaFYdzRZ9Wh/30cGKInNbL7f4udQW/nMxyThmCkVt5C11xH2t+hlkLIZBou14If1RxfJ9f79cyH0I0MGMm0UhsXZezuceCY4T6y+NwG/MA+P92FMrW6F8HKw0O+6/CBoYX1bh2+4sRpdj1PDSQ4EoKkVQ8+7h25sKVIXVCGDE+FfVCgjgvIcceGLwiz2s+icS1t52kG51seKnzL3vIRqDrj1FeFr4KnhY18RegWasiOIUciR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2019 11:31:17.9779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c788d31-17d7-47c6-b940-08d75b9a5983
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3606
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdPMdukz5eFNrLGIQf4r2lp0styLRyqJF4LJal7Afd4=;
 b=WaaRupGEhOsZCIipp82xMjqZbUYlKA2sKWO9M7yU+QiRb7ZRpf+Djw4kDkbk/BPDsEySV905Dt0BsqutBj2h6GoPbs/oWseknLXdE2SEdvnr9x3SWL2TA84MPB2fS5bXFmb4MJLr65swdMZ1n3g0dZWRPARZgUOSWKJ84YDt76A=
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
Cc: Le Ma <Le.Ma@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028113109.s44HHUH4wB7ti8qNLKkupl0hOw6_z9z_mlD_VcbR3VA@z>

RnJvbTogTGUgTWEgPExlLk1hQGFtZC5jb20+CgpDaGFuZ2UtSWQ6IElhOGE2MWE0YjNiZDUyOWYw
ZjY5MWU0M2U2OWIyOTlkN2QxNTFjMGMyClNpZ25lZC1vZmYtYnk6IExlIE1hIDxMZS5NYUBhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25iaW9fdjdfNC5jIHwgNiArKysr
Ky0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3XzQuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L25iaW9fdjdfNC5jCmluZGV4IDBkYjQ1OGYuLjg3NjY5MGEgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25iaW9fdjdfNC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25iaW9fdjdfNC5jCkBAIC0zMjQsNyArMzI0LDExIEBA
IHN0YXRpYyB2b2lkIG5iaW9fdjdfNF9oYW5kbGVfcmFzX2NvbnRyb2xsZXJfaW50cl9ub19iaWZy
aW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlCiAJCQkJCQlSQVNfQ05UTFJfSU5URVJSVVBUX0NMRUFS
LCAxKTsKIAkJV1JFRzMyX1NPQzE1KE5CSU8sIDAsIG1tQklGX0RPT1JCRUxMX0lOVF9DTlRMLCBi
aWZfZG9vcmJlbGxfaW50cl9jbnRsKTsKIAotCQlhbWRncHVfcmFzX2dsb2JhbF9yYXNfaXNyKGFk
ZXYpOworCQkvKgorCQkgKiByYXNfY29udHJvbGxlcl9pbnQgaXMgZGVkaWNhdGVkIGZvciBuYmlm
IHJhcyBlcnJvciwKKwkJICogbm90IHRoZSBnbG9iYWwgaW50ZXJydXB0IGZvciBzeW5jIGZsb29k
CisJCSAqLworCQlhbWRncHVfcmFzX3Jlc2V0X2dwdShhZGV2LCB0cnVlKTsKIAl9CiB9CiAKLS0g
CjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
