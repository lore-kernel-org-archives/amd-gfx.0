Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CE7C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 18:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9023D10E837;
	Tue, 30 Apr 2024 18:28:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gy96ROLh";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2857610E837
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 18:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dciZsTUgD8M8Cbhgz2aHNi7MK9LY4IZlLzC4iEje+g9C0XVWmOr0Lq5NJ8oY7kNk7lzpFI268b7X9cJQuOhP406w9/BcuuICZa58148NgnHtnkNeumrB6GkE6ZrsBQZlIM4sl/US3RQYs06iz3RexDwshoP86Hl4gU+3yRGw4jvcTsEo8WvRgQIMTfjyygLXHHpf6mMHclC+LPcmmZFmS9ouocMdXZv97rWqvCVdzZDXhN8akw5rTFRgReU3Iilp98B3p4nE+1NMPtf6hBM24PqYqe46EPdyilZsnpaBtUbSVZUCOOMkMC3MfZKFYm7DbVEiCnFP6iSRduo9VXJcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIP1EseGp/5+Y6VsCP+c84wlb+U1bxYH9o7RrnNMNzs=;
 b=m5M8hBXadcHtW+a8HoAmAeSMMXK+gJOze6+i5lfEKwDRlfqLlZBvTCtXM6lJY32MyfSRql9q5E1/pT2zX8qfoZ7ubFcLbPY2nDVP8QkoUIhHeTh952r7MDscApKIFvbyP5g5SK8jg1Ld4pz5YuBTajdZdCv77QK/QFAH+245+wGCWEe7VwsmcD1LUmgNiJNPu5NadjjwGNwKLsH0fBkyj2ewF/lIWmnCCv2RoxiMZcGNXuRT2afJrkfjWqhgmlPQYpdedrPXhvzfOJsTRjisyU4cJqtXT/one3ljoOFsnhcGsasgNYgwexB/pUPwhqp7+uCLioPOKnDbjFpiUfYSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIP1EseGp/5+Y6VsCP+c84wlb+U1bxYH9o7RrnNMNzs=;
 b=Gy96ROLhDVzK02jsmPLLSgSC14ivyRlePzKBXTJBR77AhI5xLMwfXfXvyUzS2YbyJIAbkg6qPyhWKxM8C0oMhqb7Jn/O2tS7yoAQDmugJ+x+NpJ0GNxKvmcbuDw0GTkCOgZ1yYoE2zkdhR6PBC8j61/0FKWzOWxxMwIzEPrnknk=
Received: from DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 18:28:13 +0000
Received: from DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::88dd:d6b6:2f6a:cc3c]) by DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::88dd:d6b6:2f6a:cc3c%5]) with mapi id 15.20.7519.030; Tue, 30 Apr 2024
 18:28:13 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Li,
 Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
Subject: RE: [PATCH v4 2/4] drm/amdgpu: Add reset_context flag for host FLR
Thread-Topic: [PATCH v4 2/4] drm/amdgpu: Add reset_context flag for host FLR
Thread-Index: AQHamAdzpaHg5/eNcUegOJlZO26tQLGBKDZA
Date: Tue, 30 Apr 2024 18:28:13 +0000
Message-ID: <DM4PR12MB53285E321642A4E4FBDA0897F11A2@DM4PR12MB5328.namprd12.prod.outlook.com>
References: <20240426035742.90560-2-Yunxiang.Li@amd.com>
 <20240426182705.98131-1-Yunxiang.Li@amd.com>
