Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E23DC77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 03:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F283310E5AF;
	Fri, 19 May 2023 03:33:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79FF910E5AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 03:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFWl3LUDFBbkMQfAZqBVTDYOPbUivU+vRkqkiGPoRIKvSPI2+j1F/oRrtHsuBQI9tXOpSJEw1GE59vgItmOc4tKZFDvWyK37hqj5sXKAyY6yxyBE73MyyirfR2lEI38kqEE0Yvmf7ioEO1ceE/qqkylWFwIm51zPLjqGqG/em6uyamBJEXYhQmbw4ikjwdmgPBkDqDis7DvguF8/naoyYC9YkXJt70j87sDMDFv7tEF1hpyWT0DTL4XDhPQ38vPMWK/2CBpm4zVA2+2qnGc/+YGImaY2r6ob6Vldghje0cxCD73/n0x1et4LsFM1tAX2MQXllYXJy715UnGA73SZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4hOf6PfbXMSMRPfoYtlE5Bifb0VdjDnvGE99mi2ECk=;
 b=eJdbth7LDgmVRWxRnpjLXJVndccXhRcJwWkdD0hB1KgIu3jR45U7Gs+QCz10oRdf+8uaGmhFx948E+cfvTIIcRuJ0i7EkOMrtdTPKyS6t78v7xSMVc4v1B41STZa67pDvhOsdP1xurjsiklFjDlYjsb7cdUMzPF4yzCStshQ2hjUj0coxMDk+FDUEyX17ns6oZ926xFBcdMUZYbWsiOTL83y/0wDhURHDKQceG/kP0so4Xyyz7uS8Y7RhZyshm2Zb+LsfhdYqO3fECMSaxIqT8oxlfp1jZY4u+XtQ4IaZJKZzVPFIjJy/q19SLbnjoGTOKrURxi1oJf6BgPIl9WPeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4hOf6PfbXMSMRPfoYtlE5Bifb0VdjDnvGE99mi2ECk=;
 b=k6I0WVTNqpOBDdByIYDIRfpRtfj7Coyw+n1SArHj3/CU0QLVjet12SaT25kD/kiQc/Iw3h1eFkXW9g+yytZUfOTQDKAk0hmyPa+9oYM20tY9WvYb9whk5B41i8bqmJKeJsZqrdoqqRjVT5vOAriuEp7/uY+S1v6IxCiphf6mw6g=
