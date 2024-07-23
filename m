Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5387DC3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jul 2024 08:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FDAD10E4B5;
	Tue, 23 Jul 2024 08:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0WkYyRL5";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6407E10E50B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jul 2024 08:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfeXSGqJNAc206J1nKXhfQpXm7a/KG/AGNGDBfmeMf9sr1/l7KvzAQyIQvFPQl4W5XO3jLNucRCcufwFbpJ4//1036pJka57QlSDPea0MMfhSq06APVGxGLBAuDe9uY4/8VA4gMF9IvnRDaX3MJUAhRfAbSbflKtzeyaHhTFALd+MnZpNjfmtp5UNnmCLbfE8Ao8L8y3D08Ky7QXBXUHjm8WdBpLAvR54pjw7Eo1OFUwiIQyHpaNVmOmwfX4e01YraVNAeNB/DuAm4lSNlG9bD7CONWkWVUyhTrN7bEqesTD26x+Z8OeG5HJPgaJ3m3TPbEuECa7kOgPvDMSDO6HJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4GhKYfz9rgt3dle64iStJ6//Fmu0fx0Dfq36ih3t2w=;
 b=XcXVVNCb/uBE5FHo+UzVkq8cGHFknP+6riLIQ+DwhVhFeUmxdaMnw1BJgUxX2nIzMtSLyGt53qk/kY0Zl/dYPaFarPLmN8t/jPWMFCm7dBTPf+Q4++Uu9ISJ4Awbm+NeRU8GfLm6EiPlV3zLyr40E/BcdKTWEFHsP5yPtw/FB73ybnIKAkqhCWMoJj8Ub7jZHvQb+Kqo0q2pjh7/fNjCxSqtmIE+9tNZJLiuPRGBG3QyPUZq4TRPzs8o20wLPdA0eIpHX46tLZ2Q0veixIeYTC4XXr1trW5B1yQELEoNN0+K55xzNEA/JKyaPY7r6dfO/jaQhPlpopDIxmQ4J2UMWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4GhKYfz9rgt3dle64iStJ6//Fmu0fx0Dfq36ih3t2w=;
 b=0WkYyRL5uGh7GYrHC/301hBDiJIxMsSES1OCFN3SK7G/V4I+yyXLLaYuXWo/k5voYOd/S7NQOUYRMSYpob6lhS01jo9ezbwqd5GxWzHZlxfVRLrgT+S8Eb60cSM/oWxH8FOgCbaNPTsEsOG5prlhelpPsizTRIYqxQ+Qj4RulWg=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SA3PR12MB7903.namprd12.prod.outlook.com (2603:10b6:806:307::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 23 Jul
 2024 08:51:16 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%3]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 08:51:16 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip kfd init if GFX is not ready.
