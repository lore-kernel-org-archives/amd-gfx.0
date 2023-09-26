Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A46E81815
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 03:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E7E10E349;
	Tue, 26 Sep 2023 03:20:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C29410E349
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 03:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyR7OAvIome9wfwzimeRplRL/wTsnDyEgJ27XVUhOoSovtV7xpuHXIl9tER5HupE8Gtj28CQGO3An0tF07tvvvulep2fylbiXw6Kp0+UXRPFVdHZqYfGNTY2TmaeII5hGIgJJgWvZmNHVXnamfaKPBClNtxiStIpIgwLSzmgrpkVP11j/pVUB3opEEGk/UymKTnR6Y2q0FIp3Jbxmt3JeHaRAWPxkPhxov5hSObWXp/374tRTNC7Xzt6C1jvf9XdXXwsw475akTvY4bxd5gUXjLspL1kjx4M12KmZabwSW8eKeGOMT7XXCQzkIXaXs9nBYUkw7YjLvTo+/LsnTAiKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfMhFwTLXqENrYbv8Y7Hd9Y6ZHqb+oZ20sALBdt/5Yg=;
 b=TQKCkbJiE7Autl/33KvxDdqAsecZ0/em2iNWTP3Ti+rY0GT9F6nyH7LeZqo0+fMCpz4T89MKLDVVSLHiJaYmoJKkLQVnakhLgP2KV1r/Fqr2bg3wNwdKZ1tJwhb2yvPqLymJGR1wdDj7wjnVFo45LFfOqOPFE3hBJgZZzdnvh26XAzg4dLJYosk2GEO6mpkK3tsTCGMb8dC7An2yt0U6jG+XaPtygUUYc1tnCMqs8KKy06JQC2aTNcNtcF/17zK2hjcruCsk95fD9dHfDMEv+pL2T0zD5XBWldG8s1yQRcZJ4GFU40eht0VMFpECu1PO8JUzfRI1twbMTWHYWsJSWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfMhFwTLXqENrYbv8Y7Hd9Y6ZHqb+oZ20sALBdt/5Yg=;
 b=4fa/53FXmU9VOhsSkXDUGLwLjl5UIlxFRWYmMDZumNXBpz4gAfr+bL613bnrQ9i5JI9w6E9sOc3r1vl5cInZ09WpzP0RNZe9PKF0d/whSbksQfTPiPhdAlZq1uG6E046cyzau+tgIfuHQRff5ly80caHgocICLpnNF3n9aixF9o=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 26 Sep
 2023 03:20:39 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::dcd1:7d96:fd8a:ba35]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::dcd1:7d96:fd8a:ba35%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 03:20:39 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 4/4] drm/amd: Enable seamless boot by default on newer
 ASICs
Thread-Topic: [PATCH v2 4/4] drm/amd: Enable seamless boot by default on newer
 ASICs
Thread-Index: AQHZ5mXrKZMtwpge3EeTIFkK2lpXerAsgoYg
Date: Tue, 26 Sep 2023 03:20:38 +0000
Message-ID: <CH2PR12MB415257CDB87ED7EB3568F763FEC3A@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20230913171455.153412-1-mario.limonciello@amd.com>
 <20230913171455.153412-5-mario.limonciello@amd.com>
