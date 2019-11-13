Return-Path: <SRS0=4UxD=ZF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC8DC432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 22:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231E12063A
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2019 22:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231E12063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E956E104;
	Wed, 13 Nov 2019 22:45:36 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680065.outbound.protection.outlook.com [40.107.68.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58596E104
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 22:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2suSZ8Io/j/BOKPYu39Cd0rFvTm6hVfkNkMS65ufwg6GRTREji8x7qYpvNEpdSN6sJTwQPRRURjaX3/ewEYj+EG4kc3bZOXHFhhdZ6JUrXqiOBRD8C4VnsBPuTkJj55mqwwxRSOmPX37RFYnBXmLPOcnzC3NsOMHN4/GVt0NF+fjVUuYDy/9ujfYq+kQbHF/SftvPP+PP9Yc/PAEtGvLIu86rhPhwMM7eA4rmSr/n7idjC9fwO08/fY5nMOt2nQuLEJLeFWDKeNWjByD10wDTa5SH/CZky2o4tpoii1XMvFS2GrnqBqYpnJazlhFMQaNk5yJHOW6sRw5oboIO4Qdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tryLyU6FKYicpIyVvWCAWLdgKfmRUbYF7lKiEjB8Awg=;
 b=Hm5PNbRodJSXwYFNaKdRRBJOgCUiwp0emztqr45CKCiqVYjmXOkEtjo0m2sP/5HNqvhrhnsAgvndfKsmw045EnTeD9hxl6D3N80iVBBUdIPnzAfIeBoiZwgqhe0+wtP02DWC/0F0+rMCK7wbfVar4IJcYarHYUaa2GEaxTWrlJRF5ukekC525Uba4mLp0hd2BZ/TOsg0AkcyjrH5DO3/6Tq9r5hW+pI7zRRJevYjp4DLlGfJ+MSmypuC4VggP25YOTnDAzLVMN9iPheN5guVViXtNeWQcseHfVDYYSI3ssbrT+LO9h67t97U2Ksy9rbABTJfBgEyk9DKLg+U5n3q/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from BN8PR12CA0020.namprd12.prod.outlook.com (2603:10b6:408:60::33)
 by DM6PR12MB2780.namprd12.prod.outlook.com (2603:10b6:5:4e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Wed, 13 Nov
 2019 22:45:29 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by BN8PR12CA0020.outlook.office365.com
 (2603:10b6:408:60::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Wed, 13 Nov 2019 22:45:29 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 13 Nov 2019 22:45:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 13 Nov
 2019 16:45:27 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 13 Nov
 2019 16:45:26 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 13 Nov 2019 16:45:26 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/ras: Extract amdgpu_ras_save_bad_pages from
 amdgpu_ras_reserve_bad_pages
Date: Wed, 13 Nov 2019 17:45:24 -0500
Message-ID: <1573685125-2335-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(428003)(199004)(189003)(478600001)(26005)(54906003)(8936002)(186003)(336012)(51416003)(7696005)(5660300002)(305945005)(6916009)(2616005)(476003)(4326008)(426003)(316002)(16586007)(86362001)(53416004)(356004)(50226002)(44832011)(8676002)(81156014)(486006)(126002)(36756003)(47776003)(14444005)(50466002)(2906002)(48376002)(70206006)(2351001)(70586007)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2780; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16acf38b-057e-4ab4-12cb-08d7688b2ead
X-MS-TrafficTypeDiagnostic: DM6PR12MB2780:
X-Microsoft-Antispam-PRVS: <DM6PR12MB27803B0E6E38D6DDCB9CE5EFEA760@DM6PR12MB2780.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0220D4B98D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 69HCAJDhz+/NHuszd1zVglch5uGNsjr1IJvoJXpkd7PGJohpHOywaDE9MBLY1+JHuBcKqehRC/mYJPFLfpU/kTGVdyPvmHlytt30jbEdgQurqbs1LJx9PULapk2HZYQusgMPYQ575RjQRxPH3x7J6CoIPHc1ZU+u5/lT6aAu//L2QL6D5z0+TaNXeKE8vodwm7PIULTDLNyeTShop/wPrMzXeKa3WRva3Ekl23OOyuJ0VPkQI1KO6MI6DWKo4AcSklZIMg3lxoGu1hBdBI/dcUbY27hBkwfp/YOVuL7RhsSzeyDC9kVtvQhXJTisW3piM+Q/0+XBvOGJbGW53BToCSqfHShS1JPUvXaYdUCmxbNr2+SrkFxUVPjNecqPH7RK8sZKHGCkdvqkCGApGOlJB+UYpBUutWZe+J9DCns+FWZF1McOkn/YAm72Obg/BKY4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2019 22:45:28.7476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16acf38b-057e-4ab4-12cb-08d7688b2ead
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2780
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tryLyU6FKYicpIyVvWCAWLdgKfmRUbYF7lKiEjB8Awg=;
 b=SIUAIY8KlfSYLVW/zbXMfaEKXvcJ6N562SmXT39ZverLVtmoeZ7Xi9aHCEQXGbWEhu3lpRdEQGJlbViON/jY7WudPJr7FwT9lsE4BBuCKcz4S4/M4FQx4qjyNU5npw5hMjk5+TaB/EuB0W/9JM81zSlZzwEa96j9uwefH88xTv4=
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
Cc: alexdeucher@gmail.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 guchun.chen@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191113224524.0-jmEzCjueyjSsu2sR-KersMWYFleL1a6pM1FoBjC3c@z>

V2Ugd2FudCB0byBiZSBiZSBhYmxlIHRvIGNhbGwgdGhlbSBpbmRlcGVuZGVudGx5IGZyb20gb25l
IGFub3RoZXIKc28gdGhhdCBiZWZvcmUgR1BVIHJlc2V0IGp1c3QgYW1kZ3B1X3Jhc19zYXZlX2Jh
ZF9wYWdlcyBpcyBjYWxsZWQuCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5k
cmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmFzLmMgfCAxNCArKysrLS0tLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Jhcy5oIHwgIDQgKysrLQogMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9yYXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMu
YwppbmRleCA0MDQ0ODM0Li42MDBhODZkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmFzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Jhcy5jCkBAIC0xNDIxLDcgKzE0MjEsNyBAQCBpbnQgYW1kZ3B1X3Jhc19hZGRfYmFkX3Bh
Z2VzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogICogd3JpdGUgZXJyb3IgcmVjb3JkIGFy
cmF5IHRvIGVlcHJvbSwgdGhlIGZ1bmN0aW9uIHNob3VsZCBiZQogICogcHJvdGVjdGVkIGJ5IHJl
Y292ZXJ5X2xvY2sKICAqLwotc3RhdGljIGludCBhbWRncHVfcmFzX3NhdmVfYmFkX3BhZ2VzKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQoraW50IGFtZGdwdV9yYXNfc2F2ZV9iYWRfcGFnZXMo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7CiAJc3RydWN0IGFtZGdwdV9yYXMgKmNvbiA9
IGFtZGdwdV9yYXNfZ2V0X2NvbnRleHQoYWRldik7CiAJc3RydWN0IHJhc19lcnJfaGFuZGxlcl9k
YXRhICpkYXRhOwpAQCAtMTUyMCw3ICsxNTIwLDcgQEAgaW50IGFtZGdwdV9yYXNfcmVzZXJ2ZV9i
YWRfcGFnZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJc3RydWN0IHJhc19lcnJfaGFu
ZGxlcl9kYXRhICpkYXRhOwogCXVpbnQ2NF90IGJwOwogCXN0cnVjdCBhbWRncHVfYm8gKmJvID0g
TlVMTDsKLQlpbnQgaSwgcmV0ID0gMDsKKwlpbnQgaTsKIAogCWlmICghY29uIHx8ICFjb24tPmVo
X2RhdGEpCiAJCXJldHVybiAwOwpAQCAtMTU0OCwxMiArMTU0OCw5IEBAIGludCBhbWRncHVfcmFz
X3Jlc2VydmVfYmFkX3BhZ2VzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlkYXRhLT5s
YXN0X3Jlc2VydmVkID0gaSArIDE7CiAJCWJvID0gTlVMTDsKIAl9Ci0KLQkvKiBjb250aW51ZSB0
byBzYXZlIGJhZCBwYWdlcyB0byBlZXByb20gZXZlbiByZWVzcnZlX3ZyYW0gZmFpbHMgKi8KLQly
ZXQgPSBhbWRncHVfcmFzX3NhdmVfYmFkX3BhZ2VzKGFkZXYpOwogb3V0OgogCW11dGV4X3VubG9j
aygmY29uLT5yZWNvdmVyeV9sb2NrKTsKLQlyZXR1cm4gcmV0OworCXJldHVybiAwOwogfQogCiAv
KiBjYWxsZWQgd2hlbiBkcml2ZXIgdW5sb2FkICovCkBAIC0xNjE1LDE0ICsxNjEyLDExIEBAIGlu
dCBhbWRncHVfcmFzX3JlY292ZXJ5X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJ
CXJldCA9IGFtZGdwdV9yYXNfbG9hZF9iYWRfcGFnZXMoYWRldik7CiAJCWlmIChyZXQpCiAJCQln
b3RvIGZyZWU7Ci0JCXJldCA9IGFtZGdwdV9yYXNfcmVzZXJ2ZV9iYWRfcGFnZXMoYWRldik7Ci0J
CWlmIChyZXQpCi0JCQlnb3RvIHJlbGVhc2U7CisJCWFtZGdwdV9yYXNfcmVzZXJ2ZV9iYWRfcGFn
ZXMoYWRldik7CiAJfQogCiAJcmV0dXJuIDA7CiAKLXJlbGVhc2U6CiAJYW1kZ3B1X3Jhc19yZWxl
YXNlX2JhZF9wYWdlcyhhZGV2KTsKIGZyZWU6CiAJa2ZyZWUoKCpkYXRhKS0+YnBzKTsKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaCBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaAppbmRleCBmODBmZDM0Li4xMmIwNzk3IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmgKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oCkBAIC00OTIsNiArNDkyLDgg
QEAgdW5zaWduZWQgbG9uZyBhbWRncHVfcmFzX3F1ZXJ5X2Vycm9yX2NvdW50KHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAogaW50IGFtZGdwdV9yYXNfYWRkX2JhZF9wYWdlcyhzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKIAkJc3RydWN0IGVlcHJvbV90YWJsZV9yZWNvcmQgKmJwcywgaW50
IHBhZ2VzKTsKIAoraW50IGFtZGdwdV9yYXNfc2F2ZV9iYWRfcGFnZXMoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpOworCiBpbnQgYW1kZ3B1X3Jhc19yZXNlcnZlX2JhZF9wYWdlcyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldik7CiAKIHN0YXRpYyBpbmxpbmUgaW50IGFtZGdwdV9yYXNfcmVz
ZXRfZ3B1KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LApAQCAtNTAzLDcgKzUwNSw3IEBAIHN0
YXRpYyBpbmxpbmUgaW50IGFtZGdwdV9yYXNfcmVzZXRfZ3B1KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LAogCSAqIGkyYyBtYXkgYmUgdW5zdGFibGUgaW4gZ3B1IHJlc2V0CiAJICovCiAJaWYg
KGluX3Rhc2soKSkKLQkJYW1kZ3B1X3Jhc19yZXNlcnZlX2JhZF9wYWdlcyhhZGV2KTsKKwkJYW1k
Z3B1X3Jhc19zYXZlX2JhZF9wYWdlcyhhZGV2KTsKIAogCWlmIChhdG9taWNfY21weGNoZygmcmFz
LT5pbl9yZWNvdmVyeSwgMCwgMSkgPT0gMCkKIAkJc2NoZWR1bGVfd29yaygmcmFzLT5yZWNvdmVy
eV93b3JrKTsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
