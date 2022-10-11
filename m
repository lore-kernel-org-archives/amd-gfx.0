Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3943C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 05:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44F510E5BE;
	Tue, 11 Oct 2022 05:23:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F7110E5BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 05:23:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXVy96Px+8JscyrCB4z+9OsW2XNWT0CMFL8YIFvOG/2CKZYzChML0kz1PPiP9KISG36MKbczoQcJfEY34de0JwR0xC/5prUPs+2E0NBTOjoDwn45gKg6/TQ6Q0FN7Z1o/0EdrPYcjI819K2Q8/IvYnI9Tj6I46WXa1PUBgadsbuKA8gend62mZvXCPGKoZfxvZkjWoqQfiXKw6itYIyONf3v61fSzpzhKd4nsCqUnjO1pqsIS+YA936WQTIud7vLK9VUR2i0McOZxwYMJNivG/CXKl24yTHoljGIHpzAzHIPhhvtWfTMN5JuAd2pLA89ynr3uM4lFBuTMnJziRGYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xT3jvU7AJFPypJ8y89Iyz6SRELyJQv6JDbO0FVIomF8=;
 b=ikZnBTaiqMynJBgcu5VsiIy+D4qJeeyyp9Svfyif7QTvxOMJy66lnCJGe54MFHVYfI3U0MdNwcQ2wHe/WbzNerhOikJzZxqWAzD6WAH15Ika0CuUbw1rJdYELe+ekerWt2hXkH6KyFa3Ye2avdCEgQAw0cXa007r8BFfRHYnRHRcm6YHBQQx5Y89kkvLRfvDR6JfyrhBiyJiyIB+NvTdVW8uGb2crGcgYfHGdaemGtJQSc8fIRpNSGWKSsMlKb92wXnjd8DFgFEenQUVozZC+MXYNgHdTCJtHgt1lzGNRzNzNcigX880mP5iF7xJD33RqpZBpUUSe7UsOfCpIE5iiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT3jvU7AJFPypJ8y89Iyz6SRELyJQv6JDbO0FVIomF8=;
 b=wO8uVVxvqIE27+/DnzbyUooEUoMNSEAayrt7JBMxfDupkJdj1DCTLgrb6jE3UusIO8Wi3lrqHp6ftIf+9zLXd6zye5TA/UuqXZaf7Jf1Tr8Qsx+WzjgonkxErJYnLGTbkAwxngPNroLTvXMMdSAmnmJ+RM54SLKzoll39v8yUOc=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.41; Tue, 11 Oct
 2022 05:23:11 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::17b2:7f3c:25f7:4c97]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::17b2:7f3c:25f7:4c97%8]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 05:23:10 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: correct the cache info for gfx1036
