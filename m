Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A536C433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 07:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF84613BA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 07:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF84613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 992A16E435;
	Wed,  5 May 2021 07:30:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13A7D6E42D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 07:30:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ky+pwV43PtqcqkTvBextGgDmlXHrBh+UoNtapZ+UTXp5Ox+XGzXryaLQ9c2E2MCZgjE2rmnHDEymTECd0iQPy8zPazjH6sxjkLLwiI9Jbt2yHjwyJcQCj2G6+ONjcYeTHDr6vlXW/xwbmomco4v6dpdlzeDgvIQHXVXz2xnM8ufrRtrN5GfQHsRnvabkioimvQUE/gbU1Po8/b4JdFqJxy+eFbB3Ro+LJVrbHRj5BSuev9jHuTTt46a1DfwLpVX0dAX2G3WrOVkkBXo2fwJyGE3Fl46mlus+wbuITqC6YV7nZP1sFz433Nb664omtsrIo6N0zzWn+GIYEFMuiSHiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26r6OoTzctoj5S2RaVd/qe0Y9GTk7Lj5dNN9abN1COY=;
 b=oeLgVuwcBPeuGUCRu7+NH29b7sjs16lWnEmPQZ4Jvmh89EkohBGbwictpKp6GoKeibfGejtd7e8n6NONWrFPNx0pDbi6NokaG+Z7Wv0FSI2zJCBBcG+QIF0PZTma0vzsdyTW+miG2VeT4fjzJ/EX/Fwr4oT3US3iGnidY1LT7jR3Sn/loM+UpJskAv0F9iVcG42PJqyk6gJnbbGxVE5LZuUROhs9uX72ASspbpxdIBkGnQXO6riE1LmwOd046T7FWN/4BF6SiJvuCcxe+BBF1QPUNC131rwtKhToQmbIbtwYHyiXvSzg4K3ie9v9mg32OUcac+seyDh2ukh4ebUc7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26r6OoTzctoj5S2RaVd/qe0Y9GTk7Lj5dNN9abN1COY=;
 b=q89Wms0J6MnhqXhX8EII8TZdFTsMC8N77ZIcKzdPebFC7Ml7D3MbjJPM2+PxZumR1hURGHBrcbzAq9AYK7ArXDEXLkeC8RbxwCnsQGpklv/hBZUJ01PRc7WOvcHvwsEVdk9YIBZh/b1G7gB9dupcP9LOjVgpauFiTWFii2RkRd4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1866.namprd12.prod.outlook.com (2603:10b6:3:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Wed, 5 May
 2021 07:30:22 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4108.025; Wed, 5 May 2021
 07:30:22 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: Export ras_*_enabled to debugfs
Date: Wed,  5 May 2021 03:30:05 -0400
Message-Id: <20210505073005.5128-5-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
In-Reply-To: <20210505073005.5128-1-luben.tuikov@amd.com>
References: <20210505073005.5128-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::10) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.40 via Frontend Transport; Wed, 5 May 2021 07:30:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7004277c-83bf-4153-9dca-08d90f97a43d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1866:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB186638B6B516326F0013C2EC99599@DM5PR12MB1866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9P8kWM+ioHveeXK26VqPx/+bCtsa0zYjcR1xmgK//odt13aiUBdcKmKHrDgRjctKuOVw7Xjs4Y66pPS4N7m1SKn3agpixo/fii03We5IuFimqstrLSpF/pwo6faHG+ymrBkY2w2ZSSdUcAgpu/2UnIffMNf+/nf1SOL9gD9gXu926wPuo/Ig92Ww7wJm8NMnlT1tOQcscktdaOZbaV0vf8WnmQ/Djjo959Dg25Jpqxgy+VaNPp6mOrrMSAtDrUBUW9PrrGKEvoMyq8NXcF6PDhK5itIVvun/vvWavjzilxSN6knQhhBqqJfVF6zKw/w+svu7flXIDZL8vPnRMUpSzU0XApb4XHHc0w5npQl5CiId1l1/Pn2X5ujZkT5oZ274xpEbzUHEVoL3/nU+ZHydCABGqG4MDGwGKVLQrf8jHyitQJdlufAk7gdBOApnpH+xu5Z+g0mTNghKS/v+ckKUiC9UCHCyUe+qJGXrq2GdRUJ+N7FbCQLaj5mQRkZk/FbwNlzjPgBlBV2e5sXqRo39zapOvy2t9BGgs9JBVgQa+KmNO5xAE41QjMEsN1gAe5XlIeEB50jft5Cw3tuQJnXFC3Pxt4H8wk0OFz3WaI8RlUFrMNTnq+ATtgmhVz7LGCIg0nITosrkFpzhcnGjDe30f95zhT0cQSZivnN0uu1dYc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(36756003)(4326008)(956004)(8676002)(44832011)(26005)(2906002)(54906003)(1076003)(6666004)(2616005)(316002)(5660300002)(8936002)(6916009)(52116002)(6506007)(6512007)(83380400001)(66476007)(66556008)(38350700002)(186003)(16526019)(6486002)(38100700002)(86362001)(66946007)(478600001)(55236004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OWI5SjVkeGtUUUVFUTVWNUt2eTcreXhZa3FSMktDQTBKMEZZZFd4V3hjbUJj?=
 =?utf-8?B?c054TmFnTVJydGN4NFJmRklZTFA3TE1VY0xSS3kxam5nQ1Joa0VhODY1SkJy?=
 =?utf-8?B?bXJuUFRWb0NYekxyd1U1NzVLNU16TFFjN1d4d25wbmRRRnhickN4MTR6NFdw?=
 =?utf-8?B?R0p0cW15Zzg5ZU0vM0VDUmR6TGtjTTRVbkcwQ1NIRFBhYkdoWDhTS29vNXdn?=
 =?utf-8?B?d2JVWEtzdVBGU3JlWnRzZ1lhdXJEeDJxRnIxdG5rLzNrZjZsNE9hNnVFM2F3?=
 =?utf-8?B?TGIrRUR4RktPV0xQaWdUZmZQbFRTRWliN2JnSlVhQ2dyYTVIVm5DTkg4T0Y2?=
 =?utf-8?B?aythakZqcy8rRVZEOFFmaUd2bU53L2ZmVlR2WEhkN05OTDZjRWZzRGg5bFo0?=
 =?utf-8?B?M3NnV25Wd3o1aVFNamEzYUgyV1VBUFZuU0FidmRTWGhkdFlyUTdVaFFRaFND?=
 =?utf-8?B?VTJCVThCZnZHYmo3L1dIbFl4Z3QzelFaakljVUhCY0JCaUdtaEI0bzJjUDJu?=
 =?utf-8?B?RzhtbU9DTGlEWTJuZTJHNnNRRXp0bTAyek9NOEJaMjhRcFE2Q3UxTzZ6YnF2?=
 =?utf-8?B?STBPZlVtTGxUTk0vZWY4OXlROThIK3p1RyswaWF3ZndWTk5QMmw2M3hlTkhj?=
 =?utf-8?B?YllBSU45WFpmNkJGU3JIM3RVeko2RW0vMXMrRDZOMmRYdnRRSlNGWkZoRTdH?=
 =?utf-8?B?TGJOZWhGVmJpU1NCY0RJT0dyRVBKU2ZwNHVhS2RsM2U0cUgrMmhKajdFRmdv?=
 =?utf-8?B?eU5jWXVpaTZHVjJ1QjlEQWoyS1lpSW5za2FKK2cvMDlreCt5dGFobUlzVzBj?=
 =?utf-8?B?UUFBaUliODdqTnB6dmovbGZtQ29pVTgxbi94ZnFIb1k3MWpFZ3RLVXY2OElG?=
 =?utf-8?B?OFFaNlg5UzhDTHI4SFlpcTZ6YUdvWHplYjF6Y2FRS2J2RXFHZ1poRzRUSlY1?=
 =?utf-8?B?RWoxZEtkZzNMMll6Y1U1M3VVYUNEUHBKd0ZNQ0FkRityQkdUcXNYVkMydHB2?=
 =?utf-8?B?ZkpkcHBOekU2ZEd4RXM2Vml4b3IvZFUwTmdLWi9adXpDQ0dMQUFja1RYaTI4?=
 =?utf-8?B?WEhKZnZiMEhsTHdQQWdtaVNBM2V1aXU0aDdraitnYmRCS29DMjg1dDJRaFBI?=
 =?utf-8?B?dVlrelBacmZJaWRVNlNFMllOTlkzRVpIZzNJRGFPQkpjblNJK3gwcmp2VXhm?=
 =?utf-8?B?K1JORUZpYWVZK0xqOTBkL1BnY2dkM3FKOGltekdmU25OTGtlWWVQVkZ1UW5l?=
 =?utf-8?B?Y1l4ZGJzOVBRY2U1am93S3BwYmZnUVp5NGxDOWN2Z3FhYy9MQ2NnbHpBN0E1?=
 =?utf-8?B?ZFFOK3NCVjVYeGFzVTkydkdnY3FQRktsQnRpelZHaG5ReG00VVRUZS9IbWpt?=
 =?utf-8?B?M1dtY0tqUFE3OEV2Yk9lWXpBc01qVEVzaE0vU1pXaFFvQXYvQmdSUFFON2tZ?=
 =?utf-8?B?MUZyY3Q0dURTRXAwcUkxajg4NlBQd21SUDNpZ0ZUcENic3BJa2h6cld0R2xV?=
 =?utf-8?B?Yng1akJidCtLU3lkV3JMMHlmMWVNc3BhRWsxenkxbnRiN1VMbzBiQTB3MjJP?=
 =?utf-8?B?SE1IN0FDR0JwVkUrcUNCZjI0N1dzd2pxWjhyQ1FtaU1TVVE2WkNZa0xRaTls?=
 =?utf-8?B?NVY4blVDL3J5eGpBWUwyek5qeHNEWWlNTzFFdmtVakRCMmU2eEhzbUYzM3h3?=
 =?utf-8?B?c0xVYjJhZ3gzL0wzMU1oN25MQTRiZTFBOWJ6WGlVbThjbmQ2UElrelBZOVRt?=
 =?utf-8?Q?YEjbFG33e7XMOVg34IfFQoeEWgIOidMcqkLfuxH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7004277c-83bf-4153-9dca-08d90f97a43d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 07:30:22.1244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRxXoshTGd2dsTtOaT49gQuqq7jFWDe5cMfALGbsK5MiCQeF8rVRJICn/eptTdbf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1866
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RXhwb3J0IHRoZSBydW50aW1lLXNldCAicmFzX2h3X2VuYWJsZWQiIGFuZAoicmFzX2VuYWJsZWQi
IHRvIGRlYnVnZnMsIGZvciBkZWJ1Z2dpbmcuCgpDYzogQWxleGFuZGVyIERldWNoZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+CkNjOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFt
ZC5jb20+CkNjOiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+ClNpZ25lZC1v
ZmYtYnk6IEx1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+CkFja2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgNiArKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jhcy5jCmluZGV4IDQ0NGY1MzI1ZjA5Mi4uNjA5NTMwYzRhNTk5IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCkBAIC0xMjk5LDggKzEyOTksOCBAQCBzdGF0
aWMgaW50IGFtZGdwdV9yYXNfc3lzZnNfcmVtb3ZlX2FsbChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKIHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICphbWRncHVfcmFzX2RlYnVnZnNfY3JlYXRlX2N0
cmxfbm9kZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAlzdHJ1Y3QgYW1kZ3B1X3Jh
cyAqY29uID0gYW1kZ3B1X3Jhc19nZXRfY29udGV4dChhZGV2KTsKLQlzdHJ1Y3QgZGVudHJ5ICpk
aXI7Ci0Jc3RydWN0IGRybV9taW5vciAqbWlub3IgPSBhZGV2X3RvX2RybShhZGV2KS0+cHJpbWFy
eTsKKwlzdHJ1Y3QgZHJtX21pbm9yICAqbWlub3IgPSBhZGV2X3RvX2RybShhZGV2KS0+cHJpbWFy
eTsKKwlzdHJ1Y3QgZGVudHJ5ICAgICAqZGlyOwogCiAJZGlyID0gZGVidWdmc19jcmVhdGVfZGly
KFJBU19GU19OQU1FLCBtaW5vci0+ZGVidWdmc19yb290KTsKIAlkZWJ1Z2ZzX2NyZWF0ZV9maWxl
KCJyYXNfY3RybCIsIFNfSVdVR08gfCBTX0lSVUdPLCBkaXIsIGFkZXYsCkBAIC0xMzA5LDYgKzEz
MDksOCBAQCBzdGF0aWMgc3RydWN0IGRlbnRyeSAqYW1kZ3B1X3Jhc19kZWJ1Z2ZzX2NyZWF0ZV9j
dHJsX25vZGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKgogCQkJICAgICZhbWRncHVfcmFzX2RlYnVn
ZnNfZWVwcm9tX29wcyk7CiAJZGVidWdmc19jcmVhdGVfdTMyKCJiYWRfcGFnZV9jbnRfdGhyZXNo
b2xkIiwgMDQ0NCwgZGlyLAogCQkJICAgJmNvbi0+YmFkX3BhZ2VfY250X3RocmVzaG9sZCk7CisJ
ZGVidWdmc19jcmVhdGVfeDMyKCJyYXNfaHdfZW5hYmxlZCIsIDA0NDQsIGRpciwgJmFkZXYtPnJh
c19od19lbmFibGVkKTsKKwlkZWJ1Z2ZzX2NyZWF0ZV94MzIoInJhc19lbmFibGVkIiwgMDQ0NCwg
ZGlyLCAmYWRldi0+cmFzX2VuYWJsZWQpOwogCiAJLyoKIAkgKiBBZnRlciBvbmUgdW5jb3JyZWN0
YWJsZSBlcnJvciBoYXBwZW5zLCB1c3VhbGx5IEdQVSByZWNvdmVyeSB3aWxsCi0tIAoyLjMxLjAu
OTcuZzE0MjQzMDMzODQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
