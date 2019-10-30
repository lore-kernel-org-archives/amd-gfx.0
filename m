Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBF1CA9EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 09:02:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365742087F
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 09:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365742087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAEC36E8D2;
	Wed, 30 Oct 2019 09:02:24 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750058.outbound.protection.outlook.com [40.107.75.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 358F56E8CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 09:02:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0t2mL2qZvLNASn1g18F1CRZ4He+HTYRhjWFRx6zF9ss5D59VH3fFbgzqse0VnlXuL7o1RvcDoLH9gDj4Wg6TLD0erxJ5dRrAJRoiv8DrfOn/xlBz7yyHVwbteUSqQ87KLsFVtwqdVEoepT/mzw3SqRB/VE2GepnyvtGkZTLyI92PN9dwEWDWx7GU8Z1Fq80o7x2Rxplw7Qy5b1SWPsHkC8e43OP/pwEhrvXlJFDJPvy83CGwZOwkZLG5DyEfsK7TtT+LkAGtY4qtRq/C2a5/73NSRTAM4Ts7Rc2uq9VJGcX7r5S1qKR42Qi1P/Eyk/hNlFJ84G0dM7rAQnQ+2xCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih//S/Yw/wxGFVxfM1IIJP3uE76CjHnzo5l2Polp814=;
 b=j+6ZFlyl2oSvdHfvjW6+HTf4p4FEcNZQ/nui+3ZlfMVPTTMQxWmgJ76XJj4dZEnNoOa0ifVOKQxXeYHhBZoHIP8EIhSExhEBMgigLiP9eiX161g9EWrjjvYrQkltt232Pukkg69nVEPlMfbnsh/cNUs+gLT7q/qB4JwiwRFRLQU5xzT8jWtUf0IpzZekMtGAhbZjInpl504lUnwpTlb0CqjlWcKTYUEaZUaA+zyXKKs3sT18lNRfkgXmcLKcwkzCSdR7UoH5HvZGFCTs1rjbIkj0Wt4k5UYK6hZWxFzxuyyK5AcEaah5hxgU60Z/VIOQgBPg8M7tYNHp4/IQIxoS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from DM3PR12CA0111.namprd12.prod.outlook.com (2603:10b6:0:55::31) by
 DM5PR1201MB0060.namprd12.prod.outlook.com (2603:10b6:4:51::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Wed, 30 Oct 2019 09:02:21 +0000
Received: from DM3NAM03FT030.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::202) by DM3PR12CA0111.outlook.office365.com
 (2603:10b6:0:55::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.23 via Frontend
 Transport; Wed, 30 Oct 2019 09:02:21 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM3NAM03FT030.mail.protection.outlook.com (10.152.82.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2387.20 via Frontend Transport; Wed, 30 Oct 2019 09:02:20 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 30 Oct
 2019 04:02:20 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 30 Oct 2019 04:02:18 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: fix no ACK from LDS read during stress test
 for Arcturus
Date: Wed, 30 Oct 2019 17:02:11 +0800
Message-ID: <1572426131-16337-1-git-send-email-le.ma@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(428003)(199004)(189003)(356004)(6666004)(6916009)(4326008)(126002)(5660300002)(186003)(486006)(4744005)(2616005)(476003)(305945005)(336012)(426003)(44832011)(70206006)(70586007)(8676002)(81156014)(2351001)(26005)(478600001)(50226002)(54906003)(51416003)(81166006)(316002)(16586007)(47776003)(36756003)(2906002)(8936002)(50466002)(86362001)(48376002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0060; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e352c139-9d8c-491e-8a08-08d75d17df73
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0060:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0060DBF940DE82DCA1C8B1B9F6600@DM5PR1201MB0060.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-Forefront-PRVS: 02065A9E77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LSlOpN1kX0zSY1GuXsAc7jbb9o3OepNvpDWb7TY3otJc0qQxoHm3E2QeDAsboorj1TsqRPjADlPjYHOdaV9Lu8K0Qw9mUZTMLLiF8Ywm9KaORfjlJuX/3g9FVLJc/ldsbhfCbCI9Owipxi3uq7SN4I2FMQZpynk490XqPw8A6R+GU4lmh+IwLd99u9Em/QiysGS6hcGNF7DXnMt1j4WIdOPgdq9irnfjy/AaG3gbGNJ6KW+hAXbN7Ym7V2vqlW3y6FUdwvAFPHhYYvbNvqkA3+gT3Mn7AfW4mdmhM8xViPc5GY0uN7epLIWW/yf0NCtsckgkxlxRujwwynqZx9kA8C115NbKtVkr71vO2iZgjWOgXmXvGv2WhvGpWhp9C44a8EZ2aIvVlR+1mDT0i+kunVodTk3dEw4OI6Zjw8aoQJbV3n0YjWTg6lgjKbzm7uMX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2019 09:02:20.9885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e352c139-9d8c-491e-8a08-08d75d17df73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0060
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih//S/Yw/wxGFVxfM1IIJP3uE76CjHnzo5l2Polp814=;
 b=TAVwqV7bJIAmHpXDQVSkaYISadrKvYRn9OomsJ9R0NoqnWVFe1nbWGXDjiMiSG5L3ikLFVQYKOb9nflnAdYkb89NfQRBcwXH6OM1Jx7wsvZM2LmiEOWsBu076NJCvo57SgHCFewaC0eWQzPjYgxKH2g5nJiNMJIBxqHZXWvUAT4=
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
Cc: alexander.deucher@amd.com, Le Ma <le.ma@amd.com>, jay.cornwall@amd.com,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030090211.dmrhPG4S2DLnAS1_km-14GcL0-kVkhsXf1cfrc-P0Ek@z>

U2V0IG1tU1FfQ09ORklHLkRJU0FCTEVfU01FTV9TT0ZUX0NMQVVTRSBhcyBXL1IuCgpDaGFuZ2Ut
SWQ6IEk2MjI1OTA5ZmQ2MjcwMjQyN2ZiYjgwN2UwYzZiYTZiYWZjZmE0MWQ1ClNpZ25lZC1vZmYt
Ynk6IExlIE1hIDxsZS5tYUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92OV8wLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCmluZGV4IDVlN2EwMWMuLjA3OTYyY2EgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwpAQCAtNjk5LDYgKzY5OSw3IEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgc29jMTVfcmVnX2dvbGRlbiBnb2xkZW5fc2V0dGluZ3NfZ2NfOV80XzFf
YXJjdFtdID0KIAlTT0MxNV9SRUdfR09MREVOX1ZBTFVFKEdDLCAwLCBtbVRDUF9DSEFOX1NURUVS
XzNfQVJDVCwgMHgzZmZmZmZmZiwgMHgyZWJkOWZlMyksCiAJU09DMTVfUkVHX0dPTERFTl9WQUxV
RShHQywgMCwgbW1UQ1BfQ0hBTl9TVEVFUl80X0FSQ1QsIDB4M2ZmZmZmZmYsIDB4YjkwZjViMSks
CiAJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1UQ1BfQ0hBTl9TVEVFUl81X0FSQ1Qs
IDB4M2ZmLCAweDEzNSksCisJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1TUV9DT05G
SUcsIDB4ZmZmZmZmZmYsIDB4MDExQTAwMDApLAogfTsKIAogc3RhdGljIGNvbnN0IHUzMiBHRlhf
UkxDX1NSTV9JTkRFWF9DTlRMX0FERFJfT0ZGU0VUU1tdID0KLS0gCjIuNy40CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
