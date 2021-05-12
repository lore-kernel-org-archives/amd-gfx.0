Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3273C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 14:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C3661407
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 14:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C3661407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9F3B6EC18;
	Wed, 12 May 2021 14:27:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 971846EC14;
 Wed, 12 May 2021 14:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+Eewd0CLuSwSrxK2iNd+N11Ag2uXXSflAUMvxU58wk/3a8nRqswUDjkXSihqO4RcikcJepDLP0yoh0vazSKq7r5syxS/WOUHcB70kN1rxf8jJv3+wVmF3gLirQ/P1K6CNkLkA7gVH2ECM5fqEwYx0zHjyg2kZ1m77fpBMPWBVwwQXIW1l4g7Tc1ojGxxPB1WlxHIbNHK6R+Awgbc3/5gwE6QrKyN8chv9RO1SlIOMqIOTV2XhH+hbKaSPyr9vc+4wr6pvlgvJMsKpch31WTsNkphvIplt8XbnNpyZZjV0Jk2cxAQDapvNyMXFHGyh3HHv5K+lGkmPJ3yjvJbzq4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvCJ3p4J5b6j3Y4MhS7JBFeYIKw8tX02HYjT2myyNew=;
 b=NClw1aosdmAom2YbdRgfYIU24BgaLP+kgESmVxFQBbjzAY/KYYkSGbYcZYD3RgX65BSz9cvDalAXMqu/sLeafv3s5TiWxsoi3SlzP0KSUFVYW8AWMO+zkObdrhb4lXzILyMTsYQAV4BLZS/RMgEhV6RXaRobxMdaEf2c1wBgKy7UwqzX29+8yNPAAlyxyGspDvs/l8pvApZs9QfPJLtSz6eo0rc2R8EY5FlBE2w7v1TgTfq4QgBxnIJUR1syFGNSt/kLO3FCYy4+/3zMcMCFhL6QrJCncU+GbgY9PUOB7jAnTQjwHPOiN8CdgbfdujO8NgIzbkvBlJ8FEHxLMNYL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvCJ3p4J5b6j3Y4MhS7JBFeYIKw8tX02HYjT2myyNew=;
 b=nuzT6bWjXxYiWGuUlPvhCLkzrocNnKXBxeykUb8ZHUJA22yXqLzNURmZJ5B25myLUh1ss5V5YTxsxl0TBD8cAkn1INPtYwnTpEzalCJqxwN2NKsf7sNTJc+XTh0H/nv19TtT9YQubOuNbTdDfz1bVwNMte1diF1vXxJX/G4wwbI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 14:27:33 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 14:27:33 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
Subject: [PATCH v7 10/16] drm/sched: Make timeout timer rearm conditional.
Date: Wed, 12 May 2021 10:26:42 -0400
Message-Id: <20210512142648.666476-11-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
X-Originating-IP: [2607:fea8:3edf:49b0:7576:4f76:97d8:1487]
X-ClientProxiedBy: YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::45) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from agrodzovsky-All-Series.hitronhub.home
 (2607:fea8:3edf:49b0:7576:4f76:97d8:1487) by
 YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30 via Frontend
 Transport; Wed, 12 May 2021 14:27:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7617c67-b5ff-49a0-b218-08d9155214bc
