Return-Path: <SRS0=MNBo=HS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3EDC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 15:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B46764E0F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 15:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B46764E0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A98189D9B;
	Tue, 16 Feb 2021 15:22:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A538089D9B
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 15:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYii8fluwNjW4qS9Ot6JdvaWKKztSgWDQoGix5C2iYwGRalu3BC4YsONYCoufhmXFKRgyUfqBeMCNHFYS7hVGm9FsQWzvDM6B4PsTgB+psYUe+VQ9+B1ZqUdaSE/zRob36DUyRDpW09A8BlSuQjcbqN5Lc+iQCjmC+rY3dxirLAw+20kduQA8Cs0tLxwVSU8AR7qfVJOPaFMkjXTVhxvzSc0Y0SwJDa5uIU1ZYa+twOGS90ZVhwZDBD3kCCR86azhZk/cvY/2aQzQBhwV+pIa6caWTHd94hLo7Jbjh/VfjlCNfy8naHHem+XxCTatiEQBOi+6Zp+/5W6kaiClUJIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcXGR1DNHBtlvr0hA5rnh/F9ZQufpd8uL+c1wnCUrZE=;
 b=AlkeTx8cUO9nUbcNHriwuG0sute89d/bih8K2/yuNpRPBicGKJNg5DTC/KHOTnaf8K3/foFlGhj+Q4JbzZT7cGNdxGSP/PbdnOzYXOtzIDDTmG3Hdh8lWoi6yD6a51Jhfh8c+MJjz/aupvBw9X070ZmFFnHNKIkbSJS14rGu8p7RreQUKARKV+ZbrZw5pma/04fPwBZlRnWfp0XYnylFvsWGrO9eCMlefi8qMGmpLmg/Sk+w0cKy6D7ipFRpPMzksZ7cHNSafeks86L64khOfWF5flMXMBRe1wE9qa27qpUuggiKpgztjDD1y/ZofjPcKoiJ8RfgFkHJ2E6BdhlTMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcXGR1DNHBtlvr0hA5rnh/F9ZQufpd8uL+c1wnCUrZE=;
 b=O6pjpy3aca5KJsFk4SgdWW+eBXw9yeQESm6Wy+O9Jv5OynkchknT92EvYbpRfi+ntdqx9qWZQUgWa//AXKtM5lujNPFvmRMW00vVvsRDpzbk94DeVqJRraABrb6KYQg/YK7sTWh9/VyiVNnP70aSeF260nZX6a+z0vBKkfCkSEg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4729.namprd12.prod.outlook.com (2603:10b6:5:7f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Tue, 16 Feb
 2021 15:22:28 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.043; Tue, 16 Feb 2021
 15:22:28 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: alexander.deucher@amd.com
