Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F35FC5B543
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 11:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2310110E7C3;
	Wed,  4 Jun 2025 11:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E1K+GkS5";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C253310E7DA
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 11:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dD9IkfTpEyKn1wpMngEfICqxrvNRhu5VJNieOrHHQB/yRMJajdCAhX1hzasdvc+M1bFHhtsKjv31dYs20+A9mtLBwcQVl/eIZyHlhQGSkQMv9qd8SMA3TcbDsrpE7zuEkSLp1cEgJyeFd0ValoSyozenVAFlf/nwKDkIjPvv1+dJuWlGB3mzhG0iJD065Q9695lE/gL+595vvuxVGPBy3zCEylDKpRPbzStucxBiER1zOKnnK6HTRkODGLwg/qxyQ2cbImzVaLY57OQgbamhhQw6Uumt7ySK2RuIf/oHAve0VbsIMh6yShD93y42hslnbRwJu1G8ZDDZ0uvtfH5/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbZgIVzK0ZwlW6YUESYukvBGMEwAJQrnl+fifq2Wp8o=;
 b=O2elLIMIy44AGd5GQjiJrXWgd2RGzgXAGyejjiofFrl8rfJrhm93JezU6bOiwQtzjIC/91G4VWBKQrWtq30paFdqGt1NeDw8FP/kFNkRF5dmImDdl7RrvyKpv8yYbZivp2XVbdYJPB9ie/4zk4H3di+8Bcbsq8tneQwpjhtsd7iprqLH7qet+UuOY4lJQhdzOOZfNxNM0/vloi65KdXMEysghZkbz29IRh7DTDAoQWjhobZgBq3vt0sn10P9rd8J360lMesqKlbfyAA2nLc72sZ7QhElnarzonqh1EK8+wdxp6sbPA3N5Cgyswqyt+i/60bOg7QF10JmQJKil3LYHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbZgIVzK0ZwlW6YUESYukvBGMEwAJQrnl+fifq2Wp8o=;
 b=E1K+GkS5Tv+JvDTPfjlxWzHJ41lphbHqWEE0pS6531EYRF8DApx9l/0Tqp5zjAcWOESpovLQqSN4ZeFR4IxQZb2umlf40rAdYFmK8mSVsB2lmSCqnit2P7EUBi1cOWIjum+innsYUahgvTu5m1LWfBjbquojqwAGJH/llzMBQE0=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by IA0PPF12042BF6F.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Wed, 4 Jun
 2025 11:39:48 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%3]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 11:39:48 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Zha, YiFan(Even)" <Yifan.Zha@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "Chen, Horace" <Horace.Chen@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, 
 "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Lock reset domain when VF get host FLR work
 message
Thread-Topic: [PATCH] drm/amdgpu: Lock reset domain when VF get host FLR work
 message
