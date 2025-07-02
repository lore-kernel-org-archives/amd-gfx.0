Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648A7C8303D
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jul 2025 01:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD03C10E650;
	Wed,  2 Jul 2025 01:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F4LDX7XG";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF5AE10E2F0
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jul 2025 01:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxsflthsUs/tKQRQtbeBA7CcxWPqffD59O9KhRfjWL9FRjrx3vDwF/kq9Ckef8Dvc8q2yx2kjYpGSD673pEGRTd3w38ZqbRGV24zMqub8pMnTwlNedQW3T/yVBR8UyUwztZ3w+u179WiF1OzDoOKa4ICXkHqLG1TcV3x5j4UpWRjaTHYnd/NdUlQrty7UAbP+iI6NhyiAKEyzU3xChBgCvbAKK7GDGRjbabxrZ+XrydA+ywQuUEYqpHpFa+rRSZB4MJ+m/HhfbGwgiPQB6U4jVCnG3m4ETwXhSFCVCwIdY7Dy+swXN+bkaWGMDmed06sFWah3rAVMCaHcBGzL0LcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JlJwG4bouMphafxhSK3vKVzcP79ZJxT3QfEDk6CgAc=;
 b=Bsg6wTGg/62LxowbDP7YRpbwDui00kqPTGbrBlhqr8KWYrzDHvAON3lIP55PVYSb84KZGKTjErmrcWo71dCiEfUhoy7b/uxJ5+zkz8kh1e7IgZWVrzEFFncKpe85l7sx46mMkrDunhgr6jDofTQjFmoKr3u0Gn//cVn1bw4iM7X9hXZsCeW3RIDHIkPcsc1/0qCr2Zycdb3WyqzZQQ5UybHC5WqqAl7bbI6Sjrmae7I4K9iVEkHa9lBM9SFJwXw40TfB5l6+vG/x5BeV+r76ZdFU8FXJjbN8rsDA8DXADd2XnLt/LI7SlvTpKZUCfeTJizVax/QJNESqAfwqNLrK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JlJwG4bouMphafxhSK3vKVzcP79ZJxT3QfEDk6CgAc=;
 b=F4LDX7XGdCH4ocO2YoJdWHNwb8QvKizfXTCoy3zd4z3P4Bmq5Aur3en2rhJLqFAVwWmxG5JgbcF0EfPYSwxGiFTDlJ82IcxqBPQAnnsWG20Orl96JZFXAMPQockHlbgYVi2lZQnLXdMmIG5TWI12LqQVQJ4wYLpkG9z8DV3u8Gg=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SA1PR12MB7246.namprd12.prod.outlook.com (2603:10b6:806:2bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Wed, 2 Jul
 2025 01:52:27 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%6]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 01:52:27 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sdma: don't actually disable any SDMA rings
 via debugfs
Thread-Topic: [PATCH] drm/amdgpu/sdma: don't actually disable any SDMA rings
 via debugfs
