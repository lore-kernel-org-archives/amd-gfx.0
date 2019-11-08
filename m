Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225FCC5DF60
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 10:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F082178F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 10:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F082178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD666F916;
	Fri,  8 Nov 2019 10:23:44 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730049.outbound.protection.outlook.com [40.107.73.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FC3D6F916
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 10:23:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1PvKqixvw+fbceIRIaUrTXizah4lTrfydBGJywcm8lKuRy8BRURrOdet3gqFn+2qWlUjyYdCSpZgkfr5D0htbWPS2LqEEetpLwubQDV1i2DyMVvAda/GIkVmJ0Q7qYOw0VC70aj1Pqabey1TlcSmIoFQ+ql2Z5VIaYIE45u1hLrAxonEK90DeKGVup2ng6yyKMWPCpVw54i9yewomhFN+16aH23+J/VegkLDTUtfimAb8X22Gtsjhp50YMmLlAG1DGT+EEU7oPWRM2trY0cKVYDpQBXG4p234LS9fmwgwkgDLjarHz+0e5hGm06cKAmPKQbrU3dDFjI3j/3pS43TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlwI0FIdNxMlcHrRgup0PTywo3VJuqygHIlBzUMudZI=;
 b=Ieb6JSPBnsRypz5Kdjmij4zj25Uqrbl83DcM4PoelR4LuV89U3q0NF+AGImytUrJ6dFHLl9eLXv/myfHAaohTOPpz4Xtr3NFAFA40tch1yVxqBXalIwfqrFSK342lWOLvBz67VcsoRYI/LeR7xaIlwTiTM/Kx/+YwYwQHGhtfLRPad4DDJ0YUeq3Fg2gjgNZqOOxB+lOxi0QYIqdyW2gpctkyv2l72ZeUIX1bQQrSmemYPtlVKL4TtOpX/uOmNnJ6cJv1BiVZDQQoWtcTNu26Ip16hZOTuUdCKi5MyotUnS529tgnZqFc8Z9V5OX0lOgVLj6jy9pQuB7GFH5VSb6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0138.namprd12.prod.outlook.com (2603:10b6:0:51::34) by
 DM5PR12MB1482.namprd12.prod.outlook.com (2603:10b6:4:a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Fri, 8 Nov 2019 10:23:41 +0000
Received: from CO1NAM03FT061.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::201) by DM3PR12CA0138.outlook.office365.com
 (2603:10b6:0:51::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.23 via Frontend
 Transport; Fri, 8 Nov 2019 10:23:41 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM03FT061.mail.protection.outlook.com (10.152.81.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2430.20 via Frontend Transport; Fri, 8 Nov 2019 10:23:41 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 8 Nov 2019
 04:23:40 -0600
Received: from jesse-build-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 8 Nov 2019 04:23:39 -0600
From: Jesse Zhang <zhexi.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: finish delay works before release resources
Date: Fri, 8 Nov 2019 18:23:37 +0800
Message-ID: <1573208617-16260-1-git-send-email-zhexi.zhang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(376002)(428003)(189003)(199004)(6916009)(70206006)(36756003)(50466002)(478600001)(26005)(186003)(4326008)(86362001)(81166006)(81156014)(305945005)(2351001)(7696005)(50226002)(48376002)(51416003)(8936002)(336012)(5660300002)(486006)(47776003)(8676002)(476003)(356004)(126002)(16586007)(316002)(426003)(53416004)(2616005)(70586007)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1482; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63ecf174-41cd-46bb-b575-08d76435ba16
X-MS-TrafficTypeDiagnostic: DM5PR12MB1482:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1482F95E15E3E6BFFB0E93FAEF7B0@DM5PR12MB1482.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 0215D7173F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3FDvVV4WUA8zjUXgPKXoS+iYDxNARtF4G23pXDBMGNvAHSFmrjgEXGoOQ40YSipmnipNUS3G2DcTdcwuYAITHUim9ViAns/hsNVrDi+R6MgpTidtsuF3ZEB/6cHVG8ADkRpj65XtEB8J3rRBcTqZyK1BrUTzuOveJ5GeYiSFvD+K8IhhEynXDkRGJfT4QQ8zIUSRPIKjKsf0iX6pwLLe0ef8rrditV+3OHqIi4YkDMCVl8dOK89TQQWVc7QGnCVDmAW4Xd8NKzw6IpeIE7skVKymvRGXMQYIqbWgQCgBl4aNdBaX49n8b+OZNb2ztlEP4B/Dkv2nK3wHObiwAQr1e3DOvg7oThQXgbBktMvqQIA7tfTYUoJ35kuT6Y0tMccpAQqi419xWkPAfegEjWmwLWO2xhxirJ6GM9bFcToHZJaWdhtG+cfzO95jhoSOBGE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2019 10:23:41.2677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ecf174-41cd-46bb-b575-08d76435ba16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1482
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlwI0FIdNxMlcHrRgup0PTywo3VJuqygHIlBzUMudZI=;
 b=hTZBpqXdv/T82jcOPBDianw2OTN7A6O45e9Oix+Z0JgYw23ipBDaTkNsEM8U9m4Icir9EXAWBY7P/Ts5I2cCZbLKxKKdgE2O0K5AIQCuRR4Y2XTLjA3ZRZwfxiYuuCmkOzxBZ6+V6BWBxIx5UNvfoW8rV/EBK8Z63ulvb833VC4=
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
Cc: Jesse Zhang <zhexi.zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108102337.Hw5v_rqjpo9cgO-BqbbfU5jKTrP-mIvv3RhBciLXDbs@z>

Zmx1c2gvY2FuY2VsIGRlbGF5ZWQgd29ya3MgYmVmb3JlIGRvaW5nIGZpbmFsaXphdGlvbgp0byBh
dm9pZCBjb25jdXJyZW50bHkgcmVxdWVzdHMuCgpDaGFuZ2UtSWQ6IEk4NWI3ZmZiYjM0ODc1YWYx
YzczNGNiNDU3M2E2ZWNjNzFkMzlkNjUyClNpZ25lZC1vZmYtYnk6IEplc3NlIFpoYW5nIDx6aGV4
aS56aGFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYyB8IDMgKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMg
ICAgfCAxICsKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2UuYyAgICB8IDEg
KwogMyBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKaW5kZXggMDMyODdkOS4uNWU1NTc4YSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwpAQCAtMzE0Niw2ICszMTQ2LDkg
QEAgdm9pZCBhbWRncHVfZGV2aWNlX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAK
IAlEUk1fSU5GTygiYW1kZ3B1OiBmaW5pc2hpbmcgZGV2aWNlLlxuIik7CiAJYWRldi0+c2h1dGRv
d24gPSB0cnVlOworCisJZmx1c2hfZGVsYXllZF93b3JrKCZhZGV2LT5kZWxheWVkX2luaXRfd29y
ayk7CisKIAkvKiBkaXNhYmxlIGFsbCBpbnRlcnJ1cHRzICovCiAJYW1kZ3B1X2lycV9kaXNhYmxl
X2FsbChhZGV2KTsKIAlpZiAoYWRldi0+bW9kZV9pbmZvLm1vZGVfY29uZmlnX2luaXRpYWxpemVk
KXsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYwppbmRleCBkMWIxMGI1Li4z
MjEyOGU5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZk
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3V2ZC5jCkBAIC0yOTks
NiArMjk5LDcgQEAgaW50IGFtZGdwdV91dmRfc3dfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKIHsKIAlpbnQgaSwgajsKIAorCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmYWRldi0+
dXZkLmlkbGVfd29yayk7CiAJZHJtX3NjaGVkX2VudGl0eV9kZXN0cm95KCZhZGV2LT51dmQuZW50
aXR5KTsKIAogCWZvciAoaiA9IDA7IGogPCBhZGV2LT51dmQubnVtX3V2ZF9pbnN0OyArK2opIHsK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2UuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2UuYwppbmRleCA5MmFhM2IxLi5mNzBi
NTVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNlLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jCkBAIC0yMTYsNiAr
MjE2LDcgQEAgaW50IGFtZGdwdV92Y2Vfc3dfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKIAlpZiAoYWRldi0+dmNlLnZjcHVfYm8gPT0gTlVMTCkKIAkJcmV0dXJuIDA7CiAKKwljYW5j
ZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYtPnZjZS5pZGxlX3dvcmspOwogCWRybV9zY2hlZF9l
bnRpdHlfZGVzdHJveSgmYWRldi0+dmNlLmVudGl0eSk7CiAKIAlhbWRncHVfYm9fZnJlZV9rZXJu
ZWwoJmFkZXYtPnZjZS52Y3B1X2JvLCAmYWRldi0+dmNlLmdwdV9hZGRyLAotLSAKMi43LjQKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
