Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC13AC47258
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Feb 2024 05:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C79210E7AC;
	Fri,  2 Feb 2024 05:39:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eIXn2QS7";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 352C610E7AC
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Feb 2024 05:39:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igKq/ZFqLaaeJF0DXob39PivcI5WRZa9j7onIDB17QIsn1OvCTcL74jgj0q1za0bSlP6SuFRZ2URz3hYOwu5fcaOpBsZqF/osbJmp0UPhjDVf4Lx2r/9EtjxDUwScslDNp/DsEMB5CQYYePhth4yxtYU++DdZG+Hbq2NgZfkTsldgz9tY3YgBwEOVWSiPO6JMg1KA17ttYk0xCUxIOOZJq83vHC23EhzAPyST8CyvzD4cVSLPXaAdfSW739w3jk4VhEeamFopKl38wIsixeq87Tg5Ovw4HvXPprxB7dRPqAhBqJLcosKOYFXZ520zdRD5YJ08MUwJWd/CX9B8oM2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1izsfa3uh2gsAq+boj3yC7459bzM9oKvasxWoivqkcM=;
 b=I3uIJdf5P08aSQGLUOFfL1EdazZXaBBxzpPQDi+eHKCxbZvvAKUIaDqB2Rgqsu+CacQpCURwszNdoiVhQaChxACoYzIt5qhgzPdFyBlnxkxFC1naSe2OpUwFfX6linZ8uYc3Pmg1dCwRsIEuPQsFB6immAhFM/9mNxk0DHwv+lXvnd5S/hSqaOqdovehIpoiTnquQrFNY8SGYQyUF5kOf4IFw+EYlJSBcLY883Np5WjB+Lc15xZadyDqysjtWuXIMmBwVyrHfqo8mZokZjJ2KOra3ilee1kg2PrYYsIQUAj7uic3IQskAzzD0avCkddYp7WVQyahuPUC8xbmRUIQSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1izsfa3uh2gsAq+boj3yC7459bzM9oKvasxWoivqkcM=;
 b=eIXn2QS7smzrRimwlES6nPn+VEANU8xnfQWVhgkYYfHOcl8QHDNd/llo2KuNDKpfTg73g/sQJTdIQZjg1D9MMsrfCxEERZEKbz/vCZsmCB9Emfxf4/jauNOIahU+LZ2A5EX/b+wdctSdUWQJmXZZMiiCrIkwpr9KVhnCx7DBIeI=