In-Reply-To: <20230913171455.153412-5-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=758a435d-dd84-4e4e-8af9-577e12fc8ecf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-26T03:15:11Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|SA1PR12MB7409:EE_
x-ms-office365-filtering-correlation-id: 299ebdf4-39ea-4a3a-8035-08dbbe3f8ec8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OMQpFdYlONJdFzC9O4kkR2bTfUlmKU4ue3g/tzl/CtL3HfM19j/5ukWrbU7XwnKsoP8GbS+TpsU+oz/KrmjGJDjDIleR084+1u/2GCM8WjQHIn6ufMaxdHFIbXsHSnM8oicDGBTssxpl/dwJBytgni+IG459T0sWJ99/PY2Lvkha+kCYSwLUCbKUCa8b3fussAcGhJgCeqQ9xAn/CWXgdp3+j5D432AmATjlsAsthM7EOqtMABzA97GXXtcadexE92VhbbQYEgHKw4ZEyk4i6WCjVj4fs/NyEMhv/f1gjt7stO4XYHitu9H5Xvh/UYw0jncmZx6jiv6sAnJzdqc21O6JXzUYlOG8xCZcuS9AIO5HV/qBIvK98dC/Gdy7d0S++FzkC9yyCJA83jnt2g2ep1P+4YlBtp1rAEjwiq1dvI/5AE5bf+jU+augc6UCk8dGlaTci6GcV0THtYuBBN2Sr8WCeK9uI1cv9lCkZrUjhbb7yzwLeg3WYcDpz8uWhV05TR6ZvUyCsctsOPc6EtnxBVXxy2CLLGqHIS+yvAR7zhXkZWh2X0liMMrWftka55twpoxfjFPb/S0a0GcsBYyefRn6a6ABMJez3r9iN4T0Sb1hSMdHypFGqWUlnnl0Bbkj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(186009)(86362001)(71200400001)(122000001)(83380400001)(33656002)(9686003)(7696005)(66446008)(66556008)(64756008)(54906003)(55016003)(6506007)(66946007)(66476007)(52536014)(76116006)(26005)(41300700001)(316002)(53546011)(478600001)(5660300002)(8676002)(4326008)(2906002)(110136005)(38100700002)(38070700005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?UU44Q1doVXN3alNJbzFLTkxqc1Y0ZExlVFRVRDUrT0pqRlJJUnRsK09X?=
 =?iso-2022-jp?B?TEZyOUZ2VHNKV1FQSDkwM2tOMzF6NWhsS1pxcVkrNXVQbFZibTdFakpk?=
 =?iso-2022-jp?B?Vm1KMkpXbEI3Z3JzaytDOTVvVWRIUUZta1d4eTZUSGY5RFl0QlFhL3dW?=
 =?iso-2022-jp?B?bjBFWEtsQnNicTJyTTZaeEliQ01SVVZjcVl1T3ozenpkTDJMOE5ndFJO?=
 =?iso-2022-jp?B?V3FOc093ejJFQmFDeWJEcXFqUkxrT0IyWTlDNjZ4bkhBdURwdld3dm5i?=
 =?iso-2022-jp?B?ekVFZUJyNDdOTnk5dUdnb3RFK3dPelRjQUF3MG04UmI0TVJLbkhCcCtI?=
 =?iso-2022-jp?B?RDJTYjluNDNEUDdtYlRGU2ltQkJFcnh5aUtLQlRKSmtwcGh1SCtIdFVQ?=
 =?iso-2022-jp?B?bW9oMU9MdEZKVmhPa1h4UDBOVHczOERDQkFHbUlOSGJtbCtNR01YUVpS?=
 =?iso-2022-jp?B?eUp6ZU1DdlBkekNCRzA3dWQ1ZVZjMERic1c4bHpiQ3N3VTZmSjZ2M0Va?=
 =?iso-2022-jp?B?Vnd1M0g3d3FnYmhYdGdIYXdkSU81U3JKOXZBOFpXVE9saUI1TXpnK2Iy?=
 =?iso-2022-jp?B?R3ozZGpVQng3cEZEdnBMZ05VaCtlbWQ0TndHbjZHVmNGSjFCSzVSemJu?=
 =?iso-2022-jp?B?UVI1WU9YbVpDOUw2MGVtRlNjMUEzYi9xVlkwL2w5ZWM5bHo3VU9neHhZ?=
 =?iso-2022-jp?B?eWlmNTFPbHAySTlnNkpOMHU5bFhoaWlaSDV4ZEtlWlp2dER3ZFhLM3Zl?=
 =?iso-2022-jp?B?MllEakQzTktTeW4xazM5UVg3ekJNTmhKZ3IyV1FnUFgvVlFrSEl4Z2dX?=
 =?iso-2022-jp?B?ekoxbk82S0pEM1NadFVoMXl6SURYQ3AvUkVweWFNWWIvSGVDTDgrVm1X?=
 =?iso-2022-jp?B?TG9xcVlLRkx0cWUwUFEzYXU0algvL054TmlqYjZ4eGpldmtKM0lRMXh0?=
 =?iso-2022-jp?B?TWNOUmhzVnhNbng4SVRBcktGazJacEFJUjE2RXBYUzEzNW83aDU2N0tU?=
 =?iso-2022-jp?B?TDgwY3I2aDdhRm4wQ2pWZitQK0xKMjIrQjlQbnMyLzIvSVVFMUlObUda?=
 =?iso-2022-jp?B?d25IZFY1UHlsZGdqNGJKdGdyWitJeW1XNW1yMjV5SkZrcXpiNzRWbW1j?=
 =?iso-2022-jp?B?UzM4OCtEMVpqcm81Z0hHWlViMjRBVDR6bzZpSHF4QmE5eG5QSldrZ04z?=
 =?iso-2022-jp?B?SDVFWWhiNVJFb2oyYzNtaXV6d1pBdnZKMGs2cVJzbm16RGpCaTdBbTFy?=
 =?iso-2022-jp?B?OEoraitKT3RSZHIySFFVWlFiVG1VbzBSdWloejVwak43Ukw5TGVKa3hG?=
 =?iso-2022-jp?B?WTFkbUxuRnFMV1VEdGtSTUFpSTlqZk4wc3crWFU4dGNPN1VqTGNRTnRt?=
 =?iso-2022-jp?B?dTFIZVdoWHZSdjVPMUVibHpOZVNOV0pkVUJEME1uSSthdngzNE1seEkv?=
 =?iso-2022-jp?B?RHUwNTdZUjkzWlNIdFpVaTJSc3JYMmUwYjJ1c1JNV1lyd2tiYi9pdmJH?=
 =?iso-2022-jp?B?b0ZpYVVEajV5eGpyendiUXFqK3VaK2x4bVNGUXZJbm1uQTE2MlVtVjFZ?=
 =?iso-2022-jp?B?cUVIY1lwRmFWN0t1a0VvbWEyVThySWZHWnR4QnFzL25pZ2xSUFBpRVZW?=
 =?iso-2022-jp?B?WkRJVEx0azBjWWFtdVJ5TVd2dU50dVcxMGVWVWFMdGFLa2dWRVFMMmdK?=
 =?iso-2022-jp?B?Z0VYUkhpN3pES3M4WDhiTnhwTVJiTk43Z3dlU0pFRmpFVjZJQjBoZEZN?=
 =?iso-2022-jp?B?T2hqLzRTQzFvRk9NazUyeFZxYldIMnlGTnM2d0wrL0Exa0VZblN3V1Yw?=
 =?iso-2022-jp?B?RFdNL1lTOG8vNXcrdHpSZDBwcXE0b1Qra1hpUEwyaHlJcEFneEptNWsw?=
 =?iso-2022-jp?B?eUdFZ0FhcXpaV2dNTUlKMGFOQTNWWEQrelNUamJxai9salpCV0xWUm13?=
 =?iso-2022-jp?B?Tm9HZlZuazRHTEhFS2dNUG1pWG4wcXRFanVXa1pZNWNwTld6K2haZ1FV?=
 =?iso-2022-jp?B?djRidUdDbmo2SXVDWEVBejJSeFIvMEVxQTJZaVRxMWxPZ2pOcjhLeElQ?=
 =?iso-2022-jp?B?VVRSUzNVdnZSM3BXRURTVUd2R1F1Q0hKZUVQVEJQdzlqUzJHRWlmZVhM?=
 =?iso-2022-jp?B?MHZUaTJqbW9jRGRzOVIwZ1lVRkQ2ZTBWR0VkU3A4aitQSFlZNno0ZSth?=
 =?iso-2022-jp?B?N3FOZHVmVDA1NzlxU0FKOW9CcGZmaVZYaFNucFdka294NGtRSlNkR3Zx?=
 =?iso-2022-jp?B?K2dOL1RrUmRaT3Z5MVkyNDkxbUZxVndKRT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299ebdf4-39ea-4a3a-8035-08dbbe3f8ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 03:20:39.0165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJQE7GLApT/wRdjeJOpiAG8U+NXOVOz8CGQpR35w4pwnvCDkgYwUlvMFoRlsUmw8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Mario,

Navi32 which DCE3.2.0 not support this. This patch will cause modprobe fail=
 on NV32.

[  +0.000126] [drm] DSC precompute is not needed.
[ +19.026503] amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with your prev=
ious command: SMN_C2PMSG_66:0x0000002D SMN_C2PMSG_82:0x00000000
[  +0.000002] amdgpu 0000:03:00.0: amdgpu: Failed to power gate JPEG!
[  +0.000001] [drm:amdgpu_dpm_enable_jpeg [amdgpu]] *ERROR* Dpm disable jpe=
g failed, ret =3D -62.
[9=1B$B7n=1B(B26 11:00] amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with=
 your previous command: SMN_C2PMSG_66:0x0000002D SMN_C2PMSG_82:0x00000000
[  +0.000001] amdgpu 0000:03:00.0: amdgpu: Failed to power gate VCN!
[  +0.000000] [drm:amdgpu_dpm_enable_uvd [amdgpu]] *ERROR* Dpm disable uvd =
failed, ret =3D -62.
[  +3.557018] amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with your prev=
ious command: SMN_C2PMSG_66:0x0000002D SMN_C2PMSG_82:0x00000000
[ +16.269817] watchdog: BUG: soft lockup - CPU#7 stuck for 26s! [modprobe:2=
8704]


Either change to:
return adev->ip_versions[DCE_HWIP][0] =3D=3D IP_VERSION(3, 2, 0);

Or revert [PATCH v2 4/4] drm/amd: Enable seamless boot by default on newer =
ASICs both ok.

Thanks,
Feifei

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario Li=
monciello
Sent: Thursday, September 14, 2023 1:15 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry <Harry.=
Wentland@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH v2 4/4] drm/amd: Enable seamless boot by default on newer A=
SICs

