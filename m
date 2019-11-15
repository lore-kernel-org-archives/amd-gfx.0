Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC29C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 22:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E2742072A
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 22:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2742072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AA046EB3E;
	Fri, 15 Nov 2019 22:38:47 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760089.outbound.protection.outlook.com [40.107.76.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 436486E0DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 22:38:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuNxkjjSFWxM/KmSLW/Q0/lYCwIuZf0q26KwUxhqCOjgxfSlaKZ2ZcLZx0LiQFrJFeZkat+P3xnNfO0O3qcQXDbDyW8fJs5bC/2gOK9tiP/BeguhMMTgxLBFQwD1T4GyhUe9MHuWC90KKskATfjOXe8tWQigqMEe9tNHS1RGM3cL+6TLdjaKgrqu2Be8yTrDDAQ5ki6tUS4HJ2XUSjKf9urhwZm5PW4lw4uhUX946gVMiieEZV2n71x/l6uvNLAqLYSPyrZ35lOrSnXaFgbFgaMbWYjHs+MdF+NFkLIVUVWkIcuFEaG5qb1tSzzUGHOOTWbYIz/lL1INVNWhGBqh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Si/lce7ex4+rAcLWa3+HheXhqKse+SZF/E4/cHYsGsY=;
 b=D8jgvU/BA4jXRgirhP46uO4gE90lR1/MFkV4LnUFVj5pVFounKVHQmioHdjZgEH5IDBnJImZg/O0PwSFO6akiIY70wTbK0W4UMQTMGsOChzZAosS/E9m5umsZCkiy/eCfKrjC41pm2baxeuHoNxcaBs9xLw9xs7/vwqiAJUulxuPECNh2SMl6JJpJh3zSC70BL1PQ0j/c5mmUR2joOugP/g/Si50Twcp12AVFMShhM4qr5ma4uekmMV/8sQEo0tCLR004vwM5bxFRywxdNVX0qq0BaQXBbsbfa2yRZDTCcOuie99/V1I5TZUl+DjwoifU/PI4r6mp1DhRiluMbYJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from CH2PR12MB4182.namprd12.prod.outlook.com (20.180.16.11) by
 CH2PR12MB3672.namprd12.prod.outlook.com (52.132.246.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 22:38:43 +0000
Received: from CH2PR12MB4182.namprd12.prod.outlook.com
 ([fe80::24d1:40a8:f811:6be1]) by CH2PR12MB4182.namprd12.prod.outlook.com
 ([fe80::24d1:40a8:f811:6be1%6]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 22:38:43 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amd/amdgpu: force to trigger a no-retry-fault after a
 retry-fault
Date: Fri, 15 Nov 2019 16:38:30 -0600
Message-Id: <20191115223830.29769-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: SN4PR0501CA0052.namprd05.prod.outlook.com
 (2603:10b6:803:41::29) To CH2PR12MB4182.namprd12.prod.outlook.com
 (2603:10b6:610:ae::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: db903b8f-6126-4c6d-1123-08d76a1c91aa
X-MS-TrafficTypeDiagnostic: CH2PR12MB3672:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB36720B24BD0C4E273919862EFD700@CH2PR12MB3672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(6916009)(47776003)(50466002)(8676002)(48376002)(6666004)(25786009)(66066001)(36756003)(486006)(186003)(66476007)(6116002)(66556008)(3846002)(2906002)(386003)(6506007)(66946007)(476003)(2616005)(26005)(44832011)(8936002)(2351001)(14444005)(7736002)(6486002)(81166006)(1076003)(478600001)(50226002)(51416003)(6436002)(5660300002)(81156014)(52116002)(6512007)(4326008)(2361001)(14454004)(316002)(305945005)(16586007)(86362001)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3672;
 H:CH2PR12MB4182.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2u5OyZfMxb2A9NV+t9MCe0brmAtw5qJjMzT2qAJuIrebzh6C1SDmBqGJR382JRl6GzfIECiZqs39NEIsutaUH/o7eVkCzhxmxKAjbEIRv52sV6yEVuWgdr0h5Xqqzb0EH7igYuc/q3woAuP6BbF538Gw8wK8rtizEtR9trYsXlTyvESgW8udct7ZpfeunbCRu2ViALaMe2b61ctLh8PM7rgyq8QWP+x2LXOzUys5ZoRHYMt/gHrmerOLBkUeYqn5YeK9YLy5ljIbDqcA4Zw+T5rS0uVCAhH59mcY2Ools+DXVy5PtKmhtlBQqadvnJTWCE1/ddQLxA/edGdhJidMa4Oa6AiWCPEE1KuJL93pRatv6BO117wonm6EF/XfKXIi6r2S1oRHSRBEebalmgdr5Mal1cR6kotDiAx/4nIhaKSUtYVc9AvkQ93Je3oL0Ju
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db903b8f-6126-4c6d-1123-08d76a1c91aa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 22:38:43.3616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6Soeh892qloxEJZoEANrQukxm5g8sgHnU2SnPbn9HjkswSQ483Y+c2fBPKc/BVqj0mjP68vKPCXeN4vVINEKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3672
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Si/lce7ex4+rAcLWa3+HheXhqKse+SZF/E4/cHYsGsY=;
 b=pfASNF5atdmw10Vxqe1bCwhuFFgyO/dmkMlKYjse7Zw2+w/O9f8kZEMrl/a1JjgVU6ooQEn/EvWZBrNZDz9vsCjyjGjU+zSyPyyKivtwXLSO3jh3P1j6XIYPFII8DjUKi/xMApt2m0voYEacaaygYepUhBORFHz4EhcGXvtHn0A=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115223830.CoE9UaDcJ7oTi6XrLTeUKs4ED_pvYbBYbpqImUyejiI@z>

QWZ0ZXIgYSByZXRyeS1mYXVsdCBoYXBwZW5zLCB0aGUgZmF1bHQgaGFuZGxlciB3aWxsIG1vZGlm
eSB0aGUgVVRDTDIgdG8Kc2V0IFBURSBiaXRzIHRvIGZvcmNlIGEgbm8tcmV0cnktZmF1bHQuIFRo
aXMgd2lsbCBjYXVzZSB0aGUgd2F2ZSB0bwplbnRlciB0aGUgdHJhcCBoYW5kbGVyLgoKQ2hhbmdl
LUlkOiBJMTc3MTAyODkxZjcxNTA2OGYxNTYwNTk1N2ZmMjNiMGNhYjg2MjYwMwpTaWduZWQtb2Zm
LWJ5OiBBbGV4IFNpZXJyYSA8YWxleC5zaWVycmFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDE1ICsrKysrKystLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jCmluZGV4IDNjMGJkNjQ3MmE0Ni4uOWFkNzM0NWQzMTVkIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwpAQCAtMzE2Nyw3ICszMTY3LDggQEAg
Ym9vbCBhbWRncHVfdm1faGFuZGxlX2ZhdWx0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1
bnNpZ25lZCBpbnQgcGFzaWQsCiAJCQkgICAgdWludDY0X3QgYWRkcikKIHsKIAlzdHJ1Y3QgYW1k
Z3B1X2JvICpyb290OwotCXVpbnQ2NF90IHZhbHVlLCBmbGFnczsKKwl1aW50NjRfdCB2YWx1ZSA9
IDA7CisJdWludDY0X3QgZmxhZ3M7CiAJc3RydWN0IGFtZGdwdV92bSAqdm07CiAJbG9uZyByOwog
CkBAIC0zMTk2LDE3ICszMTk3LDE1IEBAIGJvb2wgYW1kZ3B1X3ZtX2hhbmRsZV9mYXVsdChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgaW50IHBhc2lkLAogCQlnb3RvIGVycm9y
X3VubG9jazsKIAogCWFkZHIgLz0gQU1ER1BVX0dQVV9QQUdFX1NJWkU7Ci0JZmxhZ3MgPSBBTURH
UFVfUFRFX1ZBTElEIHwgQU1ER1BVX1BURV9TTk9PUEVEIHwKLQkJQU1ER1BVX1BURV9TWVNURU07
CiAKIAlpZiAoYW1kZ3B1X3ZtX2ZhdWx0X3N0b3AgPT0gQU1ER1BVX1ZNX0ZBVUxUX1NUT1BfTkVW
RVIpIHsKLQkJLyogUmVkaXJlY3QgdGhlIGFjY2VzcyB0byB0aGUgZHVtbXkgcGFnZSAqLwotCQl2
YWx1ZSA9IGFkZXYtPmR1bW15X3BhZ2VfYWRkcjsKLQkJZmxhZ3MgfD0gQU1ER1BVX1BURV9FWEVD
VVRBQkxFIHwgQU1ER1BVX1BURV9SRUFEQUJMRSB8Ci0JCQlBTURHUFVfUFRFX1dSSVRFQUJMRTsK
KwkJLyogU2V0dGluZyBQVEUgZmxhZ3MgdG8gdHJpZ2dlciBhIG5vLXJldHJ5LWZhdWx0ICAqLwor
CQlmbGFncyA9IEFNREdQVV9QVEVfRVhFQ1VUQUJMRSB8IEFNREdQVV9QREVfUFRFIHwKKwkJCUFN
REdQVV9QVEVfVEY7CiAJfSBlbHNlIHsKIAkJLyogTGV0IHRoZSBodyByZXRyeSBzaWxlbnRseSBv
biB0aGUgUFRFICovCi0JCXZhbHVlID0gMDsKKwkJZmxhZ3MgPSBBTURHUFVfUFRFX1ZBTElEIHwg
QU1ER1BVX1BURV9TTk9PUEVEIHwKKwkJCUFNREdQVV9QVEVfU1lTVEVNOwogCX0KIAogCXIgPSBh
bWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoYWRldiwgdm0sIHRydWUsIE5VTEwsIGFkZHIsIGFk
ZHIgKyAxLAotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
