Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EB0C07E9B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 04:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9155460FDA
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 04:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9155460FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F4A16E8A5;
	Wed, 21 Jul 2021 04:48:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 382846E8A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 04:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWM4dlKWpdXIvioaZYHt18r+Qvjr1MI3q3yn7gE00DXNdx8LTmXbVsJusoLLfwf5qnuFX7nNGMQFBjwuaNBDckifiJGPpWFHZNjcxrTiZ+YReZ83Xo0A3CgS6NljYRWsXx0LwCG9Ili7bYEwepsjVkJAJKVOGALNFCgfiOnYNPVNh8Jbk1oLt8mhUjLqTErqsfkpkXNeQOWor5NdVqPhmQdZZnWt3s9OvBXEcZZRpTwnA0JLfMk3xXp4i6589397le7gtK/GHJiGjT5eo8poDQ6YqGEGASs460TaIbvvvNM6T4LDgOjkpIAeFxV5fR4Z8dHaXQv4RC/LXdzZRdDubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbtVLY3/SNAzZ/q6dAPqNpQpqBEP3+dwnKNyCcuyZ6c=;
 b=dF66Zldw/0UGRzvpwLxj8ZgQrcKCeW7k9JDbCUBCrrHc+D3xxZS5civhWCtQpFobHE4O1eIrjYyF7GDrkh4fpNQI0igOJm8+mORJiAK3f1+LGAP3Fu72SJvm+ynTqpMqnhYRUE7fsqLPJBb3lZTKWchhJNoFThJAWDyB+bfu3XooOZtBVyUxQld16AwC13FZh9D4s8vGRaJuE//qXvbaf4cux9XPOPeXTACU+q/JHuWSaEoezGk6BTbhFRnovySt1A4MZRyu//FflRLr59cykB8di9D1jl4F/+M2D/bfPpYWPWJMF2APCVFFv6QkOCpAu1O0f03DLPdGIbBohw/Law==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ellerman.id.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbtVLY3/SNAzZ/q6dAPqNpQpqBEP3+dwnKNyCcuyZ6c=;
 b=ObFvdECS9OMpqW5K5Xb4DvYlDQMH4RPMw8Kt46sg1Aa2Db+NB0EaTbQBmvIeRs/DpiwCAJGbahMxRcEyQF9lQ/bZuPSBlICPi8z60cFkIxhZgweXprNpgsY5fNIbUzF9q7WwMQgU+UdWXCQ3PRUSbYFIrmFyHlCsFoaz2NGKxKI=
Received: from DS7PR03CA0180.namprd03.prod.outlook.com (2603:10b6:5:3b2::35)
 by CH2PR12MB3686.namprd12.prod.outlook.com (2603:10b6:610:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Wed, 21 Jul
 2021 04:48:19 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::2a) by DS7PR03CA0180.outlook.office365.com
 (2603:10b6:5:3b2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Wed, 21 Jul 2021 04:48:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; ellerman.id.au; dkim=none (message not signed)
 header.d=none;ellerman.id.au; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 04:48:18 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 23:48:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 21:48:17 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 20 Jul 2021 23:48:11 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <mpe@ellerman.id.au>, <benh@kernel.crashing.org>, <paulus@samba.org>,
 <christophe.leroy@csgroup.eu>, <linuxppc-dev@lists.ozlabs.org>,
 <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v2 2/2] drm/amd/display: Use PPC FPU functions
