Return-Path: <SRS0=VOM3=FU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A15C4361B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Dec 2020 02:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8628122CB8
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Dec 2020 02:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8628122CB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 117FB89AC2;
	Wed, 16 Dec 2020 02:29:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F5A789AC2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Dec 2020 02:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awiaBBOsAjS0wkoCTnrKa/1QLzGRKHdtUgXYXHhZ7pugOG5l533Klg1Wu13JCv1L7IPKGLBnEje0H+9NdHuUjt1kPzC8946ay66b0jC4UR9a3WtEc258UwzZD4zkHp5GTywu7UOnc0FxONOUBHLn4p/I0tZRIwDhNpxpKdySVLCXhDWkc5Ze6/ggBcCJS9recK/3aJwtEXsZv2l/H9ocvgpk1piX8Y1zK8yzd0bKcyEBwCiz448RfHW0QTSJiWFDPTrt5s9ADfMhA+39W8Yi+7439dVium+Fku66gf271bfGq/hY6+6Dv7FicpUxrtQECufLnnzvBwz80LIcQe+k2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YfEY3pCOOJDEWmjC2bq1ZjsQsG4YjVoScH2k0zHNTc=;
 b=bWxy6w+sOoaGi6Gb/RT7durTKTJ/8gvO3UwmMxopL37m8PiLhO8xBmd50pGNetzuKdpFX3GZp05OP2Ebu1vq71S4jDaTHcLDRcCj3jIx78gfXqz/N4kxDwMcoNay2kDQKYxdeEMZHbHZHO1Q8+7Aoy2W+BavKSRU4A2u8vTW3g3bxurkuQl0LNLt89mXF0N9BtDCeFJyPbaK0lwM0cGZnc4ppBQC+GQCh9hdJ1MGhtzEru3g1y+jqHkIYEkDpfKlYphGZU9mV7crWKxkcj/UH8/4wmSColp+KuQYPISV5qBnkKlkfObg09t+npIf4q1ogmjNg/b4HHI43Cad3Ek5tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YfEY3pCOOJDEWmjC2bq1ZjsQsG4YjVoScH2k0zHNTc=;
 b=xSXM2egA3kqYYs+JFvYuJSQmSdbR3w+jDV+goEMSnLT5A4SWatHondvDEinK8Uuqw0vchCaEOCiSZdFNwqonwFIqHAqB8k2GYZICHUf2iCj/tg0LM1vbG08s4hNLtRBmQeyCk3Kw6FLrNXCmLhESFIiMBDo8BXXrcLNsmostEco=
