Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C77C2BAEE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 20:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B769620749
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 20:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HqMU0t57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B769620749
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDEB06E4DE;
	Wed, 11 Mar 2020 20:49:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E60C89276
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 20:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FozUF64j6nvm5dYKfTjD5e7RzjEv3HsTNcOHSeLjwl0oWWBMQ/g5JUuIWbLWmIUtk6iOReSB+JM+zuFhgv3erkm3vVgicFhHo2iKURHSYyUKmo1c21WKIq0xfPGqQofi6W0vvYZye+vzgxCtlLlO2H+kkV44stMH5U7NmF+Mva7d8bf8VWpwwJFp+j4WNKQRiiMhAdPzWo823ci7L9lsDK4k1uGMim+VDPWzVUGMC5NMLTEme4gboLwDZq3FVTQqUNn7CaBU6abrnvrFlOIjSjLL4zmHuRSszDZ7ZGJm/WANz1jHH5dfIA5PK1IGQYB4EZl2Vmd/vlsPe5Hf9S472A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MT7rPxMcMoqJo7GGPmege7svRQCch/ZXVm8Fk5wlOJ4=;
 b=W+DB0MYUQQ3ZLs9lGXUGDFyoCttOReFJdISreRL/3b4f93o2yhIUtSxFdIaEI89a7esSr6bQk9m222l1DPN2meGOC2uGpFSrCy+7Pj9xnkIAvk8WdLV7oJt5YItboZgvwZtBbhh8gMFi3Bqthhjj5vOzU9j18acZ9U+jeAHlJUnvfr+Ay9mcyW7y8PHEJBP+NJbGD/3OD5Xr83GqaU6MeOY/m6C8ihoYY5wA7BMDLehN9nvczKIVBmlcsLWE4UCAT5hwx7haNpiozqO0P3ZgrIkG7SxHnvvDB1L05a6Sr1NmtF8ZBPsX2Y2QHW1FpxgfNvoz5l6Cycls76f8LMVlpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MT7rPxMcMoqJo7GGPmege7svRQCch/ZXVm8Fk5wlOJ4=;
 b=HqMU0t57ca8Lp8JckPjxDPgVCFnR2pASVWxACOneUUgEUZstKDDWnBwOCx09FIHy2oeIKPQySvAL7ddSc+AdIBKLT2SnDMyywz3TpuSx2B734P5tbkufk1Qo1LuHUxN++XxQ6owIGf2tElQLRwqbd/2SbEwoFRo/6KfprEXzCjo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB3079.namprd12.prod.outlook.com (2603:10b6:a03:a9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 20:49:44 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 20:49:44 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v5 1/4] drm/amdgpu/vcn: fix race condition issue for vcn start