X-MS-TrafficTypeDiagnostic: SN6PR12MB2845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB28452375343F55BD175C6129EA529@SN6PR12MB2845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhyuVcsMoQnPkmDdtW1RBzrl3t+epjt0mjR37Gb5T3amsd9DFfRP6189FvF7IQghX39P5HgtZfyF0yoGJrZE/RPGjW8b2xosncgsEF136E+3wHuSh3163ujmXV+lKMIvPNVhQITmlK6vc56CPt7FX2LNGLPh0drXsEfwPtyq38+hsCifRucPtiCDWKnhU7RU0N7A20FqWMc277KoGT0LtrW+9plHP/iI2GP0iQ8iAdnxK7eQxkV8obGvhrKY5p+huUlctCmFhd3bOZCFySSbCha11mK1ZMwSS1AlAWV/Ad4a9+bLHuvwwyQal5D1OJ8nQxokfreCFT9Fc4kQ0qqCeUNeHiPFr1/2YSn0GBGVenJMd+coF3gZg1NXWx094y5qWC5w8pDQrXaTKKznqz1SmrgU8/leRMAvn0TXsIbgf7GIMcmQ4wTYvoeSr+8iZeVyUkZhq/TKwHvEybm8GuYta3yOYhxrJOS1yDQPkw48CnuMJxUBvb3uO0U1F0fGIoc0AGZv86WyywQFweFaGjr8EFMX+Y71+JR6BnDpvsF4Ez7I5KLH1bEutQ6xhao9OAG5pB6kAb+8KKF7AnAJyqWXmd/rW+ELefisxrRxUJ6oUgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(6486002)(8676002)(54906003)(316002)(6512007)(16526019)(6636002)(478600001)(1076003)(186003)(4326008)(44832011)(2906002)(6506007)(8936002)(5660300002)(2616005)(38100700002)(66574015)(36756003)(86362001)(6666004)(66476007)(66946007)(66556008)(83380400001)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WnA0NmI2WmdTK3pyMjZpQmxkakpYUUxkd1NEc1NYRDFldXMxcm45Z3RDU2FV?=
 =?utf-8?B?NFk5blVaMU1PMU8zVzhIeEVuMERZTHhJL1dYenI0YXBOcFNJVmMrN3orY1V0?=
 =?utf-8?B?M3FyQXBFTldpZmNudy9naVdUNGh3YVNpSDlPY21xVk5UcEVENUJWRTY2RUc2?=
 =?utf-8?B?a0NnOUpDZXA5V3J4ZDY2RStjM3RzVGNVUnc2a2h4RlA0VXRIYUYyS3k5YmQ5?=
 =?utf-8?B?Ukl4QldRa0pWakhZSHlEeGJteXFqdVFLYmU1Qi9yc09PTG9UYmdDbWNVZWJn?=
 =?utf-8?B?eEI3V0p6Zk9DU1B0ODVyMU1oZFhjMy9hcEtZV3hPY3ltY2V5blR2YzhaQ0ph?=
 =?utf-8?B?MnBicU9MTmFpTTZtKzc4R1RUSGV2V1U4K3VuNnA3WHlPRUVKeWF0T2RGaUdK?=
 =?utf-8?B?MlI1cW0yZVE5UUZyN1loSFp4ZFFaNWwrSFRRc3JkVWNHTlYycVR3RGgwOGtF?=
 =?utf-8?B?WFg5THhhb2x1THNKSXhaYTNoNnJpL2VQdlp0SUNWNVNBUHZVcTNUdWRGd0tw?=
 =?utf-8?B?ZktXYmMzbFhNZktVRHpLdE43eXF2OVUxOElVV1VTbklYRVI3OFUwNStCd0ow?=
 =?utf-8?B?enV0YUswSC9OSXdBdXJyQWFrZlQzOFpmZjJsZlhqQ2pLdUROWXpjQUN2VTNU?=
 =?utf-8?B?T2p5NmdFaWlMWCtsNEliakZnWENSNGI1OSsvb2RJZ1orWGxURzNKb093Tmxk?=
 =?utf-8?B?QlJBQjR2Q0F1dFNWRHlGRi9tOS9MbXhSNnpLTlovM0J0TkYyaFg2ZHhhUitn?=
 =?utf-8?B?MmNiOHk4MHZ3Tk5HeSt0Y0gzK0F4dGI2Mm11Z2JZQkc2ZHE4b3hwaE9ZODVr?=
 =?utf-8?B?WnhTRnZxWk9XUER3VkVyUUtmWWkwSUZNTzFjOXhCd3h0L0sycWtqM09sUG9t?=
 =?utf-8?B?cHA4YXVqZGt2SDJzTXAydkNIK2V4Ym1IMng5ZUppeGF5VGJQS1ZpbktWRnFG?=
 =?utf-8?B?N2JaakpBZGR4OWk0c2JFc0lURWkzdkxHaEtUWm00Zmc4ZWJXZVNJN2ZNT084?=
 =?utf-8?B?QU5FSGRIOHZiK2tzSUlRODd1eDlaR2JFS0M4WExTUVpDdy9ianU2enV4aE1a?=
 =?utf-8?B?ZnVzRHVPUjZKM2JobnNZRWwrbHRMSHFoSmRtcHRZZ1lZMUs3c2RoSXZOS1Ju?=
 =?utf-8?B?SGpxcmlJY0daN3kxMzl5NXc4M3ZVdmRTQlN0ZCtIc01KRkRMTFZRZ2xvNnY0?=
 =?utf-8?B?WG1lSWtLTG43N3ZvK1BwWFZ6RDdLdy9XRnpJbVNlVmVOdjZ5TTBNT0lyVnJr?=
 =?utf-8?B?NXlEeTI5c0dHU2s2TTRxT3JodzZ0d2V4bzU3czVSb3FnUEFGckZMU1AwRHFL?=
 =?utf-8?B?ekV3dC9vQ1had0VuT3JSUDc4UjJuNW5oTXNBZUxpWi9YTmx6RFhQM0crQ0JN?=
 =?utf-8?B?cUFwc0M3WmR1VTBseTVHamplT1NGaDZ6dThWRmoyUkd1Q0gyYTE3ZDkyNTU3?=
 =?utf-8?B?T1ppK0ZRWW56cXMwNlRqVElrcEtrelNHdzVDYkRGRmQxZjVHVmJkeFhYWXZQ?=
 =?utf-8?B?ZHR0cDlESGxjcTJDbWxEZjNGeWRhZk1xQnpjTXFaMVA0eXd2TU1ZZkR3TWFj?=
 =?utf-8?B?Um4wbVNDSlk5QXNEVlRnTkNuRXF2Tk9yNzNKenVHREFYbzJEVTZPV01QNXNC?=
 =?utf-8?B?THdPTWdKT0pJckZPYzhTU2h6NHBIdTU2Wmh4bE5uMXVmWExFbEFua0lzaEhX?=
 =?utf-8?B?V3IzekhTSS9kTXpYOVVWdThtdzlxNk5vVkhLZUlobXFmODlpUzRrTXpDaGNW?=
 =?utf-8?B?MXNzMGlrdXJ6VE5UT3VlN0R5SVQzTzE2akZET2lEV0NUaWZlYVdtd3NpbUhK?=
 =?utf-8?B?ZzgwcnhLdlBPNDNxa0s2dVc2Ty9DQ1duZ3NMS25qR0xzdUd4UlAraUwwbUJY?=
 =?utf-8?Q?sm1Zh9fAAQps3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7617c67-b5ff-49a0-b218-08d9155214bc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 14:27:33.1106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSzpb4eWgClP/ko3EO32H9TwmiF7WT7dWTws8GSqK+BnTDsgBsii8mhwdYouToTo2sSwFo+RDOHj4ifOEO2Bhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2845
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, gregkh@linuxfoundation.org,
 Felix.Kuehling@amd.com, ppaalanen@gmail.com, helgaas@kernel.org,
 Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V2UgZG9uJ3Qgd2FudCB0byByZWFybSB0aGUgdGltZXIgaWYgZHJpdmVyIGhvb2sgcmVwb3J0cwp0
