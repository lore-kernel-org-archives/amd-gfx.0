Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4B4C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 07:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2767064DDE
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 07:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2767064DDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A93DB6E9CA;
	Wed,  3 Feb 2021 07:56:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC0C46E9CA
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 07:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFUeKF3EOzSnlwOOlMioEipTLabq7CaYS8TVneTVpzijyYVV8axyjtpzUABk2H9k6tiOiN5qkMsR8L4b1BGmovFnF5fuPhxjq9ZoRQLwjtG0oWfgf/Bn1PdLyMikvV6xCHGXhMJx0TPp3ph/+8GJaQHyCZf+Une7dV8imgDnVGpApjT8I4/TWBuxk/oEB1rjctgyeFfl6qHqIP3ivW4GNDQE9IArvxbo9P6MMHnndJJEOl23JPZv6P9ZyiQYqX0+NxrobkJ+GP2ksxpoedlchTzuepe3AlTdO69/zp7tZUHxNDmHRO5lblzYmQmGPYSLmnJ0D0nZnnZnE4sWN/xdwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHeBCYESjkYTjArL9dpMjtbQXDC1W7B069uCyS0kUUQ=;
 b=JTa25O+lgi4hjdkMCUNlb20+yVabmYei+2aSC+LDLCw15sxkbipiT2+snSA4TG/YYqA9PLhfLX1UH7Re+V0VlgTQ1YB3BLT/BrDFsxGwFR3qUituLOwGIqXRxDu8ySZy7DWPGEK/mFZzan8lap0y174/GN580PduVKhLHSzXee9T13UC0hYQWqLPRs8CdUHaPJNLbEBOfrI1qo5tC3fgg4wkb6uDDtWFvdE7042A9xygGtvOm3C2mf+cUNVRbKJDr6g+HLrM/eRo+549ukp29j0WaE2uHZCZvgA9ffMzT7AuDKyMKcAwD9q3/fvXH2bqUzOc7I1iW8XSyzl+6TOLPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHeBCYESjkYTjArL9dpMjtbQXDC1W7B069uCyS0kUUQ=;
 b=EIOGrcXX9JVVdANYwrLjQ4zOo9nlUWKqwGLp+TuhMJNjz9uiGleD2AuAK/Zas3ia0c0qiIwB5WQC0mHei/834N0Ir0DdLUcHxE4eNVg1DdYr9SKIP8kEyFWP3/JZ8Zn/KHN2RglUfumWoP/8VBhwgQ9fhTqO+r6/OO+eLApnA3w=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB3776.namprd12.prod.outlook.com (2603:10b6:208:167::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 3 Feb
 2021 07:56:37 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%3]) with mapi id 15.20.3805.027; Wed, 3 Feb 2021
 07:56:37 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and
 DPM_FLAG_SMART_SUSPEND flags
Thread-Topic: [PATCH 2/2] drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and
 DPM_FLAG_SMART_SUSPEND flags
Thread-Index: AQHW+YdeckmeOCKCXU+H4m4W76tcIKpGD0UQ
Date: Wed, 3 Feb 2021 07:56:37 +0000
Message-ID: <MN2PR12MB454926B93FE2B67447AF46A197B49@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210202171748.1062530-1-alexander.deucher@amd.com>
 <20210202171748.1062530-2-alexander.deucher@amd.com>
