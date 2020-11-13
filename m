Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C243FC55ABD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502D92065E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ESR+gWt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502D92065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B80E06E53C;
	Fri, 13 Nov 2020 17:11:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D6F36E53C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 17:11:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjC5kZjdkXw0ToIdhOyHtLOuBOPQ4/NKjoKpIsAzyKSr+Ci3TqnyS/hOuc+RMnqRp5lb/YwjzCZCmtPdBR4NfBKtnZNcuwd/RFgTEDB0jKNQgMTqhhkaTtHjn66UWHaVemhWXajcTBmsv5wqXF/i2CVy6i5OmpvMekmneMcaY1BUx0tShW3SDtURuopEO0BHcsi1K63NyMHviUM6s4m7QTr2yFoZ4XZ3tkH4WK6SgpGQWOaCGUF7rXrSWiXbMB6jF6xGHco7jJgiUZyD3G6nXof93h/gHgRgIUAjjDLQpZtA2Gv/En9JroGl9lrx9cS9lIHDmE1F74lvgELh5tkcLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wFV+aZKe8PhyLq8y2i9SlM5CSG2XCbXFWaV4Hrdj0o=;
 b=UGi0wGdNUeCvCG7r7TTH9tjPMaURMRGDjudiQywWsO6pZ+UWHoTb5eiaq7Qy/qIlxVGSSeHaeRenQjLcKs53WEnEg5CWX/0mXx8FObYp54JJZSS0RYmipZB7tJlWkC/eDv5h7Yh5r0557P/QFACSHPdYh3W0m2PmZgvSgoDSJoR73RFNU84i1PhmqvnN6LF2JNERkGDSKO/HLRp3T6rbMeOwZT7nkXISlyQpbhGZRaGEWmSCd/caSOwXpyHUUTnXcbQSluOK1cLetKXsbRLfPHskr02NhvfI31eX+xFQtl1HpbAnDMuoVBi4+lucvaMrAs6CzwpHex4Fdn46MmCNVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wFV+aZKe8PhyLq8y2i9SlM5CSG2XCbXFWaV4Hrdj0o=;
 b=ESR+gWt4UobZCWvzqDJzzJf7wNKtQL8vH6018Zn7wd0N+3Sx/m0c9k69/dSUnHyopvMf/UPndVXDPzbXt5toQWllcJxnWpwkFppcq1bUBnQA56N5AOYNtKOTJq3P7HfWvrwpRqWtYhTvvg/Zn+VadGRoQ4tPmLj1h2FoEUuGQFo=
