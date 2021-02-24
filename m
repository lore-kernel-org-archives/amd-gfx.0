Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF74FC43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5B464ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5B464ED1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9986B6EB67;
	Wed, 24 Feb 2021 22:21:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDD216EB63
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fD1IYr4+ZZq1SPUKrS9T1uKqzv6ZGZRqzG0an3F+D8iJd4vRYCYiSAuSveKDEoHAFNyhnnqUORIMwgRge4D9OYjqWYkXzxvh67DEnRPW2gke9OSIksoX4rSvp/Rbnwik4atAPwDCvoH6koObD53ZPvhkQe66CmvjhIFBinMPMxxesWMdJzA6DgyR9mUieUzNtkq3XsqM08xIT1GSH3Di4kKJDXKVtli7dXo4iIM122EjOkYu9f4HQtZKRg546YDWzijxTB1FfdtxP9r0JsLhSY6Djy1HzBWpuB6BhNRlAZxfx3CJdqvJiQskHWyOtBhOLGJX7qB4pFZ8k5/XYhy+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TelXOYYynbgI7Xgtv68yI7wS9IR9w0s+gjNz7IVwaU8=;
 b=ScNqaKjwdW0/21/YQinq791sTCnilKPMpn+RF+WF2l/9TH81akH8qAsxbQpMzGg7Yvsot17GcAPpDqlUpk+toOpVdxoc8xQL3oEOeLs9qnKkyKW0EvefKYRYM9chKtZ+pyb+ZCxg1FBw63fnx01B2q5BfrkXzToeKiw3Dy4YDLnPbrgL1TFYhuRlymB2Pv3UEHSYXd6xL4xoXxym+lkN4H1iBjfZctmvhzqYzs0PWuQqOESj6ZAkLN+pU/IWeIvVpqNs5e/Gmle2jXGpoFDwhFy/6AIPq07utSzSdNC6BaDDDCosiml51nsT/x1XBhTg1In/yPPSukHVXQgkUfmCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TelXOYYynbgI7Xgtv68yI7wS9IR9w0s+gjNz7IVwaU8=;
 b=fQahWwsc7E53pVx9yK9t5CL8Wnv8LyWwEsOO1eHLRlgYKjcCSZvdxcDzzS5yE/wuDceM3hNUV9/xqnd08Gv5E+ifTnHRlRQtyTOSmpN48ruFAY8l64IfjGSfPcCkoZV++jWMeihi2F5y9YK0ZLpqT88+1x4O2dl95YNuehHZX1o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:21:06 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:06 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 082/159] drm/amdgpu: correct IH_CHICKEN programming for
 aldebaran
