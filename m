Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABF7C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 03:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816F420756
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 03:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mT6/9Eza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816F420756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E8F6E5D5;
	Tue, 16 Jun 2020 03:24:37 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770073.outbound.protection.outlook.com [40.107.77.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAA6E6E7DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 03:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8M/5Fq0Ne6wAS3OSk2K815nHOd9VRv+tMVXEET4t7y4TfAYCMdN5h9c7X+ZLW/izVe45wLBpDDrBRvJOBaLzrENfJwjlBJINcwrzWnUqm81JTOsqJ4pg7geth8caBu46qukaLmr6d5FV0+XOmhclwbdlrGdp1B7i87/Cf0ReH4X6vzrEG6k8w79sSZBKd4GomBXCvjdIBogKfKhxuOI3Qt/xdJo3RhEcBuqWjWd/RBO6oJ1kDtVBc6Qph4+NxKMXhBPFTmHgrn1r2s8nuf1qa2eMuPDjWwMWZL10WWfx7wOk6PgU2t2+yNm78N83ta5T7R2HHP7YRgTnf+BW9QX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Etb0CHGUqb25JM+7+8QFx4MZb7Mg9iTiDa8Xh18VUg=;
 b=DnS5IFFp7bf69Yff6QPeJ81p+GX0gB5jQdxjXQxbvfaqAUsEcCCw0JOar5dDTWmP3UFsp/0Vpc2kj6lrXvDCEczZaPyKMwlLP+KUwy9TW/SZN1hEvFD6QqaWloieaUHyUPEb9IHOIG5uCaMdire0qyvlwxT7ywPAVIUhCgXiCYIysTJDHOvMVQBtMYMkeQ0qtEanqR1fukhjLrHJKUR8lRgkLFgcnoopPPTcjyci9JMDQl+D0hPXOUj4LQdOIefkjflbFznmkb4ny11CvxRG1/T0KsD2VzGp1wTAFgNCNjRbtVMQ/G3YyzST7X67AGpYSKLevD8Njbpk22oC9CaGFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Etb0CHGUqb25JM+7+8QFx4MZb7Mg9iTiDa8Xh18VUg=;
 b=mT6/9EzaekjgTqNVbZFja8MZVOB4MdQ7Bz26vfvapPwa4wIIK0/1NutMac4ARFLztLCy8LOWd/IM3hEYs3Fkn0swzYbEVbsx78hFQQsl/4L5qNIMWRR38C23KZdjsq9u0/djYOFuURrgUU32xsDG951361fQm1QL5Cw86X8lzQY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3578.namprd12.prod.outlook.com (2603:10b6:5:3c::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.24; Tue, 16 Jun 2020 03:20:12 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 03:20:12 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix documentation around busy_percentage
Thread-Topic: [PATCH] drm/amdgpu: fix documentation around busy_percentage
Thread-Index: AQHWQ1Uz2it4CD5LQUeWZ1SFvNCliqjak14A
Date: Tue, 16 Jun 2020 03:20:12 +0000
Message-ID: <DM6PR12MB2619AC19507D95067BA4FF8DE49D0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200615204001.2477190-1-alexander.deucher@amd.com>
In-Reply-To: <20200615204001.2477190-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8430f5aa-2a1b-49df-9da5-000056620e58;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-16T03:20:01Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 653c0dc4-959b-4ea7-3f28-08d811a42e74
x-ms-traffictypediagnostic: DM6PR12MB3578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB357808B2220D05BAD7E0BA29E49D0@DM6PR12MB3578.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q6k2KLOvjObqI+VaBuVDDkQ4wmtpSngC16Kx0aK0WegiKh1cGkD7CcyFM8Cmn4IcmTI79iMP4+OO9raPfefQhxkhwWachBcC17O0dB/zQvLpMc3RsHoudkLFZtfauktzKUqB6vKIWpbaLtjxmYosY/ryzFu+Qysz4gEIoMHSMAHKOSta5ZO8QrIgNEXlwL23U6etFPcz48YjVqu72uTlqEaagi6RopawdIoxlBeuslNec02Qy3qeNNFdO4u9rdjswf2MwL56fQ3A4dFvWBX5N2Zae538zVjtz9rKdWBwndEA36mi7Z871SyTbUeTSGA2On4wv7skyh9ptQwkqv2eNzX4RYEjYc8h5zwxs/bfui0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(478600001)(7696005)(52536014)(26005)(71200400001)(9686003)(8936002)(2906002)(66446008)(66556008)(66946007)(66476007)(76116006)(64756008)(86362001)(45080400002)(316002)(966005)(186003)(8676002)(33656002)(55016002)(110136005)(6506007)(53546011)(83380400001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: LqqmSEvyYxLbNuwnvLe9fIuwnWRKeVFpYMgNTuCvS9PYC/kxLq/q6i9kGcnVYqjNw9/2rKmq//RxAGw0VrKNbAHOEp3TGYDHpFtXRdRJn63sulOnKiNqXkwQeP68dyAq0JAJkdxasCMqoW5BSSVo2xO1HPFpN88LQAI24UbOvRj9l+SDpQA7BCvr/2dCHp5oqKFlVJVSIJdDKtokhah+U22nigGbA9Rc81t3aa0NLzquGBQUGFEYOVffDnW5IY4k6yz6CZtOfBxl4G9m9SKDU1jrJKVSt89kv0xvyyWrboGSAx0tZImu/fX8+lzLZI4zJ+gKe4Y54AMlgqsnZZtGiSRCBANt0nE6v/naCBb71fZ6FzBVxRAKEtdb0gktDnR8GWf+WGjKDnC5SjSObeshVNozkZuax+7pplxFyxip1WJN7oh0228EN/uCirol67r5ck+bNXqgJ3RZ2Ntu92C2/FfIZvxzQahCLcZt5aY+KUmj+QFr6rf7AJpp8JtLZ81F
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653c0dc4-959b-4ea7-3f28-08d811a42e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 03:20:12.3314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Dz11RBPPAGkKrhQfrVjmTSH9m3CRDN72UGyT2ILfMn9gnTddg1mhbjOSGgE28WQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3578
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, June 16, 2020 4:40 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix documentation around busy_percentage

Add rename the gpu busy percentage for consistency and add the mem busy percentage documentation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu.rst           | 9 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst index 4cc74325bf91..17112352f605 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -197,11 +197,14 @@ pp_power_profile_mode  .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
    :doc: pp_power_profile_mode

-busy_percent
-~~~~~~~~~~~~
+*_busy_percent
+~~~~~~~~~~~~~~

 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
-   :doc: busy_percent
+   :doc: gpu_busy_percent
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+   :doc: mem_busy_percent

 GPU Product Information
 =======================
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 5a8e177e4f56..42bbdf49458e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1668,7 +1668,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,  }

 /**
- * DOC: busy_percent
+ * DOC: gpu_busy_percent
  *
  * The amdgpu driver provides a sysfs API for reading how busy the GPU
  * is as a percentage.  The file gpu_busy_percent is used for this.
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C691ad901d90841f2421008d8116c520a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637278504263353044&amp;sdata=HMgi9aI7smavcUz4XyNbKUvCPSAjoxns7HRzDrqNf%2Bc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
