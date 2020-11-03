Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29ACC388F9
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 17:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB4220E65
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 17:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gBiQ8MMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB4220E65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D08C46E8C4;
	Tue,  3 Nov 2020 17:14:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44B5B6E8C4
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 17:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z33zfpPEVr6JUzUTrji3oZn3Bdu7fpzQUYycUMX8oe95xBnHAXCE2PxI58rLCU+FVZzoSzQgFUt0mwXTy7oDFVVA0PyrQR2jcZUXIPJF1Khco+QUpXK37D59csEU91qdykTzgy0Jn9KtYonkkI7yAcZuY3jxXArDNNXEwR2H+egRkI1XHzcXGW18lqNMb2c68V2oXQ6laKgyMoP0D4Xfdt+MjFu46bIuE0AZIi4mR3r23/sXycDnqXRm48Dg0s3eBzAB7AF/TD4vytrqCMvuGJ6Ucj4Sy8WQMeftSspCT4pH7LfQPTXDmPi6bKpwObTdF2Aa1+qiKl7HE8Clmc93zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSgGA58AJPFgWNOpW0kpwNp7H7HFhNmV0tiDgBvkNro=;
 b=EepLUIR9TizsIF63KvnF9zh0t7KaQnFQ1S0O9cJtzgOa/iQuiaab4bLzz5TLoTJmfk2HHZcNUY6ZQiRH4IOCqRC0Swc5y36+Wey0qAJ3EV1sf+BZCySrR1KB0js9i9hPTSK2lkKvp2GX1o1r5vg40sSVpMcf7JyNvCrSbf2RFDKEfmVlujzubPyu9ciIquiM/iK2h6otf3wLcWElO+vhfKhRv87piAUYKpZArtcXYBWngESagV++hk7adL3JmYZ7oHJXudU+JmFaEhe81h9igyK8djLCZinfDO7x+x0kdSktvlQY848l2NJ9+PvpHwDObgjnQjvpMuvgpc+ym74o5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSgGA58AJPFgWNOpW0kpwNp7H7HFhNmV0tiDgBvkNro=;
 b=gBiQ8MMKCOWbFsdy1z6pzaErPhp48YSoWmI1ms2bxNJtnlMU9zHzvgHjyAp6/Aj2bEnMl+r/WLI/RflcA4lTob+WxmdEfzM64PREHooIzgUaib6BZk1eBxvR80wXiZdNHXNWQQOHIbivpl0Rc2VHicubf24297Nzb3PMs4TG0HA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 17:14:07 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::e89a:3b9a:e967:3a0c]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::e89a:3b9a:e967:3a0c%7]) with mapi id 15.20.3499.031; Tue, 3 Nov 2020
 17:14:07 +0000
From: Shashank Sharma <shashank.sharma@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: clip the ref divider max value at 100
Date: Tue,  3 Nov 2020 22:43:40 +0530
Message-Id: <20201103171340.2978395-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.107.229]
X-ClientProxiedBy: MAXPR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::29) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (106.51.107.229) by
 MAXPR01CA0111.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 17:14:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d87c7182-bbba-4d88-d0fc-08d8801bdee2