In-Reply-To: <20240426182705.98131-1-Yunxiang.Li@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=84cf30ca-789a-4c16-807b-d75d7509f165;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-30T18:28:02Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5328:EE_|SA1PR12MB8117:EE_
x-ms-office365-filtering-correlation-id: 3313b88d-9fcd-43f1-f065-08dc69434b93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?69SUKbc+P+o7M/gTqnAg03jdeWP7mUJp0ICXvMWjYKR1JYT3N0Ql+ZcJmtQK?=
 =?us-ascii?Q?pZgWLJGZ3hj3ZQmkPaHFw9CJ0d43oRuVIHSbAgsTicNpt3vK6MVTpxSPxiUR?=
 =?us-ascii?Q?2vv6cFSxnhQG/599g+fOQHhHlKHg1c1xjSkqU/7HLvy4Ir2uQDioySSKNpnJ?=
 =?us-ascii?Q?GBDLvCGxGpW1qx18K3gl68cOTaySe9yBqsCk63Tl8Q3zCt8UKPnzA88j+UTD?=
 =?us-ascii?Q?Vx/vhsqNPfsz0Kh0bQ9eDjN0J8etxHP6kspaK936f/LoRVcT8jMzgRDXnkre?=
 =?us-ascii?Q?BaiMJ6oVzaLO/rN/moh0JaQHwGnbkbdWm2/C4up6ONgXi+hnqxl7XbEtCj5F?=
 =?us-ascii?Q?QeG+x30s9BatS1MYIbA/JtIPsUNpw0uM3ktq+UqvA+xZ2dVYg/Qnqa0Sdy4m?=
 =?us-ascii?Q?UawXRIqoXJ174yiRp7A8BUJaoR3+MYgOqJN6013nBBF6Acb2hurrDd7TD8zx?=
 =?us-ascii?Q?lZhnwt7N/IaWWmZIST/9HfmGVvZfU7ayqNl4kqEzSs+fUSjCxf1f/n8KbIvf?=
 =?us-ascii?Q?RTSiaoB8lMjELzfH5Tr1/Y8E79gEj1SpV7ccznrf17H0oCICs1bguddo5Wgr?=
 =?us-ascii?Q?Cr1rCxdwNEne60klXcRm979rhfVSM6oK9SlSg+9TtUjiLN1AVC3MrC3RJOJc?=
 =?us-ascii?Q?UXTvXgDffwi4cuzqweVt85B98oATsDQHpAGv3aHwqjKh/599KdwhWn4UUpu4?=
 =?us-ascii?Q?31Z7kr403ANmaGNXEzIFWeiAMQLQIVnXzAvSKxn0OLMbMxSoKxlPsM+EHjd0?=
 =?us-ascii?Q?CHwdSYN+HJzd15LKkeHMyUZaeXxsJWwHeRPxgMEcDxbZ79rczd9uHDmJ6oOW?=
 =?us-ascii?Q?v/c31mb6LVRgWz4EIROU8ked5ksDtJq238X4YEfIkomzuhneAke+wRXeQNr7?=
 =?us-ascii?Q?yuz8iFpc7QuX+bHXKGdXog1bUyEY5lSwf4EnN/KpcQu271KXTTUSkw8ysuNM?=
 =?us-ascii?Q?a9dJCwAzkkCyZXXOJN01wyLcSVZvunNK6mDVrowRfbS5L5od1JFlrGytAbSr?=
 =?us-ascii?Q?MlkjKc7G5AYvGsNMGqB18Ha5x2kX+cqdDii4ePK6931+NFPYCo0/baqbKFr0?=
 =?us-ascii?Q?UxVt76dy5Uwj56F1MsUtmERZMBu1wnrQJ2fovu000BtPrKwAxvLYEx78fHuM?=
 =?us-ascii?Q?wSecToNf1vN/MGKkF2fdF54haAqqLCH8EV+ytRDuYS6SC51mdOMxzr4gxkyJ?=
 =?us-ascii?Q?Pln0IS+U7IDCA4Vp7K75pl7cVVbytZ1itgoK/MgdC8VIJRBYjRBin/4FM93a?=
 =?us-ascii?Q?70NhwQxaQBGXg/vGAWVzysBKq50znfbu1gU9tQDA7CPCgAVui6dN9NorPrAI?=
 =?us-ascii?Q?BpxHhehhLsSUh00mcJGOMRBvJxf2tLZXaioW6YSAmel6Nw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5328.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rZfhcF6MxRM/SaIdfh1jCUdMsngO1DaUS9eLaWKBg4U/rK0Q1IH0aTy9DuB5?=
 =?us-ascii?Q?XXbkd1FgN+nL/KMekh10r4VnERBGKpVielCFnuSuLDXPCHAo910xEdChi4fV?=
 =?us-ascii?Q?Td//JOB+nki98n2d2AxHPkmqtjLxYiEfzDuUhCW9SnX0p7fVtueaVmQCvcae?=
 =?us-ascii?Q?zPp2CoSdjdRjtexLgHnmpglCl5U/D3jBd1caTNtew2807864nnmAYD10YiE3?=
 =?us-ascii?Q?M87Tzmvzcohyo7fEeUJxIf8dn8Y3Ba+leztBXsiHGI0SF05a3lTii0Lhd6zM?=
 =?us-ascii?Q?xH3AZIyczn2y4jyuK0/7voeZWvGQJnJdnsvx0emyunPiaiSy1NQO29PlQPuI?=
 =?us-ascii?Q?zo72MAXRnsRUUmx4ydbb+F9/xDFXVUiRB6pU4xV8MqmNTWKHbDQvDFb1NKAU?=
 =?us-ascii?Q?YNJ7Qf0dTFyKsPUVP8/bTKxAf7KvZlU5jZVc2cp0ANK82gOXcl25Ds9x5Nrd?=
 =?us-ascii?Q?aK48HNPG0ol2lL2RHRNqBlgaFAHA+VXfDZuJu6tNpZjsGtaxraYCS1Oj+H83?=
 =?us-ascii?Q?Q0axThd0O4Sq1GXVpQNrvzo5wn2eB/IXrYgGnrei6oV/DC3uBmzWK3JdlJ1g?=
 =?us-ascii?Q?6K5k9MoX+ERYz0KgdEMeqaH3hFxtMmrfY6NslTiuQ2uevKjbCG6uiDWkiDd/?=
 =?us-ascii?Q?XVkhs4BrwNXf+Z8FBn0J3EYYw/lWgJKfUdkClpg13cR+6RlHOHotOca7X7Fu?=
 =?us-ascii?Q?VegNfrcx+aB+OZwQYsCnnc+QUObOLWak6+hK74YktK/6LhOTBW3XqIJ/BBMx?=
 =?us-ascii?Q?ueU/q/EIc05YMPCqMKPqhxSYMW7p9HARW6Z+0z3+TVw+8/5J9erpSPOw179l?=
 =?us-ascii?Q?4I7J744sMDML7BHngpTckJCFzyfalz8Xn2tFpCYIlRXPIW7OcVmjdJWyD9is?=
 =?us-ascii?Q?8FrdWm3CbsC9dVxZB8n2Y9kWsctD05qR/aeYrMf//HKrXwPQ1Rjzqi0c146A?=
 =?us-ascii?Q?Hf/RxUh8I2DaAsWLDTxtyfOdi3bQQBbU5VrqgI9YNhRMB7n10D+pgkfBW2T3?=
 =?us-ascii?Q?xVXnlf4HkGrGr9CJxubAtxNgP2CnnthNHUTelwOY5pwAQwPe0HCipfC7uc7Y?=
 =?us-ascii?Q?OYg8ljSILtmRpBBhrCc4Dz1VgHbyNXzdl1rPePPtQ9XSoXuXEBv5J6/BOoJF?=
 =?us-ascii?Q?GDITxThWuy75sIb0+5+6e9VUyZoIEEeBrzIItsI0syDRU4aFGKqDJv48RbSb?=
 =?us-ascii?Q?m3LGxa759VCyuU+MU/wfQj4vGGnYIjUr3SPeyVJGxrjj+gGqsZW7lUOaEASQ?=
 =?us-ascii?Q?wkQnWQilq4kewCD3leCo89wTd6ajunRIF9EblinqV9oovw+T1aJeMICcF3AS?=
 =?us-ascii?Q?b8OA9fKBmDgj+8IX/ku0MHHu24VkHpat9PreF84G6nUAQfp/aAJln5OI48PN?=
 =?us-ascii?Q?26ZHaMhoATZhS/NZzu3boWP4erMpZ9AFhJCggh5HD9LGbrbTbPDAoY7ZahHq?=
 =?us-ascii?Q?1K+setIGWlprmneMBs+FvftFKCzlOeoXi3zcLpwIg1nUIh0BpgtE2sAYL6fH?=
 =?us-ascii?Q?9+VGv2rLFccUTZxGXUqJ4DND5tZZj4JyArfLHKeecaIKatDEErkToTJvrq7B?=
 =?us-ascii?Q?H1swNpr2kBFP4zmgC9s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3313b88d-9fcd-43f1-f065-08dc69434b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 18:28:13.1308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: STkmIASB1NeiJklaGqudKCwcbD6g6BjhmCoDSFwpUnGdK5mU2YlMiDpWQyndDllS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117
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

