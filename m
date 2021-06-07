Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659A5C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 15:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113DF61185
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 15:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113DF61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D2789954;
	Mon,  7 Jun 2021 15:30:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55CF789954
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 15:30:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTndBO6RPHBU2sjiHni0FZ8tF0zBJtbESZjkqboRmsik4nLC5D3f668bMci8wyomULyl57+LluGF0pM78pZc9z7jOD4WIpysOEuDej7KmyIb8LbrrLfs2iVi/wHN3Xrowk5NNzitovDoaNSAOiquPtl57/cqFIlAz/N9fgrLukYMk/w30ORitLgyV+iHGlE7v5LcYwwZ4B/uHLy48b1aiM7qjIwJClGdgpfHS1OxU7DBqzyeWJ7uYUP4rjsv+VQft2kpqgSiNkhMNlzgpg/Wtgv41N8ShjZ8t5yn3ofqLiTmkxK0q0oKnifdWx8F/+qVkODCaZjDRZtnB/7WKaH5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZNiXdXsMISqoS8LYhM7hcV9tf2n1EqaAjh/g/xw05s=;
 b=eHgO6vGgSYv4+j2MmQupd+uvbsWvt7ngIHJwu100E3eUDJJX8nbNsiZ0fQoPgsoBZofstG7HEJfCH4+YfG2ei9EYLqVo6T9HCAj5Wp3kkRda0BYvflhZU+c1f2BdLx/3Ar0FWklGx2FeOOrnT/pes/MUMQ9WBLsIOnUtHWFpqv7Ona1SwkXJ41JmT6zN6Qw3VgskEtGeNThdUUX0Y894DPOv+UcdJ+NJiogOgGsQl7B2wZIm8CpVX5qja6EhuWutjx8u3EYoNa8i61FxIigQLg2Ex1nmLnEx0oNkbupwAp0iMN04x5W5QKr5X+91ILqCwMv2zisPJJ3usTWIwrPpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZNiXdXsMISqoS8LYhM7hcV9tf2n1EqaAjh/g/xw05s=;
 b=FiGgQduWJWA7yzaxcomUTJWzpjvhcknFGqWBJhnvqCv5BcRXOqdABWIHDfROc9LwTw6RBeeJZVknKvIUc+wdHSzX4MYDeDdVcsRIwwUEjGdrLSnCN7Y1PMbffX4aHEfdr/P5elUPrJBsQZk2o28ux/qIPgm+qLdDiBsgjnuJLKE=
