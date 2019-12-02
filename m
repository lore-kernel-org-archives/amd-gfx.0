Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D39C43215
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0646320848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0646320848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C5F96E2C8;
	Mon,  2 Dec 2019 17:35:54 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800054.outbound.protection.outlook.com [40.107.80.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A3A6E28A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaYhnIwhKAcfY/v7YwZ38krhbyJzAh6hbXUkECXa6dp9dMvbBK/Lz4F4ecloqPK03lhNTZ1eDzq8wgJ3V4ZzAOB6H9z2TYdCUdUO4UXM6+L+utdaNLSjrifb4cBK82XNnl61HL1HS8uyxIeGCFGkJlVQv5fNA6Iq/rfWp8fxkOUPS6CsuZafqXNyTJ2teQaRGNjfyz6ZI1O4v5NYEGSRsiWeDEWLV/q9JRUjcKzuqFHxpwnl5VYwSq0UZe4DsoSje7a6mL+kuQ7b8Kr4oEk1vEB62hlQC98MJElInRFrgqr61FTdpLFDooYCToNedFNrd4z8hYqcMTGg4Il4tX3JoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHdpNFrdneGzOPHuCqrbBzNHcUbA5SIjazEeaSkLAUE=;
 b=FuPaDUpDOp1fK5T68Y43rF5yCuTHo8H3ZwHmMrT198eagK+hpojqmpAsz3rlWmHd63qLfNhdnIDsmDBUAsHjGH2ZRuekk8N6R1QCKfUtjunxjJ/2cDOOpgm4fIUNLk35Y+jE1kLZybDGvA05WkWtHtQUMDGIsyH3/lqJlnzUVt5opimK2vVet8GuxL3pEX2COjqJJy9MWNlvXPPvDyPqmajYa0nBoRCZ9PcXJ2AYddqxE5+/ZbJcTaed1JaA6t7LefLrX0qPufuQri9ompHYMlYdgMYz+4TRMB6KMYYzeEwL5cU+aOTPC2CwPWlgGtpe7OAZvs57oUT5Sd2SVjAKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:50 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:50 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 38/51] drm/amd/display: remove spam DSC log
Date: Mon,  2 Dec 2019 12:33:52 -0500
Message-Id: <20191202173405.31582-39-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202173405.31582-1-sunpeng.li@amd.com>
References: <20191202173405.31582-1-sunpeng.li@amd.com>
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23ce1660-5b01-410b-0ef2-08d7774e01d7
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB261027A49CD848FF6D09E80482430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(51416003)(52116002)(6512007)(66476007)(66556008)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(14444005)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hepq73GIHbXIoBK9C1bNLliFQTKc3+ifR+eq9P+Gj/Hp/nWedBczhSFZiDYckLYaXbpPbBuFnfue1iHj/K6TAj390/WAxLvNUE5oUs62ieNN9GBWbsM91uJXy8JpKeYQmSjiaQJ2HWCnYvru8kRCeJ62XsZsF0W9FmJ3jecvsnqS2lSfBYwwYpjRbm41nDGYD5UYArTSpRAlR7ojNwR79ZGFjLhTgC90N4C4YDVMNBS4v27YSL6uJs/XpeIS8m7Uu78mFolcmYy9sdUQODVrVL5HlWHE9c2AWCtCoGOp5Gi/YkvQs+A+UbJ+u0vCkkAHwv0BFVTr5c0NgWG+atONqVO6a2q47mdITTWPvg8+ciw0tk5McMds4lqm9k6thOXGZPFOYRDiFg+usag2CducB2RIZcMoLl8VpdoTwg4b8fepNvOCgKOP/lkKvhLP1yfz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ce1660-5b01-410b-0ef2-08d7774e01d7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:22.1538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAyODDXME6qWKNUvPuCtiXfeIgi9JBo56U9zUer2RCjGc4gCO1viqTXaI+uCqFFO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHdpNFrdneGzOPHuCqrbBzNHcUbA5SIjazEeaSkLAUE=;
 b=zSKa2Xasc2ms7ULUY5fMiy7H6a1J73orI5c9mah+6uhtpH8nbBKl0Ih4ZBX6NEDbjORgc+eoLQRUcg/4gRAC5H4MYDt27Y3AD7WQyeAbqkksfcspjJgpPmgO+ZRVmR3sQjD0bit70gOIAMxiWTYon69TDwCPMByw3T1foGhT1PE=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
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
Cc: Leo Li <sunpeng.li@amd.com>, harry.wentland@amd.com,
 rodrigo.siqueira@amd.com, Nikola Cornij <Nikola.Cornij@amd.com>,
 Wenjing Liu <Wenjing.Liu@amd.com>, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogV2VuamluZyBMaXUgPFdlbmppbmcuTGl1QGFtZC5jb20+Cgpbd2h5XQphZGRfZHNjX3Rv
X3N0cmVhbV9yZXNvdXJjZSBjb3VsZCBiZSBjYWxsZWQgZm9yIHZhbGlkYXRpb24uCkZhaWxpbmcg
dmFsaWRhdGlvbiBpcyBjb21wbGV0ZWx5IGZpbmUuCkhvd2V2ZXIgZmFpbGluZyBpdCBpbnNpZGUg
Y29tbWl0IHN0cmVhbXMgaXMgYmFkLgpUaGlzIGNvZGUgY291bGQgYmUgdHJpZ2dlcmVkIGZvciBi
b3RoIGNvbnRleHRzLgpUaGUgZnVuY3Rpb24gaXRzZWxmIGNhbm5vdCBkaXN0aW5ndWlzaCB0aGUg
Y2FsbGVyLCB3aGljaAptYWtlcyBpdCBpbXBvc3NpYmxlIHRvIG91dHB1dCB0aGUgbG9nIG9ubHkg
aW4gdGhlCm1lYW5pbmdmdWwgY2FzZSAoY29tbWl0IHN0cmVhbXMpLgoKU2lnbmVkLW9mZi1ieTog
V2VuamluZyBMaXUgPFdlbmppbmcuTGl1QGFtZC5jb20+ClJldmlld2VkLWJ5OiBOaWtvbGEgQ29y
bmlqIDxOaWtvbGEuQ29ybmlqQGFtZC5jb20+CkFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlA
YW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBf
cmVzb3VyY2UuYyB8IDEgLQogMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2Uu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5j
CmluZGV4IDJhYTZjMGJlNDViNC4uZjg1M2FmNDEzNTgyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYwpAQCAtMTUxNiw3
ICsxNTE2LDYgQEAgc3RhdGljIGVudW0gZGNfc3RhdHVzIGFkZF9kc2NfdG9fc3RyZWFtX3Jlc291
cmNlKHN0cnVjdCBkYyAqZGMsCiAKIAkJLyogVGhlIG51bWJlciBvZiBEU0NzIGNhbiBiZSBsZXNz
IHRoYW4gdGhlIG51bWJlciBvZiBwaXBlcyAqLwogCQlpZiAoIXBpcGVfY3R4LT5zdHJlYW1fcmVz
LmRzYykgewotCQkJZG1fb3V0cHV0X3RvX2NvbnNvbGUoIk5vIERTQ3MgYXZhaWxhYmxlXG4iKTsK
IAkJCXJlc3VsdCA9IERDX05PX0RTQ19SRVNPVVJDRTsKIAkJfQogCi0tIAoyLjI0LjAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
