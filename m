Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D7DC30633
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 15:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B2C89B57;
	Thu, 17 Aug 2023 15:03:02 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC5689B57
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 15:03:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp8KusPb8/GKm/InbnbT8on0FwF/H8m7AzqBAIftp8xNjgzZnAE7A6egA993ikHWxqSgbTCX+f1gpUDQDfkmjd3d+dvjlPYNdby/JA5D89bhyhZgZE7U9vUKFnNUyrAviJ6ACz5RLJVq390PRTYwT282rDgXPnc5oj2nFolYdbO08ta1RhgSWlPMT+SqhNyxngd6e0uoxNkRDAOzLl5DSQCNsQzYFxURtXDl+Yf6pr+vgaXCh4qB3hfv8rZk5JyVl+DpVmF7xyfUE8qLJ5T2OB4rNHs3SN6CTCqT5QfjwAW2ntTiLDDOAFGH5V4gBN+YDnTUL/rHh9/LHpG3xKNKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzUC23yRNjmpY/Ppdh27wyTTGPQkimmZN5GbEPwUn84=;
 b=Pq3Bamm9toCrNpsmI5mMTNMaylAHRbNpCQ8t0SJomPFyBkt/ROSwi4Y2w5baGhfnvLVpU9Dtqf+DNxoOJ5z3kvRI8FJpga7p6A3Md4sfLPu25wuK2UGHcrAE42CdJlIqAwgc6ma4ujy30+jAS/syOtkyfn2lfz4zVQqJSs6olJTF+e6U/qZeNuEbENOxzdosGxEN/lERHpUwVr5nb2F6a+8Yi67aHuOIWE7btj9C6jQjsxc8MVyQigkGsgBfN9fNI32lCE1my3fjNaIFFZV8xPRBywm3MSXuZ6E9NadgtpsarZdGof71XIdVhdL/OReiuXRRZkNRghf7NK+Xn2zWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzUC23yRNjmpY/Ppdh27wyTTGPQkimmZN5GbEPwUn84=;
 b=SWQBa61BtlDAE+zqem3olVlnn+QeGtlSjkI46W0pA6cnCUq7nV/ceoa3v040xU98wNvJ1l/aDiuDzg8S8eexxJieAvLk/o8NByLH8p4NDY5QUjAaqO6KQ4cSKNrNCNfLdH7Iz4HyKdv7TJJO22yTE1UAaCkBNVA0njtzFxKwKlM=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 15:02:58 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::241f:5214:7bd:79af]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::241f:5214:7bd:79af%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 15:02:58 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Dhume, Samir" <Samir.Dhume@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/jpeg - skip change of power-gating state for
 sriov
Thread-Topic: [PATCH] drm/amdgpu/jpeg - skip change of power-gating state for
 sriov
