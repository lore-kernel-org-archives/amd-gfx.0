Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E56FC47087
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 10:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C31611BD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 10:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C31611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE0746E3E3;
	Fri, 28 May 2021 10:56:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD046E069
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 10:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDUDK+PsbtNyKTe0oOxuYIBjdUuvpeu0UNDJhE4ZLShY2n//kZMlcHvNhPLdSU6qEM8LmcCFxjL/MQW7V0+shYnE2Wx2VEqRjkTPdlvctJoRnQF4YJp5D5oBGwgEKkqGDxiNc8i5vphhX5sVzgalni3md7SmMgl4AlowEfC48iwAbG8nIXUPjNp35SSwv7r1xfjrrtChrSVmECp8YknYFFLv9QfPTWZl5pjCYb2baj0DmlRp1Z6Y0/sJ44StsCY/rQHT2J5NuhxH0jQRX71tidih51m8w59yNWHD9umzDEVme0sxEUvPeGoo5Iuqx4X90EkAvjFvIXIm5KF02WwK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LdD1mvlb4xa2kTjY1plxX5HhsXrgnJBaKfS61Hk8MY=;
 b=JcgBAq2VK9sOzVCCsFKmKmQ2W9LEjAH9FltEy0IPfu/giWqCG3M4KNOjgga50vPKlBM/5eJUv7RQrjx8NHnVwTetrmG5ohYVnQGUGLUfOmu6cE3/AJ66oIYg/9jl9CyW6+g4+BTvPGY4REC7iU+zyNuOKW5wxra3OXebhMqcZHW59g6zwon4YV/mJthuUfkgTJPtqW60LIhsmBMKjT4CCRGRBQZlFjCC0prGd2Wb8BSpybk6ZWTxtrg0Ij0L9pv7QJY2H8VqWvZs4kBw/e3hIh4chtzcud4EBquefHLjkihgKC19W9PNiI2z3oB/ogOjPSJLP/FdhaGNqVJ40Y/rrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LdD1mvlb4xa2kTjY1plxX5HhsXrgnJBaKfS61Hk8MY=;
 b=mBnhTlH9TMRTWMMOkY0PlV1M/NjD0CPEuwt6cDOo8dqDK9bGwOHEoP/Z4klNHbtHdVVehSEQWpmEVYT5ehLit5j+z9T3LHjps9xnZ7Y0q0G8L6+wQal6VvBXW7sMvRN8RACd29VE1vB67/ikH7DIfuanEBm1/8csPiwn18ztdfc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Fri, 28 May
 2021 10:56:40 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 10:56:40 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/6] drm/amdgpu: move shadow bo validation to VM code
Date: Fri, 28 May 2021 12:56:19 +0200
Message-Id: <20210528105623.28148-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528105623.28148-1-nirmoy.das@amd.com>
References: <20210528105623.28148-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.100.114]
X-ClientProxiedBy: PR3P189CA0081.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::26) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.100.114) by
 PR3P189CA0081.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 10:56:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfef50d7-7c4e-4425-cd9b-08d921c745c7
