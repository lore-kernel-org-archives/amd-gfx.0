Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5726CC433FE
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1244722AED
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1244722AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD54F6E88F;
	Sat, 12 Dec 2020 15:47:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5AD6ECDE
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCPanZ2awTYnpQMWhJAGEEIcczYv7DSV2TaAh716pEDezSz09DEqAb0W34yKuxW8aXy5da50iEBPvxUtL/euxVEYT19f/WhEkqfjsmCOmR/wU8H33yBdfL0+dM5b+rdNNqqYwELKBiwM4Z4sodo5IY6ILnboFCd1N9OIsBmK0/7SG6rX6zdvKpvmmq55bL/zAWxNaAv6DVnOrtck/FoE5gnWJoHso+TXCRBayhDO2GoArsQsoliT7nz2AJLkhx0ZaGUdJcMj5UPR2JoSNOX5mPYZgfWkegDgpEmbHzVtFwAutLNyLLLWJ9RW0TCOCnvxKZrBrwYEDbKT551VgMNO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2azW/hT2zEmGcfS8QVRh9caXxlBCRi5YQgekyXnOhM=;
 b=HJPDNfjCrL0YL5OqKEgNdXJf04yy9Nt+Y1VmsFeaKXjAWO+Zojcgrn1onh9lZsF54QYMlD/cx4BleIORS5/eN08WbN53AnDGj9IaIapnyN6DPO8OnVgrXN6RSHfGDQChrLb2qulVIGqxAysOmE0hLSs60tUw0X5XFxe7zcy9QussKz0ZbGW4L0gtnDLxh7jXNww6v17QDTlkJCfgk1ha44H12/2/gz9qvyFk80nwUPPKzewixZLedcDNTklLHAYnJfmyWfXCVd5BkwYUng0QUWjLL9e0RnMfVdPqy8cd+1KDqzSsRKDHPdFfTks9dUAYFv7vR1NPH2H2c+czy3XGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2azW/hT2zEmGcfS8QVRh9caXxlBCRi5YQgekyXnOhM=;
 b=bPk7p9NvUK+z9Hhd+zlsyzJBhFMrV6RK3Zhe8XTfu8NZFNWu/etUiVdUMo02+bXLdDHi/09ZimtlJC14lQD3JUSq/xKITFde5LvTYBd7F9iOmjCtVr/0+euXQnEg0rss8HpJvYn+1bGuS5AuMdgH23oNKwIEvM3ymFT2gSJy4m8=
Received: from MW4PR04CA0244.namprd04.prod.outlook.com (2603:10b6:303:88::9)
 by BN8PR12MB3635.namprd12.prod.outlook.com (2603:10b6:408:46::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Sat, 12 Dec
 2020 15:47:39 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::37) by MW4PR04CA0244.outlook.office365.com
 (2603:10b6:303:88::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:47:38 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:47:37 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:47:35 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 25/27] drm/amdgpu: drop arcturus IH_CHICKEN programming from
 vega10 ih block
Date: Sat, 12 Dec 2020 23:45:58 +0800
Message-ID: <20201212154600.21618-25-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fa03c92-786b-433b-ebd2-08d89eb54106
X-MS-TrafficTypeDiagnostic: BN8PR12MB3635:
X-Microsoft-Antispam-PRVS: <BN8PR12MB363585B477483DF955243066FCC90@BN8PR12MB3635.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLiKEKM8XmjwLqnDDicYe4ra7QRYV+NxaUjqI8sic2EsEbzWL6kfaQN0RmyFu2PG/8BGFQ8/t7BiobLpQOFgXXfAvDpmIj5/RPXoPWMtHzLG4QI3Rs9fggUxTPpVu1CS8ox7b1uZjBS079tocUItc4kOhtdDFG6/K3k6BUE9e3aKKvXv+xx26G+nBcy9g/bqEN8TEVDeDK1OcJyRodA1V4qZI45hswLP1PosukNKgoQkBEQfVC8E9tp5sHCbcAxsaIFJqjas9JXZ/9FcTcQqZz99pMShMMXp+VtL3Vxh/ZX85UUNkqASnXyxgnbwhEidvsNi/b5wLzYLXy9EG+woQlRRsuq5z0zlxjj3BoLY6G+j5h0GTVfrGQaV2/v4UTNBU2ED0i8su3enYbYNJCuffg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(46966005)(70206006)(336012)(110136005)(26005)(81166007)(4326008)(83380400001)(8936002)(2616005)(36756003)(5660300002)(6636002)(356005)(70586007)(2906002)(186003)(508600001)(8676002)(7696005)(47076004)(82310400003)(6666004)(86362001)(426003)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:47:38.8497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa03c92-786b-433b-ebd2-08d89eb54106
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3635
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

YXJjdHVydXMgaWggc3VwcG9ydCBhbHJlYWR5IHN3aXRjaGVkIHRvIHZlZ2EyMCBpaApibG9jay4g
ZHJvcCBhcmN0dXJ1cyBpaF9jaGlja2VuIHByb2dyYW1taW5nIGZyb20KdmVnYTEwIGloIGJsb2Nr
LgoKQ2hhbmdlLUlkOiBJYzEzZjA1YTQxODZmMDVkMDAzYmY2YWUwYTJiNTQ1M2ExZTk2NGRiYgpT
aWduZWQtb2ZmLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+CkFja2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkFja2VkLWJ5
OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IERl
bm5pcyBMaSA8RGVubmlzLkxpQGFtZC5jb20+ClJldmlld2VkLWJ5OiBGZWlmZWkgWHUgPEZlaWZl
aS5YdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5j
IHwgNCArLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYwppbmRleCAxN2MwYTA3Yzg4M2Iu
LjQ0MDIxZWZlODIyMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVn
YTEwX2loLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMKQEAg
LTI3NCw5ICsyNzQsNyBAQCBzdGF0aWMgaW50IHZlZ2ExMF9paF9pcnFfaW5pdChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKIAogCWFkZXYtPm5iaW8uZnVuY3MtPmloX2NvbnRyb2woYWRldik7
CiAKLQlpZiAoKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX0FSQ1RVUlVTICYmCi0JICAgICBhZGV2
LT5maXJtd2FyZS5sb2FkX3R5cGUgPT0gQU1ER1BVX0ZXX0xPQURfRElSRUNUKSB8fAotCSAgICBh
ZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9SRU5PSVIpIHsKKwlpZiAoYWRldi0+YXNpY190eXBlID09
IENISVBfUkVOT0lSKSB7CiAJCWloX2NoaWNrZW4gPSBSUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBt
bUlIX0NISUNLRU4pOwogCQlpZiAoYWRldi0+aXJxLmloLnVzZV9idXNfYWRkcikgewogCQkJaWhf
Y2hpY2tlbiA9IFJFR19TRVRfRklFTEQoaWhfY2hpY2tlbiwgSUhfQ0hJQ0tFTiwKLS0gCjIuMTcu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
