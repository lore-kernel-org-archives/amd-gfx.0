Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613ECC3DA6E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 02:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCBBC10E2ED;
	Thu,  4 Jan 2024 02:44:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5D4210E369
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 02:44:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9WxLs6xFCl2ni5DmATRUSOOpzznohbzJL9KCkzH+PRVblXNoXKcHnrQlpX/8RBJHIN0YxrNHMiX7cIPZy3WIp/6tu+ELvGSIJ+QdgUtVX07RhwMmAPHAKgm9AhXf6HLmF8jAkO1L8K9zjZjsdvRpZ86pT79gNxvfrfg+CE/fbd7D5F6SqS6Op8DvcBgbVeNlTnBJZs1FUOe7JROQLm2KsIt0siF2BQrJYwFnmxcKmaZL2+ZmjrB07iVxPgYSmnUgN+k3imPJl3nbE1bnG5FpQ1bnkcVepe1uSS0gJ5nq/Qr9pPm1iiKEUyYf5RJlhDZtGzcMVF1BIGBBTf538k9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7tWHU+NADXUz318JTcRpyffz/B/SqvQAlndn3R3ugU=;
 b=lM6+iwDxj6tWGeui3ldJ/smPj26stoldq2JWE5GkjKC6RYxx0KkB3NzglB8FEoISOXM91vU+RZjwOmLDfY1SIAGXlJmMO9fkdoRuJT9seiuI+5bJpf5rHeqas4NIsiMwFdRy+6y3vzPXpqo4JO2M7kjh3VDui72z+VNf4hyHF2wlQ8w31IqV7sMLvI8UZv3XRUXlVcOSZX9f2RdDd0JBTesKIzs87IVCIt0e/WXe/+e7c69X2kJ5/KMZStDTWHhkFMxam6RVmOpLN5KYcX7zCaLf0hu1/sb9OsZLorkSHUxFR1Byn0/ZaCA6DPyeaB5SishV3fdSsizXR3jZN5Lu/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7tWHU+NADXUz318JTcRpyffz/B/SqvQAlndn3R3ugU=;
 b=Q/JTQJwezO7felYpkQMIJKUA9Q6sXn0lDeKq5rx23fOfxG0BqAu/9L7cutY73vLBL5ODRAeI50bzp97lhyaUH6t48g/I7KMY+ZtHyjWe0w5fouJXNJ1DdTyoJEfwd87vtoVpZ2hI+BTz4JpLIC4PeV3EK2l5zNXTJ3hRramRmoo=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 02:44:30 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 02:44:30 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 08/14] drm/amdgpu: add gfx v9.4.3 ACA support
Thread-Topic: [PATCH 08/14] drm/amdgpu: add gfx v9.4.3 ACA support
Thread-Index: AQHaPhtpavbs+BGbrE29tkdLxWq627DH+F4AgAD7OfA=
Date: Thu, 4 Jan 2024 02:44:30 +0000
Message-ID: <PH7PR12MB5997777095AD01719B131F058267A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
 <20240103080220.2815115-9-kevinyang.wang@amd.com>
 <BN9PR12MB52575437DFB9F3DD6228BDEDFC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52575437DFB9F3DD6228BDEDFC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a75187f1-d405-4ad2-8cc8-b5374008d690;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T11:44:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH3PR12MB8307:EE_
