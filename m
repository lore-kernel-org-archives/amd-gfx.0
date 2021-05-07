Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A21FC433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 07:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9EE1613F0
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 07:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EE1613F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A406ED8F;
	Fri,  7 May 2021 07:10:11 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760073.outbound.protection.outlook.com [40.107.76.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0861B6ED8F
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 07:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpbQQaPMMsIZ/mrYweOOS+KsGn/bJ7p97AfWQF4RDFlIBt0hBDucK5xk3TfMNNc6Hh1wGS6rlxw5N6RpY7BqQwN0Z13yLpYbr710fnZ+v7AlQtoXk/4sb4BEjEGHx3HBXGPA/RJNnLRV4K0vb4kAhQFEBF6WxYg+CWCkRXLYXOl6+is2ZHtbkIkXOLfNYXdIyTSuE/DD6h1d4uFU/yP4b6xZIA2Ct/xREkXx4fNn0I+hLZu7yvEeo6/GMCWXzgF7Kg9EYQ+qnpztDQl77tcreWHrGBDnlAhHkMb8RYImafgCHIjssBxe5mbo753WvdRkW/dPQm4D85K7qw/8XN6mGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0sd860z9tviKHmww9DbD/dobJdtmNbnbywjiIH0jnc=;
 b=je4T2RcHPXwCrnDbx5IHTAGvdiCS4nJul6s+4JR1vtXRbsqqj7Qq6pfK5EPd3ne2R8lr4DzQW7yuOWrwySONX+SzFfia9pLXEQ2Ru70URuyTaATmQqEjgHO3WIuLHRj8qcEMKNM2A2z9gMVL4RaRu3HhF+KHKvo9SgmnvgacDGsFmU+v16FdtL/7h8nKXvYooTmNNQdtU5pYvLIIaqfWZCHNH8R8G8QuDKQoSLQ/xtnFr6CXk05e/bWaacYgz4kRIV/cG3RdO8/oNjOOXgyYcah0gWE5LpqqU5c+S9VlMG3yt6c85QL2WjF92CgZ1NPu2iUV2jupqAQhX3WAHt+JwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0sd860z9tviKHmww9DbD/dobJdtmNbnbywjiIH0jnc=;
 b=JqNaelRH71klKvITQIXkQQU+73aOUG+UXAdkB38PMmxcXY6s2qy8HB3El9TR7kGx6WYNCrVCbW7xEQlAk9L5B36bLgmJlHTfpl5oKmCUqG3zH8fbvQdald+9QufgEBHb+OvmnNHT3DD+9IztbRWkdhf2BN4zwngSn4BtY5WxwtY=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.35; Fri, 7 May 2021 07:10:07 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::292c:5927:cb7c:cffb]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::292c:5927:cb7c:cffb%7]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 07:10:07 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Song,
 Asher" <Asher.Song@amd.com>
