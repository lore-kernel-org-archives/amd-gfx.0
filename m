Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3C0C25B47
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 10:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75EB610E061;
	Fri, 27 Oct 2023 10:43:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D4010E061
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 10:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aE84HAWUqyjlX7ZZZjoI5JtXCKePAZZ83/NId9I96gSIA61XEfheIbIxobhbjqt305kwrUOPmBRzQBO7nNQz8ZTtiQF/MApXBtwSyQMIoo236pev0HgTo/xBVckMw0Y4AwuJhUo3ewh7uJcs9sq7qlP7Rezw1JzcA1fF6q9B0Rw7tgvgvT4OgRYE7d+JhyiEDo8+1gqwNUOcxuJqZKgszxT/ONarRMqQeErk9m7yPvWt5UPoKxohxixVR+3NtDMLac7ajmiG3ufaXjVYciFbsWys/utVe4K8pmcIRudtzt8GDwMxHxxtgb2uJw4Rir6OO93iaGcja9s0WSpr5mBqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCyEjGxOwpfrcUXaQc2yOdvZsByIAh4WpAVx4PzsldA=;
 b=WXwzJtGZ8ESulOc/Ad9kdgx6OTVAmX64pxbyavMy5MeNcFwbnBnTRF0MneRU6LfihbK01hlps7kCHVCtMn7+Sc4BMdch/9b6qV9iT1lISySaB95h/1cJXjM7SVq97CfE/964Zglf6+X6y3U5vJNURLYl7Gsn2hP4+0RDg8Xq5M2ckTi8mPtitf9ICwCZdIfW3I+orFNShJ7mow1liWCp/QTUtYcc8uFOlyMlmc5SSURpSOZG8/uJHUH+fb0bbhVKZ7gz+y/EHPRYchseYc8jyweIs/j9uqN6+dyNomCbnC9P2llrjl4a74EX4r7XJXsQzb4D2X0UcFOQyTTz0s1oEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCyEjGxOwpfrcUXaQc2yOdvZsByIAh4WpAVx4PzsldA=;
 b=mTvKo1k4ux0o3FnX+LClcy2IJMCq1b5baN9sfmfrUvbtrd1ljhkO7Mb7yN0UpfZ9mu+TCLIA27Rzj0oJFnnadprhk8xuN+KtBTgigCU8cyHT9mRNyRF3ZKunVA0H5QvSmsjcT+gwFxvyuxOC0g2ZIh6sFDKM0dxZbOoHyEv2a1w=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 10:43:16 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%6]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 10:43:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Drop deferred error in uncorrectable error
 check
Thread-Topic: [PATCH] drm/amdgpu: Drop deferred error in uncorrectable error
 check
