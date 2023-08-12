Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A13EB64DD
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Aug 2023 01:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF4D10E00C;
	Sat, 12 Aug 2023 01:39:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7615310E00C
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Aug 2023 01:39:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jE+BbE+37MMHs0XxQbv1FWmfuASWw/MRlw9pk5O0qc+tSPiCVKhTwhwTuRoXbcGYk/WOTvkKWBgCcwCS5ylRBSDxZ8IVPANHqV48w9Jt4zJD2TvtWlr/9J7z8TVXe+d+CcZOQ43g9zas2WuDtD7nkeC4VBIMG3KzaLq8toIiAR85DlM0ww4irB37SZK+ZwG+4PgPZQOH1ZceMFcwum+tVVOeK4D7g9HqwGT3AjXRqlaIxLLWTkoAu+iuHa3sYPvfWYymY6MMEWR1fCq7zYtqKgI/pOeUark5XeD6iCnnUBqZL5AlSGW8OqLhiEv4MOs4aMQlf6+cgumUB26KAlOOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deeT5W/aMSLNnOyNJGFY+ILrcv2NrzW+IhSsfnFy/HQ=;
 b=PMewg5K69RGvbgW2kc379hRAhK+Tj/Dd2+KEnUv373knpjKznUla+Dxef8u83QOjSphFSXsw9y7FITJhTDJHzQcWk5//ywiYIBLcP81xtUC61RJ7mSRpNFMUsQxJA/nnYUrsC9s1+ozjemDYKDxvYYE2aPZqgiCYG5dWJvwuJm779jMtGO6II5jxynHLrZPZNxX1gRMUycsr5AWTzvLQNiYMrnSUTVCYJBjkYSXI+NJdjwOXfNB1HpoUGCYNvnbBf0BneBG3CSyDrPaDY0k/daJJz5L0tYqj8VzU7yVINsd8yI7GtkmQezx1lto2JknWWTnu2b9enZsJWOVE3nOY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deeT5W/aMSLNnOyNJGFY+ILrcv2NrzW+IhSsfnFy/HQ=;
 b=d3XqzOgMEy2zyG7i6SWTmSr7AKf0KiMU739MbudDzyWynAPwN1zZK7BihedW9OYIzobMhJ9kCwpiEKfVLnzDVbtleuV0IDb+mWrT02INp4O06qBVpPsX1PRc/QUAUyuYFRY9tLLG8BxgqMBQUq3K4O2/AGjJpNc9YXGzWO3GQfY=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ0PR12MB7083.namprd12.prod.outlook.com (2603:10b6:a03:4ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Sat, 12 Aug
 2023 01:39:38 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%4]) with mapi id 15.20.6678.020; Sat, 12 Aug 2023
 01:39:38 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/amdgpu: skip xcp drm device allocation when out of
 drm resource
Thread-Topic: [PATCH v3] drm/amdgpu: skip xcp drm device allocation when out
 of drm resource
Thread-Index: AQHZzJe+1h71pzzt4UuSY9sCNNJDGq/l4RcD
Date: Sat, 12 Aug 2023 01:39:37 +0000
Message-ID: <BYAPR12MB4614B9FB9A931ACD336212929711A@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230811202337.1867891-1-James.Zhu@amd.com>
 <20230811210627.1888328-1-James.Zhu@amd.com>
