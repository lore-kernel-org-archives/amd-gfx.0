Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27919EB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jun 2023 10:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FCB410E1E0;
	Mon, 19 Jun 2023 10:41:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF25510E1F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 10:41:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScW7aMo9NXDMOJEOwIWdGE9+9RBDk5EeKxsbmuTxyO2wjUI+eu61a2q2h5VwGECgtPQhmBVHHpqePkEqtE4g0101uRlp9QsXpn6WxOE0kgdfF+oNiRLQwhEne0dpf+ZxnKAAqb5l4P26lK9Bzq+SLUndEouh55MWeTNH45k36ik++6u+EELdef9wJckiznlyUSBxen0jtPyP29ta0IddSCYBdoEHsV58HyQGYJ1PmOvqr7T07weKXamOQZJtFTiuJAws2Wk09RPEc89BczdYnLn7zO9rlV8+QRjEFG77gXrkNvam8hd9pBjE02voUUSQr4xGvlEd+bPifrrL2/ChxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BEcBt2dHY52n0yISdbNNh0WTBeH6ds21RUsZAhmtyI=;
 b=l4JZHetMnFHV+y0fXLK4v/xVv5RfAr4l1OSD15ef7KI7UqcSShJRIGJsH0KIKZ+g6EgLMIho9SkQPJ3pfQ1S+R8nu4Iw12ImDadnzOGYfA84cLrX/3SUkT2Ni/o/ECmnnfH8AVpYhtdX50o8ufuw4J7P3QnTANrBhrj+RfxIz23gtcHvmCdUdqi73ZOoMhMYcsXRnADd1xEnw5TzjbHzzg5EgzOe+65MD7cZZDmSTr00eyDAxzHIfssXpWbVz04ox7Fwb2ZHS+7/M65KT2pibs53mu7KBk9oCgE9hyFgI1OD6WPbyUcJ5JBcj8ViidTFgTNBY8E1i+gjNntgIxm5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BEcBt2dHY52n0yISdbNNh0WTBeH6ds21RUsZAhmtyI=;
 b=esrbfsWtl+MvNa+Y4jq0ga42jeMRCGKHTyBH9bzKBPNXc8hVkdyDpfKZRLRg4saayxsIc68RnGRNXv5ctLC1ZbgoHKJbhWOp2azon+8Q8uSaIz4f656SL2n/xxSxx3CQujkR7urWLM9SFub+QWnzinQLc5DloeowqBVsHH2cxLo=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 10:41:10 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::cc12:13d6:4667:64e]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::cc12:13d6:4667:64e%6]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 10:41:09 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Remove redundant poison
 consumption handler function
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Remove redundant poison
 consumption handler function
