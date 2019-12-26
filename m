Return-Path: <SRS0=shUv=2Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69370C2D0DA
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2019 08:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2114D2071E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2019 08:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BwvBe597"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2114D2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F72289A60;
	Thu, 26 Dec 2019 08:07:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB0CD89A60
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Dec 2019 08:07:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVjp56M0BER+nX9O7oBuUEGokCJF0J8/UFTmAHOEOpuxerIyyk78XC16s6UkuF9ibC+bqVwn1B0OqXwRQuos7vrYK+1xzELgYrMDm7FpzT+Rie4aJfX43nDxrh/Z0IlVVzXwAcC/SD/BBLqoc+xDepvDLJ4dFQGPChZtMxsnaqEHRYH0Gq2oBSKfNGtaG5kAdfKSz9bVKuhz3iI7dl+SvQSuI4mmT1/YoGVyjv1qxv/I7Mq0/6mZYE/auGgpEoLprXGZpO8SfGZRaaJi+pCTmqQNqLn7zz2nbbAIrCbEpPQ1Gd94zpl6qKrqUfXAy1CV89nOo46KOd3Fkd5w1+Kldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGdIuMCOUpUvIkUE2+qGjEAKuUtxhJcN4cGPxgbABQo=;
 b=WQB848XkM9RgN1ME+QIDhk8Nl4rex4ZRgt5PMIdkZydRov+QypyMr9MVl6InJr2sMePlUdK/we2CFUQEoth5un8Pk02RrIKXF+UqNl2b8Ps+zY5Z98tutBW+0Dos2v3OSBWHvhOjV9tdZGFXq8nj4WAv3R8LsXMrnjQ+JOynSC3SO+BFNrUo6RRlH9rhTIpasVHySyCZwKUwwlZ2Cjm5HgH1e6OIhmJukPVCldmYzLoFDj5Ef4R63jF5CFEq6YeOP+MtYSQGiCcnn5wK0YYWT4HQGkX2PIuY748QO/+7TlkkK2nESKy+op1KMlhC7PmKD1N+dUxtE7INekqTZMCuCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGdIuMCOUpUvIkUE2+qGjEAKuUtxhJcN4cGPxgbABQo=;
 b=BwvBe597dlabBxr7xs27itV8c16/tO6YJ/487e0RLUG09p+Ee9ad7AK+PKGh84NH9/5oYS8YC4Hdp071cb2T5LaNRdgShkzJXp75nAstOKgX1vL3rpXuzR+LITNAzahGf7cxLGqD0YihdSLU2mqW6oXgXsV0XagCnrTptumbjQ8=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3200.namprd12.prod.outlook.com (20.179.82.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Thu, 26 Dec 2019 08:07:20 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2581.007; Thu, 26 Dec 2019
 08:07:20 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>, "Wang, Kevin(Yang)"
 <Kevin1.Wang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay free driver_pptable for smu reinit
Thread-Topic: [PATCH] drm/amd/powerplay free driver_pptable for smu reinit
Thread-Index: AQHVuhemLl+B7+75+0qe2ZQ2gTLpLqfIuyRwgAMBINCAAFXJEA==
Date: Thu, 26 Dec 2019 08:07:20 +0000
Message-ID: <MN2PR12MB3344E09B4F1506D7ADC5AE42E42B0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20191224050436.14641-1-Jack.Zhang1@amd.com>
 <CH2PR12MB3672B764698E7096C75B1ABABB290@CH2PR12MB3672.namprd12.prod.outlook.com>
 <CH2PR12MB3672A9532F7B66EDF11E716BBB2B0@CH2PR12MB3672.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB3672A9532F7B66EDF11E716BBB2B0@CH2PR12MB3672.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2e7654c3-1ccf-432d-8df4-0000cb90eb8c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-26T08:04:38Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 008b38d4-0ccd-45d1-3de9-08d789daa18d
x-ms-traffictypediagnostic: MN2PR12MB3200:|MN2PR12MB3200:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB32000A76CC1BC006E2C93D19E42B0@MN2PR12MB3200.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(13464003)(189003)(199004)(53546011)(81166006)(6506007)(86362001)(186003)(55016002)(9686003)(26005)(7696005)(66446008)(64756008)(66946007)(66556008)(478600001)(33656002)(8676002)(66476007)(76116006)(8936002)(81156014)(110136005)(5660300002)(2906002)(71200400001)(316002)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3200;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3bBQ2rv4H2lKVt2eRVgfzTz3PrcS7uIduQoh6OVJTKoOjeDcP+wsUS01D9j2HBrFeWWoxvNGbCyjSIsH7eTRcKx5YntkaEorReJrho4WFDgLUyCps7+qKAulQHUrsYqZgQiILb/6B932hZaRwkU3nyqn2axqqwjYqcZPTItRq56tAs/GrfWmmHCzK9z/dlwcCLFKKEez3D38ZsG6kVkzHF7zTEg/mSmPFAQygaaomLJOKXK8CnVsQT3sdYGg687bX04itQw/3rFhd8kJAeN+e6YMSzLkeqMXqAH8M1Ui2KVMa7x+TP7Fmu6g4Dgz0fL7z4MN8Ygk2V/wUrQCPidBsWl+sQli9RXq+zlQmWR66WivMelWnKHdfgzuHVNGh9OEeeUqfzzGjCvz68t6USU6BXcMjskpVPfRczjmi2RddmRveksenjq7wz1w0Mdsf73jEdyTZbQw7dzZ5eMfYkct34wsFe8NYmpI/1mpgmgp1RKPfn0zmeXbsqytJWNWqqTI
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008b38d4-0ccd-45d1-3de9-08d789daa18d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 08:07:20.2028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F3v9RmTJ6msMiI5fxXamHSqQ+OvC6BkIM4OSJe5coROPkq4fYvwqx/QaP53NW8Ye
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3200
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

As I know, the smu hw reinit is not on the path of gpu recover.
Can you help me understand the use case?

Regards,
Evan
> -----Original Message-----
> From: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
> Sent: Thursday, December 26, 2019 10:58 AM
> To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Zhang, Jack
> (Jian) <Jack.Zhang1@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amd/powerplay free driver_pptable for smu reinit
> 
> Ping...
> 
> -----Original Message-----
> From: Zhang, Jack (Jian)
> Sent: Tuesday, December 24, 2019 1:05 PM
> To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Feng, Kenneth
> <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Jack Zhang
> <Jack.Zhang1@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amd/powerplay free driver_pptable for smu reinit
> 
> 
> 
> -----Original Message-----
> From: Jack Zhang <Jack.Zhang1@amd.com>
> Sent: Tuesday, December 24, 2019 1:05 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
> Subject: [PATCH] drm/amd/powerplay free driver_pptable for smu reinit
> 
> During gpu recover, smu hw reinit will fail becasue table_context-
> >driver_pptable is not freed and set to NULL.
> 
> Free the driver_pptable pointer if it's not NULL.
> 
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 7781d24..ca877bd 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -713,8 +713,10 @@ int smu_v11_0_parse_pptable(struct smu_context
> *smu)
>  	struct smu_table_context *table_context = &smu->smu_table;
>  	struct smu_table *table = &table_context-
> >tables[SMU_TABLE_PPTABLE];
> 
> -	if (table_context->driver_pptable)
> -		return -EINVAL;
> +	if (table_context->driver_pptable) {
> +		kfree(table_context->driver_pptable);
> +		table_context->driver_pptable = NULL;
> +	}
> 
>  	table_context->driver_pptable = kzalloc(table->size, GFP_KERNEL);
> 
> --
> 2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