Thread-Index: AQHb6px2bowP43SfGEmQDydrcbirmLQeEQSw
Date: Wed, 2 Jul 2025 01:52:27 +0000
Message-ID: <DM4PR12MB5152D2C3C56C7F0E8F4B54A7E340A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250701152538.5832-1-alexander.deucher@amd.com>
In-Reply-To: <20250701152538.5832-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-02T01:46:25.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SA1PR12MB7246:EE_
x-ms-office365-filtering-correlation-id: e128be67-dca4-4df2-5283-08ddb90b1920
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6NNNys0yxD6POQW3Ajk4Z2f9o69nGkb09iAv13G9SGGXD+LTNyDdFfO9VLIA?=
 =?us-ascii?Q?aIQe/JR3O3hKXlGcxjWL50q9SxVxiNufcpCelpnDJ7toS/DpnXCZhGlLVBwE?=
 =?us-ascii?Q?pPxYEjI3UMdy7YNrlDMpT7tFHiTnv/L5wMuevt7hsB3ZLZKdLTp8Da5dQa5c?=
 =?us-ascii?Q?vIimouiZqFbncJz9lu+N9oxTI8cRktAAt0mVu+aiLvNXUovTG5wUojN1KUxF?=
 =?us-ascii?Q?dHWKfd5vBObSYCcPdJc9qIciEiIcJJ6YU47GKvgOMklZPxR4XcEijA7ZspU8?=
 =?us-ascii?Q?2HUybDajEfrGn4OhwdQTWsK3NwglqTKxL8KUk6PclN3amBMCElQsFukIxn9m?=
 =?us-ascii?Q?vLrg29TtIJHRh9Gw5APwjC1PPqGfJ/2fTkVnQ9XWmEN52oVO47ufGkeToMoo?=
 =?us-ascii?Q?zwcb8/LMwB5qEOORWaGUsL0yPcnUXvpmUkCv/ul9/xsvR1V80JmPcBfroqJR?=
 =?us-ascii?Q?xbURRMZq60qUkpB3IFE2KsjZ75u/keq4OzCZlGgTEAkONDah9/YH5WLvva6o?=
 =?us-ascii?Q?FDWDvCIDo9Ne2ftV2hCaH/wvDwNsGUIn1egBwzqgc2ZkkxhhP9dL1Lw6BcXe?=
 =?us-ascii?Q?j0ps6q7vcsd/Z2Sw9YSYVDBgfep7LzZSiMxdNX4Bzv9Cy5OCBVbYh+UVTbi2?=
 =?us-ascii?Q?DZEnZSEVsAYAEBW0axdtiFi/ZzvDz9pZH6q6HyyA6DKxdd9pORXYq8Ks+w/x?=
 =?us-ascii?Q?cXYhlSyldYlJgto1VxxSJBgOgIZ7EJcJtwqKd3c9ERjl54WREcF3sRGSxyWl?=
 =?us-ascii?Q?jPWhj6+43OfPajbL+I6EiIfWRm8DriYNyLVAAw7KooxSr6M7bU0KcSk8xUoT?=
 =?us-ascii?Q?eMvtQ/flR2L3wbHfuSdExiCqx9fMEWNXr/9cYuXmIjQtfFUkX2W7ndHVK6ne?=
 =?us-ascii?Q?9A02Xkns4GWs0tHB7e9Cvm4+3CBSR0467FW+BD2jtxL/FrBuljImImqKLMX9?=
 =?us-ascii?Q?APeYJF4jice4VXPrnpKMX7Pg2/UXNPfyrRRM00Xo0BxuNhDUv2DLyS76HXjN?=
 =?us-ascii?Q?dzA7GJJ3qm2dDVdvqKATTHra3wWiMyeUWELtpPtKPVfafMYpwP52pG+cyVLu?=
 =?us-ascii?Q?Fb05CztuJpdd7x/itjYdDz1Ih7Vz2nHG3lA8LdR3YAEPzIUPdz4ANFLClowk?=
 =?us-ascii?Q?/oqr8ACWTD93cLHNEsw0x6wsb83+iM9sVy3c2KgeoJ8fVp+3I5Yhlcnn8ITY?=
 =?us-ascii?Q?EYmhDO6xvyJXdw7bm0v9ALGHho8CwYQNPGT4DpZ7Si2oA/BviwBbJvL14ZAV?=
 =?us-ascii?Q?fj24EbX1cacJNXuWpphj3eleKyMXLPd8K9TZleZxepwzH0GU8M04xv0YMP2g?=
 =?us-ascii?Q?barvDitytD5grYn6RpFfLjbWSDU7DXH8J30XnoCdMsayJofzKHhromXEDcs1?=
 =?us-ascii?Q?YpMdA/zS4wG1Q5Zjqp7MjtSIA2E9sKP44M4nbP0+CcRlkNqKE1ih+OGrDS0l?=
 =?us-ascii?Q?Eso9Y21BZ4jpKsiPbL4oFG5u2nvIiKQE8okl4aDfoItZuPab2XzzinNixLW5?=
 =?us-ascii?Q?OyYkS+uOPzW+SZ0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TYROWq4YJe7BCd9WN7DzfvUP05KcHRds7AXzIsOvGIc/WcNBLxyd59NX97X0?=
 =?us-ascii?Q?IE6ZMs3rRSTbHvBDyemxANrjpLgUQ+2brrEWBiMO522ZXk4DvJ7xQmeruovK?=
 =?us-ascii?Q?VjqpmR80BjGxTJYabPQR8X9WPNN6UPq+vnHP8Cak/VOpV+zrg+/QKVVo4OEZ?=
 =?us-ascii?Q?skJOUHERyS5edVH4v3JJ2DSpDStv1xh8Bw/S9bSSaWGIuvxCVsXRxW+SDCak?=
 =?us-ascii?Q?scL/5kOlLJUIdLHDl+Nv8p1W8krlu4oPHubO7hmJlR73J1JVyQAy9PFCerNc?=
 =?us-ascii?Q?2FRof9/YeFcXzJzzHK8Q1e5bnnPXAFbUqa61qsXV/1Wnkzfa+R73Q4js71RZ?=
 =?us-ascii?Q?qEvpdbq/QATFP3dTX+tVh+sk2/lk0b59CTt112ZYH7d6m1l5hCI6SSx0ZeYO?=
 =?us-ascii?Q?0BmLd5T0aHxjLqgVcbPsxnHI/YSV5eQYqwvvVwqWQZjYcY5A1glTzOwKLAnU?=
 =?us-ascii?Q?1AOaWgqtuT5XgRtHydgWO6pqUqdOZhO704jNEozh0u8NSlzniXLIdQA6qZmn?=
 =?us-ascii?Q?pFgEalTt9hF/EviKqLsVm3h3lvVVfpaxo3GhdNe9PBsz01TzAFSYaMEecCbh?=
 =?us-ascii?Q?MHMZHgR6XvelZeYZ8l2K6XYSeUHOyez+05Hm5wM0MfyzMSBzDzN6O8rYU8V0?=
 =?us-ascii?Q?lYT9kqnzX3SqrqKcYnOy8tSj7dd3P35oqKyQRV03X38mBeaPbp5nIiBzOwzw?=
 =?us-ascii?Q?J8bwLw8CKVlll6AiNg/wQSydcRuB5I61rxPmUr63gLG4cR0HkjxAokX7KW16?=
 =?us-ascii?Q?Mg9Jke3qQF6tVX19UQyKC1ANIgGF1DkRGdZcnfRQURR5A6HonqXGVXcpen0Z?=
 =?us-ascii?Q?frGrxmeCCBhMi9+9b3+SFL6+37s3gH9ZYSQhZ/pWsGzgVnNda4Ur/mXiJtId?=
 =?us-ascii?Q?v3YBTCkxcI0RgAbRvliikmsMIpuRDf3QaITppTWW1iC3lN/BT6Ej+5V6k1PD?=
 =?us-ascii?Q?50rdJNUOG8H5WbggJaCePvjaeZxgX4Cmu/cy/BM9Ah/59AMQsYAfMEvzD6v2?=
 =?us-ascii?Q?YgwfUn6g2/R7VB0F1p1C2PkJZSSamOh5KX3QtfUI7YcwS6zPPsvHWSkOtXM9?=
 =?us-ascii?Q?5j3XpZcDMfBM2B6puSz2gL8RKgQqOQ/gQiYZivoV71nUIIdnA0GWrjaxYz7c?=
 =?us-ascii?Q?zwnwzcxrfPXOlxSx0eyuMfOOP2c+JY0Nja0lEQTXAfThcs0lny6vbaHG68nw?=
 =?us-ascii?Q?MPIu7iBJrT0eJdgRbSOIhNJgznF+tga8d48qS6VMAAohLk7X4ZmUljtCIjOo?=
 =?us-ascii?Q?g0XbQ2TkBG0c/Py+bbZU1YgkLe+Y25MSKO4K7ZkPwWFvkpSyGahun3/8f3xG?=
 =?us-ascii?Q?zBSKO7yCaYZ9byGFeVfLlh6F+6muby8Mx6LxLyiOzbPPK1Y8VRF5fE7pr+BQ?=
 =?us-ascii?Q?CYdPO90/6O8U6oG09tFD9Psm2mfj4XdpHdtl/jKllSUBPIgU2FVR5YXuntQy?=
 =?us-ascii?Q?DqCDaEta+y+I5KsBH0/b2hveW8W75lizR6cVoxNblw96mNL2dzNqRPa2898n?=
 =?us-ascii?Q?G91GmGmB0/OLYN5UN7x7vtlO0aDrwjorFsXncJH6OjNli03UGTvHly33VlsU?=
 =?us-ascii?Q?YHMz4sBxcb0bjBx8NkM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e128be67-dca4-4df2-5283-08ddb90b1920
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 01:52:27.3546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hd0U/t4cW7pwuQs0lwBKr63i/+RVQT9RlMXaMBwTOIWHw1PSvA2ExOcHdMnLY/psKawsisEmClG+aoIPLGch4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7246
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

