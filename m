Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD507EEB591
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 11:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7077B10EB4D;
	Thu, 12 Sep 2024 11:31:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="44Bq1qbK";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A27A310EB4D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 11:31:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cH+EaFfezKPzVs1Sp21f9ZKGmIvrFWbPLb4GjBqRJ/u2A34Up+k8kfkkhBdwqfI0XYZR8HJ4WiKuZ3sHYMCrddUd+O07c2KeKu9ZrnDJdSJNoDdjvGyatDUw3HKO+v/tcOyU1xncCjFwRMjW2pe5GIiWHr95PMo7rDq+z5ZbBQ5W7DNtYHOAaOKK5uSO8lj5Wt5OdGFkWdgfqSpldyITaonPYpm/m8HKLfNocMtuyjzhAW4Z8LZvOhsnE+AQBryuw5swjhKxhPBl1CGTZy/0uuHJuvKHTOXJrvQ3qj8clpzSKEyrWJBj84wdEILJmE2uczDsCjTY+HFTd3CARnfXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQvr7yJudJRSK8++XXEvYZQRu76NHHk8p2lxrBcSuXs=;
 b=Itj1ZCLlMlY20JiKkv0m+LodN+fujMlODTRnHyIHDpxNbYtNVVYgVRuH63fgsxhvWkXzexku7fZYfql1TuQJvNhYFDCD+o5Rhawk4OGqrhNxuJHxBO6FKbVFEH2DdlsHLd7FIkAG7D7iCUtLo0+djtiM65MMWrzfYQKr9DVshaQSDys4idq4Bj/vhwo4gSCJCmM4BKPZ5AGMoatcX37mdyiXMhJ9bbt39yaL2FS3vG+j9CD/QeDIGJlekB/AbfAa221DZLyQ7KiDa9TDzx2GUrEhTqL0RvlcL3HRQCC7A9lUT8JjGCNUwHwnWms5IHpNC6+AGNine2IiVDFjX6yI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQvr7yJudJRSK8++XXEvYZQRu76NHHk8p2lxrBcSuXs=;
 b=44Bq1qbKldNgjRaEoxfXo5ItfIh1jCmtnfp/aWKk4FHcM5Jxb83zvX4Jc9dNcOkeFP1V1inKxT4nwnb3Sc2JxBpwTLFgSzHBCfDlPH2wemHyhZoCG7nbKdMhfhDnEbIha7XAm6+0WeM79loNhBGbH27J6TZ0Iq4GBMQGELuyxnU=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.33; Thu, 12 Sep
 2024 11:30:57 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 11:30:57 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix XCP instance mask calculation
