Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2186BE7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 16:34:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C605A10E914;
	Tue, 10 Dec 2024 16:34:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vhuUL0SZ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76DAB10E914
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 16:34:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPPnOGuofhpJIV2LxuTSHZNFCGbA3DhcHMLKk6WK+Ts1Dl0hZM04puelFLdwAvZESAp/gNMyglEm/BpGgS1m6bgsB9xsbq5TYX9hjkIY/e3BUHZ1+G7QYk7FYVDeyXX/gJkk61SFJxY6Sqz23J4PtnGP4G7A7hXhg2CAoy1xf85mu+ELaYgAKFVWowRTqhqaUkeliBlD1GNvFVdB5Y/yjGyImnVcbKS2HBG8TTRkuKtV/ajU50FP7rpd1B3RHeXuOWFjNOLb97hOlkzNtiWXOKjQGm7zlDDRnmbmIsO7z+kdCitWLXoKtikpNc0sAQM9/JbwfGVjOQI8bi1LFhQ92w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G721GRaKaQ+CG30QvOqCIBoaw4yF9oEsegojme3STnk=;
 b=U09sZF1Ral/EobjWEIX+Zc8RP3oOaQ4Mc6xuUH/l4eOlqMX/mPQZSd/MxVQ2MP7xJ8Fof1wkS6YKlfxFpfttg3vyRZT4IFdcBf7jQf7ETQR7g4fBpNoaM/zkTR1LF7gX+vfZdgckSuNOxXuOa1EHofZamPxx5NGRt8erv4kTJAnfZaJLEqOlxRPip5rl2a++AH9uGxh3G+5EWTYt52z25GnHedU5VYIksgVSYHt424DaygVz9JSaqfYNWk2vlhiTP1TMbNUnf4QZhZRmWsMvEmXTY1pwx0suwVHSSDlo0aWRaH2vNlop4ktH3tsanfAAGv/aDf9a3HOOmX3SVpuTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G721GRaKaQ+CG30QvOqCIBoaw4yF9oEsegojme3STnk=;
 b=vhuUL0SZ0JznR1QWgKwTcjhyxdxWqZuEWFmwMKwUQVMz7UTr/pAPahQ18v0zFITHofpIrEDzIGKAs2wVlkYLLFW62hIjTHh7soJekaKrJDiyg4qfYD0wUjE3HCpjHBoqwh4mWtoV5R6BTT1gDn7lVvi5I2tJJ24ly+4SqtH7Uo4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 16:34:53 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 16:34:53 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhu, Jiadong"
 <Jiadong.Zhu@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>, "Huang, Tim"
 <Tim.Huang@amd.com>
