Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5D7C47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 07:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4013F613D4
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 07:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4013F613D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF6866E037;
	Thu, 27 May 2021 07:17:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0DDE6E037
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 07:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clV6eAKATYYf/0UOMKq+lMDIzyVV/Un0VAsxFHtHj1QwalO2qcmDvXQ5qyG32AdIlHaEZ1EU1+ZylouSgC1/GeBL3FJ1A3ARTCPrrE0d63GhzxZI7SmgvrKS3nluOo+kwpxNdawN4tkG5dJQoe/H02TPkE6gh42xEG1qXxNUSZdioxACl93aAG40zOi8Kf59z6y179n0SzZcXC4nPHHFkuza+iWjg7lLDQNoSWobwsUZBG0Xbsg+A9RvYP5364vWCGyRtaiIktJuDJfCAN2kaKOxyqsjaP2J6LGw3p+Js7zH+nJloXmPnAujmx9rCu1zU7WUT7zsiE0HKa50tq4lMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oh3IQDfqBXhqSfA89v1ziBGhLY/ngJ165mZSxQJBnjM=;
 b=YxhN/zWdb602V8E5PMLnycCsbZqKEzxhEE18KOGURjLQdrrpF9StFiXXpWOULyTNBRLP9iSAcGWsQDA/TMN0tIbvH5p0RHZ/GwqpGKiw+lTOvste0veK+FrQqHIQJMSONkexJdZpT2l1nbNXMqeGy3O5gmsYSJFdlmAZmOosOI4ARrFhkBPzzFoV7pCEMOOx1uVSofQ62XR2XH38HC3Rp7+tU+NkPAFcRghataiETzP4kClMHoJ407o39V0QO+bNLYZwrmy5lR4AhPn+npMna39XxTddVybzdUf2sZVlumzv8m4s+k3Hw++Y35YNQyNMSFWYaN9fRL38lIOdAP//7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oh3IQDfqBXhqSfA89v1ziBGhLY/ngJ165mZSxQJBnjM=;
 b=KvRzl3RqlhAsCcGzD0dPi3Q12HTHv8j+W1HH5vduAKkMFy/+6mdFAZQWuSgIZ91rp+GqiOP3fsemdA6+uP9MH5um9ZgifCQovsx+gdyK2/xB0hM/CpTVvFYojwzoIal3vqOdgbgtyOZwHAALNjwiNPy3+tOipq4ZN/zZuuqG/ek=
Received: from BYAPR12MB4759.namprd12.prod.outlook.com (2603:10b6:a03:9d::16)
 by BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 07:17:50 +0000
Received: from BYAPR12MB4759.namprd12.prod.outlook.com
 ([fe80::510c:c457:aeaf:e71c]) by BYAPR12MB4759.namprd12.prod.outlook.com
 ([fe80::510c:c457:aeaf:e71c%3]) with mapi id 15.20.4173.021; Thu, 27 May 2021
 07:17:50 +0000
From: "Li, Xin (Justin)" <Xin2.Li@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing
Thread-Topic: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing
Thread-Index: AQHXUhe/YOz3+Ry/6Uu5dUE49mCC4qr2cacAgAB54Yw=
Date: Thu, 27 May 2021 07:17:50 +0000
Message-ID: <BYAPR12MB4759A953391A086672B58D43BB239@BYAPR12MB4759.namprd12.prod.outlook.com>
References: <20210526101310.1872892-1-xin2.li@amd.com>,
 <BL1PR12MB52692DDE6DC4D82AEB5E4A6784249@BL1PR12MB5269.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB52692DDE6DC4D82AEB5E4A6784249@BL1PR12MB5269.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-26T23:57:42.0000000Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP
 2.0; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 655017df-af34-42e8-999b-08d920df8988
