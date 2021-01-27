Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA81C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 15:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA2E20771
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 15:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA2E20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB6276E838;
	Wed, 27 Jan 2021 15:25:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E7F6E837
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 15:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt9XRT/lLn7LCr3cNc5QHxmrJSyYjxiVR9Jmu4c12l32TaP3p6gRpQh32sX7tYeVWbrLp9DbCZnSjUXLmO/4PTviGh9tjziJI9CBO3RMGPYQvHr9MlWGHUKc6AtArIxZHrCUDzCvgNPsoyzF01rULW3mKu2PyxEY1X0Savq2RK3QhTNPSM4fnRiidTg2lpotQFs4cAiokB/u7lHGJ4YzlZqQ+XTqiwA50r9bIT+BIuVpPOll8OYifQxxp41gYiDCLTXEZONEVA/A5cE0qCBDzt5EDlJjoHDU6d3p4x6ulK//Xd7BQPH2ZOc4xRwaMr8p2X1LLTZ7584it3+lK33fWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEcdcotvKTI/Jv0Nn6tycaheW/hv3dlwBD+BFbw5YfU=;
 b=BzhmXUSQpJw2qdKrKQovsdg1xXsJGBmhu7avAeaL0s1UqQFSFapAUw+tbDj3QDxkVGKWrVmCzM7nOM8bZyEdwFtNCSvYDwCuOiILj5+j8mu/A22WvdlY04aoO3Js/o8/X1zeaoJ/kHJhq5DSsrjHvJp4NkSncmABdJtDNC6cwtWPnpKVFLiVyl2tk3u3sDtyNr9B03HEdOrHuxh0debSbvLQ8ojydfvtzzyU6Fh3QH+MYsKDa3RgYdttpTYqUanVaaGv7XBpCYmYg/aQIdWmgt395dGba6Tea2B1D4LtJWugaBg/fvBIWfm3Ol7bZzY6bXM4zEgIY94OMCHkeG0/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEcdcotvKTI/Jv0Nn6tycaheW/hv3dlwBD+BFbw5YfU=;
 b=Pol7X3fktpNO4Jo0tGs157bvHY7X0uW9A5yk2ZG2AZ7SIreWJloKgsMNVK/GVVd8WdcfYO56SqHI5FYgk2Kh7W5r0TbvUgRk93gt3cn9QsjNN5J24Qy/bPftBxNFsaNGIXAXud0DQ6dKH39khJYVmIYznAIG5+UYtIy6uHxoKII=
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM5PR1201MB0169.namprd12.prod.outlook.com (2603:10b6:4:55::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Wed, 27 Jan
 2021 15:25:26 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::d7f:f19c:7565:99b6]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::d7f:f19c:7565:99b6%3]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 15:25:26 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: bump driver version for new video codec
 INFO ioctl query
Thread-Topic: [PATCH 4/4] drm/amdgpu: bump driver version for new video codec
 INFO ioctl query
Thread-Index: AQHW9G3bOLfF9H99Ok+KOqLebqOnZqo7mE0g
Date: Wed, 27 Jan 2021 15:25:26 +0000
Message-ID: <DM5PR12MB17875E64CF8BF12EC66F40CBE5BB9@DM5PR12MB1787.namprd12.prod.outlook.com>
References: <20210127053231.202843-1-alexander.deucher@amd.com>
 <20210127053231.202843-4-alexander.deucher@amd.com>
