Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B50FFEDA0D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 19:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D016F10E22C;
	Tue, 17 Mar 2026 19:20:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O3yyQ/i/";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 148C210E45B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 19:19:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0FO7OLXIL1CErVg0/MSyslsBDAr0P9dzUGgV+J+etowxFdVs15XtsbmtP0ofaS/91EzRnUyuFhgUHxTAGiBgBNfmOahHOFKxKIhE3mJ3iTpInRue78GRJahWSpoKupGcF8P4bfNvc7RB5DveinZKAufOoRIrIK+ojytX6zMvQRKftE7gjHQXPqG/fjtmfTaK0BuktcKrDy6qZSssDT8zjOU0j6VYSDb8y4paJM4AnOQe7gqeYcVjXS7PY4pljXm3h/bOl0v9b4NyQ/ArweURbBDoYvHsMxYehtlDD1R4RzKYpmPzBSSG1FJNaXoZmX+9uBk5uXMOOZ+IMmpeTfc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSugl8KKhcBOMxKhGjChQGho48Go5XGjkgCCf8v5TCY=;
 b=Ix0izwzIMMBRCA33wxqZItgJU43U8Daq4v4W1M4uf6PUuDyjYQVEVAs/YQYyJYOL39MB+MYm7zozo7MxcaOSjeIZS08tegrm/L63r6ZS/bkK7uEatqoDOGGl9uwRIn5aDWpp3v7WK2//eV54Vv3Z7Ecrjb45Tjk5UK81ve+3rOSoyPhraqi9TuTYrNmaN09XCtNqXpuR5FUZE+cPmtUA33R0mP5bOOWN7Lf7nqTgFw8Gcjsd6nUy4KcAuBUKzFy5KA/oqbNEsLlJC3PYamCyfpK4vXOQnOH5gnBakvtccDyZeYBZTvWL3zuzDVnbWi1hS6p7+n3WJzRZYgEIEhQHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSugl8KKhcBOMxKhGjChQGho48Go5XGjkgCCf8v5TCY=;
 b=O3yyQ/i/wCqCLz7f5Pk0AN+plaYwG5elKdqVL3ubVBbWAvQuUwWAhSA5HmpyBTEKwSo5utwdoH1NwVbIPFXSkOwrqCZe8VvRqZFT1lpYb5vxbIGZ3RUCu8ijQSxrf4q9nKJdxDUcjeVPKN61P/Msquz1Q39mwR7mE38YdYC8wEw=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 19:19:54 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%3]) with mapi id 15.20.9723.013; Tue, 17 Mar 2026
 19:19:53 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Ma, Bing" <Bing.Ma@amd.com>
Subject: Re: [PATCH 17/17] drm/amdgpu: add profiler/spm support for gfx9_4_3
Thread-Topic: [PATCH 17/17] drm/amdgpu: add profiler/spm support for gfx9_4_3
Thread-Index: AQHcop5ljkqzJ8OO+ky5aIIGTI5k+bWzP3WK
Date: Tue, 17 Mar 2026 19:19:53 +0000
Message-ID: <SA1PR12MB8144E2E698FE2A2D21A99179EF41A@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260220192236.3121556-1-James.Zhu@amd.com>
 <20260220192236.3121556-17-James.Zhu@amd.com>