aGF0IHRoZSBkZXZpY2UgaXMgZ29uZS4KCnY1OiBVcGRhdGUgZHJtX2dwdV9zY2hlZF9zdGF0IHZh
bHVlcyBpbiBjb2RlLgoKU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5n
cm9kem92c2t5QGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9t
YWluLmMgfCAxMSArKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3Nj
aGVkX21haW4uYyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCmluZGV4
IGY0ZjQ3NDk0NDE2OS4uOGQxMjExZTg3MTAxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
c2NoZWR1bGVyL3NjaGVkX21haW4uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3Nj
aGVkX21haW4uYwpAQCAtMzE0LDYgKzMxNCw3IEBAIHN0YXRpYyB2b2lkIGRybV9zY2hlZF9qb2Jf
dGltZWRvdXQoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogewogCXN0cnVjdCBkcm1fZ3B1X3Nj
aGVkdWxlciAqc2NoZWQ7CiAJc3RydWN0IGRybV9zY2hlZF9qb2IgKmpvYjsKKwllbnVtIGRybV9n
cHVfc2NoZWRfc3RhdCBzdGF0dXMgPSBEUk1fR1BVX1NDSEVEX1NUQVRfTk9NSU5BTDsKIAogCXNj
aGVkID0gY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciwgd29ya190
ZHIud29yayk7CiAKQEAgLTMzMSw3ICszMzIsNyBAQCBzdGF0aWMgdm9pZCBkcm1fc2NoZWRfam9i
X3RpbWVkb3V0KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKIAkJbGlzdF9kZWxfaW5pdCgmam9i
LT5saXN0KTsKIAkJc3Bpbl91bmxvY2soJnNjaGVkLT5qb2JfbGlzdF9sb2NrKTsKIAotCQlqb2It
PnNjaGVkLT5vcHMtPnRpbWVkb3V0X2pvYihqb2IpOworCQlzdGF0dXMgPSBqb2ItPnNjaGVkLT5v
cHMtPnRpbWVkb3V0X2pvYihqb2IpOwogCiAJCS8qCiAJCSAqIEd1aWx0eSBqb2IgZGlkIGNvbXBs
ZXRlIGFuZCBoZW5jZSBuZWVkcyB0byBiZSBtYW51YWxseSByZW1vdmVkCkBAIC0zNDUsOSArMzQ2
LDExIEBAIHN0YXRpYyB2b2lkIGRybV9zY2hlZF9qb2JfdGltZWRvdXQoc3RydWN0IHdvcmtfc3Ry
dWN0ICp3b3JrKQogCQlzcGluX3VubG9jaygmc2NoZWQtPmpvYl9saXN0X2xvY2spOwogCX0KIAot
CXNwaW5fbG9jaygmc2NoZWQtPmpvYl9saXN0X2xvY2spOwotCWRybV9zY2hlZF9zdGFydF90aW1l
b3V0KHNjaGVkKTsKLQlzcGluX3VubG9jaygmc2NoZWQtPmpvYl9saXN0X2xvY2spOworCWlmIChz
dGF0dXMgIT0gRFJNX0dQVV9TQ0hFRF9TVEFUX0VOT0RFVikgeworCQlzcGluX2xvY2soJnNjaGVk
LT5qb2JfbGlzdF9sb2NrKTsKKwkJZHJtX3NjaGVkX3N0YXJ0X3RpbWVvdXQoc2NoZWQpOworCQlz
cGluX3VubG9jaygmc2NoZWQtPmpvYl9saXN0X2xvY2spOworCX0KIH0KIAogIC8qKgotLSAKMi4y
NS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
