Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8A6C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 03:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE66B10F217;
	Mon, 18 Mar 2024 03:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0OROPpsW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B5C510F217
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 03:36:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aD1QZuJRYlC2bG1MWznqDxf7Zido6U4ght4flojI3bi0o5+gB1h6RSXx3HM5VN3Xk4pVlR2aIBXK681RJbbzvJ3Yg6P6SsVtqxMwLaWF3PvoNfe2Lh9j2XEITErYoUYuhzI8bdlBsCtWEXU5rRJOQ9QqY1vSRIzse0Ge/0ERABuaqW9zAgiXnhQESFDhD3EUFoiWEdoTZxUjPB1uMkqjuSwF3rRDi7zyF9KdmUiBSJSWxln2/zwWcs8E2rIWW1ZIlo8+QW5RmqWOQS0dvg5BrxcfnOQcMkc0XkNVEKwh3R9cxWbyNpTyym8EoUUpS98X9pBcpFQIScZsXUuZJSyorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIYleiqpvO3S04WQv4atajT9bPvDtb+GdrzNGA1TE0o=;
 b=YAtQkkJrPgcUGxmOuF2TIpejrPyoBdIMHpAYDJ/1blsm2xZZsDTrWDYGzEy7T403vdXLcvpoABxYFAypyelnIUjntRymtZC4dxpnjIc3dNJ/37g/MI1f0l0xcXryXVHSUXDnyAs8CVkul+7EqFLxHYbsWqSRu7gU/x24EMySN/1Plyuy3K6exqmQiUf6IfYSPAVJnIHugjmqfZzntLCHTT3h881ZtCKRxMGOdq9yJkkCrpsro38tEhzKpPgKLQWEQ37sOdoV4nrhUpGgG8IPnszNPe3jJZuez/5PSUKAoN0m6LWf1YaagGAbF3rFbWymKmr1Y33WXRujuQgFpQHitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIYleiqpvO3S04WQv4atajT9bPvDtb+GdrzNGA1TE0o=;
 b=0OROPpsW+vgCaj2rUOwj+A+POgtRV541ytGVBoxxjmihtGS8QuUNNoW3TjinCEMDLFw+qcZfdpMJVFqPamiMsdGndgt0HhcACufg7Q2c/8RvcMRpLrjtM2TMTlw6P2I0WrkvK7429LvPm2Rh1JRo08U1MQmnLuJUwvF4QVXnQVE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 03:36:46 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 03:36:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: make reset method configurable for RAS
 poison
Thread-Topic: [PATCH 3/3] drm/amdgpu: make reset method configurable for RAS
 poison
Thread-Index: AQHadSaXp/4veLcT0k2cozHPpudhHbE7uxIggAEeWwCAAAbdAA==
Date: Mon, 18 Mar 2024 03:36:45 +0000
Message-ID: <BN9PR12MB525708FCFA1DC7443925C467FC2D2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240313091155.347161-1-tao.zhou1@amd.com>
 <20240313091155.347161-3-tao.zhou1@amd.com>
 <BN9PR12MB5257021E902FF9AA80E66667FC2E2@BN9PR12MB5257.namprd12.prod.outlook.com>
 <PH7PR12MB879614DB1AEEB2B6491D64ACB02D2@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB879614DB1AEEB2B6491D64ACB02D2@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9d723123-62f6-4aca-88e6-d355f27537b0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-17T10:05:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS7PR12MB6190:EE_
