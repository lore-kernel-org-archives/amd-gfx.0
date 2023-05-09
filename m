Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E068C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 13:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DCB010E144;
	Tue,  9 May 2023 13:34:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1177510E144
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 13:34:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpH5s5EoTiYLo7SFaguYMFZxeNhXU8s6o0U/KqoY+a/9aATv/ZPmrMZjEk4JnGSrxnVQ5u5SgkMVaxR9DgEOf3P9iySp+6d++U1p+SL53+oEbo1su9h3ZNm1nAr//TQc6SKVIrGgGworgkbM/4LPseTy7KQGn2HB3toeJxpqPekxRoWmoS+otL7bKS7O5FuYqZhOiyY53fEIMNTqysMdWqaxjXYrcVdzDUUwxLs1ZTB5sUEN7nLSui8dviCA148HkrdbP6m9JOKjjYD+q9paWmPmp1Aexu+5LQubTwLsriYqFHdGUXhfdpddFUXF77S3iFb44FzV9SjeJFOEw0UkZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQHP+eohpQNuACJnY6ZBPjEhywhtwrPBaXfvuNJzlrM=;
 b=GfIkmreiYrAd9nO/IeO/PqDWmpUUd0yMSlCzeiyPozdoRZ/jGLeZ5lr2gBUWsWQpSIQ025ig6ySw/30AYqhjF2DHg+0bawesz2JYMfDSr8+VEOid0g4O4j5CkSKXyB3Lvft3zEBgmfCBdAAzfUasbI5242eCqnUmz9rsuyD7ZdTgnXZnl73XGlpyiGPi9Q9XWqTbyUm2Ei0KUxs8OPE7QEI3gS1DS5o7Grr8HEY1EEZmoEOEZl/HdP/TyBFPeHOESCbcTRkWmFHhZTd4NaxKXUL4JnLJ80L6K7IRS7unX7PgVgc676Ly0y0SQWxKvQKSkCCzVU/qwGvTdNeHyntBUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQHP+eohpQNuACJnY6ZBPjEhywhtwrPBaXfvuNJzlrM=;
 b=UixnO9Cmic912+ZWaLolCcVNEZu5GZIwdOoygKmGX+ZeCZYJz7zUT2rjIiZYCyNToOT3PNvF06jyDoArw4OFigemqeOzwIlO4HDcig0U89zRqb99usTUWAAgQVebgo5mGw1YNXa49tmItHfGOCccumsQUV3uUv9tC7dntS/8OJ0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 13:34:31 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::28fa:232b:593e:5836]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::28fa:232b:593e:5836%7]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 13:34:31 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable sdma ecc irq only when sdma RAS is
 enabled in suspend
Thread-Topic: [PATCH] drm/amdgpu: disable sdma ecc irq only when sdma RAS is
 enabled in suspend