In-Reply-To: <20230811210627.1888328-1-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-12T01:34:29.8661261Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|SJ0PR12MB7083:EE_
x-ms-office365-filtering-correlation-id: 9242ea7a-6de1-49e6-a2c6-08db9ad4fd82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sSwl11Zvi5ToxEoHKQR3TzJsy3a7t9MnP481wJJN4ujV7ja6jWUEvifZqlrx6lvBKTx/1q9KWTRixoQA140z+q8apcGK+sW64HN/XxNe6emgfIJHTuE9WLftQvilPVC/U+qu6N75DWptIenf9xQmuJgO9eY+5Sak3sEHMis+Iv9jchoV5J0pkOQoFW1NQFsJZniWfNqu7Mg2f2xYbYr5Ib6jJ+LU965YQXqakVugp1OMb0gYrmiEJkSmhrZZDkmP5oOBuvBTsD6L3gN70sZa1KCi72iUu77qjR9p8Tr4+gM41LSD1XGv/vK7jcv5MgBLiVq8B/QQMCqMWMGppmUpt6c7JsSOczeeYA8LGUoDTDRDcGZPiub2eso3G7I0n9phlRcu9IJEehGxiPyVOMILKffzCaFku4QuhUem9Fy/l4q1TvGXN/Gd8YXIxzQe5Jxi3npdUFhxjwYU43TZVORl/LMatoIE9/QKCw2hqataHChXb4COEyfmDIER+PjS6OJPpyqmNNyk10qQD2znTF88w2p+cli2Kxg5BHVNW2zyR10WtSFji6g8SXZhN4hBQY3J9YZRUwAUxOF+4x6D4F9XkDvdFoazNUZz3hBFnWay5hKrHOfOv7TYNk0dUaOupdiRMSmoAqSRJe6Hvb4UuUBg2Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199021)(1800799006)(186006)(26005)(166002)(66574015)(478600001)(54906003)(316002)(110136005)(83380400001)(71200400001)(966005)(38070700005)(7696005)(53546011)(38100700002)(122000001)(4326008)(64756008)(66446008)(76116006)(66476007)(66556008)(6506007)(8936002)(8676002)(41300700001)(52536014)(5660300002)(2906002)(86362001)(9686003)(66946007)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ugXa6jX5WaIEJZnI3IJymLeazYikw7hotN/sj7SuzyFWhgG8Qfti9YW+hX?=
 =?iso-8859-1?Q?fOKHe5/nPXcUwUfQXItcb90Drb0zgrB4gkhpMH8xTciG+SJ6jZSTxo/7ea?=
 =?iso-8859-1?Q?BhqfyFLJ7xM0O2HAaCU5aqZAa3oyrI3+pu2E1LAuXpuHGNs7uXgnQ3pJe2?=
 =?iso-8859-1?Q?Fo1v7P8aVgB/YxAw3m4+4YE0hNnKTMmo8ssOguXidWJcDhm3MlqQZWH8OY?=
 =?iso-8859-1?Q?VRQ5eUX/T1RbtdbhF5RqLPElsvT/OqiKGEQCJRRjqPjBm4a3aXgnKCYAdR?=
 =?iso-8859-1?Q?qM1UVwFT6/75PwDq+whbw227HDdDkjggtYnD8pFJSDauETSR+OGEagt52L?=
 =?iso-8859-1?Q?jpzng6BCfBxAtu7R8ikgJysLmnzrY1tY2yEUIp5kxSd0ll9McQu9yprWWI?=
 =?iso-8859-1?Q?SYvZDS3uUq8zA0GeRsbmzfnGEsrf0OJFxrDrDS6DNtJQS8/eXuCFgV16Xk?=
 =?iso-8859-1?Q?1c2vqYhKHjwwosDUhu5K7/bkcbp6T712mcXT5anNPILwYiXGN8/IPcPaam?=
 =?iso-8859-1?Q?UxGcxzk03Ma9HLxq8O/HhNJaIZpwTVKhq8nKRN2IaS451xMxbcRn2iDQDM?=
 =?iso-8859-1?Q?tKrXM2xd8qsyAN8/tANT7rTtjqDm3VMouZoS5R/m8LzTnlwdGI2fTgu5tT?=
 =?iso-8859-1?Q?onnXznaE3eB+KtiZnyCptVB6prvDvC5Zn/pAzfeJ5cxmfZl04wvk+AY1tb?=
 =?iso-8859-1?Q?4rbjq/aBXlgjB73cAIrMpshrBeLUmMHDE8G8hag5E/jo7OWZFvwNfVV27C?=
 =?iso-8859-1?Q?CcvriSBXQ1LusHuFjYgmqHfTjyrVOXiEw08jotUBTntSlX6L1yYf68REda?=
 =?iso-8859-1?Q?dsv73yffv723SHobzk3PxzGQ4Hfu8FBu4w12CatqsU6+fRrlfAkrpPL9L/?=
 =?iso-8859-1?Q?1NZTVHuJjpUa/zonP2bWY82dXw3bzzCMpG/wxX1+jq8Fg1EdnvtKRcJrmm?=
 =?iso-8859-1?Q?kUNumb/sw/0V8h5VNla7Gchhrx4Oa1XRBO8QsH5ZtZacBCrN0UYKV0b12k?=
 =?iso-8859-1?Q?HloTQxiN9oc2fN3jcREx0tScKhN+PA1WAKGRd5Zo8ezxTr7tSH+CE1DFaw?=
 =?iso-8859-1?Q?ZzQpXidaKyHOVwodxXevjel30U2ysh2v100AV93i163ERlNBGaPO/nGCIu?=
 =?iso-8859-1?Q?uUaXR01tfsa0DMSVvGIJ7Uws2JbuHwbQqtw5WGH16XGifU54V1GrLBJNl8?=
 =?iso-8859-1?Q?dr8YM0UEoQSsHR16sU2/nq+GfUXBdYuBNODbnhrrjSg5JqIEL4XvEhF/qs?=
 =?iso-8859-1?Q?ZYcH8fEIf5/u2gGRUc/3ZJCwSyLRw2LdBpOEKkvhk9oyaZWBJHXBAC16vx?=
 =?iso-8859-1?Q?PPaaSC/PsWsudEgLs3DzHSPZbVfHY86sO8etUk4oC5Yw2YIXIb1FrdLpAN?=
 =?iso-8859-1?Q?AiNewlly5Lt3w3fluRyXrBaayPockE3F4Fpdt9gVcvz/x6J6JSUh5r0hfC?=
 =?iso-8859-1?Q?HCoTpAWEFW1srh5ELiQDiDzZ64J50xn+ld1VAcU059tVFnqxEQFE1Mse6j?=
 =?iso-8859-1?Q?XZdhFC5V5L4I8s2friZX97aqJW85hrQPtA1b5iL4m16bp9h8ODJAHKtcc9?=
 =?iso-8859-1?Q?zantMxWDI9Ncth4RSLC3vbse4zcN8zRmdX0IQYUYhLTLJv2YeouorwxBal?=
 =?iso-8859-1?Q?ZFbiaDSV+UCdrexw7fGQdBEkqA0rHxzOH1?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB4614B9FB9A931ACD336212929711ABYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9242ea7a-6de1-49e6-a2c6-08db9ad4fd82
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2023 01:39:37.9525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IX6d1bs5ptKnZRNQlFDwqvaynjQ3jF+hiSjprjJbGn9ruCzYgEM9Ry2V9I+GCQt0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7083
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
Cc: "Lin, Amber" <Amber.Lin@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Koenig, 
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB4614B9FB9A931ACD336212929711ABYAPR12MB4614namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