X-MS-TrafficTypeDiagnostic: DM8PR12MB5416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5416CE13DAF7174FE06FC7E58B229@DM8PR12MB5416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avuv+HjlBa3bD+PObsVdeV6nR6VfxUhU46Ix0c2sPM+02xDTjrG+ePzCuP4FS/9pxVMTRstE3eba3An/6DwsaEucHG2jcO8iPg6nMbhPu1XtZvBiX8Ubn30j13xtn2ooNpqGG+M1IicYBmF/rXKqFz5LctINKoGl89oexPwctNz1ZeDOJcih6eqblTt9M11E1qJgHbvUdFaw5kXXbYpmzfOyCZtaY6QwKEKmQO1yCqsTl5aP0nrIOf7SHHrKHPARMHcOkBw1o2Sv/rQl+Tjb20PJ3sRdbLf1onlfCeRG0twHVl300EfJQk3Jhl4mLoY/a1mqKcv575hjV+CYxpbtu1WQ+s8sFdFrolIpkO5LIHvZNIpnC1d+I++cWWwHXWwAutNNoJ5JNkUDNKefRuS6qGzffBtCIO4AojaQHu5DvDGeS5/cW2PsAvdW1P88+XOJgutExeVEODFdHRGuRbb8YDRF6Xcjir3t8KIrQ3uVHsIODvOkV96LlUX0mztb+ldBQ1FdR3XHTJ49ox+yNgl/9mgTUCBDquHlwok4e9uC1yVP9q0BCRtgQFo3F+geWD0glf83L4w2r8Xn23MFgnvxkGYrl4HD4qwsEhI93ygAqFPyU6N/FKd/vPkL5hyFr9ewx37NSQCLypfCkt690gTIXm+Zc/NtSrYqXsXmgjqWu2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(366004)(346002)(136003)(376002)(6486002)(2906002)(6512007)(38350700002)(38100700002)(6916009)(36756003)(44832011)(16526019)(5660300002)(66476007)(186003)(66556008)(66946007)(86362001)(956004)(2616005)(26005)(8936002)(83380400001)(66574015)(6506007)(478600001)(52116002)(1076003)(54906003)(8676002)(6666004)(316002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NTRpTXl2aTVqaCttRjdXaDg3RzJSMlVkK29oRVNlcUxlbnRlRGxXb1JlYmZR?=
 =?utf-8?B?SDIyMVJua01aSm02aEc0VW4zTEVDbDUwVXg1Vkh1TzFESFJCbThDVXQwYW9J?=
 =?utf-8?B?alBpdlZsdUZSb3pqYWUrZW9HcThsNHlYV3Y4NmZSbXhxRnQvMzNSUW5NbmlX?=
 =?utf-8?B?aFl1WkZHR21ROHJZWU1qNVU1SEFjNnlvK0UweWZqWXZLS3c2elRwM3Rqd2pn?=
 =?utf-8?B?dFNWU29KV2x2cktLQnMrWHBrUitDS0FtY3kyMUQrOVMydUpLUDY5TTBUUVlx?=
 =?utf-8?B?RUNYSFFKUzNCUGt1cnV3ZGNsUTFUMEE5ajNSS3NMTk15ZVY1ajM5RmlvWDhr?=
 =?utf-8?B?THNlMkcvZnBDQ2V4bDBxUjBhL3hnbFpyZnIwc3hST2ZoVlVOelNJUm5zUVpE?=
 =?utf-8?B?Y2VZcUNmU0hJZHcrN0xMc2xrSG1WUGpoWEpkUWwwdGV4T1BRT29ZbUh3UmVV?=
 =?utf-8?B?SWVhdkRjUGJJVVhTdnIzaTRER1Vsd3Y2UGNoNkVTQXBLaWFHS2kxdU1xVFlT?=
 =?utf-8?B?Qk5vTEQ3ZnluNnZyd2dEVk9zNTZ3R0JrT0NYakdqWkl1bWhPanVsMFU4V1A5?=
 =?utf-8?B?Z3VSWWVPNEs5TVdzaHVRb1k0azJaRGQyK0hVcFhXQmlYckp2UWpWZFB2OGtz?=
 =?utf-8?B?T2Z0elNOeHNZb012cVl5bE00SGpBdy83bSs1blRNbW9xQzhlVkVoUWxLSTAv?=
 =?utf-8?B?RXJXZDlNc1BxL09zR0NXVjB6RWNVR3ZiNVR2VW16UFBDc3lhdHpzNzZSWFJw?=
 =?utf-8?B?RFZUTWxJNHlPekYvUy8xNStGUi9iMVh4QmxEc1o3U1RDOEZDcjE1YVpnVDgr?=
 =?utf-8?B?V1N6TjRaY3M0bEZCeVg0bHl5aWl1d0dpa25ISklWbTMxVVVFLzllejVPb0Iz?=
 =?utf-8?B?MVhPcTF5dStNZVB5SXVGSklLR3ExbURkREp1c1dmdXBXVXVxVGdSa0pvTVp3?=
 =?utf-8?B?UmR6enFBUE02elRnL1U4aGs4L0tZeTJFQzgyYU1LZnFzL004blc3M29iV2tG?=
 =?utf-8?B?akgzellkY00wb2tnRGpMaDVEbWxIb0E0VVlnRUlHQndyck9tTjZ5SGJ3Znkv?=
 =?utf-8?B?QWNzdXErNXB3a0R1NzFTNUVMeGNOMDNYNGN1bXYyYS9oM2VRb1R1MWx1MHdP?=
 =?utf-8?B?VVhMU3YySmNFNWdRbURQbjY1NUYwUEEvbGxFYitzTHp4c3hEdkl4RmZxRUg5?=
 =?utf-8?B?bCtvSnhFdzN4NDN2b09LdUpkUnRLQ3lQZjFQb2JsTjNnck4vQjFIck9pZkFR?=
 =?utf-8?B?YVBSOTRTYWMzNWdEMTloSThGRW52eFdnKy9IUXFabzNmVXp6WnREU3lXZTRj?=
 =?utf-8?B?UjRkOWJJNEZZbi9NSkIybk9pbnQwUnVpSnFwejd3dG5KS25vR0NuaWlFR3Zt?=
 =?utf-8?B?cjBLWU9mS052WDRndGc5Z0Z1akt5VllyV2IwMXY2SmRhSE80MFZsdlZvOS91?=
 =?utf-8?B?amJMRzYvOW1WYS8vVUZtYVpzMHN1elpvY3AzdVdITmN1V0RBMU04cnJBcEZH?=
 =?utf-8?B?U2w4L1ZCRmdUYkhQZVQyZW00ZFBUSzI3WUdsTmhGWEc3MVMzV3ZtUlIyMENz?=
 =?utf-8?B?UEQyWjJBWkdVZ0ZjVWhaOFh4cVlEajVTWDVNcUF2bnI0WkNud1BrT1JLTjQy?=
 =?utf-8?B?ODVTTnVRd0RETWUyTERLM0FkTUJ2U3lPODVWVG15aDJhR2tDNVdiWThvYUtj?=
 =?utf-8?B?LzMvd3lORUM1OGlIQnNFZkxGYmY2QWJQS1NBSXdwY21vcUptekFPU09DZzFC?=
 =?utf-8?Q?uclErO/J+HXqBcbPBZky6LxstOJVth3oloexTmf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfef50d7-7c4e-4425-cd9b-08d921c745c7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 10:56:40.3840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yQXT9JrqZ1cjORcH+XyeJPhezUzwRoWlaxQRXizDG104mJgLxWuIX8M78hiX3EOC55tODveBvwa9A7DaHJB6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RG8gdGhlIHNoYWRvdyBibyB2YWxpZGF0aW9uIGluIHRoZSBWTSBjb2RlIGFzClZNIGNvZGUga25v
d3Mvb3ducyBzaGFkb3cgQk9zLgoKdjI6IEZpeCBhIHR5cG8uCgpTaWduZWQtb2ZmLWJ5OiBOaXJt
b3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2NzLmMgfCAyMyArKysrLS0tLS0tLS0tLS0tLS0tLS0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAgNSArKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2NzLmMKaW5kZXggOTAxMzZmOWRlZGQ2Li5mNmE4ZjBjNWE1MmYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCkBAIC0zOTYsMTAgKzM5NiwxMCBAQCB2b2lkIGFt
ZGdwdV9jc19yZXBvcnRfbW92ZWRfYnl0ZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHU2
NCBudW1fYnl0ZXMsCiAJc3Bpbl91bmxvY2soJmFkZXYtPm1tX3N0YXRzLmxvY2spOwogfQoKLXN0
YXRpYyBpbnQgYW1kZ3B1X2NzX2JvX3ZhbGlkYXRlKHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpw
LAotCQkJCSBzdHJ1Y3QgYW1kZ3B1X2JvICpibykKK3N0YXRpYyBpbnQgYW1kZ3B1X2NzX2JvX3Zh
bGlkYXRlKHZvaWQgKnBhcmFtLCBzdHJ1Y3QgYW1kZ3B1X2JvICpibykKIHsKIAlzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiA9IGFtZGdwdV90dG1fYWRldihiby0+dGJvLmJkZXYpOworCXN0cnVj
dCBhbWRncHVfY3NfcGFyc2VyICpwID0gcGFyYW07CiAJc3RydWN0IHR0bV9vcGVyYXRpb25fY3R4
IGN0eCA9IHsKIAkJLmludGVycnVwdGlibGUgPSB0cnVlLAogCQkubm9fd2FpdF9ncHUgPSBmYWxz
ZSwKQEAgLTQ1MSwyMSArNDUxLDYgQEAgc3RhdGljIGludCBhbWRncHVfY3NfYm9fdmFsaWRhdGUo
c3RydWN0IGFtZGdwdV9jc19wYXJzZXIgKnAsCiAJcmV0dXJuIHI7CiB9Cgotc3RhdGljIGludCBh
bWRncHVfY3NfdmFsaWRhdGUodm9pZCAqcGFyYW0sIHN0cnVjdCBhbWRncHVfYm8gKmJvKQotewot
CXN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwID0gcGFyYW07Ci0JaW50IHI7Ci0KLQlyID0gYW1k
Z3B1X2NzX2JvX3ZhbGlkYXRlKHAsIGJvKTsKLQlpZiAocikKLQkJcmV0dXJuIHI7Ci0KLQlpZiAo
Ym8tPnNoYWRvdykKLQkJciA9IGFtZGdwdV9jc19ib192YWxpZGF0ZShwLCBiby0+c2hhZG93KTsK
LQotCXJldHVybiByOwotfQotCiBzdGF0aWMgaW50IGFtZGdwdV9jc19saXN0X3ZhbGlkYXRlKHN0
cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwLAogCQkJICAgIHN0cnVjdCBsaXN0X2hlYWQgKnZhbGlk
YXRlZCkKIHsKQEAgLTQ5Myw3ICs0NzgsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jc19saXN0X3Zh
bGlkYXRlKHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwLAogCQkJCQkJICAgICBsb2JqLT51c2Vy
X3BhZ2VzKTsKIAkJfQoKLQkJciA9IGFtZGdwdV9jc192YWxpZGF0ZShwLCBibyk7CisJCXIgPSBh
bWRncHVfY3NfYm9fdmFsaWRhdGUocCwgYm8pOwogCQlpZiAocikKIAkJCXJldHVybiByOwoKQEAg
LTU5Myw3ICs1NzgsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jc19wYXJzZXJfYm9zKHN0cnVjdCBh
bWRncHVfY3NfcGFyc2VyICpwLAogCXAtPmJ5dGVzX21vdmVkX3ZpcyA9IDA7CgogCXIgPSBhbWRn
cHVfdm1fdmFsaWRhdGVfcHRfYm9zKHAtPmFkZXYsICZmcHJpdi0+dm0sCi0JCQkJICAgICAgYW1k
Z3B1X2NzX3ZhbGlkYXRlLCBwKTsKKwkJCQkgICAgICBhbWRncHVfY3NfYm9fdmFsaWRhdGUsIHAp
OwogCWlmIChyKSB7CiAJCURSTV9FUlJPUigiYW1kZ3B1X3ZtX3ZhbGlkYXRlX3B0X2JvcygpIGZh
aWxlZC5cbiIpOwogCQlnb3RvIGVycm9yX3ZhbGlkYXRlOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uYwppbmRleCBkYTE1NWMyNzZjNTEuLjZiYzc1NjZjYzE5MyAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAgLTY5Niw2ICs2OTYsMTEgQEAgaW50IGFt
ZGdwdV92bV92YWxpZGF0ZV9wdF9ib3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVj
dCBhbWRncHVfdm0gKnZtLAogCQlyID0gdmFsaWRhdGUocGFyYW0sIGJvKTsKIAkJaWYgKHIpCiAJ
CQlyZXR1cm4gcjsKKwkJaWYgKGJvLT5zaGFkb3cpIHsKKwkJCXIgPSB2YWxpZGF0ZShwYXJhbSwg
Ym8tPnNoYWRvdyk7CisJCQlpZiAocikKKwkJCQlyZXR1cm4gcjsKKwkJfQoKIAkJaWYgKGJvLT50
Ym8udHlwZSAhPSB0dG1fYm9fdHlwZV9rZXJuZWwpIHsKIAkJCWFtZGdwdV92bV9ib19tb3ZlZChi
b19iYXNlKTsKLS0KMi4zMS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
