Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8D1C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 21:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7881A2084E
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 21:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7881A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D9B36EBF5;
	Tue, 12 Nov 2019 21:26:57 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760040.outbound.protection.outlook.com [40.107.76.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58DDC6EBF3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 21:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IH8NjZzSkicJyObCGoy3oGc72pK6wjGdvoi25WmD8WEQsBtBN8cqVj8B9GripSJFmmiGJnsUTxbj1R128x1V+6xme1lmbXmd33M1stp0mynGp4UqNiSdvAoC7oyJNsabnmQE/Ks28dC6rtJSAxEC4jdzGGWbHG5Z4jbH3j1vmuywzSNmWr+aUP46il+ORtBxytVk5DArLJE/7TlxOXiKobdG+Jdbhh2BFlTx92m1Fh3vLdLBBKI3PwgXQ6r2PZMZv9UDjtis3rL5M73UxMQea33M8o45NW4d0gb7PAFuqxBGLhJed+G7PgfwR7XBdattkPMqWYyJISdojNF/D55yoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQXXrH3GWGBW/1TS54lOXZdL5NJAQLjSgH/M98v27xM=;
 b=TmjzAZI4fWLJSFRZa2jqrJcrwky742gscT3EEUDCCzXL9tvglhM35hC/orpH80OjNoZPL7CO4xiJ5feWEdWUuLmBbR/Zdi1Ym7nID9NT0Ej626dJVRwVM6hI2s5kkUb1UTllMPnQd7Z6nIeoUoZUVIp4kKZ+XIO+3JZnAiQVLmlkc1yLU/YPBBDrsViPy7MiaCNnuoZT6oSctpf4cFb/QWpKiEIkxZThSwxTMJqqT3zOE6msEfjI1C2y33gPqkx1MzfQkTk+S1sMwwcHl7a0O+N27Ce0ukQ0lDqTL44Urv3OlQ+eUQiyxIgj4Wt6FZSTQaiHgG605hIJ9+oH2HxQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3372.namprd12.prod.outlook.com (20.178.30.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 21:26:55 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 21:26:54 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: Stop using GFP_NOIO explicitly for GFX10
Date: Tue, 12 Nov 2019 16:26:41 -0500
Message-Id: <20191112212641.4643-2-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112212641.4643-1-Yong.Zhao@amd.com>
References: <20191112212641.4643-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YT1PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::15)
 To DM6PR12MB2778.namprd12.prod.outlook.com
 (2603:10b6:5:50::17)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d0a5994-d150-4dd8-2915-08d767b70a48
X-MS-TrafficTypeDiagnostic: DM6PR12MB3372:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB33729C6FE408DC2084854C9DF0770@DM6PR12MB3372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(50226002)(6486002)(66476007)(6436002)(2906002)(6116002)(3846002)(81166006)(66556008)(8936002)(81156014)(99286004)(16586007)(8676002)(316002)(50466002)(66946007)(1076003)(5660300002)(48376002)(6666004)(478600001)(14454004)(6916009)(51416003)(52116002)(6512007)(76176011)(4326008)(47776003)(66066001)(2351001)(14444005)(2361001)(25786009)(86362001)(11346002)(446003)(36756003)(305945005)(476003)(486006)(186003)(7736002)(6506007)(26005)(2616005)(386003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3372;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2RP5TJz68ueNLgFmJn9EcXeVXSmOOuUAoySd1/N64feyJwYBVE166/KGtBCFpSr4jQszOH4sKBiJjQY3VuFIXJn4NCf19TiNYzNJpUWvrtzGYlK2oKQMni63WfwtD+69RPdqBqiboTJZzRZ/keGTDAAcH/h7rvl2U7NjwIMpewei4WgIbHSWmg5QRwaNxPqSKTThOcuYxMGzivvn8GQ/zuHuJxoK1eYpBQGqhIAS79wAy3bTVuORPK+AbNgHllcUdUp9A1ukkH1bRnoSlmIYr+ANJ62rxkhPJvmZBqtMA3KRRLOFCeYaB9L7GfzuwufJofVmLJEzFizswyIVEa/jiNKv5BdXCk2Fynovj8SDwm4TjLWs5CM8UOOisokscblea/X6FT+yEYXP/ZCKhkwSlcz0+mpXSigOctDoR87oNcqBNzix6b6sVq2gnPIk7VuH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0a5994-d150-4dd8-2915-08d767b70a48
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 21:26:54.6751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FW4iGlkwoB7Oe9F1V6K6IiU0Vqh3zTU9O5xDyD9snyfBmxpuXODr5h2M/wGu2AdD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3372
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQXXrH3GWGBW/1TS54lOXZdL5NJAQLjSgH/M98v27xM=;
 b=Y1DlAl1snn/sPwDeiQo1jyavqrBeWnjoQ9i4Pr5glXkXJrHGdjF96lmvdO5kZLrWGFd+pm5+Gka8LXY1md2SEfLHcTcfK0nppJyGzUWJyxnOBjGEw+Ba/rNC6k4+VLNVTJ57LlHlWxNrjbs/Rv/DPS55HKlWNTxz7Nb9rSyqaZ0=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112212641.od5Pbmwt-UKdVK8PLPohhgL7362tK38SjOJO72ezj-8@z>

QWRhcHQgdGhlIGNoYW5nZSBmcm9tIDFjZDEwNmVjZmMxZjA0CgpUaGUgY2hhbmdlIGlzOgoKICAg
IGRybS9hbWRrZmQ6IFN0b3AgdXNpbmcgR0ZQX05PSU8gZXhwbGljaXRseQoKICAgIFRoaXMgaXMg
bm8gbG9uZ2VyIG5lZWRlZCB3aXRoIHRoZSBtZW1hbGxvY19ub2ZzX3NhdmUvcmVzdG9yZSBpbgog
ICAgZHFtX2xvY2svdW5sb2NrCgpDaGFuZ2UtSWQ6IEk0MjQ1MGIyYzE0OWQyYjE4NDJiZTk5YThm
MzU1YzgyOWEwMDc5ZTdjClNpZ25lZC1vZmYtYnk6IFlvbmcgWmhhbyA8WW9uZy5aaGFvQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5j
IHwgMiArLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMg
IHwgMiArLQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2Vy
X3YxMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5j
CmluZGV4IDQ2ZGRiMzNiNjI0YS4uNTc5YzVmZmNmYTc5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEwLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jCkBAIC0zOTMsNyArMzkzLDcgQEAg
c3RydWN0IG1xZF9tYW5hZ2VyICptcWRfbWFuYWdlcl9pbml0X3YxMChlbnVtIEtGRF9NUURfVFlQ
RSB0eXBlLAogCWlmIChXQVJOX09OKHR5cGUgPj0gS0ZEX01RRF9UWVBFX01BWCkpCiAJCXJldHVy
biBOVUxMOwogCi0JbXFkID0ga3phbGxvYyhzaXplb2YoKm1xZCksIEdGUF9OT0lPKTsKKwltcWQg
PSBremFsbG9jKHNpemVvZigqbXFkKSwgR0ZQX0tFUk5FTCk7CiAJaWYgKCFtcWQpCiAJCXJldHVy
biBOVUxMOwogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFk
X21hbmFnZXJfdjkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdl
cl92OS5jCmluZGV4IGJlMjdmZjAxY2RiOC4uMjJhODE5Yzg4OGQ4IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYwpAQCAtOTIsNyArOTIsNyBA
QCBzdGF0aWMgc3RydWN0IGtmZF9tZW1fb2JqICphbGxvY2F0ZV9tcWQoc3RydWN0IGtmZF9kZXYg
KmtmZCwKIAkgKiBpbnN0ZWFkIG9mIHN1Yi1hbGxvY2F0aW9uIGZ1bmN0aW9uLgogCSAqLwogCWlm
IChrZmQtPmN3c3JfZW5hYmxlZCAmJiAocS0+dHlwZSA9PSBLRkRfUVVFVUVfVFlQRV9DT01QVVRF
KSkgewotCQltcWRfbWVtX29iaiA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBrZmRfbWVtX29iaiks
IEdGUF9OT0lPKTsKKwkJbXFkX21lbV9vYmogPSBremFsbG9jKHNpemVvZihzdHJ1Y3Qga2ZkX21l
bV9vYmopLCBHRlBfS0VSTkVMKTsKIAkJaWYgKCFtcWRfbWVtX29iaikKIAkJCXJldHVybiBOVUxM
OwogCQlyZXR2YWwgPSBhbWRncHVfYW1ka2ZkX2FsbG9jX2d0dF9tZW0oa2ZkLT5rZ2QsCi0tIAoy
LjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
