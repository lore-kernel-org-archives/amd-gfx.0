Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B411C6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Mar 2023 07:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801FF10E714;
	Tue, 14 Mar 2023 07:38:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A0F10E088
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Mar 2023 07:38:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Il/oUGURFL/jeFrvReU51FDNxEV3MaRlGEs62Paw7oWtnSkLBtzrmtv2SdVoowX5t6AfvfnPnUYZHpX5z09Grxn2HeAIKAEVMDmqvn+vIFtbpRKsz1n9+snHWYxgkyAMTRAyJOYWy0/VXGEsGn+OkhHN4ECErWBZLRTwgRJzt8okWpl9SBNFnJmNkrc+jxrK+aQobUDiTCfz3em+4Ly2nrIJA9nde8txZXAeUJ/7lMKDSAVegfGG4Bx2GLEGOHNYCMFx7dfECtkvUOolKA/cRld4wPK9UgJYzWWm9AFyouMKhUaWfpiNtGvs8Gdsmf94OZ3TT+NdwrQmpNk/HaFzcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9LR1q43pYlqWFpG0zdeGme044NrTxWL81ZBIRcXSmY=;
 b=HYc1czWHZk9n0flTGATaDf8KWz5q/RtfmTcUq6wfnyDDYuCMZ1ZQTNWSTD1chNolvrJ0HWgSQob8JXrkkYjjPV8dDOP81niOAup8MKGHvbcelidVn8CHzkKFnT7JNB7yqMg52l7VdhQbkKTrYtQpcY05IJDelnuus/X8r2SdlyN114GpfX3UM+rN+2pvsby/QZc9+mSQV+HoKrzDMGtjhB8K1eZ8SJd/4Aifj9PIz4hg144bTtI9/b3TOhYofH7fwCmAEoWwba87UlZNlF2sTCjeQVJ1K4iuFjJUJlvRIJwpct+VNwnd+z3vcR1h9I2m3l/mEpqZtp8SoJSyX4MAmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9LR1q43pYlqWFpG0zdeGme044NrTxWL81ZBIRcXSmY=;
 b=vYc46vdKpiEONe2loG/vzoxwoieU+0DoP0TzKapgM0ZTlZJZQtGN3H5/loA2HX1QsVLo/IivppWemoYb+O5sYzKfw0tVwGqtUU66VHM69GJ/gCKxL5juzdkXns3C2RsKvYxTCW1YU++sJA6Ii6sDTe8z4FV+EGxmxK4o3AQJM84=
