Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C4EC433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 10:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D724520775
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 10:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tN1kntYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D724520775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9026089B8F;
	Tue, 28 Jul 2020 10:22:38 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750084.outbound.protection.outlook.com [40.107.75.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D77989831
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 10:22:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bp9YS8f/M6Jd083d/T4jQ1HmQ1gHukNI62lIWYCwBrxuQGUGpfq+/9GVuhN4YLrq23NMn9BwSbj6fxdCxhMf/KzW8+vk4MdNvU31QvLAZcI1iUI7as1B3N2OXjlLC2iZZw2ayU1DyAovFrgZuf+UVdQGoGTmaGEguRLyD93P9evma41jisWOvC9pOjTqkUb9a2YalfycPGpROrcvAPl1w8Ew4GBYnYSQycsA6XjRzjvesquJYuA2PzRbtrVmPpB13IDPlDJPtiiNdwgpwNqOu1zzDQTaefylfe0oVna/zwXJR1q09E+P+YMy6bwS6crarB0HX1772oF1v0JAlX71FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9dpbXNyCSe4D93gOblfSRkPKuIh6EU4juRtn5sP1i4=;
 b=GVS5gB3w/gbBzDB9ZJUGO4fc7x9vnpXYAWsC4/RUUNYZjHqFynV83e7NOV8mQgyYZ2/kUIxtl4sqTjlkgu4XZi0MsNgtvyFK9fRHzzLG4zrP27c+c3Nj8KVqhPX56ThuXou99nURVKNCmuW8y2CSYkvkU7LoVJXNuppvzW4E/hlPgZjplfufRk+VGrTHXoU06E5rFyA9W/PRKjvPBLABM4EhBxxVNYpY5BR8s7yfAzH/I23uTqZdpiuABZDCac7giFan99xpOiEwjeSTVcuTW1WFXSmYFCrzT0CxyuU0VzpnH01LBq8kOjbji11dO6sfrCJhvFPMX4giBWxHzDjIrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9dpbXNyCSe4D93gOblfSRkPKuIh6EU4juRtn5sP1i4=;
 b=tN1kntYu36I/tzqHM4C2p1I4eFibb1ZHvv26vVHhe6eoacZoJJOMiKfrmENkiZSWknejFKoK48l9L/SBGDQ2Q8fu2komkvy+JcnXX+A2zpGLaAuEWHklSmiEkIdt/CgQS7iPrnCDu4f6BGroyvYC70vsomnmtAfdCDtp+leEaro=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB2471.namprd12.prod.outlook.com
 (2603:10b6:903:d0::10) by CY4PR12MB1847.namprd12.prod.outlook.com
 (2603:10b6:903:11c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 10:22:34 +0000
Received: from CY4PR1201MB2471.namprd12.prod.outlook.com
 ([fe80::3912:f141:7c9c:ea33]) by CY4PR1201MB2471.namprd12.prod.outlook.com
 ([fe80::3912:f141:7c9c:ea33%9]) with mapi id 15.20.3216.024; Tue, 28 Jul 2020
 10:22:33 +0000
From: Jack Xiao <Jack.Xiao@amd.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Hawking.Zhang@amd.com, Christian.Koenig@amd.com, Le.Ma@amd.com
Subject: [PATCH 1/4] drm/amdgpu: define ring structure to access
 rptr/wptr/fence
Date: Tue, 28 Jul 2020 18:21:51 +0800
Message-Id: <20200728102154.2505095-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK2PR02CA0146.apcprd02.prod.outlook.com
 (2603:1096:202:16::30) To CY4PR1201MB2471.namprd12.prod.outlook.com
 (2603:10b6:903:d0::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jackfedora30.amd.com (58.247.170.242) by
 HK2PR02CA0146.apcprd02.prod.outlook.com (2603:1096:202:16::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Tue, 28 Jul 2020 10:22:31 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c638bfc-d12c-4d17-c30b-08d832e02424
X-MS-TrafficTypeDiagnostic: CY4PR12MB1847:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1847E73D63318B323F08286BEF730@CY4PR12MB1847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Y81Bs9rMx/0QOwfZAOsuTxCguPBdjE5ysCOX2/x86FmvzgqaOfHw4czL1STX/4Bo3t/3ghSSdw9pAw3hiXKCVOqRDB003TVr3vJ5wec+pKY7uuYRYLfAcv5zUBiY9krlDcRVBjb5jJc/NB9+N9nREe8D3MenPi5cPY51XAfpkbiobjE+i+/uimopcM9EgH+9IDcq7U6g2bH/L5rfyjMgdgRnWktCa5uf0qtnEsWCzPp85nFLzQqR1Q+1zAsJVqzIZNHt3hW0IwsLtjF3Y0HqAtwAJ2mRUIUD+0uyoVtd/V6gOiizzxekGBnmX993x9n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB2471.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(26005)(5660300002)(86362001)(1076003)(6666004)(2906002)(36756003)(66476007)(66556008)(66946007)(16526019)(66574015)(52116002)(7696005)(478600001)(4326008)(54906003)(6636002)(956004)(83380400001)(2616005)(6486002)(316002)(8676002)(186003)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1dwLAX6/D++IJLVX96BDZwsAurLxmb0xey5qfAc8SgQkli/X13QNf/S2FPK/txZIXo0CmxvxoLztd6gIpeTvjZ9woSqFUwrHhD7owTo0R4wYUmceVz2TybfC0Qox+VaitBa4ZgnEgnXvP7PgNGk5qVmQx6geISzzpxgXp+VvKH79xEfWGl8p9Q2Rhrs2qwCymAFCDC818XPJT5gX5NZM+ZMRUeXDJjPF+YbWpSPn32dL83J0iGh/sbQ26cFfETclEL6YxeFfyQXCLlV0WQnEjfYxdDqNI385F5G/RDQkFna74Mmem/Hl6JQv5CCgOcQfv/gfPn9v4AmdftkqtRG5Ga4V+xc3qL2HFw/qymGQIy3Jyu4IwgYwMecotXRKjA0NOXPe4S1RQdrN5/LohrW1n3x6EVJuTI+wrLm0yiLXQZ8DFUsqgHY7V1df8URLryhYLfaFfq/C9JTi0LW2MCCVavYACuEkVyBXUplj/qgU5/ATuGY5vkAUc8rL3cKkGt1w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c638bfc-d12c-4d17-c30b-08d832e02424
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB2471.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 10:22:33.7645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJ9QC+Gs5QwSovW6/G57eOBSUdnvjfogtzoCSVOrEq2nOaMN8MqBB7k+jQhRJgfT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1847
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
Cc: Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RGVmaW5lIHJpbmcgc3RydWN0dXJlIHRvIGFjY2VzcyB0aGUgY3B1L2dwdSBhZGRyZXNzIG9mIHJw
dHIvd3B0ci9mZW5jZQppbnN0ZWFkIG9mIGR5bmFtaWMgY2FsY3VsYXRpb24uCgpDYzogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTdWdnZXN0ZWQtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogSmFj
ayBYaWFvIDxKYWNrLlhpYW9AYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhh
d2tpbmcuWmhhbmdAYW1kLmNvbT4KQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmluZy5oIHwgNiArKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuaAppbmRleCBkYTg3MWQ4NGI3NDIuLjk0
MDYxOGQxYmQ0ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3JpbmcuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oCkBA
IC0yMDgsNiArMjA4LDggQEAgc3RydWN0IGFtZGdwdV9yaW5nIHsKIAlzdHJ1Y3QgYW1kZ3B1X2Jv
CSpyaW5nX29iajsKIAl2b2xhdGlsZSB1aW50MzJfdAkqcmluZzsKIAl1bnNpZ25lZAkJcnB0cl9v
ZmZzOworCXU2NAkJCXJwdHJfZ3B1X2FkZHI7CisJdm9sYXRpbGUgdTMyCQkqcnB0cl9jcHVfYWRk
cjsKIAl1NjQJCQl3cHRyOwogCXU2NAkJCXdwdHJfb2xkOwogCXVuc2lnbmVkCQlyaW5nX3NpemU7
CkBAIC0yMjgsNyArMjMwLDExIEBAIHN0cnVjdCBhbWRncHVfcmluZyB7CiAJYm9vbAkJCXVzZV9k
b29yYmVsbDsKIAlib29sCQkJdXNlX3BvbGxtZW07CiAJdW5zaWduZWQJCXdwdHJfb2ZmczsKKwl1
NjQJCQl3cHRyX2dwdV9hZGRyOworCXZvbGF0aWxlIHUzMgkJKndwdHJfY3B1X2FkZHI7CiAJdW5z
aWduZWQJCWZlbmNlX29mZnM7CisJdTY0CQkJZmVuY2VfZ3B1X2FkZHI7CisJdm9sYXRpbGUgdTMy
CQkqZmVuY2VfY3B1X2FkZHI7CiAJdWludDY0X3QJCWN1cnJlbnRfY3R4OwogCWNoYXIJCQluYW1l
WzE2XTsKIAl1MzIgICAgICAgICAgICAgICAgICAgICB0cmFpbF9zZXE7Ci0tIAoyLjI2LjIKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