x-ms-traffictypediagnostic: BY5PR12MB4227:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB42274F7E1BF276DCE47F0120BB239@BY5PR12MB4227.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:478;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZNFvOsHGqomXAkwYpRdxYWis0bv7Nk+QDM7YM3iKPdHz1sbtiKVSPIR4k+IJ8zqO2VK6eOo0e1vIPnx/XR1HtogkVli/YYhOVXNiQMog88RqLcMmCVzrIWu21otWSEdy0xcxDwcqFFa1GHiKEn6q4/e3gfqAOeEBbq/W0GB/3AZQS0m7/IEITDmYRn+Q0Nx2ptPHqas9gB7HqMljpyaDKHnRuD3mdJZerdKzDpRVIbVZM4XyWRW/A2WagBj6v04c7xntJV4xGbJiciQFs3I8XKNuv8dDxfydGmu04YBzfi48G0ceLO2+h25T2SU1uUCMa857QhdjjSwJVBSNOFGOs9ycCebuaKiB/va2MS43QEv3SAJI08ASMzVLZxe2kclhR/j33tILaGL9WtWh2tKma8I58/tljwGLk5L1NcvG39T4Jd/UO5FPDsTfqRAZqJZ2cEBiLMATPlXOpad9XxPGNgfcPe3sIykwI1Tst3w6TsZ5zPVE2Yo1VbVuO+orjIbonAmj3hhzPaZP9ztRxsNRC3RdSwuMFDoogebZoAJzBogf23pvSXe7vWFC3JvoLgET4Y4EyEUb4DmpCzwIPObj7O0/sNWjDJS1THJi2xUU+4+0jgDozBt03SsJZFFpAgZ/qVBVZ8z2DEkTfcKqWPYXWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4759.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(186003)(38100700002)(54906003)(6506007)(7696005)(26005)(33656002)(122000001)(53546011)(55016002)(71200400001)(86362001)(110136005)(52536014)(4326008)(76116006)(66446008)(8676002)(64756008)(66476007)(66556008)(5660300002)(166002)(9686003)(66946007)(8936002)(2906002)(91956017)(316002)(83380400001)(45080400002)(966005)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?gPN2g2GeKPvgWC4E7XxrmPW1YnvfZ3Cgn4c4eGDzwlef3aFTYXd+P6j7?=
 =?Windows-1252?Q?l7o3BjpX9tVa+D6aQJz1Smbto0hHFCVBXEanO8ztdbJ0kqUlX39ycuf/?=
 =?Windows-1252?Q?HpPYNd4sDAG8QEOEfGEoNQ020BnTzd6ROVYKMv7cWc5+sS+p1X7xXTli?=
 =?Windows-1252?Q?BkwZr62dLBOpe7VomxSVWD9E9RKlWqkaKb0p6v7jGbxupibTeY27qPyA?=
 =?Windows-1252?Q?WDrLliXG3Cuytvg1nNH4Z3eaTaOpos084rlkkiiCS01JiptUDF8Lflk+?=
 =?Windows-1252?Q?5YlAJgWDkJtG5584dK6HAgdQGsAFDGfAZuE+e4W3W5gKQO/zng9AmXlZ?=
 =?Windows-1252?Q?Exgx5FySrsKuejWrvR7cLj8d/d+Z1LybS9VPl1qA4fHQtBgpDdFBH+I4?=
 =?Windows-1252?Q?6dGkjl/Fm+6FQGBSFzK0946LqhQsr9sMFwBSOgg+jo7QZOJwGs06Q89T?=
 =?Windows-1252?Q?hiMeKLF9GPMWmvO1R9HofThl8rBbJU0TR4vynJIw/TBIl2eouRfxEXeV?=
 =?Windows-1252?Q?mlNVW9nz9VRq9OWy/EkH5VjuaSx/5Z6j1PAI4AruTKoWVla6wuhQ9AMe?=
 =?Windows-1252?Q?/Ki0oxOiKSVOAwbn4wte4eXR37PgBbEbfeli3HnMz0uAOstwZxWHRSNN?=
 =?Windows-1252?Q?HvKjeeX1WunKGHXTlIF81tslOlaVls1iZm2PWwZtyfv8eJHPYWze5LGV?=
 =?Windows-1252?Q?mYi1uq4U1pQ2eZKaBVirTVxX3Lk5MD3AzGSPasS5YOTo2YYGWXwP5jp/?=
 =?Windows-1252?Q?MI2I40/s8GAIdl/gdTdargbU4pNc0eYFfxlRoF/QFYUJzwEa5NbbXSQ4?=
 =?Windows-1252?Q?FxAWPF+bXTmLsiT9Z5t42kfpPJ9GIwgr208xtuRuB3GCVJ8gSjtiCBYN?=
 =?Windows-1252?Q?/sbgHocpLu0AH7T/8Yxqcub3/J1k9u7e7RJVoJu8Kdx+p0YlexuEkB5f?=
 =?Windows-1252?Q?T83L6Mqrnn20GsSboWcDLFsAymfvcmI5xP12R3JP4SzvvdrolSe0PkcP?=
 =?Windows-1252?Q?wZRqxGvwPS6C76Zykc8IMLI2ddtPMrafmDrJoOmS+dMi0OiL5bbKPQw2?=
 =?Windows-1252?Q?WNDto1IyehrJOPZ1gtq7UByNJnHPmqfdZoaK/JTsI+6INoIsj3qfm503?=
 =?Windows-1252?Q?ZN2HV9rrQvkXo/Zd8sIgS0gAHlGuAgR/xpInwoda8wLdY/Zo9dZMRa4z?=
 =?Windows-1252?Q?ng3Neo4fNplCVPU6mNnlygp9p2ufq49W/jCvnGdyabgxPz0NH17jIqfi?=
 =?Windows-1252?Q?rxjaJ+8sEvJPp4jDZyFn1rMnpNVHibtfLhjvTvwtKIs4X4APJ5/BzxbO?=
 =?Windows-1252?Q?9WE2deYEj3vJZ08skLLbXCVywmZ8c5ilOuieqUPk1D9Qxen8s9J5MjP6?=
 =?Windows-1252?Q?3Yt0rJxXoRFvHKGtasJIT71SKcsMjX9I1zNKVGur5tYbneMd/8HK9ZKy?=
 =?Windows-1252?Q?DHIJsghwUiariHTHkaJg7w=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4759.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655017df-af34-42e8-999b-08d920df8988
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 07:17:50.5073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E0WrqZy+yAhVMXg/I865k6phg4PYe+RsQZiD0Qvu5iMBjrXVlZKm0cOH8QjofsR7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Min,
 Frank" <Frank.Min@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============1306425047=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1306425047==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB4759A953391A086672B58D43BB239BYAPR12MB4759namp_"

