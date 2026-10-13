Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B76CC6B12
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 22:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E3A710E95E;
	Tue, 13 Oct 2026 22:15:49 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E938510E95E
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 22:15:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssCKsvM4QHOjFMQ61j7HKwStt8+4nAbIP0zk7cn/2MBKkQ0MG3FpawR8ADzO2JiNO2uwX7oGmLXLjDw1pL5kWR5OEZKvoan5uR60JA12Ue93RgRc/+uzUx9bg08roEMPWeBMC1yzVrEaIjcfwchMNnwWCouZyWCYHhzMROP39nvzsEH3ZgYY1dVafkKwg2567slU+rwWW0SrZoPGmHMLuZJ4LBZC0Zu7kieLI1nEqrpvN7i5y/Q34jhU7naLDWZ9rNA/gR6RNt4ZZkBDNimiBpFurmDbFeANA6SNbxn7hNY9FnykI5WPzxrluWZayNBt07pQbCNVzqcgPBg69RhHag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWfvtXwRHwuJayyfrD1KB2l86Ij5oU3ay8jLdatmS9s=;
 b=dtxfBTdPqkgG63NJeFTG6MALuSkAm1Wj07q5JXjli4juwVMthNDdKflIpNEGU0ZhPHWQ48VchndoZWtsTeCF42aRWJtgq+T65leVMCRnt+AuABL0aRHvZO1r7B5iF2gdq5u1Ob0ccN/2sN/muIPp2lt3AqsaEpQxV64XWZUynGuXqUl8yC9ziWiR91YwY7FkY6wiWw9felDE50APKv3FeKl/PR+em6aNRKciTOEt/frspeiq/VGETcO0HKLF/qbXxnr4abz5PrzIqDYXt9d1ph3+qx9T7ow4fWJXQ4EAcTp7K4Kg7pypYBxksshGPxtv5gxBrUZG6x1+KlJ+3C5lRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWfvtXwRHwuJayyfrD1KB2l86Ij5oU3ay8jLdatmS9s=;
 b=aP6nE7I/lvIS8AkEEaGN6Jf1UHIZaNZQuAT4EX1LdjzMWrC8GA4iZVGV1gInLEEpGvfBUsVGoOym/vzthveYvSwxVt3AgjtRtVTWko9XJRIZwRkdM7Ib7nGvDIL5EXghNvvIPO3eS2QQ9yDcLC8O/0CkMmYZ9b6glAr17ZmCrpw=