Subject: RE: [PATCH libdrm] Revert "tests/amdgpu: fix bo eviction test issue"
Thread-Topic: [PATCH libdrm] Revert "tests/amdgpu: fix bo eviction test issue"
Thread-Index: AQHXQl3x67tXHmSIbUKJ2qA3wy2GjqrXmsbQ
Date: Fri, 7 May 2021 07:10:07 +0000
Message-ID: <DM6PR12MB42508D945ADD562AAB8BCA7EFB579@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210506095509.7815-1-guchun.chen@amd.com>
In-Reply-To: <20210506095509.7815-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-07T07:09:50Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=372f4c87-077f-40a1-83dc-854e1c4ded5c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cd1c1a6-ea17-4335-c568-08d91127255c
x-ms-traffictypediagnostic: DM6PR12MB3308:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3308F6E544373152D00B3FE2FB579@DM6PR12MB3308.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:28;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0bI/T36vKkh8Rr5FwLdQg0cBonRUGf3Sqx8RPKN2hjAvJGjEDf+V4oQFS08RO8r59vDZDBRy/v1kLS1raAzaR/XYz0WoCLoWxNpalRJCKNztBAHurE96cFx6js28PdeoCS8Iwf4BwYAiR8GJBZ5D8/LphVvx0g5tR7FoEEYmAt2AuLDbOA0cBhxsHBgg6dBTR8hwxehWlybWYINfO40da1UMWfrrCTi/xx/ffBbkAePLwsCmGkux8oUCBNENCuBAfcquxLv/eDzdXoqMBDRIZJEpqWPIUgipHOT+LWoi/iNpoYUDU1YE0gHkQR3coYOoyUJJX7+WcDQwj1JDqs8venpN0gS93442gHzqdhg1b5SOjfAHtGLX9ai9Q1J5amurEhfb0fYNBd2wxiA8XMlEPVZWq5B6blqp9dLiyLySPRMWKHkm1pXtYciHuaItt4HfITdYTZMmkZZmeKO3RihVK6iIAY0/dC6iBrLDPqDdUMf4R45BYjNoAj2BzkpVdoEo2vNEeTmcMmFMHrFyCZQCoYNVcUptr/ZSGn3NSnFhYqLlExH4WtUSm7eE/4yyadVw8CR5vRzTVfKiRsadt5f+jWkIi9lC9310Xt7E0zLPZk0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(2906002)(6636002)(478600001)(83380400001)(122000001)(6506007)(66446008)(76116006)(66476007)(8676002)(64756008)(38100700002)(55016002)(52536014)(66556008)(26005)(86362001)(9686003)(71200400001)(186003)(53546011)(5660300002)(7696005)(316002)(33656002)(8936002)(66946007)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?LzVKL3RvYzlHdkZQTWFpZlBobjIwN3lPOGJaSXBKajFEZXJraFpOL09m?=
 =?iso-2022-jp?B?anlYcjVBUnVDeEdWdXZhWVJjVis0YzZZRDBONUZPM1NBc0cxV3FVWG9y?=
 =?iso-2022-jp?B?R3JEdTEwQXl3S2xpcnMxS25IKy9xWlh1ZE5XamE2NVptd1JtYWg2N1RL?=
 =?iso-2022-jp?B?ODY2WFJybVZqQk9GeXJuYlZWQlVLRVZuRmgzNDdOc3crYlh2ajVFbTda?=
 =?iso-2022-jp?B?RVgraW03YzV0ZTdRbXNiNzNHMERPbldrK2VEN2JSOWJrSmNLMmtjQmtJ?=
 =?iso-2022-jp?B?RmpGSWk1SHU5RmpJaVpUeGtHN0dTY0hGaTN0Qm9xRDQwNGZram50YU5p?=
 =?iso-2022-jp?B?bTVQY2UrZDNpWEc1bFVUYk5TNlY4V1VPVngwZkRNVERpU090NjhVUzJs?=
 =?iso-2022-jp?B?dUh3SjBLbUtFTlZ1TWNjVzAvVGgzYkxiM3RwVEZNSmpPZVU4OUd1SWJ2?=
 =?iso-2022-jp?B?NVo1eWpyeGhqWEJLMnJHSzBUVzZOb294SlkwWlY5ay9sM2tWS01GOXRE?=
 =?iso-2022-jp?B?U3JjVUNQUE9Mamtqb3ZYdWpYdmMyUjJTZVJ3NEFRbnJWemZsUmYxalI0?=
 =?iso-2022-jp?B?Wk10RGFTV1FUdVVMRnY1OUI5TTZpVVRLSVkzREdBSXAyUTkxVTFZMWdL?=
 =?iso-2022-jp?B?UXMxeWcvd0U0NEpvT3M3eFRtM0NVbmNybmZrRnVVZE55SEpYclZnRDdC?=
 =?iso-2022-jp?B?dUlOQmo5eThoV2ZoaDRWQ1FCSHl5U3JzSG05ekxlUnlvYVRZUVdieXlC?=
 =?iso-2022-jp?B?ZUVMVmcwSXpvaktRRk04czZxRlBzb25DcFc3YTN4VTZEK2p6cDVKWXY4?=
 =?iso-2022-jp?B?eG42NGw2eFRMS2pZSmpraldlSVk2NlMvenRKVlVtK1I4RGxuUUZPV2I4?=
 =?iso-2022-jp?B?eFArK1hoTjRGdm9Pa3Q1ZlR0elM1amdrdkxuNytYcCswVnRETzlyZnJj?=
 =?iso-2022-jp?B?RWJkbTRXOHRkVmlIbitzTWRiQk1zczJtejhyR3VMR2NWL1NnYVpmSzBl?=
 =?iso-2022-jp?B?S21QTW91eUo1RFJLbHhZTmhqWlMwRHE3SmRNVzhhVDl3R3RrTHp5dmVO?=
 =?iso-2022-jp?B?bXNzSHlxWnFycmF3U3FFWklYV3laQ3lGR0srb3M2M2hqeGgzOUtVY3BT?=
 =?iso-2022-jp?B?VjFYMzREK05hUkZlSTVhd1JCUWc5ZVBWYXZHSWNVeEo3SmJZZXYxdjJi?=
 =?iso-2022-jp?B?YnpQUmpGcG1xV2hhaWhwbC9YbkI0VWFlZ2hma1FodEl2QTlsSGpIQUk4?=
 =?iso-2022-jp?B?MjRQV1c4dkdPTHd1ZHVhRmkvU3czVkVuTHRzajk3UDNZaG5IZlR4MFNr?=
 =?iso-2022-jp?B?aXJ0c01PQkRvUlVINitmaWRuT1RLdzA0VjVKTDR4R240ZitlSS9mVXpH?=
 =?iso-2022-jp?B?ZzNJNG5KNkhzbEY4MzI2ekR6WitqSGpGcXNNOXRMSUxSZC9LZmlML1JF?=
 =?iso-2022-jp?B?OUFBcHZSZkw1UW9xTzRhMFVjZU5TMWcxSm85b3EwUzViUWdieS9MZHRG?=
 =?iso-2022-jp?B?SFdsSDhHLzFoMjRRWDFIZ244bVVrbXA2NXQvMXQ1dkppOHNQUytRMERY?=
 =?iso-2022-jp?B?WUlKR0lhSCtGKzRhWGFUWnlHTU9UMXhmSWZEdFlCUHRQYzN0N3B5by9R?=
 =?iso-2022-jp?B?aEF1enNmT2txaHpoZWliVjI4TU5wN3dSS3dOdEVQTld5aDZqNWhJMmFR?=
 =?iso-2022-jp?B?VjFvbGtra3JSUkc2V0tkZndqYlFwdjZzd0pwWXBJN2x3bzZiM0hGR3ps?=
 =?iso-2022-jp?B?YUpXWHErcGhFbWk3MTFLbGhhd2paMkhxWjRxU0dTeUl0dHRsL01hOUM5?=
 =?iso-2022-jp?B?QTRDVVhuZUVWODBlc2drekhNb283dDdpc2FWNmQwcFFSRk4yT2s4djRs?=
 =?iso-2022-jp?B?L1E5bG15bEFHSjhWTFZIVTg2Q2VWb3E0dGVPZlFvT3p2US9rU3I5enZm?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd1c1a6-ea17-4335-c568-08d91127255c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 07:10:07.6704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0BYGUzzg/DlbLkOFimJ1Ofd2O7TleK/9yCDGnxgKOM2RKjgAW1Ll/7a2GQfKTzxIVp8PQZmuX8br92jcSdEvtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3308
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]


