Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C12C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 12:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79238223D1
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 12:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79238223D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DE8D6E512;
	Wed, 20 Nov 2019 12:36:58 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720070.outbound.protection.outlook.com [40.107.72.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 964666E512
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 12:36:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/jjxS9hMGDkx5L23u1ASjG9kGc/2e2ikipN09kh0h3msCxTrN+3n9eIpnQYruxhLki4xMj87ywaF1C5OFgCSyNtcVopn6/9aHk+R1yqWRqj+1N4KoRMSnbeosw+GfxAZspE40bXNaxnNHkwRvt3thk9oLjTqCKYbFyk2DISpXJ3Q14AUY/DBYmJzPkHxNrMPoBTznQD/ccQ+MppsTzAIy68vaF/6F4BsaawjdiKLRTCDv5LZpmn94c6DLJDkirlzy3kaXxtwUmXPKk9VX1Itj5EJcsQElm2sHAX3/mGtDt4+7i7iwRSqvr+GqwCp2hUZkByPG6Sbm/3jxOWAmHMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1agxSuLUJ0tDA+3+/IbFhaIF1Nj/zuARWCxN0/N5DMA=;
 b=IaURiJzQcUrJVn/udyPUJPNu8y+gIH6hGJuI/mcVTwrluUQj36myDE/3tFJt0vH0J7OD49QBSDKwfraikDKfxfrJoFHR51QFT0eLFhjmyB+QZv8FEOtvYKDPK/VP+maVCOorV8FE15Lu5uJu379tLubou6cynFyQaBqbOZhBL/o8p16MoVKFM4OhTaCymeMJ0D8SpMKebZmPLVx5i43iRlTpZXN68KM78vZ5OEnqPUhSevYUdVRDq9Me3Ev78gc7vA8MES3F5UejaIYtZhgaUuIyRxz27q7t8A0/q3fQfzRRbT1xwuYVN7+Kb7eIMMAvACuWE4VBz17XftLd/SV9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0059.namprd12.prod.outlook.com (2603:10b6:0:56::27) by
 MWHPR12MB1230.namprd12.prod.outlook.com (2603:10b6:300:f::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 12:36:52 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::203) by DM3PR12CA0059.outlook.office365.com
 (2603:10b6:0:56::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.23 via Frontend
 Transport; Wed, 20 Nov 2019 12:36:52 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 20 Nov 2019 12:36:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 20 Nov
 2019 06:36:47 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 20 Nov
 2019 06:36:47 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 20 Nov 2019 06:36:45 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Guchun Chen <Guchun.Chen@amd.com>, "John
 Clements" <John.Clements@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: apply gpr/gds workaround before enabling GFX EDC
 mode
Date: Wed, 20 Nov 2019 20:36:43 +0800
Message-ID: <20191120123643.16416-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(428003)(199004)(189003)(53416004)(86362001)(2906002)(478600001)(36756003)(48376002)(110136005)(50466002)(50226002)(47776003)(16586007)(316002)(8936002)(81166006)(81156014)(8676002)(4744005)(5660300002)(186003)(26005)(4326008)(426003)(7696005)(51416003)(356004)(1076003)(476003)(126002)(2616005)(486006)(70206006)(6636002)(70586007)(305945005)(336012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1230; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d4cf975-6a90-4695-1403-08d76db651c2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1230:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1230BF1C304A34872EF4889EFC4F0@MWHPR12MB1230.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 02272225C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HXbamHyaSJVTYdPyoTZ39zcN3BpMKgajUj19igIJlg/nDnqN5L050jK2FGM0X1dalv/pN7dfESWo01XkaSXSdZ2yz6WEEk0nhwKdgaDCRdj1EL38zqbcZdo7Rxc4YhkStcQ/16Bt5XbTOw7lS+aXqJOHsB+xx3uTdEJ5Biekfmlt4ZxTHext/rU+MX7KyPdNt54JXeMpyygncrVRvurKtW4BJdWn1uw6Z/VprITn8GPhmIH+09d1t+oUYF/THfJE6wWxgcw4s9fqrT0ZlqK9QtwWq4mkGJCr7TNMoeV0dpFs3efbRnyTbdwrfbAGJ+NEGBfkTxi+JWvJ4IgX0CJKWjQjd+Q6PRIyy1cKoPc2yH449WYVrPGnEKg9SgG5TjtYvgg4gI4C2rnlrUpvOn1PQeRGxQG/muTt0/7O9OLBeCl4BjvhGlIvMjX4vxo6hOp+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 12:36:51.7732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4cf975-6a90-4695-1403-08d76db651c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1230
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1agxSuLUJ0tDA+3+/IbFhaIF1Nj/zuARWCxN0/N5DMA=;
 b=2bS3WdrC8KNnT528I0Sf2k2pnH5Y3a6U99SDNnsYBVhf9hV1kEnCuJ6AV3fUyCFIY5VSdMG9Q4FDjjNgfXFfz/gFEgn5BFAmdy5FJrOU88qsIB8wFd9yPEvvHxIRaqdR6jTb3bcvGHUHPR2JMgU9K7sDh033TtkklnW+cB192bY=
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120123643.eRZa6JSwCz5_4QHgZ5qsSU3xZBCqJ3DRZa30YxfOaHQ@z>

Z2Z4IG1lbW9yeSBzaG91bGQgYmUgaW5pdGlhbGl6ZWQgYmVmb3JlIGVuYWJsaW5nCkRFRCBhbmQg
RlVFIGZpZWxkIGluIG1tR0JfRURDX01PREUKCkNoYW5nZS1JZDogSTI0OGEwODczNjRjYmQ5ODU4
Y2JhMzJhNzBiZTQ1NmFmM2YwN2M5MGQKU2lnbmVkLW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3
a2luZy5aaGFuZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OV8wLmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCmluZGV4IDBkNjk2
NWJhN2E4Ni4uNjgzNTkwNTllMzkwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8w
LmMKQEAgLTQyMTMsMTAgKzQyMTMsNiBAQCBzdGF0aWMgaW50IGdmeF92OV8wX2VjY19sYXRlX2lu
aXQodm9pZCAqaGFuZGxlKQogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBh
bWRncHVfZGV2aWNlICopaGFuZGxlOwogCWludCByOwogCi0JciA9IGFtZGdwdV9nZnhfcmFzX2xh
dGVfaW5pdChhZGV2KTsKLQlpZiAocikKLQkJcmV0dXJuIHI7Ci0KIAlyID0gZ2Z4X3Y5XzBfZG9f
ZWRjX2dkc193b3JrYXJvdW5kcyhhZGV2KTsKIAlpZiAocikKIAkJcmV0dXJuIHI7CkBAIC00MjI2
LDYgKzQyMjIsMTAgQEAgc3RhdGljIGludCBnZnhfdjlfMF9lY2NfbGF0ZV9pbml0KHZvaWQgKmhh
bmRsZSkKIAlpZiAocikKIAkJcmV0dXJuIHI7CiAKKwlyID0gYW1kZ3B1X2dmeF9yYXNfbGF0ZV9p
bml0KGFkZXYpOworCWlmIChyKQorCQlyZXR1cm4gcjsKKwogCXJldHVybiAwOwogfQogCi0tIAoy
LjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