In-Reply-To: <20260220192236.3121556-17-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-17T19:19:53.149Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|MW4PR12MB7357:EE_
x-ms-office365-filtering-correlation-id: 6878e019-a605-4482-350e-08de845a2b17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003|7053199007;
x-microsoft-antispam-message-info: 8PnRXZonN3IBYRbcRw+3eywTpXFxJBqK2r45giT+2LB8qc1Bv56G7nvLFh1corv10ui2xLINunoNSsNIdcE/Rhg1lWsFBEsZDQ2MsnZixhpYlFCqGtWs+0FzTvFRVMFk5/LG2+6prhu71Gy5KvRnxfsAIQmHkhYUcfiJ/o0NQX6YoHFrgzLE5nh9Q6HK58u8NoBwLK3/nW7YBlG5zmcuOO8WrDwl4p8lnF6LyqggAegCQE3csIK9VXEXpNa58xbGf6QO+VRFCTd4cCJta/A+d30vphzbdhgQQvM4SwmXFK3uNrhwn1T5sjewXjFGAz5yC7tEfB1nnptGeO1CgiosvnH3/ZSiQ+0oi9adOGF6iIYM2jLYY6RQ2mVHLGWtXxiw1YzItmhy4FBW0a3Gog8RFaCpOwh6uMZLVaBRo4AffwLHDksZUgZojbbhpW6ZPaJ3rxFM6K+DcWTXIAfB9/X2PIUi3Uq7R+rr8SCPabtZ7+mgoepgzpO4xW9sWd+i3m7WMp7eb6BW0AzMQrrPF5Op1oVxKZvKeqq0BezbG9Fsg3sontCQxW7s+CE+XfYslJQJTRPwcPcuVrOCoiCPvovw3S+YkwcbeXQYka7zKuVP9f/tq4mpLpzz7P0yqqivXUKIWMoHq37VdeJuEWsJHAKNmDOmiJQX5Ufosld2oTZq4/bYRlj7XHJ/Tfk0WjHuIFMVMSkVTLLsB6OrKDxoSvtdxBbDG/j0eJuYHxGc+Suql26R02PvVisEGIOuTlMUq2lx+gaP2dqK3nOwijDnW4aZ+SfqjVh6b5BsG8x3u2rtNUU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n9NBX6DDFCoDEzrS/quBXT+fJfcqj58nlakZN35EqvG7N3vmUGWt0ycyeY1J?=
 =?us-ascii?Q?MJc7P1JzG6OxC6UZlOaAXLY+mrLbs4hQXiWjWrUoQyHAZAPSwX/lONn6qH88?=
 =?us-ascii?Q?Z8BN7ZeTmjqrGOo6J6X9GYuML8D3XxFRsF1YTnjkjEybm0ITzrDOcQ9f42b6?=
 =?us-ascii?Q?irKNdDpUTwMEIM4jYGGTHQNNt43oPq/jpFrQ3l5QoGtGcOQixJeJvAvvKdSZ?=
 =?us-ascii?Q?Q58r6E7CRur/a8KUXcyqnBqltReI/OHRrezwnk590v8ULl+p8C7+pZfm6K/O?=
 =?us-ascii?Q?r1z8JnfV+KB5/GbFmKr5PVKsco16l8IBcH9DJBR1M4m7XuPj35c3942778AL?=
 =?us-ascii?Q?414zuS2sXVr5vfkQdNMAO2X0CMO/dH06zyaQFJjYFsNs+Iyrnhgqiu8i+Aha?=
 =?us-ascii?Q?rqifWL4TGeXrQwmPv7i/+xyoAC8LmYc6qzOmWmYbgxRwFFvoT9na6Ii70LgF?=
 =?us-ascii?Q?gtaZy6FUzvQw877K3Wat/4IMFfZ5buniIbmkF25Oa3kUt0efx+NprXr5ShGU?=
 =?us-ascii?Q?7cLMXxKW7jy1OO1fCtm2b20pj5L3qXBBGvioGjq3z21Ova7XBpJukiI30181?=
 =?us-ascii?Q?MkHhq/ZpX9NQ6f8YxYiCo4F5jCD5rtzRHP+hA1RKZ1B+sYQOpfTvO0c6JTUa?=
 =?us-ascii?Q?G/SKsqgbc0Dq0QteC7WTMVTyOJfKPUR8sji8HPffUETdDF8Wpp6T24FRP7hr?=
 =?us-ascii?Q?zQ6NY430u9Kr7ZSrjQA+nbVe6yZhMx4hlCa+qG0crczouUb2iX6V1iVFjs7U?=
 =?us-ascii?Q?RJcElgJ32IUetsqDh/IxlrdmFWNw0ADd6kS/wCS2hNCc9d6mU+wnYXBooMV3?=
 =?us-ascii?Q?Vy8WjsNx9wPD3+u2O5gmog++BRd1Q5A8W2MLlETnDNY31oUrfYTA9iWEhtlm?=
 =?us-ascii?Q?+DPeKbAHMFiBrHYwbwBcnq+8u1yimYtCcjfAb0bMdk3yuTMv2wO5EBFZU0zF?=
 =?us-ascii?Q?+sN4g0EiXoUjaDTKhmIAmvVZE+RPQdF6pKabt3chdJKKfN74fUw9mrsmrWW1?=
 =?us-ascii?Q?WGs4HeV0uuO8uGs37C3JvOkx39Ipf0/rjO0od+xLG9/GcMZPei0DZwruCvRz?=
 =?us-ascii?Q?t6E43wKeX7/u/VVvNPm/dC2UcDeRJ8EiTIRpOp3GzKKqH27j3RLNDzmobQOm?=
 =?us-ascii?Q?DOrKX6U2HAj578nG6Yl6+RCDq/bX4dV5Q1EXuQ8jH/wLUbBxtkyceFfW1pB/?=
 =?us-ascii?Q?NSBdmSCS7Z39uFvOrtk7+hm5y0urZC/uRt/W7gCn0VM8aB4yDZIqD800ISOH?=
 =?us-ascii?Q?PD9OlrnsiwJuqBxkFzB4iFnQoH2CTHkROMcR+zHD37YGLqlUi0/6H0SY7NBP?=
 =?us-ascii?Q?7GMQkXVllpISro+oWKrODSML80MwBFpgYePhs8ghTR/F3QnNnvlPsIoxG+BV?=
 =?us-ascii?Q?KSCq09lhiSAEmd6Yx8Jxpoj9QBO6clhXAXVJ1UVgvxATZ94XgnNxzwu7wK+X?=
 =?us-ascii?Q?j3qRttqYuf177FZwo2VEt58SYG+5/DVm/Bf9GS+U8seo+xsvZzK3ptjzx8eK?=
 =?us-ascii?Q?a4bChbPvqi70SgUhRxfHxIlUNwB/WW9Y14BNHWpkm80eaem8nWgxwmNzgI1C?=
 =?us-ascii?Q?jxi7y+BwVwKvFQJqu3UO+kl53LmWUzH18C+6MaRR53MC14lqFJD8v+TP/D+7?=
 =?us-ascii?Q?1T02qUJLZ2h1gyrfynjyKm7Woqd7JT4n7Sk284R5uUsKtJbe8BVAARmLvf3O?=
 =?us-ascii?Q?+JfkHjOic7hhwP6VX9UPANqXt8GD8l9jYDxqdPMSRmzLuGuK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6878e019-a605-4482-350e-08de845a2b17
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 19:19:53.7916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EyDVR02ibquQ7eCCroltv9nTxeZn/tsHfhDLVKs5zSnGiKLNGhzXlIexKtd5FepR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
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


