Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1259C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 16:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E95D60240
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 16:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E95D60240
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 056E86E5CA;
	Tue, 22 Jun 2021 16:24:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C636E5C0;
 Tue, 22 Jun 2021 16:24:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ft5rSvxSzlC+h15Ifk30bKhnmVANtaRDs7vvFshCHVzDkGlAKK1dfjWBjMlEUrNlwxHk/aMunZ9qV0eSjk2uzF/kL2zBIBEfI+xWKF5LlNsTJBl5ukxbJ5KFTIbH6HeUTEEP5/SVqYocGYhwq6/LnlaqPhtlBuQmkXsI+Vquiacd14OuLceH7kxtTibJrbThIDfCeca7+3vhLYF/cZMGdTSTEfvnlGz1dTK5PgpciKF5dtIKTYFt/qZDF4d8WresFVnuOpaewn7GYsoIxhr4F63Apb3i30y61F3SSMjg29QdUx07WLU7OtqEJ81ApkznpUJ7ihSMfdvtJ2iy5Kljeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXsPlRN77QPW+FUwi5x4I+6OwsqiVa2abqH4ZYZ9ZrE=;
 b=ZyjG+gqEIQS3RssIfv+ezIq99V9hYG1+f2eRMMvEocB7K/6BbkvBnEsGDjNJu/KV6gLbEKi5CcX56mPSsY/joP7mIMeoctDTixAId1Z5imH6DWG1j2iDJj1gZ6UTulkuDu1O/ZI7WphNbYn9N/f8pOFY+hM8YpNEn+UK1EyHky7GTPzuEmzfIU+i0ISi5ynYMFQ5cQdaKw8S08Mpm2GvbZBsX4f1ChzzsGvId28lZHzf03mJpGoTuAnVjF83eiyD6SAqWJFGzHFpO2CFsNHERpnAcuCMpEOJ1PLu1Nu9kuLB8NR1aoACIL9MPvNVDJRb6veaPiyG1SoDP/mdLX9khw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXsPlRN77QPW+FUwi5x4I+6OwsqiVa2abqH4ZYZ9ZrE=;
 b=CboWOGyIuEBzd2OOC4C+ERFHkrHz94Mraw59XJyC6P49xMVnHc2i0FaZTy/+4kkwdMLWuvFRjEKRleDMbohVVLeypkmHYM/mOQVxewT9MVW8bTch84hdWHsEx3mqW1UCHC6gkHWAZwyr+Dz1s5VK8p6FH90TJIXotlyXqx6NI+A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 16:24:11 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::9f8:ec71:6535:cd36]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::9f8:ec71:6535:cd36%5]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 16:24:11 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/amdgpu: always allow evicting to SYSTEM domain
