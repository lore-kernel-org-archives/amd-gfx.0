Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C3606A326
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 01:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VE4y5vq1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AAE110E37A;
	Mon,  2 Nov 2026 01:28:40 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42E9110E37A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 01:28:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2PqsvW7E0uuaqxTCb8q0gxcxOMRTfR0YT425D3uC3v7vhLhI3K3M4si/SRU5PNPsCIyM605H6UoKe4JkyzawtcnDETp2gxFKLqYyvlURn6jt0Ku61Aod1BA/o07J5QqbVpbgN2aWnHG+GSH/SDvRTTxhMVYU8SPg3AGFuAuq5GNLkwwe3JKWqEKXqrdJWqZ+a+2A9M6Oxq/PURIh5VLXXMS2iOogLZrllx6NqmxjJ++EfZplqQzjgBpe84l5ZtgAdggaQroQ5UZdtA0ooKHz41WoJrQkmZWmTw61yEOLRfnNuByKPAW7Y4IrlQq1r2B1GuiAbCHyvB7evJ1950shQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIyrzlRZ1CbywDyVsmN3dVIKrqpsgfWdX/7nw6Q9mbY=;
 b=kx0mk0BDCc8wwAQkWixVFH4TFA2R1RKmDIn3u4CWBLY1zI4TM8q3ATBPe7GPc7onMsb0nQSZtv65QYx7XKj2k6EJY6ZoPrmzJNIVX3+PPg2fQgb93kTfsbRjLvRoHjMLkWEG5eRcFao47lRY+6GuqXgBzYlNAp7rCHv+sgzVSb4FrIRPVYXVILoq//thSk20w6LnN44IlSlDYqecaLDdJOdUHiQvI9yrDEGGgukaYQvao1DC1sVOLAoUoW8GbzKU3ItnueFYtwfq6pwYfY5s2d8KrCOWhvEHDIV9vWabCwkKJHbqQQ3EThcOCdPxIwFw3ATx8RFhKhgvae0e3nryZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIyrzlRZ1CbywDyVsmN3dVIKrqpsgfWdX/7nw6Q9mbY=;
 b=VE4y5vq1Pe7ZVMGddqpnvCjiTnwr/o++EHFqxjhWi7SsWu5o/xvJg+Qz5C6jBtKE3xX9RhW7CkxYIqpdZeWX/c9IJvrpkseCJVmZhGMkGANoHXELx1yokxe1wkffFhpl6snevoYQ4OJM5nZ0lhwBoRryv00q0gX0dq5kjm32O8M=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 01:28:29 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 01:28:28 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "timur.kristof@gmail.com" <timur.kristof@gmail.com>, Mario Sopena-Novales
 <Mario.Novales@amd.com>, "Rastogi, Manu" <Manu.Rastogi@amd.com>, "Zhu,
 Jiongyu (Joey)" <Jiongyu.Zhu@amd.com>
Subject: RE: [PATCH v3 01/15] drm/amdgpu: pass the device to the multi ring
 reset helpers
Thread-Topic: [PATCH v3 01/15] drm/amdgpu: pass the device to the multi ring
 reset helpers
