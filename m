Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42FA606A326
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=05mjgSDO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D86510E2E0;
	Mon,  2 Nov 2026 13:47:23 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0B4F10E2E0
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 13:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eu79MOva/EmU5C+yygdb6jmTDrYI1LcNedaKmNrj9U9J58yk0RYvTLnHlTNY/F9D2X2OyAhgfTjqzMZScC9yoemoFtDfdtZRpMy7nkDJFYytFHhIQYj4f/J69vbCGM85YEtLDx8vAL0PGf3pCSiop96u+VuZ4HqzJIIyFHCKGvl5a3tWOTM4jagWvFLFbZCp/ybpWpn8hL1HKAXN2Wyq62SfBT1hFghwTKyibQYhrZn92Pzs5SAcmr5OCAs+1vG65tiu/38Fe+K6bdxzbrPx8aK0zOSmm5+bW9igTuWZpu4OfytBuwvvUxsompr6hnkbF2xbc8iH12JrOW5FzrANbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAIFBzYwEEhSo4yJknz63OCq6ga1bwyhKvCMJOJE+S8=;
 b=DmqdefGkaF53MmlRxdzCDS5FIsrQ+/1dlYHYWEDywUgeSACem5vSHWbKoLbxK0vTDUa4KaI9RjllSG4waQX4VzN6HrcnIc5oywgIcEMb7I+ashkkAJVdK6UTpB5JgOItxVqZzlqt8oUoXLYkj3t4c3+kVBgRURwcbCuIPopubP20kOVyNp9DNiiaYfoj2bPmo/z05qUSqQ1lAviHIIYDV3IAjoRit7UhcGV04B4Ig64kPBpuHvNDS2ku7NnrelE2yUfM8Mq42KAr181yhTEbW3fNwN/GkxIFEofY5G2Y29JPzNY0TQwQjkbrXXVU1ajoQWITdMBFZV2SxF8olqFhFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAIFBzYwEEhSo4yJknz63OCq6ga1bwyhKvCMJOJE+S8=;
 b=05mjgSDOhU0oDf31RmH4h6Rr+LtYhhPRv4DElc2MbJTX7UCuy4xYZMmyHOOxBbD9CxogkzVDtyijEBBKUy/IB6Yj9kzWWnbAY7tJ1V0jx9oXnJfUqWYa20NiBeYSAdx/ncxa7rAwFz5H/VyaHzHsFDBgbNEtE4HfDTmarDY5iw4=