Received: from BL0PR12MB4755.namprd12.prod.outlook.com (2603:10b6:208:82::26)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 15:30:43 +0000
Received: from BL0PR12MB4755.namprd12.prod.outlook.com
 ([fe80::2ce1:d92c:92e9:1689]) by BL0PR12MB4755.namprd12.prod.outlook.com
 ([fe80::2ce1:d92c:92e9:1689%5]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 15:30:43 +0000
From: "Khaire, Rohit" <Rohit.Khaire@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Liu, Monk"
 <Monk.Liu@amd.com>, "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "Chen, Horace"
 <Horace.Chen@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on
 SRIOV
Thread-Index: AQHXW6jBBOCm0Cq7+0e2cLfTYbZVMasInCcAgAANbpA=
Date: Mon, 7 Jun 2021 15:30:43 +0000
Message-ID: <BL0PR12MB4755039C3515004ADD1051AA87389@BL0PR12MB4755.namprd12.prod.outlook.com>
References: <20210607142343.13509-1-rohit.khaire@amd.com>
 <392d7f26-51d6-f60e-6081-870afe8276b7@amd.com>
In-Reply-To: <392d7f26-51d6-f60e-6081-870afe8276b7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-06-07T15:30:40Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b1f91daf-0e22-4514-a2ec-a14e6ccee872;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fd38fbc-3a4a-4139-1c87-08d929c936e1
x-ms-traffictypediagnostic: MN2PR12MB4237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4237B73370CE8FDAE03E53A087389@MN2PR12MB4237.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:457;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EzkanDW0sehv66LOAqMQqR02aYE0bxFhPGkbl6Os/mmfOOqLsYmCpYItjvQRewA0lK004F98OQ7zv9rPvxyNl5DRyp2tKe8ax97PbSFinrNHIa4htgMwmEgxWUIf9P8CsjwZ/+ZhcEBBmEyZgEuGZgg1foDwnl7YCSS+gUKNFdkFZYWj/ynuTVis29XyyxzvOafbtN5BH7O+7DrPLefDnXTauZ/aYN5IbhkTdhQ/1R2lIWpIDwyIe5fzwFCCxuNtHTgsiOiSwvXpHLWjgSa2Lwf0rpMFpTI1amBxbJ2WOKcAej/1lMAaFVlvQWeB1+ZNtDyhncGN7U8gmY1pmFvAei39EGSp5SqcywLoIkNfGJdHcMwSgJ2wcpMK4yRe+Y5QH+Uy+rJPAc0hLGxA3yFgOjG1Hx/po/mLO5xf5lgmYVMdjeJYIxGKupYd2FqKurrGYfDLHNldvEiG2e4oi8fqcTROH/eF9dGgVFwMZpeXvkG0MZThOArF3jbEsX45FOM+YPiR/V02tr1qpCVFBPN9MbzPKl8F9P3RAP/XExwthGx1sUVcTGVWx/SDC8jtWj9qttdO5HTufC66KocJLr7D00u2tZkRIWEZti59EA4nEtSdk7M9egQhk3Ai4wWvVTKKcb0akEdO4TNhwquwb7vPXw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4755.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(4326008)(83380400001)(122000001)(8676002)(2906002)(8936002)(26005)(478600001)(38100700002)(66446008)(64756008)(52536014)(5660300002)(66556008)(66946007)(86362001)(316002)(110136005)(76116006)(33656002)(6506007)(7696005)(55016002)(53546011)(6636002)(9686003)(71200400001)(921005)(186003)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?NDZ6QjFMTkpZZkZmNU5qOG5hcVZiTit5VFJZakFKY2UzRXNtRHF2L1FDeGIz?=
 =?utf-8?B?Tm1PbWZ5WGxYVGJqaGtqam9lVFVDQjBEL0J5QlBnNHBHSndUUWJuQVFFM0I3?=
 =?utf-8?B?dFlXWHFnRGNaSklHWFJOOEcwTkNvZ3ZvOVRHb1RRc0NHRHVYZW1NUnVSeXNq?=
 =?utf-8?B?ZThaQUVNYzk5L3VZQmV5Mk04VG1zUWZjRmRQTWdocUt4ZTNqcUFYTlRRY0JZ?=
 =?utf-8?B?TXV1Y2ZobXRTanlFV0paOHp5aU1sR0ZDaS93aTZlMG45bnhJTFhlaUw1SHQ3?=
 =?utf-8?B?YW1HNmJ3OGJGLzJVK2NGN1NUTW05ZkkxMjNkS0hUWG1ycmpJMHl1Y2JIbU1o?=
 =?utf-8?B?RDdKN3BNTHlyc1lPcFk5dlB5ZkpQYWpLTGswME01NWNFcDlkR2d2SG1SNnBF?=
 =?utf-8?B?QXQvRStZbDJwMTZ6NlJqR2psQnBWdDR5cXc4MGRURzNvb1V4OHBYMGZ6UDF4?=
 =?utf-8?B?MnN1UnRVdEJIcFJySWQvMWhxaE5USkdSQ01lc1pNRjNUSEMwT2JzRm5rRms5?=
 =?utf-8?B?VUlNbzhHQVBGMEpPc21iTXByOUtRUlVtTTJYT3Z5bXZ4VUJ6WlUxeXNpRk1R?=
 =?utf-8?B?dDB5MmlQSjVySDBOUWVqdi9EK2ZxZlp6ZThrTDRocTBVQ3RwcDVjK2JsTXRN?=
 =?utf-8?B?ZFl2YXF1ZE5IbHpPUTJ0eFVDdjhPZVJDbllaSDlXWGZMZ0ZEeFRyR1VNWWRn?=
 =?utf-8?B?SHBteDhrS3NOaVlPaXlsTm5RRWFrY0kreFhaUkZFQ29odmQwclJQZWg1K3dZ?=
 =?utf-8?B?NHk4L0tpcUVYZnUrNi9aT1FpclRrQ21tZExIc0MyeGhEN0ErWlRYYk44Zmln?=
 =?utf-8?B?eE1hb0JzWmRxQ0FBT3dHeUlPamN4TW93VVJ2K2VxbXBqVUpJbmJkd3FkQWt4?=
 =?utf-8?B?UGkwMkZpZ2hpcGNUSVpEYVFSWjdka1l6U3AwdW9ZTC9CZHk5enRzZ29zeXhz?=
 =?utf-8?B?b1ZwV1pHUG1ZQk1RTHBvdmNzb3lodm96dUxRV0hZTUZGWjZWaXlhWlcyamo1?=
 =?utf-8?B?SytsRGlrblhKWTZ6cEVFVnI2WWRKOGljQXFpdm85VVYrYThoSUF5UEZtMjlx?=
 =?utf-8?B?dFBVaDV3WlUrcVovVFNjajg2TXRodjNLRUkvRGlQeWs0RlJyZktmay9ZYngw?=
 =?utf-8?B?MEg1cmZvMXpKcThqQTBkOEN1bWR0bWlWS0l2dEFXR0RidXF4V2lSSm9Ddkph?=
 =?utf-8?B?OEJjbzFoKzQyN3cwaDZtZTRRQU5ibTEwZEVWeXRuejFzQ25pcFYyeDJNTlli?=
 =?utf-8?B?OVc1UDhLc0VUQ1FJYmdmYmlBMFp5ZmJ3S3VoYStKSDNvWXV3eU1QVXc2ekg2?=
 =?utf-8?B?TjkvODQ1Wk1QK2IvMEl4eHpDdEJkbE1keXA4cU0xSUdFeUdDc1MyVVNSdDh4?=
 =?utf-8?B?M3ZJaHFybmZwYitIREdXbDRxd215eWRhbzNjb2NhT1dTUWMraWZKY3ZTSml2?=
 =?utf-8?B?RlNvQ1AvN21oTUJJMGpDdmtheWwwWjNneHVrRldtOGFORGwvb2ZhV0FsNWNz?=
 =?utf-8?B?Q3ZMTmNOc3BodXpLM0ZBUDlMKzJTZ25YaFlha2E1WU5EdTlXNC95U00zT1hn?=
 =?utf-8?B?azRkcUdmeEJoYkxQMW1LMm9pZ2ppQXZFQXMyUjFPd1R2RzQvQUpDbGxBVkx4?=
 =?utf-8?B?ZzVRRkk0OWpKWWp6Wmt2dXQ2UDdXeHo4VU9YUXB5c2p3am5VUFBLaWZld25u?=
 =?utf-8?B?bmxmaDZYUW56QlRiRlllU2luOGhTbERjN0E0NUdhQ29zeCtydm81UFhWNmlO?=
 =?utf-8?Q?kC64jExJn/BQgolLgV7L0iH30hZeMRhObuEE6Pg?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4755.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd38fbc-3a4a-4139-1c87-08d929c936e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 15:30:43.3534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBw4PkIFfhmmboLF5L4szJC5pasVZa+xW4VQe6GOHT0x/SP9hx3BjL7Y/MjRO8e/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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
Cc: "Ming, Davis" <Davis.Ming@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

We don't need RING1 and RING2 functionality for SRIOV afaik.

But looking at the description of the original commit message it affects RING0 too?

" drm/amdgpu: add timeout flush mechanism to update wptr for self interrupt (v2)

outstanding log reaches threshold will trigger IH ring1/2's wptr
reported, that will avoid generating interrupts to ring0 too frequent.
But if ring1/2's wptr hasn't been increased for a long time, the outstanding log
can't reach threshold so that driver can't get latest wptr info and
miss some interrupts."

Rohit

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com> 
Sent: June 7, 2021 10:31 AM
To: Khaire, Rohit <Rohit.Khaire@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhou, Peng Ju <PengJu.Zhou@amd.com>; Chen, Horace <Horace.Chen@amd.com>
Cc: Ming, Davis <Davis.Ming@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Use PSP to program IH_RB_CNTL_RING1/2 on SRIOV

Why are the ring 1&2 enabled on SRIOV in the first place?

Christian.

Am 07.06.21 um 16:23 schrieb Rohit Khaire:
> This is similar to IH_RB_CNTL programming in 
> navi10_ih_toggle_ring_interrupts
>
> Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c 
> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index eac564e8dd52..e41188c04846 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -120,11 +120,27 @@ force_update_wptr_for_self_int(struct amdgpu_device *adev,
>   	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
>   				   RB_USED_INT_THRESHOLD, threshold);
>   
> -	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
> +	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
> +		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1, ih_rb_cntl)) {
> +			DRM_ERROR("PSP program IH_RB_CNTL_RING1 failed!\n");
> +			return;
> +		}
> +	} else {
> +		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
> +	}
> +
>   	ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
>   	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
>   				   RB_USED_INT_THRESHOLD, threshold);
> -	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
> +	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
> +		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2, ih_rb_cntl)) {
> +			DRM_ERROR("PSP program IH_RB_CNTL_RING2 failed!\n");
> +			return;
> +		}
> +	} else {
> +		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
> +	}
> +
>   	WREG32_SOC15(OSSSYS, 0, mmIH_CNTL2, ih_cntl);
>   }
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
