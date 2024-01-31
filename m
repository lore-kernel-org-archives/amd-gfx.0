Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E283C48285
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 08:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10EC510F3A3;
	Wed, 31 Jan 2024 08:28:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49ED10F3A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 08:28:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McWgacgPjjit36oTTmNFnssiOJFmhj04+yVb5BFL+AaNZq4NSxavrprfun5OsniOFhc7sbfiky1Kuzqy+zyOaJAj6puaaqIT6luKg9j0XQsdIij18ag1ZLl5lGYkv2S7bVjo93zIG0DvIe+YyfrQ9CbiQwT5yF5aLX1nEVZMlxW/lbpwJEnTfuWdABFPmng5M2OUrxg6C5wmGuOekP3VA0HQ3WiHHhKarg9ZejebKugHvZt2/6GyLRR1WCvIOeJCO4lERZSXidx3jEBHr/ogylk9qEoimAWmuKkMMby6AOZUnNkVZi90uwW0FUxGSZz6Oi5aZc1uySZXSl/ieLoqag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZfZSLCEP4VXknukL0vNoaQBr0/ek1goiZoeHAonPoU=;
 b=TY1tCZYHJr+HF0Np2MGVriaEQOkiU18LicUAPLmnbaoNzM8k7f0CvFld5OCs/ExhYthMMMYHURh0Qv2bOhbaHXoFEQoI2b+hV6bTsdZah1pkvrX+tDqIiHjSTs7Ai7G8jG/adYlK1mmQQkZ+Q1OlpGSrWvbmnwUCD/lbpGgrvuAuouaOel2oBIaJbEH3YEGeyK5K+jtUnKwgJ3LHONclDvYbP6gJRsAZWs6HNpw6aR2cguCoObNYfNwCFcsESVQs07PEgG5OiIcd0aja87iPuQHYyy4VSNv014odMV19z6PIGxHgmZAsCB7yRKVigUrvPmGA2isIudlLf14gRy4Rxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZfZSLCEP4VXknukL0vNoaQBr0/ek1goiZoeHAonPoU=;
 b=yHQ7mWsbzrkcgQzt6dKyRRSrZksk4Hs9k9H/gvhf1x93RnElVuHWvX/42YhMFCTJWEIhVlmeCgDio9uSDSScrgD4VYaPGOKhu4JScvS0yCIfyOGUeLcMN6gZPyWymiawBhBtCoIoSOmmQLIPRxe0bubvXKyFFzT17Kae0cKvH+o=
Received: from CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 08:28:29 +0000
Received: from CH3PR12MB7762.namprd12.prod.outlook.com
 ([fe80::cd8:6782:48b5:268e]) by CH3PR12MB7762.namprd12.prod.outlook.com
 ([fe80::cd8:6782:48b5:268e%7]) with mapi id 15.20.7228.035; Wed, 31 Jan 2024
 08:28:29 +0000
From: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>
To: "Jamadar, Saleemkhan" <Saleemkhan.Jamadar@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in vcn
 4.0.5 suspend
Thread-Topic: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in vcn
 4.0.5 suspend
Thread-Index: AQHaU35fSyiuBt0NeUeCFKchIRfq1rDzjgEAgAAJq4A=
Date: Wed, 31 Jan 2024 08:28:29 +0000
Message-ID: <CH3PR12MB776209750E2C5CD48BE01945FA7C2@CH3PR12MB7762.namprd12.prod.outlook.com>
References: <20240130131457.3433971-1-yifan1.zhang@amd.com>
 <DM5PR12MB25658FCCE2AB9625C528597D9C7C2@DM5PR12MB2565.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB25658FCCE2AB9625C528597D9C7C2@DM5PR12MB2565.namprd12.prod.outlook.com>
