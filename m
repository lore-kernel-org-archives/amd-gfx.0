Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECA6C77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 06:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4750E10E482;
	Wed, 31 May 2023 06:21:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B691510E482
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 06:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdwS2BIYcjF9u5e5xZrexCXsDOrVgSU6M8D5pyOeOQ6Cz7af88eRPkAZM2mZIxwJgmmAFBaGOCgBnW36HLsFmNXp6FYMCD4JlcKlVxmDSrLL3UNARgWvdEttTFZvD9VBKRkBW4BxlgjtUgdpgbspVJc4L1OPcJBRDYA1MKiO7p6jzzsZ5vcD5tjFs9LmPZVozq6lhWrNab7xMWhc7IFYWQ+BgjaB26TyQ0bwYMQN+bDqD6elgMP67JUNyfTxPFg2BOVxEPKx/J131ArbSsK0gbc8KBdODB/24CdE+WZJrDZvZ6W0uNn2+VQme+12VI0MJKT5qedPxZWBsX2ozglWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzIdGDBmF9Ou9cWtsasumcky/dbOX84XNEhstuFutuw=;
 b=B1oWpHvV5TwRfCoYrNhqY825sAypBVWNC0aB2baRbs57Hvw9EvfdyBDVJJp0Oanft4S+Nmo9cvwmWw0mBR5R5lakLssBveTIwDw8XOff14Ndto84XMsSehihktPyISxgS1BsKw3SyOLMSRKvaK69MkMLPdWX1b7x9OPjy6+OfJsf+f9ZYEhpy2fZirliWkvTNXfH4Fw7LubzpEoPSKbC3dcVotjexyHExIGsL+y2h8tqWJ1CdwjoNXeRxeo1gq4ZVJCHfv9ldELcaSAhG/Ouncc/TdNxttIfyvDfgOLHXfdGWnjftZDz8UUl3X/m5AStxSBNwMxv6716kLvn1n8YMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzIdGDBmF9Ou9cWtsasumcky/dbOX84XNEhstuFutuw=;
 b=hkYPsUbcGevbPEKTiBVADGrOUcwE8q7OQU4sAI15gpH1Ded1qEPyy1+cvFzkkdlNoyo4AJ56uL2QS4i9u3AngodhV/33Sk7ucB7MImB5R5QeEIzhXfaLWNFoRbmjitdNEznoVaQuktdaMybRxp9FX0F+9Ub5JkiEQNhQ05UENHk=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM8PR12MB5464.namprd12.prod.outlook.com (2603:10b6:8:3d::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.24; Wed, 31 May 2023 06:21:01 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374%3]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 06:21:01 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Min, Frank" <Frank.Min@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip force complete fences when ring is
 uninitialized
Thread-Topic: [PATCH] drm/amdgpu: skip force complete fences when ring is
 uninitialized