In-Reply-To: <20210127053231.202843-4-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=032e2cb6-c8f7-4049-804a-6b362925daea;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-27T15:25:02Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:9880:2088:19:7101:5c38:8381:4a8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38c23ff1-83b7-4f2d-cffa-08d8c2d7c5bd
x-ms-traffictypediagnostic: DM5PR1201MB0169:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0169282102D382C4863CB66AE5BB9@DM5PR1201MB0169.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UwhCGrflsUHi0KWz5k3NUOcOF69mGhF2MlUUMAJkAaF3Xe2ksKjdLz++jqcn9pFYqo63dDV5myyCeAtE3QUJ+aC+HdYuav6XCVGB+OrfXbGsjd/zV6PJLpoK/Ytl8hBvPOpRi23vzc3f4xy4gLkO2V+mrIXhMc4ZMeKFGk8pMFohRA+V2dyfQ2MzL81vh4bVyX9+VtqzcLOwbzeIlL3JJlh3zVq4o5KcDgTGVqLPfat2yXt9jP9uSKukjSyFS4dILY1GPpD92dbz6U+v1uxy+sxTXaVJE4baxl12gLcWLsX5nvDhJHBsZDi5tyfLBnuM+SUuDFRe7z9nwjQkY6/MojqdbshPQk255xhlNy6MWOm9m0yp8A8YXu63gj4FiD9hFjzqsF0Nefjm4SSeG8Kk53CkvWalhuy20B9P+s4OITNXwA96AYo57CRRo42z97keHASxg4RhX9I7t5CQCex7GJDqn6xHfxk4ObyUSvJhPJvTyG2VxSV+erZb5JS9YtDkFZTR7JYX2xvYORIHLlkd1lJaDOC6XJKVwHIDBe7xL9n/5vmLVR7GXplSfwBcOdTJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(8676002)(5660300002)(66946007)(76116006)(6506007)(53546011)(7696005)(9686003)(33656002)(110136005)(66476007)(66556008)(64756008)(66446008)(4326008)(45080400002)(71200400001)(186003)(316002)(83380400001)(478600001)(8936002)(966005)(2906002)(52536014)(86362001)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BLGPvhOtPEfeKGQOs6P92jwHmt6IdJaghlomX2lzeyDkcLM4idjc++2MMXAT?=
 =?us-ascii?Q?xwySb6J9h6I0ybjwC64S3OkE1RKm88BNzfY419IgbdJR+uwNP0LJSFUHB544?=
 =?us-ascii?Q?q+GPXDmXji4Qf4eKQsjlQZsn2Eg07OqJkHw8vccOzON7CtAq6KV8Em2NeqYk?=
 =?us-ascii?Q?fYAldJ9MImgsmATN9Joar1hHkOfELWq6LsgkDACKfj05qxVifMNJXw5Ao9oq?=
 =?us-ascii?Q?pncuKghw8EYlrR/BmxNm7Kw9iykIPnds8aYvu9n3yjLPaWNcp9sV+zMhkK5z?=
 =?us-ascii?Q?KJgpRxw/YkSXq5gfqDP5Kgi9waVPB7fizjVM0Nv7oyI7E757ZvENL/XIMQtp?=
 =?us-ascii?Q?kupx6qaV3gUCkyrC4fPQrymuXZBtV84F+2O6AFyCAasDuvVVaqoM2yWK6log?=
 =?us-ascii?Q?j77cIGH9ywj5VFZ8jcWys2HDb8CglkdX0VXCSBJAImxGEY2CvaTNKb1y6EjL?=
 =?us-ascii?Q?c5RXVKnsnKB2rdQLKida/qTszBnZn4TNVaSUoE7cU0UwNZwfErTyhqmajNlt?=
 =?us-ascii?Q?j6czMGoW7WR4vehnYBiJzS+ce+VuvgrBkOeswZCvyGoVWQq33uMkxyfKyQJD?=
 =?us-ascii?Q?jvocuz+C/kXKODExi7F8ItrSrTqahpqOPG9uD82KU7ICHG6IPsUahv61oOYP?=
 =?us-ascii?Q?egkGmc22IiA98Hzuoz8/jCVkl4ZmYxUTQO28ft+TT8tnYYGaSJi8U4nkqVtg?=
 =?us-ascii?Q?zlTn9yo5m3TBHNwPBAd6nYcIriTWGHSNb8or5TP9Wg84twNzxjg3dU4neriJ?=
 =?us-ascii?Q?hmZxGM2y+bavXrPMG/TQkPKpolBOq5PFK+g4uQgZq7RkzbhgxNxeG7CA77Xi?=
 =?us-ascii?Q?D/I8NBTK8hGNDDmHaXZFXCOIR54p9fC5tjVFlBQw2LhUu7Z7ZKhHe9Cx1nJ1?=
 =?us-ascii?Q?a7iMhQXhDW0s/njwHfry72uuHhTei0HdMR5arlz+aaiakbPKf0VY3TVmF/Kv?=
 =?us-ascii?Q?nTJt+9vlXDp0jZWFPNGvDMgMjkowNnc+yutCNsPAp72g4POQ9F+xFaytInIy?=
 =?us-ascii?Q?HC715IrRuYvw7i85ZDPGitTngYiXu6vnFGMe0wtOIjruz0hYuzZM6XUl3cSr?=
 =?us-ascii?Q?Jlagpx5mu6nTg9qGzYWLK+FUJsYkjtJCcErUZXPA4r1hNyg/W2e0+bILXUtc?=
 =?us-ascii?Q?raqJtusxSw6y?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c23ff1-83b7-4f2d-cffa-08d8c2d7c5bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 15:25:26.2714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5j1Zy7lu/8lp7jf6PZRy0AJ8+VjOsbgS4dotc60YzLYVQDoxkg4DMP26RmPdw6r8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0169
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

The series are:
Reviewed-by: Leo Liu <leo.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: January 27, 2021 12:33 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: bump driver version for new video codec INFO ioctl query

So mesa can check when to query the kernel vs use hardcoded codec bandwidth data.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index effa9062f541..021c2386778e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -90,9 +90,10 @@
  * - 3.38.0 - Add AMDGPU_IB_FLAG_EMIT_MEM_SYNC
  * - 3.39.0 - DMABUF implicit sync does a full pipeline sync
  * - 3.40.0 - Add AMDGPU_IDS_FLAGS_TMZ
+ * - 3.41.0 - Add video codec query
  */
 #define KMS_DRIVER_MAJOR3
-#define KMS_DRIVER_MINOR40
+#define KMS_DRIVER_MINOR41
 #define KMS_DRIVER_PATCHLEVEL0

 int amdgpu_vram_limit;
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cleo.liu%40amd.com%7Cb5fda388b89a4295995e08d8c284fd6b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637473223735530829%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=8IC5CmO10YRja0spv4lRMyeCR8eaWgLsDjpy7cZTHMI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