--_000_BYAPR12MB4759A953391A086672B58D43BB239BYAPR12MB4759namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi, friends.

My apologize for this patch.

I=92ve ported this patch from another branch to fix gstreamer=92s lack of =
=93vaapi264enc=94, currently this ported patch did fix that issue. However,=
 since this patch is ported from another branch, I might need to do some al=
ternations and audits mainly in its commit messages. I will file another re=
view right after my fixes.

Thank you all for you time.

BR,
Justin

From: Liu, Monk <Monk.Liu@amd.com>
Date: Thursday, May 27, 2021 at 07:57
To: Li, Xin (Justin) <Xin2.Li@amd.com>, amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Li, Xin (Justin) <Xin2.Li@amd.com>, Deucher, Alexander <Alexander.Deuch=
er@amd.com>, Min, Frank <Frank.Min@amd.com>, Koenig, Christian <Christian.K=
oenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing
[AMD Official Use Only]

Looks it lack enough background for people to review:


-                       if (adev->vcn.inst[i].ring_dec.sched.ready)
+                       if (adev->vcn.inst[i].ring_dec.sched.ready ||
+                               (adev->asic_type =3D=3D CHIP_NAVI12 &&
+                               amdgpu_sriov_vf(adev)))
                                 ++num_rings;

[ml] why for SRIOV navi12 is forced to have those DEC rings ? since  SRIOV =
navi12 have no decode capability , any explain here ?


-               if (amdgpu_is_tmz(adev))
-                       dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_TMZ;
[ML] why this is removed ? is it related to your issue ?


Thanks

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Li, Xin =
(Justin)
Sent: Wednesday, May 26, 2021 6:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Li, Xin (Justin) <Xin2.Li@amd.com>; Deucher, Alexander <Alexander.Deuch=
er@amd.com>; Min, Frank <Frank.Min@amd.com>; Koenig, Christian <Christian.K=
oenig@amd.com>
Subject: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing

since vcn decoding ring is not required, so just disable it.

Cc: Alex.Deucher <alexander.deucher@amd.com>
Cc: Christian.Konig <christian.koenig@amd.com>
Signed-off-by: Li.Xin.Justin <xin2.li@amd.com>
Signed-off-by: Frank.Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 25 ++++++++++++++-----------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 524e4fe5efe8..614e6b06e94e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -427,7 +427,9 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev=
,
                         if (adev->uvd.harvest_config & (1 << i))
                                 continue;

-                       if (adev->vcn.inst[i].ring_dec.sched.ready)
+                       if (adev->vcn.inst[i].ring_dec.sched.ready ||
+                               (adev->asic_type =3D=3D CHIP_NAVI12 &&
+                               amdgpu_sriov_vf(adev)))
                                 ++num_rings;
                 }
                 ib_start_alignment =3D 16;
