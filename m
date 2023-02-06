Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E49FC636D3
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 19:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1897D10E188;
	Mon,  6 Feb 2023 19:58:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E26810E188
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 19:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1EGA5V5bMyGYt9afIqx19yJcg8w7xqjLxoytyZqeGQ94EBqjJO8wdOdUKdTQBi+Vcjj7OiZ2ZZt/JjIllZ204GlmNg73U05HIeXSC2Je4XMCytC9k4c4f1z2qA5Cx6MA7doyov6i7GiFgm8EAt0GBl/KHlTCLUe48m9ePMu6O0aG0sNaGHgp/uayoEW1eX0n5VXegJbMISHq3tHVMtEAquTaN4CO8j5gy4WjoBsw/GK/3l83k93n/sQ+HBz/U89q0Xey898ujQflBMEnz88PWlsqj+QYE38MM4jsIVqxT9iUGGLICphf/toJKQG3krmylCFvCJqdk/d4r769GhuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kM7+0HD2lYPw/bX4QiISm5qkWliPXcfgSim9iqe4os4=;
 b=fF1fw2Cgi3HyREifjcztqFko/0b2kDyWxbfqAQ6nYtTjjy57QOCsLeqny9Q1sC/FRdmbuJbp8kpx86FEgz68DJttV7NFC7Xp8VfKAR3fwg+SLDC77FILDKxwFlDwr3EEZqvWfORO3U1gKtD6YeaPc9sqangcwBrv5sEo2/l35GCDfHBl69rAZs0UCuIk6utAZV3y0xOLs7FLgrmv9VS75fDjJVTLolDWhuTt61nXEKDqFezWXkExi4e7QY7ZUo1zXyoAlJmkLSm3l39KtkQWWq+Q09GnqVUos3xf74EpZh0Gn3nMgcfWF42GnJ8arL0JgIy4ClJ50wDCDz553PHJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM7+0HD2lYPw/bX4QiISm5qkWliPXcfgSim9iqe4os4=;
 b=GkLM0zxz/t5e3z7xeZd6yF7Y7qiFOunHH44jSA0pRhvEY7Zl+YOJZ4gG1kiVHJvNOl+Yyh1dac9uuXHSmV0zn6iAiC/uUW05Au5Xj6mcAWoOnaDh7FeCFB8dvKlvnbgh6WJN7wa6sa3hGpmmQ6J4U2W/2p+nvU9bO/HUaW6cfdk=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 19:58:36 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::e053:4a0a:80a9:32d3]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::e053:4a0a:80a9:32d3%5]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 19:58:36 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Fix incorrect filenames in sysfs comments
