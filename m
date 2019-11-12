Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490D3C17440
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA172067B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA172067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C84666EBA4;
	Tue, 12 Nov 2019 18:04:05 +0000 (UTC)
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr790081.outbound.protection.outlook.com [40.107.79.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE1C6EBA4
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 18:04:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXbgZpgmuDDWb1pIgcu+meGb9s3KIER+Kg7esj1c+vDRU3WcV7DjqCA0n4PNvaQbhStPgZjMZlrYiHPD07bhS0IWTuIYnLA+tOs1fGwJO6/3nOL7gfFA5D5f2LyjuOi+lxreDaaP4bizURxK8e+nudftUwfMm5BrHYRWbUsFW4BCmvgcNYCdw/6D50ynErXGD2D+UsxiYR6YSWDqk6l/C5yzbUmLHWKqxCb4ZjuCYK+AFgnjIpghbDeiJIk+72YvTg7wPqAWKaI9QSGjHQ1ZLO9FgGpp92Yi9gN/cttpI9O7RLEt0fEFbQ+Oa3PT7QVoDTD4uu1YKTuw4gxSMIkbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+BciESpU8sZbINbcVWg8N7jrBch0+nbOJPuX2WHKP4=;
 b=cKzf/0l135HSI/OCDjjZ8GzESNQ1OdnU7AtZ1YlzxhukoccIi+Aj8Yeayx9WNT/7lWk0XHcx4ej4fqAsWLmR7wILVmsQuPx44Ln67ElaiL8T9a7qUJbqBglEEJDYKSvHDw/0vZtUA+SFTsGSUukzpEzM0wra1+RiZGjTmj7emJkQq2G8yNnqisP39SwUAtG/GC0umBVBcpfUm9HW+6LVDgpwyyVibAdXxu7/ZIhDCH7uROHvHHUhekztsjmDSMP7+7wKNUUIv9FBZJyQ2+EFlFwRJbjtUhu+cpxTQ9OY+W9OmB3w5myEzY9y7EkibrBlDnN/gKCs5whCA0WkwGkQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB2405.namprd12.prod.outlook.com (52.132.140.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 18:04:03 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 18:04:03 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/21] drm/amdgpu: use the JPEG structure for general driver
 support
Date: Tue, 12 Nov 2019 13:03:12 -0500
Message-Id: <20191112180329.3927-5-leo.liu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112180329.3927-1-leo.liu@amd.com>
References: <20191112180329.3927-1-leo.liu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To DM5PR12MB2456.namprd12.prod.outlook.com
 (2603:10b6:4:b4::37)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 978d3f73-bef3-4155-333e-08d7679ab37f
X-MS-TrafficTypeDiagnostic: DM5PR12MB2405:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24055C611115963AD24043CEE5770@DM5PR12MB2405.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(4326008)(6512007)(76176011)(66066001)(47776003)(6666004)(2351001)(478600001)(51416003)(52116002)(14454004)(6916009)(44832011)(486006)(186003)(476003)(2616005)(6506007)(386003)(7736002)(26005)(25786009)(2361001)(36756003)(86362001)(305945005)(446003)(11346002)(6116002)(8676002)(3846002)(99286004)(16586007)(66476007)(50226002)(66946007)(2906002)(6486002)(6436002)(8936002)(81166006)(50466002)(5660300002)(316002)(1076003)(48376002)(81156014)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2405;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v32cS9i508unqOu7P+r10Fhztbawn3dgGCBv+dT55rpBJi8TOAjrCFMyV33YDmEtw5U75VMbEqXZ72pHlirtkV45p17BY1ZfY32TMsKDIP/8DQ/O2PG5NNnmz/vXRqhzh3qzzN5CqG2cAyjvxI9GfD6VL2ya+6Tc2ewrciA5hHD9eZaQ+Rx+cO7E2HyazVpstgQWp0PNNdxSbJOXf7XsWY+MZFPa7+nFLtR2YXxgWdtD2/GRq4rFzwQ8GqcnJWajO6Ox/WG6Pxe8nmkrBzDFTnlVCkmPH0ewM9Zd+fM/GtIBCraNXfwOuQS2jwOmLiyJQdy1ZDas+Y6PpBvpn77uG1E1XaNxNStG/sfdvlwvl8A3wRsiYRlFo8HKPKmMnpKy6+clxiksq4oVc6Jtk7WpJLpqG22gV0Sm59+zros0kskGAARPs/IdqVbQakiAYK6F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978d3f73-bef3-4155-333e-08d7679ab37f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 18:04:03.3135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2g6T6mq2Kp1X1GIXssI9pI0Sw6FFmIA0aEwdvUtDPGf7tCpuMr+22PnLsPW8OU0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2405
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+BciESpU8sZbINbcVWg8N7jrBch0+nbOJPuX2WHKP4=;
 b=rxUZrSd41TUJLvnumLhgoos+nebbzfffwcF17KKtoTg0eRPfH3x/50X6448R/+t6lpvBno/J51kew1olLweQzsVrq8+NxRnp4nGZNoO2U+vTG7bX8kpYY4qCWDdP/mshXfwE6T8DcB63L2aS1tY/nFqof9NRnvR8WrJUMQ/FgQ4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112180312.gW5FiyUDYkERoxYZNaRvtc9vKpETBQoxN-TyYYXbdYc@z>

SlBFRzEuMCB3aWxsIGJlIGZ1bmN0aW9uYWwgYWxvbmcgd2l0aCBWQ04xLjAKClNpZ25lZC1vZmYt
Ynk6IExlbyBMaXUgPGxlby5saXVAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfY3R4LmMgfCA0ICsrLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9rbXMuYyB8IDYgKysrLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dmNuLmMgfCA4ICsrKy0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTAg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2N0eC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCmluZGV4
IDY2MTRkOGE2ZjRjOC4uOGYyZWVhOTJkNjdjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2N0eC5jCkBAIC0xNjksMTAgKzE2OSwxMCBAQCBzdGF0aWMgaW50IGFtZGdwdV9jdHhf
aW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCX0KIAkJCWJyZWFrOwogCQljYXNl
IEFNREdQVV9IV19JUF9WQ05fSlBFRzoKLQkJCWZvciAoaiA9IDA7IGogPCBhZGV2LT52Y24ubnVt
X3Zjbl9pbnN0OyArK2opIHsKKwkJCWZvciAoaiA9IDA7IGogPCBhZGV2LT5qcGVnLm51bV9qcGVn
X2luc3Q7ICsraikgewogCQkJCWlmIChhZGV2LT52Y24uaGFydmVzdF9jb25maWcgJiAoMSA8PCBq
KSkKIAkJCQkJY29udGludWU7Ci0JCQkJcmluZ3NbbnVtX3JpbmdzKytdID0gJmFkZXYtPnZjbi5p
bnN0W2pdLnJpbmdfanBlZzsKKwkJCQlyaW5nc1tudW1fcmluZ3MrK10gPSAmYWRldi0+anBlZy5p
bnN0W2pdLnJpbmdfZGVjOwogCQkJfQogCQkJYnJlYWs7CiAJCX0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9rbXMuYwppbmRleCA2ZGRlYTc2MDdhZDAuLjRhNDA4NWVjNTNlMCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ttcy5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYwpAQCAtNDAxLDExICs0MDEsMTEg
QEAgc3RhdGljIGludCBhbWRncHVfaHdfaXBfaW5mbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwKIAkJYnJlYWs7CiAJY2FzZSBBTURHUFVfSFdfSVBfVkNOX0pQRUc6CiAJCXR5cGUgPSBBTURf
SVBfQkxPQ0tfVFlQRV9WQ047Ci0JCWZvciAoaSA9IDA7IGkgPCBhZGV2LT52Y24ubnVtX3Zjbl9p
bnN0OyBpKyspIHsKLQkJCWlmIChhZGV2LT51dmQuaGFydmVzdF9jb25maWcgJiAoMSA8PCBpKSkK
KwkJZm9yIChpID0gMDsgaSA8IGFkZXYtPmpwZWcubnVtX2pwZWdfaW5zdDsgaSsrKSB7CisJCQlp
ZiAoYWRldi0+anBlZy5oYXJ2ZXN0X2NvbmZpZyAmICgxIDw8IGkpKQogCQkJCWNvbnRpbnVlOwog
Ci0JCQlpZiAoYWRldi0+dmNuLmluc3RbaV0ucmluZ19qcGVnLnNjaGVkLnJlYWR5KQorCQkJaWYg
KGFkZXYtPmpwZWcuaW5zdFtpXS5yaW5nX2RlYy5zY2hlZC5yZWFkeSkKIAkJCQkrK251bV9yaW5n
czsKIAkJfQogCQlpYl9zdGFydF9hbGlnbm1lbnQgPSAxNjsKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92Y24uYwppbmRleCAzMTk5ZTRhNWZmMTIuLjZiNmM4ZjhlZmFmZiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwpAQCAtMjEyLDggKzIxMiw2IEBAIGlu
dCBhbWRncHVfdmNuX3N3X2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAKIAkJZm9y
IChpID0gMDsgaSA8IGFkZXYtPnZjbi5udW1fZW5jX3JpbmdzOyArK2kpCiAJCQlhbWRncHVfcmlu
Z19maW5pKCZhZGV2LT52Y24uaW5zdFtqXS5yaW5nX2VuY1tpXSk7Ci0KLQkJYW1kZ3B1X3Jpbmdf
ZmluaSgmYWRldi0+dmNuLmluc3Rbal0ucmluZ19qcGVnKTsKIAl9CiAKIAlyZWxlYXNlX2Zpcm13
YXJlKGFkZXYtPnZjbi5mdyk7CkBAIC0zMDYsNyArMzA0LDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1
X3Zjbl9pZGxlX3dvcmtfaGFuZGxlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJCQllbHNl
CiAJCQkJbmV3X3N0YXRlLmZ3X2Jhc2VkID0gVkNOX0RQR19TVEFURV9fVU5QQVVTRTsKIAotCQkJ
aWYgKGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZhZGV2LT52Y24uaW5zdFtqXS5yaW5nX2pw
ZWcpKQorCQkJaWYgKGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZhZGV2LT5qcGVnLmluc3Rb
al0ucmluZ19kZWMpKQogCQkJCW5ld19zdGF0ZS5qcGVnID0gVkNOX0RQR19TVEFURV9fUEFVU0U7
CiAJCQllbHNlCiAJCQkJbmV3X3N0YXRlLmpwZWcgPSBWQ05fRFBHX1NUQVRFX19VTlBBVVNFOwpA
QCAtMzE0LDcgKzMxMiw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92Y25faWRsZV93b3JrX2hhbmRs
ZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogCQkJYWRldi0+dmNuLnBhdXNlX2RwZ19tb2Rl
KGFkZXYsICZuZXdfc3RhdGUpOwogCQl9CiAKLQkJZmVuY2Vbal0gKz0gYW1kZ3B1X2ZlbmNlX2Nv
dW50X2VtaXR0ZWQoJmFkZXYtPnZjbi5pbnN0W2pdLnJpbmdfanBlZyk7CisJCWZlbmNlW2pdICs9
IGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZhZGV2LT5qcGVnLmluc3Rbal0ucmluZ19kZWMp
OwogCQlmZW5jZVtqXSArPSBhbWRncHVfZmVuY2VfY291bnRfZW1pdHRlZCgmYWRldi0+dmNuLmlu
c3Rbal0ucmluZ19kZWMpOwogCQlmZW5jZXMgKz0gZmVuY2Vbal07CiAJfQpAQCAtMzU4LDcgKzM1
Niw3IEBAIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2JlZ2luX3VzZShzdHJ1Y3QgYW1kZ3B1X3Jpbmcg
KnJpbmcpCiAJCWVsc2UKIAkJCW5ld19zdGF0ZS5md19iYXNlZCA9IFZDTl9EUEdfU1RBVEVfX1VO
UEFVU0U7CiAKLQkJaWYgKGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVkKCZhZGV2LT52Y24uaW5z
dFtyaW5nLT5tZV0ucmluZ19qcGVnKSkKKwkJaWYgKGFtZGdwdV9mZW5jZV9jb3VudF9lbWl0dGVk
KCZhZGV2LT5qcGVnLmluc3RbcmluZy0+bWVdLnJpbmdfZGVjKSkKIAkJCW5ld19zdGF0ZS5qcGVn
ID0gVkNOX0RQR19TVEFURV9fUEFVU0U7CiAJCWVsc2UKIAkJCW5ld19zdGF0ZS5qcGVnID0gVkNO
X0RQR19TVEFURV9fVU5QQVVTRTsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
