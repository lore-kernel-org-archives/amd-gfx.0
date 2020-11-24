Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB57C2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 14:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FE5206E5
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 14:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y7hncSM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FE5206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD4736E409;
	Tue, 24 Nov 2020 14:36:45 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750088.outbound.protection.outlook.com [40.107.75.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D13F6E41D
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 14:36:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oac94owrMr67k2t/oYWzzLzF9S8T8UISBOTymFqFlIbRIgNhcw/2BAunFN4lVesulJsJcIsuJc6lolunZZjH8VXyFkVc0lKFM5Bv8aPfcMt3KcmdJ2EbtuOGCX68wPdG8mF7ejFl5j9hjHQuUuuQmllYgLHBKA6PqxvuoI6t9xEfmaAVdmW8pYMRRKCJJHpRiMJHetd8ERgKPKVybfWcMUNY5T23Cv4djhbbhUDLyKMlw9K3lX+oLGlMIdHXLcfk2/2vLvi0OY3XeKfKYjVDN3Y7wk4XDK7sA09c1Qr+lU8y2DdZTnAY4N2VBg+IL0sEuSiyyo/p8ZYFUT6PFuVSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eknQE7lm2xwhNjR1zL6qVn6Fw1umCSQ1qVwTfdx8jzw=;
 b=EBn5k2ZxSfAicXeI515N/kPCQCKMVeI1/SpvwHchCT5CcCrOj/VY4cNZRnDTNzD2scuO9ta4N76HsFfRPb+kL+umXGAqQGX3I4CTHd/fWN7pBpYpmz75BgsmirZoGPR8aQqw82Vq6lykQKdG0rqTzO2/tdrv9aEqiQZJPIz4JFh8cW09WTcmuqjB3dXWogq1MjlfpdDo2r6vLQPbbG58KiuCg5Xsm3wRlC1a26UT3eEHQJrFIRx1IPa/yHdzsDLsfL9yh7EnU5DZPnk4f2/WhVvB/yKDozvOCKvez1iyQ9XgQejf83RyBBT2NmsvXH88hFpRE9HenjB6fkTGi3GsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eknQE7lm2xwhNjR1zL6qVn6Fw1umCSQ1qVwTfdx8jzw=;
 b=Y7hncSM7xd8Ouv/7od6i72vV6PwLecdUv14BdXIiygdZG0TmCtIPQgxhxUwPCFGLh7umZOV66bPWcUq+mpAm11jletBDaMVrLxoa9kSMZzD/zbzTjU0fEgy5/cb+zhXr4PJum3KT9ckfKux8i/hSOKsYLG1H+K8XJavpuI47WH0=
Received: from DM5PR1201MB0124.namprd12.prod.outlook.com (2603:10b6:4:58::13)
 by DM5PR12MB1353.namprd12.prod.outlook.com (2603:10b6:3:76::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.28; Tue, 24 Nov
 2020 14:36:40 +0000
Received: from DM5PR1201MB0124.namprd12.prod.outlook.com
 ([fe80::50ed:6d61:3887:e004]) by DM5PR1201MB0124.namprd12.prod.outlook.com
 ([fe80::50ed:6d61:3887:e004%12]) with mapi id 15.20.3589.030; Tue, 24 Nov
 2020 14:36:40 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, JingWen" <JingWen.Chen2@amd.com>
Subject: RE: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw
 in SRIOV for navi12
Thread-Topic: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw
 in SRIOV for navi12
Thread-Index: AQHWwkcSGhsZcLz67kimxMKj4wuQw6nXTAaAgAAM5RA=
Date: Tue, 24 Nov 2020 14:36:40 +0000
Message-ID: <DM5PR1201MB01240896AE165C5AC5AE50049AFB0@DM5PR1201MB0124.namprd12.prod.outlook.com>
References: <20201124094905.25255-1-Stanley.Yang@amd.com>
 <CY4PR12MB128779E09EEFC614305187B6F1FB0@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB128779E09EEFC614305187B6F1FB0@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-24T13:45:01Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=489cb579-6b73-4780-991a-00008ef8215b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-24T14:36:37Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: a45bed76-7277-4980-a6a3-000079d50cef
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [101.86.242.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c2a1d1ee-721c-4b6b-eb80-08d890865b72
x-ms-traffictypediagnostic: DM5PR12MB1353:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1353D8C673CB40D4294C4E5A9AFB0@DM5PR12MB1353.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nT1l2YThHE/kHOQI57yYS0Iu6tz92oXXrQQo4OrLTmouxaseWX1luwtpQfBSxhs1iXGP3nY9KZsfP1dZeQTfV8ebF0IeKC7Lhf01iuEMyhBNkjFJQt2TI8Jnj1J2xypNDznDnwGjWsEckjWGKePNCoUDvnn7kEj9+FqPm3a3P2vMrQZMxEsef3rziLc9LGsmmVrC1mgLbbxq/aQJCeLe4m6cAVV8M3yvjeN34Y7hYJ0ugQNu1usdK4EK8wjcZyKcxKEbT0aNDJ+2GLx+TXV6GYyVXXPedRVzc6hNKpcNpzrt7inUxKJDqS3qZxbbwFlI7JsXpfWifnw2xiPhMtU20CrU4igXGgkJKmNlyKHK7kGeCTL6cefH4N2RQlDME+dRlVa7PTXM87OZECWZKB1cpw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(6506007)(53546011)(33656002)(8936002)(8676002)(86362001)(26005)(71200400001)(478600001)(5660300002)(966005)(316002)(52536014)(6636002)(76116006)(66476007)(2906002)(45080400002)(66556008)(66446008)(55016002)(83380400001)(66946007)(186003)(9686003)(7696005)(110136005)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zjtYrgzBo2Vl55wbe1jr/7pzxg8EpADxu5M5Z9tbJ8QztUkf93We+Ib/TDVa?=
 =?us-ascii?Q?JPahxL+3nc1fIjURDejtFoJVH6/gRpG93UOGvEUJUA8xER1YfBWguQ8yDZXE?=
 =?us-ascii?Q?ICze1WhtBNicdnutWaWimGqoTlD6eNGBkmDKEMJtUe42UQx7Wg6xJHedtBtr?=
 =?us-ascii?Q?FXdRTdZmH0Ff+uUDOwfJLiQvhCqKX1uJPSCh5Qv5lOYlYARJvc//wn3YfNfm?=
 =?us-ascii?Q?zjISLscS1VyFfvPBv1mQOfZpOjHHBmupYWw7yesO1+C2kNnlZBs/yJyrNZBb?=
 =?us-ascii?Q?cock8VlyjhvN+svTcjtcQf3IAhTknnWj9pM9kt+tZUnZI3FEyebtuh7hxRk3?=
 =?us-ascii?Q?53QhlXOVIU+rrZ/QVIOL0C6Y6/ovXSuiYAzWowdD4lBsl5iiX1kgdJNSh7+u?=
 =?us-ascii?Q?C8DqXNDRQAaSWRb+gJ2Gh6d7M93DRC6LEu5gawAjNN19RSGLyl1Fl2L2h4As?=
 =?us-ascii?Q?cx6mTwcORnluHROMX+EvvKH4GFjqAKULtyxKJfFvgDd8372qYwfXWNvvm0VV?=
 =?us-ascii?Q?j06nqajKdDqdojo0oAldESPBcmoqTF9sp4IYr/FQOE0YAgYnWfBtZuD3F4tn?=
 =?us-ascii?Q?eL3Mpt09nQ9f6bc5FtmMbKsTzEuWDeTxZp1g5mwJ74AnJ21p+ZgJgWqx9NXh?=
 =?us-ascii?Q?reSSO1mQzTJ3/3MWh4TFgvqIZI6cvv+tzfp9oypB0mlfyz914IoWM/gQAJhv?=
 =?us-ascii?Q?0LBDf9+vY2vxyjY6oAcE0xTmvLQaiqaI+HL83igS0Qvnyutj+ygEcYXjhJyv?=
 =?us-ascii?Q?keD6fZxvzO5ClxThqyeFbY9H9s7RmJxHt8E6fk9crR1gNABc3uInB/0DyVUv?=
 =?us-ascii?Q?kiNziLbiHMkHX1kC5/CP3mXuICS0DeSeKjtykXBwdg8pP7r4nyx8lpJF8p7v?=
 =?us-ascii?Q?m+ttxWxPZTym3ZgxAeJFDH686BSfxmuEyEykzd0VMGbVxffMDLGJleh2mkLy?=
 =?us-ascii?Q?U03225aADKrKUWzWk/nHL53SL3uY2OtFfUvTOiy+G3Y=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a1d1ee-721c-4b6b-eb80-08d890865b72
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 14:36:40.6001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ibTJOUe9jYpJHUUelT1Ift6PoPfZKvzZa4oMd4MMf1ldZ5ILus2XofIP9U7jINojIBxFcuSYHB84DsmlLmFNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1353
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

Hi Guchun,

This is an oversight. I forgot to remove it from patch version first.

Regards,
Stanley
> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Tuesday, November 24, 2020 9:47 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org;
> Chen, JingWen <JingWen.Chen2@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and asd
> fw in SRIOV for navi12
> 
> [AMD Public Use]
> 
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> @@ -208,14 +208,13 @@ static int vega10_smu_init(struct pp_hwmgr
> *hwmgr)
>  	unsigned long tools_size;
>  	int ret;
>  	struct cgs_firmware_info info = {0};
> +	struct amdgpu_device *adev = hwmgr->adev;
> 
> Why add this local variable? Looks no one is using it.
> 
> Regards,
> Guchun
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Stanley.Yang
> Sent: Tuesday, November 24, 2020 5:49 PM
> To: amd-gfx@lists.freedesktop.org; Chen, JingWen
> <JingWen.Chen2@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw
> in SRIOV for navi12
> 
> The KFDTopologyTest.BasicTest will failed if skip smc, sdma, sos, ta and asd
> fw in SRIOV for vega10, so adjust above fw and skip load them in SRIOV only
> for navi12.
> 
> v2: remove unnecessary asic type check.
> 
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c              |  3 ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c              |  2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c              |  3 ---
>  .../gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c | 13 ++++++---
> ----
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c           |  2 +-
>  5 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 16b551f330a4..8309dd95aa48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -593,9 +593,6 @@ static int sdma_v4_0_init_microcode(struct
> amdgpu_device *adev)
>  	struct amdgpu_firmware_info *info = NULL;
>  	const struct common_firmware_header *header = NULL;
> 
> -	if (amdgpu_sriov_vf(adev))
> -		return 0;
> -
>  	DRM_DEBUG("\n");
> 
>  	switch (adev->asic_type) {
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
> index cb5a6f1437f8..5ea11a0f568f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -153,9 +153,6 @@ static int sdma_v5_2_init_microcode(struct
> amdgpu_device *adev)
>  	struct amdgpu_firmware_info *info = NULL;
>  	const struct common_firmware_header *header = NULL;
> 
> -	if (amdgpu_sriov_vf(adev))
> -		return 0;
> -
>  	DRM_DEBUG("\n");
> 
>  	switch (adev->asic_type) {
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> index daf122f24f23..e2192d8762a4 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
> @@ -208,14 +208,13 @@ static int vega10_smu_init(struct pp_hwmgr
> *hwmgr)
>  	unsigned long tools_size;
>  	int ret;
>  	struct cgs_firmware_info info = {0};
> +	struct amdgpu_device *adev = hwmgr->adev;
> 
> -	if (!amdgpu_sriov_vf((struct amdgpu_device *)hwmgr->adev)) {
> -		ret = cgs_get_firmware_info(hwmgr->device,
> -						CGS_UCODE_ID_SMU,
> -						&info);
> -		if (ret || !info.kptr)
> -			return -EINVAL;
> -	}
> +	ret = cgs_get_firmware_info(hwmgr->device,
> +					CGS_UCODE_ID_SMU,
> +					&info);
> +	if (ret || !info.kptr)
> +		return -EINVAL;
> 
>  	priv = kzalloc(sizeof(struct vega10_smumgr), GFP_KERNEL);
> 
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
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Cdf14a0bc671547d
> 5315708d8905e330b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%
> 7C637418081554620468%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s
> data=BNU5d%2FQSOnNZNYHQ3ZjBjIubUl1wa6lmkaWBf2XuIjw%3D&amp;res
> erved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