Date: Wed, 24 Feb 2021 17:17:42 -0500
Message-Id: <20210224221859.3068810-75-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c75fc238-b338-4be7-1124-08d8d9125cd5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40462AA5B22477CBA98E5DADF79F9@MN2PR12MB4046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voAj87Nvqm+z+Ibycl6olIWDZvLtY6Dz2NIDe90qI8jYCmeT7MC09UPuOf+j4mJNhda1tf1i77ODMvtz8IBgO5nDNeiwm+Nn1QxTEiXeuZuaGtQmWqFq5G8+Wu/MVPJOfCMcnaRLfz1oeCc1IELt1sUC8X+L2I62ADinZNEYh7jS/XOqwdLtZHmiemFmxhfFr2LSWF1O9UaZjv5tVfbkwfRyN1Estt2eTlTL/9+XVoL1ZVBKeAA3JTpQcFev/0DmFnw0FkIPJDXI4OVzFsPzCcT+ja1PFEHM2titXPDh1tdJNW4G9nFiTQqsnu7oWG3Sih4K9/TONDYBPBC7lr7qOKsPSEBag+CtULokmNZ5DtqNzmfCDnZWbHh3QB/tJPIjesh5UoSj8uP6UfCZqNfZMH9+k8RVT+qCER98aIXfv2BPN46iEHTjdXtj8K7rRXQLUlrQTyE4OX4Gz5ul2teKeooNjmq7mG5JnerDwYHBy+Oty//6Un07qwtd+dlJHB8ewDEnfd1TpbYLDLmIHZAKVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(86362001)(4326008)(956004)(2906002)(6486002)(2616005)(478600001)(6916009)(8676002)(8936002)(1076003)(6512007)(66556008)(66946007)(5660300002)(66476007)(26005)(6666004)(186003)(52116002)(6506007)(54906003)(36756003)(316002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MVVyTWNYVTdRUk95em11dzVLK1RPRnFGSWh3bWFEczVSZXBWTHVreUtZVW5D?=
 =?utf-8?B?bWxYbjNvOUhEalFqeVo4SkNVWVRxNXBDdUJMODhzU3VKeXMvL0J1ajZ5d3Zx?=
 =?utf-8?B?ZlFsWnZMSWlST3I0bFMvWnpkRTFLWVZmN3NkNXpQRFNQWUkzcDdoZksxd3dV?=
 =?utf-8?B?Yy9sUDM5M05yOVErYlhYRFZqcHplSHBNeDhQZUZnUURiWkE1S2lhREszYlho?=
 =?utf-8?B?Ylp5ellhUmdGTVlpc2paY0FBdnh3Z1h0blY5S2d2QnFsdXphQXg0cWM2QXh5?=
 =?utf-8?B?d0I1V0RXUzF5OG4wU0xEUUNGR2pIcXNFYUpLcDBPOVh5VTR3c01hRWt4Q0pK?=
 =?utf-8?B?ak4zMzhGY1pOUDNmVGUxZjNOZFMyYThhSE9OQXVseVYrbkE4SFo5by91V1B3?=
 =?utf-8?B?ZFRQSjdsQTZEYWNLRHBTeEFzanY0RUo5N1Y0S0x4QkgrWXpOT0IwWGFjSjJD?=
 =?utf-8?B?OXBWUkhnb01HWGlsWWwwV3AwdlVkSkpNNldzWlNVOCtVRG8rcTI3RHpSRlBR?=
 =?utf-8?B?cjNNMVVsTXN2SkRLYUpwaVZadG5USjAzVHBGSnIrSGtCUnBzNGwyQ3pKMVFu?=
 =?utf-8?B?TXVDbkwxWVZ5RFhWK0pJaGxHczZuQjEyOStiMjZvaDNtQk9xYUVURTZ2aWpu?=
 =?utf-8?B?L25qdWNGelo4b0lvVTdlalpuVkR4TWY4VUJ1ZW1KcEpDZ1Azb2pPRmlsMXYr?=
 =?utf-8?B?dWhWdHVBaWlmNnZpZ2xISW05bmtLZDJza1VOZ1k5NEovY2Fxb1hsVjZxUDF4?=
 =?utf-8?B?d2xyUU93d1RhcjN6MDNRRkFaalptSjkxS1Z6YUhIeHFpTUpRdHFJTE52aDl2?=
 =?utf-8?B?QndJczd3R2hBQ3dRNEd3RWY4QmhKclg1YXVoN04yZEtiTXhMUEVXdVBBU1Bx?=
 =?utf-8?B?ZDZMd0owNWxGK1pPQXhPYWlZRzM3NzhsRkFzL2NpbWFkTWZ0cEw0RzVkS0JY?=
 =?utf-8?B?Z0xQSDd1Tm9WeFVBZzEvYzh3VzF2c0RNek9UVjIwZ0JjQk1oVGNLblZvSU5M?=
 =?utf-8?B?Q1RaWTg5d0p5ZTRFV2JqdVpIVnp1cU5lb2JEdVEzenJ4ZHRtdTNMcnZ1bThx?=
 =?utf-8?B?WlFkN3ZBbmc2ZlVXMldENHREK2V2bUV5Vzl2WERoc3ZQN1BQNWg2eUVuZkFG?=
 =?utf-8?B?cU43V0ptamRrU0RPTk1LTy9KUHpzcm9SSzdQN3JuRTR3Z2VGUnBTWUhxRzBY?=
 =?utf-8?B?dTlmK2ovNlFXbjY3bUJDWVZlSWFGZStjdmRzejJlRDFTRVZ5bkwrMGpMY1JZ?=
 =?utf-8?B?VURiWFRCdTJ1dmYrQkZZM0hnblQzTC9aakFSNjl6Y29jLy91a05pTkxiV0dP?=
 =?utf-8?B?YXhXNWwyZFNpcVhjUlZ1VmxtM0VJZ1Q2QmMzU2tqbXU4OGc3RjMvczRSQ2FR?=
 =?utf-8?B?OGZHZm9KTSs2NE5LUlV0MmxvTFhWNnZYUDVMVVBPZUtpYkwvRGJ1d3lQZVRL?=
 =?utf-8?B?dFoxdVc0UEJSYzdYMXM1L0M0bHpSQmt3bnlGWElNTmJzaVFUL1BEUDJOMm41?=
 =?utf-8?B?SUNiVXlPVk9haUJoTExIZFZ2OU0yOTE5amNzeTkrM211dTR6eDNTcGJJTmR2?=
 =?utf-8?B?OTlkSWtqMkUzYkM0YUlzUjM3aHA4c05FVEwvdERTWDBQeXhPTk5YTkFSTFov?=
 =?utf-8?B?cEMrNk1kUCtRMnA0SVNiMHhaVSsyemRyRitROUZqREFTTVVjYkoxYmhUaGlw?=
 =?utf-8?B?S3BOWGpHa01XUkdGeUFtNy92VkMrUS9SOUxzNVRDckFxZXArK3RaRTcrWlcy?=
 =?utf-8?Q?WAHiBeGTz45vR2w9ROhXPI0nrf5uK6/7/FX+NJJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75fc238-b338-4be7-1124-08d8d9125cd5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:16.5002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMQX8mFhF3wyaxONY2aFQrfBUJoKIu7kuqvBZlv0G8VPQo0g0QVucf4x1HNvROYM6tPskTzXzWgvMbKTS4sMnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgoKRm9yIGFsZGViYXJh
