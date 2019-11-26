Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631B3C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 21:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF4820722
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 21:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF4820722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C09E06E492;
	Tue, 26 Nov 2019 21:32:38 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F426E492
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 21:32:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmuq/v8kLdOiHirKpVZ5jAqmVqrJz1BxEkh0m8h0GNWP07onDY8FhNKif7ANwBJ1JEj5tMQLFSgXcF/nsYs5BwneByAHIq8Z1yg6vniaenry+5dulTng51dDW6Vsw4G3RXJJRHk5rsJdOKoFAKghywEjKho1LTpjwFf7/VVg4ODMfzNPsj8lGJnzQSgpPeUgEcXy8tRKtAZ+ndzYgbcOuX6NEq1NU417FVwxE7o2jejIwGIReNicqaj03IXRqIRgkVbsz/IgMY9sAP+6jGlVMDb9y7pNiG4wvDKrLgTG3+jKRdMXeuxYCiex8wzxdu2FxGrpBYvvosjLlFMBhvwgGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jmQlGCQIVvhJa7R7YtJG2J/qHbOekickuJEWR8Lc6c=;
 b=gwo0o8nJjI2IMXjjkujLF2lPuRcn0MbEW3HXeSzJyWusITD1UN2dHTJdKbCHaQi8VfuHCpeuykhM2/fXB2Fe+7MF4XMCcHH9oqcZdb+U+De5HEs56ACNgufgyLBPUIhR8vMFkmkTI7Z6FXVAgw7rPYncnrOiCzlKsV6H74vtnecBsY3nOcw37uXsBKlpkivZeFLY+d5xCAukBKEutc2RwZOTN0w0d0+wdLimzUHbx9BQ9zfH8oRTinArZcGZM+xDSPk5Rpwk3hXK7Q4BGSwvAEb3Cxgvtsx8qSSTE+X4oFIBJeJHIvcuKIjcacAYKTgY/uiz7jGllXgzDGcFydD4uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3466.namprd12.prod.outlook.com (20.178.198.225) by
 DM6PR12MB3034.namprd12.prod.outlook.com (20.178.199.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 21:32:34 +0000
Received: from DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616]) by DM6PR12MB3466.namprd12.prod.outlook.com
 ([fe80::8954:6ba3:6dca:4616%7]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 21:32:34 +0000
From: Zhan Liu <zhan.liu@amd.com>
To: amd-gfx@lists.freedesktop.org, hersenxs.wu@amd.com,
 rodrigo.siqueira@amd.com
Subject: [PATCH] drm/amd/display: Get NV14 specific ip params as needed
Date: Tue, 26 Nov 2019 16:32:22 -0500
Message-Id: <20191126213222.17728-1-zhan.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::39) To DM6PR12MB3466.namprd12.prod.outlook.com
 (2603:10b6:5:3b::33)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ecaaabc5-678b-4aae-1401-08d772b8266a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3034:|DM6PR12MB3034:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB30344BF42D697247D59443819E450@DM6PR12MB3034.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(199004)(189003)(99286004)(5660300002)(66946007)(4326008)(6636002)(36756003)(305945005)(66066001)(26005)(7736002)(52116002)(186003)(51416003)(386003)(6512007)(86362001)(66476007)(6506007)(66556008)(6486002)(6436002)(44832011)(25786009)(478600001)(47776003)(6666004)(4744005)(3846002)(2906002)(6116002)(50466002)(14454004)(81156014)(81166006)(8676002)(16586007)(48376002)(316002)(1076003)(50226002)(2616005)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3034;
 H:DM6PR12MB3466.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Yo1wmw+7ddn2A6668tKyHbzqeyQ/CRHBucj5Mq9hZ7o11LOUafZbtnQgbVyDEU3rGLaesa1DgrTTIc4E66iB+V2HXkYhDSHu3KgowqltvU2qBXqzw/nylZKoWaceLrrd6xny4Gp8AKgzlZJ4n6qvXpsYg1En/rkcjpqsHwafhqsgxwSKJA6xGp5EWBkEEXOPlMFg+rnZeuGYUGWU5saI3C7CXR9+XFpa+8C28CzshcCqyT9ceJYu9UUAhWfLNMbbDCpT2WeBfrcrs3O44vu0NSRbJaUK0URmkDMTp6CEem9V2e/yoX6YPGHTO0LTPZSwFs0Pb4LEu3Yo0eUn9f0+j39n64ao6AlcyfOwT9M8hTy+mXq4NrmelJ7bHhsYQQ6yoTpx4EXnFQqvQYzRd4CKrhdL5eliXAea53LtCF9cpn9ZId9hmwEUOlFrnMtHoOP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecaaabc5-678b-4aae-1401-08d772b8266a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 21:32:34.2558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/Jr33OlLFajeWX8/MN1+j/CXxKwz+wqaBbuRCtawC8BOlPabPNsL8uNmGMKNewh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3034
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jmQlGCQIVvhJa7R7YtJG2J/qHbOekickuJEWR8Lc6c=;
 b=kwL6+h6qHX71AY565JQ6/JmBEO10tilLrwrRxvkmx6PikGEJmRwSmJtDkZaxZu6hcy5PJlpWEEQkR+giVzxmfq0RGlPumBEX2UBk7oI4Ng/lTXFLx0OzkF2b1iaSqrEsEraSNJHm4E3on4M0mOXigjrCDR7Cdsxt1Xgqi2aWkzM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhan.Liu@amd.com; 
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
Cc: Zhan Liu <zhan.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126213222.10JjmxoLDM2f4CEkTor422vARkKLJ4stjjTgE24uGVs@z>

W1doeV0KTlYxNCBpcyB1c2luZyBpdHMgb3duIGlwIHBhcmFtcyB0aGF0J3MgZGlmZmVyZW50IGZy
b20gb3RoZXIKRENOMi4wIEFTSUNzLgoKW0hvd10KQWRkIEFTSUMgcmV2aXNpb24gY2hlY2sgdG8g
bWFrZSBzdXJlIE5WMTQgZ2V0cyBjb3JyZWN0CmlwIHBhcmFtcy4KClNpZ25lZC1vZmYtYnk6IFpo
YW4gTGl1IDx6aGFuLmxpdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNuMjAvZGNuMjBfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Y24yMC9kY24yMF9yZXNvdXJjZS5jCmluZGV4IGRiYzBhNGE3YzI4NC4uM2RkMmIyNDI5YWUyIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVz
b3VyY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBf
cmVzb3VyY2UuYwpAQCAtMzI0NSw2ICszMjQ1LDkgQEAgc3RhdGljIHN0cnVjdCBfdmNzX2RwaV9z
b2NfYm91bmRpbmdfYm94X3N0ICpnZXRfYXNpY19yZXZfc29jX2JiKAogc3RhdGljIHN0cnVjdCBf
dmNzX2RwaV9pcF9wYXJhbXNfc3QgKmdldF9hc2ljX3Jldl9pcF9wYXJhbXMoCiAJdWludDMyX3Qg
aHdfaW50ZXJuYWxfcmV2KQogeworCWlmIChBU0lDUkVWX0lTX05BVkkxNF9NKGh3X2ludGVybmFs
X3JldikpCisJCXJldHVybiAmZGNuMl8wX252MTRfaXA7CisKIAkvKiBOVjEyIGFuZCBOVjEwICov
CiAJcmV0dXJuICZkY24yXzBfaXA7CiB9Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