Thread-Index: AQHZoodbjiTJjcNq/UOtBNHIPjzWb6+R7+kQ
Date: Mon, 19 Jun 2023 10:41:09 +0000
Message-ID: <BL1PR12MB5334632B3E6549A65024F4989A5FA@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230619082336.171658-1-Stanley.Yang@amd.com>
In-Reply-To: <20230619082336.171658-1-Stanley.Yang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e1cd8453-4eb6-4f54-8bbe-4f64b3ab6967;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-19T10:40:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|CY5PR12MB6203:EE_
x-ms-office365-filtering-correlation-id: b272cb53-3566-4c77-46c6-08db70b1b190
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AblsLs08toybORAA7pHCWWUYcADrATCG3LpEpIPCT3FJLhqEZ21NJFxyVCB9C7VfRbYPuTCqCknImBv/kAMDNQZVaHZ+mjh2fGbCK+s6PLeNXAJEgLiK89TenhULsbLem4FEf//DJ/tq8jXhW4CDWL+tcFYkffkAaj6RZuhXjPtfPDEIWNa0Ut70uYF4gdgk2HfKyRKMTAPmWoKJJ/RHB3NsuqHYavBdSb113sEX+SrtLAu2ankQy3jKFEgnaGPsytgRVVEa8wRjRl9jT46tpf2vmz2bDwXJPKDMftyssjvL/ctiGV6N9Ndl3zET89aVrWcPJ1l0+hb3MqhaVLYoFi8Eck/hXyPCvIokqegDC9H5dWQ2AH5O4uiRQMaZGQ7Gu6VshOKFlXEYUCF8Mtl2KxQm+2LCRw+bcS6IQbFZN1E9oNke4m19UB+Ku4pgXbSC5lt23XaqPqcK07W0tgbEIsZwUlDImmOB8VQY1mz5xdyDk0QthnjD7/6YRv4YMfd2zVaaBhLbPB36Rs+csZFMT0hsGTbWdMUbDAAoHtilJMRWTfiWmsixq78GwbIUaYxtX0JrELVDZmbCVO6zjRUS7RmzBKj/lteFrd5MUSMusQk1F9HWv2pUpiZr9Wboy7xc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(122000001)(38100700002)(86362001)(55016003)(110136005)(8676002)(9686003)(41300700001)(186003)(52536014)(66946007)(76116006)(66476007)(66556008)(64756008)(66446008)(83380400001)(316002)(38070700005)(5660300002)(6636002)(7696005)(71200400001)(53546011)(6506007)(2906002)(33656002)(8936002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QURJCSeFIAGYH3ttyMoOpOYWGEnamy0RDQHKVgAWf9A3I5LtTlrzY/o8UFKz?=
 =?us-ascii?Q?RYQb/jScEMwZ71X/h2n59s/px6NHFNdmLKZxSewkmPCrdweQWo0pCMu1fQgD?=
 =?us-ascii?Q?ZOWff39dATRbDaH32Rk58b+UOI0vFWLI074icYCwMnQWvDc3PC0c04zwRj5x?=
 =?us-ascii?Q?H/JpH2sSrMHZaKKjN6HBhotIs0ivFDYgfmjH6MjzZhBbzlSSiG+QXF7tm6KH?=
 =?us-ascii?Q?N8xnMr0aDOTCFHtB47yaQF6+yN6Sg9tZl82wEtlmm6rJ29nJgcOhqFUqia+L?=
 =?us-ascii?Q?kC/IEojA+hPYR5sEfVkkjwf7s6eHYU2oKpkg0n4kKtJDNuKMHArFJmwQ+zw7?=
 =?us-ascii?Q?jIRaHbguDAF1VYyREk3wcdCTEBZsTc6IVEwlk+3NjzFfqwcWfQQJr5v06GQY?=
 =?us-ascii?Q?yidNsRuVoJhACRDaclBDnuE3xV9+65H4R9d3MMW2Gp4kVtoSskf7KEKiG7jq?=
 =?us-ascii?Q?K98+Y5JwXj4N0N0DcPsuEb9idGelo2KeBLl6MtF8LyWt7UkX/4VpxO2bGggr?=
 =?us-ascii?Q?W4d7iDrvjjsIs+F0kIOe1uZildJ/K5JK+VKEFolVEkyqTe3yyZS7JQ2sct1o?=
 =?us-ascii?Q?nGY+UxFByI0yNbDIwYt6M6DueOzafC1o3QXTdmIZsPjTBR5gd/X7pHTeQ+kM?=
 =?us-ascii?Q?IHajyzmDfFuxOooEE0E5GWKgDjIMIJnB6M2Q5m4U43gROB2WO9HOCvy25eUg?=
 =?us-ascii?Q?5aJeT3q7KR0Iocjfj6pb+dN9vpx8J0cKugeHGEw4495agncVnDTBCUzYcv4n?=
 =?us-ascii?Q?6dJvXSh14jA+gNX8viY2HIbrhTVXNBZaBQ5Q9kzejoOSy7u7QoDoe3cy9OQP?=
 =?us-ascii?Q?gpGgFDp2vklOw+mWbJdPtMwlvLiyG2CCrjiz/ZY+yi9ijXgvrxD7rGCvVaKr?=
 =?us-ascii?Q?XZNgbVlQ/aiklxMpBkw4Wchqf6j93LYpM5ziQHFUCNzqGiVG46QzElXETpYV?=
 =?us-ascii?Q?2lyLUlWD+KCtIeNYOIMYY/yLcbgge2afBlwWC5F2IxCYk9gaMUB7L/tXGbXd?=
 =?us-ascii?Q?mAJvtY1WzzILLdn1ZTAt3rSKk6rRsdw+Bhu5kPnlBsI4y3KrKqmjIcufg4CR?=
 =?us-ascii?Q?vopAQGFwN3JNnW48Jp4fAHfwXxVB3jtsMGFql+mAU21xzGdN58i1ZHPW7mLm?=
 =?us-ascii?Q?5CRqlyTeMPiBBnoI4dRJUUEeJHlHXbujLNGftGmLq2rRkeH604963dMfFPbE?=
 =?us-ascii?Q?Juzzxhzl+EXReZ714T/S/RXHB+8llps44MsxVlbquVpqwHXYe6/gxg2MSkWK?=
 =?us-ascii?Q?7tljLlCW2P1/Hu975NOIRhe4zzVULDZBpgmj5jzdutt/5DBAOeH86buvEe4d?=
 =?us-ascii?Q?8Tk9yJvBHRaAm+edgiRGC7K45CnjEMB4vr3x18s1KDq5sU2v692bpJJALsUQ?=
 =?us-ascii?Q?iHhjVHaqSP6cwgolzEjiiOUPsX9EPzAdVJfgicNIB2176EqGiZo0nrt0OHNU?=
 =?us-ascii?Q?A1VXvKrvxYYoUf7BgoF4qRSo2rGxs3D9OHCte4lfWc9qnzN1sFcQ47pzyCZo?=
 =?us-ascii?Q?O/pRM4ZaYSvH0re15wTxa6AOy1SXSqczEa+n0tnyi8t/dJ95DD+7VIguDg?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b272cb53-3566-4c77-46c6-08db70b1b190
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 10:41:09.3201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yY9JPV/z6TKoE0VgDygCyujN2V5OPTz9kKHCtEdRfwT4LhJv12fg/TViorEmFV4LEYWXw4xVWfq63vUr3sCH6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
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