Thread-Topic: [PATCH] drm/amdgpu: Fix XCP instance mask calculation
Thread-Index: AQHbBQR+Rv3EE9s5cUWqIRuE/INmBrJUBCzQ
Date: Thu, 12 Sep 2024 11:30:57 +0000
Message-ID: <DS7PR12MB6071EFEDF8E27E986E4AFC348E642@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240912111058.2252065-1-lijo.lazar@amd.com>
In-Reply-To: <20240912111058.2252065-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8ff26e0e-f6ef-460e-80cf-2e0d4c63a3f4;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-12T11:30:01Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|IA0PR12MB7673:EE_
x-ms-office365-filtering-correlation-id: fae6a63b-a89b-4d8b-0c37-08dcd31e5ee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Mfjq4ovhektpuxnNg+aMn/s9vup9vq2Sw32hS4ojbdVjNPBfn5OjWy0PWwT7?=
 =?us-ascii?Q?uUCmHVh1giD/rU2YgGgKvn2cPv6/NqI2Y5EvBF4cbF1MI7sO5Mpv7XhLMqZw?=
 =?us-ascii?Q?D2n071yEAs/mgQxCyMwUs/wgtLhAmr7CWtOYylfSnZs6DVp7iNnzSEbXeAil?=
 =?us-ascii?Q?v9AG3GBHK58oHMVKoYrw/6PyIpNs7RjnHtVPWfkolxZo99iUnNb/pDyDTO+i?=
 =?us-ascii?Q?4lbyCd0Dsa7fTZ+mVngdlZsDE4eoodYeteZGVFDqKl39M0i9Hd/6OwV1VwUh?=
 =?us-ascii?Q?pvBtGzjyAw6GmlFjhFDayrNd4dCRqyVod8AsN4qom/hVea3Fxk/jMKsk5WC0?=
 =?us-ascii?Q?2NlkIJnro0Bkp26t8IVA54JM85notLg8iqUMdQkCilgN4Oe5Dnr0BUUJ2uyr?=
 =?us-ascii?Q?9qOw9aOePIjbsiCe8+PAfV2h3XtL3mNF55ooj69ZOMx7gHecTBdGfD3UIJ+I?=
 =?us-ascii?Q?xBvZtNjxK1IFda51ohJ+pgf1N3sRu4bUrvYryogEy7HDNx9TQ3uDVXcHGpgd?=
 =?us-ascii?Q?uo4XLpHSeBzIa52jSu4an20yBcFzFnz072tsMkeV63NTsFvk3P49JB6LDafW?=
 =?us-ascii?Q?BzJItj7P8ZyIm2tkHtvfNuWs9fkuwp2RH4OHehTm0pfrdAhoMIAUAwjG54rZ?=
 =?us-ascii?Q?mUQhHdRBc1ySG30swRwzUJJu7H8Lhy8Zn3sJu3p/cFtDwFOXG34Ezpo/vfzX?=
 =?us-ascii?Q?0dc8Vjf44MZvuJAaFPnLGK92WMUcCNQIEZurtbatGrkE/+mmypdOCoVc5ljh?=
 =?us-ascii?Q?dHrBUMMPuU7tCrayJe/cHvcC//N+b3zEfp9vBiePRaXr7R63BufWthX0ERrX?=
 =?us-ascii?Q?+dFhenicJT18Xy1AQt3ujzYefxbRjhS1ZSGVBCyfYEVvFKymJ9suudA4BoFq?=
 =?us-ascii?Q?odjALVpQCcIFY9udIHoKJGbv5/89Rxjb/umcYInc3QB51IUKzbPT1IXTpBGe?=
 =?us-ascii?Q?0c5b4zca0Kf7ALvijvk64+YARr5tCArf4Wh+9nPhpb4hpJ8RZ4q2mnYeXSdx?=
 =?us-ascii?Q?BSsow5MMZP1lfrbiT7tzzTqM608DAu20e4LVnIlisdgrsArlvkBt0zg7ejxz?=
 =?us-ascii?Q?ditbQPtqIA/unwgFYSgawRt96Cnq6pMwApmm4Uku7B/xNvMFYxSSQ7Aith22?=
 =?us-ascii?Q?eOjsMYFy0vJr25OUyLBI7O6mCeg+u9vXs1O9B+oHdhNr6JZxA2VtVd0iqUY+?=
 =?us-ascii?Q?w7Kqp47CWCEt78D1Xy88AGfsoLUhjaHDtiayXqcU5Nwm67jH0qoi5jr4Clxa?=
 =?us-ascii?Q?ZGB15aWtFbknXtLBLVDPOcRS1S9OeeuwDjuGs2NB02OawE1/XhNdax38WK8B?=
 =?us-ascii?Q?OA4QBIKQiYP4KFSSpvBZHo/0OLiASZNsrvrQs1/b/llYu6tS3isAyl694hE8?=
 =?us-ascii?Q?g717aLi6L6igBfcyQytiZQO0auX7pu9O9MCJ13Ix9s1eObxkCg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oNjJxluiDDyWu0mTxhRdSxajEG1El4GBjvtwaZm1nRihabYrCvYZPkKg+3oA?=
 =?us-ascii?Q?xwo7yEjpBNnLTRVhCnjvYd3W3SFxcrk3kmoAcqHLXVnPlaLwV2AjpRu6NEMP?=
 =?us-ascii?Q?WebfinTBH9bDYoM1D4vEZduMyJmVLkp5Vv00iih12iBNT86LnOZ4u0z4DLUU?=
 =?us-ascii?Q?I+VBbQHxbJPHkZBUPKXitOV4F2EvTeErt+rUpqCwuXakialOtX6Ixs8R3J/l?=
 =?us-ascii?Q?zqR/XJAJsHYftUSJ4Gt5G44pVK1hgC1eRuVWWxuqjIRXcmQ4qrMPKfeZp6tn?=
 =?us-ascii?Q?eTtojiQ1PueLp+wWbX+xH0qiVT57X/4I2+t58dGidLdwdQdoA/M2Nj5Hm3xT?=
 =?us-ascii?Q?sfW68lENP4h8AfawZplRexPjPQmxtVmEJdMzZTpFUWxu6zL+dUdtXxuECpOn?=
 =?us-ascii?Q?Q04WlI+vu/D4lr1bqgkwgn4wPV/EPt2whbTLDFn+j9dpPh25Of/Er2aT65W8?=
 =?us-ascii?Q?glIq1ofSg0bdGfH8/wyqIrVwZF4VjAxR1ENf782Atr4Dfe0FxTdtP9m9NVwk?=
 =?us-ascii?Q?hMu2xxj0ztnm/ULVoOaWZtoazFTw7EevLVixtuh33tqRNGgt4eKXg2clgpi1?=
 =?us-ascii?Q?yxV1Rmt2w/g3mkEbhZG/ZVQ1Ibe5XtFjYdhVXVEwUdL+PG1lU+E+jg2awT+p?=
 =?us-ascii?Q?itENfW9jDvAMdjeH7GWBZ4GCYLvqFabvC0wNK4kZR/yyhOk+JQB35e7g15Ee?=
 =?us-ascii?Q?/nkl932MUB6j36h2zmsjbMi3q/Q+krh52C1bJNw42v4ZIz3zgk3FQiHXNILW?=
 =?us-ascii?Q?uje6qEdHJNtNG63GNW5GkYr6A30SGS5VECiPdCROLTxHZF/KrTb04ZQdTumv?=
 =?us-ascii?Q?UANM4A3SnQ4JMZTbTrrWXn3dDQ8lxArm95R385XyxAZBxy1ja/5GqoAs3ax1?=
 =?us-ascii?Q?h/X7tBypPeIHFsH+JXsqH9N4VwSkdEPDzy+MV0co+ALxVFW1uytOynXcsJWY?=
 =?us-ascii?Q?S4m9hX9SFfO8G4M8wqyF70N3tzIfBVDa49Bh1U4EbdNWx+dn/7vVBB+qO6JO?=
 =?us-ascii?Q?6qIoXiVXsyPeBDxx/WNkS04RJkQCLh5IL2znv6R4j9j/p84a93UsGmyq4dSi?=
 =?us-ascii?Q?+RzyzSHFIPdAv7DZgkq0jcePvutB7HwaXPy3ZM0gd4HNAsc5rKYnz6anQzV0?=
 =?us-ascii?Q?tUzYhBdErfrUhmbdfTlqViw7PViNBQ1PBJDRu+tSWt6n94kpwtRqw8g77/C6?=
 =?us-ascii?Q?/mZy4khHM+Ode5leMEgQ8uENsF4ZElBgFV4R4roc9sKtrbKsS9BdO/MA347M?=
 =?us-ascii?Q?2hPB9+RhnYURt4trRXVD2tY3xKqfJE28UYP/uIcSZ5G4mzZnqEuXQB1icSQe?=
 =?us-ascii?Q?8+9qYyKRH4UtpyouNMMgsfoQM43L+CxtlBi2qjdLjooI5CSxw8a4q3bZYR9z?=
 =?us-ascii?Q?kmMQU5m6CjNdrN3rcWGVO539NE3IfM9/wycurrK2W8k5d09jb68l8EgZ7Buv?=
 =?us-ascii?Q?JNBaoGOmhgbhVN0jAA9oRuwwBFohCCIoSfodGetkuOWTF4F1ZwU2xqEJUo5K?=
 =?us-ascii?Q?6L494rKr0SZjSv1LcddaZZnyW1Ni0YpP0KTaiCoAkNPpLytFl8uilaKnDGjI?=
 =?us-ascii?Q?XLkl2JYwvLDgB8Qm0Lc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae6a63b-a89b-4d8b-0c37-08dcd31e5ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 11:30:57.3625 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owrB4fTXr3VyHXp0fM1h3ObXJh/vAygmSr4PUhyNTlULtGh8+vZYAvPz5q0ZCShjIapfQe8B59qxe1IkuP3UZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, September 12, 2024 4:41 PM
