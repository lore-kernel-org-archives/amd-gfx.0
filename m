Return-Path: <SRS0=FsAh=JQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27A2C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 19:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C81461360
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Apr 2021 19:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C81461360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CF9B6E42E;
	Mon, 19 Apr 2021 19:47:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC436E42E
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Apr 2021 19:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShQ+1zAQIw0VBbqzM+VcLVlm61TD17EBV5m4QHvSL76aVW6Kht8gjfvp9lMkSLrXFc6xNWgK2VwVrQuXHyP9NOkIHmNmzGcfmjUM6b9c6dU3ehiVzdpHqTEXB1MLpCgcvpGNq+oub7BTFtUJzEsqrizQbXRrw9dYw5n03dPIzkHrHnUGrlOPZnT47k7CajgN6r3RJsYHuOnh7GNSjLk494wQZQgpr9oJaTDCZWQht+UerfHYFUQ+VJ56wIBFdn3O4vG33pbxLYP77xkUyoEHnds/zytB3QkBP+T8Myb9OYUnnI10GP7sTj+fdh61i8y2vn0k6UCaCibbpT/7CBuRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtEqhfA5rlDLgVt+7VHlipOXzc9yQAdrhqKsylYcY9I=;
 b=MWHKNf9QC4sK520pqqgqpSwkJcbKJT9rVsfacig1c7+phRxXPtaVRutGIm8m19aaNZSQvsl0sieItLidFluZP6hSQDYTyHbb6puO7YIAM37Bqzan/WhfmtjECJlCQDUcN9871aX3pSDogjBt/dXknY5J5nMOvV6ardDxt7lzqQ1DA4/QGUckZx6LhO3sJCSBWGl8xGp5yNHbo0xxblspT3HxRiESrR0gZgs+20+b9ZPXI6BtRvVnCyE0+EXtZXTuCxir9lIbb7qvJzb5bYTaGKFz5FDqM0X1r1kZAYPJ1Xeyo2oKT7RJfAZK7uTKn2lI+R3D5GO+Z2sdzC/mnn0Dwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtEqhfA5rlDLgVt+7VHlipOXzc9yQAdrhqKsylYcY9I=;
 b=BR5/GJF7Kou+JicQFvB7/449CSvZCSClOJapBrfZlcPijKXY1r3qYWbmSCrWYyUhsog+hbvMJMP4DXLdkgeUoNbM+LAKFZV/CscdLJqFCgJx9yKHnIIz39HBuPGrdGCI+EG3gjvwWR6Uc8nkKeca3Zkn3FwWSwPma5vAxayPlEk=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB2907.namprd12.prod.outlook.com (2603:10b6:5:183::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Mon, 19 Apr 2021 19:47:48 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::5194:b381:c345:eb0f%2]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 19:47:48 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Zeng, Oak" <Oak.Zeng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] Revert "drm/amdgpu: workaround the TMR MC address
 issue (v2)"
Thread-Topic: [PATCH 4/4] Revert "drm/amdgpu: workaround the TMR MC address
 issue (v2)"