Thread-Topic: [PATCH] drm/amdkfd: correct the cache info for gfx1036
Thread-Index: AdjcSY11oTxMl0WIT9SvS4q+/96NQQAbYFC2AB55vmAAAAoLYA==
Date: Tue, 11 Oct 2022 05:23:10 +0000
Message-ID: <DM4PR12MB51522F1AFF5AF9507C1678E7E3239@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <DM4PR12MB5152E7324B015121A58421D2E3209@DM4PR12MB5152.namprd12.prod.outlook.com>
 <BL1PR12MB51444061064E5A389D8EDB36F7209@BL1PR12MB5144.namprd12.prod.outlook.com>
 <DM4PR12MB5152F3DFF5D93F750662E0B4E3239@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152F3DFF5D93F750662E0B4E3239@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-11T05:19:21Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-11T05:23:09Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 44986f5e-93c3-49bc-a221-b1e7582bf82f
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CH2PR12MB4072:EE_
x-ms-office365-filtering-correlation-id: 82e5596e-6ada-41da-4154-08daab48b039
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mFlA3ezu/13SIfbVCRxzrnwDQhO2nOyw/nLrutOi2t0vFgcFs6XLPaLYwGtWRgZBSjWG3wsafcGK5JFxb/B4pvMAOm982CeDpUwNbgvjmho2RD2TP2hg6GFg75yAT+YiL1gQAqWg5QFDOmy0fa/EpqJiE7dlymBUQQho244lBUAOOzRPlIB/hufv7NQCj7qrrraoim3VNPdB/kOh9s1NtJ/XCVyNmVVlTw7CWYBhgZOhEDvpQ861fzLcnQDDCC63LG9yKZhkaI98z6uzAZNpdt0yWJhYhElfFN605IBVJQDJ4Oi8hSoyXfZCsP9nd6B6o1/W9F4IlLqGyNOVSrujRyPSLNccIFjvZUxhs/jVeXr5BoEor1CXuhpz7zFbc3llNOWUo0hUweoOBTyD4eATPjWFuGReoEwHGFxSv97GOBJYulcX+a+j3Sst9yWSt1k8SHlhE4Omus4cqyxySypdnWfNIaPY4XbLaK+IrroC91epPZY+sQqjw3/dMOztsbhWgkB82rTKVlyUL19gUnMQ3gDRUoWW2Wifpf2/JsaahS61UWHX+r+V/n4K/W9h7oP91Z/InIw22P15Vo+CAG9OqOdPoDLQcHrgTFUm5zav/BKdwG+zo2DQoWg/k9TkNRnoCOp2B2bgmp8vao+ldnm5UFR752Jc5rJCigK8bTgauU0hcc6mO0mGBIHSSIozgBY1NGPUxoWbO5AdZ5mfclHK8pD79BgGTRS27nHiCgxX4UovvKPc7CfiFfx//Tm7R5qRrztz7AudxRWM4kgb5BO/wzxkHfB/yXkjrTDe0u7qO2N6CxIZmE9tObqk4V+CN3Wa
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199015)(6916009)(316002)(54906003)(41300700001)(6506007)(7696005)(52536014)(5660300002)(66946007)(8936002)(66476007)(66556008)(66446008)(33656002)(4326008)(64756008)(76116006)(8676002)(26005)(71200400001)(9686003)(478600001)(186003)(86362001)(55016003)(2940100002)(2906002)(38100700002)(38070700005)(122000001)(473944003)(414714003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wAuYV9JbcPuE0OqFIMr6DGSttpZwA9e3FtAlzh1jdj76y3MujiYM5BaEtWn2?=
 =?us-ascii?Q?H62xiPUcPifV9tVE1Ockhq5dcmDuLGsWM2FjJsP8yD9dg4otQOw1C1+fDpuA?=
 =?us-ascii?Q?ekGk72DuDD8LS9q/OuqnukAKXeWB5sqjqXcLrQhXTxcaxGSPbYZmEd/NrULu?=
 =?us-ascii?Q?CjwPCvCd2Rv+xE+LtWHjCr2O+wB+0DFy+u2ladnfXGsSKy3sgCuHEtioPOv6?=
 =?us-ascii?Q?Haw1hKr1r/FpV1QXAzjf8DPuel+JxiRqinN+3Hv+e9x/5e/3QOiaR6C7ZFZA?=
 =?us-ascii?Q?ISwD0S5fu1ieUJPhxnOqrrLmvSWlrvqqK8nnz6c/iAccljpD1u+Jy7dteDZN?=
 =?us-ascii?Q?fwyX353cqM5HEY1GMbJDcYz8HA92TtYYVhP1t5o1b1xKC1u5OW59hpF5oPtx?=
 =?us-ascii?Q?AhvPpC9zcNAxxpqFVwmX3cbDGsrjoP1tquUvooCmvyXsYWVJxJJsaVAydFVj?=
 =?us-ascii?Q?yW1o5a2DFO38oJoIqlC0WE18qn3AcxRmCyReCJpFbkXxcEsb+IdvUE0JIiH6?=
 =?us-ascii?Q?+wu9K1IppUKiXlYhSr+c7qNprY9pKTeepEf/aXxi7kPweDIC39regWoKBQSw?=
 =?us-ascii?Q?ym2UsD+YzLBCZ9daDeqz2OGwTLEzU1+dUvBSav/la1KNT6BTo9uunbPVL1R1?=
 =?us-ascii?Q?4Aywo0ZVipEwpxvAVtubVa4yLJghLXYLSwyuiB0G9xrgvwLOW2guHYoSS+UB?=
 =?us-ascii?Q?e7Qx/Ao5J4KNOTvBsbN+OgLpQlWaBcX6ZuY4vx+N8F4IEurJYKwvSl6TcABv?=
 =?us-ascii?Q?36in2uXCMBHAKfuEbWbmz8SzkDZd5aowFLg7Y5KGrc53PUOu4l+aTfgvdUU3?=
 =?us-ascii?Q?6pa2f9gGT21IHkW7osCdl7iup8nCFE3aBbVE4VaeMV8OqWFBZwbeDlyl7Vq2?=
 =?us-ascii?Q?AIjviOl+q6qKuMiurcEl4CKdri7u7iQ9cv2Mwf37019Ku/AW8m8M8XHenu64?=
 =?us-ascii?Q?Hwe5XBJ21pTxzbG0ZxKndsopYsA81Nd3Uy/rBdObbefJLW9vYMbRN6OmR/wC?=
 =?us-ascii?Q?mA6vnocHaVLSgojKJty1pNTEepzZiTd1WYDXoorWkmsV0GW/bUvXfnt50aw+?=
 =?us-ascii?Q?uEFJA61GZy67uLkzJ30XZKw9jlriSDmctDO/pzCGrbnw1Syp6IRRslECnUZ1?=
 =?us-ascii?Q?c65ao+Ipldwp/BhH6bcu0b/gB/6IPOU+J+tzVvzkjLzD6O/wU9K7Pdo0ubJY?=
 =?us-ascii?Q?nRu/pS/1Uop91XTwJgOKhwaNmHLqjWqeYywTOsh1SnrJ9dXAc8xMbxW1rrDB?=
 =?us-ascii?Q?09MgG/PjcePN3V+hl+2JKJG/mABM9wFt99Wjebmq6HGGg4QvUPpgatXPkC2I?=
 =?us-ascii?Q?jwYEp08xhLRM0pnXFDiCS0ZL33MlIISCMGyyeT43zP3N4LxeZCeOjcGp2sSy?=
 =?us-ascii?Q?rN+TRTtCvbB/VOIuL1U0p7D3EYDyst/gyK2ZMm4YfQJ3gy2ph1qR4naG+vw3?=
 =?us-ascii?Q?KyYL0kFTctuZZ1RyFW7kt5dF9PcCCdXqTsVo/5EGWPm3qI5h++W4GMOl2smT?=
 =?us-ascii?Q?eJsCRkK1bhdA5BRXy3QCzyhfxSELu3U7WcZU+YjXWd2WKFwWU7nPBMwGhbez?=
 =?us-ascii?Q?nhvBp0WdGp27364vwP/t/racm9BzKNTm2iPqPpeG?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB51522F1AFF5AF9507C1678E7E3239DM4PR12MB5152namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e5596e-6ada-41da-4154-08daab48b039
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 05:23:10.8415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1776N97m5SkWwvP1Wk7v7rLfgGpyLxm4vzsxdg+AN5xX+NgA9hZgVjgtue2T4uTvbbrhZwg+n3I2OsgMwpytaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB51522F1AFF5AF9507C1678E7E3239DM4PR12MB5152namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]



   correct the cache information for gfx1036



    Signed-off-by: Yifan Zhang yifan1.zhang@amd.com<mailto:yifan1.zhang@amd=
