Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393E7C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 20:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D032861451
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 20:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D032861451
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D342A6EC3E;
	Fri,  7 May 2021 20:37:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46FA16E57A
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 20:37:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYrna7UWfvQ0pW9VU16qWeh+hMrLWJAIqMMf2nxFRC05yaDw4VyVDneaRgFUr9xTnQEd55Js1YlqsA8cWCEonwDI7BKy9jRjcJj09P9bCrgbSnBDIxOuOBZLHUcjMGZMfpq7McZGLEoK+Bw1hyQo0NPW0z3EiWFPsjQmjBHLgU4sMNC3pkl8pKwq9EpYnLdhIksY/giZsKJl2QEO0vmTOtOiQYcg3rd1uBiTmwJXQgTDb8vivs51lHBstXI8aYk01J9uX0Io5QTHCxTGaKgvawfeS36FxL6Kk6km3FJNNxYZwuRLkthYKJf6kfWAJAdsXID02bNI0YmMbwSO9bF0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8qqeFJ1GgvjEb13BuMCuDjKSxiLcDX0RCYtep2BShk=;
 b=E2mN1nozv4IGwiQv0xcXb5xV7qdh8VLJD2iMQRoVzLg/AywIXnxVctABlodo2HsO8e38rG9QbX0AW9cPfqJk18joiCHpCBAp+RY+y49ZnL3q4bwu9FpD4Yf+n/FWX0fEAjsRSulkGUkY4AmC1V6XqFSHTVoX1/vEqzpuUrIrkIEZY9BjFAhj9A/SW7Vk/xQjDpUDO6WktVRD52kyUjPA1bfi2WXgM3+sgNDctRoWYS/asNxyKnVM4ihTW7NU3Zss18VH7qYjwC/YX/JiH0G3BH8RRTtjZKVEvClNZTHbOFdWSrE1Og6+7QulqShosdsPh7/NrPqrI9aVJ2Xp4H1c4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8qqeFJ1GgvjEb13BuMCuDjKSxiLcDX0RCYtep2BShk=;
 b=FhJuVFfmY037j7aPS8bxSjTRxkdC+jYa6LeWdnGb46m4Jgqytk37Ms6YKSZK6BzvAAZiBU9s3xGZYSwxFpxEjmia8W1N6GRKS+TC2unDIRoCnKJHabhAzTHUXW1PKMJuFJNZs1e9Txq4ChuXBFzZMKgSTSeDC2FPn8ROUdy863w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3869.namprd12.prod.outlook.com (2603:10b6:208:16f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Fri, 7 May
 2021 20:36:58 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 20:36:58 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu/display: fix warning when
 CONFIG_DRM_AMD_DC_DCN is not defined
Date: Fri,  7 May 2021 16:36:41 -0400
Message-Id: <20210507203642.552770-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210507203642.552770-1-alexander.deucher@amd.com>
References: <20210507203642.552770-1-alexander.deucher@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: MN2PR16CA0061.namprd16.prod.outlook.com
 (2603:10b6:208:234::30) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR16CA0061.namprd16.prod.outlook.com (2603:10b6:208:234::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 7 May 2021 20:36:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7c8eab9-1245-420b-891a-08d91197dc8e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3869155B3D53C86777540975F7579@MN2PR12MB3869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dye7fVdQnnhp8y5RM9rNAW2kS8+RflEXW5trcrooFK6kiD740zhzaD3a0LEqM48hFU2SNUJCWN7R3Z5aCN5VzTcPoSng8SMN0LHcWb1a1fNu6gCYzmIXVEJ4O+YthYoPQ/BmE7ZCjtvwGXeJQ6VcYVL8G2XEEifwrUtfTy3LhbSOylGPHFQYo+V7R6DfYVSk+RV4BmeAlsS5KZaAMsGkWKKNGuWbLldOt+OFwD0tbff4U1RWKo4LKkLOFXw4PNFJZRbkIp8Z0+G1MLBhTB7xgPXTRt2E8bL8+8FlCKHGgJih0euJsueCJPN79LNWS5m9OqmrPzNRmoSw16c34rXSojBNEYClMOWTOeKsPGYAh5S+m2g6FkuGBgRPmZk0pF3TZas5QKe4D44uFJOct2/BWHpFGS1yoDFwWcmaBLV9cgXfRx33UKNxPEZ5AVo3CCKM/90m+llDFWMvF+Z8jwpBzBzbIqRrcmQCkMaitbaqAaIcn18H+vvnjs/IXXUly+rIA9EAG78wSfO+v7GHLg7NEuorGFXAO83OJXXabVH+JBGHq0jU4SK8bVknhU89uHjy/w5vX7cyceJYyZtSHlJgWMUAaVm+J6UEcssUaVeRDdk0ZYQ2sZjn/lexcJlMCW6SeVpraRx3J0EhYnZ/X4M78FQkc6oDNlweCVOAcVssgiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(83380400001)(5660300002)(186003)(8676002)(16526019)(26005)(36756003)(66946007)(38350700002)(2616005)(8936002)(52116002)(6916009)(86362001)(2906002)(4326008)(478600001)(1076003)(66556008)(66476007)(7696005)(6486002)(38100700002)(316002)(54906003)(956004)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V2VEckpCMjVuTzJnampPaWJrRy9iQVduajRtZ0JsZkVBb0NqeDl6TFNXRXRE?=
 =?utf-8?B?OHF6b1g4ZXJFdkhsemlMVjVVa3BQOUZxblhtR0VlRkFBR1lRUUdCZnJVYWFz?=
 =?utf-8?B?NlRlVlgvdVZRRWh2ekd1Q1cxWGc3WDgwcjJmSUpsTmJ1Vy9nUjdQZjU4c3pp?=
 =?utf-8?B?YWNJdUxReUE2U09zSFBOa002UmxuOWppd1J0MnkxWmRqMTRvOEE3dDJLNUZj?=
 =?utf-8?B?Rkg0UE5ycmNJcUFZaFprdUdCQnZxU1J1ZXFwTGZvZTBER3lWZDdRQ2ZSNmNN?=
 =?utf-8?B?UHZGeFhJUmsyMERSV2VkLzV2L1dKdzgxZTJnNGRVaTJNeWJZQTk4eU4rbDNR?=
 =?utf-8?B?UVhTaFo2Q21QSnQ4UVRaMHZIWnlUZmdMS1hDQnFabzlxSnJsR2d1ZzdvZU1I?=
 =?utf-8?B?R1BibllMMmpXM1p0OEZOM2x1YWJKeFFHNkF1UGh5L3RrT2xZQUh0bXMwRVk5?=
 =?utf-8?B?Y245K05wSEJQcFhReEJKZTdMK0kwRFozN1hXbUVCNFNPL2VLWjByTEF4a0JG?=
 =?utf-8?B?UlQvbGhQQ2MxMU1LNjFYeGs1UndkRW81K3Z3RWVQNXljTW03ZEdvVi9aNU53?=
 =?utf-8?B?dFVpYnZBandLcmRBRFo3Tm1EQTh5bGRwcC9UZTBKME1yV2k5djlIUzFwVE1H?=
 =?utf-8?B?cWN2RTlPMS8xZld6enNBaWlNb0ZIM0FsR3M4R0F4d1hBeEFqNnhQZjlIVHQ1?=
 =?utf-8?B?WmVKdWsvODRBSjNjZGt3RzAreTMraFJTWG9TR0p3bkY3dGFVc3VtTGtPTURV?=
 =?utf-8?B?bCtqTmR4ME01S1A3ekZhdDBacW5pZzNWTmExK3loOGoxM3h1NWN3NTZmM3Az?=
 =?utf-8?B?MVlubkpRM1pXZ1craHZyd0tNTDFkNG94VlFZc3JETlQwM2FVUmZjZ3JYVnp3?=
 =?utf-8?B?ZG9oZWhoL3dsLzRZOS82YTFXcStia0tDVFFjajA1Sm0zdFBoc2U2Y0g1YjlU?=
 =?utf-8?B?L3E5Z2lnZ0ltN012UDMvQXNoYmpUWCtNTnRzR2NhUW1EWUZuK2J6QnQvRjNF?=
 =?utf-8?B?OWFpQkFSTE1jcFB4YWFHUGhNODVkQStzNWVvMlUxRlFZQ2RvWUR4enB6WnlI?=
 =?utf-8?B?ZVVUNnMxUnRRWUdCRW1teEFlWlpJZFlCd3h2bnMvbXpPZFhIS0ltYlJjOGVX?=
 =?utf-8?B?bXZWVm1MTkE2MlpjR1F1Nno5RDJZOHJHbkFzSlJnLy9HMHZmUU54bmpkeUp4?=
 =?utf-8?B?RE5ZOTBJVkZGMlgzRmZETXZDeU5IdS93WEcvRXlQVzZvWkxrTWlSL0NjdVky?=
 =?utf-8?B?TkN2TGVnSjk4R25JYmYwSUZqRmFIY2pSVXlrVnF4RUc4MTdQRE9FNHp4M0Z4?=
 =?utf-8?B?YXJreEhDZnYvY1p6KzJsVk5GWWF3bkc0blRSMUMyMlR1V1pRZ1RqUlhBUnRv?=
 =?utf-8?B?a3Vwd0dPOHJCK3hYM0VJdEtHUUFIQ1A4Q0JVcEdVQzNVK21qS3BET3B5Qmp2?=
 =?utf-8?B?ais2ZUVZVXIrM2I2dUsyWUt6c2t6RUNmUXJ5Y2s5ZGlFMGFHYUpOcjhOYXYv?=
 =?utf-8?B?aG9QY2x5VU53TWpIRFNLa3VGZGw3T0hZNXJVRU9VbjNPNm4zMXg1NWREQ2J3?=
 =?utf-8?B?ckRCQzBzei9XK1FZMUF3anRUZ283WTB0MFpTek1IUFAwT1R0c2YvcllkMlFM?=
 =?utf-8?B?NGJoWnorZ1d4dmNCUVNYbUNMTmJSTGlvRkhNbnl5ZkRCM1I4c0U1bzBEYXF4?=
 =?utf-8?B?MGZSelB1bWNFREpJMmFwTm1QTmtLL3V2NGg2VjBpbWkrd2dBQlU5ZDV0c2t0?=
 =?utf-8?Q?LvAxnA5JPgeWO2tSSCVs4ZYG6F3AgcijjnKiNa7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c8eab9-1245-420b-891a-08d91197dc8e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 20:36:58.8933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBTKzg6hwy38i78wREjcUSnlWqd8IHfrrxkni2x1zyAG8elfs3CKgiJ5TGtLOlwb2uIUFMX/TrouGW49dfiZgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3869
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jude Shih <Jude.Shih@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXM6CkF0IHRvcCBsZXZlbDoKZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmM6NjMzOjEzOiB3YXJuaW5nOiDigJhkbV9kbXViX291dGJv
eDFfbG93X2lyceKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVuY3Rpb25dCiAg
NjMzIHwgc3RhdGljIHZvaWQgZG1fZG11Yl9vdXRib3gxX2xvd19pcnEodm9pZCAqaW50ZXJydXB0
X3BhcmFtcykKICAgICAgfCAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fgoKRml4
ZXM6IDc3YTQ5YzQ1ODkzMSAoImRybS9hbWQvZGlzcGxheTogU3VwcG9ydCBmb3IgRE1VQiBBVVgi
KQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
CkNjOiBKdWRlIFNoaWggPEp1ZGUuU2hpaEBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwppbmRleCA3M2Q0MWNkZDk4YmEuLjc3YmRl
NTRjOTUxNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbS5jCkBAIC02MjAsNyArNjIwLDYgQEAgc3RhdGljIHZvaWQgZG1fZGNuX3ZlcnRp
Y2FsX2ludGVycnVwdDBfaGlnaF9pcnEodm9pZCAqaW50ZXJydXB0X3BhcmFtcykKIAlhbWRncHVf
ZG1fY3J0Y19oYW5kbGVfY3JjX3dpbmRvd19pcnEoJmFjcnRjLT5iYXNlKTsKIH0KICNlbmRpZgot
I2VuZGlmCiAKIC8qKgogICogZG1fZG11Yl9vdXRib3gxX2xvd19pcnEoKSAtIEhhbmRsZXMgT3V0
Ym94IGludGVycnVwdApAQCAtNjczLDYgKzY3Miw3IEBAIHN0YXRpYyB2b2lkIGRtX2RtdWJfb3V0
Ym94MV9sb3dfaXJxKHZvaWQgKmludGVycnVwdF9wYXJhbXMpCiAKIAlBU1NFUlQoY291bnQgPD0g
RE1VQl9UUkFDRV9NQVhfUkVBRCk7CiB9CisjZW5kaWYKIAogc3RhdGljIGludCBkbV9zZXRfY2xv
Y2tnYXRpbmdfc3RhdGUodm9pZCAqaGFuZGxlLAogCQkgIGVudW0gYW1kX2Nsb2NrZ2F0aW5nX3N0
YXRlIHN0YXRlKQotLSAKMi4zMC4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
