Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D4FC433FE
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5648922AAD
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5648922AAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D046E864;
	Sat, 12 Dec 2020 15:46:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719DB6E864
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNK5Q/oErsuAb0uePD2oah7S1NPixyREU5wv5uko/L4gsguMzDTiy2VwP9eXoN73eW0HJmfrliyjiVWCTtr7/E7TO7GhjPe9y8xQLhZvE4I3AWtoc/I/7u1WVGUbkG2FJjdNTfjsdARQyflh9O3Soi4MMBmlgnmxRMk20EIBrmsC+w7Uh+gncEAMoCRut1ok6Nk9ArJKimHAKJBiThQi/ZCdhAWz/KFrEbT73NaQnD9XRjJMILetaHLdXoxBM7cW2ibQxVLRGTMf5+QaMGUX88gp2uR9Cv7L+eAKN8WLHPYGxbgTYjVA4f47P0rvolqYiI7YIeUfhD9e9u2tgTP7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97udAIxs5RY5YrOcMinZVB0KJfCJvHCqznYU21xUF5w=;
 b=Mjcd0sSvwzxbqd7Bcekwy3N4EDBFxlUVOgjPf4qjUL5difandKH/S4ikhhzEw7yggK2ZfcTr9+kV4k4zRrzW/Ft9k6XAC/xCCaxXx++iZoqMMZp982zQr5Ivf75YhTWk7vXgoIVuIBW9G8PvYpSam2LuiuY9QTszSByKmWBMTVk9L85p1myidOskISvhpvd+wIYedu3SyfArO9Ai4fldWgC5CDuXT7BFJFq8/t2wlvcGeSXb0M6emcvaDG8O96ZzNAJBiP7g64OApakcnFc+mF5PbnZ/nnBLXJS9GUqmQrRNCDb0kYmWWG5edwn9yrnHTEvKDZKMxX/t7AkKignKNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97udAIxs5RY5YrOcMinZVB0KJfCJvHCqznYU21xUF5w=;
 b=J7dcGVraUYM9cK2+TPxh/Qv2jLAnl2XbEc7a+viLEfSqTArCAmW3jQ3RsgWC6nkkNUsFd1V09S7ewa3CjTNcHWlxpcbuba6rOX9klnP+n++zE/g7uaytSEivncSrUYkslZyoDze3GvLjpPeyWYtTxh3XFHN9CAg9+grL5RmSLCY=
Received: from BN6PR2001CA0015.namprd20.prod.outlook.com
 (2603:10b6:404:b4::25) by CH2PR12MB3718.namprd12.prod.outlook.com
 (2603:10b6:610:2e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Sat, 12 Dec
 2020 15:46:23 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::3c) by BN6PR2001CA0015.outlook.office365.com
 (2603:10b6:404:b4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:46:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:22 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:22 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:46:20 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 05/27] drm/amdgpu: switch to ih_init_register_offset for vega10
Date: Sat, 12 Dec 2020 23:45:38 +0800
Message-ID: <20201212154600.21618-5-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7204b425-7d58-4212-242e-08d89eb513bc
X-MS-TrafficTypeDiagnostic: CH2PR12MB3718:
X-Microsoft-Antispam-PRVS: <CH2PR12MB371843B943A35B9A9A9C54E8FCC90@CH2PR12MB3718.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/pTkp2MipUIoitPQDGBjx/ESC52ls1xUKr+eyCMPAtIEqJniXW/UqkpNXZlCpP8wfcpEzU3dmPNGdfUcgn/js443Rb3UG9KelLYS44z6aFHfg0SDTkz1hcs9oVZorql7p5LyKQ6zSXo3STQ8aDFNn166e6p9AlRPAfG3hWrbOityJ70UYhUYsBFcocn3jxk7/eeArQsZGpQB1T1a5uiR91doVNE73E12IVyLL7AIuxVzc8BVw/AUtrQ4gOXyVvpoSdtly5iq9yjnKOkFfLz1FhM6ELkXfUV8v7/Rce9hcjrzs0uqgHqs2Uk6+99TOfvesVEond0x8inONNoW5RxN06nHqWE7+8qitHJqqeqd4mOgtmP82ralyxYWC8FgkPujPYMANLGda903Hla4upsKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(46966005)(6666004)(82310400003)(2616005)(7696005)(426003)(110136005)(4326008)(26005)(70206006)(36756003)(70586007)(1076003)(186003)(2906002)(81166007)(47076004)(336012)(356005)(8676002)(508600001)(86362001)(5660300002)(4744005)(6636002)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:46:22.9841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7204b425-7d58-4212-242e-08d89eb513bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3718
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

SW5pdGlhbGl6ZSBpaCBjb250cm9sIHJlZ2lzdGVycyBvZmZzZXQgdGhyb3VnaCBoZWxwZXIKZnVu
Y3Rpb24gdmVnYTEwX2loX2luaXRfcmVnaXN0ZXJfb2Zmc2V0LgoKU2lnbmVkLW9mZi1ieTogSGF3
a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpBY2tlZC1ieTogRmVsaXggS3VlaGxp
bmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBEZW5uaXMgTGkgPERlbm5p
cy5MaUBhbWQuY29tPgpSZXZpZXdlZC1ieTogRmVpZmVpIFh1IDxGZWlmZWkuWHVAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMTBfaWguYyB8IDMgKysrCiAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmVnYTEwX2loLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdh
MTBfaWguYwppbmRleCBmYTRjNDkwMjI5YTQuLmUyNGVlYzkyMTdkNiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmVnYTEwX2loLmMKQEAgLTc1OCw2ICs3NTgsOSBAQCBzdGF0aWMgaW50IHZl
Z2ExMF9paF9zd19pbml0KHZvaWQgKmhhbmRsZSkKIAlhZGV2LT5pcnEuaWgyLnVzZV9kb29yYmVs
bCA9IHRydWU7CiAJYWRldi0+aXJxLmloMi5kb29yYmVsbF9pbmRleCA9IChhZGV2LT5kb29yYmVs
bF9pbmRleC5paCArIDIpIDw8IDE7CiAKKwkvKiBpbml0aWFsaXplIGloIGNvbnRyb2wgcmVnaXN0
ZXJzIG9mZnNldCAqLworCXZlZ2ExMF9paF9pbml0X3JlZ2lzdGVyX29mZnNldChhZGV2KTsKKwog
CXIgPSBhbWRncHVfaWhfcmluZ19pbml0KGFkZXYsICZhZGV2LT5pcnEuaWhfc29mdCwgUEFHRV9T
SVpFLCB0cnVlKTsKIAlpZiAocikKIAkJcmV0dXJuIHI7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
