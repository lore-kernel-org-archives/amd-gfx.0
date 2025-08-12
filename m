Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0651CC87FCB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 13:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0AAF10E152;
	Tue, 12 Aug 2025 13:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YDnTnrLW";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACABF10E152
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 13:41:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1x1T15/66QbUjBBWRKLk74VwwnbwmvQFpJEFEbkMN7YbbavXlCJJTYe6+lcJ6Qz9xTpreN1bbA4xiF1ryXvSf1Npz2rWDFq86K6dO60J6TkInKxm4Hay/YuXg6Aa25hZ+c3cwoeXzHADCysWYudRtv7ie8ti/Odfhhj+PRhGVwGmlEkUSvTPx7IrSNs5HCfaheQfiO3Phm+p/7jnWyvl9TVRBSVbOX9JkuByD5uWdXwxIlx/wcTa9tw0MUE3NY5i46H5hN6QowokgpDhILzp47i+OLaO6WZh5SQGI4240lAdJ+d7bwNx+cOwVZG+BhHca/uAAIz/xzqFzQS9TQ9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3i2Z4lIe1eL28/2fEBRRHwibKlf/Wn+oe2wKmZGNuIo=;
 b=j1wBwvV+OR0mkLJNX+MlAaiXVkFrDJLz5jgsMLsd/WnXwmq4Cj50bcNcT2STBSypb7d760oywx8reAA/SQR7Sba8TTcdJxpM6r/rxKkQhWcsRFvSyfwMhOH71b4pSmNtaE7rp3SSEA5C+guwSkmAL1DgplZXZN51FuWk3uSxT9i9zsA1wF3WfzTAbBmDvphMATh+wXWFzVZi538eh3QAravOW9//qJ36uiI69TNmeYw/wYPW5jG10CrCyBjUDIN2PS2iqcXz9AIcTN9kY6rN01IRMGJWU7FF/T7xXiANIS67Zd2q4kHCeLYUwAA/8LPQiypWvtM8KJ0vDKJi/2ZZRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i2Z4lIe1eL28/2fEBRRHwibKlf/Wn+oe2wKmZGNuIo=;
 b=YDnTnrLW/3bCBMQ4WmohRjmO63tfWKckHAHVxNBRumZK0ZRp5g3jC6fgUWbKkGtuRVgZhpZp5R1VuTYk5pQTQdZTeYECyhtcbbCzXtaquRTAzwKGQVsANHZ/9nJEIk9HO2Kl62JAvaUlXv7yzX60daZqTTZoK9RfsHXbdD4KPiw=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by LV5PR12MB9753.namprd12.prod.outlook.com (2603:10b6:408:2b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 13:40:58 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%6]) with mapi id 15.20.8989.017; Tue, 12 Aug 2025
 13:40:51 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Zhou, Heng" <Heng.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Zhao,
 Victor" <Victor.Zhao@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "phasta@kernel.org" <phasta@kernel.org>, "Ma, Qing (Mark)" <Qing.Ma@amd.com>, 
 "Zhou, Heng" <Heng.Zhou@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix nullptr error of amdgpu_vm_handle_moved
