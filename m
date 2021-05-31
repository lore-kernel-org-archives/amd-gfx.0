Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FA2C47082
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 08:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 530DD6103E
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 08:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530DD6103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADC03897F6;
	Mon, 31 May 2021 08:23:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A8106E884;
 Mon, 31 May 2021 08:23:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXxJSf7upbKiiaA8qL35Plwttee5BdkvU0X2nN6TInz81oKiargfoHq7d+E5MlT4KMoYQSG9ZBkjVH9Fsg5WZqOEAqJ39riEoB56h4BcWYwwBCLUSP/RVqwcJWn/yDbKhxduHqNKUo884Y61BftPJTF7Dlg08bW+SEopnloY1YC0buklu2VXwQAWkQ96RyqrDKSAqNBxQSjeQSOZ+lBGorO6A4Vr5UQqzNtzwKigZgFDNYaq1YJ+wDPneIbG3NbVg9groG5A4bSWZ4tkezi/Q8Paxq5eltQ4kDTKo7pAbvzAJg2knlNvCRa5iRlHLAGVSBermPzHep3gHCq/VOzz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pomkoaOxGlUR1UGQYuCoeiDRnUGFFlIv6X6emanlapk=;
 b=Rpiosm9Ald51rnqvCtSexkhO0uA5BGeoQapJZZ4JcZAKnKPsrDZFIv1DLeAUO1hcIArfHphrgbU7CkSXCvDiantxHvnygaqb1lHbBzS2q3UQZ+euYXGKrGQJ2NeBgWA5ANpzKA0qn6EjrByiS/+HF0YuEJgYKmlOptABsB77R0FeoHQi9tGlT6OaiPuSMaN+uTc2umiFnRmE82yN+zYYXGdB/SNbk08YYwxvQEFNZBNppaZl/lrfOeXE3S3oXigbDWB30/mWM6LR0mQWbWUstSeWNr5n8/498gu2EPJwWMUUBv43wRC3w0Zpb2sfVPksg2n6fS1QLYrlLXpkgHlTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pomkoaOxGlUR1UGQYuCoeiDRnUGFFlIv6X6emanlapk=;
 b=Z+Z1YHBth3+6AeSjmQtQDmlkvUpntooOF6wkE7I5b63joXvz1xmlgtE9Fl/4Vfj4Bsn5kM3FPEqSbUOaVS31TcYUObkuGGNzqrI35NoQD9YR694PdNThfNhwpSXrXdnNJlRoeWFtoQl9D79MHLr+qfgPhhimhsqjM68mn9Fe7UY=