Received: from MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18)
 by MN2PR12MB4581.namprd12.prod.outlook.com (2603:10b6:208:260::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 17:11:45 +0000
Received: from MN2PR12MB4423.namprd12.prod.outlook.com
 ([fe80::e0e4:9866:9893:b6a5]) by MN2PR12MB4423.namprd12.prod.outlook.com
 ([fe80::e0e4:9866:9893:b6a5%3]) with mapi id 15.20.3541.026; Fri, 13 Nov 2020
 17:11:45 +0000
From: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable 48-bit IH timestamp counter
Thread-Topic: [PATCH] drm/amdgpu: enable 48-bit IH timestamp counter
Thread-Index: AQHWt4q3ou1EC75tmEeDMM+MBGzIwqnBpn+QgAkCbQD/+6eTcA==
Date: Fri, 13 Nov 2020 17:11:45 +0000
Message-ID: <MN2PR12MB442306220D904F638D5EDC07FDE60@MN2PR12MB4423.namprd12.prod.outlook.com>
References: <20201110175519.21308-1-alex.sierra@amd.com>
 <SA0PR12MB4430DF99234F8097DE57FBF5FDE90@SA0PR12MB4430.namprd12.prod.outlook.com>
 <288f55c4-62a4-0249-7a9c-9dc417caa462@gmail.com>
In-Reply-To: <288f55c4-62a4-0249-7a9c-9dc417caa462@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-13T17:11:41Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=011d3a25-acae-4e18-8f35-000002752705;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-13T17:11:36Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 47618642-16b3-42a0-b582-0000cbaaefbe
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-13T17:11:42Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 87affb33-a88c-4278-a6e8-0000b3f4df18
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.77.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0ca11b4f-3965-4113-2972-08d887f732da
x-ms-traffictypediagnostic: MN2PR12MB4581:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB458121D4E033BF5FB1BF6130FDE60@MN2PR12MB4581.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j85spQ9iV/wYjEkRWAqoiAUxJ03r3UnM5ILPn+NdDnBnky+0tGlsWcfH55HUu+gnNkmeTNl5YOoIk35avmQhBg7sEXKFAAtaEgu0k0qlhqtlsgFeQqURRUQ0uu/48BC0pH7gRVMMxsllnKtT1kZxzBx/WUA6AQahfPzlTIhmXPLjgVAsPCF9NVqNq0N0L34lnVAHflDy32u9/fncE75OPkEXps8N8VTl27vjGjKHIe42tmEfXIkr0m9aqSIArbMZjH3OSBMVcZN1OXdGZkBRIkABJGptOXup4oR2z5pX8id24wJe6NzGcskOHPIg7cWdAV+dP6ZqUhfIRkKUvDWoHfRExRW0p4H50Ap3E+QFNek5BJ8wxC/MOqeTjuOTDEYJtZ7Eif5RHynGAsC/2wUw0w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4423.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(316002)(86362001)(966005)(4326008)(2906002)(478600001)(66946007)(5660300002)(71200400001)(66556008)(33656002)(8676002)(83380400001)(76116006)(64756008)(66476007)(66446008)(6506007)(53546011)(7696005)(8936002)(66574015)(186003)(55016002)(45080400002)(52536014)(110136005)(26005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: YGAroVuETEfAE1ip30gHfLxjYHpVOFnvs9SY+pqHly7UNIJJ7Rq5dkGVC1C9ME7uAvY6mYsYIXOakcjMARI/CLvq7lM1eV5U4aQKuC4LOZDRhEOVJj0pEVdIZ23JqchXvh5Ard9Dvzq49gY1I+fQ9KjV7bRzR2LPZFlTH+sr5X6lSUgS+KVl95Yr7kqj54ICsG/dN0ytynDj/a2Br4ilJJXIjF3ma/xJAlgToGxgJOXGZcjP8NC44znaExooPFeCQirnrnKzIE/wf2h8XwW2SctZry5Hc6f6HAocJt1rTLazxdjswI648W748d6UfWKs3qlmRFk9jSs4ljbbVgVjph3v6AVoB5lbbX2sH37pvxn07YUteZWiemjzEbmkjw5XPwbeIO7isBIHa2YZVOyLKQtqvDuCF/fWLw3zAe4zIfuGUP2eVCD94Do/c9fnWZkcqILU9qXdKNYIjGue7ECl1+ZY9eD1hZFXzokiXCMgcuCxoFTY+jiYUqcebdmAsMuw1Xj1LeKP+5ZlyzEx6g78tcmJ97WS2GwCf0Wt56L5SRN0NoGYekkMfnR5vAs4KR/j+LBcsRLaFV7fd8mx80lZY5S7rt+t2gD3aLZDFmMiRTo60n9l69wJ7NdOqfUEwKhh1T+UzWg1Pm9TpGZeRqOrwQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4423.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca11b4f-3965-4113-2972-08d887f732da
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 17:11:45.1575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDmlsYtGm/b5G/z4MWeZlVWvxsdyQWWOutj5lq7Vv3POUCihhG40kda3ilYuw/sllh5mKQZwXxAYsHOzWzmbDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4581
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

This give us time for the rest of the enablement we're doing. However, we s=
hould fix the fundamental problem in the near future. =


Regards,
Alejandro S.

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Christian K=F6nig
> Sent: Monday, November 16, 2020 5:31 AM
> To: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>; amd-
> gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: enable 48-bit IH timestamp counter
> =

> Feel free to keep my rb for this, but is 455 days enough in general or sh=
ould
> we add wrap around handling?
> =

> Christian.
> =

> Am 10.11.20 um 18:57 schrieb Sierra Guiza, Alejandro (Alex):
> > [AMD Public Use]
> >
> > I just added support for vega10_ih too.
> >
> > Regards,
> > Alex
> >
> >> -----Original Message-----
> >> From: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>
> >> Sent: Tuesday, November 10, 2020 11:55 AM
> >> To: amd-gfx@lists.freedesktop.org
> >> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Kuehling, Felix
> >> <Felix.Kuehling@amd.com>; Sierra Guiza, Alejandro (Alex)
> >> <Alex.Sierra@amd.com>
> >> Subject: [PATCH] drm/amdgpu: enable 48-bit IH timestamp counter
> >>
> >> By default this timestamp is based on a 32 bit counter.
> >> This is used by the amdgpu_gmc_filter_faults, to avoid process the
> >> same interrupt in retry configuration.
> >> Apparently there's a problem when the timestamp coming from IH
> >> overflows and compares against timestamp coming from the the hash
> table.
> >> This patch only extends the time overflow from 10 minutes to aprx 455
> days.
> >>
> >> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 6 ++++++
> >> drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 6 ++++++
> >>   2 files changed, 12 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >> index 837769fcb35b..bda916f33805 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >> @@ -94,6 +94,8 @@ static void navi10_ih_enable_interrupts(struct
> >> amdgpu_device *adev)
> >>
> >>   	ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
> >>   	ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR,
> >> 1);
> >> +	ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
> >> +				   RB_GPU_TS_ENABLE, 1);
> >>   	if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
> >>   		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL,
> >> ih_rb_cntl)) {
> >>   			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
> @@ -109,6 +111,8
> >> @@ static void navi10_ih_enable_interrupts(struct
> >> amdgpu_device *adev)
> >>   		ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0,
> mmIH_RB_CNTL_RING1);
> >>   		ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
> >>   					   RB_ENABLE, 1);
> >> +		ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
> >> +					   RB_GPU_TS_ENABLE, 1);
> >>   		if (amdgpu_sriov_vf(adev) && adev->asic_type <
> >> CHIP_NAVI10) {
> >>   			if (psp_reg_program(&adev->psp,
> >> PSP_REG_IH_RB_CNTL_RING1,
> >>   						ih_rb_cntl)) {
> >> @@ -125,6 +129,8 @@ static void navi10_ih_enable_interrupts(struct
> >> amdgpu_device *adev)
> >>   		ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0,
> mmIH_RB_CNTL_RING2);
> >>   		ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
> >>   					   RB_ENABLE, 1);
> >> +		ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
> >> +					   RB_GPU_TS_ENABLE, 1);
> >>   		if (amdgpu_sriov_vf(adev) && adev->asic_type <
> >> CHIP_NAVI10) {
> >>   			if (psp_reg_program(&adev->psp,
> >> PSP_REG_IH_RB_CNTL_RING2,
> >>   						ih_rb_cntl)) {
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> >> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> >> index 407c6093c2ec..35d68bc5d95e 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> >> @@ -50,6 +50,8 @@ static void vega10_ih_enable_interrupts(struct
> >> amdgpu_device *adev)
> >>
> >>   	ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
> >>   	ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR,
> >> 1);
> >> +	ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
> >> +				   RB_GPU_TS_ENABLE, 1);
> >>   	if (amdgpu_sriov_vf(adev)) {
> >>   		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL,
> >> ih_rb_cntl)) {
> >>   			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
> @@ -64,6 +66,8 @@
> >> static void vega10_ih_enable_interrupts(struct
> >> amdgpu_device *adev)
> >>   		ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0,
> mmIH_RB_CNTL_RING1);
> >>   		ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
> >>   					   RB_ENABLE, 1);
> >> +		ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
> >> +					   RB_GPU_TS_ENABLE, 1);
> >>   		if (amdgpu_sriov_vf(adev)) {
> >>   			if (psp_reg_program(&adev->psp,
> >> PSP_REG_IH_RB_CNTL_RING1,
> >>   						ih_rb_cntl)) {
> >> @@ -80,6 +84,8 @@ static void vega10_ih_enable_interrupts(struct
> >> amdgpu_device *adev)
> >>   		ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0,
> mmIH_RB_CNTL_RING2);
> >>   		ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
> >>   					   RB_ENABLE, 1);
> >> +		ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
> >> +					   RB_GPU_TS_ENABLE, 1);
> >>   		if (amdgpu_sriov_vf(adev)) {
> >>   			if (psp_reg_program(&adev->psp,
> >> PSP_REG_IH_RB_CNTL_RING2,
> >>   						ih_rb_cntl)) {
> >> --
> >> 2.17.1
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=3D04%7C01%7Cal
> >
> ex.sierra%40amd.com%7C2fd98389222842a15da008d887e93049%7C3dd8961f
> e4884
> >
> e608e11a82d994e183d%7C0%7C0%7C637408783493249465%7CUnknown%7C
> TWFpbGZsb
> >
> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%
> >
> 7C3000&amp;sdata=3DNyKN4mVAmDfq4zFl5rbuth551l8nYyQh2LQ3icSXojM%3
> D&amp;re
> > served=3D0
> =

> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=3D04%7C01%7Calex.sierra%40amd.com%7C2fd98389222842a15
> da008d887e93049%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> 7408783493249465%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D
> NyKN4mVAmDfq4zFl5rbuth551l8nYyQh2LQ3icSXojM%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
