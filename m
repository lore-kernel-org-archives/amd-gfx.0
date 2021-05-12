Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DA4C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 14:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB5E61411
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 14:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB5E61411
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75A416EC1F;
	Wed, 12 May 2021 14:27:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86F66EC1C;
 Wed, 12 May 2021 14:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8uJ/P4kEJylA6M5wShhbSBD4LzFcEWvzb7aXLDIRp6DgWanorX4Oz8/GytJlSd3v7dt+b5Ts+/BHbIMeQFMiHTCEiEdXPy8bybEniOC+BcxzI++VZQt5r3/rarGeXhZ+xd3+grssFdDINwL5bvkWXXKagXBR9p4hhX6zgmU3WfOgT7ih7eWu+GadtCk21yOoygbI1sI9JqKqYsWERs4IbaTOw/1ahy4lgrDT1ZqutIWccM5K52Jht0S+MIzbnt/SHPUVPSwW/tvx7x3u/bF7j9vFHDoUQhDDkM0vygqnYMz1Qx7E6P/bbIh6FGHzYzEu/QwLsANSwnHQdwT1KBZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/uPjWV0fg0dVVvp8px//s3OoPIuYbV9UKVinTXXgyM=;
 b=b6lerkiA7/BnD7wc3ITilvmwfkWtEt+ZCXZQEJN9SC4bVFSM9pbCNFxBfNoFkUaKG4jnVUR4CgOr0ufueGfvznUJisWxf1WhY7UBED9ruVuzSC1kG6q6BKzKY3SZXF26vQ24q2MfiOg8+icYt6e2irENyp7AwFd6PmnEtZdEAzJuvvRcM/5w/TNGFLJtv+5eKyCB/keTgLJakMpzhs3p5KaKyqVkpb1+MzQptxdzigngzgN+wt0BvJYG9KWkX2/Ki/C9Og6/K9y0eTo36tkTsPUCMZWYPsbeTbKShGVmn+/tjhnSOq/LIquEV9m5vtpIRmh9RZDeJNZbacnpktgamw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/uPjWV0fg0dVVvp8px//s3OoPIuYbV9UKVinTXXgyM=;
 b=Q1lhmhAFDXI/aTiHDu8ODto3TIDliCYTi6PtbzhMteZTLwuA2Ym4jywAMiFwGEiKgDF+NBz1wdJXe7wk2g4IpAzqrV8LbRJF3GDJctWOCmKJucy+HS1LPSuYj2ck4dgyQPHqZ+oLSZi2NmImO4GvXfhaNi5mZc2LX35etICN4cA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2655.namprd12.prod.outlook.com (2603:10b6:805:72::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Wed, 12 May
 2021 14:27:38 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::ad51:8c49:b171:856c%7]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 14:27:38 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
Subject: [PATCH v7 13/16] drm/scheduler: Fix hang when sched_entity released
Date: Wed, 12 May 2021 10:26:45 -0400
Message-Id: <20210512142648.666476-14-andrey.grodzovsky@amd.com>
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
 Transport; Wed, 12 May 2021 14:27:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ce3949c-dc28-4dc4-7178-08d9155217fc
