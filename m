Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B05AC432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:23:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B26C215F1
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B26C215F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B5A26E102;
	Fri, 29 Nov 2019 08:23:42 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700053.outbound.protection.outlook.com [40.107.70.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 134CE6E0F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 08:23:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDDYjnpl86Z/7SKeHmXfnsnQWnDiLZ7sGWZyv6nMXn410Xo+903ZcOk/sUtjPEO+IlAekPB9zxTsIz8J4oIvqf99RcaEXFCrGpSlLXZ1jkoGNYzYDVizH6//dpQu0yV229AeKUGAnCBuwxyNrMEYw2EtcWaZmRickAD+IHT7gd/V0g4wxxMnpHBhd5NEW7nuzmOJuzgXhxOYefd+R+vdLwYUitQdGsh1nmJC2mrNsv444BRtB4QidPRn+QOOYWxkAq9EuibmpXmF7P2bjghmL+ktiTz3N174b+Ysj/+uwsUhoW5b3u6FXc0ZectgjiXOASUjGAaoE1hpmOtHpYuUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO35hzTaxHf8ee+ZSCBhNI6coSmSxw46YLPYOCILdxI=;
 b=Q1o3XhPGZkoIHub+m5FmWim8svDov7aWSKkY20Tvl/m6Pp6ePwK9etUZ3zErtoSCEmSAmiciMMNKh7qXMspg3AtxMPXxPNIKG+gDAKIbGSef2i775Oo1k+aOS1eLinvH4tcpT8e8YkhI2w6xn8WIDO9yGSx2Aja0q81gBTSu5vK0TgyP5e32BcfK+fe+SscFcrD6J/N66M9pHsGtkVU8iyijZsBYZuH5zJMvHH1DBtNaKgISx6V06T58c8eF2pgRMMhpiQWvfD/VKzUeXprtGQT3bclA9oZTEpKtxcDpwtH0GszF/rt8BZGnVRrxNyls/1WdKlVwNpbGRSKwXwCarA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN6PR1201CA0014.namprd12.prod.outlook.com
 (2603:10b6:405:4c::24) by BN6PR12MB1634.namprd12.prod.outlook.com
 (2603:10b6:405:4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17; Fri, 29 Nov
 2019 08:23:36 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::201) by BN6PR1201CA0014.outlook.office365.com
 (2603:10b6:405:4c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2495.17 via Frontend
 Transport; Fri, 29 Nov 2019 08:23:36 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Fri, 29 Nov 2019 08:23:36 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 29 Nov
 2019 02:23:35 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 29 Nov 2019 02:23:34 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: fix GFX10 missing CSIB set
Date: Fri, 29 Nov 2019 16:23:31 +0800
Message-ID: <1575015812-26634-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(428003)(189003)(199004)(70206006)(8936002)(50226002)(2616005)(16586007)(4744005)(426003)(6916009)(81156014)(316002)(81166006)(336012)(70586007)(8676002)(36756003)(7696005)(4326008)(26005)(2906002)(5660300002)(2351001)(47776003)(53416004)(6666004)(478600001)(86362001)(50466002)(356004)(48376002)(305945005)(51416003)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1634; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51d96b1c-a58a-4814-1234-08d774a56e18
X-MS-TrafficTypeDiagnostic: BN6PR12MB1634:
X-Microsoft-Antispam-PRVS: <BN6PR12MB16344B5194052BE25607DA5484460@BN6PR12MB1634.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0236114672
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4Hmf91bVoOslfR31NsJyWUdMbshaWG/Lba0ixrD7ta9GKRpfKWMeVVzT5uVAheqGWOIcylDutlYo9SO2oGWERhLfNUv7+spcl2fD4kfC6fepbBFooEbGX1z1d493vMqgmMIvSKiNM+Ne6JrLmAq1JIZRVSr5OqbshcnoJWd0p4iB6QvqwgkGaa5CYH3dxynhz5u3J4npu4GSzC+0kgs1Yfz3VJ8p5ICLfWZxg0cwFdiN+h10imM744noC5e0QtWEk2ooVGnHJJcKH4YW8pXPOqexen2g/7lX1yd92TVffp5bUAhXQTVuEq1YfA1FbG0avN2E1L2jaH2x56MgRlLa0KlelC5/SsPJ4Q2CB2ED4PfHOir8pbqm7Xijcins3mao2z0Vth6mrIVr9hIWDpw+A31hOWNazLhP/6bekryvk6EgBhB/Z3xco/ebrH5nIZM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2019 08:23:36.0881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d96b1c-a58a-4814-1234-08d774a56e18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1634
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO35hzTaxHf8ee+ZSCBhNI6coSmSxw46YLPYOCILdxI=;
 b=FHNoR54Zji7UxpBbJ1f7xXtZ7QLMUSGlGVW2+YLz697puoa8jFZlF6SF5JRzS3g/hA+DU+EZtnCqjQ6M1zoIWQrm7xBma2ulWyhiwFj2YwKJn/I168J1UUmK/nWe31ioaqmgO7fv5G6kc9bydixbYamY+n9hLlEYbKObAnDWNjc=
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

c3RpbGwgbmVlZCB0byBpbml0IGNzYiBldmVuIGZvciBTUklPVgoKU2lnbmVkLW9mZi1ieTogTW9u
ayBMaXUgPE1vbmsuTGl1QGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3YxMF8wLmMgfCA4ICsrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKaW5k
ZXggNzRlZGZkOS4uMjMwZThhZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3YxMF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8w
LmMKQEAgLTE4NzQsMTQgKzE4NzQsMTYgQEAgc3RhdGljIGludCBnZnhfdjEwXzBfcmxjX3Jlc3Vt
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
