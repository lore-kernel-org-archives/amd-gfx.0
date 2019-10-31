Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE669CA9ECB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E6320873
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E6320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F54E6EEAD;
	Thu, 31 Oct 2019 14:42:46 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690078.outbound.protection.outlook.com [40.107.69.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABAA96EEAF
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 14:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWh+bBJatOKRyEFA1+G9x2FjkRcjfnaoRx9mwKm5dNpNpdeOiDQkyjycmb2WLqTlbmkzYdm/vRtGFmPevFpbBJmt6p/1qVL4Spd/0HQkZsqCNYDektIShqglEaq/qMpoH+0QtA2+4hWiwYssrDmFS86y+43x1hCio13q0Rp0f+nKA23lkqCy7YzRM3gcEKMOQvfIgTPLhayjVeo/hjHT/AGTm45VV3jMrHdFYFI5lYEiolXRrX60m5zF/5z+Vbw7egtZGKABM8xod1fzQODRADMdvPd2bjct1ZSQ110W5RbHflf5K74eZjJeySS9SqpeVZpa4GWPXZyHRbuQlSfc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES/SsvFTRvWsXBA8suDBAD0K4YFwaDeOJG8NCpg4GIQ=;
 b=SlfNQDUOMFx45/3hrnbts/p0pbYvcsiTa16IeKMQ43l6hkaAu/8Om3UaMy3ZWFhEGj9J500H/alw8ZGjKQcKzB1cQc8myy9csCCRARd3fWwbKAQLHHQ0M3zKW2FWzJduxoOy1W5YdiLigRvT2PfuRkiex/rPL4+g4rvA6QKaLQwtmBYkKeUONk5KGxkX8gCJ56ynwSWVYo5ZT4hbImMc89zRi/imGHF5m5ZbR7OlzMPb+6LuYP0NmQeKF5uMm5SbFKLHf29eTikXGw4RRoRaUblOOU0HVmRpNcii+pQb99a02OCIb+jYWr9844H23D3rU4U5IYcSRnSevkvyi8locg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MWHPR12CA0060.namprd12.prod.outlook.com (2603:10b6:300:103::22)
 by MWHPR1201MB0128.namprd12.prod.outlook.com (2603:10b6:301:56::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.17; Thu, 31 Oct
 2019 14:42:28 +0000
Received: from DM3NAM03FT043.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::206) by MWHPR12CA0060.outlook.office365.com
 (2603:10b6:300:103::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.21 via Frontend
 Transport; Thu, 31 Oct 2019 14:42:28 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM3NAM03FT043.mail.protection.outlook.com (10.152.83.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 31 Oct 2019 14:42:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:27 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:27 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 31 Oct 2019 09:42:26 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/20] DC Patches 31 Oct 2019
Date: Thu, 31 Oct 2019 10:41:50 -0400
Message-ID: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(346002)(428003)(189003)(199004)(426003)(4326008)(6916009)(81166006)(7696005)(26005)(51416003)(186003)(2906002)(8676002)(126002)(476003)(2616005)(486006)(81156014)(53416004)(8936002)(336012)(50226002)(478600001)(356004)(6666004)(48376002)(50466002)(16586007)(316002)(36756003)(305945005)(86362001)(14444005)(47776003)(2351001)(70206006)(1076003)(5660300002)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR1201MB0128; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7710cc1-d38b-40f2-1d71-08d75e108d5a
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0128:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0128930EC478E1A5A5179178F9630@MWHPR1201MB0128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:284;
X-Forefront-PRVS: 02070414A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6fQXk9wUN2g9Qn1Bos/SFFGvwJQ/xVG9EbfdTqkdg6rNCMFDPZ2loP+QAB4LC3pRhLpP1KDFkjVe9HYw+aO8b4vy9ck9Ust5hwyzHFkKEAJmwsUO820/JtmhpjnzK89DWOfFO6gJh8vpgE9P5T4q4GLDgQQjCs7xuKoH/ZZSbfhuhYu7lUr4J4KI37hDjK1DcOWrRkzvJokOjk56cYyC2hAXJpgJnE5IHvjEwRIVpJHoaljTPEad5S+Z6ninI4jQozSa1ENtsFa44jnrjVU3SgwwDZUYdv8tssLQtoSSRE2jCl4AoxqlHqqshtL7jdUSLxku0Dm2JrMMfqFztGGvsdflBbqmlT3o+qWDBZuFGssUjksWOy00jUT7xWxfr2dYNtpARHc3/6WFvvKF878aRtk5N3F2PkcLhTNhjkI4W/4DYdVhrex29Ba4hLaTUAU9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2019 14:42:27.9274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7710cc1-d38b-40f2-1d71-08d75e108d5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0128
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES/SsvFTRvWsXBA8suDBAD0K4YFwaDeOJG8NCpg4GIQ=;
 b=EDNsuP6RCG4h/twV+DA34zL9Pp1YuuyYEwZER17b6ORJpKpM/RRvcvkQvMdWku0LxvNQcx4IBkJLBTIVlxLFuEbFaZs3xuFfiBIS0YoXW0//8lbVCe9COE2Cggs3EORNhXYrz6x4RdJ4SHhrWl0qT7oyp+ji6yzAzn0VXNwt7bQ=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is
 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031144150.ePooUG10UPjDnvYMKsdhqNxJ7MKLosSr29IMYBO3Uv4@z>

U3VtbWFyeSBPZiBDaGFuZ2VzCipjb25maWd1cmUgYW5kIGluaXQgbHR0cHIKKkRTQyBzYW5pdHkg
Y2hlY2sKKkJhbmR3aWR0aCBvcHRpbWl6YXRpb24KKlNvbWUgYXNzZXJ0IGZpeGVzCgpBbnRob255
IEtvbyAoMSk6CiAgZHJtL2FtZC9kaXNwbGF5OiBzZXQgTVNBIE1JU0MxIGJpdCA2IHdoaWxlIHNl
bmRpbmcgY29sb3JpbWV0cnkgaW4gVlNDCiAgICBTRFAKCkFyaWMgQ3lyICgyKToKICBkcm0vYW1k
L2Rpc3BsYXk6IDMuMi41NwogIGRybS9hbWQvZGlzcGxheTogMy4yLjU4CgpEYXZpZCBHYWxpZmZp
ICgyKToKICBkcm0vYW1kL2Rpc3BsYXk6IEZpeCBhc3NlcnQgb2JzZXJ2ZWQgd2hlbiBwZXJmb3Jt
aW5nIGR1bW15IHAtc3RhdGUKICAgIGNoZWNrCiAgZHJtL2FtZC9kaXNwbGF5OiBDcmVhdGUgZGVi
dWcgb3B0aW9uIHRvIGRpc2FibGUgdi5hY3RpdmUgY2xvY2sgY2hhbmdlCiAgICBwb2xpY3kuCgpF
cmljIFlhbmcgKDEpOgogIGRybS9hbWQvZGlzcGxheTogUmVub2lyIGNocm9tYSB2aWV3cG9ydCBX
QQoKSnVuIExlaSAoMSk6CiAgZHJtL2FtZC9kaXNwbGF5OiBhZGQgb2VtIGkyYyBpbXBsZW1lbmF0
aW9uIGluIGRjCgpMZW8gKEhhbmdob25nKSBNYSAoMSk6CiAgZHJtL2FtZC9kaXNwbGF5OiBBZGQg
c29tZSBoYXJkd2FyZSBzdGF0dXMgaW4gRFROIGxvZyBkZWJ1Z2ZzCgpOaWtvbGEgQ29ybmlqICgx
KToKICBkcm0vYW1kL2Rpc3BsYXk6IEFkZCBhIHNhbml0eSBjaGVjayBmb3IgRFNDIGFscmVhZHkg
ZW5hYmxlZC9kaXNhYmxlZAoKUmV6YSBBbWluaSAoMSk6CiAgZHJtL2FtZC9kaXNwbGF5OiBVbmlm
eSBhbGwgc2NhbGluZyB3aGVuIEludGVnZXIgU2NhbGluZyBlbmFibGVkCgpTdW5nIExlZSAoMSk6
CiAgZHJtL2FtZC9kaXNwbGF5OiBVc2UgU0lHTkFMX1RZUEVfTk9ORSBpbiBkaXNhYmxlX291dHB1
dCB1bmxlc3MgZURQCgpZb25ncWlhbmcgU3VuICgzKToKICBkcm0vYW1kL2Rpc3BsYXk6IENoYW5n
ZSBkbWN1IGluaXQgc2VxdWVuY2UgZm9yIGRtY3ViIGxvYWRpbmcgZG1jdSBGVy4KICBkcm0vYW1k
L2Rpc3BsYXk6IG9wdGltaXplIGJhbmR3aWR0aCBhZnRlciBjb21taXQgc3RyZWFtcy4KICBkcm0v
YW1kL2Rpc3BsYXk6IEFkZCBQU1AgRlcgdmVyc2lvbiBtYXNrLgoKYWJkb3VsYXllIGJlcnRoZSAo
Nik6CiAgZHJtL2FtZC9kaXNwbGF5OiBpbml0aWFsaXplIGx0dHByCiAgZHJtL2FtZC9kaXNwbGF5
OiBjaGVjayBmb3IgZHAgcmV2IGJlZm9yZSByZWFkaW5nIGx0dHByIHJlZ3MKICBkcm0vYW1kL2Rp
c3BsYXk6IGNvbmZpZ3VyZSBsdHRwciBtb2RlCiAgZHJtL2FtZC9kaXNwbGF5OiBpbXBsZW1lbnQg
bHR0cHIgbG9naWMKICBkcm0vYW1kL2Rpc3BsYXk6IHVzZSBwcmV2aW91cyBhdXggdGltZW91dCB2
YWwgaWYgbm8gcmVwZWF0ZXIuCiAgZHJtL2FtZC9kaXNwbGF5OiBkaXNhYmxlIGx0dHByIGZvciBp
bnZhbGlkIGx0dHByIGNhcHMuCgogLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbS5jIHwgICA0ICstCiAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJz
ZXIyLmMgICAgfCAgNjMgKystCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9k
Yy5jICAgICAgfCAgMjMgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2Rj
X2xpbmsuYyB8ICAgMSArCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtf
ZGRjLmMgfCAgMTggKy0KIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19k
cC5jICB8IDQxOSArKysrKysrKysrKysrKystLS0KIC4uLi9kcm0vYW1kL2Rpc3BsYXkvZGMvY29y
ZS9kY19saW5rX2h3c3MuYyAgICB8ICAzOSArLQogLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Y29yZS9kY19yZXNvdXJjZS5jIHwgIDIxICstCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGMuaCAgICAgICAgICAgfCAgIDcgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY19saW5rLmggICAgICB8ICAgNSArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNfc3RyZWFtLmggICAgfCAgIDIgKwogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
X3R5cGVzLmggICAgIHwgIDI1ICsrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNl
L2RjZV9hdXguYyAgfCAgNDYgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2Uv
ZGNlX2F1eC5oICB8ICAgMiArLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9k
Y2VfZG1jdS5jIHwgIDc5ICsrKysKIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2Uv
ZGNlX2RtY3UuaCB8ICAxMyArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2Rj
ZV9pMmMuYyAgfCAgMTkgKy0KIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfaTJj
X3N3LmMgICB8ICA0MyAtLQogLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9pMmNf
c3cuaCAgIHwgICA2ICstCiAuLi4vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9zdHJlYW1fZW5jb2Rl
ci5jICAgfCAgIDEgKwogLi4uL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9od19zZXF1ZW5jZXIu
YyAgIHwgICAzICsKIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h1YnAu
YyB8ICAgMyArCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9odWJwLmgg
fCAgIDEgKwogLi4uL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX2h3X3NlcXVlbmNlci5jIHwg
IDQ1ICstCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9vcHAuYyAgfCAg
IDEgKwogLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfb3B0Yy5oIHwgICAx
ICsKIC4uLi9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX3N0cmVhbV9lbmNvZGVyLmMgICB8ICAgNiAr
LQogLi4uL2Rpc3BsYXkvZGMvZGNuMTAvZGNuMTBfc3RyZWFtX2VuY29kZXIuaCAgIHwgICAxICsK
IC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2RzYy5jICB8ICAyNSArLQog
Li4uL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2xpbmtfZW5jb2Rlci5jIHwgICAxICsKIC4u
Li9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYyB8ICAxNiArCiAuLi4v
ZGlzcGxheS9kYy9kY24yMC9kY24yMF9zdHJlYW1fZW5jb2Rlci5jICAgfCAgIDcgKy0KIC4uLi9k
aXNwbGF5L2RjL2RjbjIwL2RjbjIwX3N0cmVhbV9lbmNvZGVyLmggICB8ICAgMSArCiAuLi4vZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9odWJwLmMgfCAgNjUgKystCiAuLi4vZHJt
L2FtZC9kaXNwbGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNlLmMgfCAgIDUgKy0KIC4uLi9kYy9k
bWwvZGNuMjAvZGlzcGxheV9tb2RlX3ZiYV8yMC5jICAgICAgICB8ICAgMyArLQogLi4uL2RjL2Rt
bC9kY24yMC9kaXNwbGF5X21vZGVfdmJhXzIwdjIuYyAgICAgIHwgICA2ICstCiAuLi4vYW1kL2Rp
c3BsYXkvZGMvZG1sL2Rpc3BsYXlfbW9kZV9zdHJ1Y3RzLmggfCAgIDEgKwogLi4uL2RybS9hbWQv
ZGlzcGxheS9kYy9kbWwvZGlzcGxheV9tb2RlX3ZiYS5jIHwgICA0ICsKIC4uLi9kcm0vYW1kL2Rp
c3BsYXkvZGMvZG1sL2Rpc3BsYXlfbW9kZV92YmEuaCB8ICAgMiArCiAuLi4vZGlzcGxheS9kYy9n
cGlvL2RjbjIwL2h3X2ZhY3RvcnlfZGNuMjAuYyAgfCAgMTIgKwogLi4uL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvaW5jL2NvcmVfdHlwZXMuaCAgIHwgICAyICsKIC4uLi9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2luYy9kY19saW5rX2RkYy5oICB8ICAgMiArLQogLi4uL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvaW5jL2RjX2xpbmtfZHAuaCAgIHwgICA0ICstCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvaW5jL2h3L2RtY3UuaCAgfCAgIDIgKwogLi4uL2RybS9hbWQvZGlzcGxheS9kYy9p
bmMvaHcvbGlua19lbmNvZGVyLmggIHwgICAxICsKIC4uLi9hbWQvZGlzcGxheS9kYy9pbmMvaHcv
c3RyZWFtX2VuY29kZXIuaCAgICB8ICAgMSArCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9p
bmMvbGlua19od3NzLmggICAgfCAgIDYgKy0KIC4uLi9kYy92aXJ0dWFsL3ZpcnR1YWxfc3RyZWFt
X2VuY29kZXIuYyAgICAgICB8ICAgMSArCiAuLi4vZGlzcGxheS9pbmNsdWRlL2dycGhfb2JqZWN0
X2N0cmxfZGVmcy5oICAgfCAgIDMgKy0KIC4uLi9hbWQvZGlzcGxheS9tb2R1bGVzL2luYy9tb2Rf
aW5mb19wYWNrZXQuaCB8ICAgNCArLQogLi4uL2Rpc3BsYXkvbW9kdWxlcy9pbmZvX3BhY2tldC9p
bmZvX3BhY2tldC5jIHwgIDQ2ICstCiA1MiBmaWxlcyBjaGFuZ2VkLCA4ODQgaW5zZXJ0aW9ucygr
KSwgMjMzIGRlbGV0aW9ucygtKQoKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