X-MS-TrafficTypeDiagnostic: SN6PR12MB2655:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26556B8F987E0B65B7FEADA0EA529@SN6PR12MB2655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjodDNVbmuIH5JjKRtrRHLX1HTVK05REV2vn70KgDg58hJD+13RcCei+iEwJULjW35ktZGrUPe1LyY/S/4Rqk2zdRsY2XHDxgCcJNtxvB8Xm+xSj3As9vghir7t2hA95PaqZB3gtQ+CiEVaW2cqQb4NasjnvHp7AwVN/H9Ovp1dKQjlG9DkxOg1SZ64fsrRS24a4Yszpkc5NFepZlVWKPnyS3jGwXzuuFokYYb7Sa7atLUSkILwaOjimMvcKCUVvzav1NPgXXWqtkRo0AQVunCMzJplkGIE+ifP72zMOnhlWHWFzCR24kW/ihSb0SU+iqwTB+WtmuAgL2mNRI2A/C6b9mBp96RVyzCI0rv46vfTADmkqrTchfNeyligoONtdK4YGyebXPBvZzn47Yw1Yx6UKFg33CyV8QvD5ZeUIGPc0Z55kvHckgTJSTW9NFCSjZZY75sQsoEKKlpWLrc0biU0ohw0kInfZIvDshbN6W8XIUfXEC+ir7s7ISEDQlWp1T9yHwJGivpzEHRG30DLDZTdXaYw+9AcqT8wcsVl9lAIPPnSHNbz6W3khaDYAWgUvN9TCnbWcB/uMq3bqO9iRi0KgdjmudHjYNtH2+CZhPLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(54906003)(66556008)(38100700002)(6512007)(66946007)(66574015)(8936002)(4326008)(83380400001)(2616005)(44832011)(6506007)(1076003)(316002)(86362001)(186003)(16526019)(66476007)(8676002)(6666004)(2906002)(5660300002)(478600001)(6636002)(36756003)(6486002)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VHZHS0lLdGk4VzdGMHdKUnZrc2RmR3AySHk5VWprVGpLU013NkZSdkNGNXUz?=
 =?utf-8?B?dTJNaGVkSm11RlBHeFVDdnBHUHFUNVFVUmNKTVl4S0JySGV4QjBmQmVBWnIz?=
 =?utf-8?B?cHVta0dMd0hGMnp5Y3lDaWd2azBLKzBnQk9sOHZQVWZvYUdPclltTUtvMkw4?=
 =?utf-8?B?NVNCQmNTSE1SRHR1Wjg2Y2g1bnpsN09sc3N3U2E3alppOVZITlFMTHczdTVH?=
 =?utf-8?B?SE9tQkNGNGd4c2RVQnFjbEZRc2lmRUl3NENzZE9xWTJna1h0UmJqUDB6a0tq?=
 =?utf-8?B?QnREM0Q0MU1tODdMREdyaWtNWE5McVRzTGprZ0dodEdKS21iSGgzYUtMM3dP?=
 =?utf-8?B?d0NlV05RV0srNlo2ajBacnVvR2toM3pONDcrYkxob2pGeHJGZVZQZ1VycU8r?=
 =?utf-8?B?MXJzejlBVDFrbk14S25VMDBOK0tycXFwbE1QdEhVdjJEdmNBSmM4aDNPMEhJ?=
 =?utf-8?B?ZkN2a2I1Y0Jka2t2MkMyS1F4NzVGN3kvTXh2eFJrR2dSMmNpNHRYUytJTUxM?=
 =?utf-8?B?M0c5UHkrd3R5Ykl1OVNtdGhNNk1MS3RIV0pZMUVkQzBCQjNRVWVHWWVOMDBN?=
 =?utf-8?B?Y2tpVGtsb29IbmwyNDJYMU1uYlhpOFNGZHRQaXY5TEhVWEY5a0dpc000WXNq?=
 =?utf-8?B?ZlI1Q0pUQUhpYldwV2NYU2NnNnBzWmhLRWgwUjBKNUU5VUxsSnNpWmVTeEVr?=
 =?utf-8?B?eXJzQkdxSTdOUFlUb3cwZEx6WmVQalRTRC83cW9ESFFaNFFDQngyNFZGYWN5?=
 =?utf-8?B?YTZ2R0MxbVJnSW5HNGhiOTMza1ozWkFDOHVHci9aUThCL0dSQno3SzBObEFG?=
 =?utf-8?B?YzVLZUhKQUNDL2hVeTNtNzdsdUpidkYwbGwyQXZQeEk0TlUzdHJ1ejFhU29n?=
 =?utf-8?B?NTNnbmxQdjV3NEhiVU41ZTVDaVhBN01OSGhiUzJ5WVhSMVZ5aUozbzJSREFE?=
 =?utf-8?B?MDQyNWI3NnQ1TlFrUTZVL3RPYXo1cS9qYytQcmdkMDlydkcvdjF0end4eFp0?=
 =?utf-8?B?SE1KRUVURmhrN0ZKSDE5QXpCQ3FLMXFTWUFNdllYZncydzJmdjJCZ3dsc1dG?=
 =?utf-8?B?R25PYURXdjlITmFhZU5TVjlsWC9ZQTVSZUJFWEcwVUV4Z0VmcWJydUVOTDUy?=
 =?utf-8?B?MTU4NEpaeHRwZDhpZ0crT1REc2ZKSHZXVi8vSFJpNGpsR3RqQ3NaTzZ4QWhx?=
 =?utf-8?B?SzBqc3BhSGpFeklyUzMzUDRNbml3TDZwaU9wK2NUazk4L1RIWVIzc05HSjJW?=
 =?utf-8?B?SE1meFlEVjVSNFBPVGFrSzhkQi9zS0FBSGhhRTFQZ3cvNGI0MFhDdzRseFNT?=
 =?utf-8?B?eXpwOTJOd3M4L0lBRWIrRklOd0hXSVJ4a2N4M2JzMi9xcVIwTXRMeTBTOXBN?=
 =?utf-8?B?TjZ3NzNyOFFwWWNKbDJyS0NxYnEwVlpVaWhSMGVlUTBSalRBM2psZkpiTlV0?=
 =?utf-8?B?aCs4ZjVzc09BcGhUV2ZuelRCMkJTYlRCWnhLdE12ci8weG5XcTN0NGdRckQ0?=
 =?utf-8?B?TlQyTGg2Y2RYMTVTeXpxQi9XVHk0SDRqQVEzVkZHVldta25FVnJKcTFVbUEr?=
 =?utf-8?B?R1kwR05iZmQ4YWFuZjZMOFppcDFYbGdoM1Z1Y2M5V0srcVY3anUwNXhSclZX?=
 =?utf-8?B?L1ZHREo4NndTR0wzcGplYXFCUGFucXJiMXFHeXo2b1N4UUZ6SzRvbjF0S2pE?=
 =?utf-8?B?aTRNZXpxWkJ5SWcxdjNNcFYveEU1emRoY3UwV0NKenV0SXJPSWhzVnZPKy9E?=
 =?utf-8?B?QVlxa2FIM2g1NkRaR0xoZCtNTHd1ZWFMKzJTUFh4eFh4YW1kTmNsYWU0QjJZ?=
 =?utf-8?B?cjQ2bXk4dUE1RDl0MUJwbFhlb2NTd2VFM1FRb2NsQ2sxU3NuNHlIZFZQamFz?=
 =?utf-8?Q?tjSiYznSg0gLr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce3949c-dc28-4dc4-7178-08d9155217fc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 14:27:38.4856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xHyO1wMWcGgBOWbhgkHoR0RY5/ooGfgTSLHNOV6MI91Z0+eBA8clj6mQRkTTkJjtwtF5QKp3YkfbCSnrnQ1Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2655
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