Received: from BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 07:38:04 +0000
Received: from BL1PR12MB5061.namprd12.prod.outlook.com
 ([fe80::583:6b12:72a2:444f]) by BL1PR12MB5061.namprd12.prod.outlook.com
 ([fe80::583:6b12:72a2:444f%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 07:38:04 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Zha, YiFan(Even)" <Yifan.Zha@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Init MMVM_CONTEXTS_DISABLE in gmc11 golden
 setting under SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Init MMVM_CONTEXTS_DISABLE in gmc11 golden
 setting under SRIOV
Thread-Index: AQHZT/zZnV+DLUDfKEeLG+T03PX4rK7578PQ
Date: Tue, 14 Mar 2023 07:38:04 +0000
Message-ID: <BL1PR12MB50613144C3EC2CEA3D2B81DEE1BE9@BL1PR12MB5061.namprd12.prod.outlook.com>
References: <20230306072459.2334191-1-Yifan.Zha@amd.com>
In-Reply-To: <20230306072459.2334191-1-Yifan.Zha@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e330cf87-f323-4ff0-8943-0fbb7b12cb8f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-14T07:37:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5061:EE_|MN2PR12MB4237:EE_
x-ms-office365-filtering-correlation-id: b521e2bd-c409-438f-ae4d-08db245f0bd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JblrgwlNR4fRMc0TR17cWqGlhD3tshnwRwjwJQRii9iI8Q8tSfqPzQhsgmWzS+9LepLpdQcaB2hv+bGN7e30FDMb2S5hQ+md3OXVf7fq+B73++oq3Sg3Z7DdAkJrsmb2ddKT5yEwo+7BinlPKhR4YrF8L4AFeDnHnqGhgEDmyrdj+jpC/XTSxKnCxn86BYBFEJ0dXo3hB1dmrYrf6BdFUAvkq/pDl0vhUI3z4Wec603X7YezX1NcwDxulDCqdio5QJJNIU8yks5oKhNiVuqBRptk4T31ptmh7J5Fj1FkG+7jge+gUmkR+SaJ7/0gLTqhNisQkbbckEZvtu4SlB5J7lixGM2bl5fDQIwb4QY1kCvqYt8Hzod4y5utiMLoy9EGe8TmWhp1QRWUOUR3TMh/nTiroyrehhMfEccznZc8h2MbtGuMcLj3pLmYEKOIAHnHitvRe+KNakL/4R8XQe7acmXkkP5yzGTWeCR7eSL8Sj+MjlLiExvKCaNMzFClcbSK44rD+rcA56sxSSpEqwaPZ6mCRIpCqW6Mkveo5nVem7w3duMKkHQAiZ0xCt1i2gyMTf8RgrOfEbbPg3CZ1RUaYjcWG4/r0ibYQ2+FUqBfWUDrhG4axMEr9BIPJxqKKrDHokYMKC9/azBw/mvUeYYgO0F1bmsfJxHncrlhz8oa8UY8Cto5y8tOSIiXPu0i9oGgH8+2QSt9PwIGMrNIzsARuw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5061.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199018)(38070700005)(86362001)(33656002)(122000001)(38100700002)(2906002)(52536014)(8936002)(5660300002)(41300700001)(55016003)(4326008)(9686003)(186003)(26005)(6506007)(53546011)(83380400001)(54906003)(6636002)(316002)(110136005)(8676002)(64756008)(66946007)(66476007)(66446008)(66556008)(76116006)(478600001)(71200400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zgNKNzR8sBlCcda7XrspWXdICRqZEKG2VZ21JtVqH2NlhnzF61WzpWD/Fi19?=
 =?us-ascii?Q?gYqImS/6Jwop1/ltoGy+TaK5jmxwuipk2FX3gj97iiIMXcQ1pPFDfdrkkcMR?=
 =?us-ascii?Q?H07tvKpRC9iU4lH2HRBU7G7ePlTZjZVkFUDnh9JqB+XOrK6PpSi2m7wz3Sy1?=
 =?us-ascii?Q?aySHLlCQOPGSL3HNG3wZWBVsoyVyqb73jBpIQth49bBkUj0cCnhJkx3fhxsK?=
 =?us-ascii?Q?rlT6P+/a1EbakZUZdmA+TiHqfrcQPaXTFGAq4oFz0D4/0RRG5s0/Sbxffs6P?=
 =?us-ascii?Q?gtfeeRjvFKZ+68deqtH5YP5N//H+OxR2NvLXLH5l25445VAgRtWIjOslIRWR?=
 =?us-ascii?Q?j7eFK1B/KmFnoVXeBI7FPmHK8yDsX2GP6x1ZUEhZ6fA3mIQ5YDxoSV/5PAQX?=
 =?us-ascii?Q?Vt801soQdvyCKiU84K/W+UTdi3CECy3w+4xuKqsNCZPj0ekFcTe+3udaHM7b?=
 =?us-ascii?Q?NJuHsjfRz77G9XEagw5YslkGi+k12un4ZytsDxJcSYBKdtUOHz7aH5IHf5Cn?=
 =?us-ascii?Q?dwr2uj4fdaXkPey4te3LgSJJMeh/uAqHe5TmqJ0ot702Ax5w9Lh8tqvaP4Sc?=
 =?us-ascii?Q?FkQFYNROT7ENPbnlXTjChAWohfocbWvnf0SqxIZdFnBBKb/oIiBQBd8s8npf?=
 =?us-ascii?Q?4Skf+FlW6RuqK0izJtjIR2vrJVk9BMEx6Exi00cEgj0pgTBJNXXG/8U3Rn85?=
 =?us-ascii?Q?LgUrQu/CrP7e8mpNE4SJ2lqBmeKVA3UtE2EemvgL3+pdw0I4Xf9Yl/kzxDi6?=
 =?us-ascii?Q?JRJVp/lyILEWCjrsDqxfcZJo0PedFcKa+PPaFtbh+Ie0/zbehS01yuMpOtKG?=
 =?us-ascii?Q?o1kcDTK6WwrzVzOOt8Em3mtmMTsg8qCSJEn4hIqxTo+gQXKmQW4aL5j0kxz6?=
 =?us-ascii?Q?69a+RCX4EU7nuA+j7jJqsFpV1OxessdCCsLLTRsAKNSD5zYhDY9oDnb4mxRc?=
 =?us-ascii?Q?dUVYfHJmDxdc+6x132YNXKy5WEgrHzr6OFCNZ9Q9KKxjFzfnWXC9Cip33OVk?=
 =?us-ascii?Q?I5U7PHY1o5IccahhQdrnvg1JMj46PEiTqOA5ziMci/918mNcbsVfA3SFjQc2?=
 =?us-ascii?Q?xMtm3b15Ai0+yZSFjIQfPfwRbcwiuadRk/RyjJilrIYWdhD19TBuMiWugrKx?=
 =?us-ascii?Q?NGcR8ld54eu1Sdmj0vGjWnDh8bcKHwo0X1medYqMrc1jBAjtyVDVvnxj9iiz?=
 =?us-ascii?Q?/ZkzLiR9KrfKiVo1nCfy13EfogSd/Ts0T8Oc4MivQ9SYSxFuv414mRaeIMDr?=
 =?us-ascii?Q?WWdt/djK6m/U4Wu2/2iD0wu6CSosOnfF1RWOEPdtg9s8mLnGqxYHTcLnxJ+i?=
 =?us-ascii?Q?GccQtgu6vFllolfEmr6WegX3ZdBA4cJhS6H6eBAqnQ2Lxq2VrirMNQJkwnLp?=
 =?us-ascii?Q?xoALIdT5Zg8aVdU+Kon7vrhuGDQp0zWGd176rDe4rimqnDPqO9CCvixv/z0P?=
 =?us-ascii?Q?ijaI81vlxxHzs7qPCQcsNnOsPMrrL78006W5MI88Tg3mRDIdecaJzFixiMvF?=
 =?us-ascii?Q?JV8IIxHnHZ7+59DpFPj+xCaAxx3myIwWglKrIJRkyxWdHl91EAaV9P5Id6A0?=
 =?us-ascii?Q?3B93UQCEGaxhUEfo4/E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5061.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b521e2bd-c409-438f-ae4d-08db245f0bd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 07:38:04.1372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXvuBGDhWVIVRzPgkeG0/JiJJ2/Z6O6UPgkeftEfkbg/auUuvZ62QRPiC3mGyeSb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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
Cc: "Zha, YiFan\(Even\)" <Yifan.Zha@amd.com>, "Chang,
 HaiJun" <HaiJun.Chang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Horace Chen <Horace.Chen@amd.com>

-----Original Message-----
From: Yifan Zha <Yifan.Zha@amd.com>
Sent: Monday, March 6, 2023 3:25 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Chen, Horace <Horace.Chen@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com=
>; Zha, YiFan(Even) <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amdgpu: Init MMVM_CONTEXTS_DISABLE in gmc11 golden set=
ting under SRIOV

[Why]
If disable the mmhub vm contexts(set MMVM_CONTEXTS_DISABLE to 0xffff), driv=
er loading failed on vf due to fence fallback timer expired on all rings.
FLR cannot reset MMVM_CONTEXTS_DISABLE.
So this vf can not be recovered anymore unless trigger a whole gpu reset.

[How]
Under SRIOV, init MMVM_CONTEXTS_DISABLE in gmc11 golden register setting.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 2 ++  drivers/gpu/drm/amd/amdgpu=
/gmc_v11_0.c  | 6 ++++++  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.h
index 0305b660cd17..fad3034b35ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -104,6 +104,8 @@ struct amdgpu_vmhub {
        uint32_t        vm_cntx_cntl_vm_fault;
        uint32_t        vm_l2_bank_select_reserved_cid2;

+       uint32_t        vm_contexts_disable;
+
        const struct amdgpu_vmhub_funcs *vmhub_funcs;  };

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 0a31a341aa43..7481f2f2804c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -875,6 +875,12 @@ static int gmc_v11_0_sw_fini(void *handle)

 static void gmc_v11_0_init_golden_registers(struct amdgpu_device *adev)  {
+       if (amdgpu_sriov_vf(adev)) {
+               struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_MMHUB_0];
+
+               WREG32(hub->vm_contexts_disable, 0);
+               return;
+       }
 }

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v3_0.c
index 164948c50ac3..17a792616979 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -517,6 +517,9 @@ static void mmhub_v3_0_init(struct amdgpu_device *adev)
        hub->vm_l2_bank_select_reserved_cid2 =3D
                SOC15_REG_OFFSET(MMHUB, 0, regMMVM_L2_BANK_SELECT_RESERVED_=
CID2);

+       hub->vm_contexts_disable =3D
+               SOC15_REG_OFFSET(MMHUB, 0, regMMVM_CONTEXTS_DISABLE);
+
        hub->vmhub_funcs =3D &mmhub_v3_0_vmhub_funcs;  }

--
2.25.1

