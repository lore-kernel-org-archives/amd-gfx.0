Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F21C433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 15:33:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0002619FC
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 15:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0002619FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E0EA6E194;
	Fri, 26 Mar 2021 15:33:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D13D6E194
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 15:33:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1PexFSVwNsFukrZANXV1aFq4CIb5gL/oAMo1wutho1kke6IOk3ZwuieFBlXcQ7XTu9ozJxpVUsL/+4VxK+0Q/z0oZQWCA7UrulW8vBH1ytIYUBt/rBtL9KaRKCDS6iZsrWtDU0I9OSDi8cDIX3UF8FxZLXD0OGVvir5e7jltRG/ntCaypmiTScPjRflt8TGgIh+jXGyliPABcXaIkNawKGSWV/Pcpcx5MreM7Z7Rgf2Tia/9g/QF/4Ty1Y0JN9OLnwDbpdOithsOaJbIJnOuo0Sx7AfrdVJBqEfW6iRkt4MgzP+WQQPQDsLTosPtI8pJ1+tMFmVkGmjouGs1UZRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laVQEPKxKjHJB5SCJKY67KanzIRe+R6QqLCz0HjH4Ns=;
 b=JdZcS1dZsFk0PLMgdL8qHfiz2ZqzNqYH3hhHXAK0q6KiwOqcj9tLiq8twWeVNuLz6dT1WOMy6oMlIYL7vCIwOv6zdpGODBQq+BFmotOHU5eEDUjNBzV7JJi/onFlk/uFRMC3PofKvhpL2GfPIRwVKIXWWaqcqhkxG0imH28+Dp2ZohKPGDWSalIwm0EaPTzIUFOUc5cFOubekY8lrENUWd5HAUa4y/KtZhxvHDhRLtaXMO8fAxDZ1crNNNYZJPp1xqTu87zDL3j3USw6YnnFJGhZPAEjPF1NThn0jyZmFfNt7TABmxQ2nRr2s3gDemVBpk3lyn1DP3XYwxL3YYzwiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laVQEPKxKjHJB5SCJKY67KanzIRe+R6QqLCz0HjH4Ns=;
 b=nw9sC6pIkwC+qzV0AVducnbYOb4RCxZeGfxC8DSFTdkTFCWx71mlA/dP9X6rlhq2ZkLhxqffmASvpPNN4Lj/mtNS1BLlcpR1ctD4JuIy2MttYmFDrDRpvVKviL3aS5zEyfuICSLaKkPrHI82BmRNa5LdC0GXIW8+u57f/O6OMJY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2415.namprd12.prod.outlook.com (2603:10b6:802:26::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Fri, 26 Mar
 2021 15:33:47 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::c2b:6cdc:4b94:7d9e]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::c2b:6cdc:4b94:7d9e%5]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 15:33:47 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: ih reroute for newer asics than vega20