A dynamic partition switch could happen later.  The switch could still be s=
uccessful in terms of hardware, and hence gives a false feeling of success =
even if there are no render nodes available for any app to make use of the =
partition.

Also, a kfd node is not expected to have a valid xcp pointer on devices wit=
hout partition. This access could break then gpu->xcp->ddev.

Thanks,
Lijo
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of James Zh=
u <James.Zhu@amd.com>
Sent: Saturday, August 12, 2023 2:36:27 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Lin, Amber <Amber.Lin@amd.com>; Zhu, James <James.Zhu@amd.com>; Kasivis=
wanathan, Harish <Harish.Kasiviswanathan@amd.com>; Koenig, Christian <Chris=
tian.Koenig@amd.com>
Subject: [PATCH v3] drm/amdgpu: skip xcp drm device allocation when out of =
drm resource

Return 0 when drm device alloc failed with -ENOSPC in
order to  allow amdgpu drive loading. But the xcp without
drm device node assigned won't be visiable in user space.
This helps amdgpu driver loading on system which has more
than 64 nodes, the current limitation.

The proposal to add more drm nodes is discussed in public,
which will support up to 2^20 nodes totally.
kernel drm:
https://lore.kernel.org/lkml/20230724211428.3831636-1-michal.winiarski@inte=
l.com/T/
libdrm:
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/305

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Christian K=F6nig <christian.koenig@amd.com>