Thread-Index: AQHXJy8hhek5I4xNuU+bkTJNCKhC8aq8W0LA
Date: Mon, 19 Apr 2021 19:47:48 +0000
Message-ID: <DM6PR12MB2761FFB07DED54B474D56C818C499@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <1617306129-5869-1-git-send-email-Oak.Zeng@amd.com>
In-Reply-To: <1617306129-5869-1-git-send-email-Oak.Zeng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-19T19:47:43Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=478d311a-a92b-4ff1-892f-123966e81fd3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3ae0:384c:4df5:cab0:d20d:80cc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eaa14529-9082-4dfc-785b-08d9036c026f
x-ms-traffictypediagnostic: DM6PR12MB2907:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2907B57CD7C82C7C97F6BE968C499@DM6PR12MB2907.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /8npKwSDIkQp1eQfMz5RUxSjn4ICKKSnLsl0VGyD16WP1BjGLu0zDbHfH1NcDm90eeDt7p0cDDqTBLE9l/Ro50Taerf2Sryjy6Y/oZkCEyhdLODVKviwtnXNT5upDryEpT3eyrLt4WFaleuBOpE7BP9Cxi2jvg+p28C88CnbMCdJPM++IIkDwylcls04JoNw6eoQATNCa8PpifAuHqmhARcKiSSf24ifXkkvB6T2oZFvtTGnGkXKxpVfhPHw6lc6wUrMEeg1zKTjGVptJNolR9xuQ9ZR5xyZBmHbHMuqSHZLTflwD4/lBV27HcUBkrwf9U6yDfzFxIQzWuOh0uRVcB32AIvqb32fAZdwbEnfqUbZkdwsN6+2+G2CvedSiXaFiNlx1Vhocx68BFqJLTHfad4L3BoOBEVU6Hb+pqZWmA7gdfHa6TCHmcZ7rEW/S4+iVx27CdcJleXtE9dPrfP3ZqxuY41tH6NXgV29/zRI79cxRnPnw7Crmz2NA4WBwoFoR9Udx8t0qfl4iaCEUQePn/dxk3R5dZYzkWt8MZBGLuK4DL21BXT0+2KG7ZKPK17CAbVzbFG7jtAcxeUDyfpNbu/0dC7OSpR+2/e0fQGdTWVvUhhgXfUBvjWpIYdUX9GkyzYBPwA66bNVmDAD6jCCUw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(66446008)(186003)(71200400001)(83380400001)(66556008)(316002)(86362001)(64756008)(2906002)(66476007)(52536014)(5660300002)(66946007)(33656002)(76116006)(6506007)(53546011)(7696005)(8936002)(55016002)(54906003)(110136005)(38100700002)(122000001)(966005)(4326008)(45080400002)(478600001)(8676002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Dw19Ve4jf6ncBDSNU1KsPQwqmEW6Iey+FtOActsFzB1B9CXrf5FSxQSRfPt1?=
 =?us-ascii?Q?gFq1ZbOuOVqYynJZDWkj7iRvO+uB9c35zPC5nlMNoRVUZabZgUhCB8NLh+hS?=
 =?us-ascii?Q?irmhdOy9i2842xMjZgiZaHGxbDkt2QMdLVZNF8LeuI4GE4+D8jyCuC7qvkW8?=
 =?us-ascii?Q?hkF7GqWXE5oFu5o78kQpr+g3L2o5Sn43SEztUQpN9YoKntqPPzdFOzsKPauH?=
 =?us-ascii?Q?wqe0/WryuqBdjB0wqwWaGYuQrtmUhjfVrgOYHRJqrgRNEwSNEKtzLYf9YfAV?=
 =?us-ascii?Q?/ccxsHFpYn5nUYvL4cZGa1fdkUDWNUG2hYyzZ6UeOaErieaheyee9132Ooj9?=
 =?us-ascii?Q?VXHNp2dDHQrTnPwXPqGeZj+9uX6fLev1Jy8gI6ALB+G0ncFWCMYR4XRtxy+9?=
 =?us-ascii?Q?kGlvtx+qI9JOjKPEVK3lc5o5K7Lbj8tPfy/bZrxTCppncI2GiMfwYHvEgt83?=
 =?us-ascii?Q?OOKpjin7QuhVO5OPX7qB2NSxtnhJQ2MGgUi7FnUDjGcMed7q4lr4MohXP4Xp?=
 =?us-ascii?Q?6itbqq9hVhGoC/MBK2vfsSIcb8skX717XrPGCy5eWCeUrhX6ptOXdWKlxNnS?=
 =?us-ascii?Q?8xjgsReA1+NW15pRD07eRD8LGyLNi2S3S/KYXTmCjGSIZ53QgzUjf/FkUuo+?=
 =?us-ascii?Q?msrNpLLuApAOhxr4SdwLz+NeskeS2iwCym9Li1aNDXFlpmUUUHVolVaMxig7?=
 =?us-ascii?Q?oDih/RO9dqTdOHqGzgoeTqkp1NIlHrakZ68XK7E/W7sZwoM9S8IwZvVnHH2q?=
 =?us-ascii?Q?arqOSbKRu53ZZjgCgGFDn9K1lVHTUZNwm6GRl5D7Xh7TnNzcP6Fz0l61UEm4?=
 =?us-ascii?Q?KOAMfg5ghMsAuZ1hyl99BJuvomZuol47hBIWauR+O5ZSNKy3WILmnk1NumAi?=
 =?us-ascii?Q?C2fr5NmzXJNGaUOl7f4eqAarVVca7M+/kAK9EJF6aA/z1C6U6LiZ8QBKcghN?=
 =?us-ascii?Q?Pq/8NTtZb/dL2ZY87YVvv+P0g16zwmOvwjG/qzYJ2cioJb/cmna/tcI8H4Ek?=
 =?us-ascii?Q?DtziCelhvJKXBD/Ck/AHc7KFlRot3potNhkM6z5S5ixPC63jDv3VkgRbuNYx?=
 =?us-ascii?Q?2yJ02/fMz2lPCZVJKVmCiz8zI049yiXewnTWKekoF5tuMqbumFXmQmTLcJ2c?=
 =?us-ascii?Q?OIGRwBfc5aVvnDTNowTTapI/C2LEWvrULzC+2hn9ixNYa0guWBb9sEMDCzqK?=
 =?us-ascii?Q?TOfw0sMvaUl2AM9CL+UbEfnxX8gP5jzq+2MNpFmi4I50kWhEGckJmPjdy0/n?=
 =?us-ascii?Q?+fSt4ppTKneGRZqkgMYzFehmDZfRfu4qWooRK3drNT6SQ7xCMssUFLi79dcY?=
 =?us-ascii?Q?bse51s4RLGV0DfVc6gJYqngGcysr6mjkowMg6Yu5sDt7m8sZ35VfCPFV5ShO?=
 =?us-ascii?Q?hVxnLurMJqNVpBv6KlDsgFUKPY1S?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa14529-9082-4dfc-785b-08d9036c026f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 19:47:48.0447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /jEJ9uY1R+LUzgRsUUsj5giHtJ/HZTggvj2RhNcxbzsfe1R+YBf8UZopypNK6BwXxgponO7J+W/FZXeM46CS8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2907
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zeng, Oak" <Oak.Zeng@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Oak Zeng
Sent: Thursday, April 1, 2021 3:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zeng, Oak <Oak.Zeng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 4/4] Revert "drm/amdgpu: workaround the TMR MC address issue (v2)"