Date: Tue, 22 Jun 2021 12:23:36 -0400
Message-Id: <20210622162339.761651-3-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210622162339.761651-1-andrey.grodzovsky@amd.com>
References: <20210622162339.761651-1-andrey.grodzovsky@amd.com>
X-Originating-IP: [2607:fea8:3edf:49b0:5c6b:dde9:a4fe:685]
X-ClientProxiedBy: YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::16) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from agrodzovsky-All-Series.hitronhub.home
 (2607:fea8:3edf:49b0:5c6b:dde9:a4fe:685) by
 YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Tue, 22 Jun 2021 16:24:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cebc4f23-3372-4e6f-b6c5-08d9359a2b0b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4399DA166534994EFE6B3438EA099@SA0PR12MB4399.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfxIwalk5F5VMoSgKntOjohWwxE77GWyFrLK42kDxxYTEqhurzi0dxl+1HQIVCtOGsc0BZen14O5CUZJJjEMxqWMewYda566cxlcY1UPC3+2O1J2B9+zufD7mDUdVLDT5qNsULMDoilf/Z3RKeaI9vdmDpAiWD2fFR5ih+G72IOKqQTmxm+H4GvbTEUqxvcAKcBQQlbQmV3t0RyjpVg7s/7NhmynjhtglqOIfBahaewHkqNt/gv/xxzWIIbHUTMBIO9fr+kF5g1+x4GXQsrKitu2BK0zE1WKq9zKU6etn1xY0JyhhnchA3BMd+vRE4S64f3aXEC6XiYbPoEOnBwJn8kYJE+IyUpp8SMr7gj01IoYLFUuicQKmawOWoEDcmbpOcYAKvFu9XmOgeMejjw3vkAhxmJBsJTaPUXvzD7tULC/r5Wi0A+2RjmdVL0FnoeXNde8vnbNRCsiZIEuvPLBz+gGmf/EqrjQLpCXRH+APkMREwfNCdmw1Pfqgvfv1rI7ycf/Q/VytfwcMZzAjRhW8fIK3xFPNOOp87Q0m4Ya3CeACC4vk4rWYaqN1JXr4JoSBgXiLPjFJqhLsr9MhK3PJQ4JPMMGLIy5qnj7S52MZkI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(66476007)(66556008)(66946007)(2616005)(44832011)(2906002)(8936002)(8676002)(5660300002)(6666004)(86362001)(6486002)(16526019)(186003)(6512007)(6506007)(83380400001)(1076003)(52116002)(38100700002)(4326008)(498600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZTckV5M0xxRFNMUmpCQllSWmtBNmVtN3FuUE9GNElaWHM3aTFTakdYd2tv?=
 =?utf-8?B?YmwxZmMySm9yek9FUWxXMWN1M0JITkFiSkQvVGJPR1puTm9US3JtamNHb0kw?=
 =?utf-8?B?Y1dtV1JMRStzYWpZZjMyVmRyVUY0MTdMbFBKdEJVaUpET0hTaWNLU0VFQjFV?=
 =?utf-8?B?THVHeEh3cnd6WG9vOFlBZUxzNGR5QlFHOTgwUm1rL3krWkVxNlVldVRlWWJu?=
 =?utf-8?B?SjA3VkQ3NFJLcHd0NkZCQ052UmthbEdpdlprMmM1U2R5WVIweXJQUXgvNWl3?=
 =?utf-8?B?ZWtLMGZuaEtPU1RwRXQ3cGxhUlpxY3JhUXMwc2ZWcW1XT2V6SCsrSStHTkk4?=
 =?utf-8?B?SGhoSkJkd0JzZ3hVMWFuS3o3dW5vZ1VQdmRFTFArcngvTE5PSU0yT3RmbjZj?=
 =?utf-8?B?VE82SzAzZUVSMlRJaWxxVWR2cUZaQzlBOHNTYmt1bEVMWVFUQ3JwQ1ExdDhZ?=
 =?utf-8?B?WU5adUlpUThjcURjTnpRa2Z6RnNCS3NINjRlb0g5WHVuRjh5VWh0MVU1TTkz?=
 =?utf-8?B?bVBiV0l3ckViQ0ZvQ0hZaGErL2R6bDVBdXU1ellObUJTNFhremlzUmlzb3VH?=
 =?utf-8?B?WEpIOTRtRk50c2dQWUJYbzBSaW0yTjRRbjdXRC8xTTAwdGdmOXVWTEVYZysz?=
 =?utf-8?B?WGliQWdlQk1qY0FTSlNEbnhubWFlQ01USEY1bVhnNi9uZEZjQjdYbThrTm1y?=
 =?utf-8?B?cmNIamFZS204T3hKdkVmVEZPeVB6WGowNU1UT0JDRDlMSDFvbG5Dd0IyUUhk?=
 =?utf-8?B?OWRvOXkzby9pWHIzanlQY2NscHJaUFpvVGw1TkdkZG1vRm0vWUdkeFErMlEx?=
 =?utf-8?B?VTRFbE45Tjg4T0dtZVdvMFg2cHNpcnQ4VGFxTUpBK3hVMTRucTJaaG1NVWQx?=
 =?utf-8?B?MHlSRjdOTzNlUlovZEt5aWFMN0dmaUVQL3hUNkhwSjhPMnVsa2l5T29GVFV5?=
 =?utf-8?B?eHpOM1lqRkJySmc4OGxiNmk3bFFtWVNVdHBYU3lyQVdWV0NkRVZqNnpkM0Q1?=
 =?utf-8?B?Z0F2K0QwYTBkaVJwL0o1S0h0cHY2R3cvMzdvMFhlV0JoQkIyUWduOVJaVUh0?=
 =?utf-8?B?VElDc2swWUEwM3NodWNxZFhwaW1lem96cHp3c0grUlVxaUc5MVhMSkw4d3FQ?=
 =?utf-8?B?ZkFOQ3IxWmlvM3RTa1FMSUY1QUxDQUVObmhLYUxheE1VZ0pqL2VrbmMreWtx?=
 =?utf-8?B?d3gwMG9nVGxLSXNrOEI3eVorUEY1VlcyY0JDUk9xRWNjRExwa054ekpzd1Yw?=
 =?utf-8?B?QVB2M2ljQ1ZTOUVTTWxEUzFFZjR2b3loKy8xeDR6ekR5TW9xcldWdTZuQ1Ez?=
 =?utf-8?B?YzlLRS80L0Q0aVhScGNsQmhmeGhKTEhJa3pmcG9QM2VJZDJjaGQyK1VMa253?=
 =?utf-8?B?M3VQNkFTZlNPT2lsYzQwNGtZQmxVNmFWZGdKcm1hK1J5SW9Hc3A4OGRkOHhv?=
 =?utf-8?B?ZWEzZS95L3VnblFxNi9mMDN2UTlXODZ0YkdmbmhHVG83dm1LdC8yQ1gyZlU5?=
 =?utf-8?B?ME1qRGRLV1FKNGpGZjRKdVFHUW9hMWxkSVdtd29nTjdpTGhIRFJ4Nmxydktw?=
 =?utf-8?B?K1hKdkZQVnZRWkN1bktwUjdITHl3Yk9nMEdZMWJjdWZwYVl6VW5YMm5FQVhr?=
 =?utf-8?B?ZEQyM1FnMEpabU9IczB3OHdaWEk0UzYxS0NMZDFhaDR4RitxaE9udmFpdmhz?=
 =?utf-8?B?Mnh4QjZUQk04dTNOTTgwQkwyZFRZVWV4d1JXZGFYRzFvNHRyZjY0RzFzRFlO?=
 =?utf-8?B?VlFnNEorWTB3ZkFWNTN1OGJnempuKzg3TlUyNFMyYkoya3RnVWhVVVBGQnhh?=
 =?utf-8?B?YmdSOU9nb2F5eHJvNy96eDNMTHl4Y2RUVUZkbkY4VXZCRkt0UTJFdFVWbTlV?=
 =?utf-8?Q?5kIFfjZgcKxmt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebc4f23-3372-4e6f-b6c5-08d9359a2b0b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 16:24:11.7067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Axa7N/HDGFuKLBavKBBS1vfSSvlfAVWBVvAqUM9y/nisQlbdT++k2R5HcQXI1xwZUft09bVsH3J/pOTDpwiKYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399
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
Cc: ckoenig.leichtzumerken@gmail.com, Lang.Yu@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKV2hlbiB3
ZSBydW4gb3V0IG9mIEdUVCB3ZSBzaG91bGQgc3RpbGwgYmUgYWJsZSB0byBldmljdCBWUkFNLT5T
WVNURU0Kd2l0aCBhIGJvdW5jZSBidWZmZXJkcm0vYW1kZ3B1OiBhbHdheXMgYWxsb3cgZXZpY3Rp
bmcgdG8gU1lTVEVNIGRvbWFpbgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90dG0uYyB8IDYgKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwppbmRl
eCA3OWY4NzU3OTJiMzAuLmI0NjcyNmU0N2JjZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV90dG0uYwpAQCAtMTQ5LDE0ICsxNDksMTYgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2V2
aWN0X2ZsYWdzKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sCiAJCQkgKiBCT3MgdG8gYmUg
ZXZpY3RlZCBmcm9tIFZSQU0KIAkJCSAqLwogCQkJYW1kZ3B1X2JvX3BsYWNlbWVudF9mcm9tX2Rv
bWFpbihhYm8sIEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0gfAotCQkJCQkJCSBBTURHUFVfR0VNX0RP
TUFJTl9HVFQpOworCQkJCQkJCUFNREdQVV9HRU1fRE9NQUlOX0dUVCB8CisJCQkJCQkJQU1ER1BV
X0dFTV9ET01BSU5fQ1BVKTsKIAkJCWFiby0+cGxhY2VtZW50c1swXS5mcGZuID0gYWRldi0+Z21j
LnZpc2libGVfdnJhbV9zaXplID4+IFBBR0VfU0hJRlQ7CiAJCQlhYm8tPnBsYWNlbWVudHNbMF0u
bHBmbiA9IDA7CiAJCQlhYm8tPnBsYWNlbWVudC5idXN5X3BsYWNlbWVudCA9ICZhYm8tPnBsYWNl
bWVudHNbMV07CiAJCQlhYm8tPnBsYWNlbWVudC5udW1fYnVzeV9wbGFjZW1lbnQgPSAxOwogCQl9
IGVsc2UgewogCQkJLyogTW92ZSB0byBHVFQgbWVtb3J5ICovCi0JCQlhbWRncHVfYm9fcGxhY2Vt
ZW50X2Zyb21fZG9tYWluKGFibywgQU1ER1BVX0dFTV9ET01BSU5fR1RUKTsKKwkJCWFtZGdwdV9i
b19wbGFjZW1lbnRfZnJvbV9kb21haW4oYWJvLCBBTURHUFVfR0VNX0RPTUFJTl9HVFQgfAorCQkJ
CQkJCUFNREdQVV9HRU1fRE9NQUlOX0NQVSk7CiAJCX0KIAkJYnJlYWs7CiAJY2FzZSBUVE1fUExf
VFQ6Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
