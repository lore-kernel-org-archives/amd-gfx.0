Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0587EC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F6564F49
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 16:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F6564F49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F9C6E94B;
	Tue,  2 Feb 2021 16:01:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23E146E94B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 16:01:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYk184PDCw5HVPpZSDn83mqmpp8CjRBW+esehwlPNfkjM8ZvEUF182aItf6H/LJDmGFDVCT0T8Ls2uX8tu6zg51jHKWpRshMKM6sDzXjsJHoBhyY3vqCWg/fYRUWswAJkGMB1WTBWnjx/rPazLVOFyEExx6MusjvHqYrmZ9AeTjSczHjUQI/Rg3WVujpbocT/cc4G0tydDQuepwf3CW3FBZrhGSt3FwjisFv4i4Cte/DpIF2GTlB6nPCDT0NzXgbBYfHEeJjzI8bijF2j9fXa32ELhjZqJeIdTTTDBZEX88J6FXHLZ8bNz25/nABGYkB4LkbYAbGICF6e62R6azfqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvHVjCJ1Swno8NK4Lfo76D2tH6RuE37PABvkI81qnNA=;
 b=ZjzrZ5uEPGC0ltjigw95UwtnLdkyp4sLdzelOq3z+Ysu+tvNVE1dnHNs+DcvQE/Z5ULMcN6KZXqD7TUPBZKRPJUGetZ6xCZEE9EDR9gitp//OKq/TbhFmZB9b3Z4zmN/PBOVLgpWFITSxXH8Kp7oQ6hL47Y7OnQ0hmf/lCEB5fDDRf0PGlDFdfKQyIo78zufeegGjuWFtQyLupD9A+a58FA69xNnUYY6Ojr48czoOXGjfWWORa6WKDKLqOnhxiAyDOQ7IuOF2R8QnlYCOBnN+lVKtn+9Vz5fpmtX3RIabHClUvVMpKz3KdWcb5RDvY7ylhOy6poXdkcNe0h5HCBMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvHVjCJ1Swno8NK4Lfo76D2tH6RuE37PABvkI81qnNA=;
 b=FdZ+GwA4wQAOF50/mJA4ShjqPixAef2NQ9TP4GDyQwZTQuwE2AhdxJ6F9D+n3cLlpmCAvFWv9pK6pHJUa6y2TMrVMt1R5IXilpUR2sBec/kLgFz2kEc/gjqlzRxNlPUUPMl7fd12vPXi+jelfXopcpyHjMlQmYg8cs8kd5ySrGE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1131.namprd12.prod.outlook.com (2603:10b6:3:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Tue, 2 Feb
 2021 16:01:19 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3805.027; Tue, 2 Feb 2021
 16:01:19 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: enable gfx wave limiting for high priority
 compute jobs
Date: Tue,  2 Feb 2021 17:00:50 +0100
Message-Id: <20210202160050.59777-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202160050.59777-1-nirmoy.das@amd.com>
References: <20210202160050.59777-1-nirmoy.das@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:405:75::15) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:405:75::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Tue, 2 Feb 2021 16:01:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6fbe3e0b-0fa7-42f7-04cb-08d8c793c717
X-MS-TrafficTypeDiagnostic: DM5PR12MB1131:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1131FD3315F7CDDB787BC2218BB59@DM5PR12MB1131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:224;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLMrCLNFKl6rAij8bIBBVD34iMYX+sZjy/kg8Mx4ZMZ2m5guHbseHo9gLgGWBDjuEsSGJDVTfT3FdNzOcwD/7gT++3W8x8Dzewsd5KKUtEpFNRUnwk6IJrBygV5mANRzbFk6dp5KQ4xKZbjsssbpoS2yUSC83zLQQ8TbOcWz/4HDLw0rTGr7q+sk123yv6vRNMo16Kyf9zuplzxi84gGZCU/q0c4H2Hu4C2i2CqDsFwdglVlnceuFTMJNXKyq8DCE5mry4s+hYUOt41bdM0EL5YpzxhTS6nz5b5cz5eh3Jh7SwWhPLiD5QJeZ6rh8eY5S+0gl6fkwTo35H+ywu7ZvQkMUJ70YqOiPv3z6haVFZfqp0/rlArGUpJywRLnWGgvZ7aJBRfhK8w0Dxcn5ejcjPRECWC3y1dkYd85GYm7LdUu2uB++LGWYOKgV2aQJVuEG1bIFUGt0yvP10p+QpCdVrYb6xPEwz5I7N+OMCDzonfjTTkVnxNK9/z7Fq8XEi7ft/MkrUxi0b4DEhr2e5YJZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(26005)(8676002)(2906002)(2616005)(66574015)(6486002)(186003)(16526019)(83380400001)(4326008)(52116002)(7696005)(66556008)(44832011)(66946007)(316002)(5660300002)(1076003)(478600001)(36756003)(86362001)(956004)(6666004)(66476007)(6916009)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V2xmcVdhRmZhSC9MRk5EWFpaZG8vU1NYYU9pYk4ybFlEamRqV2FneFNvOUJV?=
 =?utf-8?B?by9CU1htdjlrckplUlpBWUx5a200S01HSUFWMXhNUFlzTys1LzZQa2IydUhH?=
 =?utf-8?B?cnNpc2tWdndad1EyTE5XVm5xamw5dkhveC8ydWVKNENkZ0hIMXIwZGJkQ080?=
 =?utf-8?B?KzBMVVZBSjJ5V2ZzSCtHeG1PNEIyT2N0ZnpZaDdHTnVkR2FDblV1NWNVMWI3?=
 =?utf-8?B?cG9MQmMrMytrN3YzTEh3VTdycnA2RHpYNE5xTElOU2N0NXFmSlpyZmM4aEVv?=
 =?utf-8?B?YXcrSVNETFVkWm9mZnhVV3RBVVN2WGdkZjIybE9KY3drdk84Q2ZNVDc5WmlB?=
 =?utf-8?B?b2R5Z3R5ZDVvKzcwVnZ4R1I0MXpIdk8yWHJ1K0J2VTBrZlFWR2dTV3JJdFFL?=
 =?utf-8?B?TGhhckdEcWs1TlNjclFQb1l3N1NCcUhBM1BPK3NGM0p2SVZxK0lYMzVyTkZa?=
 =?utf-8?B?K0MwMmphVkVaV0NOSFpaZWxyanJJT3VienBJM1VKOWJQY1dBdjdib0hTMjQ3?=
 =?utf-8?B?aHpPUzRPUzFlc2crTExzT2pIbHZXbzl3MjZaNW5VdTRCZHlWLzRUSDJWQ21V?=
 =?utf-8?B?anZJZmdEbm0ybjZwZUlzSXQrcDBxTEpDRFhSV01IV2ppTlpXZ3d1cE83V2tx?=
 =?utf-8?B?dEp0SE1ucmNpMGlZcVBNbW0yek1ORHhqcjlOSGhLUyswRitYbWdublVpNWlU?=
 =?utf-8?B?clIzQ1NnRFVxZVFMMTVuVU4wMFJaSHJTckZ0azY3YTh6Qzh3TVhTbVhKdTRt?=
 =?utf-8?B?REVvZlU5UnF4dFhjVHhzZnZRaXc1bVlvUFJLaDdyUHNpNkZqN0Z4Y2xPMXRp?=
 =?utf-8?B?UTdnVFdYM2RDOFN5dlVEV1VJTnFJMEdxck1uYUNZeXVUak0zTWhpZE93L2hF?=
 =?utf-8?B?cXUvN0grYmw4R0JoRUd4Q3VKbDdCSlFVZGpORDhCRFZCS3lDeWl5eno1YURC?=
 =?utf-8?B?cFRPUkFrQ0NJejlPSnNPczF2eWhJeGRvUWZIaTRtRkJBdlR2a0kvK0NYK1du?=
 =?utf-8?B?djlyaHRvaFJpZTRxbS9VUWN0Y2p1SlpVRndFUnJ0VFE1RlFjRjVJVm4zaTh6?=
 =?utf-8?B?bnNoYi9nRm9vS0kxekp3OG5RTk81YUhHYUxzZW56YTA4UTgxMHdCYkdqOFFB?=
 =?utf-8?B?aUgxRk5hMkUxeUcxUFI3UktvLzFTTy9JK0UxcURRZythbXBwRDBJL0lTTS9h?=
 =?utf-8?B?c05sUUJ1S1d0cDFITHhoRG9aQkM3dERCZGJ3cERXRWpYWEM2MEl0SkFrNlVr?=
 =?utf-8?B?WDJZVUNlSTRTcUpBeWpIbnN0aWlKbVQ3V3ZaSzJIYXNJWkcxOUVnVUFnTFlH?=
 =?utf-8?B?cWFKUjhuMmV6K0xwblBOeFVKOHZPYUpXVlBEYjlEMllJY3FuUjVWOGYxcTNB?=
 =?utf-8?B?bmtWUmltTU5JbG5xdnQxNnhaSkNDWTZzUy9uVGkxRUJkNGZXRi9QTXpBc28y?=
 =?utf-8?Q?YaCFas6I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbe3e0b-0fa7-42f7-04cb-08d8c793c717
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 16:01:19.0008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXfVfgSXqxGDwVybyS0ySqDn/xgURCH2Jl4GqWkkwGi3EfJms38OmQlLuGZWRh7jKvYKrvmPUerN7AfS2Kn7Gg==
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

