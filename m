Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0956C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 07:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E1710E978;
	Wed, 31 Jan 2024 07:53:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5244310EF68
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 07:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhcsEE8MaeXJrJsLKCarwhuOOerR4z4TR8cfolpH2Y0dwYnO59DADRSNDAs++uabd7mXS2sZYNEWwT0nADxvHDVIpkPWuCgahwQx1GJ+2s4aglitGfoVmT+13ZfZ4eiX9PaiYGBzd8BdBEbMq97dHH5WKh2oYWZDCOO549SJSQFSeXu1yVK41Vp0CAMXk1EP1AqoyMSZ7wDn7dM8E8qKZYTgBmiECeicK5tW5/cvhOeP+bBVjLslhojfv+pUN10TqXgZRMmyeBsHjfwfLc1CK1tDSHB6U2NjFnZyy+gJI1tUguQv5rvB3vPC5ch1xScH+gzorNSfMhnuGCAqNHdL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAJ5SFOAydlnTjzgc8PA1zMPPSRKSvY+ltGxmnj9Y8M=;
 b=jJwJdJVQxanhqjfESUIPQw6O/YAw0l/N0jHQGtSb5mPMuakptN98UqDk7LYaQ+xZuVecccvoN9glXtfOuHS8dzWXaPB2b2GXJudS1Z3Uowpy9/pGJO3AaJUh620ioYw7+Ln7wXczcaqLVTmg+86J+KX/EZkWgJyf0Nn0ZTNWFjWzHElxK1ATRIx2rumMpJ09ds+kMJ4rMRgGUVxrixLO8LCH0365740NSqI+Jnjoyno88xG/tkz9Eg8n48bcgn5XsHFy+6ay2o8wrMaldUqNulNCZbqjSjKhQSz9nDc8f0h2dQ//yezIOKVCfaKjvc21ALjmhzvb1pd8bCx1wU9HUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAJ5SFOAydlnTjzgc8PA1zMPPSRKSvY+ltGxmnj9Y8M=;
 b=4dJak02EixMEPKzaElq9uEo0c8wEjuT9rTkAEfj6SHspbTqWI1hqj76keMPMwMdQS3OFeFsFPv7ZGo2Hp24B6ihcoEVApbsg+4M7YZ0StI+T+KpmTn6bh4R93O0h2Q1MOf/8dPOEnBdFrEyVbwd2CJxesLD1jTW8Q3y4SsiK4fA=
