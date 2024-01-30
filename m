Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59915C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 05:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5EDC112D99;
	Tue, 30 Jan 2024 05:12:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F1AC112D99
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 05:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVA6E6OV2Fml6QTyuaKp2Ox5MagnEwywzScy8YYWLm0J/LWswilhDMmHoLg23ta60qYCmo3Jt9EyxROd5bv+qL6l3UV8Hs1gzVYD9fJvxlXcW6m4i3xly7AQUu0D6qXc3IOPKKaTTY1xZAPIWMARPNzZzpSQQ9q1aeCkFZvTXWzikKMwlyIlZny0UDKOpBRVGH5nFmVleH5L9Sr/ODE4+5shEIM9pRVrAqbvjtttPK3qe46RhTooNFwuaZNa5FrLMs1eMQcu7QgnCdKFh3nLtymeu1f+McplTUIl7j9QhQJ3KOpFu741EKVLlLFDcu7bwf97klWKvg9lbTatJmDfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1khPgdFpwfFrxX4+L6F2mFkFvR4mteXxSFl7Sxv87gA=;
 b=IGiXyYuvCCW8EF17oeoVxTrT76G2g3rSiQ+gswqZjwbghSOIOgJeS0830LdOQJU3Nb6wLpCVL4OLbtJMatQQNE5/ZfIKryHvKOleuIJHKW12CPeA67G6rm//eIZNWHm2R27oQYyMJM8WA8/nUzRCj+zWAe/HQodzMeuouA+jKCHu8vl95QO3vST3RFYMBdQpEEh7kLpttJKWOKo7cpdn+hKY8JswTX5PO7vIZ+2mHzRZm9fSh80Zed7WfQ9teUwInwvRLUfDx7q1fc8oG8S6lJIJNmty1YQ33rQ6GRdCtsD5iamRckx+HNkU6w0+V9vlXANyhg6jX8E5QQSY0vAb1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1khPgdFpwfFrxX4+L6F2mFkFvR4mteXxSFl7Sxv87gA=;
 b=MkqIapTA/kGaOuMnUcFVPD5E0PL12CkqFDtmPDbO+P2kuWbRn1S+eaOTw6J5w8rt4JQ/r5bTDTGP8UokkHsw1ERXvwv6glW8PY3xGvzeQCoEJ+mqzjTvwfjypaLee4UiS+e9IRkXfxQrXbyOP9FTIDH47D8JGdHgbFLhYmHm4Wg=