Date: Wed, 21 Jul 2021 00:48:01 -0400
Message-ID: <20210721044801.840501-3-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721044801.840501-1-Anson.Jacob@amd.com>
References: <20210721044801.840501-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 181b8a50-9300-43ed-bcd1-08d94c02c28c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3686:
X-Microsoft-Antispam-PRVS: <CH2PR12MB36866E871A6F91C818349AF2EBE39@CH2PR12MB3686.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDa9zuJFMNsVB3Qh7VO9H0mmFAhb2OEVY6uC44qZh8hc+MZtp8YgBMKqol6jE04Aj9vqAGQXKO3I6K3xt0YlDb5Mshk5MPD5voqtzfKsA1YUI+ATddwizA9nF6IsVfvZ31OIT0OfKPwGfAGNN6pucx7kh10Xu9C5ecP4BWf/bTjextL21J8HL37roKjzI/xUNXzLmMFP+4S2ZsJdZi6VOZMINZRGuuKn+2PQqC1aVQLL91Cr3frD/YbFv3unJ9fmGYVmqIBcABgbDprjzgVQ1wVSoGVPutAvskWWbdqJUH0W6E3txKHJwK5/qcYb/b6Tj3GMyrxgqwmLWYCXjee+ImpLLIZAnxmEXJSwLEN0Gd/ulPDyR8B0y1Fr4fz8XgvNl+Om1+9vBFeCmgJ0TcRrKT8zOWx4s6GHu0BfLNOScJh09Xtu2NgFfpvICCEdTzWZ3wFULhEETd+tNQZ/MuhcHoPLcE8ZPi42iqEPsqTJAJlnodDRR+IuWenpMVjsqFnBQlZNZkvSvAfRuiU6T7ExyEvRKjhL9xxXg0I1KWPmIMk6edwsCo+NnZSFuVaZxZxb3UBQMhzsBdLDZNpiXtZB/VliCzzFxlSdCjgOWfOdT0sSYibyGsZzPINC+CdvsV5xCBx1YNr/xc1KnpiDPDzf10hZau/JqltwZdbjRFfsYhFg9jdX8JNPTjH92yeH/oB8oR9ugPS/FSpe7ZYlHy7POQQXf0zWjyp28Rd1crjIU9o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8676002)(356005)(81166007)(6666004)(1076003)(82310400003)(2616005)(8936002)(336012)(36860700001)(316002)(70586007)(5660300002)(4326008)(70206006)(110136005)(83380400001)(426003)(508600001)(26005)(36756003)(186003)(54906003)(47076005)(7696005)(86362001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 04:48:18.6315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 181b8a50-9300-43ed-bcd1-08d94c02c28c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3686
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
Cc: Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Christoph Hellwig <hch@infradead.org>, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VXNlIGtlcm5lbF9mcHVfYmVnaW4gJiBrZXJuZWxfZnB1X2VuZCBmb3IgUFBDCgpEZXBlbmRzIG9u
ICJwcGMvZnB1OiBBZGQgZ2VuZXJpYyBGUFUgYXBpIHNpbWlsYXIgdG8geDg2IgoKdjI6Ci0gR290
IHJpZCBvZiBtYWNybyBzd2l0Y2ggZm9yIFBQQyBhcyBoZWFkZXIgZmlsZSB3aXRoIHNhbWUKICBu
YW1lIGFzIHg4NiBpcyBhZGRlZCBieSBwcmV2aW91cyBwYXRjaCBpbiB0aGUgc2VyaWVzCgpTaWdu
ZWQtb2ZmLWJ5OiBBbnNvbiBKYWNvYiA8QW5zb24uSmFjb2JAYW1kLmNvbT4KQ0M6IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4KQ0M6IFJvZHJpZ28gU2lxdWVpcmEgPFJvZHJp
Z28uU2lxdWVpcmFAYW1kLmNvbT4KQ0M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBh
bWQuY29tPgpDQzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9vc190eXBlcy5oIHwgMjkgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyOSBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvb3NfdHlwZXMuaCBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9vc190eXBlcy5oCmluZGV4IDEyNmMyZjNhNGRkMy4u
NDdlZjQzNGY5M2Q4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
b3NfdHlwZXMuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvb3NfdHlwZXMu
aApAQCAtNTEsMzggKzUxLDkgQEAKICNkZWZpbmUgZG1fZXJyb3IoZm10LCAuLi4pIERSTV9FUlJP
UihmbXQsICMjX19WQV9BUkdTX18pCiAKICNpZiBkZWZpbmVkKENPTkZJR19EUk1fQU1EX0RDX0RD
TikKLSNpZiBkZWZpbmVkKENPTkZJR19YODYpCiAjaW5jbHVkZSA8YXNtL2ZwdS9hcGkuaD4KICNk
ZWZpbmUgRENfRlBfU1RBUlQoKSBrZXJuZWxfZnB1X2JlZ2luKCkKICNkZWZpbmUgRENfRlBfRU5E
KCkga2VybmVsX2ZwdV9lbmQoKQotI2VsaWYgZGVmaW5lZChDT05GSUdfUFBDNjQpCi0jaW5jbHVk
ZSA8YXNtL3N3aXRjaF90by5oPgotI2luY2x1ZGUgPGFzbS9jcHV0YWJsZS5oPgotI2RlZmluZSBE
Q19GUF9TVEFSVCgpIHsgXAotCWlmIChjcHVfaGFzX2ZlYXR1cmUoQ1BVX0ZUUl9WU1hfQ09NUCkp
IHsgXAotCQlwcmVlbXB0X2Rpc2FibGUoKTsgXAotCQllbmFibGVfa2VybmVsX3ZzeCgpOyBcCi0J
fSBlbHNlIGlmIChjcHVfaGFzX2ZlYXR1cmUoQ1BVX0ZUUl9BTFRJVkVDX0NPTVApKSB7IFwKLQkJ
cHJlZW1wdF9kaXNhYmxlKCk7IFwKLQkJZW5hYmxlX2tlcm5lbF9hbHRpdmVjKCk7IFwKLQl9IGVs
c2UgaWYgKCFjcHVfaGFzX2ZlYXR1cmUoQ1BVX0ZUUl9GUFVfVU5BVkFJTEFCTEUpKSB7IFwKLQkJ
cHJlZW1wdF9kaXNhYmxlKCk7IFwKLQkJZW5hYmxlX2tlcm5lbF9mcCgpOyBcCi0JfSBcCi19Ci0j
ZGVmaW5lIERDX0ZQX0VORCgpIHsgXAotCWlmIChjcHVfaGFzX2ZlYXR1cmUoQ1BVX0ZUUl9WU1hf
Q09NUCkpIHsgXAotCQlkaXNhYmxlX2tlcm5lbF92c3goKTsgXAotCQlwcmVlbXB0X2VuYWJsZSgp
OyBcCi0JfSBlbHNlIGlmIChjcHVfaGFzX2ZlYXR1cmUoQ1BVX0ZUUl9BTFRJVkVDX0NPTVApKSB7
IFwKLQkJZGlzYWJsZV9rZXJuZWxfYWx0aXZlYygpOyBcCi0JCXByZWVtcHRfZW5hYmxlKCk7IFwK
LQl9IGVsc2UgaWYgKCFjcHVfaGFzX2ZlYXR1cmUoQ1BVX0ZUUl9GUFVfVU5BVkFJTEFCTEUpKSB7
IFwKLQkJZGlzYWJsZV9rZXJuZWxfZnAoKTsgXAotCQlwcmVlbXB0X2VuYWJsZSgpOyBcCi0JfSBc
Ci19Ci0jZW5kaWYKICNlbmRpZgogCiAvKgotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
