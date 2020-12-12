Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648FEC4361B
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329D922AAD
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329D922AAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4DF96E863;
	Sat, 12 Dec 2020 15:46:50 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690061.outbound.protection.outlook.com [40.107.69.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFDE66E863
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9QDxuaRUPWV9l/qs/WvwUiX0hgEwBc0o2Ubo4kf9UVIzquGBuI/72gxd3p/TfMm7OSwqObZlaYcDOsuxq3jit4NNu++HXv1/4LAw9r4C8taNLnNFikHGFw0UqKq6UvMKAdmFW3DPpuHxj+lGCbEO+JFSZzwK9BTGblmutDJyC2py8YcE0Ou9nRumA1UAZme2Ni/7NE/g7N7vDL+bhAJie9UUTNLSPefkmfAahRG0rZb4pe/W1DVNyK844ZhRCb2eZNtySjz+FLUPMjcpXLRgKgZYYkw4gIOCpg+t2Mrm2bzu/4OSQVGywPnIPehby1MlXoWOZpLTAb+Neg+6UzItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwG4+tXc7GQMgvbocXBNDj9cwQjl7tPYaVMxvIZkea0=;
 b=edD8shPcxo31f0CY4+yQi6Nuz6l/lSdm2M4NHxZnMlJoLTzVmAcLpwOu8v/i/oTUziJkgz8hsel1fnA4k2aguS4YEy1zmhmJRP2NKdPcWEIvmTYA9s0Ptw/+SZrrKUyg0Y8l1p8IeP7WUv77BbOSmuW8+PJtkUPqXoKHDT6EqGnthDXe3nu4GeBL6Fw+IJzfC0N7xmozRoUhEsw4xhjqVnIpkjHc3JMHsStsBumsyhGXLFC/Px3nj4w5L1X69o4YcQ6qh8E9Y0neWFat+1+Kpqu/p5pcyEQuNSQNvlh9+rdK6AR7ipzSKTgGMvFGB8+eF+qWIHeYS5G670ZA1TaFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwG4+tXc7GQMgvbocXBNDj9cwQjl7tPYaVMxvIZkea0=;
 b=j2uUPbpUEcnh0irvCpKPa2P94jMtcua6UCm8Ubr3M8EjP+KFD8ey7jDr1F+6I2wTjSwGJES3Du2BxRo7v/Yl7URpKSybzR2spO9xR7NlCyV5Cc+KPDllapg7LRZLSahHq3wxTwfTWCWt9lyS9ksRNaEJOZsTGcmS9c9zg9gieGI=
Received: from BN3PR03CA0057.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::17) by DM6PR12MB3692.namprd12.prod.outlook.com
 (2603:10b6:5:14a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Sat, 12 Dec
 2020 15:46:48 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:7a4d::4) by BN3PR03CA0057.outlook.office365.com
 (2a01:111:e400:7a4d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:46:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:47 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:46 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:46:44 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 13/27] drm/amdgpu: switch to ih_init_register_offset for navi10
Date: Sat, 12 Dec 2020 23:45:46 +0800
Message-ID: <20201212154600.21618-13-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a31a11b-3c25-44d0-5ff7-08d89eb5225c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3692:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3692A29179606D71E968B995FCC90@DM6PR12MB3692.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TKyiyqeYpB+7DLE3odaaq/5F7nrlNgumfGErQ6aWNN66k+NCk36/txTOryr7JgwwhdlFM/v1NpvVysH1Wi3BWdz21q3muGj4ZMznwgCYbpVWJY+cuYaKuMHbJpDQrzQLzlQekoFzs3dQWoMW/qmMQ9pcdTMNCEGzUsXYXMlQLWZgvIwik/E9wiGwoJGdlKAfMvdPzaGOwTB8vOt7ATu/hdkMgE7NGuqlfQ+65OyPM2/+waxruKOe71rVmBdsnWnxuXqquF/hablYhXURrYxdHnBYGkxAzvAiI4uBHTBf5fjoPBvSVqxELEY9q+HSj8K1vLd//CK/5OhQ3NqHgjos9xTulLqmobWXdfU63Pvox5xGJN8mnC2+6Szc22AVs+Dm/B23mOIu2g9fdodDvjdx6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(46966005)(2906002)(336012)(26005)(6636002)(4326008)(82310400003)(81166007)(8676002)(70206006)(8936002)(70586007)(86362001)(2616005)(110136005)(426003)(4744005)(47076004)(1076003)(5660300002)(508600001)(356005)(186003)(7696005)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:46:47.5223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a31a11b-3c25-44d0-5ff7-08d89eb5225c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3692
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
Y3Rpb24gbmF2aTEwX2loX2luaXRfcmVnaXN0ZXJfb2Zmc2V0LgoKU2lnbmVkLW9mZi1ieTogSGF3
a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgpBY2tlZC1ieTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpBY2tlZC1ieTogRmVsaXggS3VlaGxpbmcg
PEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBEZW5uaXMgTGkgPERlbm5pcy5M
aUBhbWQuY29tPgpSZXZpZXdlZC1ieTogRmVpZmVpIFh1IDxGZWlmZWkuWHVAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYyB8IDMgKysrCiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvbmF2aTEwX2loLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBf
aWguYwppbmRleCA3ODZmMTVmODI5ZTkuLjM1YmQ2ZDIxMDEzNSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvbmF2aTEwX2loLmMKQEAgLTg0Nyw2ICs4NDcsOSBAQCBzdGF0aWMgaW50IG5hdmkx
MF9paF9zd19pbml0KHZvaWQgKmhhbmRsZSkKIAkJCQkJKGFkZXYtPmRvb3JiZWxsX2luZGV4Lmlo
ICsgMikgPDwgMTsKIAl9CiAKKwkvKiBpbml0aWFsaXplIGloIGNvbnRyb2wgcmVnaXN0ZXJzIG9m
ZnNldCAqLworCW5hdmkxMF9paF9pbml0X3JlZ2lzdGVyX29mZnNldChhZGV2KTsKKwogCXIgPSBh
bWRncHVfaWhfcmluZ19pbml0KGFkZXYsICZhZGV2LT5pcnEuaWhfc29mdCwgUEFHRV9TSVpFLCB0
cnVlKTsKIAlpZiAocikKIAkJcmV0dXJuIHI7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