UHJvYmxlbTogSWYgc2NoZWR1bGVyIGlzIGFscmVhZHkgc3RvcHBlZCBieSB0aGUgdGltZSBzY2hl
ZF9lbnRpdHkKaXMgcmVsZWFzZWQgYW5kIGVudGl0eSdzIGpvYl9xdWV1ZSBub3QgZW1wdHkgSSBl
bmNvdW50cmVkCmEgaGFuZyBpbiBkcm1fc2NoZWRfZW50aXR5X2ZsdXNoLiBUaGlzIGlzIGJlY2F1
c2UgZHJtX3NjaGVkX2VudGl0eV9pc19pZGxlCm5ldmVyIGJlY29tZXMgZmFsc2UuCgpGaXg6IElu
IGRybV9zY2hlZF9maW5pIGRldGFjaCBhbGwgc2NoZWRfZW50aXRpZXMgZnJvbSB0aGUKc2NoZWR1
bGVyJ3MgcnVuIHF1ZXVlcy4gVGhpcyB3aWxsIHNhdGlzZnkgZHJtX3NjaGVkX2VudGl0eV9pc19p
ZGxlLgpBbHNvIHdha2V1cCBhbGwgdGhvc2UgcHJvY2Vzc2VzIHN0dWNrIGluIHNjaGVkX2VudGl0
eSBmbHVzaGluZwphcyB0aGUgc2NoZWR1bGVyIG1haW4gdGhyZWFkIHdoaWNoIHdha2VzIHRoZW0g
dXAgaXMgc3RvcHBlZCBieSBub3cuCgp2MjoKUmV2ZXJzZSBvcmRlciBvZiBkcm1fc2NoZWRfcnFf
cmVtb3ZlX2VudGl0eSBhbmQgbWFya2luZwpzX2VudGl0eSBhcyBzdG9wcGVkIHRvIHByZXZlbnQg
cmVpbnNlcmlvbiBiYWNrIHRvIHJxIGR1ZQp0byByYWNlLgoKdjM6CkRyb3AgZHJtX3NjaGVkX3Jx
X3JlbW92ZV9lbnRpdHksIG9ubHkgbW9kaWZ5IGVudGl0eS0+c3RvcHBlZAphbmQgY2hlY2sgZm9y
IGl0IGluIGRybV9zY2hlZF9lbnRpdHlfaXNfaWRsZQoKU2lnbmVkLW9mZi1ieTogQW5kcmV5IEdy
b2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+ClJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyB8ICAzICsrLQogZHJpdmVycy9ncHUvZHJtL3NjaGVk
dWxlci9zY2hlZF9tYWluLmMgICB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxl
cyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKaW5kZXggMDI0OWM3NDUwMTg4Li4yZTkzZTg4MWI2
NWYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwpAQCAtMTE2LDcg
KzExNiw4IEBAIHN0YXRpYyBib29sIGRybV9zY2hlZF9lbnRpdHlfaXNfaWRsZShzdHJ1Y3QgZHJt
X3NjaGVkX2VudGl0eSAqZW50aXR5KQogCXJtYigpOyAvKiBmb3IgbGlzdF9lbXB0eSB0byB3b3Jr
IHdpdGhvdXQgbG9jayAqLwogCiAJaWYgKGxpc3RfZW1wdHkoJmVudGl0eS0+bGlzdCkgfHwKLQkg
ICAgc3BzY19xdWV1ZV9jb3VudCgmZW50aXR5LT5qb2JfcXVldWUpID09IDApCisJICAgIHNwc2Nf
cXVldWVfY291bnQoJmVudGl0eS0+am9iX3F1ZXVlKSA9PSAwIHx8CisJICAgIGVudGl0eS0+c3Rv
cHBlZCkKIAkJcmV0dXJuIHRydWU7CiAKIAlyZXR1cm4gZmFsc2U7CmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hl
ZHVsZXIvc2NoZWRfbWFpbi5jCmluZGV4IDhkMTIxMWU4NzEwMS4uYTJhOTUzNjkzYjQ1IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwpAQCAtODk4LDkgKzg5OCwzMyBAQCBF
WFBPUlRfU1lNQk9MKGRybV9zY2hlZF9pbml0KTsKICAqLwogdm9pZCBkcm1fc2NoZWRfZmluaShz
dHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkKQogeworCXN0cnVjdCBkcm1fc2NoZWRfZW50
aXR5ICpzX2VudGl0eTsKKwlpbnQgaTsKKwogCWlmIChzY2hlZC0+dGhyZWFkKQogCQlrdGhyZWFk
X3N0b3Aoc2NoZWQtPnRocmVhZCk7CiAKKwlmb3IgKGkgPSBEUk1fU0NIRURfUFJJT1JJVFlfQ09V
TlQgLSAxOyBpID49IERSTV9TQ0hFRF9QUklPUklUWV9NSU47IGktLSkgeworCQlzdHJ1Y3QgZHJt
X3NjaGVkX3JxICpycSA9ICZzY2hlZC0+c2NoZWRfcnFbaV07CisKKwkJaWYgKCFycSkKKwkJCWNv
bnRpbnVlOworCisJCXNwaW5fbG9jaygmcnEtPmxvY2spOworCQlsaXN0X2Zvcl9lYWNoX2VudHJ5
KHNfZW50aXR5LCAmcnEtPmVudGl0aWVzLCBsaXN0KQorCQkJLyoKKwkJCSAqIFByZXZlbnRzIHJl
aW5zZXJ0aW9uIGFuZCBtYXJrcyBqb2JfcXVldWUgYXMgaWRsZSwKKwkJCSAqIGl0IHdpbGwgcmVt
b3ZlZCBmcm9tIHJxIGluIGRybV9zY2hlZF9lbnRpdHlfZmluaQorCQkJICogZXZlbnR1YWxseQor
CQkJICovCisJCQlzX2VudGl0eS0+c3RvcHBlZCA9IHRydWU7CisJCXNwaW5fdW5sb2NrKCZycS0+
bG9jayk7CisKKwl9CisKKwkvKiBXYWtldXAgZXZlcnlvbmUgc3R1Y2sgaW4gZHJtX3NjaGVkX2Vu
dGl0eV9mbHVzaCBmb3IgdGhpcyBzY2hlZHVsZXIgKi8KKwl3YWtlX3VwX2FsbCgmc2NoZWQtPmpv
Yl9zY2hlZHVsZWQpOworCiAJLyogQ29uZmlybSBubyB3b3JrIGxlZnQgYmVoaW5kIGFjY2Vzc2lu
ZyBkZXZpY2Ugc3RydWN0dXJlcyAqLwogCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmc2NoZWQt
PndvcmtfdGRyKTsKIAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