In-Reply-To: <20210202171748.1062530-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-03T07:56:33Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5e5a67e0-73a8-4007-a871-b4e0f0a14ae4;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.213.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3e92110-5bf0-4e8c-8a89-08d8c8193b93
x-ms-traffictypediagnostic: MN2PR12MB3776:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB37762AE9B2E131BCF5DA9DE797B49@MN2PR12MB3776.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1DkxgIYFzaPPwVDqr4LrjsApx/GcYCkcECy/WvXQc2V6asTnR4s4w5rJizeuaDX6zT4jgwuf8u2QqNA7TlfaZmKqKxpGBSuEH+XZ4Sn1JPQUNDOfA3BmDpyQyfoqPonZ2B9bz6VQ9HBJg2n2e1S+xWHjGF3mPwROv1qtyb+Nsky19KcPQPOi0pT28Xg/Hv8rFE+P8nPJEXM3TDH5EHrfavX9G0LhgcOG0RmyNHYetfzVBUdTSuUGw9PyJzkCKr219nVC+nGFMq3E9f43Bk0azHumENE9gAMceoL3GSF1/mMadWr0az1ytMdQOt4zeScIz5QGi46gOX3Xv2b2vMLf9YYl2x3NejYqJbCqoljWlF4l5O4E3OlPusEzSDHk2RvBtPQ5AcDIdaWxiO9WYyEPM8y3f4yG+rnpNkcj4aWLmwECrsJdZwSDAyF0WKh6VgXP0acLvvUS9dBsXXNG4q/euRTRFG/uZ7K8ietosFuqvakG9mWxKsKvRz06sPIJkBXsFY3jKfRlQvYEZVkNpIgOzNokE/8ZhWtNquIQMdcSFZP3JYaaDvEkFy4iI6N2DyNn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(66476007)(2906002)(86362001)(478600001)(55236004)(5660300002)(8936002)(966005)(66446008)(6506007)(26005)(9686003)(53546011)(8676002)(76116006)(64756008)(52536014)(66946007)(71200400001)(316002)(110136005)(7696005)(4326008)(186003)(45080400002)(55016002)(66556008)(33656002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2igMCF9w7uUz6/wPsvqFXYeoMZAMiw+jv34mL2TnJ0gAQk8NJ90yx4zDOnZh?=
 =?us-ascii?Q?sHk9eKluanLFmgfr0N6M4EVPgXhCawjNFdOl0tcvUaIBj0nv34O67Ewx3krz?=
 =?us-ascii?Q?qnj91XN1EvQvy14fLzIhCJrGg+i7FpDW57uc2POj/lRXTKYZXVfbx8PT/mMh?=
 =?us-ascii?Q?irojuDW7tgIto0+Vy7F+giE4AudT9JuQgpUJyvA/W59tK0oMkU+crrXRrpM1?=
 =?us-ascii?Q?bBZfn6hKLlq2rqQ0jcT+e++bd2SIBLiPZx16tqLDN88Pnm0985U7N/37isOJ?=
 =?us-ascii?Q?MWan3U7VMQyy65ypC5HzBFwCyy9KKLcz3TNn8Ux++UTGHvXTwk6WJxJlqDWP?=
 =?us-ascii?Q?Qeq+ef7/xdEHnJQ9V4JK5HJwauIembxcrmtCk/zX1QqVPP3Ybzr4G9It3+eJ?=
 =?us-ascii?Q?cPYB/5Ma8yr9BUPbd6winWb2Z5pbJmnx6JlmL8mNyObQucboUp17tVCIiDmi?=
 =?us-ascii?Q?CYFdkrPwWAYCSIVwZEgbNNvIaq7ScsUs9fJ5lteau8p59SCtlJkq4oRB06Xk?=
 =?us-ascii?Q?vujGDUojJd0HgzMLSMIQDC3M3FMEAGJ9KBCe6g9EqwIOlIpfzLrC3FJvlYGe?=
 =?us-ascii?Q?t4N+JVz8NsLGmRGoZ8cLtfYLMXwY8LOlD9oYicDhGLp2n3OzV/Bnybw4EE30?=
 =?us-ascii?Q?q2MObylSVjpQzQH/MYRmV2JXuINyN3x15XZuv+tCeORK2RAAlp6LhUkxT641?=
 =?us-ascii?Q?kt1KA8cBcV6cDnvHPu/Ot/HRfuPQdxLjULrdsEKjzNOz2QghGB2YPOA2L/Le?=
 =?us-ascii?Q?PYviVaIilWsitEeewoNGP9I1iKrZVxPLt2vKNLvRCg8nx4TuDh+NOE+Wo+hk?=
 =?us-ascii?Q?w+gy3SaUN0jq0AEBqbBF5PXkRZnegxJ8HKE8mB9eLTG1N3D+P3qfzK0iMT3R?=
 =?us-ascii?Q?haeDykqStuj+8E27d5E9lmIpS6MZwZn6EUI02mUFpwpJgMrqUnQ+KX+EKLOl?=
 =?us-ascii?Q?sgzkFlsNfT6Itm05nA6KZVbH20KtX7Qc5of6VuaN4QRAUuk7cSXUkVIu2tYm?=
 =?us-ascii?Q?ZZ/DwcWPop5AxsPAfabmrNV6vqb3FnnXnz67SRrf1bNpM0l/AmyJZDmUI2oI?=
 =?us-ascii?Q?U/xJ35of?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e92110-5bf0-4e8c-8a89-08d8c8193b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 07:56:37.1162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+jGcxq3xJ6gDAsu+aRRsp8s9j6Kf3cN9HL5oP9kabwje+of1hUBjOs6MLvTM9SB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3776
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

[AMD Public Use]


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, February 2, 2021 10:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and DPM_FLAG_SMART_SUSPEND flags

Once the device has runtime suspended, we don't need to power it back up again for system suspend.  Likewise for resume, we don't to power up the device again on resume only to power it back off again via runtime pm because it's still idle.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b4780182f990..b78847fa769b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -206,6 +206,12 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		if (amdgpu_device_supports_atpx(dev) &&
 		    !amdgpu_is_atpx_hybrid())
 			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+		/* we want direct complete for BOCO */
+		if ((amdgpu_device_supports_atpx(dev) &&
+		    amdgpu_is_atpx_hybrid()) ||
+		    amdgpu_device_supports_boco(dev))
+			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_SMART_SUSPEND |
+						DPM_FLAG_MAY_SKIP_RESUME);

Device runtime suspend callback does -
	amdgpu_device_suspend(drm_dev, false)

System suspend callback does - 
	amdgpu_device_suspend(drm_dev, true)

One of the effects of this flag is for KFD to decide whether to evict all processes. It is done during system suspend but not during runtime device suspend. Will that have an impact if  the system suspend routine is skipped in this way?

Thanks,
Lijo

 		pm_runtime_use_autosuspend(dev->dev);
 		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
 		pm_runtime_allow(dev->dev);
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C8a6f7c5bbab84c6e71c408d8c79e7edd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637478830856688013%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=55Rfj9pO3cnGBiB1DkJ9yuyMMrKOvxhgYDajhIeUNkI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
