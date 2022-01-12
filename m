Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3A5C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 09:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6EF7113321;
	Wed, 12 Jan 2022 09:13:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A657113313
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 09:13:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxF4QJMlp1bD1oYPZerKFqtWYWsXg8Ce24404WxmA5uHaNv89avjHwQTqHMA374P0gr5rKVDb5y9kopQKfLr2a8l2JeTPaBO0bYzlHAB0HMhAIsUWV70MtrWDYa3gCrdkWmKz65EqTEaCTyceLnxTUv/L9/qL7O5aL1gDiNlRRFvCRAECCGk/zLnBWcFfICquuXOQI6LH0KA10I2ERrkjuuzYbsGN3e8pSHU6VVkTfVM56LgmUwkW4fhtJlwsmibGZkB4bKCUqPGIi8/lwQG2vXsQLoEBxcYLvYa5Yd68f9Zx8hO8PV1QVOvGOJN0Alfndh5lhogy1pH+2B1NQnpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnalKXsBH9CuG3Brfd1eu/wfRVApRpJEn8DaG7QEAy8=;
 b=UKVUeq2wjJO8Oi+3nLqmuoabiQgnYx7fou6CmZ28hPQ50FlSjn+4Em6jNFkSozBjz5dya0hkmsFUgtNuHUHn4j9d5oAfKR60DC4zduChnaY9eoEuQ7NL7Drw0jOCv9qpeOwc5wohOezI06St97I1ZX5IrqhsM4lpI1ty86stvJxSQSEPUJ1O49gCkunTxLK/VeX4EM/EMcO3fjB7qP1nHlFb2Hxy7ahWCK41648hqq6Xg4m8QSZ7lRMrBg8kxFljRWVqyb4idagPCwRZFMT2J/SvlNjO5+dSjztEHGBjbqiIUMURYtKlIRbdaf8EVFBbirCoIPHkmQKo/6mi8V+L7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnalKXsBH9CuG3Brfd1eu/wfRVApRpJEn8DaG7QEAy8=;
 b=QHRJDOuFpL32T7CgGSl4hbDcNDPqRFh54E8cO3m5ClpGnDDJgIgPPaqblgJsIbCqqkWXItw7Oxu0sbpq07BTkmG7ZC9a8jTHVkf2Qxw+02PfVaBsdcdPH9TvgWpc7gaAyJbs0jh8EkG9rQxbKo0sd0LjNPTH4EihbCt2iwpUfuQ=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CY4PR12MB1384.namprd12.prod.outlook.com (2603:10b6:903:3d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 09:13:19 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::68f6:f42b:2c29:7f94]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::68f6:f42b:2c29:7f94%6]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 09:13:19 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: No longer insert ras blocks into ras_list
 if it already exists in ras_list
Thread-Topic: [PATCH 2/2] drm/amdgpu: No longer insert ras blocks into
 ras_list if it already exists in ras_list
Thread-Index: AQHYB4jQYTlX6XLig0Sz+X28kPiSbKxfD/6AgAAJWjA=
Date: Wed, 12 Jan 2022 09:13:19 +0000
Message-ID: <CH2PR12MB4215AF5A5832C2E3964201EFFC529@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220112074802.2867813-1-YiPeng.Chai@amd.com>
 <20220112074802.2867813-2-YiPeng.Chai@amd.com>
 <DM5PR12MB177086BF0F422DFE80C636A7B0529@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB177086BF0F422DFE80C636A7B0529@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-12T08:36:43Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=abef01a3-48df-4b61-b3e9-38070ba244cb;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3a534e6-460a-4323-68b1-08d9d5abc6b1
