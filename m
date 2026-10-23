Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793A2606A319
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 02:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mKdU53Bv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1633910E530;
	Fri, 23 Oct 2026 02:47:52 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011001.outbound.protection.outlook.com
 [40.93.194.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9426E10E525
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 02:47:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMSJWjNVtRYxPyEeGomGlzbcH5qxqX6bfKw2iIPsnJQ2vKiM9+1A0isSuJlQJKrAK/ANdzV7qdZoAz45cggFn9oA7RDbEmM3yWDu4lF2RSN7T3LTg7U1R+coUm57T4rPdLbgwvx8NT4xcraP4nTMiEzDQ/xS1yl/+7NHvzf/96pMXBZfnJwKwqR5xcbEO1kCk7Dyay671A53UgvAFWr3HsKCo7EWFE2c0LsNKplnJ2vt0sNvmrEW2tnw2htkAEkfPcP0ZMphWUhQb9vewDRP+KRELhlPjueytViE+W+T/MBnJEm+LJOvjfs0rK2chRejimZEkUC8+vTEYvp0S72G8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfWEthK9Wm9I+yLBEyL2r/G35CiirUcqKNTBNpCT8i0=;
 b=AnZ6wYutxyJw/p3D0RNhpVYDCp86uKhK8eVMuvzR1xaYrtv9LSfF1hz4j5Eb18aiFtdpj8dW3lwe99MQeSgA5E8eVR9EIJVkwhcUGF0lAcjKD5C+05NEQFzpbaipOLHJZWcS5jjZbFl4WNNr/QSvCrExdOkTZVlzmDpOiMvx83/ziwLfTC1wHdHTKhomDVCzZGv7B2q45I0Ipwom+i7PhPqJnQaEgRU/WsjVYwaMzwATWCW8kYUIY2yDWKhqa2W6aGxva8dM36sOpIUdDKHDXCo4v/cAGyFTwX0I3qgsyiFCIZiDTg0paIaTU900z9foh2WGDzbjq1BRgyU7FytXng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfWEthK9Wm9I+yLBEyL2r/G35CiirUcqKNTBNpCT8i0=;
 b=mKdU53BvM7lFhkj52gkPVHSZ+QTR+33mEuVTtovtcjfmeBWVXkDOcI2GhYFdFeVn1QPlkDi/YLlauOOfTOnwZbsODJ+zXFnKCSxNLc4Uyjz3ZBwihQROcr4T1IMd9I9RsvEI7PkKBdB45TH6GgwkUgZbAu1LSp/c6MEgFzPHK3M=
Received: from CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 02:47:42 +0000
Received: from CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85]) by CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85%2]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 02:47:42 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Pan, Ellen" <Yunru.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Luo, Zhigang" <Zhigang.Luo@amd.com>, 
 "Wan, Gavin" <Gavin.Wan@amd.com>, "Chan, Hing Pong" <Jeffrey.Chan@amd.com>,
 "Pan, Ellen" <Yunru.Pan@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Fix NULL RAS context deref on VF
 unrecoverable error
Thread-Topic: [PATCH] drm/amd/amdgpu: Fix NULL RAS context deref on VF
 unrecoverable error