.com>



    Signed-off-by: jie1zhan jesse.zhang@amd.com<mailto:jesse.zhang@amd.com>

    Change-Id: I60e754737057c144e69a6511ba6ddfca472ca7a1



diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c

index 477a30981c1b..d25ac9cbe5b2 100644

--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c

+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c

@@ -795,6 +795,54 @@ static struct kfd_gpu_cache_info yellow_carp_cache_inf=
o[] =3D {

        },

};



+static struct kfd_gpu_cache_info gc_10_3_6_cache_info[] =3D {

+       {

+               /* TCP L1 Cache per CU */

+               .cache_size =3D 16,

+               .cache_level =3D 1,

+               .flags =3D (CRAT_CACHE_FLAGS_ENABLED |

+                               CRAT_CACHE_FLAGS_DATA_CACHE |

+                               CRAT_CACHE_FLAGS_SIMD_CACHE),

+               .num_cu_shared =3D 1,

+       },

+       {

+               /* Scalar L1 Instruction Cache per SQC */

+               .cache_size =3D 32,

+               .cache_level =3D 1,

+               .flags =3D (CRAT_CACHE_FLAGS_ENABLED |

+                               CRAT_CACHE_FLAGS_INST_CACHE |

+                               CRAT_CACHE_FLAGS_SIMD_CACHE),

+               .num_cu_shared =3D 2,

+       },

+       {

+               /* Scalar L1 Data Cache per SQC */

+               .cache_size =3D 16,

+               .cache_level =3D 1,

+               .flags =3D (CRAT_CACHE_FLAGS_ENABLED |

+                               CRAT_CACHE_FLAGS_DATA_CACHE |

+                               CRAT_CACHE_FLAGS_SIMD_CACHE),

+               .num_cu_shared =3D 2,

+       },

+       {

+               /* GL1 Data Cache per SA */

+               .cache_size =3D 128,

+               .cache_level =3D 1,

+               .flags =3D (CRAT_CACHE_FLAGS_ENABLED |

+                               CRAT_CACHE_FLAGS_DATA_CACHE |

+                               CRAT_CACHE_FLAGS_SIMD_CACHE),

+               .num_cu_shared =3D 2,

+       },

+       {

+               /* L2 Data Cache per GPU (Total Tex Cache) */

+               .cache_size =3D 256,

+               .cache_level =3D 2,

+               .flags =3D (CRAT_CACHE_FLAGS_ENABLED |

+                               CRAT_CACHE_FLAGS_DATA_CACHE |

+                               CRAT_CACHE_FLAGS_SIMD_CACHE),

+               .num_cu_shared =3D 2,

+       },

+};

