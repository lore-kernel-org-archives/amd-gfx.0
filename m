Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F5BC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 04:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5124A206C3
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 04:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0bFayVmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5124A206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D216E89D;
	Wed, 12 Aug 2020 04:34:08 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750088.outbound.protection.outlook.com [40.107.75.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B826E89E
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 04:34:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXg82Fo8+5Ddszl+dFawWmz9p3KV8H2fX5HYyiORz4DMwpQvuKQKjuP7qvqYQoBKIqAtPTRX/6evfuGFoyx5xrcZCruDlB88zUwpOKF8MSORvAS6Scf+NkN2KK3T2+XOM+vs8ejtA30SDW76GoS9uf2XbK7kQ2Cry/vg7R3HmAVfY7QCHE+Z9X6ZPoqFNMcTcGR46Fmfcv8bsZ09qeKz30muXcvWdlI8JPYO3YE9IYBnRol2Fw59VCHrSuLe+aMFjT1YmkxLqBDXRrwdpn8VsCUYfpY+QtJTtyzWzS8pC5We1BLXPKGD/u+Rt0ww4MivvjV58HT0F4E1Ekb8aLI6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5u8yODamBsr2uA8lLVZUWihMNz3FdzRsXNE1AfyUHR8=;
 b=gzA8j1QFYOZkffq1EDbxgqv54kL6j9dA8yWca4lHHTkx+QJvBCGp1+GAXNtG493vWi+w9TINFIxn/lqT35tTdnoI0/mQFq445fCJeliYWWRUGwGdI4z4Nd+ENvksCD2VMFdYdQXiMjrWn2mhu+It1gnPkcNhiwpZy001L0TlG6BrEao0wMDd3nqVbC+YKE3uCjsb0mhuE2gxrAqm+LVKBrlhVb8whB/7TCflnoXyBoD8Jguj+2ey9A+XAAjw3ERlFUBA9yBkpISseYDFTUqvDfJz3TTu8Ni+Ve1Nb94/dN9ce84QMxVRPKFjTRkSUVroTyMz2CPK6CGnb4OWV3PYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5u8yODamBsr2uA8lLVZUWihMNz3FdzRsXNE1AfyUHR8=;
 b=0bFayVmChlB/aZXZOOD272c/IgKzQEvB04gIaLQrUafLuqJnvpX8wvR1GojvF4bZ2MQH0gnJcIGGU4knoSxmRaG1BR3Q0YYgdWrtNRvfB+L8hjBcLOAYdKJyrvnChGdjZzK7t9jEMRr2pZhUBCXQMmb1pE7j1FwZa4drQkZenLM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BY5PR12MB3794.namprd12.prod.outlook.com (2603:10b6:a03:1aa::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Wed, 12 Aug
 2020 04:34:01 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::1852:d129:e9ca:ebd4%5]) with mapi id 15.20.3261.025; Wed, 12 Aug 2020
 04:34:01 +0000
From: Shashank Sharma <shashank.sharma@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3] drm/amdgpu: add new trace event for page table update v3
Date: Wed, 12 Aug 2020 10:03:36 +0530
Message-Id: <20200812043336.127057-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::11) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (49.207.207.80) by
 MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Wed, 12 Aug 2020 04:33:59 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [49.207.207.80]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 91007ef9-0f06-4c4c-e112-08d83e78ef44