Thread-Index: AQHZk3sn1PCWgH1L1kGS3Njp2bfsmK9z6Qrg
Date: Wed, 31 May 2023 06:21:01 +0000
Message-ID: <DM5PR12MB2469F0BB7AC522A394AC4519F1489@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230531044812.460358-1-bob.zhou@amd.com>
In-Reply-To: <20230531044812.460358-1-bob.zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9870b821-dca4-42c2-8c1c-dde4467880b3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-31T06:20:40Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DM8PR12MB5464:EE_
x-ms-office365-filtering-correlation-id: ee186e91-b02f-4de7-20d2-08db619f34d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mNSwIBpC/fiUPseqjkFzCEWt0MKCpptDeOCOx3wcqFZyFrFu/vvVU5W1Guo46GzDn1ojAxzcnvx8OKmFCWsUxkC3p5Lq+8Rv84gG8AZAYOPdzlIHQ8sYCsHsXZaN55kqfi9vttbg1/gGmHtyfi40fm4cyBcA7LHx31rOb2qsHpH1bZeyU/gsOLMZeFpfoZuHRh3SvraGznTIhQs0yU7XXJze+kDHmaqhyfr0qMP5EEHh9vdyHl3SkEYOXdzeh8W6uh+XEw/6hp7FhqQ6yV7Y9gBD/WM44jkjlV6rFfa0N9pqD/YMhk2Iv8C8gAueg+uFxuqn14l71CQ0GDdSywVE69SmLeA9MVYcV4pmb6MPxGwX4ghWnsYB/tGjLyblNn4QIJlkQkFR3uldml96FfG6CwHDskPkJuJSZeLdzO6rPvaqjyP+Iym2tcaIgoRfT5EiR4lD5Bl4fnFXxnrjWuReyNZuS3c/GChoZnNT03ARrDOjxmsMVR5r4EHKj9mt4K3kqMnVnbsxa/+ukfxSTAqQmCJuJO0/ff3RvRnTaL3MibJBfOK6TyWfld8YkilXL5iLdLn6MWMRoFhksaAwAd7FijFLfkNQVLTtph9ifLLPkXe7Wr7q0gBZpEqa95y9vf1K
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199021)(83380400001)(86362001)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(186003)(4326008)(6636002)(38070700005)(2906002)(26005)(9686003)(53546011)(6506007)(8676002)(8936002)(33656002)(38100700002)(52536014)(5660300002)(7696005)(55016003)(478600001)(41300700001)(71200400001)(122000001)(316002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ikS6ouiZXTJMxcCPteRrh2jX8bpLBbJpkh9ex8ATJrY0mqVmiHbflaBoVwGi?=
 =?us-ascii?Q?aFYjdt8jNDgxO89aqrkf4mCkrqc2cMVY9SxQc2KPuBDo+yB9OXq8UjTpCI24?=
 =?us-ascii?Q?VsqjdQX8tdKzJC+Oca46SGUF8wJaWsY7f7CBtqR9SYZ+Nnm6MF9fSaGMEWyO?=
 =?us-ascii?Q?lv+BiyiqyHOADDneqWt3wgGf8u0B5Q+znVwNbpw3o5948xmfI+csJnS/VSkj?=
 =?us-ascii?Q?zi8oeKavtx12aafU2c/Sbs/uyBJ96GajR3BEQCdFHCV0m8JJ8FmoVLst92tH?=
 =?us-ascii?Q?/OyiePyZsV9CfwB6qZMDBRWwm4djQRx6nylcb/QlHjTgz4ld96rewU0fKijw?=
 =?us-ascii?Q?lW2wTq/6+V5uWJ1ACgkIHQmRcFXqRU5qx+bdtjPIsb9x9oYByEaY36jdSXlq?=
 =?us-ascii?Q?aXeEl6KMEKEX9bXyMwf/baC2RdhDUkeIDPFcDPjmjRzqkhiUqwz7lZv4O0Fs?=
 =?us-ascii?Q?wOp1lejkU97zK7tzxIb8KkZEEM22CKfEpI1Ryap8AwSKDBZ01vtCYkCgeG70?=
 =?us-ascii?Q?SvAHreC8Rktj2GE2KurYOxp4KpX5D03lactB8rDlhNcpapXI9rdrI9Zru0tg?=
 =?us-ascii?Q?DgGVBQ3yUVgk4urNMiVIuArvQGogSVlbrMXgjJ3BVSwmtHfSWBKDk2NuZtXZ?=
 =?us-ascii?Q?Z2d5IbSCUaUXq9QjxwTueNGutHMLTHBgQ3sCXSDuuaDRdDeX+Ht4cd4aSEiJ?=
 =?us-ascii?Q?w0qg85aa2N653JISsZ3qWimyMbqWwdfQ+SCe12A8LWAtgCeUL19p55Fa1qrx?=
 =?us-ascii?Q?bia5pJUzBvwRJRd3Xxy+biTap7CWHUJNHjT8N4EIV0//AWgZ3h4C2pPM52LU?=
 =?us-ascii?Q?E/NkG/ZFujqf4qWV8B81MmHTmZhjuTgQ7pMOq8rhvEsOVxpTQMYyJiryzhAE?=
 =?us-ascii?Q?IRYLAzEZUtbNq4GetrVrbFNaG83dNG9RqbNY7r4ALbIPTwhwVlU7jsrdDT2l?=
 =?us-ascii?Q?ld9u/Cum0mS1z1yFLmFpzVu0ozNCpexfF8zxTVrn/ITFGnlbaCCKHmvLMl2u?=
 =?us-ascii?Q?e9RZx551U58m8mBYE7O6fc9tWeCyu58OyvUrSAewscPxPWeIMFD9oM/xIxmf?=
 =?us-ascii?Q?Gelz7pX9+XXARlyrHEVcKDwfZD4ZGajhumaLyHD+AXlc3sNaTyoUq4TxeJSB?=
 =?us-ascii?Q?txYRCrjaPLh2pjnxGD8sPLDXjaL3kSRAv0aDNIMUJDac3uf1wdj4X8IaT3+7?=
 =?us-ascii?Q?IzVyi0OrLFztmiqtDENMuJvgtSVrVS9gv6CWGM8t0WCFfK+UcSXqBh4Z/df/?=
 =?us-ascii?Q?UU6GarIVlcccYbkrFLsbi6S+f4Y/tOe3V+q1JNFs+XXb866gXH9R5eL8gAop?=
 =?us-ascii?Q?s7697X6VHjxKI8E4bW6gRn5+DzrGHJbqvKHPwdVNnzYPkwH6fI4QcpRLwfcm?=
 =?us-ascii?Q?L7in3tK7z2CIovWaQ0Bniz3lufJpkQH/YdZJXT+4BYKQRMwHvhfcAkLrCa3s?=
 =?us-ascii?Q?ZRFLwrj2APbWc9B8G5XRBq6k3yjlgP+XpNe8U4uYE5DOc6JfYhL8sgfymFXJ?=
 =?us-ascii?Q?DLq5cE230kOaUXBuihCEzgXO308ZzuLcU71gC6SxBe+rAbCpV5GZhGW8Wvyv?=
 =?us-ascii?Q?muyMQJNIotFixd2wlfA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee186e91-b02f-4de7-20d2-08db619f34d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 06:21:01.7138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TlCN4s736gb35dZw5CeOwevQ7CVLu5pBll5ogTRpv/Q/iCBJaRUiMRIGjfQh30Czr8t+l9+PF5K0qgtF+MZ2oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5464
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
Cc: "Zhou, Bob" <Bob.Zhou@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

> -----Original Message-----
> From: Bob Zhou <bob.zhou@amd.com>
> Sent: Wednesday, May 31, 2023 12:48 PM
> To: amd-gfx@lists.freedesktop.org; Min, Frank <Frank.Min@amd.com>;
> Koenig, Christian <Christian.Koenig@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhou, Bob
> <Bob.Zhou@amd.com>
> Subject: [PATCH] drm/amdgpu: skip force complete fences when ring is
> uninitialized
>
> uvd ring in uvd_v7_0_sw_init only initializes ring in bare metal case, so=
 when
> executing amdgpu_uvd_resume to restore fence seq in SRIOV, a null pointer
> dereference will occur. This patch correct this.
>
> Fixes: 043f2271e2d0a ("drm/amdgpu: mark force completed fences with -
> ECANCELED")
>
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> Oops: 0000 [#1] PREEMPT SMP PTI
> RIP: 0010:amdgpu_fence_driver_set_error+0x3f/0xc0 [amdgpu] Call Trace:
>  <TASK>
>  amdgpu_fence_driver_force_completion+0x18/0x50 [amdgpu]
>  amdgpu_uvd_resume+0x1b2/0x380 [amdgpu]
>  ? amdgpu_ring_init+0x73c/0x820 [amdgpu]
>  uvd_v7_0_sw_init+0x358/0x450 [amdgpu]
>  amdgpu_device_init.cold+0x198c/0x1fdf [amdgpu]  ?
> pci_bus_read_config_byte+0x40/0x80
>  ? pci_read_config_byte+0x27/0x50
>  amdgpu_driver_load_kms+0x1a/0x160 [amdgpu]
>  amdgpu_pci_probe+0x186/0x3c0 [amdgpu]
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index c694b41f6461..d2c5484309a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -723,6 +723,8 @@ void amdgpu_fence_driver_set_error(struct
> amdgpu_ring *ring, int error)
>   */
>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)  {
> +     if (ring->fence_drv.irq_src)
> +             return;
>       amdgpu_fence_driver_set_error(ring, -ECANCELED);
>       amdgpu_fence_write(ring, ring->fence_drv.sync_seq);
>       amdgpu_fence_process(ring);
> --
> 2.34.1

