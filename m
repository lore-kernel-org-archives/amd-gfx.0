Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16B8C47089
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E6061090
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E6061090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492DC6E128;
	Wed, 26 May 2021 13:07:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E4656E128
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 13:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ry8xxbr9TWUuS1Ovx6F67Uv0FQ0+pYypzbrzD8KJDcuIwDQ+qu+0G0xcXzOgEuYj1Q6cxIocLDPi+ISItXRKKrbviisqWSNrtA4DdMrREYU06Lmz0pMPWMv68tiV0kaJpoaV9Yu3q0+PJxIQypubK/1O5b0yORNr+Gmx97aE+H8COwhEG+2f8lxkV4vJlAbkdphmmczWw/fCvTc3cBNVaXzW7tenG04/FI39murOr//SDiyI4B2MC9rvJs6uSq7BAOeZ1u0RpJHuu54xpTRBletS0nPiZ2gUJAB6afL5i79EakVzIxFIIyMDqjapapCoeajtg3hnXIYdPdSfVB9X2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR6nFvkDE2E1thFJmrMKN9A0gPFHWy0u3zNicwOiuyQ=;
 b=Q63OoW4hBNbFJMhUPpof1mXA9Avwt4B+tZGYYYZunUufFT1AUQmA+6hVGpK5RBpksYebwnjvQjnstv1g124engHe23KnSuF1JunXZ9TuY//cWNMFCUn95NGgVxcDdfm9leaZqrHOzAtcL2fTyMWifG7lr2J0Oy8tGw5B194a66H0lcYQgTBpRhqIWw9MJCxoPqnakjFuMuWzmzJzfRhPpSu6NANOycmGghBuipKVz9b+YcNoZFAdbwHS64b+Zip37NKVnlTI+tp1M6dOkLRa35nnoEF+iZ5G2+pH3t7LpI6h4JzfTgnWZOrBciKPUG0DpHQ5jxWXPmIaEW48chgtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR6nFvkDE2E1thFJmrMKN9A0gPFHWy0u3zNicwOiuyQ=;
 b=K/DzrmfEyPUnyvq2eL02f+T1XdKAV6kpHtgJG3ECcAZzd8r2hxY0Ozb9UnK+mbi93VPCZE5bIAUsCBYgwq5avyOQrlqVprChhH584XIRnhrTCeh6Veb6FAtIgPsO7hdKbxqoqjGBQvaT4lqYj33Ayl6rEcuRfuyjpPWPxf7QnbE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM6PR12MB5568.namprd12.prod.outlook.com (2603:10b6:5:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 13:07:17 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 13:07:17 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu: add amdgpu_bo_vm bo type
Date: Wed, 26 May 2021 15:06:54 +0200
Message-Id: <20210526130658.4237-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.98.218]
X-ClientProxiedBy: PR2P264CA0047.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::35) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.98.218) by
 PR2P264CA0047.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 13:07:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2e9290b-df99-4954-b7ef-08d920473008
