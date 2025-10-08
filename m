Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D70CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 00:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C3710E738;
	Wed,  8 Oct 2025 00:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NFJMHW9o";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013012.outbound.protection.outlook.com
 [40.107.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7478310E738
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 00:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bP82FAumuljnVA38KPxPJ3eJR28BjuVqAn1OnPcjsdwMbgKRVHMP9v2jy6ITSeo60TAIm2iR3BK2ki0RWoVwjn8LeGSVTe3cCsTj9Y0KhcSINa/07WYc7qkvVUL+cL+24B6Qs6B27HfoIEM7HpxodH1K+M6gMw/4Cg5iyHhMqmvr3JTpMDL/LC3WVjLNCuSX1aMdiNbMV9eY6lSF9UCUlFgimPA+b5CEbRBw00V2GatrJ23lKk0mTRosICfVtALt6AblQ1HW+zpJJIsjQNAfVTOKToHiO096miM3lIaU4uUxqSft+r7TkfwmrT2FdSzi5vReIr8XGup9Rp+HIxnuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmFtlS4/uk7qPr0AsQM+E5VgFnxo60zKFxRLrOmvdm0=;
 b=m9iHlKz/n6KxZQqs2qdvUQ7q2mTBfrhE+Qdw6JRKt55x8+xzeiCA5JrFPRpiHrJnFK0ts0P+VbkDUV/5CH1cwxJCqEdDMcTmnMglhEGfOHD2XYk+gOXlN691EFSiwGS9dQZKS4jDzIaYxhCxMMH5Rc1aOxXgIp/dfJt89r6og2dknjjtXNoxG2cd+g6vhEZwp90+R4JoCmhzHki3r7eoHan9Haf/KeuTcUewZT+8AZU+Hn4vOY8n1h9QZHMR89PUXr3uiGv+bU5eny2ABz4RvX1Jm0WbYrE1VM9QPbOvnraO801ZozrUcmSHGnsE4l0G4wyQ46ViXt3Ltp99dhVKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmFtlS4/uk7qPr0AsQM+E5VgFnxo60zKFxRLrOmvdm0=;
 b=NFJMHW9o5J9cmJmocVXkJUK+E1LR+VS/4QBxJFQjrbMenvQxodBfgW9d4/2C0ZYVD4ZSCzWjLu2Nfrp7+D9SbCvYHEN8nB1pMic8MrrhBj7siJrQ9S7fvSWrognIxh88bYMDUwtlqaj27HOfowzGDJbVi79k//cuqIVK2md+KTk=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 00:59:03 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 00:59:03 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/mes: adjust the VMID masks
Thread-Topic: [PATCH] drm/amdgpu/mes: adjust the VMID masks
Thread-Index: AQHcNu66oogFPxNs6UGG3T3tjC7bQbS3bzuQ
Date: Wed, 8 Oct 2025 00:59:02 +0000
Message-ID: <CH0PR12MB5372CE8DABEC2AF9DBD16272F4E1A@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20251006182550.90535-1-alexander.deucher@amd.com>
In-Reply-To: <20251006182550.90535-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-08T00:57:41.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DM4PR12MB6039:EE_
x-ms-office365-filtering-correlation-id: 3e87a907-e31b-4f6e-b7b4-08de0605dfa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?B9c95DG2mg59g2srxlojZe5cz23tkZSa19kneUOjouq50StNfIaJ4WP2p0Vc?=
 =?us-ascii?Q?JxRlZWJiqj+MMRoaMbvfoZ9kB0E36HSKJuzHB4XXUtOkP7ytVQtL986GoUbG?=
 =?us-ascii?Q?IAYM7zRSX4SbFVCVCE8OjAs/yoLxKqJ6KQ0wuslDGm05lnlg1YHchzF94JIm?=
 =?us-ascii?Q?FWtyTocCP5A82J6aq4pCgVFTlxqeVhYhjKxDVuubMQO9JL6wrcmnfM8SXzLs?=
 =?us-ascii?Q?+Rm0nBkX4ml794ajfatZLruth/Jfzl7fb27Hd3nHAFTQ+Jbk0lYnvLo3vX6b?=
 =?us-ascii?Q?3RWtXyiPfsFWsctoKFN6oFNNpBGN7T2+QBOTMErqhNLYE+eHsKkla4zTTXl8?=
 =?us-ascii?Q?l34SNWZPKby9D4Lf6qVUtTfhnOsIYwxngX9Z5w57n6HaoiEvFSed8kV0sPid?=
 =?us-ascii?Q?GVMd/8VqtTkc1O+nwv8bEIZEj4IXz0dKMcLy7qrvuEU8ISqLjANxKdsJSS58?=
 =?us-ascii?Q?XaKfy8oFCdzc3jNzMxedDRlAjenpt4Nhu2XRFOQMquG7g3W07VTzobqmqbKL?=
 =?us-ascii?Q?kiTaRwVA3V2nxkVPCPAg+laP8T81lydtS0sabaMldMnLe6F7XB+J1CiRLNIe?=
 =?us-ascii?Q?lLHqwsTsE7nnp/0vmPPfXUKobE0i7Sj5O+g9VWHgme7oTI197Ipvoo38Hoax?=
 =?us-ascii?Q?JQqYH6/y4679UVsw/vlHNwHz7DyAQ0tNzUcmv4b4rk1DOF2IRD2veryy7ND7?=
 =?us-ascii?Q?qOurszdKazgR3ULOKm3Bp0se5AsrSzWBAJu7k/suBlYsxz/IpmiUM9EbhjGf?=
 =?us-ascii?Q?sK+8MdrdJcOv3mJ72WhTfdJWacNLnEnGyEIUQLhj6jk9lxs1ilgFdGfS3v0M?=
 =?us-ascii?Q?q6Y9jvMwGj9SU/aKFMnAQLf4kYPcWUINrrkAMMleHobmVStGuqgxFrQWQgxK?=
 =?us-ascii?Q?9BZsNSHd1If4VopRdr5CM3dHfqCIMyCfUrEw86w+wdhJap+QsNTm/RQX3Cte?=
 =?us-ascii?Q?mpPMA6kZRarHKZ0kGI6NZJh0W9o4o6wc6OqiQ5hbZLYydWlZPIFrkqew8rwx?=
 =?us-ascii?Q?RXCj22BvjxXEqSvb/9m6zC3BTKd3a6g20V0pcHMgKsiVQuqbJ1rOAYPFFTkd?=
 =?us-ascii?Q?QpdwLYkKP2aNMRAr2JouA4vdR1jS7Tca3dCsGHwW083BNkieEVjDMPy07/h+?=
 =?us-ascii?Q?iLsblfABszk0aposicyKkz0esn9lPRnTT7jSkrvSCQqU0F31Zo9cgcyzSCTG?=
 =?us-ascii?Q?fG5t58YaK/Hj1p7tAv+glkh9p/6gfP9KNRAq0PndRYwZHNJm+bVZKzYnnnRy?=
 =?us-ascii?Q?qEnWuVDLRhdxtkk/4L8Rx0DDrRx8kwLsfp/fY/yW3ECJ4c2TnWihSLXwhubo?=
 =?us-ascii?Q?T66QjQMaGy715FvvCm04cHtUnfOfMzrso0ZqN/lplRxgXUOoG24z+UFF6m5n?=
 =?us-ascii?Q?lc+l3IcB6iKLOTRQKrorRYIRvXGetu+n24HMiDQBZH9x9pnAKLONj8le42zC?=
 =?us-ascii?Q?wS1EX4XrbI/kK1mBV6+rNq0Hh6hUn+ErXrhzpPMynVNGBoij5O2bQMj30SMe?=
 =?us-ascii?Q?zDChhKH5C8rHFfGVFgqeNTRjTWrFFpXzOhPl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ESJRCMAvx+bMlI24bc0xATKAj5HD+w5zfkptwnfaUyCiotRoyXnzTqJg0pB5?=
 =?us-ascii?Q?yvY0ERq2YWG742xCm/rt9TH5uk2Cz/rUN33hY1CnnZjiIAUEU+CTE4X5mPQT?=
 =?us-ascii?Q?h+XRImfcNMbt7RBiZ2GppnSXlmXa12i5l4jFdZxMBGCk3OSK0PncGHpv+kLS?=
 =?us-ascii?Q?xtH/1Ho6tkper97ONz13WFoj8ab6HaWcwe0Na1VVa72Rh9jYqh5M6FF4RAnQ?=
 =?us-ascii?Q?Y3oVqieqR7BV4jhdfM2AQiPxGgoizoTAnIbwAlXva1lkznEVpntKNUtMV+ZE?=
 =?us-ascii?Q?hfRVEX0DYTqAh4axkCH6hBhBttzMdypSjpU1KKEfZNCRxHU/pgdDP+4wSffY?=
 =?us-ascii?Q?quN4djlHy0mq0GjDEKsZdwekRlOVjRNojOlqdwxxQhafse579T69t8VD9hx6?=
 =?us-ascii?Q?WN9sQrF+e5WRpt9zShYfMZMk/CmiZyQEhTJ0sW8HG5jageqMz0W1FkChRo7m?=
 =?us-ascii?Q?/lwGuPxYJgRoCoNMXlSsw04zGEumQpFmVZCFxdxY5MMnQEXkVWm1z6rYgG8J?=
 =?us-ascii?Q?udufUugXEd1NsJgkZ3wsAvPG18qzEBflhdIa6BIE/9624KW35zhmETDnatS3?=
 =?us-ascii?Q?0dD5VJ8MBuE0FPUdPy35LmASZzJIqtJAsKLKbaiWbGFm+LOPlyQFfRaCvYT5?=
 =?us-ascii?Q?QZqa4qQcyNJi0csK+B7dbvSZO4g+4ngjIpK0L4mILzAo4g919eQWPOmgeOZt?=
 =?us-ascii?Q?YKjXou3yHaFD6592sjoENUDTEm7qW9kbMNoFGOZJ5dQjkemRh7tqSYBJKqpt?=
 =?us-ascii?Q?7s9q+mfy31kEbaSa0n5LcnUeym4EbWj6F2Q7pw7Rtuge3jMVeOflWKHwHTzr?=
 =?us-ascii?Q?YWZjD8ZKLfTvyG4Nvd0kPPoc/VaY6G5W9F8QfmspBC/Dv3mqe4BEXHz49cU5?=
 =?us-ascii?Q?ZOGHweDtV7mwgUQ89RRrT8DuiaWa9xObVSBg5g08SPgfZ4tROcVVa9/QX+To?=
 =?us-ascii?Q?ZKpG61H5EQ5weYQIy16w4bHU6+36/VTZ8BwhY1OOvGjdwo3b0EBDZVmfP8Ic?=
 =?us-ascii?Q?g9i+Fgt+FiWrzCd9TEjckgmfb+mQVcbjwtQJzu6fDE/qwqkKZO1iaxcQF8Gp?=
 =?us-ascii?Q?1a15ycbOKSwsP2XMC/MY9JBY/Dj/21ohhLFYMU3US7yU4mJDrt8r/DPyaEEm?=
 =?us-ascii?Q?26ZJZqysXBjAhKa6Jg+5apqxDK4GKoWXCjl2mOl5F2EhTJRbVEKOaIkUPzWX?=
 =?us-ascii?Q?ROoxnVEJm9G1rcqizzS0YPTbP/r9+Il+l17QY+FTzWHnJKmsJtUNfsS/ixYK?=
 =?us-ascii?Q?K51x9LbgeFhhxOCt2PNRx1al8nPYUADFF2MLrGyPiYMSrW165bph9RGmwE2E?=
 =?us-ascii?Q?B9Hx2FbQ3uLQlflgrYSY8ycL1L22ny3nyg7dsr1xDAeGpfrsDgoiIqeP5SR0?=
 =?us-ascii?Q?is2pj33CI9ow65mW6OtHqqGoBHG755c6c8A2NhptGZq9MWnRvT3+Go/rElx1?=
 =?us-ascii?Q?EEugIPv5YnLHknCRCQujk+pZ6dgoV4vZST6Zce3QwYETkQGN6iAURMpchuzY?=
 =?us-ascii?Q?RcY9Z92s6dyanrwwH1unA6twP2hRSv/Ty/ZlxnT8Yks/lSikBjDiPZl7ZSum?=
 =?us-ascii?Q?MFUkMwnqxT2Klm+t6VU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e87a907-e31b-4f6e-b7b4-08de0605dfa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 00:59:02.9588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1DkCpfkt81b4Vp4ApmlmSTDWPDj63EE7+O28XJlXJn5ZFXddXQJwQgFdYuOyQoqbKiH5hSh+FOurjASWBj5jdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039
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

Looks good to me .
Reviewed-by: Shaoyun liu  <Shaoyun.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Monday, October 6, 2025 2:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/mes: adjust the VMID masks

The firmware limits the max vmid, but align the settings with the hw limits=
 as well just to be safe.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 2a397cdbb38ed..aa4db2c81d17c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -105,8 +105,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
                spin_lock_init(&adev->mes.ring_lock[i]);

        adev->mes.total_max_queue =3D AMDGPU_FENCE_MES_QUEUE_ID_MASK;
-       adev->mes.vmid_mask_mmhub =3D 0xffffff00;
-       adev->mes.vmid_mask_gfxhub =3D adev->gfx.disable_kq ? 0xfffffffe : =
0xffffff00;
+       adev->mes.vmid_mask_mmhub =3D 0xFF00;
+       adev->mes.vmid_mask_gfxhub =3D adev->gfx.disable_kq ? 0xFFFE : 0xFF=
00;

        num_pipes =3D adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
        if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
--
2.51.0