Thread-Topic: [PATCH] drm/amdgpu: fix nullptr error of amdgpu_vm_handle_moved
Thread-Index: AQHcCE/GR01GE8BB+0SO/ZFYrlkafLRfDLPQ
Date: Tue, 12 Aug 2025 13:40:51 +0000
Message-ID: <CY8PR12MB70995746C03CC66E188340148C2BA@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20250808103204.3919298-1-Heng.Zhou@amd.com>
In-Reply-To: <20250808103204.3919298-1-Heng.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-08-12T13:40:34.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|LV5PR12MB9753:EE_
x-ms-office365-filtering-correlation-id: efe01cd3-24f5-4e4b-7b19-08ddd9a5da40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VtjpEQrdfu0M+5ZDx1xvlYE7jqkWgtcrx744W3gVpzfRon43WZIoGbEHNHhR?=
 =?us-ascii?Q?pFtrX7VA50ugmyLM4aOxaYwUsjgctttoRthKDqRmtL6tAqbGxyDDNnfh7cYy?=
 =?us-ascii?Q?LldNrSUvnu9GMXbSp+qu+rxhutbrsz/pE9vAUX4CPbzTeoOnY8rEyrOPZ3Ff?=
 =?us-ascii?Q?lNKnsHH70zm+QRmtkQdt7hMUu9Y+dDb74osIrjbLdknLSnOtn+Z6gI5fZC1d?=
 =?us-ascii?Q?FgxVlER1e3HZUBdKkPDb0YXiQh0SOLVE2T6/FtN/DHIi5ys1D5TpMmYk7bmN?=
 =?us-ascii?Q?lh9eEPlnHrnnQi7T9yb0MYDynNksn3QqYq+bw3rnoENEdEIk0p+Z6UGPSYLF?=
 =?us-ascii?Q?CK+WZOUALofuIPEdCmCCINLAZBCLPm78LLAmKQMabKFrutEEZbkFwPUV96PY?=
 =?us-ascii?Q?0pCYXvJlpYdQS5a4PntJTcNG/+wb8rkn6EWy8kNOFKEoARRs5A19LBt6bsQ+?=
 =?us-ascii?Q?cvukY47LMbEIOd3F94sLjZw06NRsYNB1sV8EfM8Tucp7zdceHlPveJFjvS5u?=
 =?us-ascii?Q?827ks7PwoV0vk4fm+Wb6nHrktEXkgXGKaLXO8B9Ia1i+nykz7R6YyMi7qhVv?=
 =?us-ascii?Q?GgHtKk6SX8AJaXeSKPIE/QciVNJ3Ij1tLAEDA5iaSS4SEWWIkbuhBASoaYlK?=
 =?us-ascii?Q?NJeyPmeAeZ5Lux6IkSzNgJ94gMEqwug+Wy3ipZ49NSBqKqHPaovRiQsFhssz?=
 =?us-ascii?Q?/r0HQut18YtHMEnRFSaXUJw7Pg5RvsFV/TAvS0JJ4RGoP8hfUCXw6rKbQ3Nx?=
 =?us-ascii?Q?AuyDGZ6gQBo4hSeLo00hGdhZnHIcrrSGsMQVSyQMktAMPZkiWlM84kTvTSi2?=
 =?us-ascii?Q?cYvKICbTc10IaSaQxs7Az27b3ks8SIqMeoRWR2S4yWde5AxoH05x4nbmZI/u?=
 =?us-ascii?Q?3s8Jo9FIwJ7e/l6m1+8OHRb7ZA4440jgKoGOKZVHnDSKSmEWMxblu0q06uu1?=
 =?us-ascii?Q?6tV4Dm58ApDx7DrKMxxoIFjApybtJRBx3xeixF8zzNBZDcWEf0srOZDLRYfA?=
 =?us-ascii?Q?xsHPudn92Jnm/CWcPpqmcheMq0/7Ekg1c6ONxQn3e1O0ljnNHxvZFZPDSjjT?=
 =?us-ascii?Q?mVSYjyoHFpd/+CCGk5YsDbmWquSGcfblOOskHaWgoNAryT3Zs9KnuPWYuoW3?=
 =?us-ascii?Q?fAGFUCwZ2ffdfeJ37nPDi1s5/7pgT+By9VncD0kKzQ2b5d6aB+AMW/rOuTt7?=
 =?us-ascii?Q?wXeqO+8gJtSS6P5AH+pAQo7ltCtZ2nXqjdoK69WVJs+EHmZ8f7/aq3r12pb/?=
 =?us-ascii?Q?dBYTFto0YClZPRorKnr6B8VP2DVJnMQ13TDO7LMuYaCkCLLiwcXalUrGg8lI?=
 =?us-ascii?Q?EeAezzr58Ntdl/eKRViWD9cAJvItHt/MOurBFAluGqdLcQ8W7KAU1dJXReWE?=
 =?us-ascii?Q?yFhO3wur2kH0uE46vtZCaT+t46/IQ0olqK8pgD9f7TL/ReSYZOrJskSD9h/Z?=
 =?us-ascii?Q?q//UOr5HVMyclpx59erdZZBgx6jj8CD5iyFYdNhjzBR/SwnmKEnsQpq1tBJ0?=
 =?us-ascii?Q?78zbmby3lbr+Y+I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O5gxwlf3DfAaoKtFvK/RpfI0bwPd8CeMyilMXTVbeDCVSV01g9tXaHd+jw7c?=
 =?us-ascii?Q?JzUVUAUUaxEkr5iGGYbvrFZrC0gBMBds81/8V+lugGA0uJ+SGy9Xclxj6Yph?=
 =?us-ascii?Q?MgOVR7V5BzHifFdSUoemW4/6eWgZV3KgVD+aNC/k3Ela93kz2vdSjM1FoaLW?=
 =?us-ascii?Q?Yu9LcBbtZv5xaVp3F22+9Mug3NFpVx2kqR8j9fRnKH5kaXiCZJmOZTYEmJOr?=
 =?us-ascii?Q?kcA3kJ3mYTR0vwtE8j7pP2T31qJTo/3KwIu9qC3y6ZKvtp3iEtqJaRrKNKWz?=
 =?us-ascii?Q?A7ShdtFcR2DpDBV80ltDvoEZzK/KF6Bingu21ica5+xqDVr+yvapgoVxOOPq?=
 =?us-ascii?Q?nQle4M08N8fbC8Mu16tbeXbd/XSqpyljyPdMymnkwfrtaYyM5fLwW4zXVPw1?=
 =?us-ascii?Q?X50mjuQPaovSBkAiQcAYtjwpErDGNGnyCGNH1C0HJA9Fxn3Souo3O6DsZ549?=
 =?us-ascii?Q?JkVyRXjxtwZvM9TMoXvoekKWkZvZQJUUfyL7rKtPqmSKZbx1ukM4KHYmWCaM?=
 =?us-ascii?Q?vj9qTNp8giLtYz09nvW1FqvhGW+DpJoyEDAGGEYp9jeh+pCfJ2Ip3gRmtKhY?=
 =?us-ascii?Q?+MzTI3lG4SUIPlQ4reul+w8adFtupSrEeqGG5KqXiBt9NHEPKvmiihZBMKMr?=
 =?us-ascii?Q?P8WZSJdDEqAs/nu+WKb83yQ4PQE8tj2JSfvscXHQPOMlKWXcFAOziKb/TE6B?=
 =?us-ascii?Q?M/t1fVJvStdFaEpuusjPnnHUEr7HsLNglEiTdM9sjuFAhi3Q1hlLQO5UmR+m?=
 =?us-ascii?Q?nR6iVSbCVBbdf1sHXZ5fTZ3OWGDSXUROMH2PYJxZ6aOcPQfHNsR2qw1E+zbC?=
 =?us-ascii?Q?pqUVMfLYWPub3D4eEc7YxuDbz+WJjoKekJdUv8VnDC3uLtJBaraboty47T3a?=
 =?us-ascii?Q?v9hFpvBjtj5J8puwjkg1hZ0HcLofqUBYgUW00WzNknAWrUYaeth3led2+n4U?=
 =?us-ascii?Q?zVdh8GL5iRt53QrTW+ON4vpMp8CHv8uusRy+0BLPexGY5ndgyYh3YtxGRSqG?=
 =?us-ascii?Q?7khr0+SqW5zYInCEfyaLISD53URifJe/SWtryDKodqwGbVO96lhaDi1ST76D?=
 =?us-ascii?Q?bv3KOM5P1dHcvOSB4mKy5tErs7Blp5vbVg7c6uytGF16KM1AbRPgl+WJk5sU?=
 =?us-ascii?Q?7ViLWTeKh0kA/ND5cOFTDIZYUDoR7cxEk2/M/++U/v9/TUFvvPVWpzi23Mn+?=
 =?us-ascii?Q?3wm9FBpKw/K9ABdXpCVBXaAFbl7LoGZik1WTfK1hpR1R460NowokCBg6YpdP?=
 =?us-ascii?Q?1lOUJUgBvxVbVIAWtObyVtkW/qgBS+nZUDHAT2cMvDnYARnoe2tRHLWJ4PXi?=
 =?us-ascii?Q?KkPA7NcK7EkzD+GaWgzLUn7qEfcZK3jIfyM4sOe2yUM1eovUoMokOVuU5KP6?=
 =?us-ascii?Q?50dE7T+8aGxAoPxz/fEVjMrwon3Ua21n+uo1tTq9tgPCxRLIoZYSiMVstdor?=
 =?us-ascii?Q?NDyvSAszDE32SQsWb8k9RnhTpI88TvGiO1NCQ78/ao6AbbFdN4jf1pQ4HX5H?=
 =?us-ascii?Q?1TPTGj4dX/DIi+2V6fFb55x63ngggDra+yX2oFAexC3wGGni0tyI0cIb1fFY?=
 =?us-ascii?Q?v/Qt3F7/lFr0cOhwHJk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe01cd3-24f5-4e4b-7b19-08ddd9a5da40
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 13:40:51.0904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZjVPnK1WpQJe9WFyqXYL3dSiSQRsddQfnWzgLUCe1lXZvfHgX268heo6FaTJ4Bo7DjE1//dHxSjXhhRn5LqMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9753
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

