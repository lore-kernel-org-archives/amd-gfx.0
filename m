Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86582C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 07:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE13206E1
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 07:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE13206E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF4966E060;
	Thu, 14 Nov 2019 07:34:17 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770052.outbound.protection.outlook.com [40.107.77.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3AF36E060
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 07:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnnvsePy0miouKy6895NwFtpjsKvj/Jr4KPEd3kHdazjnt8lhpzixqFZgwloqwCD7v+MnLdDTVwCpFjPDm0WMbmO1z2FN5dZmo+ZDuR/hoMkyCvOAtC2E3jznZHOWzn/IckY3coUoQ0lJBeZBqs4MDFjtsaPETEu6tzLMJoUq9sJWnMVfqJtIHcWB1A1+SW9/0IWH+6GkPs5F4PF0LDVKVacAv96K0bxxB4YokW8MRuY8BblSWkgd9ign+mfMda8u2k6Yk/d5Zu+ePQvAKLv1M4syzHWE/wWvMQ4eXoatcEOA+/7uB8KG9PSl0hG97mhtA3Gobc03fEgnpDu1fm9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DfJgh2az7FcXrRNIj8YbUWdbfRTMi3E0La3BTprRLU=;
 b=BCIJq6RgBxsztaFsePWsIpfdYsG24EeluRkuMHzVcgX5uWzlD5NGPD5v9a0x8HFbVgZTFGBVB+CwNMoEOexcEBrZ0SmqT1Xh7kBCIaMq2JjqgDSQ5OeXumq82jGIwm01HGCQM5rBVVkPoHRO9xtUHMK2LTOuPcpEg4v0N2AyX4/xJ0ouCBEAL6xTtokVdOtMd46pz/h3In8JIN0jOZrpcutkaMc7mdssybEPH5+YbWSW3dit/A5ksmbwynkn002KrRNQlsK7k7I3sGGxsZQFOR2/sngxFufLJGszwrbAbrIaJgr9kLkhaYmpdD7xk4k5vMZvXhyw34ecSaVx+zauxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3710.namprd12.prod.outlook.com (10.255.239.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Thu, 14 Nov 2019 07:34:14 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 07:34:14 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: issue no PPSMC_MSG_GetCurrPkgPwr on
 unsupported ASICs
Date: Thu, 14 Nov 2019 15:33:47 +0800
Message-Id: <20191114073347.12034-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK2PR03CA0046.apcprd03.prod.outlook.com
 (2603:1096:202:17::16) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8f05667-f5d6-4070-1818-08d768d50c5b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3710EB1879EC2D504C96E485E4710@MN2PR12MB3710.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-Forefront-PRVS: 02213C82F8
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(3923003)(4326008)(81166006)(36756003)(2361001)(51416003)(8936002)(6512007)(52116002)(486006)(44832011)(305945005)(7736002)(81156014)(8676002)(50226002)(478600001)(476003)(6486002)(2616005)(99286004)(6666004)(6116002)(6436002)(50466002)(2906002)(3846002)(66066001)(26005)(2870700001)(6916009)(386003)(25786009)(186003)(5660300002)(86362001)(48376002)(6506007)(1076003)(316002)(66946007)(66556008)(2351001)(66476007)(14454004)(47776003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3710;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7BX5ANyWQAWxFbwnXqjvzcxeQmX0gcy7ztB0CtPjgEcO/M6hG89l5DpR67yDX8IRD78785cVZzqs6xhuWBAoxqoa3s7cnoIOH8RdF7qD7tCS0+Eufcgie97EM+CIzarXfcuRw8l30B20CS+b26WDhyqO14+ymCM+ArR1OPqB4tJu6CoCoUXWbY7LqTSLLlnWmug2M8sRedhvDDsT8FMluD6vdpKuuLIojYhQyyHXMw6BA9ZMCVI9zv53bKfI9KhwBTzGEob1AcCxbzYd0/802UYFmhBg/7zksEcl3fTfv76ZAayPo/kXuXKFKytnfy1LEw6GSo/MQmQQEJfp1NNCiKaOn8nPafmEEyKTThiuFjS4nub8qKBBwP7reDKbvgmj/eciqYjFT304mcLhNPPz2f/yKFuIxXT7OvLk/goOQlS2RDqb+U9nyZkwDV3MIxk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f05667-f5d6-4070-1818-08d768d50c5b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 07:34:14.3942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzTbejEIlmTHseNxJd5TY6Mpiwlej7iurIt/+CVh1TpvZhaUKYCfHy8htps2XHFd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3710
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DfJgh2az7FcXrRNIj8YbUWdbfRTMi3E0La3BTprRLU=;
 b=qhdTJkJGcnzU6hQqSOLe+8eyiqN7hWhbG+g2CvjNDraee2nhTXB+0rHKSFXCxa9CHcXlPxYOvdBLgoFCvOh/muPsGGtIOWYtG/dKNTaBOMINtzNacw4pA8tc7yti8ztkYxf8oVjwDj4bNfPKZ8/FKukkzeHlg6y1MJkeacNomXM=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114073347.FgFaTTQriFxlKr1Jws7ikQtrAQeaXU20TzdA1pkvjbY@z>

T3RoZXJ3aXNlLCB0aGUgZXJyb3IgbWVzc2FnZSBwcm9tcHRlZCB3aWxsIGNvbmZ1c2UgdXNlci4K
CkNoYW5nZS1JZDogSTQ0YjlmODcwYTg2NjM3MTRkNzE1YTFkNWJmMmFhMjRhYmU3NWJiOGUKU2ln
bmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KLS0tCiAuLi4vZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYyAgfCAyMyArKysrKysrKysrKysrKyst
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdy
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdyLmMKaW5k
ZXggZDNjM2IzNTEyYTE2Li41YzZiNzFiMzU2ZTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdyLmMKQEAgLTM0NzYsMTggKzM0NzYsMzEgQEAg
c3RhdGljIGludCBzbXU3X2dldF9wcF90YWJsZV9lbnRyeShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdy
LAogCiBzdGF0aWMgaW50IHNtdTdfZ2V0X2dwdV9wb3dlcihzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdy
LCB1MzIgKnF1ZXJ5KQogeworCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gaHdtZ3ItPmFk
ZXY7CiAJaW50IGk7CiAJdTMyIHRtcCA9IDA7CiAKIAlpZiAoIXF1ZXJ5KQogCQlyZXR1cm4gLUVJ
TlZBTDsKIAotCXNtdW1fc2VuZF9tc2dfdG9fc21jX3dpdGhfcGFyYW1ldGVyKGh3bWdyLCBQUFNN
Q19NU0dfR2V0Q3VyclBrZ1B3ciwgMCk7Ci0JdG1wID0gY2dzX3JlYWRfcmVnaXN0ZXIoaHdtZ3It
PmRldmljZSwgbW1TTUNfTVNHX0FSR18wKTsKLQkqcXVlcnkgPSB0bXA7CisJLyoKKwkgKiBQUFNN
Q19NU0dfR2V0Q3VyclBrZ1B3ciBpcyBub3Qgc3VwcG9ydGVkIG9uOgorCSAqICAtIEhhd2FpaQor
CSAqICAtIEJvbmFpcmUKKwkgKiAgLSBGaWppCisJICogIC0gVG9uZ2EKKwkgKi8KKwlpZiAoKGFk
ZXYtPmFzaWNfdHlwZSAhPSBDSElQX0hBV0FJSSkgJiYKKwkgICAgKGFkZXYtPmFzaWNfdHlwZSAh
PSBDSElQX0JPTkFJUkUpICYmCisJICAgIChhZGV2LT5hc2ljX3R5cGUgIT0gQ0hJUF9GSUpJKSAm
JgorCSAgICAoYWRldi0+YXNpY190eXBlICE9IENISVBfVE9OR0EpKSB7CisJCXNtdW1fc2VuZF9t
c2dfdG9fc21jX3dpdGhfcGFyYW1ldGVyKGh3bWdyLCBQUFNNQ19NU0dfR2V0Q3VyclBrZ1B3ciwg
MCk7CisJCXRtcCA9IGNnc19yZWFkX3JlZ2lzdGVyKGh3bWdyLT5kZXZpY2UsIG1tU01DX01TR19B
UkdfMCk7CisJCSpxdWVyeSA9IHRtcDsKIAotCWlmICh0bXAgIT0gMCkKLQkJcmV0dXJuIDA7CisJ
CWlmICh0bXAgIT0gMCkKKwkJCXJldHVybiAwOworCX0KIAogCXNtdW1fc2VuZF9tc2dfdG9fc21j
KGh3bWdyLCBQUFNNQ19NU0dfUG1TdGF0dXNMb2dTdGFydCk7CiAJY2dzX3dyaXRlX2luZF9yZWdp
c3Rlcihod21nci0+ZGV2aWNlLCBDR1NfSU5EX1JFR19fU01DLAotLSAKMi4yNC4wCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