x-ms-traffictypediagnostic: CY4PR12MB1384:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1384F5AE3FA60D535117B3D1FC529@CY4PR12MB1384.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WLCJRnPg+2oNEurv1LewlT3S671Im35Vq+tF4g7/GD8nhZCnx1TKokjDYI1BXpdVpHy6yepDoVNXqkQq/U5uLoCEh7P5KUcPAElz2ON4sk3fchE3o/lva2NbKscPbmbTIYbVi5fJPr4neIhsJ2ggN8BKZMPVpv9qcBatjkzQ5JzVOFYcXCtp4FUxDBcpYFMKuC3N0i3rsKRdK4GLm1eIjmgrMmg7UP6vHYX7XaFUUjUk9gkK/kzhn7I10WuD3QUymeb2dRiNKP/NZz90FC0YXfcDP+A2b/4kUZgPGVuFAxtAqpUZTy8fn6EOe2OfAqSbHegZR27cOISv1KBADLv6W6SyYxAqR6cMdMDa0Cyo1liX6F++6WjnGXdn6mvLXlroVTn7Q+iDc/1GzAjfrhOzLp2Mfa4xIXgthyLtACJvmHwbDptheNBGMEc7QD9N4bpauTm6rOPfJFIFJ4XHyfecyhE0ckLK53wW8ujoDtXlrfkH0RiQINznKjGdGeMtzaDyCNivkg+lCWBL58hq0c7lRjBTPY5ims1FU2LNd0k/Ckqe6jTXxL4NpxcIMvNklaWiymfYtR/DImM9xVPpgQaRIDfGMHJfiXeNoJi4e3khJhbcH9kDe/22ns2t6R064CVH+rxhJCaIx4Wpuz3ZQpaPKlrX/9oSc5GqVG3aS4sfhO2oKX1kIrKd1chCL/PExT0lkhW8UGVMs3loqGaLOZEVgQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66446008)(508600001)(64756008)(7696005)(71200400001)(66476007)(110136005)(5660300002)(66946007)(76116006)(86362001)(2906002)(54906003)(52536014)(316002)(8936002)(8676002)(6506007)(26005)(186003)(53546011)(9686003)(122000001)(83380400001)(55016003)(4326008)(33656002)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NteCiopjrLBGv2KKpYC+isGtvPrKvQVnazhTSyFN1uDScQZKPLm8Ux1IdgOS?=
 =?us-ascii?Q?cTF6vntPQu5raaHBc9/y5xEBT64fKbsesZ7FV3peygKDnilomuMp08NHFij+?=
 =?us-ascii?Q?JGJWD1s+p6mMxgNXJ7FljH9Frahg8TakhAlZ+kS/TfMUPcEhvFZchZfqeO2B?=
 =?us-ascii?Q?G5XwzlevORGcueHTEnF1e8rLgH0a9bIttxmMGyfKnOFfYas5h02f3tPkfsO9?=
 =?us-ascii?Q?QCxJDvqAvJIqteWLDasv4tLLGaN92UesFtFOgm27y2JBe5VMxADsu7IcfF1s?=
 =?us-ascii?Q?xRC4DQd+vGJLZ1EKA50QPOWdQ01pzWe6it6jOzKgAGVe8PfWPYSzGvAIN9Uh?=
 =?us-ascii?Q?KYOH3klKgDDAngjB2oQsh4vHJMNMA8uRZTUbsAkXxX9LZcd8+MGwUyAaQdSK?=
 =?us-ascii?Q?b9TiG5Eae8SwAx4edgVgL/a9UXIlJUfZTxkwZQu4KMiKAQVD5uSRuu2YYVDZ?=
 =?us-ascii?Q?XKUaPmDS2SxhTGkr6sW7v1ACIEvs8JdRo7J4GsznOTt58JfboWJInSMX2MrI?=
 =?us-ascii?Q?1gQ1rRG/8/htWSmp/WGwxt5awvZINYaJDMaUkhU4hVGVSXOseof6GqWzqGxQ?=
 =?us-ascii?Q?ybtHG2082VyYNnvsO0dp/r0F5hoEUpqI22cpcpxOnp4FCfTmHKRc8reUkMhZ?=
 =?us-ascii?Q?ig0AIPHdk5ho1XDmGHfPxMdOtyjws5ooM08+w3O1gp779OosVMdLCl2nAnRy?=
 =?us-ascii?Q?pJatr3+9hLqBVO+Fyjpasz277zkbc3FxHvzt7Kphu6UbU7M9H3Oh6LTdRANI?=
 =?us-ascii?Q?hERfUqc8m6bnPBfhTCCs6TY9TqGo5tjWyNYsm1Z2DZI+HhrIr9tDxnMDbCNQ?=
 =?us-ascii?Q?xQQdAno/e6GO/4B2HDqJ+jOd1dMjNncFpxB43ePAlxNNHG/aG40bt34avaCW?=
 =?us-ascii?Q?LPB/r2iNZXTFSwns1fdPgwpa3a80vq74vnqjWPiylZmSE+EgYDme5cI+GhGR?=
 =?us-ascii?Q?esyfSa27wx85atuIxCqJpIi6d5NlV8Ug6Hfk8QoydwUdZ3zIyrQ3PBEtLri5?=
 =?us-ascii?Q?h7Og0dRviYosrPno7dEJgDAe969IoafzHf1t23cQ1LF8TJ518tm47OtVOPw8?=
 =?us-ascii?Q?QQV5xI441MON5UT44zfhfT2Wdd65rZXqkxPdmCSCvFRdcwxoMUQcFaneMTz4?=
 =?us-ascii?Q?5J35j5VdlRdMLDbIifsuVU2yCXXC/mb7p6GP7+3efDX7BqW564QCbU+w9q1x?=
 =?us-ascii?Q?qMhmgDZmZgbw1DLrc9rVTs5ZIS6EtVPFZicI9R9niuPF1YerlCyDRf/W64Ro?=
 =?us-ascii?Q?EpDxEZ1u5qlRJEWnZyhXjUnCxQoVueEABRz4JG/aNc0mIr/aHEz75exMaovX?=
 =?us-ascii?Q?u2v8FG2xYripYbAjJvFe2irx3nZg8cM8hOETo1eRIG9zxa2MftIib0LKrRUo?=
 =?us-ascii?Q?RTP/7UT60iOTvRChzUWjOz7nMDGtliqMTtc8OIjxXHNUwc8CXz3DYbdOqTPG?=
 =?us-ascii?Q?5MajAxrIEdLMpDys+jpKUslMH2B33wXv0hwGYLbHN1rPAZuDDcVqwZKCpEQ7?=
 =?us-ascii?Q?EqUlj2xNnC5ZFvo5q5n9PNrgTybGZv2+Pj0GkG1LGE03QLF/7dm2E9R5JzDh?=
 =?us-ascii?Q?GOnUm+0oNZerNY3t/k2522vs819thT4D76/1i+1QJinc55+SJlwU+WZN49AX?=
 =?us-ascii?Q?NMUm52heyWvwNaturjV0BJY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a534e6-460a-4323-68b1-08d9d5abc6b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 09:13:19.7869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cg0P3HDnMo/7VAaHI4nuiyr/jRf9+6glkXDjjtwQR6ULvHWjlubeoTy+nlm3hY/YJFMWozT1hgSkJcWbCmx9QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1384
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Wednesday, January 12, 2022 4:37 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@a=
md.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: No longer insert ras blocks into ras_l=
ist if it already exists in ras_list

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, January 12, 2022 3:48 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking=20
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,=20
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: No longer insert ras blocks into=20
> ras_list if it already exists in ras_list
>=20
> No longer insert ras blocks into ras_list if it already exists in ras_lis=
t.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 62be0b4909b3..e6d3bb4b56e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2754,9 +2754,17 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device
> *adev)  int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
>  		struct amdgpu_ras_block_object* ras_block_obj)  {
> +	struct amdgpu_ras_block_object *obj, *tmp;
>  	if (!adev || !amdgpu_ras_asic_supported(adev) || !ras_block_obj)
>  		return -EINVAL;
>=20
> +	/* If the ras object had been in ras_list, doesn't add it to=20
> +ras_list again */
>[Tao] How about "If the ras object is in ras_list, don't add it again"

[Thomas] OK

> +	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
> +		if (obj =3D=3D ras_block_obj) {
> +			return 0;
> +		}
> +	}

>[Tao] The patch is OK for me currently, but I think the root cause is we i=
nitialize adev->gmc.xgmi.ras in gmc_ras_late_init, the initialization shoul=
d be called only in modprobe stage and we can create a general gmc_early_in=
it for it.

[Thomas] This can create a new task to do it.

> +
>  	INIT_LIST_HEAD(&ras_block_obj->node);
>  	list_add_tail(&ras_block_obj->node, &adev->ras_list);
>=20
> --
> 2.25.1
