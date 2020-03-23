Return-Path: <SRS0=zf+m=5I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D03C4332B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 14:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B68120658
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 14:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NKOHVERK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B68120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93911892BC;
	Mon, 23 Mar 2020 14:14:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9185A892BC
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 14:14:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0mfjLhXHpqSvieKc2rzul83JWBRMUa5Hr+lk80xWQLuKojZ1Lv3bC9ncccxQQ8YlcWXvO+IZKdYVZ66mWztscik8+G2vUZTVmaGUYBlSGrvB60EB0TUhwviyrj6SRJXbqwcFKCQATXvnk8ixqveEYtp8l6Ik7x67OfnWzkBSuZGb3kja032OJ0/0vyh0UHjS2t2FXWeQtQWhaaaEBrFXC59lKB5LnN2hcUSaxeqk9tcyi5OL+tXRZZLJyYn0Z4qpNuQBstg5P8Khy6hOm8yf1lTCQGVdwxKoU0B3Sqadx1h1e7DASNglNV0bunwQuUomDFvk1OTK02GuWDLtPYa/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpUNthyaSbJHj68bvrWHcpgCIbPrC5n9MOFPHRf3rJ8=;
 b=A/phVfCfrx3FLpd8FJNEVk5cwFniOERBYnm3dz/txIA1JvgWU48FGXYRfV1spO68lmjgB4ZENQmN/L8cYFqZztUYoopMiFdLtkWe+0tSihQ40kZH+OFau1E49FNjgd7Ck0t8h0h07/36rDEYTBandtuCesHM0+7FHFymgTd7v76VHWDJjCunyQ5Tq2bJ7xQWaRBbg+O0N2AkLwt62hws1j8otcfv2GOqpRIHXU8U3TW8r+zu+vCmyRyVgC+blvmsJwe0m+1L9TstCcBpuWknyMPVGnvfD2yTKj/6oh6GKLLkOIx51uWSwl3zQuuV63uT/MD0UisTuD7XTESOhHxToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpUNthyaSbJHj68bvrWHcpgCIbPrC5n9MOFPHRf3rJ8=;
 b=NKOHVERKJgQcE/vUmYXmgqSbWhl7z+HDBwphoTY1qiLUPZJJQl/1Gzx7PYeNHZKIwr1ehpCLi6wdoQot2u+VQL0ZbOVfG2BxAIFYsrTDHUIgcfJWS81MC3dfZl/0iwbMWmaHvShk5OMmxyOmFbsaq/GxI939TNcxBW2W1KfiVKI=
