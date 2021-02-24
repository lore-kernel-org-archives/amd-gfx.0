Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54768C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B92664E20
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B92664E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5BD76EB21;
	Wed, 24 Feb 2021 22:20:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A93DE6EB35
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkZnrC59yDupqVa+u+Q+EZ6mGpuTfxl0xvPAtIGIh5l3N5K6KL1FTIvI4OedfWpDndhcCVGgtNOjRpwVBIct4n2uEofqadPxsxfRzuiIYgIeS/s3p9ZJ4DGi5z/DNxZb/C8MgX3iFhejkE9fzCdvk3VN3SRwQKURO5QrZO+aSYMz9eQEYSK/pY3P4uRN9UYSv7hthNBykv0wbjQGT61dQTSXtfyuSfkPm36N1mVhAqXGvIoKOiejJhPIffA//9YUBJ9i17sotvdrf+p6ulyds8zlB6HQPU1TTmzEO/rL6gvtXGy6GAc8U/kT86MYGA/9Cy5a64unP1cw8g5T6N13pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLIIJ3vTrghzJ2I3ChC9sJIW3L3FHHhZZdQDp0EEW1o=;
 b=hEGTH4J6+3P5zWVvFSF8P0hs2MzJ5mv01HABwLKe2K2bGxxs6G7xTEIe2GbgQtz9RGFDXWVBclIiuCO9iW+oJLPtTctw+Zc878/vj8LrkN9L4Qp3/9N7hdTODLqiQw7qdXiwX3xWe2bMhfgrmAQPIFtk4DcV+Fua01L8Fj6BA2K1xr0vKUos6tdXR4m/uTzhQx1sKcAafU7YZxd2u1P3M09Vr7B77poU+Nw3g6hEka8H/HhV/0UHUjuh2w2qXnFCIW2FI/Pqg2jafEy5pSL3OjWxS7/2tTcgY7oAZPC5TV8Zd1wlmqkHWKjcyDuOqeW3akymZHompWnTL7jDwRtLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLIIJ3vTrghzJ2I3ChC9sJIW3L3FHHhZZdQDp0EEW1o=;
 b=l6LEa7nVba4jsHe/f2KAVqsU2bEbw2DUeVmemNNTqay4qY4rq9BNU8M+LIgcM7jieYjFXGHfhRWf5m/KBStCCScDzkvKlebdRWz+TO/0QCuIncNdHpJnaM93oNH67yNnkBCGsQVGPaGcwAo/rvsWbf4zh2uxSY/ca/0Q3J+ISJM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 22:20:16 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:16 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 039/159] drm/amdgpu: enable xgmi support for Aldebaran