Date: Wed, 11 Mar 2020 16:49:31 -0400
Message-Id: <1583959774-16570-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTBPR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::33) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTBPR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 20:49:43 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13b3dd57-ec8c-4952-e5b5-08d7c5fdba57
X-MS-TrafficTypeDiagnostic: BYAPR12MB3079:|BYAPR12MB3079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3079BEAA7CD2010D1550145BE4FC0@BYAPR12MB3079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(199004)(66574012)(66946007)(26005)(66476007)(4326008)(2906002)(66556008)(6666004)(5660300002)(7696005)(52116002)(6916009)(316002)(81166006)(8676002)(478600001)(6486002)(8936002)(81156014)(86362001)(956004)(186003)(2616005)(36756003)(16526019);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3079;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BI617NdSzz8WtjsRDLBbSwE0uOQ4xM3v7lkcQIjIcltNmPwJmH1CQwyyFS8PIarI2ACQPZD/McV26cysE9AO/H3KJYHmYgAEVGUHW18p/ZzbRiqtmRKDp6R04fhwK7E9qsUuHEVYEpYeqs4WuMZWOEJTeBqTARoK+VeQP0tN2CicNsBlOPYQDi543Fhl/UFwpwRpq8bpQKLcyrmSZiiSV60sYy95BvGK43Y+vozNon0RoJPQznAR34hPSc3gwBjYwOrWqYYbBaXK4qyAbJrw8uIWmgld5f7SpHsSV5/7F9DtP7XjlHgXXvHP8e+h4pL4A3/sPB7cAJpjBNfhd/rMb0LmAeNjj69X8ZXZGr4kE0lhRFWS3tOZUyZSJ0RuPpXfsMTMnr7PUoh1DxY80eewNbhMLdLj/mKiVFTNqXC/GlDT1kavjR4n1BSoqrYqqr5/
X-MS-Exchange-AntiSpam-MessageData: V3ikXoiMV6VAb+aE1aOYPQA5Ktulvb/NF+gd1tmBjxNRDmf4JEKus1YVnZ0iTix9JW0cgByQlUuOZSVPJY45DgOX+dRQhfaKMsau0GZNfe69A1yINfUZb3YpnbX3HTJWu8pk+wlWylQxu8qOAsrDdQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b3dd57-ec8c-4952-e5b5-08d7c5fdba57
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 20:49:44.2153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2xuAF5cQVLY8Tn/nL78JTyFVDit1WhBwtl/LbyGfqbVEB9OfyGnHEjPeAqx+Xvi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3079
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4IHJhY2UgY29uZGl0aW9uIGlzc3VlIHdoZW4gbXVsdGlwbGUgdmNuIHN0YXJ0cyBhcmUgY2Fs
bGVkLgoKdjI6IFJlbW92ZWQgY2hlY2tpbmcgdGhlIHJldHVybiB2YWx1ZSBvZiBjYW5jZWxfZGVs
YXllZF93b3JrX3N5bmMoKQp0byBwcmV2ZW50IHBvc3NpYmxlIHJhY2VzIGhlcmUuCgp2MzogQWRk
IHRvdGFsX3N1Ym1pc3Npb25fY250IHRvIGF2b2lkIGdhdGUgcG93ZXIgdW5leHBlY3RlZGx5LgoK
djQ6IFJlbW92ZSBleHRyYSBjb3VudGVyIGNoZWNrLCBhbmQgcmVkdWNlIGNvdW50ZXIgYmVmb3Jl
IGlkbGUKd29yayBzY2hlZHVsZQoKU2lnbmVkLW9mZi1ieTogSmFtZXMgWmh1IDxKYW1lcy5aaHVA
YW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgfCAy
MSArKysrKysrKysrKysrKy0tLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92Y24uaCB8ICAyICsrCiAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Zjbi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCmluZGV4IGE0
MTI3MmYuLjZkYWNmNzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92Y24uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMK
QEAgLTYzLDYgKzYzLDggQEAgaW50IGFtZGdwdV92Y25fc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIAlpbnQgaSwgcjsKIAogCUlOSVRfREVMQVlFRF9XT1JLKCZhZGV2LT52Y24u
aWRsZV93b3JrLCBhbWRncHVfdmNuX2lkbGVfd29ya19oYW5kbGVyKTsKKwltdXRleF9pbml0KCZh
ZGV2LT52Y24udmNuX3BnX2xvY2spOworCWF0b21pY19zZXQoJmFkZXYtPnZjbi50b3RhbF9zdWJt
aXNzaW9uX2NudCwgMCk7CiAKIAlzd2l0Y2ggKGFkZXYtPmFzaWNfdHlwZSkgewogCWNhc2UgQ0hJ
UF9SQVZFTjoKQEAgLTIxMCw2ICsyMTIsNyBAQCBpbnQgYW1kZ3B1X3Zjbl9zd19maW5pKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KQogCX0KIAogCXJlbGVhc2VfZmlybXdhcmUoYWRldi0+dmNu
LmZ3KTsKKwltdXRleF9kZXN0cm95KCZhZGV2LT52Y24udmNuX3BnX2xvY2spOwogCiAJcmV0dXJu
IDA7CiB9CkBAIC0zMDcsNyArMzEwLDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Zjbl9pZGxlX3dv
cmtfaGFuZGxlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJCWZlbmNlcyArPSBmZW5jZVtq
XTsKIAl9CiAKLQlpZiAoZmVuY2VzID09IDApIHsKKwlpZiAoIWZlbmNlcyAmJiAhYXRvbWljX3Jl
YWQoJmFkZXYtPnZjbi50b3RhbF9zdWJtaXNzaW9uX2NudCkpIHsKIAkJYW1kZ3B1X2dmeF9vZmZf
Y3RybChhZGV2LCB0cnVlKTsKIAkJYW1kZ3B1X2RldmljZV9pcF9zZXRfcG93ZXJnYXRpbmdfc3Rh
dGUoYWRldiwgQU1EX0lQX0JMT0NLX1RZUEVfVkNOLAogCQkgICAgICAgQU1EX1BHX1NUQVRFX0dB
VEUpOwpAQCAtMzE5LDEzICszMjIsMTQgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3Zjbl9pZGxlX3dv
cmtfaGFuZGxlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiB2b2lkIGFtZGdwdV92Y25fcmlu
Z19iZWdpbl91c2Uoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQogewogCXN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2ID0gcmluZy0+YWRldjsKLQlib29sIHNldF9jbG9ja3MgPSAhY2FuY2VsX2Rl
bGF5ZWRfd29ya19zeW5jKCZhZGV2LT52Y24uaWRsZV93b3JrKTsKIAotCWlmIChzZXRfY2xvY2tz
KSB7Ci0JCWFtZGdwdV9nZnhfb2ZmX2N0cmwoYWRldiwgZmFsc2UpOwotCQlhbWRncHVfZGV2aWNl
X2lwX3NldF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LCBBTURfSVBfQkxPQ0tfVFlQRV9WQ04sCi0J
CSAgICAgICBBTURfUEdfU1RBVEVfVU5HQVRFKTsKLQl9CisJYXRvbWljX2luYygmYWRldi0+dmNu
LnRvdGFsX3N1Ym1pc3Npb25fY250KTsKKwljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmFkZXYt
PnZjbi5pZGxlX3dvcmspOworCisJbXV0ZXhfbG9jaygmYWRldi0+dmNuLnZjbl9wZ19sb2NrKTsK
KwlhbWRncHVfZ2Z4X29mZl9jdHJsKGFkZXYsIGZhbHNlKTsKKwlhbWRncHVfZGV2aWNlX2lwX3Nl
dF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LCBBTURfSVBfQkxPQ0tfVFlQRV9WQ04sCisJICAgICAg
IEFNRF9QR19TVEFURV9VTkdBVEUpOwogCiAJaWYgKGFkZXYtPnBnX2ZsYWdzICYgQU1EX1BHX1NV
UFBPUlRfVkNOX0RQRykJewogCQlzdHJ1Y3QgZHBnX3BhdXNlX3N0YXRlIG5ld19zdGF0ZTsKQEAg
LTM0NSwxMCArMzQ5LDEzIEBAIHZvaWQgYW1kZ3B1X3Zjbl9yaW5nX2JlZ2luX3VzZShzdHJ1Y3Qg
YW1kZ3B1X3JpbmcgKnJpbmcpCiAKIAkJYWRldi0+dmNuLnBhdXNlX2RwZ19tb2RlKGFkZXYsIHJp
bmctPm1lLCAmbmV3X3N0YXRlKTsKIAl9CisJbXV0ZXhfdW5sb2NrKCZhZGV2LT52Y24udmNuX3Bn
X2xvY2spOwogfQogCiB2b2lkIGFtZGdwdV92Y25fcmluZ19lbmRfdXNlKHN0cnVjdCBhbWRncHVf
cmluZyAqcmluZykKIHsKKwlhdG9taWNfZGVjKCZyaW5nLT5hZGV2LT52Y24udG90YWxfc3VibWlz
c2lvbl9jbnQpOworCiAJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZyaW5nLT5hZGV2LT52Y24uaWRs
ZV93b3JrLCBWQ05fSURMRV9USU1FT1VUKTsKIH0KIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Zjbi5oCmluZGV4IDZmZTA1NzMuLjExMWM0Y2MgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdmNuLmgKQEAgLTIwMCw2ICsyMDAsOCBAQCBzdHJ1Y3QgYW1kZ3B1X3Zj
biB7CiAJc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICp2Y25fZGVjX3NjaGVkW0FNREdQVV9NQVhf
VkNOX0lOU1RBTkNFU107CiAJdWludDMyX3QJCSBudW1fdmNuX2VuY19zY2hlZDsKIAl1aW50MzJf
dAkJIG51bV92Y25fZGVjX3NjaGVkOworCXN0cnVjdCBtdXRleAkJIHZjbl9wZ19sb2NrOworCWF0
b21pY190CQkgdG90YWxfc3VibWlzc2lvbl9jbnQ7CiAKIAl1bnNpZ25lZAloYXJ2ZXN0X2NvbmZp
ZzsKIAlpbnQgKCpwYXVzZV9kcGdfbW9kZSkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCi0t
IAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
