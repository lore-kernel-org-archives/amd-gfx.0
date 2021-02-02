Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E59AC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC66B64F5E
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC66B64F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D2366E941;
	Tue,  2 Feb 2021 16:01:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9506E6E942
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 16:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWN6F4hpxDVo67s5+GL770uUixMqzlFzWkA0KXsOKl0pQhgFPXiiYpAycUUrHmugffqViQ0lmcvSekk1Q4fNa0cuH5gVrBaAR8Qw4s/Z/UAoqulM1oIGAWit+ppBYj8rdr/xzrEUKNjtSUj9QYBYrUXSjPVZBBBHJS+hFnrDhqEPPOcQmUCQXm01KWi+qi3TgUKHGUVBiiA9JuXAwZ77uy6+iSSC2YC5Gf4LxPeOBWfKvE9kYvdj5KLiAesjr/sB8Z9F2SuuEedyvXsx4YTdgcY5Ua+YzhwLH/Ri11Q5pzaVzTNssjjq4HfQlTA7Y8cPNSypBcUVGT53+cbsInGYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGnk5XJT/3fbr/N7GMxXqOpjMl8IveifPIXUFQEtSPE=;
 b=bPAb1OmkjXsO1EZVYhuY7649n8rbmVqNOmOE5pogQZoBgDseFSeAkSDRQbX1y89YwrOliU6nhrf2D73sMEzLIHmgpU5kur5DnsRNl/hHoOVrKhH1Fw/IYfdcdBVCQm2hCqQxmkWbnB/L1j0498IFqd0dUnYak0+kFms8fR8grvqu8vJghO6keWIBg/EM6RPdcT2Pjy9TJdusIJLmvaFP5gLINTnJCNJB38VMhfwnKEFZib5ZzDlWQg7w6oSNqxMBP35srvz1hoAMPAbWAzFR7P3r8cAcLHbzDqyHPP2crqkq8fPTkTLwR51aGBDkcoQdKYhk68+zgm24cJlFq8j1PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGnk5XJT/3fbr/N7GMxXqOpjMl8IveifPIXUFQEtSPE=;
 b=EsTcY3X3CZUCAZ/7Ijrz7JUItWKjiSlO23Zyh+LauBQX9Ijw4hR/Vylpx83bz6h1YLsPYIU0V8T6R+mhJ/3RvToVFebWBHMn99CxTKVgrpWAJbu43sz8IcCUR4+q0kmxHlLTG9mBCT6/nvIJLDeI90NJ8bnB0L6qZ9RqwaNujw8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1131.namprd12.prod.outlook.com (2603:10b6:3:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Tue, 2 Feb
 2021 16:01:10 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Tue, 2 Feb 2021
 16:01:10 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: cleanup struct amdgpu_ring
Date: Tue,  2 Feb 2021 17:00:47 +0100
Message-Id: <20210202160050.59777-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:405:75::15) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:405:75::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Tue, 2 Feb 2021 16:01:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 915cdb68-4803-43f6-d51d-08d8c793c222
X-MS-TrafficTypeDiagnostic: DM5PR12MB1131:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11311F7664B5B0671EC7E7548BB59@DM5PR12MB1131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Acsp2xxUemEjMYcWBDmXtlDPKiKcJXRDH0MNVaJfWj+fs8lsdvB443omum9rqPEWgIYuDiInjUI7zkJoZGsvMZZtu4I8+lOr6lDK6dWy42/2Do1KqYH2ReklfXzQgfv1yC3M7WVCt5ASYt0dHC2turgBGDbQp8nKKXxwOVTNBEqn6LHG4RiAP9NA8PwhfILcraTciYe6JmujvzD78p9it9rrpwUANXnaMhJPIEMdA2gEZLkCiiExvagu9u436jEdEE36cBIrYg16QGgC6XOCkM7p2UBHXQJwxM59xvGAWJ4DmiN+HMcp/cla1R86loevr2ama2HUXUH+zcxO++dcGRWIubuCl8zsEz+FlDOyh+SO/MU5fcID4GlS85JqD9vESIBMgLSrJJjUBh60fBcM0SOc2/obGRNG5QOE+5CnWmHw4KIB94QHmY3uUulsQzL3KoOSNcr/qkHYahohL7O/0AjUdLZQ6G7h5MaOMv5hBb362m+ODY5K2NPYMLvw8/PKR+Gzi2xx8tl3Fj7vdE4kZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(26005)(8676002)(2906002)(2616005)(6486002)(186003)(16526019)(83380400001)(4326008)(52116002)(7696005)(66556008)(44832011)(66946007)(316002)(5660300002)(1076003)(478600001)(36756003)(86362001)(956004)(6666004)(66476007)(6916009)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?akgrRkR2M2J2MEJ6TkxVaUp1MlBoZnQ0Mk1TVHZMWXNveDE4YkVoMFpZVmNo?=
 =?utf-8?B?TGNUQnhZK1RPbi80cXZMQUJrWldZSnlwTDA1RFM5cElXT0R1V016VEt4aW02?=
 =?utf-8?B?SEd6Tm1vUGJ6S2FQdG5uNnFrcTdHMU00OHkwOU1meFliKzhXSUpBSWlXNUNU?=
 =?utf-8?B?T2VFSHNGR0J4TFJSdmNiWjFSSS9XN1pIby9YL0VJNUd6b3JzNTM2cFFBT2FY?=
 =?utf-8?B?Y0VzZE9Ock05c1BsZjAxTHRBemFRVmgxa3NMZU84L245MVNQQ25XQjRHcDE2?=
 =?utf-8?B?ZUxqdUMvWmNNSDMzVmdlWTBSMDN2QXpHY3RONTVaYkt2UkZGNUZnNTVDNWNB?=
 =?utf-8?B?dEcwNWRSMHc3cEdOYlNNZ05hd25xb3M5UFBobW9DMit2bzRWdUc1WFc1UXRM?=
 =?utf-8?B?U1RySnlDem44RzRYdUNETjIybFlCejJLL1h3M3puVDBSS3FFMkJuTit3M0pz?=
 =?utf-8?B?VDhhZy9xVDNXTUg5eCt2TE0yNi9mKzdBYTJKL01HbWJPUEZRckdMUnhFaVdy?=
 =?utf-8?B?c1daNk9wS3pjSmNxbEo2a0dhaEVDdnpDTjJUKytrYlBtOUNZSUNSY3FZRDVp?=
 =?utf-8?B?SGx1KzFVK3VLZkZUMHl4T09ndzRXZ1NZa1hQYTJ1Q2F3aWhRd0p4TUNubk9Z?=
 =?utf-8?B?Nm1PWmxFbmdjUjhQcThOMHBZL3JubGwwRlhqRjVieXlvSnZrTkFBUVZ0Z2s5?=
 =?utf-8?B?M3k5eGhzS3RjVzdaenVEbXdpS1ZFZ1lIN1FCRU1CS2dnaVpEUTA1V0FzVDJs?=
 =?utf-8?B?S2VvY2JtVTBOM2tMYWlFd0FwbG83aDloNTYwU21hNnBFWHVpbFp6TG9jbnkv?=
 =?utf-8?B?emc4emFyZGtmNzBYejNENkErZXJnOXpVS082amh6b3NocXJmNWdUK25DclRZ?=
 =?utf-8?B?MzN5MjlCRDEydWczMTN3WXpuLzRyS0dxc2I0czJEb1cxUHROdnpkVm92TU5R?=
 =?utf-8?B?bTFLNkduRWdwdXdabFVDd1p1bFRnRHVUKytobWF3c3I4ZWJHaTRVbEhCbjQw?=
 =?utf-8?B?TDc2di82b0NtZEN4c01MQlRSWWVkbkdGRjNBVDZmUGpsQkZrUDYwR2lOd1cy?=
 =?utf-8?B?RHp0MFl2d2RqQ01lVVYxUG8wT3ZYcDdsN1BJRkF6dkIrVFZMT3JtUlkvWlc5?=
 =?utf-8?B?KzFlZm9mNjdQVTEvRmZDRHlaV29lZmw4UFBuVzYrWVVOUnowaGRNYmZJSGJv?=
 =?utf-8?B?RWswWk5ESllCTVZoa0x4UDV2citOVDVHRGhHYXFqekJadjZiSkZuUkZsRWRi?=
 =?utf-8?B?dHI4enZoeElaeU5NWURrY1FuT0lWVlZ0bW4rOFNSRXBKNDRzdVRmdmlVaDV5?=
 =?utf-8?B?R0tXSUFhTVkvYWNaa3hNZUpIeHFKaWlSYXRuRWhIaTBLRk1xOG81Q0M3VkM5?=
 =?utf-8?B?ZlpCVUE0VHF1M3NpVjFqVTJYMzArT0NVTkk0cDFPZmNCZWJ3WFlHbExVZVpI?=
 =?utf-8?Q?sGOX9Gh3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 915cdb68-4803-43f6-d51d-08d8c793c222
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 16:01:10.7046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIYy07DKjCbKjdpwwFPU/yOxvB24kh8OTrrJohHw1oRxyysnZ9Q9bEC4sJaOAkCsKQ/3JdUCTpCzQMxtINfqoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1131
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
Cc: Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 Nirmoy Das <nirmoy.das@amd.com>, ray.huang@amd.com,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBwYXRjaCBjb25zaXN0IG9mIGJlbG93IHJlbGF0ZWQgY2hhbmdlczoKCjEgUmVuYW1lIHJp
bmctPnByaW9yaXR5IHRvIHJpbmctPmh3X3ByaW8uCjIgQXNzaWduIGNvcnJlY3QgaGFyZHdhcmUg
cmluZyBwcmlvcml0eS4KMyBSZW1vdmUgcmluZy0+cHJpb3JpdHlfbXV0ZXggYXMgcmluZyBwcmlv
cml0eSByZW1haW5zIHVuY2hhbmdlZAogIGFmdGVyIGluaXRpYWxpemF0aW9uLgo0IFJlbW92ZSB1
bnVzZWQgcmluZy0+bnVtX2pvYnMuCgp2MzogcmVtb3ZlIHJpbmctPm51bV9qb2JzLgp2MjogcmVt
b3ZlIHJpbmctPnByaW9yaXR5X211dGV4LgoKRml4ZXM6IDMzYWJjYjFmNWExNyAoImRybS9hbWRn
cHU6IHNldCBjb21wdXRlIHF1ZXVlIHByaW9yaXR5IGF0IG1xZF9pbml0IikKU2lnbmVkLW9mZi1i
eTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yaW5nLmMgfCA4ICsrLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmluZy5oIHwgNiArLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcmluZy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3JpbmcuYwppbmRleCAxYTYxMmY1MWVjZDkuLmI2NDRjNzg0NzVmZCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jCkBAIC0xNjYsNyArMTY2LDcgQEAgaW50IGFtZGdw
dV9yaW5nX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfcmlu
ZyAqcmluZywKIAkJICAgICB1bnNpZ25lZCBpbnQgbWF4X2R3LCBzdHJ1Y3QgYW1kZ3B1X2lycV9z
cmMgKmlycV9zcmMsCiAJCSAgICAgdW5zaWduZWQgaW50IGlycV90eXBlLCB1bnNpZ25lZCBpbnQg
aHdfcHJpbykKIHsKLQlpbnQgciwgaTsKKwlpbnQgcjsKIAlpbnQgc2NoZWRfaHdfc3VibWlzc2lv
biA9IGFtZGdwdV9zY2hlZF9od19zdWJtaXNzaW9uOwogCXUzMiAqbnVtX3NjaGVkOwogCXUzMiBo
d19pcDsKQEAgLTI1OCw4ICsyNTgsNyBAQCBpbnQgYW1kZ3B1X3JpbmdfaW5pdChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAogCX0KIAogCXJpbmct
Pm1heF9kdyA9IG1heF9kdzsKLQlyaW5nLT5wcmlvcml0eSA9IERSTV9TQ0hFRF9QUklPUklUWV9O
T1JNQUw7Ci0JbXV0ZXhfaW5pdCgmcmluZy0+cHJpb3JpdHlfbXV0ZXgpOworCXJpbmctPmh3X3By
aW8gPSBod19wcmlvOwogCiAJaWYgKCFyaW5nLT5ub19zY2hlZHVsZXIpIHsKIAkJaHdfaXAgPSBy
aW5nLT5mdW5jcy0+dHlwZTsKQEAgLTI2OCw5ICsyNjcsNiBAQCBpbnQgYW1kZ3B1X3JpbmdfaW5p
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAog
CQkJJnJpbmctPnNjaGVkOwogCX0KIAotCWZvciAoaSA9IERSTV9TQ0hFRF9QUklPUklUWV9NSU47
IGkgPCBEUk1fU0NIRURfUFJJT1JJVFlfQ09VTlQ7ICsraSkKLQkJYXRvbWljX3NldCgmcmluZy0+
bnVtX2pvYnNbaV0sIDApOwotCiAJcmV0dXJuIDA7CiB9CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmluZy5oCmluZGV4IDcxMTIxMzc2ODlkYi4uMmFkYTgwY2U0MmY1IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmgKQEAgLTI0MiwxMSArMjQyLDcg
QEAgc3RydWN0IGFtZGdwdV9yaW5nIHsKIAlzdHJ1Y3QgZG1hX2ZlbmNlCSp2bWlkX3dhaXQ7CiAJ
Ym9vbAkJCWhhc19jb21wdXRlX3ZtX2J1ZzsKIAlib29sCQkJbm9fc2NoZWR1bGVyOwotCi0JYXRv
bWljX3QJCW51bV9qb2JzW0RSTV9TQ0hFRF9QUklPUklUWV9DT1VOVF07Ci0Jc3RydWN0IG11dGV4
CQlwcmlvcml0eV9tdXRleDsKLQkvKiBwcm90ZWN0ZWQgYnkgcHJpb3JpdHlfbXV0ZXggKi8KLQlp
bnQJCQlwcmlvcml0eTsKKwlpbnQJCQlod19wcmlvOwogCiAjaWYgZGVmaW5lZChDT05GSUdfREVC
VUdfRlMpCiAJc3RydWN0IGRlbnRyeSAqZW50OwotLSAKMi4zMC4wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
