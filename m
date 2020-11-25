Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D73EC5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 06:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB3420708
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 06:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CeK6hVsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB3420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD8776E82F;
	Wed, 25 Nov 2020 06:45:06 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700055.outbound.protection.outlook.com [40.107.70.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F49E6E82F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 06:45:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llBYwFjPl7JJu1wIh6qaWAjOVnK8TJN2HFeIOc+bim8wNcwtGzrwdGyk+BFtPycYngMq7WsV0N6ytktuguSTjwLem+TsVFGhpLMbjuZ6UkjgBdVrP07QqSCgqwPV02T5di4SyuujQaK5LtoRd65er1mwzbrcaW49S+aTIAUeJXQFOOtaQUwhR4Ml9PypG0pQ3q5RoWnq2DKEZG396jh5o55iyuclp4dGXrh0kxPqeetAGXCol/BhGwEUeGGWQ5cA0j76WScXNMEHncvd8wz+JnJ8wcaLhxRVwKQiijinE4CgrQkBTeOHCAQ9s/zvvxsgt7oiiM2+n2BgHIerV8RHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6YDqhKlNCK1+5FGEu41l5Vdzo1cCU9mtH8Qep7+a28=;
 b=eUt7lFKZlICsrX/7dgN39N/kPPx5+hugzhfElYHN1yPOiUP+cxf6IBrpXsSA97GH57/0Caj2CX771kYIMPZ128Vk1qHRc0p7SSttk7IA+pQL0wWvAWvj43hJ+IOKC7LbwkwImeLLsYBdUERT1DatbAFlTfpG0NWLpPSU3pOl7blRMdGGtDDNybEy1ruqCcmbKKsjLa9kgbDeRsjgCpwXjJwj3suglUvdVOj68w6oUN9czVTpNizLQ9+XMnuKXPf3drB7KD49KX1gVE2dZ3+4njqgVCHIai02pz4XXDr+V4+9gjhLQtmFbfksd/lGYC3VcYgjcYttoWdrrApyx9A7xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6YDqhKlNCK1+5FGEu41l5Vdzo1cCU9mtH8Qep7+a28=;
 b=CeK6hVsnAg3IeuKbwt+mXI5CFkAH5LfdusfCFGuPyDGalhxie4+t8kv/oIg5u5JoZu96JwAysXOrtanC3wI/RlWeWcVSA25u3Rd3y7B5mZXR6oxYqY9IX6S13gB84td1XReItK12FONG9OUgKpkSR3I6RwiGy3nzIaX8M+N85Lw=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1750.namprd12.prod.outlook.com (2603:10b6:903:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Wed, 25 Nov
 2020 06:45:02 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3589.030; Wed, 25 Nov 2020
 06:45:02 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, JingWen" <JingWen.Chen2@amd.com>
Subject: RE: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw
 in SRIOV for navi12
Thread-Topic: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw
 in SRIOV for navi12
Thread-Index: AQHWwkcSyC7H9ERIqU6kZy+Nte0A7KnXS3PQgAAObwCAAQ5cMA==
Date: Wed, 25 Nov 2020 06:45:01 +0000
Message-ID: <CY4PR12MB1287ECC874E7B98D4D7D589BF1FA0@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201124094905.25255-1-Stanley.Yang@amd.com>
 <CY4PR12MB128779E09EEFC614305187B6F1FB0@CY4PR12MB1287.namprd12.prod.outlook.com>
 <DM5PR1201MB01240896AE165C5AC5AE50049AFB0@DM5PR1201MB0124.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR1201MB01240896AE165C5AC5AE50049AFB0@DM5PR1201MB0124.namprd12.prod.outlook.com>
Accept-Language: en-US
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
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-25T06:44:59Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 2f79c91b-7fa0-4a52-ad04-0000047e9f14
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.158.166.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b47defb4-2c02-41f0-fe19-08d8910da28e
x-ms-traffictypediagnostic: CY4PR12MB1750:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB175075B49A5F64AAA054516AF1FA0@CY4PR12MB1750.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: As1G28zXNnSN/6zHegkMQG7W+cW7beac7xKjBPpnE8tSbgGL0e2MPZDtaNZv3S2FotUp+2nA+37R661u9Mi0fovmhffiWUD0Vlq4A5jHl77CHYpJG3B//YHJmf41bLh6CTpZPZ80L6TputkLECxl0QA0aQ0BM3az5dckTolyh/ZtPrOKHsFrhqhTWMcr9tg1/W2OAGfKXBMULh/AAxMkzXVy5+Rz/YTIlzAeUGq6YtooliRKq8LoVFbuBPgbrYkIkB14G64MENVtFu6i0o02U/B2YRSacySlUN6G1LmJZEf2Obuee11A8Lfitb4wtUhh6lBSwTrmE10aGRzqjXhV9JhQYkIzgJJ67gXz9SCqkdkZDOpreUze66GXwIkVwIu1dzA0cpmLXVUGphst0bpzHA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(26005)(45080400002)(86362001)(966005)(6506007)(2906002)(83380400001)(186003)(52536014)(33656002)(5660300002)(53546011)(6636002)(66556008)(66446008)(64756008)(66946007)(478600001)(110136005)(316002)(55016002)(9686003)(8676002)(66476007)(7696005)(76116006)(8936002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?saeeptcJmvpli5qJ9OrZdLwoh5XUQFBOgQYiY1ZxDXHbw/0LcH/IU8KpORD4?=
 =?us-ascii?Q?i+V2J4RO5Op/3Nbm5/+MjN8O7Wf8o8DRYZ9++OXWKcNKr+1IPIlCdvjEKbBR?=
 =?us-ascii?Q?y+aUrgWk9PVkGIlZIeGBeij4Jukxk5JUP9yaaY0HwQuaqZQcP6AZEK4yLn+k?=
 =?us-ascii?Q?Wa2z3lTJHpi3ErzlSq9MwUFW0Y37l7NQ7M9IfWIaMnN18hPBuhSspMzr+j+j?=
 =?us-ascii?Q?GwCv0Xxjf+MYPvmkFzCx0fPR1eukfqI+2FQ+Lx0/Vhwi+KYk1ZmwdNeydZsp?=
 =?us-ascii?Q?HF85vI5rGLIPkCXe+quJpt3y2tnUH2o1CAy149rGjoTOfINHiuSLZDjDRtyj?=
 =?us-ascii?Q?ZmoSYA1BwxfU7hI01Q9i18MZpXFjcpvRqmokaUpmspOQ3awoVHhBS3142A3P?=
 =?us-ascii?Q?ydhZuW1YzVcPXJDwzirEweL1X31imZyTNEpkSBDakjtNdhkG+SEVnDY9Z1vg?=
 =?us-ascii?Q?Xh9kDI7nAgrtL23B0qNg3bZE/biE97mlEq3Y6ZZWuBwgI+Fy7kFosf2fiEPA?=
 =?us-ascii?Q?IJGv8SpM6S6+w5as/pDZfRcZsJXz+6zkf+uWXgRevxelFrfVPofUvMlLq6/A?=
 =?us-ascii?Q?zHOFREnZYrt1gNciNw4104JPLkGJj6Jds53DwVFGqarcvbkycQU3gm4exMJ5?=
 =?us-ascii?Q?EaiOlGqebXg3GsDAec3lepi5V6AuruBnxenzufCmWcBqLWgcPQhwpXszMXGm?=
 =?us-ascii?Q?MQoR30jxyX5h1JcPs0DhaR1K40HSmdRFAKir2/y3eboxFTkSj4fcpCyCcDtm?=
 =?us-ascii?Q?/w9Yft8N92LGGhxDoY4RoKT8a+cai1FBiGTKWrdAjSo/eUXEmN+PYw6PL0DO?=
 =?us-ascii?Q?9380QwEcZEPr11Hz4q+JUnOr3zGdk06lJVLEZxYhQJPMSILyXwls4Nl/Q8Rk?=
 =?us-ascii?Q?p7J0J2FgWaBIs10qnZdmB3LeyD4mCgT89R4qIRSdDGIolWia8uxVh88mzmUb?=
 =?us-ascii?Q?0NI5afWNRDbsosdD8bwrbNgQR/qRJYUrCdw+PkDJbj8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b47defb4-2c02-41f0-fe19-08d8910da28e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 06:45:01.9288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VwGesGUVlQsuX1Dvzo8/CqP/QQsWCUd1+TSc3ByLU3/omPFrfV30Ii0XbQHmLRb46nehWszHS1OBOkuO4koZHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1750
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

Okay. With that fixed, the patch is:

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com> 
Sent: Tuesday, November 24, 2020 10:37 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Chen, JingWen <JingWen.Chen2@amd.com>
Subject: RE: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw in SRIOV for navi12

[AMD Public Use]

Hi Guchun,

This is an oversight. I forgot to remove it from patch version first.

Regards,
Stanley
> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Tuesday, November 24, 2020 9:47 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; 
> amd-gfx@lists.freedesktop.org; Chen, JingWen <JingWen.Chen2@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and 
> asd fw in SRIOV for navi12
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
> Subject: [PATCH V2 1/1] drm/amdgpu: only skip smc sdma sos ta and asd 
> fw in SRIOV for navi12
> 
> The KFDTopologyTest.BasicTest will failed if skip smc, sdma, sos, ta 
> and asd fw in SRIOV for vega10, so adjust above fw and skip load them 
> in SRIOV only for navi12.
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
>  			dev_err(adev->dev, "Failed to load smu firmware!\n");
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.f
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