Date: Wed, 24 Feb 2021 17:16:59 -0500
Message-Id: <20210224221859.3068810-32-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 85c4fbb2-b4a4-4670-f10b-08d8d9124b3a
X-MS-TrafficTypeDiagnostic: BL0PR12MB4865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB48655A80EBE75A79AAB92297F79F9@BL0PR12MB4865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDsRrHzuRXQI9gZMyJ9TA2sA1hbC3uINnxi0aDVTkxO+I/cPCpuV4pfZsAPPAQRUj2mcnAR28MHB4dWif+OyuNBlwWL0t4t8E7Lq51V8/CEkPAiUCN7SJfNLl64NVbBTr35Z8VJJNSjCcMIZQJt/z9UetcPoMTf/944eqdsA5W7T+IYQeMggUfoBlmkeFOU9I64UuvLcLAFMy1CCB3Mq8Ur75Ihr8hqZU69mIaZf96nhVtTOLVyuyLvkGbmlAYE0LapF628v+eXqKZ4/2LVHMJcSA9GvUPmf9PwGVOiWa6H280JibfTvVqDsnUP+HwdHrhlACTYF9F6VQ9tHUxYaiZCNkCD4thxfZ8jhdNvmUlRxgSH7ZwRNdo+vKPxWTd2PIO9cd5VwCTEIwXptaM03l2kSyZwB9iUYcaqmo5X5CO6lS6oxhOm4GCiU+yFrHMUByRtBuq3uUxMkd3DILOTVWewzpqklTkUxqexDRn43ZNQDUZvuLUMWSJvDgJJQKswIAsbkrg1SJ6j6jc/Ekyducg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(6506007)(478600001)(316002)(66476007)(66556008)(86362001)(2616005)(5660300002)(6916009)(8676002)(956004)(36756003)(1076003)(66574015)(2906002)(6486002)(6512007)(26005)(4326008)(52116002)(186003)(66946007)(54906003)(8936002)(16526019)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aXVZS2ZvN2hqY21TUHVONXBXSEtXVGNTc2t3elRZakIxOUcxaTFuOXpvY084?=
 =?utf-8?B?bFJVMXRiY0ltM2l1MVAwOHBNU2NhdG1lb0dtS1ZYTVhCMXBiYTNWYVFDZFdp?=
 =?utf-8?B?OUFZU2xvU05VMXhMQlZ6aldCS2NweEtUSnRiYW1ISDBOUlhaT3c0WXpQY2FN?=
 =?utf-8?B?ZTZQMlo2M3BCdE44S0NZRzhIeWlQajc2WnhPTk5KdEZCbC83dDdQeDlheGFY?=
 =?utf-8?B?Qk1STlA1TnNvUFkrU2pJczdhSGFOQXVPODBuVTM0VGl4WkprTFJhWXV3UTRB?=
 =?utf-8?B?UTN3UzJsVXNiZGxSbDdBdnJQNVF0bmF5eEtHNEZ6UFJpSUxEa0pLdE5oMWEx?=
 =?utf-8?B?cUNrUXQyRENHMmZUek1DcDAyRUtmakNmWlJSdHhVZk8xUnlscUV1ZGxWbWJa?=
 =?utf-8?B?K2Q3ckVKckxTek1wWHIxSjhMMzdHSXcwdDc2NWhZdHpCMFVNZjMvaitjMEV4?=
 =?utf-8?B?OE5uSUw4U2h3Y1Y4YUZ2SFBsL05lZU92a205SjVaZTdsREF0OEYwYzZCVEow?=
 =?utf-8?B?Y3hFQ0EvbktPaFBXczJWSXRSREM1N1dzR3NPMU4yN2traHdNZzhwaTRBZHpE?=
 =?utf-8?B?N0REQktqTjdqQkc1eENPSEJqd0NNTUsyd2ZpeGNsWUY5c0NtejRZYmtqWGI4?=
 =?utf-8?B?M1J6U00xcDFWTjc4NGFyQlcvblJUV3pMZVFHVkhiNWhjaHY3Ulo3dkEwL2NV?=
 =?utf-8?B?NElOME9jcXhQYUFrOVFoMUZyR21jMmRLUENONERSMnhBb0tOTU5FTFJ0Nkt6?=
 =?utf-8?B?UkFhaDF0c095NlRXUGlTeGl5SkZDamVEdEtJTlQrYmdTNVB5UStlUDNUQy9s?=
 =?utf-8?B?VlAzYmYzVnZnWkprTUV5NG5PTUJ2b08xYXM2TFZWY2dRUnRBWWFGSlp3YzRW?=
 =?utf-8?B?NW9ZQ1EzNjRtNmRpRFFBYU5ENUFySzFvbjFpTThMMHl2WkZxTlh0U3dmVmt1?=
 =?utf-8?B?eUNLdDhVVnF0WFdwYVI2ampBSk9RYWdmeFFRSW1hakVTL1NyVENTS05uNkRL?=
 =?utf-8?B?N1lHMCswaDF5VTdHM2JUbzlvVnp0aU54cFlQQmpZNUlPM2t3ZlRrV3EyeWdt?=
 =?utf-8?B?ZGJqVmJreHh3SkNQTGVSTzkzb0tRUGJIOHdkMjI4OXhkU1UyYUlOSDFLZGJZ?=
 =?utf-8?B?TjBDc3F0ZXNiYVo4SGJZcXF2TFFoTklSMmJ0TXpPdlY0WEl5RUZtbHpTTkdS?=
 =?utf-8?B?TUhURmk5VnB3U3ZNTzE2ampxWTZZcW9aZTdocGluaFJ4U3JEV3h3SEcxczBn?=
 =?utf-8?B?Z2FxRzJhNFVGdXVYQVdNeGV5UkRweW5hNmN5cldnRGI3TUwxZS9KMXJVTDlV?=
 =?utf-8?B?Yi9waHc3RkEweDl0cU1kV0xwRHh4MWoxV09xR3FrV2dsZjhtUW05MW1oZkFv?=
 =?utf-8?B?TTNKRlhvWmtVNDE4bTlmeGN1YjMvRDFDSW1zc2tyVjhnYzhGMnRZclhCeHNH?=
 =?utf-8?B?ZlRhdGY4NXFham9BVmxWNTNSeDhFZUtoVjdmQURoQXNwVVM1K2c4ekNGTTNQ?=
 =?utf-8?B?VDRNeUJzajIwQVoyeVlxUXRmQXVsNm5salhjWXhYd1NyOXB1QkxEZWpGdTNo?=
 =?utf-8?B?Y2xPSkFTM1BMaU84YVllRFhpblRCQWdJWVNMbEdzeWJ0ZEZlb0FiY0lNOTEy?=
 =?utf-8?B?WUw1WVdPYlpXNzNjc0xKQ2p6K3lsSmVLd3RLbVE0TndlbHhjaUo5YWJza2lV?=
 =?utf-8?B?cVZmNGtvcVI4YXg1dWY3djYxaHJtbWQwUS9KV2h6WERWL1VKNlpBbndkdUFm?=
 =?utf-8?Q?sezPEByIj5xHv2FVEfz66rui1HvUBeIuSSBHfG+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c4fbb2-b4a4-4670-f10b-08d8d9124b3a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:47.0117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pORyBcllSQ413xREb9S17qtAPfnZcPgf3mu/FHMTQuWJg8UJpBohzNBr/cADP4caszIYZz5493Nu9TbLznLhkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <oak.zeng@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogUmFqbmVlc2ggQmhhcmR3YWogPHJham5lZXNoLmJoYXJkd2FqQGFtZC5jb20+CgpMaWtl