Subject: Re: [PATCH 7/7 v2] drm/amdgpu/gfx11: clean up kcq reset code
Thread-Topic: [PATCH 7/7 v2] drm/amdgpu/gfx11: clean up kcq reset code
Thread-Index: AQHbStjTJEC0SOcWJk+JSUJ8nm3rL7LfrQ/E
Date: Tue, 10 Dec 2024 16:34:53 +0000
Message-ID: <BL1PR12MB51445FACF797620C8E0C60DFF73D2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20241210075458.2183464-1-jesse.zhang@amd.com>
In-Reply-To: <20241210075458.2183464-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-10T16:34:52.585Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB6585:EE_
x-ms-office365-filtering-correlation-id: 97cd5206-a4d6-4094-dee3-08dd193892fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?LCxt6fz5eMIa4j9wz0ESHIARvu7tfyf2FYRpkIUu+gZg+c57E7B4zCKX4b9F?=
 =?us-ascii?Q?CatWNWYxeTtzgAW9C4k8o/WwU2SDifWzODAVCdgy+7ZOYNJFLxDzxlQAXBJG?=
 =?us-ascii?Q?q39he8yd9llNBtDbOyDqwxsZAkCQ55xiIKvNiw7ssoVs6s05vCgPuWHlgHOj?=
 =?us-ascii?Q?YWtc4vD4oKQB0jK4S+mpUc/wa2KxfyWW0Z04xYcQvLfmTPJTSR+CJ6IWLcqw?=
 =?us-ascii?Q?tNKDfgCTnacB9XO4zb6nLBWBymI1dsFKwB/ehCmKVB6e4trC7whqwzNczYtG?=
 =?us-ascii?Q?/bvL+Bi763iM0TUsF4bmo63z7p8IPU673cl2cYVMMwwZC11gh//GaS/VElHp?=
 =?us-ascii?Q?y82z0JXHezGGeQBsus6uxjm867YN7TRdgjuUnEJaA8B0DIobL5ETir/YK14q?=
 =?us-ascii?Q?F4ACBApI9FlSTpIYhmcLUzhbMGe26wna7hCdybkYSW9t8MG2nzj4fvsiFklT?=
 =?us-ascii?Q?xoU8JT9xuhAbeg8gWuKWOutw4hmwsnG3ANZwLruzXYVo4081P7oNN2KfiH4K?=
 =?us-ascii?Q?ULvDm60VrsMPpVP7go8tVmRmHTwmQa0D80OweSlCX+ahfAJMinSwrVauAy3d?=
 =?us-ascii?Q?YVFddfTz4c78sT7aDHVUuFRkdui1IeHM3iaLS2Sdzn9bMaQu4AQUzOrXWLAg?=
 =?us-ascii?Q?H/FY0sI1nbWDA8XYBjUT7jp6GLuV9fRBpGVK41QO1rGqobu1KWilopMozcYu?=
 =?us-ascii?Q?YEAVzqbIMfjsXspbwCov4hQIGe5reDVWHl7dysokVdlowGtvdzdat7z27QFO?=
 =?us-ascii?Q?hG21HvuUSiGj7PQ6Vg/VvsDFyJI+xNSgMxR65OYlEBZowhYkTgnx+hZ3T7BJ?=
 =?us-ascii?Q?jvKfdAebWVFPYUHwGGRnhxclGJvQ3WbLuJnEcyUsrIJer699WHpozmN7R2kr?=
 =?us-ascii?Q?DKrCToqW6YdOS0wm7hNEexIucyO8+RtoewwnFPHUU68uGwbLQhsvU6MKREPG?=
 =?us-ascii?Q?b/0ux1mFg9cIQZOkFIo9OunvOFT25dh4F7uAEjXb/5f1J2pZjEbIZqXs7cvb?=
 =?us-ascii?Q?lvqUPzXuAUUMI6MrjsG/RYxrXvCxEo9ZbwNwR1Mh5mjimvicM1iTzzM5a9oX?=
 =?us-ascii?Q?jM5PtfntwHC4usaI7izCGRmpDE9rD/2F3cmcSJOL1dC17GRE/rOJElhVi1sS?=
 =?us-ascii?Q?E9UHtDnDUngoZY3g9lkIpjOOOwxHdH7ogyskKmNarE/3aAnXT1fSTjJ0MgSE?=
 =?us-ascii?Q?ufHwYb9QRL/E2pyjOpLQQz0O2dxof3OwKxzQ3CtJLTJsXaDFOmVj9D1HD1hU?=
 =?us-ascii?Q?hWC3k/decAfwi+2qw9Mf+F0O2MYA0QEEBDlB6QsQpTFbWSlnKRMI/HdECbZc?=
 =?us-ascii?Q?jqvDDy/bbnZDvCx4ZoX4ATbtOuUpllqwwbOkgGSZRzeh2POXDmEESpdgSJQg?=
 =?us-ascii?Q?bRUn0SZS+GCl/RZBZS2zuqk0vncARRxOovFQAeoAcX4LyWewYg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SHyG0PwBXDK5u5ZmiVN8+3ysZhc4WrMcNQF1kJsN/1dpYnXfTxW+VRFhc8LB?=
 =?us-ascii?Q?5UomEJcCnkEpfIoVyhwMhdz/LwEjNvXc6ebeV6sFEp4O7ZFw0N7CVd/9xgqI?=
 =?us-ascii?Q?iDOllDHFpRypzpABcicWzzRs3aqXUL46Rw2vjRs3o9kY/Py+wd2TXUCNn5Mv?=
 =?us-ascii?Q?/iLEAEJJ9ggksBGgH7vtsu8VSMmOhVjwN6hPQ5zL5aAE38G22+ONKoFGHUV/?=
 =?us-ascii?Q?9mnXDLF+3q4786ShgLztJGYxTcjCn5t4mYX4EITYqobfQnZIuodBSKP3G16+?=
 =?us-ascii?Q?953ZpIEXQP5kDZJoMhWCF/UnmvSwzpFnpSi+V/O8jxjV+c7ic1l1+rQG/y7a?=
 =?us-ascii?Q?kNuQI22kmGXrXvg0wPW7uY+j7Ns0PFfGpiXtvaOLgs6aVr6AlYHD/YcPCZQn?=
 =?us-ascii?Q?MgdgMCzxsRNFszoYkDQDoSphgyLTvLOPLK5RsJfkfT8SClAC/abEZJQ4WDaY?=
 =?us-ascii?Q?JeKgIR/CXexbsYXqCuiZ23chgX8is2X7zWAYhJNl5voJQtWZ+fI0FaR4G9YS?=
 =?us-ascii?Q?EZlr2gGeeMlmOQy8gA/EyFPSxVkwKRd9NZ36hbETAq9BB77zEGliB5WniEoU?=
 =?us-ascii?Q?fF3KD2iq/p1DyRcyUIdxM/VMA2t6Sb8yWPyoYbJz9rQgQRUzB9f1kMXs33fW?=
 =?us-ascii?Q?bAhkzyhy+HmEGg8LJBlBOQU9RLuylLeXIMNPMw6PlvRL/XY1SNst5A7fVoKt?=
 =?us-ascii?Q?wPtf7bD1JX3MrKrXvychaEuMsm9pwDSjR53d4dneEWNY9TY3TCaYnod78Q/k?=
 =?us-ascii?Q?ACnQ75ilVYGlQOSLn5oYw0mr8Sy316GovDnAFYmV+zuXMhkn7StfX8vEOiCV?=
 =?us-ascii?Q?W4EgNXY121RVQcf62u8PyAkj5SrA+S246NzhF6bkLCueewjz/x0T9mqlHHXm?=
 =?us-ascii?Q?nk0zOeMwnICVyFuacWDcZNRs90EETkX9QZC1nECERS1CHe4S9FEVO+mlORc+?=
 =?us-ascii?Q?1dtSsik0RpyFgxhkQH9tmNumDzQvunnNYTEEYkeRbgKSTxxwGmZ1+yqlpcDA?=
 =?us-ascii?Q?CMxbnH2/dzo+KxzZapvc/GyUNdZQFQx3LBEOulObINdNlJDWhvYlDEwU8Kf6?=
 =?us-ascii?Q?F96Jo9enM6w1CTFra6zsmp2baRoYiym1p3UO36SlPQNkKpE8wgfXWRENRch5?=
 =?us-ascii?Q?CpMAY8CvE3NfbcMvWXVfDKxi1ygPXceVk6pnj32CCsB3es5t+6JrDmCMCjYJ?=
 =?us-ascii?Q?uq6KAfcC7I3WyNGV9jOo29TnZ1lMZdh++jhRFMlxy86Gzo/iO5DUNIzkOLoe?=
 =?us-ascii?Q?kl2HZuxWflxBSAEbOyrlmwm/LnDXivol2HPcn8/ripUx+m074KXaw3w1A4so?=
 =?us-ascii?Q?1aAs02FB8BFIVB5Jdr3kJBqmDhG5ny/31HJSl6SOVMx6mOJj4bASVdNz+5K6?=
 =?us-ascii?Q?NBAVwrqywc3A5Ny/lsb0SFdcFtMUx3Ow9SD1aLXU5tTepHcjiRwLFk1x5MGC?=
 =?us-ascii?Q?3sQVp+/Dlu9fmUu7ufAHnrPJg2EFYNaBwqzg6IEUTf9PF0lVPGsbs6Dvlv0r?=
 =?us-ascii?Q?MkEvq8BWY1sjkkT0E5Fx9OiElWFB1xoBuPair0RL9g/e8VsHIqmqAae5NwIo?=
 =?us-ascii?Q?u+HrFwAKkHOzrUXfRVw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51445FACF797620C8E0C60DFF73D2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cd5206-a4d6-4094-dee3-08dd193892fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 16:34:53.1212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kL05e+4+CCYee5nRGfK91J6dRzPa1kgUfVHWpITMfHLslutD4XMhPvGdY5XIy+KP8I9cPpDWjsed+NR+p1i22A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585
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

