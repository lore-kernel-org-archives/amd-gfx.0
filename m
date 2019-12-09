Return-Path: <SRS0=Fyns=Z7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FC9C43603
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 18:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D7C205C9
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Dec 2019 18:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D7C205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C43E76E509;
	Mon,  9 Dec 2019 18:58:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C0D6E509
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Dec 2019 18:58:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8/BGHMhRS47+LN9K1lMpXCfnMfuSUDRDHfDquTFqhGLYBz43J7pde9qzb2FLe4MMJq2CqAA54EGcOy5rlbQGhLinguINuKduC3/DGPKLND7B0kAl0JMejNiPAEpSdrgRLuHuJ+YEYm0AOCTSuPsDwL1nCj+qp96SNkqEbURTZdCjiXDc19cI5Xa9UgrC4fq4B75aizVFRsftpFev7OxLgLCswvevUoLfXOdT6kXokuFKU25N3T6Mvlr3BuCRXfagNzEK0xYjJIfaQevCmF0zy7NUiJcdkSoFO5Ef2rGLz2dzXkHDySXtcvREX5qgVs9YDIBp+9M+Tc3c6CpN3R7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMXY4pOBYhfpIzVuDFbxumAzbrjD3nmSmvGeXcxL+dY=;
 b=l6ty88Vc5c/dmATUEVy1s34lMNEie1i0HCYbRtDsv+ugvy3AucBXKnWPKfJ0eqgj7rXB3XslzpNjA89GquyxIbdCtpvkpMZCEeh9Qf9MMDnBBK5mvGrZW/DhI6KcUYRquphW78DC7Kj9i0wMmuOpDOSvXPsKfIf9GMMmzyQKFSu1m8qT81XvnJ6S31cW20kcqVPi7FiFMva6Xt+nfhX0QOthq1mQf4byHw+pc49eXWZMunnYJOPF0tIjIlR9i8IU8a6bOUk45qIifvhTVFyqY1WGF+fHErUTWLO3TREtyraYoU4SAq5+IJ+FvzKQnd/cYkeUsbRcYaDrTvDKZLq2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3612.namprd12.prod.outlook.com (20.178.30.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.17; Mon, 9 Dec 2019 18:58:29 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::71fe:9848:c834:1cd6]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::71fe:9848:c834:1cd6%3]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 18:58:29 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] tests/amdgpu: Fix unused function warning (v2)
Date: Mon,  9 Dec 2019 13:58:00 -0500
Message-Id: <05ce81cdbd389ef54e6cb63a055ed64b4a82f9eb.1575917839.git.luben.tuikov@amd.com>
X-Mailer: git-send-email 2.24.0.390.g083378cc35
In-Reply-To: <f57d33f459df0c733ef108b2beb889e844450542.1575917839.git.luben.tuikov@amd.com>
References: <f57d33f459df0c733ef108b2beb889e844450542.1575917839.git.luben.tuikov@amd.com>
X-ClientProxiedBy: YTOPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::20) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0.390.g083378cc35
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d28c2683-e727-4c1a-8acc-08d77cd9c78f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3612:|DM6PR12MB3612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3612714933EBF28D61C1C59F99580@DM6PR12MB3612.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(199004)(189003)(2616005)(66946007)(36756003)(118296001)(66556008)(66476007)(86362001)(44832011)(316002)(54906003)(6506007)(52116002)(6486002)(4326008)(26005)(186003)(6512007)(2906002)(8676002)(81166006)(81156014)(2870700001)(305945005)(8936002)(6916009)(478600001)(6666004)(5660300002)(4744005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3612;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1lObgg68o1ksA6fmQV8VfmTlPO5bBfEskghTT5rABZcv9DoFwlAKToK1tagAaepL3N4MKmuGWrdSt/yGM04J4v9IBC8kyzUS93Acs6j0t2k0uc1IeNdf2KINBhzMAPe7mayHV4Sk69G4A0lCwJd3UtvhGdE7v/RDUwbU7ewfhUt78x7TuFsI178L9oE7Yfpvd2xJbANiqmA+L0QcdK8JlK6LgtQej5lrCKFtXDQ1TOu005GkXMZfQLNpQjcV6eiIb7l4GXa2BNmxBdRfWPy2KD3QXFQnbltQefQTdfRyK7NZ3hXToQPiBOcG4FjVsS2Q9fEtEJb2UFhxxgYgMzj7u/2ZOcXp91i95r2IpRlHfPJfy8m2u7QoVSssfwcJ2XdUBRAEub1NvWlRkKEFHhxw1QWPfflBrua0l0i54VT5ZuXL0C6RjT3Lo3qY5ApUo2/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28c2683-e727-4c1a-8acc-08d77cd9c78f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 18:58:29.7213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEU/sfNN1lPoQW9/06WtRdXvY1eXPKR22CTLJLOIv3hrXENXiVrCO7b2J0VWhkbg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3612
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMXY4pOBYhfpIzVuDFbxumAzbrjD3nmSmvGeXcxL+dY=;
 b=BDi2eAQygk1CZAvtw++VwyXje7dfEL2MwRGWZ4RcPs2lvlG5gkfNgvjjxtnsm3bsGvYL4EHM5fnvpEwlv0zNdDvwEN7gg+LUe7AYIBRkkU9Ex4MKsJQx1eJzaYfENiEizppoIBfpmstgO9cnax3VYSK/5A1pVb5tQ+RxxeW41Js=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBwYXRjaCBmaXhlczoKLVd1bnVzZWQtZnVuY3Rpb24KCnYyOiBBbHdheXMgZW5hYmxlIGFt
ZGdwdV9yYXNfdGVzdCgpLgoKU2lnbmVkLW9mZi1ieTogTHViZW4gVHVpa292IDxsdWJlbi50dWlr
b3ZAYW1kLmNvbT4KLS0tCiB0ZXN0cy9hbWRncHUvcmFzX3Rlc3RzLmMgfCAyIC0tCiAxIGZpbGUg
Y2hhbmdlZCwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9hbWRncHUvcmFzX3Rl
c3RzLmMgYi90ZXN0cy9hbWRncHUvcmFzX3Rlc3RzLmMKaW5kZXggZDcxNGJlNzMuLmY3NDUxNjZi
IDEwMDY0NAotLS0gYS90ZXN0cy9hbWRncHUvcmFzX3Rlc3RzLmMKKysrIGIvdGVzdHMvYW1kZ3B1
L3Jhc190ZXN0cy5jCkBAIC04ODEsOSArODgxLDcgQEAgQ1VfVGVzdEluZm8gcmFzX3Rlc3RzW10g
PSB7CiAJeyAicmFzIHF1ZXJ5IHRlc3QiLAlhbWRncHVfcmFzX3F1ZXJ5X3Rlc3QgfSwKIAl7ICJy
YXMgaW5qZWN0IHRlc3QiLAlhbWRncHVfcmFzX2luamVjdF90ZXN0IH0sCiAJeyAicmFzIGRpc2Fi
bGUgdGVzdCIsCWFtZGdwdV9yYXNfZGlzYWJsZV90ZXN0IH0sCi0jaWYgMAogCXsgInJhcyBlbmFi
bGUgdGVzdCIsCWFtZGdwdV9yYXNfZW5hYmxlX3Rlc3QgfSwKLSNlbmRpZgogCUNVX1RFU1RfSU5G
T19OVUxMLAogfTsKIAotLSAKMi4yNC4wLjM5MC5nMDgzMzc4Y2MzNQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
