Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B46C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 06:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80CED10E849;
	Wed, 26 Feb 2025 06:01:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aVaoX9bn";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5695610E849
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 06:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tXVmqehE2Whe8f8hFJJGeSFYH5kPng0yWQEHNJO/a6O/17ZxdMojF0PU8YNbTvwrJXUJi8rqkmzubxJc91M+xuKli8Cqu+eZyQxDK/+nNgaK+EBEZPGHIXfr4gQDOeUUZLZvCozTMgY/mid55d+B/1RRSEKK6Ik46LIxb8OJKT85kH9WaNJFQcqVsNXQSr1aAD+L6io3/vV6rjJMADkC34tP31/AHb1J/NZbCdPp4J0feA7Xsl58X46Myv8QA8Alyq/FKTMHNrh/iRQ35aTp5iggC8FLU0Rq0oA+sGg+pwZynED7mH0JsUOmFhNJrqlJygjNgfs477a2CVP8ve5rbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1tIwVESy670BRMjYg+ZHD/EOSkUyWyN0+ZqDRQR+1o=;
 b=F7xr3TxiZZl+Qn1cgQ9SGfJjqBoX1JRsktV030T1KntidPi294hRZ18W4OnDn4q5c3koHwQ6EkWTpkuPp4oMZhsxExnb6j8MpL66H7duo6TLg05aVzPqBciiASfzaWYz427GLA/YtdN5/qpUHfTaVpg2gUUQ8+kkk78Jc7cPDeB/LDsat64uegxMFQqYNMpclP8NwKNM8JiqQ+qoiGeb89oDSyPcY+75l8BwdkBPvVO8OQPys72e8bAAmBW/xuAxCXEOpkyPMr0MHWtIvx4SJFhKNWlunsH+ApsDEl6RzKDP5QJXbW5aSQeJlucFyHNeq6kN3poUsOe04pUEHTip4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1tIwVESy670BRMjYg+ZHD/EOSkUyWyN0+ZqDRQR+1o=;
 b=aVaoX9bnKJjvpbHJ0C6kdyEKytQ4DRnesglDpdigxJlyX3Jru6hWTfL1BBon3JMnHrr8feXjWSzhwKxcySMpHAa3uiY8AAlNUVEv695MOgOQsDfz8hiNWodPgHGQikqnyDN1zWMTYlQ4dNWeCi/8Z9UH0ooXCmq8j/2Nfiz4x4k=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 06:01:37 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 06:01:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disable fru_id field in CPER section