Accept-Language: en-IN, en-US
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
x-ms-traffictypediagnostic: CH3PR12MB7762:EE_|CY5PR12MB6130:EE_
x-ms-office365-filtering-correlation-id: 51a1d8af-fff9-4220-d694-08dc22369a6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EqTjqQT6VKZAolwqrYL2DeHioy4DuMKnLDEfDmEHRYpJsAKQ8FW5r8pCpuc5YAhg0pjoapqnjeYiGr/ag+vqP+zNcoh3C2K1C/X+oPBagiyHpqfYF/TzgZkdzGiVi0B0KjM8a3oerfE3i3tTuhcwo8rn/2vrPzepKjhgKsQr2jC0I8lpyWbJmXxGyCarfuligVz0J6x/iHoyM8UQeCdB/q7dgQSJc8lt88f/QsnddWwOrBWIReT56L1kP+i2+InxmuDJq2YEZSENg0K2F6bTonGbDl8NjBptk8G7NxJyJVnpeMsIzus83z+sqPcbLQiBorCYR1V8G1tsrw26vWTMCE0QaHgNIGqTvoXLIhFX6MN8+xLWPiNi2jxS4yCkUrZVhynR7PUueLeANCEMEhMpJCqhHM63sulF05bbQXg2Jv5F3MTRvOn9GqcyVYLgj5bxsAUis9l7U8fLc+j4D7VLxaPCEkCEo56iuCvYiUE0P7d9dHkLth4que4TgqNuQyQE+1mUnlopr3IAlQ85I4DRBm/AEH2unb28nglBPkzTs4tOE7AiLLGdzVKdb15+6hglHc7JzgJJr8etPfmo/anBeVenGcfFzNKhqEhDNKCTkCoPXgOVLfnrpV43K6S+P4W8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7762.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(55016003)(83380400001)(41300700001)(33656002)(86362001)(38070700009)(122000001)(26005)(38100700002)(9686003)(6506007)(7696005)(53546011)(478600001)(2906002)(110136005)(316002)(76116006)(71200400001)(66946007)(66556008)(66476007)(66446008)(64756008)(15650500001)(4326008)(8936002)(52536014)(8676002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5I/44FvC7GDykrQPljUODKdTZ+sTHlBK6oXVkzlcGHpSCFMEe/YDz7QBo7yU?=
 =?us-ascii?Q?SWc+SujFpdFQh1c7bVwl+XEsg8EBeI+wIpCzWNiEGvp8HlwiP2POlOc3GhXx?=
 =?us-ascii?Q?+rI9m5nOCQsRPQQto4CKBSMpSjQHr2E/bTThbbH88Y3NdPXzJXFCWxz3SxZn?=
 =?us-ascii?Q?+arGI5Y51pAFcAe9tcIlL075+AjzW2Vd5y44M+u9hRv216F9pHBeIBZ82bVg?=
 =?us-ascii?Q?jx6E9gLA/btxHgysFXwdUU6Rykt2FGSIzkLtW7mx5JpbUlzFF4/GAnZiZ5Mr?=
 =?us-ascii?Q?IGCEviFIv4c6QvUtzcJTjprhb6lPikoP7FBIstqzyawazKbvIsM47qH1yBmZ?=
 =?us-ascii?Q?Ia24xiRhUuxDBNFk35L27DI/3mQA+FFoSvDVKTNozbgPtMJcVasl1NJw9MhJ?=
 =?us-ascii?Q?mUVxnaZGLoB2jIHZVE8WZufa/7xBPx5I8lmJF79zvy/XfKdx2pDvcJ4+EilC?=
 =?us-ascii?Q?7AXhAigMuFTc/JasG0a2xLuje7M+gJ7QzxIJer+wUjjw/6nEk5l9zf6VFfqT?=
 =?us-ascii?Q?B4XM99j4MgSTDeBVCfdjeM7qhlHePC5HzpyzkG/ZS2ohXzXnrJGt0uW3APLE?=
 =?us-ascii?Q?e+AxO3XytYHzJXMfa5VE6VNMD266RvJqWpNpwCJ9z25nACoKYTJSnHORiRcO?=
 =?us-ascii?Q?pCwQdmfbLnb+SxwHAgHyVlFpaXubzjbJi5lDjEnorNi6wRbH3RvGQG/UeRy9?=
 =?us-ascii?Q?ZpxfkyjiXARMT+dMpYEDbRmVZHb7nVQxqWRg8vY6YvkvrAPDRrpqxZPdk1cI?=
 =?us-ascii?Q?k4eeB9I0ty6rIqdIKkK19Guzisih/puFJdkH0FNOT8b9dG7YjK9rgwg3QgMw?=
 =?us-ascii?Q?ybvRa4mg3LYRFEESahnqGZ4LItvfmepNemasUE6EFvaLcPq7AWnmwxZniiww?=
 =?us-ascii?Q?qZmKlSUmf/gRil9akIl+gjMETSVKYEKPKGQ0cfGzRf4TKmdt1lnOrSINt0rq?=
 =?us-ascii?Q?SoMGZP2Bc2qPzo+s995JCQ95OCltohL35jmxCvhfhXNIElbOH+f2pHvRrIUB?=
 =?us-ascii?Q?ZRaW/JzCrAyZPUfq99g90jeiNyjbVAgaW8glFZPL6K+QAZsXaUntI7o/IxUi?=
 =?us-ascii?Q?qfuAljX589N/+wOfpbHYm5lsKA8/JXvibV5XVtaFJff8pROCPXVbcjgqTFhx?=
 =?us-ascii?Q?TR0/PP1esisV4q4HBt2DGWJfyXFAFWUAcSRFjmzvVLAE70R11jHuj/4IbNFn?=
 =?us-ascii?Q?II6ogMQsSRN/QCQDTvC9kLgBpnwqtDbbHIgHEyxuXydEhVLyCn48QVpQfPwt?=
 =?us-ascii?Q?gPcnVziEzPrsZCi5Nv65ngYDo54a+ZUfBpwMsjvP8REYX+f4bnzlo4ttsGwO?=
 =?us-ascii?Q?HHFuyoA4VeS3mT1kX/6es1g6YS/b+nwUXnSb5eTFA3uih/JvA6SvMhEOfjrX?=
 =?us-ascii?Q?D1EQCvH+m/MWifIQf+4TGRtfcBT0olx7YCIAtOe/otK9NIylORPKxJ1fonOI?=
 =?us-ascii?Q?OlfxpoEpNiR/Do6xONjblvpPf8FWCC0Zxvf4E5nCHr/CR1ZD6pmvDueIbpt8?=
 =?us-ascii?Q?IGXiiz0Ybb7vdsxRThkUgtB/7fXhDkjxtF9W2LSIEdjREFmV0V4hL+3Jgqq5?=
 =?us-ascii?Q?JX8rMO+W4Tr/7/4QE1o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a1d8af-fff9-4220-d694-08dc22369a6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 08:28:29.3649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozo8V36shO4BCUOmmn8ihl3v1Ht82xBQn1CqaqptTa9AwxsjJI1kCVC3bfzrGhl/I8ZKbBFbcwChKloNexNc1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Looks good to me.

Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.c=
om>

Regards,
Veera

-----Original Message-----
From: Jamadar, Saleemkhan <Saleemkhan.Jamadar@amd.com>
Sent: Wednesday, January 31, 2024 1:23 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Gopalakrishnan, Veeraba=
dhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in vcn 4=
.0.5 suspend

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


