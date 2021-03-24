Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A5EC433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 16:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4105A61962
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 16:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4105A61962
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1EB889C96;
	Wed, 24 Mar 2021 16:44:00 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2085.outbound.protection.outlook.com [40.107.102.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E2A89C96
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 16:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTRZOhBA4SF+RAsEDkPpgPmygodLf4gvbFtkAIxJ72IBE6w11bvHg3x0l+XqQyq2zKmLq2lc/A9XQV4TDjZIzR3+B6Jxg4NYyiaoctEh9hV19NZs1038v2m45GREKUw4MUdJC0Nor9UuHiVbngOx2ou9WmV3ZMJxGtVqp/MTK0pdMS5PQnUSNmRl+MmnwGAzTt4RF31ka/+bhiGlPK8fhqfC4qFW1SB5iNOCz23sNWX4CBniSg02iZoRiZvcdQPHDh5H2eOuJXrZAsNcqivPojV73ECSqiE9h0uUm0VQxJBLstK7hVkheDCM0I1tYQHMneLCkkrfxOnU2UAwjSr/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3fWBU7evQWO4sRrshTIWAP5Sk/p/jl853xhnzHkNMI=;
 b=NhZvWDmHwrF74RnKnTFgyWQ9s5S37wtEzHTj2wy2Pr2sfUVJEoHn59RNp/Rkm6iRz9jfjdaTzj7N41UadBz05UQ9/xNOgvBZBgWfWBqDcmi3exmDlfVW/8iFM1qdmcJqtMRMp2E2I1Hi/noiavOPJixwxqLJ8aArsgNR5tyxfKv6uyVjyWJDG7rhDjjZDX8SvKTkhrKBo3lWnTUbVhAOQ0+9HdZ7j43TFfIBQ6xcua7VOmYu3WmWJe6mI86paRxyLhRKzvV0MSibchFKVKWrYITOCsBAfb4bK91GuSl7cm/K9gLvSQpdaTEkhlr4N+oyqWbkQWIpvC3YUdAoGlhkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3fWBU7evQWO4sRrshTIWAP5Sk/p/jl853xhnzHkNMI=;
 b=eNi8o6x+Y7yHZ5BPDjjQV7ZbktdLyx+0iLDPrLJWHx1Zt4MdZSSsNEoR/mBAn1KObYsll6IRYGT/hgRTIlB0O8mSXdthNxrjOK8DtOmr4/c7wL9j7ROGzhdtsDoUT0tK6dWT1hRb4Avf/QqJDiVfkhvDRnEKnCqgTbKucV86Css=
Received: from DM6PR12MB3324.namprd12.prod.outlook.com (2603:10b6:5:11e::26)
 by DM5PR1201MB0267.namprd12.prod.outlook.com (2603:10b6:4:55::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 16:43:56 +0000
Received: from DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e5:ccc4:4120:4b89]) by DM6PR12MB3324.namprd12.prod.outlook.com
 ([fe80::e5:ccc4:4120:4b89%7]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 16:43:56 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Cox, Philip" <Philip.Cox@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Set amdgpu.noretry=1 for Arcturus
Thread-Topic: [PATCH] drm/amdgpu: Set amdgpu.noretry=1 for Arcturus
Thread-Index: AQHXILEGLVikq+7vq0WGlFj6kOimoKqTWEvg
Date: Wed, 24 Mar 2021 16:43:56 +0000
Message-ID: <DM6PR12MB33241A1F7B28E74148A7981285639@DM6PR12MB3324.namprd12.prod.outlook.com>
References: <20210324132410.12754-1-Philip.Cox@amd.com>
In-Reply-To: <20210324132410.12754-1-Philip.Cox@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-24T16:43:54Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=62bbb84d-9803-4e26-ad37-adf8a5cd3fe6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc2ef14e-889b-47b5-b2ed-08d8eee40476
x-ms-traffictypediagnostic: DM5PR1201MB0267:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB026752454370C95B4AD7674685639@DM5PR1201MB0267.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tY2TxZBn0Gg7CpS5sRaz548kklNSvQ6tHJAI2fgwGhieyg2adfqCpH93we1QJ7wrJyzKm+16lqBG36mmluKLDVouKTaWons2+GqGeVY/PaUDT3VB0n44kaVW8KwhXWiATrZQ86aj2VrLiJF0pXp5dum0ClrYZh/aaWI7Q2KCdcMNUJaJmPtmHRJ57rtM59iOQgorDflzFSqvgxgsj/+5eaqzE29fH75AxYIJfST5rPyG32WnpapL5WDpASSmtKXco8FHO0I5U06g9VDzZ6JJ3jpJPx9kX+FBeoMeSwr0iIUwIScQaGR+f+g5eTFvzCODnQO4KuG987JX95F2YmbAeaglfmFgFqZ8uU6X4WCpgNZ1on1QGOk0n/L5wurLtmvoVjxSpuyVLjJZWufeeiTPXP6PURf+QlQrAEHpZCOT3m+7rUu1BAa1SWrXY8vsZo+25VAR/uBh8uo4ZmsD+IuqhsULHvDxIEd94idFn8u0RbF/XFndzk/8b6Pk+xeVLlxzM6hf6Ci7T8eyY1eyOX52C94HPqlaoqAVEXIrXsN0/1Ez5T08UxortQqmS4L1Al/8dmwcD5cbBrMjrU0n+P9zAwlA8y5LHgu1rUPxe/Xv/I/oZCgfC8XiPcA5UZlVUR3F70nuVz3IsVJL9oU0lYxVjCEjP7WSzqKPeT4TFXQ7Wf1xVtiSAxRmFdY4arVKftw1GMKKJ/htcSEiKhaptddgL/RA+NSw9oGSu4a+i1Dgb74=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3324.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(8936002)(52536014)(4326008)(66946007)(66446008)(33656002)(64756008)(71200400001)(2906002)(66476007)(45080400002)(86362001)(83380400001)(66556008)(38100700001)(966005)(7696005)(478600001)(110136005)(53546011)(76116006)(186003)(55016002)(316002)(9686003)(5660300002)(26005)(8676002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uiTBq0jUKrKM5xcnLrlsr9jAnoEuzm3AdVivwFPfiGYkQ3NPxyyybzZDOaxt?=
 =?us-ascii?Q?VGa6/6zTA0WKQXlfrB6w7wdEDH9pk2BPyiGFpee8HUB1QsEhAN5oWU+ESvwm?=
 =?us-ascii?Q?eu6MO6icoAkpYWLCDfSkVUiz1cI7GwEfb5zUC+50OTCz/xlTXabbY6kfUAgD?=
 =?us-ascii?Q?PzpOO3AYO7dSfxkaWsdo/F3frac4lG7goyB7Zra+c+HnikDBIPZu0P9wW5GO?=
 =?us-ascii?Q?Iy7R+VKgCj+L7YeS4Qz8UEtU8mw0G8Hk610EKTJBO1jT+YSUc4Q83fXl0154?=
 =?us-ascii?Q?8lShpk8BmtQFbVUpZtUGzqjcLZawKYTeB5GucXAoPnvpBslcaRNXy66uoioz?=
 =?us-ascii?Q?xgAsG4hGbvVLMW1nTpI89DFXlMiY4owV0yeBciinzJl11zsQAjAwkFpnnKTq?=
 =?us-ascii?Q?blXHr0UqJyqFobUGOnTXVTcZHALC5IEdm4MCelilR6nSsR9GmwkjMTUrDK16?=
 =?us-ascii?Q?Wyaw3ovHlZKSFYxvxEJTsGbu7kd7nBK1klLPrskrve4oTLnj1jFDFaUrKovN?=
 =?us-ascii?Q?QAW5TrywWDow/cnXaBtGcRk/naoEgtBiMt/abkxT/BtknFrocD6eV87ahTkT?=
 =?us-ascii?Q?ZJhdSExiyxEKLYGl56jLmX93Y20FZqZZOOAZmIhW2/gPIWxUOkc/onODVffk?=
 =?us-ascii?Q?0xQE1GPqUlXY6W5o6yX/J/BpNDkOXHQgEEEFLhEuNVvbBRZS95RrAcBNnSKa?=
 =?us-ascii?Q?ZQjTiqdlG1CpgFHFpxrK1eVQRM6QLQK9ousisnSWviOKplCTQ7V5Gx0/qiBK?=
 =?us-ascii?Q?lFhrAKWbTgOBWshmydDWzrtS9+4s34WqcbJS9VLFnRIphv21XfPw//IJiAVA?=
 =?us-ascii?Q?vDXS+NceNSzzpLvIx+cvlRUhQqtC3Mcc2wpMwMs2cd8No4vV0De68IKJdbGZ?=
 =?us-ascii?Q?I96tgdskk62cxSYdEh4mqKdWy61G0l1YDO97xbtPE96+r9es91a24nl1pOSC?=
 =?us-ascii?Q?SyiI170dwFAZgWbUXDICjDg3FZ6JJqTSgn3RNoNetuB1ogrrEK/dcnOJfVJd?=
 =?us-ascii?Q?JDuVTh1ipwAB93+N1UaZrC/i2iaE9yOJ2oEQ3BgG/naXdHdVIVsVQhETTGTo?=
 =?us-ascii?Q?L5hjuLHB0D1J8uFkrKwZllCBkXp3vejhJQumNaVTB3lgKl9EowzGl+2z86Rc?=
 =?us-ascii?Q?Hnf1W/KutZXnqsIBA+qeXq426SV9GB+IeyzaywLD35KQHjJxH3QhiJqfZZcc?=
 =?us-ascii?Q?tLY5BDPQVXQDZUaXMa8MhI4ttpW4NnqP9WwMK3zq3th4kWCXt6UckY9UPHJr?=
 =?us-ascii?Q?CHNnhMhQIbtpHLxQLvbEHq/x7chJtMAUEznG1wGfW5hdj1/g1WYVk7og8/4x?=
 =?us-ascii?Q?0wUhFB+bMCfl2hgm64JomGiO?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2ef14e-889b-47b5-b2ed-08d8eee40476
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 16:43:56.5938 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQ/QeUVel5SfI7ROh/K4pnjaQKP9RmOYBucdFZ7EdCcNyYwsUeVTzO+pI23Hd+eYw49TOO6EcwyYv1qRip6dXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0267
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
Cc: "Cox, Philip" <Philip.Cox@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]



Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Philip Cox
> Sent: Wednesday, March 24, 2021 9:24 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Cox, Philip <Philip.Cox@amd.com>
> Subject: [PATCH] drm/amdgpu: Set amdgpu.noretry=1 for Arcturus
> 
> Setting amdgpu.noretry=1 as default for Arcturus.
> 
> Signed-off-by: Philip Cox <Philip.Cox@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 1e07c66676c2..b9d68fd2610c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -516,6 +516,7 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
>  	switch (adev->asic_type) {
>  	case CHIP_VEGA10:
>  	case CHIP_VEGA20:
> +	case CHIP_ARCTURUS:
>  	case CHIP_ALDEBARAN:
>  		/*
>  		 * noretry = 0 will cause kfd page fault tests fail
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.or
> g%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Ckent.russell%40amd.com%7C2c07a0acac274b89901908d8eec8
> 26c0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637521890728881804%7CUn
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI6Mn0%3D%7C1000&amp;sdata=OBKwCLSerFdepJPSPF1njp8QJV0hlTeR2xdpWmApSnM
> %3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