Thread-Index: AQHZghV6qaKG/6Fy2EaDc7sNMLSuL69R8aAA
Date: Tue, 9 May 2023 13:34:30 +0000
Message-ID: <BL1PR12MB51447905EB97672F601E6468F7769@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230509012734.2095928-1-guchun.chen@amd.com>
In-Reply-To: <20230509012734.2095928-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-09T13:34:29Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2dd4cc94-6e9a-4c85-ab83-62794d33ca43;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-05-09T13:34:29Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 20257089-72cc-454d-94ec-ab0cf962005e
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ0PR12MB7006:EE_
x-ms-office365-filtering-correlation-id: 0799fee7-609e-427f-28a1-08db50921e81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SIPvz/MUw6emOluvG9kn/ZmYREYttpLFwQaGHvB9UnVgT78Lt+b1wQYFv2X6Vnh82n4hRdsbzBwLO4GXohlG3aQaH5Lu6PlGCniEFvrZdX/7nZCGOuy/Io4b/NvTxySUpRh2Zd1M3op9C0UABl/xYK8hHpqK9dQdP9q9MCz65U0KCIQ1idtQznIwKQEMYzKyu8ifcslakEdEWXLq8zvHtuH/0h1cVwgtOO5wnAWBK/YGrTLP9F0cQ8LMocNSI++53az4M04X6wqYu4b0EuSaxE8/21k6M9sfr74KZoFXobHdx8k/69u+KFxOqechN7scH5GnBPzsBa5QAvL9fhQZaP0TwOrA4jmTH+q9KCASdwoFlpSfU229sXHmyUkKl6LW+fkA8p9tBXYPaq/Sas0dQwURnLq+pKPEyTvErWupnm882cTpHhibmD/qEVWUbjqBAS0HsG5pDtH2FJWexcKSDHE3qRMHrT4ZfvYnuimLPJ1toPhKo0XVtnhbQtZZIWaoPytI5BDm0HqNf6fwo0tQ3BN0iiKe23jXiqGiL/H++0zC1rhIuUZDmb/HDdmtpTolM+w4f9WoyTX+wPL7ajOROg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(33656002)(52536014)(66556008)(122000001)(38100700002)(2906002)(15650500001)(55016003)(316002)(86362001)(8676002)(6636002)(64756008)(76116006)(66946007)(4326008)(8936002)(5660300002)(66476007)(38070700005)(66446008)(921005)(41300700001)(966005)(83380400001)(186003)(53546011)(6506007)(26005)(9686003)(478600001)(7696005)(110136005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TS5xl+J7OhyaNgOSL2ka5z3xxNvu+/aLUfzsxOVRj7KoGzyJpoB8eRMs1PJX?=
 =?us-ascii?Q?rScyE4/fi+JhhfPugAF4vSvyV3/i9IrK8EelDMR+UBm7X8wytjxqHt09Yh4T?=
 =?us-ascii?Q?QYGFHtrsecYaCgR9dvpkqt5PnUWFzKjvV+AitDBQt1gjVzbA/y8y0i3XwZ2C?=
 =?us-ascii?Q?1sMBxZ5n/XPe6AwYVrp8aIX8yV7vTFYacPqcwdifmsvy43if63cBh2EDILxi?=
 =?us-ascii?Q?sRMIfGCCN2bpRwcQY72PCkheLOaczhcadRAEeVVYJFMHEcvbNJUUbF+PrwE6?=
 =?us-ascii?Q?7T5NFeXLz9GQBvzLUHxn3iFq7A3iYoL3FuR1Xn9NmLrTEvT3qRBL3DR9EGWF?=
 =?us-ascii?Q?cPkSM4FrDDsTi/yX99dfIf9G5CsZ3Sbd8pfXDslXT8kpSwVczOvLtW541I60?=
 =?us-ascii?Q?wRJ2utKr54iJ4QaiYwv/NWyOEzU0ZamI2RJiQf2VpXy8JlZ5NfPftdZtHPIv?=
 =?us-ascii?Q?mXSw/8KxyJzW8A2iiLIqS9ebdoYTGa5ijnDWoDDQ/8mw42C++EIdikP70Q54?=
 =?us-ascii?Q?Z9s+Mp+X1tZNQmEFODZ4FRtlpeEYGn/lsJiRPGUfz+AxbYRRhvI4Qb3V+2Lm?=
 =?us-ascii?Q?/+OsPiplSrYiqRq+UZjk11l4/aIicMHHmYLK8sAyoKp9n7hSpdLSq1o1vqsS?=
 =?us-ascii?Q?lFxPSGzlvqEXRddJiRETihP2NnBMNqluvhbz4Y79KYfIF+4SafLP6EL1/oL4?=
 =?us-ascii?Q?+ZbQlwZjWCysnD++aNO8nJYVDroQ2Ci7HtzDxaKaJR8ZtxpDO1+0+7fN6Had?=
 =?us-ascii?Q?SloHgLmwuMeTcFbTR/i6iK2Xe4cIlofH8wRV6EkFUGOvH8cc0WnIYRil+2um?=
 =?us-ascii?Q?ILxNdggP4qNEuQ7KVMjiK8sWn4UUbWJEK/Fsv8Xc307eAthkmR6gf9pTBOJ0?=
 =?us-ascii?Q?sYaX72Lf2QKRQDNFgwEzr9o3s5roAYPGcitdxWT1a8wH3r+DwXbBwKiGY3UH?=
 =?us-ascii?Q?1YXM5c24QGxYjvIbyszvdY5zYgl7T0HBsIzph40HKOd20Q+3Eie4fvtsZT9y?=
 =?us-ascii?Q?YjTqursHYLpBKjEsqkvxswq1Jn5lz0bMo9GykJauFxxCDXV0ERv65qOH0dzp?=
 =?us-ascii?Q?RNRtk/QJ7jXO8wxKkjMj6Xta1noK9o6t4gwWB34xx2PskkCQaoQgFFCthZYN?=
 =?us-ascii?Q?N3dudm5oFZh0+Ss6eJY6h2Sck/nr5Pt9q+LxNrb+NFdXXR65u15lNKaPsGkT?=
 =?us-ascii?Q?0HBXYjc0rr/Mn3rV3MM8YGyeU+kFmKL12QVFThbKcaaNuIt3HLBWnMUsCXNM?=
 =?us-ascii?Q?YoPzmdlWiKjpNxUyrlb0fK8uEx3e/LTxvpkTikrfOS4F8W1p8OHrZ+9VBIij?=
 =?us-ascii?Q?G5qPDhMiT1nYptJ3ltz91oAc3zZBXrSoNk/EfGx1o/8IEZopgVTWrLgIxoj9?=
 =?us-ascii?Q?mfqIjUgR/hnp74ska7EwVTpnYy2qJUCFFK++srqkgLYcYNcdEhzwGpqsKn8W?=
 =?us-ascii?Q?7/zpnftg/Cb9TQAnbP3m5Csn1RoIdZdFst2eVxobaFzC3GJB4xHBUdGH4GcI?=
 =?us-ascii?Q?dRSTL2dzNHoKSNGGEvZuT2p+vWNJA1jbxnpZNr7bSjP4wNykEz04SM6o3Zfv?=
 =?us-ascii?Q?2Kaz2A6trgs/z3mKwpQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0799fee7-609e-427f-28a1-08db50921e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 13:34:30.9877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sM4qoeAfxEtzLf9MczlRrmJFYjKkmrN/O9AESXB1RN5fw9WxV4aSxXlam6eu7FWiO4fnMFbdkdMlTYfwFizjEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Monday, May 8, 2023 9:28 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;
> Pan, Xinhui <Xinhui.Pan@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: disable sdma ecc irq only when sdma RAS is
> enabled in suspend
>=20
> sdma_v4_0_ip is shared on a few asics, but in sdma_v4_0_hw_fini, driver
> unconditionally disables ecc_irq which is only enabled on those asics ena=
bling
> sdma ecc. This will introduce a warning in suspend cycle on those chips w=
ith
> sdma ip v4.0, while without sdma ecc. So this patch correct this.
>=20
> [ 7283.166354] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu] [
> 7283.167001] RSP: 0018:ffff9a5fc3967d08 EFLAGS: 00010246 [ 7283.167019]
> RAX: ffff98d88afd3770 RBX: 0000000000000001 RCX: 0000000000000000 [
> 7283.167023] RDX: 0000000000000000 RSI: ffff98d89da30390 RDI:
> ffff98d89da20000 [ 7283.167025] RBP: ffff98d89da20000 R08:
> 0000000000036838 R09: 0000000000000006 [ 7283.167028] R10:
> ffffd5764243c008 R11: 0000000000000000 R12: ffff98d89da30390 [
> 7283.167030] R13: ffff98d89da38978 R14: ffffffff999ae15a R15:
> ffff98d880130105 [ 7283.167032] FS:  0000000000000000(0000)
> GS:ffff98d996f00000(0000) knlGS:0000000000000000 [ 7283.167036] CS:  0010
> DS: 0000 ES: 0000 CR0: 0000000080050033 [ 7283.167039] CR2:
> 00000000f7a9d178 CR3: 00000001c42ea000 CR4: 00000000003506e0 [
> 7283.167041] Call Trace:
> [ 7283.167046]  <TASK>
> [ 7283.167048]  sdma_v4_0_hw_fini+0x38/0xa0 [amdgpu] [ 7283.167704]
> amdgpu_device_ip_suspend_phase2+0x101/0x1a0 [amdgpu] [ 7283.168296]
> amdgpu_device_suspend+0x103/0x180 [amdgpu] [ 7283.168875]
> amdgpu_pmops_freeze+0x21/0x60 [amdgpu] [ 7283.169464]
> pci_pm_freeze+0x54/0xc0
>=20
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2522
>=20
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index b5affba22156..8b8ddf050266 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1903,9 +1903,11 @@ static int sdma_v4_0_hw_fini(void *handle)
>  		return 0;
>  	}
>=20
> -	for (i =3D 0; i < adev->sdma.num_instances; i++) {
> -		amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
> -			       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
> +	if (amdgpu_ras_is_supported(adev,
> AMDGPU_RAS_BLOCK__SDMA)) {
> +		for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +			amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
> +				       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
> +		}
>  	}
>=20
>  	sdma_v4_0_ctx_switch_enable(adev, false);
> --
> 2.25.1
