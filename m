Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE0FC17447
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269B52184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269B52184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A986EA36;
	Tue, 12 Nov 2019 00:34:00 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800058.outbound.protection.outlook.com [40.107.80.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 877296EA31
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:33:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvQ0ncHfAaxLGp8Wl+sSR4fJkE5aDOyBnTJE2bCZBbrwOV/ImdhB5D8FjU5AkoiMGELkKnDctuXQym6fsYSrgMzHQTupgzQKCF0SQv4LP2H+YibZTPXz1dmw6WzetjF4cQayzF6K0hRP4rqQSRbYXIGtzDDMz/uRNB0Rn/cZWaseBaZ+08WCcIImJVX26jlEMXhDtKH0xP120yob60Kw4OfOx+dR7HvZ5Fw0eYJUZ3EVp4k7ZkiIFWALP8C3aVYwoGq6D0dQbOqmGxaySbKXQJONr3OJVp2g81VC3Oi5K0sBxuspDht1MrzngSp6BzSfXpiwlnhswgjeFJY860J9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUZZYXlJu4M+K/xVlirCW0DnkyZoCg2NJV7ZUkpdtVc=;
 b=V4NjOguqKoBT1GYQrGDXjdDfKxsTBpM70VAGdWvoIxI5KQUXHlNPMWgEJyjXJrAVBNrxgkE7CEbln6mMSUgvu2x27MuCpfxsWNnewPKhhLH2qRWEGWV668J3Uq+2SBp6Sc3/yKt2QGz5warx4EMlIy/C/qU/9gLGwe5JFaNSGsDjSiEKGzzzJaDGUo5w7zQefI0i7d6Z7Zd9KECEmY3lEXGZum4SMzzSxhg6AsxfFuiK+7ri9kMdP/Edj2q+1LXUbl6qGMqG/Apdpa3BrEnSuDOWZgKXS9XzV6Jt0RwS0+khnYuCfWX0UjqxJ2WcNL43Fn2SiRWaDRR45ePWyIKqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:33:55 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:33:55 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/30] drm/amd/display: Clean up some code with unused
 registers
Date: Mon, 11 Nov 2019 19:33:08 -0500
Message-Id: <20191112003324.8419-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
References: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be4c4b22-1ed2-437d-6216-08d76707ff9c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2554A73FFB71A5D1BBEDD6D798770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(4744005)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQEoToFoFvltaoCV5bwtn7hPEc5FJL9Io44mqeqp5xsadify7qnGeTuE1r/so/UQFhYrflMJfu8Y8yUl3DZnMSP9m2p0Kgy6A8GurvR2qe5JfXbnLa6Sbvul5oeceEsibuer52b1Xj/S5yNt9rwtuAe5YOo1mJqj6QMZZ/5L2vOASP8C3qVHMe8UaaqAxfGIga3untqT+h5SSdPSvQ1evMUZdIScdQ4qaY9bFGXolKSa8hMz5O81hL0A++gU/xkTnMPSjZCwHiYDkURioyXeiMHBOATXZF2BSzRcZSq/zlz5z82A6aspIs8bPDmt0J0FADXjq2mwbL8QxXVE6LI3qW+NdgtWxnvKi1VFBI4S+PG9N63pXlolcNGJToMFu8UKl6rRirbdSkcWcl1G/fsoaDmpySrE1P8U/0Rnr51W4oxVfWBIlhkW0pQFlMSoZyjq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4c4b22-1ed2-437d-6216-08d76707ff9c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:33:55.0593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cckoFcZBEubNMW/k030ArWjqzHUjHLUHJvY/DTLpbp+uUZ0pcNCzPBTERJRWEclgoihohamzlAiJtqR051yPeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUZZYXlJu4M+K/xVlirCW0DnkyZoCg2NJV7ZUkpdtVc=;
 b=DNSWUQ/xhADinTC0Ndz+hYNHD7/iC8NelqQ8XEQqL30GJSf1hWz0Q4maK8qCNaEl16StbeOTspKivJ/CVmYfq7l2LyC7lPXGGTGPUpewpTJM76KuIaVCW+wa7nMLFLGpjf9yfvzUho1VtH3EMzc44Fn2g/qYT5UPmoxNKl4XPJA=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
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
Cc: Tony Cheng <Tony.Cheng@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003308.lKT15BDoByTwAqMFLKTmXJZZ1AewSZVlD1L7y1ubZHk@z>

RnJvbTogQW50aG9ueSBLb28gPEFudGhvbnkuS29vQGFtZC5jb20+CgpbV2h5XQpVbnVzZWQgcmVn
aXN0ZXIgaW4gdGhlIGNvZGUKCltIb3ddClJlbW92ZSB1bnVzZWQgcmVnaXN0ZXIKClNpZ25lZC1v
ZmYtYnk6IEFudGhvbnkgS29vIDxBbnRob255Lktvb0BhbWQuY29tPgpSZXZpZXdlZC1ieTogVG9u
eSBDaGVuZyA8VG9ueS5DaGVuZ0BhbWQuY29tPgpBY2tlZC1ieTogUm9kcmlnbyBTaXF1ZWlyYSA8
Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY2UvZGNlX2h3c2VxLmggfCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY2UvZGNlX2h3c2VxLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNlL2RjZV9od3NlcS5oCmluZGV4IGViZThmOWEyMWJlMi4uYmZmMDNhNjhhYTAxIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9od3NlcS5oCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2h3c2VxLmgKQEAgLTc5Miw4
ICs3OTIsNyBAQCBzdHJ1Y3QgZGNlX2h3c2VxX3JlZ2lzdGVycyB7CiAJdHlwZSBEMlZHQV9NT0RF
X0VOQUJMRTsgXAogCXR5cGUgRDNWR0FfTU9ERV9FTkFCTEU7IFwKIAl0eXBlIEQ0VkdBX01PREVf
RU5BQkxFOyBcCi0JdHlwZSBBWkFMSUFfQVVESU9fRFRPX01PRFVMRTtcCi0JdHlwZSBIUE9fSERN
SVNUUkVBTUNMS19HQVRFX0RJUzsKKwl0eXBlIEFaQUxJQV9BVURJT19EVE9fTU9EVUxFOwogCiBz
dHJ1Y3QgZGNlX2h3c2VxX3NoaWZ0IHsKIAlIV1NFUV9SRUdfRklFTERfTElTVCh1aW50OF90KQot
LSAKMi4yNC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