This reverts commit 34a33d4683cba7ba63c894132efb1998c0217631.
34a33d4683cba7ba63c894132efb1998c0217631 was a driver workaround when PSP firmware was not ready. Now the PSP fw is ready so we revert this driver workaround.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  9 ---------  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 10 ----------  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 21 ++++++---------------  drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 10 ++++------
 4 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index bc374bc..59bbe59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -209,15 +209,6 @@ struct amdgpu_gmc {
 	 */
 	u64			fb_start;
 	u64			fb_end;
-	/* In the case of use GART table for vmid0 FB access, [fb_start, fb_end]
-	 * will be squeezed to GART aperture. But we have a PSP FW issue to fix
-	 * for now. To temporarily workaround the PSP FW issue, added below two
-	 * variables to remember the original fb_start/end to re-enable FB
-	 * aperture to workaround the PSP FW issue. Will delete it after we
-	 * get a proper PSP FW fix.
-	 */
-	u64			fb_start_original;
-	u64			fb_end_original;
 	unsigned		vram_width;
 	u64			real_vram_size;
 	int			vram_mtrr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 123ab31..5298698 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -414,16 +414,6 @@ static int psp_tmr_init(struct psp_context *psp)
 				      AMDGPU_GEM_DOMAIN_VRAM,
 				      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
 
-	/* workaround the tmr_mc_addr:
-	 * PSP requires an address in FB aperture. Right now driver produce
-	 * tmr_mc_addr in the GART aperture. Convert it back to FB aperture
-	 * for PSP. Will revert it after we get a fix from PSP FW.
-	 */
-	if (psp->adev->asic_type == CHIP_ALDEBARAN) {
-		psp->tmr_mc_addr -= psp->adev->gmc.fb_start;
-		psp->tmr_mc_addr += psp->adev->gmc.fb_start_original;
-	}
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 9b78891..561b32e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -140,21 +140,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	 * FB aperture and AGP aperture. Disable them.
 	 */
 	if (adev->gmc.pdb0_bo) {
-		if (adev->asic_type == CHIP_ALDEBARAN) {
-			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, adev->gmc.fb_end_original >> 24);
-			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, adev->gmc.fb_start_original >> 24);
-			WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
-			WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
-			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, adev->gmc.fb_start_original >> 18);
-			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, adev->gmc.fb_end_original >> 18);
-		} else {
-			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, 0);
-			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
-			WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
-			WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
-			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
-			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
-		}
+		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, 0);
+		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
+		WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
+		WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
+		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
+		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index d341d17..71914f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -47,8 +47,6 @@ static u64 mmhub_v1_7_get_fb_location(struct amdgpu_device *adev)
 
 	adev->gmc.fb_start = base;
 	adev->gmc.fb_end = top;
-	adev->gmc.fb_start_original = base;
-	adev->gmc.fb_end_original = top;
 
 	return base;
 }
@@ -126,10 +124,10 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
 	if (adev->gmc.pdb0_bo) {
 		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BOT, 0xFFFFFF);
 		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_TOP, 0);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP, adev->gmc.fb_end_original >> 24);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE, adev->gmc.fb_start_original >> 24);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, adev->gmc.fb_start_original >> 18);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, adev->gmc.fb_end_original >> 18);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP, 0);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
 	}
 	if (amdgpu_sriov_vf(adev))
 		return;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Charish.kasiviswanathan%40amd.com%7C2a709f7948ee45442b9b08d8f5464294%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637529029417945688%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=MWOR%2FCMXXgQPJywjxFCH3Q%2FfPMGZOSWbKdNSROS0Dec%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