Subject: [PATCH 1/1] drm/radeon: fix compilation error
Date: Tue, 16 Feb 2021 16:22:16 +0100
Message-Id: <20210216152216.50637-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [217.86.96.112]
X-ClientProxiedBy: AM0PR08CA0032.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::45) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.96.112) by
 AM0PR08CA0032.eurprd08.prod.outlook.com (2603:10a6:208:d2::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25 via Frontend Transport; Tue, 16 Feb 2021 15:22:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 07214c50-192c-4a72-8ea7-08d8d28eabe7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4729:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4729938E0F643EFEC545DC208B879@DM6PR12MB4729.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZ1EcoDsDvvlPiLMOKCXXlfciQIhOdpG7urej6O8yMVvBukeq9rIoJlXAnYD8R2AxMSw0I4IfpZhxEGCCgJqwi/aC7xLdu2cgn1QeLCTD14D3aDeYbGcN2yLsf7U0BTTSF38ObuFpTqG9RefAhqEoTbiD2OsspZ8SxsNnda3ys3JptqOMXbNQqNEyOR1XZsKP90UVtiWdPGkRD7IxwX6NI6wYPCxtR7PGWmAf5z0mHilxrlTqSJY+dVHXI1gcAJfpH4A8IoM5rX287cyIEmBiYWTqyUWkDINnG+Gq9N9L4PMN6vvswbsDOAUDfjz2v5joJV7eJGHNFrV40BQAjvlzqyE1Xlhu5K6ncfq1ibkOgNGyuV0S8nFMKL255hnpxzhLVNFGttyA+j22x5E28nnLR2Frtd2lnrSDAG4inL56+BBFZwnXUORFhn+/ycWVaDESjYntKb5GlbQ5SfbY/mHemKfvxAXaXxTFnmwrwIwO481EFURGOC/gW4keYN4uH2NBRuqyErC0qg0jnTxqqWppw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(6506007)(66556008)(6486002)(6512007)(8936002)(54906003)(4326008)(36756003)(186003)(86362001)(8676002)(5660300002)(66476007)(478600001)(2906002)(16526019)(956004)(37006003)(6666004)(2616005)(34206002)(44832011)(6636002)(66946007)(1076003)(316002)(26005)(83380400001)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d0M1VG5IUGJKMjk2U3VvS0hNQ3RPWTNmWGFUKzBheDFJUjZrYkJzd3Q1OWhY?=
 =?utf-8?B?bjF3NEVVaU1JYW1zcGd6eEdHQU41REpiY1lzdEY3K3h3U2lFTmFCN21Rd0dF?=
 =?utf-8?B?NGw5NkR5a3U3SWhpWFkveWpGM2grS29aa1praDZaKzc1OUE1SXdwOGFoWWdH?=
 =?utf-8?B?OEc5OW5YUTRpNmpycEllbHNIanpYQXpiSjZ2NVgwVWI0ZFZ2QmQ5ZTgwbC9k?=
 =?utf-8?B?b3BmQUR0QnJ2L0R1VWhWZmVIcUYxbUFDZ1cxSWZlU2ZGS2lNQlFkR2M3S3o0?=
 =?utf-8?B?dXBMQVBGbDhsUm5xZE5xSDdCeUdqR2xZbkhlWEN6Wjg3L29OaDdwY2RCVEpt?=
 =?utf-8?B?Rkl2WDhIcUt4U2FPNGx0L093aDM4b1NxdWYvN1NlRmp2Y3R5NmI3T3krV0Vk?=
 =?utf-8?B?TUR0dXdQSEpkZkN4YzhrRGc2TStyNWZ1M09ZSEVFMURGUWRqdTZlYnNXK2Yx?=
 =?utf-8?B?Z24ySUI1cHRFM2puNkhMQlU3QjRwOElCdzlpUmhsMEZMV3IwZnA1RmN4WG1h?=
 =?utf-8?B?SnkyaEFwWWh5eDUzc2NhcjhVazN6R0tGM3ZPTVRqcU1uR203UGFyN0xPS3Jl?=
 =?utf-8?B?MUFlSFp3QXFCVnZDM0dqYSt1THo0RTM1L2tlaVEvS09VNVJ5QmhDN094MS9H?=
 =?utf-8?B?KzZ0dW9xVm40MDZGc2pOcGY3eTk1dFhIRFBqN1JlL1AvWDU5d2prSXZINFIx?=
 =?utf-8?B?dFI3b3RjZFNKOFJCYlZRdjU5SlRNUzZyYWxHaUVTU1VIQkFoQng5d2c5T1Ra?=
 =?utf-8?B?bU9mRDZQL2t0UStyQzdhSlhQSk43eUs1WmVHL0dUQkxLcGZrZlJwekc2VEhI?=
 =?utf-8?B?UUFiVVhtc3JheTRiUng4Rlp1SnJHdnc0MGpHNjZUQ2ZlVjJwdEs0UjM5V1lI?=
 =?utf-8?B?Ukx2Mk5PK0p3eG80K3FHaWs1dE53NXdlVUZoZHNpK3JyeDNJV0k5ZUYzcHBU?=
 =?utf-8?B?T20zMDBSdytFMXFYSDJJZFVUMHc1Qk44VkRWeVFvVmtjN2VGNUIrTjlZVjRH?=
 =?utf-8?B?ZTJjc0RkZkpLNlFaaVhsODNKTnJCWGphaS9aQldneFhVckhaUklCb1VwN2Mr?=
 =?utf-8?B?Zms5UDRRMW9KWWFaMnl3RkxMa3ZZOXJ6WmQ1c3lPdGwzZ2xkbUl0NUVBMFBh?=
 =?utf-8?B?QTFyQ21sL0NvT2l2aTFxcGQ3S0xNeXk4MjJtZWZ5QnlvclhmRkpzWERFdW1F?=
 =?utf-8?B?cnVJck5TUXRVZ1pPSTF3SnpUQWRUV1R2b1JmNHlTdzBYZ09STkZNeWRDZFEw?=
 =?utf-8?B?cm9ZdmtkZncydFhZVEc4SlFFQWYrQmdKbUMyUUV2eFdhM0hrQnJiTHo3VkxU?=
 =?utf-8?B?aEF3eGZtMzUxbFVDMkRxdjhaTlFQWVRyUnNxYWw2VnNpSVVTSGh5b2hkZVM5?=
 =?utf-8?B?b2wrTFFodmJUOTFyR0lveXJMdy9NUHN2WisyTEovUXlicWhXOTVyTExteEMw?=
 =?utf-8?B?VGlwNEJNYlc1U0Y5MEljbFpERVRRc0dTN2EwbENYYWhZamdPUUcvL0ZBdER3?=
 =?utf-8?B?QmhLN0ZpUFVUTzNMRkxyN0JBQ2RsNUdEUWtHVDB1c2oySnFZUjhRK2VpUmJu?=
 =?utf-8?B?SWNYL1JsVXdWTm5kWTlCYjFRLzVXOWdjbFk4REd1UnlYMUw2QXJpZ0VMbVdw?=
 =?utf-8?B?cVVWZVRJdjJmT05Vc1ppaGdlS2cxYmFLTHIweUhtT1h3K2NzMFNseTA5Rk8x?=
 =?utf-8?B?T1E3OU4zUFBrNE1vc1ZRWndwYlI3bms4bUhjNnlRbks1T1U0REpCM2JqbnBN?=
 =?utf-8?Q?Q+SJ5gz37P0GxVMaa3ImRLBErxIB1HjWs/tIKeg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07214c50-192c-4a72-8ea7-08d8d28eabe7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2021 15:22:28.5552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFHO/nVtHwFttdQzpYAyEt0LM9eD7QwWeTpbJTsuBPMLziLgGtNcqwvvXUlil4jK1YnN04w4sGSqX6XZI2WfTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4729
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org, Mark Broadworth <Mark.Broadworth@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgYmVsb3cgY29tcGlsYXRpb24gZXJyb3I6CmNvbmZsaWN0aW5nIHR5cGVzIGZvciDigJhy
MTAwX2RlYnVnZnNfbWNfaW5mb19pbml04oCZCgpGaXhlczogNmY4NjcyZDY1MjNiZmUzOGUgKCJk
cm0vcmFkZW9uOiBkbyBub3QgdXNlIGRybSBtaWRkbGUgbGF5ZXIgZm9yCmRlYnVnZnMiKQpTaWdu
ZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+ClJlcG9ydGVkLWJ5OiBN
YXJrIEJyb2Fkd29ydGggPE1hcmsuQnJvYWR3b3J0aEBhbWQuY29tPgotLS0KSGkgQWxleCwKCkNh
biB5b3UgcGxlYXNlIHNxdWFzaCB0aGlzIHdpdGggdGhlICJGaXhlcyIgY29tbWl0LgpJIGFtIG5v
dCBzdXJlIGhvdyBJIG1pc3NlZCBpdC4KSSBldmVuIHRlc3RlZCB0aGUgcGF0Y2ggd2l0aCBteSBy
YWRlb24gY2FyZCBiZWZvcmUgcHVzaGluZy4KCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3IzMDAu
YyAgICAgICAgfCA2ICstLS0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXNpYy5o
IHwgMiArLQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yMzAwLmMgYi9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3IzMDAuYwppbmRleCAwM2IwZDRhODFmN2EuLjkyNjQzZGZkZDhhOCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yMzAwLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yMzAwLmMKQEAgLTEzMjYsMTIgKzEzMjYsOCBAQCB2b2lkIHIzMDBfc2V0X3Jl
Z19zYWZlKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQogdm9pZCByMzAwX21jX3Byb2dyYW0o
c3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCiB7CiAJc3RydWN0IHIxMDBfbWNfc2F2ZSBzYXZl
OwotCWludCByOwoKLQlyID0gcjEwMF9kZWJ1Z2ZzX21jX2luZm9faW5pdChyZGV2KTsKLQlpZiAo
cikgewotCQlkZXZfZXJyKHJkZXYtPmRldiwgIkZhaWxlZCB0byBjcmVhdGUgcjEwMF9tYyBkZWJ1
Z2ZzIGZpbGUuXG4iKTsKLQl9CisJcjEwMF9kZWJ1Z2ZzX21jX2luZm9faW5pdChyZGV2KTsKCiAJ
LyogU3RvcHMgYWxsIG1jIGNsaWVudHMgKi8KIAlyMTAwX21jX3N0b3AocmRldiwgJnNhdmUpOwpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXNpYy5oIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXNpYy5oCmluZGV4IDJjNzdmMTUxZWY2Mi4uMWNmMmE1
ZTBkOTFkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hc2ljLmgK
KysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXNpYy5oCkBAIC0xMDgsNyArMTA4
LDcgQEAgaW50IHIxMDBfcGNpX2dhcnRfaW5pdChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7
CiB2b2lkIHIxMDBfcGNpX2dhcnRfZmluaShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7CiBp
bnQgcjEwMF9wY2lfZ2FydF9lbmFibGUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwogdm9p
ZCByMTAwX3BjaV9nYXJ0X2Rpc2FibGUoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwotaW50
IHIxMDBfZGVidWdmc19tY19pbmZvX2luaXQoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpOwor
dm9pZCAgcjEwMF9kZWJ1Z2ZzX21jX2luZm9faW5pdChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRl
dik7CiBpbnQgcjEwMF9ndWlfd2FpdF9mb3JfaWRsZShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRl
dik7CiBpbnQgcjEwMF9pYl90ZXN0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBzdHJ1Y3Qg
cmFkZW9uX3JpbmcgKnJpbmcpOwogdm9pZCByMTAwX2lycV9kaXNhYmxlKHN0cnVjdCByYWRlb25f
ZGV2aWNlICpyZGV2KTsKLS0KMi4zMC4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
