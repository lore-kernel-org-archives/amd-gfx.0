Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB6CCCFA13
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 09:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80C1910EB2A;
	Thu, 26 Sep 2024 09:09:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lEY9G+mf";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1739B10EB25
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 09:09:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNjIxSuppwnOu7EHBx2blISngF8s4FrLp901KbIGKav5D6cxFh/3Nat+OGm5pGRPaR04ggCwUqziKJuh8c4EvIm9qs70OOf+LQXqxth5ROtKl2LZHLrU7un3Rk8ov7p0Bd8jtKx8de4ApojbkT8qKUfze50B3+SkqEZMIjWK+oqs5QE3kSK0dunwAnZ9zccShH5P3BdLTnh4RhulWBEMInxyl+s+hPOyh/jEGxsXNnuxonfL6n8VqranA3W+Nh/ZwY927Fs4qSKauENNWx42J5xiSxZHn3vCCnCez3mrD5Dpyd97aJ6EPwTanZ1PO3y9Cpnt7omdiAVWvKvdQTWuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0ONiA4zk6JuAYOYgXGSaJO61PSdyZC9izgWHdtHhvc=;
 b=GFKfeeRVTE9VK/eUqgJoQ7vmBCZXVURLU35ebWcswPxtkwGLf26zxC+E/xqaaIls4P7Cn4FdIuWZLA7Sfpxpu8AKuvb2KHSe7KcovrFwuAM28UwPxPOHb+wwpAdHySOLMUJIMNySlybE0t5NodKFBLIfCOTLd9TpxCeHEYJLLMZdzl6lOAbzGusG+LvrIheRwDrgsOPgTqxRd8F1+FbjAe1CmCBR6hWxnR6GfOtmTL+ZtKsCE1dQ63wgxQAzwJ1BYVZBTTAcsRSg+Dwv95xPQ6IZ4yPAqMz1LfWQPs+CO43mb4GsnLR8j+l/7SNFiUkIt7fH6bz4NjlBev4k/pHIkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0ONiA4zk6JuAYOYgXGSaJO61PSdyZC9izgWHdtHhvc=;
 b=lEY9G+mfgscdrJ4fHDWIgBPW8NM1VC+xardE3Jb6Jc2w0b4SNG2R2GKso2yx4I5u44EJUlma2k6n7PcJqhQDkg7MEXjGFiyf6j8+pFTtUnwOFWxxqulAkRlZB2YMzPPYqy4y55DxGdepRdJxnFgrGfKIGHiyrTbkW1YIwG6UMWY=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 09:09:20 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8%6]) with mapi id 15.20.7982.018; Thu, 26 Sep 2024
 09:09:20 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>, "Errabolu, Ramesh"
 <Ramesh.Errabolu@amd.com>
Subject: RE: [PATCH 2/7] drm/amdgpu: Add PSP interface for NPS switch
Thread-Topic: [PATCH 2/7] drm/amdgpu: Add PSP interface for NPS switch
Thread-Index: AQHbDkakGobRCvj6Mkuck538oXwJl7Jpyulw
Date: Thu, 26 Sep 2024 09:09:20 +0000
Message-ID: <CH2PR12MB41526605BBB5ED915AEB7F8BFE6A2@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
 <20240924055652.2678433-3-lijo.lazar@amd.com>