X-MS-TrafficTypeDiagnostic: BY5PR12MB3794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB37946415292382B33B08DE30F2420@BY5PR12MB3794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzPFVmdfCbmNKH/u3qTM0+pVygOQY3wcN3aqLSrIOTuKPF1XheKuLtc/snZfYSaKJP/fm+HpRz0DsQxucc1zfkfcxWbIotii9BTY5l0y0xnC6uGtOwJxqF1xQcyiW5UEst/3goQUTqH7z5TTs5x4sEohkrs3vyYyx7BLe10yANr+tBLYnAVFXY6VywtKAtKXGgjr2S/SyLKUYGvKlkCnjwlJVqWER3XwZ9+ObRJO1WzeYr8RhbtIJ26mcknYnQIrxnw2pVhpqIKJNN0SXEH0P9KT/+B+xw8eA9E+PF39UiE8zLWFL1L/BdNBLK1s+SIUdU/0vidZl8ImRX/zStWyAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(6506007)(6666004)(1006002)(478600001)(26005)(36756003)(316002)(16526019)(186003)(55236004)(1076003)(54906003)(66946007)(6916009)(4326008)(66476007)(66556008)(5660300002)(956004)(2616005)(66574015)(15650500001)(86362001)(8936002)(8676002)(6486002)(44832011)(2906002)(6512007)(83380400001)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 66enaZ/LB+6/U5ryWBMPXOSSElYmeoAVjiRkugjgFsJGwuUJyayJYXVgqb+EgbpAZEPA4mFEMBg6cL3ecrGkbk9h+Lp7/2WsHimtg9abvVm2OD4P7nOlQZnW+2q8ABio/l1/VK0MXixcywyKWLsU2cWyu9A6e4Nc6nTvbu3I0ul6wco5piHo9dPG9AV/v7DQmBMxpmXyGqzIeJQWq8y05wwDIdrP/lWSgBEJ+1fWvDlVdZuqq/zmhJwVJA3OoCuI3IpQlukc6X4LUUoUfpgOmOlUFyBxYL/4mguwj+f17mrkYgXQ9zgnJx6QHQEa8S4YYThmO3BjGRkzdGPD7VRKk76amuWmbEiXSc1JLmPq7omBW+wr5SQi74I6m4P2BNzlmAlXFiOL7lz/nvGcqCn/ZLCH/JYUefjpOyTa7R5aDz+yPaVfSgrq/tt0M3RyiiSBTJ1IMGUTmzCJ9KDySfwGKvragBzcNohybs80k5qqgMNnYwaTqzpsmaSJ5ve911gx84c9R5cvPgzaiOmL2g/fqhWIoVzgOAIaGgioQf4A+ZxSYFNMZdZyN3MDvONbaCnLzVOucxemQdx5dd7kcIHNCKKsTpxnHWD8T/d6r7bpdipXdKTCnh7TaJpD/hRl1vJ+pCvoE+n+7YVi8NBYdkXL3g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91007ef9-0f06-4c4c-e112-08d83e78ef44
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 04:34:00.7819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zto9MnQ0F0rt8EC6W1bcvyahDpKk6sNsrCLvzCsbeYAFQPlFhjz8gGY7gcDMgAzj97a0o0WpeR4AevDCT1ZkYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3794
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
c3QKCkNjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTog
U2hhc2hhbmsgU2hhcm1hIDxzaGFzaGFuay5zaGFybWFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaCB8IDM4ICsrKysrKysrKysrKysrKysrKysr
KysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyAgICB8ICA5ICsrKyst
LQogMiBmaWxlcyBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgKaW5kZXggNjNlNzM0YTEyNWZi
Li5iOWFhZTc5ODNiNGIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90cmFjZS5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFj
ZS5oCkBAIC0zMjEsNiArMzIxLDQ0IEBAIERFRklORV9FVkVOVChhbWRncHVfdm1fbWFwcGluZywg
YW1kZ3B1X3ZtX2JvX2NzLAogCSAgICBUUF9BUkdTKG1hcHBpbmcpCiApOwogCitUUkFDRV9FVkVO
VChhbWRncHVfdm1fdXBkYXRlX3B0ZXMsCisJICAgIFRQX1BST1RPKHN0cnVjdCBhbWRncHVfdm1f
dXBkYXRlX3BhcmFtcyAqcCwKKwkJICAgICB1aW50NjRfdCBzdGFydCwgdWludDY0X3QgZW5kLAor
CQkgICAgIHVuc2lnbmVkIGludCBucHRlcywgdWludDY0X3QgZHN0LAorCQkgICAgIHVpbnQ2NF90
IGluY3IsIHVpbnQ2NF90IGZsYWdzKSwKKwlUUF9BUkdTKHAsIHN0YXJ0LCBlbmQsIG5wdGVzLCBk
c3QsIGluY3IsIGZsYWdzKSwKKwlUUF9TVFJVQ1RfX2VudHJ5KAorCQkJIF9fZmllbGQodTY0LCBz
dGFydCkKKwkJCSBfX2ZpZWxkKHU2NCwgZW5kKQorCQkJIF9fZmllbGQodTY0LCBmbGFncykKKwkJ
CSBfX2ZpZWxkKHU2NCwgaW5jcikKKwkJCSBfX2ZpZWxkKHVuc2lnbmVkIGludCwgbnB0ZXMpCisJ
CQkgX19keW5hbWljX2FycmF5KHU2NCwgZHN0LCBucHRlcykKKwkpLAorCisJVFBfZmFzdF9hc3Np
Z24oCisJCQl1bnNpZ25lZCBpbnQgaTsKKworCQkJX19lbnRyeS0+c3RhcnQgPSBzdGFydDsKKwkJ
CV9fZW50cnktPmVuZCA9IGVuZDsKKwkJCV9fZW50cnktPmZsYWdzID0gZmxhZ3M7CisJCQlfX2Vu
dHJ5LT5pbmNyID0gaW5jcjsKKwkJCV9fZW50cnktPm5wdGVzID0gbnB0ZXM7CisKKwkJCWZvciAo
aSA9IDA7IGkgPCBucHRlczsgKytpKSB7CisJCQkJdTY0IGFkZHIgPSBwLT5wYWdlc19hZGRyID8g
YW1kZ3B1X3ZtX21hcF9nYXJ0KAorCQkJCQlwLT5wYWdlc19hZGRyLCBkc3QpIDogZHN0OworCisJ
CQkJKCh1NjQgKilfX2dldF9keW5hbWljX2FycmF5KGRzdCkpW2ldID0gYWRkcjsKKwkJCQlkc3Qg
Kz0gaW5jcjsKKwkJCX0KKwkpLAorCVRQX3ByaW50aygic2VnOjB4JTAxMGxseC0weCUwMTBsbHgs
IGZsYWdzOjB4JWxseCwgbnB0cj0ldSwgcGdzejolbGx1LCIKKwkJICAiIGRzdDpcbiVzIiwgX19l
bnRyeS0+c3RhcnQsIF9fZW50cnktPmVuZCwgX19lbnRyeS0+ZmxhZ3MsCisJCSAgX19lbnRyeS0+
bnB0ZXMsIF9fZW50cnktPmluY3IsCisJCSAgX19wcmludF9hcnJheShfX2dldF9keW5hbWljX2Fy
cmF5KGRzdCksIF9fZW50cnktPm5wdGVzLCA4KSkKKyk7CisKIFRSQUNFX0VWRU5UKGFtZGdwdV92
bV9zZXRfcHRlcywKIAkgICAgVFBfUFJPVE8odWludDY0X3QgcGUsIHVpbnQ2NF90IGFkZHIsIHVu
c2lnbmVkIGNvdW50LAogCQkgICAgIHVpbnQzMl90IGluY3IsIHVpbnQ2NF90IGZsYWdzLCBib29s
IGRpcmVjdCksCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCmluZGV4IDcxZTAw
NWNmMjk1Mi4uYjVkYmI1ZThiYzYxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYwpAQCAtMTUxMywxNyArMTUxMywyMiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRhdGVf
cHRlcyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywKIAkJZG8gewogCQkJ
dWludDY0X3QgdXBkX2VuZCA9IG1pbihlbnRyeV9lbmQsIGZyYWdfZW5kKTsKIAkJCXVuc2lnbmVk
IG5wdGVzID0gKHVwZF9lbmQgLSBmcmFnX3N0YXJ0KSA+PiBzaGlmdDsKKwkJCXVpbnQ2NF90IHVw
ZF9mbGFncyA9IGZsYWdzIHwgQU1ER1BVX1BURV9GUkFHKGZyYWcpOwogCiAJCQkvKiBUaGlzIGNh
biBoYXBwZW4gd2hlbiB3ZSBzZXQgaGlnaGVyIGxldmVsIFBEcyB0bwogCQkJICogc2lsZW50IHRv
IHN0b3AgZmF1bHQgZmxvb2RzLgogCQkJICovCiAJCQlucHRlcyA9IG1heChucHRlcywgMXUpOwor
CisJCQl0cmFjZV9hbWRncHVfdm1fdXBkYXRlX3B0ZXMocGFyYW1zLCBmcmFnX3N0YXJ0LCB1cGRf
ZW5kLAorCQkJCQkJICAgIG5wdGVzLCBkc3QsIGluY3IsCisJCQkJCQkgICAgdXBkX2ZsYWdzKTsK
IAkJCWFtZGdwdV92bV91cGRhdGVfZmxhZ3MocGFyYW1zLCBwdCwgY3Vyc29yLmxldmVsLAogCQkJ
CQkgICAgICAgcGVfc3RhcnQsIGRzdCwgbnB0ZXMsIGluY3IsCi0JCQkJCSAgICAgICBmbGFncyB8
IEFNREdQVV9QVEVfRlJBRyhmcmFnKSk7CisJCQkJCSAgICAgICB1cGRfZmxhZ3MpOwogCiAJCQlw
ZV9zdGFydCArPSBucHRlcyAqIDg7Ci0JCQlkc3QgKz0gKHVpbnQ2NF90KW5wdGVzICogQU1ER1BV
X0dQVV9QQUdFX1NJWkUgPDwgc2hpZnQ7CisJCQlkc3QgKz0gbnB0ZXMgKiBpbmNyOwogCiAJCQlm
cmFnX3N0YXJ0ID0gdXBkX2VuZDsKIAkJCWlmIChmcmFnX3N0YXJ0ID49IGZyYWdfZW5kKSB7Ci0t
IAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
