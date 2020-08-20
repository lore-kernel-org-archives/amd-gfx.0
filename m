Return-Path: <SRS0=nMzJ=B6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015E9C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 10:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E60A20639
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2020 10:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jVfTwMMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E60A20639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B4A36E932;
	Thu, 20 Aug 2020 10:38:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87B886E932
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2020 10:38:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHtEtZajcGI36Snty29ybxWB5760Tx0mzGjlwDUCkPVFDucz0SCAXH3L7Nq8ZnD+XDZZGWEsbRN4thGqjG6PC2bIOPwiiQ9WeLKB44YDhTcnAJ2o7GgqAekFyIEzj0IewDhVpvUaOTz4SvLdGJe3Clnk5nQCrSRGKNdbmtYE06QK42EDS2H2l4lbIv/1Ho5UaCGI7V3ixD+gMYqvksZmeyrc8LaImIXLyZIhu10zaw8Zak7nXePcBFIhgN0/PxWMGfX90nwcsO2GrXYfubh7UCGjz0OzQAv5bzlVaJ57ptyRhKldRmAPNLxJdDwg+AJBWi5IBLh4KaIFL0HXh+ZSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laRfyR4ulhWZP08NrT2As4vhbc/nMJVfqdYNJ7d56Us=;
 b=nfrJqOKKOWajsghm0LjG4DT63hVaRTj4hFqE88NBHf7XsEDys6z0NEn1m6DR5poyfmQwapVByK1An/2A3U0JcwLWGeGCE074QolKoNIH+YARmZQesplbabXoOsUnkr8YnhhdJU5ISRnjbTc2K4WBvbw076PGPcBVZut90fkZwvchwCPHd8ZeTENZIWjTNJ14XLfr1wyxMl8BNaBnIJCEUH6DhMp8S3QtDMUZH8dmhTMMztnupG+9IwZxVjDOBuAfUMrGbaF1ND1mynmJXT8wwxfzG2olBS91XSGEAjxRPaX9AmpomwdyO/Ef0jKGRlLghuCYIylnU5SWi53hGbtCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laRfyR4ulhWZP08NrT2As4vhbc/nMJVfqdYNJ7d56Us=;
 b=jVfTwMMKBTDf7FFw3RJ+vnRZ8pobmOwG+NgrGseGfgVWcwLw5mQylgASwNBByAGBJCgy4pn4528cNvGVK2a00D7YtJSlDxgXZI+hyHNsUTZWLNPzIU1Bwy5wRl6SCoiMOS9O9DMl0x11d1BLbfHIJGH7LFYiVUp3j/9C0U0zFlg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BY5PR12MB3971.namprd12.prod.outlook.com (2603:10b6:a03:1a5::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 10:38:47 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4%5]) with mapi id 15.20.3305.025; Thu, 20 Aug 2020
 10:38:47 +0000