RW5hYmxlIGdmeCB3YXZlIGxpbWl0aW5nIGZvciBnZnggam9icyBiZWZvcmUgcHVzaGluZyBoaWdo
IHByaW9yaXR5CmNvbXB1dGUgam9icyBzbyB0aGF0IGhpZ2ggcHJpb3JpdHkgY29tcHV0ZSBqb2Jz
IGdldHMgbW9yZSByZXNvdXJjZXMKdG8gZmluaXNoIGVhcmx5LgoKdjI6IHVzZSByaW5nIHByaW9y
aXR5IGluc3RlYWQgb2Ygam9iIHByaW9yaXR5LgoKU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8
bmlybW95LmRhc0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9p
Yi5jIHwgOSArKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jCmluZGV4IDAyNGQwYTU2M2E2NS4uNzY0NTIy
M2VhMGVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYwpAQCAtMTk1LDYg
KzE5NSwxMCBAQCBpbnQgYW1kZ3B1X2liX3NjaGVkdWxlKHN0cnVjdCBhbWRncHVfcmluZyAqcmlu
ZywgdW5zaWduZWQgbnVtX2licywKIAlpZiAoKGliLT5mbGFncyAmIEFNREdQVV9JQl9GTEFHX0VN
SVRfTUVNX1NZTkMpICYmIHJpbmctPmZ1bmNzLT5lbWl0X21lbV9zeW5jKQogCQlyaW5nLT5mdW5j
cy0+ZW1pdF9tZW1fc3luYyhyaW5nKTsKIAorCWlmIChyaW5nLT5mdW5jcy0+ZW1pdF93YXZlX2xp
bWl0ICYmCisJICAgIHJpbmctPmh3X3ByaW8gPT0gQU1ER1BVX0dGWF9QSVBFX1BSSU9fSElHSCkK
KwkJcmluZy0+ZnVuY3MtPmVtaXRfd2F2ZV9saW1pdChyaW5nLCB0cnVlKTsKKwogCWlmIChyaW5n
LT5mdW5jcy0+aW5zZXJ0X3N0YXJ0KQogCQlyaW5nLT5mdW5jcy0+aW5zZXJ0X3N0YXJ0KHJpbmcp
OwogCkBAIC0yOTUsNiArMjk5LDExIEBAIGludCBhbWRncHVfaWJfc2NoZWR1bGUoc3RydWN0IGFt
ZGdwdV9yaW5nICpyaW5nLCB1bnNpZ25lZCBudW1faWJzLAogCXJpbmctPmN1cnJlbnRfY3R4ID0g
ZmVuY2VfY3R4OwogCWlmICh2bSAmJiByaW5nLT5mdW5jcy0+ZW1pdF9zd2l0Y2hfYnVmZmVyKQog
CQlhbWRncHVfcmluZ19lbWl0X3N3aXRjaF9idWZmZXIocmluZyk7CisKKwlpZiAocmluZy0+ZnVu
Y3MtPmVtaXRfd2F2ZV9saW1pdCAmJgorCSAgICByaW5nLT5od19wcmlvID09IEFNREdQVV9HRlhf
UElQRV9QUklPX0hJR0gpCisJCXJpbmctPmZ1bmNzLT5lbWl0X3dhdmVfbGltaXQocmluZywgZmFs
c2UpOworCiAJYW1kZ3B1X3JpbmdfY29tbWl0KHJpbmcpOwogCXJldHVybiAwOwogfQotLSAKMi4z
MC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
