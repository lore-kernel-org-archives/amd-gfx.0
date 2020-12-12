Return-Path: <SRS0=w48p=FQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E88FC4361B
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC3F22AAD
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Dec 2020 15:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC3F22AAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD6896E86E;
	Sat, 12 Dec 2020 15:47:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF8926E87A
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Dec 2020 15:46:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHqwhZFZdw9r1x9rH11tSUHeFN40Zhe7pFv40UgkLhfHmDFyf54Xh1ZCFOChWAeTslrpKbaFzWbF/qIhLdTlXn4DxS8DdwL1veyeaieIuwue0CB7lKgapyo2F67xQbD8rBhsfzjYfQSpP8RVP4ah2eJRZOw5hRlTmF9hs7YZbixkTNOtlfxJaJA8aVvBkzYEYKPl/Lb9bpU4JGFBJJvH2QRZsxJTlrfebGAywrilSZ6dmf7A8og5riGCR3pV6u8W0aVWHzkFhCA62uMdEplti3z132I6fkWavPRCpJPQiSTcavd3pmfGn/I9PsXU4lUTWqCevth5kyOH4O9kPk6E8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWNCTBO+LuRSOQgsAohYU8Auroq6rjTlw5WXOJ2vUyk=;
 b=lcpzB1APAHBrVib28OmKM4yFIa1shbGM7mAEj02vKu2yfLs7jeg4IVePGV69sW++E7vOwiSpfabV0tVtnm2e+3B2MjVNI4W7A0Ix8CMI+M42xNQK8jLl8TMAnligCOFoduNwn5l61dKKvWZp75RzOltWbRHixDVEYrgR/An9MSEp+MZijQIz1Qv008c/+r+lVV0yhbVDQAeU7m/C9m2zZvaIRnIqKE0/ZVI85HHVi2x9TqZcVodeNHqL3LO+bPq4th8Xi/m3j9HN/hyZ/+9kzckT+Em07jfDBGYsDE7gHjdC1Qu1msrND+mT38dqT3ZBXXiWXEK+kq5ZsWTWm1vsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWNCTBO+LuRSOQgsAohYU8Auroq6rjTlw5WXOJ2vUyk=;
 b=ogRtQ6HOGo6lKLy8Z4aCP1/cOQu8GjOKz2AuRj01BzvbW/WE7uvgmbwAD6pKdxW/n0beR1UPEmm7yM+S1TLN3JtDqUJgN73cQZ2Ax/2dfNzHURcCD0GvnDWuJSOUbAaAw+C6t4BiDARq59E3MVdeWfyTgQ5ODVLPZc4cJOYxR+o=
Received: from BN6PR08CA0087.namprd08.prod.outlook.com (2603:10b6:404:b6::25)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Sat, 12 Dec
 2020 15:46:57 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:b6:cafe::99) by BN6PR08CA0087.outlook.office365.com
 (2603:10b6:404:b6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Sat, 12 Dec 2020 15:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Sat, 12 Dec 2020 15:46:56 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 12 Dec
 2020 09:46:55 -0600
Received: from hawzhang-System-Product-Dev.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Sat, 12 Dec 2020 09:46:53 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Dennis Li <Dennis.Li@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 16/27] drm/amdgpu: use cached ih rb control reg offsets for
 navi10