@@ -770,8 +772,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *dat=
a, struct drm_file *filp)
                         dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_FUSION;
                 if (amdgpu_mcbp || amdgpu_sriov_vf(adev))
                         dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_PREEMPTI=
ON;
-               if (amdgpu_is_tmz(adev))
-                       dev_info->ids_flags |=3D AMDGPU_IDS_FLAGS_TMZ;

                 vm_size =3D adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZ=
E;
                 vm_size -=3D AMDGPU_VA_RESERVED_SIZE;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_0.c
index 8af567c546db..dc8a36766c4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -220,17 +220,20 @@ static int vcn_v2_0_hw_init(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
         struct amdgpu_ring *ring =3D &adev->vcn.inst->ring_dec;
-       int i, r;
+       int i, r =3D -1;

         adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
                                              ring->doorbell_index, 0);

-       if (amdgpu_sriov_vf(adev))
+       if (amdgpu_sriov_vf(adev)) {
                 vcn_v2_0_start_sriov(adev);
-
-       r =3D amdgpu_ring_test_helper(ring);
-       if (r)
-               goto done;
+               if (adev->asic_type =3D=3D CHIP_NAVI12)
+                       ring->sched.ready =3D false;
+       } else {
+               r =3D amdgpu_ring_test_helper(ring);
+               if (r)
+                       goto done;
+       }

         //Disable vcn decode for sriov
         if (amdgpu_sriov_vf(adev))
@@ -245,8 +248,11 @@ static int vcn_v2_0_hw_init(void *handle)

 done:
         if (!r)
-               DRM_INFO("VCN decode and encode initialized successfully(un=
der %s).\n",
-                       (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode=
":"SPG Mode");
+               DRM_INFO("VCN %s encode initialized successfully(under %s).=
\n",
+                       (adev->asic_type =3D=3D CHIP_NAVI12 &&
+                               amdgpu_sriov_vf(adev))?"":"decode and",
+                       (adev->pg_flags &
+                               AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mod=
e");

         return r;
 }
@@ -1721,9 +1727,6 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *r=
ing)
         unsigned i;
         int r;

-       if (amdgpu_sriov_vf(adev))
-               return 0;
-
         WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);
         r =3D amdgpu_ring_alloc(ring, 4);
         if (r)
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cmonk.liu=
%40amd.com%7Cb86e27d9b55f429b352308d9202ee408%7C3dd8961fe4884e608e11a82d994=
e183d%7C0%7C0%7C637576208056272141%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw=
MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DcMllN=
28FN56voTpWwdnMmBB3CGXezs%2FaEwflSZD6qr4%3D&amp;reserved=3D0

--_000_BYAPR12MB4759A953391A086672B58D43BB239BYAPR12MB4759namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi, friends.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">My apologize for this patch. <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I=92ve ported this patch from another branch to fix =
gstreamer=92s lack of =93vaapi264enc=94, currently this ported patch did fi=
x that issue. However, since this patch is ported from another branch, I mi=
ght need to do some alternations and audits
 mainly in its commit messages. I will file another review right after my f=