Received: from MWHPR17CA0087.namprd17.prod.outlook.com (2603:10b6:300:c2::25)
 by BL0PR12MB4689.namprd12.prod.outlook.com (2603:10b6:208:8f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 08:23:17 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::2d) by MWHPR17CA0087.outlook.office365.com
 (2603:10b6:300:c2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22 via Frontend
 Transport; Mon, 31 May 2021 08:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Mon, 31 May 2021 08:23:16 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 31 May
 2021 03:23:13 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/ttm: cleanup and add TTM_PL_FLAG_TEMPORARY flag
Date: Mon, 31 May 2021 16:22:39 +0800
Message-ID: <20210531082241.4254-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aceffc50-e687-4994-b599-08d9240d5761
X-MS-TrafficTypeDiagnostic: BL0PR12MB4689:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4689807D851ED19D568EB6FDFB3F9@BL0PR12MB4689.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zrOVq47SHCCfKIyY8qwHfG+316N7iTV1iMvjHT2gxhZwinifBh2cDZ6CEd6SS3SXXuWjnWF7towICOq/ug7X3NZFRdWiiBk+w+Cid+gWYyhp0HC0ToLuexWduJmxKQApn2HKUusnkjXy4pE11fS6zBkQpXZ/J/0Mv7jQubk45UKOYQxeX2zmJVzg0dypnyq5lb5fUhcESo/nmz08sUMLCvXACDRj0zHBi8SNw6c697B+SdloigvTmCCMy2g4+uerbUZ0E0BW3YhZBN5qodoKb2JpRz8PtPjIvBN8xXO2FWgM2Y6QlZXkjRhIQ/i0OLbgORV2znzNx63o8wfkamoFklZaW0tvT9anDFMkw801odraepWTwY6SP8b7OCzf2RPjKCDv1PNkXYsIL3Frb7JSdMVIWeXdqrjuqjrIo1LpHQlPJ9LtwwvaIE0GbvEsdXcUw0uixy4pmU2p5qT6qzIvF4yo476jI6guBKR5V2YbCWRt50JUyftKpxWr5hIpllB7RYhbSDQ4pAKfykwmmFvHfUY6iSCyzBwpqcnGjflWrnM4KLoFou4F/trhxJ6Xf1hXsBGi+LRERfY+b7/m5v9JEppVC90w32NWkZkyQGMu6Il4ZfeMIoFTsfkXt7a8wZd5hqGHh6fsYWwAy3r0dOSTesrVLalffTkOqxzDo5SXjY2L8IoxFkVWONVYEsUaU63
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(36840700001)(66574015)(36756003)(82310400003)(83380400001)(26005)(478600001)(86362001)(2906002)(70586007)(70206006)(1076003)(186003)(110136005)(5660300002)(2616005)(7696005)(54906003)(316002)(426003)(336012)(8936002)(6666004)(8676002)(356005)(36860700001)(81166007)(82740400003)(47076005)(4326008)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 08:23:16.7182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aceffc50-e687-4994-b599-08d9240d5761
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4689
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
Cc: Marek Olsak <Marek.Olsak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Huang
 Rui <ray.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Lang Yu <Lang.Yu@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6?= <thomas_os@shipmail.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Q2xlYW51cCBhbmQganVzdCBtYWtlIFRUTV9QTF9GTEFHXyogc3RhcnQgZnJvbSB6ZXJvLgoKQ3Vy
cmVudGx5LCB3ZSBoYXZlIGEgbGltaXR0ZWQgR1RUIG1lbW9yeSBzaXplIGFuZCBuZWVkIGEgYm91
bmNlIGJ1ZmZlcgp3aGVuIGRvaW5nIGJ1ZmZlciBtaWdyYXRpb24gYmV0d2VlbiBWUkFNIGFuZCBT
WVNURU0gZG9tYWluLgoKVGhlIHByb2JsZW0gaXMgdW5kZXIgR1RUIG1lbW9yeSBwcmVzc3VyZSB3
ZSBjYW4ndCBkbyBidWZmZXIgbWlncmF0aW9uCmJldHdlZW4gVlJBTSBhbmQgU1lTVEVNIGRvbWFp
bi4gQnV0IGluIHNvbWUgY2FzZXMgd2UgcmVhbGx5IG5lZWQgdGhhdC4KRWVzcGVjaWFsbHkgd2hl
biB2YWxpZGF0aW5nIGEgVlJBTSBiYWNraW5nIHN0b3JlIEJPIHdoaWNoIHJlc2lkZXMgaW4KU1lT
VEVNIGRvbWFpbi4KCkFkZCBUVE1fUExfRkxBR19URU1QT1JBUlkgZmxhZyBmb3IgdGVtcG9yYXJ5
IEdUVCBtZW1vcnkgYWxsb2NhdGlvbiB1bmRlcgptZW1vcnkgcHJlc3N1cmUuIEl0IG1heSBiZSB1
c2VmdWwgZm9yIGRpcnZlcnMgd2l0aCBhIGxpbWl0ZWQgR1RUIG1lbW9yeQpzaXplLgoKdjI6IGFk
ZCBkZXRhaWxlZCBjb21tZW50cwoKU3VnZ2VzdGVkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IExhbmcgWXUgPExhbmcuWXVAYW1k
LmNvbT4KLS0tCiBpbmNsdWRlL2RybS90dG0vdHRtX3BsYWNlbWVudC5oIHwgNSArKystLQogMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9pbmNsdWRlL2RybS90dG0vdHRtX3BsYWNlbWVudC5oIGIvaW5jbHVkZS9kcm0vdHRtL3R0bV9w
bGFjZW1lbnQuaAppbmRleCBhYTZiYTRkMGNmNzguLjlmNWNmYzdjMmQ1YSAxMDA2NDQKLS0tIGEv
aW5jbHVkZS9kcm0vdHRtL3R0bV9wbGFjZW1lbnQuaAorKysgYi9pbmNsdWRlL2RybS90dG0vdHRt
X3BsYWNlbWVudC5oCkBAIC00Nyw4ICs0Nyw5IEBACiAgKiB0b3Agb2YgdGhlIG1lbW9yeSBhcmVh
LCBpbnN0ZWFkIG9mIHRoZSBib3R0b20uCiAgKi8KIAotI2RlZmluZSBUVE1fUExfRkxBR19DT05U
SUdVT1VTICAoMSA8PCAxOSkKLSNkZWZpbmUgVFRNX1BMX0ZMQUdfVE9QRE9XTiAgICAgKDEgPDwg
MjIpCisjZGVmaW5lIFRUTV9QTF9GTEFHX0NPTlRJR1VPVVMgICgxIDw8IDApCisjZGVmaW5lIFRU
TV9QTF9GTEFHX1RPUERPV04gICAgICgxIDw8IDEpCisjZGVmaW5lIFRUTV9QTF9GTEFHX1RFTVBP
UkFSWSAgICgxIDw8IDIpCiAKIC8qKgogICogc3RydWN0IHR0bV9wbGFjZQotLSAKMi4yNS4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
