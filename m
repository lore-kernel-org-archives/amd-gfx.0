Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54965CE79A9
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 15:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6A610E296;
	Tue, 19 Sep 2023 15:34:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7449B10E296
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 15:34:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHJp8sas4YypKw3odk0CtksYNLd1VTPziavdTCEPQ63viJBDLpygEC3izL8SuNeNDTlQ2q4exMCtqwphqql4UDMYnfyxxkCNlBpPRS9lgs9R1PwB0Orh1NExJL1AMLdNCdVPzFjlrcw7wzLjPHHTUvuU+AtZ9BAYAS4DHuq8TUSWPzNm2ziqcx7lYxs+BL8wBmrBhZ1v5XJKTMGUEvS1eEKCZmjCYUaCstpNxyTgf2EPof/PQxqAuiqPEQikipxA0LL+UJjQktzB8T6hWnLUpcLazFN5B68UlnRKeKURom15s14eQglXPqq4jrP7Tpp/Y2luds2hkqyyiAiHFSK05w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pS8PmDXhL/H3+XeSvdZEXIxAyvT7OmNg0LZq9f0isQ=;
 b=EvMAba2y1eskZHXS0MzE1Y/gECUvpJ1t+hYNPkyjWG0Z2F385WlRih0pC5RIBaz7qBIu7nzxlGzGdduyb82ynH8k57CxcJilcHdeI6wSpA2Lt5fythXCaoEAhFVdwXqOIYoG5iMMtu2Sr30DrNQvhHn2HARAbbygspPb0jyntgrn5/Jfr5rDlbUJV+sROBpt4o9fECcIVYlwUZ6FrVDvE4LmfCnEgugDjDD0BqJlVRASCeYAQTH8YRs2sgPlwF8UyY+lIN5tACCFrB05z063pos10ccUPT8EMvsf0BsO5D1AGOURpMkPNXc0l3EHhKI1YyuWfpGVFhBhbq7BheS0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pS8PmDXhL/H3+XeSvdZEXIxAyvT7OmNg0LZq9f0isQ=;
 b=wOrbshAk/z8jBdxTbuP4dw8KO1fFT2GCkRLFIwlHpRoJuO/rmmpi6ekWLC1O7ycEsVl9yo5hHQCOxwvjrn9exCLqk/0VMiXUaNaWhfRgamcsgkS0KCaRgRKVjwMrV4MXaxKYYfTRw8ZSJsriKUBBiTQ8LtMzbFwacbDNoVM9/5M=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 15:33:59 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6768.029; Tue, 19 Sep 2023
 15:33:59 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: change if condition for bad channel
 bitmap update
Thread-Topic: [PATCH 3/3] drm/amdgpu: change if condition for bad channel
 bitmap update
Thread-Index: AQHZ6uFxvqHLNKv230y0nDUXUsl0+LAiRh6A
Date: Tue, 19 Sep 2023 15:33:58 +0000
Message-ID: <PH7PR12MB5997FC420ADC892676DA822982FAA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20230919100936.8810-1-tao.zhou1@amd.com>
 <20230919100936.8810-3-tao.zhou1@amd.com>