Reviewed-by:  Lang Yu <Lang.Yu@amd.com>

Regards，
Lang

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Thursday, May 6, 2021 5:55 PM
To: amd-gfx@lists.freedesktop.org; Yu, Lang <Lang.Yu@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Song, Asher <Asher.Song@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH libdrm] Revert "tests/amdgpu: fix bo eviction test issue"

This reverts commit a5a400c9581c3b91598623603067556b18084c5d.

bo evict test was disabled by default per below commit. So still keep it as disabled.

1f6a85cc test/amdgpu: disable bo eviction test by default

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 tests/amdgpu/amdgpu_test.c |  3 +++
 tests/amdgpu/basic_tests.c | 13 ++++---------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/tests/amdgpu/amdgpu_test.c b/tests/amdgpu/amdgpu_test.c index 60f3a508..77bbfbcc 100644
--- a/tests/amdgpu/amdgpu_test.c
+++ b/tests/amdgpu/amdgpu_test.c
@@ -496,6 +496,9 @@ static void amdgpu_disable_suites()
 				"gfx ring slow bad draw test (set amdgpu.lockup_timeout=50)", CU_FALSE))
 			fprintf(stderr, "test deactivation failed - %s\n", CU_get_error_msg());
 
+	if (amdgpu_set_test_active(BASIC_TESTS_STR, "bo eviction Test", CU_FALSE))
+		fprintf(stderr, "test deactivation failed - %s\n", 
+CU_get_error_msg());
+
 	/* This test was ran on GFX8 and GFX9 only */
 	if (family_id < AMDGPU_FAMILY_VI || family_id > AMDGPU_FAMILY_RV)
 		if (amdgpu_set_test_active(BASIC_TESTS_STR, "Sync dependency Test", CU_FALSE)) diff --git a/tests/amdgpu/basic_tests.c b/tests/amdgpu/basic_tests.c index 8e7c4916..3a4214f5 100644
--- a/tests/amdgpu/basic_tests.c
+++ b/tests/amdgpu/basic_tests.c
@@ -928,15 +928,6 @@ static void amdgpu_bo_eviction_test(void)
 				   0, &vram_info);
 	CU_ASSERT_EQUAL(r, 0);
 
-	r = amdgpu_query_heap_info(device_handle, AMDGPU_GEM_DOMAIN_GTT,
-				   0, &gtt_info);
-	CU_ASSERT_EQUAL(r, 0);
-
-	if (vram_info.max_allocation > gtt_info.heap_size/3) {
-		vram_info.max_allocation = gtt_info.heap_size/3;
-		gtt_info.max_allocation = vram_info.max_allocation;
-	}
-
 	r = amdgpu_bo_alloc_wrap(device_handle, vram_info.max_allocation, 4096,
 				 AMDGPU_GEM_DOMAIN_VRAM, 0, &vram_max[0]);
 	CU_ASSERT_EQUAL(r, 0);
@@ -944,6 +935,10 @@ static void amdgpu_bo_eviction_test(void)
 				 AMDGPU_GEM_DOMAIN_VRAM, 0, &vram_max[1]);
 	CU_ASSERT_EQUAL(r, 0);
 
+	r = amdgpu_query_heap_info(device_handle, AMDGPU_GEM_DOMAIN_GTT,
+				   0, &gtt_info);
+	CU_ASSERT_EQUAL(r, 0);
+
 	r = amdgpu_bo_alloc_wrap(device_handle, gtt_info.max_allocation, 4096,
 				 AMDGPU_GEM_DOMAIN_GTT, 0, &gtt_max[0]);
 	CU_ASSERT_EQUAL(r, 0);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