Thread-Topic: [PATCH] drm/amdgpu: Disable fru_id field in CPER section
Thread-Index: AQHbiAJhuoI9UvTq/U6a34Xswnav7bNZF7CQ
Date: Wed, 26 Feb 2025 06:01:37 +0000
Message-ID: <BN9PR12MB5257B8281E5C63CC28E5D73AFCC22@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250226035548.50191-1-xiang.liu@amd.com>
In-Reply-To: <20250226035548.50191-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=daf2ccd0-998e-4b36-8c31-027d2b6653aa;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-26T06:01:19Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY5PR12MB6130:EE_
x-ms-office365-filtering-correlation-id: f3af4630-f4c4-421e-ca42-08dd562b07e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dyVZBRfZfF/WnNigH/dIV4qL/HvYpZ8iAfxMc05jq6e6+fU90szT8yF6sCJo?=
 =?us-ascii?Q?vqLtJO3rIJLqqk2IKiGkvmHTuOd+Y53ZBy8LzF2rS9DrIB9NQgmGhA0xBYPa?=
 =?us-ascii?Q?qRlUvihOwo6YPAZpzULj6RQkt8fCwzdkS4P7KFV2efxk8BLU6VLP9+bj85qv?=
 =?us-ascii?Q?785sCnT1NLgdNhW6AKUJXD+rGEX8i8fR3HRTj1Cu/9/APQrHfP7IKML349mE?=
 =?us-ascii?Q?Ry/DpSHCnFMDmpD/QRhDbI78AdB8P7Rx9iq35Sof2WcVigly/2jS/WWiW+mZ?=
 =?us-ascii?Q?yHbyVFSXG9G+C8/Xzj5V3gRiaYg0530xyzlyrbIKFLrdPfDcnZN/dVUvYTz8?=
 =?us-ascii?Q?xSusIrP3lDclS5lixBtTZaXVS4ZdNjzKOXFYE53ItMvW1Sx3u2RDkx6/on1Z?=
 =?us-ascii?Q?+Q5VveaZjXRRe1khFkx11WwQ3iv1gsaaOsvCNtMAO93Gonu+U7XBjWdkDfpB?=
 =?us-ascii?Q?0ovJWJSK15v6edwfNwmz8tWbPgxWBWRJPjbkONATUuMs3oBTShrIWtvhW39b?=
 =?us-ascii?Q?3lGIQxijbqWCx45r5GY1fDmwwWW//0qt5OqdXw2Pj1xUX47qa39WY7ZXEUeI?=
 =?us-ascii?Q?v1nYdT9rrkZfARthzayDGxxH6rwIeq9oeeMFUgMsAQYkZ0PT2ZGi+B+vXo2i?=
 =?us-ascii?Q?/AovGxSbtHoxxEg42keC6lJ4Tpew9B6YRFAtqFYzTm8KcBW4rYsrpu6DQjOg?=
 =?us-ascii?Q?3vw0+B7ZMmKwCbRIntjCZXl00hcxx/ia26pRenYPkTMI6dpxvexZNROMiuZi?=
 =?us-ascii?Q?0ZkkqbZFJn0yfNIYsoavi8sGHDTF46eXDgVkhSyQQX/vvJf4GPOIuzaApK+7?=
 =?us-ascii?Q?mP21kNBmAcUuLjiSxj7D+LhxdzUGCdOcZR/n723rByNofL6Dzo0tiTHc1Lt5?=
 =?us-ascii?Q?Hsj10H4dJOt09eeGpMLRSfPNlv/EnR0EGlZCJP34egSlljfEdQGhNB0ie5Y4?=
 =?us-ascii?Q?PeDmOLVr9iKdpWP/+GD8XS2K0y5oC1nwP5k07D2INdH6lCN7r6Nf/CoZG2Ms?=
 =?us-ascii?Q?gYHv12NLfld9tlDFFWI5lFPVprLDB2ZIDG4CJwryHwuifhsAUJyCA1x9G3Wd?=
 =?us-ascii?Q?I/HiSiC7t+umuQGWsqW24G5oGveQOWkxC2rL6y9Nv+wJTGDfLpnH76IZcioR?=
 =?us-ascii?Q?Hk9xFYIdb7w9gtKavhqMQLL9Ba6FAv4Vuw9mW1GNsoDw911ecmCSb66ISKnx?=
 =?us-ascii?Q?ZgEgwDtwxHNFRwr7Y4ks11c59/Tbt5Lhlw6iIDqUgbo2CIfLBZY+zlGRfqm0?=
 =?us-ascii?Q?35eWlo9MnuqYiPmUIfw7tH88CwszFHH3l3W+xOdI0RrtJoqBFT2C6bFUsfVG?=
 =?us-ascii?Q?idRRtMasSmX1lNDRaiosBuopAoc46WoXK01ZUQmH4YwWYaR255AzvSntgT/Y?=
 =?us-ascii?Q?VAK5dOc7jiVn8qIltZeQ6W9VvJ/dhGxpJZhU2KdYnqLs74h1aXI0YicWEhtG?=
 =?us-ascii?Q?a80qfF40XMsOsO7nwVexVpOzn5FR4uFH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wZCSJlpI0SitFod1Rqck+Elz3ER/2nS87wqNm0yERpTBLcYlFK2+m7B+YDjK?=
 =?us-ascii?Q?7QHza69KP65GrWSWXzajnQdi8O5tfx1KgC307WplOrNzbYVXFHVezGRoAJa8?=
 =?us-ascii?Q?W1Edn8XdkMUXVBZMVNlOaDE2qwqw6zJa1QbVO/fmg5kfWoPbZw6NwQSOIshM?=
 =?us-ascii?Q?lucsyOF1ptaWEfTf+ZDPGVRFCy98bkv7JAW8bc15EYIu6XFE2ITCzVBvlagZ?=
 =?us-ascii?Q?aXlJqstJgE6F+W5Nx3wXweV59KOWgobRRqwr3mjeHOWbjHE35mz9jbVU5PCo?=
 =?us-ascii?Q?rTWAqcBGcC/4ttZIEmInkr8VGtR3XASOAhRy/F69Z3RJvlWz5Du2WEmjjlCb?=
 =?us-ascii?Q?7wPjifFaHJ8yXo7iklZj7QaDX9LPdZXy48IOtEWVgwjCpvStvpyErORuGpBP?=
 =?us-ascii?Q?WD2z7XYovh4RD3XGjMC0c++1DtfUVXq9UuDn8ktX6mlthGSXkpWYYNZhPT86?=
 =?us-ascii?Q?xTTM0xrK+Ik8TvDnWk03g3BSzxdxXGeNo4hu6v0D/RB+x7WGzwI8hwTzo2fw?=
 =?us-ascii?Q?AAXyzC16oZf/aavGffdPssc0Fmmb1KnnXLor0mamXf9THSwqz4OSNp44F8uB?=
 =?us-ascii?Q?lJCaCf3UcB3g12PuVe/Dx3MbjxJ7kXiuzSb/pFvgkrCIJu6i5Tsu+XFRtuCc?=
 =?us-ascii?Q?Zgvi3a+X/2iYhR5HOhNXQqEGJVAlBuh09MN9URHjW0OCacIuHkkx0MYTY4RF?=
 =?us-ascii?Q?J/qCly7mCA1HO8WHkwT+C33F5rbUpw++cpESfjHyd3fpr/3HDzzgKANYZoHl?=
 =?us-ascii?Q?wed8uiAyNpSMJCg+BDqE+bL0u9VFylGq8TTXCHWTirsGCcEZg8LmwHyhLkHW?=
 =?us-ascii?Q?NKYpDXNJGB+gldMoBElIIg29LP7CmBwS/TKOTkCtY6ZePEo9mNidTjVZR3FT?=
 =?us-ascii?Q?BcsPcYMvZzpBWLOttD0ozImf9E1PxFfcrMuZV9gutKPsNnF+S7mDYOrGTitn?=
 =?us-ascii?Q?gOIH1WKSqxpNmr4OjeaSNf9U21VzwduoP6N2tBDCYJ44PFxLeB+qMZdLDpri?=
 =?us-ascii?Q?Ky3KES90tJqs7E6UJrEpUaQqTkAT6CiUfEidOG9BB3bF6yc9BzB1XSZwzNux?=
 =?us-ascii?Q?/ZODdgoSXsi3PPnYIleok5Mxg9E7p+MYohYEUXCkEi3CI1YKhx7hRfNjHEwv?=
 =?us-ascii?Q?SbulVdEiWVrTIsKEcb333QZg3o3usrycCpHo2Zfd0fz9wZ/MJUp9CDNrz9N5?=
 =?us-ascii?Q?vF7AzjElcAJ0TaVlV73nLl5KVebS+VrY7EZfOqrwHzjGk7rBDnmmAn0vunKl?=
 =?us-ascii?Q?V9PXKyFwXodduObfpg56gPA0uzMgZFDXCHPV4KvPoep+2umWqDqv2lPBkPCh?=
 =?us-ascii?Q?qDcoDh6DpqxXSoew/fPjSpIDIFntisBCrdfwXQAYnjTu61PPkIRJ4rLRb5F3?=
 =?us-ascii?Q?H3NgNxh9HAnVooyEfVVBE07Qn9vttlNEQz2J1JgxlELv9swYT3tXXt9PdzMN?=
 =?us-ascii?Q?F+ztt34qgU+66/0mhwvN4UTo5nBKU7WQ+omEWKL3sS253XKKe2yDBDqwbb/0?=
 =?us-ascii?Q?mJvWliAvutQnHgNuIwa4Ng7TFUPKkpv80Xk9edqcdxYC99GjmVeKiPb+lI1Q?=
 =?us-ascii?Q?wluopCfey3iYD5juxqc+GZeJBfSKGe5JQ/2W4ABp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3af4630-f4c4-421e-ca42-08dd562b07e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 06:01:37.1947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNHYudARk03iKeJAcl6CbFvECjSRxADQlBeLkKWtS8L1J9plf3o5o8sN/AgSRyb05rKqvSWQDhPOh7a1EAGYVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Wednesday, February 26, 2025 11:56
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Disable fru_id field in CPER section

