Return-Path: <SRS0=udrn=ZW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E70C432C0
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Nov 2019 22:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51AF2075A
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Nov 2019 22:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51AF2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57BF289F92;
	Sat, 30 Nov 2019 22:42:01 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720061.outbound.protection.outlook.com [40.107.72.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A971989F92
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Nov 2019 22:42:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WY71ZqFDq/BKJiwut6xeA0i9HdJuGRMIMA6uCYVRB82xWa0ECjATmAB4mA3vnrngmzXE4O1Ytej6HS4VJOcVnkxihSXLvXrruQsvCIQL00Wg5OEaOpubSoF//tH1ZnmRg+3bJOzIeWWbicni6YwJ3tt0elgHQGXNAs5ykvWOO0fL/091+00PtzeUX3wa0GFV0p8hnAOVMb0P3S4muQMZTIl/QGLoW9ftnkO2PSo7WhI21p77ftL3QOQpgIwtyPlTYKu2KJPW/Lz46eqhtQyvYGRcO/Z72icks9zv1W6oWeKV0DcbqQUFDcTsi/oFx3ekYTGONl4+VuITHHrgju5rtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu9yguBI6TCS7jVoeZzAHcALTpCAjxj7zmCQ9WaETPY=;
 b=D4YtiXgX+JXX9p37ULtffqSatZ68Jpl5u0ScbGv5nFWgKFaOFbnMa9lUKt5/f5/DL4DocyTq9QpYc0NR3pyMI6nZoGhIyI7nOiWcQ5qkvYqftEN3jYkYweKaDUo9h1b4ziZskI6qZetn6rH8+Hel2vsVVd3UqtCLQInLupXqM7GWYM+yOxBfNQDhHR4Rf1wv5X8zZ3dD1lokjKKbkWd3/vwCz/TRB5ELE23/G2yFp4+6VWI5mfZ+V3hn0lOWrkk4uicG4gAsjEtUNSwq0qkHSWpxEOaN5S5NrKdFQ8QjA93u+KOi/tqOOZHkByTb+/jNCuQIT34BWwxXFQdOWVXYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from CH2PR12CA0016.namprd12.prod.outlook.com (2603:10b6:610:57::26)
 by BN6PR12MB1652.namprd12.prod.outlook.com (2603:10b6:405:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Sat, 30 Nov
 2019 22:41:55 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::200) by CH2PR12CA0016.outlook.office365.com
 (2603:10b6:610:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2495.18 via Frontend
 Transport; Sat, 30 Nov 2019 22:41:55 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2451.23 via Frontend Transport; Sat, 30 Nov 2019 22:41:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 30 Nov
 2019 16:41:54 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 30 Nov
 2019 16:41:54 -0600
Received: from emily-build-machine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Sat, 30 Nov 2019 16:41:53 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov: No need the event 3 and 4 now
Date: Sun, 1 Dec 2019 06:41:40 +0800
Message-ID: <1575153700-10434-1-git-send-email-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(428003)(189003)(199004)(316002)(53416004)(2616005)(186003)(16586007)(26005)(2351001)(48376002)(70206006)(70586007)(336012)(14444005)(5660300002)(356004)(6666004)(478600001)(36756003)(81166006)(81156014)(7696005)(51416003)(50226002)(305945005)(4744005)(8676002)(426003)(50466002)(8936002)(47776003)(86362001)(2906002)(4326008)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1652; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8c3ac84-8034-4bf3-01a6-08d775e68068
X-MS-TrafficTypeDiagnostic: BN6PR12MB1652:
X-Microsoft-Antispam-PRVS: <BN6PR12MB165227E3251792ED1F39FF478F410@BN6PR12MB1652.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 02379661A3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wqc22mINAWA+1tfkOXgBloCDhOyZ7Mw75dqmKKbpf9DyUCGA3DlTh5Vn3WcSpEA58dS780kayVlAGkNRkYe4uDosjnYEhiLdj45L5yJez16AIGzOPVOHLAf9Gstd2bTEpLuo5wfjKgo6bHBge8e4h5D/zoyiSMgQuUjFvwsjES3biJaJHDtx47LHIf1999sXyfBCZ/Q6nl8irZ4jAg4J00pV4ce23lmQpZFRnxe68XTaOOZNCs4+8oDB8xsE225kQmRzl/9EZ6VvcKQ8iNe0diWWj1ExsHlOqF9/1TowZv+YIHysk2hQa7qNmk6r2vVPBUnz0ByJmwb3z6ptzHsY3p1uU8VAyTOBOelrKvFSgE+R/Ta26mKMcEqD/VfNfOOeoFWUuDAkqiEbFQDNoKHmXulM/eRlkjlQHL4O2kjOxf95NdOrKeWPgKFo3/rhx/Di
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2019 22:41:55.2581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c3ac84-8034-4bf3-01a6-08d775e68068
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1652
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu9yguBI6TCS7jVoeZzAHcALTpCAjxj7zmCQ9WaETPY=;
 b=zk7n1MvrCWr70YUzHJ/n3f8SFFLJvDU0AW0FtuZp+3MxpbenalPlvEICl4RNr9dyeZo+4r++vrnmZtxQg+bdn2vyobELCYvBYaD+0H40BWbJTPxyq0KTzixshW7CyAnz74j7sSi6iA56up2JzTjpujfMEmqJ5WdLgoyR9hQgMS8=
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
Cc: Emily Deng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXMgd2lsbCBjYWxsIHVubG9hZCBrbXMgd2hlbiBpbml0aWFsaXplIGZhaWwsIGFuZCB0aGUgdW5s
b2FkIGttcyB3aWxsCnNlbmQgZXZlbnQgMyBhbmQgNCwgc28gZG9uJ3QgbmVlZCBldmVudCAzIGFu
ZCA0IGluIGRldmljZSBpbml0LgoKU2lnbmVkLW9mZi1ieTogRW1pbHkgRGVuZyA8RW1pbHkuRGVu
Z0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCBkMWQ1NzNkLi4wMzkzZTM1IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0zMDM2LDggKzMw
MzYsNiBAQCBpbnQgYW1kZ3B1X2RldmljZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAogCQl9CiAJCWRldl9lcnIoYWRldi0+ZGV2LCAiYW1kZ3B1X2RldmljZV9pcF9pbml0IGZhaWxl
ZFxuIik7CiAJCWFtZGdwdV92Zl9lcnJvcl9wdXQoYWRldiwgQU1ER0lNX0VSUk9SX1ZGX0FNREdQ
VV9JTklUX0ZBSUwsIDAsIDApOwotCQlpZiAoYW1kZ3B1X3ZpcnRfcmVxdWVzdF9mdWxsX2dwdShh
ZGV2LCBmYWxzZSkpCi0JCQlhbWRncHVfdmlydF9yZWxlYXNlX2Z1bGxfZ3B1KGFkZXYsIGZhbHNl
KTsKIAkJZ290byBmYWlsZWQ7CiAJfQogCi0tIAoyLjcuNAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4
