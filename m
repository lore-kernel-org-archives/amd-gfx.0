Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E316C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 14:54:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB64810E31D;
	Thu, 21 Apr 2022 14:54:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 217C210E31D
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 14:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrDCYWQGTPvKoPlhKzsoWG7dhxMbEgR07OHd6/WSqeFDLO0MCY6GVHpeV0tM6yYTX4cwtcRKk7RFRJsdr5ARD6xBfTZoWClHc39Gxuo4wAKzQQcyCdY0aQoDJg6+wuMY+L+OP3BzQJcEK41XKDtZtfvSf4t//dWRsonSiC1wF697BAo6x0+iJmmBfk0XIz4KVI71PRzrzrwGTTjSsQWc2G6ARpGXPW55lYtvs/J9YfUA+LVvUBxHzZiZlf1JYH/UHA+Xye2qT8lHN1howc2HVW+QidUlMs/Lp5bhackcolCrLLb5SDsA5ivNkwXSNl2t604lyuiebbUE30MrvXqCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PSA3gNKBwuAGvMKN/Vt4stuJG3JpovlnvFy4t3n7UI=;
 b=iJM6Q7nwjKrtTVcJCdZKmMSHE2BsDLg8fRi0oqvpq03MWkUsRWgeMDpDCC0I5ex3/rd1t72HZBdb8+WCnpowqXunr1/ip8F9dISZJAm+btWmSuULnLKBNQuHCK+hWGhSTc/HRwLz7oOzLbFfJlYQzyJPJBM7YBVD26XZEx7oYjGJjpLzwBQgaO2sDjbntQzdPHLZVtEZeML5ibMbpCxR3ajCJYEumImdLCmDvjga3JCn9/NDSfxLL4objaBbAvgUhDqqtOe9lBBHCVNiRhX9+HF8YXbqv9eZWFHhIdJ5zqG8Tb7uXco8Dup6CPDkzK6A6ThQ052MWuEOaqdmUdRy2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PSA3gNKBwuAGvMKN/Vt4stuJG3JpovlnvFy4t3n7UI=;
 b=PshmU/HsFo9F2XqCR8N46q4nHs5wZVyj2l+yI8X6qaPC/WLgpzw/llNJT2oncddMa8xxeBEXEMZbZ12mu4glUSHMYe2/4mQlHe+TicUratov52OjjQJX0oCFs9OYITjG+R7j/eDX8274a8d7qouk0NWNSuku23h8vig3SPbFmr0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 14:54:13 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::a561:6b71:55fa:ed2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::a561:6b71:55fa:ed2d%8]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 14:54:13 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Ziya, Mohammad zafar"
 <Mohammadzafar.Ziya@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: add RAS poison creation handler (v2)