Received: from IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5)
 by BN9PR12MB5067.namprd12.prod.outlook.com (2603:10b6:408:134::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 05:12:48 +0000
Received: from IA1PR12MB6356.namprd12.prod.outlook.com
 ([fe80::79cf:ba33:6895:33fa]) by IA1PR12MB6356.namprd12.prod.outlook.com
 ([fe80::79cf:ba33:6895:33fa%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 05:12:48 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove golden setting for gfx 11.5.0
Thread-Topic: [PATCH] drm/amdgpu: remove golden setting for gfx 11.5.0
Thread-Index: AQHaUpKVTUulKoYppEm5hIOxqunqCLDxmFWAgAA4P+A=
Date: Tue, 30 Jan 2024 05:12:48 +0000
Message-ID: <IA1PR12MB6356752E2CCC27D93A2F3BAAC17D2@IA1PR12MB6356.namprd12.prod.outlook.com>
References: <20240129090611.2716545-1-yifan1.zhang@amd.com>
 <MW6PR12MB88988E86CA0A49E7E5D8248DFB7D2@MW6PR12MB8898.namprd12.prod.outlook.com>
In-Reply-To: <MW6PR12MB88988E86CA0A49E7E5D8248DFB7D2@MW6PR12MB8898.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9324b9b2-eff4-479d-bb86-169d0527fb84;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-30T01:47:49Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6356:EE_|BN9PR12MB5067:EE_
x-ms-office365-filtering-correlation-id: 80e12efb-998e-4bbb-c1d7-08dc215219ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XmyxZm/R4RWzppamYVW21ysieojSuxcSNbfgikfBiSB4xUZH8xn3cD43gkWmmHW/NXkyrtNZz22WPrqPcNAeM2ekfuYKBXmqdP+Ff9+RebqpKWAUSa2IxhjH3eBkkC416AzDAFxoNRd5ezo7hhL0XxfqefwmUH8PSRZEJqfMstLuilubn3aoDwujbqSUQxzUBWNrKVjVuE0gnZrqMJ9z8NDnoqmsBh6W8118uqX4tdN/Ti++/Raq1KnGIRWdJUFqex9qoVfTElCFFFigU5DSUnq+Zl/jGTdyxMhqaGxYNHcQqdluI6ikFvIs+N3FrMfXcamdNDle76lG5JVCiPbrR+RRDHr/NzcDp2AT1/NCNdomR7pRhpxf1Vx2i4/zugLlpsbT4Riq6HawNu8ZN6cxWPJjfGbHA0f80WlC995hH2fuIIkD4MRsXXq7VP4ScouaZ8DBWHv8+4uOqY4ukO8bW0fHDRQZb72Mdp8wpd8mWsMoDATbHGIlCQhra+tNlFk+hZRaGPlo/k2WYKbhQy2Vwv63THzPY+41bpGidt5l0YjefLp8QjDyaBurqfuyhQEkroigaS9g6AlzzJtNHlBXhpe2GjN5GNxqp1SS0MPS+K23KZfXD+Eqo+iaKRXXbz1z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(396003)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(5660300002)(33656002)(122000001)(38100700002)(8936002)(83380400001)(86362001)(41300700001)(478600001)(4326008)(64756008)(52536014)(110136005)(76116006)(66946007)(66476007)(66446008)(7696005)(9686003)(6506007)(71200400001)(316002)(53546011)(66556008)(8676002)(54906003)(2906002)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ccu9Dkh9CilIfHSjaCHz3jaGmH4wCVQaIYoySQLv9UG/7eHy5vQQ1aiDGqVf?=
 =?us-ascii?Q?1nXtOx1x1gjhNyFgX74VTG9FryYaQuteJV48Qyjsz6Y2h5Uyw4H6pUUdVKfX?=
 =?us-ascii?Q?CVn9LFbx88ONXJxNt5nzus/DhlUmtjPEERk74BMqB8SjzhhKxsixU9/BxU3S?=
 =?us-ascii?Q?m6K7LHuvT19zGr77zkF9/pSZfUgSQC3SCmYa8JmD0+LlVkI1wnQBsibEF8iu?=
 =?us-ascii?Q?JN3RuasALvQ1gUW/lsHU1Mw4cuU6bpHOkZc82yCv7DqMl/Nqvyx5R91bV9aQ?=
 =?us-ascii?Q?7TRnDQz/RnqEqlsL8vIGcxDmuFob0U0CA/be+Wr5Z/voCat/Mtt6nSRmoygo?=
 =?us-ascii?Q?DxczqYOUARR+gxFdS6T9RU898JEAlvdK37QUdNmP6wjHwq56J5SUMXC1kWSx?=
 =?us-ascii?Q?G+vDOsY84KzgSmCTn6MgcxRfYa9+sxazKsLipNshdvVXnJfUYSze/PwbGt5W?=
 =?us-ascii?Q?tFxO5sDnVqA+OnN/OGjjPUEZM/Sw17LJymwlDB7hyHRW37fATETQOVf692Ic?=
 =?us-ascii?Q?BKApzIOGY14g1lK6pLsu2W/loBrH9d6xmerIRGPMImUq6XJpmgHi2hYLeI0m?=
 =?us-ascii?Q?llPR02tw21bbM5ZhXYLxT8IAovyaoNg2bHWEg1ZjfqcPZwQrARtfSmeJ8x8z?=
 =?us-ascii?Q?gZfAZfibg1atCNauOhRLfBbH6PwlxMH1+uCK/exXH9AzDtxt8UL4/cNr8ozt?=
 =?us-ascii?Q?ZxYKEKkX+MFB5BXpNtLgss1HD8DQQD6ENf5MsouHBw8n02AxBrgIVXMKgvQA?=
 =?us-ascii?Q?/bqWNx3ng3+/zU1ka9u37ZoQaOZ9hOJDoAw72Yw0BjtFB1lyefnhDNzi6qH1?=
 =?us-ascii?Q?RL5h7yuDNWUSX7ZZBK441KsBJ60rz5fUwO6JQ8OR244s4Or87gMCegdruZG7?=
 =?us-ascii?Q?adUelE1Jx4A8qKcJ9coxO8tFc56K5lbLrlD4+TfDGZatNKgtxK6Qe2B2d9qW?=
 =?us-ascii?Q?psXCyCYWk2ZlM9o1qAy4fEu/eEeB6xpuXN4RgfIHZKhbpKHgiPP+Ec7nSx+q?=
 =?us-ascii?Q?7T1VnAr8T4PHR8yifl/rZyNqWx8XUumNqnfbF+Gxd9pY7X5xIw2n6RERoVnT?=
 =?us-ascii?Q?wPCPu6j768wMlj61cnxLNybmddQqVDtw3rG2MtYAThbaBPZsswVMJfFc+k2t?=
 =?us-ascii?Q?pQyyT15lDKsYkQf4nK9s5U+aHmMawcs7BE+uBM+KRosj6+4C7cQ05gRpMPFB?=
 =?us-ascii?Q?IEihpxE/37Fwc55Z80WbuD7VQ1zcmvlvmkDeFoBmwBKf4kNCwV/wg3eM0ckc?=
 =?us-ascii?Q?DxIcHTm/1/T7MCk5XLq82mkyRPdP3rtFkBO6uTuWHOC9oGwd/tUvhO26ShpC?=
 =?us-ascii?Q?NwnmSd+rCFnz6Sv3zlvFyCSG5gPSq++NUhWU5mty7xYW2XHx6I7ea8Vw4fcy?=
 =?us-ascii?Q?inZt2N99W1tGoxnBwfqvU2p+NOPGF8v722QrAgBm+GpYMHKiGjcvTQyLKBzG?=
 =?us-ascii?Q?sRE7VS9vQ0CWkMJ54xIh6JpvoXiiKZ4mph6+q8oZ+DD74ptLn179cpJYyEbY?=
 =?us-ascii?Q?3Tnldc66Y+pH21/rIXnO7RBLHiaU3q33V/GaZuhWzC0jSUWDG1C82Se7+9gm?=
 =?us-ascii?Q?+od//HkzhFZexSrf0wk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e12efb-998e-4bbb-c1d7-08dc215219ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 05:12:48.5805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ImrtdIH7Iq4TMenAsd26IGV4w8E/3+W90eIbCbfdEwcs6xastNTnEwGd4I5+8X5/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5067
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Thanks for catching this. Will update in V2.

Best Regards,
Yifan

-----Original Message-----
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Tuesday, January 30, 2024 9:51 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: remove golden setting for gfx 11.5.0

[Public]

>-----Original Message-----
>From: Zhang, Yifan <Yifan1.Zhang@amd.com>
>Sent: Monday, January 29, 2024 5:06 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Yu, Lang
><Lang.Yu@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
>Subject: [PATCH] drm/amdgpu: remove golden setting for gfx 11.5.0
>
>No need to set golden settings in driver from gfx 11.5.0 onwards
>
>Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 32 ++------------------------
> 1 file changed, 2 insertions(+), 30 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>index c1e000010760..4e99af904e04 100644
>--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>@@ -90,10 +90,6 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_0_me.bin");
> MODULE_FIRMWARE("amdgpu/gc_11_5_0_mec.bin");
> MODULE_FIRMWARE("amdgpu/gc_11_5_0_rlc.bin");
>
>-static const struct soc15_reg_golden golden_settings_gc_11_0[] =3D {
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL, 0x20000000,
>0x20000000)
>-};
>-
> static const struct soc15_reg_golden golden_settings_gc_11_0_1[] =3D  {
>       SOC15_REG_GOLDEN_VALUE(GC, 0, regCGTT_GS_NGG_CLK_CTRL,
>0x9fff8fff, 0x00000010), @@ -104,24 +100,8 @@ static const struct
>soc15_reg_golden golden_settings_gc_11_0_1[] =3D
>       SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_SC_ENHANCE_3, 0xfffffffd,
>0x00000008),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_SC_VRS_SURFACE_CNTL_1,
>0xfff891ff, 0x55480100),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL_AUX, 0xf7f7ffff,
>0x01030000),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xfcffffff,
>0x0000000a)
>-};
>-
>-static const struct soc15_reg_golden golden_settings_gc_11_5_0[] =3D {
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regDB_DEBUG5, 0xffffffff,
>0x00000800),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGB_ADDR_CONFIG, 0x0c1807ff,
>0x00000242),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGCR_GENERAL_CNTL, 0x1ff1ffff,
>0x00000500),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2A_ADDR_MATCH_MASK,
>0xffffffff, 0xfffffff3),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_ADDR_MATCH_MASK,
>0xffffffff, 0xfffffff3),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL, 0xffffffff, 0xf37fff3f)=
,
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL3, 0xfffffffb,
>0x00f40188),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regGL2C_CTRL4, 0xf0ffffff,
>0x80009007),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regPA_CL_ENHANCE, 0xf1ffffff,
>0x00880007),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regPC_CONFIG_CNTL_1, 0xffffffff,
>0x00010000),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL_AUX, 0xf7f7ffff,
>0x01030000),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regTA_CNTL2, 0x007f0000,
>0x00000000),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xffcfffff,
>0x0000200a),
>-      SOC15_REG_GOLDEN_VALUE(GC, 0, regUTCL1_CTRL_2, 0xffffffff,
>0x0000048f)
>+      SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL2, 0xfcffffff,
>0x0000000a),
>+      SOC15_REG_GOLDEN_VALUE(GC, 0, regTCP_CNTL, 0x20000000,
>0x20000000)
> };
>
> #define DEFAULT_SH_MEM_CONFIG \
>@@ -304,17 +284,9 @@ static void gfx_v11_0_init_golden_registers(struct
>amdgpu_device *adev)
>                                               golden_settings_gc_11_0_1,
>                                               (const
>u32)ARRAY_SIZE(golden_settings_gc_11_0_1));
>               break;
>-      case IP_VERSION(11, 5, 0):
>-              soc15_program_register_sequence(adev,
>-                                              golden_settings_gc_11_5_0,
>-                                              (const
>u32)ARRAY_SIZE(golden_settings_gc_11_5_0));
>-              break;
>       default:
>               break;
>       }
>-      soc15_program_register_sequence(adev,
>-                                      golden_settings_gc_11_0,
>-                                      (const
>u32)ARRAY_SIZE(golden_settings_gc_11_0));
>

Remove golden_settings_gc_11_0 may affect all gfx11 ASICs.

Regards,
Lang

> }
>
>--
>2.37.3