Received: from IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16)
 by IA1PR12MB6530.namprd12.prod.outlook.com (2603:10b6:208:3a5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Fri, 2 Feb
 2024 05:39:32 +0000
Received: from IA1PR12MB7759.namprd12.prod.outlook.com
 ([fe80::3044:44e0:aa6b:7b30]) by IA1PR12MB7759.namprd12.prod.outlook.com
 ([fe80::3044:44e0:aa6b:7b30%5]) with mapi id 15.20.7249.024; Fri, 2 Feb 2024
 05:39:32 +0000
From: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>
To: "Jamadar, Saleemkhan" <Saleemkhan.Jamadar@amd.com>, "Ma, Li"
 <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in jpeg
 4.0.5 suspend
Thread-Topic: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in jpeg
 4.0.5 suspend
Thread-Index: AQHaVQWomrRd95XYqkOFQptf+a2Q2bD1YhoAgABDb/A=
Date: Fri, 2 Feb 2024 05:39:32 +0000
Message-ID: <IA1PR12MB7759DF013687DDF633D6BE84FA422@IA1PR12MB7759.namprd12.prod.outlook.com>
References: <20240201115430.4180149-1-li.ma@amd.com>
 <DM5PR12MB2565AE0FE8B725872E73B5809C432@DM5PR12MB2565.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2565AE0FE8B725872E73B5809C432@DM5PR12MB2565.namprd12.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a758903b-0e23-417e-89dd-60af0c297516;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-01T11:57:55Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB7759:EE_|IA1PR12MB6530:EE_
x-ms-office365-filtering-correlation-id: 7b176507-c3c8-41fc-0ea4-08dc23b154f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: otI/2Mr/yd+VIiPiha5crZt6VbJ2nclPiiG8dZxMek9ol+1L0HPgKsYad88O+TXbquDeTSRFTp18Dho3p4E6sdJSOGZ3T0Xs5wUszb+Xhg5sdrB7tcL+VBFPtKlRoc7Z4v6MqBLsewcNMqJIrRwjpLGzjchaWOpXIXKBMRp0RBUgv11L36E66Z1Yg9ZiOQjbGiAPnbxLU4IV4ammUOPVEYNll2LYHQlCPgSHuK+2mGyCk5Jgs+9jShYHJkzMsdMGb5vnnzTygUcdwe+xTYeeNyIJN4JJQH7/qtWy4h8z/SsgzZLE5KtHvjpAlG8Y2fAPpNuTlNKOd7MQyMtkiOLIiFF6vPMIJuLHsrhn1DT5yw+R+fqQmL2cNAOrQmvgi35zX2lMCuJssV+i83qcWuaAgjBer6MtWmA7b9C4Sj4h/wxx8aHYAenwshenqIc2P+EJRI1JAvDIiNZsW7ihPHIflIZnifnqh2nc2+ZYtq07ysGZBjdr688muNAjvLXLkN8rgAeym5XVJ1TW1vAymzX/kv7EZvoIioT1MrISm2wWClFr3ow1d4n5gud0kLCb7tkffeNRK1Wn5q8otE0i9JHpzQLKDH0eyS43/mpFnM+mfPnfQsSST+CAZktf4yn54PvKEe+YFncC3c28aZh+iXagXvO7N5HXTaXU6uV4B9054IM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB7759.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(52536014)(8676002)(4326008)(8936002)(66446008)(55016003)(15650500001)(64756008)(54906003)(66476007)(316002)(66946007)(66556008)(110136005)(2906002)(76116006)(33656002)(478600001)(9686003)(7696005)(6506007)(38070700009)(71200400001)(53546011)(26005)(83380400001)(122000001)(38100700002)(86362001)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8qhhtAOuXVWuax9K4BMfclIW+Tj/1KEks3OH/x1uiqBC7UbFICokWmLYmkeA?=
 =?us-ascii?Q?KnoAzEXb7W85erY+D4dnZx/z+bkgFmwcd1KseEZUsqjL+LeO5SRXMYveXJNJ?=
 =?us-ascii?Q?lbJH7kVb+wCkE/cPih2JUcykQEULdbi23+gv7FlAniVYzqZMgSx13FGp3BDa?=
 =?us-ascii?Q?YIIBmUj/JNeAjJi1xpMGP/jdiLzqbSG+F9vjIyxhenefNGZdoZiuaBADfw+q?=
 =?us-ascii?Q?dYQGo7AU2tgbwnNqM2C4woP83NIlVcIWCAkh5L0DVuuSxTm3YY1hG8r/Lj/h?=
 =?us-ascii?Q?jz6nFlu1exOBFXt4X7GFtz9wD1HayWTFYERr25pakVejp+1yixv6/DKrV1pt?=
 =?us-ascii?Q?oTlYURhVTEN6X2A7XUs2jaNkXoXzBgFGyb7GDuEhzGP5y8jFIuHR3GZFUdLY?=
 =?us-ascii?Q?EkTTgRjD8vXv7SpQUaqv3OeMRzXbzvChZ4eRMO5Y81HA94RKcz45SrkiSzgS?=
 =?us-ascii?Q?86iqzbW4N2iPCh1D4XXhAhDaBypu+j9nL2i7PnKFJb51YX0QE3DgKXb9d/90?=
 =?us-ascii?Q?Zv7CERJuhV8eC1KXvReiEKk546rZ1GX86jNZ+WqNXiufJuGllXGsi1tFkolw?=
 =?us-ascii?Q?c1q+Bp4yAU0ak5q8Gw3VSJf3QnKn61SVt4XIpzvO2MKIw40F79BIrfKtvjA0?=
 =?us-ascii?Q?VVUy/PyFM1yf2WJAHV5hplB1jZYaon2pOJA20LlmURXfwHNjOIHEXA5sSByu?=
 =?us-ascii?Q?OYqtaDXuv/19PXeNIvH3cA9xL33xlZJM2jTwsYTKl0tFUGN6NoM4d3/h0cQe?=
 =?us-ascii?Q?hCzE3Xs0L2ckn2S3J7/7rciYjf1vwvUUgd0dtxPgYINKh2LmWMVykNH20FfT?=
 =?us-ascii?Q?9gKJ1Ho2WaTpEbuw8gSe7DZUelBRdE5F9ui0rkotDTQgSv6XOd1zESfwAGlP?=
 =?us-ascii?Q?rwgpHrgsoVDTu+SH52tOt90pVz0kCISUTxzo+8jUU0AUwP42Yv9KryAZr8QN?=
 =?us-ascii?Q?kOnNv15ctmfds3eiqgB62zqPF127bddK2azMgp6hG9aRWtNkWlFSzI9CkAva?=
 =?us-ascii?Q?srIXvA4B03Unoxox5ssCBhswokAeEhbHRBocsctAk/EgGW9WGmLBPcf7AzNO?=
 =?us-ascii?Q?NamT3cmj8ZxxlrIxE/WOnMpw1cHThIEpW/NnggQ+R+ixvHNWAzQ4bWACiCF5?=
 =?us-ascii?Q?p/kdvdIeG6jwJR1UxowiT4M3gw+xUqehuEqa3KfinPyrd9yJfAXKRdfDNtCd?=
 =?us-ascii?Q?f5QPbVBqO8QUMRCDkJjLdmogHqRQzn4cazEITKaeVJpc4llmkdbBo+PTh1vH?=
 =?us-ascii?Q?+OwLUezinyfgeaHCxmXqPJ/N7OK7Gt7qlnfq/eapcWdQncXgWqtM1WYcICKv?=
 =?us-ascii?Q?hJAXNLaxAK6ZwxZTqVb1afX4+bPZE27UHBn/6lK1zaI78gdDI2OBOb601xIS?=
 =?us-ascii?Q?g5BVegCP82byVZ/0krFaKicJST2MnTZLp5F6sRvC9l1aBycPalW8f1tgB0Qw?=
 =?us-ascii?Q?CykxLLQRFNQ9gBWhDha1ujY8//3NQDg98ueCtK+K5CQZl5ID0vjz3jVOM70K?=
 =?us-ascii?Q?JEZ1dynekww2r67F0pukjNcazY7DWbH3LAFmC9cRe437n/0ADcfgWYGqHVHC?=
 =?us-ascii?Q?V720+hQIJ6Cw6KLHBpI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7759.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b176507-c3c8-41fc-0ea4-08dc23b154f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 05:39:32.0818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAiUPdrM7tiaG5H1/IpbdhVNXMA/LPiVpWEGvnLcTe9Qa75uMyfORZwTyjxupaw8n4+L18dS+0owhWWhcL5AYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6530
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

Looks good to me.

Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.c=
om>

Regards,
Veera

-----Original Message-----
From: Jamadar, Saleemkhan <Saleemkhan.Jamadar@amd.com>
Sent: Thursday, February 1, 2024 5:29 PM
To: Ma, Li <Li.Ma@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Gopalakrishnan, Veeraba=
dhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Zhang, Yifan <Yifan1.Z=
hang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in jpeg =
4.0.5 suspend

[AMD Official Use Only - General]

Acked-By: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>
Sent: Thursday, February 1, 2024 5:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Jamadar, Saleemkhan <Sa=
leemkhan.Jamadar@amd.com>; Gopalakrishnan, Veerabadhran (Veera) <Veerabadhr=
an.Gopalakrishnan@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Ma, Li <Li=
.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: remove asymmetrical irq disabling in jpeg 4.0.=
5 suspend

A supplement to commit: 45fa6f32276f7ce571227f8368cf17378b804aa1
There is an irq warning of jpeg during resume in s2idle process. No irq ena=
bled in jpeg 4.0.5 resume.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  9 ---------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 10 ----------
 2 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v4_0.c
index bc38b90f8cf8..88ea58d5c4ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -674,14 +674,6 @@ static int jpeg_v4_0_set_powergating_state(void *handl=
e,
        return ret;
 }

-static int jpeg_v4_0_set_interrupt_state(struct amdgpu_device *adev,
-                                       struct amdgpu_irq_src *source,
-                                       unsigned type,
-                                       enum amdgpu_interrupt_state state)
-{
-       return 0;
-}
-
 static int jpeg_v4_0_set_ras_interrupt_state(struct amdgpu_device *adev,
                                        struct amdgpu_irq_src *source,
                                        unsigned int type, @@ -765,7 +757,6=
 @@ static void jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev)  }

 static const struct amdgpu_irq_src_funcs jpeg_v4_0_irq_funcs =3D {
-       .set =3D jpeg_v4_0_set_interrupt_state,
        .process =3D jpeg_v4_0_process_interrupt,  };

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0_5.c
index 6ede85b28cc8..78b74daf4eeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -181,7 +181,6 @@ static int jpeg_v4_0_5_hw_fini(void *handle)
                        RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
                        jpeg_v4_0_5_set_powergating_state(adev, AMD_PG_STAT=
E_GATE);
        }
-       amdgpu_irq_put(adev, &adev->jpeg.inst->irq, 0);

        return 0;
 }
@@ -516,14 +515,6 @@ static int jpeg_v4_0_5_set_powergating_state(void *han=
dle,
        return ret;
 }

-static int jpeg_v4_0_5_set_interrupt_state(struct amdgpu_device *adev,
-                                       struct amdgpu_irq_src *source,
-                                       unsigned type,
-                                       enum amdgpu_interrupt_state state)
-{
-       return 0;
-}
-
 static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
                                      struct amdgpu_irq_src *source,
                                      struct amdgpu_iv_entry *entry) @@ -60=
3,7 +594,6 @@ static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_devi=
ce *adev)  }

 static const struct amdgpu_irq_src_funcs jpeg_v4_0_5_irq_funcs =3D {
-       .set =3D jpeg_v4_0_5_set_interrupt_state,
        .process =3D jpeg_v4_0_5_process_interrupt,  };

--
2.25.1