Have skimmed this patch set. Generally looks normal; another hardware block=
 with the usual functionality.
If these pass basic tests, they're probably fine or at least not harmful.
Some general comments:
- The commit descriptions aren't very descriptive. I'd at least like to see=
 documentation of the ioctl interface and a brief notice of what SPM is som=
ewhere, and some more words on what each patch is doing
- Patch 5/17 adds a way to allocate GTT-type memory through amdgpu_vm. This=
 seems sort of out of place with the rest of the patch set. Why is it here?=
 And why can't we just use the existing amdgpu_gtt_mgr?
- Patch 14/17 reserves extra space and puts magic numbers in it to avoid a =
page fault. This seems like a workaround for something; at very least I'd l=
ike the commit description to describe the problem this is solving in detai=
l. I'd also prefer if there was a solution that didn't involve poisoning en=
tries with magic numbers and checking possibly invalid memory.

Thanks,
David

________________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of James Zh=
u <James.Zhu@amd.com>
Sent: Friday, February 20, 2026 2:22 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
Cc: Ma, Bing; Zhu, James
Subject: [PATCH 17/17] drm/amdgpu: add profiler/spm support for gfx9_4_3

with spm function interface and spm irq.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 194 ++++++++++++++++++++++--
 1 file changed, 183 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 44b07785bf9c..29fd5e2413da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -169,6 +169,8 @@ static void gfx_v9_4_3_set_gds_init(struct amdgpu_devic=
e *adev);
 static void gfx_v9_4_3_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
                                struct amdgpu_cu_info *cu_info);