Received: from MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:47:13 +0000
Received: from MW6PR12MB7072.namprd12.prod.outlook.com
 ([fe80::a786:e93f:6c7b:ad9a]) by MW6PR12MB7072.namprd12.prod.outlook.com
 ([fe80::a786:e93f:6c7b:ad9a%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 13:47:12 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu/vce: don't allocate a scheduler fence in
 the direct IB test
Thread-Topic: [PATCH 2/3] drm/amdgpu/vce: don't allocate a scheduler fence in
 the direct IB test
Thread-Index: AQHdaBkdu6FEhoeuR0eKDv4CfzDlCbca0LwQ
Date: Mon, 2 Nov 2026 13:47:12 +0000
Message-ID: <MW6PR12MB7072E0390DCA1FB14F2C8424E56A2@MW6PR12MB7072.namprd12.prod.outlook.com>
References: <20261030024747.3083509-1-Prike.Liang@amd.com>
 <20261030024747.3083509-2-Prike.Liang@amd.com>
In-Reply-To: <20261030024747.3083509-2-Prike.Liang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-02T13:45:47.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB7072:EE_|SN7PR12MB6863:EE_
x-ms-office365-filtering-correlation-id: 4d2dbbc9-5172-412b-9edb-08df38e7cc5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|42112799006|18002099003|22082099003|56012099006|261009221227099003|261009223027099003|261009221727099003|261009220027099003|261022105027099003|261021123027099003|261021121427099003|261009223327099003|261022075727099003|4143699003|11063799006|10067099003|38070700021|261028144727099003|261026140227099003|261026121527099003;
x-microsoft-antispam-message-info: z6kT4FmoAL/rQcP6vpKhmxGqQ6dInF/6oInZMpER8hqd4UN+d02C3fuqqItPHFV0KB1kI0uO7dvVNb4moyJQZXAm6JJzWIZES1jb+gL4Kx1kD0Jfyb3yOO8eXAZ4GvvhLWJrCcnL/MtUKP5HpdlER09yirSxFkX4Qi3uru/kJf0Ymjr8befg3nahsEZLKXwkyNSIBy3fenYi0XKNWDr0HjyyXtHYK4pT4ynw60Vb3+gY6wDCXrvZhEi6RvXFmJFGg2vv6xNCaiTiiqwq3jBcPVdFFlmXlePqVc8jJMxC7wIEPpBOaYoOfvGFY2Set1q2HZM5oso35CgMV3w6hvsQwKdH2jECMztm2R9Io2U7GtB6tJfGNXBL21Ei5iEVF/8yIvQiNPgmjzStaUa/fVyRGRwD3pfmzGCdw5b6iM2TKSzOCIY9nY0s5c2wZ/6kiRUWTT/cby7WsYyQ7DL/sOcZ8Sglztx9wtVDPDlv3JSQHQDCQmY7mK2sBZMfQZxy/vX/OhF/afprSuWf9gxv84kugvvW7FPjr2iIiUrUeIGg/8bnJIcQMfSHGAG//By3CNQ9Ym+vAGni2tlJQfBLBFoIAzRP3dMnkvswcApzWueVSo37NLGOc+D65dUg+yOq8v+Hy6j+Pt94yMXcyJkO3+/pfnqD3Xdy4D/c5ete7ht79FlvPlS1gQdiBQQM6CvxKbNqYtZfJbs4xG/lOraoB1sgrnfU/a9loEByqxrt+BEjnog=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB7072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(42112799006)(18002099003)(22082099003)(56012099006)(261009221227099003)(261009223027099003)(261009221727099003)(261009220027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223327099003)(261022075727099003)(4143699003)(11063799006)(10067099003)(38070700021)(261028144727099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GPH5V47nJOkvXCSFEQeIdRiX76JL62bjRUKfUcFdC56DeH6neAtyc3UrFS3L?=
 =?us-ascii?Q?KJtVVKnUxHibV85j9/5/pRkwFh+UWaZ94Ca1JKSPYe2J0/zCHpGuMTE3hnsY?=
 =?us-ascii?Q?wkM+K3uDzG+bmKQFCycwBNsUu2y4SbhNf0qLbbiZg3frODxdNB/s0YEpioJv?=
 =?us-ascii?Q?rQ3raZ9hh2qJr+rDuP/UpOaOj4wiKS6N7mJTTAz5EaNy0EVZMwIUFjVUQs/r?=
 =?us-ascii?Q?jz3vOR7+HqYmDyjg9Xiw9CXB9EchcHfmKCi3VHaZNMa0qexB1zjE/KqtHsvY?=
 =?us-ascii?Q?7sUyOoDmYgykYv9qhFSjvS4/FYpJxidHBU648ww6WFcOMC4IOb1bKemDQU6x?=
 =?us-ascii?Q?NUVIs9bjneGfjFKTtDyMN9cSjw+A18LPqPzj/yqToUCX2aTopMIk7JD4RRta?=
 =?us-ascii?Q?kRqx49Y86NaLsaLxn36Kdg+pw9L83MgRNFCiIoLjS7+3qbzBVUIUeq5DRrwR?=
 =?us-ascii?Q?qAMy+ZQ7bTyQnnHC8cRS2nGf6RgfpUL1EhkgXtoY1g3DIrbO1vkm6E+8+ps3?=
 =?us-ascii?Q?HhdJe2CuUeAQ+2WWYj9/15gb1qCv4D/xRM1DVuUZLoowFVhGy5r/Jf0kh8NX?=
 =?us-ascii?Q?GMSFrYPQjRO+YYxUCtt9rbX+EIwzohJEg7AkUElraUlQrmLJQ75iCC71sy6Z?=
 =?us-ascii?Q?VRcpASaK5r+Jh/+vSkzwYIjNzVg6ZopGnMsAHWhakCROutscbdNjsM069FFF?=
 =?us-ascii?Q?glUWs09ymFTiNRpCsjbrsU7QNZpZoJHVHszHjMpnHXPZ8sBnblj8KkWogSQi?=
 =?us-ascii?Q?WamtOewnN0wlritnsdHPZvnyP87xYdc91L7PjlYQbUVFKh37OHx/Hvvobm1c?=
 =?us-ascii?Q?xk+Ner+cpVB9wW5qlwVqTXaMMNK2OvdN34XG1TGAFGXcU869jVCewsP3YcV7?=
 =?us-ascii?Q?PQXNn1ycBG+YgRqapbqsbUUReg4YOR5Rxe3segbdMim1/qGO59I7uUBQ2/e5?=
 =?us-ascii?Q?RKdl/utP3SULb4x3+YQv6S35EBI/JFijeo84A32i3KnhhbeGGLPUZUwg5O1o?=
 =?us-ascii?Q?6hB0zIJrozQl27tqj0JUc2EsNTGKhggqeWy4XCbmwWCgwnVKXNZDTiv5Fjhx?=
 =?us-ascii?Q?Hw3pDcONVRXTrLebbkBGPvF9ZTftjMMKesa0WD6hCZjxXlHf8rPgDFGHJhAW?=
 =?us-ascii?Q?sxG8B8pr+8l89HP3xKbLfO8mYXzMXysRZkI7fTnGvcvysLYI3XgYZC3a4MAa?=
 =?us-ascii?Q?3HJ+sMafAWGOTd4P5BQRsw+ZLHYGCb+aeABeGEwyKW+HUL3Z4mykDhCZ9LUL?=
 =?us-ascii?Q?58Apej91v5U670yk9hVTd+IPOr5lQgsNO30Sw12UWncd0BuFt54af+7PWft1?=
 =?us-ascii?Q?rjW4hL+QZ64XP3eZSGp/nq4w5znh7kv7u/xtjKs2RQ2C15korj2UZW9NFqhB?=
 =?us-ascii?Q?HNqiYYp/VVkvGx91K6KeaLejvRTRzk9kDgeuCMggrT3siCKiSQZm48KLAXIi?=
 =?us-ascii?Q?P4t/CbeK3ua5XeBBpwBxFdbkcuU9aFhA1e9xltoM9bWkT1q2uQ1e/BdLh/2r?=
 =?us-ascii?Q?el1QFKyZDFFe361G5+MaHGVKjB09TPaNtvqNGeSASKBOMmzGm28G0p33cPt0?=
 =?us-ascii?Q?jehzpJtl66HdLmAUPFSZKP5HUmLQ9ul9tmEueKp3UStlO9Iid5jSNseexItg?=
 =?us-ascii?Q?ERMtbK59CCR/hegKbn8hEXNhJbWAKP/FRRuhnJtZlmarpfs7NUKnyChUGUai?=
 =?us-ascii?Q?GdJpb7bv87vjewQMRKaXIexZUKRZTDiZ2/UFOrILcRVIBx4s?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2dbbc9-5172-412b-9edb-08df38e7cc5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 13:47:12.6113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6gL7wzG1Ks+MmQP/oV2zQRXPY9eCU5PJFJnq+C2TdFrI0PbKnt2X/nnsxBmXNJaU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Reviewed-by: Leo Liu <leo.liu@amd.com>


> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Thursday, October 29, 2026 10:48 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Prosyak, Vi=
taly
> <Vitaly.Prosyak@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Liu, Leo
> <Leo.Liu@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu/vce: don't allocate a scheduler fence in =
the
> direct IB test
>
> The IB tests run inside GPU recovery, which must not allocate memory with
> reclaim. The direct IB pool and the job allocation use GFP_ATOMIC for
> this reason.
>
> amdgpu_vce_get_create_msg() and amdgpu_vce_get_destroy_msg() still pass
> the VCE scheduler entity for direct submissions, so drm_sched_job_init()
> allocates a scheduler fence with GFP_KERNEL that the direct submission
> never uses.
>
> The create message is always submitted directly, so don't pass the entity
> there. The destroy message also goes through the scheduler when the
> handles of a closed file are freed, so only pass the entity for those
> scheduled submissions.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Cc: Leo Liu <leo.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 3952af9ae115..dec3c6d9b6ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -471,7 +471,7 @@ static int amdgpu_vce_get_create_msg(struct
> amdgpu_ring *ring, uint32_t handle,
>       uint64_t addr;
>       int i, r;
>
> -     r =3D amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
> +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL,
>                                    AMDGPU_FENCE_OWNER_UNDEFINED,
>                                    ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
>
> AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
> @@ -562,7 +562,8 @@ static int amdgpu_vce_get_destroy_msg(struct
> amdgpu_ring *ring, uint32_t handle,
>       struct dma_fence *f =3D NULL;
>       int i, r;
>
> -     r =3D amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
> +     r =3D amdgpu_job_alloc_with_ib(ring->adev,
> +                                  direct ? NULL : &ring->adev->vce.entit=
y,
>                                    AMDGPU_FENCE_OWNER_UNDEFINED,
>                                    ib_size_dw * 4,
>                                    direct ? AMDGPU_IB_POOL_DIRECT :
> --
> 2.34.1