X-MS-TrafficTypeDiagnostic: DM6PR12MB5568:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB556899E46252DDEBE231ECE18B249@DM6PR12MB5568.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFEkjvzswD4MKWka8KcidvU5DMqzYEAw8CLyeNBM2Cl/UzvdbvYTg08yR/3JN2NgpesVB7SKN4noChO5EwWyOwccw362jiD5XAPKKsALLcV1P9zMbKkaw9FRwtshPaf6hYVl6hAy/pUA5k9XwFO9HTJgUML+eumKWKHY5bRBPTeUt9BueSslPVyvn6Z4SM2kNvC3hDs2cPdYWJQcMCB+iWInMfMlxR4qk3wlNzAdTLUm9Dp6Ua1l2GEiQA5fcXzEhX13aZvbHjxDtp5g87G0fNn3wdbhqTZAuzOzd3ZrIDCGzgvgSPWwj8GeMJloiD++JG130Qd0iz8NUR23stHqIw3JR6R5EOeryXWiH62ky4UVZJ2iWsHixppIjoyciOISV7smiOuWuoZ+3Jcd66dU4iI8PCL987Os+GGdZaytXuz+xHBJAJBfhxfJwphg3ofTCxweCCxE135W7UHd56/kBova2/pCJA5nSJMktB9Sm+Psn7eqG2msqINOvqaxrA4sCivcEtX3++ke3HtrZiaBIQNI4jpch7mM8cj1NPYLQsYszdXOE+IijbQp2rkytmSu6u7ZjtPpxK7uSoFhI0G3oPJtaH0QapIOKyK0zFRDjVW0zrOmaeztUBgT3fV1pVs6rhT1O34nmDzJqYju2g99V4jlxB40WGCsvN975kg6uOU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(8936002)(54906003)(86362001)(6486002)(38350700002)(186003)(6666004)(44832011)(83380400001)(478600001)(52116002)(38100700002)(6916009)(66556008)(956004)(2616005)(66476007)(316002)(4326008)(66946007)(16526019)(8676002)(26005)(66574015)(1076003)(5660300002)(6512007)(36756003)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dXRKTlgrWTd4SXBDNHdTSHdDRktod2h4cHJNR0crWmNVYkMzcWo3VHB0Vldt?=
 =?utf-8?B?MEw2VFhzMVVxb0tLUDhOWDJtaTdPWktsUDZBNmZ3a0tsSzZmOVlSeVNmRjRJ?=
 =?utf-8?B?Ym5sSjBOLytnaHdNdERBNUpGT0gzRXUvdGt0b1BjTEJ4UEtJQW85YWJtN3Fr?=
 =?utf-8?B?cHhFMzZOeFJuMXdYa3BQN1VTeDhkc0NiajUwOE5SblBNNDhWM0F0WlUzTTRD?=
 =?utf-8?B?eW9SMmMzeGNMdGI2Z3R5NVc4dHpoMlRMWHBWd1hweGRDOHJ1VDdTUDd6R0h4?=
 =?utf-8?B?Q1FXOVB1NVVYUE53SW1tN2w1UzltU0ZVN25ONVBOZ3gvZ01PZ0cxNDlBSTB0?=
 =?utf-8?B?WS82NzZZeDVXRDU5Rk01UW9sNHE0ajA0K1pTdEl4NGlhblg3dFU4OTJXLzJz?=
 =?utf-8?B?ekFGZzJBWHZwQVphRE5IQ0YwdEhOaWJMdFVyWld0NHpLcDJ4RE5rTExFL1Ez?=
 =?utf-8?B?MGtISFdFUEVjc0tvMUhCSXJuU2U2cmVxVmdtS1lBbmVnQVJucGhwRjQxNDFm?=
 =?utf-8?B?Yy9wSjI0NUY0NGdUUWR5K0J3RHdQZWs3OUhVRmpjbVdTajFyZnpHNDB6cFBL?=
 =?utf-8?B?eEpmYmdvTHJpbExLVjlXUTEyZDdxVlB3YnlFZFl1QVlnUkdhM1RRVU04YjMy?=
 =?utf-8?B?Ky9kNWFvREd2aUtTZW5PMHpoaWIzSHBqMWVhdkl0ZDhmK3dOcEYxekVRQXND?=
 =?utf-8?B?TjN5ZTkzOEdsNWVhMDFoaENvdkxZRzlMVzRhVWtRT0pzZDZCdnZzWm1ZSnFC?=
 =?utf-8?B?U1RwRm5IUUNEcEQwRWdXSUxoK3dyaWJqczdodHJJYngvMzJ3U2ZpQjJqYTZH?=
 =?utf-8?B?SklHVFFXTURhWk16Z3VQY09wY1dLd2VGTEpLMS9Va2liNWV2czd4VWlwc09Q?=
 =?utf-8?B?TTBFcVpjeC9yeXFkeng2dG4zWFc2YUx4RGFLby9pdWNIK1hxdmtPL0Rtb3g3?=
 =?utf-8?B?eDYwaHB3UHdxY1FmZVFmTExRbGZQb3pIcmdVanp3UnBGcjYzV0cwb0Excm5U?=
 =?utf-8?B?RFFId0loWmVsNFF1bUxDTUlKVVBnbXN5ZVUwR0tkOEhENEk0Z041U2tydHcx?=
 =?utf-8?B?V1RweXdkT1ozb25LaXQ1Znd1cUlxWmQxWTlOZldXQktndVF3S1MrZUt3NmdR?=
 =?utf-8?B?dEs0V290YjhEZzBjUzJRU0VhM2YyazJibGpNbW1Ud0F3ZDErcFNjanFMdmti?=
 =?utf-8?B?NWc0WlFjYjJzRFdtNUNtOWlRMlhUQ2RKOTR2bER5QnhBNEtML2IzZjNPT0pI?=
 =?utf-8?B?WmFtR1lJYVlRV2JxNE5kZHhCU1I2djZ2V0xlYkZTSGpZS25SR1JWN3RPQlFT?=
 =?utf-8?B?NGZkc1BsMzF0ZFRzOVh2ZytBb0FTandtSVFmZm9KQWRnZVNIRUg0RXZQTzBa?=
 =?utf-8?B?b2QvSU9kTUVyeXVrV1dUZGQzeWowWDRsUWJXVmZ4eFdLa2ZMdzhQMWF5ZENs?=
 =?utf-8?B?aDduYncwR3RPUTl2b2djd3ZHeVgrZDBla1N6WGI5RXY0dzdTMndOM1kySlRZ?=
 =?utf-8?B?M09YZGhYSDhFZWY1WjF1aWJIUEhoNjBsTkprTXUvYU12RUdvMXlBWFRzVVVB?=
 =?utf-8?B?cVJPMzNhY0t1czY2MGNkaEE4OHdBWGt0dDh6TUozd0RTR3VhS3RVczhXb2hs?=
 =?utf-8?B?dnpTRjZOcFdjVUtiM3IvdDMvNWJiL1YzdXJFdEdmaUU4T25xM2lXb2NIUTVE?=
 =?utf-8?B?RENCOWZCeVE0YkRjdXVVNmNTZDhEZFY1cjR2c25VUVZvWGFIdFRCZHZEblNo?=
 =?utf-8?Q?l+RCNAC57jWAragcvU/14Cgc+QsW6rcoLMpn97v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e9290b-df99-4954-b7ef-08d920473008
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 13:07:17.1086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkJ8+xqvO8d5ZKTtWZg5uHJUMHuu18/Ctc003z1+EJ270VYziQ/MMi6yEbuLcjI7+kW9U1SHUYbev3/gwGtmQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5568
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