IGl0cyBwcmVkZWNlc3NvcnMgQWxkZWJyYW4gYWxzbyBzdXBwb3J0cyBhZHZhbmNlZCBoaWdoIGJh
bmR3aWR0aApHUFUtR1BVIGNvbW11bmljYXRpb24gaW50ZXJmYWNlIGtub3duIGFzIHhnbWkuIFRo
aXMgZW5hYmxlcyB0aGUgYmFzaWMKeGdtaSBzdXBwb3J0IHdoaWxlIHJlZmFjdG9yaW5nIHRoZSBj
b2RlIHNsaWdodGx5LgoKRGV0ZWN0aW9uIG9mIHhnbWkgbGluayBiZXR3ZWVuIGhvc3QgY3B1IGFu
ZCBncHUgd2lsbCBiZSBpbnRyb2R1Y2VkIGluIGEKZGlmZmVyZW50IHBhdGNoLgoKUmV2aWV3ZWQt
Ynk6IE9hayBaZW5nIDxvYWsuemVuZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpSZXZpZXdlZC1ieTogSGF3a2luZyBaaGFuZyA8
SGF3a2luZy5aaGFuZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBSYWpuZWVzaCBCaGFyZHdhaiA8
cmFqbmVlc2guYmhhcmR3YWpAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NvYzE1LmMgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwppbmRleCA3MjFiM2I2MjA3ZGYu
Ljg1N2ZiYTI4NGU3OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29j
MTUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCkBAIC02ODcsNyAr
Njg3LDkgQEAgaW50IHNvYzE1X3NldF9pcF9ibG9ja3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCiAJaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikpCiAJCXNvYzE1X3JlZ19iYXNlX2luaXQo
YWRldik7CiAKLQlpZiAoYWRldi0+YXNpY190eXBlID09IENISVBfVkVHQTIwIHx8IGFkZXYtPmFz
aWNfdHlwZSA9PSBDSElQX0FSQ1RVUlVTKQorCWlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9W
RUdBMjAgfHwKKwkgICAgYWRldi0+YXNpY190eXBlID09IENISVBfQVJDVFVSVVMgfHwKKwkgICAg
YWRldi0+YXNpY190eXBlID09IENISVBfQUxERUJBUkFOKQogCQlhZGV2LT5nbWMueGdtaS5zdXBw
b3J0ZWQgPSB0cnVlOwogCiAJaWYgKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSkgewotLSAKMi4y
OS4yCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