Hi Alex,
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Tuesday, July 1, 2025 11:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma: don't actually disable any SDMA rings via=
 debugfs

We can disable various queues via debugfs for IGT testing, but in doing so,=
 we race with the kernel for VM updates or buffer moves.

Fixes: d2e3961ae371 ("drm/amdgpu: add amdgpu_sdma_sched_mask debugfs")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 25 ++++--------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.c
index 8b8a04138711c..4f98d4920f5cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -350,9 +350,8 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)=
  static int amdgpu_debugfs_sdma_sched_mask_set(void *data, u64 val)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
-       u64 i, num_ring;
+       u64 num_ring;
        u64 mask =3D 0;
-       struct amdgpu_ring *ring, *page =3D NULL;

        if (!adev)
                return -ENODEV;
@@ -372,25 +371,9 @@ static int amdgpu_debugfs_sdma_sched_mask_set(void *da=
ta, u64 val)

        if ((val & mask) =3D=3D 0)
                return -EINVAL;
-
-       for (i =3D 0; i < adev->sdma.num_instances; ++i) {
-               ring =3D &adev->sdma.instance[i].ring;
-               if (adev->sdma.has_page_queue)
-                       page =3D &adev->sdma.instance[i].page;
-               if (val & BIT_ULL(i * num_ring))
-                       ring->sched.ready =3D true;
-               else
-                       ring->sched.ready =3D false;


Is it possible to change the write ring->sched.ready  via WRITE_ONCE or ato=
mic_set to avoid the race?
And check val to avoid disabling all sdma queues.
    /* Get current valid mask (reuses _get logic) */
    ret =3D amdgpu_debugfs_sdma_sched_mask_get(data, current_mask);
    if (ret)
        return ret;

    /* Reject invalid masks */
    if (val & ~current_mask)
        return -EINVAL;
-
-               if (page) {
-                       if (val & BIT_ULL(i * num_ring + 1))
-                               page->sched.ready =3D true;
-                       else
-                               page->sched.ready =3D false;
-               }
-       }
-       /* publish sched.ready flag update effective immediately across smp=
 */
-       smp_rmb();
+       /* Just return success here. We can't disable any rings otherwise
+        * we race with vm udpates or buffer ops.
+        */
        return 0;
 }

--
2.50.0