x-ms-office365-filtering-correlation-id: b9f7698e-0187-4d83-0987-08dc0ccf138b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KWFH7brh6rwu3rmI3UGPLNldkZevNCudngj4fdIXdapXfDgAqAfdVAxAnZlvo+bqhSTWI2IF57G1wp2WI+YSZxp1dmOepf9rLOSLJUA+1+h4UPHvHVFcsBchO+ltY4xgzXnJGQIbu1Kv4cuodGxAfVSRNcIA7pvAjgE18GZo3MWe5Lwm3Z+GVXZWnq3cY0p8Och8x2oZOLKEQ5NqKwf2P8I3KhtVv7Fl3aO3vx79yIAELRNMLt8UsLD08wtBNtKKuo6Z1paHvpTxpamFfC0Mg/4kGDW4sRVoyb5tJA555dKiBR2DnnbSw1plYpjj4U08gE45miQ2EJeUkHkgBLI+kslyVJm965ydPcz4M6fmJoKnfhzYybzxjN173YSlHUJyokZA2uGki3uD0WKWCUMyNecoBVP6sappm3KQKRuEkVtJdMhSVn2Z7RDBZ/NI9a0rZsTkaQKAFL41F5HjGMKFahA7/KCDwHJwiR3PKfY2eEvKZhanCg7pk5Dc2kLesCINvgQLnGGEioQfZyeSBgASW1VmQJJhLGq2cNsPARb+iVe4AxwRDwHy9VoQ7ldoNPa6efkSaqVtIhXwJHo3kg9hW4JPu6j/Cr16wz3KXIL4nKyxQcUCcmHRzyxaEoVryQ8d
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(55016003)(7696005)(9686003)(6506007)(53546011)(26005)(71200400001)(38100700002)(38070700009)(86362001)(33656002)(41300700001)(83380400001)(8936002)(4326008)(52536014)(110136005)(2906002)(5660300002)(8676002)(66476007)(66946007)(64756008)(316002)(66556008)(478600001)(76116006)(54906003)(66446008)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l5U83wiG5bc68t00ioplDtDLRZahfRM2Aad2DrctXw6JOQeKALxdJoeN/Ksz?=
 =?us-ascii?Q?GucDJsFu0/U456Unb0kl+MjHD0SM1ImhKBucL+Jvl+BLBNn0JVZgxWxtvm/4?=
 =?us-ascii?Q?FssGD5rDdOGZDVaBEqQYnbdCGIQH9X86ygYe5gBX+CGC7sZmybqdTvkKBpA3?=
 =?us-ascii?Q?pR6enhjLeOJ4hGhiwulAhqCPe3mqgpZ3b5DN0QhzM4VQDMhcJa+h93+2gEij?=
 =?us-ascii?Q?g1OU9QuhtIMaG8MJVsHetVrV34V3hbd7xEgT/n8zlsRmxHzKfdUP/ny829T+?=
 =?us-ascii?Q?/YRRkvFhH+Fiomu6OZ7/E+V3x6k8/Jjh1N0wnsOmQsoSGah1xw6GfKW5+RAD?=
 =?us-ascii?Q?4fKEdUYfWl03N2DamLt4AkGjpdfpEejNiN0m3x7RDW9qLNZyAjebGBv1tWGP?=
 =?us-ascii?Q?KuXrU5ijRTQVMPHIm8s5R+XCR7C8+SHe2dVf7DAI2pfD5wlb6h5zaySKR1+7?=
 =?us-ascii?Q?4cOHhz9/+1pYeOv640xm0QFPkIdcFfo5rJh8k8DLVbSgH7po/d+7HFPbi375?=
 =?us-ascii?Q?ZjoUKT6hpaYdK6s5cBLLMEf1zwQZUU4k4KdiRRTEbG5HDFAcrSFcU6ioP6tN?=
 =?us-ascii?Q?XURIVOymQjfew0hI+7EdlxQ+xSRTQuBESAjCHSOA+yJXUaVid/rSycktg0nu?=
 =?us-ascii?Q?iCDQWAdGPGjeBCnIER+uzrTi7iPztk/r6Thvi1CwJ3pzZ4kOUfzYSBMRMxmG?=
 =?us-ascii?Q?HYU+x0HBCuhQdrqoHI5Y5cp80vIEf2pCeLGh7ut4Ap11DwDdiIlEFuDltARk?=
 =?us-ascii?Q?QWJgz6XJ5HRFek6DbLadhZuySBFdoyeu1R8Gt3DLE5tnJLHPQD+NM8/iNcn5?=
 =?us-ascii?Q?yCNU0kQG+TAyXMZXyX3ezduS/SeRVLzoPJarI1rmu9bOIgUIn0eUImedlbaN?=
 =?us-ascii?Q?ljGzS3bMhorOADusDmr8N1qeyJ9yStOVmNQEzMKxPlWyv33ohu/17oVefbh6?=
 =?us-ascii?Q?phz8DuiBXgKUzIXUhi0jIfIIS2VTKgPXECl4MguBor14C0YeVL26TXldE66c?=
 =?us-ascii?Q?zRiHixkXacZWgeOPQZwmAeDqHbRdfrdHD5hdiUhxcZu8VJnVgXuWAyinjZv4?=
 =?us-ascii?Q?I6H0KvkBfQjBdvUZ70QqCyQ4H7qIsLtWHxVOar9WgRLhHYk+6moKuDuSAJWO?=
 =?us-ascii?Q?ykfj+18ktBFmQRXTlgyzwJNnXo1GVxpLn/P5bNEFAwwbJyCTTwoDFquKJeWy?=
 =?us-ascii?Q?qJA607BxW+ymf2aO8WajVBuab/930ijsjDbcELlMKgwVNyVgzJ4wTZmmyzW1?=
 =?us-ascii?Q?TF5iV0KB/8ei0CKmaBDNshaRyK6C/vz4hZzZxovzImaoj9qfLLy2BkADPaiP?=
 =?us-ascii?Q?qUVrkybfq2aliMPrIVpA4539Yjtbq+B+pZEDCLyV6FOH27Elhl/NT69CmNM7?=
 =?us-ascii?Q?woPlGSY4UYeYrHZqrbfBPOMSvPbi+T0RaSGTEbdsbI6/rXJa8i57qTlLr/QC?=
 =?us-ascii?Q?mm0wrHrzjtF5c1xG+/zFf0o3sx4yHStlAzPJP7lAGMz0KS30mpnyPu4qRxPD?=
 =?us-ascii?Q?jIV5OYLDNLcz9eWhL9jQ6vWX5nZXIrHXJS2F0DgMg2/U65mziZAxKp6m1G/J?=
 =?us-ascii?Q?PPWB9aqs+B/RVxfIASw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f7698e-0187-4d83-0987-08dc0ccf138b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 02:44:30.5330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yu50unoZKvSBw7XGyvWLLX/p4QucZ4aZn/AGRvsv9baWBbf0dk8W6DoNuRhNsmMo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Thanks, will update it in next version.