Thread-Topic: [PATCH 1/3] drm/amdgpu: add RAS poison creation handler (v2)
Thread-Index: AQHYVKoM+fKd+ObatkWbJAquxwxDNqz6Z5/Q
Date: Thu, 21 Apr 2022 14:54:13 +0000
Message-ID: <BN9PR12MB525799E8EB8215726022FA05FCF49@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220420113009.8062-1-tao.zhou1@amd.com>
In-Reply-To: <20220420113009.8062-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d633df3b-aa92-4fb5-8209-d1ecd4d95b9d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-21T14:02:45Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 352bef73-2da4-491a-c575-08da23a6ccce
x-ms-traffictypediagnostic: DS7PR12MB6264:EE_
x-microsoft-antispam-prvs: <DS7PR12MB6264FCCC5A80214B2722B74FFCF49@DS7PR12MB6264.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ciJ7G7eevY/19IAnOwWJPJ0vIrLvgPnR72URzvb6/iXm0Ly7eleBRjXyVmn6nf/g8pxh99G/MoBjwXf4g5McdK/w+57lITbedwkxIDZSj0Ra3zdmAIk1y7iZJBsRFkDmyEa4T77uFDpc/u0ALeKo0iTf+XPzQUCF38biRMb3g8FCyUBmZdyFYdtBbbkVLzgcY/PUxTZ/uvmaWKneYYWQVGLrUcMF68Z4tkx/SRK4BAwD9+RtOpqbl+PebrriwlRrZxBAvBz5bxwYBgtqiHS3NBcK+p8ITDjMZ1YDCHZSKSVz5xTrSWDtSeZipugvUSTYy8vG1Wtu7jMFyvzB+dB1vTG88qajjhQs9meDcGwW+3kwX2p1SwE4nm5QZ6Y6x5OywCpFSjwcCH5jmJ5g+YBbbgT1nLb+20btiQMntR+sBg93OhNvEXGXOUjRC0hA6Bvw3F+xzWSkCc8zHtIM3Dm1y55t57xYANVtDwYc0d/2eCi1i8lDs1vPSZ3OwFv2vnpcRDx5jiLR0T3x1kbFNvKlClbSyHSlte7qAaA7DLtoy8Eb0MnmhY4hffo/LcA6dUKS25+waZw7QQ2qI3jeJVLXtZ0sn4uW5wAFQCH7pUwTxZa1ioxISi4+tQFekHTUktHvIXozjUzLZNNS7gdknt6spYyBumiAARX0nPyGIZPUlTJxhxgofMo874wphXseD7/sj1Ue5ol9iX81uqzba9PYJFsCneDxPyW2AdkfgT1+dYM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7696005)(26005)(71200400001)(52536014)(86362001)(6506007)(38070700005)(33656002)(508600001)(5660300002)(921005)(53546011)(2906002)(38100700002)(8936002)(83380400001)(66476007)(122000001)(66446008)(9686003)(55016003)(66556008)(186003)(64756008)(76116006)(6636002)(8676002)(110136005)(316002)(66946007)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jKLg1y/37ust17Vb92COG5W1wDyP2Uw/BmSL3a6LgG+9IcqukxWqAPC0Zo6E?=
 =?us-ascii?Q?PuU6GtjwsYqDAfPucPHZ0OJW4FRJxjRs1OEQdxnCTxvJL7s29S8o7Uz2z63r?=
 =?us-ascii?Q?FrMdF5CyTxjpYDGfJhAaaAjHm5eKn6znwL9muv7exiEB216sePh17dZiv7Oe?=
 =?us-ascii?Q?jU7hvkcmBiSdxE4NmecoYjVUPsKM0CQAAjtLnFfWTHaRSk0Zw09HsF8nx2dp?=
 =?us-ascii?Q?uQgtGaxSFjhrEyx+V1qsQ0VS2TFyZJnUd6TyFifKU27gqTZNBEttE22AMoZs?=
 =?us-ascii?Q?gkS0dXnUih2diKcya5b7zXzxPA4Kk0isR+3HeixPaf2uHdalir4od8/BxWNK?=
 =?us-ascii?Q?YPmrhO+irfLPvtlNOrdzYhUHDoM555pdsv4xnnQCMbsnzZ5p/dcdo68HzHUg?=
 =?us-ascii?Q?h726Xs1reOvHPMjrPLmZ17UXVgItc/iyfWt+p8akB6aegKl8G4QSOet+XIMR?=
 =?us-ascii?Q?bzhVqeGSWA2DbQHlkCARgLyhhvA6YmpfHEUIvNykTldWCK+cVcDSMzFTqysK?=
 =?us-ascii?Q?h2I0CgllW4iOt1JnP+Li4taEBHlWkZbf/4uI0Q/jv5Cns79ozyuFVXLOuiUp?=
 =?us-ascii?Q?XJKP2ikZNoJfoYkaBSjSMFS5QEar08aclfLq5xrhXBrnqWhrtCzCOAWjlGJ2?=
 =?us-ascii?Q?wAthx1JMVm8yVO9F6IHE+bG8nSV782Egxll6T0T/Kc89ewIQYNZ8Yi3J7894?=
 =?us-ascii?Q?xuMXyAnweGXurdgLlyKZXRv2cRjAqpgBQSdp+xZ5146fvVPZ0z3v8vm1lw7Q?=
 =?us-ascii?Q?SuR+9b/f+Oa0FapNXblNiyBRU7i86TzIDg5eg88oy1YQe60Mm7as9UiW2gfl?=
 =?us-ascii?Q?SpOud6I8dd6uhYEy990mdh8HgFGTa0i8ib+o1bmABAaJJ0ViMRhaqx9HI2Cv?=
 =?us-ascii?Q?NJLy+u5WOoDr6kfTu1xh0zyRjjUhKnwmqmPcPDkPI2GFFuKBmsfpuojpfilF?=
 =?us-ascii?Q?Nvq6tlMySudlhPlAF0Aa6cZxKimU/XvXdAHnIfBDL1YceY6WwFiDeVINc/cE?=
 =?us-ascii?Q?ZE4tJtDRITJBUBsaDCMP0wDIBWfLNCSp8cLsX+3O4YWCye4z3a7Jw8rg/By4?=
 =?us-ascii?Q?W5EAstiZgeBiPcwWqf00VR6jT+fDOVJRFYZVkp1VnJbwCoCNFWp+2knPldvp?=
 =?us-ascii?Q?FbBdnG12KrU6YzbbWTMFKlQPcskwrZbs3uZMcPcHL6i8/k5WRe9hGD9+ngwE?=
 =?us-ascii?Q?XT0ZzlibzbadaUvgsW2jNyIHs1AWb72o6KYfxdfo8A6hv0Tf4XbSl+LatdsF?=
 =?us-ascii?Q?gkSqJEtINqgiX8R6AKoxB8S6/j08EesmA/xnzskPpnJLOGxp7vWNUTayQHxm?=
 =?us-ascii?Q?YqS77RYjGxNr51+5xN4A8C3HB2+Y9PjCLdzwXBSB+qYesFlCxD0efhmv/FDI?=
 =?us-ascii?Q?PdD+mht8bMJc4lIGXpCUKTz3aEdHHA+K7HpYR8Eoe15SHrUHfNjPGKfYIucm?=
 =?us-ascii?Q?zY7LuGfRyAIL/YU/QMGw7DUshHWEidVM5fqrtvWF2T3Fk+76bvIPM70g6Zsy?=
 =?us-ascii?Q?o8du9ctRFlR/BsK1LMVv3h+DN5uaszwNXCnBDRXTwDDfT03H1P1fzVmqscSS?=
 =?us-ascii?Q?HNsmHZLhgJuyfBACEnRdqrxtxI4lWJr737HxuSc6GlvHNaRm6u6UQHCxYMTc?=
 =?us-ascii?Q?pdMnIVMm34suftDzMgwqMRMiHjEqRu8u+57Ti+qu1zKiHOU41/TsU+WVpTlb?=
 =?us-ascii?Q?gbJpemSNN7d2D+VbCf2/hta/8jWjPCKmoUOYAt1H1SVH0wnr2vLqIryKKEPa?=
 =?us-ascii?Q?y4ajirqQVg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352bef73-2da4-491a-c575-08da23a6ccce
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 14:54:13.3524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqcQSR6PN8YsT6antC1KYAxXH+HHJiUZULE+ufwXZvSp+7a85rqU35cisesYf14nxMK8dPkbGE5WaInaoqiuCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Tao,

