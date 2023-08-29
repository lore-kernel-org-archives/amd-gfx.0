Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72EEC83F14
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 15:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D44B10E36D;
	Tue, 29 Aug 2023 15:00:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 756D810E381
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 15:00:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfUn0U6Qi8KmmrwJ8nXgJfjD9QDE8R1HLzIO1i5WqiVyypALeXuFwwdbk52ZL7BU8v8ChFvBxYISV6lh8nXsuGrLYa3wxbv1thAhRauDK3yFEVLHeB+ObXOHJqXxZp7SOWGaBqjbOnIUjfC7k7NIWv1En3dDDLhteccndDXLVOCOCwJpi6PCiL//IgvT4rtLLH1yqVwy9u1tOXj9cYzOiXFIEJw+Zkvz3bKcA0OdSny4aI1V9fznvVEK+jKyONamUbstZ33KK0tSGb5wv4r8EtdD4s0BA0kAk+e+/AVzZ5bedLOexKvIKga/4bEqXFSz7/8u19OpAgUSSkT2vaE8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLkuuUX/4RNAzsjWK49bLfTRuqKUaayR9gVRTit7s3A=;
 b=NrcP/WDpi/zGzC+/S+r5gSoY5Rhzb3zeChy8yoIEGJfubX8SagfrrlJBvCqFO7iwm86xI2OXeWNjA34eoXP9cc1kiURwJo2YApWpUlZsd4N7MgSb/k7lAuCb7qA3GnkwDH+V4uI+whRz2BtHQGxbW5A01vDVfPlPvpGMHjO1P9a6KacrOeGTYDGRquCfGP00SIDVzG2uceJLwgblydqE85R28824H0OKA0niHVoy2hR8SObunWrw704bFxz5DwNAx94Le9vXZSje8pT8hbCuvEBeQPcQXCC/BWQ1nSVb1DK6twJjgB4vGY+pGystkLyP02xfIh/SikUdjT3/VMOqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLkuuUX/4RNAzsjWK49bLfTRuqKUaayR9gVRTit7s3A=;
 b=COrp1iTGTf+l64LRxjLO7KLRHC0IBD3sBlGZFy+8zdtArq99j2eMRudi3InzCUTJLeVlDp0ZAruR+k8kwT2y2Yuze8TEQ1m5avrRAresSDa+CAKaH8h1VrmQe0b1jf56QYuQVHbZn+ymoZFDgLqGQp1e89723bYk+Auy6LIhgQ8=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 15:00:16 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::ac8f:19d4:21ba:17d0]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::ac8f:19d4:21ba:17d0%7]) with mapi id 15.20.6745.015; Tue, 29 Aug 2023
 15:00:16 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Free ras cmd input buffer properly
