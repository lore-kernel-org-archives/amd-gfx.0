Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D943CC33C9E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 01:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1902067D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 01:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V0QtrSLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1902067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 374DA6E369;
	Thu,  9 Jan 2020 01:04:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B5366E369
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 01:04:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpOVVistEHGEoe/5m2+u5a93FzEhDAkFTggtQZsKHZvxBiDWdW2Qi8ZP3OAlbh/2KUAbvdyUlWrh+yqdvXPf1o1aR42XCvpaQrrtw9J2AsFCo9zbwsAVSDfiNCfgyiInFbxQdF5ge/9VUNeTL+kaP/EKDOINiuRzGUDakM6vdyHMec6PabKYbdeg+uakMIV26juZ+9Ibj9X/f2u53NfqitVfzwJqJbT+rDAzqwaRDfvlXpSfjB7TcCGxHiwyzQGCe7kKJ+rFZHuTc54uD/vszXCKGZnXIUNNMRpehrnUpc7PfuctXnf6LGjgGZDfcLmyRIWZkB1dnn7TDtgnK52BEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6D5EzlvmG4iqdZW8fC8+gwKt6y9nFYQlkem0IkiGns=;
 b=RKIKnTPy9LSs2MRfHlxECnfQlnvIQzFHXClgm6gFhRGRricxnrMquZBl8LPunJXph2S/WEwLaXb7bTHWbiXl/QvzburVNJfYxk6eYE+1ge/a5y3NTCP18zae1aqQX33SCqQNE3W73MC7ZdjZtDLRs9d6uQY7yNG0oxbWdEGL14vHUv2GilKRYr1XKPH9a7MtAczuBhXO5c14Axd/64qyY8Q/ffpKlpbbinUmgBhoLswQdTSsJxhzj7trQNVT2eEevvZMsRu4zNfzw9bmvfsR3lyr9TIRvVkX+AfdMvbohNrzNvAlYRGXfIIFtATadDu4dzNysBqKPEMnAkMDlKfLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6D5EzlvmG4iqdZW8fC8+gwKt6y9nFYQlkem0IkiGns=;
 b=V0QtrSLb5w+XinKqad4VKx5ECEEcZW6wrr17I9HL0fWPDMYtRDL6cczAdxWmF+drJXrGb1v+HYuN5wH6Ea2DkQf33RcP12zvtLKUbOkwGTeJmETjbbgjj8CRtO7YKAFfK+0l6/dhHkZPqHK/oQlp12a1dqSTvm1rX2cnTdmiDXs=
Received: from BYAPR12MB2806.namprd12.prod.outlook.com (20.176.254.20) by
 BYAPR12MB2711.namprd12.prod.outlook.com (20.177.125.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Thu, 9 Jan 2020 01:03:56 +0000
Received: from BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269]) by BYAPR12MB2806.namprd12.prod.outlook.com
 ([fe80::bccf:40ec:3b93:4269%6]) with mapi id 15.20.2602.018; Thu, 9 Jan 2020
 01:03:56 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>, "Clements,
 John" <John.Clements@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, "Long, Gang" <Gang.Long@amd.com>
Subject: RE: [PATCH 0/4] add SDMA ras error reporting support
Thread-Topic: [PATCH 0/4] add SDMA ras error reporting support
Thread-Index: AQHVxj8lsRgxym2mwUS3U+hnsNmvF6fhg5Ug
Date: Thu, 9 Jan 2020 01:03:56 +0000
Message-ID: <BYAPR12MB280698E2E5F2E059809C3C94F1390@BYAPR12MB2806.namprd12.prod.outlook.com>
References: <20200108161721.7727-1-Hawking.Zhang@amd.com>
In-Reply-To: <20200108161721.7727-1-Hawking.Zhang@amd.com>
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
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-01-09T01:03:54Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ec823f5b-fe8b-49c0-aea3-000028541906
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c406ef9-9bca-4072-18b3-08d7949fcda4
x-ms-traffictypediagnostic: BYAPR12MB2711:|BYAPR12MB2711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB271106880E0BFF297D0567C7F1390@BYAPR12MB2711.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(199004)(189003)(13464003)(8936002)(478600001)(110136005)(6506007)(53546011)(66476007)(8676002)(6636002)(26005)(81156014)(81166006)(7696005)(9686003)(186003)(316002)(2906002)(66946007)(33656002)(4326008)(66446008)(66556008)(64756008)(86362001)(52536014)(76116006)(55016002)(5660300002)(71200400001)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2711;
 H:BYAPR12MB2806.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZJIjpX286fTysDQU5X2iWlPm55f8ZjcgJzURf6fZdsGg4h+ijuz3YbHRBD7YfgbQCVbktUuS8Pma5tc7G77+tQ32g6wge4CGBFl8NxxsUXYt5M6PJf9URvXT5n8a3yQi31RsG7nf/yfGT2Wy3/Giot7t4OJ4E1PDtjQ2vGTctEJm6BRSpTEkKWspjilYNhJi4MHhhYrAINYstQlUxOMi6V55bNDSrsssarxZ4vz408ElGRUX+PYpRNJd1duqYEGv+M7mEXnGV0MRbk2Cqh45/q2uWWjrWhHvnudss0JHonF3FqPgU3oa2RQbLYTZCdd5qpE30yznddIfu7ntBBPbOOlbKYV/JgD1r+yODspK87DnbierolEV2pSw1vuTVsvk7MsmWo5/XJPPqp4kQ4o4TCYgikq0BsaEy84+LHzefstl4zLnPw08UG1a1xO7Hkny2EED5pGPPMFq3jufkJHYhW8lFXgMGUEPNslfLO5wQPMTHrRsbOnM2f4jeHmgqhEZP9BJjPdAf4XpAE/ZRiUsiw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c406ef9-9bca-4072-18b3-08d7949fcda4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 01:03:56.4400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJXUABJKI1csz+nDVET8kTPPcnqH9Mv8+b008FE5aDbZ/8wxB2MlnEJZPVfMgwCyAFp7W3A049PhjGLVz7gKGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2711
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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
