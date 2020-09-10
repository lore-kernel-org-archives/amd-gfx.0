Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052A8C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A354D21D81
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zELl6nyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A354D21D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 518866E937;
	Thu, 10 Sep 2020 13:48:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FBA46E932
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT4LmfDrXhD09JlJhAWO6cPQj5YbcfKNCcBvYXnjGiRrPNFcgAqohuMKdmvQPzPXRAre1ajQP7v8qctjm+yfREh5HmJyrya8ds0I7iiuEWZ6cMVfho5F0ZvZbRCcHRb4RpGHrdDXTfq8YzZ2F9yLJM5BaQcaoipn3sX5qAmrGXD5nrPj8qWBx7d9NuUrS5N7C308/VPLgdIVRR4LO7vXWXk2njw3gnkCMV9EsmVVBvs5GoINWQXzMX4N3aukOtGu75BdC/6do9MSnEfBmLFes+K6C3wwuYi/gqy29ZnJ3T2JGXp3XArOCme9sdZfuxHApnZh5zbplD4ZGjY7WTAoOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t/HQuzdH0yF3PDVK2WcjiX2MuHqg21VeEHaKhReRdY=;
 b=Ahi9x3BRZ8kH1sydRrBL9981UCQfSWMNayIJeH2TSXmDAft160zWZOKf5nmNKnfn6Vjh28Y46Tn9hTdlT7xWBqpN4Jy1BkbswHts+AcbkmiS8JgM/F3BO91zoHJ6jgSdaL3a3j9KHIljAHTLjpEvw4bLpMTeWKzvaD+eEi7TEaDcQ3LcVBEecCJ5bu4MCXE5G56KVXi283dkQ13fwkOznn249+DdHuEWCEBkAMLGplYGCVpbneMZ/ozQgQSG8we3/TL1ssUpdZk7XbZVQygQWOzh4XUPbAbrjCG7vpFrj242Mdx3PytGAO42nmEqk4ZifxHEpvz1EfQjIvAQq+weGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t/HQuzdH0yF3PDVK2WcjiX2MuHqg21VeEHaKhReRdY=;
 b=zELl6nybTEM650QAisP4z9EdVDGIqXPAgeueQmox1MA/nZuygaprYbcZPu44bDRn0MOk7gcQgcneqJGKe4rk4vJzpRBnn4MuW9dq/9pyO2Lpm+eR5402JZALin0IBwzNh4pRllohkIqTeNFURmvaehEl1sY4/TEMwa5EhszzC4k=
Received: from BN4PR12CA0023.namprd12.prod.outlook.com (2603:10b6:403:2::33)
 by DM6PR12MB3465.namprd12.prod.outlook.com (2603:10b6:5:3a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:48:15 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:2:cafe::85) by BN4PR12CA0023.outlook.office365.com
 (2603:10b6:403:2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:48:15 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:48:15 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:48:14 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 37/42] drm/amd/display: fix compile warning in dml
Date: Thu, 10 Sep 2020 09:47:18 -0400
Message-ID: <20200910134723.27410-38-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b59351ea-fd1f-47e7-db2b-08d855902af6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3465:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3465482FBFA6798283803FCD8B270@DM6PR12MB3465.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PoFXnftaJYmGEc/QJb+2YDgR3TUgVboRak6zGCGmyAcltPRN2xk1DbllBNtH+z8mOc+IaJOrFL4eBqv/0Z/KOMuodfRed6NRLM1tq0ML2DsQyfki9gLdnt5e5nu6EXBhBF694GkEB9GZ7JBXKnrtXyyqh+Pd0aQCNOr4bOieqZommKPvVP88VvJUDdtajxxJ8+WZw3ORtYlK6Ge6db7nB5kqc3LSeBsUMkEtigdPyc5GEyGCuu6JN36HA2cTTG8dxa6UmMvddp9dYnwFksGDxYuCQbZlHadavAjBLYGcQRMC6eGx2PwpNtB3+9Yy7nFy9aTzKSKZXeE1UGmkhgDsTyT91AaZDz07OVnd8jThVgvmnz7P2I3GpOrrTFV1iSe06oXuORNjGYI+veqLKIcnXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966005)(6916009)(2906002)(26005)(186003)(82310400003)(1076003)(336012)(54906003)(8676002)(4326008)(86362001)(478600001)(8936002)(83380400001)(44832011)(70586007)(426003)(36756003)(70206006)(2616005)(81166007)(7696005)(82740400003)(47076004)(316002)(356005)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:48:15.6968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b59351ea-fd1f-47e7-db2b-08d855902af6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3465
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <roman.li@amd.com>,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogUm9tYW4gTGkgPHJvbWFuLmxpQGFtZC5jb20+CgpbV2h5XQpnY2MgdmVyc2lvbiA1LjQu
MCBmYWlscyBjb21waWxhdGlvbiB3aXRoOgrigJhQaXhlbFBURVJlcUhlaWdodFBURXPigJkgbWF5
IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uClstV2Vycm9yPW1heWJlLXVu
aW5pdGlhbGl6ZWRdCgpbSG93XQpJbml0aWFsaXplZCB2YXJpYWJsZSBleHBsaWNpdGx5IHdpdGgg
MAoKU2lnbmVkLW9mZi1ieTogUm9tYW4gTGkgPHJvbWFuLmxpQGFtZC5jb20+CkFja2VkLWJ5OiBB
dXJhYmluZG8gUGlsbGFpIDxhdXJhYmluZG8ucGlsbGFpQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RtbC9kY24yMS9kaXNwbGF5X21vZGVfdmJhXzIxLmMgfCAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2RjbjIxL2Rpc3BsYXlf
bW9kZV92YmFfMjEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kbWwvZGNuMjEv
ZGlzcGxheV9tb2RlX3ZiYV8yMS5jCmluZGV4IGE1NzZlZWQ5NGQ5Yi4uMzY3YzgyYjVhYjRjIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1sL2RjbjIxL2Rpc3Bs
YXlfbW9kZV92YmFfMjEuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZG1s
L2RjbjIxL2Rpc3BsYXlfbW9kZV92YmFfMjEuYwpAQCAtMTI5NCw3ICsxMjk0LDcgQEAgc3RhdGlj
IHVuc2lnbmVkIGludCBDYWxjdWxhdGVWTUFuZFJvd0J5dGVzKAogCXVuc2lnbmVkIGludCBNYWNy
b1RpbGVIZWlnaHQ7CiAJdW5zaWduZWQgaW50IEV4dHJhRFBERUJ5dGVzRnJhbWU7CiAJdW5zaWdu
ZWQgaW50IFBERUFuZE1ldGFQVEVCeXRlc0ZyYW1lOwotCXVuc2lnbmVkIGludCBQaXhlbFBURVJl
cUhlaWdodFBURXM7CisJdW5zaWduZWQgaW50IFBpeGVsUFRFUmVxSGVpZ2h0UFRFcyA9IDA7CiAK
IAlpZiAoRENDRW5hYmxlID09IHRydWUpIHsKIAkJKk1ldGFSZXF1ZXN0SGVpZ2h0ID0gOCAqIEJs
b2NrSGVpZ2h0MjU2Qnl0ZXM7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
