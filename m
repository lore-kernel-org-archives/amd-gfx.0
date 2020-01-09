Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F212C33C9E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 03:20:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14D22067D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 03:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f7EHmm3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14D22067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85FD06E384;
	Thu,  9 Jan 2020 03:20:27 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700075.outbound.protection.outlook.com [40.107.70.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFF126E384
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 03:20:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fraMw92jwbZ8fd+bhdetkrGs/BFbMI0b+a8/3+dh3toqkEnY+opDUUh+X602VNn3pldjSJTE6HuxB54urir3VZqdXIm30dQdOvSx8Susktn6zKV5Xtgs3fRuXqYDX4YdRuYEqma8UoN9dJslPR7WJZ8GmVgaQGE9KlZCGSnW4P3xnWsihtJNkMq4nl2Spo/tlRQYV/t+6ufBjlrKkjnQMpZQ/MtFebM+vCC9Dlwjji7pnz8JjAF+AcQvgXLbdBHkAt9OzCGDOlybugKOuezQk+6oKW7gSSntDtNZ9xloRTsMRDmO4IoSKnshYJTwKoKBqY8LYZu3dyuIgvz6JKYb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gamiqv+cghkG71Gdt2hTjAMaDDOlsgYiwUEZljlMdNE=;
 b=MNud3QCRH71r4K6iZXtEER4sur4WcY2gOnQFBMz8p5OJfv00TxXv6kBTCZ9qqt81LT5aJfHZIJ1rOcIHgOwvhotNpNXItd2ef0LSI4znjpO29EGjfUZe677exgdmu0xzFu572fNeIr9oA52OKZmTa7x+uCZWIT6G1PdwT0xUaOqIBZb0HVBZSptS6thztDsm34+PPvIp8EueCizhWvUR5fN6TXATyzBPmnaceAe4xVvG1MggIWqZITqIgkAyiPrWxOqdO7W61KHk3ydmmWcmSwkYmR9i+8gkVtEctqcGoHVfjPRQLd00Msc9IQ/6PwLYlcDsuf9E9h+cmK+G8A8l5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gamiqv+cghkG71Gdt2hTjAMaDDOlsgYiwUEZljlMdNE=;
 b=f7EHmm3JC9uJDAyLXJzI8sxJ8hYp6ZjdGmlF78DrwMU6fXUfJAIKgO6lmmafQj5X2qK/+PIP9r82UZQsGf+oJH+tinJDPo2LUUOWgQd6R95EFyRMuxPoF86cSTpmPy/uwdaLnf9XrDRV4Q6UY291zTgs95DGaS3FJCJ3PHVIfJE=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1434.namprd12.prod.outlook.com (10.168.238.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 03:20:23 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::4dfd:ef1a:1fde:9634]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::4dfd:ef1a:1fde:9634%3]) with mapi id 15.20.2602.016; Thu, 9 Jan 2020
 03:20:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Clements,
 John" <John.Clements@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, "Long, Gang" <Gang.Long@amd.com>