+static void gfx_v9_4_3_update_spm_vmid_internal(struct amdgpu_device *adev=
,
+                                             int xcc_id, unsigned int vmid=
);
 static void gfx_v9_4_3_xcc_set_safe_mode(struct amdgpu_device *adev, int x=
cc_id);
 static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev, int=
 xcc_id);

@@ -1065,6 +1067,13 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block=
 *ip_block)

        num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);

+       /* SPM */
+       r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_RLC,
+                             GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRU=
PT,
+                             &adev->gfx.spm_irq);
+       if (r)
+               return r;
+
        /* EOP Event */
        r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__S=
RCID__CP_EOP_INTERRUPT, &adev->gfx.eop_irq);
        if (r)
@@ -1453,10 +1462,14 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(st=
ruct amdgpu_device *adev)

 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 {
-       /* init spm vmid with 0xf */
-       if (adev->gfx.rlc.funcs->update_spm_vmid)
-               adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
+       int i, num_xcc;
+
+       if (amdgpu_sriov_vf(adev))
+               return 0;

+       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
+       for (i =3D 0; i < num_xcc; i++)
+               adev->gfx.rlc.funcs->update_spm_vmid(adev, i, NULL, 0xf);
        return 0;
 }

@@ -1631,14 +1644,15 @@ static int gfx_v9_4_3_xcc_rlc_resume(struct amdgpu_=
device *adev, int xcc_id)
 {
        int r;

+       gfx_v9_4_3_xcc_rlc_stop(adev, xcc_id);
        if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP) {
-               gfx_v9_4_3_xcc_rlc_stop(adev, xcc_id);
                /* legacy rlc firmware loading */
                r =3D gfx_v9_4_3_xcc_rlc_load_microcode(adev, xcc_id);
                if (r)
                        return r;
-               gfx_v9_4_3_xcc_rlc_start(adev, xcc_id);
        }
+       gfx_v9_4_3_update_spm_vmid_internal(adev, xcc_id, 0xf);
+       gfx_v9_4_3_xcc_rlc_start(adev, xcc_id);

        amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
        /* disable CG */
@@ -1666,28 +1680,38 @@ static int gfx_v9_4_3_rlc_resume(struct amdgpu_devi=
ce *adev)
        return 0;
 }

-static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev,
-                                             int inst, struct amdgpu_ring =
*ring, unsigned int vmid)
+static void gfx_v9_4_3_update_spm_vmid_internal(struct amdgpu_device *adev=
,
+                                             int xcc_id, unsigned int vmid=
)
 {
        u32 reg, pre_data, data;

-       reg =3D SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regRLC_SPM_MC_CNTL=
);
+       reg =3D SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPM_MC_CN=
TL);
        if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtime(adev))
                pre_data =3D RREG32_NO_KIQ(reg);
        else
-               pre_data =3D RREG32(reg);
+               pre_data =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_=
SPM_MC_CNTL);

        data =3D  pre_data & (~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK);
        data |=3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC=
_CNTL__RLC_SPM_VMID__SHIFT;

        if (pre_data !=3D data) {
                if (amdgpu_sriov_is_pp_one_vf(adev) && !amdgpu_sriov_runtim=
e(adev)) {
-                       WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, inst), regRLC_=
SPM_MC_CNTL, data);
+                       WREG32_SOC15_NO_KIQ(GC, GET_INST(GC, xcc_id), regRL=
C_SPM_MC_CNTL, data);
                } else
-                       WREG32_SOC15(GC, GET_INST(GC, inst), regRLC_SPM_MC_=
CNTL, data);
+                       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_M=
C_CNTL, data);
        }
 }