[Public]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Heng Zho=
u
Sent: Friday, August 8, 2025 6:32 AM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@a=
md.com>; Deng, Emily <Emily.Deng@amd.com>; Zhao, Victor <Victor.Zhao@amd.co=
m>; Kuehling, Felix <Felix.Kuehling@amd.com>; phasta@kernel.org; Ma, Qing (=
Mark) <Qing.Ma@amd.com>; Zhou, Heng <Heng.Zhou@amd.com>
Subject: [PATCH] drm/amdgpu: fix nullptr error of amdgpu_vm_handle_moved

If a amdgpu_bo_va is fpriv->prt_va, the bo of this one is always NULL.
So, such kind of amdgpu_bo_va should be updated separately before
amdgpu_vm_handle_moved.

Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 37d8a7034a7e..f0af292fa326 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2970,9 +2970,22 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *in=
fo, struct dma_fence __rcu *
                struct amdgpu_device *adev =3D amdgpu_ttm_adev(
                        peer_vm->root.bo->tbo.bdev);

+               struct amdgpu_fpriv *fpriv =3D
+                       container_of(peer_vm, struct amdgpu_fpriv, vm);
+
+               ret =3D amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
+               if (ret) {
+                       dev_dbg(adev->dev,
+                               "Memory eviction: handle PRT moved failed, =
pid %8d. Try again.\n",
+                               pid_nr(process_info->pid));
+                       goto validate_map_fail;
+               }
+
                ret =3D amdgpu_vm_handle_moved(adev, peer_vm, &exec.ticket)=
;
                if (ret) {
-                       pr_debug("Memory eviction: handle moved failed. Try=
 again\n");
+                       dev_dbg(adev->dev,
+                               "Memory eviction: handle moved failed, pid =
%8d. Try again.\n",
+                               pid_nr(process_info->pid));
                        goto validate_map_fail;
                }
        }
--
2.43.0

