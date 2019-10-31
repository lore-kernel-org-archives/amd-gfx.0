Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE60CA9ECB
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F52520873
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 14:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F52520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 368176EEBC;
	Thu, 31 Oct 2019 14:42:56 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770058.outbound.protection.outlook.com [40.107.77.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAFCC6EEB7
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 14:42:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gyl+iWpjxnm736RRfJkdD+eQU5W2T6BLc5VbMSZ+MQf7ZwM7CzqhVF4uEJNeWQfrv38NiiVxB/14TWqnRBnDEa0xEH4SCWndrTqhNB6ynAUFl/Ef+gIJNKMLtTeJJphSRZ5+NO/kBPpVidWLDSrPDp9WQYIMsoEdXkOhkJWeoZJFOt7n6jp6Znqm2mS2235b5MKe4E5V5wLA99TqJL4mhJl67z/DnR5twsKNK4UQImul6s7UTa1vQTV7StEQaNP9Mri5C7uL3wRz0mOfUSRkwe5LxAKCgXnJK2PO3qQHXxBTlH1zodB8+YBeYFP//CZFaJS/pEUG/M8F6gMlG8O5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9KMGOvJxsutSIla/dP//ZRpeSxugIZ/UnBOM0mInTU=;
 b=NPImrFA4JmfNdzpaCckwhuS5ubYNiUGgTlnvSUdKOoLvPlkW5EVnuwRTZtZ9dUOZRT1SbZosqV0Dy0dybinGaSHrSq3M03sgv9VqGQdsPSKSiuxMcMo5Y5UvHR7UApi/vRLPH3PA1l84leCNp4mkuIYe6Ou+tnbk8gjIAtKRBRR0NrC/2pYknOF2wpQQroAUsyfijzlJfzZTyZIxk3ZaTp5/Ch9WXLENsbbcFlGbeMLM9VTCyRMwYrVmVIC20pg5khPnR1opDoEE+UQRoTgKyUmOG+9OGqYE498F+YAnfOKOF48LSktI6yF+5yF9JG+xBz+axNrXoagvgfYZ8SSlWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
Received: from MWHPR1201CA0010.namprd12.prod.outlook.com
 (2603:10b6:301:4a::20) by DM5PR12MB1419.namprd12.prod.outlook.com
 (2603:10b6:3:77::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20; Thu, 31 Oct
 2019 14:42:45 +0000
Received: from DM3NAM03FT046.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::207) by MWHPR1201CA0010.outlook.office365.com
 (2603:10b6:301:4a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.17 via Frontend
 Transport; Thu, 31 Oct 2019 14:42:45 +0000
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM3NAM03FT046.mail.protection.outlook.com (10.152.83.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2387.20 via Frontend Transport; Thu, 31 Oct 2019 14:42:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:41 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 09:42:41 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 31 Oct 2019 09:42:41 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/20] drm/amd/display: check for dp rev before reading lttpr
 regs
Date: Thu, 31 Oct 2019 10:42:06 -0400
Message-ID: <20191031144210.24011-17-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
References: <20191031144210.24011-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(428003)(189003)(199004)(2351001)(6916009)(86362001)(76176011)(4326008)(51416003)(7696005)(305945005)(8936002)(47776003)(36756003)(50466002)(53416004)(11346002)(8676002)(2616005)(16586007)(70206006)(316002)(478600001)(426003)(476003)(336012)(486006)(50226002)(356004)(26005)(1076003)(186003)(5660300002)(126002)(81156014)(2906002)(446003)(6666004)(70586007)(81166006)(48376002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1419; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c0695a2-5187-4108-9c76-08d75e1096df
X-MS-TrafficTypeDiagnostic: DM5PR12MB1419:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1419007F907D720C7433143FF9630@DM5PR12MB1419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-Forefront-PRVS: 02070414A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PXaVdiaFxiMFb8T94YjK5Vw8tFPIeO/+caVsFUoZ5KJRHiKjnURmrYWMBQIUO/0ADeNXoi6IVs/OGdZtQm/hxxfsxtwYa3WfSSNvZctyPYlJBO5ZrI2x5SMnfLPyiFiLFBPoMEcTWn4LJAkg64KW994K4iDF4Ig9Q1n3UtHMtiTJSAWdIRyHhoGn1gLAqE9NAfeEm6E2Vt550cN0fVfCqm6U84v88pEdEechtyZuUj4d1oiGT8toahpv4ursKhsTUSOn0OV/+388hBURXNJ+ChL1f8ZuCbTJC4o4nfnnYQj49itJNOVmhFRR9nE1tMPqtVTrO2FI6TI2brzyVuiG4ceZtuOvjydCz4dgjyr1M3spyBVEyrEfXXRmmX5tlPrdkN++UoA4c0q29emr1sJr7U7EZ9ZlQhRt0qZt/U+rs9D8l/8jhn7dwWr2V3/hcE3F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2019 14:42:43.8958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0695a2-5187-4108-9c76-08d75e1096df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1419
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9KMGOvJxsutSIla/dP//ZRpeSxugIZ/UnBOM0mInTU=;
 b=TqkJl3Y94YwhdVeY5xLUb0oc19+KdvfZYe0s3lASFHYr/VDO+GL17Pj3tC+DfSa1uixE6owrFAsdQZFywXr/gog/0a9R1MN5NVFN0ILrJa9aUxijiYZXWouKe4bQ7hR/amvOauJVzcDz6lssdUeAaYDK9RDMYDGmO7mzYPTuwPU=
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
Cc: abdoulaye berthe <abdoulaye.berthe@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031144206.95NpknoIiJtdsifbRQEIUm03BHzVfXReKPPl2krI_PA@z>

RnJvbTogYWJkb3VsYXllIGJlcnRoZSA8YWJkb3VsYXllLmJlcnRoZUBhbWQuY29tPgoKW1doeV0K
TFRUUFIgd2FzIGludHJvZHVjZWQgYWZ0ZXIgRFAxLjIuIFJlYWRpbmcgTFRUUFIgcmVnaXN0ZXJz
IDB4RlhYWFgKb24gc29tZSBEUCAxLjIgZGlzcGxheSBpcyBjYXVzaW5nIGFuIHVuZXhwZWN0ZWQg
YmVoYXZpb3IuCgpbSG93XQpNYWtlIHN1cmUgdGhhdCB3ZSBkb24ndCByZWFkIGFueSBsdHRwciBy
ZWdpc3RlcnMgb24gMS4yIGRpc3BsYXlzLgoKU2lnbmVkLW9mZi1ieTogYWJkb3VsYXllIGJlcnRo
ZSA8YWJkb3VsYXllLmJlcnRoZUBhbWQuY29tPgpSZXZpZXdlZC1ieTogQXJpYyBDeXIgPEFyaWMu
Q3lyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNf
bGlua19kcC5jIHwgNSArKystLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Y29yZS9kY19saW5rX2RwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9k
Y19saW5rX2RwLmMKaW5kZXggMmE4OWY5MGVmN2E3Li4xZTQ0ODBmM2JkM2MgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rX2RwLmMKQEAgLTI3NTks
OSArMjc1OSwxMCBAQCBzdGF0aWMgYm9vbCByZXRyaWV2ZV9saW5rX2NhcChzdHJ1Y3QgZGNfbGlu
ayAqbGluaykKIAkvKiBTZXQgZGVmYXVsdCB0aW1lb3V0IHRvIDMuMm1zIGFuZCByZWFkIExUVFBS
IGNhcGFiaWxpdGllcyAqLwogCWJvb2wgZXh0X3RpbWVvdXRfc3VwcG9ydCA9IGxpbmstPmRjLT5j
YXBzLmV4dGVuZGVkX2F1eF90aW1lb3V0X3N1cHBvcnQgJiYKIAkJCSFsaW5rLT5kYy0+Y29uZmln
LmRpc2FibGVfZXh0ZW5kZWRfdGltZW91dF9zdXBwb3J0OworCWxpbmstPmlzX2x0dHByX21vZGVf
dHJhbnNwYXJlbnQgPSB0cnVlOworCiAJaWYgKGV4dF90aW1lb3V0X3N1cHBvcnQpIHsKIAkJc3Rh
dHVzID0gZGNfbGlua19hdXhfY29uZmlndXJlX3RpbWVvdXQobGluay0+ZGRjLCBMSU5LX0FVWF9E
RUZBVUxUX0VYVEVOREVEX1RJTUVPVVRfUEVSSU9EKTsKLQkJbGluay0+aXNfbHR0cHJfbW9kZV90
cmFuc3BhcmVudCA9IHRydWU7CiAJfQogCiAJbWVtc2V0KGRwY2RfZGF0YSwgJ1wwJywgc2l6ZW9m
KGRwY2RfZGF0YSkpOwpAQCAtMjc5Niw3ICsyNzk3LDcgQEAgc3RhdGljIGJvb2wgcmV0cmlldmVf
bGlua19jYXAoc3RydWN0IGRjX2xpbmsgKmxpbmspCiAJCXJldHVybiBmYWxzZTsKIAl9CiAKLQlp
ZiAoZXh0X3RpbWVvdXRfc3VwcG9ydCkgeworCWlmIChleHRfdGltZW91dF9zdXBwb3J0ICYmIGxp
bmstPmRwY2RfY2Fwcy5kcGNkX3Jldi5yYXcgPj0gMHgxNCkgewogCQlzdGF0dXMgPSBjb3JlX2xp
bmtfcmVhZF9kcGNkKAogCQkJCWxpbmssCiAJCQkJRFBfUEhZX1JFUEVBVEVSX0NOVCwKLS0gCjIu
MTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
