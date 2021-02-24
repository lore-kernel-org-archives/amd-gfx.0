Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1393C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6411664ED6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6411664ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BCB06EB61;
	Wed, 24 Feb 2021 22:21:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3AB6EB58
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjNSxYG6LwAmT01KuBJN1kU/zi3J6uqLy+ZCuQFGhsoOWh13mHvu5xJgmz3ljtudxY1TOOVZH/Si4PjI+uB9syalu4qhawShxo5pTv9W+RKsgIZc+OxYAO5/VoSuRuHwwa8eQ/Li90kgI8pQV1kFgy3oDO1/698V1C3jcacevk7v3+119YJDHFpYt5r++eI/9CEeWhLT2YfeLC/z2+VzjwOcyH7IFvuAq6xmtYNsVSfIpBPSJaBPjjFEyRDo0KmG7V+A7/fzLGitmZuGIqEkBPTtJg5UKNQB0LS7yGG4Em3wSzkZ2dBWDAgrTb5cQVrJX8rq51dgqmh0Z12OaKLWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aJKp7XC8tfBbMyrBKTm7NitSEV6J2isokGkHsNHPBg=;
 b=TWiF5Wu874NYlGFmkAedahMelmSGoGIdokB57o31JCLg/MU+EesAorEMqDCPX8m9YbA2j2k8RWNeBX9bVEb5jp79jqasDtXdEVg69fDVxYWaLlw/ReVYMoXjNJaRgBDyFz+pB03HLwPRLYsm81oCR/nNEr0jstlTiFvJMe/Ji+0LwlkDddflHqlYpR6lXL3Lq/Lvx+hV1TzHfmOGF8KiQcy0O3eRfzgf42js1XWiSFlVidCLKLgt200y+LI+I4KB3du5U8I9Zv5f/yuQnoEGC2VDto6hAZU4U6SyL6gfC36qHSIBsvEt0JSGpkbPJu9iAEDC5A5Yi8Gj2ixhviSyDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aJKp7XC8tfBbMyrBKTm7NitSEV6J2isokGkHsNHPBg=;
 b=Bc8NvgNjgj3rvHtXybk2S1g30GEZHRuQ7hJxZ2iZYmtB1xXfuBhDuCq58C0nK8agKk9h0YLv7jOyX73g9zpktLdXdewLE0OPJVJ46ycDd1xeFSdoOXky7QsWPd7sRuwP9aaEjc2RXOIQBJSRPtFW3Vsi7r+grDlW4CI7THAm78g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 22:21:10 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:10 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 094/159] drm/amdgpu: set snoop bit in pde/pte entries for
 Aldebaran A+A