Reviewed-by: Zhigang Luo <zhigang.luo@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yunxiang=
 Li
Sent: Friday, April 26, 2024 2:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Kuehling, Felix <F=
elix.Kuehling@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Li, Yunxiang (Ted=
dy) <Yunxiang.Li@amd.com>
Subject: [PATCH v4 2/4] drm/amdgpu: Add reset_context flag for host FLR

There are other reset sources that pass NULL as the job pointer, such as am=
dgpu_amdkfd_reset_work. Therefore, using the job pointer to check if the FL=
R comes from the host does not work.

Add a flag in reset_context to explicitly mark host triggered reset, and se=
t this flag when we receive host reset notification.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
v2: fix typo
v3: pass reset_context directly
v4: clear the flag in case we retry

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 ++++++++-----  drivers/gpu=
/drm/amd/amdgpu/amdgpu_reset.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  1 +
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 8befd10bf007..33c889c027a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5055,13 +5055,13 @@ static int amdgpu_device_recover_vram(struct amdgpu=
_device *adev)
  * amdgpu_device_reset_sriov - reset ASIC for SR-IOV vf
  *
  * @adev: amdgpu_device pointer
- * @from_hypervisor: request from hypervisor
+ * @reset_context: amdgpu reset context pointer
  *
  * do VF FLR and reinitialize Asic
  * return 0 means succeeded otherwise failed
  */
 static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