Seamless boot can technically be supported as far back as DCN1 but to avoid=
 regressions on older hardware, enable it for DCN3 and later.

If users report using the module parameter that it works on older ASICs as =
well, this can be adjusted.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 2116e016178a..38fafed31a1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1361,9 +1361,9 @@ bool amdgpu_device_need_post(struct amdgpu_device *ad=
ev)
 /*
  * Check whether seamless boot is supported.
  *
- * So far we only support seamless boot on select ASICs.
- * If everything goes well, we may consider expanding
- * seamless boot to other ASICs.
+ * So far we only support seamless boot on DCE 3.0 or later.
+ * If users report that it works on older ASICS as well, we may
+ * loosen this.
  */
 bool amdgpu_device_seamless_boot_supported(struct amdgpu_device *adev)  { =
@@ -1383,14 +1383,7 @@ bool amdgpu_device_seamless_boot_supported(struct am=
dgpu_device *adev)
        if (adev->mman.keep_stolen_vga_memory)
                return false;

-       switch (adev->ip_versions[DCE_HWIP][0]) {
-       case IP_VERSION(3, 0, 1):
-               return true;
-       default:
-               break;
-       }
-
-       return false;
+       return adev->ip_versions[DCE_HWIP][0] > IP_VERSION(3, 0, 0);
 }

 /*
--
2.34.1