ixes.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you all for you time.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR,<o:p></o:p></p>
<p class=3D"MsoNormal">Justin<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Liu, Monk &lt;Monk.=
Liu@amd.com&gt;<br>
<b>Date: </b>Thursday, May 27, 2021 at 07:57<br>
<b>To: </b>Li, Xin (Justin) &lt;Xin2.Li@amd.com&gt;, amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc: </b>Li, Xin (Justin) &lt;Xin2.Li@amd.com&gt;, Deucher, Alexander &lt=
;Alexander.Deucher@amd.com&gt;, Min, Frank &lt;Frank.Min@amd.com&gt;, Koeni=
g, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject: </b>RE: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc miss=
ing<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">[AMD Official Use Only]<br>
<br>
Looks it lack enough background for people to review:<br>
<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn=
.inst[i].ring_dec.sched.ready)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn=
.inst[i].ring_dec.sched.ready ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_NAVI12 &amp=
;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_vf(adev)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ++num_rings;<br>
<br>
[ml] why for SRIOV navi12 is forced to have those DEC rings ? since&nbsp; S=
RIOV navi12 have no decode capability , any explain here ?<br>
<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_is_tmz(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info-&gt;ids=
_flags |=3D AMDGPU_IDS_FLAGS_TMZ;<br>
[ML] why this is removed ? is it related to your issue ?<br>
<br>
<br>
Thanks <br>
<br>
------------------------------------------<br>
Monk Liu | Cloud-GPU Core team<br>
------------------------------------------<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Li=
, Xin (Justin)<br>
Sent: Wednesday, May 26, 2021 6:13 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Li, Xin (Justin) &lt;Xin2.Li@amd.com&gt;; Deucher, Alexander &lt;Alexan=
der.Deucher@amd.com&gt;; Min, Frank &lt;Frank.Min@amd.com&gt;; Koenig, Chri=
stian &lt;Christian.Koenig@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing<br>
<br>
since vcn decoding ring is not required, so just disable it.<br>
<br>
Cc: Alex.Deucher &lt;alexander.deucher@amd.com&gt;<br>
Cc: Christian.Konig &lt;christian.koenig@amd.com&gt;<br>
Signed-off-by: Li.Xin.Justin &lt;xin2.li@amd.com&gt;<br>
Signed-off-by: Frank.Min &lt;Frank.Min@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |&nbsp; 6 +++---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c&nbsp;&nbsp; | 25 ++++++++++++++=
-----------<br>
&nbsp;2 files changed, 17 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index 524e4fe5efe8..614e6b06e94e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -427,7 +427,9 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (a=
dev-&gt;uvd.harvest_config &amp; (1 &lt;&lt; i))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn=
.inst[i].ring_dec.sched.ready)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;vcn=
.inst[i].ring_dec.sched.ready ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_NAVI12 &amp=
;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_vf(adev)))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ++num_rings;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ib_start_alignment =3D 16;<br>
@@ -770,8 +772,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *dat=
a, struct drm_file *filp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_i=
nfo-&gt;ids_flags |=3D AMDGPU_IDS_FLAGS_FUSION;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_mcbp || amdgpu_sriov_vf(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_i=
nfo-&gt;ids_flags |=3D AMDGPU_IDS_FLAGS_PREEMPTION;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_is_tmz(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info-&gt;ids=
_flags |=3D AMDGPU_IDS_FLAGS_TMZ;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vm_size =3D adev-&gt;vm_manager.max_pfn * AMDGPU_GPU_=
PAGE_SIZE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vm_size -=3D AMDGPU_VA_RESERVED_SIZE;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_0.c<br>
index 8af567c546db..dc8a36766c4a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
@@ -220,17 +220,20 @@ static int vcn_v2_0_hw_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
=3D &amp;adev-&gt;vcn.inst-&gt;ring_dec;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r =3D -1;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;vc=
n_doorbell_range(adev, ring-&gt;use_doorbell,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;doorbell_index, 0);<=
br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vcn_v2_0_start_sriov(adev);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_test_helper(ring);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto done;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_NAVI12)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;sched.r=
eady =3D false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_ring_test_helper(ring);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto done;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; //Disable vcn decode for s=
riov<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
@@ -245,8 +248,11 @@ static int vcn_v2_0_hw_init(void *handle)<br>
&nbsp;<br>
&nbsp;done:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_INFO(&quot;VCN decode and encode initialized successfully(un=
der %s).\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pg_fla=
gs &amp; AMD_PG_SUPPORT_VCN_DPG)?&quot;DPG Mode&quot;:&quot;SPG Mode&quot;)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_INFO(&quot;VCN %s encode initialized successfully(under %s).=
\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;asic_t=
ype =3D=3D CHIP_NAVI12 &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sriov_vf(adev))?&quot;&quot;:&quot;d=
ecode and&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;pg_fla=
gs &amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_VCN_DPG)?&quot;DPG Mode&quot=
;:&quot;SPG Mode&quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
@@ -1721,9 +1727,6 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *r=
ing)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(adev-&gt;vcn.inst[r=
ing-&gt;me].external.scratch9, 0xCAFEDEAD);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_alloc(ri=
ng, 4);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Cmonk.liu%40amd.com%7Cb86e27d9b55f429b352308d9202ee408%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637576208056272141%7CUnknown%7CTWFpbGZsb3d8e=
yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am=
p;amp;sdata=3DcMllN28FN56voTpWwdnMmBB3CGXezs%2FaEwflSZD6qr4%3D&amp;amp;rese=
rved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7=
C01%7Cmonk.liu%40amd.com%7Cb86e27d9b55f429b352308d9202ee408%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C637576208056272141%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp=
;amp;sdata=3DcMllN28FN56voTpWwdnMmBB3CGXezs%2FaEwflSZD6qr4%3D&amp;amp;reser=
ved=3D0</a><o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB4759A953391A086672B58D43BB239BYAPR12MB4759namp_--

--===============1306425047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1306425047==--