Thread-Index: AQHb1SUJGZQrSfHO/kGhomP+2ZdtyLPy3jJf
Date: Wed, 4 Jun 2025 11:39:47 +0000
Message-ID: <SA1PR12MB85993FA3971424C626AAA1EAED6CA@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20250604074715.2229924-1-Yifan.Zha@amd.com>
In-Reply-To: <20250604074715.2229924-1-Yifan.Zha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-04T11:39:47.400Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|IA0PPF12042BF6F:EE_
x-ms-office365-filtering-correlation-id: 56eb0a91-9e88-4a68-104b-08dda35c8287
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?j30XwIa6NVO+fKU653/tC+GjcT7QCbB8nfM46+hoPHnBoX10Xk7+whtqd5?=
 =?iso-8859-1?Q?hOaI+d5K8Kl5ZWtoUyYHjwyd0U5iEMXLUzP5NoAcmNaB/IBOD3qKcge9YV?=
 =?iso-8859-1?Q?m4N2Uv1sxAV7oRY3etHL1t7+FEwA917gNxtb31T0HhFDuDVCuUrYdGSIL2?=
 =?iso-8859-1?Q?tG88xFTUf60mYQNCYRX5ZMgzHcCeJi++Epv5ZoJXLsnpYs1lapDS7sOuV3?=
 =?iso-8859-1?Q?zB3ijYqQjuHZYcW3GpS/1hSq4ztSMye8RGkLWycF672YSSDo62h+hw0QX7?=
 =?iso-8859-1?Q?HqBDc1rz6pmXDOGTS+DzJyhyDFwbktDS+Iz04BuDUMsvCJ9yRijBylF9OJ?=
 =?iso-8859-1?Q?NHPsjXc/4iP1bbldqltdZCrVbSWSupH9hn6w0Q9/VQlI5nDGsyb36CJtB1?=
 =?iso-8859-1?Q?whUKe5QpRh8X6GvSAmA/oFo+vcWVVbC4DFDDqacsjx2EU+DC4RROLDb18H?=
 =?iso-8859-1?Q?Z5PGjcgJrllcxYM+oRT5lmRlbpZPGkzoOpILYCThz4iFDoWdrl9ty4gViJ?=
 =?iso-8859-1?Q?CkEcF+F3gUC1Gg+FiSXHKTbF/QH7Fn8TkDvLjTxtEVlA5ki9o74VuopNIG?=
 =?iso-8859-1?Q?YDkRzNRKx8l6zCCPjfDilMNIvsDy8O4Ir/yk50N6yRQ5jq5EzLRZRM6jvO?=
 =?iso-8859-1?Q?xkeBbhfbdSZ5O+Juyg5SY2cjVpLofKnJPA5SfxsBxKT5QRKsoDNT3A2hPL?=
 =?iso-8859-1?Q?hTR4gYc7KczjQz2PkHDyq0Kyp8+aQFiV4qATYkGS1IW7W1LNabrw9jzWbv?=
 =?iso-8859-1?Q?0hQ4x8ai61Nhh+KOGp+rRPlYKP5MAt9nceqMQJqMR7m89Wxj7nb5S7zCWw?=
 =?iso-8859-1?Q?RCBcdADBb9v7usDg7YmXmTn311YJujD2ALMJoCeSQLGuzW8cCTalC8eAYm?=
 =?iso-8859-1?Q?Zi+xjqXhe6zf/I9DX9ZZ5/fiRJBdycJMQvCCympdBX79fSo24zqn1Z8bm3?=
 =?iso-8859-1?Q?XrfjZfjnRYPJbOU/+1GGCC0R1398vchgB98BxSmGZqt50MQfHVoFqW0Pc/?=
 =?iso-8859-1?Q?u1Rc+FY60CiKg4jbsPCaOnv/M7wU0FgMIKx5e11YAO8nVCYkOqYejKx9fG?=
 =?iso-8859-1?Q?8fRXQv3IeEQu8Hqz3rSY/pNUKWsfICB9W4D5YaliMa9EVbSNZeGTWo5GS+?=
 =?iso-8859-1?Q?lzlLnDrQVQvHNBE7fWe5YIgwNNZmYsL69NyjzWBlrLK7mVxmsbdRndKFlx?=
 =?iso-8859-1?Q?1o3OiW3dVeQagtQ0H+H+4i/F34oby+yvWj3uR/vGBV5key9mjAQTNtgV0z?=
 =?iso-8859-1?Q?T9t7ImPojpQGE6bl4FavMvW7iA2WBU/LHNtbloDYvj7TKYjD7wFJQpZumV?=
 =?iso-8859-1?Q?UDxZG0jr2Jz/D73oRRPfE4fXevlBUP36VNS8CkBXDnAf4X2TRft5VgvrLP?=
 =?iso-8859-1?Q?VyJeZMQ+4kRa7a28ziZD3SmlWgrYaMuxTqGmfPmz0EQYB+GNgzuuN1fbFv?=
 =?iso-8859-1?Q?FwILCpDutSF6ZPK1sxFRpPK/J9Y7AcB3qoJH24+6pFQ9FRs7W2ZD9XXMlR?=
 =?iso-8859-1?Q?GDO+6jElxQYWPq9eX82gicVYD9jiYSgXssN4Gv6OhQhqa51RM+gwapT1kA?=
 =?iso-8859-1?Q?tKrV6Ps=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kolDxrFcmDjnGpkaVoos2gs+C5AnAwmqMnOdpj598i4Fcw3fCrgM87S11z?=
 =?iso-8859-1?Q?nTKWrKsMzM/f7vmAUIqPYDmrrMuVFW/DJUKKYUeYvqEQwBZATHwP0kJvhE?=
 =?iso-8859-1?Q?lX9ouyT+EnqsTTkBN0O99lWnzaa62p8u1wFbOVOI25EXmoiY9xiFLJK9U8?=
 =?iso-8859-1?Q?1+OzsUgO9lnWrJOFIPZ/XqQcag/4in12ja3V6iApAWN1DCdWeNHuolasMR?=
 =?iso-8859-1?Q?DazsEmdC++aeJMs6YJ5B8ES+oyJnhnYiePvoLnusgiNxWrzWKAWOrlyBUF?=
 =?iso-8859-1?Q?/WgHz+NOGBX1rfUAHWKbb6D9ciXjgFPcBn8jgjqj4HxL16aFizQOe0T0k6?=
 =?iso-8859-1?Q?ONusktukLYcGz3+W2lmUyoN/yXsER2mMts94zp7qx1wXaviKLbR17YeYZI?=
 =?iso-8859-1?Q?g6+/W8NDDb3noMPf7HbtPuimqNHEqc8m8WQ+FBOLJRH0RbJyKGorVOv2u/?=
 =?iso-8859-1?Q?9rLDtq8scpr/Gl2o9EQySUziCRKFAXttYHWjZ7pda/L9BSUpmEwre+dVir?=
 =?iso-8859-1?Q?QPw38hJLSq++b2FlZ4WeU6yFokSHD55unZ3ZXR1AKO6lbFz5wZLHag41Zd?=
 =?iso-8859-1?Q?x3BT2X2vhxboWt7uD1T9H4k+jKCxPa81adq0TgMy/Fw82MZMXuZ6su3dzU?=
 =?iso-8859-1?Q?+7Y7dZpdHwHDmfqQbB+AtjUIhtYqRYdlScUgmWLX+sbeOSzhA/CipxgkZu?=
 =?iso-8859-1?Q?7a/IlCxgrogiyz750wZVKcsl0ARR005i3aPJ7JaLsXcNJ0BoLnJIpwT96T?=
 =?iso-8859-1?Q?cKnwD1sowCilfowN9z6+eUvO8aS7sAAeJNLXiJKocU3aV+LrvH90wCXqbK?=
 =?iso-8859-1?Q?gjBGijCbCw2rJ8fEJl6WDR1RENxcoY12SB5ljR/jz7E+oDtUd6e7Hg2pIg?=
 =?iso-8859-1?Q?DUSDBMZES2srxNmbMU3xB59anuyFflvup2MoXFPurEcNvU5ushNwuDsgUp?=
 =?iso-8859-1?Q?9ZzUWeYZy6cqlrvE6XECX7MFdiOEoK+plScs3i9IZw7gckcOxlOwPMjAVh?=
 =?iso-8859-1?Q?2ZYMPJfRkEQqPqKMqZYpuf2iPO2EuaKHLMOubhDhiwdMWA9Kh5/b/vduj9?=
 =?iso-8859-1?Q?v9kUa7vvNflcSeOHar88y7KSwWvokgjyKAiADh9+SJ3xx+wT4jp/bGq0zg?=
 =?iso-8859-1?Q?EsaktqA87cL+/GQy7Jks+MRt1J71IPS7OkgOb3PxITckQ2rLkC+WkWVhAp?=
 =?iso-8859-1?Q?D40tVbdNWNG3BUPEYgEqjDvFY3eGVb+NCvyBzCa+rvrrZJwg0YkN7IKR0B?=
 =?iso-8859-1?Q?AU6ZjMMCkjH9ZlEZ7pRJ9JeJacmEKIa4gig9Yuq+6dWJOXSXS91/+IQii6?=
 =?iso-8859-1?Q?FgvINhPFTyR5sNCIs7PoJZNHJFgJIUDTavzfkfWb7KYn3u8SbN/CS0Owfs?=
 =?iso-8859-1?Q?niCAxJuynO8d9VkSA3Xihtg7XlUZp/wWYPj7uDoE8O9o30vshcpqZ3rXN4?=
 =?iso-8859-1?Q?DpjOfoBoHMwVYg0sKh6rB1qrXQ/GwrsybyjhZ6ny4q8Q9wfTu9T77xzW2h?=
 =?iso-8859-1?Q?ckegwHyUjUd+v9VthYMhAw3WNR+CG9NjuC5g5FmzTxSgE5N0EqWEoWMSu1?=
 =?iso-8859-1?Q?I8KquDk5J2nJfWYBWh1Qti+PRSBEYaM2hgqu9i4PqIjwnW+nj6DCBjmdpu?=
 =?iso-8859-1?Q?tFqj031ckCcPk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56eb0a91-9e88-4a68-104b-08dda35c8287
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 11:39:47.8256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZEBLIzkEMp8j+1sKkyAoddNaohOijSSHuUPGPSvAJVm8gqJ/PJGnk6MQUo9XrEYcVvlU30XONVj4dHveCAxKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF12042BF6F
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

> @@ -6098,7 +6097,8 @@  static int amdgpu_device_halt_activities(struct am=
dgpu_device *adev,
>       /* We need to lock reset domain only once both for XGMI and single =
device */
>       tmp_adev =3D list_first_entry(device_list_handle, struct amdgpu_dev=
ice,
>                                   reset_list);
> -     amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
> +     if (!test_bit(AMDGPU_HOST_FLR, &reset_context->flags))
> +             amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
>
>       /* block all schedulers and reset given job's ring */
>       list_for_each_entry(tmp_adev, device_list_handle, reset_list) {

The host should be waiting for amdgpu_virt_ready_to_reset before it reset, =
which happens after amdgpu_device_halt_activities, so I think the lock here=
 is fine. Is the host side wait timing out for you? If so the root cause sh=
ould be that we take too long to halt guest activity.

Teddy
