Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3649C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 11:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7036720722
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 11:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7036720722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E7206E098;
	Tue, 26 Nov 2019 11:50:37 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730070.outbound.protection.outlook.com [40.107.73.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7B36E086
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 11:50:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfpUqNLW2t0onsWMvjKDpCCq3/P6mltkxPLuJse8qUiIBux+HRgdVGbkqZZunmIVGYDut63TO60LGb1eR6BX5jpKYyq+kTgoLFsgr5DVwMaXZPCtB9Dyf6WxX87VZe2wcI6Bbl5NmJcD/rSFFyOdwBwc+LtXoFKZJYlbGtHHWGXCfP5IkLUCXI5132vyYdxjTIW3rhBrEEKlcC6IVZ0aCbckBWJVHzhR9Zbt8fMLqDxD5w7p9Um8O+usvFYZxcMcWs/jhrUC+RsULaE/U+uYrP9Z5EznnZNbEwRh0BtL5yDi8lO+XTSYHtjlzKls0N9P4uZyHVqHxOqQXPziWfcjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dItcYrI+jv6wEMBcoSKI5RIt8cj9FYNrphRUMPF0VFo=;
 b=Jubfu8RCQsQTaI5wvuMIEjRv8EPkKpcEv8+F/XFCGV8+Vh8lVjsTpf04vmBPTqz82YRfu801/MVA1axR2hs98hwV7d/x5AL2jMfZGkm2AbbmV31XdLSVZ0Um2ljYDiCoRqUC4wFdOU7TXSVBmLaCQBlsrH/wdEad3CsejOmbxRJoPQ4p1rxFuVevDSgDvzhJ3QvytQOpKVGBiMQA454MVxjErH9DDxQLyTrOOEnxXBUnLRGhrRUijE9GI8Polfx2fZBYWYadqzPAhRAFP0VjBTakfHOdZe8Kzkicrih4dkLaX/0mM9Z0nk7kDY+CtpZmaYBveCwik/xpS4vou3LXZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM6PR12CA0033.namprd12.prod.outlook.com (2603:10b6:5:1c0::46)
 by BN6PR12MB1811.namprd12.prod.outlook.com (2603:10b6:404:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Tue, 26 Nov
 2019 11:50:33 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::202) by DM6PR12CA0033.outlook.office365.com
 (2603:10b6:5:1c0::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2474.18 via Frontend
 Transport; Tue, 26 Nov 2019 11:50:33 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Tue, 26 Nov 2019 11:50:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 26 Nov
 2019 05:50:32 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 26 Nov
 2019 05:50:32 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 26 Nov 2019 05:50:31 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu: fix GFX10 missing CSIB set
Date: Tue, 26 Nov 2019 19:50:20 +0800
Message-ID: <1574769024-30611-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(428003)(199004)(189003)(6666004)(356004)(81156014)(478600001)(50466002)(6916009)(8936002)(47776003)(81166006)(50226002)(2906002)(53416004)(48376002)(8676002)(26005)(86362001)(16586007)(186003)(2351001)(70586007)(70206006)(51416003)(7696005)(5660300002)(305945005)(4744005)(4326008)(336012)(2616005)(426003)(316002)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1811; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b50e47d3-84b0-4dd8-0736-08d77266d829
X-MS-TrafficTypeDiagnostic: BN6PR12MB1811:
X-Microsoft-Antispam-PRVS: <BN6PR12MB181140674F33667D7CCAC4BA84450@BN6PR12MB1811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0233768B38
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8yk6/spkDKzrM/vloq3x+AI1FKx+ABPz7NjkQuWndhaSWNakwnMrCdjsyeBRsygARPsyUH03dQvaPOyHmqetUXOGZf/Q5W10nx1lssO1Baipa5mdEsdWbzmpCPuWc70qBNywSnccRdmM5TFyznkrZTERz+HnUDWK0WgmFmQyHGvzoFG2/0xrIJTLdx3wWvFwp44d+BSnUgrGaxi7EDwXZrB9N1d5HKXy3IARVDeRsEdBeNOGx6eZAGLuuGDJ1C2TsagdH/2RU0LfrhwcZa6G8aAsM7hXaTP6fBO9CSHjzk9iXpUZLNMATm7nPHCJGoN+zyquUMRtZkgZt38L7EO8HRt5Xea8Rzwtc/6lqfktcn6djqyY/xOmVkSDHdGWOrdImFpCyyegh3ModiX0lgVDYbolbnwPvXjFz2pZbC2OYpR6dNW6tIJ05Pw25F2OKSLr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 11:50:33.4172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b50e47d3-84b0-4dd8-0736-08d77266d829
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1811
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dItcYrI+jv6wEMBcoSKI5RIt8cj9FYNrphRUMPF0VFo=;
 b=TvltrVdyeS3WFtZJTD3jlYLxdzSDHAk+DSpKH5b4LB/KMV+EL2EV0JxRm+IpW75Lhta0ZADL8BlOtA4jWGldjsXZHa5nRK3LRJZ8NapRPJi/qMxydJ+4ZUgDVk1v3Z1vWT3Tc1FWwKgyXx06oSRprvMBFSxmV9A6IoNsaqXOqfs=
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126115020.WJRZOvvbRTodbXpBNmG9CLIDz7Sx1BA5Ym9Zv9r1Kz4@z>

c3RpbGwgbmVlZCB0byBpbml0IGNzYiBldmVuIGZvciBTUklPVgoKU2lnbmVkLW9mZi1ieTogTW9u
ayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3YxMF8wLmMgfCA4ICsrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKaW5k
ZXggNGQ2ZGYzNS4uODc5YzBhMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3YxMF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8w
LmMKQEAgLTE5MjYsMTQgKzE5MjYsMTYgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfcmxjX3Jlc3Vt
ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAlpbnQgcjsKIAotCWlmIChhbWRncHVf
c3Jpb3ZfdmYoYWRldikpCi0JCXJldHVybiAwOwotCiAJaWYgKGFkZXYtPmZpcm13YXJlLmxvYWRf
dHlwZSA9PSBBTURHUFVfRldfTE9BRF9QU1ApIHsKIAkJciA9IGdmeF92MTBfMF93YWl0X2Zvcl9y
bGNfYXV0b2xvYWRfY29tcGxldGUoYWRldik7CiAJCWlmIChyKQogCQkJcmV0dXJuIHI7CiAKKwkJ
aWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkgeworCQkJZ2Z4X3YxMF8wX2luaXRfY3NiKGFkZXYp
OworCQkJcmV0dXJuIDA7CisJCX0KKwogCQlyID0gZ2Z4X3YxMF8wX2luaXRfcGcoYWRldik7CiAJ
CWlmIChyKQogCQkJcmV0dXJuIHI7Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