Subject: RE: [PATCH 0/4] add SDMA ras error reporting support
Thread-Topic: [PATCH 0/4] add SDMA ras error reporting support
Thread-Index: AQHVxj8l0HBXXJEdE0+rD676d3tylqfhhNcAgAAiG4A=
Date: Thu, 9 Jan 2020 03:20:23 +0000
Message-ID: <DM5PR12MB141856570CDF444DF61F3FB8FC390@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20200108161721.7727-1-Hawking.Zhang@amd.com>
 <BYAPR12MB280698E2E5F2E059809C3C94F1390@BYAPR12MB2806.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB280698E2E5F2E059809C3C94F1390@BYAPR12MB2806.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-09T01:03:50Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=71457068-96fb-455c-a148-0000ca15fe87;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-09T03:20:19Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 434dae17-1540-4c30-a9f8-0000cfda7a78
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5af3a374-f26a-4967-fb44-08d794b2dd65
x-ms-traffictypediagnostic: DM5PR12MB1434:|DM5PR12MB1434:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1434C117665FECFA1E066340FC390@DM5PR12MB1434.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(199004)(189003)(13464003)(7696005)(53546011)(66556008)(71200400001)(66946007)(66446008)(26005)(76116006)(33656002)(478600001)(6636002)(6506007)(186003)(66476007)(64756008)(86362001)(52536014)(5660300002)(9686003)(8676002)(81166006)(110136005)(316002)(81156014)(2906002)(55016002)(8936002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1434;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 12xf6F7RSKLT9jqwKBHLQxd4ak7qi1HH1gnRf8GVwktZ0+dEOS+X0iM461L8q/1CrvahyT5R0Simw+vzndSRlpuhMP2Aly2SZ8hbSruBB8dNaZQK1ayEHhSYgko476tpoaBixC72b4zmh77PgcuDyUbv6qA2GpVthHqCCLUcu5kUeB7Ojqso3YXsIdWf6zjXGXML5er1JcTiDYlJVikn9MWh3ZAfsexXfo2WDEuJI3YcWhUsxNfzMPfqIm87M0MSo0rjy6gzGlQ9fhyH8r7LB2ayPi2Xjwf6Ex86iQxEKRqNPF/Qi1SrguyccGY5KK03nGCMK0usIzOe/KOFLatUs1wHOrRq0GIu6BgZ2khxGmriM3ZFwLc7X+4AeCS4rB56iyv3COFk4dPYzw0jky0QiNSTfVAJBS4N6yeDNqqCafcqbASMTsmNNbUsbsQzmkcysAD8HkQ+EBcwLMl10wvbRhbwyO56r4yjJC9vwG1BlNaKLgrl4dYYmpW5wiUIAkLrkpbwBKylHP98ZZ9BkWuAew==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af3a374-f26a-4967-fb44-08d794b2dd65
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 03:20:23.4542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HsKP6s651GEeF/pADormwjMhkunOFl5lEOmektxQ55K+L4ZSFnuihkCFKV08qxRNDDfi0PpV4/DoWmMKNAkbNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1434
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

To address your concerns

1). The SDMA_EDC_COUTNERS will be cleared by HW after the reading. This is a read-only registers. Either explicitly clear this register or programming EDC_COUNTER_CLEAR register is unnecessary.
2). The error injection and error reporting are actually separated features. That's saying, users may not be allowed to do error injection to generate the error. But once hw edc feature was enabled, the driver should be able to collect and report error information.  

Regards,
Hawking

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Thursday, January 9, 2020 09:04
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Long, Gang <Gang.Long@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 0/4] add SDMA ras error reporting support

[AMD Public Use]

Two comments in patch 1.

And one more question for the series is, we add SDMA block case in ras query, but no such case in ras error injection.
Then how we get to know who triggers SDMA ECC counter? Still by the GFX injecton?

With above concerns fixed/clarified, series is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Thursday, January 9, 2020 12:17 AM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Clements, John <John.Clements@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Long, Gang <Gang.Long@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 0/4] add SDMA ras error reporting support

Currently, sdma edc counters are grouped in gfx edc counter registers array (sec_ded_counter_registers), which results to several issues including:
1). count sdma ras error into gfx ip blocks when querying gfx error counter (i.e. through sysfs gfx_error_count node).
2). kernel crash (access NULL pointer) when querying gfx error counter on vega20. there is only 2 sdma instances while the gfx edc counter register array unifed arcturus and vega20 cases.
then driver will force to read sdma2 ~ 7 edc counter registers even the ip base address is not initlaized.
3). unnecessary/wrong grbm switch even reading sdma edc counter.

To fix above issue, the series will separate sdma ras query functions from gfx one. check the sdam_edc_counters and report back error count and the error type as well. 

Hawking Zhang (4):
  drm/amdgpu: add query_ras_error_count function for sdma v4
  drm/amdgpu: support error reporting for sdma ip block
  drm/amdgpu: add ras_late_init and ras_fini for sdma v4
  drm/amdgpu: read sdma edc counter to clear the counters

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |   9 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  11 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 176 ++++++++++++++++++++++-
 4 files changed, 191 insertions(+), 12 deletions(-)

--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