Date: Sat, 12 Dec 2020 23:45:49 +0800
Message-ID: <20201212154600.21618-16-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201212154600.21618-1-Hawking.Zhang@amd.com>
References: <20201212154600.21618-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 223446f1-8129-4dd2-e8ae-08d89eb52776
X-MS-TrafficTypeDiagnostic: CH2PR12MB4151:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41512980C4518FDFF38602A2FCC90@CH2PR12MB4151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpq6sdp0wbZ/NVDMzYHkfTBuJkStU9xFaxePmr+unmAATUxQ3UitJ4cTH5RMrRYb3v1K7UPCbJC88/H2XNUGjHO1AtUJ3fAiQ7vFtlmqOEBwYij8+21n8IOrzTU3T/UdC2UWt6bbGYrGFSy9SKkQo3LympPU9ZdBGSvUq4nF/S+LdgVMyt6qv3B7co9FAOkwPfgmnZpPu4ppk2k0QPQuUlP02+sdID/oMhnMRJJhcplclBQuxKEHvQNX71vmhxLzm1fjqF1UfOCmwJY4hqX9nB39I5jhubzuw9O99gDrMsyVCAalTYyqpuRuFA8jm476RQdvQlwG2e6B7Lj5CcP4nw+9k1zC5DJkfHdrVOQ9hUYG0TUtMgZOBRJqugX8jPqURCy8p+VHFLC1mjc1xX04fadqokiR5JFXWpxVtfZTng0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(46966005)(26005)(1076003)(83380400001)(81166007)(7696005)(47076004)(2906002)(508600001)(70206006)(70586007)(8936002)(86362001)(8676002)(186003)(426003)(6666004)(82310400003)(110136005)(356005)(36756003)(6636002)(336012)(5660300002)(4326008)(2616005)(21314003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2020 15:46:56.0858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 223446f1-8129-4dd2-e8ae-08d89eb52776
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
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

YWxsIHRoZSBpaCByYiBjb250cm9sIHJlZ2lzdGVyIG9mZnNldHMgYXJlIGNhY2hlZAphdCB0aGUg
YmVnaW5uaW5nIG9mIG5hdmkxMCBpaF9zd19pbml0LgoKU2lnbmVkLW9mZi1ieTogSGF3a2luZyBa
aGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpBY2tlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4
Lkt1ZWhsaW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBEZW5uaXMgTGkgPERlbm5pcy5MaUBhbWQu
Y29tPgpSZXZpZXdlZC1ieTogRmVpZmVpIFh1IDxGZWlmZWkuWHVAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYyB8IDUyICsrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMzggZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYXZpMTBfaWguYwppbmRleCA3ZTQwMTcwYjM3
OTkuLjg2MDcyYWJjZDYwNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bmF2aTEwX2loLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmF2aTEwX2loLmMK
QEAgLTQyMSwyMyArNDIxLDE2IEBAIHN0YXRpYyB2b2lkIG5hdmkxMF9paF9pcnFfZGlzYWJsZShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHN0YXRpYyB1MzIgbmF2aTEwX2loX2dldF93cHRy
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJICAgICAgc3RydWN0IGFtZGdwdV9paF9y
aW5nICppaCkKIHsKLQl1MzIgd3B0ciwgcmVnLCB0bXA7CisJdTMyIHdwdHIsIHRtcDsKKwlzdHJ1
Y3QgYW1kZ3B1X2loX3JlZ3MgKmloX3JlZ3M7CiAKIAl3cHRyID0gbGUzMl90b19jcHUoKmloLT53
cHRyX2NwdSk7CisJaWhfcmVncyA9ICZpaC0+aWhfcmVnczsKIAogCWlmICghUkVHX0dFVF9GSUVM
RCh3cHRyLCBJSF9SQl9XUFRSLCBSQl9PVkVSRkxPVykpCiAJCWdvdG8gb3V0OwogCi0JaWYgKGlo
ID09ICZhZGV2LT5pcnEuaWgpCi0JCXJlZyA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBt
bUlIX1JCX1dQVFIpOwotCWVsc2UgaWYgKGloID09ICZhZGV2LT5pcnEuaWgxKQotCQlyZWcgPSBT
T0MxNV9SRUdfT0ZGU0VUKE9TU1NZUywgMCwgbW1JSF9SQl9XUFRSX1JJTkcxKTsKLQllbHNlIGlm
IChpaCA9PSAmYWRldi0+aXJxLmloMikKLQkJcmVnID0gU09DMTVfUkVHX09GRlNFVChPU1NTWVMs
IDAsIG1tSUhfUkJfV1BUUl9SSU5HMik7Ci0JZWxzZQotCQlCVUcoKTsKLQotCXdwdHIgPSBSUkVH
MzJfTk9fS0lRKHJlZyk7CisJd3B0ciA9IFJSRUczMl9OT19LSVEoaWhfcmVncy0+aWhfcmJfd3B0
cik7CiAJaWYgKCFSRUdfR0VUX0ZJRUxEKHdwdHIsIElIX1JCX1dQVFIsIFJCX09WRVJGTE9XKSkK
IAkJZ290byBvdXQ7CiAJd3B0ciA9IFJFR19TRVRfRklFTEQod3B0ciwgSUhfUkJfV1BUUiwgUkJf
T1ZFUkZMT1csIDApOwpAQCAtNDUyLDE4ICs0NDUsOSBAQCBzdGF0aWMgdTMyIG5hdmkxMF9paF9n
ZXRfd3B0cihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJIHdwdHIsIGloLT5ycHRyLCB0
bXApOwogCWloLT5ycHRyID0gdG1wOwogCi0JaWYgKGloID09ICZhZGV2LT5pcnEuaWgpCi0JCXJl
ZyA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBtbUlIX1JCX0NOVEwpOwotCWVsc2UgaWYg
KGloID09ICZhZGV2LT5pcnEuaWgxKQotCQlyZWcgPSBTT0MxNV9SRUdfT0ZGU0VUKE9TU1NZUywg
MCwgbW1JSF9SQl9DTlRMX1JJTkcxKTsKLQllbHNlIGlmIChpaCA9PSAmYWRldi0+aXJxLmloMikK
LQkJcmVnID0gU09DMTVfUkVHX09GRlNFVChPU1NTWVMsIDAsIG1tSUhfUkJfQ05UTF9SSU5HMik7
Ci0JZWxzZQotCQlCVUcoKTsKLQotCXRtcCA9IFJSRUczMl9OT19LSVEocmVnKTsKKwl0bXAgPSBS
UkVHMzJfTk9fS0lRKGloX3JlZ3MtPmloX3JiX2NudGwpOwogCXRtcCA9IFJFR19TRVRfRklFTEQo
dG1wLCBJSF9SQl9DTlRMLCBXUFRSX09WRVJGTE9XX0NMRUFSLCAxKTsKLQlXUkVHMzJfTk9fS0lR
KHJlZywgdG1wKTsKKwlXUkVHMzJfTk9fS0lRKGloX3JlZ3MtPmloX3JiX2NudGwsIHRtcCk7CiBv
dXQ6CiAJcmV0dXJuICh3cHRyICYgaWgtPnB0cl9tYXNrKTsKIH0KQEAgLTUyMywyMiArNTA3LDE1
IEBAIHN0YXRpYyB2b2lkIG5hdmkxMF9paF9kZWNvZGVfaXYoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsCiBzdGF0aWMgdm9pZCBuYXZpMTBfaWhfaXJxX3JlYXJtKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAogCQkJICAgICAgIHN0cnVjdCBhbWRncHVfaWhfcmluZyAqaWgpCiB7Ci0JdWlu
dDMyX3QgcmVnX3JwdHIgPSAwOwogCXVpbnQzMl90IHYgPSAwOwogCXVpbnQzMl90IGkgPSAwOwor
CXN0cnVjdCBhbWRncHVfaWhfcmVncyAqaWhfcmVnczsKIAotCWlmIChpaCA9PSAmYWRldi0+aXJx
LmloKQotCQlyZWdfcnB0ciA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBtbUlIX1JCX1JQ
VFIpOwotCWVsc2UgaWYgKGloID09ICZhZGV2LT5pcnEuaWgxKQotCQlyZWdfcnB0ciA9IFNPQzE1
X1JFR19PRkZTRVQoT1NTU1lTLCAwLCBtbUlIX1JCX1JQVFJfUklORzEpOwotCWVsc2UgaWYgKGlo
ID09ICZhZGV2LT5pcnEuaWgyKQotCQlyZWdfcnB0ciA9IFNPQzE1X1JFR19PRkZTRVQoT1NTU1lT
LCAwLCBtbUlIX1JCX1JQVFJfUklORzIpOwotCWVsc2UKLQkJcmV0dXJuOworCWloX3JlZ3MgPSAm
aWgtPmloX3JlZ3M7CiAKIAkvKiBSZWFybSBJUlEgLyByZS13cml0ZSBkb29yYmVsbCBpZiBkb29y
YmVsbCB3cml0ZSBpcyBsb3N0ICovCiAJZm9yIChpID0gMDsgaSA8IE1BWF9SRUFSTV9SRVRSWTsg
aSsrKSB7Ci0JCXYgPSBSUkVHMzJfTk9fS0lRKHJlZ19ycHRyKTsKKwkJdiA9IFJSRUczMl9OT19L
SVEoaWhfcmVncy0+aWhfcmJfcnB0cik7CiAJCWlmICgodiA8IGloLT5yaW5nX3NpemUpICYmICh2
ICE9IGloLT5ycHRyKSkKIAkJCVdET09SQkVMTDMyKGloLT5kb29yYmVsbF9pbmRleCwgaWgtPnJw
dHIpOwogCQllbHNlCkBAIC01NTcsNiArNTM0LDggQEAgc3RhdGljIHZvaWQgbmF2aTEwX2loX2ly
cV9yZWFybShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIHN0YXRpYyB2b2lkIG5hdmkxMF9p
aF9zZXRfcnB0cihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCSAgICAgICBzdHJ1Y3Qg
YW1kZ3B1X2loX3JpbmcgKmloKQogeworCXN0cnVjdCBhbWRncHVfaWhfcmVncyAqaWhfcmVnczsK
KwogCWlmIChpaC0+dXNlX2Rvb3JiZWxsKSB7CiAJCS8qIFhYWCBjaGVjayBpZiBzd2FwcGluZyBp
cyBuZWNlc3Nhcnkgb24gQkUgKi8KIAkJKmloLT5ycHRyX2NwdSA9IGloLT5ycHRyOwpAQCAtNTY0
LDEyICs1NDMsOSBAQCBzdGF0aWMgdm9pZCBuYXZpMTBfaWhfc2V0X3JwdHIoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCiAKIAkJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkKIAkJCW5hdmkx
MF9paF9pcnFfcmVhcm0oYWRldiwgaWgpOwotCX0gZWxzZSBpZiAoaWggPT0gJmFkZXYtPmlycS5p
aCkgewotCQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlIX1JCX1JQVFIsIGloLT5ycHRyKTsK
LQl9IGVsc2UgaWYgKGloID09ICZhZGV2LT5pcnEuaWgxKSB7Ci0JCVdSRUczMl9TT0MxNShPU1NT
WVMsIDAsIG1tSUhfUkJfUlBUUl9SSU5HMSwgaWgtPnJwdHIpOwotCX0gZWxzZSBpZiAoaWggPT0g
JmFkZXYtPmlycS5paDIpIHsKLQkJV1JFRzMyX1NPQzE1KE9TU1NZUywgMCwgbW1JSF9SQl9SUFRS
X1JJTkcyLCBpaC0+cnB0cik7CisJfSBlbHNlIHsKKwkJaWhfcmVncyA9ICZpaC0+aWhfcmVnczsK
KwkJV1JFRzMyKGloX3JlZ3MtPmloX3JiX3JwdHIsIGloLT5ycHRyKTsKIAl9CiB9CiAKLS0gCjIu
MTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
