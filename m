Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA7AC2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 02:18:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23836206E5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 02:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rmrkg0xI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23836206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 999EA89E98;
	Tue, 24 Nov 2020 02:18:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3BB289E98
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 02:18:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/CI25rByYswI6J19q68/23jxXQ0RLs/mnBm8UjKvH0hYo0ewDcGARnD9EVgUoxYriWNB7M6fDAfP1jeVSwICDujOU5NAjKEGUy6hcPgrSk5pCs/keos4sG8eXMVuglRb3u2H2Yem19G06ByhbuF5/s8QCE867b93yirvIjyV+neKignPRLWizsf0rAaz97FuoN6t5k16yBeSddwPg+jM+mYELnzXymrPH5rrHRqShBIjEt6eDu5UEujcEmgXw5XQzXSLzrO4D461vN6tGy+XvQ+1dgzWBgIpQ0CJnNiLATCdGfeb9hl0JZutEeyEB+6qYV+PGleKN8WVD1SSwvY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sOvJ9Rm50RUImv3/t9vJsL12KKT4qQM73LjSErTrNw=;
 b=GqKSDP3vQ5NVgB93nGeZ1phjzSoLPZYX8e5mgDRhFbVv/SFMQK1U8vlSoqYl8Aq49NvE0fSF40cYg/h5WLLQw1xUt0DnpruLWld0hFuHcRvgKzZTl5QyDeD8jgrjN2vDiDRWF8tuZ7nVuSyy0AnkB2jUnm1k9cAGPG7d5MZFonVNFZlEytfhy1FUwZ/vl3AqFEnnQQ6wSpAb6mJwolsv3HrXBixYJ77BLmBLLKiDRPCK0DOOrPP1j5+bIWWgyCRJNf+zH7kt9u7sZs8Ap0L99vBgU4wnmyCYQE9T9JOu93y2GlGYFR8/8tJ9qPPDLZ88CIBqThBN46qfo77k2YOYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sOvJ9Rm50RUImv3/t9vJsL12KKT4qQM73LjSErTrNw=;
 b=rmrkg0xIpvgyQ3i/WfUnaFbYsA7tOPy8fAjfRqFwsGMhQiHyda3NgIuNmFIfcigsj3SFYvz02fTS5KXRwAKmOhXibKmiVY6w6n+CGYHFsmjnkiF0rWyizSr7FSNCJIb7wBhL2gd+vGfsSaeBTrH4lzPPeJ1rCWEMSIPLxWrfqSM=