I was thinking more aggressive change - current amdgpu_ras_interrupt_handle=
r only serves as umc poison (poison mode) or uncorrectable error handler (f=
ue mode).

We can still keep it as a unified entry point, but how about check ip block=
 first, then if it is umc, then check poison mode to decide poison creation=
 handling or legacy uncorrectable error handling.

As discussed before, we'll optimize the poison creation handling later. so =
keeping poison_creation_handler and legacy umc ue handler in separated func=
tions seems right direction to me.

Thoughts?

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, April 20, 2022 19:30
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ziy=
a, Mohammad zafar <Mohammadzafar.Ziya@amd.com>; Chai, Thomas <YiPeng.Chai@a=
md.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add RAS poison creation handler (v2)

Prepare for the implementation of poison consumption handler.

v2: separate umc handler from poison creation.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 70 ++++++++++++++++---------
 1 file changed, 44 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 4bbed76b79c8..22477f76913a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1515,12 +1515,45 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device =
*adev)
 /* ras fs end */

 /* ih begin */
+static void amdgpu_ras_interrupt_poison_creation_handler(struct ras_manage=
r *obj,
+                               struct amdgpu_iv_entry *entry)
+{
+       dev_info(obj->adev->dev,
+               "Poison is created, no user action is needed.\n"); }
+
+static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj,
+                               struct amdgpu_iv_entry *entry)
+{
+       struct ras_ih_data *data =3D &obj->ih_data;
+       struct ras_err_data err_data =3D {0, 0, 0, NULL};
+       int ret;
+
+       if (!data->cb)
+               return;
+
+       /* Let IP handle its data, maybe we need get the output
+        * from the callback to update the error type/count, etc
+        */
+       ret =3D data->cb(obj->adev, &err_data, entry);
+       /* ue will trigger an interrupt, and in that case
+        * we need do a reset to recovery the whole system.
+        * But leave IP do that recovery, here we just dispatch
+        * the error.
+        */
+       if (ret =3D=3D AMDGPU_RAS_SUCCESS) {
+               /* these counts could be left as 0 if
+                * some blocks do not count error number
+                */
+               obj->err_data.ue_count +=3D err_data.ue_count;
+               obj->err_data.ce_count +=3D err_data.ce_count;
+       }
+}
+
 static void amdgpu_ras_interrupt_handler(struct ras_manager *obj)  {
        struct ras_ih_data *data =3D &obj->ih_data;
        struct amdgpu_iv_entry entry;
-       int ret;
-       struct ras_err_data err_data =3D {0, 0, 0, NULL};

        while (data->rptr !=3D data->wptr) {
                rmb();
@@ -1531,30 +1564,15 @@ static void amdgpu_ras_interrupt_handler(struct ras=
_manager *obj)
                data->rptr =3D (data->aligned_element_size +
                                data->rptr) % data->ring_size;

-               if (data->cb) {
-                       if (amdgpu_ras_is_poison_mode_supported(obj->adev) =
&&
-                           obj->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
-                               dev_info(obj->adev->dev,
-                                               "Poison is created, no user=
 action is needed.\n");
-                       else {
-                               /* Let IP handle its data, maybe we need ge=
t the output
-                                * from the callback to udpate the error ty=
pe/count, etc
-                                */
-                               memset(&err_data, 0, sizeof(err_data));
-                               ret =3D data->cb(obj->adev, &err_data, &ent=
ry);
-                               /* ue will trigger an interrupt, and in tha=
t case
-                                * we need do a reset to recovery the whole=
 system.
-                                * But leave IP do that recovery, here we j=
ust dispatch
-                                * the error.
-                                */
-                               if (ret =3D=3D AMDGPU_RAS_SUCCESS) {
-                                       /* these counts could be left as 0 =
if
-                                        * some blocks do not count error n=
umber
-                                        */
-                                       obj->err_data.ue_count +=3D err_dat=
a.ue_count;
-                                       obj->err_data.ce_count +=3D err_dat=
a.ce_count;
-                               }
-                       }
+               if (amdgpu_ras_is_poison_mode_supported(obj->adev)) {
+                       if (obj->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
+                               amdgpu_ras_interrupt_poison_creation_handle=
r(obj, &entry);
+               } else {
+                       if (obj->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
+                               amdgpu_ras_interrupt_umc_handler(obj, &entr=
y);
+                       else
+                               dev_warn(obj->adev->dev,
+                                       "No RAS interrupt handler for non-U=
MC block with poison
+disabled.\n");
                }
        }
 }
--
2.35.1