Received: from BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29)
 by BL1PR12MB5077.namprd12.prod.outlook.com (2603:10b6:208:310::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 03:33:32 +0000
Received: from BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::f0f1:aa1b:74a3:a178]) by BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::f0f1:aa1b:74a3:a178%7]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 03:33:31 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4] drm/amd: Flush any delayed gfxoff on suspend entry
Thread-Topic: [PATCH v4] drm/amd: Flush any delayed gfxoff on suspend entry
Thread-Index: AQHZialDkkHS/jj/cUKPQIy7CX6sF69g8Stw
Date: Fri, 19 May 2023 03:33:30 +0000
Message-ID: <BYAPR12MB26154082582165C41391BF9AE47C9@BYAPR12MB2615.namprd12.prod.outlook.com>
References: <20230518165251.93229-1-mario.limonciello@amd.com>
In-Reply-To: <20230518165251.93229-1-mario.limonciello@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=77cc6048-1aea-4f6a-9121-fbd8a93493fd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-19T03:30:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB2615:EE_|BL1PR12MB5077:EE_
x-ms-office365-filtering-correlation-id: 99be21b6-dba2-4ae2-9c83-08db5819d164
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fve5cQ+lD2FDQEnlpHuj9A/JT3kmEaz1dEVz7Htqa2I2kK5PUagaW9oswdFjY+pRh4XA1BxzCkd1Wd+we6I5j4BZD0yAAHmbEE6dbq7ihNlIeHO9QTqwCuGOhEd21uPW7tdEqeqLgM1G60RovZd53ewqmNX3KIUddBjXU6kOTBdPx5kJQPrmtTffl+c4J/87UMhz6D3n9pp7uzR+B9ftxTkTIsNtE+/Q2UPeOj2E1d2oFYQlMSWMaDWMBVIGYSYhqtYdXHSwQ0yjIQAyuvUBa1RC+rINqQjziG8OE64rMsZKPqxKdUgQSSPiNJXBWnJ0NOEllSPZm1RGMk3F3xUgHV/xjB7JcZS1YQet/jRaUWPN5MQ1QiTsDuQElR9PKK2442VLUiFEG+fQFPoDq8YrSYQuFto2jIy/poMfr2XEZg8kF1XeKTv/UJHkZZZ8DAc7cpLKhcbrzkcBHuYoJXxPzRFPYM7yB8pjAAZojAroLVSAM0UrqIIxQrk3jTAG05eYDca60sJ+pU9bnN5TJ+fX+/FHL7BsGN15o2xtLllsrN3u/lfvW8wKtTUbreIg1K5jGRo/Js4Pv6+JdkuvWUkg8EbeVRh32TPlBtEIQjyjYPX/Sf84K9KYX8OFqMxC/Diy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199021)(71200400001)(7696005)(41300700001)(38100700002)(26005)(53546011)(6506007)(9686003)(52536014)(5660300002)(83380400001)(38070700005)(186003)(2906002)(15650500001)(33656002)(86362001)(122000001)(8936002)(8676002)(55016003)(478600001)(76116006)(64756008)(66476007)(66556008)(66946007)(66446008)(4326008)(54906003)(110136005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BzBFVxbwcQRU9p09ZcowkJpbdOhu8W6tHmUp9VAeMxCnj7H38DIPPJRlU/60?=
 =?us-ascii?Q?krqSERSUtFvnoPYlG3LobDYRZEHLI1IkYcimYUsBq5S9odCXmVIaTABhy8Fk?=
 =?us-ascii?Q?voAXMf8lPUTAm1tUEbIDOltqfOGfSynME0a4WrafUaNMWSYbjhGzC66c9d50?=
 =?us-ascii?Q?CmLKT9WZOEqwhkEYPt12YCXLzKdTgJJ2ZaKSaPi6IoUX+7Bdi36Z0T+fZ6zK?=
 =?us-ascii?Q?iR0XjH5SsZEYMWys5vCOLlGlHsdwnri6XgzCcNvytnka3Ix3blO9lhB7EW+8?=
 =?us-ascii?Q?To/sj+ter+RYmbTXucxNhkTl1gvaifr1vT+dCPYFnXBLGHHtgsbmF+gNdjkO?=
 =?us-ascii?Q?TugCuaohGh96afXZUB7voLr1STx1x/CBR0liYvwX+0OrocNfwO4MYLh95WWM?=
 =?us-ascii?Q?hARYD4e9HuP16tJkdJ9XkxqaR1QTnSqnI+xS35U6L1trIY6i+6YPL/NDv5zO?=
 =?us-ascii?Q?V3mey5vkMpjXL/v3noGtSVVR7msejlQwJTeEgF0a6kdvs6xD5onajeMtSdim?=
 =?us-ascii?Q?T5+oGhgNv6CrLc0QHLLsiQfo25XEwrkP/yI/RlckYBnyD30wJBE8e43eKQFK?=
 =?us-ascii?Q?4B6gxBEc6vUV/O4jqfrczxYXlrWO2+xaG8e6RaIVgqTvbEqv7ZFxgQxEZWp+?=
 =?us-ascii?Q?z5UyOjCldvC5IJapiUK1P49D0ayJciIoE+USpChtxvJTMPCkMCP1ayaErI5K?=
 =?us-ascii?Q?FxUwekbcf82Uysq7IxMdiAuKGlhHME+/iMtr09B0GtlD2f0JVi4Y3Ola0cXc?=
 =?us-ascii?Q?hovLVud01WR8snyUZMC45/2JWO23R1AXjjDUjSt5s0gDV6THIHImt/86NBGT?=
 =?us-ascii?Q?fQkAaWgDI4GKyMRFafFVUkvxHFu4E89mxGZwL7Jh8uOlu+PPiKgElHSF1m0m?=
 =?us-ascii?Q?jGin8q15+ABIdcKX1a7cNIiQaqfsu3/ZIbEt0RXs70vHp3O/a102EaT/GXvm?=
 =?us-ascii?Q?RIGWqGBbwVMWwjXL5aqTij4s5XCRMNnL2PYzLrvvyYieKAdfj20YMiECZeVZ?=
 =?us-ascii?Q?/oeKWWLMHaWh1uSuQDMhkB4SzKVYVGAfp6hu2CRej6mDpjsnDfsSXaRU0Cvs?=
 =?us-ascii?Q?kZgkIkjGBUqP/BA3s/FkoAv5mVV/OH2zuMEkA6k3dzSjNpL+Fov07oKeVJuE?=
 =?us-ascii?Q?5rtQ3TEQcCT9es6X4scg57SffUUk7KJQSt3ItGQndteNTYy5CBvuoBF1+vcO?=
 =?us-ascii?Q?znG92HfbPMj0KRq4zq/gQrB8RGmvYKcGoMAVJfHmXJ7f/ela3J9w9h6ldypt?=
 =?us-ascii?Q?+yfgrmEj5uSIPUARQYRvGdga8Fh/JJzpxBc82nsSbyIhGXMPfdydvbB6PvlW?=
 =?us-ascii?Q?+k2z5cvd9VreOzpn05aYe59g6vrSao1iLj10O9HyJMPqBelWsqk/+Ayd65hl?=
 =?us-ascii?Q?GSlesw56XVeYA3O89UBAnr3kMmvFQ6HXI/XD3OL13Gzg1O7pwD2MjUSPaJyw?=
 =?us-ascii?Q?GUe0Y/zE2/ug1jgQXGJOOrBwC3F0WOOW6Z7iQxzrlUxoSUNZn6mhmgPUDCXf?=
 =?us-ascii?Q?k6oaKSk0iOnahNOwFxjFyCzHj7IcP527SJrJHU+QOrRzHydvlrX2jJIo/ZdX?=
 =?us-ascii?Q?UOKxL3V5NO9lmMNaV8Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99be21b6-dba2-4ae2-9c83-08db5819d164
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 03:33:31.3099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yLMmh9RN4qesfjKU5e01UkI9eVBREeGU1EJg7FGjfqg+m1/IU78JNxVrxEnp90+7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5077
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
Cc: "Tsao, Anson" <anson.tsao@amd.com>, "Martinez,
 Juan" <Juan.Martinez@amd.com>, "Gong, Richard" <Richard.Gong@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

If I understand correctly, similar job is already performed in "amdgpu_devi=
ce_set_pg_state(adev, AMD_PG_STATE_UNGATE);"
Maybe you just need to undo the "skip PG for GFX on S0ix"?

                /* skip PG for GFX, SDMA on S0ix */
                if (adev->in_s0ix &&
                    (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_T=
YPE_GFX ||
                     adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_T=
YPE_SDMA))
                        continue;

Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello
> Sent: Friday, May 19, 2023 12:53 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Tsao, Anson <anson.tsao@amd.com>; Huang, Tim
> <Tim.Huang@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>; Gong, Richard
> <Richard.Gong@amd.com>
> Subject: [PATCH v4] drm/amd: Flush any delayed gfxoff on suspend entry
>
> DCN 3.1.4 is reported to hang on s2idle entry if graphics activity
> is happening during entry.  This is because GFXOFF was scheduled as
> delayed but RLC gets disabled in s2idle entry sequence which will
> hang GFX IP if not already in GFXOFF.
>
> To help this problem, flush any delayed work for GFXOFF early in
> s2idle entry sequence to ensure that it's off when RLC is changed.
>
> commit 3964b0c2e843 ("drm/amdgpu: complete gfxoff allow signal during
> suspend without delay") modified power gating flow so that if called
> in s0ix that it ensured that GFXOFF wasn't put in work queue but
> instead processed immediately.
>
> This is dead code due to commit 5d70a549d00d ("drm/amdgpu: skip
> CG/PG for gfx during S0ix") because GFXOFF will now not be explicitly
> called as part of the suspend entry code.  Remove that dead code.
>
> Cc: stable@vger.kernel.org # 6.1+
> Suggested-by: Tim Huang <tim.huang@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3->v4:
>  * Drop patches 2-4
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 9 +--------
>  2 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a9d9bbe8586b..059139f1f973 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4316,6 +4316,7 @@ int amdgpu_device_suspend(struct drm_device
> *dev, bool fbcon)
>               drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)-
> >fb_helper, true);
>
>       cancel_delayed_work_sync(&adev->delayed_init_work);
> +     flush_delayed_work(&adev->gfx.gfx_off_delay_work);
>
>       amdgpu_ras_suspend(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index f2d0b1d55d77..b1190eb0e9c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -692,15 +692,8 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device
> *adev, bool enable)
>
>               if (adev->gfx.gfx_off_req_count =3D=3D 0 &&
>                   !adev->gfx.gfx_off_state) {
> -                     /* If going to s2idle, no need to wait */
> -                     if (adev->in_s0ix) {
> -                             if
> (!amdgpu_dpm_set_powergating_by_smu(adev,
> -                                             AMD_IP_BLOCK_TYPE_GFX,
> true))
> -                                     adev->gfx.gfx_off_state =3D true;
> -                     } else {
> -                             schedule_delayed_work(&adev-
> >gfx.gfx_off_delay_work,
> +                     schedule_delayed_work(&adev-
> >gfx.gfx_off_delay_work,
>                                             delay);
> -                     }
>               }
>       } else {
>               if (adev->gfx.gfx_off_req_count =3D=3D 0) {
> --
> 2.34.1