Received: from DM5PR1201MB0124.namprd12.prod.outlook.com (2603:10b6:4:58::13)
 by DM6PR12MB2827.namprd12.prod.outlook.com (2603:10b6:5:7f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Tue, 24 Nov
 2020 02:18:04 +0000
Received: from DM5PR1201MB0124.namprd12.prod.outlook.com
 ([fe80::50ed:6d61:3887:e004]) by DM5PR1201MB0124.namprd12.prod.outlook.com
 ([fe80::50ed:6d61:3887:e004%12]) with mapi id 15.20.3589.030; Tue, 24 Nov
 2020 02:18:04 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, JingWen" <JingWen.Chen2@amd.com>
Subject: RE: [PATCH 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw in
 SRIOV for navi12
Thread-Topic: [PATCH 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw in
 SRIOV for navi12
Thread-Index: AQHWwZtJ6sVxIJjhFkaHHJItoWuX66nVtoAAgADV3gA=
Date: Tue, 24 Nov 2020 02:18:04 +0000
Message-ID: <DM5PR1201MB01244DA56EC0DE98159B21749AFB0@DM5PR1201MB0124.namprd12.prod.outlook.com>
References: <20201123131929.21838-1-Stanley.Yang@amd.com>
 <DM6PR12MB4075813D74B9ED300249BDFDFCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB4075813D74B9ED300249BDFDFCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-23T13:30:47Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0b565533-ce57-4b18-90ae-00003770b754;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-24T02:17:59Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 7d2e12d6-7962-4710-8173-0000d258171a
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0316ffee-7676-4bc5-9a02-08d8901f2cfe
x-ms-traffictypediagnostic: DM6PR12MB2827:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2827D181146A0C221D4285F49AFB0@DM6PR12MB2827.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DIo/Zwei7EB3QKuCq8jOWvW1/E5Gx4Tl92bQouisE0Hhuvk+xtaYTWebZb6Ks83d2qvMK9dnsif8zgG+7oP7maEcdQ1vBjVR1UWsBODJ7kGGthu8Ml6AcyX+Cx+XuUJDQbW0+IyIGgqs4LKJ37Fq/fsufsZZTkn3Om2FaQAYTCgFzKXCdcG4r6g0bEc0z2HsZCIaFz7CrMFWZ6Yye4kQeumW2eBqqyZtnI9w0W81tJhu8zMmu7Bl1l7Q/JRxo6EdTZrs9wiUlPTzyqwkRwuHdf7Lt3pIwE9Pi+a6A/XS4GCy+yl1CRlgt/4T3KcL6Ygj/wa33z6uIfjHGeGOjA5sYPmputaFheo9zsCZpOTYH0QXNTHZpB9YZqgA898lxZcqao2N1elYtcTTP7eYsp2Iew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(52536014)(33656002)(45080400002)(53546011)(316002)(6506007)(110136005)(8936002)(8676002)(966005)(71200400001)(64756008)(66446008)(55016002)(66556008)(66946007)(76116006)(5660300002)(2906002)(66476007)(6636002)(7696005)(83380400001)(86362001)(186003)(478600001)(26005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?koDCKyRqkYvriXosoAL7MKZ3EFf0ngy1YpTR9+4V1K4IXjZW8hG+Xun2pmEm?=
 =?us-ascii?Q?60O764rJMHgteT4e07NA6QTnInrfitgputs/q05fvMA1VSBg/CuCH48eAAP6?=
 =?us-ascii?Q?wNc64dojBxyjXvmlbRzHbrv0mIh/ke4E66kfXXPP6vcb+1Bxwrkj9Ei/Qoep?=
 =?us-ascii?Q?MuXb9o1SYFopzNKPQ2eDjdHXdJu94atqXvLhO7qTpEjFCgGQII5HkPhdr0PL?=
 =?us-ascii?Q?DqrGGP5+IX+Mq25fVITkf54Q8SMmf08NSzuN8DhNrDZPaRGzJ6sCX3VzG14u?=
 =?us-ascii?Q?kzSr+S6jytzvSV8uSDI4fcMe/yuJ07kSMB5qmfxHmqIHCmpGPBlxd9J1u8j3?=
 =?us-ascii?Q?isbFYWTTeauuLG/XS3F8SZmiSS6TeVHdcSUkUy9mnpVD41cN4zKcAwUSSw/r?=
 =?us-ascii?Q?EhrbOceH7raiKG3cOmoYOnmw+U2xNF8TdqgXB0+Cfud4yUt3vYSy/ZrLsjzV?=
 =?us-ascii?Q?x9JyfaD3wNj9KT3YcBpW+AnJ7FbwYoqAOk9J2NiFd5Ldt3ovyxrDBDwMKvfs?=
 =?us-ascii?Q?MiHdUob2WB0ZBMYb/du3JYpUe7KndM6KkDaDxXXhwR/96zzYiNSVuP+tsjYk?=
 =?us-ascii?Q?oHEOqMjo2ipQEapCc/siamQQLy2G0omJyHd3+3tD3q4XvwyLTCzy1JONkfaY?=
 =?us-ascii?Q?FWgrsgepQO4u3yPkvJWM628GTngvsbIAGcXxadkXUFey8vaxNNgwOFml57Lb?=
 =?us-ascii?Q?Pw66itsTFEQ/BsBuYO3k1CCOANs3da6bqfCcQtJ6G1aB2NN2K+FhL/8nLUAJ?=
 =?us-ascii?Q?iiw5fKH8DMTxm3l66O5gqrnJWywuzfehxGuOeC0njMWtuEuebBsK2n/l21zS?=
 =?us-ascii?Q?3SHh6ziNZ1LYefE3SOs7yH+vCOqu1O4PRreoHRc6ehn5uEzyY8HorTmuZNX0?=
 =?us-ascii?Q?zm08FnGBmoAireqZx3acIBmVfKAvHkT7VwYDPktCNEy7Ip+ulJHNaAqcDtUQ?=
 =?us-ascii?Q?XB+29/lDekWLys1thxmkWzXNXyxzcpTvaZuluZMoHms=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0316ffee-7676-4bc5-9a02-08d8901f2cfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 02:18:04.4205 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5Md3SMuyy4A3DrMr1a62cdRKsDUp2fwzSWk/eJBpvzJnplRlPn10OKdMh/XLRoqnfdXendssltrvWDDm3HWUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2827
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

Hi Hawking,

Thanks for your reminding, it is unnecessary to check navi12 asic type in sdma v4, I will update patch and resend it.

Regards,
Stanley

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Monday, November 23, 2020 9:31 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org;
> Chen, JingWen <JingWen.Chen2@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw
> in SRIOV for navi12
> 
> [AMD Public Use]
> 
> @@ -593,7 +593,7 @@ static int sdma_v4_0_init_microcode(struct
> amdgpu_device *adev)
>  	struct amdgpu_firmware_info *info = NULL;
>  	const struct common_firmware_header *header = NULL;
> 
> -	if (amdgpu_sriov_vf(adev))
> +	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_NAVI12))
> 
> Navi12 doesn't integrate sdma v4. Why we need to check Navi12 in sdma v4
> function.
> 
> Regards,
> Hawking
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Monday, November 23, 2020 21:19
> To: amd-gfx@lists.freedesktop.org; Chen, JingWen
> <JingWen.Chen2@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw in
> SRIOV for navi12
> 
> The KFDTopologyTest.BasicTest will failed if skip smc, sdma, sos, ta and asd
> fw in SRIOV for vega10, so adjust above fw and skip load them in SRIOV only
> for navi12.
> 
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> Change-Id: Id354be93723d7b5d769d73dc67c596af300305af
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c                  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                  | 2 +-
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c | 3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c               | 2 +-
>  5 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 16b551f330a4..7e2f063120d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -593,7 +593,7 @@ static int sdma_v4_0_init_microcode(struct
> amdgpu_device *adev)
>  	struct amdgpu_firmware_info *info = NULL;
>  	const struct common_firmware_header *header = NULL;
> 
> -	if (amdgpu_sriov_vf(adev))
> +	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_NAVI12))
>  		return 0;
> 
>  	DRM_DEBUG("\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 9c72b95b7463..fad1cc394219 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -203,7 +203,7 @@ static int sdma_v5_0_init_microcode(struct
> amdgpu_device *adev)
>  	const struct common_firmware_header *header = NULL;
>  	const struct sdma_firmware_header_v1_0 *hdr;
> 
> -	if (amdgpu_sriov_vf(adev))
> +	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_NAVI12))
>  		return 0;
> 
>  	DRM_DEBUG("\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index cb5a6f1437f8..674bc88c3ec1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -153,7 +153,7 @@ static int sdma_v5_2_init_microcode(struct
> amdgpu_device *adev)
>  	struct amdgpu_firmware_info *info = NULL;
>  	const struct common_firmware_header *header = NULL;
> 
> -	if (amdgpu_sriov_vf(adev))
> +	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_NAVI12))
>  		return 0;
> 
>  	DRM_DEBUG("\n");
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> index daf122f24f23..192149e94f6c 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> @@ -208,8 +208,9 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
>  	unsigned long tools_size;
>  	int ret;
>  	struct cgs_firmware_info info = {0};
> +	struct amdgpu_device *adev = hwmgr->adev;
> 
> -	if (!amdgpu_sriov_vf((struct amdgpu_device *)hwmgr->adev)) {
> +	if (!amdgpu_sriov_vf(adev) || (adev->asic_type != CHIP_NAVI12)) {
>  		ret = cgs_get_firmware_info(hwmgr->device,
>  						CGS_UCODE_ID_SMU,
>  						&info);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 1904df5a3e20..80c0bfaed097 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -847,7 +847,7 @@ static int smu_sw_init(void *handle)
>  	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
>  	smu->smu_dpm.requested_dpm_level =
> AMD_DPM_FORCED_LEVEL_AUTO;
> 
> -	if (!amdgpu_sriov_vf(adev)) {
> +	if (!amdgpu_sriov_vf(adev) || (adev->asic_type != CHIP_NAVI12)) {
>  		ret = smu_init_microcode(smu);
>  		if (ret) {
>  			dev_err(adev->dev, "Failed to load smu
> firmware!\n");
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C11dc63c434444
> a86675608d88fb26e4c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%
> 7C637417343805220247%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda
> ta=SUkSApUQErJH80J5XELokS%2FuIDKMDsqwmBPVrfyvSOA%3D&amp;rese
> rved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
