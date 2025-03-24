Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214D4C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 09:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F0F10E081;
	Mon, 24 Mar 2025 09:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bXeELIvA";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E89D010E081
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 09:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlVxwROEKvnui5LI+VqCUbsMqZVLXY/sE8nRf0ARn1MIkn/x4D9Ec8XIOD2lr/yYvb7boPsmGuhhRqYlEIF3+/JHEmgCE7YZyw2Sk9hxhHArgEYBgzbFisMKz1+WR3JV8R0aOLYu1+pi/o50q8kNDRr/Icha3LSvOf5jyG9hljhSWNXf57gwv+yOH7+0HjLowVS68Ewn2urlDO8p3uJAJ9Hg9RhmP0uQYeP4uVBERbECFju1HiUM0hNVQ7QUyMph/ZU1X6y1SpIFThnE0GkVPa1GVvGiOTw514pIqJyB3HhhRwouehaUsVCwYTXvRsYCzEwa9SNLKFg1bCIvkaNLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/CGaxUoT0iutyGSVEbg6aTCsniPZXcLfcigq5rxQcM=;
 b=osz/DEWll6Th3xXZrtbAL71eDw5isML0aQVXvPEpS+kZpTJr1Zw+iphS1AcQzE+xU9YgKeDA78HbIxUSLHSuEqhFmkWamPXxSXQZU6fIV2bGzlCn5HwvHc4JYoJjd2OjonEmvZZvTia42UDqkqxkqH3eZ4sLw+eW1p7/lmYvj8epbPG516AklHaeZVnhHxRdmIIIdO2M3aSo3yT7+eBLmhjpRukU5L69YeGhv5rtbcj4Sw9Z8NsM5MCRCs5Du8fLBcRiMP4KITsSDxcNcO3jbhYTto3yIqyFkS5vRWG+hZOaHI4cWssi6mqQDwy+rtrAYocoYy1xuj/jMX25n5NZ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/CGaxUoT0iutyGSVEbg6aTCsniPZXcLfcigq5rxQcM=;
 b=bXeELIvAVqvTZVpYWeGQ2V5wCxsIGeuKLTnhBh3MjPe2w+2el+fQLbyWO6ebcYtiZ3twBbrTJeb8f3dnA2KP6ge/VFNwCsGefjnAxICEbvQD3EBU7ks0F3R3ilf0A1Jrzwif8eqB2rit5shSs6KRM1xuLayN8G89HdeRsmacf0I=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Mon, 24 Mar 2025 09:17:55 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:17:53 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add NPS2 to DPX compatible mode
