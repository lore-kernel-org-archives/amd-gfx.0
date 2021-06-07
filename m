Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6887C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900CE60FE5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900CE60FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D3656E92D;
	Mon,  7 Jun 2021 16:48:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A586E935
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ag5gguDNbeuau9QOvWU7TiVo/VbvFU9AwEFBo3au1yk3cCsJSrs5/OTMMbq+U5VsgVL/wQNLFJDfUMQE26m+mceF0uN3W2qU+yOjRUdXTT1POBZDfdOjqXAhP3URn2ZThNJYvuKxUxAmZEM0ODrBspH4gbjmvgQkmftLV4xCm76hUiE7njEavn7VgPHkEk22glPgrDS5pG6h/vxOfddXWuTWbMJ7RwKNVYfQ/dfhbJBN1qTjAuXN+PZEEjJ7h+DVGXcP+/0E+DhFkh0doQeWXty5U9V8kqn8dxPfO1SpR0NqzxKNXK7QJGjeFv7Ko5puweBq30hz63ej5DfdSO/78w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8Vaw3T9LOnHnmV1mk9cXvjKc/7QDXDK2PXT+CcZ6SM=;
 b=evIpfUtnit+kCTaxwnBknIN5bPSB4Jt7kjEt34bP9CdCz1yK3ehi+y81kLrvJiZXn51xPytZQq0r2pg38KUtUbOue++jGPPFPJkeUsKwH7Ob3ed3WEANpRLZ0tUW7UadOpKMkbid/jZ4eZZ1AQLGYbddmLdY7QKlwKCrbohPwRjek6VdsNkWKj9Z2nDiVjMnpnb32a9IZxRxBLBal0md+OTbyzyOrYCtOZYrgqe+nHi7V+h28Ekw/yL26NYAaq4Sf2Ih77Y/TVqChrefXrCJk1OYdOFDt3brqgHu8Fn0e4PPveiviRZlh36uCC1Thcr2G/IcUbt5ywXRb60wLzrhVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8Vaw3T9LOnHnmV1mk9cXvjKc/7QDXDK2PXT+CcZ6SM=;
 b=uYHRiA6TKxJREfeoNlfRfY5XGDPdOcgEoFg5H/XTyi34cJ+CRMni9U9B2pLDd8qaXjfVbCNBUWKcCdRiDTjyMAh8PjHGDraJW4R/AVER5ENfhmQG9YVjO+DqBs6sieaGXixI1pE7426EVSxrU/qgGFkkPOneY4SOdxQtV+OQ6ss=
Received: from BN9PR03CA0487.namprd03.prod.outlook.com (2603:10b6:408:130::12)
 by DM6PR12MB4793.namprd12.prod.outlook.com (2603:10b6:5:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.26; Mon, 7 Jun
 2021 16:48:04 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::6b) by BN9PR03CA0487.outlook.office365.com
 (2603:10b6:408:130::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:03 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:47:59 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/30] drm/amd/display: Control power gating by driver.
