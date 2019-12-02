Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C18C432C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2332084F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2332084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC226E2E3;
	Mon,  2 Dec 2019 17:35:57 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680058.outbound.protection.outlook.com [40.107.68.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 158216E2CD
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxUdSWFw1EzfezRq/Bh/OA19cHhWKMZToZ20J/dXNTOu7FEig31cKi6aqylVjKfoKdK5pnGhLmjulwHeLQnscM0PnBFi41XsoI7IQFOI8exz2ry8jQyg6wT+VmFiEJM2O6E3i1oCJImCyzMm55PMxuPHejLljetYN+luaZwr4f+XRkB6HaNeMAI+lXio29PGIP86r4abYHM9aIq9e7aPZxloMgfIfhKYiUZnxWr/Oxdc5ap4xMD1z+cdYvZfnxHOm99+Q28IgYmkR5EwcJQK4iXEcvCnVQQSzmgAlLMivTq12uGxtk5hwS0l/MwF085c1WYYiUpUBELs04l0pq7NVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+naR8uU9HLdisKwsR8wmfewH5cyAxProAdvlN9ObknI=;
 b=YgRz2xJ7C9m1Ja7pfsCI5LQmyE3STH3eX9px9QYWaPzB40Fwzl0gAQ0mTUSNLpK69XXOAXjKHftDsK5Apc84R/V3cDYvoDz5NSExSHLNBUWlyiehnBZK5A6r37GTs10sOK7zfCfPb+iL3XiGp3+oXtUgKWGsisZkN5QNTZT2RQ4t9z2FTZHMLFjz5DBRxcEMT1pdkRfn2m2cnKGArrF1BaLcq8mEqZGNJjmQELN0cDBWET7NerhYQ+7KsSV5wzRi3Xy7zG0MF1Sz5SCf2QAIXuiUg9TXmV3BdEEqivJO4y3o4ua0XCIHf9kN1MxJ2d5AtFZ+VOwfTlXbXfVYs+QuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:53 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:53 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 43/51] drm/amd/display: update dispclk and dppclk vco frequency
Date: Mon,  2 Dec 2019 12:33:57 -0500
Message-Id: <20191202173405.31582-44-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202173405.31582-1-sunpeng.li@amd.com>
References: <20191202173405.31582-1-sunpeng.li@amd.com>
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aecd7f19-9538-4ed6-aea0-08d7774e045b
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB26102EE9B9DE69EF5ED377CD82430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(51416003)(52116002)(6512007)(66476007)(66556008)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(14444005)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q10o9JaubqS7wBoEAU+U2ALFMfQmAzLFudpn4ArNfUD2Tv6TpEJkEKUc18JjQCOU298PR+4ZtswUbR9EIolRqmbJXyU1ohlikv+YaWuxXsiNvyTmTUKBpIpfPM6BKk+mUS0HW2yTaajjWMeySwATTsmnnQoUlz7+EHJq2QQFa3Fo8Fj7HJBANNAaHwtEgo0yfvwPFiwz2b33P3DM1zzU39DO1+imEAIZpRqe36hg0tVExUAtJX/b9QmvVXFUA9aEwalDQvD83XUc1LW3TvrCgrP/YH7Kb78Z2iwgaUuX0t8bU79gRHyN28YxyvXLjzvNOyQe/5PqKZEsCE2poJ8jZe25iZf4KYwFJPVUt1h2+JR7zYHmQ/vzEiqBCeas4ARWHYWRtZXjXDVGkRkmMXBTX26p9xhP4z/X5n4C7sPuaRg9CGQgFlsNldviimwJEiCZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecd7f19-9538-4ed6-aea0-08d7774e045b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:26.3264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOoHnQAHNdAnKA5+6ccBrkC0MDC6tiR6C1Z5ixdwJnLfUz9kURdAEevZbG1Tku92
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+naR8uU9HLdisKwsR8wmfewH5cyAxProAdvlN9ObknI=;
 b=KeQz6b9uRcDSFGxYc+FuON/whlFOWsefvRxrcIFS1UGMlanBpapIHpmytjIV931jG7pl4EI6vPUoUyvliKdZ7khMYmbUbXJqTqw4Mm7K3pOYwwzcMHhUUvlPSXht2ed9uB7n3MnKCdFyvG7LA4vg8Y/GNOEne0+NX4krzJYnaaI=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
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
Cc: Eric Yang <Eric.Yang2@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Tony Cheng <Tony.Cheng@amd.com>, rodrigo.siqueira@amd.com,
 harry.wentland@amd.com, bhawanpreet.lakha@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogRXJpYyBZYW5nIDxFcmljLllhbmcyQGFtZC5jb20+CgpWYWx1ZSBvYnRhaW5lZCBmcm9t
IERWIGlzIG5vdCBhbGxvd2luZyA4azYwIENUQSBtb2RlIHdpdGggRFNDIHRvCnBhc3MsIGFmdGVy
IGNoZWNraW5nIHJlYWwgdmFsdWUgYmVpbmcgdXNlZCBpbiBodywgZmluZCBvdXQgdGhhdApjb3Jy
ZWN0IHZhbHVlIGlzIDM2MDAsIHdoaWNoIHdpbGwgYWxsb3cgdGhhdCBtb2RlLgoKU2lnbmVkLW9m
Zi1ieTogRXJpYyBZYW5nIDxFcmljLllhbmcyQGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENo
ZW5nIDxUb255LkNoZW5nQGFtZC5jb20+CkFja2VkLWJ5OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjEvZGNuMjFfcmVz
b3VyY2UuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMS9k
Y24yMV9yZXNvdXJjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL2Rj
bjIxX3Jlc291cmNlLmMKaW5kZXggZmVmMTFkNTdkMmI3Li44ZmE2MzkyOWQzYjkgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9yZXNvdXJjZS5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMS9kY24yMV9yZXNvdXJj
ZS5jCkBAIC0yNTUsNyArMjU1LDcgQEAgc3RydWN0IF92Y3NfZHBpX3NvY19ib3VuZGluZ19ib3hf
c3QgZGNuMl8xX3NvYyA9IHsKIAkudm1tX3BhZ2Vfc2l6ZV9ieXRlcyA9IDQwOTYsCiAJLmRyYW1f
Y2xvY2tfY2hhbmdlX2xhdGVuY3lfdXMgPSAyMy44NCwKIAkucmV0dXJuX2J1c193aWR0aF9ieXRl
cyA9IDY0LAotCS5kaXNwY2xrX2RwcGNsa192Y29fc3BlZWRfbWh6ID0gMzU1MCwKKwkuZGlzcGNs
a19kcHBjbGtfdmNvX3NwZWVkX21oeiA9IDM2MDAsCiAJLnhmY19idXNfdHJhbnNwb3J0X3RpbWVf
dXMgPSA0LAogCS54ZmNfeGJ1Zl9sYXRlbmN5X3RvbGVyYW5jZV91cyA9IDQsCiAJLnVzZV91cmdl
bnRfYnVyc3RfYncgPSAxLAotLSAKMi4yNC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZng=