Received: from DM5PR12MB2565.namprd12.prod.outlook.com (2603:10b6:4:b8::37) by
 BL1PR12MB5803.namprd12.prod.outlook.com (2603:10b6:208:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 07:52:55 +0000
Received: from DM5PR12MB2565.namprd12.prod.outlook.com
 ([fe80::fa09:dbeb:7a64:7541]) by DM5PR12MB2565.namprd12.prod.outlook.com
 ([fe80::fa09:dbeb:7a64:7541%4]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 07:52:55 +0000
From: "Jamadar, Saleemkhan" <Saleemkhan.Jamadar@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in vcn
 4.0.5 suspend
Thread-Topic: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in vcn
 4.0.5 suspend
Thread-Index: AQHaU35fclOtW3KREE2fyvzXvsWlLbDzjY4Q
Date: Wed, 31 Jan 2024 07:52:54 +0000
Message-ID: <DM5PR12MB25658FCCE2AB9625C528597D9C7C2@DM5PR12MB2565.namprd12.prod.outlook.com>
References: <20240130131457.3433971-1-yifan1.zhang@amd.com>
In-Reply-To: <20240130131457.3433971-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4af88e6a-97f4-462b-afbd-b3f41c6bf473;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-31T07:51:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2565:EE_|BL1PR12MB5803:EE_
x-ms-office365-filtering-correlation-id: 36302052-692b-4471-e07b-08dc2231a243
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8a23dX12qLtkj0dOgO2BdXxyfVO/P3rmv5Psa9pakEN7IIjl1PWxUSUOM0Te16OMzeVYM/TRlBb9pl3mMieTI/0ZOUg/eQG6+fnhWGDUNkMuiWa/W/d1phtGOUbQhY6KB7VRP3l1AFlNO03FCWlWhAXH8PmHjXs4LGekOU2HS9lT8RBzc0HIbYRkcTQG47yDKI0UU+g/3y0U/hhWzxSdRkECqwqYLk5Eop7hGz2b5/WO8kXvdZcB8IlNA5qoDHX16YL/zNDS6ioK1TpKcewGvtOkPEl3CLp8gz5YP/KIKsqWwHarOcy64qcpD6BoFWwTUXwXWoHZKn166RdijHMzVAAjRfuP8xOT8Qmvo0Oks7b75j9kYhdW/dVrcQpDIb9lOEmIs1wRzePNfLbYebu5t4Gyu1pDM8EMpjF9cOMROY8fSSJl+xsWqeqc2t20qfl7bECCvpWGTbW4hY+rEADkX5r89bXFxq5BTcgMAAtOGwHij2tC4mCJjBy5WOcpAOtP5k5ZDbyz3p3XWQ3h1Pzw0PX19hvKK7HRWotJit6EvtR+EdI+2wktLSyhpafxO3iCTHNMrhtMHn/S35WJKdAlgKP/0rXPh3aBB/XNOqkHJDDyCuDf3h/AFyT9ZoDmfFL8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2565.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(83380400001)(53546011)(7696005)(478600001)(41300700001)(6506007)(71200400001)(9686003)(4326008)(8936002)(8676002)(52536014)(122000001)(55016003)(316002)(64756008)(66946007)(66556008)(66476007)(66446008)(54906003)(2906002)(33656002)(5660300002)(38100700002)(15650500001)(38070700009)(76116006)(110136005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u6ccKSOrUKc4K4Fu0oV11FEbkSlnwjfbrN+PM5pS+bgEdXIyCjsLQj3aTElR?=
 =?us-ascii?Q?iP8v87JlNWUH8Q2djzLVxFcysE/O/lx4y9MgdMsI7gfv9gaJ/LFVXBZKJXKC?=
 =?us-ascii?Q?GZx6mgezhNuhpH49YgSpMqzdx3A4xRSh3/howPBM2s84ArqIP5XLin2Bho8k?=
 =?us-ascii?Q?ToSFK42Az16ZVTEWJAqS2u2f9OeO8nPXOc65x//0nCyhl+1e1/tE4/3wfqxl?=
 =?us-ascii?Q?c9OyEluqkfkIi+6A3ZexAnkQGvGZfscHaJyb2RhMYEDyfoTv5MYdjX5VUaIV?=
 =?us-ascii?Q?2VI4pFaoPceQ6+w6oKjS/yRxc7zpFAEBjpKvbbMsxilEJAWuBbts+KIUA7tI?=
 =?us-ascii?Q?xOm/kU2v63lmwVBVccq8rl9+9hOx7bwlBb1BshxFtTdhaqOAJTlzMbEfTu00?=
 =?us-ascii?Q?DR8Lja703i4KRKzUez77fcrxrIQ67+dDT0n0ppUnIAxtiYQDauF7itVyyvt9?=
 =?us-ascii?Q?C6jPpDJ/akGipz96/obVHxgHPWHY2xlOela7zSXorxZ1C6RJKwXWb5uAncJd?=
 =?us-ascii?Q?IetQQeNRvQz9/RrkCj79nrZ4EYP2xMC7y3f4AA7iHFWcPQS/YCACXb70dkNQ?=
 =?us-ascii?Q?cGF+y4h2sZ6BDvmBARhOaBp/90kwSexWioFLlwUfPfvWYyFnpvazm4NZv/G6?=
 =?us-ascii?Q?UwOlwnhlMeTqqp6a1S+/oleyvl1X1WeH05UGG1RQ0SbbzsOon6gpK4o5oWZW?=
 =?us-ascii?Q?EBLh33d9KDU7kmYbs2inj7cO+2AHlMAl9iPc9CiX5lCMz9Dh3XetspBQclo1?=
 =?us-ascii?Q?p3oVh2ZHy+qvy5OmK3wNopiBzJ8U9ZF4WJxQf+z3EFD5/lEru5qVrftQaXAT?=
 =?us-ascii?Q?qdLD4zfQKkljQwp4Wzb8joPLlYq00qaG6C8nr3TUcjm+YodqKcXYpduaGbBa?=
 =?us-ascii?Q?9a1rHVM4hm2rBGGPuVYjlq+HbR81UucD92qX3dSpAXWhfDIPwSQ4UhJ75wFI?=
 =?us-ascii?Q?1aHak08Z4YXgK6paKzXL9/kdC3X1tCPSH0nwtyXym+PLEPQy1W0eBy51oeiZ?=
 =?us-ascii?Q?tLGX1peZikU/WarueGvAQU7AfK+FhzE7Z8M16xIoHaRUsxcX/pGNo4/rgsOx?=
 =?us-ascii?Q?eQYr9VjhNNWSB8TPJr/gWgRH7XVMdkXxAw1Hu6pD/2MC/0o2nOF0H2fTpIBp?=
 =?us-ascii?Q?WgdIFSnwj/C4LLthT3WW8cNT0UJEI/HYti0r0kzW6H05I8SkTfVlluuJRiky?=
 =?us-ascii?Q?DxYAkoBBzlPxLKifUScUwCKv8d18E+B3oMvPirQ/yQbJDon9ryaQFCwDodZG?=
 =?us-ascii?Q?MJ3GwuXIeHTAuF1H558gcpjiqxrcq+xunTIEMB8kHqMIBSrmceL2c1V7CqjC?=
 =?us-ascii?Q?kU48m8+eTrxB1sJNfHtADV+XGLBjXNAZJRZpzTiU+c1yE3ZWQz7NOrjSRkUx?=
 =?us-ascii?Q?GH4fo6CIERZvuyZ1cBUt64QE1RV7K1EihwiULPw47L9yrUydGxRhP7QcaW4G?=
 =?us-ascii?Q?+S97nrV3MWrfbA6ZYzAa7GcBgMZzL8msY4QV6Jk0vmB/zmPztADTX6E8QOvf?=
 =?us-ascii?Q?2fniuNAS15qhJKsylyhOiXjpApEdhvBRSmzioL1pAxTmrc++FqeznlFA0t6d?=
 =?us-ascii?Q?MsxYBT8PeAmPypeoZQQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36302052-692b-4471-e07b-08dc2231a243
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 07:52:55.0483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pT/IncJdGC7Sw8LwmUBXidP5iJajPAA3BTB9LcmlethhEWzCLxxzdRt90awLhcHAzlRKSWimzkWfT1mdL3JCag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5803
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gopalakrishnan,
 Veerabadhran \(Veera\)" <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Acked-By: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Tuesday, January 30, 2024 6:45 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Gopalakrishnan, Veeraba=
dhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Jamadar, Saleemkhan <S=
aleemkhan.Jamadar@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in vcn 4.0.5=
 suspend

There is no irq enabled in vcn 4.0.5 resume, causing wrong amdgpu_irq_src s=
tatus.
Beside, current set function callbacks are empty with no real effect.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 17 -----------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 19 -------------------
 2 files changed, 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v4_0.c
index 169ed400ee7b..8ab01ae919d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -2017,22 +2017,6 @@ static int vcn_v4_0_set_powergating_state(void *hand=
le, enum amd_powergating_sta
        return ret;
 }

-/**
- * vcn_v4_0_set_interrupt_state - set VCN block interrupt state
- *
- * @adev: amdgpu_device pointer
- * @source: interrupt sources
- * @type: interrupt types
- * @state: interrupt states
- *
- * Set VCN block interrupt state
- */
-static int vcn_v4_0_set_interrupt_state(struct amdgpu_device *adev, struct=
 amdgpu_irq_src *source,
-      unsigned type, enum amdgpu_interrupt_state state)
-{
-       return 0;
-}
-
 /**
  * vcn_v4_0_set_ras_interrupt_state - set VCN block RAS interrupt state
  *
@@ -2097,7 +2081,6 @@ static int vcn_v4_0_process_interrupt(struct amdgpu_d=
evice *adev, struct amdgpu_  }

 static const struct amdgpu_irq_src_funcs vcn_v4_0_irq_funcs =3D {
-       .set =3D vcn_v4_0_set_interrupt_state,
        .process =3D vcn_v4_0_process_interrupt,  };

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0_5.c
index 2eda30e78f61..49e4c3c09aca 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -269,8 +269,6 @@ static int vcn_v4_0_5_hw_fini(void *handle)
                                vcn_v4_0_5_set_powergating_state(adev, AMD_=
PG_STATE_GATE);
                        }
                }
-
-               amdgpu_irq_put(adev, &adev->vcn.inst[i].irq, 0);
        }

        return 0;
@@ -1668,22 +1666,6 @@ static int vcn_v4_0_5_set_powergating_state(void *ha=
ndle, enum amd_powergating_s
        return ret;
 }

-/**
- * vcn_v4_0_5_set_interrupt_state - set VCN block interrupt state
- *
- * @adev: amdgpu_device pointer
- * @source: interrupt sources
- * @type: interrupt types
- * @state: interrupt states
- *
- * Set VCN block interrupt state
- */
-static int vcn_v4_0_5_set_interrupt_state(struct amdgpu_device *adev, stru=
ct amdgpu_irq_src *source,
-               unsigned type, enum amdgpu_interrupt_state state)
-{
-       return 0;
-}
-
 /**
  * vcn_v4_0_5_process_interrupt - process VCN block interrupt
  *
@@ -1726,7 +1708,6 @@ static int vcn_v4_0_5_process_interrupt(struct amdgpu=
_device *adev, struct amdgp  }

 static const struct amdgpu_irq_src_funcs vcn_v4_0_5_irq_funcs =3D {
-       .set =3D vcn_v4_0_5_set_interrupt_state,
        .process =3D vcn_v4_0_5_process_interrupt,  };

--
2.37.3