Date: Fri, 26 Mar 2021 10:33:32 -0500
Message-Id: <20210326153332.4149-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA0PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:806:6f::9) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA0PR12CA0004.namprd12.prod.outlook.com (2603:10b6:806:6f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25 via Frontend Transport; Fri, 26 Mar 2021 15:33:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c77533f8-3a18-4400-0cb9-08d8f06c8c51
X-MS-TrafficTypeDiagnostic: SN1PR12MB2415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2415258A1C5A9CF218273DF1FD619@SN1PR12MB2415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: An98okn/TKwBrQN9P6K+wJfDkEXWezD/3kWJ4dzQAHG31smQUmyQK3XZqZQBhIQGWgWdvza3iNQ7ORy4p7H/q6rNV7f7DlAz58EyErXalI8x9BrVHVSHz9AfNEUgMMCiC0lfZLR+xSr9egW0gZPX2TdYQVlZBYAiKKHATukQV79G76gXEK2k+AWM2M84kCt+AvWsbFXIXphhVLMTXrcl8gagApVL86H8hgi8JV9woAxdkXEk/UOf1hlesWoADVoD0I4FreO6Yx0bYNTWVzoC8UoH+tZ9sEqIVFphXqDuyYV4glbEaRIGeMUc4VPkzgLGP/3EMpplhRSPZAPDirOyes1zpjvxy3+fsSQ1K0Sn5v5gzZ6lgjYz2RKplZ7iW+/jZys6VGoaQwhYWz6SlcWMcTSQkhOBkVfe8yVdo6Ya0G9b6QZ2E/J058Tcl4Xs4ELDsG1exmPR9V40vBfecTJ0pw5H6+f6f+XOMpBCQaENb/QYBFwG1RmTHjmEuKlMAjynwDfOZQXzZ17tueiupE5OiVpA3PVLieY0/quqPVIXGR05hmFmu2bH7zkOT77eP4VpKDyqDc4jyaBKZQ2j8qD5fyDnGD9KaZ1RU8zec/+g55+48NWAv/9KdlI2U3mwQ0LXp0rmkgFKfwLw/X8xDQyR0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(2616005)(16526019)(956004)(6666004)(186003)(6486002)(26005)(316002)(44832011)(8676002)(7696005)(6916009)(8936002)(36756003)(5660300002)(478600001)(1076003)(86362001)(52116002)(66946007)(66476007)(66556008)(4326008)(83380400001)(38100700001)(2906002)(66574015);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TWdmYUI4UG00WFVoR0tZVlBUWm5Mem5vMTcvQS9hMnlPZXlHa096NUp3L2JJ?=
 =?utf-8?B?RnZYdU5OZCtsSStNNncreVljdUtQL052RlFCVE5PdmhqZGdpalRad0dEKzVY?=
 =?utf-8?B?Z3lzVldodkxVYm9adFdhL09FYXhTWDhZYjhIYmRLQmhYNUM3M3BXaVdxYXcr?=
 =?utf-8?B?NERJTTRFUGtEeWJnT3p2NFZVKzkvaGEyMml0b2ZESUgyYUpWd25MUzRrOGpj?=
 =?utf-8?B?VzcvQUxZUHhaeUxDODFjcFpmRUZRV05pNTF2ZkxvUkFiSzdoTFNGckp1OXBx?=
 =?utf-8?B?M2xaTG5hOW5RM3k5Yk5scGk5b1lxYTJmYUZtZ0l4K3plVWNGNmd1RXJvQkxj?=
 =?utf-8?B?eDNBeE1hQUtkdDh0QWZCd20yTDBWaVFMekZVendYZUR6eVdvaFNTeERFV1F6?=
 =?utf-8?B?UzFFSWF6ZDRGU2p6VERUUTc4cnEzM3lRWmIwZlFqeVV4czZHamhmT3lmbDdL?=
 =?utf-8?B?TGgrb1NLVCtwSmZFSGlWTFBzd1ozRjNMUGk5RnlhS1UwT0V2eVpKRGhuaWJx?=
 =?utf-8?B?UG9Rei9zcHczQjFycTI4c0s2UXVZTjlhc3NleGxRbGcrMVRDWmYraXlnOFc3?=
 =?utf-8?B?aDRGWHBHQ3pXenBoRi9sOElEY2ZWT2ZCSDNDN092QUxFRFBXcW5JMGJKeFJU?=
 =?utf-8?B?REttaWZXSTlTTU9UejdGVmgxeUVjSGdZMUZUQklrL0V6MEFFNEw1QllueXVm?=
 =?utf-8?B?aGYydFkzSTc0Qm5aYzZCSllmZ28wQTJlKzV2Z1EzSHRrNzZGZ0Fib2R1UFFB?=
 =?utf-8?B?TkdhSXk3b2FWSWhUWk9lQ2ZZK1ZvL2RVcWtsbHB1K0NpejZIcUoxbXdOUERF?=
 =?utf-8?B?bCtRT3h2UVdKYTM3NWRIaEpxTFFxV3Y1ZmRublY5OEtCY0hoR1Z6b1hGeURo?=
 =?utf-8?B?V1BNMFpRZVh4N2ZZa3BDY1V3Q3lRdEZOM1VheUQxZ0lTbDJweERmR2l4Nnd2?=
 =?utf-8?B?TjVRMURuS2FKNzY3aUpBbFlrSlYxS3JNMkdISkVTakRWOC9xRmE2ZWQyQkxT?=
 =?utf-8?B?ODN4UzgyN0J3eTZjVE5RUmhPWDhJUTJtY0UwaHo5NityRFV6U3lyKzlJOXdQ?=
 =?utf-8?B?ZWJEMjNUUUN6SDNoNXVzaU5vNFpIc1p0ZndCbzZiV1lqRXY4cHg3NExLeG1p?=
 =?utf-8?B?OUZhL0d1ZUltbkUxU1h2MVZGL0tOUjBDRS8wak56TFFiQnErZ1lwTWlxcWFP?=
 =?utf-8?B?R2dYU2xYOTBrVmlMeGJzWFl0NE04SVFDMDkrRkJjRWROUDVMOUJTUHpHQndQ?=
 =?utf-8?B?YkNwY1hTaTZxVDNISHpTeGF4QUV6UUZwRzk2bDNwVng4Z3p5WnlvZndqNkJs?=
 =?utf-8?B?a3czNWpPTG1KMmFQQ3A0aE9OWVBZd3pSd0hxNWU2UEFZUktJNmo5REVXNzVI?=
 =?utf-8?B?MGxydkpDeUJkNWJsV2VSckM0d1BFclRjMDRzemdWTGNnUHBWd3BpeEtPbU9V?=
 =?utf-8?B?TFpGOVV5Wk9tODlqN1E2em50bUZTc0E0KzdrWUVDbnVqcGhmNDRXZ0diMzA2?=
 =?utf-8?B?MG11L3VFOHo0NmNGV2R6aFIzdS8yU3pDVmFlUVJFR3IxZm9rUGRYR3NDV1lL?=
 =?utf-8?B?ZEc0NkJpR0U1MTFHSkV2SXVnRUhVdDVLdWVBa1djc2tGZzZuK0FQTDMzNUIw?=
 =?utf-8?B?TWsySDBXUWRwb2ZmYnlTNGowdDJGbUtsZnBVdEc4bzhyblB0S3RrTTJkcDlO?=
 =?utf-8?B?WlV2b29IOHBXY2oxWFN3bUt3aXdQZ1ZZc2MzTFJlSTRVQnZvd0FLWk14Yndp?=
 =?utf-8?Q?Yz6UIrEf6U/vCiub9i9OSw5bYjWyWWLkI909Oy2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77533f8-3a18-4400-0cb9-08d8f06c8c51
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 15:33:47.5754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lB2RanovRugYs8C2q5zS/pJJQwEmHabgFqrg2FnnkABVlaBf+D+RPQ0DyVWSD68f8bO6Z8UNBzIgsEBpaSbKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2415
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U3RhcnRpbmcgQXJjdHVydXMsIGl0IHN1cHBvcnRzIGloIHJlcm91dGUgdGhyb3VnaCBtbWlvIGRp
cmVjdGx5CmluIGJhcmUgbWV0YWwgZW52aXJvbm1lbnQuIFRoaXMgaXMgYWxzbyB2YWxpZCBmb3Ig
bmV3ZXIgYXNpY3MKc3VjaCBhcyBBbGRlYmFyYW4uCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFNpZXJy
YSA8YWxleC5zaWVycmFAYW1kLmNvbT4KQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcu
WmhhbmdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92ZWdhMjBfaWgu
YyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2EyMF9paC5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmMKaW5kZXggNmMzY2IzNTEz
Yjk4Li44YTEyMmI0MTNiZjUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3ZlZ2EyMF9paC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2EyMF9paC5j
CkBAIC0yNjQsMTAgKzI2NCwxMCBAQCBzdGF0aWMgdm9pZCB2ZWdhMjBfaWhfcmVyb3V0ZV9paChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAl1aW50MzJfdCB0bXA7CiAKLQkvKiB2ZWdh
MjAgaWggcmVyb3V0ZSB3aWxsIGdvIHRocm91Z2ggcHNwCi0JICogdGhpcyBmdW5jdGlvbiBpcyBv
bmx5IHVzZWQgZm9yIGFyY3R1cnVzCisJLyogdmVnYTIwIGloIHJlcm91dGUgd2lsbCBnbyB0aHJv
dWdoIHBzcCB0aGlzCisJICogZnVuY3Rpb24gaXMgdXNlZCBmb3IgbmV3ZXIgYXNpY3Mgc3RhcnRp
bmcgYXJjdHVydXMKIAkgKi8KLQlpZiAoYWRldi0+YXNpY190eXBlID09IENISVBfQVJDVFVSVVMp
IHsKKwlpZiAoYWRldi0+YXNpY190eXBlID49IENISVBfQVJDVFVSVVMpIHsKIAkJLyogUmVyb3V0
ZSB0byBJSCByaW5nIDEgZm9yIFZNQyAqLwogCQlXUkVHMzJfU09DMTUoT1NTU1lTLCAwLCBtbUlI
X0NMSUVOVF9DRkdfSU5ERVgsIDB4MTIpOwogCQl0bXAgPSBSUkVHMzJfU09DMTUoT1NTU1lTLCAw
LCBtbUlIX0NMSUVOVF9DRkdfREFUQSk7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