-                                    bool from_hypervisor)
+                                    struct amdgpu_reset_context *reset_con=
text)
 {
        int r;
        struct amdgpu_hive_info *hive =3D NULL;
@@ -5070,12 +5070,15 @@ static int amdgpu_device_reset_sriov(struct amdgpu_=
device *adev,
 retry:
        amdgpu_amdkfd_pre_reset(adev);

-       if (from_hypervisor)
+       if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags)) {
+               clear_bit(AMDGPU_HOST_FLR, &reset_context->flags);
                r =3D amdgpu_virt_request_full_gpu(adev, true);
-       else
+       } else {
                r =3D amdgpu_virt_reset_gpu(adev);
+       }
        if (r)
                return r;
+
        amdgpu_ras_set_fed(adev, false);
        amdgpu_irq_gpu_reset_resume_helper(adev);

@@ -5826,7 +5829,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
        /* Actual ASIC resets if needed.*/
        /* Host driver will handle XGMI hive reset for SRIOV */
        if (amdgpu_sriov_vf(adev)) {
-               r =3D amdgpu_device_reset_sriov(adev, job ? false : true);
+               r =3D amdgpu_device_reset_sriov(adev, reset_context);
                if (r)
                        adev->asic_reset_res =3D r;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.h
index b11d190ece53..5a9cc043b858 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -33,6 +33,7 @@ enum AMDGPU_RESET_FLAGS {
        AMDGPU_NEED_FULL_RESET =3D 0,
        AMDGPU_SKIP_HW_RESET =3D 1,
        AMDGPU_SKIP_COREDUMP =3D 2,
+       AMDGPU_HOST_FLR =3D 3,
 };

 struct amdgpu_reset_context {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.c
index c5ba9c4757a8..f4c47492e0cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -292,6 +292,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct=
 *work)
                reset_context.method =3D AMD_RESET_METHOD_NONE;
                reset_context.reset_req_dev =3D adev;
                clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+               set_bit(AMDGPU_HOST_FLR, &reset_context.flags);

                amdgpu_device_gpu_recover(adev, NULL, &reset_context);
        }
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index fa9d1b02f391..14cc7910e5cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -328,6 +328,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct=
 *work)
                reset_context.method =3D AMD_RESET_METHOD_NONE;
                reset_context.reset_req_dev =3D adev;
                clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+               set_bit(AMDGPU_HOST_FLR, &reset_context.flags);

                amdgpu_device_gpu_recover(adev, NULL, &reset_context);
        }
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_vi.c
index 14a065516ae4..78cd07744ebe 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -529,6 +529,7 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct=
 *work)
                reset_context.method =3D AMD_RESET_METHOD_NONE;
                reset_context.reset_req_dev =3D adev;
                clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+               set_bit(AMDGPU_HOST_FLR, &reset_context.flags);

                amdgpu_device_gpu_recover(adev, NULL, &reset_context);
        }
--
2.34.1