+static void gfx_v9_4_3_update_spm_vmid(struct amdgpu_device *adev, int xcc=
_id,
+               struct amdgpu_ring *ring, unsigned int vmid)
+{
+       amdgpu_gfx_off_ctrl(adev, false);
+
+       gfx_v9_4_3_update_spm_vmid_internal(adev, xcc_id, vmid);
+
+       amdgpu_gfx_off_ctrl(adev, true);
+}
+
 static const struct soc15_reg_rlcg rlcg_access_gc_9_4_3[] =3D {
        {SOC15_REG_ENTRY(GC, 0, regGRBM_GFX_INDEX)},
        {SOC15_REG_ENTRY(GC, 0, regSQ_IND_INDEX)},
@@ -2373,6 +2397,7 @@ static int gfx_v9_4_3_hw_fini(struct amdgpu_ip_block =
*ip_block)
        int i, num_xcc;

        amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+       amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
        amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
        amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);

@@ -2507,12 +2532,112 @@ static void gfx_v9_4_3_ring_emit_gds_switch(struct=
 amdgpu_ring *ring,
                                   (1 << (oa_size + oa_base)) - (1 << oa_ba=
se));
 }

+static void gfx_v9_4_3_spm_start(struct amdgpu_device *adev, int xcc_id)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[xcc_id].ring;
+       uint32_t data =3D 0;
+
+       data =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_SPM_PERFMON_=
CNTL);
+       data |=3D RLC_SPM_PERFMON_CNTL__PERFMON_RING_MODE_MASK;
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_S=
PM_PERFMON_CNTL), data);
+
+       data =3D REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+                       CP_PERFMON_STATE_DISABLE_AND_RESET);
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_PE=
RFMON_CNTL), data);
+
+       /* When SPM is reset, RLC automatically resets wptr to 0.
+        * Manually reset rptr to match this.
+        */
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_S=
PM_RING_RDPTR), 0);
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_S=
PM_INT_CNTL), 1);
+
+       data =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL);
+       data |=3D RLC_CLK_CNTL__RLC_SPM_CLK_CNTL_MASK;
+       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL, data);
+}
+
+static void gfx_v9_4_3_spm_stop(struct amdgpu_device *adev, int xcc_id)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[xcc_id].ring;
+       uint32_t data =3D 0;
+
+       data =3D RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL);
+       data &=3D (~RLC_CLK_CNTL__RLC_SPM_CLK_CNTL_MASK);
+       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL, data);
+
+       data =3D REG_SET_FIELD(0, CP_PERFMON_CNTL, SPM_PERFMON_STATE,
+                       CP_PERFMON_STATE_STOP_COUNTING);
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_PE=
RFMON_CNTL), data);
+
+       data =3D REG_SET_FIELD(0, CP_PERFMON_CNTL, PERFMON_STATE,
+                       CP_PERFMON_STATE_DISABLE_AND_RESET);
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_PE=
RFMON_CNTL), data);
+
+       /* When SPM is reset, RLC automatically resets wptr to 0.
+        * Manually reset rptr to match this.
+        */
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_S=
PM_RING_RDPTR), 0);
+}
+
+static void gfx_v9_4_3_spm_set_rdptr(struct amdgpu_device *adev, int xcc_i=
d,  u32 rptr)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[xcc_id].ring;
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_S=
PM_RING_RDPTR), rptr);
+}
+
+static void gfx_v9_4_3_set_spm_perfmon_ring_buf(struct amdgpu_device *adev=
,
+                                           int xcc_id, u64 gpu_addr, u32 s=
ize)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq[xcc_id].ring;
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(G=
C, 0,
+                       regRLC_SPM_PERFMON_RING_BASE_LO), lower_32_bits(gpu=
_addr));
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, 0,
+                               regRLC_SPM_PERFMON_RING_BASE_HI), upper_32_=
bits(gpu_addr));
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id),
+                               regRLC_SPM_PERFMON_RING_SIZE), size);
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id),
+                               regRLC_SPM_SEGMENT_THRESHOLD), 0x1);
+
+       gfx_v9_4_3_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_PE=
RFMON_CNTL), 0);
+}
+
+static const struct spm_funcs gfx_v9_4_3_spm_funcs =3D {
+       .start =3D &gfx_v9_4_3_spm_start,
+       .stop =3D &gfx_v9_4_3_spm_stop,
+       .set_rdptr =3D &gfx_v9_4_3_spm_set_rdptr,
+       .set_spm_perfmon_ring_buf =3D &gfx_v9_4_3_set_spm_perfmon_ring_buf,
+       .set_spm_config_size =3D 30,
+};
+
+static void gfx_v9_4_3_set_spm_funcs(struct amdgpu_device *adev)
+{
+       adev->gfx.spmfuncs =3D &gfx_v9_4_3_spm_funcs;
+}
+
 static int gfx_v9_4_3_early_init(struct amdgpu_ip_block *ip_block)
 {
        struct amdgpu_device *adev =3D ip_block->adev;

        adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kcq(adev),
                                          AMDGPU_MAX_COMPUTE_RINGS);