Best Regards,
Kevin

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, January 3, 2024 7:45 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 08/14] drm/amdgpu: add gfx v9.4.3 ACA support

[AMD Official Use Only - General]

Simiar as patch #9 and #10, let's use macro to define the magic numbers

+       case 0x36430400: /* SMNAID XCD 0 */
+       case 0x38430400: /* SMNAID XCD 1 */
+       case 0x40430400: /* SMNXCD XCD 0, NOTE: FIXME: fix this error
+ later */

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, January 3, 2024 16:02
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
Subject: [PATCH 08/14] drm/amdgpu: add gfx v9.4.3 ACA support

add gfx v9.4.3 ACA driver support

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 85 +++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index 131cddbdda0d..18b8e4dbe9a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -38,6 +38,7 @@

 #include "gfx_v9_4_3.h"
 #include "amdgpu_xcp.h"
+#include "amdgpu_aca.h"

 MODULE_FIRMWARE("amdgpu/gc_9_4_3_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_rlc.bin");
@@ -675,6 +676,67 @@ static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_fu=
ncs =3D {
        .ih_node_to_logical_xcc =3D &gfx_v9_4_3_ih_to_xcc_inst,  };

+static int gfx_v9_4_3_aca_bank_generate_report(struct aca_handle *handle,
+                                              struct aca_bank *bank, enum =
aca_error_type type,
+                                              struct aca_bank_report *repo=
rt, void *data) {
+       u64 status, misc0;
+       u32 instlo;
+       int ret;
+
+       status =3D bank->regs[ACA_REG_IDX_STATUS];
+       if ((type =3D=3D ACA_ERROR_TYPE_UE &&
+            ACA_REG__STATUS__ERRORCODEEXT(status) =3D=3D ACA_EXTERROR_CODE=
_FAULT) ||
+           (type =3D=3D ACA_ERROR_TYPE_CE &&
+            ACA_REG__STATUS__ERRORCODEEXT(status) =3D=3D
+ ACA_EXTERROR_CODE_CE)) {
+
+               ret =3D aca_bank_info_decode(bank, &report->info);
+               if (ret)
+                       return ret;
+
+               /* NOTE: overwrite info.die_id with xcd id for gfx */
+               instlo =3D ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_I=
DX_IPID]);
+               instlo &=3D GENMASK(31, 1);
+               report->info.die_id =3D instlo =3D=3D 0x36430400 ? 0 : 1;
+
+               misc0 =3D bank->regs[ACA_REG_IDX_MISC0];
+               report->count =3D ACA_REG__MISC0__ERRCNT(misc0);
+               report->type =3D type;
+       }
+
+       return 0;
+}
+
+static bool gfx_v9_4_3_aca_bank_is_valid(struct aca_handle *handle, struct=
 aca_bank *bank,
+                                        enum aca_error_type type, void *da=
ta) {
+       u32 instlo;
+
+       instlo =3D ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]=
);
+       instlo &=3D GENMASK(31, 1);
+       switch (instlo) {
+       case 0x36430400: /* SMNAID XCD 0 */
+       case 0x38430400: /* SMNAID XCD 1 */
+       case 0x40430400: /* SMNXCD XCD 0, NOTE: FIXME: fix this error later=
 */
+               return true;
+       default:
+               return false;
+       }
+
+       return false;
+}
+
+static const struct aca_bank_ops gfx_v9_4_3_aca_bank_ops =3D {
+       .aca_bank_generate_report =3D gfx_v9_4_3_aca_bank_generate_report,
+       .aca_bank_is_valid =3D gfx_v9_4_3_aca_bank_is_valid, };
+
+static const struct aca_info gfx_v9_4_3_aca_info =3D {
+       .hwip =3D ACA_HWIP_TYPE_SMU,
+       .mask =3D ACA_ERROR_UE_MASK | ACA_ERROR_CE_MASK,
+       .bank_ops =3D &gfx_v9_4_3_aca_bank_ops, };
+
 static int gfx_v9_4_3_gpu_early_init(struct amdgpu_device *adev)  {
        u32 gb_addr_config;
@@ -4242,9 +4304,32 @@ struct amdgpu_ras_block_hw_ops  gfx_v9_4_3_ras_ops =
=3D {
        .reset_ras_error_count =3D &gfx_v9_4_3_reset_ras_error_count,
 };

+static int gfx_v9_4_3_ras_late_init(struct amdgpu_device *adev, struct
+ras_common_if *ras_block) {
+       int r;
+
+       r =3D amdgpu_ras_block_late_init(adev, ras_block);
+       if (r)
+               return r;
+
+       r =3D amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__GFX,
+                               &gfx_v9_4_3_aca_info,
+                               NULL);
+       if (r)
+               goto late_fini;
+
+       return 0;
+
+late_fini:
+       amdgpu_ras_block_late_fini(adev, ras_block);
+
+       return r;
+}
+
 struct amdgpu_gfx_ras gfx_v9_4_3_ras =3D {
        .ras_block =3D {
                .hw_ops =3D &gfx_v9_4_3_ras_ops,
+               .ras_late_init =3D &gfx_v9_4_3_ras_late_init,
        },
        .enable_watchdog_timer =3D &gfx_v9_4_3_enable_watchdog_timer,
 };
--
2.34.1