The fru_id field is disabled cause of mis-matching defination between CPER =
spec and driver.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cper.c
index 5b6bdabb8012..0b288deb9b19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -112,7 +112,6 @@ static int amdgpu_cper_entry_fill_section_desc(struct a=
mdgpu_device *adev,
        section_desc->revision_major            =3D CPER_SEC_MAJOR_REV_22;
        section_desc->sec_offset                =3D section_offset;
        section_desc->sec_length                =3D section_length;
-       section_desc->valid_bits.fru_id         =3D 1;
        section_desc->valid_bits.fru_text       =3D 1;
        section_desc->flag_bits.primary         =3D 1;
        section_desc->severity                  =3D sev;
@@ -122,8 +121,6 @@ static int amdgpu_cper_entry_fill_section_desc(struct a=
mdgpu_device *adev,
            adev->smuio.funcs->get_socket_id)
                snprintf(section_desc->fru_text, 20, "OAM%d",
                         adev->smuio.funcs->get_socket_id(adev));
-       /* TODO: fru_id is 16 bytes in CPER spec, but driver defines it as =
20 bytes */
-       snprintf(section_desc->fru_id, 16, "%llx", adev->unique_id);

        if (bp_threshold)
                section_desc->flag_bits.exceed_err_threshold =3D 1; @@ -376=
,7 +373,7 @@ int amdgpu_cper_generate_ce_records(struct amdgpu_device *adev=
,

        amdgpu_cper_entry_fill_hdr(adev, corrected, AMDGPU_CPER_TYPE_RUNTIM=
E, sev);

-       /* Combine CE and UE in cper record */
+       /* Combine CE and DE in cper record */
        list_for_each_entry(node, &banks->list, node) {
                bank =3D &node->bank;
                reg_data[CPER_ACA_REG_CTL_LO]    =3D lower_32_bits(bank->re=
gs[ACA_REG_IDX_CTL]);
--
2.34.1

