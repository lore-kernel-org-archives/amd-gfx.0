Return-Path: <SRS0=RIuP=ZV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6FFC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A114521781
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2019 08:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A114521781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A4D899A3;
	Fri, 29 Nov 2019 08:27:39 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770058.outbound.protection.outlook.com [40.107.77.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5345A899A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2019 08:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yb5WBvhUUq53Vex1dg5/I/wKcHt5ocuzQijTBRmDG1DOmsNoSkeHBciexpSxn2Pwg0O3EulPTuvGFN36dBs21RNppp6wsP0V/cjkYSqmPNRGEqd5Ah43GcQL/KBofoq1ZzqPqDm84R4yUWxKG7AhMZ5vSjDayolz/8GgTVLrVjaNthl+Ri3dO6KzsS4116I+9Eu8hTtk4Ye4pRYjOGy7hwfPDvYhbkNZBYoAEujVlemPgqXvMYyDrp5BNEFbzdjHb9QPkGRcyg75NIeSi4B7VJ6CUtCZkxMLUAO4/Wx6cXdlEDM52LRlPxuknLQRBW2t9Qw9yXgs7ReHwuoA5r7qqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M26Sp83bBQMbpdtaLnhquAenkvrF2x8dZS2XSWEWEI=;
 b=QNsDxMNkoDv94fd1kfEldLJalzcYO4+1U1Lc0nDd822aPakY7kElx2R9uM9NQ4CLohBYdXBPSFy/9x3gZLR7nnh6xKN/GD3b+CxOrzsQcSHxxRno3b7GMiCFn89Q8UQNmB97haVUD2q3ZPjZ64pWYrj44H55qm53/fow5jHwZ8atiMPk493XJyjoml5jZVZEeA3NfyvfrjfPacFCzOtKN8fkB3XEkJN9SHhdBXBJ02uoEjPche7wGjj8OpGb0LzE1gTOc3Pm/X5MmWJcLwuqDzTZzn564RlP1P7GWOjXHKWQud3aUj3HaFHAN9SamAdyaBGym8pHI+GLWD9NO5fVGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0088.namprd12.prod.outlook.com (2603:10b6:0:57::32) by
 DM6PR12MB3338.namprd12.prod.outlook.com (2603:10b6:5:11f::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 08:27:36 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by DM3PR12CA0088.outlook.office365.com
 (2603:10b6:0:57::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17 via Frontend
 Transport; Fri, 29 Nov 2019 08:27:36 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Fri, 29 Nov 2019 08:27:36 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 29 Nov
 2019 02:27:35 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 29 Nov 2019 02:27:34 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: should stop GFX ring in hw_fini
Date: Fri, 29 Nov 2019 16:27:32 +0800
Message-ID: <1575016052-26775-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(428003)(189003)(199004)(336012)(70586007)(5660300002)(70206006)(48376002)(8676002)(305945005)(2351001)(50466002)(81156014)(26005)(16586007)(50226002)(81166006)(316002)(8936002)(53416004)(186003)(7696005)(51416003)(4326008)(2906002)(36756003)(4744005)(47776003)(356004)(478600001)(86362001)(426003)(2616005)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3338; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f477bdd-24bd-4238-69fa-08d774a5fd63
X-MS-TrafficTypeDiagnostic: DM6PR12MB3338:
X-Microsoft-Antispam-PRVS: <DM6PR12MB33388964866D74C223FCFD9584460@DM6PR12MB3338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:249;
X-Forefront-PRVS: 0236114672
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ij3COB46sqO80d/zzZT5vMGUCoR3KP4CG4d56y6788kmdlJ8BrnG/4QChZ3+K/5HqNNYFHoxg3p5/2mwyenDre8QMQ08Y3mjJHfbU/LvC3l6AYyMCzsmj5F2XoZmRTvdgRf6ouMTUxIfk3iHMPfl7/XoRbnvofBVzEuKWs5ooGJNKceSK5KCn3hasoFUCddlVzpF+RnLcX1ykefplQKIH4sNhFIOqmdF+LJoCpwz4fPHcISV9YmShAIeJPmrIYNApO/abZ3j1/5siy3/R1c6wqL1+sTyJsHrk0aYqGfgPmU3Dc3CDvu+HeVCG+q8Bh31BF81o4vUw11ulsZa1X9meeatE623GONKGp20vSciy6Ru9/rAJwpAAQi99GVl21w5LLKtYqBfcT/aLHxlOdR46nqlz1OsTrbD+Okyb5X1+yvNii7fJRZ43vIO2TI73XqH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2019 08:27:36.4200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f477bdd-24bd-4238-69fa-08d774a5fd63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3338
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M26Sp83bBQMbpdtaLnhquAenkvrF2x8dZS2XSWEWEI=;
 b=dUZRosGpt2FHrz0lhZZBE0+2rGV+EKH9TIZdUM524Q8SsKApjzH0OkhmMYgBuuBsY3J1Nch4eIVA9aEtDEzS4Pg4nSBU8Jkr0R2I0S26BOR1gFb/ZS9yixPiPTSxQ1KEADqC2K0PM3cC/7zHu8ii8gev3YSA8urf0wDXAXKTn4I=
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

VG8gYWxpZ24gd2l0aCB0aGUgc2NoZW1lIGZyb20gZ2Z4OQoKZGlzYWJsaW5nIEdGWCByaW5nIGFm
dGVyIFZNIHNodXRkb3duIGNvdWxkIGF2b2lkCmdhcmJhZ2UgZGF0YSBiZSBmZXRjaGVkIHRvIEdG
WCBSQiB3aGljaCBtYXkgbGVhZAp0byB1bm5lY2Vzc2FyeSBzY3JldyB1cCBvbiBHRlgKClNpZ25l
ZC1vZmYtYnk6IE1vbmsgTGl1IDxNb25rLkxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCmluZGV4IDIzMGU4YWYu
Ljg4MmNmMWYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBf
MC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCkBAIC0zODA5
LDYgKzM4MDksNyBAQCBzdGF0aWMgaW50IGdmeF92MTBfMF9od19maW5pKHZvaWQgKmhhbmRsZSkK
IAlpZiAoYW1kZ3B1X2dmeF9kaXNhYmxlX2tjcShhZGV2KSkKIAkJRFJNX0VSUk9SKCJLQ1EgZGlz
YWJsZSBmYWlsZWRcbiIpOwogCWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsKKwkJZ2Z4X3Yx
MF8wX2NwX2dmeF9lbmFibGUoYWRldiwgZmFsc2UpOwogCQlwcl9kZWJ1ZygiRm9yIFNSSU9WIGNs
aWVudCwgc2hvdWxkbid0IGRvIGFueXRoaW5nLlxuIik7CiAJCXJldHVybiAwOwogCX0KLS0gCjIu
Ny40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
