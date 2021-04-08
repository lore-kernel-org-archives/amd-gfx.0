Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB0DC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 09:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8825C610FA
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 09:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8825C610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C2156EA59;
	Thu,  8 Apr 2021 09:57:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F6226EA5A
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 09:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0ZFOlcYKutczk5tTpB/t87XZj8ovBYFVtTTShRmO+3qsOk0zih8ZMKdIBfPDJAvW+B3MwY4pJapCg+onY46K3yAuHvaMXE7vAXl5UmjwreNH8Mg1Pvz8ZEstUcl5hMPwzePc1RoYcdckIee/bUoR7T73wenzJFw7IreN/DMQ7Iv7jVrNvbtZ0sTuDRvGrrRVb1gfSQv78ijv91MGTB+ADr1oXCld25seVmsu3fi8QUCnvqDRTVX9rkW0N9smx+N2Tgir/7kY2YBnFYYifPPdinV62VY8Pp1CWjiF8zODBO9BsI2OJtZQt8q6ZyUbeP4YsXLBwNtFyYttwf8mFhQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDMahuRWHaD4LuqzyMF5rRmEdvWTR+5R14xG3oLYfRA=;
 b=W24xDCAnyCQI7sj+fbajj0Hs1XtSQ94EfBI1psg9BIqHSjcXkPE9rG0KgmsQEBA3qDCbM5orWSV/ErvZg1QsWhPAu0EeW7cYZk+/XdLynLpi+8gAUApwBpmxgSVw8QX28Sb7UbRgn8FcantpVIH13CPgjdRmG2aBZKVLM+mEaSNDBe3vSMY1pNuCCg2L1mNh2vCAX2T2ZxrcBqrVMtW7x4T+alxE4STcywXNv9io+4fYG52t5XJ1cb9bBnOEqpnSJwPkYBj5HojAoIX1kACNw2ifkEKgLNXqAlXJahsqDyWvfTCiqjuzlUFbhimTEUhL1Q7ddNaAOpVE0/3OWz/mcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDMahuRWHaD4LuqzyMF5rRmEdvWTR+5R14xG3oLYfRA=;
 b=J6cCqiQ1Uzc2JO+ZPH2TcAyX/9sAZxWGr/2fCPIIOvo7oIJ6LetooBGfU4WxvRPn5Y34r+pJCiNij+4mvuiYRynovUiOQUVIK/46CwFBYq6ZqlAfxKIqGJj4Olfl0K4h3vsb820PKpVWjNwvPOeDJPPyYtx7/GAHED3RwiITt/o=