X-MS-TrafficTypeDiagnostic: BYAPR12MB3126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31260CEE13275B850BDB15A1F2110@BYAPR12MB3126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBn+WLdg1hJ90geILRgZX29RLiAYx9RpyyEv6SycbkvSeBu/rcrATkZrr3t2lUaCtVqQ8cq8mR8O9RcGcwu/5RWzVOiveolBJCPu2OcaYOhAs3PJjoS2Pixr3XerBCKEk1Sihsovd6XfGkqw99TF+fM3Zaew1gghR4Y9cCbCxlCOg71Bo3AeYs00YGFY2/VbSilGRu8c3m3YYWId1dWaqy1+w125K83wHEcPnDQ7UJjT79rFCZpPspsfBeEfQDg8rk95EVVCs/B81LL3jcejL7VheqAABfNv65XYud2J7bM0NBtBlPIOy3pXNIxneSXZJpDPOXSJ4ICrP023Z+Oq9CU4fsmplUJ19wny2uK3NcZMg3ev9rEwgkhpPaiQhsUdOoWuU8/URETiA6zZZ989eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(26005)(1006002)(478600001)(1076003)(5660300002)(6916009)(66946007)(8676002)(55236004)(44832011)(86362001)(186003)(6666004)(316002)(2906002)(966005)(54906003)(16526019)(36756003)(66476007)(66556008)(6486002)(83380400001)(956004)(2616005)(6512007)(8936002)(66574015)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4JzzTQoKE5Y5KApE/8aU8jRPDCujpU/BER6dKCFwId/ZORqfdsGhuBssO2e8CZ3bZ9ixj10E6KPPlqCpPjri18l+pLcwRCCRQuxkBAWtMYu7RciuW/repQR5eaXp9G3UmfRed0NjH14UsVIG5Dd+b8UwjIHJ3GdL5OabsHgGY/keJrO0koZLiixizZoWsbCgEA5Acp8qBFBYieiLBvtK2ORwIzTw5eu5dRPIGyGf3saqILCnhuxVS1jRKpI6X1ddtGw8oMDnVhWW7TIXC6KCtjjBfKDZuxdFcVwp7rXrT6vn5evdQ+jGTrhH2n5ELMR2GHY4p46Ro6eSiN2Glw9WF1fs3t71EtWB5LX1w9mUda+9aWQAN7SQUbYqpLQmTh3RSIJILl/T7MbR/cmn7FL3ORa37C58itdOePPNebR2JYxk7F+lhP4OYTd3YQ2tewbKOCOwflu6U9F84ndv6WQgy2Vm6biCvEM10h1xEVN29T13YPTKr2fO32XN6b2EvRxhK/HB3Qu/e3wSWXbjZp4pyE53MOuYcX6LlcYCdi+TFgs3O91c5oK43J8iIJW5PIb2TDh3h0IM2w4IFgfykyYaeN0AcKGX6rBiuz8d0v5MHCzDvgM30zDfw8/axXV5paLbLMudN15RfxpMm3RJt9olNQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87c7182-bbba-4d88-d0fc-08d8801bdee2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 17:14:07.3609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueHUWz5hirK820c/55d+qQ+VjhkIMZdhWtbixHiplO5m01vRrqDtsKg7EMBwupw+w2PBxpw8UrIENrA5h2fcDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3126
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Eddy Qin <Eddy.Qin@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBwYXRjaCBsaW1pdHMgdGhlIHJlZl9kaXZfbWF4IHZhbHVlIHRvIDEwMCwgZHVyaW5nIHRo
ZQpjYWxjdWxhdGlvbiBvZiBQTEwgZmVlZGJhY2sgcmVmZXJlbmNlIGRpdmlkZXIuIFdpdGggY3Vy
cmVudAp2YWx1ZSAoMTI4KSwgdGhlIHByb2R1Y2VkIGZiX3JlZl9kaXYgdmFsdWUgZ2VuZXJhdGVz
IHVuc3RhYmxlCm91dHB1dCBhdCBwYXJ0aWN1bGFyIGZyZXF1ZW5jaWVzLiBSYWRlb24gZHJpdmVy
IGxpbWl0cyB0aGlzCnZhbHVlIGF0IDEwMC4KCk9uIE9sYW5kLCB3aGVuIHdlIHRyeSB0byBzZXR1
cCBtb2RlIDIwNDh4MTI4MEA2MCAoYSBiaXQgd2VpcmQsCkkga25vdyksIGl0IGRlbWFuZHMgYSBj
bG9jayBvZiAyMjEyNzAgS2h6LiBJdCdzIGJlZW4gb2JzZXJ2ZWQKdGhhdCB0aGUgUExMIGNhbGN1
bGF0aW9ucyB1c2luZyB2YWx1ZXMgMTI4IGFuZCAxMDAgYXJlIHZhc3RseQpkaWZmZXJlbnQsIGFu
ZCBsb29rIGxpa2UgdGhpczoKCistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0rCnxQYXJhbWV0ZXIgICAgfEFNREdQVSAgICAgICAgfFJhZGVvbiAgICAgICB8CnwgICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8CistLS0tLS0tLS0tLS0tKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rCnxDbG9jayBmZWVkYmFjayAgICAgICAgICAgICAg
fCAgICAgICAgICAgICB8CnxkaXZpZGVyIG1heCAgfCAgMTI4ICAgICAgICAgfCAgIDEwMCAgICAg
ICB8CnxjYXAgdmFsdWUgICAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8CnwgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8CnwgICAgICAgICAgICAgfCAgICAg
ICAgICAgICAgfCAgICAgICAgICAgICB8CistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0rCnxyZWZfZGl2X21heCAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8
CnwgICAgICAgICAgICAgfCAgNDIgICAgICAgICAgfCAgMjAgICAgICAgICB8CnwgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8CnwgICAgICAgICAgICAgfCAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICB8CistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0rCnxyZWZfZGl2ICAgICAgfCAgNDIgICAgICAgICAgfCAgMjAgICAgICAgICB8Cnwg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8CistLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rCnxmYl9kaXYgICAgICAgfCAgMTAzMjYgICAg
ICAgfCAgODE5NSAgICAgICB8CistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0rCnxmYl9kaXYgICAgICAgfCAgMTAyNCAgICAgICAgfCAgMTYzICAgICAgICB8CistLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rCnxmYl9kZXZfcCAgICAgfCAg
NCAgICAgICAgICAgfCAgOSAgICAgICAgICB8CnxmcmFjIGZiX2RlXl9wfCAgICAgICAgICAgICAg
fCAgICAgICAgICAgICB8CistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0t
LS0rCgpXaXRoIHJlZl9kaXZfbWF4IHZhbHVlIGNsaXBwZWQgYXQgMTAwLCBBTURHUFUgZHJpdmVy
IGNhbiBhbHNvCmRyaXZlIHZpZGVtb2RlIDIwNDh4MTI4MEA2MCAoMjIxTWh6KSBhbmQgcHJvZHVj
ZSBwcm9wZXIgb3V0cHV0CndpdGhvdXQgYW55IGJsYW5raW5nIGFuZCBkaXN0b3J0aW9uIG9uIHRo
ZSBzY3JlZW4uCgpQUzogVGhpcyB2YWx1ZSB3YXMgY2hhbmdlZCBmcm9tIDEyOCB0byAxMDAgaW4g
UmFkZW9uIGRyaXZlciBhbHNvLCBoZXJlOgpodHRwczovL2dpdGh1Yi5jb20vZnJlZWRlc2t0b3Av
ZHJtLXRpcC9jb21taXQvNGIyMWNlMWI0YjVkMjYyZTdkNDY1NmI4ZWNlY2M4OTFmYzNjYjgwNgoK
Q2M6IEFsZXggRGV1Y2hlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4KQ2M6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IEVkZHkgUWluIDxFZGR5LlFp
bkBhbWQuY29tPgoKU2lnbmVkLW9mZi1ieTogU2hhc2hhbmsgU2hhcm1hIDxzaGFzaGFuay5zaGFy
bWFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcGxsLmMg
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcGxsLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcGxsLmMKaW5kZXggMWYyMzA1YjdiZDEzLi4y
M2EyZTFlYmY3OGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9wbGwuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcGxsLmMKQEAg
LTg1LDcgKzg1LDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3BsbF9nZXRfZmJfcmVmX2Rpdih1bnNp
Z25lZCBub20sIHVuc2lnbmVkIGRlbiwgdW5zaWduZWQgcG9zdF8KIAkJCQkgICAgICB1bnNpZ25l
ZCAqZmJfZGl2LCB1bnNpZ25lZCAqcmVmX2RpdikKIHsKIAkvKiBsaW1pdCByZWZlcmVuY2UgKiBw
b3N0IGRpdmlkZXIgdG8gYSBtYXhpbXVtICovCi0JcmVmX2Rpdl9tYXggPSBtaW4oMTI4IC8gcG9z
dF9kaXYsIHJlZl9kaXZfbWF4KTsKKwlyZWZfZGl2X21heCA9IG1pbigxMDAgLyBwb3N0X2Rpdiwg
cmVmX2Rpdl9tYXgpOwogCiAJLyogZ2V0IG1hdGNoaW5nIHJlZmVyZW5jZSBhbmQgZmVlZGJhY2sg
ZGl2aWRlciAqLwogCSpyZWZfZGl2ID0gbWluKG1heChESVZfUk9VTkRfQ0xPU0VTVChkZW4sIHBv
c3RfZGl2KSwgMXUpLCByZWZfZGl2X21heCk7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
