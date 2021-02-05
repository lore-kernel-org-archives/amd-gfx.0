Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0994C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 02:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52F4B64FB0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 02:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F4B64FB0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0477E6EE1F;
	Fri,  5 Feb 2021 02:10:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F39D6EE1F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 02:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKUWV6GraqvQQg1JPIkpEvJ1+bcs/dvtWQJo4JD/D+zYp+LUe6dv2QgUCZDJmEtw39WBLOn5shzzoda2rc4B8m99qdTNOPlT7AyrqLxASc/KGjC/Z03DnP4PGnJXkRfZrahTvcDdk/ULITGZbzKqgLMx4LuSgMngBPJ8i6530Raf1wJz7vALiqcqT2PNumsrAxJaqB4XTfGJsOGdW6mspKPt3MXEY8/8VPW3V8TW2kRAyl8mGhnaz/qDxMwHiv2Le250hkRaZuyLcVGzsBGEukZV8kDs9qlD7bKMx+WnCugNS1oW1AV+j2s6Z+YCFathFtgeyQ3anuN5fAVsSLWdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt3db2b8FimL7DAyA4fJHPhch6eLouqcFFHEzpIPPwg=;
 b=D3RB5fKbZMa9UeW6OxvrV6MXbbhJq8zPedzzgu6tQnQq7l2KfRHr0qg+mRTQ4cKs+RueQLcbRl3+17M+yope7I8OkuaExwXR0y5i8dOkaGhVtTaiQ7j9yF5XQ41IsW6XbZ2BLp0Wo0GTDuNAuxmO9u7Qz69nuyre23rgwIyMiHlQf5a2haxoGi8cY89Jc27byX1f25rJxQ+SOWOqGe/tCyTzRGt0DduXWekZG6yzAqoZYUOxw4XxKHqlDmZexriTJhhDjOgNvYsb/3SDWMhnPfd7bwrY2xN2z8YlyUlAEEcvbXEas1bTcVCPmEAtomP/CHxX/V5ALK03jqSgihukyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt3db2b8FimL7DAyA4fJHPhch6eLouqcFFHEzpIPPwg=;
 b=XtpVBwooL5CQSZLeK5dYNL+JeAO0qvyt6M6+mitb2rPplrBLL84ErWsIxtqwKKnCATXV6B5rBFuPRghvqmz6P3T/D6le8UjQQl2Ob9z5vxKK71GRUWVjETs/YdOZGqxaTNaELb5lXVlbkBS/3DyYhAxHU1w8eEv2aA5l3s8kgls=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3274.namprd12.prod.outlook.com (2603:10b6:5:182::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.23; Fri, 5 Feb 2021 02:10:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3805.028; Fri, 5 Feb 2021
 02:10:04 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: reset runpm flag if device suspend fails
Thread-Topic: [PATCH 3/3] drm/amdgpu: reset runpm flag if device suspend fails
Thread-Index: AQHW+wQsx4U+1SVv7kmKQ1AERClhpqpI0aaQ
Date: Fri, 5 Feb 2021 02:10:04 +0000
Message-ID: <DM6PR12MB2619BABD1809234B6AD97840E4B29@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210204144329.52506-1-alexander.deucher@amd.com>
 <20210204144329.52506-3-alexander.deucher@amd.com>
In-Reply-To: <20210204144329.52506-3-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=686bae34-cc20-42f0-839e-4feceb313d35;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-05T02:08:49Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 504a1875-65f1-4537-4c12-08d8c97b2715
x-ms-traffictypediagnostic: DM6PR12MB3274:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB32747D328B525658170197B9E4B29@DM6PR12MB3274.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ggbWFSwQvw9wY0UieHEu5h3dKYLjcfDpkeBTa0EXVlfbXGP7W6hXjiw6it4nkElEjoopLNo1YVNfI60bVADppEZJCCDe0ONaTnmGe71BEG5R10fldzLTIWSmY9rpcXdcCcjMY5nxeCvGY6SAycUlDVWEJLUWuMNBGGcT1ild0XbF8NCh7+aA5PF6GpLtfRJUTzWUszHVroF40zMMapPCD5oXSHWSaIZfz6M7JEg/gFBetxGoOFQtl8Ems/fPVWznO7ArtMk7AREeK29XQOXrQ8TehtxRuP5oZFwkHr552etum6pS6s8sz6dziY98EaFqealKN3b6ZL/2e/xZgGX2gVakJlYaIhfQZhb/Uw2YgR0gsRsjmVyzSbuOVvWKP4L/3uY2HbDNHjC3eFSsSTzV6+v7du9PIK7/2F9M4F/BUgAYnKVpRDyp2OLKsYHehGnnsHKyUUqWgW7m//DGYx53SxQK06t5dZMthL46kpytJvkktWgFbZgh/Xo16W8d+0Bm9XPGA2ZhpIwmYd6IYaRHD4NLRA3oTL6Iyx0pX1xiyS28xKTvKPWBlK66k8KKC0fX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(64756008)(66556008)(66476007)(15650500001)(66446008)(66946007)(76116006)(71200400001)(9686003)(55016002)(86362001)(316002)(186003)(7696005)(2906002)(26005)(8676002)(478600001)(52536014)(966005)(8936002)(4326008)(83380400001)(53546011)(110136005)(33656002)(6506007)(45080400002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GUUjTxNWnsqTTNpCeEUl3T6Dq8MujweiuB9kN/AmdWo+L+120LA/RXVwUU3D?=
 =?us-ascii?Q?0pVZ40g38isZSQUxPCiZb4ANMwxOIO/g5IeQnOFKZi/XhnUgBm6dffxwojLE?=
 =?us-ascii?Q?HfdHvfx1swWK6fERkEyh1MckdW49sxSY65OaCQzwvdgbeSCF8DT1Mz7x+J0y?=
 =?us-ascii?Q?FNL1zPfZqxqeIrEbCFIY7nqnC80i7YQ0D2D40a8AKgE1dqdvydbfPTIkav8c?=
 =?us-ascii?Q?ouGr9kzbFpJdYH0i87UJ3AMfLOIctflE2Mq5WyqqwAsPZvYBfkeYccxLT4ri?=
 =?us-ascii?Q?54pRq1NS5Pxt1SsvG0wMkOzfu259aQM95kjSpFsMj634MMAsoDVOX+UZb/yN?=
 =?us-ascii?Q?Edsb/1bzEBBrRJQRDGJnwMKhavt+ZwvXJPRvRjxU0arQ0IjJmaxHVtrJdv0N?=
 =?us-ascii?Q?iRaRtA1G0p+xa0G16QTRR970NoVSX7pwd9BwkxQ+dijOcP7QmtOK3e8lQlKm?=
 =?us-ascii?Q?TpY2Ye1itoi/VqYSeN3okraUqr/y7jhvtDXCOEMrwlF95pDFP0iwSz3zRFrw?=
 =?us-ascii?Q?mGxcVxh0gMQmG0pksH189RzDGnCXHWXKfc5cOLSnKDiuN4IUABL4HarVxsjA?=
 =?us-ascii?Q?TARzrHPm7w/OCOekjCW5GheOnNZLmv6MNd6QpUmbRkTVmoJBp2CK5Qk/cIIe?=
 =?us-ascii?Q?23Rl1eezoz9mrAFIGkhGzMHQ9CeB0XzfyT2ElUyIIlIQm898LRbtj/IftLIR?=
 =?us-ascii?Q?vWpvWdrJM9enO9aISgxhj4u+VGXGJmQdhHTKveYJ4LLDf6OqQv/LbvnEEd1+?=
 =?us-ascii?Q?2Ny5Zu1knSookidtgRwGl9OTAUQdR6fjvqtx4P7MozSO83uV+gNNLqpdzT3W?=
 =?us-ascii?Q?DSmbOjU7MuIKUHGYKRR5/zytuHQfgGyoxosR2Qv+Mcl7A9IhPQVaMSBENP+3?=
 =?us-ascii?Q?1po1zxqcUm20ap6WCC3v+hI4Xw5AhwYpOdyVUFj/WQ53ovFqSJYnxMwWzbvT?=
 =?us-ascii?Q?drgymRDIzZG7D2FCvRDG6hXiL6nECkxh/pkZcOouwpBwOmlZfYaKlZpAOJbD?=
 =?us-ascii?Q?hSxLUjKjOJX983tG86vls7axtin0MmfKABQvjjOm96iUSKAubSmQsZ7Qin0f?=
 =?us-ascii?Q?GilswNLKh+iHa/kpbDqP81dJ6kim0014/8kY9JmXnMsONHjZLG6rIrf4kZZF?=
 =?us-ascii?Q?r6130DB7p7i+55Cv3hePH9AgVOkQwmduX5aYEUbvsYGCEityGRicnzkqRwNn?=
 =?us-ascii?Q?JWBB5q7d1m8EKHR4qLNk0TC+6CMnNDBLz10Hpihg7EQG9cWrCVeuOxCg+b7O?=
 =?us-ascii?Q?LVvar9CuAjunF5ia6/tsyJHKfdEDNmaf24z4aizeQjlR2PjxSavvNy/VoGNh?=
 =?us-ascii?Q?XRlFfUINary/r7JTepiikd0C?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504a1875-65f1-4537-4c12-08d8c97b2715
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 02:10:04.5283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eek8n+qh+UIakBC/JhpxTBpS8S6uAJ+uBhAdd0CK3rIMsS5QBLf1mfhBWKJlaiVA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
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

Series is acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, February 4, 2021 10:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: reset runpm flag if device suspend fails

If device suspend fails when we attempt to runtime suspend,
reset the runpm flag.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c9821f1dc357..e5c2377a54f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1369,8 +1369,10 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;

 ret = amdgpu_device_suspend(drm_dev, false);
-if (ret)
+if (ret) {
+adev->in_runpm = false;
 return ret;
+}

 if (amdgpu_device_supports_atpx(drm_dev)) {
 /* Only need to handle PCI state in the driver for ATPX
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C5402b357d36044fe5da108d8c91b4c7e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637480466394703835%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=JoZXlRyAtQ0pDgsDEne7%2FuwRTud0hvFBe23j1cMUL10%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