Date: Tue, 8 Jun 2021 00:46:49 +0800
Message-ID: <20210607164714.311325-6-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5600ae01-8ffa-46df-a3bf-08d929d4048c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4793:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4793FCC1ACF0671BA02DD69EFF389@DM6PR12MB4793.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nI5TGpBkKUGVJm/O+7AQu8ZYk/Zy34cM6oAlzLFUh9nTbbuxpvAVotewWISyikWweaEyC08cj+h9FVCt7rjwDTL52aX6v2v+FYwAjc28iicfE1eFvii/F5i+g9GMybGqWuiRcQlX/eVZSbYRiZ1y6xnC0zogtdz1n9L3yun7LzSXKfNrOJLaoL7QvyorMeexEktd1yFMcfxg2x74AlTs55EZLspPSEEYr6SYpfI2Y4qSID+MSDNn2fEP3emvYMGpvWkp9K3ANt4+q+lxj/YzmANyTQYHTnAyatxL5Xe3eu8NAPRxo9WGQYBAhLyjtkckz5wAZEUlmRU3buaZHcnwL1MR2nPWLvQZQp5tiPAiBmvKJbCX5/LdRpnTnnaCD5sbCKfK4Kmx5zgBJ4kkZuJdjWqVsFJzCqNX1eNNlyl5HQj/qiXBBFDPy5SsP7wICoHsm82GN65Zpl8CmOksDbyVcUfRHYohjMWyBmps6mtVS5rxBIApd/6zwCF8jblO1kILNSRiAqQafdJGI49jJIAKaSIUrsEcSKbK6mbL5TKTaxbw08rSOIlkrTkag03j156hH1pCYZ+NzIsBc17HjM5o07UUdovmdkCpuMhSLR1LN8eVjOdsExDt0wsN0MXz6auSdPy5MxrUjg8W9kn/SOlB1utCdtetc9D7Aes5maOY7eYSb4vecgnndOc6Xo+HuslI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(376002)(396003)(346002)(136003)(36840700001)(46966006)(478600001)(7696005)(54906003)(6916009)(83380400001)(47076005)(5660300002)(2616005)(16526019)(1076003)(70586007)(8676002)(426003)(36756003)(316002)(26005)(4326008)(44832011)(6666004)(70206006)(82740400003)(81166007)(356005)(336012)(82310400003)(36860700001)(2906002)(86362001)(186003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:03.5333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5600ae01-8ffa-46df-a3bf-08d929d4048c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4793
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, "JinZe.Xu" <JinZe.Xu@amd.com>,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Jun
 Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogIkppblplLlh1IiA8SmluWmUuWHVAYW1kLmNvbT4KCltXaHldClRoaXMgZGlzYWJsZW1l
bnQgd291bGQgYmUgc3BlY2lmaWMgZm9yIE5hdjEwIGFuZCBzaG91bGRu4oCZdCBiZSBwcm9wYWdh
dGVkIHRvIHRoZSBvdGhlciBwcm9ncmFtcy4KCltIb3ddClBvd2VyIGdhdGluZyBpcyBjb250cm9s
bGVkIGJ5IGRyaXZlci4KClNpZ25lZC1vZmYtYnk6IEppblplLlh1IDxKaW5aZS5YdUBhbWQuY29t
PgpSZXZpZXdlZC1ieTogSnVuIExlaSA8SnVuLkxlaUBhbWQuY29tPgpBY2tlZC1ieTogU3R5bG9u
IFdhbmcgPHN0eWxvbi53YW5nQGFtZC5jb20+Ci0tLQogLi4uL2RybS9hbWQvZGlzcGxheS9kYy9k
Y24zMDIvZGNuMzAyX2h3c2VxLmMgIHwgMzQgKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24zMDIvZGNuMzAyX2h3c2VxLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMzAyL2RjbjMwMl9od3NlcS5jCmluZGV4IGU4
NTgwY2NjYmViZi4uMGE2ZDU4ZGQ4ZjZkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNuMzAyL2RjbjMwMl9od3NlcS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY24zMDIvZGNuMzAyX2h3c2VxLmMKQEAgLTg2LDE3ICs4NiwxMiBAQCB2
b2lkIGRjbjMwMl9kcHBfcGdfY29udHJvbChzdHJ1Y3QgZGNlX2h3c2VxICpod3MsIHVuc2lnbmVk
IGludCBkcHBfaW5zdCwgYm9vbCBwbwogCQkJCTEsIDEwMDApOwogCQlicmVhazsKIAljYXNlIDQ6
IC8qIERQUDQgKi8KLQkJLyoKLQkJICogRG8gbm90IHBvd2VyIGdhdGUgRFBQNCwgc2hvdWxkIGJl
IGxlZnQgYXQgSFcgZGVmYXVsdCwgcG93ZXIgb24gcGVybWFuZW50bHkuCi0JCSAqIFBHIG9uIFBp
cGU0IGlzIERlLWZlYXR1cmVkLCBhdHRlbXB0aW5nIHRvIHB1dCBpdCB0byBQRyBzdGF0ZSBtYXkg
cmVzdWx0IGluIGhhcmQKLQkJICogcmVzZXQuCi0JCSAqIFJFR19VUERBVEUoRE9NQUlOOV9QR19D
T05GSUcsCi0JCSAqCQlET01BSU45X1BPV0VSX0dBVEUsIHBvd2VyX2dhdGUpOwotCQkgKgotCQkg
KiBSRUdfV0FJVChET01BSU45X1BHX1NUQVRVUywKLQkJICoJCURPTUFJTjlfUEdGU01fUFdSX1NU
QVRVUywgcHdyX3N0YXR1cywKLQkJICoJCTEsIDEwMDApOwotCQkgKi8KKwkJUkVHX1VQREFURShE
T01BSU45X1BHX0NPTkZJRywKKwkJCQlET01BSU45X1BPV0VSX0dBVEUsIHBvd2VyX2dhdGUpOwor
CisJCVJFR19XQUlUKERPTUFJTjlfUEdfU1RBVFVTLAorCQkJCURPTUFJTjlfUEdGU01fUFdSX1NU
QVRVUywgcHdyX3N0YXR1cywKKwkJCQkxLCAxMDAwKTsKIAkJYnJlYWs7CiAJZGVmYXVsdDoKIAkJ
QlJFQUtfVE9fREVCVUdHRVIoKTsKQEAgLTE0OCwxNyArMTQzLDEyIEBAIHZvaWQgZGNuMzAyX2h1
YnBfcGdfY29udHJvbChzdHJ1Y3QgZGNlX2h3c2VxICpod3MsIHVuc2lnbmVkIGludCBodWJwX2lu
c3QsIGJvb2wKIAkJCQkxLCAxMDAwKTsKIAkJYnJlYWs7CiAJY2FzZSA0OiAvKiBEQ0hVQlA0ICov
Ci0JCS8qCi0JCSAqIERvIG5vdCBwb3dlciBnYXRlIERDSFVCNCwgc2hvdWxkIGJlIGxlZnQgYXQg
SFcgZGVmYXVsdCwgcG93ZXIgb24gcGVybWFuZW50bHkuCi0JCSAqIFBHIG9uIFBpcGU0IGlzIERl
LWZlYXR1cmVkLCBhdHRlbXB0aW5nIHRvIHB1dCBpdCB0byBQRyBzdGF0ZSBtYXkgcmVzdWx0IGlu
IGhhcmQKLQkJICogcmVzZXQuCi0JCSAqIFJFR19VUERBVEUoRE9NQUlOOF9QR19DT05GSUcsCi0J
CSAqCQlET01BSU44X1BPV0VSX0dBVEUsIHBvd2VyX2dhdGUpOwotCQkgKgotCQkgKiBSRUdfV0FJ
VChET01BSU44X1BHX1NUQVRVUywKLQkJICoJCURPTUFJTjhfUEdGU01fUFdSX1NUQVRVUywgcHdy
X3N0YXR1cywKLQkJICoJCTEsIDEwMDApOwotCQkgKi8KKwkJUkVHX1VQREFURShET01BSU44X1BH
X0NPTkZJRywKKwkJCQlET01BSU44X1BPV0VSX0dBVEUsIHBvd2VyX2dhdGUpOworCisJCVJFR19X
QUlUKERPTUFJTjhfUEdfU1RBVFVTLAorCQkJCURPTUFJTjhfUEdGU01fUFdSX1NUQVRVUywgcHdy
X3N0YXR1cywKKwkJCQkxLCAxMDAwKTsKIAkJYnJlYWs7CiAJZGVmYXVsdDoKIAkJQlJFQUtfVE9f
REVCVUdHRVIoKTsKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
