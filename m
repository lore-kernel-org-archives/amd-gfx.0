Return-Path: <SRS0=44+a=ZL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AE4C432C3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 16:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB5E208CC
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2019 16:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB5E208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C591F6E91C;
	Tue, 19 Nov 2019 16:38:09 +0000 (UTC)
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730059.outbound.protection.outlook.com [40.107.73.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 855596E9D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2019 16:38:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5awC+Sq7dLkNXMC1SEggnvgs2PGjdQUhpwUFQXuGMMkkVPltgCE2xq9wQCm2BethXYu7t6YMMgMPBjx+L1OSlnM0Po5+u9HaIQ5Dt3LFEnTZHhIVgun7sgb74U10JqoUmtI9cOSVU8/4qvi/H0ejXGdTuopTJLFAznOoS8atQJY+wl3aP8esG7sdzCuir+ok9axTUJSZDlk7gxHW0ZJnhd92YZVS+9nWJoYu/TV/jZGhg+Hp0oqPVTDFth8iKPd0yBaCBb7Si8v8imLvGEsuwc8YsstTU3S7N0Ye7ZHSEEeEqvUP1BRvxCvSfUvu7F59u5V+1Cx9JuEyyPW1AQHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZjINTE3L0Gyn4J6yqkDS4mkJg4HDqfEEM2Dci8w2Wc=;
 b=Ianev29T/JoMYCYR5+V7lVLW97a/jn6dT5hHYAO5sTX9SwzV/oE8Tf23Ko9jtGVm/wvhLXeUM3Ha6EaGrw4Th3o+S/5qSfke9vPuTanT8evJQnpUtJ9Xfe3cEUcOOOeBRl8//bimspQAxgO9k93GeRViYwRM9r2lORL9bIk06yXn9B+0JX0xyuSdvig1+4/Mn+wlUg5L6QvXq43wGtdSqnS0DoMTae9zrCi+ZFDRqZb5kXsmVrXUVhtuPIuDrjU0AbaIJumrlUcaYm9aNa52vi2n+F5LwugqNNVW1QoXzMlN6Oy94XTeMFDfIKv6oV/Na5A7R2bq2I0ZB1Qde3bHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CH2PR12MB4182.namprd12.prod.outlook.com (20.180.16.11) by
 CH2PR12MB4325.namprd12.prod.outlook.com (20.180.6.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 16:38:07 +0000
Received: from CH2PR12MB4182.namprd12.prod.outlook.com
 ([fe80::24d1:40a8:f811:6be1]) by CH2PR12MB4182.namprd12.prod.outlook.com
 ([fe80::24d1:40a8:f811:6be1%6]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 16:38:07 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: add flag to indicate amdgpu vm context
Date: Tue, 19 Nov 2019 10:37:53 -0600
Message-Id: <20191119163754.4966-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SN4PR0501CA0051.namprd05.prod.outlook.com
 (2603:10b6:803:41::28) To CH2PR12MB4182.namprd12.prod.outlook.com
 (2603:10b6:610:ae::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a3a1ec63-5ea9-4699-5c21-08d76d0edb0f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4325:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4325B164EC0D04AE846D1FA2FD4C0@CH2PR12MB4325.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 022649CC2C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(199004)(189003)(48376002)(316002)(50226002)(86362001)(14454004)(5660300002)(16586007)(66476007)(66556008)(6512007)(6666004)(66946007)(36756003)(486006)(2906002)(2361001)(386003)(66066001)(6506007)(26005)(52116002)(47776003)(8936002)(2351001)(25786009)(44832011)(6436002)(3846002)(478600001)(81166006)(51416003)(6486002)(305945005)(8676002)(6116002)(81156014)(476003)(99286004)(4326008)(1076003)(186003)(6916009)(14444005)(50466002)(7736002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4325;
 H:CH2PR12MB4182.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hafuf9dT7hhQ2dAR0ypXCicnNam/qfBsEVZq2Af466+EnLQ694MmzUd1/3fZDQOyqpi0bIzk28gqbStSvIjGxlGY3qJGdMvKy2SnxPz4L24AILWAho8k88xzlaqLGuB7NNuO6B9A+5hcnKT1e4x+lK5KmQGKMXcgxPSh5ZoJUrliqv5KaYob9Y61fmt66oDPuiw/A2NJi8lSDF4M6FQopQXWVWeo6XD7AYktBl0jyOVNNb5X82PpizcnsVoRqs8jRpCQL3rtRhbt/2k2g8qn04ioI4wiw8szCnozd0pXxDlhMqFxpU1bphibZOMIyKr8mxqNQ3B4VHiofDKHjyAx4lnMvn8Z5J29IVwpFo6/IdYdz2otF/3JGAyqep1UZGMV74d54L8uV23/E+cJrXBMRkAoIoIp8ZJfC0K5cgfCNCeEN28M6kbuE5KYcjQptFMZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a1ec63-5ea9-4699-5c21-08d76d0edb0f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2019 16:38:07.0372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNcimVtZpuqK8cmy/g8pKVtpvCvHNH80y7sStXYDR6rGyRP0i7bmfBQpnwJvEqHLHFnSAmqS5e9qYEGHSk62jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZjINTE3L0Gyn4J6yqkDS4mkJg4HDqfEEM2Dci8w2Wc=;
 b=2W/fWnVwAvI0ygOW4geJ4vZNPmRRH7IMD+gUeCDDrQqohESNxtJIeGo1lZHk706O935UjUNEAWnE1NihJulrzO2H3ljuDDfiDLTqJlpUqJQwyvH9/2yF12qYhy8ULTF1mpsL5N2kw5jiT/2ow/jmzIKI4zMksrOyl6gTUtMGsMU=
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
Message-ID: <20191119163753.L4zur0581PHyj5qyIpbSF9NEZi06XyWBAHMx_3C6acE@z>

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