Date: Wed, 24 Feb 2021 17:17:54 -0500
Message-Id: <20210224221859.3068810-87-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7dd558e6-6dcc-4eb2-5379-08d8d912631b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB479826DA4468B5238DC5CB5CF79F9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voHPG6x4o2jtbBI6T1Q9d27FuOyD2pZmBTxclAQ3FPBy2Q8/RIx3c1nYim71dKon1JTcEYjxAPRihlopYwpiFAFaebkbLKWA+0h7lI1m1YvNero7w/5/NW4+N1zaiZqV00o+wp3rJpyocIBzGQCMBagEwTFHwDuFgiBWEr0TwvWmDT2CeMq+lNW/P4Q9C3qeJMAwMGijVVunv5IDw7SBbdqmSoV8uBP2ueSQ0QXyCLPTk7nBihJH2laG09mqjl3wepecDKIeg8q/dB0JS4GxTma1hb3/SIAAhVB/JWKjvhOv0BvNVz4lI7Fnwm1+OVnSZDsrOD1Gjm1qf8tpGYlISxKgOExYtH4VXAKmN8XKLeVPi7xk9HqCA/0iRe0Yk7GqRNjHlVC7A4gF1/lIqwDvnbq/8vIdnOGRtW8qA5V2LJgTjly6TI5hMJ3IRvfzAclyb8rkRypxd3GtxCbg12iVSyhlhi628luCmSm3j72HCmeH8J/uY2BwVfvUME/BWCoFASNLAe/NCAEB/fVNOhQwfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(1076003)(8676002)(8936002)(186003)(16526019)(6486002)(66476007)(66946007)(6506007)(2906002)(54906003)(86362001)(316002)(6916009)(66556008)(6512007)(26005)(2616005)(6666004)(956004)(4326008)(36756003)(19627235002)(52116002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NXplRVVMMzFTZWoyOVF6ZnhWS1BFajBqMDJCdC9WL2xDM3M2VEszQngvd2xW?=
 =?utf-8?B?cEVoNzhOYWUySnlieGV0Y0cyak82alZSQk8ySjNUb1NYWVpncHlMN3V3a1Z5?=
 =?utf-8?B?UlhYNXhHZG9DcVcyenlabDd5cUVYdFgyaUpad1c0MTZvZEczTHc3WmdlcGtR?=
 =?utf-8?B?eUF2Z1dSZEVYbUpoNVQ1WE1YRTUzNGNaS01HTXRPZHh6cXVPMG1HbkJnWEd2?=
 =?utf-8?B?d2RIcFppWnJtWE4vejNTZWlOOVcvMFhpeVRwa0c5UWRwcW1ha0Rjc0VweVIy?=
 =?utf-8?B?VG1DV2dlZ1I5WEtkcWUrVTFibTdRenQ0RE52QXFFMHhMNzJ6RE1JQmpsL2U4?=
 =?utf-8?B?TDBMNzJ2SzNMdTMxeWxyREpwSEh4S3I4RVI3N2lVYzV5TGxiR2w5bkxnWFRW?=
 =?utf-8?B?VjZ5MDY4VE9TenlyNW0xZUtibGtBd1BxYWZ0NnVFSmFYa0JRL2l1OXpVTHk3?=
 =?utf-8?B?aDV6bEh1MEJWS0R5R1RGWXBldEpYbFFDSDQ3NHZYZ0J1WFF2UGxDUmgxUm95?=
 =?utf-8?B?OTNlT2FFK1RuclhTbzBzUkFiYWRrL3lpbGI1THNnZmVQUm5HVStsYVg2K1V5?=
 =?utf-8?B?N1VUcmlvVWJUS1J3MGZQYmVNL2x0Ulkza3NBaEhXMXdOOFk3M01FUDgyVEVY?=
 =?utf-8?B?QzF0QWYwZk9HYVVmRDIvKzZTZWQ4WTFaOC9JN0FrZ2RZZ0Qva0R5clBZRGdy?=
 =?utf-8?B?SnJHR2NTZm15aW1uVG1iUGFnWkhMUHhUV1JDVEJBSE5kZzJBNTRvOFZVK3dO?=
 =?utf-8?B?WktUN2ZubkpkMVBYdW1USFNWbEY1OVVJTndVdFYvdCtELzhkNTA4RTEwUGxD?=
 =?utf-8?B?NlhKYjY3azZBSzlJRmJuT1RCRVJyaGRzNDdkOU9MdVBxTDY0L3cwMDRpc2hG?=
 =?utf-8?B?RGlJem1nSzhPZEIvTklJN0ZOa2hWZk9LSXd3b1gwbTdVNkZvZ1dFMlMzRmxa?=
 =?utf-8?B?MXhLUWtnbVZoY2VUTlZISjQvODZHYUhjWDdXNUc0U1dtMnJCazZEUEdNWXFt?=
 =?utf-8?B?RTl6bGFxRUxLOUh3YzJvQzJPYVlDcE1kMVBCdnZYa0FiWExBNTBTUzBvVUll?=
 =?utf-8?B?RE4xR2dZckVXU21CcG5ZQWNLaWtoWjlHWkdjYVp4dTF3eHpSN2JhZENDVlNi?=
 =?utf-8?B?R1NoY24rTU9oMnV1SU1UVlNXV3FyNFMya2dCdDErY215c3pTdjAxbTU2K2Vk?=
 =?utf-8?B?TjBueVRjeHlRazM4VlV1bnFPUGFRWEZQT3BUWW96QzdvMngxSFBJZ1lodzVn?=
 =?utf-8?B?Ny9LYUJBZ05sUndaUEZlMHdsOTAyd3kvbi9vMlRkZTR2QU9Cd21zZGNpZlpv?=
 =?utf-8?B?UEFRT3poUmdobGFNbkdtMmpRT2doOUF4S2Jhb2hKZ0xmVkdha3pOc0ZNL3p6?=
 =?utf-8?B?SDdnOWc4RkN4cmJYTEhyQ2ZzbHQzSGduYjZzQ1RHUzc2NjlCR1RVRkIycmIx?=
 =?utf-8?B?aVNuZ1lKU1EwWEpwclR2aTNSWnpvL3dhdDAxa28zSUxBVlJXYzR6M3Q0U3N4?=
 =?utf-8?B?NXVYa25GMzRxeWlnQ0I3UDZPTWFGMnd2SE1NN1lGWUl3eTJvUkpNRm42V2Vh?=
 =?utf-8?B?N2FtNjRTTmhRaU11YU1sS0hmdjYvbGNVSDRCQjZGZTNCTmFPc1ZmeUlYSHFk?=
 =?utf-8?B?Z3k1U1B1cExUMG43Q0FYb2Ezd1RaM1lBcjhnSmFwMmh5VWxSN0FkRU93VlVZ?=
 =?utf-8?B?ZHVZeXliNVZHZkgzVTh4NDJOcHJPTmkxNWJZczF5c1hrdUdCcE93WHNkMFdS?=
 =?utf-8?Q?RbCczv69SC7SNJy8nvmDFvjjKQ4sEnKmwoOP4xU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd558e6-6dcc-4eb2-5379-08d8d912631b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:27.0519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HyYiMBdK5KhIVRNQq7lxlHnCoW8edUI37085G3rFLRbnXI7/wm2itxFVNh/VXg4gIcKpPKu9dwsRbRkrHQsOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
Cc: Eric Huang <jinhuieric.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogRXJpYyBIdWFuZyA8amluaHVpZXJpYy5odWFuZ0BhbWQuY29tPgoKUGFnZSB0YWJsZXMg
aW4gdnJhbSBtYXBwaW5nIHRvIGNwdSBpcyBjaGFuZ2VkIGZyb20gdW5jYWNoZWQgdG8KY2FjaGVk
IGluIEErQSwgdGhlIHNub29wIGJpdCBpbiBWTV9DT05URVhUeF9QQUdFX1RBQkxFX0JBU0VfQURE
Ui8KUERFMHMvUERFMXMvUERFMnMvUFRFLlRGcyBoYXMgdG8gYmUgc2V0IHNvIGdwdXZtIHdhbGtl
ciBzbm9vcApwYWdlIHRhYmxlIGRhdGEgb3V0IG9mIENQVSBjYWNoZS4KClNpZ25lZC1vZmYtYnk6
IEVyaWMgSHVhbmcgPGppbmh1aWVyaWMuaHVhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IE9hayBa
ZW5nIDxPYWsuWmVuZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3R0bS5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKaW5kZXggOTVkOWVkNDExNTIwLi4zYTJh
OTIyYzZjMWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90
dG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKQEAgLTE1
MzgsNiArMTUzOCw5IEBAIHVpbnQ2NF90IGFtZGdwdV90dG1fdHRfcGRlX2ZsYWdzKHN0cnVjdCB0
dG1fdHQgKnR0bSwgc3RydWN0IHR0bV9yZXNvdXJjZSAqbWVtKQogCQkJZmxhZ3MgfD0gQU1ER1BV
X1BURV9TTk9PUEVEOwogCX0KIAorCWlmIChtZW0gJiYgbWVtLT5wbGFjZW1lbnQgJiBUVE1fUExf
RkxBR19DQUNIRUQpCisJCWZsYWdzIHw9IEFNREdQVV9QVEVfU05PT1BFRDsKKwogCXJldHVybiBm
bGFnczsKIH0KIAotLSAKMi4yOS4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
