Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ED7C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613272067B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 18:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613272067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04DB36EBBA;
	Tue, 12 Nov 2019 18:04:27 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690042.outbound.protection.outlook.com [40.107.69.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70F4D6EBBA
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 18:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czVRt8duNobSxL35uKTHn0rIi9eEVUeyppktgrQN/uFfpmffukSKKCbj0xV5/j3YCA1p2GY9mTL2xBcJbnP3etQ9SpEYZo2zygX4BN2uAGRm3K0Apl99UGOuSXzpDXEJ02DxqnJmcambI3HYQ5Z+mHKqWMpkDW/KEjjtyLLb/jqtx1sVVTVrYyHcerLaRN2C6ZOQigwIuZt/Jic7eBY5djGbdMohUtmYQIz9Hy2r1xwc5udMaxzbU/IPJoRBGX2m3IhwUfcRx21XL45AbKf/Bd6bl9yTEUlfsKCj87+jDvtbsQqk0auJtOEZIDJSp1mNoWoxrxXg5SmUJrLqFbbVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuPg9iUb0ZHoH5IcfFSILVugpv1/5h1K+v+uf3tJllY=;
 b=PFlOlNGVb0mMM5xEif/j9EQld2xnsce+WygwwZaem4MFfJMC4gxXWhd5+EQW/xobi+h1ZYPqsJqjYA2mh9ovKxoPgwpLA8olgSkaPr24hgjYEPzkbe57sRGm0Jt7HynlIQALi+puXAD8qotmTBWV38EZ8IhzBC8/adb6m+3jxMBqXhHsLwzz8NrpVG1YvGxc/Pvd4E1a6qkozOGHLnzpj7uMqJRQT4olDSjeFMOZtGchWpJCdek/erOvEUpK9gftJdd5+4cYBtfoFWOot0fEuSSTx6JxRpMfrV+Z+sVxkSLgkGHqXXg09YhF1W/czJY8h2r+8GwNcNNyaWeXg8/x7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM5PR12MB2456.namprd12.prod.outlook.com (52.132.141.37) by
 DM5PR12MB1580.namprd12.prod.outlook.com (10.172.40.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 12 Nov 2019 18:04:20 +0000
Received: from DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b]) by DM5PR12MB2456.namprd12.prod.outlook.com
 ([fe80::75bf:bd52:2f61:656b%7]) with mapi id 15.20.2451.023; Tue, 12 Nov 2019
 18:04:20 +0000
From: Leo Liu <leo.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/21] drm/amdgpu: enable Arcturus JPEG2.5 block
Date: Tue, 12 Nov 2019 13:03:29 -0500
Message-Id: <20191112180329.3927-22-leo.liu@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77c6cc5e-d908-4e6d-fe6b-08d7679abd8b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15801BC7A0CEFBCBE2F39E12E5770@DM5PR12MB1580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(478600001)(6512007)(305945005)(186003)(26005)(8936002)(6436002)(6486002)(5660300002)(76176011)(99286004)(25786009)(14454004)(51416003)(476003)(446003)(2616005)(4326008)(386003)(6506007)(6916009)(16586007)(7736002)(316002)(52116002)(4744005)(86362001)(11346002)(50226002)(486006)(2361001)(8676002)(44832011)(1076003)(36756003)(3846002)(6116002)(66066001)(47776003)(50466002)(2906002)(48376002)(66946007)(66556008)(2351001)(66476007)(81156014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1580;
 H:DM5PR12MB2456.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HyjfHGcM4vqLpXIDh9ZwpWzmgT7wbMYDpvncsGARBagKRLlHHcH5XGYf8THfEh5SgpvxXs0kGPLmyp3rLDWGMwjCS5iWwjiqQZ92noPp8Zq2HymEznEFO4zY4IO3SE4IkPx6jFMFVJ3smXVgiW2eqZgZnORWWnk4GK04pBxRFbfFLWTPadRaM4VzV9yaCv+MKTVj7tIY6Te6XSxU7yy0pdw4wsGDfCbXLLUiO9QvEV6mOUvydH9fy91LP9hjwnTdzJVaa5OVfkrWRg5hNluDRtcue7DfEP5iQfMzFx3Z4HtuY0i9pcEZHki2uz7p/4RUvPqzuuoE5Fpm/lfgh2BD6ZSKX6lFA3szufdp+kjLy/EOSsQrXfg/Ea4TqebMdF4RBmt2/M/3Ot1SVSzd93tudn+4RL7tUU8XjzeTYlZ/URVZ5RPdqQb/hKjP8/IiMYfs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c6cc5e-d908-4e6d-fe6b-08d7679abd8b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 18:04:20.1306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWzCuDeL1UCeNALtuWS6Nsg4W2G3tI3/8JlsKRfvTQu0ZlVBW2gHNjFlqgYOUiVI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1580
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuPg9iUb0ZHoH5IcfFSILVugpv1/5h1K+v+uf3tJllY=;
 b=KMVd4KXuMYk3rYdM6+DbrdCx4g333m+jmvQTm3qoQqm8HLVl5+sswBwzhyEJJlWoD+VTaIdkmo29SM3JkJA8+nsql+fb5doB++IWUOEB/TLCdCnHATaCo3opDYmcQi0HXX4anV0uLUCxDczMFVNa1YVuVCWl0EW5ZC6qE6ubfnA=
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
Message-ID: <20191112180329.bBEr6FHfZCThlIryrNi4yzrp8m7sb9bBT0rhQDW15Ng@z>

SXQgYWxzbyBkb2VuJ3QgY2FyZSBhYm91dCBGVyBsb2FkaW5nIHR5cGUsIHNvIGVuYWJsaW5nIGl0
IGRpcmVjdGx5LgoKU2lnbmVkLW9mZi1ieTogTGVvIExpdSA8bGVvLmxpdUBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgfCAyICsrCiAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc29jMTUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMKaW5kZXggYjQw
NGI3YTZlNTkzLi42ODlmZmE2ZWRlNTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NvYzE1LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwpA
QCAtNjksNiArNjksNyBAQAogI2luY2x1ZGUgInZjbl92Ml8wLmgiCiAjaW5jbHVkZSAianBlZ192
Ml8wLmgiCiAjaW5jbHVkZSAidmNuX3YyXzUuaCIKKyNpbmNsdWRlICJqcGVnX3YyXzUuaCIKICNp
bmNsdWRlICJkY2VfdmlydHVhbC5oIgogI2luY2x1ZGUgIm14Z3B1X2FpLmgiCiAjaW5jbHVkZSAi
YW1kZ3B1X3NtdS5oIgpAQCAtODA0LDYgKzgwNSw3IEBAIGludCBzb2MxNV9zZXRfaXBfYmxvY2tz
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCiAJCWlmICh1bmxpa2VseShhZGV2LT5maXJt
d2FyZS5sb2FkX3R5cGUgPT0gQU1ER1BVX0ZXX0xPQURfRElSRUNUKSkKIAkJCWFtZGdwdV9kZXZp
Y2VfaXBfYmxvY2tfYWRkKGFkZXYsICZ2Y25fdjJfNV9pcF9ibG9jayk7CisJCWFtZGdwdV9kZXZp
Y2VfaXBfYmxvY2tfYWRkKGFkZXYsICZqcGVnX3YyXzVfaXBfYmxvY2spOwogCQlicmVhazsKIAlj
YXNlIENISVBfUkVOT0lSOgogCQlhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmdmVn
YTEwX2NvbW1vbl9pcF9ibG9jayk7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