Thread-Index: AQHdZrpkNePgKZtMrk63p5BuaQmoZbcaBPsQ
Date: Mon, 2 Nov 2026 01:28:28 +0000
Message-ID: <DM4PR12MB5152422F0100100566C3FBBEE36A2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
In-Reply-To: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-02T01:26:43.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|MW4PR12MB6705:EE_
x-ms-office365-filtering-correlation-id: 0cffd937-d758-4bcc-98c4-08df3880993a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|22082099003|18002099003|38070700021|56012099006|11063799006|261021121427099003|261026121527099003|261026140227099003|261022105027099003|261009223027099003|261028144727099003|261021123027099003;
x-microsoft-antispam-message-info: VSYfQavLikD8A3sw2FYDJiy8leE+ZlL6mVCv3+paCxvupbeRcwDzK2Q82zLwVWgJ0AFUwT3ya1/h8RzpX3EpCCa41kCmavxGxYeraTCebeG1760BkhzmPyuQkoU8AtasEToJbKhjpakupIR7cTMhl20QKl6OJ3Yrp8nABJ98cK1uUmAEneBWQ9bDmfMxSulx8C1mlTLhjeT8LfstS1jLgWIoL7tqjtK2u171d89cSlNu3EVWUGgXN+W5wTKgudVNwVQsX8dpxWTfiQImPoBWH0CZAZHQLHlKqw2fMCsXUW2JY3Nyw6Hd0e+JGDgi6UfHXMjkNv+y5S5pzme8kDvBFy2MUdVEo4uktXuOyRBA5w7H2YvrueU2FVCbFwBfbH6w8wlSrzPa7N/x6HqJF1LJwBebwgTnTMTlDui6AJ2c0xDv0rMlBEu8nzFBsPqGZib74CQBMpx6RKxNdsInL9+VKjZydG/8jDrBysJ7BWHw+hnceEuo4lhEisyrrmqMpjVpkrAvt/1OIizArJMwirsmHXhDki8AIviELLjZUYV3f0hUhBpVi8ug6YWh0Wd/z2o56mvPeFIZAYW7equGp26F/j5Jk6pip3tYNpiDB9rcZAwq5i5NCqTsWAfvxk6SSLn7d6rZO2Mj4rfsUU538ezoCRVlcgw+mkejUnj1tflwEyi6zIi5PwHOSiPLFYM2yhownDi5wREy/jm28ugcnl2b0+xnqytGvWU/63t7Jlt1dE4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(261009223027099003)(261028144727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zEdS+WUpnAchI6wigAbtjtJVC0LwXkXFsGC+xLjAyP689F+SOzMnXBn3R8vo?=
 =?us-ascii?Q?xsAQ8MNU7Bt3ldWnW/DSw44jCxMOezqpUGbtHZc6JSLJicSQrE1Ly+wqc8LC?=
 =?us-ascii?Q?A6qBkUJX6ENBUVlP5ncxmHfQIsfvjc9m9hNFyWhijGXtwppLQkLPhlvcJrw9?=
 =?us-ascii?Q?gBczUA3bugU2FhYzwosEv83ri7Eyz/oMf7kfzrZaP0CLJvPQ/EtD1Zk1qkmH?=
 =?us-ascii?Q?wAbaWnWXXqlB31JqYLonitl9wV59zTSPiLwAfAzGl/A7Jk9gs957iAA+X3vr?=
 =?us-ascii?Q?MFteZfutnP6/cuUK59yFpOHuMPNgI80mghzHWupXbfWQBNvD5SvBfptBRs+S?=
 =?us-ascii?Q?dmqhujra1UfvLiCSqMeFgEC6jpJD0RjNvkO1pahP0HuyeAwpIXTh3Qd6icwY?=
 =?us-ascii?Q?efW5gvargraX9TE9afC7Gv6JEuJpumnzUrAvaTti9Iyjn0paWKa5JD0sopRG?=
 =?us-ascii?Q?UpjBnFulCSKsCIpKcCy4iWhR5N+AmCTjh36grTZR3NoYMvrOYT9fZaJN8vx3?=
 =?us-ascii?Q?hphd6ijaj9vbVld1/oJCdzw5KnviVY+F/M0pfQqs0fiezaWikoh+Mk5FSt7f?=
 =?us-ascii?Q?4yJMkjGXVRvUOPAiVQdO1ofVrfgLItizo7BiTsXU4Z7EUWLnLLcsQo1O88h4?=
 =?us-ascii?Q?CH0SmsirYa7tfPdq+40UiTW3CijTgzNM+dM4mf2jkZJgVrQV4Jc5Erb9oN+j?=
 =?us-ascii?Q?vQPbw1F5CkHzFwgsYkgJbe2OD81PddpM0S2jwOZQEknScvpAvfF61Dq3IdST?=
 =?us-ascii?Q?CTc8RFyDAkaYPL3gp4/7sv9cDt97QAHSSZvqFxaXfo42pLri/aYyyQsgdqaV?=
 =?us-ascii?Q?ftyPGbMFIT5O7SsLJtjPWeDjj8sW57Xb9U4cXJAAEBiorFAQMgr1l4UfycpG?=
 =?us-ascii?Q?h6K2tlNUmMVzyt7pR3kdiOeEQHJKYf2MwjJpdrrApAXR/69Sk6kaBjfGGS9r?=
 =?us-ascii?Q?NsrM6d4eu2eLj2kAkksrbhTR12i5QgyA5IyzKFaAOwUziKnheFeVdYqwTH57?=
 =?us-ascii?Q?eAfVowLElv5bKzXXYvpofmOAffP90BgWwWco1YV/LXKM/ExuvUx1UcenmFNk?=
 =?us-ascii?Q?Lexx/W1I9DeUi8dkRP6N4KyCGvCaMytIzWKaOAkSPv6TA8Uw5pAUINj4VT8U?=
 =?us-ascii?Q?GYzknuhVej6J0vBl/S3wi8Zw3819g5+XCJxzHTeRQCl4AxYF9kMTALPZc2Qu?=
 =?us-ascii?Q?CKiu8XaPDfgYoSei5Bf8AoYfu4fmsIePw2EoS0qpcTshlNgE6G+mrI+kFVpW?=
 =?us-ascii?Q?uw0WuudI+T0guyxn0U45SaEyLT5wHJHecyk1Nq4oQ61vJ4Cm2u9XZCXNjkgO?=
 =?us-ascii?Q?BJvK1XSG8Wtt+MwAq9c9vifxEW8YWxZqFVk2ipr9ZV7Ft6CxLUsp+oWlurf0?=
 =?us-ascii?Q?RA1JtwXLm/6IrTdSDV3pXD05lZ2ji7iPVEDiJ0ocvEoGOYyiLfoT60oN47PG?=
 =?us-ascii?Q?74GSs4n9gVMSv3Grqcyamd4pDRQinanlcRWuYZu4jadfCipSTeWptgSMqoRb?=
 =?us-ascii?Q?SzuZwySJR8fu5WOJMVjL4439JR86c5CryPALiNTO+WSvLDBjZeyg9uAlLcK0?=
 =?us-ascii?Q?w2tf9MVBC9lghWnRWrBeQRVt4cn5kQoORho+CDy4anr8voNb1PA2WvMbYEjg?=
 =?us-ascii?Q?9USf2OqMtEdJ/nRh7/HwEp+QHk7P1l2xDPERDnfdqdDfF1IIRzvOalhNn7Ui?=
 =?us-ascii?Q?SauIBZcvJwyrD846tKXM8x3VMwkRbfoZkkCEDuc1qoY7uVS6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cffd937-d758-4bcc-98c4-08df3880993a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 01:28:28.6868 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRB+f2VqLkP1eectDXfP7dwporQMCeNKR6e6McRzUNGqHR9FUzHGYYq2lUp+sY7VKi9osw4JKJysPX5z5bs2zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705
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

Ping on the series ?

> -----Original Message-----
> From: Jesse Zhang <Jesse.Zhang@amd.com>
> Sent: Wednesday, October 28, 2026 4:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>;
> timur.kristof@gmail.com; Mario Sopena-Novales
> <Mario.Novales@amd.com>; Rastogi, Manu <Manu.Rastogi@amd.com>;
> Zhu, Jiongyu (Joey) <Jiongyu.Zhu@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH v3 01/15] drm/amdgpu: pass the device to the multi ring
> reset helpers
>
> amdgpu_multi_ring_reset_helper_begin() and _end() take the device from th=
e
> guilty ring. A reset triggered by a hung user queue has no guilty kernel =
ring, so
> pass the device explicitly and allow a NULL guilty ring.
>
> No functional change.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c   |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 14 ++++++++------
> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  6 ++++--
>  3 files changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> index 734f2a0bc79a..d0b0d3eaffc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> @@ -465,11 +465,11 @@ int amdgpu_device_ip_soft_reset(struct
> amdgpu_ring *guilty_ring,
>       ring_type_mask =3D amdgpu_ring_mask_from_ip(ip_type);
>
>       amdgpu_device_lock_reset_domain(adev->reset_domain);
> -     amdgpu_multi_ring_reset_helper_begin(ring_type_mask, guilty_ring,
> guilty_fence);
> +     amdgpu_multi_ring_reset_helper_begin(adev, ring_type_mask,
> +guilty_ring, guilty_fence);
>
>       r =3D ip_block->version->funcs->soft_reset(ip_block);
>
> -     r =3D amdgpu_multi_ring_reset_helper_end(ring_type_mask,
> guilty_ring, r);
> +     r =3D amdgpu_multi_ring_reset_helper_end(adev, ring_type_mask,
> +guilty_ring, r);
>       amdgpu_device_unlock_reset_domain(adev->reset_domain);
>
>       if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 7b67e8cecca2..edae764eb0c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -919,8 +919,9 @@ int amdgpu_ring_reset_helper_end(struct
> amdgpu_ring *ring,
>  /**
>   * amdgpu_multi_ring_reset_helper_begin() - Prepare multiple rings for a
> reset.
>   *
> + * @adev: amdgpu device
>   * @ring_type_mask: Bitmask of affected ring types
> - * @guilty_ring: The ring which is guilty of causing a reset.
> + * @guilty_ring: The ring which is guilty of causing a reset, or NULL.
>   * @guilty_fence: The fence which didn't signal on the guilty ring.
>   *
>   * Useful when performing a GPU reset method that affects @@ -938,11
> +939,11 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>   * After the reset is complete, the caller should then call
>   * amdgpu_multi_ring_reset_helper_end() to restore the rings.
>   */
> -void amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
> +void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device *adev,
> +                                       const u32 ring_type_mask,
>                                         struct amdgpu_ring *guilty_ring,
>                                         struct amdgpu_fence *guilty_fence=
)
> {
> -     struct amdgpu_device *adev =3D guilty_ring->adev;
>       struct amdgpu_fence *ring_guilty_fence;
>       struct amdgpu_ring *ring;
>       bool rings_busy;
> @@ -1034,8 +1035,9 @@ void
> amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
>  /**
>   * amdgpu_multi_ring_reset_helper_end() - Prepare multiple rings for a r=
eset.
>   *
> + * @adev: amdgpu device
>   * @ring_type_mask: Bitmask of affected ring types
> - * @guilty_ring: The ring which is guilty of causing a reset.
> + * @guilty_ring: The ring which is guilty of causing a reset, or NULL.
>   * @ret: Return code from the reset function.
>   *
>   * After calling amdgpu_multi_ring_reset_helper_begin()
> @@ -1046,10 +1048,10 @@ void
> amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
>   * be called to restore preemption state, but it won't attempt to
>   * fully restore the ring contents.
>   */
> -int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
> +int amdgpu_multi_ring_reset_helper_end(struct amdgpu_device *adev,
> +                                    const u32 ring_type_mask,
>                                      struct amdgpu_ring *guilty_ring, int=
 ret)  {
> -     struct amdgpu_device *adev =3D guilty_ring->adev;
>       struct amdgpu_ring *ring;
>       int i, r;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index b2040f80b7f2..7e6ed43771f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -637,10 +637,12 @@ void amdgpu_ring_reset_helper_begin(struct
> amdgpu_ring *ring,
>                                   struct amdgpu_fence *guilty_fence);  in=
t
> amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>                                struct amdgpu_fence *guilty_fence); -void
> amdgpu_multi_ring_reset_helper_begin(const u32 ring_type_mask,
> +void amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device *adev,
> +                                       const u32 ring_type_mask,
>                                         struct amdgpu_ring *guilty_ring,
>                                         struct amdgpu_fence *guilty_fence=
);
> -int amdgpu_multi_ring_reset_helper_end(const u32 ring_type_mask,
> +int amdgpu_multi_ring_reset_helper_end(struct amdgpu_device *adev,
> +                                    const u32 ring_type_mask,
>                                      struct amdgpu_ring *guilty_ring, int=
 ret);
> bool amdgpu_ring_is_reset_type_supported(struct amdgpu_ring *ring,
>                                        u32 reset_type);
> --
> 2.50.1