Received: from CH0PR12MB5139.namprd12.prod.outlook.com (2603:10b6:610:be::9)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 22:15:20 +0000
Received: from CH0PR12MB5139.namprd12.prod.outlook.com
 ([fe80::8715:80d8:e0b7:7bb1]) by CH0PR12MB5139.namprd12.prod.outlook.com
 ([fe80::8715:80d8:e0b7:7bb1%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 22:15:20 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Irshad, Luqmaan" <Luqmaan.Irshad@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Li, Yunxiang (Teddy)"
 <Yunxiang.Li@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: defer XCP DRM device free until primary
 release
Thread-Topic: [PATCH v2] drm/amdgpu: defer XCP DRM device free until primary
 release
Thread-Index: AQHdV1s0HS9rEp4qe06Wc+8+Z3AHo7b8Ec2w
Date: Tue, 13 Oct 2026 22:15:20 +0000
Message-ID: <CH0PR12MB513911F5018E9D86977C378CF79E2@CH0PR12MB5139.namprd12.prod.outlook.com>
References: <20260922205731.254264-1-luqmaan.irshad@amd.com>
 <20261008192742.22943-1-luqmaan.irshad@amd.com>
In-Reply-To: <20261008192742.22943-1-luqmaan.irshad@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-13T22:14:54.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5139:EE_|PH0PR12MB8031:EE_
x-ms-office365-filtering-correlation-id: 4543d34b-fe56-492f-fca1-08df29777840
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: v584l7H/3e+CUI2mc2A3TR79m78iqb2+RY1/toYRsi7uN2Q0Nhj4DK9X0JUlXVggowP2GaaHjk0R7kTlP6M6cnQxFxAoaaFaOKRJxn151TqCoUYx6AsgDj+kSxCgnuMit7zVZGroHgRjJNSsHOL8FYMulgylZKlg1Nyyn6JMgMBGcYgYK3I3l8lEZHg8iYILymow34iPWIRgBMHTKfdoE8TeshX++jenUhMYNuPooVtEkJPO7h17mXUlov6b4mvdLEk1M+sbY8OmfAoxSXQzUSvkb09ycTtbNFVM106+oB5lt5bt8CsS4ALADfUOGpVZks+lhEabt+Qzp9sbaHCcjykejojBEvXJqfwekrDYH0B5IJbu1ZCKxT/rhxCmUBw0q6xvGTwocE650tQL8x861FFMWomJ+RaHLF/TFM/KVPI8KJ0qD68fvZ5K55IYkEZCjXuWqPf1n+8TjTAuF+siapZn6KZWCLVgaZ1SfoGzh0JpXHiQQKtTPZ/A8mSBOJ+2V/68FnJ0PQdSxbMesN+NrUcIbyx+QsB9U5rz5T4HpsrXAYZctAcqJ/oLl/uVw5smj/MlLsm4HT5VNQe7BWq+nmgZkG7upBTQLug51yx9fvYm42kMyiQXgQdBpo5n86yWbkFMQMNBy3SJv/NfVP9GOMtgMf+d9BdW/3aNKoZnrpksLARBUSZSC5tqyq9DX40sT2dtGzm9ScNyfP+ribY10Q2B5Z+00bLzJfqRBj4nQKY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5139.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DwmotcYb22Uuxjm1jIs06SjNLGEz4Yl5pzvApg1HUZ4kg34roPzeHiLYOgoS?=
 =?us-ascii?Q?/2K8z1D305hhrwHASbPEZBKtENUXoS1K66L4xT21UAdYheEPPFMfCRkXoFEV?=
 =?us-ascii?Q?FXa3BF0kSbNcxmvihyMGec1bWlmroboowalxkYKUX3mJbqkWORJFraTd/TG9?=
 =?us-ascii?Q?Er6Z/dKe08oKhU9HHfan/Ia3MSX3Nb1mrf4opd9rNdJEqpWlJjIu7LKLvWT4?=
 =?us-ascii?Q?7KGlOBwgiOWEyFkFxxhHeDsNofcrdBWimRL7qfngB1Uv7xsGxetaNrFyIK+V?=
 =?us-ascii?Q?QEUFIKDjO/U4P65xGzCxOa+kXeg4tmtzSzUPXielMLy9v1JDlG2Rz5HX6elI?=
 =?us-ascii?Q?JS2TDJQk9xSaK2xyQuwNMijSFcjSVZkexzuC1B+dcQ5Zx6l4mp+h+oDDZBZ5?=
 =?us-ascii?Q?PVI6annYQLFCCjCxn37/E5jsLQjjqoiIsvvjnfjngQK0QjqbaNaspUKJZz9u?=
 =?us-ascii?Q?b2Kxbn15kjtL4asYSlr0XgHHisMjnYXoPDBDfUQKzlO9KNkwdrJXzGDnvafV?=
 =?us-ascii?Q?kmeHiPH1jz192t/emZT8F0UUeriWxd+FDq9R6lbZCHTToqZL4dgllQv6pZLE?=
 =?us-ascii?Q?nAgZ6tbh4e+eEYAs1nI6C5e2Ge1W4X1pJZN2XKLGXdzyAXrT/YvOUjrX4LF9?=
 =?us-ascii?Q?LEQgGvCvbyVml2enwJkbyxKQ8jXiD4+hGnHSjeQvCdEdDzPe0NzFnBgmZlD7?=
 =?us-ascii?Q?744RXRUPgdiW0C+ZuNf06Izss1tqNwfhiI7jK8yT2quZY1tkKFGr4d288euJ?=
 =?us-ascii?Q?Vjy8Ihfmz7T1SabNElln82o757zhFT8kh5Ivu/Gs60vJx33+Z7Om4OpHw8vp?=
 =?us-ascii?Q?q8TQgU+afRBud+cEQN6cItnhf3g1gFM+q/Q008PHDOMqTI9/UH5je/lufswG?=
 =?us-ascii?Q?eY4h7n1vmFak8g9sKa0N6CDZiaRSeY/b57uAOuWQL6iYtcdIE5UQnLazmWD9?=
 =?us-ascii?Q?ztn5mxyKgWpLvImGSrbxpTXRJkSdELtZJl2dGnpDwvLLjSTpbFp4f4VPANm+?=
 =?us-ascii?Q?VoSUgw7seH7higFzH6UKXHM/PDyWY9YbdvVW/4rh38/90jegR+DfwKy7PQ7o?=
 =?us-ascii?Q?Lepab5rPkNCObeRHplYEmQZR20FLxRzIhENMrE/vmtW563PHz2wI+3DeEIcQ?=
 =?us-ascii?Q?K5ZUHd++7B0JSUE0/4pbjLkjOrb9AyTmfMfjhGqOQW5EtZ/8Qg3kQsjMLRWd?=
 =?us-ascii?Q?+ylp8CrlXcNjF9maBb9+selgy8gpoTaYHPiXv1nzaHZpHaISFnvxcscm6eHq?=
 =?us-ascii?Q?Rj4G+23OGiChprab5CB9Cc6sV/o9eg4EAzAKq/AOJgUEFJo85WlYtHm7TX/T?=
 =?us-ascii?Q?aaJMIc6TLBPJz6+yyQR9B7zZwr6lnyE7UxRxw3pj0+NXRTHCqU0Fwzcg03zE?=
 =?us-ascii?Q?bfOswaPn8+QlLWVSPaKHbGdt/7yQc1v8oXovsN5lmcs1bHWtj71R0NSbtjHj?=
 =?us-ascii?Q?5LNCL/qinucpOiQP09ghYp5r2Z5KL/h/JZOLm+Qu7LQzUWH4v0GXz4iOYY+W?=
 =?us-ascii?Q?cY6Nz9ED9qBR9aoymhOcR5ZclU+P2GnBUlJYPcuta/vbz067OafUoEt+URWW?=
 =?us-ascii?Q?cH5SuNGEDNtNBriYsS2kqElORGNnR1IrgJpYMqHMUlbTvwO581OzpsmrPL5/?=
 =?us-ascii?Q?p3lWa0tTKJNaFWmmgv3hBjiMaQxHTpwCE9bDG3uKwPk4GONKjxrB0q0Vif79?=
 =?us-ascii?Q?OLeloUZnWns/HBb6n3MXM7bWvGILfqVLPRQeeM+aEOjfZ6iB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5139.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4543d34b-fe56-492f-fca1-08df29777840
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 22:15:20.4934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NUNy+GQyrchW/eJE6dw0o3XHVe28jjJwDXmqX4YFGyxnK2SbKDnU6sM3bKQrSUjDZpHIAfOPU6jPHiEMQqKjDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031
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

Public

> -----Original Message-----
> From: Irshad, Luqmaan <Luqmaan.Irshad@amd.com>
> Sent: Thursday, October 8, 2026 3:28 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Li, Yunxiang (Teddy) <Yunxiang.Li@amd.com>;
> Irshad, Luqmaan <Luqmaan.Irshad@amd.com>
> Subject: [PATCH v2] drm/amdgpu: defer XCP DRM device free until primary
> release
>
> XCP unplug currently restores the partition minors' device pointers to th=
e
> synthetic p_ddev and frees that device while files opened through those
> minors may still be active. Those files acquired drm_device references on=
 the
> primary ddev because the minors were redirected at XCP allocation time. A=
fter
> unplug reverses the redirection, close paths operate on the already-freed
> p_ddev, causing a use-after-free and p_ddev refcount underflow while leak=
ing
> the matching primary-device references.
>
> Split teardown into two phases. amdgpu_xcp_dev_unplug() only calls
> drm_dev_unplug() so new opens fail, leaving minor->dev pointing at the
> primary device. amdgpu_xcp_dev_fini() restores the partition device point=
ers
> and frees p_ddev from amdgpu_driver_release_kms(), when the primary
> drm_device reaches final release and all references held by redirected fi=
les have
> been dropped.
>
> Signed-off-by: Luqmaan Irshad <luqmaan.irshad@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  1 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 40
> ++++++++++++++++++++-----
> drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h |  1 +
>  3 files changed, 35 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f2f179421c4d..f4bc9e6eb97b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1638,6 +1638,7 @@ void amdgpu_driver_release_kms(struct
> drm_device *dev)  {
>       struct amdgpu_device *adev =3D drm_to_adev(dev);
>
> +     amdgpu_xcp_dev_fini(adev);
>       amdgpu_device_fini_sw(adev);
>       pci_set_drvdata(adev->pdev, NULL);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index a8c79a66df1d..c780d6794b89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -412,7 +412,6 @@ int amdgpu_xcp_dev_register(struct amdgpu_device
> *adev,
>
>  void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)  {
> -     struct drm_device *p_ddev;
>       int i;
>
>       if (!adev->xcp_mgr)
> @@ -422,12 +421,39 @@ void amdgpu_xcp_dev_unplug(struct
> amdgpu_device *adev)
>               if (!adev->xcp_mgr->xcp[i].ddev)
>                       break;
>
> -             p_ddev =3D adev->xcp_mgr->xcp[i].ddev;
> -             drm_dev_unplug(p_ddev);
> -             p_ddev->render->dev =3D adev->xcp_mgr->xcp[i].rdev;
> -             p_ddev->primary->dev =3D adev->xcp_mgr->xcp[i].pdev;
> -             p_ddev->driver =3D  adev->xcp_mgr->xcp[i].driver;
> -             p_ddev->vma_offset_manager =3D adev->xcp_mgr-
> >xcp[i].vma_offset_manager;
> +             drm_dev_unplug(adev->xcp_mgr->xcp[i].ddev);
> +     }
> +}
> +
> +void amdgpu_xcp_dev_fini(struct amdgpu_device *adev) {
> +     struct amdgpu_xcp *xcp;
> +     struct drm_device *p_ddev;
> +     int i;
> +
> +     if (!adev->xcp_mgr)
> +             return;
> +
> +     for (i =3D 1; i < MAX_XCP; i++) {
> +             xcp =3D &adev->xcp_mgr->xcp[i];
> +             if (!xcp->ddev)
> +                     break;
> +
> +             p_ddev =3D xcp->ddev;
> +
> +             /* Unregister devices on paths that did not unplug them
> earlier. */
> +             if (p_ddev->registered)
> +                     drm_dev_unplug(p_ddev);
> +
> +             /*
> +              * All XCP minor files have been released, so it is now saf=
e to
> +              * restore the partition device and free it.
> +              */
> +             p_ddev->render->dev =3D xcp->rdev;
> +             p_ddev->primary->dev =3D xcp->pdev;
> +             p_ddev->driver =3D xcp->driver;
> +             p_ddev->vma_offset_manager =3D xcp->vma_offset_manager;
> +             xcp->ddev =3D NULL;
>               amdgpu_xcp_drm_dev_free(p_ddev);
>       }
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> index 33157409eda0..e2fd32af9932 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> @@ -181,6 +181,7 @@ int amdgpu_xcp_get_inst_details(struct amdgpu_xcp
> *xcp,  int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>                               const struct pci_device_id *ent);
>  void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev);
> +void amdgpu_xcp_dev_fini(struct amdgpu_device *adev);
>  int amdgpu_xcp_open_device(struct amdgpu_device *adev,
>                          struct amdgpu_fpriv *fpriv,
>                          struct drm_file *file_priv);
> --
> 2.53.0