Thread-Topic: [PATCH 1/2] drm/amdgpu: Fix incorrect filenames in sysfs comments
Thread-Index: AQHZOlAazhtpPt4oLUijtwn+jNeZpa7CVgVA
Date: Mon, 6 Feb 2023 19:58:36 +0000
Message-ID: <CY8PR12MB7099223BD9E7FAC4454F25CF8CDA9@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20230206172537.2320224-1-kent.russell@amd.com>
In-Reply-To: <20230206172537.2320224-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-06T19:58:34Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=557b1a4a-26aa-4a3c-84c0-1d9caa827fd5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|SJ0PR12MB7081:EE_
x-ms-office365-filtering-correlation-id: 88b986f8-3231-481c-fd13-08db087c88cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tqcnh1rTiKkYXbAb4nvIdLLVPX8Fni/u2OdCCK5pIU0sDki2Nbth5HlnrgIG+sItJdl5hK4tEYv6SbtZweEfOEp8sec9n3sy9rvsu6r+sezeoIQfjy9g/MUAQZ2eOZ+jjKaND8u9p25VoHQBPEJzflqqVMu420D30Iai06fSZYDi49LvIHggaZk3W7U4V89Q5JLa8yH7mtotq3QA2pJXU/aItbEi0pj7k+UrhOTVVH5vDtlvjy6e6eX6nsTKP0hB3CyNZmFR9tqNu8bYNZ0dxLXpcTewdDWdo5wH3QgjmV16J/k6Cs4zUZZwbPDvHZTR3/izLWbl847Tmwxi+7nk6v6kA9u5KrYld5lawbR3VgZFmM9qe2g3HHn5T2uo1D1bjhwFO0jZA6/VxG6SuFXsAR3AeQNarLFznrLaUPD5b2M+OMvA5DgmHLB6hoTvOcfxtByiFRGRB0ToGYnS2wingOljmlJ9q/v2VfNkT4SlLiNGZNpVyAFacJRVbhxrUPjhxSHhPTaBLLkaG8s7eVq8rFRJYG5PMYuaG/dYT8TLRXhKY0FuDmaHXb7bqQlNlFN1sFwNSElQ30SSau2e72UhN/O5/ggEdmpgwDDv7Ka3kdCLSFK12ojgxHEzSvJMZdBNiDRX7uEXIW/bLGKHLammE8B89n5ntiVVSI91YD9GoBqjHECujOQbmkG51XKap1W2PYlE0fVb/Qg6v23hVCfDQw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199018)(38100700002)(478600001)(64756008)(76116006)(122000001)(66946007)(8676002)(66556008)(41300700001)(66446008)(4326008)(83380400001)(110136005)(316002)(66476007)(6506007)(186003)(53546011)(9686003)(5660300002)(33656002)(26005)(71200400001)(38070700005)(7696005)(8936002)(52536014)(55016003)(86362001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GlBM9io3NaGVNtNXMf8SMgNL/vjO+JePN9M5bzyU5b3iXcM/n3jx1hREbe4V?=
 =?us-ascii?Q?b/jz/+X0vB9Tx+xu4Vi5gR6RZEPHE0AjoLxMolvQkofL/YeAOCtiHLj/Voeq?=
 =?us-ascii?Q?BqYKjlILZm0kV+d0fvqqgPYKRPyJzUKFxDPpkJsa7QTxH2XBGNAd6fXmzESv?=
 =?us-ascii?Q?K61nv61zcnSDR3eUGuj4Jbuar0i0cQgEtc+Lt+qNFh+YKoy0oRW2M4UfCLmP?=
 =?us-ascii?Q?pQ/Kn2ybLYN/CJPGY+x5E9gzXW4a4DmAMnSl6DEmvUVCtNwb27ikyNN0+MM0?=
 =?us-ascii?Q?fgZiXC+EFz1b2PIuTfopElXiZ5IEogF3ufU/KitNDtHzN9r3Lv3z1PG8fpIj?=
 =?us-ascii?Q?tkXKT7HCE9JZwnZiNfcDh8q8oJcjmtNICtzViALFS9tVnoKq/Y1F+dcoKSId?=
 =?us-ascii?Q?gxb4GcjyXqagNZKpiXehaL2Ps2UzWhfW+MdV73A67HDEpQq+W0eVNsM3NE1l?=
 =?us-ascii?Q?WTO7C7Wwh+vXlgXNeNyAOkFk7OWnO2JNjaeRddBJVfWRIiVZJC8B1y7QxQb/?=
 =?us-ascii?Q?JRDaKfV6TzwA9msqbEVdOOij863ukCBNg/iMnIER77uxSm489dSXsPTPBX4w?=
 =?us-ascii?Q?6yWo+/EPYoRDspTGNnUm4UkqjVEkRBdpVPhwIArsqe0wuSe3p+PCGA6g3w/9?=
 =?us-ascii?Q?3GU9B4d17Fe9HtM+Z252t8D5A5eROREMFXI/714/qsX1YbeY9ac3qW46piPx?=
 =?us-ascii?Q?LLF37Hoo4PWQtSHcnAOLtDsejuFVTPTODJjuLo9HxmWTNv9kOxZ2kREkp06l?=
 =?us-ascii?Q?xkRlCOObVvkgWAfPCyGHgjqTZPzzQG7RYv6y7H8sNc4H66YvqdxrvtOh9P7W?=
 =?us-ascii?Q?e2Bmf8Fw42VvAiryhDIbpqJnXH9KyA3Ngfmwv41Ewd1kOsJaJm82gl8DBbm+?=
 =?us-ascii?Q?hdXfSyoq+TZtTfFr0lPqYuFWuDBMWIppjyx4S1Ntz/Xbg04xz6fWJ5CsOWCr?=
 =?us-ascii?Q?W5LaUwpa92tl0IuEyMpPgiWZ/3pZShv7oKUYaPDZLadNSQiO8YHUy660ccIZ?=
 =?us-ascii?Q?+4ESUUs0mKnfkHf0LLUMI0NLxF6YO04o3INF/OhUZAhVVzPzJE0hmFEOSvkB?=
 =?us-ascii?Q?O4+jr0BWHrs0VGFPimnL0UEbig7ry2FVEJol8XR4oJsi6DwM5xVVkPLDdJbR?=
 =?us-ascii?Q?SaB8DbauJK/cQQ/ysPLmATnhscTd44o6sgQJpcQUX/Vy1tlWg7FiwCCvbyl3?=
 =?us-ascii?Q?sOegDzGV4sF4gxYvqFQElUDQU+/iVtEWUDQoKPni2h9dNvFrxzMQ4ssn3cl5?=
 =?us-ascii?Q?LLYi3fqL1bkGUOpjHD/6jzqPAzoQZ+gBY4lmhqn3OJjL45iYaFfk5etIrz9L?=
 =?us-ascii?Q?oicqG7ZlRyb/KSIWJitDWfHEJgLsseGgrNMpjGU07To9AfXmH3LdFBZrU82U?=
 =?us-ascii?Q?axQXM/CYNtkqtNYf3tSuHNe4V6wj6NpblpBm/1+31FUUhCd2AvyaECC6LmWu?=
 =?us-ascii?Q?wfxnhACjGf9LrBKARJytleqfQngsLG28Rnl6zjvdwgzK68X9c8GoLmpN42Rt?=
 =?us-ascii?Q?hv3km3acqog+Lt0we+eMpwpNkovdbwCsguaehlyYwT05U05rY1HgfV6P575z?=
 =?us-ascii?Q?T57c0Sdjnowhj6c86+o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b986f8-3231-481c-fd13-08db087c88cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 19:58:36.7199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DeTn4rVAVzaINwZb1XqbxK1S58ZtQQ1TfbPf87n1BdJM3hvAdN2cHiQzb1VW9mK1sGhSbM45AZhA9q7h9Bv97Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This series Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd=
.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of kent.rus=
sell@amd.com
Sent: Monday, February 6, 2023 12:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Fix incorrect filenames in sysfs comments

This looks like a standard copy/paste mistake. Replace the incorrect
serial_number references with product_name and product_model

Signed-off-by: kent.russell@amd.com <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index a10b627c8357..5a97021bbb23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -162,7 +162,7 @@ static void amdgpu_device_get_pcie_info(struct amdgpu_d=
evice *adev);
  *
  * The amdgpu driver provides a sysfs API for reporting the product name
  * for the device
- * The file serial_number is used for this and returns the product name
+ * The file product_name is used for this and returns the product name
  * as returned from the FRU.
  * NOTE: This is only available for certain server cards
  */
@@ -184,7 +184,7 @@ static DEVICE_ATTR(product_name, S_IRUGO,
  *
  * The amdgpu driver provides a sysfs API for reporting the part number
  * for the device
- * The file serial_number is used for this and returns the part number
+ * The file product_number is used for this and returns the part number
  * as returned from the FRU.
  * NOTE: This is only available for certain server cards
  */
--=20
2.34.1