Received: from BN8PR12MB4770.namprd12.prod.outlook.com (2603:10b6:408:a1::30)
 by BN6PR12MB1378.namprd12.prod.outlook.com (2603:10b6:404:1e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Wed, 16 Dec
 2020 02:29:22 +0000
Received: from BN8PR12MB4770.namprd12.prod.outlook.com
 ([fe80::a440:d0d:9875:252]) by BN8PR12MB4770.namprd12.prod.outlook.com
 ([fe80::a440:d0d:9875:252%6]) with mapi id 15.20.3654.024; Wed, 16 Dec 2020
 02:29:22 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/disply: fix documentation warnings in display
 manager
Thread-Topic: [PATCH] drm/amdgpu/disply: fix documentation warnings in display
 manager
Thread-Index: AQHW0wUoN1S1ckEQXUuQfgUPYBysoqn4/sQQ
Date: Wed, 16 Dec 2020 02:29:22 +0000
Message-ID: <BN8PR12MB4770397624A10C41515104EAFCC50@BN8PR12MB4770.namprd12.prod.outlook.com>
References: <20201215171003.1628871-1-alexander.deucher@amd.com>
In-Reply-To: <20201215171003.1628871-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-16T02:27:51Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=700d41fd-f559-4d72-8f5d-9060eab3016e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 97c169e7-d599-4a1e-13b8-08d8a16a65ee
x-ms-traffictypediagnostic: BN6PR12MB1378:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB13781ED2766CAC6E8FCBD6C5FCC50@BN6PR12MB1378.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F044kwAVfEqZCOXet7AkpeIFkP5pC3RRTqvqEQ3+/c6hWWQ3RdwOFAo+8ooqOhQ4wgDfOZe3ygij7Zpv8bYoEwkVGh8GSs4Co/o7QSO/faosxyXlSsG7VDoxmlzI4U4ETvU9ZnE4sP9lDG8DXKGQRsXJzynfgRX2kbCirc2nab4iZEAlxDOXSiDE5o7HO+2kW7YRbTZtdNdXUoOzJu7KL/WRyhXcCc254eh9DrchD6T+ed5WFihiyWPmeyQ4GQQ1ElanyfQ9Nf0V6t7NXGVJTjDAGyHW5ZVUxBZKm11UXo+GB9d9VmQvgdTKftOfH+2h06MlNrjUl6C9GdzmJ026EA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB4770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(6506007)(66446008)(52536014)(2906002)(26005)(110136005)(5660300002)(54906003)(9686003)(86362001)(8676002)(4326008)(186003)(66476007)(66556008)(33656002)(64756008)(53546011)(498600001)(66946007)(55016002)(83380400001)(76116006)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OcoNMI0mSYRxhSpJY6YZuOyZ2fF1Y+u84OUYJUjxKoTO47USFM0tr9SZ6d8p?=
 =?us-ascii?Q?DujZJ8Mjk2Q3Xh81vXMh8aAX6Prt0ejbMJW+Cvb+88ay0SAWOJKOfj0kqjB3?=
 =?us-ascii?Q?JhxWVzZjuvKAZQSQ+wvtl+8OWxDEPoUqwnmQ5ms/k208FvCeQT64E3xfmZo9?=
 =?us-ascii?Q?RXgyLcOGHIj9t/1+C9SUq0Y/hRD2PCHGQQNeq1Lj2xfw27F4PjFfr2vLkCHZ?=
 =?us-ascii?Q?nEAC75i6ZLw3Cz+ICPm8eTPi0JLlVEUSp2T8QXDHY7PPzAo/eNjXGvqvVAXR?=
 =?us-ascii?Q?HNklKo4EWyFcXDoXfVQpkCV5YXI1z1dZqkz3cVJMdKFjh2e5VqZ2Nq9zQ6/o?=
 =?us-ascii?Q?K2I59Pf3VHwk+MTSXtuFBdxMS2jzKBhj3FWQDrXzfTJhXbFgUgXIZsUuvg8N?=
 =?us-ascii?Q?tqW3/CBX/7A+NUel3HNRvZ+hk7cLNxf8GXt9q8AXrQIY5BGEBFyDCcAM30tZ?=
 =?us-ascii?Q?DfEZ++ekZsEY3no08mQEi3OhtD1TB67hNFALe5N6RnxEOiosAHOMPV5VMHnv?=
 =?us-ascii?Q?BZmyfKN3jPiB+ZHAoJeXopRv0K5wf5rgs5npFVNrMR1PTfmw6KkxjUUh2mpI?=
 =?us-ascii?Q?E4tWH+vUMsnzDmenkApMKZN42nTioVqej1/E911N0WQueNL0Ta0s5DbdqNQA?=
 =?us-ascii?Q?3XDGkBq+gFkaW9kSnqd7xpij2wG1XZygCsSPOnXPtbX+R7FVeX3RC1ysgwWD?=
 =?us-ascii?Q?CwufsJt09HDGZWaHTloZcwtMFBicFcrn38KVB3EIgKCQ/sRWNOGU4WiWQaNj?=
 =?us-ascii?Q?6hQSEV6GfXIBSK589s49v5H0nCx01KT7u8rmv1dmksRjQVGCdLvGZNGcnbfC?=
 =?us-ascii?Q?veSYKuNwUCYuk3vcXOc+OvT631Yezb1WRaMUkKUIAUOhhK8BkaAq8QQcFjV1?=
 =?us-ascii?Q?dq+XyhvUGqUdRhNDgKj1TrIRt2FmUNeuDm5nro3No1ve0DXK6BgvEYm7VPsi?=
 =?us-ascii?Q?VQCi+Q/CdPWnzLC2vxTyL2LBGl2YQfx45xiBcMCRCks=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c169e7-d599-4a1e-13b8-08d8a16a65ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 02:29:22.0602 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3tV0SguhyNLU3/iRWtJyVLqfWCEadqn8vJnRHlHhwcK4sqvOOtYID9asQF9cp36Jiq3UWEe1rlJlSauytVkmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1378
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Thanks Alex! 
Sorry for any inconvenience..

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>

> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Wednesday, December 16, 2020 1:10 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lin, Wayne
> <Wayne.Lin@amd.com>; Stephen Rothwell <sfr@canb.auug.org.au>
> Subject: [PATCH] drm/amdgpu/disply: fix documentation warnings in display
> manager
> 
> Add documentation for crc window.
> 
> Fixes: c920888c604d ("drm/amd/display: Expose new CRC window property")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Wayne Lin <Wayne.Lin@amd.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 21
> ++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 0b31779a0485..2ee6edb3df93 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -337,10 +337,29 @@ struct amdgpu_display_manager {
>  	const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;
> 
>  #ifdef CONFIG_DEBUG_FS
> -	/* set the crc calculation window*/
> +	/**
> +	 * @crc_win_x_start_property:
> +	 *
> +	 * X start of the crc calculation window
> +	 */
>  	struct drm_property *crc_win_x_start_property;
> +	/**
> +	 * @crc_win_y_start_property:
> +	 *
> +	 * Y start of the crc calculation window
> +	 */
>  	struct drm_property *crc_win_y_start_property;
> +	/**
> +	 * @crc_win_x_end_property:
> +	 *
> +	 * X end of the crc calculation window
> +	 */
>  	struct drm_property *crc_win_x_end_property;
> +	/**
> +	 * @crc_win_y_end_property:
> +	 *
> +	 * Y end of the crc calculation window
> +	 */
>  	struct drm_property *crc_win_y_end_property;  #endif
>  	/**
> --
> 2.25.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
