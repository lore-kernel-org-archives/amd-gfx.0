Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93157C4361A
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 04:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C3922070A
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 04:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3922070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACBDF6E50B;
	Wed, 27 Jan 2021 04:32:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2053.outbound.protection.outlook.com [104.47.36.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A14646E50B
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 04:32:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGM6LernVg6fCf6jXDHcorhKznzwuvSNq6AekXAbfP9t4bV4uWa6YDHdFiQDq/US0kGpeMr719hIa4cKYjoeaF6UhKPifGhOt9JDCLyLP3M6S0C9mZ0cxeDhEtpCQFohDUnK61VSq4B8Bwb7KdCpw/u1BGontKhgka01bgYsy+1dMyqc4rpAz/auT5YKsu22er13GP8gY9F6aZI1imY3CRIes0958+ezHKD/4nJ2honTNCdtMx146rWYr+gee5x0bVS09IB/4U//YDea9nPhSStHU51CjSsyc/+uLSh4RsCN+BbEQVSVtcwn2hOoQxkDv8qjuMKJ2DpB3HDjQjqWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IL1AKAwKEyocgIqavBbUrwHaIvOd+0747wEH0WKic4=;
 b=QkiRAzIf269a2D1dfYkVnqMAo3kh7BcmHHjRenf3nMBMvHgyVQ0wGxf6Oxs/Ue0qxjzfggQGu9tOgvci98vGszZWXwUnzUac+d6X9YH0zpy/+cjwGc1Ior7zX8tJrVEHl6EV/tsza2YLOtJ74WvmEBAUgyrpYtTxEgE0t6s8CCFrHJOq8smjsjCSa/UbJDy8sKO+bA3uzu0imboUdsWNRRdrFPUsqJL14qp1DMOMuw75EeuUDERirR7vIHp3t+x4di1uXFGw8dKSeUBRHxM79NhogsrihEIci4u93dw6tnaq1ZjoeqHxv3Wta95rYYib1uNtvE+fWhUf0wos1deG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IL1AKAwKEyocgIqavBbUrwHaIvOd+0747wEH0WKic4=;
 b=KKGrJKNiHmiDyBX0ck8l0EvpYYHaJfC7iQkLqHEscWTt4rnS4rXyfhXWjo250jV872h+eTWYgdwNi1NT+JwyOw4bnplgeSrIUy3SGRIrz+IC00wUlgLt45i9o9h+q8/iaOFEWN8lHGcNrZIE98gI0ZTIKhA1kn8sKot5AIh0jHA=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by BL0PR12MB4690.namprd12.prod.outlook.com (2603:10b6:208:8e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 27 Jan
 2021 04:32:43 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::e863:8081:a14d:b03f]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::e863:8081:a14d:b03f%6]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 04:32:43 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback
Thread-Topic: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback
Thread-Index: AQHW9A+A8B54h1FnhECsUfCRTVBIg6o61ZoAgAAMlgA=
Date: Wed, 27 Jan 2021 04:32:43 +0000
Message-ID: <MN2PR12MB4549F13AF76627118690566597BB9@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210126181702.48944-1-alexander.deucher@amd.com>
 <DM6PR12MB2619EE40237D99D8A666CEFAE4BB9@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619EE40237D99D8A666CEFAE4BB9@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-27T04:32:40Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e5178df8-3432-4c35-8158-f83dd22b9a2c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.208.238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2d3b4b9-8d33-4df6-4bbf-08d8c27c96d3