+       gfx_v9_4_3_set_spm_funcs(adev);
        gfx_v9_4_3_set_kiq_pm4_funcs(adev);
        gfx_v9_4_3_set_ring_funcs(adev);
        gfx_v9_4_3_set_irq_funcs(adev);
@@ -2534,6 +2659,10 @@ static int gfx_v9_4_3_late_init(struct amdgpu_ip_blo=
ck *ip_block)
        if (r)
                return r;

+       r =3D amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
+       if (r)
+               return r;
+
        r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
        if (r)
                return r;
@@ -3404,6 +3533,41 @@ static void gfx_v9_4_3_emit_mem_sync(struct amdgpu_r=
ing *ring)
        amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
 }

+static int gfx_v9_4_3_spm_set_interrupt_state(struct amdgpu_device *adev,
+                                            struct amdgpu_irq_src *src,
+                                            unsigned int type,
+                                            enum amdgpu_interrupt_state st=
ate)
+{
+       int i, num_xcc;
+
+       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
+       for (i =3D 0; i < num_xcc; i++) {
+               switch (state) {
+               case AMDGPU_IRQ_STATE_DISABLE:
+                       WREG32_SOC15(GC, GET_INST(GC, i), regRLC_SPM_INT_CN=
TL, 0);
+                       break;
+               case AMDGPU_IRQ_STATE_ENABLE:
+                       WREG32_SOC15(GC, GET_INST(GC, i), regRLC_SPM_INT_CN=
TL, 1);
+                       break;
+               default:
+                       break;
+               }
+       }
+       return 0;
+}
+
+static int gfx_v9_4_3_spm_irq(struct amdgpu_device *adev,
+                            struct amdgpu_irq_src *source,
+                            struct amdgpu_iv_entry *entry)
+{
+       int xcc_id;
+
+       xcc_id =3D gfx_v9_4_3_ih_to_xcc_inst(adev, entry->node_id);
+
+       amdgpu_rlc_spm_interrupt(adev, xcc_id);
+       return 0;
+}
+
 static void gfx_v9_4_3_emit_wave_limit_cs(struct amdgpu_ring *ring,
                                        uint32_t pipe, bool enable)
 {
@@ -4831,11 +4995,19 @@ static const struct amdgpu_irq_src_funcs gfx_v9_4_3=
_priv_inst_irq_funcs =3D {
        .process =3D gfx_v9_4_3_priv_inst_irq,
 };

+static const struct amdgpu_irq_src_funcs gfx_v9_4_3_spm_irq_funcs =3D {
+       .set =3D gfx_v9_4_3_spm_set_interrupt_state,
+       .process =3D gfx_v9_4_3_spm_irq,
+};
+
 static void gfx_v9_4_3_set_irq_funcs(struct amdgpu_device *adev)
 {
        adev->gfx.eop_irq.num_types =3D AMDGPU_CP_IRQ_LAST;
        adev->gfx.eop_irq.funcs =3D &gfx_v9_4_3_eop_irq_funcs;

+       adev->gfx.spm_irq.num_types =3D 1;
+       adev->gfx.spm_irq.funcs =3D &gfx_v9_4_3_spm_irq_funcs;
+
        adev->gfx.priv_reg_irq.num_types =3D 1;
        adev->gfx.priv_reg_irq.funcs =3D &gfx_v9_4_3_priv_reg_irq_funcs;

--
2.34.1