Thread-Index: AQHdYZ2X6guqCuyWHU+Z5Uw/H8rYNrcKbcxg
Date: Fri, 23 Oct 2026 02:47:42 +0000
Message-ID: <CYYPR12MB87298ABD1401D57924E70A93B0642@CYYPR12MB8729.namprd12.prod.outlook.com>
References: <20261021204809.204454-1-yunru.pan@amd.com>
In-Reply-To: <20261021204809.204454-1-yunru.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-23T02:45:07.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8729:EE_|CH3PR12MB7641:EE_
x-ms-office365-filtering-correlation-id: 9a0e5242-85ed-4142-2bb2-08df30b0027d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261009223027099003|261021121427099003|261021135927099003|261021123027099003|10067099003|56012099006|261022105027099003|261022075727099003|18002099003|22082099003|38070700021|11063799006;
x-microsoft-antispam-message-info: V4R57pOlU0iewpj9+C9yMLgclqo/rzhdMfUdKHwvofQ3TDzF1DOAGFWhKW77YxQPofZhBZz7+o+cP58vX3u2HzJmyARJIpP4lVBNrlWLDr8uRxOxixc4NLymCbnQJ3f5rIT5ieE9JxrGdI5nWjjj0WfnKU21UIu1YP0IasybCizffsBBRfKhKjHQP2WU7PsgG0vmNdId0yR7iDXNNrRhxmuxr0Mjv1yYgZvyMNHjR4N9HnL/JyXYRTibDtjdv8PU1i+YLnpxNIohH1d1h1iH5eTNscRIRx9noMDztwAAkOAAsBHctbkdoroVHQQ5haplvxysoU3mO0yxFTRYfzGlo5eLyC8fAM8ypfUny24XXPhaMUqXdVBtx6klcYKQK36KFUAFfR4AkwNVTykLnqXtbTMR0lE+QO3jQXll+2qdb00hoApaLz8Pn28+wo9YOCDHQLliS7O3nNIacEqSm+sBpYN9GLjN49cei2Gc/Gv30Mr+k7daC4vcb8pyRDPchJoMwz7HsUprRny8gA8r8kgYnIVYyrDkpxGjZCtZuY2kpLXo0Utpz03PHlz2J2amC3Eq7DqylZKAtMXwHJa2eKflRAK8962n201eK8p8UoDFzVN/YjVG8sz8+0sTQDbM/c5WNo2N5FyTlxiNWFHD8JjZewe6INDqqV4DR26LWwRvbIVCVHZqL5qQ0ueh4xnDCD1cIrnnjvRKNf42w/dMNZYS4pwlFvqU/rOtVw662fMWZx4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8729.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261009223027099003)(261021121427099003)(261021135927099003)(261021123027099003)(10067099003)(56012099006)(261022105027099003)(261022075727099003)(18002099003)(22082099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WXHA1lN2nuBtDyBmmR7yCVsCMJkjVd8ridlC20J2Li7Qdcxzlb4piazsLKIF?=
 =?us-ascii?Q?jbpehoADnzKWmy8N3qzyJ7UPic9tIL4cW6CRYa9q0jUZcc62FZoiyqAfZoC+?=
 =?us-ascii?Q?oMtd6Vo20sDhYrqETh4GZLSPk+zP/9ioFHmgDU0qBXjJ1E7qbNYoxOi3Gt29?=
 =?us-ascii?Q?wrypnCKi9Zg1AWx4byhC6q34GZUQaLYD2uwvUmBxIF7+XQRZXU47/Y63ZdGa?=
 =?us-ascii?Q?gbl8Cqr1kGZ47sbwVEhbNzHV8HMje8jDYPzIs6XUS+ZBLgAshME6s4zZQvO6?=
 =?us-ascii?Q?91Ke8pcrg9tJIiwrvP91DJTk3kB0amn7z1pfFGrL+b5StDGrOstTFgrSW3Zk?=
 =?us-ascii?Q?fg2EOHql8jUsG5M+whostwPm9WRCaDjiVMql1YINxJlyeEi0diTX8b+4/o17?=
 =?us-ascii?Q?SLVkGOp10xHze/YPbsq8yIxAo0HPZQ6c+U9/Y55jkYhtZf8vf4XQvWsIfXvW?=
 =?us-ascii?Q?nJXXnGXCOLHkhp0CHpZFMpp7SR6lVRNtu42PuSmZ1j1wR8Px4Yq6IB9sZ/mu?=
 =?us-ascii?Q?HpRJuZkSpzENMHENKuWEhWvQKZkvvmAVfzozb9BQcFZ8ZHcxo5A8s4qva9pV?=
 =?us-ascii?Q?KijpRp5qYyytqJBxHpi2ZtHdJxVzNBwwSQJaeNd53LNWI1GbkFNKnULURZ5P?=
 =?us-ascii?Q?qoXEOlvHaW+8g0UokjnfLiEue0HmbVlO2XZoiSWdkuy+2RiFupwaMjTkRwAG?=
 =?us-ascii?Q?wQ6pMlFAcTlBWBpXm6B0Q6J/kGR44V0R+w4lcnGErIXBrDPbt7uKtlLumVW6?=
 =?us-ascii?Q?g094d4ZAcHHCOSERRNcxEWr46Jf3E81hXI5FmcZRzZz/GSvknTe2t+VBoQB4?=
 =?us-ascii?Q?cqHExT6cTzeinWJa8xIhT8truUD/vwXY8E8efXmg/NlmUx3HXGtliowQxI0h?=
 =?us-ascii?Q?6KAx6vLi6hsqzIcxm8OI1CkTSt/UJeYcUDqd29MwezlIBtUaaJQHw5Q90byB?=
 =?us-ascii?Q?cCZMuSzOGTKYnUDReQ7MvOlJAZy/S8459E67Krw30h27Trp3GJoA/FLIhIeK?=
 =?us-ascii?Q?8tt1yQw3ZRPTdP7bZqSUABUohZG2o3m5DEcOzhZADPj/JTkhTobHEUOQl/Kq?=
 =?us-ascii?Q?dxMyT3jnOOPmcpBMPwGEpFmFx9hiN97GrkR9V/XYcGMH3ZvR1xhrK+sAIKFB?=
 =?us-ascii?Q?14Ewdr/7rIuQCvafxL0eWjDKJawNfM/JZyrrcXF/SnuoCl1yKH6GUFj/NxXf?=
 =?us-ascii?Q?HQZsji5BNfkhDHKy6nZMCo9XQVp2WZee2MbOgbftgxRPylFWcTvleUPPfrKN?=
 =?us-ascii?Q?cFpEw9aj+uX4PnsZE7/jiFsipCNMaHS8D6KgGUbRmTscwvxTQbAo3qZCKkUl?=
 =?us-ascii?Q?k3VaEQzP5nx/OMUloHfzQ4qF4nx5V8ggHyi3q/HAECEphsy1BZvZQQEFaR7Z?=
 =?us-ascii?Q?nQRutQQilleEWfWEsHTZUlYHFU/xNvruRyuTqGYWWJpV0KECRkgeUSO4HdEw?=
 =?us-ascii?Q?HN7X/A29mlXpGRCtQl8auwd/eb/SH+GVLWBz9yD0p+c/29wdy2lSigat8htl?=
 =?us-ascii?Q?HUureIT3Rd4xv1JtDBQj/lamU8Dy+R1YubgDIRuuzf4mYWyhETQRzRV5z622?=
 =?us-ascii?Q?NWRSeitdM9wx+6gsVPtTMgezcgwvQLMIUqidgTwk3vwMM7mtw5fPs9qvzs5N?=
 =?us-ascii?Q?MF5TG8Ke2GM6tV4shtcyAE8TbYv7fPZo/OFr3nwyM6eFCouxUgBMz4hYoujg?=
 =?us-ascii?Q?anyMbHgRDNT33CYIb3Kys8M+1f03PeX6b0qTG4ySglxlcjKQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8729.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a0e5242-85ed-4142-2bb2-08df30b0027d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 02:47:42.3297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6VTGkAMV0vyfvP5Rb7r8I6BrOQ7xNjgN5txKDm30g14yHUy+yx3K3dazvJDfSFQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ellen =
Pan
> Sent: Thursday, October 22, 2026 4:48 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>;
> Wan, Gavin <Gavin.Wan@amd.com>; Chan, Hing Pong <Jeffrey.Chan@amd.com>;
> Pan, Ellen <Yunru.Pan@amd.com>
> Subject: [PATCH] drm/amd/amdgpu: Fix NULL RAS context deref on VF
> unrecoverable error
>
> A VF has no RAS context when RAS isn't supported on it or before RAS is i=
nitialized
> during probe. Handling UNRECOV_ERR_NOTIFICATION in that state dereference=
s
> a NULL amdgpu_ras pointer and panics the guest.
>
> The fix is to track the notification in adev->virt.unrecov_err instead of=
 the RAS
> context, and amdgpu_Ras_is_rma() checks that flags for VFs. Once the flag=
 is set,
> mailbox reqs fail immediately with -ENODEV and GPU recovery bails out. If=
 the
> notification arrives during probe, probe now fails cleaning instead of pa=
nicking. If it
> arrives during unload, unload completes without accessing the HW.
>
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  3 +++
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  3 +++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 15 ++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 23 ++++++++++++-----------
>  4 files changed, 30 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 557baca454a9..8349b86ab932 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -4925,6 +4925,9 @@ bool amdgpu_ras_is_rma(struct amdgpu_device *adev) =
 {
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>
> +     if (amdgpu_sriov_vf(adev))
> +             return adev->virt.unrecov_err;
> +
>       if (amdgpu_uniras_enabled(adev))
>               return amdgpu_ras_mgr_is_rma(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index a2c1aa838737..4a30306a387d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -358,6 +358,9 @@ struct amdgpu_virt {
>
>       /* hibernate and resume with different VF feature for xgmi enabled =
system */
>       bool is_xgmi_node_migrate_enabled;
> +
> +     /* PF reported the VF unrecoverable */

[Tao] you can update comment to clarify that vf maintains rma status by its=
elf, with this fixed, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> +     bool unrecov_err;
>  };
>
>  struct amdgpu_video_codec_info;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index fec08f235b92..4dcfa256c9e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -98,6 +98,16 @@ static int xgpu_ai_poll_ack(struct amdgpu_device *adev=
)
>       return -ETIME;
>  }
>
> +static void xgpu_ai_set_unrecov_err(struct amdgpu_device *adev) {
> +     if (adev->virt.unrecov_err)
> +             return;
> +
> +     adev->virt.unrecov_err =3D true;
> +
> +     dev_err(adev->dev, "VF is in an unrecoverable state. Runtime Servic=
es
> +are halted.\n"); }
> +
>  static int xgpu_ai_poll_msg(struct amdgpu_device *adev, enum idh_event e=
vent)  {
>       int r, timeout =3D AI_MAILBOX_POLL_MSG_TIMEDOUT; @@ -345,7 +355,6
> @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_device *adev,
>                                  struct amdgpu_iv_entry *entry)
>  {
>       enum idh_event event =3D xgpu_ai_mailbox_peek_msg(adev);
> -     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>
>       switch (event) {
>       case IDH_RAS_BAD_PAGES_READY:
> @@ -360,8 +369,8 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_devi=
ce
> *adev,
>               break;
>       case IDH_UNRECOV_ERR_NOTIFICATION:
>               xgpu_ai_mailbox_send_ack(adev);
> -             ras->is_rma =3D true;
> -             dev_err(adev->dev, "VF is in an unrecoverable state. Runtim=
e
> Services are halted.\n");
> +             xgpu_ai_set_unrecov_err(adev);
> +
>               if (amdgpu_sriov_runtime(adev))
>                       WARN_ONCE(!amdgpu_reset_domain_schedule(adev-
> >reset_domain,
>                                       &adev->virt.flr_work),
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index eb537b2ae685..3062f1506760 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -103,11 +103,20 @@ static int xgpu_nv_poll_ack(struct amdgpu_device *a=
dev)
>       return -ETIME;
>  }
>
> +static void xgpu_nv_set_unrecov_err(struct amdgpu_device *adev) {
> +     if (adev->virt.unrecov_err)
> +             return;
> +
> +     adev->virt.unrecov_err =3D true;
> +
> +     dev_err(adev->dev, "VF is in an unrecoverable state. Runtime Servic=
es
> +are halted.\n"); }
> +
>  static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event e=
vent)  {
>       int r;
>       uint64_t timeout, now;
> -     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>
>       now =3D (uint64_t)ktime_to_ms(ktime_get());
>       timeout =3D now + NV_MAILBOX_POLL_MSG_TIMEDOUT; @@ -119,11
> +128,7 @@ static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum
> idh_event event)
>                                       event,
> NV_MAILBOX_POLL_MSG_TIMEDOUT - timeout + now);
>                       return 0;
>               } else if (r =3D=3D -ENODEV) {
> -                     if (!amdgpu_ras_is_rma(adev)) {
> -                             ras->is_rma =3D true;
> -                             dev_err(adev->dev, "VF is in an unrecoverab=
le state. "
> -                                             "Runtime Services are halte=
d.\n");
> -                     }
> +                     xgpu_nv_set_unrecov_err(adev);
>                       return r;
>               }
>
> @@ -453,7 +458,6 @@ static int xgpu_nv_mailbox_rcv_irq(struct amdgpu_devi=
ce
> *adev,
>                                  struct amdgpu_iv_entry *entry)
>  {
>       enum idh_event event =3D xgpu_nv_mailbox_peek_msg(adev);
> -     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>
>       switch (event) {
>       case IDH_RAS_BAD_PAGES_READY:
> @@ -468,10 +472,7 @@ static int xgpu_nv_mailbox_rcv_irq(struct amdgpu_dev=
ice
> *adev,
>               break;
>       case IDH_UNRECOV_ERR_NOTIFICATION:
>               xgpu_nv_mailbox_send_ack(adev);
> -             if (!amdgpu_ras_is_rma(adev)) {
> -                     ras->is_rma =3D true;
> -                     dev_err(adev->dev, "VF is in an unrecoverable state=
. Runtime
> Services are halted.\n");
> -             }
> +             xgpu_nv_set_unrecov_err(adev);
>
>               if (amdgpu_sriov_runtime(adev))
>                       WARN_ONCE(!amdgpu_reset_domain_schedule(adev-
> >reset_domain,
> --
> 2.43.0