x-ms-traffictypediagnostic: BL0PR12MB4690:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4690FB27BE8126062E9F327297BB9@BL0PR12MB4690.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 39JOoUjyARVZ1nNb5tVYooKM1FZDU0ZXIKJpOss9zTDzPDtRvthqGVJDu8z6OhBTE61jcWcNxIK2+d+A3dOi2yO4OXp9UTRZUeVIGG+cqzJEbo+aJeTXYLdZOvVZtyJgVgBm5FQu2LWVtzLSgdK5ttfzXnb7lWyTOjQVEk5ywy8pdH9CbY1eMy2xNAX53KAwZ+Cr/tD7lOeM7bH6TFU9rNzDEACPvUPC6+vBf+FQkSdjtkHs8020aCovbR6uLA8vOG0p4OFYXCsb2KCMGL2D7WNlJLDeV8gEvSATRnwn++HubM9dqSHzuA16EmKcBQz0JyFbR0q08OIo2r7Rt7zwaQo/0rWd5BsXlcY9SQXahlM9QYcKiqqS7zmPCsdwyY4lIDjVhDLzfW4cStke5xMWvpOVbd5MxF0314r2cDQqHHk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(7696005)(316002)(110136005)(2906002)(478600001)(86362001)(4326008)(966005)(76116006)(52536014)(45080400002)(66476007)(66556008)(64756008)(66446008)(66946007)(55016002)(55236004)(53546011)(6506007)(71200400001)(186003)(26005)(33656002)(8936002)(9686003)(8676002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?d7ujzb5427ZlZ+XgWHHCpD6NFLOGopMapHmdPpW/0hJKgBl1RHACEn6MnEVa?=
 =?us-ascii?Q?Dl67FoQV8rAxdXgcqh9XE2+aB215pxjzA3c6ZSVLSetPe0wGYpyLJ8juaPYX?=
 =?us-ascii?Q?I/3TAImlSuMKfxBcVKroTqXyrAMFAKQ/6iLoFDHm3DGGGkPVELzSGkakoi7l?=
 =?us-ascii?Q?0pB4qsve5nBTQVukE7IQ3sw3VKTPn91TAYfwKwTLPYaTy1Raxs0Z9UWM7Y5J?=
 =?us-ascii?Q?JdAVIOM4dzSaOYZqm+iRgzbgAQLzXOdGh8YTzOdxzLZiXAZVTXfZUg6Qnm+A?=
 =?us-ascii?Q?J2XkuMn56EMJHJOOauJeoGe/yBKiQiLxJjd8k/9PrZzSv05x8obY6asbYBr7?=
 =?us-ascii?Q?eobi4EkQsh0dQsq4QGk+o8w0yLygmRDG6Mkm8oC36EWP4SHyrspxCLHOmVgx?=
 =?us-ascii?Q?+1AGz7VIwM/O/cgYM8MR3+Wgpyj3sOPQgMTW3l43sdeBOinEd/Vms8J6HbCJ?=
 =?us-ascii?Q?OhHryhl6O0aI0xQyB3N/gvL9AbvCkxfDkoEGBZdhlSKUEAbCg4j4/E2VtZSM?=
 =?us-ascii?Q?ownf9tfaeUrWzbYi97xs3cJDMYcp3XbSRmgfzqmV0eohioTzX5CqxJ99/nUP?=
 =?us-ascii?Q?r8zu2sqVK6MO6ymYInTnKCyMx2CY9alP4oxaFYBc3eVc05Hv4+HguLLrR1Sz?=
 =?us-ascii?Q?skn0lOa5bZeURch8n/77NNqCEl/xQRcY67n8/MbrlXa9LHC9kd7OW91xULCn?=
 =?us-ascii?Q?xF/FWwT/wTmlJskRm4bH59aPMwQAPwEv5C4Z/QwDRbgZ2JzzNp08Ohs01mUS?=
 =?us-ascii?Q?IzpcwBLhPoU0iLWaBG/ZAPxA53R53NpiS1piur7LfHnzpegfqnoR7JvSITPQ?=
 =?us-ascii?Q?mnyfN7Br64EVhE6+N4ZMgxCj1xNWWLk5AhCaAKAzKy4BnNK5ghVvzdq63pqh?=
 =?us-ascii?Q?tvSkVdNTJD8uTDbu4QQjTOHc+7x+220AoEcsVpVGJJI70XTYWb/VNseDQU9F?=
 =?us-ascii?Q?FSMVVTocQMPqP9/0fd0At7tJO1jMx9Uqm0jdLDVWFw3glOQ8ByMIUDiGpdDQ?=
 =?us-ascii?Q?ZYpnwSije9qpQtrrT5Sa/RD50Hva4KeefLyvNkOdO/77BmWqq+h78nq78Ud6?=
 =?us-ascii?Q?EeUjOkHR?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d3b4b9-8d33-4df6-4bbf-08d8c27c96d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 04:32:43.4261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUgIOqJv48hu8M2QoEKChxL3iQjT12HoX5uW+b5Z8sH9Mlu87BpL7v8kgMNyWAwD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4690
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

As crystal clock is not guaranteed to be 100M always, it's better to hardcode to 25M.

Thanks,
Lijo 

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Quan, Evan
Sent: Wednesday, January 27, 2021 9:16 AM
To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback

[AMD Official Use Only - Internal Distribution Only]

[AMD Official Use Only - Internal Distribution Only]

Actually after switching to retrieve fan speed from metrics table always, this API is not used any more.
Maybe we can just drop it. Either way the patch is reviewed-by: Evan Quan <evan.quan@amd.com>

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, January 27, 2021 2:17 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/pm/smu11: fix static fan speed readback

The xclk needs to be divided by 4.

Fixes: acab02c1af43d3 ("drm/amdgpu/pm/smu11: Fix fan set speed bug")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 147efe12973c..36dac106ed4b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1245,7 +1245,11 @@ int smu_v11_0_get_fan_speed_rpm(struct smu_context *smu,  if (!tach_period)  return -EINVAL;

-crystal_clock_freq = amdgpu_asic_get_xclk(adev);
+/*
+ * crystal_clock_freq div by 4 is required since the fan control
+ * module refers to 25MHz
+ */
+crystal_clock_freq = amdgpu_asic_get_xclk(adev) / 4;

 tmp64 = (uint64_t)crystal_clock_freq * 60 * 10000;  do_div(tmp64, (tach_period * 8));
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473159427515107%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=7xQ9%2BLQ8O%2FiLSkGngF%2BYHqleC6WKAJ2aLHe3Vts%2BTts%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Ccacc23400e334530b87208d8c2760341%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473159427515107%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=7xQ9%2BLQ8O%2FiLSkGngF%2BYHqleC6WKAJ2aLHe3Vts%2BTts%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