Thread-Index: AQHZ0KkDOR0KWHhfKE2rhxejnc/DoK/ulkow
Date: Thu, 17 Aug 2023 15:02:58 +0000
Message-ID: <BL1PR12MB5317D8779CD70004486C2C1AF11AA@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20230817011957.639883-1-samir.dhume@amd.com>
In-Reply-To: <20230817011957.639883-1-samir.dhume@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=53917471-fe3b-43b9-8aee-890108a2cb03;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-17T15:02:14Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5317:EE_|CYYPR12MB9015:EE_
x-ms-office365-filtering-correlation-id: 75f4c896-00e0-40f5-eb23-08db9f330b37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jAe6jUbg/6WP5O+DFIf85NFo7H0eVoKncQi7+1p7oGtE+nvPomKrxHuZo1qXPu+dHVPyBkIHw1aQLGG6RU4JFNGA9sbdYiuuxRMzhr3T6XkKmmW7Mv56EnNKdkGhwAzNV9PSGee1+ZGsd6YntVt6R6LGdCy1fAfi3qHVIfyQjqAoo44nddlkZ8U+C4t1pESp3bcCI2XtgvWsQOc2wHMIlMbxIYNB1S0uZ5j+HTBDsABpm0B7ipAkDdZWzAsHezUa2k/FyQWlUpyQng1F6nFfkKAtsqt4IZd3EoMmaoWbVYJMlDkEFNf9vFCxY7o9fm+6Iz9P7+K1Q3FwsMWtGs4Fj4ts8expp6LWDh7DtO0+FS9Kkjc759Eaeak5oC2zYEmsxWg8K06vpVeg2vkE2jEV9U4aFw2LKBEh3pthuoVzN0AqvTY5loko1h1kbUrdJqIYXZQBLV0SB6bi2t8qmI353idXL1AFXl7i5sHt7Pv1x/d74WU0Q8Wt+922SIuYT5HoI7UgZ4d9w+77lfs/pJQ25p8q+3n9zycIDZj0wl2tYRFo5OIHfpfURmkACts+87bDqEu9gc1XAJMz3h69/sJM0lgF4LBPMD1rWGeblSL2vIcjj7vetwDRUlRBq4wwrjcN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(7696005)(71200400001)(33656002)(9686003)(53546011)(55016003)(5660300002)(52536014)(41300700001)(66446008)(122000001)(316002)(54906003)(66946007)(66476007)(76116006)(64756008)(66556008)(110136005)(4326008)(8676002)(8936002)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RIgPKvb1Vt8IsCmS1bZ2FjXHollyj0OgYlTueDe6GqbxHZwJ1iXi7vpToziv?=
 =?us-ascii?Q?aL1F+YQ38ezbakUgYSOjptqY4sKQi3NR5Vf12rn2ZeO3DIv9IfuIFEe0IqiA?=
 =?us-ascii?Q?pJm0KGKo+hKuMOo4l4yaI52HVjipFTw/ql4xasmqgDUw8BqFh1b8GhCjVPud?=
 =?us-ascii?Q?MSA9jTEugCMdf1oacWAYRnLfsg2M6ZbHmW4/GHP2VOgpNrERRcwNGqYzSmh7?=
 =?us-ascii?Q?6PNPSq0V32+9shYyXyrvYsLODMH7uqX+GuSd+ipLZvMXh1hb14Y0M+E4by04?=
 =?us-ascii?Q?zAd/s9Dptsw+2YHents2XmUH2gOFv5G/b7EfqzSWdKc5aqnG6x/tCsGHvf3/?=
 =?us-ascii?Q?FmPKTtE+2AelyI7skjdUVGj174eazx1v9VPNhTWkgJ+9OXgiGM+CeGuTajiF?=
 =?us-ascii?Q?XZsBFGpmy+UsEmQhJgkewAvuBrk/Zfy2aB+iN7KRuQnG/zEm56UWUQxvs1aB?=
 =?us-ascii?Q?ZZgxnWzV1NTi7BgnQvXUks6Wplh0SK0rW/cGNbf0HW+Vs9iEv5YCKMhOL8Iq?=
 =?us-ascii?Q?8G92BoSCromujPqDaaQTLJZGLBrTEBwOVpulxZIrrWznrngzc7J9EWhIwd2e?=
 =?us-ascii?Q?umw9xqdLm3KD6e1GoJzSex1+BvtdLPeQ2r9ZxpG5Nk0Lyprz4srTlNW1M8mE?=
 =?us-ascii?Q?Uc/RiFJWV7GlrXlCMsCL+vz+qyNRkmMNGDtxQnczmvbqH76338EyMFVldOES?=
 =?us-ascii?Q?n+SAp5/gNtAGpw87nU2sTPh9629VX3b6M7TcY9B2nYs2FC3Oc/yMzNamSQCp?=
 =?us-ascii?Q?kKpSeGagXSeE7RxfPjU/LLEv/YN+dzdWtU6/btVbXA+H4lDPPSXkVV+3MWcG?=
 =?us-ascii?Q?tUNcIn2An3Hxa0+I72ZTYgiDj6mQF0ZT+U/jWdp0kNLDqmi+7rw+lMnLRgcB?=
 =?us-ascii?Q?1i9shET9cApHrxI+WvpEAKif/4z/DEUiDM4TrFh32PdYaoz3OcOeWrhAZ8Sb?=
 =?us-ascii?Q?bmMI8wJ29ZAI6NiihffOxeJ0ujWKxQH/sHe1CBiaJI4WcvJdFDsKOjRkjWHY?=
 =?us-ascii?Q?2QYL127nn8VPDbrUHoE3IY4fH9jm8Irpd26hXpn8N4ZHNzSEn0Ypy5gUcYeK?=
 =?us-ascii?Q?aofsGsYmA7717UYeZSvWldFT0H1sexlK7j4m87UeNoimt1Z85T/Cy4EV2ISc?=
 =?us-ascii?Q?iALPppXNBV+1HyjuBm/zGoAJctebp8/rlMNprixdk4dLAzGEr1faGUA6viEz?=
 =?us-ascii?Q?Eapsj3Rd7gwXFBKN+WOPeYWcijCJ6keXDQXWsvw+ciL+1ZV72p4vp7Mpi+Ev?=
 =?us-ascii?Q?K7IQqRFYq3KGDmnKARsk4I5Glp9Ot66Ck836Uv9IrXAa48gOUqhrFEp7apus?=
 =?us-ascii?Q?pJJvbBx83VfeLoOqRjZWzcRBqKzoojNCxeE3mVpFPP3t+TmZJl1N2s02bxs+?=
 =?us-ascii?Q?zGfN09Rjrq8DMovHKn2BkcuImBskoK8m0la5O1jFiq9yUIR7uYmxlIDKEAG9?=
 =?us-ascii?Q?4maRX2Sc/DdXNCdCITJdlRpRgxAL3JX/6L8ddeFiTW+c7p0xX5iNdNgihexr?=
 =?us-ascii?Q?NAODV9qCF6DTbRH4CreOKrR8RWitfmpu5Yy8T2ImJb1hICOekTailOn1FNib?=
 =?us-ascii?Q?Fs+bprsAH2rf5T1Hycs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f4c896-00e0-40f5-eb23-08db9f330b37
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 15:02:58.3040 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ZSbjb8Sxr8RW1k614v2ybuls1UL1ePwhgMheM+mH3sGLIzpsXWUBSLmdEPkSJwa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Zhigang Luo <zhigang.luo@amd.com>

-----Original Message-----
From: Dhume, Samir <Samir.Dhume@amd.com>
Sent: Wednesday, August 16, 2023 9:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Deucher=
, Alexander <Alexander.Deucher@amd.com>; Dhume, Samir <Samir.Dhume@amd.com>
Subject: [PATCH] drm/amdgpu/jpeg - skip change of power-gating state for sr=
iov

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0_3.c
index 15612915bb6c..1de79d660285 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -360,8 +360,10 @@ static int jpeg_v4_0_3_hw_fini(void *handle)

        cancel_delayed_work_sync(&adev->jpeg.idle_work);

-       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE)
-               ret =3D jpeg_v4_0_3_set_powergating_state(adev, AMD_PG_STAT=
E_GATE);
+       if (!amdgpu_sriov_vf(adev)) {
+               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE)
+                       ret =3D jpeg_v4_0_3_set_powergating_state(adev, AMD=
_PG_STATE_GATE);
+       }

        return ret;
 }
--
2.34.1