x-ms-office365-filtering-correlation-id: 578675c6-e89e-455a-0150-08dc46fca2ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bb8Mh3pe1OUNcaJfk52AaRz51X9kxudv7uZlxXp+kleNKdZYVa2MV9PQDQRTOdXELIniNfGfeqWXrteViv3WeTFQy9BspsRKHSzG/plvRA34l4VnHlDXbvDfnxOcg8GrlMZnlNL3slsnSVXyi0ygi13r2rFpDAEa6A4Pr3HS0I3tsm2fdP8BcbJnLvb0i3oJzfPnsZ324kBxQlH5C0HKq8Cg59qadt8Q5IpAML7WFHfj+VDMfumXozXuazjofxVr0gUMpjzN+Wf4QJT/o1GidcAikvyS2SBe+Z8jcSxx1U6k/ddvVH71mgLoTgfJAvCm3uKcAKIQMj1NovTUr2zYoJ+O6mmMY5ekJeKboUkVAASm2lYkZo0EFgGZysnFmnuFprDnFSuLsMIs8rH/BELkSzght8x2yqTAsviiwgnZgos3RbyUZPaZr4e+xnu1sEfugOhMKxR8bMi6xH1410s0hsjrt7ATu4YF2DJv4J5mFz9m9ERc45Jqyp+jyA6QRuG37mZa7d1xihDYyWK+ec7Go2L4iqbcay0dVZ+1XbcN6b7403ym81KAeLsZ8colOfyAinDuZsPVNUQuCR2Foa2X9dcPkWhLXhf7akTxCCWGlvj2hCA19SgsNeruyHr9xgXa4APXOz8VQcdZCHaHGAS5u0SYaejFj89BCJhS1PoYviNIDCaIJ99fUXY26PSteK+bfr7yU0MFFBI6/XGHZyjPpwCcy5152z7DQVrUmhLk9Rs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?777QNsYVwhDQM3/4c50GX1wY9/npyRd3ZsM/bkNjGbzn7sqsZEgmRniyKfZY?=
 =?us-ascii?Q?8lh4e32DpPhAc9KxcFoHKzdrdDe4MJVaIpICFa5bH/x5ijPsz1CiPLCp2Rfy?=
 =?us-ascii?Q?9SMD44nqHsyFkEmm8oYAd32uYrtRArZH4X33cR+hmg+84pz72EQFQg8+Lw/O?=
 =?us-ascii?Q?H3ul00+gsPGez+tnxzjw25lYfxZ5LB0TcqT1PhOFpHoYw23mPF2684853WB4?=
 =?us-ascii?Q?cUPKUC5rJRO6Iv/f4WU3jIMQK3hSaYhdZEW1ueZXK6GDLl3nAPwY33m7mQhf?=
 =?us-ascii?Q?/6f3yx9bXxcoe+SQaYE8Sn14HFSIltxpncjrq+WzG4Svma0K1MK8bYJLfbu8?=
 =?us-ascii?Q?nQkXkOEFj5hiL7aX5L1AKnIJYt1DlPCVGE0JkmPAHr5qgxpM1NNIYgzSmtPp?=
 =?us-ascii?Q?uIbz2WDW8lgFhL+ejwoWNrvHjm4BZrpmUshgwtFDq72zeczHvsTdBYnE4m5d?=
 =?us-ascii?Q?45OohzKVNqcZkHcFvj1rcrZivI+0nntVKMe7bwpGzPRStTYo1OGbJEg8tOVP?=
 =?us-ascii?Q?LqAGCaWMB/S3tHzLcu6MhH/hYQ2aVlye4COui3fkWPZBuP/1zjD0XTbihIxF?=
 =?us-ascii?Q?rqD0zWtmoksXOO/HInvr512lPk9BgfTwvPq3n1nHRO5TArUCrzG5NXmco2FU?=
 =?us-ascii?Q?0eTtNlCss6JoyssFKOslFLBY1i/LV33Ln7SE33IHco0j+YuS59iC2a9zHEaG?=
 =?us-ascii?Q?r9F/5tF8172LTdU5PE7+NRJaZnSPhuzNOtaXTQtB1zdcRvVsliyJR1BOM0RB?=
 =?us-ascii?Q?WI3/SCgNZIUDypbs4mi2JSCwD+m+CGQYeLtAJt4pzTC8mlNSeOUmnDkG+A5A?=
 =?us-ascii?Q?vkAMaB9c+sG9plA4Kml7nTjjZIY2dpGXxx+pwoC/c3LyCSFB7EYm5rl39zGz?=
 =?us-ascii?Q?F0+zJMoU6vioEDziKVDxaRUUj+5W2R/5yZQf3CyTdHS5hnJE5LlUpBewOkA0?=
 =?us-ascii?Q?W8gB0OQL8g/7fiwBZADymOV1itGK9iljgE0HPERLqmJGrTsDUpRDI0obrJSm?=
 =?us-ascii?Q?q2Myh9+M81+7TKRLuBRbC2yPy5tIAcWkyVL3UQFMErbIjQ4kBO+IX+/ZD4nw?=
 =?us-ascii?Q?DNSeDg/m++OZW7/JIv15Xc09lRDKDB0sraMEewg6yXVEG8ljEaBj6taMnHpQ?=
 =?us-ascii?Q?5PG9nBSS/XzTYoODnHX9OV+8Zn0rSxX71tyrF+atmWxU/fqVfHgp7evUgEA5?=
 =?us-ascii?Q?a2Ni9eaNYozG/7mYZ+D91ylX6cD7nmIB8y65No4nlfyldKztWhY0Xht2J7tl?=
 =?us-ascii?Q?Ux5KRt/wX4I6f08AmnYGSvnrteiNB/LoRNEJJkhpd1eiHqGl/DiHGZNT5Wfs?=
 =?us-ascii?Q?vMS2l3nt4tpa6OFDma9hQ8G6jVV7mywyjd2ZgrGViRqRaI6/TKlZ7kVwjMIv?=
 =?us-ascii?Q?KKDLGyNMCJzq3gpqFThW4HiPn5FRqsyB6lTFwqEvZ21BsIpgy3Huvrm5ufhM?=
 =?us-ascii?Q?SqdTfObaymOxwoUh6DAVKOSaH4RTeP6KpVCwY7bgLnTyvqyWuvPoBaIOHPqi?=
 =?us-ascii?Q?DXolB8500ifB1sKSGljGornFoKRHW/Kn4eBKHaCgz1K0Rm47tKNggGUi2i5H?=
 =?us-ascii?Q?BP7jJx+2VpKRkPWXEwo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578675c6-e89e-455a-0150-08dc46fca2ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 03:36:45.8520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLLQndpRoH+BPfDA4rimwGIqAffh2iQbWxi6M7ldqGxYCwLYgkhF7iSLhcutnCXIrJSDtIzNAAaXnPZEPJY9TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