Thread-Topic: [PATCH] drm/amdgpu: Add NPS2 to DPX compatible mode
Thread-Index: AQHbnJKbKqxhlikaHE+Vit4X4xgpbLOCAg4w
Date: Mon, 24 Mar 2025 09:17:53 +0000
Message-ID: <DS7PR12MB607142CF48211501D0BD63DF8EA42@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250324075833.382787-1-lijo.lazar@amd.com>
In-Reply-To: <20250324075833.382787-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d2c54dbe-f1ee-4db0-9b57-f6e3c13720cc;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-24T09:17:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|BL3PR12MB6404:EE_
x-ms-office365-filtering-correlation-id: cfa41441-0876-4d38-cdff-08dd6ab4c1e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0yYm7yycl8Vx1tn2i1Q2VfH7KLwHWdfJLq0pwu0yCBS1+cSuE6M9uEEFVWX9?=
 =?us-ascii?Q?mCDnwDMQZQx3TPjOP3eZJ+7eTv4WgkKMpvChWJG7dX5SDrTCdfeYRcS7+D0C?=
 =?us-ascii?Q?BFbGaP0t9TueZT4dzWRUSogwt88ohoEsPPVK1qQbLaaSpk1htqk5W5xRSNJv?=
 =?us-ascii?Q?9hQvFlz5Vr2sjY3jj5KGPULzn2OVEp3+Hsep5WmrZa0NvDYH04R576h3EEbX?=
 =?us-ascii?Q?867v2jcHyHp91AWEznEne4j97OePSGO8TiWi9MzHD6PXqLA7aatm2NNaww/1?=
 =?us-ascii?Q?guUlZD5ZqAh0Le1fo+98IA7hDtTxJwkaarE1mv2YO4xM40FOk5qsTbuo+W6o?=
 =?us-ascii?Q?Vl9RL1RSCMYnFe5QFI2NcOYAVeRFuOLdzbMp0ZPno86KJaNMa1IyOtKiETL/?=
 =?us-ascii?Q?DN150gc310ATtn26UhBECpHuN/FZlFXnvyt7+CFiIgTjhS1brekHB0TNhVXv?=
 =?us-ascii?Q?DiiH4t8IyFe2lPBjFomXXNOgYsEsLhijRQb4d1pKLohdBJzYmmLYY/KOaxiV?=
 =?us-ascii?Q?QScQ2XTy+9sD+tjpcimakWmIWlxV9DjK6McD1u9a37o4xjE58P4zxLwie9O7?=
 =?us-ascii?Q?krNx5PfajTjylLBNQC6uqnxUx0AHa902KPNZirW02MTZ75OqiirBGzd9a2R9?=
 =?us-ascii?Q?+Yd0f3BdUzWwdC82OTzrBdkWBA2Bglcbbp3TcsnYRYPCHm4MnMg8vxx7N1Jl?=
 =?us-ascii?Q?0oxNPqX5YbDeaqk/BG3+aYzhxd2z5O0VZKPanLppUaVvB35J4XE9NDhVHomC?=
 =?us-ascii?Q?zwdA4hmN1S5q8xUmnLxA89p/2fnsGFUAWZyG+s/nFReXZby+pEGF4jnWTPzo?=
 =?us-ascii?Q?+LM7hUyeEq2g925VKaiQ0rerqKLlvuvcD5peXEmhmVJK3UIrtdcvIMCzkX59?=
 =?us-ascii?Q?1p2pmV5QtBs9vzolX0fUutJSktukBmsl+pZEYSVeu/Wvwh1UPCJVWNdq2I1q?=
 =?us-ascii?Q?nCINjj5jAXLNjHzM90I0oAtu2dLCBnWyoWRU8jJsNUjmuoz2opCcpXY3xZpD?=
 =?us-ascii?Q?zTWxcxfKbRND+Bg73Jf0J8On4tKBLmKVc/1THCTZdeocYM5ABIkkC/jaNwWu?=
 =?us-ascii?Q?659p8sX3xNFiggjCdQxzx0AS/Sm2HXpluXFQsrmGxzzoU80UxEpMDuE7qsCi?=
 =?us-ascii?Q?vv4ZJo3YKicZF4boiuPqaZ4MvKyt4gKN5MtbBLsSFNCMM2quZAODP4g8Qdcu?=
 =?us-ascii?Q?/JBrV1hfyObxa7Yq8gTh3lja7Qbo5D0vtVksv/U+UX25RilGWN8Ou8sYSWm4?=
 =?us-ascii?Q?z749Y5g9xqzh2wKFpTZT2yVZTUgiU58fCM+hihDuI/PalkKETRYnx0eHW8oe?=
 =?us-ascii?Q?VKc4rWOeBRNQq0mUgTeKnjcySRhKaEaq5HGevOUdD5cZaMn+kVdmH6zZl6c2?=
 =?us-ascii?Q?9Ka1LlopXiOI582E9mt5zowxYhNWoqGQqyaPQkZTvD1uROEWFExI97I0NO+k?=
 =?us-ascii?Q?0uUsCghr5ZAPUx12PpDvaYM3o6bGELXD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DPP7BpP68vtyjLzuP4eSbSmwaGAfZ+Gmwnk6OpPwUPAxRjgI9W+rlmcV/w7K?=
 =?us-ascii?Q?HoUmOGqw20E0C2P852CaSkjrdBhXMH+cCQyJnuWNE/PgCZmWv1Z051urgh0v?=
 =?us-ascii?Q?TqOpxkb5iYUjguj0Bq79QZfAKD0zq72+ELv2oJlbHo/Zfu4RzmJTo9pQ+r1q?=
 =?us-ascii?Q?ns3kIYrT29NXujqnrYgbvE2ep//91nPH+fvMgwDRkePq9fKz2g7G+VzkIBIP?=
 =?us-ascii?Q?aWAAyagTvO+19Bv9FrAxTYYk8g50widDav6rpbUS0l5ocMk+c9QTDpttQNgH?=
 =?us-ascii?Q?UhklOU986665LE95Kq9Rljru4ATHYoRUyzmN3H+M7FW6Jvp0yQXyW/55Mg+A?=
 =?us-ascii?Q?16pmhndbd9EYOzrdIH38hdlNYCg/CB5qn9eU9uuyHve/ygjZn9BgfxGZc7rb?=
 =?us-ascii?Q?rsbz94gFXaVBF+UlXTAzQqEgjPKPEU0Cko9xZz73xTj1MPVSMRnhbLc4EwSG?=
 =?us-ascii?Q?PR0P8bVPZlNIjVTidaG7cvO1K1Rzaic5QL6lR8sZkl8ZYGIjQ7WuHOwo5q+U?=
 =?us-ascii?Q?r204PxcgAFaEM1ggSQrlaUjeokZVWxg7VnShmZzQ8oodkuFDKlyom5QXhoev?=
 =?us-ascii?Q?3E7u46y1/WtROi6JhISQtIcHIIAnbgu+Vw2d1V7tQhdOjp4PcE2TyzHJ85Go?=
 =?us-ascii?Q?IhC/+2tUZcCcckc1HoFYtiZP2xweH8Xj966Hfix/jYCI4E3vLfWV/RGud+sb?=
 =?us-ascii?Q?CVM11gRoaKiutvX9ZngRU7xDx3Jy4iwQMn7hUrrawevchQxJ3KqLRpZZKTj/?=
 =?us-ascii?Q?n/9fe08xfqeeC4sJcqRdkLe7F/PtvCHDGNCyVxln8i6Wqi4PxEnkIgpDLUx4?=
 =?us-ascii?Q?APF4WQ6BKRbcB49vgmonK+MtZLRLbTnTdFFxu//7jftQRG7NpuK+7I53H73d?=
 =?us-ascii?Q?qrGfygor+TsNb6/D0bhgJpwZogw67FbvjTKBj34jozcN6ipmNXe2hPy4SQx/?=
 =?us-ascii?Q?LQ0cWR/ss0NoqocPvBJ0G5yUFs2t1efST6B1qKKNPP2voe7sdvCprdgNqNOA?=
 =?us-ascii?Q?3TDA/lSpbjIIav/7Jjj+KUjXsRUchtR4/OPklzmFpD9uErNAHH4ONJCIM7mf?=
 =?us-ascii?Q?K0eiK8+unDZyWW3Ei/fNkWqHpiezTkLXxhVgMe1J6H3EyOn2qeZhZDQcFsod?=
 =?us-ascii?Q?BdAZUoKZ1K49ZL77UhYNzZsGIZZWsIWANS4w0jWi8fJfuhUoCRWWnDq5/+Dr?=
 =?us-ascii?Q?2AKmt7iwKY/UjOHmLYtw8BS6/tPYVvDhtc7FgmP5xifgfx/eSbSRmoCPAINr?=
 =?us-ascii?Q?JfHgSoRJlQSZwoJhTfDNzDVxxYW5tBktJSJWJN6qFYLNkVkG+DR5dZaZs/um?=
 =?us-ascii?Q?n2TkELcHTU+sf+uGkvQl6gJn7w63BKKmCeG3sUcP3JeavBIuyooIFLt2VmXT?=
 =?us-ascii?Q?BgyE2ytmKb8+93zP8/4qOZPjczGanAsmwN0Rfio9WHfwoL9U1sZlRScgAt9u?=
 =?us-ascii?Q?i7v9ap0D2dJzs5+cJH8Qn+DVWO+3a55LChIvrHfq41SV2kfXYlKZp1YPkK+D?=
 =?us-ascii?Q?2vQ5Hdx4IRQF2vGaPBIkLg+M4Bswm5Clyso1W5gb+38XTbn0TA5SxxRFHubx?=
 =?us-ascii?Q?37aC6kmkvjrRRlC2A6o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa41441-0876-4d38-cdff-08dd6ab4c1e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 09:17:53.6066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m7bUD3pObDUSd6C+XGrf0K67e6QAjl8S0s7P2H74Na6Suk80igs99Z7l2z1mTwwHLZBqsQJBoBsWukWRPrz0GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Monday, March 24, 2025 1:29 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add NPS2 to DPX compatible mode

Compute partition DPX is possible in NPS2 mode. Update the compatible modes=
 for DPX.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/a=
md/amdgpu/aqua_vanjaram.c
index 3c07517be09a..ae071985f26e 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -473,7 +473,8 @@ static int aqua_vanjaram_get_xcp_res_info(struct amdgpu=
_xcp_mgr *xcp_mgr,
                break;
        case AMDGPU_DPX_PARTITION_MODE:
                num_xcp =3D 2;
-               nps_modes =3D BIT(AMDGPU_NPS1_PARTITION_MODE);
+               nps_modes =3D BIT(AMDGPU_NPS1_PARTITION_MODE) |
+                           BIT(AMDGPU_NPS2_PARTITION_MODE);
                break;
        case AMDGPU_TPX_PARTITION_MODE:
                num_xcp =3D 3;
--
2.25.1