From: Shashank Sharma <shashank.sharma@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v6] drm/amdgpu: add new trace event for page table update
Date: Thu, 20 Aug 2020 16:08:23 +0530
Message-Id: <20200820103823.3599-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: MAXPR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::33) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MAXPR01CA0091.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 10:38:46 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.110.102]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0abf860-68af-4c53-8aec-08d844f5382e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3971:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB397191FFFA96F57B968E9B10F25A0@BY5PR12MB3971.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VOug6+13P9u3Cih7DZ2ifs6cmjWN3SfQclIig44rAoohxIt3U6nIZEi+slq1UfpxL6kep+y7q6HF8xxjmYyldniJUs7+zLTsIbAhD/6+6RKmTl3ZLoujKpgYheGfj8a+CI8HmtW6p/xwscns66egt9GdUAj+Ea/AQGE6GM/L5ovo0mrYa5Vl8cokb++D/GA5L21GCcrMx9gQUGp9WLhpiHRLttmqtoLS+nlejrg/xbGG+wUQKaxn1mpC4W4UxffYEOmi4et1P8h5dDIac92IZoQwRrQMne8VqWR9nf31ZCe91bYBGFI19DN+73c21UVM3HMjesUTQ7Ue1jAglTRfV0HhUV2mfDjjagNSfPhndCiWQ2KHsXlhyAm8lvfdE9A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(8676002)(66556008)(44832011)(66476007)(2616005)(83380400001)(6916009)(956004)(66946007)(6666004)(478600001)(66574015)(6486002)(8936002)(4326008)(110011004)(86362001)(15650500001)(52116002)(55236004)(186003)(26005)(2906002)(36756003)(16576012)(1076003)(5660300002)(316002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SBCWaZgvsc/jrFy+jbJPGIwtYFICAiDT7pVlxvoPKJeBH39GN7kFL8zMvWT6WrmIQn6aLhkWVACOEdqpBlmlXcIBahPTid/1XjhwUyfy5yySy5WySAZ7sSwPvxz7/fWAmtwFKuK6IA77DaAEdQWOxmYLUPYZh2XLfkYTd14G6AEMdhxsgyOZ4Iun+XdRdghOduDGZisKatOfPBh3t16ie8dbLhVWXNAv0qFv/PSJhWBkjyM7hOd/VpUF9EyqNCIEkuRXBveg5B3iavV1U+o0ySfT/dp0oLkOIBudb4er1/C1T9kUBQFh5nmCHcNu9jFImekJXS30ls3jrRFt7bH4+XbKY8hYyeyEDHLPzP1gCVrRM+ztF7oQSRmQo+jw2NmbCDL2NkjDO2+xC9mme5Y5scpvy+yotU9qSGlqwU6014smxQxGtRzDSbO+b0osZ/z8Xop0Qc7lnCFtKbRmZ1tVvwQ2gET5f1Ld0JIvYoRyKw9wwLlVDnIyGE5VBx30i9jsxhDZtqJBcmBSgSatkUqsdUKWCuzpVM4iZ/aFyndwTAUG/F4c9shHEgENBRyt7DICHObhYKRqUDs2aLWEo6dnB7kQZejYNUBrdG8I17pvigLAl9ipexggBN8HUl/NT/pmZoH/EHMHKnlbQp8cUL+lEQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0abf860-68af-4c53-8aec-08d844f5382e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 10:38:47.7613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1jhrewHT9Vyc193Z0vSCPEeTqKxkYzXdzCwubYVf1vNxAVRGlK2fHTb+ufuFEPzOEp2TUij6hyDPo2TrbXJlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3971
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBwYXRjaCBhZGRzIGEgbmV3IHRyYWNlIGV2ZW50IHRvIHRyYWNrIHRoZSBQVEUgdXBkYXRl
CmV2ZW50cy4gVGhpcyBzcGVjaWZpYyBldmVudCB3aWxsIHByb3ZpZGUgaW5mb3JtYXRpb24gbGlr
ZToKLSBzdGFydCBhbmQgZW5kIG9mIHZpcnR1YWwgbWVtb3J5IG1hcHBpbmcKLSBIVyBlbmdpbmUg
ZmxhZ3MgZm9yIHRoZSBtYXAKLSBwaHlzaWNhbCBhZGRyZXNzIGZvciBtYXBwaW5nCgpUaGlzIHdp
bGwgYmUgcGFydGljdWxhcmx5IHVzZWZ1bCBmb3IgbWVtb3J5IHByb2ZpbGluZyB0b29scwoobGlr
ZSBSTVYpIHdoaWNoIGFyZSBtb25pdG9yaW5nIHRoZSBwYWdlIHRhYmxlIHVwZGF0ZSBldmVudHMu
CgpWMjogQWRkZWQgcGh5c2ljYWwgYWRkcmVzcyBsb29rdXAgbG9naWMgaW4gdHJhY2UgcG9pbnQK
VjM6IHN3aXRjaCB0byB1c2UgX19keW5hbWljX2FycmF5CiAgICBhZGRlZCBucHRlcyBpbnQgdGhl
IFRQcHJpbnQgYXJndW1lbnRzIGxpc3QKICAgIGFkZGVkIHBhZ2Ugc2l6ZSBpbiB0aGUgYXJnIGxp
c3QKVjQ6IEFkZHJlc3NlZCBDaHJpc3RpYW4ncyByZXZpZXcgY29tbWVudHMKICAgIGFkZCBzdGFy
dC9lbmQgaW5zdGVhZCBvZiBzZWcKICAgIHVzZSBpbmNyIGluc3RlYWQgb2YgcGFnZV9zeiB0byBi
ZSBhY2N1cmF0ZQpWNTogQWRkcmVzc2VkIENocmlzdGlhbidzIHJldmlldyBjb21tZW50czoKICAg
IGFkZCBwaWQgYW5kIHZtIGNvbnRleHQgaW5mb3JtYXRpb24gaW4gdGhlIGV2ZW50ClY2OiBSZS1z
ZXF1ZW5jZSB0aGUgdmFyaWFibGVzIChwdXQgcGlkIGFuZCBjdHhfaWQgZmlyc3QpCgpDYzogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IFNoYXNoYW5rIFNo
YXJtYSA8c2hhc2hhbmsuc2hhcm1hQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3RyYWNlLmggfCA0MyArKysrKysrKysrKysrKysrKysrKysrKwogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgICAgfCAxMSArKysrLS0KIDIgZmlsZXMg
Y2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCmluZGV4IDYzZTczNGExMjVmYi4uODJjMmU3MGE2
YTcxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2Uu
aAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaApAQCAtMzIx
LDYgKzMyMSw0OSBAQCBERUZJTkVfRVZFTlQoYW1kZ3B1X3ZtX21hcHBpbmcsIGFtZGdwdV92bV9i
b19jcywKIAkgICAgVFBfQVJHUyhtYXBwaW5nKQogKTsKIAorVFJBQ0VfRVZFTlQoYW1kZ3B1X3Zt
X3VwZGF0ZV9wdGVzLAorCSAgICBUUF9QUk9UTyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJh
bXMgKnAsCisJCSAgICAgdWludDY0X3Qgc3RhcnQsIHVpbnQ2NF90IGVuZCwKKwkJICAgICB1bnNp
Z25lZCBpbnQgbnB0ZXMsIHVpbnQ2NF90IGRzdCwKKwkJICAgICB1aW50NjRfdCBpbmNyLCB1aW50
NjRfdCBmbGFncywKKwkJICAgICBwaWRfdCBwaWQsIHVpbnQ2NF90IHZtX2N0eCksCisJVFBfQVJH
UyhwLCBzdGFydCwgZW5kLCBucHRlcywgZHN0LCBpbmNyLCBmbGFncywgcGlkLCB2bV9jdHgpLAor
CVRQX1NUUlVDVF9fZW50cnkoCisJCQkgX19maWVsZCh1NjQsIHN0YXJ0KQorCQkJIF9fZmllbGQo
dTY0LCBlbmQpCisJCQkgX19maWVsZCh1NjQsIGZsYWdzKQorCQkJIF9fZmllbGQodW5zaWduZWQg
aW50LCBucHRlcykKKwkJCSBfX2ZpZWxkKHU2NCwgaW5jcikKKwkJCSBfX2ZpZWxkKHBpZF90LCBw
aWQpCisJCQkgX19maWVsZCh1NjQsIHZtX2N0eCkKKwkJCSBfX2R5bmFtaWNfYXJyYXkodTY0LCBk
c3QsIG5wdGVzKQorCSksCisKKwlUUF9mYXN0X2Fzc2lnbigKKwkJCXVuc2lnbmVkIGludCBpOwor
CisJCQlfX2VudHJ5LT5zdGFydCA9IHN0YXJ0OworCQkJX19lbnRyeS0+ZW5kID0gZW5kOworCQkJ
X19lbnRyeS0+ZmxhZ3MgPSBmbGFnczsKKwkJCV9fZW50cnktPmluY3IgPSBpbmNyOworCQkJX19l
bnRyeS0+bnB0ZXMgPSBucHRlczsKKwkJCV9fZW50cnktPnBpZCA9IHBpZDsKKwkJCV9fZW50cnkt
PnZtX2N0eCA9IHZtX2N0eDsKKwkJCWZvciAoaSA9IDA7IGkgPCBucHRlczsgKytpKSB7CisJCQkJ
dTY0IGFkZHIgPSBwLT5wYWdlc19hZGRyID8gYW1kZ3B1X3ZtX21hcF9nYXJ0KAorCQkJCQlwLT5w
YWdlc19hZGRyLCBkc3QpIDogZHN0OworCisJCQkJKCh1NjQgKilfX2dldF9keW5hbWljX2FycmF5
KGRzdCkpW2ldID0gYWRkcjsKKwkJCQlkc3QgKz0gaW5jcjsKKwkJCX0KKwkpLAorCVRQX3ByaW50
aygicGlkOiV1IHZtX2N0eDoweCVsbHggc3RhcnQ6MHglMDEwbGx4IGVuZDoweCUwMTBsbHgsIgor
CQkgICIgZmxhZ3M6MHglbGx4LCBpbmNyOiVsbHUsIGRzdDpcbiVzIiwgX19lbnRyeS0+cGlkLAor
CQkgIF9fZW50cnktPnZtX2N0eCwgX19lbnRyeS0+c3RhcnQsIF9fZW50cnktPmVuZCwKKwkJICBf
X2VudHJ5LT5mbGFncywgX19lbnRyeS0+aW5jciwgIF9fcHJpbnRfYXJyYXkoCisJCSAgX19nZXRf
ZHluYW1pY19hcnJheShkc3QpLCBfX2VudHJ5LT5ucHRlcywgOCkpCispOworCiBUUkFDRV9FVkVO
VChhbWRncHVfdm1fc2V0X3B0ZXMsCiAJICAgIFRQX1BST1RPKHVpbnQ2NF90IHBlLCB1aW50NjRf
dCBhZGRyLCB1bnNpZ25lZCBjb3VudCwKIAkJICAgICB1aW50MzJfdCBpbmNyLCB1aW50NjRfdCBm
bGFncywgYm9vbCBkaXJlY3QpLApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwpp
bmRleCA4YmMyMjUzOTM5YmUuLjNkMjU3MzliNDE1OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMKQEAgLTE1MTEsMTkgKzE1MTEsMjYgQEAgc3RhdGljIGludCBhbWRncHVf
dm1fdXBkYXRlX3B0ZXMoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwYXJhbXMsCiAJ
CWVudHJ5X2VuZCA9IG1pbihlbnRyeV9lbmQsIGVuZCk7CiAKIAkJZG8geworCQkJc3RydWN0IGFt
ZGdwdV92bSAqdm0gPSBwYXJhbXMtPnZtOwogCQkJdWludDY0X3QgdXBkX2VuZCA9IG1pbihlbnRy
eV9lbmQsIGZyYWdfZW5kKTsKIAkJCXVuc2lnbmVkIG5wdGVzID0gKHVwZF9lbmQgLSBmcmFnX3N0
YXJ0KSA+PiBzaGlmdDsKKwkJCXVpbnQ2NF90IHVwZF9mbGFncyA9IGZsYWdzIHwgQU1ER1BVX1BU
RV9GUkFHKGZyYWcpOwogCiAJCQkvKiBUaGlzIGNhbiBoYXBwZW4gd2hlbiB3ZSBzZXQgaGlnaGVy
IGxldmVsIFBEcyB0bwogCQkJICogc2lsZW50IHRvIHN0b3AgZmF1bHQgZmxvb2RzLgogCQkJICov
CiAJCQlucHRlcyA9IG1heChucHRlcywgMXUpOworCisJCQl0cmFjZV9hbWRncHVfdm1fdXBkYXRl
X3B0ZXMocGFyYW1zLCBmcmFnX3N0YXJ0LCB1cGRfZW5kLAorCQkJCQkJICAgIG5wdGVzLCBkc3Qs
IGluY3IsIHVwZF9mbGFncywKKwkJCQkJCSAgICB2bS0+dGFza19pbmZvLnBpZCwKKwkJCQkJCSAg
ICB2bS0+aW1tZWRpYXRlLmZlbmNlX2NvbnRleHQpOwogCQkJYW1kZ3B1X3ZtX3VwZGF0ZV9mbGFn
cyhwYXJhbXMsIHB0LCBjdXJzb3IubGV2ZWwsCiAJCQkJCSAgICAgICBwZV9zdGFydCwgZHN0LCBu
cHRlcywgaW5jciwKLQkJCQkJICAgICAgIGZsYWdzIHwgQU1ER1BVX1BURV9GUkFHKGZyYWcpKTsK
KwkJCQkJICAgICAgIHVwZF9mbGFncyk7CiAKIAkJCXBlX3N0YXJ0ICs9IG5wdGVzICogODsKLQkJ
CWRzdCArPSAodWludDY0X3QpbnB0ZXMgKiBBTURHUFVfR1BVX1BBR0VfU0laRSA8PCBzaGlmdDsK
KwkJCWRzdCArPSBucHRlcyAqIGluY3I7CiAKIAkJCWZyYWdfc3RhcnQgPSB1cGRfZW5kOwogCQkJ
aWYgKGZyYWdfc3RhcnQgPj0gZnJhZ19lbmQpIHsKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