Thread-Topic: [PATCH] drm/amdgpu: Free ras cmd input buffer properly
Thread-Index: AQHZ2ojiOws5wBWX2EKg751qoAmPerABXYIw
Date: Tue, 29 Aug 2023 15:00:16 +0000
Message-ID: <BL1PR12MB5334E1662CB2AF3AC12AAEF89AE7A@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230829145525.30096-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230829145525.30096-1-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=46e4e03b-bd4a-4c29-935b-1a4e9cbdc0be;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-29T14:58:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|MW4PR12MB7285:EE_
x-ms-office365-filtering-correlation-id: 2cf941fd-eaf1-4b97-c472-08dba8a0a7a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N7S1KlFT7DK0OiyM1O6k/6i/YjG7CRehwkZSXgSneP2J8jTidlsfD1EtqcUPPPcadngJ3VM8LJtyUfTQmepLYwez19HyRQmFds4wDUONUDA/jUftmUaqmtqKncpvGaYv0bHrvULRYbENHLsHeHCF9BbRfz8Qx1vyasSCHkzwzJ47dL8jeA1Qt/b/9E3don6lgngqO62+icxR4WsL7YbRdJh9/98+LFQVoMDd0EBp3YB/4hYEsCSZBmJi4iJTnHKVC8MudlmX+HgzIhoMyZ+ZdQcY8mNQfrc5TDMsHtafZxKu0STyhTdLlC1Ge4Tj9+BgLsStSsz8nUntDy44rIxA9LLVVz6wC6KrJ4P0j35lRg7JFnk8LlJux8rTXfJ5VE8uSwJs/f6gZDRYZahzMN21E2aL7tYTD7JAESZPj/qfq27GUQODcemRD5Xtp0oNSMoRuZWzya91rmbEmWmpCad7FhEpcEKT0yDpUB2LMWz0y34XtS4f6YrFkIg1O5EsqWPQmOFG6n+AOMH0YaJlcXQYPlw/qZ2PVoEWPpTzv7F22VBxkbOAd9YmoYGRYKaCYxr8+iGCU0mrK3G08X5ZlLaxHZWN7wtQzk/ASTIY4DS/CwH3CdEDwXn5MrpLAW3kTLls
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(186009)(451199024)(1800799009)(6506007)(9686003)(7696005)(71200400001)(53546011)(478600001)(110136005)(83380400001)(2906002)(76116006)(26005)(64756008)(66446008)(316002)(6636002)(66476007)(8936002)(66946007)(41300700001)(52536014)(66556008)(5660300002)(8676002)(86362001)(33656002)(55016003)(122000001)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XOFqIMWUu3+Oa3tT6gjEjoPHw59bldq/tt9xGExmJyKvKa+tp7AjdJKMPdgr?=
 =?us-ascii?Q?0QMqABa8toThoicll4b5Z7PYmrevdXDSxNy0iK4QGv3img2E0luLICUruadq?=
 =?us-ascii?Q?owqJ89h/9cJi/w1t464bqcQ+Lnz9POag7LPOjAMnAo33BcSNiV4IWbz/xuD7?=
 =?us-ascii?Q?L13CJlL4DRsrM55gu5DvtRM0n+aWNl5pgLeZ8Q6n9Dlv4jiJ/1e9Hfzw80yN?=
 =?us-ascii?Q?JwMvi6EL1q88wJn72lBbHP2WaQjJekL4WwNDsHgFiK8QTBoWkC/LLzFM4Fxo?=
 =?us-ascii?Q?GH3g3x7s96xO1BAQJrTRsZ61b00lyTY33HBeRrBmp40yD2tksSpFWPKnZWGw?=
 =?us-ascii?Q?5r5PAZ/HzbAOfV4/ey4qop2xJ/+o/lY5yGyj6wS7vmQJWOshJdWtrIT9n+3r?=
 =?us-ascii?Q?AY2caygTPlvVj7UNbRisulFDJAhVWu3fYHwPQ7lZSLa0HfzOyg+v9lztxB6l?=
 =?us-ascii?Q?YHm3e9NU5u7wb3hHCHhipMab5vIcwy4QQjYKzIrwSaBRK8jNGP/F+tfQY5vW?=
 =?us-ascii?Q?ZiuuSLU0cqZ9aQaspnHejmEJjuHLTJwPUYkW6bzxlfCAQfJBP96CHCC3lZ3+?=
 =?us-ascii?Q?DjKsrqaqmMV7iVOu1CYixVoNFAYyIq6n0HzXVDuXmhtnto3ZkrX1dU4YkjMm?=
 =?us-ascii?Q?4EPOkohId2gmUdLqkVuR6ZuPvIR1EW5Kbn7j9KXDTrsytgJpBJRpM2QGtOVt?=
 =?us-ascii?Q?U5JtoD+f5OEggza0WWIw4kfz4uLAEZW53gvbbkqFqtIHoCAM+m9UozMc1w5C?=
 =?us-ascii?Q?2DTI5j2dro0a9kAopFsdnZgbvLRxd+UEjcQU/ll6W7P7IClIpeoqHOi2UIUt?=
 =?us-ascii?Q?j3koMbb3GrD5+ALhzvLJQzsfjWb3jHi/aM1HkMJoWmqQnoSwA8jvSn88vRn0?=
 =?us-ascii?Q?jJ88tkD69IDzrunFHCgQLpIyd0J5ifKIqd0bEU5sVy2Fp3e84NoucwE8SLx/?=
 =?us-ascii?Q?ZlvpHoLR+Zrsq+SKODPl20/sMqr28jBWo9iNfd1uWsGqiR3ZnUPFte713Jti?=
 =?us-ascii?Q?Ez0g+xW5czfgmS6J4QomYvqBPyzN4s10EqiLH6DJVfhzD4gyPKsV9bGo242A?=
 =?us-ascii?Q?uE1tnVy8gYBetW6BWkHAqAgckbQCahdoeSgyOnkU+JpA8hWOQKPETRitDCjv?=
 =?us-ascii?Q?6PBBVvjVr+8eMVspdQdai/kTycrZbG2uJ6W82OzvGPqqymu9zoRdclvkfJN+?=
 =?us-ascii?Q?1NoBNOIQwULXMmnHUQHIx/qhDUle6kF6GXDgKxGutNK962KOGM/o4TWAfjmf?=
 =?us-ascii?Q?uupfv7W3ILLxOG5eSn1TIuQ+UbChW6P8KbZdCL/JPCrJ3GHxkzuiYlQmwx1V?=
 =?us-ascii?Q?50oovE2GMblH/hQVgpzMXyV3qaoIu26NiKRMXpUGLqEvmOqwmNxwFAjsx45Z?=
 =?us-ascii?Q?bI9/6nVm1fK/n+Q56ATjLfvIbpqJQ58GbD4a9G9OVYCsJXUC7rjcs1MLSftl?=
 =?us-ascii?Q?vsqEbMYA0JRiNk6OhG+Uo3cxP8c+ynWsTyt7VJrz7LMrv79+/MtqdAx+F9BX?=
 =?us-ascii?Q?5hmtw+Fu1x/TyurxklyNIi5tTT5ILHh9Wfjjpl4a0Q3e89WMJLzkiuzJy1QV?=
 =?us-ascii?Q?GMy0yn+V+ENmnTsSr0c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf941fd-eaf1-4b97-c472-08dba8a0a7a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 15:00:16.3671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D1WSap6PQPsKRD0DUXh9KLz+QWHBfI9OBr2eU50mbpuqiA49TPD4+EAVD5KSM0sIXmZXJuS77aAjt497tlBIOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
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

Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>

Regards,
Stanley
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Tuesday, August 29, 2023 10:55 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Free ras cmd input buffer properly
>
> Do not access the pointer for ras input cmd buffer if it is even not allo=
cated.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e47600a8e88e..16c5fe487ea0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -804,13 +804,13 @@ int amdgpu_ras_feature_enable(struct
> amdgpu_device *adev,
>
>       amdgpu_ras_is_poison_mode_supported(adev), ret);
>                       goto out;
>               }
> +
> +             kfree(info);
>       }
>
>       /* setup the obj */
>       __amdgpu_ras_feature_enable(adev, head, enable);
> -out:
> -     if (head->block =3D=3D AMDGPU_RAS_BLOCK__GFX)
> -             kfree(info);
> +
>       return ret;
>  }
>
> --
> 2.17.1