Thread-Index: AQHaCMCTiDU3FxBNAUOpCUX3cDK08bBdcyvg
Date: Fri, 27 Oct 2023 10:43:16 +0000
Message-ID: <BN9PR12MB52579972F48D7B8D43437C8DFCDCA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231027102943.1247582-1-candice.li@amd.com>
In-Reply-To: <20231027102943.1247582-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3a715060-79f5-4987-8f5f-2be717e22efd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-27T10:42:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN2PR12MB4095:EE_
x-ms-office365-filtering-correlation-id: 6b09b143-dee8-4123-e954-08dbd6d986e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pAFhvfd4m7tH/UjnPOuTB3V8E7nC6EEMMtHprxEAgImAcfUujZIFnPWL8uVBcDY87LqEuXGDIfALWei+YguoXkzZ37grK784R9hwqEab3E5k/eNbHmxQZvq1zlE2sWrFSjmQvZwBtPD/M5NiLByz4nQvLbZSPpoCPOiWBnVYeSY6R8KFInEpOCxHrSkpR3TlT/4TQ98gCElaTEUaWidGg2rjNgQfX4BtDy3VYZr4wW5LyldCFzDup0hpo3+v+W6CheWDPmZ3/pMZ1MMv5rDrdgTx6muIfSQbf94rip4DGoObUNq0EJGNMB1XDEqIdwztkoKYnMTJiFNt3Lul9OJD6KtcnhBBPe6HgCHgaAz8a0elISi3lv6+JVHzjrW3b9nbDRPpV0a9HW1PCfyLOUzC5VfjwsFdtK/ZisptSYpovdEHpv2qv9PxJ+BpNDgMQGx+IYlkBznDTlodFnrj9biLdAT7C87ZBIoZ0aLd8rDlQtQcMYPN+ChxfI6gwctFMiWgj3KfNZgpJU4TnBvqr/gFIhJnaPWd8mqZlJZZ2hei1gk1EE1KPSE7t3ElcPWoJfbYRKDUbRxrB1sTFcVxeqFVo+Wh0bfOyUfNcwRX7g2Kt2kEgwQsIwlJaTyBFhJV3f3L
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(110136005)(76116006)(9686003)(7696005)(478600001)(6506007)(41300700001)(5660300002)(33656002)(2906002)(38070700009)(52536014)(86362001)(53546011)(316002)(64756008)(66556008)(66446008)(8936002)(4326008)(8676002)(38100700002)(122000001)(66946007)(66476007)(83380400001)(71200400001)(26005)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O/jn9BwCrQffIJGhm1D0u4/FKetwGdMYFeNoWqHoZzZ7uSrrx7SoXP9LiFdw?=
 =?us-ascii?Q?5aNoKHWViONbvvKZFvzMXY9VdsrlU+ddGweifo5Qq9pktpKhmxbHP78SlBcY?=
 =?us-ascii?Q?btXiGZebpjfKKu1ienErVZuEb06vklJFRQWNByfbE0ggkTx53CbsQn5w4Cd7?=
 =?us-ascii?Q?l3f4r1slR82JvWqKw4jvbVPRojfDdS4rVMJQzKVzZ5mIes6h+uLeozIy86bg?=
 =?us-ascii?Q?G1ts7d8tzElX1PPojeYEvqi/6mhVOjIVwDAghMvWoRf1HU0hA+0XGkDBNfha?=
 =?us-ascii?Q?tpgkZ4l/wuvh5nK0ndMNwPW0H+38xHxKOPU8W7zj9cA695SA4UTZ4fSsLxim?=
 =?us-ascii?Q?LPl0fzGWOsjCaxXHHnVmIPn60STDNdQc3GR2LjhLpki+5ncZ2mDW8W/xxiq1?=
 =?us-ascii?Q?/8Jsmo9kULXUYtXOhNFD134B9cXxQuN2K6xyum2qt28GJsLB05Cz5VbY4Of+?=
 =?us-ascii?Q?uJ3O45w8FfOiTevHaWUU/Ad4EyKFLRDM5YsACm8xjiHChapDZGT4TAl3G/gL?=
 =?us-ascii?Q?+B4E3DnKyk9GX3HxnYO4OATh8PMGTjLg5TSLSxo0OXNYEpA2dJbY8n3vHQ9F?=
 =?us-ascii?Q?tpsjaGilx1V0SZxnyFQPA3B+8VKa3OlG6xLFDfaIhs/sO8ttSMHudw7zo9pp?=
 =?us-ascii?Q?tZ+zpOc6PryS8VO9Wr3ilfsOJtj1tfK4K/Ks+A2fiwNok+NI/IKnFJSr1dSP?=
 =?us-ascii?Q?42vC2Q0ermhoJUTvEKbE6HlLj1MEe23ewBwHKbVEp7uFJ4QvsSZA9Lg/fECt?=
 =?us-ascii?Q?a791kdd7xkJBkESv6vaQ++rrTD0EaDDWPL8p4dMlArHIZOCwWzsrFZ0C89oT?=
 =?us-ascii?Q?WQsxieU9rH+77nQLJgCoLdt6KA6CX/bvVwbFPec16dBFZdKFnJDHkgKc6eDo?=
 =?us-ascii?Q?ws95u/k1E0SuiVMD1PiQ5XIUI9hEns8EGgmxr6gyovPgEpI+ZPa8KAHCK50w?=
 =?us-ascii?Q?KjPdD1Q/uwOfVccnOdjEjMVUurTOxwyJL6jSFARVfXwmqMNFqm0SqeLsRnZ+?=
 =?us-ascii?Q?flauMmzcChcfP7qOvIv3x9pXpTzDo1sBPP0WyMoM5gy96kGG7NrPTITGAfyL?=
 =?us-ascii?Q?btssxqEU0a9EajocxHqBCfIxU11GISEiABtH2gE0QZ/Pws8NNFwxBSoqplvH?=
 =?us-ascii?Q?KoyBR1SCpzyzNBx5scXtO1hd9JT4J2RtCgvK4s//l21JZlE1J7PqzSPEzfdv?=
 =?us-ascii?Q?jpz/PFTuZLxwnjAEnnYr4BcP/CvnKV4qTLLOSKnYi6/YA1POXI+oMrKovBFV?=
 =?us-ascii?Q?eN6NIDlDT1P2vxc+Z3HCl3o0Llq/RoONFDy1+mHz5ghSnDksqQTzk+TckyIQ?=
 =?us-ascii?Q?vqUpYnu+SYqXeku5NAEXBwAlHuFSxReiiDV1mWfEGI421lhrAgso+r05TR+n?=
 =?us-ascii?Q?6BgnnXmMgST0+9MjyGQlooWpeZAHZT864m5LKF/DFchyFSc926oDWHoD2Br4?=
 =?us-ascii?Q?VQ1THuNV+xfb4UtZEFJ/isjyD0qbpthf6c7TBpwUkb1KAX3qkUFgZUZYvBER?=
 =?us-ascii?Q?zySYfYHgkOtv4X9O23XS8tZd3K9O/jqIEOzQEES9ezmzZnJ7wgFz2i1ujrlz?=
 =?us-ascii?Q?EUYYiUQ8sCtqzTQaY1kC/AE/EqVfSasB05tsl288?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b09b143-dee8-4123-e954-08dbd6d986e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 10:43:16.2392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDwzWWbFCBpdEbir4tG5tFPQtvLZW4m6k9MvdgUVB406vjwFzkj3DwNY4483g0cs/T3DEyTTBHUcsAlYy4QM+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Friday, October 27, 2023 18:30
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Drop deferred error in uncorrectable error che=
ck

Drop checking deferred error which can be handled by poison consumption.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 743d2f68b09020..770b4b4e313838 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -91,8 +91,7 @@ static void umc_v12_0_reset_error_count(struct amdgpu_dev=
ice *adev)  static bool umc_v12_0_is_uncorrectable_error(uint64_t mc_umc_st=
atus)  {
        return ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
Val) =3D=3D 1) &&
-               (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
Deferred) =3D=3D 1 ||
-               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, P=
CC) =3D=3D 1 ||
+               (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
PCC) =3D=3D 1
+||
                REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, U=
C) =3D=3D 1 ||
                REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, T=
CC) =3D=3D 1));  }
--
2.25.1