Received: from BYAPR12MB3640.namprd12.prod.outlook.com (2603:10b6:a03:aa::12)
 by BYAPR12MB3301.namprd12.prod.outlook.com (2603:10b6:a03:130::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 8 Apr
 2021 09:57:22 +0000
Received: from BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::445a:a6bb:4c3f:b565]) by BYAPR12MB3640.namprd12.prod.outlook.com
 ([fe80::445a:a6bb:4c3f:b565%7]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 09:57:21 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: enable ASPM on navi1x
Thread-Topic: [PATCH] drm/amd/pm: enable ASPM on navi1x
Thread-Index: AQHXLFoWm+eTh5bcnE+VYX5XbU8Xz6qqYc6AgAAAaVA=
Date: Thu, 8 Apr 2021 09:57:21 +0000
Message-ID: <BYAPR12MB36409B4E70AFE44E201E092B8E749@BYAPR12MB3640.namprd12.prod.outlook.com>
References: <20210408093256.10101-1-kenneth.feng@amd.com>
 <CY4PR12MB1287BB707FC99DAF0BB77F62F1749@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287BB707FC99DAF0BB77F62F1749@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-08T09:57:18Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=d13d2434-2e5b-4ef0-8e71-2f72ae0e8464;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f3d3934-0d1a-405e-3907-08d8fa74b404
x-ms-traffictypediagnostic: BYAPR12MB3301:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3301B429F051E369D18E62618E749@BYAPR12MB3301.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0YHc79sj9wT8G/WsXqCP2GlgYFgqnBbCv8aHS7Omnm9b/LEP7iak5KR111jQLbDHj6J59URqgBWt2gGM3gkSjcqQ6MGLBzx0XWyIexnzFZEn0mvlW+/MZUJJbBs86qMFbQjZxC+E0hWETLqekig4+o43ez3L+vJExOGQoQxlojri+7fV37q6rPxWDyI/xd48uLBbxqFlVlkfxbtztnLM/7lyaAbLaDW8KAE+0EuTs78o+QTZcu2mS/BGkTZ3hTmE82rSIG0OuRRaKqWgeW4L3kGjBQbUaG0p/bEAIB/bTBatugrUQS4T9Q+WtYdRbP8OM0b1igcbh3jwgy7dzL1214jufO4k0rb4unI31KGH3wjTvoyMfgWr5mXG7+trlgzjZx7dtnmPFDHjie9j5/cXv1zXKqMkBtR3HhjMvaQwytwO5D9VYOF6hj70zRwNA8gIS+CrSfQ/j1t2j2kwkj/vDhiutVcRnvUrekBluw0VKBoDGhzzT0Lsuz4tlQZh37zT10zz3Rc4GhiPtYdHyJbU7TlAZ8PR4YRzEcqiqxWCmAhH+9BLmv7yopoP92idUMj8QXbw0nre9yaZDiGcxcAEgOvenzPSqy5pulfs+CV3IEdBwQztdPi8snk9W2egEDE6JpAdB9Z8LbW5MR1BsGqV7ehLTNDfeEPw+JcSHbhyCYYnJsS5erlt+DxIL+kfiME6y0Q3xeQrN5/dQiqp6WhdkL/KMoixYf6+DaCUo03gIxiwrEfsAWclbKc5rXlEkTYH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3640.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(966005)(7696005)(2906002)(66946007)(83380400001)(71200400001)(76116006)(66476007)(33656002)(66556008)(66446008)(55016002)(38100700001)(26005)(9686003)(110136005)(5660300002)(8676002)(186003)(53546011)(8936002)(45080400002)(478600001)(86362001)(52536014)(64756008)(6506007)(316002)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yEtVWL1vplQX0wmj3jyfnPNocxGaJreid+a998Xz3zot633tHL7UzSGzd6uV?=
 =?us-ascii?Q?K+bU0++H27EFQNuwt3S+lhiryl/ny++OGfpYwSk1K7GAjpfuYuC3mEnxtFQU?=
 =?us-ascii?Q?0HO0ZeB7vMZBPhG8wkKMQ/dp9dPhUhC7DBb9dSpJhRbrERJpDxX0EUmyiAJS?=
 =?us-ascii?Q?5nARTbEoPNkukzGuCdIU6tGbpt3ik0DKFn3Bmnh9lPd4bpG2RKXJ4x+YPZYG?=
 =?us-ascii?Q?IQHT3sI6IOleMYGitjHF56MTbpbFP8LMR3LyK0W+yqLRIEAydcJLD6SfbCPD?=
 =?us-ascii?Q?FGlcvaVMNOikxBc8BNgI8OEZ8/ftw/SSDbxyduHWhNyWvcKwntK3G0/P0n2U?=
 =?us-ascii?Q?DWITfUJPZjw3wmVuYZyDmZAaLTw0TNNGsqnWBh/RmKNmP17wFLn2KMgJOAhp?=
 =?us-ascii?Q?jd9Z7Ztahp+IMmMk3lhwuuChQjWqkIlnKv7undY1VqtA0aeoeArYVzBvVaBs?=
 =?us-ascii?Q?tKI1yKbSK3KS0D6oNtxt2yUgW4Bh9W+C/tIfhGYGqVc8mCZ+jSFqyc8VYpxh?=
 =?us-ascii?Q?GwzaRkWjh/ctiW2sEq2/wGg5dEvHVGoLt8WQ3fd8pvxNF4sC+q415mW5TLYF?=
 =?us-ascii?Q?SXfskRTmS97WtX68AjAbD5eVyHax6FcANMCseJxR0u96QB27ekAc/FHj3mYK?=
 =?us-ascii?Q?7vfwf3jJtqPBAz4ETJm7iBVz9U+MmjP1YiMQT2bIdu/kuALGt6GTDrrM7Ee3?=
 =?us-ascii?Q?rKZinDwXbn/GQ0pTtFQdyDtBR+h/3Gcv/c4yMqmvD1ebQ3E9y0WNGNfGozgc?=
 =?us-ascii?Q?fIorouxJ7THFD+W060Em+NIeyYLx9+AlOy3HWn9Tc5V2b2pPJYv7nwzjzAPm?=
 =?us-ascii?Q?mK4deyfoUh0J39U5IBGWuqt8Uj6Z5ugfRyxk7WwsI/v2bELoNDxLgWH8ku/G?=
 =?us-ascii?Q?JsW1DWUHKhUXv/LHi2sTaH1Q1pLvSpeR7D+Zm3PRVK4hcv8FR86zkrP2lvXw?=
 =?us-ascii?Q?dqs4AiA0QvcsGwRvadxTnVcEeuWldRgyhU49Tko54VE8gQaWMQAlv7x9gu6k?=
 =?us-ascii?Q?rGRoRtBkqjXy/ZZIPwsw7dpPE7z2QTL5dXnZtd0a+dke9yaoqKhI6mijrHp+?=
 =?us-ascii?Q?WV9DXZMRnUn1mAVzAZXw4kWTxSUTACjBuZ0vOpKFL4UdzkTOfIWSw5LU/A05?=
 =?us-ascii?Q?59VYHd4keYIdIf5SoZIUzPeYiaZHjCroHwL42nsInDPIw9seui9yPSaWf8oC?=
 =?us-ascii?Q?jr3PpBoto8HjHbB1nXRJPrTk8R2zVO2cf4+jA8SyL80xW8eFf7z2I5okab9R?=
 =?us-ascii?Q?23m21jY8GlgecEmnhNu9FUvSLDrR2JXVEBKWYTVsRv0ZTztIiZOxVB7bzP+1?=
 =?us-ascii?Q?rS2wOtH6ckQcw6ZXqZLNmrWf?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3640.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3d3934-0d1a-405e-3907-08d8fa74b404
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 09:57:21.5031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SxR7tpFWNmTwT8NpThhz8w7OUNg+3NSAwSaBwKAxSWHQfl4G6QcQsbAEoai67C0x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3301
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

Thanks. I will remove the comments.


-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Thursday, April 8, 2021 5:55 PM
To: Feng, Kenneth <Kenneth.Feng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: enable ASPM on navi1x

[AMD Public Use]

* The ASPM function is not fully enabled and verified on
 	 * Navi yet. Temporarily skip this until ASPM enabled.
 	 */

The comments needs to be adjusted as well?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth Feng
Sent: Thursday, April 8, 2021 5:33 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: enable ASPM on navi1x

ASPM can be verified funtionally on navi1x.
And can be enabled for the benefit of the power consumption without the performance hurt.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 46d4bbabce75..5edab56c6ab0 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -601,8 +601,7 @@ static void nv_program_aspm(struct amdgpu_device *adev)
 	if (amdgpu_aspm != 1)
 		return;
 
-	if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
-	    !(adev->flags & AMD_IS_APU) &&
+	if (!(adev->flags & AMD_IS_APU) &&
 	    (adev->nbio.funcs->program_aspm))
 		adev->nbio.funcs->program_aspm(adev);
 
@@ -938,8 +937,7 @@ static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
 	 * The ASPM function is not fully enabled and verified on
 	 * Navi yet. Temporarily skip this until ASPM enabled.
 	 */
-	if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
-	    !(adev->flags & AMD_IS_APU) &&
+	if (!(adev->flags & AMD_IS_APU) &&
 	    (adev->nbio.funcs->enable_aspm))
 		adev->nbio.funcs->enable_aspm(adev, !enter);
 
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Ceb6ca4353559489ae74c08d8fa713a3f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637534711508933688%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2BtDRLzFCbPb5S6aC1pYNULjoSLy9jemx1QLUzq0CoOg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
