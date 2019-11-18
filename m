Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B13BC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 22:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7066E2230F
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 22:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7066E2230F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 199276E83E;
	Mon, 18 Nov 2019 22:25:29 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700071.outbound.protection.outlook.com [40.107.70.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5AC06E83E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 22:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSqjREBMYl4F9WEwFooc9duRPZGqXBVC9ZP9mEKD/FmpoX1V+v9AX5SbtT/+TuTf32WqsIlC7hvV4GgsOPbPFljr5rRMb/DPVMVZKLtH2pnU09IXcAr0RsuRKxlzzeFp/9P9qHgVwJfCAitQe26y4l5zmU1qgoi/9QkVOYNdZ4DwlYFXpfbPokXAmF8Y1n9s8zDohnFRMHM/I2rJXWzLvC8ExOBCNYWAVHO6D8u/WOi4ntZC5g9Fq7eOLIaueAtHa6KLyGsSzrZx3es7Cz99WAYM94N8UwQuI2O++IWRQS50JPCm/tyIDMvzJCsjha56mu2Wsf+ZTG0GronjrXierQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZjINTE3L0Gyn4J6yqkDS4mkJg4HDqfEEM2Dci8w2Wc=;
 b=PSgFocpVxJbZY1ZKXdVSm8jR9YXOrilm8NJgAjgWMlzWVUCvwnPDMVZ94kGCqOVHwe+Am7cdHOy+xK7oSqORA1ieNT5rWo8MkhW8LvEcAQs3KWw0KGKVgY9+l6RURmjfIPCJ6LxZY3QmgOGCQakNrGWIPX85aG909uqSNbY9mPve+hwEDRunV9yNCIF3GwRueTs+dq9H/brnJuhcSJDYlqxya59AqIGy8VY/l+69CyRZZf4xaB6uw7HyVxClL9BoLSMOpWOdH3PIZaqv3WNcunfBQhRrGdTVyvUYt+RyF7aGhzTAMnClah0WytmJqJ/IeCqs35x3xlmrA35tpibKYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CH2PR12MB4182.namprd12.prod.outlook.com (20.180.16.11) by
 CH2PR12MB3701.namprd12.prod.outlook.com (52.132.244.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Mon, 18 Nov 2019 22:25:26 +0000
Received: from CH2PR12MB4182.namprd12.prod.outlook.com
 ([fe80::24d1:40a8:f811:6be1]) by CH2PR12MB4182.namprd12.prod.outlook.com
 ([fe80::24d1:40a8:f811:6be1%6]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 22:25:25 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: add flag to indicate amdgpu vm context
Date: Mon, 18 Nov 2019 16:24:34 -0600
Message-Id: <20191118222435.93134-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SN6PR0102CA0018.prod.exchangelabs.com (2603:10b6:805:1::31)
 To CH2PR12MB4182.namprd12.prod.outlook.com
 (2603:10b6:610:ae::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 177dc1ce-2136-42a8-71c8-08d76c763571
X-MS-TrafficTypeDiagnostic: CH2PR12MB3701:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3701A546D0AAA4FB41B519BAFD4D0@CH2PR12MB3701.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(199004)(189003)(25786009)(305945005)(6916009)(48376002)(6506007)(486006)(476003)(2616005)(14444005)(5660300002)(2906002)(14454004)(478600001)(6486002)(3846002)(6436002)(50466002)(186003)(86362001)(44832011)(6116002)(51416003)(6666004)(2361001)(66946007)(66556008)(66476007)(6512007)(47776003)(2351001)(8936002)(386003)(36756003)(50226002)(66066001)(4326008)(7736002)(81156014)(8676002)(81166006)(99286004)(26005)(52116002)(1076003)(16586007)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3701;
 H:CH2PR12MB4182.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 817D+OwS7vpEBb+o93ThKB52XvBqjjnreX9+/VxmDVKr24TOS2/vVCpuZp7k+f+uHOH0lpzLM/fK5bTzFoYwb/8XZ03gFk0q7At1tC20D4QT94Bw9Yit+5N/g7DcozXfYo48bU42ClAdRv+fO32gvFB9jWG2LmkEtEilfZaEWO/ZH7gXpGyjTG950QofkVdJXVNZmi9dtam4WJeGbSI0KZ2VNB0jCBXX8UXRNieeJa1JJbWZxpFlrW/6QCM4tNZpE12fKvehvlELAHhxkdXW9IejFeo1YzUOgiXGLOyaDQCto1Ah0oYqK3OxTq4vluTGz8OXPZgJ34Jw9n7U6B0wFIeLD3ybOWJFHE9fHCt2Q2c/Zl1h7V/x5XhXFe7ql/l5pHxsuD+3DYqaBgEhMxHXZHBGKWKYXhdVsCoBgsrqfXnxTbPuWruCO32deULfL3iF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177dc1ce-2136-42a8-71c8-08d76c763571
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 22:25:25.6813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1v2qs/6LvtrPA48o7jtdjrseBbGUaQIeAn5DBZYu+12Zx5+wXNniIcim34HCsoTLn7575+VfGl0uLMZ4okUdZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3701
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZjINTE3L0Gyn4J6yqkDS4mkJg4HDqfEEM2Dci8w2Wc=;
 b=RZZ39/gXK53Cs1eo3SBeYDMNC+ImAOR3SheFRUkJuz+2yL/Bds3dqd4lx2ite6MYZvjdoMiLTqeHm/yNeDfIF5jRxVyq7RHcNFhDIW9H8xizhxtMClQK6X2/xQeGeCdAx1aF4cAa379sNs+lAu8GGKbaHCropUz/tOt7RV+vpi8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118222434.K1A3hUVQY8pD4oGl0vdTB217VO1FGlE6IxgVjMRh758@z>

RmxhZyBhZGRlZCB0byBpbmRpY2F0ZSBpZiB0aGUgYW1kZ3B1IHZtIGNvbnRleHQgaXMgdXNlZCBm
b3IgY29tcHV0ZSBvcgpncmFwaGljcy4KCkNoYW5nZS1JZDogSWE4MTMwMzdmZGEyZWMyOTQ3ZDcz
ZjVjNzMyODM4ODA3OGZiZWViZTUKU2lnbmVkLW9mZi1ieTogQWxleCBTaWVycmEgPGFsZXguc2ll
cnJhQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMg
fCAzICsrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmggfCAyICsrCiAy
IGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMKaW5kZXggM2MwYmQ2NDcyYTQ2Li5kNTFhYzg3NzFhZTAgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCkBAIC0yNzEzLDYgKzI3MTMsNyBAQCBpbnQgYW1k
Z3B1X3ZtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0g
KnZtLAogCQlnb3RvIGVycm9yX2ZyZWVfZGlyZWN0OwogCiAJdm0tPnB0ZV9zdXBwb3J0X2F0cyA9
IGZhbHNlOworCXZtLT5pc19jb21wdXRlX2NvbnRleHQgPSBmYWxzZTsKIAogCWlmICh2bV9jb250
ZXh0ID09IEFNREdQVV9WTV9DT05URVhUX0NPTVBVVEUpIHsKIAkJdm0tPnVzZV9jcHVfZm9yX3Vw
ZGF0ZSA9ICEhKGFkZXYtPnZtX21hbmFnZXIudm1fdXBkYXRlX21vZGUgJgpAQCAtMjg5OCw2ICsy
ODk5LDcgQEAgaW50IGFtZGdwdV92bV9tYWtlX2NvbXB1dGUoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLAogCQl2bS0+dXBkYXRlX2Z1bmNzID0gJmFtZGdw
dV92bV9zZG1hX2Z1bmNzOwogCWRtYV9mZW5jZV9wdXQodm0tPmxhc3RfdXBkYXRlKTsKIAl2bS0+
bGFzdF91cGRhdGUgPSBOVUxMOworCXZtLT5pc19jb21wdXRlX2NvbnRleHQgPSB0cnVlOwogCiAJ
aWYgKHZtLT5wYXNpZCkgewogCQl1bnNpZ25lZCBsb25nIGZsYWdzOwpAQCAtMjk1Miw2ICsyOTU0
LDcgQEAgdm9pZCBhbWRncHVfdm1fcmVsZWFzZV9jb21wdXRlKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSkKIAkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
YWRldi0+dm1fbWFuYWdlci5wYXNpZF9sb2NrLCBmbGFncyk7CiAJfQogCXZtLT5wYXNpZCA9IDA7
CisJdm0tPmlzX2NvbXB1dGVfY29udGV4dCA9IGZhbHNlOwogfQogCiAvKioKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgKaW5kZXggNWNiMjVjMWM1NGUwLi43NmZjZjg1MzAzNWMg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCkBAIC0zMDEsNiArMzAxLDgg
QEAgc3RydWN0IGFtZGdwdV92bSB7CiAJc3RydWN0IHR0bV9scnVfYnVsa19tb3ZlIGxydV9idWxr
X21vdmU7CiAJLyogbWFyayB3aGV0aGVyIGNhbiBkbyB0aGUgYnVsayBtb3ZlICovCiAJYm9vbAkJ
CWJ1bGtfbW92ZWFibGU7CisJLyogRmxhZyB0byBpbmRpY2F0ZSBpZiBWTSBpcyB1c2VkIGZvciBj
b21wdXRlICovCisJYm9vbAkJCWlzX2NvbXB1dGVfY29udGV4dDsKIH07CiAKIHN0cnVjdCBhbWRn
cHVfdm1fbWFuYWdlciB7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