-v2: added warning message
-v3: use dev_warn
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c   | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 +++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_xcp.c
index 9c9cca129498..565a1fa436d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -239,8 +239,13 @@ static int amdgpu_xcp_dev_alloc(struct amdgpu_device *=
adev)

         for (i =3D 1; i < MAX_XCP; i++) {
                 ret =3D amdgpu_xcp_drm_dev_alloc(&p_ddev);
-               if (ret)
+               if (ret =3D=3D -ENOSPC) {
+                       dev_warn(adev->dev,
+                       "Skip xcp node #%d when out of drm node resource.",=
 i);
+                       return 0;
+               } else if (ret) {
                         return ret;
+               }

                 /* Redirect all IOCTLs to the primary device */
                 adev->xcp_mgr->xcp[i].rdev =3D p_ddev->render->dev;
@@ -328,6 +333,9 @@ int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
                 return 0;

         for (i =3D 1; i < MAX_XCP; i++) {
+               if (!adev->xcp_mgr->xcp[i].ddev)
+                       break;
+
                 ret =3D drm_dev_register(adev->xcp_mgr->xcp[i].ddev, ent->=
driver_data);
                 if (ret)
                         return ret;
@@ -345,6 +353,9 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
                 return;

         for (i =3D 1; i < MAX_XCP; i++) {
+               if (!adev->xcp_mgr->xcp[i].ddev)
+                       break;
+
                 p_ddev =3D adev->xcp_mgr->xcp[i].ddev;
                 drm_dev_unplug(p_ddev);
                 p_ddev->render->dev =3D adev->xcp_mgr->xcp[i].rdev;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index 3b0749390388..310df98ba46a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1969,8 +1969,16 @@ int kfd_topology_add_device(struct kfd_node *gpu)
         int i;
         const char *asic_name =3D amdgpu_asic_name[gpu->adev->asic_type];

+
         gpu_id =3D kfd_generate_gpu_id(gpu);
-       pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
+       if (!gpu->xcp->ddev) {
+               dev_warn(gpu->adev->dev,
+               "Won't add GPU (ID: 0x%x) to topology since it has no drm n=
ode assigned.",
+               gpu_id);
+               return 0;
+       } else {
+               pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id)=
;
+       }

         /* Check to see if this gpu device exists in the topology_device_l=
ist.
          * If so, assign the gpu to that device,
--
2.34.1


--_000_BYAPR12MB4614B9FB9A931ACD336212929711ABYAPR12MB4614namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"" dir=3D"auto">A dynamic partition switch could happen later.=
&nbsp; The switch could still be successful in terms of hardware, and hence=
 gives a false feeling of success even if there are no render nodes availab=
le for any app to make use of the partition<span style=3D"font-size: 12pt;"=
>.</span></div>
<div style=3D"" dir=3D"auto"><br>
</div>
<div style=3D"" dir=3D"auto">Also, a kfd node is not expe<span>cted to have=
 a valid xcp pointer on devices without partition. This access could break =
then gpu-&gt;xcp-&gt;ddev.</span></div>
<div style=3D"" dir=3D"auto"><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of James Zhu &lt;James.Zhu@amd.c=
om&gt;<br>
<b>Sent:</b> Saturday, August 12, 2023 2:36:27 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Lin, Amber &lt;Amber.Lin@amd.com&gt;; Zhu, James &lt;James.Zhu@a=
md.com&gt;; Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;;=
 Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> [PATCH v3] drm/amdgpu: skip xcp drm device allocation when =
out of drm resource</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Return 0 when drm device alloc failed with -ENOSPC=
 in<br>
order to&nbsp; allow amdgpu drive loading. But the xcp without<br>
drm device node assigned won't be visiable in user space.<br>
This helps amdgpu driver loading on system which has more<br>
than 64 nodes, the current limitation.<br>
<br>
The proposal to add more drm nodes is discussed in public,<br>
which will support up to 2^20 nodes totally.<br>
kernel drm:<br>
<a href=3D"https://lore.kernel.org/lkml/20230724211428.3831636-1-michal.win=
iarski@intel.com/T/">https://lore.kernel.org/lkml/20230724211428.3831636-1-=
michal.winiarski@intel.com/T/</a><br>
libdrm:<br>
<a href=3D"https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/305">ht=
tps://gitlab.freedesktop.org/mesa/drm/-/merge_requests/305</a><br>
<br>
Signed-off-by: James Zhu &lt;James.Zhu@amd.com&gt;<br>
Acked-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
<br>
-v2: added warning message<br>
-v3: use dev_warn<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c&nbsp;&nbsp; | 13 ++++++++++++=
-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 +++++++++-<br>
&nbsp;2 files changed, 21 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_xcp.c<br>
index 9c9cca129498..565a1fa436d4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c<br>
@@ -239,8 +239,13 @@ static int amdgpu_xcp_dev_alloc(struct amdgpu_device *=
adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 1; i &lt; MAX_X=
CP; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_xcp_drm_dev_alloc(&amp;p_ddev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret =3D=3D -ENOSPC) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&g=
t;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Skip xcp n=
ode #%d when out of drm node resource.&quot;, i);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Redirect all IOCTLs to the primary device */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;xcp_mgr-&gt;xcp[i].rdev =3D p_ddev-&gt;rende=
r-&gt;dev;<br>
@@ -328,6 +333,9 @@ int amdgpu_xcp_dev_register(struct amdgpu_device *adev,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 1; i &lt; MAX_X=
CP; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;xcp_mgr-&gt;xcp[i].ddev)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D drm_dev_register(adev-&gt;xcp_mgr-&gt;xcp[i].=
ddev, ent-&gt;driver_data);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
@@ -345,6 +353,9 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 1; i &lt; MAX_X=
CP; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;xcp_mgr-&gt;xcp[i].ddev)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; p_ddev =3D adev-&gt;xcp_mgr-&gt;xcp[i].ddev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_dev_unplug(p_ddev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; p_ddev-&gt;render-&gt;dev =3D adev-&gt;xcp_mgr-&gt;xc=
p[i].rdev;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c<br>
index 3b0749390388..310df98ba46a 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
@@ -1969,8 +1969,16 @@ int kfd_topology_add_device(struct kfd_node *gpu)<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *asic_name =3D =
amdgpu_asic_name[gpu-&gt;adev-&gt;asic_type];<br>
&nbsp;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_id =3D kfd_generate_gp=
u_id(gpu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Adding new GPU (ID: 0x=
%x) to topology\n&quot;, gpu_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!gpu-&gt;xcp-&gt;ddev) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(gpu-&gt;adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &quot;Won't add GPU (ID: 0x%x) to topology since it has no drm n=
ode assigned.&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gpu_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_debug(&quot;Adding new GPU (ID: 0x%x) to topology\n&quot;, gp=
u_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check to see if this gp=
u device exists in the topology_device_list.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If so, assign the =
gpu to that device,<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BYAPR12MB4614B9FB9A931ACD336212929711ABYAPR12MB4614namp_--