To: amd-gfx@lists.freedesktop.org; Kamal, Asad <Asad.Kamal@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix XCP instance mask calculation

Fix instance mask calculation for VCN IP. There are cases where VCN instanc=
e could be shared across partitions. Fix here so that other blocks don't ne=
ed to check for any shared instances based on partition mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 32 +++++++++-------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/a=
md/amdgpu/aqua_vanjaram.c
index 8381dcaa68e2..719f1aa6a429 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -94,8 +94,6 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_device=
 *adev,
        case AMDGPU_RING_TYPE_VCN_ENC:
        case AMDGPU_RING_TYPE_VCN_JPEG:
                ip_blk =3D AMDGPU_XCP_VCN;
-               if (aqua_vanjaram_xcp_vcn_shared(adev))
-                       inst_mask =3D 1 << (inst_idx * 2);
                break;
        default:
                DRM_ERROR("Not support ring type %d!", ring->funcs->type); =
@@ -105,6 +103,8 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_devi=
ce *adev,
        for (xcp_id =3D 0; xcp_id < adev->xcp_mgr->num_xcps; xcp_id++) {
                if (adev->xcp_mgr->xcp[xcp_id].ip[ip_blk].inst_mask & inst_=
mask) {
                        ring->xcp_id =3D xcp_id;
+                       dev_dbg(adev->dev, "ring:%s xcp_id :%u", ring->name=
,
+                               ring->xcp_id);
                        if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPU=
TE)
                                adev->gfx.enforce_isolation[xcp_id].xcp_id =
=3D xcp_id;
                        break;
@@ -394,38 +394,31 @@ static int __aqua_vanjaram_get_xcp_ip_info(struct amd=
gpu_xcp_mgr *xcp_mgr, int x
                                    struct amdgpu_xcp_ip *ip)
 {
        struct amdgpu_device *adev =3D xcp_mgr->adev;
+       int num_sdma, num_vcn, num_shared_vcn, num_xcp;
        int num_xcc_xcp, num_sdma_xcp, num_vcn_xcp;
-       int num_sdma, num_vcn;

        num_sdma =3D adev->sdma.num_instances;
        num_vcn =3D adev->vcn.num_vcn_inst;
+       num_shared_vcn =3D 1;
+
+       num_xcc_xcp =3D adev->gfx.num_xcc_per_xcp;
+       num_xcp =3D NUM_XCC(adev->gfx.xcc_mask) / num_xcc_xcp;

        switch (xcp_mgr->mode) {
        case AMDGPU_SPX_PARTITION_MODE:
-               num_sdma_xcp =3D num_sdma;
-               num_vcn_xcp =3D num_vcn;
-               break;
        case AMDGPU_DPX_PARTITION_MODE:
-               num_sdma_xcp =3D num_sdma / 2;
-               num_vcn_xcp =3D num_vcn / 2;
-               break;
        case AMDGPU_TPX_PARTITION_MODE:
-               num_sdma_xcp =3D num_sdma / 3;
-               num_vcn_xcp =3D num_vcn / 3;
-               break;
        case AMDGPU_QPX_PARTITION_MODE:
-               num_sdma_xcp =3D num_sdma / 4;
-               num_vcn_xcp =3D num_vcn / 4;
-               break;
        case AMDGPU_CPX_PARTITION_MODE:
-               num_sdma_xcp =3D 2;
-               num_vcn_xcp =3D num_vcn ? 1 : 0;
+               num_sdma_xcp =3D DIV_ROUND_UP(num_sdma, num_xcp);
+               num_vcn_xcp =3D DIV_ROUND_UP(num_vcn, num_xcp);
                break;
        default:
                return -EINVAL;
        }

-       num_xcc_xcp =3D adev->gfx.num_xcc_per_xcp;
+       if (num_vcn && num_xcp > num_vcn)
+               num_shared_vcn =3D num_xcp / num_vcn;

        switch (ip_id) {
        case AMDGPU_XCP_GFXHUB:
@@ -441,7 +434,8 @@ static int __aqua_vanjaram_get_xcp_ip_info(struct amdgp=
u_xcp_mgr *xcp_mgr, int x
                ip->ip_funcs =3D &sdma_v4_4_2_xcp_funcs;
                break;
        case AMDGPU_XCP_VCN:
-               ip->inst_mask =3D XCP_INST_MASK(num_vcn_xcp, xcp_id);
+               ip->inst_mask =3D
+                       XCP_INST_MASK(num_vcn_xcp, xcp_id / num_shared_vcn)=
;
                /* TODO : Assign IP funcs */
                break;
        default:
--
2.25.1