QWRkIG5ldyBCTyBzdWJjbGFzcyB0aGF0IHdpbGwgYmUgdXNlZCBieSBhbWRncHUgdm0gY29kZS4K
ClNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KUmV2aWV3ZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgfCAzMiArKysrKysrKysrKysr
KysrKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmggfCAx
MCArKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKaW5kZXggM2Y4NWJhODIyMmVmLi42ODcw
Y2MyOTdhZTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9v
YmplY3QuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMK
QEAgLTY5NCw2ICs2OTQsMzggQEAgaW50IGFtZGdwdV9ib19jcmVhdGVfdXNlcihzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKIAkqdWJvX3B0ciA9IHRvX2FtZGdwdV9ib191c2VyKGJvX3B0cik7
CiAJcmV0dXJuIHI7CiB9CisKKy8qKgorICogYW1kZ3B1X2JvX2NyZWF0ZV92bSAtIGNyZWF0ZSBh
biAmYW1kZ3B1X2JvX3ZtIGJ1ZmZlciBvYmplY3QKKyAqIEBhZGV2OiBhbWRncHUgZGV2aWNlIG9i
amVjdAorICogQGJwOiBwYXJhbWV0ZXJzIHRvIGJlIHVzZWQgZm9yIHRoZSBidWZmZXIgb2JqZWN0
CisgKiBAdm1ib19wdHI6IHBvaW50ZXIgdG8gdGhlIGJ1ZmZlciBvYmplY3QgcG9pbnRlcgorICoK
KyAqIENyZWF0ZSBhIEJPIHRvIGJlIGZvciBHUFVWTS4KKyAqCisgKiBSZXR1cm5zOgorICogMCBm
b3Igc3VjY2VzcyBvciBhIG5lZ2F0aXZlIGVycm9yIGNvZGUgb24gZmFpbHVyZS4KKyAqLworCitp
bnQgYW1kZ3B1X2JvX2NyZWF0ZV92bShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKKwkJCXN0
cnVjdCBhbWRncHVfYm9fcGFyYW0gKmJwLAorCQkJc3RydWN0IGFtZGdwdV9ib192bSAqKnZtYm9f
cHRyKQoreworCXN0cnVjdCBhbWRncHVfYm8gKmJvX3B0cjsKKwlpbnQgcjsKKworCS8qIGJvX3B0
cl9zaXplIHdpbGwgYmUgZGV0ZXJtaW5lZCBieSB0aGUgY2FsbGVyIGFuZCBpdCBkZXBlbmRzIG9u
CisJICogbnVtIG9mIGFtZGdwdV92bV9wdCBlbnRyaWVzLgorCSAqLworCUJVR19PTihicC0+Ym9f
cHRyX3NpemUgPCBzaXplb2Yoc3RydWN0IGFtZGdwdV9ib192bSkpOworCXIgPSBhbWRncHVfYm9f
Y3JlYXRlKGFkZXYsIGJwLCAmYm9fcHRyKTsKKwlpZiAocikKKwkJcmV0dXJuIHI7CisKKwkqdm1i
b19wdHIgPSB0b19hbWRncHVfYm9fdm0oYm9fcHRyKTsKKwlyZXR1cm4gcjsKK30KKwogLyoqCiAg
KiBhbWRncHVfYm9fdmFsaWRhdGUgLSB2YWxpZGF0ZSBhbiAmYW1kZ3B1X2JvIGJ1ZmZlciBvYmpl
Y3QKICAqIEBibzogcG9pbnRlciB0byB0aGUgYnVmZmVyIG9iamVjdApkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oCmluZGV4IDExNDgwYzVhMjcxNi4uYTdmYmY1Zjcw
NTFlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0
LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oCkBAIC00
NCw2ICs0NCw3IEBACiAjZGVmaW5lIEFNREdQVV9BTURLRkRfQ1JFQVRFX1NWTV9CTwkoMVVMTCA8
PCA2MikKIAogI2RlZmluZSB0b19hbWRncHVfYm9fdXNlcihhYm8pIGNvbnRhaW5lcl9vZigoYWJv
KSwgc3RydWN0IGFtZGdwdV9ib191c2VyLCBibykKKyNkZWZpbmUgdG9fYW1kZ3B1X2JvX3ZtKGFi
bykgY29udGFpbmVyX29mKChhYm8pLCBzdHJ1Y3QgYW1kZ3B1X2JvX3ZtLCBibykKIAogc3RydWN0
IGFtZGdwdV9ib19wYXJhbSB7CiAJdW5zaWduZWQgbG9uZwkJCXNpemU7CkBAIC0xMjUsNiArMTI2
LDEyIEBAIHN0cnVjdCBhbWRncHVfYm9fdXNlciB7CiAKIH07CiAKK3N0cnVjdCBhbWRncHVfYm9f
dm0geworCXN0cnVjdCBhbWRncHVfYm8JCWJvOworCXN0cnVjdCBhbWRncHVfYm8JCSpzaGFkb3c7
CisJc3RydWN0IGFtZGdwdV92bV9wdCAgICAgICAgICAgICBlbnRyaWVzW107Cit9OworCiBzdGF0
aWMgaW5saW5lIHN0cnVjdCBhbWRncHVfYm8gKnR0bV90b19hbWRncHVfYm8oc3RydWN0IHR0bV9i
dWZmZXJfb2JqZWN0ICp0Ym8pCiB7CiAJcmV0dXJuIGNvbnRhaW5lcl9vZih0Ym8sIHN0cnVjdCBh
bWRncHVfYm8sIHRibyk7CkBAIC0yNzIsNiArMjc5LDkgQEAgaW50IGFtZGdwdV9ib19jcmVhdGVf
a2VybmVsX2F0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogaW50IGFtZGdwdV9ib19jcmVh
dGVfdXNlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCSAgc3RydWN0IGFtZGdwdV9i
b19wYXJhbSAqYnAsCiAJCQkgIHN0cnVjdCBhbWRncHVfYm9fdXNlciAqKnVib19wdHIpOworaW50
IGFtZGdwdV9ib19jcmVhdGVfdm0oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCisJCQlzdHJ1
Y3QgYW1kZ3B1X2JvX3BhcmFtICpicCwKKwkJCXN0cnVjdCBhbWRncHVfYm9fdm0gKip1Ym9fcHRy
KTsKIHZvaWQgYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKHN0cnVjdCBhbWRncHVfYm8gKipibywgdTY0
ICpncHVfYWRkciwKIAkJCSAgIHZvaWQgKipjcHVfYWRkcik7CiBpbnQgYW1kZ3B1X2JvX2NyZWF0
ZV9zaGFkb3coc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCi0tIAoyLjMxLjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