Received: from BN3PR03CA0102.namprd03.prod.outlook.com (2603:10b6:400:4::20)
 by DM6PR12MB3003.namprd12.prod.outlook.com (2603:10b6:5:38::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Mon, 23 Mar
 2020 14:14:10 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:400:4:cafe::33) by BN3PR03CA0102.outlook.office365.com
 (2603:10b6:400:4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend
 Transport; Mon, 23 Mar 2020 14:14:10 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Mon, 23 Mar 2020 14:14:10 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 23 Mar
 2020 09:14:09 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 23 Mar 2020 09:14:08 -0500
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: hold the reference of finished fence
Date: Mon, 23 Mar 2020 22:14:05 +0800
Message-ID: <20200323141405.2256-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(428003)(199004)(46966005)(7696005)(47076004)(426003)(2616005)(186003)(6666004)(356004)(2906002)(1076003)(336012)(478600001)(26005)(316002)(110136005)(54906003)(6636002)(5660300002)(36756003)(81166006)(70206006)(4326008)(8936002)(70586007)(81156014)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3003; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 354ab61d-ca3a-40bd-21ce-08d7cf3474d0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3003:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3003E3D10D6DEAB2334F2B96E5F00@DM6PR12MB3003.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:357;
X-Forefront-PRVS: 0351D213B3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSZ8mu/P5nXxfPoQZbGWMO0nFgCTAns2xJAS6VypTQbyzBL04cS8i8q2BmbNEkEl7W7xFV2/yCEuhk5UfeVRozpgjxthewm+1YkTU6vj1W5GPIR/bS4CKOkk4Qwbwpq0jUcx1vQWUzA+auk9QqO0h/hSYOMF0sSGXMteWizGxi4JCe+lpu60TQkIxHL1BbWJi0AOV24Op5ds9BdenHB+7xak8ArLFaWUXtNqg7lsyUkQPYE4JkbFWhF1gCEEJeTpZ4hzlqIQUgorZkIZofYBV2ogMJuy5P1kivZFWVgkBFNZxhn7nOs3SODPzhLiNrfqNUrv7S4Idb9WD/del6eNi5uvH+DG/J/1fvkY4SA4tndc9EO6tzKtRg3mXnOhnq9J0ziTTANTwv77rFlfyl0BiPaN0HQjC+zoNeTzpVf8cQxnQj28/H3Q3hZMWrbPbgTGjQHg6Glqs2hkyKLkNJ0iA+DamuF5Sjf6CWbRdHMgxmSWYGztEeXaLQu93opWFDxzT0jNrJpfkZl43UWGjLjKTQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 14:14:10.0811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 354ab61d-ca3a-40bd-21ce-08d7cf3474d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3003
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
Cc: amd-gfx@lists.freedesktop.org, Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlcmUgaXMgb25lIG9uZSBjb3JuZXIgY2FzZSBhdCBkbWFfZmVuY2Vfc2lnbmFsX2xvY2tlZAp3
aGljaCB3aWxsIHJhaXNlIHRoZSBOVUxMIHBvaW50ZXIgcHJvYmxlbSBqdXN0IGxpa2UgYmVsb3cu
Ci0+ZG1hX2ZlbmNlX3NpZ25hbAogICAgLT5kbWFfZmVuY2Vfc2lnbmFsX2xvY2tlZAoJLT50ZXN0
X2FuZF9zZXRfYml0CmhlcmUgdHJpZ2dlciBkbWFfZmVuY2VfcmVsZWFzZSBoYXBwZW4gZHVlIHRv
IHRoZSB6ZXJvIG9mIGZlbmNlIHJlZmNvdW50LgoKLT5kbWFfZmVuY2VfcHV0CiAgICAtPmRtYV9m
ZW5jZV9yZWxlYXNlCgktPmRybV9zY2hlZF9mZW5jZV9yZWxlYXNlX3NjaGVkdWxlZAoJICAgIC0+
Y2FsbF9yY3UKaGVyZSBtYWtlIHRoZSB1bmlvbiBmbGVkIOKAnGNiX2xpc3TigJ0gYXQgZmluaXNo
ZWQgZmVuY2UKdG8gTlVMTCBiZWNhdXNlIHN0cnVjdCByY3VfaGVhZCBjb250YWlucyB0d28gcG9p
bnRlcgp3aGljaCBpcyBzYW1lIGFzIHN0cnVjdCBsaXN0X2hlYWQgY2JfbGlzdAoKVGhlcmVmb3Jl
LCB0byBob2xkIHRoZSByZWZlcmVuY2Ugb2YgZmluaXNoZWQgZmVuY2UgYXQgZHJtX3NjaGVkX3By
b2Nlc3Nfam9iCnRvIHByZXZlbnQgdGhlIG51bGwgcG9pbnRlciBkdXJpbmcgZmluaXNoZWQgZmVu
Y2UgZG1hX2ZlbmNlX3NpZ25hbAoKWyAgNzMyLjkxMjg2N10gQlVHOiBrZXJuZWwgTlVMTCBwb2lu
dGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDA4ClsgIDczMi45MTQ4MTVd
ICNQRjogc3VwZXJ2aXNvciB3cml0ZSBhY2Nlc3MgaW4ga2VybmVsIG1vZGUKWyAgNzMyLjkxNTcz
MV0gI1BGOiBlcnJvcl9jb2RlKDB4MDAwMikgLSBub3QtcHJlc2VudCBwYWdlClsgIDczMi45MTY2
MjFdIFBHRCAwIFA0RCAwClsgIDczMi45MTcwNzJdIE9vcHM6IDAwMDIgWyMxXSBTTVAgUFRJClsg
IDczMi45MTc2ODJdIENQVTogNyBQSUQ6IDAgQ29tbTogc3dhcHBlci83IFRhaW50ZWQ6IEcgICAg
ICAgICAgIE9FICAgICA1LjQuMC1yYzcgIzEKWyAgNzMyLjkxODk4MF0gSGFyZHdhcmUgbmFtZTog
UUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgcmVsLTEuOC4yLTAt
ZzMzZmJlMTMgYnkgcWVtdS1wcm9qZWN0Lm9yZyAwNC8wMS8yMDE0ClsgIDczMi45MjA5MDZdIFJJ
UDogMDAxMDpkbWFfZmVuY2Vfc2lnbmFsX2xvY2tlZCsweDNlLzB4MTAwClsgIDczMi45Mzg1Njld
IENhbGwgVHJhY2U6ClsgIDczMi45MzkwMDNdICA8SVJRPgpbICA3MzIuOTM5MzY0XSAgZG1hX2Zl
bmNlX3NpZ25hbCsweDI5LzB4NTAKWyAgNzMyLjk0MDAzNl0gIGRybV9zY2hlZF9mZW5jZV9maW5p
c2hlZCsweDEyLzB4MjAgW2dwdV9zY2hlZF0KWyAgNzMyLjk0MDk5Nl0gIGRybV9zY2hlZF9wcm9j
ZXNzX2pvYisweDM0LzB4YTAgW2dwdV9zY2hlZF0KWyAgNzMyLjk0MTkxMF0gIGRtYV9mZW5jZV9z
aWduYWxfbG9ja2VkKzB4ODUvMHgxMDAKWyAgNzMyLjk0MjY5Ml0gIGRtYV9mZW5jZV9zaWduYWwr
MHgyOS8weDUwClsgIDczMi45NDM0NTddICBhbWRncHVfZmVuY2VfcHJvY2VzcysweDk5LzB4MTIw
IFthbWRncHVdClsgIDczMi45NDQzOTNdICBzZG1hX3Y0XzBfcHJvY2Vzc190cmFwX2lycSsweDgx
LzB4YTAgW2FtZGdwdV0KCnYyOiBob2xkIHRoZSBmaW5pc2hlZCBmZW5jZSBhdCBkcm1fc2NoZWRf
cHJvY2Vzc19qb2IgaW5zdGVhZCBvZgogICAgYW1kZ3B1X2ZlbmNlX3Byb2Nlc3MKClNpZ25lZC1v
ZmYtYnk6IFlpbnRpYW4gVGFvIDx5dHRhb0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jIHwgMSAtCiBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVy
L3NjaGVkX21haW4uYyAgICB8IDIgKysKIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2ZlbmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2Uu
YwppbmRleCA3NTMxNTI3MDY3ZGYuLjg1NzBiOWI5ZTBkYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKQEAgLTUyLDcgKzUyLDYgQEAKIAogc3RydWN0IGFtZGdw
dV9mZW5jZSB7CiAJc3RydWN0IGRtYV9mZW5jZSBiYXNlOwotCiAJLyogUkIsIERNQSwgZXRjLiAq
LwogCXN0cnVjdCBhbWRncHVfcmluZwkJKnJpbmc7CiB9OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVy
L3NjaGVkX21haW4uYwppbmRleCBhMThlYWJmNjkyZTQuLjhlNzMxZWQwZDlkOSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKQEAgLTY1MSw3ICs2NTEsOSBAQCBzdGF0aWMg
dm9pZCBkcm1fc2NoZWRfcHJvY2Vzc19qb2Ioc3RydWN0IGRtYV9mZW5jZSAqZiwgc3RydWN0IGRt
YV9mZW5jZV9jYiAqY2IpCiAKIAl0cmFjZV9kcm1fc2NoZWRfcHJvY2Vzc19qb2Ioc19mZW5jZSk7
CiAKKwlkbWFfZmVuY2VfZ2V0KCZzX2ZlbmNlLT5maW5pc2hlZCk7CiAJZHJtX3NjaGVkX2ZlbmNl
X2ZpbmlzaGVkKHNfZmVuY2UpOworCWRtYV9mZW5jZV9wdXQoJnNfZmVuY2UtPmZpbmlzaGVkKTsK
IAl3YWtlX3VwX2ludGVycnVwdGlibGUoJnNjaGVkLT53YWtlX3VwX3dvcmtlcik7CiB9CiAKLS0g
CjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
