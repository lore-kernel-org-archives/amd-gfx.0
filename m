Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BE2C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 15:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD61820679
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 15:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD61820679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA296EB5C;
	Tue, 12 Nov 2019 15:15:57 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770050.outbound.protection.outlook.com [40.107.77.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 251FA6EB5C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 15:15:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tex6K9c/K17sbFVzvHX2knQkcPxAgcZQS3sVs/Df20rTG4bG+FunnoPh9GUuAJIIvtp8iFf7uWvbFDBDd+j0V1AJbfF/S7cRDGWNUMHuizWUROruUpiaADxDdne4HuwA0HAgXzerB5EaRvqLk/QR+n7amDCWn0LKL0Q3Dv502FagipK4gzD6dtud/Gtv8NvaNN2ribM4XZe1bzoEF1sG5oUb1yNEex2w9YJfGMp8hI6kE4wszUd2CulHFQ6BUBTeWvhk/i8Txmz9FkNN7ukT/+TtevsMK9k9adE+HB5GC4TBrYXmsMALOPKLJ1aax5g4jAER3QXzGuVHvnOTAAlWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3y7naHpAF9p3v2ds9u7WID6WFrX4OL4B24YKYJmWrQ=;
 b=QPHRl1UFP3cUOsbrgMAT3UsakrtjCzvGPtBODY8XlceDpynwwV/7fdZuyS2+aN+HoLuVfGGuI142dYO9mxFXzUB12vkv5s0XA/PvWF2G6j9d2R9s5IMqlPmEyMUYBAczNlHwERpEyBnG9gbGlr+vCDF4/rsIWfjHlYzuNdH8KRjdcFMRYC4uE6XFOgOKaKsYwcFej7zKhNd9c1gxFkEhVdIWoVJHhfS9RG5m8Qe+SLaZdUuspct7PkflVftZ45TEvTlGVMXESJAEdTMXIKeI8+FpKCXVlJiBgibVV+5a8aiZ41jdSFsDMqPA13vH3KEG/UEduRurlH1ya8+rmgCkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM5PR12CA0054.namprd12.prod.outlook.com (2603:10b6:3:103::16)
 by DM5PR12MB1180.namprd12.prod.outlook.com (2603:10b6:3:74::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 15:15:54 +0000
Received: from DM3NAM03FT013.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::206) by DM5PR12CA0054.outlook.office365.com
 (2603:10b6:3:103::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22 via Frontend
 Transport; Tue, 12 Nov 2019 15:15:54 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM3NAM03FT013.mail.protection.outlook.com (10.152.82.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2430.20 via Frontend Transport; Tue, 12 Nov 2019 15:15:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 12 Nov
 2019 09:15:37 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 12 Nov
 2019 09:15:37 -0600
Received: from mlipski-pc.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 12 Nov 2019 09:15:37 -0600
From: <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Fix coding error in connector atomic
 check
Date: Tue, 12 Nov 2019 10:15:32 -0500
Message-ID: <20191112151532.8192-1-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(428003)(189003)(199004)(53416004)(486006)(50466002)(476003)(47776003)(426003)(26005)(36756003)(2616005)(305945005)(336012)(126002)(4326008)(86362001)(2906002)(1076003)(70206006)(16586007)(478600001)(8936002)(316002)(186003)(8676002)(81156014)(81166006)(48376002)(14444005)(5660300002)(356004)(6666004)(70586007)(110136005)(50226002)(2876002)(7696005)(6636002)(51416003)(54906003)(16060500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1180; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 053cbabb-b681-468d-885e-08d767833648
X-MS-TrafficTypeDiagnostic: DM5PR12MB1180:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1180418D96DBD60A9B16DB29E4770@DM5PR12MB1180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-Forefront-PRVS: 021975AE46
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prkoecXXlCF7mWjh3KaOcqAjCiQRx9Z0f/TBbgE2yQ8MV1Gb6qCCi+PrU8nMaTghhYxXi/jik8eKOP/BUdYZD+jHRq+GinVtUTInJAr180Fz8cVXWOrjU6nuqbYrOHJYJCQXCPAJk0Lo3Di0P+ONzoBqG/JD9A2ymV82l0AAQdqARLfLBXzNAimuJkylioPwOjCiugJ6z8dR5xxVYne+aBoiikLnYk4hxXeSNiIQMLn6q+t7nCXof++4AVfGmlP9lkaHifK/DnU0pLocZEnr3boTDSXbRR+Ox4A88G7cr+eGJnh/lg4UBS25+Asmb7Xlsl35xFWIvuf7lLS7FRr3spXqOmims1I3WUFU1zcb7qfbHaBmt2O4z1HrdKW8MWbqh3SVcCO2BndFlehNyWcrhkQth+c/hPjfsogZKJWtbyE3lpMamcuzHTjtno450J4t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 15:15:54.4453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 053cbabb-b681-468d-885e-08d767833648
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1180
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3y7naHpAF9p3v2ds9u7WID6WFrX4OL4B24YKYJmWrQ=;
 b=tIWZl2XUK3bk2OHGMe5VkzgSql0wz+o07goq21zYKVK36V2Fq8o1V3vWfi3ymSlfroDZpxpJx+TTSIDQkqCU7wUTSvKQ0FkY4N6cOctZJW+M/H6YhqZDqezXLR98Z4sRZ9k/3lQN9a48fXa404BJP/iTkComjDjFOPBrvB3EMG4=
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
Cc: alexander.deucher@amd.com, Mikita Lipski <mikita.lipski@amd.com>,
 nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112151532.4p8CKWrO1NUVwEfK17uDGqJxEG77ECLLUClqwJj3Kio@z>

RnJvbTogTWlraXRhIExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgoKW3doeV0KRm9yIE1T
VCBjb25uZWN0b3IgYXRvbWljIGNoZWNrIHdlIGhhdmUgdG8gY2hlY2sgYSBuZXcgQ1JUQyBzdGF0
ZQppbnN0ZWFkIG9mIGFuIG9sZCBvbmUsIHdoZW4gY2hlY2tpbmcgaWYgQ1JUQyBpcyBkaXNhYmxl
ZCB0bwpyZWxlYXNlIFZDUEkgc2xvdHMgYWxsb2NhdGVkLgoKU2lnbmVkLW9mZi1ieTogTWlraXRh
IExpcHNraSA8bWlraXRhLmxpcHNraUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX21zdF90eXBlcy5jIHwgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9tc3RfdHlwZXMu
YwppbmRleCAyMWYwOWI2MWVlODguLjAwY2IyZjEwOTg1MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVzLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fbXN0X3R5cGVz
LmMKQEAgLTI5OSw3ICsyOTksNyBAQCBzdGF0aWMgaW50IGRtX2RwX21zdF9hdG9taWNfY2hlY2so
c3RydWN0IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvciwKIAkJcmV0dXJuIDA7CiAKIAlpZiAobmV3
X2Nvbm5fc3RhdGUtPmNydGMpIHsKLQkJbmV3X2NydGNfc3RhdGUgPSBkcm1fYXRvbWljX2dldF9v
bGRfY3J0Y19zdGF0ZShzdGF0ZSwgbmV3X2Nvbm5fc3RhdGUtPmNydGMpOworCQluZXdfY3J0Y19z
dGF0ZSA9IGRybV9hdG9taWNfZ2V0X25ld19jcnRjX3N0YXRlKHN0YXRlLCBuZXdfY29ubl9zdGF0
ZS0+Y3J0Yyk7CiAJCWlmICghbmV3X2NydGNfc3RhdGUgfHwKIAkJICAgICFkcm1fYXRvbWljX2Ny
dGNfbmVlZHNfbW9kZXNldChuZXdfY3J0Y19zdGF0ZSkgfHwKIAkJICAgIG5ld19jcnRjX3N0YXRl
LT5lbmFibGUpCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