In-Reply-To: <20230919100936.8810-3-tao.zhou1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6c0d69c6-65cf-4800-9696-9e437f8ec37e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-19T15:28:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CY8PR12MB9036:EE_
x-ms-office365-filtering-correlation-id: 01e88453-f842-46ea-36d6-08dbb925d7e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jVs0KiTlbb21pStQyJocRJDFRckIpI5EMBxU3KzSQmnWlt8MtWJtrUZlfO5me9Ulh/ERRDNgbZK8cgOw0pupJAwvHgsQTFIvL16KiQGaOuKSIFVM3GCuDcXc8ABe3c9mEqoq1WfYlgQ1azNkLSPjrkv7C6jUro0rlZU2vpRAxgAttpMWngKN0i3K9poM9V7unsmOECQM3Pv1o1UQ2y7KJkmn7wIz54ruOqLGzY265BVJEjqrKEl4bjWtcumYzAYNLOhwsRDEG4wc08BlVMD/K28g/3FLobVXjNcP5FZDdnPsd5B+3AWenkxoQ9Xotfv0NkwxI4p09hTc2BGcAc+Fia+1FfqvoajeqDFsNTBjCjegSm/vUjckadB1LNaFWYF/2q+B8LKiiU/6dqf4KfV1BkA4I3dHVh2RbdDw1TIuc+Fm1zK5WdQ6pHbipbw5hyryiVuZ/OP9wn18ZnLNHeHONR1KmT6WWetDGjf05PELuho+mfnkkCIISWCAcF3J9e6RZIPxZyZF6WWYSqdxvt2j015cHuLjYvGsUJ10gVJixIWCO7hbX4rimeCPwwYlwaqU+peIGtkELnOMWXag3mkTk+pSKPof92FPDw2u/9dyc2EZRLJolfy/5+CTnxEoCpuxNXr9ZUXV6NxrDNhMGoER/Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(1800799009)(186009)(451199024)(478600001)(6506007)(7696005)(53546011)(86362001)(33656002)(38070700005)(38100700002)(122000001)(921005)(55016003)(26005)(2906002)(15650500001)(9686003)(71200400001)(83380400001)(8676002)(5660300002)(52536014)(110136005)(8936002)(41300700001)(76116006)(66946007)(66476007)(66446008)(64756008)(66556008)(6636002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a0obt5nmmlU2kBqvxjHtC7beOq30Mrejd1dRtiKmIOT/AJXd4A31aesyxjM/?=
 =?us-ascii?Q?VCYtpxMN0xyoixb9RajfRT+KSSJThRLArL2+vS0Po3xcNYYgAJx0C1P+fbBK?=
 =?us-ascii?Q?Y/G4kOVSdx3gycMHIFiUwcLBcJ1cOkFAWXNwX/dEJtHhKx4bIRO5W2boqmfU?=
 =?us-ascii?Q?goOkcUiUyHqAZUWMgJvT5yZJVLtvnjUlAIGhcoIhsxHHOw2WxaDIUL+BKCvL?=
 =?us-ascii?Q?oume29/hBTr+7K/o9HKuMGCyRLBabthgv7rFo2+1SJMv/FFnNWv3EoecfG3M?=
 =?us-ascii?Q?xluWM56zGK74mDk6NOMzGT1iaYBbT+DOYTqh4uIdNzljbG1s3LFbQF4kqKwN?=
 =?us-ascii?Q?9aZ5VNaElk1MfCOqWQWaXWyltw3S6Cl1W2lpvq8pKX60IwLqKEo6kebdfU6s?=
 =?us-ascii?Q?nYnkjsSQptKHyLWTp5iihcgVA8FL+ZGMF576iPFjVrSSHEIzvPKKzEf4FPvn?=
 =?us-ascii?Q?Oz/PCNZmurJkcvUDa0p5Xv8Bewuwp3TdQ3DFo0GLalzszT4II+08KwBICimz?=
 =?us-ascii?Q?SMuwAkK2UEUIBrxDSxLlN6Rs2KzEs8JoWDR0WbwU9aYi/YsTcT99nHsaSeKc?=
 =?us-ascii?Q?zZjpN8hX310iYMfWulYL01Vw4ghOuKT/7Syi2MyPnkRx/k//05ePVcv/Co14?=
 =?us-ascii?Q?evMInKUxazormyw8TfhT29Bkk7t7sRmzOW3uPwpsVDlXOTPJS13hUVkRBiQ+?=
 =?us-ascii?Q?0lHX4j2WHIbL7afLQsj9BUnGGF1w61jvK7ugKVtil/Vfkt1Xv0PKVANWKatx?=
 =?us-ascii?Q?7KCiOgd6lt2gA4fmbS6qKHR3PXsjIWgeyzJ2I7qUOhKV+cCc6GGp9rmXEG+d?=
 =?us-ascii?Q?LZGNHn0Uwu92NurqbRqzHYU1JPXXDEP0oibD0z8oQ+euXvaSF0I1X8qCmDoi?=
 =?us-ascii?Q?TBbk8ANZsCcOfWvTMW8EMucj05e+Wg9dVCivVqZ/UoSNeOBr0xRWYgqhvUcJ?=
 =?us-ascii?Q?fxg6h34ku+tQdzdAof6oydzIY6K1mwAWbDTf0LtQofFegdzRDDXmvPVwM14I?=
 =?us-ascii?Q?at7c0iuA/QcsPB2OTiX5mQzQ9RJIukxRFrMOIdlYKNtSOHdd6OAzb+3nWDQJ?=
 =?us-ascii?Q?HIz96xnsHI/mi9+wWU5zz7m+qWIkMgnLVqFol72L9Z8eTSgLwMOHvi5yNAVZ?=
 =?us-ascii?Q?yg4SrKYEMp3g+IT3wFy1PR+Va/29hPkWIT2bBitqOLJT9aIFGq8ocRw+v7cV?=
 =?us-ascii?Q?SLPUNj26miu/tn2Pzfy0Uvv1+LoG5/nEdbcBlADSQZQUrIWwYAmHLkYjbAH8?=
 =?us-ascii?Q?YJ0p/1hrXhlfTacaBPiuaOksqQkdFBMJg0SZSYDPliO1h3eLJ+KjuP39PwMX?=
 =?us-ascii?Q?NjP7SaZfNKf3nUUDNfFE0Y0h72v8eP+jtTmMoxZT968Sj0NpPCKsOv4SNiZi?=
 =?us-ascii?Q?0WFjSPTrzhzYTP6YBJj/azDc+lno/wgE/SJlbQEDNH0svHms5lAIK3YdPHwj?=
 =?us-ascii?Q?dLYt4XvN5P0n0Ff7zkyvqQuyWtJyNHb/xNKIDR09zwv2rrH7thmmnnLGAl0e?=
 =?us-ascii?Q?wJqKDNobKt0tZNXembMjXIzV3rhF3cdDRwhtaYOdnCkMPU7lMZoplbDoEb0A?=
 =?us-ascii?Q?d1wy3FduKKHDfhblmpM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e88453-f842-46ea-36d6-08dbb925d7e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 15:33:58.9508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xiINJ207T+khJiIX6qvU2Uf/cqRlwoU5dnFSuuHam9IOC5tiv9D7eQw+Hqj1AZOU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036
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

[AMD Official Use Only - General]

Hi Tao,

Based on your description, I think you should use BITS_PER_TYPE() instead o=
f sizeof(), right?

Best Regards,
Kevin

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, September 19, 2023 6:10 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>; Wan=
g, Yang(Kevin) <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: change if condition for bad channel bitmap=
 update

The amdgpu_ras_eeprom_control.bad_channel_bitmap is u32 type, but the chann=
el index could be larger than 32. For the ASICs whose channel number is mor=
e than 32, the amdgpu_dpm_send_hbm_bad_channel_flag
interface is not supported, so we simply bypass channel bitmap update under=
 this condition.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 8ced4be784e0..1c4433f22f4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -616,7 +616,8 @@ amdgpu_ras_eeprom_append_table(struct amdgpu_ras_eeprom=
_control *control,
                __encode_table_record_to_buf(control, &record[i], pp);

                /* update bad channel bitmap */
-               if (!(control->bad_channel_bitmap & (1 << record[i].mem_cha=
nnel))) {
+               if ((record[i].mem_channel < sizeof(control->bad_channel_bi=
tmap)) &&
+                   !(control->bad_channel_bitmap & (1 << record[i].mem_cha=
nnel))) {
                        control->bad_channel_bitmap |=3D 1 << record[i].mem=
_channel;
                        con->update_channel_flag =3D true;
                }
@@ -969,7 +970,8 @@ int amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_con=
trol *control,
                __decode_table_record_from_buf(control, &record[i], pp);

                /* update bad channel bitmap */
-               if (!(control->bad_channel_bitmap & (1 << record[i].mem_cha=
nnel))) {
+               if ((record[i].mem_channel < sizeof(control->bad_channel_bi=
tmap)) &&
+                   !(control->bad_channel_bitmap & (1 << record[i].mem_cha=
nnel))) {
                        control->bad_channel_bitmap |=3D 1 << record[i].mem=
_channel;
                        con->update_channel_flag =3D true;
                }
--
2.35.1