--_000_BL1PR12MB51445FACF797620C8E0C60DFF73D2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
Sent: Tuesday, December 10, 2024 2:54 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>; Liang, Prike <Pr=
ike.Liang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <Jess=
e.Zhang@amd.com>
Subject: [PATCH 7/7 v2] drm/amdgpu/gfx11: clean up kcq reset code

Replace kcq queue reset with existing function amdgpu_mes_reset_legacy_queu=
e.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 67cd42031571..b741dcb0a5a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6675,30 +6675,14 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *=
ring, unsigned int vmid)
 static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid=
)
 {
         struct amdgpu_device *adev =3D ring->adev;
-       int i, r =3D 0;
+       int r =3D 0;

         if (amdgpu_sriov_vf(adev))
                 return -EINVAL;

-       amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
-       mutex_lock(&adev->srbm_mutex);
-       soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-       WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
-       WREG32_SOC15(GC, 0, regSPI_COMPUTE_QUEUE_RESET, 0x1);
-
-       /* make sure dequeue is complete*/
-       for (i =3D 0; i < adev->usec_timeout; i++) {
-               if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
-                       break;
-               udelay(1);
-       }
-       if (i >=3D adev->usec_timeout)
-               r =3D -ETIMEDOUT;
-       soc21_grbm_select(adev, 0, 0, 0, 0);
-       mutex_unlock(&adev->srbm_mutex);
-       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+       r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
         if (r) {
-               dev_err(adev->dev, "fail to wait on hqd deactivate\n");
+               dev_err(adev->dev, "reset via MMIO failed %d\n", r);
                 return r;
         }

--
2.25.1


--_000_BL1PR12MB51445FACF797620C8E0C60DFF73D2BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Series is:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jesse.zhang@amd.com &=
lt;jesse.zhang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, December 10, 2024 2:54 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Zhu, Jiadong &lt;Jiadong.Zhu@amd.=
com&gt;; Liang, Prike &lt;Prike.Liang@amd.com&gt;; Huang, Tim &lt;Tim.Huang=
@amd.com&gt;; Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 7/7 v2] drm/amdgpu/gfx11: clean up kcq reset code</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Replace kcq queue reset with existing function amd=
gpu_mes_reset_legacy_queue.<br>
<br>
Signed-off-by: Jesse Zhang &lt;jesse.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 22 +++-------------------<br=
>
&nbsp;1 file changed, 3 insertions(+), 19 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c<br>
index 67cd42031571..b741dcb0a5a3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c<br>
@@ -6675,30 +6675,14 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *=
ring, unsigned int vmid)<br>
&nbsp;static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int=
 vmid)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ring-&gt;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_rlc_enter_safe_mode(adev, =
0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;srbm_mutex);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc21_grbm_select(adev, ring-&gt;me, =
ring-&gt;pipe, ring-&gt;queue, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE=
_REQUEST, 0x2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regSPI_COMPUTE_QU=
EUE_RESET, 0x1);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* make sure dequeue is complete*/<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;usec_ti=
meout; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) &amp; 1))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; udelay(1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i &gt;=3D adev-&gt;usec_timeout)<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D -ETIMEDOUT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc21_grbm_select(adev, 0, 0, 0, 0);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;srbm_mutex=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_rlc_exit_safe_mode(adev, 0=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_mes_reset_legacy_queue(r=
ing-&gt;adev, ring, vmid, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;fail to wait on hqd deactivate\n&quo=
t;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;reset via MMIO failed %d\n&quot;, r)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51445FACF797620C8E0C60DFF73D2BL1PR12MB5144namp_--