Please ignore this patch, I will send V2.

Regards,
Stanley
> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Monday, June 19, 2023 4:24 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: Remove redundant poison
> consumption handler function
>
> The function callback handle_poison_consumption and callback function
> poison_consumption_handler are almost same to handle poison
> consumption, remove poison_consumption_handler.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  9 ---------
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  4 ----
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  6 ++----
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  |  3 ++-
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c | 12 +++++++++---
>  5 files changed, 13 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index a33d4bc34cee..c15dbdb2e0f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -840,15 +840,6 @@ int amdgpu_gfx_ras_sw_init(struct amdgpu_device
> *adev)
>       return 0;
>  }
>
> -int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
> -                                             struct amdgpu_iv_entry
> *entry)
> -{
> -     if (adev->gfx.ras && adev->gfx.ras->poison_consumption_handler)
> -             return adev->gfx.ras->poison_consumption_handler(adev,
> entry);
> -
> -     return 0;
> -}
> -
>  int amdgpu_gfx_process_ras_data_cb(struct amdgpu_device *adev,
>               void *err_data,
>               struct amdgpu_iv_entry *entry)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index d0c3f2955821..95b80bc8cdb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -273,8 +273,6 @@ struct amdgpu_gfx_ras {
>       int (*rlc_gc_fed_irq)(struct amdgpu_device *adev,
>                               struct amdgpu_irq_src *source,
>                               struct amdgpu_iv_entry *entry);
> -     int (*poison_consumption_handler)(struct amdgpu_device *adev,
> -                                             struct amdgpu_iv_entry
> *entry);
>  };
>
>  struct amdgpu_gfx_shadow_info {
> @@ -538,8 +536,6 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device
> *adev);  void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev,
> uint32_t ucode_id);
>
>  int amdgpu_gfx_ras_sw_init(struct amdgpu_device *adev); -int
> amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
> -                                             struct amdgpu_iv_entry
> *entry);
>
>  bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);  =
int
> amdgpu_gfx_sysfs_init(struct amdgpu_device *adev); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 5b6525d8dace..7be289473034 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1694,15 +1694,13 @@ static void
> amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
>       amdgpu_umc_poison_handler(adev, false);
>
>       if (block_obj->hw_ops && block_obj->hw_ops-
> >handle_poison_consumption)
> -             poison_stat =3D block_obj->hw_ops-
> >handle_poison_consumption(adev);
> +             poison_stat =3D block_obj->hw_ops-
> >handle_poison_consumption(adev,
> +entry);
>
>       /* gpu reset is fallback for failed and default cases */
> -     if (poison_stat) {
> +     if (poison_stat !=3D true) {
>               dev_info(adev->dev, "GPU reset for %s RAS poison
> consumption is issued!\n",
>                               block_obj->ras_comm.name);
>               amdgpu_ras_reset_gpu(adev);
> -     } else {
> -             amdgpu_gfx_poison_consumption_handler(adev, entry);
>       }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 46bf1889a9d7..03f3b3774b85 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -564,7 +564,8 @@ struct amdgpu_ras_block_hw_ops {
>       void (*reset_ras_error_count)(struct amdgpu_device *adev);
>       void (*reset_ras_error_status)(struct amdgpu_device *adev);
>       bool (*query_poison_status)(struct amdgpu_device *adev);
> -     bool (*handle_poison_consumption)(struct amdgpu_device *adev);
> +     bool (*handle_poison_consumption)(struct amdgpu_device *adev,
> +                     struct amdgpu_iv_entry *entry);
>  };
>
>  /* work flow
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
> index 26d6286d86c9..5b7eac547a05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
> @@ -78,7 +78,7 @@ static int gfx_v11_0_3_rlc_gc_fed_irq(struct
> amdgpu_device *adev,
>       return 0;
>  }
>
> -static int gfx_v11_0_3_poison_consumption_handler(struct amdgpu_device
> *adev,
> +static bool gfx_v11_0_3_handle_poison_consumption(struct
> amdgpu_device
> +*adev,
>                                       struct amdgpu_iv_entry *entry)
>  {
>       /* Workaround: when vmid and pasid are both zero, trigger gpu reset
> in KGD. */ @@ -99,10 +99,16 @@ static int
> gfx_v11_0_3_poison_consumption_handler(struct amdgpu_device *adev,
>               amdgpu_ras_reset_gpu(adev);
>       }
>
> -     return 0;
> +     return true;
>  }
>
> +struct amdgpu_ras_block_hw_ops gfx_v11_0_3_ras_ops =3D {
> +     .handle_poison_consumption =3D
> gfx_v11_0_3_handle_poison_consumption,
> +};
> +
>  struct amdgpu_gfx_ras gfx_v11_0_3_ras =3D {
> +     .ras_block =3D {
> +             .hw_ops =3D &gfx_v11_0_3_ras_ops,
> +     },
>       .rlc_gc_fed_irq =3D gfx_v11_0_3_rlc_gc_fed_irq,
> -     .poison_consumption_handler =3D
> gfx_v11_0_3_poison_consumption_handler,
>  };
> --
> 2.25.1