In-Reply-To: <20240924055652.2678433-3-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=cda30979-b007-4b95-b572-272ff59ad943;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-26T09:09:03Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|CH3PR12MB8212:EE_
x-ms-office365-filtering-correlation-id: 65764138-c982-49e5-655e-08dcde0ae7ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?O635HTFdmykliW3s0U3Sx5yuitpa1/3XQAwbvgrCkYSG7c8Qr00tzLg9oovJ?=
 =?us-ascii?Q?dJkjCyATLXmZiAtxu4x/LiRBaYAkyy9JdVsB+gZvTaQdExeZix8kRjA3ep7W?=
 =?us-ascii?Q?B2jiRMW8ylTs/XVCGAy/7BA6blXrZskt65h7/MiotX2fsdOY9s5kP0Odi31q?=
 =?us-ascii?Q?/M8DZQALEUCa9m3zeOjspcd+Yus+5IMDYc4AXqa9iY12XfNcOHj5TSxvNDev?=
 =?us-ascii?Q?qjutHnYExJLAe+jHs8/C63EZV1I05Tq2WZIjPWIA6/Fv+c3Fh5XclwB9hXzE?=
 =?us-ascii?Q?EuOlC2c9D0e9goK8Jsw5j8oaJr1eQK6LYCU4rP9nkKsO7ohok4b4TjD8g/+H?=
 =?us-ascii?Q?ZwVz+RP9LXFyK3bZZwKDjidzM318WgWl6NCiLJr4bQbMZs1kC42o6K3+m8SQ?=
 =?us-ascii?Q?fQVddPWWFo6Z8e0Y6VB9hA/V4VvxynpxYEJPPeHiq6e6M6pY1Bx4fHbnPRsI?=
 =?us-ascii?Q?/boh0HukttscqfZ2KDz/+fzxUrMHHacF3wDWb/SxiosW0l9phc27hc044iyv?=
 =?us-ascii?Q?KitxGqmw3rzQyX1fprXwuxH57o6e9GdIGxOl1wX1LNXePr2JWGoeNyaRWDtm?=
 =?us-ascii?Q?C3+tO98NzWl+5NtJo+hoi5OxFYytNNkxSEWoD1xcn5wx6suQGTkw9KQ4NN93?=
 =?us-ascii?Q?/yEhUtwac5oeDhPUxhVKWLpy6/goIn56wEFYd8buaCTcNPDPGWN/o3noG5pP?=
 =?us-ascii?Q?4ANbYOdjJrWOCVbo6R3bYNCHAuDQMRMQiUmuHn5Mj2Qe+TgvBc+0R3THiqJQ?=
 =?us-ascii?Q?FTDaiZxafrEHz6oGhuF8T6UK53hbU2bgPhKIQKZAAenwRNl83PllesfIn5XU?=
 =?us-ascii?Q?Cqt5je8HbrhhbFkwGwNAcDSYZ4ZBC31BR1wED2+064r3tOd1a0aXVoX3g9Em?=
 =?us-ascii?Q?sa7tckogZZ0sA3XbtOT3xLnBbmZS8V/uX99PLEVjkfeteA4hHbNqBC/TAutr?=
 =?us-ascii?Q?AOi8ez2N5zb3Gs5NgXbFRAJ6fLXoeEix/yYq8KUdQiOjg+ysAZ9ZmT4ikGYT?=
 =?us-ascii?Q?/4Dt2KFy8gK1xqasFzYjlx9pIpm2zzIKZVOuNf1xS3TPLkmX9sUsX1HEGVSI?=
 =?us-ascii?Q?9m7VAr7hOL/WvT8fTBLsX4hwClgR9jAm4r5f/z8jgyU3MZvQoEaxPlVXEHqk?=
 =?us-ascii?Q?mXVUlUDTkLazm9Kd0kpmk2HLXLzmiguX4pYFquzXt7IJizIOZqvvecOvUCG0?=
 =?us-ascii?Q?RkTnjxnIP2miJhW6UfMQs8tBLh/7dmV47yUB0VG++yoE+FqcC7bBbS5yqMgE?=
 =?us-ascii?Q?gXovFVgmbhcDHb3Lnh49nnwJRn4n38MRzDQ7DYzwj3hJkUt6Tgv9g+4qqsqm?=
 =?us-ascii?Q?YcA02PcuPlsaHBdfANM1owlVaeR+4Fdoz3OrnqKJ5dT2Y02RY3z39EsyH97e?=
 =?us-ascii?Q?f40AVN6Jf5O+GPFZ6TO1IFFMlORSRrW/2XgBZNNfy3eRrj88nA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DV70Pl4qnhy8h0/qdkaoU98C6AKaF7g+Bxvj2gof8UnyBv8ypartjI6qUBXi?=
 =?us-ascii?Q?d1ycbaVEMRoyG7uqAMHB0R+Jj8BTaUffe6R1REokVNduacc2BbcoX/+ILHkE?=
 =?us-ascii?Q?pgv4LQM1ZB0xUaqXmMjjSMWne7iK17apGN6aRsPzSy++VSiH+y3QX/OOAfcO?=
 =?us-ascii?Q?XdJnYe1n5NVzzkdeeuNgwX5O6UGr6275jNEfyE9NaS1MdZA2YcNHnZogPJAn?=
 =?us-ascii?Q?QrO4CLEs1k8I9KmH6gE6C0UNA92T0ccohyDz4Or+EN5Rt/3Ud1xl1QH+8Ipm?=
 =?us-ascii?Q?+tM63rVka2UhHjPO3s4RfnmUPF2OIvc1NwrLW52TRaK6bFQeuUvBc40w2cFW?=
 =?us-ascii?Q?LqI8mqw1sQvDwDbIyon2ujRzG7K3Zah05b93LzovCmEdh4xq79vjuE97ocs2?=
 =?us-ascii?Q?h8rEWpQMS5G3Gnmm5Ha8/KzTCslVILIlSgQKPRlbJnmzdw0y3jqIOYsEHrdx?=
 =?us-ascii?Q?m7ftJNakkfS4RtuJF2j1a1q4BYaeMEEIqCw7nW9Oi6evYazjzOX2sj0CDJNl?=
 =?us-ascii?Q?FOb58kjs+1+MP9zBMO3D40YQKsL/s51Lm9yonq6oJ7qXYG8TxIZ4urY/7VKK?=
 =?us-ascii?Q?Rwij6tp0omJT8S8ZRMiW60bCaxqFyalNOFmvqa1XLCBPHMfak7rTx94Deh2f?=
 =?us-ascii?Q?dh+6fjh5UjOcRfVoXuoJvo3OfW4pL6GJv/ldVyKwTrU5IaRXpk9XMA+OYZLn?=
 =?us-ascii?Q?aMYZoy2KjXqkQbpwc4fqCPi/mon5h8pr4aMirXpHZa7wMCq+taQiU0x0HL3O?=
 =?us-ascii?Q?ERCFiug1GsPQoMUy6U0fJu9e3H+4yB6JzOS5PHJPxBURDjC33cTDv1wkNc5p?=
 =?us-ascii?Q?zLFLShTMmL9qGFU7sN78nxIrrFquksM0cxsE4UkT5exGMkhjyoVAY5InBFN/?=
 =?us-ascii?Q?i7sXjV38Q1SRo1lpFdv3Jdvi5KssyCZP2z3JtgB+BxMvITYS5sHPFzDBmRod?=
 =?us-ascii?Q?E5ypxJEkpCD3R2/fLgXKibgrLVeDMhuVxUzNQam9RL/XtJz2TX6LAFulFwDJ?=
 =?us-ascii?Q?Ixb6Vhqlr9FAE3mP+IHJ6lZr5w7YQhxCI22XPU9V20jYRUC84RIIiwU9k8iy?=
 =?us-ascii?Q?iJz+cDGW8bMqPfaNMzSbhPZjMofr1pof9PuWQmqfQgEKUOlNjhzQOSTX/Dda?=
 =?us-ascii?Q?zXpVzlE4BAf4npr0DJRd08gyPUlptjv3OHJ7Sf9HdW2JtCkUJQ/0ZVhfGybj?=
 =?us-ascii?Q?X76O9UXQ8AAe0RTUJWfIUxHpZWsw9HFi0miq9TmZ6vzTJyc0ZHnIBQEKNu5C?=
 =?us-ascii?Q?GKChXcVyXVQ1mzIejUu1ZR9idqOigoTqt9J5MZaxrLmN8zthzYKmPi7pldFU?=
 =?us-ascii?Q?KkLQmb/ZWY1wv4igFTiq21a01ddvpg+KNlqTt3palpV9JiXQp4m2DZ5JMWU+?=
 =?us-ascii?Q?4EO8/0zYwZ8dmZoClH/1WprhOGApF/3Z1vd6XDqzr+hyjWeVB6EZOsbLJnSs?=
 =?us-ascii?Q?UB5Xvp5L1+kOGe2cmnofjEzEzLo+7mWaosOOdijKplHlJdhUKF3pUKVtSLeL?=
 =?us-ascii?Q?rU7kgsv7Cq4BX9bqfsO0k1xa1O0bOKf1DZOC0p5E+ACgPNWF4RnoOMOett0Q?=
 =?us-ascii?Q?lwKOCXeOuWmxbClivV0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65764138-c982-49e5-655e-08dcde0ae7ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 09:09:20.1342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lds9cwA9BAKK0FLVF9BQstUZ0/0cAfoEE0muB/0CQbbq2LPFV96gRKvcGfzqWgrn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Tuesday, September 24, 2024 1:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Bhardwaj, Ra=