That's fine. It can be in another set of patches. But we should remove the =
incorrect implementation which is copied from previous version. So people w=
ill not apply changes to an incorrect base.

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, March 18, 2024 11:11
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH 3/3] drm/amdgpu: make reset method configurable for RAS=
 poison

[AMD Official Use Only - General]

I can remove the support for SOC15_IH_CLIENTID_VMC from v10, but the reset =
type should be changed from bool to uint32 for all versions.

Regards,
Tao

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Sunday, March 17, 2024 6:10 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: RE: [PATCH 3/3] drm/amdgpu: make reset method configurable
> for RAS poison
>
> [AMD Official Use Only - General]
>
> Let's not copy kfd interrupt handler and the work queue implementation
> from v9 to v10 since the firmware/hardware design are totally different.
>
> We shall have another patch to fix kfd int v10 for poison consumption
> handling and also v11.
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao
> Zhou
> Sent: Wednesday, March 13, 2024 17:12
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: make reset method configurable for
> RAS poison
>
> Each RAS block has different requirement for gpu reset in poison
> consumption handling.
> Add support for mmhub RAS poison consumption handling.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       | 14 ++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  4 ++--
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  | 20 ++++++++++++++-----
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 20 ++++++++++++++-----
>  7 files changed, 42 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 9687650b0fe3..262d20167039 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -760,7 +760,7 @@ bool amdgpu_amdkfd_is_fed(struct amdgpu_device
> *adev)  }
>
>  void amdgpu_amdkfd_ras_poison_consumption_handler(struct
> amdgpu_device *adev,
> -       enum amdgpu_ras_block block, bool reset)
> +       enum amdgpu_ras_block block, uint32_t reset)
>  {
>         amdgpu_umc_poison_handler(adev, block, reset);  } diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 03bf20e0e3da..ad50c7bbc326 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -400,7 +400,7 @@ void amdgpu_amdkfd_debug_mem_fence(struct
> amdgpu_device *adev);  int amdgpu_amdkfd_get_tile_config(struct
> amdgpu_device *adev,
>                                 struct tile_config *config);  void
> amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device
> *adev,
> -                       enum amdgpu_ras_block block, bool reset);
> +                       enum amdgpu_ras_block block, uint32_t reset);
>  bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);  bool
> amdgpu_amdkfd_bo_mapped_to_dev(struct amdgpu_device *adev, struct
> kgd_mem *mem);  void amdgpu_amdkfd_block_mmu_notifications(void *p);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e32a186c2de1..58fe7bebdf1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2045,7 +2045,7 @@ static void
> amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
>                 }
>         }
>
> -       amdgpu_umc_poison_handler(adev, obj->head.block, false);
> +       amdgpu_umc_poison_handler(adev, obj->head.block, 0);
>
>         if (block_obj->hw_ops && block_obj->hw_ops->handle_poison_consump=
tion)
>                 poison_stat =3D
> block_obj->hw_ops->handle_poison_consumption(adev);
> @@ -2698,7 +2698,7 @@ static int
> amdgpu_ras_page_retirement_thread(void
> *param)
>                 atomic_dec(&con->page_retirement_req_cnt);
>
>                 amdgpu_umc_bad_page_polling_timeout(adev,
> -                               false, MAX_UMC_POISON_POLLING_TIME_ASYNC)=
;
> +                               0, MAX_UMC_POISON_POLLING_TIME_ASYNC);
>         }
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index 20436f81856a..2c02585dcbff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -186,9 +186,7 @@ static int amdgpu_umc_do_page_retirement(struct
> amdgpu_device *adev,
>         amdgpu_umc_handle_bad_pages(adev, ras_error_status);
>
>         if (err_data->ue_count && reset) {
> -               /* use mode-2 reset for poison consumption */
> -               if (!entry)
> -                       con->gpu_reset_flags |=3D
> AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +               con->gpu_reset_flags |=3D reset;
>                 amdgpu_ras_reset_gpu(adev);
>         }
>
> @@ -196,7 +194,7 @@ static int amdgpu_umc_do_page_retirement(struct
> amdgpu_device *adev,  }
>
>  int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
> -                       bool reset, uint32_t timeout_ms)
> +                       uint32_t reset, uint32_t timeout_ms)
>  {
>         struct ras_err_data err_data;
>         struct ras_common_if head =3D {
> @@ -238,8 +236,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct
> amdgpu_device *adev,
>         if (reset) {
>                 struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>
> -               /* use mode-2 reset for poison consumption */
> -               con->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE2_RESE=
T;
> +               con->gpu_reset_flags |=3D reset;
>                 amdgpu_ras_reset_gpu(adev);
>         }
>
> @@ -247,7 +244,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct
> amdgpu_device *adev,  }
>
>  int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
> -                       enum amdgpu_ras_block block, bool reset)
> +                       enum amdgpu_ras_block block, uint32_t reset)
>  {
>         int ret =3D AMDGPU_RAS_SUCCESS;
>
> @@ -311,7 +308,8 @@ int amdgpu_umc_process_ras_data_cb(struct
> amdgpu_device *adev,
>                 void *ras_error_status,
>                 struct amdgpu_iv_entry *entry)  {
> -       return amdgpu_umc_do_page_retirement(adev, ras_error_status, entr=
y,
> true);
> +       return amdgpu_umc_do_page_retirement(adev, ras_error_status, entr=
y,
> +                               AMDGPU_RAS_GPU_RESET_MODE1_RESET);
>  }
>
>  int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev) diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> index 26d2ae498daf..4365a20eeb49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
> @@ -103,7 +103,7 @@ struct amdgpu_umc {  int
> amdgpu_umc_ras_sw_init(struct amdgpu_device *adev);  int
> amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct
> ras_common_if *ras_block);  int amdgpu_umc_poison_handler(struct amdgpu_d=
evice *adev,
> -                       enum amdgpu_ras_block block, bool reset);
> +                       enum amdgpu_ras_block block, uint32_t reset);
>  int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
>                 struct amdgpu_irq_src *source,
>                 struct amdgpu_iv_entry *entry); @@ -123,5 +123,5 @@
> int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
>                         umc_func func, void *data);
>
>  int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
> -                       bool reset, uint32_t timeout_ms);
> +                       uint32_t reset, uint32_t timeout_ms);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> index 650da18b0d87..94ab1f33fc4a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
> @@ -134,6 +134,7 @@ static void
> event_interrupt_poison_consumption(struct
> kfd_node *dev,  {
>         enum amdgpu_ras_block block =3D 0;
>         int old_poison, ret =3D -EINVAL;
> +       uint32_t reset =3D 0;
>         struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);
>
>         if (!p)
> @@ -153,6 +154,15 @@ static void
> event_interrupt_poison_consumption(struct
> kfd_node *dev,
>         case SOC15_IH_CLIENTID_UTCL2:
>                 ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
>                 block =3D AMDGPU_RAS_BLOCK__GFX;
> +               if (ret)
> +                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +               break;
> +       case SOC15_IH_CLIENTID_VMC:
> +       case SOC15_IH_CLIENTID_VMC1:
> +               ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
> +               block =3D AMDGPU_RAS_BLOCK__MMHUB;
> +               if (ret)
> +                       reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
>                 break;
>         case SOC15_IH_CLIENTID_SDMA0:
>         case SOC15_IH_CLIENTID_SDMA1:
> @@ -160,6 +170,7 @@ static void
> event_interrupt_poison_consumption(struct
> kfd_node *dev,
>         case SOC15_IH_CLIENTID_SDMA3:
>         case SOC15_IH_CLIENTID_SDMA4:
>                 block =3D AMDGPU_RAS_BLOCK__SDMA;
> +               reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
>                 break;
>         default:
>                 break;
> @@ -170,17 +181,16 @@ static void
> event_interrupt_poison_consumption(struct
> kfd_node *dev,
>         /* resetting queue passes, do page retirement without gpu reset
>          * resetting queue fails, fallback to gpu reset solution
>          */
> -       if (!ret) {
> +       if (!ret)
>                 dev_warn(dev->adev->dev,
>                         "RAS poison consumption, unmap queue flow
> succeeded: client id %d\n",
>                         client_id);
> -               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, b=
lock,
> false);
> -       } else {
> +       else
>                 dev_warn(dev->adev->dev,
>                         "RAS poison consumption, fall back to gpu
> reset flow: client id %d\n",
>                         client_id);
> -               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, b=
lock,
> true);
> -       }
> +
> +       amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block,
> + reset);
>  }
>
>  static bool event_interrupt_isr_v10(struct kfd_node *dev, diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 11641f4645e6..2a37ab7a7150 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -145,6 +145,7 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,  {
>         enum amdgpu_ras_block block =3D 0;
>         int old_poison, ret =3D -EINVAL;
> +       uint32_t reset =3D 0;
>         struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);
>
>         if (!p)
> @@ -164,6 +165,15 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>         case SOC15_IH_CLIENTID_UTCL2:
>                 ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
>                 block =3D AMDGPU_RAS_BLOCK__GFX;
> +               if (ret)
> +                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +               break;
> +       case SOC15_IH_CLIENTID_VMC:
> +       case SOC15_IH_CLIENTID_VMC1:
> +               ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
> +               block =3D AMDGPU_RAS_BLOCK__MMHUB;
> +               if (ret)
> +                       reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
>                 break;
>         case SOC15_IH_CLIENTID_SDMA0:
>         case SOC15_IH_CLIENTID_SDMA1:
> @@ -171,6 +181,7 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>         case SOC15_IH_CLIENTID_SDMA3:
>         case SOC15_IH_CLIENTID_SDMA4:
>                 block =3D AMDGPU_RAS_BLOCK__SDMA;
> +               reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
>                 break;
>         default:
>                 break;
> @@ -181,17 +192,16 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>         /* resetting queue passes, do page retirement without gpu reset
>          * resetting queue fails, fallback to gpu reset solution
>          */
> -       if (!ret) {
> +       if (!ret)
>                 dev_warn(dev->adev->dev,
>                         "RAS poison consumption, unmap queue flow
> succeeded: client id %d\n",
>                         client_id);
> -               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, b=
lock,
> false);
> -       } else {
> +       else
>                 dev_warn(dev->adev->dev,
>                         "RAS poison consumption, fall back to gpu
> reset flow: client id %d\n",
>                         client_id);
> -               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, b=
lock,
> true);
> -       }
> +
> +       amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block,
> + reset);
>  }
>
>  static bool context_id_expected(struct kfd_dev *dev)
> --
> 2.34.1
>


