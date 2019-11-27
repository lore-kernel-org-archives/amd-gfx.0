Return-Path: <SRS0=tLpO=ZT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ADCC432C3
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73592070A
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Nov 2019 09:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73592070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99CEB6E4E3;
	Wed, 27 Nov 2019 09:16:09 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740088.outbound.protection.outlook.com [40.107.74.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BE5C6E4F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Nov 2019 09:16:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeCsXmlkqB82xeuvAztXThzDo2Fbkjrolg5EJ+LoFl+IR3LjXB640LYe9YOvWle/B6nrI2uKYs4U9sfiIdKlm03SoHtc3r1TVIWns/CqLGCIvG3+fc+2SGeuvrfoL1aSX9VbltKMRHzxZLq7UAr53Ec/yq8qDm1sjJ2zv4NXpDc9yW3/w9IPpQREyBAIZpMRZ+YpYJaMJUxoxMiLQ0Es5mN0U/ZjcrPWDkkDMN2w7+6bxVGZvK6XVICnSwIxHuVn7RVmMu8BKu6f+tFZflVrjsb+gqrCuMl5xvfm/Ikg7ZqwiFV/Tf+NkXMLqvapZpbMfUEZtV+GA8I9/2sfbgu25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5s8quIgMd/AN9awIhc5teAXxR9b3hFXgKlVUd9oKuM=;
 b=ZUw4UC/o3Si/Sav7SrFSpRHfawNnuI47ulUrlhX69nvMTWT2jpfBcrBbLip/VADPK8Gu6PW3167hsah7atGqWEQ/Tz8S6SOkalIGsS6/O20GjC7O2s3cu3PCTCk+UbZMQjlRAzMZJehdZsduhsSqiHgfTdcrA0RLK4ScHi23tYVcJjKZPM9nNm6IYEAG8LK4ls1gElWqlz9OcJmro0+LNF64BlYKzWGOdIUeGIhi4mE+9qp2RIBJDG09VabNnGVaJ+tB1EBErYQCzoWZgRpF9zQrispD2W5QGEjj1FUDvcCsh7oIVuXX4onFlgyfTIGgN27p9IBZKUghNcgqH9lNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CY4PR1201CA0023.namprd12.prod.outlook.com
 (2603:10b6:910:16::33) by DM5PR12MB1307.namprd12.prod.outlook.com
 (2603:10b6:3:79::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Wed, 27 Nov
 2019 09:16:05 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::208) by CY4PR1201CA0023.outlook.office365.com
 (2603:10b6:910:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17 via Frontend
 Transport; Wed, 27 Nov 2019 09:16:04 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2451.23 via Frontend Transport; Wed, 27 Nov 2019 09:16:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 03:15:54 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 03:15:54 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 27 Nov 2019 03:15:51 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/10] drm/amdgpu: support full gpu reset workflow when ras
 err_event_athub occurs
Date: Wed, 27 Nov 2019 17:15:27 +0800
Message-ID: <1574846129-4826-7-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574846129-4826-1-git-send-email-le.ma@amd.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(428003)(199004)(189003)(2616005)(2351001)(26005)(186003)(356004)(44832011)(8936002)(6666004)(50226002)(305945005)(11346002)(51416003)(426003)(446003)(76176011)(4326008)(16586007)(2906002)(86362001)(48376002)(336012)(50466002)(6916009)(478600001)(5660300002)(70586007)(70206006)(81156014)(14444005)(47776003)(81166006)(36756003)(8676002)(316002)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1307; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db7f70eb-5d00-4cc7-fd76-08d7731a6dec
X-MS-TrafficTypeDiagnostic: DM5PR12MB1307:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1307EE6E5CCE4EE168C5B44AF6440@DM5PR12MB1307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:338;
X-Forefront-PRVS: 023495660C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWUGVvcbuAmAS432ef7XqkkmL+LAYIY+XDQtQL+O6/jQPqh05Rcna9b/m2prWjrl9FhqzreyiY3JJTR5BHxTlcYdWJBapj3HYCz5FAqYhmEgnKEGZjXYL8FwvMpgREBjw9azA5Ppqq0290dY6aeoIWc27rPtV3AnRm1kpV9I/1H03+MtJw/A/5iLGPhjjRUwJU6BJmRUeVMN3d5B8M1EOqr7M8EH1LcDWfVpTN3mXH188hPhewdxTeudKNZjBJ/wvkPbr3DjXBmuCiRUUL+n0P7GHuTPhYDk4nGLWRA+m3Og0zw98d49CNpwvKjIE7HbXE1Mepk5wk1QSDB+HC1pcxM6IwBm2jpr+hmcjb+SNgze9l0ujwje8EQsWvWQF0jfH0rk9gz32YGmXhJ+VHZxd72VrhxekKrSD0ReI1WCh5nC2Yar1HMNXFCuP7cqUz4G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 09:16:04.5555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db7f70eb-5d00-4cc7-fd76-08d7731a6dec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1307
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5s8quIgMd/AN9awIhc5teAXxR9b3hFXgKlVUd9oKuM=;
 b=eOASOQgY5dJ05e4UhAJmBcaUbOGhGdPrpBbYyb9uMIffurwSp5wPZh6IjoXMxV39CHy+BuQn9eMWVDdz71Zrqw6HYCUtEQpVi5ZJSYDo5WgZzk99srSXf1kKM9Cy6Fcft0EZqD+DwFp56y+mch5NGsaN6XElebl/CjYN3FnXVKo=
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
Cc: guchun.chen@amd.com, tao.zhou1@amd.com, Le Ma <le.ma@amd.com>,
 alexander.deucher@amd.com, dennis.li@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191127091527.TKZrmiessWbGPgx2npKhHE9NFM3FpiL2mbjpF4_DSCU@z>

VGhpcyBhdGh1YiBmYXRhbCBlcnJvciBjYW4gYmUgcmVjb3ZlcmVkIGJ5IGJhY28gd2l0aG91dCBz
eXN0ZW0tbGV2ZWwgcmVib290LApzbyBhZGQgYSBtb2RlIHRvIHVzZSBiYWNvIGZvciB0aGUgcmVj
b3ZlcnkuIE5vdCBhZmZlY3QgdGhlIGRlZmF1bHQgcHNwIHJlc2V0CnNpdHVhdGlvbnMgZm9yIG5v
dy4KCkNoYW5nZS1JZDogSWIxN2YyYTM5MjU0ZmY2YjA0NzNhNzg1NzUyYWRmZGZlYTc5ZDBlMGQK
U2lnbmVkLW9mZi1ieTogTGUgTWEgPGxlLm1hQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgMTcgKysrKysrKysrKystLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCA3MWFiZmU5Li41M2U5NTkwIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC00MDIxLDEy
ICs0MDIxLDE1IEBAIGludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAogCXN0cnVjdCBhbWRncHVfZGV2aWNlICp0bXBfYWRldiA9IE5VTEw7CiAJ
aW50IGksIHIgPSAwOwogCWJvb2wgaW5fcmFzX2ludHIgPSBhbWRncHVfcmFzX2ludHJfdHJpZ2dl
cmVkKCk7CisJYm9vbCB1c2VfYmFjbyA9CisJCShhbWRncHVfYXNpY19yZXNldF9tZXRob2QoYWRl
dikgPT0gQU1EX1JFU0VUX01FVEhPRF9CQUNPKSA/CisJCXRydWUgOiBmYWxzZTsKIAogCS8qCiAJ
ICogRmx1c2ggUkFNIHRvIGRpc2sgc28gdGhhdCBhZnRlciByZWJvb3QKIAkgKiB0aGUgdXNlciBj
YW4gcmVhZCBsb2cgYW5kIHNlZSB3aHkgdGhlIHN5c3RlbSByZWJvb3RlZC4KIAkgKi8KLQlpZiAo
aW5fcmFzX2ludHIgJiYgYW1kZ3B1X3Jhc19nZXRfY29udGV4dChhZGV2KS0+cmVib290KSB7CisJ
aWYgKGluX3Jhc19pbnRyICYmICF1c2VfYmFjbyAmJiBhbWRncHVfcmFzX2dldF9jb250ZXh0KGFk
ZXYpLT5yZWJvb3QpIHsKIAogCQlEUk1fV0FSTigiRW1lcmdlbmN5IHJlYm9vdC4iKTsKIApAQCAt
NDAzNyw3ICs0MDQwLDggQEAgaW50IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsCiAJbmVlZF9mdWxsX3Jlc2V0ID0gam9iX3NpZ25hbGVkID0gZmFs
c2U7CiAJSU5JVF9MSVNUX0hFQUQoJmRldmljZV9saXN0KTsKIAotCWRldl9pbmZvKGFkZXYtPmRl
diwgIkdQVSAlcyBiZWdpbiFcbiIsIGluX3Jhc19pbnRyID8gImpvYnMgc3RvcCI6InJlc2V0Iik7
CisJZGV2X2luZm8oYWRldi0+ZGV2LCAiR1BVICVzIGJlZ2luIVxuIiwKKwkJKGluX3Jhc19pbnRy
ICYmICF1c2VfYmFjbykgPyAiam9icyBzdG9wIjoicmVzZXQiKTsKIAogCWNhbmNlbF9kZWxheWVk
X3dvcmtfc3luYygmYWRldi0+ZGVsYXllZF9pbml0X3dvcmspOwogCkBAIC00MTA0LDcgKzQxMDgs
OCBAQCBpbnQgYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwKIAkJYW1kZ3B1X3VucmVnaXN0ZXJfZ3B1X2luc3RhbmNlKHRtcF9hZGV2KTsKIAogCQkv
KiBkaXNhYmxlIHJhcyBvbiBBTEwgSVBzICovCi0JCWlmICghaW5fcmFzX2ludHIgJiYgYW1kZ3B1
X2RldmljZV9pcF9uZWVkX2Z1bGxfcmVzZXQodG1wX2FkZXYpKQorCQlpZiAoIShpbl9yYXNfaW50
ciAmJiAhdXNlX2JhY28pICYmCisJCSAgICAgIGFtZGdwdV9kZXZpY2VfaXBfbmVlZF9mdWxsX3Jl
c2V0KHRtcF9hZGV2KSkKIAkJCWFtZGdwdV9yYXNfc3VzcGVuZCh0bXBfYWRldik7CiAKIAkJZm9y
IChpID0gMDsgaSA8IEFNREdQVV9NQVhfUklOR1M7ICsraSkgewpAQCAtNDExNSwxMyArNDEyMCwx
MyBAQCBpbnQgYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwKIAogCQkJZHJtX3NjaGVkX3N0b3AoJnJpbmctPnNjaGVkLCBqb2IgPyAmam9iLT5iYXNl
IDogTlVMTCk7CiAKLQkJCWlmIChpbl9yYXNfaW50cikKKwkJCWlmIChpbl9yYXNfaW50ciAmJiAh
dXNlX2JhY28pCiAJCQkJYW1kZ3B1X2pvYl9zdG9wX2FsbF9qb2JzX29uX3NjaGVkKCZyaW5nLT5z
Y2hlZCk7CiAJCX0KIAl9CiAKIAotCWlmIChpbl9yYXNfaW50cikKKwlpZiAoaW5fcmFzX2ludHIg
JiYgIXVzZV9iYWNvKQogCQlnb3RvIHNraXBfc2NoZWRfcmVzdW1lOwogCiAJLyoKQEAgLTQyMTQs
NyArNDIxOSw3IEBAIGludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAogc2tpcF9zY2hlZF9yZXN1bWU6CiAJbGlzdF9mb3JfZWFjaF9lbnRyeSh0
bXBfYWRldiwgZGV2aWNlX2xpc3RfaGFuZGxlLCBnbWMueGdtaS5oZWFkKSB7CiAJCS8qdW5sb2Nr
IGtmZDogU1JJT1Ygd291bGQgZG8gaXQgc2VwYXJhdGVseSAqLwotCQlpZiAoIWluX3Jhc19pbnRy
ICYmICFhbWRncHVfc3Jpb3ZfdmYodG1wX2FkZXYpKQorCQlpZiAoIShpbl9yYXNfaW50ciAmJiAh
dXNlX2JhY28pICYmICFhbWRncHVfc3Jpb3ZfdmYodG1wX2FkZXYpKQogCSAgICAgICAgICAgICAg
ICBhbWRncHVfYW1ka2ZkX3Bvc3RfcmVzZXQodG1wX2FkZXYpOwogCQlhbWRncHVfZGV2aWNlX3Vu
bG9ja19hZGV2KHRtcF9hZGV2KTsKIAl9Ci0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4