Thread-Topic: [PATCH] drm/amdgpu: skip kfd init if GFX is not ready.
Thread-Index: AQHa296Uho2loJRoCE2cTLzZ09D+I7IEAgcQ
Date: Tue, 23 Jul 2024 08:51:15 +0000
Message-ID: <DM4PR12MB51522B62B90D73D0D9470697E3A92@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240722022509.620547-1-yifan1.zhang@amd.com>
In-Reply-To: <20240722022509.620547-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a6033675-49a3-4bcf-8928-84e667383db2;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-23T08:47:00Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SA3PR12MB7903:EE_
x-ms-office365-filtering-correlation-id: d5edd6d2-3291-490f-8a16-08dcaaf49cdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?suUkF8tgdsmmNLXxmiI0A3jfXJaYmH5+lV6MfeO7s7U5XarZB1ir1CA0Giaz?=
 =?us-ascii?Q?TpW55tjfNJmKiNG6mc2ombxAq8LTrnRn8/nc/3Caxlg3a7XU+tVpolGYnP2E?=
 =?us-ascii?Q?cpCeM2BkWnfDblYlt64KJPAH8t3OZsmcYfl9tFbs636BsOQyGSLSEiJZI8sK?=
 =?us-ascii?Q?p5kdatoSWLnBFVRzWAirdf9QfBt5q0oBdSYMRBTRSmWlLQge+05X/Ivx9v47?=
 =?us-ascii?Q?zedtLkmnQ7wsZXrAZwn9vDv6zbwpka+K2djfZMZnDfR1kYbAoQ3o1MnAbi0Y?=
 =?us-ascii?Q?8rBMdeMBKQ70XH59/hp49AWYFYRzxZLSUybl/aJ+dnoFYP3WgicscxG49HAj?=
 =?us-ascii?Q?hd6qhbYMVvatIR+mFq2k9J1Xvn0F3fVwJdyz6LquGi7fdgioibLBfjwmdpDQ?=
 =?us-ascii?Q?bZOd5U2vpqZnQ0iQOgmkqIvvz0zmLDhrXbPYpQXZJWtCPJ3V7aINxA3v74VA?=
 =?us-ascii?Q?df38GkGEcvOcLCiXOwK6WEH1JPqkYKP/vgD+H61VwYO6W3UGX4yuPXh222lf?=
 =?us-ascii?Q?On4HelZgujQZowGxD5BX84YgNC81aslBJZKIFMsr6hieoDDG8+jaYvJsJRgS?=
 =?us-ascii?Q?wxLfnc4QbNBKKrtGCbZcJh2h4TrYfnKtVRJlph2OKiwXCwkPIE7w56TdBLSv?=
 =?us-ascii?Q?cczd1CnIg855XOlkWFA2g2JBXf+Dnm4t77oMHJTa8gYVnSipb5xqUxXSIlhZ?=
 =?us-ascii?Q?3pLxRchIz76lSwASLvnQ1JAjYkze4uwUdZR1nAiyJ7VokssoL1zG7ZrWciWo?=
 =?us-ascii?Q?2tVeZU9gBG9b3ToJKiovMwP6MSE7f4SGzUiULC7Je+K2UtSQSRNQaN3H/QDT?=
 =?us-ascii?Q?3XTOOFTdhOIzSP5oGneJpn+M8BxdwZZmR/+YqB2skLYKw+haPrihe39k6fm6?=
 =?us-ascii?Q?NFiZAmJfjo6SzoN9TT3j4aKPgFuk/k1c9yGKkFaQMiclF0/lteVmQu8ZhcOx?=
 =?us-ascii?Q?Olpp2yYT03Q3tVJqfWH1CIB2Zphtdt7zSbiLKTb2rl2hVTYOr3uXOB5otsEo?=
 =?us-ascii?Q?q2C50OSzZCNF+iPfk0/lcj4J0yxD5TBZ3OdNwtsbfA9kB4cs4DSi6UZ0fAWV?=
 =?us-ascii?Q?xA/+c64pqWP8d8MyuIVpUWaef5m0erpFmHr5FkagSAnqVHiCDtPfriMvKJVm?=
 =?us-ascii?Q?fKqT0gnWCwGsQ5Ry4WKdIJgAdTanDLNve2XXQMD/Ndf3pM1YmVFqR1prqbBa?=
 =?us-ascii?Q?AQRnn+1ui98vZfhxh1JCJ4meOSJcqG6Y+bWtSTMKXiF/T1NQS59uggSmAz3n?=
 =?us-ascii?Q?AXvAnYZekGlZYuKglVViAwRymRsRHtUJPzgHfiq2w8e28ca/w/c10qcv8WEl?=
 =?us-ascii?Q?yKogDAFmf5uGUIBvIOLwHlT+COnx/AhKkCK/jdW768zuFprxkownR+QaA+dq?=
 =?us-ascii?Q?geIdecSZB8flel4im6j15miCL7QmZwzL6kKf8FvUtQnfoDgiLA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sgVA65kPOXhw7VwCVxROWvKaM3b+LT+7VLtiUndH8PXHvxKDcsBC50gExUjp?=
 =?us-ascii?Q?/D0fZqBCKgntbnzCEz3QMhRbUQZamtBjA3GMaSKib4/9uGkjawOyTXkSYnxj?=
 =?us-ascii?Q?uU62XzEwAsc23wZvVvyer2Sh2sFJyDQdtm8cCXZCs7pGnwhzBR7e4mYo2nt4?=
 =?us-ascii?Q?d84OmC9Bf3wuKJgR4XEFz9dvAKBim8wzwJkcz8aPLmSouoMp4plkNAop/UlA?=
 =?us-ascii?Q?dOCrVGkKUjOsbnVUQe4DC8pKB8OIvviOXK+yDRu/R1LviM1NP9nU1E2EWqvE?=
 =?us-ascii?Q?f7fV7b/1ZZ7+FBjiFOA8kkE1AXEfp7cJOIaAMHKeBAkh6rcluRDmKhDj24vK?=
 =?us-ascii?Q?iGH14uLOk/h6e4zL25jD3k1P36EBOlGIkqOJR4vF+z81ieSoG+eCtSj4VC4/?=
 =?us-ascii?Q?zJekiv0tXJjxkvtLhY+NiiFd75T1NbXX5L0pH516sXSMzSY7X5uG2vizXAqs?=
 =?us-ascii?Q?J7g+CBqH0ltWnTg9ywaPFk3VRgmYECD4OsPQnh5PELYh3bXGycRVOXBPsco0?=
 =?us-ascii?Q?tSo3Q4bQPnQEz8/OTfr1NOM7U1RIBXdsnMBXYovNJVgQU68FU0PGg+u8t650?=
 =?us-ascii?Q?tqT0RHEsHaNfahv9GwVYdqBHWjFaA6IH96dypnrx/C0fdC/NXIowJJBTpqgs?=
 =?us-ascii?Q?omDQ0Tdd0pON2xe3IUeDLJcoHAxv+Eb0KlTJwZFOxi/4R+jt935ZftSZgPQ1?=
 =?us-ascii?Q?5JVmExmOEgdpWXJMrPILCeum+C4rcyhUVaH3iL7SbVaaApv2EYSkM7H5G8zo?=
 =?us-ascii?Q?16mq/EU4xZuk/ToAiAXvY+DFrbM3LNUmd/flWy/dI4jlma3ZuEnEYrw4c1XH?=
 =?us-ascii?Q?s4+4Ycf3+sOHYTx5PZJgQ5O1JVkC47TzBUjzb8uqHe5jKssvxEWnsmfpZLtM?=
 =?us-ascii?Q?Oq8TxyiQ/wLp4t3Av6i9tvjDbNI0bC1mJz1y42WTHSHTOsz5t4wSALV9DPRv?=
 =?us-ascii?Q?Af0LK/O5RbhAiuvAMcatnJG/YUYlnsJDKxKxHhZCTstzPFIBsXZDeLxGeiLx?=
 =?us-ascii?Q?aR1XtrnxpHZgz0n2dmBsQd9w31Vmq2ZCWIu3cMC+dJPcQWcijtKC5v72+vWB?=
 =?us-ascii?Q?NhgfaUfJr50qcGIltxAgg/aLP4CbTvPvSc91WbJT6V9Ft0FXDGWbRNBO5G0H?=
 =?us-ascii?Q?hPAMYyBGjb2ucYfaR2IHs+ZGSHkPBqaGSd5XklySsBFrmPnC8O9j+ldo3lEy?=
 =?us-ascii?Q?uPAF5LlDFyGJQn4msFT4kQ/dsuoaGHMo7qbBMo01PBvBZcNOr9OpviZEPYQP?=
 =?us-ascii?Q?DgepZ38z0pDdzp4jnbyh6MLjgODZgttvlHIx6DtaDppoIPYXwjUZhKrtWROq?=
 =?us-ascii?Q?M/5gKYVg6R9GP2RrcGVmUQpROHIif/VcVnaIUuirdnxtCQ0Ydpbn/eYOYK4E?=
 =?us-ascii?Q?yWEXCfIA/UPAjZWQkGGOvBg60jbngT3t1zGDErCR8HRIcceVTbiI719Gs/y+?=
 =?us-ascii?Q?eMe+s2PyeHwz8dMYIQSzFpQimq9CvTDan036kQGPUrH0Fbv6BujkRHTIMJUU?=
 =?us-ascii?Q?cDIcbu9neqOyanKAzXBikvz9nFAfS/r3Ek6dDNfiMcxBTSP64yz/x8HgaQ1c?=
 =?us-ascii?Q?Rp+SE/QAqJlSEl6hfXQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5edd6d2-3291-490f-8a16-08dcaaf49cdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 08:51:15.9696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mstAI/Zk863ssfHxK3fZeL+BmCxO98KlodIO+aZW/IoNxn3nspZUp4AJ7XkAHHInPUMnhuy5ysRiKU7VOvsHXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7903
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

[AMD Official Use Only - AMD Internal Distribution Only]

This patch look good for me.
Tested-and-Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Monday, July 22, 2024 10:25 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>
Subject: [PATCH] drm/amdgpu: skip kfd init if GFX is not ready.

avoid kfd init crash in that case.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index bcacf2e35eba..730dae77570c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2471,6 +2471,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amd=
gpu_device *adev)
  */
 static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)  {
+       struct amdgpu_ip_block *ip_block;
        struct pci_dev *parent;
        int i, r;
        bool total;
@@ -2608,7 +2609,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu=
_device *adev)
        if (!total)
                return -ENODEV;

-       amdgpu_amdkfd_device_probe(adev);
+       ip_block =3D amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_=
GFX);
+       if (ip_block->status.valid !=3D false)
+               amdgpu_amdkfd_device_probe(adev);
+
        adev->cg_flags &=3D amdgpu_cg_mask;
        adev->pg_flags &=3D amdgpu_pg_mask;

--
2.37.3

