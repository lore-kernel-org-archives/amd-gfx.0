Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D32C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC0F20848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC0F20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 627506E2DF;
	Mon,  2 Dec 2019 17:36:03 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800051.outbound.protection.outlook.com [40.107.80.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D59FC6E2E9
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZWbELlojgy2FjSi2yhOfiFa/by7qqaPI9jV1mdsah8pov1aYuqHmPDYAtu0fSEZ3SOa5ggBxKKec9Lfwa90XD4xRGayNTWRwhejmBxfbvENjaQ5cXX8sGQYPz4tVt8nArgI5nzR4/hpq2VYOXNOYC8yxVNr1/wun2T3ayb9jF5TqKM8QuaiLqibDRDFP4CqCtiJTTbhNalI0yPLNAlC/P7GC64sskDY8fTiRadupdTSBWKR56nBZjwEtyYjPNn6LXZl9AyETuh3ZMG+qb7jPi2yZcplocj3+Ud90lFJu0vUsoKXJpIXmjfi7r2Fk9mm79RXXeZlVlMpW3EK5qOSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL1MBG5/W1fOxeKzjU0bY7XOyWr6T1P26rzEYjfVyvw=;
 b=TYF84o+Se4YkIn3Qkp54LlDYvYmlCH0TdlJ+X+7lxBnxr5PEpRfFx3nfGYEcF8krYLBP3rmuO2G62sEojyeqG663GhIl7qVenZ5XOFgQl2Ou9ibGKFqaadRgbnL8J4t4YGAWmaasdJdvjfaraMPBCTe1gv/opI1laQQiiBqxXCAKFo8qpLO1/qojJRd//V+PFmn4oru6Ul1dNM4Q8IR5SPu/t4+qnQbFFuHcVlrXrXREjq5Wkxtjf1a6xU682gs/eC+y6EH1z9rlf87tNMf4HACkaEgj4gENyM831/eczZsdwuDUeTdRu+9kbH0wSMLfWqlI0RIEXzLxwOhUbrrSPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2610.namprd12.prod.outlook.com (20.176.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:58 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:58 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 51/51] drm/amd/display: Extend DMCUB offload testing into
 dcn20/21
Date: Mon,  2 Dec 2019 12:34:05 -0500
Message-Id: <20191202173405.31582-52-sunpeng.li@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0d627820-067d-457a-5df7-08d7774e0873
X-MS-TrafficTypeDiagnostic: BN7PR12MB2610:|BN7PR12MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB26105FA1B6360CF67B27C8E382430@BN7PR12MB2610.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(76176011)(6666004)(51416003)(52116002)(6512007)(66476007)(66556008)(316002)(50226002)(5660300002)(6916009)(81166006)(26005)(2616005)(99286004)(386003)(6506007)(1076003)(8936002)(11346002)(305945005)(446003)(81156014)(186003)(9686003)(6436002)(4326008)(8676002)(6486002)(7736002)(66946007)(54906003)(14444005)(48376002)(50466002)(86362001)(6116002)(2351001)(3846002)(2906002)(25786009)(36756003)(66066001)(2870700001)(2361001)(14454004)(478600001)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2610;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjV3fQ7KECLtMO3hoRGMzqQojA3FEPj52HJXg/iS8LSPhN98CdKNlfxXwCVrUWamleiYfqRTZdZZvAKM2AWKDGTgAEddw0Pk5VHsYFYw9O3K//okZT3XLjze0Hh0Ov14d+cTetC+IHFzApPais0bS5sdzEJFgdADL1OmK4gJAmqmdHNEBali4BqIrWXHT+SBYPO4XzKQ0mDjGP1huNbgz8k3MzvGP5m8R1dsTj1XiFLc3N4Z0RDTNvmcf3kEYKEA4SQI5mb5SFPLULpGsjzx9NiXy/0M/TUNkUrFQi/JBxxKp1E7PPSwUkbNCF4wgSFBm1Qn735FBe3sJAZlvcITpyjVIESBffTOEIY+KWeh2svDLq5T/bjqt77BZzqYdI9HvH0CWYNRSj1FO3q4542BpSj5Qvpv2s5YcRAKOwenaFY/rr+kKm8wGvdcMzMrhHK1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d627820-067d-457a-5df7-08d7774e0873
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:33.1446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7z+BvrUTblsaQw5p4nurp5/EUZwkpEcHSpMXd8zyaj1txM+0B7dHLxXm3LK4eYpM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2610
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL1MBG5/W1fOxeKzjU0bY7XOyWr6T1P26rzEYjfVyvw=;
 b=mIaB7UbXHF7m3H4YTc4zLD4oJ+sA9eIpOjh1do9N/+pLiN9qhkGPtW9Qk8OJfv2GszfJazsr+Y0uy8F4p//poD9bwS/rDBTHLmLDagtFVZ/A8XZiAv3ezCNOKzkJNGXEqsZl8IYnkHgxqAYVWWfUJo1OqRaPtKQZVP6bEWcrVYs=
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
Cc: Leo Li <sunpeng.li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 rodrigo.siqueira@amd.com, harry.wentland@amd.com, bhawanpreet.lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgoK
W1doeV0KVG8gcXVpY2tseSB2YWxpZGF0ZSB3aGV0aGVyIERNQ1VCIGlzIHJ1bm5pbmcgYW5kIGFj
Y2VwdGluZyBjb21tYW5kcyBmb3IKb2ZmbG9hZCB0ZXN0aW5nIHdlIHdhbnQgdG8gaW50ZXJjZXB0
IGEgY29tbW9uIHNlcXVlbmNlIGFzIHBhcnQgb2YKbW9kZXNldCBwcm9ncmFtbWluZy4KCltIb3dd
Ck9URyBlbmFibGUgd2lsbCBjYXVzZSB0aGUgbW9zdCBpbXBhY3QgaW4gdGVybXMgb2YgZ29sZGVu
IHJlZ2lzdGVyCmNoYW5nZXMgYW5kIGl0J3MgYSBzaW5nbGUgcmVnaXN0ZXIgd3JpdGUuCgpUaGlz
IGFwcHJvYWNoIHdhcyBwcmV2aW91c2x5IGRvbmUgaW4gZGNuMTAgY29kZSB3aGVuIGl0IHdhcyBz
aGFyZWQgd2l0aApkY24yMCBidXQgaXQgd2Fzbid0IHBvcnRlZCBvdmVyIHRvIHRoZSBkY24yMCBj
b2RlLgoKUG9ydCBvdmVyIHN0YXJ0LCBleGVjdXRlIGFuZCB3YWl0IHNlcXVlbmNlIGludG8gZGNu
MjBfb3B0Yy4KClNpZ25lZC1vZmYtYnk6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFzLmth
emxhdXNrYXNAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IFRvbnkgQ2hlbmcgPFRvbnkuQ2hlbmdAYW1k
LmNvbT4KQWNrZWQtYnk6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9vcHRjLmMgfCA1ICsrKysrCiAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX29wdGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY24yMC9kY24yMF9vcHRjLmMKaW5kZXggZjU4NTRhNWQyYjc2Li42NzNjODNl
MmFmZDQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9k
Y24yMF9vcHRjLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2Rj
bjIwX29wdGMuYwpAQCAtNTksMTEgKzU5LDE2IEBAIGJvb2wgb3B0YzJfZW5hYmxlX2NydGMoc3Ry
dWN0IHRpbWluZ19nZW5lcmF0b3IgKm9wdGMpCiAJUkVHX1VQREFURShDT05UUk9MLAogCQkJVlRH
MF9FTkFCTEUsIDEpOwogCisJUkVHX1NFUV9TVEFSVCgpOworCiAJLyogRW5hYmxlIENSVEMgKi8K
IAlSRUdfVVBEQVRFXzIoT1RHX0NPTlRST0wsCiAJCQlPVEdfRElTQUJMRV9QT0lOVF9DTlRMLCAz
LAogCQkJT1RHX01BU1RFUl9FTiwgMSk7CiAKKwlSRUdfU0VRX1NVQk1JVCgpOworCVJFR19TRVFf
V0FJVF9ET05FKCk7CisKIAlyZXR1cm4gdHJ1ZTsKIH0KIAotLSAKMi4yNC4wCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