biwgcHNwIGZpcm13YXJlIHdvbid0IHByb2dyYW0gSUhfQ0hJQ0tFTi4KaXQgbm93IGRlcGVuZHMg
b24gZHJpdmVyIHRvIHByb2dyYW0gaXQgcHJvcGVybHkgc28KZWl0aGVyIGJ1cyBhZGRyZXNzIG9y
IGdwdSB2aXJ0dWFsIGFkZHJlc3MgaXMganVzdAp3b3JraW5nIGZvciBpaCByaW5nLgoKU2lnbmVk
LW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgpBY2tlZC1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpBY2tlZC1ieTogRmVs
aXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+ClJldmlld2VkLWJ5OiBEZW5uaXMg
TGkgPERlbm5pcy5MaUBhbWQuY29tPgpSZXZpZXdlZC1ieTogRmVpZmVpIFh1IDxGZWlmZWkuWHVA
YW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2EyMF9paC5jIHwgMTUg
KysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2EyMF9paC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmMKaW5kZXggNWEzYzg2N2Q1ODgxLi4wMDQ5ZjA0
OGEzMDUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2EyMF9paC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2EyMF9paC5jCkBAIC0zNSw2ICsz
NSw5IEBACiAKICNkZWZpbmUgTUFYX1JFQVJNX1JFVFJZIDEwCiAKKyNkZWZpbmUgbW1JSF9DSElD
S0VOX0FMREVCQVJBTgkJCTB4MThkCisjZGVmaW5lIG1tSUhfQ0hJQ0tFTl9BTERFQkFSQU5fQkFT
RV9JRFgJCTAKKwogc3RhdGljIHZvaWQgdmVnYTIwX2loX3NldF9pbnRlcnJ1cHRfZnVuY3Moc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogCiAvKioKQEAgLTMxNiw2ICszMTksMTggQEAgc3Rh
dGljIGludCB2ZWdhMjBfaWhfaXJxX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJ
CVdSRUczMl9TT0MxNShPU1NTWVMsIDAsIG1tSUhfQ0hJQ0tFTiwgaWhfY2hpY2tlbik7CiAJfQog
CisJLyogcHNwIGZpcm13YXJlIHdvbid0IHByb2dyYW0gSUhfQ0hJQ0tFTiBmb3IgYWxkZWJhcmFu
CisJICogZHJpdmVyIG5lZWRzIHRvIHByb2dyYW0gaXQgcHJvcGVybHkgYWNjb3JkaW5nIHRvCisJ
ICogTUNfU1BBQ0UgdHlwZSBpbiBJSF9SQl9DTlRMICovCisJaWYgKGFkZXYtPmFzaWNfdHlwZSA9
PSBDSElQX0FMREVCQVJBTikgeworCQlpaF9jaGlja2VuID0gUlJFRzMyX1NPQzE1KE9TU1NZUywg
MCwgbW1JSF9DSElDS0VOX0FMREVCQVJBTik7CisJCWlmIChhZGV2LT5pcnEuaWgudXNlX2J1c19h
ZGRyKSB7CisJCQlpaF9jaGlja2VuID0gUkVHX1NFVF9GSUVMRChpaF9jaGlja2VuLCBJSF9DSElD
S0VOLAorCQkJCQkJICAgTUNfU1BBQ0VfR1BBX0VOQUJMRSwgMSk7CisJCX0KKwkJV1JFRzMyX1NP
QzE1KE9TU1NZUywgMCwgbW1JSF9DSElDS0VOX0FMREVCQVJBTiwgaWhfY2hpY2tlbik7CisJfQor
CiAJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoaWgpOyBpKyspIHsKIAkJaWYgKGloW2ldLT5y
aW5nX3NpemUpIHsKIAkJCWlmIChpID09IDEpCi0tIAoyLjI5LjIKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