jneesh <Rajneesh.Bhardwaj@amd.com>; Errabolu, Ramesh <Ramesh.Errabolu@amd.c=
om>
Subject: [PATCH 2/7] drm/amdgpu: Add PSP interface for NPS switch

Implement PSP ring command interface for memory partitioning on the fly on =
the supported asics.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 25 +++++++++++++++++++++++++  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 +  drivers/gpu/drm/amd/amdgpu/ps=
p_gfx_if.h | 14 +++++++++++---
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 944dad9ad29f..04be0fabb4f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1045,6 +1045,31 @@ static int psp_rl_load(struct amdgpu_device *adev)
        return ret;
 }

+int psp_memory_partition(struct psp_context *psp, int mode) {
+       struct psp_gfx_cmd_resp *cmd;
+       int ret;
+
+       if (amdgpu_sriov_vf(psp->adev))
+               return 0;
+
+       cmd =3D acquire_psp_cmd_buf(psp);
+
+       cmd->cmd_id =3D GFX_CMD_ID_FB_NPS_MODE;
+       cmd->cmd.cmd_memory_part.mode =3D mode;
+
+       dev_info(psp->adev->dev,
+                "Requesting %d memory partition change through PSP", mode)=
;
+       ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+       if (ret)
+               dev_err(psp->adev->dev,
+                       "PSP request failed to change to NPS%d mode\n", mod=
e);
+
+       release_psp_cmd_buf(psp);
+
+       return ret;
+}
+
 int psp_spatial_partition(struct psp_context *psp, int mode)  {
        struct psp_gfx_cmd_resp *cmd;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index 76fa18ffc045..567cb1f924ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -553,6 +553,7 @@ int psp_load_fw_list(struct psp_context *psp,  void psp=
_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size);

 int psp_spatial_partition(struct psp_context *psp, int mode);
+int psp_memory_partition(struct psp_context *psp, int mode);

 int is_psp_fw_valid(struct psp_bin_desc bin);

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/=
amdgpu/psp_gfx_if.h
index 604301371e4f..f4a91b126c73 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -103,8 +103,10 @@ enum psp_gfx_cmd_id
     GFX_CMD_ID_AUTOLOAD_RLC       =3D 0x00000021,   /* Indicates all graph=
ics fw loaded, start RLC autoload */
     GFX_CMD_ID_BOOT_CFG           =3D 0x00000022,   /* Boot Config */
     GFX_CMD_ID_SRIOV_SPATIAL_PART =3D 0x00000027,   /* Configure spatial p=
artitioning mode */
-       /*IDs of performance monitoring/profiling*/
-       GFX_CMD_ID_CONFIG_SQ_PERFMON =3D 0x00000046,   /* Config CGTT_SQ_CL=
K_CTRL */
+    /*IDs of performance monitoring/profiling*/
+    GFX_CMD_ID_CONFIG_SQ_PERFMON  =3D 0x00000046,   /* Config CGTT_SQ_CLK_=
CTRL */
+    /* Dynamic memory partitioninig (NPS mode change)*/
+    GFX_CMD_ID_FB_NPS_MODE         =3D 0x00000048,  /* Configure memory pa=
rtitioning mode */
 };

 /* PSP boot config sub-commands */
@@ -362,6 +364,11 @@ struct psp_gfx_cmd_config_sq_perfmon {
        uint8_t         reserved[5];
 };

+struct psp_gfx_cmd_fb_memory_part {
+       uint32_t mode; /* requested NPS mode */
+       uint32_t resvd;
+};
+
 /* All GFX ring buffer commands. */
 union psp_gfx_commands
 {
@@ -376,7 +383,8 @@ union psp_gfx_commands
     struct psp_gfx_cmd_load_toc         cmd_load_toc;
     struct psp_gfx_cmd_boot_cfg         boot_cfg;
     struct psp_gfx_cmd_sriov_spatial_part cmd_spatial_part;
-       struct psp_gfx_cmd_config_sq_perfmon config_sq_perfmon;
+    struct psp_gfx_cmd_config_sq_perfmon config_sq_perfmon;
+    struct psp_gfx_cmd_fb_memory_part cmd_memory_part;
 };

 struct psp_gfx_uresp_reserved
--
2.25.1