+

static void kfd_populated_cu_info_cpu(struct kfd_topology_device *dev,

                struct crat_subtype_computeunit *cu)

{

@@ -1514,11 +1562,14 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *=
kdev,

                        num_of_cache_types =3D ARRAY_SIZE(beige_goby_cache_=
info);

                        break;

                case IP_VERSION(10, 3, 3):

-               case IP_VERSION(10, 3, 6): /* TODO: Double check these on p=
roduction silicon */

                case IP_VERSION(10, 3, 7): /* TODO: Double check these on p=
roduction silicon */

                        pcache_info =3D yellow_carp_cache_info;

                        num_of_cache_types =3D ARRAY_SIZE(yellow_carp_cache=
_info);

                        break;

+               case IP_VERSION(10, 3, 6):

+                       pcache_info =3D gc_10_3_6_cache_info;

+                       num_of_cache_types =3D ARRAY_SIZE(gc_10_3_6_cache_i=
nfo);

+                       break;

                case IP_VERSION(11, 0, 0):

--_000_DM4PR12MB51522F1AFF5AF9507C1678E7E3239DM4PR12MB5152namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:blue;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"purple" style=3D"word-wrap:b=
reak-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0cm"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;&nbsp; correct the cache information for gfx1=
036<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp; Signed-off-by: Yifan Zhang <a hr=
ef=3D"mailto:yifan1.zhang@amd.com">
yifan1.zhang@amd.com</a><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp; Signed-off-by: jie1zhan <a href=
=3D"mailto:jesse.zhang@amd.com">
jesse.zhang@amd.com</a><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp; Change-Id: I60e754737057c144e69a=
6511ba6ddfca472ca7a1<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c =
b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<o:p></o:p></p>
<p class=3D"xmsonormal">index 477a30981c1b..d25ac9cbe5b2 100644<o:p></o:p><=
/p>
<p class=3D"xmsonormal">--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<o:p></o=
:p></p>
<p class=3D"xmsonormal">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c<o:p></o=
:p></p>
<p class=3D"xmsonormal">@@ -795,6 +795,54 @@ static struct kfd_gpu_cache_in=
fo yellow_carp_cache_info[] =3D {<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p><=
/o:p></p>
<p class=3D"xmsonormal">};<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">+static struct kfd_gpu_cache_info gc_10_3_6_cache_i=
nfo[] =3D {<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p><=
/p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TCP L1 Cache per CU */<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_size =3D 16,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_level =3D 1,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags =3D (CRAT_CACHE_FLAGS_ENABLED |<o=
:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_DA=
TA_CACHE |<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_SI=
MD_CACHE),<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_cu_shared =3D 1,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p>=
</p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p><=
/p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Scalar L1 Instruction Cache per SQC *=
/<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_size =3D 32,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_level =3D 1,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags =3D (CRAT_CACHE_FLAGS_ENABLED |<o=
:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_IN=
ST_CACHE |<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_SI=
MD_CACHE),<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_cu_shared =3D 2,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p>=
</p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p><=
/p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Scalar L1 Data Cache per SQC */<o:p><=
/o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_size =3D 16,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_level =3D 1,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags =3D (CRAT_CACHE_FLAGS_ENABLED |<o=
:p></o:p></p>
<p class=3D"xmsonormal">+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CRAT_CACHE_FLAGS_DA=
TA_CACHE |<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_SI=
MD_CACHE),<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_cu_shared =3D 2,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p>=
</p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p><=
/p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GL1 Data Cache per SA */<o:p></o:p></=
p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_size =3D 128,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_level =3D 1,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags =3D (CRAT_CACHE_FLAGS_ENABLED |<o=
:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_DA=
TA_CACHE |<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;CRAT_CACHE_FLAGS_SI=
MD_CACHE),<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_cu_shared =3D 2,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p>=
</p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:p></o:p><=
/p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* L2 Data Cache per GPU (Total Tex Cach=
e) */<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_size =3D 256,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .cache_level =3D 2,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flags =3D (CRAT_CACHE_FLAGS_ENABLED |<o=
:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_DA=
TA_CACHE |<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CRAT_CACHE_FLAGS_SI=
MD_CACHE),<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .num_cu_shared =3D 2,<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<o:p></o:p>=
</p>
<p class=3D"xmsonormal">+};<o:p></o:p></p>
<p class=3D"xmsonormal">+<o:p></o:p></p>
<p class=3D"xmsonormal">static void kfd_populated_cu_info_cpu(struct kfd_to=
pology_device *dev,<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct crat_subtype_computeunit *cu=
)<o:p></o:p></p>
<p class=3D"xmsonormal">{<o:p></o:p></p>
<p class=3D"xmsonormal">@@ -1514,11 +1562,14 @@ static int kfd_fill_gpu_cac=
he_info(struct kfd_dev *kdev,<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; num_of_cache_types =3D ARRAY_SIZE(beige_goby_cache_info);<o:p>=
</o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 3):<o:p></o:=
p></p>
<p class=3D"xmsonormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 6): /* TODO: Doub=
le check these on production silicon */<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 7): /* TODO:=
 Double check these on production silicon */<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;pcache_info =3D yellow_carp_cache_info;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; num_of_cache_types =3D ARRAY_SIZE(yellow_carp_cache_info);<o:p=
></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(10, 3, 6):<o:p></o:p></p=
>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pcache_info =3D gc_10_3_6_cache_info;<o:p></o:p></p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; num_of_cache_types =3D ARRAY_SIZE(gc_10_3_6_cache_info);<o:p></o:p>=
</p>
<p class=3D"xmsonormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 0):<o:p></o:=
p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB51522F1AFF5AF9507C1678E7E3239DM4PR12MB5152namp_--
