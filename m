Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F49C433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 20:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 879AD61451
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 20:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879AD61451
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C39936E57A;
	Fri,  7 May 2021 20:37:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 700A86E578
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 20:37:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLRVjHCsWoAoJ9xXoiMPukkPLsMvz7Xn2g3KFYrmoGRJCLEpFT5jfAPgZmhbEHLUePOice2B/a6l2WN8HbnfAm4af21AquEJ2DESfpAuq2rCYr/Gd9neSMiTADuK390pjbMSkwNFz39LEJjDdhLAegaz+WF3KDjALM6TQJdjnVSj3vQzmgXI613QursrC41JjkdJX1wHpWrWfK7KI8drzrmnkfQcYQmKJRZ8AOtZvm7kHJGCi4t/lkgIAAUtn6YUmgu1loqDDhYVjJEIpuYX1nyY0KNbk0DM0SeQjDY73GT7D1CRnF6y0zI1X39dkpsHJCXok6mG5FW4atlfWSgNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGKOYMb4k02OlYC1CtDoy4r/l5pT4/WPSH9OjvYZLBY=;
 b=XbimLLMRxexcflskjmiHvRmGMhX9NGzBIoLtZkg76SMpNjcujWfV4O6ijCtz8deuLAxAo0unbW8wk+jOcVK/JJxkTDdOHcgfv10ZpWwEyugp2jpNRfD7WPXOCKBfGMbYBnFowstsAjVD/Me4xl0xC5hKGK8VDPRTummkN72AdBUKula3yRV+MLdKyqrxEAJHNspY3NrfBmUG3zicxMpPNx1ex9CK7r9tCCReL1Iza/jYuT9mw3jwiP6BWStdtRJzkMcsPZr5B4WeCDc6FXBnTMpwdULJtxqg5FYjdTYQ/rudimIXKoMJRG5d0f3n0SVmagywP8gzlZOrfvmflII+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGKOYMb4k02OlYC1CtDoy4r/l5pT4/WPSH9OjvYZLBY=;
 b=fcRTHGGyjHNCwbswlNgR8X1iDLEM5mMoV1Q27yTSrGGAseKTPE2HyyoIG4/aQ38SofYy7YdpyHFPuQ5Vl3aZOYiA9LLMY9q+STop0xFSiezP7Uk4CIAzxjLMuGr2YTFs2IG5nz05VUkXom9Cdgok7x42wXFQYgO763wxGxPs6rc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3869.namprd12.prod.outlook.com (2603:10b6:208:16f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Fri, 7 May
 2021 20:36:59 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 20:36:59 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu/display: fix build when CONFIG_DRM_AMD_DC_DCN
 is not defined
Date: Fri,  7 May 2021 16:36:42 -0400
Message-Id: <20210507203642.552770-3-alexander.deucher@amd.com>
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
 Transport; Fri, 7 May 2021 20:36:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e022a2e-9628-4508-e7a9-08d91197dcf6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB38690C64D8A98D2E2B6BCC77F7579@MN2PR12MB3869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ka6H6LHFVZ73y6Cgdf4EMH8gWycwcoUNKqF+8icewtxe4fNCwAP2D7DSirmXtnkbMBmzKMxovZ8JvzlVo2mUjxgfvpWi4xUY8uSB9rPIMX/cvxR7VTyfsWxTPBoJPtft4LBlJbNq7GeE0VdTl7dqrIf/KjWE/f/NiXSGc5A7t2r5Yhh8iMxitshqsgCPS7T/+dDbZWUcn2NmSph0CJtKWISu1XL9L7MrJPWM6gRJtHRnECZYR2gXqklmiGgKJMFEK1lG1tkzQgQ2Szu1pS2sOj84pvq/A1xX7ZAuixSIXIDsdKmLwTSV56Ga1vi9P6VDo4Ajrg4EMPJn/QIlSLi9a+oADjMWtwc8S/42x/VKkkzQXJ3QAfplmyqmSg6jBaBW/mNJouWpeD568N8OR2BlXKFsBr7Nz/PmEljRxmriGviGuWdH67FM7QdfGG3yXDegZ82ZqmtW3/15FNMfuOsZ0zJhb0dgnyUMzVoe4waH+tUphoj+mEr8hwlAhCg8YEte1s3MnKQnHa0Ap/eNeAP2gfTcCFTUAOujiiA+sEMdnEbKCz7Qs34+paH4hhHfQSfbsRSOKqb4q9++ZCXDiSY90tjURJ/c0lOoF8V5eUJeBKBvLPa5Y/54IgET2QGFcWv4HS+iYqzroqXDzyF46wpR2Qh+VR5vwcP4bS4As4f+KzA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(5660300002)(186003)(8676002)(16526019)(26005)(36756003)(66946007)(38350700002)(2616005)(8936002)(52116002)(6916009)(86362001)(2906002)(4326008)(478600001)(1076003)(66556008)(66476007)(7696005)(6486002)(38100700002)(316002)(54906003)(956004)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M2dacmNRRzByRDk1UDQ3N2xXNHNCRDdXaXdSTlVBWlpLUUVyZThNM0FWWU45?=
 =?utf-8?B?Zkk1TUYzOWFGdmxjdGZhclF0ZmdEZm1aeXU5WVNvdkNwa1hjcDBIQXZ3Q2Fv?=
 =?utf-8?B?ang5RVBOOFJHM2ZTUXVYVjUyVU1PMWpWa2ZsR0NNaFNUckE4b2xlM0IybVZi?=
 =?utf-8?B?SmxaNUVsRlVtSENQUDRXVXZIaWlCbHlRamt1dWdqQ0xna3AxOW0yTTJWN1Qz?=
 =?utf-8?B?T1l1NUdZb0dlbFV5WW5lZ3lEbGdBSjdEbC81NVFFM0Z2WWVYbUpuK3RkOGF1?=
 =?utf-8?B?YnBOTUZib0pvUElJK0FCaEpZQzVZNWZRU0U4RENvYVVkZ2tlRStReDJDdzFx?=
 =?utf-8?B?N0NNU2k4K2xUb2lCM1VyNk5Rd2NaRy8wY1lCT0t3ZVZ0Q2RYNk9aNW9xZDZ0?=
 =?utf-8?B?YVY0VVE2WnAwUmwyTnNhTmo0TUxQY01oc1FOWnJmUnVCbE9vdjMyTCtoeTlj?=
 =?utf-8?B?aExEUDFZYldDcjByUFJ0U3FqZ0l1QkRMdmQ4Ykt3clBXSkRwTmRaUzFDY2J2?=
 =?utf-8?B?S3VRZlpSYjVpUFZIQmJoNjJ1VFFlTlZiQXBsVDNWaUVTd0JaWU9xS2JtYXd3?=
 =?utf-8?B?T29pcVhWMTJKMkc0Q1p2NmVzUTRoSy9GenBRakoyTTBsNHQ5SlZBeU5NWUxw?=
 =?utf-8?B?TUw4R3VoV24wK0lhbGpLUU9CNWNYQjJSeHRFMzdhckMveVFHYVRpRmtCZE5k?=
 =?utf-8?B?bG1vdXNqaFRmbjFJcXJaUXRuTWJDS1FNYmtEeGhCT0R3aitmTXhFZ0M4VFZE?=
 =?utf-8?B?ZHhzc2hMSXZQZHZDcjNQNjY4UW9Tb0FSWVl4N2c1MHlxYjBQUXh5dDZUSWdU?=
 =?utf-8?B?c2tPRHhPa3ZGVHkvdTBhUERqRXh6MHVLNGM5VEJleXROVkNscjhoQjdtV1lp?=
 =?utf-8?B?VHowOGNSNEFDV1hZOUlzajlOQWNVRG1NdUVUa3ZCR1VvRVVLbWNlTHdDT1lt?=
 =?utf-8?B?cjNMMEpvdm9ZSERaQ2tOaTYxK3JOamhESGZKM2VYb2k3Q05MZkM0NXdQQ2hY?=
 =?utf-8?B?ZC9SRkM0cFBhcHpqalNTSitDNWdrQ00xT2ZsSERyRDNpQmI2ZDJuRnpoaTdj?=
 =?utf-8?B?WUkyd3B3WXlvWkUxMHVUb2ZDUDlvY2ZlQS9zQlVOSzFTcHRmQjZUSHdiZW1G?=
 =?utf-8?B?ZUlpMXZtaFhXNzZkVjZqTUh1R2krZ1VOb1YrVEljaFM1RG16WFlNU1h6V3g4?=
 =?utf-8?B?OHk5b3p0dEVvMnNxaGhhVitDWWVKczlTVDIwUy9uUzlucTdZdUQ2ZzVZVTRm?=
 =?utf-8?B?WktQWnk3Ymg2bURQWkhyZWF5K05XbHJZb2ErbFg4Y2lXb2lHRGpicndJeHFo?=
 =?utf-8?B?OHFoUk5oc2FBTGF0WGIwbklrVnBBcEx1a09NNDNwUDg2ZlVjNWNPdGd4TjhO?=
 =?utf-8?B?aWhhcSt6bnFuY3pOaGxnNytaK3RvZE5SOVkyWmJqcUxvK3ZlTFYxWCtlUUV5?=
 =?utf-8?B?WE9PVllhQytvM0ZLTnBoU3FGakhxM3lSS1BkTXdsK0FIb0MzbE5aMS8ybjQz?=
 =?utf-8?B?WTA4SmJXaEthM0RiYkxxUFFncWxFdG9JdDRXOEtIQk83N3JYNG02VW84VUFa?=
 =?utf-8?B?OG5sTW9wU284MzFRWE1EeFVZU1dsdm5YQWxjZHBVcjJDM0hwNFhVMjRCcElU?=
 =?utf-8?B?SEI3Wm1aY2gvSks4RklaSlY3L0VmZEtzQzEwNklsL3hLVVhFR2lVU3FYZzZa?=
 =?utf-8?B?bkxnb25DSjgvcURyNTA2a3BVdE9sQXRWODA0b2hVOCtMblpDR2hrRkZmZFd0?=
 =?utf-8?Q?TAKaKFz06jwigD+E0FfmzM5TPqOoWOiZHLPdbX4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e022a2e-9628-4508-e7a9-08d91197dcf6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 20:36:59.5882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4bizZGVRoyZOqHwdufnVQCw3YB4fp1f4S6tW8eMl1LnRlsuK3PD2Y29q/MvnJVvwYYZjPD9SRtM6y9jnJNWlA==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jude Shish <Jude.Shih@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXM6CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbS5jOiBJbiBmdW5jdGlvbiDigJhhbWRncHVfZG1faW5pdGlhbGl6ZV9kcm1fZGV2aWNl
4oCZOgpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2FtZGdwdV9kbS9hbWRn
cHVfZG0uYzozNzI2Ojc6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDi
gJhyZWdpc3Rlcl9vdXRib3hfaXJxX2hhbmRsZXJz4oCZOyBkaWQgeW91IG1lYW4g4oCYcmVnaXN0
ZXJfaHBkX2hhbmRsZXJz4oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlv
bl0KIDM3MjYgfCAgIGlmIChyZWdpc3Rlcl9vdXRib3hfaXJxX2hhbmRsZXJzKGRtLT5hZGV2KSkg
ewogICAgICB8ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KICAgICAgfCAgICAg
ICByZWdpc3Rlcl9ocGRfaGFuZGxlcnMKCkZpeGVzOiA3N2E0OWM0NTg5MzEgKCJkcm0vYW1kL2Rp
c3BsYXk6IFN1cHBvcnQgZm9yIERNVUIgQVVYIikKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogSnVkZSBTaGlzaCA8SnVkZS5TaGloQGFt
ZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG0uYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwppbmRleCA3N2Jk
ZTU0Yzk1MTUuLjhlZTljMDNiZjI2YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCkBAIC0zNzE4LDYgKzM3MTgsNyBAQCBzdGF0aWMg
aW50IGFtZGdwdV9kbV9pbml0aWFsaXplX2RybV9kZXZpY2Uoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCiAJCQlnb3RvIGZhaWw7CiAJCX0KIAorI2lmIGRlZmluZWQoQ09ORklHX0RSTV9BTURf
RENfRENOKQogCS8qIFVzZSBPdXRib3ggaW50ZXJydXB0ICovCiAJc3dpdGNoIChhZGV2LT5hc2lj
X3R5cGUpIHsKIAljYXNlIENISVBfU0lFTk5BX0NJQ0hMSUQ6CkBAIC0zNzMxLDYgKzM3MzIsNyBA
QCBzdGF0aWMgaW50IGFtZGdwdV9kbV9pbml0aWFsaXplX2RybV9kZXZpY2Uoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCiAJZGVmYXVsdDoKIAkJRFJNX0RFQlVHX0tNUygiVW5zdXBwb3J0ZWQg
QVNJQyB0eXBlIGZvciBvdXRib3g6IDB4JVhcbiIsIGFkZXYtPmFzaWNfdHlwZSk7CiAJfQorI2Vu
ZGlmCiAKIAkvKiBsb29wcyBvdmVyIGFsbCBjb25uZWN0b3JzIG9uIHRoZSBib2FyZCAqLwogCWZv
ciAoaSA9IDA7IGkgPCBsaW5rX2NudDsgaSsrKSB7Ci0tIAoyLjMwLjIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
