Return-Path: <SRS0=zf+m=5I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6E9C4332B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 14:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F3420735
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 14:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NpA/mb62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F3420735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E1089E14;
	Mon, 23 Mar 2020 14:22:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E736489E14
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 14:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFmPOVxe05GKfo/Av/sLqZd8qAy7uBao2rkFG8LTkfokH771SDR+ViYf/Ho1Qj1hvvUYFOxEPueZsCRtFlYJeXsKXMAUqGvGJfj2U4toj0ZQ17qu23DnB2TnsHyO74YLE6Ti5tD0ecN22wU9ctIvFcORsUowO5eQEVg6TeCt1kyt6b2/7kPCqba3w6ckd4plMRzdqoukZL+ueb91/Yv+s/Pr/OljnZ+sg5h1p3prYp83tXvIoy441mYldLkuw06cSYsfNgL3+ozICRpL89mmg8McPWF6H4yw0wbmGqJz+a/L9sTfPfnqVtmRkBm6k/M3Ac8doBG+PIIO603Vqt6glw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdM8S++3/MKNliUu0+o0JNBvp8WHklw351e3ug/9OYc=;
 b=XJnlZioB1Ew9/8ViW/ZlrA4bNd9k/5gxwOgCa4HdiGqjhKsehj3zg50gZXckManiIk4cD5lV2A+HspTVjJVI9AAESkTLY5XbeuRXF9k3u3qkc5dfXpjLKcF/VA7GqNSrrkBrAlMBlMlWBN1MhwcU6js9GLZ9x50W1hGkOcddX5AEaoh8keN3YFiN9q5lQCr/QYgqQZydGwTKFc9Uh7uj9YfgrDR/e/hFKJh1vZ5KN67NGo6PC5g27pA+Kg/kanpjySxAvP5HcAbsvfyo9WmR+pSuzJVcN3FIFoBSECDOrnhZXWDdkFAiXEyCxR7n9upwBYZWgUb2lqMeYA1Jigukqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdM8S++3/MKNliUu0+o0JNBvp8WHklw351e3ug/9OYc=;
 b=NpA/mb62B+5fuzZGNqlvfyZ/1sJK6iNHm2KSvf+PhaLqCIa/Di4PaedOWPbPaT/53mZGh8VRapvM42fWJMPZmfcl+HYUw8Y/nNO5csSQZStMixXFSFme0MLL6pnyOhwDL95fvrrjJYb9iZBKkKRPPMn3bkm5NlmQiFo4zzQqRNE=
Received: from DM6PR13CA0027.namprd13.prod.outlook.com (2603:10b6:5:bc::40) by
 DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Mon, 23 Mar 2020 14:22:52 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::ad) by DM6PR13CA0027.outlook.office365.com
 (2603:10b6:5:bc::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.9 via Frontend
 Transport; Mon, 23 Mar 2020 14:22:52 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Mon, 23 Mar 2020 14:22:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 23 Mar
 2020 09:22:51 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 23 Mar
 2020 09:22:51 -0500
Received: from yttao-code-machine.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 23 Mar 2020 09:22:49 -0500
From: Yintian Tao <yttao@amd.com>
To: <christian.koenig@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: hold the reference of finished fence
Date: Mon, 23 Mar 2020 22:22:47 +0800
Message-ID: <20200323142247.3175-1-yttao@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(428003)(199004)(46966005)(36756003)(47076004)(1076003)(4326008)(26005)(336012)(110136005)(426003)(6636002)(54906003)(7696005)(186003)(356004)(2616005)(478600001)(316002)(70586007)(8936002)(81166006)(5660300002)(81156014)(70206006)(2906002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3114; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edc39d74-b190-4874-a1b8-08d7cf35abd4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3114342462F4E9E33CB22CF4E5F00@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:357;
X-Forefront-PRVS: 0351D213B3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P21Y6MpAR1dU5jpZFztoagjyIxb5p0R5hFJ4bw4v9+RQtKL7IlBrPsVDI+OGB63uFQSFwnt0V/hBLfsTHUqUjEYc/uJmM//t8hHttUnRvd+eGYPmcLg1E7n7gzwz44krZ8ilGdo/KtcTctclKJsq9jfCVVBqTWf3cAc39Mlc8i56FTI1FDpc2M2JdkVYDDkjjJ65DWbZclbnEdnL05kZDLn7OS4uMTOQiCV67xxG/8G5WLhPvnenaCqc79TbVQd7A1wDuGPV0eG21QSpaSZSIHVzsBQm3Un13pVq42cMwvTEkCCSh1CxwHVEVIx9Kpju6vzc9gTLHjcT+eMBI2jmD1nGoA6tRPUPZr7yKgYsZep7QFDFpHmcWI0UEcAIRwkucJyHGZejG700UTrxv+lnBwyXZDa+tOBUOIqhhPGY9wgBJnosf1XntzM9l+7+nx3o51uJSbabksptt45dDZekjNMfGfe9CJdLwgqR3WkXH1oIzyoIHwp03YpOWLBXp2Vuz8/K5pTpRS56XKiP89D+sA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 14:22:51.8310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc39d74-b190-4874-a1b8-08d7cf35abd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
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
cHJvY2Vzc19qb2IgaW5zdGVhZCBvZgogICAgYW1kZ3B1X2ZlbmNlX3Byb2Nlc3MKdjM6IHJlc3Vt
ZSB0aGUgYmxhbmsgbGluZQoKU2lnbmVkLW9mZi1ieTogWWludGlhbiBUYW8gPHl0dGFvQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMgfCAyICsrCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3Nj
aGVkX21haW4uYwppbmRleCBhMThlYWJmNjkyZTQuLjhlNzMxZWQwZDlkOSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKQEAgLTY1MSw3ICs2NTEsOSBAQCBzdGF0aWMgdm9p
ZCBkcm1fc2NoZWRfcHJvY2Vzc19qb2Ioc3RydWN0IGRtYV9mZW5jZSAqZiwgc3RydWN0IGRtYV9m
ZW5jZV9jYiAqY2IpCiAKIAl0cmFjZV9kcm1fc2NoZWRfcHJvY2Vzc19qb2Ioc19mZW5jZSk7CiAK
KwlkbWFfZmVuY2VfZ2V0KCZzX2ZlbmNlLT5maW5pc2hlZCk7CiAJZHJtX3NjaGVkX2ZlbmNlX2Zp
bmlzaGVkKHNfZmVuY2UpOworCWRtYV9mZW5jZV9wdXQoJnNfZmVuY2UtPmZpbmlzaGVkKTsKIAl3
YWtlX3VwX2ludGVycnVwdGlibGUoJnNjaGVkLT53YWtlX3VwX3dvcmtlcik7CiB9CiAKLS0gCjIu
MTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
